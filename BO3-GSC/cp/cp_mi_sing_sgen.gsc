/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_sgen.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_ammo_cache;
#using scripts\cp\_collectibles;
#using scripts\cp\_load;
#using scripts\cp\_mobile_armory;
#using scripts\cp\_objectives;
#using scripts\cp\_oed;
#using scripts\cp\_skipto;
#using scripts\cp\_util;
#using scripts\cp\cp_mi_sing_sgen_accolades;
#using scripts\cp\cp_mi_sing_sgen_dark_battle;
#using scripts\cp\cp_mi_sing_sgen_enter_silo;
#using scripts\cp\cp_mi_sing_sgen_exterior;
#using scripts\cp\cp_mi_sing_sgen_fallen_soldiers;
#using scripts\cp\cp_mi_sing_sgen_flood;
#using scripts\cp\cp_mi_sing_sgen_fx;
#using scripts\cp\cp_mi_sing_sgen_pallas;
#using scripts\cp\cp_mi_sing_sgen_patch;
#using scripts\cp\cp_mi_sing_sgen_revenge_igc;
#using scripts\cp\cp_mi_sing_sgen_silo_swim;
#using scripts\cp\cp_mi_sing_sgen_sound;
#using scripts\cp\cp_mi_sing_sgen_testing_lab_igc;
#using scripts\cp\cp_mi_sing_sgen_util;
#using scripts\cp\cp_mi_sing_sgen_uw_battle;
#using scripts\cp\cp_mi_sing_sgen_water_ride;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_tactical_rig;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\_save;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\colors_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\player_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicles\_quadtank;
#using scripts\shared\visionset_mgr_shared;
#namespace sgen;

function setup_rex_starts() {
  util::add_gametype("coop");
  util::add_gametype("cpzm");
}

function main() {
  if(sessionmodeiscampaignzombiesgame() && 0) {
    setclearanceceiling(34);
  } else {
    setclearanceceiling(116);
  }
  precache();
  init_clientfields();
  init_flags();
  setup_skiptos();
  function_b29072ff();
  function_1f7e5210();
  util::init_breath_fx();
  util::init_streamer_hints(6);
  callback::on_spawned( & on_player_spawned);
  savegame::set_mission_name("sgen");
  cp_mi_sing_sgen_fx::main();
  cp_mi_sing_sgen_sound::main();
  level.b_enhanced_vision_enabled = 1;
  level.can_revive_use_depthinwater_test = 1;
  level.overrideammodropteam3 = 1;
  if(getdvarstring("skipto") === "dev_flood_combat") {
    sgen_util::rename_coop_spawn_points("flood_combat", "dev_flood_combat");
  }
  load::main();
  namespace_643bc20::function_7403e82b();
  a_s_align = struct::get_array("dark_battle_align_2", "targetname");
  if(isdefined(a_s_align) && a_s_align.size > 1) {
    level.v_underwater_offset = a_s_align[1].origin - a_s_align[0].origin;
  }
  t_boundary = getent("flood_defend_out_of_boundary_trig", "targetname");
  t_boundary setinvisibletoall();
  level thread level_threads();
  level thread namespace_99202726::function_66df416f();
}

function function_1f7e5210() {
  var_d227736c = spawn("trigger_box", (280, -600, -3610), 0, 3000, 3000, 3000);
  var_d227736c thread function_4fef5e4();
}

function function_4fef5e4() {
  self endon("death");
  level endon("chem_door_open");
  while (true) {
    self waittill("trigger", who);
    if(isplayer(who)) {
      who kill();
    }
  }
}

function function_b29072ff() {
  var_76099c5f = spawnstruct();
  var_76099c5f.radius = 60;
  var_76099c5f.offset = vectorscale((-1, -1, 0), 5);
  level.var_3efe1e22["p7_nc_sin_coa_04"] = var_76099c5f;
}

