/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_armory.gsc
***************************************/

main() {
  level.additional_boss_weapon = ::spawn_weapon_in_boss_area;
  level.extinction_episode = 1;
  level.introscreen_line_1 = & "MP_ALIEN_ARMORY_INTRO_LINE_1";
  level.introscreen_line_2 = & "MP_ALIEN_ARMORY_INTRO_LINE_2";
  level.introscreen_line_3 = & "MP_ALIEN_ARMORY_INTRO_LINE_3";
  level.introscreen_line_4 = & "MP_ALIEN_ARMORY_INTRO_LINE_4";
  level.hintprecachefunc = ::armory_hint_precache;
  maps\mp\alien\_utility::alien_mode_enable("kill_resource", "wave", "airdrop", "lurker", "collectible", "loot", "pillage", "challenge", "outline", "scenes");
  var_0 = ["checkpoint", "compound", "facility", "loadingdock", "ending"];
  maps\mp\alien\_utility::alien_area_init(var_0);
  level.ricochetdamagemax = 10;
  level.hardcore_spawn_multiplier = 1.0;
  level.hardcore_damage_scalar = 1.0;
  level.hardcore_health_scalar = 1.0;
  level.hardcore_reward_scalar = 1.0;
  level.hardcore_score_scalar = 1.25;
  level.casual_spawn_multiplier = 1.0;
  level.casual_damage_scalar = 0.45;
  level.casual_health_scalar = 0.45;
  level.casual_reward_scalar = 1.0;
  level.casual_score_scalar = 0.5;
  level.include_default_challenges = 1;
  level.challenge_registration_func = maps\mp\alien\mp_alien_armory_challenges::register_armory_challenges;
  level.challenge_scalar_func = maps\mp\alien\mp_alien_armory_challenges::armory_challenge_scalar_func;
  level.custom_death_challenge_func = maps\mp\alien\mp_alien_armory_challenges::armory_death_challenge_func;
  level.custom_damage_challenge_func = maps\mp\alien\mp_alien_armory_challenges::armory_damage_challenge_func;
  level.include_default_achievements = 1;
  level.include_default_unlocks = 1;
  level.escape_cycle = 19;
  level.initial_spawn_loc_override_func = ::player_initial_spawn_loc_override;
  level.custom_pillageinitfunc = ::mp_alien_armory_pillage_init;
  maps\mp\alien\_pillage_locker::locker_pillage_functions_init();
  level.level_locker_weapon_pickup_string_func = ::armory_locker_weapon_pickup_string_func;
  level.tryusedronehive = ::mp_alien_armory_try_use_drone_hive;
  level.achievement_registration_func = maps\mp\alien\_achievement_dlc::register_achievements_dlc;
  level.update_alien_kill_achievements_func = maps\mp\alien\_achievement_dlc::update_alien_kill_achievements_dlc;
  level.update_achievement_damage_weapon_func = maps\mp\alien\_achievement_dlc::update_achievement_damage_weapon_dlc;
  level.custom_alien_death_func = maps\mp\alien\_death::general_alien_custom_death;
  level.custom_cangive_weapon_func = ::armory_cangive_weapon_handler_func;
  level.custom_give_weapon_func = ::armory_give_weapon_handler_func;
  level.generic_electric_trap_check = ::is_generic_electric_trap_func;
  level.ammoincompatibleweaponslist = ["iw6_aliendlc11_mp"];
  level.spider_boss_easter_egg_active = 0;
  level thread manage_direction_triggers();
  game["thermal_vision"] = "mp_alien_town_thermal";
  visionsetthermal(game["thermal_vision"]);
  game["thermal_vision_trinity"] = "mp_alien_thermal_trinity";
  level.cac_vo_male = common_scripts\utility::array_randomize(["p6_", "p5_"]);
  level.cac_vo_female = common_scripts\utility::array_randomize(["p8_", "p7_"]);
  level.custom_onspawnplayer_func = ::mp_alien_armory_onspawnplayer_func;
  level.custom_alien_scale_alien_damage_func = ::mp_alien_armory_scale_alien_damage_func;
  level.enter_area_func = ::armory_enter_area_func;
  level.leave_area_func = ::armory_leave_area_func;
  level.intel_table = "mp/alien/alien_armory_intel.csv";
  set_spawn_table();
  level.alien_collectibles_table = "mp/alien/collectibles_armory.csv";
  level.default_alien_definition = "mp/alien/armory_alien_definition.csv";
  level.spawn_node_info_table = "mp/alien/armory_spawn_node_info.csv";
  level.alien_challenge_table = "mp/alien/mp_alien_armory_challenges.csv";
  level.alien_character_cac_table = "mp/alien/alien_cac_presets.csv";
  level.container_spawn_table = "mp/alien/armory_container_spawn.csv";

  if(maps\mp\alien\_utility::isplayingsolo())
    level.base_player_count_multiplier = 1;
  else
    level.base_player_count_multiplier = 0.49;

  level.additional_player_count_multiplier = 0.17;
  level.waypoint_dist_override = 2500;
  maps\mp\mp_alien_armory_precache::main();
  maps\createart\mp_alien_armory_art::main();
  maps\mp\mp_alien_armory_fx::main();
  maps\mp\agents\alien\alien_spider\_alien_spider::precacheanims();
  maps\mp\alien\_armory_weapon::init();
  maps\mp\_load::main();
  setdvar("sm_sunShadowScale", "0.5");
  var_1 = ["tutorial_hive_01"];
  maps\mp\alien\_utility::add_hive_dependencies("checkpoint_hive_01", var_1);
  maps\mp\alien\_utility::add_hive_dependencies("checkpoint_hive_02", var_1);
  maps\mp\alien\_utility::add_hive_dependencies("checkpoint_hive_03", var_1);
  maps\mp\alien\_utility::add_hive_dependencies("checkpoint_hive_04", var_1);
  maps\mp\alien\_utility::add_hive_dependencies("checkpoint_hive_05", var_1);
  var_2 = ["compound_hive_01", "compound_hive_02", "compound_hive_03", "compound_hive_04", "compound_hive_06", "compound_hive_07", "compound_hive_08"];
  maps\mp\alien\_utility::add_hive_dependencies("compound_hive_05", var_2);
  var_3 = ["compound_hive_01", "compound_hive_02", "compound_hive_03", "compound_hive_04", "compound_hive_05", "compound_hive_07", "compound_hive_08"];
  maps\mp\alien\_utility::add_hive_dependencies("compound_hive_06", var_3);
  var_4 = ["facility_hive_01", "facility_hive_02", "facility_hive_03", "facility_hive_04", "facility_hive_05", "facility_hive_06"];
  maps\mp\alien\_utility::add_hive_dependencies("facility_hive_07", var_4);
  maps\mp\_compass::setupminimap("compass_map_mp_alien_armory");
  game["thermal_vision_trinity"] = "mp_alien_thermal_trinity";
  var_5 = 20000;
  var_6 = 40000;
  var_7 = 70000;
  var_8 = 240000;
  maps\mp\alien\_persistence::register_lb_escape_rank([0, var_5, var_6, var_7, var_8]);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "woodland";
  var_9 = [];
  var_10 = [5, 10];
  maps\mp\gametypes\aliens::setup_cycle_end_area_list(var_10);
  maps\mp\gametypes\aliens::setup_blocker_hives(var_9);
  maps\mp\gametypes\aliens::setup_last_hive("bomblocation_14");
  level.should_play_next_hive_vo_func = ::should_play_next_hive_vo_func;
  register_encounter();

  if(!maps\mp\alien\_utility::is_chaos_mode())
    init_container_spawn();

  maps\mp\alien\_alien_class_skills_main::main();
  maps\mp\alien\_pillage_intel::create_intel_spots();
  level thread easter_egg_conduit();
  level thread maps\mp\mp_alien_armory_fx::fx_snow("light_snow");
  level thread maps\mp\mp_alien_armory_fx::fx_snow_watcher();
  level thread debris_fx();
  spider_hide_all_debris();
  level.end_game_scoreboard_wait_time = 15;
  disconnect_snow_paths();
  move_clip_brush_checkpoint_lakeside();
  move_clip_brush_checkpoint_lakeside_boxes();
  common_scripts\utility::flag_init("start_spider_encounter");
  level thread maps\mp\alien\_lasedstrike_alien::init();
  level thread maps\mp\alien\_switchblade_alien::init();
}

