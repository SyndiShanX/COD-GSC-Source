/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_plaza.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\_turret;
#include maps\_vehicle;
#include maps\_music;
#include maps\la_utility;
#include maps\la_street;
#include maps\la_intersection;
#include maps\_glasses;
#include maps\_fire_direction;
#include maps\_vehicle_death;

autoexec init_plaza() {
  add_spawn_function_veh("van_1", ::brake_van);
  add_spawn_function_group("plaza_grate_01", "targetname", ::plaza_grate_01);
  add_spawn_function_group("plaza_grate_02", "targetname", ::plaza_grate_02);
  add_spawn_function_group("plaza_balcony_rpg0", "script_noteworthy", ::init_balcony_ai);
  add_spawn_function_group("plaza_balcony_sniper0", "script_noteworthy", ::init_balcony_ai);
  add_spawn_function_group("plaza_gunner", "targetname", ::plaza_gunner);
  a_prop = getent("plaza_cart_1", "targetname");
  a_prop_links = getentarray("plaza_cart_1_link", "targetname");
  level thread cart_1_watcher();

  foreach(m_prop_link in a_prop_links)
  m_prop_link linkto(a_prop);

  a_prop = getent("plaza_cart_2", "targetname");
  a_prop_links = getentarray("plaza_cart_2_link", "targetname");
  level thread cart_2_watcher();

  foreach(m_prop_link in a_prop_links)
  m_prop_link linkto(a_prop);
}

cart_1_watcher() {
  scene_trigger = getent("spawn_shopguy01", "targetname");
  scene_trigger waittill("trigger");
  path_clip = getent("cart_clip_1", "script_noteworthy");
  path_clip connectpaths();
  scene_wait("plaza_shopguy01");
  path_clip disconnectpaths();
}

cart_2_watcher() {
  scene_trigger = getent("spawn_shopguy02", "targetname");
  scene_trigger waittill("trigger");
  path_clip = getent("cart_clip_2", "script_noteworthy");
  path_clip connectpaths();
  scene_wait("plaza_shopguy02");
  path_clip disconnectpaths();
}

plaza_planter() {
  a_prop = getent("plaza_stairs_planter", "targetname");
  m_prop_link = getent("plaza_stairs_planter_collision", "targetname");
  m_prop_link linkto(a_prop);
  flag_wait("plaza_planter_started");
  m_prop_link connectpaths();
  flag_wait("plaza_planter_done");
  m_prop_link disconnectpaths();
}

plaza_grate_01() {
  self endon("death");
  self.deathfunction = ::ragdoll_death;
  scene_wait("plaza_grate1");
  level thread run_scene_and_delete("plaza_grate1_loop");
}

plaza_grate_02() {
  self endon("death");
  self.deathfunction = ::ragdoll_death;
  scene_wait("plaza_grate2");
  level thread run_scene_and_delete("plaza_grate2_loop");
}

init_balcony_ai() {
  self.a.disablereacquire = 1;
}

plaza_gunner() {
  flag_set("plaza_gunner_spawned");
  self waittill("death");
  flag_set("plaza_gunner_dead");

  if(!flag("harper_dead"))
    level.harper queue_dialog("harp_mg_s_down_move_up_0");

  queue_dialog_enemy("pmc3_we_ve_lost_the_mg_0");
}

skipto_plaza() {
  level.harper = init_hero("harper");
  level.harper.plaza_right = 0;
  skipto_teleport("skipto_plaza");
  exploder(56);
  exploder(57);
  exploder(58);
  exploder(59);
  level thread maps\la_street::brute_force();
  trigger_use("plaza_color_start");
  set_objective(level.obj_street_regroup);
  level.player.overrideplayerdamage = ::drone_player_damage_override;
  level thread spawn_ambient_drones(undefined, undefined, "avenger_street_flyby_4", "f38_street_flyby_4", "start_street_flyby_4", 1, 1, 8, 10, 500, 0, 1);
}

