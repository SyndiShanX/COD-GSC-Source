/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_slums.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\panama_utility;
#include maps\_anim;
#include maps\_vehicle;
#include maps\_fxanim;
#include maps\panama_2_dialog;
#include maps\_music;
#include maps\_digbats;
#include maps\createart\panama_art;
#include animscripts\anims;
#include maps\_drones;
#include maps\_turret;
#include maps\_spawner;

skipto_slums_intro() {
  skipto_teleport_players("player_skipto_slums_intro");
  flag_set("movie_done");
}

skipto_slums_main() {
  level.mason = init_hero("mason");
  level.mason change_movemode("sprint");
  level.mason.grenadeawareness = 0;
  level.mason pushplayer(1);
  level.mason.disableaivsaimelee = 1;
  level.mason.badplaceawareness = 0;
  level.noriega = init_hero("noriega");
  level.noriega thread intro_noriega();
  level.noriega pushplayer(1);
  level.noriega.disableaivsaimelee = 1;
  level.noriega.badplaceawareness = 0;

  if(level.player get_temp_stat(1)) {
    level.player giveweapon("nightingale_dpad_sp");
    level.player setactionslot(1, "weapon", "nightingale_dpad_sp");
    level.player givemaxammo("nightingale_dpad_sp");
    level.player thread nightingale_watch();
  }

  skipto_teleport("player_skipto_slums_main", level.heroes);
  level thread slum_edge_vo();
  trigger_use("trig_slums_start", "targetname");
  flag_set("slums_mason_at_overlook");
  trigger_use("slums_heli_shoot_trigger");
  flag_set("slums_update_objective");
  delay_thread(5, ::flag_set, "slums_player_down");
  level thread slums_paired_movement();
  level thread decontruct_fxanim();
  maps\createart\panama_art::slums();
  level.player setclientdvar("cg_aggressiveCullRadius", 100);
  level thread personal_pdf_battle_dialog();
  level thread e_07_mg_nest();
  level thread basketball_courtmg();
  level thread church_left_mg();
  level thread church_right_mg();
}

skipto_slums_halfway() {
}

init_flags() {
  flag_init("ambulance_complete");
  flag_init("ambulance_staff_killed");
  flag_init("ambulance_player_engaged");
  flag_init("slums_done");
  flag_init("slums_player_at_overlook");
  flag_init("slums_noriega_at_overlook");
  flag_init("slums_mason_at_overlook");
  flag_init("slums_player_down");
  flag_init("slums_shot_at_snipers");
  flag_init("slums_e_02_start");
  flag_init("slums_e_02_finish");
  flag_init("slums_molotov_triggered");
  flag_init("slums_update_objective");
  flag_init("slums_nest_engage");
  flag_init("slums_apache_retreat");
  flag_init("slums_start_building_fire");
  flag_init("slums_bottleneck_reached");
  flag_init("sm_standoff_kill");
  flag_init("slums_bottleneck_2_reached");
  flag_init("kill_gazebo_vo");
  flag_init("noriega_moved_now_move_mason");
  flag_init("mv_noriega_to_van");
  flag_init("mv_noriega_to_dumpster");
  flag_init("mv_noriega to_parking_lot");
  flag_init("mv_noriega_to_gazebo");
  flag_init("mv_noriega_just_before_stairs");
  flag_init("mv_noriega_slums_left_bottleneck");
  flag_init("mv_noriega_right_of_church");
  flag_init("mv_noriega_before_church");
  flag_init("mv_noriega_slums_right_bottleneck");
  flag_init("mv_noriega_slums_right_bottleneck_complete");
  flag_init("mv_noriega_move_passed_library");
  flag_init("spawn_balcony_digbat");
  flag_init("building_breach_ready");
  flag_init("army_street_push");
}

challenge_irstrobe_kill(str_notify) {
  level.ac130_irstrobe_kills = 0;

  while(level.ac130_irstrobe_kills < 15)
    wait 0.5;

  self notify(str_notify);
}

challenge_destroy_zpu(str_notify) {
  level waittill("slums_zpu_destroyed");
  self notify(str_notify);
}

challenge_grenade_combo(str_notify) {
  while(true) {
    level waittill("combo_death");
    self notify(str_notify);
  }
}

challenge_rescue_soldier(str_notify) {
  level waittill("slums_soldier_rescued");
  self notify(str_notify);
}

challenge_find_weapon_cache(str_notify) {
  level waittill("slums_found_weapon_cache");
  self notify(str_notify);
}

