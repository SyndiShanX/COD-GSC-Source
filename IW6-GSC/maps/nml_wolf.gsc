/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nml_wolf.gsc
*****************************************************/

preload() {
  maps\_load::set_player_viewhand_model("viewhands_player_us_rangers");
  common_scripts\utility::flag_init("wolf_start_chase_dog");
  common_scripts\utility::flag_init("wolf_start_wolfpack");
  common_scripts\utility::flag_init("wolf_start_ghost_town");
  common_scripts\utility::flag_init("begin_wolf_attack");
  common_scripts\utility::flag_init("wolf_died");
  common_scripts\utility::flag_init("wolf_test");
  common_scripts\utility::flag_init("wolfpack_circle");
  common_scripts\utility::flag_init("wolf_dog_advance");
  common_scripts\utility::flag_init("wolf_prep_slide");
  common_scripts\utility::flag_init("wolf_hesh_slide");
  common_scripts\utility::flag_init("wolf_adam_stop");
  common_scripts\utility::flag_init("wolfpack_howl");
  common_scripts\utility::flag_init("wolfpack_pack");
  common_scripts\utility::flag_init("wolfpack_attack");
  common_scripts\utility::flag_init("wolf_ghost_stage");
  common_scripts\utility::flag_init("wolf_ghost_intro_go");
  common_scripts\utility::flag_init("ghost_town_combat_start");
  common_scripts\utility::flag_init("ghost_town_apcturn");
  common_scripts\utility::flag_init("ghost_town_apcpass");
  common_scripts\utility::flag_init("ghost_town_intro_dialog");
  common_scripts\utility::flag_init("ghost_town_gate_open");
  common_scripts\utility::flag_init("ghost_ambush_started");
  common_scripts\utility::flag_init("ghost_house_retreat");
  common_scripts\utility::flag_init("wolf_hesh_slide_done");
  common_scripts\utility::flag_init("merrick_scene_done");
}

main() {
  maps\_utility::array_spawn_function_targetname("wolf_2", maps\nml_wolf_code::wolf_init);
  maps\_utility::array_spawn_function_targetname("wolf_backup", maps\nml_wolf_code::wolf_init);
  maps\_utility::array_spawn_function_targetname("last_wolves", maps\nml_wolf_code::wolf_setup);
  maps\_utility::array_spawn_function_targetname("last_wolves_main", maps\nml_wolf_code::wolf_setup);
  maps\_utility::array_spawn_function_targetname("ghosttown_patrol", maps\nml_wolf_code::ghosttown_patrol_init);
  maps\_utility::array_spawn_function_targetname("end_heli_2", maps\nml_wolf_code::end_heli_2_think);
}

setup_chase_dog() {
  maps\nml_util::set_start_positions("start_chase_dog");
  level.baker maps\_stealth_utility::disable_stealth_system();
  level.dog maps\_stealth_utility::disable_stealth_system();
  common_scripts\utility::flag_set("wolf_start_chase_dog");
}

setup_wolfpack() {
  maps\nml_util::set_start_positions("start_wolfpack");
  level.baker maps\_stealth_utility::disable_stealth_system();
  level.dog maps\_stealth_utility::disable_stealth_system();
  maps\_stealth_utility::disable_stealth_system();
  common_scripts\utility::flag_set("wolf_hesh_slide_done");
}

setup_ghost_town() {
  maps\nml_util::spawn_merrick();
  maps\nml_util::spawn_keegan();
  level.baker maps\_stealth_utility::disable_stealth_system();
  level.dog maps\_stealth_utility::disable_stealth_system();
  maps\nml_util::set_start_positions("start_ghost_town");
  maps\nml_wolf_code::set_team_colors();
  level.heroes = [level.baker, level.keegan, level.merrick];
  common_scripts\utility::array_thread(level.heroes, maps\_utility::set_goalradius, 64);
  level.dog.script_color_delay_override = 3;
  level.baker.script_color_delay_override = 2;
  level.keegan.script_color_delay_override = 1;
  level.merrick.script_color_delay_override = 0;
}

setup_ascent() {
  level.baker maps\_stealth_utility::disable_stealth_system();
  level.dog maps\_stealth_utility::disable_stealth_system();
  maps\nml_util::spawn_merrick();
  maps\nml_util::spawn_keegan();
  maps\nml_util::set_start_positions("start_ascent");
}

setup_church() {
  maps\nml_util::set_start_positions("start_church");
}

start_chase_dog() {
  common_scripts\utility::flag_wait("wolf_start_chase_dog");
  var_0 = getaiarray("axis");
  common_scripts\utility::array_call(var_0, ::delete);
  var_1 = maps\_utility::getvehiclearray();
  common_scripts\utility::array_call(var_1, ::delete);
  maps\_utility::autosave_by_name("nml");
  var_2 = common_scripts\utility::get_target_ent("ravine_quake_trigger");
  var_2.script_soundalias = "elm_nml_quake";
  var_2 thread maps\nml_util::earthquake_trigger();
  thread maps\nml_wolf_code::chase_dog();
  thread maps\nml_wolf_code::chase_dog_dialogue();
}

start_wolfpack() {
  common_scripts\utility::flag_wait("wolf_start_wolfpack");
  thread maps\nml_wolf_code::wolfpack();
  thread maps\nml_wolf_code::wolfpack_cairo();
  thread maps\nml_wolf_code::wolfpack_hesh();
  thread maps\nml_wolf_code::wolfpack_circle();
  thread maps\nml_wolf_code::wolfpack_pack();
  thread maps\nml_wolf_code::wolf_event();
}

start_ghost_town() {
  common_scripts\utility::flag_wait("wolf_start_ghost_town");
  level.heroes = [level.baker, level.keegan, level.merrick];
  maps\nml_wolf_code::set_team_colors();
  thread maps\nml_wolf_code::ghost_town_sneak();
}

start_ascent() {}

start_church() {}