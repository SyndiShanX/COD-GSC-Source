/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\proxywar\proxywar_vo.gsc
****************************************************/

function proxywar_vo_flags() {
  scripts\engine\utility::flag_init("heli_vo_complete");
  scripts\engine\utility::flag_init("finished_swabbing_vo");
  scripts\engine\utility::flag_init("at_other_vehicle");
  scripts\engine\utility::flag_init("driver_talking");
  scripts\engine\utility::flag_init("done_exit_nag_vo");
}

function vo_fo_heli_complete() {
  wait 13.5;
  say_as_chatter(level, "dx_vom_uscc_heli_approach_infil_20");
  wait 0.5;
  say_as_chatter(level, "dx_vom_uspi1_heli_approach_infil_30");
  scripts\engine\utility::flag_set("heli_vo_complete");
}

function vo_fo_forest_walk() {
  level endon("reached_overlook_patrol");
  level endon("flashlight_nag");
  level endon("overlook_patrol_noise_made");
  scripts\engine\utility::flag_wait("heli_vo_complete");
  wait 1;
  thread vo_fo_turn_off_light();
  waitframe();
  say_as_chatter(level.player, "dx_vom_alx_heli_approach_infil_60");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_trees_hike_10");
  say_as_chatter(level.alpha2, "dx_vom_h72_forest_trees_hike_20");
  wait 2;
  say_as_chatter(level.player, "dx_vom_alx_heli_approach_infil_50");
  say_as_chatter(level.alpha2, "dx_vom_h72_forest_trees_hike_30");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_trees_hike_40");
}

function vo_fo_spot_patrol() {
  level endon("start_check_kill_overlook");
  level endon("alerted_patrol");
  level notify("end_flashlight_trees_check");
  wait 1;
  scripts\engine\sp\utility::player_dialogue_stop();
  level.alpha1 stopsounds();
  level.alpha2 stopsounds();
  waitframe();
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_trees_patrol_10");
  var_0 = getEnt("rus_overlook_patrol_1", "script_noteworthy");
  var_1 = getEnt("rus_overlook_patrol_2", "script_noteworthy");
  say_as_chatter(var_0, "dx_vom_ru1_forest_trees_hike_60");
  say_as_chatter(var_1, "dx_vom_ru2_forest_trees_hike_70");
  say_as_chatter(level.alpha2, "dx_vom_h72_forest_trees_patrol_20");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_trees_patrol_30");

  if(!scripts\engine\utility::flag("alerted_patrol")) {
    say_as_chatter(level.alpha1, "dx_vom_h71_forest_trees_patrol_140");
    wait 0.5;
    say_on_enemy_radio(level, "dx_vom_ru3_forest_trees_patrol_40");
    say_as_chatter(var_0, "dx_vom_ru1_forest_trees_patrol_70");
    say_as_chatter(var_1, "dx_vom_ru2_forest_trees_patrol_80");
    say_as_chatter(var_1, "dx_vom_ru2_forest_trees_patrol_160");
    say_as_chatter(var_1, "dx_vom_ru2_forest_trees_patrol_170");
    return;
  }
}

function vo_fo_turn_off_light() {
  level endon("end_flashlight_trees_check");
  var_0 = 0;

  while(var_0 < 3) {
    if(level.player.flashlighton) {
      level notify("flashlight_nag");

      switch (var_0) {
        case 0:
          thread say_as_chatter(level.alpha1);
          break;
        case 1:
          thread say_as_chatter(level.alpha1);
          break;
        case 2:
          thread say_as_chatter(level.alpha1);
          break;
      }

      var_0++;
      wait 10;
    }

    waitframe();
  }
}

function vo_fo_overlook_kill_patrol(var_0) {
  foreach(var_2 in var_0) {
    var_2 endon("death");
  }

  thread say_as_chatter(level.alpha2, "dx_vom_h72_forest_trees_patrol_150");
  var_4 = lookupsoundlength("dx_vom_h72_forest_trees_patrol_150") / 1000;
  wait var_4 - 0.3;
}

function vo_fo_overlook_player_kill_patrol() {
  wait_combat_cooldown(0.8, 2, 1);

  if(!scripts\engine\utility::flag("overlook_patrol_noise_made")) {
    say_as_chatter(level.player, "dx_vom_alx_forest_trees_patrol_180");
    return;
  }
}

function vo_fo_overlook_killed_patrol() {
  wait_combat_cooldown(0.8, 2, 1);

  if(!scripts\engine\utility::flag("overlook_went_hot") && !scripts\engine\utility::flag("overlook_patrol_noise_made")) {
    say_as_chatter(level.alpha1, "dx_vom_h71_forest_trees_patrol_190");

    if(scripts\engine\utility::flag("reached_overlook")) {
      return;
    }

    say_as_chatter(level.alpha2, "dx_vom_h72_forest_trees_patrol_200");
    return;
  }
}

function vo_fo_overlook_reached_edge() {
  wait 1;
  vo_radio_start();
  say_as_chatter(level.player, "dx_vom_alx_forest_overlook_ridge_10");
  vo_radio_done();
  thread say_as_chatter(level);
  scripts\engine\utility::flag_set("done_overlook_radio_callin");

  if(!scripts\engine\utility::flag("overlook_went_hot") && !scripts\engine\utility::flag("overlook_patrol_noise_made")) {
    thread vo_fo_overlook_scope_enter_chatter();
    return;
  }

  if(scripts\engine\utility::flag("overlook_went_hot") && !scripts\engine\utility::flag("played_go_hot_admonishment")) {
    thread vo_fo_go_hot_admonishment();
    return;
  }
}

function vo_fo_overlook_scope_enter_chatter() {
  level endon("done_aim_look");
  level endon("overlook_went_hot");

  if(!scripts\engine\utility::flag("done_aim_look")) {
    wait 3;
    say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_ridge_40");
    var_0 = ["dx_vom_h71_forest_overlook_ridge_50", "dx_vom_h71_forest_overlook_ridge_60", "dx_vom_h71_forest_overlook_ridge_70", "dx_vom_h71_forest_overlook_ridge_80"];
    nagtill_delayed(level.alpha1, 8, "done_aim_look", var_0, 8, 1.2, 16);
    return;
  }
}

function vo_fo_overlook_scope_around_linger() {
  level endon("done_checkpoint_spot");
  level endon("done_suv_spot");
  level endon("done_suv_patrol_spot");
  level endon("done_railyard_spot");
  level endon("overlook_went_hot");
  wait 10;
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_80");
  wait 10;
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_90");
  wait 10;
  thread say_as_chatter(level);
  wait 10;
  thread say_as_chatter(level);
}

function vo_fo_callout_truck() {
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_10");
  scripts\engine\utility::flag_clear("spotter_actively_tracking");
}

