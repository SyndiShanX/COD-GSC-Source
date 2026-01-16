/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\monsoon_celerium_chamber.gsc
*********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\monsoon_util;
#include maps\_scene;
#include maps\_vehicle;
#include maps\_dialog;
#include maps\_anim;
#include maps\_music;
#include maps\_glasses;
#include maps\monsoon_lab;
#include maps\monsoon_lab_defend;
#include maps\createart\monsoon_art;
#include maps\_audio;
#include maps\_camo_suit;

skipto_celerium() {
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
  level.isaac = init_hero("isaac");
  skipto_teleport("player_skipto_celerium", get_heroes());
  level thread asd_intro_destruction();
  level thread turn_off_all_lab_trigs();
  level thread maps\monsoon_lab::remove_hallway_ai_clip();
  level thread maps\monsoon_lab::lab_doors();
  lab_spawn_funcs();
  make_model_not_cheap();
  level thread maps\monsoon_lab_defend::asd_wall_crash();
  wait 0.05;
  flag_set("start_asd_wall_crash");
  level.player.overrideplayerdamage = ::player_nitrogen_death;
  level.ignoreneutralfriendlyfire = 1;
  level.isaac.name = "Erik";
}

turn_off_all_lab_trigs() {
  a_lab_trigs = getentarray("lab_trigs", "script_noteworthy");

  foreach(trig in a_lab_trigs)
  trig trigger_off();

  a_lab_trigs = [];
  a_lab_trigs[0] = getent("trig_spawn_lobby_guys", "targetname");
  a_lab_trigs[1] = getent("trig_lab_1_1_color_cleared", "targetname");
  a_lab_trigs[2] = getent("trig_color_lobby_mid", "targetname");
  a_lab_trigs[3] = getent("trig_vo_player_asd", "targetname");
  a_lab_trigs[4] = getent("trig_sm_lab_dumby", "targetname");
  a_lab_trigs[5] = getent("trig_sm_lab_2_1_frontline", "targetname");
  a_lab_trigs[6] = getent("trig_sm_lab_1_1_frontline", "targetname");
  a_lab_trigs[7] = getent("trig_lab_1_1_frontline_half", "targetname");
  a_lab_trigs[8] = getent("trig_lab_2_1_frontline_half", "targetname");
  a_lab_trigs[9] = getent("trig_spawn_ambient_2_1_asd", "targetname");
  a_lab_trigs[10] = getent("trig_sm_lab_1_1", "targetname");
  a_lab_trigs[11] = getent("trig_window_jumper", "targetname");
  a_lab_trigs[12] = getent("trig_lab_2_1_frontline_cleared", "targetname");
  a_lab_trigs[13] = getent("trig_lab_1_1_guys_half", "targetname");
  a_lab_trigs[14] = getent("trig_stair_tumble_guy", "targetname");
  a_lab_trigs[15] = getent("trig_harper_railing_throw", "targetname");
  a_lab_trigs[16] = getent("trig_sm_lab_1_2_frontline", "targetname");
  a_lab_trigs[17] = getent("trig_lab_2_1_guys_half", "targetname");
  a_lab_trigs[18] = getent("trig_sm_lab_2_2", "targetname");
  a_lab_trigs[19] = getent("interior_lift_trigger", "targetname");
  a_lab_trigs[20] = getent("trig_lab_2_2_frontline_half", "targetname");
  a_lab_trigs[21] = getent("trig_lab_1_2_frontline_half", "targetname");
  a_lab_trigs[22] = getent("trig_sm_lab_1_2", "targetname");
  a_lab_trigs[23] = getent("trig_lab_2_2_guys_half", "targetname");
  a_lab_trigs[24] = getent("trig_lab_1_2_guys_half", "targetname");
  a_lab_trigs[25] = getent("trig_harper_speed_up", "targetname");
  a_lab_trigs[26] = getent("trig_salazar_crosby_speed_up", "targetname");
  a_lab_trigs[27] = getent("trig_lab_2_2_guys_cleared", "targetname");
  a_lab_trigs[28] = getent("trig_lab_1_2_guys_cleared", "targetname");

  foreach(trig in a_lab_trigs)
  trig trigger_off();
}

