/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_last.gsc
*****************************************************/

main() {
  level.extinction_episode = 4;
  level.intel_table = "mp/alien/alien_last_intel.csv";
  level.collectibles = [];
  level.encounter_score_components = [];
  level.eog_score_components = [];
  level.cycle_health_scalar = 1.0;
  level.cycle_damage_scalar = 1.0;
  level.cycle_reward_scalar = 1.0;
  level.ancestor_projectile_solo_scalar = 0.6;
  level.drill_damage_scalar = 1.65;
  level.removed_hives = [];
  common_scripts\utility::flag_init("intro_sequence_complete");
  level.initial_spawn_loc_override_func = ::last_player_initial_spawn_loc_override;
  level.introscreen_line_1 = &"MP_ALIEN_LAST_INTRO_LINE_1";
  level.introscreen_line_2 = &"MP_ALIEN_LAST_INTRO_LINE_2";
  level.introscreen_line_3 = &"MP_ALIEN_LAST_INTRO_LINE_3";
  level.introscreen_line_4 = &"MP_ALIEN_LAST_INTRO_LINE_4";
  maps\mp\alien\_utility::alien_mode_enable("kill_resource", "wave", "lurker", "collectible", "loot", "pillage", "challenge", "outline", "scenes");
  level.recipe_setup_func = ::last_recipe_setup_func;
  level.random_crafting_list = ["amolecular", "wire", "cellbattery", "liquidbattery", "nucleicbattery", "fuse", "pipe", "pressureplate", "tnt", "resin", "orangebiolum", "bluebiolum", "biolum", "oorangebiolum", "bbluebiolum", "bbiolum", "detonator", "casing", "substrate", "cortexgel", "cortexhousing"];
  level thread maps\mp\alien\_crafting::init();
  level thread maps\mp\alien\_crafting_traps::init();
  level.hypno_trap_func = maps\mp\alien\_crafting_traps::tryuseplaceable;
  level.tesla_trap_func = maps\mp\alien\_crafting_traps::tryuseplaceable;
  level maps\mp\alien\mp_alien_last_turret::last_turret_init();
  level.custom_alien_death_func = ::last_custom_death;
  var_0 = ["main_base", "gas_station_outpost", "parking_outpost", "rooftop_outpost", "left_transition", "upper_left_transition", "middle_transition", "upper_right_transition", "right_transition"];
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
  level.challenge_registration_func = maps\mp\alien\mp_alien_last_challenges::register_last_challenges;
  level.challenge_scalar_func = maps\mp\alien\mp_alien_last_challenges::last_challenge_scalar_func;
  level.custom_death_challenge_func = maps\mp\alien\mp_alien_last_challenges::last_death_challenge_func;
  level.custom_damage_challenge_func = maps\mp\alien\mp_alien_last_challenges::last_damage_challenge_func;
  level.include_default_achievements = 1;
  level.achievement_registration_func = maps\mp\alien\_achievement_dlc4::register_achievements_dlc4;
  level.achievement_you_wish_cb = ::achievement_you_wish_func;
  level.update_alien_kill_achievements_func = maps\mp\alien\_achievement_dlc4::update_alien_kill_achievements_dlc4;
  level.include_default_unlocks = 1;
  level.escape_cycle = 19;
  level.custom_pillageinitfunc = ::mp_alien_last_pillage_init;
  maps\mp\alien\_pillage_locker::locker_pillage_functions_init();
  level.pillage_locker_offset_override_func = ::dlc_4_offset_locker_trigger_model;
  level.level_locker_weapon_pickup_string_func = ::last_locker_weapon_pickup_string_func;
  level.locker_ark_check_func = ::last_locker_ark_check_func;
  maps\mp\gametypes\aliens::setup_last_hive("left_lung_00");
  level.cac_vo_male = common_scripts\utility::array_randomize(["p6_", "p5_"]);
  level.cac_vo_female = common_scripts\utility::array_randomize(["p8_", "p7_"]);
  level.level_specific_vo_callouts = ::last_specific_vo_callouts;
  level.should_play_next_hive_vo_func = ::last_should_play_next_hive_vo_func;
  level.custom_onspawnplayer_func = ::mp_alien_last_onspawnplayer_func;
  maps\mp\alien\_alien_maaws::alien_maaws_init();
  level.level_drill_damage_adjust_function = ::dlc4_drill_damage_adjust_function;
  thread maps\mp\alien\_alien_class_skills_main::main();
  set_spawn_table();
  set_container_spawn_table();
  set_alien_definition_table();
  level.alien_collectibles_table = "mp/alien/collectibles_last.csv";
  level.spawn_node_info_table = "mp/alien/last_spawn_node_info.csv";
  level.alien_challenge_table = "mp/alien/mp_alien_last_challenges.csv";
  level.alien_character_cac_table = "mp/alien/alien_cac_presets.csv";
  level.container_spawn_table = "mp/alien/last_container_spawn.csv";
  maps\mp\alien\_container_spawn::init_container_spawn();
  level.enter_area_func = ::last_enter_area_func;
  level.leave_area_func = ::last_leave_area_func;
  level.dlc_melee_override_func = ::last_melee_override_func;
  level.dlc_alien_init_override_func = ::last_alien_init_override_func;
  level.alien_attack_override_func = ::last_alien_attack_override_func;
  level.dlc_alien_death_override_func = ::last_alien_death_override_func;
  level.dlc_idle_anim_state_override_func = ::last_alien_idle_anim_state_override_func;
  level.dlc_alien_type_node_match_override_func = ::last_alien_type_node_match_override_func;
  level.dlc_alien_jump_override = ::last_alien_jump_override;
  level.dlc_can_do_pain_override_func = ::last_can_do_pain_override_func;
  level.dlc_alien_can_retreat_override_func = ::last_alien_can_retreat_override_func;
  level.dlc_alien_pain_anim_state_override_func = ::last_alien_pain_anim_state_override_func;
  level.dlc_alien_turn_in_place_anim_state_override_func = ::last_alien_turn_in_place_anim_state_override_func;
  level.dlc_alien_should_immediate_ragdoll_on_death_override_func = ::last_alien_should_immediate_ragdoll_on_death_override_func;
  level.dlc_get_current_player_volumes_override_func = maps\mp\mp_alien_last_progression::last_get_current_player_volumes_override_func;
  level.shell_shock_override = ::last_shellshock_override_func;

  if(maps\mp\alien\_utility::isplayingsolo())
    level.base_player_count_multiplier = 1;
  else
    level.base_player_count_multiplier = 0.49;

  level.additional_player_count_multiplier = 0.17;
  level.waypoint_dist_override = 2500;
  level.hintprecachefunc = ::last_hint_precache;
  maps\mp\mp_alien_last_precache::main();
  maps\createart\mp_alien_last_art::main();
  maps\mp\mp_alien_last_fx::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_mp_alien_last");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  init_weapon_stat_array();
  level.weapon_stats_override_name_func = ::last_weapon_stats_override_func;
  maps\mp\agents\alien\alien_ancestor\_alien_ancestor::init();
  maps\mp\agents\alien\_alien_mammoth::mammoth_level_init();
  maps\mp\agents\alien\_alien_gargoyle::gargoyle_level_init();
  maps\mp\agents\alien\_alien_bomber::bomber_level_init();
  register_encounters();

  if(!maps\mp\alien\_utility::is_chaos_mode()) {
    maps\mp\alien\_gamescore::set_drill_score_component_name("generator");
    maps\mp\alien\_gamescore_last::init_partial_hive_score_component_list_func();
    maps\mp\alien\_gamescore_last::init_last_eog_score_components(["generator", "street", "item_crafting", "cortex", "ancestor_bonus", "relics"]);
    maps\mp\alien\_gamescore_last::init_last_encounter_score_components(["street_personal", "street_team", "street_challenge", "generator", "generator_personal", "generator_team", "generator_challenge", "item_crafting", "ancestor_bonus", "cortex"]);
    maps\mp\alien\_pillage_intel::create_intel_spots();
    level thread maps\mp\mp_alien_last_final_battle::setup_final_battle();
    maps\mp\mp_alien_last_progression::init_fake_drill();
    level thread wait_spawn_intro_drill();
  }

  level thread maps\mp\alien\mp_alien_last_turret::set_up_remote_turrets();
  level thread last_start_vo();
  maps\mp\mp_alien_last_weapon::init();
  level thread setup_last_offhands();
  level.give_randombox_item_check = ::last_randombox_item_check;
  level thread maps\mp\mp_alien_last_traps::main();
  level.hypno_trap_func = maps\mp\alien\_crafting_traps::tryuseplaceable;
  level.tesla_trap_func = maps\mp\alien\_crafting_traps::tryuseplaceable;
  level.custom_cangive_weapon_func = ::last_cangive_weapon_handler_func;
  level.custom_give_weapon_func = ::last_give_weapon_handler_func;
  setup_incompatible_list();
  level.skip_radius_damage_on_puddles = 1;
  level.drill_icon_draw_dist_override = 10000;
  level thread maps\mp\alien\_lasedstrike_alien::init();
  level thread collectible_easter_egg_setup();
  level thread carwash_intel_easter_egg();
  level.drill_repair_hint = &"MP_ALIEN_LAST_GENERATOR_REPAIR_HINT";
  level.drill_repair_hint_urgent = &"MP_ALIEN_LAST_GENERATOR_REPAIR_URGENT";
  level.drill_repair = &"MP_ALIEN_LAST_REPAIRGENERATOR";
  level thread fix_map_holes();
}

