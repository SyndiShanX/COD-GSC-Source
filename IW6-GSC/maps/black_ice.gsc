/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice.gsc
*****************************************************/

main() {
  level.timestep = 0.05;
  maps\_utility::template_level("black_ice");
  maps\createart\black_ice_art::main();
  maps\black_ice_fx::main();
  maps\_utility::set_default_start("swim");
  maps\_utility::default_start(::start_swim);
  maps\_utility::add_start("swim", ::start_swim, "Swim", ::main_swim, "black_ice_intro_tr");
  maps\_utility::add_start("camp", ::start_camp, "Camp", ::main_camp, "black_ice_intro_tr");
  maps\_utility::add_start("ascend", ::start_ascend, "Ascend", ::main_ascend, "black_ice_intro_tr");
  maps\_utility::add_start("catwalks", ::start_catwalks, "Catwalks", ::main_catwalks, "black_ice_intro_tr");
  maps\_utility::add_start("catwalks_end", ::start_catwalks_end, "Catwalks End", ::main_catwalks_end, "black_ice_intro_tr");
  maps\_utility::add_start("barracks", ::start_barracks, "Barracks", ::main_barracks, "black_ice_intro_tr");
  maps\_utility::add_start("common_room", ::start_common, "Common Room", ::main_common, "black_ice_intro_tr");
  maps\_utility::add_start("flarestack", ::start_flarestack, "Flarestack", ::main_flarestack, "black_ice_intro_tr");
  maps\_utility::add_start("refinery", ::start_refinery, "Refinery", ::main_refinery, "black_ice_outro_tr");
  maps\_utility::add_start("tanks", ::start_tanks, "Tanks", ::main_tanks, "black_ice_outro_tr");
  maps\_utility::add_start("engine_room", ::start_engine_room, "Engine Room", ::main_engine_room, "black_ice_outro_tr");
  maps\_utility::add_start("mudpumps", ::start_mudpumps, "Mudpumps", ::main_mudpumps, "black_ice_outro_tr");
  maps\_utility::add_start("pipe_deck", ::start_pipe_deck, "Pipe Deck", ::main_pipe_deck, "black_ice_outro_tr");
  maps\_utility::add_start("command_outside", ::start_command_outside, "Command Center Outside", ::main_command, "black_ice_outro_tr");
  maps\_utility::add_start("command_inside", ::start_command, "Command Center Inside", ::main_command, "black_ice_outro_tr");
  maps\_utility::add_start("exfil", ::start_exfil, "Exfil", ::main_exfil, "black_ice_outro_tr");
  mission_precache();
  maps\_utility::intro_screen_create(&"BLACK_ICE_INTROSCREEN_LINE_1", &"BLACK_ICE_INTROSCREEN_LINE_2", &"BLACK_ICE_INTROSCREEN_LINE_3", &"BLACK_ICE_INTROSCREEN_LINE_4");
  maps\_utility::intro_screen_custom_func(::introscreen);
  maps\_utility::transient_init("black_ice_intro_tr");
  maps\_utility::transient_init("black_ice_outro_tr");
  maps\_load::main();
  maps\black_ice_fx::setup_footstep_fx();
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9.01);

  if(maps\_utility::is_gen4()) {
    set_default_mb_values();
  }

  thread common_scripts\_pipes::main();
  level.pipesdamage = 0;
  a_globals();
  maps\black_ice_util_ai::setup_retreat_vols();
  mission_flag_inits();
  maps\black_ice_audio::main();
  maps\black_ice_anim::main();
  maps\_hand_signals::inithandsignals();
  threat_group_inits();
  var_0 = getspawnerarray();
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, maps\black_ice_vignette::vignette_setup);
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, maps\black_ice_util::deathfunc_grenade_drop);
  maps\black_ice_util::spawn_allies();
  maps\black_ice_util::player_setup();
  mission_post_inits();
  vision_sets();
  maps\black_ice_util::array_thread_targetname("trig_ally_cqb_start", maps\black_ice_util::waittill_trigger_ent, level._allies, maps\_utility::enable_cqbwalk);
  maps\black_ice_util::array_thread_targetname("trig_ally_cqb_end", maps\black_ice_util::waittill_trigger_ent, level._allies, maps\_utility::disable_cqbwalk);
  maps\black_ice_util::array_thread_targetname("trig_vignette_interrupt", maps\black_ice_util::waittill_trigger, "notify_vignette_interrupt");
  maps\black_ice_util::array_thread_targetname("trig_ally_catchup", maps\black_ice_util::ally_catchup, level._allies);
  thread objectives();
  thread oil_pumps_animate();
  thread flarestack_swap();
  thread maps\black_ice_fx::fx_init();
  setdvar("music_enable", 1);
}

