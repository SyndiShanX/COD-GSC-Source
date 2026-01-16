/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_morals_rail.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\yemen_utility;
#include maps\_glasses;
#include maps\_vehicle;
#include maps\_objectives;
#include maps\_drones;
#include maps\_dialog;
#include maps\_music;
#include maps\yemen_anim;
#include maps\yemen_capture;
#include maps\_audio;
#include maps\yemen_hijacked;

init_flags() {
  flag_init("morals_rail_start");
  flag_init("morals_rail_fade_in_start");
  flag_init("morals_rail_suspician_started");
  flag_init("morals_rail_pip_scene_started");
  flag_init("morals_rail_done");
  flag_init("morals_rail_onground");
  flag_init("morals_rail_waypoint");
  flag_init("morals_rail_took_damage");
  flag_init("morals_rail_skipto");
  flag_init("morals_rail_fadein_starting");
}

init_spawn_funcs() {
  add_spawn_function_group("morals_rail_terrorist", "script_noteworthy", ::morals_rail_terrorist_spawnfunc);
}

skipto_morals_rail() {
  screen_fade_out(0, "black", 1);
  flag_set("morals_rail_skipto");
  switch_player_to_mason();
  setup_vtol_crash_site();
  level.is_farid_alive = 0;
}

skipto_morals_rail_skip() {
  flag_set("morals_rail_skipto");
  setup_vtol_crash_site();
  level.is_farid_alive = 1;
  skipto_teleport("skipto_drone_control_player");
}

skipto_morals_rail_menendez() {
  flag_set("morals_rail_skipto");
  level.is_farid_alive = 1;
  skipto_teleport("skipto_drone_control_player");
  level thread do_nothing();
}

do_nothing() {
  wait 6;
  level thread setup_menedez_escape_extracam();
  level waittill("do_nothing");
}

main() {
  if(!level.is_farid_alive) {
    iprintln("Morals Rail");

    level.n_rail_terrorist_kills = 0;
    load_gump("yemen_gump_outskirts");
    waittill_asset_loaded("xmodel", "veh_t6_air_v78_vtol_side_gun");
    morals_rail_setup();
    maps\yemen_anim::moral_rail_player_body_anim();
    flag_set("morals_rail_fade_in_start");
    level thread vo_septic_rail();
    level thread taking_fire_sfx();
    wait 0.05;
    autosave_by_name("morals_rail_start");
    morals_rail_go();
  } else {
    load_gump("yemen_gump_outskirts");
    mr_spawn_salazar();
    wait 0.05;
  }
}

morals_rail_setup() {
  level thread enemy_target_update();
}

setup_vtol_crash_site() {
  level notify("fxanim_vtol2_crash_start");
  level thread run_scene_and_delete("morals_vtol_crashing");
}

mr_spawn_salazar() {
  init_hero_startstruct("sp_salazar", "skipto_drone_control_salazar");
}

spawn_vtols_at_structs(str_struct_name, str_nd_name) {
  a_spots = getstructarray(str_struct_name, "targetname");

  foreach(s_spot in a_spots) {
    v_vtol = spawn_vehicle_from_targetname("yemen_drone_control_vtol_spawner");

    if(isDefined(str_nd_name) || isDefined(s_spot.target)) {
      if(isDefined(s_spot.target))
        str_nd_name = s_spot.target;

      v_vtol veh_magic_bullet_shield(1);
      v_vtol thread go_path(getvehiclenode(str_nd_name, "targetname"));
      return v_vtol;
    } else {
      v_vtol.origin = s_spot.orign;
      v_vtol.angles = s_spot.angles;
      return v_vtol;
    }
  }
}

morals_rail_terrorist_spawnfunc() {
  self.script_grenades = 0;
  self.script_radius = 64;
  self.deathfunction = ::morals_rail_count_terrorist_deaths;
  self shoot_at_target_untill_dead(getent("morals_rail_vtol", "script_noteworthy"));
}

morals_rail_count_terrorist_deaths() {
  if(self.attacker == level.player)
    level.n_rail_terrorist_kills++;

  return false;
}

