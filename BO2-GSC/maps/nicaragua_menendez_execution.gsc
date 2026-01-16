/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_menendez_execution.gsc
*************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\nicaragua_menendez_rage;
#include maps\_fxanim;

skipto_menendez_execution() {
  skipto_teleport_players("menendez_execution_skipto");
  exploder(20);
  exploder(101);
  exploder(320);
  exploder(323);
  battlechatter_on("axis");
  level.player setclientdvar("cg_aggressiveCullRadius", 495);
  maps\_fxanim::fxanim_reconstruct("fxanim_bridge_drop");
  model_restore_area("menendez_lower_village");
  model_restore_area("menendez_execution");
  model_convert("destructible_cocaine_bundles", "script_noteworthy");
  destructibles_in_area("menendez_lower_village");
  destructibles_in_area("menendez_execution");
}

skipto_dev_menendez_execution() {
  skipto_teleport_players("menendez_execution_skipto");
  level.str_rage_on = 0;
  exploder(101);
  exploder(320);
  exploder(323);
  level.player rage_disable();
  level.player setclientdvar("cg_aggressiveCullRadius", 495);
}

init_flags() {
  flag_init("villagers_executed");
  flag_init("player_grabbed_axe");
  flag_init("village_execution_axe_logic_done");
  flag_init("menendez_execution_area_done");
  flag_init("execution_start");
  flag_init("execution_molotov_fire_allow");
  flag_init("end_execution");
}

init_spawn_functions() {
}

main() {
  init_flags();
  init_spawn_functions();
  exploder(320);
  exploder(323);
  level.player thread close_shed_door();
  execution_scene();
  level thread nicaragua_execution_objectives();
  level thread menendez_execution_vo();
  level thread brutality_scene(1, "anim_before_stables_brutality", "generic_civ_male", "generic_pdf", "trig_before_stables_brutality", "objective_stables_gate_trigger", "vol_execution_civ");
  level thread menendez_chickens_setup();
  flag_wait("menendez_execution_area_done");
  event_cleanup();
}

menendez_chickens_setup() {
  a_chickens = getentarray("menendez_chicken", "targetname");

  foreach(m_chicken in a_chickens)
  m_chicken thread chicken_anim_loop();
}

menendez_execution_vo() {
  level thread menendez_execution_intro_vo();
  level thread menendez_execution_after_rage_vo();
  level thread menendez_execution_near_stables_vo();
}

menendez_execution_intro_vo() {
  level endon("execution_start");
  level endon("end_execution");
  trigger_wait("objective_middle_village_trigger", "script_noteworthy");
  a_executioners = getentarray("village_executioner", "script_noteworthy");
  ai_pdf = get_closest_living(level.player.origin, a_executioners);
  ai_pdf say_dialog("pdf1_get_on_your_knees_0");
  wait 1;
  a_execution_civs = getentarray("execution_villagers", "script_noteworthy");
  ai_civ = get_closest_living(level.player.origin, a_execution_civs);
  ai_civ say_dialog("cf6_please_let_us_go_w_0");
  wait 1;
  a_executioners = getentarray("village_executioner", "script_noteworthy");
  ai_pdf = get_closest_living(level.player.origin, a_executioners);
  ai_pdf say_dialog("pdf1_liar_you_are_part_0");
  wait 1;
  a_execution_civs = getentarray("execution_villagers", "script_noteworthy");
  ai_civ = get_closest_living(level.player.origin, a_execution_civs);
  ai_civ say_dialog("cf7_i_beg_you_have_mer_0");
  wait 1;
  a_executioners = getentarray("village_executioner", "script_noteworthy");
  ai_pdf = get_closest_living(level.player.origin, a_executioners);
  ai_pdf say_dialog("pdf1_ready_men_beat_f_0");
}

menendez_execution_after_rage_vo() {
  flag_wait_either("execution_start", "end_execution");
  flag_wait("rage_off");
  wait 1;
  a_enemeies = getaiarray("axis");
  ai_enemy = get_closest_living(level.player.origin, a_enemeies);
  ai_enemy say_dialog_and_waittill_death("pdf1_we_have_orders_to_de_0");
  a_enemeies = getaiarray("axis");
  ai_enemy = get_closest_living(level.player.origin, a_enemeies);

  if(isalive(ai_enemy))
    ai_enemy say_dialog("pdf2_drop_your_weapons_0");

  wait 1;

  if(isalive(ai_enemy))
    ai_enemy say_dialog_and_waittill_death("pdf2_i_said_drop_your_wea_0");
}

menendez_execution_near_stables_vo() {
  flag_wait("menendez_execution_area_done");
  flag_clear("rage_weapon_fire_audio_on");
  rage_mode_important_vo("jose_where_are_you_raul_1");
  wait 2;
  rage_mode_important_vo("mene_josefina_hold_on_i_0");
  level thread rage_weapon_fire_vo_on();
}

event_cleanup() {
  kill_spawnernum(2);
}

