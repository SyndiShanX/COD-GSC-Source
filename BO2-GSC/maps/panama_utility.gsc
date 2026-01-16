/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_utility.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\_skipto;
#include maps\_scene;
#include maps\_dialog;
#include maps\_challenges_sp;
#include animscripts\death;

level_init_flags() {
  flag_init("movie_done");
  flag_init("movie_started");
  flag_init("kill_argue_vo");
  flag_init("house_event_end");
  flag_init("house_follow_mason");
  flag_init("house_meet_mason");
  flag_init("player_at_front_gate");
  flag_init("player_opened_shed");
  flag_init("player_frontyard_obj");
  flag_init("show_introscreen_title");
  flag_init("house_front_door_obj_done");
  flag_init("house_front_gate_obj");
  flag_init("start_shed_obj");
  flag_init("can_turn_off_lights");
  flag_init("house_player_at_exit");
  flag_init("beach_obj_1");
  flag_init("beach_obj_2");
  flag_init("beach_obj_3");
  flag_init("stop_ac130");
  flag_init("zodiac_approach_start");
  flag_init("zodiac_approach_end");
  flag_init("destroy_gaz_trucks");
  flag_init("player_at_first_blood");
  flag_init("mason_at_first_blood");
  flag_init("first_blood_guys_cleared");
  flag_init("contacted_skinner");
  flag_init("rooftop_goes_hot");
  flag_init("rooftop_spawned");
  flag_init("rooftop_clear");
  flag_init("runway_standoff_goes_hot");
  flag_init("runway_vo_done");
  flag_init("hangar_vo_done");
  flag_init("airfield_end");
  flag_init("learjet_battle_done");
  flag_init("hangar_doors_closing");
  flag_init("spawn_pdf_assaulters");
  flag_init("parking_lot_guys_cleared");
  flag_init("hangar_gone_hot");
  flag_init("stop_intro_planes");
  flag_init("stop_runway_planes");
  flag_init("remove_hangar_god_mode");
  flag_init("player_in_hangar");
  flag_init("stop_parking_lot_jets");
  flag_init("motel_jet_done");
  flag_init("hangar_pdf_cleared");
  flag_init("rooftop_guy_killed");
  flag_init("seal_1_in_pos");
  flag_init("seal_2_in_pos");
  flag_init("start_pdf_ladder_reaction");
  flag_init("player_contextual_start");
  flag_init("player_contextual_end");
  flag_init("player_destroyed_learjet");
  flag_init("learjet_destroyed");
  flag_init("learjet_truck_enabled");
  flag_init("player_opened_grate");
  flag_init("player_second_melee");
  flag_init("contextual_melee_success");
  flag_init("player_near_motel");
  flag_init("button_wait_done");
  flag_init("contextual_melee_done");
  flag_init("setup_runway_standoff");
  flag_init("player_on_roof");
  flag_init("turret_guy_died");
  flag_init("spawn_learjet_wave_2");
  flag_init("mason_getting_in_drain");
  flag_init("mason_at_drain");
  flag_init("spawn_parking_lot_backup");
  flag_init("parking_lot_laststand");
  flag_init("mason_at_motel");
  flag_init("motel_scene_end");
  flag_init("start_intro_anims");
  flag_init("trig_mason_to_motel");
  flag_init("player_pull_pin");
  flag_init("motel_room_cleared");
  flag_init("breach_gun_raised");
  flag_init("beach_intro_vo_done");
  flag_init("player_climbs_up_ladder");
  flag_init("learjet_intro_vo_done");
  flag_init("learjet_pdf_with_rpg_at_final");
  flag_init("in_bash_position");
  flag_init("friendly_door_bash_done");
  flag_init("mcknight_sniping");
  flag_init("knife_event_finished");
  flag_init("ambulance_complete");
  flag_init("ambulance_staff_killed");
  flag_init("ambulance_player_engaged");
  flag_init("slums_done");
  flag_init("slums_player_at_overlook");
  flag_init("slums_noriega_at_overlook");
  flag_init("slums_mason_at_overlook");
  flag_init("slums_player_down");
  flag_init("slums_shot_at_snipers");
  flag_init("slums_e_02_start");
  flag_init("slums_e_02_finish");
  flag_init("slums_e_02_helicopter");
  flag_init("slums_molotov_triggered");
  flag_init("slums_update_objective");
  flag_init("slums_nest_engage");
  flag_init("slums_apache_retreat");
  flag_init("slums_start_building_fire");
  flag_init("slums_bottleneck_reached");
  flag_init("slums_bottleneck_2_reached");
  flag_init("spawn_balcony_digbat");
  flag_init("building_breach_ready");
  flag_init("army_street_push");
  flag_init("left_path_cleanup");
  flag_init("slums_player_see_pistol_anim");
  flag_init("slums_player_took_point");
  flag_init("move_intro_heli");
  flag_init("slums_turn_off_player_ignore");
  flag_init("slums_rotate_door");
  flag_init("fxanim_gazebo_start");
  flag_init("slum_scene_waiting");
  flag_init("noriega_moved_now_move_mason");
  flag_init("mv_noriega_to_van");
  flag_init("mv_noriega_to_dumpster");
  flag_init("mv_noriega to_parking_lot");
  flag_init("mv_noriega_to_gazebo");
  flag_init("mv_noriega_just_before_stairs");
  flag_init("mv_noriega_slums_left_bottleneck");
  flag_init("mv_noriega_right_of_church");
  flag_init("mv_noriega_before_church");
  flag_init("mv_noriega_slums_right_bottleneck");
  flag_init("mv_noriega_slums_right_bottleneck_complete");
  flag_init("mv_noriega_move_passed_library");
  flag_init("alley_molotov_digbat_animating");
  flag_init("cleanup_before_digbat_parking_lot");
  flag_init("panama_building_start");
  flag_init("player_at_clinic");
  flag_init("clinic_enter_hall_1");
  flag_init("clinic_enter_hall_2");
  flag_init("clinic_ceiling_collapsed");
  flag_init("post_gauntlet_player_fired");
  flag_init("post_gauntlet_mason_open_door");
  flag_init("jump_start");
  flag_init("chase_player_jumped");
  flag_init("clinic_wall_contact");
  flag_init("clinic_break_window");
  flag_init("chase_rescue_noriega");
  flag_init("checkpoint_approach_one");
  flag_init("checkpoint_approach_two");
  flag_init("checkpoint_reached");
  flag_init("checkpoint_cleared");
  flag_init("checkpoint_finished");
  flag_init("checkpoint_fade_now");
  flag_init("start_mason_run");
  flag_init("docks_battle_one_trigger_event");
  flag_init("docks_cleared");
  flag_init("docks_entering_elevator");
  flag_init("docks_rifle_mounted");
  flag_init("docks_kill_menendez");
  flag_init("sniper_start_timer");
  flag_init("sniper_stop_timer");
  flag_init("sniper_mason_shot1");
  flag_init("sniper_mason_shot2");
  flag_init("docks_mason_down");
  flag_init("docks_betrayed_fade_in");
  flag_init("docks_betrayed_fade_out");
  flag_init("docks_mason_dead_reveal");
  flag_init("docks_final_cin_fade_in");
  flag_init("docks_final_cin_fade_out");
  flag_init("docks_final_cin_landed1");
  flag_init("docks_final_cin_landed2");
  flag_init("challenge_nodeath_check_start");
  flag_init("challenge_nodeath_check_end");
  flag_init("challenge_docks_guards_speed_kill_start");
  flag_init("challenge_docks_guards_speed_kill_pause");
  flag_init("jeep_foliage_crash_1");
  flag_init("jeep_foliage_crash_2");
  flag_init("jeep_fence_crash");
  flag_init("start_gate_ambush");
  flag_init("fuel_tanks_destroyed");
  flag_init("outside_vo");
  flag_init("player_trigger_checkpoint");
  flag_init("player_not_looking");
}