morals_rail_go() {
  level.player.overrideplayerdamage = ::morals_rail_player_damage_override;
  player_vtol_go_on_rail();
  level.player.overrideplayerdamage = undefined;
}

morals_rail_player_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  n_damage = 0;

  if(!flag("morals_rail_took_damage")) {
    flag_set("morals_rail_took_damage");
    level thread wait_clear_took_damage_flag();
    n_damage = 10;

    if(self.health < 50)
      n_damage = 0;
  }

  return n_damage;
}

wait_clear_took_damage_flag() {
  level.player enableinvulnerability();
  wait 2;
  level.player disableinvulnerability();
  flag_clear("morals_rail_took_damage");
}

player_vtol_go_on_rail() {
  flag_set("morals_rail_start");
  setmusicstate("YEMEN_MASON_INBOUND");
  veh_vtol = maps\_vehicle::spawn_vehicle_from_targetname("yemen_morals_rail_vtol_spawner");
  veh_vtol.script_noteworthy = "morals_rail_vtol";
  veh_vtol.script_radius = 16;
  veh_vtol.drivepath = 1;
  nd_vtol_start = getvehiclenode("morals_rail_player_vtol_path1_start_node", "targetname");
  nd_exit_path = getvehiclenode("morals_rail_player_vtol_exit_path_start", "targetname");
  level thread do_vtol_sounds(veh_vtol);
  s_look_spot = getstruct("player_vtol_look_spot", "targetname");
  m_vtol_look_at = spawn("script_origin", s_look_spot.origin);
  veh_vtol veh_magic_bullet_shield(1);
  veh_vtol setvehgoalpos(nd_vtol_start.origin, 1);
  v_gunner_origin = veh_vtol gettagorigin("tag_gunner_mount1");
  v_gunner_angles = veh_vtol gettagangles("tag_gunner_mount1");
  level.player.origin = v_gunner_origin;
  level.player setplayerangles(v_gunner_angles);
  level.player playerlinktodelta(veh_vtol, "tag_gunner_mount1", 1, 0, 0, 0, 0, 1);
  wait 0.05;
  level.player unlink();
  level.player freezecontrols(1);
  veh_vtol usevehicle(level.player, 1);
  veh_vtol sethoverparams(128);
  flag_wait("morals_rail_fadein_starting");
  veh_vtol thread go_path(nd_vtol_start);
  veh_vtol setlookatent(m_vtol_look_at);
  wait 0.01;
  level thread screen_fade_in(1);
  level thread do_mason_custom_intro_screen();
  level.player freezecontrols(0);
  do_rail_events(veh_vtol);
  run_scene_first_frame("mason_intro_harper_lives");
  veh_vtol makevehicleunusable();
  flag_set("morals_rail_done");
  old_vtol = getent("morals_vtol_1", "targetname");
  old_vtol vehicle_toggle_sounds(0);
  m_lamp = getent("fxanim_vtol2_crash_lamp", "targetname");

  if(isDefined(m_lamp))
    m_lamp delete();

  wait_network_frame();
  level.player unlink();
  exploder(1028);
  level thread spawn_reinforcements();
  run_scene_and_delete("mason_intro_harper_lives");
  level.player enableweaponfire();
  level thread run_scene_and_delete("harper_medic_loop");
  ai_sal = getent("sp_salazar_ai", "targetname");
  ai_sal thread make_hero();
  veh_vtol thread player_vtol_exit_scene(nd_exit_path);
  trigger_use("trig_drone_control_color_alley_start", "targetname");
  m_vtol_look_at delete();
}

#using_animtree("player");

spawn_reinforcements() {
  wait(getanimlength( % p_yemen_05_05_mason_intro_hpr_lives_mason) - 10);
  trigger_use("trig_drone_control_allies");
}

player_landed_rappel(player) {
  set_head_look(1, 0.1, 0.1, 10, 10, 10, 10);
  maps\yemen_capture::ready_weapon();
}

player_rappel_rumble_on(player) {
  level.player rumble_loop(-1, 0.1, "damage_light");
}

player_rappel_rumble_off(player) {
  level.player notify("_rumble_loop_stop");
}