register_encounter() {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    maps\mp\gametypes\aliens::register_encounter(::chaos_init, undefined, undefined, undefined, ::chaos_init, maps\mp\alien\_globallogic::blank);
    maps\mp\gametypes\aliens::register_encounter(maps\mp\alien\_chaos::chaos, undefined, undefined, undefined, maps\mp\alien\_chaos::chaos, maps\mp\alien\_globallogic::blank);
    return;
  }

  maps\mp\gametypes\aliens::register_encounter(::encounter_init, undefined, undefined, undefined, ::encounter_init, maps\mp\alien\_globallogic::blank);
  maps\mp\gametypes\aliens::register_encounter(::area1_first_hive_setup, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_checkpoint, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(maps\mp\alien\_hive::regular_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_checkpoint, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::area1_third_hive_setup, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_checkpoint, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::area1_final_hive_setup, 1, undefined, 1, maps\mp\alien\_hive::skip_hive, ::jump_to_checkpoint, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::first_spider_fight, 1, undefined, undefined, ::skip_first_spider_fight, ::jump_to_checkpoint);
  maps\mp\gametypes\aliens::register_encounter(maps\mp\alien\_hive::regular_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_compound, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(maps\mp\alien\_hive::regular_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_compound, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::area2_2nd_hive_setup, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_compound, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(maps\mp\alien\_hive::regular_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_compound_final, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::second_spider_fight, undefined, undefined, 1, ::skip_second_spider_fight, ::jump_to_compound);
  maps\mp\gametypes\aliens::register_encounter(::facility_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_facility, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::facility_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_facility, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::facility_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_facility, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::facility_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_facility, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::last_facility_hive, 1, undefined, 1, maps\mp\alien\_hive::skip_hive, ::jump_to_facility, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::third_spider_fight, 1, undefined, undefined, ::skip_third_spider_fight, ::jump_to_loadingdock);
}

encounter_init() {
  maps\mp\alien\_drill::init_drill();
  maps\mp\alien\_hive::init_hives();
  maps\mp\agents\alien\alien_spider\_alien_spider::initspider();
  maps\mp\agents\alien\_alien_human::inithuman("alien_human_armory_animclass");
  maps\mp\alien\_gamescore::init_eog_score_components(["hive"]);
  maps\mp\alien\_gamescore_armory::init_armory_eog_score_components(["spider", "relics"]);
  maps\mp\alien\_gamescore::init_encounter_score_components(["challenge", "drill", "team", "personal"]);
  maps\mp\alien\_gamescore_armory::init_armory_encounter_score_components(["spider_challenge", "spider_team", "spider_personal", "first_spider"]);
  setup_special_guns();
}

setup_special_guns() {
  var_0 = getEntArray("anti_alien_gun", "targetname");
  common_scripts\utility::array_thread(var_0, maps\mp\alien\_armory_weapon::give_special_gun);
}

armory_hint_precache() {
  var_0 = [];
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_MAUL"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_MAUL";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_PROPANE_TANK"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_PROPANE_TANK";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_VKS"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_VKS";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_KRISS"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_KRISS";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_L115A3"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_L115A3";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_KAC"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_KAC";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_MTS255"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_MTS255";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_VEPR"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_VEPR";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_G28"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_G28";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_LSAT"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_LSAT";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_ARX_160"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_ARX_160";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_SVU"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_SVU";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_MAVERICK"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_MAVERICK";
  var_0["ALIEN_PICKUPS_ARMORY_PICKUP_KASTET"] = & "ALIEN_PICKUPS_ARMORY_PICKUP_KASTET";
  return var_0;
}

spider_initial_intro() {
  self scragentsetorientmode("face angle abs", self.angles);
  thread play_spider_intro_music();
  thread spider_play_snow_debris_anim();
  thread maps\mp\mp_alien_armory_vignettes::first_spider_fence();
  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack("spawn", 0, 1.0, "spawn", "end");
  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(4096);
  self waittill("goal_reached");
}

spider_hide_all_debris() {
  var_0 = getscriptablearray("snow_debris", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate(0, 1);
}

debris_fx() {
  if(maps\mp\_utility::is_gen4())
    level._effect["spider_reveal_dense_particles"] = loadfx("vfx/spider_reveal_particles");
}

spider_play_snow_debris_anim() {
  wait 2.66;
  var_0 = getent("snow_debris_static", "targetname");
  var_1 = getscriptablearray("snow_debris", "targetname");

  foreach(var_3 in var_1)
  var_3 setscriptablepartstate(0, 0);

  var_0 delete();

  if(maps\mp\_utility::is_gen4()) {
    var_5 = common_scripts\utility::getstruct("spider_blocker_01", "targetname");
    playFX(level._effect["spider_reveal_dense_particles"], var_5.origin, (1, 0, 0), (0, 0, 1));
  }

  wait 0.2;
  common_scripts\utility::exploder(62);
  wait 0.3;
  common_scripts\utility::exploder(61);
  wait 0.3;
  common_scripts\utility::exploder(62);
  wait 0.2;
  common_scripts\utility::exploder(63);
  wait 0.5;
  common_scripts\utility::exploder(61);
  wait 0.2;
  common_scripts\utility::exploder(63);
  wait 0.5;
  common_scripts\utility::exploder(62);
  wait 0.5;
  common_scripts\utility::exploder(61);
  wait 4;
  common_scripts\utility::exploder(65);
  wait 0.3;
  common_scripts\utility::exploder(64);
  var_6 = (-3112, -5074, 674);
  earthquake(0.6, 1, var_6, 1600);
  playrumbleonposition("grenade_rumble", var_6);
}

play_spider_intro_music() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    if(!common_scripts\utility::flag("exfil_music_playing"))
      level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc1_spider");
  }
}

play_spider_intro_loop() {
  self endon("death");
  self endon("end_spider_intro_loop");

  for(;;)
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack("spawn", 1, 1.0, "spawn", "end");
}

monitor_spider_intro_damage() {
  self endon("death");
  self endon("end_spider_intro_loop");
  self waittill("damage");
  self notify("end_spider_intro_loop");
}

monitor_spider_intro_proximity() {
  self endon("death");
  self endon("end_spider_intro_loop");
  var_0 = 1000000;

  for(;;) {
    foreach(var_2 in level.players) {
      if(distance2dsquared(var_2.origin, self.origin) < var_0) {
        self notify("end_spider_intro_loop");
        break;
      }
    }

    wait 0.05;
  }
}

test_meteoroid() {
  wait 10;
  thread maps\mp\alien\_spawnlogic::spawn_alien_meteoroid("minion");
  wait 2;
  thread maps\mp\alien\_spawnlogic::spawn_alien_meteoroid("minion");
  wait 10;
  thread maps\mp\alien\_spawnlogic::spawn_alien_meteoroid("minion");
}

area1_first_hive_setup() {
  level maps\mp\mp_alien_armory_vignettes::main();
  maps\mp\alien\_hive::regular_hive();
  thread maps\mp\mp_alien_armory_vignettes::godfather_area_1_first();
}

area1_third_hive_setup() {
  maps\mp\alien\_hive::regular_hive();
  thread maps\mp\mp_alien_armory_vignettes::godfather_area_1_midway();
}

area1_final_hive_setup() {
  maps\mp\alien\_hive::regular_hive();
  thread maps\mp\mp_alien_armory_vignettes::area_1_final_hive();
}

test_human() {
  wait 10.0;
  var_0 = maps\mp\agents\alien\_alien_human::alienhumanspawn((-2115, -7073, 661), (0, 0, 0), "mp_body_us_rangers_assault_a_urban", "head_mp_head_a");
}

human_notetracks(var_0, var_1, var_2, var_3) {}

setup_first_spider() {
  level endon("first_spider_fight_skipped");
  var_0 = common_scripts\utility::getstruct("spider_blocker_01", "targetname");
  var_0.retreatstate = "retreat";
  var_0.retreatindex = 0;
  level.spider = spawn_spider(var_0.origin, var_0.angles);
  level.spider spider_initial_intro();
  level.spider.retreatstruct = var_0;
  level.spider link_spider_collision();
  level thread spider_start_cycle(1);
  level.spider thread maps\mp\agents\alien\alien_spider\_alien_spider::alienspiderrunstage(1);
  activate_first_spider_fight_challenge();
}

spider_start_cycle(var_0) {
  var_1 = "stage_" + var_0;
  var_2 = level.alien_types[level.spider.alien_type].attributes[var_1]["cycle_delay"];
  var_3 = "spider_fight_" + var_0 + "_complete";

  if(var_2 > 0.0)
    var_4 = common_scripts\utility::waittill_notify_or_timeout_return(var_3, var_2);
  else
    var_4 = "no_delay";

  if(isDefined(var_4)) {
    maps\mp\alien\_spawn_director::start_cycle(level.cycle_count);
    level waittill(var_3);
    maps\mp\alien\_spawn_director::end_cycle();
  }

  level.cycle_count++;

  if(var_0 == 1)
    connect_snow_paths();
}

link_spider_collision() {
  var_0 = getent("spider_collision_00", "targetname");
  var_0.originalorigin = var_0.origin;
  var_0.originalangles = var_0.angles;
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  self.collision_brush = var_0;
  var_0 linkto(self);
}

unlink_spider_collision() {
  if(isDefined(self.collision_brush)) {
    self.collision_brush unlink();
    self.collision_brush.origin = self.collision_brush.originalorigin;
    self.collision_brush.angles = self.collision_brush.originalangles;
    self.collision_brush = undefined;
  }
}

disconnect_snow_paths() {
  var_0 = getent("spider_mound_clip", "targetname");
  var_0 disconnectpaths();
}

connect_snow_paths() {
  var_0 = getent("spider_mound_clip", "targetname");
  var_0 hide();
  var_0 connectpaths();
  var_0 delete();
}

first_spider_fight() {
  var_0 = (-3191, -5031, 609);
  level.encounter_name = "first_spider_fight";
  wait_for_player_near_spider();
  var_1 = gettime();
  maps\mp\alien\_gamescore::reset_encounter_performance();
  maps\mp\mp_alien_armory_fx::fx_snow("heavy_snow_no_fog");
  maps\mp\mp_alien_armory_fx::fx_set_spider_fog_1();
  setup_first_spider();
  level.spider waittill("spider_stage_end");
  level notify("spider_battle_end");
  wait 0.1;
  thread maps\mp\mp_alien_armory_vignettes::spider_exit_a_props();
  level.spider unlink_spider_collision();
  var_2 = gettime() - var_1;
  maps\mp\alien\_gamescore::update_team_encounter_performance("first_spider", "spider_battle_time", var_2);
  maps\mp\alien\_gamescore_armory::calculate_and_show_first_spider_score();
  wait 0.05;
  var_3 = getEntArray("fence_blocker_01_clip", "targetname");

  foreach(var_5 in var_3)
  var_5 delete();

  wait 6;
  level thread egg_cleanup();
  level.encounter_name = undefined;
  level notify("spider_fight_1_complete");
  maps\mp\mp_alien_armory_fx::fx_snow("medium_snow");
  clearfog(3);
  level thread maps\mp\alien\_drill::teleport_drill(var_0);
  thread maps\mp\mp_alien_armory_vignettes::post_first_boss_vo();
  maps\mp\alien\_achievement_dlc::update_boss_achievements("compound");
  give_reward_box_post_first_spider();

  if(maps\mp\alien\_utility::isplayingsolo() && !issplitscreen())
    maps\mp\alien\_laststand::give_laststand(level.players[0], 1);

  foreach(var_8 in level.players)
  var_8 maps\mp\alien\_persistence::try_award_bonus_pool_token();
}

egg_cleanup() {
  wait 3;
  var_0 = getEntArray("script_model", "classname");

  if(!isDefined(var_0) || var_0.size < 1) {
    return;
  }
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(isDefined(var_2.model) && var_2.model == "alien_spider_egg") {
      playFX(level._effect["egg_explosion"], var_2.origin);
      wait 0.1;
      var_2 delete();
    }
  }
}

