/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_beacon.gsc
***************************************/

main() {
  level.additional_boss_weapon = ::spawn_weapon_in_boss_area;
  level thread setintermissioncam();
  level.prematchperiod = 13;
  level.icargohives = 0;
  level.extinction_episode = 2;
  level.introscreen_line_1 = &"MP_ALIEN_BEACON_INTRO_LINE_1";
  level.introscreen_line_2 = &"MP_ALIEN_BEACON_INTRO_LINE_2";
  level.introscreen_line_3 = &"MP_ALIEN_BEACON_INTRO_LINE_3";
  level.introscreen_line_4 = &"MP_ALIEN_BEACON_INTRO_LINE_4";
  common_scripts\utility::flag_init("players_on_top_deck");
  common_scripts\utility::flag_init("tp_to_kraken_on_spawn");
  common_scripts\utility::flag_init("stop_tp_to_well_deck");
  maps\mp\alien\_utility::alien_mode_enable("kill_resource", "challenge", "wave", "airdrop", "lurker", "collectible", "loot", "pillage", "outline", "scenes");
  level thread maps\mp\alien\_crafting::init();
  level thread maps\mp\alien\_crafting_traps::init();
  level.ricochetdamagemax = 25;
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
  var_0 = ["well_deck", "hallway_1", "cargo", "front_boat", "heli_pad"];
  setDvar("sm_sunSampleSizeNear", 0.25);
  maps\mp\alien\_utility::alien_area_init(var_0);
  level.include_default_challenges = 1;
  level.challenge_registration_func = maps\mp\alien\mp_alien_beacon_challenges::register_beacon_challenges;
  level.challenge_scalar_func = maps\mp\alien\mp_alien_beacon_challenges::beacon_challenge_scalar_func;
  level.custom_death_challenge_func = maps\mp\alien\mp_alien_beacon_challenges::beacon_death_challenge_func;
  level.custom_damage_challenge_func = maps\mp\alien\mp_alien_beacon_challenges::beacon_damage_challenge_func;
  level.include_default_achievements = 1;
  level.include_default_unlocks = 1;
  level.escape_cycle = 21;
  level.custom_pillageinitfunc = ::mp_alien_beacon_pillage_init;
  level.create_attackable_ent_override_func = ::mp_alien_beacon_attackable_ent_override;
  level.drill_attack_setup_override = ::mp_alien_beacon_drill_attack_override;
  level.weapon_stats_override_name_func = ::beacon_weapon_stats_update_name;
  level.get_custom_cycle_func = ::pre_hive;
  level.achievement_registration_func = maps\mp\alien\_achievement_dlc2::register_achievements_dlc2;
  level.update_alien_kill_achievements_func = maps\mp\alien\_achievement_dlc2::update_alien_kill_achievements_dlc2;
  level.update_achievement_hypno_trap_func = maps\mp\alien\_achievement_dlc2::update_hypno_trap_rhino;
  level.update_achievement_craft_items_func = maps\mp\alien\_achievement_dlc2::update_craft_all_items_achievement;
  level.skip_radius_damage_on_puddles = 1;
  level.adjust_spawnlocation_func = ::beacon_adjust_spawnlocation;
  level.custom_alien_death_func = maps\mp\alien\_death::general_alien_custom_death;
  level.custom_cangive_weapon_func = ::beacon_cangive_weapon_handler_func;
  level.custom_give_weapon_func = ::beacon_give_weapon_handler_func;
  level.hive_icon_override = ::beacon_hive_icon_override_func;
  level.give_randombox_item_check = ::beacon_randombox_item_check;
  level.hypno_trap_func = maps\mp\alien\_crafting_traps::tryuseplaceable;
  level.tesla_trap_func = maps\mp\alien\_crafting_traps::tryuseplaceable;
  maps\mp\alien\_alien_maaws::alien_maaws_init();
  maps\mp\alien\_pillage_locker::locker_pillage_functions_init();
  level.level_locker_weapon_pickup_string_func = ::beacon_locker_weapon_pickup_string_func;
  level.cac_vo_male = common_scripts\utility::array_randomize(["p6_", "p5_"]);
  level.cac_vo_female = common_scripts\utility::array_randomize(["p8_", "p7_"]);
  level.custom_onspawnplayer_func = ::mp_alien_beacon_onspawnplayer_func;
  level.initial_spawn_loc_override_func = ::beacon_player_initial_spawn_loc_override;
  level.enter_area_func = ::beacon_enter_area_func;
  level.leave_area_func = ::beacon_leave_area_func;
  level.watch_bomb_stuck_override = ::beacon_watch_bomb_stuck_override;
  level.get_alien_model_func = ::beacon_get_alien_model;
  level.level_specific_vo_callouts = ::beacon_specific_vo_callouts;
  level.non_player_drill_plant_check = ::beacon_non_player_drill_plant_check;
  level.non_player_drill_plant = 0;
  level.intel_table = "mp/alien/alien_beacon_intel.csv";
  level.randombox_table = "mp/alien/beacon_deployable_randombox.csv";
  level maps\mp\alien\mp_alien_beacon_turret::beacon_turret_init();
  level thread maps\mp\mp_alien_beacon_fx::ship_camera_tilting();
  set_spawn_table();
  set_container_spawn_table();
  set_alien_definition_table();
  level.alien_collectibles_table = "mp/alien/collectibles_beacon.csv";
  level.spawn_node_info_table = "mp/alien/beacon_spawn_node_info.csv";
  level.alien_challenge_table = "mp/alien/mp_alien_beacon_challenges.csv";

  if(maps\mp\alien\_utility::isplayingsolo())
    level.base_player_count_multiplier = 1;
  else
    level.base_player_count_multiplier = 0.49;

  level.additional_player_count_multiplier = 0.17;
  level.waypoint_dist_override = 2500;
  maps\mp\mp_alien_beacon_precache::main();
  maps\createart\mp_alien_beacon_art::main();
  maps\mp\mp_alien_beacon_fx::main();
  init_level_flags();
  level.hintprecachefunc = ::beacon_hint_precache;
  maps\mp\alien\_beacon_weapon::init();
  maps\mp\_load::main();
  game["thermal_vision"] = "mp_alien_beacon_thermal";
  visionsetthermal(game["thermal_vision"]);
  game["thermal_vision_trinity"] = "mp_alien_thermal_trinity";
  setDvar("sm_sunShadowScale", "0.5");
  maps\mp\_utility::setdvar_cg_ng("r_specularColorScale", 4.0, 6.0);
  maps\mp\_compass::setupminimap("compass_map_mp_alien_beacon");
  var_1 = 20000;
  var_2 = 40000;
  var_3 = 70000;
  var_4 = 240000;
  maps\mp\alien\_persistence::register_lb_escape_rank([0, var_1, var_2, var_3, var_4]);
  var_5 = ["mini_lung_00"];
  maps\mp\alien\_utility::add_hive_dependencies("well_deck_2", var_5);
  var_6 = ["well_deck_2"];
  maps\mp\alien\_utility::add_hive_dependencies("door_hive_4", var_6);
  maps\mp\alien\_utility::add_hive_dependencies("well_deck_3", var_6);
  maps\mp\alien\_utility::add_hive_dependencies("door_hive_6", var_6);
  var_7 = ["door_hive_4"];
  maps\mp\alien\_utility::add_hive_dependencies("well_deck_3", var_7);
  maps\mp\alien\_utility::add_hive_dependencies("door_hive_6", var_7);
  var_8 = ["well_deck_3"];
  maps\mp\alien\_utility::add_hive_dependencies("door_hive_6", var_8);
  maps\mp\alien\_utility::add_hive_dependencies("door_hive_7", var_8);
  maps\mp\alien\_utility::add_hive_dependencies("door_hive_8", var_8);
  var_9 = ["door_hive_6"];
  maps\mp\alien\_utility::add_hive_dependencies("cargo_area_mini_1", var_9);
  maps\mp\alien\_utility::add_hive_dependencies("cargo_area_mini_2", var_9);
  maps\mp\alien\_utility::add_hive_dependencies("cargo_area_mini_3", var_9);
  maps\mp\alien\_utility::add_hive_dependencies("cargo_area_mini_4", var_9);
  maps\mp\alien\_utility::add_hive_dependencies("cargo_area_main", var_9);
  maps\mp\alien\_utility::add_hive_dependencies("door_hive_7", var_9);
  maps\mp\alien\_utility::add_hive_dependencies("door_hive_8", var_9);
  var_10 = ["top_deck_mini_1", "top_deck_mini_2", "top_deck_mini_3"];
  maps\mp\alien\_utility::add_hive_dependencies("lab_mini_1", var_10);
  maps\mp\alien\_utility::add_hive_dependencies("lab_mini_2", var_10);
  maps\mp\alien\_utility::add_hive_dependencies("lab_mini_3", var_10);
  maps\mp\alien\_utility::add_hive_dependencies("lab_mini_4", var_10);
  maps\mp\alien\_utility::add_hive_dependencies("door_hive_10", var_10);
  var_11 = ["cargo_area_mini_2"];
  maps\mp\alien\_utility::add_hive_dependencies("cargo_area_mini_3", var_11);
  var_12 = ["cargo_area_main"];
  maps\mp\alien\_utility::add_hive_dependencies("top_deck_mini_3", var_12);
  maps\mp\alien\_utility::add_hive_dependencies("top_deck_mini_1", var_12);
  maps\mp\alien\_utility::add_hive_dependencies("top_deck_mini_2", var_12);
  maps\mp\alien\_utility::add_hive_dependencies("door_hive_9", var_12);
  var_13 = ["cargo_area_mini_1", "cargo_area_mini_2", "cargo_area_mini_3", "cargo_area_mini_4"];
  maps\mp\alien\_utility::add_hive_dependencies("cargo_area_main", var_13);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "woodland";
  var_14 = [];
  var_15 = [8];
  maps\mp\gametypes\aliens::setup_cycle_end_area_list(var_15);
  maps\mp\gametypes\aliens::setup_blocker_hives(var_14);
  maps\mp\gametypes\aliens::setup_last_hive("bomblocation_14");
  init_seeder();
  register_encounter();
  maps\mp\mp_alien_beacon_vignettes::main();

  if(!maps\mp\alien\_utility::is_chaos_mode())
    init_container_spawn();

  maps\mp\alien\_pillage_intel::create_intel_spots();
  level thread maps\mp\alien\mp_alien_beacon_turret::set_up_remote_turrets();
  thread maps\mp\alien\_alien_class_skills_main::main();
  level thread beacon_intro_drill();
  level thread beacon_door_encounter_logic();
  level thread player_death_trigger_monitor();
  level thread crane_walls_hide();
  level.ammoincompatibleweaponslist = [];
  level.ammoincompatibleweaponslist[0] = "iw5_alienriotshield_mp";
  level.ammoincompatibleweaponslist[1] = "iw5_alienriotshield1_mp";
  level.ammoincompatibleweaponslist[2] = "iw5_alienriotshield2_mp";
  level.ammoincompatibleweaponslist[3] = "iw5_alienriotshield3_mp";
  level.ammoincompatibleweaponslist[4] = "iw5_alienriotshield4_mp";
  level.ammoincompatibleweaponslist[5] = "iw6_alienminigun_mp";
  level.ammoincompatibleweaponslist[6] = "iw6_alienminigun1_mp";
  level.ammoincompatibleweaponslist[7] = "iw6_alienminigun2_mp";
  level.ammoincompatibleweaponslist[8] = "iw6_alienminigun3_mp";
  level.ammoincompatibleweaponslist[9] = "iw6_alienminigun4_mp";
  level.ammoincompatibleweaponslist[10] = "iw6_alienmk32_mp";
  level.ammoincompatibleweaponslist[11] = "iw6_alienmk321_mp";
  level.ammoincompatibleweaponslist[12] = "iw6_alienmk322_mp";
  level.ammoincompatibleweaponslist[13] = "iw6_alienmk323_mp";
  level.ammoincompatibleweaponslist[14] = "iw6_alienmk324_mp";
  level.ammoincompatibleweaponslist[15] = "iw6_aliendlc11_mp";
  level.ammoincompatibleweaponslist[16] = "iw6_aliendlc11li_mp";
  level.ammoincompatibleweaponslist[17] = "iw6_aliendlc11sp_mp";
  level.ammoincompatibleweaponslist[18] = "iw6_aliendlc11fi_mp";
  thread beacon_intro_music();
  level thread setup_beacon_offhands();
  level thread fix_bad_drill_spots();
  level thread maps\mp\alien\_music_and_dialog_dlc::remove_drill_vo_once_complete();
  level thread cleanup_strings();
}

