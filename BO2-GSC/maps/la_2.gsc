/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_2.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\la_utility;
#include maps\_glasses;
#include maps\_music;
#include maps\la_2_fx;
#include maps\_load;
#include maps\la_2_amb;
#include maps\la_2_anim;
#include maps\_lockonmissileturret;
#include maps\_heatseekingmissile;
#include maps\_objectives;
#include maps\la_2_convoy;
#include maps\la_2_player_f35;
#include maps\la_2_drones_ambient;
#include maps\la_2_debug;
#include maps\_pegasus;
#include maps\_avenger;
#include maps\la_2_ground;
#include maps\_turret;
#include maps\_drones;
#include maps\la_2;
#include maps\la_2_fly;
#include maps\_skipto;
#include maps\_scene;
#include maps\createart\la_2_art;

main() {
  maps\la_2_fx::main();
  maps\la_utility::init_flags();
  setup_objectives();
  setup_skiptos();
  precache_everything();
  maps\_load::main();
  maps\la_2_amb::main();
  maps\la_2_anim::main();
  setmapcenter((0, 0, 0));
  la_drones_setup();
  level thread maps\_lockonmissileturret::init(undefined, ::getbestmissileturrettarget_f38);
  level thread maps\_heatseekingmissile::init();
  level thread level_start();
  level thread maps\_objectives::objectives();
  level thread maps\la_2_convoy::main();
  level thread maps\la_2_player_f35::main();
  level thread global_funcs();
  level thread la_2_objectives();
  level thread setup_destructibles();
  level thread maps\la_2_drones_ambient::main();
  setnorthyaw(90);
  onplayerconnect_callback(::on_player_connect);
  setsaveddvar("vehicle_sounds_cutoff", 20000);
  setsaveddvar("phys_vehicleWheelEntityCollision", "1");
  level thread temp_disable_hud_damage();

  level thread maps\la_2_debug::main();
}

on_player_connect() {
  level thread setup_story_states();
}

