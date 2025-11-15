/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_evac.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_objectives;
#include maps\_scene;
#include maps\_turret;
#include maps\_vehicle;
#include maps\pakistan_util;
#include maps\pakistan_s3_util;
#include maps\_music;
#include maps\pakistan_warehouse;
#include maps\createart\pakistan_3_art;
#include maps\_audio;
#include maps\pakistan_evac;
#include maps\pakistan_3_anim;

skipto_hangar() {
  skipto_teleport("skipto_hangar");
  level.vh_player_soct = spawn_vehicle_from_targetname("player_soc_t");
  level.vh_player_soct get_player_on_soc_t();
  level.vh_player_soct veh_magic_bullet_shield(1);
  level.vh_player_soct thread watch_for_boost();
  level.vh_player_soct.driver = level.player;
  level.vh_player_soct.n_intensity_min = 0;
  level.player.overrideplayerdamage = ::player_damage_override;
  wait 0.05;
  clientnotify("enter_soct");
  level.vh_player_soct play_fx("soct_spotlight", level.vh_player_soct gettagorigin("tag_headlights"), level.vh_player_soct gettagangles("tag_headlights"), "remove_fx", 1, "tag_headlights");
  level.vh_apache = spawn_vehicle_from_targetname("boss_apache");
  level.player.vehicle_state = 1;
  level.player clearclientflag(15);
  onsaverestored_callback(::checkpoint_save_restored);
  purple_smoke();
  level.vh_player_soct setup_vehicle_regen();
  level.player_soct_test_for_water = 1;
  flag_set("player_drone_crashes_chain_reaction");

  if(-1)
    level thread maps\pakistan_warehouse::pak3_new_ending();
}

hangar_main() {
  init_faceburn();
  level thread hangar_approach_swap_to_soct();
  hanger_wait_for_player_to_enter();
  player_enters_hanger();
  wait 1000;
}

skipto_standoff() {
  skipto_teleport("skipto_standoff");
  level thread standoff();
  level thread assign_spotlight_to_end_scene();
  level thread standoff_ai_setup();
  purple_smoke();
  set_objective(level.obj_evac_point, getstruct("evac_point", "targetname"), "breadcrumb");
  level thread maps\createart\pakistan_3_art::standoff();
}

standoff_main() {
  iprintln("Standoff");

  wait 1000;
}

warehouse_cleanup() {
  a_enemies = getaiarray("axis");
  array_delete(a_enemies);
}

hangar_approach_swap_to_soct() {
  wait 0.1;

  if(isDefined(level.harper))
    level.harper thread say_dialog("harp_dammit_we_lost_the_0", 1);

  if(level.player.vehicle_state == 2) {
    flag_set("vehicle_can_switch");
    level.override_player_scot_node = "scot_swapto_node_at_end";
    level.player.viewlockedentity notify("change_seat");

    while(level.player.vehicle_state == 2)
      wait 0.05;

    flag_clear("vehicle_can_switch");
    pak3_kill_vehicle(level.vh_player_drone);
    level.vh_player_drone = undefined;
  }

  level notify("end_player_in_soct_fail");
  level notify("hanger_chase_started");

  if(-1)
    level thread collision_chain_reaction_hanger_effects_new_version();

  level.vh_player_soct set_turret_target_flags(0, 1);

  if(isDefined(level.vh_salazar_soct))
    level.vh_salazar_soct set_turret_target_flags(0, 1);

  if(does_super_soct_exist())
    level.vh_super_soct set_turret_target_flags(0, 1);
}

hanger_wait_for_player_to_enter() {
  e_trigger = getent("hanger_faceburn_trigger", "targetname");
  e_trigger waittill("trigger");
  level.player_reaches_hanger = 1;
}

init_faceburn() {
  level.player_reaches_hanger = 0;
  level.harper_face_burn = 0;
  level thread faceburn_volume_check();
}