init_celerium_flags() {
  flag_init("set_celerium_door_obj");
  flag_init("player_triggered_celerium_door");
  flag_init("player_at_celerium_door");
  flag_init("remove_celerium_breadcrumb");
  flag_init("player_at_celerium");
  flag_init("set_celerium_chip_obj");
  flag_init("celerium_event_done");
  flag_init("isaacs_killers_cleared");
  flag_init("spawn_escape_path_guys");
  flag_init("spawn_briggs_scene");
  flag_init("set_briggs_breadcrumb");
  flag_init("spawn_staircase_guys");
  flag_init("top_stairs_guys_cleared");
  flag_init("escape_path_guys_cleared");
  flag_init("spawn_top_stairs_guys");
  flag_init("spawn_top_stairs_guys_2");
  flag_init("briggs_in_position");
  flag_init("celerium_obj_done");
  flag_init("isaac_is_shot");
  flag_init("shutdown_lights");
  flag_init("open_celerium_glass");
  flag_init("player_at_briggs");
  flag_init("play_below_us_vo");
  flag_init("isaac_grabbed_celerium");
  flag_init("detach_device_from_player");
}

celerium_chamber_main() {
  flag_wait("lab_defend_done");
  celerium_retrieval();
  escape_lab();
}

escape_vo() {
  level.player queue_dialog("sect_harper_get_a_sitre_0", 0.75);
  level.harper queue_dialog("harp_kraken_harper_requ_0", 0.5);
  level.harper queue_dialog("harp_kraken_0", 1.5);
  level.harper queue_dialog("harp_dammit_no_response_0", 2.0);
  level.player queue_dialog("sect_we_ll_fight_our_way_0", 0.5);
  level.player queue_dialog("sect_this_ain_t_over_yet_0", 0.5);
}

escape_enemy_vo() {
  trigger_wait("trig_move_exit_chamber");
  wait 0.1;
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub3_we_can_t_let_them_le_0", 1.0);
  flag_wait("spawn_escape_path_guys");
  wait 0.1;
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub0_they_re_moving_throu_0", 1.0);
  flag_wait("play_below_us_vo");
  wait 0.1;
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub1_below_us_keep_fire_0", 1.0);
}

escape_lab() {
  flag_wait("celerium_event_done");
  delete_exploder(9888);
  wait 0.05;
  wait_network_frame();
  e_lab_stair_blocker_m = getent("lab_stair_blocker_m", "targetname");
  e_lab_stair_blocker_m show();
  e_lab_stair_blocker_m solid();
  e_lab_stair_blocker_clip = getent("lab_stair_blocker_clip", "targetname");
  e_lab_stair_blocker_clip show();
  e_lab_stair_blocker_clip solid();
  level thread escape_vo();
  level thread escape_enemy_vo();
  a_exit_blood_01 = getentarray("exit_blood_01", "targetname");

  foreach(blood in a_exit_blood_01) {
    if(is_mature())
      blood show();
  }

  kill_spawnernum(202);
  e_escape_blast_doors = getent("escape_blast_doors", "targetname");
  e_escape_blast_doors show();
  e_escape_blast_doors solid();
  e_escape_blast_doors disconnectpaths();
  a_escape_trigs = getentarray("escape_trigs", "script_noteworthy");

  foreach(trig in a_escape_trigs)
  trig trigger_on();

  simple_spawn("isaacs_killers");
  level thread monitor_escape_enemies();
  escape_doors_setup();
  a_destroyed_lobby_asd = getentarray("destroyed_lobby_asd", "targetname");

  foreach(asd in a_destroyed_lobby_asd) {
    asd show();
    asd solid();
  }

  e_player_chair_clip = getent("player_chair_clip", "targetname");
  e_player_chair_clip show();
  e_player_chair_clip solid();
  trigger_wait("trig_escape_doors_1");
  playsoundatposition("evt_escape_doors", (8777, 56337, -1139));
  m_escape_door_01l = getent("escape_door_01l", "targetname");
  m_escape_door_01r = getent("escape_door_01r", "targetname");
  m_escape_door_01l movex(-90, 0.5);
  m_escape_door_01r movex(90, 0.5);
  trigger_wait("trig_escape_doors_2");
  m_escape_door_02l = getent("escape_door_02l", "targetname");
  m_escape_door_02r = getent("escape_door_02r", "targetname");
  m_escape_door_02l movey(90, 0.5);
  m_escape_door_02r movey(-90, 0.5);
  flag_wait("spawn_top_stairs_guys");
  end_scene("enemy_wounded_2");
  delete_scene_all("enemy_wounded_2");
  end_scene("enemy_wounded_3");
  delete_scene_all("enemy_wounded_3");
  level thread run_scene("corpse_1");
  level thread run_scene("corpse_2");
  level thread run_scene("escape_scientist_1_corpse");
  level thread run_scene("escape_scientist_3_corpse");
  simple_spawn("top_stairs_guys");
  autosave_by_name("escape_mid");
  level thread run_scene("enemy_wounded_1");
  level thread run_scene("belly_crawl_short");
  level thread run_scene("belly_crawl_long");
  flag_wait("spawn_top_stairs_guys_2");
  simple_spawn("top_stairs_guys_2");
  wait 0.05;
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc thread queue_dialog("cub2_hold_them_at_all_cos_0", 1.5);
  flag_wait("top_stairs_guys_cleared");
  level thread briggs_outro_scene();
  level thread soldier_briggs_convo();
  flag_wait("set_briggs_breadcrumb");
  level thread outro_soldiers();
  level thread crawl_back_victim();
  flag_wait("spawn_briggs_scene");
  clientnotify("snd_alarm_off");
  level thread kill_spotlights();
  simple_spawn("ending_gaurds");
  a_destroyed_lobby_asd = getentarray("destroyed_lobby_asd", "targetname");

  foreach(asd in a_destroyed_lobby_asd)
  playfxontag(level._effect["agr_death_smolder"], asd, "tag_origin");

  a_top_stairs_guys = get_ai_group_ai("top_stairs_guys");

  foreach(ai in a_top_stairs_guys)
  ai die();

  a_top_stairs_guys_2 = get_ai_group_ai("top_stairs_guys_2");

  foreach(ai in a_top_stairs_guys_2)
  ai die();

  flag_wait("player_at_briggs");
  setmusicstate("MONSOON_ENDING");
  level thread briggs_arrival_vo();
  level.player setlowready(1);
  level.player thread player_walk_speed_adjustment(level.briggs, "briggs_in_position", 512, 1024, 0.5, 0.6);
  clean_room_ending();
  flag_wait("briggs_in_position");
  trig_briggs_player_use = getent("briggs_player_use", "targetname");
  trig_briggs_player_use trigger_on();
  trig_briggs_player_use waittill("trigger");
  trig_briggs_player_use trigger_off();
  setmusicstate("MONSOON_BRIGGS");
  end_scene("enemy_wounded_1");
  delete_scene_all("enemy_wounded_1");
  end_scene("corpse_1");
  delete_scene_all("corpse_1");
  end_scene("corpse_2");
  delete_scene_all("corpse_2");
  a_ai_axis = getaiarray("axis");

  foreach(ai in a_ai_axis)
  ai delete();

  flag_set("celerium_obj_done");
  run_scene("ending_player");
}

