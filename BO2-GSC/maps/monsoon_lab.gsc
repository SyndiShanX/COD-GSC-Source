/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\monsoon_lab.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\monsoon_util;
#include maps\_vehicle;
#include maps\_dialog;
#include maps\_scene;
#include maps\_anim;
#include maps\_dynamic_nodes;
#include maps\_glasses;
#include maps\_cic_turret;
#include maps\_music;
#include maps\monsoon_celerium_chamber;
#include maps\monsoon_lab;
#include maps\createart\monsoon_art;
#include maps\_metal_storm;
#include maps\monsoon_lab_defend;
#include maps\_camo_suit;
#include maps\_audio;
#include maps\_titus;

skipto_lab() {
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
  skipto_teleport("player_skipto_lab", get_heroes());
}

skipto_lab_battle() {
  s_glass_hallway_damage_pulse = getstruct("glass_hallway_damage_pulse", "targetname");
  radiusdamage(s_glass_hallway_damage_pulse.origin, 128, 300, 300);
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
  level thread battlechatter_on();
  lab_spawn_funcs();
  init_lab_interior();
  skipto_teleport("player_skipto_lab_battle", get_heroes());
  trigger_use("trig_spawn_lobby_guys");
  trigger_use("trig_color_lobby_front");
  trigger_use("trig_color_lobby_mid");
  level thread asd_lobby_guys();
  level thread lab_doors();
  m_asd_intro_tile_fall = getent("asd_intro_tile_fall", "targetname");
  m_asd_intro_tile_fall delete();
  level thread challenge_kill_challenge_watch();

  foreach(hero in level.heroes)
  hero change_movemode("cqb_walk");

  level thread emergency_light_init();
  level.ignoreneutralfriendlyfire = 1;
  make_model_not_cheap();
  level thread lab_battle_dead_bodies();
}

skipto_fight_to_isaac() {
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
  e_player_elevator_bottom_clip = getent("player_elevator_bottom_clip", "targetname");
  e_player_elevator_bottom_clip connectpaths();
  e_player_elevator_bottom_clip delete();
  m_lift = getent("lift_interior_m", "targetname");
  m_lift = getent("lift_interior_m", "targetname");
  m_lift.a_left_nodes = getnodearray("interior_lift_left_nodes", "targetname");
  bm_door_south_l = getent("lift_interior_door_1_left", "targetname");
  bm_door_south_l connectpaths();
  bm_door_south_l delete();
  bm_door_south_r = getent("lift_interior_door_1_right", "targetname");
  bm_door_south_r connectpaths();
  bm_door_south_r delete();
  bm_door_north_l = getent("lift_interior_door_2_left", "targetname");
  bm_door_north_l connectpaths();
  bm_door_north_l delete();
  bm_door_north_r = getent("lift_interior_door_2_right", "targetname");
  bm_door_north_r connectpaths();
  bm_door_north_r delete();
  m_door_south_l = getent("lift_interior_door_2_left_m", "targetname");
  m_door_south_l connectpaths();
  m_door_south_r = getent("lift_interior_door_2_right_m", "targetname");
  m_door_south_r connectpaths();
  m_door_north_l = getent("lift_interior_door_1_left_m", "targetname");
  m_door_north_l connectpaths();
  m_door_north_r = getent("lift_interior_door_1_right_m", "targetname");
  m_door_north_r connectpaths();
  m_door_north_l movey(60, 2, 0.5);
  m_door_north_r movey(-60, 2, 0.5);
  m_door_south_l movey(60, 2, 0.5);
  m_door_south_r movey(-60, 2, 0.5);
  interior_lift_bottom_connect_left = getnodearray("interior_lift_bottom_connect_left", "targetname");
  interior_lift_bottom_connect_right = getnodearray("interior_lift_bottom_connect_right", "targetname");
  array_func(m_lift.a_right_nodes, ::_interior_elevator_connect_nodes, interior_lift_bottom_connect_right);
  array_func(m_lift.a_left_nodes, ::_interior_elevator_connect_nodes, interior_lift_bottom_connect_left);
  lab_spawn_funcs();
  init_lab_interior();
  skipto_teleport("player_skipto_isaac_battle", get_heroes());
  level thread maps\monsoon_celerium_chamber::turn_off_all_lab_trigs();
  level thread maps\monsoon_lab::remove_hallway_ai_clip();
  level thread maps\monsoon_lab::lab_doors();
  s_glass_hallway_damage_pulse = getstruct("glass_hallway_damage_pulse", "targetname");
  radiusdamage(s_glass_hallway_damage_pulse.origin, 128, 300, 300);
  level thread challenge_kill_challenge_watch();
  nd_harper_titus_node = getnode("harper_titus_node", "targetname");
  level.harper setgoalnode(nd_harper_titus_node);
  nd_lift_salazar = getnode("nd_lift_salazar", "targetname");
  level.salazar setgoalnode(nd_lift_salazar);
  nd_lift_crosby = getnode("nd_lift_crosby", "targetname");
  level.crosby setgoalnode(nd_lift_crosby);
  level thread emergency_light_init();
  level.ignoreneutralfriendlyfire = 1;
  make_model_not_cheap();
}

init_lab_flags() {
  flag_init("obj_lab_entrance_regroup");
  flag_init("lab_clean_room_open");
  flag_init("salazar_entrance_hack_done");
  flag_init("salazar_at_clean_room_panel");
  flag_init("harper_at_lab");
  flag_init("salazar_at_lab");
  flag_init("set_lift_objective");
  flag_init("player_crosby_path");
  flag_init("player_first_floor_path");
  flag_init("player_harps_path");
  flag_init("player_at_right_path");
  flag_init("harper_at_turret");
  flag_init("sal_at_lift_node");
  flag_init("harp_at_lift_node");
  flag_init("lift_guys_cleared");
  flag_init("player_upstairs_vo");
  flag_init("player_on_me_vo");
  flag_init("start_lab_pa_alarm");
  flag_init("lift_pre_ambush_fire");
  flag_init("lab_battle_vo_start");
  flag_init("lab_battle_mid_vo");
  flag_init("player_enemy_lift_vo");
  flag_init("stop_nitrogen_think");
  flag_init("stop_lobby_color_think");
  flag_init("player_at_lab_entrance");
  flag_init("open_lab_entrance");
  flag_init("lab_entrance_open");
  flag_init("player_at_clean_room");
  flag_init("close_entrance_doors");
  flag_init("lab_lobby_doors");
  flag_init("lab_2_1_right_door");
  flag_init("lab_2_1_left_door");
  flag_init("start_player_asd_anim");
  flag_init("end_player_asd_anim");
  flag_init("asd_becomes_active");
  flag_init("asd_tutorial_died");
  flag_init("asd_tutorial_2_died");
  flag_init("stop_shelf_fxanim");
  flag_init("start_asd_battle");
  flag_init("spawn_lobby_guys");
  flag_init("start_lab_1_1_battle");
  flag_init("lab_1_1_frontline_half");
  flag_init("lab_1_1_frontline_cleared");
  flag_init("lab_1_1_guys_half");
  flag_init("lab_1_2_frontline_half");
  flag_init("lab_1_2_guys_half");
  flag_init("lab_1_2_guys_cleared");
  flag_init("lab_2_1_frontline_half");
  flag_init("lab_2_1_frontline_cleared");
  flag_init("lab_2_1_guys_half");
  flag_init("lab_2_2_guys_half");
  flag_init("lab_2_2_guys_cleared");
  flag_init("start_lift_move_up");
  flag_init("start_lift_move_down");
  flag_init("lift_at_top");
  flag_init("lift_at_bottom");
  flag_init("elevator_is_ready");
  flag_init("start_elevator_exits");
  flag_init("start_shooting_lift");
  flag_init("spawn_nitrogen_guys");
  flag_init("section_8_nag");
  flag_init("harper_lift_ready");
  flag_init("crosby_lift_ready");
  flag_init("salazar_lift_ready");
  flag_init("nitrogen_asd_fallback_1");
  flag_init("nitrogen_asd_fallback_2");
  flag_init("right_path_asd_destroyed");
  flag_init("start_lab_defend");
  flag_init("harper_asd_titus_fire");
  flag_init("nitrogen_asd_is_dead");
  flag_init("right_path_asd_fallback");
  flag_init("3_1_left_path_cleared");
  flag_init("3_1_right_path_cleared");
  flag_init("3_2_left_path_cleared");
  flag_init("3_2_right_path_cleared");
  flag_init("set_off_hallway_destruction");
  flag_init("player_at_ddm");
  flag_init("player_at_lab_defend");
  flag_init("harper_pre_ddm");
  flag_init("salazar_pre_ddm");
  flag_init("crosby_pre_ddm");
  flag_init("stop_harper_throw");
  flag_init("end_ambient_asd");
  flag_init("harper_shield_is_ready");
  flag_init("player_shield_is_ready");
  flag_init("player_ddm_ready");
  flag_init("harper_ddm_ready");
  flag_init("set_ddm_objective");
  flag_init("kill_asd_flank_vo");
  flag_init("open_top_stairs_doors");
}

init_lab_interior() {
  a_lab_lens_flare = getstructarray("lab_lens_flare", "targetname");

  foreach(lens_flare in a_lab_lens_flare) {
    v_forward = anglestoforward(lens_flare.angles);
    playfx(level._effect["light_lens_flare"], lens_flare.origin, v_forward);
    wait 0.05;
  }

  a_destroyed_lobby_asd = getentarray("destroyed_lobby_asd", "targetname");

  foreach(asd in a_destroyed_lobby_asd) {
    asd hide();
    asd notsolid();
  }

  wait 0.05;
  a_exit_blood_02 = getentarray("exit_blood_02", "targetname");

  foreach(blood in a_exit_blood_02) {
    if(!is_mature())
      blood hide();
  }

  wait 0.05;
  a_exit_blood_01 = getentarray("exit_blood_01", "targetname");

  foreach(blood in a_exit_blood_01)
  blood hide();

  wait 0.05;
  wait 0.05;
  m_lift = getent("lift_interior_m", "targetname");
  m_lift setmovingplatformenabled(1);
  wait 0.05;
  trig_elevator_panel = getent("trig_elevator_panel", "targetname");
  trig_elevator_panel enablelinkto();
  trig_elevator_panel linkto(m_lift);
  trig_elevator_panel sethintstring("");
  trig_elevator_panel setcursorhint("HINT_NOICON");
  wait 0.05;
  a_defend_crash_show = getentarray("defend_crash_show", "targetname");

  foreach(crash_piece in a_defend_crash_show)
  crash_piece hide();

  wait 0.05;
  a_defend_pillar_show = getentarray("defend_pillar_show", "targetname");

  foreach(piece in a_defend_pillar_show)
  piece hide();

  wait 0.05;
  e_escape_blast_doors = getent("escape_blast_doors", "targetname");
  e_escape_blast_doors hide();
  e_escape_blast_doors notsolid();
  e_escape_blast_doors connectpaths();
  wait 0.05;
  e_lab_blast_doors = getent("lab_blast_doors", "targetname");
  e_lab_blast_doors hide();
  e_lab_blast_doors notsolid();
  e_lab_blast_doors connectpaths();
  wait 0.05;
  e_celerium_shield_screen = getent("celerium_shield_screen", "targetname");
  e_celerium_shield_screen hide();
  wait 0.05;
  e_lab_stair_blocker_m = getent("lab_stair_blocker_m", "targetname");
  e_lab_stair_blocker_m hide();
  e_lab_stair_blocker_m notsolid();
  e_player_chair_clip = getent("player_chair_clip", "targetname");
  e_player_chair_clip hide();
  e_player_chair_clip notsolid();
  e_lab_shelf_clip_show = getent("lab_shelf_clip_show", "targetname");
  e_lab_shelf_clip_show hide();
  e_lab_shelf_clip_show notsolid();
  e_harpers_shield = getent("harper_shield", "targetname");
  e_harpers_shield hide();
}

