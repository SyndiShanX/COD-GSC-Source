/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory.gsc
*****************************************************/

main() {
  level.factory = 1;
  maps\_utility::template_level("factory");
  maps\createart\factory_art::main();
  maps\factory_fx::main();
  maps\_riotshield::init_riotshield();
  maps\factory_precache::main();
  maps\_utility::default_start();
  maps\_utility::add_start("intro", ::intro_start, "Infil", ::intro, "factory_intro_tr");
  maps\_utility::add_start("intro_train", ::intro_train_start, "Train Pass", ::intro_train, "factory_intro_tr");
  maps\_utility::add_start("factory_ingress", ::factory_ingress_start, "Factory Entrance", ::factory_ingress, "factory_intro_tr");
  maps\_utility::add_start("powerstealth", ::powerstealth_start, "Power Stealth", ::powerstealth, "factory_intro_tr");
  maps\_utility::add_start("presat_room", ::presat_room_start, "Pre-SAT Room", ::presat_room, "factory_intro_tr");
  maps\_utility::add_start("sat_room", ::sat_room_start, "SAT Room", ::sat_room, "factory_mid_tr");
  maps\_utility::add_start("ambush", ::ambush_start, "Ambush", ::ambush, "factory_mid_tr");
  maps\_utility::add_start("ambush_escape", ::ambush_escape_start, "Ambush Escape", ::ambush_escape, "factory_mid_tr");
  maps\_utility::add_start("rooftop", ::rooftop_start, "Rooftop", ::rooftop, "factory_mid_tr");
  maps\_utility::add_start("parking_lot", ::parking_lot_start, "Parking Lot", ::parking_lot, "factory_outro_tr");
  maps\_utility::add_start("chase", ::chase_start, "Vehicle Chase", ::chase, "factory_outro_tr");
  maps\_utility::add_start("fly_around", ::fly_around_start, "Fly Around", ::fly_around);
  mission_flag_inits();
  mission_precache();
  maps\factory_audio::audio_flag_inits();
  mission_hint_string_init();
  maps\_drone_ai::init();
  common_scripts\_pipes::main();
  level.pipesdamage = 0;
  maps\_utility::intro_screen_create(&"FACTORY_INTROSCREEN_LINE_1", &"FACTORY_INTROSCREEN_LINE_2", &"FACTORY_INTROSCREEN_LINE_5");
  maps\_utility::transient_init("factory_intro_tr");
  maps\_utility::transient_init("factory_mid_tr");
  maps\_utility::transient_init("factory_outro_tr");
  maps\_load::main();
  thread motion_blur_during_melee();
  thread factory_glare();
  level.player.thermal_anim_active = 0;
  level.player.active_anim = 0;
  level.player.thermal = 0;
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9.01);
  maps\factory_anim::main();
  maps\_hand_signals::inithandsignals();
  thread mission_objective_logic();
  maps\factory_util::squad_add_ally("ALLY_ALPHA", "ally_alpha", "ally_alpha");
  maps\factory_util::squad_add_ally("ALLY_BRAVO", "ally_bravo", "ally_bravo");
  maps\factory_util::squad_add_ally("ALLY_CHARLIE", "ally_charlie", "ally_charlie");
  maps\_utility::battlechatter_off();
  maps\_stealth::main();
  maps\_patrol_anims::main();
  level.player maps\factory_camera::binoculars_init("factory");
  level.player takeallweapons();
  level.default_weapon = "honeybadger+grip_sp+reflex_sp";
  level.player giveweapon(level.default_weapon);
  level.player switchtoweaponimmediate(level.default_weapon);
  level.player giveweapon("p226_tactical+silencerpistol_sp+tactical_sp");
  level.player setoffhandprimaryclass("frag");
  level.player setoffhandsecondaryclass("flash");
  thread maps\factory_audio::audio_main();
  thread maps\factory_audio::mission_music();
  thread maps\factory_fx::lgt_vision_fog_init();
  thread maps\factory_fx::fx_init();
  setDvar("music_enable", 1);
  setsaveddvar("r_reactiveMotionPlayerRadius", 5.0);

  if(level.ps3 == 1)
    setsaveddvar("sm_sunSampleSizeNear", 0.1);

  maps\_nightvision::main(level.players, 1);
  level.player setactionslot(1, "");
}

