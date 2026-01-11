/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\odin.gsc
*****************************************************/

main() {
  maps\_utility::template_level("odin");
  maps\createart\odin_art::main();
  maps\odin_fx::main();
  maps\odin_precache::main();
  maps\_utility::default_start();
  maps\_utility::add_start("odin_intro", ::start_odin_intro, "Odin Intro", ::odin_intro);
  maps\_utility::add_start("odin_ally", ::start_odin_ally, "Odin Ally", ::odin_ally);
  maps\_utility::add_start("odin_escape", ::start_odin_escape, "Odin Escape", ::odin_escape);
  maps\_utility::add_start("odin_spin", ::start_odin_spin, "Odin Spin", ::odin_spin);
  maps\_utility::add_start("odin_satellite", ::start_odin_satellite, "Odin Satellite", ::odin_satellite);
  maps\_load::main();
  maps\odin_anim::main();
  maps\odin_audio::main();
  odin_precache();
  odin_flag_inits();
  odin_hint_string_init();
  odin_script_setup();
  maps\odin_fx::fx_init();
  level.player setviewmodel("viewhands_us_space");
}

odin_precache() {
  maps\_space::precache();
  maps\odin_intro::section_precache();
  maps\odin_ally::section_precache();
  maps\odin_escape::section_precache();
  maps\odin_spin::section_precache();
  maps\odin_satellite::section_precache();
  precachestring(&"ODIN_OBJ_RETURN");
  precachestring(&"ODIN_OBJ_SHUTDOWN");
  precachestring(&"ODIN_OBJ_DESTROY");
  precachestring(&"ODIN_OBJ_ESCAPE");
  precachestring(&"ODIN_TITLECARD_1");
  precachestring(&"ODIN_SHROUD_PICKUP");
  precacheitem("microtar_space");
  precacheitem("microtar_space_interior");
  precachemodel("viewhands_us_space");
  precachemodel("body_fed_space_assault_a");
  precacheshader("hud_icon_microtar_space");

  if(maps\_utility::is_gen4()) {
    precacheshader("space_helmet_glass_01");
  }
}

odin_flag_inits() {
  maps\odin_intro::section_flag_init();
  maps\odin_ally::section_flag_init();
  maps\odin_escape::section_flag_init();
  maps\odin_spin::section_flag_init();
  maps\odin_satellite::section_flag_init();
  common_scripts\utility::flag_init("objective_return_to_station");
  common_scripts\utility::flag_init("objective_return_to_station_complete");
  common_scripts\utility::flag_init("objective_shutdown_sat");
  common_scripts\utility::flag_init("objective_destroy_sat");
  common_scripts\utility::flag_init("no_steam_on_death");
  common_scripts\utility::flag_init("no_push_zone");
  common_scripts\utility::flag_init("astronaut_needs_help");
  common_scripts\utility::flag_init("player_has_shroud");
  common_scripts\utility::flag_init("show_custom_weap_splash");
}

odin_hint_string_init() {
  maps\odin_intro::section_hint_string_init();
  maps\odin_ally::section_hint_string_init();
  maps\odin_escape::section_hint_string_init();
  maps\odin_spin::section_hint_string_init();
  maps\odin_satellite::section_hint_string_init();
}

