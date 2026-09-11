/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\embassy\embassy_defend.gsc
******************************************************/

function embassy_defend_precache() {
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
  level.rocket_func = &scaffolding_rocket_watcher;
  level.beam_nag_lines = [];
  level.beam_nag_lines[level.beam_nag_lines.size] = ["UAV Pilot", "The drone is reloading."];
  level.beam_nag_lines[level.beam_nag_lines.size] = ["UAV Pilot", "The drone is almost reloaded."];
  level.player_dialogue_struct = spawnStruct();
  level.player_dialogue_struct.name = "Kyle";
  level.baseplate_dialogue_struct = spawnStruct();
  level.baseplate_dialogue_struct.name = "Baseplate";
  level.flare_counter = 4;
  var0 = getEnt("mortar_house_blue_gate_clip", "targetname");
  var0 connectpaths();
  var1 = getEnt("mortar_anim_truck_01", "targetname");
  var1 hide();
  var2 = getEnt("mortar_anim_truck_02", "targetname");
  var2 hide();
  var3 = getEnt("mortar_anim_truck_03", "targetname");
  var3 hide();
  var4 = getEntArray("damaged_residence", "targetname");
  scripts\engine\utility::array_call(var4, &hide);
  var5 = getEnt("emb_palm_01_clip_fallen", "targetname");
  var5 connectpaths();
  var5 hide();
  scripts\engine\utility::trigger_off("emb_palm_01_trigger", "targetname");
  level.civ_car_death_spot = (0, 0, 0);
  var6 = getEnt("emb_palm_02_clip_fallen", "targetname");
  var6 connectpaths();
  var6 hide();
  scripts\engine\utility::trigger_off("emb_palm_02_trigger", "targetname");
  var7 = getEnt("scaffolding_a_clip", "targetname");
  var7 connectpaths();
  var8 = getEnt("scaffolding_b_clip", "targetname");
  var8 connectpaths();
  var9 = getEnt("scaffolding_c_clip", "targetname");
  var9 connectpaths();
  var10 = getEnt("flare_mortar_tube_enemy", "targetname");
  var10.shell = "j_mortar_shell";
  var11 = getEntArray("building_rails", "targetname");
  scripts\engine\utility::array_call(var11, &notsolid);
  scripts\engine\sp\utility::add_hint_string("sniper_rifle_check", &"EMBASSY/SCOPED_WEAPON", &scripts\sp\maps\embassy\embassy_util::scope_swap_hint_check);
  scripts\engine\sp\utility::add_hint_string("green_beam_check", &"EMBASSY/CHANGE_WEAPON", &scripts\sp\maps\embassy\embassy_util::green_beam_swap_hint_check);
  var12 = (-213, -2463, 2300);
  thread scripts\sp\equipment\green_beam::laser_init(var12, 4, "drone_instructions", "mortar_house_perimeter");
  precachemodel("veh8_civ_lnd_walfa_yellow");
  precachemodel("veh8_civ_lnd_walfa_black");
  thread embassy_defend_precache_delay();
}

function embassy_defend_precache_delay() {
  var0 = getEntArray("middle_cars", "targetname");
  scripts\engine\utility::array_call(var0, &hide);
  wait 0.3;
  var1 = getEntArray("residence_loot", "targetname");
  scripts\engine\utility::array_call(var1, &hide);
  var2 = getEntArray("triage_loot", "targetname");
  scripts\engine\utility::array_call(var2, &hide);
  var3 = getEntArray("triage_loot_roof", "targetname");
  scripts\engine\utility::array_call(var3, &hide);
}

function embassy_defend_fx() {}

function embassy_defend_flags() {
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

function residence_arrival_start() {
  scripts\sp\maps\embassy\embassy_util::spawn_price();
  scripts\sp\maps\embassy\embassy_util::spawn_farah();
  scripts\sp\maps\embassy\embassy_util::spawn_alex();
  scripts\sp\maps\embassy\embassy_util::spawn_hadir();
  scripts\sp\maps\embassy\embassy_util::spawn_stacy();
  scripts\sp\maps\embassy\embassy_util::spawn_wolf();
  level.wolf thread scripts\sp\maps\embassy\embassy_util::wolf_friendly_fire_think();
  var0 = [level.price, level.farah, level.alex, level.hadir, level.wolf, level.stacy];
  scripts\engine\sp\utility::set_start_location("residence_arrival_start", scripts\engine\utility::array_combine([level.player], var0));
  level.ap_residence = scripts\engine\utility::getStruct("ap_residence", "targetname");
  level.hadir scripts\engine\sp\utility::place_weapon_on(level.hadir.weapon, "back");
  level.hadir scripts\engine\sp\utility::place_weapon_on(level.hadir.sidearm, "right");

  foreach(var2 in var0) {
    level.ap_residence thread scripts\common\anim::anim_first_frame_solo(var2, "res_arrival_scene");
  }

  thread scripts\sp\maps\embassy\embassy_infil::load_compound_transient();
}

function residence_arrival_main() {
  defend_inits();
  var0 = getEntArray("residence_loot", "targetname");
  scripts\engine\utility::array_call(var0, &show);
  scripts\engine\sp\utility::autosave_by_name("residence_arrival");
  var1 = [level.farah, level.price, level.alex, level.hadir];

  foreach(var3 in var1) {
    var3 clearpath();
    var3 setgoalpos(var3.origin);
  }

  setmusicstate("");
  var5 = getEnt("technical_04_end_nav", "targetname");
  var5 notsolid();
  var5 connectpaths();
  thread residence_arrival_handle_technical_on_door_close();
  thread residence_arrival_side_door("side_door_left");
  thread residence_arrival_side_door("side_door_right");
  thread residence_arrival_facade_doors();
  thread residence_arrival_vo();
  scripts\engine\sp\utility::array_spawn_function_targetname("emb_res_flavor_civs", &residence_arrival_civs);
  var6 = scripts\engine\sp\utility::array_spawn_targetname("emb_res_flavor_civs", 1);
  scripts\engine\sp\utility::array_spawn_function_targetname("emb_res_entrance_defender", &residence_arrival_marines);
  var7 = scripts\engine\sp\utility::array_spawn_targetname("emb_res_entrance_defender", 1);
  scripts\sp\maps\embassy\embassy_util::spawn_alex_friendlies();
  scripts\engine\sp\utility::set_start_location("defend_start", [level.fsa_02, level.greeter_marine]);
  thread residence_arrival_player_demeanor();
  thread residence_arrival_vfx_cleanup();
  level.ap_residence.anim_start_delay = 1;
  level.ap_residence thread scripts\engine\sp\utility::notify_delay("stop_loop", level.ap_residence.anim_start_delay);

  if(isDefined(level.ap_wolf_escort)) {
    level.ap_wolf_escort thread scripts\engine\sp\utility::notify_delay("stop_loop", level.ap_residence.anim_start_delay);
  }

  var8 = getEnt("res_secure_door", "targetname");
  var8.clip = var8 scripts\engine\utility::get_target_ent();
  var8.clip linkTo(var8);
  var8 scripts\engine\sp\utility::assign_animtree("saferoom_door");
  level.ap_residence scripts\engine\utility::delaythread(level.ap_residence.anim_start_delay, &scripts\common\anim::anim_single_solo, var8, "res_arrival_scene");
  var9 = residence_arrival_door_setup("residence_sliding_door_entrance", "residence_sliding_door_entrance_end");
  scripts\engine\utility::delaythread(level.ap_residence.anim_start_delay, &residence_arrival_door_open, var9, "inside_residence");
  var10 = scripts\engine\sp\utility::spawn_targetname("emb_res_entrance_informer", 1);
  var10.animname = "mar_informer";
  var11 = scripts\engine\sp\utility::spawn_targetname("emb_res_entrance_greeting", 1);
  var11.animname = "mar_greeting";
  level.us_soldier_3 = var11;
  var12 = [level.stacy, var10, var11];
  scripts\engine\utility::array_thread(var12, &residence_arrival_only);
  var13 = [level.price, level.alex, level.hadir, level.farah];
  scripts\engine\utility::array_thread(var13, &residence_arrival_and_exit);
  thread residence_arrival_wolf();
  level.ap_residence.arrival_done = var13.size - 1;
  level.ap_residence.exit_done = var13.size - 1;
  thread scripts\sp\maps\embassy\embassy_util::swap_card_reader("residence_card_reader");
  level thread scripts\engine\sp\utility::notify_delay("card_reader_swap", 1);
  scripts\sp\utility::notetrack_mission_failed_vo_disable();
  var14 = scripts\engine\utility::getStruct("ap_res_arrival_plr", "targetname");
  var14 thread scripts\common\anim::anim_first_frame_solo(level.player.rig, "res_arrival_scene");
  level.player.rig attach(scripts\engine\sp\utility::getmodel("keycard"), "tag_accessory_left");
  thread scripts\sp\maps\embassy\embassy_util::put_player_into_rig(level.player.rig, 0.5, 0, 0, 0, 0);
  level.player.rig scripts\engine\utility::delaycall(0.05, &setanimrate, level.player.rig scripts\engine\utility::getanim("res_arrival_scene"), 0.65);
  var14 scripts\common\anim::anim_single_solo(level.player.rig, "res_arrival_scene");
  level.player.rig detach(scripts\engine\sp\utility::getmodel("keycard"), "tag_accessory_left");
  scripts\sp\maps\embassy\embassy_util::pull_player_out_of_rig_hide_rig(level.player.rig);
  scripts\engine\utility::flag_wait("wolf_dropped_off");
  scripts\engine\utility::flag_wait("res_inside_armory");
  level notify("obj_escort_wolf_complete");
  scripts\engine\utility::flag_set("obj_escort_wolf_complete");
  scripts\sp\maps\embassy\embassy_util::spawn_mortar_friendlies();
  scripts\sp\maps\embassy\embassy_util::spawn_marines_friendlies();
  scripts\engine\utility::flag_wait("residence_arrival_vo_done");
  scripts\engine\utility::flag_wait_all("reached_approach", "allies_at_res_exit");
  var15 = residence_arrival_door_setup("residence_sliding_door_exit", "residence_sliding_door_exit_end");
  thread residence_arrival_door_open(var15, "outside_courtyard");
  wait 2;
  scripts\sp\utility::notetrack_mission_failed_vo_enable();
  scripts\engine\utility::flag_set("defend_exit_door_open");
  level notify("obj_join_forces_complete");
  thread scripts\sp\analytics::analytics_kleenex_update("Escape to Defend");
}

function residence_arrival_vo() {
  level.player endon("death");
  level.player scripts\sp\maps\embassy\embassy_util::say("dx_vom_kyle_alley_compound_70");
  level.us_soldier_3 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us3_residence_arrival_intro_10");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_residence_arrival_intro_20");
  level.us_soldier_3 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us3_residence_arrival_intro_30");
  scripts\engine\utility::flag_wait("wolf_dropped_off");
  var0 = ["dx_vom_pri_residence_arrival_intro_70", "dx_vom_pri_residence_arrival_intro_80", "dx_vom_pri_residence_arrival_intro_90"];
  level.price scripts\sp\maps\embassy\embassy_util::nagtill_delayed(8, "res_inside_armory", var0, 12, 1.2);
  wait 2;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_residence_arrival_exit_30");
  level scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_lass_residence_arrival_exit_40");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_residence_arrival_exit_50");
  level scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_lass_residence_arrival_exit_60");
  scripts\engine\utility::flag_set("residence_arrival_vo_done");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_residence_arrival_exit_70");
  thread speak_to_stacy();
  wait 15;
  var0 = ["dx_vom_pri_residence_arrival_exit_80", "dx_vom_pri_residence_arrival_exit_90", "dx_vom_pri_residence_arrival_exit_100"];
  level.price scripts\sp\maps\embassy\embassy_util::nagtill("reached_approach", var0, 15);
}

function speak_to_stacy() {
  if(isDefined(level.stacy) && isalive(level.stacy)) {
    level.player endon("death");
    level.stacy endon("death");
    level.player scripts\sp\maps\embassy\embassy_util::wait_lookat(level.stacy, 85, "j_head", 0.3, 100);
    level.stacy scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_stac_residence_arrival_exit_10");
    level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_residence_arrival_exit_20");
    return;
  }
}

function residence_arrival_player_demeanor() {
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.player scripts\sp\player::player_movement_state("creep");
  scripts\engine\utility::flag_wait("defend_entrance_door_closed");
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  scripts\engine\utility::flag_wait("outside_courtyard");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.player scripts\sp\player::player_movement_state("default");
}

function residence_arrival_delete_on_exit_door_close() {
  level scripts\engine\utility::waittill_any("residence_sliding_door_exit_closed", "player_on_rooftop");
  self delete();
}

function residence_arrival_handle_technical_on_door_close() {
  level waittill("residence_sliding_door_exit_closed");
  self solid();
  self disconnectPaths();
}

function residence_arrival_marines() {
  self endon("entitydeleted");
  thread residence_arrival_delete_on_exit_door_close();
  self.script_pushable = 0;
  self.ap = self.spawner;
  self.animname = "marine";

  if(scripts\engine\utility::is_equal(self.script_namenumber, "crouch")) {
    self allowedstances("crouch");
  } else {
    scripts\common\utility::demeanor_override("casual_gun");
    scripts\common\ai::set_gunpose("gun_down");
  }

  scripts\sp\names::get_name();
  self setlookattext(self.name, &"");
  var0 = 150;
  GscBinSkip4(0x35, var0);
}

function residence_arrival_marines_look_at(var0) {
  for(;;) {
    var1 = scripts\sp\maps\embassy\embassy_util::within_distance(level.player.origin, self.origin, var0);

    if(var1 && !istrue(self.lookingatent)) {
      scripts\common\utility::lookatentity(level.player, 0);
    } else if(!var1 && istrue(self.lookingatent)) {
      scripts\common\utility::lookatentity();
    }

    waitframe();
  }
}

function residence_arrival_civs() {
  self endon("entitydeleted");
  self.fakeactor_face_anim = 1;

  if(!isDefined(level.dejected_idle_count) || level.dejected_idle_count > 5) {
    level.dejected_idle_count = 0;
  } else {
    level.dejected_idle_count++;
  }

  self.civ_count = level.dejected_idle_count;
  self.animname = "civ";
  thread residence_arrival_delete_on_exit_door_close();
  thread scripts\sp\maps\embassy\embassy_util::civ_friendly_fire_think();
  self.ap = self.spawner;
  self.last_player_reaction_time = 0;

  for(;;) {
    self.ap thread scripts\common\anim::anim_loop_solo(self, "dejected_idle_" + self.civ_count, "stop_loop");

    while((!scripts\engine\utility::time_has_passed(self.last_player_reaction_time, 3) || !scripts\sp\maps\embassy\embassy_util::within_distance(level.player.origin, self.origin, 100)) && !level.player isfiring() && !scripts\sp\maps\embassy\embassy_util::player_aiming_at_2d(self.origin, 30)) {
      waitframe();
    }

    self.ap notify("stop_loop");

    if(level.player isfiring() || scripts\sp\maps\embassy\embassy_util::player_aiming_at_2d(self.origin, 30)) {
      self.ap scripts\common\anim::anim_single_solo(self, "dejected_react_ads_enter_" + self.civ_count);
      self.ap thread scripts\common\anim::anim_loop_solo(self, "dejected_react_ads_idle_" + self.civ_count, "stop_loop");

      while(level.player isfiring() | scripts\sp\maps\embassy\embassy_util::player_aiming_at_2d(self.origin, 30)) {
        waitframe();
      }

      self.ap notify("stop_loop");
      self.ap scripts\common\anim::anim_single_solo(self, "dejected_react_ads_exit_" + self.civ_count);
      continue;
    }

    self.ap scripts\common\anim::anim_single_solo(self, "dejected_react_plr_" + self.civ_count);
    self.last_player_reaction_time = gettime();
  }
}

function residence_arrival_and_exit() {
  wait level.ap_residence.anim_start_delay;
  level.ap_residence scripts\common\anim::anim_single_solo(self, "res_arrival_scene");
  level.ap_residence thread scripts\common\anim::anim_loop_solo(self, "res_arrival_scene_idle", "stop_loop_" + self.animname);
  thread residence_arrival_done();
  scripts\engine\utility::flag_wait("res_inside_armory");
  var0 = getEntArray("middle_cars", "targetname");
  scripts\engine\utility::array_call(var0, &delete);
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

  if(self == level.hadir) {
    level.ap_residence scripts\common\anim::anim_single_solo(self, "res_room_exit_to_defend");
    return;
  }
}

function residence_arrival_only() {
  thread residence_arrival_delete_on_exit_door_close();
  wait level.ap_residence.anim_start_delay;
  level.ap_residence scripts\common\anim::anim_single_solo(self, "res_arrival_scene");

  if(self == level.stacy) {
    thread residence_arrival_stacy_reactions();
  } else {
    level.ap_residence thread scripts\common\anim::anim_loop_solo(self, "res_arrival_scene_idle", "stop_loop_" + self.animname);
  }

  thread residence_arrival_done();
}

function residence_arrival_stacy_reactions() {
  self endon("death");
  self.last_player_reaction_time = 0;

  for(;;) {
    level.ap_residence thread scripts\common\anim::anim_loop_solo(self, "res_arrival_scene_idle", "stop_loop_" + self.animname);

    while(!scripts\engine\utility::time_has_passed(self.last_player_reaction_time, 3) || !scripts\sp\maps\embassy\embassy_util::within_distance(level.player.origin, self.origin, 100) && !level.player isfiring() && !scripts\sp\maps\embassy\embassy_util::player_aiming_at_2d(self.origin, 30)) {
      waitframe();
    }

    level.ap_residence notify("stop_loop_" + self.animname);

    if(level.player isfiring() || scripts\sp\maps\embassy\embassy_util::player_aiming_at_2d(self.origin, 30)) {
      level.ap_residence scripts\common\anim::anim_single_solo(self, "res_room_ads_react");
      continue;
    }

    if(scripts\engine\math::is_point_on_right(level.player.origin)) {
      scripts\common\anim::anim_single_solo(self, "res_room_plr_react_r");
    } else {
      scripts\common\anim::anim_single_solo(self, "res_room_plr_react_l");
    }

    self.last_player_reaction_time = gettime();
  }
}

function residence_arrival_wolf() {
  wait level.ap_residence.anim_start_delay;
  level.ap_residence scripts\common\anim::anim_single_solo(level.wolf, "res_arrival_scene");

  if(isDefined(level.wolf.handcuffs)) {
    level.wolf.handcuffs delete();
  }

  level.wolf delete();
  thread residence_arrival_done();
}

function residence_arrival_done() {
  level.ap_residence.arrival_done--;

  if(level.ap_residence.arrival_done <= 0) {
    scripts\engine\utility::flag_set("wolf_dropped_off");
    return;
  }
}

function residence_exit_done() {
  level.ap_residence.exit_done--;

  if(level.ap_residence.exit_done <= 0) {
    scripts\engine\utility::flag_set("allies_at_res_exit");
    return;
  }
}

function residence_arrival_vfx_cleanup() {
  level waittill("residence_sliding_door_entrance_closed");
  scripts\engine\utility::stop_exploder("heli_fire");
  scripts\engine\utility::stop_exploder("landing_car_explode");
}

function residence_arrival_door_setup(var0, var1) {
  var2 = getEnt(var0, "targetname");
  var2.clip = var2 scripts\engine\utility::get_target_ent();
  var2.clip linkTo(var2);
  var2.start = var2.origin;
  var2.end = scripts\engine\utility::getStruct(var1, "targetname").origin;
  return var2;
}

function residence_arrival_door_open(var0, var1) {
  thread audio_residence_door_open();
  var0.clip connectpaths();
  var0 moveTo(var0.end, 4, 0.25, 0.25);
  wait 4;
  var0.total_dist = distance(var0.start, var0.end);
  var0.curr_dist = distance(var0.origin, var0.start);
  var0.move_pct = var0.curr_dist / var0.total_dist;
  thread residence_arrival_door_pauser(var0);

  while(var0.move_pct > 0.01 && !scripts\engine\utility::flag("player_on_rooftop")) {
    var0.curr_dist = distance(var0.origin, var0.start);
    var0.move_pct = var0.curr_dist / var0.total_dist;
    waitframe();
  }

  var0.origin = var0.start;
  var0.clip disconnectPaths();
  level notify("audio_door_is_closed");
  self notify("closed");
  level notify(var0.targetname + "_closed");

  if(var0.targetname == "residence_sliding_door_entrance") {
    scripts\engine\utility::flag_set("defend_entrance_door_closed");

    if(isDefined(level.sr_exit_door)) {
      level.sr_exit_door delete();
      level.sr_exit_door = undefined;
    }

    if(isDefined(level.sr_entrance_door)) {
      level.sr_entrance_door delete();
      level.sr_entrance_door = undefined;
      return;
    }

    return;
  }

  thread residence_arrival_door_delete();
}

function residence_arrival_door_delete() {
  scripts\engine\utility::flag_wait("wave_5_house_end");
  self.clip connectpaths();
  self.clip delete();
  self delete();
}

function audio_residence_door_open() {
  self playSound("emb_residence_door_roll_open_start");
  self playLoopSound("emb_residence_door_roll_open_lp");
  wait 4;
  self playSound("emb_residence_door_roll_open_stop");
  wait 0.25;
  self stoploopsound();
}

function audio_residence_door_close() {
  self playSound("emb_residence_door_roll_closed_start");
  self playLoopSound("emb_residence_door_roll_closed_lp");
  level waittill("audio_door_is_closed");
  self playSound("emb_residence_door_roll_closed_stop");
  wait 0.25;
  self stoploopsound();
}

function residence_arrival_door_pauser(var0) {
  self endon("closed");
  self endon("entitydeleted");

  for(;;) {
    scripts\engine\utility::flag_wait(var0);
    thread audio_residence_door_close();
    self moveTo(self.start, self.move_pct * 10, 0.25 * self.move_pct, 0.25 * self.move_pct);
    scripts\engine\utility::flag_waitopen(var0);
    var1 = 1 - self.move_pct;
    self moveTo(self.end, var1 * 10, 0.25 * var1, 0.25 * var1);
  }
}

function residence_arrival_side_door(var0) {
  var1 = getEnt(var0, "targetname");
  var1.closed = spawnStruct();
  var1.closed.origin = var1.origin;
  var1.closed.angles = var1.angles;
  var1.open = scripts\engine\utility::getStruct(var0 + "_open", "targetname");
  var1.clip = var1 scripts\engine\utility::get_target_ent();
  var1.clip linkTo(var1);
  var1.origin = var1.open.origin;
  var1.angles = var1.open.angles;
  level waittill("residence_sliding_door_exit_closed");
  var1.origin = var1.closed.origin;
  var1.angles = var1.closed.angles;
  self notify("closed");
}

function residence_arrival_facade_doors() {
  var0 = getEntArray("res_facade_door", "targetname");

  foreach(var2 in var0) {
    var2.open = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  wait 10;

  foreach(var2 in var0) {
    var2 moveTo(var2.open.origin, 6);
  }
}

function residence_arrival_catchup() {
  scripts\engine\utility::flag_set("obj_escort_wolf_complete");
  thread residence_arrival_facade_doors_catchup();
  var0 = residence_arrival_door_setup("residence_sliding_door_exit", "residence_sliding_door_exit_end");
  thread residence_arrival_door_delete();
}

function residence_arrival_facade_doors_catchup() {
  var0 = getEntArray("res_facade_door", "targetname");

  foreach(var2 in var0) {
    var2.open = scripts\engine\utility::getStruct(var2.target, "targetname");
    var2.origin = var2.open.origin;
  }
}

function defend_approach_start() {
  squad_init();
  defend_inits();
  scripts\engine\sp\utility::set_start_location("roof_approach_start", [level.player, level.price, level.farah, level.alex, level.hadir]);
  thread sfx_spawn_crickets();
  scripts\engine\sp\utility::set_start_location("defend_start", [level.ally_01_mortar, level.ally_02_mortar, level.ally_03, level.ally_04, level.greeter_marine, level.fsa_02]);
}

function defend_approach_main() {
  var0 = getEnt("player_mortar_clip", "targetname");
  var0 notsolid();
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

function scriptable_field_lights_swap() {
  wait 0.3;
  var0 = getscriptablearray("field_light_pole", "script_noteworthy");

  foreach(var2 in var0) {
    var2.dummy = spawn("script_model", var2.origin);
    var2.dummy setModel(var2.model);
    var2.dummy.angles = var2.angles;
    var2.og_origin = var2.origin;
    var2.origin += (0, 0, -1000);
  }
}

function rooftop_touch_trigger() {
  scripts\engine\sp\utility::trigger_wait("roof_mortar_trigger", "targetname");
  scripts\engine\utility::flag_set("player_on_rooftop");
}

function heading_to_rooftop_check() {
  var0 = [level.price, level.alex];
  var1 = 350;

  while(!scripts\engine\utility::flag("player_on_rooftop")) {
    if(var1 < distance2d(level.player.origin, level.price.origin)) {
      level.player thread scripts\sp\player::focus_display_hint(undefined, 8);
      wait 18;
      var1 = 700;
    }

    waitframe();
  }
}

function defend_approach_hadir_to_roof() {
  level.hadir scripts\engine\sp\utility::set_goal_radius(64);
  level.hadir scripts\engine\sp\utility::set_goal_pos((-700.2, 719.8, 26));
  level.hadir waittill("goal");
  level.hadir scripts\engine\sp\utility::set_force_color("b");
}

function mus_intro_walkntalk() {
  wait 3;
  setmusicstate("mx_embassy_walkntalk_intro");
  wait 50.615;
  setmusicstate("mx_embassy_walkntalk");
  scripts\engine\utility::flag_wait("player_flaring");
  setmusicstate("");
}

function back_on_roof_nag() {
  if(scripts\engine\utility::flag("wave_1_falling_back")) {
    return;
  }

  level endon("wave_1_falling_back");
  var0 = ["dx_vom_pri_defend_nags_10", "dx_vom_pri_defend_nags_20", "dx_vom_pri_defend_nags_30"];
  var1 = scripts\engine\sp\utility::create_deck(var0);
  init_building_flags();

  for(;;) {
    scripts\sp\maps\embassy\embassy_util::flag_waitopen_all_array(["player_on_south_building", "player_on_north_building"]);

    while(!level.player isonground()) {
      waitframe();
    }

    level.price scripts\sp\maps\embassy\embassy_util::nagtill(["player_on_south_building", "player_on_north_building"], var1);
  }
}

function init_building_flags() {
  var0 = getEnt("building_a_roof_trigger", "targetname");
  var1 = getEnt("roof_mortar_trigger", "targetname");

  if(!scripts\engine\utility::flag_exist("player_on_north_building")) {
    scripts\engine\sp\utility::flag_trigger_init("player_on_north_building", var0, 1);
  }

  if(!scripts\engine\utility::flag_exist("player_on_south_building")) {
    scripts\engine\sp\utility::flag_trigger_init("player_on_south_building", var1, 1);
  }

  var0 scripts\engine\utility::trigger_on();
  var1 scripts\engine\utility::trigger_on();
}

function wrong_rooftop_nag() {
  if(scripts\engine\utility::flag("roof_compromised")) {
    return;
  }

  level endon("roof_compromised");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, [level.alex, "dx_vom_alx_defend_intro_100"]);
}

function defend_approach_catchup() {
  scripts\engine\utility::flag_set("approach_end");
  thread objective_manager_defend();

  if(!scripts\sp\starts::is_after_start("trucks")) {
    thread wrong_rooftop_nag();
    return;
  }
}

function defend_wave_0_start() {
  thread illumination_mortars_init();
  squad_init();
  defend_inits();
  scripts\engine\utility::flag_set("intro_skipped");
  scripts\engine\utility::flag_set("intro_vo_finished");
  var0 = [level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar];
  scripts\engine\sp\utility::set_start_location("defend_start", var0);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.player, level.ally_03, level.ally_04, level.greeter_marine, level.fsa_02, level.alex, level.hadir]);
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  thread distant_civs();
  var1 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  scripts\engine\utility::array_thread(var0, &scene_intro_to_roof_to_idle, var1);
  thread sfx_spawn_crickets();
  thread player_weaponfire_watcher();
}

function defend_wave_0_main() {
  thread weapon_check();
  scripts\engine\sp\utility::trigger_wait("roof_mortar_trigger", "targetname");
  scripts\engine\utility::flag_set("player_on_rooftop");
  thread sniper_rifle_nag();
  thread scripts\sp\maps\embassy\embassy_util::focus_reminder("player_has_sniper", 15);
  scripts\engine\utility::flag_wait("player_has_sniper");
  scripts\engine\sp\utility::autosave_by_name("player_has_sniper");
  thread dialogue_rooftops_wave_0();
  var0 = scripts\engine\utility::getStruct("mortar_wave_3_lookat", "targetname");
  var1 = 0.996195;
  var2 = gettime();
  var3 = 20000;

  for(;;) {
    if(gettime() > var2 + var3 || level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin, var1)) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("civ_life_start");
  scripts\engine\sp\utility::autosave_by_name("civ_life_start");
  distant_threat();
  scripts\engine\utility::flag_wait("wave_1_start");
  wait 3;
}

function weapon_check() {
  level.player endon("death");

  if(scripts\engine\utility::flag("civ_life_start")) {
    return;
  }

  level endon("civ_life_start");
  var0 = 0;

  for(;;) {
    var1 = level.player getweaponslistprimaries();

    foreach(var3 in var1) {
      var4 = getweaponattachments(var3);

      if(isDefined(var4) && var4.size > 0) {
        foreach(var6 in var4) {
          if(issubstr(var6, "scope")) {
            var0 = 1;
          }

          break;
        }
      }
    }

    if(var0) {
      scripts\engine\utility::flag_set("player_has_sniper");
    } else {
      scripts\engine\utility::flag_clear("player_has_sniper");
    }

    waitframe();
  }
}

function sniper_rifle_nag() {
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

function defend_wave_0_catchup() {
  scripts\engine\utility::flag_set("civ_life_start");
  scripts\engine\utility::flag_set("player_on_rooftop");
  scripts\engine\utility::flag_set("player_has_sniper");
  scripts\engine\utility::flag_set("intro_vo_finished");
  scripts\engine\utility::flag_set("wave_1_start");
}

function defend_wave_1_start() {
  squad_init();
  defend_inits();
  thread illumination_mortars_init();
  scripts\engine\utility::flag_set("intro_skipped");
  scripts\engine\utility::flag_set("wave_1_vo_skipped");
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("b");
  var0 = [level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar];
  scripts\engine\sp\utility::set_start_location("roof_approach_start", [level.hadir]);
  scripts\engine\sp\utility::set_start_location("defend_start", var0);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.player, level.ally_03, level.ally_04, level.greeter_marine, level.fsa_02, level.alex]);
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  var1 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  thread sfx_spawn_crickets();
}

function defend_wave_1_main() {
  thread scripts\sp\maps\embassy\embassy_util::reactive_foliage_med();
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
  thread scene_flare_react();
  var0 = [level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar];
  var1 = getEnt("building_b_roof_cover_volume", "targetname");
  var2 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  var2 notify("stop_loop");
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
  thread scripts\sp\maps\embassy\embassy_util::focus_reminder("wave_1_attack", 7);
  thread wave_1_autosave_manager();
  scripts\engine\utility::flag_wait("player_flaring");
  scripts\engine\utility::flag_set("first_flare");
  thread back_on_roof_nag();
  thread dialogue_rooftops_wave_1_post_flare();
  var2 notify("stop_loop_flare_react");
  scripts\engine\utility::flag_wait("wave_1_falling_back");
  thread mus_retreat();
  scripts\engine\utility::flag_wait_all("wave_1_end", "wave_1_vo_finished");
  scripts\engine\sp\utility::autosave_by_name("wave_1_complete");
}

function mus_retreat() {
  setmusicstate("mx_embassy_roof_transition");
  scripts\engine\utility::flag_wait("enemy_mortar_allow_fire");
  setmusicstate("");
}

function wave_1_exploder_manager() {
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::exploder("wave01");
  scripts\engine\utility::flag_waitopen("flares_out");
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::exploder("wave02");
  scripts\engine\utility::flag_waitopen("flares_out");
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::exploder("wave03");
}

