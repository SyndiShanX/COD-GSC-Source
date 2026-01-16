/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_2_ground.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\la_utility;
#include maps\_music;
#include maps\_hud_util;
#include maps\createart\la_2_art;
#include maps\la_2_anim;
#include maps\_friendlyfire;
#include maps\_scene;
#include maps\la_2_player_f35;
#include maps\la_2_amb;
#include maps\_drones;
#include maps\la_2_convoy;
#include maps\_vehicle;
#include maps\_turret;
#include maps\_objectives;
#include maps\_glasses;
#include maps\_load_common;
#include maps\_helicopter_ai;
#include maps\_lockonmissileturret;
#include maps\_anim;
#include maps\_audio;
#include maps\la_2_fly;

f35_flight_start() {
  level.player thread f35_tutorial(1, 0, 1, 0, 0);
}

f35_wakeup() {
  wait_for_first_player();
  level clientnotify("intro_exterior");
  setmusicstate("LA_2_INTRO");
  maps\createart\la_2_art::fog_intro();
  exploder(20);
  exploder(462);
  exploder(100);
  exploder(102);
  level.no_drone_ragdoll = 1;
  run_scene_first_frame("anderson_f35_exit");
  intro_move_player_origin();
  level.f35 thread f35_landing_gear();
  level thread intro_set_cull_dist();
  vh_intro_van = get_ent("convoy_van", "targetname", 1);
  vh_intro_van thread func_on_death(::required_vehicle_death);
  level.player thread player_wakes_up_la_2();
  level thread pilot_pre_drag_idle();

  if(!flag("harper_dead"))
    level thread harper_wakes_up();
  else {
    flag_set("start_anderson_f35_exit");
    wait 5.5;
    level notify("harper_woke_up");
  }

  level thread late_cops_driveup();
  level thread intro_blackhawks();
  level thread intro_cougars();
  level thread ambient_flybys();
  level thread fake_building_collapse();
  level thread ambient_activity_warehouse_street();
  level thread intro_guys_die();
  level.f35 thread f35_blinking_light();
  level.f35 thread maps\la_2_anim::vo_f35_boarding();
  level.f35 thread func_on_death(::required_vehicle_death);
  flag_wait("start_anderson_f35_exit");
  level thread harper_drags_pilot_to_van();
  vh_intro_van attach("veh_iw_civ_ambulance_int", "tag_origin");
  level thread run_digital_billboards();
  level thread fire_hydrant_break();
}

fire_hydrant_break() {
  m_hydrant = undefined;
  a_models = getentarray("script_model", "classname");

  for(i = 0; i < a_models.size; i++) {
    if(a_models[i].model == "fxdest_gp_firehydrant_base") {
      m_hydrant = a_models[i];
      break;
    }
  }

  while(distance2d(level.player.origin, m_hydrant.origin) > 700)
    wait 0.05;

  m_hydrant dodamage(5000, m_hydrant.origin);
}

player_wakes_up_la_2(b_remove_weapons, str_return_weapons_notify) {
  assert(isplayer(self), "player_wakes_up can only be used on players!");

  if(!isDefined(level.flag["player_awake"]))
    flag_init("player_awake");

  if(!isDefined(b_remove_weapons))
    b_remove_weapons = 1;

  e_temp = spawn("script_origin", self.origin);
  e_temp.angles = self getplayerangles();
  self playerlinktodelta(e_temp, undefined, 0, 45, 45, 45, 45);
  self setstance("prone");
  self allowstand(0);
  self allowsprint(0);
  self allowjump(0);
  self allowads(!b_remove_weapons);
  self setplayerviewratescale(30);
  self hide_hud();

  if(b_remove_weapons)
    self thread _player_wakes_up_remove_weapons(str_return_weapons_notify);

  self shellshock("death", 12);
  self screen_fade_out(0);
  wait 0.2;
  self playrumbleonentity("damage_light");
  wait 0.4;
  self playrumbleonentity("damage_light");
  wait 0.4;
  self screen_fade_to_alpha_with_blur(0.35, 2, 3);
  wait 1.5;
  self screen_fade_to_alpha_with_blur(1, 1.5, 6);
  self playrumbleonentity("damage_light");
  wait 0.5;
  self screen_fade_to_alpha_with_blur(0.2, 2, 1.5);
  wait 2;
  self screen_fade_to_alpha_with_blur(1, 1, 6);
  wait 1;
  self setplayerviewratescale(80);
  self screen_fade_to_alpha_with_blur(0.2, 2, 1);
  self allowstand(1);
  self allowsprint(1);
  self allowjump(1);
  self allowads(1);
  self resetplayerviewratescale();
  self notify("_give_back_weapons");
  self show_hud();
  flag_set("player_awake");
  self unlink();
  e_temp delete();
  self screen_fade_to_alpha_with_blur(0, 2, 0);
}

intro_set_cull_dist() {
  wait 2;
  level clientnotify("set_intro_fog_banks");
  setculldist(15000);
  wait 0.2;
  setculldist(15001);
}

intro_move_player_origin() {
  s_player_start = get_struct("player_start_default_struct", "targetname", 1);
  v_start_pos = s_player_start.origin;
  v_start_ang = s_player_start.angles;
  v_saved_pos = "";

  if(v_saved_pos != "")
    v_start_pos = level.f35 localtoworldcoords(v_saved_pos);

  v_saved_ang = "";

  if(v_saved_ang != "")
    v_start_ang = v_saved_ang;

  level.player setorigin(bullettrace(v_start_pos + vectorscale((0, 0, 1), 1000.0), v_start_pos + vectorscale((0, 0, 1), 1000.0) + vectorscale((0, 0, -1), 100000.0), 0, level.player)["position"]);
  level.player setplayerangles(v_start_ang);

  println("intro_move_player_origin done!");
}

f35_landing_gear() {
  self hidepart("tag_landing_gear_doors");
  self hidepart("tag_ladder");
  self attach("veh_t6_air_fa38_landing_gear", "tag_landing_gear_down");
  self attach("veh_t6_air_fa38_ladder", "tag_ladder");
  flag_wait("player_flying");
  self showpart("tag_landing_gear_doors");
  self showpart("tag_ladder");
  self detach("veh_t6_air_fa38_landing_gear", "tag_landing_gear_down");
  self detach("veh_t6_air_fa38_ladder", "tag_ladder");
}

pilot_pre_drag_idle() {
  level endon("player_in_f35");
  level endon("pilot_drag_started");
  ai_pilot = init_hero("f35_pilot");
  ai_pilot.animname = "f35_pilot";
  playfxontag(level._effect["anderson_halo"], ai_pilot, "J_HipTwist_RI");
  run_scene_first_frame("pilot_drag_van_setup");
  level waittill("start_anderson_f35_exit");
  run_scene("anderson_f35_exit");

  println("anderson_f35_exit F35 pos: " + level.f35 gettagorigin("tag_origin") + ", angles = " + level.f35 gettagangles("tag_origin"));

  run_scene("pilot_drag_setup");
}

harper_drags_pilot_to_van() {
  wait 1.5;
  vh_intro_van = get_ent("convoy_van", "targetname", 1);
  nd_start = getvehiclenode("intro_van_exit_spline", "targetname");
  assert(isDefined(nd_start), "nd_start is missing for harper_drags_pilot_to_van");

  if(!flag("harper_dead")) {
    level thread pilot_drag_play_harper_anims();
    ai_harper = get_ais_from_scene("pilot_drag_harper")[0];
    ai_harper waittill("goal");
  } else {
    t_debris_trigger = get_ent("player_inside_debris_cloud_trigger", "targetname", 1);
    t_debris_trigger waittill("trigger");
  }

  level notify("pilot_drag_started");
  run_scene("pilot_drag");
  level notify("pilot_drag_ended");
  delete_ais_from_scene("pilot_drag");
  n_wait_time = 1;

  if(!flag("player_in_f35"))
    n_wait_time = 5;

  flag_wait("player_in_f35");

  if(isDefined(ai_harper))
    ai_harper anim_stopanimscripted();

  wait(n_wait_time);
  vh_intro_van.origin = nd_start.origin;
  vh_intro_van setphysangles(nd_start.angles);
  wait 0.5;
  vh_intro_van thread go_path(nd_start);
}

actor_died_fail() {
  level endon("pilot_drag_ended");
  self waittill("death");

  if(!isDefined(level.pilot_drag_over))
    level.player thread maps\_friendlyfire::missionfail();
}

pilot_drag_play_harper_anims() {
  ai_harper = get_ent("harper_ai", "targetname");
  ai_harper anim_set_blend_in_time(0.2);
  run_scene("pilot_drag_harper");
  level thread run_scene("pilot_drag_harper_idle");
}

required_vehicle_death() {
  if(flag("player_in_f35")) {
    return;
  }
  setdvar("ui_deadquote", & "LA_2_REQUIRED_VEHICLE_DEAD");
  missionfailed();
}

late_cops_driveup() {
  squad_cars = spawn_vehicles_from_targetname("late_lapd");

  foreach(car in squad_cars)
  car.overridevehicledamage = ::cops_damage_override;

  playsoundatposition("amb_distant_police_oneshot", (6744, -33418, 316));
  level waittill("harper_woke_up");

  for(i = 0; i < squad_cars.size; i++) {
    wait 0.8;
    squad_cars[i] playsound("amb_police_siren_" + i);
    squad_cars[i] thread play_delayed_stop_sound(i);
  }

  flag_wait("player_in_f35");
  wait 5.0;

  for(i = 0; i < squad_cars.size; i++)
    squad_cars[i] notify("kill_siren");
}

fake_building_collapse() {
  level waittill("harper_woke_up");
  playsoundatposition("exp_mortar_dist", (6747, -33485, 241));
  wait 1;
  playsoundatposition("evt_dist_building_fall", (6747, -33485, 241));
}

cops_damage_override(einflictor, eattacker, idamage, idflags, type, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(eattacker == level.player) {
    if(self.health - idamage <= 0)
      level.player thread maps\_friendlyfire::missionfail();
  }

  return idamage;
}

intro_blackhawks() {
  blackhawks = spawn_vehicles_from_targetname("intro_blackhawk");
}

intro_cougars() {
  cougars = spawn_vehicles_from_targetname("intro_cougar");
}

play_delayed_stop_sound(num) {
  wait 0.5;

  while(self getspeed() >= 5)
    wait 0.1;

  self playsound("amb_police_stop_" + num);
}

harper_wakes_up() {
  n_scale = 150;
  v_angles_player = anglestoforward(level.player.angles);
  v_origin_player = level.player.origin;
  v_offset = vectorscale((0, 0, 1), 1000.0);
  v_harper_pos = v_angles_player * n_scale + v_origin_player + v_offset;
  v_start_origin = bullettrace(v_harper_pos, v_harper_pos + vectorscale((0, 0, -1), 100000.0), 0, level.player)["position"];
  v_angles = level.player.angles;
  ai_harper = init_hero("harper");
  ai_harper forceteleport(v_start_origin, v_angles);
  wait 5.5;
  level thread maps\_scene::run_scene("harper_wakes_up");
  level notify("harper_woke_up");
  a_nodes = getnodearray("harper_intro_cover_node", "targetname");
  assert(a_nodes.size > 0, "harper_intro_cover_node array is missing!");
  nd_best = a_nodes[0];
  n_dot_best = -1;
  v_to_plane = vectornormalize(level.f35.origin - ai_harper.origin);

  for(i = 0; i < a_nodes.size; i++) {
    v_to_node = vectornormalize(a_nodes[i].origin - ai_harper.origin);
    n_dot = vectordot(v_to_plane, v_to_node);

    if(n_dot > n_dot_best) {
      nd_best = a_nodes[i];
      n_dot_best = n_dot;
    }
  }

  ai_harper force_goal(nd_best, 32);
  ai_harper change_movemode("sprint");
  flag_wait("intro_harper_moveup");
  flag_set("start_anderson_f35_exit");
}

f35_boarding() {
  waittill_notify_or_timeout("player_can_board", 10);
  flag_set("player_can_board");
  t_boarding = get_ent("f35_bump_trigger", "targetname", 1);
  t_boarding waittill("trigger");
  flag_set("player_in_f35");
  level thread maps\la_2_anim::vo_f35_startup();
  level.player anim_f35_get_in();
  setculldist(25000);
  stop_exploder(100);
  level.player anim_f35_startup();
  maps\la_2_player_f35::player_boards_f35();
  exploder(470);
  flag_set("player_flying");
  level thread vtol_check_on_path();
  level thread maps\la_2_amb::radio_chatter();
  level.player freezecontrols(1);
  autosave_now();
  level.player freezecontrols(0);
}

