/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\jungle_ghosts.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  maps\_utility::template_level("jungle_ghosts");
  maps\createart\jungle_ghosts_art::main();
  maps\jungle_ghosts_fx::main();
  maps\jungle_ghosts_anim::main();
  maps\jungle_ghosts_precache::main();
  maps\_patrol_anims_gundown::main();
  maps\_patrol_anims_creepwalk::main();
  maps\jungle_ghosts_util::enemy_weapons_force_use_init();
  setup_bind_detection();
  precache_please();
  init_starts();
  init_level_flags();
  init_radio_dialogue();
  init_dialogue();
  setup_fire_damage();
  maps\_utility::intro_screen_create(&"JUNGLE_GHOSTS_INTROSCREEN_LINE_1", &"JUNGLE_GHOSTS_INTROSCREEN_LINE_2", &"JUNGLE_GHOSTS_INTROSCREEN_LINE_5", &"JUNGLE_GHOSTS_INTROSCREEN_LINE_3");
  maps\_utility::intro_screen_custom_func(::custom_intro_screen_func);
  maps\_load::main();

  if(!level.console) {
    setsaveddvar("r_mbEnable", 2);
    setsaveddvar("r_mbCameraRotationInfluence", 0.25);
    setsaveddvar("r_mbCameraTranslationInfluence", 0.01);
    setsaveddvar("r_mbModelVelocityScalar", 0.1);
    setsaveddvar("r_mbStaticVelocityScalar", 0.2);
    setsaveddvar("r_mbViewModelEnable", 0);
  }

  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 6);

  if(level.xenon) {
    setsaveddvar("r_texFilterProbeBilinear", 1);
  }

  if(!maps\_utility::is_gen4()) {
    setsaveddvar("sm_sunshadowscale", 0.55);
  }

  level.rain_skybox = getent("jungle_overcast_sky", "targetname");
  level.rain_skybox hide();
  level.player takeallweapons();
  maps\jungle_ghosts_audio::main();
  maps\_stealth::main();
  common_scripts\utility::array_thread(level.players, maps\_stealth_utility::stealth_default);
  maps\_utility::add_hint_string("hint_silencer_toggle", &"JUNGLE_GHOSTS_SILENCER_TOGGLE", ::should_toggle_silencer);

  if(maps\jungle_ghosts_util::game_is_pc()) {
    maps\_utility::add_hint_string("hint_drag", &"JUNGLE_GHOSTS_HINT_PLANE_DRAG", ::player_pushing_forward);
  } else {
    maps\_utility::add_hint_string("hint_drag", &"JUNGLE_GHOSTS_HINT_PLANE_DRAG_NORMAL", ::player_pushing_forward);
  }

  level.doing_hand_signal = 0;
  var_0 = ["to_grassy_field", "field_entrance"];

  foreach(var_2 in var_0) {
    var_2 = getent(var_2, "targetname");
    var_2 thread maps\jungle_ghosts_util::play_hand_signal_for_player();
  }

  var_4 = getent("stream", "targetname");
  var_4 thread maps\jungle_ghosts_util::stream_trig_logic();
  level.laser_count = 0;
  level.impact_tree = 0;
  level.stealth_spotted_time = 6;
  level.stealth_player_aware_enemies = [];
  level.ignore_on_func = maps\jungle_ghosts_util::generic_ignore_on;
  level.ignore_off_func = maps\jungle_ghosts_util::generic_ignore_off;
  var_5 = [];
  var_5["default_crouch"]["exposed_idle"] = [ % exposed_crouch_lookaround_1, % exposed_crouch_lookaround_2, % exposed_crouch_lookaround_3, % exposed_crouch_lookaround_4];
  maps\_utility::register_archetype("jungle_soldier", var_5);
  level.player setviewmodel("viewhands_gs_jungle_b");
  thread maps\jungle_ghosts_jungle::jungle_moving_foliage_settings();
  setsaveddvar("cg_foliagesnd_alias", "plyr_wet_foliage_mvmnt");
  setdvar("ads_dof_tracedist", 2048);
  common_scripts\utility::trigger_off("river_slide_trig", "targetname");
  setdvar("music_enable", 1);
  thread maps\jungle_ghosts_jungle::motion_tracker_setup();
  createthreatbiasgroup("friendly_squad");
  createthreatbiasgroup("chopper_guys");
  thread maps\jungle_ghosts_util::music_start();
  thread intro_stealth_spotted_check();
  thread distant_tree_card_hider();
  thread ssao_logic_post_stream();
}

distant_tree_card_hider() {
  var_0 = getEntArray("hidetrees", "targetname");

  for(;;) {
    foreach(var_2 in var_0) {
      if(level.player.origin[1] > 2905) {
        var_2 show();
        continue;
      }

      var_2 hide();
    }

    wait 2;
  }
}

ai_total_count() {
  for(;;) {
    common_scripts\utility::waitframe();
  }
}

setup_bind_detection() {
  level.actionbinds = [];
  registeractionbinding("player_takedown", "+activate", &"JUNGLE_GHOSTS_HINT_TAKEDOWN");
  registeractionbinding("player_takedown", "+usereload", &"JUNGLE_GHOSTS_HINT_TAKEDOWN_RELOAD");
  registeractionbinding("pickup_rpg", "+activate", &"JUNGLE_GHOSTS_RPG_PICKUP");
  registeractionbinding("pickup_rpg", "+usereload", &"JUNGLE_GHOSTS_RPG_PICKUP_RELOAD");
  registeractionbinding("player_helpup", "+activate", &"JUNGLE_GHOSTS_HINT_HELPUP");
  registeractionbinding("player_helpup", "+usereload", &"JUNGLE_GHOSTS_HINT_HELPUP_RELOAD");
  registeractionbinding("ads_360", "+speed_throw", &"JUNGLE_GHOSTS_HINT_ADS_THROW_360");
  registeractionbinding("ads_360", "+speed", &"JUNGLE_GHOSTS_HINT_ADS_360");
  registeractionbinding("ads", "+speed_throw", &"JUNGLE_GHOSTS_HINT_ADS_THROW");
  registeractionbinding("ads", "+speed", &"JUNGLE_GHOSTS_HINT_ADS");
  registeractionbinding("ads", "+toggleads_throw", &"JUNGLE_GHOSTS_HINT_ADS_TOGGLE_THROW");
  registeractionbinding("ads", "toggleads", &"JUNGLE_GHOSTS_HINT_ADS_TOGGLE");
  registeractionbinding("equip_soflam", "+actionslot 4", &"JUNGLE_GHOSTS_HINT_WEAPON_SOFLAM");
}

registeractionbinding(var_0, var_1, var_2) {
  if(!isDefined(level.actionbinds[var_0])) {
    level.actionbinds[var_0] = [];
  }

  var_3 = spawnStruct();
  var_3.binding = var_1;
  var_3.hint = var_2;
  var_3.keytext = undefined;
  var_3.hinttext = undefined;
  precachestring(var_2);
  level.actionbinds[var_0][level.actionbinds[var_0].size] = var_3;
}

getactionbind(var_0) {
  for(var_1 = 0; var_1 < level.actionbinds[var_0].size; var_1++) {
    var_2 = level.actionbinds[var_0][var_1];
    var_3 = getkeybinding(var_2.binding);

    if(!var_3["count"]) {
      continue;
    }
    return level.actionbinds[var_0][var_1];
  }

  return level.actionbinds[var_0][0];
}

keyhint(var_0, var_1, var_2, var_3) {
  clear_hints();
  level endon("clearing_hints");
  level.hintelem = create_custom_hint();
  var_4 = getactionbind(var_0);
  level.hintelem settext(var_4.hint);

  if(!isDefined(var_3)) {
    var_5 = "did_action_" + var_0;

    for(var_6 = 0; var_6 < level.actionbinds[var_0].size; var_6++) {
      var_4 = level.actionbinds[var_0][var_6];
      notifyoncommand(var_5, var_4.binding);
    }

    if(isDefined(var_1)) {
      level.player thread notifyontimeout(var_5, var_1);
    }

    level.player waittill(var_5);
    level.hintelem fadeovertime(0.5);
    level.hintelem.alpha = 0;
    wait 0.5;
    clear_hints();
  }
}

create_custom_hint() {
  var_0 = 2;

  if(isDefined(level.hint_fontscale)) {
    var_0 = level.hint_fontscale;
  }

  var_1 = maps\_hud_util::createfontstring("default", var_0);
  var_1.hidewheninmenu = 1;
  var_1.sort = 0.5;
  var_1.alpha = 0.9;
  var_1.x = 0;
  var_1.y = -68;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.foreground = 0;
  var_1.hidewhendead = 1;
  var_1.hidewheninmenu = 1;
  return var_1;
}