function vo_fo_callout_checkpoint() {
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_ridge_81");
  scripts\engine\utility::flag_clear("spotter_actively_tracking");
}

function vo_fo_checkpoint(var_0) {
  switch (var_0) {
    case "overlook_tower_guard":
      thread say_as_chatter(level.player);
      say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_40");
      break;
    case "overlook_truck":
      say_as_chatter(level.player, "dx_vom_alx_forest_overlook_scout_20");
      say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_60");
      break;
    case "front_gate_guard_right":
    case "front_gate_guard_left":
      say_as_chatter(level.player, "dx_vom_alx_forest_overlook_scout_31");
      say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_40");
      break;
  }
}

function vo_fo_tower_only() {
  thread say_as_chatter(level.player);
}

function vo_fo_callout_railway() {
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_190");
  scripts\engine\utility::flag_clear("spotter_actively_tracking");
}

function vo_fo_railyard() {
  say_as_chatter(level.player, "dx_vom_alx_forest_overlook_scout_141");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_150");
}

function vo_fo_callout_suv() {
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_220");
}

function vo_fo_suv_moving() {
  say_as_chatter(level.player, "dx_vom_alx_forest_overlook_scout_200");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_210");
}

function vo_fo_suv_patrol() {
  say_as_chatter(level.player, "dx_vom_alx_forest_overlook_scout_71");
}

function vo_fo_callin_strike() {
  level endon("overlook_went_hot");
  scripts\engine\utility::flag_set("allow_target_marking");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_300");
  var_0 = ["dx_vom_h71_forest_overlook_scout_320", "dx_vom_h71_forest_overlook_scout_330"];
  thread nagtill_delayed(level.alpha1, 8, "begin_airstrike", var_0, 8, 1.2);
}

function vo_fo_go_hot_admonishment() {
  scripts\engine\utility::flag_set("played_go_hot_admonishment");
  thread mus_overlook_hot();

  if(!scripts\engine\utility::flag("done_facility_scan")) {
    say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_131");
    say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_132");
  }

  scripts\engine\utility::flag_set("admonishment_done");
}

function vo_fo_target_calledin() {
  if(scripts\engine\utility::flag("alpha1_callin_strike")) {
    scripts\engine\utility::flag_set("done_facility_scan");
    scripts\engine\utility::flag_wait("alpha_group_reached_edge");
    say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_331");
    say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_332");
    say_as_chatter(level, "dx_vom_uspi2_forest_overlook_scout_333");
    thread vo_fo_target_hit();
    return;
  }

  if(scripts\engine\utility::flag("overlook_went_hot")) {
    scripts\engine\utility::flag_set("done_facility_scan");

    if(!scripts\engine\utility::flag("played_go_hot_admonishment")) {
      thread vo_fo_go_hot_admonishment();
    }

    scripts\engine\utility::flag_wait("admonishment_done");
    scripts\engine\utility::flag_wait("alpha_group_reached_edge");
    say_as_chatter(level.alpha1, "dx_vom_h71_forest_overlook_scout_133");
    thread vo_fo_target_hit();
    return;
  }

  vo_radio_start();
  say_as_chatter(level.player, "dx_vom_alx_forest_overlook_scout_340");
  vo_radio_done();
  say_as_chatter(level, "dx_vom_uspi2_forest_overlook_scout_350");
  thread say_as_chatter(level.player);
  thread vo_fo_target_hit();
}

function vo_fo_target_hit() {
  wait 5;
  say_as_chatter(level.alpha2, "dx_vom_h72_forest_overlook_scout_370");
}

function vo_fa_post_phosphorus() {
  wait 4;
  scripts\engine\utility::flag_set("start_halligan_open");
  say_as_chatter(level, "dx_vom_uspi2_forest_phosphorus_airstrike_40");
  vo_radio_start();
  say_as_chatter(level.player, "dx_vom_alx_forest_phosphorus_airstrike_50");
  vo_radio_done();
  say_on_enemy_radio(level, "dx_vom_ru3_forest_phosphorus_airstrike_100");
  wait 3;
  wait 2;
  thread say_on_enemy_radio(level);
  scripts\engine\utility::flag_set("phosphorus_vo_done");
}

function vo_increment_nag_counter(var_0) {
  if(!isDefined(level.nag_count) || level.nag_count > var_0) {
    level.nag_count = 0;
    return;
  }

  level.nag_count++;
}

function vo_nag_after_time(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_1) {
    level endon(var_5);
  }

  if(!isDefined(var_3)) {
    var_3 = 15;
  }

  if(istrue(var_2)) {
    [[var_0]]();
  }

  for(;;) {
    wait var_3;
    [[var_0]]();
  }
}

function vo_fp_patrol_incoming(var_0) {
  level endon("player_fired_at_patrol");
  level endon("player_too_close_to_patroller");
  level endon("reached_railyard_entrance");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_phosphorus_contact_50");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_phosphorus_contact_70");
  thread scripts\sp\maps\proxywar\proxywar_util::hint_crouch();
  scripts\engine\utility::flag_wait("start_patrol_anim");
  say_as_chatter(var_0[0], "dx_vom_ru3_forest_patrol_combat_10");
  wait 0.5;
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_phosphorus_contact_80");
  wait 0.5;
  say_as_chatter(var_0[1], "dx_vom_ru4_forest_patrol_combat_50");
  wait 3;
  say_as_chatter(var_0[1], "dx_vom_ru4_forest_patrol_combat_30");
  scripts\engine\utility::flag_set("player_prompted_for_patrol");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_patrol_combat_70");
}

function vo_fp_going_hot() {
  var_0 = ["dx_vom_h72_forest_patrol_combat_80", "dx_vom_h72_forest_patrol_combat_90", "dx_vom_h72_forest_patrol_combat_100", "dx_vom_h72_forest_patrol_combat_110"];
  var_1 = scripts\engine\utility::random(var_0);
  wait 2;
  say_as_chatter(level.alpha2, var_1);
}

function vo_fp_patrol_eliminated() {
  wait_combat_cooldown(0.6, 1.5, 1);
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_patrol_combat_120");
}

