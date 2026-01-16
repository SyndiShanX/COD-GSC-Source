/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_intersection.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\_turret;
#include maps\_vehicle;
#include maps\la_utility;
#include maps\_music;
#include animscripts\shared;

autoexec init() {
  add_flag_function("looking_down_the_street", ::fa38_landing);
  add_trigger_function("intersection_backtrack_fail", ::intersection_backtrack_fail);
  add_spawn_function_ai_group("g20_attackers", ::spawn_func_g20_attackers);
  add_spawn_function_veh("intersection_last_truck", ::intersection_last_truck);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret_light", ::manage_vehicles_low_road);
  a_dest = getentarray("destructible", "targetname");

  foreach(dest in a_dest) {
    if(!isDefined(dest.script_string) && !isDefined("explosion_car1") || isDefined(dest.script_string) && isDefined("explosion_car1") && dest.script_string == "explosion_car1")
      level.explosion_car1 = dest;
  }
}

skipto_intersection() {
  init_hero("harper");
  skipto_teleport("skipto_intersection");
  level thread intersection_vo();
  level thread spawn_ambient_drones(undefined, undefined, "avenger_street_flyby_4", "f38_street_flyby_4", "start_street_flyby_4", 1, 1, 8, 10, 500, 0, 1);
}

main() {
  level thread vip_cougar();
  battlechatter_on("allies");
  battlechatter_on("axis");
  init_hero("harper");
  level thread intersection_deathposes();
  run_scene_first_frame("intersection_bodies");
  level thread simple_spawn("intersection_ss", ::spawn_func_intersection_ss);
  init_vehicles();
  level thread spawn_right_truck();
  flag_wait("intersection_started");
  spawn_manager_enable("t_intersection_spawn_manager");
  level thread vo_lapd_intersection();
  level thread sam_cougar();
  exploder(500);
  exploder(10780);
  level notify("fxanim_skyscraper02_impact_start");
  level thread autosave_by_name("intersection_start");
  level thread line_manager();
  set_aerial_vehicles();
  level thread drop_building1();
  building_collapse();

  if(!flag("intersect_vip_cougar_died"))
    flag_set("intersect_vip_cougar_saved");

  la_2_transition();
  nextmission();
}

vo_lapd_intersection() {
  add_vo_to_nag_group("lapd_intersection", level.cop_1, "lpd2_move_get_out_of_th_0");
  add_vo_to_nag_group("lapd_intersection", level.cop_2, "lpd3_get_in_cover_retur_0");
  add_vo_to_nag_group("lapd_intersection", level.cop_1, "lpd1_the_city_s_a_fucking_0");
  level thread start_vo_nag_group_flag("lapd_intersection", "ok_to_drop_building", randomfloatrange(3.0, 6.0));
}

intersection_deathposes() {
  run_scene_first_frame("intersectbody_02");
  run_scene_first_frame("intersectbody_09");
  run_scene_first_frame("intersectbody_12");
  run_scene_first_frame("intersectbody_13");
  run_scene_first_frame("intersectbody_17");
  run_scene_first_frame("intersectbody_25");
}

intersection_vo() {
  level endon("building_collapsing");
  flag_wait_any("plaza_vo_done", "player_reached_intersection");
  level thread collapse_vo();
  level thread intersection_vo_pmc_callouts();

  if(!flag("harper_dead"))
    level.harper thread priority_dialog("harp_we_re_too_late_sect_0", 2, "intersect_vip_cougar_died", "intersect_vip_cougar_saved");
  else
    level.player thread priority_dialog("sect_dammit_into_radi_0", 2, "intersect_vip_cougar_died", "intersect_vip_cougar_saved");

  if(!flag("harper_dead")) {
    if(!flag("building_collapsing"))
      level.harper thread queue_dialog("harp_they_have_another_gu_0", 0, "intersection_truck_right", "right_truck_dead");

    if(!flag("building_collapsing"))
      level.harper thread queue_dialog("harp_take_it_down_0", 1, "intersection_truck_right", "right_truck_dead");
  } else
    queue_dialog_ally("lpd1_we_need_back_up_0", 1, undefined, "building_collapsing");

  flag_wait("do_anderson_landing_vo");
  level.player priority_dialog("ande_section_i_took_a_0", 2);
  level.player priority_dialog("im_going_to_have_009", 1.5);
  level.player priority_dialog("were_on_our_way_012", 0.5);
  level.player priority_dialog("im_bleeding_out_015", 1.5);
  flag_set("ok_to_drop_building1");

  if(!flag("harper_dead")) {
    level.harper queue_dialog("harp_dammit_section_they_0", 0, undefined, "building_collapsing");
    level.harper queue_dialog("harp_we_need_to_secure_th_0", 1, undefined, "building_collapsing");
  } else {
    queue_dialog_enemy("pmc1_they_won_t_fire_on_t_0", 0, undefined, "building_collapsing");
    queue_dialog_enemy("pmc3_get_to_the_downed_pl_0", 1, undefined, "building_collapsing");
  }

  wait 2;
  flag_set("ok_to_drop_building");
}