clear_hints() {
  if(isDefined(level.hintelem)) {
    level.hintelem maps\_hud_util::destroyelem();
  }

  if(isDefined(level.iconelem)) {
    level.iconelem maps\_hud_util::destroyelem();
  }

  if(isDefined(level.iconelem2)) {
    level.iconelem2 maps\_hud_util::destroyelem();
  }

  if(isDefined(level.iconelem3)) {
    level.iconelem3 maps\_hud_util::destroyelem();
  }

  if(isDefined(level.hintbackground)) {
    level.hintbackground maps\_hud_util::destroyelem();
  }

  level notify("clearing_hints");
}

notifyontimeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
  self notify(var_0);
}

precache_please() {
  precachemodel("viewhands_gs_jungle_b");
  precachemodel("tag_turret");
  precachemodel("tag_laser");
  precachemodel("viewhands_player_gs_jungle_b");
  precachemodel("fullbody_dog_a");
  precachemodel("head_pilot_a");
  precachemodel("weapon_beretta");
  precachemodel("vehicle_aas_72x_destructible");
  precachemodel("jungle_crate_01");
  precachemodel("jungle_crate_01_dmg");
  precachemodel("viewmodel_knife_iw6");
  precacheitem("knifeonly_scripted");
  precachemodel("parachute_hanging_static");
  precachemodel("weapon_honeybadger");
  precachemodel("weapon_p226");
  precacheshader("cb_motiontracker3d_ping_enemy");
  precacheshader("cb_motiontracker3d_ping_friendly");
  precacheshader("white");
  precacheshader("black");
  precacheitem("honeybadger+acog_sp");
  precacheitem("smaw");
  precacheitem("rpg_straight");
  precacheitem("rpg_player");
  precacheitem("ak47");
  precacheitem("ak47_silencer");
  precacheitem("knife_jungle");
  precacheitem("m4_silencer_reflex");
  precacheitem("beretta");
  precacheitem("honeybadger");
  precacheitem("kriss");
  precacheitem("microtar");
  precacheitem("sc2010");
  precacheitem("p226");
  precacheitem("p226_tactical");
  precacheitem("apache_turret");
  precacheitem("missile_attackheli");
  precacheitem("rpg_straight_nosound");
  precachestring(&"JUNGLE_GHOSTS_SILENCER_TOGGLE");
  precachestring(&"JUNGLE_GHOSTS_INTROSCREEN_LINE_1");
  precachestring(&"JUNGLE_GHOSTS_INTROSCREEN_LINE_2");
  precachestring(&"JUNGLE_GHOSTS_INTROSCREEN_LINE_3");
  precachestring(&"JUNGLE_GHOSTS_INTROSCREEN_LINE_4");
  precachestring(&"JUNGLE_GHOSTS_INTROSCREEN_LINE_5");
  precachestring(&"JUNGLE_GHOSTS_OBIT_TREE");
  precachestring(&"JUNGLE_GHOSTS_FAIL_LEFT_SQUAD");
  precachestring(&"JUNGLE_GHOSTS_RPG_PICKUP_RELOAD");
  precachestring(&"JUNGLE_GHOSTS_RPG_PICKUP");
  precachestring(&"JUNGLE_GHOSTS_GRASS_DEATH_HINT1");
  precachestring(&"JUNGLE_GHOSTS_GRASS_DEATH_HINT2");
  precachestring(&"JUNGLE_GHOSTS_HINT_PLANE_DRAG");
  precachestring(&"JUNGLE_GHOSTS_HINT_PLANE_DRAG_NORMAL");
  precachestring(&"JUNGLE_GHOSTS_OBJ_REGROUP_AT_WATERFALL");
  precachestring(&"JUNGLE_GHOSTS_OBJ_SAVE_TEAM");
  precachestring(&"JUNGLE_GHOSTS_OBJ_ESC_TO_RIVER");
  precacheshellshock("prague_swim");
  precacheshellshock("underwater");
  precacheshellshock("player_limp");
  precacherumble("damage_heavy");
  precacherumble("tank_rumble");
  precacherumble("slide_loop");
}

init_starts() {
  maps\_utility::add_start("crash_test", ::crash_test_start, "New chopper crash test");
  maps\_utility::add_start("parachute", ::parachute_start, "Parachute");
  maps\_utility::add_start("jungle_corridor", ::jungle_corridor_start, "Jungle, no parachute");
  maps\_utility::add_start("jungle_hill", ::jungle_hill_start, "Jungle Hill");
  maps\_utility::add_start("waterfall", ::execution_start, "Waterfall Execution");
  maps\_utility::add_start("Stream", ::stream_start, "Stream");
  maps\_utility::add_start("Stream Waterfall", ::stream_waterfall_start, "Stream Waterfall");
  maps\_utility::add_start("grass", ::tall_grass_start, "tall_grass");
  maps\_utility::add_start("grass cold", ::tall_grass_start_cold, "tall_grass_cold");
  maps\_utility::add_start("grass chopper", ::tall_grass_chopper_start, "tall_grass_chopper");
  maps\_utility::add_start("grass nogame", ::tall_grass_nogame_start, "tall_grass - no scripting");
  maps\_utility::add_start("runway", ::runway_start, "Runway");
  maps\_utility::add_start("escape_runway", ::escape_runway_start, "Escape: Runway");
  maps\_utility::add_start("escape_jungle", ::escape_jungle_start, "Escape: Jungle");
  maps\_utility::add_start("escape_river", ::escape_river_start, "Escape: River");
  maps\_utility::add_start("escape_waterfall", ::escape_waterfall_start, "Escape: Waterfall Landing");
  maps\_utility::add_start("tree_test", ::dest_tree_test, "Destructible Tree test");
  maps\_utility::add_start("underwater", ::underwater_test, "underwater");
  maps\_utility::add_start("iplane_interrogation", ::iplane_interrogation, "iplane_intro");
  maps\_utility::add_start("iplane_crash", ::iplane_crash, "iplane_crash");
  maps\_utility::default_start(::iplane_interrogation);
}