temp_disable_hud_damage() {
  flag_wait("all_players_connected");
  wait 1;

  while(true) {
    while(getdvarint(#"_id_13510208") != 1)
      wait 0.05;

    level clientnotify("temp_disable_hud_damage");

    if(isDefined(level.player.e_temp_fx)) {
      level.player.e_temp_fx unlink();
      level.player.e_temp_fx delete();
    }

    while(getdvarint(#"_id_13510208") == 1)
      wait 0.05;

    level clientnotify("temp_enable_hud_damage");
  }
}

global_funcs() {
  wait_for_first_player();
  level.missile_lock_on_range = 15000;
  level.persistent_fires_max = 31;
  setup_spawn_functions();
  spawn_manager_set_global_active_count(24);
  add_spawn_function_veh_by_type("drone_pegasus_fast_la2_2x", maps\_pegasus::update_objective_model);
  add_spawn_function_veh_by_type("drone_avenger_fast_la2_2x", maps\_avenger::update_objective_model);
  add_spawn_function_veh_by_type("drone_pegasus_fast_la2_2x", maps\_pegasus::update_damage_states);
  add_spawn_function_veh_by_type("drone_avenger_fast_la2_2x", maps\_avenger::update_damage_states);
  add_spawn_function_veh_by_type("drone_pegasus_fast_la2_2x", ::spawn_plane_fx_on_death);
  add_spawn_function_veh_by_type("drone_avenger_fast_la2_2x", ::spawn_plane_fx_on_death);
  add_spawn_function_veh_by_type("plane_f35_fast_la2", ::spawn_plane_fx_on_death);
  add_spawn_function_veh_by_type("drone_pegasus_fast_la2_2x", ::plane_midair_deathfx);
  add_spawn_function_veh_by_type("drone_avenger_fast_la2_2x", ::plane_midair_deathfx);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret_la2", ::ground_vehicle_fires_at_player);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret_la2", ::add_missile_turret_target);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret_la2", ::blow_up_vehicle_at_spline_end);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret_la2", ::delay_free_vehicle);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret_la2", ::prevent_riders_from_unloading);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret_la2", ::add_vehicle_to_convoy_target_pool);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret_la2", ::clean_up_vehicle_at_air_to_air);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret_la2", ::enable_vehicle_avoidance, 128);
  add_spawn_function_veh_by_type("civ_van_sprinter_la2", ::add_ground_vehicle_damage_callback);
  add_spawn_function_veh_by_type("civ_van_sprinter_la2", maps\la_2_ground::stop_at_spline_end);
  add_spawn_function_veh_by_type("civ_van_sprinter_la2", ::add_missile_turret_target);
  add_spawn_function_veh_by_type("heli_pavelow_la2", ::add_ground_vehicle_damage_callback);
  add_spawn_function_veh_by_type("heli_pavelow_la2", ::add_missile_turret_target);
  add_spawn_function_veh_by_type("heli_pavelow_la2", ::helicopter_fires_at_player);
  add_spawn_function_veh_by_type("heli_pavelow_la2", ::hover_at_spline_end);
  add_spawn_function_veh_by_type("heli_pavelow_la2", ::func_on_death, ::pavelow_tailor_rotor_fire_on_death);
  add_spawn_function_veh_by_type("civ_bigrig_la2", ::add_missile_turret_target);
  add_spawn_function_veh_by_type("civ_bigrig_la2", ::bigrig_add_trailer);
  add_spawn_function_veh_by_type("civ_bigrig_la2", ::bigrig_death_fx);
  add_spawn_function_veh_by_type("civ_bigrig_la2", ::blow_up_vehicle_at_spline_end);
  add_spawn_function_veh_by_type("civ_bigrig_la2", ::add_ground_vehicle_damage_callback);
  add_spawn_function_veh_by_type("civ_bigrig_la2", ::clean_up_vehicle_at_air_to_air);
  add_spawn_function_veh_by_type("civ_police_la2", ::police_car_cheap);
  add_spawn_function_veh_by_type("civ_police_la2", ::delay_free_vehicle);
  add_spawn_function_veh_by_type("civ_police_la2", ::add_ground_vehicle_damage_callback);
  add_spawn_function_veh_by_type("civ_police_la2", ::enable_vehicle_avoidance, 64);
  add_spawn_function_veh_by_type("civ_police_light", ::police_car_cheap);
  add_spawn_function_veh_by_type("civ_police_light", ::prevent_riders_from_unloading);
  add_spawn_function_veh_by_type("civ_police_light_nophysics", ::police_car_cheap);
  add_spawn_function_veh_by_type("civ_police_light_nophysics", ::prevent_riders_from_unloading);
  add_spawn_function_veh_by_type("heli_future_la2", ::add_ground_vehicle_damage_callback);
  add_spawn_function_veh_by_type("apc_cougar_gun_turret_low", ::enable_vehicle_avoidance, 128);
  sp_police_car_rider = get_ent("lapd_in_car", "targetname", 1);
  a_police_ground_ents = get_ent_array("lapd_drone_target_origins", "targetname", 1);
  sp_police_car_rider add_spawn_function(::find_target_after_getout, a_police_ground_ents);
  add_spawn_function_veh_by_type("civ_police", ::police_car_add_occupants, sp_police_car_rider);
  add_spawn_function_veh_by_type("civ_pickup_red_wturret_la2", ::pickup_add_occupants);

  if(!isDefined(level.green_zone_volume))
    level.green_zone_volume = get_ent("green_zone_volume", "targetname", 1);

  if(!isDefined(level.dogfights_volume))
    level.dogfights_volume = get_ent("dogfights_zone", "targetname", 1);

  level.player setclientdvar("cg_aggressiveCullRadius", 100);
  level.player thread toggle_occluders();
  level thread convoy_trigger_setup();
}

delay_free_vehicle() {
  self.dontfreeme = 1;
  self waittill("death");
  wait 10;

  if(isDefined(self))
    self.dontfreeme = undefined;
}

pavelow_tailor_rotor_fire_on_death() {
  playfxontag(level._effect["pavelow_tail_rotor_fire"], self, "tag_origin");
}

blow_up_vehicle_at_spline_end() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "blow_up_at_spline_end") {
    self endon("death");
    self waittill("reached_end_node");
    self do_vehicle_damage(self.health + 100, level.convoy.vh_potus, "explosive");
  }
}

