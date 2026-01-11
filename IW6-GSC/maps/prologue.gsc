/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\prologue.gsc
*****************************************************/

main() {
  maps\_utility::template_level("prologue");
  maps\createart\prologue_art::main();
  maps\prologue_fx::main();
  maps\prologue_precache::main();
  level.prologue = 1;
  maps\youngblood::youngblood_earthquake_setup();
  maps\youngblood_fx::main();
  maps\odin_fx::main();
  precacheshader("logo_game_big");
  precacheshader("logo_game_big_blur_blend");

  if(maps\_utility::is_gen4()) {
    precacheshader("glare_expand");
    setsaveddvar("r_ssaofadedepth", 256);
    setsaveddvar("r_ssaorejectdepth", 1024);
  }

  maps\youngblood::yb_precache();
  maps\odin::odin_precache();
  level.player allowlean(0);
  maps\_utility::default_start();
  maps\_utility::add_start("start_deer", maps\youngblood::setup_deer, undefined, maps\youngblood::start_deer, "prologue_transient_ground_tr");
  maps\_utility::add_start("start_after_hunt", maps\youngblood::setup_after_hunt, undefined, maps\youngblood::start_after_hunt, "prologue_transient_ground_tr");
  maps\_utility::add_start("start_woods", maps\youngblood::setup_woods, undefined, maps\youngblood::start_woods, "prologue_transient_ground_tr");
  maps\_utility::add_start("start_neighborhood", maps\youngblood::setup_neighborhood, undefined, maps\youngblood::start_neighborhood, "prologue_transient_ground_tr");
  maps\_utility::add_start("start_mansion_ext", maps\youngblood::setup_mansion_ext, undefined, maps\youngblood::start_mansion_ext, "prologue_transient_ground_tr");
  maps\_utility::add_start("start_mansion", maps\youngblood::setup_mansion, undefined, maps\youngblood::start_mansion, "prologue_transient_ground_tr");
  maps\_utility::add_start("odin_intro", maps\odin::start_odin_intro, "Odin Intro", maps\odin::odin_intro, "prologue_transient_odin_tr");
  maps\_utility::add_start("odin_ally", maps\odin::start_odin_ally, "Odin Ally", maps\odin::odin_ally, "prologue_transient_odin_tr");
  maps\_utility::add_start("odin_escape", maps\odin::start_odin_escape, "Odin Escape", maps\odin::odin_escape, "prologue_transient_odin_tr");
  maps\_utility::add_start("odin_spin", maps\odin::start_odin_spin, "Odin Spin", maps\odin::odin_spin, "prologue_transient_odin_tr");
  maps\_utility::add_start("odin_satellite", maps\odin::start_odin_satellite, "Odin Satellite", maps\odin::odin_satellite, "prologue_transient_odin_tr");
  maps\_utility::add_start("start_chaos_a", maps\youngblood::setup_chaos_a, undefined, maps\youngblood::start_chaos_a, "prologue_transient_ground_tr");
  maps\_utility::add_start("start_chaos_b", maps\youngblood::setup_chaos_b, undefined, maps\youngblood::start_chaos_b, "prologue_transient_ground_tr");
  maps\_utility::add_start("start_pickup", maps\youngblood::setup_pickup, undefined, maps\youngblood::start_pickup, "prologue_transient_ground_tr");
  maps\_utility::add_start("start_test", maps\youngblood::start_test, undefined);
  maps\_utility::add_start("start_test_area_a", maps\youngblood::start_test_area_a, undefined);
  maps\_utility::add_start("start_test_area_b", maps\youngblood::start_test_area_b, undefined);
  maps\_utility::transient_init("prologue_transient_odin_tr");
  maps\_utility::transient_init("prologue_transient_ground_tr");
  maps\_load::main();
  maps\prologue_audio::main();
  maps\youngblood_audio::main();
  maps\odin_audio::main();
  level.space_breathing_enabled = 0;
  maps\youngblood_anim::main();
  maps\odin_anim::main();
  maps\odin::odin_flag_inits();
  maps\odin::odin_hint_string_init();
  maps\odin_fx::fx_init();
  thread maps\_space_player::init_player_space();
  thread maps\_space_ai::init_ai_space();
  maps\youngblood::yb_flag_inits();
  maps\youngblood::youngblood_script_setup();
  maps\youngblood::yb_setup();
  maps\_drone_deer::init();
  thread prologue_transition_to_odin();
  thread prologue_transition_back_to_youngblood();
  common_scripts\utility::trigger_off("player_push_trigger", "script_noteworthy");
  common_scripts\utility::flag_init("transition_from_odin_to_yb_done");
}

prologue_transition_to_odin() {
  common_scripts\utility::flag_wait("start_transition_to_odin");
  level.pre_odin_pos = level.player.origin;
  level.pre_odin_ang = level.player.angles;
  maps\_utility::transient_switch("prologue_transient_ground_tr", "prologue_transient_odin_tr");
  level.player freezecontrols(1);
  level.player unlink();
  level.player playersetgroundreferenceent(undefined);
  maps\odin::odin_script_setup();
  common_scripts\utility::flag_set("do_transition_to_odin");
  level.player allowsprint(1);
  wait 1.5;
  setsaveddvar("g_speed", 190);
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9.01);
  level.player freezecontrols(0);
}