init_level_flags() {
  level.player maps\_utility::ent_flag_init("recently_fired_weapon");
  level.player maps\_utility::ent_flag_init("tall_grass_player_protection");
  common_scripts\utility::flag_init("friendlies_ready");
  common_scripts\utility::flag_init("intro_lines");
  common_scripts\utility::flag_init("interupt_end");
  common_scripts\utility::flag_init("hill_flanked");
  common_scripts\utility::flag_init("hill_clear");
  common_scripts\utility::flag_init("player_at_execution");
  common_scripts\utility::flag_init("stop_water_footsteps");
  common_scripts\utility::flag_init("player_found_bravo");
  common_scripts\utility::flag_init("begin_shoot_chopper");
  common_scripts\utility::flag_init("stream_fight_begin");
  common_scripts\utility::flag_init("waterfall_hub");
  common_scripts\utility::flag_init("smaw_target_detroyed");
  common_scripts\utility::flag_init("stream_clear");
  common_scripts\utility::flag_init("waterfall_ambush_begin");
  common_scripts\utility::flag_init("ambush_open_fire");
  common_scripts\utility::flag_init("squad_in_ambush_position");
  common_scripts\utility::flag_init("player_in_ambush_position");
  common_scripts\utility::flag_init("ambush_guys_dead");
  common_scripts\utility::flag_init("ai_hold");
  common_scripts\utility::flag_init("player_didnt_ambush");
  common_scripts\utility::flag_init("tall_grass_goes_hot");
  common_scripts\utility::flag_init("tall_grass_intro_goes_hot");
  common_scripts\utility::flag_init("begin_runway_attack");
  common_scripts\utility::flag_init("runway_hot");
  common_scripts\utility::flag_init("intro_takedown_started");
  common_scripts\utility::flag_init("player_targeting");
  common_scripts\utility::flag_init("smaw_guy_get_into_pos");
  common_scripts\utility::flag_init("runway_choppers_return");
  common_scripts\utility::flag_init("chopper_over_tallgrass");
  common_scripts\utility::flag_init("squad_to_escape_slide");
  common_scripts\utility::flag_init("interrogtaion_started");
  common_scripts\utility::flag_init("player_rescued_hostage");
  common_scripts\utility::flag_init("player_shot_runway_with_wrong_weapon");
  common_scripts\utility::flag_init("adjusting_wind");
  common_scripts\utility::flag_init("player_is_moving");
  common_scripts\utility::flag_init("player_swim_faster");
  common_scripts\utility::flag_init("player_out_of_water");
  common_scripts\utility::flag_init("intro_takedown_ready");
  common_scripts\utility::flag_init("intro_takedown_done");
  common_scripts\utility::flag_init("intro_takedown_aborted");
  common_scripts\utility::flag_init("choppers_attacked");
  common_scripts\utility::flag_init("player_surfaces");
  common_scripts\utility::flag_init("runway_clear_to_shoot");
  common_scripts\utility::flag_init("jungle_section1_clear");
  common_scripts\utility::flag_init("squad_to_waterfall_ambush");
  common_scripts\utility::flag_init("skybox_changed");
  common_scripts\utility::flag_init("doing_lightning");
  common_scripts\utility::flag_init("player_landed");
  common_scripts\utility::flag_init("chopper_crash_complete");
  common_scripts\utility::flag_init("doing_story_vo");
  common_scripts\utility::flag_init("player_has_rpg");
  common_scripts\utility::flag_init("player_jumping");
  common_scripts\utility::flag_init("player_jump_watcher_stop");
  common_scripts\utility::flag_init("player_fell_off_waterfall");
  common_scripts\utility::flag_init("player_spotted_music");
  common_scripts\utility::flag_init("player_spotted_vo");
  common_scripts\utility::flag_init("chopper_impact");
  common_scripts\utility::flag_init("grass_went_hot");
  common_scripts\utility::flag_init("second_distant_sat_launch");
  common_scripts\utility::flag_init("tall_grass_heli_unloaded");
  common_scripts\utility::flag_init("moving_into_tall_grass");
  common_scripts\utility::flag_init("can_see_chopper");
  common_scripts\utility::flag_init("bridge_approach");
  common_scripts\utility::flag_init("stream_rush_chopper");
  common_scripts\utility::flag_init("waterfall_patrollers_dead");
  common_scripts\utility::flag_init("waterfall_patrollers_passed");
  common_scripts\utility::flag_init("choppers_get_down");
  common_scripts\utility::flag_init("choppers_saw_player");
  common_scripts\utility::flag_init("choppers_are_gone");
  common_scripts\utility::flag_init("stream_backend_moveup_stealth");
  common_scripts\utility::flag_init("backend_friendlies_go_hot");
  common_scripts\utility::flag_init("chopper_tallgrass_gone");
  common_scripts\utility::flag_init("stream_heli_out");
  common_scripts\utility::flag_init("time_for_chopper_to_leave");
  common_scripts\utility::flag_init("e3_warp");
  common_scripts\utility::flag_init("chopper_about_to_leave");
  common_scripts\utility::flag_init("hostage_a_group_shot");
  common_scripts\utility::flag_init("hostage_b_group_shot");
  common_scripts\utility::flag_init("took_long_enough_to_rescue");
  common_scripts\utility::flag_init("got_close_enough_to_rescue");
  common_scripts\utility::flag_init("player_rushed_waterfall_passers");
  common_scripts\utility::flag_init("box_swap");
  common_scripts\utility::flag_init("waterfall_ambush_over");
  common_scripts\utility::flag_init("field_dialogue_cue");
  common_scripts\utility::flag_init("hostage_flag_set");
  common_scripts\utility::flag_init("player_agro_near_execution");
  common_scripts\utility::flag_init("stream_enemy_alert");
  common_scripts\utility::flag_init("start_removing_stream_guys");
  common_scripts\utility::flag_init("obj_regroup");
  common_scripts\utility::flag_init("obj_save_team");
  common_scripts\utility::flag_init("obj_get_to_river");
  common_scripts\utility::flag_init("obj_all_done");
  common_scripts\utility::flag_init("pre_tall_grass_friendly_moveup_1");
  common_scripts\utility::flag_init("pre_tall_grass_friendly_moveup_2");
  common_scripts\utility::flag_init("pre_tall_grass_friendly_moveup_3");
  common_scripts\utility::flag_init("pre_tall_grass_friendly_moveup_4");
  common_scripts\utility::flag_init("pre_tall_grass_friendly_moveup_5");
  common_scripts\utility::flag_init("chopper_fire_on_player_hard");
  common_scripts\utility::flag_init("chopper_kill_player");
  common_scripts\utility::flag_init("waterfall_went_hot_late");
  common_scripts\utility::flag_init("starting_elias_rescue");
  common_scripts\utility::flag_init("start_pre_grass_patroller");
  common_scripts\utility::flag_init("begin_pre_tall_grass_scene");
  common_scripts\utility::flag_init("clear_to_move_into_tall_grass");
  common_scripts\utility::flag_init("tall_grass_hot_early_skip");
  common_scripts\utility::flag_init("backend_friendlies_go_hot_late");
  common_scripts\utility::flag_init("do_jungleg_bkr_coughingcatchingbreath");
  common_scripts\utility::flag_init("do_stream_chopper_fx");
  common_scripts\utility::flag_init("kill_face_fx");
  common_scripts\utility::flag_init("keep_tall_grass_alive_longer");
  var_0 = [];
  var_0[var_0.size] = "jungle_entrance";
  var_0[var_0.size] = "jungle_entrance_approach";
  var_0[var_0.size] = "hill_pos_1";
  var_0[var_0.size] = "hill_pos_4";
  var_0[var_0.size] = "hill_pos_5";
  var_0[var_0.size] = "hill_pos_6";
  var_0[var_0.size] = "waterfall_approach";
  var_0[var_0.size] = "waterfall_trig";
  var_0[var_0.size] = "chopper_crash_arrive";
  var_0[var_0.size] = "player_went_right";
  var_0[var_0.size] = "to_grassy_field";
  var_0[var_0.size] = "field_entrance";
  var_0[var_0.size] = "field_halfway";
  var_0[var_0.size] = "field_end";
  var_0[var_0.size] = "runway_approach";
  var_0[var_0.size] = "runway_arrive";
  var_0[var_0.size] = "player_slid";
  var_0[var_0.size] = "slide_start";
  var_0[var_0.size] = "escape_halfway";
  var_0[var_0.size] = "player_at_river";
  var_0[var_0.size] = "player_crossed_river";
  var_0[var_0.size] = "stryker_go";
  var_0[var_0.size] = "final_read";
  var_0[var_0.size] = "waterfall_to_stream";
  var_0[var_0.size] = "stream_exit";
  var_0[var_0.size] = "crash_arrive";
  var_0[var_0.size] = "player_slide_arrive";
  var_0[var_0.size] = "stream_backend_start";
  var_0[var_0.size] = "stream_backend_moveup";
  var_0[var_0.size] = "player_rushed_chopper_crash";
  var_0[var_0.size] = "abort_chopper_crash";
  var_0[var_0.size] = "bridge_area_exit";
  var_0[var_0.size] = "squad_to_waterfall";
  var_0[var_0.size] = "runway_halfway";
  var_0[var_0.size] = "can_see_chopper";
  var_0[var_0.size] = "bridge_approach";
  var_0[var_0.size] = "stream_rush_chopper";
  var_0[var_0.size] = "stream_backend_moveup_stealth";
  var_0[var_0.size] = "retreat_to_tall_grass";
  var_0[var_0.size] = "jump_vo_trig";

  foreach(var_2 in var_0) {
    init_flag_and_set_on_targetname_trigger(var_2);
  }
}

init_flag_and_set_on_targetname_trigger(var_0) {
  common_scripts\utility::flag_init(var_0);
  thread maps\_utility::set_flag_on_targetname_trigger(var_0);
}

init_radio_dialogue() {
  level.scr_radio["jungleg_at1_online"] = "jungleg_at1_online";
  level.scr_radio["jungleg_at2_whatdoyousee"] = "jungleg_at2_whatdoyousee";
  level.scr_radio["jungleg_at1_lotsoftrees"] = "jungleg_at1_lotsoftrees";
  level.scr_radio["jungleg_bt1_halfaclick"] = "jungleg_bt1_halfaclick";
  level.scr_radio["jungleg_at1_scanning"] = "jungleg_at1_scanning";
  level.scr_radio["jungleg_at1_goteyes"] = "jungleg_at1_goteyes";
  level.scr_radio["jungleg_at1_donotengage"] = "jungleg_at1_donotengage";
  level.scr_radio["jungleg_bt1_toodifficult"] = "jungleg_bt1_toodifficult";
  level.scr_radio["jungleg_at1_delayingrmp"] = "jungleg_at1_delayingrmp";
  level.scr_radio["jungleg_chq_radiosilence"] = "jungleg_chq_radiosilence";
  level.scr_radio["jungleg_at1_etaonrmp"] = "jungleg_at1_etaonrmp";
  level.scr_radio["jungleg_chq_rmpactive"] = "jungleg_chq_rmpactive";
}

