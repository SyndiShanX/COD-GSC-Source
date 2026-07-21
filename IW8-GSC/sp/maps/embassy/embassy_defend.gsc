/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\embassy\embassy_defend.gsc
***********************************************/

embassy_defend_precache() {
  setsaveddvar("NLRRTORQPN", 5);
  setDvar("VehicleContinuesOnDriverDeath", 1);
  level.first_roof_struct = spawnStruct();
  level.first_roof_struct.origin = (-38, -599, 150);
  level.second_roof_struct = spawnStruct();
  level.second_roof_struct.origin = (149, -808, 150);
  level.front_goal_vol = getEnt("front_1", "targetname");
  level.roof_objective_struct = spawnStruct();
  level.roof_objective_struct.origin = (-18, -871, 210);
  level.flare_objective_struct = spawnStruct();
  level.flare_objective_struct.origin = (-20, -700, 200);
  level.flare_light = getEnt("flare_fx_light", "targetname");
  level.flare_light_up = getEnt("flare_fx_light_up", "targetname");
  level.flare_light.og_angles = level.flare_light.angles;
  level.flare_light setlightintensity(0);
  level.flare_light_up setlightintensity(0);
  level.flare_light.intensity = undefined;
  level.rocket_tag = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  level.rocket_func = ::scaffolding_rocket_watcher;
  level.beam_nag_lines = [];
  level.beam_nag_lines[level.beam_nag_lines.size] = ["UAV Pilot", "The drone is reloading."];
  level.beam_nag_lines[level.beam_nag_lines.size] = ["UAV Pilot", "The drone is almost reloaded."];
  level.player_dialogue_struct = spawnStruct();
  level.player_dialogue_struct.name = "Kyle";
  level.baseplate_dialogue_struct = spawnStruct();
  level.baseplate_dialogue_struct.name = "Baseplate";
  level.flare_counter = 4;
  var_0 = getEnt("mortar_house_blue_gate_clip", "targetname");
  var_0 connectpaths();
  var_1 = getEnt("mortar_anim_truck_01", "targetname");
  var_1 hide();
  var_2 = getEnt("mortar_anim_truck_02", "targetname");
  var_2 hide();
  var_3 = getEnt("mortar_anim_truck_03", "targetname");
  var_3 hide();
  var_4 = getEntArray("damaged_residence", "targetname");
  scripts\engine\utility::array_call(var_4, ::hide);
  var_5 = getEnt("emb_palm_01_clip_fallen", "targetname");
  var_5 connectpaths();
  var_5 hide();
  scripts\engine\utility::trigger_off("emb_palm_01_trigger", "targetname");
  level.civ_car_death_spot = (0, 0, 0);
  var_6 = getEnt("emb_palm_02_clip_fallen", "targetname");
  var_6 connectpaths();
  var_6 hide();
  scripts\engine\utility::trigger_off("emb_palm_02_trigger", "targetname");
  var_7 = getEnt("scaffolding_a_clip", "targetname");
  var_7 connectpaths();
  var_8 = getEnt("scaffolding_b_clip", "targetname");
  var_8 connectpaths();
  var_9 = getEnt("scaffolding_c_clip", "targetname");
  var_9 connectpaths();
  var_10 = getEnt("flare_mortar_tube_enemy", "targetname");
  var_10.shell = "j_mortar_shell";
  var_11 = getEntArray("building_rails", "targetname");
  scripts\engine\utility::array_call(var_11, ::notsolid);
  scripts\engine\sp\utility::add_hint_string("sniper_rifle_check", &"EMBASSY/SCOPED_WEAPON", scripts\sp\maps\embassy\embassy_util.gsc::scope_swap_hint_check);
  scripts\engine\sp\utility::add_hint_string("green_beam_check", &"EMBASSY/CHANGE_WEAPON", scripts\sp\maps\embassy\embassy_util.gsc::green_beam_swap_hint_check);
  var_12 = (-213, -2463, 2300);
  thread scripts\sp\equipment\green_beam::laser_init(var_12, 4, "drone_instructions", "mortar_house_perimeter");
  precachemodel("veh8_civ_lnd_walfa_yellow");
  precachemodel("veh8_civ_lnd_walfa_black");
  thread embassy_defend_precache_delay();
}

embassy_defend_precache_delay() {
  var_0 = getEntArray("middle_cars", "targetname");
  scripts\engine\utility::array_call(var_0, ::hide);
  wait 0.3;
  var_1 = getEntArray("residence_loot", "targetname");
  scripts\engine\utility::array_call(var_1, ::hide);
  var_2 = getEntArray("triage_loot", "targetname");
  scripts\engine\utility::array_call(var_2, ::hide);
  var_3 = getEntArray("triage_loot_roof", "targetname");
  scripts\engine\utility::array_call(var_3, ::hide);
}

embassy_defend_fx() {}

embassy_defend_flags() {
  scripts\engine\utility::flag_init("civ_car_death");
  scripts\engine\utility::flag_init("inside_residence");
  scripts\engine\utility::flag_init("defend_entrance_door_closed");
  scripts\engine\utility::flag_init("res_inside_armory");
  scripts\engine\utility::flag_init("wolf_dropped_off");
  scripts\engine\utility::flag_init("allies_at_res_exit");
  scripts\engine\utility::flag_init("reached_approach");
  scripts\engine\utility::flag_init("defend_exit_door_open");
  scripts\engine\utility::flag_init("pre_defend_done");
  scripts\engine\utility::flag_init("outside_courtyard");
  scripts\engine\utility::flag_init("rooftops_approach");
  scripts\engine\utility::flag_init("wave_0_start_distant_threat");
  scripts\engine\utility::flag_init("distant_threat_complete");
  scripts\engine\utility::flag_init("table_civs_spooked");
  scripts\engine\utility::flag_init("player_shoots_at_civs");
  scripts\engine\utility::flag_init("mortar_end");
  scripts\engine\utility::flag_init("mortar_launched");
  scripts\engine\utility::flag_init("enemy_mortar_launched");
  scripts\engine\utility::flag_init("civ_life_start");
  scripts\engine\utility::flag_init("civ_spotters_start");
  scripts\engine\utility::flag_init("firing_down_field");
  scripts\engine\utility::flag_init("intro_skipped");
  scripts\engine\utility::flag_init("wave_0_start");
  scripts\engine\utility::flag_init("spawning_unknowns");
  scripts\engine\utility::flag_init("spawning_unknowns_01");
  scripts\engine\utility::flag_init("spawning_distant_threat_right_side");
  scripts\engine\utility::flag_init("spawning_distant_threat_left_side");
  scripts\engine\utility::flag_init("wave_1_start");
  scripts\engine\utility::flag_init("flare_2_skipped");
  scripts\engine\utility::flag_init("wave_1_attack");
  scripts\engine\utility::flag_init("wave_1_vo_skipped");
  scripts\engine\utility::flag_init("wave_1_vo_finished");
  scripts\engine\utility::flag_init("wave_1_shoot_out_lights");
  scripts\engine\utility::flag_init("east_gate_down");
  scripts\engine\utility::flag_init("perimeter_destroyed");
  scripts\engine\utility::flag_init("ally_drag_start");
  scripts\engine\utility::flag_init("roof_compromised");
  scripts\engine\utility::flag_init("mortar_vo_loop");
  scripts\engine\utility::flag_init("player_looking_at_buildings");
  scripts\engine\utility::flag_init("front_1");
  scripts\engine\utility::flag_init("drone_instructions");
  scripts\engine\utility::flag_init("disable_drone_nags");
  scripts\engine\utility::flag_init("front_2");
  scripts\engine\utility::flag_init("front_3");
  scripts\engine\utility::flag_init("wave_1_3_ending");
  scripts\engine\utility::flag_init("enemies_at_the_wall");
  scripts\engine\utility::flag_init("approach_end");
  scripts\engine\utility::flag_init("wave_0_start");
  scripts\engine\utility::flag_init("wave_1_end");
  scripts\engine\utility::flag_init("wave_1_falling_back");
  scripts\engine\utility::flag_init("wave_2_end");
  scripts\engine\utility::flag_init("intro_vo_finished");
  scripts\engine\utility::flag_init("movement_skipped");
  scripts\engine\utility::flag_init("wave_2_trucks_end");
  scripts\engine\utility::flag_init("trucks_stopped");
  scripts\engine\utility::flag_init("player_looking_toward_trucks");
  scripts\engine\utility::flag_init("wave_2_push_inside");
  scripts\engine\utility::flag_init("perimeter_breached");
  scripts\engine\utility::flag_init("sniper_roof_start");
  scripts\engine\utility::flag_init("wave_3_end");
  scripts\engine\utility::flag_init("wave_3_mid_end");
  scripts\engine\utility::flag_init("triage_idle");
  scripts\engine\utility::flag_init("cleanup_triage_room");
  scripts\engine\utility::flag_init("ladder_up");
  scripts\engine\utility::flag_init("drag_scene_complete");
  scripts\engine\utility::flag_init("triage_start");
  scripts\engine\utility::flag_init("triage_scene_started");
  scripts\engine\utility::flag_init("triage_watcher_start");
  scripts\engine\utility::flag_init("street_guys_run");
  scripts\engine\utility::flag_init("wave_4_technicals");
  scripts\engine\utility::flag_init("wave_4_final_technical_spawn");
  scripts\engine\utility::flag_init("wave_4_end");
  scripts\engine\utility::flag_init("player_pushing_house");
  scripts\engine\utility::flag_init("wave_5_end");
  scripts\engine\utility::flag_init("boost_started");
  scripts\engine\utility::flag_init("house_gate_interacted");
  scripts\engine\utility::flag_init("wave_5_house_end");
  scripts\engine\utility::flag_init("mortar_run_started");
  scripts\engine\utility::flag_init("wave_6_end");
  scripts\engine\utility::flag_init("beam_technical_guys_killed");
  scripts\engine\utility::flag_init("mortar_house_field_path");
  scripts\engine\utility::flag_init("wave_3_mortars_roof_targeted");
  scripts\engine\utility::flag_init("green_beam_acquired");
  scripts\engine\utility::flag_init("player_leaving_mortar_house");
  scripts\engine\utility::flag_init("residence_return");
  scripts\engine\utility::flag_init("targeting_laser_acquired");
  scripts\engine\utility::flag_init("venom_first_attack");
  scripts\engine\utility::flag_init("fire_rocket_at_technical");
  scripts\engine\utility::flag_init("east_gate_destroyed");
  scripts\engine\utility::flag_init("enemy_mortar_manned");
  scripts\engine\utility::flag_init("enable_ilumination_flares");
  scripts\engine\utility::flag_init("player_flaring");
  scripts\engine\utility::flag_init("flares_out");
  scripts\engine\utility::flag_init("enemy_mortar_allow_fire");
  scripts\engine\utility::flag_init("mortar_try_kill_player");
  scripts\engine\utility::flag_init("flare_loop_on");
  scripts\engine\utility::flag_init("flare_north");
  scripts\engine\utility::flag_init("flare_east");
  scripts\engine\utility::flag_init("sfx_crickets");
  scripts\engine\utility::flag_init("stop_player_flare_mortar");
  scripts\engine\utility::flag_init("street_enemies_clear");
  scripts\engine\utility::flag_init("escape_lights");
  scripts\engine\utility::flag_init("residence_destroyed");
  scripts\engine\utility::flag_init("mayhem_done");
  scripts\engine\utility::flag_init("hide_mayhem");
  scripts\engine\utility::flag_init("civ_car_spawn");
  scripts\engine\utility::flag_init("mortar_house_early");
  scripts\engine\utility::flag_init("mortar_team_objective");
  scripts\engine\utility::flag_init("player_on_rooftop");
  scripts\engine\utility::flag_init("player_has_sniper");
  scripts\engine\utility::flag_init("building_combat_objective");
  scripts\engine\utility::flag_init("push_objective");
  scripts\engine\utility::flag_init("price_triage_objective");
  scripts\engine\utility::flag_init("first_flare");
  scripts\engine\utility::flag_init("green_beam_shown");
  scripts\engine\utility::flag_init("obj_escort_wolf_complete");
  scripts\engine\utility::flag_init("residence_arrival_vo_done");
  scripts\engine\utility::flag_init("wave_4_dialogue_complete");
  scripts\engine\utility::flag_init("corner_guys_spawned");
  scripts\engine\utility::flag_init("palm_01_damaged");
  scripts\engine\utility::flag_init("hadir_go_to_wall");
  scripts\engine\utility::flag_init("mortar_guy_breakout_watcher");
  scripts\engine\utility::flag_init("rooftop_enter");
}

residence_arrival_start() {
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_farah();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_alex();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_hadir();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_stacy();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_wolf();
  level.wolf thread scripts\sp\maps\embassy\embassy_util.gsc::wolf_friendly_fire_think();
  var_0 = [level.price, level.farah, level.alex, level.hadir, level.wolf, level.stacy];
  scripts\engine\sp\utility::set_start_location("residence_arrival_start", scripts\engine\utility::array_combine([level.player], var_0));
  level.ap_residence = scripts\engine\utility::getStruct("ap_residence", "targetname");
  level.hadir scripts\engine\sp\utility::place_weapon_on(level.hadir.weapon, "back");
  level.hadir scripts\engine\sp\utility::place_weapon_on(level.hadir.sidearm, "right");

  foreach(var_2 in var_0)
  level.ap_residence thread scripts\common\anim::anim_first_frame_solo(var_2, "res_arrival_scene");

  thread scripts\sp\maps\embassy\embassy_infil.gsc::load_compound_transient();
}

residence_arrival_main() {
  defend_inits();
  var_0 = getEntArray("residence_loot", "targetname");
  scripts\engine\utility::array_call(var_0, ::show);
  scripts\engine\sp\utility::autosave_by_name("residence_arrival");
  var_1 = [level.farah, level.price, level.alex, level.hadir];

  foreach(var_3 in var_1) {
    var_3 clearpath();
    var_3 setgoalpos(var_3.origin);
  }

  setmusicstate("");
  var_5 = getEnt("technical_04_end_nav", "targetname");
  var_5 notsolid();
  var_5 connectpaths();
  var_5 thread residence_arrival_handle_technical_on_door_close();
  thread residence_arrival_side_door("side_door_left");
  thread residence_arrival_side_door("side_door_right");
  thread residence_arrival_facade_doors();
  thread residence_arrival_vo();
  scripts\engine\sp\utility::array_spawn_function_targetname("emb_res_flavor_civs", ::residence_arrival_civs);
  var_6 = scripts\engine\sp\utility::array_spawn_targetname("emb_res_flavor_civs", 1);
  scripts\engine\sp\utility::array_spawn_function_targetname("emb_res_entrance_defender", ::residence_arrival_marines);
  var_7 = scripts\engine\sp\utility::array_spawn_targetname("emb_res_entrance_defender", 1);
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_alex_friendlies();
  scripts\engine\sp\utility::set_start_location("defend_start", [level.fsa_02, level.greeter_marine]);
  thread residence_arrival_player_demeanor();
  thread residence_arrival_vfx_cleanup();
  level.ap_residence.anim_start_delay = 1.0;
  level.ap_residence thread scripts\engine\sp\utility::notify_delay("stop_loop", level.ap_residence.anim_start_delay);

  if(isDefined(level.ap_wolf_escort))
    level.ap_wolf_escort thread scripts\engine\sp\utility::notify_delay("stop_loop", level.ap_residence.anim_start_delay);

  var_8 = getEnt("res_secure_door", "targetname");
  var_8.clip = var_8 scripts\engine\utility::get_target_ent();
  var_8.clip linkTo(var_8);
  var_8 scripts\engine\sp\utility::assign_animtree("saferoom_door");
  level.ap_residence scripts\engine\utility::delaythread(level.ap_residence.anim_start_delay, scripts\common\anim::anim_single_solo, var_8, "res_arrival_scene");
  var_9 = residence_arrival_door_setup("residence_sliding_door_entrance", "residence_sliding_door_entrance_end");
  scripts\engine\utility::delaythread(level.ap_residence.anim_start_delay, ::residence_arrival_door_open, var_9, "inside_residence");
  var_10 = scripts\engine\sp\utility::spawn_targetname("emb_res_entrance_informer", 1);
  var_10.animname = "mar_informer";
  var_11 = scripts\engine\sp\utility::spawn_targetname("emb_res_entrance_greeting", 1);
  var_11.animname = "mar_greeting";
  level.us_soldier_3 = var_11;
  var_12 = [level.stacy, var_10, var_11];
  scripts\engine\utility::array_thread(var_12, ::residence_arrival_only);
  var_13 = [level.price, level.alex, level.hadir, level.farah];
  scripts\engine\utility::array_thread(var_13, ::residence_arrival_and_exit);
  thread residence_arrival_wolf();
  level.ap_residence.arrival_done = var_13.size - 1;
  level.ap_residence.exit_done = var_13.size - 1;
  thread scripts\sp\maps\embassy\embassy_util.gsc::swap_card_reader("residence_card_reader");
  level thread scripts\engine\sp\utility::notify_delay("card_reader_swap", 1.0);
  scripts\sp\utility::notetrack_mission_failed_vo_disable();
  var_14 = scripts\engine\utility::getStruct("ap_res_arrival_plr", "targetname");
  var_14 thread scripts\common\anim::anim_first_frame_solo(level.player.rig, "res_arrival_scene");
  level.player.rig attach(scripts\engine\sp\utility::getmodel("keycard"), "tag_accessory_left");
  thread scripts\sp\maps\embassy\embassy_util.gsc::put_player_into_rig(level.player.rig, 0.5, 0, 0, 0, 0);
  level.player.rig scripts\engine\utility::delaycall(0.05, ::setanimrate, level.player.rig scripts\engine\utility::getanim("res_arrival_scene"), 0.65);
  var_14 scripts\common\anim::anim_single_solo(level.player.rig, "res_arrival_scene");
  level.player.rig detach(scripts\engine\sp\utility::getmodel("keycard"), "tag_accessory_left");
  scripts\sp\maps\embassy\embassy_util.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  scripts\engine\utility::flag_wait("wolf_dropped_off");
  scripts\engine\utility::flag_wait("res_inside_armory");
  level notify("obj_escort_wolf_complete");
  scripts\engine\utility::flag_set("obj_escort_wolf_complete");
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_mortar_friendlies();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_marines_friendlies();
  scripts\engine\utility::flag_wait("residence_arrival_vo_done");
  scripts\engine\utility::flag_wait_all("reached_approach", "allies_at_res_exit");
  var_15 = residence_arrival_door_setup("residence_sliding_door_exit", "residence_sliding_door_exit_end");
  thread residence_arrival_door_open(var_15, "outside_courtyard");
  wait 2.0;
  scripts\sp\utility::notetrack_mission_failed_vo_enable();
  scripts\engine\utility::flag_set("defend_exit_door_open");
  level notify("obj_join_forces_complete");
  thread scripts\sp\analytics::analytics_kleenex_update("Escape to Defend");
}

residence_arrival_vo() {
  level.player endon("death");
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_kyle_alley_compound_70");
  level.us_soldier_3 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us3_residence_arrival_intro_10");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_residence_arrival_intro_20");
  level.us_soldier_3 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us3_residence_arrival_intro_30");
  scripts\engine\utility::flag_wait("wolf_dropped_off");
  var_0 = ["dx_vom_pri_residence_arrival_intro_70", "dx_vom_pri_residence_arrival_intro_80", "dx_vom_pri_residence_arrival_intro_90"];
  level.price scripts\sp\maps\embassy\embassy_util.gsc::nagtill_delayed(8, "res_inside_armory", var_0, 12, 1.2);
  wait 2;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_residence_arrival_exit_30");
  level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_lass_residence_arrival_exit_40");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_residence_arrival_exit_50");
  level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_lass_residence_arrival_exit_60");
  scripts\engine\utility::flag_set("residence_arrival_vo_done");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_residence_arrival_exit_70");
  thread speak_to_stacy();
  wait 15;
  var_0 = ["dx_vom_pri_residence_arrival_exit_80", "dx_vom_pri_residence_arrival_exit_90", "dx_vom_pri_residence_arrival_exit_100"];
  level.price scripts\sp\maps\embassy\embassy_util.gsc::nagtill("reached_approach", var_0, 15);
}

speak_to_stacy() {
  if(isDefined(level.stacy) && isalive(level.stacy)) {
    level.player endon("death");
    level.stacy endon("death");
    level.player scripts\sp\maps\embassy\embassy_util.gsc::wait_lookat(level.stacy, 85, "j_head", 0.3, 100);
    level.stacy scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_stac_residence_arrival_exit_10");
    level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_residence_arrival_exit_20");
  }
}

residence_arrival_player_demeanor() {
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.player scripts\sp\player::player_movement_state("creep");
  scripts\engine\utility::flag_wait("defend_entrance_door_closed");
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  scripts\engine\utility::flag_wait("outside_courtyard");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.player scripts\sp\player::player_movement_state("default");
}

residence_arrival_delete_on_exit_door_close() {
  level scripts\engine\utility::waittill_any("residence_sliding_door_exit_closed", "player_on_rooftop");
  self delete();
}

residence_arrival_handle_technical_on_door_close() {
  level waittill("residence_sliding_door_exit_closed");
  self solid();
  self disconnectPaths();
}

residence_arrival_marines() {
  self endon("entitydeleted");
  thread residence_arrival_delete_on_exit_door_close();
  self.script_pushable = 0;
  self.ap = self.spawner;
  self.animname = "marine";

  if(scripts\engine\utility::is_equal(self.script_namenumber, "crouch"))
    self allowedstances("crouch");
  else {
    scripts\common\utility::demeanor_override("casual_gun");
    scripts\common\ai::set_gunpose("gun_down");
  }

  scripts\sp\names::get_name();
  self setlookattext(self.name, &"");
  var_0 = 150;
  childthread residence_arrival_marines_look_at(var_0);
  var_1 = 0;

  for(;;) {
    var_2 = level.player isfiring() || scripts\sp\maps\embassy\embassy_util.gsc::player_aiming_at_2d(self.origin, 30);
    var_3 = scripts\engine\utility::time_has_passed(var_1, 1.5);

    if(var_2) {
      if(!scripts\engine\utility::is_equal(self.script_namenumber, "crouch")) {
        scripts\common\utility::clear_demeanor_override();
        scripts\common\ai::set_gunpose("disable");
      }

      scripts\common\utility::lookatentity();
      scripts\asm\shared\utility::toggle_poiauto(1);

      while(var_2 || !var_3) {
        if(var_2)
          var_1 = gettime();

        var_3 = scripts\engine\utility::time_has_passed(var_1, 3.0);
        waitframe();
        var_2 = level.player isfiring() || scripts\sp\maps\embassy\embassy_util.gsc::player_aiming_at_2d(self.origin, 30);
      }

      scripts\asm\shared\utility::toggle_poiauto(0);

      if(!scripts\engine\utility::is_equal(self.script_namenumber, "crouch")) {
        scripts\common\utility::demeanor_override("casual_gun");
        scripts\common\ai::set_gunpose("gun_down");
      }

      if(scripts\sp\maps\embassy\embassy_util.gsc::within_distance(level.player.origin, self.origin, var_0))
        scripts\common\utility::lookatentity(level.player, 0);
    }

    waitframe();
  }
}

residence_arrival_marines_look_at(var_0) {
  for(;;) {
    var_1 = scripts\sp\maps\embassy\embassy_util.gsc::within_distance(level.player.origin, self.origin, var_0);

    if(var_1 && !istrue(self.lookingatent))
      scripts\common\utility::lookatentity(level.player, 0);
    else if(!var_1 && istrue(self.lookingatent))
      scripts\common\utility::lookatentity();

    waitframe();
  }
}

residence_arrival_civs() {
  self endon("entitydeleted");
  self.fakeactor_face_anim = 1;

  if(!isDefined(level.dejected_idle_count) || level.dejected_idle_count > 5)
    level.dejected_idle_count = 0;
  else
    level.dejected_idle_count++;

  self.civ_count = level.dejected_idle_count;
  self.animname = "civ";
  thread residence_arrival_delete_on_exit_door_close();
  thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
  self.ap = self.spawner;
  self.last_player_reaction_time = 0;

  for(;;) {
    self.ap thread scripts\common\anim::anim_loop_solo(self, "dejected_idle_" + self.civ_count, "stop_loop");

    while((!scripts\engine\utility::time_has_passed(self.last_player_reaction_time, 3) || !scripts\sp\maps\embassy\embassy_util.gsc::within_distance(level.player.origin, self.origin, 100)) && !level.player isfiring() && !scripts\sp\maps\embassy\embassy_util.gsc::player_aiming_at_2d(self.origin, 30))
      waitframe();

    self.ap notify("stop_loop");

    if(level.player isfiring() || scripts\sp\maps\embassy\embassy_util.gsc::player_aiming_at_2d(self.origin, 30)) {
      self.ap scripts\common\anim::anim_single_solo(self, "dejected_react_ads_enter_" + self.civ_count);
      self.ap thread scripts\common\anim::anim_loop_solo(self, "dejected_react_ads_idle_" + self.civ_count, "stop_loop");

      while(level.player isfiring() | scripts\sp\maps\embassy\embassy_util.gsc::player_aiming_at_2d(self.origin, 30))
        waitframe();

      self.ap notify("stop_loop");
      self.ap scripts\common\anim::anim_single_solo(self, "dejected_react_ads_exit_" + self.civ_count);
      continue;
    }

    self.ap scripts\common\anim::anim_single_solo(self, "dejected_react_plr_" + self.civ_count);
    self.last_player_reaction_time = gettime();
  }
}

residence_arrival_and_exit() {
  wait(level.ap_residence.anim_start_delay);
  level.ap_residence scripts\common\anim::anim_single_solo(self, "res_arrival_scene");
  level.ap_residence thread scripts\common\anim::anim_loop_solo(self, "res_arrival_scene_idle", "stop_loop_" + self.animname);
  thread residence_arrival_done();
  scripts\engine\utility::flag_wait("res_inside_armory");
  var_0 = getEntArray("middle_cars", "targetname");
  scripts\engine\utility::array_call(var_0, ::delete);
  thread unload_embassy_load_anims();
  scripts\engine\utility::flag_wait("wolf_dropped_off");
  level.ap_residence notify("stop_loop_" + self.animname);
  level.ap_residence scripts\common\anim::anim_single_solo(self, "res_room_exit");
  level.ap_residence thread scripts\common\anim::anim_loop_solo(self, "res_room_exit_idle", "stop_loop_" + self.animname);
  thread residence_exit_done();
  scripts\engine\utility::flag_wait("allies_at_res_exit");
  scripts\engine\utility::flag_wait("reached_approach");
  scripts\engine\utility::flag_wait("defend_exit_door_open");
  level.ap_residence notify("stop_loop_" + self.animname);

  if(self == level.hadir)
    level.ap_residence scripts\common\anim::anim_single_solo(self, "res_room_exit_to_defend");
}

residence_arrival_only() {
  thread residence_arrival_delete_on_exit_door_close();
  wait(level.ap_residence.anim_start_delay);
  level.ap_residence scripts\common\anim::anim_single_solo(self, "res_arrival_scene");

  if(self == level.stacy)
    thread residence_arrival_stacy_reactions();
  else
    level.ap_residence thread scripts\common\anim::anim_loop_solo(self, "res_arrival_scene_idle", "stop_loop_" + self.animname);

  thread residence_arrival_done();
}

residence_arrival_stacy_reactions() {
  self endon("death");
  self.last_player_reaction_time = 0;

  for(;;) {
    level.ap_residence thread scripts\common\anim::anim_loop_solo(self, "res_arrival_scene_idle", "stop_loop_" + self.animname);

    while(!scripts\engine\utility::time_has_passed(self.last_player_reaction_time, 3) || !scripts\sp\maps\embassy\embassy_util.gsc::within_distance(level.player.origin, self.origin, 100) && !level.player isfiring() && !scripts\sp\maps\embassy\embassy_util.gsc::player_aiming_at_2d(self.origin, 30))
      waitframe();

    level.ap_residence notify("stop_loop_" + self.animname);

    if(level.player isfiring() || scripts\sp\maps\embassy\embassy_util.gsc::player_aiming_at_2d(self.origin, 30)) {
      level.ap_residence scripts\common\anim::anim_single_solo(self, "res_room_ads_react");
      continue;
    }

    if(scripts\engine\math::is_point_on_right(level.player.origin))
      scripts\common\anim::anim_single_solo(self, "res_room_plr_react_r");
    else
      scripts\common\anim::anim_single_solo(self, "res_room_plr_react_l");

    self.last_player_reaction_time = gettime();
  }
}

residence_arrival_wolf() {
  wait(level.ap_residence.anim_start_delay);
  level.ap_residence scripts\common\anim::anim_single_solo(level.wolf, "res_arrival_scene");

  if(isDefined(level.wolf.handcuffs))
    level.wolf.handcuffs delete();

  level.wolf delete();
  thread residence_arrival_done();
}

residence_arrival_done() {
  level.ap_residence.arrival_done--;

  if(level.ap_residence.arrival_done <= 0)
    scripts\engine\utility::flag_set("wolf_dropped_off");
}

residence_exit_done() {
  level.ap_residence.exit_done--;

  if(level.ap_residence.exit_done <= 0)
    scripts\engine\utility::flag_set("allies_at_res_exit");
}

residence_arrival_vfx_cleanup() {
  level waittill("residence_sliding_door_entrance_closed");
  scripts\engine\utility::stop_exploder("heli_fire");
  scripts\engine\utility::stop_exploder("landing_car_explode");
}

residence_arrival_door_setup(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_2.clip = var_2 scripts\engine\utility::get_target_ent();
  var_2.clip linkTo(var_2);
  var_2.start = var_2.origin;
  var_2.end = scripts\engine\utility::getStruct(var_1, "targetname").origin;
  return var_2;
}

residence_arrival_door_open(var_0, var_1) {
  var_0 thread audio_residence_door_open();
  var_0.clip connectpaths();
  var_0 moveTo(var_0.end, 4.0, 0.25, 0.25);
  wait 4.0;
  var_0.total_dist = distance(var_0.start, var_0.end);
  var_0.curr_dist = distance(var_0.origin, var_0.start);
  var_0.move_pct = var_0.curr_dist / var_0.total_dist;
  var_0 thread residence_arrival_door_pauser(var_1);

  while(var_0.move_pct > 0.01 && !scripts\engine\utility::flag("player_on_rooftop")) {
    var_0.curr_dist = distance(var_0.origin, var_0.start);
    var_0.move_pct = var_0.curr_dist / var_0.total_dist;
    waitframe();
  }

  var_0.origin = var_0.start;
  var_0.clip disconnectPaths();
  level notify("audio_door_is_closed");
  self notify("closed");
  level notify(var_0.targetname + "_closed");

  if(var_0.targetname == "residence_sliding_door_entrance") {
    scripts\engine\utility::flag_set("defend_entrance_door_closed");

    if(isDefined(level.sr_exit_door)) {
      level.sr_exit_door delete();
      level.sr_exit_door = undefined;
    }

    if(isDefined(level.sr_entrance_door)) {
      level.sr_entrance_door delete();
      level.sr_entrance_door = undefined;
    }
  } else
    var_0 thread residence_arrival_door_delete();
}

residence_arrival_door_delete() {
  scripts\engine\utility::flag_wait("wave_5_house_end");
  self.clip connectpaths();
  self.clip delete();
  self delete();
}

audio_residence_door_open() {
  self playSound("emb_residence_door_roll_open_start");
  self playLoopSound("emb_residence_door_roll_open_lp");
  wait 4.0;
  self playSound("emb_residence_door_roll_open_stop");
  wait 0.25;
  self stoploopsound();
}

audio_residence_door_close() {
  self playSound("emb_residence_door_roll_closed_start");
  self playLoopSound("emb_residence_door_roll_closed_lp");
  level waittill("audio_door_is_closed");
  self playSound("emb_residence_door_roll_closed_stop");
  wait 0.25;
  self stoploopsound();
}

residence_arrival_door_pauser(var_0) {
  self endon("closed");
  self endon("entitydeleted");

  for(;;) {
    scripts\engine\utility::flag_wait(var_0);
    thread audio_residence_door_close();
    self moveTo(self.start, self.move_pct * 10.0, 0.25 * self.move_pct, 0.25 * self.move_pct);
    scripts\engine\utility::flag_waitopen(var_0);
    var_1 = 1 - self.move_pct;
    self moveTo(self.end, var_1 * 10.0, 0.25 * var_1, 0.25 * var_1);
  }
}

residence_arrival_side_door(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1.closed = spawnStruct();
  var_1.closed.origin = var_1.origin;
  var_1.closed.angles = var_1.angles;
  var_1.open = scripts\engine\utility::getStruct(var_0 + "_open", "targetname");
  var_1.clip = var_1 scripts\engine\utility::get_target_ent();
  var_1.clip linkTo(var_1);
  var_1.origin = var_1.open.origin;
  var_1.angles = var_1.open.angles;
  level waittill("residence_sliding_door_exit_closed");
  var_1.origin = var_1.closed.origin;
  var_1.angles = var_1.closed.angles;
  self notify("closed");
}

residence_arrival_facade_doors() {
  var_0 = getEntArray("res_facade_door", "targetname");

  foreach(var_2 in var_0)
  var_2.open = scripts\engine\utility::getStruct(var_2.target, "targetname");

  wait 10.0;

  foreach(var_2 in var_0)
  var_2 moveTo(var_2.open.origin, 6);
}

residence_arrival_catchup() {
  scripts\engine\utility::flag_set("obj_escort_wolf_complete");
  thread residence_arrival_facade_doors_catchup();
  var_0 = residence_arrival_door_setup("residence_sliding_door_exit", "residence_sliding_door_exit_end");
  var_0 thread residence_arrival_door_delete();
}

residence_arrival_facade_doors_catchup() {
  var_0 = getEntArray("res_facade_door", "targetname");

  foreach(var_2 in var_0) {
    var_2.open = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_2.origin = var_2.open.origin;
  }
}

defend_approach_start() {
  squad_init();
  defend_inits();
  scripts\engine\sp\utility::set_start_location("roof_approach_start", [level.player, level.price, level.farah, level.alex, level.hadir]);
  thread sfx_spawn_crickets();
  scripts\engine\sp\utility::set_start_location("defend_start", [level.ally_01_mortar, level.ally_02_mortar, level.ally_03, level.ally_04, level.greeter_marine, level.fsa_02]);
}

defend_approach_main() {
  var_0 = getEnt("player_mortar_clip", "targetname");
  var_0 notsolid();
  thread defend_approach_hadir_to_roof();
  scripts\engine\sp\utility::set_start_location("defend_start", [level.ally_03, level.ally_04]);
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  scripts\engine\sp\utility::autosave_by_name("approach");
  scripts\engine\utility::flag_set("rooftops_approach");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.price scripts\common\utility::demeanor_override("combat");
  thread rooftop_touch_trigger();
  thread heading_to_rooftop_check();
  thread illumination_mortars_init();
  thread dialogue_rooftops_approach();
  thread distant_civs();
  thread player_weaponfire_watcher();
  thread objective_manager_defend();
  thread mus_intro_walkntalk();
  thread scene_intro_to_rooftops();
  thread wrong_rooftop_nag();
  scripts\engine\utility::flag_wait("intro_vo_finished");
}

scriptable_field_lights_swap() {
  wait 0.3;
  var_0 = getscriptablearray("field_light_pole", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2.dummy = spawn("script_model", var_2.origin);
    var_2.dummy setModel(var_2.model);
    var_2.dummy.angles = var_2.angles;
    var_2.og_origin = var_2.origin;
    var_2.origin = var_2.origin + (0, 0, -1000);
  }
}

rooftop_touch_trigger() {
  scripts\engine\sp\utility::trigger_wait("roof_mortar_trigger", "targetname");
  scripts\engine\utility::flag_set("player_on_rooftop");
}

heading_to_rooftop_check() {
  var_0 = [level.price, level.alex];
  var_1 = 350;

  while(!scripts\engine\utility::flag("player_on_rooftop")) {
    if(var_1 < distance2d(level.player.origin, level.price.origin)) {
      level.player thread scripts\sp\player::focus_display_hint(undefined, 8);
      wait 18;
      var_1 = 700;
    }

    waitframe();
  }
}

defend_approach_hadir_to_roof() {
  level.hadir scripts\engine\sp\utility::set_goal_radius(64);
  level.hadir scripts\engine\sp\utility::set_goal_pos((-700.2, 719.8, 26));
  level.hadir waittill("goal");
  level.hadir scripts\engine\sp\utility::set_force_color("b");
}

mus_intro_walkntalk() {
  wait 3;
  setmusicstate("mx_embassy_walkntalk_intro");
  wait 50.615;
  setmusicstate("mx_embassy_walkntalk");
  scripts\engine\utility::flag_wait("player_flaring");
  setmusicstate("");
}

back_on_roof_nag() {
  if(scripts\engine\utility::flag("wave_1_falling_back")) {
    return;
  }
  level endon("wave_1_falling_back");
  var_0 = ["dx_vom_pri_defend_nags_10", "dx_vom_pri_defend_nags_20", "dx_vom_pri_defend_nags_30"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  init_building_flags();

  for(;;) {
    scripts\sp\maps\embassy\embassy_util.gsc::flag_waitopen_all_array(["player_on_south_building", "player_on_north_building"]);

    while(!level.player isonground())
      waitframe();

    level.price scripts\sp\maps\embassy\embassy_util.gsc::nagtill(["player_on_south_building", "player_on_north_building"], var_1);
  }
}

init_building_flags() {
  var_0 = getEnt("building_a_roof_trigger", "targetname");
  var_1 = getEnt("roof_mortar_trigger", "targetname");

  if(!scripts\engine\utility::flag_exist("player_on_north_building"))
    scripts\engine\sp\utility::flag_trigger_init("player_on_north_building", var_0, 1);

  if(!scripts\engine\utility::flag_exist("player_on_south_building"))
    scripts\engine\sp\utility::flag_trigger_init("player_on_south_building", var_1, 1);

  var_0 scripts\engine\utility::trigger_on();
  var_1 scripts\engine\utility::trigger_on();
}

wrong_rooftop_nag() {
  if(scripts\engine\utility::flag("roof_compromised")) {
    return;
  }
  level endon("roof_compromised");
  var_0 = [];
  var_0[var_0.size] = [level.alex, "dx_vom_alx_defend_intro_100"];
  var_0[var_0.size] = [level.hadir, "dx_vom_had_defend_intro_110"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  init_building_flags();

  for(;;) {
    scripts\engine\utility::flag_wait("player_on_north_building");
    scripts\sp\maps\embassy\embassy_util.gsc::nagtill_open("player_on_north_building", var_1, 6.5, 1.2, 20, 1.5);
  }
}

defend_approach_catchup() {
  scripts\engine\utility::flag_set("approach_end");
  thread objective_manager_defend();

  if(!scripts\sp\starts::is_after_start("trucks"))
    thread wrong_rooftop_nag();
}

defend_wave_0_start() {
  thread illumination_mortars_init();
  squad_init();
  defend_inits();
  scripts\engine\utility::flag_set("intro_skipped");
  scripts\engine\utility::flag_set("intro_vo_finished");
  var_0 = [level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar];
  scripts\engine\sp\utility::set_start_location("defend_start", var_0);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.player, level.ally_03, level.ally_04, level.greeter_marine, level.fsa_02, level.alex, level.hadir]);
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  thread distant_civs();
  var_1 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  scripts\engine\utility::array_thread(var_0, ::scene_intro_to_roof_to_idle, var_1);
  thread sfx_spawn_crickets();
  thread player_weaponfire_watcher();
}

defend_wave_0_main() {
  thread weapon_check();
  scripts\engine\sp\utility::trigger_wait("roof_mortar_trigger", "targetname");
  scripts\engine\utility::flag_set("player_on_rooftop");
  thread sniper_rifle_nag();
  thread scripts\sp\maps\embassy\embassy_util.gsc::focus_reminder("player_has_sniper", 15);
  scripts\engine\utility::flag_wait("player_has_sniper");
  scripts\engine\sp\utility::autosave_by_name("player_has_sniper");
  thread dialogue_rooftops_wave_0();
  var_0 = scripts\engine\utility::getStruct("mortar_wave_3_lookat", "targetname");
  var_1 = 0.996195;
  var_2 = gettime();
  var_3 = 20000;

  for(;;) {
    if(gettime() > var_2 + var_3 || level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_1)) {
      break;
    } else
      wait 0.1;
  }

  scripts\engine\utility::flag_set("civ_life_start");
  scripts\engine\sp\utility::autosave_by_name("civ_life_start");
  distant_threat();
  scripts\engine\utility::flag_wait("wave_1_start");
  wait 3;
}

weapon_check() {
  level.player endon("death");

  if(scripts\engine\utility::flag("civ_life_start")) {
    return;
  }
  level endon("civ_life_start");
  var_0 = 0;

  for(;;) {
    var_1 = level.player getweaponslistprimaries();

    foreach(var_3 in var_1) {
      var_4 = getweaponattachments(var_3);

      if(isDefined(var_4) && var_4.size > 0) {
        foreach(var_6 in var_4) {
          if(issubstr(var_6, "scope"))
            var_0 = 1;

          break;
        }
      }
    }

    if(var_0)
      scripts\engine\utility::flag_set("player_has_sniper");
    else
      scripts\engine\utility::flag_clear("player_has_sniper");

    waitframe();
  }
}

sniper_rifle_nag() {
  level.getsniper_starttime = gettime();
  level endon("player_has_sniper");
  wait 3;

  for(;;) {
    scripts\engine\utility::flag_waitopen("player_has_sniper");
    wait 0.5;
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_roof_65");
    scripts\engine\sp\utility::display_hint("sniper_rifle_check");
    wait 7;
    scripts\engine\utility::flag_waitopen("player_has_sniper");
    wait 0.5;
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_roof_66");
    wait 15;
  }
}

defend_wave_0_catchup() {
  scripts\engine\utility::flag_set("civ_life_start");
  scripts\engine\utility::flag_set("player_on_rooftop");
  scripts\engine\utility::flag_set("player_has_sniper");
  scripts\engine\utility::flag_set("intro_vo_finished");
  scripts\engine\utility::flag_set("wave_1_start");
}

defend_wave_1_start() {
  squad_init();
  defend_inits();
  thread illumination_mortars_init();
  scripts\engine\utility::flag_set("intro_skipped");
  scripts\engine\utility::flag_set("wave_1_vo_skipped");
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("b");
  var_0 = [level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar];
  scripts\engine\sp\utility::set_start_location("roof_approach_start", [level.hadir]);
  scripts\engine\sp\utility::set_start_location("defend_start", var_0);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.player, level.ally_03, level.ally_04, level.greeter_marine, level.fsa_02, level.alex]);
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  var_1 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  thread sfx_spawn_crickets();
}

defend_wave_1_main() {
  thread scripts\sp\maps\embassy\embassy_util.gsc::reactive_foliage_med();
  thread friendlies_scared_of_dark();
  thread wave_1_field_infantry();
  thread wave_1_exploder_manager();
  scripts\engine\utility::flag_wait("wave_1_start");
  thread dialogue_rooftops_wave_1();

  if(!scripts\engine\utility::flag("movement_skipped")) {
    thread shoot_out_field_lights();
    thread shoot_out_perimeter_lights();
  }

  scripts\engine\utility::flag_wait("enable_ilumination_flares");
  level.ally_01_mortar thread scene_flare_react();
  var_0 = [level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar];
  var_1 = getEnt("building_b_roof_cover_volume", "targetname");
  var_2 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  var_2 notify("stop_loop");
  level.farah scripts\engine\sp\utility::clear_force_color();
  level.farah scripts\engine\sp\utility::set_force_color("o");
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("p");
  level.ally_02_mortar scripts\engine\sp\utility::clear_force_color();
  level.ally_02_mortar scripts\engine\sp\utility::set_force_color("g");
  level.ally_01_mortar scripts\engine\sp\utility::clear_force_color();
  level.ally_01_mortar scripts\engine\sp\utility::set_force_color("r");
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  scripts\engine\utility::flag_set("front_1");
  thread scripts\sp\maps\embassy\embassy_util.gsc::focus_reminder("wave_1_attack", 7);
  thread wave_1_autosave_manager();
  scripts\engine\utility::flag_wait("player_flaring");
  scripts\engine\utility::flag_set("first_flare");
  thread back_on_roof_nag();
  thread dialogue_rooftops_wave_1_post_flare();
  var_2 notify("stop_loop_flare_react");
  scripts\engine\utility::flag_wait("wave_1_falling_back");
  thread mus_retreat();
  scripts\engine\utility::flag_wait_all("wave_1_end", "wave_1_vo_finished");
  scripts\engine\sp\utility::autosave_by_name("wave_1_complete");
}

mus_retreat() {
  setmusicstate("mx_embassy_roof_transition");
  scripts\engine\utility::flag_wait("enemy_mortar_allow_fire");
  setmusicstate("");
}

wave_1_exploder_manager() {
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::exploder("wave01");
  scripts\engine\utility::flag_waitopen("flares_out");
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::exploder("wave02");
  scripts\engine\utility::flag_waitopen("flares_out");
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::exploder("wave03");
}

wave_1_autosave_manager() {
  scripts\engine\utility::flag_wait("player_flaring");
  scripts\engine\sp\utility::autosave_by_name("wave_1_begin");
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::flag_waitopen("flares_out");
  scripts\engine\utility::flag_wait("player_flaring");
  scripts\engine\sp\utility::autosave_by_name("wave_1_mid");
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::flag_waitopen("flares_out");
  scripts\engine\utility::flag_wait("player_flaring");
  scripts\engine\sp\utility::autosave_by_name("wave_1_final");
}

distant_civs() {
  level scripts\engine\utility::waittill_any("residence_sliding_door_exit_closed", "player_on_rooftop");
  waitframe();
  thread civs_table();
  thread civs_spotters();
  thread civs_bike();
  thread civs_walkers();
  thread civs_garage_door_guy();
  thread civs_soccer_guys();
  thread civ_vehicles();
}

civ_vehicles() {
  thread civ_life_car_01(1);
  scripts\engine\utility::flag_wait("civ_life_start");
  wait 2;
  thread civ_life_car_00();
  wait 2;
  thread civ_life_car_01(2);
}

civ_life_car_00() {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("civ_veh_spawner_00");
  var_0.maxhealth = 30000;
  var_0.health = 30000;
  var_0.regenerate = 1;
  var_0 scripts\common\vehicle::godon();
  var_0 setModel("veh8_civ_lnd_walfa_yellow");
  level notify("civ_car_spawn");
  var_1 = getspawner("civ_driver_00", "targetname");
  var_1.count = 1;
  var_1 = scripts\engine\sp\utility::spawn_targetname("civ_driver_00", 1);
  var_1.animname = "civ_driver";
  var_1.ignoreme = 1;
  var_1.allowdeath = 1;
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0 gettagorigin("TAG_DRIVER"), var_0 gettagangles("TAG_DRIVER"));
  var_2.origin = var_2.origin + (10, 0, -5);
  var_2 linkTo(var_0, "TAG_DRIVER");
  var_1 linkTo(var_0, "TAG_DRIVER");
  var_2 thread scripts\common\anim::anim_loop_solo(var_1, "driver_idle", "stop_loop");
  var_0 thread vehicle_death_watcher(var_1);
  var_0 thread vehicle_whizby_watcher(var_1, "scn_embassy_civ_car_dist_speed_away_02");
  var_3 = getvehiclenode("civ_veh_start_00", "targetname");
  var_0 scripts\common\vehicle::attach_vehicle_and_gopath(var_3);
  var_0 scripts\common\vehicle::vehicle_lights_on();
  playFXOnTag(scripts\engine\utility::getfx("vfx_embassy_car_headlight_truck_l"), var_0, "tag_light_front_left");
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_embassy_car_headlight_truck_r"), var_0, "tag_light_front_right");
  var_0 vehicle_turnengineoff();
  var_0 playSound("scn_embassy_civ_car_dist_02");
  wait 1;
  var_0 endon("death");

  while(var_0.veh_speed)
    wait 0.1;

  var_2 delete();
  var_1 delete();
  var_0 delete();
}

civ_life_car_01(var_0) {
  var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname("civ_veh_spawner_00");
  var_1.maxhealth = 30000;
  var_1.health = 30000;
  var_1.regenerate = 1;
  var_1 scripts\common\vehicle::godon();
  var_1 setModel("veh8_civ_lnd_walfa_black");
  level notify("civ_car_spawn");
  var_2 = getspawner("civ_driver_00", "targetname");
  var_2.count = 1;
  var_2 = scripts\engine\sp\utility::spawn_targetname("civ_driver_00", 1);
  var_2.animname = "civ_driver";
  var_2.ignoreme = 1;
  var_2.allowdeath = 1;
  var_3 = scripts\engine\utility::spawn_tag_origin(var_1 gettagorigin("TAG_DRIVER"), var_1 gettagangles("TAG_DRIVER"));
  var_3.origin = var_3.origin + (10, 0, -5);
  var_3 linkTo(var_1, "TAG_DRIVER");
  var_2 linkTo(var_1, "TAG_DRIVER");
  var_3 thread scripts\common\anim::anim_loop_solo(var_2, "driver_idle", "stop_loop");
  var_1 thread vehicle_death_watcher(var_2);
  var_1 thread vehicle_whizby_watcher(var_2, "scn_embassy_civ_car_dist_speed_away_01");
  var_4 = getvehiclenode("civ_veh_start_00", "targetname");
  var_1 scripts\common\vehicle::attach_vehicle_and_gopath(var_4);
  var_1 scripts\common\vehicle::vehicle_lights_on();
  playFXOnTag(scripts\engine\utility::getfx("vfx_embassy_car_headlight_truck_l"), var_1, "tag_light_front_left");
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_embassy_car_headlight_truck_r"), var_1, "tag_light_front_right");
  var_1 vehicle_turnengineoff();

  if(var_0 == 1)
    var_1 playSound("scn_embassy_civ_car_dist_01");
  else if(var_0 == 2)
    var_1 playSound("scn_embassy_civ_car_dist_03");

  wait 1;
  var_1 endon("death");

  while(var_1.veh_speed)
    wait 0.1;

  var_2 delete();
  var_1 delete();
  var_3 delete();
}

civs_walkers() {
  level endon("firing_down_field");
  level waittill("civ_walkers_go");
  wait 1;
  var_0 = scripts\engine\sp\utility::array_spawn_noteworthy("civ_walkers", 1);
  scripts\engine\utility::array_thread(var_0, ::civ_walkers_anim_and_run_away);
  scripts\engine\utility::array_thread(var_0, ::civ_walkers_breakout);
}

civ_walkers_anim_and_run_away() {
  level endon("firing_down_field");
  self endon("death");
  self.animname = self.animation;
  scripts\common\anim::anim_single_solo(self, "civ_walk_run");
  scripts\engine\sp\utility::set_goal_radius(75);
  self setgoalpos((4684, -2649, 30));
  wait 5;
  scripts\engine\utility::waittill_any_timeout(10, "goal");
  self delete();
}

civ_walkers_breakout() {
  self endon("death");
  level endon("spawning_unknowns");
  level waittill("firing_down_field");
  wait 0.2;
  self stopanimScripted();
  scripts\engine\sp\utility::set_goal_radius(75);
  self setgoalpos((5294, -2877, 30));
  scripts\engine\utility::waittill_any_timeout(10, "goal");
  self delete();
}

civs_table() {
  level endon("firing_down_field");
  var_0 = scripts\engine\sp\utility::array_spawn_noteworthy("table_civs", 1);

  foreach(var_2 in var_0)
  var_2.animname = var_2.animation;

  waitframe();
  var_4 = getEnt("civ_table_table", "targetname");
  var_5 = getEnt("civ_table_chair1", "targetname");
  var_5 scripts\engine\sp\utility::assign_animtree("chair1");
  var_6 = getEnt("civ_table_chair2", "targetname");
  var_6 scripts\engine\sp\utility::assign_animtree("chair2");
  var_7 = [var_5, var_6];
  thread civs_running_exiting_sounds();
  thread civs_running_exiting_2guys_right_sounds();
  thread civs_running_by_sounds_right_side();
  thread civs_running_by_sounds_left_side();
  var_4 thread scripts\common\anim::anim_first_frame(var_7, "civ_chair_idle");
  scripts\engine\utility::array_thread(var_0, ::civ_table_animations, var_4);
  scripts\engine\utility::array_thread(var_0, ::civs_table_breakout, var_4);
  scripts\engine\utility::flag_wait("player_flaring");
  var_7 = [var_5, var_6, var_4];
  scripts\engine\utility::array_delete(var_7);
}

civ_table_animations(var_0) {
  level endon("firing_down_field");
  self endon("death");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "civ_table_idle", "civ_table_loop_end");
  scripts\engine\utility::flag_wait("table_civs_spooked");
  wait 2;
  var_0 notify("civ_table_loop_end");
  var_0 scripts\common\anim::anim_single_solo(self, "civ_table_exit");
  self delete();
}

civs_running_exiting_sounds() {
  scripts\engine\utility::flag_wait("table_civs_spooked");
  wait 5.5;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_away_01", (4969, -1123, 100));
  wait 0.3;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_away_02", (5035, 423, 111));
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_away_03", (4548, -1834, 39));
}

civs_running_exiting_2guys_right_sounds() {
  level waittill("civ_walkers_go");
  wait 17.0;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_away_05", (4548, -1834, 39));
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_away_06", (4548, -1834, 39));
}

civs_running_by_sounds_right_side() {
  scripts\engine\utility::flag_wait("spawning_distant_threat_right_side");
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5509, -1528, 144));
  wait 0.2;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_in", (5509, -1528, 144));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5509, -1528, 144));
  wait 0.8;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_dumpster_hit_03", (5509, -1528, 144));
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5509, -1528, 144));
  wait 1.2;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5509, -1528, 144));
  wait 1.2;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5509, -1528, 144));
  wait 1.2;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5509, -1528, 144));
  wait 1.2;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5509, -1528, 144));
  wait 1.2;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5509, -1528, 144));
}

civs_running_by_sounds_left_side() {
  scripts\engine\utility::flag_wait("spawning_distant_threat_left_side");
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_dumpster_hit_01", (5397, -266, 144));
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5397, -266, 144));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5397, -266, 144));
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5397, -266, 144));
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5397, -266, 144));
  wait 0.8;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_in", (5397, -266, 144));
  wait 0.8;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5397, -266, 144));
  wait 0.8;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_dumpster_hit_02", (5397, -266, 144));
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5397, -266, 144));
  wait 0.8;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5397, -266, 144));
  wait 0.8;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5397, -266, 144));
  wait 0.8;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_by", (5397, -266, 144));
}

civs_table_breakout(var_0) {
  level endon("spawning_unknowns");
  self endon("death");
  self endon("entitydeleted");
  var_0 endon("civ_table_loop_end");
  level waittill("firing_down_field");
  wait 0.2;
  var_0 thread scripts\common\anim::anim_single_solo(self, "civ_table_exit");
  waitframe();
  self setanimrate(scripts\engine\utility::getanim("civ_table_exit"), 1.3);
  self waittillmatch("single anim", "end");
  self delete();
}

civs_bike() {
  var_0 = scripts\engine\utility::getStruct("bike_animstruct", "targetname");
  var_0.origin = (4706, -279, -10);
  var_0.angles = (0, 270, 0);
  var_1 = scripts\engine\sp\utility::array_spawn_noteworthy("bike_civ", 1);
  var_2 = var_1[0];
  var_2.animname = var_2.animation;
  var_3 = scripts\engine\sp\utility::spawn_anim_model("bike1");
  var_4 = [var_3, var_2];
  scripts\engine\utility::array_thread(var_4, ::civs_bike_breakout, var_0);
  level endon("firing_down_field");
  var_0 scripts\common\anim::anim_first_frame(var_4, "civ_bikers");
  scripts\engine\utility::flag_wait("civ_life_start");
  var_0 thread scripts\common\anim::anim_single(var_4, "civ_bikers");
  waitframe();
  var_2 setanimrate(var_2 scripts\engine\utility::getanim("civ_bikers"), 1.5);
  var_3 setanimrate(var_3 scripts\engine\utility::getanim("civ_bikers"), 1.5);
  var_2 waittillmatch("single anim", "end");
  var_2 delete();
  var_3 delete();
}

civs_bike_breakout(var_0) {
  self endon("death");
  level endon("spawning_unknowns");
  level waittill("firing_down_field");

  if(!scripts\engine\utility::flag("civ_life_start"))
    var_0 thread scripts\common\anim::anim_single_solo(self, "civ_bikers");

  wait 0.5;
  self setanimrate(scripts\engine\utility::getanim("civ_bikers"), 1.7);
  wait 1;
  self setanimrate(scripts\engine\utility::getanim("civ_bikers"), 2.2);
  self waittillmatch("single anim", "end");
  self delete();
}

civs_garage_door_guy() {
  thread civs_garage_door_guy_endon_watcher();
  level endon("firing_down_field_unspooked");
  var_0 = getspawner("door_civ", "script_noteworthy");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "garage_civ";
  waitframe();
  var_2 = spawnStruct();
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_2 thread scripts\common\anim::anim_loop_solo(var_1, "garage_civ_idle", "stop_loop");
  var_1 thread civs_garage_door_guy_breakout(var_2);
  scripts\engine\utility::flag_wait("table_civs_spooked");
  wait 2;
  var_2 notify("stop_loop");
  var_2 thread scripts\common\anim::anim_single_solo(var_1, "garage_civ_exit");
  var_3 = getEnt("garage_door", "targetname");
  scripts\engine\utility::delaythread(2.3, scripts\engine\utility::play_sound_in_space, "scn_embassy_cafe_door_close", var_3.origin);
  level notify("sfx_garage_door_shutting");
  wait 2.4;
  var_3 moveTo(var_3.origin - (0, 0, 76), 1);
  wait 1;
  level notify("garage_door_closed");
  var_1 delete();
}

civs_garage_door_guy_endon_watcher() {
  level waittill("firing_down_field");
  waitframe();

  if(scripts\engine\utility::flag("table_civs_spooked")) {
    return;
  }
  level notify("firing_down_field_unspooked");
}

civs_garage_door_guy_breakout(var_0) {
  level endon("spawning_unknowns");
  var_0 endon("stop_loop");
  var_0 endon("civ_table_loop_end");
  level waittill("firing_down_field");
  wait 0.3;
  var_0 thread scripts\common\anim::anim_single_solo(self, "garage_civ_exit");
  waitframe();
  self setanimrate(scripts\engine\utility::getanim("garage_civ_exit"), 1.2);
  var_1 = getEnt("garage_door", "targetname");
  scripts\engine\utility::delaythread(1.3, scripts\engine\utility::play_sound_in_space, "scn_embassy_cafe_door_close", var_1.origin);
  level notify("sfx_garage_door_shutting");
  wait 1.8;
  var_1 moveTo(var_1.origin - (0, 0, 76), 0.5);
  wait 1;
  level notify("garage_door_closed");
  self delete();
}

civs_soccer_guys() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("soccer_civs", 1);

  foreach(var_2 in var_0)
  var_2.animname = var_2.script_noteworthy;

  waitframe();
  scripts\engine\utility::array_thread(var_0, ::civs_soccer_guys_animation);
  scripts\engine\utility::array_thread(var_0, ::civs_soccer_guys_animation_breakout);
  thread sfx_cafe();
}

civs_soccer_guys_animation() {
  level endon("firing_down_field");
  var_0 = self;

  if(self.animname == "soccer_guy_1") {
    var_1 = getEnt("soccer_guy_2", "script_noteworthy");
    var_0 = var_1;
  }

  var_0 thread scripts\common\anim::anim_loop_solo(self, "civ_soccer_guys_idle", "stop_loop");
  scripts\engine\sp\utility::trigger_wait("roof_mortar_trigger", "targetname");
  scripts\engine\utility::flag_wait("intro_vo_finished");
  scripts\engine\utility::flag_wait("civ_life_start");
  var_0 notify("stop_loop");
  var_0 thread scripts\common\anim::anim_single_solo(self, "civ_soccer_guys");
  level waittill("garage_door_closed");

  if(isDefined(self))
    self delete();
}

civs_soccer_guys_animation_breakout() {
  level endon("spawning_unknowns");
  level waittill("firing_down_field");
  level waittill("garage_door_closed");
  self delete();
}

sfx_cafe() {
  wait 9;
  var_0 = spawn("script_origin", (4890, -955, 57));
  var_0 scripts\engine\sp\utility::sound_fade_in("emt_embassy_cafe_game_lp", 0.2, 5, 1);
  level waittill("sfx_garage_door_shutting");
  wait 2.3;
  var_0 playSound("emt_embassy_cafe_game_lp_end");
  wait 0.1;
  var_0 stoploopsound();
  var_0 delete();
}

civs_spotters() {
  var_0 = scripts\engine\utility::getStruct("spotter_animstruct", "targetname");
  var_1 = scripts\engine\sp\utility::array_spawn_targetname("spotter_civs");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_4 thread civs_spotters_breakout();
    var_4.animname = var_4.script_noteworthy;
  }

  var_0 thread scripts\common\anim::anim_loop(var_1, "civ_spotters_idle", "stop_lean_loop");
  level endon("firing_down_field");
  scripts\engine\utility::flag_wait("civ_life_start");
  scripts\engine\utility::flag_wait("civ_spotters_start");
  var_0 notify("stop_lean_loop");
  var_0 thread scripts\common\anim::anim_single(var_1, "civ_spotters");
  wait 6;
  level notify("civ_walkers_go");
  wait 5;
  scripts\engine\utility::flag_set("table_civs_spooked");
  wait 12;
  scripts\engine\utility::array_call(var_1, ::delete);
}

civs_spotters_breakout() {
  level endon("table_civs_spooked");
  level waittill("firing_down_field");
  var_0 = (5358, -808, -9.1);
  wait 0.2;
  self stopanimScripted();
  scripts\engine\sp\utility::set_goal_radius(75);
  self setgoalpos(var_0);
  scripts\engine\utility::waittill_any_timeout(10, "goal");
  self delete();
}

distant_threat() {
  scripts\engine\utility::flag_wait("wave_0_start_distant_threat");
  wait 1;

  if(scripts\engine\utility::flag("firing_down_field"))
    wait 5;

  var_0 = scripts\engine\utility::getStruct("mortar_wave_3_lookat", "targetname");
  var_1 = cos(90);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_1)) {
      break;
    } else
      wait 0.1;
  }

  wait 1;
  level.distant_guys = getspawnerarray("wave_0_enemies");
  scripts\engine\utility::array_thread(level.distant_guys, ::distant_guy_spawner_watcher);
  level.distant_guys thread spawn_distant_threat();
  scripts\engine\utility::flag_wait("spawning_unknowns");
  waitframe();
  scripts\engine\utility::flag_clear("spawning_unknowns");
  wait 10;
  level.distant_guys = getspawnerarray("wave_0_1_enemies");
  scripts\engine\utility::array_thread(level.distant_guys, ::distant_guy_spawner_watcher);
  level.distant_guys thread spawn_distant_threat();
  scripts\engine\utility::flag_wait("spawning_unknowns");
  wait 2;
  scripts\engine\utility::flag_set("spawning_unknowns_01");
  wait 7;
  scripts\engine\utility::flag_set("distant_threat_complete");
}

distant_threat_gate_init() {
  var_0 = getEnt("distant_threat_gate", "targetname");
  var_1 = var_0 scripts\engine\utility::get_target_ent();
  var_0.og_origin = var_0.origin;
  var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_0.move_origin = var_2.origin;
}

distant_threat_gate_move() {
  var_0 = getEnt("distant_threat_gate", "targetname");
  var_0 moveTo(var_0.move_origin, 2, 0, 2);
  wait 10.5;
  var_0 moveTo(var_0.og_origin, 2, 0, 2);
}

distant_guy_spawner_watcher(var_0, var_1) {
  level endon("spawning_unknowns");
  level endon("wave_1_start");
  var_2 = cos(1.5);
  var_3 = cos(7);
  var_4 = gettime();
  var_5 = 10;

  if(isDefined(var_0))
    var_5 = var_0;

  var_5 = var_5 * 1000;

  for(;;) {
    var_6 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var_3);
    var_7 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var_2);

    if(gettime() >= var_4 + var_5 || var_6 && !var_7 && level.player scripts\engine\sp\utility::isads()) {
      break;
    } else
      wait 0.1;
  }

  scripts\engine\utility::flag_set("spawning_unknowns");
}

spawn_distant_threat() {
  scripts\engine\utility::flag_wait("spawning_unknowns");
  level notify("spawning_distant_threat");
  wait 0.2;

  foreach(var_1 in level.distant_guys) {
    var_1 scripts\engine\sp\utility::spawn_ai(1);

    if(var_1.origin[1] > -1200)
      scripts\engine\utility::flag_set("spawning_distant_threat_left_side");

    if(var_1.origin[1] < -1200)
      scripts\engine\utility::flag_set("spawning_distant_threat_right_side");

    wait 0.4;
  }
}

distant_enemies_spawn_func() {
  self endon("death");
  self.ignoreall = 1;
  self.ignoreme = 1;
  scripts\engine\sp\utility::set_goal_radius(23);
  scripts\common\utility::demeanor_override("combat");
  scripts\engine\sp\utility::place_weapon_on(self.sidearm, "none");
  self.sidearm = isundefinedweapon();
  scripts\engine\utility::waittill_any_timeout(13, "goal", "delete_wave_0");
  wait 3;
  self delete();
}

friendlies_scared_of_dark() {
  while(!scripts\engine\utility::flag("enemies_at_the_wall") && !scripts\engine\utility::flag("flare_2_skipped")) {
    var_0 = getaiarray("allies");

    if(!scripts\engine\utility::flag("flares_out")) {
      foreach(var_2 in var_0)
      var_2.ignoreall = 1;
    } else {
      foreach(var_2 in var_0)
      var_2.ignoreall = 0;
    }

    wait 0.5;
  }

  if(scripts\engine\utility::flag("flare_2_skipped"))
    wait 5;

  var_0 = getaiarray("allies");

  foreach(var_2 in var_0)
  var_2.ignoreall = 0;
}

friendlies_defend_using_volume(var_0, var_1, var_2) {
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::disable_ai_color);
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::set_fixednode_false);
  scripts\engine\utility::array_call(var_0, ::setgoalvolumeauto, var_1, var_1 scripts\engine\sp\utility::get_cover_volume_forward());
  scripts\engine\utility::flag_wait(var_2);
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::enable_ai_color);
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::set_fixednode_true);
  var_3 = spawnStruct();
  var_3.count = var_0.size;

  foreach(var_5 in var_0)
  var_3 thread waittill_return_to_colornode(var_5);

  var_3 waittill("returned_to_colornode");
  level notify("returned_to_colornodes");
}

waittill_return_to_colornode(var_0) {
  wait 0.1;
  var_0.og_goalradius = var_0.goalradius;
  var_0.goalradius = 4;
  var_0 waittill("goal");
  var_0.goalradius = var_0.og_goalradius;
  var_0.og_goalradius = undefined;
  self.count--;

  if(self.count == 0)
    self notify("returned_to_colornode");
}

flare_nag_1() {}

flare_nag_2() {}

flare_nag_2_skipped() {}

flare_nag_3() {}

price_mortar_run_triggers_on(var_0) {
  var_1 = getEntArray("price_mortar_run_triggers", "script_noteworthy");
  var_1 = scripts\engine\utility::array_add(var_1, getEnt("mortar_house_guys_trigger", "targetname"));
  var_1 = scripts\engine\utility::array_add(var_1, getEnt("wave_5_mortar_house_exterior_trigger", "targetname"));
  var_1 = scripts\engine\utility::array_add(var_1, getEnt("mortar_house_street_save", "targetname"));

  if(var_0 == 0) {
    foreach(var_3 in var_1)
    scripts\engine\utility::trigger_off(var_3.targetname, "targetname");
  } else {
    foreach(var_3 in var_1)
    scripts\engine\utility::trigger_on(var_3.targetname, "targetname");
  }
}

price_compound_run_triggers_on(var_0) {
  var_1 = getEntArray("price_compound_run_triggers", "script_noteworthy");
  var_2 = getEnt("wolf_escapes", "targetname");
  var_1 = scripts\engine\utility::array_add(var_1, var_2);

  if(var_0 == 0) {
    foreach(var_4 in var_1)
    scripts\engine\utility::trigger_off(var_4.targetname, "targetname");
  } else {
    foreach(var_4 in var_1)
    scripts\engine\utility::trigger_on(var_4.targetname, "targetname");
  }
}

init_corner_wall() {
  var_0 = getEntArray("building_a_roof_front_destructible", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2.code_classname == "trigger_damage")
      var_2 setCanDamage(0);
  }

  var_4 = getEntArray("building_a_destroyed_wall_reveal", "targetname");

  foreach(var_2 in var_4) {
    var_2 show();

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "brush")
      var_2 connectpaths();
  }

  var_7 = getEntArray("building_b_destroyed_roof_reveal", "targetname");
  var_8 = getEntArray("building_a_roof_corner_destructible", "script_noteworthy");
  var_9 = [];

  foreach(var_2 in var_8) {
    if(var_2.code_classname == "trigger_damage")
      var_9[var_9.size] = var_2;
  }

  var_12 = getEntArray("building_a_destroyed_solid", "targetname");
  var_13 = getEntArray("building_a_roof_corner_wall", "targetname");
  var_14 = [];

  foreach(var_2 in var_13)
  var_14[var_14.size] = var_2;

  if(!scripts\sp\starts::is_after_start("Mortar")) {
    scripts\engine\utility::array_call(var_4, ::hide);
    level waittill("mortar_impact");
    waitframe();
    level waittill("mortar_impact");
  }

  var_17 = getEnt("roof_mortar_kill_trigger", "targetname");
  var_17 thread corner_wall_kill_player();
  var_18 = undefined;

  foreach(var_17 in var_9)
  var_17 notify("damage", 6, var_18, var_18, var_18, var_18, var_18, var_18, var_18, var_18, "mortar");

  var_21 = getEntArray("roof_mortar_wall_light_model_02", "targetname");
  scripts\engine\utility::array_delete(var_21);
  scripts\engine\utility::array_call(var_4, ::show);
  scripts\engine\utility::array_call(var_14, ::delete);
  scripts\engine\utility::array_call(var_12, ::delete);
  init_front_wall();
}

init_front_wall(var_0) {
  level waittill("mortar_impact");
  var_0 = getEntArray("building_a_roof_front_destructible", "script_noteworthy");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.code_classname == "trigger_damage")
      var_1[var_1.size] = var_3;
  }

  var_5 = undefined;

  foreach(var_7 in var_1)
  var_7 notify("damage", 6, var_5, var_5, var_5, var_5, var_5, var_5, var_5, var_5, "mortar");
}

init_b_side_wall(var_0) {
  wait 1;
  var_0 = getEntArray("building_b_roof_front_destructible", "script_noteworthy");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.code_classname == "trigger_damage")
      var_1[var_1.size] = var_3;
  }

  var_5 = undefined;

  foreach(var_7 in var_1)
  var_7 notify("damage", 6, var_5, var_5, var_5, var_5, var_5, var_5, var_5, var_5, "mortar");
}

init_corner_wall_building_b() {
  var_0 = getEntArray("building_b_roof_corner_wall", "targetname");
  scripts\engine\utility::flag_wait("wave_4_end");
  waitframe();
  scripts\engine\utility::array_call(var_0, ::hide);
}

init_roof_destruction() {
  var_0 = getEntArray("building_b_destroyed_roof_reveal", "targetname");
  var_1 = getEnt("building_b_roof", "targetname");

  foreach(var_3 in var_0) {
    var_3 show();

    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "brush")
      var_3 connectpaths();
  }

  if(!scripts\sp\starts::is_after_start("laser_targeting_1")) {
    foreach(var_3 in var_0)
    var_3 hide();

    var_1 connectpaths();
  }
}

init_destructible_roof_walls() {
  var_0 = getEntArray("wall_trigger", "targetname");
  scripts\engine\utility::array_thread(var_0, ::init_wall_state);
}

init_wall_state() {
  wait 0.15;
  var_0 = scripts\engine\utility::get_linked_ents();
  var_1 = scripts\engine\sp\utility::get_linked_scriptables();
  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "broken_wall")
      var_4 hide();

    var_4 setentityowner(self);
  }

  var_6 = 1;

  while(var_6) {
    self waittill("damage", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);

    if(isDefined(var_16))
      var_2 = getweaponbasename(var_16);

    if(isDefined(var_2) && (var_2 == "mortar" && var_7 > 5))
      var_6 = 0;
  }

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.script_noteworthy)) {
      continue;
    }
    if(var_4.script_noteworthy == "broken_wall") {
      var_4 show();
      var_4 dontcastshadows();
    }

    if(var_4.script_noteworthy == "solid_wall") {
      if(scripts\engine\utility::array_contains(var_1, var_4)) {
        var_4 setscriptablepartstate("base", "force_exploded");
        continue;
      }

      var_4 delete();
    }
  }
}

init_destructible_perimeter() {
  level.destructibles = [];
  level.east_wall_01 = getEntArray("mortar_wall_01", "targetname");
  level.east_wall_01 thread destructible_perimeter();
  level.destructibles[level.destructibles.size] = level.east_wall_01;
  level.east_wall_02 = getEntArray("mortar_wall_02", "targetname");
  level.east_wall_02 thread destructible_perimeter();
  level.destructibles[level.destructibles.size] = level.east_wall_02;
  level.east_wall_03 = getEntArray("mortar_wall_03", "targetname");
  level.east_wall_03 thread destructible_perimeter();
  level.destructibles[level.destructibles.size] = level.east_wall_03;
  level.east_wall_04 = getEntArray("mortar_wall_04", "targetname");
  level.east_wall_04 thread destructible_perimeter();
  level.destructibles[level.destructibles.size] = level.east_wall_04;
  level.east_wall_05 = getEntArray("mortar_wall_05", "targetname");
  level.east_wall_05 thread destructible_perimeter();
  level.destructibles[level.destructibles.size] = level.east_wall_05;
  level.east_wall_07 = getEntArray("mortar_wall_07", "targetname");
  level.east_wall_07 thread destructible_perimeter();
  level.destructibles[level.destructibles.size] = level.east_wall_07;
  level.roof_b_wall = getEntArray("roof_b_wall", "targetname");
  level.roof_b_wall thread roof_b_wall_init();
}

init_glowstick() {
  var_0 = getEnt("light_stick", "targetname");
  var_0 hide();
  var_0.og_origin = var_0.origin;
  var_0.og_angles = var_0.angles;
  var_1 = getEnt("mortar_light", "targetname");
  var_1.og_intensity = var_1 getlightintensity();
  var_1 setlightintensity(0);
  var_1.og_origin = var_1.origin;
  var_1.og_angles = var_1.angles;
  var_1.origin = var_0.origin;
  var_0.light = var_1;
}

destructible_perimeter(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 1;

  foreach(var_5 in self) {
    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "broken_wall")
      var_5 hide();

    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "solid_wall") {}
  }

  var_2 = self[0];

  if(isDefined(var_0))
    var_3 = 0;

  while(var_3) {
    var_2 waittill("destroy");
    var_3 = 0;
  }

  foreach(var_5 in self) {
    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "solid_wall") {
      var_5 hide();

      if(var_5.classname != "script_model")
        var_5 connectpaths();
    }

    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "broken_wall") {
      var_5 show();
      var_5 dontcastshadows();

      if(isDefined(var_5.script_parameters) && var_5.script_parameters == "ground_clip")
        var_5 connectpaths();
    }
  }

  wait 0.2;
}

init_residence_wall() {
  waitframe();
  var_0 = getEntArray("residence_destroyed_wall", "targetname");
  var_1 = getEntArray("residence_pristine_wall", "targetname");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  var_2 thread residence_wall_swap();
}

residence_wall_swap() {
  foreach(var_1 in self) {
    if(isDefined(var_1.targetname) && var_1.targetname == "residence_destroyed_wall")
      var_1 hide();
  }

  scripts\engine\utility::flag_wait("residence_destroyed");

  foreach(var_1 in self) {
    if(isDefined(var_1.targetname) && var_1.targetname == "residence_pristine_wall")
      var_1 hide();

    if(isDefined(var_1.targetname) && var_1.targetname == "residence_destroyed_wall")
      var_1 show();
  }
}

roof_b_wall_init(var_0) {
  foreach(var_2 in self) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "broken_wall")
      var_2 hide();
  }

  var_4 = scripts\engine\utility::getStruct("roof_b_wall_struct", "script_noteworthy");
  var_5 = 1;

  if(isDefined(var_0))
    var_5 = 0;

  while(var_5) {
    if(isDefined(var_0)) {
      break;
    }

    var_4 waittill("destroy");
    var_5 = 0;
  }

  foreach(var_2 in self) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "solid_wall")
      var_2 hide();

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "broken_wall")
      var_2 show();

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "clip")
      var_2 delete();
  }
}

roof_b_wall_02_init(var_0) {
  foreach(var_2 in self) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "broken_wall")
      var_2 hide();
  }

  var_4 = scripts\engine\utility::getStruct("roof_b_wall_struct_02", "script_noteworthy");
  var_5 = 1;

  if(isDefined(var_0))
    var_5 = 0;

  while(var_5) {
    if(isDefined(var_0)) {
      break;
    }

    var_4 waittill("destroy");
    var_5 = 0;
  }

  foreach(var_2 in self) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "solid_wall")
      var_2 hide();

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "broken_wall")
      var_2 show();

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "clip")
      var_2 delete();
  }
}

roof_b_corner_wall_init(var_0) {
  foreach(var_2 in self) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "broken_wall")
      var_2 hide();
  }

  var_4 = scripts\engine\utility::getStruct("roof_b_corner_wall_struct", "script_noteworthy");
  var_5 = 1;

  if(isDefined(var_0))
    var_5 = 0;

  while(var_5) {
    var_4 waittill("destroy");
    var_5 = 0;
  }

  foreach(var_2 in self) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "solid_wall")
      var_2 hide();

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "broken_wall")
      var_2 show();

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "clip")
      var_2 delete();
  }
}

destructible_wall_mortar_end(var_0, var_1) {
  foreach(var_3 in self) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "solid_wall") {
      if(isDefined(var_0)) {
        var_4 = spawnStruct();
        var_4.origin = var_3.origin;
        var_4.origin = (var_4.origin[0] - 20, var_4.origin[1] - 30, 20);

        if(isDefined(var_1))
          var_4.origin = (var_3.origin[0] + var_1, var_4.origin[1] - 30, 20);

        return var_4;
      } else
        return var_3;
    }
  }
}

player_kill_triggers() {
  var_0 = getEnt("player_kill_triggers", "targetname");
  thread scripts\sp\trigger::trigger_outofbounds(var_0);
}

player_warn_trigger() {
  level endon("wave_4_end");

  if(scripts\sp\starts::is_after_start("mortar_building_attack"))
    return;
  else if(scripts\engine\utility::flag("wave_4_end")) {
    return;
  }
  var_0 = getEnt("player_warn_trigger", "targetname");

  if(!level.player istouching(var_0))
    scripts\engine\sp\utility::trigger_wait("player_warn_trigger", "targetname");

  wait 1;
  level.price scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_pri_defend_intro_60");
  wait 4;

  if(level.player istouching(var_0))
    level.price scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_pri_defend_intro_70");

  wait 4;
  level.price scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_pri_defend_intro_60");
  wait 3;

  if(level.player istouching(var_0))
    level.price scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_pri_defend_intro_70");

  wait 1;
  var_1 = scripts\engine\utility::getStructArray("player_kill_struct", "targetname");
}

defend_wave_1_catchup() {
  thread shoot_out_field_lights(1);
  thread illumination_mortars_init();
  scripts\engine\utility::flag_set("front_1");
  scripts\engine\utility::flag_set("front_2");
  scripts\engine\utility::flag_set("front_3");
  scripts\engine\utility::flag_set("first_flare");
  scripts\engine\utility::flag_set("wave_1_end");
  var_0 = getEntArray("residence_loot", "targetname");
  scripts\engine\utility::array_call(var_0, ::hide);
}

defend_wave_2_trucks_start() {
  defend_inits();
  squad_init();
  level.front_goal_vol = getEnt("front_3", "targetname");
  scripts\engine\sp\utility::set_start_location("defend_start", [level.player, level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar, level.ally_03, level.ally_04]);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.ally_03, level.ally_04, level.greeter_marine, level.fsa_02, level.alex, level.hadir]);
  scripts\engine\utility::flag_set("wave_1_end");
  scripts\engine\utility::flag_set("enable_ilumination_flares");
  scripts\engine\utility::flag_set("wave_1_falling_back");
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("b");
  scripts\engine\utility::trigger_off("slide_trigger_01", "targetname");
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  thread sfx_spawn_crickets();
}

defend_wave_2_trucks_main() {
  thread scene_mortars();
  thread dialogue_rooftops_wave_2();
  level waittill("round_count_done");
  wait 2;
  var_0 = scripts\engine\utility::getStruct("mortar_wave_3_lookat", "targetname");
  var_1 = cos(90);
  scripts\engine\utility::flag_set("player_looking_toward_trucks");
  thread scripts\engine\utility::flag_set_delayed("stop_player_flare_mortar", 8);
  scripts\engine\utility::delaythread(11, ::distant_threat_gate_move);
  scene_trucks_drive_in();
  scripts\engine\utility::flag_wait("trucks_stopped");
  wait 7;
  scripts\engine\sp\utility::autosave_by_name("trucks_end");
  scripts\engine\utility::flag_set("wave_2_trucks_end");
}

scene_trucks_drive_in() {
  var_0 = scripts\engine\utility::getStruct("mortar_trucks_animstruct", "targetname");
  var_1 = getEnt("mortar_anim_truck_01", "targetname");
  var_1 show();
  var_1 scripts\engine\sp\utility::assign_animtree("truck_01");
  var_2 = getEnt("mortar_anim_truck_02", "targetname");
  var_2 show();
  var_2 scripts\engine\sp\utility::assign_animtree("truck_02");
  var_3 = getEnt("mortar_anim_truck_03", "targetname");
  var_3 show();
  var_3 scripts\engine\sp\utility::assign_animtree("truck_03");
  var_4 = [var_1, var_2, var_3];
  scripts\engine\utility::array_call(var_4, ::hide);
  scripts\engine\utility::flag_wait("player_looking_toward_trucks");
  scripts\engine\utility::array_call(var_4, ::show);
  scripts\engine\utility::array_thread(var_4, ::truck_drivers);
  level notify("mortar_trucks_start");
  var_1 thread sfx_trucks_drive_in_01();
  var_3 thread sfx_trucks_drive_in_02();
  var_0 scripts\common\anim::anim_single(var_4, "mortar_trucks_arrive");
  var_1 waittillmatch("single anim", "end");
  scripts\engine\utility::flag_set("trucks_stopped");
  thread sfx_mortar_setup();
}

truck_drivers() {
  var_0 = self;
  var_1 = getspawner("flavor_truck_driver", "targetname");
  var_1.count = var_1.count + 1;
  var_2 = var_1 scripts\engine\sp\utility::spawn_ai(1);
  var_2.animname = "flavor_truck_driver";
  var_2 linkTo(var_0, "tag_driver");
  var_0 thread scripts\common\anim::anim_loop_solo(var_2, "flavor_truck_drive_by", "stop_loop_driver", "tag_driver");
  scripts\engine\utility::flag_wait("trucks_stopped");
  wait 3;
  var_2 delete();
}

sfx_trucks_drive_in_01() {
  wait 3.7;
  self playSound("scn_embassy_trucks_drive_in");
}

sfx_trucks_drive_in_02() {
  self playSound("scn_embassy_red_truck_drive_in");
}

sfx_mortar_setup() {
  wait 3;
  var_0 = spawn("script_origin", (4814, -1330, 214));
  var_0 playSound("scn_embassy_mortar_setup");
  wait 6;
  var_0 delete();
}

scene_mortars() {
  level.ai_in_position = 0;
  var_0 = [level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar];
  var_1 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  scripts\engine\utility::array_thread(var_0, ::scene_mortars_ai_to_anim, var_1);

  while(level.ai_in_position < 4)
    waitframe();

  scripts\engine\utility::flag_wait("player_looking_toward_trucks");

  if(!scripts\engine\utility::flag("wave_2_trucks_end")) {
    wait 1;
    var_1 notify("stop_loop");
    var_1 scripts\common\anim::anim_single(var_0, "mortar_scene_trucks");
    var_1 thread scripts\common\anim::anim_loop(var_0, "mortar_scene_trucks_idle", "stop_loop");
  }

  scripts\engine\utility::flag_wait("enemy_mortar_allow_fire");
  wait 0.7;
  var_1 notify("stop_loop");
  var_1 scripts\common\anim::anim_single(var_0, "mortar_scene_attack");
  level.ally_02_mortar scripts\common\ai::stop_magic_bullet_shield();
  level.ally_02_mortar.health = 1;
}

scene_mortars_ai_to_anim(var_0) {
  if(level.start_point == "mortar")
    var_0 endon("stop_loop");
  else
    var_0 scripts\sp\anim::anim_reach_solo(self, "mortar_scene_start");

  level.ai_in_position++;
  var_0 scripts\common\anim::anim_single_solo(self, "mortar_scene_start");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "mortar_scene_idle", "stop_loop");
  scripts\engine\sp\utility::enable_ai_color();
}

player_weaponfire_watcher() {
  level endon("wave_1_start");
  scripts\engine\sp\utility::trigger_wait("roof_mortar_trigger", "targetname");
  var_0 = scripts\engine\utility::getStruct("mortar_wave_3_lookat", "targetname");

  for(;;) {
    level.player waittill("weapon_fired");

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, 0.95)) {
      level notify("firing_down_field");
      scripts\engine\utility::flag_set("firing_down_field");
      wait 0.1;
      scripts\engine\utility::flag_set("wave_0_start_distant_threat");
    }
  }
}

scene_intro_to_rooftops() {
  scripts\engine\sp\utility::set_start_location("approach_start", [level.ally_02_mortar]);
  var_0 = getEntArray("flare_mortar_tube", "targetname");
  var_1 = var_0[1];
  var_1 scripts\engine\sp\utility::assign_animtree("mortar");
  var_1.anim_struct = spawnStruct();
  var_1.anim_struct.angles = var_1.angles;
  var_1.anim_struct.origin = var_1.origin;
  var_2 = getEnt("ammo_box", "targetname");
  var_2.clip = var_2 scripts\engine\utility::get_target_ent();
  var_2.clip linkTo(var_2);
  var_2.clip notsolid();
  var_2 scripts\engine\sp\utility::assign_animtree("ammo_box");
  var_3 = [level.price, level.farah];
  var_4 = [level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar, var_1, var_2];
  var_5 = [level.ally_01_mortar, level.ally_02_mortar, var_1];
  var_6 = [level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar];
  var_7 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  var_7 thread scripts\common\anim::anim_first_frame_solo(var_1, "rooftops_begin");
  var_7 thread scripts\common\anim::anim_first_frame_solo(var_2, "rooftops_begin");
  level.ally_02_mortar thread marine_rooftop_reach_and_idle(var_7);
  var_7 thread scripts\common\anim::anim_loop([level.ally_01_mortar], "rooftops_idle", "stop_loop");
  var_7 thread scripts\common\anim::anim_single_solo(level.alex, "rooftops_intro_run");
  level.alex thread scene_intro_to_ai();
  var_7 scripts\common\anim::anim_single(var_3, "rooftops_intro_run");
  var_7 notify("stop_loop");
  waitframe();
  var_7 thread scripts\common\anim::anim_single(var_4, "rooftops_begin");
  scripts\engine\utility::array_thread(var_6, ::scene_intro_to_roof_to_idle, var_7);
  var_2 waittillmatch("single anim", "end");
  var_2.clip solid();
  var_8 = getEnt("player_mortar_clip", "targetname");
  var_8 solid();
  scripts\engine\utility::flag_wait("civ_life_start");
  scripts\engine\utility::flag_wait("player_flaring");
  var_2.clip delete();
  var_2 delete();
}

marine_rooftop_reach_and_idle(var_0) {
  var_0 scripts\sp\anim::anim_reach([level.ally_02_mortar], "rooftops_idle");
  var_0 scripts\common\anim::anim_loop_solo(level.ally_02_mortar, "rooftops_idle", "stop_loop");
}

scene_intro_to_ai(var_0) {
  self waittillmatch("single anim", "end");

  if(self != level.alex)
    var_0 thread scripts\sp\anim::anim_reach_solo(self, "rooftops_begin");
  else
    level.alex scripts\engine\sp\utility::set_force_color("b");
}

scene_intro_to_roof_to_idle(var_0) {
  if(!scripts\engine\utility::flag("intro_skipped"))
    self waittillmatch("single anim", "end");

  var_0 scripts\common\anim::anim_single_solo(self, "mortar_scene_start");
  self setgoalpos(self.origin);

  if(self == level.ally_01_mortar)
    var_0 thread scripts\common\anim::anim_loop_solo(self, "mortar_scene_idle", "stop_mortar_guy_idle");
  else
    var_0 thread scripts\common\anim::anim_loop_solo(self, "mortar_scene_idle", "stop_loop");

  if(self == level.price)
    scripts\engine\utility::flag_set("approach_end");
}

scene_flare_react() {
  if(scripts\engine\utility::flag("movement_skipped"))
    wait 3;

  var_0 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  var_0 notify("stop_mortar_guy_idle");
  waitframe();
  var_0 scripts\common\anim::anim_single_solo(self, "flare_nag_start");
  var_0 notify("stop_mortar_guy_idle");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "flare_nag_idle", "stop_loop_flare_react");
  scripts\engine\utility::flag_wait("enable_ilumination_flares");
  thread scene_flare_react_break_out();
  level endon("player_flaring");

  while(!scripts\engine\utility::flag("player_flaring") && !scripts\engine\utility::flag("flares_out")) {
    var_0 notify("stop_loop_flare_react");
    var_0 scripts\common\anim::anim_single_solo(self, "flare_nag");
    var_0 thread scripts\common\anim::anim_loop_solo(self, "flare_nag_idle", "stop_loop_flare_react");
    wait 3;
    var_0 notify("stop_loop_flare_react");
    waitframe();
  }
}

scene_flare_react_break_out() {
  var_0 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  scripts\engine\utility::flag_wait("player_flaring");
  var_0 notify("stop_loop_flare_react");
  var_0 scripts\common\anim::anim_single_solo(self, "flare_nag_react");
}

scene_ally_drag() {
  scripts\engine\sp\utility::activate_trigger("wave_2_drag_color_trigger", "targetname");
  level.ally_03.disableplayeradsloscheck = 1;
  level.ally_04.disableplayeradsloscheck = 1;
  waitframe();
  level.ally_03 scripts\engine\sp\utility::clear_force_color();
  level.ally_03 scripts\engine\sp\utility::set_force_color("y");
  level.ally_03 scripts\engine\utility::disable_pain();
  level.ally_04 scripts\engine\sp\utility::clear_force_color();
  level.ally_04 scripts\engine\sp\utility::set_force_color("c");
  scripts\engine\utility::flag_wait("ally_drag_start");
  scripts\engine\utility::flag_waitopen("flares_out");
  level.ally_04.ignoreme = 1;
  level.ally_03.ignoreme = 1;
  level.ally_03.ignoreall = 1;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2.grenadeammo = 0;

  var_4 = [level.ally_03, level.ally_04];
  var_5 = scripts\engine\utility::getStruct("ally_drag_struct", "targetname");
  var_5 scripts\sp\anim::anim_reach_solo(level.ally_03, "drag_scene_enter");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2.grenadeammo = 0;

  var_5 scripts\common\anim::anim_single_solo(level.ally_03, "drag_scene_enter");
  thread dialogue_drag_scene();
  thread ally_anim_reach_after_delay(var_5);
  var_5 scripts\common\anim::anim_single_solo(level.ally_03, "drag_scene_hit");
  var_5 thread scripts\common\anim::anim_single(var_4, "drag_scene_drag");
  thread drag_buddy_go_to_combat();
  level.ally_03 waittillmatch("single anim", "end");
  var_8 = scripts\engine\utility::getStruct("triage_struct", "targetname");
  var_9 = getEnt("barracks_bloodstain", "targetname");
  var_9 show();
  var_5 thread scripts\common\anim::anim_last_frame_solo(level.ally_03, "drag_scene_drag");
  level.ally_03 scripts\engine\sp\utility::name_hide();
  scripts\engine\utility::flag_set("drag_scene_complete");
  var_10 = getspawner("ally_03", "targetname");
  var_10.count = 1;
  var_11 = scripts\engine\sp\utility::bodyonlyspawn(var_10);
  var_11 setModel(level.ally_03.model);
  var_11.animname = level.ally_03.animname;
  var_11 scripts\common\ai::gun_remove();
  wait 0.1;
  var_11 dontinterpolate();
  var_5 thread scripts\common\anim::anim_last_frame_solo(var_11, "drag_scene_drag");
  waitframe();
  level.ally_03 scripts\common\ai::stop_magic_bullet_shield();
  level.ally_03 delete();
  scripts\engine\utility::flag_wait("green_beam_acquired");
  var_11 delete();
}

drag_buddy_go_to_combat() {
  level.ally_04 waittillmatch("single anim", "end");
  level.ally_04 scripts\engine\utility::enable_pain();
  level.ally_04.health = 1;
  level.ally_04.ignoreme = 0;
  level.ally_04.ignoreall = 0;
  level.ally_04 scripts\common\ai::stop_magic_bullet_shield();
  level.ally_04 scripts\engine\sp\utility::clear_force_color();
  level.ally_04 setgoalpos(level.ally_04.origin);
  level.ally_04 scripts\engine\sp\utility::set_goal_radius(800);
}

ally_anim_reach_after_delay(var_0) {
  level.ally_04 scripts\engine\utility::disable_pain();
  level.ally_04.ignoreall = 1;
  level.ally_04 scripts\engine\sp\utility::set_goal_radius(20);
  level.ally_04 allowedstances("crouch");
  wait 3.7;
  level.ally_04 allowedstances("crouch", "stand");
  var_0 scripts\sp\anim::anim_reach_and_approach_solo(level.ally_04, "drag_scene_drag");
}

scene_triage() {
  var_0 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  var_0 notify("stop_loop");
  var_1 = scripts\engine\utility::getStruct("ally_drag_struct", "targetname");
  var_1 notify("stop_loop");
  waitframe();
  level.barracks_civ = scripts\engine\sp\utility::spawn_script_noteworthy("civ_02", 1);
  level.barracks_civ.animname = "civ_01";
  level.barracks_civ.allowdeath = 1;
  level.barracks_civ.health = 10;
  var_2 = [level.price, level.farah];
  var_3 = [level.price, level.barracks_civ];
  var_4 = spawnStruct();
  var_4.origin = (181, -92, -0.583);
  var_4.angles = (0, 90, 0);
  var_5 = scripts\engine\utility::getStruct("triage_corpse_remover", "targetname");
  var_4.counter = 0;
  scripts\sp\maps\embassy\embassy_util.gsc::remove_corpses_near_pos(var_5.origin, var_5.radius);
  level.price thread anim_reach_failsafe_go(10, var_4, "triage_scene_pre_enter");
  var_4 scripts\sp\anim::anim_reach_solo(level.price, "triage_scene_pre_enter");
  level.price notify("anim_reached");
  thread triage_scene_mayhem_anims();
  var_4 scripts\common\anim::anim_single_solo(level.price, "triage_scene_pre_enter");
  var_4 thread scripts\common\anim::anim_loop_solo(level.price, "triage_scene_enter_idle", "stop_price");
  thread triage_start_watcher();
  scripts\engine\utility::flag_wait("triage_start");
  scripts\engine\utility::flag_set("triage_scene_started");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::wait_finish_speaking();
  var_6 = getEnt("targetting_struct", "targetname");
  var_6 scripts\engine\sp\utility::assign_animtree("green_beam");
  var_7 = spawn_triage_props();
  var_8 = var_7[0];
  var_7 = scripts\engine\utility::array_combine([var_6], var_7);
  var_4 notify("stop_price");
  thread triage_door_open();
  var_9 = scripts\engine\utility::array_combine([level.price, level.barracks_civ], var_7);
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_triage_price_bang_door", (-106, 176, 107));
  var_4 thread scripts\common\anim::anim_single(var_9, "triage_scene_start");
  scripts\engine\utility::array_thread(var_3, ::scene_triage_to_idle, var_4);
  thread triage_civ_breakout();
  level.player.rig hide();
  var_4 thread scripts\common\anim::anim_first_frame_solo(level.player.rig, "heart_to_heart");
  level waittill("green_beam_hint");
  scripts\engine\utility::flag_set("green_beam_shown");
  var_6 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 1, 0), &"EMBASSY/HINT_DESIGNATOR", 90, 200, 38, 0, undefined, 0, undefined, "duration_none", undefined, undefined, 65);
  var_6 waittill("trigger");
  scripts\engine\utility::flag_clear("wave_3_inside");
  var_4 notify("stop_loop");
  scripts\engine\utility::flag_set("green_beam_acquired");

  if(level.player ispcplayer()) {
    level.og_zplanes = getDvar("OMNONNMOTP");
    setsaveddvar("OMNONNMOTP", "0.1 500 1.5 10000");
  }

  level.green_beam = var_6;
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::green_beam_pickup();
  scripts\sp\maps\embassy\embassy_util.gsc::put_player_into_rig(level.player.rig, 0.5, 5, 5, 5, 5);
  var_9 = [level.player.rig, level.price, var_6];
  level.player.rig show();
  var_4 thread scripts\common\anim::anim_single(var_9, "heart_to_heart");
  var_4 notify("stop_loop");
  thread price_to_idle_to_climb(var_4);
  thread triage_rpg_momment_cleanup();
  level.player.rig waittillmatch("single anim", "end");
  level.barracks_civ notify("run_away");
  scripts\engine\utility::flag_set("allow_green_beam");
  scripts\engine\utility::exploder("field_fires");
  scripts\sp\maps\embassy\embassy_util.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  var_4 notify("stop_loop");
  var_3 = scripts\engine\utility::array_remove_array([level.farah, level.price], var_3);

  if(isDefined(level.og_zplanes) && level.player ispcplayer()) {
    setsaveddvar("OMNONNMOTP", level.og_zplanes);
    level.og_zplanes = undefined;
  }

  scripts\engine\utility::flag_wait("cleanup_triage_room");
  var_10 = getweaponarray();

  foreach(var_12 in var_10) {
    if(var_12.origin[2] < 60 && !scripts\engine\utility::is_equal(var_12.targetname, "m4_refill_02"))
      var_12 delete();
  }

  scripts\engine\utility::array_delete(var_7);
}

anim_reach_failsafe_go(var_0, var_1, var_2) {
  self endon("anim_reached");
  wait(var_0);
  var_3 = scripts\engine\utility::getanim(var_2);
  var_4 = getstartorigin(var_1.origin, var_1.angles, var_3);
  var_5 = getstartangles(var_1.angles, var_1.angles, var_3);
  self forceteleport(var_4, var_5);
}

triage_civ_breakout() {
  var_0 = getEnt("building_b_bathroom_door", "targetname");
  level.barracks_civ waittill("idle_looping");
  level.barracks_civ scripts\engine\utility::waittill_any("bulletwhizby", "run_away");
  level.barracks_civ notify("run_away");
  wait 2.5;
  var_0 rotateby((0, -70, 0), 1);
  wait 1;
  var_0 rotateby((0, 70, 0), 0.5);
  wait 3;
  level.barracks_civ delete();
}

price_to_idle_to_climb(var_0) {
  level.price waittillmatch("single anim", "end");
  var_0 thread scripts\common\anim::anim_loop_solo(level.price, "triage_scene_ladder_idle", "stop_loop");
  scripts\engine\utility::flag_wait("cleanup_triage_room");
  var_0 notify("stop_loop");
  var_1 = scripts\engine\utility::getStruct("ladder_up_struct", "targetname");
  var_1 scripts\sp\anim::anim_reach_solo(level.price, "ladder_climb");
  var_1 scripts\common\anim::anim_single_solo(level.price, "ladder_climb");
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::enable_ai_color();
  level.price scripts\engine\sp\utility::set_force_color("p");
}

spawn_triage_props() {
  var_0 = ["beam_case"];
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_1.size] = scripts\engine\sp\utility::spawn_anim_model(var_3);

  return var_1;
}

scene_alex_flare_support_breakout() {
  scripts\engine\utility::flag_wait("wave_2_end");
  level.support_mortar_tube notify("stop_flare_support_loop");
  level.support_mortar_tube scripts\common\anim::anim_single_solo(level.alex, "flare_launch_alex");
  level.alex scripts\engine\sp\utility::enable_ai_color();
}

triage_reach_and_idle(var_0) {
  self allowedstances("stand");
  var_1 = "triage_scene_start";
  var_2 = scripts\engine\utility::getanim(var_1);
  var_3 = getstartorigin(var_0.origin, var_0.angles, var_2);
  var_3 = var_3 + (0, -100, 0);
  scripts\common\ai::disable_arrivals();
  self.goalradius = 32;
  self setgoalpos(var_3);
  self waittill("goal");
  scripts\common\utility::demeanor_override("alert");
  scripts\common\ai::enable_arrivals();
  var_0 scripts\sp\anim::anim_reach_and_approach_solo(self, var_1);
  var_0.counter++;
  var_0 thread scripts\common\anim::anim_loop_solo(self, "triage_scene_enter_idle", "stop_loop");
  self allowedstances("stand", "crouch", "prone");
  scripts\common\utility::demeanor_override("combat");
}

triage_door_open() {
  wait 2.5;
  var_0 = getEnt("building_b_door", "targetname");
  var_1 = var_0 scripts\engine\utility::get_target_ent();
  var_0.clip = getEnt(var_1.targetname, "targetname");
  var_0.clip linkTo(var_0);
  var_0 rotateYaw(-90, 1);
  var_0.clip connectpaths();
}

triage_door_close() {
  var_0 = getEnt("building_b_door", "targetname");
  var_1 = var_0 scripts\engine\utility::get_target_ent();
  var_0.clip = getEnt(var_1.targetname, "targetname");
  var_0.clip linkTo(var_0);
  var_0 rotateYaw(90, 2);
  wait 2;
  var_0.clip disconnectPaths();
  var_2 = getEntArray("triage_loot", "targetname");
  scripts\engine\utility::array_call(var_2, ::hide);
}

scene_triage_to_idle(var_0) {
  self endon("death");
  var_1 = "stop_loop";
  wait 1;
  self waittillmatch("single anim", "end");

  if(self == level.price) {
    level notify("beam_show");
    var_1 = "stop_loop";
  }

  var_0 thread scripts\common\anim::anim_loop_solo(self, "triage_scene_idle", var_1);

  if(self == level.barracks_civ) {
    self notify("idle_looping");
    self waittill("run_away");
    var_0 thread scripts\common\anim::anim_single_solo(self, "triage_scene_exit");
  }

  if(self == level.farah)
    scripts\engine\utility::flag_set("triage_idle");
}

scene_triage_to_exit(var_0) {
  var_0 scripts\common\anim::anim_single_solo(self, "triage_scene_exit");

  if(self == level.farah)
    scripts\engine\sp\utility::enable_ai_color();

  if(self == level.price)
    level.price setgoalpos(level.price.origin);
}

scene_sniper_roof() {
  var_0 = scripts\engine\utility::getStruct("roof_sniper_animstruct", "targetname");
  var_0.origin = var_0.origin + (175, 110, 0);
  var_1 = [level.greeter_marine, level.fsa_02];
  var_2 = "sniper_start_death";

  foreach(var_4 in var_1) {
    var_4 scripts\engine\sp\utility::clear_force_color();
    var_4.fixednode = 0;
  }

  level.greeter_marine thread anim_reach_failsafe_go(10, var_0, "sniper_start_death");
  level.fsa_02 thread anim_reach_failsafe_go(10, var_0, "sniper_start_death");
  var_0 scripts\sp\anim::anim_reach(var_1, "sniper_start_death");

  foreach(var_4 in var_1)
  var_4 allowedstances("crouch");

  level notify("scene_sniper_roof");
  var_8 = getEnt("sniper_bad_place", "targetname");
  var_9 = createnavbadplacebyent(var_8, "axis");
  wait 1.0;
  level.greeter_marine notify("anim_reached");
  level.fsa_02 notify("anim_reached");
  var_10 = (-934, 2367, 447);
  var_11 = var_1[1] gettagorigin("j_head");
  var_12 = "iw8_ar_akilo47";
  var_0 thread scripts\common\anim::anim_single(var_1, "sniper_start_death");

  for(var_13 = 0; var_13 < 3; var_13++) {
    magicbullet(var_12, var_10, var_11 + (0, 1.5 * var_13, 2 * var_13));
    wait 0.1;
  }

  wait 1.3;

  for(var_13 = 0; var_13 < 5; var_13++) {
    var_11 = var_1[1] gettagorigin("j_head");
    magicbullet(var_12, var_10, var_11 + (0, 1.5 * var_13, 2 * var_13));
    wait 0.15;
  }

  wait 3.0;

  for(var_13 = 0; var_13 < 5; var_13++) {
    var_11 = var_1[0] gettagorigin("j_head");
    magicbullet(var_12, var_10, var_11 + (0, 1.5 * var_13, 2 * var_13));
    wait 0.15;
  }

  wait 4.5;

  for(var_13 = 0; var_13 < 5; var_13++) {
    var_11 = var_1[0] gettagorigin("j_head");
    magicbullet(var_12, var_10, var_11 + (0, 1.5 * var_13, 2 * var_13));
    wait 0.15;
  }

  destroynavobstacle(var_9);
}

defend_wave_2_trucks_catchup() {}

defend_wave_2_mortars_start() {
  defend_inits();
  squad_init();
  level.front_goal_vol = getEnt("front_4", "targetname");
  scripts\engine\sp\utility::set_start_location("defend_start", [level.player, level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar, level.ally_03, level.ally_04]);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.ally_03, level.ally_04, level.greeter_marine, level.fsa_02, level.alex, level.hadir]);
  scripts\engine\utility::flag_set("wave_1_end");
  scripts\engine\utility::flag_set("enable_ilumination_flares");
  scripts\engine\utility::flag_set("wave_2_trucks_end");
  scripts\engine\utility::flag_set("wave_1_falling_back");
  scripts\engine\utility::flag_set("player_looking_toward_trucks");
  scripts\engine\utility::flag_set("front_3");
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("b");
  scripts\engine\utility::trigger_off("slide_trigger_01", "targetname");
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  thread scene_mortars();
}

defend_wave_2_mortars_main() {
  scripts\engine\utility::flag_wait("wave_2_trucks_end");
  level.player.dontgrenademe = 0;
  level.flare_lifetime = 22;
  level.front_goal_vol = getEnt("front_4", "targetname");
  level.alex.ignoreme = 1;
  wait 1;
  thread scriptable_compound_car_shadows();
  thread wave_2_enemy_mortar();
  thread dialogue_rooftops_wave_2_mortars();
  thread player_runs_out_watcher();
  scripts\engine\utility::flag_wait("enemy_mortar_launched");
  var_0 = getEnt("mortar_anim_truck_01", "targetname");
  var_1 = getEnt("mortar_anim_truck_02", "targetname");
  var_2 = getEnt("mortar_anim_truck_03", "targetname");
  var_3 = [var_0, var_1, var_2];
  scripts\engine\utility::array_call(var_3, ::hide);
  level notify("sfx_stop_crickets");
  scripts\engine\utility::delaythread(5, scripts\engine\sp\utility::array_spawn_targetname, "wave_2_enemies", 1);
  level waittill("mortar_impact");
  var_4 = getEnt("player_mortar_clip", "targetname");
  var_4 delete();
  thread scene_ally_drag();
  thread destroy_first_roof_mortar();
  scripts\engine\utility::flag_wait("roof_compromised");
  level.flare_lifetime = 10;
  thread shadow_manager();
  scripts\engine\sp\utility::autosave_by_name("second_mortar");
  scripts\engine\utility::delaythread(5, ::friendly_flare_sender_loop, "flare_north");
  thread spawn_weapons_and_armor();
  thread mortar_roof_deadly();
  wait 7;
  scripts\engine\sp\utility::activate_trigger_with_targetname("wave_2_color_trigger");
  thread scripts\engine\sp\utility::battlechatter_on("allies");
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  thread mortar_rounds_pacing();
  level waittill("mortar_impact");
  scripts\engine\sp\utility::activate_trigger("wave_2_wall_cover_start", "targetname");
  scripts\engine\sp\utility::autosave_by_name("wave_2_mid");
  level waittill("mortar_impact");
  spawn_ai_wave_2_pre_push();
  scripts\engine\sp\utility::activate_trigger("wave_2_wall_cover", "targetname");
  scripts\engine\utility::flag_wait("perimeter_destroyed");
  scripts\engine\sp\utility::autosave_by_name("perimeter_destroyed");
  scripts\engine\utility::flag_waitopen("flares_out");
  var_5 = getaiarray("axis");

  foreach(var_7 in var_5)
  var_7.grenadeammo = 0;

  scripts\engine\utility::flag_wait("flares_out");
  spawn_ai_wave_2_pre_push();
  scripts\engine\utility::flag_set("ally_drag_start");
  thread clear_enemy_grenades();
  scripts\engine\utility::flag_waitopen("flares_out");
  thread clear_enemy_grenades();
  scripts\engine\utility::flag_clear("flare_loop_on");
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::flag_clear("enemy_mortar_allow_fire");
  scripts\engine\sp\utility::autosave_by_name("ally_drag");
  thread wave_2_nerf_friendlies();
  wait 4;
  scripts\engine\sp\utility::activate_trigger_with_targetname("push_color_trigger");
  scripts\engine\utility::flag_set("push_objective");
  scripts\engine\sp\utility::activate_trigger_with_targetname("wave_2_color_trigger");
  spawn_max_ai_wave_2_push();
  spawn_max_ai_wave_2_push();
  thread clear_enemy_grenades();
  wait 2;
}

scriptable_compound_car_shadows() {
  wait 0.2;
  var_0 = getscriptablearray();

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2.model, "veh8_civ_lnd_decho_mp_black"))
      var_2 dontcastshadows();
  }
}

shadow_manager() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0)
  var_2 dontcastshadows();

  scripts\engine\utility::array_thread(var_0, ::ai_show_shadows_in_compound);
  scripts\engine\utility::flag_wait("wave_2_end");
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    var_2 notify("castshadows");
    var_2 castshadows();
  }
}

ai_show_shadows_in_compound() {
  self endon("death");
  self endon("castshadows");
  var_0 = getEnt("interior_main_grounds", "targetname");

  while(!self istouching(var_0))
    wait 0.1;

  self castshadows();
}

player_runs_out_watcher() {
  level endon("ally_drag_start");
  var_0 = getEnt("player_warn_trigger", "targetname");

  for(;;) {
    var_1 = getaiarray("axis");

    if(level.player istouching(var_0)) {
      foreach(var_3 in var_1)
      var_3 notify("player_outside");
    }

    wait 0.5;
  }
}

clear_enemy_grenades() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2.grenadeammo = 0;
}

defend_wave_2_push_start() {
  if(getdvarint("scr_emb_trailer", 1)) {
    level.trailer = 1;
    waitframe();
  }

  defend_inits();
  squad_init();
  level.front_goal_vol = getEnt("front_4", "targetname");
  level.ally_02_mortar scripts\common\ai::stop_magic_bullet_shield();
  level.ally_02_mortar delete();
  scripts\engine\sp\utility::set_start_location("defend_wave_2_push_start", [level.player, level.price, level.farah]);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.ally_03, level.ally_04, level.greeter_marine, level.fsa_02, level.alex, level.hadir]);
  thread friendly_flare_sender(undefined, "flare_north");
  scripts\engine\utility::flag_set("wave_1_end");
  scripts\engine\utility::flag_set("enable_ilumination_flares");
  scripts\engine\utility::flag_set("wave_2_trucks_end");
  scripts\engine\utility::flag_set("wave_1_falling_back");
  scripts\engine\utility::flag_set("player_looking_toward_trucks");
  scripts\engine\utility::flag_set("roof_compromised");
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("b");
  scripts\engine\utility::trigger_off("slide_trigger_01", "targetname");
  scripts\engine\sp\utility::activate_trigger_with_targetname("wall_breach_color_trigger");
  level.player.dontgrenademe = 0;
  level.flare_lifetime = 22;
  level.front_goal_vol = getEnt("front_4", "targetname");
  level.alex.ignoreme = 1;
  setaudiotriggerstate("combat_zone", "combat_lvl2", 0.1);
  setaudiotriggerstate("default", "combat_lvl2", 0.1);
  var_0 = spawnStruct();
  var_0.origin = (1289, -600, -20);
  scripts\engine\sp\utility::array_spawn_targetname("wave_2_enemies", 1);
  spawn_max_ai_wave_2_push();
  spawn_max_ai_wave_2_push();
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1)
  var_3 forceteleport(var_0.origin, var_3.angles);

  level.push_delay = 4;
  scripts\engine\utility::exploder("mortar2");
  level.ally_04 delete();
  var_5 = scripts\engine\utility::getStruct("triage_struct", "targetname");
  var_5 thread scripts\common\anim::anim_first_frame_solo(level.ally_03, "drag_scene_idle");
  level.ally_03 scripts\engine\sp\utility::name_hide();
  scripts\sp\maps\embassy\embassy_lighting.gsc::start_tree_fire_flicker();
}

defend_wave_2_push_main() {
  thread defend_push_weapon_cleanup();
  scripts\engine\sp\utility::activate_trigger_with_targetname("push_color_trigger");
  waitframe();

  if(isDefined(level.push_delay))
    wait(level.push_delay);

  var_0 = getaiarray("axis");
  var_0 = sortbydistance(var_0, level.player.origin);

  foreach(var_2 in var_0)
  var_2.grenadeammo = 0;

  var_0 thread enemies_battlecry();
  var_0[0] thread enemy_gun_pump();
  wait 1;
  scripts\engine\utility::flag_set("perimeter_breached");
  var_4 = getnodearray("push_inside_path", "targetname");
  var_4 = sortbydistance(var_4, level.player.origin);
  wait 1;
  var_0 = getaiarray("axis");
  var_0 = sortbydistance(var_0, var_4[0].origin);
  scripts\engine\utility::array_thread(var_0, ::enemies_flood_interior, var_0, var_4);
  thread ignore_player_for_breach();
  scripts\engine\utility::flag_wait("perimeter_breached");
  level.fsa_02.ignoreall = 0;
  level.greeter_marine.ignoreall = 0;
  scripts\engine\sp\utility::activate_trigger_with_targetname("wall_breach_color_trigger");
  scripts\engine\utility::delaythread(7, ::enemies_hunt_player);
  enemy_alive_counter_gate(8);
  spawn_max_ai_wave_2_push_again();
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2.grenadeammo = 0;
    var_2 scripts\engine\sp\utility::set_ignoresuppression(1);
  }

  var_7 = getEnt("interior_main_grounds", "targetname");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.seeking_player)) {
      continue;
    }
    var_2 setgoalvolumeauto(var_7);
  }

  enemy_alive_counter_gate(6);
  var_10 = getaiarray("axis");

  foreach(var_2 in var_10) {
    var_2 notify("clear_spawn_func_logic");
    waitframe();
    var_2 scripts\engine\sp\utility::set_ignoresuppression(1);
    var_2.ignoreall = 0;
    var_2.attackeraccuracy = 1;
    var_2 scripts\common\utility::demeanor_override("combat");
    var_2 scripts\engine\utility::set_movement_speed(220);
    var_2 setgoalpos((-48, -371, 80));
    var_2 scripts\engine\sp\utility::set_goal_radius(350);
  }

  enemy_alive_counter_gate(4);
  var_0 = getaiarray("axis");

  foreach(var_14 in var_0) {
    self.health = 1;
    self.attackeraccuracy = 10;
    self.baseaccuracy = 0;

    if(var_14 scripts\engine\utility::doinglongdeath()) {
      var_14 kill();
      continue;
    }

    var_14 scripts\engine\sp\utility::disable_long_death();
  }

  enemy_alive_counter_gate(3);
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 scripts\engine\sp\utility::set_goal_radius(256);
      var_2 setgoalentity(level.player);
      var_2 scripts\engine\sp\utility::set_favoriteenemy(level.player);
      var_2.health = 1;
    }
  }

  enemy_alive_counter_gate(0);
  scripts\engine\sp\utility::autosave_by_name("wave_2_complete");
  setaudiotriggerstate("combat_zone", "combat_lvl0", 1);
  setaudiotriggerstate("default", "combat_lvl0", 1);
  wait 7;
  scripts\engine\utility::flag_set("wave_2_end");
}

defend_wave_2_push_catchup() {
  scripts\engine\utility::flag_set("push_objective");
  scripts\engine\utility::flag_set("wave_2_end");
  scripts\sp\maps\embassy\embassy_lighting.gsc::start_tree_fire_flicker();
}

mortar_roof_deadly() {
  scripts\engine\utility::flag_wait("wave_3_mortars_roof_targeted");
  var_0 = getEnt("roof_mortar_trigger", "targetname");
  wait 6;

  while(!scripts\engine\utility::flag("triage_start")) {
    if(level.player istouching(var_0))
      level.player scripts\sp\utility::set_player_attacker_accuracy(10);
    else
      level.player scripts\sp\utility::set_player_attacker_accuracy(1);

    wait 0.5;
  }

  level.player scripts\sp\utility::set_player_attacker_accuracy(1);
}

spawn_weapons_and_armor() {
  var_0 = getEnt("m4_refill_03", "targetname");

  if(isDefined(var_0)) {
    var_0.origin = var_0.og_origin;
    var_0.angles = var_0.og_angles;
  }

  var_0 = getEnt("m4_refill_01", "targetname");

  if(isDefined(var_0)) {
    var_0.origin = var_0.og_origin;
    var_0.angles = var_0.og_angles;
  }
}

spawn_triage_loot() {}

spawn_ar(var_0, var_1) {
  var_2 = "weapon_iw8_ar_mike4+reflex_west01";
  var_3 = spawn(var_2, var_0, 1);
  var_3.angles = var_1;
  return var_3;
}

ignore_player_for_breach() {
  level.player.ignoreme = 1;
  wait 5;
  level.player.ignoreme = 0;
}

corner_wall_kill_player() {
  if(!level.player istouching(self)) {
    return;
  }
  thread scripts\sp\hud_util::fade_out(0.4);
  level.player kill();
}

enemies_battlecry() {
  if(isDefined(self[0]))
    self[1] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_defend_battlecry_20");

  if(isDefined(self[2]))
    self[2] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq3_defend_battlecry_40");

  if(isDefined(self[3]))
    self[3] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq3_defend_battlecry_41");
}

spawn_ai_wave_1() {
  level.wave_1_guys = [];
  var_0 = 6;
  var_1 = getspawnerarray("wave_1");

  if(var_1.size - var_0 < 0)
    var_0 = var_1.size;

  for(var_2 = 0; var_2 < var_0; var_2++)
    level.wave_1_guys[level.wave_1_guys.size] = var_1[var_2] scripts\engine\sp\utility::spawn_ai(1);
}

spawn_ai_wave_2_pre_push() {
  var_0 = getaiarray("axis", "allies");
  var_1 = 28 - var_0.size;
  var_2 = getspawnerarray("wave_2_extra_1");

  if(var_2.size - var_1 < 0)
    var_1 = var_2.size;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_2[var_3].count = 1;
    var_2[var_3] scripts\engine\sp\utility::spawn_ai(1);
    var_2[var_3].count = 1;
  }
}

spawn_max_ai_wave_2_push() {
  var_0 = getaiarray("axis", "allies");
  var_1 = 28 - var_0.size;
  var_2 = getspawnerarray("wave_2_extra_3");

  if(var_2.size - var_1 < 0)
    var_1 = var_2.size;

  var_3 = [];
  var_4 = 0;

  while(var_3.size - 1 < var_1) {
    var_5 = var_2[var_4] scripts\engine\sp\utility::spawn_ai();

    if(isDefined(var_5))
      var_3[var_3.size] = var_5;

    var_2[var_4].count = 1;
    var_4++;

    if(var_4 == var_2.size - 1)
      var_4 = 0;

    wait 0.3;
  }

  var_0 = getaiarray("axis", "allies");
}

spawn_max_ai_wave_2_push_again() {
  var_0 = getaiarray("axis", "allies");
  var_1 = 10;
  var_2 = getspawnerarray("push_inside__refill");

  if(var_2.size - var_1 < 0)
    var_1 = var_2.size;

  var_3 = [];
  var_4 = 0;

  while(var_3.size - 1 < var_1) {
    var_5 = var_2[var_4] scripts\engine\sp\utility::spawn_ai();

    if(isDefined(var_5))
      var_3[var_3.size] = var_5;

    var_2[var_4].count = 1;
    var_4++;

    if(var_4 == var_2.size - 1)
      var_4 = 0;

    wait 0.3;
  }
}

enemies_hunt_player() {
  var_0 = getaiarray("axis");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = 3;
  var_2 = [];

  if(var_0.size > 15)
    var_1 = 6;

  for(var_3 = 0; var_3 < var_1; var_3++)
    var_2[var_2.size] = var_0[var_3];

  foreach(var_5 in var_2) {
    if(isalive(var_5))
      var_5 notify("hunting_player");

    waitframe();

    if(isalive(var_5)) {
      var_5 scripts\engine\sp\utility::set_favoriteenemy(level.player);
      var_5 scripts\engine\sp\utility::set_goal_radius(500);
      var_5 setgoalentity(level.player);
      var_5.seeking_player = 1;
    }
  }
}

enemies_flood_interior(var_0, var_1) {
  self endon("death");
  self endon("hunting_player");
  scripts\engine\sp\utility::set_ignoresuppression(1);
  self.holding = undefined;

  if(var_0.size > 16) {
    for(var_2 = 4; var_2 < 21; var_2 = var_2 + 2) {
      if(isDefined(self) && isDefined(var_0[var_2]) && self == var_0[var_2])
        self.holding = 1;
    }
  }

  if(isDefined(self.holding))
    wait 3;

  wait(randomfloatrange(0.2, 0.5));
  scripts\engine\sp\utility::set_goal_radius(500);
  var_3 = getEnt("interior_grounds_center", "targetname");
  scripts\engine\utility::set_movement_speed(140);
  self setgoalnode(var_1[0]);
  scripts\engine\utility::waittill_any_timeout(12, "goal");
  var_4 = scripts\engine\utility::getStruct("mortar_suv_struct", "script_noteworthy");
  self setgoalpos(var_4.origin);
  scripts\engine\sp\utility::set_goal_radius(960);
}

enemy_gun_pump() {
  self endon("death");
  self.animname = "aq_88";
  self.allowdeath = 1;
  var_0 = ["first_wave_gun_pump_1", "first_wave_gun_pump_2"];
  thread scripts\common\anim::anim_single_solo(self, "first_wave_gun_pump_1");
  wait 2.7;
  level notify("enemy_rush_after_pump");
  self stopanimScripted();
  waitframe();
}

defend_wave_2_mortars_catchup() {
  scripts\engine\utility::flag_set("palm_01_damaged");
  scripts\engine\utility::flag_set("roof_compromised");
  scripts\engine\utility::flag_set("push_objective");
  level.east_gate = getEnt("eastgate_clip", "targetname");
  var_0 = level.east_gate scripts\engine\utility::get_target_ent();
  var_0 hide();
  level.east_gate connectpaths();
  level.east_gate delete();
  level.east_wall_01 = getEntArray("mortar_wall_01", "targetname");
  level.east_wall_01 thread destructible_perimeter(1);
  level.east_wall_02 = getEntArray("mortar_wall_02", "targetname");
  level.east_wall_02 thread destructible_perimeter(1);
  level.east_wall_03 = getEntArray("mortar_wall_03", "targetname");
  level.east_wall_03 thread destructible_perimeter(1);
  level.east_wall_04 = getEntArray("mortar_wall_04", "targetname");
  level.east_wall_04 thread destructible_perimeter(1);
  level.east_wall_07 = getEntArray("mortar_wall_07", "targetname");
  level.east_wall_07 thread destructible_perimeter(1);
  level.roof_b_wall = getEntArray("roof_b_wall", "targetname");
  level.roof_b_wall thread roof_b_wall_init(1);
  scripts\engine\utility::exploder("mortar2");
  scripts\engine\utility::exploder("mortar3");
  scripts\engine\utility::exploder("mortar4");
  scripts\engine\utility::exploder("mortar5");

  if(!scripts\sp\starts::is_after_start("mortar_building_exterior")) {
    scripts\engine\utility::exploder("mortar6_tree");
    scripts\engine\utility::exploder("mortar6");
  }

  scripts\engine\utility::exploder("mortar7");

  if(scripts\sp\starts::is_after_start("mortar_building_exterior")) {
    level.east_wall_06 = getEntArray("mortar_wall_06", "targetname");
    level.east_wall_06 thread destructible_perimeter(1);
  }

  scripts\engine\utility::exploder("firewall");
}

wave_2_nerf_friendlies() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    var_2.baseaccuracy = 0.6;

    if(isDefined(var_2.roof)) {
      var_2.ignoreme = 1;
      var_2.baseaccuracy = 0.1;
    }
  }

  scripts\engine\utility::flag_wait("wave_2_end");
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    var_2.baseaccuracy = 1;

    if(isDefined(var_2.roof))
      var_2.ignoreme = 0;
  }
}

defend_wave_3_triage_start() {
  scripts\engine\utility::flag_set("drag_scene_complete");
  scripts\engine\utility::flag_set("enable_ilumination_flares");
  defend_inits();
  squad_init();
  scripts\engine\sp\utility::set_start_location("defend_start", [level.ally_03, level.ally_04, level.greeter_marine, level.fsa_02, level.alex, level.hadir]);
  scripts\engine\sp\utility::set_start_location("defend_wave_3_start", [level.player, level.price, level.farah, level.ally_02_mortar]);
  level.ally_04 delete();
  level.ally_03 scripts\engine\sp\utility::name_hide();
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("b");
  var_0 = scripts\engine\utility::getStruct("triage_struct", "targetname");
  level.ally_03 scripts\common\ai::stop_magic_bullet_shield();
  var_0 thread scripts\common\anim::anim_first_frame_solo(level.ally_03, "drag_scene_idle");
  waitframe();
  level.ally_03.allowdeath = 1;
  level.ally_03.skipdeathanim = 1;
  level.ally_03.noragdoll = 1;
  level.ally_03.diequietly = 1;
  level.ally_03 scripts\engine\sp\utility::die();
}

defend_wave_3_triage_main() {
  thread mantle_over_wall();
  scripts\engine\utility::flag_wait("wave_2_end");
  thread scripts\engine\utility::flag_set_delayed("triage_watcher_start", 2);
  thread scripts\sp\friendlyfire::reset_friendlyfire_participation();
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(var_2 == level.farah || var_2 == level.price) {
      continue;
    }
    var_2 scripts\engine\sp\utility::clear_force_color();
    var_2 scripts\engine\sp\utility::set_force_color("b");
  }

  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  level.price scripts\engine\sp\utility::clear_force_color();
  thread dialogue_rooftops_wave_3();
  thread triage_ammo_nag();
  scripts\engine\utility::flag_set("price_triage_objective");
  scripts\engine\utility::flag_wait("triage_watcher_start");
  thread traversal_nav_obstacle();
  wait 1;
  thread scene_triage();
  wait 2;
  thread scripts\sp\maps\embassy\embassy_util.gsc::focus_reminder("wave_3_inside", 25);
  var_4 = getaiarray("allies");
  scripts\engine\utility::flag_wait("triage_start");
  level.price scripts\engine\sp\utility::name_hide();
  var_5 = getEntArray("triage_loot", "targetname");
  scripts\engine\utility::array_call(var_5, ::show);
  scripts\engine\utility::flag_wait("wave_3_inside");
  var_6 = getEntArray("triage_loot_roof", "targetname");
  scripts\engine\utility::array_call(var_6, ::show);
  thread field_weapon_cleanup();
  thread scripts\sp\analytics::analytics_kleenex_update("Defend to Triage");
  level.support_mortar_tube.angles = level.support_mortar_tube.angles + (0, 120, 0);
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  scripts\engine\utility::flag_wait("allow_green_beam");
  scripts\engine\utility::flag_set("custom_cooldown");
  var_7 = getEntArray("rooftop_loot", "targetname");
  scripts\engine\utility::array_call(var_7, ::hide);
  scripts\engine\sp\utility::autosave_by_name("green_beam_acquired");
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

mantle_over_wall() {
  scripts\engine\utility::flag_wait("ladder_up");
  wait 2;
  scripts\engine\sp\utility::trigger_wait_targetname("building_a_roof_trigger");
  var_0 = getEnt("mantle_trigger", "targetname");

  if(level.player istouching(var_0)) {
    var_1 = spawnStruct();
    var_1.origin = (-172.1, 210.5, 220);
    var_1.angles = (0, 90, 0);
    var_2 = scripts\engine\utility::spawn_tag_origin(level.player.origin, var_1.angles);
    level.player playerlinktoblend(var_2, "tag_origin", 0.2);
    wait 0.2;
    var_2 moveTo(var_1.origin, 0.5, 0.5);
    level.player scripts\engine\sp\utility::player_gesture_force("ges_movement_mantle_32_over");
    wait 0.5;
    level.player unlink();
  }
}

traversal_nav_obstacle() {
  var_0 = getEnt("traversal_temp_nav_obstacle", "targetname");
  var_1 = createnavbadplacebyent(var_0, "axis", "allies");
  scripts\engine\utility::flag_wait("wave_4_end");
  destroynavobstacle(var_1);
}

embassy_palm_trees(var_0) {
  if(isDefined(level.palm_trees) && level.palm_trees.size != 0) {
    foreach(var_2 in level.palm_trees) {
      if(isDefined(var_2)) {
        var_3 = distance(var_2.origin, var_0);

        if(var_3 < 600) {
          scripts\engine\utility::array_remove(level.palm_trees, var_2);
          wait(randomfloatrange(1, 2));

          if(scripts\engine\utility::is_equal(var_2.targetname, "emb_palm_02")) {
            level notify("emb_palm_02_damaged");
            level.palm_trees = scripts\engine\utility::array_remove(level.palm_trees, var_2);
          } else {
            scripts\engine\utility::exploder(var_2.exploder_name);
            level.palm_trees = scripts\engine\utility::array_remove(level.palm_trees, var_2);
          }
        }
      }
    }
  }
}

triage_rpg_momment_cleanup() {
  wait 13.4;
  thread scripts\engine\utility::play_sound_in_space("weap_mortar_incoming", (-314, 739, 1000));
  wait 1.6;
  scripts\engine\utility::exploder("triage_exp");
  screenshake(level.player.origin, 20, 1, 5, 0.5, 0, 0.5, 100, 5, 50, 50);
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_triage_mortar_ceiling_dirt_01", (-498, 347, 106));
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_triage_mortar_ceiling_dirt_02", (-263, 475, 106));
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price setgoalpos(level.price.origin);
  level.farah scripts\common\utility::demeanor_override("combat");
  level.price scripts\common\utility::demeanor_override("combat");
  level.farah scripts\engine\utility::set_movement_speed(120);
  level.price scripts\engine\utility::set_movement_speed(120);
  var_0 = getnode("price_ladder_node", "targetname");
  var_1 = scripts\engine\utility::getStruct("farah_ladder_struct", "targetname");
  magicgrenademanual("mortar", level.player.origin + (0, 0, 250), (0, 0, 0), 0.05);
  var_2 = getEnt("barracks_ladder_brush", "targetname");
  var_2 hide();
  var_3 = scripts\engine\utility::getStruct("ladder_up_struct", "targetname");
  var_3.origin = var_3.origin + (-34, 0, 0);
  level.price setgoalnode(var_0);
  var_4 = getEnt("barracks_ladder", "targetname");
  var_4 scripts\engine\sp\utility::assign_animtree("ladder");
  var_4.animname = "ladder";
  var_5 = [var_4, level.farah];
  var_3 thread scripts\common\anim::anim_single(var_5, "ladder_up_scene");
  waitframe();
  level.farah.pushable = 1;
  level.farah setanimtime(level.farah scripts\engine\utility::getanim("ladder_up_scene"), 0.01);
  var_4 setanimtime(var_4 scripts\engine\utility::getanim("ladder_up_scene"), 0.01);
  waitframe();
  level.farah setanimrate(level.farah scripts\engine\utility::getanim("ladder_up_scene"), 0);
  var_4 setanimrate(var_4 scripts\engine\utility::getanim("ladder_up_scene"), 0);
  thread scripts\engine\utility::flag_set_delayed("building_combat_objective", 5);
  scripts\engine\utility::flag_set("sniper_roof_start");
  thread can_see_farah_watcher();
  scripts\engine\utility::flag_wait("wave_3_inside");
  level.farah setanimrate(level.farah scripts\engine\utility::getanim("ladder_up_scene"), 1);
  var_4 setanimrate(var_4 scripts\engine\utility::getanim("ladder_up_scene"), 1);
  scripts\engine\utility::flag_set("ladder_up");
  var_2 show();
  wait 4;
  thread intro_playerspeedscalinglogic();
  level.farah waittillmatch("single anim", "end");
  level notify("farah_over_roof");
  scripts\sp\player::player_movement_state("default");
}

intro_playerspeedscalinglogic() {
  level endon("farah_over_roof");

  while(!level.player isonladder())
    waitframe();

  var_0 = level.farah;
  var_1 = 40;
  var_2 = 85;
  var_3 = 20;
  var_4 = 40;
  var_5 = [var_0];

  for(;;) {
    var_6 = sortbydistance(var_5, level.player.origin)[0];
    var_7 = distance(var_6.origin, level.player.origin);
    var_8 = scripts\engine\math::normalize_value(var_3, var_4, var_7);
    var_9 = scripts\engine\math::factor_value(var_1, var_2, var_8);
    scripts\engine\sp\utility::player_speed_set(var_9);
    waitframe();
  }
}

can_see_farah_watcher() {
  level endon("wave_3_inside");

  for(;;) {
    var_0 = level.player getEye();
    var_1 = level.farah.origin + (0, 0, 30);
    var_2 = sighttracepassed(var_0, var_1, 0, level.player, 1);

    if(var_2) {
      break;
    } else
      wait 0.1;
  }

  scripts\engine\utility::flag_set("wave_3_inside");
}

triage_ammo_nag() {
  scripts\engine\utility::flag_wait("triage_idle");

  if(!scripts\engine\utility::flag("wave_3_inside"))
    level thread scripts\engine\utility::add_dialogue_line("Price", "Kyle, get in here and resupply.", "purple");
}

triage_end_fadeout_waiting() {
  wait 4.5;
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 1.2);
}

triage_start_watcher() {
  var_0 = getEnt("triage_trigger", "targetname");
  var_1 = level.price;
  var_2 = 0.70701;
  var_3 = 200;

  for(;;) {
    if(level.player istouching(var_0) && distance2d(level.price.origin, level.player.origin) < 200) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("triage_start");
}

defend_wave_3_triage_catchup() {
  var_0 = getEntArray("triage_loot", "targetname");
  scripts\engine\utility::array_call(var_0, ::hide);
  var_1 = getEntArray("rooftop_loot", "targetname");
  scripts\engine\utility::array_call(var_1, ::hide);
  scripts\engine\utility::exploder("field_fires");
  scripts\engine\utility::flag_set("custom_cooldown");
  scripts\engine\utility::flag_set("price_triage_objective");
  scripts\engine\utility::flag_set("wave_3_inside");
  scripts\engine\utility::flag_set("building_combat_objective");
  scripts\engine\utility::flag_set("green_beam_shown");
  scripts\engine\utility::flag_set("green_beam_acquired");
  thread traversal_nav_obstacle();
}

defend_wave_3_buildings_start() {
  scripts\engine\utility::flag_set("drag_scene_complete");
  scripts\engine\utility::flag_set("enable_ilumination_flares");
  scripts\engine\utility::flag_set("sniper_roof_start");
  scripts\engine\utility::flag_set("wave_3_inside");
  scripts\engine\utility::flag_set("ladder_up");
  defend_inits();
  squad_init();
  scripts\engine\sp\utility::set_start_location("defend_start", [level.greeter_marine, level.fsa_02, level.alex, level.hadir]);
  scripts\engine\sp\utility::set_start_location("defend_wave_4_start", [level.player, level.price, level.farah]);
  level.ally_04 delete();
  level.ally_03 delete();
  level.greeter_marine scripts\engine\sp\utility::clear_force_color();
  level.fsa_02 scripts\engine\sp\utility::clear_force_color();
  level.support_mortar_tube.angles = level.support_mortar_tube.angles + (0, 120, 0);
  scripts\engine\sp\utility::activate_trigger("wave_3_roof_color", "targetname");
  scripts\engine\utility::flag_set("allow_green_beam");
  scripts\engine\utility::flag_set("custom_cooldown");
}

defend_wave_3_buildings_main() {
  if(scripts\sp\starts::is_after_start("triage_scene"))
    waitframe();

  thread scripts\engine\sp\utility::battlechatter_on("allies");
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  thread dialogue_rooftops_wave_3_building();
  thread scaffolding_combat();
  thread rpg_playerrepulsor();
  var_0 = getaiarray("allies");
  scripts\engine\utility::trigger_on("wave_3_ladder", "targetname");
  scripts\engine\utility::trigger_on("building_a_roof_trigger", "targetname");
  scripts\engine\utility::flag_set("enable_ilumination_flares");
  scripts\engine\utility::trigger_on("building_a_roof_trigger", "targetname");
  scripts\engine\utility::trigger_on("wave_3_ladder", "targetname");
  scripts\engine\sp\utility::activate_trigger("wave_3_roof_color", "targetname");
  setaudiotriggerstate("combat_zone", "combat_lvl1", 5);
  setaudiotriggerstate("default", "combat_lvl1", 5);
  scripts\engine\utility::flag_wait("wave_3_inside");
  scripts\engine\utility::flag_wait("ladder_up");
  level.farah scripts\engine\sp\utility::clear_force_color();
  level.farah scripts\engine\sp\utility::enable_ai_color();
  level.farah scripts\engine\sp\utility::set_force_color("o");
  scripts\engine\sp\utility::activate_trigger("wave_3_roof_color", "targetname");
  thread friendly_flare_sender_loop("flare_north");
  scripts\engine\sp\utility::trigger_wait("wave_3_ladder", "targetname");
  thread defend_wave_3_ladder_vo();
  var_1 = getaiarray("allies");
  var_2 = [level.price, level.farah, level.alex, level.hadir];

  foreach(var_4 in var_1) {
    var_4.fixednode = 0;
    var_4 scripts\engine\sp\utility::clear_force_color();
    var_4 scripts\engine\sp\utility::set_goal_radius(400);
    var_4 setgoalpos((-276.5, 422.5, 152));
    var_4.goalheight = 72;
  }

  scripts\engine\sp\utility::activate_trigger("wave_3_roof_color", "targetname");
  var_6 = spawnStruct();
  var_6.origin = (63, 1090, 300);
  var_7 = cos(20);
  scripts\engine\sp\utility::trigger_wait("building_a_roof_trigger", "targetname");
  thread ally_equipment_watcher();
  scripts\engine\utility::flag_set("cleanup_triage_room");
  thread triage_door_close();
  thread remove_green_beam();
  thread scripts\engine\utility::flag_set_delayed("player_looking_at_buildings", 4);

  for(;;) {
    if(scripts\engine\utility::flag("player_looking_at_buildings")) {
      break;
    }

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_6.origin, var_7)) {
      break;
    } else
      wait 0.1;
  }

  scripts\engine\utility::flag_set("player_looking_at_buildings");
  scripts\engine\sp\utility::autosave_by_name("roof_support");
  wait 2;
  var_0 = getaiarray("allies");

  foreach(var_4 in var_0)
  var_4.ignoreall = 0;

  scripts\engine\utility::flag_wait("wave_3_mid_end");
  scripts\engine\sp\utility::autosave_by_name("building_destroyed");
  thread player_looking_away_from_mayhem_watcher();
  scripts\engine\utility::flag_set("wave_3_end");
}

defend_wave_3_ladder_vo() {
  level thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_uavoperator_defend_greenbeam1_10");
  level.price thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_greenbeam1_20");
}

ally_equipment_watcher() {
  level.player endon("death");

  for(;;) {
    var_0 = level.player getammocount(getcompleteweaponname("flash"));

    if(var_0 < 2) {
      break;
    }

    wait 0.5;
  }

  level.hadir.support_equipment = 3;
  level.player notify("ally_equipment_notify");
  level.player.ally_equipment_force_ping = 1;
}

scaffolding_combat() {
  level.scaffolding_choice = undefined;
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = scripts\engine\sp\utility::array_spawn_targetname("guard_rails_guys", 1);

  foreach(var_5 in var_3)
  var_5 scripts\engine\sp\utility::set_goal_radius(64);

  var_1 = scripts\engine\sp\utility::array_spawn_targetname("scaffolding_c_guys", 1);
  scripts\engine\utility::array_thread(var_1, ::backup_nodes);
  thread scaffolding_mayhem("scaffolding_c_clip", "scaffolding_c_trigger", "scaffolding_c", "scaffolding_c_guys");
  thread scaffolding_mayhem("scaffolding_b_clip", "scaffolding_b_trigger", "scaffolding_b", "scaffolding_b_guys");
  thread scaffolding_mayhem("scaffolding_a_clip", "scaffolding_a_trigger", "scaffolding_a", "scaffolding_a_guys");
  var_7 = spawnStruct();
  var_7.origin = (63, 1090, 300);
  var_8 = cos(20);

  for(;;) {
    if(scripts\engine\utility::flag("player_looking_at_buildings") || scripts\engine\utility::flag("wave_3_ladder")) {
      break;
    }

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_7.origin, var_8)) {
      break;
    } else
      wait 0.1;
  }

  scripts\engine\utility::flag_set("player_looking_at_buildings");
  wait 6;
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("scaffolding_b_guys", 1);
  scripts\engine\utility::array_thread(var_0, ::backup_nodes);
  wait 7;
  var_2 = scripts\engine\sp\utility::array_spawn_targetname("scaffolding_a_guys", 1);
  scripts\engine\utility::array_thread(var_2, ::backup_nodes);
  var_9 = scripts\engine\utility::array_combine(var_2, var_0, var_1);
  var_9 = scripts\sp\maps\embassy\embassy_util.gsc::array_removedeaddyingorundefined(var_9);
  var_10 = scripts\engine\utility::getStruct("scaffolding_d_struct", "targetname");
  enemy_alive_counter_gate(3);
  var_11 = getspawner("scaffolding_d_guys", "targetname");
  var_12 = [];

  for(var_13 = 0; var_13 < 3; var_13++) {
    var_5 = var_11 scripts\engine\sp\utility::spawn_ai(1);
    var_5 scripts\engine\sp\utility::set_goal_radius(375);
    var_5.goalheight = 10;
    var_5.ignoresuppression = 1;
    var_5.attackeraccuracy = 0.1;
    var_5 setgoalpos(var_10.origin);
    var_12[var_12.size] = var_5;
    var_11.count = 1;
    wait 0.5;
  }

  var_9 = scripts\engine\utility::array_combine(var_9, var_3, var_12);
  var_9 = scripts\sp\maps\embassy\embassy_util.gsc::array_removedeaddyingorundefined(var_9);
  thread enemies_alive_watcher(var_9, "wave_3_mid_end");
}

backup_nodes() {
  self endon("death");
  scripts\engine\utility::waittill_any("bad_path", "path_blocked");
  self.target = undefined;
  scripts\engine\sp\utility::set_goal_radius(1000);
  self setgoalpos(self.origin);
  self.ignoreall = 1;
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
}

rpg_playerrepulsor() {
  var_0 = missile_createrepulsorent(level.player, 400, 1500);
  scripts\engine\sp\utility::trigger_wait("building_a_roof_trigger", "targetname");
  var_0 = missile_createrepulsorent(level.player, 600, 2000);
  scripts\engine\utility::flag_wait("wave_3_end");
  missile_deleteattractor(var_0);
}

scaffolding_mayhem(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_0, "targetname");
  var_4.trigger = getEnt(var_1, "targetname");
  var_4 setCanDamage(1);
  var_5 = undefined;
  var_6 = 1;

  while(!var_4.trigger istouching(level.rocket_tag) && !scripts\engine\utility::flag("mayhem_done"))
    waitframe();

  thread sfx_scaffolding_mayhem(var_2, var_4);
  playmayhem(var_2);
  playmayhem(var_2 + "_tarps");
  var_4 notsolid();
  var_4 disconnectPaths();

  if(isDefined(var_3)) {
    var_3 = getEntArray(var_3, "targetname");

    foreach(var_8 in var_3) {
      if(isalive(var_8)) {
        var_8.forceragdollimmediate = 1;
        var_8 kill();
      }
    }
  }

  scripts\engine\utility::flag_wait("hide_mayhem");
  hidemayhem(var_2);
  hidemayhem(var_2 + "_tarps");
}

sfx_scaffolding_mayhem(var_0, var_1) {
  if(var_0 == "scaffolding_a")
    thread scripts\engine\utility::play_sound_in_space("mayhem_emb_laser_bldng_mayhem_right", var_1.origin);
  else if(var_0 == "scaffolding_b")
    thread scripts\engine\utility::play_sound_in_space("mayhem_emb_laser_bldng_mayhem_middle", var_1.origin);
  else if(var_0 == "scaffolding_c")
    thread scripts\engine\utility::play_sound_in_space("mayhem_emb_laser_bldng_mayhem_left", var_1.origin);
}

scaffolding_rocket_watcher(var_0) {
  thread embassy_technicals(var_0);
  self waittill("explode", var_1);
  thread embassy_palm_trees(var_0);
  wait 0.1;
  level.rocket_tag dontinterpolate();
  level.rocket_tag.origin = var_1;
  var_2 = getEntArray("building_rails", "targetname");
  scripts\engine\utility::array_thread(var_2, ::building_rails_destroy, level.rocket_tag.origin);
}

building_rails_destroy(var_0) {
  if(120 > distance(self.origin, var_0))
    self delete();
}

embassy_technicals(var_0) {
  if(isDefined(level.technicals) && level.technicals.size != 0) {
    foreach(var_2 in level.technicals) {
      if(isDefined(var_2)) {
        var_3 = distance(var_2.origin, var_0);

        if(var_3 < 800) {
          if(scripts\engine\utility::flag_exist("fire_rocket_at_technical")) {
            scripts\engine\utility::flag_set("fire_rocket_at_technical");
            wait 1;
            scripts\engine\utility::flag_clear("fire_rocket_at_technical");
          }
        }
      }
    }
  }
}

enemies_alive_watcher(var_0, var_1) {
  while(var_0.size > 0) {
    var_0 = scripts\sp\maps\embassy\embassy_util.gsc::array_removedeaddyingorundefined(var_0);
    wait 0.1;
  }

  if(isDefined(var_1))
    scripts\engine\utility::flag_set(var_1);
}

defend_wave_3_buildings_catchup() {
  if(isDefined(level.hadir))
    thread ally_equipment_watcher();
}

defend_wave_4_targeting_start() {
  defend_inits();
  squad_init();
  scripts\engine\utility::flag_set("wave_3_end");
  scripts\engine\utility::flag_set("wave_3_mid_end");
  scripts\engine\utility::flag_set("targeting_laser_acquired");
  scripts\engine\sp\utility::set_start_location("defend_wave_4_start", [level.greeter_marine, level.fsa_02, level.player, level.price, level.farah, level.alex]);
  scripts\engine\sp\utility::set_start_location("defend_wave_5_start", [level.player]);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.hadir]);
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0)
  var_2 scripts\engine\sp\utility::clear_force_color();

  setaudiotriggerstate("combat_zone", "combat_lvl0", 0.1);
  setaudiotriggerstate("default", "combat_lvl0", 0.1);
  thread remove_green_beam();
  scripts\engine\utility::flag_set("allow_green_beam");
  scripts\engine\utility::flag_set("mayhem_done");
  scripts\engine\utility::flag_set("hide_mayhem");
  thread scaffolding_mayhem("scaffolding_c_clip", "scaffolding_c_trigger", "scaffolding_c");
  thread scaffolding_mayhem("scaffolding_b_clip", "scaffolding_b_trigger", "scaffolding_b");
  thread scaffolding_mayhem("scaffolding_a_clip", "scaffolding_a_trigger", "scaffolding_a");
}

defend_wave_4_targeting_main() {
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::mortar_building_attack_lighting(4);
  thread scripts\engine\sp\utility::battlechatter_off("allies");
  scripts\engine\utility::flag_wait("wave_3_end");
  scripts\engine\sp\utility::autosave_by_name("wave_4_street");
  drone_nags_disable();
  setaudiotriggerstate("combat_zone", "combat_lvl0", 1);
  setaudiotriggerstate("default", "combat_lvl0", 1);
  thread dialogue_rooftops_wave_4();
  level.price thread scripts\engine\sp\utility::name_hide();

  if(!isDefined(level.price.og_name))
    level.price.og_name = "Price";

  level.price thread scripts\engine\sp\utility::name_show();
  level.front_goal_vol = getEnt("exterior_north_vol", "targetname");
  var_0 = getaiarray("allies");
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  level waittill("move_east");

  foreach(var_2 in var_0) {
    var_2 scripts\engine\sp\utility::clear_force_color();
    var_2 scripts\engine\sp\utility::set_force_color("b");
  }

  thread civ_car();
  scripts\engine\utility::flag_wait("civ_car_spawn");
  level waittill("civ_car_gone");
}

defend_wave_4_targeting_catchup() {}

defend_wave_4_technicles_start() {
  defend_inits();
  squad_init();
  scripts\engine\utility::flag_set("wave_3_inside");
  scripts\engine\utility::flag_set("wave_3_end");
  scripts\engine\utility::flag_set("wave_3_mid_end");
  scripts\engine\utility::flag_set("targeting_laser_acquired");
  scripts\engine\sp\utility::set_start_location("defend_wave_4_start", [level.greeter_marine, level.fsa_02, level.player, level.price, level.farah, level.alex]);
  scripts\engine\sp\utility::set_start_location("defend_wave_5_start", [level.player]);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.hadir]);
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0)
  var_2 scripts\engine\sp\utility::clear_force_color();

  thread dialogue_rooftops_wave_3_building();
  setaudiotriggerstate("combat_zone", "combat_lvl0", 0.1);
  setaudiotriggerstate("default", "combat_lvl0", 0.1);
  thread remove_green_beam();
  scripts\engine\utility::flag_set("allow_green_beam");
  scripts\engine\utility::flag_set("mayhem_done");
  scripts\engine\utility::flag_set("hide_mayhem");
  thread scaffolding_mayhem("scaffolding_c_clip", "scaffolding_c_trigger", "scaffolding_c");
  thread scaffolding_mayhem("scaffolding_b_clip", "scaffolding_b_trigger", "scaffolding_b");
  thread scaffolding_mayhem("scaffolding_a_clip", "scaffolding_a_trigger", "scaffolding_a");
}

defend_wave_4_technicles_main() {
  setsaveddvar("NQNQPRLRQM", 0.15);
  visionsetnaked("embassy_field_brighter", 3);
  level.player scripts\sp\utility::set_player_attacker_accuracy(0.5);
  thread dialogue_rooftops_wave_4_technicals();
  level waittill("drone_callout");
  thread scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\sp\utility::autosave_by_name("drone_callout");
  var_0 = getaiarray("allies");
  var_1 = [level.price, level.farah, level.alex, level.hadir];

  foreach(var_3 in var_0) {
    var_3.fixednode = 0;
    var_3 scripts\engine\sp\utility::clear_force_color();
    var_3 scripts\engine\sp\utility::set_goal_radius(400);
    var_3 setgoalpos((-276.5, 422.5, 152));
    var_3.goalheight = 72;
  }

  level.technical_02 = undefined;
  thread achievement_watcher();
  thread wave_4_technical_02();

  while(!isDefined(level.technical_02))
    waitframe();

  wait 1;
  var_5 = gettime();
  var_6 = scripts\engine\sp\utility::getvehiclearray();

  while(var_6.size > 0 && var_5 + 10000 > gettime()) {
    var_6 = scripts\engine\sp\utility::getvehiclearray();
    wait 0.1;
  }

  thread wave_4_technical_03();
  wait 1;

  while(var_6.size > 0 && var_5 + 12000 > gettime()) {
    var_6 = scripts\engine\sp\utility::getvehiclearray();
    wait 0.1;
  }

  scripts\engine\sp\utility::autosave_by_name("streets_guys");
  thread spawn_street_guys();
  wait 0.5;
  scripts\engine\utility::delaythread(12, ::wave_4_technical_10);
  player_looking_down_street_watcher();
  wait 5;
  thread audio_defend_4_zone_state();
  enemy_alive_counter_gate(2);
  scripts\engine\sp\utility::autosave_by_name("last_technical");
  thread wave_4_technical_09();
  scripts\engine\utility::flag_set("wave_4_final_technical_spawn");
  scripts\engine\utility::delaythread(6, scripts\engine\sp\utility::array_spawn_targetname, "wave_4_corner_guys", 1);
  wait 1;
  scripts\engine\utility::flag_wait("beam_technical_guys_killed");
  scripts\engine\utility::flag_wait("corner_guys_spawned");
  enemy_alive_counter_gate(3);
  var_7 = getaiarray("axis");

  foreach(var_3 in var_7) {
    var_3 notify("clear_spawn_func_logic");
    waitframe();
    var_3.ignoreall = 0;
    var_3.attackeraccuracy = 1;
    var_3 scripts\common\utility::demeanor_override("combat");
    var_3 scripts\engine\utility::set_movement_speed(220);
    var_3 setgoalpos((-48, -371, 80));
    var_3 scripts\engine\sp\utility::set_goal_radius(400);

    if(distance(var_3.origin, level.player.origin) > 2500)
      var_3 kill();
  }

  enemy_alive_counter_gate(0);
  level.player scripts\sp\utility::set_player_attacker_accuracy(1);
  scripts\engine\utility::flag_set("wave_4_end");
  scripts\engine\sp\utility::autosave_by_name("wave_4_complete");
  scripts\engine\utility::flag_wait("wave_4_dialogue_complete");

  if(scripts\sp\maps\embassy\embassy_util.gsc::green_beam_swap_hint_check())
    scripts\engine\sp\utility::display_hint("green_beam_check");

  setsaveddvar("NQNQPRLRQM", 1);
}

achievement_watcher() {
  level endon("technical_achievement_fail");
  level endon("wave_4_dialogue_complete");
  scripts\engine\utility::flag_wait("wave_4_final_technical_spawn");
  wait 0.1;

  while(isDefined(level.technical_09.health) && level.technical_09.health >= 1)
    wait 0.15;

  thread scripts\sp\utility::giveachievement_wrapper("lovefromabove");
}

audio_defend_4_zone_state() {
  setaudiotriggerstate("combat_zone", "combat_lvl1", 2);
  setaudiotriggerstate("default", "combat_lvl1", 2);
  wait 8;
  setaudiotriggerstate("combat_zone", "combat_lvl2", 2);
  setaudiotriggerstate("default", "combat_lvl2", 2);
  wait 18;
  setaudiotriggerstate("combat_zone", "combat_lvl1", 2);
  setaudiotriggerstate("default", "combat_lvl1", 2);
  scripts\engine\utility::flag_wait("wave_4_end");
  setaudiotriggerstate("combat_zone", "combat_lvl0", 2);
  setaudiotriggerstate("default", "combat_lvl0", 2);
}

defend_wave_4_technicles_catchup() {
  scripts\engine\utility::flag_set("wave_4_end");

  if(!scripts\sp\starts::is_after_start("laser_targeting_2")) {
    scripts\engine\utility::flag_set("allow_green_beam");
    level endon("allow_green_beam");
    childthread vo_beam_confirms();
    childthread vo_beam_hit();
    childthread vo_beam_ally_close();
    childthread vo_beam_nomark();
    childthread vo_beam_negative();
    childthread vo_beam_cooldown();
  }
}

civ_car() {
  var_0 = spawnStruct();
  var_0.origin = (4140, 896, 24);
  var_1 = 0.93969;
  var_2 = gettime();
  var_3 = 8000;

  for(;;) {
    if(gettime() > var_2 + var_3 || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_1)) {
      break;
    } else
      wait 0.1;
  }

  level.civ_car = scripts\common\vehicle::spawn_vehicle_from_targetname("civ_veh_spawner_01");
  level.civ_car.maxhealth = 21000;
  level.civ_car.health = 21000;
  level.civ_car.regenerate = 0;
  level.civ_car thread swapped_car();
  level notify("civ_car_spawn");
  scripts\engine\utility::flag_set("civ_car_spawn");
  var_4 = scripts\engine\sp\utility::spawn_targetname("civ_driver", 1);
  var_4.animname = "civ_driver";
  var_4.ignoreme = 1;
  var_4.allowdeath = 1;
  var_4 scripts\common\utility::lookatentity(level.player);
  var_5 = scripts\engine\utility::spawn_tag_origin(level.civ_car gettagorigin("TAG_DRIVER"), level.civ_car gettagangles("TAG_DRIVER"));
  var_5.origin = var_5.origin + (10, 0, -5);
  var_5 linkTo(level.civ_car, "TAG_DRIVER");
  var_4 linkTo(level.civ_car, "TAG_DRIVER");
  var_4.no_friendly_fire_fail = 1;
  var_5 thread scripts\common\anim::anim_loop_solo(var_4, "driver_idle", "stop_loop");
  var_4 scripts\engine\sp\utility::set_deathanim("driver_death");
  level.civ_car thread vehicle_death_watcher(var_4);
  level.civ_car thread vehicle_whizby_watcher(var_4, "scn_embassy_civ_car_dist_speed_away_03");
  var_4 thread driver_death_watcher();
  var_6 = getvehiclenode("civ_veh_start_01", "targetname");
  level.civ_car scripts\common\vehicle::attach_vehicle_and_gopath(var_6);
  playFXOnTag(scripts\engine\utility::getfx("vfx_embassy_car_headlight_truck_l"), level.civ_car, "tag_light_front_left");
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_embassy_car_headlight_truck_r"), level.civ_car, "tag_light_front_right");
  waitframe();
  thread vo_unkown_car(var_4);
  thread sfx_unknown_car();
  wait 1;
  level.civ_car.regenerate = 0;
  level.civ_car endon("death");
  level.civ_car endon("driver_death");

  while(level.civ_car.veh_speed)
    wait 0.1;

  var_4 delete();
  level.civ_car delete();
  var_5 delete();
  level notify("civ_car_gone");
  level notify("civ_car_escaped");
}

swapped_car() {
  self endon("entitydeleted");
  level.colmaps = [];
  level.colmaps = getEntArray("collmap_scriptable", "classname");
  var_0 = undefined;

  foreach(var_2 in level.colmaps) {
    if(scripts\engine\utility::is_equal(var_2.targetname, "veh8_civ_lnd_walfa")) {
      var_0 = var_2;
      break;
    }
  }

  self.new_col_map = spawn("script_model", (0, 0, 0));
  self.new_col_map clonebrushmodeltoscriptmodel(var_0);
  self.new_col_map hide();
  self.new_col_map.angles = self.angles;
  self.new_col_map.origin = self.origin;
  self.new_col_map linkTo(self);
  self waittill("death");
  self.new_col_map show();
  var_4 = createnavbadplacebyent(self.new_col_map, "axis", "allies");
}

vo_unkown_car(var_0) {
  level endon("wave_4_technicals");
  level endon("civ_car_escaped");
  var_1 = level.civ_car scripts\engine\utility::waittill_any_return("death", "driver_death", "damage");

  if(var_1 == "damage") {
    wait 0.4;

    if(isDefined(level.civ_car) && isalive(var_0) && level.civ_car.health > 0)
      level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_civcar_62");
  }

  if(isDefined(level.civ_car) && isalive(var_0) && level.civ_car.health > 0)
    level.civ_car scripts\engine\utility::waittill_any_return("death", "driver_death");

  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_civcar_61");
}

driver_death_watcher() {
  level endon("civ_car_gone");
  self waittill("death");
  wait 0.1;

  if(scripts\engine\utility::flag("civ_car_death")) {
    return;
  }
  if(isDefined(level.civ_car)) {
    level.civ_car notify("driver_death");
    level.civ_car vehicle_setspeed(0, 10, 20);
    level.civ_car_death_spot = self.origin;
    level notify("civ_car_gone");
  }
}

fake_headlights() {}

sfx_unknown_car() {
  level.civ_car vehicle_turnengineoff();
  var_0 = spawn("script_origin", level.civ_car.origin);
  var_0 linkTo(level.civ_car);
  var_0 playSound("scn_embassy_civ_car_unknown");
  level.civ_car scripts\engine\utility::waittill_any("death", "civ_car_gone", "damage");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(0.1);
}

sfx_technical_drive_in(var_0, var_1) {
  var_0 vehicle_turnengineoff();
  var_2 = spawn("script_origin", var_0.origin);
  var_2 linkTo(var_0);
  var_2 playSound(var_1);
  var_0 waittill("death");
  var_2 scripts\engine\sp\utility::sound_fade_and_delete(0.1);
}

vehicle_whizby_watcher(var_0, var_1) {
  self waittill("damage");
  self stopsounds();
  thread scripts\engine\utility::playsoundontag("scn_embassy_civ_car_bullet_impt", "tag_origin", 1);

  if(isalive(var_0)) {
    if(isDefined(var_1) && soundexists(var_1))
      self playSound(var_1);

    self vehicle_setspeed(40, 5);
  }
}

vehicle_death_watcher(var_0) {
  level endon("civ_car_gone");
  self waittill("death");
  level.civ_car_death_spot = self.origin;
  scripts\engine\utility::flag_set("civ_car_death");

  if(isDefined(var_0))
    var_0 kill();

  level notify("civ_car_gone");
}

truck_street_death_watcher(var_0) {
  level endon("wave_4_end");
  self waittill("death");
  level.truck_death_spot = self.origin;
}

defend_wave_4_snipers_start() {
  defend_inits();
  squad_init();
  scripts\engine\sp\utility::set_start_location("defend_wave_4_start", [level.price, level.farah]);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.greeter_marine, level.fsa_02, level.alex, level.hadir]);
  scripts\engine\sp\utility::set_start_location("defend_wave_5_start", [level.player]);
  level.price scripts\engine\sp\utility::clear_force_color();
  thread scripts\engine\sp\utility::battlechatter_on("allies");
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  scripts\engine\utility::flag_set("mayhem_done");
  scripts\engine\utility::flag_set("wave_4_end");
  thread scaffolding_mayhem("scaffolding_c_clip", "scaffolding_c_trigger", "scaffolding_c");
  thread scaffolding_mayhem("scaffolding_b_clip", "scaffolding_b_trigger", "scaffolding_b");
  thread scaffolding_mayhem("scaffolding_a_clip", "scaffolding_a_trigger", "scaffolding_a");
  level.support_mortar_tube.angles = level.support_mortar_tube.angles + (0, 120, 0);
}

defend_wave_4_snipers_main() {
  thread scene_sniper_roof();
  var_0 = [level.price, level.farah, level.alex, level.hadir];

  foreach(var_2 in var_0) {
    var_2.fixednode = 0;
    var_2 scripts\engine\sp\utility::clear_force_color();
    var_2 scripts\engine\sp\utility::set_goal_radius(400);
    var_2 setgoalpos((-276.5, 422.5, 152));
    var_2.goalheight = 72;
  }

  level waittill("scene_sniper_roof");
  wait 2;
  var_4 = scripts\engine\sp\utility::array_spawn_targetname("building_snipers", 1);

  foreach(var_2 in var_4) {
    var_2.attackeraccuracy = 0.1;
    var_2.ignoresuppression = 1;
    var_2 scripts\engine\sp\utility::set_favoriteenemy(level.player);
  }

  thread dialogue_wave_4_snipers();
  thread friendly_flare_sender_loop("flare_north");
  enemy_alive_counter_gate(1);
  var_2 = getaiarray("axis")[0];

  if(isalive(var_2))
    enemy_move_to_exposed(var_2);

  enemy_alive_counter_gate(0);
}

dialogue_wave_4_snipers() {
  level endon("wave_4_end");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_greenbeam1_80");
  wait 2.5;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_sniper_10");
  wait 4;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_sniper_40");
}

enemy_move_to_exposed(var_0) {
  var_0 endon("death");
  var_1 = getnodearray("sniper_exposed_nodes", "targetname");

  foreach(var_3 in var_1) {
    if(!isalive(var_0)) {
      break;
    }

    if(var_3.origin[2] > var_0.origin[2] + 30 || var_3.origin[2] < var_0.origin[2])
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
  }

  var_5 = sortbydistance(var_1, var_0.origin)[0];
  var_0 setgoalpos(var_5.origin);
  var_0 scripts\engine\sp\utility::set_goal_radius(32);
}

player_looking_down_street_watcher() {
  var_0 = 0.76604;
  var_1 = gettime();
  var_2 = 7000;
  var_3 = spawnStruct();
  var_3.origin = (4783, 775, 19);

  for(;;) {
    if(gettime() > var_1 + var_2 || level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_3.origin, var_0)) {
      break;
    } else
      waitframe();
  }

  scripts\engine\utility::flag_set("street_guys_run");
}

player_looking_away_from_mayhem_watcher() {
  var_0 = 0.76604;
  var_1 = gettime();
  var_2 = 15000;
  var_3 = spawnStruct();
  var_3.origin = (4783, 775, 19);

  for(;;) {
    if(gettime() > var_1 + var_2 || level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_3.origin, var_0)) {
      break;
    } else
      waitframe();
  }

  scripts\engine\utility::flag_set("hide_mayhem");
}

spawn_street_guys() {
  var_0 = scripts\engine\sp\utility::get_spawner_array("wave_4_street_guys", "script_noteworthy");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_1 > 4)
      wait 1.5;

    var_0[var_1] scripts\engine\sp\utility::spawn_ai(1);
  }
}

remove_green_beam() {
  scripts\engine\utility::flag_wait("wave_4_end");
  wait 3;
  scripts\sp\equipment\green_beam::disable_green_beam();
  level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_uavoperator_defend_greenbeam2_180");
  scripts\engine\utility::flag_set("wave_4_dialogue_complete");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_greenbeam2_190");
  level.hadir scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_had_defend_greenbeam2_200");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_greenbeam2_210");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_greenbeam2_220");
}

defend_wave_5_mortar_attack_start() {
  scripts\engine\utility::flag_set("wave_4_end");
  defend_inits();
  squad_init();
  scripts\engine\sp\utility::set_start_location("defend_wave_4_start", [level.price, level.farah, level.alex]);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.hadir]);
  scripts\engine\sp\utility::set_start_location("defend_wave_5_start", [level.player]);
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("b");
  scripts\engine\sp\utility::activate_trigger("wave_4_streets_color_trigger", "targetname");
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::mortar_building_attack_lighting();
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  thread palmtree_notify_delay();
}

palmtree_notify_delay() {
  wait 1;
  level notify("emb_palm_02_damaged");
}

defend_wave_5_mortar_attack_main() {
  thread load_compound_anims_end_transient();
  thread mortar_house_boost_interact_door();
  setaudiotriggerstate("combat_zone", "combat_lvl0", 0.1);
  setaudiotriggerstate("default", "combat_lvl0", 0.1);
  thread player_pushes_mortar_house_early();
  thread dialogue_rooftops_wave_5();
  scripts\engine\utility::flag_wait("wave_4_end");
  scripts\engine\utility::flag_clear("flare_loop_on");
  thread scripts\engine\sp\utility::battlechatter_off("allies");
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_goal_radius(400);
  level.hadir setgoalpos((-151.7, 336.3, 150));

  if(!scripts\engine\utility::flag("mortar_house_early"))
    wait 1;

  scripts\engine\sp\utility::autosave_by_name("wave_5_begin");
  thread wave_5_enemy_mortar();
  level waittill("mortar_impact");
  thread scripts\sp\maps\embassy\embassy_util.gsc::spawn_marines_wave_5();

  if(!scripts\engine\utility::flag("mortar_house_early"))
    wait 5;

  scripts\engine\sp\utility::autosave_by_name("attack_house");
  scripts\engine\sp\utility::activate_trigger("wave_4_streets_color_trigger", "targetname");
  thread audio_defend_5_zone_state();
  var_0 = getspawnerarray("wave_4_field_2");

  foreach(var_2 in var_0)
  var_2.count = 2;

  var_4 = scripts\engine\sp\utility::array_spawn_targetname("wave_4_field_2", 1);
  scripts\engine\sp\utility::array_spawn_targetname("wave_4_back", 1);
  wait 1;
  level.ally_05 scripts\common\ai::stop_magic_bullet_shield();
  level.ally_06 scripts\common\ai::stop_magic_bullet_shield();
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("b");
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("p");
  scripts\engine\utility::flag_set("mortar_run_started");
  thread mortar_house_boost();
  price_mortar_run();
  scripts\engine\utility::flag_set("wave_5_end");
}

audio_defend_5_zone_state() {
  wait 2;
  setaudiotriggerstate("combat_zone", "combat_lvl1", 3);
  setaudiotriggerstate("default", "combat_lvl1", 3);
  scripts\engine\sp\utility::trigger_wait("mortar_house_streets", "targetname");
  setaudiotriggerstate("combat_zone", "combat_lvl2", 2);
  setaudiotriggerstate("default", "combat_lvl2", 2);
  scripts\engine\utility::flag_wait("street_enemies_clear");
  setaudiotriggerstate("combat_zone", "combat_lvl0", 3);
  setaudiotriggerstate("default", "combat_lvl0", 3);
}

player_pushes_mortar_house_early() {
  level endon("mortar_impact");
  scripts\engine\sp\utility::trigger_wait("mortar_house_streets", "targetname");
  scripts\engine\utility::flag_set("mortar_house_early");
}

price_mortar_run() {
  thread mortar_enemies_temp_disable_molotovs();
  thread price_mortar_run_triggers_on(1);
  level.price.ignoreall = 0;
  scripts\engine\sp\utility::activate_trigger("price_mortar_run_trigger_01", "targetname");
  thread price_mortar_run_field_path();
  thread push_up_mortar_house();
  thread enemies_goal_player();
  scripts\engine\sp\utility::trigger_wait("mortar_house_grounds_trigger", "targetname");
  var_0 = getEnt("mortar_house_blue_gate_clip", "targetname");
  var_0 disconnectPaths();
  scripts\engine\sp\utility::autosave_by_name("mortar_house_street_save");
  thread kill_tree_light();
  level.mortar_window_guy = scripts\engine\sp\utility::spawn_targetname("mortar_window_guy", 1);
  scripts\engine\utility::flag_wait("mortar_house_street_save");
  scripts\engine\sp\utility::autosave_by_name("mortar_house_street_save");
  scripts\engine\utility::flag_wait("street_enemies_clear");
}

kill_tree_light() {
  var_0 = getEnt("tree_fire_light", "targetname");
  var_0 notify("stop_fire_flicker");
  wait 1;
  var_0 setlightintensity(0);
}

mortar_enemies_temp_disable_molotovs() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2.grenadeammo = 0;

  scripts\engine\sp\utility::trigger_wait_targetname("mortar_house_streets");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2.grenadeammo = 2;
}

enemies_goal_player() {
  scripts\engine\sp\utility::trigger_wait("mortar_house_streets", "targetname");
  scripts\engine\sp\utility::array_spawn_targetname("mortar_streets_backup", 1);
  var_0 = getaiarray("axis");
  var_0 = scripts\sp\maps\embassy\embassy_util.gsc::array_removedeaddyingorundefined(var_0);

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2.targetname, "mortar_team_2") || scripts\engine\utility::is_equal(var_2.targetname, "mortar_window_guy") || scripts\engine\utility::is_equal(var_2.targetname, "mortar_roof_defender")) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
      continue;
    }

    var_2 scripts\engine\sp\utility::set_goal_radius(1000);
    var_2 setgoalpos(var_2.origin);
    var_2 setgoalentity(level.player);
  }

  while(var_0.size > 0) {
    var_0 = scripts\sp\maps\embassy\embassy_util.gsc::array_removedeaddyingorundefined(var_0);
    wait 0.1;
  }

  scripts\engine\utility::flag_set("street_enemies_clear");
}

push_up_mortar_house() {
  var_0 = getEnt("price_mortar_run_trigger_02", "targetname");
  var_0 endon("trigger");
  wait 15;
  scripts\engine\sp\utility::activate_trigger("price_mortar_run_trigger_02", "targetname");
}

price_mortar_run_field_path() {
  level endon("mortar_house_perimeter");
  scripts\engine\sp\utility::trigger_wait("price_mortar_run_trigger_02_alt", "targetname");
  scripts\engine\utility::flag_set("mortar_house_field_path");
  var_0 = getaiarray("axis");
  var_1 = getEnt("exterior_north_vol_3", "targetname");

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::is_equal(var_3.targetname, "mortar_team_2")) {
      continue;
    }
    var_3 setgoalpos(var_3.origin);
    var_3 setgoalvolumeauto(var_1);
  }

  level.front_goal_vol = var_1;
}

defend_wave_5_mortar_attack_catchup() {
  scripts\engine\utility::flag_set("mortar_team_objective");
}

defend_wave_5_mortar_house_boost_start() {
  defend_inits();
  squad_init();
  thread price_mortar_run_triggers_on(1);
  scripts\engine\utility::flag_set("wave_4_end");
  scripts\engine\utility::flag_set("wave_5_end");
  scripts\engine\sp\utility::set_start_location("defend_wave_4_start", [level.farah, level.alex, level.price]);
  scripts\engine\sp\utility::set_start_location("defend_wave_5_boost_start", [level.player, level.hadir]);
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("b");
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("p");
  scripts\engine\utility::trigger_off("wave_5_mortar_house_exterior_trigger", "targetname");
  setaudiotriggerstate("combat_zone", "combat_lvl2", 0.1);
  setaudiotriggerstate("default", "combat_lvl2", 0.1);
  thread mortar_house_boost();
  scripts\engine\utility::flag_set("street_enemies_clear");
  thread mortar_house_boost_interact_door();
}

defend_wave_5_mortar_house_boost_main() {
  thread mortar_house_boost_vo();
  wait 0.5;
  level.mortar_house_guys = scripts\engine\sp\utility::array_spawn_targetname("mortar_house_guys", 1);

  foreach(var_1 in level.mortar_house_guys)
  var_1 setthreatbiasgroup("mortar_house_guys");

  var_3 = getaiarray("allies");
  var_3 = scripts\engine\utility::array_remove(var_3, level.hadir);

  foreach(var_1 in var_3)
  var_1 setthreatbiasgroup("ignore_mortar_house_guys");

  thread scripts\engine\sp\utility::ignoreeachother("ignore_mortar_house_guys", "mortar_house_guys");
  scripts\engine\sp\utility::autosave_by_name("mortar_house_approach");
  level waittill("boost_complete");
}

defend_wave_5_mortar_house_boost_catchup() {
  thread mortar_building_doors();
}

defend_wave_5_mortar_house_start() {
  defend_inits();
  squad_init();
  thread price_mortar_run_triggers_on(1);
  scripts\engine\utility::flag_set("wave_4_end");
  scripts\engine\utility::flag_set("wave_5_end");
  scripts\engine\sp\utility::set_start_location("defend_wave_4_start", [level.farah, level.alex, level.price]);
  scripts\engine\sp\utility::set_start_location("defend_wave_5_house_start", [level.player, level.hadir]);
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("b");
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("p");
  scripts\engine\sp\utility::array_spawn_targetname("mortar_house_guys");
  scripts\engine\utility::trigger_off("wave_5_mortar_house_exterior_trigger", "targetname");
  setaudiotriggerstate("combat_zone", "combat_lvl2", 0.1);
  setaudiotriggerstate("default", "combat_lvl2", 0.1);
  level.hadir.support_equipment_og = 2;
}

defend_wave_5_mortar_house_main() {
  thread mortar_house_vo();
  scripts\engine\utility::flag_wait("wave_5_end");
  thread mortar_house_fridge();
  level.hadir scripts\engine\sp\utility::clear_force_color();
  thread defend_mortar_house_favela();
  scripts\engine\sp\utility::activate_trigger("wave_6_return_color_trigger", "targetname");
  waitframe();
  scripts\engine\sp\utility::trigger_wait_targetname("mortar_living_room_trigger");
  thread field_ent_cleanup();
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("p");
  scripts\engine\sp\utility::activate_trigger("wave_6_return_color_trigger", "targetname");

  if(!isalive(level.mortar_window_guy)) {
    var_0 = getspawner("mortar_window_guy", "targetname");
    var_0.count = 1;
    level.mortar_window_guy = scripts\engine\sp\utility::spawn_targetname("mortar_window_guy", 1);
  }

  thread hallway_exploder_lookat();
  scripts\engine\sp\utility::trigger_wait("price_mortar_run_trigger_07", "targetname");
  scripts\engine\utility::flag_set("mortar_guy_breakout_watcher");
  thread player_leaves_house_early();
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.script_noteworthy, "mortar_team") || scripts\engine\utility::is_equal(var_3.targetname, "mortar_house_guys") || scripts\engine\utility::is_equal(var_3.targetname, "mortar_window_guy"))
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
  }

  scripts\engine\utility::array_call(var_1, ::delete);

  if(!scripts\engine\utility::flag("enemy_mortar_manned")) {
    thread wave_5_enemy_mortar_replacement();
    scripts\engine\utility::flag_waitopen("enemy_mortar_manned");
  }

  enemy_alive_counter_gate(0);
  scripts\engine\utility::flag_set("wave_5_house_end");
  var_5 = getEnt("mortar_roof_clip", "targetname");
  var_5 connectpaths();
  var_5 notsolid();
  scripts\engine\sp\utility::activate_trigger("price_mortar_run_trigger_08", "targetname");
  scripts\engine\sp\utility::autosave_by_name("mortar_house_cleared");
}

player_leaves_house_early() {
  level endon("wave_5_house_end");
  var_0 = getEnt("compound_technicals_go", "targetname");

  while(!level.player istouching(var_0))
    waitframe();

  if(!scripts\engine\utility::flag("wave_5_house_end")) {
    var_1 = getaiarray("axis");
    scripts\engine\sp\utility::array_kill(var_1);
  }
}

defend_mortar_house_favela() {
  var_0 = scripts\engine\utility::getStruct("mortar_house_favela_struct", "targetname");
  var_0.origin = var_0.origin + anglestoright(var_0.angles) * 2;
  var_1 = getEnt("favela_door", "targetname");
  var_1.clip = var_1 scripts\engine\utility::get_target_ent();
  var_1.clip linkTo(var_1);
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  level.favela_door = var_1;
  var_1.animname = "favela_door";
  var_1 scripts\engine\sp\utility::assign_animtree();
  var_2 = undefined;
  var_3 = getEntArray("mortar_house_guys", "targetname");

  foreach(var_5 in var_3) {
    if(scripts\engine\utility::is_equal(var_5.script_noteworthy, "favela"))
      var_2 = var_5;
  }

  var_2.animname = "generic";
  var_2.forceragdollimmediate = 1;
  var_2.allowdeath = 1;
  var_2 endon("death");
  var_1 scripts\common\anim::anim_first_frame_solo(var_2, "faveladoor_peak");
  favela_door_open(var_1, var_2);
  var_1.clip connectpaths();
}

favela_door_open(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("breakout");
  var_2 = var_0 scripts\engine\utility::getanim("faveladoor_peak");
  var_3 = getanimlength(var_2);
  var_1.target = undefined;
  var_4 = spawnStruct();
  var_4.origin = (2762, 2168, 169);
  var_4.angles = (0, 180, 0);
  var_1 scripts\engine\sp\utility::set_goal_radius(10);
  var_1 scripts\sp\utility::context_melee_allow(0);
  level scripts\engine\utility::waittill_any("hallway_lookat", "mortar_guy_breakout_watcher");
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "faveladoor_peak");
  var_1 thread favela_door_guy_anims(var_0, var_3, "faveladoor_peak");
  var_5 = scripts\engine\utility::getStruct("favela_grenade_struct", "targetname");
  var_6 = var_5.origin;
  var_7 = var_5.origin + (0, 0, 10) + anglesToForward(var_5.angles) * 220;
  var_1 thread magic_grenade_toss(1, var_6, var_7, 3, "semtex");
  var_1 thread favela_door_distance_check();
  var_0 thread favela_door_fastopen(var_3, var_1);
  wait(var_3);

  if(isalive(var_1) && !istrue(self.fast_open))
    var_1 scripts\engine\utility::waittill_any_timeout(2, "death");

  var_1 stopanimScripted();
  var_1 setgoalpos(var_1.origin);
  var_0 notify("stop_loop");
  var_1 notify("stop_loop");
  var_8 = 175;
  var_9 = distance2d(var_1.origin, level.player.origin);

  if(var_8 < var_9) {
    var_4 thread scripts\common\anim::anim_first_frame_solo(var_1, "faveladoor_fastopen");
    var_4 thread scripts\common\anim::anim_single_solo(var_1, "faveladoor_fastopen");
    waitframe();
    var_1 setanimtime(var_1 scripts\engine\utility::getanim("faveladoor_fastopen"), 0.5);
    var_1 waittillmatch("single anim", "end");
  }

  var_1 stopanimScripted();
  var_1 setgoalpos(var_1.origin);
}

favela_door_distance_check() {
  self endon("death");
  self.fast_open = 0;
  var_0 = 200;

  for(;;) {
    if(var_0 > distance2d(self.origin, level.player.origin)) {
      break;
    }

    waitframe();
  }

  self.fast_open = 1;
  waitframe();
  self notify("fast_open");
}

favela_door_fastopen(var_0, var_1) {
  var_2 = self;
  var_1 scripts\engine\utility::waittill_any_timeout(var_0, "death", "fast_open");

  if(isalive(var_1) && !istrue(self.fast_open))
    var_1 scripts\engine\utility::waittill_any_timeout(2, "death");

  var_2 notify("stop_loop");
  var_2 thread scripts\common\anim::anim_single_solo(var_2, "faveladoor_fastopen");
  var_2 playSound("scrpt_door_wood_heavy_bash_npc");
}

magic_grenade_toss(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(!isDefined(var_4))
    var_4 = "frag";

  wait(var_0);
  var_5 = magicgrenade(var_4, var_1, var_2, var_3);

  if(!isDefined(var_5)) {
    return;
  }
  self.threw_grenade = 1;
  var_5 endon("entitydeleted");

  if(var_4 == "molotov")
    level notify("molotov_fired");

  if(var_4 == "semtex")
    thread scripts\sp\equipment\semtex::semtexfiremain(var_5, var_3);

  if(var_4 == "molotov")
    thread scripts\sp\equipment\molotov::molotovfiremain(var_5);

  if(isDefined(var_3))
    var_5 thread beacon_fuse(var_3);
}

beacon_fuse(var_0) {
  waitframe();
  self setscriptablepartstate("state", "beacon", 1);
  self setscriptablepartstate("state", "beacon_ai", 0);
  wait(var_0);

  if(isDefined(self))
    self setscriptablepartstate("state", "destroy", 1);
}

favela_door_guy_anims(var_0, var_1, var_2) {
  self endon("death");
  var_0 scripts\common\anim::anim_single_solo(self, var_2);
}

field_ent_cleanup(var_0) {
  var_1 = getEnt("field_cleanup_vol", "targetname");

  if(isDefined(var_0))
    wait(var_0);

  var_2 = scripts\engine\sp\utility::getvehiclearray();
  scripts\engine\utility::array_delete(var_2);
  waitframe();
  var_3 = getEntArray("script_vehicle", "code_classname");
  var_4 = getEntArray("script_vehicle_corpse", "code_classname");
  var_5 = scripts\engine\utility::array_combine(var_3, var_4);
  scripts\engine\utility::array_thread(var_5, ::field_ent_cleanup_logic, var_1);
}

field_weapon_cleanup() {
  var_0 = getEnt("field_cleanup_vol", "targetname");
  var_1 = getweaponarray();

  foreach(var_3 in var_1) {
    if(var_3 istouching(var_0))
      var_3 delete();
  }
}

field_ent_cleanup_logic(var_0) {
  if(!isDefined(self.model)) {
    return;
  }
  if(self istouching(var_0)) {
    self notify("fire_extinguish");
    self notify("stop_all_death_fx");
    waitframe();

    if(isDefined(self)) {
      if(isDefined(self.new_col_map))
        self.new_col_map hide();

      self hide();
    }
  }
}

mortar_house_boost_vo() {
  level.player endon("death");
  wait 0.5;
  var_0 = ["dx_vom_had_defend_mortar_building_182", "dx_vom_had_defend_mortar_building_184", "dx_vom_had_defend_mortar_building_186", "dx_vom_had_defend_mortar_building_188"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  level.hadir scripts\sp\maps\embassy\embassy_util.gsc::nagtill("house_gate_interacted", var_1, 8);
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_mortar_building_190");
  var_0 = ["dx_vom_had_defend_mortar_building_192", "dx_vom_had_defend_mortar_building_194", "dx_vom_had_defend_mortar_building_196", "dx_vom_had_defend_mortar_building_198"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  level.hadir scripts\sp\maps\embassy\embassy_util.gsc::nagtill("boost_started", var_1, 6);
  wait 9;
  level.hadir scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_had_defend_mortar_building_200");
  wait 5;
  var_0 = ["dx_vom_had_defend_mortar_building_202", "dx_vom_had_defend_mortar_building_204", "dx_vom_had_defend_mortar_building_206"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  level.hadir scripts\sp\maps\embassy\embassy_util.gsc::nagtill("mortar_house_enter_save", var_1);
}

mortar_house_boost() {
  wait 0.1;
  var_0 = spawnStruct();
  var_0.origin = (2385, 1624, 24.803);
  var_0.angles = (0, 0, 0);
  var_1 = spawnStruct();
  var_1.origin = (2345, 1624, 24.803);
  var_1.angles = (0, 0, 0);
  var_2 = getspawner("boost_aq_spawner", "targetname");
  var_3 = spawnStruct();
  var_3.origin = var_2.origin + (0, 0, 50);
  var_3.angles = (0, 270, 0);
  var_4 = getEnt("mortar_door_right", "targetname");
  scripts\engine\utility::flag_wait("hadir_go_to_wall");
  scripts\engine\utility::flag_set("house_gate_interacted");
  scripts\engine\utility::flag_wait("street_enemies_clear");
  level.hadir.support_equipment_og = level.hadir.support_equipment;
  level.hadir.support_equipment = 0;
  level.hadir notify("remove_equipment");
  level.player.rig hide();
  var_1 scripts\common\anim::anim_first_frame_solo(level.player.rig, "mortar_boost");
  var_5 = 0;

  if(isDefined(level.truck_death_spot)) {
    if(level.truck_death_spot[0] > 2040 && level.truck_death_spot[0] < 20400)
      var_5 = 1;
  }

  if(!var_5)
    var_1 scripts\sp\anim::anim_reach_solo(level.hadir, "mortar_boost_enter");

  var_1 scripts\common\anim::anim_single_solo(level.hadir, "mortar_boost_enter");
  var_1 thread scripts\common\anim::anim_loop_solo(level.hadir, "mortar_boost_idle", "stop_loop");
  thread hadir_boost_nag(var_1);
  level.hadir scripts\sp\player\cursor_hint::create_cursor_hint("tag_accessory_left", undefined, &"EMBASSY/BOOST", 90, 500, 75, 0, 0, 0, undefined, "duration_none");
  level.hadir waittill("trigger");
  var_2 = scripts\engine\sp\utility::bodyonlyspawn(var_2);
  var_2.animname = "aq_1";
  var_2 notsolid();
  var_1 notify("stop_loop");
  level.hadir scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::flag_set("boost_started");
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::boost_moment_dof();
  var_1 thread scripts\sp\anim::anim_reach_solo(level.hadir, "mortar_boost");
  scripts\sp\maps\embassy\embassy_util.gsc::put_player_into_rig(level.player.rig, 0.75, 0, 0, 0, 0);
  var_1 thread scripts\common\anim::anim_single([level.hadir, level.player.rig], "mortar_boost");
  thread mortar_building_doors();
  thread mortar_door_magic_bullet(var_3);
  var_0 scripts\engine\utility::delaythread(7.9, scripts\common\anim::anim_single, [var_2], "mortar_boost");
  level.player.rig waittillmatch("single anim", "end");
  scripts\sp\maps\embassy\embassy_util.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  level.hadir stopanimScripted();
  level.hadir clearpath();
  var_6 = getnode("hadir_post_boost_node", "targetname");
  level.hadir forceteleport(var_6.origin);
  level.hadir scripts\engine\sp\utility::set_goal_radius(16);
  level.hadir setgoalpos(var_6.origin);
  can_see_hadir_watcher();
  level.hadir scripts\engine\utility::set_movement_speed(240);
  level notify("boost_complete");
}

mortar_house_boost_interact_door() {
  var_0 = getEntArray("mortar_door_left", "targetname");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::is_equal(var_3.script_noteworthy, "interactive_door"))
      level.boost_door = var_3;
  }

  level.boost_door waittill("trigger");
  scripts\engine\utility::flag_set("hadir_go_to_wall");
}

hadir_boost_nag(var_0) {
  level.hadir endon("trigger");

  for(;;) {
    wait 10;
    var_0 notify("stop_loop");
    var_0 scripts\common\anim::anim_single_solo(level.hadir, "mortar_boost_nag");
    var_0 thread scripts\common\anim::anim_loop_solo(level.hadir, "mortar_boost_idle", "stop_loop");
  }
}

can_see_hadir_watcher() {
  level endon("boost_complete");

  for(;;) {
    var_0 = level.player getEye();
    var_1 = level.hadir.origin + (0, 0, 30);
    var_2 = sighttracepassed(var_0, var_1, 0, level.player, 1);

    if(var_2) {
      break;
    } else
      waitframe();
  }
}

mortar_door_magic_bullet(var_0) {
  wait 7;
  var_1 = var_0.origin + anglesToForward(var_0.angles) * 50;
  var_2 = "iw8_ar_akilo47";

  for(var_3 = 0; var_3 < 5; var_3++) {
    magicbullet(var_2, var_0.origin, var_1 + (0, 1.5 * var_3, 2 * var_3));
    wait 0.15;
  }
}

mortar_building_doors(var_0, var_1) {
  var_0 = getEntArray("mortar_door_left", "targetname");
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(scripts\engine\utility::is_equal(var_4.script_noteworthy, "interactive_door"))
      level.boost_door = var_4;
  }

  var_1 = getEnt("mortar_door_right", "targetname");
  var_1.clip = var_1 scripts\engine\utility::get_target_ent();
  var_1.clip linkTo(var_1);
  var_2 = scripts\sp\door::get_interactive_door("mortar_door_left");
  var_2.open_left = 0;
  var_1 scripts\engine\utility::delaycall(7.7, ::rotateyaw, 110, 0.5);
  wait 7.7;
  var_2 thread scripts\sp\door::remove_open_ability();
  var_2 thread scripts\sp\door::door_open_completely();
  var_1.clip connectpaths();

  if(isDefined(var_2.navobstacle))
    destroynavobstacle(self.navobstacle);

  var_2.clip connectpaths();
}

mortar_house_vo() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("mortar_house_perimeter");
  wait 0.5;
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_mortar_interior_10");
  wait 0.4;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_mortar_interior_20");
  var_0 = getEntArray("mortar_house_guys", "targetname");
  wait_floor_clear(var_0);
  wait 0.3;
  scripts\sp\maps\embassy\embassy_util.gsc::wait_combat_cooldown(0.8, 4);
  var_1 = ["dx_vom_had_defend_mortar_interior_40", "dx_vom_had_defend_mortar_interior_50", "dx_vom_had_defend_mortar_interior_60", "dx_vom_had_defend_mortar_interior_70"];
  var_2 = scripts\engine\sp\utility::create_deck(var_1, 0);
  var_2.autoshuffle = 1;
  var_3 = getEnt("price_mortar_run_trigger_06", "targetname");
  level.hadir thread scripts\sp\maps\embassy\embassy_util.gsc::nagtill("player_at_stairs", var_2, 12);
  var_3 waittill("trigger");
  scripts\engine\utility::trigger_off("price_mortar_run_trigger_05", "targetname");
  scripts\engine\utility::trigger_off("price_mortar_run_trigger_04", "targetname");
  level notify("player_at_stairs");
}

wait_floor_clear(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = getaiarray("axis");

  var_1 = scripts\sp\maps\embassy\embassy_util.gsc::default_if_undefined(var_1, 0);
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(!isalive(var_4)) {
      continue;
    }
    if(abs(level.player.origin[2] - var_4.origin[2]) < 40)
      var_2++;
  }

  while(var_2 > var_1) {
    level waittill("ai_killed");
    var_2 = 0;

    foreach(var_4 in var_0) {
      if(!isalive(var_4)) {
        continue;
      }
      if(abs(level.player.origin[2] - var_4.origin[2]) < 40)
        var_2++;
    }
  }
}

mortar_house_fridge() {
  var_0 = spawnStruct();
  var_0.origin = (2686, 2115, 33);
  var_0.angles = (0, 0, 0);
  var_1 = getspawner("boost_aq_spawner", "targetname");
  var_1.count = 1;
  var_1 = scripts\engine\sp\utility::bodyonlyspawn(var_1);
  var_1.animname = "aq_1";
  var_1 scripts\common\ai::gun_remove();
  var_1 notsolid();
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_1, "fridge_takedown");
  var_2 = [];
  var_3 = getEnt("mortar_fridge_broom", "targetname");
  var_3 scripts\engine\sp\utility::assign_animtree("fridge_broom");
  var_3.animname = "fridge_broom";
  var_2[var_2.size] = var_3;
  var_4 = getEnt("mortar_fridge_bottom", "targetname");
  var_4 scripts\engine\sp\utility::assign_animtree("fridge_bottom");
  var_4.animname = "fridge_bottom";
  var_2[var_2.size] = var_4;
  var_5 = getEnt("mortar_fridge_top", "targetname");
  var_5 scripts\engine\sp\utility::assign_animtree("fridge_top");
  var_5.animname = "fridge_top";
  var_2[var_2.size] = var_5;
  var_6 = getEnt("mortar_fridge_body", "targetname");
  var_6 scripts\engine\sp\utility::assign_animtree("fridge_body");
  var_6.animname = "fridge_body";
  var_2[var_2.size] = var_6;
  var_7 = getEnt("mortar_fridge_entrance_door", "targetname");
  var_7.clip = var_7 scripts\engine\utility::get_target_ent();
  var_7.clip linkTo(var_7);
  var_7 scripts\engine\sp\utility::assign_animtree("fridge_door");
  var_7.animname = "fridge_door";
  var_2[var_2.size] = var_7;
  var_0 thread scripts\common\anim::anim_first_frame(var_2, "fridge_takedown");
  level.hadir scripts\engine\sp\utility::set_goal_radius(16);
  level.hadir.ignoreme = 1;
  var_0 scripts\sp\anim::anim_reach_solo(level.hadir, "fridge_takedown_enter");
  var_0 scripts\common\anim::anim_single_solo(level.hadir, "fridge_takedown_enter");
  scripts\engine\sp\utility::autosave_by_name("fridge_takedown");

  if(!scripts\engine\utility::flag("mortar_house_enter_save")) {
    var_0 thread scripts\common\anim::anim_loop_solo(level.hadir, "fridge_takedown_enter_idle", "stop_loop");
    scripts\engine\utility::flag_wait("mortar_house_enter_save");
    var_0 notify("stop_loop");
  }

  visionsetnaked("", 1);
  var_7.clip connectpaths();
  var_0 thread scripts\common\anim::anim_single([level.hadir, var_1], "fridge_takedown");
  var_0 thread scripts\common\anim::anim_single(var_2, "fridge_takedown");
  thread mortar_house_kitchen_lookat();
  thread scripts\engine\utility::flag_set_delayed("house_enter_low_delay", 5);
  wait(getanimlength(level.hadir scripts\engine\utility::getanim("fridge_takedown")) - 1.5);
  level.hadir scripts\engine\sp\utility::set_goal_radius(10);
  level.hadir setgoalpos(level.hadir.origin);
  level.hadir.ignoreme = 0;
  level.hadir thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_had_defend_mortar_interior_30");
  scripts\engine\sp\utility::trigger_wait_targetname("price_mortar_run_trigger_05");
  level.hadir.support_equipment = level.hadir.support_equipment_og;
  level.hadir scripts\engine\sp\utility::set_force_color("p");
}

mortar_house_kitchen_lookat() {
  var_0 = spawnStruct();
  var_0.origin = (2706, 2328, 100);
  var_1 = 0.64;
  var_2 = gettime();
  var_3 = 4000;

  while(!scripts\engine\utility::flag("house_enter_low_delay")) {
    var_4 = level.player getEye();
    var_5 = var_0.origin;
    var_6 = sighttracepassed(var_4, var_5, 0, level.player, 1);

    if(var_6 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_1)) {
      break;
    } else
      wait 0.1;
  }

  scripts\engine\utility::flag_set("house_enter_low_delay");
}

hallway_exploder_lookat() {
  var_0 = scripts\engine\utility::getStruct("mortar_house_lookat_struct", "targetname");
  var_0.origin = var_0.origin + (0, 100, 0);
  var_1 = 0.984808;
  var_2 = gettime();
  var_3 = 10000;

  for(;;) {
    var_4 = level.player getEye();
    var_5 = var_0.origin;
    var_6 = sighttracepassed(var_4, var_5, 0, level.player, 1);

    if(var_6 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_1)) {
      break;
    } else
      wait 0.1;
  }

  level notify("hallway_lookat");
  scripts\engine\utility::exploder("window_exp");
  wait 0.1;
  scripts\engine\utility::stop_exploder("mortar2_tree");
}

doorbust_guy_becomes_ai_if_alive() {
  self waittillmatch("single anim", "end");
  self setgoalpos(self.origin);
  self.goalradius = 20;
}

defend_wave_5_mortar_house_catchup() {
  scripts\engine\utility::flag_set("wave_5_house_end");
}

defend_wave_6_start() {
  defend_inits();
  squad_init();
  scripts\engine\utility::flag_set("wave_5_house_end");
  scripts\engine\sp\utility::set_start_location("defend_wave_6_house_end", [level.player, level.hadir]);
  scripts\engine\sp\utility::set_start_location("defend_wave_4_start", [level.farah, level.alex, level.price]);
  var_0 = getEnt("mortar_roof_clip", "targetname");
  var_0 connectpaths();
  var_0 notsolid();
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("b");
  thread kill_tree_light();
}

defend_wave_6_main() {
  setsaveddvar("NQNQPRLRQM", 0.2);
  level.farah scripts\engine\sp\utility::clear_force_color();
  level.farah scripts\engine\sp\utility::set_force_color("b");
  thread compound_technicals();
  var_0 = getEnt("residence_wall_gate", "targetname");
  var_0.clip = var_0 scripts\engine\utility::get_target_ent();
  var_0.clip linkTo(var_0);
  var_0 rotateYaw(-80, 1);
  var_0.clip connectpaths();
  scripts\engine\utility::flag_wait("wave_5_house_end");
  scripts\engine\utility::flag_set("residence_destroyed");
  var_1 = getEntArray("damaged_light", "targetname");

  foreach(var_3 in var_1)
  var_3 setlightintensity(0);

  thread dialogue_rooftops_wave_6();
  thread price_mortar_run_triggers_on(0);
  thread price_compound_run_triggers_on(1);
  thread residence_bodies();
  scripts\engine\utility::delaythread(2, ::price_mortar_roof_exit);
  scripts\engine\utility::delaythread(2, scripts\engine\sp\utility::activate_trigger, "wave_6_color_trigger", "targetname");
  thread price_and_player_ignored();
  var_5 = getaiarray("allies");

  foreach(var_7 in var_5)
  var_7 setthreatbiasgroup("allies");

  thread return_to_compound_objective();
  thread save_on_return_to_compound();
  scripts\engine\sp\utility::activate_trigger("price_compound_run_trigger_81", "targetname");
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_10");
  level.price.ignoreall = 0;
  thread audio_defend_6_zone_state();
  scripts\engine\utility::exploder("final_push");
  thread sfx_misc_field_expl();
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_12");
  level notify("kill_friendly_flares");
  level.alex scripts\engine\sp\utility::enable_ai_color();
  level.farah scripts\engine\sp\utility::enable_ai_color();
  scripts\engine\utility::flag_set("residence_return");
  scripts\engine\sp\utility::autosave_by_name("residence_return");
  scripts\engine\sp\utility::array_spawn_targetname("wave_6_residence_defenders", 1);
  var_9 = scripts\engine\sp\utility::spawn_targetname("wave_6_residence_defenders_roof", 1);

  if(isDefined(var_9))
    var_9 thread scripts\engine\sp\utility::set_favoriteenemy(level.farah);

  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_13");
  var_10 = getEntArray("damaged_residence", "targetname");
  scripts\engine\utility::array_call(var_10, ::show);
  var_11 = getEntArray("pristine_residence", "targetname");
  scripts\engine\utility::array_call(var_11, ::hide);
  thread car_bomb_event();
  level notify("car_bomb_zone_state");
}

sfx_misc_field_expl() {
  wait 10;
  var_0 = spawn("script_origin", (-580, -32, 15));
  var_0 playexplosionsound("scn_embassy_field_mortar_01", "exp");
  wait 0.6;
  var_1 = spawn("script_origin", (-732, -540, 15));
  var_1 playexplosionsound("scn_embassy_field_mortar_02", "exp");
}

audio_defend_6_zone_state() {
  setaudiotriggerstate("combat_zone", "combat_lvl1", 2);
  setaudiotriggerstate("default", "combat_lvl1", 2);
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_12");
  setaudiotriggerstate("combat_zone", "combat_lvl2", 5);
  setaudiotriggerstate("default", "combat_lvl2", 5);
  level waittill("car_bomb_zone_state");
  setaudiotriggerstate("combat_zone", "combat_lvl1", 2);
  setaudiotriggerstate("default", "combat_lvl1", 2);
}

compound_technicals() {
  scripts\engine\sp\utility::trigger_wait_targetname("compound_technicals_go");
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::compound_return_lighting(3);
  scripts\engine\utility::flag_set("player_leaving_mortar_house");
  scripts\engine\sp\utility::activate_trigger("price_compound_run_trigger_09", "targetname");
  scripts\engine\utility::stop_exploder("mortar4");
  scripts\engine\utility::delaythread(0.7, ::wave_6_technical_08);
  scripts\engine\utility::delaythread(0.7, ::wave_6_technical_04);
  scripts\engine\utility::delaythread(4, ::wave_6_technical_07);
  scripts\engine\utility::delaythread(3.5, ::wave_6_technical_05);
  scripts\engine\utility::delaythread(5, ::wave_6_technical_06);
  scripts\engine\sp\utility::autosave_by_name("wave_6_begin");
}

return_to_compound_objective() {}

price_mortar_roof_exit() {
  var_0 = scripts\engine\utility::getStruct("price_roof_exit_struct", "targetname");
  var_0.angles = (0, 0, 0);
  var_0 scripts\sp\anim::anim_reach_solo(level.hadir, "mortar_house_exit");
  var_0 scripts\common\anim::anim_single_solo(level.hadir, "mortar_house_exit");
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("p");
}

suicide_bomber() {
  setmusicstate("mx_embassy_palace");
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_14");
  level notify("spawned_suicide_bomber");
  var_0 = scripts\engine\sp\utility::spawn_targetname("suicide_bomber", 1);

  if(isDefined(var_0)) {
    var_0.attackeraccuracy = 0;
    var_0 detach(var_0.headmodel);
    var_0.headmodel = "head_sc_m_alameer_civ_bg_nohair";
    var_0 attach(var_0.headmodel);
    var_0 setModel("body_al_qatala_urban_civ_3_1");
    var_0.jetpackmodel = "al_qatala_urban_civ_bomb_vest";
    var_0 attach(var_0.jetpackmodel);
  }
}

car_bomb_event() {
  var_0 = scripts\engine\utility::getStruct("residence_explosion_struct", "targetname");
  var_1 = 0.984808;
  var_2 = gettime() + 8000;

  for(;;) {
    if(scripts\engine\utility::flag("wolf_escapes") || gettime() > var_2 || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_1)) {
      break;
    } else
      wait 0.1;
  }

  var_3 = spawnStruct();
  var_3.origin = (-2377, -1039, 20);
  magicgrenademanual("mortar", var_3.origin, (0, 0, 0), 0.05);
  scripts\engine\utility::exploder("car_bomb");
  thread sfx_car_bomb_expl(var_3.origin);
  earthquake(0.2, 1.5, level.player.origin, 400);
  playrumbleonposition("damage_heavy", level.player.origin);
  magicgrenademanual("mortar", var_3.origin, (0, 0, 0), 0.05);
}

sfx_car_bomb_expl(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playexplosionsound("scn_embassy_car_bomb_expl", "exp");
  wait 6;
  var_1 delete();
}

palm_tree_swap() {
  wait 0.2;
  scripts\engine\utility::flag_wait("wave_5_house_end");
  scripts\engine\utility::stop_exploder("mortar6_tree");
  var_0 = getscriptablearray("emb_palm_01", "targetname")[0];
  var_0 setscriptablepartstate("base", "show_damaged");
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_12");
  wait 1;
  var_1 = getEnt("emb_palm_01_clip_fallen", "targetname");
  var_1 show();
  var_1 disconnectPaths();
  scripts\engine\utility::trigger_on("emb_palm_01_trigger", "targetname");
  scripts\engine\utility::exploder("dead_palm");
  var_0 thread scripts\engine\sp\utility::play_sound_on_tag("scr_emb_palm_burning_fall", "palm_tree_B001_clone_surfatt_001");
  scripts\engine\utility::delaythread(4.5, scripts\engine\utility::play_loopsound_in_space, "scr_emb_palm_fire_big_lp", (-433, -73, 76));
  var_0 setscriptablepartstate("base", "show_death");
}

palm_tree_swap_02() {
  wait 0.2;
  level waittill("emb_palm_02_damaged");
  var_0 = getscriptablearray("emb_palm_02", "targetname")[0];
  var_0 setscriptablepartstate("base", "show_damaged");
  var_1 = getEnt("price_mortar_run_trigger_02", "targetname");
  var_2 = getEnt("price_mortar_run_trigger_02_alt", "targetname");
  var_3 = scripts\engine\utility::getStruct("emb_palm_02_fall_struct", "targetname");
  scripts\engine\utility::flag_wait("wave_4_end");
  scripts\engine\sp\utility::trigger_wait_targetname("player_warn_trigger");

  if(var_3.radius + 150 > distance2d(level.civ_car_death_spot, var_3.origin)) {
    return;
  }
  var_4 = getEnt("emb_palm_02_trigger", "targetname");
  var_5 = createnavbadplacebyent(var_4, "axis", "allies");
  var_0 thread scripts\engine\sp\utility::play_sound_on_tag("scr_emb_palm_burning_fall", "palm_tree_B001_clone_surfatt_001");
  scripts\engine\utility::delaythread(4.5, scripts\engine\utility::play_loopsound_in_space, "scr_emb_palm_fire_big_lp", (1119, 1114, 105));
  var_6 = getEnt("emb_palm_02_clip_fallen", "targetname");
  var_6 show();
  var_6 disconnectPaths();
  var_0 setscriptablepartstate("base", "show_death");
  scripts\engine\utility::trigger_on("emb_palm_02_trigger", "targetname");
}

price_and_player_ignored() {
  level.player.ignoreme = 1;
  level.hadir.ignoreme = 1;
  level.hadir.ignoreall = 1;
  level waittill("stop_ignoring_player");
  level.player.ignoreme = 0;
  level.hadir.ignoreme = 0;
  level.hadir.ignoreall = 0;
}

save_on_return_to_compound() {
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_10");
  scripts\engine\sp\utility::autosave_by_name("compound_assault");
  scripts\engine\sp\utility::trigger_wait_targetname("compound_return_auto_save");
  scripts\engine\sp\utility::autosave_by_name("compound_return_auto_save");
}

defend_wave_6_catchup() {
  scripts\engine\utility::flag_set("residence_return");
  scripts\engine\utility::flag_set("residence_destroyed");
  thread residence_bodies();
  var_0 = getEntArray("damaged_light", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 getlightintensity();
    var_2 setlightintensity(var_3 / 1.1);
  }
}

defend_wolf_escapes_start() {
  defend_inits();
  squad_init();
  var_0 = getEnt("mortar_anim_truck_01", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("truck_01");
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("p");
  scripts\engine\utility::flag_set("wave_5_house_end");
  scripts\engine\sp\utility::set_start_location("wolf_escapes_start", [level.player, level.price, level.farah, level.alex]);
  scripts\engine\sp\utility::set_start_location("roof_approach_start", [level.hadir]);
  var_1 = spawnStruct();
  var_1.origin = (-418, -110, 76);
  price_compound_run_triggers_on(1);
  scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::activate_trigger, "price_compound_run_trigger_15", "targetname");
  scripts\engine\sp\utility::activate_trigger("price_compound_run_trigger_14", "targetname");
}

defend_wolf_escapes_main() {
  thread suicide_bomber();
  scripts\engine\sp\utility::trigger_wait("price_compound_run_trigger_14", "targetname");
  setaudiotriggerstate("combat_zone", "", 2);
  setaudiotriggerstate("default", "", 2);
  var_0 = getEnt("res_secure_door", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("residence_saferoom_door");
  var_0 scripts\common\anim::anim_first_frame_solo(var_0, "wolf_escapes");
  thread ai_push_residence();
  thread defend_wolf_hostage();
  scripts\engine\utility::flag_wait("wolf_escapes");
  visionsetnaked("", 1);
  scripts\engine\sp\utility::autosave_by_name("stacy_hostage");
  var_1 = scripts\engine\utility::getStruct("residence_end_struct", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  var_1 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (3, 0, -5), &"EMBASSY/OPEN", 90, 500, 50, 0);
  var_2 = scripts\engine\utility::getStruct("residence_end_anim_struct", "targetname");
  var_2.origin = var_2.origin + (-5, 2, 0);
  var_0 = getEnt("res_secure_door", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("residence_saferoom_door");
  var_2 thread scripts\common\anim::anim_first_frame_solo(var_0, "wolf_escapes");
  var_1 waittill("trigger");
  thread ending_scene_mayhem_anims();
  thread kill_player_if_hostage_taker_still_alive();
  var_3 = getaiarray("axis");
  scripts\engine\utility::array_delete(var_3);
  level.hadir.support_equipment = 0;
  level.farah.support_equipment = 0;
  level.hadir notify("remove_equipment");
  thread skippable_ending();
  scripts\engine\utility::flag_set("escape_lights");
  var_4 = getspawner("kyle", "script_noteworthy");
  var_4.count = 1;
  level.kyle = scripts\engine\sp\utility::spawn_targetname("kyle", 1);
  level.kyle.animname = "kyle";
  level.player.fake_weapon = level.player getcurrentweapon();
  var_5 = weaponclass(level.player.fake_weapon);

  if(var_5 != "rifle" && var_5 != "smg")
    level.player.fake_weapon = scripts\sp\utility::make_weapon("iw8_ar_mike4");

  level.kyle scripts\anim\shared.gsc::forceuseweapon(level.player.fake_weapon, "primary");
  level.kyle hide();
  thread wolf_escapes_fx();
  defend_wolf_escapes_ending();
}

defend_wolf_escapes_scene_start() {
  defend_inits();
  squad_init();
  var_0 = getEnt("mortar_anim_truck_01", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("truck_01");
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("p");
  scripts\engine\utility::flag_set("wave_5_house_end");
  scripts\engine\sp\utility::set_start_location("wolf_escapes_start", [level.player, level.price, level.farah, level.alex]);
  scripts\engine\sp\utility::set_start_location("roof_approach_start", [level.hadir]);
  var_1 = spawnStruct();
  var_1.origin = (-418, -110, 76);
  price_compound_run_triggers_on(1);
  scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::activate_trigger, "price_compound_run_trigger_15", "targetname");
  scripts\engine\sp\utility::activate_trigger("price_compound_run_trigger_14", "targetname");
}

defend_wolf_escapes_scene_main() {
  waitframe();
  level.player setOrigin((-1795, -349, 120));
  level.player setplayerangles((0, 219, 0));
  setaudiotriggerstate("combat_zone", "", 2);
  setaudiotriggerstate("default", "", 2);
  level.player clearsoundsubmix("sp_npc_steps_down", 1.0);
  var_0 = getEnt("res_secure_door", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("residence_saferoom_door");
  var_0 scripts\common\anim::anim_first_frame_solo(var_0, "wolf_escapes");
  var_1 = scripts\engine\utility::getStruct("residence_end_struct", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  var_1 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (3, 0, -5), &"EMBASSY/OPEN", 90, 500, 50, 0);
  var_2 = scripts\engine\utility::getStruct("residence_end_anim_struct", "targetname");
  var_2.origin = var_2.origin + (-5, 2, 0);
  var_0 = getEnt("res_secure_door", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("residence_saferoom_door");
  var_2 thread scripts\common\anim::anim_first_frame_solo(var_0, "wolf_escapes");
  var_1 waittill("trigger");
  thread ending_scene_mayhem_anims();
  level.hadir.support_equipment = 0;
  level.farah.support_equipment = 0;
  level.hadir notify("remove_equipment");
  scripts\engine\utility::flag_set("escape_lights");
  var_3 = getspawner("kyle", "script_noteworthy");
  var_3.count = 1;
  level.kyle = scripts\engine\sp\utility::spawn_targetname("kyle", 1);
  level.kyle.animname = "kyle";
  level.player.fake_weapon = level.player getcurrentweapon();
  var_4 = weaponclass(level.player.fake_weapon);

  if(var_4 != "rifle" && var_4 != "smg")
    level.player.fake_weapon = scripts\sp\utility::make_weapon("iw8_ar_mike4");

  level.kyle scripts\anim\shared.gsc::forceuseweapon(level.player.fake_weapon, "primary");
  level.kyle hide();
  thread wolf_escapes_fx();
  defend_wolf_escapes_ending();
}

kill_player_if_hostage_taker_still_alive() {
  level.player endon("death");

  if(isalive(level.stacy.other)) {
    level.player kill();
    wait 10;
  }
}

skippable_ending() {
  level endon("level_ended");
  var_0 = scripts\sp\utility::userskip_wait();

  if(!var_0) {
    return;
  }
  var_1 = getaiarray();

  foreach(var_3 in var_1)
  var_3 stopsounds();

  scripts\engine\sp\utility::nextmission();
}

residence_bodies() {
  var_0 = scripts\engine\utility::getStructArray("residence_end_dead_struct", "targetname");
  var_1 = getspawner("dead_marine_defend", "targetname");

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\sp\utility::bodyonlyspawn(var_1);
    var_4.animname = "soldier_01";
    var_4 thread scripts\common\ai::gun_remove();
    waitframe();
    var_4 notsolid();
    var_3 thread scripts\common\anim::anim_single_solo(var_4, var_3.animation);
    waitframe();
  }

  var_0 = scripts\engine\utility::getStructArray("residence_end_dead_struct_02", "targetname");
  var_1 = getspawner("dead_enemy_defend", "targetname");

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\sp\utility::bodyonlyspawn(var_1);
    var_4.animname = "soldier_01";
    var_4 thread scripts\common\ai::gun_remove();
    waitframe();
    var_4 notsolid();
    var_3 thread scripts\common\anim::anim_single_solo(var_4, var_3.animation);
    waitframe();
  }
}

wolf_escapes_vo() {
  level.player endon("death");
  waitframe();
  thread vo_stacy_killed();
  level.stacy endon("damage");
  level.stacy endon("bullethit");
  level.stacy endon("killer_succeeds");
  level.stacy.other endon("death");
  level endon("stacy_result");
  level.stacy thread scripts\engine\utility::call_on_notify("damage", ::stopsounds);
  level.stacy thread scripts\engine\utility::call_on_notify("bullethit", ::stopsounds);
  level.stacy thread scripts\engine\utility::call_on_notify("killer_succeeds", ::stopsounds);
  vo_wolf_escape_entrance();
  level.stacy.other thread scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_aq2_wolf_escapes_final_20");
  level.stacy.function_stack = undefined;
  level.stacy notify("clear_function_stack");
  level.stacy thread scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_stac_wolf_escapes_final_10", 1);
}

vo_wolf_escape_entrance() {
  level.player endon("death");
  level endon("stacy_killer_saw_player");
  level.stacy.other endon("death");
  var_0 = ["dx_vom_pri_wolf_escapes_final_80", "dx_vom_pri_wolf_escapes_final_90", "dx_vom_pri_wolf_escapes_final_100", "dx_vom_pri_wolf_escapes_outro_10"];
  level.get_in_there_nags = scripts\engine\sp\utility::create_deck(var_0, 0);
  level.get_in_there_nags.autoshuffle = 1;
  check_cleared_residence();
  wait 2;
  scripts\sp\maps\embassy\embassy_util.gsc::wait_combat_cooldown(6, 30);
  level.price scripts\sp\maps\embassy\embassy_util.gsc::nagtill("stacy_killer_saw_player", level.get_in_there_nags, 8, 1.5);
}

check_cleared_residence() {
  while(getaiarray("axis").size > 3)
    level waittill("ai_killed");

  level notify("cleared_residence");
}

vo_stacy_killed() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("wolf_escapes");
  level.stacy thread scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_stac_wolf_escapes_final_00");
  var_0 = level.stacy.other;
  var_1 = level.stacy scripts\engine\utility::waittill_any_return("killer_succeeds", "damage", "bullethit", "player_killed", "freed");
  level notify("stacy_result", var_1);
  wait 0.2;

  if(var_1 == "freed" && isalive(level.stacy) && !istrue(level.stacy.killed_early)) {
    level.stacy.function_stack = undefined;
    level.stacy notify("clear_function_stack");
    level.stacy thread scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_stac_wolf_escapes_final_30", 1);
    wait 0.6;
    scripts\sp\maps\embassy\embassy_util.gsc::wait_combat_cooldown(0.6, 2);

    if(isalive(level.stacy) && !istrue(level.stacy.killed_early))
      level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_wolf_escapes_final_40");
  } else {
    var_0 stopsounds();

    if(isalive(var_0))
      var_0 waittill("death");

    scripts\sp\maps\embassy\embassy_util.gsc::wait_combat_cooldown(0.6, 2);
    level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_wolf_escapes_final_50");
    wait 0.25;
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_wolf_escapes_final_60");
  }

  thread wolf_escape_door_nags();
}

wolf_escape_door_nags() {
  wait 6;
  level.get_in_there_nags.items = scripts\engine\utility::array_add(level.get_in_there_nags.items, "dx_vom_pri_wolf_escapes_final_70");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::nagtill("escape_lights", level.get_in_there_nags);
}

ai_push_residence() {
  scripts\engine\utility::flag_wait("wolf_escapes");
  enemy_alive_counter_gate(0);
  var_0 = getnodesinradius((-2017, -536, 116), 300, 0);
  var_0 = sortbydistance(var_0, (-2017, -536, 116));
  var_1 = getaiarray("allies");

  foreach(var_3 in var_1) {
    var_3.fixednode = 0;
    var_3 scripts\engine\sp\utility::clear_force_color();
    var_3 enableavoidance(0, 0);
    var_3 setgoalpos(var_3.origin);
    var_3 thread scripts\sp\spawner::go_to_node(var_0[0]);
    var_3 setgoalnode(var_0[0]);
    var_3 scripts\engine\sp\utility::set_goal_radius(64);
    var_0 = scripts\engine\utility::array_remove(var_0, var_0[0]);
  }
}

defend_wolf_escapes_catchup() {}

defend_wolf_hostage() {
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_stacy();
  var_0 = scripts\engine\sp\utility::spawn_targetname("residence_stacy_killer");
  var_0.animname = "residence_stacy_killer";
  var_0.ignoreme = 1;
  var_0.health = 20;
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  var_0 scripts\common\ai::gun_remove();
  var_0 scripts\sp\utility::context_melee_allow(0);
  var_0 thread wolf_hostage_check_damage();
  var_0.other = level.stacy;
  level.stacy.other = var_0;
  level.stacy.ignoreme = 1;
  level.stacy allowedstances("crouch");
  level.stacy scripts\engine\sp\utility::set_allowdeath(1);
  thread wolf_escapes_vo();
  level.stacy thread wolf_hostage_check_damage();
  level.stacy scripts\engine\sp\utility::clear_deathanim();
  level.stacy.skipdeathanim = 1;
  level.stacy.a.nodeath = 1;
  level.stacy.noragdoll = 1;
  level.stacy.flashed = 0;
  level.stacy.no_friendly_fire_fail = 1;
  var_1 = scripts\engine\utility::getStruct("stacy_hostage_struct", "targetname");
  var_1.origin = var_1.origin + (0, 0, 0);
  var_2 = [level.stacy, var_0];
  var_1 scripts\common\anim::anim_single(var_2, "bpgc_hostage_enter");
  var_1 thread scripts\common\anim::anim_loop(var_2, "bpgc_hostage_idle", "stop_hostage_loop");
  var_1 thread hostage_loop_watcher(level.stacy);
  level.stacy thread flashbang_watcher();
  level.stacy.other thread flashbang_watcher();
  var_1 thread hostage_loop_watcher(level.stacy.other);
  level.stacy thread wolf_damage_watcher(var_1);
  var_0 thread stacy_killer_succeeds(var_1);
  var_0 thread stacy_killer_dies(var_1);
  var_0 thread stacy_dies(var_1);
  var_0 thread stacy_killed_by_player(var_1);
  var_0 endon("death");

  while(!var_0 cansee(level.player))
    waitframe();

  level notify("stacy_killer_saw_player");
  wait 1.0;

  if(distance2d(level.stacy.other.origin, level.player.origin) > 200)
    wait 1.1;

  var_1 notify("stop_hostage_loop");
}

stacy_killer_succeeds(var_0) {
  self endon("death");
  level.stacy endon("freed");
  level.stacy endon("player_killed");
  var_0 waittill("stop_hostage_loop");
  waitframe();

  if(isDefined(level.stacy.killed_early)) {
    return;
  }
  level.stacy.killed_by_killer = 1;
  var_0 thread scripts\common\anim::anim_single_solo(self, "bpgc_hostage_exit");
  var_0 thread scripts\common\anim::anim_single_solo(level.stacy, "bpgc_hostage_death");
  level waittill("hostage_aq_fired");
  level.stacy.name = "";
  level.stacy notify("killer_succeeds");
  thread stacy_hostage_death();
}

stacy_hostage_death() {
  level.stacy waittillmatch("single anim", "end");
  level.stacy scripts\common\ai::stop_magic_bullet_shield();
  level.stacy scripts\engine\sp\utility::die();
}

stacy_killer_dies(var_0) {
  level.stacy endon("damage");
  level.stacy endon("bullethit");
  level.stacy endon("death");
  level.stacy endon("killer_succeeds");
  scripts\engine\utility::waittill_any("damage", "bullethit");
  level.stacy notify("freed");
  level.stacy.freed = 1;
  thread stacy_dies_after_freedom(var_0);
  level.stacy.forceragdollimmediate = 1;
  var_0 notify("stop_hostage_loop");
  level.stacy stopanimScripted();
  var_0 thread scripts\common\anim::anim_single_solo(level.stacy, "bpgc_hostage_exit");
  thread stacy_reset_ff();
  level.stacy waittillmatch("single anim", "end");
  level.stacy setgoalpos(level.stacy.origin);
  thread stacy_nearby_detect();

  for(;;) {
    stacy_dejected_idle();
    level.stacy notify("stop_loop");

    if(level.stacy.whiz == 1) {
      level.stacy scripts\common\anim::anim_single_solo(level.stacy, "dejected_react_gun");
      level.stacy notify("react_complete");
      continue;
    }

    var_1 = "dejected_react_01";

    if(scripts\engine\utility::cointoss())
      var_1 = "dejected_react_02";

    level.stacy scripts\common\anim::anim_single_solo(level.stacy, var_1);
    level.stacy notify("react_complete");
  }
}

stacy_reset_ff() {
  wait 0.5;
  level.stacy.no_friendly_fire_fail = 0;
  level.stacy thread scripts\sp\maps\embassy\embassy_util.gsc::civ_friendly_fire_think();
}

flashbang_watcher() {
  self endon("death");
  level endon("hostage_aq_fired");
  level.stacy endon("freed");
  var_0 = undefined;
  self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  if(isDefined(var_10))
    var_0 = getweaponbasename(var_10);

  if(var_0 == "flash")
    level.stacy.flashed = 1;

  self.allowdeath = 1;

  if(self == level.stacy)
    self.other shoot();
  else {
    self shoot();
    thread scripts\common\anim::anim_single_solo(self, "bpgc_hostage_flash");
  }
}

stacy_dejected_idle() {
  level.stacy.whiz = 0;
  level.stacy endon("breakout_idle");
  level.stacy endon("death");
  level.stacy thread scripts\common\anim::anim_loop_solo(level.stacy, "dejected_idle");
  level.stacy waittill("bulletwhizby");
  level.stacy.whiz = 1;
}

stacy_nearby_detect() {
  level.stacy endon("death");

  for(;;) {
    var_0 = distance(level.stacy.origin, level.player.origin);

    if(var_0 < 70) {
      level.stacy notify("breakout_idle");
      level.stacy waittill("react_complete");
    }

    waitframe();
  }
}

stacy_killed_by_player(var_0) {
  self endon("death");
  level.stacy endon("freed");
  level.stacy endon("death");
  level.stacy waittill("player_killed");
  level.stacy.name = "";
  var_0 notify("stop_hostage_loop");
  self stopanimScripted();
}

stacy_dies(var_0) {
  level.stacy endon("freed");
  level.stacy endon("killer_succeeds");
  level.stacy scripts\engine\utility::waittill_any("damage", "bullethit", "player_killed");
  var_0 notify("stop_hostage_loop");

  if(!istrue(level.stacy.freed))
    var_0 scripts\common\anim::anim_single_solo(level.stacy, "bpgc_hostage_death");

  level.stacy scripts\common\ai::stop_magic_bullet_shield();
  level.stacy scripts\engine\sp\utility::die();
}

stacy_dies_after_freedom(var_0) {
  level.stacy scripts\engine\utility::waittill_any("damage", "bullethit");
  waitframe();
  level.stacy notify("stop_loop");
  var_0 notify("stop_hostage_loop");
  level.stacy.forceragdollimmediate = 1;
  level.stacy stopanimScripted();
  level.stacy.a.nodeath = 0;
  level.stacy scripts\common\ai::stop_magic_bullet_shield();
  level.stacy scripts\engine\sp\utility::ai_ragdoll_immediate();
}

wolf_damage_watcher(var_0) {
  level endon("hostage_free");
  level.stacy scripts\engine\utility::waittill_any("damage", "bullethit");
}

hostage_loop_watcher(var_0) {
  self endon("stop_hostage_loop");
  var_0 scripts\engine\utility::waittill_any("damage", "bullethit");

  if(var_0 == level.stacy) {
    level.stacy notify("player_killed");
    level.stacy.killed_early = 1;
    self notify("stop_hostage_loop");
  }
}

wolf_hostage_check_damage() {
  self endon("stop_checking_damage");
  scripts\engine\utility::waittill_any("damage", "bullethit");
  self.killed_early = 1;
}

wolf_escapes_fx() {
  playFX(scripts\engine\utility::getfx("vfx_mortar_wall_smoke"), (-2241, -729, 74), (1, 1, 1), (1, 1, 1));
}

defend_wolf_escapes_ending() {
  level.price.name = "";
  var_0 = getEnt("res_secure_door", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("residence_saferoom_door");
  setmusicstate("");
  var_1 = [level.price, level.kyle, level.farah, level.alex, level.hadir];

  foreach(var_3 in var_1)
  var_3 scripts\engine\sp\utility::name_hide();

  var_1 = scripts\engine\utility::array_add(var_1, var_0);
  var_5 = scripts\engine\utility::getStruct("residence_end_anim_struct", "targetname");
  var_5.origin = var_5.origin + (-5, 0, 0);
  var_6 = getEntArray("residence_pristine_wall", "targetname");
  scripts\engine\utility::array_delete(var_6);
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::wolf_door_light();
  var_5 scripts\common\anim::anim_first_frame_solo(level.player.rig, "wolf_escapes");
  var_5 scripts\common\anim::anim_first_frame_solo(level.kyle, "wolf_escapes");
  waitframe();
  level.player enablequickweaponswitch(1);
  scripts\sp\maps\embassy\embassy_util.gsc::put_player_into_rig(level.player.rig, 0.5, 5, 5, 5, 5);
  var_7 = getcorpsearray();

  foreach(var_9 in var_7)
  var_9 delete();

  var_5 scripts\common\anim::anim_first_frame_solo(var_0, "wolf_escapes");
  var_5 thread scripts\common\anim::anim_single(var_1, "wolf_escapes");
  var_5 scripts\common\anim::anim_single_solo(level.player.rig, "wolf_escapes");
  level.kyle show();
  var_5 scripts\common\anim::anim_last_frame_solo(level.player.rig, "wolf_escapes");
  level.player unlink();
  var_11 = level.player.rig scripts\engine\utility::getanim("wolf_escapes_cam");
  var_12 = getstartorigin(var_5.origin, var_5.angles, var_11);
  var_13 = getstartangles(var_5.origin, var_5.angles, var_11);
  level.player setOrigin(var_12);
  level.player setplayerangles(var_13);
  thread audio_wolf_outro_room_mix();
  visionsetnaked("embassy_wolf_escapes", 0.2);
  var_5 scripts\common\anim::anim_first_frame_solo(level.player.rig, "wolf_escapes_cam");
  level.player playerlinktoabsolute(level.player.rig, "tag_player");
  var_5 notify("stop_first_frame");
  level.player.rig hide();
  thread defend_wolf_escapes_ending_camera_settings();
  var_5 thread scripts\common\anim::anim_single_solo(level.player.rig, "wolf_escapes_cam");
  var_14 = getanimlength(level.player.rig scripts\engine\utility::getanim("wolf_escapes_cam"));
  level.player scripts\engine\utility::delaycall(var_14 - 5.5, ::setclienttriggeraudiozone, "fade_to_black_minus_scripted5_music_and_dx", 7.5);
  wait(var_14 - 2.5);
  thread scripts\sp\analytics::analytics_kleenex_update("Triage to End of Gameplay");
  scripts\engine\sp\utility::nextmission();
  level waittill("forever");
}

#using_animtree("generic_human");

triage_scene_mayhem_anims() {
  level.price thread scene_mayhem(%emb_def_050_triage_scene_price_face, "triage_mayhem_price_face", "price_mayhem_end");
}

ending_scene_mayhem_anims() {
  level.price thread scene_mayhem(%emb_exfil_010_wolfescapes_price_face, "ending_mayhem_price_face");
  level.farah thread scene_mayhem(%emb_exfil_010_wolfescapes_farah_face, "ending_mayhem_farah_face");

  while(!isDefined(level.kyle))
    waitframe();

  level.kyle thread scene_mayhem(%emb_exfil_010_wolfescapes_kyle_face, "ending_mayhem_kyle_face");
}

scene_mayhem(var_0, var_1, var_2) {
  level waittill(var_1);

  if(!isDefined(var_2))
    var_2 = undefined;

  thread play_mayhem_animation(var_0, var_2);
}

play_mayhem_animation(var_0, var_1) {
  if(isDefined(self.headmodel)) {
    if(isDefined(self.hatmodel))
      self detach(self.hatmodel);

    self detach(self.headmodel);
    self setanim(var_0, 1.0, 0.0, 1.0);
  }

  if(isDefined(var_1)) {
    level waittill(var_1);
    self setanim(var_0, 0.0, 0.0, 0.0);
    self attach(self.headmodel);

    if(isDefined(self.hatmodel))
      self attach(self.hatmodel);
  }
}

audio_wolf_outro_room_mix() {
  level.player setclienttriggeraudiozone("embassy_wolf_outro_room", 10);
}

defend_wolf_escapes_ending_camera_settings() {
  level.player modifybasefov(42, 0.01);
  level.player setcinematicmotionoverride("disabled");
  hidecinematicletterboxing(0, 0);
  level.price scripts\engine\sp\utility::dof_enable_autofocus(1.4, 1, undefined, undefined, "tag_eye");
  wait 5;
  level.farah scripts\engine\sp\utility::dof_enable_autofocus(2, 1, undefined, undefined, "tag_eye");
}

wolf_actors_idle(var_0) {
  self waittillmatch("single anim", "end");

  if(scripts\engine\utility::is_equal(self, level.price) || scripts\engine\utility::is_equal(self, level.kyle)) {
    if(scripts\engine\utility::is_equal(self, level.price)) {
      var_0 scripts\common\anim::anim_last_frame_solo(self, "wolf_escapes");
      return;
    }

    scripts\engine\sp\utility::clear_force_color();
    self setgoalpos(self.origin);
  }
}

mortar_rounds_pacing() {
  level endon("wave_2_end");
  level.mortar_round_delay_time = level.mortar_round_delay_time + 1;
  level waittill("mortar_impact");
  waitframe();
  level waittill("mortar_impact");

  for(;;) {
    if(!scripts\engine\utility::flag("enemy_mortar_manned")) {
      break;
    }

    level.mortar_round_delay_time = 0.5;
    var_0 = randomintrange(2, 4);
    var_1 = randomintrange(1, 2);
    level.mortar_round_delay_time = var_1;
    wait(var_1);
  }
}

flare_mover(var_0) {
  while(isDefined(self) && scripts\engine\utility::flag("flares_out")) {
    var_1 = self.origin[0] + randomintrange(-5, 5);
    var_2 = self.origin[1] + randomintrange(-5, 5);
    var_3 = self.origin[2] - 15;
    self moveTo((var_1, var_2, var_3), 1);
    wait 1;
  }
}

squad_init() {
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_farah();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_alex();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_hadir();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_mortar_friendlies();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_marines_friendlies();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_alex_friendlies();
}

wave_1_field_infantry() {
  var_0 = getEnt("interior_main_vol", "targetname");
  var_1 = scripts\engine\utility::getStruct("mortar_wave_3_lookat", "targetname");
  var_2 = 0.939693;

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_1.origin, var_2)) {
      break;
    } else if(!scripts\engine\utility::flag("flares_out")) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("wave_1_shoot_out_lights");
  wait 3;
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  scripts\engine\utility::flag_wait("wave_1_attack");
  var_3 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  var_3 notify("stop_loop");
  var_3 notify("stop_mortar_guy_idle");
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  thread scripts\engine\sp\utility::battlechatter_off("allies");
  thread scripts\engine\sp\utility::battlechatter_off("axis");
  wait 0.4;
  var_4 = undefined;
  spawn_ai_wave_1();
  var_4 = level.wave_1_guys[0];
  var_4.animname = "aq_leader";
  var_4.health = 20;
  var_5 = scripts\engine\utility::getStruct("aq_leader_struct", "targetname");
  var_5.origin = var_5.origin + (-700, -200, 0);
  var_5 thread scripts\common\anim::anim_first_frame_solo(var_4, "compound_charge");
  wait 4.0;
  var_5 thread scripts\common\anim::anim_single_solo(var_4, "compound_charge");
  var_4.allowdeath = 1;
  var_4 allowedstances("stand", "crouch", "prone");
  wait 2.5;
  thread scripts\engine\utility::play_sound_in_space("dx_vom_aq4_defend_battlecry_51", var_5.origin + (0, 0, 50));
  wait 1;
  scripts\engine\utility::array_thread(level.wave_1_guys, ::enemies_wave_01_scatter_delay);
  level.farah scripts\engine\sp\utility::set_battlechatter(0);
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  thread scripts\engine\sp\utility::battlechatter_on("allies");
  level.farah.battlechatterallowed = 1;

  while(level.flare_countdown > 8)
    wait 0.1;

  thread wave_1_enemy_reinforcements();
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::flag_waitopen("flares_out");
  scripts\engine\utility::flag_set("enable_ilumination_flares");
  front_2_timeout();

  if(!scripts\engine\utility::flag("front_3"))
    scripts\engine\utility::flag_wait("player_flaring");

  var_6 = getaiarray("axis");
  scripts\engine\utility::array_thread(var_6, ::molotov_notify);
  scripts\engine\utility::flag_wait("front_3");
  scripts\engine\utility::flag_set("enable_ilumination_flares");
  thread flare_enable_loop();

  if(!scripts\engine\utility::flag("flare_2_skipped"))
    scripts\engine\utility::flag_wait("flares_out");
  else
    wait 8;

  scripts\engine\utility::flag_set("enemies_at_the_wall");
  thread molotov_throwers();
  scripts\engine\utility::flag_wait("wave_1_falling_back");
  wait 1;
  level notify("wave_1_retreats");
  thread scripts\engine\sp\utility::battlechatter_off("allies");
  thread scripts\engine\sp\utility::battlechatter_off("axis");
  wait 3;
  scripts\engine\utility::flag_set("wave_1_end");
  thread field_weapon_cleanup();
}

molotov_throwers() {
  var_0 = (9.2, 212, 212);
  var_1 = (108.5, -294.5, 16);
  var_2 = scripts\engine\utility::getStruct("east_grounds", "targetname").origin;
  var_3 = scripts\engine\utility::getStruct("price_ladder_struct", "targetname").origin;
  var_4 = [var_0, var_1, var_2, var_3];
  var_5 = spawnStruct();
  var_5.angles = (0, 180, 0);
  var_5.origin = (718, 100, 17.5283);
  var_6 = spawnStruct();
  var_6.angles = (0, 180, 0);
  var_6.origin = (726, -237, 17.5283);
  var_7 = [var_6, var_6];
  level.scr_anim["grenade_thrower"]["grenade_toss"] = % sdr_com_exposed_crouch_grenade_throw01;
  scripts\common\anim::addnotetrack_notify("grenade_thrower", "grenade_throw", "scripted_grenade_throw", "grenade_toss");
  var_8 = "molotov";
  var_9 = 0;

  while(var_9 < 4) {
    var_10 = getaiarray("axis");
    var_10 = scripts\sp\maps\embassy\embassy_util.gsc::array_removedeaddyingorundefined(var_10);

    if(var_10.size == 0) {
      break;
    }

    var_11 = sortbydistance(var_10, scripts\engine\utility::random(var_7).origin)[0];
    var_11.animname = "grenade_thrower";
    var_11 endon("death");
    var_11.ignoreall = 1;
    var_11.threw_grenade = 0;
    var_11 thread anim_reach_watcher(var_5);
    var_11 thread molotov_guy_death_watcher();
    var_11 thread molotov_throw_watcher();

    for(;;) {
      if(!isDefined(var_11)) {
        break;
      }

      if(var_11.threw_grenade) {
        break;
      }

      waitframe();
    }

    if(!isDefined(var_11)) {
      continue;
    }
    var_12 = var_4[var_9];
    var_11 scripts\engine\sp\utility::set_grenadeweapon(var_8);
    var_11.grenadeammo = 1;
    var_13 = var_11 gettagorigin("tag_accessory_right");
    var_14 = (var_12 - var_11.origin + (0, 0, 50)) * 1.5;
    var_15 = var_11 magicgrenade(var_13, var_12);

    if(!isDefined(var_15)) {
      var_11.ignoreall = 0;
      waitframe();
      continue;
    }

    var_9++;
    var_11.ignoreall = 0;
    var_11.threw_grenade = 1;
    var_11.grenadeammo = 0;

    if(var_8 == "molotov") {
      level notify("molotov_fired");
      thread scripts\sp\equipment\molotov::molotovfiremain(var_15);
    }

    if(var_8 == "semtex")
      var_11 thread scripts\sp\equipment\semtex::semtexfiremain(var_15);

    if(var_9 < 2) {
      wait 4;
      continue;
    }

    wait 9;
  }
}

anim_reach_watcher(var_0) {
  self endon("death");
  var_0 scripts\sp\anim::anim_reach_solo(self, "grenade_toss");

  if(isalive(self))
    var_0 thread scripts\common\anim::anim_single_solo(self, "grenade_toss");
}

molotov_throw_watcher() {
  self endon("death");
  level waittill("scripted_grenade_throw");
  self.threw_grenade = 1;
}

molotov_guy_death_watcher() {
  self waittill("death");
  level notify("molotov_guy_died");
}

front_2_timeout() {
  level endon("front_3");
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::flag_waitopen("flares_out");
  scripts\engine\utility::flag_set("enable_ilumination_flares");
}

flare_enable_loop() {
  level endon("stop_player_flare_mortar");

  for(;;) {
    scripts\engine\utility::flag_wait("flares_out");
    scripts\engine\utility::flag_waitopen("flares_out");
    scripts\engine\utility::flag_set("enable_ilumination_flares");
  }
}

enemy_volume_changer() {
  var_0 = [];
  scripts\engine\utility::flag_wait("wave_1_attack");
  scripts\engine\utility::flag_waitopen("flares_out");
  level.front_goal_vol = getEnt("front_2", "targetname");
  scripts\engine\utility::flag_set("front_2");
  var_1 = getaiarray("axis");
  wait 1;
  scripts\engine\utility::array_thread(var_1, ::wave_1_enemy_battle_line_update, level.front_goal_vol);
  scripts\engine\utility::flag_waitopen("flares_out");
  thread skip_front_2_logic();
  scripts\engine\utility::flag_wait("flares_out");

  if(scripts\engine\utility::flag("front_3")) {
    return;
  }
  scripts\engine\utility::exploder("wave02");
  scripts\engine\utility::flag_waitopen("flares_out");
  var_2 = getEnt("front_2_clip", "targetname");
  var_2 connectpaths();
  var_2 delete();
  scripts\engine\utility::flag_set("front_3");
  level.front_goal_vol = getEnt("front_3", "targetname");
  wait 1;
  var_1 = getaiarray("axis");
  scripts\engine\utility::array_thread(var_1, ::wave_1_enemy_battle_line_update, level.front_goal_vol);
  waitframe();
  scripts\engine\utility::flag_wait("flares_out");
  waitframe();
}

skip_front_2_logic() {
  level endon("flares_out");
  wait 20;
  scripts\engine\utility::flag_set("front_3");
  scripts\engine\utility::flag_set("flare_2_skipped");
  level.front_goal_vol = getEnt("front_3", "targetname");
  var_0 = getaiarray("axis");
  scripts\engine\utility::array_thread(var_0, ::enemies_skip_front_2, level.front_goal_vol);
  var_1 = getEnt("front_2_clip", "targetname");
  var_1 connectpaths();
  var_1 delete();
}

enemies_skip_front_2(var_0) {
  self allowedstances("stand", "crouch", "prone");
  scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::delaythread(randomfloatrange(0.5, 1), scripts\common\utility::demeanor_override, "combat");
  self setgoalvolumeauto(var_0, level.field_cover_direction);
  scripts\engine\utility::set_movement_speed(180);
  scripts\engine\utility::waittill_any_timeout(6, "goal");
  self allowedstances("crouch", "stand", "prone");
  self.ignoreall = 0;
  self setgoalvolumeauto(var_0, level.field_cover_direction);
  scripts\common\utility::demeanor_override("combat");
}

wave_1_enemy_battle_line_update(var_0, var_1) {
  level endon("flare_2_skipped");

  if(!isalive(self)) {
    return;
  }
  self endon("death");
  self.ignoreall = 1;
  scripts\common\utility::demeanor_override("cqb");
  self notify("change_volume");
  wait(randomfloatrange(0.1, 0.4));
  self allowedstances("prone");
  scripts\engine\utility::flag_wait("player_flaring");
  var_2 = getcorpsearray();

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4.script_noteworthy, "ally_03")) {
      continue;
    }
    var_4 delete();
  }

  wait 4;
  self allowedstances("stand", "crouch", "prone");
  scripts\common\utility::demeanor_override("combat");
  var_6 = 0.1;

  if(scripts\engine\utility::flag("front_3"))
    var_6 = var_6 + 1;

  wait(var_6);

  if(scripts\engine\utility::flag("front_3")) {
    self allowedstances("stand", "crouch", "prone");
    scripts\common\utility::demeanor_override("cqb");
    scripts\engine\utility::delaythread(randomfloatrange(0.5, 1), scripts\common\utility::demeanor_override, "combat");
    self setgoalvolumeauto(var_0, level.field_cover_direction);
    wait 1;
  }

  self allowedstances("stand", "crouch", "prone");
  scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::delaythread(randomfloatrange(0.5, 1), scripts\common\utility::demeanor_override, "combat");
  self setgoalvolumeauto(var_0, level.field_cover_direction);
  scripts\engine\utility::waittill_any_timeout(6, "goal");
  self allowedstances("crouch", "stand", "prone");
  self.ignoreall = 0;
  self setgoalvolumeauto(var_0, level.field_cover_direction);
  scripts\common\utility::demeanor_override("combat");
}

wave_1_enemy_reinforcements() {
  spawn_max_ai_wave_1_refill();
  wait 0.1;
  spawn_max_ai_wave_1_refill();
  thread enemy_volume_changer();
  scripts\engine\utility::flag_wait_any("player_flaring", "flare_2_skipped");

  if(!scripts\engine\utility::flag("flare_2_skipped")) {
    var_0 = getcorpsearray();

    foreach(var_2 in var_0)
    var_2 delete();

    wait 3.5;
    spawn_max_ai_wave_1_lmg_push();
    scripts\engine\utility::flag_waitopen("flares_out");
    rpg_guy_wave_1();
  } else
    spawn_ai_wave_2_pre_push();

  scripts\engine\utility::flag_wait("front_3");
  scripts\engine\utility::flag_wait_any("player_flaring", "flare_2_skipped");
  thread wave_1_technical_01();

  if(!scripts\engine\utility::flag("flare_2_skipped"))
    spawn_max_ai_wave_1_technical_refill();

  enemy_alive_counter_gate(7);
  var_4 = getnodearray("exposed_flare_nodes", "targetname");
  var_4 = sortbydistance(var_4, level.player.origin);
  var_5 = getaiarray("axis");

  foreach(var_8, var_7 in var_5) {
    var_7.goalradius = 32;
    var_7 setgoalnode(var_4[var_8]);
    var_7.health = 1;
    var_7.attackeraccuracy = 1000;
    var_7.baseaccuracy = 0;

    if(var_7 scripts\engine\utility::doinglongdeath()) {
      var_7 kill();
      continue;
    }

    var_7 scripts\engine\sp\utility::disable_long_death();
  }

  scripts\engine\utility::flag_set("wave_1_3_ending");
  enemy_alive_counter_gate(3);
  enemy_alive_counter_gate(0);
  scripts\engine\utility::flag_set("wave_1_falling_back");
}

spawn_max_ai_wave_1_lmg_push() {
  var_0 = getspawnerarray("wave_1_extra_2");
  var_1 = getaiarray("axis");
  var_2 = 13 - var_1.size;
  var_3 = var_2;

  if(var_3 <= 0) {} else {
    if(var_0.size - var_3 < 0)
      var_3 = var_0.size;

    for(var_4 = 0; var_4 < var_3; var_4++)
      var_0[var_4] scripts\engine\sp\utility::spawn_ai(1);
  }

  var_1 = getaiarray("axis", "allies");
}

spawn_max_ai_wave_1_technical_refill() {
  var_0 = getspawnerarray("wave_1_extra_3");
  var_1 = getaiarray("axis", "allies");
  var_2 = 25 - var_1.size;
  var_3 = var_2;

  if(var_3 <= 0) {} else {
    if(var_0.size - var_3 < 0)
      var_3 = var_0.size;

    for(var_4 = 0; var_4 < var_3; var_4++)
      var_0[var_4] scripts\engine\sp\utility::spawn_ai(1);
  }

  var_1 = getaiarray("axis", "allies");
}

spawn_max_ai_wave_1_refill() {
  var_0 = getaiarray("axis", "allies");
  var_1 = 5;
  var_2 = getspawnerarray("wave_1_extra_1");

  if(var_2.size - var_1 < 0)
    var_1 = var_2.size;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    wait(randomfloatrange(0.1, 0.4));
    var_2[var_3] scripts\engine\sp\utility::spawn_ai(1);
    var_2[var_3].count = 1;
  }

  var_0 = getaiarray("axis");
}

rpg_guy_wave_1() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("rpg_guy_01", 1);
  var_0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
  var_0.baseaccuracy = 1;
  var_1 = scripts\engine\sp\utility::spawn_targetname("rpg_guy_02", 1);
  var_1 scripts\engine\sp\utility::set_favoriteenemy(level.player);
  var_1.baseaccuracy = 1;
  var_0.ignoreme = 1;
  var_0.rpg_guy = 1;
  var_1.ignoreme = 1;
  var_1.rpg_guy = 1;
  var_2 = [var_0, var_1];
  scripts\engine\utility::array_thread(var_2, ::rpg_notify);
  scripts\engine\utility::flag_wait("front_3");
  scripts\engine\utility::flag_wait("player_flaring");

  if(isDefined(var_0))
    var_0.ignoreme = 0;

  if(isDefined(var_1))
    var_1.ignoreme = 0;
}

rpg_notify() {
  self endon("death");

  for(;;) {
    self waittill("missile_fire");
    level notify("rpg_fired");
  }
}

molotov_notify() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire");
    level notify("molotov_fired");
  }
}

wave_1_enemy_behavior() {
  self.allowdeath = 1;
  self.flare_timer = level.flare_lifetime;
  scripts\engine\utility::ent_flag_init("flared");
  scripts\common\utility::demeanor_override("cqb");
  scripts\engine\sp\utility::place_weapon_on(self.sidearm, "none");
  self.sidearm = isundefinedweapon();
  thread enemy_flare_behavior();
  self.ignoreall = 1;

  if(self.targetname == "wave_1") {
    self.ignoreme = 1;
    self allowedstances("stand", "crouch");
  }

  if(self.classname == "actor_enemy_alq_desert_dmr")
    self.disablesniperbehaviors = 1;

  if(self.classname == "actor_enemy_alq_desert_lmg")
    self.secondaryweapon = "none";

  self setgoalvolumeauto(level.front_goal_vol, level.field_cover_direction);

  if(self.targetname != "wave_1")
    enemies_wave_01_engage();
}

enemies_wave_01_scatter_delay() {
  self endon("death");
  wait(randomfloatrange(0.1, 1.1));
  self allowedstances("stand", "crouch", "prone");
  scripts\engine\utility::delaythread(randomfloatrange(0.2, 1), scripts\common\utility::demeanor_override, "combat");
  self.ignoreme = 0;
  scripts\engine\utility::waittill_any_timeout(10, "goal");

  if(!isDefined(self)) {
    return;
  }
  self.ignoreall = 0;
}

enemies_wave_01_engage() {
  self endon("change_volume");
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::waittill_any_timeout(6, "goal");
  self.ignoreall = 0;
}

enemies_wave_01_refill() {
  self endon("change_volume");
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  scripts\common\utility::demeanor_override("combat");
  self.ignoreall = 0;
}

enemy_fall_back_killer() {
  self endon("death");
  self waittill("goal");
  self delete();
}

friendly_flare_sender(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_0))
    var_3 = var_0;

  wait(var_3);

  if(!scripts\engine\utility::flag("flares_out")) {
    if(isDefined(var_2)) {
      var_4 = scripts\engine\utility::getStruct("flare_anim", "script_noteworthy");
      var_5 = getaiarray("allies");
      var_6 = scripts\engine\utility::getclosest(var_4.origin, var_5);

      if(!isDefined(var_6.magic_bullet_shield))
        var_6 thread scripts\common\ai::magic_bullet_shield();

      var_6.ignoreall = 1;
      var_6.ignoreme = 1;
      var_7 = var_6.script_forcecolor;
      var_6.animname = "emp_stand_pain_01";
      var_4 scripts\sp\anim::anim_reach_solo(var_6, "flare_drop");
      var_4 thread scripts\common\anim::anim_loop_solo(var_6, "flare_drop", "stop_drop");
      var_4 notify("stop_drop");
      var_6 scripts\engine\sp\utility::set_force_color("g");
      var_6.ignoreall = 0;
      var_6.ignoreme = 0;
    }
  }
}

friendly_flare_sender_loop(var_0, var_1) {
  level endon("wave_2_end");
  level endon("wave_3_end");
  level endon("wave_4_end");
  level endon("kill_friendly_flares");
  var_2 = 4;
  scripts\engine\utility::flag_set("flare_loop_on");

  if(scripts\sp\starts::is_after_start("laser_targeting_1"))
    var_2 = 0;

  if(scripts\engine\utility::flag("perimeter_breached"))
    var_2 = 0;

  var_3 = ["dx_vom_alx_defend_grounds_30", "dx_vom_alx_defend_grounds_40", "dx_vom_alx_defend_grounds_50"];
  var_4 = scripts\engine\sp\utility::create_deck(var_3);
  level.support_mortar_tube.shell = "j_mortar_shell";
  level.support_mortar_tube showpart(level.support_mortar_tube.shell, "misc_wm_mortar");
  level.support_mortar_tube scripts\engine\sp\utility::assign_animtree("enemy_mortar");
  level.support_mortar_tube scripts\common\anim::anim_first_frame_solo(level.support_mortar_tube, "flare_enter_aq");
  var_5 = [level.support_mortar_tube, level.alex];

  while(scripts\engine\utility::flag("flare_loop_on")) {
    level.alex.ignoreme = 1;
    level.alex.ignoreall = 1;
    level.support_mortar_tube scripts\sp\anim::anim_reach_solo(level.alex, "flare_enter_aq");
    level.alex scripts\engine\sp\utility::set_goal_radius(10);

    if(scripts\engine\utility::flag("flares_out"))
      scripts\engine\utility::flag_waitopen("flares_out");

    level.support_mortar_tube showpart(level.support_mortar_tube.shell, "misc_wm_mortar");
    level.alex scripts\engine\utility::delaythread(1, scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter, var_4 scripts\engine\sp\utility::deck_draw(), 0, 1);
    level.support_mortar_tube scripts\common\anim::anim_single(var_5, "flare_enter_aq");
    thread scripts\engine\utility::flag_set_delayed("flare_north", 0.5);
    level.support_mortar_tube thread scripts\common\anim::anim_single(var_5, "flare_launch_aq");
    level.alex waittillmatch("single anim", "end");
    level.support_mortar_tube scripts\common\anim::anim_single_solo(level.alex, "flare_exit_aq");
    level.support_mortar_tube scripts\common\anim::anim_first_frame_solo(level.support_mortar_tube, "flare_enter_aq");
    level.support_mortar_tube notify("stop_flare_support_loop");
    level.alex.ignoreme = 0;
    level.alex.ignoreall = 0;
    var_6 = getnode("alex_mortar_node", "targetname");
    level.alex setgoalnode(var_6);
    level.alex allowedstances("crouch", "stand");
    scripts\engine\utility::flag_wait("flares_out");

    if(isDefined(var_1)) {
      break;
    }

    while(level.flare_countdown > 1)
      wait 0.1;

    level.alex setgoalpos(level.support_mortar_tube.origin);
    level.alex scripts\engine\sp\utility::set_goal_radius(20);
  }

  level.alex scripts\engine\sp\utility::enable_ai_color();
  level.alex allowedstances("crouch", "stand", "prone");
}

guy_reveal() {
  self endon("death");
  self.ignoreme = 0;
}

enemy_alive_counter_gate(var_0) {
  wait 0.2;
  var_1 = getaiarray("axis");

  while(var_1.size > var_0) {
    var_1 = getaiarray("axis");
    wait 0.1;
  }

  return 0;
}

wave_1_technical_01() {
  scripts\engine\utility::flag_wait("enemies_at_the_wall");
  level.technical_01 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_01");
  level.technical_01.maxhealth = 34000;
  level.technical_01 setnormalhealth(1);
  level.technical_01.donotunloadonend = 1;
  level.technical_01 scripts\common\vehicle::godon();
  level.technicals[level.technicals.size] = level.technical_01;
  level.technical_01_gunner = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_01");
  level.technical_01 hidepart("tag_roof_wheel", "veh8_civ_lnd_techo_rebel");
  var_0 = getEnt("technical_dude_gunner_clip", "targetname");
  var_0.origin = var_0.origin + (5, -10, 5);
  var_0 linkTo(level.technical_01);
  level.technical_01_gunner forceteleport(var_0.origin + (0, 0, 0), level.technical_01_gunner.angles);
  level.technical_01_gunner linkTo(var_0);
  var_1 = scripts\sp\utility::make_weapon("iw8_lm_pkilo");
  level.technical_01_gunner scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
  level.technical_01_gunner.baseaccuracy = 0.1;
  level.technical_01_gunner allowedstances("stand");
  level.technical_01_gunner thread gunner_death_watcher(level.technical_01);
  level.technical_01_gunner.deathanim = % emb_def_truck_driver_death;
  var_2 = scripts\engine\utility::getStruct("technical_magic_bullet_struct", "targetname");
  var_3 = level.technical_01_gunner gettagorigin("j_head");
  var_4 = getvehiclenode("technical_start_01", "targetname");
  wait 4;
  level.technical_01 thread technical_lights();
  level.technical_01 scripts\common\vehicle::attach_vehicle_and_gopath(var_4);
  thread sfx_technical_drive_in(level.technical_01, "scn_embassy_technical_drive_in");
  wait 1;
  level.technical_01_gunner.secondaryweapon = "none";

  while(level.technical_01.veh_speed)
    wait 0.1;

  level.technical_01 scripts\common\vehicle::godoff();
  level.technical_01.regenerate = 0;
  level notify("technical_01_stopped");
  level.technical_01 notify("technical_01_stopped");
  level.technical_01.maxhealth = 20000;
  var_5 = getEntArray("technical_dudes_01", "targetname");

  foreach(var_7 in var_5)
  var_7 setgoalvolumeauto(level.front_goal_vol, level.field_cover_direction);

  while(level.flare_countdown > 0)
    wait 7;

  scripts\engine\utility::flag_wait("wave_1_3_ending");

  if(isDefined(level.technical_01_gunner)) {
    magicbullet("iw8_sn_mike14", var_2.origin, var_3);
    waitframe();
    level.technical_01_gunner kill();
  }
}

technical_lights() {
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_technical_brakelight_left"), self, "tag_light_back_left");
  playFXOnTag(scripts\engine\utility::getfx("vfx_technical_brakelight_right"), self, "tag_light_back_right");
  scripts\engine\utility::waittill_any("death", "technical_01_stopped");
  waitframe();
  stopFXOnTag(scripts\engine\utility::getfx("vfx_technical_brakelight_left"), self, "tag_light_back_left");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_technical_brakelight_right"), self, "tag_light_back_right");
}

wave_4_technical_02() {
  var_0 = spawnStruct();
  var_0.origin = (4140, 896, 24);
  var_1 = 0.93969;
  var_2 = gettime();
  var_3 = 10000;

  for(;;) {
    if(gettime() > var_2 + var_3 || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_1)) {
      break;
    } else
      wait 0.1;
  }

  level.technical_02 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_02");
  level.technical_02.maxhealth = 20000;
  level.technicals[level.technicals.size] = level.technical_02;
  level.technical_02_gunner = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_02");
  var_4 = getEnt("technical_dude_gunner_clip_02", "targetname");
  var_4.origin = var_4.origin + (0, 0, 4);
  var_4 linkTo(level.technical_02);
  level.technical_02_gunner forceteleport(var_4.origin + (0, 0, 0), level.technical_02_gunner.angles);
  level.technical_02_gunner linkTo(var_4);
  level.technical_02_gunner.ignoreme = 1;
  level.technical_02_gunner.ignoreall = 1;
  level.technical_02_gunner.noragdoll = 1;
  level.technical_02_gunner allowedstances("stand");
  level.technical_02_gunner thread gunner_death_watcher(level.technical_02);
  level.technical_02_gunner.secondaryweapon = "none";
  level.technical_02_gunner thread gunner_ignore_delay(7);
  var_5 = getvehiclenode("technical_start_02", "targetname");
  level.technical_02 scripts\common\vehicle::attach_vehicle_and_gopath(var_5);
  level.technical_02 scripts\common\vehicle::vehicle_lights_on();
  thread sfx_technical_drive_in(level.technical_02, "scn_embassy_technical_02_drive_in");
  level.technical_02 endon("death");
  wait 1;
  level.technical_02.regenerate = 0;

  while(level.technical_02.veh_speed && !scripts\engine\utility::flag("fire_rocket_at_technical"))
    wait 0.1;

  if(scripts\engine\utility::flag("fire_rocket_at_technical"))
    level waittill("hellfire_impact");

  level.technical_02.maxhealth = 21000;

  if(isalive(level.technical_02_gunner))
    level.technical_02_gunner.ignoreme = 0;

  var_6 = getEntArray("technical_dudes_02", "targetname");
  var_7 = getEnt("interior_main_grounds", "targetname");

  foreach(var_9 in var_6) {
    var_9 setgoalvolumeauto(var_7);
    var_9 scripts\engine\sp\utility::set_ignoresuppression(0);
    var_9 scripts\engine\sp\utility::set_goal_radius(300);
    var_9 setgoalentity(level.player);
    var_9 allowedstances("stand", "crouch");
  }

  if(level.technical_02.health >= 1 && !level.technical_02.veh_speed) {
    level notify("technical_achievement_fail");
    level.technical_02 scripts\common\vehicle::vehicle_lights_off("brakelights");
  }
}

gunner_ignore_delay(var_0) {
  self endon("death");
  wait(var_0);
  self.ignoreme = 0;
  self.ignoreall = 0;
}

wave_4_technical_03() {
  level.technical_03 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_03");
  var_0 = getEntArray("technical_dudes_03", "targetname");
  level.technical_03 scripts\common\vehicle::vehicle_lights_on();
  level.technical_03.maxhealth = 34000;
  level.technicals[level.technicals.size] = level.technical_03;
  level.technical_03_gunner = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_03");
  var_0 = scripts\engine\utility::array_add(var_0, level.technical_03_gunner);
  thread enemies_alive_watcher(var_0, "beam_technical_guys_killed");
  var_1 = getEnt("technical_dude_gunner_clip_03", "targetname");
  var_1.origin = var_1.origin + (0, 0, 0);
  var_1 linkTo(level.technical_03);
  level.technical_03_gunner forceteleport(var_1.origin + (0, 0, 0), level.technical_03_gunner.angles);
  level.technical_03_gunner linkTo(var_1);
  level.technical_03_gunner.ignoreme = 1;
  level.technical_03_gunner.noragdoll = 1;
  level.technical_03_gunner allowedstances("stand");
  level.technical_03_gunner thread gunner_death_watcher(level.technical_03);
  level.technical_03_gunner.secondaryweapon = "none";
  var_2 = getvehiclenode("technical_start_03", "targetname");
  level.technical_03 scripts\common\vehicle::attach_vehicle_and_gopath(var_2);
  level.technical_03 endon("death");
  level.technical_03 thread truck_street_death_watcher();
  thread sfx_technical_drive_in(level.technical_03, "scn_embassy_technical_03_drive_in");
  wait 1;
  level.technical_03.regenerate = 0;

  while(level.technical_03.veh_speed && !scripts\engine\utility::flag("fire_rocket_at_technical"))
    wait 0.1;

  if(scripts\engine\utility::flag("fire_rocket_at_technical"))
    level waittill("hellfire_impact");

  level.technical_03.maxhealth = 21000;
  var_3 = getEntArray("technical_dudes_03", "targetname");
  var_4 = getEnt("interior_main_grounds", "targetname");

  foreach(var_6 in var_3) {
    var_6 setgoalvolumeauto(var_4);
    var_6 scripts\engine\sp\utility::set_ignoresuppression(0);
    var_6 scripts\engine\sp\utility::set_goal_radius(300);
    var_6 scripts\engine\sp\utility::set_favoriteenemy(level.price);
    var_6 setgoalentity(level.price);
    var_6 allowedstances("stand", "crouch");
  }

  if(isalive(level.technical_03_gunner))
    level.technical_03_gunner.ignoreme = 0;

  if(level.technical_03.health >= 1 && !level.technical_03.veh_speed) {
    level notify("technical_achievement_fail");
    level.technical_03 scripts\common\vehicle::vehicle_lights_off("brakelights");
  }
}

wave_4_technical_09() {
  level.technical_09 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_09");
  var_0 = getEntArray("technical_dudes_09", "targetname");
  level.technical_09 scripts\common\vehicle::vehicle_lights_on();
  level.technical_09.maxhealth = 34000;
  level.technicals[level.technicals.size] = level.technical_09;
  thread enemies_alive_watcher(var_0, "beam_technical_guys_killed");
  var_1 = getvehiclenode("technical_start_09", "targetname");
  level.technical_09 scripts\common\vehicle::attach_vehicle_and_gopath(var_1);
  thread sfx_technical_drive_in(level.technical_09, "scn_embassy_technical_09_drive_in");
  wait 1;
  level.technical_09.regenerate = 0;
  level.technical_09 endon("death");
  level.technical_09 vehicle_setspeed(25, 10, 5);

  while(level.technical_09.veh_speed && !scripts\engine\utility::flag("fire_rocket_at_technical"))
    wait 0.1;

  if(scripts\engine\utility::flag("fire_rocket_at_technical"))
    level waittill("hellfire_impact");

  level.technical_09.maxhealth = 21000;
  var_2 = getEntArray("technical_dudes_09", "targetname");
  var_3 = getEnt("interior_main_grounds", "targetname");

  foreach(var_5 in var_2) {
    var_5 setgoalvolumeauto(var_3);
    var_5 scripts\engine\sp\utility::set_ignoresuppression(0);
    var_5 scripts\engine\sp\utility::set_goal_radius(300);
    var_5 scripts\engine\sp\utility::set_favoriteenemy(level.price);
    var_5 setgoalentity(level.price);
    var_5 allowedstances("stand", "crouch");
  }

  if(level.technical_09.health >= 1 && !level.technical_09.veh_speed) {
    level notify("technical_achievement_fail");
    level.technical_09 scripts\common\vehicle::vehicle_lights_off("brakelights");
  }
}

wave_4_technical_10() {
  level.technical_10 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_10");
  var_0 = getEntArray("technical_dudes_10", "targetname");
  level.technical_10 scripts\common\vehicle::vehicle_lights_on();
  level.technical_10.maxhealth = 34000;
  level.technicals[level.technicals.size] = level.technical_10;
  thread enemies_alive_watcher(var_0, "beam_technical_guys_killed");
  var_1 = getvehiclenode("technical_start_10", "targetname");
  level.technical_10 scripts\common\vehicle::attach_vehicle_and_gopath(var_1);
  thread sfx_technical_drive_in(level.technical_10, "scn_embassy_technical_10_drive_in");
  wait 1;
  level.technical_10.regenerate = 0;
  level.technical_10 endon("death");
  level.technical_10 vehicle_setspeed(25, 10, 5);

  while(level.technical_10.veh_speed && !scripts\engine\utility::flag("fire_rocket_at_technical"))
    wait 0.1;

  if(scripts\engine\utility::flag("fire_rocket_at_technical"))
    level waittill("hellfire_impact");

  level.technical_10.maxhealth = 21000;
  var_2 = getEntArray("technical_dudes_10", "targetname");
  var_3 = getEnt("interior_main_grounds", "targetname");

  foreach(var_5 in var_2) {
    var_5 setgoalvolumeauto(var_3);
    var_5 scripts\engine\sp\utility::set_ignoresuppression(0);
    var_5 scripts\engine\sp\utility::set_goal_radius(300);
    var_5 scripts\engine\sp\utility::set_favoriteenemy(level.price);
    var_5 setgoalentity(level.price);
    var_5 allowedstances("stand", "crouch");
  }

  if(level.technical_10.health >= 1 && !level.technical_10.veh_speed) {
    level notify("technical_achievement_fail");
    level.technical_10 scripts\common\vehicle::vehicle_lights_off("brakelights");
  }
}

wave_6_technical_04() {
  level.technical_04 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_04");
  level.technical_04 scripts\common\vehicle::vehicle_lights_on();
  level.technical_04.maxhealth = 25000;
  level.technical_04 scripts\common\vehicle::godon();
  level.technical_04 setnormalhealth(1);
  level.technicals[level.technicals.size] = level.technical_04;
  var_0 = getvehiclenode("technical_start_04", "targetname");
  level.technical_04 scripts\common\vehicle::attach_vehicle_and_gopath(var_0);
  wait 1;
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_13");
  level.technical_04 scripts\common\vehicle::godoff();
  level.technical_04.maxhealth = 22000;
  level.technical_04.regenerate = 0;
  level.technical_04 scripts\common\vehicle::vehicle_lights_off();
}

wave_6_technical_05() {
  level.technical_05 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_05");
  level.technical_05.maxhealth = 25000;
  level.technical_05 setnormalhealth(1);
  level.technical_05 scripts\common\vehicle::godon();
  level.technicals[level.technicals.size] = level.technical_05;
  var_0 = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_05");
  var_1 = getEnt("technical_dude_gunner_clip_05", "targetname");
  var_1.origin = var_1.origin + (0, 0, 0);
  var_1 linkTo(level.technical_05);
  var_0 forceteleport(var_1.origin + (0, 0, 0), var_0.angles);
  var_0 linkTo(var_1);
  var_0.noragdoll = 1;
  var_0 allowedstances("crouch");
  var_0 thread gunner_death_watcher(level.technical_05);
  var_0 scripts\engine\sp\utility::set_favoriteenemy(level.alex);
  var_2 = scripts\engine\utility::spawn_script_origin(level.alex.origin + (0, 0, 100));
  var_0 setentitytarget(var_2, 0.7);
  var_3 = getvehiclenode("technical_start_05", "targetname");
  level.technical_05 scripts\common\vehicle::attach_vehicle_and_gopath(var_3);
  wait 1;

  if(isDefined(var_0))
    var_0 thread scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq4_defend_battlecry_51");

  while(level.technical_05.veh_speed)
    wait 0.1;

  level.technical_05 scripts\common\vehicle::godoff();
  level.technical_05 scripts\common\vehicle::vehicle_lights_off("brakelights");
  level.technical_05.maxhealth = 20900;
  level.technical_05.regenerate = 0;

  if(isalive(var_0)) {
    var_0 clearentitytarget();
    var_0 getenemyinfo(level.player);
    var_0 allowedstances("crouch", "stand");
  }
}

wave_6_technical_06() {
  level.technical_06 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_06");
  level.technical_06 scripts\common\vehicle::vehicle_lights_on();
  level.technical_06.maxhealth = 25000;
  level.technical_06 setnormalhealth(1);
  level.technicals[level.technicals.size] = level.technical_06;
  level.technical_06 scripts\common\vehicle::godon();
  var_0 = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_06");
  var_1 = getEnt("technical_dude_gunner_clip_06", "targetname");
  var_1.origin = var_1.origin + (0, 0, 0);
  var_1 linkTo(level.technical_06);
  var_0 forceteleport(var_1.origin + (0, 0, 0), var_0.angles);
  var_0 linkTo(var_1);
  var_0.ignoreme = 0;
  var_0.noragdoll = 1;
  var_0 allowedstances("stand");
  var_0 thread gunner_death_watcher(level.technical_06);
  var_2 = scripts\engine\utility::spawn_script_origin(level.farah.origin + (0, 0, 100));
  var_0 setentitytarget(var_2, 0.5);
  var_3 = getvehiclenode("technical_start_06", "targetname");
  level.technical_06 scripts\common\vehicle::attach_vehicle_and_gopath(var_3);
  wait 1;

  while(level.technical_06.veh_speed)
    wait 0.1;

  level.technical_06 scripts\common\vehicle::godoff();
  level.technical_06.regenerate = 0;
  level.technical_06.maxhealth = 20400;
  level notify("stop_ignoring_player");
  level.technical_06 scripts\common\vehicle::vehicle_lights_off("brakelights");
}

wave_6_technical_07() {
  level.technical_07 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_07");
  level.technical_07 scripts\common\vehicle::vehicle_lights_on();
  level.technical_07.maxhealth = 25000;
  level.technical_07 setnormalhealth(1);
  level.technical_07 scripts\common\vehicle::godon();
  level.technicals[level.technicals.size] = level.technical_06;
  var_0 = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_07");
  var_1 = getEnt("technical_dude_gunner_clip_07", "targetname");
  var_1.origin = var_1.origin + (0, 0, 0);
  var_1 linkTo(level.technical_07);
  var_0 forceteleport(var_1.origin + (0, 0, 0), var_0.angles);
  var_0 linkTo(var_1);
  var_0.ignoreme = 0;
  var_0.noragdoll = 1;
  var_0 allowedstances("crouch");
  var_0 thread gunner_death_watcher(level.technical_07);
  var_2 = getvehiclenode("technical_start_07", "targetname");
  level.technical_07 scripts\common\vehicle::attach_vehicle_and_gopath(var_2);
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_13");
  level.technical_07 scripts\common\vehicle::godoff();
  level.technical_07.regenerate = 0;
  level.technical_07.maxhealth = 20400;
  level.technical_07 scripts\common\vehicle::vehicle_lights_off();
}

wave_6_technical_08() {
  level.technical_08 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_08");
  level.technical_08 scripts\common\vehicle::vehicle_lights_on();
  level.technical_08.maxhealth = 25000;
  level.technical_08 setnormalhealth(1);
  level.technicals[level.technicals.size] = level.technical_08;
  level.technical_08 scripts\common\vehicle::godon();
  level.technical_08 endon("death");
  var_0 = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_08");
  var_1 = getEnt("technical_dude_gunner_clip_08", "targetname");
  var_1.origin = var_1.origin + (-10, 0, 0);
  var_1 linkTo(level.technical_08);
  var_0 forceteleport(var_1.origin + (0, 0, 0), var_0.angles);
  var_0 linkTo(var_1);
  var_0.noragdoll = 1;
  var_0 allowedstances("stand");
  var_0 thread gunner_death_watcher(level.technical_08);
  var_2 = scripts\engine\utility::spawn_script_origin(level.alex.origin + (0, 0, 100));
  var_0 setentitytarget(var_2, 0.7);
  var_3 = getvehiclenode("technical_start_08", "targetname");
  level.technical_08 scripts\common\vehicle::attach_vehicle_and_gopath(var_3);
  wait 1;
  thread wave_6_technical_08_gunner_behavior(var_0);

  while(isDefined(level.technical_08) && level.technical_08.veh_speed)
    wait 0.1;

  level.technical_08 scripts\common\vehicle::godoff();
  level.technical_08.regenerate = 0;
  level.technical_08.maxhealth = 20400;
  level notify("stop_ignoring_player");
  level.technical_08 scripts\common\vehicle::vehicle_lights_off("brakelights");
}

wave_6_technical_08_gunner_behavior(var_0) {
  level waittill("stop_ignoring_player");

  if(isalive(var_0)) {
    var_0.baseaccuracy = 0.4;
    var_0 clearentitytarget();
    var_0 getenemyinfo(level.player);
    var_0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
    var_0 allowedstances("crouch", "stand");
  }
}

gunner_death_watcher(var_0) {
  self endon("death");
  var_0 waittill("death");
  self kill();
}

shoot_out_field_lights(var_0) {
  wait 0.3;

  if(isDefined(var_0))
    wait 0.1;

  var_1 = getscriptablearray("field_light_pole", "script_noteworthy");

  foreach(var_3 in var_1) {
    var_3 dontinterpolate();
    var_3.origin = var_3.og_origin;
    var_3.dummy delete();
  }

  var_5 = scripts\engine\utility::getStructArray("perimiter_light_faux_shooters", "targetname");
  var_5 = scripts\engine\utility::array_randomize(var_5);
  var_6 = [];
  var_7 = getEnt("field_street_lamps_1", "targetname");
  var_7.child = getEnt("field_street_lamps_1_child_1", "targetname");
  var_6[var_6.size] = var_7;
  var_7 = getEnt("field_street_lamps_2", "targetname");
  var_7.child = getEnt("field_street_lamps_2_child_1", "targetname");
  var_6[var_6.size] = var_7;
  var_7 = getEnt("field_street_lamps_3", "targetname");
  var_7.child = getEnt("field_street_lamps_3_child_1", "targetname");
  var_6[var_6.size] = var_7;
  var_7 = getEnt("field_street_lamps_4", "targetname");
  var_7.child = getEnt("field_street_lamps_4_child_1", "targetname");
  var_6[var_6.size] = var_7;
  scripts\engine\utility::array_thread(var_6, ::field_light_ondamage);

  if(isDefined(var_0)) {
    foreach(var_7 in var_6)
    var_7 notify("damage");

    return;
  }

  var_6 = scripts\engine\utility::array_randomize(var_6);
  var_10 = 0;

  foreach(var_7 in var_6) {
    if(isDefined(var_7.isdead)) {
      continue;
    }
    if(var_10 > var_5.size) {
      var_10 = 0;
      var_5 = scripts\engine\utility::array_randomize(var_5);
    }

    var_12 = var_7 scripts\engine\sp\utility::get_linked_struct();
    thread shoot_out_lights_thread(var_7, var_5[var_10].origin, var_12.origin);
    wait(randomfloatrange(0.7, 1.5));
    var_10++;
  }
}

field_light_ondamage() {
  self waittill("damage", var_0);
  self.isdead = 1;
  self setlightintensity(0);
  self.child setlightintensity(0);

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = scripts\engine\sp\utility::get_linked_struct();
  var_2 = vectortoangles(scripts\engine\utility::flat_origin(var_0) - scripts\engine\utility::flat_origin(self.origin)) + (0, 135, 0);
  var_3 = anglesToForward(var_2);
  radiusdamage(var_1.origin, 20, 100, 100, level.player, "MOD_PISTOL_BULLET");
  playFX(scripts\engine\utility::getfx("spark_shower"), var_1.origin, var_3);
}

shoot_out_perimeter_lights(var_0) {
  wait(randomfloatrange(3, 5));
  var_1 = getscriptablearray("perimeter_lights", "targetname");
  var_2 = scripts\engine\utility::getStructArray("perimiter_light_faux_shooters", "targetname");
  var_2 = scripts\engine\utility::array_randomize(var_2);

  if(isDefined(var_0)) {
    foreach(var_4 in var_1)
    var_4 setscriptablepartstate("onoff", "off");

    return;
  }

  scripts\engine\utility::flag_wait("wave_1_shoot_out_lights");
  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_6 = 0;

  foreach(var_4 in var_1) {
    if(isDefined(var_4.isdead)) {
      continue;
    }
    if(var_6 > var_2.size) {
      var_6 = 0;
      var_2 = scripts\engine\utility::array_randomize(var_2);
    }

    thread shoot_out_lights_thread(var_4, var_2[var_6].origin);
    wait(randomfloatrange(1, 2));
    var_6++;
  }
}

shoot_out_lights_thread(var_0, var_1, var_2) {
  var_3 = randomintrange(2, 3);
  var_4 = "iw8_ar_akilo47";
  var_5 = scripts\engine\utility::getfx("akilo_muzzle_flash");

  if(!isDefined(var_2))
    var_2 = var_0.origin;

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_7 = var_2 + scripts\engine\utility::randomvectorrange(-40, 40);
    var_8 = vectorNormalize(var_7 - var_1);
    playFX(var_5, var_1, var_8);
    magicbullet(var_4, var_1, var_7);
    wait(randomfloatrange(0.05, 0.3));
  }

  if(!isDefined(var_0.script_prefab_exploder)) {
    var_8 = vectorNormalize(var_2 - var_1);
    playFX(var_5, var_1, var_8);
  }

  magicbullet(var_4, var_1, var_2);
  wait 0.05;

  if(!isDefined(var_0.isdead)) {
    if(isDefined(var_0.script_prefab_exploder))
      scripts\engine\utility::exploder(var_0.script_prefab_exploder);

    var_0 notify("damage", var_1);
    radiusdamage(var_2, 5, 100, 100, undefined, "MOD_PISTOL_BULLET");
  }

  var_3 = randomintrange(1, 3);
  var_9 = 0.1;

  for(var_6 = 0; var_6 < var_3; var_6++) {
    wait(randomfloatrange(0.2, 0.4) + var_9);
    var_9 = var_9 + randomfloatrange(0.2, 0.4);
    var_7 = var_2 + scripts\engine\utility::randomvectorrange(-30, 30);
    var_8 = vectorNormalize(var_7 - var_1);
    playFX(var_5, var_1, var_8);
    magicbullet(var_4, var_1, var_7);
  }
}

perimeter_light_ondeath(var_0, var_1) {
  var_0 waittill("death");
  var_0.isdead = 1;

  if(distance2dsquared(level.player.origin, var_0.origin) > squared(500)) {
    return;
  }
  var_2 = vectortoangles(scripts\engine\utility::flat_origin(level.player.origin) - scripts\engine\utility::flat_origin(var_0.origin)) + (0, 135, 0);
  var_3 = anglesToForward(var_2);
  playFX(scripts\engine\utility::getfx("spark_shower"), var_0.origin + (0, 0, 0), var_3);
}

wave_2_enemy_mortar() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStruct("mortar_wave_1", "targetname");
  var_0 = scripts\engine\utility::getStructArray("mortar_array", "targetname");
  level.player_roof_mortars = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "player_roof")
      level.player_roof_mortars[level.player_roof_mortars.size] = var_3;
  }

  scripts\engine\utility::flag_set("enemy_mortar_allow_fire");
  thread enemy_mortar(var_1);
  level.enemy_mortar_end = level.east_wall_01 destructible_wall_mortar_end(1);
  level waittill("mortar_impact");
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_car_mortar_impt_01", (256, -450, 160));
  level.east_wall_01[0] notify("destroy");
  scripts\engine\utility::exploder("mortar1");

  if(scripts\engine\utility::flag("player_flaring")) {
    scripts\engine\utility::flag_clear("enemy_mortar_allow_fire");
    scripts\engine\utility::flag_waitopen("player_flaring");
    scripts\engine\utility::flag_set("enemy_mortar_allow_fire");
    scripts\engine\utility::flag_clear("enable_ilumination_flares");
  }

  level.enemy_mortar_end = level.first_roof_struct;
  level waittill("mortar_impact");
  scripts\engine\utility::exploder("mortar2");
  scripts\engine\utility::exploder("mortar2_tree");
  var_5 = getEnt("slide_trigger_01", "targetname");

  if(var_5 istouching(level.player)) {
    level.player disableinvulnerability();
    level.player kill();
  }

  scripts\sp\maps\embassy\embassy_lighting.gsc::start_tree_fire_flicker();
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_roof_mortar_impt_01", (42, -595, 210));
  scripts\engine\utility::trigger_on("slide_trigger_01", "targetname");
  thread disable_slide_trigger();
  waitframe();
  scripts\engine\utility::flag_set("enable_ilumination_flares");
  level.enemy_mortar_end = level.second_roof_struct;
  scripts\engine\utility::flag_set("roof_compromised");
  wait 1;
  scripts\engine\utility::flag_set("wave_3_mortars_roof_targeted");
  level waittill("mortar_impact");
  scripts\engine\utility::exploder("mortar3");
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_roof_mortar_impt_02", (258, -752, 210));
  thread sfx_jumpdown_amb_change();
  thread mus_retreat_cont();
  var_6 = getEnt("roof_mortar_wall_light_2", "targetname");

  if(isDefined(var_6))
    var_6 setlightintensity(0);

  level.east_gate = getEnt("eastgate_clip", "targetname");
  var_7 = scripts\engine\utility::getStruct("east_gate_struct", "targetname");
  var_7.origin = var_7.origin + (-10, 0, 0);
  level.enemy_mortar_end = var_7;
  level waittill("mortar_impact");
  var_8 = getEnt("east_gate_destroyed", "targetname");

  if(isDefined(var_8.target)) {
    var_9 = getEntArray(var_8.target, "targetname");
    scripts\engine\utility::array_call(var_9, ::show);
  }

  var_8 show();
  scripts\engine\utility::exploder("mortar4");
  var_10 = getEnt(level.east_gate.target, "targetname");
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_gate_mortar_impt_01", (316, -107, 102));

  if(isDefined(var_10.target)) {
    var_9 = getEntArray(var_10.target, "targetname");
    scripts\engine\utility::array_delete(var_9);
  }

  var_10 delete();
  level.east_gate connectpaths();
  level.east_gate delete();
  scripts\engine\utility::flag_set("east_gate_down");
  level.enemy_mortar_end = level.east_wall_03 destructible_wall_mortar_end(1);
  level waittill("mortar_impact");
  scripts\engine\utility::exploder("mortar5");
  level.east_wall_03[0] notify("destroy");
  level.enemy_mortar_end = level.east_wall_02 destructible_wall_mortar_end(1, 20);
  level waittill("mortar_impact");
  scripts\engine\utility::exploder("mortar6");
  scripts\engine\utility::exploder("mortar6_tree");
  level.east_wall_02[0] notify("destroy");
  level.enemy_mortar_end = level.east_wall_04 destructible_wall_mortar_end(1);
  level waittill("mortar_impact");
  scripts\engine\utility::exploder("mortar7");
  level.east_wall_04[0] notify("destroy");
  var_11 = spawnStruct();
  var_11.origin = (-1564, 1292, 93);
  var_11.angles = (0, 0, 0);
  level.enemy_mortar_end = var_11;
  level waittill("mortar_impact");
  scripts\engine\utility::exploder("firewall");
  radiusdamage((-1564, 1292, 93), 600, 1000, 1000, level.player);
  scripts\engine\utility::flag_set("perimeter_destroyed");
  level.mortar_round_delay_time = 2.5;
  level.enemy_mortar_end = level.east_wall_07 destructible_wall_mortar_end(1);
  level waittill("mortar_impact");
  level.east_wall_07[0] notify("destroy");
  var_12 = scripts\engine\utility::getStruct("roof_b_wall_struct", "script_noteworthy");
  level.enemy_mortar_end = var_12;
  level waittill("mortar_impact");
  var_12 notify("destroy");
  var_13 = scripts\engine\utility::getStruct("mortar_suv_struct", "script_noteworthy");
  level.enemy_mortar_end = var_13;
  level waittill("mortar_impact");
  scripts\engine\utility::flag_set("palm_01_damaged");
  scripts\engine\utility::flag_clear("enemy_mortar_allow_fire");
  thread mortar_locations_watcher();
  wait 3;
  scripts\engine\utility::flag_set("enemy_mortar_allow_fire");
}

sfx_jumpdown_amb_change() {
  wait 3;
  setaudiotriggerstate("combat_zone", "combat_lvl2", 5.0);
  setaudiotriggerstate("default", "combat_lvl2", 5.0);
}

mus_retreat_cont() {
  wait 2;
  setmusicstate("mx_embassy_retreat_cont");
  scripts\engine\utility::flag_wait("wave_2_end");
  setmusicstate("");
}

disable_slide_trigger() {
  scripts\engine\utility::delaythread(2, scripts\engine\utility::trigger_off, "slide_trigger_01", "targetname");
}

wave_5_enemy_mortar() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStruct("mortar_wave_4", "targetname");
  var_0 = scripts\engine\utility::getStructArray("mortar_array", "targetname");
  var_2 = spawnStruct();
  var_2.origin = (178.5, 937.5, 21.8);
  level.enemy_mortar_end = var_2;
  var_1 = scripts\engine\utility::getStruct("mortar_wave_4", "targetname");
  scripts\engine\utility::flag_set("enemy_mortar_allow_fire");
  scripts\engine\utility::flag_clear("mortar_vo_loop");
  thread enemy_mortar_house_mortar_guy(var_1, undefined, "mortar_team_2");
  level waittill("mortar_impact");
  thread mortar_locations_watcher();
  scripts\engine\utility::exploder("mortar8");
  level.east_wall_05[0] notify("destroy");
  scripts\engine\utility::flag_set("mortar_vo_loop");
  scripts\engine\utility::flag_clear("enemy_mortar_allow_fire");
  wait 7;
  scripts\engine\utility::flag_set("enemy_mortar_allow_fire");
}

wave_5_enemy_mortar_replacement() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStruct("mortar_wave_4", "targetname");
  level.player_roof_mortars = [];
  level.east_wall_mortars = [];
  var_2 = spawnStruct();
  var_2.origin = (-160, 585, 153);
  level.enemy_mortar_end = var_2;
  var_1 = scripts\engine\utility::getStruct("mortar_wave_4", "targetname");
  scripts\engine\utility::flag_set("enemy_mortar_allow_fire");
  thread enemy_mortar_house_mortar_guy(var_1, undefined, "mortar_team_3");
}

mortar_locations_watcher() {
  level endon("wave_2_end");
  level endon("wave_6_end");
  var_0 = scripts\engine\utility::getStructArray("mortar_array", "targetname");

  for(;;) {
    if(scripts\engine\utility::flag("enemy_mortar_manned")) {
      if(!scripts\engine\utility::flag("wave_6_end")) {
        if(!scripts\engine\utility::flag("mortar_try_kill_player")) {
          var_0 = sortbydistance(var_0, level.player.origin);
          var_1 = int(var_0.size / 1.5);
          var_2 = int(var_0.size / 1.5) + 1;
          var_3 = int(var_0.size / 1.5) - 1;
          var_4 = [var_1, var_2, var_3];
          level.enemy_mortar_end = var_0[scripts\engine\utility::random(var_4)];
        } else
          level.enemy_mortar_end = level.player;
      }

      wait 0.25;
      continue;
    }

    break;
  }
}

wave_3_player_on_roof_watcher() {
  level endon("enemy_mortar_manned");
  var_0 = 0;
  var_1 = getEnt("building_a_roof_trigger", "targetname");

  for(;;) {
    if(!level.player istouching(var_1))
      scripts\engine\utility::flag_set("mortar_try_kill_player");
    else
      scripts\engine\utility::flag_clear("mortar_try_kill_player");

    wait 0.3;
  }
}

wave_2_enemy_behavior() {
  self endon("death");
  self.grenadeammo = 0;
  self.flare_timer = level.flare_lifetime;
  scripts\engine\utility::ent_flag_init("flared");
  self.ignoreall = 1;
  scripts\engine\sp\utility::place_weapon_on(self.sidearm, "none");
  self.sidearm = isundefinedweapon();
  self dontcastshadows();
  thread ai_show_shadows_in_compound();
  self setgoalvolumeauto(level.front_goal_vol, level.field_cover_direction);
  scripts\engine\utility::set_movement_speed(250);
  scripts\engine\utility::waittill_any_timeout(17, "goal", "player_outside");
  scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::set_movement_speed(200);
  self.ignoreall = 0;
}

wave_3_building_enemy_behavior() {
  self endon("death");
  self.attackeraccuracy = 0;
  self.baseaccuracy = 0.01;
  self.grenadeammo = 0;
  scripts\engine\sp\utility::place_weapon_on(self.sidearm, "none");
  self.sidearm = isundefinedweapon();
  self.baseaccuracy = 0.1;
  self.flare_timer = level.flare_lifetime;
  scripts\engine\utility::ent_flag_init("flared");
  self.goalradius = 65;
  self.ignoreall = 1;
  self.ignoreme = 1;
  scripts\engine\sp\utility::disable_long_death();
  self waittill("goal");

  if(!isalive(self)) {
    return;
  }
  self.ignoreall = 0;
  self.ignoreme = 0;
}

wave_4_street_enemy_behavior() {
  self endon("death");

  if(self.classname == "actor_enemy_alq_desert_dmr")
    self.disablesniperbehaviors = 1;

  self.attackeraccuracy = 0;
  self.baseaccuracy = 0.5;
  self.grenadeammo = 2;
  self.ignoreall = 1;
  var_0 = scripts\engine\utility::get_target_ent();
  scripts\engine\utility::set_movement_speed(80);
  wait 2;
  scripts\engine\utility::flag_wait("street_guys_run");
  scripts\engine\utility::set_movement_speed(250);
  self setgoalnode(var_0);
  scripts\engine\utility::waittill_any_timeout(15, "reached_path_end", "goal");
  waitframe();
  scripts\engine\utility::waittill_any_timeout(5, "goal");
  scripts\engine\utility::set_movement_speed(180);
  self.ignoreall = 0;
  self.attackeraccuracy = 1;
  scripts\common\utility::demeanor_override("combat");
  self setgoalpos((1004, 1512, 48));
  scripts\engine\sp\utility::set_goal_radius(1000);
  scripts\engine\utility::flag_wait("beam_technical_guys_killed");
  enemy_alive_counter_gate(2);
  self setgoalpos(self.origin);
  scripts\engine\sp\utility::set_goal_radius(800);
  self setgoalpos((-176, -334, 48));
}

wave_4_corner_enemy_behavior() {
  scripts\engine\utility::flag_set("corner_guys_spawned");
  self endon("death");

  if(self.classname == "actor_enemy_alq_desert_dmr")
    self.disablesniperbehaviors = 1;

  self.attackeraccuracy = 0;
  self.baseaccuracy = 0.5;
  self.grenadeammo = 2;
  self.ignoreall = 1;
  scripts\engine\sp\utility::set_grenadeweapon("semtex");
  scripts\engine\utility::set_movement_speed(220);
  self setgoalpos((-176, -334, 48));
  scripts\engine\sp\utility::set_goal_radius(700);
  self endon("clear_spawn_func_logic");
  scripts\engine\utility::waittill_any_timeout(15, "reached_path_end", "goal");
  scripts\engine\utility::set_movement_speed(180);
  self.ignoreall = 0;
  self.attackeraccuracy = 1;
  scripts\common\utility::demeanor_override("combat");
}

wave_5_street_enemy_behavior() {
  self endon("death");
  self.grenadeammo = 20;
  scripts\engine\sp\utility::set_grenadeweapon("molotov");
  var_0 = (1614, 1732, 24);
  var_1 = 970;
  self setgoalpos(var_0);
  scripts\engine\sp\utility::set_goal_radius(var_1);
}

wave_5_mortar_run_enemy_behavior() {
  self endon("death");
  var_0 = getEnt("exterior_north_vol", "targetname");
  self setgoalvolumeauto(var_0, level.field_cover_direction);

  if(scripts\engine\utility::flag("mortar_house_field_path")) {
    var_0 = getEnt("exterior_north_vol_3", "targetname");
    self setgoalvolumeauto(var_0);
  }
}

mortar_house_guys_behavior() {
  self endon("death");

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "floor_guy")) {
    scripts\engine\sp\utility::trigger_wait_targetname("price_mortar_run_trigger_05");
    self getenemyinfo(level.player);
    scripts\engine\sp\utility::trigger_wait_targetname("mortar_living_room_trigger");
    self clearpath();
    scripts\engine\sp\utility::set_goal_radius(500);
    self setgoalentity(level.player);
    self.ignoreall = 0;
  }

  if(scripts\engine\utility::is_equal(self.script_namenumber, "bathroom")) {
    while(!self cansee(level.player))
      wait 0.2;

    self clearpath();
    scripts\engine\sp\utility::set_goal_radius(500);
    self setgoalentity(level.player);
  }
}

wave_1_technical_enemy_behavior_01() {
  self endon("death");
  self.ignoreme = 1;
  self.attackeraccuracy = 0.0;
  self setgoalvolumeauto(level.front_goal_vol, level.field_cover_direction);
  level waittill("technical_01_stopped");

  if(scripts\engine\utility::is_equal(self.script_startingposition, 0)) {
    self.allowdeath = 1;
    self.health = 1;
  }

  self.attackeraccuracy = 1.0;
  wait 1;
  self.ignoreme = 0;
}

wave_1_technical_gunner_spawn_func() {
  self endon("death");
  self.ignoreme = 1;
  self.secondaryweapon = "none";
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
}

wave_6_technical_04_enemy_behavior() {
  self endon("death");
  self.attackeraccuracy = 0.5;
  thread wave_6_drivers();
  self waittill("jumpedout");
  var_0 = getEnt("interior_grounds_east", "targetname");
  self setgoalvolumeauto(var_0);
}

wave_6_technical_05_enemy_behavior() {
  self endon("death");
  self.attackeraccuracy = 0.3;
  thread wave_6_drivers();
  self waittill("jumpedout");
  var_0 = getEnt("interior_grounds_center_wave_6", "targetname");
  self setgoalvolumeauto(var_0);
}

wave_6_technical_06_enemy_behavior() {
  self endon("death");
  thread wave_6_drivers();
  self waittill("jumpedout");
  self.baseaccuracy = 0.1;
  var_0 = getEnt("compound_entrance_volume", "targetname");
  self setgoalvolumeauto(var_0);
}

wave_6_technical_07_enemy_behavior() {
  self endon("death");
  self.attackeraccuracy = 0.3;
  thread wave_6_drivers();
  self waittill("jumpedout");
  self.baseaccuracy = 0.1;
  var_0 = getEnt("interior_grounds_center_wave_6", "targetname");
  self setgoalvolumeauto(var_0);
}

wave_6_technical_08_enemy_behavior() {
  self endon("death");
  self.attackeraccuracy = 0.3;
  thread wave_6_drivers();
  self.ignoreall = 1;
  self waittill("jumpedout");
  self.baseaccuracy = 0.2;
  var_0 = getnodearray("push_inside_path", "targetname");
  var_0 = sortbydistance(var_0, self.origin);
  scripts\engine\sp\utility::set_goal_radius(65);
  self setgoalnode(var_0[0]);
  scripts\engine\utility::waittill_any_timeout(12, "goal");
  self.ignoreall = 0;
  var_1 = getEnt("interior_grounds_center_wave_6", "targetname");
  self setgoalvolumeauto(var_1);
}

wave_6_drivers() {
  self endon("death");

  if(scripts\engine\utility::is_equal(self.script_startingposition, 0)) {
    self.ignorerandombulletdamage = 1;
    self.attackeraccuracy = 0;
    self waittill("jumpedout");
    self.ignorerandombulletdamage = 0;
    self.attackeraccuracy = 1;
  }
}

wave_4_technical_03_enemy_behavior() {
  self endon("death");
  scripts\engine\utility::ent_flag_init("flared");
  thread wave_6_drivers();
  self waittill("jumpedout");
  scripts\engine\sp\utility::set_goal_pos((-323, -334, 36));
  scripts\engine\sp\utility::set_goal_radius(500);
  scripts\engine\sp\utility::set_grenadeweapon("semtex");
  scripts\engine\utility::set_movement_speed(200);
  self.grenadeammo = 255;
}

dialogue_rooftops_approach() {}

dialogue_rooftops_wave_0() {
  thread dialogue_rooftops_wave_0_shooting_nags();
  thread dialogue_rooftops_wave_0_cafe();
  thread dialogue_distant_threat_callouts();
  thread dialogue_rooftops_wave_0_lights_shot();
}

dialogue_rooftops_wave_0_cafe() {
  level.player endon("death");
  level endon("firing_down_field");

  if(scripts\engine\utility::flag("firing_down_field")) {
    return;
  }
  thread price_field_nag();
  scripts\engine\utility::flag_wait_all("civ_life_start", "intro_vo_finished");
  var_0 = scripts\engine\utility::getStruct("spotter_animstruct", "targetname");

  if(scripts\sp\maps\embassy\embassy_util.gsc::wait_lookat_ads_or_timeout(var_0, 200, 4)) {
    wait 0.3;
    level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_cafe_10", 1, 1);
  } else {
    wait 0.3;
    level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_cafe_10", 1, 1);
  }

  scripts\engine\utility::flag_set("civ_spotters_start");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_cafe_20", 1);
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_intro_27");
  wait 1;
  var_1 = gettime();

  if(scripts\sp\maps\embassy\embassy_util.gsc::wait_lookat_ads_or_timeout(var_0, 200, 2))
    level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_cafe_30", 1);
  else
    level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_cafe_30", 1);

  var_2 = (gettime() - var_1) * 0.001;
  wait(max(0, 4 - var_2));
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_intro_26", 1);
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_cafe_40", 1);
  wait 1;
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_cafe_41", 1);
  wait 0.2;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_cafe_80", 1);
  wait 0.5;
  var_1 = gettime();

  if(scripts\sp\maps\embassy\embassy_util.gsc::wait_lookat_ads_or_timeout(var_0, 200, 1))
    level.player thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_cafe_82", 1);
  else
    level.alex thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_cafe_81", 1);

  scripts\engine\utility::flag_wait("table_civs_spooked");
  var_2 = (gettime() - var_1) * 0.001;
  wait(max(0, 3 - var_2));
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_cafe_43", 1);
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_cafe_44", 1);
  wait 2.5;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_cafe_46", 1);
  wait 2;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_cafe_47", 1);
  scripts\engine\utility::flag_set("wave_0_start_distant_threat");
  scripts\engine\utility::flag_wait("spawning_unknowns");
}

dialogue_rooftops_wave_0_shooting_nags() {
  level.player endon("death");
  level endon("wave_1_start");

  for(;;) {
    wait_shot_warning(1);
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_cafe_120", 1, 0.8);
    wait_shot_warning();

    if(!scripts\engine\utility::flag("wave_0_start_distant_threat")) {
      level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_cafe_130");
      wait_shot_warning();
    }

    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_roof_100", 1, 1);
    wait_shot_warning();
    level.hadir scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_had_defend_roof_120", 1, 1);
    scripts\engine\utility::flag_wait("distant_threat_complete");
    wait_shot_warning();
    level.alex thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_roof_190", 1, 1);
    level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_roof_130");
    wait_shot_warning();
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_roof_180", 1, 1);
    wait_shot_warning();
    level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_roof_110", 1, 1);
  }
}

wait_shot_warning(var_0) {
  if(!istrue(var_0))
    wait 2;

  level waittill("firing_down_field");
  wait 0.1;
  scripts\engine\sp\utility::player_dialogue_stop();
  wait 0.3;
  wait(scripts\sp\maps\embassy\embassy_util.gsc::wait_combat_cooldown(0.4, 1.5));
}

price_field_nag() {
  level.player endon("death");
  level endon("civ_life_start");

  for(;;) {
    wait 2;
    var_0 = (gettime() - level.getsniper_starttime) / 1000;
    wait(max(4 - var_0, 0));
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_roof_64");
    wait 4;
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_roof_63");
    wait 3;
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_roof_62");
  }
}

dialogue_distant_threat_callouts() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("spawning_unknowns");
  wait 2;
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_cafe_60", 1);
  wait 4;
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_cafe_70", 1);
  wait 4;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_cafe_72");
}

dialogue_rooftops_wave_0_lights_shot() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("distant_threat_complete");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_cafe_71");
  wait 1.5;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_cafe_100");
  wait 0.5;
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_cafe_110");
  wait 1;
  scripts\engine\utility::exploder("birdscare");
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_birds_field", (3304, -38, 147));
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_fieldintro_10");
  wait 0.5;
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_fieldintro_30");
  wait 2;
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_fieldintro_40");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_fieldintro_50");
  wait 2;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_roof_150");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_roof_160");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_roof_170");
  scripts\engine\utility::flag_set("wave_1_start");
}

dialogue_rooftops_wave_1() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("wave_1_shoot_out_lights");

  if(!scripts\engine\utility::flag("movement_skipped") && !scripts\engine\utility::flag("wave_1_vo_skipped")) {
    wait 2;
    level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_roof_70");
    wait 0.2;
    level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_roof_80");
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_roof_81");
    wait 0.1;
    level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_roof_90");
    wait 0.4;
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_roof_140");
    wait 0.5;
    level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_flarestart_21");
    wait 0.4;
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_flarestart_41");
  }

  scripts\engine\utility::flag_set("enable_ilumination_flares");
  wait 1;
  var_0 = [];
  var_0[var_0.size] = [level.price, "dx_vom_pri_defend_flarestart_40"];
  var_0[var_0.size] = [level.price, "dx_vom_pri_defend_flarestart_30"];
  var_0[var_0.size] = [level.alex, "dx_vom_alx_defend_flarestart_60"];
  var_0[var_0.size] = [level.price, "dx_vom_pri_defend_flarestart_50"];
  var_0[var_0.size] = [level.hadir, "dx_vom_had_defend_flarestart_10"];
  scripts\sp\maps\embassy\embassy_util.gsc::nagtill("player_flaring", var_0);
}

dialogue_rooftops_wave_1_post_flare() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("player_flaring");
  wait 1.5;
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_combat2_10", 1);
  scripts\engine\utility::flag_wait("flares_out");
  wait 1;
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_combat1_10");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_combat1_20");
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_combat1_30");
  wait 6;
  level.ally_02_mortar scripts\engine\sp\utility::smart_dialogue("dx_vom_us2_defend_combat1_40");
  wait 2.5;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_combat1_50");
  scripts\engine\utility::flag_waitopen("flares_out");
  wait 1;
  thread dialogue_wave_1_flare_2_chatter();
  scripts\engine\utility::flag_wait_any("player_flaring", "flare_2_skipped");

  if(!scripts\engine\utility::flag("flare_2_skipped")) {
    wait 2.3;
    level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_flarestart_71");
    scripts\engine\utility::flag_wait("flares_out");
    wait 1;
    level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_combat2_20");
    level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_combat2_30");
    level.hadir scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_had_defend_combat2_40");
    level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_taunt_30");
    scripts\engine\utility::flag_waitopen("flares_out");
    thread dialogue_wave_1_flare_3_chatter();
  }

  wait 1.8;
  scripts\engine\utility::flag_wait_any("player_flaring", "flare_2_skipped");

  if(!scripts\engine\utility::flag("flare_2_skipped")) {
    wait 1.8;
    level.player thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_flarestart_70", 1, 0.3);
    scripts\engine\utility::flag_wait("flares_out");
    thread dialogue_last_flare();
  } else
    wait 6;

  wait 0.5;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_combat3_40");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_combat3_30");
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_combat3_50");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_combat3_60");
  scripts\engine\utility::flag_wait("wave_1_falling_back");
  wait 4;
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_combat1_50");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_combat1_51");
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_trucks_20");
  wait 0.5;
  scripts\engine\utility::flag_set("wave_1_vo_finished");
}

dialogue_last_flare() {
  scripts\engine\utility::flag_waitopen("player_flaring");
  scripts\engine\utility::flag_wait("player_flaring");
  wait 1.2;
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_combat3_10", 1);
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_combat3_20", 1);
}

dialogue_wave_1_flare_2_chatter() {
  level.player endon("death");
  level endon("player_flaring");
  level endon("wave_1_falling_back");
  wait 1;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_chatter_10");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_chatter_11");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_chatter_12");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_chatter_13");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_chatter_14");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_chatter_15");
  wait 3;
  thread flarenag();
}

flarenag() {
  level endon("wave_1_falling_back");

  if(!isDefined(level.flarenags)) {
    var_0 = [];
    var_0[var_0.size] = [level.farah, "dx_vom_far_defend_grounds_101"];
    var_0[var_0.size] = [level.alex, "dx_vom_alx_defend_flarenags_10"];
    var_0[var_0.size] = [level.price, "dx_vom_pri_defend_flarenags_11"];
    var_0[var_0.size] = [level.price, "dx_vom_pri_defend_flarenags_12"];
    var_0[var_0.size] = [level.alex, "dx_vom_alx_defend_flarenags_13"];
    var_0[var_0.size] = [level.farah, "dx_vom_far_defend_flarenags_14"];
    var_0[var_0.size] = [level.price, "dx_vom_pri_defend_flarenags_15"];
    var_0[var_0.size] = [level.price, "dx_vom_pri_defend_flarenags_20"];
    var_0[var_0.size] = [level.price, "dx_vom_pri_defend_flarenags_21"];
    var_0[var_0.size] = [level.price, "dx_vom_pri_defend_flarenags_22"];
    var_0[var_0.size] = [level.hadir, "dx_vom_had_defend_flarenags_23"];
    var_0[var_0.size] = [level.alex, "dx_vom_alx_defend_flarenags_30"];
    var_0[var_0.size] = [level.price, "dx_vom_pri_defend_flarenags_31"];
    var_0[var_0.size] = [level.price, "dx_vom_pri_defend_flarenags_32"];
    var_0[var_0.size] = [level.alex, "dx_vom_alx_defend_flarenags_33"];
    var_0[var_0.size] = [level.hadir, "dx_vom_had_defend_flarenags_34"];
    level.flarenags = scripts\engine\sp\utility::create_deck(var_0);
  }

  scripts\sp\maps\embassy\embassy_util.gsc::nagtill("player_flaring", level.flarenags);
}

dialogue_wave_1_flare_3_chatter() {
  level.player endon("death");
  level endon("flares_out");
  level endon("player_flaring");
  level endon("wave_1_falling_back");
  wait 1;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_chatter_20");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_chatter_21");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_chatter_22");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_chatter_23");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_chatter_24");
  flarenag();
}

dialogue_rooftops_wave_2() {
  level.player endon("death");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_trucks_21");
  wait 1;
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_trucks_22");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_trucks_23");
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_trucks_24");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_trucks_31");
  level notify("round_count_done");
  scripts\engine\utility::flag_wait("player_looking_toward_trucks");
  wait 7;
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_trucks_40");
  wait 0.5;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_trucks_50");
  wait 1;
  level.ally_02_mortar scripts\engine\sp\utility::smart_dialogue("dx_vom_us2_defend_trucks_80");
  wait 0.5;
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_trucks_70");
  scripts\engine\utility::flag_wait("trucks_stopped");
}

dialogue_rooftops_wave_2_mortars() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("enemy_mortar_launched");
  wait 1;
  level.farah thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_mortars_20", 1);
  scripts\engine\utility::flag_waitopen("enemy_mortar_launched");
  scripts\engine\utility::flag_wait("enemy_mortar_launched");
  wait 0.5;
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_mortars_40", 1);
  level.ally_02_mortar thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_mortars_50", 1);
  level waittill("mortar_impact");
  wait 1;
  level.ally_02_mortar thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_mortars_60");
  var_0 = lookupsoundlength("dx_vom_us2_defend_mortars_60") / 1000;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_mortars_70", 1, var_0 - 0.3);
  thread off_the_roof_nags();
  wait 1;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_grounds_10", 1);
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_grounds_20", 1);
  scripts\engine\utility::flag_wait("east_gate_down");
  wait 2;
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_grounds_60");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_grounds_70");
  scripts\engine\utility::flag_wait("perimeter_breached");
  wait 4;
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_grounds_110");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_grounds_120");
}

nag_near_wall() {
  wait 10;
  var_0 = getEnt("push_fallback_trigger", "targetname");
  var_1 = ["dx_vom_pri_defend_grounds_150", "dx_vom_pri_defend_grounds_130", "dx_vom_pri_defend_grounds_140"];
  var_2 = scripts\engine\sp\utility::create_deck(var_1, 0);
  var_2.autoshuffle = 1;

  for(;;) {
    while(!level.player istouching(var_0) || getaiarray("axis").size <= 4)
      scripts\engine\utility::waittill_any_ents(var_0, "trigger", level, "ai_killed");

    level.price childthread scripts\sp\maps\embassy\embassy_util.gsc::nagtill("away_from_wall", var_2, 5, 1.6, 20);

    while(level.player istouching(var_0) && getaiarray("axis").size > 4)
      waitframe();

    level notify("away_from_wall");
  }
}

off_the_roof_nags() {
  level.player endon("death");
  level endon("perimeter_breached");
  var_0 = ["dx_vom_pri_defend_mortars_80", "dx_vom_pri_defend_mortars_90", "dx_vom_pri_defend_mortars_100"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  init_building_flags();
  wait 5;
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::nagtill_open("player_on_south_building", var_1, 6.5, 1.2, 20, 1.5);
}

dialogue_drag_scene() {
  level endon("wave_2_end");
  wait 3;
  level.ally_03 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us3_defend_mandown_10", 1);
  level.ally_04 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_mandown_20", 1);
  level.ally_03 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us3_defend_mandown_30", 1);
  level.ally_04 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_mandown_40", 1);
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_mandown_50", 1);
  wait 1;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_mandown_51", 1);
  wait 1;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_grounds_140");
  wait 0.3;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_grounds_101");
  childthread nag_near_wall();
  wait 3;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_fight_30");
  wait 4;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_fight_60");
  wait 7;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_fight_130");
}

dialogue_rooftops_wave_3() {
  level.player endon("death");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_resupply_10");
  thread scripts\engine\utility::flag_set_delayed("triage_watcher_start", 0.6);
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_resupply_20");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_resupply_30");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_resupply_40");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_resupply_43");
  resupply_nag();
  wait 0.5;
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_triage_30");
  wait 3;
  level.barracks_civ scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm1_topfloor_office_240");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_resupply_110");
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_resupply_120");
  wait 0.2;
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_kyle_defend_resupply_130");
  wait 1;
  level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_uavoperator_defend_resupply_41");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_resupply_42");
  wait 1.5;
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_intro_10");
  wait 0.4;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_intro_20");
  wait 0.3;
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_resupply_90");

  if(!scripts\engine\utility::flag("green_beam_acquired"))
    level scripts\engine\utility::waittill_either("price_triage_nag", "green_beam_acquired");

  var_0 = ["dx_vom_pri_defend_resupply_140", "dx_vom_pri_defend_resupply_150", "dx_vom_pri_defend_resupply_160"];
  level.price scripts\sp\maps\embassy\embassy_util.gsc::nagtill("green_beam_acquired", var_0, "price_triage_nag");
  wait 1;
  scripts\engine\utility::flag_wait("wave_3_inside");
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_building_fight_20", 1);
  wait 1;
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_building_fight_10", 1);
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_building_fight_20");
  wait 2;

  if(!level.player isonladder())
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_building_fight_30");
}

resupply_nag() {
  if(scripts\engine\utility::flag("triage_scene_started")) {
    return;
  }
  level endon("triage_scene_started");
  wait 6;
  var_0 = ["dx_vom_pri_defend_resupply_50", "dx_vom_pri_defend_resupply_60", "dx_vom_pri_defend_resupply_70"];
  level.price scripts\sp\maps\embassy\embassy_util.gsc::nagtill("triage_scene_started", var_0, 5);
}

get_on_north_roof_nag(var_0) {
  init_building_flags();

  if(scripts\engine\utility::flag("wave_3_end")) {
    return;
  }
  level endon("wave_3_end");
  var_1 = [];
  var_1[var_1.size] = [level.price, "dx_vom_pri_defend_building_fight_10"];
  var_1[var_1.size] = [level.hadir, "dx_vom_had_defend_building_fight_31"];
  var_1[var_1.size] = [level.price, "dx_vom_pri_defend_building_fight_32"];
  var_1[var_1.size] = [level.price, "dx_vom_pri_defend_building_fight_33"];
  var_1[var_1.size] = [level.price, "dx_vom_pri_defend_building_fight_50"];
  var_2 = scripts\engine\sp\utility::create_deck(var_1);
  level.price scripts\sp\maps\embassy\embassy_util.gsc::nagtill_delayed(8, "wave_3_inside", var_2, 5, 1.2, 12);
  wait 10;

  for(;;) {
    scripts\engine\utility::flag_waitopen("player_on_north_building");

    while(!level.player isonground() || level.player isonladder())
      waitframe();

    level.price scripts\sp\maps\embassy\embassy_util.gsc::nagtill("player_on_north_building", var_2, 5, 1.2, 12);
  }
}

dialogue_rooftops_wave_3_building() {
  thread get_on_north_roof_nag();
  scripts\engine\utility::flag_wait("player_on_north_building");
  scripts\engine\utility::flag_wait("allow_green_beam");
  level endon("allow_green_beam");
  childthread vo_beam_confirms();
  childthread vo_beam_hit();
  childthread vo_beam_ally_close();
  childthread vo_beam_nomark();
  childthread vo_beam_negative();
  childthread vo_beam_cooldown();

  if(level.start_point != "laser_targeting_2")
    level.price thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_greenbeam1_30");

  scripts\engine\utility::flag_set("drone_instructions");
}

vo_beam_confirms() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_kyle_defend_greenbeam1_110";
  var_0[var_0.size] = "dx_vom_uavoperator_defend_greenbeam1_150";
  var_0[var_0.size] = "dx_vom_kyle_defend_greenbeam1_120";
  var_0[var_0.size] = "dx_vom_uavoperator_defend_greenbeam1_160";
  var_0[var_0.size] = "dx_vom_kyle_defend_greenbeam1_130";
  var_0[var_0.size] = "dx_vom_uavoperator_defend_greenbeam1_170";
  var_0[var_0.size] = "dx_vom_kyle_defend_greenbeam1_140";
  var_0[var_0.size] = "dx_vom_uavoperator_defend_greenbeam1_180";
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;

  for(;;) {
    level waittill("green_beam_target_confirmed");
    level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 1);
  }
}

vo_beam_hit() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_uavoperator_defend_greenbeam1_190";
  var_0[var_0.size] = "dx_vom_uavoperator_defend_greenbeam1_200";
  var_0[var_0.size] = "dx_vom_uavoperator_defend_greenbeam1_210";
  var_0[var_0.size] = "dx_vom_uavoperator_defend_greenbeam1_220";
  var_0[var_0.size] = "dx_vom_uavoperator_defend_greenbeam1_230";
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_pri_defend_greenbeam1_240";
  var_0[var_0.size] = "dx_vom_pri_defend_greenbeam1_250";
  var_0[var_0.size] = "dx_vom_had_defend_greenbeam1_260";
  var_0[var_0.size] = "dx_vom_had_defend_greenbeam1_270";
  var_2 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_alx_defend_greenbeam2_100", "dx_vom_alx_defend_greenbeam2_110"];
  var_3 = scripts\engine\sp\utility::create_deck(var_0);
  var_4 = 0;

  for(;;) {
    level waittill("hellfire_killcount", var_5, var_6);

    if(scripts\engine\utility::flag("civ_car_spawn") && !scripts\engine\utility::flag("wave_4_technicals")) {
      continue;
    }
    wait 1;

    if(var_6 > 1 && !var_4) {
      var_4 = 1;
      level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_greenbeam2_130", 0, 1.5);
      continue;
    } else if(var_6 > 0) {
      level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(var_3 scripts\engine\sp\utility::deck_draw(), 0, 1.5);
      continue;
    }

    if(var_5 > 0) {
      level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 1.5);
      continue;
    }

    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(var_2 scripts\engine\sp\utility::deck_draw(), 0, 0.5);
  }
}

vo_beam_ally_close() {
  var_0 = ["dx_vom_uavoperator_uav_close_10", "dx_vom_uavoperator_uav_close_20", "dx_vom_uavoperator_uav_close_30"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level waittill("green_beam_error");

    if(level.player.greenbeamerror == "allies_too_close")
      level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 1);
  }
}

vo_beam_nomark() {
  var_0 = ["dx_vom_uavoperator_uav_nomark_10", "dx_vom_uavoperator_uav_nomark_20", "dx_vom_uavoperator_uav_nomark_30"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level waittill("green_beam_error");

    if(level.player.greenbeamerror == "hit_none")
      level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 1);
  }
}

vo_beam_negative() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_uavoperator_defend_greenbeam1_280";
  var_0[var_0.size] = "dx_vom_uavoperator_defend_greenbeam1_290";
  var_0[var_0.size] = "dx_vom_uavoperator_defend_greenbeam1_300";
  var_0[var_0.size] = "dx_vom_uavoperator_uav_reload_40";
  var_0[var_0.size] = "dx_vom_uavoperator_uav_reload_50";
  var_0[var_0.size] = "dx_vom_uavoperator_uav_reload_60";
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;

  for(;;) {
    level waittill("attempted_green_beam_while_reloading");
    level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 1);
  }
}

vo_beam_cooldown() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_uavoperator_uav_reload_10";
  var_0[var_0.size] = "dx_vom_uavoperator_uav_reload_20";
  var_0[var_0.size] = "dx_vom_uavoperator_uav_reload_30";
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_uavoperator_uav_mark_10";
  var_0[var_0.size] = "dx_vom_uavoperator_uav_mark_20";
  var_0[var_0.size] = "dx_vom_uavoperator_uav_mark_30";
  var_2 = scripts\engine\sp\utility::create_deck(var_0);
  scripts\engine\utility::flag_waitopen("beam_ammo_out");
  childthread vo_use_beam_nags();

  for(;;) {
    scripts\engine\utility::flag_wait("beam_down");
    level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 1);
    scripts\engine\utility::flag_waitopen("beam_down");
    level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(var_2 scripts\engine\sp\utility::deck_draw(), 0, 3);
    childthread vo_use_beam_nags(10);
  }
}

drone_nags_enable(var_0) {
  scripts\engine\utility::flag_clear("disable_drone_nags");
  thread vo_use_beam_nags();

  if(isDefined(var_0))
    wait(var_0);

  if(!scripts\engine\utility::flag("laser_marker_on"))
    scripts\engine\utility::flag_set("drone_instructions");
}

drone_nags_disable() {
  scripts\engine\utility::flag_set("disable_drone_nags");
}

vo_use_beam_nags(var_0) {
  level endon("beam_down");
  level endon("allow_green_beam");
  level endon("disable_drone_nags");

  if(scripts\engine\utility::flag("disable_drone_nags")) {
    return;
  }
  if(isDefined(var_0))
    wait(var_0);

  for(;;) {
    scripts\engine\utility::flag_waitopen("hellfire_launched");
    vo_use_beam_nag();
    check_add_beam_nags();
  }
}

vo_use_beam_nag() {
  level endon("hellfire_launched");
  check_init_beam_nags();
  wait 15;

  if(getaiarray("axis").size == 0) {
    return;
  }
  scripts\engine\utility::flag_set("drone_instructions");
  childthread scripts\sp\maps\embassy\embassy_util.gsc::nagtill("stop_beam_nags", level.beam_nags, 12, 1.3, 20);

  while(getaiarray("axis").size > 0)
    level waittill("ai_killed");

  level notify("stop_beam_nags");
}

check_init_beam_nags() {
  if(!isDefined(level.beam_nags)) {
    var_0 = [];
    var_0[var_0.size] = [level.price, "dx_vom_pri_defend_greenbeam1_40"];
    var_0[var_0.size] = [level.price, "dx_vom_pri_defend_greenbeam1_50"];
    var_0[var_0.size] = [level.price, "dx_vom_pri_defend_greenbeam1_60"];
    var_0[var_0.size] = [level.price, "dx_vom_pri_defend_greenbeam1_70"];
    var_0[var_0.size] = [level.alex, "dx_vom_alx_defend_greenbeam1_80"];
    var_0[var_0.size] = [level.alex, "dx_vom_alx_defend_greenbeam1_90"];
    var_0[var_0.size] = [level.alex, "dx_vom_alx_defend_greenbeam1_100"];
    level.beam_nags = scripts\engine\sp\utility::create_deck(var_0);
  }

  if(scripts\engine\utility::flag("wave_3_end") && !istrue(level.beam_nags.removed_building_lines)) {
    var_1 = ["dx_vom_pri_defend_greenbeam1_70", "dx_vom_alx_defend_greenbeam1_80", "dx_vom_alx_defend_greenbeam1_100", "dx_vom_far_defend_greenbeam1_330"];
    var_2 = [];

    foreach(var_4 in level.beam_nags.items) {
      if(!scripts\engine\utility::array_contains(var_1, var_4[1]))
        var_2[var_2.size] = var_4;
    }

    level.beam_nags.items = var_2;

    if(level.beam_nags scripts\engine\sp\utility::deck_is_empty())
      level.beam_nags scripts\sp\maps\embassy\embassy_util.gsc::array_deck_shuffle();

    level.beam_nags.removed_building_lines = 1;
  }
}

check_add_beam_nags() {
  if(scripts\engine\utility::flag("hellfire_launched") && !istrue(level.beam_nags.added_lines)) {
    var_0 = [];
    var_0[var_0.size] = [level.farah, "dx_vom_far_defend_greenbeam1_310"];
    var_0[var_0.size] = [level.farah, "dx_vom_far_defend_greenbeam1_320"];
    var_0[var_0.size] = [level.farah, "dx_vom_far_defend_greenbeam1_330"];
    var_0[var_0.size] = [level, "dx_vom_uavoperator_defend_greenbeam1_340"];
    var_0[var_0.size] = [level, "dx_vom_uavoperator_defend_greenbeam1_350"];
    var_0[var_0.size] = [level, "dx_vom_uavoperator_defend_greenbeam1_360"];
    level.beam_nags.items = scripts\engine\utility::array_combine(level.beam_nags.items, scripts\engine\utility::array_randomize(var_0));
    level.beam_nags.added_lines = 1;
  }
}

dialogue_rooftops_wave_4() {
  scripts\sp\maps\embassy\embassy_util.gsc::wait_combat_cooldown(1.2, 4);
  level endon("civ_car_death");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_greenbeam2_10");
  wait 2;
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_greenbeam2_150");
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_greenbeam2_160");
  wait 2;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_greenbeam2_40");
  level notify("move_east");
  level waittill("civ_car_spawn");
  level.civ_car endon("driver_death");
  level.civ_car endon("damage");
  wait 7;
  level.alex thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_civcar_10");
  wait 3;
  level.hadir thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_had_defend_civcar_20");
  wait 1.5;

  if(distance2dsquared(level.player.origin, level.hadir.origin) < squared(1300))
    level.player thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_civcar_30");

  wait 2.5;
  level.hadir thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_had_defend_civcar_40");
  wait 5;
  level.farah thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_civcar_50");
  wait 1;
  level.alex thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_civcar_60");
  wait 13;
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_civcar_70");
  level notify("civ_car_gone");
}

dialogue_rooftops_wave_4_technicals() {
  level endon("wave_4_end");
  drone_nags_enable(5);
  scripts\engine\utility::flag_set("wave_4_technicals");
  level thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_uavoperator_defend_greenbeam2_20");
  wait 2;
  level notify("drone_callout");
  level thread monitor_enemies_enter_perimeter();
  wait 0.5;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_greenbeam2_30");
  wait 2;
  scripts\engine\utility::flag_wait("street_guys_run");

  if(scripts\engine\sp\utility::getvehiclearray().size > 0)
    level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_greenbeam2_120");
  else
    wait 1;

  wait 1;
  level.farah thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_defend_greenbeam2_60");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_greenbeam2_50");
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_greenbeam2_70");
  scripts\engine\utility::flag_wait("wave_4_final_technical_spawn");
  wait 3;

  while(!get_vehicles_in_field().size)
    waitframe();

  level.hadir scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_had_defend_greenbeam2_80");
  wait 0.5;
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_greenbeam2_90");
}

get_vehicles_in_field() {
  var_0 = getEnt("field_cleanup_vol", "targetname");
  var_1 = getEnt("player_warn_trigger", "targetname");
  var_2 = scripts\engine\sp\utility::getvehiclearray();
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5 istouching(var_0) && var_5 istouching(var_1))
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

monitor_enemies_enter_perimeter() {
  level endon("wave_4_end");
  var_0 = getEnt("interior_main_grounds", "targetname");
  var_1 = 0;

  while(!var_1) {
    var_2 = getaiarray("axis");

    if(var_2.size == 0) {
      waitframe();
      continue;
    }

    foreach(var_4 in var_2) {
      waitframe();

      if(!isalive(var_4)) {
        continue;
      }
      if(var_4 istouching(var_0)) {
        var_1 = 1;
        break;
      }
    }
  }

  level.alex scripts\engine\sp\utility::smart_dialogue("dx_vom_alx_defend_greenbeam2_140");
  thread audio_defend_4_perimeter_zone_state();
}

audio_defend_4_perimeter_zone_state() {
  level endon("wave_4_end");
  setaudiotriggerstate("combat_zone", "combat_lvl2", 1);
  setaudiotriggerstate("default", "combat_lvl2", 1);
  wait 15;
  setaudiotriggerstate("combat_zone", "combat_lvl1", 3);
  setaudiotriggerstate("default", "combat_lvl1", 3);
}

dialogue_rooftops_wave_5() {
  thread player_pushing_house_watcher();
  scripts\engine\utility::flag_wait("enemy_mortar_allow_fire");
  level waittill("mortar_launch");
  wait 1;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_defend_mortar_building_10");
  level waittill("mortar_impact");
  wait 0.8;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_mortar_building_20");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_defend_mortar_building_30");
  level.alex scripts\engine\sp\utility::smart_dialogue("dx_vom_alx_defend_mortar_building_40");
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_defend_mortar_building_41");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_defend_mortar_building_42");
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_mortar_building_60");
  scripts\engine\utility::flag_set("mortar_team_objective");
  level.alex scripts\engine\sp\utility::smart_dialogue("dx_vom_alx_defend_mortar_building_61");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_defend_mortar_building_63");
  scripts\engine\utility::flag_wait("mortar_run_started");
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_defend_mortar_building_62");
  level.alex scripts\engine\sp\utility::smart_dialogue("dx_vom_alx_defend_mortar_building_80");
  level.ally_05 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_mortar_building_90");
  level.ally_06 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_mortar_building_100");
  thread dialogue_wave_5_marines();
  nag_say_with_hadir();
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_defend_mortar_building_180");
}

nag_say_with_hadir() {
  if(scripts\engine\utility::flag("player_pushing_house")) {
    return;
  }
  level endon("player_pushing_house");
  var_0 = [];
  var_0[var_0.size] = [level.alex, "dx_vom_alx_defend_mortar_building_110"];
  var_0[var_0.size] = [level.price, "dx_vom_pri_defend_mortar_building_120"];
  var_0[var_0.size] = [level.price, "dx_vom_pri_defend_mortar_building_130"];
  var_0[var_0.size] = [level.farah, "dx_vom_far_defend_mortar_building_131"];
  var_0[var_0.size] = [level.farah, "dx_vom_far_defend_mortar_building_132"];
  var_0[var_0.size] = [level.farah, "dx_vom_far_defend_mortar_building_133"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;

  for(;;) {
    while(level.player.origin[0] > 350 || level.player.origin[1] > 900)
      waitframe();

    level.player childthread scripts\sp\player::focus_display_hint(8, 6, level, "with_hadir");
    childthread scripts\sp\maps\embassy\embassy_util.gsc::nagtill_delayed(8, "with_hadir", var_1, 12, 1.2, 30);

    while(level.player.origin[0] < 350 && level.player.origin[1] < 900)
      waitframe();

    waitframe();
    level notify("with_hadir");
  }
}

dialogue_wave_5_marines() {
  scripts\engine\utility::flag_wait("player_pushing_house");
  level.ally_05 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us1_defend_mortar_building_140");
  wait 1;

  if(getaiarray("axis").size < 3) {
    return;
  }
  level.ally_06 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_us2_defend_mortar_building_150");

  if(!isalive(level.ally_06)) {
    return;
  }
  level.ally_05 waittill("death");
  wait 0.4;
  level.ally_05 scripts\engine\sp\utility::smart_dialogue("dx_vom_us1_defend_mortar_building_170");
}

player_pushing_house_watcher() {
  if(scripts\engine\utility::flag("wave_5_fall_back")) {
    scripts\engine\utility::flag_set("player_pushing_house");
    return;
  }

  level scripts\engine\utility::thread_on_notify("wave_5_fall_back", scripts\engine\utility::flag_set, "player_pushing_house");
  level endon("wave_5_fall_back");
  var_0 = getEnt("price_mortar_run_trigger_02", "targetname");
  scripts\engine\sp\utility::trigger_wait("price_mortar_run_trigger_02", "targetname");
  scripts\engine\utility::flag_set("player_pushing_house");
}

dialogue_rooftops_wave_6() {
  level.player endon("death");
  level endon("cleared_residence");
  wait 0.3;
  scripts\sp\maps\embassy\embassy_util.gsc::wait_combat_cooldown(0.8, 4);
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_mortar_interior_110");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_mortar_interior_115");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_defend_mortar_interior_120");
  wait_hadir_goal_or_flag("player_leaving_mortar_house");
  var_0 = ["dx_vom_had_wolf_escapes_combat_30", "dx_vom_had_wolf_escapes_combat_40", "dx_vom_had_wolf_escapes_combat_50"];
  level.hadir scripts\sp\maps\embassy\embassy_util.gsc::nagtill("player_leaving_mortar_house", var_0);
  wait 0.8;
  level.hadir scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_had_wolf_escapes_combat_60");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_wolf_escapes_combat_60");
  wait 4;
  level.farah scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_far_wolf_escapes_combat_70");
  wait 4;
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_wolf_escapes_combat_80");
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_wolf_escapes_combat_85");
  wait 4;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_wolf_escapes_combat_90");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_wolf_escapes_combat_110");
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_wolf_escapes_combat_120");
  wait 4;
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_wolf_escapes_combat_100");
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_wolf_escapes_combat_125");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_wolf_escapes_combat_130");
  wait 6;
  var_1 = [];
  var_1[var_1.size] = "dx_vom_pri_wolf_escapes_combat_131";
  var_1[var_1.size] = "dx_vom_pri_wolf_escapes_combat_132";
  var_1[var_1.size] = "dx_vom_pri_wolf_escapes_combat_133";
  var_1[var_1.size] = "dx_vom_pri_wolf_escapes_combat_140";
  var_1[var_1.size] = "dx_vom_pri_wolf_escapes_combat_150";
  var_0 = scripts\engine\sp\utility::create_deck(var_1, 0);
  var_0.autoshuffle = 1;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::nagtill("spawned_suicide_bomber", var_0, 8, 1.2, 20);
}

wait_hadir_goal_or_flag(var_0) {
  if(scripts\engine\utility::flag(var_0)) {
    return;
  }
  level endon(var_0);
  wait 2;
  level.hadir waittill("goal");
  wait 2;
}

enemy_flare_behavior() {
  self endon("death");
  scripts\engine\utility::ent_flag_wait("flared");

  if(!scripts\engine\utility::flag("front_2")) {
    wait 1;
    scripts\engine\utility::reacttolightifpossible(level.flare_light.origin);
  }

  while(self.flare_timer > 0) {
    self.attackeraccuracy = 1.0;
    self.baseaccuracy = 0.5;
    wait 1;
    self.flare_timer--;
  }

  scripts\engine\utility::ent_flag_clear("flared");

  if(!scripts\engine\utility::flag("roof_compromised")) {
    self.attackeraccuracy = 0.3;
    self.baseaccuracy = 2;
  }

  thread enemy_flare_behavior();
}

enemy_flare_behavior_wave_3() {
  self endon("death");
  scripts\engine\utility::ent_flag_wait("flared");

  while(self.flare_timer > 0) {
    self.attackeraccuracy = 1.5;
    self.baseaccuracy = 0.3;
    self.ignoreme = 0;
    wait 1;
    self.flare_timer--;
  }

  scripts\engine\utility::ent_flag_clear("flared");

  if(!scripts\engine\utility::flag("venom_first_attack")) {
    self.attackeraccuracy = 0.3;
    self.baseaccuracy = 1.5;
    thread enemy_flare_behavior_wave_3();
    return;
  } else
    self.attackeraccuracy = 1;

  self.baseaccuracy = 0.1;
}

haze_watcher() {
  var_0 = getEntArray("haze", "targetname");

  foreach(var_2 in var_0)
  var_2 hide();

  var_4 = 1;
  var_5 = 0.7;
  var_6 = 0.999;
}

enemy_mortar(var_0) {
  level endon("wave_2_end");
  scripts\engine\utility::flag_set("enemy_mortar_manned");
  scripts\engine\utility::flag_wait("enemy_mortar_allow_fire");

  if(isDefined(var_0))
    thread dx_mortar_launch_callout(var_0.origin);
  else
    thread dx_mortar_launch_callout((2828, 100, 30));

  wait 0.25;
  enemy_mortar_launch(var_0);
  wait(level.mortar_round_delay_time);
  thread enemy_mortar(var_0);
}

enemy_mortar_house_mortar_guy(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_3 = getspawner(var_2, "targetname");
    var_1 = var_3 scripts\engine\sp\utility::spawn_ai(1);
    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
    var_1.health = 10;
    var_1.animname = "aq_mortar";
    var_1.allowdeath = 1;
    var_1 scripts\sp\utility::context_melee_allow(0);
    scripts\engine\utility::flag_set("enemy_mortar_manned");
  }

  var_1 thread hide_shield_mortar_guy();
  scripts\engine\utility::flag_wait("enemy_mortar_allow_fire");

  if(!isalive(var_1)) {
    scripts\engine\utility::flag_clear("enemy_mortar_manned");
    return;
  }

  var_1 enemy_mortar_animations(var_0);
  scripts\engine\utility::flag_clear("enemy_mortar_manned");
}

enemy_mortar_animations(var_0) {
  self endon("death");
  self endon("mortar_guy_breakout");
  var_1 = getEnt("flare_mortar_tube_enemy", "targetname");
  self allowedstances("crouch");
  var_1 scripts\engine\sp\utility::assign_animtree("enemy_mortar");
  var_1 scripts\common\anim::anim_first_frame_solo(var_1, "flare_enter_aq");
  var_1 scripts\sp\anim::anim_reach_solo(self, "flare_enter_aq");
  var_1 scripts\common\anim::anim_single([var_1, self], "flare_enter_aq");
  thread mortar_guy_mortar_death(var_1);
  thread mortar_guy_breakout(var_1);
  thread mortar_tube_collapse(var_1);

  for(;;) {
    level.mortar_round_delay_time = randomfloatrange(10, 12.5);

    if(isDefined(var_0))
      thread dx_mortar_launch_callout(var_0.origin);
    else
      thread dx_mortar_launch_callout((2828, 100, 30));

    wait 0.25;
    var_1 thread scripts\common\anim::anim_single([var_1, self], "flare_launch_aq");
    wait(getanimlength(scripts\engine\utility::getanim("flare_launch_aq")) - 0.5);
    level notify("mortar_launch");
    thread enemy_mortar_launch(var_0);
    var_1 scripts\common\anim::anim_single([var_1, self], "flare_reload_aq");
    var_1 thread scripts\common\anim::anim_loop([var_1, self], "flare_aq_idle", "stop_loop");
    wait(level.mortar_round_delay_time);

    if(!scripts\engine\utility::flag("enemy_mortar_allow_fire"))
      scripts\engine\utility::flag_wait("enemy_mortar_allow_fire");

    var_1 notify("stop_loop");
  }
}

mortar_guy_mortar_death(var_0) {
  self endon("death");
  self endon("mortar_guy_breakout");
  self.allowdeath = 1;
  scripts\engine\utility::flag_wait("mortar_guy_breakout_watcher");

  if(!isalive(self)) {
    return;
  }
  scripts\engine\sp\utility::set_deathanim("mortar_guy_death");
  self waittill("death");
  var_0 notify("collapse_mortar");
}

mortar_guy_bullet_shield() {
  if(scripts\engine\utility::flag("house_enter_low_delay"))
    return;
}

hide_shield_mortar_guy() {
  if(scripts\engine\utility::flag("mortar_house_perimeter")) {
    return;
  }
  self hide();
  scripts\common\ai::magic_bullet_shield(1);
  scripts\engine\sp\utility::trigger_wait("mortar_house_grounds_trigger", "targetname");
  self show();
  scripts\common\ai::stop_magic_bullet_shield();
}

mortar_guy_breakout(var_0) {
  self endon("death");
  scripts\engine\utility::flag_wait("mortar_guy_breakout_watcher");
  var_1 = getnode("mortar_guy_roof_node", "targetname");

  if(!isalive(self)) {
    return;
  }
  thread damage_on_rooftop_enter();
  level thread rooftop_enter_watcher();
  self allowedstances("crouch");
  scripts\engine\utility::waittill_any("damage", "bulletwhizby");
  var_0 notify("stop_loop");
  wait 0.2;
  self notify("mortar_guy_breakout");
  self.ignoreall = 0;
  self getenemyinfo(level.player);
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  self setgoalnode(var_1);
  thread scripts\sp\spawner::go_to_node(var_1);
  self allowedstances("crouch");
  self.ignoreme = 0;
  self setgoalpos(self.origin);
  scripts\engine\sp\utility::set_goal_radius(64);
  scripts\engine\sp\utility::clear_deathanim();
  var_0 notify("stop_loop");
  waitframe();
  var_0 thread scripts\common\anim::anim_single_solo(self, "flare_exit_aq");
  wait 0.75;
  self getenemyinfo(level.player);
  self allowedstances("crouch", "stand");
  var_0 notify("collapse_mortar");
  var_0 hidepart(var_0.shell, "misc_wm_mortar");
  self stopanimScripted();

  for(;;) {
    self getenemyinfo(level.player);
    scripts\engine\sp\utility::set_favoriteenemy(level.player);
    wait 0.1;
  }
}

player_info() {}

mortar_tube_collapse(var_0) {
  scripts\engine\utility::flag_wait("mortar_guy_breakout_watcher");
  var_0 waittill("collapse_mortar");
  var_0 stopanimScripted();
  var_0 notify("stop_loop");
  var_0 scripts\common\anim::anim_single([var_0], "mortar_guy_death");
}

rooftop_enter_watcher() {
  scripts\engine\sp\utility::trigger_wait_targetname("price_mortar_run_trigger_08");
  scripts\engine\utility::flag_set("rooftop_enter");
}

damage_on_rooftop_enter() {
  self endon("death");
  scripts\engine\utility::flag_wait("rooftop_enter");
  self notify("damage");
}

dx_mortar_launch_callout(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(!isDefined(level.mortar_vo_ints))
    level.mortar_vo_ints = scripts\engine\sp\utility::create_deck([0, 1, 2]);

  var_3 = level.mortar_vo_ints scripts\engine\sp\utility::deck_draw();

  switch (var_3) {
    case 0:
      var_1 = "dx_vom_aq1_mortar_fire_10";
      var_2 = "dx_vom_aq1_mortar_fire_10_dist";
      break;
    case 1:
      var_1 = "dx_vom_aq1_mortar_fire_20";
      var_2 = "dx_vom_aq1_mortar_fire_20_dist";
      break;
    default:
      var_1 = "dx_vom_aq1_mortar_fire_30";
      var_2 = "dx_vom_aq1_mortar_fire_30_dist";
      break;
  }

  thread scripts\engine\utility::play_sound_in_space(var_1, var_0);
  thread scripts\engine\utility::play_sound_in_space(var_2, var_0);
}

enemy_mortar_launch(var_0) {
  scripts\engine\utility::flag_set("enemy_mortar_launched");
  thread scripts\engine\sp\utility::flag_clear_delayed("enemy_mortar_launched", 3);
  var_1 = 3000;
  var_2 = 3.25;
  var_3 = spawnStruct();
  var_3.origin = (5551, -851, 150);

  if(scripts\engine\utility::flag("wave_4_end")) {
    var_4 = getEnt("flare_mortar_tube_enemy", "targetname");
    var_3.origin = var_4 gettagorigin("j_shaft_top");
  }

  var_5 = spawnStruct();
  var_5.origin = level.enemy_mortar_end.origin;
  var_6 = scripts\engine\trace::ray_trace(var_5.origin + (0, 0, 600), var_5.origin);
  var_5.origin = var_6["position"];

  if(getdvarint("scr_mortar_gravity")) {
    var_7 = distance(var_3.origin, var_5.origin);
    var_2 = var_7 / var_1 * var_2;
  }

  var_8 = scripts\engine\utility::spawn_tag_origin(var_3.origin, (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_smktrail_mortar"), var_8, "tag_origin");
  var_9 = "vfx_emb_flash_mortar";

  if(scripts\engine\utility::flag("wave_4_end"))
    var_9 = "vfx_emb_flash_mortar_2";

  if(!scripts\engine\utility::flag("mortar_house_perimeter"))
    playFX(scripts\engine\utility::getfx(var_9), var_3.origin);

  if(distance2d(level.player.origin, var_3.origin) < 400) {
    earthquake(0.1, 2, var_3.origin, 2000);
    level.player playRumbleOnEntity("damage_light");
  }

  wait 0.1;
  level.player playRumbleOnEntity("damage_heavy");
  var_8 thread scripts\engine\utility::playsoundontag("weap_mortar_fire_dist", "tag_origin");
  var_8 playLoopSound("weap_mortar_fly_lp");
  var_10 = max(0.05, var_2 - 1.7);
  var_8 scripts\engine\utility::delaythread(var_10, scripts\engine\utility::playsoundontag, "weap_mortar_incoming", "tag_origin");
  movemortar(var_8, var_3.origin, var_5.origin, var_2);
  level notify("mortar_impact");
  var_8 stoploopsound("weap_mortar_fly_lp");
  var_8 delete();
  radiusdamage(var_5.origin, 500, 1, 1);
  earthquake(0.4, 1.5, var_5.origin, 2000);
  playrumbleonposition("damage_heavy", level.player.origin);
  playFX(scripts\engine\utility::getfx("vfx_mortar_explosion"), var_5.origin);
  var_7 = distance(level.player.origin, var_5.origin);

  if(300 > distance(level.player.origin, var_5.origin)) {
    if(level.player.origin[2] + 100 > var_5.origin[2])
      level.player scripts\engine\utility::delaycall(0.75, ::shellshock, "default", 1);
  }

  if(level.enemy_mortar_end == level.second_roof_struct) {
    level.player enableinvulnerability();
    playrumbleonposition("damage_heavy", level.player.origin);
    magicgrenademanual("mortar", var_5.origin + (0, 0, 5), (0, 0, 0), 0.05);
    level.player scripts\engine\utility::delaycall(1, ::disableinvulnerability);
  } else
    magicgrenademanual("mortar", var_5.origin + (0, 0, 5), (0, 0, 0), 0.05);
}

movemortar(var_0, var_1, var_2, var_3, var_4) {
  setdvarifuninitialized("scr_mortar_gravity", "0 ");

  if(getdvarint("scr_mortar_gravity")) {
    var_0.origin = var_1;
    var_5 = getdvarint("NPOQPMP");
    var_6 = distance(var_1, var_2);
    var_7 = var_2 - var_1;
    var_8 = 0.5 * var_5 * squared(var_3) * -1;
    var_9 = (var_7[0] / var_3, var_7[1] / var_3, (var_7[2] - var_8) / var_3);
    var_0 movegravity(var_9, var_3);
    var_10 = gettime() + var_3 * 1000;

    while(gettime() < var_10) {
      var_0 anglemortar();
      waitframe();
    }
  } else {
    var_11 = 1200;

    if(isDefined(var_4))
      var_11 = var_4;

    var_12 = 1 / (var_3 / 0.05);
    var_13 = 0;

    while(var_13 < 1) {
      var_0.origin = scripts\engine\math::get_point_on_parabola(var_1, var_2, var_11, var_13);
      var_0 anglemortar();
      var_13 = var_13 + var_12;
      wait 0.05;
    }

    var_0.origin = var_2;
  }
}

anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

illumination_mortars_init() {
  level.intro_mortar_tube = undefined;
  var_0 = getEntArray("flare_mortar_tube", "targetname");

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "east")) {
      level.intro_mortar_tube = var_2;
      var_2 illumination_mortars();
    }
  }
}

illumination_mortars_friendly_init() {
  level.support_mortar_tube = undefined;
  var_0 = getEntArray("flare_mortar_tube", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "north") {
      level.support_mortar_tube = var_2;
      var_3 = getEnt("friendly_mortar_clip", "targetname");
      var_3 linkTo(level.support_mortar_tube);
      var_4 = getEntArray("friendly_mortar_ammo", "targetname");

      foreach(var_6 in var_4)
      var_6 linkTo(level.support_mortar_tube);

      level.support_mortar_tube.angles = level.support_mortar_tube.angles + (0, -15, 0);
      var_2 illumination_mortar_friendly();
    }
  }
}

destroy_first_roof_mortar() {
  level waittill("mortar_impact");
  var_0 = getEntArray("flare_mortar_tube", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "east") {
      var_2 scripts\sp\player\cursor_hint::remove_cursor_hint();

      if(isDefined(var_2.interact))
        var_2.interact delete();

      var_2 delete();
    }
  }

  var_4 = getEntArray("mortar_delete", "targetname");
  scripts\engine\utility::array_delete(var_4);
  var_5 = getscriptablearray("perimeter_lights", "targetname");
  var_6 = [];
  var_6[0] = (31.6, -541.2, 178);

  foreach(var_8 in var_5) {
    if(distancesquared(var_8.origin, var_6[0]) < squared(20)) {
      var_8 setscriptablepartstate("onoff", "off");
      var_8 thread special_delay_hide();
    }
  }
}

special_delay_hide() {
  wait 0.1;
  self hide();
}

stop_illumination_mortars_thread() {
  self endon("trigger");
  scripts\engine\utility::flag_wait("stop_player_flare_mortar");
  scripts\sp\player\cursor_hint::remove_cursor_hint();
  level notify("stop_illumination_mortars");
}

illumination_mortars() {
  level.player endon("death");
  level notify("stop_illumination_mortars");

  if(scripts\engine\utility::flag("stop_player_flare_mortar")) {
    return;
  }
  if(!level.flare_counter) {
    return;
  }
  level endon("end_player_mortar_tubes");
  self endon("entitydeleted");
  self.flash = "j_shaft_top";
  self.shell = "j_mortar_shell";
  self hidepart(self.shell, "misc_wm_mortar");
  scripts\engine\sp\utility::assign_animtree("mortar");
  var_0 = undefined;
  var_1 = scripts\engine\utility::get_target_array();
  var_2 = undefined;

  switch (level.flare_counter) {
    case 4:
      var_2 = &"EMBASSY/LAUNCH_FLARE_4";
      break;
    case 3:
      var_2 = &"EMBASSY/LAUNCH_FLARE_3";
      break;
    case 2:
      var_2 = &"EMBASSY/LAUNCH_FLARE_2";
      break;
    case 1:
      var_2 = &"EMBASSY/LAUNCH_FLARE_1";
      break;
    default:
      break;
  }

  if(isDefined(self.interact))
    self.interact delete();

  var_3 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), self gettagangles("j_shaft_top"));
  var_3 linkTo(self);
  self.interact = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top") + (0, 0, 15), (0, 0, 0));
  self.interact linkTo(self);
  scripts\engine\utility::flag_wait("enable_ilumination_flares");
  scripts\common\anim::anim_first_frame_solo(self, "player_mortar_fire");
  self.interact scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, -10), var_2, undefined, 300, 100, 1, undefined, undefined, undefined, undefined, undefined, undefined);
  self.interact thread stop_illumination_mortars_thread();
  self.interact waittill("trigger");
  level.flare_counter--;

  if(!scripts\engine\utility::flag("enable_ilumination_flares"))
    scripts\engine\utility::flag_wait("enable_ilumination_flares");

  scripts\engine\utility::flag_set("player_flaring");
  level.player.stance = level.player getstance();
  level notify("illumination_flare_shot");

  if(!scripts\engine\utility::flag("wave_1_attack"))
    scripts\engine\utility::flag_set("wave_1_attack");

  var_4 = [level.player.rig, self];
  scripts\common\anim::anim_first_frame(var_4, "player_mortar_fire");
  level.player enableinvulnerability();
  level.player scripts\engine\utility::delaycall(4, ::disableinvulnerability);
  scripts\common\anim::anim_first_frame_solo(level.player.rig, "player_mortar_fire");
  thread scripts\engine\sp\utility::dof_enable_autofocus(2.0, 10, undefined, undefined, "j_shaft_top");
  scripts\sp\maps\embassy\embassy_util.gsc::put_player_into_rig(level.player.rig, 0.4, 5, 5, 5, 5, 1);
  self showpart(self.shell, "misc_wm_mortar");
  scripts\engine\utility::delaythread(2.25, ::illumination_flare, var_3);
  thread mortar_launch_player_effect();
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  thread scripts\common\anim::anim_single(var_4, "player_mortar_fire");
  level.player.rig waittillmatch("single anim", "end");
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  self hidepart(self.shell, "misc_wm_mortar");
  thread scripts\engine\sp\utility::dof_disable_autofocus();
  scripts\sp\maps\embassy\embassy_util.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  level notify("stop_print_timer");
  wait 0.2;
  self.interact delete();
  var_3 delete();
  wait 5;
  scripts\engine\utility::flag_clear("player_flaring");
  scripts\engine\utility::flag_clear("enable_ilumination_flares");

  if(!scripts\engine\utility::flag("wave_2_trucks_end"))
    thread illumination_mortars();
}

mortar_launch_player_effect() {
  level.player endon("death");
  wait 2.2;
  level.player playRumbleOnEntity("damage_bullet");
  screenshake(self.origin, 20, 1, 5, 0.5, 0, 0.5, 100, 5, 50, 50);
}

illumination_mortar_friendly() {
  if(scripts\engine\utility::flag("wave_5_end")) {
    return;
  }
  var_0 = undefined;
  var_1 = undefined;
  self.shell = "j_mortar_shell";
  self hidepart(self.shell, "misc_wm_mortar");
  var_1 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), self gettagangles("j_shaft_top"));
  var_1 linkTo(self);

  for(;;) {
    var_2 = scripts\engine\utility::flag_wait_any_return("flare_north", "flare_east");

    if(issubstr(var_2, self.script_noteworthy))
      thread illumination_flare(var_1);

    scripts\engine\utility::flag_clear(var_2);
    wait 0.1;
  }
}

illumination_flare(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = level.flare_light.og_angles + (10, 60, 0);
  var_4 = self.script_noteworthy;

  switch (var_4) {
    case "east":
      if(scripts\engine\utility::flag("front_1"))
        var_1 = (3400, 0, 600);

      if(scripts\engine\utility::flag("front_2"))
        var_1 = (2700, -100, 700);

      if(scripts\engine\utility::flag("front_3"))
        var_1 = (1300, -200, 700);

      break;
    case "north":
      if(!scripts\engine\utility::flag("wave_2_end")) {
        var_1 = (900, -200, 700);
        level.flare_light.intensity = 300;
        var_3 = level.flare_light.og_angles + (-25, 0, 0);
      }

      if(scripts\engine\utility::flag("wave_2_end")) {
        var_1 = (-613, 1304, 900);
        var_3 = (0, 85, 0);
        level.flare_light.intensity = 200;
      }

      break;
    default:
      break;
  }

  var_5 = scripts\engine\utility::spawn_tag_origin(var_0.origin, (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_mortar_fire"), self.origin, anglesToForward(self.angles));
  thread scripts\engine\utility::play_sound_in_space("weap_mortar_flare_launch", var_0.origin);
  var_5 scripts\engine\utility::delaythread(0.1, scripts\engine\utility::playsoundontag, "weap_mortar_flare_whistle", "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_illumination_flare_launch_trail"), var_5, "tag_origin");
  var_6 = 2.25;

  if(getdvarint("scr_mortar_gravity")) {
    var_7 = distance(var_0.origin, var_1);
    var_8 = 2000;
    var_6 = var_7 / var_8 * var_6;
  }

  thread movemortar(var_5, var_0.origin, var_1, var_6, 400);
  wait(var_6);
  level.flare_light dontinterpolate();
  level.flare_light_up dontinterpolate();
  level.flare_light.origin = var_5.origin + (0, 0, -10);
  level.flare_light_up.origin = var_5.origin + (0, 0, 0);
  level.flare_light.angles = var_3;
  level.flare_light linkTo(var_5);
  level.flare_light_up linkTo(var_5);
  scripts\engine\utility::flag_set("flares_out");
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::flare_light();
  thread scripts\sp\maps\embassy\embassy_lighting.gsc::flare_light_up();
  playFXOnTag(scripts\engine\utility::getfx("vfx_illumination_flare_unlit"), var_5, "tag_origin");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_illumination_flare_launch_trail"), var_5, "tag_origin");
  var_9 = scripts\engine\trace::ray_trace(var_5.origin, var_5.origin + (0, 0, -10000));
  var_1 = var_9["position"] + (0, 0, 5);
  level notify("flare_drop");
  var_5 thread scripts\engine\utility::playsoundontag("weap_mortar_flare_burst", "tag_origin");
  var_5 thread scripts\engine\sp\utility::play_sound_on_tag("weap_mortar_flare_phosphorus_start", "tag_origin");
  var_5 scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::play_loop_sound_on_tag, "weap_mortar_flare_phosphorus_lp", "tag_origin");
  var_5 thread flare_mover(var_1);
  var_5 thread flare_ai_ent_flag_setting();
  var_5 scripts\engine\utility::delaythread(level.flare_lifetime - 2.0, scripts\engine\utility::playsoundontag, "weap_mortar_flare_phosphorus_end", "tag_origin");
  var_5 scripts\engine\utility::delaythread(level.flare_lifetime - 1.8, scripts\engine\utility::stop_loop_sound_on_entity, "weap_mortar_flare_phosphorus_lp");
  thread flare_countdown();
  wait(level.flare_lifetime);
  level.flare_light unlink();
  var_5 delete();
  scripts\engine\utility::flag_clear("flares_out");
}

flare_countdown() {
  level.flare_countdown = level.flare_lifetime;

  for(var_0 = level.flare_lifetime; var_0 > 0; var_0--) {
    level.flare_countdown--;
    wait 1;
  }
}

flare_ai_ent_flag_setting() {
  for(var_0 = 0; var_0 < level.flare_lifetime; var_0++) {
    var_1 = getaiarray("axis");

    foreach(var_3 in var_1) {
      var_4 = 1500;

      if(distance(self.origin, var_3.origin) < var_4) {
        if(var_3 scripts\engine\utility::ent_flag_exist("flared") && !var_3 scripts\engine\utility::ent_flag("flared")) {
          var_3 scripts\engine\utility::ent_flag_set("flared");
          var_3.flare_timer = level.flare_lifetime - var_0;
        }
      }
    }

    wait 1;
  }
}

doorbust_guy_spawn_func() {
  self.animname = "doorbust_guy";
  scripts\engine\sp\utility::set_deathanim("stairs_death");
  self.allowdeath = 1;
  thread door_bust_guy_autosave();
  var_0 = getEnt("doorbust_door", "targetname");
  var_0.clip = getEnt("doorbust_door_clip", "targetname");
  var_0.clip linkTo(var_0);
  self.struct = scripts\engine\utility::getStruct("doorbust_struct", "targetname");
  waitframe();
  self.struct scripts\common\anim::anim_first_frame_solo(self, "door_bust");
  thread scripts\common\ai::magic_bullet_shield();
  scripts\engine\sp\utility::trigger_wait_targetname("doorbust_guy_trigger");
  thread scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_aq2_defend_mortar_interior_10");
  wait 1.5;
  self endon("death");
  thread scripts\common\ai::stop_magic_bullet_shield();
  var_0 playSound("scrpt_door_wood_heavy_bash_npc");
  var_0 rotateYaw(-110, 0.3);
  var_0.clip connectpaths();
  self.struct thread scripts\common\anim::anim_single_solo(self, "door_bust");
  waitframe();
  self setanimtime(scripts\engine\utility::getanim("door_bust"), 0.5);
  thread doorbust_guy_becomes_ai_if_alive();
}

stairs_guy_spawn_func() {
  self.animname = "stairs_guy";
  self.allowdeath = 1;
  self.struct = scripts\engine\utility::getStruct("mortar_house_stairs_struct", "targetname");
  waitframe();
  self.struct thread scripts\common\anim::anim_single_solo(self, "stairs_scene");
  waitframe();
  self setanimtime(scripts\engine\utility::getanim("stairs_scene"), 0.2);
  self setanimrate(scripts\engine\utility::getanim("stairs_scene"), 0);
  thread scripts\common\ai::magic_bullet_shield();
  scripts\engine\sp\utility::trigger_wait_targetname("price_mortar_run_trigger_05");
  self setanimrate(scripts\engine\utility::getanim("stairs_scene"), 1);
  self endon("death");
  thread scripts\common\ai::stop_magic_bullet_shield();
  thread doorbust_guy_becomes_ai_if_alive();
}

door_bust_guy_autosave() {
  self waittill("death");
  scripts\engine\sp\utility::autosave_by_name("mortar_house_stairs");
}

suicide_bomber_spawn_func() {
  self getenemyinfo(level.player);
  self endon("death");
  var_0 = getEnt("bomber_left_side_trigger", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      scripts\engine\sp\utility::set_favoriteenemy(level.price);
      self getenemyinfo(level.price);
    }

    waitframe();
  }
}

sfx_spawn_crickets() {
  if(scripts\engine\utility::flag("sfx_crickets")) {
    return;
  }
  var_0 = spawn("script_origin", (-266, -591, 24));
  var_0 playLoopSound("emt_cricket_single_02_close_lp");
  var_1 = spawn("script_origin", (-1339, -310, 52));
  var_1 playLoopSound("emt_cricket_area_01_lp");
  var_2 = spawn("script_origin", (-968, -1641, 16));
  var_2 playLoopSound("emt_night_bugs_lp");
  var_3 = spawn("script_origin", (-389, -1066, 37));
  var_3 playLoopSound("emt_night_bugs_lp");
  var_4 = spawn("script_origin", (-549, -310, 43));
  var_4 playLoopSound("emt_night_bugs_lp");
  var_5 = spawn("script_origin", (38, 71, 26));
  var_5 playLoopSound("emt_night_bugs_lp");
  var_6 = spawn("script_origin", (251, -1541, 52));
  var_6 playLoopSound("emt_night_bugs_lp");
  var_7 = spawn("script_origin", (615, -110, 16));
  var_7 playLoopSound("emt_cricket_single_03_dist_lp");
  var_8 = spawn("script_origin", (-571, -1583, 51));
  var_8 playLoopSound("emt_cricket_single_05_dist_lp");
  scripts\engine\utility::flag_set("sfx_crickets");
  level waittill("sfx_stop_crickets");
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
  var_6 delete();
  var_7 delete();
  var_8 delete();
}

defend_inits() {
  scripts\engine\utility::flag_set("obj_using_cctv");
  level.technicals = [];
  level.mortar_teams = [];
  level.field_cover_direction = anglesToForward((0, 180, 0));
  level.roof_tops_cover_direction = anglesToForward((0, 60, 0));
  level.player.dontgrenademe = 1;
  var_0 = getEntArray("triage_loot", "targetname");
  scripts\engine\utility::array_call(var_0, ::hide);
  var_1 = getEnt("wolf_escape_gate", "targetname");
  var_1 hide();
  thread haze_watcher();
  thread illumination_mortars_friendly_init();
  thread price_mortar_run_triggers_on(0);
  thread price_compound_run_triggers_on(0);
  thread init_destructible_roof_walls();
  thread init_corner_wall();
  thread init_destructible_perimeter();
  thread init_residence_wall();
  thread player_kill_triggers();
  thread player_warn_trigger();
  thread distant_threat_gate_init();
  thread init_glowstick();
  thread palm_trees_init();
  thread palm_tree_swap();
  thread palm_tree_swap_02();
  thread scriptable_field_lights_swap();
  var_2 = getEnt("east_gate_destroyed", "targetname");
  var_2 hide();
  var_3 = getEnt("barracks_bloodstain", "targetname");
  var_3 hide();
  var_4 = getEnt("m4_refill_03", "targetname");
  var_4.og_origin = var_4.origin;
  var_4.og_angles = var_4.angles;
  var_4.origin = (-274, -1002, 84);
  var_5 = getEnt("m4_refill_01", "targetname");
  var_5.og_origin = var_5.origin;
  var_5.og_angles = var_5.angles;
  var_5.origin = (-274, -1002, 84);
  var_6 = getEntArray(var_2.target, "targetname");

  if(var_6.size > 0)
    scripts\engine\utility::array_call(var_6, ::hide);

  scripts\engine\utility::trigger_off("slide_trigger_01", "targetname");
  scripts\engine\utility::trigger_off("wave_3_ladder", "targetname");
  level.flare_lifetime = 22;
  level.player.flare_held = 0;
  level.mortar_round_delay_time = 2.5;
  var_7 = ["scaffolding_a", "scaffolding_b", "scaffolding_c"];

  foreach(var_9 in var_7)
  show_scaffolding_mayhem(var_9);
}

palm_trees_init() {
  wait 0.2;
  level.palm_trees = [];
  var_0 = spawnStruct();
  var_0.exploder_name = "p_tree_fire_1";
  var_0.origin = (833.4, 1280.7, 34);
  level.palm_trees[level.palm_trees.size] = var_0;
  var_1 = getscriptablearray("emb_palm_02", "targetname")[0];
  level.palm_trees[level.palm_trees.size] = var_1;
  var_2 = spawnStruct();
  var_2.exploder_name = "p_tree_fire_3";
  var_2.origin = (2341.4, 1280.7, 34);
  level.palm_trees[level.palm_trees.size] = var_2;
  var_3 = spawnStruct();
  var_3.exploder_name = "p_tree_fire_4";
  var_3.origin = (3636.4, 1280.7, 34);
  level.palm_trees[level.palm_trees.size] = var_3;
  var_4 = spawnStruct();
  var_4.exploder_name = "p_tree_fire_5";
  var_4.origin = (1034.6, 1813.3, 36);
  level.palm_trees[level.palm_trees.size] = var_4;
}

show_scaffolding_mayhem(var_0) {
  showmayhem(var_0);
  showmayhem(var_0 + "_tarps");
}

unload_embassy_load_anims() {
  waitframe();
  var_0 = getcorpsearray();

  foreach(var_2 in var_0)
  var_2 delete();

  thread embassy_weapon_cleanup();
  waitframe();
  thread scripts\engine\sp\utility::transient_unload("embassy_building_tr");
  scripts\engine\sp\utility::transient_unload("embassy_building_cctv_tr");
  waitframe();
  loadtransient("embassy_compound_anims_middle_tr");
}

embassy_weapon_cleanup() {
  var_0 = getweaponarray();

  foreach(var_2 in var_0) {
    if(var_2.origin[0] < -4300)
      var_2 delete();
  }
}

defend_push_weapon_cleanup() {
  var_0 = getweaponarray();

  foreach(var_2 in var_0) {
    if(var_2.origin[0] > 500 && var_2.origin[2] < 35)
      var_2 delete();
  }
}

load_compound_anims_end_transient() {
  waitframe();
  scripts\engine\sp\utility::transient_unload("embassy_compound_anims_middle_tr");
  waitframe();
  loadtransient("embassy_compound_anims_end_tr");
}

objective_manager_defend() {
  waitframe();
  scripts\engine\sp\objectives::objective_add("Rooftop", "current", level.roof_objective_struct.origin + (0, 0, 20), &"EMBASSY/OBJ_ROOFTOP");
  scripts\engine\utility::flag_wait("player_on_rooftop");
  scripts\engine\utility::flag_wait("intro_vo_finished");
  scripts\engine\sp\objectives::objective_remove("Rooftop");
  var_0 = spawnStruct();
  var_0.origin = (-120, -952, 180);

  if(!scripts\engine\utility::flag("player_has_sniper")) {
    scripts\engine\sp\objectives::objective_add("Rifle", "current", var_0.origin, &"EMBASSY/OBJ_SCOPE");
    scripts\engine\utility::flag_wait("player_has_sniper");
    scripts\engine\sp\objectives::objective_remove("Rifle");
  }

  waitframe();
  var_1 = scripts\engine\utility::getStruct("soccer_struct", "targetname");
  scripts\engine\sp\objectives::objective_add("Cafe", "current", var_1.origin + (0, 0, 100), &"EMBASSY/OBJ_CAFE");
  scripts\engine\utility::flag_wait("wave_1_start");
  scripts\engine\sp\objectives::objective_remove("Cafe");
  scripts\engine\sp\objectives::objective_add("defend_objective", "current", undefined, &"EMBASSY/OBJ_DEFEND_COMPOUND");
  scripts\engine\utility::flag_wait("front_1");
  scripts\engine\sp\objectives::objective_remove("defend_objective");
  scripts\engine\sp\objectives::objective_add("flare_objective", "current", level.intro_mortar_tube.origin + (0, 0, 75), &"EMBASSY/OBJ_FLARE");
  scripts\engine\utility::flag_wait("first_flare");
  scripts\engine\utility::flag_wait("wave_1_end");
  scripts\engine\sp\objectives::objective_remove("flare_objective");
  scripts\engine\sp\objectives::objective_add("defend_objective", "current", undefined, &"EMBASSY/OBJ_DEFEND_COMPOUND");
  scripts\engine\utility::flag_wait("push_objective");
  scripts\engine\sp\objectives::objective_remove("defend_objective");
  scripts\engine\sp\objectives::objective_add("push_objective", "current", (-600.5, -254.5, 41.8), &"EMBASSY/OBJ_PUSH");
  scripts\engine\utility::flag_wait("wave_2_end");
  scripts\engine\sp\objectives::objective_remove("push_objective");
  scripts\engine\utility::flag_wait("price_triage_objective");
  var_2 = spawnStruct();
  var_2.origin = (-111, 189, 76);
  var_2 = scripts\engine\utility::spawn_tag_origin(level.price.origin + (0, 0, 80), level.price.angles);
  var_2 linkTo(level.price);
  scripts\engine\sp\objectives::objective_add("regroup", "current", var_2.origin, &"EMBASSY/OBJ_REGROUP", undefined);
  scripts\engine\sp\objectives::objective_set_on_entity("regroup", undefined, var_2);
  scripts\engine\utility::flag_wait("wave_3_inside");
  scripts\engine\sp\objectives::objective_remove("regroup");
  var_2 delete();
  scripts\engine\sp\objectives::objective_add("resupply", "current", undefined, &"EMBASSY/OBJ_RESUPPLY");
  scripts\engine\utility::flag_wait("green_beam_shown");

  if(!scripts\engine\utility::flag("green_beam_acquired"))
    wait 1;

  scripts\engine\sp\objectives::objective_remove("resupply");
  var_3 = getEnt("targetting_struct", "targetname");
  scripts\engine\sp\objectives::objective_add("greenbeam", "current", var_3.origin + (0, 0, 10), &"EMBASSY/OBJ_DESIGNATOR");
  scripts\engine\utility::flag_wait("green_beam_acquired");
  scripts\engine\sp\objectives::objective_remove("greenbeam");
  scripts\engine\utility::flag_wait("building_combat_objective");
  var_2 = spawnStruct();
  var_2.origin = (-232.5, 422.5, 175);
  scripts\engine\sp\objectives::objective_add("building_combat", "current", var_2.origin, &"EMBASSY/OBJ_MARK_TARGETS");
  scripts\engine\utility::flag_wait("wave_4_end");
  scripts\engine\sp\objectives::objective_remove("building_combat");
  scripts\engine\sp\objectives::objective_add("defend_objective", "current", undefined, &"EMBASSY/OBJ_DEFEND_COMPOUND");
  scripts\engine\utility::flag_wait("mortar_team_objective");
  scripts\engine\sp\objectives::objective_remove("defend_objective");
  var_2 = scripts\engine\utility::getStruct("mortar_wave_4", "targetname");
  scripts\engine\sp\objectives::objective_add("mortar_team", "current", var_2.origin, &"EMBASSY/OBJ_CLEAR_HOUSE");
  scripts\engine\utility::flag_wait("wave_5_house_end");

  if(!scripts\engine\utility::flag("residence_return"))
    wait 2;

  scripts\engine\sp\objectives::objective_remove("mortar_team");
  var_2 = spawnStruct();
  var_2.origin = (-418, -110, 76);
  scripts\engine\sp\objectives::objective_add("return_to_compound", "current", var_2.origin, &"EMBASSY/OBJ_COMPOUND");
  scripts\engine\utility::flag_wait("residence_return");
  scripts\engine\sp\objectives::objective_remove("return_to_compound");
  var_2.origin = (-1842, -379, 116);
  var_4 = scripts\engine\utility::getStruct("residence_end_struct", "targetname");
  scripts\engine\sp\objectives::objective_add("secure_the_wolf", "current", var_2.origin + (0, 0, 30), &"EMBASSY/OBJ_SECURE_WOLF");
  scripts\engine\utility::flag_wait("wolf_escapes");
  scripts\engine\sp\objectives::objective_update("secure_the_wolf", "current", var_4.origin + (0, 0, 30), &"EMBASSY/OBJ_SECURE_WOLF");
}