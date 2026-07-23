/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\183.gsc
**************************************/

main() {
  if(!isDefined(level.func)) {
    level.func = [];
  }
  level.func["setsaveddvar"] = ::setsaveddvar;
  level.func["useanimtree"] = ::useanimtree;
  level.func["setanim"] = ::setanim;
  level.func["setanimknob"] = ::setanimknob;
  level.func["clearanim"] = ::clearanim;
  level.func["kill"] = ::kill;
  set_early_level();
  level.global_callbacks = [];
  level.global_callbacks["_autosave_stealthcheck"] = ::global_empty_callback;
  level.global_callbacks["_patrol_endon_spotted_flag"] = ::global_empty_callback;
  level.global_callbacks["_spawner_stealth_default"] = ::global_empty_callback;
  level.global_callbacks["_idle_call_idle_func"] = ::global_empty_callback;

  if(!isDefined(level.visionthermaldefault)) {
    level.visionthermaldefault = "cheat_bw";
  }
  visionsetthermal(level.visionthermaldefault);
  visionsetpain("near_death");
  level.func["damagefeedback"] = maps\_damagefeedback::updatedamagefeedback;
  common_scripts\utility::array_thread(getEntArray("script_model_pickup_claymore", "classname"), ::claymore_pickup_think_global);
  common_scripts\utility::array_thread(getEntArray("ammo_cache", "targetname"), ::ammo_cache_think_global);
  maps\_utility::array_delete(getEntArray("trigger_multiple_softlanding", "classname"));

  if(getDvar("debug") == "") {
    setDvar("debug", "0");
  }
  if(getDvar("fallback") == "") {
    setDvar("fallback", "0");
  }
  if(getDvar("angles") == "") {
    setDvar("angles", "0");
  }
  if(getDvar("noai") == "") {
    setDvar("noai", "off");
  }
  if(getDvar("scr_RequiredMapAspectratio") == "") {
    setDvar("scr_RequiredMapAspectratio", "1");
  }
  setDvar("ac130_player_num", -1);
  maps\_utility::clear_custom_eog_summary();
  setDvar("ui_remotemissile_playernum", 0);
  setDvar("ui_pmc_won", 0);

  if(!isDefined(anim.notetracks)) {
    anim.notetracks = [];
    animscripts\notetracks::registernotetracks();
  }

  maps\_utility::add_start("no_game", ::start_nogame);
  add_no_game_starts();
  level._loadstarted = 1;
  level.first_frame = 1;
  level.level_specific_dof = 0;
  thread remove_level_first_frame();
  level.wait_any_func_array = [];
  level.run_func_after_wait_array = [];
  level.run_call_after_wait_array = [];
  level.run_noself_call_after_wait_array = [];
  level.do_wait_endons_array = [];
  level.abort_wait_any_func_array = [];

  if(!isDefined(level.script)) {
    level.script = tolower(getDvar("mapname"));
  }
  maps\_specialops::specialops_remove_unused();

  if(maps\_utility::is_specialop() && (issplitscreen() || getDvar("coop") == "1")) {
    setDvar("solo_play", "");
  }
  if(issubstr(level.script, "so_survival_")) {} else {}

  level.xp_enable = 0;

  if(maps\_utility::is_specialop()) {
    level.xp_enable = 1;

    if(maps\_utility::is_survival()) {
      level.laststand_type = 2;
    } else {
      level.laststand_type = 1;
    }
  } else {
    level.laststand_type = 0;
  }
  level.dirteffectmenu["center"] = "dirt_effect_center";
  level.dirteffectmenu["left"] = "dirt_effect_left";
  level.dirteffectmenu["right"] = "dirt_effect_right";
  precachemenu(level.dirteffectmenu["center"]);
  precachemenu(level.dirteffectmenu["left"]);
  precachemenu(level.dirteffectmenu["right"]);
  precacheshader("fullscreen_dirt_bottom_b");
  precacheshader("fullscreen_dirt_bottom");
  precacheshader("fullscreen_dirt_left");
  precacheshader("fullscreen_dirt_right");
  precacheshader("fullscreen_bloodsplat_bottom");
  precacheshader("fullscreen_bloodsplat_left");
  precacheshader("fullscreen_bloodsplat_right");
  level.ai_number = 0;

  if(!isDefined(level.flag)) {
    common_scripts\utility::init_flags();
  } else {
    var_0 = getarraykeys(level.flag);
    common_scripts\utility::array_levelthread(var_0, ::check_flag_for_stat_tracking);
  }

  init_level_players();

  if(maps\_utility::is_coop()) {
    maps\_coop::main();
  }
  if(maps\_utility::laststand_enabled()) {
    maps\_laststand::main();
  }
  if(issplitscreen()) {
    setsaveddvar("cg_fovScale", "0.75");
  } else {
    setsaveddvar("cg_fovScale", "1");
  }
  level.radiation_totalpercent = 0;
  common_scripts\utility::flag_init("missionfailed");
  common_scripts\utility::flag_init("auto_adjust_initialized");
  common_scripts\utility::flag_init("_radiation_poisoning");
  common_scripts\utility::flag_init("gameskill_selected");
  common_scripts\utility::flag_init("battlechatter_on_thread_waiting");
  thread maps\_gameskill::aa_init_stats();
  thread player_death_detection();
  level.default_run_speed = 190;
  setsaveddvar("g_speed", level.default_run_speed);

  if(maps\_utility::is_specialop()) {
    setsaveddvar("sv_saveOnStartMap", 0);
  } else if(maps\_utility::arcademode()) {
    setsaveddvar("sv_saveOnStartMap", 0);
    thread arcademode_save();
  } else if(isDefined(level.credits_active)) {
    setsaveddvar("sv_saveOnStartMap", 0);
  } else {
    setsaveddvar("sv_saveOnStartMap", 1);
  }
  common_scripts\utility::create_lock("mg42_drones");
  common_scripts\utility::create_lock("mg42_drones_target_trace");
  level.dronestruct = [];

  foreach(var_3, var_2 in level.struct) {
    if(!isDefined(var_2.targetname)) {
      continue;
    }
    if(var_2.targetname == "delete_on_load") {
      level.struct[var_3] = undefined;
    }
  }

  common_scripts\utility::struct_class_init();
  common_scripts\utility::flag_init("respawn_friendlies");
  common_scripts\utility::flag_init("player_flashed");
  level.arcademode_kill_func = maps\_utility::arcademode_kill;
  level.connectpathsfunction = ::connectpaths;
  level.disconnectpathsfunction = ::disconnectpaths;
  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;
  level.isaifunc = ::isai;
  level.createclientfontstring_func = maps\_hud_util::createserverclientfontstring;
  level.hudsetpoint_func = maps\_hud_util::setpoint;
  level.makeentitysentient_func = ::makeentitysentient;
  level.freeentitysentient_func = ::freeentitysentient;
  level.laseron_func = ::laserforceon;
  level.laseroff_func = ::laserforceoff;
  level.stat_track_kill_func = maps\_player_stats::register_kill;
  level.stat_track_damage_func = maps\_player_stats::register_shot_hit;
  level.dopickyautosavechecks = 1;
  level.autosave_threat_check_enabled = 1;
  level.getnodefunction = ::getnode;
  level.getnodearrayfunction = ::getnodearray;

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }
  foreach(var_5 in level.players) {
    var_5.maxhealth = level.player.health;
    var_5.shellshocked = 0;
    var_5.inwater = 0;
    var_5 thread watchweaponchange();
  }

  level.last_mission_sound_time = -5000;
  level.hero_list = [];
  thread precache_script_models();

  for(var_7 = 0; var_7 < level.players.size; var_7++) {
    var_5 = level.players[var_7];
    var_5 thread maps\_utility::flashmonitor();
    var_5 thread maps\_utility::shock_ondeath();
  }

  precachemodel("fx");
  precachemodel("tag_origin");
  precacheshellshock("victoryscreen");
  precacheshellshock("default");
  precacheshellshock("flashbang");
  precacheshellshock("dog_bite");
  precacherumble("damage_heavy");
  precacherumble("damage_light");
  precacherumble("grenade_rumble");
  precacherumble("artillery_rumble");
  precachestring(&"GAME_GET_TO_COVER");
  precachestring(&"GAME_LAST_STAND_GET_BACK_UP");
  precachestring(&"SCRIPT_GRENADE_DEATH");
  precachestring(&"SCRIPT_GRENADE_SUICIDE_LINE1");
  precachestring(&"SCRIPT_GRENADE_SUICIDE_LINE2");
  precachestring(&"SCRIPT_EXPLODING_VEHICLE_DEATH");
  precachestring(&"SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH");
  precachestring(&"SCRIPT_EXPLODING_BARREL_DEATH");
  precacheshader("hud_grenadeicon");
  precacheshader("hud_grenadepointer");
  precacheshader("hud_burningcaricon");
  precacheshader("death_juggernaut");
  precacheshader("death_friendly_fire");
  precacheshader("hud_destructibledeathicon");
  precacheshader("hud_burningbarrelicon");
  precacheshader("waypoint_ammo");
  level._effect["deathfx_bloodpool_generic"] = loadfx("impacts/deathfx_bloodpool_generic");
  animscripts\pain::initpainfx();
  animscripts\melee::melee_init();
  level.createfx_enabled = getDvar("createfx") != "";
  slowmo_system_init();
  maps\_mgturret::main();
  setupexploders();
  maps\_art::main();
  maps\_noder::main();
  common_scripts\_painter::main();
  maps\_gameskill::setskill();
  maps\_anim::init();
  thread common_scripts\_fx::initfx();

  if(level.createfx_enabled) {
    level.stop_load = 1;
    maps\_createfx::createfx();
  }

  maps\_global_fx::main();
  maps\_detonategrenades::init();
  thread setup_simple_primary_lights();
  maps\_names::setup_names();

  if(isDefined(level.handle_starts_endons)) {
    thread[[level.handle_starts_endons]]();
  } else {
    thread handle_starts();
  }
  if(!isDefined(level.trigger_flags)) {
    common_scripts\utility::init_trigger_flags();
  }
  level.killspawn_groups = [];
  init_script_triggers();
  setsaveddvar("ufoHitsTriggers", "0");
  do_no_game_start();

  if(getDvar("g_connectpaths") == "2") {
    level waittill("eternity");
  }
  maps\_autosave::main();

  if(!isDefined(level.animsounds)) {
    thread maps\_debug::init_animsounds();
  }
  maps\_anim::init();
  maps\_audio::aud_init();

  if(isDefined(level.audio_stringtable_mapname)) {
    maps\_audio::set_stringtable_mapname(level.audio_stringtable_mapname);
  }
  anim.usefacialanims = 0;

  if(!isDefined(level.missionfailed)) {
    level.missionfailed = 0;
  }
  maps\_loadout::init_loadout();
  common_scripts\_destructible::init();
  thread common_scripts\_elevator::init();
  thread common_scripts\_pipes::main();
  thread maps\_vehicle::init_vehicles();
  setobjectivetextcolors();
  common_scripts\_dynamic_world::init();
  setsaveddvar("ui_campaign", level.campaign);
  thread maps\_introscreen::main();
  thread maps\_quotes::main();
  thread maps\_shutter::main();
  thread maps\_endmission::main();
  thread maps\_damagefeedback::init();
  thread maps\_escalator::init();
  maps\_friendlyfire::main();
  common_scripts\utility::array_levelthread(getEntArray("badplace", "targetname"), ::badplace_think);
  common_scripts\utility::array_levelthread(getEntArray("delete_on_load", "targetname"), maps\_utility::deleteent);
  common_scripts\utility::array_thread(getnodearray("traverse", "targetname"), ::traversethink);
  common_scripts\utility::array_thread(getEntArray("piano_key", "targetname"), ::pianothink);
  common_scripts\utility::array_thread(getEntArray("piano_damage", "targetname"), ::pianodamagethink);
  common_scripts\utility::array_thread(getEntArray("water", "targetname"), ::waterthink);
  common_scripts\utility::array_thread(getEntArray("kill_all_players", "targetname"), ::kill_all_players_trigger);
  common_scripts\utility::flag_init("allow_ammo_pickups");
  common_scripts\utility::flag_set("allow_ammo_pickups");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_grenade_launcher", "targetname"), ::ammo_pickup, "grenade_launcher");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_rpg", "targetname"), ::ammo_pickup, "rpg");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_c4", "targetname"), ::ammo_pickup, "c4");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_claymore", "targetname"), ::ammo_pickup, "claymore");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_556", "targetname"), ::ammo_pickup, "556");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_762", "targetname"), ::ammo_pickup, "762");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_45", "targetname"), ::ammo_pickup, "45");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_pistol", "targetname"), ::ammo_pickup, "pistol");
  thread maps\_interactive_objects::main();
  thread maps\_intelligence::main();
  thread maps\_gameskill::playerhealthregeninit();

  for(var_7 = 0; var_7 < level.players.size; var_7++) {
    var_5 = level.players[var_7];
    var_5 thread maps\_gameskill::playerhealthregen();
    var_5 thread playerdamagerumble();
  }

  thread player_special_death_hint();
  thread massnodeinitfunctions();
  common_scripts\utility::flag_init("spawning_friendlies");
  common_scripts\utility::flag_init("friendly_wave_spawn_enabled");
  common_scripts\utility::flag_clear("spawning_friendlies");
  level.friendly_spawner["rifleguy"] = getEntArray("rifle_spawner", "script_noteworthy");
  level.friendly_spawner["smgguy"] = getEntArray("smg_spawner", "script_noteworthy");
  level.spawn_funcs = [];
  level.spawn_funcs["allies"] = [];
  level.spawn_funcs["axis"] = [];
  level.spawn_funcs["team3"] = [];
  level.spawn_funcs["neutral"] = [];
  thread maps\_spawner::goalvolumes();
  thread maps\_spawner::friendlychains();
  thread maps\_spawner::friendlychain_ondeath();
  common_scripts\utility::array_thread(getEntArray("friendly_spawn", "targetname"), maps\_spawner::friendlyspawnwave);
  common_scripts\utility::array_thread(getEntArray("flood_and_secure", "targetname"), maps\_spawner::flood_and_secure);
  common_scripts\utility::array_thread(getEntArray("window_poster", "targetname"), ::window_destroy);

  if(!isDefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
  }

  level.shared_portable_turrets = [];
  level.spawn_groups = [];
  maps\_spawner::main();
  common_scripts\utility::array_thread(getEntArray("background_block", "targetname"), ::background_block);
  maps\_hud::init();
  thread load_friendlies();
  thread maps\_animatedmodels::main();

  if(maps\_utility::is_coop()) {
    thread maps\_loadout::coop_gamesetup_menu();
  }
  thread weapon_ammo();

  if(maps\_utility::is_specialop()) {
    maps\_specialops::specialops_init();
  }
  if(level.script == level.missionsettings.levels[0].name && !level.player getlocalplayerprofiledata("hasEverPlayed_SP")) {
    level.player setlocalplayerprofiledata("hasEverPlayed_SP", 1);
    updategamerprofile();
  }

  level notify("load_finished");
}