wait_for_player_near_spider() {
  var_0 = "waypoint_alien_blocker";
  var_1 = 14;
  var_2 = 14;
  var_3 = 0.75;
  var_4 = (-3198, -4902, 648);
  var_5 = 60;
  var_6 = 256;
  var_7 = 100;
  var_8 = maps\mp\alien\_hud::make_waypoint(var_0, var_1, var_2, var_3, var_4);
  var_9 = spawn("trigger_radius", var_4, 0, var_6, var_7);
  var_9 thread watch_trigger_by_player();
  var_9 common_scripts\utility::waittill_any_timeout(var_5, "trigger_by_player");
  var_9 delete();
  var_8 destroy();
}

watch_trigger_by_player() {
  self endon("death");
  level endon("game_ended");
  common_scripts\utility::waitframe();

  for(;;) {
    self waittill("trigger", var_0);

    if(isplayer(var_0)) {
      break;
    }
  }

  self notify("trigger_by_player");
}

activate_first_spider_fight_challenge() {
  var_0 = "kill_spider";

  if(!maps\mp\alien\_utility::isplayingsolo()) {
    if(randomint(100) > 50)
      var_0 = "kill_eggs";
  }

  maps\mp\alien\_challenge::activate_new_challenge(var_0);
}

give_reward_box_post_first_spider() {
  var_0 = (-3175, -4687, 649);
  var_0 = common_scripts\utility::drop_to_ground(var_0, 32, -128);
  var_1 = "deployable_currency";
  var_2 = 1;
  var_3 = level.players[randomint(level.players.size)];
  var_3.team_currency_rank = var_2;
  var_4 = maps\mp\alien\_deployablebox::createboxforplayer(var_1, var_0, var_3);
  var_4.upgrade_rank = var_2;
  var_4.air_dropped = 1;
  wait 0.05;
  var_4 thread maps\mp\alien\_deployablebox::box_setactive(1);
}

