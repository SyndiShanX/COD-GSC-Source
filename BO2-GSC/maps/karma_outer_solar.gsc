/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_outer_solar.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_glasses;
#include maps\_objectives;
#include maps\_scene;
#include maps\karma_util;
#include maps\_music;
#include maps\karma_arrival;
#include maps\createart\karma_art;
#include maps\karma_anim;
#include maps\karma_inner_solar;
#include maps\karma_civilians;
#include maps\_fxanim;
#include maps\_drones;

init_flags() {
  flag_init("player_at_club");
  flag_init("kill_solar_lounge");
  flag_init("kill_outer_solar");
  flag_init("club_door_closed");
}

init_spawn_funcs() {
}

skipto_club_solar() {
  cleanup_ents("cleanup_checkin");
  cleanup_ents("cleanup_tower");
  cleanup_ents("cleanup_dropdown");
  cleanup_ents("cleanup_spiderbot");
  cleanup_ents("cleanup_crc");
  cleanup_ents("cleanup_construction");
  maps\karma_arrival::deconstruct_fxanims();
  level.ai_salazar = init_hero("salazar");
  skipto_teleport("skipto_outer_solar", array(level.ai_salazar));
  setsaveddvar("g_speed", 110);
  level.player thread maps\createart\karma_art::vision_set_change("sp_karma_office");
}