faceburn_volume_check() {
  e_info_volume = getent("faceburn_info_volume", "targetname");

  while(true) {
    if(level.vh_player_soct istouching(e_info_volume)) {
      level thread harper_face_burned();
      break;
    }

    if(level.player_reaches_hanger == 1) {
      break;
    }

    wait 0.01;
  }

  e_info_volume delete();
}

harper_face_burned() {
  level.harper_face_burn = 1;
  earthquake(0.4, 2.0, level.vh_player_soct.origin, 512);

  for(i = 0; i < 10; i++) {
    level.player playrumbleonentity("damage_heavy");
    wait 0.1;
  }
}

#using_animtree("vehicles");
#using_animtree("generic_human");

player_enters_hanger() {
  flag_set("player_enters_hanger");
  set_objective(level.obj_evac_face_burn_point, undefined, "done");
  level.player freezecontrols(1);
  level notify("player_control_ends");
  level.vh_player_soct thread kill_boost_if_active();
  level.vh_player_soct showpart("tag_gunner_turret1");
  s_align = getstruct("chinese_standoff", "targetname");
  v_player_soct_start_pos = getstartorigin(s_align.origin, (0, 0, 0), % v_pakistan_9_4_standoff_approach_soct1);
  level.vh_player_soct setvehgoalpos(v_player_soct_start_pos, 0, 0);
  level.vh_player_soct setneargoalnotifydist(768);
  level.vh_player_soct thread lerp_vehicle_speed(level.vh_player_soct getspeedmph(), 119, 6);
  level.vh_player_soct waittill("near_goal");
  level.player freezecontrols(0);

  if(isDefined(level.harper))
    level.harper delete();

  if(isDefined(level.salazar))
    level.salazar delete();

  if(isDefined(level.han))
    level.han delete();

  level clientnotify("end_lvl");
  setmusicstate("PAKISTAN_BURNED");
  level thread maps\_audio::switch_music_wait("PAKISTAN_STANDOFF", 6);
  set_objective(level.obj_evac, undefined, "done");
  level thread warehouse_cleanup();
  wait 0.01;
  level thread standoff();
  level thread standoff_ai_setup();
  level thread stop_salazars_soct();
  level thread salazar_and_han_run_to_evac_point(7.0);
  level thread maps\pakistan_evac::assign_spotlight_to_end_scene(8);
  level thread hide_harper(0, undefined);

  if(does_super_soct_exist())
    pak3_kill_vehicle(level.vh_super_soct);

  level clientnotify("exit_vehicle");

  if(level.harper_face_burn == 1) {
    n_lerp_time = 0.65;
    level.player set_story_stat("HARPER_SCARRED", 1);
    str_player_scene = "standoff_approach_burned_player";
    str_soct_scene = "standoff_approach_soct";
    level thread run_scene("standoff_approach_burned_harper", n_lerp_time);
    level thread run_scene(str_player_scene, n_lerp_time);
    level thread run_scene(str_soct_scene, n_lerp_time);
    wait 0.1;
    level thread standoff_savepoint(str_soct_scene);
    level thread set_objective_when_player_ready(1, str_player_scene);
    level thread attach_steering_wheel();
    level.harper = getent("harper_ai", "targetname");
    level.harper set_ignoreall(1);
    level.harper set_ignoreme(1);
    level.harper thread say_dialog("harp_aargh_0");
    level.harper thread burn_harpers_face(1);
    level.vh_player_soct useby(level.player);
    level.player thread player_arms_transition(str_player_scene);
    scene_wait("standoff_approach_burned_player");
    level thread burned_dialog("sect_there_s_our_evac_sit_0", "harp_finally_0");
    s_align = getstruct("chinese_standoff", "targetname");
    v_harper_idle_pos = getstartorigin(s_align.origin, (0, 0, 0), % ch_pakistan_9_4_standoff_burned_idle_harper);
    str_harper_exit_scene = "harper_burned_walk";
  } else {
    n_lerp_time = 0.1;
    level.player set_story_stat("HARPER_SCARRED", 0);
    level.player giveachievement_wrapper("SP_STORY_HARPER_FACE");
    str_player_scene = "standoff_approach_not_burned_player";
    str_soct_scene = "standoff_approach_not_burned_soct";
    level thread run_scene("standoff_approach_not_burned_harper", n_lerp_time);
    level thread run_scene(str_player_scene, n_lerp_time);
    level thread run_scene(str_soct_scene, n_lerp_time);
    wait 0.1;
    level thread standoff_savepoint(str_soct_scene);
    level thread set_objective_when_player_ready(1, str_player_scene);
    level thread attach_steering_wheel();
    level.harper = getent("harper_ai", "targetname");
    level.harper set_ignoreall(1);
    level.harper set_ignoreme(1);
    level.harper thread say_dialog("harp_that_was_a_fucking_n_0");
    level.vh_player_soct useby(level.player);
    level.player thread player_arms_transition(str_player_scene);
    scene_wait("standoff_approach_not_burned_harper");
    level thread burned_dialog("sect_there_s_our_evac_sit_0", undefined);
    s_align = getstruct("chinese_standoff", "targetname");
    v_harper_idle_pos = getstartorigin(s_align.origin, (0, 0, 0), % ch_pakistan_9_4_standoff_idle_harper);
    str_harper_exit_scene = "harper_standoff_idle_not_burned";
  }

  level.vh_player_soct setvehgoalpos(level.vh_player_soct.origin, 0);
  level.vh_player_soct setspeedimmediate(0);
  level.vh_player_soct notify("remove_fx");
  level.vh_player_soct lights_off();

  if(level.harper_face_burn == 1)
    level.harper force_goal(v_harper_idle_pos, 16, 0);
  else
    level.harper force_goal(v_harper_idle_pos, 16, 0);

  level thread maps\createart\pakistan_3_art::standoff();
  wait 1000;
}