get_load_trigger_classes() {
  var_0 = [];
  var_0["trigger_multiple_nobloodpool"] = ::trigger_nobloodpool;
  var_0["trigger_multiple_flag_set"] = ::flag_set_trigger;
  var_0["trigger_multiple_flag_clear"] = ::flag_unset_trigger;
  var_0["trigger_multiple_sun_off"] = ::sun_off;
  var_0["trigger_multiple_sun_on"] = ::sun_on;
  var_0["trigger_use_flag_set"] = ::flag_set_trigger;
  var_0["trigger_use_flag_clear"] = ::flag_unset_trigger;
  var_0["trigger_multiple_flag_set_touching"] = ::flag_set_touching;
  var_0["trigger_multiple_flag_lookat"] = ::trigger_lookat;
  var_0["trigger_multiple_flag_looking"] = ::trigger_looking;
  var_0["trigger_multiple_no_prone"] = ::no_prone_think;
  var_0["trigger_multiple_no_crouch_or_prone"] = ::no_crouch_or_prone_think;
  var_0["trigger_multiple_compass"] = ::trigger_multiple_compass;
  var_0["trigger_multiple_specialops_flag_set"] = ::flag_set_trigger_specialops;
  var_0["trigger_multiple_fx_volume"] = ::trigger_multiple_fx_volume;
  var_0["trigger_multiple_light_sunshadow"] = maps\_lights::sun_shadow_trigger;

  if(!maps\_utility::is_no_game_start()) {
    var_0["trigger_multiple_autosave"] = maps\_autosave::trigger_autosave;
    var_0["trigger_multiple_spawn"] = maps\_spawner::trigger_spawner;
    var_0["trigger_multiple_spawn_reinforcement"] = maps\_spawner::trigger_spawner_reinforcement;
  }

  var_0["trigger_multiple_slide"] = ::trigger_slide;
  var_0["trigger_multiple_fog"] = ::trigger_fog;
  var_0["trigger_damage_doradius_damage"] = ::trigger_damage_do_radius_damage;
  var_0["trigger_multiple_doradius_damage"] = ::trigger_multiple_do_radius_damage;
  var_0["trigger_damage_player_flag_set"] = ::trigger_damage_player_flag_set;
  var_0["trigger_multiple_visionset"] = ::trigger_multiple_visionset;
  var_0["trigger_multiple_glass_break"] = ::trigger_glass_break;
  var_0["trigger_radius_glass_break"] = ::trigger_glass_break;
  var_0["trigger_multiple_friendly_respawn"] = ::trigger_multiple_friendly_respawn;
  var_0["trigger_multiple_friendly_stop_respawn"] = ::trigger_multiple_friendly_stop_respawn;
  var_0["trigger_multiple_physics"] = ::trigger_multiple_physics;
  var_0["trigger_multiple_fx_watersheeting"] = maps\_fx::watersheeting;
  return var_0;
}

get_load_trigger_funcs() {
  var_0 = [];
  var_0["friendly_wave"] = maps\_spawner::friendly_wave;
  var_0["friendly_wave_off"] = maps\_spawner::friendly_wave;
  var_0["friendly_mgTurret"] = maps\_spawner::friendly_mgturret;

  if(!maps\_utility::is_no_game_start()) {
    var_0["camper_spawner"] = maps\_spawner::camper_trigger_think;
    var_0["flood_spawner"] = maps\_spawner::flood_trigger_think;
    var_0["trigger_spawner"] = maps\_spawner::trigger_spawner;
    var_0["trigger_autosave"] = maps\_autosave::trigger_autosave;
    var_0["trigger_spawngroup"] = ::trigger_spawngroup;
    var_0["two_stage_spawner"] = maps\_spawner::two_stage_spawner_think;
    var_0["trigger_vehicle_spline_spawn"] = ::trigger_vehicle_spline_spawn;
    var_0["trigger_vehicle_spawn"] = ::trigger_vehicle_spawn;
    var_0["trigger_vehicle_getin_spawn"] = ::trigger_vehicle_getin_spawn;
    var_0["random_spawn"] = maps\_spawner::random_spawn;
  }

  var_0["autosave_now"] = maps\_autosave::autosave_now_trigger;
  var_0["trigger_autosave_tactical"] = maps\_autosave::trigger_autosave_tactical;
  var_0["trigger_autosave_stealth"] = maps\_autosave::trigger_autosave_stealth;
  var_0["trigger_unlock"] = ::trigger_unlock;
  var_0["trigger_lookat"] = ::trigger_lookat;
  var_0["trigger_looking"] = ::trigger_looking;
  var_0["trigger_cansee"] = ::trigger_cansee;
  var_0["autosave_immediate"] = maps\_autosave::trigger_autosave_immediate;
  var_0["flag_set"] = ::flag_set_trigger;

  if(maps\_utility::is_coop()) {
    var_0["flag_set_coop"] = ::flag_set_coop_trigger;
  }
  var_0["flag_set_player"] = ::flag_set_player_trigger;
  var_0["flag_unset"] = ::flag_unset_trigger;
  var_0["flag_clear"] = ::flag_unset_trigger;
  var_0["objective_event"] = maps\_spawner::objective_event_init;
  var_0["friendly_respawn_trigger"] = ::trigger_multiple_friendly_respawn;
  var_0["friendly_respawn_clear"] = ::friendly_respawn_clear;
  var_0["radio_trigger"] = ::radio_trigger;
  var_0["trigger_ignore"] = ::trigger_ignore;
  var_0["trigger_pacifist"] = ::trigger_pacifist;
  var_0["trigger_delete"] = ::trigger_turns_off;
  var_0["trigger_delete_on_touch"] = ::trigger_delete_on_touch;
  var_0["trigger_off"] = ::trigger_turns_off;
  var_0["trigger_outdoor"] = maps\_spawner::outdoor_think;
  var_0["trigger_indoor"] = maps\_spawner::indoor_think;
  var_0["trigger_hint"] = ::trigger_hint;
  var_0["trigger_grenade_at_player"] = ::throw_grenade_at_player_trigger;
  var_0["flag_on_cleared"] = ::flag_on_cleared;
  var_0["flag_set_touching"] = ::flag_set_touching;
  var_0["delete_link_chain"] = ::delete_link_chain;
  var_0["trigger_fog"] = ::trigger_fog;
  var_0["trigger_slide"] = ::trigger_slide;
  var_0["trigger_dooropen"] = ::trigger_dooropen;
  var_0["no_crouch_or_prone"] = ::no_crouch_or_prone_think;
  var_0["no_prone"] = ::no_prone_think;
  return var_0;
}

init_script_triggers() {
  var_0 = get_load_trigger_classes();
  var_1 = get_load_trigger_funcs();

  foreach(var_5, var_3 in var_0) {
    var_4 = getEntArray(var_5, "classname");
    common_scripts\utility::array_levelthread(var_4, var_3);
  }

  var_6 = getEntArray("trigger_multiple", "classname");
  var_7 = getEntArray("trigger_radius", "classname");
  var_4 = maps\_utility::array_merge(var_6, var_7);
  var_8 = getEntArray("trigger_disk", "classname");
  var_4 = maps\_utility::array_merge(var_4, var_8);
  var_9 = getEntArray("trigger_once", "classname");
  var_4 = maps\_utility::array_merge(var_4, var_9);

  if(!maps\_utility::is_no_game_start()) {
    for(var_10 = 0; var_10 < var_4.size; var_10++) {
      if(var_4[var_10].spawnflags & 32) {
        thread maps\_spawner::trigger_spawner(var_4[var_10]);
      }
    }
  }

  for(var_11 = 0; var_11 < 7; var_11++) {
    switch (var_11) {
      case 0:
        var_12 = "trigger_multiple";
        break;
      case 1:
        var_12 = "trigger_once";
        break;
      case 2:
        var_12 = "trigger_use";
        break;
      case 3:
        var_12 = "trigger_radius";
        break;
      case 4:
        var_12 = "trigger_lookat";
        break;
      case 5:
        var_12 = "trigger_disk";
        break;
      default:
        var_12 = "trigger_damage";
        break;
    }

    var_4 = getEntArray(var_12, "code_classname");

    for(var_10 = 0; var_10 < var_4.size; var_10++) {
      if(isDefined(var_4[var_10].script_flag_true)) {
        level thread script_flag_true_trigger(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].script_flag_false)) {
        level thread script_flag_false_trigger(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].script_autosavename) || isDefined(var_4[var_10].script_autosave)) {
        level thread maps\_autosave::autosavenamethink(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].script_fallback)) {
        level thread maps\_spawner::fallback_think(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].script_mgturretauto)) {
        level thread maps\_mgturret::mgturret_auto(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].script_killspawner)) {
        level thread maps\_spawner::kill_spawner(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].script_kill_vehicle_spawner)) {
        level thread maps\_vehicle::kill_vehicle_spawner(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].script_emptyspawner)) {
        level thread maps\_spawner::empty_spawner(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].script_prefab_exploder)) {
        var_4[var_10].script_exploder = var_4[var_10].script_prefab_exploder;
      }
      if(isDefined(var_4[var_10].script_exploder)) {
        level thread exploder_load(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].ambient)) {
        var_4[var_10] thread maps\_audio::trigger_multiple_audio_trigger(1);
      }
      if(isDefined(var_4[var_10].script_audio_zones) || isDefined(var_4[var_10].script_audio_enter_msg) || isDefined(var_4[var_10].script_audio_exit_msg) || isDefined(var_4[var_10].script_audio_progress_msg) || isDefined(var_4[var_10].script_audio_enter_func) || isDefined(var_4[var_10].script_audio_exit_func) || isDefined(var_4[var_10].script_audio_progress_func) || isDefined(var_4[var_10].script_audio_point_func)) {
        var_4[var_10] thread maps\_audio::trigger_multiple_audio_trigger();
      }
      if(isDefined(var_4[var_10].script_triggered_playerseek)) {
        level thread triggered_playerseek(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].script_bctrigger)) {
        level thread bctrigger(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].script_trigger_group)) {
        var_4[var_10] thread trigger_group();
      }
      if(isDefined(var_4[var_10].script_random_killspawner)) {
        level thread maps\_spawner::random_killspawner(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].targetname)) {
        var_13 = var_4[var_10].targetname;

        if(isDefined(var_1[var_13])) {
          level thread[[var_1[var_13]]](var_4[var_10]);
        }
      }
    }
  }
}

set_early_level() {
  level.early_level = [];
  level.early_level["intro"] = 1;
  level.early_level["sp_ny_harbor"] = 1;
  level.early_level["sp_ny_manhattan"] = 1;
  level.early_level["warlord"] = 1;
  level.early_level["london"] = 1;
}

trigger_slide(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);
    var_1 thread slidetriggerplayerthink(var_0);
  }
}

slidetriggerplayerthink(var_0) {
  if(isDefined(self.vehicle)) {
    return;
  }
  if(maps\_utility::issliding()) {
    return;
  }
  thread maps\_audio::aud_send_msg("start_player_slide_trigger", self);

  if(isDefined(self.player_view)) {
    return;
  }
  self endon("death");

  if(soundexists("SCN_cliffhanger_player_hillslide")) {
    self playSound("SCN_cliffhanger_player_hillslide");
  }
  var_1 = undefined;

  if(isDefined(var_0.script_accel)) {
    var_1 = var_0.script_accel;
  }
  maps\_utility::beginsliding(undefined, var_1);

  for(;;) {
    if(!self istouching(var_0)) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(level.end_slide_delay)) {
    wait(level.end_slide_delay);
  }
  maps\_utility::endsliding();
  thread maps\_audio::aud_send_msg("end_player_slide_trigger", self);
}

setup_simple_primary_lights() {
  var_0 = getEntArray("generic_flickering", "targetname");
  var_1 = getEntArray("generic_pulsing", "targetname");
  var_2 = getEntArray("generic_double_strobe", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_lights::generic_flickering);
  common_scripts\utility::array_thread(var_1, maps\_lights::generic_pulsing);
  common_scripts\utility::array_thread(var_2, maps\_lights::generic_double_strobe);
}

weapon_ammo() {
  var_0 = getEntArray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].classname) && getsubstr(var_0[var_1].classname, 0, 7) == "weapon_") {
      var_2 = var_0[var_1];
      var_3 = getsubstr(var_2.classname, 7);

      if(isDefined(var_2.script_ammo_max)) {
        var_4 = weaponclipsize(var_3);
        var_5 = weaponmaxammo(var_3);
        var_2 itemweaponsetammo(var_4, var_5, var_4, 0);
        var_6 = weaponaltweaponname(var_3);

        if(var_6 != "none") {
          var_7 = weaponclipsize(var_6);
          var_8 = weaponmaxammo(var_6);
          var_2 itemweaponsetammo(var_7, var_8, var_7, 1);
        }

        continue;
      }

      var_9 = 0;
      var_4 = undefined;
      var_10 = undefined;
      var_11 = 0;
      var_12 = undefined;
      var_13 = undefined;

      if(isDefined(var_2.script_ammo_clip)) {
        var_4 = var_2.script_ammo_clip;
        var_9 = 1;
      }

      if(isDefined(var_2.script_ammo_extra)) {
        var_10 = var_2.script_ammo_extra;
        var_9 = 1;
      }

      if(isDefined(var_2.script_ammo_alt_clip)) {
        var_12 = var_2.script_ammo_alt_clip;
        var_11 = 1;
      }

      if(isDefined(var_2.script_ammo_alt_extra)) {
        var_13 = var_2.script_ammo_alt_extra;
        var_11 = 1;
      }

      if(var_9) {
        if(!isDefined(var_4)) {}

        if(!isDefined(var_10)) {}

        var_2 itemweaponsetammo(var_4, var_10);
      }

      if(var_11) {
        if(!isDefined(var_12)) {}

        if(!isDefined(var_13)) {}

        var_2 itemweaponsetammo(var_12, var_13, 0, 1);
      }
    }
  }
}

trigger_group() {
  thread trigger_group_remove();
  level endon("trigger_group_" + self.script_trigger_group);
  self waittill("trigger");
  level notify("trigger_group_" + self.script_trigger_group, self);
}

trigger_group_remove() {
  level waittill("trigger_group_" + self.script_trigger_group, var_0);

  if(self != var_0) {
    self delete();
  }
}

exploder_load(var_0) {
  level endon("killexplodertridgers" + var_0.script_exploder);
  var_0 waittill("trigger");

  if(isDefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(!var_0 maps\_utility::script_delay()) {
      wait 4;
    }
    level thread exploder_load(var_0);
    return;
  }

  if(!var_0 maps\_utility::script_delay() && isDefined(var_0.script_exploder_delay)) {
    wait(var_0.script_exploder_delay);
  }
  common_scripts\utility::exploder(var_0.script_exploder);
  level notify("killexplodertridgers" + var_0.script_exploder);
}

shock_onpain() {
  precacheshellshock("pain");
  precacheshellshock("default");
  level.player endon("death");
  setdvarifuninitialized("blurpain", "on");

  for(;;) {
    var_0 = level.player.health;
    level.player waittill("damage");

    if(getDvar("blurpain") == "on") {
      if(var_0 - level.player.health < 129) {
        continue;
      }
      level.player shellshock("default", 5);
    }
  }
}