function wave_1_autosave_manager() {
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

function distant_civs() {
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

function civ_vehicles() {
  thread civ_life_car_01(1);
  scripts\engine\utility::flag_wait("civ_life_start");
  wait 2;
  thread civ_life_car_00();
  wait 2;
  thread civ_life_car_01(2);
}

function civ_life_car_00() {
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("civ_veh_spawner_00");
  var0.maxhealth = 30000;
  var0.health = 30000;
  var0.regenerate = 1;
  var0 scripts\common\vehicle::godon();
  var0 setModel("veh8_civ_lnd_walfa_yellow");
  level notify("civ_car_spawn");
  var1 = getspawner("civ_driver_00", "targetname");
  var1.count = 1;
  var1 = scripts\engine\sp\utility::spawn_targetname("civ_driver_00", 1);
  var1.animname = "civ_driver";
  var1.ignoreme = 1;
  var1.allowdeath = 1;
  var2 = scripts\engine\utility::spawn_tag_origin(var0 gettagorigin("TAG_DRIVER"), var0 gettagangles("TAG_DRIVER"));
  var2.origin += (10, 0, -5);
  var2 linkTo(var0, "TAG_DRIVER");
  var1 linkTo(var0, "TAG_DRIVER");
  var2 thread scripts\common\anim::anim_loop_solo(var1, "driver_idle", "stop_loop");
  thread vehicle_death_watcher(var0);
  thread vehicle_whizby_watcher(var0, var1);
  var3 = getvehiclenode("civ_veh_start_00", "targetname");
  var0 scripts\common\vehicle::attach_vehicle_and_gopath(var3);
  var0 scripts\common\vehicle::vehicle_lights_on();
  playFXOnTag(scripts\engine\utility::getfx("vfx_embassy_car_headlight_truck_l"), var0, "tag_light_front_left");
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_embassy_car_headlight_truck_r"), var0, "tag_light_front_right");
  var0 vehicle_turnengineoff();
  var0 playSound("scn_embassy_civ_car_dist_02");
  wait 1;
  var0 endon("death");

  while(var0.veh_speed) {
    wait 0.1;
  }

  var2 delete();
  var1 delete();
  var0 delete();
}

function civ_life_car_01(var0) {
  var1 = scripts\common\vehicle::spawn_vehicle_from_targetname("civ_veh_spawner_00");
  var1.maxhealth = 30000;
  var1.health = 30000;
  var1.regenerate = 1;
  var1 scripts\common\vehicle::godon();
  var1 setModel("veh8_civ_lnd_walfa_black");
  level notify("civ_car_spawn");
  var2 = getspawner("civ_driver_00", "targetname");
  var2.count = 1;
  var2 = scripts\engine\sp\utility::spawn_targetname("civ_driver_00", 1);
  var2.animname = "civ_driver";
  var2.ignoreme = 1;
  var2.allowdeath = 1;
  var3 = scripts\engine\utility::spawn_tag_origin(var1 gettagorigin("TAG_DRIVER"), var1 gettagangles("TAG_DRIVER"));
  var3.origin += (10, 0, -5);
  var3 linkTo(var1, "TAG_DRIVER");
  var2 linkTo(var1, "TAG_DRIVER");
  var3 thread scripts\common\anim::anim_loop_solo(var2, "driver_idle", "stop_loop");
  thread vehicle_death_watcher(var1);
  thread vehicle_whizby_watcher(var1, var2);
  var4 = getvehiclenode("civ_veh_start_00", "targetname");
  var1 scripts\common\vehicle::attach_vehicle_and_gopath(var4);
  var1 scripts\common\vehicle::vehicle_lights_on();
  playFXOnTag(scripts\engine\utility::getfx("vfx_embassy_car_headlight_truck_l"), var1, "tag_light_front_left");
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_embassy_car_headlight_truck_r"), var1, "tag_light_front_right");
  var1 vehicle_turnengineoff();

  if(var0 == 1) {
    var1 playSound("scn_embassy_civ_car_dist_01");
  } else if(var0 == 2) {
    var1 playSound("scn_embassy_civ_car_dist_03");
  }

  wait 1;
  var1 endon("death");

  while(var1.veh_speed) {
    wait 0.1;
  }

  var2 delete();
  var1 delete();
  var3 delete();
}

function civs_walkers() {
  level endon("firing_down_field");
  level waittill("civ_walkers_go");
  wait 1;
  var0 = scripts\engine\sp\utility::array_spawn_noteworthy("civ_walkers", 1);
  scripts\engine\utility::array_thread(var0, &civ_walkers_anim_and_run_away);
  scripts\engine\utility::array_thread(var0, &civ_walkers_breakout);
}

function civ_walkers_anim_and_run_away() {
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

function civ_walkers_breakout() {
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

function civs_table() {
  level endon("firing_down_field");
  var0 = scripts\engine\sp\utility::array_spawn_noteworthy("table_civs", 1);

  foreach(var2 in var0) {
    var2.animname = var2.animation;
  }

  waitframe();
  var4 = getEnt("civ_table_table", "targetname");
  var5 = getEnt("civ_table_chair1", "targetname");
  var5 scripts\engine\sp\utility::assign_animtree("chair1");
  var6 = getEnt("civ_table_chair2", "targetname");
  var6 scripts\engine\sp\utility::assign_animtree("chair2");
  var7 = [var5, var6];
  thread civs_running_exiting_sounds();
  thread civs_running_exiting_2guys_right_sounds();
  thread civs_running_by_sounds_right_side();
  thread civs_running_by_sounds_left_side();
  var4 thread scripts\common\anim::anim_first_frame(var7, "civ_chair_idle");
  scripts\engine\utility::array_thread(var0, &civ_table_animations, var4);
  scripts\engine\utility::array_thread(var0, &civs_table_breakout, var4);
  scripts\engine\utility::flag_wait("player_flaring");
  var7 = [var5, var6, var4];
  scripts\engine\utility::array_delete(var7);
}

function civ_table_animations(var0) {
  level endon("firing_down_field");
  self endon("death");
  var0 thread scripts\common\anim::anim_loop_solo(self, "civ_table_idle", "civ_table_loop_end");
  scripts\engine\utility::flag_wait("table_civs_spooked");
  wait 2;
  var0 notify("civ_table_loop_end");
  var0 scripts\common\anim::anim_single_solo(self, "civ_table_exit");
  self delete();
}

function civs_running_exiting_sounds() {
  scripts\engine\utility::flag_wait("table_civs_spooked");
  wait 5.5;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_away_01", (4969, -1123, 100));
  wait 0.3;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_away_02", (5035, 423, 111));
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_away_03", (4548, -1834, 39));
}

function civs_running_exiting_2guys_right_sounds() {
  level waittill("civ_walkers_go");
  wait 17;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_away_05", (4548, -1834, 39));
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_runner_away_06", (4548, -1834, 39));
}

function civs_running_by_sounds_right_side() {
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

function civs_running_by_sounds_left_side() {
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

function civs_table_breakout(var0) {
  level endon("spawning_unknowns");
  self endon("death");
  self endon("entitydeleted");
  var0 endon("civ_table_loop_end");
  level waittill("firing_down_field");
  wait 0.2;
  var0 thread scripts\common\anim::anim_single_solo(self, "civ_table_exit");
  waitframe();
  self setanimrate(scripts\engine\utility::getanim("civ_table_exit"), 1.3);
  self waittillmatch("single anim", "end");
  self delete();
}

function civs_bike() {
  var0 = scripts\engine\utility::getStruct("bike_animstruct", "targetname");
  var0.origin = (4706, -279, -10);
  var0.angles = (0, 270, 0);
  var1 = scripts\engine\sp\utility::array_spawn_noteworthy("bike_civ", 1);
  var2 = var1[0];
  var2.animname = var2.animation;
  var3 = scripts\engine\sp\utility::spawn_anim_model("bike1");
  var4 = [var3, var2];
  scripts\engine\utility::array_thread(var4, &civs_bike_breakout, var0);
  level endon("firing_down_field");
  var0 scripts\common\anim::anim_first_frame(var4, "civ_bikers");
  scripts\engine\utility::flag_wait("civ_life_start");
  var0 thread scripts\common\anim::anim_single(var4, "civ_bikers");
  waitframe();
  var2 setanimrate(var2 scripts\engine\utility::getanim("civ_bikers"), 1.5);
  var3 setanimrate(var3 scripts\engine\utility::getanim("civ_bikers"), 1.5);
  var2 waittillmatch("single anim", "end");
  var2 delete();
  var3 delete();
}

function civs_bike_breakout(var0) {
  self endon("death");
  level endon("spawning_unknowns");
  level waittill("firing_down_field");

  if(!scripts\engine\utility::flag("civ_life_start")) {
    var0 thread scripts\common\anim::anim_single_solo(self, "civ_bikers");
  }

  wait 0.5;
  self setanimrate(scripts\engine\utility::getanim("civ_bikers"), 1.7);
  wait 1;
  self setanimrate(scripts\engine\utility::getanim("civ_bikers"), 2.2);
  self waittillmatch("single anim", "end");
  self delete();
}

function civs_garage_door_guy() {
  thread civs_garage_door_guy_endon_watcher();
  level endon("firing_down_field_unspooked");
  var0 = getspawner("door_civ", "script_noteworthy");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "garage_civ";
  waitframe();
  var2 = spawnStruct();
  var2.origin = var0.origin;
  var2.angles = var0.angles;
  var2 thread scripts\common\anim::anim_loop_solo(var1, "garage_civ_idle", "stop_loop");
  thread civs_garage_door_guy_breakout(var1);
  scripts\engine\utility::flag_wait("table_civs_spooked");
  wait 2;
  var2 notify("stop_loop");
  var2 thread scripts\common\anim::anim_single_solo(var1, "garage_civ_exit");
  var3 = getEnt("garage_door", "targetname");
  scripts\engine\utility::delaythread(2.3, &scripts\engine\utility::play_sound_in_space, "scn_embassy_cafe_door_close", var3.origin);
  level notify("sfx_garage_door_shutting");
  wait 2.4;
  var3 moveTo(var3.origin - (0, 0, 76), 1);
  wait 1;
  level notify("garage_door_closed");
  var1 delete();
}

function civs_garage_door_guy_endon_watcher() {
  level waittill("firing_down_field");
  waitframe();

  if(scripts\engine\utility::flag("table_civs_spooked")) {
    return;
  }

  level notify("firing_down_field_unspooked");
}

function civs_garage_door_guy_breakout(var0) {
  level endon("spawning_unknowns");
  var0 endon("stop_loop");
  var0 endon("civ_table_loop_end");
  level waittill("firing_down_field");
  wait 0.3;
  var0 thread scripts\common\anim::anim_single_solo(self, "garage_civ_exit");
  waitframe();
  self setanimrate(scripts\engine\utility::getanim("garage_civ_exit"), 1.2);
  var1 = getEnt("garage_door", "targetname");
  scripts\engine\utility::delaythread(1.3, &scripts\engine\utility::play_sound_in_space, "scn_embassy_cafe_door_close", var1.origin);
  level notify("sfx_garage_door_shutting");
  wait 1.8;
  var1 moveTo(var1.origin - (0, 0, 76), 0.5);
  wait 1;
  level notify("garage_door_closed");
  self delete();
}

function civs_soccer_guys() {
  var0 = scripts\engine\sp\utility::array_spawn_targetname("soccer_civs", 1);

  foreach(var2 in var0) {
    var2.animname = var2.script_noteworthy;
  }

  waitframe();
  scripts\engine\utility::array_thread(var0, &civs_soccer_guys_animation);
  scripts\engine\utility::array_thread(var0, &civs_soccer_guys_animation_breakout);
  thread sfx_cafe();
}

function civs_soccer_guys_animation() {
  level endon("firing_down_field");
  var0 = self;

  if(self.animname == "soccer_guy_1") {
    var1 = getEnt("soccer_guy_2", "script_noteworthy");
    var0 = var1;
  }

  var0 thread scripts\common\anim::anim_loop_solo(self, "civ_soccer_guys_idle", "stop_loop");
  scripts\engine\sp\utility::trigger_wait("roof_mortar_trigger", "targetname");
  scripts\engine\utility::flag_wait("intro_vo_finished");
  scripts\engine\utility::flag_wait("civ_life_start");
  var0 notify("stop_loop");
  var0 thread scripts\common\anim::anim_single_solo(self, "civ_soccer_guys");
  level waittill("garage_door_closed");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function civs_soccer_guys_animation_breakout() {
  level endon("spawning_unknowns");
  level waittill("firing_down_field");
  level waittill("garage_door_closed");
  self delete();
}

function sfx_cafe() {
  wait 9;
  var0 = spawn("script_origin", (4890, -955, 57));
  var0 scripts\engine\sp\utility::sound_fade_in("emt_embassy_cafe_game_lp", 0.2, 5, 1);
  level waittill("sfx_garage_door_shutting");
  wait 2.3;
  var0 playSound("emt_embassy_cafe_game_lp_end");
  wait 0.1;
  var0 stoploopsound();
  var0 delete();
}

function civs_spotters() {
  var0 = scripts\engine\utility::getStruct("spotter_animstruct", "targetname");
  var1 = scripts\engine\sp\utility::array_spawn_targetname("spotter_civs");
  var2 = undefined;

  foreach(var4 in var1) {
    thread civs_spotters_breakout();
    var4.animname = var4.script_noteworthy;
  }

  var0 thread scripts\common\anim::anim_loop(var1, "civ_spotters_idle", "stop_lean_loop");
  level endon("firing_down_field");
  scripts\engine\utility::flag_wait("civ_life_start");
  scripts\engine\utility::flag_wait("civ_spotters_start");
  var0 notify("stop_lean_loop");
  var0 thread scripts\common\anim::anim_single(var1, "civ_spotters");
  wait 6;
  level notify("civ_walkers_go");
  wait 5;
  scripts\engine\utility::flag_set("table_civs_spooked");
  wait 12;
  scripts\engine\utility::array_call(var1, &delete);
}

function civs_spotters_breakout() {
  level endon("table_civs_spooked");
  level waittill("firing_down_field");
  var0 = (5358, -808, -9.1);
  wait 0.2;
  self stopanimScripted();
  scripts\engine\sp\utility::set_goal_radius(75);
  self setgoalpos(var0);
  scripts\engine\utility::waittill_any_timeout(10, "goal");
  self delete();
}

function distant_threat() {
  scripts\engine\utility::flag_wait("wave_0_start_distant_threat");
  wait 1;

  if(scripts\engine\utility::flag("firing_down_field")) {
    wait 5;
  }

  var0 = scripts\engine\utility::getStruct("mortar_wave_3_lookat", "targetname");
  var1 = cos(90);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin, var1)) {
      break;
    }

    wait 0.1;
  }

  wait 1;
  level.distant_guys = getspawnerarray("wave_0_enemies");
  scripts\engine\utility::array_thread(level.distant_guys, &distant_guy_spawner_watcher);
  thread spawn_distant_threat();
  scripts\engine\utility::flag_wait("spawning_unknowns");
  waitframe();
  scripts\engine\utility::flag_clear("spawning_unknowns");
  wait 10;
  level.distant_guys = getspawnerarray("wave_0_1_enemies");
  scripts\engine\utility::array_thread(level.distant_guys, &distant_guy_spawner_watcher);
  thread spawn_distant_threat();
  scripts\engine\utility::flag_wait("spawning_unknowns");
  wait 2;
  scripts\engine\utility::flag_set("spawning_unknowns_01");
  wait 7;
  scripts\engine\utility::flag_set("distant_threat_complete");
}

function distant_threat_gate_init() {
  var0 = getEnt("distant_threat_gate", "targetname");
  var1 = var0 scripts\engine\utility::get_target_ent();
  var0.og_origin = var0.origin;
  var2 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var0.move_origin = var2.origin;
}

function distant_threat_gate_move() {
  var0 = getEnt("distant_threat_gate", "targetname");
  var0 moveTo(var0.move_origin, 2, 0, 2);
  wait 10.5;
  var0 moveTo(var0.og_origin, 2, 0, 2);
}

function distant_guy_spawner_watcher(var0, var1) {
  level endon("spawning_unknowns");
  level endon("wave_1_start");
  var2 = cos(1.5);
  var3 = cos(7);
  var4 = gettime();
  var5 = 10;

  if(isDefined(var0)) {
    var5 = var0;
  }

  var5 *= 1000;

  for(;;) {
    var6 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var3);
    var7 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var2);

    if(gettime() >= var4 + var5 || var6 && !var7 && level.player scripts\engine\sp\utility::isads()) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("spawning_unknowns");
}

function spawn_distant_threat() {
  scripts\engine\utility::flag_wait("spawning_unknowns");
  level notify("spawning_distant_threat");
  wait 0.2;

  foreach(var1 in level.distant_guys) {
    var1 scripts\engine\sp\utility::spawn_ai(1);

    if(var1.origin[1] > -1200) {
      scripts\engine\utility::flag_set("spawning_distant_threat_left_side");
    }

    if(var1.origin[1] < -1200) {
      scripts\engine\utility::flag_set("spawning_distant_threat_right_side");
    }

    wait 0.4;
  }
}

function distant_enemies_spawn_func() {
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

function friendlies_scared_of_dark() {
  while(!scripts\engine\utility::flag("enemies_at_the_wall") && !scripts\engine\utility::flag("flare_2_skipped")) {
    var0 = getaiarray("allies");

    if(!scripts\engine\utility::flag("flares_out")) {
      foreach(var2 in var0) {
        var2.ignoreall = 1;
      }
    } else {
      foreach(var2 in var0) {
        var2.ignoreall = 0;
      }
    }

    wait 0.5;
  }

  if(scripts\engine\utility::flag("flare_2_skipped")) {
    wait 5;
  }

  var0 = getaiarray("allies");

  foreach(var2 in var0) {
    var2.ignoreall = 0;
  }
}

function friendlies_defend_using_volume(var0, var1, var2) {
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::disable_ai_color);
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::set_fixednode_false);
  scripts\engine\utility::array_call(var0, &setgoalvolumeauto, var1, var1 scripts\engine\sp\utility::get_cover_volume_forward());
  scripts\engine\utility::flag_wait(var2);
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::enable_ai_color);
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::set_fixednode_true);
  var3 = spawnStruct();
  var3.count = var0.size;

  foreach(var5 in var0) {
    thread waittill_return_to_colornode(var3);
  }

  var3 waittill("returned_to_colornode");
  level notify("returned_to_colornodes");
}

function waittill_return_to_colornode(var0) {
  wait 0.1;
  var0.og_goalradius = var0.goalradius;
  var0.goalradius = 4;
  var0 waittill("goal");
  var0.goalradius = var0.og_goalradius;
  var0.og_goalradius = undefined;
  self.count--;

  if(self.count == 0) {
    self notify("returned_to_colornode");
    return;
  }
}

function flare_nag_1() {}

function flare_nag_2() {}

function flare_nag_2_skipped() {}

function flare_nag_3() {}

function price_mortar_run_triggers_on(var0) {
  var1 = getEntArray("price_mortar_run_triggers", "script_noteworthy");
  var1 = scripts\engine\utility::array_add(var1, getEnt("mortar_house_guys_trigger", "targetname"));
  var1 = scripts\engine\utility::array_add(var1, getEnt("wave_5_mortar_house_exterior_trigger", "targetname"));
  var1 = scripts\engine\utility::array_add(var1, getEnt("mortar_house_street_save", "targetname"));
  jumpiffalse(var0 == 0) LOC_0000008a;

  foreach(var3 in var1) {
    scripts\engine\utility::trigger_off(var3.targetname, "targetname");
  }

  return;
}

function price_compound_run_triggers_on(var0) {
  var1 = getEntArray("price_compound_run_triggers", "script_noteworthy");
  var2 = getEnt("wolf_escapes", "targetname");
  var1 = scripts\engine\utility::array_add(var1, var2);
  jumpiffalse(var0 == 0) LOC_00000066;

  foreach(var4 in var1) {
    scripts\engine\utility::trigger_off(var4.targetname, "targetname");
  }

  return;
}

function init_corner_wall() {
  var0 = getEntArray("building_a_roof_front_destructible", "script_noteworthy");

  foreach(var2 in var0) {
    if(var2.code_classname == "trigger_damage") {
      var2 setCanDamage(0);
    }
  }

  var4 = getEntArray("building_a_destroyed_wall_reveal", "targetname");

  foreach(var2 in var4) {
    var2 show();

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "brush") {
      var2 connectpaths();
    }
  }

  var7 = getEntArray("building_b_destroyed_roof_reveal", "targetname");
  var8 = getEntArray("building_a_roof_corner_destructible", "script_noteworthy");
  var9 = [];

  foreach(var2 in var8) {
    if(var2.code_classname == "trigger_damage") {
      var9 = var2;
    }
  }

  var12 = getEntArray("building_a_destroyed_solid", "targetname");
  var13 = getEntArray("building_a_roof_corner_wall", "targetname");
  var14 = [];

  foreach(var2 in var13) {
    var14 = var2;
  }

  if(!scripts\sp\starts::is_after_start("Mortar")) {
    scripts\engine\utility::array_call(var4, &hide);
    level waittill("mortar_impact");
    waitframe();
    level waittill("mortar_impact");
  }

  var17 = getEnt("roof_mortar_kill_trigger", "targetname");
  thread corner_wall_kill_player();
  var18 = undefined;

  foreach(var17 in var9) {
    var17 notify("damage", 6, var18, var18, var18, var18, var18, var18, var18, var18, "mortar");
  }

  var21 = getEntArray("roof_mortar_wall_light_model_02", "targetname");
  scripts\engine\utility::array_delete(var21);
  scripts\engine\utility::array_call(var4, &show);
  scripts\engine\utility::array_call(var14, &delete);
  scripts\engine\utility::array_call(var12, &delete);
  init_front_wall();
}

function init_front_wall(var0) {
  level waittill("mortar_impact");
  var0 = getEntArray("building_a_roof_front_destructible", "script_noteworthy");
  var1 = [];

  foreach(var3 in var0) {
    if(var3.code_classname == "trigger_damage") {
      var1 = var3;
    }
  }

  var5 = undefined;

  foreach(var7 in var1) {
    var7 notify("damage", 6, var5, var5, var5, var5, var5, var5, var5, var5, "mortar");
  }
}

function init_b_side_wall(var0) {
  wait 1;
  var0 = getEntArray("building_b_roof_front_destructible", "script_noteworthy");
  var1 = [];

  foreach(var3 in var0) {
    if(var3.code_classname == "trigger_damage") {
      var1 = var3;
    }
  }

  var5 = undefined;

  foreach(var7 in var1) {
    var7 notify("damage", 6, var5, var5, var5, var5, var5, var5, var5, var5, "mortar");
  }
}

function init_corner_wall_building_b() {
  var0 = getEntArray("building_b_roof_corner_wall", "targetname");
  scripts\engine\utility::flag_wait("wave_4_end");
  waitframe();
  scripts\engine\utility::array_call(var0, &hide);
}

function init_roof_destruction() {
  var0 = getEntArray("building_b_destroyed_roof_reveal", "targetname");
  var1 = getEnt("building_b_roof", "targetname");

  foreach(var3 in var0) {
    var3 show();

    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "brush") {
      var3 connectpaths();
    }
  }

  if(!scripts\sp\starts::is_after_start("laser_targeting_1")) {
    foreach(var3 in var0) {
      var3 hide();
    }

    var1 connectpaths();
    return;
  }
}

function init_destructible_roof_walls() {
  var0 = getEntArray("wall_trigger", "targetname");
  scripts\engine\utility::array_thread(var0, &init_wall_state);
}

function init_wall_state() {
  wait 0.15;
  var0 = scripts\engine\utility::get_linked_ents();
  var1 = scripts\engine\sp\utility::get_linked_scriptables();
  var0 = scripts\engine\utility::array_combine(var0, var1);
  var2 = undefined;

  foreach(var4 in var0) {
    if(isDefined(var4.script_noteworthy) && var4.script_noteworthy == "broken_wall") {
      var4 hide();
    }

    var4 setentityowner(self);
  }

  for(var6 = 1; var6; var6 = 0) {
    self waittill("damage", var7, var8, var9, var10, var11, var12, var13, var14, var15, var16);

    if(isDefined(var16)) {
      var2 = getweaponbasename(var16);
    }

    if(isDefined(var2) && var2 == "mortar" && var7 > 5) {}
  }

  foreach(var4 in var0) {
    if(!isDefined(var4.script_noteworthy)) {
      continue;
    }

    if(var4.script_noteworthy == "broken_wall") {
      var4 show();
      var4 dontcastshadows();
    }

    if(var4.script_noteworthy == "solid_wall") {
      if(scripts\engine\utility::array_contains(var1, var4)) {
        var4 setscriptablepartstate("base", "force_exploded");
        continue;
      }

      var4 delete();
    }
  }
}

function init_destructible_perimeter() {
  level.destructibles = [];
  level.east_wall_01 = getEntArray("mortar_wall_01", "targetname");
  thread destructible_perimeter();
  level.destructibles[level.destructibles.size] = level.east_wall_01;
  level.east_wall_02 = getEntArray("mortar_wall_02", "targetname");
  thread destructible_perimeter();
  level.destructibles[level.destructibles.size] = level.east_wall_02;
  level.east_wall_03 = getEntArray("mortar_wall_03", "targetname");
  thread destructible_perimeter();
  level.destructibles[level.destructibles.size] = level.east_wall_03;
  level.east_wall_04 = getEntArray("mortar_wall_04", "targetname");
  thread destructible_perimeter();
  level.destructibles[level.destructibles.size] = level.east_wall_04;
  level.east_wall_05 = getEntArray("mortar_wall_05", "targetname");
  thread destructible_perimeter();
  level.destructibles[level.destructibles.size] = level.east_wall_05;
  level.east_wall_07 = getEntArray("mortar_wall_07", "targetname");
  thread destructible_perimeter();
  level.destructibles[level.destructibles.size] = level.east_wall_07;
  level.roof_b_wall = getEntArray("roof_b_wall", "targetname");
  thread roof_b_wall_init();
}

function init_glowstick() {
  var0 = getEnt("light_stick", "targetname");
  var0 hide();
  var0.og_origin = var0.origin;
  var0.og_angles = var0.angles;
  var1 = getEnt("mortar_light", "targetname");
  var1.og_intensity = var1 getlightintensity();
  var1 setlightintensity(0);
  var1.og_origin = var1.origin;
  var1.og_angles = var1.angles;
  var1.origin = var0.origin;
  var0.light = var1;
}

function destructible_perimeter(var0) {
  var1 = undefined;
  var2 = undefined;
  var3 = 1;

  foreach(var5 in self) {
    if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == "broken_wall") {
      var5 hide();
    }

    if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == "solid_wall") {}
  }

  var2 = self[0];

  if(isDefined(var0)) {}

  for(var3 = 0; var3; var3 = 0) {
    var2 waittill("destroy");
  }

  foreach(var5 in self) {
    if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == "solid_wall") {
      var5 hide();

      if(var5.classname != "script_model") {
        var5 connectpaths();
      }
    }

    if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == "broken_wall") {
      var5 show();
      var5 dontcastshadows();

      if(isDefined(var5.script_parameters) && var5.script_parameters == "ground_clip") {
        var5 connectpaths();
      }
    }
  }

  wait 0.2;
}

function init_residence_wall() {
  waitframe();
  var0 = getEntArray("residence_destroyed_wall", "targetname");
  var1 = getEntArray("residence_pristine_wall", "targetname");
  var2 = scripts\engine\utility::array_combine(var0, var1);
  thread residence_wall_swap();
}

function residence_wall_swap() {
  foreach(var1 in self) {
    if(isDefined(var1.targetname) && var1.targetname == "residence_destroyed_wall") {
      var1 hide();
    }
  }

  scripts\engine\utility::flag_wait("residence_destroyed");

  foreach(var1 in self) {
    if(isDefined(var1.targetname) && var1.targetname == "residence_pristine_wall") {
      var1 hide();
    }

    if(isDefined(var1.targetname) && var1.targetname == "residence_destroyed_wall") {
      var1 show();
    }
  }
}

function roof_b_wall_init(var0) {
  foreach(var2 in self) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "broken_wall") {
      var2 hide();
    }
  }

  var4 = scripts\engine\utility::getStruct("roof_b_wall_struct", "script_noteworthy");
  var5 = 1;

  if(isDefined(var0)) {}

  for(var5 = 0; var5; var5 = 0) {
    if(isDefined(var0)) {
      break;
    }

    var4 waittill("destroy");
  }

  foreach(var2 in self) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "solid_wall") {
      var2 hide();
    }

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "broken_wall") {
      var2 show();
    }

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "clip") {
      var2 delete();
    }
  }
}

function roof_b_wall_02_init(var0) {
  foreach(var2 in self) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "broken_wall") {
      var2 hide();
    }
  }

  var4 = scripts\engine\utility::getStruct("roof_b_wall_struct_02", "script_noteworthy");
  var5 = 1;

  if(isDefined(var0)) {}

  for(var5 = 0; var5; var5 = 0) {
    if(isDefined(var0)) {
      break;
    }

    var4 waittill("destroy");
  }

  foreach(var2 in self) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "solid_wall") {
      var2 hide();
    }

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "broken_wall") {
      var2 show();
    }

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "clip") {
      var2 delete();
    }
  }
}

function roof_b_corner_wall_init(var0) {
  foreach(var2 in self) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "broken_wall") {
      var2 hide();
    }
  }

  var4 = scripts\engine\utility::getStruct("roof_b_corner_wall_struct", "script_noteworthy");
  var5 = 1;

  if(isDefined(var0)) {}

  for(var5 = 0; var5; var5 = 0) {
    var4 waittill("destroy");
  }

  foreach(var2 in self) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "solid_wall") {
      var2 hide();
    }

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "broken_wall") {
      var2 show();
    }

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "clip") {
      var2 delete();
    }
  }
}

function destructible_wall_mortar_end(var0, var1) {
  foreach(var3 in self) {
    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "solid_wall") {
      if(isDefined(var0)) {
        var4 = spawnStruct();
        var4.origin = var3.origin;
        var4.origin = (var4.origin[0] - 20, var4.origin[1] - 30, 20);

        if(isDefined(var1)) {
          var4.origin = (var3.origin[0] + var1, var4.origin[1] - 30, 20);
        }

        return var4;
      }

      return var5;
    }
  }

  var3 = undefined;
  var4 = undefined;
}

function player_kill_triggers() {
  var0 = getEnt("player_kill_triggers", "targetname");
  thread scripts\sp\trigger::trigger_outofbounds(var0);
}

function player_warn_trigger() {
  level endon("wave_4_end");

  if(scripts\sp\starts::is_after_start("mortar_building_attack")) {
    return;
  } else if(scripts\engine\utility::flag("wave_4_end")) {
    return;
  }

  var0 = getEnt("player_warn_trigger", "targetname");

  if(!level.player istouching(var0)) {
    scripts\engine\sp\utility::trigger_wait("player_warn_trigger", "targetname");
  }

  wait 1;
  level.price scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_pri_defend_intro_60");
  wait 4;

  if(level.player istouching(var0)) {
    level.price scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_pri_defend_intro_70");
  }

  wait 4;
  level.price scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_pri_defend_intro_60");
  wait 3;

  if(level.player istouching(var0)) {
    level.price scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_pri_defend_intro_70");
  }

  wait 1;
  var1 = scripts\engine\utility::getStructArray("player_kill_struct", "targetname");
}

function defend_wave_1_catchup() {
  thread shoot_out_field_lights(1);
  thread illumination_mortars_init();
  scripts\engine\utility::flag_set("front_1");
  scripts\engine\utility::flag_set("front_2");
  scripts\engine\utility::flag_set("front_3");
  scripts\engine\utility::flag_set("first_flare");
  scripts\engine\utility::flag_set("wave_1_end");
  var0 = getEntArray("residence_loot", "targetname");
  scripts\engine\utility::array_call(var0, &hide);
}

function defend_wave_2_trucks_start() {
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

function defend_wave_2_trucks_main() {
  thread scene_mortars();
  thread dialogue_rooftops_wave_2();
  level waittill("round_count_done");
  wait 2;
  var0 = scripts\engine\utility::getStruct("mortar_wave_3_lookat", "targetname");
  var1 = cos(90);
  scripts\engine\utility::flag_set("player_looking_toward_trucks");
  thread scripts\engine\utility::flag_set_delayed("stop_player_flare_mortar", 8);
  scripts\engine\utility::delaythread(11, &distant_threat_gate_move);
  scene_trucks_drive_in();
  scripts\engine\utility::flag_wait("trucks_stopped");
  wait 7;
  scripts\engine\sp\utility::autosave_by_name("trucks_end");
  scripts\engine\utility::flag_set("wave_2_trucks_end");
}

function scene_trucks_drive_in() {
  var0 = scripts\engine\utility::getStruct("mortar_trucks_animstruct", "targetname");
  var1 = getEnt("mortar_anim_truck_01", "targetname");
  var1 show();
  var1 scripts\engine\sp\utility::assign_animtree("truck_01");
  var2 = getEnt("mortar_anim_truck_02", "targetname");
  var2 show();
  var2 scripts\engine\sp\utility::assign_animtree("truck_02");
  var3 = getEnt("mortar_anim_truck_03", "targetname");
  var3 show();
  var3 scripts\engine\sp\utility::assign_animtree("truck_03");
  var4 = [var1, var2, var3];
  scripts\engine\utility::array_call(var4, &hide);
  scripts\engine\utility::flag_wait("player_looking_toward_trucks");
  scripts\engine\utility::array_call(var4, &show);
  scripts\engine\utility::array_thread(var4, &truck_drivers);
  level notify("mortar_trucks_start");
  thread sfx_trucks_drive_in_01();
  thread sfx_trucks_drive_in_02();
  var0 scripts\common\anim::anim_single(var4, "mortar_trucks_arrive");
  var1 waittillmatch("single anim", "end");
  scripts\engine\utility::flag_set("trucks_stopped");
  thread sfx_mortar_setup();
}

function truck_drivers() {
  var0 = self;
  var1 = getspawner("flavor_truck_driver", "targetname");
  var1.count += 1;
  var2 = var1 scripts\engine\sp\utility::spawn_ai(1);
  var2.animname = "flavor_truck_driver";
  var2 linkTo(var0, "tag_driver");
  var0 thread scripts\common\anim::anim_loop_solo(var2, "flavor_truck_drive_by", "stop_loop_driver", "tag_driver");
  scripts\engine\utility::flag_wait("trucks_stopped");
  wait 3;
  var2 delete();
}

function sfx_trucks_drive_in_01() {
  wait 3.7;
  self playSound("scn_embassy_trucks_drive_in");
}

function sfx_trucks_drive_in_02() {
  self playSound("scn_embassy_red_truck_drive_in");
}

function sfx_mortar_setup() {
  wait 3;
  var0 = spawn("script_origin", (4814, -1330, 214));
  var0 playSound("scn_embassy_mortar_setup");
  wait 6;
  var0 delete();
}

function scene_mortars() {
  level.ai_in_position = 0;
  var0 = [level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar];
  var1 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  scripts\engine\utility::array_thread(var0, &scene_mortars_ai_to_anim, var1);

  while(level.ai_in_position < 4) {
    waitframe();
  }

  scripts\engine\utility::flag_wait("player_looking_toward_trucks");

  if(!scripts\engine\utility::flag("wave_2_trucks_end")) {
    wait 1;
    var1 notify("stop_loop");
    var1 scripts\common\anim::anim_single(var0, "mortar_scene_trucks");
    var1 thread scripts\common\anim::anim_loop(var0, "mortar_scene_trucks_idle", "stop_loop");
  }

  scripts\engine\utility::flag_wait("enemy_mortar_allow_fire");
  wait 0.7;
  var1 notify("stop_loop");
  var1 scripts\common\anim::anim_single(var0, "mortar_scene_attack");
  level.ally_02_mortar scripts\common\ai::stop_magic_bullet_shield();
  level.ally_02_mortar.health = 1;
}

function scene_mortars_ai_to_anim(var0) {
  if(level.start_point == "mortar") {
    var0 endon("stop_loop");
  } else {
    var0 scripts\sp\anim::anim_reach_solo(self, "mortar_scene_start");
  }

  level.ai_in_position++;
  var0 scripts\common\anim::anim_single_solo(self, "mortar_scene_start");
  var0 thread scripts\common\anim::anim_loop_solo(self, "mortar_scene_idle", "stop_loop");
  scripts\engine\sp\utility::enable_ai_color();
}

function player_weaponfire_watcher() {
  level endon("wave_1_start");
  scripts\engine\sp\utility::trigger_wait("roof_mortar_trigger", "targetname");
  var0 = scripts\engine\utility::getStruct("mortar_wave_3_lookat", "targetname");

  for(;;) {
    level.player waittill("weapon_fired");

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin, 0.95)) {
      level notify("firing_down_field");
      scripts\engine\utility::flag_set("firing_down_field");
      wait 0.1;
      scripts\engine\utility::flag_set("wave_0_start_distant_threat");
    }
  }
}

function scene_intro_to_rooftops() {
  scripts\engine\sp\utility::set_start_location("approach_start", [level.ally_02_mortar]);
  var0 = getEntArray("flare_mortar_tube", "targetname");
  var1 = var0[1];
  var1 scripts\engine\sp\utility::assign_animtree("mortar");
  var1.anim_struct = spawnStruct();
  var1.anim_struct.angles = var1.angles;
  var1.anim_struct.origin = var1.origin;
  var2 = getEnt("ammo_box", "targetname");
  var2.clip = var2 scripts\engine\utility::get_target_ent();
  var2.clip linkTo(var2);
  var2.clip notsolid();
  var2 scripts\engine\sp\utility::assign_animtree("ammo_box");
  var3 = [level.price, level.farah];
  var4 = [level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar, var1, var2];
  var5 = [level.ally_01_mortar, level.ally_02_mortar, var1];
  var6 = [level.price, level.farah, level.ally_01_mortar, level.ally_02_mortar];
  var7 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  var7 thread scripts\common\anim::anim_first_frame_solo(var1, "rooftops_begin");
  var7 thread scripts\common\anim::anim_first_frame_solo(var2, "rooftops_begin");
  thread marine_rooftop_reach_and_idle(level.ally_02_mortar);
  var7 thread scripts\common\anim::anim_loop([level.ally_01_mortar], "rooftops_idle", "stop_loop");
  var7 thread scripts\common\anim::anim_single_solo(level.alex, "rooftops_intro_run");
  thread scene_intro_to_ai();
  var7 scripts\common\anim::anim_single(var3, "rooftops_intro_run");
  var7 notify("stop_loop");
  waitframe();
  var7 thread scripts\common\anim::anim_single(var4, "rooftops_begin");
  scripts\engine\utility::array_thread(var6, &scene_intro_to_roof_to_idle, var7);
  var2 waittillmatch("single anim", "end");
  var2.clip solid();
  var8 = getEnt("player_mortar_clip", "targetname");
  var8 solid();
  scripts\engine\utility::flag_wait("civ_life_start");
  scripts\engine\utility::flag_wait("player_flaring");
  var2.clip delete();
  var2 delete();
}

function marine_rooftop_reach_and_idle(var0) {
  var0 scripts\sp\anim::anim_reach([level.ally_02_mortar], "rooftops_idle");
  var0 scripts\common\anim::anim_loop_solo(level.ally_02_mortar, "rooftops_idle", "stop_loop");
}

function scene_intro_to_ai(var0) {
  self waittillmatch("single anim", "end");

  if(self != level.alex) {
    var0 thread scripts\sp\anim::anim_reach_solo(self, "rooftops_begin");
    return;
  }

  level.alex scripts\engine\sp\utility::set_force_color("b");
}

function scene_intro_to_roof_to_idle(var0) {
  if(!scripts\engine\utility::flag("intro_skipped")) {
    self waittillmatch("single anim", "end");
  }

  var0 scripts\common\anim::anim_single_solo(self, "mortar_scene_start");
  self setgoalpos(self.origin);

  if(self == level.ally_01_mortar) {
    var0 thread scripts\common\anim::anim_loop_solo(self, "mortar_scene_idle", "stop_mortar_guy_idle");
  } else {
    var0 thread scripts\common\anim::anim_loop_solo(self, "mortar_scene_idle", "stop_loop");
  }

  if(self == level.price) {
    scripts\engine\utility::flag_set("approach_end");
    return;
  }
}

function scene_flare_react() {
  if(scripts\engine\utility::flag("movement_skipped")) {
    wait 3;
  }

  var0 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  var0 notify("stop_mortar_guy_idle");
  waitframe();
  var0 scripts\common\anim::anim_single_solo(self, "flare_nag_start");
  var0 notify("stop_mortar_guy_idle");
  var0 thread scripts\common\anim::anim_loop_solo(self, "flare_nag_idle", "stop_loop_flare_react");
  scripts\engine\utility::flag_wait("enable_ilumination_flares");
  thread scene_flare_react_break_out();
  level endon("player_flaring");

  while(!scripts\engine\utility::flag("player_flaring") && !scripts\engine\utility::flag("flares_out")) {
    var0 notify("stop_loop_flare_react");
    var0 scripts\common\anim::anim_single_solo(self, "flare_nag");
    var0 thread scripts\common\anim::anim_loop_solo(self, "flare_nag_idle", "stop_loop_flare_react");
    wait 3;
    var0 notify("stop_loop_flare_react");
    waitframe();
  }
}

function scene_flare_react_break_out() {
  var0 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  scripts\engine\utility::flag_wait("player_flaring");
  var0 notify("stop_loop_flare_react");
  var0 scripts\common\anim::anim_single_solo(self, "flare_nag_react");
}

function scene_ally_drag() {
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
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    var2.grenadeammo = 0;
  }

  var4 = [level.ally_03, level.ally_04];
  var5 = scripts\engine\utility::getStruct("ally_drag_struct", "targetname");
  var5 scripts\sp\anim::anim_reach_solo(level.ally_03, "drag_scene_enter");
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    var2.grenadeammo = 0;
  }

  var5 scripts\common\anim::anim_single_solo(level.ally_03, "drag_scene_enter");
  thread dialogue_drag_scene();
  thread ally_anim_reach_after_delay(var5);
  var5 scripts\common\anim::anim_single_solo(level.ally_03, "drag_scene_hit");
  var5 thread scripts\common\anim::anim_single(var4, "drag_scene_drag");
  thread drag_buddy_go_to_combat();
  level.ally_03 waittillmatch("single anim", "end");
  var8 = scripts\engine\utility::getStruct("triage_struct", "targetname");
  var9 = getEnt("barracks_bloodstain", "targetname");
  var9 show();
  var5 thread scripts\common\anim::anim_last_frame_solo(level.ally_03, "drag_scene_drag");
  level.ally_03 scripts\engine\sp\utility::name_hide();
  scripts\engine\utility::flag_set("drag_scene_complete");
  var10 = getspawner("ally_03", "targetname");
  var10.count = 1;
  var11 = scripts\engine\sp\utility::bodyonlyspawn(var10);
  var11 setModel(level.ally_03.model);
  var11.animname = level.ally_03.animname;
  var11 scripts\common\ai::gun_remove();
  wait 0.1;
  var11 dontinterpolate();
  var5 thread scripts\common\anim::anim_last_frame_solo(var11, "drag_scene_drag");
  waitframe();
  level.ally_03 scripts\common\ai::stop_magic_bullet_shield();
  level.ally_03 delete();
  scripts\engine\utility::flag_wait("green_beam_acquired");
  var11 delete();
}

function drag_buddy_go_to_combat() {
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

function ally_anim_reach_after_delay(var0) {
  level.ally_04 scripts\engine\utility::disable_pain();
  level.ally_04.ignoreall = 1;
  level.ally_04 scripts\engine\sp\utility::set_goal_radius(20);
  level.ally_04 allowedstances("crouch");
  wait 3.7;
  level.ally_04 allowedstances("crouch", "stand");
  var0 scripts\sp\anim::anim_reach_and_approach_solo(level.ally_04, "drag_scene_drag");
}

function scene_triage() {
  var0 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  var0 notify("stop_loop");
  var1 = scripts\engine\utility::getStruct("ally_drag_struct", "targetname");
  var1 notify("stop_loop");
  waitframe();
  level.barracks_civ = scripts\engine\sp\utility::spawn_script_noteworthy("civ_02", 1);
  level.barracks_civ.animname = "civ_01";
  level.barracks_civ.allowdeath = 1;
  level.barracks_civ.health = 10;
  var2 = [level.price, level.farah];
  var3 = [level.price, level.barracks_civ];
  var4 = spawnStruct();
  var4.origin = (181, -92, -0.583);
  var4.angles = (0, 90, 0);
  var5 = scripts\engine\utility::getStruct("triage_corpse_remover", "targetname");
  var4.counter = 0;
  scripts\sp\maps\embassy\embassy_util::remove_corpses_near_pos(var5.origin, var5.radius);
  thread anim_reach_failsafe_go(level.price, 10, var4);
  var4 scripts\sp\anim::anim_reach_solo(level.price, "triage_scene_pre_enter");
  level.price notify("anim_reached");
  thread triage_scene_mayhem_anims();
  var4 scripts\common\anim::anim_single_solo(level.price, "triage_scene_pre_enter");
  var4 thread scripts\common\anim::anim_loop_solo(level.price, "triage_scene_enter_idle", "stop_price");
  thread triage_start_watcher();
  scripts\engine\utility::flag_wait("triage_start");
  scripts\engine\utility::flag_set("triage_scene_started");
  level.price scripts\sp\maps\embassy\embassy_util::wait_finish_speaking();
  var6 = getEnt("targetting_struct", "targetname");
  var6 scripts\engine\sp\utility::assign_animtree("green_beam");
  var7 = spawn_triage_props();
  var8 = var7[0];
  var7 = scripts\engine\utility::array_combine([var6], var7);
  var4 notify("stop_price");
  thread triage_door_open();
  var9 = scripts\engine\utility::array_combine([level.price, level.barracks_civ], var7);
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_triage_price_bang_door", (-106, 176, 107));
  var4 thread scripts\common\anim::anim_single(var9, "triage_scene_start");
  scripts\engine\utility::array_thread(var3, &scene_triage_to_idle, var4);
  thread triage_civ_breakout();
  level.player.rig hide();
  var4 thread scripts\common\anim::anim_first_frame_solo(level.player.rig, "heart_to_heart");
  level waittill("green_beam_hint");
  scripts\engine\utility::flag_set("green_beam_shown");
  var6 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 1, 0), &"EMBASSY/HINT_DESIGNATOR", 90, 200, 38, 0, undefined, 0, undefined, "duration_none", undefined, undefined, 65);
  var6 waittill("trigger");
  scripts\engine\utility::flag_clear("wave_3_inside");
  var4 notify("stop_loop");
  scripts\engine\utility::flag_set("green_beam_acquired");

  if(level.player ispcplayer()) {
    level.og_zplanes = getDvar("OMNONNMOTP");
    setsaveddvar("OMNONNMOTP", "0.1 500 1.5 10000");
  }

  level.green_beam = var6;
  thread scripts\sp\maps\embassy\embassy_lighting::green_beam_pickup();
  scripts\sp\maps\embassy\embassy_util::put_player_into_rig(level.player.rig, 0.5, 5, 5, 5, 5);
  var9 = [level.player.rig, level.price, var6];
  level.player.rig show();
  var4 thread scripts\common\anim::anim_single(var9, "heart_to_heart");
  var4 notify("stop_loop");
  thread price_to_idle_to_climb(var4);
  thread triage_rpg_momment_cleanup();
  level.player.rig waittillmatch("single anim", "end");
  level.barracks_civ notify("run_away");
  scripts\engine\utility::flag_set("allow_green_beam");
  scripts\engine\utility::exploder("field_fires");
  scripts\sp\maps\embassy\embassy_util::pull_player_out_of_rig_hide_rig(level.player.rig);
  var4 notify("stop_loop");
  var3 = scripts\engine\utility::array_remove_array([level.farah, level.price], var3);

  if(isDefined(level.og_zplanes) && level.player ispcplayer()) {
    setsaveddvar("OMNONNMOTP", level.og_zplanes);
    level.og_zplanes = undefined;
  }

  scripts\engine\utility::flag_wait("cleanup_triage_room");
  var10 = getweaponarray();

  foreach(var12 in var10) {
    if(var12.origin[2] < 60 && !scripts\engine\utility::is_equal(var12.targetname, "m4_refill_02")) {
      var12 delete();
    }
  }

  scripts\engine\utility::array_delete(var7);
}