fix_map_holes() {
  level endon("game_ended");
  level waittill("spawn_nondeterministic_entities");
  var_0 = getent("player256x256x8", "targetname");
  var_0 moveto((2320, -201, 240), 0.05);
  var_0.angles = (270, 270, 0);
  var_1 = spawn("script_model", (1224, 1600.5, 64));
  var_1.angles = (0, 270, 90);
  var_1 clonebrushmodeltoscriptmodel(getent("player256x256x8", "targetname"));
  var_2 = spawn("script_model", (-528, 1598.5, 64));
  var_2.angles = (0, 90, 90);
  var_2 clonebrushmodeltoscriptmodel(getent("player256x256x8", "targetname"));
}

collectible_easter_egg_setup() {
  wait 1;
  level._effect["arcade_death"] = level._effect["eyeball_death"];
  level.collectible_spots_found = 0;
  level.collectible_spots = 0;
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_0[0] = add_collectible_spot((-356, -1109, 81), (90, 240, 180));
  var_0[1] = add_collectible_spot((47, -667, 81), (90, 255, 0));
  var_0[2] = add_collectible_spot((1281, -244.5, 238), (90, 280, 180));
  var_1[0] = add_collectible_spot((2936.5, 2725, 47.5), (90, 12.1, 0));
  var_1[1] = add_collectible_spot((2645, 2124, 40.75), (90, 162.1, 5));
  var_1[2] = add_collectible_spot((3155.5, 2564.5, 203.5), (90, 222.1, 180));
  var_2[0] = add_collectible_spot((-2256, 2110.5, 230.5), (90, 282.1, 180));
  var_2[1] = add_collectible_spot((-2328, 2492.5, 208.5), (90, 282.1, 180));
  var_2[2] = add_collectible_spot((-902, 2100.5, 246.5), (90, 297.1, 0));
  var_3 = common_scripts\utility::random(var_0);
  var_4 = common_scripts\utility::random(var_1);
  var_5 = common_scripts\utility::random(var_2);
  level thread init_collectible_spot(var_3);
  level thread init_collectible_spot(var_4);
  level thread init_collectible_spot(var_5);
}

add_collectible_spot(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.angles = var_1;
  return var_2;
}

init_collectible_spot(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1.origin = var_0.origin;
  var_1 setModel("tag_origin");
  wait 1;
  var_1 makeusable();
  var_1 sethintstring("");
  var_1.used = 0;
  var_1 thread wait_for_player_use();

  while(!var_1.used) {
    playFX(level._effect["collectible_eye"], var_1.origin, anglesToForward(var_1.angles), anglestoup(var_1.angles));
    wait 1;
  }

  var_1 delete();
  level.collectible_spots++;

  if(level.collectible_spots >= 3) {
    level.easter_egg_lodge_sign_active = 1;
    activate_easter_egg();
  }
}

wait_for_player_use() {
  self waittill("trigger", var_0);
  self.used = 1;
  var_0 playlocalsound("last_easter_collect");
}

activate_easter_egg() {
  wait 1;
  maps\mp\_utility::playsoundinspace("last_easter_unlock", (0, 0, 0));
  earthquake(0.35, 4, (0, 0, 0), 10000);
  wait 1;

  foreach(var_1 in level.players) {
    var_1 thread[[level.custom_juicebox_logic]](180, 4, 1);
    var_1 thread maps\mp\alien\_outline_proto::set_alien_outline();
    playFXOnTag(level.dig_fx["shrine"]["player"], var_1, "tag_origin");
    var_1.shrine_effect_ent = spawnfxforclient(level.dig_fx["shrine"]["screen"], var_1 getEye(), var_1);
    triggerfx(var_1.shrine_effect_ent);
    var_1.shrine_effect_ent setfxkilldefondelete();
    var_1 thread killfxonplayerdeath(var_1.shrine_effect_ent, "death", "disconnect");
  }

  level thread last_easter_egg_off();
}

killfxonplayerdeath(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(isDefined(var_1))
    level endon(var_1);

  if(isDefined(var_2))
    level endon(var_2);

  if(isDefined(var_3))
    level endon(var_3);

  common_scripts\utility::waittill_any("killed_player", "disconnect");

  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_5 in var_0)
      var_5 delete();
    } else
      var_0 delete();
  }
}

last_easter_egg_off() {
  level endon("game_ended");
  wait 180;
  level.easter_egg_lodge_sign_active = 0;

  foreach(var_1 in level.players) {
    var_1 thread maps\mp\alien\_alien_class_skills_main::remove_the_outline();
    stopFXOnTag(level.dig_fx["shrine"]["player"], var_1, "tag_origin");

    if(isDefined(var_1.shrine_effect_ent))
      var_1.shrine_effect_ent delete();
  }
}

carwash_intel_easter_egg() {
  var_0 = common_scripts\utility::getstructarray("ee_n", "targetname");
  var_1 = common_scripts\utility::getstructarray("ee_e", "targetname");
  var_2 = common_scripts\utility::getstructarray("ee_v", "targetname");
  var_3 = common_scripts\utility::getstructarray("ee_r", "targetname");
  var_4 = common_scripts\utility::getstructarray("ee_s", "targetname");
  var_5 = common_scripts\utility::getstructarray("ee_o", "targetname");
  var_6 = common_scripts\utility::getstructarray("ee_f", "targetname");
  var_7 = common_scripts\utility::getstructarray("ee_t", "targetname");
  level.easter_egg_trigs = getEntArray("ee_trig", "targetname");
  var_8 = [var_0, var_1, var_2, var_1, var_3, var_4, var_5, var_6, var_7];
  var_9 = ["^1N", "^2E", "^3V", "^4E", "^5R", "^6S", "^7O", "^8F", "^9T"];
  var_10 = undefined;

  for(;;) {
    for(var_11 = 0; var_11 < var_8.size; var_11++) {
      level thread wait_for_letter_shot(var_8[var_11]);

      if(var_11 > 0) {
        var_12 = level common_scripts\utility::waittill_notify_or_timeout_return("letter_shot", (var_10 + 30000 - gettime()) / 1000);

        if(isDefined(var_12)) {
          level notify("stop_waiting");
          break;
        }
      } else if(var_11 == 0) {
        level waittill("letter_shot");
        var_10 = gettime();
      }

      if(gettime() < var_10 + 30000) {
        var_13 = "";

        for(var_4 = 0; var_4 < var_11; var_4++)
          var_13 = var_13 + var_9[var_4];

        var_13 = var_13 + var_9[var_11];
        iprintlnbold(var_13);

        if(var_11 == var_8.size - 1) {
          level thread unlock_last_secret_intel();
          return;
        }
      } else
        break;
    }
  }
}

unlock_last_secret_intel() {
  wait 1;
  maps\mp\_utility::playsoundinspace("last_easter_unlock", (0, 0, 0));
  earthquake(0.35, 4, (0, 0, 0), 10000);
  wait 1;

  foreach(var_1 in level.players)
  thread maps\mp\alien\_pillage_intel::give_player_easter_egg_intel(var_1);
}