function vo_fp_flashlight_nag() {
  level endon("end_flashlight_nag");
  level endon("eliminate_patrol_1");
  var_0 = 0;

  while(!scripts\engine\utility::flag("eliminate_patrol_1")) {
    if(level.player.flashlighton) {
      if(var_0 == 0) {
        say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_sneak_10");
        var_0++;
      } else {
        say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_sneak_20");
        var_0 = 0;
      }

      wait 1;
      var_1 = gettime();

      while(!scripts\engine\utility::time_has_passed(var_1, 10)) {
        if(!level.player.flashlighton) {
          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

function vo_fe_burning_woods() {
  level endon("reached_tower_collapse");
  wait 7;
  say_as_chatter(level.alpha2, "dx_vom_h72_forest_exit_gate_10");
  say_as_chatter(level.bravo2, "dx_vom_h74_forest_exit_gate_20");
}

function vo_re_tower_collapse() {
  level endon("burning_guy_killed");
  wait 2.5;
  thread say_as_chatter(level.bravo1);
  scripts\engine\utility::flag_wait("burning_guy_spawned");
  wait 2;
  say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_aftermath_60");
}

function vo_re_entrance_burner(var_0) {
  scripts\engine\utility::flag_set("burning_guy_spawned");
  var_0 scripts\engine\utility::delaythread(1, &say, "dx_vom_ru1_railyard_entrance_aftermath_70");
  var_0 waittill("death", var_1);
  level notify("burning_guy_killed");
  wait 1.8;

  if(isDefined(var_1) && var_1 == level.player) {
    say_as_chatter(level.player, "dx_vom_alx_railyard_entrance_aftermath_140");
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_aftermath_160");
  }

  wait 1;
  say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_aftermath_180");
}

function vo_re_entrance_fire_damage() {
  level endon("start_combat_intro_scene");
  var_0 = "";

  while(var_0 != "MOD_FIRE") {
    level.player waittill("damage", var_1, var_2, var_3, var_4, var_0);
  }

  wait 0.5;
  say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_aftermath_40");
}

function vo_re_pistol_burner(var_0) {
  wait 6;

  if(isalive(var_0)) {
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_aftermath_210");
    return;
  }
}

function vo_re_crawling_burner(var_0) {
  thread say(var_0);
  wait 1.5;
  say_as_chatter(level.player, "dx_vom_alx_railyard_entrance_aftermath_90");

  if(isalive(var_0)) {
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_aftermath_200");
    return;
  }
}

function vo_rb_reached_breach() {
  var_0 = scripts\engine\utility::getStruct("ap_breach", "targetname");

  while(distance2d(level.player.origin, var_0.origin) > 450 && !scripts\engine\utility::flag("breach_window_view")) {
    waitframe();
  }

  if(!scripts\engine\utility::flag("player_skipped_breach")) {
    if(distance2d(level.player.origin, var_0.origin) > distance2d(level.alpha1.origin, var_0.origin)) {
      say_as_chatter(level.alpha1, "dx_vom_h71_railyard_breach_armory_10");
      return;
    }

    say_as_chatter(level.player, "dx_vom_alx_railyard_breach_armory_120");
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_breach_armory_130");
    return;
  }
}

function vo_rb_ru_breach_guys() {
  var_0 = getEnt("rus_breach_guy_2", "script_noteworthy");
  var_1 = getEnt("rus_breach_guy_1", "script_noteworthy");
  var_0 endon("death");
  var_1 endon("death");
  vo_rb_ru_breach_guys_pre_breach(var_0, var_1);
  wait 1.1;
  var_1 stopsounds();
  say(var_0, "dx_vom_ru1_railyard_breach_armory_190", 1);
}

function vo_rb_ru_breach_guys_pre_breach(var_0, var_1) {
  if(scripts\engine\utility::flag("animated_breach_started")) {
    return;
  }

  level endon("animated_breach_started");
  wait 1;
  wait_for_break_in_chatter();
  say(var_0, "dx_vom_ru1_railyard_entrance_sneak_70");
  say(var_1, "dx_vom_ru2_railyard_entrance_sneak_80");
  wait_for_break_in_chatter();
  say(var_1, "dx_vom_ru2_railyard_breach_armory_40");
  say(var_0, "dx_vom_ru1_railyard_breach_armory_50");
  scripts\engine\utility::flag_wait("animated_breach_started");
}

function vo_rb_breaching() {
  if(scripts\engine\utility::flag("animated_breach_started")) {
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_breach_armory_180");
    return;
  }

  if(scripts\engine\utility::flag("player_fired_at_breach")) {
    say_as_chatter(level.player, "dx_vom_alx_railyard_breach_armory_140");
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_breach_armory_150");
    return;
  }

  if(scripts\engine\utility::flag("breach_door_open")) {
    say_as_chatter(level.player, "dx_vom_alx_railyard_breach_armory_160");
    say_as_chatter(level.alpha2, "dx_vom_h72_railyard_breach_armory_170");
    return;
  }
}

function vo_rci_rus_radio_trans() {
  if(!scripts\engine\utility::flag("animated_breach_started")) {
    wait 2;
  }

  thread say_on_enemy_radio(level, "dx_vom_ru3_railyard_combat_intro_breach_10");
  wait 1.5;
  thread say_as_chatter(level.alpha1);
}

function vo_rci_player_tries_door() {
  say_as_chatter(level.player, "dx_vom_alx_railyard_combat_intro_breach_30");
}

function vo_rci_mg_breach() {
  wait 3.5;
  say_as_chatter(level.alpha1, "dx_vom_h71_railyard_combat_intro_breach_50", 1);
}

function vo_rc_set_mg_suppress_goal() {
  if(!scripts\engine\utility::flag("lmg_suppressed")) {
    say_as_chatter(level.bravo3, "dx_vom_h75_railyard_combat_mg_10");
  }

  if(!scripts\engine\utility::flag("lmg_suppressed")) {
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_combat_mg_20");
  }

  if(!scripts\engine\utility::flag("lmg_suppressed")) {
    thread vo_rc_mount_reminder();
    return;
  }
}

function vo_rc_mount_reminder() {
  level endon("lmg_suppressed");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_h71_railyard_combat_mgsuppress_170");
}

function vo_rc_mg_suppress_reminder() {
  level endon("machine_gunner_killed");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_h71_railyard_combat_mgsuppress_20");
}

function vo_rc_mg_suppressed() {
  var_0 = 0;

  if(!isDefined(level.vo_suppress_count)) {
    wait 0.25;
    var_0 = 1;
    level.vo_suppress_count = 0;
    level.vo_suppress_alias = [];
    level.vo_suppress_alias[level.vo_suppress_alias.size] = "dx_vom_h71_railyard_combat_mg_70";
    level.vo_suppress_alias[level.vo_suppress_alias.size] = "dx_vom_h71_railyard_combat_mgsuppress_70";
    level.vo_suppress_alias[level.vo_suppress_alias.size] = "dx_vom_h71_railyard_combat_mgsuppress_80";
    level.vo_suppress_alias[level.vo_suppress_alias.size] = "dx_vom_h71_railyard_combat_mgsuppress_90";
    level.vo_suppress_alias[level.vo_suppress_alias.size] = "dx_vom_h71_railyard_combat_mg_210";
    level.vo_suppress_alias[level.vo_suppress_alias.size] = "dx_vom_h71_railyard_combat_mg_80";
    level.vo_suppress_alias[level.vo_suppress_alias.size] = "dx_vom_h73_railyard_combat_mg_160";
  } else {
    level.vo_suppress_count += 1;
    level.vo_suppress_count = scripts\engine\utility::mod(level.vo_suppress_count, level.vo_suppress_alias.size);
  }

  if(level.vo_suppress_alias[level.vo_suppress_count] == "dx_vom_h73_railyard_combat_mg_160") {
    say_as_chatter(level.bravo1, level.vo_suppress_alias[level.vo_suppress_count], 1);
  } else {
    say_as_chatter(level.alpha1, level.vo_suppress_alias[level.vo_suppress_count], 1);
  }

  if(var_0) {
    say_as_chatter(level.player, "dx_vom_alx_railyard_combat_mg_30");
    return;
  }
}

function vo_rc_mg_grenade_hint() {
  wait 0.25;

  if(level.player getammocount("frag") < 4) {
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_combat_mg_100", 0, 1);
    return;
  }

  say_as_chatter(level.bravo1, "dx_vom_h73_railyard_combat_mg_170", 0, 1);
}

function vo_rc_set_mg_goal() {
  scripts\engine\utility::flag_wait_any("advance_to_right_traincar", "advance_to_left_platform");
  say_as_chatter(level.bravo1, "dx_vom_h73_railyard_combat_mg_140");
  say_as_chatter(level.alpha1, "dx_vom_h71_railyard_combat_mg_150");
}

function vo_rc_mg_reminder() {
  level endon("advance_to_mg_platform");
  scripts\engine\utility::flag_wait_any("advance_to_right_room_1", "advance_to_left_traincars");
  say_as_chatter(level.bravo1, "dx_vom_h73_railyard_combat_mg_190");
  say_as_chatter(level.alpha1, "dx_vom_h71_railyard_combat_mg_200");
}

function vo_rc_mg_hint() {
  level endon("machine_gunner_killed");
  scripts\engine\utility::flag_wait("advance_to_mg_platform");
  var_0 = 0;

  if(isDefined(level.railyard_lmg)) {
    var_1 = anglestoleft(level.railyard_lmg.og_angles + (0, -45, 0));
    var_2 = level.player.origin - level.railyard_lmg.og_origin;
    var_0 = vectordot(var_1, var_2);
  }

  if(!isDefined(level.railyard_lmg) || var_0 < 0 || level.player getammocount("frag") <= 0) {
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_combat_mg_180");
    return;
  }

  say_as_chatter(level.alpha1, "dx_vom_h71_railyard_combat_mg_90");
}

function vo_rc_mg_defeated() {
  level endon("reached_courtyard_overlook");
  scripts\engine\utility::flag_wait("machine_gunner_killed");
  wait_combat_cooldown(0.8, 2, 1);
  say_as_chatter(level.player, "dx_vom_alx_railyard_combat_mg_220");
  say_as_chatter(level.alpha1, "dx_vom_h71_railyard_combat_mg_230");
}

function vo_cr_enemies_fall_back() {
  var_0 = getEntArray("courtyard_defend_group", "targetname");
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
  var_0 = sortbydistance(var_0, level.player.origin);
  var_1 = var_0[0];
  say(var_1, "dx_vom_ru4_courtyard_retreat_warehouse_10");
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
  var_0 = sortbydistance(var_0, level.player.origin);
  var_2 = var_0[0];

  if(var_2 == var_1) {
    var_2 = var_0[1];
  }

  say(var_2, "dx_vom_ru1_courtyard_retreat_warehouse_20");
  say_as_chatter(level.bravo2, "dx_vom_h74_courtyard_retreat_warehouse_30");
  say_as_chatter(level.bravo3, "dx_vom_h75_courtyard_retreat_warehouse_40");
}

function vo_cr_kill_retreating() {
  level endon("reached_warehouse_foyer");
  scripts\engine\sp\utility::waittill_dead_or_dying(level.courtyarddefendgroup);
  wait_combat_cooldown(0.6, 2, 1);
  scripts\engine\utility::flag_wait("reached_courtyard_mid_4");
  say_as_chatter(level.bravo1, "dx_vom_h73_courtyard_retreat_warehouse_60");
  say_as_chatter(level.player, "dx_vom_alx_courtyard_retreat_warehouse_100");
  say_as_chatter(level.bravo2, "dx_vom_h74_courtyard_retreat_warehouse_110");
}

function vo_we_alpha1_enter_warehouse() {
  say_as_chatter(level.alpha1, "dx_vom_h71_courtyard_retreat_warehouse_70");
}

function vo_we_bravo2_enter_warehouse() {
  say_as_chatter(level.bravo2, "dx_vom_h74_courtyard_retreat_warehouse_80");
}

function vo_we_bravo3_enter_warehouse() {
  say_as_chatter(level.bravo3, "dx_vom_h75_courtyard_retreat_warehouse_90");
}

function vo_we_door_approach() {
  wait 3.5;
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_power_10");
}

function vo_we_nag_enter_warehouse() {
  level endon("done_objective_hint");
  level endon("near_warehouse_door");
  var_0 = ["dx_vom_h71_courtyard_retreat_warehouse_120", "dx_vom_h71_courtyard_retreat_warehouse_130", "dx_vom_h71_courtyard_retreat_warehouse_140"];
  nagtill_delayed(level.alpha1, 8, "near_warehouse_door", var_0, 12);
}

function vo_we_open_door() {
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_power_20");
}

function vo_we_power_off() {
  level endon("reached_warehouse_metal_clang");
  wait 0.35;
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_power_30");
  say_as_chatter(level.player, "dx_vom_alx_warehouse_enter_power_40");
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_power_50");
  wait 1;

  if(scripts\engine\utility::flag("reached_warehouse_interior")) {
    return;
  }

  level endon("reached_warehouse_interior");
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_power_60");
  vo_wc_head_inside_nag(level);
}

function vo_wc_head_inside_nag() {
  var_0 = ["dx_vom_h73_warehouse_enter_power_100", "dx_vom_h73_warehouse_enter_power_110"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_0 = ["dx_vom_h71_warehouse_enter_power_70", "dx_vom_h71_warehouse_enter_power_80", "dx_vom_h71_warehouse_enter_power_90"];
  var_2 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_2.autoshuffle = 1;

  for(;;) {
    nagtill_delayed(level.alpha1, 8, "near_warehouse_door", var_2, 12, 1.2);
    nagtill_open_delayed(level.bravo1, 8, "near_warehouse_door", var_1, 12);
  }
}

function vo_wc_entered_main_warehouse() {
  level endon("reached_warehouse_metal_clang");
  scripts\engine\utility::flag_wait("lights_out");
  say_as_chatter(level.bravo2, "dx_vom_h74_warehouse_enter_power_120");

  if(!level.player.flashlighton) {
    wait 2;
    say_as_chatter(level.bravo2, "dx_vom_h74_warehouse_enter_power_130");
    say_as_chatter(level.player, "dx_vom_alx_warehouse_enter_power_140");
    say_as_chatter(level.bravo1, "dx_vom_h73_warehouse_enter_power_150");
    return;
  }
}

function vo_wc_hear_enemies() {
  level endon("reached_warehouse_first_run");
  scripts\engine\utility::flag_wait("lights_out");
  say_as_chatter(level.bravo2, "dx_vom_h74_warehouse_enter_search_10");
  say_as_chatter(level.bravo1, "dx_vom_h73_warehouse_enter_search_20");
  say_as_chatter(level.bravo2, "dx_vom_h74_warehouse_enter_search_30");
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_search_40");
}

function vo_wc_first_runner() {
  if(scripts\engine\utility::flag("killed_runner1")) {
    return;
  }

  level endon("killed_runner1");
  wait 0.5;
  say_as_chatter(level.bravo2, "dx_vom_h74_warehouse_enter_search_50", 1);
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_search_60");
}

function wait_first_contact() {
  level.player endon("damage");
  level.player endon("bulletwhizby");
  scripts\engine\utility::waittill_any_ents_array(getaiarray("allies"), "damage", "bulletwhizby", "weapon_fired");
}

function vo_wc_first_contact() {
  wait_first_contact();
  var_0 = [];
  GscBinSkip0(0x2e, "alpha1", "dx_vom_h71_warehouse_enter_search_80");
}

function vo_wc_kill_runner1(var_0) {
  var_0 waittill("death");
  wait_combat_cooldown(0.4, 1, 1);
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_search_120");
}

function vo_wc_catwalk_defender() {
  if(!isalive(self)) {
    return;
  }

  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_search_130");
}

function vo_wc_catwalk_defender_moved() {
  if(!isalive(self)) {
    return;
  }

  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_search_140");
}

function vo_wc_shelf_runner() {
  wait 1;
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_search_150");
}

function vo_wc_shelf_runner_killed(var_0) {
  var_0 waittill("death", var_1);
  wait_combat_cooldown(0.4, 1, 1);

  if(var_1 == level.player) {
    say_as_chatter(level.player, "dx_vom_alx_warehouse_enter_search_160");
    return;
  }

  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_search_170");
}

function vo_wc_laststand() {
  wait 2;

  if(scripts\engine\utility::flag("final_defender_killed")) {
    return;
  }

  thread say("dx_vom_ru2_warehouse_enter_search_180");
}

function vo_wc_all_dead() {
  level endon("warehouse_power_on");
  wait_combat_cooldown(0.4, 1, 1);
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_search_210");
  wait 0.6;
  say_as_chatter(level.player, "dx_vom_alx_warehouse_enter_search_220");
  say_as_chatter(level.player, "dx_vom_alx_warehouse_enter_search_230");
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_search_240");
  say_as_chatter(level.bravo1, "dx_vom_h73_warehouse_enter_search_250");
  say_as_chatter(level.bravo3, "dx_vom_h75_warehouse_enter_search_260");

  if(!scripts\engine\utility::flag("warehouse_power_on")) {
    thread vo_wdg_nag_find_power();
  }

  scripts\engine\utility::flag_set("find_power_vo_done");
}

function vo_wdg_nag_find_power() {
  level endon("warehouse_power_on");
  wait 2;
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_search_270");
  wait 10;
  say_as_chatter(level.bravo2, "dx_vom_h73_warehouse_enter_search_300");
  wait 12;
  say_as_chatter(level.bravo2, "dx_vom_h73_warehouse_enter_search_290");
  wait 12;
  say_as_chatter(level.bravo3, "dx_vom_h75_warehouse_enter_search_330");
  say_as_chatter(level.bravo2, "dx_vom_h74_warehouse_enter_search_340");
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_enter_search_350");
  wait 10;
  say_as_chatter(level.bravo1, "dx_vom_h73_warehouse_enter_search_280");
  wait 14;
  say_as_chatter(level.bravo2, "dx_vom_h73_warehouse_enter_search_310");
}

function vo_wdg_tried_door_button() {
  wait 2;
  say_as_chatter(level.player, "dx_vom_alx_warehouse_discover_gas_russians_10");
}

function vo_wdg_found_button() {
  say_as_chatter(level.player, "dx_vom_alx_warehouse_discover_gas_russians_20", 1);
  wait 2;
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_discover_gas_russians_30");
}

function vo_wdg_discover_russians_callout() {
  wait 1;
  say_as_chatter(level.bravo1, "dx_vom_h73_warehouse_discover_gas_russians_40");
  say_as_chatter(level.bravo1, "dx_vom_h73_warehouse_discover_gas_russians_50");
  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_discover_gas_russians_60");
  vo_radio_start();
  say_as_chatter(level.player, "dx_vom_alx_warehouse_discover_gas_russians_70");
  vo_radio_done();
  thread say_as_chatter(level);
  wait 4;

  if(!scripts\engine\utility::flag("started_swabbing")) {
    vo_radio_start();
    level.player playsoundatviewheight("dx_vom_alx_warehouse_discover_gas_russians_90");
    wait lookupsoundlength("dx_vom_alx_warehouse_discover_gas_russians_90") / 1000;
    vo_radio_done();
  }

  say_as_chatter(level.alpha1, "dx_vom_h71_warehouse_discover_gas_russians_110");

  if(!scripts\engine\utility::flag("started_swabbing")) {
    say_as_chatter(level.player, "dx_vom_alx_warehouse_discover_gas_russians_120");
    thread vo_wdg_approach_gas_truck();
    return;
  }
}

function vo_wdg_approach_gas_truck() {
  if(scripts\engine\utility::flag("started_swabbing")) {
    return;
  }

  level endon("started_swabbing");
  var_0 = ["dx_vom_h71_trucks_convoy_gas_10", "dx_vom_h71_trucks_convoy_gas_20", "dx_vom_h71_trucks_convoy_gas_30"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  wait 5;

  for(;;) {
    level.discovergasref waittill("end_discover_idle");
    wait 3.5;
    thread say_as_chatter(level.alpha1);
  }
}

function vo_wdg_found_gas() {
  scripts\engine\utility::flag_wait("finished_swabbing");
  thread say_as_chatter(level);
  wait 2.5;
  vo_radio_start();
  thread say_as_chatter(level.player);
  wait 1.5;
  vo_radio_done();
  scripts\engine\utility::flag_set("finished_swabbing_vo");
}

function vo_wdg_nag_exit() {
  if(!scripts\engine\utility::flag("done_exit_nag_vo")) {
    scripts\engine\utility::flag_set("done_exit_nag_vo");
    say_as_chatter(level.alpha1, "dx_vom_h71_trucks_convoy_exfil_10");
    return;
  }
}

function vo_ts_call_shotgun() {
  scripts\engine\utility::flag_wait("finished_swabbing_vo");
  say_as_chatter(level.bravo2, "dx_vom_h74_trucks_convoy_exfil_20");
  thread vo_ts_wrong_vehicle();

  if(!scripts\engine\utility::flag("player_entered_truck")) {
    thread vo_ts_shotgun_nag();
    return;
  }
}

function vo_ts_shotgun_nag() {
  level endon("player_entered_truck");
  wait 10;
  scripts\engine\utility::flag_waitopen("driver_talking");
  scripts\engine\utility::flag_set("driver_talking");
  say_as_chatter(level.bravo2, "dx_vom_h74_trucks_convoy_exfil_30");
  scripts\engine\utility::flag_clear("driver_talking");
  wait 12;
  scripts\engine\utility::flag_waitopen("driver_talking");
  scripts\engine\utility::flag_set("driver_talking");
  say_as_chatter(level.bravo2, "dx_vom_h74_trucks_convoy_exfil_40");
  scripts\engine\utility::flag_clear("driver_talking");
}

function vo_ts_wrong_vehicle() {
  level endon("player_entered_truck");
  var_0 = 1;

  while(var_0) {
    scripts\engine\utility::flag_wait("at_other_vehicle");

    if(!scripts\engine\utility::flag("driver_talking")) {
      scripts\engine\utility::flag_set("driver_talking");
      say_as_chatter(level.bravo1, "dx_vom_h73_trucks_convoy_exfil_50");
      scripts\engine\utility::flag_clear("driver_talking");
      var_0 = 0;
    }

    waitframe();
  }
}

function vo_radio_start() {
  while(level.player isswitchingweapon()) {
    waitframe();
  }

  level.player scripts\common\utility::allow_offhand_weapons(0, "radio");
  level.player scripts\common\utility::allow_melee(0, "radio");
  level.player scripts\common\utility::allow_sprint(0, "radio");
  level.player scripts\common\utility::allow_weapon_switch(0, "radio");
  level.player scripts\common\utility::allow_weapon_pickup(0, "radio");
  level.player scripts\common\utility::allow_ads(0, "radio");
  level.player scripts\common\utility::allow_mount_side(0, "radio");
  level.player scripts\common\utility::allow_mount_top(0, "radio");
  level.player scripts\common\utility::allow_fire(0, "radio");
  level.player scripts\common\utility::allow_reload(0, "radio");
  level.player forceplaygestureviewmodel("iw8_vm_ges_radio_shoulder_sp");
  wait 0.75;
}

function vo_radio_done() {
  level.player stopgestureviewmodel("iw8_vm_ges_radio_shoulder_sp");
  level.player scripts\common\utility::allow_offhand_weapons(1, "radio");
  level.player scripts\common\utility::allow_melee(1, "radio");
  level.player scripts\common\utility::allow_sprint(1, "radio");
  level.player scripts\common\utility::allow_weapon_switch(1, "radio");
  level.player scripts\common\utility::allow_weapon_pickup(1, "radio");
  level.player scripts\common\utility::allow_ads(1, "radio");
  level.player scripts\common\utility::allow_mount_side(1, "radio");
  level.player scripts\common\utility::allow_mount_top(1, "radio");
  level.player scripts\common\utility::allow_fire(1, "radio");
  level.player scripts\common\utility::allow_reload(1, "radio");
}

function say(var_0, var_1, var_2) {
  if(!soundexists(var_0)) {
    return false;
  }

  if(is_dead_or_dying(self)) {
    return false;
  }

  self notify("started_speaking", var_0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var_0;

  if(isPlayer(self) && isDefined(var_2)) {
    scripts\engine\sp\utility::player_gesture_force(var_2);
    var_3 = lookupsoundlength(var_0) / 1000;
    scripts\engine\utility::delaycall(var_3, &stopgestureviewmodel);
  }

  if(istrue(var_1)) {
    if(isstruct(self)) {
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var_0);
    } else if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var_0);
    } else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var_0);
    } else {
      if(issentient(self)) {
        self playsoundatviewheight(var_0);
      } else {
        self playSound(var_0);
      }

      wait lookupsoundlength(var_0) / 1000;
    }
  } else if(isstruct(self)) {
    scripts\engine\sp\utility::smart_radio_dialogue(var_0);
  } else if(isPlayer(self)) {
    scripts\engine\sp\utility::smart_player_dialogue(var_0);
  } else if(isDefined(self.animname)) {
    scripts\engine\sp\utility::smart_dialogue(var_0);
  } else {
    if(issentient(self)) {
      self playsoundatviewheight(var_0);
    } else {
      self playSound(var_0);
    }

    wait lookupsoundlength(var_0) / 1000;
  }

  self notify("finished_speaking", var_0);
  return true;
}

function is_dead_or_dying(var_0) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(isai(var_0)) {
    return (!isalive(var_0) || var_0 scripts\engine\utility::doinglongdeath());
  } else if(issentient(var_0)) {
    return !isalive(var_0);
  }

  return false;
}

function is_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return 0;
  }

  return scripts\engine\utility::time_has_passed(self.lastspoketime, lookupsoundlength(self.lastaliassaid) / 1000);
}