function anim_reach_failsafe_go(var0, var1, var2) {
  self endon("anim_reached");
  wait var0;
  var3 = scripts\engine\utility::getanim(var2);
  var4 = getstartorigin(var1.origin, var1.angles, var3);
  var5 = getstartangles(var1.angles, var1.angles, var3);
  self forceteleport(var4, var5);
}

function triage_civ_breakout() {
  var0 = getEnt("building_b_bathroom_door", "targetname");
  level.barracks_civ waittill("idle_looping");
  level.barracks_civ scripts\engine\utility::waittill_any("bulletwhizby", "run_away");
  level.barracks_civ notify("run_away");
  wait 2.5;
  var0 rotateby((0, -70, 0), 1);
  wait 1;
  var0 rotateby((0, 70, 0), 0.5);
  wait 3;
  level.barracks_civ delete();
}

function price_to_idle_to_climb(var0) {
  level.price waittillmatch("single anim", "end");
  var0 thread scripts\common\anim::anim_loop_solo(level.price, "triage_scene_ladder_idle", "stop_loop");
  scripts\engine\utility::flag_wait("cleanup_triage_room");
  var0 notify("stop_loop");
  var1 = scripts\engine\utility::getStruct("ladder_up_struct", "targetname");
  var1 scripts\sp\anim::anim_reach_solo(level.price, "ladder_climb");
  var1 scripts\common\anim::anim_single_solo(level.price, "ladder_climb");
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::enable_ai_color();
  level.price scripts\engine\sp\utility::set_force_color("p");
}

function spawn_triage_props() {
  var0 = ["beam_case"];
  var1 = [];

  foreach(var3 in var0) {
    var1 = scripts\engine\sp\utility::spawn_anim_model(var3);
  }

  return var1;
}

function scene_alex_flare_support_breakout() {
  scripts\engine\utility::flag_wait("wave_2_end");
  level.support_mortar_tube notify("stop_flare_support_loop");
  level.support_mortar_tube scripts\common\anim::anim_single_solo(level.alex, "flare_launch_alex");
  level.alex scripts\engine\sp\utility::enable_ai_color();
}

function triage_reach_and_idle(var0) {
  self allowedstances("stand");
  var1 = "triage_scene_start";
  var2 = scripts\engine\utility::getanim(var1);
  var3 = getstartorigin(var0.origin, var0.angles, var2);
  var3 += (0, -100, 0);
  scripts\common\ai::disable_arrivals();
  self.goalradius = 32;
  self setgoalpos(var3);
  self waittill("goal");
  scripts\common\utility::demeanor_override("alert");
  scripts\common\ai::enable_arrivals();
  var0 scripts\sp\anim::anim_reach_and_approach_solo(self, var1);
  var0.counter++;
  var0 thread scripts\common\anim::anim_loop_solo(self, "triage_scene_enter_idle", "stop_loop");
  self allowedstances("stand", "crouch", "prone");
  scripts\common\utility::demeanor_override("combat");
}

function triage_door_open() {
  wait 2.5;
  var0 = getEnt("building_b_door", "targetname");
  var1 = var0 scripts\engine\utility::get_target_ent();
  var0.clip = getEnt(var1.targetname, "targetname");
  var0.clip linkTo(var0);
  var0 rotateYaw(-90, 1);
  var0.clip connectpaths();
}

function triage_door_close() {
  var0 = getEnt("building_b_door", "targetname");
  var1 = var0 scripts\engine\utility::get_target_ent();
  var0.clip = getEnt(var1.targetname, "targetname");
  var0.clip linkTo(var0);
  var0 rotateYaw(90, 2);
  wait 2;
  var0.clip disconnectPaths();
  var2 = getEntArray("triage_loot", "targetname");
  scripts\engine\utility::array_call(var2, &hide);
}

function scene_triage_to_idle(var0) {
  self endon("death");
  var1 = "stop_loop";
  wait 1;
  self waittillmatch("single anim", "end");

  if(self == level.price) {
    level notify("beam_show");
    var1 = "stop_loop";
  }

  var0 thread scripts\common\anim::anim_loop_solo(self, "triage_scene_idle", var1);

  if(self == level.barracks_civ) {
    self notify("idle_looping");
    self waittill("run_away");
    var0 thread scripts\common\anim::anim_single_solo(self, "triage_scene_exit");
  }

  if(self == level.farah) {
    scripts\engine\utility::flag_set("triage_idle");
    return;
  }
}

function scene_triage_to_exit(var0) {
  var0 scripts\common\anim::anim_single_solo(self, "triage_scene_exit");

  if(self == level.farah) {
    scripts\engine\sp\utility::enable_ai_color();
  }

  if(self == level.price) {
    level.price setgoalpos(level.price.origin);
    return;
  }
}

function scene_sniper_roof() {
  var0 = scripts\engine\utility::getStruct("roof_sniper_animstruct", "targetname");
  var0.origin += (175, 110, 0);
  var1 = [level.greeter_marine, level.fsa_02];
  var2 = "sniper_start_death";

  foreach(var4 in var1) {
    var4 scripts\engine\sp\utility::clear_force_color();
    var4.fixednode = 0;
  }

  thread anim_reach_failsafe_go(level.greeter_marine, 10, var0);
  thread anim_reach_failsafe_go(level.fsa_02, 10, var0);
  var0 scripts\sp\anim::anim_reach(var1, "sniper_start_death");

  foreach(var4 in var1) {
    var4 allowedstances("crouch");
  }

  level notify("scene_sniper_roof");
  var8 = getEnt("sniper_bad_place", "targetname");
  var9 = createnavbadplacebyent(var8, "axis");
  wait 1;
  level.greeter_marine notify("anim_reached");
  level.fsa_02 notify("anim_reached");
  var10 = (-934, 2367, 447);
  var11 = var1[1] gettagorigin("j_head");
  var12 = "iw8_ar_akilo47";
  var0 thread scripts\common\anim::anim_single(var1, "sniper_start_death");

  for(var13 = 0; var13 < 3; var13++) {
    magicbullet(var12, var10, var11 + (0, 1.5 * var13, 2 * var13));
    wait 0.1;
  }

  wait 1.3;

  for(var13 = 0; var13 < 5; var13++) {
    var11 = var1[1] gettagorigin("j_head");
    magicbullet(var12, var10, var11 + (0, 1.5 * var13, 2 * var13));
    wait 0.15;
  }

  wait 3;

  for(var13 = 0; var13 < 5; var13++) {
    var11 = var1[0] gettagorigin("j_head");
    magicbullet(var12, var10, var11 + (0, 1.5 * var13, 2 * var13));
    wait 0.15;
  }

  wait 4.5;

  for(var13 = 0; var13 < 5; var13++) {
    var11 = var1[0] gettagorigin("j_head");
    magicbullet(var12, var10, var11 + (0, 1.5 * var13, 2 * var13));
    wait 0.15;
  }

  destroynavobstacle(var9);
}

function defend_wave_2_trucks_catchup() {}

function defend_wave_2_mortars_start() {
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

function defend_wave_2_mortars_main() {
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
  var0 = getEnt("mortar_anim_truck_01", "targetname");
  var1 = getEnt("mortar_anim_truck_02", "targetname");
  var2 = getEnt("mortar_anim_truck_03", "targetname");
  var3 = [var0, var1, var2];
  scripts\engine\utility::array_call(var3, &hide);
  level notify("sfx_stop_crickets");
  scripts\engine\utility::delaythread(5, &scripts\engine\sp\utility::array_spawn_targetname, "wave_2_enemies", 1);
  level waittill("mortar_impact");
  var4 = getEnt("player_mortar_clip", "targetname");
  var4 delete();
  thread scene_ally_drag();
  thread destroy_first_roof_mortar();
  scripts\engine\utility::flag_wait("roof_compromised");
  level.flare_lifetime = 10;
  thread shadow_manager();
  scripts\engine\sp\utility::autosave_by_name("second_mortar");
  scripts\engine\utility::delaythread(5, &friendly_flare_sender_loop, "flare_north");
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
  var5 = getaiarray("axis");

  foreach(var7 in var5) {
    var7.grenadeammo = 0;
  }

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

function scriptable_compound_car_shadows() {
  wait 0.2;
  var0 = getscriptablearray();

  foreach(var2 in var0) {
    if(scripts\engine\utility::is_equal(var2.model, "veh8_civ_lnd_decho_mp_black")) {
      var2 dontcastshadows();
    }
  }
}

function shadow_manager() {
  var0 = getaiarray("allies");

  foreach(var2 in var0) {
    var2 dontcastshadows();
  }

  scripts\engine\utility::array_thread(var0, &ai_show_shadows_in_compound);
  scripts\engine\utility::flag_wait("wave_2_end");
  var0 = getaiarray("allies");

  foreach(var2 in var0) {
    var2 notify("castshadows");
    var2 castshadows();
  }
}

function ai_show_shadows_in_compound() {
  self endon("death");
  self endon("castshadows");
  var0 = getEnt("interior_main_grounds", "targetname");

  while(!self istouching(var0)) {
    wait 0.1;
  }

  self castshadows();
}

function player_runs_out_watcher() {
  level endon("ally_drag_start");
  var0 = getEnt("player_warn_trigger", "targetname");

  for(;;) {
    var1 = getaiarray("axis");

    if(level.player istouching(var0)) {
      foreach(var3 in var1) {
        var3 notify("player_outside");
      }
    }

    wait 0.5;
  }
}

function clear_enemy_grenades() {
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    var2.grenadeammo = 0;
  }
}

function defend_wave_2_push_start() {
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
  var0 = spawnStruct();
  var0.origin = (1289, -600, -20);
  scripts\engine\sp\utility::array_spawn_targetname("wave_2_enemies", 1);
  spawn_max_ai_wave_2_push();
  spawn_max_ai_wave_2_push();
  var1 = getaiarray("axis");

  foreach(var3 in var1) {
    var3 forceteleport(var0.origin, var3.angles);
  }

  level.push_delay = 4;
  scripts\engine\utility::exploder("mortar2");
  level.ally_04 delete();
  var5 = scripts\engine\utility::getStruct("triage_struct", "targetname");
  var5 thread scripts\common\anim::anim_first_frame_solo(level.ally_03, "drag_scene_idle");
  level.ally_03 scripts\engine\sp\utility::name_hide();
  scripts\sp\maps\embassy\embassy_lighting::start_tree_fire_flicker();
}

function defend_wave_2_push_main() {
  thread defend_push_weapon_cleanup();
  scripts\engine\sp\utility::activate_trigger_with_targetname("push_color_trigger");
  waitframe();

  if(isDefined(level.push_delay)) {
    wait level.push_delay;
  }

  var0 = getaiarray("axis");
  var0 = sortbydistance(var0, level.player.origin);

  foreach(var2 in var0) {
    var2.grenadeammo = 0;
  }

  thread enemies_battlecry();
  thread enemy_gun_pump();
  wait 1;
  scripts\engine\utility::flag_set("perimeter_breached");
  var4 = getnodearray("push_inside_path", "targetname");
  var4 = sortbydistance(var4, level.player.origin);
  wait 1;
  var0 = getaiarray("axis");
  var0 = sortbydistance(var0, var4[0].origin);
  scripts\engine\utility::array_thread(var0, &enemies_flood_interior, var0, var4);
  thread ignore_player_for_breach();
  scripts\engine\utility::flag_wait("perimeter_breached");
  level.fsa_02.ignoreall = 0;
  level.greeter_marine.ignoreall = 0;
  scripts\engine\sp\utility::activate_trigger_with_targetname("wall_breach_color_trigger");
  scripts\engine\utility::delaythread(7, &enemies_hunt_player);
  enemy_alive_counter_gate(8);
  spawn_max_ai_wave_2_push_again();
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    var2.grenadeammo = 0;
    var2 scripts\engine\sp\utility::set_ignoresuppression(1);
  }

  var7 = getEnt("interior_main_grounds", "targetname");
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    var2 setgoalvolumeauto(var7);
    LOC_0000019a:
  }

  enemy_alive_counter_gate(6);
  var10 = getaiarray("axis");

  foreach(var2 in var10) {
    var2 notify("clear_spawn_func_logic");
    waitframe();
    var2 scripts\engine\sp\utility::set_ignoresuppression(1);
    var2.ignoreall = 0;
    var2.attackeraccuracy = 1;
    var2 scripts\common\utility::demeanor_override("combat");
    var2 scripts\engine\utility::set_movement_speed(220);
    var2 setgoalpos((-48, -371, 80));
    var2 scripts\engine\sp\utility::set_goal_radius(350);
  }

  enemy_alive_counter_gate(4);
  var0 = getaiarray("axis");

  foreach(var14 in var0) {
    self.health = 1;
    self.attackeraccuracy = 10;
    self.baseaccuracy = 0;

    if(var14 scripts\engine\utility::doinglongdeath()) {
      var14 kill();
      continue;
    }

    var14 scripts\engine\sp\utility::disable_long_death();
  }

  enemy_alive_counter_gate(3);
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    if(isalive(var2)) {
      var2 scripts\engine\sp\utility::set_goal_radius(256);
      var2 setgoalentity(level.player);
      var2 scripts\engine\sp\utility::set_favoriteenemy(level.player);
      var2.health = 1;
    }
  }

  enemy_alive_counter_gate(0);
  scripts\engine\sp\utility::autosave_by_name("wave_2_complete");
  setaudiotriggerstate("combat_zone", "combat_lvl0", 1);
  setaudiotriggerstate("default", "combat_lvl0", 1);
  wait 7;
  scripts\engine\utility::flag_set("wave_2_end");
}

function defend_wave_2_push_catchup() {
  scripts\engine\utility::flag_set("push_objective");
  scripts\engine\utility::flag_set("wave_2_end");
  scripts\sp\maps\embassy\embassy_lighting::start_tree_fire_flicker();
}

function mortar_roof_deadly() {
  scripts\engine\utility::flag_wait("wave_3_mortars_roof_targeted");
  var0 = getEnt("roof_mortar_trigger", "targetname");
  wait 6;

  while(!scripts\engine\utility::flag("triage_start")) {
    if(level.player istouching(var0)) {
      level.player scripts\sp\utility::set_player_attacker_accuracy(10);
    } else {
      level.player scripts\sp\utility::set_player_attacker_accuracy(1);
    }

    wait 0.5;
  }

  level.player scripts\sp\utility::set_player_attacker_accuracy(1);
}

function spawn_weapons_and_armor() {
  var0 = getEnt("m4_refill_03", "targetname");

  if(isDefined(var0)) {
    var0.origin = var0.og_origin;
    var0.angles = var0.og_angles;
  }

  var0 = getEnt("m4_refill_01", "targetname");

  if(isDefined(var0)) {
    var0.origin = var0.og_origin;
    var0.angles = var0.og_angles;
    return;
  }
}

function spawn_triage_loot() {}

function spawn_ar(var0, var1) {
  var2 = "weapon_iw8_ar_mike4+reflex_west01";
  var3 = spawn(var2, var0, 1);
  var3.angles = var1;
  return var3;
}

function ignore_player_for_breach() {
  level.player.ignoreme = 1;
  wait 5;
  level.player.ignoreme = 0;
}

function corner_wall_kill_player() {
  if(!level.player istouching(self)) {
    return;
  }

  thread scripts\sp\hud_util::fade_out(0.4);
  level.player kill();
}

function enemies_battlecry() {
  if(isDefined(self[0])) {
    self[1] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_defend_battlecry_20");
  }

  if(isDefined(self[2])) {
    self[2] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq3_defend_battlecry_40");
  }

  if(isDefined(self[3])) {
    self[3] scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq3_defend_battlecry_41");
    return;
  }
}

function spawn_ai_wave_1() {
  level.wave_1_guys = [];
  var0 = 6;
  var1 = getspawnerarray("wave_1");

  if(var1.size - var0 < 0) {
    var0 = var1.size;
  }

  for(var2 = 0; var2 < var0; var2++) {
    level.wave_1_guys[level.wave_1_guys.size] = var1[var2] scripts\engine\sp\utility::spawn_ai(1);
  }
}

function spawn_ai_wave_2_pre_push() {
  var0 = getaiarray("axis", "allies");
  var1 = 28 - var0.size;
  var2 = getspawnerarray("wave_2_extra_1");

  if(var2.size - var1 < 0) {
    var1 = var2.size;
  }

  for(var3 = 0; var3 < var1; var3++) {
    var2[var3].count = 1;
    var2[var3] scripts\engine\sp\utility::spawn_ai(1);
    var2[var3].count = 1;
  }
}

function spawn_max_ai_wave_2_push() {
  var0 = getaiarray("axis", "allies");
  var1 = 28 - var0.size;
  var2 = getspawnerarray("wave_2_extra_3");

  if(var2.size - var1 < 0) {
    var1 = var2.size;
  }

  var3 = [];
  var4 = 0;

  while(var3.size - 1 < var1) {
    var5 = var2[var4] scripts\engine\sp\utility::spawn_ai();

    if(isDefined(var5)) {
      var3 = var5;
    }

    var2[var4].count = 1;
    var4++;

    if(var4 == var2.size - 1) {
      var4 = 0;
    }

    wait 0.3;
  }

  var0 = getaiarray("axis", "allies");
}

function spawn_max_ai_wave_2_push_again() {
  var0 = getaiarray("axis", "allies");
  var1 = 10;
  var2 = getspawnerarray("push_inside__refill");

  if(var2.size - var1 < 0) {
    var1 = var2.size;
  }

  var3 = [];
  var4 = 0;

  while(var3.size - 1 < var1) {
    var5 = var2[var4] scripts\engine\sp\utility::spawn_ai();

    if(isDefined(var5)) {
      var3 = var5;
    }

    var2[var4].count = 1;
    var4++;

    if(var4 == var2.size - 1) {
      var4 = 0;
    }

    wait 0.3;
  }
}

function enemies_hunt_player() {
  var0 = getaiarray("axis");
  var0 = scripts\engine\utility::array_randomize(var0);
  var1 = 3;
  var2 = [];

  if(var0.size > 15) {
    var1 = 6;
  }

  for(var3 = 0; var3 < var1; var3++) {
    var2 = var0[var3];
  }

  foreach(var5 in var2) {
    if(isalive(var5)) {
      var5 notify("hunting_player");
    }

    waitframe();

    if(isalive(var5)) {
      var5 scripts\engine\sp\utility::set_favoriteenemy(level.player);
      var5 scripts\engine\sp\utility::set_goal_radius(500);
      var5 setgoalentity(level.player);
      var5.seeking_player = 1;
    }
  }
}

function enemies_flood_interior(var0, var1) {
  self endon("death");
  self endon("hunting_player");
  scripts\engine\sp\utility::set_ignoresuppression(1);
  self.holding = undefined;

  if(var0.size > 16) {
    var2 = 4;

    while(var2 < 21) {
      if(isDefined(self) && isDefined(var0[var2]) && self == var0[var2]) {
        self.holding = 1;
      }

      var2 += 2;
    }
  }

  if(isDefined(self.holding)) {
    wait 3;
  }

  wait randomfloatrange(0.2, 0.5);
  scripts\engine\sp\utility::set_goal_radius(500);
  var3 = getEnt("interior_grounds_center", "targetname");
  scripts\engine\utility::set_movement_speed(140);
  self setgoalnode(var1[0]);
  scripts\engine\utility::waittill_any_timeout(12, "goal");
  var4 = scripts\engine\utility::getStruct("mortar_suv_struct", "script_noteworthy");
  self setgoalpos(var4.origin);
  scripts\engine\sp\utility::set_goal_radius(960);
}

function enemy_gun_pump() {
  self endon("death");
  self.animname = "aq_88";
  self.allowdeath = 1;
  var0 = ["first_wave_gun_pump_1", "first_wave_gun_pump_2"];
  thread scripts\common\anim::anim_single_solo(self, "first_wave_gun_pump_1");
  wait 2.7;
  level notify("enemy_rush_after_pump");
  self stopanimScripted();
  waitframe();
}

function defend_wave_2_mortars_catchup() {
  scripts\engine\utility::flag_set("palm_01_damaged");
  scripts\engine\utility::flag_set("roof_compromised");
  scripts\engine\utility::flag_set("push_objective");
  level.east_gate = getEnt("eastgate_clip", "targetname");
  var0 = level.east_gate scripts\engine\utility::get_target_ent();
  var0 hide();
  level.east_gate connectpaths();
  level.east_gate delete();
  level.east_wall_01 = getEntArray("mortar_wall_01", "targetname");
  thread destructible_perimeter(level.east_wall_01);
  level.east_wall_02 = getEntArray("mortar_wall_02", "targetname");
  thread destructible_perimeter(level.east_wall_02);
  level.east_wall_03 = getEntArray("mortar_wall_03", "targetname");
  thread destructible_perimeter(level.east_wall_03);
  level.east_wall_04 = getEntArray("mortar_wall_04", "targetname");
  thread destructible_perimeter(level.east_wall_04);
  level.east_wall_07 = getEntArray("mortar_wall_07", "targetname");
  thread destructible_perimeter(level.east_wall_07);
  level.roof_b_wall = getEntArray("roof_b_wall", "targetname");
  thread roof_b_wall_init(level.roof_b_wall);
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
    thread destructible_perimeter(level.east_wall_06);
  }

  scripts\engine\utility::exploder("firewall");
}

function wave_2_nerf_friendlies() {
  var0 = getaiarray("allies");

  foreach(var2 in var0) {
    var2.baseaccuracy = 0.6;

    if(isDefined(var2.roof)) {
      var2.ignoreme = 1;
      var2.baseaccuracy = 0.1;
    }
  }

  scripts\engine\utility::flag_wait("wave_2_end");
  var0 = getaiarray("allies");

  foreach(var2 in var0) {
    var2.baseaccuracy = 1;

    if(isDefined(var2.roof)) {
      var2.ignoreme = 0;
    }
  }
}

function defend_wave_3_triage_start() {
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
  var0 = scripts\engine\utility::getStruct("triage_struct", "targetname");
  level.ally_03 scripts\common\ai::stop_magic_bullet_shield();
  var0 thread scripts\common\anim::anim_first_frame_solo(level.ally_03, "drag_scene_idle");
  waitframe();
  level.ally_03.allowdeath = 1;
  level.ally_03.skipdeathanim = 1;
  level.ally_03.noragdoll = 1;
  level.ally_03.diequietly = 1;
  level.ally_03 scripts\engine\sp\utility::die();
}

function defend_wave_3_triage_main() {
  thread mantle_over_wall();
  scripts\engine\utility::flag_wait("wave_2_end");
  thread scripts\engine\utility::flag_set_delayed("triage_watcher_start", 2);
  thread scripts\sp\friendlyfire::reset_friendlyfire_participation();
  var0 = getaiarray("allies");

  foreach(var2 in var0) {
    if(var2 == level.farah || var2 == level.price) {
      continue;
    }

    var2 scripts\engine\sp\utility::clear_force_color();
    var2 scripts\engine\sp\utility::set_force_color("b");
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
  thread scripts\sp\maps\embassy\embassy_util::focus_reminder("wave_3_inside", 25);
  var4 = getaiarray("allies");
  scripts\engine\utility::flag_wait("triage_start");
  level.price scripts\engine\sp\utility::name_hide();
  var5 = getEntArray("triage_loot", "targetname");
  scripts\engine\utility::array_call(var5, &show);
  scripts\engine\utility::flag_wait("wave_3_inside");
  var6 = getEntArray("triage_loot_roof", "targetname");
  scripts\engine\utility::array_call(var6, &show);
  thread field_weapon_cleanup();
  thread scripts\sp\analytics::analytics_kleenex_update("Defend to Triage");
  level.support_mortar_tube.angles += (0, 120, 0);
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  scripts\engine\utility::flag_wait("allow_green_beam");
  scripts\engine\utility::flag_set("custom_cooldown");
  var7 = getEntArray("rooftop_loot", "targetname");
  scripts\engine\utility::array_call(var7, &hide);
  scripts\engine\sp\utility::autosave_by_name("green_beam_acquired");
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

function mantle_over_wall() {
  scripts\engine\utility::flag_wait("ladder_up");
  wait 2;
  scripts\engine\sp\utility::trigger_wait_targetname("building_a_roof_trigger");
  var0 = getEnt("mantle_trigger", "targetname");

  if(level.player istouching(var0)) {
    var1 = spawnStruct();
    var1.origin = (-172.1, 210.5, 220);
    var1.angles = (0, 90, 0);
    var2 = scripts\engine\utility::spawn_tag_origin(level.player.origin, var1.angles);
    level.player playerlinktoblend(var2, "tag_origin", 0.2);
    wait 0.2;
    var2 moveTo(var1.origin, 0.5, 0.5);
    level.player scripts\engine\sp\utility::player_gesture_force("ges_movement_mantle_32_over");
    wait 0.5;
    level.player unlink();
    return;
  }
}

function traversal_nav_obstacle() {
  var0 = getEnt("traversal_temp_nav_obstacle", "targetname");
  var1 = createnavbadplacebyent(var0, "axis", "allies");
  scripts\engine\utility::flag_wait("wave_4_end");
  destroynavobstacle(var1);
}

function embassy_palm_trees(var0) {
  if(isDefined(level.palm_trees) && level.palm_trees.size != 0) {
    foreach(var2 in level.palm_trees) {
      if(isDefined(var2)) {
        var3 = distance(var2.origin, var0);

        if(var3 < 600) {
          scripts\engine\utility::array_remove(level.palm_trees, var2);
          wait randomfloatrange(1, 2);

          if(scripts\engine\utility::is_equal(var2.targetname, "emb_palm_02")) {
            level notify("emb_palm_02_damaged");
            level.palm_trees = scripts\engine\utility::array_remove(level.palm_trees, var2);
          } else {
            scripts\engine\utility::exploder(var2.exploder_name);
            level.palm_trees = scripts\engine\utility::array_remove(level.palm_trees, var2);
          }
        }
      }
    }

    return;
  }
}

function triage_rpg_momment_cleanup() {
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
  var0 = getnode("price_ladder_node", "targetname");
  var1 = scripts\engine\utility::getStruct("farah_ladder_struct", "targetname");
  magicgrenademanual("mortar", level.player.origin + (0, 0, 250), (0, 0, 0), 0.05);
  var2 = getEnt("barracks_ladder_brush", "targetname");
  var2 hide();
  var3 = scripts\engine\utility::getStruct("ladder_up_struct", "targetname");
  var3.origin += (-34, 0, 0);
  level.price setgoalnode(var0);
  var4 = getEnt("barracks_ladder", "targetname");
  var4 scripts\engine\sp\utility::assign_animtree("ladder");
  var4.animname = "ladder";
  var5 = [var4, level.farah];
  var3 thread scripts\common\anim::anim_single(var5, "ladder_up_scene");
  waitframe();
  level.farah.pushable = 1;
  level.farah setanimtime(level.farah scripts\engine\utility::getanim("ladder_up_scene"), 0.01);
  var4 setanimtime(var4 scripts\engine\utility::getanim("ladder_up_scene"), 0.01);
  waitframe();
  level.farah setanimrate(level.farah scripts\engine\utility::getanim("ladder_up_scene"), 0);
  var4 setanimrate(var4 scripts\engine\utility::getanim("ladder_up_scene"), 0);
  thread scripts\engine\utility::flag_set_delayed("building_combat_objective", 5);
  scripts\engine\utility::flag_set("sniper_roof_start");
  thread can_see_farah_watcher();
  scripts\engine\utility::flag_wait("wave_3_inside");
  level.farah setanimrate(level.farah scripts\engine\utility::getanim("ladder_up_scene"), 1);
  var4 setanimrate(var4 scripts\engine\utility::getanim("ladder_up_scene"), 1);
  scripts\engine\utility::flag_set("ladder_up");
  var2 show();
  wait 4;
  thread intro_playerspeedscalinglogic();
  level.farah waittillmatch("single anim", "end");
  level notify("farah_over_roof");
  scripts\sp\player::player_movement_state("default");
}

function intro_playerspeedscalinglogic() {
  level endon("farah_over_roof");

  while(!level.player isonladder()) {
    waitframe();
  }

  var0 = level.farah;
  var1 = 40;
  var2 = 85;
  var3 = 20;
  var4 = 40;
  var5 = [var0];

  for(;;) {
    var6 = sortbydistance(var5, level.player.origin)[0];
    var7 = distance(var6.origin, level.player.origin);
    var8 = scripts\engine\math::normalize_value(var3, var4, var7);
    var9 = scripts\engine\math::factor_value(var1, var2, var8);
    scripts\engine\sp\utility::player_speed_set(var9);
    waitframe();
  }
}

function can_see_farah_watcher() {
  level endon("wave_3_inside");

  for(;;) {
    var0 = level.player getEye();
    var1 = level.farah.origin + (0, 0, 30);
    var2 = sighttracepassed(var0, var1, 0, level.player, 1);

    if(var2) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("wave_3_inside");
}

function triage_ammo_nag() {
  scripts\engine\utility::flag_wait("triage_idle");

  if(!scripts\engine\utility::flag("wave_3_inside")) {
    level thread scripts\engine\utility::add_dialogue_line("Price", "Kyle, get in here and resupply.", "purple");
    return;
  }
}

function triage_end_fadeout_waiting() {
  wait 4.5;
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 1.2);
}

function triage_start_watcher() {
  var0 = getEnt("triage_trigger", "targetname");
  var1 = level.price;
  var2 = 0.70701;
  var3 = 200;

  for(;;) {
    if(level.player istouching(var0) && distance2d(level.price.origin, level.player.origin) < 200) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("triage_start");
}

function defend_wave_3_triage_catchup() {
  var0 = getEntArray("triage_loot", "targetname");
  scripts\engine\utility::array_call(var0, &hide);
  var1 = getEntArray("rooftop_loot", "targetname");
  scripts\engine\utility::array_call(var1, &hide);
  scripts\engine\utility::exploder("field_fires");
  scripts\engine\utility::flag_set("custom_cooldown");
  scripts\engine\utility::flag_set("price_triage_objective");
  scripts\engine\utility::flag_set("wave_3_inside");
  scripts\engine\utility::flag_set("building_combat_objective");
  scripts\engine\utility::flag_set("green_beam_shown");
  scripts\engine\utility::flag_set("green_beam_acquired");
  thread traversal_nav_obstacle();
}

function defend_wave_3_buildings_start() {
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
  level.support_mortar_tube.angles += (0, 120, 0);
  scripts\engine\sp\utility::activate_trigger("wave_3_roof_color", "targetname");
  scripts\engine\utility::flag_set("allow_green_beam");
  scripts\engine\utility::flag_set("custom_cooldown");
}

function defend_wave_3_buildings_main() {
  if(scripts\sp\starts::is_after_start("triage_scene")) {
    waitframe();
  }

  thread scripts\engine\sp\utility::battlechatter_on("allies");
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  thread dialogue_rooftops_wave_3_building();
  thread scaffolding_combat();
  thread rpg_playerrepulsor();
  var0 = getaiarray("allies");
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
  var1 = getaiarray("allies");
  var2 = [level.price, level.farah, level.alex, level.hadir];

  foreach(var4 in var1) {
    var4.fixednode = 0;
    var4 scripts\engine\sp\utility::clear_force_color();
    var4 scripts\engine\sp\utility::set_goal_radius(400);
    var4 setgoalpos((-276.5, 422.5, 152));
    var4.goalheight = 72;
  }

  scripts\engine\sp\utility::activate_trigger("wave_3_roof_color", "targetname");
  var6 = spawnStruct();
  var6.origin = (63, 1090, 300);
  var7 = cos(20);
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

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var6.origin, var7)) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("player_looking_at_buildings");
  scripts\engine\sp\utility::autosave_by_name("roof_support");
  wait 2;
  var0 = getaiarray("allies");

  foreach(var4 in var0) {
    var4.ignoreall = 0;
  }

  scripts\engine\utility::flag_wait("wave_3_mid_end");
  scripts\engine\sp\utility::autosave_by_name("building_destroyed");
  thread player_looking_away_from_mayhem_watcher();
  scripts\engine\utility::flag_set("wave_3_end");
}

function defend_wave_3_ladder_vo() {
  level thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_uavoperator_defend_greenbeam1_10");
  level.price thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_greenbeam1_20");
}

function ally_equipment_watcher() {
  level.player endon("death");

  for(;;) {
    var0 = level.player getammocount(getcompleteweaponname("flash"));

    if(var0 < 2) {
      break;
    }

    wait 0.5;
  }

  level.hadir.support_equipment = 3;
  level.player notify("ally_equipment_notify");
  level.player.ally_equipment_force_ping = 1;
}

function scaffolding_combat() {
  level.scaffolding_choice = undefined;
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  var3 = scripts\engine\sp\utility::array_spawn_targetname("guard_rails_guys", 1);

  foreach(var5 in var3) {
    var5 scripts\engine\sp\utility::set_goal_radius(64);
  }

  var1 = scripts\engine\sp\utility::array_spawn_targetname("scaffolding_c_guys", 1);
  scripts\engine\utility::array_thread(var1, &backup_nodes);
  thread scaffolding_mayhem("scaffolding_c_clip", "scaffolding_c_trigger", "scaffolding_c", "scaffolding_c_guys");
  thread scaffolding_mayhem("scaffolding_b_clip", "scaffolding_b_trigger", "scaffolding_b", "scaffolding_b_guys");
  thread scaffolding_mayhem("scaffolding_a_clip", "scaffolding_a_trigger", "scaffolding_a", "scaffolding_a_guys");
  var7 = spawnStruct();
  var7.origin = (63, 1090, 300);
  var8 = cos(20);

  for(;;) {
    if(scripts\engine\utility::flag("player_looking_at_buildings") || scripts\engine\utility::flag("wave_3_ladder")) {
      break;
    }

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var7.origin, var8)) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("player_looking_at_buildings");
  wait 6;
  var0 = scripts\engine\sp\utility::array_spawn_targetname("scaffolding_b_guys", 1);
  scripts\engine\utility::array_thread(var0, &backup_nodes);
  wait 7;
  var2 = scripts\engine\sp\utility::array_spawn_targetname("scaffolding_a_guys", 1);
  scripts\engine\utility::array_thread(var2, &backup_nodes);
  var9 = scripts\engine\utility::array_combine(var2, var0, var1);
  var9 = scripts\sp\maps\embassy\embassy_util::array_removedeaddyingorundefined(var9);
  var10 = scripts\engine\utility::getStruct("scaffolding_d_struct", "targetname");
  enemy_alive_counter_gate(3);
  var11 = getspawner("scaffolding_d_guys", "targetname");
  var12 = [];

  for(var13 = 0; var13 < 3; var13++) {
    var5 = var11 scripts\engine\sp\utility::spawn_ai(1);
    var5 scripts\engine\sp\utility::set_goal_radius(375);
    var5.goalheight = 10;
    var5.ignoresuppression = 1;
    var5.attackeraccuracy = 0.1;
    var5 setgoalpos(var10.origin);
    var12 = var5;
    var11.count = 1;
    wait 0.5;
  }

  var9 = scripts\engine\utility::array_combine(var9, var3, var12);
  var9 = scripts\sp\maps\embassy\embassy_util::array_removedeaddyingorundefined(var9);
  thread enemies_alive_watcher(var9, "wave_3_mid_end");
}

function backup_nodes() {
  self endon("death");
  scripts\engine\utility::waittill_any("bad_path", "path_blocked");
  self.target = undefined;
  scripts\engine\sp\utility::set_goal_radius(1000);
  self setgoalpos(self.origin);
  self.ignoreall = 1;
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
}

function rpg_playerrepulsor() {
  var0 = missile_createrepulsorent(level.player, 400, 1500);
  scripts\engine\sp\utility::trigger_wait("building_a_roof_trigger", "targetname");
  var0 = missile_createrepulsorent(level.player, 600, 2000);
  scripts\engine\utility::flag_wait("wave_3_end");
  missile_deleteattractor(var0);
}

function scaffolding_mayhem(var0, var1, var2, var3) {
  var4 = getEnt(var0, "targetname");
  var4.trigger = getEnt(var1, "targetname");
  var4 setCanDamage(1);
  var5 = undefined;
  var6 = 1;

  while(!var4.trigger istouching(level.rocket_tag) && !scripts\engine\utility::flag("mayhem_done")) {
    waitframe();
  }

  thread sfx_scaffolding_mayhem(var2, var4);
  playmayhem(var2);
  playmayhem(var2 + "_tarps");
  var4 notsolid();
  var4 disconnectPaths();

  if(isDefined(var3)) {
    var3 = getEntArray(var3, "targetname");

    foreach(var8 in var3) {
      if(isalive(var8)) {
        var8.forceragdollimmediate = 1;
        var8 kill();
      }
    }
  }

  scripts\engine\utility::flag_wait("hide_mayhem");
  hidemayhem(var2);
  hidemayhem(var2 + "_tarps");
}

function sfx_scaffolding_mayhem(var0, var1) {
  if(var0 == "scaffolding_a") {
    thread scripts\engine\utility::play_sound_in_space("mayhem_emb_laser_bldng_mayhem_right", var1.origin);
    return;
  }

  if(var0 == "scaffolding_b") {
    thread scripts\engine\utility::play_sound_in_space("mayhem_emb_laser_bldng_mayhem_middle", var1.origin);
    return;
  }

  if(var0 == "scaffolding_c") {
    thread scripts\engine\utility::play_sound_in_space("mayhem_emb_laser_bldng_mayhem_left", var1.origin);
    return;
  }
}

function scaffolding_rocket_watcher(var0) {
  thread embassy_technicals(var0);
  self waittill("explode", var1);
  thread embassy_palm_trees(var0);
  wait 0.1;
  level.rocket_tag dontinterpolate();
  level.rocket_tag.origin = var1;
  var2 = getEntArray("building_rails", "targetname");
  scripts\engine\utility::array_thread(var2, &building_rails_destroy, level.rocket_tag.origin);
}

function building_rails_destroy(var0) {
  if(120 > distance(self.origin, var0)) {
    self delete();
    return;
  }
}

function embassy_technicals(var0) {
  if(isDefined(level.technicals) && level.technicals.size != 0) {
    foreach(var2 in level.technicals) {
      if(isDefined(var2)) {
        var3 = distance(var2.origin, var0);

        if(var3 < 800) {
          if(scripts\engine\utility::flag_exist("fire_rocket_at_technical")) {
            scripts\engine\utility::flag_set("fire_rocket_at_technical");
            wait 1;
            scripts\engine\utility::flag_clear("fire_rocket_at_technical");
          }
        }
      }
    }

    return;
  }
}