set_head_look(time, accel, decel, n_right_arc, n_left_arc, n_top_arc, n_bottom_arc) {
  level.player lerpviewangleclamp(time, accel, decel, n_right_arc, n_left_arc, n_top_arc, n_bottom_arc);
}

setup_menedez_escape_extracam() {
  if(!isDefined(level.salazar))
    wait 0.05;

  level.salazar delete();
  level.player.ignoreme = 1;
  extracam = get_extracam();
  camera_lookat = getent("menedenez_escape_cam", "targetname");
  extracam.origin = camera_lookat.origin;
  extracam.angles = camera_lookat.angles;
  guard1 = simple_spawn_single("fleeing_cover_terrorist");
  guard1 thread set_ignoreall(1);
  guard2 = simple_spawn_single("fleeing_cover_terrorist");
  guard2 thread set_ignoreall(1);
  men_node = getnode("menedenez_fleeing_node", "targetname");
  guard1_node = getnode("guard1_fleeing_node", "targetname");
  guard2_node = getnode("guard2_fleeing_node", "targetname");
  wait 3;
  menendez = simple_spawn_single("menendez_morals");
  menendez change_movemode("sprint");
  menendez set_ignoreall(1);
  menendez thread force_goal(men_node, 32);
  wait 1;
  guard3 = simple_spawn_single("fleeing_cover_terrorist2");
  guard3 thread set_ignoreall(1);
  guard3 thread force_goal(guard1_node, 32);
  wait 0.7;
  guard4 = simple_spawn_single("fleeing_cover_terrorist2");
  guard4 thread set_ignoreall(1);
  guard4 thread force_goal(guard2_node, 32);
  wait 0.8;
  guard5 = simple_spawn_single("fleeing_cover_terrorist2");
  guard5 thread set_ignoreall(1);
  guard5 thread force_goal(guard1_node, 32);
  wait 3.5;
  guard1 thread force_goal(guard1_node, 32);
  wait 1;
  guard2 thread force_goal(guard2_node, 32);
  wait 3;
  turn_off_extra_cam();
  guard1 delete();
  guard2 delete();
  menendez delete();
}

do_rail_events(veh_vtol) {
  level thread do_rail_ai();
  level thread morals_rail_ground_spawner();
  flag_wait("morals_rail_pip_scene_started");
  level thread play_bink_on_hud("yemen_mendz");
  level waittill("rail_ready_exit");
  fire_rpgs_from_structs("s_morals_rail_arched_balcony_rpg_struct");
  wait 2;
}

morals_rail_ground_spawner() {
  str_category = "morals_rail_dudes";
  a_spawners = getentarray("morals_rail_ground_spawner", "targetname");
  simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 0, 0);
  level waittill("rail_ready_exit");
  wait 5.2;
  cleanup_ents(str_category);
}

do_rail_drones() {
  sp_drone = getent("morals_rail_first_ground_drone", "targetname");
  drones_start("s_mr_sp_second_ground_drones");
  drones_start("s_mr_sp_first_ground_drones");
  drones_start("s_mr_sp_vtol_ground_drones");
  level waittill("rail_ready_exit");
  drones_delete("s_mr_sp_second_ground_drones");
  drones_delete("s_mr_sp_first_ground_drones");
  drones_delete("s_mr_sp_vtol_ground_drones");
  drones_delete("s_mr_sp_fourth_ground_drones");
  sp_drone delete();
}

do_rail_ai() {
  level waittill("rail_ready_exit");
  level thread maps\_audio::switch_music_wait("YEMEN_MASON_ARRIVES", 4);
  spawn_manager_kill("morals_rail_lower_wave_1");
  spawn_manager_kill("morals_rail_lower_wave_2");
  spawn_manager_kill("morals_rail_upper_wave_2");
  spawn_manager_kill("morals_rail_upper_wave_1");
  wait 0.1;
  a_ai_terrorists = getentarray("morals_rail_terrorist", "script_noteworthy");
  maps\yemen_hijacked::kill_units(a_ai_terrorists);
}

escort_vtol_go_on_rail(str_struct, veh_speed_match) {
  level endon("morals_rail_done");
  veh_speed_match endon("delete");
  veh_vtol = spawn_vtols_at_structs(str_struct);
  veh_vtol endon("delete");

  while(true) {
    n_speed = veh_speed_match getspeed();
    veh_vtol setspeed(n_speed / 17.6);
    wait 1;
  }
}