lab_entrance() {
  level thread emergency_light_init();
  level thread challenge_kill_challenge_watch();
  level thread clean_room_doors();
  level.ignoreneutralfriendlyfire = 1;

  foreach(hero in level.heroes)
  hero.grenadeawareness = 0;

  level.harper thread harper_lab_intro();
  level.salazar thread salazar_lab_intro();
  level.crosby thread crosby_lab_intro();
  level thread clean_room_vo();
  level thread asd_hallway_vo();
  flag_wait("harper_at_lab");
  flag_wait("salazar_at_lab");
  level.harper idle_at_cover(1);
  level.salazar idle_at_cover(1);
  wait 1;
  trig_player_at_lab = getent("trig_player_at_lab", "targetname");
  trig_player_at_lab trigger_on();
  flag_wait("player_at_lab_entrance");
  level thread run_scene("salazar_lab_entry_intro");
  flag_wait("open_lab_entrance");
  trigger_use("trig_color_clean_room");
  m_lab_door_right_rear = getent("lab_door_right_rear", "targetname");
  m_lab_door_left_rear = getent("lab_door_left_rear", "targetname");
  m_lab_door_left = getent("lab_door_left", "targetname");
  m_lab_door_right = getent("lab_door_right", "targetname");
  bm_lab_door_left_clip = getent("lab_door_left_clip", "targetname");
  bm_lab_door_right_clip = getent("lab_door_right_clip", "targetname");
  bm_lab_door_left_clip linkto(m_lab_door_left);
  bm_lab_door_right_clip linkto(m_lab_door_right);
  bm_lab_door_left_rear_clip = getent("lab_door_left_rear_clip", "targetname");
  bm_lab_door_right_rear_clip = getent("lab_door_right_rear_clip", "targetname");
  bm_lab_door_left_rear_clip linkto(m_lab_door_left_rear);
  bm_lab_door_right_rear_clip linkto(m_lab_door_right_rear);
  s_front_lab_door_rumble_dist = getstruct("s_front_lab_door_rumble_dist", "targetname");
  s_front_lab_door_rumble_dist.is_moving = 1;
  s_front_lab_door_rumble_dist.is_big_door = 1;
  s_front_lab_door_rumble_dist thread player_door_rumble();
  s_rear_lab_door_rumble_dist = getstruct("s_rear_lab_door_rumble_dist", "targetname");
  s_rear_lab_door_rumble_dist.is_moving = 1;
  s_rear_lab_door_rumble_dist.is_big_door = 1;
  s_rear_lab_door_rumble_dist thread player_door_rumble();
  m_lab_door_left connectpaths();
  m_lab_door_right connectpaths();
  bm_lab_door_right_clip connectpaths();
  bm_lab_door_left_clip connectpaths();
  m_lab_door_left_rear connectpaths();
  m_lab_door_right_rear connectpaths();
  bm_lab_door_right_rear_clip connectpaths();
  bm_lab_door_left_rear_clip connectpaths();
  n_distance = distance2d(s_rear_lab_door_rumble_dist.origin, level.player.origin);

  if(n_distance < 500)
    level.player playrumbleonentity("damage_heavy");

  level.player setlowready(0);
  m_lab_door_left movey(90, 5, 1);
  m_lab_door_right movey(-90, 5, 1);
  m_lab_door_right playsound("evt_lab_round_doors");
  wait 1.5;
  n_distance = distance2d(s_rear_lab_door_rumble_dist.origin, level.player.origin);

  if(n_distance < 500)
    level.player playrumbleonentity("damage_heavy");

  m_lab_door_left_rear movey(83, 5, 1);
  m_lab_door_right_rear movey(-83, 5, 1);
  m_lab_door_left_rear playsound("evt_lab_round_doors");
  m_lab_door_left waittill("movedone");
  s_front_lab_door_rumble_dist.is_moving = 0;
  n_distance = distance2d(s_front_lab_door_rumble_dist.origin, level.player.origin);

  if(n_distance < 500)
    level.player playrumbleonentity("damage_heavy");

  m_lab_door_left_rear waittill("movedone");
  s_rear_lab_door_rumble_dist.is_moving = 0;
  n_distance = distance2d(s_rear_lab_door_rumble_dist.origin, level.player.origin);

  if(n_distance < 500)
    level.player playrumbleonentity("damage_heavy");

  flag_set("lab_entrance_open");
  level thread maps\createart\monsoon_art::lab_vision();
  autosave_by_name("asd_battle");
  level.harper idle_at_cover(0);
  level.salazar idle_at_cover(0);
}

make_model_not_cheap() {
  m_lab_door_right_rear = getent("lab_door_right_rear", "targetname");
  m_lab_door_right_rear ignorecheapentityflag(1);
  wait 0.05;
  m_lab_door_left_rear = getent("lab_door_left_rear", "targetname");
  m_lab_door_right_rear ignorecheapentityflag(1);
  m_lab_door_left = getent("lab_door_left", "targetname");
  m_lab_door_left ignorecheapentityflag(1);
  m_lab_door_right = getent("lab_door_right", "targetname");
  m_lab_door_right ignorecheapentityflag(1);
  wait 0.05;
  bm_celerium_door_front_l = getent("celerium_door_front_l", "targetname");
  bm_celerium_door_front_l ignorecheapentityflag(1);
  bm_celerium_door_front_r = getent("celerium_door_front_r", "targetname");
  bm_celerium_door_front_r ignorecheapentityflag(1);
  wait 0.05;
  bm_celerium_door_rear_l = getent("celerium_door_rear_l", "targetname");
  bm_celerium_door_rear_l ignorecheapentityflag(1);
  bm_celerium_door_rear_r = getent("celerium_door_rear_r", "targetname");
  bm_celerium_door_rear_r ignorecheapentityflag(1);
  bm_player_asd_window = getent("player_asd_window", "targetname");
  bm_player_asd_window ignorecheapentityflag(1);
  wait 0.05;
  m_escape_door_01l = getent("escape_door_01l", "targetname");
  m_escape_door_01l ignorecheapentityflag(1);
  m_escape_door_01r = getent("escape_door_01r", "targetname");
  m_escape_door_01r ignorecheapentityflag(1);
  m_escape_door_02l = getent("escape_door_02l", "targetname");
  m_escape_door_02l ignorecheapentityflag(1);
  m_escape_door_02r = getent("escape_door_02r", "targetname");
  m_escape_door_02r ignorecheapentityflag(1);
  wait 0.05;
  e_fxanim_defend_room_door = getent("fxanim_defend_room_door", "targetname");
  e_fxanim_defend_room_door ignorecheapentityflag(1);
  e_ddm_1 = getent("DDM_1", "targetname");
  e_ddm_1 ignorecheapentityflag(1);
  e_ddm_2 = getent("DDM_2", "targetname");
  e_ddm_2 ignorecheapentityflag(1);
  wait 0.05;
  m_defend_door_01r = getent("defend_door_01r", "targetname");
  m_defend_door_01r ignorecheapentityflag(1);
  m_defend_door_01l = getent("defend_door_01l", "targetname");
  m_defend_door_01l ignorecheapentityflag(1);
  m_defend_door_02l = getent("defend_door_02l", "targetname");
  m_defend_door_02l ignorecheapentityflag(1);
  m_defend_door_02r = getent("defend_door_02r", "targetname");
  m_defend_door_02r ignorecheapentityflag(1);
  wait 0.05;
  e_defend_door_3l = getent("defend_door_03l", "targetname");
  e_defend_door_3l ignorecheapentityflag(1);
  e_defend_door_03r = getent("defend_door_03r", "targetname");
  e_defend_door_03r ignorecheapentityflag(1);
  m_lift = getent("lift_interior_m", "targetname");
  m_lift ignorecheapentityflag(1);
  wait 0.05;
  bm_asd_garage_1 = getent("bm_asd_garage_1", "targetname");
  bm_asd_garage_1 ignorecheapentityflag(1);
  bm_asd_garage_2 = getent("bm_asd_garage_2", "targetname");
  bm_asd_garage_2 ignorecheapentityflag(1);
  e_isaac_container = getent("isaac_container", "targetname");
  e_isaac_container ignorecheapentityflag(1);
}

harper_lab_intro() {
  self disable_ai_color(1);
  self.goalradius = 32;
  nd_crosby_lab_entrance = getnode("crosby_lab_entrance", "targetname");
  self setgoalnode(nd_crosby_lab_entrance);
  self waittill("goal");
  flag_set("harper_at_lab");
  flag_wait("player_at_lab_entrance");
  self enable_ai_color();
  run_scene("harper_lab_entry_intro");
  flag_wait("start_player_asd_anim");
  run_scene("asd_intro_harper_int_player");
  trigger_use("trig_color_post_clean_room");
}

crosby_lab_intro() {
  nd_crosby_pre_lab_entrance = getnode("crosby_pre_lab_entrance", "targetname");
  self setgoalnode(nd_crosby_pre_lab_entrance);
  self waittill("goal");
  flag_wait("player_at_lab_entrance");
  self disable_ai_color(1);
  nd_crosby_lab_entrance = getnode("crosby_lab_entrance", "targetname");
  self setgoalnode(nd_crosby_lab_entrance);
  self waittill("goal");
  flag_wait("lab_entrance_open");
  self enable_ai_color();
}

salazar_lab_intro() {
  self disable_ai_color(1);
  self.goalradius = 32;
  nd_salazar_entrance = getnode("nd_salazar_entrance", "targetname");
  self setgoalnode(nd_salazar_entrance);
  self waittill("goal");
  flag_set("salazar_at_lab");
  flag_wait("lab_entrance_open");
  nd_salazar_pre_clean = getnode("salazar_pre_clean", "targetname");
  self setgoalnode(nd_salazar_pre_clean);
  flag_set("salazar_at_clean_room_panel");
  flag_wait("player_at_clean_room");
  self enable_ai_color();
  level.player thread queue_dialog("sect_salazar_get_it_ope_1");
  run_scene("asd_intro_salazar_intro");
  nd_salazar_post_clean = getnode("salazar_post_clean", "targetname");
  self setgoalnode(nd_salazar_post_clean);
}

clean_room_doors() {
  flag_wait("player_at_lab_entrance");
  autosave_now("player_at_entrance");
  make_model_not_cheap();
  init_lab_interior();
  e_clip_clean_room_door = getent("clip_clean_room_door", "targetname");
  e_clip_clean_room_door notsolid();
  e_clip_clean_room_door hide();
  m_clean_room_door_01_l = getent("clean_room_door_01_l", "targetname");
  m_clean_room_door_01_l ignorecheapentityflag(1);
  m_clean_room_door_01_l_clip = getent("clean_room_door_01_l_clip", "targetname");
  m_clean_room_door_01_l_clip linkto(m_clean_room_door_01_l);
  m_clean_room_door_01_r = getent("clean_room_door_01_r", "targetname");
  m_clean_room_door_01_r ignorecheapentityflag(1);
  m_clean_room_door_01_r_clip = getent("clean_room_door_01_r_clip", "targetname");
  m_clean_room_door_01_r_clip linkto(m_clean_room_door_01_r);
  m_clean_room_door_01_l connectpaths();
  m_clean_room_door_01_r connectpaths();
  m_clean_room_door_01_l_clip connectpaths();
  m_clean_room_door_01_r_clip connectpaths();
  m_clean_room_door_02_l = getent("clean_room_door_02_l", "targetname");
  m_clean_room_door_02_l ignorecheapentityflag(1);
  m_clean_room_door_02_r = getent("clean_room_door_02_r", "targetname");
  m_clean_room_door_02_r ignorecheapentityflag(1);
  trigger_wait("trig_clean_room_doors");
  playsoundatposition("evt_clean_room_doors_open", (8220, 55198, -931));
  m_clean_room_door_01_l movey(58, 1);
  m_clean_room_door_01_r movey(-58, 1);
  flag_wait("player_at_clean_room");
  trig_clean_room_player = getent("trig_clean_room_player", "script_noteworthy");

  while(true) {
    if(level.player istouching(trig_clean_room_player) && level.harper istouching(trig_clean_room_player) && level.salazar istouching(trig_clean_room_player) && level.crosby istouching(trig_clean_room_player)) {
      break;
    }

    wait 0.05;
  }

  e_clip_clean_room_door solid();
  e_clip_clean_room_door show();
  m_clean_room_door_01_l movey(-58, 1);
  m_clean_room_door_01_r movey(58, 1);
  playsoundatposition("evt_clean_room_doors_close", (8220, 55198, -931));
  flag_set("close_entrance_doors");
  m_clean_room_door_01_r waittill("movedone");
  wait 2;
  exploder(1350);
  spray_ent = spawn("script_origin", (8382, 55196, -887));
  playsoundatposition("evt_spray_start", (8382, 55196, -887));
  spray_ent playloopsound("evt_spray_loop", 0.5);
  wait 5;
  spray_ent stoploopsound(0.5);
  playsoundatposition("evt_spray_stop", (8382, 55196, -887));
  spray_ent delete();
  wait 1;
  flag_set("lab_clean_room_open");
  playsoundatposition("evt_clean_room_door_2_open", (8538, 55207, -945));
  m_clean_room_door_02_l_clip = getent("clean_room_door_02_l_clip", "targetname");
  m_clean_room_door_02_l_clip linkto(m_clean_room_door_02_l);
  m_clean_room_door_02_r_clip = getent("clean_room_door_02_r_clip", "targetname");
  m_clean_room_door_02_r_clip linkto(m_clean_room_door_02_r);
  m_clean_room_door_02_l movey(58, 1);
  m_clean_room_door_02_r movey(-58, 1);
  m_clean_room_door_02_r waittill("movedone");
  m_clean_room_door_02_l connectpaths();
  m_clean_room_door_02_r connectpaths();
  m_clean_room_door_02_l_clip connectpaths();
  m_clean_room_door_02_r_clip connectpaths();
  level.crosby change_movemode("cqb_walk");
  level.harper change_movemode("cqb_walk");
  flag_wait("open_top_stairs_doors");
  m_clean_room_door_01_l movey(58, 1);
  m_clean_room_door_01_r movey(-58, 1);
}