skip_first_spider_fight() {
  level notify("first_spider_fight_skipped");

  if(isDefined(level.spider))
    level.spider suicide();

  var_0 = getEntArray("fence_blocker_01", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();

  level.cycle_count++;
  maps\mp\mp_alien_armory_fx::fx_snow("medium_snow");
}

area2_2nd_hive_setup() {
  maps\mp\alien\_hive::regular_hive();
  thread maps\mp\mp_alien_armory_vignettes::pre_second_boss_vo();
}

second_spider_fight() {
  maps\mp\mp_alien_armory_fx::fx_snow("medium_snow");
  maps\mp\mp_alien_armory_vignettes::spider_entrance_b();
  maps\mp\mp_alien_armory_vignettes::spider_posture_b();
  maps\mp\mp_alien_armory_vignettes::spider_exit_b();
  maps\mp\mp_alien_armory_fx::fx_snow("heavy_snow_no_fog");
  var_0 = getEntArray("blocker_02", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();

  level notify("factory_blocker_gone");
  maps\mp\alien\_achievement_dlc::update_boss_achievements("facility");

  if(maps\mp\alien\_utility::isplayingsolo() && !issplitscreen())
    maps\mp\alien\_laststand::give_laststand(level.players[0], 1);
}

third_spider_fight() {
  var_0 = gettime();
  maps\mp\alien\_gamescore::reset_encounter_performance();
  level.encounter_name = "final_spider_fight";
  level notify("final_spider_fight");
  var_1 = common_scripts\utility::getstruct("spider_ending_01", "targetname");
  var_1.retreatstate = "retreat";
  var_1.retreatindex = 3;
  maps\mp\mp_alien_armory_vignettes::spider_entrance_c();
  level.spider.retreatstruct = var_1;
  level.spider.elevatedretreatstruct = common_scripts\utility::getstruct("spider_ending_retreat_01", "targetname");
  level.spider link_spider_collision();
  level thread spider_start_cycle(2);
  var_2 = gettime();
  maps\mp\mp_alien_armory_fx::fx_snow("heavy_snow_no_fog");
  maps\mp\mp_alien_armory_fx::fx_set_spider_fog_3();
  level thread force_all_players_in_final_area();
  level.spider maps\mp\agents\alien\alien_spider\_alien_spider::alienspiderrunstage(2);
  var_3 = gettime() - var_2;
  maps\mp\alien\_achievement_dlc::update_boss_achievements("final", var_3);
  level.spider unlink_spider_collision();
  level.spider suicide();
  level.encounter_name = undefined;
  level notify("spider_fight_2_complete");
  maps\mp\mp_alien_armory_fx::fx_snow("heavy_snow");
  clearfog(3);
  update_lb_aliensession_final_spider(var_0);

  if(!maps\mp\alien\_utility::is_casual_mode())
    set_players_escaped();

  give_players_completion_tokens();
  maps\mp\alien\_unlock::update_escape_item_unlock(level.players);
  var_4 = gettime() - var_0;
  maps\mp\alien\_gamescore::update_team_encounter_performance("final_spider", "spider_battle_time", var_4);
  maps\mp\alien\_gamescore_armory::calculate_final_spider_score();
  var_5 = get_win_condition();
  var_6 = maps\mp\alien\_hud::get_end_game_string_index(var_5);
  thread armory_victory_music();
  level maps\mp\_utility::delaythread(10, maps\mp\gametypes\aliens::alienendgame, "allies", var_6);
  thread maps\mp\mp_alien_armory_vignettes::post_final_boss_vo();
}

set_players_escaped() {
  foreach(var_1 in level.players)
  var_1 maps\mp\alien\_persistence::set_player_escaped();
}

give_players_completion_tokens() {
  foreach(var_1 in level.players)
  var_1 maps\mp\alien\_persistence::award_completion_tokens();
}

get_win_condition() {
  foreach(var_1 in level.players) {
    if(maps\mp\alien\_utility::is_true(var_1.inlaststand))
      return "some_escape";
  }

  return "all_escape";
}

armory_victory_music() {
  wait 2;

  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      var_1 stoplocalsound("mus_alien_dlc1_archer_exfil");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    if(!common_scripts\utility::flag("exfil_music_playing"))
      level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_exfil");
  }
}

update_lb_aliensession_final_spider(var_0) {
  var_1 = gettime() - var_0;
  var_2 = get_lb_final_spider_rank(var_1);

  foreach(var_4 in level.players) {
    var_4 maps\mp\alien\_persistence::lb_player_update_stat("escapedRank" + var_2, 1, 1);
    var_4 maps\mp\alien\_persistence::lb_player_update_stat("hits", 1, 1);
  }
}

get_lb_final_spider_rank(var_0) {
  var_1 = 300000;
  var_2 = 600000;
  var_3 = 900000;

  if(var_0 <= var_1)
    return 0;
  else if(var_0 <= var_2)
    return 1;
  else if(var_0 <= var_3)
    return 2;
  else
    return 3;
}

spawn_second_spider_in_third_fight(var_0) {
  var_0 endon("death");
  var_1 = 0.5;

  for(;;) {
    if(var_0 maps\mp\agents\alien\alien_spider\_alien_spider::gethealthratio() < var_1) {
      break;
    }

    wait 0.05;
  }

  var_2 = common_scripts\utility::getstruct("spider_ending_02", "targetname");
  var_2.retreatstate = "retreat";
  var_2.retreatindex = 3;
  var_3 = spawn_spider(var_2.origin.spawn_struct.angles);
  var_3 maps\mp\agents\alien\alien_spider\_alien_spider::alienspiderrunstage(3);
  var_3.retreatstruct = var_2;
  var_3 suicide();
}

spawn_spider(var_0, var_1) {
  if(isDefined(var_1))
    var_2 = var_1;
  else if(isDefined(level.players))
    var_2 = vectortoangles(level.players[0].origin - var_0);
  else
    var_2 = (0, 0, 0);

  return maps\mp\agents\alien\alien_spider\_alien_spider::alienspiderspawn(var_0, var_2);
}

skip_second_spider_fight() {
  var_0 = getEntArray("blocker_02", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();

  maps\mp\mp_alien_armory_fx::fx_snow("heavy_snow_no_fog");
}

skip_third_spider_fight() {}

armory_enter_area_func(var_0) {
  if(!maps\mp\alien\_utility::is_chaos_mode())
    maps\mp\alien\_container_spawn::activate_container_spawners_in_area(var_0);
}

armory_leave_area_func(var_0) {
  if(!maps\mp\alien\_utility::is_chaos_mode())
    maps\mp\alien\_container_spawn::deactivate_container_spawners_in_area(var_0);
}

facility_hive() {
  maps\mp\alien\_hive::regular_hive();

  if(level.current_hive_name == "facility_hive_01_post")
    thread maps\mp\mp_alien_armory_vignettes::cross_lab_scene();
}

last_facility_hive() {
  var_0 = "queen_break_wall";
  var_1 = 4.5;
  var_2 = 5.0;
  maps\mp\alien\_hive::regular_hive();
  wait(randomfloatrange(1.0, var_2));
  level notify("queen_break_wall");
  level thread watch_spider_fight_trigger();
  wait(var_1);
  thread maps\mp\mp_alien_armory_vignettes::queen_hole_marker();
}

watch_spider_fight_trigger() {
  var_0 = getent("archer_escape", "targetname");
  var_0 waittill("trigger");
  common_scripts\utility::flag_set("start_spider_encounter");
}

init_container_spawn() {
  maps\mp\alien\_container_spawn::init_container_spawn();
  level.should_skip_area_activation_func = ::should_skip_area_activation;
  var_0 = [];
  var_0["container_spawn_2"] = ["checkpoint_hive_02"];
  var_0["container_spawn_3"] = ["checkpoint_hive_04"];
  var_0["container_spawn_4"] = ["compound_hive_04"];
  var_0["container_spawn_5"] = ["compound_hive_08"];
  var_0["container_spawn_6"] = ["compound_hive_03"];
  level thread maps\mp\alien\_container_spawn::container_spawn_hive_monitor(var_0);
}

should_skip_area_activation(var_0) {
  var_1 = ["container_spawn_2", "container_spawn_3", "container_spawn_4", "container_spawn_5", "container_spawn_6"];
  return common_scripts\utility::array_contains(var_1, var_0);
}

mp_alien_armory_try_use_drone_hive(var_0, var_1, var_2, var_3, var_4) {
  maps\mp\alien\_switchblade_alien::tryusedronehive(var_0, var_1, var_2, var_3, var_4);
}

jump_to_checkpoint() {}

jump_to_compound() {}

jump_to_compound_final() {}

jump_to_facility() {}

jump_to_loadingdock() {}

mp_alien_armory_pillage_init() {
  level.pillageinfo = spawnStruct();
  level.pillageinfo.alienattachment_model = "weapon_alien_muzzlebreak";
  level.pillageinfo.default_use_time = 1000;
  level.pillageinfo.money_stack = "pb_money_stack_01";
  level.pillageinfo.attachment_model = "has_spotter_scope";
  level.pillageinfo.maxammo_model = "mil_ammo_case_1_open";
  level.pillageinfo.flare_model = "mil_emergency_flare_mp";
  level.pillageinfo.clip_model = "weapon_baseweapon_clip";
  level.pillageinfo.soflam_model = "weapon_soflam";
  level.pillageinfo.leash_model = "weapon_knife_iw6";
  level.pillageinfo.trophy_model = "mp_trophy_system_folded_iw6";
  level.pillageinfo.ui_searching = 1;
  level.pillageinfo.easy_attachment = 30;
  level.pillageinfo.easy_money = 12;
  level.pillageinfo.easy_clip = 19;
  level.pillageinfo.easy_explosive = 15;
  level.pillageinfo.easy_soflam = 5;
  level.pillageinfo.easy_specialammo = 7;
  level.pillageinfo.easy_leash = 5;
  level.pillageinfo.easy_locker_key = 2;
  level.pillageinfo.easy_intel = 5;
  level.pillageinfo.medium_attachment = 30;
  level.pillageinfo.medium_explosive = 15;
  level.pillageinfo.medium_money = 10;
  level.pillageinfo.medium_clip = 10;
  level.pillageinfo.medium_specialammo = 10;
  level.pillageinfo.medium_leash = 5;
  level.pillageinfo.medium_soflam = 5;
  level.pillageinfo.medium_trophy = 5;
  level.pillageinfo.medium_locker_key = 5;
  level.pillageinfo.medium_intel = 5;
  level.pillageinfo.hard_attachment = 30;
  level.pillageinfo.hard_explosive = 14;
  level.pillageinfo.hard_leash = 10;
  level.pillageinfo.hard_maxammo = 10;
  level.pillageinfo.hard_specialammo = 11;
  level.pillageinfo.hard_money = 5;
  level.pillageinfo.hard_soflam = 5;
  level.pillageinfo.hard_trophy = 5;
  level.pillageinfo.hard_locker_key = 5;
  level.pillageinfo.hard_intel = 5;
  level.custom_build_pillageitem_array_func = ::armory_build_pillageitem_array_func;
  relocate_bad_pillage_spots();
}

relocate_bad_pillage_spots() {
  var_0 = common_scripts\utility::getstructarray("pillage_compound_3", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.origin == (-1324.8, -3134.5, 687.9)) {
      var_2.origin = (-1241, -3234, 674);
      var_2.angles = (1, 0, 0);
    }
  }
}

armory_build_pillageitem_array_func(var_0) {
  level thread maps\mp\alien\_pillage_intel::build_intel_pillageitem_arrays(var_0);
}

mp_alien_armory_onspawnplayer_func() {
  thread maps\mp\alien\_armory_weapon::special_gun_watcher();
  thread maps\mp\alien\_music_and_dialog_dlc::dlc_vo_init_on_player_spawn();
  thread maps\mp\alien\_pillage_intel::intel_on_player_connect();
  thread maps\mp\mp_alien_armory_vignettes::gate_check();
  thread maps\mp\alien\_achievement::eggallfoundforpack(0);

  if(!isDefined(level.setskillsflag)) {
    level.setskillsflag = 1;
    common_scripts\utility::flag_set("give_player_abilities");
  }

  thread maps\mp\alien\_alien_class_skills_main::assign_skills();
}

mp_alien_armory_scale_alien_damage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(is_spider_beam_weapon(var_5))
    var_2 = var_2 * 15;

  return var_2;
}