usedanimations() {
  setDvar("usedanim", "");

  for(;;) {
    if(getDvar("usedanim") == "") {
      wait 2;
      continue;
    }

    var_0 = getDvar("usedanim");
    setDvar("usedanim", "");

    if(!isDefined(level.completedanims[var_0])) {
      continue;
    }
    for(var_1 = 0; var_1 < level.completedanims[var_0].size; var_1++) {}
  }
}

badplace_think(var_0) {
  if(!isDefined(level.badplaces)) {
    level.badplaces = 0;
  }
  level.badplaces++;
  badplace_cylinder("badplace" + level.badplaces, -1, var_0.origin, var_0.radius, 1024);
}

setup_individual_exploder(var_0) {
  var_1 = var_0.script_exploder;

  if(!isDefined(level.exploders[var_1])) {
    level.exploders[var_1] = [];
  }
  var_2 = var_0.targetname;

  if(!isDefined(var_2)) {
    var_2 = "";
  }
  level.exploders[var_1][level.exploders[var_1].size] = var_0;

  if(maps\_utility::exploder_model_starts_hidden(var_0)) {
    var_0 hide();
    return;
  }

  if(maps\_utility::exploder_model_is_damaged_model(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1) {
      if(isDefined(var_0.script_disconnectpaths)) {
        var_0 connectpaths();
      }
    }

    return;
  }

  if(maps\_utility::exploder_model_is_chunk(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1) {
      var_0 connectpaths();
    }
    return;
  }
}

setupexploders() {
  level.exploders = [];
  var_0 = getEntArray("script_brushmodel", "classname");
  var_1 = getEntArray("script_model", "classname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_0[var_0.size] = var_1[var_2];
  }
  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_prefab_exploder)) {
      var_4.script_exploder = var_4.script_prefab_exploder;
    }
    if(isDefined(var_4.masked_exploder)) {
      continue;
    }
    if(isDefined(var_4.script_exploder)) {
      setup_individual_exploder(var_4);
    }
  }

  var_6 = [];
  var_7 = getEntArray("script_brushmodel", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2].script_prefab_exploder)) {
      var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;
    }
    if(isDefined(var_7[var_2].script_exploder)) {
      var_6[var_6.size] = var_7[var_2];
    }
  }

  var_7 = getEntArray("script_model", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2].script_prefab_exploder)) {
      var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;
    }
    if(isDefined(var_7[var_2].script_exploder)) {
      var_6[var_6.size] = var_7[var_2];
    }
  }

  var_7 = getEntArray("item_health", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2].script_prefab_exploder)) {
      var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;
    }
    if(isDefined(var_7[var_2].script_exploder)) {
      var_6[var_6.size] = var_7[var_2];
    }
  }

  if(isDefined(level.enable_struct_exploders)) {
    var_7 = level.struct;

    for(var_2 = 0; var_2 < var_7.size; var_2++) {
      if(!isDefined(var_7[var_2])) {
        continue;
      }
      if(isDefined(var_7[var_2].script_prefab_exploder)) {
        var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;
      }
      if(isDefined(var_7[var_2].script_exploder)) {
        if(!isDefined(var_7[var_2].angles)) {
          var_7[var_2].angles = (0, 0, 0);
        }
        var_6[var_6.size] = var_7[var_2];
      }
    }
  }

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }
  var_8 = [];
  var_8["exploderchunk visible"] = 1;
  var_8["exploderchunk"] = 1;
  var_8["exploder"] = 1;
  thread setup_flag_exploders();

  for(var_2 = 0; var_2 < var_6.size; var_2++) {
    var_9 = var_6[var_2];
    var_4 = common_scripts\utility::createexploder(var_9.script_fxid);
    var_4.v = [];
    var_4.v["origin"] = var_9.origin;
    var_4.v["angles"] = var_9.angles;
    var_4.v["delay"] = var_9.script_delay;
    var_4.v["delay_post"] = var_9.script_delay_post;
    var_4.v["firefx"] = var_9.script_firefx;
    var_4.v["firefxdelay"] = var_9.script_firefxdelay;
    var_4.v["firefxsound"] = var_9.script_firefxsound;
    var_4.v["firefxtimeout"] = var_9.script_firefxtimeout;
    var_4.v["earthquake"] = var_9.script_earthquake;
    var_4.v["rumble"] = var_9.script_rumble;
    var_4.v["damage"] = var_9.script_damage;
    var_4.v["damage_radius"] = var_9.script_radius;
    var_4.v["soundalias"] = var_9.script_soundalias;
    var_4.v["repeat"] = var_9.script_repeat;
    var_4.v["delay_min"] = var_9.script_delay_min;
    var_4.v["delay_max"] = var_9.script_delay_max;
    var_4.v["target"] = var_9.target;
    var_4.v["ender"] = var_9.script_ender;
    var_4.v["physics"] = var_9.script_physics;
    var_4.v["type"] = "exploder";

    if(!isDefined(var_9.script_fxid)) {
      var_4.v["fxid"] = "No FX";
    } else {
      var_4.v["fxid"] = var_9.script_fxid;
    }
    var_4.v["exploder"] = var_9.script_exploder;

    if(isDefined(level.createfxexploders)) {
      var_10 = level.createfxexploders[var_4.v["exploder"]];

      if(!isDefined(var_10)) {
        var_10 = [];
      }
      var_10[var_10.size] = var_4;
      level.createfxexploders[var_4.v["exploder"]] = var_10;
    }

    if(!isDefined(var_4.v["delay"])) {
      var_4.v["delay"] = 0;
    }
    if(isDefined(var_9.target)) {
      var_11 = getEntArray(var_4.v["target"], "targetname")[0];

      if(isDefined(var_11)) {
        var_12 = var_11.origin;
        var_4.v["angles"] = vectortoangles(var_12 - var_4.v["origin"]);
      } else {
        var_11 = common_scripts\utility::get_target_ent(var_4.v["target"]);

        if(isDefined(var_11)) {
          var_12 = var_11.origin;
          var_4.v["angles"] = vectortoangles(var_12 - var_4.v["origin"]);
        }
      }
    }

    if(!isDefined(level.enable_struct_exploders)) {
      if(var_9.code_classname == "script_brushmodel" || isDefined(var_9.model)) {
        var_4.model = var_9;
        var_4.model.disconnect_paths = var_9.script_disconnectpaths;
      }
    } else {
      var_4.model = var_9;

      if(isDefined(var_4.model.script_modelname)) {
        precachemodel(var_4.model.script_modelname);
      }
    }

    if(isDefined(var_9.targetname) && isDefined(var_8[var_9.targetname])) {
      var_4.v["exploder_type"] = var_9.targetname;
    } else {
      var_4.v["exploder_type"] = "normal";
    }
    if(isDefined(var_9.masked_exploder)) {
      var_4.v["masked_exploder"] = var_9.model;
      var_4.v["masked_exploder_spawnflags"] = var_9.spawnflags;
      var_4.v["masked_exploder_script_disconnectpaths"] = var_9.script_disconnectpaths;
      var_9 delete();
    }

    var_4 common_scripts\_createfx::post_entity_creation_function();
  }
}

setup_flag_exploders() {
  waittillframeend;
  waittillframeend;
  waittillframeend;
  var_0 = [];

  foreach(var_2 in level.createfxent) {
    if(var_2.v["type"] != "exploder") {
      continue;
    }
    var_3 = var_2.v["flag"];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == "nil") {
      var_2.v["flag"] = undefined;
    }
    var_0[var_3] = 1;
  }

  foreach(var_7, var_6 in var_0) {}
  thread exploder_flag_wait(var_7);
}

exploder_flag_wait(var_0) {
  if(!common_scripts\utility::flag_exist(var_0)) {
    common_scripts\utility::flag_init(var_0);
  }
  common_scripts\utility::flag_wait(var_0);

  foreach(var_2 in level.createfxent) {
    if(var_2.v["type"] != "exploder") {
      continue;
    }
    var_3 = var_2.v["flag"];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 != var_0) {
      continue;
    }
    var_2 common_scripts\utility::activate_individual_exploder();
  }
}

nearairushesplayer() {
  if(isalive(level.enemyseekingplayer)) {
    return;
  }
  var_0 = maps\_utility::get_closest_ai(level.player.origin, "bad_guys");

  if(!isDefined(var_0)) {
    return;
  }
  if(distance(var_0.origin, level.player.origin) > 400) {
    return;
  }
  level.enemyseekingplayer = var_0;
  var_0 setgoalentity(level.player);
  var_0.goalradius = 512;
}

playerdamagerumble() {
  for(;;) {
    self waittill("damage", var_0);

    if(isDefined(self.specialdamage)) {
      continue;
    }
    self playRumbleOnEntity("damage_heavy");
  }
}

playerdamageshellshock() {
  for(;;) {
    level.player waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH") {
      var_5 = 0;
      var_6 = level.player.maxhealth / 100;
      var_7 = var_0 * var_6;

      if(var_7 >= 90) {
        var_5 = 4;
      } else if(var_7 >= 50) {
        var_5 = 3;
      } else if(var_7 >= 25) {
        var_5 = 2;
      } else if(var_7 > 10) {
        var_5 = 1;
      }
      if(var_5) {
        level.player shellshock("default", var_5);
      }
    }
  }
}

map_is_early_in_the_game() {
  if(isDefined(level.early_level[level.script])) {
    return level.early_level[level.script];
  } else {
    return 0;
  }
}

player_throwgrenade_timer() {
  self endon("death");
  self.lastgrenadetime = 0;

  for(;;) {
    while(!self isthrowinggrenade()) {
      wait 0.05;
    }
    self.lastgrenadetime = gettime();

    while(self isthrowinggrenade()) {
      wait 0.05;
    }
  }
}

player_special_death_hint() {
  if(maps\_utility::is_specialop()) {
    return;
  }
  if(isalive(level.player)) {
    thread maps\_quotes::setdeadquote();
  }
  level.player thread player_throwgrenade_timer();
  level.player waittill("death", var_0, var_1, var_2);

  if(var_1 != "MOD_GRENADE" && var_1 != "MOD_GRENADE_SPLASH" && var_1 != "MOD_SUICIDE" && var_1 != "MOD_EXPLOSIVE") {
    return;
  }
  if(level.gameskill >= 2) {
    if(!map_is_early_in_the_game()) {
      return;
    }
  }

  if(var_1 == "MOD_SUICIDE") {
    if(level.player.lastgrenadetime - gettime() > 3500.0) {
      return;
    }
    level notify("new_quote_string");
    thread grenade_death_text_hudelement(&"SCRIPT_GRENADE_SUICIDE_LINE1", &"SCRIPT_GRENADE_SUICIDE_LINE2");
    return;
  }

  if(var_1 == "MOD_EXPLOSIVE") {
    if(level.player destructible_death(var_0)) {
      return;
    }
    if(level.player exploding_barrel_death_af_chase(var_0)) {
      return;
    }
    if(level.player vehicle_death(var_0)) {
      return;
    }
    if(level.player exploding_barrel_death(var_0)) {
      return;
    }
  }

  if(var_1 == "MOD_GRENADE" || var_1 == "MOD_GRENADE_SPLASH") {
    if(isDefined(var_2) && !isweapondetonationtimed(var_2)) {
      return;
    }
    level notify("new_quote_string");
    setDvar("ui_deadquote", "@SCRIPT_GRENADE_DEATH");
    thread grenade_death_indicator_hudelement();
    return;
  }
}

vehicle_death(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0.code_classname != "script_vehicle") {
    return 0;
  }
  level notify("new_quote_string");
  setDvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
  thread special_death_indicator_hudelement("hud_burningcaricon", 96, 96);
  return 1;
}

destructible_death(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!isDefined(var_0.destructible_type)) {
    return 0;
  }
  level notify("new_quote_string");

  if(issubstr(var_0.destructible_type, "vehicle")) {
    setDvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
    thread special_death_indicator_hudelement("hud_burningcaricon", 96, 96);
  } else {
    setDvar("ui_deadquote", "@SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH");
    thread special_death_indicator_hudelement("hud_destructibledeathicon", 96, 96);
  }

  return 1;
}

exploding_barrel_death_af_chase(var_0) {
  if(level.script != "af_chase") {
    return 0;
  }
  return exploding_barrel_death(var_0);
}

exploding_barrel_death(var_0) {
  if(isDefined(level.lastexplodingbarrel)) {
    if(gettime() != level.lastexplodingbarrel["time"]) {
      return 0;
    }
    var_1 = distance(self.origin, level.lastexplodingbarrel["origin"]);

    if(var_1 > level.lastexplodingbarrel["radius"]) {
      return 0;
    }
    level notify("new_quote_string");
    setDvar("ui_deadquote", "@SCRIPT_EXPLODING_BARREL_DEATH");
    thread special_death_indicator_hudelement("hud_burningbarrelicon", 64, 64);
    return 1;
  }

  return 0;
}

grenade_death_text_hudelement(var_0, var_1) {
  level.player.failingmission = 1;
  setDvar("ui_deadquote", "");
  wait 1.5;
  var_2 = newhudelem();
  var_2.elemtype = "font";
  var_2.font = "default";
  var_2.fontscale = 1.5;
  var_2.x = 0;
  var_2.y = -30;
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "center";
  var_2.vertalign = "middle";
  var_2 settext(var_0);
  var_2.foreground = 1;
  var_2.alpha = 0;
  var_2 fadeovertime(1);
  var_2.alpha = 1;

  if(isDefined(var_1)) {
    var_2 = newhudelem();
    var_2.elemtype = "font";
    var_2.font = "default";
    var_2.fontscale = 1.5;
    var_2.x = 0;
    var_2.y = -25 + level.fontheight * var_2.fontscale;
    var_2.alignx = "center";
    var_2.aligny = "middle";
    var_2.horzalign = "center";
    var_2.vertalign = "middle";
    var_2 settext(var_1);
    var_2.foreground = 1;
    var_2.alpha = 0;
    var_2 fadeovertime(1);
    var_2.alpha = 1;
  }
}

grenade_death_indicator_hudelement() {
  wait 1.5;
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 68;
  var_0 setshader("hud_grenadeicon", 50, 50);
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.foreground = 1;
  var_0.alpha = 0;
  var_0 fadeovertime(1);
  var_0.alpha = 1;
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 25;
  var_0 setshader("hud_grenadepointer", 50, 25);
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.foreground = 1;
  var_0.alpha = 0;
  var_0 fadeovertime(1);
  var_0.alpha = 1;
}

special_death_indicator_hudelement(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1.5;
  }
  wait(var_3);
  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 40;
  var_4 setshader(var_0, var_1, var_2);
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.horzalign = "center";
  var_4.vertalign = "middle";
  var_4.foreground = 1;
  var_4.alpha = 0;
  var_4 fadeovertime(1);
  var_4.alpha = 1;
}

triggered_playerseek(var_0) {
  var_1 = var_0.script_triggered_playerseek;
  var_0 waittill("trigger");
  var_2 = getaiarray();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isalive(var_2[var_3])) {
      continue;
    }
    if(isDefined(var_2[var_3].script_triggered_playerseek) && var_2[var_3].script_triggered_playerseek == var_1) {
      var_2[var_3].goalradius = 800;
      var_2[var_3] setgoalentity(level.player);
      level thread maps\_spawner::delayed_player_seek_think(var_2[var_3]);
    }
  }
}