mission_flag_inits() {
  maps\black_ice_swim::section_flag_inits();
  maps\black_ice_camp::section_flag_inits();
  maps\black_ice_ascend::section_flag_inits();
  maps\black_ice_catwalks::section_flag_inits();
  maps\black_ice_flarestack::section_flag_inits();
  maps\black_ice_refinery::section_flag_inits();
  maps\black_ice_tanks_to_mud_pumps::section_flag_inits();
  maps\black_ice_pipe_deck::section_flag_inits();
  maps\black_ice_command::section_flag_inits();
  maps\black_ice_exfil::section_flag_inits();
}

mission_post_inits() {
  maps\black_ice_swim::section_post_inits();
  maps\black_ice_camp::section_post_inits();
  maps\black_ice_catwalks::section_post_inits();
  maps\black_ice_flarestack::section_post_inits();
  maps\black_ice_refinery::section_post_inits();
  maps\black_ice_tanks_to_mud_pumps::section_post_inits();
  maps\black_ice_pipe_deck::section_post_inits();
  maps\black_ice_command::section_post_inits();
  maps\black_ice_exfil::section_post_inits();
}

mission_precache() {
  precacheitem("aps_underwater");
  precacheitem("r5rgp");
  precacheitem("sc2010");
  precacheitem("p226");
  precacheitem("test_detonator_black_ice");
  precacheshellshock("blackice_nosound");
  precacheshellshock("default");
  precacheshellshock("slowview");
  precacherumble("tank_rumble");
  precacherumble("helo_ladder_swing");
  precacherumble("hind_flyover");
  precacherumble("lever_feedback_light");
  precacherumble("lever_feedback_heavy");
  precacheitem("hellfire_missile_af_caves");
  precachemodel("weapon_p226");
  precachemodel("viewhands_us_udt");
  precachemodel("viewhands_player_us_udt");
  objective_string_precache();
  maps\black_ice_precache::main();
  maps\black_ice_swim::section_precache();
  maps\black_ice_camp::section_precache();
  maps\black_ice_ascend::section_precache();
  maps\black_ice_catwalks::section_precache();
  maps\black_ice_flarestack::section_precache();
  maps\black_ice_refinery::section_precache();
  maps\black_ice_tanks_to_mud_pumps::section_precache();
  maps\black_ice_pipe_deck::section_precache();
  maps\black_ice_command::section_precache();
  maps\black_ice_exfil::section_precache();
}

a_globals() {
  level._enemies = [];
  level._allies = [];
  level._bravo = [];
  level._vehicles = [];
  getdvarint("bi_command_pressure_trial", 0);
  setdvar("bi_command_pressure_trial", 0);
}

threat_group_inits() {
  createthreatbiasgroup("bravo");
  createthreatbiasgroup("player");
  createthreatbiasgroup("bc_lmg");
  createthreatbiasgroup("bc_killme");
  createthreatbiasgroup("cw_low_balcony");
  createthreatbiasgroup("ignore_allies");
  setignoremegroup("allies", "ignore_allies");
  setignoremegroup("ignore_allies", "allies");
  createthreatbiasgroup("ignore_bravo");
  setignoremegroup("bravo", "ignore_bravo");
}

vision_sets() {
  maps\black_ice_util::vision_watcher("flag_vision_campinteriors", "black_ice_tent_interior", 1, "black_ice_basecamp", 1);
  maps\black_ice_util::vision_watcher("flag_vision_refinery_to_tanks", "", 0, "", 0);
  thread maps\black_ice_util::flag_watcher("flag_vision_engine_room", ::vision_engine_room_start, ::vision_engine_room_end);
  thread maps\black_ice_util::flag_watcher("flag_vision_mudpumps", ::vision_mudpumps_start, ::vision_mudpumps_end);
  maps\black_ice_util::vision_watcher("flag_vision_pipedeck_off", "", 0, "", 0);
  maps\black_ice_util::vision_watcher("flag_vision_pipedeck_on", "black_ice_pipedeck", 0, "black_ice_pipedeck", 0);
  maps\black_ice_util::vision_watcher("flag_vision_command", "black_ice_command", 3.0, "black_ice", 3.0);
  maps\black_ice_util::vision_watcher("flag_vision_exfil_deck", "black_ice_exfil_deck", 1.5, "black_ice_flyout", 2.0);
}

