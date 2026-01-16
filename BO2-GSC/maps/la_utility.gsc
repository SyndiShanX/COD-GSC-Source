/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_utility.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_turret;
#include maps\_vehicle;
#include animscripts\anims;
#include maps\_skipto;
#include maps\_anim;
#include maps\_dialog;
#include maps\_objectives;
#include maps\_challenges_sp;
#include maps\_callbackglobal;
#include maps\_shellshock;
#include maps\_glasses;

autoexec init_la() {
  onplayerconnect_callback(::on_player_connect);
  sp = getent("harper", "targetname");

  if(isDefined(sp))
    sp add_spawn_function(::spawn_func_harper);

  sp = getent("hillary", "targetname");

  if(isDefined(sp))
    sp add_spawn_function(::spawn_func_hillary);

  sp = getent("sam", "targetname");

  if(isDefined(sp))
    sp add_spawn_function(::spawn_func_sam);

  sp = getent("jones", "targetname");

  if(isDefined(sp))
    sp add_spawn_function(::spawn_func_jones);
}

on_player_connect() {
  setup_challenges();
  level_settings();
}

spawn_func_harper() {
  level.harper = self;

  if(level.player get_story_stat("HARPER_SCARRED") || getdvarint(#"_id_5EB50757") == 1) {
    self detach(self.headmodel);
    self.headmodel = "c_usa_cia_combat_harper_head_scar";
    self attach("c_usa_cia_combat_harper_head_scar");
  }
}

spawn_func_hillary() {
  level.hillary = self;
}

spawn_func_sam() {
  level.sam = self;
  self set_ignoreme(1);
}

spawn_func_jones() {
  level.jones = self;
  self set_ignoreme(1);
}

init_flags() {
  flag_init("end_intro_screen");

  if(!level flag_exists("intro_done"))
    flag_init("intro_done");

  flag_init("harper_dead");
  flag_init("pip_playing");
  flag_init("drone_approach", 1);
  flag_init("intro_attack_start");
  flag_init("near_sam_cougar");
  flag_init("start_sam_end_vo");
  flag_init("sam_success");
  flag_init("sam_complete");
  flag_init("sniper_option");
  flag_init("rappel_option");
  flag_init("left_side_rappel_started");
  flag_init("left_side_rappel_guys_dead");
  flag_init("bus_rpg_guy_spawned");
  flag_init("bus_rpg_guy_fired");
  flag_init("bus_rpg_guy_dead");
  flag_init("player_looking_at_rappel_guy");
  flag_init("player_looking_at_rpg_bus_guy");
  flag_init("out_of_ammo");
  flag_init("low_road_complete");
  flag_init("started_rappelling");
  flag_init("done_rappelling");
  flag_init("player_in_cougar");
  flag_init("drive_failing");
  flag_init("low_road_move_up_4");
  flag_init("drive_under_first_overpass");
  flag_init("drive_under_big_overpass");
  flag_init("first_drone_strike");
  flag_init("allow_sniper_exit");
  flag_init("player_approaches_convoy");
  flag_init("la_1_sky_transition");
  flag_init("objective_g20_failed");
  flag_init("objective_g20_check");
  flag_init("move_to_pillar");
  flag_init("truck_right");
  flag_init("street_cops_arrived");
  flag_init("claw_grenade");
  flag_init("bdog_noharper_spawned");
  flag_init("bdog_noharper_moved_down_street");
  flag_init("bdog_noharper_dead");
  flag_init("bdog_front_spawned");
  flag_init("bdog_front_wounded");
  flag_init("bdog_front_immobilized");
  flag_init("bdog_front_dead");
  flag_init("bdog_back_spawned");
  flag_init("bdog_back_wounded");
  flag_init("bdog_back_immobilized");
  flag_init("bdog_back_dead");
  flag_init("bdog_front_dead_friendlies_moved");
  flag_init("intersection_started");
  flag_init("fl_clear_the_street");
  flag_init("fl_player_entered_plaza");
  flag_init("plaza_gunner_spawned");
  flag_init("plaza_gunner_dead");
  flag_init("brute_force_fail");
  flag_init("rooftop_sam_in");
  flag_init("intersect_vip_cougar_died");
  flag_init("event_6_done");
  flag_init("f35_la_plaza_crash_start");
  flag_init("f35_la_plaza_crash_end");
  flag_init("la_arena_start");
  flag_init("anderson_saved");
  flag_init("ending_ai_can_die");
  flag_init("ending_player_arrived");
  flag_init("intersect_vip_cougar_saved");
  flag_init("building_collapsing");
  flag_init("got_hit_by_claw");
  flag_init("someone_on_train");
  flag_init("someone_near_hotel");
  flag_init("vo_general");
  flag_init("police_in_hotel");
  flag_init("plaza_vo_done");
  flag_init("intro_harper_moveup");
  flag_init("vtol_off_path");
  flag_init("player_can_board");
  flag_init("player_in_f35");
  flag_init("player_flying");
  flag_init("player_awake");
  flag_init("no_fail_from_distance");
  flag_init("F35_pilot_saved");
  flag_init("G20_1_saved");
  flag_init("G20_2_saved");
  flag_init("G20_1_dead");
  flag_init("G20_2_dead");
  flag_init("convoy_movement_started");
  flag_init("convoy_can_move");
  flag_init("player_in_range_of_convoy");
  flag_init("convoy_in_position");
  flag_init("ground_targets_escape");
  flag_init("convoy_at_ground_targets");
  flag_init("ground_targets_done");
  flag_init("tutorial_done");
  flag_init("convoy_nag_override");
  flag_init("hotel_street_truck_group_1_spawned");
  flag_init("convoy_at_roadblock");
  flag_init("roadblock_done");
  flag_init("convoy_at_rooftops");
  flag_init("rooftops_done");
  flag_init("convoy_at_dogfight");
  flag_init("convoy_continue");
  flag_init("dogfight_wave_1");
  flag_init("dogfight_wave_2");
  flag_init("dogfight_wave_3");
  flag_init("dogfight_done");
  flag_init("convoy_at_trenchrun");
  flag_init("trenchrun_done");
  flag_init("trenchruns_start");
  flag_init("convoy_at_hotel");
  flag_init("hotel_done");
  flag_init("convoy_at_outro");
  flag_init("outro_start");
  flag_init("ejection_start");
  flag_init("eject_done");
  flag_init("outro_done");
  flag_init("gas_station_destroyed");
  flag_init("warehouse_destroyed");
  flag_init("ground_attack_vehicles_dead");
  flag_init("rooftop_enemies_dead");
  flag_init("eject_sequence_started");
  flag_init("convoy_at_apartment_building");
  flag_init("convoy_at_parking_structure");
  flag_init("la_transition_setup_done");
  flag_init("player_passed_garage");
  flag_init("start_anderson_f35_exit");
  flag_init("convoy_at_trenchrun_turn_2");
  flag_init("convoy_at_trenchrun_turn_3");
  flag_init("missile_event_started");
  flag_init("dogfights_story_done");
  flag_init("missile_can_damage_player");
  flag_init("force_flybys_available");
  flag_init("strafing_run_active");
  flag_init("strafing_wave_done");
  flag_init("convoy_passed_roundabout");
  flag_init("player_at_rooftops");
  flag_init("building_collapse_done");
  flag_init("pip_intro_done");
  flag_init("eject_drone_spawned");
  flag_init("roadblock_clear");
  flag_init("do_anderson_landing_vo");
  flag_init("ok_to_drop_building1");
  flag_init("ok_to_drop_building");
  flag_init("bdog_back_dead_friendlies_moved");
  flag_init("bdog_back_dead_friendlies_moved_to_plaza");
  flag_init("player_at_convoy_end");
  flag_init("do_plaza_anderson_convo");
  flag_init("player_brought_shield");
}

setup_objectives() {
  if(getdvar(#"mapname") == "la_1") {
    level.obj_prom_night = maps\_objectives::register_objective(&"LA_SHARED_OBJ_PROM_NIGHT");
    level.obj_shoot_drones = maps\_objectives::register_objective(&"LA_SHARED_OBJ_SHOOT_DRONES");
    level.obj_regroup = maps\_objectives::register_objective(&"LA_SHARED_OBJ_REGROUP");
    level.obj_rappel = maps\_objectives::register_objective(&"LA_SHARED_OBJ_RAPPEL_TEXT");
    level.obj_rappel2 = maps\_objectives::register_objective(&"LA_SHARED_OBJ_RAPPEL2");
    level.obj_snipe = maps\_objectives::register_objective(&"LA_SHARED_OBJ_SNIPE_TEXT");
    level.obj_potus = maps\_objectives::register_objective(&"LA_SHARED_OBJ_POTUS_TEXT");
    level.obj_highway = maps\_objectives::register_objective(&"LA_SHARED_OBJ_HIGHWAY");
    level.obj_g20_cougar = maps\_objectives::register_objective(&"LA_SHARED_OBJ_G20_COUGAR");
    level.obj_drive = maps\_objectives::register_objective(&"LA_SHARED_OBJ_DRIVE_TEXT");
  }

  level.obj_interact = maps\_objectives::register_objective(&"");
  level.obj_lock_perk = maps\_objectives::register_objective(&"");
  level.obj_brute_perk = maps\_objectives::register_objective(&"");
  level.obj_intruder_perk = maps\_objectives::register_objective(&"");

  if(getdvar(#"mapname") != "la_1") {
    level.obj_prom_night = maps\_objectives::register_objective(&"LA_SHARED_OBJ_PROM_NIGHT");
    level.obj_potus = maps\_objectives::register_objective(&"LA_SHARED_OBJ_POTUS_TEXT");
    level.obj_street_regroup = maps\_objectives::register_objective(&"LA_SHARED_OBJ_STREET_REGROUP");
    level.obj_street = maps\_objectives::register_objective(&"LA_SHARED_OBJ_STREET");
    level.obj_g20_street = maps\_objectives::register_objective(&"LA_SHARED_OBJ_G20_STREET");
    level.obj_big_dogs_harper = maps\_objectives::register_objective(&"LA_SHARED_OBJ_BIG_DOGS");
    level.obj_big_dogs_noharper = maps\_objectives::register_objective(&"LA_SHARED_OBJ_BIG_DOGS_NOHARPER");
    level.obj_plaza = maps\_objectives::register_objective(&"LA_SHARED_OBJ_PLAZA");
    level.obj_arena = maps\_objectives::register_objective(&"LA_SHARED_OBJ_ARENA");
    level.obj_follow = maps\_objectives::register_objective(&"");
    level.obj_anderson = maps\_objectives::register_objective(&"");
    level.obj_sonar_out = maps\_objectives::register_objective(&"");
    level.obj_fly = maps\_objectives::register_objective(&"LA_SHARED_OBJ_FLY");
    level.obj_protect = maps\_objectives::register_objective(&"LA_SHARED_OBJ_PROTECT");
    level.obj_destroy_drones = maps\_objectives::register_objective(&"LA_SHARED_OBJ_DESTROY_DRONES");
    level.obj_follow_van = maps\_objectives::register_objective(&"LA_SHARED_OBJ_FOLLOW_VAN");
    level.obj_follow_ambulance = maps\_objectives::register_objective(&"LA_SHARED_OBJ_FOLLOW_AMBULANCE");
    level.obj_roadblock = maps\_objectives::register_objective(&"LA_SHARED_OBJ_ROADBLOCK");
    level.obj_rooftops = maps\_objectives::register_objective(&"LA_SHARED_OBJ_ROOFTOPS");
    level.obj_dogfights = maps\_objectives::register_objective(&"LA_SHARED_OBJ_DOGFIGHTS");
    level.obj_dogfights_last = maps\_objectives::register_objective(&"");
    level.obj_dogfights_strafe = maps\_objectives::register_objective(&"");
    level.obj_trenchrun_1 = maps\_objectives::register_objective(&"LA_SHARED_OBJ_TRENCHRUN");
    level.obj_trenchrun_2 = maps\_objectives::register_objective(&"LA_SHARED_OBJ_TRENCHRUN");
    level.obj_trenchrun_3 = maps\_objectives::register_objective(&"LA_SHARED_OBJ_TRENCHRUN");
    level.obj_trenchrun_4 = maps\_objectives::register_objective(&"LA_SHARED_OBJ_TRENCHRUN");
  }
}

setup_story_states() {
  flag_wait("level.player");

  if(level.player get_story_stat("HARPER_DEAD_IN_YEMEN") || getdvarint(#"_id_90CEA541") == 1)
    flag_set("harper_dead");
}

skipto_cleanup() {
  if(level.script == "la_1")
    load_gumps();

  if(level.skipto_point == "intro") {
    return;
  }
  flag_set("intro_done");

  if(level.skipto_point == "after_the_attack") {
    return;
  }
  if(level.skipto_point == "sam_jump") {
    return;
  }
  if(level.skipto_point == "sam") {
    clientnotify("set_sam_int_context");
    return;
  }

  exploder(1001);

  if(isDefined(level.obj_shoot_drones))
    skip_objective(level.obj_shoot_drones);

  if(level.skipto_point == "cougar_fall") {
    return;
  }
  if(level.script == "la_1")
    aerial_vehicles_no_target();

  if(level.skipto_point == "sniper_rappel") {
    return;
  }
  if(level.skipto_point == "sniper_exit") {
    return;
  }
  flag_set("started_rappelling");
  flag_set("done_rappelling");
  flag_set("player_approaches_convoy");

  if(level.skipto_point == "g20_group1") {
    return;
  }
  if(isDefined(level.obj_highway)) {
    skip_objective(level.obj_highway);
    skip_objective(level.obj_g20_cougar);
  }

  if(level.skipto_point == "drive") {
    return;
  }
  flag_set("la_1_sky_transition");

  if(level.skipto_point == "skyline") {
    return;
  }
  if(level.skipto_point == "street") {
    clientnotify("set_silent_context");
    return;
  }

  exploder(56);
  exploder(57);
  exploder(58);
  exploder(59);
  flag_set("bdog_front_dead");
  flag_set("bdog_back_dead");
  flag_set("bdog_front_dead_friendlies_moved");

  if(level.skipto_point == "plaza") {
    return;
  }
  flag_set("plaza_vo_done");
  flag_set("intersection_started");

  if(level.skipto_point == "intersection") {
    return;
  }
  if(level.skipto_point == "arena") {
    return;
  }
  if(level.skipto_point == "arena_exit") {
    return;
  }
  if(level.skipto_point == "f35_wakeup") {
    return;
  }
  level.player show_hud();
  flag_set("player_awake");
  flag_set("player_can_board");

  if(level.skipto_point == "f35_boarding") {
    return;
  }
  if(level.skipto_point != "f35_outro")
    flag_set("player_flying");

  flag_set("player_in_f35");

  if(level.skipto_point == "f35_flying") {
    return;
  }
  flag_set("tutorial_done");

  if(level.skipto_point == "f35_ground_targets") {
    return;
  }
  flag_set("convoy_at_ground_targets");
  flag_set("ground_targets_done");

  if(level.skipto_point == "f35_pacing") {
    return;
  }
  flag_set("player_passed_garage");
  flag_set("convoy_passed_roundabout");
  flag_set("roadblock_done");

  if(level.skipto_point == "f35_rooftops") {
    return;
  }
  flag_set("rooftops_done");
  flag_set("convoy_at_dogfight");

  if(level.skipto_point == "f35_dogfights") {
    return;
  }
  flag_set("dogfights_story_done");
  flag_set("dogfight_done");

  if(level.skipto_point == "f35_trenchrun") {
    return;
  }
  flag_set("trenchruns_start");
  flag_set("trenchrun_done");

  if(level.skipto_point == "f35_hotel") {
    return;
  }
  flag_set("hotel_done");

  if(level.skipto_point == "f35_eject") {
    return;
  }
  flag_set("eject_done");

  if(level.skipto_point == "f35_outro")
    return;
}

load_gumps() {
  screen_fade_out(0);

  if(is_after_skipto("g20_group1"))
    load_gump("la_1_gump_1d");
  else if(is_after_skipto("cougar_fall"))
    load_gump("la_1_gump_1c");
  else if(is_after_skipto("intro"))
    load_gump("la_1_gump_1b");
  else
    load_gump("la_1_gump_1a");

  screen_fade_in(0);
}

level_settings() {
}

setup_challenges() {
  if(level.script == "la_1") {
    self thread maps\_challenges_sp::register_challenge("turretdrones", ::challenge_turretdrones);
    self thread maps\_challenges_sp::register_challenge("snipekills", ::challenge_snipekills);
  } else if(level.script == "la_1b") {
    self thread maps\_challenges_sp::register_challenge("qrkills", ::challenge_qrkills);
    self thread maps\_challenges_sp::register_challenge("roofdrones", ::challenge_roofdrones);
    self thread maps\_challenges_sp::register_challenge("rescueagents", ::challenge_rescueagents);
    self thread maps\_challenges_sp::register_challenge("rescuesecond", ::challenge_rescuesecond);
    self thread track_saveanderson();
  } else if(level.script == "la_2") {
    self thread maps\_challenges_sp::register_challenge("saveanderson", ::challenge_saveanderson);
    self thread maps\_challenges_sp::register_challenge("nodeath", ::challenge_nodeath);
    self thread maps\_challenges_sp::register_challenge("savecougars", ::challenge_savecougars);
  }
}

weapon_is_sniper_weapon(str_weapon) {
  return weaponissniperweapon(str_weapon) || issubstr(str_weapon, "metalstorm");
}

weapon_is_charge_weapon(str_weapon) {
  return weaponissniperweapon(str_weapon) && issubstr(str_weapon, "metalstorm");
}

challenge_snipekills(str_notify) {
  level endon("rappel_option");
  flag_wait("sniper_option");
  level.playersniperkillsafterbigrig = 0;
  add_global_spawn_function("axis", ::challenge_snipekills_death_listener, str_notify);
  a_enemy_ai = getaiarray("axis");
  array_thread(a_enemy_ai, ::challenge_snipekills_death_listener, str_notify);
  flag_wait("start_last_stand");
  remove_global_spawn_function("axis", ::challenge_snipekills_death_listener);
}

challenge_snipekills_death_listener(str_notify) {
  while(isalive(self)) {
    self waittill("death", e_attacker, str_mod, str_weapon, str_location);

    if(flag("sniper_option") && isDefined(str_weapon) && isplayer(e_attacker) && weapon_is_sniper_weapon(str_weapon)) {
      if(isDefined(self.damagelocation) && (self.damagelocation == "head" || self.damagelocation == "helmet" || self.damagelocation == "neck"))
        level.player notify(str_notify);

      level.playersniperkillsafterbigrig++;

      println("player sniped " + level.playersniperkillsafterbigrig + "guys");

    }
  }
}

challenge_turretdrones(str_notify) {
  flag_wait("sam_cougar_fall_player_done");
  wait 1;

  if(level.n_sam_missiles_fired == level.num_planes_shot)
    self notify(str_notify);
}

challenge_roofdrones(str_notify) {
  flag_wait("rooftop_sam_in");

  for(n_kills = 0; flag("rooftop_sam_in"); n_kills++)
    level waittill("rooftop_drone_killed");

  n_kills--;
  level waittill("sam_out_anim_done");

  for(i = 0; i < n_kills; i++) {
    self notify(str_notify);
    wait 0.1;
  }
}

challenge_qrkills(str_notify) {
  flag_wait("level.player");
  level.player waittill_player_has_intruder_perk();
  add_global_spawn_function("axis", ::challenge_qrkills_death_listener, str_notify);
}

challenge_qrkills_death_listener(str_notify) {
  self waittill("death", e_attacker, b_damage_from_underneath, str_weapon);

  if(isDefined(e_attacker) && isDefined(e_attacker.targetname) && e_attacker.targetname == "attackdrone")
    level.player notify(str_notify);
}

challenge_rescueagents(str_notify) {
  level waittill("brute_force_done");
  self notify(str_notify);
}

challenge_rescuesecond(str_notify) {
  level endon("intersect_vip_cougar_died");
  flag_wait("intersect_vip_cougar_saved");
  wait 2;
  self notify(str_notify);
}

challenge_saveanderson(str_notify) {
  level waittill("skybuster_kill_3x");
  self notify(str_notify);
}

track_saveanderson() {
  level.plaza_sam_time = 0;
  flag_wait("la_arena_start");
  n_time_limit = gettime() + 240000;
  flag_wait("building_collapsing");
  n_complete_time = gettime() - level.plaza_sam_time;

  if(n_complete_time < n_time_limit)
    flag_set("anderson_saved");
}

challenge_savecougars(str_notify) {
  flag_wait("eject_done");

  foreach(vh in level.convoy.vehicles) {
    self notify(str_notify);
    wait 0.05;
  }
}

challenge_save_f35s(str_notify) {
  while(true) {
    level waittill("player_saved_tracked_friendly_f35");
    self notify(str_notify);
  }
}

challenge_nodeath(str_notify) {
  flag_wait("eject_done");
  n_deaths = get_player_stat("deaths");

  if(n_deaths == 0)
    self notify(str_notify);
}

player_has_sniper_weapon() {
  a_current_weapons = level.player getweaponslist();

  foreach(str_weapon in a_current_weapons) {
    if(weapon_is_sniper_weapon(str_weapon))
      return true;
  }

  return false;
}

player_has_charge_weapon() {
  a_current_weapons = level.player getweaponslist();

  foreach(str_weapon in a_current_weapons) {
    if(weapon_is_charge_weapon(str_weapon))
      return true;
  }

  return false;
}

ai_group_get_num_killed(aigroup) {
  return level._ai_group[aigroup].killed_count;
}

give_max_ammo_for_sniper_weapons() {
  a_current_weapons = level.player getweaponslist();

  foreach(str_weapon in a_current_weapons) {
    if(weapon_is_sniper_weapon(str_weapon)) {
      self setweaponammoclip(str_weapon, 1000);
      self setweaponammostock(str_weapon, 1000);
    }
  }
}

waittill_player_has_sniper_weapon() {
  while(!self player_has_sniper_weapon())
    self waittill("weapon_change");
}

switch_player_to_sniper_weapon() {
  assert(isplayer(self), "switch_player_to_sniper_weapon not called on a player!");
  a_current_weapons = self getweaponslist();
  b_gave_weapon = 0;

  foreach(str_weapon in a_current_weapons) {
    if(weapon_is_sniper_weapon(str_weapon)) {
      b_gave_weapon = 1;
      level.player switchtoweapon(str_weapon);
      break;
    }
  }

  assert(b_gave_weapon, "Tried to switch player to sniper weapon but player doesn't have sniper weapon.");
}

stick_player(b_look, n_clamp_right, n_clamp_left, n_clamp_top, n_clamp_bottom) {
  if(!isDefined(b_look))
    b_look = 0;

  self.m_link = spawn("script_model", self.origin);
  self.m_link.angles = self.angles;
  self.m_link setmodel("tag_origin");

  if(b_look)
    self playerlinktodelta(self.m_link, "tag_origin", 1, n_clamp_right, n_clamp_left, n_clamp_top, n_clamp_bottom, 1);
  else
    self playerlinktoabsolute(self.m_link, "tag_origin");
}

unstick_player() {
  if(isDefined(self.m_link))
    self.m_link delete();
}

waittill_all_axis_are_dead() {
  while(getaiarray("axis").size > 0)
    wait 0.2;
}

waittill_player_approaches_ai(ai_goal, n_radius) {
  do {
    wait 0.05;
    v_eye = ai_goal get_eye();
    b_looking = self is_player_looking_at(v_eye);
    n_dist = distance2dsquared(v_eye, self.origin);
  }
  while(!b_looking || n_dist > n_radius * n_radius);
}

get_player_cougar() {
  if(!isDefined(level.veh_player_cougar)) {
    level.veh_player_cougar = get_specific_vehicle("g20_group1_cougar");
    level.veh_player_cougar thread player_cougar_init();
  }

  return level.veh_player_cougar;
}

player_cougar_init() {
  self hidepart("tag_windshield_d1");
  self hidepart("tag_windshield_d2");
  self makevehicleunusable();
}

f35_vtol_spawn_func() {
  self thread fa38_hover();
  self thread fa38_fly();
  self notify("fly");
}

fa38_fly() {
  self endon("death");

  while(true) {
    self waittill("fly");

    if(!(isDefined(self.hovering) && !self.hovering)) {
      play_fx("f35_exhaust_fly", undefined, undefined, "hover", 1, "origin_animate_jnt");
      self.hovering = 0;
    }
  }
}

fa38_hover() {
  self endon("death");

  while(true) {
    self waittill("hover");

    if(!(isDefined(self.hovering) && self.hovering)) {
      play_fx("f35_exhaust_hover_rear", undefined, undefined, "fly", 1, "tag_fx_nozzle_left_rear");
      play_fx("f35_exhaust_hover_rear", undefined, undefined, "fly", 1, "tag_fx_nozzle_right_rear");
      play_fx("f35_exhaust_hover_front", undefined, undefined, "fly", 1, "tag_fx_nozzle_left");
      play_fx("f35_exhaust_hover_front", undefined, undefined, "fly", 1, "tag_fx_nozzle_right");
      self.hovering = 1;
    }
  }
}

get_f35_vtol() {
  return get_specific_vehicle("f35_vtol");
}

get_specific_vehicle(targetname) {
  veh = getent(targetname, "targetname");

  if(!isDefined(veh))
    veh = spawn_vehicle_from_targetname(targetname);

  return veh;
}

use_player_cougar() {
  level.veh_player_cougar = get_player_cougar();
  level.veh_player_cougar godon();
  level.veh_player_cougar makevehicleusable();
  level.veh_player_cougar usevehicle(level.player, 0);
  level.veh_player_cougar makevehicleunusable();
  level.player enableinvulnerability();
  level.player hide_hud();
  level.player allowmelee(0);
  flag_set("player_in_cougar");
  wait 0.5;
  level thread cougar_controls_instructions();
}

cougar_controls_instructions() {
  screen_message_create(&"LA_SHARED_COUGAR_GAS", & "LA_SHARED_COUGAR_BRAKE");
  n_timeout = 0;

  while(!level.player gasbuttonpressed()) {
    wait 0.05;
    n_timeout++;

    if(n_timeout > 100) {
      break;
    }
  }

  screen_message_delete();
  screen_message_create(&"LA_SHARED_COUGAR_STEER");
  n_timeout = 0;
  b_steered = 0;

  while(!b_steered) {
    n_threshold = 0.4;
    n_move_stick_strength = length(level.player getnormalizedmovement());
    b_steered = n_threshold < n_move_stick_strength;
    wait 0.05;
    n_timeout++;

    if(n_timeout > 100) {
      break;
    }
  }

  screen_message_delete();
}

func_on_death(func_after_death) {
  assert(isDefined(func_after_death), "func_after_death is a required parameter for func_on_death");
  self waittill("death");

  if(isDefined(self))
    self[[func_after_death]]();
}

debug_hud_elem_add(func_debug, str_custom_dvar) {
  assert(isDefined(func_debug), "func_debug is a required parameter for debug_hud_elem_add");

  if(!isDefined(level.debug_hud))
    level.debug_hud = spawnstruct();

  if(!isDefined(level.debug_hud.elems))
    level.debug_hud.elems = [];

  level.debug_hud.scale_y = 15;
  n_scale = level.debug_hud.scale_y;
  hud_elem = newhudelem();
  level.debug_hud.elems[level.debug_hud.elems.size] = hud_elem;
  hud_elem.horzalign = "left";
  hud_elem.vertalign = "bottom";
  hud_elem.alignx = "left";
  hud_elem.aligny = "bottom";
  hud_elem.x = 0;
  hud_elem.y = level.debug_hud.elems.size * n_scale * -1;
  hud_elem.font = "objective";
  hud_elem.font_scale = 1;
  hud_elem.color = (0, 0, 1);
  hud_elem thread _debug_hud_elem_should_show(str_custom_dvar);
  hud_elem thread _debug_hud_elem_func(func_debug);
  return hud_elem;
}

debug_hud_elem_set_text(str_text) {
  assert(isDefined(str_text), "str_text is a required parameter for debug_hud_elem_set_text");
  self.debug_text = str_text;
}

debug_hud_elem_remove(hud_elem) {
  assert(isDefined(hud_elem), "hud_elem parameter is required for debug_hud_elem_remove!");
  b_has_removed = 0;

  for(i = 0; i < level.debug_hud.elems.size; i++) {
    if(level.debug_hud.elems[i] == hud_elem) {
      hud_to_remove = level.debug_hud.elems[i];
      hud_to_remove notify("debug_hud_remove");
      wait 0.05;
      hud_to_remove destroy();
      b_has_removed = 1;
      continue;
    }

    if(b_has_removed) {
      n_index = i - 1;
      n_scale = level.debug_hud.scale_y;
      hud_current = level.debug_hud.elems[i];
      hud_current.y = n_index * n_scale * -1;
    }
  }

  arrayremovevalue(level.debug_hud.elems, undefined);
}

_debug_hud_elem_func(func_debug) {
  self endon("debug_hud_remove");
  self[[func_debug]]();
}

_debug_hud_elem_should_show(str_custom_dvar) {
  self endon("debug_hud_remove");
  str_dvar = "show_debug_hud";

  if(isDefined(str_custom_dvar))
    str_dvar = str_custom_dvar;

  self.dvar_name = str_dvar;
  b_should_show_debug = 0;

  while(true) {
    if(isDefined(getdvar(str_dvar)) && getdvar(str_dvar) == "1") {
      b_should_show_debug = 1;

      if(isDefined(self.debug_text))
        self settext(self.debug_text);
    } else {
      b_should_show_debug = 0;
      self settext("");
    }

    self.hud_should_show = b_should_show_debug;
    wait 0.5;
  }
}

press_x_to_continue() {
  screen_message_create("press x to continue");
  level.player waittill_use_button_pressed();
  screen_message_delete();
}

la_1_vehicle_damage(e_inflictor, e_attacker, n_damage, n_flags, str_mod, str_weapon, v_point, v_dir, str_hitloc, psoffsettime, b_underneath, n_model_index, str_part_name) {
  if(self.vehicleclass == "4 wheel") {
    if(isDefined(level.veh_player_cougar) && self == level.veh_player_cougar) {
      return;
    }
    b_plane_weapon = isDefined(e_attacker.vehicleclass) && e_attacker.vehicleclass == "plane";
    b_explosion = isDefined(str_mod) && (str_mod == "MOD_EXPLOSIVE" || str_mod == "MOD_PROJECTILE" || str_mod == "MOD_UNKNOWN");

    if(b_explosion && b_plane_weapon) {
      vehicle_explosion_launch(v_point);
      self finishvehicledamage(e_inflictor, e_attacker, n_damage, n_flags, "MOD_UNKNOWN", str_weapon, v_point, v_dir, str_hitloc, psoffsettime, b_underneath, n_model_index, str_part_name, 0);
      return;
    }
  }

  maps\_callbackglobal::callback_vehicledamage(e_inflictor, e_attacker, n_damage, n_flags, str_mod, str_weapon, v_point, v_dir, str_hitloc, psoffsettime, b_underneath, n_model_index, str_part_name);
}

la_1b_intersection_vehicle_damage(e_inflictor, e_attacker, n_damage, n_flags, str_mod, str_weapon, v_point, v_dir, str_hitloc, psoffsettime, b_underneath, n_model_index, str_part_name) {
  if(self.vehicleclass == "4 wheel") {
    b_explosion = isDefined(str_mod) && (str_mod == "MOD_EXPLOSIVE" || str_mod == "MOD_PROJECTILE" || str_mod == "MOD_UNKNOWN");

    if(b_explosion) {
      vehicle_explosion_launch(v_point);
      self finishvehicledamage(e_inflictor, e_attacker, n_damage, n_flags, "MOD_UNKNOWN", str_weapon, v_point, v_dir, str_hitloc, psoffsettime, b_underneath, n_model_index, str_part_name, 0);
      return;
    }
  }

  maps\_callbackglobal::callback_vehicledamage(e_inflictor, e_attacker, n_damage, n_flags, str_mod, str_weapon, v_point, v_dir, str_hitloc, psoffsettime, b_underneath, n_model_index, str_part_name);
}

vehicle_explosion_launch(v_hit_point, n_force) {
  self endon("death");
  s_launch = get_launch_params_from_structs();

  if(isDefined(s_launch)) {
    v_impact_point = s_launch.v_impact;
    v_world_force = s_launch.v_force;
  } else {
    v_impact_pos = v_hit_point;
    v_rocket_impact_point = v_hit_point;
    v_forward = anglestoforward(self.angles);
    v_right = anglestoright(self.angles);
    v_up = anglestoright(self.angles);
    n_max_x = 500;
    n_max_y = 400;
    v_impact_pos = v_rocket_impact_point - self.origin;
    n_dist_in_front = vectordot(v_forward, v_impact_pos);
    n_dist_to_v_right = vectordot(v_right, v_impact_pos);

    if(abs(n_dist_in_front) > n_max_x || abs(n_dist_to_v_right) > n_max_y)
      return false;

    str_impact_orient = "";

    if(abs(n_dist_in_front) < n_max_x * 0.25)
      str_impact_orient = "mid_";
    else if(n_dist_in_front < 0)
      str_impact_orient = "rear_";
    else
      str_impact_orient = "front_";

    if(n_dist_to_v_right < 0)
      str_impact_orient = str_impact_orient + "left";
    else
      str_impact_orient = str_impact_orient + "v_right";

    v_impact_point = (0, 0, 0);
    v_force = (0, 0, 0);

    switch (str_impact_orient) {
      case "mid_left":
        v_impact_point = (28, -46, 50);
        v_force = (0, 308, 30);
        break;
      case "mid_v_right":
        v_impact_point = (28, 42, 50);
        v_force = (0, -340, 30);
        break;
      case "front_left":
        v_impact_point = (108, 2, 50);
        v_force = (-16, 132, 126);
        break;
      case "front_v_right":
        v_impact_point = (108, 2, 50);
        v_force = (-32, -132, 126);
        break;
      case "rear_left":
        v_impact_point = (-84, -22, 26);
        v_force = (56, 180, 150);
        break;
      case "rear_v_right":
        v_impact_point = (-92, 18, 26);
        v_force = (72, -148, 150);
        break;
    }

    v_world_force = v_forward * v_force[0] + v_right * v_force[1] + v_up * v_force[2];

    if(isDefined(n_force))
      v_world_force = vectornormalize(v_world_force) * n_force;
  }

  e_fx = spawn_model("tag_origin", self.origin, self.angles);
  e_fx linkto(self);
  playfxontag(getfx("vehicle_launch_trail"), e_fx, "tag_origin");

  level thread draw_line_for_time(v_impact_point, v_impact_point + v_world_force, 1, 0, 0, 2);

  if(self.classname == "script_vehicle")
    self launchvehicle(v_world_force, v_impact_point);
  else if(self.classname == "script_model")
    self physicslaunch(v_impact_point, v_world_force);

  e_fx delay_thread(4, ::self_delete);
}

get_launch_params_from_structs() {
  if(isDefined(self.target)) {
    s_start = get_struct(self.target);

    if(isDefined(s_start)) {
      s_end = get_struct(s_start.target);
      assert(isDefined(s_end));
      v_start = s_start.origin;
      v_end = s_end.origin;
      v_dir = v_end - v_start;
      a_trace = bullettrace(v_start, v_end, 0, undefined);
      v_hit_pos = a_trace["position"];
      n_intensity = 200;

      if(isDefined(s_start.script_float))
        n_intensity = s_start.script_float;

      s_return = spawnstruct();
      s_return.v_impact = v_hit_pos;
      s_return.v_force = vectornormalize(v_dir) * n_intensity;
      return s_return;
    }
  }
}

_av_out_of_world() {
  self endon("death");

  while(true) {
    if(self.origin[2] < -30000) {
      self notify("crash_move_done");

      if(isDefined(self.deleted) && self.deleted)
        self delete();
      else {
        self.delete_on_death = 1;
        self notify("death");

        if(!isalive(self))
          self delete();
      }
    }

    wait 0.05;
  }
}

aerial_vehicles_no_target() {
  level.aerial_vehicles_no_target = 1;
  a_veh = get_vehicle_array();

  foreach(veh in a_veh) {
    if(target_istarget(veh))
      target_remove(veh);
  }
}

fade_with_shellshock_and_visionset() {
  current_vision_set = level.player getvisionsetnaked();

  if(current_vision_set == "")
    current_vision_set = "default";

  level thread maps\_shellshock::main(level.player.origin, 15, 256, 0, 0, 0, undefined, "la_1_crash_exit", 0);
  visionsetnaked("sp_la_1_crash_exit");
  wait 5;
  screen_fade_in(0);
  visionsetnaked(current_vision_set, 25);
}

veh_brake_unload() {
  self endon("death");
  self playsound("evt_truck_incoming");
  self waittill("brake");
  self playsound("evt_truck_stop");

  while(self getspeedmph() > 2)
    wait 0.1;

  self notify("unload");
}

func_on_notify(str_notify, func, param_1, param_2, param_3, param_4, param_5) {
  assert(isDefined(str_notify), "str_notify is a required parameter for func_on_notify");
  assert(isDefined(func), "func is a required parameter for func_on_notify");
  self thread _func_on_notify(str_notify, func, param_1, param_2, param_3, param_4, param_5);
}

_func_on_notify(str_notify, func, param_1, param_2, param_3, param_4, param_5) {
  self endon("death");
  self waittill(str_notify);
  single_thread(self, func, param_1, param_2, param_3, param_4, param_5);
}

get_forward(b_flat, str_tag) {
  if(!isDefined(b_flat))
    b_flat = 0;

  if(isplayer(self))
    v_angles = level.player getplayerangles();
  else if(isDefined(str_tag))
    v_angles = self gettagangles(str_tag);
  else
    v_angles = self.angles;

  if(b_flat)
    v_angles = (v_angles[0], v_angles[1], 0);

  v_forward = anglestoforward(v_angles);
  return v_forward;
}

delete_ents(str_name, str_key) {
  assert(isDefined(str_name), "str_name is a required argument for delete_ents()");

  if(!isDefined(str_key))
    str_key = "targetname";

  array_func(getentarray(str_name, str_key), ::self_delete);
}

delete_vehicle_on_flag(str_flag) {
  self endon("death");
  flag_wait("str_flag");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

get_relative_position_string(e_ent) {
  v_local = e_ent worldtolocalcoords(self.origin);
  str_local_coordinates = v_local[0] + " " + v_local[1] + " " + v_local[2];
  return str_local_coordinates;
}

cleanup(ent) {
  if(isDefined(ent))
    ent delete();
}

cleanup_array(a_ents) {
  array_delete(a_ents);
}

cleanup_kvp(str_value, str_key) {
  if(!isDefined(str_key))
    str_key = "targetname";

  a_ents = getentarray(str_value, str_key);
  cleanup_array(a_ents);
}

set_goal_to_current_pos() {
  self setgoalpos(self.origin);
}

police_car() {
  self endon("death");
  self play_fx("siren_light", undefined, undefined, "death", 1, "tag_body");
  wait(randomfloatrange(0.05, 1));
  self thread police_car_audio();
}

police_car_audio() {
  sound_ent = spawn("script_origin", self.origin);
  sound_ent playloopsound("amb_radio_chatter_loop", 0.5);
  self waittill("death");
  sound_ent delete();
}

police_motorcycle() {
  self endon("death");
  wait(randomfloatrange(0.05, 1));
  play_fx("siren_light_bike", undefined, undefined, "death", 1, "tag_fx_lights_front");
}

is_police_car(ent) {
  if(isDefined(ent.model)) {
    if(ent.model == "veh_t6_police_car" || ent.model == "veh_t6_police_car_low" || ent.model == "veh_t6_police_car_static")
      return true;
  }

  return false;
}

is_police_motorcycle(ent) {
  if(isDefined(ent.model)) {
    if(ent.model == "veh_t6_civ_police_motorcycle")
      return true;
  }

  return false;
}

is_suv(ent) {
  return isDefined(ent.model) && issubstr(ent.model, "veh_iw_civ_suv");
}

waittill_not_god_mode() {
  while(isgodmode(self))
    wait 0.05;
}

new_timer() {
  s_timer = spawnstruct();
  s_timer.n_time_created = gettime();
  return s_timer;
}

get_time() {
  t_now = gettime();
  return t_now - self.n_time_created;
}

get_time_in_seconds() {
  return get_time() / 1000;
}

add_scripted_damage_state(n_percentage_to_change_state, func_on_state_change) {
  assert(isDefined(n_percentage_to_change_state), "n_percentage_to_change_state is a required argument for add_scripted_damage_state!");
  assert(n_percentage_to_change_state > 0 && n_percentage_to_change_state < 1, "add_scripted_damage_state was passed an invalue percentage to change state. Passed " + n_percentage_to_change_state + ", but valid range is between 0 and 1.");
  assert(isDefined(func_on_state_change), "func_on_state_change is a required argument for add_scripted_damage_state!");
  assert(isDefined(self.health) || isDefined(self.armor), "no .health or .armor parameter found on entitiy" + self getentitynumber() + " at position " + self.origin);
  b_use_custom_health = isDefined(self.armor);
  n_health_max = self.health;

  if(b_use_custom_health)
    n_health_max = self.armor;

  b_state_changed = 0;
  n_damage_to_change_state = n_health_max * n_percentage_to_change_state;

  while(!b_state_changed) {
    self waittill("damage", n_damage);
    n_current_health = self.health;

    if(b_use_custom_health)
      n_current_health = self.armor;

    if(n_current_health < n_damage_to_change_state)
      b_state_changed = 1;
  }

  self[[func_on_state_change]]();
}

is_greenlight_build() {
  b_is_greenlight_build = 0;

  if(getdvar(#"_id_31D6EE53") != "" && getdvarint(#"_id_31D6EE53") == 0)
    b_is_greenlight_build = 1;

  return b_is_greenlight_build;
}

spawn_sam_drone_group(str_spawner_name, n_count, angle_offset, override_start_angles) {
  v_player_angles = level.player.angles;

  if(isDefined(override_start_angles))
    v_player_angles = override_start_angles;

  n_spawn_yaw = absangleclamp360(v_player_angles[1] + angle_offset);
  v_spawn_vector_dir = -1;

  if(angle_offset < 180)
    v_spawn_vector_dir = 1;

  a_spawned_drones = [];

  for(i = 0; i < n_count; i++) {
    v_spawn_org = level.player.origin + anglestoforward((0, n_spawn_yaw, 0)) * 15000;
    v_spawn_org = (v_spawn_org[0], v_spawn_org[1], 12000 + randomint(2000));
    veh_drone = spawn_vehicle_from_targetname(str_spawner_name);
    veh_drone setmodel("veh_t6_drone_avenger_x2");
    veh_drone.origin = v_spawn_org;
    v_spawn_vector = anglestoright((0, n_spawn_yaw, 0)) * v_spawn_vector_dir;
    veh_drone.v_spawn_vector = v_spawn_org + v_spawn_vector * 20000;
    v_start_angles = vectortoangles(veh_drone.v_spawn_vector - veh_drone.origin);
    veh_drone setphysangles(v_start_angles);
    veh_drone.v_escape_vector = v_spawn_org;
    veh_drone thread sam_drone();
    a_spawned_drones[a_spawned_drones.size] = veh_drone;
  }

  return a_spawned_drones;
}

sam_drone() {
  self setdefaultpitch(10);
  self setforcenocull();
  self setneargoalnotifydist(1000);
  self ent_flag_init("straffing");
  target_set(self);
  self thread sam_drone_death();
  self thread strafe_player(1, level.sam_cougar, "tag_gunner_barrel2");
  self thread fall_out_of_world();
}

sam_drone_death() {
  level endon("sam_success");

  if(!isDefined(level.num_planes))
    level.num_planes = 0;

  level.num_planes++;
  self waittill("death");
  target_remove(self);

  if(isDefined(self) && self.health <= 0) {
    playfx(level._effect["sam_drone_explode"], self.origin, (0, 0, 1), anglestoforward(self.angles));
    n_dist = distance2d(self.origin, level.player.origin);
    n_quake_scale = clamp(1.0 - n_dist / 25000, 0.25, 1.0);
    n_quake_time = clamp(1.0 - n_dist / 25000, 0.25, 0.5);
    playsoundatposition("evt_turret_shake", (0, 0, 0));
    earthquake(n_quake_scale, n_quake_time, level.player.origin, 1024, level.player);
  }

  if(isDefined(level.num_planes))
    level.num_planes--;

  if(!isDefined(level.num_planes_shot))
    level.num_planes_shot = 0;

  level.num_planes_shot++;
  level notify("sam_hint_drone_killed");
  n_drones_count = get_vehicle_array("ambient_drone", "targetname").size;

  if(level.num_planes_shot >= 36)
    level delay_thread(1, ::flag_set, "sam_success");

  self waittill("crash_move_done");

  if(isDefined(self) && self.health > 0) {
    return;
  }
  if(isDefined(self)) {
    playfx(level._effect["sam_drone_explode"], self.origin, (0, 0, 1), anglestoforward(self.angles));
    n_dist = distance2d(self.origin, level.player.origin);
    n_quake_scale = clamp(1.0 - n_dist / 25000, 0.25, 1.0);
    n_quake_time = clamp(1.0 - n_dist / 25000, 0.25, 0.5);
    playsoundatposition("evt_turret_shake", (0, 0, 0));
    earthquake(n_quake_scale, n_quake_time, level.player.origin, 1024, level.player);
  }
}

strafe_player(b_missiles, e_target, e_target_tag) {
  self endon("death");
  level endon("sam_cougar_mount_started");
  self notify("_strafe_player_");
  self endon("_strafe_player_");

  if(!isDefined(e_target))
    e_target = level.player;

  if(!isDefined(b_missiles))
    b_missiles = 0;

  self ent_flag_set("straffing");

  while(true) {
    v_goal = isDefined(self.v_spawn_vector) ? self.v_spawn_vector : e_target.origin;
    v_goal = v_goal + (randomintrange(-5000, 5000), randomintrange(-5000, 5000), randomintrange(-5000, 5000));

    self thread debug_goal(v_goal);

    self setvehgoalpos(v_goal, 0);
    self thread drone_speed_manager();
    self waittill("near_goal");

    if(isDefined(level.n_drone_wave) && level.n_drone_wave == 2) {
      v_forward = vectornormalize(e_target.origin - self.origin);
      v_right = vectorcross(v_forward, (0, 0, 1));
      v_goal = e_target.origin - v_right * randomintrange(8000, 10000) + (0, 0, randomintrange(1500, 2500));
    } else {
      n_height = isDefined(self.n_strafe_height_offset) ? self.n_strafe_height_offset : 1000;
      v_goal = e_target.origin + (randomintrange(-500, 500), randomintrange(-500, 500), n_height + randomintrange(0, 500));
    }

    self thread debug_goal(v_goal);

    self thread strafe_player_plane_fire_guns(randomintrange(0, 100) < 25 ? 0 : b_missiles);
    self setvehgoalpos(v_goal, 0);
    self waittill("near_goal");
    self notify("kill_speed_manager");
    self setspeed(750, 1000, 1000);
    v_goal = isDefined(self.v_escape_vector) ? self.v_escape_vector : undefined;

    if(isDefined(v_goal)) {
      self setvehgoalpos(v_goal, 0);
      self waittill("near_goal");
    }
  }

  self ent_flag_clear("straffing");
}

debug_goal(v_goal) {
  self endon("goal");
  self endon("near_goal");

  while(true) {
    debugstar(v_goal, 1, (1, 0, 0));
    wait 0.05;
  }

}

strafe_player_plane_fire_guns(b_missles) {
  self endon("death");
  self endon("_strafe_player_");
  level endon("sam_cougar_mount_started");

  if(!isDefined(b_missles))
    b_missles = 1;

  wait(randomfloatrange(1, 2));

  if(self.health > 0) {
    self set_turret_target(level.player, (randomintrange(-60, 60), randomintrange(-60, 60), 0), 0);
    self thread fire_turret_for_time(7, 0);

    if(b_missles) {
      wait(randomfloatrange(1, 2));
      level notify("drone_wave_" + level.n_drone_wave);
      yaw = angleclamp180(vectortoangles(vectornormalize(self.origin - level.player.origin))[1]);
      yaw = yaw + randomintrange(-3, 3);
      shoot_point = level.player.origin + anglestoforward((0, yaw, 0)) * randomintrange(50, 100);
      self settargetorigin(shoot_point, 0);
      self firegunnerweapon(0);
    }
  }
}

drone_speed_manager() {
  self endon("death");
  self endon("kill_speed_manager");

  while(true) {
    n_dist = distance(self.origin, level.player.origin);

    if(n_dist > 15000) {
      n_dist_normalized = min(n_dist / 20000, 1.0);
      n_speed = lerpfloat(500, 750, n_dist_normalized);
      self setspeed(n_speed, 1000);
    } else
      self setspeed(500, 1000, 1000);

    wait 0.05;
  }
}

sam_visionset() {
  self endon("death");

  while(true) {
    self waittill("missileTurret_on");
    clientnotify("sam_on");
    battlechatter_off("allies");
    battlechatter_off("axis");
    visionset = self getvisionsetnaked();
    self visionsetnaked("sam_turret", 0.5);
    cin_id = start3dcinematic("sam_gizmos_v2", 1, 1);
    self waittill("missileTurret_off");
    clientnotify("sam_off");
    stop3dcinematic(cin_id);
    battlechatter_on("allies");
    battlechatter_on("axis");
    self visionsetnaked(visionset, 0);
  }
}

sam_hint() {
  level endon("sam_event_done");
  screen_message_create(&"LA_1_SAM_HINT_ADS", & "LA_1_SAM_HINT_FIRE");
  level waittill("sam_hint_drone_killed");
  screen_message_delete();
}

sam_cougar_player_damage_watcher() {
  self endon("death");
  self endon("exit_vehicle");

  while(true) {
    self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weaponname);
    self cleardamageindicator();
    playsoundatposition("evt_turret_shake", (0, 0, 0));
  }
}

scale_model_lods(n_lod_scale_rigid, n_lod_scale_skinned) {
  assert(isDefined(n_lod_scale_rigid), "n_lod_scale_rigid is a required parameter for scale_model_LODs!");
  assert(isDefined(n_lod_scale_skinned), "n_lod_scale_skinned is a required parameter for scale_model_LODs!");
  level.player setclientdvar("r_lodScaleRigid", n_lod_scale_rigid);
  level.player setclientdvar("r_lodScaleSkinned", n_lod_scale_skinned);
}

vtol_hover_notetrack(veh_vtol) {
  veh_vtol notify("hover");
}

vtol_fly_notetrack(veh_vtol) {
  veh_vtol notify("fly");
}

dont_free_vehicle() {
  self.dontfreeme = 1;
}

manage_vehicles_low_road() {
  self endon("death");
  self.overridevehicledamage = ::vehicles_low_road_damage_override;

  if(isDefined(self.script_string) && self.script_string == "fully_automatic" || self.targetname == "drive_trucks") {
    set_turret_burst_parameters(3, 4.5, 1, 1.5, 1);
    self set_turret_target(level.player, undefined, 1);
    self set_turret_ignore_line_of_sight(1, 1);
  } else
    set_turret_burst_parameters(2, 3.5, 2, 2.2, 1);

  flag_wait("player_in_cougar");
  set_turret_ignore_line_of_sight(1, 1);
}

vehicles_low_road_damage_override(einflictor, eattacker, idamage, idflags, type, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(!isplayer(eattacker))
    idamage = 0;

  return idamage;
}

debug_timer() {
  hud_debug_timer = get_debug_timer();
  hud_debug_timer settimerup(0);
}

get_debug_timer() {
  if(isDefined(level.hud_debug_timer))
    level.hud_debug_timer destroy();

  level.hud_debug_timer = newhudelem();
  level.hud_debug_timer.alignx = "left";
  level.hud_debug_timer.aligny = "bottom";
  level.hud_debug_timer.horzalign = "left";
  level.hud_debug_timer.vertalign = "bottom";
  level.hud_debug_timer.x = 0;
  level.hud_debug_timer.y = 0;
  level.hud_debug_timer.fontscale = 1.0;
  level.hud_debug_timer.color = (0.8, 1.0, 0.8);
  level.hud_debug_timer.font = "objective";
  level.hud_debug_timer.glowcolor = (0.3, 0.6, 0.3);
  level.hud_debug_timer.glowalpha = 1;
  level.hud_debug_timer.foreground = 1;
  level.hud_debug_timer.hidewheninmenu = 1;
  return level.hud_debug_timer;
}

delete_when_not_looking_at() {
  self endon("death");

  while(level.player is_player_looking_at(self.origin, 0.67, 0) || self.drivebysoundtime0 > 0 || self.drivebysoundtime1 > 0)
    wait 0.2;

  if(isDefined(self.classname) && self.classname == "script_vehicle") {
    self.delete_on_death = 1;
    self notify("death");

    if(!isalive(self))
      self delete();
  } else
    self delete();
}

delete_on_goal() {
  self endon("death");
  self waittill("goal");
  self delete();
}

trigger_timeout(n_time, str_value, str_key, ent) {
  if(!isDefined(str_key))
    str_key = "targetname";

  if(!isDefined(ent))
    ent = get_players()[0];

  trig = getent(str_value, str_key);

  if(isDefined(trig)) {
    trig endon("death");
    trig endon("trigger");
    wait(n_time);
    trig useby(ent);
    level notify(str_value, ent);
  }
}

spawn_func_scripted_flyby() {
  self playrumbleonentity("flyby");
  earthquake(0.2, 3, level.player.origin, 500);
}

set_straffing_drones(str_spawner, str_align_structs, n_height, str_delete_flag, n_wait_min, n_wait_max) {
  level thread _set_straffing_drones_thread(str_spawner, str_align_structs, n_height, str_delete_flag, n_wait_min, n_wait_max);
}

_set_straffing_drones_thread(str_spawner, str_align_structs, n_height, str_delete_flag, n_wait_min, n_wait_max) {
  level notify("set_straffing_drones");
  level endon("set_straffing_drones");

  if(str_spawner == "off") {
    return;
  }
  a_align_structs = get_struct_array(str_align_structs);

  while(true) {
    spawn_straffing_drone(a_align_structs[getarraykeys(a_align_structs)[randomint(getarraykeys(a_align_structs).size)]], n_height, level.player, str_delete_flag, str_spawner);
    wait(randomfloatrange(n_wait_min, n_wait_max));
  }
}

spawn_straffing_drone(s_align, n_height_above_player, e_target, str_delete_flag, str_spawner) {
  if(!isDefined(str_spawner))
    str_spawner = "sam_drone";

  if(cointoss()) {
    angle_offset = 90;
    v_spawn_vector_dir = 1;
  } else {
    angle_offset = -90;
    v_spawn_vector_dir = -1;
  }

  n_spawn_yaw = s_align.angles[1] + angle_offset;
  v_spawn_org = s_align.origin + anglestoforward((0, n_spawn_yaw, 0)) * 5000;
  v_spawn_org = v_spawn_org - anglestoforward((0, s_align.angles[1], 0)) * 15000;
  v_spawn_org = (v_spawn_org[0], v_spawn_org[1], 3000 + randomint(2000));
  veh_drone = spawn_vehicle_from_targetname(str_spawner);
  veh_drone.origin = v_spawn_org;
  v_goal_org = s_align.origin + anglestoforward((0, n_spawn_yaw, 0)) * 5000;
  v_goal_org = v_goal_org + anglestoforward((0, s_align.angles[1], 0)) * 10000;
  v_goal_org = (v_goal_org[0], v_goal_org[1], 3000 + randomint(2000));
  veh_drone.v_spawn_vector = v_goal_org;
  v_start_angles = vectortoangles(veh_drone.v_spawn_vector - veh_drone.origin);
  veh_drone setphysangles(v_start_angles);
  veh_drone thread straffing_drone(n_height_above_player, e_target, str_delete_flag);
  return veh_drone;
}

straffing_drone(n_height_above_player, e_target, str_delete_flag) {
  self endon("death");
  self thread fall_out_of_world();

  if(isDefined(str_delete_flag))
    self thread delete_vehicle_on_flag(str_delete_flag);

  self setdefaultpitch(10);
  self setforcenocull();
  self setneargoalnotifydist(500);
  self ent_flag_init("straffing");

  while(true) {
    self setvehgoalpos(self.v_spawn_vector, 0);
    self waittill("near_goal");

    if(!(isDefined(level.disable_straffing_drone_shooting) && level.disable_straffing_drone_shooting) && cointoss()) {
      self set_turret_burst_parameters(0.5, 2, 0.1, 0.5, 0);

      if(isDefined(e_target))
        self thread shoot_turret_at_target(e_target, 3, (randomintrange(-200, 200), randomintrange(-200, 200), randomintrange(-200, 200)), 0);
      else
        self enable_turret(0);

      if(isDefined(level.enable_straffing_drone_missiles) && level.enable_straffing_drone_missiles) {
        self thread shoot_turret_at_target(e_target, 3, undefined, 1);
        self thread shoot_turret_at_target(e_target, 3, undefined, 2);
      }
    }

    goal = level.player.origin + (0, 0, n_height_above_player);
    self setvehgoalpos(goal, 0);
    self waittill("near_goal");

    if(!isDefined(self.b_delete_when_not_looking_at)) {
      self thread delete_when_not_looking_at();
      self.b_delete_when_not_looking_at = 1;
    }
  }
}

fall_out_of_world() {
  self endon("death");

  while(self.origin[2] > -5000)
    wait 0.05;

  self delete();
}

spawn_ambient_drones(trig_name, kill_trig_name, str_targetname, str_targetname_allies, path_start, n_count_axis, n_count_allies, min_interval, max_interval, speed, delay, b_move_path) {
  if(!isDefined(speed))
    speed = 400;

  if(!isDefined(delay))
    delay = 0;

  if(!isDefined(b_move_path))
    b_move_path = 0;

  level endon("end_ambient_drones");
  level endon("end_ambient_drones_" + path_start);

  if(isDefined(kill_trig_name))
    level thread ambient_drones_kill_trig_watcher(kill_trig_name, path_start);

  if(isDefined(trig_name))
    trigger_wait(trig_name, "targetname");

  drones = [];
  vehicles = getvehiclearray();
  total = n_count_axis + n_count_allies;

  while(vehicles.size + total > 60) {
    wait 0.05;
    vehicles = getvehiclearray();
  }

  if(delay > 0)
    wait(delay);

  nd_path = getvehiclenode(path_start, "targetname");

  while(true) {
    while(isDefined(level.pause_ambient_drones) && level.pause_ambient_drones)
      wait 0.05;

    for(i = 0; i < n_count_axis; i++) {
      vh_plane = maps\_vehicle::spawn_vehicle_from_targetname(str_targetname);
      vh_plane setspeedimmediate(speed, 300);
      vh_plane thread delete_me();
      vh_plane setforcenocull();
      vh_plane thread ambient_drone_die();
      vh_plane pathfixedoffset((randomintrange(-1000, 1000), randomintrange(-1000, 1000), randomintrange(-500, 500)));
      vh_plane pathvariableoffset(vectorscale((1, 1, 1), 500.0), randomfloatrange(1, 2));
      vh_plane thread go_path(nd_path);
      vh_plane thread play_fake_flyby();
      vh_plane veh_toggle_tread_fx(0);
      vh_plane.b_is_ambient = 1;
      drones[drones.size] = vh_plane;

      if(b_move_path)
        vh_plane pathmove(nd_path, level.player.origin + vectorscale((0, 0, 1), 2000.0), level.player.angles);

      wait 0.25;
    }

    for(i = 0; i < n_count_allies; i++) {
      vh_plane = maps\_vehicle::spawn_vehicle_from_targetname(str_targetname_allies);
      vh_plane setspeedimmediate(speed, 300);
      vh_plane.drone_targets = drones;
      vh_plane thread ambient_allies_weapons_think(0);
      vh_plane thread delete_me();
      vh_plane setforcenocull();
      vh_plane pathfixedoffset((randomintrange(-2000, 0), randomintrange(-1000, 1000), randomintrange(-500, 500)));
      vh_plane pathvariableoffset(vectorscale((1, 1, 1), 500.0), randomfloatrange(1, 2));
      vh_plane thread go_path(nd_path);
      vh_plane veh_toggle_tread_fx(0);
      vh_plane.b_is_ambient = 1;

      if(b_move_path)
        vh_plane pathmove(nd_path, level.player.origin + vectorscale((0, 0, 1), 2000.0), level.player.angles);

      wait 0.1;
    }

    wait(randomfloatrange(min_interval, max_interval));
  }
}

play_fake_flyby() {
  wait 0.1;
  sound_ent = spawn("script_origin", self.origin);
  sound_ent linkto(self, "tag_origin");
  wait(randomfloatrange(1, 3));
  sound_ent playsound("evt_fake_flyby");
  self waittill("reached_end_node");
  sound_ent delete();
}

ambient_drones_kill_trig_watcher(trig_name, kill_name) {
  trigger_wait(trig_name, "targetname");
  level notify("end_ambient_drones_" + kill_name);
}

delete_me() {
  self waittill("reached_end_node");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

ambient_drone_die() {
  self waittill("death");
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.delete_on_death) && isDefined(level._effect["fireball_trail_lg"])) {
    playfxontag(level._effect["fireball_trail_lg"], self, "tag_origin");
    playsoundatposition("evt_pegasus_explo", self.origin);
    wait 5;

    if(isDefined(self))
      self delete();
  } else {
    wait 30;

    if(isDefined(self))
      self delete();
  }
}

ambient_allies_weapons_think(n_missile_pct) {
  self endon("death");

  while(true) {
    target = undefined;

    if(isDefined(self.drone_targets) && self.drone_targets.size > 0) {
      target = random(self.drone_targets);

      if(isDefined(target)) {
        self maps\_turret::set_turret_target(target, (0, 0, 0), 1);
        self maps\_turret::set_turret_target(target, (0, 0, 0), 2);
        self thread maps\_turret::fire_turret_for_time(randomfloatrange(3, 5), 1);
        self thread maps\_turret::fire_turret_for_time(randomfloatrange(3, 5), 2);
      }
    }

    if(!isDefined(target))
      wait 0.05;
    else
      wait(randomfloatrange(4, 6));
  }
}

play_pip(str_bik_name) {
  maps\_glasses::play_bink_on_hud(str_bik_name, 0, 1);
}

link_model_to_tag(str_model, str_tag) {
  m_model = spawn_model(str_model);
  m_model linkto(self, str_tag, (0, 0, 0), (0, 0, 0));
}

#using_animtree("vehicles");

open_suv_doors() {
  self useanimtree(#animtree);
  self setanimknoball( % veh_anim_suv_doors_open, % root, 1, 0, 1);
}

data_glove_on(m_player_body, datapad_model) {
  if(level.script == "la_1b")
    datapad_model = "c_usa_cia_frnd_viewbody_vson";
  else
    datapad_model = "c_usa_cia_masonjr_viewbody_vson";

  m_player_body attach(datapad_model, "J_WristTwist_LE");
  wait 0.05;
  m_player_body detach(datapad_model, "J_WristTwist_LE");
  wait 0.05;
  m_player_body attach(datapad_model, "J_WristTwist_LE");
  wait 0.05;
  m_player_body detach(datapad_model, "J_WristTwist_LE");
  wait 0.05;
  m_player_body attach(datapad_model, "J_WristTwist_LE");
  m_player_body setclientflag(2);

  if(level.script != "la_1b")
    m_player_body play_fx("data_glove_glow", undefined, undefined, undefined, 1, "J_WristTwist_LE");
}

vo_callouts_intro(ai_noteworthy, str_calling_team, a_vo_lines) {
  if(isDefined(ai_noteworthy))
    s_func = new_func(::filter_vo_callout_ai, ai_noteworthy);

  foreach(str_line in a_vo_lines) {
    level queue_dialog(str_line, 0, undefined, undefined, 1, 0, str_calling_team, s_func);
    wait(randomfloatrange(0.25, 1.0));
  }
}

vo_callouts(ai_noteworthy, str_calling_team, a_vo_callouts, str_flag_ender, str_flag_ender_2, n_min_wait, n_max_wait) {
  if(!isDefined(str_flag_ender_2))
    str_flag_ender_2 = "end_vo_callouts";

  if(!isDefined(n_min_wait))
    n_min_wait = 2.0;

  if(!isDefined(n_max_wait))
    n_max_wait = 3.0;

  level endon(str_flag_ender);
  level endon(str_flag_ender_2);

  if(isDefined(ai_noteworthy) && ai_noteworthy != "player")
    s_func = new_func(::filter_vo_callout_ai, ai_noteworthy);

  a_keys = getarraykeys(a_vo_callouts);
  a_keys = array_randomize(a_keys);

  foreach(str_key in a_keys) {
    str_line = undefined;

    if(str_calling_team == "allies") {
      if(str_key == "generic" || is_node_group_used("node_" + str_key, "script_noteworthy", "axis"))
        str_line = array_randomize(a_vo_callouts[str_key])[0];
    } else if(str_key == "generic" || is_player_touching_volume("volume_" + str_key, "script_noteworthy"))
      str_line = array_randomize(a_vo_callouts[str_key])[0];

    if(isDefined(str_line)) {
      if(!isDefined(ai_noteworthy) && !isDefined("player") || isDefined(ai_noteworthy) && isDefined("player") && ai_noteworthy == "player")
        level.player queue_dialog(str_line);
      else
        level queue_dialog(str_line, 0, undefined, undefined, 1, 0, str_calling_team, s_func);

      wait(randomfloatrange(n_min_wait, n_max_wait));
      continue;
    }

    wait 1;
  }
}

filter_vo_callout_ai(ai_noteworthy) {
  if(!isDefined(self.script_noteworthy) && !isDefined(ai_noteworthy) || isDefined(self.script_noteworthy) && isDefined(ai_noteworthy) && self.script_noteworthy == ai_noteworthy)
    return true;

  return false;
}

is_node_group_used(str_node_value, str_node_key, str_team) {
  a_nodes = getnodearray(str_node_value, str_node_key);

  foreach(nd_node in a_nodes) {
    ai_guy = getnodeowner(nd_node);

    if(isDefined(ai_guy) && ai_guy.team == str_team)
      return true;
  }

  return false;
}

is_player_touching_volume(str_volume_value, str_volume_key) {
  a_volumes = getentarray(str_volume_value, str_volume_key);

  foreach(t_volume in a_volumes) {
    if(level.player istouching(t_volume))
      return true;
  }

  return false;
}

ignore_vo_notetracks(ent) {
  ent.ignore_vo_notetracks = 1;
}

hide_player_ropes() {
  flag_wait_any("intro_player_noharper_started", "intro_player_started");

  if(flag("harper_dead"))
    e_body = get_model_or_models_from_scene("intro_player_noharper", "player_body");
  else
    e_body = get_model_or_models_from_scene("intro_player", "player_body");

  for(i = 1; i < 9; i++)
    e_body hidepart("jnt_rope_0" + i);

  e_body hidepart("jnt_hook");
  e_body hidepart("J_Snpr_Cbnr");
  e_body hidepart("J_Snpr_CbnrOpen");
  e_body hidepart("J_Snpr_Knot");

  for(i = 1; i < 4; i++)
    e_body hidepart("J_Snpr_RopeShort_0" + i);

  for(i = 1; i < 10; i++)
    e_body hidepart("J_Snpr_Rope_0" + i);

  for(i = 0; i < 3; i++)
    e_body hidepart("J_Snpr_Rope_1" + i);
}

mission_fail(str_dead_quote_ref) {
  setdvar("ui_deadquote", str_dead_quote_ref);
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
}