function enemies_alive_watcher(var0, var1) {
  while(var0.size > 0) {
    var0 = scripts\sp\maps\embassy\embassy_util::array_removedeaddyingorundefined(var0);
    wait 0.1;
  }

  if(isDefined(var1)) {
    scripts\engine\utility::flag_set(var1);
    return;
  }
}

function defend_wave_3_buildings_catchup() {
  if(isDefined(level.hadir)) {
    thread ally_equipment_watcher();
    return;
  }
}

function defend_wave_4_targeting_start() {
  defend_inits();
  squad_init();
  scripts\engine\utility::flag_set("wave_3_end");
  scripts\engine\utility::flag_set("wave_3_mid_end");
  scripts\engine\utility::flag_set("targeting_laser_acquired");
  scripts\engine\sp\utility::set_start_location("defend_wave_4_start", [level.greeter_marine, level.fsa_02, level.player, level.price, level.farah, level.alex]);
  scripts\engine\sp\utility::set_start_location("defend_wave_5_start", [level.player]);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.hadir]);
  var0 = getaiarray("allies");

  foreach(var2 in var0) {
    var2 scripts\engine\sp\utility::clear_force_color();
  }

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

function defend_wave_4_targeting_main() {
  thread scripts\sp\maps\embassy\embassy_lighting::mortar_building_attack_lighting(4);
  thread scripts\engine\sp\utility::battlechatter_off("allies");
  scripts\engine\utility::flag_wait("wave_3_end");
  scripts\engine\sp\utility::autosave_by_name("wave_4_street");
  drone_nags_disable();
  setaudiotriggerstate("combat_zone", "combat_lvl0", 1);
  setaudiotriggerstate("default", "combat_lvl0", 1);
  thread dialogue_rooftops_wave_4();
  level.price thread scripts\engine\sp\utility::name_hide();

  if(!isDefined(level.price.og_name)) {
    level.price.og_name = "Price";
  }

  level.price thread scripts\engine\sp\utility::name_show();
  level.front_goal_vol = getEnt("exterior_north_vol", "targetname");
  var0 = getaiarray("allies");
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  level waittill("move_east");

  foreach(var2 in var0) {
    var2 scripts\engine\sp\utility::clear_force_color();
    var2 scripts\engine\sp\utility::set_force_color("b");
  }

  thread civ_car();
  scripts\engine\utility::flag_wait("civ_car_spawn");
  level waittill("civ_car_gone");
}

function defend_wave_4_targeting_catchup() {}

function defend_wave_4_technicles_start() {
  defend_inits();
  squad_init();
  scripts\engine\utility::flag_set("wave_3_inside");
  scripts\engine\utility::flag_set("wave_3_end");
  scripts\engine\utility::flag_set("wave_3_mid_end");
  scripts\engine\utility::flag_set("targeting_laser_acquired");
  scripts\engine\sp\utility::set_start_location("defend_wave_4_start", [level.greeter_marine, level.fsa_02, level.player, level.price, level.farah, level.alex]);
  scripts\engine\sp\utility::set_start_location("defend_wave_5_start", [level.player]);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.hadir]);
  var0 = getaiarray("allies");

  foreach(var2 in var0) {
    var2 scripts\engine\sp\utility::clear_force_color();
  }

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

function defend_wave_4_technicles_main() {
  setsaveddvar("NQNQPRLRQM", 0.15);
  visionsetnaked("embassy_field_brighter", 3);
  level.player scripts\sp\utility::set_player_attacker_accuracy(0.5);
  thread dialogue_rooftops_wave_4_technicals();
  level waittill("drone_callout");
  thread scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\sp\utility::autosave_by_name("drone_callout");
  var0 = getaiarray("allies");
  var1 = [level.price, level.farah, level.alex, level.hadir];

  foreach(var3 in var0) {
    var3.fixednode = 0;
    var3 scripts\engine\sp\utility::clear_force_color();
    var3 scripts\engine\sp\utility::set_goal_radius(400);
    var3 setgoalpos((-276.5, 422.5, 152));
    var3.goalheight = 72;
  }

  level.technical_02 = undefined;
  thread achievement_watcher();
  thread wave_4_technical_02();

  while(!isDefined(level.technical_02)) {
    waitframe();
  }

  wait 1;
  var5 = gettime();
  var6 = scripts\engine\sp\utility::getvehiclearray();

  while(var6.size > 0 && var5 + 10000 > gettime()) {
    var6 = scripts\engine\sp\utility::getvehiclearray();
    wait 0.1;
  }

  thread wave_4_technical_03();
  wait 1;

  while(var6.size > 0 && var5 + 12000 > gettime()) {
    var6 = scripts\engine\sp\utility::getvehiclearray();
    wait 0.1;
  }

  scripts\engine\sp\utility::autosave_by_name("streets_guys");
  thread spawn_street_guys();
  wait 0.5;
  scripts\engine\utility::delaythread(12, &wave_4_technical_10);
  player_looking_down_street_watcher();
  wait 5;
  thread audio_defend_4_zone_state();
  enemy_alive_counter_gate(2);
  scripts\engine\sp\utility::autosave_by_name("last_technical");
  thread wave_4_technical_09();
  scripts\engine\utility::flag_set("wave_4_final_technical_spawn");
  scripts\engine\utility::delaythread(6, &scripts\engine\sp\utility::array_spawn_targetname, "wave_4_corner_guys", 1);
  wait 1;
  scripts\engine\utility::flag_wait("beam_technical_guys_killed");
  scripts\engine\utility::flag_wait("corner_guys_spawned");
  enemy_alive_counter_gate(3);
  var7 = getaiarray("axis");

  foreach(var3 in var7) {
    var3 notify("clear_spawn_func_logic");
    waitframe();
    var3.ignoreall = 0;
    var3.attackeraccuracy = 1;
    var3 scripts\common\utility::demeanor_override("combat");
    var3 scripts\engine\utility::set_movement_speed(220);
    var3 setgoalpos((-48, -371, 80));
    var3 scripts\engine\sp\utility::set_goal_radius(400);

    if(distance(var3.origin, level.player.origin) > 2500) {
      var3 kill();
    }
  }

  enemy_alive_counter_gate(0);
  level.player scripts\sp\utility::set_player_attacker_accuracy(1);
  scripts\engine\utility::flag_set("wave_4_end");
  scripts\engine\sp\utility::autosave_by_name("wave_4_complete");
  scripts\engine\utility::flag_wait("wave_4_dialogue_complete");

  if(scripts\sp\maps\embassy\embassy_util::green_beam_swap_hint_check()) {
    scripts\engine\sp\utility::display_hint("green_beam_check");
  }

  setsaveddvar("NQNQPRLRQM", 1);
}

function achievement_watcher() {
  level endon("technical_achievement_fail");
  level endon("wave_4_dialogue_complete");
  scripts\engine\utility::flag_wait("wave_4_final_technical_spawn");
  wait 0.1;

  while(isDefined(level.technical_09.health) && level.technical_09.health >= 1) {
    wait 0.15;
  }

  thread scripts\sp\utility::giveachievement_wrapper("lovefromabove");
}

function audio_defend_4_zone_state() {
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

function defend_wave_4_technicles_catchup() {
  scripts\engine\utility::flag_set("wave_4_end");

  if(!scripts\sp\starts::is_after_start("laser_targeting_2")) {
    scripts\engine\utility::flag_set("allow_green_beam");
    level endon("allow_green_beam");
    GscBinSkip4(0x35);
  }
}

function civ_car() {
  var0 = spawnStruct();
  var0.origin = (4140, 896, 24);
  var1 = 0.93969;
  var2 = gettime();
  var3 = 8000;

  for(;;) {
    if(gettime() > var2 + var3 || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin, var1)) {
      break;
    }

    wait 0.1;
  }

  level.civ_car = scripts\common\vehicle::spawn_vehicle_from_targetname("civ_veh_spawner_01");
  level.civ_car.maxhealth = 21000;
  level.civ_car.health = 21000;
  level.civ_car.regenerate = 0;
  thread swapped_car();
  level notify("civ_car_spawn");
  scripts\engine\utility::flag_set("civ_car_spawn");
  var4 = scripts\engine\sp\utility::spawn_targetname("civ_driver", 1);
  var4.animname = "civ_driver";
  var4.ignoreme = 1;
  var4.allowdeath = 1;
  var4 scripts\common\utility::lookatentity(level.player);
  var5 = scripts\engine\utility::spawn_tag_origin(level.civ_car gettagorigin("TAG_DRIVER"), level.civ_car gettagangles("TAG_DRIVER"));
  var5.origin += (10, 0, -5);
  var5 linkTo(level.civ_car, "TAG_DRIVER");
  var4 linkTo(level.civ_car, "TAG_DRIVER");
  var4.no_friendly_fire_fail = 1;
  var5 thread scripts\common\anim::anim_loop_solo(var4, "driver_idle", "stop_loop");
  var4 scripts\engine\sp\utility::set_deathanim("driver_death");
  thread vehicle_death_watcher(level.civ_car);
  thread vehicle_whizby_watcher(level.civ_car, var4);
  thread driver_death_watcher();
  var6 = getvehiclenode("civ_veh_start_01", "targetname");
  level.civ_car scripts\common\vehicle::attach_vehicle_and_gopath(var6);
  playFXOnTag(scripts\engine\utility::getfx("vfx_embassy_car_headlight_truck_l"), level.civ_car, "tag_light_front_left");
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_embassy_car_headlight_truck_r"), level.civ_car, "tag_light_front_right");
  waitframe();
  thread vo_unkown_car(var4);
  thread sfx_unknown_car();
  wait 1;
  level.civ_car.regenerate = 0;
  level.civ_car endon("death");
  level.civ_car endon("driver_death");

  while(level.civ_car.veh_speed) {
    wait 0.1;
  }

  var4 delete();
  level.civ_car delete();
  var5 delete();
  level notify("civ_car_gone");
  level notify("civ_car_escaped");
}

function swapped_car() {
  self endon("entitydeleted");
  level.colmaps = [];
  level.colmaps = getEntArray("collmap_scriptable", "classname");
  var0 = undefined;

  foreach(var2 in level.colmaps) {
    if(scripts\engine\utility::is_equal(var2.targetname, "veh8_civ_lnd_walfa")) {
      var0 = var2;
      break;
    }
  }

  self.new_col_map = spawn("script_model", (0, 0, 0));
  self.new_col_map clonebrushmodeltoscriptmodel(var0);
  self.new_col_map hide();
  self.new_col_map.angles = self.angles;
  self.new_col_map.origin = self.origin;
  self.new_col_map linkTo(self);
  self waittill("death");
  self.new_col_map show();
  var4 = createnavbadplacebyent(self.new_col_map, "axis", "allies");
}

function vo_unkown_car(var0) {
  level endon("wave_4_technicals");
  level endon("civ_car_escaped");
  var1 = level.civ_car scripts\engine\utility::waittill_any_return("death", "driver_death", "damage");

  if(var1 == "damage") {
    wait 0.4;

    if(isDefined(level.civ_car) && isalive(var0) && level.civ_car.health > 0) {
      level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_civcar_62");
    }
  }

  if(isDefined(level.civ_car) && isalive(var0) && level.civ_car.health > 0) {
    level.civ_car scripts\engine\utility::waittill_any_return("death", "driver_death");
  }

  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_civcar_61");
}

function driver_death_watcher() {
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
    return;
  }
}

function fake_headlights() {}

function sfx_unknown_car() {
  level.civ_car vehicle_turnengineoff();
  var0 = spawn("script_origin", level.civ_car.origin);
  var0 linkTo(level.civ_car);
  var0 playSound("scn_embassy_civ_car_unknown");
  level.civ_car scripts\engine\utility::waittill_any("death", "civ_car_gone", "damage");
  var0 scripts\engine\sp\utility::sound_fade_and_delete(0.1);
}

function sfx_technical_drive_in(var0, var1) {
  var0 vehicle_turnengineoff();
  var2 = spawn("script_origin", var0.origin);
  var2 linkTo(var0);
  var2 playSound(var1);
  var0 waittill("death");
  var2 scripts\engine\sp\utility::sound_fade_and_delete(0.1);
}

function vehicle_whizby_watcher(var0, var1) {
  self waittill("damage");
  self stopsounds();
  thread scripts\engine\utility::playsoundontag("scn_embassy_civ_car_bullet_impt", "tag_origin", 1);

  if(isalive(var0)) {
    if(isDefined(var1) && soundexists(var1)) {
      self playSound(var1);
    }

    self vehicle_setspeed(40, 5);
    return;
  }
}

function vehicle_death_watcher(var0) {
  level endon("civ_car_gone");
  self waittill("death");
  level.civ_car_death_spot = self.origin;
  scripts\engine\utility::flag_set("civ_car_death");

  if(isDefined(var0)) {
    var0 kill();
  }

  level notify("civ_car_gone");
}

function truck_street_death_watcher(var0) {
  level endon("wave_4_end");
  self waittill("death");
  level.truck_death_spot = self.origin;
}

function defend_wave_4_snipers_start() {
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
  level.support_mortar_tube.angles += (0, 120, 0);
}

function defend_wave_4_snipers_main() {
  thread scene_sniper_roof();
  var0 = [level.price, level.farah, level.alex, level.hadir];

  foreach(var2 in var0) {
    var2.fixednode = 0;
    var2 scripts\engine\sp\utility::clear_force_color();
    var2 scripts\engine\sp\utility::set_goal_radius(400);
    var2 setgoalpos((-276.5, 422.5, 152));
    var2.goalheight = 72;
  }

  level waittill("scene_sniper_roof");
  wait 2;
  var4 = scripts\engine\sp\utility::array_spawn_targetname("building_snipers", 1);

  foreach(var2 in var4) {
    var2.attackeraccuracy = 0.1;
    var2.ignoresuppression = 1;
    var2 scripts\engine\sp\utility::set_favoriteenemy(level.player);
  }

  thread dialogue_wave_4_snipers();
  thread friendly_flare_sender_loop("flare_north");
  enemy_alive_counter_gate(1);
  var2 = getaiarray("axis")[0];

  if(isalive(var2)) {
    enemy_move_to_exposed(var2);
  }

  enemy_alive_counter_gate(0);
}

function dialogue_wave_4_snipers() {
  level endon("wave_4_end");
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_greenbeam1_80");
  wait 2.5;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_sniper_10");
  wait 4;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_sniper_40");
}

function enemy_move_to_exposed(var0) {
  var0 endon("death");
  var1 = getnodearray("sniper_exposed_nodes", "targetname");

  foreach(var3 in var1) {
    if(!isalive(var0)) {
      break;
    }

    if(var3.origin[2] > var0.origin[2] + 30 || var3.origin[2] < var0.origin[2]) {
      var1 = scripts\engine\utility::array_remove(var1, var3);
    }
  }

  var5 = sortbydistance(var1, var0.origin)[0];
  var0 setgoalpos(var5.origin);
  var0 scripts\engine\sp\utility::set_goal_radius(32);
}

function player_looking_down_street_watcher() {
  var0 = 0.76604;
  var1 = gettime();
  var2 = 7000;
  var3 = spawnStruct();
  var3.origin = (4783, 775, 19);

  for(;;) {
    if(gettime() > var1 + var2 || level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var3.origin, var0)) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("street_guys_run");
}

function player_looking_away_from_mayhem_watcher() {
  var0 = 0.76604;
  var1 = gettime();
  var2 = 15000;
  var3 = spawnStruct();
  var3.origin = (4783, 775, 19);

  for(;;) {
    if(gettime() > var1 + var2 || level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var3.origin, var0)) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("hide_mayhem");
}

function spawn_street_guys() {
  var0 = scripts\engine\sp\utility::get_spawner_array("wave_4_street_guys", "script_noteworthy");

  for(var1 = 0; var1 < var0.size; var1++) {
    if(var1 > 4) {
      wait 1.5;
    }

    var0[var1] scripts\engine\sp\utility::spawn_ai(1);
  }
}

function remove_green_beam() {
  scripts\engine\utility::flag_wait("wave_4_end");
  wait 3;
  scripts\sp\equipment\green_beam::disable_green_beam();
  level scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_uavoperator_defend_greenbeam2_180");
  scripts\engine\utility::flag_set("wave_4_dialogue_complete");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_greenbeam2_190");
  level.hadir scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_had_defend_greenbeam2_200");
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_greenbeam2_210");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_greenbeam2_220");
}

function defend_wave_5_mortar_attack_start() {
  scripts\engine\utility::flag_set("wave_4_end");
  defend_inits();
  squad_init();
  scripts\engine\sp\utility::set_start_location("defend_wave_4_start", [level.price, level.farah, level.alex]);
  scripts\engine\sp\utility::set_start_location("defend_start", [level.hadir]);
  scripts\engine\sp\utility::set_start_location("defend_wave_5_start", [level.player]);
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("b");
  scripts\engine\sp\utility::activate_trigger("wave_4_streets_color_trigger", "targetname");
  thread scripts\sp\maps\embassy\embassy_lighting::mortar_building_attack_lighting();
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  thread palmtree_notify_delay();
}

function palmtree_notify_delay() {
  wait 1;
  level notify("emb_palm_02_damaged");
}

function defend_wave_5_mortar_attack_main() {
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

  if(!scripts\engine\utility::flag("mortar_house_early")) {
    wait 1;
  }

  scripts\engine\sp\utility::autosave_by_name("wave_5_begin");
  thread wave_5_enemy_mortar();
  level waittill("mortar_impact");
  thread scripts\sp\maps\embassy\embassy_util::spawn_marines_wave_5();

  if(!scripts\engine\utility::flag("mortar_house_early")) {
    wait 5;
  }

  scripts\engine\sp\utility::autosave_by_name("attack_house");
  scripts\engine\sp\utility::activate_trigger("wave_4_streets_color_trigger", "targetname");
  thread audio_defend_5_zone_state();
  var0 = getspawnerarray("wave_4_field_2");

  foreach(var2 in var0) {
    var2.count = 2;
  }

  var4 = scripts\engine\sp\utility::array_spawn_targetname("wave_4_field_2", 1);
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

function audio_defend_5_zone_state() {
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

function player_pushes_mortar_house_early() {
  level endon("mortar_impact");
  scripts\engine\sp\utility::trigger_wait("mortar_house_streets", "targetname");
  scripts\engine\utility::flag_set("mortar_house_early");
}

function price_mortar_run() {
  thread mortar_enemies_temp_disable_molotovs();
  thread price_mortar_run_triggers_on(1);
  level.price.ignoreall = 0;
  scripts\engine\sp\utility::activate_trigger("price_mortar_run_trigger_01", "targetname");
  thread price_mortar_run_field_path();
  thread push_up_mortar_house();
  thread enemies_goal_player();
  scripts\engine\sp\utility::trigger_wait("mortar_house_grounds_trigger", "targetname");
  var0 = getEnt("mortar_house_blue_gate_clip", "targetname");
  var0 disconnectPaths();
  scripts\engine\sp\utility::autosave_by_name("mortar_house_street_save");
  thread kill_tree_light();
  level.mortar_window_guy = scripts\engine\sp\utility::spawn_targetname("mortar_window_guy", 1);
  scripts\engine\utility::flag_wait("mortar_house_street_save");
  scripts\engine\sp\utility::autosave_by_name("mortar_house_street_save");
  scripts\engine\utility::flag_wait("street_enemies_clear");
}

function kill_tree_light() {
  var0 = getEnt("tree_fire_light", "targetname");
  var0 notify("stop_fire_flicker");
  wait 1;
  var0 setlightintensity(0);
}

function mortar_enemies_temp_disable_molotovs() {
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    var2.grenadeammo = 0;
  }

  scripts\engine\sp\utility::trigger_wait_targetname("mortar_house_streets");
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    var2.grenadeammo = 2;
  }
}

function enemies_goal_player() {
  scripts\engine\sp\utility::trigger_wait("mortar_house_streets", "targetname");
  scripts\engine\sp\utility::array_spawn_targetname("mortar_streets_backup", 1);
  var0 = getaiarray("axis");
  var0 = scripts\sp\maps\embassy\embassy_util::array_removedeaddyingorundefined(var0);

  foreach(var2 in var0) {
    if(scripts\engine\utility::is_equal(var2.targetname, "mortar_team_2") || scripts\engine\utility::is_equal(var2.targetname, "mortar_window_guy") || scripts\engine\utility::is_equal(var2.targetname, "mortar_roof_defender")) {
      var0 = scripts\engine\utility::array_remove(var0, var2);
      continue;
    }

    var2 scripts\engine\sp\utility::set_goal_radius(1000);
    var2 setgoalpos(var2.origin);
    var2 setgoalentity(level.player);
  }

  while(var0.size > 0) {
    var0 = scripts\sp\maps\embassy\embassy_util::array_removedeaddyingorundefined(var0);
    wait 0.1;
  }

  scripts\engine\utility::flag_set("street_enemies_clear");
}

function push_up_mortar_house() {
  var0 = getEnt("price_mortar_run_trigger_02", "targetname");
  var0 endon("trigger");
  wait 15;
  scripts\engine\sp\utility::activate_trigger("price_mortar_run_trigger_02", "targetname");
}

function price_mortar_run_field_path() {
  level endon("mortar_house_perimeter");
  scripts\engine\sp\utility::trigger_wait("price_mortar_run_trigger_02_alt", "targetname");
  scripts\engine\utility::flag_set("mortar_house_field_path");
  var0 = getaiarray("axis");
  var1 = getEnt("exterior_north_vol_3", "targetname");

  foreach(var3 in var0) {
    if(scripts\engine\utility::is_equal(var3.targetname, "mortar_team_2")) {
      continue;
    }

    var3 setgoalpos(var3.origin);
    var3 setgoalvolumeauto(var1);
  }

  level.front_goal_vol = var1;
}

function defend_wave_5_mortar_attack_catchup() {
  scripts\engine\utility::flag_set("mortar_team_objective");
}

function defend_wave_5_mortar_house_boost_start() {
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

function defend_wave_5_mortar_house_boost_main() {
  thread mortar_house_boost_vo();
  wait 0.5;
  level.mortar_house_guys = scripts\engine\sp\utility::array_spawn_targetname("mortar_house_guys", 1);

  foreach(var1 in level.mortar_house_guys) {
    var1 setthreatbiasgroup("mortar_house_guys");
  }

  var3 = getaiarray("allies");
  var3 = scripts\engine\utility::array_remove(var3, level.hadir);

  foreach(var1 in var3) {
    var1 setthreatbiasgroup("ignore_mortar_house_guys");
  }

  thread scripts\engine\sp\utility::ignoreeachother("ignore_mortar_house_guys", "mortar_house_guys");
  scripts\engine\sp\utility::autosave_by_name("mortar_house_approach");
  level waittill("boost_complete");
}

function defend_wave_5_mortar_house_boost_catchup() {
  thread mortar_building_doors();
}

function defend_wave_5_mortar_house_start() {
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

function defend_wave_5_mortar_house_main() {
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
    var0 = getspawner("mortar_window_guy", "targetname");
    var0.count = 1;
    level.mortar_window_guy = scripts\engine\sp\utility::spawn_targetname("mortar_window_guy", 1);
  }

  thread hallway_exploder_lookat();
  scripts\engine\sp\utility::trigger_wait("price_mortar_run_trigger_07", "targetname");
  scripts\engine\utility::flag_set("mortar_guy_breakout_watcher");
  thread player_leaves_house_early();
  var1 = getaiarray("axis");

  foreach(var3 in var1) {
    if(scripts\engine\utility::is_equal(var3.script_noteworthy, "mortar_team") || scripts\engine\utility::is_equal(var3.targetname, "mortar_house_guys") || scripts\engine\utility::is_equal(var3.targetname, "mortar_window_guy")) {
      var1 = scripts\engine\utility::array_remove(var1, var3);
    }
  }

  scripts\engine\utility::array_call(var1, &delete);

  if(!scripts\engine\utility::flag("enemy_mortar_manned")) {
    thread wave_5_enemy_mortar_replacement();
    scripts\engine\utility::flag_waitopen("enemy_mortar_manned");
  }

  enemy_alive_counter_gate(0);
  scripts\engine\utility::flag_set("wave_5_house_end");
  var5 = getEnt("mortar_roof_clip", "targetname");
  var5 connectpaths();
  var5 notsolid();
  scripts\engine\sp\utility::activate_trigger("price_mortar_run_trigger_08", "targetname");
  scripts\engine\sp\utility::autosave_by_name("mortar_house_cleared");
}

function player_leaves_house_early() {
  level endon("wave_5_house_end");
  var0 = getEnt("compound_technicals_go", "targetname");

  while(!level.player istouching(var0)) {
    waitframe();
  }

  if(!scripts\engine\utility::flag("wave_5_house_end")) {
    var1 = getaiarray("axis");
    scripts\engine\sp\utility::array_kill(var1);
    return;
  }
}

function defend_mortar_house_favela() {
  var0 = scripts\engine\utility::getStruct("mortar_house_favela_struct", "targetname");
  var0.origin += anglestoright(var0.angles) * 2;
  var1 = getEnt("favela_door", "targetname");
  var1.clip = var1 scripts\engine\utility::get_target_ent();
  var1.clip linkTo(var1);
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  level.favela_door = var1;
  var1.animname = "favela_door";
  var1 scripts\engine\sp\utility::assign_animtree();
  var2 = undefined;
  var3 = getEntArray("mortar_house_guys", "targetname");

  foreach(var5 in var3) {
    if(scripts\engine\utility::is_equal(var5.script_noteworthy, "favela")) {
      var2 = var5;
    }
  }

  var2.animname = "generic";
  var2.forceragdollimmediate = 1;
  var2.allowdeath = 1;
  var2 endon("death");
  var1 scripts\common\anim::anim_first_frame_solo(var2, "faveladoor_peak");
  favela_door_open(var1, var2);
  var1.clip connectpaths();
}

function favela_door_open(var0, var1) {
  var1 endon("death");
  var1 endon("breakout");
  var2 = var0 scripts\engine\utility::getanim("faveladoor_peak");
  var3 = getanimlength(var2);
  var1.target = undefined;
  var4 = spawnStruct();
  var4.origin = (2762, 2168, 169);
  var4.angles = (0, 180, 0);
  var1 scripts\engine\sp\utility::set_goal_radius(10);
  var1 scripts\sp\utility::context_melee_allow(0);
  level scripts\engine\utility::waittill_any("hallway_lookat", "mortar_guy_breakout_watcher");
  var0 thread scripts\common\anim::anim_single_solo(var0, "faveladoor_peak");
  thread favela_door_guy_anims(var1, var0, var3);
  var5 = scripts\engine\utility::getStruct("favela_grenade_struct", "targetname");
  var6 = var5.origin;
  var7 = var5.origin + (0, 0, 10) + anglesToForward(var5.angles) * 220;
  thread magic_grenade_toss(var1, 1, var6, var7, 3);
  thread favela_door_distance_check();
  thread favela_door_fastopen(var0, var3);
  wait var3;

  if(isalive(var1) && !istrue(self.fast_open)) {
    var1 scripts\engine\utility::waittill_any_timeout(2, "death");
  }

  var1 stopanimScripted();
  var1 setgoalpos(var1.origin);
  var0 notify("stop_loop");
  var1 notify("stop_loop");
  var8 = 175;
  var9 = distance2d(var1.origin, level.player.origin);

  if(var8 < var9) {
    var4 thread scripts\common\anim::anim_first_frame_solo(var1, "faveladoor_fastopen");
    var4 thread scripts\common\anim::anim_single_solo(var1, "faveladoor_fastopen");
    waitframe();
    var1 setanimtime(var1 scripts\engine\utility::getanim("faveladoor_fastopen"), 0.5);
    var1 waittillmatch("single anim", "end");
  }

  var1 stopanimScripted();
  var1 setgoalpos(var1.origin);
}

function favela_door_distance_check() {
  self endon("death");
  self.fast_open = 0;
  var0 = 200;

  for(;;) {
    if(var0 > distance2d(self.origin, level.player.origin)) {
      break;
    }

    waitframe();
  }

  self.fast_open = 1;
  waitframe();
  self notify("fast_open");
}

function favela_door_fastopen(var0, var1) {
  var2 = self;
  var1 scripts\engine\utility::waittill_any_timeout(var0, "death", "fast_open");

  if(isalive(var1) && !istrue(self.fast_open)) {
    var1 scripts\engine\utility::waittill_any_timeout(2, "death");
  }

  var2 notify("stop_loop");
  var2 thread scripts\common\anim::anim_single_solo(var2, "faveladoor_fastopen");
  var2 playSound("scrpt_door_wood_heavy_bash_npc");
}

function magic_grenade_toss(var0, var1, var2, var3, var4) {
  self endon("death");

  if(!isDefined(var4)) {
    var4 = "frag";
  }

  wait var0;
  var5 = magicgrenade(var4, var1, var2, var3);

  if(!isDefined(var5)) {
    return;
  }

  self.threw_grenade = 1;
  var5 endon("entitydeleted");

  if(var4 == "molotov") {
    level notify("molotov_fired");
  }

  if(var4 == "semtex") {
    thread scripts\sp\equipment\semtex::semtexfiremain(var5, var3);
  }

  if(var4 == "molotov") {
    thread scripts\sp\equipment\molotov::molotovfiremain(var5);
  }

  if(isDefined(var3)) {
    thread beacon_fuse(var5);
    return;
  }
}

function beacon_fuse(var0) {
  waitframe();
  self setscriptablepartstate("state", "beacon", 1);
  self setscriptablepartstate("state", "beacon_ai", 0);
  wait var0;

  if(isDefined(self)) {
    self setscriptablepartstate("state", "destroy", 1);
    return;
  }
}

function favela_door_guy_anims(var0, var1, var2) {
  self endon("death");
  var0 scripts\common\anim::anim_single_solo(self, var2);
}

function field_ent_cleanup(var0) {
  var1 = getEnt("field_cleanup_vol", "targetname");

  if(isDefined(var0)) {
    wait var0;
  }

  var2 = scripts\engine\sp\utility::getvehiclearray();
  scripts\engine\utility::array_delete(var2);
  waitframe();
  var3 = getEntArray("script_vehicle", "code_classname");
  var4 = getEntArray("script_vehicle_corpse", "code_classname");
  var5 = scripts\engine\utility::array_combine(var3, var4);
  scripts\engine\utility::array_thread(var5, &field_ent_cleanup_logic, var1);
}

function field_weapon_cleanup() {
  var0 = getEnt("field_cleanup_vol", "targetname");
  var1 = getweaponarray();

  foreach(var3 in var1) {
    if(var3 istouching(var0)) {
      var3 delete();
    }
  }
}

function field_ent_cleanup_logic(var0) {
  if(!isDefined(self.model)) {
    return;
  }

  if(self istouching(var0)) {
    self notify("fire_extinguish");
    self notify("stop_all_death_fx");
    waitframe();

    if(isDefined(self)) {
      if(isDefined(self.new_col_map)) {
        self.new_col_map hide();
      }

      self hide();
      return;
    }

    return;
  }
}

function mortar_house_boost_vo() {
  level.player endon("death");
  wait 0.5;
  var0 = ["dx_vom_had_defend_mortar_building_182", "dx_vom_had_defend_mortar_building_184", "dx_vom_had_defend_mortar_building_186", "dx_vom_had_defend_mortar_building_188"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);
  var1.autoshuffle = 1;
  level.hadir scripts\sp\maps\embassy\embassy_util::nagtill("house_gate_interacted", var1, 8);
  level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_defend_mortar_building_190");
  var0 = ["dx_vom_had_defend_mortar_building_192", "dx_vom_had_defend_mortar_building_194", "dx_vom_had_defend_mortar_building_196", "dx_vom_had_defend_mortar_building_198"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);
  var1.autoshuffle = 1;
  level.hadir scripts\sp\maps\embassy\embassy_util::nagtill("boost_started", var1, 6);
  wait 9;
  level.hadir scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_had_defend_mortar_building_200");
  wait 5;
  var0 = ["dx_vom_had_defend_mortar_building_202", "dx_vom_had_defend_mortar_building_204", "dx_vom_had_defend_mortar_building_206"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);
  var1.autoshuffle = 1;
  level.hadir scripts\sp\maps\embassy\embassy_util::nagtill("mortar_house_enter_save", var1);
}

function mortar_house_boost() {
  wait 0.1;
  var0 = spawnStruct();
  var0.origin = (2385, 1624, 24.803);
  var0.angles = (0, 0, 0);
  var1 = spawnStruct();
  var1.origin = (2345, 1624, 24.803);
  var1.angles = (0, 0, 0);
  var2 = getspawner("boost_aq_spawner", "targetname");
  var3 = spawnStruct();
  var3.origin = var2.origin + (0, 0, 50);
  var3.angles = (0, 270, 0);
  var4 = getEnt("mortar_door_right", "targetname");
  scripts\engine\utility::flag_wait("hadir_go_to_wall");
  scripts\engine\utility::flag_set("house_gate_interacted");
  scripts\engine\utility::flag_wait("street_enemies_clear");
  level.hadir.support_equipment_og = level.hadir.support_equipment;
  level.hadir.support_equipment = 0;
  level.hadir notify("remove_equipment");
  level.player.rig hide();
  var1 scripts\common\anim::anim_first_frame_solo(level.player.rig, "mortar_boost");
  var5 = 0;

  if(isDefined(level.truck_death_spot)) {
    if(level.truck_death_spot[0] > 2040 && level.truck_death_spot[0] < 20400) {
      var5 = 1;
    }
  }

  if(!var5) {
    var1 scripts\sp\anim::anim_reach_solo(level.hadir, "mortar_boost_enter");
  }

  var1 scripts\common\anim::anim_single_solo(level.hadir, "mortar_boost_enter");
  var1 thread scripts\common\anim::anim_loop_solo(level.hadir, "mortar_boost_idle", "stop_loop");
  thread hadir_boost_nag(var1);
  level.hadir scripts\sp\player\cursor_hint::create_cursor_hint("tag_accessory_left", undefined, &"EMBASSY/BOOST", 90, 500, 75, 0, 0, 0, undefined, "duration_none");
  level.hadir waittill("trigger");
  var2 = scripts\engine\sp\utility::bodyonlyspawn(var2);
  var2.animname = "aq_1";
  var2 notsolid();
  var1 notify("stop_loop");
  level.hadir scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::flag_set("boost_started");
  thread scripts\sp\maps\embassy\embassy_lighting::boost_moment_dof();
  var1 thread scripts\sp\anim::anim_reach_solo(level.hadir, "mortar_boost");
  scripts\sp\maps\embassy\embassy_util::put_player_into_rig(level.player.rig, 0.75, 0, 0, 0, 0);
  var1 thread scripts\common\anim::anim_single([level.hadir, level.player.rig], "mortar_boost");
  thread mortar_building_doors();
  thread mortar_door_magic_bullet(var3);
  var0 scripts\engine\utility::delaythread(7.9, &scripts\common\anim::anim_single, [var2], "mortar_boost");
  level.player.rig waittillmatch("single anim", "end");
  scripts\sp\maps\embassy\embassy_util::pull_player_out_of_rig_hide_rig(level.player.rig);
  level.hadir stopanimScripted();
  level.hadir clearpath();
  var6 = getnode("hadir_post_boost_node", "targetname");
  level.hadir forceteleport(var6.origin);
  level.hadir scripts\engine\sp\utility::set_goal_radius(16);
  level.hadir setgoalpos(var6.origin);
  can_see_hadir_watcher();
  level.hadir scripts\engine\utility::set_movement_speed(240);
  level notify("boost_complete");
}

function mortar_house_boost_interact_door() {
  var0 = getEntArray("mortar_door_left", "targetname");
  var1 = undefined;

  foreach(var3 in var0) {
    if(scripts\engine\utility::is_equal(var3.script_noteworthy, "interactive_door")) {
      level.boost_door = var3;
    }
  }

  level.boost_door waittill("trigger");
  scripts\engine\utility::flag_set("hadir_go_to_wall");
}

function hadir_boost_nag(var0) {
  level.hadir endon("trigger");

  for(;;) {
    wait 10;
    var0 notify("stop_loop");
    var0 scripts\common\anim::anim_single_solo(level.hadir, "mortar_boost_nag");
    var0 thread scripts\common\anim::anim_loop_solo(level.hadir, "mortar_boost_idle", "stop_loop");
  }
}

function can_see_hadir_watcher() {
  level endon("boost_complete");

  for(;;) {
    var0 = level.player getEye();
    var1 = level.hadir.origin + (0, 0, 30);
    var2 = sighttracepassed(var0, var1, 0, level.player, 1);

    if(var2) {
      break;
    }

    waitframe();
  }
}

function mortar_door_magic_bullet(var0) {
  wait 7;
  var1 = var0.origin + anglesToForward(var0.angles) * 50;
  var2 = "iw8_ar_akilo47";

  for(var3 = 0; var3 < 5; var3++) {
    magicbullet(var2, var0.origin, var1 + (0, 1.5 * var3, 2 * var3));
    wait 0.15;
  }
}

function mortar_building_doors(var0, var1) {
  var0 = getEntArray("mortar_door_left", "targetname");
  var2 = undefined;

  foreach(var4 in var0) {
    if(scripts\engine\utility::is_equal(var4.script_noteworthy, "interactive_door")) {
      level.boost_door = var4;
    }
  }

  var1 = getEnt("mortar_door_right", "targetname");
  var1.clip = var1 scripts\engine\utility::get_target_ent();
  var1.clip linkTo(var1);
  var2 = scripts\sp\door::get_interactive_door("mortar_door_left");
  var2.open_left = 0;
  var1 scripts\engine\utility::delaycall(7.7, &rotateyaw, 110, 0.5);
  wait 7.7;
  var2 thread scripts\sp\door::remove_open_ability();
  var2 thread scripts\sp\door::door_open_completely();
  var1.clip connectpaths();

  if(isDefined(var2.navobstacle)) {
    destroynavobstacle(self.navobstacle);
  }

  var2.clip connectpaths();
}

function mortar_house_vo() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("mortar_house_perimeter");
  wait 0.5;
  level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_defend_mortar_interior_10");
  wait 0.4;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_mortar_interior_20");
  var0 = getEntArray("mortar_house_guys", "targetname");
  wait_floor_clear(var0);
  wait 0.3;
  scripts\sp\maps\embassy\embassy_util::wait_combat_cooldown(0.8, 4);
  var1 = ["dx_vom_had_defend_mortar_interior_40", "dx_vom_had_defend_mortar_interior_50", "dx_vom_had_defend_mortar_interior_60", "dx_vom_had_defend_mortar_interior_70"];
  var2 = scripts\engine\sp\utility::create_deck(var1, 0);
  var2.autoshuffle = 1;
  var3 = getEnt("price_mortar_run_trigger_06", "targetname");
  level.hadir thread scripts\sp\maps\embassy\embassy_util::nagtill("player_at_stairs", var2, 12);
  var3 waittill("trigger");
  scripts\engine\utility::trigger_off("price_mortar_run_trigger_05", "targetname");
  scripts\engine\utility::trigger_off("price_mortar_run_trigger_04", "targetname");
  level notify("player_at_stairs");
}

function wait_floor_clear(var0, var1) {
  if(!isDefined(var0)) {
    var0 = getaiarray("axis");
  }

  var1 = scripts\sp\maps\embassy\embassy_util::default_if_undefined(var1, 0);
  var2 = 0;

  foreach(var4 in var0) {
    if(!isalive(var4)) {
      continue;
    }

    if(abs(level.player.origin[2] - var4.origin[2]) < 40) {
      var2++;
    }
  }

  while(var2 > var1) {
    level waittill("ai_killed");
    var2 = 0;

    foreach(var4 in var0) {
      if(!isalive(var4)) {
        continue;
      }

      if(abs(level.player.origin[2] - var4.origin[2]) < 40) {
        var2++;
      }
    }
  }
}