fix_bad_drill_spots() {
  level endon("game_ended");
  level waittill("spawn_nondeterministic_entities");
  var_0 = getent("player64x64x256", "targetname");

  if(isDefined(var_0)) {
    var_0 moveto((-347.4, 2044.1, 1033.04), 0.05);
    var_0.angles = (0, 0, 0);
  }

  var_1 = getent("clip64x64x64", "targetname");

  if(isDefined(var_1)) {
    var_1 moveto((-811.5, -2114.5, 75), 0.05);
    var_1.angles = (0, 0, 0);
  }

  var_2 = getent("monsterjplayerclip512x8x256", "targetname");

  if(isDefined(var_2)) {
    var_2.origin = (-856, 3590, 1152);
    var_2.angles = (0, 270, 0);
  }

  var_3 = getent("clip64x64x128", "targetname");

  if(isDefined(var_3)) {
    var_3.origin = (276, 6176, 1152);
    var_3.angles = (0, 0, 0);
  }

  var_4 = getent("player512x512x8", "targetname");

  if(isDefined(var_4)) {
    var_4.origin = (752, 3398, 64);
    var_4.angles = (270, 180, 180);
    var_5 = spawn("script_model", (842, 3218, 440));
    var_5 clonebrushmodeltoscriptmodel(var_4);
    var_5.origin = (842, 3218, 440);
    var_5.angles = (270, 180, 180);
  }

  var_6 = getent("monsterplayer512x512x8", "targetname");

  if(isDefined(var_6)) {
    var_6.origin = (1098, 3046, 440);
    var_6.angles = (270, 270, -180);
    var_7 = spawn("script_model", (891, 3038, 184));
    var_7 setModel("tool_cabinet_02_iw6");
    var_7.angles = (0, 180, 0);
  }
}

cleanup_strings() {
  var_0 = 5.0;
  wait(var_0);
  var_1 = getarraykeys(game["dialog"]);

  foreach(var_3 in var_1) {
    if(game["dialog"][var_3] == "enemy_null" || game["dialog"][var_3] == "friendly_null" || game["dialog"][var_3] == "null")
      game["dialog"][var_3] = undefined;
  }

  game["dialog"] = common_scripts\utility::array_removeundefined(game["dialog"]);
}

setup_beacon_offhands() {
  while(!isDefined(level.offhand_explosives))
    wait 1;

  level.offhand_explosives = common_scripts\utility::array_add(level.offhand_explosives, "iw6_aliendlc22_mp");
  level.offhand_secondaries = common_scripts\utility::array_add(level.offhand_secondaries, "iw6_aliendlc21_mp");
}

beacon_intro_drill() {
  level waittill("spawn_beacon_drill", var_0, var_1);
  level notify("spawn_intro_drill", var_0, var_1);
  common_scripts\utility::flag_set("intro_sequence_complete");
}

waypoint_after_drill_picked_up() {
  level waittill("drill_pickedup");
  level thread place_waypoint_on_blocker_door();
}

place_waypoint_on_blocker_door() {
  var_0 = (-40, 874, 340);
  var_1 = "waypoint_alien_blocker";
  var_2 = 14;
  var_3 = 14;
  var_4 = 0.75;
  var_5 = var_0 + (0, 0, 4);
  var_6 = maps\mp\alien\_hud::make_waypoint(var_1, var_2, var_3, var_4, var_5);

  for(;;) {
    level waittill("drill_planted");

    if(level.current_hive_name == "cargo_area_main") {
      break;
    } else {
      var_6.alpha = 0;
      level waittill("drill_pickedup");
      var_6.alpha = 0.75;
    }
  }

  var_6 destroy();
}

use_drillbot_door(var_0, var_1) {
  var_2 = var_1.script_angles;

  if(isDefined(var_0))
    var_2 = var_2 * -1;

  var_1 moveto(var_1.origin + var_2, 2);
  playsoundatpos(var_1.origin, "scn_drillbot_door");
}

spawn_beacon_cargo_drillbot() {
  var_0 = getvehiclenode("cargo_drillbot_start", "targetname");
  level.drill_vehicle = spawnvehicle("vehicle_drill_bot", "drill", "mp_alien_drill_bot", var_0.origin, var_0.angles);
  level.drill_vehicle.team = "allies";
  level.drill_vehicle.health = 1000000;
  level.drill_vehicle makevehiclesolidcapsule(1, 1, 1);
  level.drill_headlight_fx = spawn("script_model", level.drill_vehicle.origin + (0, 0, 30) + vector_multiply(anglesToForward(level.drill_vehicle.angles), 10));
  level.drill_headlight_fx.angles = (0, 90, 0);
  level.drill_headlight_fx setModel("tag_origin");
  wait 0.5;
  playFXOnTag(level._effect["bot_headlight"], level.drill_headlight_fx, "tag_origin");
  level.drill_headlight_fx linkto(level.drill_vehicle);
  var_1 = "waypoint_alien_blocker";
  var_2 = 14;
  var_3 = 14;
  var_4 = 0.75;
  var_5 = level.drill_vehicle.origin + (0, 0, 40);

  foreach(var_7 in level.players)
  maps\mp\alien\_outline_proto::enable_outline_for_player(level.drill_vehicle, var_7, 3, 0, "high");

  level.drillbot_waypoint_icon = maps\mp\alien\_hud::make_waypoint(var_1, var_2, var_3, var_4, var_5);
}

vector_multiply(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

beacon_watch_bomb_stuck_override(var_0) {
  if(maps\mp\alien\_utility::is_true(var_0.on_container) && maps\mp\alien\_utility::is_true(level.all_players_on_container)) {
    level thread link_drill_to_container(var_0);
    return 1;
  }

  if(!isDefined(level.drill_vehicle) || !maps\mp\alien\_utility::is_true(level.drillbot_door_open))
    return 0;

  if(distancesquared(var_0.origin, level.drill_vehicle.origin) < 6400 && !isDefined(level.drillbot_event_finished)) {
    level thread cargo_drillbot_logic(var_0);
    return 1;
  }

  return 0;
}

link_drill_to_container(var_0) {
  var_0 takeweapon("alienbomb_mp");
  var_0 enableweaponswitch();
  maps\mp\alien\_drill::drop_drill(var_0.origin + (0, 0, 4), (0, 0, 0));
  earthquake(0.25, 0.5, var_0.origin, 128);
  level.drill_linked_to_container = 1;
  wait 0.1;
  var_1 = getEntArray("move_container", "targetname");
  level.drill linkto(var_1[0]);
  level.drill makeunusable();

  if(isDefined(level.drill_icon))
    level.drill_icon.alpha = 0;

  var_0 maps\mp\alien\_drill::restore_last_weapon();
  var_0 common_scripts\utility::_enableoffhandweapons();
  level waittill("beacon_starting_topdeck");
  level.drill makeusable();
  level.drill unlink();
  level.drill_linked_to_container = undefined;

  foreach(var_3 in level.players)
  var_3.on_container = undefined;

  if(isDefined(level.drill_icon)) {
    level.drill_icon.x = level.drill.origin[0];
    level.drill_icon.y = level.drill.origin[1];
    level.drill_icon.z = level.drill.origin[2] + 72;
    level.drill_icon.alpha = 0.5;
  }
}

cargo_drillbot_logic(var_0) {
  level notify("drillbot_used");
  clear_drillbot_lowermessage();

  if(isDefined(level.drillbot_waypoint_icon))
    level.drillbot_waypoint_icon destroy();

  var_0 takeweapon("alienbomb_mp");
  level.drill_vehicle playsoundonmovingent("scn_drillbot_attach");
  var_0 enableweaponswitch();
  var_1 = level.drill_vehicle gettagorigin("tag_turret_attach");
  level.prevent_drill_pickup = 1;
  maps\mp\alien\_drill::drop_drill(var_1, (0, 0, 0));
  earthquake(0.25, 0.5, var_0.origin, 128);
  var_0 maps\mp\alien\_drill::restore_last_weapon();
  var_0 common_scripts\utility::_enableoffhandweapons();
  wait 0.1;
  level.prevent_drill_pickup = undefined;
  level.drill linkto(level.drill_vehicle, "tag_turret_attach", (0, 0, 0), (0, 0, 0));
  level.drill makeunusable();
  var_2 = undefined;

  foreach(var_4 in level.stronghold_hive_locs) {
    if(isDefined(var_4.target) && var_4.target == "cargo_area_mini_3") {
      var_2 = var_4;
      break;
    }
  }

  var_2 maps\mp\alien\_hive::disable_other_strongholds();

  if(isDefined(var_2.icon))
    var_2.icon destroy();

  wait_for_player_to_activate_platform();
  level.non_player_drill_plant = 1;
  use_drillbot_door(1, getent("cargo_bot_entrance_door", "targetname"));
  send_bot_to_hive_and_drill(var_0);
  var_6 = common_scripts\utility::getclosest(level.drill_vehicle.origin, getvehiclenodearray("drill_path", "targetname"));
  level.drill_vehicle attachpath(var_6);
  level.drill_vehicle startpath();
  level.drill_vehicle playsoundonmovingent("scn_drillbot_move02");
  level.drill_vehicle vehicle_setspeed(5, 1, 1);
  level.drill_vehicle waittill("reached_end_node");
  var_7 = undefined;
  use_drillbot_door(var_7, getent("cargo_bot_exit_door", "targetname"));
  level.drill makeusable();

  foreach(var_9 in level.players)
  maps\mp\alien\_outline_proto::disable_outline_for_player(level.drill_vehicle, var_9);

  level.drill_headlight_fx delete();
  level.drillbot_event_finished = 1;
  level.non_player_drill_plant = 0;
  level.drill maps\mp\alien\_drill::set_drill_icon();
}

send_bot_to_hive_and_drill(var_0) {
  if(isDefined(level.drill_icon))
    level.drill_icon destroy();

  var_1 = getvehiclenode("cargo_drillbot_start", "targetname");
  level.drill_vehicle attachpath(var_1);
  level.drill_vehicle startpath();
  level.drill_vehicle playsoundonmovingent("scn_drillbot_move01");
  level.drill_vehicle vehicle_setspeed(5, 1, 1);
  level.drill_icon_draw_dist_override = 10000;
  level.drill_vehicle waittill("reached_end_node");
  var_2 = undefined;

  foreach(var_4 in level.stronghold_hive_locs) {
    if(isDefined(var_4.target) && var_4.target == "cargo_area_mini_3") {
      var_2 = var_4;
      break;
    }
  }

  if(!isDefined(var_0) || !isalive(var_0)) {
    var_6 = maps\mp\alien\_utility::get_array_of_valid_players();
    var_0 = var_6[0];
  }

  level.drill_carrier = var_0;
  var_2 notify("trigger", var_0);
  common_scripts\utility::flag_wait("drill_detonated");
  level.drill_icon_draw_dist_override = undefined;
  wait 8;
  level.drill makeunusable();
  level.drill linkto(level.drill_vehicle, "tag_turret_attach", (0, 0, -2), (0, 0, 0));

  if(isDefined(level.drill_icon))
    level.drill_icon destroy();
}

wait_for_player_to_activate_platform() {
  var_0 = getent("bot_switch", "targetname");
  maps\mp\alien\_outline_proto::add_to_outline_watch_list(var_0, 0);
  var_1 = "waypoint_alien_blocker";
  var_2 = 14;
  var_3 = 14;
  var_4 = 0.75;
  var_5 = var_0.origin + (0, 0, 40);
  var_6 = maps\mp\alien\_hud::make_waypoint(var_1, var_2, var_3, var_4, var_5);
  var_0 makeusable();
  var_0 sethintstring(&"MP_ALIEN_BEACON_ACTIVATE_BOT");
  var_0 waittill("trigger", var_7);
  playsoundatpos(var_0.origin + (0, 0, 40), "scn_drillbot_activate");
  maps\mp\alien\_outline_proto::remove_from_outline_watch_list(var_0);
  var_0 makeunusable();
  var_6 destroy();
}

clear_drillbot_lowermessage() {
  foreach(var_1 in level.players)
  var_1 maps\mp\_utility::clearlowermessage("bot_drill");
}

check_for_player_near_bot_with_drill() {
  self endon("disconnect");
  self endon("death");
  level endon("drillbot_used");

  if(maps\mp\alien\_utility::is_true(level.drillbot_event_finished)) {
    return;
  }
  var_0 = 6400;

  while(!isDefined(level.drill_vehicle))
    wait 1;

  for(;;) {
    while(!common_scripts\utility::flag("drill_drilling")) {
      if(isDefined(self.inlaststand) && self.inlaststand || common_scripts\utility::flag("drill_drilling") || isDefined(self.usingremote) || maps\mp\alien\_utility::is_true(self.iscarrying)) {
        wait 0.05;
        continue;
      }

      if(distancesquared(level.drill_vehicle.origin, self.origin) < var_0) {
        if(!isDefined(level.drill_carrier) || isDefined(level.drill_carrier) && level.drill_carrier != self) {
          maps\mp\_utility::setlowermessage("bot_drill", &"MP_ALIEN_BEACON_PLACE_DRILL", undefined, 10);

          while(player_should_see_drillbot_hint(level.drill_vehicle, var_0, 1))
            wait 0.05;

          maps\mp\_utility::clearlowermessage("bot_drill");
        } else {
          maps\mp\_utility::setlowermessage("bot_drill", &"MP_ALIEN_BEACON_DRILL_ONBOT", undefined, 10);

          while(player_should_see_drillbot_hint(level.drill_vehicle, var_0, 0))
            wait 0.05;

          maps\mp\_utility::clearlowermessage("bot_drill");
        }
      }

      wait 0.05;
    }

    common_scripts\utility::flag_waitopen("drill_drilling");
  }
}

player_should_see_drillbot_hint(var_0, var_1, var_2) {
  if(distancesquared(var_0.origin, self.origin) > var_1)
    return 0;

  if(common_scripts\utility::flag("drill_drilling"))
    return 0;

  if(self.inlaststand)
    return 0;

  if(isDefined(self.usingremote))
    return 0;

  if(maps\mp\alien\_utility::is_true(var_2))
    return 1;
  else if(maps\mp\alien\_utility::is_true(self.iscarrying))
    return 0;

  return 1;
}

register_encounter() {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    maps\mp\gametypes\aliens::register_encounter(::chaos_init, undefined, undefined, undefined, ::chaos_init, maps\mp\alien\_globallogic::blank);
    maps\mp\gametypes\aliens::register_encounter(maps\mp\alien\_chaos::chaos, undefined, undefined, undefined, maps\mp\alien\_chaos::chaos, maps\mp\alien\_globallogic::blank);
    return;
  }

  maps\mp\gametypes\aliens::register_encounter(::encounter_init, undefined, undefined, undefined, ::encounter_init, maps\mp\alien\_globallogic::blank);
  maps\mp\gametypes\aliens::register_encounter(::mp_alien_beacon_intro_ride, 1, undefined, undefined, ::skip_hive_give_abilities, ::jump_to_well_deck_1, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::hives_2_custom, 1, undefined, 1, maps\mp\alien\_hive::skip_hive, ::jump_to_well_deck_2, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::hives_3_custom, 1, undefined, 1, maps\mp\alien\_hive::skip_hive, ::jump_to_mini_boss, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::first_cargo_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_cargo_area, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::cargo_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_cargo_area, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::cargo_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_cargo_area, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::cargo_hive, 1, undefined, 1, maps\mp\alien\_hive::skip_hive, ::jump_to_cargo_blocker, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::top_deck_hive_01, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_top_deck, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::final_deck_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_top_deck, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::first_lab_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_lab_area, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::second_lab_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_lab_area, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::third_lab_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_lab_area, maps\mp\alien\_hive::beat_regular_hive);
  maps\mp\gametypes\aliens::register_encounter(::mp_alien_beacon_top_deck_hive, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_lab_blocker);
  maps\mp\gametypes\aliens::register_encounter(::mp_alien_beacon_boss_encounter, 1, undefined, undefined, maps\mp\alien\_hive::skip_hive, ::jump_to_boss_area);
}