function setup_skiptos() {
  skipto::add("intro", & cp_mi_sing_sgen_exterior::skipto_intro_init, "Intro", & cp_mi_sing_sgen_exterior::skipto_intro_done);
  skipto::add("exterior", & cp_mi_sing_sgen_exterior::function_d43e5685, "Exterior", & cp_mi_sing_sgen_exterior::function_91e8545f);
  skipto::function_d68e678e("enter_lobby", & cp_mi_sing_sgen_exterior::skipto_enter_lobby_init, "Enter Lobby", & cp_mi_sing_sgen_exterior::skipto_enter_lobby_done);
  skipto::function_d68e678e("discover_data", & cp_mi_sing_sgen_enter_silo::skipto_discover_data_init, "Discover Data", & cp_mi_sing_sgen_enter_silo::skipto_discover_data_done);
  skipto::function_d68e678e("aquarium_shimmy", & cp_mi_sing_sgen_enter_silo::skipto_aquarium_shimmy_init, "Aquarium Shimmy", & cp_mi_sing_sgen_enter_silo::skipto_aquarium_shimmy_done);
  skipto::function_d68e678e("gen_lab", & cp_mi_sing_sgen_enter_silo::skipto_gen_lab_init, "Genetics Lab", & cp_mi_sing_sgen_enter_silo::skipto_gen_lab_done);
  skipto::function_d68e678e("post_gen_lab", & cp_mi_sing_sgen_enter_silo::skipto_post_gen_lab_init, "Post Gen Lab", & cp_mi_sing_sgen_enter_silo::skipto_post_gen_lab_done);
  skipto::function_d68e678e("chem_lab", & cp_mi_sing_sgen_enter_silo::skipto_chem_lab_init, "Chemical Lab", & cp_mi_sing_sgen_enter_silo::skipto_chem_lab_done);
  skipto::function_d68e678e("post_chem_lab", & cp_mi_sing_sgen_enter_silo::skipto_post_chem_lab_init, "Post Chem Lab", & cp_mi_sing_sgen_enter_silo::skipto_post_chem_lab_done);
  skipto::function_d68e678e("silo_floor", & cp_mi_sing_sgen_enter_silo::skipto_silo_floor_init, "Silo Floor Battle", & cp_mi_sing_sgen_enter_silo::skipto_silo_floor_done);
  skipto::function_d68e678e("under_silo", & cp_mi_sing_sgen_enter_silo::skipto_under_silo_init, "Under Silo", & cp_mi_sing_sgen_enter_silo::skipto_under_silo_done);
  skipto::function_d68e678e("fallen_soldiers", & cp_mi_sing_sgen_fallen_soldiers::skipto_fallen_soldiers_init, "Fallen Soldiers", & cp_mi_sing_sgen_fallen_soldiers::skipto_fallen_soldiers_done);
  skipto::function_d68e678e("testing_lab_igc", & cp_mi_sing_sgen_testing_lab_igc::skipto_testing_lab_igc_init, "Human Testing Lab", & cp_mi_sing_sgen_testing_lab_igc::skipto_testing_lab_igc_done);
  skipto::function_d68e678e("dark_battle", & cp_mi_sing_sgen_dark_battle::skipto_dark_battle_init, "Dark Battle", & cp_mi_sing_sgen_dark_battle::skipto_dark_battle_done);
  skipto::function_d68e678e("charging_station", & cp_mi_sing_sgen_dark_battle::skipto_charging_station_init, "Charging Station", & cp_mi_sing_sgen_dark_battle::skipto_charging_station_done);
  skipto::function_d68e678e("descent", & cp_mi_sing_sgen_pallas::skipto_descent_init, "Descent", & cp_mi_sing_sgen_pallas::skipto_descent_done);
  skipto::add("pallas_start", & cp_mi_sing_sgen_pallas::skipto_pallas_start_init, "pallas start", & cp_mi_sing_sgen_pallas::skipto_pallas_start_done);
  skipto::add("pallas_end", & cp_mi_sing_sgen_pallas::skipto_pallas_end_init, "Pallas Death", & cp_mi_sing_sgen_pallas::skipto_pallas_end_done);
  skipto::function_d68e678e("twin_revenge", & cp_mi_sing_sgen_revenge_igc::skipto_revenge_init, "Twin Revenge", & cp_mi_sing_sgen_revenge_igc::skipto_revenge_done);
  skipto::function_d68e678e("flood_combat", & cp_mi_sing_sgen_flood::skipto_flood_init, "Flood Combat", & cp_mi_sing_sgen_flood::skipto_flood_done);
  skipto::function_d68e678e("flood_defend", & cp_mi_sing_sgen_flood::skipto_flood_defend_init, "Flood Defend", & cp_mi_sing_sgen_flood::skipto_flood_defend_done);
  skipto::function_d68e678e("underwater_battle", & cp_mi_sing_sgen_uw_battle::skipto_underwater_init, "Underwater Battle", & cp_mi_sing_sgen_uw_battle::skipto_underwater_done);
  skipto::function_d68e678e("underwater_rail", & cp_mi_sing_sgen_water_ride::skipto_underwater_rail_init, "Underwater Rail", & cp_mi_sing_sgen_water_ride::skipto_underwater_rail_done);
  skipto::function_d68e678e("silo_swim", & cp_mi_sing_sgen_silo_swim::skipto_silo_swim_init, "Silo Swim", & cp_mi_sing_sgen_silo_swim::skipto_silo_swim_done);
  skipto::add_dev("dev_flood_combat", & cp_mi_sing_sgen_flood::skipto_flood_init, "Flood Combat", & cp_mi_sing_sgen_flood::skipto_flood_done);
}

