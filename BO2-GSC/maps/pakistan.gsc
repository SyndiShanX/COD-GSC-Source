/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\pakistan_util;
#include maps\_glasses;
#include maps\_scene;
#include maps\pakistan_fx;
#include maps\pakistan_anthem_approach;
#include maps\pakistan_anim;
#include maps\_load;
#include maps\_patrol;
#include maps\_flamethrower_plight;
#include maps\pakistan_amb;
#include maps\_heatseekingmissile;
#include maps\createart\pakistan_art;
#include maps\_fire_direction;
#include maps\pakistan_street;
#include maps\pakistan_market;
#include maps\_rusher;
#include maps\_turret;
#include maps\_challenges_sp;

main() {
  maps\pakistan_fx::main();
  level.supportsfutureflamedeaths = 1;
  level.actor_charring_client_flag = 15;
  level_precache();
  init_flags();
  setup_objectives();
  setup_skiptos();
  level.custom_introscreen = maps\pakistan_anthem_approach::pakistan_title_screen;
  maps\pakistan_anim::main();
  maps\_load::main();
  maps\_patrol::patrol_init();
  maps\_flamethrower_plight::init();
  maps\pakistan_amb::main();
  maps\_heatseekingmissile::init();
  onplayerconnect_callback(::on_player_connect);
  level thread maps\createart\pakistan_art::main();
  level thread maps\_objectives::objectives();
  level thread pakistan_objectives();
  level thread global_funcs();
  battlechatter_on("axis");
}

on_player_connect() {
  setup_challenges();
  setsaveddvar("phys_buoyancy", 1);
  n_water_level_offset = 2;

  if(flag("frogger_started") && !flag("frogger_done"))
    n_water_level_offset = 10;

  setdvar("r_waterWaveBase", n_water_level_offset);
  self thread scale_speed_in_water();
  self thread waittill_player_death();
}

waittill_player_death() {
  self waittill("death");
  clientnotify("player_dead");
}

scale_speed_in_water() {
  self endon("death");
  self endon("stop_scale_speed_in_water");
  self endon("slow_down");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "market_guy") {
    return;
  }
  while(true) {
    wait 0.5;
    n_depth = self depthinwater();

    if(isplayer(self)) {
      level.move_speed_scale = linear_map(n_depth, 35, 0, 0.85, 1);
      self setmovespeedscale(level.move_speed_scale);
    } else if(isai(self) && !(isDefined(self.scale_speed_in_water) && !self.scale_speed_in_water)) {
      self.moveplaybackrate = linear_map(n_depth, 35, 0, 0.75, 1);

      if(n_depth >= 16) {
        if(!(isDefined(self.rusher) && self.rusher) && !(isDefined(self.pakistan_move_mode) && self.pakistan_move_mode))
          self change_movemode("cqb_walk");
      } else if(!(isDefined(self.rusher) && self.rusher) && !(isDefined(self.pakistan_move_mode) && self.pakistan_move_mode))
        self reset_movemode();
    }
  }
}