anim_f35_get_in() {
  n_fov_vtol = 70;
  level.player setclientdvar("cg_fov", n_fov_vtol);
  level thread maps\_scene::run_scene("F35_get_in_vehicle");
  level thread maps\_scene::run_scene("F35_get_in");
  wait 0.05;
  m_helmet = get_model_or_models_from_scene("F35_get_in", "F35_helmet");
  m_helmet setforcenocull();
  maps\_scene::scene_wait("F35_get_in");
}

anim_f35_startup() {
  level thread maps\_scene::run_scene("F35_startup_vehicle");
  maps\createart\la_2_art::art_vtol_mode_settings();
  maps\_scene::run_scene("F35_startup");
}

intro_guys_die() {
  a_intro_guys = simple_spawn("intro_guys");

  for(i = 0; i < a_intro_guys.size; i++)
    a_intro_guys[i] thread play_intro_guy_death_anim();
}

play_intro_guy_death_anim() {
  self.animname = "intro_guy";
  self enable_long_death();
  str_death_anim = "intro_death_" + randomintrange(1, 7);
  self set_deathanim(str_death_anim);
  wait 0.1;
  self dodamage(self.health + 1, self.origin);
}

f35_blinking_light() {
  wait 1;
  str_tag_left = "tag_left_wingtip";
  str_tag_right = "tag_right_wingtip";
  v_pos_left = self gettagorigin(str_tag_left);
  v_pos_right = self gettagorigin(str_tag_right);
  e_temp_left = spawn("script_model", v_pos_left);
  e_temp_left setmodel("tag_origin");
  e_temp_right = spawn("script_model", v_pos_right);
  e_temp_right setmodel("tag_origin");
  playfxontag(level._effect["f35_light"], e_temp_left, "tag_origin");
  playfxontag(level._effect["f35_light"], e_temp_right, "tag_origin");
  flag_wait("player_flying");
  e_temp_left delete();
  e_temp_right delete();
}

setup_destructibles() {
  wait_for_first_player();
  level thread damage_trigger_monitor("radio_tower_damage_trigger", 500, "fxanim_signal_tower_start", undefined, ::radio_tower_death);
  bm_clip_pristine = get_ent("crane_clip_pristine", "targetname", 1);
  bm_clip_collapsed = get_ent("crane_clip_collapsed", "targetname", 1);
  bm_clip_collapsed moveto(bm_clip_collapsed.origin - vectorscale((0, 0, 1), 10000.0), 0.1);
  level thread damage_trigger_monitor("rooftop_crane_trigger", 1000, "fxanim_crane_collapse_start", level.player, ::crane_death);
  level thread billboard_kill_screen("billboard_death_1", "billboard_physics_struct_1");
  level thread billboard_kill_screen("billboard_death_2", "billboard_physics_struct_2");
  a_fake_physics_vehicles = get_ent_array("fake_physics_vehicle", "targetname", 1);
  array_thread(a_fake_physics_vehicles, ::fake_physics_vehicle_launch);
  level thread billboard_1_lookat_trigger();
  level thread setup_parking_garage();
}

billboard_1_lookat_trigger() {
  level endon("billboard_death_1");
  t_lookat = get_ent("billboard_1_lookat_trigger", "targetname", 1);
  b_should_fire_rpg = 0;

  while(!b_should_fire_rpg) {
    t_lookat waittill("trigger");

    if(distance(t_lookat.origin, level.player.origin) < 6000)
      b_should_fire_rpg = 1;
  }

  fire_magic_rpg_struct("hotel_st_billboard_magic_struct");
}

billboard_kill_screen(str_fx_anim_start_notify, str_struct_targetname) {
  s_physics_pulse = get_struct(str_struct_targetname, "targetname", 1);
  level waittill(str_fx_anim_start_notify);
  radiusdamage(s_physics_pulse.origin, 300, 150, 150);
  physicsexplosionsphere(s_physics_pulse.origin, 300, 250, 1);
}

setup_parking_garage() {
  t_roof = get_ent("parking_garage_destroyed_roof_part_trigger", "targetname", 1);
  t_damage = get_ent("parking_structure_damage_trigger", "targetname", 1);
  bm_roof_clip_pristine = get_ent("parking_structure_roof_brushmodel", "targetname", 1);
  bm_roof_clip_destroyed = get_ent("parking_structure_destroyed_clip", "targetname", 1);
  t_roof thread destroy_roof_on_helicopter_crash();
  level thread parking_structure_destroy_roof();
  bm_roof_clip_pristine setmovingplatformenabled(1);
  bm_roof_clip_destroyed trigger_off();
  b_roof_pristine = 1;

  while(b_roof_pristine) {
    t_damage waittill("damage", n_damage, e_attacker, v_fire_direction, v_hit_point, str_type);

    if(isDefined(e_attacker) && isplayer(e_attacker) && isDefined(str_type) && issubstr(str_type, "PROJECTILE"))
      b_roof_pristine = 0;
  }

  level notify("parking_structure_roof_collapse");
}

parking_structure_destroy_roof() {
  t_roof = get_ent("parking_garage_destroyed_roof_part_trigger", "targetname", 1);
  a_roof_nodes = getnodearray("parking_structure_roof_nodes", "script_noteworthy");
  t_damage = get_ent("parking_structure_damage_trigger", "targetname", 1);
  bm_roof_clip_pristine = get_ent("parking_structure_roof_brushmodel", "targetname", 1);
  bm_roof_clip_destroyed = get_ent("parking_structure_destroyed_clip", "targetname", 1);
  t_physics = get_ent("garage_roof_physics_struct", "targetname", 1);
  assert(a_roof_nodes.size > 0, "roof nodes are missing for set_parking_garage");
  level waittill("parking_structure_roof_collapse");
  bm_roof_clip_destroyed moveto(bm_roof_clip_destroyed.origin + vectorscale((0, 0, 1), 10000.0), 0.1);
  a_vehicles = get_ent_array("garage_car", "script_noteworthy");
  a_vehicles_on_roof = [];

  for(i = 0; i < a_vehicles.size; i++) {
    if(a_vehicles[i] istouching(t_physics))
      a_vehicles_on_roof[a_vehicles_on_roof.size] = a_vehicles[i];
  }

  level notify("fxanim_garage_roof_start");
  array_thread(a_vehicles_on_roof, ::push_garage_roof_vehicles, t_physics);
  a_to_die = get_ai_touching_volume("axis", "parking_garage_destroyed_roof_part_trigger");

  if(a_to_die.size > 0) {
    for(i = 0; i < a_to_die.size; i++)
      a_to_die[i] die();
  }

  for(i = 0; i < a_roof_nodes.size; i++)
    setenablenode(a_roof_nodes[i], 0);

  bm_roof_clip_pristine delete();
  t_damage delete();
  t_roof delete();
}

destroy_roof_on_helicopter_crash() {
  level endon("parking_structure_roof_collapse");

  while(true) {
    self waittill("trigger", e_triggered);

    if(isDefined(e_triggered.classname) && e_triggered.classname == "script_vehicle" && e_triggered.vehicleclass == "helicopter" && isDefined(e_triggered.crashing) && e_triggered.crashing) {
      wait 1;
      level notify("parking_structure_roof_collapse");
    }
  }
}

push_garage_roof_vehicles(e_trigger) {
  wait 0.8;
  n_scale = 3;
  v_push = vectornormalize(e_trigger.origin - self.origin) * n_scale;
  self physicslaunch(self.origin, v_push);
}

fake_physics_vehicle_launch() {
  b_valid_vehicle = self.classname == "script_model" || self.classname == "script_vehicle";
  assert(b_valid_vehicle, self.classname + " is not a supported classname for fake_physics_vehicle_launch. supported types = script_model");
  self setcandamage(1);
  n_damage_threshold = 200;
  n_scale_explosive_min = 2000;
  n_scale_explosive_max = 3000;
  n_scale_bullet_min = 400;
  n_scale_bullet_max = 500;
  n_health = 500;
  n_accumulated = 0;
  b_is_dead = 0;

  while(true) {
    self waittill("damage", n_damage, e_attacker, v_fire_direction, v_hit_point, str_type);
    b_should_move = 0;
    b_is_explosive_type = 0;
    b_is_bullet_type = 0;
    b_is_enough_damage = 0;

    if(issubstr(str_type, "PROJECTILE") || issubstr(str_type, "GRENADE") || issubstr(str_type, "EXPLOSIVE")) {
      b_is_explosive_type = 1;
      b_should_move = 1;
    } else if(issubstr(str_type, "BULLET")) {
      b_is_bullet_type = 1;
      b_should_move = 1;
    }

    if(n_damage >= n_damage_threshold) {
      b_is_enough_damage = 1;
      n_accumulated = n_accumulated + n_damage;
    }

    if(!b_is_dead && n_accumulated > n_health)
      b_is_dead = 1;

    if(b_should_move && b_is_enough_damage) {
      if(b_is_explosive_type)
        self vehicle_explosion_launch(v_hit_point);
      else if(b_is_bullet_type) {
        n_scale = randomintrange(n_scale_bullet_min, n_scale_bullet_max);
        v_launch_direction = vectornormalize(v_hit_point - self.origin) * n_scale * -1;
        self physicslaunch(v_hit_point, v_launch_direction);
      }
    }
  }
}

gas_station_death() {
  exploder(105);
  flag_set("gas_station_destroyed");
  e_harper = level.convoy.vh_van;
  t_damage = get_ent("gas_station_damage_trigger", "targetname", 1);
  playsoundatposition("evt_gas_station_explo", t_damage.origin);
  v_point = t_damage.origin;
  n_radius = 1024;
  n_force_min = 250;
  n_force_max = 350;
  n_launch_angle_min = undefined;
  n_launch_angle_max = undefined;
  b_use_drones = 1;
  explosion_launch(v_point, n_radius, n_force_min, n_force_max, n_launch_angle_min, n_launch_angle_max, b_use_drones);
  maps\_drones::drones_delete("gas_station_drones");
  vh_truck = get_ent("truck_gas_station", "targetname");

  if(isDefined(vh_truck))
    vh_truck dodamage(9999, vh_truck.origin, level.player, level.player, "explosive");
}

warehouse_death() {
  exploder(110);
  flag_set("warehouse_destroyed");
  e_harper = level.convoy.vh_van;
  t_damage = get_ent("warehouse_damage_trigger", "targetname", 1);
  v_point = t_damage.origin;
  n_radius = 2000;
  n_force_min = 250;
  n_force_max = 350;
  n_launch_angle_min = undefined;
  n_launch_angle_max = undefined;
  b_use_drones = 1;
  explosion_launch(v_point, n_radius, n_force_min, n_force_max, n_launch_angle_min, n_launch_angle_max, b_use_drones);
  spawn_manager_disable("spawn_manager_warehouse_roof");
  spawn_manager_disable("spawn_manager_warehouse_roof_1");
  spawn_manager_disable("spawn_manager_warehouse_street");
}

radio_tower_death() {
  assert(isDefined(self.target), "script_brushmodel target is missing for radio tower!");
  self playsound("evt_sigtower_exp");
  bm_weapon_clip = get_ent(self.target, "targetname", 1);
  bm_weapon_clip delete();
  self delete();
}

crane_death() {
  bm_clip_pristine = get_ent("crane_clip_pristine", "targetname", 1);
  bm_clip_collapsed = get_ent("crane_clip_collapsed", "targetname", 1);
  t_hit = get_ent("crane_clip_trigger", "targetname", 1);
  bm_clip_pristine delete();
  bm_clip_collapsed trigger_on();
  n_timeout = 4;
  t_hit delete();
}

kill_player_if_under_crane(n_timeout) {
  level endon("crane_collapse_done");
  level delay_thread(n_timeout, "crane_collapse_done");
  self waittill("trigger");
  level.deadquote_override = 1;
  setdvar("ui_deadquote", & "LA_2_F35_DEAD_CRANE");
  level.f35 do_vehicle_damage(level.f35.health_regen.health, self);
}