main() {
  flag_set("la_arena_start");

  if(!flag("harper_dead")) {
    level.harper = init_hero("harper");
    level.harper.script_ignore_suppression = 1;
    level.harper.plaza_right = 0;
  }

  getent("lockbreaker_left_door", "targetname") ignorecheapentityflag(1);
  getent("lockbreaker_right_door", "targetname") ignorecheapentityflag(1);
  level thread setup_street_cops_for_plaza();
  a_av_allies_spawner_targetnames = array("f35_fast");
  a_av_axis_spawner_targetnames = array("avenger_fast", "pegasus_fast");
  level.player.overrideplayerdamage = ::drone_player_damage_override;
  level thread plaza_deathposes();
  run_scene_first_frame("plaza_bodies");
  run_scene_first_frame("plaza_shopguy01", 1, 1);
  run_scene_first_frame("plaza_shopguy02", 1, 1);
  trigger_on("plaza_building_fxanim");
  level thread plaza_shop_ai_anims();
  level thread table_flips();
  level thread clear_behind();
  level thread plaza_harper_movement();
  level thread plaza_right_color_logic();
  level thread lockbreaker();
  level thread brute_force();
  level thread plaza_vo();
  level thread plaza_and_intersect_transition();
  level thread maps\la_intersection::intersection_vo();
  level thread vo_lapd_plaza();
  wait 0.05;
  path_clip1 = getent("cart_clip_1", "script_noteworthy");
  path_clip1 disconnectpaths();
  path_clip2 = getent("cart_clip_2", "script_noteworthy");
  path_clip2 disconnectpaths();
  f35_crash();
  simple_spawn_single("plaza_right_rpg");
}

vo_lapd_plaza() {
  add_vo_to_nag_group("lapd_plaza", level.cop_1, "lpd3_don_t_let_them_get_b_0");
  add_vo_to_nag_group("lapd_plaza", level.cop_2, "lpd1_get_in_cover_retur_0");
  add_vo_to_nag_group("lapd_plaza", level.cop_1, "lpd2_get_out_of_here_0");
  add_vo_to_nag_group("lapd_plaza", level.cop_2, "lpd3_guy_at_the_corner_0");
  add_vo_to_nag_group("lapd_plaza", level.cop_1, "lpd3_i_m_burning_ammo_he_0");
  add_vo_to_nag_group("lapd_plaza", level.cop_2, "lpd3_i_m_hit_i_m_hit_0");
  add_vo_to_nag_group("lapd_plaza", level.cop_1, "lpd3_watch_your_fire_age_0");
  add_vo_to_nag_group("lapd_plaza", level.cop_2, "lpd1_they_re_trying_to_fl_0");
  add_vo_to_nag_group("lapd_plaza", level.cop_1, "lpd1_officers_down_0");
  add_vo_to_nag_group("lapd_plaza", level.cop_2, "put_em_down_034");
  level thread start_vo_nag_group_flag("lapd_plaza", "ok_to_drop_building", randomfloatrange(3.0, 6.0));
}

setup_street_cops_for_plaza() {
  flag_wait("bdog_back_dead");

  if(isDefined(level.cop_1)) {
    level.cop_1 set_force_color("c");
    level.cop_2 set_force_color("c");
  }
}

plaza_deathposes() {
  run_scene_first_frame("plazabody_02");
  run_scene_first_frame("plazabody_03");
  run_scene_first_frame("plazabody_04");
  run_scene_first_frame("plazabody_08");
  run_scene_first_frame("plazabody_10");
  run_scene_first_frame("plazabody_11");
  run_scene_first_frame("plazabody_13");
  run_scene_first_frame("plazabody_16");
}

cleanup_color_plaza_right_2_inside() {
  level endon("intersection_started");
  trigger_wait("color_plaza_right_2_outside");
  cleanup_kvp("color_plaza_right_2_inside");
}

cleanup_color_plaza_right_2_outside() {
  level endon("intersection_started");
  trigger_wait("color_plaza_right_2_inside");
  cleanup_kvp("color_plaza_right_2_outside");
}