collapse_vo() {
  flag_wait("building_collapsing");

  if(!flag("harper_dead")) {
    level.harper priority_dialog("harp_awww_shit_the_who_0", 2);
    level.harper priority_dialog("everybody_down_001", 2);
  }
}

intersection_vo_pmc_callouts() {
  a_intro_vo = array("pmc1_here_they_come_1", "pmc3_open_fire_0");
  vo_callouts_intro(undefined, "axis", a_intro_vo);
  a_vo_callouts = [];
  a_vo_callouts["generic"] = array("pmc0_don_t_let_them_move_0", "pmc0_get_the_hell_away_0", "pmc0_hit_and_move_hit_a_0", "pmc0_keep_shooting_you_f_0", "pmc1_i_m_hit_0", "pmc1_bastards_0", "pmc1_we_re_losing_men_0", "pmc1_keep_firing_0", "pmc1_dammit_weapon_s_ja_0", "pmc2_keep_them_back_0", "pmc2_get_me_a_clip_0", "pmc2_i_need_ammo_0", "pmc2_we_need_more_men_dow_0", "pmc2_hold_the_blockade_0", "pmc3_hit_em_now_0", "pmc3_stay_on_them_0", "pmc3_i_got_him_0", "pmc3_fuck_man_they_shot_0", "pmc3_i_m_out_0", "pmc3_keep_it_together_0", "pmc3_keep_your_heads_down_0");
  level thread vo_callouts(undefined, "axis", a_vo_callouts, "building_collapsing");
}

intersection_backtrack_fail() {
  missionfailedwrapper(&"GAME_MISSIONFAILED");
}

init_vehicles() {
  a_vehicles = getvehiclearray();
  a_destructibles = getentarray("destructible", "targetname");
  a_vehicles = arraycombine(a_vehicles, a_destructibles, 1, 0);

  foreach(veh in a_vehicles) {
    if(!isDefined(veh.script_noteworthy) && !isDefined("veh_explosion") || isDefined(veh.script_noteworthy) && isDefined("veh_explosion") && veh.script_noteworthy == "veh_explosion")
      veh thread launch_car_on_deah();
  }
}

spawn_right_truck() {
  flag_wait_any("intersect_vip_cougar_died", "intersect_vip_cougar_saved");
  flag_wait("looking_down_the_street");

  if(!flag("right_truck_spawned"))
    trigger_use("right_truck_trigger");
}

launch_car_on_deah() {
  self waittill("death");
  self thread vehicle_explosion_launch(self.origin);
}

set_aerial_vehicles() {
  a_av_allies_spawner_targetnames = array("f35_fast");
  a_av_axis_spawner_targetnames = array("avenger_fast", "pegasus_fast");
}

line_manager() {
  flag_wait("player_reached_intersection");
  a_volumes = getentarray("goal_volume_intersection", "targetname");
  a_volumes = sort_by_script_int(a_volumes, 1);
  add_spawn_function_group("sp_intersection1", "targetname", ::spawn_func_intersection_fallback_ai);

  foreach(volume in a_volumes) {
    level.current_intersection_goal_volume = volume;
    level notify("intersection_goal_volume_update");

    if(isDefined(volume.target))
      trigger_use(volume.target);

    level.intersection_kill_count = 0;
    wait 1;
    waittill_fallback(volume);
  }
}

waittill_fallback(volume) {
  level endon("intersection_kill_update");
  level.player waittill_player_touches(volume);
}

spawn_func_intersection_fallback_ai() {
  while(isalive(self)) {
    self setgoalvolumeauto(level.current_intersection_goal_volume);
    waittill_any_ents(level, "intersection_goal_volume_update", self, "death");
  }

  level.intersection_kill_count++;

  if(level.intersection_kill_count > 8)
    level notify("intersection_kill_update");
}