encounter_init() {
  var_0 = getent("drill_pickup_trig", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  maps\mp\alien\_drill::init_drill();
  maps\mp\alien\_hive::init_hives();
  maps\mp\alien\_gamescore::init_eog_score_components(["hive"]);
  maps\mp\alien\_gamescore_beacon::init_beacon_eog_score_components(["kraken", "item_crafting", "side_area", "relics"]);
  maps\mp\alien\_gamescore::init_encounter_score_components(["challenge", "drill", "team", "team_blocker", "personal", "personal_blocker"]);
  maps\mp\alien\_gamescore_beacon::init_beacon_encounter_score_components(["item_crafting", "side_area", "gas", "kraken", "kraken_personal", "kraken_team", "tentacle_bonus", "progression_door"]);
  level.progression_doors = ["door_hive_4", "door_hive_6"];
  level thread fix_cargo_leftovers();
}

init_seeder() {
  maps\mp\agents\alien\_alien_seeder::seeder_level_init();
  level.dlc_alien_init_override_func = ::beacon_alien_init_override;
  level.dlc_melee_override_func = ::beacon_alien_melee_override;
  level.dlc_alien_death_override_func = ::beacon_alien_death_override;
  level.dlc_get_non_agent_enemies = ::beacon_get_non_agent_enemies;
}

beacon_alien_init_override() {
  if(maps\mp\alien\_utility::get_alien_type() == "seeder")
    maps\mp\agents\alien\_alien_seeder::seeder_init();
}

beacon_alien_melee_override(var_0) {
  if(self.melee_type == "seeder_spit")
    maps\mp\agents\alien\_alien_seeder::seeder_spit_attack(var_0);
}

beacon_alien_death_override(var_0) {
  if(maps\mp\alien\_utility::get_alien_type() == "seeder")
    maps\mp\agents\alien\_alien_seeder::seeder_death(var_0);
}

beacon_get_non_agent_enemies() {
  var_0 = [];

  if(isDefined(level.seeder_active_turrets)) {
    foreach(var_2 in level.seeder_active_turrets) {
      if(!isDefined(var_2.pet))
        var_0 = common_scripts\utility::array_add(var_0, var_2);
    }

    return var_0;
  }

  return [];
}

beacon_hint_precache() {
  var_0 = [];
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_PROPANE_TANK"] = &"ALIEN_PICKUPS_BEACON_PICKUP_PROPANE_TANK";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_VKS"] = &"ALIEN_PICKUPS_BEACON_PICKUP_VKS";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_FP6"] = &"ALIEN_PICKUPS_BEACON_PICKUP_FP6";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_RGM"] = &"ALIEN_PICKUPS_BEACON_PICKUP_RGM";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_PP19"] = &"ALIEN_PICKUPS_BEACON_PICKUP_PP19";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_CBJMS"] = &"ALIEN_PICKUPS_BEACON_PICKUP_CBJMS";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_MAUL"] = &"ALIEN_PICKUPS_BEACON_PICKUP_MAUL";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_MICROTAR"] = &"ALIEN_PICKUPS_BEACON_PICKUP_MICROTAR";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_KAC"] = &"ALIEN_PICKUPS_BEACON_PICKUP_KAC";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_PANZERFAUST"] = &"ALIEN_PICKUPS_BEACON_PICKUP_PANZERFAUST";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_G28"] = &"ALIEN_PICKUPS_BEACON_PICKUP_G28";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_HONEYBADGER"] = &"ALIEN_PICKUPS_BEACON_PICKUP_HONEYBADGER";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_RGM"] = &"ALIEN_PICKUPS_BEACON_PICKUP_RGM";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_ARX_160"] = &"ALIEN_PICKUPS_BEACON_PICKUP_ARX_160";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_LSAT"] = &"ALIEN_PICKUPS_BEACON_PICKUP_LSAT";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_SVU"] = &"ALIEN_PICKUPS_BEACON_PICKUP_SVU";
  var_0["ALIEN_PICKUPS_BEACON_PICKUP_RIPPER"] = &"ALIEN_PICKUPS_BEACON_PICKUP_RIPPER";
  return var_0;
}

mp_alien_beacon_pillage_init() {
  level.pillageinfo = spawnStruct();
  level.pillageinfo.alienattachment_model = "weapon_alien_muzzlebreak";
  level.pillageinfo.default_use_time = 1000;
  level.pillageinfo.money_stack = "pb_money_stack_01";
  level.pillageinfo.attachment_model = "has_spotter_scope";
  level.pillageinfo.maxammo_model = "mil_ammo_case_1_open";
  level.pillageinfo.flare_model = "mil_emergency_flare_mp";
  level.pillageinfo.clip_model = "weapon_baseweapon_clip";
  level.pillageinfo.leash_model = "weapon_knife_iw6";
  level.pillageinfo.trophy_model = "mp_trophy_system_folded_iw6";
  level.pillageinfo.ui_searching = 1;
  level.pillageinfo.easy_attachment = 30;
  level.pillageinfo.easy_clip = 15;
  level.pillageinfo.easy_money = 20;
  level.pillageinfo.easy_explosive = 16;
  level.pillageinfo.easy_specialammo = 17;
  level.pillageinfo.easy_locker_key = 1;
  level.pillageinfo.easy_intel = 1;
  level.pillageinfo.medium_attachment = 35;
  level.pillageinfo.medium_explosive = 16;
  level.pillageinfo.medium_money = 20;
  level.pillageinfo.medium_specialammo = 20;
  level.pillageinfo.medium_clip = 7;
  level.pillageinfo.medium_locker_key = 1;
  level.pillageinfo.medium_intel = 1;
  level.pillageinfo.hard_attachment = 25;
  level.pillageinfo.hard_maxammo = 25;
  level.pillageinfo.hard_specialammo = 19;
  level.pillageinfo.hard_money = 25;
  level.pillageinfo.hard_locker_key = 5;
  level.pillageinfo.hard_intel = 1;
  level.crafting_item_table = "mp/alien/crafting_items.csv";
  level.crafting_table_item_index = 0;
  level.crafting_table_item_ref = 1;
  level.crafting_table_item_name = 2;
  level.crafting_table_item_icon = 3;
  level.max_crafting_items = 3;
  level.crafting_model = "weapon_baseweapon_clip";
  level.get_hintstring_for_pillaged_item_func = ::beacon_get_hintstring_for_pillaged_item_func;
  level.get_hintstring_for_item_pickup_func = ::beacon_get_hintstring_for_item_pickup_func;
  level.custom_build_pillageitem_array_func = ::beacon_build_pillageitem_array_func;
  relocate_bad_pillage_spots();
}

relocate_bad_pillage_spots() {
  var_0 = common_scripts\utility::getstructarray("lab_crafting_pillage", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.origin == (-1034, 5744.2, 1214)) {
      var_2.origin = (-1034.5, 5686.2, 1156);
      var_2.angles = (0, 313, 0);
    }
  }
}

mp_alien_beacon_onspawnplayer_func() {
  thread maps\mp\alien\_alien_class_skills_main::assign_skills();
  thread maps\mp\alien\_music_and_dialog_dlc::dlc_vo_init_on_player_spawn();
  thread maps\mp\alien\_pillage_intel::intel_on_player_connect();
  thread maps\mp\alien\_beacon_weapon::special_gun_watcher();
  thread check_for_player_near_bot_with_drill();
  var_0 = self;
  thread maps\mp\alien\_achievement::eggallfoundforpack(1);
  level notify("boat_spawn", var_0);

  if(common_scripts\utility::flag_exist("boat_ride_over") && !common_scripts\utility::flag("boat_ride_over"))
    var_0 thread boat_intro_on_connect(var_0, level.players.size);
}

tp_to_well_deck() {
  var_0 = [];
  var_0[1] = (-132, -3142, -100);
  var_0[2] = (-232, -3142, -100);
  var_0[3] = (-332, -3142, -100);
  var_0[4] = (-432, -3142, -100);
  var_1 = 0;

  while(var_1 == 0 && self.origin[1] < -4500) {
    foreach(var_3 in var_0) {
      if(canspawn(var_3) && !positionwouldtelefrag(var_3)) {
        if(!isDefined(self.teleport_overlay)) {
          thread teleport_black_screen();
          wait 1;
        }

        if(canspawn(var_3) && !positionwouldtelefrag(var_3)) {
          teleport_player_to_spot(var_3);
          var_1 = 1;
          break;
        } else
          continue;
      }
    }

    wait 0.1;
  }
}

freeze_connected_player_controls() {
  level endon("introscreen_over");
  wait 1;

  while(!common_scripts\utility::flag("intro_sequence_complete")) {
    level waittill("connected", var_0);
    var_0 thread freeze_controls_load();
  }
}

freeze_controls_load() {
  maps\mp\_utility::freezecontrolswrapper(1);
  self disableweapons();
  level waittill("introscreen_over");
  maps\mp\_utility::freezecontrolswrapper(0);
  self enableweapons();
}

skip_hive_give_abilities() {
  common_scripts\utility::flag_set("give_player_abilities");
  maps\mp\alien\_hive::skip_hive();
}

beacon_get_hintstring_for_pillaged_item_func(var_0) {
  var_0 = "" + var_0;

  switch (var_0) {
    case "crafting":
      return &"ALIEN_CRAFTING_FOUND_CRAFTING_ITEM";
    case "locker_key":
      return &"ALIEN_PILLAGE_LOCKER_FOUND_LOCKER_KEY";
    case "locker_weapon":
      return &"ALIEN_PILLAGE_LOCKER_FOUND_LOCKER_WEAPON";
  }
}

