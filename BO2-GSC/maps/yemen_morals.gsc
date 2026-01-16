/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_morals.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\yemen_utility;
#include maps\_vehicle;
#include maps\_anim;
#include maps\_dialog;
#include maps\_music;
#include maps\_audio;
#include maps\yemen_anim;
#include maps\yemen_amb;
#include maps\_quadrotor;
#include maps\yemen_metal_storms;

init_flags() {
  flag_init("morals_start");
  flag_init("harper_shot");
  flag_init("menendez_shot");
  flag_init("moral_2_animation_loading");
  flag_init("morals_scene_complete");
}

init_spawn_funcs() {
}

switch_head() {
  level.ai_harper = self;

  if(level.player get_story_stat("HARPER_SCARRED")) {
    self detach("c_usa_cia_combat_harper_head");
    self attach("c_usa_cia_combat_harper_head_scar");
  }
}

switch_head_terrorist_4() {
  level.ai_terrorist_4 = self;
  self setmodel("c_mul_cordis_body2_3");

  if(isDefined(self.headmodel)) {
    model = self.headmodel;
    self detach(model);
  }

  self attach("c_mul_cordis_head4_3");
}

switch_head_terrorist_5() {
  level.ai_terrorist_5 = self;
  self setmodel("c_mul_cordis_body1_4");

  if(isDefined(self.headmodel)) {
    model = self.headmodel;
    self detach(model);
  }

  self attach("c_mul_cordis_head1_2");
}

skipto_morals() {
  load_gump("yemen_gump_morals");
  level.is_defalco_alive = 1;
  skipto_teleport("skipto_morals_player");
  exploder(30);
}

main() {
  iprintln("Morals");

  flag_set("morals_start");
  exploder(2000);
  harper_spawner = getent("harper_morals", "targetname");
  harper_spawner add_spawn_function(::switch_head);
  terrorist_spawner_4 = getent("terrorist_morals_04", "targetname");
  terrorist_spawner_4 add_spawn_function(::switch_head_terrorist_4);
  terrorist_spawner_5 = getent("terrorist_morals_05", "targetname");
  terrorist_spawner_5 add_spawn_function(::switch_head_terrorist_5);
  level thread end_market_vo();
  level clientnotify("yemen_disable_sonar");
  level thread clean_up_behind();
  level thread morals_setup();
  trigger_wait("morals_at_menendez");
  level thread maps\_audio::switch_music_wait("YEMEN_SURPRISE_MENENDEZ", 0.5);
  level thread battlechatter_off();
  stop_exploder(3);
  stop_exploder(20);
  exploder(30);
  level clientnotify("morals");
  level thread setup_capture_drones();
  level thread morals_intro_ambient();
  level thread vo_morals_shoot_vtol();
  level.player thread morals_disable_camo_suit();
  shoot_down_vtol();
  vtol_approach();
  morals_choice_outcome();
  morals_mason_intro();
  flag_set("morals_scene_complete");
  morals_clean_up();
  stop_exploder(1026);
}

morals_disable_camo_suit() {
  assert(isplayer(self));
  self endon("death");

  if(level.player ent_flag_exist("camo_suit_on") && level.player ent_flag("camo_suit_on"))
    level.player ent_flag_clear("camo_suit_on");

  weapon_list = self getweaponslist();
  camo_weapon = "camo_suit_sp";
  has_camo = 0;

  foreach(weapon in weapon_list) {
    if(weapon == camo_weapon) {
      self takeweapon(weapon);
      has_camo = 1;
      break;
    }
  }

  if(has_camo == 1) {
    flag_wait("morals_scene_complete");

    if(!level.is_farid_alive)
      flag_wait("mason_intro_harper_lives_done");

    wait 0.1;
    self giveweapon(camo_weapon);
  }
}

clean_up_behind() {
  cleanup("metal_storms_wounded", "script_noteworthy");
}