#using_animtree("vehicles");

vip_cougar() {
  level.vh_vip_cougar = spawn_vehicle_from_targetname("vip_cougar");
  level.vh_vip_cougar.overridevehicledamage = ::cougar_damage_override;
  level.vh_vip_cougar.death_anim = % v_la_03_11_g20failure_cougar;
  level.vh_vip_cougar thread save_vip();
  level.vh_vip_cougar.health = 5000;
  level.vh_vip_cougar waittill("death");
  n_cougar_origin = level.vh_vip_cougar.origin;
  level.vh_vip_cougar radiusdamage(n_cougar_origin, 512, 512, 512, undefined, "MOD_EXPLOSIVE");
  flag_set("intersect_vip_cougar_died");
}

cougar_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  if(str_means_of_death == "MOD_PROJECTILE")
    n_damage = 1000;
  else
    n_damage = 0;

  return n_damage;
}

save_vip() {
  level thread run_scene_and_delete("ssathanks_ssa_idle");
  self.takedamage = 0;
  flag_wait("player_reached_intersection");
  self.takedamage = 1;
  level notify("fxanim_spire_collapse_start");
  set_objective(level.obj_g20_street, self gettagorigin("tag_player") + vectorscale((0, 0, 1), 100.0), "", undefined, 1, 60);
  flag_wait_either("intersect_vip_cougar_died", "g20_attackers_cleared");
  wait 2;

  if(!flag("intersect_vip_cougar_died")) {
    set_objective(level.obj_g20_street, undefined, "done");
    set_objective(level.obj_g20_street, undefined, "delete");
    flag_set("intersect_vip_cougar_saved");
    self.takedamage = 0;
    level thread run_scene_and_delete("ssathanks_harper");
    level.harper waittill("goal");
    delete_scene("ssathanks_ssa_idle");
    run_scene_and_delete("ssathanks_ssa");
  } else {
    level.player thread queue_dialog("sect_dammit_into_radi_0");
    set_objective(level.obj_g20_street, undefined, "failed");
    set_objective(level.obj_g20_street, undefined, "delete");
  }

  autosave_by_name("save_vip_done");
  trigger_use("color_move_after_vip_event");
}

save_vip_vo() {
  level.player queue_dialog("you_got_here_just_006", 0);
  level.player queue_dialog("you_fight_throu_007", 1);
}

spawn_func_intersection_ss() {
  self endon("death");
  self magic_bullet_shield();
  self thread intersection_ss_turn_off_mbs_when_player_gets_there();
  level.vh_vip_cougar waittill("death");
  self intersection_ss_kill();
  trigger_use("color_move_after_vip_event");
}

intersection_ss_turn_off_mbs_when_player_gets_there() {
  self endon("death");
  flag_wait("player_reached_intersection");
  intersection_ss_turn_off_mbs();
}

intersection_ss_kill() {
  if(!(!isDefined(self.script_string) && !isDefined("intersection_ss_hero") || isDefined(self.script_string) && isDefined("intersection_ss_hero") && self.script_string == "intersection_ss_hero"))
    self ragdoll_death();
}

intersection_ss_turn_off_mbs() {
  if(!(!isDefined(self.script_string) && !isDefined("intersection_ss_hero") || isDefined(self.script_string) && isDefined("intersection_ss_hero") && self.script_string == "intersection_ss_hero"))
    self stop_magic_bullet_shield();
}

spawn_func_g20_attackers() {
  self endon("death");
  self waittill("goal");
  shoot_at_target_untill_dead(level.vh_vip_cougar, undefined, 2);
}

sam_cougar() {
  vh_sam = spawn_vehicle_from_targetname("sam_cougar");
  vh_sam.takedamage = 0;
  level endon("stop_sam_cougar");
  vh_sam = getent("sam_cougar", "targetname");
  vh_sam set_turret_ignore_line_of_sight(1, 2);
  e_target = spawn_model("tag_origin");

  while(true) {
    e_target.origin = vh_sam.origin + vectorscale((0, 0, 1), 5000.0) + vectornormalize(anglestoforward(vh_sam.angles)) * 7000 + random_vector(2000);
    vh_sam set_turret_target(e_target, (0, 0, 0), 2);
    vh_sam fire_turret_for_time(2, 2);
    wait 6;
  }
}