is_spider_beam_weapon(var_0) {
  return isDefined(var_0) && var_0 == "spider_beam_mp";
}

easter_egg_conduit() {
  level endon("game_ended");
  level endon("easter_egg_conduit_complete");
  level endon("easter_egg_conduit_failed");
  level.easter_egg_conduit_hits = 0;
  level.easter_egg_conduit_trigs = getEntArray("conduit_trig", "targetname");

  if(!isDefined(level.easter_egg_conduit_trigs) || level.easter_egg_conduit_trigs.size == 0) {
    return;
  }
  var_0 = level.easter_egg_conduit_trigs[randomint(level.easter_egg_conduit_trigs.size)];
  level.easter_egg_conduit_trigs = sortbydistance(level.easter_egg_conduit_trigs, var_0.origin);
  var_1 = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_3 = level.easter_egg_conduit_trigs[var_2];
    var_3.health = 1000000;
    var_3.id = var_2;
    var_3.hit = 0;
    var_3.window_active = 0;
    var_3.spark_structs = common_scripts\utility::getstructarray(var_3.target, "targetname");
    var_1[var_1.size] = var_3;
  }

  var_1 = common_scripts\utility::array_randomize(var_1);
  common_scripts\utility::array_thread(var_1, ::monitor_conduit_hit);
  var_4 = 0;
  var_5 = 0;

  for(;;) {
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_6 = var_1[var_2];

      if(!var_6.hit) {
        playsoundatpos(var_6.origin, "emt_aln_arm_trans_sparks");

        foreach(var_8 in var_6.spark_structs) {
          playFX(loadfx("vfx/moments/alien/easter_egg_conduit_spark"), var_8.origin);
          playFX(loadfx("vfx/moments/alien/fence_lightning_shock"), var_8.origin);
        }

        var_6.window_active = 1;
        wait 6;
        var_6.window_active = 0;
        continue;
      }

      wait 6;
    }
  }
}