wait_for_letter_shot(var_0) {
  level endon("stop_waiting");

  foreach(var_2 in level.easter_egg_trigs)
  var_2 common_scripts\utility::trigger_off();

  foreach(var_6, var_5 in var_0) {
    level.easter_egg_trigs[var_6] common_scripts\utility::trigger_on();
    level.easter_egg_trigs[var_6].origin = var_5.origin;
    level.easter_egg_trigs[var_6] thread wait_for_letter_damage();
  }

  level waittill("letter_shot");
}

wait_for_letter_damage() {
  level endon("letter_shot");
  level endon("stop_waiting");
  self waittill("trigger");
  playFX(level._effect["alien_gib"], self.origin);
  self playSound("last_easter_collect");
  level notify("letter_shot");
}

wait_spawn_intro_drill() {
  wait 2.0;
  level notify("spawn_intro_drill");
  level notify("enable_encounters");
  wait 3.0;
  common_scripts\utility::flag_set("intro_sequence_complete");
}

register_encounters() {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    maps\mp\gametypes\aliens::register_encounter(::chaos_init, undefined, undefined, undefined, ::chaos_init, maps\mp\alien\_globallogic::blank);
    maps\mp\gametypes\aliens::register_encounter(maps\mp\alien\_chaos::chaos, undefined, undefined, undefined, maps\mp\alien\_chaos::chaos, maps\mp\alien\_globallogic::blank);
    return;
  }

  level.dlc_run_encounters_override = maps\mp\mp_alien_last_progression::run_non_linear_encounters;
  maps\mp\mp_alien_last_progression::nonlinear_progression_init();
  maps\mp\mp_alien_last_progression::register_nonlinear_outpost("main_base", 1);
  maps\mp\mp_alien_last_progression::register_nonlinear_outpost("gas_station");
  maps\mp\mp_alien_last_progression::register_nonlinear_outpost("parking");
  maps\mp\mp_alien_last_progression::register_nonlinear_outpost("rooftop");
  maps\mp\mp_alien_last_progression::register_nonlinear_conduit("gas_station", "conduit_gas_station_1", 6, 12, 18, 1, 0, ::gas_station_part_1, 0);
  maps\mp\mp_alien_last_progression::register_nonlinear_conduit("gas_station", "conduit_gas_station_2", 7, 13, 19, 1, 0, ::gas_station_blocker, 1);
  maps\mp\mp_alien_last_progression::register_nonlinear_conduit("parking", "conduit_parking_1", 8, 14, 20, 1, 0, ::parking_part_1, 0);
  maps\mp\mp_alien_last_progression::register_nonlinear_conduit("parking", "conduit_parking_2", 9, 15, 21, 1, 0, ::parking_blocker, 1);
  maps\mp\mp_alien_last_progression::register_nonlinear_conduit("rooftop", "conduit_rooftop_1", 10, 16, 22, 1, 0, ::rooftop_part_1, 0);
  maps\mp\mp_alien_last_progression::register_nonlinear_conduit("rooftop", "conduit_rooftop_2", 11, 17, 23, 1, 0, ::rooftop_blocker, 1);
  maps\mp\mp_alien_last_progression::register_nonlinear_transition("main_base", "transition_left", 1, 0, maps\mp\mp_alien_last_progression::opener_slide, -110, 110, "gas_station");
  maps\mp\mp_alien_last_progression::register_nonlinear_transition("main_base", "transition_middle", 1, 0, maps\mp\mp_alien_last_progression::opener_slide_x, -275, 275, "parking");
  maps\mp\mp_alien_last_progression::register_nonlinear_transition("main_base", "transition_right", 1, 0, maps\mp\mp_alien_last_progression::opener_slide, -110, 110, "rooftop");
  maps\mp\mp_alien_last_progression::register_nonlinear_transition("gas_station", "transition_left", 1, 0, maps\mp\mp_alien_last_progression::opener_pivot, 60, -60, "main_base");
  maps\mp\mp_alien_last_progression::register_nonlinear_transition("gas_station", "transition_upper_left", 1, 0, maps\mp\mp_alien_last_progression::opener_pivot, 60, -60, "parking");
  maps\mp\mp_alien_last_progression::register_nonlinear_transition("parking", "transition_upper_left", 1, 0, maps\mp\mp_alien_last_progression::opener_doors, -88, 88, "gas_station");
  maps\mp\mp_alien_last_progression::register_nonlinear_transition("parking", "transition_middle", 1, 0, maps\mp\mp_alien_last_progression::opener_slide, 128, -128, "main_base");
  maps\mp\mp_alien_last_progression::register_nonlinear_transition("parking", "transition_upper_right", 1, 0, maps\mp\mp_alien_last_progression::opener_doors, -100, 100, "rooftop");
  maps\mp\mp_alien_last_progression::register_nonlinear_transition("rooftop", "transition_upper_right", 1, 0, maps\mp\mp_alien_last_progression::opener_pivot, 80, -80, "parking");
  maps\mp\mp_alien_last_progression::register_nonlinear_transition("rooftop", "transition_right", 1, 0, maps\mp\mp_alien_last_progression::opener_doors, 75, -75, "main_base");
}

blank_script() {}

last_melee_override_func(var_0) {
  switch (self.melee_type) {
    case "burrow":
      maps\mp\agents\alien\_alien_mammoth::burrow(var_0);
      break;
    case "stun":
      maps\mp\agents\alien\_alien_gargoyle::stun(var_0);
      break;
    case "wing_swipe":
      maps\mp\agents\alien\_alien_gargoyle::wing_swipe(var_0);
      break;
    case "hover_attack":
      maps\mp\agents\alien\_alien_gargoyle::hover(var_0);
      break;
    case "divebomb":
      maps\mp\agents\alien\_alien_bomber::divebomb(var_0);
      break;
    case "strafe_run":
      maps\mp\agents\alien\_alien_gargoyle::strafe_run(var_0);
      break;
    case "kamikaze":
      maps\mp\agents\alien\_alien_bomber::kamikaze(var_0);
      break;
    case "fissure_spawn":
      maps\mp\agents\alien\_alien_mammoth::fissure_spawn(var_0);
      break;
    case "mammoth_angered":
      maps\mp\agents\alien\_alien_mammoth::mammoth_angered(var_0);
      break;
    case "takeoff":
      maps\mp\agents\alien\_alien_gargoyle::takeoff(var_0);
      break;
    case "land":
      maps\mp\agents\alien\_alien_gargoyle::land(var_0);
      break;
    case "air_dodge":
      maps\mp\agents\alien\_alien_gargoyle::air_dodge(var_0);
      break;
    case "fly":
      maps\mp\agents\alien\_alien_gargoyle::fly(var_0);
      break;
    case "fly_intro":
      maps\mp\agents\alien\_alien_gargoyle::fly_intro(var_0);
      break;
  }
}

last_alien_idle_anim_state_override_func(var_0) {
  if(!isDefined(self.alien_type))
    return undefined;

  switch (self.alien_type) {
    case "gargoyle":
      return maps\mp\agents\alien\_alien_gargoyle::gargoyle_idle_state(var_0);
  }

  return undefined;
}

last_can_do_pain_override_func(var_0) {
  switch (maps\mp\alien\_utility::get_alien_type()) {
    case "gargoyle":
      return maps\mp\agents\alien\_alien_gargoyle::can_do_pain(var_0);
    default:
      return 1;
  }
}

last_alien_pain_anim_state_override_func(var_0) {
  switch (maps\mp\alien\_utility::get_alien_type()) {
    case "gargoyle":
      return maps\mp\agents\alien\_alien_gargoyle::get_pain_anim_state(var_0);
    default:
      return undefined;
  }
}

last_alien_turn_in_place_anim_state_override_func() {
  switch (maps\mp\alien\_utility::get_alien_type()) {
    case "gargoyle":
      return maps\mp\agents\alien\_alien_gargoyle::get_turn_in_place_anim_state();
    default:
      return undefined;
  }
}