vision_engine_room_start() {
  level.player thread maps\black_ice_tanks_to_mud_pumps::player_smoke_duck();
}

vision_engine_room_end() {
  level.player thread maps\black_ice_tanks_to_mud_pumps::player_smoke_duck_end();
}

vision_mudpumps_start() {
  common_scripts\utility::exploder("mud_pumps");
  common_scripts\utility::exploder("mud_pumps_lights");
  maps\_utility::stop_exploder("engineroom_01");
}

vision_mudpumps_end() {
  maps\_utility::stop_exploder("mud_pumps");
  maps\_utility::stop_exploder("mud_pumps_lights");
  maps\_utility::stop_exploder("engineroom_02");
}

start_swim() {
  maps\black_ice_swim::start();
  weapon_alt_check();
}

main_swim() {
  thread flarestack_swap(1);
  maps\black_ice_swim::main();
}

start_camp() {
  thread flarestack_swap(1);
  maps\black_ice_camp::start();
  weapon_alt_check();
}

main_camp() {
  maps\black_ice_camp::main();
}

start_ascend() {
  maps\black_ice_ascend::start();
  weapon_alt_check();
}

main_ascend() {
  maps\black_ice_ascend::main();
}

start_catwalks() {
  maps\black_ice_catwalks::start_catwalks();
  weapon_alt_check();
}

main_catwalks() {
  maps\black_ice_catwalks::main_catwalks();
}

start_catwalks_end() {
  maps\black_ice_catwalks::start_catwalks_end();
  weapon_alt_check();
}

main_catwalks_end() {
  maps\black_ice_catwalks::catwalks_end();
}

start_barracks() {
  maps\black_ice_catwalks::start_barracks();
  weapon_alt_check();
}

main_barracks() {
  maps\black_ice_catwalks::main_barracks();
}

start_common() {
  maps\black_ice_catwalks::start_common();
  weapon_alt_check();
}

main_common() {
  maps\black_ice_catwalks::main_common();
}

start_flarestack() {
  maps\black_ice_flarestack::start();
  weapon_alt_check();
}

main_flarestack() {
  thread transient_load_outro_and_save();
  maps\black_ice_flarestack::main();
}

transient_load_outro_and_save() {
  if(!istransientqueued("black_ice_outro_tr")) {
    maps\_utility::transient_unloadall_and_load("black_ice_outro_tr");
  }

  while(!istransientloaded("black_ice_outro_tr")) {
    wait(level.timestep);
  }

  maps\_utility::autosave_by_name("flarestack");
}

start_refinery() {
  maps\black_ice_refinery::start();
  weapon_alt_check();
}

main_refinery() {
  maps\_utility::autosave_by_name("refinery");
  maps\black_ice_refinery::main();
}

start_tanks() {
  maps\black_ice_tanks_to_mud_pumps::start_tanks();
  weapon_alt_check();
  maps\black_ice_audio::sfx_fire_tower_spawn();
  maps\black_ice_refinery::util_derrick_destroy_quick();
}

main_tanks() {
  maps\_utility::autosave_by_name("tanks");
  synctransients();
  maps\black_ice_tanks_to_mud_pumps::main_tanks();
}

start_engine_room() {
  maps\black_ice_tanks_to_mud_pumps::start_engine_room();
  weapon_alt_check();
  thread maps\black_ice_audio::sfx_fire_tower_spawn();
  maps\black_ice_refinery::util_derrick_destroy_quick();
}

main_engine_room() {
  maps\_utility::autosave_by_name("engine_room");
  maps\black_ice_tanks_to_mud_pumps::main_engine_room();
}

start_mudpumps() {
  maps\black_ice_tanks_to_mud_pumps::start_mudpumps();
  weapon_alt_check();
  maps\black_ice_audio::sfx_fire_tower_spawn();
  maps\black_ice_refinery::util_derrick_destroy_quick();
}

main_mudpumps() {
  maps\_utility::autosave_by_name("mudpumps");
  maps\black_ice_tanks_to_mud_pumps::main_mudpumps();
}

start_pipe_deck() {
  maps\black_ice_pipe_deck::start();
  weapon_alt_check();
  thread maps\black_ice_audio::sfx_fire_tower_spawn();
  maps\black_ice_refinery::util_derrick_destroy_quick();
}