slums_wind_settings() {
  setsaveddvar("wind_global_vector", "246.366 0 0");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 5000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

intro() {
  level slums_wind_settings();
  level thread slum_edge_vo();
  level.player setclientdvar("cg_aggressiveCullRadius", 100);
  maps\createart\panama_art::slums();
  flag_wait("movie_done");
  level thread decontruct_fxanim();

  if(level.player get_temp_stat(1)) {
    level.player giveweapon("nightingale_dpad_sp");
    level.player setactionslot(1, "weapon", "nightingale_dpad_sp");
    level.player givemaxammo("nightingale_dpad_sp");
    level.player thread nightingale_watch();
  }

  add_spawn_function_ai_group("ambulance_staff", ::check_for_friendly_fire_noriega);
  level.mason = init_hero("mason");
  level.noriega = init_hero("noriega");
  level.mason set_ignoreme(1);
  level.mason.disableaivsaimelee = 1;
  level.mason.badplaceawareness = 0;
  level.noriega set_ignoreme(1);
  level.noriega.disableaivsaimelee = 1;
  level.noriega.badplaceawareness = 0;
  level thread intro_ambulance();
  level thread slum_vo_ambulance();
  level thread personal_pdf_battle_dialog();
  level thread e_07_mg_nest();
  level thread basketball_courtmg();
  level thread church_left_mg();
  level thread church_right_mg();
  level thread intro_cleanup();

  get_animation_endings();

  level.player thread intro_player();
  level.mason thread intro_mason();
  level.noriega thread intro_noriega();
  level thread slums_manage_grenade_count();
  flag_wait("ambulance_player_engaged");
}

decontruct_fxanim() {
  level thread fxanim_deconstruct("gazebo_collapse");
  level thread fxanim_deconstruct("overlook_building_explode");
}

slums_spawn_functions() {
  add_spawn_function_veh("slums_opening_read_heli", ::littlebird_fire_until_flag, "move_intro_heli");
  add_spawn_function_veh("slums_apc_speaker", ::turn_off_magic_bullet_shield);
  add_spawn_function_veh("slums_apc_speaker", ::turn_off_magic_bullet_shield);
}

turn_off_magic_bullet_shield() {
  self endon("death");
  self thread veh_magic_bullet_shield(1);
  self.ignoreme = 1;
  wait 5;
  self.ignoreme = 0;
  self thread veh_magic_bullet_shield(0);
}

littlebird_fire_until_flag(str_flag) {
  self thread fire_turret_for_time(-1, 1);
  self thread fire_turret_for_time(-1, 2);
  flag_wait(str_flag);
  self stop_turret(1);
  self stop_turret(2);
}

slums_manage_grenade_count() {
  a_axis_array = getspawnerteamarray("axis");

  foreach(e_spawner in a_axis_array) {
    if(randomint(2) < 1) {
      e_spawner.script_grenades = 0;
      continue;
    }

    e_spawner.script_grenades = 1;
  }
}

intro_show_gun(player_body) {
  level.player enableweapons();
  level.player showviewmodel();
}

intro_civ() {
  level thread run_scene("slums_intro_civ_3_fight");
  flag_wait("slums_intro_civ_4_loop_started");
  wait 0.65;
  ai_doctor = getent("amb_doctor_4_ai", "targetname");
  ai_doctor ragdoll_death();
}

intro_bat_digbat() {
  run_scene("slums_intro_digbat_fight");
  flag_wait_any("ambulance_staff_killed", "ambulance_player_engaged");
}

ambulance_van() {
  run_scene("slums_ambulance");
  v_ambulance = getent("ambulence", "targetname");
  light_left = spawn("script_model", v_ambulance gettagorigin("tag_light_left") + vectorscale((0, 0, 1), 6.0));
  light_left setmodel("tag_origin");
  light_left.angles = v_ambulance gettagangles("tag_light_left");
  playfxontag(getfx("ambulance_siren"), light_left, "tag_origin");
  light_right = spawn("script_model", v_ambulance gettagorigin("tag_light_right") + vectorscale((0, 0, 1), 6.0));
  light_right setmodel("tag_origin");
  light_right.angles = v_ambulance gettagangles("tag_light_right");
  playfxontag(getfx("ambulance_siren"), light_right, "tag_origin");
}

intro_ambulance() {
  level thread intro_civ();
  level thread ambulance_van();
  level thread run_scene_first_frame("slums_intro_corpses");
  level thread intro_civilian_watch();
  level thread intro_digbat_watch();
  wait 0.5;
  dead_body = get_ais_from_scene("slums_intro_corpses");

  for(i = 0; i < dead_body.size; i++) {
    dead_body[i] ragdoll_death();
    wait 0.5;
  }

  flag_wait_any("ambulance_staff_killed", "ambulance_player_engaged");
  setmusicstate("DIGBAT_SURPRISE");
  count = 0;

  if(!flag("ambulance_staff_killed")) {
    a_staff = get_ai_group_ai("ambulance_staff");

    foreach(e_civ in a_staff)
    e_civ thread intro_civilian_saved();

    a_digbats = get_ai_group_ai("ambulance_digbats");

    foreach(e_digbat in a_digbats) {
      level thread run_scene("slums_intro_react_" + e_digbat.animname);
      e_digbat thread delay_thread(randomfloatrange(1, 3), ::play_digbat_dialog, count);
      count++;

      if(e_digbat.animname == "amb_digbat_1" || e_digbat.animname == "amb_digbat_3")
        e_digbat thread turn_into_melee_digbats("slums_intro_react_" + e_digbat.animname);
    }
  }

  flag_wait("slums_player_down");
  level.mason set_ignoreme(0);
  level.noriega set_ignoreme(0);
  end_scene("slums_ambulance");
  end_scene("slums_intro_corpses");
}

turn_into_melee_digbats(str_wait) {
  self endon("death");
  scene_wait(str_wait);
  self thread make_barbwire_digbat();
}

intro_civilian_saved() {
  self endon("death");
  self thread magic_bullet_shield();
  run_scene("slums_intro_saved_" + self.animname);
  run_scene("slums_intro_saved_loop_" + self.animname);
}

intro_civilian_watch() {
  level endon("ambulance_player_engaged");
  level thread run_scene("slums_intro_ambulance_loop_1");
  level thread run_scene("slums_intro_ambulance_loop_2");
  level thread run_scene("slums_intro_ambulance_loop_control");
  wait 20;
  level thread run_scene("slums_intro_ambulance_kill", 0.5);
  level thread civ_death_melee_bat();
}

civ_death_melee_bat() {
  count = 0;
  scene_wait("slums_intro_ambulance_kill");
  wait 1;
  a_digbats = get_ai_group_ai("ambulance_digbats");

  foreach(e_digbat in a_digbats) {
    e_digbat thread delay_thread(randomfloatrange(0.5, 1), ::play_digbat_dialog, count);
    count++;

    if(e_digbat.animname == "amb_digbat_1" || e_digbat.animname == "amb_digbat_3")
      e_digbat thread make_barbwire_digbat();
  }
}

play_digbat_dialog(num) {
  self endon("death");

  if(num == 0)
    self say_dialog("db1_enemy_forces_0");
  else if(num == 1)
    self say_dialog("db2_kill_them_0");
  else
    self say_dialog("db3_die_here_american_0");
}

intro_digbat_watch() {
  waittill_ai_group_cleared("ambulance_digbats");
  flag_set("ambulance_complete");
}

intro_player() {
  level endon("ambulance_staff_killed");
  run_scene("slums_intro_player");
  autosave_by_name("slums_start");
  self waittill_any("weapon_fired", "grenade_fire");
  level thread play_woods_ambulence_dialog();
  flag_set("ambulance_player_engaged");
  flag_wait("ambulance_complete");
  self set_ignoreme(1);
  flag_wait("slums_turn_off_player_ignore");
  self set_ignoreme(0);
}

intro_player_vo_1(ai_mason) {
  level.player say_dialog("okay_fucker_wh_001");
}

intro_player_vo_2(ai_mason) {
  level.player say_dialog("got_it_011");
}

intro_mason() {
  self set_ignoreall(1);
  self.grenadeawareness = 0;
  self disable_react();
  self.perfectaim = 1;
  self pushplayer(1);
  self setgoalnode(getnode("mason_slums_intro_cover", "targetname"));
  run_scene("slums_intro");
  level thread run_scene("slums_intro_loop");
  level thread player_door_kick();
  flag_wait("ambulance_complete");
  level clientnotify("dbid");
  setmusicstate("POST_DIGBAT");
  exploder(15011);
  end_scene("slums_intro_loop");
  run_scene("slums_into_building");

  if(!flag("slums_player_see_pistol_anim")) {
    level thread run_scene("slums_into_building_wait");
    flag_wait("slums_player_see_pistol_anim");
    end_scene("slums_into_building_wait");
  }

  level thread run_scene("slums_noriega_pistol");
  clip = get_model_or_models_from_scene("slums_noriega_pistol", "noriega_clip");
  clip hide();
  scene_wait("slums_noriega_pistol");
  level notify("noriega_pistol_animation_done");
  flag_set("slums_update_objective");

  if(!flag("slums_player_took_point")) {
    level thread run_scene("slums_noriega_pistol_wait");
    flag_wait("slums_player_took_point");
    end_scene("slums_noriega_pistol_wait");
  } else {
    a_models[0] = get_model_or_models_from_scene("slums_noriega_pistol", "noriega_hat");
    a_models[1] = get_model_or_models_from_scene("slums_noriega_pistol", "noriega_pistol");
    array_delete(a_models);
  }

  level.noriega attach("c_pan_noriega_cap", "", 1);
  self set_ignoreme(0);
  self set_ignoreall(0);
  self change_movemode("sprint");
  level thread slums_paired_movement();
  level thread veh_animate_pickup_trucks();
  level thread veh_animate_pickup_cars();
  trigger_use("trig_slums_start", "targetname");
}

#using_animtree("generic_human");

player_door_kick() {
  e_clip = getent("player_blocker_door_clip", "targetname");
  e_door = getent("player_blocker_door", "targetname");
  e_clip_linkto = getent("player_blocker_door_clip_2", "targetname");
  e_clip_linkto linkto(e_door);
  level waittill("slums_noriega_pistol_started");
  anim_length = getanimlength( % ch_pan_05_01_noriega_pistol_mason);
  wait(anim_length - 4);
  trigger_wait("trig_player_kick_door");
  level thread fxanim_reconstruct("overlook_building_explode");
  level thread run_scene("player_door_kick_door");
  level thread door_breach_wait();
  level thread run_scene("player_door_kick");
  e_clip trigger_off();
  wait 0.5;
  exploder(960);
  wait 1.5;
  flag_set("slums_player_took_point");
  flag_wait("move_intro_heli");
  level thread run_scene_first_frame("player_door_kick_door");
  e_clip trigger_on();
  e_clip_linkto delete();
}

door_breach_wait() {
  wait 0.5;
  playsoundatposition("evt_door_kick", (0, 0, 0));
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.4, 0.4, level.player.origin, 256, level.player);
  level clientnotify("drkck");
  level notify("kill_radio");
  setmusicstate("MAIN_FIGHT");
}

intro_noriega() {
  self set_ignoreme(1);
  self set_ignoreall(1);
  self.grenadeawareness = 0;
  self pushplayer(1);
  self change_movemode("cqb_walk");
  self set_noriega_run_anims();
}

set_noriega_run_anims() {
  self animscripts\anims::clearanimcache();
  self.a.combatrunanim = % ai_noriega_run_02;
  self.run_noncombatanim = self.a.combatrunanim;
  self.walk_combatanim = self.a.combatrunanim;
  self.walk_noncombatanim = self.a.combatrunanim;
}

main() {
  slums_drones_setup();
  slums_magic_rpg_setup();
  add_spawn_function_veh("slums_apache_stay", ::e_02_heli_think);
  add_spawn_function_veh("slums_zpu", ::e_10_zpu_think);
  add_spawn_function_veh("slums_overlook_apc", ::e_01_overlook_apc_think);
  add_spawn_function_veh("left_path_pdf_truck", ::e_03_alley_jeep);
  add_spawn_function_group("slums_apc_passenger", "targetname", ::e_13_apc_passenger_think);
  add_spawn_function_group("slums_right_alley_1", "script_noteworthy", ::ambience_right_alley_truck);
  level thread slums_spawn_functions();
  level thread air_ambience("slums_jet", "slums_jet_path", "slums_done");
  level thread air_ambience("slums_apache", "slums_apache_path", "slums_done", 8.0, 10.0);
  level thread ambience_alley_fire("slums_done");
  level thread ambient_alley_dog();
  level thread molotov_intro_van();
  level thread ac130_ambience("slums_done");
  level thread sky_fire_light_ambience("slums", "slums_done");
  level thread slums_cleanup_1();
  level thread e_01_left_path_cleanup();
  level thread clear_slum_southeast_ai();
  level thread clear_central_ai();
  wait 0.05;
  level thread e_01_left_path();
  level thread e_01_overlook();
  level thread e_02_apache_attack();
  level thread e_03_building_destroy();
  level thread e_04_apc_wall_crash();
  level thread e_13_apc_trigger_watch();
  level thread e_16_claymore_alley();
  level thread e_17_brute_force();
  level thread e_21_store_rummage();
  level thread e_22_woman_beating();
  level thread e_23_parking_lot();
  level thread slums_bottle_neck();
  level.vehiclespawncallbackthread = ::apc_announcements;
  level thread slums_heroes_watch();
  level thread building_player_breach();
  flag_wait("slums_done");
  level run_scene_first_frame("slums_breach_exit");
}

notetrack_function_end_mission(guy) {
  screen_fade_out(1, "black", 1);
  wait 0.2;
  rpc("clientscripts/_audio", "cmnLevelFadeout");
  nextmission();
}

building_player_breach() {
  trig_building_player_breach = getent("trig_building_player_breach", "targetname");
  trig_building_player_breach waittill("trigger");
  flag_set("slums_done");
  wait 0.05;
  trig_building_player_breach delete();
  level thread run_scene("player_door_kick_clinic");
  level thread notetrack_function_end_mission(self);
  wait 0.5;
  level thread rotate_the_clinic_door();
}

slums_nag_setup() {
  add_vo_to_nag_group("slums_nag", level.mason, "go_keep_moving_012");
  add_vo_to_nag_group("slums_nag", level.mason, "were_right_behind_013");
  add_vo_to_nag_group("slums_nag", level.mason, "keep_moving_014");
  add_vo_to_nag_group("slums_nag", level.mason, "we_gotta_pick_up_015");
  add_vo_to_nag_group("slums_nag", level.mason, "hurry_woods_hurr_016");
  add_vo_to_nag_group("slums_nag", level.mason, "dont_hold_up_h_ju_017");
  flag_wait("slums_player_down");
  level thread start_vo_nag_group_flag("slums_nag", "slums_done", 15, 5, 0, 3, ::slums_nag_check);
}