morals_setup() {
  maps\yemen_anim::morals_anims();
  level.hammer_audio_limiter = 0;
  level thread maps\yemen_amb::yemen_drone_control_tones(0);
  vehicle_add_main_callback("heli_quadrotor", maps\_quadrotor::quadrotor_think);
  maps\yemen_metal_storms::metal_storms_cleanup();
  morals_vtol_setup();
  level thread fake_combat_sounds();
}

morals_intro_ambient() {
  vh_vtol = getent("morals_vtol_1", "targetname");
  a_sp_terrorists = getentarray("pre_morals_terrorist", "targetname");
  moral_terrorist_group = [];

  foreach(spawner in a_sp_terrorists) {
    guy = simple_spawn_single(spawner, maps\yemen_utility::terrorist_teamswitch_spawnfunc);
    guy thread target_vtol_with_gun();
    guy magic_bullet_shield();
    guy set_ignoreall(1);
    guy set_goalradius(64);
    moral_terrorist_group[moral_terrorist_group.size] = guy;
  }

  wait 23;
  ar_goal_nodes = getnodearray("morals_shoot_vtol_goto_nodes", "targetname");

  foreach(terr in moral_terrorist_group) {
    terr set_goalradius(100);
    ar_goal_nodes = get_array_of_closest(terr.origin, ar_goal_nodes);
    farthest_node = ar_goal_nodes[ar_goal_nodes.size - 1];

    if(isDefined(farthest_node)) {
      terr thread set_goal_node(farthest_node);
      ar_goal_nodes = array_remove(farthest_node, ar_goal_nodes);
      wait(randomfloatrange(0.05, 0.5));
    }
  }
}

target_vtol_with_gun() {
  self endon("death");
  vh_vtol = getent("morals_vtol_1", "targetname");
  wait 2;
  self thread shoot_at_target(vh_vtol, undefined, randomfloatrange(0.5, 2), -1);
}

morals_clean_up() {
  level.player setlowready(0);
  switch_player_to_mason();
  level.player disableinvulnerability();
  level.friendlyfiredisabled = 0;
  setsaveddvar("aim_target_ignore_team_checking", 0);
  level thread battlechatter_on();

  if(flag("harper_shot")) {
    delete_scene("morals_shoot_menendez", 1);
    delete_scene("morals_shoot_menendez_defalco", 1);

    if(!isDefined(level.is_defalco_alive) || level.is_defalco_alive == 0) {
      end_scene("morals_shoot_harper_defalco");
      delete_scene("morals_shoot_harper_defalco", 1);
    }
  } else if(flag("menendez_shot")) {
    delete_scene("morals_outcome_farid_lives", 1);
    delete_scene("morals_shoot_harper", 1);
    delete_scene("morals_shoot_harper_defalco", 1);

    if(!isDefined(level.is_defalco_alive) || level.is_defalco_alive == 0) {
      end_scene("morals_shoot_menendez_defalco");
      delete_scene("morals_shoot_menendez_defalco", 1);
    }
  }
}

set_blend_in_out_times(time) {
  self anim_set_blend_in_time(time);
  self anim_set_blend_out_time(time);
}

morals_vtol_setup() {
  vh_vtol = spawn_vehicle_from_targetname("morals_vtol_1");
  vh_vtol veh_magic_bullet_shield(1);
}

morals_ambient_qrotor_delete() {
}

