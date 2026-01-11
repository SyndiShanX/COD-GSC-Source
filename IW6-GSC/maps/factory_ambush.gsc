/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_ambush.gsc
*****************************************************/

start() {
  maps\factory_util::actor_teleport(level.squad["ALLY_ALPHA"], "ambush_start_alpha");
  maps\factory_util::actor_teleport(level.squad["ALLY_BRAVO"], "ambush_start_bravo");
  maps\factory_util::actor_teleport(level.squad["ALLY_CHARLIE"], "ambush_start_charlie");
  thread ambush_dest_screens();
  level.squad["ALLY_ALPHA"] thread maps\_utility::enable_cqbwalk();
  level.squad["ALLY_BRAVO"] thread maps\_utility::enable_cqbwalk();
  level.squad["ALLY_CHARLIE"] thread maps\_utility::enable_cqbwalk();
  maps\factory_util::safe_trigger_by_targetname("ambush_intro_ally01_position");
  maps\factory_util::safe_trigger_by_targetname("ambush_intro_ally02_position");
  maps\factory_util::safe_trigger_by_targetname("ambush_intro_ally03_position");
  level.player maps\factory_util::move_player_to_start_point("playerstart_ambush");
  common_scripts\utility::flag_set("lgt_ambush_jump");
  thread maps\factory_anim::factory_assembly_line_play();
  level thread maps\factory_util::open_door("ambush_door_pivot_left", -160, 0.5, 1);
  level thread maps\factory_util::open_door("ambush_door_pivot_right", 145, 0.5, 1);
  thread ambush_setup();
  thread maps\factory_intro::train_cleanup();
  wait 0.1;
}

section_precache() {
  precachemodel("fac_keyboard_obj");
  precachemodel("factory_ambush_monitor_obj");
  precachemodel("fac_io_device_obj");
  precachemodel("factory_assembly_automated_arm_damaged");
  precacheitem("smoke_grenade_factory");
  precacheshader("nightvision_overlay_goggles");
  precacheshellshock("flashbang");
}

section_flag_init() {
  common_scripts\utility::flag_init("factory_assembly_line_resume_speed_front");
  common_scripts\utility::flag_init("factory_assembly_line_resume_speed_back");
  common_scripts\utility::flag_init("enable_ambush_use");
  common_scripts\utility::flag_init("player_used_computer");
  common_scripts\utility::flag_init("ambush_start_fx");
  common_scripts\utility::flag_init("ambush_vignette_done");
  common_scripts\utility::flag_init("ambush_moment_clear");
  common_scripts\utility::flag_init("ambush_prep_smoke_01");
  common_scripts\utility::flag_init("ambush_smoke_01");
  common_scripts\utility::flag_init("ambush_used_thermal");
  common_scripts\utility::flag_init("walking_cough_guy_done");
  common_scripts\utility::flag_init("ambush_thermal_flashed");
  common_scripts\utility::flag_init("ambush_arm_malfunction");
  common_scripts\utility::flag_init("ambush_thermal_allies_movedup_01");
  common_scripts\utility::flag_init("ambush_wave_3_done");
  common_scripts\utility::flag_init("ambush_lower_back_clear");
  common_scripts\utility::flag_init("thermal_battle_clear");
  common_scripts\utility::flag_init("stop_smoke_penalty");
  common_scripts\utility::flag_init("stop_assembly_line");
  common_scripts\utility::flag_init("lgt_ambush_jump");
}

section_hint_string_init() {
  maps\_utility::add_hint_string("HINT_THERMAL", &"FACTORY_HINT_THERMAL", ::hint_thermal_timeout);
  maps\_utility::add_hint_string("HINT_THERMAL_OFF", &"FACTORY_HINT_THERMAL_OFF", ::hint_thermal_off_timeout);
  maps\_utility::add_hint_string("HINT_THERMAL_SHORT", &"FACTORY_HINT_THERMAL_SHORT", ::hint_thermal_timeout);
  maps\_utility::add_hint_string("HINT_THERMAL_OFF_SHORT", &"FACTORY_HINT_THERMAL_OFF_SHORT", ::hint_thermal_off_timeout);
}

main() {
  maps\_utility::autosave_by_name("ambush");
  thread break_ambush_glass();
  var_0 = common_scripts\utility::getstruct("ambush_anim_node", "script_noteworthy");
  level thread maps\factory_anim::ambush_cables(var_0);
  level thread ambush_dialogue();
  thread maps\factory_rooftop::rooftop_heli();
  thread maps\factory_audio::ambush_line_emitter_create();
  level thread ambush_moment_logic();
  thread maps\factory_audio::sfx_pa_bursts();
  level thread thermal_battle_logic();
  common_scripts\utility::flag_wait("thermal_battle_clear");
  ambush_cleanup();
  common_scripts\utility::flag_set("stop_assembly_line");
  level notify("stop_assembly_line");
  wait 2.5;
}

ambush_setup() {
  level.ambush_threat_boost = 2600;
  level.player.maxvisibledist = 1280;
  level.flood_spawner_limited_cap = 9;
  level thread setup_ambush_flood_spawner_limited_triggers();

  foreach(var_1 in level.squad) {
    var_1.fixednodesaferadius = 256;
    var_1.script_accuracy = 0.5;
    var_1.suppressionwait = 3500;
    var_1.usechokepoints = 0;
    var_1 pushplayer(1);
  }

  var_3 = getEntArray("ambush_desk_prop_post", "targetname");
  var_4 = getEntArray("ambush_desk_post", "targetname");
  var_3 = common_scripts\utility::array_combine(var_3, var_4);

  foreach(var_6 in var_3) {
    if(isDefined(var_6.script_parameters)) {
      var_6 connectpaths();
    }

    var_6 notsolid();
    var_6 hide();
  }

  var_8 = getEntArray("smoke_canister", "script_noteworthy");

  foreach(var_10 in var_8) {
    var_10 hide();
  }

  var_12 = getent("ambush_breach_player_pda", "targetname");
  var_12 hide();
  maps\_utility::set_custom_gameskill_func(::factory_ambush_grenade_params);
  var_13 = getEntArray("ambush_window_mantle", "targetname");

  foreach(var_15 in var_13) {
    var_15 movez(-100, 0.1);
  }

  var_17 = [];
  var_17 = getEntArray("ambush_fan", "targetname");

  foreach(var_19 in var_17) {
    var_19 thread ambush_fan_spin();
  }

  thread maps\factory_anim::ambush_anim_setup();
  maps\factory_fx::fx_assembly_setup();

  if(!level.player.thermal) {
    common_scripts\utility::exploder("assembly_ambient_off_in_thermal");
  }

  setlasermaterial("fac_gfx_laser", "fac_gfx_laser_light");
  maps\factory_anim::setup_smoke_archetype();
  var_21 = getent("ambush_smoke_volume", "targetname");
  maps\_utility::array_spawn_function_targetname("ambush_groundtroops_01", ::enemy_smoke_reaction, var_21);
  maps\_utility::array_spawn_function_targetname("ambush_groundtroops_02", ::enemy_smoke_reaction, var_21);
  maps\_utility::array_spawn_function_noteworthy("ambush_fastropers", ::enemy_smoke_reaction, var_21);
  level.squad["ALLY_ALPHA"] thread ally_smoke_reaction_vision(var_21);
  level.squad["ALLY_BRAVO"] thread ally_smoke_reaction_vision(var_21);
  level.squad["ALLY_CHARLIE"] thread ally_smoke_reaction_vision(var_21);
  common_scripts\utility::flag_wait("ambush_escape_spawn_helis");
}