last_alien_should_immediate_ragdoll_on_death_override_func(var_0) {
  switch (maps\mp\alien\_utility::get_alien_type()) {
    case "gargoyle":
      return maps\mp\agents\alien\_alien_gargoyle::should_immediate_ragdoll_on_death();
    default:
      return undefined;
  }
}

last_alien_can_retreat_override_func(var_0) {
  switch (maps\mp\alien\_utility::get_alien_type()) {
    case "gargoyle":
      return maps\mp\agents\alien\_alien_gargoyle::can_retreat(var_0);
    default:
      return 1;
  }
}

last_shellshock_override_func(var_0) {
  if(maps\mp\alien\_utility::is_true(self.is_grabbed)) {
    return;
  }
  self shellshock("alien_spitter_gas_cloud", var_0);
}

last_alien_type_node_match_override_func(var_0) {
  switch (var_0) {
    case "elite":
    case "mammoth":
    case "bomber":
      return 0;
    case "gargoyle":
      if(getdvarint("scr_gargoyle_disable_fly_intro") != 1)
        return 0;

      break;
    default:
      return 1;
  }
}

last_alien_jump_override(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy != "flyable")
    var_4 = var_1.script_noteworthy;

  maps\mp\agents\alien\_alien_jump::jump(var_0.origin, var_0.angles, var_1.origin, var_1.angles, var_3, undefined, var_4);
}

last_alien_init_override_func() {
  switch (maps\mp\alien\_utility::get_alien_type()) {
    case "mammoth":
      maps\mp\agents\alien\_alien_mammoth::mammoth_init();
      break;
    case "gargoyle":
      maps\mp\agents\alien\_alien_gargoyle::gargoyle_init();
      break;
    case "bomber":
      maps\mp\agents\alien\_alien_bomber::bomber_init();
      break;
  }
}

last_alien_attack_override_func(var_0, var_1) {
  switch (var_1) {
    case "burrow":
      maps\mp\agents\alien\_alien_mammoth::burrow_attack(var_0);
      break;
    case "stun":
      maps\mp\agents\alien\_alien_gargoyle::stun_attack(var_0);
      break;
    case "wing_swipe":
      maps\mp\agents\alien\_alien_gargoyle::wing_swipe_attack(var_0);
      break;
    case "hover_attack":
      maps\mp\agents\alien\_alien_gargoyle::hover_attack(var_0);
      break;
    case "strafe_run":
      maps\mp\agents\alien\_alien_gargoyle::strafe_run_attack(var_0);
      break;
    case "fissure_spawn":
      maps\mp\agents\alien\_alien_mammoth::fissure_spawn_attack(var_0);
      break;
    case "mammoth_angered":
      maps\mp\agents\alien\_alien_mammoth::mammoth_angered_attack(var_0);
      break;
    case "takeoff":
      maps\mp\agents\alien\_alien_gargoyle::takeoff_attack(var_0);
      break;
    case "land":
      maps\mp\agents\alien\_alien_gargoyle::landing_attack(var_0);
      break;
    case "fly":
      maps\mp\agents\alien\_alien_gargoyle::fly_attack(var_0);
      break;
    case "fly_intro":
      maps\mp\agents\alien\_alien_gargoyle::fly_intro_attack(var_0);
      break;
    default:
      return 0;
  }

  return 1;
}

last_locker_weapon_pickup_string_func(var_0) {
  var_0 = "" + var_0;

  switch (var_0) {
    case "weapon_vks":
      return &"ALIEN_PICKUPS_DESCENT_LOCKER_VKS";
    case "weapon_usr":
      return &"ALIEN_PICKUPS_DESCENT_LOCKER_USR";
    case "weapon_remington_r5rgp":
      return &"ALIEN_PICKUPS_DESCENT_LOCKER_R5RGP";
    case "weapon_rm_22":
      return &"ALIEN_PICKUPS_DESCENT_LOCKER_MAVERICK";
    case "weapon_evopro":
      return &"ALIEN_PICKUPS_DESCENT_LOCKER_RIPPER";
    case "weapon_k7":
      return &"ALIEN_PICKUPS_DESCENT_LOCKER_K7";
    case "weapon_uts_15":
      return &"ALIEN_PICKUPS_DESCENT_LOCKER_UTS";
    case "weapon_maul":
      return &"ALIEN_PICKUPS_DESCENT_LOCKER_MAUL";
    case "weapon_mk14_ebr_iw6":
      return &"ALIEN_PICKUPS_DESCENT_LOCKER_MK14";
    case "weapon_imbel_ia2":
      return &"ALIEN_PICKUPS_DESCENT_LOCKER_IMBEL";
    case "weapon_kac_chainsaw":
      return &"ALIEN_PICKUPS_DESCENT_LOCKER_KAC";
    case "weapon_ameli":
      return &"ALIEN_PICKUPS_DESCENT_LOCKER_AMELI";
  }
}

mp_alien_last_pillage_init() {
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
  level.pillageinfo.easy_attachment = 35;
  level.pillageinfo.easy_money = 15;
  level.pillageinfo.easy_clip = 20;
  level.pillageinfo.easy_specialammo = 20;
  level.pillageinfo.easy_locker_key = 5;
  level.pillageinfo.easy_intel = 5;
  level.pillageinfo.medium_attachment = 35;
  level.pillageinfo.medium_explosive = 15;
  level.pillageinfo.medium_money = 10;
  level.pillageinfo.medium_clip = 10;
  level.pillageinfo.medium_specialammo = 10;
  level.pillageinfo.medium_leash = 5;
  level.pillageinfo.medium_soflam = 5;
  level.pillageinfo.medium_locker_key = 5;
  level.pillageinfo.medium_intel = 5;
  level.pillageinfo.hard_attachment = 35;
  level.pillageinfo.hard_explosive = 14;
  level.pillageinfo.hard_leash = 10;
  level.pillageinfo.hard_maxammo = 10;
  level.pillageinfo.hard_specialammo = 11;
  level.pillageinfo.hard_money = 5;
  level.pillageinfo.hard_soflam = 5;
  level.pillageinfo.hard_trophy = 5;
  level.pillageinfo.hard_locker_key = 5;
  level.pillageinfo.hard_intel = 5;
  level.crafting_item_table = "mp/alien/crafting_items.csv";
  level.crafting_table_item_index = 0;
  level.crafting_table_item_ref = 1;
  level.crafting_table_item_name = 2;
  level.crafting_table_item_icon = 3;
  level.max_crafting_items = 3;
  level.crafting_model = "weapon_baseweapon_clip";
  level.get_hintstring_for_pillaged_item_func = ::last_get_hintstring_for_pillaged_item_func;
  level.get_hintstring_for_item_pickup_func = ::last_get_hintstring_for_item_pickup_func;
  level.custom_build_pillageitem_array_func = ::last_build_pillageitem_array_func;
}

last_hint_precache() {
  var_0 = [];
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_AMELI"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_AMELI";
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_IMBEL"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_IMBEL";
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_K7"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_K7";
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_KAC"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_KAC";
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_KASTET"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_KASTET";
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_MAUL"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_MAUL";
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_MAVERICK"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_MAVERICK";
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_MK14"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_MK14";
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_R5RGP"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_R5RGP";
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_RIPPER"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_RIPPER";
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_USR"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_USR";
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_UTS"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_UTS";
  var_0["ALIEN_PICKUPS_DESCENT_PICKUP_VKS"] = &"ALIEN_PICKUPS_DESCENT_PICKUP_VKS";
  return var_0;
}

last_enter_area_func(var_0) {
  if(!maps\mp\alien\_utility::is_chaos_mode())
    maps\mp\alien\_container_spawn::activate_container_spawners_in_area(var_0);
}

last_leave_area_func(var_0) {
  if(!maps\mp\alien\_utility::is_chaos_mode())
    maps\mp\alien\_container_spawn::deactivate_container_spawners_in_area(var_0);
}

mp_alien_last_onspawnplayer_func() {
  thread maps\mp\alien\_music_and_dialog_dlc::dlc_vo_init_on_player_spawn();
  thread maps\mp\alien\_pillage_intel::intel_on_player_connect();

  if(!isDefined(level.setskillsflag)) {
    level.setskillsflag = 1;
    common_scripts\utility::flag_set("give_player_abilities");
  }

  thread maps\mp\alien\_alien_class_skills_main::assign_skills();
  thread maps\mp\alien\_achievement::eggallfoundforpack(3);
  thread maps\mp\mp_alien_last_weapon::special_gun_watcher();
  thread maps\mp\mp_alien_last_weapon::last_grenade_watcher();
  thread last_intro_music_play();
}