beacon_get_hintstring_for_item_pickup_func(var_0) {
  var_0 = "" + var_0;

  switch (var_0) {
    case "wire":
      return &"ALIEN_CRAFTING_PICKUP_WIRE";
    case "amolecular":
      return &"ALIEN_CRAFTING_PICKUP_AMOLECULAR";
    case "fuse":
      return &"ALIEN_CRAFTING_PICKUP_FUSE";
    case "pipe":
      return &"ALIEN_CRAFTING_PICKUP_PIPE";
    case "pressureplate":
      return &"ALIEN_CRAFTING_PICKUP_PRESSUREPLATE";
    case "nucleicbattery":
      return &"ALIEN_CRAFTING_PICKUP_NUCLEICBATTERY";
    case "cellbattery":
      return &"ALIEN_CRAFTING_PICKUP_CELLBATTERY";
    case "liquidbattery":
      return &"ALIEN_CRAFTING_PICKUP_LIQUIDBATTERY";
    case "tnt":
      return &"ALIEN_CRAFTING_PICKUP_TNT";
    case "resin":
      return &"ALIEN_CRAFTING_PICKUP_RESIN";
    case "biolum":
      return &"ALIEN_CRAFTING_PICKUP_BIOLUM";
    case "locker_key":
      return &"ALIEN_PILLAGE_LOCKER_PICKUP_LOCKER_KEY";
    case "locker_weapon":
      return &"ALIEN_PILLAGE_LOCKER_PICKUP_LOCKER_WEAPON";
    case "venomx":
      return &"ALIEN_CRAFTING_PICKUP_DISARMED_VENOM";
    case "bluebiolum":
      return &"ALIEN_CRAFTING_PICKUP_BLUEBIOLUM";
    case "orangebiolum":
      return &"ALIEN_CRAFTING_PICKUP_ORANGEBIOLUM";
    case "amethystbiolum":
      return &"ALIEN_CRAFTING_PICKUP_PURPLEBIOLUM";
    case "iw6_aliendlc22_mp":
      return &"ALIEN_CRAFTING_PICKUP_PIPEBOMB";
    case "flare":
    case "stickyflare":
    case "viewmodel_flare":
    case "iw6_aliendlc21_mp":
      return &"ALIEN_CRAFTING_PICKUP_STICKYFLARE";
  }

  if(isDefined(level.level_locker_weapon_pickup_string_func))
    return [[level.level_locker_weapon_pickup_string_func]](var_0);
}

beacon_build_pillageitem_array_func(var_0) {
  switch (var_0) {
    case "easy":
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "crafting", level.pillageinfo.crafting_easy);
      break;
    case "medium":
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "crafting", level.pillageinfo.crafting_medium);
      break;
    case "hard":
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "crafting", level.pillageinfo.crafting_hard);
      break;
  }

  level thread maps\mp\alien\_pillage_intel::build_intel_pillageitem_arrays(var_0);
}

beacon_locker_weapon_pickup_string_func(var_0) {
  var_0 = "" + var_0;

  switch (var_0) {
    case "weapon_maul":
      return &"ALIEN_PICKUPS_BEACON_LOCKER_MAUL";
    case "weapon_kac_chainsaw":
      return &"ALIEN_PICKUPS_BEACON_LOCKER_KAC";
    case "weapon_g28":
      return &"ALIEN_PICKUPS_BEACON_LOCKER_G28";
    case "weapon_fabarm_fp6":
      return &"ALIEN_PICKUPS_BEACON_LOCKER_FP6";
    case "weapon_pp19_bizon_iw6":
      return &"ALIEN_PICKUPS_BEACON_LOCKER_PP19";
    case "weapon_cbj_ms_iw6":
      return &"ALIEN_PICKUPS_BEACON_LOCKER_CBJMS";
    case "weapon_tar21":
      return &"ALIEN_PICKUPS_BEACON_LOCKER_MICROTAR";
    case "weapon_honeybadger":
      return &"ALIEN_PICKUPS_BEACON_LOCKER_HONEYBADGER";
    case "weapon_arx_160":
      return &"ALIEN_PICKUPS_BEACON_LOCKER_ARX_160";
    case "weapon_lsat_iw6":
      return &"ALIEN_PICKUPS_BEACON_LOCKER_LSAT";
    case "weapon_dragunov_svu":
      return &"ALIEN_PICKUPS_BEACON_LOCKER_SVU";
    case "weapon_evopro":
      return &"ALIEN_PICKUPS_BEACON_LOCKER_RIPPER";
    default:
      return &"ALIEN_PILLAGE_LOCKER_PICKUP_LOCKER_WEAPON";
  }
}

watch_cinematic_use(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  level waittill(var_1);
  preloadcinematicforall(var_0);
  level waittill(var_2);
  playcinematicforall(var_0);
  level waittill(var_3);
  stopcinematicforall();
}

mp_alien_beacon_intro_ride() {
  level thread intro_boat_ride();
  maps\mp\alien\_hive::regular_hive();
}

intro_boat_ride() {
  common_scripts\utility::flag_init("boat_ride_over");
  thread maps\mp\mp_alien_beacon_vignettes::drill_swap();
  level.boat_vehicle = getent("intro_hovercraft", "targetname");
  var_0 = getent("hovercraft_clip", "targetname");
  var_0 linkto(level.boat_vehicle);
  var_1 = getent("hovercraft_back_clip", "targetname");
  var_1 notsolid();
  var_2 = getent("hovercraft_clip_gate", "targetname");
  var_2 linkto(level.boat_vehicle);
  level.boat_vehicle.spawn_locations = [];

  for(var_3 = 0; var_3 < 4; var_3++) {
    level.boat_vehicle.spawn_locations[var_3] = getent("beacon_hovercraft_spot" + (var_3 + 1), "targetname");
    level.boat_vehicle.spawn_locations[var_3] linkto(level.boat_vehicle);
  }

  foreach(var_3, var_5 in level.players) {
    var_6 = getent("beacon_hovercraft_spot" + (var_3 + 1), "targetname");
    var_6.used_spot = 1;
    var_5 setorigin(var_6.origin);
    var_5 setplayerangles(var_6.angles);
  }

  wait 0.5;
  level.boat_vehicle scriptmodelplayanimdeltamotion("alien_beacon_intro_hovercraft");
  thread maps\mp\mp_alien_beacon_vignettes::boat_ride_vo();
  thread maps\mp\mp_alien_beacon_fx::fx_boatride_splashes();
  thread maps\mp\mp_alien_beacon_fx::fx_raindrops_screenfx_intro();
  wait 5;
  level.boat_vehicle thread beacon_play_sound_on_moving_tag("scn_beacon_intro_fan_left", "J_LE_Fan", 26);
  level.boat_vehicle thread beacon_play_sound_on_moving_tag("scn_beacon_intro_fan_right", "J_RI_Fan", 26);
  wait 21;
  var_2 delete();
  wait 2.33;
  common_scripts\utility::flag_set("boat_ride_over");
  thread update_override_info((-281, -2645, 0.124998), (0, 90, 0));
  common_scripts\utility::flag_set("give_player_abilities");
  var_1 solid();

  foreach(var_6 in level.boat_vehicle.spawn_locations)
  var_6 delete();

  var_0 delete();
}

boat_intro_on_connect(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in level.boat_vehicle.spawn_locations) {
    if(!isDefined(var_4.used_spot)) {
      var_2 = var_4;
      var_4.used_spot = 1;
      break;
    }
  }

  if(!isDefined(var_2)) {
    foreach(var_4 in level.boat_vehicle.spawn_locations)
    var_4.used_node = undefined;

    var_2 = level.boat_vehicle.spawn_locations[1];
    var_2.usedspot = 1;
  }

  wait 0.1;
  var_0 setorigin(var_2.origin + (0, 0, 0));
  var_0 setplayerangles(var_2.angles);
  wait 0.05;
  var_0 playerlinkto(var_2);
  wait 0.2;
  var_0 unlink();
}

collision_test() {
  self waittill("unresolved_collision");
}

hives_2_custom() {
  maps\mp\alien\_hive::regular_hive();
}

hives_3_custom() {
  thread maps\mp\mp_alien_beacon_vignettes::mini_boss();
  maps\mp\alien\_hive::regular_hive(::get_mini_boss_score_component_list);
  thread update_override_info((-1300, 437, -127.875), (0, 0, 0));
  level notify("miniboss_retreat");
  level.miniboss_beaten = 1;
  thread maps\mp\mp_alien_beacon_vignettes::post_miniboss_vo();
  maps\mp\alien\_achievement_dlc2::update_blocker_achievements("tentacle_fight");

  foreach(var_1 in level.players)
  var_1 maps\mp\alien\_persistence::try_award_bonus_pool_token();

  if(maps\mp\alien\_utility::isplayingsolo() && !issplitscreen())
    maps\mp\alien\_laststand::give_laststand(level.players[0], 1);
}

get_mini_boss_score_component_list() {
  if(maps\mp\alien\_utility::isplayingsolo())
    return ["drill", "personal", "challenge", "tentacle_bonus"];
  else
    return ["drill", "team", "personal", "challenge", "tentacle_bonus"];
}

first_cargo_hive() {
  level thread maps\mp\mp_alien_beacon_vignettes::cargo_room_intro_vo();
  cargo_hive();
  thread update_override_info((-742, 1258, 136.125), (0, 90, 0));
}

pre_hive() {
  if(level.current_hive_name == "cargo_area_mini_3")
    return 23;

  return level.cycle_count;
}

cargo_hive() {
  maps\mp\alien\_hive::regular_hive();

  if(isDefined(level.icargohives)) {
    if(level.icargohives == 1) {
      common_scripts\utility::flag_set("delay_UGV_VO");
      thread maps\mp\mp_alien_beacon_vignettes::cargo_room_hive_two_vo();
      level.icargohives++;
    } else if(level.icargohives == 2) {
      level thread waypoint_after_drill_picked_up();
      level.icargohives++;
    } else
      level.icargohives++;
  }

  if(level.current_hive_name == "cargo_area_mini_2_post") {
    wait 5;
    spawn_beacon_cargo_drillbot();
    var_0 = undefined;
    level thread use_drillbot_door(var_0, getent("cargo_bot_entrance_door", "targetname"));
    wait 3;
    level.drillbot_door_open = 1;
  }

  level maps\mp\mp_alien_beacon_vignettes::set_up_blast_doors();

  if(level.current_hive_name == "cargo_area_mini_1_post" || level.current_hive_name == "cargo_area_mini_2_post" || level.current_hive_name == "cargo_area_mini_3_post" || level.current_hive_name == "cargo_area_mini_4_post" || level.current_hive_name == "cargo_area_mini_5_post" || level.current_hive_name == "cargo_area_mini_6_post")
    level.blast_doors_lifted++;

  if(level.current_hive_name == "cargo_area_mini_2_post")
    level thread maps\mp\mp_alien_beacon_vignettes::cargo_room_use_ugv_vo();

  if(level.blast_doors_lifted > 3 && !common_scripts\utility::flag("cargo_control_room_vo_played"))
    level thread maps\mp\mp_alien_beacon_vignettes::cargo_room_go_to_control_room_vo();

  level thread spawn_elites_from_container();
}

cargo_blocker_door_setup() {
  level.custom_hive_logic = ::beacon_cargo_hive_logic;
  level.hive_is_really_a_door = 1;
}

beacon_cargo_hive_logic() {
  level notify("drill_start_door_fx", 180);
  level.drill scriptmodelplayanim("alien_drill_open_door_long");
  level thread beacon_cargo_hive_think();
}

beacon_cargo_hive_think() {
  common_scripts\utility::flag_wait("drill_detonated");
  wait 10;
  level.custom_hive_logic = undefined;
  level.hive_is_really_a_door = undefined;
}

top_deck_hive_01() {
  thread maps\mp\mp_alien_beacon_vignettes::init_cinematics("mp_beacon_archer_vig", 60);
  thread raise_cargo_container();
  thread wait_for_players_reach_waypoint();
  maps\mp\alien\_hive::regular_hive();
}

wait_for_players_reach_waypoint() {
  var_0 = "waypoint_alien_blocker";
  var_1 = 14;
  var_2 = 14;
  var_3 = 0.75;
  var_4 = (-252, 1139, 340);
  var_5 = 60;
  var_6 = 128;
  var_7 = 100;
  var_8 = maps\mp\alien\_hud::make_waypoint(var_0, var_1, var_2, var_3, var_4);
  var_9 = spawn("trigger_radius", var_4, 0, var_6, var_7);
  var_9 watch_trigger_by_player();
  var_9 delete();
  var_8 destroy();
}