plaza_vo() {
  level thread plaza_vo_pmc_callouts();
  level endon("player_reached_intersection");
  level.player queue_dialog("ande_section_the_mercs_0");
  do_pip2();

  if(flag("player_has_bruteforce") && !flag("brute_force_player_started"))
    level.player queue_dialog("our_iav_is_on_fire_003", 0, "near_bruteforce_cougar", "plaza_enter");

  flag_wait("plaza_enter");
  queue_dialog_enemy("pmc3_here_they_come_0");
  flag_wait("plaza_gunner_spawned");
  queue_dialog_enemy("pmc2_get_on_the_mg_0");
  queue_dialog_enemy("pmc3_open_fire_0");

  if(!flag("harper_dead")) {
    level.harper queue_dialog("harp_mg_s_got_the_entranc_0", 0, "plaza_gunner_spawned", "plaza_gunner_dead");
    level.harper queue_dialog("harp_those_fucking_cops_a_0", 0, undefined, array("plaza_gunner_dead", "plaza_left_path", "plaza_right_path"));
    level.harper queue_dialog("harp_find_another_way_rou_0", 0, "plaza_gunner_spawned", array("plaza_gunner_dead", "plaza_left_path", "plaza_right_path"));
  }

  level.player queue_dialog("sect_spread_out_open_up_0", 1, undefined, "f35_la_plaza_crash_end");
  level.player queue_dialog("sect_stay_on_line_0", 0, undefined, "f35_la_plaza_crash_end");
  queue_dialog_enemy("pmc3_get_the_rpgs_onto_th_0", 0, undefined, "f35_la_plaza_crash_end");
  level thread queue_dialog_enemy("pmc3_they_re_heading_into_0", 0, "plaza_right_path");
  level thread left_path_vo();
  level thread middle_path_vo();
  level thread right_path_vo();
  level thread monitor_planter_scene();
  flag_wait("do_plaza_anderson_convo");
  level.player queue_dialog("sect_anderson_the_frenc_0");
  level.player queue_dialog("ande_enemy_forces_are_tar_0");
  level.player queue_dialog("sect_that_s_them_hold_t_0");
  queue_dialog_enemy("pmc3_come_on_keep_push_0", 0, "f35_la_plaza_crash_start", "f35_la_plaza_crash_end");
  queue_dialog_enemy("pmc2_focus_rpg_fire_on_th_0", 0, undefined, "f35_la_plaza_crash_start");
  queue_dialog_enemy("pmc1_bring_them_down_0", 0, undefined, "f35_la_plaza_crash_start");
  flag_wait("f35_la_plaza_crash_start");
  queue_dialog_enemy("pmc1_direct_hit_it_s_co_0", 0, "f35_la_plaza_crash_start", "f35_la_plaza_crash_end");
  flag_wait("f35_la_plaza_crash_end");
  level thread autosave_by_name("f35_plaza_crash");
  level notify("continue_path");
  queue_dialog_enemy("pmc3_come_on_keep_push_0");
  queue_dialog_enemy("pmc3_get_on_them_0");
  level.player queue_dialog("ande_dammit_section_the_1");
  level.player queue_dialog("ande_i_can_t_hold_them_of_0");
  level.player queue_dialog("ande_they_re_dead_if_you_0");
  flag_set("plaza_vo_done");
}

monitor_planter_scene() {
  flag_wait("plaza_left_path");
  flag_wait("plaza_planter_started");
  flag_init("planter_roll");
  level thread monitor_planter();
  ai_guy = get_ais_from_scene("plaza_planter", "plaza_planter_01");
  e_planter = get_model_or_models_from_scene("plaza_planter", "plaza_stairs_planter");

  if(isDefined(ai_guy)) {
    ai_guy waittill("death");

    if(!flag("plaza_planter_done") && !flag("planter_roll"))
      end_scene("plaza_planter");
  }
}

monitor_planter() {
  level endon("plaza_planter_done");
  wait 4.5;
  flag_set("planter_roll");
}

left_path_vo() {
  level endon("player_reached_intersection");
  flag_wait("plaza_left_path");

  if(!flag("harper_dead")) {
    level.harper queue_dialog("harp_1st_floor_left_side_0", 0, array("plaza_left_path"), "player_reached_escalator");
    level.harper queue_dialog("harp_2nd_floor_by_the_es_0", 0, array("plaza_left_path", "enemies_by_the_escalator"), array("plaza_top_of_stairs_cleared"));
  }

  flag_wait("player_reached_top_of_escalator");
  level.player queue_dialog("ande_i_see_a_sam_turret_o_0", 0, array("plaza_left_path"));
  level.player queue_dialog("sect_i_ll_do_what_i_can_0", 0, array("lockbreaker_started"), "plaza_left_side_middle");
  flag_set("do_plaza_anderson_convo");
  level waittill("continue_path");

  if(!flag("harper_dead")) {
    level.harper queue_dialog("harp_sniper_dead_ahead_0", 0, array("plaza_left_path", "plaza_end_balcony_sniper_spawning"), "plaza_end_balcony_sniper_cleared");
    wait 1;
    level.harper queue_dialog("harp_opposite_balcony_0", 0, array("plaza_left_path", "plaza_end_balcony_rpg_spawning"), "plaza_end_balcony_rpg_cleared");
  }
}