last_intro_music_play() {
  wait 0.01;

  if(common_scripts\utility::flag_exist("intro_sequence_complete") && !common_scripts\utility::flag("intro_sequence_complete")) {
    if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
      self playlocalsound("mus_alien_dlc4_last_intro");
  }
}

last_get_hintstring_for_pillaged_item_func(var_0) {
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

last_get_hintstring_for_item_pickup_func(var_0) {
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
    case "bbiolum":
      return &"ALIEN_CRAFTING_PICKUP_BIOLUM";
    case "biolum":
      return &"ALIEN_CRAFTING_PICKUP_BIOLUM";
    case "locker_key":
      return &"ALIEN_PILLAGE_LOCKER_PICKUP_LOCKER_KEY";
    case "locker_weapon":
      return &"ALIEN_PILLAGE_LOCKER_PICKUP_LOCKER_WEAPON";
    case "venomx":
      return &"ALIEN_CRAFTING_PICKUP_DISARMED_VENOM";
    case "bbluebiolum":
    case "bluebiolum":
      return &"ALIEN_CRAFTING_PICKUP_BLUEBIOLUM";
    case "oorangebiolum":
    case "orangebiolum":
      return &"ALIEN_CRAFTING_PICKUP_ORANGEBIOLUM";
    case "amethystbiolum":
      return &"ALIEN_CRAFTING_PICKUP_PURPLEBIOLUM";
    case "iw6_aliendlc22_mp":
      return &"ALIEN_CRAFTING_PICKUP_PIPEBOMB";
    case "stickyflare":
    case "viewmodel_flare":
    case "iw6_aliendlc21_mp":
    case "flare":
      return &"ALIEN_CRAFTING_PICKUP_STICKYFLARE";
    case "detonator":
      return &"ALIEN_CRAFTING_PICKUP_DETONATOR";
    case "casing":
      return &"ALIEN_CRAFTING_PICKUP_CASING";
    case "cortexgel":
      return &"ALIEN_CRAFTING_PICKUP_CORTEXGEL";
    case "cortexhousing":
      return &"ALIEN_CRAFTING_PICKUP_CORTEXHOUSING";
    case "substrate":
      return &"ALIEN_CRAFTING_PICKUP_SUBSTRATE";
    case "iw6_aliendlc31_mp":
      return &"ALIEN_CRAFTING_PICKUP_VENOMXGRENADE";
    case "iw6_aliendlc32_mp":
      return &"ALIEN_CRAFTING_PICKUP_VENOMLXGRENADE";
    case "iw6_aliendlc33_mp":
      return &"ALIEN_CRAFTING_PICKUP_VENOMFXGRENADE";
    case "iw6_aliendlc43_mp":
      return &"ALIEN_CRAFTING_PICKUP_CORTEXGRENADE";
  }

  if(isDefined(level.level_locker_weapon_pickup_string_func))
    return [[level.level_locker_weapon_pickup_string_func]](var_0);
}

last_build_pillageitem_array_func(var_0) {
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

init_weapon_stat_array() {
  level.weaponstats_weaponlist = [];
  level.weaponstats_weaponlist["iw6_arkalienr5rgp_mp"] = "iw6_alienDLC33_mp";
  level.weaponstats_weaponlist["iw6_arkaliendlc15_mp"] = "iw6_alienDLC15_mp";
  level.weaponstats_weaponlist["iw6_arkalienk7_mp"] = "iw6_alienDLC31_mp";
  level.weaponstats_weaponlist["iw6_arkaliendlc23_mp"] = "iw6_alienDLC23_mp";
  level.weaponstats_weaponlist["iw6_arkalienameli_mp"] = "iw6_alienDLC32_mp";
  level.weaponstats_weaponlist["iw6_arkalienkac_mp"] = "iw6_alienkac_mp";
  level.weaponstats_weaponlist["iw6_arkalienvks_mp"] = "iw6_alienvks_mp";
  level.weaponstats_weaponlist["iw6_arkalienusr_mp"] = "iw6_alienDLC34_mp";
  level.weaponstats_weaponlist["iw6_arkalienimbel_mp"] = "iw6_alienimbel_mp";
  level.weaponstats_weaponlist["iw6_arkalienmk14_mp"] = "iw6_alienDLC31_mp";
  level.weaponstats_weaponlist["iw6_arkalienmaul_mp"] = "iw6_alienmaul_mp";
  level.weaponstats_weaponlist["iw6_arkalienuts15_mp"] = "iw6_alienDLC24_mp";
}

last_weapon_stats_override_func(var_0) {
  if(isDefined(level.weaponstats_weaponlist[var_0]))
    return level.weaponstats_weaponlist[var_0];

  return var_0;
}

achievement_you_wish_func() {
  maps\mp\alien\_achievement_dlc4::award_you_wish();
}

gas_station_part_1(var_0) {
  level waittill("drill_detonated");
  level.gas_station_conduits_completed++;
}

parking_part_1(var_0) {
  level waittill("drill_detonated");
  level.parking_conduits_completed++;
}

rooftop_part_1(var_0) {
  level waittill("drill_detonated");
  level.rooftop_conduits_completed++;
}

gas_station_blocker(var_0) {
  maps\mp\mp_alien_last_encounters::do_gas_station_blocker();
}

parking_blocker(var_0) {
  maps\mp\mp_alien_last_encounters::do_garage_blocker();
}

rooftop_blocker(var_0) {
  maps\mp\mp_alien_last_encounters::do_rooftops_blocker();
}

last_locker_ark_check_func(var_0, var_1) {
  if(maps\mp\alien\_utility::weapon_has_alien_attachment(var_0)) {
    var_2 = ["alienmuzzlebrake"];
    var_1 = maps\mp\alien\_utility::ark_attachment_transfer_to_locker_weapon(var_1, var_2, 1);
  }

  return "weapon_" + var_1;
}

dlc_4_offset_locker_trigger_model() {
  if(isDefined(self.locker_origin))
    self.pillage_trigger.origin = self.locker_origin;

  if(isDefined(self.locker_angles))
    self.pillage_trigger.angles = self.locker_angles;

  var_0 = (0, 0, 20);
  var_1 = (0, 0, 13);
  var_2 = (0, 0, 90);
  var_3 = (0, 0, 6);
  var_4 = (0, 0, 0);
  var_5 = getgroundposition(self.pillage_trigger.origin + var_0, 2);

  switch (self.pillage_trigger.model) {
    case "weapon_rm_22":
      self.pillage_trigger hidepart("tag_barrel_sniper", "weapon_rm_22");
    default:
      var_3 = var_1;
      var_4 = var_2;
      break;
  }

  var_3 = var_1;
  var_4 = var_2;
  var_6 = self.pillage_trigger.origin;
  var_7 = self.pillage_trigger.angles;
  var_8 = self.pillage_trigger.origin;
  var_9 = (0, 0, 0);
  var_10 = self.pillage_trigger.origin + var_3;
  var_11 = var_4;
  var_12 = transformmove(var_6, var_7, var_8, var_9, var_10, var_11);
  var_13 = var_12["origin"] - var_5;
  var_4 = var_12["angles"];
  self.pillage_trigger.origin = var_5 + var_13;
  self.pillage_trigger.angles = var_4;
}

last_specific_vo_callouts(var_0) {
  var_0["last_vo"] = ::playlastvo;
  var_0["conduit_attack"] = ::playconduitattackvo;
  var_0["cortex_attack"] = ::playcortexattackvo;
  var_0["ancestor_close"] = ::playancestorclosevo;
  var_0["ancestor_shield_up"] = ::playancestorshieldupvo;
  var_0["ancestor_shield_down"] = ::playancestorshielddownvo;
  var_0["transition_start"] = ::playtransitionstartvo;
  var_0["nx_weapon_schematic"] = ::playnxweaponvo;
  var_0["nx_grenade_schematic"] = ::playnxgrenadevo;
  return var_0;
}

playlastvo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 10;
  var_2 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_2.size < 1) {
    return;
  }
  var_3 = var_2[0];

  if(!soundexists(var_3.vo_prefix + var_0)) {
    iprintln("Last vo: " + var_3.vo_prefix + var_0);
    return;
  }

  var_2 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_2.size < 1) {
    return;
  }
  var_3 = var_2[0];
  var_4 = var_3.vo_prefix + var_0;

  if(var_0 == "conduit_nag" || var_0 == "conduit_nag_aliens")
    var_1 = 3;

  if(var_0 == "conduit_halfway" && isDefined(level.current_encounter_info) && level.current_encounter_info.type == "transition") {
    return;
  }
  var_3 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_4, undefined, var_1);
}