main() {
  iprintln("outer_solar");

  level.n_aggressivecullradius = getdvar(#"_id_0EC60F96");
  setsaveddvar("Cg_aggressivecullradius", 50);
  setsaveddvar("r_skyTransition", 1);
  setsaveddvar("mantle_enable", 0);
  maps\karma_anim::club_anims();
  level.ai_harper = init_hero("harper", maps\karma_inner_solar::harper_think);
  level.ai_karma = simple_spawn_single("karma", ::club_actor_think);
  level.ai_karma setforcenocull();
  level thread start_civs_outer_solar("kill_outer_solar");
  level thread outer_solar_objectives();
  rpc("clientscripts/karma_amb", "sndPlayShadows");
  level outer_solar_fx();
  wait 1.0;
  level thread populate_club();
  level thread club_fx();
  level thread harper_finds_karma_pip();
  level thread bar_glass_visibility_think();
  flag_set("player_among_civilians");
  setmusicstate("KARMA_1_OUTER_SOLAR");

  foreach(ent in getentarray("velvet_rope", "script_noteworthy"))
  ent setscale(0.9);

  trigger_wait("t_club_entrance");
  clientnotify("scle");
  level thread start_civs_lounge("kill_solar_lounge");
  flag_set("player_at_club");
  level thread run_scene_and_delete("bouncer_lounge_door_idle");
  trigger_wait("t_enter_club");
  level thread enter_bar_animations("club_door_closed");
  trigger_wait("t_lounge_door");
  exploder(615);
  level thread outer_door();
  level thread lounge_door();
  level thread outer_solar_cleanup();
}

outer_solar_objectives() {
  flag_wait("elevator_at_club");
  self thread objective_breadcrumb(level.obj_meet_karma, "t_club_entrance");
  trigger_wait("t_lounge_door_close");
}

harper_finds_karma_pip() {
  level.player show_hud();
  pip_snd_ent = spawn("script_origin", level.player.origin);
  pip_snd_ent playloopsound("evt_pip_club_loop");
  wait 0.1;
  level thread maps\_glasses::play_bink_on_hud("karma_pip_club", 0, 1, 0, 0, 1);
  flag_wait("glasses_bink_playing");
  delay_thread(0, ::run_scene_and_delete, "harper_finds_karma");
  level thread autosave_by_name("elevator_03");
  scene_wait("harper_finds_karma");
  pip_snd_ent stoploopsound();
  pip_snd_ent delete();
  level thread harper_and_karma_loop();
}

bar_glass_visibility_think() {
  foreach(e_glass in getentarray("club_glass", "targetname")) {
    e_glass setscale(0.5);
    e_glass hide();
  }

  flag_wait("start_club_encounter");

  foreach(e_glass in getentarray("club_glass", "targetname"))
  e_glass show();
}

enter_bar_animations(str_cleanup_flag) {
  level thread walk_to_loop_anim("outer_solar_enter_bar_a", "outer_solar_enter_bar_a_loop", str_cleanup_flag);
  level thread walk_to_loop_anim("outer_solar_enter_bar_b", "outer_solar_enter_bar_b_loop", str_cleanup_flag);
  level thread walk_to_loop_anim("outer_solar_enter_bar_c", "outer_solar_enter_bar_c_loop", str_cleanup_flag);
  level thread walk_to_loop_anim("outer_solar_enter_bar_d", "outer_solar_enter_bar_d_loop", str_cleanup_flag);
  level thread walk_to_loop_anim("outer_solar_enter_bar_e", "outer_solar_enter_bar_e_loop", str_cleanup_flag);
}

walk_to_loop_anim(str_scene_walk, str_scene_loop, str_cleanup_flag) {
  str_done = str_scene_walk + "_done";
  level thread run_scene_and_delete(str_scene_walk);

  while(true) {
    if(flag(str_done)) {
      break;
    }

    if(flag(str_cleanup_flag)) {
      end_scene(str_scene_walk);
      return;
    }

    wait 0.01;
  }

  level thread run_scene_and_delete(str_scene_loop);

  while(true) {
    if(flag(str_cleanup_flag)) {
      end_scene(str_scene_loop);
      return;
    }

    wait 0.01;
  }
}

outer_solar_fx() {
  thread globe_activate("sun_globe", 30, -1, "kill_solar_lounge", "outer_solar", "club_sun_small", "tag_origin");
  thread globe_activate("mercury_outer", 8.8, 1, "kill_solar_lounge", "outer_solar", "planet_static", "tag_fx_mercury", (72, 0, -6));
  thread globe_activate("venus_outer", 22.45, 1, "kill_solar_lounge", "outer_solar", "planet_static", "tag_fx_venus", (97, 0, 5));
  thread globe_activate("earth_outer", 36.5, 1, "kill_solar_lounge", "outer_solar", "planet_static", "tag_fx_earth", (124, 0, -12));
  exploder(600);
  exploder(601);
}

globe_activate(str_targetname, n_orbit_time, n_orbit_direction, str_endon, str_cleanup, str_fx, str_tag, v_offset) {
  if(!isDefined(v_offset))
    v_offset = (0, 0, 0);

  a_m_globes = getentarray(str_targetname, "targetname");

  foreach(m_globe in a_m_globes) {
    m_globe setforcenocull();

    if(isDefined(str_cleanup))
      m_globe add_cleanup_ent(str_cleanup);

    if(isDefined(m_globe.script_float)) {
      m_globe ignorecheapentityflag(1);
      m_globe setscale(m_globe.script_float);
    }

    if(isDefined(str_fx))
      m_globe thread play_fx(str_fx, m_globe.origin + v_offset, (0, 0, 0), str_endon, 1, undefined, 1);

    m_globe thread spin_globe(str_endon, n_orbit_time, n_orbit_direction);
  }
}

spin_globe(str_endon, n_orbit_time, n_orbit_direction) {
  if(!isDefined(n_orbit_time))
    n_orbit_time = 30;

  if(!isDefined(n_orbit_direction))
    n_orbit_direction = 1;

  self endon("death");

  if(isDefined(str_endon))
    level endon(str_endon);

  while(true) {
    self rotateyaw(n_orbit_direction * 360, n_orbit_time);
    wait(n_orbit_time);
  }
}

outer_door() {
  trigger_wait("t_lounge_door");
  time = 2.0;
  a_doors = getentarray("solarentrance_door", "targetname");

  for(i = 0; i < a_doors.size; i++) {
    e_door = a_doors[i];
    e_clip = getent(e_door.target, "targetname");
    e_clip linkto(e_door);
    e_door rotateyaw(e_door.script_int, time, 0, 0.15);
  }
}

lounge_door() {
  ai_bouncer = get_ais_from_scene("bouncer_lounge_door_idle", "lounge_bouncer");
  end_scene("bouncer_lounge_door_idle");
  ai_bouncer thread bouncer_open_lounge_door_anims();
  wait 1.3;
  clientnotify("scms");
  setmusicstate("KARMA_1_ENTER_CLUB");
  m_lounge_door = getent("lounge_door", "targetname");
  m_lounge_door_clip = getent("lounge_door_clip", "targetname");
  m_lounge_door_clip linkto(m_lounge_door);
  m_lounge_door rotateyaw(110, 1.8, 0, 0.15);
  trigger_wait("t_lounge_door_close");
  level thread cleanup_ents("cleanup_outersolar");
  level thread maps\karma_util::cleanup_structs("cleanup_outersolar");
  m_lounge_door rotateyaw(-110, 2.0, 0, 0.15);
  wait 2.0;
}

bouncer_open_lounge_door_anims() {
  self set_blend_in_out_times(0.2);
  level run_scene_and_delete("bouncer_lounge_door_open");
  level thread run_scene_and_delete("bouncer_lounge_door_wait");
  flag_wait("bouncer_lounge_door_wait_started");
  trigger_wait("t_lounge_door_close");
  level thread run_scene_and_delete("bouncer_lounge_door_close");
  wait 2.0;
  flag_set("club_door_closed");
}

assign_club_spawners() {
  maps\karma_civilians::assign_civ_spawners("club_bouncer");
  maps\karma_civilians::assign_civ_spawners("club_shadow_dancer");
  maps\karma_civilians::assign_civ_spawners("club_male", 2);
  maps\karma_civilians::assign_civ_spawners("club_female", 1);
  maps\karma_civilians::assign_civ_spawners("club_male_light", 1);
  maps\karma_civilians::assign_civ_spawners("club_female_light", 1);
}

init_solar_systems() {
  self notify("fxanim_solar_system_01_start");
  wait 1.0;
  self notify("fxanim_solar_system_02_start");
  wait 1.0;
  self notify("fxanim_solar_system_03_start");
  wait 1.0;
  self notify("fxanim_solar_system_04_start");
  wait 1.0;
  self notify("fxanim_solar_system_05_start");
  wait 1.0;
  self notify("fxanim_solar_system_06_start");
  wait 1.0;
  self notify("fxanim_solar_system_07_start");
  wait 1.0;
  self notify("fxanim_solar_system_08_start");
}

start_civs_outer_solar(str_kill_flag) {
  if(!is_mature()) {
    foreach(e_dancer in getentarray("dancers", "script_noteworthy"))
    e_dancer delete();

    level thread init_solar_systems();
  } else
    maps\_fxanim::fxanim_delete("fxanim_solar_system");

  assign_club_spawners();
  maps\_drones::drones_setup_unique_anims("solar_drones", level.drones.anims["civ_walk"]);
  maps\_drones::drones_speed_modifier("solar_drones", -0.1, 0.1);
  level maps\karma_civilians::spawn_static_club_civs("static_outer_couples", 0.0, "club_male", "club_female");
  level maps\karma_civilians::spawn_static_civs("static_outer_solar_elevator_civs");
  level maps\karma_civilians::spawn_static_club_civs("static_outer_civs", 2.0, "club_male", "club_female");
  level thread run_scene_and_delete("outer_solar_bouncer");
  level thread run_scene_and_delete("outer_solar_bouncer2");
  level thread run_scene_and_delete("outer_solar_line_guy01");
  level thread run_scene_and_delete("outer_solar_line_guy02");
  level thread run_scene_and_delete("outer_solar_girl01");
  level thread run_scene_and_delete("outer_solar_girl02");
  level thread run_scene_and_delete("outer_solar_girl03");
  level thread run_scene_and_delete("outer_solar_guy01");
  level thread run_scene_and_delete("outer_solar_guy02");
  level thread run_scene_and_delete("outer_solar_guy03");
  level thread run_scene_and_delete("outer_solar_guy04");
  level thread run_scene_and_delete("outer_solar_coatcheck_area_2guys");
  level thread run_scene_and_delete("outer_solar_coatcheck_area_couple");
  level thread run_scene_and_delete("outer_solar_bar_seated");
  level thread run_scene_and_delete("outer_bar_e");
  level thread run_scene_and_delete("outer_bar_c");
  level thread run_scene_and_delete("outer_bar_a_girl2");
  level thread run_scene_and_delete("outer_bar_a_guy1");
  level thread run_scene_and_delete("outer_bar_b_guy1");
  level thread run_scene_and_delete("outer_bar_d_girl1");
  level thread run_scene_and_delete("outer_bar_d_guy2");
  level thread run_scene_and_delete("outer_bar_f_girl1");
  level thread run_scene_and_delete("outer_bar_f_guy1");
  level thread run_scene_and_delete("outer_bar_f_guy2");
  level thread run_scene_and_delete("outer_bar_g_girl1");
  level thread run_scene_and_delete("outer_bar_g_guy1");
  level thread run_scene_and_delete("outer_bar_g_guy2");
  level thread seductive_lady_in_outer_bar();
  level thread blocking_club_bouncer();
  m_civ = get_model_or_models_from_scene("outer_bar_g_girl1", "outer_bar_g_girl1");
  m_civ attach("hjk_vodka_glass_lrg", "TAG_WEAPON_LEFT");
  m_civ = get_model_or_models_from_scene("outer_bar_g_guy2", "outer_bar_g_guy2");
  m_civ attach("p6_bar_beer_glass", "TAG_WEAPON_LEFT");
  m_bartender = get_model_or_models_from_scene("outer_bar_e", "outer_bar_e_bartender1");
  m_bartender attach("p6_bar_shaker_no_lid", "TAG_WEAPON_LEFT");
  m_bartender attach("p6_vodka_bottle", "TAG_WEAPON_RIGHT");
  m_bartender = get_model_or_models_from_scene("outer_bar_c", "outer_bar_c_bartender2");
  m_bartender attach("p6_bar_shaker_no_lid", "TAG_WEAPON_LEFT");
  m_bartender attach("p6_vodka_bottle", "TAG_WEAPON_RIGHT");
  flag_wait(str_kill_flag);
  level maps\karma_civilians::delete_civs("static_outer_couples");
  level maps\karma_civilians::delete_civs("static_outer_solar_elevator_civs");
  level maps\karma_civilians::delete_civs("static_outer_civs");
  end_scene("outer_solar_bouncer");
  end_scene("outer_solar_bouncer2");
  end_scene("outer_solar_line_guy01");
  end_scene("outer_solar_line_guy02");
  end_scene("outer_solar_girl01");
  end_scene("outer_solar_girl02");
  end_scene("outer_solar_girl03");
  end_scene("outer_solar_guy01");
  end_scene("outer_solar_guy02");
  end_scene("outer_solar_guy03");
  end_scene("outer_solar_guy04");
  flag_wait("kill_solar_lounge");
  end_scene("outer_solar_coatcheck_area_2guys");
  end_scene("outer_solar_coatcheck_area_couple");
  end_scene("outer_solar_bar_seated");
  wait 0.1;
  end_scene("outer_bar_e");
  end_scene("outer_bar_c");
  wait 0.1;
  end_scene("outer_bar_a_girl2");
  end_scene("outer_bar_a_guy1");
  wait 0.1;
  end_scene("outer_bar_b_guy1");
  end_scene("outer_bar_d_girl1");
  end_scene("outer_bar_d_guy2");
  wait 0.1;
  end_scene("outer_bar_f_girl1");
  end_scene("outer_bar_f_guy1");
  end_scene("outer_bar_f_guy2");
  wait 0.1;
  end_scene("outer_bar_g_girl1");
  end_scene("outer_bar_g_guy1");
  end_scene("outer_bar_g_guy2");
}

seductive_lady_in_outer_bar() {
  trigger_wait("t_enter_club");
  run_scene_and_delete("outer_seductive_woman_intro");
  str_scene_name = "outer_seductive_woman_loop";
  level thread run_scene_and_delete(str_scene_name);

  while(true) {
    if(flag("kill_solar_lounge")) {
      end_scene(str_scene_name);
      return;
    }

    wait 0.01;
  }
}

blocking_club_bouncer() {
  str_anim_name = "main_bouncer_loop";
  level thread run_scene_and_delete(str_anim_name);
  e_trigger = getent("player_approaches_main_bouncer_trigger", "targetname");
  e_trigger waittill("trigger");
  e_bouncer = getent("club_main_enterance_bouncer_ai", "targetname");
  level notify("salazar_enter_club");
  end_scene(str_anim_name);
  e_bouncer thread blocking_bouncer_vo_and_wristband();
  str_anim_name = "main_bouncer_moveout";
  run_scene_and_delete(str_anim_name);
  str_anim_name = "main_bouncer_moveout_loop";
  level thread run_scene_and_delete(str_anim_name);
  trigger_wait("t_enter_club");
  end_scene(str_anim_name);
  str_anim_name = "main_bouncer_moveback";
  run_scene_and_delete(str_anim_name);
  str_anim_name = "main_bouncer_moveback_complete_loop";
  level thread run_scene_and_delete(str_anim_name);

  while(true) {
    if(flag("kill_outer_solar")) {
      break;
    }

    wait 0.01;
  }

  end_scene(str_anim_name);
}

blocking_bouncer_vo_and_wristband() {
  level thread player_show_wristband(0.75);
  e_dialog_pos = spawn("script_origin", getstruct("club_line_female_vo", "targetname").origin);
  e_dialog_pos say_dialog("woma_hey_how_come_they_0", undefined, 1);
  e_dialog_pos delete();
  self say_dialog("door_their_ids_say_vip_0");
  e_dialog_pos = spawn("script_origin", getstruct("club_line_male_vo", "targetname").origin);
  e_dialog_pos say_dialog("dude_come_on_man_the_chi_0", undefined, 1);
  e_dialog_pos delete();
  self say_dialog("door_sorry_sir_we_re_v_0");
}

player_show_wristband(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  level.player_viewmodel = "c_usa_masonjr_karma_viewhands";
  level.player showviewmodel();
  level.player enableweapons();
  level.player giveweapon("noweapon_sp_arm_raise");
  level.player switchtoweapon("noweapon_sp_arm_raise");
  wait 2;
  level.player takeweapon("noweapon_sp_arm_raise");
  level.player disableweapons();
  level.player hideviewmodel();
  level.player_viewmodel = "c_usa_masonjr_karma_armlaunch_viewhands";
}

start_civs_lounge(str_kill_flag) {
  maps\karma_civilians::assign_civ_drone_spawners("civ_club", "lounge_drones");
  level maps\karma_civilians::spawn_static_club_civs("static_lounge", 2.0, "club_male", "club_female");
  level maps\karma_civilians::spawn_static_club_civs("static_lounge_couples", 0.0, "club_male", "club_female");
  level maps\karma_civilians::spawn_static_civs("static_club_approaching");
  level maps\karma_civilians::spawn_static_civs("static_club_approaching_couples", 0.0);
  flag_wait(str_kill_flag);
  level thread maps\_drones::drones_delete_spawned();
  level thread maps\karma_civilians::delete_civs("static_lounge");
  level thread maps\karma_civilians::delete_civs("static_lounge_couples");
}

ai_logic() {
  self gun_remove();
}

outer_solar_cleanup() {
  flag_set("kill_outer_solar");
  flag_wait("club_door_closed");
  flag_set("kill_solar_lounge");
  wait 0.1;
  delete_exploder(600);
  delete_exploder(601);
  wait 0.1;

  foreach(e_door in getentarray("script_doors", "script_noteworthy"))
  e_door delete();

  if(is_mature()) {
    foreach(e_dancer in getentarray("dancers", "script_noteworthy")) {
      if(isDefined(e_dancer.script_float) && e_dancer.script_float == 1.0)
        e_dancer delete();
    }
  } else {
    foreach(e_solarsystem in getentarray("fxanim_solar_system", "targetname")) {
      if(isDefined(e_solarsystem.script_int) && e_solarsystem.script_int == 1)
        e_solarsystem.script_string = "solar_system_delete";
    }

    maps\_fxanim::fxanim_delete("solar_system_delete");
  }

  cleanup_ents("outer_solar");
}