function wait_finish_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return false;
  }

  var_0 = (gettime() - self.lastspoketime) / 1000;
  var_1 = lookupsoundlength(self.lastaliassaid) / 1000;

  if(var_0 < var_1) {
    wait var_1 - var_0;
  }

  return true;
}

function time_since_spoke() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return undefined;
  }

  var_0 = self.lastspoketime + lookupsoundlength(self.lastaliassaid);
  return (gettime() - var_0) / 1000;
}

function say_sequence(var_0, var_1) {
  var_2 = self;

  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  foreach(var_4 in var_0) {
    var_2 = say_vo_item(var_2, var_4, var_1);
  }
}

function say_vo_item(var_0, var_1) {
  var_2 = self;

  if(isarray(var_0)) {
    if((isint(var_0[0]) || isfloat(var_0[0])) && isint(var_0[1]) || isfloat(var_0[1])) {
      wait randomfloatrange(var_0[0], var_0[1]);
    } else if(isbuiltinfunction(var_0[0]) || isbuiltinmethod(var_0[0]) || isanimation(var_0[0])) {
      call_with_params(var_2, var_0[0], var_0[1]);
    }

    return var_2;
  }

  if(isent(var_0) || isstruct(var_0)) {
    var_2 = var_0;
  } else if(isstring(var_0)) {
    say(var_2, var_0, var_1);
  } else if(isint(var_0) || isfloat(var_0)) {
    wait var_0;
  } else if(isbuiltinfunction(var_0) || isbuiltinmethod(var_0) || isanimation(var_0)) {
    call_with_params(var_2, var_0);
  } else if(scripts\engine\sp\utility::is_deck(var_0)) {
    var_2 = say_vo_item(var_2, var_0 scripts\engine\sp\utility::deck_draw(), var_1);
  }

  return var_2;
}