ambush_dialogue() {
  common_scripts\utility::flag_wait("start_ambush_moment");
  var_0 = getent("ambush_office_volume", "targetname");

  while(!level.squad["ALLY_ALPHA"] istouching(var_0)) {
    wait 0.2;
  }

  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_grabthedata");
  var_1 = ["factory_mrk_adamusethecomputer", "factory_mrk_adamgivemea", "factory_mrk_adamoverhere"];
  level.squad["ALLY_ALPHA"] thread maps\factory_util::nag_line_generator(var_1, "player_used_computer", undefined, 7);
  common_scripts\utility::flag_set("enable_ambush_use");
  common_scripts\utility::flag_wait("ambush_triggered");
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_hsh_lookslikemanufacturing");
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_hsh_thesatelliewefound");
  wait 7.0;
  maps\_utility::smart_radio_dialogue("factory_kck_jerichowevegotmovement");
  common_scripts\utility::flag_wait("ambush_vignette_done");
  wait 1.0;
  level thread ambush_dialogue_pinned_reactions();
  common_scripts\utility::flag_wait_any("ambush_prep_smoke_01", "player_left_ambush_room");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_okweblindem");
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_hsh_smokeready");
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_kgn_smokeready");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_popsmoke");
  wait 1.2;
  common_scripts\utility::flag_set("ambush_smoke_01");
  level.player thread maps\factory_util::thermal_vision();
  level thread maps\factory_fx::fx_track_thermal();
  level thread ambush_dialogue_flashbangs();
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_kgn_smokeout_2");
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_mrk_smokeisout");
  wait 1.4;
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_gotothermals");
  level thread show_thermal_tooltip(1);
  level thread thermal_off_tooltip_handler();
  common_scripts\utility::flag_wait("ambush_thermal_allies_movedup_01");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_totheoffices");
  wait 1.0;
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  level thread ambush_thermal_push_dialog();
  level thread ambush_smoke_clear_dialog();
  common_scripts\utility::flag_wait("thermal_battle_clear");
  wait 0.55;
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_rgs_clear");
  wait 0.25;
  level.squad["ALLY_BRAVO"] maps\_utility::smart_dialogue("factory_diz_clear2");
}

ambush_dialogue_pinned_reactions() {
  level endon("player_left_ambush_room");

  if(common_scripts\utility::flag("player_left_ambush_room")) {
    return;
  }
  wait 1.2;
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_rookstaydown");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_holdthisposition");
  wait 0.8;
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_housemainweare_2");
  wait 0.2;
  maps\_utility::smart_radio_dialogue("factory_hqr_negativejerichoarclightis");
  wait 0.15;
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_hsh_shitwedonot");
  level.squad["ALLY_BRAVO"] maps\_utility::smart_dialogue("factory_kgn_wevegotmoreincoming");
  wait 1.1;
  wait 1.5;
  wait 0.66;
  wait 0.8;
  wait 0.4;
  common_scripts\utility::flag_set("ambush_moment_clear");
}

ambush_thermal_push_dialog() {
  level endon("ambush_smoke_off_tooltip");
  level.squad["ALLY_BRAVO"] maps\_utility::smart_dialogue("factory_kgn_twodown");
  common_scripts\utility::flag_wait("ambush_progress_flag_1");
  level.squad["ALLY_BRAVO"] maps\_utility::smart_dialogue("factory_kgn_threemoreekia");
  wait 2.5;
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_keeppushingforward");
  wait 4.1;
  level.squad["ALLY_BRAVO"] maps\_utility::smart_dialogue("factory_hsh_droppingem");
  wait 4.6;
  level.squad["ALLY_BRAVO"] maps\_utility::smart_dialogue("factory_mrk_goingdown");
  wait 2.25;
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_dontstop");
}

ambush_smoke_clear_dialog() {
  level endon("thermal_battle_clear");
  common_scripts\utility::flag_wait("ambush_thermal_flashed");

  while(level.player common_scripts\utility::isflashed()) {
    wait 0.1;
  }

  wait 6.5;
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_hsh_mythermalsarefried");
  wait 0.2;
  level.squad["ALLY_BRAVO"] maps\_utility::smart_dialogue("factory_kgn_minetoo");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_govisorsofflose");
  wait 8.0;
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_dontstopwehave");
}

ambush_dialogue_flashbangs() {
  common_scripts\utility::flag_wait("ambush_smoke_off_tooltip");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_hsh_flashbang");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_flashbangsgetdown");
}

factory_ambush_grenade_params() {
  level.difficultysettings["playerGrenadeBaseTime"]["easy"] = 48000;
  level.difficultysettings["playerGrenadeBaseTime"]["normal"] = 42000;
  level.difficultysettings["playerGrenadeBaseTime"]["hardened"] = 25000;
  level.difficultysettings["playerGrenadeBaseTime"]["veteran"] = 25000;
  level.difficultysettings["playerGrenadeRangeTime"]["easy"] = 24000;
  level.difficultysettings["playerGrenadeRangeTime"]["normal"] = 18000;
  level.difficultysettings["playerGrenadeRangeTime"]["hardened"] = 10000;
  level.difficultysettings["playerGrenadeRangeTime"]["veteran"] = 10000;
  level.difficultysettings["double_grenades_allowed"]["easy"] = 0;
  level.difficultysettings["double_grenades_allowed"]["normal"] = 0;
  level.difficultysettings["double_grenades_allowed"]["hardened"] = 1;
  level.difficultysettings["double_grenades_allowed"]["veteran"] = 1;
}