player_vtol_exit_scene(nd_goal) {
  self clearlookatent();
  self.drivepath = 1;
  self go_path(nd_goal);
}

mr_get_magic_target_position(e_shooter, n_dist) {
  if(!isDefined(n_dist))
    n_dist = 5000;

  v_aim_spot = e_shooter.origin + vectornormalize(anglestoforward(e_shooter.angles)) * n_dist;
  a_trace = bullettrace(e_shooter.origin, v_aim_spot, 1, e_shooter);
  return a_trace["position"];
}

fire_rpgs_from_structs(str_struct, v_target, n_min, n_max) {
  n_wait = undefined;
  a_rpgs = getstructarray(str_struct, "targetname");

  foreach(s_rpg in a_rpgs) {
    if(!isDefined(s_rpg.script_noteworthy))
      v_target = _get_target_position();
    else if(s_rpg.script_noteworthy == "player")
      v_target = _get_target_position();
    else {
      e_target_ent = getstruct(s_rpg.script_notewothy, "targetname");
      v_target = e_target_ent.origin;
    }

    magicbullet("usrpg_magic_bullet_sp", s_rpg.origin, v_target);
    wait(_get_custom_wait(n_min, n_max));
  }
}

_get_custom_wait(n_min, n_max) {
  if(isDefined(n_min) && isDefined(n_max))
    n_wait = randomfloatrange(n_min, n_max);
  else {
    if(isDefined(n_min))
      n_wait = n_min;

    if(isDefined(n_max))
      n_wait = n_max;

    if(!isDefined(n_max) && !isDefined(n_min))
      n_wait = 0.05;
  }

  return n_wait;
}

enemy_target_update() {
  level endon("morals_rail_done");
  m_aim = _get_aim_model();

  while(true) {
    m_aim.origin = _get_target_position();
    wait 0.2;
  }
}

_get_aim_model() {
  m_aim = spawn("script_model", (0, 0, 0));
  m_aim setmodel("tag_origin");
  m_aim.targetname = "m_enemy_target";
  return m_aim;
}

_get_target_position() {
  v_eye_pos = level.player geteye();
  v_player_eye = level.player getplayerangles();
  v_player_eye = vectornormalize(anglestoforward(v_player_eye));
  v_trace_to_point = v_eye_pos + v_player_eye * 512;
  a_trace = bullettrace(v_eye_pos, v_trace_to_point, 0, level.player);
  return a_trace["position"];
}

vo_septic_rail() {
  level.player say_dialog("sept_harper_harper_do_0");
  wait 0.2;
  level.player say_dialog("sept_dammit_something_s_0");
  level thread set_fadein_flag(1);
  wait 0.2;
  level.player say_dialog("sept_watchtower_lineback_0");
  wait 0.2;
  level.player say_dialog("sect_push_available_video_0");
  flag_set("morals_rail_pip_scene_started");
  wait 1.0;
  level.player say_dialog("sept_taking_heavy_fire_fr_0");
  wait 1.5;
  level.player say_dialog("sect_menendez_0");
  wait 0.4;
  level.player say_dialog("sect_kraken_we_have_eye_0");
}

set_fadein_flag(delay) {
  wait(delay);
  flag_set("morals_rail_fadein_starting");
}

killwithdrones_challenge(str_notify) {
  level waittill("morals_rail_done");

  if(isDefined(level.n_rail_terrorist_kills) && level.n_rail_terrorist_kills >= 10)
    self notify(str_notify);
}

do_vtol_sounds(plr_vtol) {
  level clientnotify("inside_osprey");
  level waittill("morals_rail_done");
  level clientnotify("osprey_done");
  vtol_snd = spawn("script_origin", plr_vtol.origin);
  vtol_snd linkto(plr_vtol);
  wait 3.5;
  vtol_snd playloopsound("veh_osp_steady", 1);
  wait 30;
  vtol_snd stoploopsound(2);
  vtol_snd delete();
}

taking_fire_sfx() {
  playsoundatposition("evt_takin_dat_fire", (0, 0, 0));
}