close_shed_door() {
  trigger_wait("trig_execution");
  s_door = getstruct("can_see_shed_door", "targetname");

  while(is_player_looking_at(s_door.origin, 0) || self.origin[1] > 6272)
    wait 0.05;

  m_door = getent("shed_door", "targetname");
  m_door ignorecheapentityflag(1);
  m_door setscale(1.145);
  m_door.angles = vectorscale((0, 1, 0), 90.0);
  m_door.origin = (-5408, 6344, 1018);
  wait 0.15;
  m_door disconnectpaths();
  load_gump("nicaragua_gump_menendez");
  a_menendez_hill_ents = getentarray("menendez_hill", "script_noteworthy");

  foreach(e_menendez_hill in a_menendez_hill_ents)
  e_menendez_hill delete();

  a_ai = getaiarray();

  foreach(ai_alive in a_ai) {
    if(ai_alive.origin[1] > 6400)
      ai_alive delete();
  }

  model_delete_area("menendez_lower_village");
  model_restore_area("menendez_stables_and_upper_village");
  destructibles_in_area("menendez_stables_and_upper_village");
  run_scene_first_frame("barn_doors");
  maps\_fxanim::fxanim_reconstruct("fxanim_barn_explode_01");
  maps\_fxanim::fxanim_reconstruct("fxanim_barn_explode_02");
}

connect_roof_watcher_path() {
  level thread connect_roof_watcher_path_by_ai_group_count();
  flag_wait_either("execution_start", "end_execution");
  level waittill_either("one_execution_pdf_left", "rage_off");
  m_path_clip = getent("roof_watcher_path_clip", "targetname");
  m_path_clip disconnectpaths();
  m_path_clip delete();
  level notify("execution_about_done");
  wait 0.15;
  ai_roof = get_ais_from_scene("execution_watchers_idle", "roof_pdf");

  if(isalive(ai_roof)) {
    nd_goal = getnode("roof_watcher_goal", "targetname");
    ai_roof setgoalnode(nd_goal);
  }
}

connect_roof_watcher_path_by_ai_group_count() {
  waittill_ai_group_ai_count("execution_pdfs", 1);
  level notify("one_execution_pdf_left");
}

execution_scene() {
  level thread run_scene("axe_attack_pdf_loop");
  level thread run_scene("execution_loop");
  level thread run_scene("execution_molotv_idle");
  level thread run_scene("execution_watchers_idle");
  flag_wait("execution_loop_started");

  for(i = 1; i <= 5; i++)
    level thread execution_logic(i);

  level thread execution_start_timer();
  level thread execution_stop_by_spotted();
  level thread connect_roof_watcher_path();
  level.player thread execution_stop_by_firing();
  level.player thread execution_rage();
  level clientnotify("off_frst_walla");

  if(is_mature())
    level.player thread wait_axe_grab();
  else
    level thread execution_non_mature_objective();
}

execution_non_mature_objective() {
  trigger_wait("objective_middle_village_trigger", "script_noteworthy");
  s_obj_execution = getstruct("obj_execution", "targetname");
  set_objective(level.obj_menendez_axe, s_obj_execution, "");
  t_axe = getent("trig_axe", "targetname");
  t_axe delete();
  flag_wait_either("execution_start", "end_execution");
  set_objective(level.obj_menendez_axe, undefined, "delete");
}

execution_logic(n_index) {
  if(n_index == 5)
    ai_pdf = get_ais_from_scene("axe_attack_pdf_loop", "execution_pdf_" + n_index);
  else
    ai_pdf = get_ais_from_scene("execution_loop", "execution_pdf_" + n_index);

  flag_wait_either("execution_start", "end_execution");
  ai_civ = get_ais_from_scene("execution_loop", "execution_civ_" + n_index);
  ai_civ.a.deathforceragdoll = 1;

  if(flag("end_execution")) {
    if(isalive(ai_civ)) {
      run_scene("execution_escape_" + n_index);
      ai_civ thread execution_escape();
    }
  } else {
    if(isalive(ai_civ))
      level thread run_scene("execution_civ_" + n_index);

    if(isalive(ai_pdf))
      run_scene("execution_pdf_" + n_index);
  }

  if(isalive(ai_pdf) && ai_pdf.animname == "execution_pdf_4")
    ai_pdf thread run_away("pd4_node");

  if(isalive(ai_pdf) && ai_pdf.animname == "execution_pdf_1") {
    ai_pdf.a.deathforceragdoll = 1;
    ai_pdf.b_not_part_of_rage = 1;
    run_scene("slide_to_cover");

    if(isalive(ai_pdf))
      ai_pdf.b_not_part_of_rage = undefined;
  }
}

run_away(str_node) {
  self endon("death");
  nd_target = getnode(str_node, "targetname");
  self setgoalnode(nd_target);
  self disable_tactical_walk();
  self.goalradius = 16;
}

execution_escape() {
  self endon("death");
  self set_goalradius(128);
  self set_ignoreme(0);
  self.enemyaccuracy = 0.6;
  v_execution_civ_goal = get_ent("vol_execution_civ", "targetname", 1);
  self setgoalvolumeauto(v_execution_civ_goal);
  self waittill("goal");
  level.n_civilians_saved++;
  self die();
}

