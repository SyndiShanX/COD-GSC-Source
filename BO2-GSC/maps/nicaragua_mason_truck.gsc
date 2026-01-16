/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_mason_truck.gsc
******************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\_fxanim;
#include maps\nicaragua_mason_donkeykong;
#include maps\_turret;

skipto_mason_truck() {
  trigger_off("mason_hill_wave2_lasthill");
  level.hudson = init_hero("hudson");
  level.woods = init_hero("woods");
  skipto_teleport("player_skipto_mason_truck", get_heroes());
  set_objective(level.obj_mason_up_hill);
  exploder(10);
  setsaveddvar("cg_aggressiveCullRadius", "500");
  model_restore_area("mason_hill_1");
  model_restore_area("mason_hill_2");
  model_restore_area("mason_mission");
  maps\_fxanim::fxanim_reconstruct("fxanim_watertower_river");
  maps\_fxanim::fxanim_reconstruct("fxanim_hut_river");
  maps\_fxanim::fxanim_reconstruct("fxanim_porch_explode");
  maps\_fxanim::fxanim_reconstruct("fxanim_hut_explode");
  maps\_fxanim::fxanim_reconstruct("fxanim_hut_explode_watertower");
  maps\_fxanim::fxanim_reconstruct("fxanim_trough_break_1");
  maps\_fxanim::fxanim_reconstruct("fxanim_trough_break_2");
  maps\_fxanim::fxanim_reconstruct("fxanim_truck_fence");
  maps\_fxanim::fxanim_reconstruct("fxanim_archway");
  maps\_fxanim::fxanim_reconstruct("fxanim_fountain");
  battlechatter_on("axis");
  trigger_use("mason_truck_color_trigger");
}

init_flags() {
  flag_init("nicaragua_mason_truck_complete");
  flag_init("mason_truck_stopped");
  flag_init("mason_truck_crashed");
  flag_init("mason_truck_crash_complete");
  flag_init("mason_truck_occupants_spawned");
  flag_init("mason_truck_wave2_begin");
  flag_init("mason_truck_wave2_retreat");
  flag_init("player_using_truck_turret");
  flag_init("mason_truck_resolved");
  flag_init("mason_truck_VO_complete");
}

main() {
  init_flags();
  level thread nicaragua_mason_truck_objectives();
  mason_truck_setup();
  level thread mason_truck_begin();
  level thread mason_truck_combat();
  flag_wait("nicaragua_mason_truck_complete");
  level thread mason_truck_cleanup();
}

nicaragua_mason_truck_objectives() {
  flag_wait("mason_hill_objective_breadcrumb_complete");
  set_objective(level.obj_mason_up_hill, undefined, "remove");
  level thread objective_breadcrumb(level.obj_mason_up_hill, "mason_truck_objective_breadcrumb");
}

challenge_mason_flip_truck(str_notify) {
  self endon(str_notify);
  self endon("mason_truck_turnout");
  flag_wait("mason_truck_crash_complete");
  self notify(str_notify);
}

mason_truck_setup() {
  e_wagon_clip = getent("wagon_clip", "targetname");
  e_wagon_clip trigger_off();
  a_nd_nodes = getnodearray("mason_truck_exposed_nodes", "script_noteworthy");

  foreach(node in a_nd_nodes)
  setenablenode(node, 0);

  level thread run_scene("mason_truck_pdf_corpse");
}

mason_truck_colorgroups() {
  trigger_use("mason_truck_color_trigger");
  flag_wait("mason_truck_wave2_begin");
  flag_wait_any("mason_truck_crash_complete", "mason_truck_stopped");
  trigger_use("mason_truck_color_trigger2");
  level thread mason_truck_move_up_vo();
  flag_wait("mason_truck_wave2_retreat");
  trigger_use("mason_truck_color_trigger3");
}