shoot_down_vtol() {
  level.player enableinvulnerability();
  level.player_interactive_model = "c_mul_yemen_farid_viewbody_bloody";
  level thread run_scene_first_frame("morals_shoot_vtol_gump_transition");
  level thread run_scene_first_frame("morals_vtol_crashing");
  level thread run_scene_first_frame("morals_shoot_vtol");
  level thread run_scene_first_frame("morals_shoot_vtol_player");
  m_player_body = get_model_or_models_from_scene("morals_shoot_vtol_player", "player_body");
  m_player_body set_blend_in_out_times(0.25);
  gun = get_model_or_models_from_scene("morals_shoot_vtol_gump_transition", "fhj_morals");
  gun set_blend_in_out_times(0.25);
  ai_menendez = get_ai("menendez_morals_ai", "targetname");
  ai_menendez set_blend_in_out_times(0.25);
  level thread camera_tween();
  level thread camera_restraint_for_pop();
  level thread morals_arms_fov_in();
  level thread run_scene_and_delete("morals_mene_door");
  level thread run_scene("morals_shoot_vtol");
  level thread run_scene_and_delete("morals_shoot_vtol_gump_transition");
  level thread run_scene_and_delete("morals_shoot_vtol_player");
  exploder(1027);
  wait 0.1;
  level thread morals_arm_light_fx();
  ai_menendez gun_switchto("fhj18_sp", "right");
  ai_menendez set_ignoreme(1);
  ai_menendez.team = "allies";
  wait 1;
  m_player_body = get_model_or_models_from_scene("morals_shoot_vtol_player", "player_body");
  m_player_body setforcenocull();
  scene_wait("morals_shoot_vtol_gump_transition");
  morals_arms_fov_out();
  level thread maps\_audio::switch_music_wait("YEMEN_HARPER_DECISION", 0.5);
}

camera_restraint_for_pop() {
  wait 34;
  body = get_model_or_models_from_scene("morals_shoot_vtol_player", "player_body");
  player_camera_restrain_smooth(body, 15, 10, 10, 0);
  wait 3;
  level.player playerlinktodelta(body, "tag_player", 1, 15, 15, 15, 15);
}

#using_animtree("player");

camera_tween() {
  wait(getanimlength( % p_yemen_05_01_shoot_vtol_player) - 0.25);
  level.player startcameratween(0.5);
}

morals_arm_light_fx() {
  player_model = get_model_or_models_from_scene("morals_shoot_vtol_player", "player_body");
  ent_origin = spawn_model("tag_origin", player_model gettagorigin("J_Wrist_RI"), player_model gettagangles("J_Wrist_RI"));
  ent_origin linkto(player_model, "J_Wrist_RI");
  playfxontag(getfx("morals_arm_light"), ent_origin, "tag_origin");
  wait 14;
  ent_origin delete();
}

morals_shoot_vtol_fire_rocket(ai_guy) {
  playsoundatposition("wpn_rpg_fire_plr", (0, 0, 0));
  m_fhj = getent("fhj_morals", "targetname");
  vh_vtol = getent("morals_vtol_1", "targetname");
  m_rocket = spawn_model("projectile_at4", m_fhj.origin, m_fhj.angles);
  playfxontag(getfx("morals_fhj_rocket_trail"), m_rocket, "tag_fx");
  m_rocket moveto(vh_vtol.origin - vectorscale((0, 0, 1), 112.0), 0.5);
  m_rocket waittill("movedone");
  m_rocket delete();
  level.player playrumbleonentity("artillery_rumble");
  level notify("fxanim_vtol2_crash_start");
  wait 0.2;
  turn_off_vehicle_exhaust(vh_vtol);
  turn_off_vehicle_tread_fx(vh_vtol);
  vh_vtol vehicle_toggle_sounds(0);
  playfxontag(level._effect["moral_vtol_explosion"], vh_vtol, "tag_origin");
  playfxontag(level._effect["fx_vtol_engine_burn1"], vh_vtol, "tag_fx_engine_right1");
  playfxontag(level._effect["fx_yemen_vtol_smoke"], vh_vtol, "tag_origin");
}

morals_shoot_vtol_camera_in(unused_param) {
  body = get_model_or_models_from_scene("morals_shoot_vtol_player", "player_body");
  player_camera_restrain_smooth(body, 15, 10, 10, 0);
}

morals_shoot_vtol_camera_out(unused_param) {
  body = get_model_or_models_from_scene("morals_capture_approach_player", "player_body");
  level.player playerlinktodelta(body, "tag_player", 1, 15, 15, 15, 15);
}