playconduitattackvo(var_0) {
  if(!isDefined(var_0))
    var_0 = "conduit_attack";

  var_1 = 30000;
  var_2 = gettime();

  if(!isDefined(level.next_conduit_damage_vo_time) || level.next_conduit_damage_vo_time < var_2) {
    level.next_conduit_damage_vo_time = var_2 + randomintrange(var_1, var_1 + 5000);
    var_3 = maps\mp\alien\_utility::get_array_of_valid_players();
    var_4 = common_scripts\utility::random(var_3);

    if(!isDefined(var_4)) {
      return;
    }
    var_5 = var_4.vo_prefix + var_0;
    var_4 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_5, "high", 5);
  }
}

playcortexattackvo() {
  var_0 = "cortex_attack";
  var_1 = 30000;
  var_2 = gettime();

  if(!isDefined(level.next_conduit_damage_vo_time) || level.next_conduit_damage_vo_time < var_2) {
    level.next_conduit_damage_vo_time = var_2 + randomintrange(var_1, var_1 + 5000);
    var_3 = maps\mp\alien\_utility::get_array_of_valid_players();
    var_4 = common_scripts\utility::random(var_3);

    if(!isDefined(var_4)) {
      return;
    }
    var_5 = var_4.vo_prefix + var_0;
    var_4 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_5, "high", 5);
  }
}

playtransitionstartvo() {
  if(isDefined(level.first_priority_vo)) {
    return;
  }
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  if(maps\mp\alien\_utility::is_true(level.intro_v1)) {
    var_0 = ["last_gdf_firstpriority"];
    play_last_vignette_vo(var_0);
  }

  level.first_priority_vo = 1;
}

playnxweaponvo(var_0) {
  level endon("game_ended");

  if(isDefined(var_0.first_time_nx_weapon_vo)) {
    return;
  }
  if(!isDefined(var_0.first_time_nx_weapon_vo)) {
    while(vo_system_is_paused())
      wait 0.1;

    maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);

    while(maps\mp\alien\_music_and_dialog_dlc::is_vo_system_playing())
      wait 0.1;

    wait 0.25;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_0.first_time_nx_weapon_vo = 1;
    var_2 = "last_gdf_psicannon";
    var_1 playsoundtoplayer(var_2, var_0);
    wait(lookupsoundlength(var_2) / 1000);
    maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
    var_1 delete();
  }
}

playnxgrenadevo(var_0) {
  level endon("game_ended");

  if(isDefined(var_0.first_time_nx_grenade_vo)) {
    return;
  }
  if(!isDefined(var_0.first_time_nx_grenade_vo)) {
    while(vo_system_is_paused())
      wait 0.1;

    maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);

    while(maps\mp\alien\_music_and_dialog_dlc::is_vo_system_playing())
      wait 0.1;

    wait 0.25;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_0.first_time_nx_grenade_vo = 1;
    var_2 = "last_gdf_disruptergrenades";
    var_1 playsoundtoplayer(var_2, var_0);
    wait(lookupsoundlength(var_2) / 1000);
    maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
    var_1 delete();
  }
}

playancestorclosevo() {
  var_0 = 30000;
  var_1 = gettime();

  if(!isDefined(level.ancestor_close_vo_time) || level.ancestor_close_vo_time < var_1) {
    level.ancestor_close_vo_time = var_1 + randomintrange(var_0, var_0 + 5000);
    var_2 = maps\mp\alien\_utility::get_array_of_valid_players();
    var_3 = common_scripts\utility::random(var_2);

    if(!isDefined(var_3)) {
      return;
    }
    var_4 = var_3.vo_prefix + "ancestor_close";
    var_3 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_4, undefined, 3);
  }
}

playancestorshieldupvo() {
  var_0 = 30000;
  var_1 = gettime();

  if(!isDefined(level.ancestor_shield_vo_time) || level.ancestor_shield_vo_time < var_1) {
    level.ancestor_shield_vo_time = var_1 + randomintrange(var_0, var_0 + 5000);
    var_2 = maps\mp\alien\_utility::get_array_of_valid_players();
    var_3 = common_scripts\utility::random(var_2);

    if(!isDefined(var_3)) {
      return;
    }
    var_4 = var_3.vo_prefix + "ancestor_shield_up";
    var_3 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_4, undefined, 2);
  }
}

playancestorshielddownvo() {
  var_0 = 30000;
  var_1 = gettime();

  if(!isDefined(level.ancestor_shield_down_vo_time) || level.ancestor_shield_down_vo_time < var_1) {
    level.ancestor_shield_down_vo_time = var_1 + randomintrange(var_0, var_0 + 5000);
    var_2 = maps\mp\alien\_utility::get_array_of_valid_players();
    var_3 = common_scripts\utility::random(var_2);

    if(!isDefined(var_3)) {
      return;
    }
    var_4 = var_3.vo_prefix + "ancestor_shield_down";
    var_3 maps\mp\alien\_music_and_dialog_dlc::play_vo_on_player(var_4, undefined, 1);
  }
}

play_last_vignette_player_vo(var_0) {
  if(self.sessionstate != "playing") {
    return;
  }
  if(!soundexists(var_0)) {
    wait 0.1;
    return;
  }

  foreach(var_2 in level.players) {
    if(var_2 issplitscreenplayer() && !var_2 issplitscreenplayerprimary()) {
      continue;
    }
    if(var_2 == self) {
      if(maps\mp\alien\_music_and_dialog::alias_2d_version_exists(var_2, var_0))
        var_2 playlocalsound(maps\mp\alien\_music_and_dialog::get_alias_2d_version(var_2, var_0));
      else
        var_2 playlocalsound(var_0);

      continue;
    }

    self playsoundtoplayer(var_0, var_2);
  }

  wait(lookupsoundlength(var_0) / 1000);
}

play_last_vignette_vo(var_0, var_1, var_2) {
  level endon("game_ended");

  while(vo_system_is_paused())
    wait 0.1;

  maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);

  while(maps\mp\alien\_music_and_dialog_dlc::is_vo_system_playing())
    wait 0.1;

  wait 0.25;
  play_vignette_vo_array(var_0, var_1);
  maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

play_vignette_vo_array(var_0, var_1) {
  level endon("game_ended");

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_1) && common_scripts\utility::flag(var_1)) {
      break;
    }

    if(!soundexists(var_3)) {
      iprintln("last story vo: " + var_3);
      continue;
    }

    var_4 = lookupsoundlength(var_3) / 1000;
    thread play_global_vo(var_3);
    wait(var_4);
  }
}

play_cross_vignette_vo(var_0) {
  level endon("game_ended");

  while(vo_system_is_paused())
    wait 0.1;

  maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);

  while(maps\mp\alien\_music_and_dialog_dlc::is_vo_system_playing())
    wait 0.1;

  wait 0.25;
  play_cross_vo(var_0);
  maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

play_cross_vo(var_0) {
  level endon("game_ended");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level.dr_cross)) {
    return;
  }
  if(!soundexists(var_0)) {
    iprintln("cross vo missing: " + var_0);
    return;
  }

  var_1 = lookupsoundlength(var_0) / 1000;
  level.dr_cross playSound(var_0);
  wait(var_1);
}

play_global_vo(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2 playSound(var_0);
      break;
    }
  }
}

vo_system_is_paused() {
  foreach(var_1 in level.players) {
    if(var_1 maps\mp\alien\_music_and_dialog::is_vo_system_paused())
      return 1;
  }

  return 0;
}