level_precache() {
  maps\_fire_direction::claw_precache();
  maps\pakistan_street::precache_dyn_ent_debris();
  maps\pakistan_market::precache_dyn_ent_market_debris();
  precacheturret("bigdog_flamethrower");
  precacheitem("usrpg_player_sp");
  precacheitem("defaultweapon_invisible_sp");
  precacheitem("sa58_sp");
  precacheitem("data_glove_sp");
  precacheitem("data_glove_claw_sp");
  precacheshader("flamethrowerfx_color_distort_overlay_bloom");
  precacheshader("compass_static");
  precacheshader("hud_pak_drone");
  precacheshader("hud_pak_bus");
  precachemodel("veh_t6_drone_claw_turret_flamethrower");
  precachemodel("t6_wpn_hacking_dongle_prop");
  precachemodel("t6_wpn_jaws_of_life_prop");
  precachemodel("c_pak_civ_male_corpse1_fb");
  precachemodel("c_pak_civ_male_corpse2_fb");
  precachemodel("c_usa_cia_masonjr_viewbody_vson");
  precachemodel("c_usa_cia_claw_viewbody_vson");
  precachemodel("veh_t6_civ_bus_pakistan_sp");
  precachemodel("p_rus_cabinet_metal_large");
  precachemodel("com_pallet_2");
  precachemodel("furniture_couch_leather2_dust");
  precachemodel("veh_iw_pickup_destroyed");
  precachemodel("t5_veh_civ_vw_bus");
  precachemodel("ch_crate48x64");
  precachemodel("me_refrigerator_d");
  precachemodel("vehicle_tractor");
  precachemodel("t5_veh_civ_lambro_550");
  precachemodel("p6_chair_damaged_panama");
  precachemodel("veh_t6_civ_car_compact_red_radiant");
  precachemodel("veh_t6_civ_car_compact_grey_radiant");
  precachemodel("veh_t6_civ_car_compact_radiant");
  precachemodel("veh_t6_civ_car_compact_static_d_red");
  precachestring(&"extracam_glasses");
  precachestring(&"hud_update_vehicle_custom");
  precachestring(&"drone_claw_wflamethrower");
  precachestring(&"PAKISTAN_SHARED_GCM_OFFLINE");
  precachestring(&"PAKISTAN_SHARED_GCM_ONLINE");
  precachestring(&"PAKISTAN_SHARED_CLAW_ONLINE");
  precachestring(&"pakistan_intro");
  precachestring(&"PAKISTAN_SHARED_FLAMETHROWER_ENABLED");
  precachestring(&"PAKISTAN_SHARED_COMMS");
  precachestring(&"PAKISTAN_SHARED_SOCT_INFO");
  precacherumble("Pakistan_water");
}

pakistan_objectives() {
  flag_wait("intro_anim_done");
  s_market_goal = getstruct("market_exit_objective", "targetname");
  set_objective(level.obj_get_to_base, s_market_goal, "breadcrumb");
  flag_wait("frogger_started");
  s_arch_goal = getstruct("skipto_bus_street", "targetname");
  set_objective(level.obj_get_to_base, s_market_goal, "remove");
  set_objective(level.obj_get_to_base, s_arch_goal, "breadcrumb");
  flag_wait("frogger_done");
  s_bus_goal = getstruct("bus_dam_temp_wave_struct", "targetname");
  set_objective(level.obj_get_to_base, s_arch_goal, "remove");
  set_objective(level.obj_get_to_base, s_bus_goal, "breadcrumb");
  flag_wait("bus_dam_runners_started");
  wait 3;
  set_objective(level.obj_get_to_base, s_bus_goal, "remove");
  e_bus_escape = get_ent("bus_escape_hint_origin", "targetname", 1);
  set_objective(level.obj_bus_escape, e_bus_escape);
  flag_wait("bus_dam_gate_push_test_done");
  set_objective(level.obj_bus_escape, undefined, "done", undefined, 0);
  flag_wait("drone1_start");
  set_objective(level.obj_get_to_base, undefined, "done", undefined, 0);
  set_objective(level.obj_avoid_drones, getstruct("stealth_start_obj", "targetname"), "breadcrumb");
  flag_wait("corpse_alley_player_done");
  set_objective(level.obj_avoid_drones, getstruct("stealth_start_obj", "targetname"), "remove");
  set_objective(level.obj_avoid_drones, getent("trigger_bank", "targetname"), "breadcrumb");
  flag_wait("player_entered_bank");
  set_objective(level.obj_avoid_drones, getent("trigger_bank", "targetname"), "remove");
  set_objective(level.obj_avoid_drones, level.harper, "follow");
  flag_wait("sewer_move_up");
  set_objective(level.obj_avoid_drones, level.harper, "remove");
  set_objective(level.obj_avoid_drones, undefined, "done");
  set_objective(level.obj_avoid_drones, undefined, "delete");
  set_objective(level.obj_get_to_base, undefined, "delete");
  set_objective(level.obj_get_to_base_again, level.harper, "follow");
  flag_wait("approach_exit");
  set_objective(level.obj_get_to_base_again, level.harper, "remove");
  set_objective(level.obj_get_to_base_again, getstruct("pakistan_sewer_exit_temp", "targetname"), "breadcrumb");
  flag_wait("player_at_ladder");
  set_objective(level.obj_get_to_base_again, getstruct("pakistan_sewer_exit_temp", "targetname"), "remove");
  set_objective(level.obj_get_to_base_again, getstruct("obj_manhole", "targetname"), "breadcrumb");
  flag_wait("pak1_done");
  set_objective(level.obj_get_to_base_again, undefined, "done");
}