moral_vtol_crash_anim(guy) {
  vh_vtol = getent("morals_vtol_1", "targetname");
  level thread run_scene_and_delete("morals_vtol_crashing");
  playsoundatposition("fxa_vtol2_crash", (0, 0, 0));
  thread fx_morals_vtol_crash();
  scene_wait("morals_vtol_crashing");
  wait 2;
  stop_exploder(1027);
  exploder(1026);
  level thread run_scene_first_frame("morals_vtol_dead");
  vh_vtol setmodel("veh_t6_air_v78_vtol_burned");
  level end_scene("morals_shoot_vtol");
  level delete_scene("morals_shoot_vtol");
  level thread load_gump_in_two();
  running_terrorist = getentarray("yemen_terrorist_running_moral", "targetname");

  for(i = 0; i < running_terrorist.size; i++)
    running_terrorist[i] delete();
}

fx_morals_vtol_crash() {
  wait 6;
  clientnotify("vtol_snap");
  exploder(2100);
  wait 4;
  stop_exploder(2000);
  level.player playrumbleonentity("artillery_rumble");
}

vtol_approach() {
  level thread vtol_approach_ambient_guys();
  ai_menendez = get_ai("menendez_morals_ai", "targetname");
  ai_menendez gun_switchto("judge_sp", "right");

  if(level.is_defalco_alive == 1)
    level thread run_scene_and_delete("morals_capture_approach_defalco");

  level thread morals_capture_approach_handle_player_anim();
  run_scene_and_delete("morals_capture_approach");

  if(level.is_defalco_alive == 1)
    level thread run_scene_and_delete("morals_capture_defalco");

  level thread run_scene_and_delete("morals_capture");
  ai_menendez gun_switchto("judge_sp", "right");
  ai_harper = get_ais_from_scene("morals_capture", "harper_morals");
  level waittill_either("harper_shot", "menendez_shot");
  ai_harper stopsounds();
  ai_in_scene = get_ais_from_scene("morals_capture");

  if(isDefined(ai_in_scene)) {
    foreach(ai_dude in ai_in_scene)
    ai_dude magic_bullet_shield();
  }

  if(level.is_defalco_alive == 1) {
    ai_in_scene1 = get_ais_from_scene("morals_capture_defalco");

    if(isDefined(ai_in_scene1)) {
      foreach(ai_dude1 in ai_in_scene1)
      ai_dude1 magic_bullet_shield();
    }
  }

  screen_message_delete();
}

morals_streamer_hint_off(m_player_body) {
  if(isDefined(level.e_streamer_hint))
    level.e_streamer_hint delete();
}

morals_streamer_hint_on(m_player_body) {
  level.e_streamer_hint = createstreamerhint((-5552, -4605, 174), 0.5);
}

morals_capture_approach_handle_player_anim() {
  scene_wait("morals_shoot_vtol_player");
  run_scene_and_delete("morals_capture_approach_player");
}

load_gump_in_two() {
  load_gump("yemen_gump_morals_rail");
  flag_set("moral_2_animation_loading");
  wait 0.1;
  run_scene_and_delete("moral_execute_pilots_in");
  run_scene_and_delete("moral_execute_pilots_kill");
}

setup_capture_drones() {
  crowd_models_close = array("c_mul_cordis_body3_1", "c_mul_cordis_body1_2", "c_mul_cordis_body1_3", "c_mul_cordis_body1_4", "c_mul_cordis_body2_1", "c_mul_cordis_body2_2", "c_mul_cordis_body2_3", "c_mul_cordis_body2_4");
  crowd_models_close_head = array("c_mul_cordis_head1_1", "c_mul_cordis_head1_2", "c_mul_cordis_head1_3", "c_mul_cordis_head1_4", "c_mul_cordis_head1_5", "c_mul_cordis_head2_1", "c_mul_cordis_head3_1", "c_mul_cordis_head4_1", "c_mul_cordis_head4_2", "c_mul_cordis_head4_3", "c_mul_cordis_head4_4", "c_mul_cordis_head4_5");

  for(i = 0; i < 15; i++) {
    if(i == 10) {
      continue;
    }
    m_drone = spawn("script_model", (0, 0, 0));
    m_drone.angles = (0, 0, 0);
    m_drone setmodel(random(crowd_models_close));
    m_drone attach(random(crowd_models_close_head), "");
    m_drone attach("t6_wpn_ar_an94_world", "tag_weapon_right");
    m_drone.animname = "terrorist_" + (i + 1) + "_moral";
  }

  for(i = 0; i < 3; i++) {
    m_drone = spawn("script_model", (0, 0, 0));
    m_drone.angles = (0, 0, 0);
    m_drone setmodel(random(crowd_models_close));
    m_drone attach(random(crowd_models_close_head), "");
    m_drone attach("t6_wpn_ar_an94_world", "tag_weapon_right");
    m_drone.animname = "terrorist_" + (i + 1) + "_capture";
  }
}