execution_start_timer() {
  level endon("stop_execution_timer");
  trigger_wait("trig_near_execution");
  wait 7;
  flag_set("execution_start");
  run_execution_watcher_scenes();
}

execution_stop_by_spotted() {
  trigger_wait("trig_execution_spotted");
  execution_end();
}

execution_stop_by_firing() {
  trigger_wait("trig_execution");
  self waittill_any("weapon_fired", "grenade_fire");
  execution_end();
}

execution_rage() {
  trigger_wait("trig_near_execution");
  self rage_medium();
  flag_wait_either("execution_start", "end_execution");

  if(!flag("axe_attack_player_started"))
    level thread rage_mode_important_vo("mene_animals_0");

  self rage_high(1);

  if(flag("axe_attack_player_started"))
    level thread rage_high_logic("execution_pdfs");
  else
    level thread rage_high_logic("execution_pdfs", 1);
}

wait_axe_grab() {
  level endon("execution_start");
  level endon("end_execution");
  run_scene_first_frame("axe_attack_prop");
  trigger_wait("objective_middle_village_trigger", "script_noteworthy");
  s_axe_obj = getstruct("obj_axe", "targetname");
  set_objective(level.obj_menendez_axe, s_axe_obj, "use");
  t_axe = getent("trig_axe", "targetname");
  t_axe sethintstring(&"NICARAGUA_RAGE_MELEE_PROMPT");
  t_axe thread axe_cleanup();
  trigger_wait("trig_axe");
  level thread axe_scene();
}

axe_cleanup() {
  level waittill_any("stop_execution_timer", "execution_start", "end_execution");
  self delete();
  set_objective(level.obj_menendez_axe, undefined, "delete");
}

axe_scene() {
  level thread execution_stop_timer_for_axe_scene();
  ai_pdf = get_ais_from_scene("axe_attack_pdf_loop", "execution_pdf_5");

  if(isalive(ai_pdf))
    ai_pdf thread axe_blood_splat();

  level thread run_scene("axe_attack_prop");
  level thread run_scene("axe_attack_pdf");
  run_scene("axe_attack_player");
  level.player thread menendez_cleanup_after_anim();
}

axe_vo() {
  wait 1;
  rage_mode_important_vo("mene_rage_mode_axe_thro_0");
  wait 1;
  rage_mode_important_vo("mene_filthy_soulless_0");
}

axe_blood_splat() {
  wait 2;

  if(is_mature())
    self maps\nicaragua_menendez_rage::blood_splat_logic(1);
}

execution_stop_timer_for_axe_scene() {
  level notify("stop_execution_timer");
  level thread axe_vo();
  wait 2;
  execution_end();
}

execution_end() {
  flag_set("end_execution");

  if(!flag("execution_start")) {
    if(!flag("axe_attack_player_started"))
      end_scene("axe_attack_pdf_loop");

    end_scene("execution_loop");
  }

  run_execution_watcher_scenes();
}

run_execution_watcher_scenes() {
  ai_roof = get_ais_from_scene("execution_watchers_idle", "roof_pdf");

  if(isalive(ai_roof) && !flag("execution_watcher_react_roof_started"))
    level thread run_scene("execution_watcher_react_roof");

  ai_molotov = get_ais_from_scene("execution_watchers_idle", "molotov_pdf");

  if(isalive(ai_molotov) && !flag("execution_watcher_react_molotov_started")) {
    level thread run_scene("execution_molotv_react");
    level thread run_scene("execution_watcher_react_molotov");
    level thread allow_to_catch_on_fire();
    ai_molotov thread delete_molotov_when_dead();
  }

  end_scene("execution_molotv_idle");
}

allow_to_catch_on_fire() {
  wait 3;
  flag_set("execution_molotov_fire_allow");
}

delete_molotov_when_dead() {
  self waittill("death");

  if(!flag("execution_molotov_fire_allow"))
    end_scene("execution_molotv_react");
}

nicaragua_execution_objectives() {
  level waittill("execution_about_done");
  e_trigger = getent("objective_stables_gate_trigger", "targetname");
  str_struct_name = e_trigger.target;
  s_struct = getstruct(str_struct_name, "targetname");
  set_objective(level.obj_menendez_save_josefina, s_struct, "");
  e_trigger waittill("trigger");
  set_objective(level.obj_menendez_save_josefina, undefined, "remove");
  flag_set("menendez_execution_area_done");
}

func_spawn_pdf_execution_grounds(e_volume) {
  self endon("death");
  self set_pacifist(1);
  self set_ignoreall(1);
  n_old_radius = self.goalradius;
  self set_goalradius(2);
  flag_wait("villagers_executed");
  wait 6;
  self set_ignoreall(0);
  self set_goalradius(n_old_radius);
  self setgoalvolumeauto(e_volume);
  self waittill("goal");
  self set_pacifist(0);
}