function mortar_house_fridge() {
  var0 = spawnStruct();
  var0.origin = (2686, 2115, 33);
  var0.angles = (0, 0, 0);
  var1 = getspawner("boost_aq_spawner", "targetname");
  var1.count = 1;
  var1 = scripts\engine\sp\utility::bodyonlyspawn(var1);
  var1.animname = "aq_1";
  var1 scripts\common\ai::gun_remove();
  var1 notsolid();
  var0 thread scripts\common\anim::anim_first_frame_solo(var1, "fridge_takedown");
  var2 = [];
  var3 = getEnt("mortar_fridge_broom", "targetname");
  var3 scripts\engine\sp\utility::assign_animtree("fridge_broom");
  var3.animname = "fridge_broom";
  var2 = var3;
  var4 = getEnt("mortar_fridge_bottom", "targetname");
  var4 scripts\engine\sp\utility::assign_animtree("fridge_bottom");
  var4.animname = "fridge_bottom";
  var2 = var4;
  var5 = getEnt("mortar_fridge_top", "targetname");
  var5 scripts\engine\sp\utility::assign_animtree("fridge_top");
  var5.animname = "fridge_top";
  var2 = var5;
  var6 = getEnt("mortar_fridge_body", "targetname");
  var6 scripts\engine\sp\utility::assign_animtree("fridge_body");
  var6.animname = "fridge_body";
  var2 = var6;
  var7 = getEnt("mortar_fridge_entrance_door", "targetname");
  var7.clip = var7 scripts\engine\utility::get_target_ent();
  var7.clip linkTo(var7);
  var7 scripts\engine\sp\utility::assign_animtree("fridge_door");
  var7.animname = "fridge_door";
  var2 = var7;
  var0 thread scripts\common\anim::anim_first_frame(var2, "fridge_takedown");
  level.hadir scripts\engine\sp\utility::set_goal_radius(16);
  level.hadir.ignoreme = 1;
  var0 scripts\sp\anim::anim_reach_solo(level.hadir, "fridge_takedown_enter");
  var0 scripts\common\anim::anim_single_solo(level.hadir, "fridge_takedown_enter");
  scripts\engine\sp\utility::autosave_by_name("fridge_takedown");

  if(!scripts\engine\utility::flag("mortar_house_enter_save")) {
    var0 thread scripts\common\anim::anim_loop_solo(level.hadir, "fridge_takedown_enter_idle", "stop_loop");
    scripts\engine\utility::flag_wait("mortar_house_enter_save");
    var0 notify("stop_loop");
  }

  visionsetnaked("", 1);
  var7.clip connectpaths();
  var0 thread scripts\common\anim::anim_single([level.hadir, var1], "fridge_takedown");
  var0 thread scripts\common\anim::anim_single(var2, "fridge_takedown");
  thread mortar_house_kitchen_lookat();
  thread scripts\engine\utility::flag_set_delayed("house_enter_low_delay", 5);
  wait getanimlength(level.hadir scripts\engine\utility::getanim("fridge_takedown")) - 1.5;
  level.hadir scripts\engine\sp\utility::set_goal_radius(10);
  level.hadir setgoalpos(level.hadir.origin);
  level.hadir.ignoreme = 0;
  level.hadir thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_had_defend_mortar_interior_30");
  scripts\engine\sp\utility::trigger_wait_targetname("price_mortar_run_trigger_05");
  level.hadir.support_equipment = level.hadir.support_equipment_og;
  level.hadir scripts\engine\sp\utility::set_force_color("p");
}

function mortar_house_kitchen_lookat() {
  var0 = spawnStruct();
  var0.origin = (2706, 2328, 100);
  var1 = 0.64;
  var2 = gettime();
  var3 = 4000;

  while(!scripts\engine\utility::flag("house_enter_low_delay")) {
    var4 = level.player getEye();
    var5 = var0.origin;
    var6 = sighttracepassed(var4, var5, 0, level.player, 1);

    if(var6 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin, var1)) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("house_enter_low_delay");
}

function hallway_exploder_lookat() {
  var0 = scripts\engine\utility::getStruct("mortar_house_lookat_struct", "targetname");
  var0.origin += (0, 100, 0);
  var1 = 0.984808;
  var2 = gettime();
  var3 = 10000;

  for(;;) {
    var4 = level.player getEye();
    var5 = var0.origin;
    var6 = sighttracepassed(var4, var5, 0, level.player, 1);

    if(var6 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin, var1)) {
      break;
    }

    wait 0.1;
  }

  level notify("hallway_lookat");
  scripts\engine\utility::exploder("window_exp");
  wait 0.1;
  scripts\engine\utility::stop_exploder("mortar2_tree");
}

function doorbust_guy_becomes_ai_if_alive() {
  self waittillmatch("single anim", "end");
  self setgoalpos(self.origin);
  self.goalradius = 20;
}

function defend_wave_5_mortar_house_catchup() {
  scripts\engine\utility::flag_set("wave_5_house_end");
}

function defend_wave_6_start() {
  defend_inits();
  squad_init();
  scripts\engine\utility::flag_set("wave_5_house_end");
  scripts\engine\sp\utility::set_start_location("defend_wave_6_house_end", [level.player, level.hadir]);
  scripts\engine\sp\utility::set_start_location("defend_wave_4_start", [level.farah, level.alex, level.price]);
  var0 = getEnt("mortar_roof_clip", "targetname");
  var0 connectpaths();
  var0 notsolid();
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("b");
  thread kill_tree_light();
}

function defend_wave_6_main() {
  setsaveddvar("NQNQPRLRQM", 0.2);
  level.farah scripts\engine\sp\utility::clear_force_color();
  level.farah scripts\engine\sp\utility::set_force_color("b");
  thread compound_technicals();
  var0 = getEnt("residence_wall_gate", "targetname");
  var0.clip = var0 scripts\engine\utility::get_target_ent();
  var0.clip linkTo(var0);
  var0 rotateYaw(-80, 1);
  var0.clip connectpaths();
  scripts\engine\utility::flag_wait("wave_5_house_end");
  scripts\engine\utility::flag_set("residence_destroyed");
  var1 = getEntArray("damaged_light", "targetname");

  foreach(var3 in var1) {
    var3 setlightintensity(0);
  }

  thread dialogue_rooftops_wave_6();
  thread price_mortar_run_triggers_on(0);
  thread price_compound_run_triggers_on(1);
  thread residence_bodies();
  scripts\engine\utility::delaythread(2, &price_mortar_roof_exit);
  scripts\engine\utility::delaythread(2, &scripts\engine\sp\utility::activate_trigger, "wave_6_color_trigger", "targetname");
  thread price_and_player_ignored();
  var5 = getaiarray("allies");

  foreach(var7 in var5) {
    var7 setthreatbiasgroup("allies");
  }

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
  var9 = scripts\engine\sp\utility::spawn_targetname("wave_6_residence_defenders_roof", 1);

  if(isDefined(var9)) {
    var9 thread scripts\engine\sp\utility::set_favoriteenemy(level.farah);
  }

  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_13");
  var10 = getEntArray("damaged_residence", "targetname");
  scripts\engine\utility::array_call(var10, &show);
  var11 = getEntArray("pristine_residence", "targetname");
  scripts\engine\utility::array_call(var11, &hide);
  thread car_bomb_event();
  level notify("car_bomb_zone_state");
}

function sfx_misc_field_expl() {
  wait 10;
  var0 = spawn("script_origin", (-580, -32, 15));
  var0 playexplosionsound("scn_embassy_field_mortar_01", "exp");
  wait 0.6;
  var1 = spawn("script_origin", (-732, -540, 15));
  var1 playexplosionsound("scn_embassy_field_mortar_02", "exp");
}

function audio_defend_6_zone_state() {
  setaudiotriggerstate("combat_zone", "combat_lvl1", 2);
  setaudiotriggerstate("default", "combat_lvl1", 2);
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_12");
  setaudiotriggerstate("combat_zone", "combat_lvl2", 5);
  setaudiotriggerstate("default", "combat_lvl2", 5);
  level waittill("car_bomb_zone_state");
  setaudiotriggerstate("combat_zone", "combat_lvl1", 2);
  setaudiotriggerstate("default", "combat_lvl1", 2);
}

function compound_technicals() {
  scripts\engine\sp\utility::trigger_wait_targetname("compound_technicals_go");
  thread scripts\sp\maps\embassy\embassy_lighting::compound_return_lighting(3);
  scripts\engine\utility::flag_set("player_leaving_mortar_house");
  scripts\engine\sp\utility::activate_trigger("price_compound_run_trigger_09", "targetname");
  scripts\engine\utility::stop_exploder("mortar4");
  scripts\engine\utility::delaythread(0.7, &wave_6_technical_08);
  scripts\engine\utility::delaythread(0.7, &wave_6_technical_04);
  scripts\engine\utility::delaythread(4, &wave_6_technical_07);
  scripts\engine\utility::delaythread(3.5, &wave_6_technical_05);
  scripts\engine\utility::delaythread(5, &wave_6_technical_06);
  scripts\engine\sp\utility::autosave_by_name("wave_6_begin");
}

function return_to_compound_objective() {}

function price_mortar_roof_exit() {
  var0 = scripts\engine\utility::getStruct("price_roof_exit_struct", "targetname");
  var0.angles = (0, 0, 0);
  var0 scripts\sp\anim::anim_reach_solo(level.hadir, "mortar_house_exit");
  var0 scripts\common\anim::anim_single_solo(level.hadir, "mortar_house_exit");
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("p");
}

function suicide_bomber() {
  setmusicstate("mx_embassy_palace");
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_14");
  level notify("spawned_suicide_bomber");
  var0 = scripts\engine\sp\utility::spawn_targetname("suicide_bomber", 1);

  if(isDefined(var0)) {
    var0.attackeraccuracy = 0;
    var0 detach(var0.headmodel);
    var0.headmodel = "head_sc_m_alameer_civ_bg_nohair";
    var0 attach(var0.headmodel);
    var0 setModel("body_al_qatala_urban_civ_3_1");
    var0.jetpackmodel = "al_qatala_urban_civ_bomb_vest";
    var0 attach(var0.jetpackmodel);
    return;
  }
}

function car_bomb_event() {
  var0 = scripts\engine\utility::getStruct("residence_explosion_struct", "targetname");
  var1 = 0.984808;
  var2 = gettime() + 8000;

  for(;;) {
    if(scripts\engine\utility::flag("wolf_escapes") || gettime() > var2 || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin, var1)) {
      break;
    }

    wait 0.1;
  }

  var3 = spawnStruct();
  var3.origin = (-2377, -1039, 20);
  magicgrenademanual("mortar", var3.origin, (0, 0, 0), 0.05);
  scripts\engine\utility::exploder("car_bomb");
  thread sfx_car_bomb_expl(var3.origin);
  earthquake(0.2, 1.5, level.player.origin, 400);
  playrumbleonposition("damage_heavy", level.player.origin);
  magicgrenademanual("mortar", var3.origin, (0, 0, 0), 0.05);
}

function sfx_car_bomb_expl(var0) {
  var1 = spawn("script_origin", var0);
  var1 playexplosionsound("scn_embassy_car_bomb_expl", "exp");
  wait 6;
  var1 delete();
}

function palm_tree_swap() {
  wait 0.2;
  scripts\engine\utility::flag_wait("wave_5_house_end");
  scripts\engine\utility::stop_exploder("mortar6_tree");
  var0 = getscriptablearray("emb_palm_01", "targetname")[0];
  var0 setscriptablepartstate("base", "show_damaged");
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_12");
  wait 1;
  var1 = getEnt("emb_palm_01_clip_fallen", "targetname");
  var1 show();
  var1 disconnectPaths();
  scripts\engine\utility::trigger_on("emb_palm_01_trigger", "targetname");
  scripts\engine\utility::exploder("dead_palm");
  var0 thread scripts\engine\sp\utility::play_sound_on_tag("scr_emb_palm_burning_fall", "palm_tree_B001_clone_surfatt_001");
  scripts\engine\utility::delaythread(4.5, &scripts\engine\utility::play_loopsound_in_space, "scr_emb_palm_fire_big_lp", (-433, -73, 76));
  var0 setscriptablepartstate("base", "show_death");
}

function palm_tree_swap_02() {
  wait 0.2;
  level waittill("emb_palm_02_damaged");
  var0 = getscriptablearray("emb_palm_02", "targetname")[0];
  var0 setscriptablepartstate("base", "show_damaged");
  var1 = getEnt("price_mortar_run_trigger_02", "targetname");
  var2 = getEnt("price_mortar_run_trigger_02_alt", "targetname");
  var3 = scripts\engine\utility::getStruct("emb_palm_02_fall_struct", "targetname");
  scripts\engine\utility::flag_wait("wave_4_end");
  scripts\engine\sp\utility::trigger_wait_targetname("player_warn_trigger");

  if(var3.radius + 150 > distance2d(level.civ_car_death_spot, var3.origin)) {
    return;
  }

  var4 = getEnt("emb_palm_02_trigger", "targetname");
  var5 = createnavbadplacebyent(var4, "axis", "allies");
  var0 thread scripts\engine\sp\utility::play_sound_on_tag("scr_emb_palm_burning_fall", "palm_tree_B001_clone_surfatt_001");
  scripts\engine\utility::delaythread(4.5, &scripts\engine\utility::play_loopsound_in_space, "scr_emb_palm_fire_big_lp", (1119, 1114, 105));
  var6 = getEnt("emb_palm_02_clip_fallen", "targetname");
  var6 show();
  var6 disconnectPaths();
  var0 setscriptablepartstate("base", "show_death");
  scripts\engine\utility::trigger_on("emb_palm_02_trigger", "targetname");
}

function price_and_player_ignored() {
  level.player.ignoreme = 1;
  level.hadir.ignoreme = 1;
  level.hadir.ignoreall = 1;
  level waittill("stop_ignoring_player");
  level.player.ignoreme = 0;
  level.hadir.ignoreme = 0;
  level.hadir.ignoreall = 0;
}

function save_on_return_to_compound() {
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_10");
  scripts\engine\sp\utility::autosave_by_name("compound_assault");
  scripts\engine\sp\utility::trigger_wait_targetname("compound_return_auto_save");
  scripts\engine\sp\utility::autosave_by_name("compound_return_auto_save");
}

function defend_wave_6_catchup() {
  scripts\engine\utility::flag_set("residence_return");
  scripts\engine\utility::flag_set("residence_destroyed");
  thread residence_bodies();
  var0 = getEntArray("damaged_light", "targetname");

  foreach(var2 in var0) {
    var3 = var2 getlightintensity();
    var2 setlightintensity(var3 / 1.1);
  }
}

function defend_wolf_escapes_start() {
  defend_inits();
  squad_init();
  var0 = getEnt("mortar_anim_truck_01", "targetname");
  var0 scripts\engine\sp\utility::assign_animtree("truck_01");
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("p");
  scripts\engine\utility::flag_set("wave_5_house_end");
  scripts\engine\sp\utility::set_start_location("wolf_escapes_start", [level.player, level.price, level.farah, level.alex]);
  scripts\engine\sp\utility::set_start_location("roof_approach_start", [level.hadir]);
  var1 = spawnStruct();
  var1.origin = (-418, -110, 76);
  price_compound_run_triggers_on(1);
  scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::activate_trigger, "price_compound_run_trigger_15", "targetname");
  scripts\engine\sp\utility::activate_trigger("price_compound_run_trigger_14", "targetname");
}

function defend_wolf_escapes_main() {
  thread suicide_bomber();
  scripts\engine\sp\utility::trigger_wait("price_compound_run_trigger_14", "targetname");
  setaudiotriggerstate("combat_zone", "", 2);
  setaudiotriggerstate("default", "", 2);
  var0 = getEnt("res_secure_door", "targetname");
  var0 scripts\engine\sp\utility::assign_animtree("residence_saferoom_door");
  var0 scripts\common\anim::anim_first_frame_solo(var0, "wolf_escapes");
  thread ai_push_residence();
  thread defend_wolf_hostage();
  scripts\engine\utility::flag_wait("wolf_escapes");
  visionsetnaked("", 1);
  scripts\engine\sp\utility::autosave_by_name("stacy_hostage");
  var1 = scripts\engine\utility::getStruct("residence_end_struct", "targetname");
  var1 = scripts\engine\utility::spawn_tag_origin(var1.origin, var1.angles);
  var1 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (3, 0, -5), &"EMBASSY/OPEN", 90, 500, 50, 0);
  var2 = scripts\engine\utility::getStruct("residence_end_anim_struct", "targetname");
  var2.origin += (-5, 2, 0);
  var0 = getEnt("res_secure_door", "targetname");
  var0 scripts\engine\sp\utility::assign_animtree("residence_saferoom_door");
  var2 thread scripts\common\anim::anim_first_frame_solo(var0, "wolf_escapes");
  var1 waittill("trigger");
  thread ending_scene_mayhem_anims();
  thread kill_player_if_hostage_taker_still_alive();
  var3 = getaiarray("axis");
  scripts\engine\utility::array_delete(var3);
  level.hadir.support_equipment = 0;
  level.farah.support_equipment = 0;
  level.hadir notify("remove_equipment");
  thread skippable_ending();
  scripts\engine\utility::flag_set("escape_lights");
  var4 = getspawner("kyle", "script_noteworthy");
  var4.count = 1;
  level.kyle = scripts\engine\sp\utility::spawn_targetname("kyle", 1);
  level.kyle.animname = "kyle";
  level.player.fake_weapon = level.player getcurrentweapon();
  var5 = weaponclass(level.player.fake_weapon);

  if(var5 != "rifle" && var5 != "smg") {
    level.player.fake_weapon = scripts\sp\utility::make_weapon("iw8_ar_mike4");
  }

  level.kyle scripts\anim\shared::forceuseweapon(level.player.fake_weapon, "primary");
  level.kyle hide();
  thread wolf_escapes_fx();
  defend_wolf_escapes_ending();
}

function defend_wolf_escapes_scene_start() {
  defend_inits();
  squad_init();
  var0 = getEnt("mortar_anim_truck_01", "targetname");
  var0 scripts\engine\sp\utility::assign_animtree("truck_01");
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_force_color("p");
  scripts\engine\utility::flag_set("wave_5_house_end");
  scripts\engine\sp\utility::set_start_location("wolf_escapes_start", [level.player, level.price, level.farah, level.alex]);
  scripts\engine\sp\utility::set_start_location("roof_approach_start", [level.hadir]);
  var1 = spawnStruct();
  var1.origin = (-418, -110, 76);
  price_compound_run_triggers_on(1);
  scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::activate_trigger, "price_compound_run_trigger_15", "targetname");
  scripts\engine\sp\utility::activate_trigger("price_compound_run_trigger_14", "targetname");
}

function defend_wolf_escapes_scene_main() {
  waitframe();
  level.player setOrigin((-1795, -349, 120));
  level.player setplayerangles((0, 219, 0));
  setaudiotriggerstate("combat_zone", "", 2);
  setaudiotriggerstate("default", "", 2);
  level.player clearsoundsubmix("sp_npc_steps_down", 1);
  var0 = getEnt("res_secure_door", "targetname");
  var0 scripts\engine\sp\utility::assign_animtree("residence_saferoom_door");
  var0 scripts\common\anim::anim_first_frame_solo(var0, "wolf_escapes");
  var1 = scripts\engine\utility::getStruct("residence_end_struct", "targetname");
  var1 = scripts\engine\utility::spawn_tag_origin(var1.origin, var1.angles);
  var1 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (3, 0, -5), &"EMBASSY/OPEN", 90, 500, 50, 0);
  var2 = scripts\engine\utility::getStruct("residence_end_anim_struct", "targetname");
  var2.origin += (-5, 2, 0);
  var0 = getEnt("res_secure_door", "targetname");
  var0 scripts\engine\sp\utility::assign_animtree("residence_saferoom_door");
  var2 thread scripts\common\anim::anim_first_frame_solo(var0, "wolf_escapes");
  var1 waittill("trigger");
  thread ending_scene_mayhem_anims();
  level.hadir.support_equipment = 0;
  level.farah.support_equipment = 0;
  level.hadir notify("remove_equipment");
  scripts\engine\utility::flag_set("escape_lights");
  var3 = getspawner("kyle", "script_noteworthy");
  var3.count = 1;
  level.kyle = scripts\engine\sp\utility::spawn_targetname("kyle", 1);
  level.kyle.animname = "kyle";
  level.player.fake_weapon = level.player getcurrentweapon();
  var4 = weaponclass(level.player.fake_weapon);

  if(var4 != "rifle" && var4 != "smg") {
    level.player.fake_weapon = scripts\sp\utility::make_weapon("iw8_ar_mike4");
  }

  level.kyle scripts\anim\shared::forceuseweapon(level.player.fake_weapon, "primary");
  level.kyle hide();
  thread wolf_escapes_fx();
  defend_wolf_escapes_ending();
}

function kill_player_if_hostage_taker_still_alive() {
  level.player endon("death");

  if(isalive(level.stacy.other)) {
    level.player kill();
    wait 10;
    return;
  }
}

function skippable_ending() {
  level endon("level_ended");
  var0 = scripts\sp\utility::userskip_wait();

  if(!var0) {
    return;
  }

  var1 = getaiarray();

  foreach(var3 in var1) {
    var3 stopsounds();
  }

  scripts\engine\sp\utility::nextmission();
}

function residence_bodies() {
  var0 = scripts\engine\utility::getStructArray("residence_end_dead_struct", "targetname");
  var1 = getspawner("dead_marine_defend", "targetname");

  foreach(var3 in var0) {
    var4 = scripts\engine\sp\utility::bodyonlyspawn(var1);
    var4.animname = "soldier_01";
    var4 thread scripts\common\ai::gun_remove();
    waitframe();
    var4 notsolid();
    var3 thread scripts\common\anim::anim_single_solo(var4, var3.animation);
    waitframe();
  }

  var0 = scripts\engine\utility::getStructArray("residence_end_dead_struct_02", "targetname");
  var1 = getspawner("dead_enemy_defend", "targetname");

  foreach(var3 in var0) {
    var4 = scripts\engine\sp\utility::bodyonlyspawn(var1);
    var4.animname = "soldier_01";
    var4 thread scripts\common\ai::gun_remove();
    waitframe();
    var4 notsolid();
    var3 thread scripts\common\anim::anim_single_solo(var4, var3.animation);
    waitframe();
  }
}

function wolf_escapes_vo() {
  level.player endon("death");
  waitframe();
  thread vo_stacy_killed();
  level.stacy endon("damage");
  level.stacy endon("bullethit");
  level.stacy endon("killer_succeeds");
  level.stacy.other endon("death");
  level endon("stacy_result");
  level.stacy thread scripts\engine\utility::call_on_notify("damage", &stopsounds);
  level.stacy thread scripts\engine\utility::call_on_notify("bullethit", &stopsounds);
  level.stacy thread scripts\engine\utility::call_on_notify("killer_succeeds", &stopsounds);
  vo_wolf_escape_entrance();
  level.stacy.other thread scripts\sp\maps\embassy\embassy_util::say("dx_vom_aq2_wolf_escapes_final_20");
  level.stacy.function_stack = undefined;
  level.stacy notify("clear_function_stack");
  level.stacy thread scripts\sp\maps\embassy\embassy_util::say("dx_vom_stac_wolf_escapes_final_10", 1);
}

function vo_wolf_escape_entrance() {
  level.player endon("death");
  level endon("stacy_killer_saw_player");
  level.stacy.other endon("death");
  var0 = ["dx_vom_pri_wolf_escapes_final_80", "dx_vom_pri_wolf_escapes_final_90", "dx_vom_pri_wolf_escapes_final_100", "dx_vom_pri_wolf_escapes_outro_10"];
  level.get_in_there_nags = scripts\engine\sp\utility::create_deck(var0, 0);
  level.get_in_there_nags.autoshuffle = 1;
  check_cleared_residence();
  wait 2;
  scripts\sp\maps\embassy\embassy_util::wait_combat_cooldown(6, 30);
  level.price scripts\sp\maps\embassy\embassy_util::nagtill("stacy_killer_saw_player", level.get_in_there_nags, 8, 1.5);
}

function check_cleared_residence() {
  while(getaiarray("axis").size > 3) {
    level waittill("ai_killed");
  }

  level notify("cleared_residence");
}

function vo_stacy_killed() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("wolf_escapes");
  level.stacy thread scripts\sp\maps\embassy\embassy_util::say("dx_vom_stac_wolf_escapes_final_00");
  var0 = level.stacy.other;
  var1 = level.stacy scripts\engine\utility::waittill_any_return("killer_succeeds", "damage", "bullethit", "player_killed", "freed");
  level notify("stacy_result", var1);
  wait 0.2;

  if(var1 == "freed" && isalive(level.stacy) && !istrue(level.stacy.killed_early)) {
    level.stacy.function_stack = undefined;
    level.stacy notify("clear_function_stack");
    level.stacy thread scripts\sp\maps\embassy\embassy_util::say("dx_vom_stac_wolf_escapes_final_30", 1);
    wait 0.6;
    scripts\sp\maps\embassy\embassy_util::wait_combat_cooldown(0.6, 2);

    if(isalive(level.stacy) && !istrue(level.stacy.killed_early)) {
      level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_wolf_escapes_final_40");
    }
  } else {
    var0 stopsounds();

    if(isalive(var0)) {
      var0 waittill("death");
    }

    scripts\sp\maps\embassy\embassy_util::wait_combat_cooldown(0.6, 2);
    level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_wolf_escapes_final_50");
    wait 0.25;
    level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_wolf_escapes_final_60");
  }

  thread wolf_escape_door_nags();
}

function wolf_escape_door_nags() {
  wait 6;
  level.get_in_there_nags.items = scripts\engine\utility::array_add(level.get_in_there_nags.items, "dx_vom_pri_wolf_escapes_final_70");
  level.price scripts\sp\maps\embassy\embassy_util::nagtill("escape_lights", level.get_in_there_nags);
}

function ai_push_residence() {
  scripts\engine\utility::flag_wait("wolf_escapes");
  enemy_alive_counter_gate(0);
  var0 = getnodesinradius((-2017, -536, 116), 300, 0);
  var0 = sortbydistance(var0, (-2017, -536, 116));
  var1 = getaiarray("allies");

  foreach(var3 in var1) {
    var3.fixednode = 0;
    var3 scripts\engine\sp\utility::clear_force_color();
    var3 enableavoidance(0, 0);
    var3 setgoalpos(var3.origin);
    var3 thread scripts\sp\spawner::go_to_node(var0[0]);
    var3 setgoalnode(var0[0]);
    var3 scripts\engine\sp\utility::set_goal_radius(64);
    var0 = scripts\engine\utility::array_remove(var0, var0[0]);
  }
}

function defend_wolf_escapes_catchup() {}

function defend_wolf_hostage() {
  scripts\sp\maps\embassy\embassy_util::spawn_stacy();
  var0 = scripts\engine\sp\utility::spawn_targetname("residence_stacy_killer");
  var0.animname = "residence_stacy_killer";
  var0.ignoreme = 1;
  var0.health = 20;
  var0 scripts\engine\sp\utility::set_allowdeath(1);
  var0 scripts\common\ai::gun_remove();
  var0 scripts\sp\utility::context_melee_allow(0);
  thread wolf_hostage_check_damage();
  var0.other = level.stacy;
  level.stacy.other = var0;
  level.stacy.ignoreme = 1;
  level.stacy allowedstances("crouch");
  level.stacy scripts\engine\sp\utility::set_allowdeath(1);
  thread wolf_escapes_vo();
  thread wolf_hostage_check_damage();
  level.stacy scripts\engine\sp\utility::clear_deathanim();
  level.stacy.skipdeathanim = 1;
  level.stacy.a.nodeath = 1;
  level.stacy.noragdoll = 1;
  level.stacy.flashed = 0;
  level.stacy.no_friendly_fire_fail = 1;
  var1 = scripts\engine\utility::getStruct("stacy_hostage_struct", "targetname");
  var1.origin += (0, 0, 0);
  var2 = [level.stacy, var0];
  var1 scripts\common\anim::anim_single(var2, "bpgc_hostage_enter");
  var1 thread scripts\common\anim::anim_loop(var2, "bpgc_hostage_idle", "stop_hostage_loop");
  thread hostage_loop_watcher(var1);
  thread flashbang_watcher();
  thread flashbang_watcher();
  thread hostage_loop_watcher(var1);
  thread wolf_damage_watcher(level.stacy);
  thread stacy_killer_succeeds(var0);
  thread stacy_killer_dies(var0);
  thread stacy_dies(var0);
  thread stacy_killed_by_player(var0);
  var0 endon("death");

  while(!var0 cansee(level.player)) {
    waitframe();
  }

  level notify("stacy_killer_saw_player");
  wait 1;

  if(distance2d(level.stacy.other.origin, level.player.origin) > 200) {
    wait 1.1;
  }

  var1 notify("stop_hostage_loop");
}

function stacy_killer_succeeds(var0) {
  self endon("death");
  level.stacy endon("freed");
  level.stacy endon("player_killed");
  var0 waittill("stop_hostage_loop");
  waitframe();

  if(isDefined(level.stacy.killed_early)) {
    return;
  }

  level.stacy.killed_by_killer = 1;
  var0 thread scripts\common\anim::anim_single_solo(self, "bpgc_hostage_exit");
  var0 thread scripts\common\anim::anim_single_solo(level.stacy, "bpgc_hostage_death");
  level waittill("hostage_aq_fired");
  level.stacy.name = "";
  level.stacy notify("killer_succeeds");
  thread stacy_hostage_death();
}

function stacy_hostage_death() {
  level.stacy waittillmatch("single anim", "end");
  level.stacy scripts\common\ai::stop_magic_bullet_shield();
  level.stacy scripts\engine\sp\utility::die();
}

function stacy_killer_dies(var0) {
  level.stacy endon("damage");
  level.stacy endon("bullethit");
  level.stacy endon("death");
  level.stacy endon("killer_succeeds");
  scripts\engine\utility::waittill_any("damage", "bullethit");
  level.stacy notify("freed");
  level.stacy.freed = 1;
  thread stacy_dies_after_freedom(var0);
  level.stacy.forceragdollimmediate = 1;
  var0 notify("stop_hostage_loop");
  level.stacy stopanimScripted();
  var0 thread scripts\common\anim::anim_single_solo(level.stacy, "bpgc_hostage_exit");
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

    var1 = "dejected_react_01";

    if(scripts\engine\utility::cointoss()) {
      var1 = "dejected_react_02";
    }

    level.stacy scripts\common\anim::anim_single_solo(level.stacy, var1);
    level.stacy notify("react_complete");
  }
}

function stacy_reset_ff() {
  wait 0.5;
  level.stacy.no_friendly_fire_fail = 0;
  level.stacy thread scripts\sp\maps\embassy\embassy_util::civ_friendly_fire_think();
}

function flashbang_watcher() {
  self endon("death");
  level endon("hostage_aq_fired");
  level.stacy endon("freed");
  var0 = undefined;
  self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);

  if(isDefined(var10)) {
    var0 = getweaponbasename(var10);
  }

  if(var0 == "flash") {
    level.stacy.flashed = 1;
  }

  self.allowdeath = 1;

  if(self == level.stacy) {
    self.other shoot();
    return;
  }

  self shoot();
  thread scripts\common\anim::anim_single_solo(self, "bpgc_hostage_flash");
}

function stacy_dejected_idle() {
  level.stacy.whiz = 0;
  level.stacy endon("breakout_idle");
  level.stacy endon("death");
  level.stacy thread scripts\common\anim::anim_loop_solo(level.stacy, "dejected_idle");
  level.stacy waittill("bulletwhizby");
  level.stacy.whiz = 1;
}

function stacy_nearby_detect() {
  level.stacy endon("death");

  for(;;) {
    var0 = distance(level.stacy.origin, level.player.origin);

    if(var0 < 70) {
      level.stacy notify("breakout_idle");
      level.stacy waittill("react_complete");
    }

    waitframe();
  }
}

function stacy_killed_by_player(var0) {
  self endon("death");
  level.stacy endon("freed");
  level.stacy endon("death");
  level.stacy waittill("player_killed");
  level.stacy.name = "";
  var0 notify("stop_hostage_loop");
  self stopanimScripted();
}

function stacy_dies(var0) {
  level.stacy endon("freed");
  level.stacy endon("killer_succeeds");
  level.stacy scripts\engine\utility::waittill_any("damage", "bullethit", "player_killed");
  var0 notify("stop_hostage_loop");

  if(!istrue(level.stacy.freed)) {
    var0 scripts\common\anim::anim_single_solo(level.stacy, "bpgc_hostage_death");
  }

  level.stacy scripts\common\ai::stop_magic_bullet_shield();
  level.stacy scripts\engine\sp\utility::die();
}

function stacy_dies_after_freedom(var0) {
  level.stacy scripts\engine\utility::waittill_any("damage", "bullethit");
  waitframe();
  level.stacy notify("stop_loop");
  var0 notify("stop_hostage_loop");
  level.stacy.forceragdollimmediate = 1;
  level.stacy stopanimScripted();
  level.stacy.a.nodeath = 0;
  level.stacy scripts\common\ai::stop_magic_bullet_shield();
  level.stacy scripts\engine\sp\utility::ai_ragdoll_immediate();
}

function wolf_damage_watcher(var0) {
  level endon("hostage_free");
  level.stacy scripts\engine\utility::waittill_any("damage", "bullethit");
}

function hostage_loop_watcher(var0) {
  self endon("stop_hostage_loop");
  var0 scripts\engine\utility::waittill_any("damage", "bullethit");

  if(var0 == level.stacy) {
    level.stacy notify("player_killed");
    level.stacy.killed_early = 1;
    self notify("stop_hostage_loop");
    return;
  }
}

function wolf_hostage_check_damage() {
  self endon("stop_checking_damage");
  scripts\engine\utility::waittill_any("damage", "bullethit");
  self.killed_early = 1;
}

function wolf_escapes_fx() {
  playFX(scripts\engine\utility::getfx("vfx_mortar_wall_smoke"), (-2241, -729, 74), (1, 1, 1), (1, 1, 1));
}

function defend_wolf_escapes_ending() {
  level.price.name = "";
  var0 = getEnt("res_secure_door", "targetname");
  var0 scripts\engine\sp\utility::assign_animtree("residence_saferoom_door");
  setmusicstate("");
  var1 = [level.price, level.kyle, level.farah, level.alex, level.hadir];

  foreach(var3 in var1) {
    var3 scripts\engine\sp\utility::name_hide();
  }

  var1 = scripts\engine\utility::array_add(var1, var0);
  var5 = scripts\engine\utility::getStruct("residence_end_anim_struct", "targetname");
  var5.origin += (-5, 0, 0);
  var6 = getEntArray("residence_pristine_wall", "targetname");
  scripts\engine\utility::array_delete(var6);
  thread scripts\sp\maps\embassy\embassy_lighting::wolf_door_light();
  var5 scripts\common\anim::anim_first_frame_solo(level.player.rig, "wolf_escapes");
  var5 scripts\common\anim::anim_first_frame_solo(level.kyle, "wolf_escapes");
  waitframe();
  level.player enablequickweaponswitch(1);
  scripts\sp\maps\embassy\embassy_util::put_player_into_rig(level.player.rig, 0.5, 5, 5, 5, 5);
  var7 = getcorpsearray();

  foreach(var9 in var7) {
    var9 delete();
  }

  var5 scripts\common\anim::anim_first_frame_solo(var0, "wolf_escapes");
  var5 thread scripts\common\anim::anim_single(var1, "wolf_escapes");
  var5 scripts\common\anim::anim_single_solo(level.player.rig, "wolf_escapes");
  level.kyle show();
  var5 scripts\common\anim::anim_last_frame_solo(level.player.rig, "wolf_escapes");
  level.player unlink();
  var11 = level.player.rig scripts\engine\utility::getanim("wolf_escapes_cam");
  var12 = getstartorigin(var5.origin, var5.angles, var11);
  var13 = getstartangles(var5.origin, var5.angles, var11);
  level.player setOrigin(var12);
  level.player setplayerangles(var13);
  thread audio_wolf_outro_room_mix();
  visionsetnaked("embassy_wolf_escapes", 0.2);
  var5 scripts\common\anim::anim_first_frame_solo(level.player.rig, "wolf_escapes_cam");
  level.player playerlinktoabsolute(level.player.rig, "tag_player");
  var5 notify("stop_first_frame");
  level.player.rig hide();
  thread defend_wolf_escapes_ending_camera_settings();
  var5 thread scripts\common\anim::anim_single_solo(level.player.rig, "wolf_escapes_cam");
  var14 = getanimlength(level.player.rig scripts\engine\utility::getanim("wolf_escapes_cam"));
  level.player scripts\engine\utility::delaycall(var14 - 5.5, &setclienttriggeraudiozone, "fade_to_black_minus_scripted5_music_and_dx", 7.5);
  wait var14 - 2.5;
  thread scripts\sp\analytics::analytics_kleenex_update("Triage to End of Gameplay");
  scripts\engine\sp\utility::nextmission();
  level waittill("forever");
}

#using_animtree("generic_human");

function triage_scene_mayhem_anims() {
  thread scene_mayhem(level.price, %emb_def_050_triage_scene_price_face, "triage_mayhem_price_face");
}

#using_animtree("");

function ending_scene_mayhem_anims() {
  thread scene_mayhem(level.price, %emb_exfil_010_wolfescapes_price_face);
  thread scene_mayhem(level.farah, %emb_exfil_010_wolfescapes_farah_face);

  while(!isDefined(level.kyle)) {
    waitframe();
  }

  thread scene_mayhem(level.kyle, %emb_exfil_010_wolfescapes_kyle_face);
}

function scene_mayhem(var0, var1, var2) {
  level waittill(var1);

  if(!isDefined(var2)) {
    var2 = undefined;
  }

  thread play_mayhem_animation(var0, var2);
}

function play_mayhem_animation(var0, var1) {
  if(isDefined(self.headmodel)) {
    if(isDefined(self.hatmodel)) {
      self detach(self.hatmodel);
    }

    self detach(self.headmodel);
    self setanim(var0, 1, 0, 1);
  }

  if(isDefined(var1)) {
    level waittill(var1);
    self setanim(var0, 0, 0, 0);
    self attach(self.headmodel);

    if(isDefined(self.hatmodel)) {
      self attach(self.hatmodel);
      return;
    }

    return;
  }
}

function audio_wolf_outro_room_mix() {
  level.player setclienttriggeraudiozone("embassy_wolf_outro_room", 10);
}

function defend_wolf_escapes_ending_camera_settings() {
  level.player modifybasefov(42, 0.01);
  level.player setcinematicmotionoverride("disabled");
  hidecinematicletterboxing(0, 0);
  level.price scripts\engine\sp\utility::dof_enable_autofocus(1.4, 1, undefined, undefined, "tag_eye");
  wait 5;
  level.farah scripts\engine\sp\utility::dof_enable_autofocus(2, 1, undefined, undefined, "tag_eye");
}

function wolf_actors_idle(var0) {
  self waittillmatch("single anim", "end");

  if(scripts\engine\utility::is_equal(self, level.price) || scripts\engine\utility::is_equal(self, level.kyle)) {
    if(scripts\engine\utility::is_equal(self, level.price)) {
      var0 scripts\common\anim::anim_last_frame_solo(self, "wolf_escapes");
      return;
    }

    scripts\engine\sp\utility::clear_force_color();
    self setgoalpos(self.origin);
    return;
  }
}