mason_truck_combat() {
  spawn_manager_enable("mason_truck_cartel_start_sm");
  wait 0.1;
  spawn_manager_enable("mason_truck_start_pdf_sm");
  waittill_spawn_manager_complete("mason_truck_cartel_start_sm");
  flag_wait("mason_truck_occupants_spawned");
  level thread mason_truck_check_for_enemies_dead();
  a_ai_enemies = get_ai_group_ai("mason_truck_cartel_wave1");

  if(a_ai_enemies.size > 3)
    waittill_dead(a_ai_enemies, 3);

  flag_set("mason_truck_wave2_begin");
  spawn_manager_enable("mason_truck_cartel_wave2_sm");
  waittill_spawn_manager_complete("mason_truck_cartel_wave2_sm");
  waittill_ai_group_ai_count("mason_truck_cartel_wave2", 2);
  flag_waitopen("player_using_truck_turret");
  flag_set("mason_truck_wave2_retreat");
  a_ai_cartel = get_ai_group_ai("mason_truck_cartel_wave2");
  e_goalvolume = getent("donkeykong_goalvolume", "targetname");

  foreach(guy in a_ai_cartel) {
    guy thread maps\nicaragua_mason_donkeykong::sprint_to_retreat(e_goalvolume);
    wait(randomfloatrange(0.5, 1.5));
  }
}

mason_truck_player_uses_turret(vh_truck) {
  level endon("begin_mason_donkeykong");
  self waittill("enter_vehicle", e_vehicle);

  if(e_vehicle != vh_truck) {
    return;
  }
  flag_set("player_using_truck_turret");
  a_nd_nodes = getnodearray("mason_truck_exposed_nodes", "script_noteworthy");

  foreach(node in a_nd_nodes)
  setenablenode(node, 1);

  spawn_manager_enable("mason_truck_turret_enemies_sm");
  self waittill("exit_vehicle");
  flag_clear("player_using_truck_turret");
  spawn_manager_disable("mason_truck_turret_enemies_sm");
  a_s_spawner = getentarray("mason_truck_turret_enemies", "targetname");

  foreach(spawner in a_s_spawner) {
    if(isDefined(spawner))
      spawner.count = 0;
  }
}

mason_truck_end() {
  flag_set("nicaragua_mason_truck_complete");
  trigger_off("mason_truck_end_trigger");
  level notify("mason_truck_complete");
}

mason_truck_check_for_enemies_dead() {
  level endon("mason_truck_complete");
  level thread mason_truck_end_failsafe();
  a_ai_enemies = get_ai_group_ai("mason_truck_cartel_wave1");
  waittill_dead(a_ai_enemies);
  mason_truck_end();
}

mason_truck_end_failsafe() {
  level endon("mason_truck_complete");
  trigger_wait("begin_donkeykong");
  mason_truck_end();
}

mason_truck_begin() {
  trigger_wait("mason_truck_begin");
  level thread mason_truck_vo();
  level thread mason_truck_colorgroups();

  while(true) {
    vh_truck = getent("mason_truck", "targetname");

    if(isDefined(vh_truck)) {
      break;
    }

    wait 0.1;
  }

  wait 0.1;
  vh_truck.damagerecieved = 0;
  vh_truck.overridevehicledamage = ::mason_truck_damage_override;
  vh_truck mason_truck_add_occupants();
  vh_truck thread go_path(getnode("mason_truck_path", "targetname"));
  vh_truck playsound("evt_mason_truck_approach");
  vh_truck thread mason_truck_shoots();
  level.player thread mason_truck_player_uses_turret(vh_truck);
  vh_truck waittill("mason_truck_decision_point");
  s_goal = getstruct("truck_crash", "targetname");
  vh_truck.goalradius = 32;
  vh_truck setvehgoalpos(s_goal.origin);
  vh_truck.drivepath = 0;
  vh_truck waittill("goal");

  if(!flag("mason_truck_crashed")) {
    vh_truck.overridevehicledamage = undefined;
    vh_truck notify("mason_truck_turnout");
    level notify("mason_truck_turnout");
    level thread mason_truck_turnout_vo();
    run_scene("mason_truck_stop", 2.0);

    if(!flag("mason_truck_gunner_killed"))
      vh_truck thread mason_truck_turnout_explode();

    flag_set("mason_truck_stopped");
    vh_truck mason_truck_passengers_getout();
  } else {
    horn_ent = spawn("script_origin", vh_truck.origin);
    horn_ent linkto(vh_truck);
    level thread truck_horn_sound(horn_ent);
    vh_truck clearvehgoalpos();
    vh_truck cancelaimove();
    run_scene("mason_truck_crash", 2.0);
    flag_set("mason_truck_crash_complete");
    level thread mason_truck_crash_vo();
    level notify("mason_truck_crashed");
    level.player inc_general_stat("mechanicalkills");
  }

  flag_set("mason_truck_resolved");
}