traversethink() {
  var_0 = getEnt(self.target, "targetname");
  self.traverse_height = var_0.origin[2];
  var_0 delete();
}

pianodamagethink() {
  var_0 = self getorigin();
  var_1[0] = "large";
  var_1[1] = "small";

  for(;;) {
    self waittill("trigger");
    thread common_scripts\utility::play_sound_in_space("bullet_" + common_scripts\utility::random(var_1) + "_piano", var_0);
  }
}

pianothink() {
  var_0 = self getorigin();
  var_1 = "piano_" + self.script_noteworthy;
  self setHintString(&"SCRIPT_PLATFORM_PIANO");

  for(;;) {
    self waittill("trigger");
    thread common_scripts\utility::play_sound_in_space(var_1, var_0);
  }
}

bctrigger(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.target)) {
    var_2 = getEntArray(var_0.target, "targetname");

    if(issubstr(var_2[0].classname, "trigger")) {
      var_1 = var_2[0];
    }
  }

  if(isDefined(var_1)) {
    var_1 waittill("trigger", var_3);
  } else {
    var_0 waittill("trigger", var_3);
  }
  var_4 = undefined;

  if(isDefined(var_1)) {
    if(var_3.team != level.player.team && level.player istouching(var_0)) {
      var_4 = level.player animscripts\battlechatter::getclosestfriendlyspeaker("custom");
    } else if(var_3.team == level.player.team) {
      var_5 = "axis";

      if(level.player.team == "axis") {
        var_5 = "allies";
      }
      var_6 = animscripts\battlechatter::getspeakers("custom", var_5);
      var_6 = maps\_utility::get_array_of_farthest(level.player.origin, var_6);

      foreach(var_8 in var_6) {
        if(var_8 istouching(var_0)) {
          var_4 = var_8;

          if(bctrigger_validate_distance(var_8.origin)) {
            break;
          }
        }
      }
    }
  } else if(isPlayer(var_3)) {
    var_4 = var_3 animscripts\battlechatter::getclosestfriendlyspeaker("custom");
  } else {
    var_4 = var_3;
  }
  if(!isDefined(var_4)) {
    return;
  }
  if(!bctrigger_validate_distance(var_4.origin)) {
    return;
  }
  var_10 = var_4 maps\_utility::custom_battlechatter(var_0.script_bctrigger);

  if(!var_10) {
    level maps\_utility::delaythread(0.25, ::bctrigger, var_0);
  } else {
    var_0 notify("custom_battlechatter_done");
  }
}

bctrigger_validate_distance(var_0) {
  if(distance(var_0, level.player getorigin()) <= 512) {
    return 1;
  }
  return 0;
}

waterthink() {
  var_0 = getEnt(self.target, "targetname");
  var_1 = var_0.origin[2];
  var_0 = undefined;
  level.depth_allow_prone = 8;
  level.depth_allow_crouch = 33;
  level.depth_allow_stand = 50;
  var_2 = 0;

  for(;;) {
    wait 0.05;

    if(!level.player.inwater && var_2) {
      var_2 = 0;
      level.player allowprone(1);
      level.player allowcrouch(1);
      level.player allowstand(1);
      thread waterthink_rampspeed(level.default_run_speed);
    }

    self waittill("trigger");
    level.player.inwater = 1;
    var_2 = 1;

    while(level.player istouching(self)) {
      level.player.inwater = 1;
      var_3 = level.player getorigin();
      var_4 = var_3[2] - var_1;

      if(var_4 > 0) {
        break;
      }

      var_5 = int(level.default_run_speed - abs(var_4 * 5));

      if(var_5 < 50) {
        var_5 = 50;
      }
      thread waterthink_rampspeed(var_5);

      if(abs(var_4) > level.depth_allow_crouch) {
        level.player allowcrouch(0);
      } else {
        level.player allowcrouch(1);
      }
      if(abs(var_4) > level.depth_allow_prone) {
        level.player allowprone(0);
      } else {
        level.player allowprone(1);
      }
      wait 0.5;
    }

    level.player.inwater = 0;
    wait 0.05;
  }
}

waterthink_rampspeed(var_0) {
  level notify("ramping_water_movement_speed");
  level endon("ramping_water_movement_speed");
  var_1 = 0.5;
  var_2 = int(var_1 * 20);
  var_3 = getdvarint("g_speed");
  var_4 = 0;

  if(var_0 < var_3) {
    var_4 = 1;
  }
  var_5 = int(abs(var_3 - var_0));
  var_6 = int(var_5 / var_2);

  for(var_7 = 0; var_7 < var_2; var_7++) {
    var_3 = getdvarint("g_speed");

    if(var_4) {
      setsaveddvar("g_speed", var_3 - var_6);
    } else {
      setsaveddvar("g_speed", var_3 + var_6);
    }
    wait 0.05;
  }

  setsaveddvar("g_speed", var_0);
}

massnodeinitfunctions() {
  var_0 = getallnodes();
  thread maps\_mgturret::auto_mgturretlink(var_0);
  thread maps\_mgturret::saw_mgturretlink(var_0);
  thread maps\_colors::init_color_grouping(var_0);
}

trigger_unlock(var_0) {
  var_1 = "not_set";

  if(isDefined(var_0.script_noteworthy)) {
    var_1 = var_0.script_noteworthy;
  }
  var_2 = getEntArray(var_0.target, "targetname");
  var_0 thread trigger_unlock_death(var_0.target);

  for(;;) {
    common_scripts\utility::array_thread(var_2, common_scripts\utility::trigger_off);
    var_0 waittill("trigger");
    common_scripts\utility::array_thread(var_2, common_scripts\utility::trigger_on);
    wait_for_an_unlocked_trigger(var_2, var_1);
    maps\_utility::array_notify(var_2, "relock");
  }
}

trigger_unlock_death(var_0) {
  self waittill("death");
  var_1 = getEntArray(var_0, "targetname");
  common_scripts\utility::array_thread(var_1, common_scripts\utility::trigger_off);
}

wait_for_an_unlocked_trigger(var_0, var_1) {
  level endon("unlocked_trigger_hit" + var_1);
  var_2 = spawnStruct();

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3] thread report_trigger(var_2, var_1);
  }
  var_2 waittill("trigger");
  level notify("unlocked_trigger_hit" + var_1);
}

report_trigger(var_0, var_1) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + var_1);
  self waittill("trigger");
  var_0 notify("trigger");
}

get_trigger_targs() {
  var_0 = [];
  var_1 = undefined;

  if(isDefined(self.target)) {
    var_2 = getEntArray(self.target, "targetname");
    var_3 = [];

    foreach(var_5 in var_2) {
      if(var_5.classname == "script_origin") {
        var_3[var_3.size] = var_5;
      }
      if(issubstr(var_5.classname, "trigger")) {
        var_0[var_0.size] = var_5;
      }
    }

    var_2 = common_scripts\utility::getStructArray(self.target, "targetname");

    foreach(var_5 in var_2) {}
    var_3[var_3.size] = var_5;

    if(var_3.size == 1) {
      var_9 = var_3[0];
      var_1 = var_9.origin;

      if(isDefined(var_9.code_classname)) {
        var_9 delete();
      }
    }
  }

  var_10 = [];
  var_10["triggers"] = var_0;
  var_10["target_origin"] = var_1;
  return var_10;
}

trigger_lookat(var_0) {
  trigger_lookat_think(var_0, 1);
}

trigger_looking(var_0) {
  trigger_lookat_think(var_0, 0);
}

trigger_visionset_change(var_0) {
  var_1 = 3;

  if(isDefined(var_0.script_delay)) {
    var_1 = var_0.script_delay;
  }
  for(;;) {
    var_0 waittill("trigger");
    maps\_utility::set_vision_set(var_0.script_visionset, var_1);
    wait(var_1);
  }
}

trigger_lookat_think(var_0, var_1) {
  var_2 = 0.78;

  if(isDefined(var_0.script_dot)) {
    var_2 = var_0.script_dot;
  }
  var_3 = var_0 get_trigger_targs();
  var_4 = var_3["triggers"];
  var_5 = var_3["target_origin"];
  var_6 = isDefined(var_0.script_flag) || isDefined(var_0.script_noteworthy);
  var_7 = undefined;

  if(var_6) {
    var_7 = var_0 maps\_utility::get_trigger_flag();

    if(!isDefined(level.flag[var_7])) {
      common_scripts\utility::flag_init(var_7);
    }
  } else if(!var_4.size) {}

  if(var_1 && var_6) {
    level endon(var_7);
  }
  var_0 endon("death");
  var_8 = 0;

  if(isDefined(var_0.script_parameters)) {
    var_8 = !issubstr("no_sight", var_0.script_parameters);
  }
  for(;;) {
    if(var_6) {
      common_scripts\utility::flag_clear(var_7);
    }
    var_0 waittill("trigger", var_9);
    var_10 = [];

    while(var_9 istouching(var_0)) {
      if(var_8 && !sighttracepassed(var_9 getEye(), var_5, 0, undefined)) {
        if(var_6) {
          common_scripts\utility::flag_clear(var_7);
        }
        wait 0.5;
        continue;
      }

      var_11 = vectorNormalize(var_5 - var_9.origin);
      var_12 = var_9 getplayerangles();
      var_13 = anglesToForward(var_12);
      var_14 = vectordot(var_13, var_11);

      if(var_14 >= var_2) {
        common_scripts\utility::array_thread(var_4, maps\_utility::send_notify, "trigger");

        if(var_6) {
          common_scripts\utility::flag_set(var_7, var_9);
        }
        if(var_1) {
          return;
        }
        wait 2;
      } else if(var_6) {
        common_scripts\utility::flag_clear(var_7);
      }
      if(var_8) {
        wait 0.5;
        continue;
      }

      wait 0.05;
    }
  }
}

trigger_cansee(var_0) {
  var_1 = [];
  var_2 = undefined;
  var_3 = var_0 get_trigger_targs();
  var_1 = var_3["triggers"];
  var_2 = var_3["target_origin"];
  var_4 = isDefined(var_0.script_flag) || isDefined(var_0.script_noteworthy);
  var_5 = undefined;

  if(var_4) {
    var_5 = var_0 maps\_utility::get_trigger_flag();

    if(!isDefined(level.flag[var_5])) {
      common_scripts\utility::flag_init(var_5);
    }
  } else if(!var_1.size) {}

  var_0 endon("death");
  var_6 = 12;
  var_7 = [];
  var_7[var_7.size] = (0, 0, 0);
  var_7[var_7.size] = (var_6, 0, 0);
  var_7[var_7.size] = (var_6 * -1, 0, 0);
  var_7[var_7.size] = (0, var_6, 0);
  var_7[var_7.size] = (0, var_6 * -1, 0);
  var_7[var_7.size] = (0, 0, var_6);

  for(;;) {
    if(var_4) {
      common_scripts\utility::flag_clear(var_5);
    }
    var_0 waittill("trigger", var_8);

    while(level.player istouching(var_0)) {
      if(!var_8 cantraceto(var_2, var_7)) {
        if(var_4) {
          common_scripts\utility::flag_clear(var_5);
        }
        wait 0.1;
        continue;
      }

      if(var_4) {
        common_scripts\utility::flag_set(var_5);
      }
      common_scripts\utility::array_thread(var_1, maps\_utility::send_notify, "trigger");
      wait 0.5;
    }
  }
}

cantraceto(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(sighttracepassed(self getEye(), var_0 + var_1[var_2], 1, self)) {
      return 1;
    }
  }

  return 0;
}

indicate_start(var_0) {
  var_1 = newhudelem();
  var_1.alignx = "left";
  var_1.aligny = "middle";
  var_1.x = 10;
  var_1.y = 400;
  var_1 settext(var_0);
  var_1.alpha = 0;
  var_1.fontscale = 3;
  wait 1;
  var_1 fadeovertime(1);
  var_1.alpha = 1;
  wait 5;
  var_1 fadeovertime(1);
  var_1.alpha = 0;
  wait 1;
  var_1 destroy();
}

handle_starts() {
  common_scripts\utility::create_dvar("start", "");

  if(getDvar("scr_generateClipModels") != "" && getDvar("scr_generateClipModels") != "0") {
    return;
  }
  if(!isDefined(level.start_functions)) {
    level.start_functions = [];
  }
  var_0 = tolower(getDvar("start"));
  var_1 = get_start_dvars();

  if(isDefined(level.start_point)) {
    var_0 = level.start_point;
  }
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_0 == var_1[var_3]) {
      var_2 = var_3;
      level.start_point = var_1[var_3];
      break;
    }
  }

  if(isDefined(level.default_start_override) && !isDefined(level.start_point)) {
    foreach(var_6, var_5 in var_1) {
      if(level.default_start_override == var_5) {
        var_2 = var_6;
        level.start_point = var_5;
        break;
      }
    }
  }

  if(!isDefined(level.start_point)) {
    if(isDefined(level.default_start)) {
      level.start_point = "default";
    } else if(maps\_utility::level_has_start_points()) {
      level.start_point = level.start_functions[0]["name"];
    } else {
      level.start_point = "default";
    }
  }

  waittillframeend;
  thread start_menu();

  if(level.start_point == "default") {
    if(isDefined(level.default_start)) {
      level thread[[level.default_start]]();
    }
  } else {
    var_7 = level.start_arrays[level.start_point];
    thread[[var_7["start_func"]]]();
  }

  if(maps\_utility::is_default_start()) {
    var_8 = get_string_for_starts(var_1);
    setDvar("start", var_8);
  }

  waittillframeend;
  var_9 = [];

  for(var_3 = var_2; var_3 < level.start_functions.size; var_3++) {
    var_7 = level.start_functions[var_3];

    if(!isDefined(var_7["logic_func"])) {
      continue;
    }
    if(already_ran_function(var_7["logic_func"], var_9)) {
      continue;
    }
    [[var_7["logic_func"]]]();
    var_9[var_9.size] = var_7["logic_func"];
  }
}

already_ran_function(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

get_string_for_starts(var_0) {
  var_1 = " ** No starts have been set up for this map with maps_utility::add_start().";

  if(var_0.size) {
    var_1 = " ** ";

    for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
      var_1 = var_1 + var_0[var_2] + " ";
    }
  }

  setDvar("start", var_1);
  return var_1;
}

create_start(var_0, var_1) {
  var_2 = 1;
  var_3 = (0.9, 0.9, 0.9);

  if(var_1 != -1) {
    var_4 = 5;

    if(var_1 != var_4) {
      var_2 = 1 - abs(var_4 - var_1) / var_4;
    } else {
      var_3 = (1, 1, 0);
    }
  }

  if(var_2 == 0) {
    var_2 = 0.05;
  }
  var_5 = newhudelem();
  var_5.alignx = "left";
  var_5.aligny = "middle";
  var_5.x = 80;
  var_5.y = 80 + var_1 * 18;
  var_5 settext(var_0);
  var_5.alpha = 0;
  var_5.foreground = 1;
  var_5.color = var_3;
  var_5.fontscale = 1.75;
  var_5 fadeovertime(0.5);
  var_5.alpha = var_2;
  return var_5;
}