function mortar_rounds_pacing() {
  level endon("wave_2_end");
  level.mortar_round_delay_time += 1;
  level waittill("mortar_impact");
  waitframe();
  level waittill("mortar_impact");

  for(;;) {
    if(!scripts\engine\utility::flag("enemy_mortar_manned")) {
      break;
    }

    level.mortar_round_delay_time = 0.5;
    var0 = randomintrange(2, 4);
    var1 = randomintrange(1, 2);
    level.mortar_round_delay_time = var1;
    wait var1;
  }
}

function flare_mover(var0) {
  while(isDefined(self) && scripts\engine\utility::flag("flares_out")) {
    var1 = self.origin[0] + randomintrange(-5, 5);
    var2 = self.origin[1] + randomintrange(-5, 5);
    var3 = self.origin[2] - 15;
    self moveTo((var1, var2, var3), 1);
    wait 1;
  }
}

function squad_init() {
  scripts\sp\maps\embassy\embassy_util::spawn_price();
  scripts\sp\maps\embassy\embassy_util::spawn_farah();
  scripts\sp\maps\embassy\embassy_util::spawn_alex();
  scripts\sp\maps\embassy\embassy_util::spawn_hadir();
  scripts\sp\maps\embassy\embassy_util::spawn_mortar_friendlies();
  scripts\sp\maps\embassy\embassy_util::spawn_marines_friendlies();
  scripts\sp\maps\embassy\embassy_util::spawn_alex_friendlies();
}

function wave_1_field_infantry() {
  var0 = getEnt("interior_main_vol", "targetname");
  var1 = scripts\engine\utility::getStruct("mortar_wave_3_lookat", "targetname");
  var2 = 0.939693;

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var1.origin, var2)) {
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
  var3 = scripts\engine\utility::getStruct("mortar_rooftop_struct", "targetname");
  var3 notify("stop_loop");
  var3 notify("stop_mortar_guy_idle");
  scripts\engine\sp\utility::activate_trigger("wave_0_color_trigger", "targetname");
  thread scripts\engine\sp\utility::battlechatter_off("allies");
  thread scripts\engine\sp\utility::battlechatter_off("axis");
  wait 0.4;
  var4 = undefined;
  spawn_ai_wave_1();
  var4 = level.wave_1_guys[0];
  var4.animname = "aq_leader";
  var4.health = 20;
  var5 = scripts\engine\utility::getStruct("aq_leader_struct", "targetname");
  var5.origin += (-700, -200, 0);
  var5 thread scripts\common\anim::anim_first_frame_solo(var4, "compound_charge");
  wait 4;
  var5 thread scripts\common\anim::anim_single_solo(var4, "compound_charge");
  var4.allowdeath = 1;
  var4 allowedstances("stand", "crouch", "prone");
  wait 2.5;
  thread scripts\engine\utility::play_sound_in_space("dx_vom_aq4_defend_battlecry_51", var5.origin + (0, 0, 50));
  wait 1;
  scripts\engine\utility::array_thread(level.wave_1_guys, &enemies_wave_01_scatter_delay);
  level.farah scripts\engine\sp\utility::set_battlechatter(0);
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  thread scripts\engine\sp\utility::battlechatter_on("allies");
  level.farah.battlechatterallowed = 1;

  while(level.flare_countdown > 8) {
    wait 0.1;
  }

  thread wave_1_enemy_reinforcements();
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::flag_waitopen("flares_out");
  scripts\engine\utility::flag_set("enable_ilumination_flares");
  front_2_timeout();

  if(!scripts\engine\utility::flag("front_3")) {
    scripts\engine\utility::flag_wait("player_flaring");
  }

  var6 = getaiarray("axis");
  scripts\engine\utility::array_thread(var6, &molotov_notify);
  scripts\engine\utility::flag_wait("front_3");
  scripts\engine\utility::flag_set("enable_ilumination_flares");
  thread flare_enable_loop();

  if(!scripts\engine\utility::flag("flare_2_skipped")) {
    scripts\engine\utility::flag_wait("flares_out");
  } else {
    wait 8;
  }

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

function molotov_throwers() {
  var0 = (9.2, 212, 212);
  var1 = (108.5, -294.5, 16);
  var2 = scripts\engine\utility::getStruct("east_grounds", "targetname").origin;
  var3 = scripts\engine\utility::getStruct("price_ladder_struct", "targetname").origin;
  var4 = [var0, var1, var2, var3];
  var5 = spawnStruct();
  var5.angles = (0, 180, 0);
  var5.origin = (718, 100, 17.5283);
  var6 = spawnStruct();
  var6.angles = (0, 180, 0);
  var6.origin = (726, -237, 17.5283);
  var7 = [var6, var6];
  level.scr_anim["grenade_thrower"]["grenade_toss"] = % sdr_com_exposed_crouch_grenade_throw01;
  scripts\common\anim::addnotetrack_notify("grenade_thrower", "grenade_throw", "scripted_grenade_throw", "grenade_toss");
  var8 = "molotov";
  var9 = 0;

  while(var9 < 4) {
    var10 = getaiarray("axis");
    var10 = scripts\sp\maps\embassy\embassy_util::array_removedeaddyingorundefined(var10);

    if(var10.size == 0) {
      break;
    }

    var11 = sortbydistance(var10, scripts\engine\utility::random(var7).origin)[0];
    var11.animname = "grenade_thrower";
    var11 endon("death");
    var11.ignoreall = 1;
    var11.threw_grenade = 0;
    thread anim_reach_watcher(var11);
    thread molotov_guy_death_watcher();
    thread molotov_throw_watcher();

    for(;;) {
      waitframe();
    }

    LOC_0000019e:
      var12 = var4[var9];
    var11 scripts\engine\sp\utility::set_grenadeweapon(var8);
    var11.grenadeammo = 1;
    var13 = var11 gettagorigin("tag_accessory_right");
    var14 = (var12 - var11.origin + (0, 0, 50)) * 1.5;
    var15 = var11 magicgrenade(var13, var12);

    if(!isDefined(var15)) {
      var11.ignoreall = 0;
      waitframe();
      continue;
    }

    var9++;
    var11.ignoreall = 0;
    var11.threw_grenade = 1;
    var11.grenadeammo = 0;

    if(var8 == "molotov") {
      level notify("molotov_fired");
      thread scripts\sp\equipment\molotov::molotovfiremain(var15);
    }

    if(var8 == "semtex") {
      var11 thread scripts\sp\equipment\semtex::semtexfiremain(var15);
    }

    if(var9 < 2) {
      wait 4;
      continue;
    }

    wait 9;
    LOC_00000266:
  }
}

function anim_reach_watcher(var0) {
  self endon("death");
  var0 scripts\sp\anim::anim_reach_solo(self, "grenade_toss");

  if(isalive(self)) {
    var0 thread scripts\common\anim::anim_single_solo(self, "grenade_toss");
    return;
  }
}

function molotov_throw_watcher() {
  self endon("death");
  level waittill("scripted_grenade_throw");
  self.threw_grenade = 1;
}

function molotov_guy_death_watcher() {
  self waittill("death");
  level notify("molotov_guy_died");
}

function front_2_timeout() {
  level endon("front_3");
  scripts\engine\utility::flag_wait("flares_out");
  scripts\engine\utility::flag_waitopen("flares_out");
  scripts\engine\utility::flag_set("enable_ilumination_flares");
}

function flare_enable_loop() {
  level endon("stop_player_flare_mortar");

  for(;;) {
    scripts\engine\utility::flag_wait("flares_out");
    scripts\engine\utility::flag_waitopen("flares_out");
    scripts\engine\utility::flag_set("enable_ilumination_flares");
  }
}

function enemy_volume_changer() {
  var0 = [];
  scripts\engine\utility::flag_wait("wave_1_attack");
  scripts\engine\utility::flag_waitopen("flares_out");
  level.front_goal_vol = getEnt("front_2", "targetname");
  scripts\engine\utility::flag_set("front_2");
  var1 = getaiarray("axis");
  wait 1;
  scripts\engine\utility::array_thread(var1, &wave_1_enemy_battle_line_update, level.front_goal_vol);
  scripts\engine\utility::flag_waitopen("flares_out");
  thread skip_front_2_logic();
  scripts\engine\utility::flag_wait("flares_out");

  if(scripts\engine\utility::flag("front_3")) {
    return;
  }

  scripts\engine\utility::exploder("wave02");
  scripts\engine\utility::flag_waitopen("flares_out");
  var2 = getEnt("front_2_clip", "targetname");
  var2 connectpaths();
  var2 delete();
  scripts\engine\utility::flag_set("front_3");
  level.front_goal_vol = getEnt("front_3", "targetname");
  wait 1;
  var1 = getaiarray("axis");
  scripts\engine\utility::array_thread(var1, &wave_1_enemy_battle_line_update, level.front_goal_vol);
  waitframe();
  scripts\engine\utility::flag_wait("flares_out");
  waitframe();
}

function skip_front_2_logic() {
  level endon("flares_out");
  wait 20;
  scripts\engine\utility::flag_set("front_3");
  scripts\engine\utility::flag_set("flare_2_skipped");
  level.front_goal_vol = getEnt("front_3", "targetname");
  var0 = getaiarray("axis");
  scripts\engine\utility::array_thread(var0, &enemies_skip_front_2, level.front_goal_vol);
  var1 = getEnt("front_2_clip", "targetname");
  var1 connectpaths();
  var1 delete();
}

function enemies_skip_front_2(var0) {
  self allowedstances("stand", "crouch", "prone");
  scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::delaythread(randomfloatrange(0.5, 1), &scripts\common\utility::demeanor_override, "combat");
  self setgoalvolumeauto(var0, level.field_cover_direction);
  scripts\engine\utility::set_movement_speed(180);
  scripts\engine\utility::waittill_any_timeout(6, "goal");
  self allowedstances("crouch", "stand", "prone");
  self.ignoreall = 0;
  self setgoalvolumeauto(var0, level.field_cover_direction);
  scripts\common\utility::demeanor_override("combat");
}

function wave_1_enemy_battle_line_update(var0, var1) {
  level endon("flare_2_skipped");

  if(!isalive(self)) {
    return;
  }

  self endon("death");
  self.ignoreall = 1;
  scripts\common\utility::demeanor_override("cqb");
  self notify("change_volume");
  wait randomfloatrange(0.1, 0.4);
  self allowedstances("prone");
  scripts\engine\utility::flag_wait("player_flaring");
  var2 = getcorpsearray();

  foreach(var4 in var2) {
    if(scripts\engine\utility::is_equal(var4.script_noteworthy, "ally_03")) {
      continue;
    }

    var4 delete();
  }

  wait 4;
  self allowedstances("stand", "crouch", "prone");
  scripts\common\utility::demeanor_override("combat");
  var6 = 0.1;

  if(scripts\engine\utility::flag("front_3")) {
    var6 += 1;
  }

  wait var6;

  if(scripts\engine\utility::flag("front_3")) {
    self allowedstances("stand", "crouch", "prone");
    scripts\common\utility::demeanor_override("cqb");
    scripts\engine\utility::delaythread(randomfloatrange(0.5, 1), &scripts\common\utility::demeanor_override, "combat");
    self setgoalvolumeauto(var0, level.field_cover_direction);
    wait 1;
  }

  self allowedstances("stand", "crouch", "prone");
  scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::delaythread(randomfloatrange(0.5, 1), &scripts\common\utility::demeanor_override, "combat");
  self setgoalvolumeauto(var0, level.field_cover_direction);
  scripts\engine\utility::waittill_any_timeout(6, "goal");
  self allowedstances("crouch", "stand", "prone");
  self.ignoreall = 0;
  self setgoalvolumeauto(var0, level.field_cover_direction);
  scripts\common\utility::demeanor_override("combat");
}

function wave_1_enemy_reinforcements() {
  spawn_max_ai_wave_1_refill();
  wait 0.1;
  spawn_max_ai_wave_1_refill();
  thread enemy_volume_changer();
  scripts\engine\utility::flag_wait_any("player_flaring", "flare_2_skipped");

  if(!scripts\engine\utility::flag("flare_2_skipped")) {
    var0 = getcorpsearray();

    foreach(var2 in var0) {
      var2 delete();
    }

    wait 3.5;
    spawn_max_ai_wave_1_lmg_push();
    scripts\engine\utility::flag_waitopen("flares_out");
    rpg_guy_wave_1();
  } else {
    spawn_ai_wave_2_pre_push();
  }

  scripts\engine\utility::flag_wait("front_3");
  scripts\engine\utility::flag_wait_any("player_flaring", "flare_2_skipped");
  thread wave_1_technical_01();

  if(!scripts\engine\utility::flag("flare_2_skipped")) {
    spawn_max_ai_wave_1_technical_refill();
  }

  enemy_alive_counter_gate(7);
  var4 = getnodearray("exposed_flare_nodes", "targetname");
  var4 = sortbydistance(var4, level.player.origin);
  var5 = getaiarray("axis");

  foreach(var7 in var5) {
    var7.goalradius = 32;
    var7 setgoalnode(var4[var8]);
    var7.health = 1;
    var7.attackeraccuracy = 1000;
    var7.baseaccuracy = 0;

    if(var7 scripts\engine\utility::doinglongdeath()) {
      var7 kill();
      continue;
    }

    var7 scripts\engine\sp\utility::disable_long_death();
  }

  scripts\engine\utility::flag_set("wave_1_3_ending");
  enemy_alive_counter_gate(3);
  enemy_alive_counter_gate(0);
  scripts\engine\utility::flag_set("wave_1_falling_back");
}

function spawn_max_ai_wave_1_lmg_push() {
  var0 = getspawnerarray("wave_1_extra_2");
  var1 = getaiarray("axis");
  var2 = 13 - var1.size;
  var3 = var2;

  if(var3 <= 0) {} else {
    if(var0.size - var3 < 0) {
      var3 = var0.size;
    }

    for(var4 = 0; var4 < var3; var4++) {
      var0[var4] scripts\engine\sp\utility::spawn_ai(1);
    }
  }

  var1 = getaiarray("axis", "allies");
}

function spawn_max_ai_wave_1_technical_refill() {
  var0 = getspawnerarray("wave_1_extra_3");
  var1 = getaiarray("axis", "allies");
  var2 = 25 - var1.size;
  var3 = var2;

  if(var3 <= 0) {} else {
    if(var0.size - var3 < 0) {
      var3 = var0.size;
    }

    for(var4 = 0; var4 < var3; var4++) {
      var0[var4] scripts\engine\sp\utility::spawn_ai(1);
    }
  }

  var1 = getaiarray("axis", "allies");
}

function spawn_max_ai_wave_1_refill() {
  var0 = getaiarray("axis", "allies");
  var1 = 5;
  var2 = getspawnerarray("wave_1_extra_1");

  if(var2.size - var1 < 0) {
    var1 = var2.size;
  }

  for(var3 = 0; var3 < var1; var3++) {
    wait randomfloatrange(0.1, 0.4);
    var2[var3] scripts\engine\sp\utility::spawn_ai(1);
    var2[var3].count = 1;
  }

  var0 = getaiarray("axis");
}

function rpg_guy_wave_1() {
  var0 = scripts\engine\sp\utility::spawn_targetname("rpg_guy_01", 1);
  var0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
  var0.baseaccuracy = 1;
  var1 = scripts\engine\sp\utility::spawn_targetname("rpg_guy_02", 1);
  var1 scripts\engine\sp\utility::set_favoriteenemy(level.player);
  var1.baseaccuracy = 1;
  var0.ignoreme = 1;
  var0.rpg_guy = 1;
  var1.ignoreme = 1;
  var1.rpg_guy = 1;
  var2 = [var0, var1];
  scripts\engine\utility::array_thread(var2, &rpg_notify);
  scripts\engine\utility::flag_wait("front_3");
  scripts\engine\utility::flag_wait("player_flaring");

  if(isDefined(var0)) {
    var0.ignoreme = 0;
  }

  if(isDefined(var1)) {
    var1.ignoreme = 0;
    return;
  }
}

function rpg_notify() {
  self endon("death");

  for(;;) {
    self waittill("missile_fire");
    level notify("rpg_fired");
  }
}

function molotov_notify() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire");
    level notify("molotov_fired");
  }
}

function wave_1_enemy_behavior() {
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

  if(self.classname == "actor_enemy_alq_desert_dmr") {
    self.disablesniperbehaviors = 1;
  }

  if(self.classname == "actor_enemy_alq_desert_lmg") {
    self.secondaryweapon = "none";
  }

  self setgoalvolumeauto(level.front_goal_vol, level.field_cover_direction);

  if(self.targetname != "wave_1") {
    enemies_wave_01_engage();
    return;
  }
}

function enemies_wave_01_scatter_delay() {
  self endon("death");
  wait randomfloatrange(0.1, 1.1);
  self allowedstances("stand", "crouch", "prone");
  scripts\engine\utility::delaythread(randomfloatrange(0.2, 1), &scripts\common\utility::demeanor_override, "combat");
  self.ignoreme = 0;
  scripts\engine\utility::waittill_any_timeout(10, "goal");

  if(!isDefined(self)) {
    return;
  }

  self.ignoreall = 0;
}

function enemies_wave_01_engage() {
  self endon("change_volume");
  self endon("death");

  if(!isalive(self)) {
    return;
  }

  scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::waittill_any_timeout(6, "goal");
  self.ignoreall = 0;
}

function enemies_wave_01_refill() {
  self endon("change_volume");
  self endon("death");

  if(!isalive(self)) {
    return;
  }

  scripts\common\utility::demeanor_override("combat");
  self.ignoreall = 0;
}

function enemy_fall_back_killer() {
  self endon("death");
  self waittill("goal");
  self delete();
}

function friendly_flare_sender(var0, var1, var2) {
  var3 = 0;

  if(isDefined(var0)) {
    var3 = var0;
  }

  wait var3;

  if(!scripts\engine\utility::flag("flares_out")) {
    if(isDefined(var2)) {
      var4 = scripts\engine\utility::getStruct("flare_anim", "script_noteworthy");
      var5 = getaiarray("allies");
      var6 = scripts\engine\utility::getclosest(var4.origin, var5);

      if(!isDefined(var6.magic_bullet_shield)) {
        var6 thread scripts\common\ai::magic_bullet_shield();
      }

      var6.ignoreall = 1;
      var6.ignoreme = 1;
      var7 = var6.script_forcecolor;
      var6.animname = "emp_stand_pain_01";
      var4 scripts\sp\anim::anim_reach_solo(var6, "flare_drop");
      var4 thread scripts\common\anim::anim_loop_solo(var6, "flare_drop", "stop_drop");
      var4 notify("stop_drop");
      var6 scripts\engine\sp\utility::set_force_color("g");
      var6.ignoreall = 0;
      var6.ignoreme = 0;
      return;
    }

    return;
  }
}

function friendly_flare_sender_loop(var0, var1) {
  level endon("wave_2_end");
  level endon("wave_3_end");
  level endon("wave_4_end");
  level endon("kill_friendly_flares");
  var2 = 4;
  scripts\engine\utility::flag_set("flare_loop_on");

  if(scripts\sp\starts::is_after_start("laser_targeting_1")) {
    var2 = 0;
  }

  if(scripts\engine\utility::flag("perimeter_breached")) {
    var2 = 0;
  }

  var3 = ["dx_vom_alx_defend_grounds_30", "dx_vom_alx_defend_grounds_40", "dx_vom_alx_defend_grounds_50"];
  var4 = scripts\engine\sp\utility::create_deck(var3);
  level.support_mortar_tube.shell = "j_mortar_shell";
  level.support_mortar_tube showpart(level.support_mortar_tube.shell, "misc_wm_mortar");
  level.support_mortar_tube scripts\engine\sp\utility::assign_animtree("enemy_mortar");
  level.support_mortar_tube scripts\common\anim::anim_first_frame_solo(level.support_mortar_tube, "flare_enter_aq");
  var5 = [level.support_mortar_tube, level.alex];

  while(scripts\engine\utility::flag("flare_loop_on")) {
    level.alex.ignoreme = 1;
    level.alex.ignoreall = 1;
    level.support_mortar_tube scripts\sp\anim::anim_reach_solo(level.alex, "flare_enter_aq");
    level.alex scripts\engine\sp\utility::set_goal_radius(10);

    if(scripts\engine\utility::flag("flares_out")) {
      scripts\engine\utility::flag_waitopen("flares_out");
    }

    level.support_mortar_tube showpart(level.support_mortar_tube.shell, "misc_wm_mortar");
    level.alex scripts\engine\utility::delaythread(1, &scripts\sp\maps\embassy\embassy_util::say_as_chatter, var4 scripts\engine\sp\utility::deck_draw(), 0, 1);
    level.support_mortar_tube scripts\common\anim::anim_single(var5, "flare_enter_aq");
    thread scripts\engine\utility::flag_set_delayed("flare_north", 0.5);
    level.support_mortar_tube thread scripts\common\anim::anim_single(var5, "flare_launch_aq");
    level.alex waittillmatch("single anim", "end");
    level.support_mortar_tube scripts\common\anim::anim_single_solo(level.alex, "flare_exit_aq");
    level.support_mortar_tube scripts\common\anim::anim_first_frame_solo(level.support_mortar_tube, "flare_enter_aq");
    level.support_mortar_tube notify("stop_flare_support_loop");
    level.alex.ignoreme = 0;
    level.alex.ignoreall = 0;
    var6 = getnode("alex_mortar_node", "targetname");
    level.alex setgoalnode(var6);
    level.alex allowedstances("crouch", "stand");
    scripts\engine\utility::flag_wait("flares_out");

    if(isDefined(var1)) {
      break;
    }

    while(level.flare_countdown > 1) {
      wait 0.1;
    }

    level.alex setgoalpos(level.support_mortar_tube.origin);
    level.alex scripts\engine\sp\utility::set_goal_radius(20);
  }

  level.alex scripts\engine\sp\utility::enable_ai_color();
  level.alex allowedstances("crouch", "stand", "prone");
}

function guy_reveal() {
  self endon("death");
  self.ignoreme = 0;
}

function enemy_alive_counter_gate(var0) {
  wait 0.2;
  var1 = getaiarray("axis");

  while(var1.size > var0) {
    var1 = getaiarray("axis");
    wait 0.1;
  }

  return false;
}

function wave_1_technical_01() {
  scripts\engine\utility::flag_wait("enemies_at_the_wall");
  level.technical_01 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_01");
  level.technical_01.maxhealth = 34000;
  level.technical_01 setnormalhealth(1);
  level.technical_01.donotunloadonend = 1;
  level.technical_01 scripts\common\vehicle::godon();
  level.technicals[level.technicals.size] = level.technical_01;
  level.technical_01_gunner = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_01");
  level.technical_01 hidepart("tag_roof_wheel", "veh8_civ_lnd_techo_rebel");
  var0 = getEnt("technical_dude_gunner_clip", "targetname");
  var0.origin += (5, -10, 5);
  var0 linkTo(level.technical_01);
  level.technical_01_gunner forceteleport(var0.origin + (0, 0, 0), level.technical_01_gunner.angles);
  level.technical_01_gunner linkTo(var0);
  var1 = scripts\sp\utility::make_weapon("iw8_lm_pkilo");
  level.technical_01_gunner scripts\anim\shared::forceuseweapon(var1, "primary");
  level.technical_01_gunner.baseaccuracy = 0.1;
  level.technical_01_gunner allowedstances("stand");
  thread gunner_death_watcher(level.technical_01_gunner);
  level.technical_01_gunner.deathanim = % emb_def_truck_driver_death;
  var2 = scripts\engine\utility::getStruct("technical_magic_bullet_struct", "targetname");
  var3 = level.technical_01_gunner gettagorigin("j_head");
  var4 = getvehiclenode("technical_start_01", "targetname");
  wait 4;
  thread technical_lights();
  level.technical_01 scripts\common\vehicle::attach_vehicle_and_gopath(var4);
  thread sfx_technical_drive_in(level.technical_01, "scn_embassy_technical_drive_in");
  wait 1;
  level.technical_01_gunner.secondaryweapon = "none";

  while(level.technical_01.veh_speed) {
    wait 0.1;
  }

  level.technical_01 scripts\common\vehicle::godoff();
  level.technical_01.regenerate = 0;
  level notify("technical_01_stopped");
  level.technical_01 notify("technical_01_stopped");
  level.technical_01.maxhealth = 20000;
  var5 = getEntArray("technical_dudes_01", "targetname");

  foreach(var7 in var5) {
    var7 setgoalvolumeauto(level.front_goal_vol, level.field_cover_direction);
  }

  while(level.flare_countdown > 0) {
    wait 7;
  }

  scripts\engine\utility::flag_wait("wave_1_3_ending");

  if(isDefined(level.technical_01_gunner)) {
    magicbullet("iw8_sn_mike14", var2.origin, var3);
    waitframe();
    level.technical_01_gunner kill();
    return;
  }
}

function technical_lights() {
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_technical_brakelight_left"), self, "tag_light_back_left");
  playFXOnTag(scripts\engine\utility::getfx("vfx_technical_brakelight_right"), self, "tag_light_back_right");
  scripts\engine\utility::waittill_any("death", "technical_01_stopped");
  waitframe();
  stopFXOnTag(scripts\engine\utility::getfx("vfx_technical_brakelight_left"), self, "tag_light_back_left");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_technical_brakelight_right"), self, "tag_light_back_right");
}

function wave_4_technical_02() {
  var0 = spawnStruct();
  var0.origin = (4140, 896, 24);
  var1 = 0.93969;
  var2 = gettime();
  var3 = 10000;

  for(;;) {
    if(gettime() > var2 + var3 || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin, var1)) {
      break;
    }

    wait 0.1;
  }

  level.technical_02 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_02");
  level.technical_02.maxhealth = 20000;
  level.technicals[level.technicals.size] = level.technical_02;
  level.technical_02_gunner = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_02");
  var4 = getEnt("technical_dude_gunner_clip_02", "targetname");
  var4.origin += (0, 0, 4);
  var4 linkTo(level.technical_02);
  level.technical_02_gunner forceteleport(var4.origin + (0, 0, 0), level.technical_02_gunner.angles);
  level.technical_02_gunner linkTo(var4);
  level.technical_02_gunner.ignoreme = 1;
  level.technical_02_gunner.ignoreall = 1;
  level.technical_02_gunner.noragdoll = 1;
  level.technical_02_gunner allowedstances("stand");
  thread gunner_death_watcher(level.technical_02_gunner);
  level.technical_02_gunner.secondaryweapon = "none";
  thread gunner_ignore_delay(level.technical_02_gunner);
  var5 = getvehiclenode("technical_start_02", "targetname");
  level.technical_02 scripts\common\vehicle::attach_vehicle_and_gopath(var5);
  level.technical_02 scripts\common\vehicle::vehicle_lights_on();
  thread sfx_technical_drive_in(level.technical_02, "scn_embassy_technical_02_drive_in");
  level.technical_02 endon("death");
  wait 1;
  level.technical_02.regenerate = 0;

  while(level.technical_02.veh_speed && !scripts\engine\utility::flag("fire_rocket_at_technical")) {
    wait 0.1;
  }

  if(scripts\engine\utility::flag("fire_rocket_at_technical")) {
    level waittill("hellfire_impact");
  }

  level.technical_02.maxhealth = 21000;

  if(isalive(level.technical_02_gunner)) {
    level.technical_02_gunner.ignoreme = 0;
  }

  var6 = getEntArray("technical_dudes_02", "targetname");
  var7 = getEnt("interior_main_grounds", "targetname");

  foreach(var9 in var6) {
    var9 setgoalvolumeauto(var7);
    var9 scripts\engine\sp\utility::set_ignoresuppression(0);
    var9 scripts\engine\sp\utility::set_goal_radius(300);
    var9 setgoalentity(level.player);
    var9 allowedstances("stand", "crouch");
  }

  if(level.technical_02.health >= 1 && !level.technical_02.veh_speed) {
    level notify("technical_achievement_fail");
    level.technical_02 scripts\common\vehicle::vehicle_lights_off("brakelights");
    return;
  }
}

function gunner_ignore_delay(var0) {
  self endon("death");
  wait var0;
  self.ignoreme = 0;
  self.ignoreall = 0;
}

function wave_4_technical_03() {
  level.technical_03 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_03");
  var0 = getEntArray("technical_dudes_03", "targetname");
  level.technical_03 scripts\common\vehicle::vehicle_lights_on();
  level.technical_03.maxhealth = 34000;
  level.technicals[level.technicals.size] = level.technical_03;
  level.technical_03_gunner = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_03");
  var0 = scripts\engine\utility::array_add(var0, level.technical_03_gunner);
  thread enemies_alive_watcher(var0, "beam_technical_guys_killed");
  var1 = getEnt("technical_dude_gunner_clip_03", "targetname");
  var1.origin += (0, 0, 0);
  var1 linkTo(level.technical_03);
  level.technical_03_gunner forceteleport(var1.origin + (0, 0, 0), level.technical_03_gunner.angles);
  level.technical_03_gunner linkTo(var1);
  level.technical_03_gunner.ignoreme = 1;
  level.technical_03_gunner.noragdoll = 1;
  level.technical_03_gunner allowedstances("stand");
  thread gunner_death_watcher(level.technical_03_gunner);
  level.technical_03_gunner.secondaryweapon = "none";
  var2 = getvehiclenode("technical_start_03", "targetname");
  level.technical_03 scripts\common\vehicle::attach_vehicle_and_gopath(var2);
  level.technical_03 endon("death");
  thread truck_street_death_watcher();
  thread sfx_technical_drive_in(level.technical_03, "scn_embassy_technical_03_drive_in");
  wait 1;
  level.technical_03.regenerate = 0;

  while(level.technical_03.veh_speed && !scripts\engine\utility::flag("fire_rocket_at_technical")) {
    wait 0.1;
  }

  if(scripts\engine\utility::flag("fire_rocket_at_technical")) {
    level waittill("hellfire_impact");
  }

  level.technical_03.maxhealth = 21000;
  var3 = getEntArray("technical_dudes_03", "targetname");
  var4 = getEnt("interior_main_grounds", "targetname");

  foreach(var6 in var3) {
    var6 setgoalvolumeauto(var4);
    var6 scripts\engine\sp\utility::set_ignoresuppression(0);
    var6 scripts\engine\sp\utility::set_goal_radius(300);
    var6 scripts\engine\sp\utility::set_favoriteenemy(level.price);
    var6 setgoalentity(level.price);
    var6 allowedstances("stand", "crouch");
  }

  if(isalive(level.technical_03_gunner)) {
    level.technical_03_gunner.ignoreme = 0;
  }

  if(level.technical_03.health >= 1 && !level.technical_03.veh_speed) {
    level notify("technical_achievement_fail");
    level.technical_03 scripts\common\vehicle::vehicle_lights_off("brakelights");
    return;
  }
}

function wave_4_technical_09() {
  level.technical_09 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_09");
  var0 = getEntArray("technical_dudes_09", "targetname");
  level.technical_09 scripts\common\vehicle::vehicle_lights_on();
  level.technical_09.maxhealth = 34000;
  level.technicals[level.technicals.size] = level.technical_09;
  thread enemies_alive_watcher(var0, "beam_technical_guys_killed");
  var1 = getvehiclenode("technical_start_09", "targetname");
  level.technical_09 scripts\common\vehicle::attach_vehicle_and_gopath(var1);
  thread sfx_technical_drive_in(level.technical_09, "scn_embassy_technical_09_drive_in");
  wait 1;
  level.technical_09.regenerate = 0;
  level.technical_09 endon("death");
  level.technical_09 vehicle_setspeed(25, 10, 5);

  while(level.technical_09.veh_speed && !scripts\engine\utility::flag("fire_rocket_at_technical")) {
    wait 0.1;
  }

  if(scripts\engine\utility::flag("fire_rocket_at_technical")) {
    level waittill("hellfire_impact");
  }

  level.technical_09.maxhealth = 21000;
  var2 = getEntArray("technical_dudes_09", "targetname");
  var3 = getEnt("interior_main_grounds", "targetname");

  foreach(var5 in var2) {
    var5 setgoalvolumeauto(var3);
    var5 scripts\engine\sp\utility::set_ignoresuppression(0);
    var5 scripts\engine\sp\utility::set_goal_radius(300);
    var5 scripts\engine\sp\utility::set_favoriteenemy(level.price);
    var5 setgoalentity(level.price);
    var5 allowedstances("stand", "crouch");
  }

  if(level.technical_09.health >= 1 && !level.technical_09.veh_speed) {
    level notify("technical_achievement_fail");
    level.technical_09 scripts\common\vehicle::vehicle_lights_off("brakelights");
    return;
  }
}

function wave_4_technical_10() {
  level.technical_10 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_10");
  var0 = getEntArray("technical_dudes_10", "targetname");
  level.technical_10 scripts\common\vehicle::vehicle_lights_on();
  level.technical_10.maxhealth = 34000;
  level.technicals[level.technicals.size] = level.technical_10;
  thread enemies_alive_watcher(var0, "beam_technical_guys_killed");
  var1 = getvehiclenode("technical_start_10", "targetname");
  level.technical_10 scripts\common\vehicle::attach_vehicle_and_gopath(var1);
  thread sfx_technical_drive_in(level.technical_10, "scn_embassy_technical_10_drive_in");
  wait 1;
  level.technical_10.regenerate = 0;
  level.technical_10 endon("death");
  level.technical_10 vehicle_setspeed(25, 10, 5);

  while(level.technical_10.veh_speed && !scripts\engine\utility::flag("fire_rocket_at_technical")) {
    wait 0.1;
  }

  if(scripts\engine\utility::flag("fire_rocket_at_technical")) {
    level waittill("hellfire_impact");
  }

  level.technical_10.maxhealth = 21000;
  var2 = getEntArray("technical_dudes_10", "targetname");
  var3 = getEnt("interior_main_grounds", "targetname");

  foreach(var5 in var2) {
    var5 setgoalvolumeauto(var3);
    var5 scripts\engine\sp\utility::set_ignoresuppression(0);
    var5 scripts\engine\sp\utility::set_goal_radius(300);
    var5 scripts\engine\sp\utility::set_favoriteenemy(level.price);
    var5 setgoalentity(level.price);
    var5 allowedstances("stand", "crouch");
  }

  if(level.technical_10.health >= 1 && !level.technical_10.veh_speed) {
    level notify("technical_achievement_fail");
    level.technical_10 scripts\common\vehicle::vehicle_lights_off("brakelights");
    return;
  }
}

function wave_6_technical_04() {
  level.technical_04 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_04");
  level.technical_04 scripts\common\vehicle::vehicle_lights_on();
  level.technical_04.maxhealth = 25000;
  level.technical_04 scripts\common\vehicle::godon();
  level.technical_04 setnormalhealth(1);
  level.technicals[level.technicals.size] = level.technical_04;
  var0 = getvehiclenode("technical_start_04", "targetname");
  level.technical_04 scripts\common\vehicle::attach_vehicle_and_gopath(var0);
  wait 1;
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_13");
  level.technical_04 scripts\common\vehicle::godoff();
  level.technical_04.maxhealth = 22000;
  level.technical_04.regenerate = 0;
  level.technical_04 scripts\common\vehicle::vehicle_lights_off();
}

function wave_6_technical_05() {
  level.technical_05 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_05");
  level.technical_05.maxhealth = 25000;
  level.technical_05 setnormalhealth(1);
  level.technical_05 scripts\common\vehicle::godon();
  level.technicals[level.technicals.size] = level.technical_05;
  var0 = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_05");
  var1 = getEnt("technical_dude_gunner_clip_05", "targetname");
  var1.origin += (0, 0, 0);
  var1 linkTo(level.technical_05);
  var0 forceteleport(var1.origin + (0, 0, 0), var0.angles);
  var0 linkTo(var1);
  var0.noragdoll = 1;
  var0 allowedstances("crouch");
  thread gunner_death_watcher(var0);
  var0 scripts\engine\sp\utility::set_favoriteenemy(level.alex);
  var2 = scripts\engine\utility::spawn_script_origin(level.alex.origin + (0, 0, 100));
  var0 setentitytarget(var2, 0.7);
  var3 = getvehiclenode("technical_start_05", "targetname");
  level.technical_05 scripts\common\vehicle::attach_vehicle_and_gopath(var3);
  wait 1;

  if(isDefined(var0)) {
    var0 thread scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq4_defend_battlecry_51");
  }

  while(level.technical_05.veh_speed) {
    wait 0.1;
  }

  level.technical_05 scripts\common\vehicle::godoff();
  level.technical_05 scripts\common\vehicle::vehicle_lights_off("brakelights");
  level.technical_05.maxhealth = 20900;
  level.technical_05.regenerate = 0;

  if(isalive(var0)) {
    var0 clearentitytarget();
    var0 getenemyinfo(level.player);
    var0 allowedstances("crouch", "stand");
    return;
  }
}

function wave_6_technical_06() {
  level.technical_06 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_06");
  level.technical_06 scripts\common\vehicle::vehicle_lights_on();
  level.technical_06.maxhealth = 25000;
  level.technical_06 setnormalhealth(1);
  level.technicals[level.technicals.size] = level.technical_06;
  level.technical_06 scripts\common\vehicle::godon();
  var0 = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_06");
  var1 = getEnt("technical_dude_gunner_clip_06", "targetname");
  var1.origin += (0, 0, 0);
  var1 linkTo(level.technical_06);
  var0 forceteleport(var1.origin + (0, 0, 0), var0.angles);
  var0 linkTo(var1);
  var0.ignoreme = 0;
  var0.noragdoll = 1;
  var0 allowedstances("stand");
  thread gunner_death_watcher(var0);
  var2 = scripts\engine\utility::spawn_script_origin(level.farah.origin + (0, 0, 100));
  var0 setentitytarget(var2, 0.5);
  var3 = getvehiclenode("technical_start_06", "targetname");
  level.technical_06 scripts\common\vehicle::attach_vehicle_and_gopath(var3);
  wait 1;

  while(level.technical_06.veh_speed) {
    wait 0.1;
  }

  level.technical_06 scripts\common\vehicle::godoff();
  level.technical_06.regenerate = 0;
  level.technical_06.maxhealth = 20400;
  level notify("stop_ignoring_player");
  level.technical_06 scripts\common\vehicle::vehicle_lights_off("brakelights");
}

function wave_6_technical_07() {
  level.technical_07 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_07");
  level.technical_07 scripts\common\vehicle::vehicle_lights_on();
  level.technical_07.maxhealth = 25000;
  level.technical_07 setnormalhealth(1);
  level.technical_07 scripts\common\vehicle::godon();
  level.technicals[level.technicals.size] = level.technical_06;
  var0 = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_07");
  var1 = getEnt("technical_dude_gunner_clip_07", "targetname");
  var1.origin += (0, 0, 0);
  var1 linkTo(level.technical_07);
  var0 forceteleport(var1.origin + (0, 0, 0), var0.angles);
  var0 linkTo(var1);
  var0.ignoreme = 0;
  var0.noragdoll = 1;
  var0 allowedstances("crouch");
  thread gunner_death_watcher(var0);
  var2 = getvehiclenode("technical_start_07", "targetname");
  level.technical_07 scripts\common\vehicle::attach_vehicle_and_gopath(var2);
  scripts\engine\sp\utility::trigger_wait_targetname("price_compound_run_trigger_13");
  level.technical_07 scripts\common\vehicle::godoff();
  level.technical_07.regenerate = 0;
  level.technical_07.maxhealth = 20400;
  level.technical_07 scripts\common\vehicle::vehicle_lights_off();
}