middle_path_vo() {
  level endon("player_reached_intersection");
  level endon("plaza_left_path");
  level endon("plaza_right_path");
  level endon("plaza_middle_right_path");
  flag_wait("f35_la_plaza_crash_start");
  flag_set("do_plaza_anderson_convo");
  level waittill("continue_path");

  if(!flag("harper_dead")) {
    level.harper queue_dialog("harp_rpg_right_side_hig_0", 0, "plaza_end_balcony_rpg_spawning", "plaza_end_balcony_rpg_cleared");
    wait 1;
    level.harper queue_dialog("harp_sniper_2nd_floor_0", 0, "plaza_end_balcony_sniper_spawning", "plaza_end_balcony_sniper_cleared");
  }
}

right_path_vo() {
  level endon("player_reached_intersection");
  flag_wait_either("plaza_right_path", "plaza_middle_right_path");

  if(!flag("harper_dead"))
    level.harper queue_dialog("harp_1st_floor_right_sid_0", 0);

  flag_set("do_plaza_anderson_convo");
  level waittill("continue_path");

  if(!flag("harper_dead")) {
    level.harper queue_dialog("harp_rpg_right_side_hig_0", 0, "plaza_end_balcony_rpg_spawning", "plaza_end_balcony_rpg_cleared");
    wait 1;
    level.harper queue_dialog("harp_sniper_2nd_floor_0", 0, "plaza_end_balcony_sniper_spawning", "plaza_end_balcony_sniper_cleared");
  }
}

plaza_vo_pmc_callouts() {
  a_intro_vo = array("pmc3_they_re_still_fighti_0", "pmc2_get_on_the_mg_0", "pmc3_open_fire_0");
  vo_callouts_intro(undefined, "axis", a_intro_vo);
  a_vo_callouts = [];
  a_vo_callouts["mall_2nd_floor_int"] = array("pmc1_second_floor_mall_0");
  a_vo_callouts["mall_2nd_floor_ext"] = array("pmc0_they_re_on_the_balco_0");
  a_vo_callouts["mall_stairs"] = array("pmc3_targets_on_the_stair_0");
  a_vo_callouts["generic"] = array("pmc3_get_on_them_0", "pmc1_bring_them_down_0", "pmc3_fall_back_to_the_are_0", "pmc1_here_they_come_1", "pmc3_here_they_come_0", "pmc3_open_fire_0");
  level thread vo_callouts(undefined, "axis", a_vo_callouts, "intersection_started", "rooftop_sam_in", 4.0, 10.0);
}

plaza_vo_save_french_iav() {
  level endon("intersect_vip_cougar_saved");
  level endon("intersect_vip_cougar_died");
  a_help_vo = array("were_taking_heavy_008", "theyre_all_over_u_004");
  a_respond_vo = array("on_our_way_004");

  while(true) {
    wait(randomintrange(15, 25));
    level.player queue_dialog(a_help_vo[randomint(a_help_vo.size)]);
  }
}

do_pip2() {
  flag_set("pip_playing");
  thread maps\_glasses::play_bink_on_hud("la_pip_seq_2", 0, 0);
  flag_wait("glasses_bink_playing");
  level.player priority_dialog("samu_we_re_northbound_on_0");
  level.player priority_dialog("pres_if_we_lose_any_more_0");
  level.player priority_dialog("sect_understood_section_0");
  flag_clear("pip_playing");
}

brute_force() {
  level endon("brute_force_fail");
  flag_wait("brute_force_ssa_1_started");
  flag_waitopen("pip_playing");
  ai_ss = get_ais_from_scene("brute_force_ssa_1", "ssa_1_brute_force");
  ai_ss thread brute_force_ai_take_position("brute_force_ssa_1");
  ai_ss priority_dialog("ssa4_thank_god_0");
  level.player priority_dialog("grab_a_rifle_h_we_006");
  ai_ss = get_ais_from_scene("brute_force_ssa_2", "ssa_2_brute_force");
  ai_ss thread brute_force_ai_take_position("brute_force_ssa_2");
  ai_ss = get_ais_from_scene("brute_force_ssa_3", "ssa_3_brute_force");
  ai_ss thread brute_force_ai_take_position("brute_force_ssa_3");
}

brute_force_ai_take_position(scene_and_node_targetname) {
  self endon("death");
  node = getnode(scene_and_node_targetname, "targetname");
  scene_wait(scene_and_node_targetname);
  self setgoalnode(node);
}