clean_up_vehicle_at_air_to_air() {
  self endon("death");
  level waittill("start_dogfight_event");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

enable_vehicle_avoidance(radius) {
  self setvehicleavoidance(1, radius);
}

police_car_add_occupants(sp_rider) {
  if(isDefined(self.script_string) && self.script_string == "no_riders") {
    return;
  }
  self endon("death");

  if(!isDefined(sp_rider.currently_spawning))
    sp_rider.currently_spawning = 0;

  while(sp_rider.currently_spawning)
    wait(randomfloatrange(0.05, 0.25));

  sp_rider.currently_spawning = 1;
  ai_rider = simple_spawn_single(sp_rider);
  sp_rider.currently_spawning = 0;
  ai_rider enter_vehicle(self);
}

prevent_riders_from_unloading() {
  self.dontunloadonend = 1;
}

add_vehicle_to_convoy_target_pool() {
}

find_target_after_getout(a_target_ents) {
  self endon("death");
  self waittill("jumpedout");
  a_cover = getcovernodearray(self.origin, 2048);

  if(a_cover.size == 0) {
    return;
  }
  self.goalradius = 32;
  b_found_node = 0;

  while(!b_found_node) {
    nd_best = getclosest(self.origin, a_cover);

    if(!isnodeoccupied(nd_best) && (isDefined(nd_best.script_string) && nd_best.script_string == self.team))
      b_found_node = 1;
    else {
      arrayremovevalue(a_cover, nd_best);
      wait 0.05;
    }
  }

  self setgoalnode(nd_best);
  self delay_thread(randomfloatrange(3, 8), ::bloody_death);

  if(isDefined(a_target_ents))
    self shoot_at_target(random(a_target_ents), undefined, 0, -1);
}

hover_at_spline_end() {
  self endon("death");
  self waittill("reached_end_node");
  self sethoverparams(500);
}

police_car_cheap() {
  self endon("death");
  self setvehicleavoidance(1);
  self play_fx("siren_light", undefined, undefined, -1, 1, "tag_origin");
  self waittill("reached_end_node");
  self notify("groupedanimevent", "twitch");
}

helicopter_fires_at_player() {
  self endon("death");
  maps\_turret::shoot_turret_at_target(level.player, -1, (0, 0, 0), 0);
}

spawn_plane_fx_on_death() {
  self func_on_death(maps\la_2_drones_ambient::crash_landing_fx);
}

bigrig_death_fx() {
  self waittill("death");
  playfxontag(level._effect["bigrig_death"], self, "tag_origin");
}

add_missile_turret_target() {
  v_offset = (0, 0, 0);

  if(isDefined(self.classname) && self.classname == "script_vehicle") {
    if(self.vehicletype == "civ_van_sprinter")
      v_offset = vectorscale((0, 0, 1), 60.0);
    else if(self.vehicletype == "civ_bigrig_la2")
      v_offset = vectorscale((0, 0, 1), 80.0);
  }

  target_set(self, v_offset);
}

pickup_add_occupants() {
  if(isDefined(self.script_string) && self.script_string == "no_riders") {
    return;
  }
  str_driver_tag = "tag_driver";
  str_gunner_tag = "tag_gunner1";
  ai_gunner = simple_spawn_single("pickup_guy", ::pickup_disable_turret_on_gunner_death, self);
  ai_gunner enter_vehicle(self, str_gunner_tag);
}

pickup_disable_turret_on_gunner_death(vh_truck) {
  self.overrideactordamage = ::pickup_gunners_dont_take_cougar_damage;
  self waittill("death");
  n_index = 1;

  if(isDefined(vh_truck)) {
    vh_truck maps\_turret::disable_turret(n_index);
    vh_truck notify("gunner_dead");
  }
}

pickup_gunners_dont_take_cougar_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(isDefined(sweapon) && sweapon == "cougar_gun_turret")
    idamage = 1;

  return idamage;
}

convoy_trigger_setup() {
  a_triggers = get_ent_array("convoy_vehicle_trigger", "script_noteworthy", 1);

  for(i = 0; i < a_triggers.size; i++)
    a_triggers[i] thread convoy_trigger_proc();
}

