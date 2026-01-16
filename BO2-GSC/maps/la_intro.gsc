/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_intro.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\la_utility;
#include maps\_vehicle;
#include maps\_scene;
#include maps\_dialog;
#include maps\_music;
#include maps\_fxanim;
#include maps\_audio;
#include maps\_turret;
#include maps\_objectives;

autoexec event_funcs() {
  add_spawn_function_group("mason_reflection", "targetname", ::reflection_scene_head_track);
}

skipto_intro() {
}

main() {
  println("Intro");

  level thread intro_hide_fxanim();
  clientnotify("intr_on");
  exploder(10);
  level thread drone_approach();
  flag_wait("all_players_connected");
  level.old_friendlynamedist = 15000;
  setsaveddvar("g_friendlyNameDist", 0);
  setsaveddvar("sm_sunSampleSizeNear", 0.4);
  level thread ambient_drones();

  if(level.player hasweapon("riotshield_sp"))
    flag_set("player_brought_shield");

  s_cougar_spawner = get_vehicle_spawner("intro_cougar");
  veh_cougar = spawnvehicle("veh_t6_mil_cougar_interior", "intro_cougar", "apc_cougar_nophysics", s_cougar_spawner.origin, s_cougar_spawner.angles);
  veh_cougar setmodel("veh_t6_mil_cougar_interior");
  veh_cougar thread intro_cougar();
  n_fov = getdvarint(#"cg_fov");
  level.player setclientdvar("cg_fov", 55);
  run_scene_first_frame("intro");

  if(flag("harper_dead"))
    run_scene_first_frame("intro_player_noharper");

  waittill_textures_loaded();
  clientnotify("argus_zone:intro");
  intro_dialog();
  nd_cougar_path = getvehiclenode("intro_cougar_path", "targetname");
  veh_cougar thread go_path(nd_cougar_path);
  level thread run_reflection_scene();
  veh_cougar thread intro_scene_misc();

  debug_timer();

  level.player playsound("evt_la_1_intro");
  level thread run_scene_and_delete("intro_fxanim_loop");
  level thread hide_player_ropes();

  if(!flag("harper_dead")) {
    level thread run_scene_and_delete("intro_harper");
    level thread run_scene_and_delete("intro_player");
  } else {
    level thread run_scene_and_delete("intro_player_noharper");
    n_player_body = get_model_or_models_from_scene("intro_player_noharper", "player_body");
    n_player_body attach("adrenaline_syringe_small_animated", "tag_weapon");
  }

  level run_scene_and_delete("intro");
  level clientnotify("over_black");
  level.player setclientdvar("cg_fov", n_fov);

  if(flag("harper_dead"))
    n_player_body detach("adrenaline_syringe_small_animated", "tag_weapon");
}

intro_hide_fxanim() {
  maps\_fxanim::fxanim_deconstruct("freeway_chunks_fall");
  maps\_fxanim::fxanim_deconstruct("fxanim_road_sign_snipe_01");
  maps\_fxanim::fxanim_deconstruct("fxanim_road_sign_snipe_02");
  maps\_fxanim::fxanim_deconstruct("fxanim_road_sign_snipe_03");
  maps\_fxanim::fxanim_deconstruct("fxanim_road_sign_snipe_04");
  maps\_fxanim::fxanim_deconstruct("fxanim_sniper_drone_crash_chunks");
  maps\_fxanim::fxanim_deconstruct("fxanim_sniper_freeway");
  maps\_fxanim::fxanim_deconstruct("cougar_fall_debris");
  maps\_fxanim::fxanim_deconstruct("sniper_bus");
  flag_wait("cougar_crawl_player_first_frame");
  maps\_fxanim::fxanim_reconstruct("freeway_chunks_fall");
  maps\_fxanim::fxanim_reconstruct("fxanim_road_sign_snipe_01");
  maps\_fxanim::fxanim_reconstruct("fxanim_road_sign_snipe_02");
  maps\_fxanim::fxanim_reconstruct("fxanim_road_sign_snipe_03");
  maps\_fxanim::fxanim_reconstruct("fxanim_road_sign_snipe_04");
  maps\_fxanim::fxanim_reconstruct("fxanim_sniper_drone_crash_chunks");
  maps\_fxanim::fxanim_reconstruct("fxanim_sniper_freeway");
  maps\_fxanim::fxanim_reconstruct("cougar_fall_debris");
  maps\_fxanim::fxanim_reconstruct("sniper_bus");
}

intro_cougar() {
  level.intro_cougar = self;
  self attach("veh_t6_mil_cougar_interior_shadow");
  self attach("veh_t6_mil_cougar_interior_attachment", "tag_body_animate_jnt");
  fxanim_la_cougar_interior_static_mod = spawn_model("fxanim_la_cougar_interior_static_mod");
  fxanim_la_cougar_interior_static_mod linkto(self, "tag_body_animate_jnt", (0, 0, 0), (0, 0, 0));
  self hidepart("tag_windshield_blood");
  self hidepart("tag_windshield_crack");
  self play_fx("cougar_dashboard", undefined, undefined, -1, 1, "tag_body_animate_jnt");
  self play_fx("cougar_dome_light", undefined, undefined, -1, 1, "tag_fx_domelight");
  self play_fx("cougar_monitor", undefined, undefined, -1, 1, "tag_fx_monitor");
  self play_fx("intro_dust", undefined, undefined, -1, 1, "tag_body_animate_jnt");
  self thread cougar_godrays();
  flag_wait("intro_fxanim_loop_started");
  m_fxanims = getent("intro_fxanims", "targetname");
  m_fxanims attach("fxanim_gp_secret_serv_backpack_mod", "backpack_jnt");
  m_fxanims attach("fxanim_gp_secret_serv_gasmask_mod", "gasmask_jnt");
  scene_wait("intro");
  m_fxanims delete();
  fxanim_la_cougar_interior_static_mod delete();
}

set_chopper_dof(m_player_body) {
  veh_cougar = getent("intro_cougar", "targetname");
  veh_cougar setclientflag(13);
}

intro_dialog() {
  setmusicstate("LA_1_INTRO");
  level thread maps\_audio::switch_music_wait("LA_1_CRAWL", 83);
  wait 8;
}

slowmo_start(m_player_body) {
  timescale_tween(0.1, 0.3, 1);
}

slowmo_end(m_player_body) {
  timescale_tween(0.3, 1, 1);
}

slowmo_med_start(m_player_body) {
  timescale_tween(0.2, 0.4, 1);
}

slowmo_med_end(m_player_body) {
  timescale_tween(0.4, 1, 1);
}

fade_out(m_player_body) {
  level.player maps\_utility::hide_hud();
  screen_fade_out(0);
  clientnotify("reset_snapshot");
}

run_reflection_scene() {
  m_reflection_cougar = getent("cougar_reflection_scene", "targetname");
  level thread run_scene_and_delete("intro_reflection");

  if(!flag("harper_dead"))
    level thread run_scene_and_delete("intro_reflection_harper");

  scene_wait("intro_reflection");
  m_reflection_cougar delete();
}

reflection_scene_head_track() {
  self endon("death");

  while(true) {
    v_forward = anglestoforward(level.player getplayerangles());
    v_eye = level.player get_eye();
    self lookatpos(v_eye + v_forward * 300);
    wait 0.05;
  }
}

cougar_godrays() {
  self endon("death");

  while(true) {
    self play_fx("intro_cougar_godrays", undefined, undefined, "stop_godrays", 1, "tag_body_animate_jnt");
    self waittill("start_godrays");
  }
}

warp(m_player_body) {
  self play_fx("intro_warp_smoke", undefined, undefined, 4, 1, "tag_body_animate_jnt");
  self notify("stop_godrays");
  wait 1;
  node = getvehiclenode("intro_cougar_path", "targetname");
  level.player setorigin(node.origin);
  self thread go_path(node);
  wait 2;
  self notify("start_godrays");
}

turn_on_reflection_cam() {
  setsaveddvar("r_extracam_custom_aspectratio", 1.89479);
  level.sm_cam_ent = getent("reflection_cam", "targetname");
  level.sm_cam_ent setclientflag(1);
}

turn_off_reflection_cam(b_delete) {
  if(!isDefined(b_delete))
    b_delete = 0;

  level.sm_cam_ent clearclientflag(1);

  if(b_delete)
    level.sm_cam_ent delay_thread(2, ::self_delete);
}

drone_approach() {
  exploder(55);
  exploder(60);
  wait 5;

  while(flag("drone_approach"))
    wait 0.2;

  stop_exploder(55);
  stop_exploder(60);
}

spawn_intro_drone_set() {
  a_drones = spawn_vehicles_from_targetname("intro_drones");

  foreach(veh_drone in a_drones) {
    start_node = getvehiclenode(veh_drone.target, "targetname");
    veh_drone thread go_path(start_node);
    veh_drone thread set_drone_path_variance();
    veh_drone thread restart_path_watcher();
  }

  wait(randomfloatrange(1.5, 4.5));
}

set_drone_path_variance() {
  self waittill("start_path_variance");
  self pathvariableoffset((1000, 1000, 100), 1.5);
}

restart_path_watcher() {
  while(flag("drone_approach")) {
    self waittill("reached_end_node");
    self veh_toggle_exhaust_fx(0);
    wait 0.05;
    nd_start = getvehiclenode(self.target, "targetname");
    self thread go_path(nd_start);
    wait 0.1;
    self veh_toggle_exhaust_fx(1);
  }

  self delete();
}

blackhawk_explosion(veh_blackhawk) {
  veh_blackhawk notify("missile_hit");
  veh_blackhawk play_fx("intro_blackhawk_explode", undefined, undefined, -1, 1, "body_animate_jnt");
  wait 0.3;
  veh_blackhawk play_fx("intro_blackhawk_trail", undefined, undefined, -1, 1, "body_animate_jnt");
}

missile_hide(m_missile_1) {
  m_missile_1 hide();
}

intro_scene_misc() {
  flag_wait("intro_started");
  setup_argus();
  level thread policecar_lights();
  veh_blackhawk = getent("intro_blackhawk", "targetname");
  veh_blackhawk play_fx("blackhawk_groundfx", undefined, undefined, "missile_hit", 1, "body_animate_jnt");
  veh_drone1 = getent("intro_drone1", "targetname");
  veh_drone2 = getent("intro_drone2", "targetname");
  veh_drone3 = getent("intro_drone3", "targetname");
  veh_drone4 = getent("intro_drone4", "targetname");
  e_missile_target1 = getent("intro_missile_target1", "targetname");
  e_missile_target2 = getent("intro_missile_target2", "targetname");
  e_missile_target3 = getent("intro_missile_target3", "targetname");
  e_missile_target4 = getent("intro_missile_target4", "targetname");
  veh_drone1 maps\_turret::set_turret_target(e_missile_target4, undefined, 1);
  veh_drone1 maps\_turret::set_turret_target(e_missile_target4, undefined, 2);
  veh_drone2 maps\_turret::set_turret_target(e_missile_target1, undefined, 1);
  veh_drone2 maps\_turret::set_turret_target(e_missile_target1, undefined, 2);
  veh_drone3 maps\_turret::set_turret_target(e_missile_target2, undefined, 1);
  veh_drone3 maps\_turret::set_turret_target(e_missile_target2, undefined, 2);
  veh_drone4 maps\_turret::set_turret_target(e_missile_target3, undefined, 1);
  veh_drone4 maps\_turret::set_turret_target(e_missile_target3, undefined, 2);
  level thread run_scene("intro_gunner");
  delay_thread(35, ::turn_on_reflection_cam);
  delay_thread(45, ::turn_off_reflection_cam, 1);
  delay_thread(5, ::play_fx, "magic_cop_car_left", undefined, undefined, undefined, 1, "tag_body_animate_jnt");
  delay_thread(12, ::play_fx, "magic_cop_car_left", undefined, undefined, undefined, 1, "tag_body_animate_jnt");
  delay_thread(17, ::play_fx, "magic_cop_car_left", undefined, undefined, undefined, 1, "tag_body_animate_jnt");
  delay_thread(20, ::play_fx, "magic_cop_car_right", undefined, undefined, undefined, 1, "tag_body_animate_jnt");
  delay_thread(30, ::play_fx, "magic_cop_car_right", undefined, undefined, undefined, 1, "tag_body_animate_jnt");
  delay_thread(35, ::play_fx, "magic_cop_car_left", undefined, undefined, undefined, 1, "tag_body_animate_jnt");
  delay_thread(52, ::exploder, 204);
  scene_wait("intro");
  end_scene("intro_gunner");
}

intro_windshield_swap(vh_cougar) {
  vh_cougar hidepart("tag_windshield_clean");
}

setup_argus() {
  if(!flag("harper_dead")) {
    level.harper = getent("harper_drone", "targetname");
    addargus(level.harper, "harper", "harper");
  }

  level.hillary = getent("hillary_drone", "targetname");
  addargus(level.hillary, "hillary", "hillary");
  level.sam = getent("sam_drone", "targetname");
  addargus(level.sam, "sam", "sam");
  level.jones = getent("jones_drone", "targetname");
  addargus(level.jones, "jones", "jones");
}

sec_spit_and_drool(m_secretary) {
  wait 0.5;
  m_secretary play_fx("sec_drool", undefined, undefined, -1, 1, "j_mouth_ri");
}

policecar_lights() {
  getent("intro_copcar1", "targetname") thread play_fx_when_shown("siren_light_intro", "tag_fx_siren_lights");
  getent("intro_copcar2", "targetname") thread play_fx_when_shown("siren_light_intro", "tag_fx_siren_lights");
  getent("intro_copcar3", "targetname") thread play_fx_when_shown("siren_light_intro", "tag_fx_siren_lights");
  getent("intro_copcar4", "targetname") thread play_fx_when_shown("siren_light_intro", "tag_fx_siren_lights");
  getent("intro_copcar5", "targetname") thread play_fx_when_shown("siren_light_intro", "tag_fx_siren_lights");
  getent("intro_bike1", "targetname") thread play_fx_when_shown("siren_light_bike_intro", "tag_fx_lights_front");
  getent("intro_bike2", "targetname") thread play_fx_when_shown("siren_light_bike_intro", "tag_fx_lights_front");
  getent("intro_bike3", "targetname") thread play_fx_when_shown("siren_light_bike_intro", "tag_fx_lights_front");
  getent("intro_bike4", "targetname") thread play_fx_when_shown("siren_light_bike_intro", "tag_fx_lights_front");
}

play_fx_when_shown(str_fx, str_tag) {
  self endon("death");

  while(true) {
    self waittill("show");
    wait(randomfloatrange(0, 0.3));
    play_fx(str_fx, undefined, undefined, "hide", 1, str_tag);
    self waittill("hide");
  }
}

cougar3_aim(veh_cougar) {
  veh_cougar3 = getent("intro_cougar3", "targetname");
  veh_drone2 = getent("intro_drone2", "targetname");
  veh_cougar3 maps\_turret::set_turret_target(veh_drone2, undefined, 2);
}

fade_in(m_player_body) {
  if(!is_mature())
    wait 7;

  flag_set("end_intro_screen");
  maps\_objectives::set_objective(level.obj_prom_night);
}

intro_shellshock(m_player_body) {
  earthquake(0.75, 2, level.player.origin, 1000);
  level.player shellshock("la_1_crash_exit", 2);
}

ambient_drones() {
  level.pause_ambient_drones = 0;
  level thread spawn_ambient_drones("trig_highway_flyby_1", "kill_highway_flyby_2", "pegasus_highway_flyby_1", "f38_highway_flyby_1", "start_highway_flyby_1", 5, 0, 3, 4, 500, 1);
  level thread spawn_ambient_drones("trig_highway_flyby_2", "kill_highway_flyby_2", "pegasus_highway_flyby_2", "f38_highway_flyby_2", "start_highway_flyby_2", 5, 0, 3, 4, 500, 3);
  level thread spawn_ambient_drones("trig_highway_flyby_3", "kill_highway_flyby_2", "pegasus_highway_flyby_3", "f38_highway_flyby_3", "start_highway_flyby_3", 5, 0, 4, 5, 500, 5);
  level thread spawn_ambient_drones("trig_highway_flyby_4", "kill_highway_flyby_2", "pegasus_highway_flyby_4", "f38_highway_flyby_4", "start_highway_flyby_4", 5, 0, 4, 5, 500, 5);
  wait 0.05;
  trigger_use("trig_highway_flyby_1");
  trigger_use("trig_highway_flyby_2");
  trigger_use("trig_highway_flyby_3");
  trigger_use("trig_highway_flyby_4");
  flag_wait("sam_cougar_mount_started");
  level.pause_ambient_drones = 1;
  flag_wait("sam_success");
  level.pause_ambient_drones = 0;
  level waittill_any_return("sniper_option", "rappel_option");
  trigger_use("kill_highway_flyby_2");
}

show_vehicle_count() {
  while(true) {
    vehicles = getvehiclearray();
    ambient_count = 0;

    foreach(vehicle in vehicles) {
      if(isDefined(vehicle.b_is_ambient))
        ambient_count++;
    }

    iprintln("Count: " + vehicles.size + " Ambient: " + ambient_count);
    wait 0.05;
  }

}