table_flips() {
  run_scene_first_frame("plaza_table_flip_01", 1);
  run_scene_first_frame("plaza_table_flip_02", 1);
  node = getnode("plaza_table_flip_01_node", "targetname");
  setenablenode(node, 0);
  node = getnode("plaza_table_flip_02_node", "targetname");
  setenablenode(node, 0);
  flag_wait("run_scene_plaza_table_flip");
  node = getnode("plaza_table_flip_01_node", "targetname");
  setenablenode(node, 1);
  node = getnode("plaza_table_flip_02_node", "targetname");
  setenablenode(node, 1);
  level thread run_scene_and_delete("plaza_table_flip_01");
  level thread run_scene_and_delete("plaza_table_flip_02");
}

plaza_shop_ai_anims() {
  level thread handle_shop_guy_1_nodes();
  level thread handle_shop_guy_2_nodes();
}

handle_shop_guy_1_nodes() {
  nodes = getnodearray("plaza_shop_guy_1_nodes", "script_noteworthy");

  foreach(node in nodes)
  setenablenode(node, 0);

  scene_wait("plaza_shopguy01");

  foreach(node in nodes)
  setenablenode(node, 1);
}

handle_shop_guy_2_nodes() {
  nodes = getnodearray("plaza_shop_guy_2_nodes", "script_noteworthy");

  foreach(node in nodes)
  setenablenode(node, 0);

  scene_wait("plaza_shopguy02");

  foreach(node in nodes)
  setenablenode(node, 1);
}

clear_behind() {
  level endon("plaza_decision_made");

  while(true) {
    a_friendlies = getaiarray("allies");
    a_enemies = getaiarray("axis");

    foreach(ai_enemy in a_enemies) {
      wait_network_frame();

      if(!isDefined(ai_enemy) || !isalive(ai_enemy)) {
        continue;
      }
      if(isDefined(ai_enemy.isbigdog) && ai_enemy.isbigdog) {
        continue;
      }
      if(level.player.origin[1] - ai_enemy.origin[1] < 512) {
        continue;
      }
      a_nearest_friendly = spawnstruct();
      a_nearest_friendly.dist_sq = 262144;

      foreach(ai_friendly in a_friendlies) {
        if(!isDefined(ai_friendly) || !isalive(ai_friendly)) {
          continue;
        }
        n_dist_sq = lengthsquared(ai_enemy.origin - ai_friendly.origin);

        if(n_dist_sq > a_nearest_friendly.dist_sq) {
          continue;
        }
        a_nearest_friendly.ai_friendly = ai_friendly;
        a_nearest_friendly.dist_squared = n_dist_sq;
      }

      if(isDefined(a_nearest_friendly.ai_friendly)) {
        a_nearest_friendly.ai_friendly shoot_at_target_perfect_aim(ai_enemy);
        continue;
      }

      if(!level.player is_player_looking_at(ai_enemy.origin, 0))
        ai_enemy bloody_death();
    }

    wait 0.1;
  }
}

shoot_at_target_perfect_aim(ai_target) {
  self endon("death");
  self.perfectaim = 1;
  self shoot_at_target(ai_target);
  self.perfectaim = 0;
}

brake_van() {
  self endon("death");
  self.overridevehicledamage = ::van_damage_override;
  self waittill("brake");

  while(self getspeedmph() > 0)
    wait 0.05;

  self notify("unload");
  level notify(self.targetname + "_unload");
}

van_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  if(str_means_of_death == "MOD_PROJECTILE_SPLASH" || str_means_of_death == "MOD_PROJECTILE")
    n_damage = self.health;

  return n_damage;
}

plaza_rpg() {
  self endon("death");
  self.a.allow_weapon_switch = 0;
  self force_goal(undefined, 16);
  self.goalradius = 16;
}

plaza_harper_movement() {
  if(!flag("harper_dead")) {
    level thread plaza_harper_movement_left();
    level thread plaza_harper_movement_right();
    level thread plaza_harper_movement_center();
  }
}

plaza_harper_movement_center() {
  level endon("intersection_started");
  trigger_wait("sm_plaza_center_3");
  trigger_use("intersection_start");
}

plaza_harper_movement_left() {
  level endon("delete_plaza_left_color");
  trigger_wait("color_plaza_left_0");
  level notify("delete_plaza_right_color");
  a_plaza_right_color = getentarray("plaza_right_color", "script_noteworthy");

  foreach(t_plaza_right_color in a_plaza_right_color)
  t_plaza_right_color delete();

  level.harper.plaza_right = 0;
}