odin_script_setup() {
  if(isDefined(level.odin_script_setup)) {
    return;
  }
  level.odin_script_setup = 1;
  level.intro_ent_del = [];
  level.ally_ent_del = [];
  level.sat_ent_del = [];
  level.gameskill_breath_func = maps\odin_util::odin_breathing_func;
  level.player allowmelee(0);

  if(maps\_utility::is_gen4()) {
    setglaregrimematerial("space_helmet_glass_01");
    setsaveddvar("r_mbEnable", 2);
    setsaveddvar("r_mbFastEnable", 1);
    setsaveddvar("r_mbFastPreset", 0);
    setsaveddvar("r_mbCameraRotationInfluence", 0.6);
    setsaveddvar("r_mbCameraTranslationInfluence", 2.0);
    setsaveddvar("r_mbViewmodelVelocityScalar", 0.04);
    setsaveddvar("r_mbStaticVelocityScalar", 0.56);
    setsaveddvar("r_mbViewmodelEnable", 1);
    setsaveddvar("r_mbModelVelocityScalar", 0.2);
  }

  if(level.start_point == "start_deer" || level.start_point == "start_after_hunt" || level.start_point == "start_woods" || level.start_point == "start_neighborhood" || level.start_point == "start_mansion_ext" || level.start_point == "start_mansion" || level.start_point == "default") {
    level.start_point = "odin_intro";
  }

  thread maps\odin_fx::lgt_init();
  level.player.ignoreme = 0;
  level.player.ignoreall = 0;
  thread mission_objective_logic();
  level.odin_fov = 55;
  level.player.has_pushanims = 1;

  if(!isDefined(level.prologue) || isDefined(level.prologue) && level.prologue == 0) {
    thread maps\_space_player::init_player_space();
    thread maps\_space_ai::init_ai_space();
  }

  maps\_colors::add_cover_node("Path 3D");
  maps\_colors::add_cover_node("Cover Stand 3D");
  maps\_colors::add_cover_node("Cover Right 3D");
  maps\_colors::add_cover_node("Cover Left 3D");
  maps\_colors::add_cover_node("Cover Up 3D");
  maps\_colors::add_cover_node("Exposed 3D");
  setsaveddvar("player_spaceViewHeight", 11);
  setsaveddvar("player_spaceCapsuleHeight", 30);
  setsaveddvar("phys_gravity_ragdoll", 0);
  setsaveddvar("phys_gravity", 0);
  setsaveddvar("phys_autoDisableLinear", 0.25);
  setsaveddvar("g_gravity", 1);
  level.wall_friction_enabled = 1;
  level.wall_friction_trace_dist = 5;
  level.wall_friction_offset_dist = 2;
  setsaveddvar("bg_viewBobAmplitudeStanding", "0.0 0.0");
  setsaveddvar("bg_viewBobAmplitudeStandingAds", "0.0 0.0");
  setsaveddvar("bg_viewBobAmplitudeDucked", "0.0 0.0");
  setsaveddvar("bg_viewBobAmplitudeDuckedAds", "0.0 0.0");
  setsaveddvar("bg_viewBobAmplitudeSprinting", "0.0 0.0");
  setsaveddvar("bg_weaponBobAmplitudeStanding", "0.0 0.0");
  setsaveddvar("bg_weaponBobAmplitudeDucked", "0.0 0.0");
  setsaveddvar("bg_weaponBobAmplitudeSprinting", "0.0 0.0");
  setsaveddvar("bg_weaponBobAmplitudeBase", 0.0);
  setsaveddvar("bg_viewBobMax", 0);
  thread maps\_space_player::init_player_space_anims();
  level.water_level_z = level.player.origin[2];
  level.default_goalradius = 64;
  level.player thread maps\_space_player::enable_player_space();
  level.player thread maps\_space::player_space_helmet();
  level.player thread maps\_space::space_hud_enable(1);
  level.player notify("stop_space_breathe");
  level.player.weapon_interior = "microtar_space_interior+acogsmg_sp";
  level.player.weapon_exterior = "microtar_space+acogsmg_sp";
  thread maps\odin_spin::safe_hide_spin();
  thread maps\odin_util::odin_control_player_speed();

  if(isDefined(level.prologue) && level.prologue == 1) {
    level notify("stop_particulates");
    level.player setviewmodel("viewhands_us_space");
    level.scr_model["player_rig"] = "viewhands_player_us_space";
  }

  var_0 = getent("ally_0", "targetname");
  level.ally = var_0 maps\_utility::spawn_ai(1);
  level.squad[0] = level.ally;
  level.ally thread maps\_utility::deletable_magic_bullet_shield();
  level.ally thread maps\_utility::set_force_color("r");
  level.ally thread maps\_space_ai::enable_space();
  level.ally.animname = "odin_ally";
  level.player thread maps\odin_util::player_physics_pulse();
  level.ally thread maps\odin_util::ally_physics_pulse();
  common_scripts\utility::flag_set("no_steam_on_death");
  level.ally.moveplaybackrate = 1.5;
  thread maps\odin_audio::audio_set_initial_ambience();
  thread maps\odin_util::set_mission_view_tweaks();
  wait 0.1;
}

give_weapons() {
  self takeallweapons();
  self giveweapon(level.player.weapon_interior);
  self switchtoweapon(level.player.weapon_interior);
  self disableweaponpickup();
}

start_odin_intro() {
  jump_to_cleanup();
  odin_script_setup();
  maps\odin_intro::intro_start();
}

odin_intro() {
  maps\odin_intro::intro_main();
}

start_odin_ally() {
  jump_to_cleanup();
  odin_script_setup();
  maps\odin_ally::ally_start();
  thread maps\odin_audio::sfx_pressurize_space();
}

odin_ally() {
  maps\odin_ally::ally_main();
}

start_odin_escape() {
  jump_to_cleanup();
  odin_script_setup();
  maps\odin_escape::escape_start();
  thread maps\odin_audio::sfx_pressurize_space();
}

odin_escape() {
  maps\odin_escape::escape_main();
}

start_odin_spin() {
  jump_to_cleanup();
  odin_script_setup();
  maps\odin_spin::spin_start();
  thread maps\odin_audio::sfx_pressurize_space();
}

odin_spin() {
  maps\odin_spin::spin_main();
}

