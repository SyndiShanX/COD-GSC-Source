/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout_hangar.gsc
**************************************/

#include maps\blackout_util;
#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\_glasses;
#include maps\_dialog;
#include maps\blackout_anim;
#include maps\_music;
#include maps\blackout_deck;
#include maps\_jetpack_ai;
#include maps\_fxanim;
#include maps\_audio;
#include maps\createart\blackout_art;

init_flags() {
  flag_init("mason_hangar_started");
  flag_init("hanger_salazar_scene");
  flag_init("hangar_betrayal_speech_started");
  flag_init("mason_approach_salazar");
  flag_init("betrayal_speech_done");
  flag_init("mason_elevator_started");
  flag_init("reached_top_elevator");
  flag_init("mason_elevator_flyby_started");
}

skipto_mason_hangar() {
  mason_part_2_animations();
  skipto_teleport_players("player_skipto_mason_hangar");
  level.salazar = init_hero_startstruct("salazar", "salazar_skipto_mason_hangar");

  if(level.is_harper_alive) {
    level.harper = init_hero_startstruct("harper", "harper_skipto_mason_hangar");
    level.harper change_movemode("cqb_run");
  }

  add_posed_corpses("control_room_corpses", "mason_elevator_started");
  server_room_exit_door_open();
}

skipto_mason_salazar_caught() {
  mason_part_2_animations();
  skipto_teleport_players("player_skipto_mason_salazar_caught");
  flag_set("mason_hangar_started");

  if(level.is_harper_alive) {
    level.harper = init_hero_startstruct("harper", "harper_skipto_mason_salazar_caught");
    level.harper change_movemode("cqb_run");
  }

  set_objective(level.obj_find_salazar, level.salazar);
  spawn_salazar_guards();
}

skipto_mason_elevator() {
  flag_set("hanger_salazar_scene");
  mason_part_2_animations();
  level.harper = init_hero("harper");
  level.ai_redshirt1 = init_hero("elevator_friendly", ::set_force_color, "r");
  level.ai_redshirt2 = init_hero("elevator_friendly", ::set_force_color, "r");
  skipto_teleport("player_skipto_mason_elevator", get_heroes());
  maps\blackout_util::init_phalanx_cannons("hackable_phalanx_cannon_spot");
  maps\blackout_util::disable_phalanx_cannons("hackable_phalanx_cannon_spot");
}

run_mason_hangar() {
  autosave_by_name("hangar");
  set_light_flicker_fx_area(71000);
  elevators_set_no_cull(1);
  level notify("start_control_room_fxanims");
  elevator_models_show();
  elevator_models_link();
  deck_turn_off_cells();
  level thread sea_cowbell();

  if(level.is_harper_alive)
    level.harper change_movemode("cqb_run");

  trigger_use("control_room_color_start");
  spawn_salazar_guards();
  level thread dialog_mason_hangar();
  flag_set("mason_hangar_started");
  level thread run_scene_and_delete("betrayal_surrender_sal_idle_loop");

  if(!isDefined(level.salazar)) {
    flag_wait("betrayal_surrender_sal_idle_loop_started");
    level.salazar = get_ent("salazar_ai", "targetname");
  }

  level.salazar thread friendly_fire_instant_fail_add();
  level thread mason_hangar_ambience();
  exploder(5001);
  level thread menendez_riding_elevator();
  level thread objective_breadcrumb_to_salazar();
  trigger_wait("hangar_trigger");
}

objective_breadcrumb_to_salazar() {
  t_current = get_ent("mason_hangar_breadcrumb_start", "targetname");

  while(isDefined(t_current)) {
    set_objective(level.obj_find_salazar, t_current, "breadcrumb");
    t_current waittill("trigger");

    if(isDefined(t_current.target))
      t_current = getent(t_current.target, "targetname");
    else
      t_current = undefined;
  }

  set_objective(level.obj_find_salazar, level.salazar, "breadcrumb");
}