monitor_conduit_hit() {
  level endon("easter_egg_conduit_complete");
  level endon("easter_egg_conduit_failed");

  for(;;) {
    var_0 = spawn("script_model", self.spark_structs[0].origin);
    var_0 setModel("tag_origin");
    var_0.health = 1000000;
    var_0 endon("death");
    var_0 setCanDamage(1);
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_2) && isplayer(var_2) && isDefined(var_5) && var_5 == "MOD_EXPLOSIVE" && isDefined(var_9) && var_9 == 5 && !isDefined(var_10)) {
      if(self.window_active) {
        if(level.easter_egg_conduit_hits == 0)
          level thread monitor_fail_condition();

        self.hit = 1;
        level.easter_egg_conduit_hits++;
      } else
        level notify("easter_egg_conduit_failed");

      var_0 delete();
      return;
    }

    self.health = self.health + var_1;
  }
}

monitor_fail_condition() {
  level endon("easter_egg_conduit_complete");
  level endon("easter_egg_conduit_failed");
  wait 24;
  wait 0.5;

  if(level.easter_egg_conduit_hits < 4)
    level notify("easter_egg_conduit_failed");
  else {
    level thread activate_easter_egg_conduit();
    level notify("easter_egg_conduit_complete");
  }
}

activate_easter_egg_conduit() {
  iprintln(&"ALIENS_PATCH_ZAP");
  level._effect["arcade_death"] = loadfx("vfx/moments/alien/vfx_alien_arcade_death_dlc1");
  level.easter_egg_lodge_sign_active = 1;
  wait 300;
  level.easter_egg_lodge_sign_active = 0;
}

armory_cangive_weapon_handler_func(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(self hasweapon("aliensoflam_mp"))
    var_4++;

  if(self.hasriotshield || self.hasriotshieldequipped)
    var_4++;

  if(var_1 == "iw6_aliendlc11_mp" && var_0.size + 1 > var_3 + var_4)
    return 0;

  return 1;
}

armory_give_weapon_handler_func(var_0) {
  if(self getcurrentweapon() == "iw6_aliendlc11_mp")
    return 0;

  return undefined;
}

manage_direction_triggers() {
  level.current_direction_triggers = ["ocean", "mountain", "tower", "security_gate", "compound", "helipad"];
  level waittill("spider_fight_1_complete");
  level.current_direction_triggers = [];
  wait_for_scene_trig_over("compound_scripted_spawn");
  level.current_direction_triggers = ["rooftop", "helipad", "storage", "factory"];
  level waittill("factory_blocker_gone");
  level.current_direction_triggers = [];
  wait_for_scene_trig_over("facility_scripted_spawn");
  level.current_direction_triggers = ["window"];
  level waittill("factory_blocker_gone");
  level.current_direction_triggers = [];
}

wait_for_scene_trig_over(var_0) {
  var_1 = getEntArray("scene_trig", "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.target) && var_3.target == var_0) {
      var_3 waittill("trigger");
      break;
    }
  }

  wait 25;
}

is_generic_electric_trap_func() {
  var_0 = ["container_electric_node_01", "checkpoint_electric_trap_node_01b", "electric_trap_node_01", "catwalk_electric_trap", "electric_node_00b"];

  if(isDefined(self.generator) && isDefined(self.generator.target) && common_scripts\utility::array_contains(var_0, self.generator.target))
    return 1;

  return 0;
}

mp_alien_armory_intermission_func() {
  self endon("disconnect");
  self notify("spawned");
  self notify("end_respawn");
  self stopshellshock();
  self stoprumble("damage_heavy");
  self.deathposition = undefined;
  maps\mp\_utility::freezecontrolswrapper(1);
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  var_0 = self.pers["postGameChallenges"];
  self playerhide();
  maps\mp\_utility::clearkillcamstate();
  self.friendlydamage = undefined;
  var_1 = select_best_intermission_point();
  self spawn(var_1.origin, var_1.angles);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
  self.anchor = spawn("script_model", self.origin);
  self.anchor.angles = var_1.angles;
  self.anchor setModel("tag_origin");
  self cameralinkto(self.anchor, "tag_origin");
  common_scripts\utility::waitframe();

  if(!isDefined(var_1.target)) {
    return;
  }
  var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");

  for(;;) {
    self.anchor moveto(var_2.origin, 25);
    self.anchor rotateto(var_2.angles, 25);
    wait 25;

    if(!isDefined(var_2.target)) {
      break;
    }

    var_2 = common_scripts\utility::getstruct(var_2.target, "targetname");
  }
}

select_best_intermission_point() {
  var_0 = maps\mp\alien\_utility::get_current_area_name();
  var_1 = common_scripts\utility::getstructarray(var_0 + "_intermission", "script_noteworthy");

  switch (var_0) {
    case "loadingdock":
      return get_best_struct_facing_boss(var_1, level.spider);
  }

  if(isDefined(var_1))
    return common_scripts\utility::random(var_1);
}

get_best_struct_facing_boss(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(common_scripts\utility::within_fov(var_1.origin, var_1.angles, var_4.origin, cos(35)))
      var_2[var_2.size] = var_4;
  }

  if(var_2.size < 1)
    return common_scripts\utility::random(var_0);

  return common_scripts\utility::random(var_2);
}