mission_precache() {
  precacheshellshock("factory_revbreach");
  precacherumble("silencer_fire");
  precacheitem("honeybadger");
  precacheitem("p226_tactical");
  precacheitem("gm6+scopegm6_sp");
  precacheitem("mts255");
  precacheshader("hud_icon_nvg");
  maps\_utility::precache("viewmodel_NVG");
  maps\factory_intro::section_precache();
  maps\factory_powerstealth::section_precache();
  maps\factory_weapon_room::section_precache();
  maps\factory_ambush::section_precache();
  maps\factory_ambush_escape::section_precache();
  maps\factory_rooftop::section_precache();
  maps\factory_chase::section_precache();
}

mission_flag_inits() {
  maps\factory_intro::section_flag_init();
  maps\factory_powerstealth::section_flag_init();
  maps\factory_weapon_room::section_flag_init();
  maps\factory_ambush::section_flag_init();
  maps\factory_ambush_escape::section_flag_init();
  maps\factory_rooftop::section_flag_init();
  maps\factory_parking_lot::section_flag_init();
  maps\factory_chase::section_flag_init();
  common_scripts\utility::flag_init("intel_proto_flag");
}

mission_hint_string_init() {
  maps\factory_intro::section_hint_string_init();
  maps\factory_powerstealth::section_hint_string_init();
  maps\factory_ambush::section_hint_string_init();
}

motion_blur_during_melee() {
  if(maps\_utility::is_gen4()) {
    for(;;) {
      if(level.player meleeButtonPressed() && !level.player isthrowinggrenade()) {
        setsaveddvar("r_mbEnable", 2);
        setsaveddvar("r_mbCameraRotationInfluence", 1);
        setsaveddvar("r_mbCameraTranslationInfluence", 0.01);
        setsaveddvar("r_mbModelVelocityScalar", 0.7);
        setsaveddvar("r_mbStaticVelocityScalar", 0.2);
        setsaveddvar("r_mbViewmodelVelocityScalar", 1);
        wait 1.5;
        setsaveddvar("r_mbEnable", 0);
      }

      wait 0.05;
    }
  }
}

factory_glare() {
  if(maps\_utility::is_gen4())
    precacheshader("lens_grime_messy");
}

intro_start() {
  thread maps\factory_audio::intro_ambience_changes();
  thread maps\factory_util::factory_black_zone_achievement();
  level.player maps\factory_util::move_player_to_start_point("playerstart_intro");
  level maps\factory_intro::intro_start();
}

intro() {
  level maps\factory_intro::intro();
}

intro_train_start() {
  jump_to_cleanup();
  thread maps\factory_util::factory_black_zone_achievement();
  level.player maps\factory_util::move_player_to_start_point("playerstart_intro_train");
  level maps\factory_intro::intro_train_start();
}

intro_train() {
  level maps\factory_intro::intro_train();
}

factory_ingress_start() {
  jump_to_cleanup();
  thread maps\factory_util::factory_black_zone_achievement();
  level.player maps\factory_util::move_player_to_start_point("playerstart_factory_ingress");
  level maps\factory_intro::factory_ingress_start();
}

factory_ingress() {
  level maps\factory_intro::factory_ingress();
}

powerstealth_start() {
  jump_to_cleanup();
  thread maps\factory_util::factory_black_zone_achievement();
  level.player maps\factory_util::move_player_to_start_point("playerstart_powerstealth");
  level maps\factory_powerstealth::powerstealth_start();
}

powerstealth() {
  level maps\factory_powerstealth::powerstealth();
}