spawn_salazar_guards() {
  level.redshirt1 = simple_spawn_single("elevator_friendly", ::run_to_node, "elevator_friendly_1_guards_salazar");
  level.redshirt2 = simple_spawn_single("elevator_friendly", ::run_to_node, "elevator_friendly_2_guards_salazar");
  level.redshirt3 = simple_spawn_single("elevator_friendly", ::run_to_node, "elevator_friendly_3_guards_salazar");
  level.redshirt4 = simple_spawn_single("elevator_friendly", ::run_to_node, "elevator_friendly_4_guards_salazar");
}

dialog_mason_hangar() {
  level endon("betrayal_speech_sal_started");
  wait 1;
  a_hangar_redshirts = get_ent_array("elevator_friendly_ai", "targetname");
  ai_redshirt = arraysort(a_hangar_redshirts, level.player.origin, 1)[0];
  ai_redshirt queue_dialog("secu_section_security_t_0");
  level.player queue_dialog("sect_where_are_you_1");
  ai_redshirt queue_dialog("secu_hangar_bay_two_0");
  level.player queue_dialog("sect_on_my_way_what_abo_0");
  ai_redshirt queue_dialog("secu_he_took_of_one_of_ou_0");
}

pip_ai_think() {
  self magic_bullet_shield();
  self set_ignoreall(1);
  wait 2;
  self set_ignoreall(0);
  flag_wait("mason_elevator_started");
  wait(randomfloatrange(0.5, 1.0));
  self stop_magic_bullet_shield();
  self die();
}

dialog_mason_elevator() {
  playsoundatposition("vox_bla_13_03_001b_sect", (1136, -2172, -519));
  level.player say_dialog("sect_attention_all_on_thi_1");
  playsoundatposition("vox_bla_13_03_002b_sect", (1136, -2172, -519));
  level.player say_dialog("sect_all_hands_prep_for_e_0");
  playsoundatposition("vox_bla_13_03_003b_sect", (1136, -2172, -519));
  level.player say_dialog("sect_i_say_again_abando_0");
  level thread dialog_combat_mason_elevator();
}

dialog_combat_mason_elevator() {
  a_friendly_generic = [];
  a_friendly_generic[a_friendly_generic.size] = "nav0_get_us_to_the_upper_0";
  a_friendly_generic[a_friendly_generic.size] = "nav1_taking_fire_from_hig_0";
  a_friendly_generic[a_friendly_generic.size] = "nav0_rpgs_0";
  level thread start_combat_vo_group_friendly(a_friendly_generic, "reached_top_elevator");
  a_enemy_generic = [];
  a_enemy_generic[a_enemy_generic.size] = "cub0_over_here_get_fire_0";
  a_enemy_generic[a_enemy_generic.size] = "cub1_here_they_come_0";
  a_enemy_generic[a_enemy_generic.size] = "cub2_kill_them_before_the_0";
  a_enemy_generic[a_enemy_generic.size] = "cub3_fire_the_rpgs_0";
  level thread start_combat_vo_group_enemy(a_enemy_generic, "reached_top_elevator");
}