ambush_moment_logic() {
  thread setup_computer_use_hint();
  common_scripts\utility::flag_wait("entered_pre_ambush_room");
  maps\factory_util::safe_trigger_by_targetname(level.default_weapon);
  level.squad["ALLY_ALPHA"] thread maps\factory_anim::ambush_get_on_computer_player_nag();
  level.squad["ALLY_BRAVO"] thread maps\factory_anim::ambush_bravo_computer_use();
  level.squad["ALLY_CHARLIE"] thread maps\factory_anim::ambush_charlie_computer_use();
  thread maps\factory_audio::ambush_pre_start_ally1_typing_sfx();
  thread maps\factory_audio::ambush_pre_start_ally2_typing_sfx();
  maps\_utility::autosave_tactical();
  common_scripts\utility::flag_wait("start_ambush_moment");
  wait 0.1;
  var_0 = level.squad["ALLY_ALPHA"].goalradius;
  level.squad["ALLY_ALPHA"].goalradius = 16;
  level.squad["ALLY_ALPHA"] waittill("goal");
  level.squad["ALLY_ALPHA"].goalradius = var_0;
  common_scripts\utility::flag_wait("player_used_computer");
  common_scripts\utility::flag_set("ambush_triggered");
  level.squad["ALLY_ALPHA"] maps\_utility::clear_generic_idle_anim();
  thread ambush_slowmo();
  thread breach_door();
  wait 0.5;
  thread ambush_door_breacher();
  thread ambush_weapons_drop();
  thread ambush_riotshield_no_melee();
  wait 0.5;
  level thread maps\factory_util::open_door("ambush_door_pivot_left", 160, 0.5, 1);
  level thread maps\factory_util::open_door("ambush_door_pivot_right", -145, 0.5, 1);
  thread ambush_leave_room_early();
  thread ambush_groundtroops_01();
  level waittill("ambush_start_fx");
  maps\_utility::autosave_by_name_silent("ambush");
  var_1 = getglass("desk_glass_panel");
  destroyglass(var_1);
  level waittill("ambush_glass_break");
  common_scripts\utility::flag_set("ambush_vignette_done");
  thread ambush_fastropers_01();
  level.player.threatbias = level.ambush_threat_boost;
  wait 5.0;
  level.squad["ALLY_ALPHA"] thread maps\_utility::disable_cqbwalk();
  level.squad["ALLY_BRAVO"] thread maps\_utility::disable_cqbwalk();
  level.squad["ALLY_CHARLIE"] thread maps\_utility::disable_cqbwalk();
  level.squad["ALLY_ALPHA"].grenadeawareness = 0;
  level.squad["ALLY_BRAVO"].grenadeawareness = 0;
  level.squad["ALLY_CHARLIE"].grenadeawareness = 0;
}

setup_computer_use_hint() {
  common_scripts\utility::flag_wait("enable_ambush_use");
  level notify("show_ambush_use_hint");
  var_0 = getent("ambush_console_use", "targetname");
  var_0 usetriggerrequirelookat();
  var_0 sethintstring(&"FACTORY_HINT_AMBUSH_TRIGGER");
  var_0 common_scripts\utility::trigger_off();
  var_0 thread ambush_use_loop();

  for(;;) {
    var_0 waittill("trigger");

    if(level.player.thermal_anim_active) {
      continue;
    } else if(level.player isthrowinggrenade() || level.player ismeleeing()) {
      continue;
    } else {
      break;
    }

    wait 0.1;
  }

  common_scripts\utility::flag_set("player_used_computer");
  var_0 delete();
}

ambush_use_loop(var_0) {
  var_1 = 0;
  var_2 = getent("ambush_use_volume", "targetname");
  var_3 = getent("ambush_office_volume", "targetname");

  while(isDefined(self)) {
    if(level.player istouching(var_2) && !var_1) {
      common_scripts\utility::trigger_on();
      var_1 = 1;
    } else if(!level.player istouching(var_2) && var_1) {
      common_scripts\utility::trigger_off();
      var_1 = 0;
    }

    if(level.player.thermal_anim_active && var_1) {
      common_scripts\utility::trigger_off();
      var_1 = 0;
    }

    if(!level.squad["ALLY_ALPHA"] istouching(var_3) || !level.squad["ALLY_BRAVO"] istouching(var_3) || !level.squad["ALLY_CHARLIE"] istouching(var_3) && var_1) {
      common_scripts\utility::trigger_off();
      var_1 = 0;
    }

    if(level.player isthrowinggrenade() || level.player ismeleeing()) {
      common_scripts\utility::trigger_off();
      var_1 = 0;
    }

    wait 0.1;
  }
}

ambush_slowmo() {
  level waittill("ambush_start_fx");
  thread maps\factory_audio::ambush_battle_start_ambience_change();
  common_scripts\utility::exploder("ambush_start_fx");
  level waittill("ambush_door_breached");

  if(maps\_utility::is_gen4()) {
    var_0 = maps\_utility::create_sunflare_setting("default");
    var_0.position = (13.8701, -144.781, 0);
    maps\_art::sunflare_changes("default", 0);
  }

  thread maps\_utility::vision_set_fog_changes("factory_ambush_breach_explosion", 0);
  wait 0.05;
  maps\_art::dof_enable_script(30, 200, 4, 200, 500, 3, 0.2);
  thread maps\_utility::vision_set_fog_changes("factory_ambush_breach_explosion_1", 0.2);
  wait 0.15;
  maps\_utility::slowmo_setspeed_slow(0.15);
  maps\_utility::slowmo_setlerptime_in(0.2);
  thread maps\_utility::slowmo_lerp_in();
  level.player playrumbleonentity("artillery_rumble");
  wait 0.1;
  thread maps\_utility::vision_set_fog_changes("factory_ambush_breach_explosion_2", 0.1);
  wait 0.15;
  thread maps\_utility::vision_set_fog_changes("factory_ambush_breach_explosion_3", 0.5);
  wait 0.15;
  maps\_utility::slowmo_setspeed_slow(0.3);
  maps\_utility::slowmo_setlerptime_in(1);
  thread maps\_utility::slowmo_lerp_in();
  wait 1;
  thread maps\_utility::vision_set_fog_changes("", 1.4);
  maps\_art::dof_disable_script(1.4);
  wait 0.25;
  common_scripts\utility::flag_set("music_ambush_battle");
  maps\_utility::slowmo_setlerptime_out(2.0);
  thread maps\_utility::slowmo_lerp_out();
  thread maps\factory_audio::sfx_end_slomo_sound();
  thread maps\factory_audio::sfx_ambush_alarm_sound();
}

breach_door() {
  level waittill("ambush_start_fx");
  var_0 = getent("ambush_breach_door_connector", "targetname");
  var_0 connectpaths();
  var_0 notsolid();
  var_0 delete();
  wait 0.2;
  common_scripts\utility::exploder("ambush_door_exploder");
  wait 0.5;
  common_scripts\utility::exploder("ambush_door_exploder_sparks");
  level waittill("ambush_glass_break");
  wait 1.2;
  common_scripts\utility::exploder("ambush_door_exploder_strobe");

  if(maps\_utility::is_gen4()) {
    common_scripts\utility::exploder("ambush_door_exploder_strobe_ng");
  }
}

break_ambush_glass() {
  setsaveddvar("glass_damageToDestroy", 9999);
  setsaveddvar("glass_damageToWeaken", 9998);
  level waittill("ambush_glass_break");
  var_0 = getEntArray("ambush_room_window_glass_bp", "targetname");

  foreach(var_2 in var_0) {
    var_2 notsolid();
    var_2 hide();
  }

  maps\factory_util::break_glass("ambush_room_window_glass_right", (1, 0, 0));
  maps\factory_util::break_glass("ambush_room_window_glass_angled", (1, 0, 0));
  setsaveddvar("glass_damageToDestroy", 275);
  setsaveddvar("glass_damageToWeaken", 75);
  common_scripts\utility::flag_wait("ambush_thermal_allies_movedup_01");
}