standoff_savepoint(str_scene) {
  scene_wait(str_scene);
  autosave_by_name("standoff_approach_savepoint");
}

set_objective_when_player_ready(delay, str_player_scene) {
  wait(delay);
  scene_wait(str_player_scene);
  set_objective(level.obj_evac_point, getstruct("evac_point", "targetname"), "breadcrumb");
}

burned_dialog(str_player, str_harper) {
  level.player say_dialog(str_player);

  if(isDefined(str_harper))
    level.harper say_dialog(str_harper);
}

attach_steering_wheel() {
  e_soct = getent("player_soc_t", "targetname");
  v_origin = e_soct gettagorigin("tag_steeringwheel");
  v_angles = e_soct gettagangles("tag_steeringwheel");
  e_wheel = spawn_model("veh_t6_mil_soc_t_steeringwheel", v_origin, v_angles);
  e_wheel linkto(e_soct, "tag_steeringwheel");
}

burn_harpers_face(delay) {
  wait(delay);
  maps\pakistan_3_anim::burn_harper_face(self);
}

player_arms_transition(str_player_scene) {
  scene_wait(str_player_scene);
  self notify("give_back_weapons");
  luinotifyevent(&"hud_expand_ammo", 0);
  wait 0.1;
  primaryweapons = self getweaponslistprimaries();
  self switchtoweapon(primaryweapons[0]);
  wait 0.1;
  self setlowready(1);
}

stop_salazars_soct() {
  if(isDefined(level.vh_salazar_soct)) {
    level.vh_salazar_soct notify("end_salazar_speed_control");
    wait 0.1;
    level.vh_salazar_soct setvehgoalpos(level.vh_salazar_soct.origin, 0);
    level.vh_salazar_soct setspeedimmediate(0);
    level.vh_salazar_soct setbrake(1);
  }
}

