/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\monsoon.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\monsoon_util;
#include maps\_camo_suit;
#include maps\_glasses;
#include maps\monsoon_fx;
#include maps\_metal_storm;
#include maps\_heatseekingmissile;
#include maps\_cic_turret;
#include maps\_load;
#include maps\monsoon_anim;
#include maps\_stealth_logic;
#include maps\_stealth_behavior;
#include maps\_patrol;
#include maps\_rusher;
#include maps\createart\monsoon_art;
#include maps\monsoon_amb;
#include maps\_fxanim;
#include maps\_ammo_refill;
#include maps\monsoon_intro;
#include maps\monsoon_wingsuit;
#include maps\monsoon_ruins;
#include maps\monsoon_lab;
#include maps\monsoon_lab_defend;
#include maps\monsoon_celerium_chamber;

main() {
  maps\monsoon_fx::main();
  level_precache();
  level_init();
  level_init_flags();
  setup_objectives();
  setup_skiptos();
  maps\_metal_storm::init();
  maps\_heatseekingmissile::init();
  level.custom_introscreen = ::monsoon_custom_introscreen;
  level thread maps\_cic_turret::init();
  maps\_load::main();
  screen_fade_out(0, undefined, 1);
  maps\monsoon_anim::main();
  maps\_stealth_logic::stealth_init("rain");
  maps\_stealth_logic::stealth_detect_corpse_range_set(256, 128, 64);
  maps\_stealth_behavior::main();
  maps\_patrol::patrol_init();
  maps\monsoon_anim::custom_patrol_init();
  array_thread(getspawnerarray(), ::add_spawn_function, ::setup_camo_suit_ai);
  maps\_rusher::init_rusher();
  array_thread(getspawnerarray(), ::add_spawn_function, ::setup_gasfreeze_ai);
  level thread outside_lift_init();
  level thread sway_init();
  level thread maps\createart\monsoon_art::main();
  level thread maps\monsoon_amb::main();
  level thread maps\_objectives::objectives();
  onplayerconnect_callback(::on_player_connect);
  onsaverestored_callback(::on_saved_restored_monsoon);
  setsaveddvar("r_waterWaveAngle", "40 120 205 302");
  setsaveddvar("r_waterWaveWavelength", "275 358 206 431");
  setsaveddvar("r_waterWaveAmplitude", "1.25 0 1.5 2");
  setsaveddvar("r_waterWaveSteepness", "1 1 1 1");
  setsaveddvar("r_waterWaveSpeed", "0.8 1.35 0.675 1.125");
}

monsoon_fxanim_deconstruct() {
  maps\_fxanim::fxanim_deconstruct("fxanim_defend_room");
  maps\_fxanim::fxanim_deconstruct("fxanim_defend_room_monitors");
  maps\_fxanim::fxanim_deconstruct("fxanim_server_arm_loop");
  maps\_fxanim::fxanim_deconstruct("fxanim_metal_storm_enter");
  flag_wait("monsoon_gump_interior");
  model_restore_area();
  maps\_fxanim::fxanim_reconstruct("fxanim_defend_room");
  maps\_fxanim::fxanim_reconstruct("fxanim_defend_room_monitors");
  maps\_fxanim::fxanim_reconstruct("fxanim_server_arm_loop");
  maps\_fxanim::fxanim_reconstruct("fxanim_metal_storm_enter");
  e_volume = getent("model_convert", "targetname");
  a_fxanims = getentarray("fxanim", "script_noteworthy");

  foreach(m_fxanim in a_fxanims) {
    if(isDefined(m_fxanim) && !m_fxanim istouching(e_volume)) {
      m_fxanim notify("fxanim_delete");
      m_fxanim delete();
      wait 0.05;
    }
  }

  a_script_models = getentarray("script_model", "classname");

  foreach(script_model in a_script_models) {
    if(!script_model istouching(e_volume)) {
      if(isDefined(script_model.destructibledef)) {
        script_model delete();
        wait 0.05;
      }

      if(isDefined(script_model.targetname)) {
        if(script_model.targetname == "sys_ammo_cache" || script_model.targetname == "sys_weapon_cache") {
          script_model maps\_ammo_refill::cleanup_cache();
          wait 0.05;
        }
      }
    }
  }
}

monsoon_custom_introscreen(level_prefix, number_of_lines, totaltime, text_color) {
  flag_wait("all_players_connected");
  flag_wait_either("monsoon_gump_exterior", "monsoon_gump_interior");
  waittill_textures_loaded();
  wait 0.5;
  screen_fade_in(1);
  flag_wait("show_introscreen_title");
  luinotifyevent(&"hud_add_title_line", 4, level_prefix, number_of_lines, totaltime, text_color);
  wait 2.5;
  level notify("introscreen_done");
}