start_menu() {}

start_nogame() {
  common_scripts\utility::array_call(getaiarray(), ::delete);
  common_scripts\utility::array_call(getspawnerarray(), ::delete);
}

get_start_dvars() {
  var_0 = [];

  for(var_1 = 0; var_1 < level.start_functions.size; var_1++) {
    var_0[var_0.size] = level.start_functions[var_1]["name"];
  }
  return var_0;
}

display_starts() {
  level.display_starts_pressed = 1;

  if(level.start_functions.size <= 0) {
    return;
  }
  var_0 = get_start_dvars();
  var_0[var_0.size] = "default";
  var_0[var_0.size] = "cancel";
  var_1 = start_list_menu();
  var_2 = create_start("Selected Start:", -1);
  var_2.color = (1, 1, 1);
  var_3 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];
    var_6 = "[" + var_0[var_4] + "]";

    if(var_5 != "cancel" && var_5 != "default") {
      if(isDefined(level.start_arrays[var_5]["start_loc_string"])) {
        var_6 = var_6 + " -> ";
        var_6 = var_6 + level.start_arrays[var_5]["start_loc_string"];
      }
    }

    var_3[var_3.size] = var_6;
  }

  var_7 = var_0.size - 1;
  var_8 = 0;
  var_9 = 0;

  for(var_10 = 0; var_7 > 0; var_7--) {
    if(var_0[var_7] == level.start_point) {
      var_10 = 1;
      break;
    }
  }

  if(!var_10) {
    var_7 = var_0.size - 1;
  }
  start_list_settext(var_1, var_3, var_7);
  var_11 = var_7;

  for(;;) {
    if(!level.player buttonPressed("F10")) {
      level.display_starts_pressed = 0;
    }
    if(var_11 != var_7) {
      start_list_settext(var_1, var_3, var_7);
      var_11 = var_7;
    }

    if(!var_8) {
      if(level.player buttonPressed("UPARROW") || level.player buttonPressed("DPAD_UP") || level.player buttonPressed("APAD_UP")) {
        var_8 = 1;
        var_7--;
      }
    } else if(!level.player buttonPressed("UPARROW") && !level.player buttonPressed("DPAD_UP") && !level.player buttonPressed("APAD_UP")) {
      var_8 = 0;
    }
    if(!var_9) {
      if(level.player buttonPressed("DOWNARROW") || level.player buttonPressed("DPAD_DOWN") || level.player buttonPressed("APAD_DOWN")) {
        var_9 = 1;
        var_7++;
      }
    } else if(!level.player buttonPressed("DOWNARROW") && !level.player buttonPressed("DPAD_DOWN") && !level.player buttonPressed("APAD_DOWN")) {
      var_9 = 0;
    }
    if(var_7 < 0) {
      var_7 = var_0.size - 1;
    }
    if(var_7 >= var_0.size) {
      var_7 = 0;
    }
    if(level.player buttonPressed("BUTTON_B")) {
      start_display_cleanup(var_1, var_2);
      break;
    }

    if(level.player buttonPressed("kp_enter") || level.player buttonPressed("BUTTON_A") || level.player buttonPressed("enter")) {
      if(var_0[var_7] == "cancel") {
        start_display_cleanup(var_1, var_2);
        break;
      }

      setDvar("start", var_0[var_7]);
      level.player openpopupmenu("start");
    }

    wait 0.05;
  }
}

start_list_menu() {
  var_0 = [];

  for(var_1 = 0; var_1 < 11; var_1++) {
    var_2 = create_start("", var_1);
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

start_list_settext(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_3 + (var_2 - 5);

    if(isDefined(var_1[var_4])) {
      var_5 = var_1[var_4];
    } else {
      var_5 = "";
    }
    var_0[var_3] settext(var_5);
  }
}

start_display_cleanup(var_0, var_1) {
  var_1 destroy();

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] destroy();
  }
}

devhelp_hudelements(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    for(var_3 = 0; var_3 < 5; var_3++) {
      var_0[var_2][var_3].alpha = var_1;
    }
  }
}

devhelp() {}

flag_set_player_trigger(var_0) {
  if(maps\_utility::is_coop()) {
    thread flag_set_coop_trigger(var_0);
    return;
  }

  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_set(var_1);
  }
}

trigger_nobloodpool(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isalive(var_1)) {
      continue;
    }
    var_1.skipbloodpool = 1;
    var_1 thread set_wait_then_clear_skipbloodpool();
  }
}

set_wait_then_clear_skipbloodpool() {
  self notify("notify_wait_then_clear_skipBloodPool");
  self endon("notify_wait_then_clear_skipBloodPool");
  self endon("death");
  wait 2;
  self.skipbloodpool = undefined;
}

sun_on(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(getdvarint("sm_sunenable") == 1) {
      continue;
    }
    setsaveddvar("sm_sunenable", 1);
  }
}

sun_off(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(getdvarint("sm_sunenable") == 0) {
      continue;
    }
    setsaveddvar("sm_sunenable", 0);
  }
}

flag_set_trigger(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_set(var_1, var_2);
  }
}

flag_set_trigger_specialops(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  var_0.player_touched_arr = level.players;
  var_0 thread flag_set_trigger_specialops_clear(var_1);

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0.player_touched_arr = common_scripts\utility::array_remove(var_0.player_touched_arr, var_2);

    if(var_0.player_touched_arr.size) {
      continue;
    }
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_set(var_1, var_2);
  }
}

flag_set_trigger_specialops_clear(var_0) {
  for(;;) {
    level waittill(var_0);

    if(common_scripts\utility::flag(var_0)) {
      self.player_touched_arr = [];
      continue;
    }

    self.player_touched_arr = level.players;
  }
}

trigger_damage_player_flag_set(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isalive(var_2)) {
      continue;
    }
    if(!isPlayer(var_2)) {
      continue;
    }
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_set(var_1, var_2);
  }
}

flag_set_coop_trigger(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  var_2 = [];

  for(;;) {
    var_0 waittill("trigger", var_3);

    if(!isPlayer(var_3)) {
      continue;
    }
    var_4 = [];
    var_4[var_4.size] = var_3;
    var_2 = maps\_utility::array_merge(var_2, var_4);

    if(var_2.size == level.players.size) {
      break;
    }
  }

  var_0 maps\_utility::script_delay();
  common_scripts\utility::flag_set(var_1);
}

flag_unset_trigger(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  for(;;) {
    var_0 waittill("trigger");
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_clear(var_1);
  }
}

eq_trigger(var_0) {
  level.set_eq_func[1] = ::set_eq_on;
  level.set_eq_func[0] = ::set_eq_off;
  var_1 = getEnt(var_0.target, "targetname");

  for(;;) {
    var_0 waittill("trigger");
    var_2 = getaiarray("allies");

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2[var_3][[level.set_eq_func[var_2[var_3] istouching(var_1)]]]();
    }
    while(level.player istouching(var_0)) {
      wait 0.05;
    }
    var_2 = getaiarray("allies");

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2[var_3][[level.set_eq_func[0]]]();
    }
  }
}

player_ignores_triggers() {
  self endon("death");
  self.ignoretriggers = 1;
  wait 1;
  self.ignoretriggers = 0;
}

get_trigger_eq_nums(var_0) {
  var_1 = [];
  var_1[0] = var_0;

  for(var_2 = 0; var_2 < level.eq_trigger_table[var_0].size; var_2++) {
    var_1[var_1.size] = level.eq_trigger_table[var_0][var_2];
  }
  return var_1;
}

player_touched_eq_trigger(var_0, var_1) {
  self endon("death");
  var_2 = get_trigger_eq_nums(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    self.eq_table[var_2[var_3]] = 1;
    self.eq_touching[var_2[var_3]] = 1;
  }

  thread player_ignores_triggers();
  var_4 = getaiarray();

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_5];

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(var_6.eq_table[var_2[var_3]]) {
        var_6 eqoff();
        break;
      }
    }
  }

  while(self istouching(var_1)) {
    wait 0.05;
  }
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    self.eq_table[var_2[var_3]] = 0;
    self.eq_touching[var_2[var_3]] = undefined;
  }

  var_4 = getaiarray();

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_5];
    var_7 = 0;

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(var_6.eq_table[var_2[var_3]]) {
        var_7 = 1;
      }
    }

    if(!var_7) {
      continue;
    }
    var_8 = getarraykeys(self.eq_touching);
    var_9 = 0;

    for(var_10 = 0; var_10 < var_8.size; var_10++) {
      if(!var_6.eq_table[var_8[var_10]]) {
        continue;
      }
      var_9 = 1;
      break;
    }

    if(!var_9) {
      var_6 eqon();
    }
  }
}

ai_touched_eq_trigger(var_0, var_1) {
  self endon("death");
  var_2 = get_trigger_eq_nums(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    self.eq_table[var_2[var_3]] = 1;
    self.eq_touching[var_2[var_3]] = 1;
  }

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(level.player.eq_table[var_2[var_3]]) {
      self eqoff();
      break;
    }
  }

  self.ignoretriggers = 1;
  wait 1;
  self.ignoretriggers = 0;

  while(self istouching(var_1)) {
    wait 0.5;
  }
  var_2 = get_trigger_eq_nums(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    self.eq_table[var_2[var_3]] = 0;
    self.eq_touching[var_2[var_3]] = undefined;
  }

  var_4 = getarraykeys(self.eq_touching);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(level.player.eq_table[var_4[var_5]]) {
      return;
    }
  }

  self eqon();
}

ai_eq() {
  level.set_eq_func[0] = ::set_eq_on;
  level.set_eq_func[1] = ::set_eq_off;
  var_0 = 0;

  for(;;) {
    while(!level.ai_array.size) {
      wait 0.05;
    }
    waittillframeend;
    waittillframeend;
    var_1 = getarraykeys(level.ai_array);
    var_0++;

    if(var_0 >= var_1.size) {
      var_0 = 0;
    }
    var_2 = level.ai_array[var_1[var_0]];
    var_2[[level.set_eq_func[sighttracepassed(level.player getEye(), var_2 getEye(), 0, undefined)]]]();
    wait 0.05;
  }
}

set_eq_on() {
  self eqon();
}

set_eq_off() {
  self eqoff();
}

add_tokens_to_trigger_flags(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(level.trigger_flags[var_2])) {
      level.trigger_flags[var_2] = [];
    }
    level.trigger_flags[var_2][level.trigger_flags[var_2].size] = self;
  }
}

script_flag_false_trigger(var_0) {
  var_1 = common_scripts\utility::create_flags_and_return_tokens(var_0.script_flag_false);
  var_0 add_tokens_to_trigger_flags(var_1);
  var_0 common_scripts\utility::update_trigger_based_on_flags();
}

script_flag_true_trigger(var_0) {
  var_1 = common_scripts\utility::create_flags_and_return_tokens(var_0.script_flag_true);
  var_0 add_tokens_to_trigger_flags(var_1);
  var_0 common_scripts\utility::update_trigger_based_on_flags();
}

wait_for_flag(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    level endon(var_0[var_1]);
  }
  level waittill("foreverrr");
}

trigger_multiple_physics(var_0) {
  var_1 = [];
  var_2 = common_scripts\utility::getStructArray(var_0.target, "targetname");
  var_3 = getEntArray(var_0.target, "targetname");

  foreach(var_5 in var_3) {
    var_6 = spawnStruct();
    var_6.origin = var_5.origin;
    var_6.script_parameters = var_5.script_parameters;
    var_6.script_damage = var_5.script_damage;
    var_6.radius = var_5.radius;
    var_2[var_2.size] = var_6;
    var_5 delete();
  }

  var_0.org = var_2[0].origin;
  var_0 waittill("trigger");
  var_0 maps\_utility::script_delay();

  foreach(var_6 in var_2) {
    var_9 = var_6.radius;
    var_10 = var_6.script_parameters;
    var_11 = var_6.script_damage;

    if(!isDefined(var_9)) {
      var_9 = 350;
    }
    if(!isDefined(var_10)) {
      var_10 = 0.25;
    }
    setDvar("tempdvar", var_10);
    var_10 = getdvarfloat("tempdvar");

    if(isDefined(var_11)) {
      radiusdamage(var_6.origin, var_9, var_11, var_11 * 0.5);
    }
    physicsexplosionsphere(var_6.origin, var_9, var_9 * 0.5, var_10);
  }
}

trigger_multiple_friendly_stop_respawn(var_0) {
  for(;;) {
    var_0 waittill("trigger");
    common_scripts\utility::flag_clear("respawn_friendlies");
  }
}

trigger_multiple_friendly_respawn(var_0) {
  var_0 endon("death");
  var_1 = getEnt(var_0.target, "targetname");
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = var_1.origin;
    var_1 delete();
  } else {
    var_1 = common_scripts\utility::getStruct(var_0.target, "targetname");
    var_2 = var_1.origin;
  }

  for(;;) {
    var_0 waittill("trigger");
    level.respawn_spawner_org = var_2;
    common_scripts\utility::flag_set("respawn_friendlies");
    wait 0.5;
  }
}

friendly_respawn_clear(var_0) {
  for(;;) {
    var_0 waittill("trigger");
    common_scripts\utility::flag_clear("respawn_friendlies");
    wait 0.5;
  }
}

trigger_multiple_do_radius_damage(var_0) {
  var_0 waittill("trigger");
  var_0 do_radius_damage_from_target();
}

do_radius_damage_from_target() {
  var_0 = 80;

  if(isDefined(self.radius)) {
    var_0 = self.radius;
  }
  var_1 = maps\_utility::get_all_target_ents();

  foreach(var_3 in var_1) {}
  radiusdamage(var_3.origin, var_0, 5000, 5000);

  self delete();
}

trigger_damage_do_radius_damage(var_0) {
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(!isalive(var_2)) {
      continue;
    }
    if(distance(var_2.origin, var_0.origin) > 940) {
      continue;
    }
    break;
  }

  var_0 do_radius_damage_from_target();
}

radio_trigger(var_0) {
  var_0 waittill("trigger");
  maps\_utility::radio_dialogue(var_0.script_noteworthy);
}

background_block() {
  self.origin = self.origin - self.script_bg_offset;
}

trigger_ignore(var_0) {
  thread trigger_runs_function_on_touch(var_0, maps\_utility::set_ignoreme, maps\_utility::get_ignoreme);
}

trigger_pacifist(var_0) {
  thread trigger_runs_function_on_touch(var_0, maps\_utility::set_pacifist, maps\_utility::get_pacifist);
}

trigger_runs_function_on_touch(var_0, var_1, var_2) {
  for(;;) {
    var_0 waittill("trigger", var_3);

    if(!isalive(var_3)) {
      continue;
    }
    if(var_3[[var_2]]()) {
      continue;
    }
    var_3 thread touched_trigger_runs_func(var_0, var_1);
  }
}

touched_trigger_runs_func(var_0, var_1) {
  self endon("death");
  self.ignoreme = 1;
  [[var_1]](1);
  self.ignoretriggers = 1;
  wait 1;
  self.ignoretriggers = 0;

  while(self istouching(var_0)) {
    wait 1;
  }
  [[var_1]](0);
}

