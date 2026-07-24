/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titanjackal\titanjackal.gsc
*******************************************************/

main() {
  scripts\sp\utility::_id_116CB("titanjackal");
  scripts\sp\maps\titanjackal\titanjackal_anim::main();
  scripts\sp\maps\titanjackal\gen\titanjackal_art::main();
  scripts\sp\maps\titan\titan_fx::main();
  scripts\sp\maps\titan\titan_precache::main();
  scripts\sp\maps\titanjackal\titanjackal_audio::main();
  scripts\sp\utility::_id_1749("jackal_arena_begin", scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A086, "Jackal Arena Begin", scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A084, ["titanjackal_prime_tr", "titan_jackal_refinery_tr"], scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A085);
  scripts\sp\utility::_id_1749("jackal_first_building", scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A08A, "Jackal: First Building", scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A089, ["titanjackal_prime_tr", "titan_jackal_refinery_tr"], scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A088);
  scripts\sp\utility::_id_1749("landed_turbine", scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A7D2, "Jackal: First Building", scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A7D1, ["titanjackal_prime_tr", "titan_jackal_refinery_tr"], scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A7CE);
  scripts\sp\utility::_id_1749("jackal_second_building_exit", scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A094, "Jackal: Second Building Exit", scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A093, ["titanjackal_prime_tr", "titan_jackal_refinery_tr"], scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_A092);
  scripts\sp\utility::_id_1749("tower_destruction", scripts\sp\maps\titan\titan_hot_landing::_id_11A5A, "Tower Destruction", scripts\sp\maps\titan\titan_hot_landing::_id_11A58, ["titanjackal_prime_tr", "titan_jackal_refinery_tr"], scripts\sp\maps\titan\titan_hot_landing::_id_11A59);
  scripts\sp\utility::_id_1749("hot_landing", scripts\sp\maps\titan\titan_hot_landing::_id_90BA, "Hot Landing", scripts\sp\maps\titan\titan_hot_landing::_id_1196F, ["titanjackal_prime_tr", "titan_jackal_refinery_tr"], scripts\sp\maps\titan\titan_hot_landing::_id_90B8);
  scripts\sp\utility::_id_1749("turbine_dest_test", scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_12934);
  scripts\sp\utility::_id_16EB("aa_guns", &"TITANJACKAL_DESTROY_AA");
  scripts\sp\utility::_id_16EB("destroy_air_support", &"TITANJACKAL_DESTROY_AIR_SUPPORT");
  scripts\sp\utility::_id_16EB("destroy_ajak", &"TITANJACKAL_DESTROY_AJAK");
  scripts\sp\utility::_id_16EB("land_on_turbine", &"TITANJACKAL_LANDING_PAD");
  scripts\sp\utility::_id_16EB("turbine_button_hint", &"TITANJACKAL_TURBINE_BUTTON_HINT");
  scripts\sp\utility::_id_16EB("destroy_refinery_pipes", &"TITANJACKAL_DESTROY_REFINERY");
  scripts\sp\utility::_id_16EB("launch_hint", &"TITANJACKAL_JACKAL_LAUNCH_HINT", scripts\sp\maps\titan\titan_hot_landing::_id_AA7C);
  scripts\sp\utility::_id_16EB("jackal_return", &"TITANJACKAL_JACKAL_RETURN");
  precache();
  _id_9809();
  scripts\sp\maps\titanjackal\titanjackal_code::_id_969D();
  thread _id_ABE0();
  scripts\sp\load::main();
  var_0 = getEntArray("geyser_spawner", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\titanjackal\titanjackal_code::_id_8259);
  scripts\engine\utility::exploder("jackal_cloud_ceiling");
  scripts\engine\utility::exploder("fx_tower_red_beacon");
  scripts\engine\utility::exploder("fx_sunflare");
  scripts\sp\utility::_id_F44E(0);
  _id_0E4B::helmethud_on();
}

precache() {
  precacheturret("cap_turret_med");
  precacheturret("cap_turret_med_proj");
  precachemodel("jackal_arena_aa_turret");
  precacheitem("cap_turret_proj_weapon");
  precacheitem("magic_spaceship_20mm_bullet");
  precacheitem("cap_mons_projectile");
  precachemodel("veh_mil_ca_olympus_mons");
  precachemodel("vfx_destr_titan_fuelline_pipe_mid");
  precachemodel("vfx_destr_titan_fuelline_pipe_long");
  precachemodel("vfx_destr_titan_fuelline_pipe_small");
  precachemodel("vfx_destr_titan_fuelline_pipe_xl");
  precachemodel("viewmodel_base_animated_desert");
  precachemodel("body_hero_protagonist_vm_legs_desert");
  precachemodel("viewmodel_base_viewhands_iw7_desert");
  precachemodel("veh_mil_air_un_jackal_01_cockpit_glass_dmg_02");
  precachemodel("veh_mil_air_un_jackal_01_cockpit_glass_dmg_03");
  precachemodel("titan_jackal_window_armor_panel");
  precachemodel("tag_origin_animate");
  precachemodel("debris_gravity_module_01_part_00");
  precachemodel("fullbody_hero_eth3n");
  precachemodel("sdf_console_control_panel_08_rig");
  precacheshader("hud_offscreenobjectivepointer");
  precachemodel("vm_hero_protagonist_arms_torn");
  precachemodel("bridge_main_connector_01_destroyed_01");
  precachemodel("bridge_main_connector_01_destroyed_02");
  precachemodel("bridge_main_connector_01_destroyed_03");
  precachemodel("bridge_main_connector_01_destroyed_04");
  precachemodel("bridge_main_connector_01_destroyed_05");
  precachemodel("veh_mil_air_un_retribution_ftl_a");
  precachemodel("veh_mil_air_un_retribution_ftl_a_r");
  precachemodel("veh_mil_air_un_retribution_ftl_b");
  precachemodel("veh_mil_air_un_retribution_ftl_b_r");
  _id_0BDC::_id_D803("veh_mil_air_un_jackal_landed_01b_coll_only", (0, 0, -18));
}