mason_truck_turnout_explode() {
  flag_wait("mason_truck_gunner_killed");
  self dodamage(self.health, self.origin);
}

truck_horn_sound(ent) {
  wait 1.5;
  ent playloopsound("amb_pickup_horn");
  wait 25;
  ent stoploopsound(3);
  wait 4;
  ent delete();
}

trough_1_break(e_truck) {
  level notify("fxanim_trough_break_1_start");
  earthquake(0.25, 0.5, level.player.origin, 1024);
  level.player thread rumble_loop(4, 0.05, "damage_light");
  a_nd_nodes = getnodearray("mason_truck_trough1_nodes", "script_noteworthy");

  foreach(node in a_nd_nodes)
  setenablenode(node, 0);
}

trough_2_break(e_truck) {
  level notify("fxanim_trough_break_2_start");
  earthquake(0.25, 0.5, level.player.origin, 1024);
  level.player thread rumble_loop(4, 0.05, "damage_light");
  e_trough_clip = getent("truck_trough", "targetname");
  e_trough_clip trigger_off();
  a_nd_nodes = getnodearray("mason_truck_trough2_nodes", "script_noteworthy");

  foreach(node in a_nd_nodes)
  setenablenode(node, 0);
}

fence_break(e_truck) {
  level notify("fxanim_truck_fence_start");
  earthquake(0.25, 0.5, level.player.origin, 1024);
  level.player thread rumble_loop(4, 0.05, "damage_light");

  if(isalive(level.mason_truck_gunner)) {
    level.mason_truck_gunner ragdoll_death();
    v_x = randomfloatrange(-20.0, 20.0);
    v_y = randomfloatrange(30.0, 45.0);
    v_z = 0.0;
    level.mason_truck_gunner launchragdoll((v_x, v_y, v_z));
  }
}

truck_hits_tree(e_truck) {
  e_truck.overridevehicledamage = undefined;
  e_truck.takedamage = 0;
  earthquake(0.5, 0.5, level.player.origin, 1024);
  level.player thread rumble_loop(4, 0.05, "damage_heavy");
  add_generic_ai_to_scene(level.mason_truck_passenger, "mason_truck_passenger_crash_death");
  level thread run_scene("mason_truck_passenger_crash_death");
  e_truck thread re_link_passenger_to_truck();
}

mason_truck_add_occupants() {
  str_driver_tag = "tag_driver";
  str_passenger_tag = "tag_passenger";
  str_gunner_tag = "tag_gunner1";
  ai_driver = simple_spawn_single("mason_truck_occupant");
  wait_network_frame();
  ai_passenger = simple_spawn_single("mason_truck_occupant");
  wait_network_frame();
  ai_gunner = simple_spawn_single("mason_truck_occupant");
  wait_network_frame();
  ai_gunner.deathfunction = ::truck_gunner_death;
  self thread truck_disable_turret_on_gunner_death();
  ai_driver enter_vehicle(self, str_driver_tag);
  ai_passenger enter_vehicle(self, str_passenger_tag);
  ai_gunner enter_vehicle(self, str_gunner_tag);
  level.mason_truck_driver = ai_driver;
  level.mason_truck_passenger = ai_passenger;
  level.mason_truck_gunner = ai_gunner;
  ai_gunner.script_noteworthy = "ai_gunner";
  flag_set("mason_truck_occupants_spawned");
}

truck_gunner_death() {
  flag_set("mason_truck_gunner_killed");
  return false;
}

truck_disable_turret_on_gunner_death() {
  flag_wait("mason_truck_gunner_killed");
  n_index = 1;

  if(isDefined(self)) {
    self maps\_turret::stop_turret(n_index, 1);
    self notify("gunner_dead");
    self makevehicleusable();
  }
}