ambush_door_breacher() {
  level waittill("ambush_door_breached");
  wait 0.45;
  var_0 = getent("door_breach_guy", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();

  if(!maps\_utility::spawn_failed(var_1)) {
    var_1.animname = "generic";
    var_1.dontmelee = 1;
    var_1.fixednode = 1;
    var_1.goalradius = 0;
    var_1.attackeraccuracy = 3;
    var_1.favoriteenemy = level.player;
    var_1.ignoreme = 1;
    var_1.threatbias = 5000;
    var_1 maps\_utility::enable_cqbwalk();
    var_1 maps\_utility::delaythread(4, maps\factory_util::factory_set_ignoreme, 0);
  }

  var_2 = getEntArray("ambush_window_breacher_extra", "targetname");

  foreach(var_4 in var_2) {
    var_5 = var_4 maps\_utility::spawn_ai();

    if(maps\_utility::spawn_failed(var_5)) {
      continue;
    }
    var_5.dontmelee = 1;
    var_5.fixednode = 1;
    var_5.goalradius = 0;
    var_5.attackeraccuracy = 2.0;
    var_5.ignoreme = 1;
    var_5 maps\_utility::delaythread(randomfloatrange(6, 8), maps\factory_util::factory_set_ignoreme, 0);
  }
}

ambush_leave_room_early() {
  common_scripts\utility::flag_wait("player_left_ambush_room");
  common_scripts\utility::flag_set("ambush_moment_clear");
  common_scripts\utility::flag_set("ambush_thermal_allies_movedup_01");
  common_scripts\utility::flag_set("walking_cough_guy_done");
  var_0 = level.player.attackeraccuracy;
  var_1 = 0;

  while(!common_scripts\utility::flag("ambush_smoke_01") && !common_scripts\utility::flag("thermal_battle_clear") && !common_scripts\utility::flag("ambush_thermal_flashed")) {
    common_scripts\utility::array_thread(getaiarray("axis"), maps\_utility::set_favoriteenemy, level.player);
    level.player.threatbias = 10000;
    level.player maps\_utility::set_player_attacker_accuracy(4.0);
    wait 0.25;
  }

  maps\_utility::clear_custom_gameskill_func();
}

ambush_fastropers_01() {
  maps\factory_util::break_glass("ambush_glass_ropers_1", (0, 0, -1));
  level.ambush_fast_ropers_mid = [];
  level.ambush_fast_ropers_mid[level.ambush_fast_ropers_mid.size] = ambush_fastrope("ambush_fastroper_mid_1", undefined, 0, 0, 0.75);
  level.ambush_fast_ropers_mid[level.ambush_fast_ropers_mid.size] = ambush_fastrope("ambush_fastroper_mid_2", undefined, 0, 0, 0.75);
  level.ambush_fast_ropers_mid[level.ambush_fast_ropers_mid.size] = ambush_fastrope("ambush_fastroper_mid_4", undefined, 0, 0, 0.75);
  level.ambush_fast_ropers_mid[level.ambush_fast_ropers_mid.size] = ambush_fastrope("ambush_fastroper_mid_6", undefined, 0, 3, 4);
}

ambush_fastrope(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getent(var_0, "targetname");
  var_6 = var_5 maps\_utility::spawn_ai(1, 0);

  if(maps\_utility::spawn_failed(var_6)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = var_0 + "_node";
  } else {
    var_1 = var_1 + "_node";
  }

  var_6 thread maps\factory_anim::ambush_fastrope_do_anim(var_1, var_2, var_3, var_4);
  return var_6;
}

ambush_groundtroops_01() {
  level waittill("ambush_door_breached");
  maps\factory_util::safe_trigger_by_noteworthy("ambush_groundtroops_01_trigger");
  common_scripts\utility::flag_wait("ambush_smoke_01");
  maps\factory_util::safe_trigger_by_targetname("ambush_groundtroops_01_far_killspawner");
  common_scripts\utility::flag_wait("ambush_thermal_allies_movedup_01");
  maps\factory_util::safe_trigger_by_targetname("ambush_groundtroops_01_killspawner");
}

ambush_dest_screens() {}

ambush_dest_screen() {}

ambush_weapons_drop() {
  level waittill("ambush_door_breached");
  wait 0.3;
  var_0 = spawn("weapon_mts255+eotech_sp", (5120, -1840, 256));
  var_0.angles = (randomfloatrange(0, 360), randomfloatrange(0, 360), randomfloatrange(0, 360));
  var_0 = spawn("weapon_gm6+scopegm6_sp", (5062, -1328, 256));
  var_0.angles = (randomfloatrange(0, 360), randomfloatrange(0, 360), randomfloatrange(0, 360));
  var_0 = spawn("weapon_mts255+eotech_sp", (5414, -1902, 260));
  var_0.angles = (randomfloatrange(0, 360), randomfloatrange(0, 360), randomfloatrange(0, 360));
  var_0 = spawn("weapon_m27", (5374, -2132, 260));
  var_0.angles = (randomfloatrange(0, 360), randomfloatrange(0, 360), randomfloatrange(0, 360));
  var_0 = spawn("weapon_gm6+scopegm6_sp", (4838, -2626, 381));
  var_0.angles = (randomfloatrange(0, 360), randomfloatrange(0, 360), randomfloatrange(0, 360));
  var_0 = spawn("weapon_gm6+scopegm6_sp", (4184, -2433, 381));
  var_0.angles = (randomfloatrange(0, 360), randomfloatrange(0, 360), randomfloatrange(0, 360));
}

ambush_riotshield_no_melee() {
  for(;;) {
    if(player_is_using_riot_shield()) {
      level.player.dontmelee = 1;
    }

    if(!player_is_using_riot_shield()) {
      level.player.dontmelee = undefined;
    }

    wait 0.1;
  }
}

player_is_using_riot_shield() {
  var_0 = level.player getcurrentweapon();

  if(var_0 == "riotshield_iw6_sp") {
    return 1;
  } else {
    return 0;
  }
}

thermal_battle_logic() {
  common_scripts\utility::flag_wait("ambush_moment_clear");
  thread safety_to_prevent_rushing();
  common_scripts\utility::flag_set("ambush_prep_smoke_01");
  wait 1.5;
  thread ambush_allies_throw_smoke();
  thread ambush_thermal_off_flashbangs();
  common_scripts\utility::flag_wait("ambush_smoke_01");
  thread maps\factory_fx::fx_ambush_spawn_assembly_smoke();
  thread maps\factory_anim::force_smoke_reaction_anims();
  wait 1.0;
  maps\_utility::autosave_by_name_silent("ambush");
  thread ambush_smoke_penalty();
  level thread thermal_battle_elongate();
  common_scripts\utility::flag_wait_any("ambush_thermal_allies_movedup_01", "player_left_ambush_room");
  common_scripts\utility::flag_wait("walking_cough_guy_done");

  foreach(var_1 in level.squad) {
    var_1 stopanimscripted();
    var_1 maps\factory_util::enable_awareness();
    var_1 maps\_utility::enable_ai_color();
    var_1.usechokepoints = 1;
    var_1 pushplayer(0);
  }

  waittillframeend;
  wait 3.0;
  maps\factory_util::safe_trigger_by_targetname("ambush_allies_move_up");
  common_scripts\utility::array_thread(level.squad, ::ally_start_aggressive_advance);
  thread ambush_riotshield_smoke();
  thread wait_and_kill_guys_in_volume(2, "ambush_far_kill_volume");
  wait 3.0;
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_cleanhouseweneed");
  thread ambush_groundtroops_02();
  thread ambush_allies_move_down_lanes();
  wait 5;
  common_scripts\utility::flag_wait_any("ambush_progress_flag_1", "ambush_groundtroops_02_clear");
  var_3 = getent("assembly_lanes_backstab_prevention", "targetname");
  badplace_brush("assembly_lane_backstab_preventer", 0, var_3, "axis");
  wait 3.0;
  thread ambush_cleanup_left_room();
  maps\_utility::autosave_by_name_silent("ambush");
  maps\factory_util::safe_trigger_by_noteworthy("ambush_groundtroops_03_trigger");
  thread ambush_riotshield_back();
  thread ambush_set_lower_back_clear();
  thread ambush_wave_03_killcounter();
  common_scripts\utility::flag_wait_any("ambush_wave_3_done", "ambush_player_approaching_mezzanine");

  if(!common_scripts\utility::flag("ambush_player_approaching_mezzanine")) {
    thread ambush_allies_move_up_stairs();
  }

  maps\_utility::autosave_by_name_silent("ambush");
  common_scripts\utility::flag_wait_any("ambush_player_on_mezzanine_right", "ambush_player_on_mezzanine_left");
  thread wait_and_kill_guys_in_volume(0.5, "ambush_back_corner_lower");

  if(common_scripts\utility::flag("ambush_player_on_mezzanine_left")) {
    thread ambush_wave_4_left_path();
  } else {
    thread ambush_wave_4_right_path();
  }

  maps\_utility::waittill_aigroupcount("ambush_groundtroops_04", 2);
  maps\factory_util::safe_trigger_by_targetname("ambush_sec_office_allies_postup");
  var_4 = maps\_utility::get_ai_group_ai("ambush_groundtroops_04");

  foreach(var_6 in var_4) {
    var_6 thread maps\factory_util::playerseek();
    var_6.aggressivemode = 1;
  }

  common_scripts\utility::flag_wait("ambush_groundtroops_04_clear");
  maps\factory_util::safe_trigger_by_targetname("ambush_escape_allies_goto_office");
  common_scripts\utility::flag_set("thermal_battle_clear");
}

safety_to_prevent_rushing() {
  level endon("safe_to_advance");
  level endon("safety_timeout");
  var_0 = 12;
  var_1 = 0;

  while(!common_scripts\utility::flag("ambush_player_approaching_mezzanine")) {
    wait 0.1;
    var_1 = var_1 + 0.1;

    if(var_1 >= var_0) {
      level notify("safety_timeout");
    }
  }

  var_2 = maps\_utility::get_closest_ai(level.player.origin, "axis");

  while(level.player.health > 25) {
    if(isDefined(var_2) && isalive(var_2)) {
      level.player dodamage(30, var_2.origin, var_2, var_2, "MOD_RIFLE_BULLET");
    } else {
      var_3 = getent("ambush_fastroper_mid_5_node", "targetname");
      level.player dodamage(30, var_3.origin, undefined, undefined, "MOD_RIFLE_BULLET");
    }

    wait 0.2;
  }

  level.player kill();
}

ambush_allies_throw_smoke() {
  level.player.threatbias = -1000;
  level.squad["ALLY_ALPHA"] thread maps\factory_anim::ambush_ally_throw_smoke("throw_smoke_node_03", "alpha_smoke_throw_node", "pop_smoke_ally01", undefined, 4);
  level.squad["ALLY_BRAVO"] thread maps\factory_anim::ambush_ally_throw_smoke("throw_smoke_node_02", "ambush_anim_node", "pop_smoke_ally02", undefined, 2.5, "pop_smoke_enter_ally02");
  level.squad["ALLY_CHARLIE"] thread maps\factory_anim::ambush_ally_throw_smoke("throw_smoke_node_01", "ambush_anim_node", "pop_smoke_ally03", undefined, 2.0, "pop_smoke_enter_ally03");
}

thermal_battle_elongate() {
  wait 8;
  common_scripts\utility::flag_set("ambush_thermal_allies_movedup_01");

  foreach(var_1 in level.squad) {
    var_1 thread ally_pick_up_weapon();
  }
}

ally_pick_up_weapon() {
  level endon("thermal_battle_clear");
  wait_until_out_of_sight();

  if(self == level.squad["ALLY_ALPHA"]) {
    maps\_utility::forceuseweapon("cz805bren+reflex_sp", "primary");
  } else if(self == level.squad["ALLY_BRAVO"]) {
    maps\_utility::forceuseweapon("pp19+reflexsmg_sp", "primary");
  } else if(self == level.squad["ALLY_CHARLIE"]) {
    maps\_utility::forceuseweapon("m27", "primary");
  }
}

wait_until_out_of_sight() {
  level endon("thermal_battle_clear");

  for(;;) {
    if(level.player maps\_utility::player_can_see_ai(self)) {
      break;
    }

    wait 0.25;
  }
}

ambush_cleanup_left_room() {
  maps\factory_util::safe_trigger_by_targetname("ambush_left_room_killspawner");
  thread wait_and_kill_guys_in_volume(0, "left_room_cleanup_vol");
}

ambush_groundtroops_02() {
  maps\factory_util::safe_trigger_by_noteworthy("ambush_groundtroops_02_trigger");
  level notify("safe_to_advance");
  maps\_utility::waittill_aigroupcount("ambush_groundtroops_02", 3);
  common_scripts\utility::flag_set("ambush_groundtroops_02_clear");
}

ambush_allies_move_down_lanes() {
  common_scripts\utility::flag_wait("ambush_allies_move_down_lanes");
  common_scripts\utility::flag_wait("ambush_riotshield_smoke_clear");
  maps\factory_util::safe_trigger_by_targetname("ambush_allies_move_down_lanes");
  common_scripts\utility::flag_wait("ambush_corner_allies_push");
  maps\factory_util::safe_trigger_by_targetname("ambush_corner_allies_push");
  common_scripts\utility::array_thread(level.squad, ::ally_start_aggressive_advance);
}

ambush_set_lower_back_clear() {
  level endon("ambush_lower_back_clear");
  level endon("thermal_battle_clear");
  var_0 = getent("ambush_back_corner_lower", "targetname");
  var_1 = [];

  for(;;) {
    var_1 = var_0 maps\_utility::get_ai_touching_volume("axis");
    var_2 = maps\_utility::get_ai_group_count("riotshield_back");

    if(!common_scripts\utility::flag("ambush_smoke_off_tooltip") && (var_2 < 2 || var_1.size < 2)) {
      common_scripts\utility::flag_set("ambush_smoke_off_tooltip");
    }

    if(var_1.size <= 2 && var_2 < 1) {
      common_scripts\utility::flag_set("ambush_lower_back_clear");
      return;
    }

    wait 0.2;
  }
}

ambush_allies_move_up_stairs() {
  common_scripts\utility::flag_wait_any("ambush_lower_back_clear", "ambush_player_on_mezzanine_right", "ambush_player_on_mezzanine_left");
  common_scripts\utility::flag_set("ambush_lower_back_clear");
  maps\factory_util::safe_delete_targetname("ambush_corner_allies_push");
  maps\factory_util::safe_trigger_by_targetname("ambush_back_corner_allies_push");
  maps\factory_util::safe_trigger_by_targetname("ambush_groundtroops_03_killspawner");
  maps\_utility::delaythread(3.0, common_scripts\utility::flag_set, "music_ambush_battle_ends");
  wait 2.2;
  level.squad["ALLY_ALPHA"] thread maps\_utility::smart_dialogue("factory_bkr_upthestairs");
}

ambush_groundtroops_02_fallback() {
  var_0 = getent("ambush_groundtroops_02_cleanup_a", "targetname");
  var_1 = var_0 maps\_utility::get_ai_touching_volume("axis");
  thread maps\factory_util::safe_set_goal_volume(var_1, "ambush_groundtroops_02_cleanup_b");
}

ambush_wave_03_killcounter() {
  maps\_utility::waittill_aigroupcount("ambush_wave_03", 3);
  maps\factory_util::safe_trigger_by_noteworthy("ambush_groundtroops_035_trigger");
  maps\_utility::waittill_aigroupcount("ambush_wave_035", 2);
  maps\_utility::waittill_aigroupcount("ambush_wave_03", 1);
  maps\factory_util::safe_trigger_by_targetname("ambush_groundtroops_03_killspawner");
  var_0 = getent("ambush_back_corner_volume", "targetname");
  var_1 = var_0 maps\_utility::get_ai_touching_volume("axis");
  common_scripts\utility::array_thread(var_1, maps\factory_util::playerseek);
  wait 2.0;
  common_scripts\utility::flag_set("ambush_wave_3_done");
  common_scripts\utility::flag_set("ambush_expl_03");
}

ambush_wave_4_left_path() {
  maps\factory_util::safe_trigger_by_targetname("ambush_sec_office_allies_push");
  maps\factory_util::safe_trigger_by_noteworthy("ambush_groundtroops_04_trigger");
}

ambush_wave_4_right_path() {
  maps\factory_util::safe_trigger_by_targetname("ambush_back_corner_allies_right_path");
  var_0 = getEntArray("ambush_groundtroops_04", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      var_2.target = var_2.script_parameters;
    }
  }

  maps\factory_util::safe_trigger_by_noteworthy("ambush_groundtroops_04_trigger");
}