skipto_setup() {
  load_gumps_panama();
  skipto = level.skipto_point;
  level thread destroy_parking_lot_vehicles_before_parking_lot_on_veteran();

  if(skipto == "house") {
    return;
  }
  flag_set("house_meet_mason");
  flag_set("house_follow_mason");
  flag_set("house_front_door_obj_done");
  flag_set("house_front_gate_obj");
  flag_set("player_at_front_gate");
  flag_set("start_shed_obj");
  flag_set("player_opened_shed");
  flag_set("player_frontyard_obj");
  flag_set("house_player_at_exit");
  flag_set("zodiac_approach_start");

  if(skipto == "zodiac") {
    return;
  }
  flag_set("zodiac_approach_end");

  if(skipto == "beach") {
    return;
  }
  flag_set("mason_getting_in_drain");
  flag_set("player_climbs_up_ladder");
  flag_set("player_at_first_blood");
  flag_set("player_contextual_start");
  flag_set("contextual_melee_done");
  flag_set("setup_runway_standoff");
  flag_set("beach_obj_1");
  flag_set("beach_obj_2");
  flag_set("beach_obj_3");

  if(skipto == "runway") {
    return;
  }
  if(skipto == "learjet") {
    return;
  }
  flag_set("learjet_battle_done");
  flag_set("player_near_motel");

  if(skipto == "motel") {
    return;
  }
  flag_set("mason_at_motel");
  flag_set("start_intro_anims");
  flag_set("motel_room_cleared");
  flag_set("motel_scene_end");

  if(skipto == "slums_intro") {
    return;
  }
  flag_set("ambulance_complete");
  flag_set("slums_update_objective");

  if(skipto == "slums_main") {
    return;
  }
  if(skipto == "building") {
    return;
  }
  screen_fade_in(1, undefined, 1);
  flag_set("panama_building_start");

  if(skipto == "chase") {
    return;
  }
  flag_set("chase_rescue_noriega");
  flag_set("jump_start");

  if(skipto == "checkpoint") {
    return;
  }
  flag_set("checkpoint_approach_one");
  flag_set("checkpoint_approach_two");
  flag_set("checkpoint_reached");
  flag_set("checkpoint_cleared");
  flag_set("checkpoint_finished");

  if(skipto == "docks") {
    return;
  }
  flag_set("docks_cleared");
  flag_set("docks_entering_elevator");

  if(skipto == "sniper")
    return;
}