on_player_connect() {
  level.player = get_players()[0];
  level.player setup_challenges();
  level thread bruteforce_perk_asd();
  add_spawn_function_veh_by_type("apc_gaz_tigr_monsoon", ::add_ai_to_gaz);
  add_spawn_function_veh_by_type("apc_gaz_tigr_wturret_monsoon", ::add_ai_to_gaz);
  a_triggers = getentarray("trigger_c4", "script_noteworthy");
  array_thread(a_triggers, ::plant_c4_trigger_think);

  if(!flag("monsoon_gump_interior")) {
    level thread model_convert_areas();
    level thread monsoon_fxanim_deconstruct();
  }
}

on_saved_restored_monsoon() {
  if(flag("mid_flight_save") && !flag("wingsuit_player_landed")) {
    screen_fade_out(0);
    level.player.vh_wingsuit.origin = getent("mid_flight_save", "targetname").origin;
    v_to_goal = vectortoangles((58016, 79256, -13656) - level.player.vh_wingsuit.origin);
    level.player.vh_wingsuit setphysangles((0, v_to_goal[1], 0));
    level.player.vh_wingsuit setspeedimmediate(200);
    level.harper.vh_wingsuit notify("mid_flight_restore");
    level.salazar.vh_wingsuit notify("mid_flight_restore");
    level.harper.vh_wingsuit setspeedimmediate(0);
    level.salazar.vh_wingsuit setspeedimmediate(0);
    delay_thread(0.2, ::screen_fade_in, 0.5);
  }

  if(flag("player_flying_wingsuit") && !flag("wingsuit_player_landed")) {
    wait_network_frame();
    wait_network_frame();
    luinotifyevent(&"hud_update_vehicle_entity", 1, level.player.vh_wingsuit getentitynumber());
    s_crumb_pos = getstruct("squirrel_breadcrumb_start", "targetname");
    luinotifyevent(&"hud_update_distance_obj", 3, int(s_crumb_pos.origin[0]), int(s_crumb_pos.origin[1]), int(s_crumb_pos.origin[2]));
  }

  if(!flag("wingsuit_player_landed")) {
    wait_network_frame();
    luinotifyevent(&"hud_shrink_ammo", 0);
  }
}

setup_skiptos() {
  add_skipto("intro", maps\monsoon_intro::skipto_intro, "Intro", maps\monsoon_intro::main);
  add_skipto("harper_reveal", maps\monsoon_intro::skipto_harper_reveal, "Harper Reveal", maps\monsoon_intro::main);
  add_skipto("rock_swing", maps\monsoon_intro::skipto_rock_swing, "Rock Swing", maps\monsoon_intro::main);
  add_skipto("suit_jump", maps\monsoon_intro::skipto_suit_jump, "Suit Jump", maps\monsoon_intro::main);
  add_skipto("suit_flying", maps\monsoon_wingsuit::skipto_suit_fly, "Suit Flying", maps\monsoon_wingsuit::wingsuit_main);
  add_skipto("camo_intro", maps\monsoon_wingsuit::skipto_camo_intro, "Camo Intro", maps\monsoon_wingsuit::camo_intro_main);
  add_skipto("camo_battle", maps\monsoon_ruins::skipto_camo_battle, "Camouflage_Battle", maps\monsoon_ruins::camo_battle_main);
  add_skipto("helipad_battle", maps\monsoon_ruins::skipto_helipad_battle, "Helipad Battle", maps\monsoon_ruins::helipad_battle_main);
  add_skipto("outer_ruins", maps\monsoon_ruins::skipto_outer_ruins, "Outer Ruins", maps\monsoon_ruins::outer_ruins_main);
  add_skipto("inner_ruins", maps\monsoon_ruins::skipto_inner_ruins, "Inner Ruins", maps\monsoon_ruins::inner_ruins_main);
  add_skipto("ruins_interior", maps\monsoon_ruins::skipto_ruins_interior, "Ruins Interior", maps\monsoon_ruins::ruins_interior_main);
  add_skipto("lab", maps\monsoon_lab::skipto_lab, "Lab", maps\monsoon_lab::lab_main);
  add_skipto("lab_battle", maps\monsoon_lab::skipto_lab_battle, "Lab Battle", maps\monsoon_lab::lab_battle_main);
  add_skipto("fight_to_isaac", maps\monsoon_lab::skipto_fight_to_isaac, "Fight to Isaac", maps\monsoon_lab::fight_to_isaac_main);
  add_skipto("lab_defend", maps\monsoon_lab_defend::skipto_lab_defend, "Lab Defend", maps\monsoon_lab_defend::lab_defend_main);
  add_skipto("celerium_chamber", maps\monsoon_celerium_chamber::skipto_celerium, "Celerium Chamber", maps\monsoon_celerium_chamber::celerium_chamber_main);
  default_skipto("intro");
  set_skipto_cleanup_func(maps\monsoon_util::skipto_setup);
}