create_dropped_pillage_item(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.pillage_trigger = spawn("script_model", self.origin);
  var_5.pillage_trigger setModel(var_1);
  var_5.pillage_trigger setcursorhint("HINT_NOICON");

  if(maps\mp\alien\_utility::alien_mode_has("outline"))
    maps\mp\alien\_outline_proto::add_to_outline_pillage_watch_list(var_5.pillage_trigger, 0);

  var_6 = spawnStruct();
  var_6.type = var_0;

  if(var_6.type == "explosive") {
    var_6.explosive_type = maps\mp\alien\_pillage::choose_random_explosive_type();
    var_6.explosive_type = "aliensemtex_mp";
    var_5.pillage_trigger setModel(getweaponmodel(var_6.explosive_type));
  }

  var_6.count = var_2;
  var_7 = var_6 get_string_for_hintstring();
  var_8 = maps\mp\alien\_pillage::get_hintstring_for_item_pickup(var_7);
  var_5.pillage_trigger sethintstring(var_8);
  var_5.pillage_trigger makeusable();
  var_5.pillageinfo = spawnStruct();
  var_5.pillageinfo.type = var_0;

  if(!isDefined(var_4))
    var_4 = 1;

  var_5.pillageinfo.ammo = var_4;

  if(isDefined(var_3))
    var_5.pillageinfo.item = var_3;

  if(var_6.type == "explosive")
    var_5.pillageinfo.item = var_6.explosive_type;

  var_9 = common_scripts\utility::drop_to_ground(var_5.pillage_trigger.origin);
  var_5.pillage_trigger moveto(var_9 + (0, 0, 4), 0.75);
  var_5 thread maps\mp\alien\_pillage::pillage_spot_think();
  var_5.enabled = 1;
  var_5.searched = 1;
}

get_string_for_hintstring() {
  var_0 = self.type;

  switch (self.type) {
    case "grenade":
      var_0 = "aliensemtex_mp";
      break;
    case "explosive":
      var_0 = self.explosive_type;
      break;
    default:
      break;
  }

  return var_0;
}

armory_locker_weapon_pickup_string_func(var_0) {
  var_0 = "" + var_0;

  switch (var_0) {
    case "weapon_kriss_v":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_KRISS";
    case "weapon_vepr":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_VEPR";
    case "weapon_maul":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_MAUL";
    case "weapon_mts_255":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_MTS255";
    case "weapon_vks":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_VKS";
    case "weapon_l115a3":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_L115A3";
    case "weapon_kac_chainsaw":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_KAC";
    case "weapon_arx_160":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_ARX_160";
    case "weapon_g28":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_G28";
    case "weapon_lsat_iw6":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_LSAT";
    case "weapon_dragunov_svu":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_SVU";
    case "weapon_kastet":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_KASTET";
    case "weapon_rm_22":
      return & "ALIEN_PICKUPS_ARMORY_LOCKER_MAVERICK";
  }
}

should_play_next_hive_vo_func() {
  if(!maps\mp\alien\_utility::isplayingsolo() && (level.cycle_count == 3 || level.cycle_count == 7 || level.cycle_count == 8 || level.cycle_count == 10))
    return 1;

  return 0;
}

force_all_players_in_final_area() {
  var_0 = common_scripts\utility::getstructarray("final_battle_player_teleport", "script_noteworthy");
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!var_3 should_teleport_player()) {
      continue;
    }
    var_1[var_1.size] = var_3;
    var_3 thread do_teleport_messaging();
  }

  if(var_1.size < 1) {
    return;
  }
  level waittill("teleport_players_to_final");

  for(;;) {
    var_5 = 0;

    foreach(var_7, var_3 in var_1) {
      if(!var_3 should_teleport_player()) {
        continue;
      }
      if(!var_3 maps\mp\alien\_utility::is_in_laststand() && !maps\mp\alien\_utility::is_true(var_3.isreviving) || var_3.sessionstate == "spectator") {
        var_3 thread find_valid_spot_to_teleport(var_0);
        var_3.being_teleported = 1;
        continue;
      }

      var_5 = 1;
    }

    if(!var_5) {
      break;
    }

    wait 0.05;
  }

  level thread teleport_dog_tags();
  wait 3;
  var_8 = getent("final_battle_player_check", "targetname");

  foreach(var_3 in level.players) {
    if(isalive(var_3) && var_3 istouching(var_8)) {
      continue;
    }
    var_3 thread find_valid_spot_to_teleport(var_0);
  }
}

teleport_dog_tags() {
  var_0 = common_scripts\utility::getstructarray("final_battle_player_teleport", "script_noteworthy");
  var_1 = (0, 0, 30);

  foreach(var_4, var_3 in level.players) {
    if(var_3.sessionstate == "spectator") {
      if(isDefined(var_3.reviveent))
        var_3.reviveent.origin = var_0[var_4].origin;

      if(isDefined(var_3.reviveiconent))
        var_3.reviveiconent.origin = var_0[var_4].origin + var_1;

      var_3.forceteleportorigin = var_0[var_4].origin;
      var_3.forceteleportangles = var_0[var_4].angles;
    }
  }
}

should_teleport_player() {
  var_0 = getent("final_battle_player_check", "targetname");

  if(isDefined(self.being_teleported))
    return 0;

  if(!isalive(self) || self istouching(var_0))
    return 0;

  return 1;
}

find_valid_spot_to_teleport(var_0) {
  for(;;) {
    foreach(var_2 in var_0) {
      if(canspawn(var_2.origin) && !positionwouldtelefrag(var_2.origin)) {
        thread teleport_player_to_final_area(var_2);
        return;
      }
    }

    wait 0.05;
  }
}

teleport_player_to_final_area(var_0) {
  self endon("disconnect");
  thread teleport_black_screen();
  wait 1;
  self cancelmantle();
  self dontinterpolate();
  self setorigin(var_0.origin);
  self setplayerangles(var_0.angles);
  self notify("teleport_finished");
}

do_teleport_messaging() {
  self endon("death");
  var_0 = getent("final_battle_player_check", "targetname");
  self iprintlnbold(&"MP_ALIEN_ARMORY_TELEPORT_PLAYER");
  wait 1;

  for(var_1 = 9; var_1 > 0; var_1--) {
    if(self istouching(var_0)) {
      wait 1;
      continue;
    }

    self iprintlnbold(var_1);
    wait 1;
  }

  level notify("teleport_players_to_final");
}

teleport_black_screen() {
  self endon("disconnect");
  self.teleport_overlay = newclienthudelem(self);
  self.teleport_overlay.x = 0;
  self.teleport_overlay.y = 0;
  self.teleport_overlay setshader("black", 640, 480);
  self.teleport_overlay.alignx = "left";
  self.teleport_overlay.aligny = "top";
  self.teleport_overlay.sort = 1;
  self.teleport_overlay.horzalign = "fullscreen";
  self.teleport_overlay.vertalign = "fullscreen";
  self.teleport_overlay.alpha = 0;
  self.teleport_overlay.foreground = 1;
  self.teleport_overlay fadeovertime(0.75);
  self.teleport_overlay.alpha = 1;
  self waittill("teleport_finished");
  self.teleport_overlay fadeovertime(0.75);
  self.teleport_overlay.alpha = 0;
  wait 1;
  self.teleport_overlay destroy();
}