function wave_6_technical_08() {
  level.technical_08 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_truck_spawner_08");
  level.technical_08 scripts\common\vehicle::vehicle_lights_on();
  level.technical_08.maxhealth = 25000;
  level.technical_08 setnormalhealth(1);
  level.technicals[level.technicals.size] = level.technical_08;
  level.technical_08 scripts\common\vehicle::godon();
  level.technical_08 endon("death");
  var0 = scripts\engine\sp\utility::spawn_targetname("technical_dude_gunner_08");
  var1 = getEnt("technical_dude_gunner_clip_08", "targetname");
  var1.origin += (-10, 0, 0);
  var1 linkTo(level.technical_08);
  var0 forceteleport(var1.origin + (0, 0, 0), var0.angles);
  var0 linkTo(var1);
  var0.noragdoll = 1;
  var0 allowedstances("stand");
  thread gunner_death_watcher(var0);
  var2 = scripts\engine\utility::spawn_script_origin(level.alex.origin + (0, 0, 100));
  var0 setentitytarget(var2, 0.7);
  var3 = getvehiclenode("technical_start_08", "targetname");
  level.technical_08 scripts\common\vehicle::attach_vehicle_and_gopath(var3);
  wait 1;
  thread wave_6_technical_08_gunner_behavior(var0);

  while(isDefined(level.technical_08) && level.technical_08.veh_speed) {
    wait 0.1;
  }

  level.technical_08 scripts\common\vehicle::godoff();
  level.technical_08.regenerate = 0;
  level.technical_08.maxhealth = 20400;
  level notify("stop_ignoring_player");
  level.technical_08 scripts\common\vehicle::vehicle_lights_off("brakelights");
}

function wave_6_technical_08_gunner_behavior(var0) {
  level waittill("stop_ignoring_player");

  if(isalive(var0)) {
    var0.baseaccuracy = 0.4;
    var0 clearentitytarget();
    var0 getenemyinfo(level.player);
    var0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
    var0 allowedstances("crouch", "stand");
    return;
  }
}

function gunner_death_watcher(var0) {
  self endon("death");
  var0 waittill("death");
  self kill();
}

function shoot_out_field_lights(var0) {
  wait 0.3;

  if(isDefined(var0)) {
    wait 0.1;
  }

  var1 = getscriptablearray("field_light_pole", "script_noteworthy");

  foreach(var3 in var1) {
    var3 dontinterpolate();
    var3.origin = var3.og_origin;
    var3.dummy delete();
  }

  var5 = scripts\engine\utility::getStructArray("perimiter_light_faux_shooters", "targetname");
  var5 = scripts\engine\utility::array_randomize(var5);
  var6 = [];
  var7 = getEnt("field_street_lamps_1", "targetname");
  var7.child = getEnt("field_street_lamps_1_child_1", "targetname");
  var6 = var7;
  var7 = getEnt("field_street_lamps_2", "targetname");
  var7.child = getEnt("field_street_lamps_2_child_1", "targetname");
  var6 = var7;
  var7 = getEnt("field_street_lamps_3", "targetname");
  var7.child = getEnt("field_street_lamps_3_child_1", "targetname");
  var6 = var7;
  var7 = getEnt("field_street_lamps_4", "targetname");
  var7.child = getEnt("field_street_lamps_4_child_1", "targetname");
  var6 = var7;
  scripts\engine\utility::array_thread(var6, &field_light_ondamage);

  if(isDefined(var0)) {
    foreach(var9, var7 in var6) {
      var7 notify("damage");
    }

    return;
  }

  var8 = scripts\engine\utility::array_randomize(var8);
  var10 = 0;

  foreach(var9 in var8) {
    if(isDefined(var9.isdead)) {
      continue;
    }

    if(var10 > var7.size) {
      var10 = 0;
      var7 = scripts\engine\utility::array_randomize(var7);
    }

    var12 = var9 scripts\engine\sp\utility::get_linked_struct();
    thread shoot_out_lights_thread(var9, var7[var10].origin, var12.origin);
    wait randomfloatrange(0.7, 1.5);
    var10++;
  }
}

function field_light_ondamage() {
  self waittill("damage", var0);
  self.isdead = 1;
  self setlightintensity(0);
  self.child setlightintensity(0);

  if(!isDefined(var0)) {
    return;
  }

  var1 = scripts\engine\sp\utility::get_linked_struct();
  var2 = vectortoangles(scripts\engine\utility::flat_origin(var0) - scripts\engine\utility::flat_origin(self.origin)) + (0, 135, 0);
  var3 = anglesToForward(var2);
  radiusdamage(var1.origin, 20, 100, 100, level.player, "MOD_PISTOL_BULLET");
  playFX(scripts\engine\utility::getfx("spark_shower"), var1.origin, var3);
}

function shoot_out_perimeter_lights(var0) {
  wait randomfloatrange(3, 5);
  var1 = getscriptablearray("perimeter_lights", "targetname");
  var2 = scripts\engine\utility::getStructArray("perimiter_light_faux_shooters", "targetname");
  var2 = scripts\engine\utility::array_randomize(var2);

  if(isDefined(var0)) {
    foreach(var5, var4 in var1) {
      var4 setscriptablepartstate("onoff", "off");
    }

    return;
  }

  scripts\engine\utility::flag_wait("wave_1_shoot_out_lights");
  var4 = scripts\engine\utility::array_randomize(var4);
  var6 = 0;

  foreach(var4 in var4) {
    if(isDefined(var4.isdead)) {
      continue;
    }

    if(var6 > var5.size) {
      var6 = 0;
      var5 = scripts\engine\utility::array_randomize(var5);
    }

    thread shoot_out_lights_thread(var4, var5[var6].origin);
    wait randomfloatrange(1, 2);
    var6++;
  }
}

function shoot_out_lights_thread(var0, var1, var2) {
  var3 = randomintrange(2, 3);
  var4 = "iw8_ar_akilo47";
  var5 = scripts\engine\utility::getfx("akilo_muzzle_flash");

  if(!isDefined(var2)) {
    var2 = var0.origin;
  }

  for(var6 = 0; var6 < var3; var6++) {
    var7 = var2 + scripts\engine\utility::randomvectorrange(-40, 40);
    var8 = vectorNormalize(var7 - var1);
    playFX(var5, var1, var8);
    magicbullet(var4, var1, var7);
    wait randomfloatrange(0.05, 0.3);
  }

  if(!isDefined(var0.script_prefab_exploder)) {
    var8 = vectorNormalize(var2 - var1);
    playFX(var5, var1, var8);
  }

  magicbullet(var4, var1, var2);
  wait 0.05;

  if(!isDefined(var0.isdead)) {
    if(isDefined(var0.script_prefab_exploder)) {
      scripts\engine\utility::exploder(var0.script_prefab_exploder);
    }

    var0 notify("damage", var1);
    radiusdamage(var2, 5, 100, 100, undefined, "MOD_PISTOL_BULLET");
  }

  var3 = randomintrange(1, 3);
  var9 = 0.1;

  for(var6 = 0; var6 < var3; var6++) {
    wait randomfloatrange(0.2, 0.4) + var9;
    var9 += randomfloatrange(0.2, 0.4);
    var7 = var2 + scripts\engine\utility::randomvectorrange(-30, 30);
    var8 = vectorNormalize(var7 - var1);
    playFX(var5, var1, var8);
    magicbullet(var4, var1, var7);
  }
}

function perimeter_light_ondeath(var0, var1) {
  var0 waittill("death");
  var0.isdead = 1;

  if(distance2dsquared(level.player.origin, var0.origin) > squared(500)) {
    return;
  }

  var2 = vectortoangles(scripts\engine\utility::flat_origin(level.player.origin) - scripts\engine\utility::flat_origin(var0.origin)) + (0, 135, 0);
  var3 = anglesToForward(var2);
  playFX(scripts\engine\utility::getfx("spark_shower"), var0.origin + (0, 0, 0), var3);
}

function wave_2_enemy_mortar() {
  var0 = [];
  var1 = scripts\engine\utility::getStruct("mortar_wave_1", "targetname");
  var0 = scripts\engine\utility::getStructArray("mortar_array", "targetname");
  level.player_roof_mortars = [];

  foreach(var3 in var0) {
    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "player_roof") {
      level.player_roof_mortars[level.player_roof_mortars.size] = var3;
    }
  }

  scripts\engine\utility::flag_set("enemy_mortar_allow_fire");
  thread enemy_mortar(var1);
  level.enemy_mortar_end = destructible_wall_mortar_end(level.east_wall_01, 1);
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
  var5 = getEnt("slide_trigger_01", "targetname");

  if(var5 istouching(level.player)) {
    level.player disableinvulnerability();
    level.player kill();
  }

  scripts\sp\maps\embassy\embassy_lighting::start_tree_fire_flicker();
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
  var6 = getEnt("roof_mortar_wall_light_2", "targetname");

  if(isDefined(var6)) {
    var6 setlightintensity(0);
  }

  level.east_gate = getEnt("eastgate_clip", "targetname");
  var7 = scripts\engine\utility::getStruct("east_gate_struct", "targetname");
  var7.origin += (-10, 0, 0);
  level.enemy_mortar_end = var7;
  level waittill("mortar_impact");
  var8 = getEnt("east_gate_destroyed", "targetname");

  if(isDefined(var8.target)) {
    var9 = getEntArray(var8.target, "targetname");
    scripts\engine\utility::array_call(var9, &show);
  }

  var8 show();
  scripts\engine\utility::exploder("mortar4");
  var10 = getEnt(level.east_gate.target, "targetname");
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_gate_mortar_impt_01", (316, -107, 102));

  if(isDefined(var10.target)) {
    var9 = getEntArray(var10.target, "targetname");
    scripts\engine\utility::array_delete(var9);
  }

  var10 delete();
  level.east_gate connectpaths();
  level.east_gate delete();
  scripts\engine\utility::flag_set("east_gate_down");
  level.enemy_mortar_end = destructible_wall_mortar_end(level.east_wall_03, 1);
  level waittill("mortar_impact");
  scripts\engine\utility::exploder("mortar5");
  level.east_wall_03[0] notify("destroy");
  level.enemy_mortar_end = destructible_wall_mortar_end(level.east_wall_02, 1, 20);
  level waittill("mortar_impact");
  scripts\engine\utility::exploder("mortar6");
  scripts\engine\utility::exploder("mortar6_tree");
  level.east_wall_02[0] notify("destroy");
  level.enemy_mortar_end = destructible_wall_mortar_end(level.east_wall_04, 1);
  level waittill("mortar_impact");
  scripts\engine\utility::exploder("mortar7");
  level.east_wall_04[0] notify("destroy");
  var11 = spawnStruct();
  var11.origin = (-1564, 1292, 93);
  var11.angles = (0, 0, 0);
  level.enemy_mortar_end = var11;
  level waittill("mortar_impact");
  scripts\engine\utility::exploder("firewall");
  radiusdamage((-1564, 1292, 93), 600, 1000, 1000, level.player);
  scripts\engine\utility::flag_set("perimeter_destroyed");
  level.mortar_round_delay_time = 2.5;
  level.enemy_mortar_end = destructible_wall_mortar_end(level.east_wall_07, 1);
  level waittill("mortar_impact");
  level.east_wall_07[0] notify("destroy");
  var12 = scripts\engine\utility::getStruct("roof_b_wall_struct", "script_noteworthy");
  level.enemy_mortar_end = var12;
  level waittill("mortar_impact");
  var12 notify("destroy");
  var13 = scripts\engine\utility::getStruct("mortar_suv_struct", "script_noteworthy");
  level.enemy_mortar_end = var13;
  level waittill("mortar_impact");
  scripts\engine\utility::flag_set("palm_01_damaged");
  scripts\engine\utility::flag_clear("enemy_mortar_allow_fire");
  thread mortar_locations_watcher();
  wait 3;
  scripts\engine\utility::flag_set("enemy_mortar_allow_fire");
}

function sfx_jumpdown_amb_change() {
  wait 3;
  setaudiotriggerstate("combat_zone", "combat_lvl2", 5);
  setaudiotriggerstate("default", "combat_lvl2", 5);
}

function mus_retreat_cont() {
  wait 2;
  setmusicstate("mx_embassy_retreat_cont");
  scripts\engine\utility::flag_wait("wave_2_end");
  setmusicstate("");
}

function disable_slide_trigger() {
  scripts\engine\utility::delaythread(2, &scripts\engine\utility::trigger_off, "slide_trigger_01", "targetname");
}

function wave_5_enemy_mortar() {
  var0 = [];
  var1 = scripts\engine\utility::getStruct("mortar_wave_4", "targetname");
  var0 = scripts\engine\utility::getStructArray("mortar_array", "targetname");
  var2 = spawnStruct();
  var2.origin = (178.5, 937.5, 21.8);
  level.enemy_mortar_end = var2;
  var1 = scripts\engine\utility::getStruct("mortar_wave_4", "targetname");
  scripts\engine\utility::flag_set("enemy_mortar_allow_fire");
  scripts\engine\utility::flag_clear("mortar_vo_loop");
  thread enemy_mortar_house_mortar_guy(var1, undefined, "mortar_team_2");
  level waittill("mortar_impact");
  thread mortar_locations_watcher();
  scripts\engine\utility::exploder("mortar8");
  level.east_wall_05[0] notify("destroy");
  scripts\engine\utility::flag_set("mortar_vo_loop");
  scripts\engine\utility::flag_clear("enemy_mortar_allow_fire");
  wait 7;
  scripts\engine\utility::flag_set("enemy_mortar_allow_fire");
}

function wave_5_enemy_mortar_replacement() {
  var0 = [];
  var1 = scripts\engine\utility::getStruct("mortar_wave_4", "targetname");
  level.player_roof_mortars = [];
  level.east_wall_mortars = [];
  var2 = spawnStruct();
  var2.origin = (-160, 585, 153);
  level.enemy_mortar_end = var2;
  var1 = scripts\engine\utility::getStruct("mortar_wave_4", "targetname");
  scripts\engine\utility::flag_set("enemy_mortar_allow_fire");
  thread enemy_mortar_house_mortar_guy(var1, undefined, "mortar_team_3");
}

function mortar_locations_watcher() {
  level endon("wave_2_end");
  level endon("wave_6_end");
  var0 = scripts\engine\utility::getStructArray("mortar_array", "targetname");

  for(;;) {
    if(scripts\engine\utility::flag("enemy_mortar_manned")) {
      if(!scripts\engine\utility::flag("wave_6_end")) {
        if(!scripts\engine\utility::flag("mortar_try_kill_player")) {
          var0 = sortbydistance(var0, level.player.origin);
          var1 = int(var0.size / 1.5);
          var2 = int(var0.size / 1.5) + 1;
          var3 = int(var0.size / 1.5) - 1;
          var4 = [var1, var2, var3];
          level.enemy_mortar_end = var0[scripts\engine\utility::random(var4)];
        } else {
          level.enemy_mortar_end = level.player;
        }
      }

      wait 0.25;
      continue;
    }

    break;
  }
}

function wave_3_player_on_roof_watcher() {
  level endon("enemy_mortar_manned");
  var0 = 0;
  var1 = getEnt("building_a_roof_trigger", "targetname");

  for(;;) {
    if(!level.player istouching(var1)) {
      scripts\engine\utility::flag_set("mortar_try_kill_player");
    } else {
      scripts\engine\utility::flag_clear("mortar_try_kill_player");
    }

    wait 0.3;
  }
}

function wave_2_enemy_behavior() {
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

function wave_3_building_enemy_behavior() {
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

function wave_4_street_enemy_behavior() {
  self endon("death");

  if(self.classname == "actor_enemy_alq_desert_dmr") {
    self.disablesniperbehaviors = 1;
  }

  self.attackeraccuracy = 0;
  self.baseaccuracy = 0.5;
  self.grenadeammo = 2;
  self.ignoreall = 1;
  var0 = scripts\engine\utility::get_target_ent();
  scripts\engine\utility::set_movement_speed(80);
  wait 2;
  scripts\engine\utility::flag_wait("street_guys_run");
  scripts\engine\utility::set_movement_speed(250);
  self setgoalnode(var0);
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

function wave_4_corner_enemy_behavior() {
  scripts\engine\utility::flag_set("corner_guys_spawned");
  self endon("death");

  if(self.classname == "actor_enemy_alq_desert_dmr") {
    self.disablesniperbehaviors = 1;
  }

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

function wave_5_street_enemy_behavior() {
  self endon("death");
  self.grenadeammo = 20;
  scripts\engine\sp\utility::set_grenadeweapon("molotov");
  var0 = (1614, 1732, 24);
  var1 = 970;
  self setgoalpos(var0);
  scripts\engine\sp\utility::set_goal_radius(var1);
}

function wave_5_mortar_run_enemy_behavior() {
  self endon("death");
  var0 = getEnt("exterior_north_vol", "targetname");
  self setgoalvolumeauto(var0, level.field_cover_direction);

  if(scripts\engine\utility::flag("mortar_house_field_path")) {
    var0 = getEnt("exterior_north_vol_3", "targetname");
    self setgoalvolumeauto(var0);
    return;
  }
}

function mortar_house_guys_behavior() {
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
    while(!self cansee(level.player)) {
      wait 0.2;
    }

    self clearpath();
    scripts\engine\sp\utility::set_goal_radius(500);
    self setgoalentity(level.player);
    return;
  }
}

function wave_1_technical_enemy_behavior_01() {
  self endon("death");
  self.ignoreme = 1;
  self.attackeraccuracy = 0;
  self setgoalvolumeauto(level.front_goal_vol, level.field_cover_direction);
  level waittill("technical_01_stopped");

  if(scripts\engine\utility::is_equal(self.script_startingposition, 0)) {
    self.allowdeath = 1;
    self.health = 1;
  }

  self.attackeraccuracy = 1;
  wait 1;
  self.ignoreme = 0;
}

function wave_1_technical_gunner_spawn_func() {
  self endon("death");
  self.ignoreme = 1;
  self.secondaryweapon = "none";
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
}

function wave_6_technical_04_enemy_behavior() {
  self endon("death");
  self.attackeraccuracy = 0.5;
  thread wave_6_drivers();
  self waittill("jumpedout");
  var0 = getEnt("interior_grounds_east", "targetname");
  self setgoalvolumeauto(var0);
}

function wave_6_technical_05_enemy_behavior() {
  self endon("death");
  self.attackeraccuracy = 0.3;
  thread wave_6_drivers();
  self waittill("jumpedout");
  var0 = getEnt("interior_grounds_center_wave_6", "targetname");
  self setgoalvolumeauto(var0);
}

function wave_6_technical_06_enemy_behavior() {
  self endon("death");
  thread wave_6_drivers();
  self waittill("jumpedout");
  self.baseaccuracy = 0.1;
  var0 = getEnt("compound_entrance_volume", "targetname");
  self setgoalvolumeauto(var0);
}

function wave_6_technical_07_enemy_behavior() {
  self endon("death");
  self.attackeraccuracy = 0.3;
  thread wave_6_drivers();
  self waittill("jumpedout");
  self.baseaccuracy = 0.1;
  var0 = getEnt("interior_grounds_center_wave_6", "targetname");
  self setgoalvolumeauto(var0);
}

function wave_6_technical_08_enemy_behavior() {
  self endon("death");
  self.attackeraccuracy = 0.3;
  thread wave_6_drivers();
  self.ignoreall = 1;
  self waittill("jumpedout");
  self.baseaccuracy = 0.2;
  var0 = getnodearray("push_inside_path", "targetname");
  var0 = sortbydistance(var0, self.origin);
  scripts\engine\sp\utility::set_goal_radius(65);
  self setgoalnode(var0[0]);
  scripts\engine\utility::waittill_any_timeout(12, "goal");
  self.ignoreall = 0;
  var1 = getEnt("interior_grounds_center_wave_6", "targetname");
  self setgoalvolumeauto(var1);
}

function wave_6_drivers() {
  self endon("death");

  if(scripts\engine\utility::is_equal(self.script_startingposition, 0)) {
    self.ignorerandombulletdamage = 1;
    self.attackeraccuracy = 0;
    self waittill("jumpedout");
    self.ignorerandombulletdamage = 0;
    self.attackeraccuracy = 1;
    return;
  }
}

function wave_4_technical_03_enemy_behavior() {
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

function dialogue_rooftops_approach() {}

function dialogue_rooftops_wave_0() {
  thread dialogue_rooftops_wave_0_shooting_nags();
  thread dialogue_rooftops_wave_0_cafe();
  thread dialogue_distant_threat_callouts();
  thread dialogue_rooftops_wave_0_lights_shot();
}

function dialogue_rooftops_wave_0_cafe() {
  level.player endon("death");
  level endon("firing_down_field");

  if(scripts\engine\utility::flag("firing_down_field")) {
    return;
  }

  thread price_field_nag();
  scripts\engine\utility::flag_wait_all("civ_life_start", "intro_vo_finished");
  var0 = scripts\engine\utility::getStruct("spotter_animstruct", "targetname");

  if(scripts\sp\maps\embassy\embassy_util::wait_lookat_ads_or_timeout(var0, 200, 4)) {
    wait 0.3;
    level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_defend_cafe_10", 1, 1);
  } else {
    wait 0.3;
    level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_cafe_10", 1, 1);
  }

  scripts\engine\utility::flag_set("civ_spotters_start");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_cafe_20", 1);
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_intro_27");
  wait 1;
  var1 = gettime();

  if(scripts\sp\maps\embassy\embassy_util::wait_lookat_ads_or_timeout(var0, 200, 2)) {
    level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_defend_cafe_30", 1);
  } else {
    level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_cafe_30", 1);
  }

  var2 = (gettime() - var1) * 0.001;
  wait max(0, 4 - var2);
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_intro_26", 1);
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_cafe_40", 1);
  wait 1;
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_cafe_41", 1);
  wait 0.2;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_cafe_80", 1);
  wait 0.5;
  var1 = gettime();

  if(scripts\sp\maps\embassy\embassy_util::wait_lookat_ads_or_timeout(var0, 200, 1)) {
    level.player thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_defend_cafe_82", 1);
  } else {
    level.alex thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_cafe_81", 1);
  }

  scripts\engine\utility::flag_wait("table_civs_spooked");
  var2 = (gettime() - var1) * 0.001;
  wait max(0, 3 - var2);
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_cafe_43", 1);
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_cafe_44", 1);
  wait 2.5;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_cafe_46", 1);
  wait 2;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_cafe_47", 1);
  scripts\engine\utility::flag_set("wave_0_start_distant_threat");
  scripts\engine\utility::flag_wait("spawning_unknowns");
}

function dialogue_rooftops_wave_0_shooting_nags() {
  level.player endon("death");
  level endon("wave_1_start");

  for(;;) {
    wait_shot_warning(1);
    level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_cafe_120", 1, 0.8);
    wait_shot_warning();

    if(!scripts\engine\utility::flag("wave_0_start_distant_threat")) {
      level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_cafe_130");
      wait_shot_warning();
    }

    level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_roof_100", 1, 1);
    wait_shot_warning();
    level.hadir scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_had_defend_roof_120", 1, 1);
    scripts\engine\utility::flag_wait("distant_threat_complete");
    wait_shot_warning();
    level.alex thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_roof_190", 1, 1);
    level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_roof_130");
    wait_shot_warning();
    level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_roof_180", 1, 1);
    wait_shot_warning();
    level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_roof_110", 1, 1);
  }
}

function wait_shot_warning(var0) {
  if(!istrue(var0)) {
    wait 2;
  }

  level waittill("firing_down_field");
  wait 0.1;
  scripts\engine\sp\utility::player_dialogue_stop();
  wait 0.3;
  wait scripts\sp\maps\embassy\embassy_util::wait_combat_cooldown(0.4, 1.5);
}

function price_field_nag() {
  level.player endon("death");
  level endon("civ_life_start");

  for(;;) {
    wait 2;
    var0 = (gettime() - level.getsniper_starttime) / 1000;
    wait max(4 - var0, 0);
    level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_roof_64");
    wait 4;
    level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_roof_63");
    wait 3;
    level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_roof_62");
  }
}

function dialogue_distant_threat_callouts() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("spawning_unknowns");
  wait 2;
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_cafe_60", 1);
  wait 4;
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_cafe_70", 1);
  wait 4;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_cafe_72");
}

function dialogue_rooftops_wave_0_lights_shot() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("distant_threat_complete");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_cafe_71");
  wait 1.5;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_cafe_100");
  wait 0.5;
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_cafe_110");
  wait 1;
  scripts\engine\utility::exploder("birdscare");
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_birds_field", (3304, -38, 147));
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_fieldintro_10");
  wait 0.5;
  level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_defend_fieldintro_30");
  wait 2;
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_fieldintro_40");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_fieldintro_50");
  wait 2;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_roof_150");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_roof_160");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_roof_170");
  scripts\engine\utility::flag_set("wave_1_start");
}

function dialogue_rooftops_wave_1() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("wave_1_shoot_out_lights");

  if(!scripts\engine\utility::flag("movement_skipped") && !scripts\engine\utility::flag("wave_1_vo_skipped")) {
    wait 2;
    level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_roof_70");
    wait 0.2;
    level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_roof_80");
    level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_roof_81");
    wait 0.1;
    level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_roof_90");
    wait 0.4;
    level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_roof_140");
    wait 0.5;
    level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_flarestart_21");
    wait 0.4;
    level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_flarestart_41");
  }

  scripts\engine\utility::flag_set("enable_ilumination_flares");
  wait 1;
  var0 = [];
  GscBinSkip0(0x2e, var0.size, [level.price, "dx_vom_pri_defend_flarestart_40"]);
}

function dialogue_rooftops_wave_1_post_flare() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("player_flaring");
  wait 1.5;
  level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_defend_combat2_10", 1);
  scripts\engine\utility::flag_wait("flares_out");
  wait 1;
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_combat1_10");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_combat1_20");
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_combat1_30");
  wait 6;
  level.ally_02_mortar scripts\engine\sp\utility::smart_dialogue("dx_vom_us2_defend_combat1_40");
  wait 2.5;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_combat1_50");
  scripts\engine\utility::flag_waitopen("flares_out");
  wait 1;
  thread dialogue_wave_1_flare_2_chatter();
  scripts\engine\utility::flag_wait_any("player_flaring", "flare_2_skipped");

  if(!scripts\engine\utility::flag("flare_2_skipped")) {
    wait 2.3;
    level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_defend_flarestart_71");
    scripts\engine\utility::flag_wait("flares_out");
    wait 1;
    level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_combat2_20");
    level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_combat2_30");
    level.hadir scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_had_defend_combat2_40");
    level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_taunt_30");
    scripts\engine\utility::flag_waitopen("flares_out");
    thread dialogue_wave_1_flare_3_chatter();
  }

  wait 1.8;
  scripts\engine\utility::flag_wait_any("player_flaring", "flare_2_skipped");

  if(!scripts\engine\utility::flag("flare_2_skipped")) {
    wait 1.8;
    level.player thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_defend_flarestart_70", 1, 0.3);
    scripts\engine\utility::flag_wait("flares_out");
    thread dialogue_last_flare();
  } else {
    wait 6;
  }

  wait 0.5;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_combat3_40");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_combat3_30");
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_combat3_50");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_combat3_60");
  scripts\engine\utility::flag_wait("wave_1_falling_back");
  wait 4;
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_combat1_50");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_combat1_51");
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_trucks_20");
  wait 0.5;
  scripts\engine\utility::flag_set("wave_1_vo_finished");
}

function dialogue_last_flare() {
  scripts\engine\utility::flag_waitopen("player_flaring");
  scripts\engine\utility::flag_wait("player_flaring");
  wait 1.2;
  level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_defend_combat3_10", 1);
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_combat3_20", 1);
}

function dialogue_wave_1_flare_2_chatter() {
  level.player endon("death");
  level endon("player_flaring");
  level endon("wave_1_falling_back");
  wait 1;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_chatter_10");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_chatter_11");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_chatter_12");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_chatter_13");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_chatter_14");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_chatter_15");
  wait 3;
  thread flarenag();
}

function flarenag() {
  level endon("wave_1_falling_back");

  if(!isDefined(level.flarenags)) {
    var0 = [];
    GscBinSkip0(0x2e, var0.size, [level.farah, "dx_vom_far_defend_grounds_101"]);
  }

  scripts\sp\maps\embassy\embassy_util::nagtill("player_flaring", level.flarenags);
}

function dialogue_wave_1_flare_3_chatter() {
  level.player endon("death");
  level endon("flares_out");
  level endon("player_flaring");
  level endon("wave_1_falling_back");
  wait 1;
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_chatter_20");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_chatter_21");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_chatter_22");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_chatter_23");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_chatter_24");
  flarenag();
}

function dialogue_rooftops_wave_2() {
  level.player endon("death");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_trucks_21");
  wait 1;
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_trucks_22");
  level.ally_01_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_trucks_23");
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_trucks_24");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_trucks_31");
  level notify("round_count_done");
  scripts\engine\utility::flag_wait("player_looking_toward_trucks");
  wait 7;
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_trucks_40");
  wait 0.5;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_trucks_50");
  wait 1;
  level.ally_02_mortar scripts\engine\sp\utility::smart_dialogue("dx_vom_us2_defend_trucks_80");
  wait 0.5;
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_trucks_70");
  scripts\engine\utility::flag_wait("trucks_stopped");
}

function dialogue_rooftops_wave_2_mortars() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("enemy_mortar_launched");
  wait 1;
  level.farah thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_mortars_20", 1);
  scripts\engine\utility::flag_waitopen("enemy_mortar_launched");
  scripts\engine\utility::flag_wait("enemy_mortar_launched");
  wait 0.5;
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_mortars_40", 1);
  level.ally_02_mortar thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_mortars_50", 1);
  level waittill("mortar_impact");
  wait 1;
  level.ally_02_mortar thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_mortars_60");
  var0 = lookupsoundlength("dx_vom_us2_defend_mortars_60") / 1000;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_mortars_70", 1, var0 - 0.3);
  thread off_the_roof_nags();
  wait 1;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_grounds_10", 1);
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_grounds_20", 1);
  scripts\engine\utility::flag_wait("east_gate_down");
  wait 2;
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_grounds_60");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_grounds_70");
  scripts\engine\utility::flag_wait("perimeter_breached");
  wait 4;
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_grounds_110");
  level.ally_02_mortar scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_grounds_120");
}

function nag_near_wall() {
  wait 10;
  var0 = getEnt("push_fallback_trigger", "targetname");
  var1 = ["dx_vom_pri_defend_grounds_150", "dx_vom_pri_defend_grounds_130", "dx_vom_pri_defend_grounds_140"];
  var2 = scripts\engine\sp\utility::create_deck(var1, 0);
  var2.autoshuffle = 1;

  for(;;) {
    while(!level.player istouching(var0) || getaiarray("axis").size <= 4) {
      scripts\engine\utility::waittill_any_ents(var0, "trigger", level, "ai_killed");
    }

    level.price childthread scripts\sp\maps\embassy\embassy_util::nagtill("away_from_wall", var2, 5, 1.6, 20);

    while(level.player istouching(var0) && getaiarray("axis").size > 4) {
      waitframe();
    }

    level notify("away_from_wall");
  }
}

function off_the_roof_nags() {
  level.player endon("death");
  level endon("perimeter_breached");
  var0 = ["dx_vom_pri_defend_mortars_80", "dx_vom_pri_defend_mortars_90", "dx_vom_pri_defend_mortars_100"];
  var1 = scripts\engine\sp\utility::create_deck(var0);
  init_building_flags();
  wait 5;
  level.alex scripts\sp\maps\embassy\embassy_util::nagtill_open("player_on_south_building", var1, 6.5, 1.2, 20, 1.5);
}

function dialogue_drag_scene() {
  level endon("wave_2_end");
  wait 3;
  level.ally_03 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us3_defend_mandown_10", 1);
  level.ally_04 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_mandown_20", 1);
  level.ally_03 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us3_defend_mandown_30", 1);
  level.ally_04 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_mandown_40", 1);
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_mandown_50", 1);
  wait 1;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_mandown_51", 1);
  wait 1;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_grounds_140");
  wait 0.3;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_grounds_101");
  GscBinSkip4(0x35);
}

function dialogue_rooftops_wave_3() {
  level.player endon("death");
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_resupply_10");
  thread scripts\engine\utility::flag_set_delayed("triage_watcher_start", 0.6);
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_resupply_20");
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_resupply_30");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_resupply_40");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_resupply_43");
  resupply_nag();
  wait 0.5;
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_triage_30");
  wait 3;
  level.barracks_civ scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm1_topfloor_office_240");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_resupply_110");
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_resupply_120");
  wait 0.2;
  level.player scripts\sp\maps\embassy\embassy_util::say("dx_vom_kyle_defend_resupply_130");
  wait 1;
  level scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_uavoperator_defend_resupply_41");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_resupply_42");
  wait 1.5;
  level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_intro_10");
  wait 0.4;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_intro_20");
  wait 0.3;
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_resupply_90");

  if(!scripts\engine\utility::flag("green_beam_acquired")) {
    level scripts\engine\utility::waittill_either("price_triage_nag", "green_beam_acquired");
  }

  var0 = ["dx_vom_pri_defend_resupply_140", "dx_vom_pri_defend_resupply_150", "dx_vom_pri_defend_resupply_160"];
  level.price scripts\sp\maps\embassy\embassy_util::nagtill("green_beam_acquired", var0, "price_triage_nag");
  wait 1;
  scripts\engine\utility::flag_wait("wave_3_inside");
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_building_fight_20", 1);
  wait 1;
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_building_fight_10", 1);
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_building_fight_20");
  wait 2;

  if(!level.player isonladder()) {
    level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_building_fight_30");
    return;
  }
}

function resupply_nag() {
  if(scripts\engine\utility::flag("triage_scene_started")) {
    return;
  }

  level endon("triage_scene_started");
  wait 6;
  var0 = ["dx_vom_pri_defend_resupply_50", "dx_vom_pri_defend_resupply_60", "dx_vom_pri_defend_resupply_70"];
  level.price scripts\sp\maps\embassy\embassy_util::nagtill("triage_scene_started", var0, 5);
}

function get_on_north_roof_nag(var0) {
  init_building_flags();

  if(scripts\engine\utility::flag("wave_3_end")) {
    return;
  }

  level endon("wave_3_end");
  var1 = [];
  GscBinSkip0(0x2e, var1.size, [level.price, "dx_vom_pri_defend_building_fight_10"]);
}

function dialogue_rooftops_wave_3_building() {
  thread get_on_north_roof_nag();
  scripts\engine\utility::flag_wait("player_on_north_building");
  scripts\engine\utility::flag_wait("allow_green_beam");
  level endon("allow_green_beam");
  GscBinSkip4(0x35);
}

function vo_beam_confirms() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_kyle_defend_greenbeam1_110");
}

function vo_beam_hit() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_uavoperator_defend_greenbeam1_190");
}

function vo_beam_ally_close() {
  var0 = ["dx_vom_uavoperator_uav_close_10", "dx_vom_uavoperator_uav_close_20", "dx_vom_uavoperator_uav_close_30"];
  var1 = scripts\engine\sp\utility::create_deck(var0);

  for(;;) {
    level waittill("green_beam_error");

    if(level.player.greenbeamerror == "allies_too_close") {
      level scripts\sp\maps\embassy\embassy_util::say_as_chatter(var1 scripts\engine\sp\utility::deck_draw(), 0, 1);
    }
  }
}

function vo_beam_nomark() {
  var0 = ["dx_vom_uavoperator_uav_nomark_10", "dx_vom_uavoperator_uav_nomark_20", "dx_vom_uavoperator_uav_nomark_30"];
  var1 = scripts\engine\sp\utility::create_deck(var0);

  for(;;) {
    level waittill("green_beam_error");

    if(level.player.greenbeamerror == "hit_none") {
      level scripts\sp\maps\embassy\embassy_util::say_as_chatter(var1 scripts\engine\sp\utility::deck_draw(), 0, 1);
    }
  }
}

function vo_beam_negative() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_uavoperator_defend_greenbeam1_280");
}

function vo_beam_cooldown() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_uavoperator_uav_reload_10");
}

function drone_nags_enable(var0) {
  scripts\engine\utility::flag_clear("disable_drone_nags");
  thread vo_use_beam_nags();

  if(isDefined(var0)) {
    wait var0;
  }

  if(!scripts\engine\utility::flag("laser_marker_on")) {
    scripts\engine\utility::flag_set("drone_instructions");
    return;
  }
}

function drone_nags_disable() {
  scripts\engine\utility::flag_set("disable_drone_nags");
}

function vo_use_beam_nags(var0) {
  level endon("beam_down");
  level endon("allow_green_beam");
  level endon("disable_drone_nags");

  if(scripts\engine\utility::flag("disable_drone_nags")) {
    return;
  }

  if(isDefined(var0)) {
    wait var0;
  }

  for(;;) {
    scripts\engine\utility::flag_waitopen("hellfire_launched");
    vo_use_beam_nag();
    check_add_beam_nags();
  }
}

function vo_use_beam_nag() {
  level endon("hellfire_launched");
  check_init_beam_nags();
  wait 15;

  if(getaiarray("axis").size == 0) {
    return;
  }

  scripts\engine\utility::flag_set("drone_instructions");
  childthread scripts\sp\maps\embassy\embassy_util::nagtill("stop_beam_nags", level.beam_nags, 12, 1.3, 20);

  while(getaiarray("axis").size > 0) {
    level waittill("ai_killed");
  }

  level notify("stop_beam_nags");
}

function check_init_beam_nags() {
  if(!isDefined(level.beam_nags)) {
    var0 = [];
    GscBinSkip0(0x2e, var0.size, [level.price, "dx_vom_pri_defend_greenbeam1_40"]);
  }

  if(scripts\engine\utility::flag("wave_3_end") && !istrue(level.beam_nags.removed_building_lines)) {
    var1 = ["dx_vom_pri_defend_greenbeam1_70", "dx_vom_alx_defend_greenbeam1_80", "dx_vom_alx_defend_greenbeam1_100", "dx_vom_far_defend_greenbeam1_330"];
    var2 = [];

    foreach(var4 in level.beam_nags.items) {
      if(!scripts\engine\utility::array_contains(var1, var4[1])) {
        var2 = var4;
      }
    }

    level.beam_nags.items = var2;

    if(level.beam_nags scripts\engine\sp\utility::deck_is_empty()) {
      level.beam_nags scripts\sp\maps\embassy\embassy_util::array_deck_shuffle();
    }

    level.beam_nags.removed_building_lines = 1;
    return;
  }
}

function check_add_beam_nags() {
  if(scripts\engine\utility::flag("hellfire_launched") && !istrue(level.beam_nags.added_lines)) {
    var0 = [];
    GscBinSkip0(0x2e, var0.size, [level.farah, "dx_vom_far_defend_greenbeam1_310"]);
  }
}

function dialogue_rooftops_wave_4() {
  scripts\sp\maps\embassy\embassy_util::wait_combat_cooldown(1.2, 4);
  level endon("civ_car_death");
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_greenbeam2_10");
  wait 2;
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_greenbeam2_150");
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_greenbeam2_160");
  wait 2;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_greenbeam2_40");
  level notify("move_east");
  level waittill("civ_car_spawn");
  level.civ_car endon("driver_death");
  level.civ_car endon("damage");
  wait 7;
  level.alex thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_civcar_10");
  wait 3;
  level.hadir thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_had_defend_civcar_20");
  wait 1.5;

  if(distance2dsquared(level.player.origin, level.hadir.origin) < squared(1300)) {
    level.player thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_defend_civcar_30");
  }

  wait 2.5;
  level.hadir thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_had_defend_civcar_40");
  wait 5;
  level.farah thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_civcar_50");
  wait 1;
  level.alex thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_civcar_60");
  wait 13;
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_civcar_70");
  level notify("civ_car_gone");
}