bigrig_add_trailer() {
  if(isDefined(self.script_string) && self.script_string == "no_trailer") {
    return;
  }
  self.trailer_model = spawn("script_model", self.origin);
  self.trailer_model.angles = self.angles;
  self.trailer_model linkto(self);
  self.trailer_model setmodel("veh_t6_civ_18wheeler_trailer");

  if(isDefined(self.script_int)) {
    self.model_old = self.model;
    self setmodel("veh_t6_civ_18wheeler");
    self.trailer_model hide();
  }

  self waittill("death");
  self.trailer_model show();
  self.trailer_model setmodel("veh_t6_civ_18wheeler_trailer_dead");

  if(isDefined(self.model_old))
    self setmodel(self.model_old);
}

_play_bigrig_trailer_anim() {
}

convoy_trigger_proc() {
  self maps\la_2_convoy::_waittill_triggered_by_convoy();

  if(isDefined(self.target)) {
    t_vehicle_spawn = get_ent(self.target, "targetname", 1);
    t_vehicle_spawn notify("trigger");
  }

  wait 1;
  self delete();

  if(isDefined(t_vehicle_spawn))
    t_vehicle_spawn delete();
}

plane_midair_deathfx() {
  self waittill("death");

  if(flag("convoy_at_dogfight") && !flag("dogfight_done")) {
    if(isDefined(self) && isDefined(self.origin) && isDefined(self.angles))
      playfx(level._effect["plane_deathfx_small"], self.origin, anglestoforward(self.angles));
  }
}

toggle_occluders() {
  level endon("death");
  wait_for_first_player();
  e_occluders_on = level.green_zone_volume;
  flag_wait("convoy_at_dogfight");

  while(true) {
    b_is_in_volume = self istouching(e_occluders_on);

    if(b_is_in_volume)
      n_value = 1;
    else
      n_value = 0;

    enableoccluder("", n_value);
    wait 0.5;
  }
}

precache_everything() {
  precacheitem("usrpg_magic_bullet_cheap_sp");
  precacheitem("f35_death_blossom");
  precacheitem("pegasus_missile_turret_doublesize");
  precacheitem("m4_sp");
  precacheitem("ksg_sp");
  precacheitem("molotov_sp");
  precacheitem("molotov_dpad_sp");
  precacheitem("napalmblob_sp");
  precachemodel("veh_t6_mil_cougar_interior");
  precachemodel("veh_t6_civ_18wheeler");
  precachemodel("veh_t6_civ_18wheeler_trailer");
  precachemodel("veh_t6_civ_18wheeler_trailer_dead");
  precachemodel("veh_t6_air_fa38_landing_gear");
  precachemodel("veh_t6_air_fa38_ladder");
  precachemodel("veh_t6_drone_avenger_x2");
  precachemodel("veh_t6_air_fa38_x2");
  precachemodel("veh_t6_mil_cougar_interior_attachment");
  precachemodel("veh_t6_mil_cougar_interior_shadow");
  precachemodel("veh_iw_civ_ambulance_int");
  precachemodel("c_usa_cia_combat_harper_head_scar");
  precachemodel("p6_light_ad_03_crnr");
  precachemodel("p6_light_ad_05_crnr");
  precachemodel("p6_light_ad_07_crnr");
  precachemodel("p6_light_ad_09_crnr");
  precachemodel("p6_light_ad_10_crnr");
  precacherumble("tank_damage_light_mp");
  precacherumble("tank_damage_heavy_mp");
  precachestring(&"hud_update_vehicle_custom");
  precachestring(&"plane_f35_player_vtol");
  precachestring(&"hud_f35");
  precachestring(&"hud_f35_death_blossom");
  precachestring(&"hud_f35_end");
  precachestring(&"hud_link_lost");
  precachestring(&"hud_missile_incoming");
  precachestring(&"hud_missile_incoming_dist");
  precachestring(&"hud_damage");
  precachestring(&"hud_weapon_heat");
  precachestring(&"hud_update_vehicle");
  precachestring(&"la_pip_seq_1");
  precachestring(&"la_pip_seq_3");
  precachestring(&"la_pip_seq_4");
  precachestring(&"la_pip_seq_5");
  precachestring(&"la_pip_seq_6");
  precachestring(&"la_pip_seq_7");
  precachestring(&"la_pip_seq_8");
}