function init_chatter() {
  level.vo_chatter = spawnStruct();
  level.vo_chatter.speaking = 0;
  level.vo_chatter.waiting = [];
}

function terminate_chatter() {
  level.vo_chatter notify("terminate_chatter");
  level.vo_chatter = undefined;
}

function say_as_chatter(var_0, var_1, var_2) {
  return do_as_chatter(&say, [var_0, var_1], var_1, var_2);
}

function say_as_chatter_with_gesture(var_0, var_1, var_2, var_3) {
  return do_as_chatter(&say, [var_1, var_2, var_0], var_2, var_3);
}

function say_sequence_as_chatter(var_0, var_1, var_2) {
  return do_as_chatter(&say_sequence, [var_0], var_1, var_2);
}

function wait_for_break_in_chatter(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;

  if(!isDefined(level.vo_chatter) || !level.vo_chatter.speaking) {
    return 1;
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var_1);

  if(isDefined(var_0) && isstring(var_0)) {
    var_2 = scripts\engine\utility::waittill_any_ents_return(var_1, "proceed", self, var_0, level, var_0) == var_0;
  } else if(isDefined(var_0)) {
    var_2 = var_1 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var_0) == "timeout";
  } else {
    var_1 waittill("proceed");
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var_1);
  return var_2;
}

