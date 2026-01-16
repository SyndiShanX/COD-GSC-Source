/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_building.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\panama_utility;
#include maps\_music;
#include maps\createart\panama3_art;
#include maps\_audio;

skipto_building() {
  skipto_setup();
  level.mason = init_hero("mason");
  level.noriega = init_hero("noriega");
  a_heroes = array(level.mason, level.noriega);
  skipto_teleport("player_skipto_building", a_heroes);
}

main() {
  add_spawn_function_group("hallway_gun_guys", "targetname", ::turn_off_badplace);
  hurt_trigger = getent("fight_room_hurt_trigger", "targetname");
  hurt_trigger trigger_off();
  level.digbat_gauntlet_vo = [];
  level.digbat_gauntlet_vo[level.digbat_gauntlet_vo.size] = "db1_in_here_americans_0";
  level.digbat_gauntlet_vo[level.digbat_gauntlet_vo.size] = "db2_in_the_hallway_0";
  level.digbat_gauntlet_vo[level.digbat_gauntlet_vo.size] = "db1_kill_them_0";
  level.digbat_gauntlet_vo[level.digbat_gauntlet_vo.size] = "db2_die_fucker_0";
  level.digbat_gauntlet_vo[level.digbat_gauntlet_vo.size] = "db3_raaaargh_0";
  level.digbat_gauntlet_vo_count = -1;
  add_spawn_function_group("digbat_gauntlet_ais", "targetname", ::play_random_gauntlet_vo);
  trigger_off("building_hallway_dmg", "targetname");
  level clientnotify("lsmn");
  flag_set("panama_building_start");
  setmusicstate("PANAMA_HAUNTED_HOUSE");
  level.mason = init_hero("mason");
  level.mason change_movemode();
  level.noriega = init_hero("noriega");
  level.noriega change_movemode();
  level.noriega thread check_for_friendly_fire_noriega();
  level.player allowsprint(0);

  if(level.player get_temp_stat(1)) {
    level.player giveweapon("nightingale_dpad_sp");
    level.player setactionslot(1, "weapon", "nightingale_dpad_sp");
    level.player givemaxammo("nightingale_dpad_sp");
    level.player thread nightingale_watch();
  }

  if(level.player get_temp_stat(2)) {
    level.player giveweapon("irstrobe_dpad_sp");
    level.player setactionslot(4, "weapon", "irstrobe_dpad_sp");
    level.player thread ir_strobe_watch();
  }

  level.player thread player_walk_speed_adjustment(level.mason, "digbat_tackle_done", 128, 512, 0.4, 0.7);
  level thread create_dead_bodies();
  level thread start_crying_woman();
  clinic_spookies();
  level thread clinic_move_heroes();
  wait 0.5;
  level thread building_dialog();
  screen_fade_in(1, undefined, 1);
  digbat_tackle();
  level.player allowsprint(1);
  digbat_gauntlet();
  level thread building_stairwell_mason_movement();
  flag_wait("outside_vo");
  building_stairwell();
}

init_flags() {
  flag_init("panama_building_start");
  flag_init("player_at_clinic");
  flag_init("clinic_enter_hall_1");
  flag_init("clinic_enter_hall_2");
  flag_init("clinic_ceiling_collapsed");
  flag_init("post_gauntlet_player_fired");
  flag_init("post_gauntlet_mason_open_door");
  flag_init("outside_vo");
}

create_dead_bodies() {
  doctor_model = getent("dead_nurse_1", "targetname");
  doctor_model attach("c_mul_redcross_nurse_head1");
  doctor_model = getent("dead_nurse_2", "targetname");
  doctor_model attach("c_mul_redcross_nurse_head1");
  doctor_model = getent("dead_nurse_3", "targetname");
  doctor_model attach("c_mul_redcross_nurse_head1");
  doctor_model = getent("dead_doctor_1", "targetname");
  doctor_model attach("c_mul_redcross_doctor_head1");
  level thread run_scene("dead_nurse_1");
  level thread run_scene("dead_nurse_2");
  level thread run_scene("dead_nurse_3");
  level thread run_scene("dead_doctor_1");
}