ambush_thermal_off_flashbangs() {
  common_scripts\utility::flag_wait("ambush_smoke_off_tooltip");
  wait 2.2;
  var_0 = getEntArray("flash_node_start", "targetname");

  foreach(var_4, var_2 in var_0) {
    var_3 = getent(var_2.target, "targetname");
    thread wait_and_flashbang(var_2, var_3);
  }

  level.player thread ambush_thermal_player_flash();
  common_scripts\utility::flag_set("ambush_stop_smoke");
  level.player.grenadetimers["fraggrenade"] = level.player.grenadetimers["fraggrenade"] + randomintrange(6000, 12000);
  anim.grenadetimers["AI_fraggrenade"] = anim.grenadetimers["AI_fraggrenade"] + randomintrange(6000, 12000);
  common_scripts\utility::flag_set("ambush_expl_01");
  wait 9;
  thread maps\factory_audio::sfx_explo_after_flashbang();
  common_scripts\utility::flag_set("ambush_expl_02");
  radiusdamage((5378, -2197, 262), 200, 400, 100);
}

wait_and_flashbang(var_0, var_1) {
  wait(randomfloatrange(0, 0.25));
  var_2 = magicgrenade("flash_grenade", var_0.origin, var_1.origin, 2.5);

  if(isDefined(var_2)) {
    var_2 waittill("death");
    level.player notify("flashed");
  }
}