last_start_vo() {
  level endon("kill_start_vo");

  while(!isDefined(level.players))
    wait 0.1;

  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  level thread set_flag_when_players_leave_base();
  wait 5.0;

  if(randomint(2) > 0) {
    var_0 = ["last_gdf_restorepower"];
    play_last_vignette_vo(var_0);
    wait 0.5;
    var_0 = ["last_gdf_6powerconduits"];
    play_last_vignette_vo(var_0);
    wait 0.5;
    var_0 = ["last_gdf_cantpreplaunch"];
    play_last_vignette_vo(var_0);
    wait 0.5;
    var_0 = ["last_gdf_goodluck"];
    play_last_vignette_vo(var_0);
  } else {
    level.intro_v1 = 1;
    var_0 = ["last_gdf_nosign"];
    play_last_vignette_vo(var_0);
    wait 0.5;
    var_0 = ["last_gdf_sitesurrounded", "last_gdf_goodluck"];
    play_last_vignette_vo(var_0);
  }

  level thread last_start_nag_vo();
}

last_start_nag_vo() {
  level endon("kill_start_vo");
  var_0 = 30;
  var_1 = 20;
  wait(var_0);
  var_2 = [];

  for(var_3 = ["last_gdf_exitthebase", "last_gdf_getmoving"]; !common_scripts\utility::flag("players_left_starting_area"); var_1 = var_1 + 10) {
    var_4 = common_scripts\utility::random(var_3);
    var_2 = [var_4];
    play_last_vignette_vo(var_2);
    wait(var_1);
  }
}

last_nag_vo_until_flag(var_0, var_1) {
  var_2 = 30;
  var_3 = 20;
  wait(var_2);

  while(!common_scripts\utility::flag(var_1)) {
    play_last_vignette_vo(var_0);
    wait(var_3);
    var_3 = var_3 + 10;
  }
}

play_conduit_encounter_complete_vo() {
  level endon("drill_planted");
  level endon("stop_post_hive_vo");
  level notify("dlc_vo_notify", "last_vo", "encounter_cleared");
  wait 5;
  var_0 = 0;

  while(maps\mp\agents\_agent_utility::getactiveagentsoftype("alien").size > 0) {
    wait 1;
    var_0++;

    if(var_0 > 15) {
      break;
    }
  }

  thread maps\mp\mp_alien_last_encounters::encounter_end_conduit_number_vo();
}

play_transition_encounter_complete_vo() {
  level endon("drill_planted");
  level endon("stop_post_hive_vo");
  var_0 = 0;

  while(maps\mp\agents\_agent_utility::getactiveagentsoftype("alien").size > 0) {
    wait 1;
    var_0++;

    if(var_0 > 15) {
      break;
    }
  }

  if(var_0 <= 15)
    level notify("dlc_vo_notify", "last_vo", "area_cleared");

  wait 5;
  level thread play_conduit_nag_vo();
}

play_conduit_nag_vo() {
  level endon("drill_planted");
  level endon("stop_post_hive_vo");

  if(isDefined(level.num_conduit_completed) && level.num_conduit_completed > 5) {
    return;
  }
  var_0 = 30;
  var_1 = 20;
  wait(var_0);
  var_2 = [];
  var_3 = ["conduit_nag", "conduit_nag_aliens"];

  for(;;) {
    var_4 = common_scripts\utility::random(var_3);
    level notify("dlc_vo_notify", "last_vo", var_4);
    wait(var_1);
    var_1 = var_1 + 10;
  }
}

remove_conduit_vo_once_complete() {
  foreach(var_1 in level.players) {
    var_1 thread remove_conduit_vo_on_player("conduit_attacked");
    var_1 thread remove_conduit_vo_on_player("conduit_repaired");
    var_1 thread remove_conduit_vo_on_player("conduit_halfway");
    var_1 thread remove_conduit_vo_on_player("conduit_damaged");
  }
}

remove_conduit_vo_on_player(var_0) {
  foreach(var_3, var_2 in level.alien_vo_priority_level)
  maps\mp\alien\_music_and_dialog::remove_vo_data(var_0, var_2);
}

set_flag_when_players_leave_base() {
  if(!common_scripts\utility::flag_exist("players_left_starting_area"))
    common_scripts\utility::flag_init("players_left_starting_area");

  var_0 = getent("main_base", "targetname");

  while(!common_scripts\utility::flag("players_left_starting_area")) {
    foreach(var_2 in level.players) {
      if(!var_2 istouching(var_0))
        common_scripts\utility::flag_set("players_left_starting_area");
    }

    wait 0.25;
  }
}

last_should_play_next_hive_vo_func() {
  return 0;
}

dlc4_drill_damage_adjust_function(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 == "alien_ancestor_mp") {
    var_3 = 10;
    level.drill_last_health = level.drill_last_health - var_3;
  } else if(isDefined(var_0) && isDefined(var_1) && isDefined(var_1.alien_type) && var_1.alien_type != "ancestor") {
    var_0 = int(var_0 * level.drill_damage_scalar);
    level.drill_last_health = level.drill_last_health - var_0;
  }
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
      case "main_base":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_main_base_sp.csv";
        break;
      case "gas_station_outpost":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_gas_station_outpost_sp.csv";
        break;
      case "parking_outpost":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_parking_outpost_sp.csv";
        break;
      case "rooftop_outpost":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_rooftop_outpost_sp.csv";
        break;
      case "left_transition":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_left_transition_sp.csv";
        break;
      case "upper_left_transition":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_upper_left_transition_sp.csv";
        break;
      case "middle_transition":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_middle_transition_sp.csv";
        break;
      case "upper_right_transition":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_upper_right_transition_sp.csv";
        break;
      case "right_transition":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_right_transition_sp.csv";
        break;
    }
  } else {
    switch (maps\mp\alien\_utility::get_chaos_area()) {
      case "main_base":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_main_base_mp.csv";
        break;
      case "gas_station_outpost":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_gas_station_outpost_mp.csv";
        break;
      case "parking_outpost":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_parking_outpost_mp.csv";
        break;
      case "rooftop_outpost":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_rooftop_outpost_mp.csv";
        break;
      case "left_transition":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_left_transition_mp.csv";
        break;
      case "upper_left_transition":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_upper_left_transition_mp.csv";
        break;
      case "middle_transition":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_middle_transition_mp.csv";
        break;
      case "upper_right_transition":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_upper_right_transition_mp.csv";
        break;
      case "right_transition":
        level.alien_cycle_table = "mp/alien/chaos_spawn_last_right_transition_mp.csv";
        break;
    }
  }
}

set_hardcore_extinction_spawn_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_last_hardcore_sp.csv";
  else
    level.alien_cycle_table_hardcore = "mp/alien/cycle_spawn_last_hardcore_mp.csv";
}

set_regular_extinction_spawn_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.alien_cycle_table = "mp/alien/cycle_spawn_last_sp.csv";
  else
    level.alien_cycle_table = "mp/alien/cycle_spawn_last_mp.csv";
}

set_container_spawn_table() {
  if(maps\mp\alien\_utility::is_hardcore_mode())
    set_hardcore_container_spawn_table();
  else
    set_regular_container_spawn_table();
}

set_hardcore_container_spawn_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.container_spawn_table = "mp/alien/last_container_spawn_hardcore_sp.csv";
  else
    level.container_spawn_table = "mp/alien/last_container_spawn_hardcore.csv";
}

set_regular_container_spawn_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.container_spawn_table = "mp/alien/last_container_spawn_sp.csv";
  else
    level.container_spawn_table = "mp/alien/last_container_spawn.csv";
}

set_alien_definition_table() {
  if(maps\mp\alien\_utility::is_hardcore_mode())
    set_hardcore_alien_definition_table();
  else
    set_regular_alien_definition_table();
}

set_regular_alien_definition_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.default_alien_definition = "mp/alien/last_alien_definition_sp.csv";
  else
    level.default_alien_definition = "mp/alien/last_alien_definition.csv";
}

set_hardcore_alien_definition_table() {
  if(maps\mp\alien\_utility::isplayingsolo())
    level.default_alien_definition = "mp/alien/last_alien_definition_hardcore_sp.csv";
  else
    level.default_alien_definition = "mp/alien/last_alien_definition_hardcore.csv";
}