plaza_harper_movement_right() {
  level endon("delete_plaza_right_color");
  trigger_wait("sm_plaza_right_0");
  level notify("delete_plaza_left_color");
  a_plaza_left_color = getentarray("plaza_left_color", "script_noteworthy");

  foreach(t_plaza_left_color in a_plaza_left_color)
  t_plaza_left_color delete();

  level.harper.plaza_right = 1;
}

plaza_right_color_logic() {
  level thread plaza_right_color_1_inside();
  level thread plaza_right_color_1_outside();
  level thread cleanup_color_plaza_right_2_inside();
  level thread cleanup_color_plaza_right_2_outside();
}

plaza_right_color_1_inside() {
  level endon("delete_plaza_right_color");
  level endon("plaza_right_color_1");
  trigger_wait("color_plaza_right_1_inside");
  cleanup_kvp("color_plaza_right_1_outside", "targetname");
  cleanup_kvp("color_plaza_right_0_inside", "targetname");
  level notify("plaza_right_color_1");
}

plaza_right_color_1_outside() {
  level endon("delete_plaza_right_color");
  level endon("plaza_right_color_1");
  trigger_wait("color_plaza_right_1_outside");
  cleanup_kvp("color_plaza_right_1_inside", "targetname");
  cleanup_kvp("color_plaza_right_0_inside", "targetname");
  level notify("plaza_right_color_1");
}

force_goal_after_unload() {
  self endon("death");
  self force_goal(undefined, 16, 1);
}

f35_crash() {
  m_clip = getent("plaza_f38_clip", "targetname");
  m_clip connectpaths();
  m_clip notsolid();
  trig = trigger_wait("t_f35_crash");
  level thread f35_crash_sound();

  if(!flag("harper_dead") && (isDefined(level.harper.plaza_right) && level.harper.plaza_right))
    level notify("plaza_right_color_2");

  flag_set("f35_la_plaza_crash_start");
  wait 3.5;
  m_clip solid();
  m_clip disconnectpaths();

  if(level.player istouching(m_clip))
    level.player suicide();

  flag_set("f35_la_plaza_crash_end");
}

f35_crash_fx(m_f35) {
  run_scene_first_frame("f35_crash_pilot");
  m_f35 play_fx("f35_exhaust_hover_front", undefined, undefined, "stop_fx", 1, "tag_fx_nozzle_left");
  m_f35 play_fx("f35_exhaust_hover_front", undefined, undefined, "stop_fx", 1, "tag_fx_nozzle_right");
  m_f35 play_fx("f35_exhaust_hover_rear", undefined, undefined, "stop_fx", 1, "tag_fx_nozzle_left_rear");
  m_f35 play_fx("f35_exhaust_hover_rear", undefined, undefined, "stop_fx", 1, "tag_fx_nozzle_right_rear");
  level waittill("f35_tower_02_start");
  m_f35 notify("stop_fx");
  level clientnotify("f35_crash_done");
}

f35_crash_sound() {
  temp_ent = spawn("script_origin", (12331, -440, 657));
  temp_ent playsound("evt_f35_crash_incoming");
  wait 2;
  clientnotify("snd_f35_crash");
  level.player playsound("evt_f35_crash_impact");
  level.player playrumbleonentity("artillery_rumble");
  earthquake(0.5, 4.0, level.player.origin, 100);
  temp_ent delete();
  wait 1;
  level.player playrumbleonentity("grenade_rumble");
}

kill_player_if_run_over(str_scene_name) {
  level endon(str_scene_name + "_done");

  while(!level.player istouching(self))
    wait 0.05;

  level.player suicide();
}

cleanup_street() {
  a_fxanim_models = getentarray("fxanim", "script_noteworthy");

  foreach(ent in a_fxanim_models) {
    e_linked = ent getlinkedent();

    if(isDefined(e_linked) && (!isDefined(e_linked.model) && !isDefined("fxanim_la_apartment_mod") || isDefined(e_linked.model) && isDefined("fxanim_la_apartment_mod") && e_linked.model == "fxanim_la_apartment_mod"))
      ent unlink();
  }
}