watch_trigger_by_player() {
  self endon("death");
  level endon("game_ended");
  common_scripts\utility::waitframe();

  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      break;
    }
  }

  self notify("trigger_by_player");
}

final_deck_hive() {
  maps\mp\alien\_hive::regular_hive();
  var_0 = [];
  var_0 = getEntArray("deck_to_lab_door", "targetname");
  var_1 = getent("deck_to_lab_door_linker", "targetname");

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && isDefined(var_1))
      var_3 linkto(var_1);
  }

  var_5 = getEntArray("top_deck_mini_1", "targetname");

  foreach(var_7 in var_5) {
    if(var_7.classname == "script_brushmodel")
      var_7 delete();
  }

  var_1 movez(92, 5, 0, 1);
  thread maps\mp\mp_alien_beacon_vignettes::lab_entrance_vo();

  if(maps\mp\alien\_utility::isplayingsolo() && !issplitscreen())
    maps\mp\alien\_laststand::give_laststand(level.players[0], 1);

  thread update_override_info((264, 4232, 1152.13), (0, 130, 0));
}

first_lab_hive() {
  maps\mp\alien\_hive::regular_hive();
  thread maps\mp\mp_alien_beacon_vignettes::lab_first_hive_vo();
}

second_lab_hive() {
  maps\mp\alien\_hive::regular_hive();
  thread maps\mp\mp_alien_beacon_vignettes::lab_second_hive_vo();
}

third_lab_hive() {
  maps\mp\alien\_hive::regular_hive();
}

mp_alien_beacon_cargo_blocker_hive() {
  generic_blocker_hive_logic("cargo_blocker_dead");
}

mp_alien_beacon_top_deck_hive() {
  disable_lab_doors();
  maps\mp\alien\_gamescore::reset_encounter_performance();
  maps\mp\mp_alien_beacon_vignettes::setup_gas_encounter();
  give_gas_encounter_rewards();
  common_scripts\utility::flag_set("top_deck_blocker_dead");
  common_scripts\utility::flag_set("boss_turrets_on");
  var_0 = getent("player128x128x128", "targetname");

  if(isDefined(var_0)) {
    var_0 moveto((-136.5, 6465.5, 1444), 0.05);
    var_0.angles = (0, 0, 0);
  }
}

give_gas_encounter_rewards() {
  var_0 = get_gas_encounter_score_components();
  maps\mp\alien\_gamescore::calculate_and_show_encounter_scores(level.players, var_0);

  foreach(var_2 in level.players) {
    var_2 maps\mp\alien\_persistence::eog_player_update_stat("hivesdestroyed", 1);
    var_2 thread maps\mp\alien\_hive::wait_to_give_rewards();
  }
}

get_gas_encounter_score_components() {
  if(maps\mp\alien\_utility::isplayingsolo())
    return ["gas", "personal"];
  else
    return ["gas", "team", "personal"];
}

mp_alien_beacon_story_moment() {}

mp_alien_beacon_boss_encounter() {
  var_0 = getent("boss_trigger", "targetname");
  var_0 waittill("trigger");
  setDvar("sm_sunSampleSizeNear", 0.7);
  level thread clean_aliens_for_kraken();
  wait 2;
  level notify("stop_teleport_script");
  common_scripts\utility::flag_set("tp_to_kraken_on_spawn");
  update_override_info((-125.5, 7012.5, 1152.13), (0, 0, 0));
  level thread gather_ye_players_for_kraken();
  wait 1.0;
  level notify("stop_drill_teleport_script");
  level.blocker_hive_active = 1;
  maps\mp\agents\alien\alien_kraken\_alien_kraken::initkraken();
  maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::initkrakententacle();
  thread play_kraken_intro_music();
  wait 5.0;
  var_1 = common_scripts\utility::getstruct("kraken_position_1", "targetname");
  level.kraken = maps\mp\agents\alien\alien_kraken\_alien_kraken::alienkrakenspawn(var_1.origin, var_1.angles);
  level.kraken maps\mp\agents\alien\alien_kraken\_alien_kraken::attachtentacles();
  level.kraken.feral_occludes = 1;
  level.kraken attach("fx_kraken_bones_jaw");
  level.kraken attach("fx_kraken_bones_helmet");
  common_scripts\utility::flag_set("boss_is_spawned");
  level thread listen_for_emerge_phase();
  level thread kraken_start_cycle(1);
  maps\mp\alien\_gamescore::reset_encounter_performance();
  var_2 = gettime();
  level.kraken maps\mp\agents\alien\alien_kraken\_alien_kraken::alienkrakenthink();
  var_3 = gettime() - var_2;
  update_lb_aliensession_final_kraken(var_3);
  maps\mp\alien\_gamescore_beacon::calculate_kraken_score(var_3);
  maps\mp\alien\_achievement_dlc2::update_blocker_achievements("kraken", var_3);
  maps\mp\mp_alien_beacon_vignettes::post_boss_vo();

  if(!maps\mp\alien\_utility::is_casual_mode())
    set_players_escaped();

  give_players_completion_tokens();
  maps\mp\alien\_unlock::update_escape_item_unlock(level.players);
  var_4 = get_win_condition();
  var_5 = maps\mp\alien\_hud::get_end_game_string_index(var_4);
  level maps\mp\_utility::delaythread(3, maps\mp\gametypes\aliens::alienendgame, "allies", var_5);
}

gather_ye_players_for_kraken() {
  level endon("game_ended");

  foreach(var_1 in level.kraken_turrets) {
    if(var_1.origin[1] < 6500) {
      var_1.overloaded = 1;
      var_1 notify("disable_turret");
      var_1.use_trigger notify("turret_is_broken");
      var_1.use_trigger maps\mp\alien\mp_alien_beacon_turret::turret_is_broken(var_1);
    }
  }

  wait 1;

  for(;;) {
    foreach(var_4 in level.players) {
      var_5 = var_4;

      if(isDefined(var_4.reviveent))
        var_5 = var_4.reviveent;

      if(var_5.origin[1] < 6640) {
        var_4 teleport_player_to_boss_fight(var_5);
        wait 0.1;
      }
    }

    wait 0.25;
  }
}

clean_aliens_for_kraken() {
  var_0 = [];
  var_1 = getEntArray("spawn_zone", "targetname");

  foreach(var_3 in var_1) {
    if(issubstr(var_3.script_linkname, "spawn_9") || issubstr(var_3.script_linkname, "spawn_10") || issubstr(var_3.script_linkname, "spawn_11") || issubstr(var_3.script_linkname, "spawn_12") || issubstr(var_3.script_linkname, "spawn_13"))
      var_0[var_0.size] = var_3;
  }

  var_5 = maps\mp\alien\_spawnlogic::get_alive_agents();

  foreach(var_7 in var_5) {
    var_8 = 0;

    foreach(var_3 in var_0) {
      if(var_7 istouching(var_3))
        var_8 = 1;
    }

    if(!var_8)
      var_7 suicide();
  }
}

teleport_player_to_boss_fight(var_0) {
  var_1 = [];
  var_1[0] = (-125.5, 7012.5, 1165.5);
  var_1[1] = (-63, 7012.5, 1165.5);
  var_1[2] = (1, 7012.5, 1165.5);
  var_1[3] = (64.5, 7012.5, 1165.5);
  var_2 = (0, 0, 0);
  var_3 = 0;

  while(!var_3) {
    foreach(var_5 in var_1) {
      if(canspawn(var_5) && !positionwouldtelefrag(var_5)) {
        if(!isDefined(self.teleport_overlay)) {
          thread teleport_black_screen();
          wait 1;
        }

        if(canspawn(var_5) && !positionwouldtelefrag(var_5)) {
          if(isDefined(var_0) && var_0 != self)
            teleport_player_to_spot(var_5, var_0);
          else
            teleport_player_to_spot(var_5);

          var_3 = 1;
          break;
        } else
          continue;
      }
    }

    wait 0.1;
  }

  self notify("player_teleported");
}

beacon_player_initial_spawn_loc_override() {
  if(maps\mp\alien\_utility::is_chaos_mode())
    chaos_player_initial_spawn_loc_override();
  else
    regular_player_initial_spawn_loc_override();
}

regular_player_initial_spawn_loc_override() {
  if(!isDefined(level.currentspawnoriginoverride)) {
    return;
  }
  if(!isDefined(level.currentspawnanglesoverride))
    level.currentspawnanglesoverride = (0, 0, 0);

  self.forcespawnorigin = level.currentspawnoriginoverride;
  self.forcespawnangles = level.currentspawnanglesoverride;
}

chaos_player_initial_spawn_loc_override() {
  var_0 = [];
  var_1 = [];

  switch (maps\mp\alien\_utility::get_chaos_area()) {
    case "cargo":
      var_0 = [(1011, 1649, 145), (982, 1783, 145), (-1547, 1765, 145), (-1542, 1637, 145)];
      var_1 = [(0, 180, 0), (0, 180, 0), (0, 0, 0), (0, 0, 0)];
      break;
  }

  self.forcespawnorigin = var_0[level.players.size];
  self.forcespawnangles = var_1[level.players.size];
}

update_override_info(var_0, var_1) {
  var_2 = common_scripts\utility::drop_to_ground(var_0, 5, -100);
  level.currentspawnoriginoverride = var_0;
  level.currentspawnanglesoverride = var_1;
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

play_kraken_intro_music() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      var_1 stoplocalsound("mus_alien_queen");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    if(!common_scripts\utility::flag("exfil_music_playing"))
      level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc2_kraken");
  }
}

kraken_start_cycle(var_0) {}

update_lb_aliensession_final_kraken(var_0) {
  var_1 = get_lb_final_kraken_rank(var_0);

  foreach(var_3 in level.players) {
    var_3 maps\mp\alien\_persistence::lb_player_update_stat("escapedRank" + var_1, 1, 1);
    var_3 maps\mp\alien\_persistence::lb_player_update_stat("hits", 1, 1);
  }
}

get_lb_final_kraken_rank(var_0) {
  var_1 = 555000;
  var_2 = 630000;
  var_3 = 750000;

  if(var_0 <= var_1)
    return 0;
  else if(var_0 <= var_2)
    return 1;
  else if(var_0 <= var_3)
    return 2;
  else
    return 3;
}

generic_blocker_hive_logic(var_0) {
  level endon("game_ended");
  var_1 = maps\mp\alien\_hive::select_hives(1);
  var_2 = var_1[0];
  var_3 = maps\mp\alien\_hive::create_attackable_ent(var_2);
  var_2.attackable_ent = var_3;
  level.current_blocker_hive = var_2;
  level.encounter_name = var_2.target;
  level thread maps\mp\alien\_spawnlogic::encounter_cycle_spawn("blocker_hive_heli_inbound");
  setomnvar("ui_alien_boss_status", 2);
  setomnvar("ui_alien_boss_progression", 0);
  var_3 show();
  var_3 setCanDamage(1);
  var_3 thread maps\mp\alien\_hud::blocker_hive_hp_bar();
  var_3 thread maps\mp\alien\_hive::monitor_attackable_ent_damage(var_2);
  var_3 waittill("death");
  common_scripts\utility::flag_set(var_0);
  maps\mp\alien\_spawn_director::end_cycle();
  level.encounter_name = undefined;
  maps\mp\alien\_hive::blocker_hive_explode_sequence(var_3, var_2);
  maps\mp\alien\_hive::give_players_rewards(1);
}

mp_alien_beacon_attackable_ent_override(var_0) {
  if(maps\mp\alien\_hive::get_blocker_hive_index() == 1) {
    var_0.health = 10000;
    var_0.maxhealth = 10000;
  } else {
    var_0.health = 15000;
    var_0.maxhealth = 15000;
  }

  if(maps\mp\alien\_utility::isplayingsolo()) {
    var_0.health = int(0.66 * var_0.health);
    var_0.maxhealth = int(0.66 * var_0.maxhealth);
  }

  return var_0;
}

init_level_flags() {
  common_scripts\utility::flag_init("cargo_blocker_dead");
  common_scripts\utility::flag_init("top_deck_blocker_dead");
}

beacon_enter_area_func(var_0) {
  if(!maps\mp\alien\_utility::is_chaos_mode())
    maps\mp\alien\_container_spawn::activate_container_spawners_in_area(var_0);
}

beacon_leave_area_func(var_0) {
  if(!maps\mp\alien\_utility::is_chaos_mode())
    maps\mp\alien\_container_spawn::deactivate_container_spawners_in_area(var_0);
}