collision_chain_reaction_hanger_effects_new_version() {
  hanger_explodes_time = 1.3;
  level thread foreground_tower_collapses();
  flag_wait("player_drone_crashes_chain_reaction");
  wait 0.1;
  level thread chain_reaction_vo();
  start_exploder_number = 770;
  end_exploder_number = 778;

  for(i = start_exploder_number; i <= end_exploder_number; i++) {
    exploder(i);
    level.player playrumbleonentity("damage_light");
    delay = randomfloatrange(0.4, 0.45);
    wait(delay);
  }

  flag_wait("ending_player_blocker_moving");
  level thread explode_tower(0.01);
  level thread avoid_flames_dialog(1.3);
  start_exploder_number = 785;
  end_exploder_number = 788;

  for(i = start_exploder_number; i <= end_exploder_number; i++) {
    exploder(i);
    level.player playrumbleonentity("damage_light");
    delay = randomfloatrange(0.4, 0.45);
    wait(delay);
  }

  start_time = gettime();

  while(true) {
    time = gettime();
    dt = (time - start_time) / 1000;

    if(dt >= hanger_explodes_time) {
      break;
    }

    wait 0.01;
  }

  level thread explode_pipes(0.01);
  start_exploder_number = 779;
  end_exploder_number = 780;

  for(i = start_exploder_number; i <= end_exploder_number; i++) {
    exploder(i);
    level.player playrumbleonentity("damage_light");
    wait 0.2;
  }
}

chain_reaction_vo() {
  wait 2;

  if(isDefined(level.harper))
    level.harper thread say_dialog("harp_collision_s_started_0");

  wait 2;
  level.player thread say_dialog("sect_evac_point_s_up_ahea_0");
}

avoid_flames_dialog(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  if(isDefined(level.harper))
    level.harper thread say_dialog("harp_avoid_the_flames_0", delay);
}

explode_pipes(wait_time) {
  wait(wait_time);
  level notify("fxanim_pipes_fire_start");
}

explode_tower(wait_time) {
  wait(wait_time);
  level notify("fxanim_smokestack_collapse_start");
}

foreground_tower_collapses() {
  wait 0.5;
  level notify("fxanim_smokestack_collapse_01_start");
  wait 2.0;
  level notify("fxanim_smokestack_collapse_02_start");
}

standoff() {
  e_ent = getent("zhao_ending_friendly_chopper", "targetname");
  e_ent hidepart("tag_main_rotor_blur");
  e_ent hidepart("tag_tail_rotor_blur");
  str_main_scene = "standoff_chinese_important";
  level thread run_scene_first_frame(str_main_scene);
  wait 0.2;
  hide_scene_names(str_main_scene);
  trigger_wait("trigger_standoff");
  set_objective(level.obj_evac_point, undefined, "delete");
  setmusicstate("PAKISTAN_PLAYER_AT_STANDOFF");
  lerp_time = 0.2;
  level thread run_scene(str_main_scene, lerp_time);
  level thread run_scene("standoff", lerp_time);
  level thread run_scene("standoff_burned", lerp_time);
  flag_wait("standoff_started");
  scene_wait("standoff");
}

assign_spotlight_to_end_scene(delay) {
  if(isDefined(delay))
    wait(delay);

  if(isDefined(level.vh_player_soct))
    level.vh_player_soct notify("remove_fx");

  wait 0.1;
  exploder(799);
}

hide_scene_names(str_main_scene) {
  a_ai = get_ais_from_scene(str_main_scene);

  if(isDefined(a_ai)) {
    for(i = 0; i < a_ai.size; i++) {
      e_ent = a_ai[i];

      if(isDefined(e_ent.name))
        e_ent.name = "";
    }
  }
}