plaza_and_intersect_transition() {
  flag_wait("intersection_started");
  cleanup_street();
  level notify("plaza_decision_made");
  level notify("plaza_end");
  cleanup_kvp("sm_plaza_left_0");
  cleanup_kvp("sm_plaza_left_1");
  cleanup_kvp("sm_plaza_left_2");
  cleanup_kvp("sm_plaza_left_3");
  cleanup_kvp("sm_plaza_left_4");
  cleanup_kvp("sm_plaza_left_5");
  cleanup_kvp("sm_plaza_right_0");
  cleanup_kvp("sm_plaza_right_1");
  cleanup_kvp("sm_plaza_right_2");
  cleanup_kvp("sm_plaza_right_3");
  cleanup_kvp("sm_plaza_center_2");
  cleanup_kvp("sm_plaza_center_3");
  cleanup_kvp("plaza_stairs_left");
  cleanup_kvp("color_plaza_right_0_inside");
  cleanup_kvp("color_plaza_right_2_inside");
  cleanup_kvp("color_plaza_right_1_outside");
  cleanup_kvp("color_plaza_left_1");
  cleanup_kvp("color_plaza_left_2");
  cleanup_kvp("color_plaza_left_3");
  cleanup_kvp("color_plaza_left_4");
  cleanup_kvp("color_plaza_left_5");
  cleanup_kvp("color_plaza_right_1_inside");
  cleanup_kvp("color_plaza_right_2_outside");
  a_friendlies = getaiarray("allies");

  foreach(ai_friendly in a_friendlies) {
    ai_friendly change_movemode("cqb");
    ai_friendly.perfectaim = 1;
  }

  a_friendlies = getaiarray("allies");

  foreach(ai_friendly in a_friendlies) {
    ai_friendly enable_ai_color();
    ai_friendly reset_movemode();
    ai_friendly.perfectaim = 0;
    ai_friendly thread force_goal(undefined, 16, 1);
  }
}

lockbreaker() {
  trigger_off("lockbreaker_use", "targetname");
  level.player waittill_player_has_lock_breaker_perk();
  t_perk_use = getent("lockbreaker_use", "targetname");
  t_perk_use setcursorhint("HINT_NOICON");
  t_perk_use sethintstring(&"SCRIPT_HINT_HACK");
  trigger_on("lockbreaker_use", "targetname");
  m_lock = getent("lockbreaker_position", "targetname");
  set_objective_perk(level.obj_lock_perk, m_lock);
  trigger_wait("lockbreaker_use");
  remove_objective_perk(level.obj_lock_perk);
  level.player magic_bullet_shield();
  run_scene("lockbreaker");
  level.player stop_magic_bullet_shield();
  level thread intruder_sam();
}

lockbreaker_planted(m_player) {
}

lockbreaker_door_open(m_player) {
  m_left_org = getent("lockbreaker_left", "targetname");
  m_left_door = getent("lockbreaker_left_door", "targetname");
  m_right_org = getent("lockbreaker_right", "targetname");
  m_right_door = getent("lockbreaker_right_door", "targetname");
  m_left_door linkto(m_left_org);
  m_right_door linkto(m_right_org);
  m_left_org rotateyaw(100, 2.0);
  m_right_org rotateyaw(-100, 2.0);
}