mason_truck_shoots() {
  self endon("death");
  self endon("gunner_dead");
  n_turret_index = 1;
  v_offset = self set_mason_truck_burst_parameters(n_turret_index);
  self maps\_turret::set_turret_ignore_line_of_sight(1, n_turret_index);
  a_ai_allies = getaiarray("allies");
  self maps\_turret::set_turret_target_ent_array(a_ai_allies, n_turret_index);
  self enable_turret(n_turret_index);
  self waittill("mason_truck_turnout");
  self maps\_turret::clear_turret_target_ent_array(n_turret_index);

  while(true) {
    self maps\_turret::shoot_turret_at_target(level.player, -1, v_offset, n_turret_index);
    wait 1;
  }
}

mason_truck_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(!flag("mason_truck_crashed")) {
    if(eattacker == level.player) {
      n_delta = distance2d(level.mason_truck_driver.origin, vpoint);

      if(n_delta <= 40) {
        if(sweapon == "molotov_dpad_sp")
          n_damage = idamage;
        else
          n_damage = int(idamage / 2.0);

        self.damagerecieved = self.damagerecieved + n_damage;

        if(self.damagerecieved >= 100) {
          flag_set("mason_truck_crashed");
          self hidepart("tag_glass_front");
          self attach("veh_iw_pickup_bloody_glass", "tag_glass_front");
          level.mason_truck_driver stopanimscripted();
          add_generic_ai_to_scene(level.mason_truck_driver, "mason_truck_driver_death");
          level thread run_scene("mason_truck_driver_death");
          self thread re_link_driver_to_truck();
          level.mason_truck_passenger stopanimscripted();
          add_generic_ai_to_scene(level.mason_truck_passenger, "mason_truck_passenger_crash_idle");
          level thread run_scene("mason_truck_passenger_crash_idle");
        }
      }
    }
  }

  return false;
}

re_link_driver_to_truck() {
  scene_wait("mason_truck_driver_death");
  level.mason_truck_driver linkto(self, "tag_driver");
}

re_link_passenger_to_truck() {
  scene_wait("mason_truck_passenger_crash_death");
  level.mason_truck_passenger linkto(self, "tag_passenger");
}

mason_truck_passengers_getout() {
  self vehicle_unload(0.1);
  a_ai_passengers = getentarray("mason_truck_occupant_ai", "targetname");
  e_goalvolume = getent("mason_truck_riders_goalvolume", "targetname");

  foreach(guy in a_ai_passengers) {
    if(!isDefined(guy.script_noteworthy))
      guy setgoalvolumeauto(e_goalvolume);
  }
}

mason_truck_vo() {
  trigger_wait("mason_truck_turns_corner");
  level.hudson queue_dialog("huds_mg_truck_incoming_0");

  if(is_mature())
    level.woods queue_dialog("wood_shoot_the_fucking_dr_0", 0.5);
  else
    level.woods queue_dialog("wood_shoot_the_driver_ma_0", 0.5);
}

mason_truck_crash_vo() {
  level.woods queue_dialog("wood_like_old_times_huh_0");
  level.player queue_dialog("maso_ain_t_it_just_0", 0.5);
  flag_set("mason_truck_VO_complete");
}

mason_truck_turnout_vo() {
  level.woods queue_dialog("wood_too_slow_mason_0");

  if(!flag("mason_truck_gunner_killed"))
    level.hudson queue_dialog("huds_take_down_the_gunner_0", 1.0);

  flag_set("mason_truck_VO_complete");
}

mason_truck_move_up_vo() {
  flag_wait("mason_truck_resolved");
  wait 1.0;
  level.hudson queue_dialog("huds_move_0", 1.0, "mason_truck_VO_complete");
}

mason_truck_cleanup() {
  level waittill("begin_mason_donkeykong");
  kill_spawnernum(12);
  a_ai_pdf = get_ai_group_ai("mason_truck_pdf");

  foreach(guy in a_ai_pdf) {
    if(isalive(guy))
      guy thread timebomb(0.1, 2.0);
  }

  level waittill("nicaragua_mason_donkeykong_complete");
  delete_scene_all("mason_truck_stop", 1);
  delete_scene("mason_truck_crash", 1);
  delete_scene_all("mason_truck_driver_death", 1);
  delete_scene("mason_truck_passenger_crash_idle", 1);
  delete_scene_all("mason_truck_passenger_crash_death", 1);
}