init_dialogue() {
  level.scr_sound["alpha1"]["jungleg_at1_weredark"] = "jungleg_at1_weredark";
  level.scr_sound["alpha1"]["jungleg_at1_takeusout"] = "jungleg_at1_takeusout";
  level.scr_sound["alpha1"]["jungleg_at1_rattlingthecage"] = "jungleg_at1_rattlingthecage";
  level.scr_sound["alpha1"]["jungleg_at1_yourcall"] = "jungleg_at1_yourcall";
  level.scr_sound["alpha1"]["jungleg_at1_goinsilent"] = "jungleg_at1_goinsilent";
  level.scr_sound["alpha1"]["jungleg_at1_halfclickup"] = "jungleg_at1_halfclickup";
  level.scr_sound["alpha1"]["jungleg_at1_mightneedextract"] = "jungleg_at1_mightneedextract";
  level.scr_sound["alpha1"]["jungleg_at1_topofthehill"] = "jungleg_at1_topofthehill";
  level.scr_sound["alpha1"]["jungleg_at1_soundsbad"] = "jungleg_at1_soundsbad";
  level.scr_sound["alpha1"]["jungleg_at1_pickone"] = "jungleg_at1_pickone";
  level.scr_sound["alpha1"]["jungleg_at1_gotcompany"] = "jungleg_at1_gotcompany";
  level.scr_sound["alpha1"]["jungleg_at1_thatwasclose"] = "jungleg_at1_thatwasclose";
  level.scr_sound["alpha1"]["jungleg_at1_withyou"] = "jungleg_at1_withyou";
  level.scr_sound["alpha1"]["jungleg_at1_withya"] = "jungleg_at1_withya";
  level.scr_sound["alpha1"]["jungleg_at1_hesdown"] = "jungleg_at1_hesdown";
  level.scr_sound["alpha1"]["jungleg_at1_targetdown"] = "jungleg_at1_targetdown";
  level.scr_sound["alpha1"]["jungleg_at1_theresthewaterfall"] = "jungleg_at1_theresthewaterfall";
  level.scr_sound["alpha1"]["jungleg_at1_letsdoit"] = "jungleg_at1_letsdoit";
  level.scr_sound["alpha1"]["jungleg_at1_whenyouare"] = "jungleg_at1_whenyouare";
  level.scr_sound["alpha1"]["jungleg_at1_foundabody"] = "jungleg_at1_foundabody";
  level.scr_sound["alpha1"]["jungleg_at1_letsdoit"] = "jungleg_at1_letsdoit";
  level.scr_sound["alpha1"]["jungleg_at1_whenyouare"] = "jungleg_at1_whenyouare";
  level.scr_sound["alpha2"]["jungleg_at2_gotcompany"] = "jungleg_at2_gotcompany";
  level.scr_sound["alpha2"]["jungleg_at2_thatwasclose"] = "jungleg_at2_thatwasclose";
  level.scr_sound["alpha2"]["jungleg_at2_withyou"] = "jungleg_at2_withyou";
  level.scr_sound["alpha2"]["jungleg_at2_withya"] = "jungleg_at2_withya";
  level.scr_sound["alpha2"]["jungleg_at2_imwithyou"] = "jungleg_at2_imwithyou";
  level.scr_sound["alpha2"]["jungleg_at2_hesdown"] = "jungleg_at2_hesdown";
  level.scr_sound["alpha2"]["jungleg_at2_targetdown"] = "jungleg_at2_targetdown";
  level.scr_sound["alpha2"]["jungleg_at2_theresthewaterfall"] = "jungleg_at2_theresthewaterfall";
  level.scr_sound["alpha2"]["jungleg_at2_letsdoit"] = "jungleg_at2_letsdoit";
  level.scr_sound["alpha2"]["jungleg_at2_whenyouare"] = "jungleg_at2_whenyouare";
  level.scr_sound["alpha2"]["jungleg_at2_foundabody"] = "jungleg_at2_foundabody";
  level.scr_sound["alpha2"]["jungleg_at2_letsdoit"] = "jungleg_at2_letsdoit";
  level.scr_sound["alpha2"]["jungleg_at2_whenyouare"] = "jungleg_at2_whenyouare";
}

should_toggle_silencer() {
  var_0 = level.player getcurrentweapon();
  var_1 = strtok(var_0, "_");

  if(isDefined(var_1.size)) {
    if(var_1[0] == "alt") {
      return 1;
    } else {
      return 0;
    }
  }
}

should_switchto_soflam() {
  if(level.player getcurrentweapon() == "soflam") {
    return 1;
  }

  return 0;
}

should_use_soflam() {
  if(level.player getcurrentweapon() == "soflam" && level.player playerads() >= 0.25) {
    return 1;
  }

  return 0;
}