intruder_sam() {
  level.b_sam_success = 0;
  level.player thread sam_visionset();
  set_objective_perk(level.obj_lock_perk, getent("near_intruder_sam", "targetname"));
  trigger_wait("near_intruder_sam");
  remove_objective_perk(level.obj_lock_perk);
  level.player.ignoreme = 1;
  level thread fxanim_drones();
  level thread intruder_sam_timer();

  if(maps\_fire_direction::is_fire_direction_active())
    level.player maps\_fire_direction::_fire_direction_disable();

  run_scene("sam_in");
  flag_set("rooftop_sam_in");
  level.player thread magic_bullet_shield();
  vh_sam = getent("intruder_sam", "targetname");
  vh_sam usevehicle(level.player, 2);
  vh_sam thread intruder_sam_death();
  vh_sam.overridevehicledamage = ::sam_damage_override;
  vh_sam hide_sam_turret();
  vh_sam thread maps\_vehicle_death::vehicle_damage_filter(undefined, 5, 1);
  level.player thread sam_cougar_player_damage_watcher();
  setdvar("aim_assist_script_disable", 0);
  level.player.old_aim_assist_min_target_distance = getdvarint(#"_id_E87B44C5");
  level.player setclientdvar("aim_assist_min_target_distance", 100000);
  level.plaza_sam_time = gettime();
  level thread drone_sam_attack();
  level waittill("intruder_sam_end");
  level.plaza_sam_time = gettime() - level.plaza_sam_time;
  level.player thread stop_magic_bullet_shield();
  flag_clear("rooftop_sam_in");
  level notify("rooftop_drone_killed");

  if(vh_sam.health > 0)
    vh_sam useby(level.player);

  vh_sam show_sam_turret();

  if(level.b_sam_success)
    run_scene("sam_out");
  else {
    vh_sam dodamage(10000, vh_sam.origin, undefined, undefined, "explosive");
    run_scene("sam_thrown_out");
  }

  level notify("sam_out_anim_done");
  autosave_by_name("sam_thrown_out");
  level thread plaza_vo_pmc_callouts();
  level.player setclientdvar("aim_assist_min_target_distance", level.player.old_aim_assist_min_target_distance);
  level.player.ignoreme = 0;

  if(maps\_fire_direction::is_fire_direction_active())
    level.player maps\_fire_direction::_fire_direction_enable();
}

drone_sam_attack() {
  level endon("intruder_sam_end");
  n_count = 6;
  angle_offsets = [];
  n_first_right_or_left = randomintrange(0, 2);
  angle_offset[0] = randomintrange(90, 100) + n_first_right_or_left * 170;
  angle_offset[1] = 180;
  angle_offset[2] = 180;
  level.drone_sam_attack_score = 0;

  for(i = 1; i <= 15; i++) {
    level.n_drone_wave = i;
    count = n_count + (i - 1);
    a_drones = spawn_sam_drone_group("avenger_fast", count, 180);
    array_thread(a_drones, ::intruder_sam_drone_end);
    array_thread(a_drones, ::intruder_sam_drone_score_watcher);
    level notify("drones_spawned");
    array_wait(a_drones, "death");

    if(level.n_drone_wave == 14)
      flag_set("start_sam_end_vo");

    level notify("good_shot");
  }

  foreach(vh_drone in a_drones) {
    if(isDefined(vh_drone.deathmodel_pieces))
      array_delete(vh_drone.deathmodel_pieces);
  }
}

update_drone_sam_attack_score() {
  level endon("intruder_sam_end");

  while(true) {
    wait 10;
    level.drone_sam_attack_score = level.drone_sam_attack_score + 1000;
  }
}

fxanim_drones() {
  a_fxanim_drones = getentarray("fxanim_ambient_drone", "targetname");
  level.is_player_in_sam = 1;

  foreach(m_drone in a_fxanim_drones) {
    m_drone delete();
    level.n_av_models--;
  }

  level waittill("intruder_sam_end");
  level.is_player_in_sam = 0;
}

intruder_sam_timer() {
  level endon("intruder_sam_end");
  n_time = 120;
  wait(n_time);
  level.b_sam_success = 1;
  level notify("intruder_sam_end");
}

intruder_sam_death() {
  level endon("intruder_sam_end");
  self waittill("death");
  level.b_sam_success = 0;
  level notify("intruder_sam_end");
}

intruder_sam_drone_end() {
  self endon("death");
  level waittill("intruder_sam_end");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

intruder_sam_drone_score_watcher() {
  level endon("intruder_sam_end");
  self.n_birth_time = gettime();
  self waittill("death");
  time = gettime();
  delta = (time - self.n_birth_time) / 1000;
  t = delta / 10;
  t = clamp(t, 0.0, 1.0);
  t = 1.0 - t;
  score = int(lerpfloat(500, 5000, t)) * level.n_drone_wave;
  level.drone_sam_attack_score = level.drone_sam_attack_score + score;
  level notify("rooftop_drone_killed");
}

sam_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  if(n_damage < 11)
    level.player dodamage(1, e_attacker.origin);

  return n_damage * 3;
}

hide_sam_turret() {
  level.player hide_hud();
  self hidepart("tag_gunner_turret2", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_canopy", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_stick_base", "veh_t6_mil_cougar_turret_sam");
  self hidepart("tag_screen", "veh_t6_mil_cougar_turret_sam");
}

show_sam_turret() {
  level.player show_hud();
  self showpart("tag_gunner_turret2", "veh_t6_mil_cougar_turret_sam");
  self showpart("tag_canopy", "veh_t6_mil_cougar_turret_sam");
  self showpart("tag_stick_base", "veh_t6_mil_cougar_turret_sam");
  self showpart("tag_screen", "veh_t6_mil_cougar_turret_sam");
}

skylight_leader() {
  scene_wait("skylight_leader");
  self setgoalnode(getnode(self.target, "targetname"));
  self waittill("goal");
  self delete();
}