slums_nag_check() {
  return true;
}

slums_drones_setup() {
  sp_drone_ally = getent("slums_ally_drone", "targetname");
  maps\_drones::drones_assign_spawner("slums_ally_drone_trigger", sp_drone_ally);
  sp_drone_axis = getent("slums_axis_drone", "targetname");
  maps\_drones::drones_assign_spawner("slums_axis_drone_trigger", sp_drone_axis);
  maps\_drones::drones_assign_spawner("slums_apache_drones", sp_drone_axis);
  maps\_drones::drones_assign_spawner("slums_howitzer_drones", sp_drone_axis);
  sp_digbat_axis = getent("slums_digbat_drone", "targetname");
  maps\_drones::drones_assign_spawner("slums_digbat_drone_trigger", sp_digbat_axis);
}

slums_magic_rpg_setup() {
  a_triggers = getentarray("slums_rpg", "targetname");
  array_thread(a_triggers, ::slums_magic_rpg_think);
}

slums_magic_rpg_think() {
  self waittill("trigger");
  s_rpg_start = getstruct(self.target, "targetname");
  s_rpg_end = getstruct(s_rpg_start.target, "targetname");
  magicbullet("rpg_magic_bullet_sp", s_rpg_start.origin, s_rpg_end.origin);
  self delete();
}

slums_heroes_watch() {
  level endon("slums_done");
  t_position = getent("building_enter_front_door", "targetname");

  while(true) {
    if(level.mason istouching(t_position) && level.noriega istouching(t_position)) {
      flag_set("building_breach_ready");
      return;
    }

    wait 1;
  }
}

slums_cleanup_1() {
  level thread slum_clean_up_standoff();
  flag_wait("slums_bottleneck_reached");
  spawn_manager_kill("sm_slums_park_digbats", 1);
}

slum_clean_up_standoff() {
  flag_wait("sm_standoff_kill");
  spawn_manager_kill("sm_slums_standoff", 1);
}

e_01_left_path_cleanup() {
  flag_wait("left_path_cleanup");
  spawn_manager_kill("sm_slums_left_narrow", 1);
  a_ai = get_ai_group_ai("slums_left_narrow");

  foreach(ai in a_ai)
  ai kill();
}

init_slums_pre_mgnest_axis() {
  self endon("death");
  self magic_bullet_shield();
  self set_spawner_targets("pdf_street_front");
  flag_wait("slums_player_down");
  self stop_magic_bullet_shield();
  flag_wait("army_street_push");
  self set_spawner_targets("pdf_street_fallback");
}

e_01_army_street_push() {
  a_sp_allies = getentarray("slums_mg_nest_allies", "targetname");
  array_thread(a_sp_allies, ::add_spawn_function, ::magic_bullet_shield);
  a_slums_pre_mgnest_axis = getentarray("slums_pre_mgnest_axis", "targetname");
  array_thread(a_slums_pre_mgnest_axis, ::add_spawn_function, ::init_slums_pre_mgnest_axis);
  slums_mg_nest_allies = simple_spawn("slums_mg_nest_allies");
  spawn_manager_enable("sm_slums_axis_pre_mgnest");
  flag_wait("slums_player_down");
  delay_thread(5, ::flag_set, "army_street_push");
  flag_wait("army_street_push");
  trigger_use("army_street_push_color", "script_noteworthy");
  spawn_manager_disable("sm_slums_axis_pre_mgnest");
}

e_01_fire_building_civs() {
  a_fire_building_civilians = getentarray("fire_building_civilians", "targetname");
  array_thread(a_fire_building_civilians, ::add_spawn_function, ::init_fire_building_civilians);
  level thread run_scene("civs_building_01");
  level thread run_scene("civs_building_02");
  level thread run_scene("civs_building_03");
  level thread run_scene("civs_building_04");
  level thread run_scene("civs_building_05");
  level thread run_scene("civs_building_06");
}

init_fire_building_civilians() {
  self endon("death");
  nd_delete_fire_civs_array = [];
  nd_delete_fire_civs_array[nd_delete_fire_civs_array.size] = getnode("delete_fire_civs_1", "targetname");
  nd_delete_fire_civs_array[nd_delete_fire_civs_array.size] = getnode("delete_fire_civs_2", "targetname");
  nd_delete_fire_civs_array[nd_delete_fire_civs_array.size] = getnode("delete_fire_civs_3", "targetname");
  nd_delete_fire_civs_array[nd_delete_fire_civs_array.size] = getnode("delete_fire_civs_4", "targetname");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.goalradius = 32;

  while(true) {
    for(i = 0; i < nd_delete_fire_civs_array.size; i++) {
      self setgoalpos(nd_delete_fire_civs_array[i].origin);
      self waittill("goal");

      if(level.player is_player_looking_at(self.origin, 0.5, 1))
        continue;
      else
        self die();
    }
  }
}

e_01_left_path() {
  trigger_wait("trig_left_path_truck", "script_noteworthy");
  left_path_pdf_truck = spawn_vehicle_from_targetname_and_drive("left_path_pdf_truck");
}

e_01_overlook() {
  level thread e_01_apc_digbat_alley();
  level thread e_01_army_street_push();
  flag_wait("slums_player_down");
  autosave_by_name("slums_start");
  level thread dialog_building_collapse();
  level thread dialog_balcony_enemies();
  level thread dialog_rooftop();
  level thread dialog_van_jump();
  level thread park_movement_vo();
  level thread magic_alley_movement();
  level thread dialog_church();
  v_hydrant_pos = getstruct("slums_hydrant", "targetname").origin;
  radiusdamage(v_hydrant_pos, 36, 350, 349);
  trigger_wait("trig_lookat_burning_building");

  iprintln("triggering burning building");

  stop_exploder(15011);
  level notify("fxanim_overlook_building_start");
  level thread e_01_fire_building_civs();
  level.player playsound("fxa_pan_overwatch_collapse");
  a_models = getentarray("overlook_hide", "targetname");
  array_delete(a_models);
}

e_01_apc_digbat_alley() {
  level endon("kill_e_01_apc_digbat_alley");
  a_apc_alley_army = getentarray("apc_alley_army", "targetname");
  array_thread(a_apc_alley_army, ::add_spawn_function, ::magic_bullet_shield);
  ai_alley_apc_gunner = getent("alley_apc_gunner", "targetname");
  ai_alley_apc_gunner add_spawn_function(::magic_bullet_shield);
  spawn_vehicle_from_targetname_and_drive("slums_overlook_apc");
  flag_wait("spawn_balcony_digbat");
  trigger_wait("digbat_alley_rpg", "script_noteworthy");

  foreach(guy in a_apc_alley_army) {
    if(isalive(guy))
      guy stop_magic_bullet_shield();
  }
}

init_apc_alley_digbats() {
  self endon("death");
  n_rand_goal_radius = randomintrange(32, 128);
  self.goalradius = n_rand_goal_radius;
  nd_apc_death = getnode(self.target, "targetname");
  self setgoalnode(nd_apc_death);
  self waittill("goal");
  self die();
}

e_01_overlook_advance(str_aigroup) {
  a_allies = get_ai_group_ai(str_aigroup);
  a_nodes = getnodearray(str_aigroup, "targetname");

  for(i = 0; i < a_allies.size; i++) {
    if(isalive(a_allies[i])) {
      a_allies[i] setgoalnode(a_nodes[i]);
      wait(randomfloatrange(1, 3));
    }
  }
}

e_01_overlook_attach_strobe(e_thrower) {
  e_thrower attach("t5_weapon_tactical_insertion_world", "tag_weapon_left");
  e_thrower.e_strobe = spawn("script_model", e_thrower.origin);
  e_thrower.e_strobe setmodel("tag_origin");
  e_thrower.e_strobe linkto(e_thrower, "tag_weapon_left");
  playfxontag(getfx("ir_strobe"), e_thrower.e_strobe, "tag_origin");
  e_thrower.e_strobe playloopsound("fly_irstrobe_beep", 0.1);
}

e_01_overlook_detach_strobe(e_thrower) {
  e_thrower detach("t5_weapon_tactical_insertion_world", "tag_weapon_left");
  e_strobe = e_thrower.e_strobe;
  e_strobe unlink();
  wait 5;
  e_strobe delete();
}

e_01_overlook_apc_think() {
  self endon("death");
  self veh_magic_bullet_shield(1);
  self maps\_turret::set_turret_burst_parameters(1.5, 5.0, 0.5, 1.0, 4);
  self enable_turret(4);
  trigger_wait("send_apc_rpg", "targetname");
  s_start_pos = get_struct("rpg_apc_scene_start", "targetname");
  e_rpg = magicbullet("rpg_magic_bullet_sp", s_start_pos.origin, get_struct(s_start_pos.target, "targetname").origin);

  while(isDefined(e_rpg))
    wait 0.05;

  self maps\_turret::stop_turret(4);
  self veh_magic_bullet_shield(0);
  self notify("death");
}

e_03_alley_jeep() {
  self maps\_turret::set_turret_burst_parameters(1.5, 3.0, 0.5, 1.0, 1);
}

#using_animtree("fakeshooters");