chaos_init() {
  maps\mp\alien\_chaos::init();
  register_egg_default_loc();
  level thread chaos_initial_entity_setup();
}

chaos_initial_entity_setup() {
  level endon("game_ended");
  level waittill("spawn_nondeterministic_entities");
  maps\mp\mp_alien_last_final_battle::initial_entity_setup();
}

register_egg_default_loc() {
  switch (maps\mp\alien\_utility::get_chaos_area()) {
    case "main_base":
      maps\mp\alien\_chaos::set_egg_default_loc((-116, 2240, -1264));
      break;
    case "gas_station_outpost":
      maps\mp\alien\_chaos::set_egg_default_loc((-116, 2240, -1264));
      break;
    case "parking_outpost":
      maps\mp\alien\_chaos::set_egg_default_loc((-116, 2240, -1264));
      break;
    case "rooftop_outpost":
      maps\mp\alien\_chaos::set_egg_default_loc((-116, 2240, -1264));
      break;
    case "left_transition":
      maps\mp\alien\_chaos::set_egg_default_loc((-116, 2240, -1264));
      break;
    case "upper_left_transition":
      maps\mp\alien\_chaos::set_egg_default_loc((-116, 2240, -1264));
      break;
    case "middle_transition":
      maps\mp\alien\_chaos::set_egg_default_loc((-116, 2240, -1264));
      break;
    case "upper_right_transition":
      maps\mp\alien\_chaos::set_egg_default_loc((-116, 2240, -1264));
      break;
    case "right_transition":
      maps\mp\alien\_chaos::set_egg_default_loc((-116, 2240, -1264));
      break;
  }
}

last_player_initial_spawn_loc_override() {
  if(maps\mp\alien\_utility::is_chaos_mode())
    chaos_player_initial_spawn_loc_override();
  else
    regular_player_initial_spawn_loc_override();
}

regular_player_initial_spawn_loc_override() {
  if(!isDefined(maps\mp\alien\_utility::get_player_initial_spawn_origin())) {
    return;
  }
  self.forcespawnorigin = maps\mp\alien\_utility::get_player_initial_spawn_origin();
  self.forcespawnangles = maps\mp\alien\_utility::get_player_initial_spawn_angles();
}

chaos_player_initial_spawn_loc_override() {
  var_0 = [];
  var_1 = [];

  switch (maps\mp\alien\_utility::get_chaos_area()) {
    case "main_base":
      var_0 = [(546, -1457, 36), (719, -1459, 36), (390, -1491, 36), (232, -1501, 36)];
      var_1 = [(0, 90, 0), (0, 90, 0), (0, 90, 0), (0, 90, 0)];
      break;
    case "gas_station_outpost":
      var_0 = [(-2936, -161, 1346), (-3082, -158, 1346), (-3111, -285, 1372), (-2917, -283, 1372)];
      var_1 = [(0, 114, 0), (0, 55, 0), (0, 55, 0), (0, 102, 0)];
      break;
    case "parking_outpost":
      var_0 = [(-2936, -161, 1346), (-3082, -158, 1346), (-3111, -285, 1372), (-2917, -283, 1372)];
      var_1 = [(0, 114, 0), (0, 55, 0), (0, 55, 0), (0, 102, 0)];
      break;
    case "rooftop_outpost":
      var_0 = [(-2936, -161, 1346), (-3082, -158, 1346), (-3111, -285, 1372), (-2917, -283, 1372)];
      var_1 = [(0, 114, 0), (0, 55, 0), (0, 55, 0), (0, 102, 0)];
      break;
    case "left_transition":
      var_0 = [(-2936, -161, 1346), (-3082, -158, 1346), (-3111, -285, 1372), (-2917, -283, 1372)];
      var_1 = [(0, 114, 0), (0, 55, 0), (0, 55, 0), (0, 102, 0)];
      break;
    case "upper_left_transition":
      var_0 = [(-2936, -161, 1346), (-3082, -158, 1346), (-3111, -285, 1372), (-2917, -283, 1372)];
      var_1 = [(0, 114, 0), (0, 55, 0), (0, 55, 0), (0, 102, 0)];
      break;
    case "middle_transition":
      var_0 = [(-2936, -161, 1346), (-3082, -158, 1346), (-3111, -285, 1372), (-2917, -283, 1372)];
      var_1 = [(0, 114, 0), (0, 55, 0), (0, 55, 0), (0, 102, 0)];
      break;
    case "upper_right_transition":
      var_0 = [(-2936, -161, 1346), (-3082, -158, 1346), (-3111, -285, 1372), (-2917, -283, 1372)];
      var_1 = [(0, 114, 0), (0, 55, 0), (0, 55, 0), (0, 102, 0)];
      break;
    case "right_transition":
      var_0 = [(-2936, -161, 1346), (-3082, -158, 1346), (-3111, -285, 1372), (-2917, -283, 1372)];
      var_1 = [(0, 114, 0), (0, 55, 0), (0, 55, 0), (0, 102, 0)];
      break;
  }

  self.forcespawnorigin = var_0[level.players.size];
  self.forcespawnangles = var_1[level.players.size];
}

last_recipe_setup_func() {
  return ["tesla", "grenade", "trap", "weapon", "sticky", "vgrenade", "cortexgrenade", "cortexweapon"];
}

setup_last_offhands() {
  while(!isDefined(level.offhand_secondaries))
    wait 1;

  level.offhand_secondaries = common_scripts\utility::array_add(level.offhand_secondaries, "iw6_aliendlc21_mp");
  level.offhand_explosives = common_scripts\utility::array_add(level.offhand_explosives, "iw6_aliendlc43_mp");
  level.offhand_explosives = common_scripts\utility::array_add(level.offhand_explosives, "iw6_aliendlc22_mp");
  level.offhand_explosives = common_scripts\utility::array_add(level.offhand_explosives, "iw6_aliendlc31_mp");
  level.offhand_explosives = common_scripts\utility::array_add(level.offhand_explosives, "iw6_aliendlc32_mp");
  level.offhand_explosives = common_scripts\utility::array_add(level.offhand_explosives, "iw6_aliendlc33_mp");
}

last_randombox_item_check(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "flare":
    case "trophy":
      self takeweapon("iw6_aliendlc21_mp");
      return;
  }
}

last_alien_death_override_func(var_0) {
  switch (maps\mp\alien\_utility::get_alien_type()) {
    case "bomber":
      thread maps\mp\agents\alien\_alien_bomber::bomber_death(self.origin);
      break;
  }
}

last_cangive_weapon_handler_func(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(self hasweapon("aliensoflam_mp"))
    var_4++;

  if(self.hasriotshield || self.hasriotshieldequipped)
    var_4++;

  var_5 = self getcurrentweapon();
  var_6 = 0;

  if(var_5 == "iw6_aliendlc41_mp")
    var_6 = 1;

  if(var_6 && var_0.size + 1 > var_3 + var_4)
    return 0;

  return 1;
}

last_give_weapon_handler_func(var_0) {
  var_1 = self getcurrentweapon();

  if(var_1 == "iw6_aliendlc41_mp")
    return 0;

  return undefined;
}

setup_incompatible_list() {
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
  level.ammoincompatibleweaponslist[15] = "iw6_aliendlc41_mp";
}

last_custom_death(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = isDefined(var_1) && isplayer(var_1);

  if(var_7 && isDefined(var_4) && maps\mp\alien\_utility::weapon_has_alien_attachment(var_4) && var_3 != "MOD_MELEE" && !maps\mp\alien\_utility::is_true(level.easter_egg_lodge_sign_active)) {
    playFX(level._effect["alien_ark_gib"], self.origin + (0, 0, 32));

    if(maps\mp\alien\_utility::is_true(level.should_use_custom_death_func))
      playFX(level._effect["soul_escape"], self.origin + (0, 0, 32));

    return 1;
  }

  if(maps\mp\alien\_utility::is_true(level.should_use_custom_death_func)) {
    if(var_7 || isDefined(var_1.owner) && isplayer(var_1.owner)) {
      playFX(level._effect["soul_escape"], self.origin + (0, 0, 32));
      return 0;
    }
  }

  return 0;
}