kill_spotlights() {
  level.emergency_light_active notify("stop_emergency_light");
  wait 0.05;
  wait_network_frame();
  level notify("new_emergency_light_playing");
  level.emergency_light_active = undefined;
  wait_network_frame();
  level notify("kill_emergency_lights");
  wait_network_frame();
  exploder(1024);
}

briggs_arrival_vo() {
  level.briggs queue_dialog("brig_section_your_team_0");
  level.player queue_dialog("sect_it_s_briggs_0", 0.3);
  level.player queue_dialog("sect_stand_down_it_s_the_0", 0.4);
}

crawl_back_victim() {
  level thread run_scene("last_stand_killer_loop");
  level thread run_scene("data_observer_loop");
  level thread run_scene("dying_crawl_back");
  level thread run_scene("hallway_victim_owned");
  ai_hallway_victim_killer = simple_spawn_single("hallway_victim_killer");
  ai_hallway_victim_killer.ignoreme = 1;
  ai_hallway_victim_killer.ignoreall = 1;
  ai_hallway_victim_killer magic_bullet_shield();
  s_last_stand_magicbullet = getstruct("last_stand_magicbullet", "targetname");
  s_last_stand_magicbullet_end = getstruct(s_last_stand_magicbullet.target, "targetname");
  magicbullet("scar_sp", s_last_stand_magicbullet.origin, s_last_stand_magicbullet_end.origin);
  magicbullet("scar_sp", s_last_stand_magicbullet.origin, s_last_stand_magicbullet_end.origin);
  magicbullet("scar_sp", s_last_stand_magicbullet.origin, s_last_stand_magicbullet_end.origin);
  magicbullet("scar_sp", s_last_stand_magicbullet.origin, s_last_stand_magicbullet_end.origin);
  magicbullet("scar_sp", s_last_stand_magicbullet.origin, s_last_stand_magicbullet_end.origin);
  magicbullet("scar_sp", s_last_stand_magicbullet.origin, s_last_stand_magicbullet_end.origin);
  flag_wait("player_at_briggs");
  ai_crawl_dude = get_ais_from_scene("dying_crawl_back", "crawl_back_guy");

  if(isDefined(ai_crawl_dude))
    ai_crawl_dude die();
}

gun_shots_to_victim(guy) {
}