mason_elevator() {
  m_mason_elevator = getent("mason_elevator", "targetname");
  m_mason_elevator setmovingplatformenabled(1);
  m_mason_elevator elevator_connect_paths();
  elevator_waittill_squad_boarded();
  level clientnotify("loud_alarm_on");
  trigger_wait("mason_elevator_trig");
  m_clip = getent("mason_elevator_clip", "targetname");
  m_clip solid();
  m_clip linkto(m_mason_elevator);
  flag_set("mason_elevator_started");
  flag_clear("distant_explosions_on");
  clean_up_super_kill_blood();
  delete_exploder(125);
  set_objective(level.obj_find_menen, undefined);
  level thread dialog_mason_elevator();
  autosave_by_name("mason_on_elevator");
  level.player thread elevator_rumble();
  m_mason_elevator thread elevator_audio();
  set_objective(level.obj_breadcrumb, undefined, "done");
  elevator_disconnect_paths();
  wait 1.5;
  spawn_manager_enable("sm_mason_elevator");
  delay_thread(15, ::flag_set, "start_deck_spawners");
  delay_thread(15, ::spawn_manager_kill, "sm_mason_elevator", 1);
  delay_thread(10, ::run_scene, "fa38_crash");
  delay_thread(20, ::play_dradis_bink);
  delay_thread(15, ::elevator_jetpacks_land);
  m_mason_elevator movez(576, 25, 3, 3);

  if(-1)
    level thread maps\blackout_deck::setup_claw_bigdog();

  wait 23.8;
  flag_set("reached_top_elevator");
  m_clip delete();
  m_mason_elevator waittill("movedone");
  trigger_use("move_allies_off_elevator");
  autosave_by_name("mason_reached_deck");
  elevator_connect_paths();
  stop_exploder(5001);
  level notify("start_vtol_timer");
  level thread cleanup_for_deck();
}

elevator_jetpacks_land() {
  a_s_landing = getstructarray("jetpack_elevator_struct", "targetname");

  foreach(s_align in a_s_landing) {
    level thread maps\_jetpack_ai::create_jetpack_ai(s_align, "pmc_assault_guy", 0, maps\blackout_deck::func_jetpack_live_to_deck);
    wait(randomfloatrange(1.0, 2.0));
  }
}

play_dradis_bink() {
  maps\_glasses::play_bink_on_hud("blackout_dradis", 0, 0);
}

hack_moving_platform() {
  self movez(-1, 0.05);
  self waittill("movedone");
  self movez(1, 0.05);
  self waittill("movedone");
}

elevator_waittill_squad_boarded() {
  t_elevator = getent("mason_elevator_trig", "targetname");
  a_elevator_squad = array(level.harper, level.redshirt1, level.redshirt2);
  a_elevator_squad = remove_undefined_from_array(a_elevator_squad);
  b_all_boarded = 0;

  while(!b_all_boarded) {
    b_all_boarded = 1;

    foreach(ai in a_elevator_squad) {
      if(!ai istouching(t_elevator))
        b_all_boarded = 0;
    }

    wait 0.5;
  }
}

elevator_debris_rumble(m_debris) {
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.3, 1, self.origin, 1000, level.player);
}

elevator_rumble() {
  self endon("death");
  self playrumbleonentity("damage_heavy");
  earthquake(0.3, 1, self.origin, 1000, self);
  wait 1.5;

  while(!flag("reached_top_elevator")) {
    self playrumbleonentity("tank_rumble");
    earthquake(0.1, 0.1, self.origin, 1000, self);
    wait 0.1;
  }

  self playrumbleonentity("damage_heavy");
  earthquake(0.3, 1, self.origin, 1000, self);
}

elevator_audio() {
  playsoundatposition("evt_elev_alarm", (815, -2177, -400));
  wait 1;
  self playsound("evt_elev_start");
  wait 1;
  self playloopsound("evt_elev_loop", 2);
  self waittill("movedone");
  self playsound("evt_elev_stop");
  wait 0.5;
  self stoploopsound(0.3);
}

play_pip_dradis() {
  wait 3;
  level thread play_pip("blackout_dradis", 0);
}

menendez_riding_elevator() {
  menendez_elevator = getent("menendez_elevator", "targetname");
  landing_gears = getent("landing_gear_hanger", "targetname");

  if(isDefined(landing_gears))
    landing_gears delete();

  menendez_elevator movez(200, 1, 0.5, 0.5);
  wait 1;
  menendez_elevator movez(376, 30, 1, 1);
}

run_betrayal_redshirt_walkup_scene() {
  ai_redshirt = simple_spawn_single("navy_assault_guy");
  ai_redshirt.targetname = "salazar_captor_ai";
  ai_redshirt.animname = "salazar_captor";
  s_warp = get_struct("redshirt_captures_salazar_warp_struct", "targetname", 1);
  ai_redshirt forceteleport(s_warp.origin, s_warp.angles);
  flag_wait("player_enters_hangar");
  ai_redshirt run_to_node("harper_guards_salazar");
}