main_pipe_deck() {
  maps\_utility::autosave_by_name("pipe_deck");
  maps\black_ice_pipe_deck::main();
}

start_command_outside() {
  maps\black_ice_command::start_outside();
  weapon_alt_check();
  thread maps\black_ice_audio::sfx_fire_tower_spawn();
  maps\black_ice_refinery::util_derrick_destroy_quick();
}

start_command() {
  maps\black_ice_command::start_inside();
  weapon_alt_check();
  thread maps\black_ice_audio::sfx_fire_tower_spawn();
  maps\black_ice_refinery::util_derrick_destroy_quick();
}

main_command() {
  maps\_utility::autosave_by_name("command");
  maps\black_ice_command::main();
}

start_exfil() {
  maps\black_ice_exfil::start();
  weapon_alt_check();
  maps\black_ice_refinery::util_derrick_destroy_quick();
}

main_exfil() {
  maps\_utility::autosave_by_name("exfil");
  maps\black_ice_exfil::main();
}

weapon_alt_check() {
  if(level.default_weapon == "m4_hybrid_grunt_optim") {
    level.default_weapon = "alt_" + level.default_weapon;
    level.player switchtoweaponimmediate(level.default_weapon);
  }
}

objective_string_precache() {
  precachestring(&"BLACK_ICE_OBJ_SWIM_DETONATE");
  precachestring(&"BLACK_ICE_OBJ_CAMP_CLEAR_CAMP");
  precachestring(&"BLACK_ICE_OBJ_ASCEND_ASCEND");
  precachestring(&"BLACK_ICE_OBJ_FLARESTACK_FIGHT_TO");
  precachestring(&"BLACK_ICE_OBJ_FLARESTACK_SHUT_OFF");
  precachestring(&"BLACK_ICE_OBJ_COMMAND_FIGHT_TO");
  precachestring(&"BLACK_ICE_OBJ_COMMAND_DISABLE_SUPPRESSION");
  precachestring(&"BLACK_ICE_OBJ_EXFIL_GET_TO_HELI");
}

objectives() {
  switch (level.start_point) {
    case "swim":
      level waittill("notify_swim_dialog5_1");
      objective_add(maps\_utility::obj("obj_swim_detonate_charges"), "current", &"BLACK_ICE_OBJ_SWIM_DETONATE");
      common_scripts\utility::flag_wait("flag_swim_breach_detonate");
      maps\_utility::objective_complete(maps\_utility::obj("obj_swim_detonate_charges"));
    case "camp":
      level waittill("bc_player_ready");
      objective_add(maps\_utility::obj("obj_camp_clear_camp"), "current", &"BLACK_ICE_OBJ_CAMP_CLEAR_CAMP");
      common_scripts\utility::flag_wait("flag_camp_cleared");
      wait 2.5;
      maps\_utility::objective_complete(maps\_utility::obj("obj_camp_clear_camp"));
    case "ascend":
      wait 1;
      objective_add(maps\_utility::obj("obj_ascend_ascend"), "current", &"BLACK_ICE_OBJ_ASCEND_ASCEND");
      level waittill("notify_ascend_objective_complete");
      maps\_utility::objective_complete(maps\_utility::obj("obj_ascend_ascend"));
    case "common_room":
    case "barracks":
    case "catwalks":
      wait 1;
      objective_add(maps\_utility::obj("obj_flarestack_fight_to"), "current", &"BLACK_ICE_OBJ_FLARESTACK_FIGHT_TO");
      common_scripts\utility::flag_wait("flag_flarestack_scene_start");
      maps\_utility::objective_complete(maps\_utility::obj("obj_flarestack_fight_to"));
    case "flarestack":
      level waittill("notify_activate_flarestack_console");
      objective_add(maps\_utility::obj("obj_flarestack_shut_off"), "current", &"BLACK_ICE_OBJ_FLARESTACK_SHUT_OFF");
      level waittill("notify_flare_stack_off");
      maps\_utility::objective_complete(maps\_utility::obj("obj_flarestack_shut_off"));
      common_scripts\utility::flag_wait("flag_flarestack_end");
    case "pipe_deck":
    case "engine_room":
    case "tanks":
    case "refinery":
      objective_add(maps\_utility::obj("obj_command_fight_to_command_center"), "current", &"BLACK_ICE_OBJ_COMMAND_FIGHT_TO");
      level waittill("notify_pipedeck_final_battle_start");
      maps\_utility::objective_complete(maps\_utility::obj("obj_command_fight_to_command_center"));
      level waittill("dialogue_mgs_done");
      objective_add(maps\_utility::obj("obj_command_take_out_mgs"), "current", &"BLACK_ICE_OBJ_PIPEDECK_TURRETS");
      common_scripts\utility::flag_wait("flag_pipe_deck_mgs_down");
      maps\_utility::objective_complete(maps\_utility::obj("obj_command_take_out_mgs"));
    case "command_inside":
    case "command_outside":
      common_scripts\utility::flag_wait("flag_objective_fire_supression");
      objective_add(maps\_utility::obj("obj_command_disable_suppression"), "current", &"BLACK_ICE_OBJ_COMMAND_DISABLE_SUPPRESSION");
      common_scripts\utility::flag_wait("flag_command_done");
      maps\_utility::objective_complete(maps\_utility::obj("obj_command_disable_suppression"));
    case "exfil":
      objective_add(maps\_utility::obj("obj_exfil_get_to_heli"), "current", &"BLACK_ICE_OBJ_EXFIL_GET_TO_HELI");
      level waittill("player_ladder_success");
      maps\_utility::objective_complete(maps\_utility::obj("obj_exfil_get_to_heli"));
  }
}