clean_room_ending() {
  level thread run_scene("clean_room_cower_loop_1");
  level thread run_scene("clean_room_cower_loop_2");
  level thread run_scene("clean_room_cower_loop_3");
  level thread run_scene("clean_room_cower_loop_4");
  level thread run_scene("clean_room_soldier1");
  level thread run_scene("clean_room_soldier2");
  level thread run_scene("clean_room_soldier3");
  level thread run_scene("clean_room_soldier4");
  level thread run_scene("briggs_saluter1");
  level thread run_scene("briggs_saluter2");
}

escape_doors_setup() {
  m_escape_door_01l = getent("escape_door_01l", "targetname");
  m_escape_door_01l_clip = getent("escape_door_01l_clip", "targetname");
  m_escape_door_01l_clip linkto(m_escape_door_01l);
  m_escape_door_01r = getent("escape_door_01r", "targetname");
  m_escape_door_01r_clip = getent("escape_door_01r_clip", "targetname");
  m_escape_door_01r_clip linkto(m_escape_door_01r);
  m_escape_door_01l_clip connectpaths();
  m_escape_door_01r_clip connectpaths();
  m_escape_door_01l connectpaths();
  m_escape_door_01r connectpaths();
  m_escape_door_02l = getent("escape_door_02l", "targetname");
  m_escape_door_02l_clip = getent("escape_door_02l_clip", "targetname");
  m_escape_door_02l_clip linkto(m_escape_door_02l);
  m_escape_door_02r = getent("escape_door_02r", "targetname");
  m_escape_door_02r_clip = getent("escape_door_02r_clip", "targetname");
  m_escape_door_02r_clip linkto(m_escape_door_02r);
  m_escape_door_02l_clip connectpaths();
  m_escape_door_02r_clip connectpaths();
  m_escape_door_02l connectpaths();
  m_escape_door_02r connectpaths();
}

end_level_fade(guy) {
  screen_fade_out(1, "black", 1);
  level.player notify("mission_finished");
  wait 0.2;
  nextmission();
}

ending_soldier_1() {
  run_scene_first_frame("ending_soldier1_approach");
  flag_wait("spawn_briggs_scene");
  run_scene("ending_soldier1_approach");
  level thread run_scene("ending_soldier1_loop");
}

ending_soldier_2() {
  run_scene_first_frame("ending_soldier2_approach");
  flag_wait("spawn_briggs_scene");
  level thread run_scene("ending_soldier2_chair");
  run_scene("ending_soldier2_approach");
  level thread run_scene("ending_soldier2_loop");
}

ending_soldier_3() {
  run_scene_first_frame("ending_soldier3_approach");
  flag_wait("spawn_briggs_scene");
  level thread run_scene("ending_soldier3_chair");
  run_scene("ending_soldier3_approach");
  level thread run_scene("ending_soldier3_loop");
}

ending_soldier_4() {
  run_scene_first_frame("ending_soldier4_approach");
  flag_wait("spawn_briggs_scene");
  run_scene("ending_soldier4_approach");
  level thread run_scene("ending_soldier4_loop");
}

outro_soldiers() {
  level thread ending_soldier_1();
  level thread ending_soldier_2();
  level thread ending_soldier_3();
  level thread ending_soldier_4();
}

briggs_outro_scene() {
  level.briggs = init_hero("briggs");
  run_scene("ending_briggs_entry");
  flag_set("briggs_in_position");
  level thread run_scene("ending_briggs_idle");
}

soldier_briggs_convo() {
  run_scene("ending_soldier5_entry");
  level thread run_scene("ending_soldier5_idle");
}

monitor_escape_enemies() {
  flag_wait("spawn_escape_path_guys");
  waittill_ai_group_cleared("escape_path_guys");
  flag_set("escape_path_guys_cleared");
  trigger_use("trig_move_pre_stairs");
  flag_wait("spawn_top_stairs_guys");
  waittill_ai_group_cleared("top_stairs_guys");
  flag_set("top_stairs_guys_cleared");
  trigger_use("trig_move_first_floor");
}

celerium_retrieval() {
  autosave_by_name("defend_end");
  level thread celerium_vision_set_tracking();
  level thread celerium_entrance_doors();
  level thread celerium_glass();
  level thread celerium_enemies();
  level thread celerium_holograms();
  level thread celerium_lighting();
  level.isaac thread isaac_celerium();
  level.harper thread harper_celerium();
  level.salazar thread salazar_celerium();
  level.crosby thread crosby_celerium();
  level thread player_celerium();
}

celerium_vision_set_tracking() {
  s_pos = getstruct("back_celerium_door_rumble_dist", "targetname");

  while(true) {
    while(level.player.origin[0] > s_pos.origin[0])
      wait 0.05;

    level thread maps\createart\monsoon_art::celerium_chamber_vision();
    wait 1;

    while(level.player.origin[0] < s_pos.origin[0])
      wait 0.05;

    level thread maps\createart\monsoon_art::lab_vision();
    wait 1;
  }
}