setup_objectives() {
  level.a_objectives = [];
  level.n_obj_index = 0;
  level.obj_meet = register_objective(&"PANAMA_OBJ_MEET");
  level.obj_meet_mcknight = register_objective(&"PANAMA_OBJ_MEET_MCKNIGHT");
  level.obj_house_empty = register_objective(&"");
  level.obj_shed = register_objective(&"PANAMA_OBJ_SHED");
  level.obj_frontyard = register_objective(&"PANAMA_OBJ_FRONTYARD");
  level.obj_interact = register_objective(&"");
  level.obj_intruder = register_objective(&"");
  level.obj_follow_mason_1 = register_objective(&"");
  level.obj_capture_noriega = register_objective(&"PANAMA_OBJ_CAPTURE_NORIEGA");
  level.obj_assist_seals = register_objective(&"PANAMA_OBJ_ASSIST_SEALS");
  level.obj_capture_menendez = register_objective(&"PANAMA_OBJ_CAPTURE_MENENDEZ");
  level.obj_find_false_profit = register_objective(&"PANAMA_OBJ_FIND_FALSE_PROFIT");
  level.obj_reach_checkpoint = register_objective(&"PANAMA_OBJ_REACH_CHECKPOINT");
  level.obj_docks_sniper = register_objective(&"PANAMA_OBJ_DOCKS_SNIPER");
  level.obj_docks_kill_menendez = register_objective(&"PANAMA_OBJ_DOCKS_KILL_MENENDEZ");

  if(level.script == "panama") {
    house_objectives();
    airfield_objectives();
  } else if(level.script == "panama_2") {
    while(!isDefined(level.mason) || !isDefined(level.noriega))
      wait 0.05;

    slums_objectives();
  } else {
    while(!isDefined(level.mason) || !isDefined(level.noriega))
      wait 0.05;

    chase_objectives();
    docks_objectives();
  }
}

setup_global_challenges() {
  wait_for_first_player();
  level.player thread maps\_challenges_sp::register_challenge("nodeath", ::challenge_nodeath);
  level.player thread maps\_challenges_sp::register_challenge("nightingale", ::challenge_nightingale);
}

challenge_nightingale(str_notify) {
  level waittill("nightingale_challenge_completed");
  self notify(str_notify);
}

challenge_nodeath(str_notify) {
  flag_wait("challenge_nodeath_check_start");
  n_deaths = get_player_stat("deaths");

  if(n_deaths == 0)
    self notify(str_notify);

  flag_set("challenge_nodeath_check_end");
}

house_objectives() {
  flag_wait("house_meet_mason");
  set_objective(level.obj_meet, getstruct("s_greet_mason_obj"), "breadcrumb");
  flag_wait("house_follow_mason");
  set_objective(level.obj_meet, getstruct("s_front_door"), "breadcrumb");
  flag_wait("house_front_door_obj_done");
  flag_wait("house_front_gate_obj");
  set_objective(level.obj_meet, getstruct("s_front_gate"), "breadcrumb");
  flag_wait("player_at_front_gate");
  set_objective(level.obj_meet, getstruct("s_front_gate"), "done");
  flag_wait("start_shed_obj");
  set_objective(level.obj_shed, getstruct("s_shed_door_obj"), "breadcrumb");
  flag_wait("player_opened_shed");
  set_objective(level.obj_shed, undefined, "remove");
  set_objective(level.obj_shed, undefined, "done");
  set_objective(level.obj_shed, undefined, "delete");
  flag_wait("player_frontyard_obj");
  set_objective(level.obj_frontyard, getstruct("s_player_gate_obj"), "breadcrumb");
  flag_wait("house_player_at_exit");
  set_objective(level.obj_frontyard, undefined, "remove");
  set_objective(level.obj_frontyard, undefined, "done");
  set_objective(level.obj_frontyard, undefined, "delete");
}