trigger_turns_off(var_0) {
  var_0 waittill("trigger");
  var_0 common_scripts\utility::trigger_off();

  if(!isDefined(var_0.script_linkto)) {
    return;
  }
  var_1 = strtok(var_0.script_linkto, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    common_scripts\utility::array_thread(getEntArray(var_1[var_2], "script_linkname"), common_scripts\utility::trigger_off);
  }
}

set_player_viewhand_model(var_0) {
  level.player_viewhand_model = var_0;
  precachemodel(level.player_viewhand_model);
}

trigger_hint(var_0) {
  if(!isDefined(level.displayed_hints)) {
    level.displayed_hints = [];
  }
  waittillframeend;
  var_1 = var_0.script_hint;
  var_0 waittill("trigger", var_2);

  if(isDefined(level.displayed_hints[var_1])) {
    return;
  }
  level.displayed_hints[var_1] = 1;
  var_2 maps\_utility::display_hint(var_1);
}

stun_test() {
  if(getDvar("stuntime") == "") {
    setDvar("stuntime", "1");
  }
  level.player.allowads = 1;

  for(;;) {
    self waittill("damage");

    if(getdvarint("stuntime") == 0) {
      continue;
    }
    thread stun_player(self playerads());
  }
}

stun_player(var_0) {
  self notify("stun_player");
  self endon("stun_player");

  if(var_0 > 0.3) {
    if(level.player.allowads == 1) {
      level.player playSound("player_hit_while_ads");
    }
    level.player.allowads = 0;
    level.player allowads(0);
  }

  level.player setspreadoverride(20);
  wait(getdvarint("stuntime"));
  level.player allowads(1);
  level.player.allowads = 1;
  level.player resetspreadoverride();
}

throw_grenade_at_player_trigger(var_0) {
  var_0 endon("death");
  var_0 waittill("trigger");
  maps\_utility::throwgrenadeatplayerasap();
}

flag_on_cleared(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  for(;;) {
    var_0 waittill("trigger");
    wait 1;

    if(var_0 found_toucher()) {
      continue;
    }
    break;
  }

  common_scripts\utility::flag_set(var_1);
}

found_toucher() {
  var_0 = getaiarray("bad_guys");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isalive(var_2)) {
      continue;
    }
    if(var_2 istouching(self)) {
      return 1;
    }
    wait 0.1;
  }

  var_0 = getaiarray("bad_guys");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2 istouching(self)) {
      return 1;
    }
  }

  return 0;
}

trigger_delete_on_touch(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

flag_set_touching(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 maps\_utility::script_delay();

    if(isalive(var_2) && var_2 istouching(var_0) && isDefined(var_0)) {
      common_scripts\utility::flag_set(var_1);
    }
    while(isalive(var_2) && var_2 istouching(var_0) && isDefined(var_0)) {
      wait 0.25;
    }
    common_scripts\utility::flag_clear(var_1);
  }
}

setobjectivetextcolors() {
  var_0 = "1.0 1.0 1.0";
  var_1 = "0.9 0.9 0.9";
  var_2 = "0.85 0.85 0.85";

  if(level.script == "armada") {
    setsaveddvar("con_typewriterColorBase", var_1);
    return;
  }

  setsaveddvar("con_typewriterColorBase", var_0);
}

ammo_pickup(var_0) {
  var_1 = [];

  if(var_0 == "grenade_launcher") {
    var_1[var_1.size] = "alt_m4_grenadier";
    var_1[var_1.size] = "alt_m4m203_acog";
    var_1[var_1.size] = "alt_m4m203_acog_payback";
    var_1[var_1.size] = "alt_m4m203_eotech";
    var_1[var_1.size] = "alt_m4m203_motion_tracker";
    var_1[var_1.size] = "alt_m4m203_reflex";
    var_1[var_1.size] = "alt_m4m203_reflex_arctic";
    var_1[var_1.size] = "alt_m4m203_silencer";
    var_1[var_1.size] = "alt_m4m203_silencer_reflex";
    var_1[var_1.size] = "alt_m16_grenadier";
    var_1[var_1.size] = "alt_ak47_grenadier";
    var_1[var_1.size] = "alt_ak47_desert_grenadier";
    var_1[var_1.size] = "alt_ak47_digital_grenadier";
    var_1[var_1.size] = "alt_ak47_fall_grenadier";
    var_1[var_1.size] = "alt_ak47_woodland_grenadier";
  } else if(var_0 == "rpg") {
    var_1[var_1.size] = "rpg";
    var_1[var_1.size] = "rpg_player";
    var_1[var_1.size] = "rpg_straight";
  } else if(var_0 == "c4") {
    var_1[var_1.size] = "c4";
  } else if(var_0 == "claymore") {
    var_1[var_1.size] = "claymore";
  } else if(var_0 == "556") {
    var_1[var_1.size] = "m4_grenadier";
    var_1[var_1.size] = "m4_grunt";
    var_1[var_1.size] = "m4_sd_cloth";
    var_1[var_1.size] = "m4_shotgun";
    var_1[var_1.size] = "m4_silencer";
    var_1[var_1.size] = "m4_silencer_acog";
    var_1[var_1.size] = "m4m203_acog";
    var_1[var_1.size] = "m4m203_acog_payback";
    var_1[var_1.size] = "m4m203_eotech";
    var_1[var_1.size] = "m4m203_motion_tracker";
    var_1[var_1.size] = "m4m203_reflex";
    var_1[var_1.size] = "m4m203_reflex_arctic";
    var_1[var_1.size] = "m4m203_silencer";
    var_1[var_1.size] = "m4m203_silencer_reflex";
    var_1[var_1.size] = "m4m203_silencer";
  } else if(var_0 == "762") {
    var_1[var_1.size] = "ak47";
    var_1[var_1.size] = "ak47_acog";
    var_1[var_1.size] = "ak47_eotech";
    var_1[var_1.size] = "ak47_grenadier";
    var_1[var_1.size] = "ak47_reflex";
    var_1[var_1.size] = "ak47_shotgun";
    var_1[var_1.size] = "ak47_silencer";
    var_1[var_1.size] = "ak47_thermal";
    var_1[var_1.size] = "ak47_desert";
    var_1[var_1.size] = "ak47_desert_acog";
    var_1[var_1.size] = "ak47_desert_eotech";
    var_1[var_1.size] = "ak47_desert_grenadier";
    var_1[var_1.size] = "ak47_desert_reflex";
    var_1[var_1.size] = "ak47_digital";
    var_1[var_1.size] = "ak47_digital_acog";
    var_1[var_1.size] = "ak47_digital_eotech";
    var_1[var_1.size] = "ak47_digital_grenadier";
    var_1[var_1.size] = "ak47_digital_reflex";
    var_1[var_1.size] = "ak47_fall";
    var_1[var_1.size] = "ak47_fall_acog";
    var_1[var_1.size] = "ak47_fall_eotech";
    var_1[var_1.size] = "ak47_fall_grenadier";
    var_1[var_1.size] = "ak47_fall_reflex";
    var_1[var_1.size] = "ak47_woodland";
    var_1[var_1.size] = "ak47_woodland_acog";
    var_1[var_1.size] = "ak47_woodland_eotech";
    var_1[var_1.size] = "ak47_woodland_grenadier";
    var_1[var_1.size] = "ak47_woodland_reflex";
  } else if(var_0 == "45") {
    var_1[var_1.size] = "ump45";
    var_1[var_1.size] = "ump45_acog";
    var_1[var_1.size] = "ump45_eotech";
    var_1[var_1.size] = "ump45_reflex";
    var_1[var_1.size] = "ump45_silencer";
    var_1[var_1.size] = "ump45_arctic";
    var_1[var_1.size] = "ump45_arctic_acog";
    var_1[var_1.size] = "ump45_arctic_eotech";
    var_1[var_1.size] = "ump45_arctic_reflex";
    var_1[var_1.size] = "ump45_digital";
    var_1[var_1.size] = "ump45_digital_acog";
    var_1[var_1.size] = "ump45_digital_eotech";
    var_1[var_1.size] = "ump45_digital_reflex";
  } else if(var_0 == "pistol") {
    var_1[var_1.size] = "beretta";
    var_1[var_1.size] = "beretta393";
    var_1[var_1.size] = "usp";
    var_1[var_1.size] = "usp_scripted";
    var_1[var_1.size] = "usp_silencer";
    var_1[var_1.size] = "glock";
  }

  var_2 = spawn("trigger_radius", self.origin, 0, 25, 32);

  for(;;) {
    common_scripts\utility::flag_wait("allow_ammo_pickups");
    var_2 waittill("trigger", var_3);

    if(!common_scripts\utility::flag("allow_ammo_pickups")) {
      continue;
    }
    if(!isDefined(var_3)) {
      continue;
    }
    if(!isPlayer(var_3)) {
      continue;
    }
    var_4 = undefined;
    var_5 = undefined;
    var_6 = var_3 getweaponslistall();

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      for(var_8 = 0; var_8 < var_1.size; var_8++) {
        if(var_6[var_7] == var_1[var_8]) {
          var_4 = var_6[var_7];
        }
      }
    }

    if(!isDefined(var_4) && var_0 == "claymore") {
      var_5 = 1;
      var_4 = "claymore";
      break;
    }

    if(!isDefined(var_4) && var_0 == "c4") {
      var_5 = 1;
      var_4 = "c4";
      break;
    }

    if(!isDefined(var_4)) {
      continue;
    }
    if(var_3 getfractionmaxammo(var_4) >= 1) {
      continue;
    }
    break;
  }

  if(isDefined(var_5)) {
    var_3 giveweapon(var_4);
  } else {
    var_9 = 1;

    if(var_0 == "556" || var_0 == "762") {
      var_9 = 30;
    } else if(var_0 == "45") {
      var_9 = 25;
    } else if(var_0 == "pistol") {
      var_9 = 15;
    }
    var_3 setweaponammostock(var_4, var_3 getweaponammostock(var_4) + var_9);
  }

  var_3 playlocalsound("grenade_pickup");
  var_2 delete();

  if(isDefined(self)) {
    self delete();
  }
}

get_script_linkto_targets() {
  var_0 = [];

  if(!isDefined(self.script_linkto)) {
    return var_0;
  }
  var_1 = strtok(self.script_linkto, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = getEnt(var_3, "script_linkname");

    if(isDefined(var_4)) {
      var_0[var_0.size] = var_4;
    }
  }

  return var_0;
}

delete_link_chain(var_0) {
  var_0 waittill("trigger");
  var_1 = var_0 get_script_linkto_targets();
  common_scripts\utility::array_thread(var_1, ::delete_links_then_self);
}

delete_links_then_self() {
  var_0 = get_script_linkto_targets();
  common_scripts\utility::array_thread(var_0, ::delete_links_then_self);
  self delete();
}

trigger_fog(var_0) {
  waittillframeend;
  var_1 = var_0.script_fogset_start;
  var_2 = var_0.script_fogset_end;
  var_0.sunfog_enabled = 0;

  if(isDefined(var_1) && isDefined(var_2)) {
    var_3 = maps\_utility::get_fog(var_1);
    var_4 = maps\_utility::get_fog(var_2);
    var_0.start_neardist = var_3.startdist;
    var_0.start_fardist = var_3.halfwaydist;
    var_0.start_color = (var_3.red, var_3.green, var_3.blue);
    var_0.start_opacity = var_3.maxopacity;
    var_0.sunfog_enabled = isDefined(var_3.sunred) || isDefined(var_4.sunred);

    if(isDefined(var_3.sunred)) {
      var_0.start_suncolor = (var_3.sunred, var_3.sungreen, var_3.sunblue);
      var_0.start_sundir = var_3.sundir;
      var_0.start_sunbeginfadeangle = var_3.sunbeginfadeangle;
      var_0.start_sunendfadeangle = var_3.sunendfadeangle;
      var_0.start_sunfogscale = var_3.normalfogscale;
    } else if(var_0.sunfog_enabled) {
      var_0.start_suncolor = var_0.start_color;
      var_0.start_sundir = (0, 0, 0);
      var_0.start_sunbeginfadeangle = 0;
      var_0.start_sunendfadeangle = 90;
      var_0.start_sunfogscale = 1;
    }

    var_0.end_neardist = var_4.startdist;
    var_0.end_fardist = var_4.halfwaydist;
    var_0.end_color = (var_3.red, var_3.green, var_3.blue);
    var_0.end_opacity = var_4.maxopacity;

    if(isDefined(var_4.sunred)) {
      var_0.end_suncolor = (var_4.sunred, var_4.sungreen, var_4.sunblue);
      var_0.end_sundir = var_4.sundir;
      var_0.end_sunbeginfadeangle = var_4.sunbeginfadeangle;
      var_0.end_sunendfadeangle = var_4.sunendfadeangle;
      var_0.end_sunfogscale = var_4.normalfogscale;
    } else if(var_0.sunfog_enabled) {
      var_0.end_suncolor = var_0.end_color;
      var_0.end_sundir = (0, 0, 0);
      var_0.end_sunbeginfadeangle = 0;
      var_0.end_sunendfadeangle = 90;
      var_0.end_sunfogscale = 1;
    }
  }

  var_5 = getEnt(var_0.target, "targetname");
  var_6 = var_5.origin;
  var_7 = undefined;

  if(isDefined(var_5.target)) {
    var_8 = getEnt(var_5.target, "targetname");
    var_7 = var_8.origin;
  } else {
    var_7 = var_6 + (var_0.origin - var_6) * 2;
  }
  var_9 = distance(var_6, var_7);

  for(;;) {
    var_0 waittill("trigger", var_10);
    var_11 = 0;

    while(var_10 istouching(var_0)) {
      var_11 = maps\_utility::get_progress(var_6, var_7, var_10.origin, var_9);
      var_11 = clamp(var_11, 0, 1);
      var_0 set_fog_progress(var_11);
      wait 0.05;
    }

    if(var_11 > 0.5) {
      var_11 = 1;
    } else {
      var_11 = 0;
    }
    var_0 set_fog_progress(var_11);
  }
}

set_fog_progress(var_0) {
  var_1 = 1 - var_0;
  var_2 = self.start_neardist * var_1 + self.end_neardist * var_0;
  var_3 = self.start_fardist * var_1 + self.end_fardist * var_0;
  var_4 = self.start_color * var_1 + self.end_color * var_0;
  var_5 = self.start_opacity;
  var_6 = self.end_opacity;

  if(!isDefined(var_5)) {
    var_5 = 1;
  }
  if(!isDefined(var_6)) {
    var_6 = 1;
  }
  var_7 = var_5 * var_1 + var_6 * var_0;

  if(self.sunfog_enabled) {
    var_8 = self.start_suncolor * var_1 + self.end_suncolor * var_0;
    var_9 = self.start_sundir * var_1 + self.end_sundir * var_0;
    var_10 = self.start_sunbeginfadeangle * var_1 + self.end_sunbeginfadeangle * var_0;
    var_11 = self.start_sunendfadeangle * var_1 + self.end_sunendfadeangle * var_0;
    var_12 = self.start_sunfogscale * var_1 + self.end_sunfogscale * var_0;
    setexpfog(var_2, var_3, var_4[0], var_4[1], var_4[2], var_7, 0.4, var_8[0], var_8[1], var_8[2], var_9, var_10, var_11, var_12);
  } else {
    setexpfog(var_2, var_3, var_4[0], var_4[1], var_4[2], var_7, 0.4);
  }
}