jungle_start() {
  maps\iplane::iplane_unload();
  thread maps\jungle_ghosts_jungle::intro_setup();
  thread objectives("jungle");
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

parachute_start() {
  maps\iplane::iplane_unload();
  thread maps\jungle_ghosts_jungle::intro_setup();
  thread objectives("jungle");
}

jungle_corridor_start() {
  maps\iplane::iplane_unload();
  common_scripts\utility::flag_set("player_landed");
  thread maps\jungle_ghosts_util::cull_distance_logic();
  maps\jungle_ghosts_util::move_player_to_start("jungle_corridor_player");
  thread maps\jungle_ghosts_jungle::setup_friendlies();
  thread maps\jungle_ghosts_jungle::setup_jungle_enemies();
  thread maps\jungle_ghosts_jungle::dead_pilot_hang();
  maps\_utility::activate_trigger_with_targetname("corridor_moveup");
  thread objectives("jungle");
  thread maps\jungle_ghosts_jungle::hill_fx();
  thread maps\jungle_ghosts_util::do_bokeh("hill_pos_1");
  thread maps\jungle_ghosts_jungle::do_birds();
  thread maps\jungle_ghosts_jungle::jungle_stealth_settings();
  thread maps\jungle_ghosts_jungle::connect_dropdown_traverse();
  level.did_inactive_vo = 0;
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player setmovespeedscale(0.9);
  level.player disableinvulnerability();
  var_0 = ["p226_tactical+silencerpistol_sp+tactical_sp"];
  maps\jungle_ghosts_util::arm_player(var_0);
  wait 1;
  common_scripts\utility::flag_wait("jungle_entrance");
  maps\_utility::autosave_stealth();
  common_scripts\utility::flag_wait("crash_arrive");
  var_1 = common_scripts\utility::getstructarray("jungle_corridor_ai", "targetname");

  while(!isDefined(level.alpha)) {
    wait 0.1;
  }

  foreach(var_4, var_3 in var_1) {
    level.alpha[var_4] forceteleport(var_3.origin, var_3.angles);
    level.alpha[var_4] maps\_utility::set_force_color("r");
  }

  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

crash_test_start() {
  level.player setorigin((673, 5084, 564.411));
  var_0 = getent("crash_final_collision", "targetname");
  var_0 notsolid();
  var_1 = getent("dest_crate", "targetname");
  var_1 notsolid();
  var_2 = common_scripts\utility::getstruct("new_crash", "targetname");
  var_2.chopper = maps\_utility::spawn_anim_model("aas");
  var_2.chopper thread maps\jungle_ghosts_stream::chopper_sound();
  thread maps\jungle_ghosts_stream::chopper_rumble_earthquake();
  var_2.crate_clip = getent("chopper_clip", "targetname");
  var_2.crate_clip.origin = var_2.chopper.origin;
  var_2.crate_clip.angles = var_2.chopper.angles;
  var_2.crate_clip linkto(var_2.chopper, "tag_origin");
  var_2.pristine_crate = maps\_utility::spawn_anim_model("pristine_crate");
  var_2.damaged_crate = maps\_utility::spawn_anim_model("damaged_crate");
  var_2.pilot = maps\_utility::spawn_targetname("chopper_pilot", 1);
  var_2.pilot.animname = "pilot";
  var_2.pilot thread maps\jungle_ghosts_stream::crash_pilot_logic(var_2.chopper);
  var_2.pilot_corpse = spawn("script_model", var_2.origin);
  var_2.pilot_corpse setModel(var_2.pilot.model);
  var_2.pilot_corpse useanimtree(#animtree);
  var_2.pilot_corpse.origin = var_2.chopper gettagorigin("tag_driver");
  var_2.pilot_corpse.angles = var_2.chopper gettagangles("tag_driver");
  var_2.pilot_corpse linkto(var_2.chopper);
  var_2.pilot_corpse setanimknob( % jungle_ghost_helicrash_pilot, 1, 0, 0);
  var_2.pilot_corpse setanimtime( % jungle_ghost_helicrash_pilot, 1);
  var_2.actors = [var_2.pilot, var_2.pristine_crate, var_2.damaged_crate, var_2.chopper];
  var_2 thread maps\_anim::anim_loop(var_2.actors, "new_crash_idle");
  wait 5;
  common_scripts\utility::flag_set("smaw_target_detroyed");
  var_2 maps\_anim::anim_single(var_2.actors, "new_crash");
  var_0 solid();
  var_0 disconnectpaths();
  var_2.crate_clip delete();
}

dest_tree_test() {
  maps\jungle_ghosts_runway::escape_setup_trees();
  level.player setorigin((246, 11798, 755.036));
  level.player setplayerangles((0, 180, 0));
  maps\jungle_ghosts_util::arm_player(["honeybadger+acog_sp"]);
  common_scripts\utility::flag_set("choppers_saw_player");
}

underwater_test() {
  var_0 = common_scripts\utility::getstruct("struct_player_bigjump_edge_reference", "targetname");
  level.player setorigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  level.player enableinvulnerability();
  level.mover = level.player common_scripts\utility::spawn_tag_origin();
  thread maps\jungle_ghosts_runway::escape_player_water_logic();
  thread maps\jungle_ghosts_runway::new_player_jump();
}

custom_intro_screen_func() {
  common_scripts\utility::flag_wait("intro_lines");
  maps\_introscreen::introscreen(1);
}

jungle_hill_start() {
  common_scripts\utility::flag_set("jungle_entrance");
  thread maps\jungle_ghosts_jungle::hill_fx();
  thread maps\jungle_ghosts_util::cull_distance_logic();
  level thread maps\jungle_ghosts_jungle::jungle_stealth_settings();
  thread objectives("jungle_hill");
  maps\_utility::array_spawn_function_targetname("alpha_team", maps\jungle_ghosts_jungle::jungle_friendly_logic);
  thread maps\jungle_ghosts_jungle::setup_hill_enemies();
  maps\jungle_ghosts_util::move_player_to_start("jungle_hill_start_player");
  var_0 = ["p226_tactical+silencerpistol_sp+tactical_sp", "honeybadger+acog_sp"];
  maps\jungle_ghosts_util::arm_player(var_0, 1);
  wait 1;
  wait 0.5;
  level thread maps\jungle_ghosts_jungle::friendly_navigation();
  level thread maps\jungle_ghosts_jungle::jungle_vo();
  level thread maps\jungle_ghosts_jungle::player_spotted_logic();
  common_scripts\utility::flag_set("jungle_entrance");
  maps\_utility::activate_trigger_with_targetname("jungle_entrance");
  common_scripts\utility::flag_wait("waterfall_approach");
  thread maps\jungle_ghosts_jungle::waterfall_execution();
  level.player thread maps\jungle_ghosts_util::stream_waterfx("stop_water_footsteps", "step_run_plr_water");
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

execution_start() {
  maps\iplane::iplane_unload();
  common_scripts\utility::flag_set("jungle_entrance");
  thread objectives("waterfall");
  maps\jungle_ghosts_util::move_player_to_start("waterfall_execution_player");
  var_0 = ["honeybadger+acog_sp", "p226_tactical+silencerpistol_sp+tactical_sp"];
  maps\jungle_ghosts_util::arm_player(var_0, 1);
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);
  assign_alpha();
  var_1 = common_scripts\utility::getstructarray("waterfall_execution_ai", "targetname");

  foreach(var_4, var_3 in var_1) {
    level.alpha[var_4] forceteleport(var_3.origin, var_3.angles);
    level.alpha[var_4] maps\_utility::set_force_color("r");
    level.alpha[var_4] maps\_utility::ent_flag_init("stealth_kill");
    level.alpha[var_4] thread maps\_utility::magic_bullet_shield(1);
  }

  thread maps\jungle_ghosts_jungle::waterfall_execution();
  maps\_utility::activate_trigger_with_targetname("waterfall_approach");
  level thread maps\jungle_ghosts_jungle::jungle_vo();
  maps\_utility::friendlyfire_warnings_off();
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

stream_start() {
  maps\iplane::iplane_unload();
  common_scripts\utility::flag_set("jungle_entrance");
  common_scripts\utility::flag_set("second_distant_sat_launch");
  common_scripts\utility::flag_set("intro_lines");
  common_scripts\utility::flag_set("obj_get_to_river");
  var_0 = common_scripts\utility::get_target_ent("river_blocker");
  var_0 connectpaths();
  var_0 delete();
  thread objectives("stream");
  maps\jungle_ghosts_util::move_player_to_start("stream_start_player");
  var_1 = ["honeybadger+acog_sp", "p226_tactical+silencerpistol_sp+tactical_sp"];
  maps\jungle_ghosts_util::arm_player(var_1, 1);
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);
  assign_alpha();
  level.bravo = maps\_utility::array_spawn_targetname("bravo_team", 1);
  assign_bravo();
  var_2 = common_scripts\utility::getstructarray("stream_start_ai", "targetname");
  level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
  var_3 = getaiarray("allies");

  foreach(var_6, var_5 in var_2) {
    var_3[var_6] forceteleport(var_5.origin, var_5.angles);
  }

  setup_squad_stealth();
  common_scripts\utility::array_thread(level.bravo, maps\_utility::set_force_color, "b");
  common_scripts\utility::array_thread(level.alpha, maps\_utility::set_force_color, "r");
  common_scripts\utility::array_thread(level.alpha, maps\_utility::enable_ai_color);
  common_scripts\utility::flag_set("player_rescued_hostage");
  common_scripts\utility::flag_set("second_distant_sat_launch");
  common_scripts\utility::flag_set("player_rescued_hostage");
  common_scripts\utility::array_thread(var_3, ::stream_friendly_setup);
  thread maps\jungle_ghosts_stream::friendly_stream_navigation();
  level.player thread maps\jungle_ghosts_util::stream_waterfx("stop_water_footsteps", "step_run_plr_water");
  maps\_utility::friendlyfire_warnings_off();
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

stream_waterfall_start() {
  maps\iplane::iplane_unload();
  common_scripts\utility::flag_set("jungle_entrance");
  common_scripts\utility::flag_set("second_distant_sat_launch");
  common_scripts\utility::flag_set("intro_lines");
  common_scripts\utility::flag_set("obj_get_to_river");
  thread objectives("stream");
  maps\jungle_ghosts_util::move_player_to_start("stream_waterfall_player");
  var_0 = ["p226_tactical+silencerpistol_sp+tactical_sp", "honeybadger+acog_sp"];
  maps\jungle_ghosts_util::arm_player(var_0, 1);
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);
  assign_alpha();
  level.bravo = maps\_utility::array_spawn_targetname("bravo_team", 1);
  assign_bravo();
  level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
  var_1 = common_scripts\utility::getstructarray("stream_waterfall_ai", "targetname");
  var_2 = getaiarray("allies");

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] forceteleport(var_4.origin, var_4.angles);
  }

  setup_squad_stealth();
  common_scripts\utility::array_thread(level.bravo, maps\_utility::set_force_color, "b");
  common_scripts\utility::array_thread(level.alpha, maps\_utility::set_force_color, "r");
  common_scripts\utility::array_thread(level.alpha, maps\_utility::enable_ai_color);
  common_scripts\utility::array_thread(level.squad, maps\_utility::ent_flag_init, "stealth_kill");
  common_scripts\utility::array_thread(var_2, ::stream_friendly_setup);
  thread maps\jungle_ghosts_stream::friendly_stream_navigation();
  thread maps\jungle_ghosts_stream::stream_enemy_setup("waterfall");
  level.player thread maps\jungle_ghosts_util::stream_waterfx("stop_water_footsteps", "step_run_plr_water");
  maps\_utility::friendlyfire_warnings_off();
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

stream_backend_start() {
  common_scripts\utility::flag_set("jungle_entrance");
  common_scripts\utility::flag_set("second_distant_sat_launch");
  common_scripts\utility::flag_set("intro_lines");
  common_scripts\utility::flag_set("obj_get_to_river");
  thread objectives("stream");
  maps\jungle_ghosts_util::move_player_to_start("stream_backend_player");
  var_0 = ["p226_tactical+silencerpistol_sp+tactical_sp", "honeybadger+acog_sp"];
  maps\jungle_ghosts_util::arm_player(var_0, 1);
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);
  assign_alpha();
  level.bravo = maps\_utility::array_spawn_targetname("bravo_team", 1);
  assign_bravo();
  level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
  var_1 = common_scripts\utility::getstructarray("stream_backend_ai", "targetname");
  common_scripts\utility::array_thread(level.squad, maps\_utility::ent_flag_init, "stealth_kill");
  var_2 = getaiarray("allies");

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] forceteleport(var_4.origin, var_4.angles);
  }

  setup_squad_stealth();
  common_scripts\utility::array_thread(level.bravo, maps\_utility::set_force_color, "b");
  common_scripts\utility::array_thread(level.alpha, maps\_utility::set_force_color, "r");
  common_scripts\utility::array_thread(level.alpha, maps\_utility::enable_ai_color);
  common_scripts\utility::array_thread(var_2, ::stream_friendly_setup);
  thread maps\jungle_ghosts_stream::friendly_stream_navigation();
  thread maps\jungle_ghosts_stream::stream_enemy_setup("backend");
  level.player thread maps\jungle_ghosts_util::stream_waterfx("stop_water_footsteps", "step_run_plr_water");
  thread swap_to_overcast_sky();
  maps\_utility::friendlyfire_warnings_off();
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