function do_as_chatter(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vo_chatter)) {
    thread init_chatter();
  }

  level.vo_chatter endon("terminate_chatter");
  var_4 = spawnStruct();
  thread do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4);
  var_4 waittill("done", var_5);
  return var_5;
}

function do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4) {
  level.vo_chatter endon("terminate_chatter");

  if(level.vo_chatter.speaking && (!istrue(var_2) || isDefined(var_3))) {
    var_5 = wait_for_break_in_chatter(var_3);
  } else {
    var_5 = 0;
  }

  var_6 = undefined;

  if(!level.vo_chatter.speaking || !var_5 || istrue(var_3)) {
    level.vo_chatter notify("started_speaking", self, var_1, var_2);
    level.vo_chatter.speaking++;
    var_6 = call_with_params(var_1, var_2);
    level.vo_chatter.speaking--;
    level.vo_chatter notify("done_speaking", self, var_1, var_2);
  }

  if(!level.vo_chatter.speaking && isDefined(level.vo_chatter.waiting[0])) {
    level.vo_chatter.waiting[0] notify("proceed");
  }

  var_5 notify("done", var_6);
}

function call_with_params(var_0, var_1) {
  if(isbuiltinfunction(var_0)) {
    return call_with_params_script(var_0, var_1);
  }

  if(isbuiltinmethod(var_0) || isanimation(var_0)) {
    return call_with_params_builtin(var_0, var_1);
  }
}