e_02_apache_attack() {
  flag_wait_any("slums_e_02_start", "left_path_cleanup");
  autosave_by_name("slums_apache");
  maps\_drones::drones_start("slums_apache_drones");
  spawn_manager_enable("sm_slums_apache_critical_guys");
  flag_wait("fxanim_gazebo_start");
  wait 2;
  s_rpg_start = getstruct("apache_rpg_start", "targetname");
  s_rpg_end = getstruct(s_rpg_start.target, "targetname");
  magicbullet("rpg_magic_bullet_sp", s_rpg_start.origin, s_rpg_end.origin);
  wait 2;
  flag_set("slums_apache_retreat");
  maps\_drones::drones_delete("slums_apache_drones");
  level notify("apache_target_stop");
  a_pdf = getentarray("apache_target", "script_noteworthy");

  foreach(e_drone in a_pdf) {
    if(isDefined(e_drone)) {
      e_drone thread drone_dodeath( % ai_death_collapse_in_place, "remove_drone_corpses");
      wait(randomfloatrange(0.5, 1.0));
    }
  }
}

e_02_heli_think() {
  self setteam("allies");
  self veh_magic_bullet_shield(1);
  self veh_toggle_tread_fx(0);
  flag_wait("slums_e_02_helicopter");
  fxanim_reconstruct("gazebo_collapse");
  level thread e_02_gazebo_destruction();
  level waittill("blow_gazebo");
  a_target_pos = getstructarray("capitol_hill_target", "targetname");
  e_target = spawn("script_origin", a_target_pos[0].origin);
  self set_turret_target(e_target, (0, 0, 0), 1);
  self set_turret_target(e_target, (0, 0, 0), 2);
  self thread fire_turret_for_time(-1, 1);
  self thread fire_turret_for_time(-1, 2);
  self setlookatent(e_target);
  level thread move_gazebo_target(e_target);
  flag_wait("slums_apache_retreat");
  self clearlookatent();
  self stop_turret(1);
  self stop_turret(2);
  e_target delete();
  stop_exploder(5201);
  s_retreat = getstruct("slums_apache_retreat", "targetname");
  self setvehgoalpos(s_retreat.origin);
  wait 4;
  s_retreat = getstruct("slums_apache_retreat_end", "targetname");
  self setvehgoalpos(s_retreat.origin);
  wait 10;
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

move_gazebo_target(e_target) {
  a_target_pos = getstructarray("capitol_hill_target", "targetname");

  while(!flag("slums_apache_retreat")) {
    e_target moveto(a_target_pos[randomint(a_target_pos.size)].origin, 3.0);
    e_target waittill("movedone");
  }
}

e_02_gazebo_destruction() {
  level thread notify_on_lookat_trigger("see_gazebo_flank", "blow_gazebo");
  level thread notify_on_lookat_trigger("see_gazebo_street", "blow_gazebo");
  level thread notify_on_lookat_trigger("gazebo_lookat_trigger_northwest", "blow_gazebo");
  level thread notify_on_lookat_trigger("gazebo_lookat_trigger_northeast", "blow_gazebo");
  exploder(5201);
  level thread gazebo_audio_loop();
  level waittill("blow_gazebo");
  level notify("fxanim_gazebo_start");
  level.player say_dialog("reds_stay_back_our_helos_0");
  flag_set("fxanim_gazebo_start");
}

gazebo_audio_loop() {
  gaz_sound = spawn("script_origin", (24465, 28335, 720));
  gaz_sound playloopsound("fxa_gzbo_loop", 2);
  gaz_sound thread gazebo_impacts();
  level waittill("blow_gazebo");
  gaz_sound stoploopsound(2.5);
  wait 10;
  gaz_sound delete();
}

gazebo_impacts() {
  level endon("blow_gazebo");

  while(true) {
    self playsound("fxa_gzbo_hit_prj");
    wait(randomfloatrange(0.02, 0.1));
  }
}

e_03_building_destroy() {
  a_library_destroyed = getentarray("jc_library_destroyed", "targetname");

  foreach(e_piece in a_library_destroyed)
  e_piece hide();

  trigger_wait("sm_slums_building_destroy");
  maps\_drones::drones_start("slums_howitzer_drones");
  trigger_wait("trigger_slums_building_destroy");
  autosave_by_name("slums_building");
  s_start = getstruct("slums_howitzer_start", "targetname");
  s_end = getstruct(s_start.target, "targetname");
  magicbullet("ac130_howitzer_minigun", s_start.origin, s_end.origin);
  a_pdf = getentarray("howitzer_target", "script_noteworthy");

  foreach(e_drone in a_pdf)
  e_drone thread drone_fakedeath(1);

  exploder(550);
  level notify("fxanim_library_start");
  wait 0.1;

  foreach(e_piece in a_library_destroyed)
  e_piece show();

  a_library_pristine = getentarray("jc_library_intact", "targetname");
  array_delete(a_library_pristine);
}

e_04_apc_wall_crash() {
  trigger_wait("slums_e4_start");
  autosave_by_name("slums_crash");
  level notify("remove_drone_corpses");
  s_pos = getstruct("APC_StoreCrash", "targetname");
  e_sound = spawn("script_origin", s_pos.origin);
  level notify("fxanim_laundromat_wall_start");
  e_sound playsound("evt_apc_wall_crash");
  run_scene("slums_apc_wall_crash");
  e_sound delete();
  wall_clip = getent("apc_marine_guard_clip", "targetname");
  wall_clip connectpaths();
  wall_clip delete();
  level thread spawn_manager_enable("apc_marine_guard");
}

e_07_mg_nest() {
  e_turret = getent("slums_mg_nest_turret", "targetname");
  n_fire_min = 1.5;
  n_fire_max = 4.1;
  n_wait_min = 1.3;
  n_wait_max = 2.6;
  e_turret maps\_turret::set_turret_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max);
}

basketball_courtmg() {
  e_turret = getent("basketcourt_mg", "targetname");
  n_fire_min = 1.5;
  n_fire_max = 4.1;
  n_wait_min = 1.3;
  n_wait_max = 2.6;
  e_turret maps\_turret::set_turret_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max);
}

church_left_mg() {
  e_turret = getent("church_left_mg", "targetname");
  n_fire_min = 1.5;
  n_fire_max = 4.1;
  n_wait_min = 1.3;
  n_wait_max = 2.6;
  e_turret maps\_turret::set_turret_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max);
}

church_right_mg() {
  e_turret = getent("church_right_mg", "targetname");
  n_fire_min = 1.5;
  n_fire_max = 4.1;
  n_wait_min = 1.3;
  n_wait_max = 2.6;
  e_turret maps\_turret::set_turret_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max);
}

e_07_delete_on_goal(goal_node_targetname) {
  nd_goal = getnode(goal_node_targetname, "targetname");
  self force_goal(nd_goal);
  self delete();
}

e_10_zpu_think() {
  self endon("death");
  a_target_pos = getstructarray("slums_zpu_target", "targetname");
  e_target = spawn("script_origin", a_target_pos[0].origin);
  self setturrettargetent(e_target);
  self thread e_10_zpu_burst_fire();
  self thread e_10_zpu_challenge_watch();

  while(self.riders.size) {
    wait 5;
    e_target moveto(a_target_pos[randomint(a_target_pos.size)].origin, 3.0);
  }
}

e_10_zpu_burst_fire() {
  self endon("death");

  while(self.riders.size) {
    n_burst_time = randomintrange(25, 50);

    for(i = 0; i < n_burst_time; i++) {
      self fireweapon();
      wait 0.05;
    }

    wait(randomfloatrange(0.5, 1.5));
  }
}

e_10_zpu_challenge_watch() {
  self waittill("death");
  level notify("slums_zpu_destroyed");
}

e_11_sniper_think() {
  self endon("death");
  self set_ignoreme(1);
  self set_ignoreall(1);
  self thread e_11_sniper_shot();
  s_target = getstruct(self.script_noteworthy, "targetname");
  e_focus_target = spawn("script_origin", s_target.origin);

  while(!flag("slums_shot_at_snipers"))
    self shoot_at_target(e_focus_target);

  self stop_shoot_at_target();
  e_focus_target delete();
  self shoot_at_target(level.player, undefined, -1);
  self set_ignoreall(0);
}

e_11_sniper_shot() {
  self waittill_any("damage", "death");
  flag_set("slums_shot_at_snipers");
}

e_13_apc_passenger_think() {
  self endon("death");
  self thread magic_bullet_shield();
  e_goal_volume = getent("slums_apc_drop_goal", "targetname");
  self.fixednode = 0;
  self setgoalvolumeauto(e_goal_volume);
  self waittill("exit_vehicle");
  self findbestcovernode();
  self delay_thread(60, ::stop_magic_bullet_shield);
}

apc_announcements(vehicle) {
  vehicle endon("death");
  vehicle endon("delete");
  wait 1;

  if(isDefined(vehicle.model) && vehicle.model == "veh_t6_mil_m113") {
    while(isDefined(vehicle)) {
      wait(randomfloatrange(3, 6));
      vehicle playsound("vox_pan_2_01_024A_pa", "sounddone");
      vehicle waittill("sounddone");
      wait(randomfloatrange(3, 6));
      vehicle playsound("vox_pan_2_01_025A_pa", "sounddone");
      vehicle waittill("sounddone");
    }
  }
}

e_13_apc_trigger_watch() {
  t_left_apc = getent("trigger_slums_apc_left", "script_noteworthy");
  t_right_apc = getent("trigger_slums_apc_right", "script_noteworthy");
  waittill_any_ents(t_left_apc, "trigger", t_right_apc, "trigger");
}