ambush_thermal_player_flash() {
  level endon("thermal_battle_clear");
  common_scripts\utility::waittill_any("flashbang", "flashed");
  common_scripts\utility::flag_set("ambush_thermal_flashed");
  self stopshellshock();
  self shellshock("flashbang", 2.5);
  common_scripts\utility::flag_set("ambush_arm_malfunction");
  self enablehealthshield(1);
  self.threatbias = -2000;
  wait 7.0;
  self enablehealthshield(0);
  wait 5.0;
  self.threatbias = -750;
  wait 5.0;
  self.threatbias = level.ambush_threat_boost;
}

ambush_riotshield_smoke() {
  var_0 = getEntArray("ambush_riotshield_02", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 maps\_utility::spawn_ai(1);
    var_4.destination = getent(var_3.target, "targetname");
    var_4.health = 100;
    var_1[var_1.size] = var_4;
  }

  waittillframeend;

  foreach(var_4 in var_1) {
    if(isalive(var_4) && isDefined(var_4.destination)) {
      var_4.goalradius = 16;
      var_4 setgoalpos(var_4.destination.origin);
    }
  }

  var_8 = common_scripts\utility::flag_wait_any_return("riotshield_cleanup_left", "riotshield_cleanup_right");

  if(var_8 == "riotshield_cleanup_left") {
    var_1 = maps\_utility::get_ai_group_ai("riotshield_right");
  } else {
    var_1 = maps\_utility::get_ai_group_ai("riotshield_left");
  }

  foreach(var_4 in var_1) {
    var_4 thread kill_after_time(1, 3);
  }
}

ambush_riotshield_back() {
  var_0 = getEntArray("ambush_riotshield_03", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 maps\_utility::spawn_ai();

    if(!maps\_utility::spawn_failed(var_4)) {
      var_4.fixednode = 1;
      var_4.health = 100;
      var_1[var_1.size] = var_4;
    }
  }

  thread ambush_riotshield_back_cleanup(var_1);
  maps\_utility::waittill_aigroupcount("riotshield_back", 1);

  foreach(var_4 in var_1) {
    var_4 thread kill_after_time(12);
  }
}

ambush_riotshield_back_cleanup(var_0) {
  common_scripts\utility::flag_wait_any("ambush_player_on_mezzanine_right", "ambush_player_on_mezzanine_left");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2.health = 1;
      var_2 thread kill_after_time(20);
    }
  }
}

show_thermal_tooltip(var_0, var_1) {
  level endon("thermal_battle_clear");

  if(isDefined(var_0) && var_0 == 1) {
    level.show_thermal_hint = 1;

    if(isDefined(var_1)) {
      var_2 = "HINT_THERMAL_SHORT";
      level.trigger_hint_func["HINT_THERMAL_SHORT"] = ::thermal_hint_func_on;
    } else
      var_2 = "HINT_THERMAL";
  } else {
    level.show_thermal_off_hint = 1;

    if(isDefined(var_1)) {
      var_2 = "HINT_THERMAL_OFF_SHORT";
      level.trigger_hint_func["HINT_THERMAL_OFF_SHORT"] = ::thermal_hint_func_off;
    } else
      var_2 = "HINT_THERMAL_OFF";
  }

  if(level.show_thermal_hint == 1) {
    if(level.player.thermal == 0 && level.player.thermal_anim_active == 0) {
      level.player thread maps\_utility::display_hint(var_2);
    }
  } else if(level.show_thermal_off_hint == 1) {
    if(level.player.thermal == 1 && level.player.thermal_anim_active == 0) {
      level.player thread maps\_utility::display_hint(var_2);
    }
  }

  wait 10;
  level.show_thermal_hint = 0;
  level.show_thermal_off_hint = 0;
}

thermal_hint_func_on() {
  return level.player.thermal;
}

thermal_hint_func_off() {
  return !level.player.thermal;
}