presat_room_start() {
  jump_to_cleanup();
  level maps\factory_weapon_room::presat_room_start();
}

presat_room() {
  level maps\factory_weapon_room::presat_room();
}

sat_room_start() {
  jump_to_cleanup();
  level.player giveweapon("flash_grenade");
  level.player giveweapon("fraggrenade");
  level maps\factory_weapon_room::sat_room_start();
}

sat_room() {
  level maps\factory_weapon_room::sat_room();
}

ambush_start() {
  jump_to_cleanup();
  level.player giveweapon("flash_grenade");
  level.player giveweapon("fraggrenade");
  level maps\factory_ambush::start();
}

ambush() {
  level maps\factory_ambush::main();
}

ambush_escape_start() {
  jump_to_cleanup();
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  level.player giveweapon("flash_grenade");
  level.player giveweapon("fraggrenade");
  level.player thread maps\factory_util::thermal_vision();
  level thread maps\factory_fx::fx_track_thermal();
  level maps\factory_ambush_escape::start();
}

ambush_escape() {
  level maps\factory_ambush_escape::main();
}

rooftop_start() {
  jump_to_cleanup();
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  level.player giveweapon("flash_grenade");
  level.player giveweapon("fraggrenade");
  level.player thread maps\factory_util::thermal_vision();
  level thread maps\factory_fx::fx_track_thermal();
  level maps\factory_rooftop::start();
}

rooftop() {
  level maps\factory_rooftop::main();
}

parking_lot_start() {
  jump_to_cleanup();
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  level.player giveweapon("flash_grenade");
  level.player giveweapon("fraggrenade");
  level.player thread maps\factory_util::thermal_vision();
  level thread maps\factory_fx::fx_track_thermal();
  level maps\factory_parking_lot::start();
}

parking_lot() {
  level maps\factory_parking_lot::main();
}

chase_start() {
  jump_to_cleanup();
  level.player giveweapon("flash_grenade");
  level.player giveweapon("fraggrenade");
  level.player thread maps\factory_util::thermal_vision();
  level thread maps\factory_fx::fx_track_thermal();
  level maps\factory_chase::start();
}

chase() {
  level maps\factory_chase::main();
}

fly_around_start() {
  iprintlnbold("Press X to cycle transient fastfiles");
  level.player maps\factory_util::move_player_to_start_point("playerstart_intro");
}

fly_around() {
  for(;;) {
    while(!level.player buttonPressed("BUTTON_X"))
      wait 0.05;

    maps\factory_util::load_transient("factory_intro_tr");

    while(!istransientloaded("factory_intro_tr"))
      wait 0.05;

    while(!level.player buttonPressed("BUTTON_X"))
      wait 0.05;

    maps\factory_util::load_transient("factory_mid_tr");

    while(!istransientloaded("factory_mid_tr"))
      wait 0.05;

    while(!level.player buttonPressed("BUTTON_X"))
      wait 0.05;

    maps\factory_util::load_transient("factory_outro_tr");

    while(!istransientloaded("factory_outro_tr"))
      wait 0.05;
  }
}