level_precache() {
  precachestring(&"MONSOON_POI_SCANNING");
  precachestring(&"MONSOON_POI_HELI");
  precachestring(&"MONSOON_POI_HOSTILES");
  precachestring(&"MONSOON_POI_LIFT");
  precachestring(&"MONSOON_POI_SENTRY");
  precachestring(&"MONSOON_CHUTE_DEPLOYED");
  precachestring(&"MONSOON_HACKING_CHAMBER_DOOR");
  precachestring(&"MONSOON_HACKING_CHAMBER_DOOR_PORT");
  precachestring(&"MONSOON_HACKING_CHAMBER_DOOR_DONE");
  precachestring(&"MONSOON_IDKFA");
  precachestring(&"MONSOON_J_5_ACTIVATING");
  precachestring(&"MONSOON_ASD_ANOMALY");
  precachestring(&"MONSOON_ASD_DETECTED");
  precachestring(&"MONSOON_J_5_DEAD");
  precachemodel("c_usa_cia_masonjr_viewhands_cl");
  precachemodel("c_usa_cia_frnd_viewbody_vson");
  precachemodel("c_usa_seal6_monsoon_armlaunch_viewbody_on");
  precachemodel("c_usa_seal6_monsn_sqrl_armlnch_viewbody");
  precacheshader("cinematic2d");
  precacheshader("compass_static");
  precacherumble("monsoon_harper_swing");
  precacherumble("monsoon_player_swing");
  precacherumble("monsoon_gloves_impact");
  precachemodel("c_usa_seal6_ass_sqrl_haper_wt_fb");
  precachemodel("c_usa_seal6_ass_sqrl_salazar_wt_fb");
  precachemodel("c_usa_seal6_assault_squirrel_wt_fb");
  precachemodel("c_usa_seal6_helmet_prop");
  precachemodel("p6_anim_seal_helmet_view");
  precachemodel("t6_wpn_knife_melee");
  precachemodel("ctl_light_spotlight_generator_on");
  precachemodel("p6_container_yard_light_on");
  precachemodel("ctl_light_spotlight_generator_off");
  precachemodel("p6_container_yard_light_off");
  precachemodel("fxanim_gp_vines_strangler_fig_mod");
  precachemodel("fxanim_gp_vines_aquilaria_sm_mod");
  precachemodel("t6_wpn_c4_world");
  precachemodel("p6_monsoon_ext_elevator_rain_box");
  precacheitem("exptitus6_sp");
  precacheitem("scar_silencer_sp");
  precacheitem("saritch_sp");
  precachestring(&"goggles_hud");
  precachestring(&"hud_goggles_add_poi");
  precachestring(&"hud_goggles_clear_all_poi");
  precachestring(&"hud_goggles_update_zoom");
  precachestring(&"hud_update_distance_obj");
  precachestring(&"hud_update_friendly");
  precachestring(&"hud_update_vehicle_entity");
  precachestring(&"hud_update_vehicle");
  precachestring(&"hud_update_vehicle_custom");
  precachestring(&"plane_wingsuit");
  precachestring(&"hud_weapon_cg_heat");
  precacheitem("metalstorm_launcher");
  precacheitem("riotshield_sp");
  precachemodel("t6_wpn_shield_carry_world");
  precachemodel("p6_celerium_device");
  precachemodel("p6_asd_charger_door");
  precacherumble("tank_rumble");
  precachemodel("veh_t6_drone_tank_freeze");
  precachemodel("p6_monsoon_ext_elevator_door_broken");
  precachemodel("p6_monsoon_ext_elevator_glass_rt_broken");
  precachemodel("p6_monsoon_ext_elevator_glass_lft_broken");
  precachemodel("office_chair_black_anim_haiti");
  precachemodel("p6_monsoon_crate_access_unlocked");
  maps\_camo_suit::precache();
}

level_init() {
  m_lion = getent("lion_statue_collision", "targetname");
  m_lion notsolid();
  m_collapse = getent("ruins_blocker", "targetname");
  m_collapse notsolid();
  m_collapse connectpaths();
  m_collapse hide();
  m_chute = getent("fxanim_parachute", "targetname");
  m_chute hide();
  m_temple_doors_destroyed = getent("temple_doors_destroyed", "targetname");
  m_temple_doors_destroyed hide();
  trig_player_riotshield = getent("trig_player_riotshield", "targetname");
  trig_player_riotshield trigger_off();
  trig_player_celerium = getent("trig_player_celerium", "targetname");
  trig_player_celerium trigger_off();
  trig_isaac_player = getent("trig_isaac_player", "targetname");
  trig_isaac_player trigger_off();
  trig_player_celerium_door = getent("trig_player_celerium_door", "targetname");
  trig_player_celerium_door trigger_off();
  level.metalstorm_freeze_death = 1;
  a_escape_trigs = getentarray("escape_trigs", "script_noteworthy");

  foreach(trig in a_escape_trigs)
  trig trigger_off();

  trig_briggs_player_use = getent("briggs_player_use", "targetname");
  trig_briggs_player_use trigger_off();
  trig_player_at_lab = getent("trig_player_at_lab", "targetname");
  trig_player_at_lab trigger_off();
  e_lab_stair_blocker_clip = getent("lab_stair_blocker_clip", "targetname");
  e_lab_stair_blocker_clip hide();
  e_lab_stair_blocker_clip notsolid();
}