airfield_objectives() {
  flag_wait("zodiac_approach_start");
  set_objective(level.obj_capture_noriega);
  flag_wait("zodiac_approach_end");
  wait 1;
  obj_trigger = getent("trigger_obj_beach_1", "targetname");
  set_objective(level.obj_capture_noriega, obj_trigger, "");
  flag_wait("beach_obj_1");
  obj_trigger = getent("trigger_obj_beach_2", "targetname");
  set_objective(level.obj_capture_noriega, obj_trigger, "");
  flag_wait("beach_obj_2");
  obj_trigger = getent("trigger_obj_beach_3", "targetname");
  set_objective(level.obj_capture_noriega, obj_trigger, "");
  flag_wait("beach_obj_3");
  flag_wait("player_climbs_up_ladder");
  set_objective(level.obj_capture_noriega, undefined, "remove");
  flag_wait("contextual_melee_done");
  flag_wait("learjet_battle_done");
  set_objective(level.obj_assist_seals, level.mason, "remove");
  set_objective(level.obj_assist_seals, undefined, "done");
  set_objective(level.obj_assist_seals, undefined, "delete");
  set_objective(level.obj_capture_noriega, level.mason, "follow");
  flag_wait("player_near_motel");
  set_objective(level.obj_capture_noriega, getstruct("s_hotel_obj_breadcrumb").origin + vectorscale((0, 0, 1), 40.0), "breadcrumb");
  flag_wait("motel_breach_started");
  set_objective(level.obj_capture_noriega, undefined, "remove");
  flag_wait("motel_room_cleared");
  set_objective(level.obj_capture_noriega, undefined, "done");
}

slums_objectives() {
  flag_wait("motel_scene_end");
  set_objective(level.obj_reach_checkpoint);
  flag_wait("ambulance_complete");
  flag_wait("slums_update_objective");
  set_objective(level.obj_reach_checkpoint, getent("trig_player_kick_door", "targetname").origin + vectorscale((0, 0, 1), 50.0), "breach");
  flag_wait("slums_player_took_point");
  level.player setclientdvar("cg_objectiveIndicatorFarFadeDist", 80000);
  set_objective(level.obj_reach_checkpoint, getent("building_enter_front_door", "targetname").origin + vectorscale((0, 0, 1), 72.0));
  flag_wait("building_breach_ready");
  set_objective(level.obj_reach_checkpoint, getent("building_breach_obj", "targetname").origin, "breach");
  trigger_wait("trig_building_player_breach");
  set_objective(level.obj_reach_checkpoint, undefined, "remove");
}

chase_objectives() {
  set_objective(level.obj_meet, undefined, undefined, undefined, 0);
  set_objective(level.obj_meet, undefined, "deactivate");
  set_objective(level.obj_capture_noriega, undefined, undefined, undefined, 0);
  set_objective(level.obj_capture_noriega, undefined, "deactivate");
  wait 2;
  set_objective(level.obj_reach_checkpoint, level.mason, "follow");
  trigger_wait("building_side_door_roof_fall");
  nurse_trigger = getent("nurse_objective", "targetname");
  set_objective(level.obj_reach_checkpoint, undefined, "remove");
  set_objective(level.obj_reach_checkpoint, nurse_trigger.origin, "help");
  trigger_wait("trig_tackle_start");
  set_objective(level.obj_reach_checkpoint, undefined, "remove");
  level waittill("end_gauntlet");
  m_door_clip = getent("clinic_stairs_blocker", "targetname");
  set_objective(level.obj_reach_checkpoint, undefined, "remove");
  set_objective(level.obj_reach_checkpoint, m_door_clip, "breadcrumb");
  trigger_wait("chase_door_trigger");
  set_objective(level.obj_reach_checkpoint, undefined, "remove");
  flag_wait("chase_rescue_noriega");
  set_objective(level.obj_reach_checkpoint, getstruct("noriega_rescue_marker", "targetname"), "help");
  level waittill("noriega_rescued");
  set_objective(level.obj_reach_checkpoint, undefined, "remove");
  flag_wait("jump_start");
  set_objective(level.obj_reach_checkpoint, getstruct("jump_obj_marker", "targetname"), "jump");
  level waittill("chase_jump_cleared");
  set_objective(level.obj_reach_checkpoint, undefined, "remove");
  flag_wait("checkpoint_approach_one");
  set_objective(level.obj_reach_checkpoint, level.mason, "follow");
  flag_wait("checkpoint_approach_two");
  set_objective(level.obj_reach_checkpoint, getstruct("checkpoint_approach_marker", "targetname"), "breadcrumb");
  flag_wait("checkpoint_reached");
  set_objective(level.obj_reach_checkpoint, undefined, "remove");
  flag_wait("checkpoint_cleared");
  set_objective(level.obj_reach_checkpoint, getstruct("checkpoint_obj_marker_jeep", "targetname"), "enter");
  flag_wait("checkpoint_finished");
  set_objective(level.obj_reach_checkpoint, undefined, "done");
}