cleanup_for_deck() {
  delete_emergency_light("server_room_light");
  delete_emergency_light("menendez_switch_light");
  delete_emergency_light("messiah_room_light");
  delete_emergency_light("hangar_light");
  maps\_fxanim::fxanim_delete("control_room_fxanims");
  a_to_delete = array("redshirt2_ai", "salazar_ai", "redshirt1_ai");
  level thread clean_up_ent_array(a_to_delete);
}

run_mason_elevator() {
  autosave_by_name("mason_elevator");
  maps\blackout_anim::f38_crash_into_bridge();
  m_mason_elevator = get_ent("mason_elevator", "targetname", 1);
  m_mason_elevator hack_moving_platform();
  elevator_connect_paths();
  a_elevator_squad = [];
  a_elevator_squad[a_elevator_squad.size] = level.harper;
  a_elevator_squad[a_elevator_squad.size] = level.redshirt1;
  a_elevator_squad[a_elevator_squad.size] = level.redshirt2;
  a_elevator_squad = remove_undefined_from_array(a_elevator_squad);

  foreach(ai in a_elevator_squad) {
    ai set_force_color("r");
    ai set_ignoreall(0);
  }

  move_ai_to_pre_elevator_positions();
  wait 1;
  set_objective(level.obj_find_menen, getent("mason_elevator_trig", "targetname"));
  trigger_wait("trigger_dead_body_fall");
  level thread fxanim_debris_fx();
  level notify("fxanim_black_elevator_debris_start");
  add_spawn_function_group("pip_ai", "script_noteworthy", ::pip_ai_think);
  wait 2;
  spawn_manager_enable("sm_pip_troops");
  level thread mason_elevator();
}

fxanim_debris_fx() {
  level waittill("fxanim_black_elevator_debris_start");
  wait 0.05;
  earthquake(0.3, 1.5, level.player.origin, 128);
  fxanim_model = getent("black_elevator_debris", "targetname");
  playfxontag(getfx("fx_com_elev_fa38_debri_trail_3"), fxanim_model, "link_cockpit_debris_jnt");
  playfxontag(getfx("fx_com_elev_fa38_debri_trail_2"), fxanim_model, "link_wing_l_debris_jnt");
  playfxontag(getfx("fx_com_elev_fa38_debri_trail_2"), fxanim_model, "link_wing_r_debris_jnt");
  playfxontag(getfx("fx_com_elev_fa38_debri_trail"), fxanim_model, "link_engine_debris_jnt");
  wait 2;
  earthquake(0.3, 1.5, level.player.origin, 128);
  trigger_use("color_trigger_hangar");
  wait 3;
  mason_elevator = getent("mason_elevator", "targetname");
  fxanim_model linkto(mason_elevator);
}

move_ai_to_pre_elevator_positions() {
  t_color_moveup = get_ent("pre_elevator_color_trigger", "targetname");

  if(isDefined(t_color_moveup))
    t_color_moveup trigger_use();
}

ambient_fire_on_deck() {
  s_fire = get_struct("s_deck_fire", "targetname");
  play_fx("fx_fire_line_md", s_fire.origin, s_fire.angles);
  s_smoke = get_struct("s_deck_smoke_1", "targetname");
  play_fx("fx_smk_fire_lg_black", s_smoke.origin, s_smoke.angles);
  play_fx("fx_fire_fuel_sm", s_smoke.origin, s_smoke.angles);
  s_smoke = get_struct("s_deck_smoke_2", "targetname");
  play_fx("fx_smk_fire_lg_black", s_smoke.origin, s_smoke.angles);
  play_fx("fx_fire_fuel_sm", s_smoke.origin, s_smoke.angles);
}