start_odin_satellite() {
  jump_to_cleanup();
  odin_script_setup();
  maps\odin_satellite::satellite_start();
}

odin_satellite() {
  maps\odin_satellite::satellite_main();
}

mission_objective_logic() {
  maps\_utility::obj("OBJ_RETURN");
  maps\_utility::obj("OBJ_SHUTDOWN");
  maps\_utility::obj("OBJ_DESTROY");
  waittillframeend;
  var_0 = 0;

  if(level.start_point != "default") {
    var_0 = 1;
  }

  if(isDefined(level.prologue) && level.prologue == 1) {}

  level.space_breathing_enabled = 1;

  switch (level.start_point) {
    case "default":
    case "odin_intro":
      common_scripts\utility::flag_wait("objective_return_to_station");
      thread add_marker_helper(maps\_utility::obj("OBJ_RETURN"));
      setsaveddvar("compass", "1");
      objective_add(maps\_utility::obj("OBJ_RETURN"), "active", &"ODIN_OBJ_RETURN");
      objective_state(maps\_utility::obj("OBJ_RETURN"), "current");
      common_scripts\utility::flag_wait("clear_helper_mark");
      level notify("safe_marker_thread_deletion");
      objective_state(maps\_utility::obj("OBJ_RETURN"), "done");
      var_0 = 0;
    case "odin_ally":
      if(var_0) {
        objective_add(maps\_utility::obj("OBJ_RETURN"), "done", &"ODIN_OBJ_RETURN");
        var_0 = 0;
      }

      common_scripts\utility::flag_wait("objective_shutdown_sat");
      objective_add(maps\_utility::obj("OBJ_SHUTDOWN"), "active", &"ODIN_OBJ_SHUTDOWN");
    case "odin_escape":
      if(var_0) {
        objective_add(maps\_utility::obj("OBJ_RETURN"), "done", &"ODIN_OBJ_RETURN");
        objective_add(maps\_utility::obj("OBJ_SHUTDOWN"), "active", &"ODIN_OBJ_SHUTDOWN");
        var_0 = 0;
      }

      common_scripts\utility::flag_wait("objective_escape_sat");
      objective_add(maps\_utility::obj("OBJ_SHUTDOWN"), "done", &"ODIN_OBJ_SHUTDOWN");
      wait 1;
      objective_add(maps\_utility::obj("OBJ_SHUTDOWN"), "active", &"ODIN_OBJ_ESCAPE");
    case "odin_spin":
      if(var_0) {
        objective_add(maps\_utility::obj("OBJ_RETURN"), "done", &"ODIN_OBJ_RETURN");
        objective_add(maps\_utility::obj("OBJ_SHUTDOWN"), "active", &"ODIN_OBJ_ESCAPE");
        var_0 = 0;
      }

      common_scripts\utility::flag_wait("objective_destroy_sat");
      objective_add(maps\_utility::obj("OBJ_SHUTDOWN"), "done", &"ODIN_OBJ_ESCAPE");
      objective_add(maps\_utility::obj("OBJ_DESTROY"), "active", &"ODIN_OBJ_DESTROY");
    case "odin_satellite":
      if(var_0) {
        objective_add(maps\_utility::obj("OBJ_RETURN"), "done", &"ODIN_OBJ_RETURN");
        objective_add(maps\_utility::obj("OBJ_SHUTDOWN"), "done", &"ODIN_OBJ_ESCAPE");
        objective_add(maps\_utility::obj("OBJ_DESTROY"), "active", &"ODIN_OBJ_DESTROY");
        var_0 = 0;
      }

      common_scripts\utility::flag_wait("satellite_end_anim_started");
      wait 2;
      objective_add(maps\_utility::obj("OBJ_DESTROY"), "done", &"ODIN_OBJ_DESTROY");
    default:
  }
}

add_marker_helper(var_0) {
  level endon("safe_marker_thread_deletion");
  common_scripts\utility::flag_wait("astronaut_needs_help");
  var_1 = getent("intro_hatch_door_blocker_org", "targetname");
  objective_position(var_0, var_1.origin);
}

jump_to_cleanup() {
  switch (level.start_point) {
    case "odin_satellite":
      common_scripts\utility::flag_set("spin_clear");
      thread maps\odin_spin::spin_cleanup(1);
    case "odin_spin":
      common_scripts\utility::flag_set("escape_clear");
      thread maps\odin_escape::escape_cleanup(1);
    case "odin_escape":
      common_scripts\utility::flag_set("ally_clear");
      thread maps\odin_ally::ally_cleanup(0);
    case "odin_ally":
      common_scripts\utility::flag_set("invasion_clear");
      thread maps\odin_intro::intro_cleanup(0);
    case "default":
    case "odin_intro":
    default:
  }
}