oil_pumps_animate() {
  var_0 = getEntArray("oil_pump", "targetname");

  foreach(var_2 in var_0) {
    var_2.animname = "oil_pump";
    var_2 maps\_utility::assign_animtree();
    var_3 = randomfloatrange(0.5, 2.0);
    var_2 setanim(level.scr_anim["oil_pump"]["motion"], 1.0, 0.1, var_3);
  }
}

trains_periph_logic(var_0, var_1) {
  var_2 = 6;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = getEntArray("train_" + var_3, "targetname");
    var_5 = getent("train_control_node_" + var_3, "targetname");
    var_5.init_origin = var_5.origin;
    var_5.trains = [];

    foreach(var_7 in var_4) {
      var_7 show();
      var_7 linkto(var_5);
      var_5.trains[var_5.trains.size] = var_7;
    }

    thread trains_move(var_0, var_5, var_1);
  }
}

trains_move(var_0, var_1, var_2) {
  wait(var_0);
  var_3 = 288.0;
  var_4 = 100.0;
  var_5 = getent("train_target_node", "targetname");
  var_6 = var_3 * level.timestep;
  var_7 = var_5.origin - var_1.origin;

  while(lengthsquared(var_7) > var_4) {
    var_7 = var_5.origin - var_1.origin;
    var_8 = vectornormalize(var_7);
    var_1.origin = var_1.origin + var_8 * var_6;
    wait(level.timestep);
  }

  if(var_2) {
    foreach(var_10 in var_1.trains) {
    var_10 delete();
    }

    var_1 delete();
  } else {
    foreach(var_10 in var_1.trains) {
    var_10 hide();
    }

    var_1.origin = var_1.init_origin;
  }
}

flarestack_swap(var_0) {
  var_1 = getEntArray("flamestack_anim", "targetname");
  var_2 = getEntArray("flarestack_optimized", "targetname");

  if(isDefined(var_0) && var_0) {
    foreach(var_4 in var_1) {
    var_4 hide();
    }

    foreach(var_4 in var_2) {
    var_4 show();
    }
  } else {
    foreach(var_4 in var_2) {
    var_4 hide();
    }

    foreach(var_4 in var_1) {
    var_4 show();
    }
  }
}

introscreen() {
  level.player freezecontrols(1);
  level.player common_scripts\utility::delaycall(2, ::freezecontrols, 0);
  maps\_introscreen::introscreen(1);
}

set_default_mb_values() {
  if(!level.ps4) {
    setsaveddvar("r_mbEnable", 2);
    setsaveddvar("r_mbFastEnable", 1);
    setsaveddvar("r_mbFastPreset", 2);
    setsaveddvar("r_mbCameraRotationInfluence", 0.07);
    setsaveddvar("r_mbCameraTranslationInfluence", 0.15);
    setsaveddvar("r_mbModelVelocityScalar", 0.5);
    setsaveddvar("r_mbStaticVelocityScalar", 0.2);
    setsaveddvar("r_mbViewModelEnable", 1);
    setsaveddvar("r_mbViewModelVelocityScalar", 0.004);
  }
}