prologue_transition_back_to_youngblood() {
  common_scripts\utility::flag_wait("start_transition_to_youngblood");
  level notify("stop_weapon_drop_scripts");
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 2.5);

  if(maps\_utility::is_gen4()) {
    setsaveddvar("r_mbEnable", 0);
    setglaregrimematerial("glare_expand");
  }

  level.gameskill_breath_func = undefined;
  level.player springcamdisabled(0.0);
  level.space_breathing_enabled = 0;
  level notify("stop_particulates");
  var_0 = [];
  var_0 = maps\_utility::getfxarraybyid("space_particulate_player_oneshot");
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("space_particulate_player_view"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("space_particulate_player_mov"));

  foreach(var_2 in var_0) {
    if(common_scripts\utility::fxexists(var_2)) {
      var_2 common_scripts\utility::pauseeffect();
    }
  }

  if(isDefined(level.ally)) {
    level.ally delete();
  }

  level.player takeallweapons();
  level.player unlink();
  level.player freezecontrols(1);
  level.player maps\_space_player::disable_player_space();
  setsaveddvar("hud_showStance", 0);
  maps\odin_satellite::satellite_cleanup(0);
  common_scripts\utility::flag_clear("enable_player_thruster_audio");
  level notify("kill_thrusters");

  if(isDefined(level.sunflare)) {
    stopFXOnTag(level._effect["sun_lens_flare"], level.sunflare, "tag_origin");
  }

  thread maps\_utility::transient_switch("prologue_transient_odin_tr", "prologue_transient_ground_tr");
  maps\_utility::delaythread(2.95, maps\_utility::smart_radio_dialogue, "youngblood_hsh_readypush2");

  if(isDefined(level.pre_odin_pos)) {
    level.player setclienttriggeraudiozone("youngblood_slomo_impact", 0.2);
    level.player common_scripts\utility::delaycall(0.2, ::setorigin, level.pre_odin_pos);

    if(isDefined(level.pre_odin_ang)) {
      level.player common_scripts\utility::delaycall(0.2, ::setplayerangles, level.pre_odin_ang);
    }
  }

  wait 6.4;
  level.pre_odin_pos = undefined;
  level.pre_odin_ang = undefined;

  if(isDefined(level.sunflare)) {
    level.sunflare delete();
  }

  common_scripts\utility::flag_wait("prologue_transient_ground_tr_loaded");
  level.player showhud();
  maps\odin_util::move_player_to_start_point("player_back_to_earth_tp");
  setsaveddvar("player_spaceViewHeight", 60);
  setsaveddvar("player_spaceCapsuleHeight", 70);
  setsaveddvar("phys_gravity_ragdoll", -800);
  setsaveddvar("phys_gravity", -800);
  setsaveddvar("phys_autoDisableLinear", 20.0);
  setsaveddvar("g_gravity", 800);
  setsaveddvar("g_speed", 190);
  level.player setmovespeedscale(1.0);
  setsaveddvar("bg_viewBobAmplitudeStanding", "0.007 0.007");
  setsaveddvar("bg_viewBobAmplitudeStandingAds", "0.007 0.007");
  setsaveddvar("bg_viewBobAmplitudeDucked", "0.0075 0.0075");
  setsaveddvar("bg_viewBobAmplitudeDuckedAds", "0.0075 0.0075");
  setsaveddvar("bg_viewBobAmplitudeSprinting", "0.02 0.014");
  setsaveddvar("bg_weaponBobAmplitudeStanding", "0.055 0.025");
  setsaveddvar("bg_weaponBobAmplitudeDucked", "0.045 0.025");
  setsaveddvar("bg_weaponBobAmplitudeSprinting", "0.02 0.014");
  setsaveddvar("bg_weaponBobAmplitudeBase", 0.16);
  setsaveddvar("bg_viewBobMax", 8.0);
  earthquake(0.1, 0.1, (0, 0, 0), 1);
  common_scripts\utility::flag_set("transition_from_odin_to_yb_done");
}

delete_beginning_ents() {
  maps\_utility::battlechatter_off();
  animscripts\battlechatter::shutdown_battlechatter();
  var_0 = getEntArray();
  iprintlnbold(var_0.size);
  var_1 = common_scripts\utility::get_target_ent("yb_ground_volume");
  common_scripts\utility::array_thread(var_1.fx, common_scripts\utility::pauseeffect);
  wait 1;

  foreach(var_3 in var_0) {
    if(var_3 != var_1 && !isplayer(var_3) && var_3 != level.mover_object && isDefined(var_3.classname) && var_3.classname != "script_origin") {
      if(isDefined(var_3.origin)) {
        level.mover_object.origin = var_3.origin;

        if(level.mover_object istouching(var_1)) {
          var_3 delete();
        }
      }
    }
  }
}