la_drones_setup() {
  maps\_drones::init();
  maps\_drones::drones_set_max(100);
  maps\_drones::drones_set_muzzleflash(level._effect["drone_muzzle_flash"]);
  maps\_drones::drones_set_impact_effect(level._effect["drone_impact_fx"]);
  drones_assign_global_spawner("allies", "lapd_drone_guy");
  drones_assign_global_spawner("axis", "axis_drone_spawner_guy");
  level.drone_weaponlist_axis = array("m4_sp");
  level.drone_weaponlist_allies = array("ksg_sp");
  a_drone_triggers = get_ent_array("drone_axis", "targetname");
  a_drone_triggers_allies = get_ent_array("drone_allies", "targetname");
  a_drone_triggers = arraycombine(a_drone_triggers, a_drone_triggers_allies, 1, 0);

  foreach(drone_trigger in a_drone_triggers)
  maps\_drones::drones_speed_modifier(drone_trigger.script_string, -0.3, 0.3);

  maps\_drones::drones_speed_modifier("warehouse_st_right_blockade", -0.2, 0.4);
  maps\_drones::drones_speed_modifier("hotel_street_breakthrough_drones", 0.0, 0.4);
  maps\_drones::drones_add_custom_func("throw_molotov", ::drone_throws_molotov);
}

drone_throws_molotov(s_start, v_destination, params) {
  self delay_thread(1.4, ::_drone_throws_molotov_proc);
}

_drone_throws_molotov_proc() {
  if(isDefined(self)) {
    v_start = self gettagorigin("tag_weapon");
    v_end = self.origin + anglestoforward(self.angles) * 1000;
    self molotov_throw(undefined, v_start, v_end);
  }
}

drones_assign_global_spawner(str_side, str_spawner_targetname) {
  if(str_side == "allies")
    str_targetname = "drone_allies";
  else
    str_targetname = "drone_axis";

  a_drone_spawners = get_ent_array(str_targetname, "targetname", 1);
  sp_drone_model = get_ent(str_spawner_targetname, "targetname", 1);

  for(i = 0; i < a_drone_spawners.size; i++)
    maps\_drones::drones_assign_spawner(a_drone_spawners[i].script_string, sp_drone_model);
}