celerium_holograms() {
  a_data_streams = getentarray("data_streams", "script_noteworthy");
  array_thread(a_data_streams, ::data_stream_rotate_think);
  array_thread(a_data_streams, ::data_fade_think);
}

data_stream_rotate_think() {
  self ignorecheapentityflag(1);
  level.n_data_stream_speed = 14;

  while(!flag("shutdown_lights")) {
    self rotateyaw(-360, level.n_data_stream_speed);
    self waittill("rotatedone");
  }
}

data_fade_think() {
  level endon("shutdown_lights");

  while(true) {
    if(cointoss())
      self hide_data_element();

    wait(randomfloatrange(2.0, 3.0));
  }
}

hide_data_element() {
  self setclientflag(10);
  wait(randomfloatrange(5.0, 7.0));
  self clearclientflag(10);
  wait 1;
}

player_erik_neckshot(guy) {
  if(is_mature()) {
    playfxontag(level._effect["erik_neck_shot"], level.isaac, "J_neck");
    level.isaac playsound("evt_isaac_shot");
  }

  level.player queue_dialog("sect_what_the_hell_0", 0.25);
  level.harper queue_dialog("harp_behind_us_we_got_i_0", 0.1);
  level.player queue_dialog("sect_defensive_positions_0", 0.5);
}

celerium_enemies() {
  flag_wait("isaac_is_shot");
  level thread run_scene("soldier1_celerium_battle");
  level thread run_scene("soldier2_celerium_battle");
  level thread run_scene("soldier3_celerium_battle");
  wait 0.05;
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub2_stop_them_0");
}

celerium_entrance_doors() {
  flag_wait("player_triggered_celerium_door");
  level thread maps\_audio::switch_music_wait("MONSOON_CELERIUM", 3);
  bm_celerium_door_front_l = getent("celerium_door_front_l", "targetname");
  bm_celerium_door_front_r = getent("celerium_door_front_r", "targetname");
  e_celerium_door_left_clip = getent("celerium_door_left_clip", "targetname");
  e_celerium_door_right_clip = getent("celerium_door_right_clip", "targetname");
  e_celerium_door_left_clip linkto(bm_celerium_door_front_l);
  e_celerium_door_right_clip linkto(bm_celerium_door_front_r);
  bm_celerium_door_rear_l = getent("celerium_door_rear_l", "targetname");
  bm_celerium_door_rear_r = getent("celerium_door_rear_r", "targetname");
  e_celerium_door_left_rear_clip = getent("celerium_door_left_rear_clip", "targetname");
  e_celerium_door_right_rear_clip = getent("celerium_door_right_rear_clip", "targetname");
  e_celerium_door_left_rear_clip linkto(bm_celerium_door_rear_l);
  e_celerium_door_right_rear_clip linkto(bm_celerium_door_rear_r);
  bm_celerium_door_front_l playsound("evt_celerium_doors");
  bm_celerium_door_front_l movey(-90, 5, 1);
  bm_celerium_door_front_r movey(90, 5, 1);
  wait 1.5;
  bm_celerium_door_rear_l movey(-83, 5, 1);
  bm_celerium_door_rear_r movey(83, 5, 1);
  s_front_celerium_door_rumble_dist = getstruct("front_celerium_door_rumble_dist", "targetname");
  s_front_celerium_door_rumble_dist.is_moving = 1;
  s_front_celerium_door_rumble_dist.is_big_door = 1;
  s_front_celerium_door_rumble_dist thread player_door_rumble();
  s_back_celerium_door_rumble_dist = getstruct("back_celerium_door_rumble_dist", "targetname");
  s_back_celerium_door_rumble_dist.is_moving = 1;
  s_back_celerium_door_rumble_dist.is_big_door = 1;
  s_back_celerium_door_rumble_dist thread player_door_rumble();
  bm_celerium_door_front_l waittill("movedone");
  s_front_celerium_door_rumble_dist.is_moving = 0;
  n_distance = distance2d(s_front_celerium_door_rumble_dist.origin, level.player.origin);

  if(n_distance < 500)
    level.player playrumbleonentity("damage_heavy");

  bm_celerium_door_rear_l waittill("movedone");
  s_back_celerium_door_rumble_dist.is_moving = 0;
  n_distance = distance2d(s_back_celerium_door_rumble_dist.origin, level.player.origin);

  if(n_distance < 500)
    level.player playrumbleonentity("damage_heavy");

  bm_celerium_door_front_l connectpaths();
  bm_celerium_door_front_r connectpaths();
  bm_celerium_door_rear_l connectpaths();
  bm_celerium_door_rear_r connectpaths();
  e_celerium_door_left_clip connectpaths();
  e_celerium_door_right_clip connectpaths();
  e_celerium_door_left_rear_clip connectpaths();
  e_celerium_door_right_rear_clip connectpaths();
}