e_15_dumpster_push() {
  m_clip = getent("slums_dumpster_clip", "targetname");
  m_dumpster = getent("slums_dumpster", "targetname");
  m_clip linkto(m_dumpster);
  trigger_wait("slums_e_15_start");
  playsoundatposition("evt_dumpster", (22976, 27216, 452));
  run_scene("dumpster_push");
  e_volume = getent("slums_gv_5_15_axis", "targetname");
  a_pushers = get_ai_group_ai("slums_dumpster_pushers");

  foreach(e_pusher in a_pushers)
  e_pusher setgoalvolumeauto(e_volume);

  m_clip disconnectpaths();
}

e_16_claymore_alley() {
  a_claymores = getentarray("slums_claymore", "targetname");

  foreach(m_claymore in a_claymores) {
    playfxontag(getfx("claymore_laser"), m_claymore, "tag_fx");
    m_claymore thread e_16_satchel_damage();
    m_claymore thread e_16_claymore_detonation();
  }
}

e_16_satchel_damage() {
  self endon("death");
  self.health = 100;
  self setcandamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self waittill("damage");
  wait 0.05;
  self thread e_16_detonate();
}

e_16_claymore_detonation() {
  self endon("death");
  detonateradius = 192;
  damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - detonateradius), 1, detonateradius, detonateradius * 2);

  while(true) {
    damagearea waittill("trigger", ent);

    if(isplayer(ent)) {
      if(ent damageconetrace(self.origin, self) > 0) {
        wait 0.4;
        self thread e_16_detonate();
        return;
      }
    }
  }
}

e_16_detonate() {
  playfx(getfx("claymore_explode"), self gettagorigin("tag_fx"));
  radiusdamage(self gettagorigin("tag_fx"), 192, 250, 500);
  self delete();
}

e_17_brute_force() {
  level endon("slums_done");
  t_start = getent("slums_brute_force", "targetname");
  t_start sethintstring(&"PANAMA_OPEN_GRATE");
  t_start setcursorhint("HINT_NOICON");
  t_start trigger_off();
  level.player waittill_player_has_brute_force_perk();
  wait 0.5;
  run_scene_first_frame("brute_force");
  t_start trigger_on();
  set_objective(level.obj_interact, t_start, "interact");
  t_start waittill("trigger");
  set_objective(level.obj_interact, t_start, "remove");
  t_start delete();
  clip = getent("brute_force_player_clip", "targetname");
  clip delete();
  level.player set_ignoreme(1);
  level thread run_scene("brute_force");
  run_scene("brute_force_player");
  level.player set_ignoreme(0);
  level.player giveweapon("irstrobe_dpad_sp");
  level.player setactionslot(4, "weapon", "irstrobe_dpad_sp");
  level.player thread ir_strobe_watch();
  level.player set_temp_stat(2, 1);
  level notify("slums_soldier_rescued");
  autosave_by_name("panama_slum");
}

e_19_molotov_digbat_alley() {
  flag_wait("spawn_balcony_digbat");
  level run_scene_first_frame("slums_molotov_throw_left_alley");
  trigger_wait("trig_digbat_alley_left", "targetname");
  e_digbat = get_ais_from_scene("slums_molotov_throw_left_alley", "molotov_digbat");
  flag_set("alley_molotov_digbat_animating");
  level thread run_scene("slums_molotov_throw_left_alley");
  wait 5;
  flag_clear("alley_molotov_digbat_animating");
}

e_19_molotov_digbat() {
  level thread e_19_left_side();
  level thread e_19_right_side();
  flag_wait("slums_molotov_triggered");
  t_left = getent("e_19_trigger_molotov_left", "targetname");
  t_right = getent("e_19_trigger_molotov_right", "targetname");
  t_left delete();
  t_right delete();
}

e_19_attach(e_digbat) {
  e_digbat attach("t6_wpn_molotov_cocktail_prop_world", "tag_weapon_left");
  playfxontag(getfx("molotov_lit"), e_digbat, "TAG_FX");
}

e_19_shot(e_digbat) {
  playfxontag(getfx("on_fire_tor"), e_digbat, "J_Spine4");
  playfxontag(getfx("on_fire_leg"), e_digbat, "J_Hip_LE");
  playfxontag(getfx("on_fire_leg"), e_digbat, "J_Hip_RI");
  playfxontag(getfx("on_fire_arm"), e_digbat, "J_Elbow_LE");
  playfxontag(getfx("on_fire_arm"), e_digbat, "J_Elbow_RI");
}

e_19_left_side() {
  level endon("e_19_molotov_triggered");
  trigger_wait("e_19_trigger_molotov_left");
  level run_scene("slums_molotov_throw_left");
}

e_19_right_side() {
  level endon("e_19_molotov_triggered");
  trigger_wait("e_19_trigger_molotov_right");
  run_scene("slums_molotov_throw_right");
}

e_21_store_rummage() {
  trigger_wait("slums_e_21_start");
}

e_22_woman_beating() {
  trigger_wait("slums_e_22_start");
  level thread run_scene("beating_loop");
  level thread run_scene("beating_corpse");
  wait 0.1;
  digbat = get_ais_from_scene("beating_loop", "e_22_digbat");
  digbat endon("death");
  trigger = trigger_wait("slums_e_22_react");
  trigger delete();
  run_scene("beating_reaction");
}

e_23_parking_lot() {
  trigger_wait("slums_e_23_start");
  level thread run_scene("parking_jump");
  s_window_start = getstruct("e_23_window_damage", "targetname");
  s_window_end = getstruct(s_window_start.target, "targetname");
  level thread run_scene("parking_window");
  level thread mn_moveup_after_digbat_parking();
  wait 0.5;

  for(i = 0; i < 5; i++) {
    magicbullet("ak47_sp", s_window_start.origin, s_window_end.origin);
    wait 0.05;
  }
}

slums_bottle_neck() {
  trigger_wait("sm_slums_bottleneck");
  spawn_manager_enable("sm_slums_bottleneck_critical");
}

ambience_right_alley_truck() {
  self endon("death");
  self waittill("exit_vehicle");
  self.goalradius = 32;
  s_goal = getstruct("slums_right_alley_1", "targetname");
  self setgoalpos(s_goal.origin);
  self waittill("goal");
  self delete();
}

ambience_alley_fire(flag_ender) {
  a_triggers = getentarray("slums_fakefire_lookat", "targetname");
  array_thread(a_triggers, ::ambient_alley_fire_think, flag_ender);
}

ambient_alley_fire_think(flag_ender) {
  a_fire_pos = getstructarray(self.target, "targetname");

  while(!flag(flag_ender)) {
    self waittill("trigger");
    level thread ambient_alley_fire_burst(a_fire_pos[randomint(a_fire_pos.size)]);
    wait 0.5;
  }

  self delete();
}

ambient_alley_fire_burst(s_start) {
  v_start = s_start.origin;
  v_end = getstruct(s_start.target, "targetname").origin;
  str_weapon = "ak47_sp";

  if(isDefined(s_start.script_noteworthy) && s_start.script_noteworthy == "ally")
    str_weapon = "m16_sp";

  for(i = 0; i < 10; i++) {
    magicbullet(str_weapon, v_start, v_end);
    wait 0.05;
  }
}

ambient_alley_dog() {
  level endon("slums_done");
  t_scare = trigger_wait("slums_dog_scare");
  a_dogs = getentarray("slums_dog", "script_noteworthy");
  nd_delete = getnode("slums_dog_goal", "targetname");

  foreach(ai_dog in a_dogs) {
    if(isalive(ai_dog)) {
      ai_dog thread ambient_alley_dog_retreat(nd_delete);
      wait(randomfloatrange(1.0, 3.0));
    }
  }

  t_scare delete();
}

ambient_alley_dog_retreat(nd_delete) {
  self endon("death");
  self.goalradius = 32;
  self setgoalpos(nd_delete.origin);
  self waittill("goal");
  self delete();
}

dog_that_runs_on_slum_entrance() {
  trigger_wait("trig_slums_start_dog", "targetname");
  start_struct = getstruct("dog_starting_struct", "targetname");
  e_dog_spawner = getent("dog_random_spawner", "targetname");
  e_dog_spawner.origin = start_struct.origin;
  e_dog_spawner.angles = start_struct.angles;
  e_dog_spawner.count = 100;
  e_dog = simple_spawn_single(e_dog_spawner);
  e_dog.ignoreme = 1;
  e_dog.ignoreall = 1;
  e_dog.goalradius = 64;
  e_dog endon("death");
  end_struct = getstruct(start_struct.target, "targetname");
  e_dog setgoalpos(end_struct.origin);
  e_dog waittill("goal");
  e_dog delete();
}

ambient_slums_dog_init() {
  a_dog_triggers = getentarray("trig_run_a_dog", "script_noteworthy");
  array_thread(a_dog_triggers, ::ambient_slums_dog);
}

ambient_slums_dog() {
  self waittill("trigger");
  start_struct = getstruct(self.target, "targetname");
  end_struct = getstruct(start_struct.target, "targetname");
  e_dog_spawner = getent("dog_random_spawner", "targetname");
  e_dog_spawner.origin = start_struct.origin;
  e_dog_spawner.angles = start_struct.angles;
  e_dog_spawner.count = 100;
  e_dog = simple_spawn_single(e_dog_spawner);
  e_dog.ignoreme = 1;
  e_dog.ignoreall = 1;
  e_dog.goalradius = 64;

  while(isDefined(end_struct)) {
    e_dog setgoalpos(end_struct.origin);
    e_dog waittill("goal");

    if(isDefined(end_struct.target))
      end_struct = getstruct(end_struct.target, "targetname");
    else
      end_struct = undefined;
  }

  e_dog delete();
}

cleanup_slums_think() {
  level thread cleanup_progression_passed_digbat_parking_lot();
  level thread cleanup_initial_mgnest_through_digbat_parking_lot();
}

