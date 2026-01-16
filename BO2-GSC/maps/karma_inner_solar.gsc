/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_inner_solar.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_glasses;
#include maps\_objectives;
#include maps\_scene;
#include maps\karma_util;
#include maps\_music;
#include maps\_fxanim;
#include maps\karma_anim;
#include maps\karma_outer_solar;
#include maps\karma_civilians;
#include maps\createart\karma_art;
#include maps\_drones;
#include maps\_anim;
#include animscripts\utility;

init_flags() {
  flag_init("entered_inner_club");
  flag_init("salazar_start_overwatch");
  flag_init("start_club_encounter");
  flag_init("stop_club_fx");
  flag_init("club_left_flee");
  flag_init("club_right_flee");
  flag_init("club_rear_flee");
  flag_init("run_to_bar");
  flag_init("start_bar_fight");
  flag_init("heroes_open_fire");
  flag_init("club_open_fire");
  flag_init("club_stop_timescale");
  flag_init("club_civs_scream");
  flag_init("counterterrorists_win");
  flag_init("exit_club");
  flag_init("inner_solar_dialog_start");
  flag_init("club_terrorists_alerted");
  flag_init("bar_fight_end_slow");
  flag_init("bar_fight_spawn_wave");
  flag_init("bar_fight_cover_advance");
  flag_init("restart_club_fx");
}

init_spawn_funcs() {
  add_spawn_function_group("club_terrorists", "script_noteworthy", ::club_terrorist_think);
  add_spawn_function_group("club_pmc1", "targetname", ::club_terrorist_think);
  add_spawn_function_group("club_pmc2", "targetname", ::club_terrorist_think);
  add_spawn_function_group("club_pmc3", "targetname", ::club_terrorist_think);
  add_global_spawn_function("axis", ::adjust_accuracy_for_difficulty);
}

skipto_inner_solar() {
  cleanup_ents("cleanup_checkin");
  cleanup_ents("cleanup_tower");
  cleanup_ents("cleanup_dropdown");
  cleanup_ents("cleanup_spiderbot");
  cleanup_ents("cleanup_crc");
  cleanup_ents("cleanup_construction");

  for(i = 1; i <= 12; i++)
    maps\_fxanim::fxanim_deconstruct("fxanim_club_top_laser_" + i);

  for(i = 1; i <= 2; i++)
    maps\_fxanim::fxanim_deconstruct("fxanim_club_dj_laser_" + i);

  for(i = 1; i <= 2; i++)
    maps\_fxanim::fxanim_deconstruct("fxanim_club_bar_shelves_0" + i);

  if(!is_mature()) {
    foreach(e_dancer in getentarray("dancers", "script_noteworthy"))
    e_dancer delete();

    level thread init_solar_systems();
  } else
    maps\_fxanim::fxanim_delete("fxanim_solar_system");

  maps\karma_anim::club_anims();
  level.ai_harper = init_hero("harper", ::harper_think);
  skipto_teleport("skipto_inner_solar");
  setsaveddvar("g_speed", 110);
  level thread harper_and_karma_loop();
  maps\karma_outer_solar::assign_club_spawners();
  level maps\karma_civilians::spawn_static_civs("static_club_approaching");
  level maps\karma_civilians::spawn_static_civs("static_club_approaching_couples", 0.0);
  exploder(601);
  wait 3.0;
  clientnotify("scms");
  level thread club_fx();
  level thread populate_club();

  foreach(ent in getentarray("velvet_rope", "script_noteworthy"))
  ent setscale(0.9);
}

skipto_solar_fight() {
  cleanup_ents("cleanup_checkin");
  cleanup_ents("cleanup_tower");
  cleanup_ents("cleanup_dropdown");
  cleanup_ents("cleanup_spiderbot");
  cleanup_ents("cleanup_crc");
  cleanup_ents("cleanup_construction");

  if(!is_mature()) {
    foreach(e_dancer in getentarray("dancers", "script_noteworthy"))
    e_dancer delete();

    level thread init_solar_systems();
  } else
    maps\_fxanim::fxanim_delete("fxanim_solar_system");

  level.player setstance("crouch");
  level.player allowstand(0);
  init_club_battle_damage_timing();
  level.player.overrideplayerdamage = ::player_damage_override;
  bm_clip = getent("dance_floor_clip", "targetname");
  bm_clip delete();
  level.player maps\createart\karma_art::vision_set_change("sp_karma_clubmain_dancefloor");
  maps\karma_anim::club_anims();
  level.ai_harper = init_hero("harper", ::harper_think);
  maps\karma_outer_solar::assign_club_spawners();
  level thread club_drones();
  skipto_teleport("skipto_solar_fight");
  a_m_groups = getentarray("m_civ_club_group1", "targetname");
  array_delete(a_m_groups);

  foreach(ent in getentarray("velvet_rope", "targetname"))
  ent delete();

  getent("sick_girls_clip", "targetname") delete();
  level thread change_club_lights();
  level.player thread inner_club_dialog();
  flag_set("entered_inner_club");

  for(i = 1; i <= 12; i++) {
    m_laser = getent("fxanim_club_top_laser_" + i, "targetname");
    m_laser setforcenocull();
    str_tag = "laser_attach_jnt";
    m_laser play_fx("club_dance_floor_laser", undefined, undefined, "stop_fx", 1, str_tag, 1);
  }

  level notify("fxanim_club_top_lasers_start");
  wait 0.05;
  flag_set("restart_club_fx");
  level thread club_dj_front_lasers();
  thread globe_activate("sun_globe_inner", 30, -1, "kill_solar_lounge", "outer_solar", "club_sun", "tag_origin");
  thread globe_activate("mercury", 8.8, 1, "kill_solar_lounge", "outer_solar", "planet_static", "tag_fx_mercury", (144, 0, -11));
  thread globe_activate("venus", 22.45, 1, "kill_solar_lounge", "outer_solar", "planet_static", "tag_fx_venus", (195, 0, 10));
  thread globe_activate("earth", 36.5, 1, "kill_solar_lounge", "outer_solar", "planet_static", "tag_fx_earth", (250, 0, -25));
}