damage_trigger_monitor(str_trigger_name, n_damage_before_trigger, str_notify_on_death, a_valid_attackers, func_on_death) {
  assert(isDefined(str_trigger_name), "str_trigger_name is a required parameter for damage_trigger_monitor");
  assert(isDefined(n_damage_before_trigger), "n_damage_before_trigger is a required parameter for damage_trigger_monitor");
  assert(isDefined(str_notify_on_death), "str_notify_on_death is a required parameter for damage_trigger_monitor");
  b_check_attackers = 0;
  t_damage = get_ent(str_trigger_name, "targetname", 1);
  assert(t_damage.classname == "trigger_damage", "damage_trigger_monitor() requires classname trigger_damage. " + str_trigger_name + " is currently a " + t_damage.classname);
  e_target = get_ent(str_trigger_name + "_target", "targetname");

  if(isDefined(e_target)) {
  }

  if(isDefined(a_valid_attackers)) {
    b_check_attackers = 1;
    a_attackers = [];

    if(isarray(a_valid_attackers))
      a_attackers = a_valid_attackers;
    else
      a_attackers[a_attackers.size] = a_valid_attackers;
  }

  b_check_attackers = isDefined(a_valid_attackers);
  n_damage_total = 0;

  while(n_damage_total < n_damage_before_trigger) {
    t_damage waittill("damage", n_damage, e_attacker);
    b_should_damage = 1;

    if(b_check_attackers) {
      b_should_damage = 0;

      for(i = 0; i < a_attackers.size; i++) {
        if(a_attackers[i] == e_attacker)
          b_should_damage = 1;
      }
    }

    if(b_should_damage)
      n_damage_total = n_damage_total + n_damage;
  }

  self notify(str_notify_on_death);
  t_damage notify("death");

  if(isDefined(e_target))
    e_target delete();

  if(isDefined(func_on_death))
    t_damage[[func_on_death]]();
}

f35_ground_targets() {
  maps\createart\la_2_art::art_vtol_mode_settings();
  flag_wait("convoy_movement_started");
  level thread maps\la_2_convoy::convoy_register_stop_point("convoy_tutorial_stop_trigger", "ground_targets_done", ::flag_set, "convoy_at_ground_targets");
  level thread convoy_attacked_by_sprinter_vans();
  level thread spawn_ground_target_guys();
  flag_wait("convoy_at_ground_targets");
  stop_exploder(20);
  level thread setup_ground_attack_objectives();
  level thread roadblock_vehicles();
  level thread maps\la_2_anim::vo_roadblock();
  _ground_targets_success();
  maps\la_2_convoy::convoy_distance_check_update(25000);
  flag_set("ground_targets_done");
  level thread _ground_targets_end();
}

roadblock_vehicles() {
  a_vehicle_names = array("truck_warehouse_1", "truck_warehouse_2", "truck_gas_station");
  a_vehicles = [];

  for(i = 0; i < a_vehicle_names.size; i++) {
    a_temp_vehicle = maps\_vehicle::spawn_vehicle_from_targetname(a_vehicle_names[i]);
    a_vehicles[a_vehicles.size] = a_temp_vehicle;
  }
}

ground_vehicle_fires_at_player(n_custom_index) {
  self endon("death");
  self endon("gunner_dead");
  self add_ground_vehicle_damage_callback();

  if(self.vehicletype == "civ_pickup_red_wturret_la2") {
  }

  n_index = 1;
  v_offset = (0, 0, 0);

  if(isDefined(n_custom_index))
    n_index = n_custom_index;

  self maps\_turret::set_turret_burst_parameters(5, 7, 1.5, 3, n_index);

  while(!isDefined(self.is_ambient_vehicle) || !self.is_ambient_vehicle) {
    e_target = randomint(100) < 95 ? maps\la_2_convoy::convoy_get_leader() : level.player;
    self maps\_turret::set_turret_target(e_target, v_offset, n_index);
    self maps\_turret::shoot_turret_at_target(e_target, -1, v_offset, n_index);
  }
}

add_ground_vehicle_damage_callback() {
  if(isDefined(self))
    self.overridevehicledamage = ::ground_vehicle_damage_callback;
}

ground_vehicle_damage_callback(einflictor, eattacker, idamage, idflags, type, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(isDefined(sweapon)) {
    if(sweapon == "f35_missile_turret_player")
      idamage = 9999;
    else if(sweapon == "f35_side_minigun_player")
      idamage = 1000;
    else if(sweapon == "cougar_gun_turret")
      idamage = 1;
  }

  return idamage;
}

spawn_ground_target_guys() {
  spawn_manager_enable("spawn_manager_warehouse_roof_1");
  waittill_spawn_manager_complete("spawn_manager_warehouse_roof_1");
  e_warehouse_1 = get_ent("roadblock_roof_origin_1", "targetname", 1);
  maps\_objectives::set_objective(level.obj_roadblock, e_warehouse_1, "remove");
  e_warehouse_2 = get_ent("roadblock_roof_origin_2", "targetname", 1);
  maps\_objectives::set_objective(level.obj_roadblock, e_warehouse_2, "destroy", -1);
  spawn_manager_enable("spawn_manager_warehouse_roof");
}

_ground_targets_end() {
  if(flag("ground_targets_escape"))
    wait 6;

  maps\_drones::drones_delete("gas_station_drones");
  maps\_drones::drones_delete("warehouse_drones");
}

_ground_targets_success(n_placeholder) {
  waittill_spawn_manager_complete("spawn_manager_warehouse_roof");
  e_warehouse_2 = get_ent("roadblock_roof_origin_2", "targetname", 1);
  maps\_objectives::set_objective(level.obj_roadblock, e_warehouse_2, "remove");
  a_guys = get_ent_array("warehouse_roof_guys");
  a_guys_1 = get_ent_array("warehouse_roof_guys_1");
  a_guys = arraycombine(a_guys, a_guys_1, 1, 0);
  level thread spread_array_thread(a_guys, ::mark_ai_for_death);
}

_ground_targets_failure(n_placeholder) {
  level endon("ground_targets_done");
  level waittill_any("G20_1_dead", "G20_2_dead", "POTUS_health_low");
  flag_set("ground_targets_escape");
  spawn_manager_disable("spawn_manager_warehouse_roof");
  spawn_manager_disable("spawn_manager_warehouse_roof_1");
  spawn_manager_disable("spawn_manager_warehouse_street");
  e_harper = level.convoy.vh_van;
  e_harper thread say_dialog("roadblock_escape");
}

convoy_attacked_by_sprinter_vans() {
  a_vans = maps\_vehicle::spawn_vehicles_from_targetname("terrorist_chaser_vans_a");

  if(isDefined(level.convoy.vh_g20_1)) {
    a_temp = maps\_vehicle::spawn_vehicles_from_targetname("terrorist_chaser_vans_b");
    a_vans = arraycombine(a_vans, a_temp, 1, 0);
    level.convoy.vh_g20_1 maps\_turret::set_turret_target_ent_array(a_vans, level.convoy.vh_g20_1.turret_index_used);
  }

  level.convoy.vh_potus maps\_turret::set_turret_target_ent_array(a_vans, level.convoy.vh_potus.turret_index_used);

  foreach(vh_van in a_vans) {
    assert(isDefined(vh_van.target), "van at " + vh_van.origin + " is not targeting a spline path!");
    n_temp = getvehiclenode(vh_van.target, "targetname");
    vh_van.drivepath = 1;
    vh_van thread go_path(n_temp);
  }
}

setup_ground_attack_objectives() {
  wait 0.5;
  a_targets = [];

  if(!flag("gas_station_destroyed")) {
    t_gas_station = get_ent("gas_station_damage_trigger", "targetname");
    a_targets[a_targets.size] = t_gas_station;
  }

  if(!flag("warehouse_destroyed"))
    t_warehouse = get_ent("warehouse_damage_trigger", "targetname");

  level.ground_attack_targets = a_targets.size;
  array_thread(a_targets, ::objective_ground_attack_add);
  e_warehouse = get_ent("roadblock_roof_origin_1", "targetname", 1);
  maps\_objectives::set_objective(level.obj_roadblock, e_warehouse, "destroy", -1);
}

objective_ground_attack_add() {
  maps\_objectives::set_objective(level.obj_roadblock, self, "destroy", -1);
  self waittill("death");
  maps\_objectives::set_objective(level.obj_roadblock, self, "remove");
  level.ground_attack_targets--;
  maps\_objectives::set_objective(level.obj_roadblock, undefined, undefined, level.ground_attack_targets);
}

ground_attack_vehicle_death() {
  self vehicle_explosion_launch(self.origin);
  level.ground_attack_vehicles--;

  if(level.ground_attack_vehicles == 0)
    flag_set("ground_attack_vehicles_dead");
}

setup_spawn_functions() {
  add_spawn_function_group("intro_medic", "targetname", ::actor_died_fail);
  add_spawn_function_veh("hotel_street_heli_group_1", ::hotel_street_heli_think);
  add_spawn_function_veh("hotel_street_heli_group_3", ::hotel_street_heli_think);
  a_nodes_warehouse_roof = getnodearray("roadblock_cover_roof", "targetname");
  a_nodes_warehouse_roof_edge = getnodearray("roadblock_cover_roof_edge", "targetname");
  a_nodes_warehouse_roof_1 = getnodearray("roadblock_cover_roof_1", "targetname");
  a_nodes_warehouse_roof_edge_1 = getnodearray("roadblock_cover_roof_edge_1", "targetname");
  a_nodes_warehouse_street = getnodearray("roadblock_cover_street", "targetname");
  add_spawn_function_group("warehouse_roof_guys", "targetname", ::warehouse_guys_func, a_nodes_warehouse_roof_edge, a_nodes_warehouse_roof);
  add_spawn_function_group("warehouse_ground_guys", "targetname", ::warehouse_guys_func, a_nodes_warehouse_street);
  add_spawn_function_group("warehouse_roof_guys_1", "targetname", ::warehouse_guys_func, a_nodes_warehouse_roof_edge_1, a_nodes_warehouse_roof_1);
  a_nodes_edge = getnodearray("rooftops_edge_node", "targetname");
  a_nodes_interior = getnodearray("rooftops_edge_node", "targetname");
  a_volumes_infantry = [];
  a_volumes_infantry[a_volumes_infantry.size] = get_ent("rooftops_volume_east", "targetname", 1);
  add_spawn_function_group("parking_structure_guys", "targetname", ::attack_convoy_leader_ai);
  add_spawn_function_veh("truck_gas_station", ::gas_station_collateral_damage);
  add_spawn_function_group("crane_building_guys", "targetname", ::attack_convoy_leader_ai);
  add_spawn_function_group("parking_structure_van_guys", "script_noteworthy", ::attack_convoy_leader_ai);
  add_spawn_function_veh("parking_garage_heli_1", ::heli_crash_audio);
  add_spawn_function_veh("parking_garage_heli_1", ::heli_think);
  add_spawn_function_veh("parking_garage_heli_2", ::ground_vehicle_fires_at_player, 0);
  add_spawn_function_veh("crane_building_helicopter", ::heli_crash_audio);
  add_spawn_function_veh("crane_building_helicopter_2", ::heli_crash_audio);
  add_spawn_function_veh("crane_building_helicopter", ::heli_think);
  add_spawn_function_veh("crane_building_helicopter_2", ::heli_think);
  add_spawn_function_veh("hotel_street_crash_drone", ::die_on_spline);
  add_spawn_function_veh("building_collapse_fly_in_planes", ::building_collapse_planes_fire);
}