cleanup_slums_ai_by_targetname(str_targetname) {
  a_guys = getentarray(str_targetname, "targetname");

  foreach(e_guy in a_guys)
  e_guy delete();
}

cleanup_progression_passed_digbat_parking_lot() {
  flag_wait("cleanup_before_digbat_parking_lot");
  level notify("cleanup_warp_around_parking_lot");
  t_for_warp = getent("trig_player_moving_around_parking_lot", "targetname");
  t_for_warp delete();
  flag_set("spawn_balcony_digbat");
  trigger_use("send_apc_rpg", "targetname");
  spawn_manager_kill("sm_apc_alley_digbats");
  wait 0.05;
  level notify("kill_e_01_apc_digbat_alley");
  a_guys = getentarray("apc_alley_army_ai", "targetname");
  array_thread(a_guys, ::bloody_death);
  wait 0.05;
  cleanup_slums_ai_by_targetname("sm_apc_alley_digbats_ai");
  cleanup_slums_ai_by_targetname("slums_mg_nest_allies_ai");
}

cleanup_initial_mgnest_through_digbat_parking_lot() {
  trigger_wait("trig_warp_passed_apc", "targetname");
  t_for_warp = getent("trig_player_moving_around_parking_lot", "targetname");

  if(isDefined(t_for_warp))
    t_for_warp delete();

  level endon("cleanup_warp_around_parking_lot");
  level notify("kill_e_01_apc_digbat_alley");
  cleanup_slums_ai_by_targetname("apc_alley_army_ai");
  trig_digbat_parking_lot = getent("slums_e_23_start", "targetname");

  if(isDefined(trig_digbat_parking_lot))
    trig_digbat_parking_lot delete();

  a_spawn_managers = array("sm_slums_axis_mgnest", "sm_slums_axis_pre_mgnest", "sm_rooftop_and_windows_alley", "sm_slums_initial_retreat", "sm_digbat_parking");

  foreach(str_sm in a_spawn_managers) {
    spawn_manager_kill(str_sm, 1);
    wait 0.05;
  }

  foreach(str_sm in a_spawn_managers) {
    a_guys = get_ai_from_spawn_manager(str_sm, 1);

    foreach(e_guy in a_guys)
    e_guy delete();

    wait 0.05;
  }
}

slums_paired_movement() {
  level.mason disable_ai_color();
  level.noriega disable_ai_color();
  nd_noriega_start = getnodearray("node_noriega_path_start", "targetname");
  nd_mason_start = getnodearray("node_mason_path_start", "targetname");
  trigger_wait("trig_slums_start");
  level.mason thread slums_go_to_node_using_funcs(nd_mason_start);
  level.noriega thread slums_go_to_node_using_funcs(nd_noriega_start);
  level thread move_up_script_logic();
  level thread cleanup_slums_think();
}

move_up_script_logic() {
  level thread mn_moveup_after_mg_nest();
  level thread mn_moveup_from_dumpster_to_wall();
  level thread mn_moveup_to_digbat_parking();
  level thread mn_moveup_after_apache_attack();
  level thread mn_move_along_cafe_wall();
  level thread mn_moveup_into_bottleneck_right();
  level thread mn_moveup_to_library();
  level thread mn_move_passed_the_library();
  level thread mn_moveup_church();
  level thread mn_warp_move_around_parking_lot();
  level thread mn_warp_straight_passed_apc();
  level thread mn_warp_upper_left_corner();
  level thread mn_warp_before_digbat_beatdown();
  level thread mn_warp_after_intruder_hallway();
  level thread mw_warp_end_failsafe();
}

warp_me_in_slums_logic(str_start_node) {
  self notify("stop_going_to_node_slums");
  self.disableexits = 1;
  self.disablearrivals = 1;

  if(isDefined(self.slums_current_scene))
    end_scene(self.slums_current_scene);

  nd_warp_point = getnode(str_start_node, "targetname");
  self forceteleport(nd_warp_point.origin, nd_warp_point.angles);

  if(isDefined(nd_warp_point.target)) {
    nd_start_point = getnodearray(nd_warp_point.target, "targetname");
    self thread slums_go_to_node_using_funcs(nd_start_point);
  }
}

slums_go_to_node_using_funcs(node, get_target_func, set_goal_func_quits, require_player_dist) {
  if(!isDefined(get_target_func))
    get_target_func = ::slums_get_target_nodes;

  if(!isDefined(set_goal_func_quits))
    set_goal_func_quits = maps\_spawner::go_to_node_set_goal_node;

  self endon("stop_going_to_node_slums");
  self endon("death");

  for(;;) {
    node = get_least_used_from_array(node);
    player_wait_dist = require_player_dist;

    if(isDefined(node.script_requires_player)) {
      if(node.script_requires_player > 1)
        player_wait_dist = node.script_requires_player;
      else
        player_wait_dist = 256;

      node.script_requires_player = 0;
    }

    if(node.type == "Path" || isDefined(node.script_string) && node.script_string == "anim_waitscene")
      self.disablearrivals = 1;
    else {
      self.disableexits = 0;
      self.disablearrivals = 0;
    }

    if(isDefined(node.script_radius))
      self.goalradius = node.radius;
    else
      self.goalradius = 32;

    if(!isDefined(self.slum_state) || self.slum_state != "moving")
      self set_slums_moving_ai_params();

    if(isDefined(node.script_string)) {
      if(issubstr(node.script_string, "notify")) {
        a_str = strtok(node.script_string, "_");
        level notify(a_str[1]);
      }
    }

    if(!isDefined(node.script_waittill) || node.script_waittill != "none") {
      [
        [set_goal_func_quits]
      ](node);
      self waittill("goal");
    }

    if(node.type != "Path") {
      self set_slums_at_cover_ai_params();

      if(self == level.mason)
        level thread autosave_by_name("autosave_" + node.targetname);
    }

    if(isDefined(node.script_string)) {
      a_string_tokens = strtok(node.script_string, "_");

      if(a_string_tokens[0] == "anim") {
        if(a_string_tokens[1] == "waitscene") {
          if(flag("slum_scene_waiting")) {
            self setgoalnode(getnode(node.target, "targetname"));
            flag_clear("slum_scene_waiting");
            wait 0.1;
          } else {
            flag_set("slum_scene_waiting");
            flag_waitopen("slum_scene_waiting");
          }
        } else if(a_string_tokens[1] == "coverwall") {
          if(self == level.mason)
            level.noriega notify("stop_going_to_node_slums");
          else
            level.mason notify("stop_going_to_node_slums");

          level.noriega.slums_current_scene = "slums_critical_path_along_the_wall_noriega";
          level.mason.slums_current_scene = "slums_critical_path_along_the_wall_mason";
          run_scene("slums_critical_path_along_the_wall_mason", 0.5);
          level.noriega.slums_current_scene = undefined;
          level.mason.slums_current_scene = undefined;

          if(self == level.mason) {
            nd_start_point = getnodearray("nd_start_after_wall_noriega", "targetname");
            level.noriega thread slums_go_to_node_using_funcs(nd_start_point);
          } else {
            nd_start_point = getnodearray("nd_start_after_wall_mason", "targetname");
            level.mason thread slums_go_to_node_using_funcs(nd_start_point);
          }
        } else if(a_string_tokens[1] == "coverstairs") {
          if(self == level.mason)
            level.noriega notify("stop_going_to_node_slums");
          else
            level.mason notify("stop_going_to_node_slums");

          level.noriega.slums_current_scene = "slums_critical_path_before_library";
          level.mason.slums_current_scene = "slums_critical_path_before_library";
          run_scene("slums_critical_path_before_library", 1);
          level.noriega.slums_current_scene = undefined;
          level.mason.slums_current_scene = undefined;

          if(self == level.mason) {
            nd_start_point = getnodearray("nd_noriega_start_after_stair_cover", "targetname");
            wait 1;
            level.noriega thread slums_go_to_node_using_funcs(nd_start_point);
          } else {
            nd_start_point = getnodearray("nd_mason_start_after_stair_cover", "targetname");
            level.mason thread slums_go_to_node_using_funcs(nd_start_point);
          }
        } else if(a_string_tokens[1] == "behindcar") {
          if(self == level.mason)
            level.noriega notify("stop_going_to_node_slums");
          else
            level.mason notify("stop_going_to_node_slums");

          iprintln("animating at car");

          level.noriega.slums_current_scene = "slums_critical_path_first_car";
          level.mason.slums_current_scene = "slums_critical_path_first_car";
          run_scene("slums_critical_path_first_car", 1);
          run_scene("slums_critical_path_first_car_exit", 1);
          level.noriega.slums_current_scene = undefined;
          level.mason.slums_current_scene = undefined;
          level.mason.disablecoverab = 1;

          iprintln("done animating at car");

          if(self == level.mason) {
            nd_start_point = getnodearray("nd_start_after_car_noriega", "targetname");
            wait 1;
            level.noriega thread slums_go_to_node_using_funcs(nd_start_point);
          } else {
            nd_start_point = getnodearray("nd_start_after_car_mason", "targetname");
            level.mason thread slums_go_to_node_using_funcs(nd_start_point);
          }
        } else if(a_string_tokens[1] == "gobarrels") {
          if(self == level.mason)
            level.noriega notify("stop_going_to_node_slums");
          else
            level.mason notify("stop_going_to_node_slums");

          level.noriega.slums_current_scene = "slums_critical_path_to_barrels_from_wall_noriega";
          level.mason.slums_current_scene = "slums_critical_path_to_barrels_from_wall_mason";
          level thread run_scene("slums_critical_path_to_barrels_from_wall_noriega");
          run_scene("slums_critical_path_to_barrels_from_wall_mason", 1);
          level.noriega.slums_current_scene = undefined;
          level.mason.slums_current_scene = undefined;
          level.mason.disablecoverab = 0;

          if(self == level.mason) {
            nd_start_point = getnodearray("nd_start_after_barrels_noriega", "targetname");
            wait 1;
            level.noriega thread slums_go_to_node_using_funcs(nd_start_point);
          } else {
            nd_start_point = getnodearray("nd_start_after_barrels_mason", "targetname");
            level.mason thread slums_go_to_node_using_funcs(nd_start_point);
          }
        }
      }
    }

    if(isDefined(node.script_flag_set))
      flag_set(node.script_flag_set);

    if(isDefined(node.script_flag_clear))
      flag_set(node.script_flag_clear);

    if(isDefined(node.script_flag_wait)) {
      if(isDefined(node.script_timer)) {
        wait(node.script_timer);
        flag_set(node.script_flag_wait);
      }

      flag_wait(node.script_flag_wait);

      if(self == level.mason) {
        flag_wait("noriega_moved_now_move_mason");
        flag_clear("noriega_moved_now_move_mason");
      }

      if(self == level.noriega)
        delay_thread(1.0, ::flag_set, "noriega_moved_now_move_mason");
    } else if(isDefined(node.script_timer))
      wait(node.script_timer);

    if(isDefined(node.script_aigroup))
      waittill_ai_group_cleared(node.script_aigroup);

    if(!isDefined(node.target)) {
      break;
    }

    nextnode_array = [
      [get_target_func]
    ](node.target);

    if(!nextnode_array.size) {
      break;
    }

    node = nextnode_array;
  }

  self notify("reached_path_end");
}