asd_visor_text() {
  wait 1;
  add_visor_text("MONSOON_ASD_ANOMALY", 0, "default", "medium");
  wait 2;
  remove_visor_text("MONSOON_ASD_ANOMALY");
  wait 0.05;
  add_visor_text("MONSOON_ASD_DETECTED", 0, "default", "medium");
  wait 2;
  remove_visor_text("MONSOON_ASD_DETECTED");
}

player_asd_intro() {
  level thread lab_battle_enemy_vo();
  flag_wait("start_player_asd_anim");
  level thread asd_visor_text();
  level.player thread queue_dialog("cub2_asd_alerted_0");
  level.crosby reset_movemode();
  level.harper reset_movemode();
  level notify("fxanim_metal_storm_enter01_start");
  earthquake(0.75, 2, level.player.origin, 1000);
  level.player shellshock("default", 8.5);
  level.player playsound("evt_lab_entrance_exp");
  level.player playrumbleonentity("grenade_rumble");
  level.player setcandamage(0);
  level clientnotify("snd_alarm");
  setsaveddvar("bg_fallDamageMinHeight", 512);
  setsaveddvar("bg_fallDamageMaxHeight", 850);
  m_asd_intro_tile_fall = getent("asd_intro_tile_fall", "targetname");
  m_asd_intro_tile_fall delete();
  setmusicstate("MONSOON_BASE_FIGHT_1");

  if(level.player ent_flag_exist("camo_suit_on") && level.player ent_flag("camo_suit_on"))
    level.player ent_flag_clear("camo_suit_on");

  level.player stopsounds();
  bm_player_asd_window = getent("player_asd_window", "targetname");
  bm_player_asd_window_2 = getent("player_asd_window_2", "targetname");
  e_player_asd_window_clip = getent("player_asd_window_clip", "targetname");
  bm_player_asd_window connectpaths();
  bm_player_asd_window_2 connectpaths();
  e_player_asd_window_clip connectpaths();
  e_player_asd_window_clip delete();
  bm_player_asd_window movex(-60, 0.5);
  bm_player_asd_window_2 movex(60, 0.5);
  run_scene("asd_intro_player_intro");
  flag_set("end_player_asd_anim");
  autosave_by_name("asd_intro");
  level.player setcandamage(1);
  s_hallway_rockets_start = getstruct("hallway_rockets_start", "targetname");
  s_asd_hallway_target = getstruct("asd_hallway_target", "targetname");
  magicbullet("metalstorm_launcher", s_hallway_rockets_start.origin, s_asd_hallway_target.origin);
  wait 0.25;
  magicbullet("metalstorm_launcher", s_hallway_rockets_start.origin, s_asd_hallway_target.origin);
}

asd_fall_back_think() {
  self endon("death");
  s_asd_2_spot = getstruct("asd_2_spot", "targetname");
  self maps\_vehicle::defend(s_asd_2_spot.origin, 128);
  flag_wait("spawn_lobby_guys");
  s_asd_fallback_pos = getstruct("asd_fallback_pos", "targetname");
  self thread maps\_vehicle::defend(s_asd_fallback_pos.origin, 128);
  waittill_ai_group_ai_count("lobby_guys", 5);
  self notify("death");
}

harper_grenade_launch(guy) {
  playfxontag(getfx("grenade_arm_launcher"), level.harper, "J_Wrist_RI");
}

asd_grenade_defense(guy) {
  s_midair_nade_explosion = getstruct("midair_nade_explosion", "targetname");
  playfx(getfx("c4_explode"), s_midair_nade_explosion.origin);
  level notify("fxanim_metal_storm_enter02_start");
  level.player playrumbleonentity("grenade_rumble");
  earthquake(0.2, 0.5, level.player.origin, 1000);
}

lab_main() {
  lab_spawn_funcs();
  level thread lab_entrance();
  asd_tutorial_intro();
}

asd_tutorial_intro() {
  level thread player_asd_intro();
  flag_wait("start_player_asd_anim");
  level thread vo_player_asd();
  level thread watch_asd_deaths();
  level thread asd_cleanup();
  level thread rpg_hallway_destruction();
  level.vh_asd_tutorial = spawn_vehicle_from_targetname("asd_tutorial");
  level.vh_asd_tutorial thread asd_lobby_think();
  level.vh_asd_tutorial thread watch_asd_tutorial_death();
  level.vh_asd_tutorial_2 = spawn_vehicle_from_targetname("asd_tutorial_2");
  level.vh_asd_tutorial_2 thread asd_fall_back_think();
  level.vh_asd_tutorial_2 thread watch_asd_tutorial_2_death();
  flag_wait("end_player_asd_anim");

  foreach(hero in level.heroes)
  hero.grenadeawareness = 1;

  level thread asd_lobby_guys();
  level thread lab_battle_dead_bodies();
  flag_wait("start_lab_1_1_battle");
}

asd_cleanup() {
  flag_wait("elevator_is_ready");

  if(isDefined(level.vh_asd_tutorial) && isalive(level.vh_asd_tutorial))
    level.vh_asd_tutorial notify("death");

  if(isDefined(level.vh_asd_tutorial_2) && isalive(level.vh_asd_tutorial_2))
    level.vh_asd_tutorial_2 notify("death");
}

watch_asd_tutorial_death() {
  self waittill("death");
  flag_set("asd_tutorial_died");
}

watch_asd_tutorial_2_death() {
  self waittill("death");
  flag_set("asd_tutorial_2_died");
}

watch_asd_deaths() {
  flag_wait("asd_tutorial_died");
  flag_wait("asd_tutorial_2_died");
  flag_set("stop_shelf_fxanim");
}

lab_battle_dead_bodies() {
  flag_wait("start_lab_1_1_battle");
  level thread run_scene("scientist_1");
  level thread run_scene("scientist_2");
  level thread run_scene("scientist_3");
  level thread run_scene("scientist_5");
  level thread run_scene("scientist_10");
  level thread run_scene("scientist_11");
  level thread run_scene("cower_2_loop");
  flag_wait("start_lift_move_down");
  end_scene("scientist_1");
  delete_scene_all("scientist_1");
  end_scene("scientist_2");
  delete_scene_all("scientist_2");
  end_scene("scientist_3");
  delete_scene_all("scientist_3");
  end_scene("scientist_5");
  delete_scene_all("scientist_5");
  end_scene("scientist_10");
  delete_scene_all("scientist_10");
  end_scene("scientist_11");
  delete_scene_all("scientist_11");
  end_scene("cower_2_loop");
  delete_scene_all("cower_2_loop");
}

clean_room_vo() {
  level endon("lock_breaker_perk_used");
  level endon("start_player_asd_anim");
  level endon("player_on_me_vo");
  flag_wait("player_at_clean_room");
  flag_wait("lab_clean_room_open");
  level.salazar queue_dialog("sala_it_looks_deserted_1", 0.5, undefined, "player_on_me_vo");
  level.player queue_dialog("sect_they_may_have_abando_1", 0.5, undefined, "player_on_me_vo");
}

asd_hallway_vo() {
  flag_wait("player_on_me_vo");
  level.player queue_dialog("sect_alright_on_me_1", 0.1, undefined, "start_player_asd_anim");
}

rpg_hallway_destruction() {
  s_asd_rpg_start = getstruct("asd_rpg_start", "targetname");
  s_asd_rpg_end = getstruct(s_asd_rpg_start.target, "targetname");
  s_asd_rpg_start_2 = getstruct("asd_rpg_start_2", "targetname");
  s_asd_rpg_end_2 = getstruct(s_asd_rpg_start_2.target, "targetname");
  s_asd_rpg_start_4 = getstruct("asd_rpg_start_4", "targetname");
  s_asd_rpg_end_4 = getstruct(s_asd_rpg_start_4.target, "targetname");
  magicbullet("metalstorm_launcher", s_asd_rpg_start.origin, s_asd_rpg_end.origin);
  magicbullet("metalstorm_launcher", s_asd_rpg_start_2.origin, s_asd_rpg_end_2.origin);
  magicbullet("metalstorm_launcher", s_asd_rpg_start_4.origin, s_asd_rpg_end_4.origin);
  wait 0.25;
  magicbullet("metalstorm_launcher", s_asd_rpg_start.origin, s_asd_rpg_end.origin);
}

asd_hallway_gunfire() {
  self endon("death");
  wait 2;
  e_asd_turret_target = getent("asd_turret_target", "targetname");
  s_asd_turret_target_end = getstruct("asd_turret_target_end", "targetname");
  self setturrettargetent(e_asd_turret_target);
  self thread metalstorm_fire_for_time(5);
  e_asd_turret_target moveto(s_asd_turret_target_end.origin, 5);
  wait 3;
  s_asd_hallway_target = getstruct("asd_hallway_target", "targetname");
  magicbullet("metalstorm_launcher", self gettagorigin("TAG_MISSILE1"), s_asd_hallway_target.origin);
  wait 0.5;
  magicbullet("metalstorm_launcher", self gettagorigin("TAG_MISSILE1"), s_asd_hallway_target.origin);
}

vo_player_asd() {
  level endon("stop_shelf_fxanim");
  trigger_wait("asd_flank_explosions");
  e_lab_shelf_clip_show = getent("lab_shelf_clip_show", "targetname");
  e_lab_shelf_clip_show show();
  e_lab_shelf_clip_show solid();
  e_lab_shelf_clip_hide = getent("lab_shelf_clip_hide", "targetname");
  e_lab_shelf_clip_hide hide();
  e_lab_shelf_clip_hide notsolid();
  level notify("fxanim_flank_start");
  s_flank_physics = getstruct("s_flank_physics", "targetname");
  physicsexplosionsphere(s_flank_physics.origin, 64, 32, 0.3);
  earthquake(0.2, 0.3, level.player.origin, 128);
  level.player playrumbleonentity("damage_heavy");
  s_asd_rpg_start_3 = getstruct("asd_rpg_start_3", "targetname");
  s_asd_rpg_end_3 = getstruct(s_asd_rpg_start_3.target, "targetname");
  magicbullet("metalstorm_launcher", s_asd_rpg_start_3.origin, s_asd_rpg_end_3.origin);
}

asd_lobby_think() {
  self endon("death");
  self thread asd_hallway_gunfire();
  self setcandamage(0);
  self veh_magic_bullet_shield(1);
  self maps\_metal_storm::metalstorm_stop_ai();
  nd_start_node = getvehiclenode(self.target, "targetname");
  self thread go_path(nd_start_node);
  self waittill("reached_end_node");
  self setspeed(0, 3, 2);
  flag_wait("end_player_asd_anim");
  self maps\_vehicle::vehicle_pathdetach();
  self setcandamage(1);
  self veh_magic_bullet_shield(0);
  self thread asd_health_watch();
  s_asd_tutorial_spot = getstruct("asd_tutorial_spot", "targetname");
  self setvehgoalpos(s_asd_tutorial_spot.origin, 1, 2, 1);
  self waittill_any("goal", "near_goal");
  self maps\_vehicle::defend(s_asd_tutorial_spot.origin, 128);
}