vtol_approach_ambient_guys() {
  a_ai_morals_shooters = get_ai_array("pre_morals_terrorist_ai", "targetname");
  array_delete(a_ai_morals_shooters);
  a_ai_morals_runners = get_ai_array("pre_morals_terrorist_runover_ai", "targetname");
  array_delete(a_ai_morals_runners);
  a_sp_morals_shooters = get_ent_array("pre_morals_terrorist", "targetname");
  array_delete(a_sp_morals_shooters);
  a_qrotors = getentarray("morals_qrotor", "targetname");
  array_thread(a_qrotors, ::qrotor_delete);
}

qrotor_delete() {
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

morals_capture_punch(harper) {
  playfxontag(level._effect["morals_punch"], harper, "j_head");
}

morals_capture_start_choice(player) {
  level endon("menendez_shot");
  level endon("harper_shot");
  screen_message_create(&"YEMEN_SHOOT_HARPER", & "YEMEN_SHOOT_MENENDEZ", undefined, -80);
  wait 0.5;
  level.player thread watch_shoot_harper();
  level.player thread watch_shoot_menendez();
  scene_wait("morals_capture");
  flag_set("menendez_shot");
}

watch_shoot_harper() {
  level endon("morals_rail_start");
  level endon("menendez_shot");

  while(self usebuttonpressed())
    wait 0.05;

  while(!self usebuttonpressed())
    wait 0.05;

  flag_set("harper_shot");
  setmusicstate("YEMEN_HARPER_HARPER_DIED");
  level notify("harper_shot_complete");
}

watch_shoot_menendez() {
  level endon("harper_shot");
  level endon("morals_rail_start");

  while(self jumpbuttonpressed())
    wait 0.05;

  while(!self jumpbuttonpressed())
    wait 0.05;

  flag_set("menendez_shot");
  setmusicstate("YEMEN_HARPER_FARID_DIED");
  level notify("menendez_shot_complete");
}

play_gun_shot_fx_rumble(b_farid_shot) {
  if(!isDefined(b_farid_shot))
    b_farid_shot = 0;

  level.player playrumbleonentity("damage_heavy");
  overlay = newclienthudelem(level.player);
  overlay.x = 0;
  overlay.y = 0;

  if(is_mature()) {
    if(b_farid_shot)
      overlay setshader("overlay_low_health_splat", 640, 480);
    else
      overlay setshader("overlay_harper_blood", 640, 480);

    overlay.splatter = 1;
  }

  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.foreground = 0;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 1;
  overlay fadeovertime(5);
  overlay.alpha = 0;
  wait 5;
  overlay destroy();
}

morals_choice_outcome() {
  if(flag("harper_shot")) {
    level.is_farid_alive = 1;
    level.player set_story_stat("HARPER_DEAD_IN_YEMEN", 1);

    if(level.is_defalco_alive == 1)
      level thread run_scene_and_delete("morals_shoot_harper_defalco");

    level thread run_scene_and_delete("morals_shoot_harper");
    wait 1.2;
    gun = get_model_or_models_from_scene("morals_shoot_harper", "morals_fn57");
    playfxontag(level._effect["muzzle_flash"], gun, "tag_fx");
    playfxontag(level._effect["harper_blood"], level.ai_harper, "j_head");
    wait 0.1;

    if(is_mature()) {
      thread play_blood_screen_fx();
      level.ai_terrorist_4 detach("c_mul_cordis_head4_3");
      level.ai_terrorist_4 attach("c_mul_cordis_head4_3_bld");
      level.ai_terrorist_5 detach("c_mul_cordis_head1_2");
      level.ai_terrorist_5 attach("c_mul_cordis_head1_2_bld");

      if(level.player get_story_stat("HARPER_SCARRED")) {
        level.ai_harper detach("c_usa_cia_combat_harper_head_scar");
        level.ai_harper attach("c_usa_cia_combat_harper_head_scar_shot");
      } else {
        level.ai_harper detach("c_usa_cia_combat_harper_head");
        level.ai_harper attach("c_usa_cia_combat_harper_head_shot");
      }
    }

    wait(getanimlength( % p_yemen_05_04_shoot_harper_player) - 2);
    screen_fade_out(0.5);
    wait 1;
    thread play_harper_blood_pool_fx();
    level notify("stop_mason_vtol_fire");
    run_scene_first_frame("morals_outcome_farid_lives");
    m_body = get_model_or_models_from_scene("morals_outcome_farid_lives", "player_body");
    m_body hide();
    morals_streamer_hint_off();
  } else {
    level.is_farid_alive = 0;
    level.player set_story_stat("FARID_DEAD_IN_YEMEN", 1);
    level thread run_scene_and_delete("morals_shoot_menendez");
    morals_streamer_hint_off();

    if(level.is_defalco_alive == 1)
      level thread run_scene_and_delete("morals_shoot_menendez_defalco");

    thread play_muzzle_flash_shoot_menendez();
    wait(getanimlength( % p_yemen_05_04_shoot_menendez_player) - 1);
    screen_fade_out(0.0);
    wait 1;
    level.player giveachievement_wrapper("SP_STORY_HARPER_LIVES");
  }

  level clientnotify("mbs");
}

play_muzzle_flash_shoot_menendez() {
  level waittill("notetrack_farid_shot");
  wait 0.05;
  level waittill("morals_shoot_menendez_fire");
  menendez = get_ais_from_scene("morals_shoot_menendez", "menendez_morals");
  playfxontag(getfx("muzzle_flash_menendez"), menendez, "tag_flash");
}

play_blood_screen_fx() {
  wait 0.05;
  level thread play_gun_shot_fx_rumble();
}

play_harper_blood_pool_fx() {
  wait 6;
  exploder(420);
}

morals_outcome_farid_shot(empty_param) {
  level.player disableinvulnerability();
  level.player dodamage(50, level.player.origin);
  level.player enableinvulnerability();
  farid_shot = 1;
  level notify("notetrack_farid_shot");

  if(is_mature())
    level thread play_gun_shot_fx_rumble(farid_shot);
}

morals_shoot_harper_slowmo(empty_param) {
  settimescale(0.25);
}

morals_shoot_harper_speedup(empty_param) {
  settimescale(1);
}

morals_arms_fov_in(unused_param) {
  old_fov = getdvarint(#"cg_fov");
  new_fov = 60;
  time = 1;
  level.player thread lerp_fov_overtime(time, new_fov, 1);
  level waittill("morals_arms_fov_out");
  level.player thread lerp_fov_overtime(time, old_fov, 1);
}

morals_arms_fov_out(unused_param) {
  level notify("morals_arms_fov_out");
}

morals_shoot_harper_fov_in(unused_param) {
  old_fov = getdvarint(#"cg_fov");
  new_fov = 55;
  time = 0.5;
  level.player thread lerp_fov_overtime(time, new_fov, 1);
  level waittill("morals_shoot_harper_fov_out");
  level.player thread lerp_fov_overtime(time, old_fov, 1);
}

morals_shoot_harper_fov_out(unused_param) {
  level notify("morals_shoot_harper_fov_out");
}

morals_shoot_harper_vtol_fire(empty_param) {
  level endon("stop_mason_vtol_fire");
  settimescale(0.25);
  m_vtol = get_model_or_models_from_scene("morals_shoot_harper", "morals_shoot_harper_vtol");
  s_temp = getstruct("morals_align", "targetname");

  while(isDefined(m_vtol)) {
    m_vtol firegunnerweapon(0);
    wait 0.05;
  }
}

morals_shoot_harper_explosion(m_player) {
  exploder(2001);
  s_temp = getstruct("morals_align", "targetname");
  playsoundatposition("exp_morals_harper", s_temp.origin);
}

morals_mason_intro() {
  if(flag("harper_shot")) {
    trigger_use("trig_drone_control_allies");
    wait 2;
    level thread screen_fade_in(2);
    thread run_scene_and_delete("morals_outcome_farid_lives");
    ai_salazar = getent("sp_salazar_ai", "targetname");
    ai_in_scene = get_ais_from_scene("morals_outcome_farid_lives");

    foreach(ai_dude in ai_in_scene) {
      if(ai_dude.animname != "morals_salazar")
        ai_dude stop_magic_bullet_shield();
    }

    flag_wait("morals_outcome_farid_lives_done");
    wait 0.05;
    player_weapons = level.player getweaponslist();

    foreach(weapon in player_weapons)
    level.player givestartammo(weapon);
  }
}

player_switch_in(player) {
  body = get_model_or_models_from_scene("morals_outcome_farid_lives", "player_body");
  player_camera_restrain_smooth(body, 10, 10, 10, 10);
}

player_camera_restrain_smooth(body, n_right, n_left, n_top, n_bottom) {
  n = [];
  n[0] = n_right;
  n[1] = n_left;
  n[2] = n_top;
  n[3] = n_bottom;

  while(array_greater_than_zero(n)) {
    level.player playerlinktodelta(body, "tag_player", 1, n[0], n[1], n[2], n[3]);
    n = decrement_array_min_zero(n);
    wait 0.05;
  }

  if(array_equal_to_zero(n))
    level.player playerlinktodelta(body, "tag_player", 1, n[0], n[1], n[2], n[3]);
}

array_greater_than_zero(array) {
  foreach(n in array) {
    if(n > 0)
      return true;
  }

  return false;
}

array_equal_to_zero(array) {
  foreach(n in array) {
    if(n < 0 || n > 0)
      return false;
  }

  return true;
}

decrement_array_min_zero(array) {
  new_array = [];

  foreach(n in array) {
    if(n > 0)
      n--;

    new_array[new_array.size] = n;
  }

  return new_array;
}

player_switch_out(player) {
  level thread do_mason_custom_intro_screen();
  body = get_model_or_models_from_scene("morals_outcome_farid_lives", "player_body");
  level.player playerlinktodelta(body, "tag_player", 1, 10, 10, 10, 10);
}

fake_combat_sounds() {
  canned_combat_1 = spawn("script_origin", (-4915, -4479, 455));
  canned_combat_2 = spawn("script_origin", (-4995, -5589, 572));
  canned_combat_1 playloopsound("amb_canned_battle_l");
  canned_combat_2 playloopsound("amb_canned_battle_r");
}

vo_morals_shoot_vtol() {
  flag_wait("morals_vtol_crashing_started");
  level.player thread say_dialog("harp_farid_you_still_m_0", 3.5);
  level.player say_dialog("harp_it_s_harper_we_re_0", 6.5);
  flag_wait("morals_vtol_crashing_done");
  level.player say_dialog("harp_dammit_fuck_i_0", 0.5);
}

say_dialog_waittill(str_vo_line, str_waittill, n_delay, b_fake_ent, b_cleanup) {
  assert(isDefined(str_waittill));
  level waittill(str_waittill);
  self say_dialog(str_vo_line, n_delay, b_fake_ent, b_cleanup);
}