init_container_spawn() {
  maps\mp\alien\_container_spawn::init_container_spawn();
  level.should_skip_area_activation_func = ::should_skip_area_activation;
  var_0 = [];
  level thread maps\mp\alien\_container_spawn::container_spawn_hive_monitor(var_0);
}

should_skip_area_activation(var_0) {
  var_1 = [];
  return common_scripts\utility::array_contains(var_1, var_0);
}

spawn_elites_from_container() {
  var_0 = 0;

  while(!var_0) {
    level waittill("drill_planted");

    if(level.current_hive_name == "cargo_area_main") {
      var_0 = 1;
      lower_cargo_container();
      wait 1.0;
      level thread notify_and_remove_door("container_3_spawn_1", "cargo_container_3_door_01");
      wait 0.5;

      if(maps\mp\alien\_utility::isplayingsolo()) {
        level thread notify_and_remove_door("fake_notify", "cargo_container_3_door_02");
        continue;
      }

      level thread notify_and_remove_door("container_3_spawn_2", "cargo_container_3_door_02");
    }
  }
}

notify_and_remove_door(var_0, var_1) {
  var_2 = getent(var_1 + "_start", "targetname");
  common_scripts\utility::waitframe();
  var_3 = getent(var_1, "targetname");

  if(maps\mp\alien\_utility::isplayingsolo())
    var_3 setscriptablepartstate(0, 1);
  else
    var_3 setscriptablepartstate(0, 4);

  common_scripts\utility::waitframe();

  if(isDefined(var_2))
    var_2 delete();

  level notify(var_0);
}

jump_to_well_deck_1() {}

jump_to_well_deck_2() {}

jump_to_mini_boss() {}

jump_to_cargo_area() {}

jump_to_cargo_blocker() {}

jump_to_top_deck() {}

jump_to_lab_area() {}

jump_to_lab_blocker() {}

jump_to_boss_area() {}

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

set_container_spawn_table() {
  if(maps\mp\alien\_utility::is_hardcore_mode())
    set_hardcore_container_spawn_table();
  else
    set_regular_container_spawn_table();
}

set_alien_definition_table() {
  if(maps\mp\alien\_utility::is_hardcore_mode())
    set_hardcore_alien_definition_table();
  else
    set_regular_alien_definition_table();
}

set_chaos_spawn_table() {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    switch (maps\mp\alien\_utility::get_chaos_area()) {
      case "welldeck":
        level.alien_cycle_table = "mp/alien/chaos_spawn_beacon_welldeck_sp.csv";
        break;
      case "cargo":
        level.alien_cycle_table = "mp/alien/chaos_spawn_beacon_cargo_sp.csv";
        break;
      case "lab":
        level.alien_cycle_table = "mp/alien/chaos_spawn_beacon_lab_sp.csv";
        break;
    }
  } else {
    switch (maps\mp\alien\_utility::get_chaos_area()) {
      case "welldeck":
        level.alien_cycle_table = "mp/alien/chaos_spawn_beacon_welldeck_mp.csv";
        break;
      case "cargo":
        level.alien_cycle_table = "mp/alien/chaos_spawn_beacon_cargo_mp.csv";
        break;
      case "lab":
        level.alien_cycle_table = "mp/alien/chaos_spawn_beacon_lab_mp.csv";
        break;
    }
  }
}

set_regular_extinction_spawn_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.alien_cycle_table = "mp/alien/cycle_spawn_beacon_sp.csv";
  else
    level.alien_cycle_table = "mp/alien/cycle_spawn_beacon_mp.csv";
}

set_regular_container_spawn_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.container_spawn_table = "mp/alien/beacon_container_spawn_sp.csv";
  else
    level.container_spawn_table = "mp/alien/beacon_container_spawn.csv";
}

set_regular_alien_definition_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.default_alien_definition = "mp/alien/beacon_alien_definition_sp.csv";
  else
    level.default_alien_definition = "mp/alien/beacon_alien_definition.csv";
}

chaos_init() {
  maps\mp\alien\_hive::init_hive_locs();
  maps\mp\alien\_chaos::init();
  register_egg_default_loc();
  set_end_cam_position();
  thread player_containment();
}

player_containment() {
  level waittill("spawn_nondeterministic_entities");
  var_0 = spawn("script_model", (-674, 765, 136));
  var_0 setModel("beacon_single_sliding_door_left");
  var_0.angles = (0, 0, 0);
  var_1 = spawn("script_model", (-742, 765, 136));
  var_1 setModel("beacon_single_sliding_door_left");
  var_1.angles = (0, 0, 0);
  var_2 = getent("player256x256x8", "targetname");
  var_2.origin = (-745, 760, 120);
  var_2.angles = (270, 270, 0);
  var_3 = spawn("script_model", (-410.3, 785, 280));
  var_3 setModel("armory_weapon_chest");
  var_3.angles = (0, 180, 0);
  var_4 = getent("player512x512x8", "targetname");

  if(isDefined(var_4)) {
    var_4.origin = (752, 3398, 64);
    var_4.angles = (270, 180, 180);
    var_5 = spawn("script_model", (842, 3218, 440));
    var_5 clonebrushmodeltoscriptmodel(var_4);
    var_5.origin = (842, 3218, 440);
    var_5.angles = (270, 180, 180);
  }

  var_6 = getent("monsterplayer512x512x8", "targetname");

  if(isDefined(var_6)) {
    var_6.origin = (1098, 3046, 440);
    var_6.angles = (270, 270, -180);
    var_7 = spawn("script_model", (891, 3038, 184));
    var_7 setModel("tool_cabinet_02_iw6");
    var_7.angles = (0, 180, 0);
  }
}

set_end_cam_position() {
  var_0 = getEntArray("mp_global_intermission", "classname");
  var_1 = common_scripts\utility::getclosest(level.eggs_default_loc, var_0);

  switch (maps\mp\alien\_utility::get_chaos_area()) {
    case "welldeck":
      var_1.origin = (264, 3012, 492);
      var_1.angles = (15, 225, 0);
      break;
    case "cargo":
      var_1.origin = (264, 3012, 492);
      var_1.angles = (15, 225, 0);
      break;
    case "lab":
      var_1.origin = (264, 3012, 492);
      var_1.angles = (15, 225, 0);
      break;
  }
}

register_egg_default_loc() {
  switch (maps\mp\alien\_utility::get_chaos_area()) {
    case "welldeck":
      maps\mp\alien\_chaos::set_egg_default_loc((-116, 2240, -1264));
      break;
    case "cargo":
      maps\mp\alien\_chaos::set_egg_default_loc((-116, 2240, -1264));
      break;
    case "lab":
      maps\mp\alien\_chaos::set_egg_default_loc((-116, 2240, -1264));
      break;
  }
}

set_hardcore_extinction_spawn_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_beacon_hardcore_sp.csv";
  else
    level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_beacon_hardcore_mp.csv";
}

set_hardcore_container_spawn_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.container_spawn_table = "mp/alien/beacon_container_spawn_hardcore_sp.csv";
  else
    level.container_spawn_table = "mp/alien/beacon_container_spawn_hardcore.csv";
}

set_hardcore_alien_definition_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.default_alien_definition = "mp/alien/beacon_alien_definition_hardcore_sp.csv";
  else
    level.default_alien_definition = "mp/alien/beacon_alien_definition_hardcore_mp.csv";
}

beacon_door_encounter_logic() {
  level endon("game_ended");

  for(;;) {
    level waittill("start_spawn_event", var_0);
    var_1 = var_0 + "_" + randomintrange(1, 4);
    maps\mp\alien\_spawn_director::activate_spawn_event(var_1);
  }
}

lower_cargo_container() {
  var_0 = 5;
  wait 4;
  var_1 = getent("beacon_crane_top", "targetname");
  var_2 = getent("beacon_crane_bottom", "targetname");
  var_1 scriptmodelplayanimdeltamotion("alien_beacon_crane_enter_base");
  var_2 scriptmodelplayanim("alien_beacon_crane_enter_base");
  var_3 = getent("cargo_container_3_door_01_start", "targetname");
  var_4 = getent("cargo_container_3_door_02_start", "targetname");
  var_5 = getent("crane_sound_origin_1", "targetname");
  var_6 = getent("crane_sound_origin_2", "targetname");
  var_7 = getEntArray("crane_container_top_bad_place", "targetname");
  var_8 = getEntArray("move_container_clip", "targetname");
  var_9 = getEntArray("move_container", "targetname");
  var_9 = common_scripts\utility::add_to_array(var_9, var_3);
  var_9 = common_scripts\utility::add_to_array(var_9, var_4);
  var_9 = common_scripts\utility::add_to_array(var_9, var_5);
  var_9 = common_scripts\utility::add_to_array(var_9, var_6);
  var_9 = common_scripts\utility::array_combine(var_9, var_8);
  var_9 = common_scripts\utility::array_combine(var_9, var_7);

  foreach(var_11 in var_9)
  var_11 linkto(var_1, "j_Base_Wire_07");

  var_13 = getent("crane_container_bad_place", "targetname");
  badplace_brush("crane_lower_spot", 0, var_13, "axis");
  var_4 thread lower_cargo_container_sfx();
  wait(var_0 + 1);
  badplace_delete("crane_lower_spot");

  if(isDefined(var_13))
    var_13 delete();

  foreach(var_11 in var_9)
  var_11 unlink();

  foreach(var_17 in var_7)
  var_17 disconnectpaths();
}

lower_cargo_container_sfx() {
  wait 0.02;
  self playsoundonmovingent("scn_beacon_crane_down");
}

raise_cargo_container_sfx(var_0) {
  wait 0.04;
  var_1 = lookupsoundlength(var_0);
  self playsoundonmovingent(var_0);
  wait(var_1 / 1000 + 1);
  self unlink();
  self delete();
}

raise_cargo_container() {
  var_0 = getent("cargo_room_control_switch", "targetname");
  var_0 sethintstring(&"MP_ALIEN_BEACON_CRANE_HINT");
  var_1 = getent(var_0.target, "targetname");
  maps\mp\alien\_outline_proto::add_to_outline_watch_list(var_1, 0);
  var_0 waittill("trigger", var_2);
  var_2 playlocalsound("scn_drillbot_activate");
  level notify("trigger_first_archer_bink");
  thread maps\mp\mp_alien_beacon_vignettes::nag_bink_toggle();
  var_0 makeunusable();
  thread maps\mp\mp_alien_beacon_vignettes::pre_crane_vo();
  maps\mp\alien\_outline_proto::remove_from_outline_watch_list(var_1);
  wait 5;
  var_3 = getent("beacon_crane_top", "targetname");
  var_4 = getent("beacon_crane_bottom", "targetname");
  var_5 = getEntArray("move_container_clip", "targetname");
  var_6 = getEntArray("crane_container_top_bad_place", "targetname");
  var_7 = getEntArray("move_container", "targetname");
  var_8 = getent("crane_tag", "targetname");
  var_8.origin = var_3 gettagorigin("j_Base_Wire_07");
  var_8.angles = var_3 gettagangles("j_Base_Wire_07");
  var_9 = getent("cargo_players_trigger", "targetname");
  var_9 wait_for_players_to_enter_container(var_8);
  var_9 thread update_player_in_container_status();

  foreach(var_11 in var_5)
  var_11.unresolved_collision_func = ::crane_unresolved_collision;

  level notify("crane_started");
  common_scripts\utility::flag_set("everyone_in_cargo_container");
  level thread disable_cargo_door_drill_spots();
  level thread teleport_drill_to_container_if_needed();
  var_9 enablelinkto();
  var_9 linkto(var_8);
  var_13 = getent("crane_sound_origin_1", "targetname");
  var_14 = getent("crane_sound_origin_2", "targetname");
  var_7 = common_scripts\utility::add_to_array(var_7, var_13);
  var_7 = common_scripts\utility::add_to_array(var_7, var_14);
  var_7 = common_scripts\utility::array_combine(var_7, var_6);
  var_7 = common_scripts\utility::array_combine(var_7, var_5);

  foreach(var_16 in var_7)
  var_16 linkto(var_8);

  thread update_override_info((659, 1494, 1024.13), (0, 90, 0));
  maps\mp\_utility::delaythread(30, ::crane_walls_hide, 1);
  var_3 scriptmodelplayanimdeltamotion("alien_beacon_crane_exit_base");
  var_4 scriptmodelplayanim("alien_beacon_crane_exit_base");
  var_8 scriptmodelplayanimdeltamotion("alien_beacon_crane_exit_top_tag");
  var_13 thread raise_cargo_container_sfx("scn_beacon_crane_up_01");
  var_14 thread raise_cargo_container_sfx("scn_beacon_crane_up_02");
  thread crane_vo_waiter();
  level notify("cinematic_end");
  level notify("godfathers_explanation");
  wait 30;
  maps\mp\alien\_achievement_dlc2::update_blocker_achievements("blocker_cargo");
  badplace_delete("crane_lower_spot");

  foreach(var_11 in var_6)
  var_11 disconnectpaths();

  level notify("beacon_starting_topdeck");
  common_scripts\utility::flag_set("players_on_top_deck");
  var_9 unlink();
  var_9 delete();
  level thread teleport_player_if_not_on_top_deck();
  maps\mp\_utility::delaythread(1.0, ::teleport_drill_if_below_top_deck);
  level.watch_bomb_stuck_override = undefined;
}