function precache() {
  level._effect["current_effect"] = "debris/fx_debris_underwater_current_sgen_os";
  level._effect["decon_mist"] = "steam/fx_steam_decon_fill_elevator_sgen";
  level._effect["drone_breadcrumb"] = "light/fx_temp_glow_cookie_crumb_sgen";
  level._effect["drone_sparks"] = "destruct/fx_dest_drone_mapper";
  level._effect["red_flare"] = "light/fx_light_emergency_flare_red";
  level._effect["water_spout"] = "water/fx_water_leak_torrent_md";
  level._effect["coolant_fx"] = "fog/fx_fog_coolant_jet_pallas_sgen";
  level._effect["fake_depth_charge_explosion"] = "explosions/fx_exp_underwater_depth_charge";
  level._effect["tidal_wave"] = "water/fx_temp_water_tidal_wave_sgen";
  level._effect["drone_splash"] = "water/fx_water_splash_25v25";
  level._effect["rock_explosion"] = "explosions/fx_exp_generic_lg";
  level._effect["coolant_tower_unleash"] = "fog/fx_fog_coolant_release_column_sgen";
  level._effect["coolant_tower_damage_minor"] = "fog/fx_fog_coolant_leak_md";
  level._effect["coolant_tower_damage_major"] = "fog/fx_fog_coolant_leak_lg";
  level._effect["depth_charge_explosion"] = "explosions/fx_exp_underwater_depth_charge";
  level._effect["underwater_flare"] = "light/fx_light_flare_ground_sgen";
  level._effect["weakspot_impact"] = "impacts/fx_bul_impact_metal_tower_core_sgen";
}