set_spawn_table() {
  if(maps\mp\alien\_utility::is_chaos_mode())
    set_chaos_spawn_table();
  else {
    if(maps\mp\alien\_utility::is_hardcore_mode()) {
      set_hardcore_extinction_spawn_table();
      return;
    }

    set_regular_extinction_spawn_table();
  }
}

set_chaos_spawn_table() {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    switch (maps\mp\alien\_utility::get_chaos_area()) {
      case "checkpoint":
        level.alien_cycle_table = "mp/alien/chaos_spawn_armory_checkpoint_sp.csv";
        break;
      case "compound":
        level.alien_cycle_table = "mp/alien/chaos_spawn_armory_compound_sp.csv";
        break;
      case "facility":
        level.alien_cycle_table = "mp/alien/chaos_spawn_armory_facility_sp.csv";
        break;
    }
  } else {
    switch (maps\mp\alien\_utility::get_chaos_area()) {
      case "checkpoint":
        level.alien_cycle_table = "mp/alien/chaos_spawn_armory_checkpoint.csv";
        break;
      case "compound":
        level.alien_cycle_table = "mp/alien/chaos_spawn_armory_compound.csv";
        break;
      case "facility":
        level.alien_cycle_table = "mp/alien/chaos_spawn_armory_facility.csv";
        break;
    }
  }
}

set_regular_extinction_spawn_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.alien_cycle_table = "mp/alien/cycle_spawn_armory_sp.csv";
  else
    level.alien_cycle_table = "mp/alien/cycle_spawn_armory.csv";
}

chaos_init() {
  maps\mp\alien\_hive::init_hive_locs();
  maps\mp\alien\_chaos::init();
  register_egg_default_loc();
  set_end_cam_position();
  level thread armory_chaos_nondeterministic_entity_handler();
}

armory_chaos_nondeterministic_entity_handler() {
  level endon("game_ended");
  var_0 = 5;
  wait(var_0);
  open_intro_fence();
  move_patchable_clip_to_compound();
  delete_snow_mound();
  maps\mp\mp_alien_armory_vignettes::spider_exit_a_props();
}

delete_snow_mound() {
  var_0 = getEntArray("snow_debris_static", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }

  var_4 = getEntArray("spider_mound_clip", "targetname");

  foreach(var_2 in var_4) {
    if(isDefined(var_2)) {
      var_2 connectpaths();
      var_2 delete();
    }
  }
}

move_patchable_clip_to_compound() {
  move_player256x256x8();
  move_player256x256x128();
  move_player512x512x8();
  move_clip512x512x8();
  move_clip256x256x8();
  move_clip256x256x128();
  move_box_models();
}

move_box_models() {
  var_0 = spawn("script_model", (-2665, -5071, 818));
  var_0 setModel("clk_crate48x64_snow");
  var_0.angles = (0, 270, 0);
  var_1 = spawn("script_model", (-2674, -5127, 818));
  var_1 setModel("clk_crate48x64_snow");
  var_1.angles = (0, 180, 0);
}

move_player256x256x8() {
  var_0 = getent("player256x256x8", "targetname");
  var_1 = spawn("script_model", (-3440, -5001, 860));
  var_1.angles = (270, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

move_player256x256x128() {
  var_0 = getent("player256x256x128", "targetname");
  var_1 = spawn("script_model", (-4084, -5168, 860));
  var_1.angles = (270, 270, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

move_player512x512x8() {
  var_0 = getent("player512x512x8", "targetname");
  var_1 = spawn("script_model", (-3700, -5048, 984));
  var_1.angles = (270, 270, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

move_clip512x512x8() {
  var_0 = getent("player512x512x8", "targetname");
  var_1 = spawn("script_model", (-2828, -5128, 1072));
  var_1.angles = (270, 180, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

move_clip256x256x8() {
  var_0 = getent("player256x256x8", "targetname");
  var_1 = spawn("script_model", (-2692, -5162, 938));
  var_1.angles = (270, 90, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

move_clip256x256x128() {
  var_0 = getent("clip256x256x128", "targetname");
  var_0.origin = (-2570, -5172, 938);
  var_0.angles = (270, 0, 0);
  var_0 disconnectpaths();
}

set_end_cam_position() {
  var_0 = getEntArray("mp_global_intermission", "classname");
  var_1 = common_scripts\utility::getclosest(level.eggs_default_loc, var_0);

  switch (maps\mp\alien\_utility::get_chaos_area()) {
    case "checkpoint":
      var_1.origin = (-2000, -7020, 848);
      var_1.angles = (15, 110, -8);
      break;
    case "facility":
      var_1.origin = (-2000, -7020, 848);
      var_1.angles = (15, 110, -8);
      break;
  }
}

player_initial_spawn_loc_override() {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    chaos_player_initial_spawn_loc_override();
    return;
  }
}

chaos_player_initial_spawn_loc_override() {
  var_0 = [];

  switch (maps\mp\alien\_utility::get_chaos_area()) {
    case "compound":
      var_0 = [(-3249, -4639, 600), (-3394, -4668, 620), (-3027, -4599, 619), (-2896, -4625, 634)];
      break;
  }

  self.forcespawnorigin = var_0[level.players.size];
  self.forcespawnangles = (0, 90, 0);
}

register_egg_default_loc() {
  switch (maps\mp\alien\_utility::get_chaos_area()) {
    case "checkpoint":
      maps\mp\alien\_chaos::set_egg_default_loc((-2576, -6307, -36));
      break;
    case "compound":
      maps\mp\alien\_chaos::set_egg_default_loc((-2576, -6307, -36));
      break;
    case "facility":
      maps\mp\alien\_chaos::set_egg_default_loc((-2576, -6307, -36));
      break;
  }
}

open_intro_fence() {
  var_0 = getEntArray("intro_fence", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }

  var_4 = getscriptablearray("intro_fence_script", "targetname");
  var_4[0] setscriptablepartstate(0, 3);
}

set_hardcore_extinction_spawn_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_armory_hardcore_sp.csv";
  else
    level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_armory_hardcore.csv";
}

move_clip_brush_checkpoint_lakeside() {
  var_0 = getent("player512x512x8", "targetname");
  var_1 = spawn("script_model", (-1414, -6356, 650));
  var_1.angles = (270, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

move_clip_brush_checkpoint_lakeside_boxes() {
  var_0 = getent("player128x128x8", "targetname");
  var_1 = spawn("script_model", (-1554, -5942, 892));
  var_1.angles = (270.5, 6.19994, -89.9999);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

spawn_weapon_in_boss_area() {
  var_0 = spawnStruct();
  var_0.script_noteworthy = "weapon_iw6_aliendlc15_mp";
  var_0.targetname = "item";
  var_0.origin = (-2948, 485, 692);
  var_0.angles = (60, 0, 0);
  var_0.radius = 200;
  return var_0;
}