crane_unresolved_collision(var_0) {
  var_0 thread teleport_player_to_top_deck(undefined);
}

crane_vo_waiter() {
  var_0 = lookupsoundlength("beacon_gdf_drcrosshasbeendesignated") / 1000;
  wait(30 - var_0);
  thread maps\mp\mp_alien_beacon_vignettes::crane_vo();
}

disable_cargo_door_drill_spots() {
  var_0 = [];

  foreach(var_2 in level.stronghold_hive_locs) {
    if(isDefined(var_2.target) && (var_2.target == "door_hive_7" || var_2.target == "door_hive_8")) {
      if(isDefined(var_2.icon))
        var_2.icon destroy();

      var_2 makeunusable();
      var_2 sethintstring("");
      var_2 notify("stop_listening");
      var_2.target = undefined;
      var_0[var_0.size] = var_2;
    }
  }

  level.stronghold_hive_locs = common_scripts\utility::array_remove_array(level.stronghold_hive_locs, var_0);
}

teleport_player_to_spot(var_0, var_1) {
  self endon("disconnect");
  self cancelmantle();
  self dontinterpolate();
  self setorigin(var_0);
  self.forceteleportorigin = var_0;

  if(isDefined(var_1)) {
    var_1.origin = var_0;
    self.reviveiconent.origin = var_0;
  }

  self notify("teleport_finished");

  if(isDefined(self.teleport_overlay)) {
    self.teleport_overlay fadeovertime(0.75);
    self.teleport_overlay.alpha = 0;
    wait 1;

    if(isDefined(self.teleport_overlay))
      self.teleport_overlay destroy();
  }

  maps\mp\_utility::clearlowermessage("cargo_teleport");

  if(isDefined(self.reviveent))
    thread wait_for_spawn_and_remove_forceteleport();
  else
    self.forceteleportorigin = undefined;
}

wait_for_spawn_and_remove_forceteleport() {
  for(;;) {
    level waittill("player_spawned", var_0);

    if(self == var_0) {
      break;
    }
  }

  self.forceteleportorigin = undefined;
}

teleport_black_screen() {
  self endon("disconnect");
  maps\mp\_utility::setlowermessage("cargo_teleport", &"MP_ALIEN_BEACON_CARGO_TELEPORT", 3);
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
}

update_player_in_container_status() {
  level endon("beacon_starting_topdeck");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self)) {
        var_1.on_container = 1;
        continue;
      }

      var_1.on_container = 0;
    }

    common_scripts\utility::waitframe();
  }
}

teleport_drill_to_container_if_needed() {
  level endon("beacon_starting_topdeck");
  level endon("drill_planted");

  for(;;) {
    var_0 = 0;
    var_1 = (432, 1487, 1033);
    var_2 = (0, 0, 0);

    if(isDefined(level.drill_linked_to_container))
      var_0 = 1;

    if(isDefined(level.drill_carrier)) {
      foreach(var_4 in level.players) {
        if(level.drill_carrier == var_4)
          var_0 = 1;
      }
    }

    if(!var_0) {
      level.drill.origin = var_1;
      level.drill.angles = var_2;
      level.drill maps\mp\alien\_drill::set_drill_icon();
    }

    wait 0.1;
  }
}

teleport_player_to_top_deck(var_0) {
  var_1 = [];
  var_1[0] = (260, 1487, 1043);
  var_1[1] = (360, 1487, 1043);
  var_1[2] = (260, 1387, 1043);
  var_1[3] = (360, 1387, 1043);
  var_2 = (0, 0, 0);
  var_3 = 0;

  while(!var_3) {
    foreach(var_5 in var_1) {
      if(canspawn(var_5) && !positionwouldtelefrag(var_5)) {
        if(!isDefined(self.teleport_overlay)) {
          thread teleport_black_screen();
          wait 1;
        }

        if(canspawn(var_5) && !positionwouldtelefrag(var_5)) {
          if(isDefined(var_0) && var_0 != self)
            teleport_player_to_spot(var_5, var_0);
          else
            teleport_player_to_spot(var_5);

          var_3 = 1;
          break;
        } else
          continue;
      }
    }

    wait 0.1;
  }

  self notify("player_teleported");
}

teleport_player_if_not_on_top_deck() {
  level endon("stop_teleport_script");

  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = var_1;

      if(isDefined(var_1.reviveent))
        var_2 = var_1.reviveent;

      if(!isDefined(var_1.forceteleportorigin) && var_2.origin[2] < 1000) {
        var_1 thread teleport_player_to_top_deck(var_2);
        wait 0.1;
      }
    }

    wait 0.25;
  }
}

teleport_drill_if_below_top_deck() {
  level endon("stop_drill_teleport_script");
  var_0 = (432, 1487, 1033);
  var_1 = (0, 0, 0);

  for(;;) {
    if(isDefined(level.drill) && level.drill.origin[2] < 1000) {
      level.drill.origin = var_0;
      level.drill.angles = var_1;
      level.drill maps\mp\alien\_drill::set_drill_icon();
    }

    wait 1.0;
  }
}

cargo_activate_crane_hint() {
  level endon("crane_activated");
  iprintlnbold("Activate the crane to progress");
  wait 8;
  iprintlnbold("Activate the crane to progress");
  wait 12;
  iprintlnbold("Activate the crane to progress");
  wait 18;
  iprintlnbold("Activate the crane to progress");
}

crane_walls_hide(var_0) {
  var_1 = getEntArray("cargo_container_walls", "targetname");

  foreach(var_3 in var_1)
  var_3 notsolid();

  if(maps\mp\alien\_utility::is_true(var_0)) {
    foreach(var_3 in var_1)
    var_3 delete();
  }
}

crane_walls_show_and_link(var_0) {
  var_1 = getEntArray("cargo_container_walls", "targetname");

  foreach(var_3 in var_1) {
    var_3 solid();
    var_3 linkto(var_0);
  }
}

wait_for_players_to_enter_container(var_0) {
  level.all_players_on_container = 0;
  var_1 = "waypoint_alien_blocker";
  var_2 = 14;
  var_3 = 14;
  var_4 = 0.75;
  var_5 = self.origin + (0, 0, 4);
  var_6 = maps\mp\alien\_hud::make_waypoint(var_1, var_2, var_3, var_4, var_5);

  for(;;) {
    self waittill("trigger", var_7);

    if(!maps\mp\alien\_utility::is_true(var_7.on_container))
      var_7.on_container = 1;

    var_8 = 1;
    var_9 = 0;

    foreach(var_7 in level.players) {
      if(!var_7 isonground() || !maps\mp\alien\_utility::is_true(var_7.on_container) || !var_7 istouching(self) || distance(var_7.origin, var_0.origin) > 125)
        var_8 = 0;

      if(isDefined(level.drill_carrier) && level.drill_carrier == var_7)
        var_9 = 1;
    }

    if(!(var_9 || isDefined(level.drill_linked_to_container)))
      var_8 = 0;

    if(var_8) {
      level.all_players_on_container = 1;
      var_6 destroy();
      return;
    }
  }
}

cargo_get_in_crane_hint() {
  level endon("crane_started");
  iprintlnbold("Everyone get in the lift container!");
  wait 8;
  iprintlnbold("Everyone get in the lift container!");
  wait 12;
  iprintlnbold("Everyone get in the lift container!");
  wait 18;
  iprintlnbold("Everyone get in the lift container!");
}

beacon_cargo_drill_onconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread check_for_player_near_bot_with_drill();
  }
}

beacon_play_sound_on_moving_tag(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_3 = spawn("script_model", (0, 0, 0));
    var_3 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
    wait 0.1;
    var_3 playsoundonmovingent(var_0);

    if(isDefined(var_2))
      wait(var_2);
    else
      wait 10;

    var_3 delete();
  }
}

player_death_trigger_monitor() {
  var_0 = getEntArray("player_drill_death", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _death_trigger_monitor();
}

_death_trigger_monitor() {
  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      var_1 = self;
      var_2 = self;
      var_3 = 100;
      var_4 = "MOD_TRIGGER_HURT";
      var_5 = undefined;
      var_6 = self.origin;
      var_7 = "none";
      var_8 = undefined;
      var_0 maps\mp\alien\_death::onplayerkilled(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      logprint("!!PLAYER WAS KILLED BY TRIGGER!! : " + var_0.name + " killed by death trigger at: " + var_0.origin + "\\n");
    }
  }
}

beacon_intro_music() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread beacon_intro_music_play();
  }
}

beacon_intro_music_play() {
  self waittill("spawned_player");

  foreach(var_1 in level.players) {
    wait 0.01;

    if(common_scripts\utility::flag_exist("boat_ride_over") && !common_scripts\utility::flag("boat_ride_over")) {
      var_1 stoplocalsound("us_spawn_music");

      if(!level.splitscreen || level.splitscreen && !isDefined(level.playedbeaconstartingmusic)) {
        if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
          level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc2_beacon_intro");

        if(level.splitscreen)
          level.playedbeaconstartingmusic = 1;
      }

      continue;
    }

    wait 0.1;
    var_1 stoplocalsound("us_spawn_music");
    wait 0.1;
    var_1 stoplocalsound("us_spawn_music");
    wait 0.1;
    var_1 stoplocalsound("us_spawn_music");
    wait 0.1;
    var_1 stoplocalsound("us_spawn_music");
    wait 0.1;
    var_1 stoplocalsound("us_spawn_music");
  }
}

mp_alien_beacon_drill_attack_override() {
  if(level.current_hive_name == "cargo_area_main") {
    cargo_blocker_door_setup();
    self.synch_attack_setup = undefined;
    return;
  }

  if(level.current_hive_name != "cargo_area_mini_3") {
    return;
  }
  var_0 = [];
  var_0["brute"][0] = maps\mp\alien\_utility::set_attack_sync_direction((-1, 0, 0), "alien_drill_attack_drill_R_enter", "alien_drill_attack_drill_R_loop", "alien_drill_attack_drill_R_exit", "attack_drill_right", "attack_drill");
  var_0["brute"][1] = maps\mp\alien\_utility::set_attack_sync_direction((1, 0, 0), "alien_drill_attack_drill_L_enter", "alien_drill_attack_drill_L_loop", "alien_drill_attack_drill_L_exit", "attack_drill_left", "attack_drill");
  var_0["goon"][0] = maps\mp\alien\_utility::set_attack_sync_direction((-1, 0, 0), "alien_goon_drill_attack_drill_R_enter", "alien_goon_drill_attack_drill_R_loop", "alien_goon_drill_attack_drill_R_exit", "attack_drill_right", "attack_drill");
  var_0["goon"][1] = maps\mp\alien\_utility::set_attack_sync_direction((1, 0, 0), "alien_goon_drill_attack_drill_L_enter", "alien_goon_drill_attack_drill_L_loop", "alien_goon_drill_attack_drill_L_exit", "attack_drill_left", "attack_drill");
  var_1[0] = "offline";
  var_1[1] = "death";
  var_1[2] = "drill_complete";
  var_1[3] = "destroyed";
  maps\mp\alien\_utility::set_synch_attack_setup(var_0, 1, var_1, undefined, maps\mp\alien\_drill::drill_synch_attack_play_anim, maps\mp\alien\_drill::drill_synch_attack_play_anim, maps\mp\alien\_drill::drill_synch_attack_exit, "drill");
}

beacon_weapon_stats_update_name(var_0) {
  switch (var_0) {
    case "iw6_altalienlsat_mp":
      var_0 = "iw6_alienDLC12_mp";
      break;
    case "iw6_altaliensvu_mp":
      var_0 = "iw6_alienDLC13_mp";
      break;
    case "iw6_altalienarx_mp":
      var_0 = "iw6_alienDLC14_mp";
      break;
    case "iw6_altalienmaverick_mp":
      var_0 = "iw6_alienDLC15_mp";
      break;
    default:
      break;
  }

  return var_0;
}