get_animation_endings() {
}

print_out_end_location_of_animation(_anim, str_align_node, animname) {
  align_node = getstruct(str_align_node, "targetname");
  start_org = getstartorigin(align_node.origin, (0, 0, 0), _anim);
  start_ang = getstartangles(align_node.origin, (0, 0, 0), _anim);
  endpoint = start_org;
  iprintln(animname + " anim starts at: " + endpoint[0] + " " + endpoint[1] + " " + endpoint[2]);
  temp_ent = spawn("script_origin", start_org);
  temp_ent.angles = start_ang;
  localdeltavector = getmovedelta(_anim, 0, 1);
  endpoint = temp_ent localtoworldcoords(localdeltavector);
  iprintln(animname + " anim ends at: " + endpoint[0] + " " + endpoint[1] + " " + endpoint[2]);
}

set_slums_at_cover_ai_params() {
  if(self == level.mason) {
    self set_ignoreall(0);
    self.disable_blindfire = 1;
  }

  if(self == level.noriega)
    self.a.coveridleonly = 1;

  self set_ignoresuppression(0);
  self enable_pain();
  self enable_react();
  self change_movemode("run");
  self.slum_state = "cover";
}

set_slums_moving_ai_params() {
  if(self == level.mason)
    self change_movemode("sprint");
  else if(self == level.noriega)
    self change_movemode("run");

  self set_ignoreall(1);
  self set_ignoresuppression(1);
  self disable_pain();
  self disable_react();
  self.nododgemove = 1;
  self.slum_state = "moving";
}

slums_get_target_nodes(target) {
  return getnodearray(target, "targetname");
}

mn_moveup_after_mg_nest() {
  level endon("cleanup_player_committed_left");
  waittill_spawn_manager_cleared("sm_slums_axis_mgnest");

  while(is_spawn_manager_enabled("sm_slums_axis_pre_mgnest"))
    wait 0.15;

  flag_set("mv_noriega_to_dumpster");
}

mn_moveup_church() {
  waittill_spawn_manager_cleared("sm_church_yard_battle");
  flag_set("mv_noriega_to_end_door");
}

mn_moveup_from_dumpster_to_wall() {
  level endon("cleanup_player_committed_left");
  trig = getent("trig_mv_noriega_to_wall_alley", "targetname");
  trig endon("trigger");
  waittill_spawn_manager_complete("sm_slums_initial_retreat");
  wait 4;
  trigger_use("trig_mv_noriega_to_wall_alley");
}

mn_moveup_to_digbat_parking() {
  level endon("cleanup_player_committed_left");
  waittill_spawn_manager_cleared("sm_slums_initial_retreat");
  waittill_spawn_manager_cleared("sm_rooftop_and_windows_alley");
  flag_set("mv_noriega to_parking_lot");
}

mn_moveup_after_digbat_parking() {
  level endon("cleanup_player_committed_left");
  wait 0.15;
  trig_next_color = getent("trig_color_after_db_park", "targetname");
  trig_next_color endon("trigger");
  e_digbat_1 = get_ais_from_scene("parking_jump", "slums_park_digbat_01");
  e_digbat_2 = get_ais_from_scene("parking_window", "slums_park_digbat_02");
  waittill_spawn_manager_cleared("sm_digbat_parking");

  while(isalive(e_digbat_1) || isalive(e_digbat_2))
    wait 0.15;

  flag_set("cleanup_before_digbat_parking_lot");
  trigger_use("trig_color_after_db_park", "targetname");
}

mn_moveup_after_apache_attack() {
  waittill_spawn_manager_cleared("sm_slums_apache_critical_guys");
  flag_set("mv_noriega_to_gazebo");
}

mn_move_along_cafe_wall() {
}

mn_moveup_into_bottleneck_right() {
  waittill_spawn_manager_cleared("sm_slums_bottleneck");
  flag_set("mv_noriega_slums_right_bottleneck");
}

mn_moveup_to_library() {
  waittill_spawn_manager_cleared("sm_bottleneck_right_rear");
  flag_set("mv_noriega_slums_right_bottleneck_complete");
}

mn_move_passed_the_library() {
  level waittill("fxanim_library_start");
  wait 10;
  flag_set("mv_noriega_move_passed_library");
}

mn_warp_move_around_parking_lot() {
  level endon("cleanup_warp_around_parking_lot");
  level endon("tier_1_magic_teleport");
  trigger_wait("trig_player_moving_around_parking_lot", "targetname");
  level notify("cleanup_player_committed_left");
  level.mason thread warp_me_in_slums_logic("nd_mason_start_around_parking");
  level.noriega thread warp_me_in_slums_logic("nd_noriega_start_around_parking");
}

mn_warp_straight_passed_apc() {
  level endon("tier_2_teleport");
  trigger_wait("trig_warp_passed_apc", "targetname");

  if(flag("alley_molotov_digbat_animating"))
    flag_waitopen("alley_molotov_digbat_animating");

  level notify("tier_1_magic_teleport");
  level notify("left_side_teleport");
  level.mason thread warp_me_in_slums_logic("nd_mason_start_straight_past_apc");
  level.noriega thread warp_me_in_slums_logic("nd_noriega_start_straight_past_apc");
}

mn_warp_upper_left_corner() {
  trigger_wait("trig_player_upper_left_corner", "targetname");
  level notify("tier_2_teleport");
  level notify("tier_3_teleport");
  level.mason thread warp_me_in_slums_logic("nd_mason_start_left_corner");
  level.noriega thread warp_me_in_slums_logic("nd_noriega_start_left_corner");
}

mn_warp_before_digbat_beatdown() {
  level endon("tier_3_teleport");
  trigger_wait("trig_warp_before_beatdown", "targetname");
  level notify("tier_2_teleport");
  level.mason thread warp_me_in_slums_logic("nd_mason_start_before_beatdown");
  level.noriega thread warp_me_in_slums_logic("nd_noriega_start_before_beatdown");
}

mn_warp_after_intruder_hallway() {
  level endon("tier_2_teleport");
  level endon("left_side_teleport");
  trigger_wait("trig_warp_for_intruder", "targetname");
  level notify("tier_1_magic_teleport");
  level.mason thread warp_me_in_slums_logic("nd_mason_start_intruder_hallway");
  level.noriega thread warp_me_in_slums_logic("nd_noriega_start_intruder_hallway");
}

mw_warp_end_failsafe() {
  level endon("stopfailsafe");
  trigger_wait("warp_trig_failsafe_end", "targetname");

  iprintln("Do failsafe warp here");

  mason_node = getnode("nd_mason_failsafe", "targetname");
  noriega_node = getnode("nd_noriega_failsafe", "targetname");
  safe_to_warp = 1;

  while(safe_to_warp) {
    temp_node = undefined;

    if(isDefined(mason_node.target)) {
      temp_node = getnode(mason_node.target, "targetname");

      if(!level.player is_player_looking_at(temp_node.origin + vectorscale((0, 0, 1), 30.0), 0.6, 1))
        mason_node = temp_node;
      else
        safe_to_warp = 0;
    } else
      safe_to_warp = 0;
  }

  level.mason thread warp_me_in_slums_logic(mason_node.targetname);
  safe_to_warp = 1;

  while(safe_to_warp) {
    temp_node = undefined;

    if(isDefined(noriega_node.target)) {
      temp_node = getnode(noriega_node.target, "targetname");

      if(!level.player is_player_looking_at(temp_node.origin + vectorscale((0, 0, 1), 30.0), 0.6, 1))
        noriega_node = temp_node;
      else
        safe_to_warp = 0;
    } else
      safe_to_warp = 0;
  }

  level.noriega thread warp_me_in_slums_logic(noriega_node.targetname);
}

#using_animtree("animated_props");