level_start() {
  wait_for_first_player();

  if(getdvar(#"_id_B5F23DCA") != "1") {
    println("LA_1 ENDING POSITION NOT FOUND. USING DEFAULT LEVEL START CONDITIONS!");

    flag_set("G20_1_saved");
    flag_set("G20_2_saved");
  }

  if(isDefined(getdvar(#"_id_CEC8DDF8")) && getdvar(#"_id_CEC8DDF8") == "1")
    flag_set("F35_pilot_saved");

  if(isDefined(getdvar(#"_id_E0C8EA9C")) && getdvar(#"_id_E0C8EA9C") == "1")
    flag_set("G20_1_saved");

  if(isDefined(getdvar(#"_id_2DC3275D")) && getdvar(#"_id_2DC3275D") == "1")
    flag_set("G20_2_saved");

  println("Anderson saved: " + flag("F35_pilot_saved"));
  println("G20_1 saved: " + flag("G20_1_saved"));
  println("G20_2 saved: " + flag("G20_2_saved"));

  flag_set("la_transition_setup_done");
}

setup_skiptos() {
  default_skipto("f35_wakeup");
  add_skipto("intro", ::skipto_la_1);
  add_skipto("after_the_attack", ::skipto_la_1);
  add_skipto("sam", ::skipto_la_1);
  add_skipto("cougar_fall", ::skipto_la_1);
  add_skipto("sniper_rappel", ::skipto_la_1);
  add_skipto("low_road", ::skipto_la_1);
  add_skipto("g20_group1", ::skipto_la_1);
  add_skipto("drive", ::skipto_la_1);
  add_skipto("skyline", ::skipto_la_1);
  add_skipto("street", ::skipto_la_1b);
  add_skipto("plaza", ::skipto_la_1b);
  add_skipto("intersection", ::skipto_la_1b);
  add_skipto("f35_wakeup", maps\la_2::skipto_f35_wakeup, & "SKIPTO_STRING_HERE", maps\la_2_ground::f35_wakeup);
  add_skipto("f35_boarding", maps\la_2::skipto_f35_boarding, & "SKIPTO_STRING_HERE", maps\la_2_ground::f35_boarding);
  add_skipto("f35_flying", maps\la_2::skipto_f35_flying, & "SKIPTO_STRING_HERE", maps\la_2_ground::f35_flight_start);
  add_skipto("f35_pacing", maps\la_2::skipto_f35_pacing, & "SKIPTO_STRING_HERE", maps\la_2_ground::f35_pacing);
  add_skipto("f35_rooftops", maps\la_2::skipto_f35_rooftops, & "SKIPTO_STRING_HERE", maps\la_2_ground::f35_rooftops);
  add_skipto("f35_dogfights", maps\la_2::skipto_f35_dogfights, & "SKIPTO_STRING_HERE", maps\la_2_fly::f35_dogfights);
  add_skipto("f35_eject", maps\la_2::skipto_f35_eject, & "SKIPTO_STRING_HERE", maps\la_2_ground::f35_eject);
  add_skipto("f35_outro", maps\la_2::skipto_f35_outro, & "SKIPTO_STRING_HERE", maps\la_2_ground::f35_outro);
  add_skipto("dev_build_test", maps\la_2::skipto_dev_build_test, & "SKIPTO_STRING_HERE");
  set_skipto_cleanup_func(::skipto_cleanup);
}

la_2_objectives() {
  wait_for_first_player();
  set_objective(level.obj_prom_night, undefined, undefined, undefined, 0);
  set_objective(level.obj_prom_night, undefined, "deactivate");
  set_objective(level.obj_potus, undefined, undefined, undefined, 0);
  set_objective(level.obj_potus, undefined, "deactivate");
  set_objective(level.obj_street_regroup, undefined, undefined, undefined, 0);
  set_objective(level.obj_street_regroup, undefined, "deactivate");
  flag_wait("player_awake");
  t_f35_bump_trigger = get_ent("f35_bump_trigger", "targetname", 1);
  maps\_objectives::set_objective(level.obj_fly, t_f35_bump_trigger, "breadcrumb");

  while(distance2d(level.player.origin, t_f35_bump_trigger.origin) > 300 || !flag("player_can_board"))
    wait 0.05;

  maps\_objectives::set_objective(level.obj_fly, t_f35_bump_trigger, "enter");
  level thread objective_f35_hint();
  flag_wait("player_in_f35");
  maps\_objectives::set_objective(level.obj_fly, level.f35, "done");
  flag_wait("player_flying");

  if(!flag("harper_dead"))
    maps\_objectives::set_objective(level.obj_follow_van, level.convoy.vh_van, "follow");
  else
    maps\_objectives::set_objective(level.obj_follow_ambulance, level.convoy.vh_van, "follow");

  flag_wait("roadblock_done");

  if(!flag("harper_dead")) {
    maps\_objectives::set_objective(level.obj_follow_van, undefined, "done");
    maps\_objectives::set_objective(level.obj_follow_van, undefined, "delete");
  } else {
    maps\_objectives::set_objective(level.obj_follow_ambulance, undefined, "done");
    maps\_objectives::set_objective(level.obj_follow_ambulance, undefined, "delete");
  }

  maps\_objectives::set_objective(level.obj_protect, level.convoy.vh_potus, "protect");
  flag_wait("convoy_at_dogfight");
  wait 2;
  maps\_objectives::set_objective(level.obj_protect, undefined, "done");
  maps\_objectives::set_objective(level.obj_protect, undefined, "delete");
  maps\_objectives::set_objective(level.obj_destroy_drones);
  flag_wait("dogfight_done");
  maps\_objectives::set_objective(level.obj_destroy_drones, undefined, "done");
}

objective_f35_hint() {
  level endon("player_flying");
  wait 30;
}

skipto_la_1() {
  changelevel("la_1", 1);
}

skipto_la_1b() {
  changelevel("la_1b", 1);
}

f35_move_to_position(str_struct_name) {
  assert(isDefined(str_struct_name), "str_struct_name is a required parameter for f35_move_to_struct");
  s_f35_position = get_struct(str_struct_name, "targetname", 1);
  level.f35.origin = s_f35_position.origin;

  if(isDefined(s_f35_position.angles))
    level.f35 setphysangles(s_f35_position.angles);

  maps\la_2_player_f35::player_boards_f35();
}

convoy_move_to_position(str_struct_names) {
  assert(isDefined(str_struct_names), "str_struct_names is a required parameter for convoy_move_to_position");
  assert(isDefined(level.convoy.vehicles), "level.convoy.vehicles is missing in convoy_move_to_position");
  a_vehicles = level.convoy.vehicles;
  vh_van = level.convoy.vh_van;
  a_vehicles[a_vehicles.size] = vh_van;

  if(!maps\_skipto::is_after_skipto("f35_dogfights") && maps\_skipto::is_after_skipto("f35_ground_targets"))
    a_vehicles = arraycombine(a_vehicles, level.convoy.lapd_escort, 1, 0);

  a_structs = get_struct_array(str_struct_names, "targetname", 1);
  assert(a_structs.size >= a_vehicles.size, "missing structs for convoy_move_to_position. Have " + a_structs.size + ", need " + a_vehicles.size);

  for(i = 0; i < a_vehicles.size; i++) {
    b_found_struct = 0;

    for(j = 0; j < a_structs.size; j++) {
      if(a_vehicles[i].script_int == a_structs[j].script_int) {
        vh_temp = a_vehicles[i];
        s_temp = a_structs[j];

        println(vh_temp.targetname + "moving to struct " + s_temp.targetname + " at " + s_temp.origin + "\\n");

        b_found_struct = 1;
        vh_temp cancelaimove();
        wait 0.05;
        vh_temp.origin = s_temp.origin;

        if(isDefined(s_temp.angles)) {
          vh_temp.angles = s_temp.angles;
          vh_temp setphysangles(s_temp.angles);
        }

        if(isDefined(s_temp.target)) {
          nd_temp = getvehiclenode(s_temp.target, "targetname");
          vh_temp attachpath(nd_temp);

          if(vh_temp == vh_van) {
            vh_temp thread maps\la_2_convoy::convoy_vehicle_think_van(nd_temp);
            continue;
          }

          vh_temp thread maps\la_2_convoy::convoy_vehicle_think(nd_temp);
        }
      }
    }

    assert(b_found_struct, a_vehicles[i].targetname + " is missing struct for " + str_struct_names + ". Script_int = " + a_vehicles[i].script_int);
  }
}

convoy_move_to_dogfight_position(str_structs_name) {
}

skipto_f35_wakeup() {
}

skipto_f35_boarding() {
  skipto_teleport("f35_boarding_skipto");
  maps\_scene::run_scene_first_frame("F35_startup_vehicle");
  maps\createart\la_2_art::fog_intro();
}

skipto_f35_flying() {
  f35_move_to_position("skipto_f35_flying_struct");
  maps\la_2_player_f35::f35_startup_console(undefined);
}

skipto_f35_ground_targets() {
  f35_move_to_position("skipto_f35_ground_targets_struct");
  convoy_move_to_position("skipto_convoy_ground_targets");
}

skipto_f35_pacing() {
  _skipto_turn_off_roadblock_triggers();
  f35_move_to_position("skipto_f35_pacing_struct");
  convoy_move_to_position("skipto_convoy_roadblock_struct");
  level thread maps\la_2_fly::_autosave_after_bink();

  if(is_greenlight_build()) {
    maps\la_2_player_f35::f35_show_console("tag_display_flight");
    level thread convoy_waits_for_player_input();
  }
}

skipto_f35_rooftops() {
  _skipto_turn_off_roadblock_triggers();
  f35_move_to_position("skipto_f35_rooftops_struct");
  convoy_move_to_position("skipto_convoy_rooftops_struct");
  maps\la_2_player_f35::f35_startup_console(undefined);
  flag_set("player_at_convoy_end");
}

convoy_waits_for_player_input() {
  array_notify(level.convoy.vehicles, "convoy_stop");
  wait 0.1;
  array_notify(level.convoy.lapd_escort, "convoy_stop");
  flag_clear("convoy_can_move");
  b_player_moving = 0;
  wait 1;

  while(!b_player_moving) {
    if(length(level.player getnormalizedmovement()) > 0.1)
      b_player_moving = 1;

    wait 0.05;
  }

  flag_wait("pip_intro_done");
  flag_set("convoy_can_move");
  wait 0.5;
  level thread maps\la_2_fly::_autosave_after_bink();

  foreach(vehicle in level.convoy.vehicles) {
    if(is_alive(vehicle))
      vehicle setspeed(30);
  }

  foreach(vehicle in level.convoy.lapd_escort) {
    if(is_alive(vehicle))
      vehicle setspeed(30);
  }
}

skipto_f35_dogfights() {
  f35_move_to_position("skipto_f35_dogfight_struct");
  convoy_move_to_position("skipto_convoy_dogfights_struct");
  level.f35 setheliheightlock(0);
  level thread f35_hide_outer_model_parts(1, 0.25);
  flag_set("convoy_can_move");
  flag_set("dogfights_story_done");
  flag_set("player_flying");
  delay_notify("fxanim_bldg_convoy_block_start", 2);
  _skipto_turn_off_roadblock_triggers();
  maps\la_2_player_f35::f35_startup_console(undefined);
  setmusicstate("LA_2_DOGFIGHT");
}

_skipto_turn_off_roadblock_triggers() {
  t_stop = get_ent("convoy_tutorial_stop_trigger", "targetname", 1);
  t_stop trigger_off();
}

skipto_f35_trenchrun() {
  f35_move_to_position("skipto_f35_trenchrun_struct");
  convoy_move_to_position("skipto_convoy_trenchruns_struct");

  for(i = 0; i < level.convoy.vehicles.size; i++)
    level.convoy.vehicles[i] setspeed(30);
}

skipto_f35_hotel() {
  f35_move_to_position("skipto_f35_hotel_struct");
  convoy_move_to_position("convoy_moveto_final_position");
}

skipto_f35_eject() {
  maps\_lockonmissileturret::enablelockon();
  f35_move_to_position("skipto_f35_eject_struct");
  convoy_move_to_position("convoy_moveto_eject_sequence");
  spawn_eject_friendly_follow_plane();
  wait 1;
  level.f35 thread _f35_set_vtol_mode_v2();
  flag_set("hotel_done");
  flag_set("no_fail_from_distance");
  maps\la_2_player_f35::f35_startup_console(undefined);
}

skipto_f35_outro() {
  flag_set("no_fail_from_distance");
  flag_set("eject_done");
}

skipto_dev_build_test() {
  wait 2;
  level.player resetfov();
  maps\createart\la_2_art::art_jet_mode_settings();
}

getbestmissileturrettarget_f38() {
  a_targets_all = target_getarray();
  a_targets_valid = [];
  a_targets_all = get_array_of_closest(self.origin, a_targets_all, undefined, 10, level.missile_lock_on_range);

  for(idx = 0; idx < a_targets_all.size; idx++) {
    if(self insidemissileturretreticlenolock(a_targets_all[idx]))
      a_targets_valid[a_targets_valid.size] = a_targets_all[idx];
  }

  if(a_targets_valid.size == 0)
    return undefined;

  e_best_target = a_targets_valid[0];
  n_best_target_index = -1;
  best_distance = 99999;

  if(a_targets_valid.size > 1) {
    for(i = 0; i < a_targets_valid.size; i++) {
      n_dist_to_target = distance(self.origin, a_targets_valid[i].origin);

      if(n_dist_to_target < best_distance) {
        best_distance = n_dist_to_target;
        n_best_target_index = i;
      }
    }
  }

  if(n_best_target_index > -1)
    e_best_target = a_targets_valid[n_best_target_index];

  return e_best_target;
}