docks_objectives() {
  flag_wait("docks_cleared");
  set_objective(level.obj_docks_sniper, getstruct("docks_obj_marker_elevator", "targetname"), "enter");
  flag_wait("docks_entering_elevator");
  set_objective(level.obj_docks_sniper, getent("sniper_noriega_kill_guard_trigger", "targetname"), "follow");
  trigger_wait("sniper_noriega_kill_guard_trigger");
  set_objective(level.obj_docks_sniper, undefined, "done");
  flag_wait("docks_kill_menendez");
  set_objective(level.obj_capture_menendez, undefined, "delete");
  set_objective(level.obj_docks_kill_menendez, level.mason, "kill");
  flag_wait("docks_mason_down");
  set_objective(level.obj_docks_kill_menendez, undefined, "done");
}

destroy_parking_lot_vehicles_before_parking_lot_on_veteran() {
  if(getdifficulty() == "fu") {
    structs = getstructarray("destroy_vehicles_struct", "targetname");

    foreach(struct in structs)
    radiusdamage(struct.origin, 1000, 9001, 9001);
  }
}

load_gumps_panama() {
  if(level.script == "panama_2" || level.script == "panama_3")
    return;
}

nightingale_watch() {
  self endon("death");

  if(level.script == "panama")
    self thread nightingale_hint();

  while(true) {
    self waittill("grenade_fire", e_grenade, str_weapon_name);

    if(str_weapon_name == "nightingale_dpad_sp") {
      wait 1;
      e_grenade thread nightingale_think();
      e_grenade thread nightingale_grab_enemy_attention();
    }
  }
}

nightingale_think() {
  playfxontag(level._effect["nightingale_smoke"], self, "tag_fx");

  for(i = 0; i < 256; i++) {
    v_start_pos = self.origin + vectorscale((0, 0, 1), 10.0);
    v_end_pos = v_start_pos + vectorscale((0, 0, 1), 100.0);
    v_offset = (randomintrange(-100, 100), randomintrange(-100, 100), 0);
    magicbullet("m16_sp", v_start_pos, v_end_pos + v_offset);
    wait 0.05;
  }
}

nightingale_grab_enemy_attention() {
  n_enemies_attracted = 0;

  for(i = 0; i < 2; i++) {
    a_enemies = getaiarray("axis");

    foreach(ai_enemy in a_enemies) {
      if(isDefined(ai_enemy) && isalive(ai_enemy)) {
        if(distance2dsquared(self.origin, ai_enemy.origin) < 722500) {
          if(!isDefined(ai_enemy.grenade_marked)) {
            ai_enemy thread nightingale_react_logic(self);
            ai_enemy thread nightingale_marked();
            n_enemies_attracted++;
          }
        }
      }
    }

    wait 1;
  }

  if(n_enemies_attracted > 7)
    level notify("nightingale_challenge_completed");
}

nightingale_react_logic(e_grenade) {
  self endon("death");
  e_grenade endon("death");
  self shoot_at_target(e_grenade, undefined, undefined, 0.5);
  self aim_at_target(e_grenade, 11);
}

nightingale_marked() {
  self endon("death");
  self.grenade_marked = 1;
  wait 20;
  self.grenade_marked = undefined;
}

nightingale_hint() {
  level endon("nightingale_threw");
  level thread hint_timer("nightingale_selected");
  screen_message_create(&"PANAMA_HINT_NIGHTINGALE_SELECT");

  while(!level.player actionslotonebuttonpressed())
    wait 0.05;

  level notify("nightingale_selected");
  level thread hint_timer("nightingale_threw");
  screen_message_delete();
  screen_message_create(&"PANAMA_HINT_NIGHTINGALE");
  level.player waittill_attack_button_pressed();
  screen_message_delete();
  level notify("nightingale_threw");
}

hint_timer(str_notify) {
  level endon(str_notify);
  wait 3;
  screen_message_delete();
}

onspawndecoy() {
  self endon("death");
  self.initial_velocity = self getvelocity();
  delay = 1;
  wait(delay);
  decoy_time = 30;
  spawn_time = gettime();
  self thread simulateweaponfire();

  while(true) {
    if(gettime() > spawn_time + decoy_time * 1000) {
      self destroydecoy();
      return;
    }

    wait 0.05;
  }
}