clinic_move_heroes() {
  level endon("digbat_tackle_started");
  run_scene("clinic_walk_door_to_idle");
  level thread run_scene("clinic_walk_idle_1");
  flag_wait("clinic_enter_hall_1");
  run_scene("clinic_walk_move_to_idle2");
  level thread run_scene("clinic_walk_idle_2");
  flag_wait("clinic_enter_hall_2");
  run_scene("clinic_walk_path_v1");
  level thread run_scene("clinic_walk_end_idle_v1");
}

clinic_spookies() {
  exploder(106);
  level thread clinic_ceiling_collapse();
  level thread clinic_light_shake();
  level thread maps\createart\panama3_art::clinic();
}

clinic_ceiling_collapse() {
  flag_wait("clinic_ceiling_collapsed");
  autosave_by_name("digbat_tackle");
  e_door = getent("clinic_stairwell_door", "targetname");
  e_door delete();
  level notify("fxanim_ceiling_collapse_start");
  v_ceiling_position = getstruct("building_ceiling_collapse", "targetname").origin;
  earthquake(0.3, 0.5, v_ceiling_position, 1000);
  e_sound_pos = spawn("script_origin", v_ceiling_position);
  level.player playsound("evt_hospital_shake_1");
  e_sound_pos playsound("evt_hospital_collapse");
  e_sound_pos delete();
  level.player playrumblelooponentity("damage_heavy");
  wait 0.5;
  level.player stoprumble("damage_heavy");
}

clinic_light_shake() {
  trigger_wait("clinic_light_shake");
  level.player playsound("evt_hospital_shake_0");
  exploder(621);
  earthquake(0.5, 1.5, level.player.origin, 250);
  a_structs = getstructarray("clinic_move_light", "targetname");

  foreach(s_pos in a_structs)
  physicsexplosioncylinder(s_pos.origin, 200, 190, 0.5);
}

start_crying_woman() {
  flag_wait("clinic_enter_hall_1");
  level thread run_scene("crying_woman_idle");
  nurse_model = get_model_or_models_from_scene("crying_woman_idle", "crying_woman");
  nurse_model setmodel("c_mul_redcross_nurse_wnded_body");
}

digbat_tackle() {
  trigger_wait("trig_tackle_start");
  level clientnotify("pab");
  level thread maps\_audio::switch_music_wait("PANAMA_BACK_FIGHT", 1.8);
  a_ai = getaiarray("axis", "allies");

  foreach(ai in a_ai) {
    if(ai is_hero()) {
      continue;
    }
    ai delete();
  }

  a_vehicles = getentarray("slums_vehicle", "script_noteworthy");

  foreach(vehicle in a_vehicles) {
    vehicle.delete_on_death = 1;
    vehicle notify("death");

    if(!isalive(vehicle))
      vehicle delete();
  }

  level notify("digbat_tackle_started");
  level thread run_scene("digbat_tackle");
  wait 0.05;
  digbat = get_ais_from_scene("digbat_tackle", "tackle_digbat");
  digbat attach("t6_wpn_machete_prop", "tag_weapon_left");
  level thread digbat_kick_open_door();
  scene_wait("digbat_tackle");
  run_scene_first_frame("noriega_fight_first");
  level.player allowsprint(1);
  level thread player_tackle_player_control_logic();
  nd_mason_gauntlet = getnode("mason_gauntlet_node", "targetname");
  level.mason setgoalnode(nd_mason_gauntlet);
  level.mason thread digbat_mason_control();
  level.player setclientdvar("cg_drawFriendlyNames", 1);
}

digbat_mason_control() {
  level endon("end_gauntlet");
}

give_player_max_ammo() {
  level endon("end_gauntlet");

  while(true) {
    wait 0.1;
    level.player setweaponammoclip("m1911_1handed_sp", 400);
  }
}

digbat_kick_open_door() {
  left_door = getent("hospital_door_left", "targetname");
  right_door = getent("hospital_door_right", "targetname");
  left_door rotateyaw(-78, 0.5);
  right_door rotateyaw(87, 0.5);
  door_clip = getent("clinic_double_door_clip", "targetname");
  door_clip trigger_off();
  door_clip connectpaths();
}