function call_with_params_script(var_0, var_1) {
  if(!isDefined(var_1)) {
    return self[[var_0]]();
  }

  if(!isarray(var_1)) {
    return self[[var_0]](var_1);
  }

  switch (var_1.size) {
    case 0:
      return self[[var_0]]();
    case 1:
      return self[[var_0]](var_1[0]);
    case 2:
      return self[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

function call_with_params_builtin(var_0, var_1) {
  if(!isDefined(var_1)) {
    return self[[var_0]]();
  }

  if(!isarray(var_1)) {
    return self builtin[[var_0]](var_1);
  }

  switch (var_1.size) {
    case 0:
      return self builtin[[var_0]]();
    case 1:
      return self builtin[[var_0]](var_1[0]);
    case 2:
      return self builtin[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

function nagtill_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9 endon("stop");
  var_9 scripts\engine\utility::delaythread(var_0, &scripts\engine\utility::send_notify, "stop");
  nagtill(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

function nagtill_delayed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    if(!isarray(var_1)) {
      var_1 = [var_1];
    }

    foreach(var_11 in var_1) {
      var_12 = scripts\engine\utility::flag_exist(var_11) && scripts\engine\utility::ter_op(istrue(var_9), !scripts\engine\utility::flag(var_11), scripts\engine\utility::flag(var_11));

      if(var_12) {
        return;
      }

      level endon(var_11);
      self endon(var_11);
    }
  }

  wait var_0;
  nagtill(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

function nagtill_open_delayed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_1)) {
    if(!isarray(var_1)) {
      var_1 = [var_1];
    }

    foreach(var_10 in var_1) {
      if(scripts\engine\utility::flag_exist(var_10) && !scripts\engine\utility::flag(var_10)) {
        return;
      }

      level endon(var_10);
      self endon(var_10);
    }
  }

  wait var_0;
  return nagtill(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1);
}

function nagtill_open(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

function nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_2 = default_if_undefined(var_2, 3);
  var_3 = default_if_undefined(var_3, 1.5);
  var_4 = default_if_undefined(var_4, 25);
  var_5 = default_if_undefined(var_5, var_2 / 4);
  var_6 = default_if_undefined(var_6, var_3);
  var_7 = default_if_undefined(var_7, var_4 / 4);
  var_9 = var_4 > var_2;
  var_10 = var_7 > var_5;

  if(isDefined(var_0)) {
    if(!isarray(var_0)) {
      var_0 = [var_0];
    }

    foreach(var_12 in var_0) {
      var_13 = scripts\engine\utility::flag_exist(var_12) && scripts\engine\utility::ter_op(istrue(var_8), !scripts\engine\utility::flag(var_12), scripts\engine\utility::flag(var_12));

      if(var_13) {
        return;
      }

      level endon(var_12);
      self endon(var_12);
    }
  }

  jumpiffalse(isarray(var_1)) LOC_000000dc;
  var_1 = scripts\engine\sp\utility::create_deck(var_1, 0);
  var_1.autoshuffle = 1;

  for(;;) {
    var_15 = self;
    var_16 = var_1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var_16)) {
      var_15 = var_16[0];
      var_16 = var_16[1];
    }

    thread notify_started_nag(var_15);
    say_as_chatter(var_15, var_16);
    level notify("said_nag", var_15, var_16);
    wait randomfloatrange(var_2 - var_5, var_2 + var_5);

    if(var_9) {
      var_2 = min(var_2 * var_3, var_4);
    } else {
      var_2 = max(var_2 * var_3, var_4);
    }

    if(var_10) {
      var_5 = min(var_5 * var_6, var_7);
    } else {
      var_5 = max(var_5 * var_6, var_7);
    }

    if(var_1 scripts\engine\sp\utility::deck_is_empty()) {
      array_deck_shuffle(var_1);
    }
  }
}

function notify_started_nag(var_0) {
  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }

  self waittillmatch("started_speaking", var_0);
  level notify("started_nag", self, var_0);
}

function compare(var_0, var_1) {
  if(isarray(var_0)) {
    if(isarray(var_1)) {
      return compare_arrays(var_0, var_1);
    }

    return 0;
  }

  if(isarray(var_1)) {
    return 0;
  }

  return var_0 == var_1;
}

function compare_arrays(var_0, var_1) {
  if(var_0.size != var_1.size) {
    return false;
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_1[var_5])) {
      return false;
    }

    var_4 = var_1[var_5];

    if(compare(var_4, var_3)) {
      return false;
    }
  }

  return true;
}