asd_lobby_guys() {
  level thread asd_tutorial_timeout();
  level thread lab_doors();
  level thread asd_battle_dialog();
  flag_wait("spawn_lobby_guys");
  flag_set("lab_lobby_doors");
  flag_set("asd_becomes_active");
  remove_hallway_ai_clip();
  trigger_use("trig_spawn_lobby_guys");
  wait 0.05;
  level thread asd_battle_enemy_vo();
  level thread monitor_lobby_frontline();
  use_trigger_on_group_count("lobby_guys", "trig_color_lobby_front", 7);
  use_trigger_on_group_count("lobby_guys", "trig_color_lobby_mid", 5, 1);
  use_trigger_on_group_count("lobby_guys", "trig_lab_1_1_color_cleared", 3);
  level thread fallback_on_ai_count("lobby_guys", 2, "lobby_guys_fallback");
  level thread color_trig_cleanup();
}

lab_battle_enemy_vo() {
  flag_wait("lab_battle_vo_start");
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub0_they_re_coming_up_th_0", 1.0);
  wait 0.25;
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub2_stay_on_the_balconie_0", 0.5);
  flag_wait("lab_battle_mid_vo");
  wait 0.25;
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub3_don_t_let_them_move_0", 1.0);
  flag_wait("player_enemy_lift_vo");
  wait 0.25;
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub1_there_headed_for_t_0", 1.0);
}

asd_battle_enemy_vo() {
  level endon("start_lift_move_down");
  flag_wait("spawn_lobby_guys");
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub3_we_re_under_attack_0", 0.5);
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub0_enemy_forces_have_br_0", 2.0);
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub1_sound_the_evacuation_0", 1.0);
  flag_set("start_lab_pa_alarm");
}

asd_battle_dialog() {
  level.harper queue_dialog("harp_its_front_is_too_tou_0", 0);
  level.player queue_dialog("sect_spread_out_clear_t_0", 0.25);
  waittill_ai_group_ai_count("lobby_guys", 5);
  flag_set("kill_asd_flank_vo");
  level.player queue_dialog("sect_upstairs_go_0", 0.2, "player_upstairs_vo");
  waittill_ai_group_cleared("lobby_guys");
  level.player queue_dialog("sect_keep_pushing_0", 0.5);

  if(is_mature())
    level.harper queue_dialog("harp_they_sure_as_hell_do_0", 0.5);
  else
    level.harper queue_dialog("harp_they_definitely_don_0", 0.5);
}

color_trig_cleanup() {
  trigger_wait("trig_color_lobby_mid");
  trig_left_lobby_guy = getent("trig_left_lobby_guy", "targetname");

  if(isDefined(trig_left_lobby_guy))
    trig_left_lobby_guy delete();

  trig_right_lobby_guy = getent("trig_right_lobby_guy", "targetname");

  if(isDefined(trig_left_lobby_guy))
    trig_right_lobby_guy delete();
}

remove_hallway_ai_clip() {
  e_asd_hallway_clip = getent("asd_hallway_clip", "targetname");
  e_asd_hallway_clip connectpaths();
  e_asd_hallway_clip delete();
}

lobby_upstairs_doors() {
  e_right_lobby_top_door = getent("right_lobby_top_door", "targetname");
  e_right_lobby_top_door ignorecheapentityflag(1);
  bm_right_lobby_top_door_clip = getent("right_lobby_top_door_clip", "targetname");
  e_left_lobby_top_door = getent("left_lobby_top_door", "targetname");
  e_left_lobby_top_door ignorecheapentityflag(1);
  bm_left_lobby_top_door_clip = getent("left_lobby_top_door_clip", "targetname");
  bm_right_lobby_top_door_clip linkto(e_right_lobby_top_door);
  bm_left_lobby_top_door_clip linkto(e_left_lobby_top_door);
  bm_right_lobby_top_door_clip connectpaths();
  e_right_lobby_top_door connectpaths();
  bm_left_lobby_top_door_clip connectpaths();
  e_left_lobby_top_door connectpaths();
  trigger_wait("trig_upstairs_doors");
  e_right_lobby_top_door movex(55, 0.5);
  e_left_lobby_top_door movex(-55, 0.5);
}

left_lobby_door() {
  e_left_lobby_door = getent("left_lobby_door", "targetname");
  e_left_lobby_door ignorecheapentityflag(1);
  bm_left_lobby_door_clip = getent("left_lobby_door_clip", "targetname");
  bm_left_lobby_door_clip linkto(e_left_lobby_door);
  bm_left_lobby_door_clip connectpaths();
  e_left_lobby_door connectpaths();
  trigger_wait("trig_left_lobby_door");
  e_left_lobby_door movey(57, 0.5);
}

right_lobby_door() {
  e_right_lobby_door = getent("right_lobby_door", "targetname");
  e_right_lobby_door ignorecheapentityflag(1);
  bm_right_lobby_door_clip = getent("right_lobby_door_clip", "targetname");
  bm_right_lobby_door_clip linkto(e_right_lobby_door);
  bm_right_lobby_door_clip connectpaths();
  e_right_lobby_door connectpaths();
  trigger_wait("trig_right_lobby_door");
  e_right_lobby_door movey(-57, 0.5);
}

lab_doors() {
  level thread lab_2_1_left_door();
  level thread lab_2_1_right_door();
  level thread lobby_upstairs_doors();
  level thread left_lobby_door();
  level thread right_lobby_door();
}

lab_2_1_left_door() {
  e_left_2_1_door = getent("left_2_1_door", "targetname");
  e_left_2_1_door ignorecheapentityflag(1);
  bm_left_2_1_door_clip = getent("left_2_1_door_clip", "targetname");
  bm_left_2_1_door_clip linkto(e_left_2_1_door);
  e_left_2_1_door connectpaths();
  bm_left_2_1_door_clip connectpaths();
  trigger_wait("trig_left_2_1_door");
  e_left_2_1_door movex(-55, 0.5);
}

lab_2_1_right_door() {
  e_right_2_1_door = getent("right_2_1_door", "targetname");
  e_right_2_1_door ignorecheapentityflag(1);
  bm_right_2_1_door_clip = getent("right_2_1_door_clip", "targetname");
  bm_right_2_1_door_clip linkto(e_right_2_1_door);
  e_right_2_1_door connectpaths();
  bm_right_2_1_door_clip connectpaths();
  trigger_wait("trig_right_2_1_door");
  e_right_2_1_door movex(55, 0.5);
}

monitor_lobby_frontline() {
  waittill_ai_group_amount_killed("lobby_guys", 2);
  flag_set("asd_becomes_active");
  flag_set("start_asd_battle");
}

asd_tutorial_timeout() {
  level endon("spawn_lobby_guys");
  wait 4.5;
  trigger_use("trig_color_lobby_front");
  flag_set("asd_becomes_active");
  flag_set("spawn_lobby_guys");
}

asd_health_watch() {
  self endon("death");

  while(self.health > 100)
    wait 0.05;

  trigger_use("trig_color_lobby_front");
  flag_set("asd_becomes_active");
  flag_set("spawn_lobby_guys");
}

player_nitrogen_death(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
  if(smeansofdeath == "MOD_GAS") {
    if(isDefined(level.player.b_been_frozen) && level.player.b_been_frozen)
      return 0;
    else {
      level.dont_save_now = 1;
      level.player.b_been_frozen = 1;
      level.player.ignoreme = 1;
      level.player shellshock("default", 8);
      rpc("clientscripts/monsoon", "FROST_filter_over_time", 3.5, 0, 1);
      level thread run_scene("player_nitrogen_death");
      wait 3.5;
    }

    idamage = level.player.health + 100;
  }

  return idamage;
}

lab_battle_main() {
  level thread inside_lift_init();
  flag_wait("start_asd_battle");
  level thread server_and_modem_machines();
  level thread spawn_ambient_asd();
  level thread lab_color_triggers();
  level thread elevator_transition();
  autosave_by_name("lab_1_1_battle");
  level thread first_floor_lab_main();
  level thread second_floor_lab_main();
  flag_wait("start_lift_move_down");
}

spawn_ambient_asd() {
  level endon("end_ambient_asd");
  trigger_wait("trig_spawn_ambient_2_1_asd");
  spawn_vehicle_from_targetname("asd_ambient_2_1");
}