movedecoy(count, fire_time, main_dir, max_offset_angle) {
  self endon("death");
  self endon("done");

  if(!self isonground()) {
    return;
  }
  min_speed = 100;
  max_speed = 200;
  min_up_speed = 100;
  max_up_speed = 200;
  current_main_dir = randomintrange(main_dir - max_offset_angle, main_dir + max_offset_angle);
  avel = (randomfloatrange(800, 1800) * (randomintrange(0, 2) * 2 - 1), 0, randomfloatrange(580, 940) * (randomintrange(0, 2) * 2 - 1));
  intial_up = randomfloatrange(min_up_speed, max_up_speed);
  start_time = gettime();
  gravity = getdvarint(#"bg_gravity");

  for(i = 0; i < 1; i++) {
    angles = (0, randomintrange(current_main_dir - max_offset_angle, current_main_dir + max_offset_angle), 0);
    dir = anglestoforward(angles);
    dir = vectorscale(dir, randomfloatrange(min_speed, max_speed));
    deltatime = (gettime() - start_time) * 0.001;
    up = (0, 0, intial_up - 800 * deltatime);
    self launch(dir + up);
    wait(fire_time);
  }
}

destroydecoy() {
  self notify("done");
}

simulateweaponfire() {
  self endon("death");
  self endon("done");
  weapon = "m16_sp";
  self thread trackmaindirection();
  self.max_offset_angle = 30;
  firetime = 10;
  clipsize = 5;
  reloadtime = 1.0;

  if(clipsize > 30)
    clipsize = 30;

  burst_spacing_min = 2;
  burst_spacing_max = 6;

  while(true) {
    burst_count = randomintrange(int(clipsize * 0.6), clipsize);
    interrupt = 0;
    self thread movedecoy(burst_count, firetime, self.main_dir, self.max_offset_angle);
  }
}

fireburst(weapon, firetime, count, interrupt) {
  interrupt_shot = count;

  if(interrupt)
    interrupt_shot = int(count * randomfloatrange(0.6, 0.8));

  wait(firetime * interrupt_shot);

  if(interrupt)
    wait(firetime * (count - interrupt_shot));
}

trackmaindirection() {
  self endon("death");
  self endon("done");
  self.main_dir = int(vectortoangles((self.initial_velocity[0], self.initial_velocity[1], 0))[1]);
  up = (0, 0, 1);

  while(true) {
    self waittill("grenade_bounce", pos, normal);
    dot = vectordot(normal, up);

    if(dot < 0.5 && dot > -0.5)
      self.main_dir = int(vectortoangles((normal[0], normal[1], 0))[1]);
  }
}

ir_strobe_watch() {
  self endon("death");

  if(isDefined(level.strobe_active)) {
    return;
  }
  if(level.script == "panama_2") {
    screen_message_create(&"PANAMA_STROBE_GRENADE_TUTORIAL", & "PANAMA_SELECT_IRSTROBE");
    self thread watch_ir_strobe_equipped();
    self waittill_notify_or_timeout("strobe_equipped", 10);
    self notify("hint_over");
    screen_message_delete();
  }

  level.strobe_vo[0] = "reds_odin_1_2_confirmin_0";
  level.strobe_vo[1] = "reds_be_advised_fall_ba_0";
  level.strobe_vo[2] = "reds_firing_now_0";
  level.strobe_vo_tracker = 0;

  if(level.script == "panama_2") {
    while(self getcurrentweapon() != "irstrobe_dpad_sp")
      wait 0.05;

    screen_message_create(&"PANAMA_HINT_THROW_IRSTROBE");
    self thread watch_ir_strobe_fired();
    self waittill_notify_or_timeout("strobe_fired", 5);
    self notify("hint_over");
    screen_message_delete();
  }

  level.strobe_active = 0;
  level.strobe_queue = [];
  self thread _ir_strobe_queue();

  while(true) {
    self waittill("grenade_fire", e_grenade, str_weapon_name);

    if(str_weapon_name == "irstrobe_dpad_sp") {
      e_grenade.active = 1;
      e_grenade ent_flag_init("start_fire");
      level.strobe_queue[level.strobe_queue.size] = e_grenade;
      e_grenade thread _ir_strobe_logic();
    }
  }
}

watch_ir_strobe_equipped() {
  self endon("hint_over");

  while(!self actionslotfourbuttonpressed())
    wait 0.05;

  self notify("strobe_equipped");
}

watch_ir_strobe_fired() {
  self endon("hint_over");

  while(!self attackbuttonpressed())
    wait 0.05;

  self notify("strobe_fired");
}

_ir_strobe_queue() {
  self endon("death");

  while(true) {
    if(!level.strobe_active) {
      for(i = 0; i < level.strobe_queue.size; i++) {
        if(level.strobe_queue[i].active) {
          level.strobe_active = 1;
          level.strobe_queue[i] ent_flag_set("start_fire");
          break;
        }
      }
    }

    wait 1;
  }
}

_ir_strobe_logic() {
  wait 2;
  e_model = spawn("script_model", self.origin);
  e_model setmodel("tag_origin");
  playfxontag(level._effect["ir_strobe"], e_model, "tag_origin");
  e_model playloopsound("fly_irstrobe_beep", 0.1);
  self ent_flag_wait("start_fire");
  level.player queue_dialog(level.strobe_vo[level.strobe_vo_tracker], 0.5);
  level.strobe_vo_tracker++;

  if(level.strobe_vo_tracker == level.strobe_vo.size)
    level.strobe_vo_tracker = 0;

  wait 3;
  tracedata = bullettrace(self.origin, self.origin + vectorscale((0, 0, 1), 256.0), 0, self);

  if(tracedata["fraction"] == 1 && !flag("post_gauntlet_mason_open_door")) {
    v_end_pos = self.origin;
    ac130_shoot(v_end_pos, 1);
  } else if(isDefined(tracedata["entity"]) && tracedata["entity"].classname == "script_vehicle") {
    if(tracedata["entity"].vehicletype == "apc_m113")
      wait 6;
    else {
      v_end_pos = self.origin;
      ac130_shoot(v_end_pos, 1);
    }
  } else
    wait 6;

  self.active = 0;
  level.strobe_active = 0;
  e_model delete();
}

air_ambience(str_veh_targetname, str_paths, flag_ender, n_min_wait, n_max_wait) {
  if(!isDefined(n_min_wait))
    n_min_wait = 4.0;

  if(!isDefined(n_max_wait))
    n_max_wait = 6.0;

  a_paths = getvehiclenodearray(str_paths, "targetname");
  nd_last_path = a_paths[0];

  while(!flag(flag_ender)) {
    for(nd_path = a_paths[randomint(a_paths.size)]; nd_path == nd_last_path; nd_path = a_paths[randomint(a_paths.size)]) {
    }

    nd_last_path = nd_path;
    v_jet = spawn_vehicle_from_targetname(str_veh_targetname);
    v_jet thread _air_ambience_think(nd_path);
    v_jet setforcenocull();

    if(v_jet.vehicletype == "plane_mig23")
      v_jet thread add_jet_fx();

    wait(randomfloatrange(n_min_wait, n_max_wait));
  }
}

_air_ambience_think(nd_path) {
  self getonpath(nd_path);
  self gopath();
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

add_jet_fx() {
  playfxontag(level._effect["jet_contrail"], self, "tag_wingtip_l");
  playfxontag(level._effect["jet_contrail"], self, "tag_wingtip_r");
  playfxontag(level._effect["jet_exhaust"], self, "tag_engine_fx");
}

ac130_ambience(flag_ender) {
  while(!flag(flag_ender)) {
    v_forward = anglestoforward(level.player getplayerangles()) * 5000;
    v_end_pos = level.player.origin + (v_forward[0], v_forward[1], 0);
    v_offset = (randomintrange(-2000, 2000), randomintrange(-2000, 2000), 0);
    v_end_pos = v_end_pos + v_offset;
    ac130_shoot(v_end_pos);
    wait 5;
  }
}

ac130_shoot(v_end_pos, b_close) {
  v_start_pos = (v_end_pos[0], v_end_pos[1], 3500);
  v_fx_pos = v_start_pos;
  sound_ent = spawn("script_origin", v_start_pos);

  if(isDefined(b_close) && b_close) {
    earthquake(0.3, 8, v_end_pos, 1028);
    level.player thread _ac130_vibration(v_start_pos);
    level thread _ac130_clear_enemies(v_start_pos);
  }

  for(i = 0; i < 60; i++) {
    v_offset_end = v_end_pos + (randomintrange(-200, 200), randomintrange(-200, 200), 0);
    sound_ent playloopsound("wpn_ac130_fire_loop_npc", 0.25);
    playsoundatposition("prj_ac130_impact", v_offset_end);
    magicbullet("ac130_vulcan_minigun", v_start_pos, v_offset_end);
    wait 0.1;
  }

  sound_ent playsound("wpn_ac130_fire_loop_ring_npc");
  sound_ent delete();

  if(isDefined(b_close) && b_close) {
    level.player notify("stop_rumble_check");
    level.player playsound("evt_ac130_fire");
  }
}

_ac130_vibration(v_start_pos) {
  self endon("stop_rumble_check");

  while(true) {
    if(distance2d(v_start_pos, self.origin) < 1028)
      self playrumbleonentity("damage_heavy");

    wait 0.05;
  }
}

_ac130_clear_enemies(v_start_pos) {
  wait 1;
  a_axis = getaiarray("axis");

  foreach(e_enemy in a_axis) {
    if(isalive(e_enemy) && isDefined(e_enemy.grenade_marked) && e_enemy.grenade_marked) {
      magicbullet("ac130_vulcan_minigun", v_start_pos, e_enemy.origin);
      e_enemy die();
      level notify("combo_death");
      wait(randomfloatrange(0.5, 1.0));
      continue;
    }

    if(isalive(e_enemy) && distance2d(v_start_pos, e_enemy.origin) < 800) {
      magicbullet("ac130_vulcan_minigun", v_start_pos, e_enemy.origin);
      e_enemy die();
      wait(randomfloatrange(0.5, 1.0));
    }
  }
}

sky_fire_light_ambience(str_area, flag_ender) {
  a_exploder_id = [];

  switch (str_area) {
    case "airfield":
      a_exploder_id[0] = 102;
      a_exploder_id[1] = 103;
      a_exploder_id[2] = 104;
      a_exploder_id[3] = 105;
      break;
    case "slums":
      a_exploder_id[0] = 501;
      a_exploder_id[1] = 502;
      a_exploder_id[2] = 503;
      a_exploder_id[3] = 504;
      break;
  }
}

player_lock_in_position(origin, angles) {
  link_to_ent = spawn("script_model", origin);
  link_to_ent.angles = angles;
  link_to_ent setmodel("tag_origin");
  self playerlinktoabsolute(link_to_ent, "tag_origin");
  self waittill("unlink_from_ent");
  self unlink();
  link_to_ent delete();
}

old_man_woods(str_movie_name, notify_special) {
  level clientnotify("omw_on");
  flag_clear("movie_done");
  cin_id = play_movie_async(str_movie_name, 0, 0, undefined, 1, "movie_done", 1);

  while(!iscinematicinprogress(cin_id))
    wait 0.05;

  wait 1;
  flag_set("movie_started");

  while(iscinematicinprogress(cin_id))
    wait 0.05;

  flag_set("movie_done");
  flag_clear("movie_started");

  if(isDefined(notify_special))
    level clientnotify(notify_special);
  else
    level clientnotify("omw_off");
}

run_anim_to_idle(str_start_scene, str_idle_scene) {
  run_scene(str_start_scene);
  level thread run_scene(str_idle_scene);
}

fail_player(str_dead_quote_ref) {
  setdvar("ui_deadquote", str_dead_quote_ref);
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
}

set_custom_flashlight_values(range, startradius, endradius, fovinnerfraction, brightness, offset, color, bob_amount) {
  wait 1.0;
  setsaveddvar("r_enableFlashlight", "1");
  setsaveddvar("r_flashLightRange", range);
  setsaveddvar("r_flashLightStartRadius", startradius);
  setsaveddvar("r_flashLightEndRadius", endradius);
  setsaveddvar("r_flashLightFOVInnerFraction", fovinnerfraction);
  setsaveddvar("r_flashLightBrightness", brightness);
  setsaveddvar("r_flashLightOffset", offset);
  setsaveddvar("r_flashLightColor", color);
  setsaveddvar("r_flashLightColor", bob_amount);
}

notify_on_lookat_trigger(str_trig_name, str_notify) {
  level endon(str_notify);
  trigger_wait(str_trig_name, "targetname");
  level notify(str_notify);
}

waittill_done_talking() {
  while(isDefined(self.is_talking) && self.is_talking)
    wait 0.05;
}

screen_fade_in_delay(n_duration, n_delay) {
  wait(n_delay);
  screen_fade_in(n_duration);
}

screen_fade_out_delay(n_duration, n_delay) {
  wait(n_delay);
  screen_fade_out(n_duration);
}

blackscreen(fadein, stay, fadeout) {
  blackscreen = newhudelem();
  blackscreen.alpha = 0;
  blackscreen.horzalign = "fullscreen";
  blackscreen.vertalign = "fullscreen";
  blackscreen setshader("black", 640, 480);

  if(fadein > 0)
    blackscreen fadeovertime(fadein);

  blackscreen.alpha = 1;
  wait(stay);

  if(fadeout > 0)
    blackscreen fadeovertime(fadeout);

  blackscreen.alpha = 0;
  blackscreen destroy();
  level notify("blackscreen_finished");
}

player_flak_jacket_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  if(str_means_of_death != "MOD_BULLET" && str_means_of_death != "MOD_MELEE" && str_means_of_death != "MOD_PISTOL_BULLET" && str_means_of_death != "MOD_RIFLE_BULLET") {
    n_damage = get_whole_number(n_damage * 0.5);

    if(str_weapon == "rpg_sp") {
      ai_array = getaiarray("axis");

      foreach(ai in ai_array) {
        if(distance2dsquared(ai.origin, level.player.origin) < 65536) {
          ai thread animscripts\death::play_explosion_death();
          level notify("kill_ai_with_flak_jacket");
        }
      }
    }
  }

  return n_damage;
}

get_whole_number(num) {
  negative = 1;

  if(num < 0)
    negative = -1;

  num = abs(num);

  for(count = 0; num >= 1; count = count + 1)
    num = num - 1;

  return count * negative;
}

check_for_friendly_fire_noriega() {
  while(true) {
    self waittill("damage", amount, attacker);

    if(attacker == level.player)
      missionfailedwrapper(&"PANAMA_FRIENDLY_FIRE_FAILURE");

    wait 0.05;
  }
}