tall_grass_start() {
  maps\iplane::iplane_unload();
  common_scripts\utility::flag_set("jungle_entrance");
  common_scripts\utility::flag_set("second_distant_sat_launch");
  common_scripts\utility::flag_set("intro_lines");
  common_scripts\utility::flag_set("obj_get_to_river");
  thread objectives("tall_grass");
  common_scripts\utility::flag_set("ambush_open_fire");
  var_0 = getent("stream_backend_moveup_stealth", "targetname");
  var_0 delete();
  maps\jungle_ghosts_util::move_player_to_start("tall_grass_player");
  var_1 = ["p226_tactical+silencerpistol_sp+tactical_sp", "honeybadger+acog_sp"];
  maps\jungle_ghosts_util::arm_player(var_1);
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);
  assign_alpha();
  level.bravo = maps\_utility::array_spawn_targetname("bravo_team", 1);
  assign_bravo();
  var_2 = common_scripts\utility::getstructarray("tall_grass_ai", "targetname");
  var_3 = getaiarray("allies");

  foreach(var_6, var_5 in var_2) {
    var_3[var_6] forceteleport(var_5.origin, var_5.angles);
  }

  level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
  common_scripts\utility::array_thread(level.squad, maps\_utility::enable_ai_color);
  common_scripts\utility::array_thread(level.squad, ::tall_grass_friendly_setup);
  thread maps\jungle_ghosts_stream::stream_enemy_setup("none");
  common_scripts\utility::array_thread(level.squad, maps\_utility::ent_flag_init, "stealth_kill");
  setup_squad_stealth();
  common_scripts\utility::array_thread(level.alpha, maps\_utility::set_force_color, "r");
  common_scripts\utility::array_thread(level.bravo, maps\_utility::set_force_color, "b");
  thread maps\jungle_ghosts_stream::tall_grass_globals();
  thread maps\jungle_ghosts_stream::tall_grass_friendly_navigation();
  maps\_utility::activate_trigger_with_targetname("stream_exit");
  thread swap_to_overcast_sky();
  maps\_utility::activate_trigger_with_targetname("stream_backend_moveup");
  var_7 = maps\jungle_ghosts_stream::pre_tallgrass_guys_logic;
  maps\_utility::array_spawn_function_targetname("tall_grass_intro_guys", maps\jungle_ghosts_stream::pre_tallgrass_guys_logic);
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

tall_grass_start_cold() {
  maps\iplane::iplane_unload();
  common_scripts\utility::flag_set("jungle_entrance");
  common_scripts\utility::flag_set("second_distant_sat_launch");
  common_scripts\utility::flag_set("intro_lines");
  common_scripts\utility::flag_set("obj_get_to_river");
  thread objectives("tall_grass");
  var_0 = maps\jungle_ghosts_jungle::jungle_enemy_logic;
  maps\_utility::array_spawn_function_targetname("tall_grass_intro_guys_stealth", var_0, "zero", 1);
  var_0 = maps\jungle_ghosts_stream::pre_tall_grass_patroller_break_on_sight;
  maps\_utility::array_spawn_function_targetname("tall_grass_intro_guys_stealth", var_0);
  var_0 = maps\jungle_ghosts_stream::pre_tall_grass_patroller_logic;
  maps\_utility::array_spawn_function_noteworthy("tall_grass_patroller", var_0);
  maps\jungle_ghosts_util::move_player_to_start("tall_grass_player");
  var_1 = ["p226_tactical+silencerpistol_sp+tactical_sp", "honeybadger+acog_sp"];
  maps\jungle_ghosts_util::arm_player(var_1);
  wait 1;
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);
  assign_alpha();
  level.bravo = maps\_utility::array_spawn_targetname("bravo_team", 1);
  assign_bravo();
  var_2 = common_scripts\utility::getstructarray("tall_grass_ai", "targetname");
  var_3 = getaiarray("allies");

  foreach(var_6, var_5 in var_2) {
    var_3[var_6] forceteleport(var_5.origin, var_5.angles);
  }

  var_7 = getent("stream_backend_moveup", "targetname");
  var_7 delete();
  level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
  common_scripts\utility::array_thread(level.squad, maps\_utility::enable_ai_color);
  common_scripts\utility::array_thread(level.squad, ::tall_grass_friendly_setup);
  thread maps\jungle_ghosts_stream::stream_enemy_setup("none");
  common_scripts\utility::array_thread(level.squad, maps\_utility::ent_flag_init, "stealth_kill");
  setup_squad_stealth();
  common_scripts\utility::array_thread(level.alpha, maps\_utility::set_force_color, "r");
  common_scripts\utility::array_thread(level.bravo, maps\_utility::set_force_color, "b");
  thread maps\jungle_ghosts_stream::tall_grass_globals();
  thread maps\jungle_ghosts_stream::friendly_stream_navigation();
  maps\_utility::activate_trigger_with_targetname("stream_exit");
  thread swap_to_overcast_sky();
  common_scripts\utility::flag_wait("stream_exit");
  maps\_utility::activate_trigger_with_targetname("stream_backend_moveup_stealth");
  common_scripts\utility::trigger_off("stream_backend_moveup_stealth", "targetname");
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

tall_grass_chopper_start() {
  maps\iplane::iplane_unload();
  common_scripts\utility::flag_set("jungle_entrance");
  common_scripts\utility::flag_set("second_distant_sat_launch");
  common_scripts\utility::flag_set("intro_lines");
  common_scripts\utility::flag_set("obj_get_to_river");
  thread objectives("tall_grass");
  maps\jungle_ghosts_util::move_player_to_start("tall_grass_chopper_player");
  var_0 = ["p226_tactical+silencerpistol_sp+tactical_sp", "honeybadger+acog_sp"];
  maps\jungle_ghosts_util::arm_player(var_0);
  wait 1;
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);
  assign_alpha();
  level.bravo = maps\_utility::array_spawn_targetname("bravo_team", 1);
  assign_bravo();
  var_1 = common_scripts\utility::getstructarray("tall_grass_chopper_ai", "targetname");
  var_2 = getaiarray("allies");

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] forceteleport(var_4.origin, var_4.angles);
  }

  common_scripts\utility::array_thread(level.alpha, maps\_utility::set_force_color, "r");
  common_scripts\utility::array_thread(level.bravo, maps\_utility::set_force_color, "b");
  level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
  common_scripts\utility::array_thread(level.squad, maps\_utility::enable_ai_color);
  common_scripts\utility::array_thread(level.squad, ::tall_grass_friendly_setup);
  thread maps\jungle_ghosts_stream::stream_enemy_setup("none");
  setup_squad_stealth();
  thread maps\jungle_ghosts_stream::tall_grass_globals(1);
  thread maps\jungle_ghosts_stream::tall_grass_friendly_navigation();
  common_scripts\utility::flag_set("to_grassy_field");
  common_scripts\utility::flag_set("jungle_entrance");
  thread swap_to_overcast_sky();
  badplace_delete("pre_tall_grass0");
  badplace_delete("pre_tall_grass1");
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

tall_grass_nogame_start() {
  maps\iplane::iplane_unload();
  thread swap_to_overcast_sky();
  maps\jungle_ghosts_util::move_player_to_start("nogame_player_start");
  var_0 = ["p226_tactical+silencerpistol_sp+tactical_sp", "honeybadger+acog_sp"];
  maps\jungle_ghosts_util::arm_player(var_0, 1);
  common_scripts\utility::flag_set("field_entrance");
  level thread maps\jungle_ghosts_stream::tall_grass_moving_grass_settings();
}