hint_thermal_timeout() {
  if(!level.show_thermal_hint) {
    return 1;
  }

  return 0;
}

hint_thermal_off_timeout() {
  if(!level.show_thermal_off_hint) {
    return 1;
  }

  return 0;
}

thermal_off_tooltip_handler() {
  common_scripts\utility::flag_wait("ambush_thermal_flashed");
  wait 0.5;

  if(level.player.thermal == 1) {
    level thread show_thermal_tooltip(0);
  }
}

ambush_smoke_penalty() {
  level endon("stop_smoke_penalty");
  var_0 = getent("ambush_smoke_volume", "targetname");
  var_1 = getent("ambush_cleanup_volume", "targetname");
  var_2 = "ambush_stop_smoke";
  var_3 = level.player.maxvisibledist;
  var_4 = level.player.attackeraccuracy;

  for(;;) {
    if(isDefined(var_0) && level.player istouching(var_0)) {
      level.player.threatbias = -300;
      level.player.maxvisibledist = 475;
      level.player.attackeraccuracy = 0.15;
    } else if(isDefined(var_0) && !level.player istouching(var_0)) {
      level.player.threatbias = level.ambush_threat_boost;
      level.player.ignoreme = 0;
      level.player.maxvisibledist = var_3;
      level.player.attackeraccuracy = var_4;
    }

    var_5 = var_1 maps\_utility::get_ai_touching_volume("axis");

    foreach(var_7 in var_5) {
      if(!isDefined(var_7.ambush_original_accuracy)) {
        var_7.ambush_original_accuracy = var_7.script_accuracy;
      }

      if(isDefined(var_0) && var_7 istouching(var_0)) {
        var_7.script_accuracy = 0.08;
        continue;
      }

      var_7.script_accuracy = var_7.ambush_original_accuracy;
    }

    if(common_scripts\utility::flag(var_2) && isDefined(var_0)) {
      var_0 delete();
      wait 5;
      var_5 = var_1 maps\_utility::get_ai_touching_volume("axis");

      foreach(var_7 in var_5) {
        var_7.script_accuracy = 2;
      }

      maps\_utility::clear_custom_gameskill_func();
      common_scripts\utility::flag_set("stop_smoke_penalty");
    }

    wait 0.25;
  }
}

enemy_smoke_reaction(var_0) {
  maps\_utility::enable_cqbwalk();
  thread enemy_smoke_reaction_vision(var_0);
  thread enemy_smoke_reaction_anim(var_0);
}

enemy_smoke_reaction_vision(var_0) {
  self endon("death");
  common_scripts\utility::flag_wait("ambush_smoke_01");
  var_1 = self.maxsightdistsqrd;

  for(;;) {
    wait(randomfloatrange(0.25, 1.5));

    if(!isDefined(var_0)) {
      return;
    }
    if(self istouching(var_0)) {
      self.maxsightdistsqrd = 4096;
      wait(randomfloatrange(1.0, 4.0));
      self.maxsightdistsqrd = var_1;
    }
  }
}

enemy_smoke_reaction_anim(var_0) {
  self endon("death");
  level endon("ambush_stop_smoke");
  common_scripts\utility::flag_wait("ambush_smoke_01");
  self.animarchetype = "factory_smoke";

  for(;;) {
    wait(randomfloatrange(1.5, 3.0));

    if(!isDefined(var_0)) {
      return;
    }
    if(self istouching(var_0) && !isDefined(self.smoke_immune)) {
      if(isDefined(self.node)) {
        self.animname = "generic";
        self.allowdeath = 1;
        self.claimed_node = self.node;
        self.keepclaimednode = 1;

        switch (self.script) {
          case "cover_crouch":
            maps\_anim::anim_single_solo(self, common_scripts\utility::random(["factory_ambush_smoke_CornerCr_01", "factory_ambush_smoke_CornerCr_02"]));
            break;
          case "cover_right":
            maps\_anim::anim_single_solo(self, common_scripts\utility::random(["factory_ambush_smoke_CornerCrR_01", "factory_ambush_smoke_CornerCrR_02", "factory_ambush_smoke_CornerCrR_03"]));
            break;
          case "cover_left":
            maps\_anim::anim_single_solo(self, common_scripts\utility::random(["factory_ambush_smoke_CornerCrL_01", "factory_ambush_smoke_CornerCrL_02", "factory_ambush_smoke_CornerCrL_03"]));
            break;
          case "cover_stand":
            maps\_anim::anim_single_solo(self, common_scripts\utility::random(["factory_ambush_smoke_stand_01", "factory_ambush_smoke_stand_02"]));
            break;
        }

        self.keepclaimednode = 0;
      }
    }
  }
}

ally_smoke_reaction_vision(var_0) {
  self endon("death");
  common_scripts\utility::flag_wait("ambush_smoke_01");
  var_1 = self.maxvisibledist;

  for(;;) {
    wait(randomfloatrange(1.0, 3.0));

    if(!isDefined(self) || !isalive(self)) {
      return;
    }
    if(!isDefined(var_0)) {
      self.ignoreme = 0;
      self.maxvisibledist = var_1;
      return;
    }

    if(self istouching(var_0)) {
      self.maxvisibledist = 256;
      wait(randomfloatrange(1.0, 3.0));

      if(!isDefined(self) || !isalive(self)) {
        self.maxvisibledist = var_1;
      }
    }
  }
}

ambush_smoke_close_enemies() {
  common_scripts\utility::flag_wait("player_left_ambush_room");

  while(!common_scripts\utility::flag("ambush_stop_smoke")) {
    var_0 = maps\_utility::get_closest_ai(level.player.origin, "axis");

    if(isalive(var_0) && maps\_utility::players_within_distance(512, var_0.origin)) {
      var_0 thread maps\_utility::player_seek();
      var_0 thread maps\_utility::set_favoriteenemy(level.player);
      var_0.dontevershoot = 1;
      var_0.smoke_immune = 1;
      var_0.maxvisibledist = 128;
      var_0 common_scripts\utility::waittill_any_timeout(10, "death");
    }

    wait 1;
  }
}

kill_after_time(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1)) {
    wait(randomfloatrange(var_0, var_1));
  } else {
    wait(var_0);
  }

  if(isDefined(self) && isai(self) && isalive(self)) {
    self kill();
  }
}

wait_and_kill_guys_in_volume(var_0, var_1) {
  if(var_0 > 0) {
    wait(var_0);
  }

  var_2 = getent(var_1, "targetname");
  var_3 = var_2 maps\_utility::get_ai_touching_volume("axis");

  foreach(var_5 in var_3) {
    var_5 thread kill_after_time(0.0, 3.0);
  }
}

ambush_fan_spin(var_0) {
  level endon("stop_assembly_line");

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    self rotatepitch(360, 12);
    wait 12;
  }
}

ally_start_aggressive_advance() {
  if(!isDefined(self) || !issentient(self) || !isalive(self)) {
    return;
  }
  var_0 = self.goalradius;
  self.goalradius = 4;
  self.ignoreall = 1;
  self.ignoresuppression = 1;
  self.ignorerandombulletdamage = 1;
  maps\_utility::disable_bulletwhizbyreaction();
  maps\_utility::disable_pain();
  maps\_utility::disable_danger_react();
  self.grenadeawareness = 0;
  self waittill("goal");
  self.goalradius = var_0;
  ally_end_aggressive_advance();
}