celerium_lighting() {
  flag_wait("shutdown_lights");
  clientnotify("light_celerium");
  a_data_streams = getentarray("data_streams", "script_noteworthy");

  foreach(data in a_data_streams)
  data hide();

  c_data_00 = getent("c_data_00", "targetname");
  c_data_00 hide();
  level thread exterior_rim_lights();
  exploder(9888);
  exploder(10666);
  flag_set("open_celerium_glass");
  flag_wait("isaac_grabbed_celerium");
  e_celerium_device = get_model_or_models_from_scene("player_chip_end", "celerium_chip");
  e_celerium_device.anim_link play_fx("celerium_glow", undefined, undefined, "isaac_is_shot", 1);
}

exterior_rim_lights() {
  iprintln("middle level");

  clientnotify("light_celerium_wall_01");
  clientnotify("light_celerium_wall_02");
  clientnotify("light_celerium_wall_03");
  clientnotify("light_celerium_wall_04");
  clientnotify("light_celerium_wall_05");
  clientnotify("light_celerium_wall_06");
  clientnotify("light_celerium_wall_07");
  exploder(9902);
  wait 0.5;

  iprintln("lower level");

  wait 0.5;

  iprintln("top level");
}

erik_celerium_door_nag() {
  level endon("player_at_celerium_door");
  level.harper.b_harper_door_nag = 0;
  level.isaac.b_door_nagged = 0;

  if(!isDefined(level.a_celerium_door_nag)) {
    level.a_celerium_door_nag[0] = "isaa_on_your_go_0";
    level.a_celerium_door_nag[1] = "isaa_we_have_to_hurry_0";
  }

  foreach(nag in level.a_celerium_door_nag) {
    wait 8;

    if(level.isaac.b_door_nagged && !level.harper.b_harper_door_nag) {
      level.harper queue_dialog("harp_let_s_get_to_it_sec_0");
      level.harper.b_harper_door_nag = 1;
      continue;
    }

    level.isaac queue_dialog(nag);
    level.isaac.b_door_nagged = 1;
    nag = undefined;
  }
}

celerium_door_visor_text() {
  add_visor_text("MONSOON_HACKING_CHAMBER_DOOR", 0, "default", "medium");
  wait 2;
  remove_visor_text("MONSOON_HACKING_CHAMBER_DOOR");
  wait 0.05;
  add_visor_text("MONSOON_HACKING_CHAMBER_DOOR_PORT", 0, "default", "medium");
  wait 2;
  remove_visor_text("MONSOON_HACKING_CHAMBER_DOOR_PORT");
  wait 0.05;
  add_visor_text("MONSOON_HACKING_CHAMBER_DOOR_DONE", 0, "default", "medium");
  wait 2;
  remove_visor_text("MONSOON_HACKING_CHAMBER_DOOR_DONE");
}