delete_and_create_runway_jets() {
  runway_array = getentarray("runway_jet_delete", "targetname");
  array_delete(runway_array);
  spawn_vehicle_from_targetname("defend_f38_1");
  spawn_vehicle_from_targetname("defend_f38_2");
}

gas_mask_remove() {
  if(isDefined(self.gas_mask_model)) {
    self detach(self.gas_mask_model, "J_Head");
    self.gas_mask_model = undefined;
  }
}

run_to_node(str_targetname, str_delay_flag) {
  if(isDefined(str_delay_flag))
    flag_wait(str_delay_flag);

  nd_goal = getnode(str_targetname, "targetname");
  self set_goal_node(nd_goal);
}

nuke_server_room() {
  level notify("nuke_server_room");
  server_room_exit_door_close();
  cleanup_server_room();
  load_gump("blackout_gump_deck");
}

cleanup_server_room() {
  delete_emergency_light("server_room_light");
  delete_emergency_light("menendez_switch_light");
  delete_if_defined("karma_ai", "targetname");
  a_to_delete = array("briggs_ai", "meat_shield_target_01_ai", "control_room_pmc_ai", "meat_shield_target_02_ai", "control_room_navy_guy", "guy2_ai", "guy3_ai", "guy1_ai", "server_room_computer_guy_ai", "torch_guy_ai", "server_room_computer_chair", "panel", "server_room_console_dark", "server_room_console_bink", "eyeball_broken", "server_room_computer_chair", "server_screen", "menendez_start_door", "vent_clip_brushmodel", "khan_screen_2", "salazar_shoots_screen", "khan_screen_bink", "khan_screen_blank", "cctv_door", "cctv_door_clip");
  level thread clean_up_ent_array(a_to_delete);
}

run_mason_salazar_caught() {
  level thread nuke_server_room();
  set_light_flicker_fx_area(71100);
  level.salazar = init_hero("salazar", ::clear_force_color);

  if(scene_exists("betrayal_surrender_sal_idle_loop"))
    level thread run_scene_and_delete("betrayal_surrender_sal_idle_loop");

  level thread friendly_fire_fail_during_surrender();

  if(level.is_harper_alive) {
    level.harper thread run_to_node("harper_guards_salazar");
    flag_wait("mason_approach_salazar");
    level thread queue_dialog_ally("nav3_don_t_move_you_fu_0", 2);
    level.player setlowready(1);
    flag_wait("hangar_betrayal_speech_started");
    level.player player_disable_weapons();
    level thread maps\_audio::switch_music_wait("BLACKOUT_SALAZAR_CONFRONTATION", 0.1);
    set_objective(level.obj_find_salazar, undefined, "delete");
    level thread run_scene_and_delete("betrayal_speech_sal", 0.2);
    run_scene_and_delete("betrayal_speech_player");
    level.salazar stop_magic_bullet_shield();
    level.player thread hold_player_for_salazar_ending();
    level.harper change_movemode("run");
    level thread run_scene_and_delete("betrayal_shot");
    level thread maps\_audio::playsoundatposition_wait("evt_salazar_shot", (0, 0, 0), 1);
  } else {
    level thread run_betrayal_redshirt_walkup_scene();
    flag_wait("mason_approach_salazar");
    level.player setlowready(1);
    level thread queue_dialog_ally("nav3_don_t_move_you_fu_0", 2);
    flag_wait("hangar_betrayal_speech_started");
    level.player player_disable_weapons();
    level thread maps\_audio::switch_music_wait("BLACKOUT_SALAZAR_CONFRONTATION", 0.1);
    set_objective(level.obj_find_salazar, undefined, "delete");
    flag_wait("betrayal_surrender_sal_idle_loop_started");
    level thread run_scene_and_delete("betrayal_speech_sal", 0.2);
    run_scene_and_delete("betrayal_speech_player");
    level.player thread low_ready_for_time(4);
    level.player thread queue_dialog("sect_get_him_out_of_here_1", 0.5);
    level.player thread queue_dialog("sect_i_m_going_after_mene_0", 0.5);
    level thread run_scene_then_loop("betrayal_sal_captured", "betrayal_sal_captured_loop");
  }

  flag_set("betrayal_speech_done");
  maps\blackout_util::cleanup_ents("mason_hangar_trigs", "script_noteworthy");
}