_id_9809() {
  scripts\engine\utility::flag_init("hl_move_mons");
  scripts\engine\utility::flag_init("hl_mons_flak");
  scripts\engine\utility::flag_init("hl_mons_heavy_flak");
  scripts\engine\utility::flag_init("hl_mons_salvo_fire_bink");
  scripts\engine\utility::flag_init("hl_mons_flak_right_cleanup");
  scripts\engine\utility::flag_init("turbine_jackal_dead");
  scripts\engine\utility::flag_init("mons_jackal_blow");
  scripts\engine\utility::flag_init("mons_player_squeeze");
  scripts\engine\utility::flag_init("mons_chase");
  scripts\engine\utility::flag_init("retribution_go");
  scripts\engine\utility::flag_init("player_in_control");
  scripts\engine\utility::flag_init("flag_scipted_jackal_landing");
  scripts\engine\utility::flag_init("refinery_tower_destroyed");
  scripts\engine\utility::flag_init("flag_player_launched");
  scripts\engine\utility::flag_init("player_ending_launch_triggered");
  scripts\engine\utility::flag_init("control_room_clear");
  scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_963A();
  var_0 = ["titanjackal_prime_tr", "titan_jackal_refinery_tr"];

  foreach(var_2 in var_0) {
    scripts\engine\utility::flag_init(var_2 + "_loaded");
    scripts\engine\utility::flag_init(var_2 + "_unloaded");
  }
}

_id_ABE0() {
  _id_9659();
  _id_F4A5("OBJECTIVE_TOWER_1", "begin_dogfight", "refinery_tower_destroyed");
  _id_F4A5("OBJECTIVE_SKELTERS_1", "missile_boat_spawned", "jackals_retreated");
  _id_F4A5("OBJECTIVE_AJACK", "missile_boats_destroyed");
  scripts\engine\utility::flag_wait("jackals_retreated");
  _id_F4A5("OBJECTIVE_LAND", "player_has_landed_on_turbine");
  _id_F4A5("OBJECTIVE_SHIELDING", "turbine1_destroyed");
  _id_F4A5("OBJECTIVE_BOARD", "player_has_left_the_turbine");
  scripts\engine\utility::flag_wait("refinery_tower_destroyed");
  _id_F4A5("OBJECTIVE_RENDEZVOUS", "player_ending_launch_triggered");
}

_id_9659() {
  scripts\sp\utility::_id_C264("OBJECTIVE_TOWER_1");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_TOWER_1"), &"TITANJACKAL_OBJ_TOWER");
  scripts\sp\utility::_id_C264("OBJECTIVE_SKELTERS_1");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_SKELTERS_1"), &"TITANJACKAL_OBJ_SKELTERS");
  scripts\sp\utility::_id_C264("OBJECTIVE_AJACK");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_AJACK"), &"TITANJACKAL_OBJ_AJAK");
  scripts\sp\utility::_id_C264("OBJECTIVE_SKELTERS_2");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_SKELTERS_2"), &"TITANJACKAL_OBJ_SKELTERS");
  scripts\sp\utility::_id_C264("OBJECTIVE_LAND");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_LAND"), &"TITANJACKAL_OBJ_LAND");
  scripts\sp\utility::_id_C264("OBJECTIVE_SHIELDING");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_SHIELDING"), &"TITANJACKAL_OBJ_SHIELDING");
  scripts\sp\utility::_id_C264("OBJECTIVE_BOARD");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_BOARD"), &"TITANJACKAL_OBJ_BOARD");
  scripts\sp\utility::_id_C264("OBJECTIVE_TOWER_2");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_TOWER_2"), &"TITANJACKAL_OBJ_TOWER");
  scripts\sp\utility::_id_C264("OBJECTIVE_RENDEZVOUS");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_RENDEZVOUS"), &"TITANJACKAL_OBJ_RENDEZVOUS");
}

_id_F4A5(var_0, var_1, var_2) {
  objective_add(scripts\sp\utility::_id_C264(var_0), "current");

  if(isDefined(var_1)) {
    scripts\engine\utility::flag_wait(var_1);

    if(isDefined(var_2))
      thread _id_50F3(var_2, var_0);
    else
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264(var_0));
  }
}

_id_50F3(var_0, var_1) {
  scripts\engine\utility::flag_wait(var_0);
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264(var_1));
}