runway_start() {
  maps\iplane::iplane_unload();
  common_scripts\utility::flag_set("jungle_entrance");
  common_scripts\utility::flag_set("second_distant_sat_launch");
  common_scripts\utility::flag_set("intro_lines");
  thread maps\jungle_ghosts_runway::runway_setup();
  maps\jungle_ghosts_util::move_player_to_start("runway_player");
  var_0 = ["p226_tactical+silencerpistol_sp+tactical_sp", "honeybadger+acog_sp"];
  maps\jungle_ghosts_util::arm_player(var_0, 1);
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);
  assign_alpha();
  level.bravo = maps\_utility::array_spawn_targetname("bravo_team", 1);
  assign_bravo();
  var_1 = common_scripts\utility::getstructarray("runway_ai", "targetname");
  var_2 = getaiarray("allies");

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] forceteleport(var_4.origin, var_4.angles);
  }

  level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
  common_scripts\utility::array_thread(level.squad, maps\_utility::enable_ai_color);
  common_scripts\utility::array_thread(level.squad, ::tall_grass_friendly_setup);
  common_scripts\utility::array_thread(level.alpha, maps\_utility::set_force_color, "r");
  common_scripts\utility::array_thread(level.bravo, maps\_utility::set_force_color, "b");
  maps\_utility::activate_trigger_with_targetname("squad_to_runway");
  thread objectives("runway");
  thread runway_escape_weather();
  thread swap_to_overcast_sky();
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

runway_escape_weather() {
  thread maps\jungle_ghosts_util::start_raining();
  thread maps\jungle_ghosts_util::thunder_and_lightning(8, 12);
  level.player setclienttriggeraudiozone("jungle_ghosts_escape_rain", 0.1);
}

escape_runway_start() {
  maps\iplane::iplane_unload();
  common_scripts\utility::flag_set("jungle_entrance");
  common_scripts\utility::flag_set("second_distant_sat_launch");
  common_scripts\utility::flag_set("intro_lines");
  common_scripts\utility::flag_set("obj_get_to_river");
  maps\jungle_ghosts_util::move_player_to_start("escape_runway_player");
  var_0 = ["p226_tactical+silencerpistol_sp+tactical_sp", "honeybadger+acog_sp"];
  maps\jungle_ghosts_util::arm_player(var_0, 1);
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);
  assign_alpha();
  level.bravo = maps\_utility::array_spawn_targetname("bravo_team", 1);
  assign_bravo();
  var_1 = common_scripts\utility::getstructarray("escape_runway_ai", "targetname");
  var_2 = getaiarray("allies");

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] forceteleport(var_4.origin, var_4.angles);
  }

  common_scripts\utility::array_thread(level.alpha, maps\_utility::set_force_color, "r");
  common_scripts\utility::array_thread(level.bravo, maps\_utility::set_force_color, "b");
  level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
  common_scripts\utility::array_thread(level.squad, maps\_utility::enable_ai_color);
  common_scripts\utility::array_thread(level.squad, maps\_utility::magic_bullet_shield);
  setup_squad_stealth();
  maps\_utility::activate_trigger_with_targetname("squad_to_runway");
  thread objectives("escape_runway");
  thread maps\jungle_ghosts_runway::escape_globals("runway");
  var_6 = maps\_utility::getent_or_struct("apache1_start_point", "script_noteworthy");
  var_7 = getent("runway_apache", "script_noteworthy");
  level.apache1 = maps\_vehicle::vehicle_spawn(var_7);
  level.apache1 thread maps\jungle_ghosts_runway::runway_apache_logic("runway");
  level.apache1 vehicle_teleport(var_6.origin, var_6.angles);
  level.apache1 thread maps\_vehicle::vehicle_paths(var_6);
  wait 0.1;
  level.apache1 vehicle_setspeedimmediate(50);
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

escape_jungle_start() {
  maps\iplane::iplane_unload();
  common_scripts\utility::flag_set("jungle_entrance");
  common_scripts\utility::flag_set("second_distant_sat_launch");
  common_scripts\utility::flag_set("intro_lines");
  common_scripts\utility::flag_set("obj_get_to_river");
  maps\jungle_ghosts_util::move_player_to_start("escape_jungle_player");
  var_0 = ["p226_tactical+silencerpistol_sp+tactical_sp", "honeybadger+acog_sp"];
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);
  assign_alpha();
  level.bravo = maps\_utility::array_spawn_targetname("bravo_team", 1);
  assign_bravo();
  var_1 = common_scripts\utility::getstructarray("escape_jungle_ai", "targetname");
  var_2 = getaiarray("allies");

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] forceteleport(var_4.origin, var_4.angles);
  }

  common_scripts\utility::array_thread(level.alpha, maps\_utility::set_force_color, "r");
  common_scripts\utility::array_thread(level.bravo, maps\_utility::set_force_color, "b");
  level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
  common_scripts\utility::array_thread(level.squad, maps\_utility::enable_ai_color);
  common_scripts\utility::array_thread(level.squad, maps\_utility::magic_bullet_shield);
  setup_squad_stealth();
  thread objectives("escape_runway");
  thread maps\jungle_ghosts_runway::escape_globals("jungle");
  var_6 = maps\_utility::getent_or_struct("chopper_over_tallgrass", "script_noteworthy");
  var_7 = getent("runway_apache", "script_noteworthy");
  level.apache1 = maps\_vehicle::vehicle_spawn(var_7);
  level.apache1 vehicle_teleport(var_6.origin, (0, 130, 0));
  level.apache1 thread maps\jungle_ghosts_runway::runway_apache_logic("jungle");
  thread runway_escape_weather();
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

iplane_interrogation() {
  level thread maps\iplane::iplane_start();
}

iplane_crash() {
  level thread maps\iplane::iplane_crash();
}

escape_river_start() {
  maps\iplane::iplane_unload();
  common_scripts\utility::flag_set("jungle_entrance");
  common_scripts\utility::flag_set("second_distant_sat_launch");
  common_scripts\utility::flag_set("intro_lines");
  common_scripts\utility::flag_set("obj_get_to_river");
  thread maps\jungle_ghosts_jungle::slomo_sound_scale_setup();
  level.river_apache = thread maps\_vehicle::spawn_vehicle_from_targetname_and_drive("river_chopper");
  maps\jungle_ghosts_util::move_player_to_start("escape_river_player");
  var_0 = ["p226_tactical+silencerpistol_sp+tactical_sp", "honeybadger+acog_sp"];
  maps\jungle_ghosts_util::arm_player(var_0, 1);
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);
  assign_alpha();
  level.bravo = maps\_utility::array_spawn_targetname("bravo_team", 1);
  var_1 = common_scripts\utility::getstructarray("escape_river_ai", "targetname");
  var_2 = getaiarray("allies");

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] forceteleport(var_4.origin, var_4.angles);
  }

  common_scripts\utility::array_thread(level.alpha, maps\_utility::set_force_color, "r");
  common_scripts\utility::array_thread(level.bravo, maps\_utility::set_force_color, "b");
  level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
  common_scripts\utility::array_thread(level.squad, maps\_utility::enable_ai_color);
  common_scripts\utility::array_thread(level.squad, maps\_utility::magic_bullet_shield);
  setup_squad_stealth();
  var_6 = maps\_utility::getent_or_struct("attack_river_jump", "targetname");
  var_7 = getent("runway_apache", "script_noteworthy");
  level.apache1 = maps\_vehicle::vehicle_spawn(var_7);
  level.apache1 vehicle_teleport(var_6.origin, var_6.angles);
  level.apache1 thread maps\jungle_ghosts_runway::runway_apache_logic("river");
  thread maps\jungle_ghosts_runway::escape_globals("river");
  common_scripts\utility::flag_set("escape_halfway");
  level.river_apache maps\_vehicle::mgoff();
  thread runway_escape_weather();
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

escape_waterfall_start() {
  maps\iplane::iplane_unload();
  common_scripts\utility::flag_set("jungle_entrance");
  common_scripts\utility::flag_set("second_distant_sat_launch");
  common_scripts\utility::flag_set("intro_lines");
  common_scripts\utility::flag_set("obj_get_to_river");
  level.river_apache = thread maps\_vehicle::spawn_vehicle_from_targetname_and_drive("river_chopper");
  maps\jungle_ghosts_util::move_player_to_start("waterfall_player_land");
  var_0 = ["p226_tactical+silencerpistol_sp+tactical_sp", "honeybadger+acog_sp"];
  maps\jungle_ghosts_util::arm_player(var_0, 1);
  level.alpha = maps\_utility::array_spawn_targetname("alpha_team", 1);
  assign_alpha();
  level.bravo = maps\_utility::array_spawn_targetname("bravo_team", 1);
  var_1 = common_scripts\utility::getstructarray("waterfall_ai_land", "targetname");
  var_2 = getaiarray("allies");

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] forceteleport(var_4.origin, var_4.angles);
  }

  common_scripts\utility::array_thread(level.alpha, maps\_utility::set_force_color, "r");
  common_scripts\utility::array_thread(level.bravo, maps\_utility::set_force_color, "b");
  level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
  common_scripts\utility::array_thread(level.squad, maps\_utility::enable_ai_color);
  common_scripts\utility::array_thread(level.squad, maps\_utility::magic_bullet_shield);
  setup_squad_stealth();
  thread runway_escape_weather();
  thread escape_setup_swimming();
  thread maps\jungle_ghosts_util::battle_chatter_controller_friendlies();
}