low_ready_for_time(n_time) {
  self setlowready(1);
  wait(n_time);
  self setlowready(0);
  level.player player_enable_weapons();
}

hold_player_for_salazar_ending() {
  run_scene_and_delete("betrayal_shot_player");
  level.player setlowready(1);
  scene_wait("betrayal_shot");
  level.player setlowready(0);
  level.player player_enable_weapons();
}

friendly_fire_fail_during_surrender() {
  if(level.is_harper_alive) {
    flag_wait("betrayal_surrender_harper_started");
    ai_captor = level.harper;
  } else {
    flag_wait("player_enters_hangar");
    ai_captor = get_ent("salazar_captor_ai", "targetname");
  }

  ai_captor friendly_fire_instant_fail_add();
  flag_wait("betrayal_speech_done");

  if(level.is_harper_alive)
    ai_captor friendly_fire_instant_fail_remove();
}

notetrack_harper_uses_pistol(ai_harper) {
  ai_harper gun_switchto(ai_harper.primaryweapon, "right");
  ai_harper attach("t6_wpn_pistol_fiveseven_prop", "tag_weapon_left");
}

notetrack_harper_hides_pistol(m_origin) {
  ai_harper = get_ent("harper_ai", "targetname", 1);
  ai_harper detach("t6_wpn_pistol_fiveseven_prop", "tag_weapon_left");
}

notetrack_harper_shoots_salazar(m_origin) {
  exploder(1028);
  v_start = m_origin gettagorigin("origin_animate_jnt");
  v_angles = m_origin gettagangles("origin_animate_jnt");
  v_end = v_start + anglestoforward(v_angles) * 200;
  magicbullet("fiveseven_sp", v_start, v_end);
  playfxontag(level._effect["super_kill_muzzle_flash"], m_origin, "origin_animate_jnt");
  ai_salazar = get_ent("salazar_ai", "targetname", 1);
  playfxontag(level._effect["harper_shoots_salazar"], ai_salazar, "J_Head");
}

mason_hangar_ambience() {
  exploder(1111);
  flag_wait("mason_approach_salazar");
  maps\createart\blackout_art::vision_set_menendez();
  level thread maps\blackout_util::init_persist_ambience(4, "tanker_fourth_state_start_spot");
  level thread maps\blackout_util::start_cowbell();
  flag_wait("mason_elevator_started");
  setmusicstate("BLACKOUT_DECK_FIGHT");
  maps\blackout_util::cleanup_structs("hangar_drone_struct", "script_noteworthy");
  maps\blackout_util::cleanup_structs("salazar_exit_structs", "script_noteworthy");
  maps\createart\blackout_art::vision_set_hanger_elevator();
  maps\blackout_util::init_phalanx_cannons("hackable_phalanx_cannon_spot");
  maps\blackout_util::disable_phalanx_cannons("hackable_phalanx_cannon_spot");
  flag_wait("mason_elevator_flyby_started");
  maps\blackout_util::init_ambient_oneoff_vehicles("mason_elevator_f38_spline");
  level thread maps\blackout_util::kill_ambient_vehicles();
  flag_wait("reached_top_elevator");
  exploder(11002);
  stop_exploder(10252);
  stop_exploder(11001);
  maps\createart\blackout_art::vision_set_deck();
  maps\blackout_util::kill_persist_damaged_tanker("tanker_fourth_state_start_spot_model");
  maps\blackout_util::cleanup_structs("mason_hangar_gassed_pair_struct", "script_noteworthy");
  maps\blackout_util::cleanup_ents("mason_hangar_wall_lean_node", "script_noteworthy");
}