function array_deck_shuffle() {
  var_0 = self;
  var_0.index = 0;
  var_0.items = scripts\engine\utility::array_randomize(var_0.items);

  if(!var_0.prevent_redraw || !isDefined(var_0.last_drawn) || var_0.items.size <= 1) {
    return;
  }

  var_1 = compare(var_0.items[0], var_0.last_drawn);

  if(var_1) {
    var_2 = randomintrange(1, var_0.items.size);
    var_3 = var_0.items[0];
    var_0.items[0] = var_0.items[var_2];
    var_0.items[var_2] = var_3;
    return;
  }
}

function default_if_undefined(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = var_1;
  }

  return var_0;
}

function wait_combat_cooldown(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    wait var_0;
  }

  while(!isDefined(var_1) || var_1 > 0) {
    if(!recently_in_combat(var_0)) {
      return false;
    }

    waitframe();

    if(isDefined(var_1)) {
      var_1 -= 0.05;
    }
  }

  return true;
}

function recently_in_combat(var_0) {
  var_1 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var_0);
  var_2 = isDefined(level.player.last_damaged_time) && !scripts\engine\utility::time_has_passed(level.player.last_damaged_time, var_0);
  return level.player isfiring() || var_1 || var_2;
}

function track_player_combat_time() {
  level.player endon("death");

  for(;;) {
    var_0 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "damage") == "weapon_fired";

    if(var_0) {
      level.player.last_weapon_fire_time = gettime();
      continue;
    }

    level.player.last_damaged_time = gettime();
  }
}

function wait_lookat_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return wait_lookat(var_0, var_1, var_3, var_4, var_5, var_6, var_2, 1);
}

function wait_lookat_ads_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return wait_lookat_ads(var_0, var_1, var_3, var_4, var_5, var_6, var_2);
}

function wait_lookat_ads(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!istrue(var_5)) {
    var_5 = 0;
  }

  return wait_lookat(var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1);
}

function wait_lookaway(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return wait_lookat(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

function wait_lookat(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_3)) {
    var_3 *= 1000;
  } else {
    var_3 = 0;
  }

  var_9 = undefined;

  while(!isDefined(var_9) || gettime() - var_9 <= var_3) {
    if(!isDefined(var_0)) {
      return;
    }

    if(isDefined(var_4)) {
      wait_near(level.player, var_0, var_4);
    }

    var_10 = is_looking_at(var_0, var_1, var_2, var_5);

    if(var_8) {
      var_10 = !var_10;
    }

    if(istrue(var_7)) {
      var_10 = var_10 && level.player scripts\engine\sp\utility::isads();
    }

    if(var_10 && !isDefined(var_9)) {
      var_9 = gettime();
    } else if(!var_10) {
      var_9 = undefined;
    }

    if(var_10 && (!isDefined(var_3) || var_3 == 0)) {
      break;
    }

    waitframe();

    if(isDefined(var_6)) {
      var_6 -= 0.05;

      if(var_6 <= 0) {
        return 0;
      }
    }
  }

  return 1;
}

function is_looking_at(var_0, var_1, var_2, var_3) {
  if(isent(var_0) && isDefined(var_2)) {
    var_4 = var_0 gettagorigin(var_2);
  } else if((isent(var_1) || isstruct(var_1)) && isDefined(var_1.origin)) {
    var_4 = var_1.origin;
  } else {
    var_4 = var_2;
  }

  var_5 = level.player worldpointtoscreenpos(var_4, getdvarint("MRNKTKLLKP"));

  if(!isDefined(var_5)) {
    return 0;
  }

  if(isDefined(var_3) && length2d(var_5) > var_3) {
    return 0;
  }

  if(!isDefined(var_4) || var_4) {
    jumpiffalse(isent(var_2)) LOC_00000098;
    var_6 = [level.player, var_2];
    goto LOC_000000a3;
  } else {
    var_7 = 1;
  }

  return var_7;
}

function wait_near(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = var_0;

  for(;;) {
    if(isent(var_0)) {
      var_3 = var_0.origin;
    }

    if(distance2dsquared(self.origin, var_3) < var_2) {
      break;
    }

    waitframe();
  }
}

function say_on_enemy_radio(var_0, var_1, var_2) {
  var_3 = 0;

  if(!istrue(var_1) || isDefined(var_2)) {
    var_3 = wait_for_break_in_chatter(var_2);
  }

  if(isDefined(var_1) && !var_1 && var_3) {
    return;
  }

  var_4 = getcorpsearrayinradius(level.player.origin, 1000);
  var_5 = scripts\engine\utility::array_combine(var_4, getaiarrayinradius(level.player.origin, 1000, "axis"));

  if(var_5.size == 0) {
    return;
  }

  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in var_5) {
    if(getsubstr(var_9.classname, 0, 11) != "actor_enemy") {
      continue;
    }

    var_10 = distance2dsquared(level.player.origin, var_9 gettagorigin("j_chest"));

    if(!isDefined(var_7) || var_10 < var_7) {
      var_6 = var_9;
      var_7 = var_10;
    }
  }

  if(!isDefined(var_6)) {
    return;
  }

  var_12 = var_6 gettagorigin("j_chest");
  var_13 = var_6 gettagangles("j_chest");
  var_14 = scripts\engine\utility::spawn_script_origin(var_12, var_13);
  var_14 linkTo(var_6, "j_chest");
  say(var_14, var_0, 1);
}

function mus_forest_overlook() {
  scripts\engine\utility::flag_wait("reached_overlook_patrol");
  setmusicstate("mus_proxy_dark_infil");
  wait 10;
  scripts\engine\utility::flag_wait("called_in_strike");
  setmusicstate("");
}

function mus_overlook_hot() {
  setmusicstate("");
}

function mus_railyard_combat() {
  scripts\engine\utility::flag_wait("start_combat_intro_scene");
  wait 8;
  setmusicstate("mus_proxy_yard_battle");
}

function mus_courtyard_endmusic() {
  scripts\engine\utility::flag_wait("started_courtyard_breach");
  setmusicstate("");
}

function mus_lightsout() {
  setmusicstate("mus_proxy_lightsout");
}

function mus_discover_russians() {
  setmusicstate("");
}

function mus_hadir_discover() {
  wait 2;
  setmusicstate("mus_proxy_hadir");
  wait 61;
  setmusicstate("");
}

function mus_truck_leave() {
  setmusicstate("mus_proxy_truck_leave");
}