veh_animate_pickup_trucks() {
  a_trucks = getentarray("anim_truck_hood", "targetname");

  foreach(e_truck in a_trucks) {
    e_truck useanimtree(#animtree);
    e_truck.animname = "anim_truck_hood";
    e_truck maps\_anim::anim_first_frame(e_truck, "truck_hood_up");
  }

  iprintln("animated " + a_trucks.size + " trucks hoods up");
}

veh_animate_pickup_cars() {
  a_cars = getentarray("anim_car_door", "targetname");

  foreach(e_car in a_cars) {
    e_car useanimtree(#animtree);
    e_car.animname = "anim_car_door";
    e_car maps\_anim::anim_first_frame(e_car, "car_driver_door_open");
  }

  iprintln("animated " + a_cars.size + " car driver doors open");
}

rotate_the_clinic_door() {
  e_door = getent("clinic_frontdoor", "targetname");
  e_rotator = getent("clinic_door_rotator", "targetname");
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.4, 0.4, level.player.origin, 256, level.player);
  e_door linkto(e_rotator);
  e_rotator rotateyaw(-110, 0.8, 0.05, 0.75);
}

clear_slum_southeast_ai() {
  trigger_wait("delete_ai_from_southeast_slum");
  level notify("delete_ai_from_southeast_slum");
  spawn_manager_disable("sm_rooftop_and_windows_alley");
  trigger = getent("southeast_pdf_delete_volume", "targetname");
  a_ai = getaiarray("axis", "allies");

  for(i = 0; i < a_ai.size; i++) {
    if(a_ai[i] == level.mason || a_ai[i] == level.noriega) {
      continue;
    }
    if(a_ai[i] istouching(trigger))
      a_ai[i] dodamage(300, (0, 0, 0));
  }

  wait 1;
  a_ai = getaiarray("axis", "allies");

  for(i = 0; i < a_ai.size; i++) {
    if(a_ai[i] == level.mason || a_ai[i] == level.noriega) {
      continue;
    }
    if(a_ai[i] istouching(trigger))
      a_ai[i] dodamage(300, (0, 0, 0));
  }
}

clear_central_ai() {
  trigger_wait("sm_church_yard_battle");
  level notify("central_pdf_delete_volume");
  spawn_manager_disable("sm_slums_apache_critical_guys");
  spawn_manager_disable("sm_slums_bottleneck_critical");
  spawn_manager_disable("sm_bottleneck_right_rear");
  spawn_manager_disable("sm_slums_left_narrow");
  spawn_manager_disable("sm_slums_standoff");
  trigger = getent("central_pdf_delete_volume", "targetname");
  a_ai = getaiarray("axis", "allies");

  for(i = 0; i < a_ai.size; i++) {
    if(a_ai[i] == level.mason || a_ai[i] == level.noriega) {
      continue;
    }
    if(a_ai[i] istouching(trigger))
      a_ai[i] delete();
  }

  wait 1;
  a_ai = getaiarray("axis", "allies");

  for(i = 0; i < a_ai.size; i++) {
    if(a_ai[i] == level.mason || a_ai[i] == level.noriega) {
      continue;
    }
    if(a_ai[i] istouching(trigger))
      a_ai[i] delete();
  }
}

slum_edge_vo() {
  section_1_trigger = getent("slum_section_1", "targetname");
  section_2_trigger = getent("slum_section_2", "targetname");
  section_3_trigger = getent("slum_section_3", "targetname");
  level.current_edge_vo = " ";
  vo_string_1 = [];
  vo_string_1[vo_string_1.size] = "pdf_we_need_more_firepow_0";
  vo_string_1[vo_string_1.size] = "pdf_they_re_in_the_open_0";
  vo_string_1[vo_string_1.size] = "pdf_on_the_road_0";
  vo_string_1[vo_string_1.size] = "pdf_draw_them_into_the_o_0";
  vo_string_1[vo_string_1.size] = "pdf_put_more_men_on_the_0";
  vo_string_1[vo_string_1.size] = "pdf_hit_that_car_until_i_0";
  vo_string_1[vo_string_1.size] = "pdf_grenade_move_0";
  vo_string_1[vo_string_1.size] = "pdf_deserters_will_be_sh_0";
  vo_string_1[vo_string_1.size] = "pdf_there_s_too_many_of_0";
  vo_string_1[vo_string_1.size] = "pdf_they_re_coming_up_th_0";
  vo_string_1[vo_string_1.size] = "pdf_contact_end_of_the_0";
  vo_string_1[vo_string_1.size] = "pdf_they_have_gunships_i_0";
  vo_string_1[vo_string_1.size] = "pdf_hold_the_building_0";
  vo_string_1[vo_string_1.size] = "pdf_there_are_too_many_a_0";
  vo_string_1[vo_string_1.size] = "pdf_we_have_them_pinned_0";
  vo_string_1[vo_string_1.size] = "pdf_they_re_still_bombin_0";
  vo_string_1[vo_string_1.size] = "pdf_drive_them_back_to_t_0";
  vo_string_1[vo_string_1.size] = "pdf_where_are_our_tanks_0";
  vo_string_1[vo_string_1.size] = "pdf_we_have_them_pinned_0";
  vo_string_1[vo_string_1.size] = "pdf_hold_them_at_the_chu_0";
  vo_string_1[vo_string_1.size] = "pdf_we_cannot_hold_our_p_0";
  vo_string_1[vo_string_1.size] = "pdf_they_ve_destroyed_th_0";
  vo_string_1[vo_string_1.size] = "pdf_in_the_churchyard_0";
  vo_string_1[vo_string_1.size] = "pdf_rush_them_0";
  vo_string_1[vo_string_1.size] = "pdf_they_have_more_armor_0";
  vo_string_1[vo_string_1.size] = "pdf_they_are_at_the_park_0";
  vo_string_1[vo_string_1.size] = "pdf_there_are_too_many_a_0";
  vo_string_1[vo_string_1.size] = "pdf_bring_down_their_hel_0";
  vo_string_1[vo_string_1.size] = "pdf_get_aa_fire_on_their_0";
  player_location = undefined;

  while(true) {
    player_location = get_player_location(section_1_trigger, section_2_trigger, section_3_trigger);

    if(!isDefined(player_location)) {
      vo_string_1 play_vo_in_section("slum_section_1");
      vo_string_1 play_vo_in_section("slum_section_1");
      vo_string_1 play_vo_in_section("slum_section_1");
    } else if(player_location == section_1_trigger) {
      vo_string_1 play_vo_in_section("slum_section_1");
      vo_string_1 play_vo_in_section("slum_section_1");
      vo_string_1 play_vo_in_section("slum_section_1");
    } else if(player_location == section_2_trigger) {
      vo_string_1 play_vo_in_section("slum_section_2");
      vo_string_1 play_vo_in_section("slum_section_2");
      vo_string_1 play_vo_in_section("slum_section_2");
    } else if(player_location == section_3_trigger) {
      vo_string_1 play_vo_in_section("slum_section_3");
      vo_string_1 play_vo_in_section("slum_section_3");
      vo_string_1 play_vo_in_section("slum_section_3");
    }

    wait(randomfloatrange(2, 6));
  }
}

get_player_location(location_1, location_2, location_3) {
  if(level.player istouching(location_1))
    return location_1;
  else if(level.player istouching(location_2))
    return location_2;
  else if(level.player istouching(location_3))
    return location_3;
  else
    return undefined;
}

play_vo_in_section(trigger_name) {
  new_line = self[randomint(self.size)];

  while(new_line == level.current_edge_vo) {
    new_line = self[randomint(self.size)];
    level.current_edge_vo = new_line;
    break;
  }

  section_trigger = getent(trigger_name, "targetname");
  random_dude = get_random_ai_no_closer_than(1000, 2000, section_trigger);

  if(isDefined(random_dude)) {
    iprintln(distance2d(random_dude.origin, level.player.origin));

    if(isai(random_dude))
      random_dude say_dialog(new_line);
    else
      random_dude say_dialog(new_line, 0, 1);
  }
}

get_random_ai_no_closer_than(min_distance, max_distance, trigger) {
  a_ai = getaiarray("axis");

  for(i = 0; i < a_ai.size; i++) {
    player_distance = distance2dsquared(a_ai[i].origin, level.player.origin);

    if(a_ai[i] istouching(trigger) && player_distance > min_distance * min_distance && player_distance < max_distance * max_distance && !isDefined(a_ai[i].is_about_to_talk))
      return a_ai[i];
  }

  a_ai = getaiarray("allies");

  for(i = 0; i < a_ai.size; i++) {
    player_distance = distance2dsquared(a_ai[i].origin, level.player.origin);

    if(a_ai[i] istouching(trigger) && player_distance > min_distance * min_distance && player_distance < max_distance * max_distance && !isDefined(a_ai[i].is_about_to_talk))
      return a_ai[i];
  }

  a_struct = getentarray("random_vo_location", "targetname");

  for(i = 0; i < a_struct.size; i++) {
    player_distance = distance2dsquared(a_struct[i].origin, level.player.origin);

    if(player_distance > min_distance * min_distance && player_distance < max_distance * max_distance && !isDefined(a_struct[i].is_about_to_talk))
      return a_struct[i];
  }
}

molotov_intro_van() {
  level endon("delete_ai_from_southeast_slum");
  trigger_wait("molotov_flame_car_trigger");
  start_struct = getent("molotov_flame_car_start", "targetname");
  end_struct = getstruct("molotov_flame_car_target", "targetname");
  level.player magicgrenadetype("molotov_sp", start_struct.origin, (-600, -1000, 330), 3);
}

intro_cleanup() {
  flag_wait("move_intro_heli");
  models = getentarray("pan_intro_models", "script_noteworthy");

  for(i = 0; i < models.size; i++)
    models[i] delete();
}