remove_level_first_frame() {
  wait 0.05;
  level.first_frame = -1;
}

no_crouch_or_prone_think(var_0) {
  common_scripts\utility::array_thread(level.players, ::no_crouch_or_prone_think_for_player, var_0);
}

no_crouch_or_prone_think_for_player(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 != self) {
      continue;
    }
    while(var_1 istouching(var_0)) {
      var_1 allowprone(0);
      var_1 allowcrouch(0);
      wait 0.05;
    }

    var_1 allowprone(1);
    var_1 allowcrouch(1);
  }
}

no_prone_think(var_0) {
  common_scripts\utility::array_thread(level.players, ::no_prone_think_for_player, var_0);
}

no_prone_think_for_player(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 != self) {
      continue;
    }
    while(var_1 istouching(var_0)) {
      var_1 allowprone(0);
      wait 0.05;
    }

    var_1 allowprone(1);
  }
}

load_friendlies() {
  if(isDefined(game["total characters"])) {
    var_0 = game["total characters"];
  } else {
    return;
  }
  var_1 = getaiarray("allies");
  var_2 = var_1.size;
  var_3 = 0;
  var_4 = getspawnerteamarray("allies");
  var_5 = var_4.size;
  var_6 = 0;

  for(;;) {
    if(var_2 <= 0 && var_5 <= 0 || var_0 <= 0) {
      return;
    }
    if(var_2 > 0) {
      if(isDefined(var_1[var_3].script_friendname)) {
        var_2--;
        var_3++;
        continue;
      }

      var_1[var_3] codescripts\character::new();
      var_1[var_3] thread codescripts\character::load(game["character" + (var_0 - 1)]);
      var_2--;
      var_3++;
      var_0--;
      continue;
    }

    if(var_5 > 0) {
      if(isDefined(var_4[var_6].script_friendname)) {
        var_5--;
        var_6++;
        continue;
      }

      var_7 = game["character" + (var_0 - 1)];
      maps\_utility::precache(var_7["model"]);
      maps\_utility::precache(var_7["model"]);
      var_4[var_6] thread maps\_utility::spawn_setcharacter(game["character" + (var_0 - 1)]);
      var_5--;
      var_6++;
      var_0--;
      continue;
    }
  }
}

check_flag_for_stat_tracking(var_0) {
  if(!common_scripts\utility::issuffix(var_0, "aa_")) {
    return;
  }
  [[level.sp_stat_tracking_func]](var_0);
}

precache_script_models() {
  waittillframeend;

  if(!isDefined(level.scr_model)) {
    return;
  }
  var_0 = getarraykeys(level.scr_model);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isarray(level.scr_model[var_0[var_1]])) {
      for(var_2 = 0; var_2 < level.scr_model[var_0[var_1]].size; var_2++) {
        precachemodel(level.scr_model[var_0[var_1]][var_2]);
      }
      continue;
    }

    precachemodel(level.scr_model[var_0[var_1]]);
  }
}

arcademode_save() {
  var_0 = [];
  var_0["cargoship"] = 1;
  var_0["blackout"] = 1;
  var_0["armada"] = 1;
  var_0["bog_a"] = 1;
  var_0["hunted"] = 1;
  var_0["ac130"] = 1;
  var_0["bog_b"] = 1;
  var_0["airlift"] = 1;
  var_0["village_assault"] = 1;
  var_0["scoutsniper"] = 1;
  var_0["ambush"] = 1;
  var_0["sniperescape"] = 0;
  var_0["village_defend"] = 0;
  var_0["icbm"] = 1;
  var_0["launchfacility_a"] = 1;
  var_0["launchfacility_b"] = 0;
  var_0["jeepride"] = 0;
  var_0["airplane"] = 1;

  if(var_0[level.script]) {
    return;
  }
  wait 2.5;
  var_1 = "levelshots / autosave / autosave_" + level.script + "start";
  savegame("levelstart", &"AUTOSAVE_LEVELSTART", var_1, 1);
}

player_death_detection() {
  setDvar("player_died_recently", "0");
  thread player_died_recently_degrades();
  level maps\_utility::add_wait(common_scripts\utility::flag_wait, "missionfailed");
  level.player maps\_utility::add_wait(maps\_utility::waittill_msg, "death");
  maps\_utility::do_wait_any();
  var_0 = [];
  var_0[0] = 70;
  var_0[1] = 30;
  var_0[2] = 0;
  var_0[3] = 0;
  setDvar("player_died_recently", var_0[level.gameskill]);
}

player_died_recently_degrades() {
  for(;;) {
    var_0 = getdvarint("player_died_recently", 0);

    if(var_0 > 0) {
      var_0 = var_0 - 5;
      setDvar("player_died_recently", var_0);
    }

    wait 5;
  }
}

trigger_spawngroup(var_0) {
  waittillframeend;
  var_1 = var_0.script_spawngroup;

  if(!isDefined(level.spawn_groups[var_1])) {
    return;
  }
  var_0 waittill("trigger");
  var_2 = common_scripts\utility::random(level.spawn_groups[var_1]);

  foreach(var_5, var_4 in var_2) {}
  var_4 maps\_utility::spawn_ai();
}

recon_player() {
  self notify("new_recon_player");
  self endon("new_recon_player");
  self waittill("death", var_0, var_1, var_2);

  if(!isDefined(var_2)) {
    var_2 = "script_kill";
  }
  var_3 = 0;
  var_4 = "none";
  var_5 = (0, 0, 0);

  if(isDefined(var_0)) {
    var_4 = var_0.classname;
    var_5 = var_0.origin;
    var_6 = vectorNormalize(var_5 - self.origin);
    var_7 = anglesToForward(self getplayerangles());
    var_3 = vectordot(var_6, var_7);
  }

  reconspatialevent(self.origin, "script_player_death: playerid %s, enemy %s, enemyposition %v, enemydotproduct %f, cause %s, weapon %s", self.unique_id, var_4, var_5, var_3, var_1, var_2);

  if(isDefined(var_0)) {
    reconspatialevent(var_0.origin, "script_player_killer: playerid %s, enemy %s, playerposition %v, enemydotproduct %f, cause %s, weapon %s", self.unique_id, var_4, self.origin, var_3, var_1, var_2);
  }
}

recon_player_downed() {
  self notify("new_player_downed_recon");
  self endon("new_player_downed_recon");
  self endon("death");

  for(;;) {
    self waittill("player_downed");
    var_0 = getlevelticks() * 0.05;
    var_1 = var_0;

    if(isDefined(self.last_downed_time)) {
      var_0 = var_1 - self.last_downed_time;
    }
    self.last_downed_time = var_1;
    reconspatialevent(self.origin, "script_player_downed: playerid %s, leveltime %d, deltatime %d", self.unique_id, var_1, var_0);
  }
}

init_level_players() {
  level.players = getEntArray("player", "classname");

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0].unique_id = "player" + var_0;
  }
  level.player = level.players[0];

  if(level.players.size > 1) {
    level.player2 = level.players[1];
  }
  level notify("level.players initialized");

  foreach(var_2 in level.players) {
    var_2 thread recon_player();

    if(maps\_utility::is_specialop()) {
      var_2 thread recon_player_downed();
    }
  }
}

kill_all_players_trigger() {
  self waittill("trigger", var_0);
  maps\_utility::kill_wrapper();
}

trigger_vehicle_spline_spawn(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 thread maps\_vehicle::spawn_vehicle_and_attach_to_spline_path(70);
    wait 0.05;
  }
}

trigger_vehicle_spawn(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 thread maps\_vehicle::spawn_vehicle_and_gopath();
    wait 0.05;
  }
}

trigger_dooropen(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = [];
  var_2["left_door"] = -170;
  var_2["right_door"] = 170;

  foreach(var_4 in var_1) {
    var_5 = var_2[var_4.script_noteworthy];
    var_4 connectpaths();
    var_4 rotateYaw(var_5, 1, 0, 0.5);
  }
}

trigger_glass_break(var_0) {
  var_1 = getglassarray(var_0.target);

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  for(;;) {
    level waittill("glass_break", var_2);

    if(var_2 istouching(var_0)) {
      var_3 = var_2.origin;
      wait 0.05;
      var_4 = var_2.origin;
      var_5 = undefined;

      if(var_3 != var_4) {
        var_5 = var_4 - var_3;
      }
      if(isDefined(var_5)) {
        foreach(var_7 in var_1) {}
        destroyglass(var_7, var_5);

        break;
      } else {
        foreach(var_7 in var_1) {}
        destroyglass(var_7);

        break;
      }
    }
  }

  var_0 delete();
}

trigger_vehicle_getin_spawn(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_4 = getEntArray(var_3.target, "targetname");

    foreach(var_6 in var_4) {
      if(!issubstr(var_6.code_classname, "actor")) {
        continue;
      }
      if(!(var_6.spawnflags & 1)) {
        continue;
      }
      var_6.dont_auto_ride = 1;
    }
  }

  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::vehicle_spawns_targets_and_rides);
  common_scripts\utility::array_thread(var_1, maps\_utility::spawn_vehicle);
}

vehicle_spawns_targets_and_rides() {
  var_0 = getEntArray(self.target, "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.code_classname == "info_vehicle_node") {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_1 = maps\_utility::get_array_of_closest(self.origin, var_1);

  foreach(var_7, var_6 in var_1) {}
  var_6 thread maps\_utility::add_spawn_function(::guy_spawns_and_gets_in_vehicle, self, var_7);

  common_scripts\utility::array_thread(var_1, maps\_utility::spawn_ai);
  self waittill("guy_entered");
  wait 3;
  thread maps\_vehicle::vehicle_becomes_crashable();

  if(!self.riders.size) {
    return;
  }
  maps\_vehicle::gopath();
  maps\_vehicle::leave_path_for_spline_path();
}

guy_spawns_and_gets_in_vehicle(var_0, var_1) {
  maps\_vehicle::mount_snowmobile(var_0, var_1);
}

watchweaponchange() {
  if(!isDefined(level.friendly_thermal_reflector_effect)) {
    level.friendly_thermal_reflector_effect = loadfx("misc/thermal_tapereflect_inverted");
  }
  self endon("death");
  var_0 = self getcurrentweapon();

  if(weap_has_thermal(var_0)) {
    thread thermal_tracker();
  }
  for(;;) {
    self waittill("weapon_change", var_1);

    if(weap_has_thermal(var_1)) {
      thread thermal_tracker();
      continue;
    }

    self notify("acogThermalTracker");
  }
}

weap_has_thermal(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0 == "none") {
    return 0;
  }
  if(weaponhasthermalscope(var_0)) {
    return 1;
  }
  return 0;
}

thermal_tracker() {
  self endon("death");
  self notify("acogThermalTracker");
  self endon("acogThermalTracker");
  var_0 = 0;

  for(;;) {
    var_1 = var_0;
    var_0 = self playerads();

    if(turn_thermal_on(var_0, var_1)) {
      thermal_effectson();
    } else if(turn_thermal_off(var_0, var_1)) {
      thermal_effectsoff();
    }
    wait 0.05;
  }
}

turn_thermal_on(var_0, var_1) {
  if(var_0 <= var_1) {
    return 0;
  }
  if(var_0 <= 0.65) {
    return 0;
  }
  return !isDefined(self.is_in_thermal_vision);
}

turn_thermal_off(var_0, var_1) {
  if(var_0 >= var_1) {
    return 0;
  }
  if(var_0 >= 0.8) {
    return 0;
  }
  return isDefined(self.is_in_thermal_vision);
}

thermal_effectson() {
  self.is_in_thermal_vision = 1;
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.has_thermal_fx)) {
      continue;
    }
    var_2.has_thermal_fx = 1;
    var_2 thread loop_friendly_thermal_reflector_effect(self.unique_id);
  }

  if(maps\_utility::is_coop()) {
    var_4 = maps\_utility::get_other_player(self);

    if(!isDefined(var_4.has_thermal_fx)) {
      var_4.has_thermal_fx = 1;
      var_4 thread loop_friendly_thermal_reflector_effect(self.unique_id, self);
    }
  }
}

thermal_effectsoff() {
  self.is_in_thermal_vision = undefined;
  level notify("thermal_fx_off" + self.unique_id);
  var_0 = getaiarray("allies");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].has_thermal_fx = undefined;
  }
  if(maps\_utility::is_coop()) {
    var_2 = maps\_utility::get_other_player(self);
    var_2.has_thermal_fx = undefined;
  }
}

loop_friendly_thermal_reflector_effect(var_0, var_1) {
  if(isDefined(self.has_no_ir)) {
    return;
  }
  level endon("thermal_fx_off" + var_0);
  self endon("death");

  for(;;) {
    if(isDefined(var_1)) {
      playfxontagforclients(level.friendly_thermal_reflector_effect, self, "J_Spine4", var_1);
    } else {
      playFXOnTag(level.friendly_thermal_reflector_effect, self, "J_Spine4");
    }
    wait 0.2;
  }
}

claymore_pickup_think_global() {
  precacheitem("claymore");
  self endon("deleted");
  self setCursorHint("HINT_NOICON");
  self setHintString(&"WEAPON_CLAYMORE_PICKUP");
  self makeusable();
  var_0 = weaponmaxammo("claymore") + weaponclipsize("claymore");

  if(isDefined(self.script_ammo_clip)) {
    var_0 = self.script_ammo_clip;
  }
  while(var_0 > 0) {
    self waittill("trigger", var_1);
    var_1 playSound("weap_pickup");
    var_2 = 0;

    if(!var_1 hasweapon("claymore")) {
      var_1 giveweapon("claymore");
    } else {
      var_2 = var_1 getammocount("claymore");
    }
    if(isDefined(var_0) && var_0 > 0) {
      var_0 = var_2 + var_0;
      var_3 = weaponmaxammo("claymore");
      var_4 = weaponclipsize("claymore");

      if(var_0 >= var_4) {
        var_0 = var_0 - var_4;
        var_1 setweaponammoclip("claymore", var_4);
      }

      if(var_0 >= var_3) {
        var_0 = var_0 - var_3;
        var_1 setweaponammostock("claymore", var_3);
      } else if(var_0 > 0) {
        var_1 setweaponammostock("claymore", var_0);
        var_0 = 0;
      }
    } else {
      var_1 givemaxammo("claymore");
    }
    var_5 = 4;

    if(isDefined(var_1.remotemissile_actionslot) && var_1.remotemissile_actionslot == 4) {
      var_5 = 2;
    }
    var_1 setactionslot(var_5, "weapon", "claymore");
    var_1 switchtoweapon("claymore");
  }

  if(isDefined(self.target)) {
    var_6 = getEntArray(self.target, "targetname");

    foreach(var_8 in var_6) {}
    var_8 delete();
  }

  self makeunusable();
  self delete();
}