escape_setup_swimming() {
  level thread maps\jungle_ghosts_util::player_swim_think();

  foreach(var_1 in level.squad) {
    var_1 thread maps\jungle_ghosts_util::enable_ai_swim();
  }
}

stream_friendly_setup() {
  self.ignoreme = 1;
  thread maps\_utility::magic_bullet_shield(1);
  thread maps\jungle_ghosts_util::stream_waterfx("stop_water_footsteps", "step_run_plr_water");
}

stream_friendly_setup_e3() {
  self.ignoreme = 1;
  thread maps\jungle_ghosts_util::stream_waterfx("stop_water_footsteps", "step_run_plr_water");
}

tall_grass_friendly_setup() {
  thread maps\_utility::magic_bullet_shield(1);
  self.ignoreme = 1;
  self.ignoreall = 1;
}

swap_to_overcast_sky() {
  if(common_scripts\utility::flag("skybox_changed")) {
    return;
  }
  var_0 = getmapsunlight();
  var_1 = (0.804688, 0.878906, 0.996094);
  thread maps\_utility::sun_light_fade(var_0, var_1, 0.1);
  common_scripts\utility::flag_set("skybox_changed");

  if(isDefined(level.rain_skybox)) {
    level.rain_skybox show();
  }
}

assign_alpha() {
  foreach(var_1 in level.alpha) {
    if(var_1.script_friendname == "Elias") {
      level.alpha1 = var_1;
      level.alpha1.animname = "alpha1";
      level.alpha1 maps\_utility::forceuseweapon("honeybadger", "primary");
      level.alpha1 thread maps\_utility::set_ai_bcvoice("taskforce");
      level.alpha1 animscripts\battlechatter_ai::assign_npcid();
      continue;
    }

    level.alpha2 = var_1;
    level.alpha2.animname = "alpha2";
    level.alpha2 thread maps\_utility::set_ai_bcvoice("taskforce");
    level.alpha2 maps\_utility::forceuseweapon("honeybadger", "primary");
    level.alpha2 animscripts\battlechatter_ai::assign_npcid();
  }
}

assign_bravo() {
  foreach(var_1 in level.bravo) {
    if(var_1.script_friendname == "Merrick") {
      level.merrick = var_1;
      var_1.animname = "baker";
      var_1 thread maps\_utility::set_ai_bcvoice("taskforce");
      level.merrick maps\_utility::forceuseweapon("honeybadger", "primary");
      level.merrick animscripts\battlechatter_ai::assign_npcid();
      continue;
    }

    level.hesh = var_1;
    var_1.animname = "diaz";
    var_1 thread maps\_utility::set_ai_bcvoice("taskforce");
    level.hesh maps\_utility::forceuseweapon("honeybadger", "primary");
    level.hesh animscripts\battlechatter_ai::assign_npcid();
  }
}

objectives(var_0) {
  switch (var_0) {
    case "jungle":
    case "default":
      common_scripts\utility::flag_wait("obj_regroup");
      wait 1;
    case "jungle_hill":
    case "waterfall":
      objective_add(maps\_utility::obj("waterfall"), "current", &"JUNGLE_GHOSTS_OBJ_REGROUP_AT_WATERFALL");
      common_scripts\utility::flag_wait("waterfall_see_friendlies");
      maps\_utility::objective_complete(maps\_utility::obj("waterfall"));
      common_scripts\utility::flag_wait_any("player_at_execution", "obj_save_team");
      objective_add(maps\_utility::obj("rescue"), "current", &"JUNGLE_GHOSTS_OBJ_SAVE_TEAM");
      common_scripts\utility::flag_wait("player_rescued_hostage");
      maps\_utility::objective_complete(maps\_utility::obj("rescue"));
      common_scripts\utility::flag_wait("obj_get_to_river");
    case "escape_runway":
    case "runway":
    case "tall_grass":
    case "stream":
      objective_add(maps\_utility::obj("escape"), "current", &"JUNGLE_GHOSTS_OBJ_ESC_TO_RIVER");
      common_scripts\utility::flag_wait("obj_all_done");
      maps\_utility::objective_complete(maps\_utility::obj("escape"));
  }
}

setup_squad_stealth() {
  var_0 = maps\_stealth_utility::stealth_default;
  var_1 = maps\jungle_ghosts_util::friendly_jungle_stealth_color_behavior;
  common_scripts\utility::array_thread(level.squad, var_0);
  common_scripts\utility::array_thread(level.squad, var_1);
}

intro_stealth_spotted_check() {
  level.was_spotted = 0;
  common_scripts\utility::flag_wait_any("_stealth_spotted", "ambush_open_fire", "choppers_saw_player");
  level.was_spotted = 1;
}

setup_fire_damage() {
  var_0 = [];
  var_0[0] = (-2595.77, -1665.52, -402.233);
  var_0[1] = (-2543.83, -1644.33, -391.218);
  var_0[2] = (-2459.34, -752.736, -423.511);
  var_0[3] = (-2519.98, -1160.48, -408.619);
  var_0[4] = (-3044.98, -1504.99, -363.192);
  var_0[5] = (-3031.5, -1663.59, -397.669);
  var_0[6] = (-3142.29, -1533.65, -389.321);
  var_0[7] = (-3210.06, -1682.39, -416.253);
  var_0[8] = (-2814.12, -1157.09, -398.665);
  var_0[9] = (-2157.6, -781.504, -438.141);
  var_0[10] = (-2264.97, -1499.58, -429.448);
  var_0[11] = (-2241.24, -1616.73, -437.561);
  var_0[12] = (-2629.33, -608.276, -419.8);
  var_0[13] = (-2708, -1377.09, -401.751);
  var_0[14] = (-2103.42, -1285.64, -413.131);
  var_0[15] = (-2127.55, -1301.51, -419.345);
  var_0[16] = (-2453.06, -690.896, -379.602);
  var_0[17] = (-2655.49, -867.645, -416.411);
  var_0[18] = (-2166.7, -582.921, -367.181);
  var_1 = [];
  var_1[0] = (-4194.69, -4732.18, -224.489);
  var_1[1] = (-4194.69, -4732.18, -224.489);
  var_1[2] = (-2084.12, -1298.02, -370.623);
  var_2 = [];
  var_2[0] = (-2442.65, -529.762, -395.673);
  var_2[1] = (-2737.53, -1562.62, -310.952);
  var_2[2] = (-2421.33, -511.182, -396.035);
  var_2[3] = (-2730.36, -1575.76, -335.448);
  var_2[4] = (-1708.77, -846.385, -338.592);
  var_2[5] = (-2413.1, -587.093, -346.973);
  var_2[6] = (-2362.01, -498.633, -402.776);

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = spawn("trigger_radius", var_0[var_3], 0, 32, 64);
    var_4 thread world_fire_damage("s");
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = spawn("trigger_radius", var_1[var_3], 0, 64, 128);
    var_4 thread world_fire_damage("m");
  }

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = spawn("trigger_radius", var_2[var_3], 0, 80, 256);
    var_4 thread world_fire_damage("l");
  }
}

world_fire_damage(var_0) {
  var_1 = 10;

  if(var_0 == "m") {
    var_1 = 25;
  } else if(var_0 == "l") {
    var_1 = 50;
  }

  for(;;) {
    self waittill("trigger");
    level.player dodamage(var_1, self.origin);
    wait 0.5;
  }
}

player_pushing_forward() {
  if(common_scripts\utility::flag("vargas_at_edge")) {
    return 1;
  }

  var_0 = level.player getnormalizedmovement();
  return var_0[0] > 0.1;
}

ssao_logic_post_stream() {
  level.player waittill("start_falling_anim");
  var_0 = 1;

  for(;;) {
    if(maps\jungle_ghosts_util::game_is_ng() && level.player.origin[1] > 977 && level.player.origin[1] < 8939 && !var_0) {
      maps\_art::enable_ssao_over_time(2);
      var_0 = 1;
    } else if(maps\jungle_ghosts_util::game_is_ng() && (level.player.origin[1] <= 977 || level.player.origin[1] >= 8939) && var_0) {
      maps\_art::disable_ssao_over_time(2);
      var_0 = 0;
    }

    wait 1;
  }
}