player_celerium() {
  flag_wait("set_celerium_door_obj");
  setmusicstate("MONSOON_DEFEND_EVENT_END");
  trig_player_celerium_door = getent("trig_player_celerium_door", "targetname");
  trig_player_celerium_door trigger_on();
  trig_player_celerium_door waittill("trigger");
  trig_player_celerium_door delete();
  flag_set("player_at_celerium_door");
  level thread celerium_door_visor_text();
  level.player setlowready(1);
  exploder(858);
  exploder(966);
  level thread run_scene("celerium_chip_loop");
  wait 0.05;
  e_celerium_device = get_model_or_models_from_scene("celerium_chip_loop", "celerium_chip");
  e_celerium_device.anim_link play_fx("celerium_strobe", undefined, undefined, "isaac_grabbed_celerium", 1);
  flag_set("player_triggered_celerium_door");
  a_defend_asds = getentarray("defend_asds", "script_noteworthy");

  foreach(asd in a_defend_asds) {
    if(issentient(asd))
      asd notify("death");
  }

  ai_axis = getaiarray("axis");

  foreach(ai in ai_axis) {
    if(isDefined(ai) && isalive(ai))
      ai die();
  }

  delay_thread(0.05, maps\_camo_suit::data_glove_on, "player_celerium_door_open");

  if(level.player ent_flag_exist("camo_suit_on") && level.player ent_flag("camo_suit_on"))
    level.player ent_flag_clear("camo_suit_on");

  clientnotify("light_celerium");
  run_scene("player_celerium_door_open");
  level.player thread player_walk_speed_adjustment(level.isaac, "player_at_celerium", 128, 512, 0.35);
  level.isaac queue_dialog("isaa_follow_me_0", 0.25);
  wait 0.75;
  clientnotify("light_celerium_entrance");
  flag_wait("set_celerium_chip_obj");
  trig_player_celerium = getent("trig_player_celerium", "targetname");
  trig_player_celerium trigger_on();
  trig_player_celerium waittill("trigger");
  trig_player_celerium delete();
  level.emergency_light_active notify("stop_emergency_light");
  wait 0.05;
  wait_network_frame();
  level notify("new_emergency_light_playing");
  level.emergency_light_active = undefined;
  flag_set("remove_celerium_breadcrumb");
  level thread holster_guns_on_approach();

  if(level.player ent_flag_exist("camo_suit_on") && level.player ent_flag("camo_suit_on"))
    level.player ent_flag_clear("camo_suit_on");

  run_scene("player_chip_approach");
  flag_set("player_at_celerium");
  run_scene("player_chip_end");
  flag_set("celerium_event_done");
  level thread run_scene("enemy_wounded_2");
  level thread run_scene("enemy_wounded_3");
  level thread run_scene("belly_crawl_long_2");
  autosave_by_name("celerium_event_save");
  s_window_jumper_target = getstruct("window_jumper_target", "targetname");
  s_window_jumper_target_end = getstruct(s_window_jumper_target.target, "targetname");
  radiusdamage(s_window_jumper_target.origin, 100, 400, 200);
  radiusdamage(s_window_jumper_target_end.origin, 100, 400, 200);
}

holster_guns_on_approach() {
  wait 0.35;
  level.player disableweapons();
}

isaac_vo_before_door() {
  level thread erik_celerium_door_nag();
}

isaac_celerium() {
  level thread isaac_vo_before_door();
  run_scene("isaac_celerium_door_approach");
  level clientnotify("clrm_o");
  flag_set("set_celerium_door_obj");
  level thread run_scene("isaac_celerium_door_loop");
  flag_wait("player_triggered_celerium_door");
  self anim_set_blend_in_time(0.2);
  self anim_set_blend_out_time(0.2);
  run_scene("isaac_celerium_door_open");
  run_scene("isaac_celerium_approach");
  flag_set("set_celerium_chip_obj");
  playsoundatposition("evt_celerium_interact", (5793, 56153, -1164));
  level thread run_scene("isaac_celerium_loop");
  flag_wait("player_at_celerium");
  self stop_magic_bullet_shield();
  level thread maps\_audio::switch_music_wait("MONSOON_BASE_FIGHT_3", 47);
  run_scene("isaac_celerium_end");
}

attach_device_to_player(guy) {
}

celerium_glass() {
  flag_wait("player_at_celerium");
  e_celerium_shield_screen = getent("celerium_shield_screen", "targetname");
  e_celerium_shield_screen show();
  e_celerium_shield_screen movez(14.5, 1);
  flag_wait("open_celerium_glass");
  exploder(9777);
  e_celerium_shield_screen movez(-14.5, 1);
  level clientnotify("clrm_x");
  playsoundatposition("evt_celerium_glass", (5793, 56153, -1164));
  e_celerium_shield_glow = getent("celerium_shield_glow", "targetname");
  e_celerium_shield_glow hide();
  e_celerium_shield = getent("celerium_shield", "targetname");
  e_celerium_shield movez(-58, 6);
  e_celerium_shield_screen waittill("movedone");
  e_celerium_shield_screen hide();
}

harper_celerium() {
  self.goalradius = 32;
  self disable_ai_color(1);
  self disable_pain();
  self.dontmelee = 1;
  self.fixednode = 0;
  nd_harper_celerium_door = getnode("nd_harper_celerium_door", "targetname");
  self setgoalnode(nd_harper_celerium_door);
  scene_wait("player_celerium_door_open");
  nd_salazar_escape = getnode("nd_salazar_escape", "targetname");
  self setgoalnode(nd_salazar_escape);
  scene_wait("player_chip_approach");
  run_scene("harper_celerium_approach");
  run_scene_first_frame("harper_celerium_battle");
  flag_wait("isaac_is_shot");
  run_scene("harper_celerium_battle");
  self.script_accuracy = 2.0;
  self setgoalnode(nd_salazar_escape);
  flag_wait("isaacs_killers_cleared");
  self disable_pain();
  nd_harper_wall_node = getnode("harper_wall_node", "targetname");
  self setgoalnode(nd_harper_wall_node);
  flag_wait("escape_path_guys_cleared");
  self disable_ai_color(1);
  nd_harper_pre_stairs = getnode("nd_harper_pre_stairs", "targetname");
  self setgoalnode(nd_harper_pre_stairs);
  flag_wait("spawn_top_stairs_guys");
  nd_harper_top_stairs = getnode("nd_harper_top_stairs", "targetname");
  self setgoalnode(nd_harper_top_stairs);
  flag_wait("spawn_top_stairs_guys_2");
  trigger_wait("trig_move_first_floor");
  nd_harper_first_floor = getnode("nd_harper_first_floor", "targetname");
  self setgoalnode(nd_harper_first_floor);
}