standoff_ai_setup() {
  num_seals = 10;

  for(i = 0; i < num_seals; i++) {
    ai_seal = simple_spawn_single("seal_team");
    s_spot = getstruct("seal_" + i, "targetname");

    if(i == 0) {
      add_scene_properties("soldier_idle_seal_1", s_spot.targetname);
      add_generic_ai_to_scene(ai_seal, "soldier_idle_seal_1");
      level thread run_scene("soldier_idle_seal_1");
      ai_seal thread soldier_stance("seal_1", s_spot.targetname);
      continue;
    }

    n_random = randomintrange(2, 4);
    add_scene_properties("soldier_idle_seal_" + n_random, s_spot.targetname);
    add_generic_ai_to_scene(ai_seal, "soldier_idle_seal_" + n_random);
    level thread run_scene("soldier_idle_seal_" + n_random);
    ai_seal thread soldier_stance("seal_" + n_random, s_spot.targetname);
  }

  num_chinese = 10;

  for(i = 0; i < num_chinese; i++) {
    ai_chinese = simple_spawn_single("chinese_force");
    s_spot = getstruct("chinese_" + i, "targetname");

    if(i == 0 || i == 1 || i == 2) {
      add_scene_properties("soldier_idle_chinese_3", s_spot.targetname);
      add_generic_ai_to_scene(ai_chinese, "soldier_idle_chinese_3");
      level thread run_scene("soldier_idle_chinese_3");
      ai_chinese thread soldier_stance("chinese_3", s_spot.targetname);
      continue;
    }

    n_random = randomintrange(1, 3);
    add_scene_properties("soldier_idle_chinese_" + n_random, s_spot.targetname);
    add_generic_ai_to_scene(ai_chinese, "soldier_idle_chinese_" + n_random);
    level thread run_scene("soldier_idle_chinese_" + n_random);
    ai_chinese thread soldier_stance("chinese_" + n_random, s_spot.targetname);
  }

  level notify("standoff_ai_setup_done");
}

soldier_stance(str_suffix, str_align_targetname) {
}

standoff_aim_chinese() {
  self endon("death");
  level waittill("standoff_ai_setup_done");

  while(true) {
    n_random = randomint(12);
    ai_target = getent("seal_team_ai_" + n_random, "script_noteworthy");
    self aim_at_target(ai_target);
    wait(randomintrange(3, 6));
  }
}

standoff_aim_seal() {
  self endon("death");
  level waittill("standoff_ai_setup_done");

  while(true) {
    n_random = randomint(12);
    ai_target = getent("chinese_force_ai_" + n_random, "script_noteworthy");
    self aim_at_target(ai_target);
    wait(randomintrange(3, 6));
  }
}

does_super_soct_exist() {
  b_super_soct_exists = 0;

  if(isDefined(level.vh_super_soct) && (isDefined(level.vh_super_soct.classname) && level.vh_super_soct.classname == "script_vehicle"))
    b_super_soct_exists = 1;

  return b_super_soct_exists;
}

salazar_and_han_run_to_evac_point(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  if(isDefined(level.salazar) && isalive(level.salazar))
    level.salazar delete();

  level.salazar = init_hero("salazar");

  if(isDefined(level.han) && isalive(level.han))
    level.han delete();

  level.han = init_hero("han");
  a_ents = [];
  a_ents[a_ents.size] = level.salazar;
  a_ents[a_ents.size] = level.han;
  a_start_node = [];
  a_start_node[a_start_node.size] = getnode("salazar_evac_start_node", "targetname");
  a_start_node[a_start_node.size] = getnode("han_evac_start_node", "targetname");
  a_end_node = [];
  a_end_node[a_end_node.size] = getnode("salazar_evac_end_node", "targetname");
  a_end_node[a_end_node.size] = getnode("han_evac_end_node", "targetname");

  for(i = 0; i < a_ents.size; i++) {
    e_ent = a_ents[i];
    e_ent thread ai_teleport_and_run_to_node(a_start_node[i], a_end_node[i]);
  }
}

ai_teleport_and_run_to_node(nd_start, nd_end) {
  self endon("death");
  self set_ignoreall(1);
  self set_ignoreme(1);
  self forceteleport(nd_start.origin, nd_start.angles);
  wait 0.01;
  self setgoalnode(nd_end);
  self.goalradius = 48;
  dist = 1000;

  while(dist > 200) {
    dist = distance(self.origin, nd_end.origin);
    wait 0.01;
  }

  self setgoalpos(self.origin);
  wait 0.01;
  self forceteleport(nd_end.origin, nd_end.angles);
}