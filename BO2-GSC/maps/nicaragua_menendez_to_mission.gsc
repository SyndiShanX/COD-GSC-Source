/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_menendez_to_mission.gsc
**************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\_turret;
#include maps\nicaragua_menendez_rage;
#include maps\_fxanim;

skipto_menendez_to_mission() {
  skipto_teleport_players("player_skipto_menendez_to_mission");
  exploder(20);
  exploder(101);
  exploder(330);
  battlechatter_on("axis");
  level.player setclientdvar("cg_aggressiveCullRadius", 495);
  model_removal_through_model_convert_system("menendez_lower_village");
  model_restore_area("menendez_execution");
  model_restore_area("menendez_stables_and_upper_village");
  model_convert("destructible_cocaine_bundles", "script_noteworthy");
  destructibles_in_area("menendez_execution");
  destructibles_in_area("menendez_stables_and_upper_village");
}

main() {
  debug_print_line("Nicaragua To Mission");
  autosave_by_name("nicaragua_menendez_to_mission");
  init_flags();
  init_spawn_functions();
  level thread nicaragua_to_mission_objectives();
  level thread nicaragua_to_mission_vo();
  maps\_fxanim::fxanim_reconstruct("fxanim_gate_crash");
  level thread balcony_throw();
  trigger_wait("courtyard_truck_arrives");
  event_cleanup();
}

balcony_throw() {
  run_scene_first_frame("balcony_throw");
  trigger_wait("trig_balcony_throw");
  s_haycart_dest = getstruct("struct_mm_haycart_dest", "targetname");
  level.player waittill_player_looking_at(s_haycart_dest.origin, 45, 0);
  level thread run_scene("balcony_throw");
  flag_wait("balcony_throw_started");
  ai_civ = get_ais_from_scene("balcony_throw", "balcony_throw_civ");
  ai_civ thread balcony_throw_destruction(s_haycart_dest);
  scene_wait("balcony_throw");
  ai_pdf = get_ais_from_scene("balcony_throw", "balcony_throw_pdf");

  if(isalive(ai_pdf))
    ai_pdf setgoalpos(ai_pdf.origin);
}

balcony_throw_destruction(s_haycart_dest) {
  while(isDefined(self))
    wait 0.05;

  radiusdamage(s_haycart_dest.origin, 32, 1, 1);
}

haycart_anim() {
  trigger_wait("trig_haycart");
  run_scene("hay_cart_scene");
}

init_flags() {
}

init_spawn_functions() {
  add_spawn_function_veh("cartel_courtyard_truck", ::courtyard_truck_spawn_func);
  sp_truck_gunner = get_ent("cartel_courtyard_truck_gunner", "targetname", 1);
  sp_truck_gunner add_spawn_function(::func_spawn_truck_gunner);
  sp_truck_driver = get_ent("cartel_courtyard_truck_driver", "targetname", 1);
  sp_truck_driver add_spawn_function(::func_spawn_truck_driver);
  add_global_spawn_function("axis", ::spawner_set_cleanup_category, "menendez_to_mission");
}

event_cleanup() {
  remove_global_spawn_function("axis", ::spawner_set_cleanup_category);
  spawn_manager_cleanup("menendez_to_mission_spawn_managers");
  kill_spawnernum(4);
}

nicaragua_to_mission_objectives() {
  e_trigger = getent("objective_to_mission_part1_trigger", "targetname");
  str_struct_name = e_trigger.target;
  s_struct = getstruct(str_struct_name, "targetname");
  set_objective(level.obj_menendez_save_josefina, s_struct, "");
  e_trigger waittill("trigger");
  set_objective(level.obj_menendez_save_josefina, undefined, "remove");
  wait 0.5;
  e_trigger = getent("objective_to_mission_part2_trigger", "targetname");
  str_struct_name = e_trigger.target;
  s_struct = getstruct(str_struct_name, "targetname");
  set_objective(level.obj_menendez_save_josefina, s_struct, "");
}

nicaragua_to_mission_vo() {
  trigger_wait("trig_balcony_throw");
  a_cartels = getaiarray("allies");
  ai_cartel = get_closest_living(level.player.origin, a_cartels);

  if(isalive(ai_cartel))
    ai_cartel say_dialog("crt0_menendez_are_you_0");

  wait 1;
  rage_mode_important_vo("mene_josefina_i_have_0");
  wait 1;
  a_cartels = getaiarray("allies");
  ai_cartel = get_closest_living(level.player.origin, a_cartels);

  if(isalive(ai_cartel))
    ai_cartel say_dialog("crt0_you_heard_him_push_0");
}

stables_exit_anim_setup() {
  a_cartels = simple_spawn("cartel_stables_exit");

  foreach(ai_cartel in a_cartels) {
    ai_cartel.goalradius = 16;
    ai_cartel magic_bullet_shield();
  }

  trigger_wait("stables_exit_trigger");

  foreach(ai_cartel in a_cartels)
  ai_cartel stop_magic_bullet_shield();
}

stables_exit_anim() {
}

func_spawn_stables_exit_door_blocker() {
  self.deathfunction = ::stables_exit_delete_clip;
}

stables_exit_delete_clip() {
  level notify("stables_exit_open");
}