salazar_celerium() {
  self.goalradius = 32;
  self disable_ai_color(1);
  self disable_pain();
  self.dontmelee = 1;
  self.fixednode = 0;
  nd_salazar_defend = getnode("nd_salazar_defend", "targetname");
  self setgoalnode(nd_salazar_defend);
  scene_wait("player_celerium_door_open");
  wait 2;
  nd_harper_escape = getnode("nd_harper_escape", "targetname");
  self setgoalnode(nd_harper_escape);
  scene_wait("player_chip_approach");
  run_scene("salazar_celerium_approach");
  run_scene_first_frame("salazar_celerium_battle");
  flag_wait("isaac_is_shot");
  run_scene("salazar_celerium_battle");
  self.script_accuracy = 2.0;
  nd_crosby_escape = getnode("nd_crosby_escape", "targetname");
  self setgoalnode(nd_crosby_escape);
  flag_wait("isaacs_killers_cleared");
  nd_salazar_wall_node = getnode("salazar_wall_node", "targetname");
  self setgoalnode(nd_salazar_wall_node);
  flag_wait("escape_path_guys_cleared");
  self disable_ai_color(1);
  nd_salazar_pre_stairs = getnode("nd_salazar_pre_stairs", "targetname");
  self setgoalnode(nd_salazar_pre_stairs);
  self waittill("goal");
  flag_wait("spawn_top_stairs_guys");
  nd_salazar_top_stairs = getnode("nd_salazar_top_stairs", "script_noteworthy");
  self setgoalnode(nd_salazar_top_stairs);
  flag_wait("spawn_top_stairs_guys_2");
  trigger_wait("trig_move_first_floor");
  nd_salazar_first_floor = getnode("nd_salazar_first_floor", "script_noteworthy");
  self setgoalnode(nd_salazar_first_floor);
  flag_wait("player_at_briggs");
  nd_salazar_briggs_scene = getnode("salazar_briggs_scene", "script_noteworthy");
  self setgoalnode(nd_salazar_briggs_scene);
}

crosby_celerium() {
  self.goalradius = 32;
  self disable_ai_color(1);
  self disable_pain();
  self.dontmelee = 1;
  self.fixednode = 0;
  nd_salazar_celerium_door = getnode("nd_salazar_celerium_door", "targetname");
  self setgoalnode(nd_salazar_celerium_door);
  scene_wait("player_celerium_door_open");
  nd_crosby_escape = getnode("nd_crosby_escape", "targetname");
  self setgoalnode(nd_crosby_escape);
  scene_wait("player_chip_approach");
  run_scene("crosby_celerium_approach");
  run_scene_first_frame("crosby_celerium_battle");
  flag_wait("isaac_is_shot");
  run_scene("crosby_celerium_battle");
  self.script_accuracy = 2.0;
  nd_crosby_chamber_node = getnode("crosby_chamber_node", "targetname");
  self setgoalnode(nd_crosby_chamber_node);
  flag_wait("isaacs_killers_cleared");
  nd_crosby_wall_node = getnode("crosby_wall_node", "targetname");
  self setgoalnode(nd_crosby_wall_node);
  flag_wait("escape_path_guys_cleared");
  self disable_ai_color(1);
  nd_crosby_pre_stairs = getnode("nd_crosby_pre_stairs", "targetname");
  self setgoalnode(nd_crosby_pre_stairs);
  flag_wait("spawn_top_stairs_guys");
  nd_crosby_top_stairs = getnode("nd_crosby_top_stairs", "targetname");
  self setgoalnode(nd_crosby_top_stairs);
  flag_wait("spawn_top_stairs_guys_2");
  trigger_wait("trig_move_first_floor");
  nd_crosby_first_floor = getnode("nd_crosby_first_floor", "script_noteworthy");
  self setgoalnode(nd_crosby_first_floor);
  trigger_wait("trig_move_first_floor_2");
  nd_crosby_briggs_scene = getnode("crosby_briggs_scene", "script_noteworthy");
  self setgoalnode(nd_crosby_briggs_scene);
}