player_tackle_player_control_logic() {
  level endon("end_gauntlet");
  player_align = getent("player_tackle_sequence", "targetname");
  flag_init("player_moved_during_gauntlet");
  align = _get_align_object("digbat_tackle_body");
  level thread gauntlet_recover();
}

digbat_tackle_wall(e_digbat) {
  level notify("fxanim_wall_tackle_start");
  exploder(640);
  level.player playsound("evt_dingbat_wall_break");
  wait 1;
  level.player playrumbleonentity("damage_heavy");
  overlay = newclienthudelem(level.player);
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("overlay_low_health_splat", 640, 480);
  overlay.splatter = 1;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.foreground = 0;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 1;
  overlay fadeovertime(10);
  overlay.alpha = 0;
  wait 1;
  level.player setblur(0, 5);
  wait 10;
  overlay destroy();
}

digbat_blood_pool() {
  run_scene("digbat_blood_pool");
  level thread run_scene("digbat_blood_pool_loop");
  e_blood_pool = getent("blood_pool", "targetname");
  e_blood_pool setclientflag(13);
}

digbat_gauntlet() {
  level.gauntlet_death = 1;
  spawn_manager_enable("hallway_clinic_manager");
  wait 1;
  enemies = getaiarray("axis");
  level thread digbat_guantlet_fail_safe();
  waittill_spawn_manager_cleared("hallway_clinic_manager");
  level notify("end_gauntlet");
  setmusicstate("PANAMA_BACK_FIGHT_OVER");
  autosave_by_name("digbat_gauntlet_over");
}

digbat_guantlet_fail_safe() {
  level endon("end_gauntlet");
  flag_wait("clinic_stairwell_top");

  do {
    enemies = getaiarray("axis");

    foreach(ai in enemies) {
      if(isDefined(ai.digbat_melee_weapon))
        ai die();
    }

    wait 1;
  }
  while(true);
}

spawn_digbat_hallway(spawner_name) {
  digbat = simple_spawn_single(spawner_name);
  digbat.fixednode = 1;
  digbat.dontmelee = 1;
}

digbat_gauntlet_think() {
  self.health = 30;
  self waittill("death");
  level notify("gauntlet_death");
  level.gauntlet_death++;
}

digbat_challenge_track() {
  self waittill("death", attacker);

  if(!isDefined(attacker)) {
    return;
  }
  if(attacker == level.player)
    level.total_digbat_killed++;
}

gauntlet_recover() {
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player hideviewmodel();
  wait 0.05;
  level thread run_scene("tackle_recover_woman");
  run_scene("tackle_recover_player");
  level.player allowprone(1);
  level.player allowcrouch(1);
}

building_stairwell() {
  level thread building_stairwell_flashlights();
  level thread building_stairwell_player_fire_listener();
  flag_wait("post_gauntlet_mason_open_door");
  level clientnotify("SND_ehs");
  autosave_by_name("apache_chase_start");
}

building_stairwell_mason_movement() {
  nd_stairwell_entrance = getnode("stairwell_entrance", "targetname");
  level.mason set_goalradius(32);
  level.mason setgoalnode(nd_stairwell_entrance);
  wait 0.5;
  level.mason waittill("goal");
}

building_stairwell_flashlights() {
  wait 1;
  level thread run_scene("hallway_flashlights_enter");
  wait 0.5;
  a_flashlights = get_model_or_models_from_scene("hallway_flashlights_enter");

  foreach(m_flashlight in a_flashlights)
  playfxontag(level._effect["flashlight"], m_flashlight, "tag_origin");

  scene_wait("hallway_flashlights_enter");
  array_delete(a_flashlights);
  level thread run_scene("hallway_flashlights_loop");
  a_flashlights = get_model_or_models_from_scene("hallway_flashlights_loop");

  foreach(m_flashlight in a_flashlights)
  playfxontag(level._effect["flashlight"], m_flashlight, "origin_animate_jnt");

  flag_wait("clinic_stairwell_top");
  array_delete(a_flashlights);
}

building_stairwell_player_fire_listener() {
  level endon("clinic_stairwell_top");
  level thread outside_vo();
  level.player waittill("weapon_fired");
  flag_set("post_gauntlet_player_fired");
  wait 0.5;
  level thread building_stairwell_soldier_fire("flashlight_hall_shot_start_1", "flashlight_hall_shot_end_1");
  level thread building_stairwell_soldier_fire("flashlight_hall_shot_start_2", "flashlight_hall_shot_end_2");
  exploder(540);
  level notify("fxanim_hall_blinds_start");
  trigger_on("building_hallway_dmg", "targetname");
}