ally_end_aggressive_advance() {
  if(!isDefined(self) || !issentient(self) || !isalive(self)) {
    return;
  }
  self.ignoreall = 0;
  self.ignoresuppression = 0;
  self.ignorerandombulletdamage = 0;
  maps\_utility::enable_bulletwhizbyreaction();
  maps\_utility::enable_pain();
  self.grenadeawareness = 1;
}

ambush_cleanup(var_0) {
  if(!isDefined(var_0)) {
    var_1 = getent("ambush_cleanup_volume", "targetname");
    var_2 = var_1 maps\_utility::get_ai_touching_volume("axis");

    foreach(var_4 in var_2) {
      if(isDefined(var_4) && isai(var_4) && var_4.team == "axis") {
        var_4 kill();
      }
    }
  }

  common_scripts\utility::flag_set("ambush_smoke_01");
  common_scripts\utility::flag_set("thermal_battle_clear");
  common_scripts\utility::flag_set("ambush_thermal_flashed");
  maps\factory_util::safe_trigger_by_targetname("ambush_groundtroops_01_killspawner");
  maps\factory_util::safe_trigger_by_targetname("ambush_groundtroops_02_killspawner");
  maps\factory_util::safe_trigger_by_targetname("ambush_groundtroops_03_killspawner");
  maps\factory_util::safe_trigger_by_targetname("ambush_groundtroops_04_killspawner");
  maps\factory_util::safe_trigger_by_targetname("ambush_fastropers_killspawner");
  maps\factory_util::safe_delete_noteworthy("ambush_fastropers");
  maps\factory_util::safe_delete_targetname("ambush_groundtroops_01");
  maps\factory_util::safe_delete_targetname("ambush_groundtroops_02");
  maps\factory_util::safe_delete_targetname("ambush_groundtroops_03");
  maps\factory_util::safe_delete_targetname("ambush_groundtroops_035");
  maps\factory_util::safe_delete_targetname("ambush_groundtroops_04");
  maps\factory_util::safe_delete_targetname("ambush_riotshield_01");
  maps\factory_util::safe_delete_targetname("ambush_riotshield_02");
  maps\factory_util::safe_delete_targetname("ambush_riotshield_03");
  maps\factory_util::safe_delete_targetname("ambush_window_breacher_extra");
  maps\factory_util::safe_delete_targetname("ambush_window_breacher_extra");
  maps\factory_util::safe_delete_targetname("ambush_trigger_cleanup");
  maps\factory_util::safe_delete_noteworthy("ambush_groundtroops_02_trigger");
  maps\factory_util::safe_delete_noteworthy("ambush_groundtroops_04_trigger");
  maps\factory_util::safe_delete_targetname("ambush_groundtroops_02_killspawner");
  maps\factory_util::safe_delete_targetname("ambush_groundtroops_03_killspawner");
  maps\factory_util::safe_delete_targetname("ambush_groundtroops_04_killspawner");
  maps\factory_util::safe_delete_linkname("ambush_cleanup_object");

  if(!isDefined(var_0)) {
    badplace_delete("assembly_lane_backstab_preventer");
    maps\_utility::battlechatter_off();

    foreach(var_7 in level.squad) {
      var_7 notify("cleanup_grenade_throw");
      var_7.suppressionwait = 3000;
      var_7.script_accuracy = 1.0;
      var_7.usechokepoints = 1;
    }

    maps\_utility::clear_custom_gameskill_func();
  }

  level thread maps\factory_anim::factory_assembly_line_cleanup(var_0);
}

attach_mover_prefab() {
  if(!isDefined(level.mover_prefabs)) {
    create_ambush_mover_prefabs();
  }

  for(var_0 = 0; var_0 < level.mover_prefabs.size; var_0++) {
    if(level.mover_prefabs[var_0].in_use == 0) {
      level.mover_prefabs[var_0].in_use = 1;
      var_1 = self gettagorigin("J_anim_jnt_top_arm_holder");
      level.mover_prefabs[var_0].origin = var_1;
      level.mover_prefabs[var_0] linkto(self, "J_anim_jnt_top_arm_holder");
      self.mover_prefab_id = var_0;
      return;
    }
  }
}

detach_mover_prefab() {
  level.mover_prefabs[self.mover_prefab_id].in_use = 0;
  self unlink();
}

create_ambush_mover_prefabs() {
  level.mover_prefabs = [];
  var_0 = 8;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level.mover_prefabs[level.mover_prefabs.size] = create_mover_prefab("ambush_mover_prefab", var_1 + 1);
  }
}

create_mover_prefab(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = [];
  var_5 = var_0 + "_" + var_1;
  var_6 = getEntArray(var_5, "targetname");

  foreach(var_8 in var_6) {
    if(var_8.code_classname == "script_brushmodel") {
      var_4[var_4.size] = var_8;
      continue;
    }

    if(var_8.code_classname == "script_origin") {
      if(isDefined(var_8.script_noteworthy)) {
        var_3 = var_8;
      } else {
        var_2 = var_8;
        var_2.audio_org = undefined;
      }

      continue;
    }
  }

  foreach(var_11 in var_4) {
    var_11 linkto(var_2);
  }

  if(isDefined(var_3)) {
    var_3 linkto(var_2);
    var_2.audio_org = var_3;
  }

  var_2.in_use = 0;
  return var_2;
}

setup_ambush_flood_spawner_limited_triggers() {
  if(!isDefined(level.flood_spawner_limited_cap)) {
    level.flood_spawner_limited_cap = 15;
  }

  var_0 = getEntArray("flood_spawner_limited", "targetname");

  foreach(var_2 in var_0) {
    thread flood_trigger_limited_think(var_2);
  }
}

flood_trigger_limited_think(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
  common_scripts\utility::array_thread(var_1, ::flood_spawner_limited_init);
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 thread flood_spawner_limited_think(var_0);
    wait 0.1;
  }
}

flood_spawner_limited_init(var_0) {}

flood_spawner_limited_think(var_0) {
  self endon("death");
  self notify("stop current floodspawner");
  self endon("stop current floodspawner");
  maps\_utility::script_delay();

  while(self.count > 0) {
    var_1 = isDefined(self.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
    var_2 = getaiarray("axis");

    if(var_2.size >= level.flood_spawner_limited_cap) {
      wait(randomfloatrange(0.8, 1.2));
      continue;
    }

    if(isDefined(self.script_forcespawn)) {
      var_3 = self stalingradspawn(var_1);
    } else {
      var_3 = self dospawn(var_1);
    }

    if(maps\_utility::spawn_failed(var_3)) {
      wait 1;
      continue;
    }

    var_2 = getaiarray("axis");
    var_3 thread maps\_spawner::reincrement_count_if_deleted(self);
    var_3 thread maps\_spawner::expand_goalradius(var_0);
    var_3 waittill("death", var_4);

    if(!maps\_spawner::player_saw_kill(var_3, var_4)) {
      self.count++;
    }

    if(!isDefined(var_3)) {
      continue;
    }
    if(!maps\_utility::script_wait()) {
      wait(randomfloatrange(5, 9));
    }
  }
}