function init_clientfields() {
  clientfield::register("world", "w_fxa_truck_flip", 1, 1, "int");
  clientfield::register("world", "w_robot_window_break", 1, 2, "int");
  clientfield::register("world", "silo_swim_bridge_fall", 1, 1, "int");
  clientfield::register("world", "testing_lab_wires", 1, 1, "int");
  clientfield::register("world", "w_underwater_state", 1, 1, "int");
  clientfield::register("world", "w_flood_combat_windows_b", 1, 1, "int");
  clientfield::register("world", "w_flood_combat_windows_c", 1, 1, "int");
  clientfield::register("world", "elevator_light_probe", 1, 1, "int");
  clientfield::register("world", "flood_defend_hallway_flood_siege", 1, 1, "int");
  clientfield::register("world", "tower_chunks1", 1, 1, "int");
  clientfield::register("world", "tower_chunks2", 1, 1, "int");
  clientfield::register("world", "tower_chunks3", 1, 1, "int");
  clientfield::register("world", "observation_deck_destroy", 1, 1, "counter");
  clientfield::register("world", "fallen_soldiers_client_fxanims", 1, 1, "int");
  clientfield::register("world", "w_flyover_buoys", 1, 1, "int");
  clientfield::register("world", "w_twin_igc_fxanim", 1, 2, "int");
  clientfield::register("world", "set_exposure_bank", 1, 1, "int");
  clientfield::register("world", "silo_debris", 1, 3, "int");
  clientfield::register("world", "ceiling_collapse", 1, 3, "int");
  clientfield::register("world", "debris_catwalk", 1, 1, "counter");
  clientfield::register("world", "debris_wall", 1, 1, "counter");
  clientfield::register("world", "debris_fall", 1, 1, "counter");
  clientfield::register("world", "debris_bridge", 1, 1, "counter");
  clientfield::register("scriptmover", "structural_weakness", 1, 1, "int");
  clientfield::register("scriptmover", "sm_elevator_door_state", 1, 2, "int");
  clientfield::register("scriptmover", "sm_elevator_shader", 1, 2, "int");
  clientfield::register("scriptmover", "weakpoint", 1, 1, "int");
  clientfield::register("scriptmover", "sm_depth_charge_fx", 1, 2, "int");
  clientfield::register("scriptmover", "dni_eye", 1, 1, "int");
  clientfield::register("scriptmover", "turn_fake_robot_eye", 1, 1, "int");
  clientfield::register("scriptmover", "play_cia_robot_rogue_control", 1, 1, "int");
  clientfield::register("scriptmover", "cooling_tower_damage", 1, 1, "int");
  clientfield::register("toplayer", "pallas_monitors_state", 1, getminbitcountfornum(3), "int");
  clientfield::register("toplayer", "tp_water_sheeting", 1, 1, "int");
  clientfield::register("toplayer", "oed_interference", 1, 1, "int");
  clientfield::register("toplayer", "sndSiloBG", 1, 1, "int");
  clientfield::register("toplayer", "dust_motes", 1, 1, "int");
  clientfield::register("toplayer", "water_motes", 1, 1, "int");
  clientfield::register("toplayer", "water_teleport", 1, 1, "int");
  clientfield::register("vehicle", "extra_cam_ent", 1, 2, "int");
  clientfield::register("vehicle", "sm_depth_charge_fx", 1, 2, "int");
  clientfield::register("vehicle", "quad_tank_tac_mode", 1, 1, "int");
  clientfield::register("actor", "robot_bubbles", 1, 1, "int");
  clientfield::register("actor", "disable_tmode", 1, 1, "int");
  clientfield::register("actor", "sndStepSet", 1, 1, "int");
  clientfield::register("world", "sndLabWalla", 1, 1, "int");
  visionset_mgr::register_info("overlay", "earthquake_blur", 1, 50, 1, 1, & visionset_mgr::timeout_lerp_thread_per_player, 0);
}