building_collapse_planes_fire() {
  self endon("death");
  assert(isDefined(self.script_string), "script_string is missing on building collapse plane at " + self.origin);
  e_target = get_ent(self.script_string, "targetname");
  assert(isDefined(e_target), "target for building collapse plane with script_string '" + self.script_string + "' is missing!");
  self waittill("fire_now");
  e_missile = magicbullet("pegasus_missile_turret_doublesize", self.origin, e_target.origin);
  e_missile thread _explode_near_target(e_target);
  self waittill("reached_end_node");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

_explode_near_target(e_target) {
  self endon("death");
  self thread _collapse_building_on_missile_hit();

  while(distance(self.origin, e_target.origin) > 200)
    wait 0.05;

  self resetmissiledetonationtime(0);
}

_collapse_building_on_missile_hit() {
  self waittill("death");
  level notify("fxanim_bldg_convoy_block_start");
  exploder(100);
  wait 5;
  flag_set("building_collapse_done");
}

die_on_spline() {
  self endon("death");
  self waittill("kill_me");
  self do_vehicle_damage(self.health, level.convoy.vh_potus, "explosive");
}

vehicle_fires_at_target_pool_then_dies(str_enemy_targetname) {
  self endon("death");
  self.is_ambient_vehicle = 1;
  a_targets = get_ent_array(str_enemy_targetname, "targetname");
  array_thread(a_targets, ::add_ambient_turret_target);
  self maps\_turret::clear_turret_target(1);

  if(a_targets.size > 0) {
    self maps\_turret::set_turret_target_ent_array(a_targets, 1);
    self maps\_turret::enable_turret(1);
  }

  self waittill("target_array_destroyed");

  while(self getspeedmph() > 5)
    wait 1;

  wait(randomfloatrange(3, 5));
  iprintlnbold("destroying ambient vehicle");
  self do_vehicle_damage(self.health, level.convoy.vh_potus, "explosive");
}

add_ambient_turret_target() {
  self.is_ambient_turret_target = 1;
}

gas_station_collateral_damage() {
  self waittill("death");
  t_gas_station = get_ent("gas_station_damage_trigger", "targetname");

  if(isDefined(t_gas_station))
    t_gas_station dodamage(9999, t_gas_station.origin, level.player, level.player, "explosive");
}

warehouse_guys_func(a_convoy_nodes, a_player_nodes) {
  self endon("death");
  assert(isDefined(a_convoy_nodes), "a_convoy_nodes is a required parameter for warehouse_guys_func");

  if(!isDefined(a_player_nodes))
    a_player_nodes = a_convoy_nodes;

  n_distance_to_next_max_sq = 300 * 300;
  n_distance_from_last_max_sq = 300 * 300;
  v_last_node_position = self.origin;
  self.goalradius = 64;
  self.a.rockets = 200;
  self.dropweapon = 0;

  if(is_mature() && !is_gib_restricted_build())
    self.force_gib = 1;

  b_should_target_player = isDefined(self.script_noteworthy) && self.script_noteworthy == "shoot_player";
  a_nodes = a_convoy_nodes;

  if(b_should_target_player)
    a_nodes = a_player_nodes;

  assert(a_nodes.size > 0, "a_nodes for " + self.targetname + " at position " + self.origin + " has no nodes for warehouse_guys_func");

  while(true) {
    b_found_node = 0;
    self set_ignoreall(1);

    while(!b_found_node) {
      nd_cover = random(a_nodes);
      b_node_claimed = isnodeoccupied(nd_cover);
      n_distance_from_last_sq = distancesquared(nd_cover.origin, v_last_node_position);
      b_distance_from_last_ok = n_distance_from_last_sq > n_distance_from_last_max_sq;
      n_distance_to_cover_sq = distancesquared(self.origin, nd_cover.origin);
      b_distance_to_next_ok = n_distance_to_cover_sq > n_distance_to_next_max_sq;

      if(!b_node_claimed && b_distance_to_next_ok && b_distance_from_last_ok)
        b_found_node = 1;

      wait 0.05;
    }

    self set_goal_node(nd_cover);
    self waittill("goal");
    v_last_node_position = nd_cover.origin;
    self set_ignoreall(0);
    n_shoot_time = randomfloatrange(10, 25);
    e_target = maps\la_2_convoy::convoy_get_leader();

    if(b_should_target_player)
      e_target = level.player;

    self thread shoot_at_target(e_target, undefined, 0, n_shoot_time);
    wait(n_shoot_time);
  }
}

remove_target_on_death() {
  self waittill("death");

  if(target_istarget(self))
    target_remove(self);
}

attack_convoy_leader_ai() {
  self endon("death");
  b_shoot_player = 0;
  self.dropweapon = 0;
  self.goalradius = 64;
  self.a.rockets = 200;
  self set_pacifist(1);
  self waittill("goal");
  self set_pacifist(0);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "shoot_player" && self.weapon == "rpg")
    b_shoot_player = 1;

  while(true) {
    e_target = maps\la_2_convoy::convoy_get_leader();

    if(b_shoot_player)
      e_target = level.player;

    self shoot_at_target(e_target);
    wait 1;
  }
}

rooftop_guys_func(a_nodes_edge, a_nodes_interior, a_volumes_infantry) {
  self endon("death");
  b_shoot_player = 0;
  self.dropweapon = 0;
  self.goalradius = 64;
  self.a.rockets = 200;
  a_nodes = a_nodes_edge;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "shoot_player") {
    b_shoot_player = 1;
    a_nodes = a_nodes_interior;
  }

  while(true) {
    self go_to_appropriate_goal(a_nodes, a_volumes_infantry);
    e_target = maps\la_2_convoy::convoy_get_leader();

    if(b_shoot_player)
      e_target = level.player;

    self shoot_at_target(e_target);
    wait 8;
  }
}

go_to_appropriate_goal(a_nodes, a_volumes_infantry) {
  b_has_goal = 0;

  while(!b_has_goal) {
    nd_goal = random(a_nodes);
    n_index = 0;

    if(flag("convoy_at_parking_structure"))
      n_index = 1;

    e_volume = a_volumes_infantry[n_index];
    b_node_occupied = isnodeoccupied(nd_goal);
    b_is_within_volume = is_point_inside_volume(nd_goal.origin, e_volume);

    if(!b_node_occupied && b_is_within_volume)
      b_has_goal = 1;
  }

  self set_goal_node(nd_goal);
  self waittill("goal");
}

shoot_target_until_out_of_view(e_target) {
  b_can_see_target = 1;

  while(b_can_see_target) {
    self aim_at_target(e_target, 1);
    v_eye = self get_eye();
    b_can_see_target = self is_looking_at(e_target.origin, undefined, 1);

    if(!isalive(e_target) || !b_can_see_target) {
      return;
    }
    self shoot_at_target(e_target);
    wait 1;
  }
}

attack_player_ai() {
  self endon("death");
  self.dropweapon = 0;
  self.goalradius = 64;
  self.a.rockets = 200;
  self waittill("goal");
  self shoot_at_target_untill_dead(level.player);
}

spawn_vehicles_from_targetname_and_gopath(str_name) {
  a_vehicles = maps\_vehicle::spawn_vehicles_from_targetname(str_name);
  assert(a_vehicles.size > 0, "spawn_vehicles_from_targetname_and_gopath found no vehicles with name " + str_name);

  for(i = 0; i < a_vehicles.size; i++) {
    assert(isDefined(a_vehicles[i].target), "spawn_vehicles_from_targetname_and_gopath found a vehicle not attached to spline at " + a_vehicles[i].origin);
    nd_temp = getvehiclenode(a_vehicles[i].target, "targetname");
    a_vehicles[i] thread go_path(nd_temp);
  }
}