setup_ambient_2_1_asd() {
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self veh_magic_bullet_shield(1);
  self maps\_metal_storm::metalstorm_stop_ai();
  nd_start_node = getvehiclenode(self.target, "targetname");
  self thread go_path(nd_start_node);
  self waittill("reached_end_node");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

lab_color_triggers() {
  a_lab_color_triggers = getentarray("lab_color_triggers", "script_noteworthy");

  foreach(trigger in a_lab_color_triggers)
  trigger thread notify_targeted_trigger();

  a_lower_lab_color_triggers = getentarray("lower_lab_color_triggers", "script_noteworthy");

  foreach(trigger in a_lower_lab_color_triggers)
  trigger thread notify_targeted_trigger();
}

notify_targeted_trigger() {
  self waittill("trigger");
  e_trig_split_path = getent(self.target, "targetname");
  e_trig_split_path useby(level.player);
}

lab_spawn_funcs() {
  ai_isaac = getent("isaac", "targetname");
  ai_isaac add_spawn_function(::setup_isaac);
  ai_window_jumper = getent("window_jumper", "targetname");
  ai_window_jumper add_spawn_function(::init_window_jumper);
  a_lab_scientist = getentarray("ambient_lab_scientists", "script_noteworthy");
  array_thread(a_lab_scientist, ::add_spawn_function, ::init_lab_scientists);
  ai_left_lobby_guy = getent("left_lobby_guy", "script_noteworthy");
  ai_left_lobby_guy add_spawn_function(::trigger_left_lobby_color);
  ai_right_lobby_guy = getent("right_lobby_guy", "script_noteworthy");
  ai_right_lobby_guy add_spawn_function(::trigger_right_lobby_color);
  ai_escape_stair_guy = getent("escape_stair_guy", "targetname");
  ai_escape_stair_guy add_spawn_function(::init_escape_stair_guy);
  add_spawn_function_veh("nitrogen_asd", ::init_nitrogen_asd);
  add_spawn_function_veh("right_path_asd", ::init_right_path_asd);
  add_spawn_function_veh("asd_defend_1", maps\monsoon_lab_defend::init_defend_left_asd);
  add_spawn_function_veh("asd_defend_2", maps\monsoon_lab_defend::init_defend_right_asd);
  add_spawn_function_veh("asd_ambient_2_1", ::setup_ambient_2_1_asd);
  add_spawn_function_veh("right_path_asd", maps\monsoon_lab_defend::init_right_path_asd);
  a_guy_ragdoll_death = getentarray("guy_ragdoll_death", "script_noteworthy");
  array_thread(a_guy_ragdoll_death, ::add_spawn_function, ::init_guy_ragdoll_death);
  a_corpse_guy = getentarray("corpse_guy", "script_noteworthy");
  array_thread(a_corpse_guy, ::add_spawn_function, ::init_guy_ragdoll_death);
  e_crawl_back_guy = getent("crawl_back_guy", "targetname");
  e_crawl_back_guy add_spawn_function(::init_crawl_back_guy);
  a_ending_friendlies = getentarray("ending_friendlies", "script_noteworthy");
  array_thread(a_ending_friendlies, ::add_spawn_function, ::init_ending_friendlies);
}

init_ending_friendlies() {
  self endon("death");
  self magic_bullet_shield();
  self.ignoreme = 1;
  self.ignoreall = 1;
  self bloodimpact("none");
}

init_crawl_back_guy() {
  self endon("death");
  self.a.deathforceragdoll = 1;
  self.ignoreme = 1;
  self gun_remove();
  self gun_switchto("beretta93r_sp", "right");
  scene_wait("dying_crawl_back");
  self die();
}

init_guy_ragdoll_death() {
  self endon("death");
  self.ignoreme = 1;
  self gun_remove();
  self.a.deathforceragdoll = 1;
}

init_window_jumper() {
  self endon("death");
  scene_wait("window_jumper");
  nd_goal = getnode(self.target, "targetname");
  self force_goal(nd_goal, 64, 1);
}

setup_isaac() {
  self endon("death");
  level.isaac = self;
}

init_escape_stair_guy() {
  self endon("death");
  self.pacifist = 1;
  nd_goal = getnode(self.target, "targetname");
  self force_goal(nd_goal, 64);
  self waittill("goal");
  self.pacifist = 0;
}

monitor_nitrogen_asd_death() {
  level endon("nitrogen_asd_fallback_2");
  self waittill("death");
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc thread queue_dialog("cub3_they_took_out_the_as_0");
  flag_set("nitrogen_asd_is_dead");
  wait 4;
  trigger_use("trig_nitrogen_guys_half");
  use_trigger_on_group_clear("lab_nitrogen_guys", "trig_nitrogen_guys_cleared");
}

init_nitrogen_asd() {
  self endon("death");
  self.ignoreme = 1;
  self maps\_metal_storm::metalstorm_stop_ai();
  self thread asd_fire_on_lift();
  nd_start_node = getvehiclenode(self.target, "targetname");
  self thread go_path(nd_start_node);
  flag_wait("start_shooting_lift");
  self waittill("reached_end_node");
  self thread monitor_nitrogen_asd_death();
  flag_wait("lift_at_bottom");
  self maps\_vehicle::vehicle_pathdetach();
  self.ignoreme = 0;
  flag_wait("nitrogen_asd_fallback_1");
  s_nitrogen_asd_elevator_pos = getstruct("nitrogen_asd_fallback_pos_1", "targetname");
  self setvehgoalpos(s_nitrogen_asd_elevator_pos.origin, 1, 2, 1);
  self waittill_any("goal", "near_goal");
  self maps\_vehicle::defend(self.origin, 128);
}

asd_fire_on_lift() {
  self endon("death");
  s_asd_elevator_target = getstruct("asd_elevator_target", "targetname");
  e_asd_target_origin = spawn("script_origin", s_asd_elevator_target.origin);
  e_asd_target_origin.angles = s_asd_elevator_target.angles;
  s_end_asd_lift_target = getstruct("end_asd_lift_target", "targetname");
  self setturrettargetent(e_asd_target_origin);
  level thread lift_destruction();
  flag_wait("start_shooting_lift");
  level notify("fxanim_elevator_asd_dmg_start");
  self thread metalstorm_fire_for_time(4);
  e_asd_target_origin moveto(s_end_asd_lift_target.origin, 3.5);
  s_lift_asd_target_1 = getstruct("lift_asd_target_1", "targetname");
  s_lift_asd_target_2 = getstruct("lift_asd_target_2", "targetname");
  s_lift_asd_target_3 = getstruct("lift_asd_target_3", "targetname");
  e_asd_target_origin waittill("movedone");
  wait 0.4;
  self thread metalstorm_fire_for_time(4);
  e_asd_target_origin moveto(s_asd_elevator_target.origin, 3.5);
  e_asd_target_origin waittill("movedone");
  self clearturrettarget();
  self thread metalstorm_weapon_think();
}

lift_destruction() {
  e_left_window = getent("lift_interior_window_1_left_m", "targetname");
  e_left_window thread elevator_damage_watch("p6_monsoon_ext_elevator_glass_lft_broken", 3401);
  e_right_window = getent("lift_interior_window_1_right_m", "targetname");
  e_right_window thread elevator_damage_watch("p6_monsoon_ext_elevator_glass_rt_broken", 3404);
  m_door_north_r = getent("lift_interior_door_1_right_m", "targetname");
  m_door_north_r thread elevator_damage_watch("p6_monsoon_ext_elevator_door_broken", 3402);
  m_door_north_l = getent("lift_interior_door_1_left_m", "targetname");
  m_door_north_l thread elevator_damage_watch("p6_monsoon_ext_elevator_door_broken", 3403);
}

elevator_damage_watch(str_model_swap, n_exploder) {
  self endon("lift_model_broken");
  self setcandamage(1);
  self.b_model_broken = 0;
  self waittill("damage", num_damage, e_attacker);
  flag_set("set_off_hallway_destruction");

  if(!self.b_model_broken) {
    if(isDefined(e_attacker) && isDefined(e_attacker.targetname) && e_attacker.targetname == "nitrogen_asd") {
      exploder(n_exploder);
      self setmodel(str_model_swap);
      self.b_model_broken = 1;
      self notify("lift_model_broken");
    }
  }
}

init_right_path_asd() {
  self endon("death");
  self thread monitor_right_path_asd_death();
  self thread player_asd_rumble();
  nd_start_node = getvehiclenode(self.target, "targetname");
  self thread go_path(nd_start_node);
  self thread metalstorm_weapon_think();
  self waittill("reached_end_node");
  self maps\_vehicle::vehicle_pathdetach();
  s_right_path_asd_attack_pos = getstruct("right_path_asd_attack_pos", "targetname");
  self maps\_vehicle::defend(s_right_path_asd_attack_pos.origin, 128);
  flag_wait("right_path_asd_fallback");
  s_right_path_asd_fallback = getstruct("right_path_asd_fallback", "targetname");
  self setvehgoalpos(s_right_path_asd_fallback.origin, 1, 2, 1);
  self waittill_any("goal", "near_goal");
  self maps\_vehicle::defend(self.origin, 128);
}

monitor_right_path_asd_death() {
  self waittill("death");
  flag_set("right_path_asd_destroyed");
}

trigger_left_lobby_color() {
  level endon("stop_lobby_color_think");
  self waittill("death");
  trigger_use("trig_left_lobby_guy", "targetname", level.player, 0);
}

trigger_right_lobby_color() {
  level endon("stop_lobby_color_think");
  self waittill("death");
  trigger_use("trig_right_lobby_guy", "targetname", level.player, 0);
}

init_lab_scientists() {
  self endon("death");
  self.team = "neutral";
  self.goalradius = 64;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.ignoresuppression = 1;
  self.grenadeawareness = 0;
  self gun_remove();
  nd_delete_kill = getnode(self.target, "targetname");
  self setgoalpos(nd_delete_kill.origin);
  self thread lab_scientist_screams();
  self waittill_notify_or_timeout("goal", 10);

  if(self cansee(level.player))
    self die();
  else
    self delete();
}

lab_scientist_screams() {
  self endon("death");
  wait(randomintrange(1, 4));
  self playsound("vox_scientist_screams");
}

window_jumper() {
  level endon("end_ambient_asd");
  trigger_wait("trig_window_jumper");
  s_window_jumper_target = getstruct("window_jumper_target", "targetname");
  s_window_jumper_target_end = getstruct(s_window_jumper_target.target, "targetname");
  magicbullet("scar_sp", s_window_jumper_target.origin, s_window_jumper_target_end.origin);
  magicbullet("scar_sp", s_window_jumper_target.origin, s_window_jumper_target_end.origin);
  magicbullet("scar_sp", s_window_jumper_target.origin, s_window_jumper_target_end.origin);
  magicbullet("scar_sp", s_window_jumper_target.origin, s_window_jumper_target_end.origin);
  run_scene("window_jumper");
}

first_floor_lab_main() {
  level thread harper_speed_up();
  level thread harper_railing_throw();
  level thread window_jumper();
  level thread first_floor_kill_trig();
  trigger_wait("trig_sm_lab_1_1_frontline");
  wait 0.05;
  flag_set("stop_lobby_color_think");
  level thread monitor_lab_1_1_frontline();
  level thread monitor_lab_1_1();
  use_trigger_on_group_count("lab_1_1_frontline", "trig_lab_1_1_frontline_half", 2);
  use_trigger_on_group_clear("lab_1_1_frontline", "trig_lab_1_1_color_frontline_cleared");
  trigger_wait("trig_sm_lab_1_1");
  wait 0.05;
  use_trigger_on_group_count("lab_1_1_guys", "trig_lab_1_1_guys_half", 1);
  trigger_wait("trig_sm_lab_1_2_frontline");
  wait 0.05;
  use_trigger_on_group_count("lab_1_2_frontline", "trig_lab_1_2_frontline_half", 2);
  trigger_wait("trig_sm_lab_1_2");
  wait 0.05;
  use_trigger_on_group_count("lab_1_2_guys", "trig_lab_1_2_guys_half", 2);
  use_trigger_on_group_clear("lab_1_2_guys", "trig_lab_1_2_guys_cleared");
}

first_floor_kill_trig() {
  flag_wait("player_crosby_path");
  first_floor_kill_trig = getent("first_floor_kill_trig", "targetname");
  a_axis_ai = getaiarray("axis");

  foreach(ai in a_axis_ai) {
    if(ai istouching(first_floor_kill_trig)) {
      ai.a.deathforceragdoll = 1;
      ai die();
    }
  }
}

second_floor_kill_trig() {
  flag_wait("player_first_floor_path");
  second_floor_kill_trig = getent("second_floor_kill_trig", "targetname");
  a_axis_ai = getaiarray("axis");

  foreach(ai in a_axis_ai) {
    if(ai istouching(second_floor_kill_trig)) {
      ai.a.deathforceragdoll = 1;
      ai die();
    }
  }
}

right_path_kill_trig() {
  flag_wait("player_harps_path");
  right_path_kill_trig = getent("right_path_kill_trig", "targetname");
  a_axis_ai = getaiarray("axis");

  foreach(ai in a_axis_ai) {
    if(ai istouching(right_path_kill_trig)) {
      ai.a.deathforceragdoll = 1;
      ai die();
    }
  }
}

harp_path_kill_trig() {
  flag_wait("player_at_right_path");
  harp_path_kill_trig = getent("harp_path_kill_trig", "targetname");
  a_axis_ai = getaiarray("axis");

  foreach(ai in a_axis_ai) {
    if(ai istouching(harp_path_kill_trig)) {
      ai.a.deathforceragdoll = 1;
      ai die();
    }
  }
}

harper_speed_up() {
  level endon("salazar_crosby_speed_up");
  trigger_wait("trig_harper_speed_up");
  level notify("harper_speed_up");
  kill_spawnernum(205);
  kill_spawnernum(206);
  kill_spawnernum(207);
  trig_top_floor_volume = getent("trig_top_floor_volume", "targetname");
  a_axis_ai = getaiarray("axis");

  foreach(ai in a_axis_ai) {
    if(ai istouching(trig_top_floor_volume)) {
      ai.a.deathforceragdoll = 1;
      ai die();
    }
  }

  simple_spawn_single("harper_speed_up_victim", ::weaken_harper_victim);
  level.harper disable_ai_color(1);
  s_harper_speed_up_pos = getstruct("harper_speed_up_pos", "targetname");
  level.harper teleport(s_harper_speed_up_pos.origin, s_harper_speed_up_pos.angles);
  nd_harper_pre_lift = getnode("harper_pre_lift", "targetname");
  level.harper.goalradius = 32;
  level.harper setgoalnode(nd_harper_pre_lift);
}

weaken_harper_victim() {
  self endon("death");
  self.health = 1;
  self.attackeraccuracy = 10;
}

salazar_crosby_speed_up() {
  level endon("harper_speed_up");
  trigger_wait("trig_salazar_crosby_speed_up");
  level notify("salazar_crosby_speed_up");
  kill_spawnernum(208);
  kill_spawnernum(209);
  kill_spawnernum(210);
  kill_spawnernum(211);
  trig_bottom_floor_volume = getent("trig_bottom_floor_volume", "targetname");
  a_axis_ai = getaiarray("axis");

  foreach(ai in a_axis_ai) {
    if(ai istouching(trig_bottom_floor_volume)) {
      ai.a.deathforceragdoll = 1;
      ai die();
    }
  }

  level.salazar disable_ai_color(1);
  level.crosby disable_ai_color(1);
  s_salazar_speed_up_pos = getstruct("salazar_speed_up_pos", "targetname");
  s_crosby_speed_up_pos = getstruct("crosby_speed_up_pos", "targetname");
  level.salazar teleport(s_salazar_speed_up_pos.origin, s_salazar_speed_up_pos.angles);
  level.crosby teleport(s_crosby_speed_up_pos.origin, s_crosby_speed_up_pos.angles);
  nd_salazar_pre_lift = getnode("salazar_pre_lift", "targetname");
  level.salazar.goalradius = 32;
  level.salazar setgoalnode(nd_salazar_pre_lift);
  nd_crosby_pre_lift = getnode("crosby_pre_lift", "targetname");
  level.crosby.goalradius = 32;
  level.crosby setgoalnode(nd_crosby_pre_lift);
}

harper_railing_throw() {
  level endon("stop_harper_throw");
  trigger_wait("trig_harper_railing_throw");
  kill_spawnernum(206);
  trig_bottom_floor_volume = getent("trig_bottom_floor_volume", "targetname");

  if(level.player istouching(trig_bottom_floor_volume)) {
    trig_volume_harper_throw = getent("trig_volume_harper_throw", "targetname");
    a_axis_ai = getaiarray("axis");

    foreach(axis in a_axis_ai) {
      if(axis istouching(trig_volume_harper_throw)) {
        if(axis cansee(level.player)) {
          axis die();
          continue;
        }

        axis delete();
      }
    }

    level.harper bloodimpact("none");
    level.harper.ignoreme = 1;
    run_scene("harper_railing_throw");
    level.harper bloodimpact("hero");
    level.harper.ignoreme = 0;
    node_post_throw = getnode("node_post_throw", "targetname");
    level.harper setgoalnode(node_post_throw);
  }
}

monitor_lab_1_1_frontline() {
  waittill_ai_group_count("lab_1_1_frontline", 2);
  trigger_use("trig_sm_lab_1_1");
}

monitor_lab_1_1() {
  waittill_ai_group_count("lab_1_1_guys", 2);
  trigger_use("trig_sm_lab_1_2_frontline");
}

second_floor_lab_main() {
  level thread salazar_crosby_speed_up();
  level thread second_floor_kill_trig();
  trigger_wait("trig_sm_lab_2_1_frontline");
  wait 0.05;
  flag_set("stop_lobby_color_think");
  level thread killspawn_player_spawns();
  level thread monitor_harper_color_chains();
  level thread monitor_salazar_color_chains();
  level thread monitor_lab_2_1_frontline();
  use_trigger_on_group_count("lab_2_1_frontline", "trig_lab_2_1_frontline_half", 4);
  use_trigger_on_group_count("lab_2_1_frontline", "trig_lab_2_1_frontline_cleared", 3);
  trigger_wait("trig_sm_lab_2_1");
  wait 0.05;
  use_trigger_on_group_count("lab_2_1_guys", "trig_lab_2_1_guys_half", 3);
  autosave_by_name("mid_upper_level");
  kill_spawnernum(200);
  kill_spawnernum(201);
  trigger_wait("trig_sm_lab_2_2");
  wait 0.05;
  use_trigger_on_group_count("lab_2_2_guys", "trig_lab_2_2_guys_half", 2);
  use_trigger_on_group_count("lab_2_2_guys", "trig_lab_2_2_guys_cleared", 1);
  level thread monitor_lab_2_2();
}

killspawn_player_spawns() {
  trigger_wait("trig_lab_2_1_frontline_cleared");
  kill_spawnernum(200);
  kill_spawnernum(201);
}

monitor_harper_color_chains() {
  trigger_wait("trig_sm_lab_2_1_frontline");
  trigger_use("trig_sm_lab_1_1_frontline");
  trigger_wait("trig_lab_2_1_frontline_half");
  trigger_use("trig_sm_lab_1_1");
  level thread kill_ai_group("lobby_guys");
  trigger_wait("trig_lab_2_1_guys_half");
  trigger_use("trig_lab_1_1_guys_half");
  trigger_use("trig_sm_lab_1_2_frontline");
  level thread kill_ai_group("lab_2_1_frontline");
  trigger_wait("trig_lab_2_2_frontline_half");
  trigger_use("trig_sm_lab_1_2");
  level notify("stop_harper_throw");
  flag_set("stop_harper_throw");
}

kill_ai_group(str_ai_group) {
  a_str_ai_group = get_ai_group_ai(str_ai_group);

  foreach(guy in a_str_ai_group)
  guy die();
}

monitor_salazar_color_chains() {
  trigger_wait("trig_sm_lab_1_1_frontline");
  trigger_use("trig_sm_lab_2_1_frontline");
  trigger_wait("trig_lab_1_1_frontline_half");
  trigger_use("trig_lab_2_1_frontline_half");
  trigger_wait("trig_lab_1_1_color_frontline_cleared");
  trigger_use("trig_sm_lab_2_1");
  level thread kill_ai_group("lab_1_1_frontline");
  trigger_wait("trig_lab_1_1_guys_half");
  trigger_use("trig_sm_lab_2_2");
}

monitor_lab_2_1_frontline() {
  waittill_ai_group_count("lab_2_1_frontline", 2);
  trigger_use("trig_sm_lab_2_1");
}

monitor_lab_2_2() {
  trigger_wait("trig_sm_lab_2_1");
  waittill_ai_group_count("lab_2_2_guys", 2);
  trigger_use("trig_sm_lab_2_2");
}

init_lift_guys() {
  self endon("death");
  self.goalradius = 16;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.no_gib = 1;
  flag_wait("lift_at_top");
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.goalradius = 250;
  self set_spawner_targets("lift_attack_nodes");
}

monitor_lift_guys() {
  waittill_ai_group_cleared("lab_lift_guys");
  flag_set("lift_guys_cleared");
  ai_axis = getaiarray("axis");

  foreach(ai in ai_axis)
  ai die();
}

elevator_transition() {
  trigger_wait("interior_lift_trigger");
  autosave_by_name("elevator_trig");
  simple_spawn("lab_lift_guys", ::init_lift_guys);
  wait 0.05;
  level thread monitor_lift_guys();
  flag_set("start_lift_move_up");
  flag_wait("lift_at_top");
  flag_wait("lift_guys_cleared");
  autosave_by_name("lab_interior_elevator");
  setmusicstate("MONSOON_LAB_UPSTAIRS_CLEAR");

  foreach(hero in level.heroes)
  hero disable_ai_color(1);

  level thread elevator_harper_approach();
  level thread elevator_salazar_approach();
  level.harper thread harper_elevator_ride();
  level.salazar thread salazar_elevator_ride();
  level.crosby thread crosby_elevator_ride();
  flag_set("elevator_is_ready");
  e_trig_elevator_panel = getent("trig_elevator_panel", "targetname");
  e_trig_elevator_panel sethintstring(&"MONSOON_LIFT_PROMPT");
  e_trig_elevator_panel setcursorhint("HINT_NOICON");
  e_trig_elevator_panel waittill("trigger");
  e_trig_elevator_panel sethintstring("");
  level thread lift_hack_visor_text();
  end_scene("harper_elevator_enter");
  end_scene("harper_elevator_idle");
  end_scene("salazar_elevator_enter");
  end_scene("salazar_elevator_idle");
  trigger_use("lift_ambush", "script_noteworthy", level.player, 0);
  clearallcorpses();
  flag_set("start_lift_move_down");
  setsaveddvar("bg_fallDamageMinHeight", 256);
  setsaveddvar("bg_fallDamageMaxHeight", 512);
  level thread run_scene("scientist_4");

  if(level.player ent_flag_exist("camo_suit_on") && level.player ent_flag("camo_suit_on"))
    level.player ent_flag_clear("camo_suit_on");

  delay_thread(0.05, maps\_camo_suit::data_glove_on, "player_lift_interact");
  run_scene("player_lift_interact");

  foreach(hero in level.heroes) {
    hero disable_pain();
    hero monsoon_hero_rampage(1);
    hero bloodimpact("none");
  }

  level.harper idle_at_cover(0);
  level.salazar idle_at_cover(0);
  autosave_now("lift_going_down");
}

lift_hack_visor_text() {
  add_visor_text("MONSOON_HACKING_CHAMBER_DOOR", 0, "default", "medium");
  wait 2;
  remove_visor_text("MONSOON_HACKING_CHAMBER_DOOR");
}

elevator_harper_approach() {
  level endon("start_lift_move_down");
  nd_harper_pre_lift = getnode("harper_pre_lift", "targetname");
  level.harper.goalradius = 32;
  level.harper setgoalnode(nd_harper_pre_lift);
  level.harper waittill("goal");
  level.harper idle_at_cover(1);
  flag_set("harp_at_lift_node");
  flag_wait("sal_at_lift_node");
  flag_wait("harp_at_lift_node");
  wait 1;
  run_scene("harper_elevator_enter");
  flag_set("harper_lift_ready");
  level thread run_scene("harper_elevator_idle");
}

elevator_salazar_approach() {
  level endon("start_lift_move_down");
  nd_salazar_pre_lift = getnode("salazar_pre_lift", "targetname");
  level.salazar.goalradius = 32;
  level.salazar setgoalnode(nd_salazar_pre_lift);
  level.salazar waittill("goal");
  level.salazar idle_at_cover(1);
  flag_set("sal_at_lift_node");
  flag_wait("sal_at_lift_node");
  flag_wait("harp_at_lift_node");
  wait 1;
  run_scene("salazar_elevator_enter");
  flag_set("salazar_lift_ready");
  level thread run_scene("salazar_elevator_idle");
}

harper_elevator_ride() {
  flag_wait("start_lift_move_down");
  wait 0.75;
  level thread run_scene("harper_elevator_idle");
  flag_wait("start_elevator_exits");
  end_scene("harper_elevator_idle");
  delete_scene("harper_elevator_idle");
  run_scene("harper_elevator_exit");
  flag_set("nitrogen_asd_fallback_1");
  nd_harper_titus_node = getnode("harper_titus_node", "targetname");
  self setgoalnode(nd_harper_titus_node);
}

salazar_elevator_ride() {
  flag_wait("start_lift_move_down");
  wait 0.75;
  level thread run_scene("salazar_elevator_idle");
  flag_wait("start_elevator_exits");
  end_scene("salazar_elevator_idle");
  delete_scene("salazar_elevator_idle");
  e_elevator_regroup = getent("elevator_regroup", "targetname");
  self linkto(e_elevator_regroup);
  run_scene("salazar_elevator_exit");
  nd_lift_salazar = getnode("nd_lift_salazar", "targetname");
  self setgoalnode(nd_lift_salazar);
}

crosby_elevator_ride() {
  self.goalradius = 32;
  nd_crosby_lift_node = getnode("crosby_lift_node", "targetname");
  self setgoalnode(nd_crosby_lift_node);
  flag_set("crosby_lift_ready");
  flag_wait("start_lift_move_down");
  wait 0.75;
  level thread run_scene("crosby_elevator_idle");
  flag_wait("start_elevator_exits");
  end_scene("crosby_elevator_idle");
  delete_scene("crosby_elevator_idle");
  e_elevator_regroup = getent("elevator_regroup", "targetname");
  self linkto(e_elevator_regroup);
  run_scene("crosby_elevator_exit");
  nd_lift_crosby = getnode("nd_lift_crosby", "targetname");
  self setgoalnode(nd_lift_crosby);
  self waittill("goal");
}

inside_lift_init() {
  m_lift = getent("lift_interior_m", "targetname");
  e_lift_scanner = getent("lift_scanner", "targetname");
  e_lift_scanner linkto(m_lift);
  e_interior_lift_red_light = getent("interior_lift_red_light", "targetname");
  e_interior_lift_red_light linkto(m_lift);
  a_m_doors[0] = getent("lift_interior_door_2_left_m", "targetname");
  a_m_doors[1] = getent("lift_interior_door_2_right_m", "targetname");
  a_m_doors[2] = getent("lift_interior_door_1_left_m", "targetname");
  a_m_doors[3] = getent("lift_interior_door_1_right_m", "targetname");

  foreach(m_door in a_m_doors) {
    m_door ignorecheapentityflag(1);
    m_door setforcenocull();
    m_door linkto(m_lift);
  }

  a_m_glass[0] = getent("lift_interior_window_1_left_m", "targetname");
  a_m_glass[1] = getent("lift_interior_window_1_right_m", "targetname");
  a_m_glass[2] = getent("lift_interior_window_2_left_m", "targetname");
  a_m_glass[3] = getent("lift_interior_window_2_right_m", "targetname");
  a_m_glass[4] = getent("lift_interior_window_2_left_m", "targetname");
  a_m_glass[5] = getent("lift_interior_window_2_right_m", "targetname");

  foreach(m_glass in a_m_glass) {
    m_glass ignorecheapentityflag(1);
    m_glass linkto(m_lift);
  }

  a_bm_doors[0] = getent("lift_interior_door_2_left", "targetname");
  a_bm_doors[1] = getent("lift_interior_door_2_right", "targetname");
  a_bm_doors[2] = getent("lift_interior_door_1_left", "targetname");
  a_bm_doors[3] = getent("lift_interior_door_1_right", "targetname");

  for(i = 0; i < a_bm_doors.size; i++) {
    a_bm_doors[i] ignorecheapentityflag(1);
    a_bm_doors[i] linkto(a_m_doors[i]);
  }

  m_lift.a_right_nodes = getnodearray("interior_lift_right_nodes", "targetname");
  m_lift.a_left_nodes = getnodearray("interior_lift_left_nodes", "targetname");
  m_lift.v_lift_bottom = m_lift.origin;
  m_lift.v_lift_top = (m_lift.origin[0], m_lift.origin[1], getstruct("interior_lift_up", "targetname").origin[2]);
  wait 0.05;
  level thread inside_lift_move_up();
  level thread inside_lift_move_down();
}

lower_lab_level_vo() {
  flag_wait("start_shooting_lift");
  level.harper queue_dialog("harp_son_of_a_bitch_ano_0");
  flag_wait("lift_at_bottom");
  level.salazar queue_dialog("sala_target_the_nitrogen_0", 1);
  level.harper queue_dialog("harp_smart_thinking_sala_0", 0.5);
  flag_wait("set_ddm_objective");
  level.harper queue_dialog("harp_moving_left_0", 2);
  level.harper queue_dialog("harp_they_got_more_auto_t_0", 2.0);
  level.player queue_dialog("sect_push_through_em_1", 3.5);
  waittill_ai_group_cleared("ddm_guys");
  level.player queue_dialog("sect_okay_we_re_clear_0", 0.3);
}

lower_lab_enemy_vo() {
  flag_wait("start_shooting_lift");
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc thread queue_dialog("cub0_open_fire_1", 0.25);
  flag_wait("lift_at_bottom");
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub1_hold_the_hallway_1", 1.0);
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub2_don_t_let_them_advan_0", 2.0);
}

inside_lift_move_down() {
  level thread lower_lab_level_vo();
  flag_wait("start_lift_move_down");
  level thread lower_lab_enemy_vo();
  playsoundatposition("evt_elevator_close_2d", (0, 0, 0));
  e_player_elevator_top_clip = getent("player_elevator_top_clip", "targetname");
  e_player_elevator_top_clip disconnectpaths();
  e_player_elevator_top_clip solid();
  m_lift = getent("lift_interior_m", "targetname");
  interior_lift_top_connect_left = getnodearray("interior_lift_top_connect_left", "targetname");
  interior_lift_top_connect_right = getnodearray("interior_lift_top_connect_right", "targetname");
  array_func(m_lift.a_right_nodes, ::_interior_elevator_disconnect_nodes, interior_lift_top_connect_right);
  array_func(m_lift.a_left_nodes, ::_interior_elevator_disconnect_nodes, interior_lift_top_connect_left);
  bm_door_south_l = getent("lift_interior_door_1_left", "targetname");
  bm_door_south_r = getent("lift_interior_door_1_right", "targetname");
  bm_door_north_l = getent("lift_interior_door_2_left", "targetname");
  bm_door_north_r = getent("lift_interior_door_2_right", "targetname");
  m_door_south_l = getent("lift_interior_door_2_left_m", "targetname");
  m_door_south_r = getent("lift_interior_door_2_right_m", "targetname");
  m_door_north_l = getent("lift_interior_door_1_left_m", "targetname");
  m_door_north_r = getent("lift_interior_door_1_right_m", "targetname");
  m_door_south_l unlink();
  m_door_south_r unlink();
  m_door_north_l unlink();
  m_door_north_r unlink();
  bm_door_north_l unlink();
  bm_door_north_r unlink();
  bm_door_south_l unlink();
  bm_door_south_r unlink();
  m_door_south_l movey(-60, 2, 0.5);
  m_door_south_r movey(60, 2, 0.5);
  m_door_north_l movey(-60, 2, 0.5);
  m_door_north_r movey(60, 2, 0.5);
  bm_door_south_l movey(-60, 2, 0.5);
  bm_door_south_r movey(60, 2, 0.5);
  bm_door_north_l movey(-60, 2, 0.5);
  bm_door_north_r movey(60, 2, 0.5);
  bm_door_north_r waittill("movedone");
  playsoundatposition("evt_elevator_start", (0, 0, 0));
  level thread elevator_loop_n_stop_sounds();
  m_door_south_l linkto(m_lift);
  m_door_south_r linkto(m_lift);
  m_door_north_l linkto(m_lift);
  m_door_north_r linkto(m_lift);
  bm_door_north_l linkto(m_lift);
  bm_door_north_r linkto(m_lift);
  bm_door_south_l linkto(m_lift);
  bm_door_south_r linkto(m_lift);
  level.player playrumbleonentity("damage_heavy");
  level.player playrumblelooponentity("tank_rumble");
  level.player setcandamage(0);
  delay_thread(1, ::flag_set, "lift_pre_ambush_fire");
  delay_thread(2, ::flag_set, "spawn_nitrogen_guys");
  delay_thread(6, ::flag_set, "start_shooting_lift");
  delay_thread(5, ::flag_set, "start_elevator_exits");
  m_lift moveto(m_lift.v_lift_bottom, 8, 1.6, 1.6);
  m_lift waittill("movedone");
  level.player stoprumble("tank_rumble");
  level.player playrumbleonentity("damage_heavy");
  playsoundatposition("evt_elevator_open_2d", (0, 0, 0));
  e_player_elevator_bottom_clip = getent("player_elevator_bottom_clip", "targetname");
  e_player_elevator_bottom_clip connectpaths();
  e_player_elevator_bottom_clip delete();
  bm_door_north_l unlink();
  bm_door_north_r unlink();
  bm_door_south_l unlink();
  bm_door_south_r unlink();
  m_door_north_l unlink();
  m_door_north_r unlink();
  m_door_south_l unlink();
  m_door_south_r unlink();
  m_door_north_l movey(60, 2, 0.5);
  m_door_north_r movey(-60, 2, 0.5);
  m_door_south_l movey(60, 2, 0.5);
  m_door_south_r movey(-60, 2, 0.5);
  bm_door_north_l movey(60, 2, 0.5);
  bm_door_north_r movey(-60, 2, 0.5);
  bm_door_south_l movey(60, 2, 0.5);
  bm_door_south_r movey(-60, 2, 0.5);
  bm_door_south_r waittill("movedone");
  flag_set("lift_at_bottom");
  level.player setcandamage(1);
  bm_door_south_l linkto(m_lift);
  bm_door_south_r linkto(m_lift);
  bm_door_north_l linkto(m_lift);
  bm_door_north_r linkto(m_lift);
  m_door_south_l linkto(m_lift);
  m_door_south_r linkto(m_lift);
  m_door_north_l linkto(m_lift);
  m_door_north_r linkto(m_lift);
  interior_lift_bottom_connect_left = getnodearray("interior_lift_bottom_connect_left", "targetname");
  interior_lift_bottom_connect_right = getnodearray("interior_lift_bottom_connect_right", "targetname");
  array_func(m_lift.a_right_nodes, ::_interior_elevator_connect_nodes, interior_lift_bottom_connect_right);
  array_func(m_lift.a_left_nodes, ::_interior_elevator_connect_nodes, interior_lift_bottom_connect_left);
}

elevator_loop_n_stop_sounds() {
  elevator_ent_2 = spawn("script_origin", (0, 0, 0));
  elevator_ent_2 playloopsound("evt_elevator_loop", 2.5);
  wait 6;
  elevator_ent_2 stoploopsound(1);
  playsoundatposition("evt_elevator_stop", (9277, 57793, -943));
  elevator_ent_2 delete();
}

inside_lift_move_up() {
  m_lift = getent("lift_interior_m", "targetname");
  flag_wait("start_lift_move_up");
  elevator_ent = spawn("script_origin", (9385, 57792, -987));
  elevator_ent playloopsound("evt_elevator_loop_3d", 0.5);
  level thread elevator_stop_1_sound(elevator_ent);
  m_lift play_fx("lift_light", m_lift.origin, m_lift.angles, undefined, 1);
  s_elevator_spotight_struct = getstruct("elevator_spotight_struct", "targetname");
  array_func(m_lift.a_right_nodes, ::node_disconnect_from_path);
  array_func(m_lift.a_left_nodes, ::node_disconnect_from_path);
  bm_door_south_l = getent("lift_interior_door_1_left", "targetname");
  bm_door_south_r = getent("lift_interior_door_1_right", "targetname");
  bm_door_north_l = getent("lift_interior_door_2_left", "targetname");
  bm_door_north_r = getent("lift_interior_door_2_right", "targetname");
  m_door_south_l = getent("lift_interior_door_2_left_m", "targetname");
  m_door_south_r = getent("lift_interior_door_2_right_m", "targetname");
  m_door_north_l = getent("lift_interior_door_1_left_m", "targetname");
  m_door_north_r = getent("lift_interior_door_1_right_m", "targetname");
  m_lift moveto(m_lift.v_lift_top, 8, 1.6, 1.6);
  m_lift waittill("movedone");
  playsoundatposition("evt_elevator_open", (9403, 57800, -929));
  e_player_elevator_top_clip = getent("player_elevator_top_clip", "targetname");
  e_player_elevator_top_clip connectpaths();
  e_player_elevator_top_clip notsolid();
  m_door_south_l unlink();
  m_door_south_r unlink();
  m_door_north_l unlink();
  m_door_north_r unlink();
  bm_door_north_l unlink();
  bm_door_north_r unlink();
  bm_door_south_l unlink();
  bm_door_south_r unlink();
  m_door_north_l movey(60, 2, 0.5);
  m_door_north_r movey(-60, 2, 0.5);
  m_door_south_l movey(60, 2, 0.5);
  m_door_south_r movey(-60, 2, 0.5);
  bm_door_north_l movey(60, 2, 0.5);
  bm_door_north_r movey(-60, 2, 0.5);
  bm_door_south_l movey(60, 2, 0.5);
  bm_door_south_r movey(-60, 2, 0.5);
  bm_door_north_r waittill("movedone");
  bm_door_north_l linkto(m_lift);
  bm_door_north_r linkto(m_lift);
  bm_door_south_l linkto(m_lift);
  bm_door_south_r linkto(m_lift);
  m_door_north_l linkto(m_lift);
  m_door_north_r linkto(m_lift);
  m_door_south_l linkto(m_lift);
  m_door_south_r linkto(m_lift);
  flag_set("lift_at_top");
  e_elevator_regroup = getent("elevator_regroup", "targetname");
  e_elevator_regroup linkto(m_lift);
  interior_lift_top_connect_left = getnodearray("interior_lift_top_connect_left", "targetname");
  interior_lift_top_connect_right = getnodearray("interior_lift_top_connect_right", "targetname");
  array_func(m_lift.a_right_nodes, ::_interior_elevator_connect_nodes, interior_lift_top_connect_right);
  array_func(m_lift.a_left_nodes, ::_interior_elevator_connect_nodes, interior_lift_top_connect_left);
}

elevator_stop_1_sound(elevator_ent) {
  wait 6;
  elevator_ent stoploopsound(0.5);
  playsoundatposition("evt_elevator_stop_3d", (9277, 57793, -943));
}

_interior_elevator_connect_nodes(a_nodes) {
  foreach(nd_node in a_nodes) {
    linknodes(self, nd_node);
    linknodes(nd_node, self);
  }
}

_interior_elevator_disconnect_nodes(a_nodes) {
  foreach(nd_node in a_nodes) {
    unlinknodes(self, nd_node);
    unlinknodes(nd_node, self);
  }
}

ddm_machines() {
  e_ddm_machine_1 = getent("DDM_1", "targetname");
  e_ddm_machine_1.animname = "ddm_1";
  e_ddm_machine_1 useanimtree(level.scr_animtree["ddm_1"]);
  e_ddm_machine_1 thread anim_loop(e_ddm_machine_1, "ddm_machine_1_loop");
  n_rand_wait = randomintrange(2, 4);
  wait(n_rand_wait);
  e_ddm_machine_2 = getent("DDM_2", "targetname");
  e_ddm_machine_2.animname = "ddm_2";
  e_ddm_machine_2 useanimtree(level.scr_animtree["ddm_2"]);
  e_ddm_machine_2 thread anim_loop(e_ddm_machine_2, "ddm_machine_2_loop");
  flag_wait("player_at_isaac");
  e_ddm_machine_1 thread anim_loop(e_ddm_machine_1, "ddm_machine_1_fast_loop");
  e_ddm_machine_2 thread anim_loop(e_ddm_machine_2, "ddm_machine_2_fast_loop");
}

server_and_modem_machines() {
  e_fxanim_server_arm_loop = getent("fxanim_server_arm_loop", "targetname");
  e_fxanim_server_arm_loop.animname = "server_arm";
  e_fxanim_server_arm_loop useanimtree(level.scr_animtree["server_arm"]);
  e_fxanim_server_arm_modems = getent("fxanim_server_arm_modems", "targetname");
  e_fxanim_server_arm_modems.animname = "modem";
  e_fxanim_server_arm_modems useanimtree(level.scr_animtree["modem"]);
  level notify("fxanim_server_arm_loop_start");
}

ddm_start_harpers_shield(ddm_machine) {
  if(flag("harper_ddm_ready")) {
    ddm_machine attach("t6_wpn_shield_carry_world", "J_shield_extend_attach_tag");
    ddm_machine anim_single(ddm_machine, "ddm_machine_1_extend");
    ddm_machine detach("t6_wpn_shield_carry_world", "J_shield_extend_attach_tag");
    e_harpers_shield = getent("harper_shield", "targetname");
    e_harpers_shield show();
    flag_set("harper_shield_is_ready");
    scene_wait("harper_shield_plant");
    ddm_machine anim_single(ddm_machine, "ddm_machine_1_retract");
    wait 1;
    ddm_machine thread anim_loop(ddm_machine, "ddm_machine_1_loop");
    flag_clear("harper_ddm_ready");
  }
}

ddm_start_players_shield(ddm_machine) {
  if(flag("player_ddm_ready")) {
    ddm_machine attach("t6_wpn_shield_carry_world", "J_shield_extend_attach_tag");
    ddm_machine anim_single(ddm_machine, "ddm_machine_2_extend");
    ddm_machine detach("t6_wpn_shield_carry_world", "J_shield_extend_attach_tag");
    run_scene_first_frame("player_defend_shield");
    flag_set("player_shield_is_ready");
    scene_wait("player_shield_grab");
    ddm_machine anim_single(ddm_machine, "ddm_machine_2_retract");
    wait 1;
    ddm_machine thread anim_loop(ddm_machine, "ddm_machine_2_loop");
    flag_clear("player_ddm_ready");
  }
}

init_lab_nitrogen_guys_back_up() {
  self endon("death");
  self.goalradius = 32;
  flag_wait("set_ddm_objective");
  self.goalradius = 250;
}

fight_to_isaac_main() {
  flag_wait("spawn_nitrogen_guys");
  level thread maps\_audio::switch_music_wait("MONSOON_NITROGEN_GUYS", 6);
  level.vh_nitrogen_asd = spawn_vehicle_from_targetname("nitrogen_asd");
  simple_spawn("lab_nitrogen_guys", ::init_lab_nitrogen_guys);
  simple_spawn("nitrogen_scientists");
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc thread queue_dialog("cub3_here_they_come_0", 0.25);
  level thread maps\monsoon_lab_defend::player_isaac_container();
  flag_wait("lift_at_bottom");
  level thread right_path_kill_trig();
  level thread harp_path_kill_trig();
  level thread run_scene("lab_corpse_1_loop");
  level thread run_scene("lab_corpse_2_loop");
  level thread run_scene("lab_corpse_3_loop");
  level.player.overrideplayerdamage = ::player_nitrogen_death;
  level thread ddm_machines();
  vh_left_path_turret = spawn_vehicle_from_targetname("left_path_turret");
  vh_left_path_turret thread maps\_cic_turret::cic_turret_off();
  vh_left_path_turret thread monitor_left_path_turret_death();
  level thread watch_harp_at_turret();
  autosave_by_name("lift_at_bottom");
  level thread asd_nitrogen_challenge_watch();

  foreach(hero in level.heroes)
  hero enable_ai_color();

  level thread reverse_hero_rampage();
  simple_spawn("lab_nitrogen_guys_back_up", ::init_lab_nitrogen_guys_back_up);
  level thread monitor_nitrogen_guys();
  use_trigger_on_group_count("lab_nitrogen_guys", "trig_nitrogen_guys_half", 1);
  trigger_wait("trig_lab_3_1_sm");
  flag_set("set_ddm_objective");
  level thread run_scene("cower_3_loop");
  level thread run_scene("lab_cower_1_loop");
  level thread monitor_lower_level_ai_groups("3_1_left_path", "3_1_left_path_cleared");
  level thread monitor_lower_level_ai_groups("3_1_right_path", "3_1_right_path_cleared");
  vh_left_path_turret = getent("left_path_turret", "script_noteworthy");

  if(isDefined(vh_left_path_turret))
    vh_left_path_turret thread maps\_cic_turret::cic_turret_on();

  use_trigger_on_group_count("3_1_left_path", "trig_3_1_left_cleared", 1);
  use_trigger_on_group_clear("3_1_right_path", "trig_3_1_right_cleared");
  trigger_wait("trig_lab_3_2_sm");
  autosave_by_name("mid_lower_level");
  level thread monitor_lower_level_ai_groups("3_2_left_path", "3_2_left_path_cleared");
  level thread monitor_lower_level_ai_groups("3_2_right_path", "3_2_right_path_cleared");
  level.vh_right_path_asd = spawn_vehicle_from_targetname("right_path_asd");
  level thread watch_sal_at_asd();

  if(isDefined(level.vh_nitrogen_asd))
    level.vh_nitrogen_asd notify("death");

  use_trigger_on_group_count("3_2_right_path", "trig_3_2_right_half", 2);
  use_trigger_on_group_clear("3_2_right_path", "trig_3_2_right_cleared");
  use_trigger_on_group_count("3_2_left_path", "trig_3_2_left_half", 2);
  use_trigger_on_group_clear("3_2_left_path", "trig_3_2_left_cleared");
  trigger_wait("trig_end_of_lower_lab");

  if(isDefined(level.vh_right_path_asd))
    level.vh_right_path_asd notify("death");

  if(isDefined(vh_left_path_turret))
    vh_left_path_turret notify("death");

  level.harper.perfectaim = 1;
  level.salazar.perfectaim = 1;
  level.crosby.perfectaim = 1;
  level.harper.dontmelee = 1;
  level.salazar.dontmelee = 1;
  level.crosby.dontmelee = 1;
  waittill_ai_group_cleared("ddm_guys");
  setmusicstate("MONSOON_ISAAC");
  a_ai_axis = getaiarray("axis");

  foreach(ai in a_ai_axis)
  ai die();

  nd_harper_pre_ddm = getnode("harper_pre_ddm", "targetname");
  nd_salazar_pre_ddm = getnode("salazar_pre_ddm", "targetname");
  nd_crosby_pre_ddm = getnode("crosby_pre_ddm", "targetname");
  level.harper thread regroup_pre_ddm(nd_harper_pre_ddm, "harper_pre_ddm");
  level.salazar thread regroup_pre_ddm(nd_salazar_pre_ddm, "salazar_pre_ddm");
  level.crosby thread regroup_pre_ddm(nd_crosby_pre_ddm, "crosby_pre_ddm");
  flag_wait("harper_pre_ddm");
  flag_wait("salazar_pre_ddm");
  flag_wait("crosby_pre_ddm");
  flag_wait("player_at_lab_defend");
  wait 1;
  flag_set("start_lab_defend");
}

watch_harp_at_turret() {
  level endon("start_lab_defend");
  flag_wait("harper_at_turret");
  vh_left_path_turret = getent("left_path_turret", "script_noteworthy");

  if(isDefined(vh_left_path_turret))
    vh_left_path_turret notify("death");
}

watch_sal_at_asd() {
  level endon("start_lab_defend");
  flag_wait("sal_at_asd_vol");

  if(isDefined(level.vh_right_path_asd))
    level.vh_right_path_asd notify("death");

  trig_sal_at_asd_vol = getent("sal_at_asd_vol", "targetname");
  a_axis_ai = getaiarray("axis");

  foreach(ai in a_axis_ai) {
    if(ai istouching(trig_sal_at_asd_vol)) {
      ai.a.deathforceragdoll = 1;
      ai die();
    }
  }
}

regroup_pre_ddm(nd_node, str_goal_flag) {
  self.goalradius = 16;
  self.grenadeawareness = 0;
  self.perfectaim = 0;
  self idle_at_cover(1);
  self.dontmelee = 0;
  self monsoon_hero_rampage(0);
  wait 0.05;
  self disable_ai_color(1);
  self setgoalnode(nd_node);
  self waittill("goal");
  flag_set(str_goal_flag);
}

monitor_left_path_turret_death() {
  self waittill("death");
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc thread queue_dialog("cub2_auto_turret_s_down_0", 1.0);
}

monitor_nitrogen_guys() {
  level endon("stop_nitrogen_think");
  waittill_ai_group_cleared("lab_nitrogen_guys");
  trigger_use("trig_nitrogen_guys_cleared");
}

init_lab_nitrogen_guys() {
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.goalradius = 32;
  flag_wait("start_shooting_lift");
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.goalradius = 250;
  self.script_accuracy = 0.5;
  wait 3;
  self.script_accuracy = 1.0;
}

reverse_hero_rampage() {
  trigger_wait("trig_nitrogen_guys_cleared");

  foreach(hero in level.heroes) {
    hero enable_pain();
    hero monsoon_hero_rampage(0);
    hero bloodimpact("hero");
  }
}

monitor_lower_level_ai_groups(str_group_name, str_group_flag) {
  waittill_ai_group_cleared(str_group_name);
  flag_set(str_group_flag);
}

fallback_on_ai_count(str_ai_group, n_count, str_fallback_nodes) {
  waittill_ai_group_ai_count(str_ai_group, n_count);
  a_str_ai_group = get_ai_group_ai(str_ai_group);

  foreach(guy_alive in a_str_ai_group) {
    guy_alive.pathenemyfightdist = 64;
    guy_alive.goalradius = 64;
    guy_alive thread ai_fallback_reengage(str_fallback_nodes);
  }
}

ai_fallback_reengage(str_spawner_target) {
  self endon("death");
  self set_ignoreall(1);
  self set_spawner_targets(str_spawner_target);
  self waittill("goal");
  self.goalradius = 200;
  self.pathenemyfightdist = 192;
  self set_ignoreall(0);
}

asd_nitrogen_challenge_watch() {
  level endon("lab_defend_done");
  level.n_asd_freeze_test = 0;

  while(true) {
    level waittill("asd_freezed");
    level.n_asd_freeze_test++;
    level notify("asd_frozen_challenge");
    wait 0.05;
  }
}

harper_titus_asd(ai_harper) {
  s_harper_titus_target = getstruct("harper_titus_target", "targetname");
  e_titus_target = spawn("script_origin", s_harper_titus_target.origin);
  e_titus_target.angles = s_harper_titus_target.angles;

  if(isDefined(level.vh_nitrogen_asd))
    ai_harper maps\_titus::magic_bullet_titus(level.vh_nitrogen_asd.origin + vectorscale((0, 0, 1), 40.0));
  else
    ai_harper maps\_titus::magic_bullet_titus(e_titus_target.origin);
}

challenge_camo_kills(str_notify) {
  while(true) {
    level waittill("camo_death");
    self notify(str_notify);
    wait 0.05;
  }
}

challenge_freeze_asds(str_notify) {
  while(true) {
    level waittill("asd_frozen_challenge");
    self notify(str_notify);
    wait 0.05;
  }
}

struct_1_spark(guy) {
  s_struct_1_spark = getstruct("struct_1_spark", "targetname");
  play_fx("fx_mon_heli_blade_sparks_sm", s_struct_1_spark.origin, s_struct_1_spark.angles);
}

struct_2_spark(guy) {
  s_struct_2_spark = getstruct("struct_2_spark", "targetname");
  play_fx("fx_mon_heli_blade_sparks_sm", s_struct_2_spark.origin, s_struct_2_spark.angles);
}

struct_3_spark(guy) {
  s_struct_3_spark = getstruct("struct_3_spark", "targetname");
  play_fx("fx_mon_heli_blade_sparks_sm", s_struct_3_spark.origin, s_struct_3_spark.angles);
}

struct_4_spark(guy) {
  s_struct_4_spark = getstruct("struct_4_spark", "targetname");
  play_fx("fx_mon_heli_blade_sparks_sm", s_struct_4_spark.origin, s_struct_4_spark.angles);
}

struct_5_spark(guy) {
  s_struct_5_spark = getstruct("struct_5_spark", "targetname");
  play_fx("fx_mon_heli_blade_sparks_sm", s_struct_5_spark.origin, s_struct_5_spark.angles);
}

struct_6_spark(guy) {
  s_struct_6_spark = getstruct("struct_6_spark", "targetname");
  play_fx("fx_mon_heli_blade_sparks_sm", s_struct_6_spark.origin, s_struct_6_spark.angles);
}