mission_objective_logic() {
  maps\_utility::obj("OBJ_INFILTRATE");
  maps\_utility::obj("OBJ_FIND_PROOF");
  maps\_utility::obj("OBJ_SCAN_2");
  maps\_utility::obj("OBJ_INVESTIGATE");
  maps\_utility::obj("OBJ_ESCAPE");
  waittillframeend;
  var_0 = 0;

  if(level.start_point != "default")
    var_0 = 1;

  switch (level.start_point) {
    case "default":
    case "intro":
      common_scripts\utility::flag_wait("intro_drop_kill_done");
      var_0 = 0;
    case "factory_ingress":
    case "intro_train":
      objective_add(maps\_utility::obj("OBJ_INFILTRATE"), "active", &"FACTORY_OBJ_ENTER_FACTORY");
      objective_state(maps\_utility::obj("OBJ_INFILTRATE"), "current");
      common_scripts\utility::flag_wait("entered_factory_1");
      objective_state(maps\_utility::obj("OBJ_INFILTRATE"), "done");
      var_0 = 0;
    case "sat_room":
    case "presat_room":
    case "powerstealth":
      if(var_0) {
        objective_add(maps\_utility::obj("OBJ_INFILTRATE"), "done", &"FACTORY_OBJ_ENTER_FACTORY");
        var_0 = 0;
      }

      objective_add(maps\_utility::obj("OBJ_FIND_PROOF"), "active", &"FACTORY_OBJ_FIND_EVIDENCE");
      objective_state(maps\_utility::obj("OBJ_FIND_PROOF"), "current");
      common_scripts\utility::flag_wait("start_camera_moment");
      objective_state(maps\_utility::obj("OBJ_FIND_PROOF"), "done");
      wait 0.25;
      objective_add(maps\_utility::obj("OBJ_SCAN_2"), "active", &"FACTORY_OBJ_SCAN_2");
      objective_state(maps\_utility::obj("OBJ_SCAN_2"), "current");
      common_scripts\utility::flag_wait("cam_B_confirmed");
      objective_state(maps\_utility::obj("OBJ_SCAN_2"), "done");
      common_scripts\utility::flag_wait("sat_room_continue");
    case "ambush":
      if(var_0) {
        objective_add(maps\_utility::obj("OBJ_INFILTRATE"), "done", &"FACTORY_OBJ_ENTER_FACTORY");
        objective_add(maps\_utility::obj("OBJ_FIND_PROOF"), "done", &"FACTORY_OBJ_FIND_EVIDENCE");
      }

      objective_add(maps\_utility::obj("OBJ_INVESTIGATE"), "active", &"FACTORY_OBJ_INVESTIGATE_RECORDS");
      objective_state(maps\_utility::obj("OBJ_INVESTIGATE"), "current");
      level waittill("show_ambush_use_hint");
      var_1 = getent("ambush_console_node", "targetname");
      common_scripts\utility::flag_wait("player_used_computer");
      wait 1.0;
      objective_state(maps\_utility::obj("OBJ_INVESTIGATE"), "done");
      common_scripts\utility::flag_wait("ambush_vignette_done");
      wait 3.0;
      var_0 = 0;
    case "chase":
    case "parking_lot":
    case "rooftop":
    case "ambush_escape":
      if(var_0) {
        objective_add(maps\_utility::obj("OBJ_INFILTRATE"), "done", &"FACTORY_OBJ_ENTER_FACTORY");
        objective_add(maps\_utility::obj("OBJ_FIND_PROOF"), "done", &"FACTORY_OBJ_FIND_EVIDENCE");
        objective_add(maps\_utility::obj("OBJ_INVESTIGATE"), "done", &"FACTORY_OBJ_INVESTIGATE_RECORDS");
        var_0 = 0;
      }

      objective_add(maps\_utility::obj("OBJ_ESCAPE"), "active", &"FACTORY_OBJ_ESCAPE_FACTORY");
      objective_state(maps\_utility::obj("OBJ_ESCAPE"), "current");
      common_scripts\utility::flag_wait("car_chase_complete");
      objective_state(maps\_utility::obj("OBJ_ESCAPE"), "done");
    default:
  }
}

jump_to_cleanup() {
  switch (level.start_point) {
    case "chase":
    case "parking_lot":
    case "rooftop":
    case "ambush_escape":
      maps\factory_ambush::ambush_cleanup(1);
    case "ambush":
      maps\factory_weapon_room::sat_cleanup(1);
    case "sat_room":
      maps\factory_weapon_room::presat_cleanup(1);
    case "default":
    case "presat_room":
    case "powerstealth":
    case "factory_ingress":
    case "intro_train":
    case "intro":
    default:
  }
}