function dialogue_rooftops_wave_4_technicals() {
  level endon("wave_4_end");
  drone_nags_enable(5);
  scripts\engine\utility::flag_set("wave_4_technicals");
  level thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_uavoperator_defend_greenbeam2_20");
  wait 2;
  level notify("drone_callout");
  thread monitor_enemies_enter_perimeter();
  wait 0.5;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_greenbeam2_30");
  wait 2;
  scripts\engine\utility::flag_wait("street_guys_run");

  if(scripts\engine\sp\utility::getvehiclearray().size > 0) {
    level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_greenbeam2_120");
  } else {
    wait 1;
  }

  wait 1;
  level.farah thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_defend_greenbeam2_60");
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_greenbeam2_50");
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_defend_greenbeam2_70");
  scripts\engine\utility::flag_wait("wave_4_final_technical_spawn");
  wait 3;

  while(!get_vehicles_in_field().size) {
    waitframe();
  }

  level.hadir scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_had_defend_greenbeam2_80");
  wait 0.5;
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_greenbeam2_90");
}

function get_vehicles_in_field() {
  var0 = getEnt("field_cleanup_vol", "targetname");
  var1 = getEnt("player_warn_trigger", "targetname");
  var2 = scripts\engine\sp\utility::getvehiclearray();
  var3 = [];

  foreach(var5 in var2) {
    if(var5 istouching(var0) && var5 istouching(var1)) {
      var3 = var5;
    }
  }

  return var3;
}

function monitor_enemies_enter_perimeter() {
  level endon("wave_4_end");
  var0 = getEnt("interior_main_grounds", "targetname");
  var1 = 0;

  while(!var1) {
    var2 = getaiarray("axis");

    if(var2.size == 0) {
      waitframe();
      continue;
    }

    foreach(var4 in var2) {
      waitframe();

      if(!isalive(var4)) {
        continue;
      }

      if(var4 istouching(var0)) {
        var1 = 1;
        break;
      }
    }
  }

  level.alex scripts\engine\sp\utility::smart_dialogue("dx_vom_alx_defend_greenbeam2_140");
  thread audio_defend_4_perimeter_zone_state();
}

function audio_defend_4_perimeter_zone_state() {
  level endon("wave_4_end");
  setaudiotriggerstate("combat_zone", "combat_lvl2", 1);
  setaudiotriggerstate("default", "combat_lvl2", 1);
  wait 15;
  setaudiotriggerstate("combat_zone", "combat_lvl1", 3);
  setaudiotriggerstate("default", "combat_lvl1", 3);
}

function dialogue_rooftops_wave_5() {
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
  level.ally_05 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_mortar_building_90");
  level.ally_06 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_mortar_building_100");
  thread dialogue_wave_5_marines();
  nag_say_with_hadir();
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_defend_mortar_building_180");
}

function nag_say_with_hadir() {
  if(scripts\engine\utility::flag("player_pushing_house")) {
    return;
  }

  level endon("player_pushing_house");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, [level.alex, "dx_vom_alx_defend_mortar_building_110"]);
}

function dialogue_wave_5_marines() {
  scripts\engine\utility::flag_wait("player_pushing_house");
  level.ally_05 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us1_defend_mortar_building_140");
  wait 1;

  if(getaiarray("axis").size < 3) {
    return;
  }

  level.ally_06 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_us2_defend_mortar_building_150");

  if(!isalive(level.ally_06)) {
    return;
  }

  level.ally_05 waittill("death");
  wait 0.4;
  level.ally_05 scripts\engine\sp\utility::smart_dialogue("dx_vom_us1_defend_mortar_building_170");
}

function player_pushing_house_watcher() {
  if(scripts\engine\utility::flag("wave_5_fall_back")) {
    scripts\engine\utility::flag_set("player_pushing_house");
    return;
  }

  level scripts\engine\utility::thread_on_notify("wave_5_fall_back", &scripts\engine\utility::flag_set, "player_pushing_house");
  level endon("wave_5_fall_back");
  var0 = getEnt("price_mortar_run_trigger_02", "targetname");
  scripts\engine\sp\utility::trigger_wait("price_mortar_run_trigger_02", "targetname");
  scripts\engine\utility::flag_set("player_pushing_house");
}

function dialogue_rooftops_wave_6() {
  level.player endon("death");
  level endon("cleared_residence");
  wait 0.3;
  scripts\sp\maps\embassy\embassy_util::wait_combat_cooldown(0.8, 4);
  level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_defend_mortar_interior_110");
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_defend_mortar_interior_115");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_defend_mortar_interior_120");
  wait_hadir_goal_or_flag("player_leaving_mortar_house");
  var0 = ["dx_vom_had_wolf_escapes_combat_30", "dx_vom_had_wolf_escapes_combat_40", "dx_vom_had_wolf_escapes_combat_50"];
  level.hadir scripts\sp\maps\embassy\embassy_util::nagtill("player_leaving_mortar_house", var0);
  wait 0.8;
  level.hadir scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_had_wolf_escapes_combat_60");
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_wolf_escapes_combat_60");
  wait 4;
  level.farah scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_far_wolf_escapes_combat_70");
  wait 4;
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_wolf_escapes_combat_80");
  level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_wolf_escapes_combat_85");
  wait 4;
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_wolf_escapes_combat_90");
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_wolf_escapes_combat_110");
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_wolf_escapes_combat_120");
  wait 4;
  level.alex scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_alx_wolf_escapes_combat_100");
  level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_wolf_escapes_combat_125");
  level.price scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_wolf_escapes_combat_130");
  wait 6;
  var1 = [];
  GscBinSkip0(0x2e, var1.size, "dx_vom_pri_wolf_escapes_combat_131");
}

function wait_hadir_goal_or_flag(var0) {
  if(scripts\engine\utility::flag(var0)) {
    return;
  }

  level endon(var0);
  wait 2;
  level.hadir waittill("goal");
  wait 2;
}

function enemy_flare_behavior() {
  self endon("death");
  scripts\engine\utility::ent_flag_wait("flared");

  if(!scripts\engine\utility::flag("front_2")) {
    wait 1;
    scripts\engine\utility::reacttolightifpossible(level.flare_light.origin);
  }

  while(self.flare_timer > 0) {
    self.attackeraccuracy = 1;
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

function enemy_flare_behavior_wave_3() {
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
  } else {
    self.attackeraccuracy = 1;
  }

  self.baseaccuracy = 0.1;
}

function haze_watcher() {
  var0 = getEntArray("haze", "targetname");

  foreach(var2 in var0) {
    var2 hide();
  }

  var4 = 1;
  var5 = 0.7;
  var6 = 0.999;
}

function enemy_mortar(var0) {
  level endon("wave_2_end");
  scripts\engine\utility::flag_set("enemy_mortar_manned");
  scripts\engine\utility::flag_wait("enemy_mortar_allow_fire");

  if(isDefined(var0)) {
    thread dx_mortar_launch_callout(var0.origin);
  } else {
    thread dx_mortar_launch_callout((2828, 100, 30));
  }

  wait 0.25;
  enemy_mortar_launch(var0);
  wait level.mortar_round_delay_time;
  thread enemy_mortar(var0);
}

function enemy_mortar_house_mortar_guy(var0, var1, var2) {
  if(!isDefined(var1)) {
    var3 = getspawner(var2, "targetname");
    var1 = var3 scripts\engine\sp\utility::spawn_ai(1);
    var1.ignoreall = 1;
    var1.ignoreme = 1;
    var1.health = 10;
    var1.animname = "aq_mortar";
    var1.allowdeath = 1;
    var1 scripts\sp\utility::context_melee_allow(0);
    scripts\engine\utility::flag_set("enemy_mortar_manned");
  }

  thread hide_shield_mortar_guy();
  scripts\engine\utility::flag_wait("enemy_mortar_allow_fire");

  if(!isalive(var1)) {
    scripts\engine\utility::flag_clear("enemy_mortar_manned");
    return;
  }

  enemy_mortar_animations(var1, var0);
  scripts\engine\utility::flag_clear("enemy_mortar_manned");
}

function enemy_mortar_animations(var0) {
  self endon("death");
  self endon("mortar_guy_breakout");
  var1 = getEnt("flare_mortar_tube_enemy", "targetname");
  self allowedstances("crouch");
  var1 scripts\engine\sp\utility::assign_animtree("enemy_mortar");
  var1 scripts\common\anim::anim_first_frame_solo(var1, "flare_enter_aq");
  var1 scripts\sp\anim::anim_reach_solo(self, "flare_enter_aq");
  var1 scripts\common\anim::anim_single([var1, self], "flare_enter_aq");
  thread mortar_guy_mortar_death(var1);
  thread mortar_guy_breakout(var1);
  thread mortar_tube_collapse(var1);

  for(;;) {
    level.mortar_round_delay_time = randomfloatrange(10, 12.5);

    if(isDefined(var0)) {
      thread dx_mortar_launch_callout(var0.origin);
    } else {
      thread dx_mortar_launch_callout((2828, 100, 30));
    }

    wait 0.25;
    var1 thread scripts\common\anim::anim_single([var1, self], "flare_launch_aq");
    wait getanimlength(scripts\engine\utility::getanim("flare_launch_aq")) - 0.5;
    level notify("mortar_launch");
    thread enemy_mortar_launch(var0);
    var1 scripts\common\anim::anim_single([var1, self], "flare_reload_aq");
    var1 thread scripts\common\anim::anim_loop([var1, self], "flare_aq_idle", "stop_loop");
    wait level.mortar_round_delay_time;

    if(!scripts\engine\utility::flag("enemy_mortar_allow_fire")) {
      scripts\engine\utility::flag_wait("enemy_mortar_allow_fire");
    }

    var1 notify("stop_loop");
  }
}

function mortar_guy_mortar_death(var0) {
  self endon("death");
  self endon("mortar_guy_breakout");
  self.allowdeath = 1;
  scripts\engine\utility::flag_wait("mortar_guy_breakout_watcher");

  if(!isalive(self)) {
    return;
  }

  scripts\engine\sp\utility::set_deathanim("mortar_guy_death");
  self waittill("death");
  var0 notify("collapse_mortar");
}

function mortar_guy_bullet_shield() {
  if(scripts\engine\utility::flag("house_enter_low_delay")) {
    return;
  }
}

function hide_shield_mortar_guy() {
  if(scripts\engine\utility::flag("mortar_house_perimeter")) {
    return;
  }

  self hide();
  scripts\common\ai::magic_bullet_shield(1);
  scripts\engine\sp\utility::trigger_wait("mortar_house_grounds_trigger", "targetname");
  self show();
  scripts\common\ai::stop_magic_bullet_shield();
}

function mortar_guy_breakout(var0) {
  self endon("death");
  scripts\engine\utility::flag_wait("mortar_guy_breakout_watcher");
  var1 = getnode("mortar_guy_roof_node", "targetname");

  if(!isalive(self)) {
    return;
  }

  thread damage_on_rooftop_enter();
  thread rooftop_enter_watcher();
  self allowedstances("crouch");
  scripts\engine\utility::waittill_any("damage", "bulletwhizby");
  var0 notify("stop_loop");
  wait 0.2;
  self notify("mortar_guy_breakout");
  self.ignoreall = 0;
  self getenemyinfo(level.player);
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  self setgoalnode(var1);
  thread scripts\sp\spawner::go_to_node(var1);
  self allowedstances("crouch");
  self.ignoreme = 0;
  self setgoalpos(self.origin);
  scripts\engine\sp\utility::set_goal_radius(64);
  scripts\engine\sp\utility::clear_deathanim();
  var0 notify("stop_loop");
  waitframe();
  var0 thread scripts\common\anim::anim_single_solo(self, "flare_exit_aq");
  wait 0.75;
  self getenemyinfo(level.player);
  self allowedstances("crouch", "stand");
  var0 notify("collapse_mortar");
  var0 hidepart(var0.shell, "misc_wm_mortar");
  self stopanimScripted();

  for(;;) {
    self getenemyinfo(level.player);
    scripts\engine\sp\utility::set_favoriteenemy(level.player);
    wait 0.1;
  }
}

function player_info() {}

function mortar_tube_collapse(var0) {
  scripts\engine\utility::flag_wait("mortar_guy_breakout_watcher");
  var0 waittill("collapse_mortar");
  var0 stopanimScripted();
  var0 notify("stop_loop");
  var0 scripts\common\anim::anim_single([var0], "mortar_guy_death");
}

function rooftop_enter_watcher() {
  scripts\engine\sp\utility::trigger_wait_targetname("price_mortar_run_trigger_08");
  scripts\engine\utility::flag_set("rooftop_enter");
}

function damage_on_rooftop_enter() {
  self endon("death");
  scripts\engine\utility::flag_wait("rooftop_enter");
  self notify("damage");
}

function dx_mortar_launch_callout(var0) {
  var1 = undefined;
  var2 = undefined;

  if(!isDefined(level.mortar_vo_ints)) {
    level.mortar_vo_ints = scripts\engine\sp\utility::create_deck([0, 1, 2]);
  }

  var3 = level.mortar_vo_ints scripts\engine\sp\utility::deck_draw();

  switch (var3) {
    case 0:
      var1 = "dx_vom_aq1_mortar_fire_10";
      var2 = "dx_vom_aq1_mortar_fire_10_dist";
      break;
    case 1:
      var1 = "dx_vom_aq1_mortar_fire_20";
      var2 = "dx_vom_aq1_mortar_fire_20_dist";
      break;
    default:
      var1 = "dx_vom_aq1_mortar_fire_30";
      var2 = "dx_vom_aq1_mortar_fire_30_dist";
      break;
  }

  thread scripts\engine\utility::play_sound_in_space(var1, var0);
  thread scripts\engine\utility::play_sound_in_space(var2, var0);
}

function enemy_mortar_launch(var0) {
  scripts\engine\utility::flag_set("enemy_mortar_launched");
  thread scripts\engine\sp\utility::flag_clear_delayed("enemy_mortar_launched", 3);
  var1 = 3000;
  var2 = 3.25;
  var3 = spawnStruct();
  var3.origin = (5551, -851, 150);

  if(scripts\engine\utility::flag("wave_4_end")) {
    var4 = getEnt("flare_mortar_tube_enemy", "targetname");
    var3.origin = var4 gettagorigin("j_shaft_top");
  }

  var5 = spawnStruct();
  var5.origin = level.enemy_mortar_end.origin;
  var6 = scripts\engine\trace::ray_trace(var5.origin + (0, 0, 600), var5.origin);
  var5.origin = var6["position"];

  if(getdvarint("scr_mortar_gravity")) {
    var7 = distance(var3.origin, var5.origin);
    var2 = var7 / var1 * var2;
  }

  var8 = scripts\engine\utility::spawn_tag_origin(var3.origin, (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_smktrail_mortar"), var8, "tag_origin");
  var9 = "vfx_emb_flash_mortar";

  if(scripts\engine\utility::flag("wave_4_end")) {
    var9 = "vfx_emb_flash_mortar_2";
  }

  if(!scripts\engine\utility::flag("mortar_house_perimeter")) {
    playFX(scripts\engine\utility::getfx(var9), var3.origin);
  }

  if(distance2d(level.player.origin, var3.origin) < 400) {
    earthquake(0.1, 2, var3.origin, 2000);
    level.player playRumbleOnEntity("damage_light");
  }

  wait 0.1;
  level.player playRumbleOnEntity("damage_heavy");
  var8 thread scripts\engine\utility::playsoundontag("weap_mortar_fire_dist", "tag_origin");
  var8 playLoopSound("weap_mortar_fly_lp");
  var10 = max(0.05, var2 - 1.7);
  var8 scripts\engine\utility::delaythread(var10, &scripts\engine\utility::playsoundontag, "weap_mortar_incoming", "tag_origin");
  movemortar(var8, var3.origin, var5.origin, var2);
  level notify("mortar_impact");
  var8 stoploopsound("weap_mortar_fly_lp");
  var8 delete();
  radiusdamage(var5.origin, 500, 1, 1);
  earthquake(0.4, 1.5, var5.origin, 2000);
  playrumbleonposition("damage_heavy", level.player.origin);
  playFX(scripts\engine\utility::getfx("vfx_mortar_explosion"), var5.origin);
  var7 = distance(level.player.origin, var5.origin);

  if(300 > distance(level.player.origin, var5.origin)) {
    if(level.player.origin[2] + 100 > var5.origin[2]) {
      level.player scripts\engine\utility::delaycall(0.75, &shellshock, "default", 1);
    }
  }

  if(level.enemy_mortar_end == level.second_roof_struct) {
    level.player enableinvulnerability();
    playrumbleonposition("damage_heavy", level.player.origin);
    magicgrenademanual("mortar", var5.origin + (0, 0, 5), (0, 0, 0), 0.05);
    level.player scripts\engine\utility::delaycall(1, &disableinvulnerability);
    return;
  }

  magicgrenademanual("mortar", var5.origin + (0, 0, 5), (0, 0, 0), 0.05);
}

function movemortar(var0, var1, var2, var3, var4) {
  setdvarifuninitialized("scr_mortar_gravity", "0 ");

  if(getdvarint("scr_mortar_gravity")) {
    var0.origin = var1;
    var5 = getdvarint("NPOQPMP");
    var6 = distance(var1, var2);
    var7 = var2 - var1;
    var8 = 0.5 * var5 * squared(var3) * -1;
    var9 = (var7[0] / var3, var7[1] / var3, (var7[2] - var8) / var3);
    var0 movegravity(var9, var3);
    var10 = gettime() + var3 * 1000;

    while(gettime() < var10) {
      anglemortar(var0);
      waitframe();
    }

    return;
  }

  var11 = 1200;

  if(isDefined(var4)) {
    var11 = var4;
  }

  var12 = 1 / var3 / 0.05;
  var13 = 0;

  while(var13 < 1) {
    var0.origin = scripts\engine\math::get_point_on_parabola(var1, var2, var11, var13);
    anglemortar(var0);
    var13 += var12;
    wait 0.05;
  }

  var0.origin = var2;
}

function anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

function illumination_mortars_init() {
  level.intro_mortar_tube = undefined;
  var0 = getEntArray("flare_mortar_tube", "targetname");

  foreach(var2 in var0) {
    if(scripts\engine\utility::is_equal(var2.script_noteworthy, "east")) {
      level.intro_mortar_tube = var2;
      illumination_mortars(var2);
    }
  }
}

function illumination_mortars_friendly_init() {
  level.support_mortar_tube = undefined;
  var0 = getEntArray("flare_mortar_tube", "targetname");

  foreach(var2 in var0) {
    if(var2.script_noteworthy == "north") {
      level.support_mortar_tube = var2;
      var3 = getEnt("friendly_mortar_clip", "targetname");
      var3 linkTo(level.support_mortar_tube);
      var4 = getEntArray("friendly_mortar_ammo", "targetname");

      foreach(var6 in var4) {
        var6 linkTo(level.support_mortar_tube);
      }

      level.support_mortar_tube.angles += (0, -15, 0);
      illumination_mortar_friendly(var2);
    }
  }
}

function destroy_first_roof_mortar() {
  level waittill("mortar_impact");
  var0 = getEntArray("flare_mortar_tube", "targetname");

  foreach(var2 in var0) {
    if(var2.script_noteworthy == "east") {
      var2 scripts\sp\player\cursor_hint::remove_cursor_hint();

      if(isDefined(var2.interact)) {
        var2.interact delete();
      }

      var2 delete();
    }
  }

  var4 = getEntArray("mortar_delete", "targetname");
  scripts\engine\utility::array_delete(var4);
  var5 = getscriptablearray("perimeter_lights", "targetname");
  var6 = [];
  GscBinSkip0(0x2e, 0, (31.6, -541.2, 178));
}

function special_delay_hide() {
  wait 0.1;
  self hide();
}

function stop_illumination_mortars_thread() {
  self endon("trigger");
  scripts\engine\utility::flag_wait("stop_player_flare_mortar");
  scripts\sp\player\cursor_hint::remove_cursor_hint();
  level notify("stop_illumination_mortars");
}

function illumination_mortars() {
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
  var0 = undefined;
  var1 = scripts\engine\utility::get_target_array();
  var2 = undefined;

  switch (level.flare_counter) {
    case 4:
      var2 = &"EMBASSY/LAUNCH_FLARE_4";
      break;
    case 3:
      var2 = &"EMBASSY/LAUNCH_FLARE_3";
      break;
    case 2:
      var2 = &"EMBASSY/LAUNCH_FLARE_2";
      break;
    case 1:
      var2 = &"EMBASSY/LAUNCH_FLARE_1";
      break;
    default:
      break;
  }

  if(isDefined(self.interact)) {
    self.interact delete();
  }

  var3 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), self gettagangles("j_shaft_top"));
  var3 linkTo(self);
  self.interact = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top") + (0, 0, 15), (0, 0, 0));
  self.interact linkTo(self);
  scripts\engine\utility::flag_wait("enable_ilumination_flares");
  scripts\common\anim::anim_first_frame_solo(self, "player_mortar_fire");
  self.interact scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, -10), var2, undefined, 300, 100, 1, undefined, undefined, undefined, undefined, undefined, undefined);
  thread stop_illumination_mortars_thread();
  self.interact waittill("trigger");
  level.flare_counter--;

  if(!scripts\engine\utility::flag("enable_ilumination_flares")) {
    scripts\engine\utility::flag_wait("enable_ilumination_flares");
  }

  scripts\engine\utility::flag_set("player_flaring");
  level.player.stance = level.player getstance();
  level notify("illumination_flare_shot");

  if(!scripts\engine\utility::flag("wave_1_attack")) {
    scripts\engine\utility::flag_set("wave_1_attack");
  }

  var4 = [level.player.rig, self];
  scripts\common\anim::anim_first_frame(var4, "player_mortar_fire");
  level.player enableinvulnerability();
  level.player scripts\engine\utility::delaycall(4, &disableinvulnerability);
  scripts\common\anim::anim_first_frame_solo(level.player.rig, "player_mortar_fire");
  thread scripts\engine\sp\utility::dof_enable_autofocus(2, 10, undefined, undefined, "j_shaft_top");
  scripts\sp\maps\embassy\embassy_util::put_player_into_rig(level.player.rig, 0.4, 5, 5, 5, 5, 1);
  self showpart(self.shell, "misc_wm_mortar");
  scripts\engine\utility::delaythread(2.25, &illumination_flare, var3);
  thread mortar_launch_player_effect();
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  thread scripts\common\anim::anim_single(var4, "player_mortar_fire");
  level.player.rig waittillmatch("single anim", "end");
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  self hidepart(self.shell, "misc_wm_mortar");
  thread scripts\engine\sp\utility::dof_disable_autofocus();
  scripts\sp\maps\embassy\embassy_util::pull_player_out_of_rig_hide_rig(level.player.rig);
  level notify("stop_print_timer");
  wait 0.2;
  self.interact delete();
  var3 delete();
  wait 5;
  scripts\engine\utility::flag_clear("player_flaring");
  scripts\engine\utility::flag_clear("enable_ilumination_flares");

  if(!scripts\engine\utility::flag("wave_2_trucks_end")) {
    thread illumination_mortars();
    return;
  }
}

function mortar_launch_player_effect() {
  level.player endon("death");
  wait 2.2;
  level.player playRumbleOnEntity("damage_bullet");
  screenshake(self.origin, 20, 1, 5, 0.5, 0, 0.5, 100, 5, 50, 50);
}

function illumination_mortar_friendly() {
  if(scripts\engine\utility::flag("wave_5_end")) {
    return;
  }

  var0 = undefined;
  var1 = undefined;
  self.shell = "j_mortar_shell";
  self hidepart(self.shell, "misc_wm_mortar");
  var1 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), self gettagangles("j_shaft_top"));
  var1 linkTo(self);

  for(;;) {
    var2 = scripts\engine\utility::flag_wait_any_return("flare_north", "flare_east");

    if(issubstr(var2, self.script_noteworthy)) {
      thread illumination_flare(var1);
    }

    scripts\engine\utility::flag_clear(var2);
    wait 0.1;
  }
}

function illumination_flare(var0) {
  var1 = undefined;
  var2 = undefined;
  var3 = level.flare_light.og_angles + (10, 60, 0);
  var4 = self.script_noteworthy;

  switch (var4) {
    case "east":
      if(scripts\engine\utility::flag("front_1")) {
        var1 = (3400, 0, 600);
      }

      if(scripts\engine\utility::flag("front_2")) {
        var1 = (2700, -100, 700);
      }

      if(scripts\engine\utility::flag("front_3")) {
        var1 = (1300, -200, 700);
      }

      break;
    case "north":
      if(!scripts\engine\utility::flag("wave_2_end")) {
        var1 = (900, -200, 700);
        level.flare_light.intensity = 300;
        var3 = level.flare_light.og_angles + (-25, 0, 0);
      }

      if(scripts\engine\utility::flag("wave_2_end")) {
        var1 = (-613, 1304, 900);
        var3 = (0, 85, 0);
        level.flare_light.intensity = 200;
      }

      break;
    default:
      break;
  }

  var5 = scripts\engine\utility::spawn_tag_origin(var0.origin, (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_mortar_fire"), self.origin, anglesToForward(self.angles));
  thread scripts\engine\utility::play_sound_in_space("weap_mortar_flare_launch", var0.origin);
  var5 scripts\engine\utility::delaythread(0.1, &scripts\engine\utility::playsoundontag, "weap_mortar_flare_whistle", "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_illumination_flare_launch_trail"), var5, "tag_origin");
  var6 = 2.25;

  if(getdvarint("scr_mortar_gravity")) {
    var7 = distance(var0.origin, var1);
    var8 = 2000;
    var6 = var7 / var8 * var6;
  }

  thread movemortar(var5, var0.origin, var1, var6, 400);
  wait var6;
  level.flare_light dontinterpolate();
  level.flare_light_up dontinterpolate();
  level.flare_light.origin = var5.origin + (0, 0, -10);
  level.flare_light_up.origin = var5.origin + (0, 0, 0);
  level.flare_light.angles = var3;
  level.flare_light linkTo(var5);
  level.flare_light_up linkTo(var5);
  scripts\engine\utility::flag_set("flares_out");
  thread scripts\sp\maps\embassy\embassy_lighting::flare_light();
  thread scripts\sp\maps\embassy\embassy_lighting::flare_light_up();
  playFXOnTag(scripts\engine\utility::getfx("vfx_illumination_flare_unlit"), var5, "tag_origin");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_illumination_flare_launch_trail"), var5, "tag_origin");
  var9 = scripts\engine\trace::ray_trace(var5.origin, var5.origin + (0, 0, -10000));
  var1 = var9["position"] + (0, 0, 5);
  level notify("flare_drop");
  var5 thread scripts\engine\utility::playsoundontag("weap_mortar_flare_burst", "tag_origin");
  var5 thread scripts\engine\sp\utility::play_sound_on_tag("weap_mortar_flare_phosphorus_start", "tag_origin");
  var5 scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::play_loop_sound_on_tag, "weap_mortar_flare_phosphorus_lp", "tag_origin");
  thread flare_mover(var5);
  thread flare_ai_ent_flag_setting();
  var5 scripts\engine\utility::delaythread(level.flare_lifetime - 2, &scripts\engine\utility::playsoundontag, "weap_mortar_flare_phosphorus_end", "tag_origin");
  var5 scripts\engine\utility::delaythread(level.flare_lifetime - 1.8, &scripts\engine\utility::stop_loop_sound_on_entity, "weap_mortar_flare_phosphorus_lp");
  thread flare_countdown();
  wait level.flare_lifetime;
  level.flare_light unlink();
  var5 delete();
  scripts\engine\utility::flag_clear("flares_out");
}

function flare_countdown() {
  level.flare_countdown = level.flare_lifetime;

  for(var0 = level.flare_lifetime; var0 > 0; var0--) {
    level.flare_countdown--;
    wait 1;
  }
}

function flare_ai_ent_flag_setting() {
  for(var0 = 0; var0 < level.flare_lifetime; var0++) {
    var1 = getaiarray("axis");

    foreach(var3 in var1) {
      var4 = 1500;

      if(distance(self.origin, var3.origin) < var4) {
        if(var3 scripts\engine\utility::ent_flag_exist("flared") && !var3 scripts\engine\utility::ent_flag("flared")) {
          var3 scripts\engine\utility::ent_flag_set("flared");
          var3.flare_timer = level.flare_lifetime - var0;
        }
      }
    }

    wait 1;
  }
}

function doorbust_guy_spawn_func() {
  self.animname = "doorbust_guy";
  scripts\engine\sp\utility::set_deathanim("stairs_death");
  self.allowdeath = 1;
  thread door_bust_guy_autosave();
  var0 = getEnt("doorbust_door", "targetname");
  var0.clip = getEnt("doorbust_door_clip", "targetname");
  var0.clip linkTo(var0);
  self.struct = scripts\engine\utility::getStruct("doorbust_struct", "targetname");
  waitframe();
  self.struct scripts\common\anim::anim_first_frame_solo(self, "door_bust");
  thread scripts\common\ai::magic_bullet_shield();
  scripts\engine\sp\utility::trigger_wait_targetname("doorbust_guy_trigger");
  thread scripts\sp\maps\embassy\embassy_util::say("dx_vom_aq2_defend_mortar_interior_10");
  wait 1.5;
  self endon("death");
  thread scripts\common\ai::stop_magic_bullet_shield();
  var0 playSound("scrpt_door_wood_heavy_bash_npc");
  var0 rotateYaw(-110, 0.3);
  var0.clip connectpaths();
  self.struct thread scripts\common\anim::anim_single_solo(self, "door_bust");
  waitframe();
  self setanimtime(scripts\engine\utility::getanim("door_bust"), 0.5);
  thread doorbust_guy_becomes_ai_if_alive();
}

function stairs_guy_spawn_func() {
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

function door_bust_guy_autosave() {
  self waittill("death");
  scripts\engine\sp\utility::autosave_by_name("mortar_house_stairs");
}

function suicide_bomber_spawn_func() {
  self getenemyinfo(level.player);
  self endon("death");
  var0 = getEnt("bomber_left_side_trigger", "targetname");

  for(;;) {
    if(level.player istouching(var0)) {
      scripts\engine\sp\utility::set_favoriteenemy(level.price);
      self getenemyinfo(level.price);
    }

    waitframe();
  }
}

function sfx_spawn_crickets() {
  if(scripts\engine\utility::flag("sfx_crickets")) {
    return;
  }

  var0 = spawn("script_origin", (-266, -591, 24));
  var0 playLoopSound("emt_cricket_single_02_close_lp");
  var1 = spawn("script_origin", (-1339, -310, 52));
  var1 playLoopSound("emt_cricket_area_01_lp");
  var2 = spawn("script_origin", (-968, -1641, 16));
  var2 playLoopSound("emt_night_bugs_lp");
  var3 = spawn("script_origin", (-389, -1066, 37));
  var3 playLoopSound("emt_night_bugs_lp");
  var4 = spawn("script_origin", (-549, -310, 43));
  var4 playLoopSound("emt_night_bugs_lp");
  var5 = spawn("script_origin", (38, 71, 26));
  var5 playLoopSound("emt_night_bugs_lp");
  var6 = spawn("script_origin", (251, -1541, 52));
  var6 playLoopSound("emt_night_bugs_lp");
  var7 = spawn("script_origin", (615, -110, 16));
  var7 playLoopSound("emt_cricket_single_03_dist_lp");
  var8 = spawn("script_origin", (-571, -1583, 51));
  var8 playLoopSound("emt_cricket_single_05_dist_lp");
  scripts\engine\utility::flag_set("sfx_crickets");
  level waittill("sfx_stop_crickets");
  var0 delete();
  var1 delete();
  var2 delete();
  var3 delete();
  var4 delete();
  var5 delete();
  var6 delete();
  var7 delete();
  var8 delete();
}

function defend_inits() {
  scripts\engine\utility::flag_set("obj_using_cctv");
  level.technicals = [];
  level.mortar_teams = [];
  level.field_cover_direction = anglesToForward((0, 180, 0));
  level.roof_tops_cover_direction = anglesToForward((0, 60, 0));
  level.player.dontgrenademe = 1;
  var0 = getEntArray("triage_loot", "targetname");
  scripts\engine\utility::array_call(var0, &hide);
  var1 = getEnt("wolf_escape_gate", "targetname");
  var1 hide();
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
  var2 = getEnt("east_gate_destroyed", "targetname");
  var2 hide();
  var3 = getEnt("barracks_bloodstain", "targetname");
  var3 hide();
  var4 = getEnt("m4_refill_03", "targetname");
  var4.og_origin = var4.origin;
  var4.og_angles = var4.angles;
  var4.origin = (-274, -1002, 84);
  var5 = getEnt("m4_refill_01", "targetname");
  var5.og_origin = var5.origin;
  var5.og_angles = var5.angles;
  var5.origin = (-274, -1002, 84);
  var6 = getEntArray(var2.target, "targetname");

  if(var6.size > 0) {
    scripts\engine\utility::array_call(var6, &hide);
  }

  scripts\engine\utility::trigger_off("slide_trigger_01", "targetname");
  scripts\engine\utility::trigger_off("wave_3_ladder", "targetname");
  level.flare_lifetime = 22;
  level.player.flare_held = 0;
  level.mortar_round_delay_time = 2.5;
  var7 = ["scaffolding_a", "scaffolding_b", "scaffolding_c"];

  foreach(var9 in var7) {
    show_scaffolding_mayhem(var9);
  }
}

function palm_trees_init() {
  wait 0.2;
  level.palm_trees = [];
  var0 = spawnStruct();
  var0.exploder_name = "p_tree_fire_1";
  var0.origin = (833.4, 1280.7, 34);
  level.palm_trees[level.palm_trees.size] = var0;
  var1 = getscriptablearray("emb_palm_02", "targetname")[0];
  level.palm_trees[level.palm_trees.size] = var1;
  var2 = spawnStruct();
  var2.exploder_name = "p_tree_fire_3";
  var2.origin = (2341.4, 1280.7, 34);
  level.palm_trees[level.palm_trees.size] = var2;
  var3 = spawnStruct();
  var3.exploder_name = "p_tree_fire_4";
  var3.origin = (3636.4, 1280.7, 34);
  level.palm_trees[level.palm_trees.size] = var3;
  var4 = spawnStruct();
  var4.exploder_name = "p_tree_fire_5";
  var4.origin = (1034.6, 1813.3, 36);
  level.palm_trees[level.palm_trees.size] = var4;
}

function show_scaffolding_mayhem(var0) {
  showmayhem(var0);
  showmayhem(var0 + "_tarps");
}

function unload_embassy_load_anims() {
  waitframe();
  var0 = getcorpsearray();

  foreach(var2 in var0) {
    var2 delete();
  }

  thread embassy_weapon_cleanup();
  waitframe();
  thread scripts\engine\sp\utility::transient_unload("embassy_building_tr");
  scripts\engine\sp\utility::transient_unload("embassy_building_cctv_tr");
  waitframe();
  loadtransient("embassy_compound_anims_middle_tr");
}

function embassy_weapon_cleanup() {
  var0 = getweaponarray();

  foreach(var2 in var0) {
    if(var2.origin[0] < -4300) {
      var2 delete();
    }
  }
}

function defend_push_weapon_cleanup() {
  var0 = getweaponarray();

  foreach(var2 in var0) {
    if(var2.origin[0] > 500 && var2.origin[2] < 35) {
      var2 delete();
    }
  }
}

function load_compound_anims_end_transient() {
  waitframe();
  scripts\engine\sp\utility::transient_unload("embassy_compound_anims_middle_tr");
  waitframe();
  loadtransient("embassy_compound_anims_end_tr");
}

function objective_manager_defend() {
  waitframe();
  scripts\engine\sp\objectives::objective_add("Rooftop", "current", level.roof_objective_struct.origin + (0, 0, 20), &"EMBASSY/OBJ_ROOFTOP");
  scripts\engine\utility::flag_wait("player_on_rooftop");
  scripts\engine\utility::flag_wait("intro_vo_finished");
  scripts\engine\sp\objectives::objective_remove("Rooftop");
  var0 = spawnStruct();
  var0.origin = (-120, -952, 180);

  if(!scripts\engine\utility::flag("player_has_sniper")) {
    scripts\engine\sp\objectives::objective_add("Rifle", "current", var0.origin, &"EMBASSY/OBJ_SCOPE");
    scripts\engine\utility::flag_wait("player_has_sniper");
    scripts\engine\sp\objectives::objective_remove("Rifle");
  }

  waitframe();
  var1 = scripts\engine\utility::getStruct("soccer_struct", "targetname");
  scripts\engine\sp\objectives::objective_add("Cafe", "current", var1.origin + (0, 0, 100), &"EMBASSY/OBJ_CAFE");
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
  var2 = spawnStruct();
  var2.origin = (-111, 189, 76);
  var2 = scripts\engine\utility::spawn_tag_origin(level.price.origin + (0, 0, 80), level.price.angles);
  var2 linkTo(level.price);
  scripts\engine\sp\objectives::objective_add("regroup", "current", var2.origin, &"EMBASSY/OBJ_REGROUP", undefined);
  scripts\engine\sp\objectives::objective_set_on_entity("regroup", undefined, var2);
  scripts\engine\utility::flag_wait("wave_3_inside");
  scripts\engine\sp\objectives::objective_remove("regroup");
  var2 delete();
  scripts\engine\sp\objectives::objective_add("resupply", "current", undefined, &"EMBASSY/OBJ_RESUPPLY");
  scripts\engine\utility::flag_wait("green_beam_shown");

  if(!scripts\engine\utility::flag("green_beam_acquired")) {
    wait 1;
  }

  scripts\engine\sp\objectives::objective_remove("resupply");
  var3 = getEnt("targetting_struct", "targetname");
  scripts\engine\sp\objectives::objective_add("greenbeam", "current", var3.origin + (0, 0, 10), &"EMBASSY/OBJ_DESIGNATOR");
  scripts\engine\utility::flag_wait("green_beam_acquired");
  scripts\engine\sp\objectives::objective_remove("greenbeam");
  scripts\engine\utility::flag_wait("building_combat_objective");
  var2 = spawnStruct();
  var2.origin = (-232.5, 422.5, 175);
  scripts\engine\sp\objectives::objective_add("building_combat", "current", var2.origin, &"EMBASSY/OBJ_MARK_TARGETS");
  scripts\engine\utility::flag_wait("wave_4_end");
  scripts\engine\sp\objectives::objective_remove("building_combat");
  scripts\engine\sp\objectives::objective_add("defend_objective", "current", undefined, &"EMBASSY/OBJ_DEFEND_COMPOUND");
  scripts\engine\utility::flag_wait("mortar_team_objective");
  scripts\engine\sp\objectives::objective_remove("defend_objective");
  var2 = scripts\engine\utility::getStruct("mortar_wave_4", "targetname");
  scripts\engine\sp\objectives::objective_add("mortar_team", "current", var2.origin, &"EMBASSY/OBJ_CLEAR_HOUSE");
  scripts\engine\utility::flag_wait("wave_5_house_end");

  if(!scripts\engine\utility::flag("residence_return")) {
    wait 2;
  }

  scripts\engine\sp\objectives::objective_remove("mortar_team");
  var2 = spawnStruct();
  var2.origin = (-418, -110, 76);
  scripts\engine\sp\objectives::objective_add("return_to_compound", "current", var2.origin, &"EMBASSY/OBJ_COMPOUND");
  scripts\engine\utility::flag_wait("residence_return");
  scripts\engine\sp\objectives::objective_remove("return_to_compound");
  var2.origin = (-1842, -379, 116);
  var4 = scripts\engine\utility::getStruct("residence_end_struct", "targetname");
  scripts\engine\sp\objectives::objective_add("secure_the_wolf", "current", var2.origin + (0, 0, 30), &"EMBASSY/OBJ_SECURE_WOLF");
  scripts\engine\utility::flag_wait("wolf_escapes");
  scripts\engine\sp\objectives::objective_update("secure_the_wolf", "current", var4.origin + (0, 0, 30), &"EMBASSY/OBJ_SECURE_WOLF");
}