function init_flags() {
  util::set_level_start_flag("start_level");
  load::function_73adcefc();
  level flag::init("important_vo_playing");
  level flag::init("exterior_start_patrol");
  level flag::init("hendricks_on_hill");
  level flag::init("start_vehicle_patrols");
  level flag::init("intro_igc_done");
  level flag::init("hendricks_intro_done");
  level flag::init("player_has_silenced_weap");
  level flag::init("start_technical");
  level flag::init("intro_truck_arrived");
  level flag::init("fallback_to_qt");
  level flag::init("hendricks_qt_reveal");
  level flag::init("intro_quadtank_dead");
  level flag::init("quad_tank_nag_vo_playing");
  level flag::init("quad_tank_trophy_system_destroyed");
  level flag::init("enemy_alerting_area");
  level flag::init("hendricks_at_lobby_idle");
  level flag::init("lobby_door_opening");
  level flag::init("lobby_door_opened");
  level flag::init("silo_door_opened");
  level flag::init("data_discovered");
  level flag::init("data_recovered");
  level flag::init("hendricks_move_to_under_fan");
  level flag::init("hendricks_corvus_examination");
  level flag::init("corvus_entrance_hendrick_idle_trigger");
  level flag::init("chem_door_open");
  level flag::init("player_raise_hendricks_player_ready");
  level flag::init("player_raise_hendricks_hendricks_ready");
  level flag::init("spawn_quadtank_reinforcements");
  level flag::init("start_hendricks_move_up_battle_1");
  level flag::init("start_hendricks_move_up_battle_2");
  level flag::init("gen_lab_cleared");
  level flag::init("hendricks_at_gen_lab_door");
  level flag::init("gen_lab_door_opened");
  level flag::init("bridge_collapse_safe");
  level flag::init("hendricks_door_line");
  level flag::init("spawn_quad_tank");
  level flag::init("enable_battle_volumes");
  level flag::init("pre_gen_lab_vo_done");
  level flag::init("qtank_fight_completed");
  level flag::init("mappy_path_active");
  level flag::init("hendricks_data_anim_done");
  level flag::init("hendricks_at_silo_doors");
  level flag::init("gen_lab_gone_hot");
  level flag::init("bridge_debris_player_kill");
  level flag::init("chem_lab_hendricks_movein_done");
  level flag::init("start_silo_ambush");
  level flag::init("start_floor_risers");
  level flag::init("all_players_outside_chem_lab");
  level flag::init("gen_lab_pip_off");
  level flag::init("exterior_gone_hot");
  level flag::init("hendricks_in_cqb");
  level flag::init("hendricks_in_gen_lab");
  level flag::init("drone_over_grate");
  level flag::init("drone_over_grate_real");
  level flag::init("drone_died");
  level flag::init("kane_data_callout");
  level flag::init("weapons_research_vo_start");
  level flag::init("weapons_research_vo_done");
  level flag::init("highlight_railing_glass");
  level flag::init("glass_railing_kicked");
  level flag::init("spawn_silo_robots");
  level flag::init("drone_silo_anim_done");
  level flag::init("drone_scanning");
  level flag::init("hendricks_at_silo_floor");
  level flag::init("send_drone_over_grate");
  level flag::init("silo_floor_cleared");
  level flag::init("silo_grate_open");
  level flag::init("pallas_intro_completed");
  level flag::init("pallas_start");
  level flag::init("pallas_end");
  level flag::init("core_two_destroyed");
  level flag::init("hendricks_attacked_done");
  level flag::init("tower_three_destroyed");
  level flag::init("dark_battle_hendricks_above");
  level flag::init("dark_battle_hendricks_ambush");
  level flag::init("pallas_ambush_over");
  level flag::init("fallen_soldiers_hendricks_ready");
  level flag::init("pallas_lift_front_open");
  level flag::init("pallas_lift_back_open");
  level flag::init("pallas_death");
  level flag::init("bridge_hit_1");
  level flag::init("bridge_hit_2");
  level flag::init("optics_out");
  level flag::init("defend_ready");
  level flag::init("hendricks_door_open");
  level flag::init("water_robot_spawned");
  level flag::init("pod_robot_spawned");
  level flag::init("depth_charges_cleared");
  level flag::init("player_raise_hendricks_hendricks");
  level flag::init("silo_swim_bridge_collapse");
  level flag::init("silo_swim_take_out");
  level flag::init("sgen_end_igc");
}