global_funcs() {
  add_global_spawn_function("axis", ::float_longer_on_death);
  add_global_spawn_function("allies", ::scale_speed_in_water);
  add_global_spawn_function("axis", ::scale_speed_in_water);
  add_spawn_function_veh("fake_vehicle_spawner", ::take_no_damage);
  add_spawn_function_veh("drone_helicopter", maps\pakistan_anthem_approach::spawn_funch_stealth_drone1);
  add_spawn_function_veh_by_type("drone_firescout_axis", maps\pakistan_anthem_approach::drone_helicopter_setup);
  add_spawn_function_veh_by_type("drone_firescout_isi", maps\pakistan_anthem_approach::drone_helicopter_setup);
  add_spawn_function_veh_by_type("misc_origin_animate", maps\pakistan_street::debris_vehicle);
  add_spawn_function_group("harper", "targetname", ::spawn_func_harper);
  add_spawn_function_group("salazar", "targetname", ::spawn_func_salazar);
  add_spawn_function_group("intruder_guy1", "targetname", maps\pakistan_anthem_approach::intruder_perk_guy_spawn_func);
  add_spawn_function_group("intruder_guy2", "targetname", maps\pakistan_anthem_approach::intruder_perk_guy_spawn_func);
  sp_claw_1 = get_ent("claw_1", "targetname", 1);
  sp_claw_1 add_spawn_function(::toggle_ignore_state);
  sp_claw_2 = get_ent("claw_2", "targetname", 1);
  sp_claw_2 add_spawn_function(::toggle_ignore_state);
  flag_wait("level.player");
  wait_network_frame();
  maps\pakistan_market::claw_1_init();
  maps\_rusher::init_rusher();
  m_clip = getent("clip_alley_door", "targetname");
  e_door = getent("pakistan_alley_door", "targetname");
  m_clip linkto(e_door, "door_hinge_jnt");
}

toggle_ignore_state() {
  self set_ignoreall(1);
  scene_wait("intro_anim");
  self set_ignoreall(0);
}

spawn_func_harper() {
  level.harper = self;
  level.harper make_hero();
}

spawn_func_salazar() {
  level.salazar = self;
  level.salazar make_hero();
}

drone_add_cheap_spotlight() {
  e_spotlight_target = spawn("script_origin", self.origin + anglestoforward(self.angles) * 5000 + vectorscale((0, 0, -1), 500.0));
  self maps\_turret::set_turret_target(e_spotlight_target, undefined, 0);
  self play_fx("helicopter_drone_spotlight_cheap", undefined, undefined, "death", 1, "tag_spotlight");
  self thread ambient_drone_target_delete(e_spotlight_target);
}

float_longer_on_death() {
  self waittill("death");

  if(isDefined(self))
    self floatlonger();
}

take_no_damage() {
  self.takedamage = 0;
}