fa38_landing(trig, e_who) {
  vh_fa38 = spawn_vehicle_from_targetname("f35_vtol");
  vh_fa38 hidepart("tag_landing_gear_doors");
  vh_fa38 attach("veh_t6_air_fa38_landing_gear", "tag_landing_gear_down");
  vh_fa38 thread fa38_stop_snd();
  level thread run_scene("fa38_landing");
  wait 6;
  flag_set("do_anderson_landing_vo");
}

fa38_stop_snd() {
  wait 18;
  self vehicle_toggle_sounds(0);
}

intersection_last_truck() {
  self waittill("kill_car");

  if(level.explosion_car1.health > 0)
    self shoot_turret_at_target(level.explosion_car1, -1, undefined, 1);

  self enable_turret(1);
}

drop_building1() {
  flag_wait_array(array("ok_to_drop_building1", "looking_down_the_street"));
  playsoundatposition("evt_small_bldg_collapse", (9602, 2746, 293));
  earthquake(0.2, 1, level.player.origin, 20000);
  level notify("fxanim_bldg_convoy_block_start");
}

building_collapse() {
  flag_wait_array(array("ok_to_drop_building", "looking_down_the_street"));
  battlechatter_off("allies");
  battlechatter_off("axis");
  level thread harper_knocked_down();
  level.player thread player_knocked_down();
  level.player playsound("evt_bldg_collapse_end");
  setmusicstate("LA_1B_BUILDING_COLLAPSE");
  level.player magic_bullet_shield();
  level notify("stop_sam_cougar");
  level notify("fxanim_skyscraper02_start");
  flag_set("building_collapsing");
  earthquake(0.3, 12, level.player.origin, 20000);
  level.player playrumbleonentity("la_1b_building_collapse");
  delay_thread(3, ::set_player_invulnerable);
  wait 12;
  level clientnotify("fade_out");
  level.player hide_hud();
  screen_fade_out(5);
  stopallrumbles();
}

harper_knocked_down() {
  if(!flag("harper_dead"))
    level.harper animcustom(::harper_get_knocked_down);
}

#using_animtree("generic_human");

harper_get_knocked_down() {
  wait 7.5;
  self setflaggedanimknoballrestart("knockedDown", % ai_stand_exposed_extendedpain_b, % body, 1, 0.1, 0.7);
  self animscripts\shared::donotetracks("knockedDown");
}

player_knocked_down() {
  e_temp = spawn("script_origin", self.origin);
  e_temp.angles = self getplayerangles();
  wait 8.5;

  e_temp moveto(e_temp.origin + vectorscale((0, -1, 0), 150.0), 2, 0.2, 1.5);
  self setstance("prone");
  self allowstand(0);
  self allowsprint(0);
  self allowjump(0);
  self allowads(0);
  self setplayerviewratescale(30);
  self hide_hud();
  self take_weapons();

  self shellshock("explosion", 20);
  self playrumbleonentity("damage_heavy");
  level thread run_scene("building_collapse_player");
}

set_player_invulnerable() {
  level.player enableinvulnerability();
}

la_2_transition() {
  e_align = getent("f35_vtol", "targetname");
  str_local_player_coordinates = level.player get_relative_position_string(e_align);
  setdvar("la_2_player_start_pos", str_local_player_coordinates);
  setdvar("la_1_ending_position", 1);
  b_saved_anderson = 0;

  if(flag("anderson_saved"))
    b_saved_anderson = 1;

  setdvar("la_F35_pilot_saved", b_saved_anderson);
  b_g20_saved_2nd = 0;

  if(!flag("intersect_vip_cougar_died"))
    b_g20_saved_2nd = 1;

  setdvar("la_G20_2_saved", b_g20_saved_2nd);
}

f35_land_fx(m_f35) {
  m_f35 play_fx("f35_exhaust_hover_front", undefined, undefined, "stop_fx", 1, "tag_fx_nozzle_left");
  m_f35 play_fx("f35_exhaust_hover_front", undefined, undefined, "stop_fx", 1, "tag_fx_nozzle_right");
  m_f35 play_fx("f35_exhaust_hover_rear", undefined, undefined, "stop_fx", 1, "tag_fx_nozzle_left_rear");
  m_f35 play_fx("f35_exhaust_hover_rear", undefined, undefined, "stop_fx", 1, "tag_fx_nozzle_right_rear");
  scene_wait("fa38_landing");
  m_f35 notify("stop_fx");
}