molotov_throw(str_targetname, v_start, v_end) {
  assert(isDefined(str_targetname) || (isDefined(v_start) || isDefined(v_end)), "either str_targetname or v_start and v_end are required for molotov_throw function");

  if(isDefined(str_targetname))
    s_start = get_struct(str_targetname, "targetname", 1);

  if(!isDefined(v_start) && isDefined(s_start))
    v_start = s_start.origin;
  else if(!isDefined(v_start) && !isDefined(s_start))
    v_start = self.origin;

  if(!isDefined(v_end)) {
    s_end = get_struct(s_start.target, "targetname", 1);
    v_end = s_end.origin;
  }

  n_gravity = abs(getdvarint(#"bg_gravity")) * -1;
  v_throw = vectornormalize(v_end - v_start) * 700;
  n_dist = distance(v_start, v_end);
  n_time = n_dist / 700;
  v_delta = v_end - v_start;
  n_drop_from_gravity = 0.5 * n_gravity * (n_time * n_time);
  v_launch = (v_delta[0] / n_time, v_delta[1] / n_time, (v_delta[2] - n_drop_from_gravity) / n_time);
  self magicgrenadetype("molotov_sp", v_start, v_launch);
}

f35_pacing() {
  if(is_greenlight_build()) {
    level thread art_vtol_mode_settings();
    n_exposure = 2.99997;
    level.player setclientdvars("r_exposureTweak", 1, "r_exposureValue", n_exposure);
    flag_wait("introscreen_complete");
  }

  level thread maps\la_2_convoy::convoy_register_stop_point("convoy_roadblock_trigger", "roadblock_done", ::flag_set, "convoy_at_roadblock");
  level.f35 delay_thread(2, ::pip_start, "la_pip_seq_3", maps\la_2_anim::vo_pip_pacing);
  flag_wait("convoy_at_roadblock");

  while(distance2dsquared(level.convoy.leader.origin, level.player.origin) > 100000000)
    wait 0.05;

  flag_set("roadblock_done");
}

pip_start(str_bink_name, func_during_bink) {
  flag_waitopen("pip_playing");
  flag_set("pip_playing");
  level.f35.current_bink = str_bink_name;

  if(isDefined(level.f35.current_bink_id))
    stop3dcinematic(level.f35.current_bink_id);

  wait 0.1;
  maps\la_2_player_f35::f35_show_console("tag_display_message");
  thread maps\_glasses::play_bink_on_hud(str_bink_name, 0, 0);
  flag_wait("glasses_bink_playing");

  if(isDefined(func_during_bink))
    self thread[[func_during_bink]]();

  flag_waitopen("glasses_bink_playing");
  f35_show_console(undefined);
  flag_clear("pip_playing");
}

ambient_activity_warehouse_street() {
  trigger_wait("trig_ground_ambient_flybys_8");
  maps\_drones::drones_set_cheap_flag("warehouse_st_right_blockade", 1);
  maps\_drones::drones_set_cheap_flag("warehouse_st_blockade_lapd", 1);
  delay_thread(0.2, maps\_drones::drones_start, "warehouse_st_right_blockade");
  delay_thread(0.3, maps\_drones::drones_start, "warehouse_st_blockade_lapd");
  level.player delay_thread(3, ::molotov_throw, "warehouse_st_molotov_struct_1");
  level.player delay_thread(4, ::molotov_throw, "warehouse_st_molotov_struct_2");
  level.player delay_thread(5, ::molotov_throw, "warehouse_st_molotov_struct_3");
  level thread ambient_activitiy_stop_warehouse_st_left();
  level waittill("stop_ambient_activity_warehouse_street");
  maps\_drones::drones_delete("warehouse_st_right_blockade");
  maps\_drones::drones_delete("warehouse_st_blockade_lapd");
  a_lookat_triggers = get_ent_array("drones_warehouse_st_turn_kill_trigger_left", "targetname", 1);

  for(i = 0; i < a_lookat_triggers.size; i++)
    a_lookat_triggers[i] delete();
}

ambient_activitiy_stop_warehouse_st_left() {
  level waittill("stop_ambient_activity_warehouse_street_left");
  a_lookat_triggers = get_ent_array("drones_warehouse_st_turn_kill_trigger", "targetname", 1);

  for(i = 0; i < a_lookat_triggers.size; i++)
    a_lookat_triggers[i] delete();
}

ambient_activity_hotel_street() {
  level notify("stop_ambient_activity_warehouse_street");
  level notify("stop_ambient_activity_warehouse_street_left");
  wait 0.05;
  maps\_drones::drones_set_cheap_flag("hotel_street_breakthrough_drones", 1);
  maps\_drones::drones_set_cheap_flag("hotel_st_breakthrough_opposite", 1);
  maps\_drones::drones_set_cheap_flag("hotel_street_parking_lot_drones", 1);
  maps\_drones::drones_set_cheap_flag("hotel_street_breakthrough_lapd", 1);
  delay_thread(0.1, maps\_drones::drones_start, "hotel_street_breakthrough_drones");
  delay_thread(0.2, maps\_drones::drones_start, "hotel_st_breakthrough_opposite");
  delay_thread(0.3, maps\_drones::drones_start, "hotel_street_parking_lot_drones");
  delay_thread(0.4, maps\_drones::drones_start, "hotel_street_breakthrough_lapd");
  flag_wait("convoy_at_apartment_building");
  maps\_drones::drones_delete("hotel_street_building_drones");
  wait 0.1;
  maps\_drones::drones_delete("hotel_st_breakthrough_opposite");
  wait 0.1;
  maps\_drones::drones_delete("hotel_street_parking_lot_drones");
  wait 0.1;
  maps\_drones::drones_delete("hotel_street_breakthrough_lapd");
  wait 0.1;
  maps\_drones::drones_delete("hotel_street_breakthrough_drones");
}

ambient_activity_hotel_street_vehicles(e_triggered) {
  wait 2;
}

ambient_activity_hotel_street_turn() {
  maps\_drones::drones_set_cheap_flag("hotel_turn_drones", 1);
  maps\_drones::drones_set_cheap_flag("hotel_turn_drones_lapd", 1);
  delay_thread(0.1, maps\_drones::drones_start, "hotel_turn_drones");
  delay_thread(0.2, maps\_drones::drones_start, "hotel_turn_drones_lapd");
  maps\_drones::drones_delete("hotel_street_building_drones");
  wait 0.1;
  maps\_drones::drones_delete("hotel_st_breakthrough_opposite");
  wait 0.1;
  maps\_drones::drones_delete("hotel_street_parking_lot_drones");
  wait 0.1;
  maps\_drones::drones_delete("hotel_street_breakthrough_lapd");
  wait 0.1;
  maps\_drones::drones_delete("hotel_street_breakthrough_drones");
  maps\_drones::drones_delete("warehouse_st_right_blockade");
  maps\_drones::drones_delete("warehouse_st_blockade_lapd");
  flag_wait("convoy_at_apartment_building");
  maps\_drones::drones_delete("hotel_turn_drones");
  wait 0.1;
  maps\_drones::drones_delete("hotel_turn_drones_lapd");
}

ambient_activity_parking_structure() {
  t_radio_tower = get_ent("radio_tower_damage_trigger", "targetname");

  if(isDefined(t_radio_tower))
    fire_magic_rpg_struct("radio_tower_magic_damage_struct");

  maps\_drones::drones_set_cheap_flag("parking_structure_drones", 1);
  maps\_drones::drones_set_cheap_flag("parking_structure_lapd_drones", 1);
  delay_thread(0.1, maps\_drones::drones_start, "parking_structure_drones");
  delay_thread(0.3, maps\_drones::drones_start, "parking_structure_lapd_drones");
  flag_wait("player_passed_garage");
  maps\_drones::drones_delete("parking_structure_drones");
  maps\_drones::drones_delete("parking_structure_lapd_drones");
  a_axis_ai = getaiarray("axis");
  array_thread(a_axis_ai, ::mark_ai_for_death);
}

ambient_activity_park() {
  maps\_drones::drones_set_cheap_flag("park_terrorists", 1);
  maps\_drones::drones_start("park_terrorists");
  delay_thread(0.2, maps\_drones::drones_start, "park_lapd");
  flag_wait("player_passed_garage");
  maps\_drones::drones_delete("park_lapd");
  maps\_drones::drones_delete("park_terrorists");
}

fire_magic_rpg_struct(str_struct_name) {
  s_magic_bullet_start = get_struct(str_struct_name, "targetname", 1);
  s_magic_bullet_end = get_struct(s_magic_bullet_start.target, "targetname", 1);
  magicbullet("usrpg_magic_bullet_cheap_sp", s_magic_bullet_start.origin, s_magic_bullet_end.origin);
  return s_magic_bullet_end;
}

lapd_ai_hotel_turn(a_goals, a_fire_points) {
  self endon("death");
  b_found_node = 0;
  self.goalradius = 32;
  self.takedamage = 0;

  while(!b_found_node) {
    nd_goal = random(a_goals);

    if(!isnodeoccupied(nd_goal))
      b_found_node = 1;
  }

  self set_goal_node(nd_goal);
  self waittill("goal");
  self.takedamage = 1;

  while(true) {
    e_target = random(a_fire_points);
    n_fire_time = randomfloatrange(5, 10);
    self shoot_at_target(e_target, undefined, undefined, n_fire_time);
  }
}

ambient_activity_crane_street() {
  maps\_drones::drones_set_cheap_flag("crane_street_terrorists", 1);
  maps\_drones::drones_start("crane_street_terrorists");
  delay_thread(0.2, maps\_drones::drones_start, "crane_street_lapd");
  a_guys = getaiarray("axis");
  array_thread(a_guys, ::mark_ai_for_death);
  flag_wait("convoy_at_rooftops");
  maps\_drones::drones_delete("crane_street_lapd");
  maps\_drones::drones_delete("crane_street_terrorists");
}

f35_rooftops() {
  level thread maps\la_2_convoy::convoy_register_stop_point("convoy_waits_after_parking_garage", "player_passed_garage");
  level thread maps\la_2_convoy::convoy_register_stop_point("convoy_hotel_regroup_stop_trigger", "player_in_range_of_convoy", ::flag_set, "convoy_passed_roundabout");
  level thread add_trigger_function("hotel_street_ambient_trigger", ::ambient_activity_hotel_street);
  level thread add_trigger_function("hotel_street_turn_drones_trigger", ::ambient_activity_hotel_street_turn);
  level thread add_trigger_function("drones_in_the_park_trigger", ::ambient_activity_park);
  level thread add_flag_function("convoy_at_parking_structure", ::ambient_activity_parking_structure);
  level thread add_trigger_function("parking_structure_ambient_drones_trigger", ::ambient_activity_parking_structure);
  level thread add_trigger_function("convoy_waits_after_crane_building_trigger", ::pre_building_collapse_event);
  autosave_by_name("la_2_rooftops");
  level thread vo_rooftops();
  level thread rooftop_ai_setup();
  level thread crane_building_spawner();
  level thread ambient_activity_hotel_street_vehicles();
  flag_wait("player_passed_garage");
  autosave_by_name("la_2_rooftops_b");
  level thread maps\la_2_anim::vo_after_parking_structure();
  level thread maps\la_2_convoy::convoy_register_stop_point("convoy_rooftops_stop_trigger", "convoy_at_rooftops", ::convoy_waits_after_crane_building);
  level thread building_collapse_planes_fly_in();
  flag_wait("player_at_convoy_end");
}

building_collapse_planes_fly_in() {
  s_convoy_dust = getstruct("convoy_dust_align", "targetname");
  exploder(10951);
  playfx(getfx("convoy_dust"), s_convoy_dust.origin);
  level notify("fxanim_bldg_convoy_block_start");
  delay_thread(0.1, ::spawn_vehicles_from_targetname_and_gopath, "building_collapse_fly_in_planes");
}

pre_building_collapse_event() {
  t_vehicle_spawner = get_ent("building_collapse_event_vehicle_spawner", "targetname", 1);
  t_vehicle_spawner_2 = get_ent("building_collapse_battle_vehicle_trigger", "targetname", 1);
  maps\_drones::drones_set_cheap_flag("building_collapse_battle_axis", 1);
  maps\_drones::drones_set_cheap_flag("building_collapse_battle_allies", 1);
  maps\_drones::drones_start("pre_building_collapse_drones");
  delay_thread(0.2, maps\_drones::drones_start, "building_collapse_battle_axis");
  delay_thread(0.4, maps\_drones::drones_start, "building_collapse_battle_allies");
  level waittill("kill_pre_building_collapse_drones");
  maps\_drones::drones_delete("building_collapse_battle_axis");
  maps\_drones::drones_delete("building_collapse_battle_allies");
  a_triggers = get_ent_array("pre_building_collapse_drones_lookat_kill_triggers", "targetname", 1);

  for(i = 0; i < a_triggers.size; i++)
    a_triggers[i] delete();
}

convoy_waits_after_crane_building() {
  t_wait = get_ent("convoy_waits_after_crane_building_trigger", "targetname", 1);
  b_player_hit_trigger = 0;

  if(!flag("convoy_at_rooftops")) {
    while(!b_player_hit_trigger) {
      t_wait waittill("trigger", e_triggered);

      if(isplayer(e_triggered))
        b_player_hit_trigger = 1;
    }

    flag_set("convoy_at_rooftops");
  }
}

crane_building_spawner() {
  t_crane_building = get_ent("crane_building_lookat_trigger", "targetname", 1);
  b_spawn_ready = 0;
  level thread _crane_building_helicopter();

  while(!b_spawn_ready) {
    t_crane_building waittill("trigger");
    n_distance_current = distance(t_crane_building.origin, level.player.origin);

    if(n_distance_current < 15000)
      level notify("spawn_crane_building_heli");

    if(n_distance_current < 7500)
      b_spawn_ready = 1;
  }

  if(!flag("convoy_at_dogfight")) {
  }

  t_crane_building delete();
}

_crane_building_helicopter() {
  t_proximity = get_ent("crane_building_helicopter_trigger", "targetname", 1);
  level thread maps\_load_common::trigger_notify(t_proximity, "spawn_crane_building_heli");
  delay_thread(3, ::set_flag_on_trigger, t_proximity, "player_passed_garage");
  level waittill("spawn_crane_building_heli");

  if(!flag("convoy_at_dogfight")) {
    vh_helicopter = maps\_vehicle::spawn_vehicle_from_targetname("crane_building_helicopter");
    vh_helicopter_2 = maps\_vehicle::spawn_vehicle_from_targetname("crane_building_helicopter_2");
    nd_path = getvehiclenode(vh_helicopter.target, "targetname");
    vh_helicopter.cur_target = level.player;
    vh_helicopter thread maps\_helicopter_ai::helicopter_fire_update2();
    vh_helicopter thread heli_shoot_at_crane();
    vh_helicopter thread go_path(nd_path);
    vh_helicopter thread heli_triggers_crane_fall();
    nd_path_2 = getvehiclenode(vh_helicopter_2.target, "targetname");
    vh_helicopter_2.cur_target = level.convoy.potus;
    vh_helicopter_2 thread maps\_helicopter_ai::helicopter_fire_update2();
    vh_helicopter_2 thread go_path(nd_path_2);
    vh_helicopter = get_ent("crane_building_helicopter", "targetname");
  }
}

weapon_index_test() {
  for(i = 0; i < 5; i++) {
    str_weapon = self seatgetweapon(i);

    if(!isDefined(str_weapon))
      str_weapon = "NONE";

    iprintlnbold(str_weapon + " at seat index " + i);
  }
}

heli_shoot_at_crane() {
  self endon("death");
  wait 2;
  t_crane = get_ent("rooftop_crane_trigger", "targetname");

  if(isDefined(t_crane)) {
    self setgunnertargetent(t_crane, (0, 0, 0), 0);
    self setgunnertargetent(t_crane, (0, 0, 0), 1);
    self firegunnerweapon(0);
    self firegunnerweapon(1);
    wait 1;
    t_crane dodamage(9999, t_crane.origin, level.player);
  }
}

heli_triggers_crane_fall() {
  level endon("start_dogfight_event");
  s_crash_point = get_struct("crane_building_helicopter_crash_point", "targetname", 1);
  self waittill("death");
  self thread _heli_crash_sanity_check(s_crash_point);

  if(!isDefined(self)) {
    return;
  }
  self waittill_either("crash_move_done", "missed_rooftop");
  t_crane = get_ent("rooftop_crane_trigger", "targetname");

  if(isDefined(t_crane))
    t_crane dodamage(9999, t_crane.origin, level.player);
}

heli_crash_audio() {
  self waittill("death");

  if(isDefined(self)) {
    self playsound("evt_heli_crash");
    self waittill("crash_move_done");
    self stopsound("evt_heli_crash");
  }
}

_heli_crash_sanity_check(s_reference) {
  self endon("missed_rooftop");
  self endon("crash_move_done");
  self endon("death");

  while(true) {
    if(!isDefined(self)) {
      return;
    }
    n_dot_up = self get_dot_up(s_reference.origin);

    if(n_dot_up > 0)
      self notify("missed_rooftop");

    wait 0.05;
  }
}

helicopter_rappel_unload(func_ai_custom) {
  self endon("death");
  self.rappel_unloading_done = 0;
  self.originheightoffset = 75;

  if(!isDefined(func_ai_custom))
    func_ai_custom = ::crane_building_ai_func;
}

land_heli() {
  self setneargoalnotifydist(12);
  self sethoverparams(0, 0, 10);
  self cleargoalyaw();
  self settargetyaw(flat_angle(self.angles)[1]);
  self setvehgoalpos_wrap(bullettrace(self.origin, self.origin + vectorscale((0, 0, -1), 100000.0), 0, self)["position"], 1);
  self waittill("near_goal");
}

crane_building_ai_func() {
  self endon("death");
  self waittill("jumpedout");
  a_goals = getnodearray("crane_building_edge_nodes", "script_noteworthy");
  assert(a_goals.size > 0, "a_goals missing in crane_building_ai_func!");
  b_found_goal = 0;

  while(!b_found_goal) {
    wait(randomfloatrange(0.1, 0.6));
    nd_goal = random(a_goals);

    if(!isnodeoccupied(nd_goal))
      b_found_goal = 1;
  }

  self set_goalradius(32);
  self set_ignoreall(1);
  self setgoalnode(nd_goal);
  self waittill("goal");
  self set_ignoreall(0);
  self thread attack_convoy_leader_ai();
}

heli_populate_passengers(n_guys, str_value, str_key, func_spawn) {
  assert(isDefined(n_guys), "n_guys is a required parameter for heli_populate_passengers!");
  assert(isDefined(str_value), "str_value is a required parameter for heli_populate_passengers!");
  assert(isDefined(str_key), "str_key is a required parameter for heli_populate_passengers!");
  assert(isDefined(func_spawn), "func_spawn is a required parameter for heli_populate_passengers!");
  sp_passenger = get_ent(str_value, str_key, 1);

  if(!isDefined(self)) {
    return;
  }
  for(i = 0; i < n_guys; i++) {
    ai_temp = simple_spawn_single(sp_passenger, func_spawn);
    ai_temp enter_vehicle(self);
    wait_network_frame();
  }
}

_kill_drones_after_convoy_passes(str_trigger_name, str_drone_name) {
  assert(isDefined(str_trigger_name), "str_trigger_name is a required parameter fo _kill_drones_after_convoy_passes");
  assert(isDefined(str_drone_name), "str_drone_name is a required parameter for _kill_drones_after_convoy_passes");
  t_kill = get_ent(str_trigger_name, "targetname", 1);
  t_kill maps\la_2_convoy::_waittill_triggered_by_convoy();
  maps\_drones::drones_delete(str_drone_name);
}

rooftop_ai_setup() {
  a_aigroup_names = array("parking_garage_floor_4", "parking_garage_van_1", "parking_garage_floor_3", "parking_garage_stairs", "rooftop_near", "rooftop_far");
  maps\_objectives::set_objective(level.obj_roadblock, undefined, "delete");
  n_objective_counter = a_aigroup_names.size;
  level.rooftop_objective_counter = n_objective_counter;
  t_apartments = get_ent("rooftop_apartment_guys_move_trigger", "targetname", 1);
  t_apartments maps\la_2_convoy::_waittill_triggered_by_convoy();
  flag_set("convoy_at_apartment_building");
  t_parking_structure = get_ent("convoy_at_parking_structure_trigger", "targetname", 1);
  t_parking_structure_vehicle = get_ent("convoy_at_parking_structure_trigger_vehicle", "targetname", 1);
  t_parking_structure_vehicle notify("trigger");
  flag_set("convoy_at_parking_structure");
  wait 0.2;
  t_kill_spawn_managers = get_ent("convoy_waits_after_parking_garage", "targetname", 1);
  t_kill_spawn_managers maps\la_2_convoy::_waittill_triggered_by_convoy();
  a_rooftops_guys = get_ent_array("rooftop_start_guys", "script_noteworthy");
  spread_array_thread(a_rooftops_guys, ::mark_ai_for_death);
  a_rooftops_end = get_ent("convoy_dogfight_stop_trigger", "targetname", 1);
  a_rooftops_end maps\la_2_convoy::_waittill_triggered_by_convoy(1);
  a_crane_building_guys = get_ent_array("crane_building_guys", "script_noteworthy");
  spread_array_thread(a_crane_building_guys, ::mark_ai_for_death);
  flag_set("player_at_convoy_end");
}

stop_at_spline_end() {
  if(self != level.convoy.vh_van) {
    self endon("death");
    self waittill_either("reached_end_node", "brake");
    self setspeed(0);
    self vehicle_unload();
  }
}

mark_ai_for_death() {
  self endon("death");
  b_is_spawner = isspawner(self);

  if(b_is_spawner) {
    println("mark_ai_for_death deleting spawner at " + self.origin);

    self delete();
    return;
  }

  wait(randomfloatrange(0.1, 5.0));
  b_can_see_target = 1;

  while(b_can_see_target) {
    b_is_alive = isalive(self);

    if(!b_is_alive) {
      return;
    }
    b_can_see_target = level.player is_looking_at(self.origin);
    wait 1;
  }

  println("mark_ai_for_death killing AI at " + self.origin);

  if(isalive(self))
    self dodamage(self.health, self.origin);
}

rooftop_ai_individual_objective(str_group_name) {
  b_should_loop = 1;
  b_has_setup_objective = 0;
  b_track_objective = 0;
  b_is_new_guy = 1;

  while(b_should_loop) {
    a_guys = get_ai_group_ai(str_group_name);
    n_living_count = a_guys.size;
    n_total_count = get_ai_group_count(str_group_name);

    if(n_living_count == 0 && n_total_count == 0)
      b_should_loop = 0;

    if(n_total_count == n_living_count)
      b_track_objective = 1;

    if(b_track_objective && n_living_count > 0) {
      e_temp = get_closest_living(level.f35.origin, a_guys);

      if(!b_has_setup_objective) {
        maps\_objectives::set_objective(level.obj_rooftops, e_temp, "kill", -1);
        b_has_setup_objective = 1;
      }

      maps\_objectives::set_objective(level.obj_rooftops, e_temp, "kill");
      e_temp waittill("death");
      maps\_objectives::set_objective(level.obj_rooftops, e_temp, "remove");
      continue;
    }

    wait 1;
  }

  level.rooftop_objective_counter--;

  if(level.rooftop_objective_counter == 0) {
    maps\_objectives::set_objective(level.obj_rooftops, undefined, "delete");
    maps\_drones::drones_delete("drone_trigger_example_2");
    flag_set("rooftop_enemies_dead");
  } else
    maps\_objectives::set_objective(level.obj_rooftops, undefined, undefined, level.rooftop_objective_counter);
}

convoy_blocked_by_debris() {
  flag_wait("building_collapse_done");
  level notify("kill_pre_building_collapse_drones");
  a_ground_vehicles = get_ent_array("building_collapse_truck", "targetname");
  a_ground_vehicles[a_ground_vehicles.size] = get_ent("building_collapse_bigrig", "targetname");
  array_thread(a_ground_vehicles, ::do_vehicle_damage, 9999, level.convoy.vh_potus, "explosive");
  a_axis_ai = getaiarray("axis");
  array_thread(a_axis_ai, ::mark_ai_for_death);
}

f35_trenchrun() {
  maps\createart\la_2_art::art_vtol_mode_settings();
  level thread maps\la_2_convoy::convoy_register_stop_point("convoy_trenchrun_stop_trigger", "trenchruns_start", ::flag_set, "convoy_at_trenchrun");
  t_one = get_ent("trenchruns_plane_trigger_2", "targetname", 1);
  t_two = get_ent("trenchruns_plane_trigger_3", "targetname", 1);
  flag_wait("convoy_at_trenchrun");
  scale_model_lods(1, 1);
  b_player_within_range = 0;
  n_distance_sq = 8000 * 8000;

  while(!b_player_within_range) {
    n_distance_current_sq = distancesquared(level.convoy.vh_potus.origin, level.player.origin);

    if(n_distance_sq > n_distance_current_sq)
      b_player_within_range = 1;

    wait 0.1;
  }

  while(!level.f35.is_vtol)
    wait 0.25;

  wait 2;
  flag_set("trenchruns_start");
  level.player thread maps\la_2_player_f35::f35_tutorial(0, 0, 1, 1);
  level thread maps\la_2_anim::vo_trenchruns();
  n_trenchrun_planes = 10;
  maps\_objectives::set_objective(level.obj_trenchrun_1, undefined, undefined);
  v_offset = vectorscale((1, 1, 1), 30.0);
  level.trenchrun_wave = 1;
  delay_thread(0.5, ::spawn_trenchrun_plane, "avenger_fast_la2", "trenchrun_spline_low_1", 300, v_offset, 1);
  t_one maps\la_2_convoy::_waittill_triggered_by_convoy();
  maps\_objectives::set_objective(level.obj_trenchrun_1, undefined, "delete");
  level.trenchrun_wave = 2;
  flag_set("convoy_at_trenchrun_turn_2");
  delay_thread(1.0, ::spawn_trenchrun_plane, "avenger_fast_la2", "trenchrun_spline_low_2a", 250, v_offset, 1);
  t_two maps\la_2_convoy::_waittill_triggered_by_convoy();
  maps\_objectives::set_objective(level.obj_trenchrun_2, undefined, "delete");
  level.trenchrun_wave = 3;
  flag_set("convoy_at_trenchrun_turn_3");
  delay_thread(1.0, ::spawn_trenchrun_plane, "avenger_fast_la2", "trenchrun_spline_low_3", 250, v_offset, 1);
  delay_thread(4.5, ::spawn_trenchrun_plane, "avenger_fast_la2", "trenchrun_spline_low_3b", 250, v_offset, 1);
  n_max_wait = 17;
  delay_thread(n_max_wait, maps\_objectives::set_objective, level.obj_trenchrun_3, undefined, "delete");
  delay_thread(n_max_wait, ::flag_set, "trenchrun_done");
}

do_vehicle_damage(n_amount, e_attacker, str_damage_type) {
  if(isDefined(self.armor))
    self.armor = self.armor - n_amount;

  if(!isDefined(str_damage_type))
    str_damage_type = "explosive";

  self dodamage(n_amount, self.origin, e_attacker, e_attacker, str_damage_type);
}

spawn_trenchrun_plane(str_spawner_name, str_start_point, n_speed, v_offset, n_update_time, b_track) {
  assert(isDefined(str_spawner_name), "str_spawner_name is a required argument for spawn_trenchrun_plane!");
  assert(isDefined(str_start_point), "str_start_point is a required argument for spawn_trenchrun_plane!");
  sp_vehicle = get_vehicle_spawner(str_spawner_name, "targetname");
  nd_start = getvehiclenode(str_start_point, "targetname");

  if(!isDefined(sp_vehicle.angles))
    sp_vehicle.angles = (0, 0, 0);

  if(!isDefined(nd_start.angles))
    nd_start.angles = (0, 0, 0);

  if(!isDefined(n_speed))
    n_speed = 250;

  if(!isDefined(b_track))
    b_track = 1;

  v_origin_old = sp_vehicle.origin;
  v_angles_old = sp_vehicle.angles;
  sp_vehicle.origin = nd_start.origin;
  sp_vehicle.angles = nd_start.angles;
  vh_plane = maps\_vehicle::spawn_vehicle_from_targetname(str_spawner_name);
  vh_plane thread trenchrun_sanity_check();
  vh_plane endon("death");

  if(b_track) {
    if(!isDefined(level.trenchrun_planes))
      level.trenchrun_planes = [];

    level.trenchrun_planes[level.trenchrun_planes.size] = vh_plane;
  }

  sp_vehicle.origin = v_origin_old;
  sp_vehicle.angles = v_angles_old;
  vh_plane setspeed(n_speed, 1000, 1000);
  target_set(vh_plane);
  vh_plane enableaimassist();
  vh_convoy_leader = maps\la_2_convoy::convoy_get_leader();
  vh_plane.using_ai = 0;
  vh_plane thread _trenchrun_update_goal_pos(10192);

  if(isDefined(v_offset) && !isDefined(n_update_time))
    vh_plane pathfixedoffset(v_offset);
  else if(isDefined(v_offset) && isDefined(n_update_time))
    vh_plane pathvariableoffset(v_offset, n_update_time);

  vh_plane setneargoalnotifydist(700);
  vh_plane thread go_path(nd_start);
  vh_plane waittill("reached_end_node");
  vh_plane.using_ai = 1;
  vh_plane notify("stop_ambient_behavior");
  vh_plane.no_tracking = 1;
  vh_plane clearvehgoalpos();
  vh_plane setspeed(n_speed, 1000, 1000);
  vh_plane waittill("near_goal");
  vh_convoy_leader = vh_plane.suicide_target;
  vh_plane.takedamage = 1;
  vh_plane dodamage(vh_plane.health + 1000, vh_plane.origin, vh_convoy_leader, vh_convoy_leader, "explosive");

  if(vh_convoy_leader == level.convoy.vh_potus) {
  }

  vh_convoy_leader do_vehicle_damage(vh_convoy_leader.armor, vh_plane);
}

trenchrun_sanity_check() {
  self endon("death");

  while(!isDefined(self.suicide_target))
    wait 0.1;

  while(true) {
    n_distance = distance(self.origin, self.suicide_target.origin);
    b_too_close = n_distance < 1500;

    if(b_too_close) {
      wait 2.5;

      println("trenchrun sanity check failed!");

      self dodamage(self.health + 9999, self.origin, self.suicide_target, self.suicide_target, "explosive");
    }

    wait 0.1;
  }
}

_print_goal_line(s_goal, n_red, n_green, n_blue, n_refresh_time) {
  self notify("_kill_goal_line");
  self endon("_kill_goal_line");
  self endon("death");

  if(!isDefined(n_red))
    n_red = 1;

  if(!isDefined(n_green))
    n_green = 1;

  if(!isDefined(n_blue))
    n_blue = 1;

  if(!isDefined(n_refresh_time))
    n_refresh_time = 1;

  while(true) {
    n_distance = distance(self.origin, s_goal.origin);
    self thread draw_line_for_time(self.origin, s_goal.origin, n_red, n_green, n_blue, n_refresh_time);
    wait(n_refresh_time);
  }

}

_trenchrun_update_goal_pos(n_near_goal_draw_red_line) {
  self endon("death");
  n_time = 0.5;
  n_r = 1;
  n_g = 0.55;
  n_b = 0;
  b_first_run = 1;

  while(true) {
    e_target = maps\la_2_convoy::convoy_get_leader();
    self.suicide_target = e_target;

    if(is_alive(e_target)) {
      n_speed = e_target getspeedmph();
      v_forward = anglestoforward(e_target.angles);
      v_predicted_location = e_target.origin + v_forward * n_speed * n_time;
      n_distance = distance(self.origin, e_target.origin);

      if(n_distance < n_near_goal_draw_red_line) {
        n_r = 1;
        n_g = 0;
        n_b = 0;
      }

      if(self.using_ai)
        self setvehgoalpos(v_predicted_location);
    }

    wait 0.05;
  }
}

trenchrun_draw_line(e_target, n_distance_to_red) {
  self endon("death");
  self thread _print_goal_line(e_target, 1, 0.55, 0, 0.05);

  while(true) {
    n_distance = distance(self.origin, e_target.origin);

    if(n_distance < n_distance_to_red)
      self thread _print_goal_line(e_target, 1, 0, 0, 0.05);

    wait 0.05;
  }

}

trenchrun_add_objective_to_plane() {
  if(!isDefined(level.trenchrun_wave))
    level.trenchrun_wave = 1;

  n_wave = level.trenchrun_wave;

  if(n_wave == 1)
    n_objective = level.obj_trenchrun_1;
  else if(n_wave == 2)
    n_objective = level.obj_trenchrun_2;
  else if(n_wave == 3)
    n_objective = level.obj_trenchrun_3;
  else if(n_wave == 4)
    n_objective = level.obj_trenchrun_4;
  else {
    assertmsg("trenchrun wave " + n_wave + " not supported");

  }

  maps\_objectives::set_objective(n_objective, self, "", -1);
  self waittill("death");
  maps\_objectives::set_objective(n_objective, self, "remove");
}

f35_hotel() {
  level thread maps\la_2_convoy::convoy_register_stop_point("convoy_hotel_stop_trigger", "hotel_done", ::flag_set, "convoy_at_hotel");
  flag_wait("convoy_at_hotel");

  for(i = 0; i < level.convoy.vehicles.size; i++) {
    level.convoy.vehicles[i] notify("convoy_stop");
    level.convoy.vehicles[i] ent_flag_clear("is_moving");
  }

  level.convoy.vh_van notify("convoy_stop");
  flag_wait("trenchrun_done");
  level.f35 notify("stop_turret_shoot");
  level.player notify("turretownerchange");
  wait 2;
  delay_thread(0.5, maps\la_2_anim::vo_hotel);
  v_offset = vectorscale((1, 1, 1), 30.0);
  level.trenchrun_wave = 4;
  delay_thread(2.5, ::spawn_trenchrun_plane, "avenger_fast_la2", "trenchrun_spline_low_4b", 200, v_offset, 1);
  delay_thread(4.9, ::spawn_trenchrun_plane, "avenger_fast_la2", "trenchrun_spline_low_4c", 200, v_offset, 1);
  wait 10;

  while(level.trenchrun_planes.size > 0) {
    wait 1;
    level.trenchrun_planes = array_removedead(level.trenchrun_planes);
  }

  level.f35 thread say_dialog("nose_cannons_offli_038");
  level.f35 notify("stop_f35_minigun");
  flag_set("hotel_done");
}

f35_eject() {
  level thread spawn_ambient_drones("trig_eject_parachute_flyby_1", "trig_kill_parachute_flyby_1", "pegasus_eject_parachute_flyby_1", "f38_eject_parachute_flyby_1", "start_eject_parachute_flyby_1", 2, 4, 1.5, 2, 450);
  level thread spawn_ambient_drones("trig_eject_parachute_flyby_3", "trig_kill_parachute_flyby_3", "pegasus_eject_parachute_flyby_3", "f38_eject_parachute_flyby_3", "start_eject_parachute_flyby_3", 2, 4, 1, 1.5, 550);
  level thread spawn_ambient_drones("trig_eject_parachute_flyby_4", "trig_kill_parachute_flyby_4", "pegasus_eject_parachute_flyby_4", "f38_eject_parachute_flyby_4", "start_eject_parachute_flyby_4", 1, 6, 2, 3, 400);
  level.player setclientdvar("cg_aggressiveCullRadius", 1000);
  f35_show_console("tag_display_malfunction");
  level thread maps\la_2_anim::vo_plane_very_damaged();
  wait 3;
  f35_eject_eject();
  f35_eject_collision();
  maps\_objectives::set_objective(level.obj_trenchrun_4, undefined, "delete");
  flag_set("eject_done");
}

eject_wait_for_player_position() {
  a_eject_drone_starts = getvehiclenodearray("eject_sequence_spline", "script_noteworthy");
  nd_spline_start = a_eject_drone_starts[0];

  do {
    b_spawn_ready = 0;
    wait 0.2;
    waittill_player_near_convoy_and_f35_for_eject();

    foreach(nd_start_node in a_eject_drone_starts) {
      if(distance2dsquared(level.f35.origin, nd_start_node.origin) > distance2dsquared(level.f35.origin, nd_spline_start.origin))
        nd_spline_start = nd_start_node;
    }

    is_clear = bullettracepassed(level.f35.origin, nd_spline_start.origin, 0, level.f35);

    if(is_clear && level.player is_looking_at(level.convoy.leader, 0.7, 0))
      b_spawn_ready = 1;
  }
  while(!b_spawn_ready);

  return nd_spline_start;
}

waittill_player_near_convoy_and_f35_for_eject() {
  s_facing_pos = getstruct("eject_facing_pos", "targetname");
  vh_friendly = getentarray("convoy_f35_ally_4", "targetname")[0];

  do {
    b_facing_drone = 0;

    while(!isDefined(vh_friendly)) {
      vh_friendly = getentarray("convoy_f35_ally_4", "targetname")[0];
      wait 0.05;
    }

    wait 0.2;

    if(isDefined(vh_friendly)) {
      n_dist = distance2dsquared(level.f35.origin, level.convoy.vh_potus.origin);
      n_f35_dist = distancesquared(level.f35.origin, vh_friendly.origin);

      if(n_dist <= 225000000 && n_f35_dist <= 225000000) {
        v_player_to_plane = vectornormalize(vh_friendly.origin - level.f35.origin);
        v_plane_forward = vectornormalize(anglestoforward(vh_friendly.angles));
        v_player_forward = vectornormalize(anglestoforward(level.f35.angles));

        if(vectordot(v_player_to_plane, v_plane_forward) > 0.7) {
          if(vectordot(v_plane_forward, v_player_forward) > 0.8)
            b_facing_drone = 1;
        }
      }
    }
  }
  while(!b_facing_drone);
}

#using_animtree("vehicles");

eject_move_align_struct(nd_start) {
  s_align = getstruct("align_eject_sequence", "targetname");
  n_speed = level.f35 getmaxspeed();
  n_time = getanimlength( % v_la_10_01_f35eject_drone_intro) + 2;
  n_eject_offset = n_speed * n_time;
  v_player_to_node = vectornormalize(nd_start.origin - level.f35.origin);
  v_start_point = nd_start.origin;
  s_align.origin = v_start_point;
  v_rotate_to = vectortoangles(v_player_to_node);
  v_rotate_to = (0, v_rotate_to[1], v_rotate_to[2]);
  v_rotate_to = (v_rotate_to[0], v_rotate_to[1], 0);
  s_align.angles = v_rotate_to;
}

f35_eject_intro() {
  s_align = getstruct("align_eject_sequence", "targetname");
  level notify("kill_ambient_drone_spawn_manager");
  level notify("kill_attacking_drones");
  level.f35 notify("stop_f35_minigun");
  level.f35 notify("stop_turret_shoot");
  level clientnotify("set_eject_fog_bank");
  level thread f35_eject_enemies_fly_away();
  m_linkto = spawn_model("tag_origin", level.f35.origin, level.f35.angles);
  m_linkto.targetname = "eject_align_origin";
  m_linkto linkto(level.f35, "tag_origin");
  m_lookat = spawn_model("tag_origin", s_align.origin, s_align.angles);
  v_to_goal = vectortoangles(s_align.origin - level.f35.origin);
  level.f35 cancelaimove();
  level.f35 setphysangles((0, v_to_goal[1], 0));
  level.f35 setvehicletype("plane_f35_player_vtol_dogfight");
  level.f35 setvehicleavoidance(1);
  level.f35 setspeedimmediate(200, 500);
  level.f35 setvehgoalpos(s_align.origin, 0);
  vh_plane = maps\_vehicle::spawn_vehicle_from_targetname("eject_sequence_drone");
  wait 0.1;
  vh_plane setmodel("veh_t6_drone_avenger_x2");
  vh_plane linkto(m_linkto);
  playfxontag(level._effect["drone_damaged_state"], vh_plane, "tag_origin");
  add_scene_properties("f35_eject_drone_intro", "eject_align_origin");
  level thread maps\_scene::run_scene("f35_eject_drone_intro");
  level thread maps\la_2_anim::vo_eject();
  flag_set("eject_drone_spawned");
  vh_plane thread f35_eject_highlight_drone();
  vh_plane thread eject_plan_fire_before_eject();
  maps\_scene::scene_wait("f35_eject_drone_intro");
}

test() {
  self endon("death");

  while(true) {
    level.f35 setangularvelocity((0, 0, 0));
    level.f35 setphysangles((0, self.angles[1], 0));
    wait 0.05;
  }
}

f35_eject_intro_test() {
}

f35_eject_enemies_fly_away() {
}

f35_eject_highlight_drone() {
  level.player notify("missileTurret_off");
  level.player maps\_lockonmissileturret::clearlockontarget();
  target_set(self);
  level.player weaponlockstart(self);
  wait 2;
  level.player weaponlockfinalize(self);
}

f35_eject_eject() {
  f35_eject_sequence_setup();
  level.f35.supportsanimscripted = 1;
  level.f35 thread maps\la_2_anim::vo_eject_f35();
  add_scene_properties("F35_eject", "eject_align_origin");
  level thread f35_eject_player();
  level thread maps\_scene::run_scene("F35_eject");
  wait 0.1;
  flag_set("eject_sequence_started");
  maps\_scene::scene_wait("F35_eject");
  vh_plane = get_ent("eject_sequence_drone", "targetname", 1);
  vh_plane unlink();
}

f35_eject_player() {
  m_linkto = spawn_model("tag_origin", level.f35.origin, level.f35.angles);
  m_linkto.targetname = "eject_align_origin";
  m_linkto linkto(level.f35, "tag_origin");
  level.player.body = spawn_anim_model("player_body", level.player.origin);
  level.player.body.angles = level.player.angles;
  m_linkto maps\_anim::anim_first_frame(level.player.body, "f35_eject_start");
  level.player.body linkto(m_linkto);
  wait 0.05;
  m_linkto thread maps\_anim::anim_single_aligned(level.player.body, "f35_eject_start");
  wait 0.05;
  level.f35 useby(level.player);
  level.player playerlinktoabsolute(level.player.body, "tag_player");
  level thread player_exits_f35();
}

f35_eject_collision() {
  level notify("midair_collision_started");
  level clientnotify("set_outro_fog_bank");
  f35_eject_warp_plane_to_collision();
  level.f35 unlink();
  level.player unlink();
  level thread maps\_audio::switch_music_wait("LA_2_PARACHUTE", 0.5);
  level.f35 hidepart("tag_canopy");
  level thread maps\_scene::run_scene("midair_collision");
  m_player_body = get_model_or_models_from_scene("midair_collision", "player_body");
  playfxontag(level._effect["ejection_seat_rocket"], m_player_body, "J_SpineLower");
  playfxontag(level._effect["f38_eject_trail"], level.f35, "tag_origin");
  level thread maps\la_2_anim::vo_eject_collision();
  maps\_scene::scene_wait("midair_collision");
}

f38s_play_exhaust() {
  wait 5;

  for(i = 2; i < 5; i++) {
    f35 = getent("f35_" + i, "targetname");

    if(isDefined(f35))
      playfxontag(level._effect["f38_afterburner"], f35, "tag_origin");
  }
}

f35_eject_warp_plane_to_collision() {
  s_align = getstruct("anim_end_struct", "targetname");
  m_linkto = getent("eject_align_origin", "targetname");
  v_start_origin = getstartorigin(s_align.origin, s_align.angles, % v_la_10_01_f35eject_f35);
  v_start_angles = getstartangles(s_align.origin, s_align.angles, % v_la_10_01_f35eject_f35);
  level.player thread fadetoblackforxsec(0, 0.05, 0.05, 0.4);
  m_linkto.origin = v_start_origin;
  m_linkto.angles = v_start_angles;
}

f35_eject_sequence_setup() {
  level.convoy.vh_van notify("unload");
  level.f35 play_fx("f35_console_blinking", undefined, undefined, "health_at_max", 1, "tag_origin");
  f35_show_console("tag_display_eject");
  level.player setclientdvar("cg_fov", 70);
  level.player enableinvulnerability();
  level.player takeallweapons();
  luinotifyevent(&"hud_f35_end");
  level thread maps\createart\la_2_art::eject();
  exploder(600);

  if(flag("harper_dead"))
    exploder(710);
  else
    exploder(700);
}

f35_intercepts_drone() {
  level endon("midair_collision_started");
  level waittill("eject_sequence_ready");
  vh_drone = get_ent("eject_sequence_drone", "targetname", 1);
  vh_drone.supportsanimscripted = 1;
  player_exits_f35();
  flag_set("eject_sequence_started");
  wait 0.25;
  level.f35 cancelaimove();
  level.f35 setspeed(200);
  m_linkto = spawn_model("tag_origin", level.f35.origin, level.f35.angles);
  level.f35 linkto(m_linkto);
  n_moveto_time = distance(level.f35.origin, vh_drone.origin) / (200 * 20);
  v_f35_to_drone = vectornormalize(vh_drone.origin - level.f35.origin);
  v_rotate_to = vectortoangles(v_f35_to_drone);
  m_linkto moveto(vh_drone.origin, n_moveto_time);
  m_linkto rotateto(v_rotate_to, 1, 0.25, 0.25);

  while(1024 < distance(level.f35.origin, vh_drone.origin))
    wait 0.05;

  level.convoy.vh_potus.takedamage = 0;
  level.f35 do_vehicle_damage(level.f35.health_regen.health, vh_drone);
  vh_drone do_vehicle_damage(vh_drone.health, level.f35);
}

eject_drone_spawn() {
  v_offset = undefined;
  n_update_time = undefined;
  level.convoy.leader = level.convoy.vh_potus;
  level.convoy.leader.takedamage = 1;
  maps\_lockonmissileturret::disablelockon();
  level.missile_lock_on_range = undefined;
  a_eject_drone_starts = getvehiclenodearray("eject_sequence_spline", "script_noteworthy");
  nd_spline_start = a_eject_drone_starts[0];

  do {
    b_spawn_ready = 0;
    wait 0.2;
    waittill_player_near_convoy_and_f35_for_eject();

    foreach(nd_start_node in a_eject_drone_starts) {
      if(distance2dsquared(level.f35.origin, nd_start_node.origin) > distance2dsquared(level.f35.origin, nd_spline_start.origin))
        nd_spline_start = nd_start_node;
    }

    if(level.player is_looking_at(level.convoy.leader, 0.7, 1))
      b_spawn_ready = 1;
  }
  while(!b_spawn_ready);

  flag_set("eject_drone_spawned");
  level thread spawn_trenchrun_plane("eject_sequence_drone", nd_spline_start.targetname, 200, v_offset, n_update_time);
  wait 0.1;
  level thread maps\la_2_anim::vo_no_guns();
  vh_plane = get_ent("eject_sequence_drone", "targetname", 1);
  vh_plane setmodel("veh_t6_drone_avenger_x2");
  vh_plane thread eject_plan_fire_before_eject();
  vh_friendly = getentarray("convoy_f35_ally_4", "targetname")[0];
  playfx(level._effect["plane_deathfx_small"], vh_friendly.origin, anglestoforward(vh_friendly.angles));
  vh_friendly do_vehicle_damage(vh_friendly.health, vh_plane);
  wait 2;
  vh_plane thread near_convoy_fail_watcher();
  is_looking_at = 0;

  while(!is_looking_at) {
    v_drone_forward = vectornormalize(anglestoforward(vh_plane.angles));
    v_f35_forward = vectornormalize(anglestoforward(level.f35.angles));

    if(vectordot(v_drone_forward, v_f35_forward) < -0.8) {
      if(level.player is_player_looking_at(vh_plane.origin, 0.8, 1, level.f35))
        is_looking_at = 1;
    }

    wait 0.05;
  }

  level notify("eject_sequence_ready");
}

eject_plan_fire_before_eject() {
  level endon("midair_collision_started");
  vh_friendly = getentarray("convoy_f35_ally_4", "targetname")[0];
  vh_friendly do_vehicle_damage(vh_friendly.health, self);
  self maps\la_2_fly::_setup_plane_firing_by_type();

  for(i = 0; i < self.weapon_indicies.size; i++) {
    n_index = self.weapon_indicies[i];
    self maps\_turret::set_turret_target(level.convoy.vh_potus, (0, 0, 0), n_index);
  }

  wait 1;

  while(!flag("ejection_start")) {
    self eject_plane_fire(level.convoy.vh_potus, 0, 1);
    wait(randomintrange(1, 2));
  }
}

eject_plane_fire(e_target, use_actual_pos, use_rockets) {
  if(!isDefined(use_actual_pos))
    use_actual_pos = 0;

  if(!isDefined(use_rockets))
    use_rockets = 0;

  level endon("midair_collision_started");
  e_target endon("death");
  v_offset = (0, 0, 0);
  n_fire_time = randomintrange(2, 3);

  for(i = 0; i < self.weapon_indicies.size; i++) {
    n_index = self.weapon_indicies[i];
    self maps\_turret::set_turret_target(e_target, v_offset, n_index);
    self thread maps\_turret::fire_turret_for_time(n_fire_time, n_index);
  }
}

near_convoy_fail_watcher() {
  level endon("eject_done");
  self endon("death");
  v_convoy_vehicle = level.convoy.vehicles[0];
  n_fail_dist = 9000000;

  while(true) {
    n_dist = distance2dsquared(v_convoy_vehicle.origin, self.origin);

    if(n_dist < n_fail_dist) {
      setdvar("ui_deadquote", & "LA_2_OBJ_PROTECT_FAIL");
      missionfailed();
    }

    wait 0.05;
  }
}

f35_outro() {
  flag_wait("eject_done");
  level thread maps\createart\la_2_art::outro();
  exploder(610);
  ai_harper = init_hero("harper");
  ai_harper unlink();
  level.convoy.vh_potus attach("veh_t6_mil_cougar_interior");
  level.convoy.vh_potus hidepart("tag_door_l", "veh_t6_mil_cougar_interior");
  level.convoy.vh_potus hidepart("tag_door_r", "veh_t6_mil_cougar_interior");
  a_temp = level.convoy.vehicles;
  a_temp[a_temp.size] = level.convoy.vh_van;

  foreach(veh in a_temp) {
    veh notify("goal");
    veh notify("_convoy_vehicle_think_stop");
    veh clearvehgoalpos();
    veh.takedamage = 0;
    veh cancelaimove();
    veh.supportsanimscripted = 1;
  }

  level.convoy.vh_potus play_fx("cougar_dome_light", undefined, undefined, -1, 1, "tag_fx_domelight");

  if(is_alive(level.convoy.vh_g20_1)) {
    if(!flag("harper_dead"))
      level thread maps\_scene::run_scene("outro_g20_1");
    else
      level thread maps\_scene::run_scene("outro_g20_1_noharper");
  }

  if(is_alive(level.convoy.vh_g20_2)) {
    if(!flag("harper_dead"))
      level thread maps\_scene::run_scene("outro_g20_2");
    else
      level thread maps\_scene::run_scene("outro_g20_2_noharper");
  }

  if(!flag("harper_dead"))
    level thread maps\_scene::run_scene("outro_hero");
  else
    level thread maps\_scene::run_scene("outro_hero_noharper");

  level thread press_fadeout();
  wait 1;
  vh_potus_convoy = getent("convoy_potus", "targetname");
  vh_potus_convoy thread potus_convoy_interior_setup();
  maps\_scene::scene_wait("outro_hero");
  flag_set("outro_done");
}

van_fx() {
  wait 3;
  van = getent("convoy_van_prop", "targetname");
  playfxontag(level._effect["convoy_skid_stop"], van, "tag_origin");
}

outro_pip(guy) {
  wait 2;
  level thread maps\_glasses::play_bink_on_hud("la_pip_seq_1", 0, 0);
  wait 3;
  level.player queue_dialog("pres_you_did_a_great_serv_0");
  level.player queue_dialog("pres_in_the_meantime_0");
  level.player queue_dialog("pres_and_make_sure_ju_0");
}

press_fadeout() {
  wait 12;
  level clientnotify("fade_out");
  screen_fade_out(1);
  wait 1.1;
  nextmission();
}

potus_convoy_interior_setup() {
  self attach("veh_t6_mil_cougar_interior_attachment", "tag_body_animate_jnt");
}

roadblock_vehicles_dead() {
  roadblock_vehicles = getentarray("roadblock_vehicles", "targetname");
  array_wait(roadblock_vehicles, "death");
  flag_set("roadblock_clear");
}

ambient_flybys() {
  level thread spawn_ambient_drones("trig_ground_ambient_flybys_1", "trig_ground_ambient_flybys_8", "pegasus_ground_ambient_flyby_2", "f38_ground_ambient_flyby_2", "ground_ambient_flyby_path_2", 6, 2, 3, 4);
  level thread spawn_ambient_drones("trig_ground_ambient_flybys_3", "trig_ground_ambient_flybys_4", "pegasus_ground_ambient_flyby_3", "f38_ground_ambient_flyby_3", "ground_ambient_flyby_path_3", 5, 2, 2, 3);
  level thread spawn_ambient_drones("trig_ground_ambient_flybys_4", "trig_ground_ambient_flybys_5", "pegasus_ground_ambient_flyby_4", "f38_ground_ambient_flyby_4", "ground_ambient_flyby_path_4", 4, 2, 3, 5);
  level thread spawn_ambient_drones("trig_ground_ambient_flybys_4", "trig_ground_ambient_flybys_5", "pegasus_ground_ambient_flyby_7", "f38_ground_ambient_flyby_7", "ground_ambient_flyby_path_7", 4, 2, 4, 5);
  level thread spawn_ambient_drones("trig_ground_ambient_flybys_5", "trig_ground_ambient_flybys_7", "pegasus_ground_ambient_flyby_5", "f38_ground_ambient_flyby_5", "ground_ambient_flyby_path_5", 4, 2, 5, 6);
  level thread spawn_ambient_drones("trig_ground_ambient_flybys_5", "trig_ground_ambient_flybys_7", "pegasus_ground_ambient_flyby_6", "f38_ground_ambient_flyby_6", "ground_ambient_flyby_path_6", 6, 2, 3, 4);
}

run_digital_billboards() {
  level.corner_sign_models = array("p6_light_ad_03_crnr", "p6_light_ad_05_crnr", "p6_light_ad_07_crnr", "p6_light_ad_09_crnr");
  a_signs = getentarray("light_ad", "targetname");
  array_thread(a_signs, ::_corner_sign_swap);
}

_corner_sign_swap() {
  level endon("kill_digital_billboards");

  while(true) {
    for(i = 0; i < level.corner_sign_models.size; i++) {
      self setmodel(level.corner_sign_models[i]);
      wait 9;
    }
  }
}

vtol_check_on_path() {
  a_path_trigs = getentarray("vtol_safe_flightpath", "targetname");

  while(!flag("dogfights_story_done")) {
    is_safe = 0;

    foreach(t_path in a_path_trigs) {
      if(level.player istouching(t_path))
        is_safe = 1;
    }

    if(!is_safe)
      level thread vtol_off_path();
    else {
      level notify("vtol_on_path");
      flag_clear("vtol_off_path");
    }

    wait 0.5;
  }
}

vtol_off_path() {
  level endon("vtol_on_path");
  vh_van = level.convoy.vh_van;

  if(!flag("vtol_off_path")) {
    flag_set("vtol_off_path");
    level.player say_dialog("samu_where_are_you_secti_0");
    level.player say_dialog("samu_we_need_you_with_the_0");
    missionfailedwrapper(&"LA_2_DISTANCE_FAIL");
  }
}

heli_think() {
  self endon("death");
  self thread heli_death_trail();
  self.cur_target = level.player;
  self thread maps\_helicopter_ai::helicopter_fire_update2();
  self waittill("reached_end_node");
  self.attack_range_min = 200;
  self.attack_range_max = 300;
  self.attack_right_range = 250;
  self.attack_move_frequency = 0.25;
  self.vehaircraftcollisionenabled = 1;
  self setvehicleavoidance(1);
  self thread maps\_helicopter_ai::helicopter_think(level.convoy.vh_potus);
}

hotel_street_heli_think() {
  self endon("death");
  self thread heli_death_trail("reached_end_node");
  self.cur_target = level.convoy.vh_potus;
  self thread maps\_helicopter_ai::helicopter_fire_update2();
  self waittill("reached_end_node");
  self.attack_range_min = 200;
  self.attack_range_max = 300;
  self.attack_right_range = 250;
  self.attack_move_frequency = 0.25;
  self.vehaircraftcollisionenabled = 1;
  self setvehicleavoidance(1);
  self thread maps\_helicopter_ai::helicopter_think(level.convoy.vh_potus);
}

heli_death_trail(str_ender) {
  if(!isDefined(str_ender))
    str_ender = undefined;

  if(isDefined(str_ender))
    self endon(str_ender);

  self waittill("death");

  if(isDefined(self))
    playfx(self.deathfx, self.origin);

  if(isDefined(self))
    playfxontag(level._effect["heli_crash_trail"], self, "tag_origin");
}