ammo_cache_think_global() {
  self.use_trigger = spawn("script_model", self.origin + (0, 0, 28));
  self.use_trigger setModel("tag_origin");
  self.use_trigger makeusable();
  self.use_trigger setCursorHint("HINT_NOICON");
  self.use_trigger setHintString(&"WEAPON_CACHE_USE_HINT");
  thread ammo_icon_think();

  for(;;) {
    self.use_trigger waittill("trigger", var_0);
    self.use_trigger makeunusable();
    var_0 playSound("player_refill_all_ammo");
    var_0 disableweapons();
    var_1 = var_0 getweaponslistall();

    foreach(var_3 in var_1) {
      if(var_3 == "claymore") {
        continue;
      }
      if(var_3 == "c4") {
        continue;
      }
      var_0 givemaxammo(var_3);
      var_4 = weaponclipsize(var_3);

      if(isDefined(var_4)) {
        if(var_0 getweaponammoclip(var_3) < var_4) {
          var_0 setweaponammoclip(var_3, var_4);
        }
      }
    }

    wait 1.5;
    var_0 enableweapons();
    self.use_trigger makeusable();
  }
}

ammo_icon_think() {
  var_0 = spawn("trigger_radius", self.origin, 0, 320, 72);
  var_1 = newhudelem();
  var_1 setshader("waypoint_ammo", 1, 1);
  var_1.alpha = 0;
  var_1.color = (1, 1, 1);
  var_1.x = self.origin[0];
  var_1.y = self.origin[1];
  var_1.z = self.origin[2] + 16;
  var_1 setwaypoint(1, 1);
  self.ammo_icon = var_1;
  self.ammo_icon_trig = var_0;

  if(isDefined(self.icon_always_show) && self.icon_always_show) {
    ammo_icon_fade_in(var_1);
    return;
  }

  wait 0.05;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    while(var_2 istouching(var_0)) {
      var_3 = 1;
      var_4 = var_2 getcurrentweapon();

      if(var_4 == "none") {
        var_3 = 0;
      } else if(var_2 getfractionmaxammo(var_4) > 0.9) {
        var_3 = 0;
      }
      if(maps\_utility::player_looking_at(self.origin, 0.8, 1) && var_3) {
        ammo_icon_fade_in(var_1);
      } else {
        ammo_icon_fade_out(var_1);
      }
      wait 0.25;
    }

    ammo_icon_fade_out(var_1);
  }
}

ammo_icon_fade_in(var_0) {
  if(var_0.alpha != 0) {
    return;
  }
  var_0 fadeovertime(0.2);
  var_0.alpha = 0.3;
  wait 0.2;
}

ammo_icon_fade_out(var_0) {
  if(var_0.alpha == 0) {
    return;
  }
  var_0 fadeovertime(0.2);
  var_0.alpha = 0;
  wait 0.2;
}

trigger_multiple_visionset(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(var_0.script_visionset_start) && isDefined(var_0.script_visionset_end)) {
    var_1 = 1;
    var_3 = getEnt(var_0.target, "targetname");

    if(!isDefined(var_3)) {
      var_3 = common_scripts\utility::getStruct(var_0.target, "targetname");
    }
    var_4 = getEnt(var_3.target, "targetname");

    if(!isDefined(var_4)) {
      var_4 = common_scripts\utility::getStruct(var_3.target, "targetname");
    }
    var_3 = var_3.origin;
    var_4 = var_4.origin;
    var_2 = distance(var_3, var_4);
    var_0 init_visionset_progress_trigger();
  }

  var_5 = -1;

  for(;;) {
    var_0 waittill("trigger", var_6);

    if(isPlayer(var_6)) {
      if(var_1) {
        var_7 = 0;

        while(var_6 istouching(var_0)) {
          var_7 = maps\_utility::get_progress(var_3, var_4, var_6.origin, var_2);
          var_7 = clamp(var_7, 0, 1);

          if(var_7 != var_5) {
            var_5 = var_7;
            var_6 vision_set_fog_progress(var_0, var_7);
          }

          wait 0.05;
        }

        if(var_7 < 0.5) {
          var_6 maps\_utility::vision_set_fog_changes(var_0.script_visionset_start, var_0.script_delay);
        } else {
          var_6 maps\_utility::vision_set_fog_changes(var_0.script_visionset_end, var_0.script_delay);
        }
        continue;
      }

      var_6 maps\_utility::vision_set_fog_changes(var_0.script_visionset, var_0.script_delay);
    }
  }
}

init_visionset_progress_trigger() {
  if(!isDefined(self.script_delay)) {
    self.script_delay = 2;
  }
  var_0 = maps\_utility::get_vision_set_fog(self.script_visionset_start);
  var_1 = maps\_utility::get_vision_set_fog(self.script_visionset_end);

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = spawnStruct();
  var_2.startdist = var_1.startdist - var_0.startdist;
  var_2.halfwaydist = var_1.halfwaydist - var_0.halfwaydist;
  var_2.red = var_1.red - var_0.red;
  var_2.blue = var_1.blue - var_0.blue;
  var_2.green = var_1.green - var_0.green;
  var_2.maxopacity = var_1.maxopacity - var_0.maxopacity;
  var_2.sunfogenabled = isDefined(var_0.sunfogenabled) || isDefined(var_1.sunfogenabled);
  var_3 = 0;

  if(isDefined(var_0.sunred)) {
    var_3 = var_0.sunred;
  }
  var_4 = 0;

  if(isDefined(var_1.sunred)) {
    var_4 = var_1.sunred;
  }
  var_2.sunred_start = var_3;
  var_2.sunred = var_4 - var_3;
  var_5 = 0;

  if(isDefined(var_0.sungreen)) {
    var_5 = var_0.sungreen;
  }
  var_6 = 0;

  if(isDefined(var_1.sungreen)) {
    var_6 = var_1.sungreen;
  }
  var_2.sungreen_start = var_5;
  var_2.sungreen = var_6 - var_5;
  var_7 = 0;

  if(isDefined(var_0.sunblue)) {
    var_7 = var_0.sunblue;
  }
  var_8 = 0;

  if(isDefined(var_1.sunblue)) {
    var_8 = var_1.sunblue;
  }
  var_2.sunblue_start = var_7;
  var_2.sunblue = var_8 - var_7;
  var_9 = (0, 0, 0);

  if(isDefined(var_0.sundir)) {
    var_9 = var_0.sundir;
  }
  var_10 = (0, 0, 0);

  if(isDefined(var_1.sundir)) {
    var_10 = var_1.sundir;
  }
  var_2.sundir_start = var_9;
  var_2.sundir = var_10 - var_9;
  var_11 = 0;

  if(isDefined(var_0.sunbeginfadeangle)) {
    var_11 = var_0.sunbeginfadeangle;
  }
  var_12 = 0;

  if(isDefined(var_1.sunbeginfadeangle)) {
    var_12 = var_1.sunbeginfadeangle;
  }
  var_2.sunbeginfadeangle_start = var_11;
  var_2.sunbeginfadeangle = var_12 - var_11;
  var_13 = 0;

  if(isDefined(var_0.sunendfadeangle)) {
    var_13 = var_0.sunendfadeangle;
  }
  var_14 = 0;

  if(isDefined(var_1.sunendfadeangle)) {
    var_14 = var_1.sunendfadeangle;
  }
  var_2.sunendfadeangle_start = var_13;
  var_2.sunendfadeangle = var_14 - var_13;
  var_15 = 0;

  if(isDefined(var_0.normalfogscale)) {
    var_15 = var_0.normalfogscale;
  }
  var_16 = 0;

  if(isDefined(var_1.normalfogscale)) {
    var_16 = var_1.normalfogscale;
  }
  var_2.normalfogscale_start = var_15;
  var_2.normalfogscale = var_16 - var_15;
  self.visionset_diff = var_2;
}

vision_set_fog_progress(var_0, var_1) {
  maps\_utility::init_self_visionset();

  if(var_1 < 0.5) {
    self.vision_set_transition_ent.vision_set = var_0.script_visionset_start;
  } else {
    self.vision_set_transition_ent.vision_set = var_0.script_visionset_end;
  }
  self.vision_set_transition_ent.time = 0;

  if(var_0.script_visionset_start == var_0.script_visionset_end) {
    return;
  }
  self visionsetnakedforplayer_lerp(var_0.script_visionset_start, var_0.script_visionset_end, var_1);
  var_2 = maps\_utility::get_vision_set_fog(var_0.script_visionset_start);
  var_3 = maps\_utility::get_vision_set_fog(var_0.script_visionset_end);
  var_4 = var_0.visionset_diff;
  var_5 = spawnStruct();
  var_5.startdist = var_2.startdist + var_4.startdist * var_1;
  var_5.halfwaydist = var_2.halfwaydist + var_4.halfwaydist * var_1;
  var_5.halfwaydist = max(1, var_5.halfwaydist);
  var_5.red = var_2.red + var_4.red * var_1;
  var_5.green = var_2.green + var_4.green * var_1;
  var_5.blue = var_2.blue + var_4.blue * var_1;
  var_5.maxopacity = var_2.maxopacity + var_4.maxopacity * var_1;

  if(var_4.sunfogenabled) {
    var_5.sunfogenabled = 1;
    var_5.sunred = var_4.sunred_start + var_4.sunred * var_1;
    var_5.sungreen = var_4.sungreen_start + var_4.sungreen * var_1;
    var_5.sunblue = var_4.sunblue_start + var_4.sunblue * var_1;
    var_5.sundir = var_4.sundir_start + var_4.sundir * var_1;
    var_5.sunbeginfadeangle = var_4.sunbeginfadeangle_start + var_4.sunbeginfadeangle * var_1;
    var_5.sunendfadeangle = var_4.sunendfadeangle_start + var_4.sunendfadeangle * var_1;
    var_5.normalfogscale = var_4.normalfogscale_start + var_4.normalfogscale * var_1;
  }

  maps\_utility::set_fog_to_ent_values(var_5, 0.05);
}

window_destroy() {
  var_0 = getglass(self.target);

  if(!isDefined(var_0)) {
    return;
  }
  level waittillmatch("glass_destroyed", var_0);
  self delete();
}

global_empty_callback(var_0, var_1, var_2, var_3, var_4) {}

trigger_multiple_compass(var_0) {
  var_1 = var_0.script_parameters;

  if(!isDefined(level.minimap_image)) {
    level.minimap_image = "";
  }
  for(;;) {
    var_0 waittill("trigger");

    if(level.minimap_image != var_1) {
      maps\_compass::setupminimap(var_1);
    }
  }
}

assign_fx_to_trigger(var_0, var_1, var_2) {
  if(isDefined(var_0.v["soundalias"]) && var_0.v["soundalias"] != "nil") {
    if(!isDefined(var_0.v["stopable"]) || !var_0.v["stopable"]) {
      return;
    }
  }

  var_2.origin = var_0.v["origin"];

  if(var_2 istouching(var_1)) {
    var_1.fx[var_1.fx.size] = var_0;
  }
}

trigger_multiple_fx_volume(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0.fx = [];

  foreach(var_3 in level.createfxent) {}
  assign_fx_to_trigger(var_3, var_0, var_1);

  var_1 delete();

  if(!isDefined(var_0.target)) {
    return;
  }
  var_5 = getEntArray(var_0.target, "targetname");

  foreach(var_7 in var_5) {
    switch (var_7.classname) {
      case "trigger_multiple_fx_volume_on":
        var_7 thread trigger_multiple_fx_trigger_on_think(var_0);
        break;
      case "trigger_multiple_fx_volume_off":
        var_7 thread trigger_multiple_fx_trigger_off_think(var_0);
        break;
      default:
        break;
    }
  }
}

trigger_multiple_fx_trigger_on_think(var_0) {
  for(;;) {
    self waittill("trigger");
    common_scripts\utility::array_thread(var_0.fx, maps\_utility::restarteffect);
    wait 1;
  }
}

trigger_multiple_fx_trigger_off_think(var_0) {
  wait 1;
  common_scripts\utility::array_thread(var_0.fx, common_scripts\utility::pauseeffect);

  for(;;) {
    self waittill("trigger");
    common_scripts\utility::array_thread(var_0.fx, common_scripts\utility::pauseeffect);
    wait 1;
  }
}

weapon_list_debug() {
  common_scripts\utility::create_dvar("weaponlist", "0");

  if(!getdvarint("weaponlist")) {
    return;
  }
  var_0 = getEntArray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.code_classname)) {
      continue;
    }
    if(issubstr(var_3.code_classname, "weapon")) {
      var_1[var_3.classname] = 1;
    }
  }

  foreach(var_7, var_6 in var_1) {}

  var_8 = getspawnerarray();
  var_9 = [];

  foreach(var_11 in var_8) {}
  var_9[var_11.code_classname] = 1;

  foreach(var_14, var_6 in var_9) {}
}

slowmo_system_init() {
  level.slowmo = spawnStruct();
  slowmo_system_defaults();
  notifyoncommand("_cheat_player_press_slowmo", "+melee");
  notifyoncommand("_cheat_player_press_slowmo", "+melee_breath");
  notifyoncommand("_cheat_player_press_slowmo", "+melee_zoom");
}

slowmo_system_defaults() {
  level.slowmo.lerp_time_in = 0.0;
  level.slowmo.lerp_time_out = 0.25;
  level.slowmo.speed_slow = 0.4;
  level.slowmo.speed_norm = 1.0;
}

add_no_game_starts() {
  var_0 = getEntArray("script_origin_start_nogame", "classname");

  if(!var_0.size) {
    return;
  }
  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_startname)) {
      continue;
    }
    maps\_utility::add_start("no_game_" + var_2.script_startname, ::start_nogame);
  }
}

do_no_game_start() {
  if(!maps\_utility::is_no_game_start()) {
    return;
  }
  setsaveddvar("ufoHitsTriggers", "1");
  level.stop_load = 1;

  if(isDefined(level.custom_no_game_setupfunc)) {
    level[[level.custom_no_game_setupfunc]]();
  }
  maps\_loadout::init_loadout();
  thread maps\_audio::aud_init();
  maps\_global_fx::main();
  do_no_game_start_teleport();
  common_scripts\utility::array_call(getEntArray("truckjunk", "targetname"), ::delete);
  common_scripts\utility::array_call(getEntArray("truckjunk", "script_noteworthy"), ::delete);
  level waittill("eternity");
}

do_no_game_start_teleport() {
  var_0 = getEntArray("script_origin_start_nogame", "classname");

  if(!var_0.size) {
    return;
  }
  var_0 = sortbydistance(var_0, level.player.origin);

  if(level.start_point == "no_game") {
    level.player maps\_utility::teleport_player(var_0[0]);
    return;
  }

  var_1 = getsubstr(level.start_point, 8);
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.script_startname)) {
      continue;
    }
    if(var_1 != var_4.script_startname) {
      continue;
    }
    if(isDefined(var_4.script_visionset)) {
      maps\_utility::vision_set_fog_changes(var_4.script_visionset, 0);
    }
    level.player maps\_utility::teleport_player(var_4);
    var_2 = 1;
    break;
  }

  if(!var_2) {
    level.player maps\_utility::teleport_player(var_0[0]);
  }
}