function level_threads() {
  a_t_mover = getentarray("t_mover", "targetname");
  array::thread_all(a_t_mover, & sgen_util::trig_mover);
  a_t_ev_on = getentarray("enhanced_vision_on", "targetname");
  a_t_ev_off = getentarray("enhanced_vision_off", "targetname");
  array::thread_all(a_t_ev_on, & function_5dd1ccff, 1);
  array::thread_all(a_t_ev_off, & function_5dd1ccff, 0);
  a_t_water = getentarray("water_movement_trigger", "targetname");
  array::thread_all(a_t_water, & water_movement);
  level thread silo_grate();
  level thread scale_rock_slide();
  level thread hide_show_fxanim_door_flood();
  level thread robot_oed_toggles();
}

function init_hendricks(str_objective) {
  if(str_objective == "intro" || str_objective == "exterior" || str_objective == "enter_lobby" || str_objective == "discover_data") {
    level.ai_hendricks = util::get_hero("hendricks_backpack");
  } else {
    level.ai_hendricks = util::get_hero("hendricks");
  }
  if(!issubstr(level.skipto_point, "dev_flood_combat")) {
    skipto::teleport_ai(str_objective);
  }
}

function robot_oed_toggles() {
  for (x = 2; x < 4; x++) {
    scene::add_scene_func("cin_sgen_15_04_robot_ambush_aie_arise_robot0" + x, & enhanced_vision_entity_off, "init");
    scene::add_scene_func("cin_sgen_15_04_robot_ambush_aie_arise_robot0" + x, & enhanced_vision_entity_on, "play");
  }
  for (x = 1; x < 5; x++) {
    scene::add_scene_func("cin_sgen_13_01_robots_awaken_aie_awake_robot0" + x, & enhanced_vision_entity_off, "init");
    scene::add_scene_func("cin_sgen_13_01_robots_awaken_aie_awake_robot0" + x, & enhanced_vision_entity_on, "play");
  }
  for (x = 1; x < 5; x++) {
    scene::add_scene_func("cin_sgen_12_02_corvus_vign_wakeup_rail_robot_0" + x, & enhanced_vision_entity_off, "init");
    scene::add_scene_func("cin_sgen_12_02_corvus_vign_wakeup_rail_robot_0" + x, & enhanced_vision_entity_on, "play");
  }
  scene::add_scene_func("cin_sgen_16_01_charging_station_aie_idle_robot01", & enhanced_vision_entity_off, "init");
  scene::add_scene_func("cin_sgen_16_01_charging_station_aie_idle_robot01", & enhanced_vision_entity_off, "play");
  scene::add_scene_func("cin_sgen_16_01_charging_station_aie_fail_robot01", & enhanced_vision_entity_off, "init");
  scene::add_scene_func("cin_sgen_16_01_charging_station_aie_fail_robot01", & enhanced_vision_entity_off, "play");
  for (x = 1; x < 7; x++) {
    scene::add_scene_func("cin_sgen_16_01_charging_station_aie_awaken_robot0" + x, & enhanced_vision_entity_on, "play");
  }
  scene::add_scene_func("cin_sgen_16_01_charging_station_aie_awaken_robot05_jumpdown", & enhanced_vision_entity_on, "play");
}

function lift_pillar_cover_pallas() {
  e_pillars = getentarray("diaz_tower_1", "targetname");
  foreach(pillar in e_pillars) {
    pillar movez(106, 0.05);
  }
}

function on_player_spawned() {
  if(level flag::get("optics_out")) {
    level thread function_5dd1ccff(0, 0, self);
  }
}

function silo_grate() {
  level flag::wait_till("silo_grate_open");
  a_blockers = getentarray("silo_floor_clip", "targetname");
  array::run_all(a_blockers, & delete);
  level flag::wait_till("silo_swim");
  a_blockers = getentarray("silo_grate", "targetname");
  array::run_all(a_blockers, & delete);
}