beacon_specific_vo_callouts(var_0) {
  var_0["beacon_vo"] = ::playbeaconvo;
  var_0["start_containment"] = ::beacon_start_containment_vo;
  var_0["warn_gas"] = ::beacon_warn_gas_vo;
  var_0["warn_pipes"] = ::beacon_warn_pipes;
  var_0["kraken_intro"] = ::playkrakenintrovo;
  var_0["kraken_vo"] = ::playkrakenvo;
  var_0["tentacle_gone"] = ::playkrakenvo;
  var_0["warn_kraken_attack"] = ::playkrakenattackvo;
  return var_0;
}

playbeaconvo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_1.size < 1) {
    return;
  }
  var_2 = var_1[0];

  if(!soundexists(var_2.vo_prefix + var_0)) {
    return;
  }
  var_1 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_1.size < 1) {
    return;
  }
  var_2 = var_1[0];
  var_3 = var_2.vo_prefix + var_0;
  var_2 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_3);
}

listen_for_emerge_phase() {
  var_0 = 1;

  for(;;) {
    level waittill("kraken_emerge_phase");

    if(var_0 == 0) {
      level notify("dlc_vo_notify", "kraken_vo", "kraken_port");
      var_0 = 1;
    } else {
      level notify("dlc_vo_notify", "kraken_vo", "kraken_starboard");
      var_0 = 0;
    }

    wait 5;
    level notify("dlc_vo_notify", "kraken_vo", "use_turrets");
  }
}

beacon_start_containment_vo() {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return;
  }
  var_0 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_0.size < 1) {
    return;
  }
  var_1 = var_0[0];
  var_0 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_0.size < 1) {
    return;
  }
  var_1 = var_0[0];
  var_2 = var_1.vo_prefix + "start_containment";
  var_1 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_2);
}

beacon_warn_gas_vo() {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return;
  }
  var_0 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_0.size < 1) {
    return;
  }
  var_1 = var_0[0];

  if(isDefined(level.warn_gas) && randomint(100) > 10) {
    return;
  }
  level.warn_gas = 1;
  var_2 = var_1.vo_prefix + "warn_gas";
  var_1 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_2);
}

beacon_warn_pipes(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_1.size < 1) {
    return;
  }
  var_2 = var_1[0];

  if(!soundexists(var_2.vo_prefix + var_0)) {
    return;
  }
  var_3 = 15000;
  var_4 = gettime();

  if(!isDefined(level.next_pipe_vo_time))
    level.next_pipe_vo_time = var_4 + randomintrange(var_3, var_3 + 2000);
  else if(var_4 < level.next_pipe_vo_time) {
    return;
  }
  level.next_pipe_vo_time = var_4 + randomintrange(var_3, var_3 + 1500);
  var_5 = var_2.vo_prefix + var_0;
  var_2 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_5);
}

playkrakenintrovo() {
  wait 1.0;
  var_0 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_0.size < 1) {
    return;
  }
  var_1 = var_0[0];
  var_2 = var_1.vo_prefix + "kraken_intro";
  var_1 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_2);
}

playkrakenvo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_1.size < 1) {
    return;
  }
  var_2 = var_1[0];

  if(!soundexists(var_2.vo_prefix + var_0)) {
    return;
  }
  if(var_0 == "warn_metal")
    wait 5.0;

  if(var_0 == "kraken_weak")
    wait 5.0;

  if(var_0 == "warn_emp")
    wait 5.0;

  var_3 = var_2.vo_prefix + var_0;
  var_2 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_3, "high", 10);
}

playkrakenattackvo() {
  var_0 = "warn_kraken_attack";

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_1.size < 1) {
    return;
  }
  var_2 = var_1[0];

  if(!soundexists(var_2.vo_prefix + var_0)) {
    return;
  }
  var_3 = 20000;
  var_4 = gettime();

  if(!isDefined(level.next_kraken_attack_vo_time))
    level.next_kraken_attack_vo_time = var_4 + randomintrange(var_3, var_3 + 2000);
  else if(var_4 < level.next_kraken_attack_vo_time) {
    return;
  }
  level.next_kraken_attack_vo_time = var_4 + randomintrange(var_3, var_3 + 1500);
  var_5 = var_2.vo_prefix + var_0;
  var_2 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_5, "high", 5);
}

beacon_customprematchperiod() {
  if(!maps\mp\alien\_utility::is_true(level.introscreen_done))
    level.prematchperiod = 10;

  while(level.players.size == 0)
    wait 0.05;

  foreach(var_1 in level.players) {
    var_1 maps\mp\_utility::freezecontrolswrapper(1);
    var_1 disableweapons();
  }

  if(!maps\mp\alien\_intro_sequence::intro_sequence_enabled()) {
    wait 7;
    level notify("introscreen_over");
    level.introscreen_done = 1;
    level notify("spawn_intro_drill");

    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      level.players[var_3] maps\mp\_utility::freezecontrolswrapper(0);
      level.players[var_3] enableweapons();

      if(!isDefined(level.players[var_3].pers["team"]))
        continue;
    }

    return;
  }

  if(level.prematchperiod > 0) {
    var_1 = level wait_for_first_player_connect();

    if(maps\mp\alien\_intro_sequence::intro_sequence_enabled())
      level thread maps\mp\alien\_intro_sequence::play_intro_sequence(var_1);

    level thread show_introscreen_text();

    if(isDefined(level.intro_dialogue_func))
      level thread[[level.intro_dialogue_func]]();

    wait(level.prematchperiod - 3);

    if(isDefined(level.postintroscreenfunc))
      [[level.postintroscreenfunc]]();

    level notify("introscreen_over");
    level.introscreen_done = 1;
  } else {
    wait 1;
    level notify("introscreen_over");
  }

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    level.players[var_3] maps\mp\_utility::freezecontrolswrapper(0);
    level.players[var_3] enableweapons();

    if(!isDefined(level.players[var_3].pers["team"]))
      continue;
  }
}

wait_for_first_player_connect() {
  var_0 = undefined;

  if(level.players.size == 0)
    level waittill("connected", var_0);
  else
    var_0 = level.players[0];

  return var_0;
}

show_introscreen_text() {
  wait 2;
  var_0 = maps\mp\alien\_hud::introscreen_corner_line(level.introscreen_line_1, 1);
  wait 1;
  var_1 = maps\mp\alien\_hud::introscreen_corner_line(level.introscreen_line_2, 2);
  wait 1;
  var_2 = maps\mp\alien\_hud::introscreen_corner_line(level.introscreen_line_3, 3);
  wait 1;
  var_3 = maps\mp\alien\_hud::introscreen_corner_line(level.introscreen_line_4, 4);
  level waittill("introscreen_over");
  var_0 fadeovertime(3);
  var_1 fadeovertime(3);
  var_2 fadeovertime(3);
  var_3 fadeovertime(3);
  wait 3.1;
  var_0.alpha = 0;
  var_1.alpha = 0;
  var_2.alpha = 0;
  var_3.alpha = 0;
  var_0 destroy();
  var_1 destroy();
  var_2 destroy();
  var_3 destroy();
}

beacon_non_player_drill_plant_check() {
  return level.non_player_drill_plant;
}

beacon_get_alien_model(var_0) {
  var_1 = level.alien_types[var_0].attributes["model"];

  if(isDefined(level.kraken))
    var_1 = var_1 + "_lowlod";

  return var_1;
}

beacon_cangive_weapon_handler_func(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(self hasweapon("aliensoflam_mp"))
    var_4++;

  if(self.hasriotshield || self.hasriotshieldequipped)
    var_4++;

  var_5 = self getcurrentweapon();
  var_6 = 0;

  if(issubstr(var_5, "aliendlc11"))
    var_6 = 1;

  if(var_6 && var_0.size + 1 > var_3 + var_4)
    return 0;

  return 1;
}

beacon_give_weapon_handler_func(var_0) {
  var_1 = self getcurrentweapon();

  if(issubstr(var_1, "aliendlc11"))
    return 0;

  return undefined;
}

beacon_hive_icon_override_func() {
  if(isDefined(self.target) && self.target == "cargo_area_main")
    return 1;

  return 0;
}

disable_lab_doors() {
  foreach(var_1 in level.stronghold_hive_locs) {
    if(isDefined(var_1.target) && (var_1.target == "door_hive_10" || var_1.target == "door_hive_9")) {
      if(isDefined(var_1.icon))
        var_1.icon destroy();

      var_1 makeunusable();
      var_1 sethintstring("");
      var_1 notify("stop_listening");
      var_1.target = undefined;
      level.stronghold_hive_locs = common_scripts\utility::array_remove(level.stronghold_hive_locs, var_1);
    }
  }
}

beacon_randombox_item_check(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "trophy":
    case "flare":
      self takeweapon("iw6_aliendlc21_mp");
      return;
  }
}

setintermissioncam() {
  var_0 = getent("mp_global_intermission", "classname");
  var_0.origin = (-316.775, 6480.45, 1528);
  var_0.angles = (10, 90, 0);
}

fix_beacon_jump_exploit() {
  wait 3.0;
  var_0 = getent("player128x128x128", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0.origin;
  var_0.origin = (-224, -608, 118);

  while(level.current_hive_name != "door_hive_1_post" && level.current_hive_name != "well_deck_2_post")
    wait 0.25;

  var_0.origin = var_1;
}

fix_cargo_leftovers() {
  level endon("game_ended");
  level waittill("beacon_starting_topdeck");
  var_0 = maps\mp\alien\_spawnlogic::get_alive_agents();

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2) && var_2.origin[2] < 925) {
      var_2.scene = 1;
      var_2 suicide();
    }

    wait 0.1;
  }

  var_4 = [];

  foreach(var_6 in level.players) {
    if(isDefined(var_6.crafted_items["alien_crafting_hypno_trap"])) {
      var_7 = var_6.crafted_items["alien_crafting_hypno_trap"];

      if(!isarray(var_7))
        var_4 = common_scripts\utility::add_to_array(var_4, var_7);
      else
        var_4 = common_scripts\utility::array_combine(var_4, var_7);
    }

    if(isDefined(var_6.crafted_items["alien_crafting_tesla_trap"])) {
      var_7 = var_6.crafted_items["alien_crafting_tesla_trap"];

      if(!isarray(var_7))
        var_4 = common_scripts\utility::add_to_array(var_4, var_7);
      else
        var_4 = common_scripts\utility::array_combine(var_4, var_7);
    }
  }

  var_4 = common_scripts\utility::array_combine(var_4, level.turrets);
  var_4 = common_scripts\utility::array_combine(var_4, level.placedims);
  var_4 = common_scripts\utility::array_combine(var_4, level.balldrones);

  foreach(var_10 in var_4) {
    if(isDefined(var_10) && isDefined(var_10.origin) && !isDefined(var_10.carriedby) && var_10.origin[2] < 925)
      var_10 notify("death");
  }
}

should_enable_crafting() {
  if(maps\mp\alien\_utility::is_chaos_mode())
    return 0;

  return 1;
}

beacon_adjust_spawnlocation(var_0) {
  if(isDefined(var_0.script_noteworthy)) {
    switch (var_0.script_noteworthy) {
      case "cargo_air_vent_down_01":
        if(var_0.origin == (661, 2965, 501)) {
          var_0.origin = (661, 2826, 501);
          var_0.angles = (0, 90, 0);
          var_0.script_noteworthy = "cargo_air_vent_down_02";
        }

        break;
      case "cargo_crawl_out_grate_1":
        var_0.origin = (-943, 1719, 77.5);
        var_0.angles = (0, 179.1, 0);
        break;
      case "cargo_crawl_out_grate_3":
        var_0.origin = (704, 1720, 76);
        var_0.angles = (0, 179.1, 0);
        break;
    }
  }

  return var_0;
}

spawn_weapon_in_boss_area() {
  var_0 = common_scripts\utility::getstructarray("item", "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }
    if(var_2.script_noteworthy == "weapon_iw6_alienhoneybadger_mp") {
      var_2.script_noteworthy = "weapon_iw6_altalienarx_mp";
      var_2.origin = (-775.2, 882.1, 6);
      var_2.angles = (311.4, 90, 0);
      continue;
    }

    if(var_2.script_noteworthy == "weapon_iw6_alieng28_mp") {
      var_2.script_noteworthy = "weapon_iw6_alienvks_mp_alienvksscope";
      var_2.origin = (-194.3, 822.9, 156.5);
      continue;
    }

    if(var_2.script_noteworthy == "weapon_iw6_altaliensvu_mp") {
      var_2.script_noteworthy = "weapon_iw6_alienvks_mp_alienvksscope";
      var_2.origin = (512.6, 782, 157);
    }
  }

  var_4 = spawnStruct();
  var_4.script_noteworthy = "weapon_iw6_altalienarx_mp";
  var_4.targetname = "item";
  var_4.origin = (-326, 8536, 1170);
  var_4.angles = (311.4, 90, 0);
  var_4.radius = 200;
  return var_4;
}