club_intro() {
  iprintln("INNER_SOLAR");

  delete_exploder(0, 599);
  delete_exploder(900, 920);
  delete_exploder(1001);
  delete_exploder(10510, 10511);
  level thread inner_solar_objectives();
  level.player thread inner_club_dialog();
  trigger_wait("t_club_start_harper");

  if(!isDefined(level.n_aggressivecullradius))
    level.n_aggressivecullradius = getdvar(#"_id_0EC60F96");

  setsaveddvar("Cg_aggressivecullradius", 50);
  flag_wait("start_club_encounter");
  level thread run_scene_and_delete("club_encounter");
  level thread run_scene_and_delete("club_encounter_player");
  level thread run_scene_and_delete("club_encounter_allies");
  level thread run_scene_and_delete("club_encounter_dancers2");
  level thread run_scene_and_delete("club_encounter_dancers3");
  flag_wait("club_encounter_started");
  flag_wait("club_encounter_player_started");
  flag_wait("club_encounter_allies_started");
  level thread change_club_lights(2, 2);
  level thread defalco_execution_mature_filter();
  get_ais_from_scene("club_encounter", "defalco") gun_switchto("fiveseven_sp", "right");
  level.ai_harper set_blend_in_out_times(0.2);
  get_model_or_models_from_scene("club_encounter_allies", "karma") set_blend_in_out_times(0.2);
  setsaveddvar("g_speed", level.default_run_speed);
  level.player enableinvulnerability();
  clientnotify("lull");
  bm_clip = getent("dance_floor_clip", "targetname");
  bm_clip delete();

  foreach(ent in getentarray("velvet_rope", "targetname"))
  ent delete();

  clear_background_civilians();
  level thread club_drones();
  wait 3.55;
  level.player allowstand(0);
  level.player setstance("crouch");
  flag_set("club_left_flee");
  wait 1.5;
  flag_set("club_right_flee");
  level thread play_notify_music_start();
  end_scene("seductive_woman_loop");
  end_scene("sick_girls");
  getent("sick_girls_clip", "targetname") delete();
  scene_wait("club_encounter");
  setsaveddvar("Cg_aggressivecullradius", level.n_aggressivecullradius);
  setsaveddvar("mantle_enable", 1);
  luinotifyevent(&"hud_shrink_ammo");
}

defalco_execution_mature_filter() {
  if(!is_mature()) {
    wait 12.0;
    screen_fade_out(0);
    wait 1.0;
    screen_fade_in(0);
  }
}

play_notify_music_start() {
  setmusicstate("KARMA_1_DEFALCO");
  wait 22.5;
  clientnotify("scm3");
  setmusicstate("KARMA_1_CLUB_FIGHT");
}

club_fight() {
  level.callbackactorkilled = ::callback_actorkilled_headshotcheck;
  flag_set("start_bar_fight");
  thread run_scene_and_delete("bar_fight_player");
  thread run_scene_and_delete("bar_fight_harper");
  thread run_scene_and_delete("bar_fight_pmcs");
  thread player_bar_fight();
  level thread bar_fight_waves_think();
  wait 0.05;

  foreach(ai_pmc in get_ais_from_scene("bar_fight_pmcs"))
  ai_pmc set_blend_in_out_times(0.2);

  delete_exploder(628);
  exploder(630);
  thread run_scene_and_delete("bar_fight_pmc5");
  wait 1.6;
  wait 0.9;
  thread run_scene_and_delete("bar_fight_pmc4");
  wait 1.7;
  flag_clear("run_to_bar");
  flag_set("restart_club_fx");
  level.ai_harper get_ai_targets("club_target_harper");
  scene_wait("bar_fight_harper");
  level thread run_scene_and_delete("bar_fight_movement_pmcs");
  scene_wait("bar_fight_movement3");
  level.ai_harper force_goal(getnode("harper_bar_fight_end_cover", "targetname"), 128, 0);
  level.ai_harper set_ignoreall(0);
  level.ai_harper set_ignoreme(0);
  waittill_ai_group_ai_count("aig_club_terrorists", 0);
  level.player.overrideplayerdamage = undefined;
  flag_set("counterterrorists_win");
  karma_2_transition();
}

bar_fight_waves_think() {
  flag_wait("bar_fight_spawn_wave");
  flag_clear("bar_fight_spawn_wave");
  delay_thread(2.0, ::dj_jump_spawn);
  level thread bar_fight_spawn_wave("club_fight_wave2_pos", 2.0);
  flag_wait("bar_fight_spawn_wave");
  flag_clear("bar_fight_spawn_wave");
  level thread bar_fight_spawn_wave("club_fight_wave3_pos", 2.0);
  flag_wait("bar_fight_spawn_wave");
  flag_clear("bar_fight_spawn_wave");
  level thread bar_fight_spawn_wave("club_fight_wave4_pos", 2.0, 0);
}

dj_jump_spawn() {
  level thread run_scene_and_delete("bar_fight_dj_jump");
  flag_wait("bar_fight_dj_jump_started");
  a_guys = get_ais_from_scene("bar_fight_dj_jump");
  scene_wait("bar_fight_dj_jump");

  foreach(ai_guy in a_guys) {
    if(isalive(ai_guy)) {
      ai_guy thread shoot_at_target_untill_dead(level.player);
      ai_guy force_goal(getnode(ai_guy.target, "targetname"), 8);
    }
  }
}

bar_fight_spawn_cover_guys() {
  foreach(s_pos in getstructarray("club_fight_cover_start", "targetname"))
  s_pos thread bar_fight_cover_spawn();
}

bar_fight_cover_spawn() {
  if(isDefined(self.script_float))
    wait(self.script_float);

  ai_guy = simple_spawn_single("club_terrorist_assault");
  ai_guy.script_noteworthy = "nodamage";
  ai_guy endon("death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "delete")
    ai_guy.script_string = "delete";
  else
    ai_guy.script_string = "no_delete";

  ai_guy forceteleport(self.origin, self.angles);
  ai_guy set_goalradius(8);
  ai_guy thread force_goal(getnode(self.target, "targetname"), 8);
  ai_guy thread shoot_at_target_untill_dead(level.player);

  for(i = 0; i < 2; i++) {
    flag_wait("bar_fight_cover_advance");
    nd_node = getnode(self.target, "targetname");

    if(isDefined(nd_node)) {
      self.target = nd_node.target;

      if(isDefined(self.target)) {
        nd_node = getnode(self.target, "targetname");

        if(isDefined(nd_node)) {
          if(isDefined(nd_node.script_noteworthy) && nd_node.script_noteworthy == "delete")
            ai_guy.script_string = "delete";

          ai_guy notify("stop_shoot_at_target");
          ai_guy thread force_goal(nd_node, 8);
          ai_guy thread shoot_at_target_untill_dead(level.player);
        }
      }
    }

    wait 0.05;
    flag_clear("bar_fight_cover_advance");
  }

  flag_wait("bar_fight_cover_advance");
  wait 0.05;
  flag_clear("bar_fight_cover_advance");
  ai_guy delete();
}

bar_fight_spawn_wave(str_pos, n_delay, do_cleanup) {
  if(!isDefined(do_cleanup))
    do_cleanup = 1;

  a_mid_positions = getstructarray(str_pos, "targetname");
  a_ai_living = getaiarray("axis");

  if(do_cleanup) {
    foreach(ai_guy in a_ai_living) {
      if(isalive(ai_guy))
        ai_guy thread delay_delete(n_delay);
    }
  }

  foreach(s_pos in a_mid_positions)
  s_pos thread bar_fight_spawn_mid();

  if(isDefined(n_delay))
    wait(n_delay + 0.05);

  flag_set("bar_fight_cover_advance");
}

delay_delete(n_delay) {
  wait(n_delay);

  if(isalive(self) && !isDefined(self.script_string)) {
    wait(randomfloatrange(0.1, 0.25));
    self kill();
  } else if(isalive(self) && isDefined(self.script_string) && self.script_string == "delete")
    self delete();
}

bar_fight_spawn_fore() {
  if(isDefined(self.script_float))
    wait(self.script_float);

  ai_guy = simple_spawn_single("club_terrorist_" + self.script_noteworthy);
  ai_guy forceteleport(self.origin, self.angles);
  ai_guy thread shoot_at_target_untill_dead(level.player);
  ai_guy set_goalradius(8);
  ai_guy force_goal(self, 8);
}

bar_fight_spawn_mid() {
  if(isDefined(self.script_float))
    wait(self.script_float);

  ai_guy = simple_spawn_single("club_terrorist_" + self.script_noteworthy);

  if(isDefined(self.script_string))
    ai_guy change_movemode(self.script_string);

  nd_node = getnode(self.target, "targetname");
  ai_guy forceteleport(self.origin, self.angles);
  ai_guy thread shoot_at_target_untill_dead(level.player);
  ai_guy set_goalradius(8);
  ai_guy force_goal(nd_node, 8);

  if(isDefined(nd_node.script_noteworthy) && nd_node.script_noteworthy == "crouch")
    ai_guy allowedstances("crouch");
}

bar_fight_spawn_back() {
  if(isDefined(self.script_float))
    wait(self.script_float);

  ai_guy = simple_spawn_single("club_terrorist_" + self.script_noteworthy);

  if(isDefined(self.script_string))
    ai_guy change_movemode(self.script_string);

  ai_guy forceteleport(self.origin, self.angles);
  ai_guy thread shoot_at_target_untill_dead(level.player);
  ai_guy set_goalradius(8);
  nd_cover = self;

  if(isDefined(self.target))
    nd_cover = getnode(self.target, "targetname");

  ai_guy force_goal(nd_cover, 8);
}

inner_solar_objectives() {
  objective_breadcrumb(level.obj_meet_karma, "t_lounge_door_close");
  flag_wait("start_club_encounter");
  set_objective(level.obj_meet_karma, undefined, "done");
}

club_fight_objectives() {
  set_objective(level.obj_stop_defalco, undefined);
}

change_club_lights(n_time_floor, n_time_exposure) {
  if(!isDefined(n_time_floor))
    n_time_floor = 0.05;

  if(!isDefined(n_time_exposure))
    n_time_exposure = 0.05;

  a_e_lights = getentarray("speechlight", "targetname");

  foreach(e_light in a_e_lights)
  e_light setforcenocull();

  if(!flag("run_to_bar"))
    array_thread(a_e_lights, ::lerp_intensity, 30, n_time_floor);

  thread blend_exposure_over_time(4.0, n_time_exposure);
  flag_wait("run_to_bar");
  wait(n_time_floor);
  clientnotify("clon");
}

club_fx() {
  a_s_candles = getstructarray("candle_flame", "targetname");

  foreach(s_candle in a_s_candles) {
    if(isDefined(s_candle.angles))
      v_forward = anglestoforward(s_candle.angles);
    else
      v_forward = (1, 0, 0);

    level thread play_fx("kar_candle01", s_candle.origin, s_candle.angles, undefined, 0, undefined, 1);
  }

  a_s_ashtrays = getstructarray("ashtray_smoke", "targetname");

  foreach(s_ashtray in a_s_ashtrays) {
    if(isDefined(s_ashtray.angles))
      v_forward = anglestoforward(s_ashtray.angles);
    else
      v_forward = (1, 0, 0);

    playfx(level._effect["kar_ashtray01"], s_ashtray.origin, v_forward);
  }

  for(i = 1; i <= 12; i++)
    maps\_fxanim::fxanim_reconstruct("fxanim_club_top_laser_" + i);

  for(i = 1; i <= 2; i++)
    maps\_fxanim::fxanim_reconstruct("fxanim_club_dj_laser_" + i);

  for(i = 1; i <= 2; i++)
    maps\_fxanim::fxanim_reconstruct("fxanim_club_bar_shelves_0" + i);

  flag_wait("club_door_closed");
  exploder(620);
  wait 2.0;

  for(i = 1; i <= 12; i++) {
    m_laser = getent("fxanim_club_top_laser_" + i, "targetname");
    m_laser setforcenocull();
    str_tag = "laser_attach_jnt";
    m_laser play_fx("club_dance_floor_laser", undefined, undefined, "stop_fx", 1, str_tag, 1);
  }

  level notify("fxanim_club_top_lasers_start");
  wait 0.05;
  level thread club_dj_front_lasers();
  wait 5.05;
  thread globe_activate("sun_globe_inner", 30, -1, "kill_solar_lounge", "outer_solar", "club_sun", "tag_origin");
  thread globe_activate("mercury", 8.8, 1, "kill_solar_lounge", "outer_solar", "planet_static", "tag_fx_mercury", (144, 0, -11));
  thread globe_activate("venus", 22.45, 1, "kill_solar_lounge", "outer_solar", "planet_static", "tag_fx_venus", (195, 0, 10));
  thread globe_activate("earth", 36.5, 1, "kill_solar_lounge", "outer_solar", "planet_static", "tag_fx_earth", (250, 0, -25));
  flag_wait("stop_club_fx");
  delete_exploder(601);
  delete_exploder(620);

  for(i = 1; i <= 12; i++) {
    m_laser = getent("fxanim_club_top_laser_" + i, "targetname");
    m_laser notify("stop_fx");
  }

  wait 0.05;
  m_laser = getent("fxanim_club_dj_laser_1", "targetname");
  m_laser.fx_origin delete();
  wait 0.05;
  m_laser = getent("fxanim_club_dj_laser_2", "targetname");
  m_laser.fx_origin delete();
  m_laser.fx_origin = spawn_model("tag_origin", m_laser gettagorigin("laser_attach_jnt"), m_laser gettagangles("laser_attach_jnt"));
  m_laser.fx_origin linkto(m_laser, "laser_attach_jnt");
  playfxontag(level._effect["club_dj_front_laser_static"], m_laser.fx_origin, "tag_origin");
  flag_wait("restart_club_fx");
  m_laser.fx_origin delete();

  for(i = 1; i <= 12; i++) {
    m_laser = getent("fxanim_club_top_laser_" + i, "targetname");
    m_laser setforcenocull();
    str_tag = "laser_attach_jnt";
    m_laser play_fx("club_dance_floor_laser", undefined, undefined, "stop_fx", 1, str_tag, 1);
  }

  level notify("fxanim_club_top_lasers_start");
  wait 0.05;
  level thread club_dj_front_lasers();
  wait 5.05;
  thread globe_activate("sun_globe_inner", 30, -1, "kill_solar_lounge", "outer_solar", "club_sun", "tag_origin");
  thread globe_activate("mercury", 8.8, 1, "kill_solar_lounge", "outer_solar", "planet_static", "tag_fx_mercury", (144, 0, -11));
  thread globe_activate("venus", 22.45, 1, "kill_solar_lounge", "outer_solar", "planet_static", "tag_fx_venus", (195, 0, 10));
  thread globe_activate("earth", 36.5, 1, "kill_solar_lounge", "outer_solar", "planet_static", "tag_fx_earth", (250, 0, -25));
}

club_dj_front_lasers() {
  level endon("stop_club_fx");
  m_laser1 = getent("fxanim_club_dj_laser_1", "targetname");
  m_laser1 setforcenocull();
  m_laser1.fx_origin = spawn_model("tag_origin", m_laser1 gettagorigin("laser_attach_jnt"), m_laser1 gettagangles("laser_attach_jnt"));
  m_laser1.fx_origin linkto(m_laser1, "laser_attach_jnt");
  m_laser2 = getent("fxanim_club_dj_laser_2", "targetname");
  m_laser2 setforcenocull();
  m_laser2.fx_origin = spawn_model("tag_origin", m_laser2 gettagorigin("laser_attach_jnt"), m_laser2 gettagangles("laser_attach_jnt"));
  m_laser2.fx_origin linkto(m_laser2, "laser_attach_jnt");
  level notify("fxanim_club_dj_lasers_start");

  while(true) {
    exploder(627);

    if(!flag("restart_club_fx")) {
      playfxontag(level._effect["club_dj_front_laser2_smoke"], m_laser1.fx_origin, "tag_origin");
      playfxontag(level._effect["club_dj_front_laser2_smoke"], m_laser2.fx_origin, "tag_origin");
      wait 10;
      playfxontag(level._effect["club_dj_front_laser2_light"], m_laser1.fx_origin, "tag_origin");
      playfxontag(level._effect["club_dj_front_laser2_light"], m_laser2.fx_origin, "tag_origin");
      wait 10;
      playfxontag(level._effect["club_dj_front_laser2_disco"], m_laser1.fx_origin, "tag_origin");
      playfxontag(level._effect["club_dj_front_laser2_disco"], m_laser2.fx_origin, "tag_origin");
      wait 10;
      playfxontag(level._effect["club_dj_front_laser2_fan"], m_laser1.fx_origin, "tag_origin");
      playfxontag(level._effect["club_dj_front_laser2_fan"], m_laser2.fx_origin, "tag_origin");
      wait 10;
      playfxontag(level._effect["club_dj_front_laser2_roller"], m_laser1.fx_origin, "tag_origin");
      playfxontag(level._effect["club_dj_front_laser2_roller"], m_laser2.fx_origin, "tag_origin");
      wait 10;
    }

    playfxontag(level._effect["club_dj_front_laser2_shell"], m_laser1.fx_origin, "tag_origin");
    playfxontag(level._effect["club_dj_front_laser2_shell"], m_laser2.fx_origin, "tag_origin");
    wait 6;
  }
}

start_civs_club() {
  maps\_drones::drones_set_max(256);
  level maps\karma_civilians::spawn_static_civs("static_club_patrons");
  level maps\karma_civilians::spawn_static_civs("static_club_patron_couples", 0.0);
  wait 0.5;
  level maps\karma_civilians::spawn_static_civs("static_club_dancers");
}

#using_animtree("animated_props");

group_dancing() {
  self endon("death");
  self useanimtree(#animtree);
  wait(randomfloatrange(0.0, 1.0));

  if(randomint(100) < 50)
    maps\_anim::anim_generic(self, "group_dancing2");

  while(true) {
    maps\_anim::anim_generic(self, "group_dancing1");
    maps\_anim::anim_generic(self, "group_dancing2");
  }
}

populate_club() {
  level thread seductive_woman();
  level thread sick_girls();
  level thread run_scene_and_delete("dj_loop");
  wait 0.1;
  level.ai_dj = get_model_or_models_from_scene("dj_loop", "club_dj");
  level.ai_dj setforcenocull();
  level thread run_scene_and_delete("club_encounter_hostages_loop");
  wait 0.1;
  level thread run_scene_and_delete("club_encounter_dancers1_loop");
  wait 0.1;
  level thread run_scene_and_delete("club_encounter_dancers2_loop");
  wait 0.1;
  level thread run_scene_and_delete("club_encounter_dancers3_loop");
  wait 0.1;
  a_models = get_model_or_models_from_scene("club_encounter_hostages_loop");

  foreach(model in a_models)
  model setforcenocull();

  a_models = get_model_or_models_from_scene("club_encounter_dancers1_loop");

  foreach(model in a_models)
  model setforcenocull();

  a_models = get_model_or_models_from_scene("club_encounter_dancers2_loop");

  foreach(model in a_models)
  model setforcenocull();

  a_models = get_model_or_models_from_scene("club_encounter_dancers3_loop");

  foreach(model in a_models)
  model setforcenocull();

  flag_wait("club_door_closed");
  wait 1;
  a_m_group_dancers = getentarray("m_civ_club_group1", "targetname");
  array_thread(a_m_group_dancers, ::group_dancing);
  wait 0.1;
  level start_civs_club();
  wait 0.1;
  exploder(621);
  wait 0.1;
  exploder(622);
  wait 0.1;
  exploder(623);
  wait 0.1;
  level thread react_scene("trig_club_react_a", "club_react_a_start_idle", "club_react_a_react", "club_react_a_end_idle", "start_club_encounter");
  wait 0.1;
  level thread react_scene("trig_club_react_b", "club_react_b_start_idle", "club_react_b_react", "club_react_b_end_idle", "start_club_encounter");
  wait 0.1;
  level thread react_scene("trig_club_react_c", "club_react_c_start_idle", "club_react_c_react", "club_react_c_end_idle", "start_club_encounter");
  wait 0.1;
  level thread react_scene("t_part_dancers_a", "club_dance_parters_a_loop", "club_dance_parters_a_react", "club_dance_parters_a_endloop", "start_club_encounter");
  wait 0.1;
  level thread react_scene("t_part_dancers_b", "club_dance_parters_b_loop", "club_dance_parters_b_react", "club_dance_parters_b_endloop", "start_club_encounter");
  wait 0.1;
  level thread react_scene("t_part_dancers_c", "club_dance_parters_c_loop", "club_dance_parters_c_react", "club_dance_parters_c_endloop", "start_club_encounter");
  wait 0.1;
  thread money_showers();
  level thread run_scene_and_delete("bar_e");
  wait 0.5;
  level thread run_scene_and_delete("bar_c");
  wait 0.5;
  level thread run_scene_and_delete("bar_a_girl2");
  level thread run_scene_and_delete("bar_a_guy1");
  wait 0.5;
  level thread run_scene_and_delete("bar_d_girl1");
  level thread run_scene_and_delete("bar_d_guy2");
  wait 0.5;
  level thread run_scene_and_delete("bar_g_girl1");
  wait 0.5;
  m_civ = get_model_or_models_from_scene("bar_g_girl1", "bar_g_girl1");
  m_civ attach("hjk_vodka_glass_lrg", "TAG_WEAPON_LEFT");
  m_bartender = get_model_or_models_from_scene("bar_e", "bar_e_bartender1");
  m_bartender attach("p6_bar_shaker_no_lid", "TAG_WEAPON_LEFT");
  m_bartender attach("p6_vodka_bottle", "TAG_WEAPON_RIGHT");
  m_bartender = get_model_or_models_from_scene("bar_c", "bar_c_bartender2");
  m_bartender attach("p6_bar_shaker_no_lid", "TAG_WEAPON_LEFT");
  m_bartender attach("p6_vodka_bottle", "TAG_WEAPON_RIGHT");
  flag_wait("start_club_encounter");
  end_scene("club_react_a_react");
  end_scene("club_react_b_react");
  end_scene("club_react_c_react");
}

sick_girls() {
  level thread run_scene_and_delete("sick_girls");
  wait 0.05;
  a_girls = get_model_or_models_from_scene("sick_girls");
  a_girls[0] attach("c_mul_civ_club_female_head1", "", 1);
  a_girls[1] attach("c_mul_civ_club_female_head5", "", 1);
}

seductive_woman() {
  trigger_wait("trig_club_hallway");
  level thread run_scene_and_delete("seductive_woman_intro");
  get_ais_from_scene("seductive_woman_intro", "seductive_woman").ikpriority = 5;
  scene_wait("seductive_woman_intro");
  level thread run_scene_and_delete("seductive_woman_loop");
}

money_showers() {
  level endon("start_club_encounter");
  exploder(624);
  wait 2.0;
  exploder(625);
  wait 2.0;
  exploder(626);
  wait 2.0;
  a_spots[0] = 624;
  a_spots[1] = 625;
  a_spots[2] = 626;
  a_spots = array_randomize(a_spots);
  n_index = 0;

  while(true) {
    exploder(a_spots[n_index]);
    wait(randomfloatrange(3, 4));
    n_index++;

    if(n_index == a_spots.size) {
      n_last_spot = a_spots[n_index - 1];
      n_index = 0;
      a_spots = array_randomize(a_spots);

      if(a_spots[0] == n_last_spot) {
        a_spots[0] = a_spots[a_spots.size - 1];
        a_spots[a_spots.size - 1] = n_last_spot;
      }
    }
  }
}

harper_and_karma_loop() {
  level thread run_scene_and_delete("club_encounter_harper_loop");
}

club_drones() {
  a_str_types[0] = "club_male_light";
  a_str_types[1] = "club_female_light";
  maps\karma_civilians::assign_civ_drone_spawners_by_type(a_str_types, "club_left_flee");
  maps\karma_civilians::assign_civ_drone_spawners_by_type(a_str_types, "club_right_flee");
  maps\karma_civilians::assign_civ_drone_spawners_by_type(a_str_types, "club_rear_flee");
  maps\karma_civilians::assign_civ_drone_spawners_by_type(a_str_types, "dance_floor_flee");
  level.drone_run_rate = 100;
  level.drones.trace_height = 100;
  maps\karma_anim::setup_drone_run_anims();
  drones_setup_unique_anims("club_left_flee", level.drone_cycle_override);
  drones_setup_unique_anims("club_right_flee", level.drone_cycle_override);
  drones_setup_unique_anims("club_rear_flee", level.drone_cycle_override);
  drones_setup_unique_anims("dance_floor_flee", level.drone_cycle_override);

  if(!flag("stop_club_fx")) {
    flag_wait("club_left_flee");
    level thread maps\_drones::drones_start("club_left_flee");
    flag_wait("club_right_flee");
    level thread maps\_drones::drones_start("club_right_flee");
    flag_wait("club_rear_flee");
    wait 1.0;
    level thread maps\_drones::drones_start("club_rear_flee");
  }

  flag_wait("start_bar_fight");
  level thread dead_civs();
  level thread maps\_drones::drones_start("dance_floor_flee");
}

start_crowd_flee(m_player_body) {
  flag_set("run_to_bar");
  level thread fire_at_bar();
  level thread player_physpulses_start("bar_physpulses1", 5.0);
  level thread run_scene_and_delete("club_encounter_hostage_flee");
}

bullet_time() {
  flag_set("heroes_open_fire");
  level thread player_physpulses_start("bar_physpulses2");
  wait 0.5;
  thread timescale_tween(1.0, 0.2, 1);
  wait 0.6;
  radiusdamage((1634, -6797, -2719), 10, 50, 50);
  flag_set("club_stop_timescale");
  wait 0.25;
  radiusdamage((1602, -6828, -2719), 10, 100, 100);
  wait 0.5;
  timescale_tween(0.2, 1.0, 1.0, 0.0, 0.05);
  wait 0.5;
  level.player disableweapons();
}

shoot_dj(ai_defalco) {
  ai_defalco fire_round(level.ai_dj);
  playfxontag(level._effect["execution_blood"], level.ai_dj, "J_Head");
  clientnotify("scm2");
  flag_set("stop_club_fx");
  exploder(628);
}

shoot_hostage(ai_defalco) {
  m_hostage = get_model_or_models_from_scene("club_encounter", "female_hostage1");
  ai_defalco shoot();
  playfxontag(level._effect["execution_blood"], m_hostage, "J_Head");
}

shoot_pmc1(ai_harper) {
  ai_harper fire_round(level.ai_harper.a_ai_targets[0]);
}

shoot_pmc2(ai_harper) {
  ai_harper fire_round(level.ai_harper.a_ai_targets[1]);
}

shoot_pmc3(ai_harper) {
  ai_harper fire_round(level.ai_harper.a_ai_targets[2]);
}

fire_round(ai_target) {
  v_origin = self gettagorigin("TAG_FLASH");

  if(isDefined(ai_target)) {
    if(isai(ai_target))
      ai_target.a.nodeath = 1;

    v_dest = ai_target gettagorigin("J_Head");
    magicbullet("fiveseven_sp", v_origin, v_dest, self);
  } else
    self shoot();
}

killed_by_harper(ai_guy) {
  if(isalive(ai_guy)) {
    if(isDefined(level.ai_harper.a_ai_targets) && isDefined(level.ai_harper.a_ai_targets[0]) && level.ai_harper.a_ai_targets[0] == ai_guy)
      flag_set("club_stop_timescale");

    ai_guy.a.nodeath = 1;
    scene_wait("bar_fight_pmcs");

    if(isDefined(ai_guy))
      ai_guy animscripts\utility::become_corpse();
  }
}

dj_killed(ai_callback) {
  playfxontag(level._effect["blood_spurt"], ai_callback, "J_Head");
}

fire_at_bar() {
  a_s_shooters = getstructarray("shooter_squib", "targetname");
  a_s_bar_targets = getstructarray("bar_squib", "targetname");
  n_timeout = gettime() + 6500;

  while(gettime() < n_timeout) {
    s_origin = random(a_s_shooters);
    s_end = random(a_s_bar_targets);
    v_start = s_origin.origin;
    v_random = (randomfloatrange(-1.0, 1.0), 0, randomfloatrange(-1.0, 1.0));
    v_end = s_end.origin + v_random * 16;
    v_direction = vectornormalize(v_end - v_start);
    playfx(level._effect["club_tracers"], v_start, v_direction);
    magicbullet("hk416_silencer_sp", v_start, v_end);
    radiusdamage(v_end, 5, 100, 100);
    wait(randomfloatrange(0.02, 0.17));
  }
}

ready_explosions(b_run_immediate) {
  if(!isDefined(b_run_immediate) || !b_run_immediate)
    self waittill("trigger");

  s_squib = getstruct(self.target, "targetname");

  if(!isDefined(s_squib))
    s_squib = getnode(self.target, "targetname");

  while(isDefined(s_squib)) {
    playsoundatposition("dst_club_lights", s_squib.origin);
    physicsexplosioncylinder(s_squib.origin, 50, 10, 1.5);
    radiusdamage(s_squib.origin, 20, 500, 500, level.ai_harper);
    wait 0.3;

    if(isDefined(s_squib.target))
      s_squib = getstruct(s_squib.target, "targetname");
    else
      break;
  }
}

ai_scared_think() {
  self endon("death");
  self.goalradius = 16;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self add_cleanup_ent("club");
  self gun_remove();
}

ai_evacuee_think() {
  self endon("death");
  self.goalradius = 8;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self add_cleanup_ent("club");
  self gun_remove();
  nd_exit_club = getnode("club_exit_node_01", "targetname");
  self setgoalnode(nd_exit_club);
  flag_wait("club_shoot_target_down");
  self delete();
}

club_actor_think() {
  self endon("death");
  self.goalradius = 8;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self add_cleanup_ent("club");
  self gun_remove();
}

clear_background_civilians() {
  wait 1.0;
  level maps\karma_civilians::delete_civs("club_rear", "script_noteworthy");
  delete_exploder(621);
  delete_exploder(624);
  wait 0.05;
  level maps\karma_civilians::delete_civs("club_left", "script_noteworthy");
  delete_exploder(622);
  delete_exploder(625);
  wait 0.05;
  end_scene("club_encounter_dancers1_loop");
  end_scene("bar_e");
  wait 0.1;
  end_scene("bar_c");
  wait 0.1;
  end_scene("bar_a_girl2");
  end_scene("bar_a_guy1");
  end_scene("bar_b_guy1");
  end_scene("bar_d_girl1");
  end_scene("bar_d_guy2");
  end_scene("bar_f_girl1");
  end_scene("bar_f_guy1");
  end_scene("bar_f_guy2");
  end_scene("bar_g_girl1");
  wait 0.1;
  level maps\karma_civilians::delete_civs("static_club_approaching");
  wait 0.05;
  level maps\karma_civilians::delete_civs("static_club_approaching_couples");
  level thread clear_static_flee_civs();
}

clear_static_flee_civs() {
  flag_wait("club_left_flee");
  flag_wait("club_right_flee");
  a_m_groups = getentarray("m_civ_club_group1", "targetname");
  array_delete(a_m_groups);
  wait 0.05;
  delete_exploder(623);
  delete_exploder(626);
  wait 0.05;
  level thread maps\karma_civilians::spawn_static_civs("static_civ_flee");
  level thread maps\karma_civilians::delete_civs("club_right", "script_noteworthy");
  scene_wait("club_encounter_player");
  level thread maps\karma_civilians::delete_civs("static_civ_flee", "targetname");
}

club_enemies_think() {
  self.ignoreall = 1;
  self.ignoreme = 1;
}

civs_scream() {
  if(!flag("club_civs_scream")) {
    flag_set("club_civs_scream");
    clientnotify("ccs");
  }
}

dead_civs() {
  maps\karma_anim::club_bodies_anims();
  level thread run_scene_and_delete("civ_body1");
  level thread run_scene_and_delete("civ_body2");
  level thread run_scene_and_delete("civ_body3");
  level thread run_scene_and_delete("civ_body4");
  level thread run_scene_and_delete("civ_body5");
  level thread run_scene_and_delete("civ_body6");
  level thread run_scene_and_delete("civ_body7");
}

club_terrorist_think() {
  self endon("death");
  self endon("club_terrorists_alerted");

  if(isDefined(self.animname)) {
    switch (self.animname) {
      case "club_pmc1":
        self gun_switchto("saiga12_sp", "right");
        break;
      case "club_pmc4":
      case "club_pmc5":
      case "club_pmc6":
      case "club_pmc7":
      case "club_pmc8":
      case "club_pmc9":
      case "player_target1":
      case "salazar_target1":
        self set_deathanim("death");
        break;
    }
  }

  self disable_long_death();

  if(!flag("club_open_fire")) {
    self.goalradius = 8;
    self.script_radius = 8;
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.fixednode = 1;
    self change_movemode("cqb_walk");
    flag_wait("heroes_open_fire");
    self.allowdeath = 1;
    self setcandamage(1);
    flag_wait("club_open_fire");
  }

  self.ignoreall = 0;
  self.ignoreme = 0;
}

mark_as_target(str_wait_flag) {
  self endon("death");

  if(isDefined(str_wait_flag))
    flag_wait(str_wait_flag);

  b_seen = 0;

  while(!b_seen) {
    if(self cansee(level.ai_salazar) || self cansee(level.player))
      b_seen = 1;

    wait(randomfloatrange(0.5, 1.0));
  }

  target_set(self);
}

unmark_target() {
  self waittill("death");
  removeargus(self.n_argus_id);
}

grenade_toss() {
  self endon("death");
  self endon("damage");
  self.goalradius = 8;
  self setgoalpos(self.origin);
  wait 6;
  n_goal = getnode(self.target, "targetname");
  self force_goal(n_goal, 8);

  if(level.player istouching(getent("trig_floor_bar", "targetname"))) {
    v_start_pos = self.origin + vectorscale((0, 0, 1), 48.0);
    s_end_pos = getstruct("grenade_target", "targetname");

    if(isalive(self))
      self magicgrenade(v_start_pos, s_end_pos.origin, 7);
  }
}

ai_shoot_wildly() {
  self endon("death");
  a_fake_targets = getentarray("enemy_fake_targets", "targetname");
  e_fake = a_fake_targets[randomint(a_fake_targets.size)];
  self thread shoot_at_target(e_fake, undefined, 0, 10);
  wait 8;

  if(!flag("club_melee_started"))
    flag_set("club_terrorists_alerted");
}

harper_think() {
  self.goalradius = 8;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self gun_switchto("fiveseven_sp", "right");
}

get_ai_targets(str_target_group) {
  i = 1;
  b_target_found = 1;
  a_ai_array = getaiarray("axis");
  self.a_ai_targets = [];

  while(b_target_found) {
    b_target_found = 0;

    foreach(ai_guy in a_ai_array) {
      if(isDefined(ai_guy.script_noteworthy) && ai_guy.script_noteworthy == str_target_group + i) {
        self.a_ai_targets[self.a_ai_targets.size] = ai_guy;
        b_target_found = 1;
        break;
      }
    }

    i++;
  }
}

kill_ai_target(ai_target, n_traverse_time, n_aim_time, n_shoot_time) {
  if(!isDefined(n_traverse_time))
    n_traverse_time = 0.5;

  if(!isDefined(n_aim_time))
    n_aim_time = 1.0;

  if(!isDefined(n_shoot_time))
    n_shoot_time = 0.05;

  self endon("death");

  if(!isalive(ai_target)) {
    return;
  }
  ai_target endon("death");
  arrayremovevalue(level.a_ai_club_terrorists, ai_target);
  self thread shoot_at_target(ai_target, "J_head", n_traverse_time + n_aim_time, n_shoot_time);
  wait(n_traverse_time + n_aim_time + n_shoot_time);

  if(isalive(ai_target)) {
    v_aim_point = ai_target gettagorigin("J_head");
    magicbullet(self.weapon, self gettagorigin("tag_flash"), v_aim_point, self);
    wait 0.1;

    if(isalive(ai_target))
      ai_target kill();
  }
}

player_bar_fight() {
  level.player thread vision_set_change("sp_karma_ClubMainFight");
  init_club_battle_damage_timing();
  level.player.overrideplayerdamage = ::player_damage_override;
  level.player thread player_infinite_ammo();
  level.disable_damage_blur = 1;
  wait 2.0;
  getent("t_explosions1", "targetname") thread ready_explosions();
  getent("t_explosions2", "targetname") thread ready_explosions();
  getent("t_explosions3", "targetname") thread ready_explosions();
  getent("t_explosions4", "targetname") thread ready_explosions();
  level thread bar_fight_spawn_cover_guys();
  wait 3.5;
  simple_spawn("club_terrorist_floor", ::club_terrorist_think);
  wait 1.0;
  level.player enableinvulnerability();
  level.player takeallweapons();
  level.player giveweapon("kard_reflex_nofirstraise_sp");
  level.player showviewmodel();
  level.player allowads(1);
  setsaveddvar("cg_drawCrosshair", 1);
  level.player enableweapons();
  level.player allowstand(1);
  level.player setstance("stand");
  flag_set("player_act_normally");
  flag_set("club_open_fire");
  level thread bullet_time();
  scene_wait("bar_fight_player");
  thread autosave_now("club_fight");
  level.ai_harper gun_switchto("fiveseven_silencer_sp", "right");
  delay_thread(0.5, ::player_disable_invulnerability);
  trigger_use("t_explosions3", "targetname");
  run_scene_and_delete("bar_fight_slowmo1");
  level.ai_harper bloodimpact("none");
  level.ai_harper thread say_dialog("harp_flank_left_0");
  level.player disableweapons();
  level.ai_harper gun_switchto("hk416_silencer_sp", "right");
  level.player thread say_dialog("sect_shoot_and_scoot_0", 3.5);
  run_scene_first_frame("bar_fight_movement1_player");
  flag_set("bar_fight_spawn_wave");
  level.player thread player_enable_invulnerability();
  level thread run_scene_and_delete("bar_fight_movement1_player");
  level thread player_whizbys_start(undefined, 3.0);
  level thread player_dynents_start("player_dynents1", undefined, 2.5);
  level thread player_physpulses_start("player_physpulses1", 4.75);
  run_scene_and_delete("bar_fight_movement1_harper");
  scene_wait("bar_fight_movement1_player");
  delay_thread(0.6, ::player_disable_invulnerability);
  level.player thread player_cover_fire_start("harp_at_your_9_0", 0.9, 0.5);
  run_scene_and_delete("bar_fight_slowmo2");
  level.player thread say_dialog("sect_covering_0", 3.5);
  flag_set("bar_fight_spawn_wave");
  delay_thread(1.0, ::trigger_use, "t_explosions1", "targetname");
  level.player thread player_enable_invulnerability();
  run_scene_and_delete("bar_fight_movement2");
  delay_thread(0.6, ::player_disable_invulnerability);
  level thread player_physpulses_start("player_physpulses2", 1.0);
  level.player thread player_cover_fire_start("harp_move_move_0", 0.9, 0.5, 1, 2);
  run_scene_and_delete("bar_fight_slowmo3");
  flag_set("bar_fight_spawn_wave");
  trigger_use("t_explosions2", "targetname");
  level.player thread player_enable_invulnerability();
  run_scene_and_delete("bar_fight_movement3");
  delay_thread(0.6, ::player_disable_invulnerability);
  trigger_use("t_explosions4", "targetname");
  level.player thread player_cover_fire_start(undefined, 0.9, 0.5, 0);
  run_scene_and_delete("bar_fight_slowmo4");
  level.player.overrideplayerdamage = undefined;

  foreach(ai_guy in getaiarray("axis")) {
    if(isalive(ai_guy)) {
      ai_guy notify("club_fight_end");
      ai_guy.script_accuracy = 0.0;
    }
  }

  luinotifyevent(&"hud_expand_ammo");
  level thread final_grenade();
}

player_enable_invulnerability() {
  if(!isDefined(level.player.fired))
    level.player dodamage(1000, level.player.origin, level.player);
  else {
    level.player.fired = undefined;
    level.player enableinvulnerability();
  }
}

player_disable_invulnerability() {
  level.player disableinvulnerability();
  level.player thread player_watch_for_shot();
}

player_watch_for_shot() {
  self notify("watch_for_shot");
  self endon("watch_for_shot");
  self waittill("weapon_fired");
  self.fired = 1;
}

player_cover_fire_start(str_move_dialog, n_timescale_length, n_timescale_blend_out_time, do_disable_weapons, n_target_kills) {
  if(!isDefined(do_disable_weapons))
    do_disable_weapons = 1;

  if(!isDefined(n_target_kills))
    n_target_kills = 3;

  self thread player_cover_fire_kills_think(n_target_kills);
  timescale_tween(1.0, 0.2, 1.0);
  level.player enableweapons();
  waittill_any_or_timeout(n_timescale_length / 5, "cover_fire_stop");
  self notify("cover_fire_timeout");
  timescale_tween(0.2, 1.0, 0.5);

  if(isDefined(str_move_dialog))
    level.ai_harper thread say_dialog(str_move_dialog);

  wait(n_timescale_blend_out_time);

  if(do_disable_weapons)
    level.player disableweapons();
}

player_cover_fire_kills_think(n_target_kills) {
  self endon("cover_fire_timeout");

  for(n_total_kills = 0; n_total_kills < n_target_kills; n_total_kills++)
    self waittill("player_killed_enemy");

  self notify("cover_fire_stop");
}

final_grenade() {
  level.ai_harper magicgrenade(getstruct("club_fight_magic_grenade_start", "targetname").origin, getstruct("club_fight_magic_grenade_end", "targetname").origin, 1.5);
}

player_infinite_ammo() {
  while(!flag("bar_fight_movement3_done")) {
    foreach(str_weapon in self getweaponslist())
    self setweaponammoclip(str_weapon, weaponclipsize(str_weapon));

    wait 0.05;
  }
}

player_reload(ent) {
  foreach(str_weapon in level.player getweaponslist())
  level.player setweaponammoclip(str_weapon, 0);
}

lights_drop() {
  level notify("fxanim_club_laser_2_fall_start");
  wait 1.0;
  level notify("fxanim_club_laser_1_fall_start");
  wait 2.0;
  level notify("fxanim_club_laser_4_fall_start");
}

club_cleanup() {
  cleanup_ents("club");
}

karma_2_transition() {
  flag_wait("exit_club");
  rpc("clientscripts/_audio", "cmnLevelFadeout");
  screen_fade_out(1.0);
  level.player takeallweapons();
  level.player notify("draw_weapons");
  wait 0.5;
  nextmission();
}

inner_club_dialog() {
  flag_wait("entered_inner_club");
  self say_dialog("sect_harper_where_are_y_0");
  self say_dialog("harp_we_re_on_the_dance_f_0", 0.25);
  self say_dialog("sect_on_my_way_0", 0.25);
  self say_dialog("sala_section_i_m_in_pos_0", 0.5);
  flag_wait("counterterrorists_win");
  self say_dialog("sect_defalco_has_karma_w_0", 1.0);
  self say_dialog("sect_we_need_you_to_track_0");
  flag_set("exit_club");
}

player_whizbys_start(n_delay, n_time) {
  if(isDefined(n_delay))
    wait(n_delay);

  foreach(s_start in getstructarray("player_whizbys1", "targetname"))
  s_start thread player_whizby_think(n_time);
}

player_whizby_think(n_time) {
  self endon("stop_whizbys");
  s_end = getstruct(self.target, "targetname");
  wait(randomfloatrange(0.0, 0.5));
  self thread notify_delay("stop_whizbys", n_time);

  while(true) {
    magicbullet("hk416_silencer_sp", self.origin, s_end.origin);
    wait(randomfloatrange(0.25, 0.5));
  }
}

player_dynents_start(str_structs, n_delay, n_time) {
  if(isDefined(n_delay))
    wait(n_delay);

  if(!isDefined(level.player.club_dynents)) {
    level.player.club_dynents[0] = "p_cub_ashtray_glass";
    level.player.club_dynents[1] = "hjk_vodka_glass_lrg";
    level.player.club_dynents[2] = "p6_bar_solar_coaster_single";
    level.player.club_dynents[3] = "p6_bar_al_jinan_napkin_single";
  }

  foreach(s_start in getstructarray(str_structs, "targetname"))
  s_start thread player_dynents_think(n_time);
}

player_dynents_think(n_time) {
  self endon("stop_dynents");
  s_end = getstruct(self.target, "targetname");
  v_force_dir = s_end.origin - self.origin;
  v_force_dir = vectornormalize(v_force_dir);
  wait(randomfloatrange(0.0, 0.5));
  self thread notify_delay("stop_dynents", n_time);

  while(true) {
    v_force_launch = v_force_dir * randomfloatrange(0.75, 1.5);
    v_force_launch = (v_force_launch[0], v_force_launch[1], v_force_dir[2] * self.script_float);
    n_dynents_index = randomintrange(0, 3);
    createdynentandlaunch(level.player.club_dynents[n_dynents_index], self.origin, random_vector(360), self.origin, v_force_launch);
    wait(randomfloatrange(0.5, 1.5));
  }
}

player_physpulses_start(str_struct, n_delay) {
  if(isDefined(n_delay))
    wait(n_delay);

  foreach(s_struct in getstructarray(str_struct, "targetname"))
  s_struct thread player_physents_think();
}

player_physents_think() {
  if(isDefined(self.script_float))
    wait(self.script_float);

  if(isDefined(self.script_string) && self.script_string == "makeinvulnerable") {
    level.player enableinvulnerability();
    wait 0.05;
  }

  radiusdamage(self.origin, self.script_int, 100, 75, level.ai_harper);

  if(isDefined(self.script_string) && self.script_string == "makeinvulnerable") {
    wait 0.05;
    level.player disableinvulnerability();
  }
}

init_club_battle_damage_timing() {
  switch (getdifficulty()) {
    default:
      level.club_battle_damage_timeout = 500;
      break;
  }
}

player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(isDefined(eattacker.script_noteworthy) && eattacker.script_noteworthy == "nodamage") {
    level.player cleardamageindicator();
    return 0;
  }

  if(!isDefined(level.club_battle_damage_time))
    level.club_battle_damage_time = gettime();

  if(gettime() - level.club_battle_damage_time >= level.club_battle_damage_timeout) {
    if(level.player.health <= 5) {
      level thread screen_fade_out(0);
      missionfailedwrapper();
    }

    level.club_battle_damage_time = gettime();

    if(level.player attack_button_pressed())
      return 0;

    if(level.player is_ads())
      idamage = int(idamage / 2);

    n_diff_scale = 1;

    switch (getdifficulty()) {
      case "easy":
        n_diff_scale = 2.2;
        break;
      case "medium":
        n_diff_scale = 2;
        break;
      case "hard":
        n_diff_scale = 2.1;
        break;
      case "fu":
        n_diff_scale = 2.2;
        break;
    }

    idamage = int(idamage * n_diff_scale);
    return idamage;
  } else {
    level.player cleardamageindicator();
    return 0;
  }
}

adjust_accuracy_for_difficulty() {
  self endon("death");
  self endon("club_fight_end");

  while(true) {
    self.script_accuracy = 9001.0;
    level.player waittill_attack_button_pressed();
    self.script_accuracy = 5.0;

    while(level.player attack_button_held())
      wait 0.05;

    wait 0.25;
  }
}