building_stairwell_soldier_fire(str_start_struct, str_end_struct) {
  level endon("clinic_stairwell_top");
  n_burst_count_min = 12;
  n_burst_count_max = 15;
  n_burst_delay_min = 0.1;
  n_burst_delay_max = 0.15;
  n_post_burst_delay_min = 0.2;
  n_post_burst_delay_max = 0.3;
  a_start_structs = getstructarray(str_start_struct, "targetname");
  a_end_structs = getstructarray(str_end_struct, "targetname");

  while(true) {
    n_burst_count = randomintrange(n_burst_count_min, n_burst_count_max);

    for(i = 0; i < n_burst_count; i++) {
      s_start = a_start_structs[randomint(a_start_structs.size)];
      s_end = a_end_structs[randomint(a_end_structs.size)];
      magicbullet("m16_sp", s_start.origin, s_end.origin);
      wait(randomfloatrange(n_burst_delay_min, n_burst_delay_max));
    }

    wait(randomfloatrange(n_post_burst_delay_min, n_post_burst_delay_max));
  }
}

building_dialog() {
  level endon("start_digbag_tackle_dialog");
  level thread digbat_tackle_dialog();
  level.player say_dialog("wood_this_place_is_a_fuck_0", 1);
  level.mason say_dialog("maso_it_wasn_t_much_bette_0", 1);
  trigger_wait("clinic_light_shake");
  level.mason say_dialog("maso_hudson_it_s_mason_2");
  level.mason say_dialog("maso_hudson_beat_d_0", 1);
  level.mason say_dialog("maso_i_don_t_know_what_th_0", 1.3);
  level.player say_dialog("wood_don_t_sweat_it_maso_0", 0.4);
  trigger_wait("building_hall_roof_fall");
  nurse_model = get_model_or_models_from_scene("crying_woman_idle", "crying_woman");
  nurse_model thread say_dialog("woma__0");
  wait 2;
  level.player say_dialog("wood_i_hear_it_0", 1);
}

digbat_tackle_dialog() {
  trigger_wait("trig_tackle_start");
  level notify("start_digbag_tackle_dialog");
  level.player say_dialog("wood_she_s_hurt_bad_maso_0");
  level.player say_dialog("wood_damn_it_0", 1);
  wait 2;
  level.mason say_dialog("maso_shit_he_s_running_0");
  level.mason say_dialog("maso_idiot_s_gonna_get_hi_0");
  wait 2;
  level.mason say_dialog("maso_more_in_front_0", 1);
  level waittill("end_gauntlet");
  level.player say_dialog("wood_we_gotta_get_after_h_0", 1);
  level.mason say_dialog("maso_i_knew_we_were_givin_0");
}

outside_vo() {
  level.player endon("weapon_fired");
  trigger = getent("chase_stair_VO", "targetname");
  flag_wait("outside_vo");
  solider = getent("solider_outside_VO", "targetname");
  solider say_dialog("usr1_gunshots_came_from_i_0", 0, 1);
  solider say_dialog("usr2_did_another_team_mov_0", 0, 1);
  solider say_dialog("usr1_don_t_think_so_0", 0, 1);
  solider say_dialog("usr2_call_it_in_i_want_0", 0, 1);
}

unfreeze_player_controls_after_blackscreen_over() {
  wait 0.5;
  level.player freezecontrols(1);
  level waittill("blackscreen_finished");
  wait 0.75;
  level.player freezecontrols(0);
}

turn_off_badplace() {
  self.badplaceawareness = 0;
}

play_random_gauntlet_vo() {
  self endon("death");
  self thread digbat_challenge_track();

  if(level.digbat_gauntlet_vo_count >= 4)
    level.digbat_gauntlet_vo_count = -1;

  level.digbat_gauntlet_vo_count++;
  self say_dialog(level.digbat_gauntlet_vo[level.digbat_gauntlet_vo_count], randomfloatrange(0.5, 3));
}