function pull_out_last_weapon() {
  if(isdefined(self.lastactiveweapon) && self.lastactiveweapon != level.weaponnone && self hasweapon(self.lastactiveweapon)) {
    self switchtoweapon(self.lastactiveweapon);
  } else {
    primaryweapons = self getweaponslistprimaries();
    if(isdefined(primaryweapons) && primaryweapons.size > 0) {
      self switchtoweapon(primaryweapons[0]);
    }
  }
}

function function_5dd1ccff(b_enable, b_use_trig = 1, e_player) {
  level endon("descent");
  while (true) {
    if(b_use_trig) {
      self waittill("trigger", e_player);
    }
    if(!isdefined(e_player.b_tactical_mode_enabled)) {
      e_player.b_tactical_mode_enabled = level.b_tactical_mode_enabled;
    }
    var_154f55d0 = e_player.b_tactical_mode_enabled;
    if(!b_enable) {
      level flag::set("optics_out");
      e_player oed::enable_tac_mode(0);
      e_player oed::enable_ev(0);
      if(isdefined(e_player.cybercom.is_primed) && e_player.cybercom.is_primed) {
        e_player player::take_weapons();
        e_player player::give_back_weapons();
      }
      e_player cybercom::disablecybercom();
      e_player cybercom_tacrig::function_ccca7010("cybercom_playermovement");
      if(b_enable != var_154f55d0) {
        util::show_event_message(e_player, & "CP_MI_SING_SGEN_VISION_INTERFERENCE");
      }
    } else {
      level flag::clear("optics_out");
      e_player oed::enable_tac_mode(1);
      e_player oed::enable_ev(1);
      e_player cybercom::enablecybercom();
      var_11f40d11 = e_player cybercom::function_cc812e3b("cybercom_playermovement");
      e_player cybercom_tacrig::giverigability("cybercom_playermovement", var_11f40d11);
      if(b_enable != var_154f55d0) {
        util::show_event_message(e_player, & "CP_MI_SING_SGEN_VISION_RESTORED");
      }
    }
    if(!b_use_trig) {
      return;
    }
  }
}

function enhanced_vision_entity_off(a_ents) {
  if(isai(self)) {
    self.ignoreme = 1;
    self oed::disable_thermal();
    self disableaimassist();
  }
  if(isdefined(a_ents)) {
    array::thread_all(a_ents, & enhanced_vision_entity_off);
  }
}

function enhanced_vision_entity_on(a_ents) {
  if(isai(self)) {
    self.ignoreme = 0;
    self oed::enable_thermal();
    self enableaimassist();
  }
  if(isdefined(a_ents)) {
    array::thread_all(a_ents, & enhanced_vision_entity_on);
  }
}

function water_movement() {
  while (true) {
    self waittill("trigger", e_player);
    if(!(isdefined(e_player.is_in_water) && e_player.is_in_water)) {
      self thread water_movement_player(e_player);
    }
  }
}

function water_movement_player(e_player) {
  e_player endon("death");
  self endon("death");
  e_player.is_in_water = 1;
  e_player setmovespeedscale(0.7);
  e_player allowprone(0);
  while (e_player istouching(self)) {
    wait(0.1);
  }
  e_player allowprone(1);
  e_player setmovespeedscale(1);
  e_player.is_in_water = 0;
}

function scale_rock_slide() {
  m_rocks = getentarray("silo_rock_slide", "targetname");
  array::run_all(m_rocks, & setscale, 2);
}

function script_tag_align_create(str_name, n_index = 0) {
  a_s_align = struct::get_array(str_name, "targetname");
  s_align = spawnstruct();
  s_align.origin = a_s_align[n_index].origin;
  s_align.angles = a_s_align[n_index].angles;
  s_align.targetname = str_name + "_script";
  level.struct_class_names["targetname"][str_name + "_script"] = array(s_align);
}

function hide_show_fxanim_door_flood() {
  e_door_clip = getent("flood_door_player_clip", "targetname");
  e_door_clip movez(128, 0.05);
  level thread sgen_util::set_door_state("surgical_room_entrance_door", "open");
}