setup_skiptos() {
  default_skipto("intro");
  add_skipto("intro", maps\pakistan_market::skipto_intro, & "intro", maps\pakistan_market::intro);
  add_skipto("market", maps\pakistan_market::skipto_market, & "market", maps\pakistan_market::market);
  add_skipto("dev_market_perk", maps\pakistan_market::skipto_market_dev_perk, & "market_with_perk", maps\pakistan_market::market);
  add_skipto("dev_market_no_perk", maps\pakistan_market::skipto_market_dev_no_perk, & "market_with_perk", maps\pakistan_market::market);
  add_skipto("car_smash", maps\pakistan_market::skipto_car_smash, & "car_smash", maps\pakistan_market::car_smash);
  add_skipto("market_exit", maps\pakistan_market::skipto_market_exit, & "market_exit", maps\pakistan_market::market_exit);
  add_skipto("dev_market_exit_perk", maps\pakistan_market::skipto_market_exit_perk, & "market_exit", maps\pakistan_market::market_exit);
  add_skipto("dev_market_exit_no_perk", maps\pakistan_market::skipto_market_exit_no_perk, & "market_exit", maps\pakistan_market::market_exit);
  add_skipto("frogger", maps\pakistan_street::skipto_frogger, & "frogger", maps\pakistan_street::frogger);
  add_skipto("dev_frogger_claw_support", maps\pakistan_street::skipto_frogger_claw_support, & "frogger", maps\pakistan_street::frogger);
  add_skipto("bus_street", maps\pakistan_street::skipto_bus_street, & "bus_street", maps\pakistan_street::bus_street);
  add_skipto("bus_dam", maps\pakistan_street::skipto_bus_dam, & "bus_dam", maps\pakistan_street::bus_dam);
  add_skipto("alley", maps\pakistan_street::skipto_alley, & "alley", maps\pakistan_street::alley);
  add_skipto("anthem_approach", maps\pakistan_anthem_approach::skipto_anthem_approach, & "anthem_approach", maps\pakistan_anthem_approach::anthem_approach);
  add_skipto("sewer_exterior", maps\pakistan_anthem_approach::skipto_sewer_exterior, & "sewer_exterior", maps\pakistan_anthem_approach::sewer_exterior);
  add_skipto("sewer_interior", maps\pakistan_anthem_approach::skipto_sewer_interior, & "sewer_interior", maps\pakistan_anthem_approach::sewer_interior);
  add_skipto("dev_sewer_interior_perk", maps\pakistan_anthem_approach::skipto_sewer_interior_perk, & "sewer_interior_perk", maps\pakistan_anthem_approach::sewer_interior);
  add_skipto("dev_sewer_interior_no_perk", maps\pakistan_anthem_approach::skipto_sewer_interior_no_perk, & "sewer_interior_perk", maps\pakistan_anthem_approach::sewer_interior);
  add_skipto("anthem", ::skipto_pakistan_2);
  add_skipto("roof_meeting", ::skipto_pakistan_2);
  add_skipto("claw", ::skipto_pakistan_2);
  add_skipto("escape_intro", ::skipto_pakistan_3);
  add_skipto("escape_battle", ::skipto_pakistan_3);
  add_skipto("escape_bosses", ::skipto_pakistan_3);
  add_skipto("warehouse", ::skipto_pakistan_3);
  add_skipto("hangar", ::skipto_pakistan_3);
  add_skipto("standoff", ::skipto_pakistan_3);
  add_skipto("dev_s3_script", ::skipto_pakistan_3);
  add_skipto("dev_s3_build", ::skipto_pakistan_3);
  set_skipto_cleanup_func(::skipto_cleanup);
}

skipto_pakistan_2() {
  changelevel("pakistan_2", 1);
}

skipto_pakistan_3() {
  changelevel("pakistan_3", 1);
}

setup_challenges() {
  self thread maps\_challenges_sp::register_challenge("froggernohits", ::challenge_frogger_no_hits);
  self thread maps\_challenges_sp::register_challenge("clawkill", ::challenge_claw_kills);
}

challenge_claw_kills(str_notify) {
  level endon("frogger_done");
  flag_wait("brute_force_unlock_done");
  level.n_fire_direction_kill_count = 0;
  level thread claw_kill_callback_control();
  flag_wait("claw_challenge_done");
  self notify(str_notify);
}

claw_kill_callback_control() {
  level.overrideactorkilled = ::claw_kill_callback;
  flag_wait("frogger_done");
  level.n_fire_direction_kill_count = undefined;
  level.overrideactorkilled = undefined;
}

claw_kill_callback(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime) {
  if(isDefined(self._fire_direction_targeted) && self._fire_direction_targeted) {
    if(sweapon == "claw_grenade_impact_explode_sp" || sweapon == "bigdog_flamethrower" || sweapon == "bigdog_dual_turret") {
      level.n_fire_direction_kill_count++;

      if(level.n_fire_direction_kill_count >= 8)
        flag_set("claw_challenge_done");
    }
  }
}

challenge_frogger_no_hits(str_notify) {
  level endon("player_hit_by_frogger_debris");
  flag_wait("frogger_done");
  wait 5;
  self notify(str_notify);
}