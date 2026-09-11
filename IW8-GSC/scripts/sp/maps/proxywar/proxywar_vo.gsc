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
  var0 = getEnt("rus_overlook_patrol_1", "script_noteworthy");
  var1 = getEnt("rus_overlook_patrol_2", "script_noteworthy");
  say_as_chatter(var0, "dx_vom_ru1_forest_trees_hike_60");
  say_as_chatter(var1, "dx_vom_ru2_forest_trees_hike_70");
  say_as_chatter(level.alpha2, "dx_vom_h72_forest_trees_patrol_20");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_trees_patrol_30");

  if(!scripts\engine\utility::flag("alerted_patrol")) {
    say_as_chatter(level.alpha1, "dx_vom_h71_forest_trees_patrol_140");
    wait 0.5;
    say_on_enemy_radio(level, "dx_vom_ru3_forest_trees_patrol_40");
    say_as_chatter(var0, "dx_vom_ru1_forest_trees_patrol_70");
    say_as_chatter(var1, "dx_vom_ru2_forest_trees_patrol_80");
    say_as_chatter(var1, "dx_vom_ru2_forest_trees_patrol_160");
    say_as_chatter(var1, "dx_vom_ru2_forest_trees_patrol_170");
    return;
  }
}

function vo_fo_turn_off_light() {
  level endon("end_flashlight_trees_check");
  var0 = 0;

  while(var0 < 3) {
    if(level.player.flashlighton) {
      level notify("flashlight_nag");

      switch (var0) {
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

      var0++;
      wait 10;
    }

    waitframe();
  }
}

function vo_fo_overlook_kill_patrol(var0) {
  foreach(var2 in var0) {
    var2 endon("death");
  }

  thread say_as_chatter(level.alpha2, "dx_vom_h72_forest_trees_patrol_150");
  var4 = lookupsoundlength("dx_vom_h72_forest_trees_patrol_150") / 1000;
  wait var4 - 0.3;
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
    var0 = ["dx_vom_h71_forest_overlook_ridge_50", "dx_vom_h71_forest_overlook_ridge_60", "dx_vom_h71_forest_overlook_ridge_70", "dx_vom_h71_forest_overlook_ridge_80"];
    nagtill_delayed(level.alpha1, 8, "done_aim_look", var0, 8, 1.2, 16);
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

function vo_fo_checkpoint(var0) {
  switch (var0) {
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
  var0 = ["dx_vom_h71_forest_overlook_scout_320", "dx_vom_h71_forest_overlook_scout_330"];
  thread nagtill_delayed(level.alpha1, 8, "begin_airstrike", var0, 8, 1.2);
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

function vo_increment_nag_counter(var0) {
  if(!isDefined(level.nag_count) || level.nag_count > var0) {
    level.nag_count = 0;
    return;
  }

  level.nag_count++;
}

function vo_nag_after_time(var0, var1, var2, var3) {
  foreach(var5 in var1) {
    level endon(var5);
  }

  if(!isDefined(var3)) {
    var3 = 15;
  }

  if(istrue(var2)) {
    [[var0]]();
  }

  for(;;) {
    wait var3;
    [[var0]]();
  }
}

function vo_fp_patrol_incoming(var0) {
  level endon("player_fired_at_patrol");
  level endon("player_too_close_to_patroller");
  level endon("reached_railyard_entrance");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_phosphorus_contact_50");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_phosphorus_contact_70");
  thread scripts\sp\maps\proxywar\proxywar_util::hint_crouch();
  scripts\engine\utility::flag_wait("start_patrol_anim");
  say_as_chatter(var0[0], "dx_vom_ru3_forest_patrol_combat_10");
  wait 0.5;
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_phosphorus_contact_80");
  wait 0.5;
  say_as_chatter(var0[1], "dx_vom_ru4_forest_patrol_combat_50");
  wait 3;
  say_as_chatter(var0[1], "dx_vom_ru4_forest_patrol_combat_30");
  scripts\engine\utility::flag_set("player_prompted_for_patrol");
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_patrol_combat_70");
}

function vo_fp_going_hot() {
  var0 = ["dx_vom_h72_forest_patrol_combat_80", "dx_vom_h72_forest_patrol_combat_90", "dx_vom_h72_forest_patrol_combat_100", "dx_vom_h72_forest_patrol_combat_110"];
  var1 = scripts\engine\utility::random(var0);
  wait 2;
  say_as_chatter(level.alpha2, var1);
}

function vo_fp_patrol_eliminated() {
  wait_combat_cooldown(0.6, 1.5, 1);
  say_as_chatter(level.alpha1, "dx_vom_h71_forest_patrol_combat_120");
}

function vo_fp_flashlight_nag() {
  level endon("end_flashlight_nag");
  level endon("eliminate_patrol_1");
  var0 = 0;

  while(!scripts\engine\utility::flag("eliminate_patrol_1")) {
    if(level.player.flashlighton) {
      if(var0 == 0) {
        say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_sneak_10");
        var0++;
      } else {
        say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_sneak_20");
        var0 = 0;
      }

      wait 1;
      var1 = gettime();

      while(!scripts\engine\utility::time_has_passed(var1, 10)) {
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

function vo_re_entrance_burner(var0) {
  scripts\engine\utility::flag_set("burning_guy_spawned");
  var0 scripts\engine\utility::delaythread(1, &say, "dx_vom_ru1_railyard_entrance_aftermath_70");
  var0 waittill("death", var1);
  level notify("burning_guy_killed");
  wait 1.8;

  if(isDefined(var1) && var1 == level.player) {
    say_as_chatter(level.player, "dx_vom_alx_railyard_entrance_aftermath_140");
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_aftermath_160");
  }

  wait 1;
  say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_aftermath_180");
}

function vo_re_entrance_fire_damage() {
  level endon("start_combat_intro_scene");
  var0 = "";

  while(var0 != "MOD_FIRE") {
    level.player waittill("damage", var1, var2, var3, var4, var0);
  }

  wait 0.5;
  say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_aftermath_40");
}

function vo_re_pistol_burner(var0) {
  wait 6;

  if(isalive(var0)) {
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_aftermath_210");
    return;
  }
}

function vo_re_crawling_burner(var0) {
  thread say(var0);
  wait 1.5;
  say_as_chatter(level.player, "dx_vom_alx_railyard_entrance_aftermath_90");

  if(isalive(var0)) {
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_entrance_aftermath_200");
    return;
  }
}

function vo_rb_reached_breach() {
  var0 = scripts\engine\utility::getStruct("ap_breach", "targetname");

  while(distance2d(level.player.origin, var0.origin) > 450 && !scripts\engine\utility::flag("breach_window_view")) {
    waitframe();
  }

  if(!scripts\engine\utility::flag("player_skipped_breach")) {
    if(distance2d(level.player.origin, var0.origin) > distance2d(level.alpha1.origin, var0.origin)) {
      say_as_chatter(level.alpha1, "dx_vom_h71_railyard_breach_armory_10");
      return;
    }

    say_as_chatter(level.player, "dx_vom_alx_railyard_breach_armory_120");
    say_as_chatter(level.alpha1, "dx_vom_h71_railyard_breach_armory_130");
    return;
  }
}

function vo_rb_ru_breach_guys() {
  var0 = getEnt("rus_breach_guy_2", "script_noteworthy");
  var1 = getEnt("rus_breach_guy_1", "script_noteworthy");
  var0 endon("death");
  var1 endon("death");
  vo_rb_ru_breach_guys_pre_breach(var0, var1);
  wait 1.1;
  var1 stopsounds();
  say(var0, "dx_vom_ru1_railyard_breach_armory_190", 1);
}

function vo_rb_ru_breach_guys_pre_breach(var0, var1) {
  if(scripts\engine\utility::flag("animated_breach_started")) {
    return;
  }

  level endon("animated_breach_started");
  wait 1;
  wait_for_break_in_chatter();
  say(var0, "dx_vom_ru1_railyard_entrance_sneak_70");
  say(var1, "dx_vom_ru2_railyard_entrance_sneak_80");
  wait_for_break_in_chatter();
  say(var1, "dx_vom_ru2_railyard_breach_armory_40");
  say(var0, "dx_vom_ru1_railyard_breach_armory_50");
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
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_h71_railyard_combat_mgsuppress_170");
}

function vo_rc_mg_suppress_reminder() {
  level endon("machine_gunner_killed");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_h71_railyard_combat_mgsuppress_20");
}

function vo_rc_mg_suppressed() {
  var0 = 0;

  if(!isDefined(level.vo_suppress_count)) {
    wait 0.25;
    var0 = 1;
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

  if(var0) {
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
  var0 = 0;

  if(isDefined(level.railyard_lmg)) {
    var1 = anglestoleft(level.railyard_lmg.og_angles + (0, -45, 0));
    var2 = level.player.origin - level.railyard_lmg.og_origin;
    var0 = vectordot(var1, var2);
  }

  if(!isDefined(level.railyard_lmg) || var0 < 0 || level.player getammocount("frag") <= 0) {
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
  var0 = getEntArray("courtyard_defend_group", "targetname");
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);
  var0 = sortbydistance(var0, level.player.origin);
  var1 = var0[0];
  say(var1, "dx_vom_ru4_courtyard_retreat_warehouse_10");
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);
  var0 = sortbydistance(var0, level.player.origin);
  var2 = var0[0];

  if(var2 == var1) {
    var2 = var0[1];
  }

  say(var2, "dx_vom_ru1_courtyard_retreat_warehouse_20");
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
  var0 = ["dx_vom_h71_courtyard_retreat_warehouse_120", "dx_vom_h71_courtyard_retreat_warehouse_130", "dx_vom_h71_courtyard_retreat_warehouse_140"];
  nagtill_delayed(level.alpha1, 8, "near_warehouse_door", var0, 12);
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
  var0 = ["dx_vom_h73_warehouse_enter_power_100", "dx_vom_h73_warehouse_enter_power_110"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);
  var0 = ["dx_vom_h71_warehouse_enter_power_70", "dx_vom_h71_warehouse_enter_power_80", "dx_vom_h71_warehouse_enter_power_90"];
  var2 = scripts\engine\sp\utility::create_deck(var0, 0);
  var2.autoshuffle = 1;

  for(;;) {
    nagtill_delayed(level.alpha1, 8, "near_warehouse_door", var2, 12, 1.2);
    nagtill_open_delayed(level.bravo1, 8, "near_warehouse_door", var1, 12);
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
  var0 = [];
  GscBinSkip0(0x2e, "alpha1", "dx_vom_h71_warehouse_enter_search_80");
}

function vo_wc_kill_runner1(var0) {
  var0 waittill("death");
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

function vo_wc_shelf_runner_killed(var0) {
  var0 waittill("death", var1);
  wait_combat_cooldown(0.4, 1, 1);

  if(var1 == level.player) {
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
  var0 = ["dx_vom_h71_trucks_convoy_gas_10", "dx_vom_h71_trucks_convoy_gas_20", "dx_vom_h71_trucks_convoy_gas_30"];
  var1 = scripts\engine\sp\utility::create_deck(var0);
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
  var0 = 1;

  while(var0) {
    scripts\engine\utility::flag_wait("at_other_vehicle");

    if(!scripts\engine\utility::flag("driver_talking")) {
      scripts\engine\utility::flag_set("driver_talking");
      say_as_chatter(level.bravo1, "dx_vom_h73_trucks_convoy_exfil_50");
      scripts\engine\utility::flag_clear("driver_talking");
      var0 = 0;
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

function say(var0, var1, var2) {
  if(!soundexists(var0)) {
    return false;
  }

  if(is_dead_or_dying(self)) {
    return false;
  }

  self notify("started_speaking", var0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var0;

  if(isPlayer(self) && isDefined(var2)) {
    scripts\engine\sp\utility::player_gesture_force(var2);
    var3 = lookupsoundlength(var0) / 1000;
    scripts\engine\utility::delaycall(var3, &stopgestureviewmodel);
  }

  if(istrue(var1)) {
    if(isstruct(self)) {
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var0);
    } else if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var0);
    } else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var0);
    } else {
      if(issentient(self)) {
        self playsoundatviewheight(var0);
      } else {
        self playSound(var0);
      }

      wait lookupsoundlength(var0) / 1000;
    }
  } else if(isstruct(self)) {
    scripts\engine\sp\utility::smart_radio_dialogue(var0);
  } else if(isPlayer(self)) {
    scripts\engine\sp\utility::smart_player_dialogue(var0);
  } else if(isDefined(self.animname)) {
    scripts\engine\sp\utility::smart_dialogue(var0);
  } else {
    if(issentient(self)) {
      self playsoundatviewheight(var0);
    } else {
      self playSound(var0);
    }

    wait lookupsoundlength(var0) / 1000;
  }

  self notify("finished_speaking", var0);
  return true;
}

function is_dead_or_dying(var0) {
  if(!isDefined(var0)) {
    return true;
  }

  if(isai(var0)) {
    return (!isalive(var0) || var0 scripts\engine\utility::doinglongdeath());
  } else if(issentient(var0)) {
    return !isalive(var0);
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

  var0 = (gettime() - self.lastspoketime) / 1000;
  var1 = lookupsoundlength(self.lastaliassaid) / 1000;

  if(var0 < var1) {
    wait var1 - var0;
  }

  return true;
}

function time_since_spoke() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return undefined;
  }

  var0 = self.lastspoketime + lookupsoundlength(self.lastaliassaid);
  return (gettime() - var0) / 1000;
}

function say_sequence(var0, var1) {
  var2 = self;

  if(!isarray(var0)) {
    var0 = [var0];
  }

  foreach(var4 in var0) {
    var2 = say_vo_item(var2, var4, var1);
  }
}

function say_vo_item(var0, var1) {
  var2 = self;

  if(isarray(var0)) {
    if((isint(var0[0]) || isfloat(var0[0])) && isint(var0[1]) || isfloat(var0[1])) {
      wait randomfloatrange(var0[0], var0[1]);
    } else if(isbuiltinfunction(var0[0]) || isbuiltinmethod(var0[0]) || isanimation(var0[0])) {
      call_with_params(var2, var0[0], var0[1]);
    }

    return var2;
  }

  if(isent(var0) || isstruct(var0)) {
    var2 = var0;
  } else if(isstring(var0)) {
    say(var2, var0, var1);
  } else if(isint(var0) || isfloat(var0)) {
    wait var0;
  } else if(isbuiltinfunction(var0) || isbuiltinmethod(var0) || isanimation(var0)) {
    call_with_params(var2, var0);
  } else if(scripts\engine\sp\utility::is_deck(var0)) {
    var2 = say_vo_item(var2, var0 scripts\engine\sp\utility::deck_draw(), var1);
  }

  return var2;
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

function say_as_chatter(var0, var1, var2) {
  return do_as_chatter(&say, [var0, var1], var1, var2);
}

function say_as_chatter_with_gesture(var0, var1, var2, var3) {
  return do_as_chatter(&say, [var1, var2, var0], var2, var3);
}

function say_sequence_as_chatter(var0, var1, var2) {
  return do_as_chatter(&say_sequence, [var0], var1, var2);
}

function wait_for_break_in_chatter(var0) {
  var1 = spawnStruct();
  var2 = 0;

  if(!isDefined(level.vo_chatter) || !level.vo_chatter.speaking) {
    return 1;
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var1);

  if(isDefined(var0) && isstring(var0)) {
    var2 = scripts\engine\utility::waittill_any_ents_return(var1, "proceed", self, var0, level, var0) == var0;
  } else if(isDefined(var0)) {
    var2 = var1 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var0) == "timeout";
  } else {
    var1 waittill("proceed");
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var1);
  return var2;
}

function do_as_chatter(var0, var1, var2, var3) {
  if(!isDefined(level.vo_chatter)) {
    thread init_chatter();
  }

  level.vo_chatter endon("terminate_chatter");
  var4 = spawnStruct();
  thread do_as_chatter_internal(var0, var1, var2, var3, var4);
  var4 waittill("done", var5);
  return var5;
}

function do_as_chatter_internal(var0, var1, var2, var3, var4) {
  level.vo_chatter endon("terminate_chatter");

  if(level.vo_chatter.speaking && (!istrue(var2) || isDefined(var3))) {
    var5 = wait_for_break_in_chatter(var3);
  } else {
    var5 = 0;
  }

  var6 = undefined;

  if(!level.vo_chatter.speaking || !var5 || istrue(var3)) {
    level.vo_chatter notify("started_speaking", self, var1, var2);
    level.vo_chatter.speaking++;
    var6 = call_with_params(var1, var2);
    level.vo_chatter.speaking--;
    level.vo_chatter notify("done_speaking", self, var1, var2);
  }

  if(!level.vo_chatter.speaking && isDefined(level.vo_chatter.waiting[0])) {
    level.vo_chatter.waiting[0] notify("proceed");
  }

  var5 notify("done", var6);
}

function call_with_params(var0, var1) {
  if(isbuiltinfunction(var0)) {
    return call_with_params_script(var0, var1);
  }

  if(isbuiltinmethod(var0) || isanimation(var0)) {
    return call_with_params_builtin(var0, var1);
  }
}

function call_with_params_script(var0, var1) {
  if(!isDefined(var1)) {
    return self[[var0]]();
  }

  if(!isarray(var1)) {
    return self[[var0]](var1);
  }

  switch (var1.size) {
    case 0:
      return self[[var0]]();
    case 1:
      return self[[var0]](var1[0]);
    case 2:
      return self[[var0]](var1[0], var1[1]);
    case 3:
      return self[[var0]](var1[0], var1[1], var1[2]);
    case 4:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3]);
    case 5:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4]);
    case 6:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5]);
    case 7:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6]);
    case 8:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7]);
    case 9:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7], var1[8]);
    default:
      break;
  }
}

function call_with_params_builtin(var0, var1) {
  if(!isDefined(var1)) {
    return self[[var0]]();
  }

  if(!isarray(var1)) {
    return self builtin[[var0]](var1);
  }

  switch (var1.size) {
    case 0:
      return self builtin[[var0]]();
    case 1:
      return self builtin[[var0]](var1[0]);
    case 2:
      return self builtin[[var0]](var1[0], var1[1]);
    case 3:
      return self builtin[[var0]](var1[0], var1[1], var1[2]);
    case 4:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3]);
    case 5:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4]);
    case 6:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5]);
    case 7:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6]);
    case 8:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7]);
    case 9:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7], var1[8]);
    default:
      break;
  }
}

function nagtill_or_timeout(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = spawnStruct();
  var9 endon("stop");
  var9 scripts\engine\utility::delaythread(var0, &scripts\engine\utility::send_notify, "stop");
  nagtill(var1, var2, var3, var4, var5, var6, var7, var8);
}

function nagtill_delayed(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1)) {
    if(!isarray(var1)) {
      var1 = [var1];
    }

    foreach(var11 in var1) {
      var12 = scripts\engine\utility::flag_exist(var11) && scripts\engine\utility::ter_op(istrue(var9), !scripts\engine\utility::flag(var11), scripts\engine\utility::flag(var11));

      if(var12) {
        return;
      }

      level endon(var11);
      self endon(var11);
    }
  }

  wait var0;
  nagtill(var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function nagtill_open_delayed(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(isDefined(var1)) {
    if(!isarray(var1)) {
      var1 = [var1];
    }

    foreach(var10 in var1) {
      if(scripts\engine\utility::flag_exist(var10) && !scripts\engine\utility::flag(var10)) {
        return;
      }

      level endon(var10);
      self endon(var10);
    }
  }

  wait var0;
  return nagtill(var1, var2, var3, var4, var5, var6, var7, var8, 1);
}

function nagtill_open(var0, var1, var2, var3, var4, var5, var6, var7) {
  return nagtill(var0, var1, var2, var3, var4, var5, var6, var7, 1);
}

function nagtill(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var2 = default_if_undefined(var2, 3);
  var3 = default_if_undefined(var3, 1.5);
  var4 = default_if_undefined(var4, 25);
  var5 = default_if_undefined(var5, var2 / 4);
  var6 = default_if_undefined(var6, var3);
  var7 = default_if_undefined(var7, var4 / 4);
  var9 = var4 > var2;
  var10 = var7 > var5;

  if(isDefined(var0)) {
    if(!isarray(var0)) {
      var0 = [var0];
    }

    foreach(var12 in var0) {
      var13 = scripts\engine\utility::flag_exist(var12) && scripts\engine\utility::ter_op(istrue(var8), !scripts\engine\utility::flag(var12), scripts\engine\utility::flag(var12));

      if(var13) {
        return;
      }

      level endon(var12);
      self endon(var12);
    }
  }

  jumpiffalse(isarray(var1)) LOC_000000dc;
  var1 = scripts\engine\sp\utility::create_deck(var1, 0);
  var1.autoshuffle = 1;

  for(;;) {
    var15 = self;
    var16 = var1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var16)) {
      var15 = var16[0];
      var16 = var16[1];
    }

    thread notify_started_nag(var15);
    say_as_chatter(var15, var16);
    level notify("said_nag", var15, var16);
    wait randomfloatrange(var2 - var5, var2 + var5);

    if(var9) {
      var2 = min(var2 * var3, var4);
    } else {
      var2 = max(var2 * var3, var4);
    }

    if(var10) {
      var5 = min(var5 * var6, var7);
    } else {
      var5 = max(var5 * var6, var7);
    }

    if(var1 scripts\engine\sp\utility::deck_is_empty()) {
      array_deck_shuffle(var1);
    }
  }
}

function notify_started_nag(var0) {
  if(!isDefined(self) || !isDefined(var0)) {
    return;
  }

  self waittillmatch("started_speaking", var0);
  level notify("started_nag", self, var0);
}

function compare(var0, var1) {
  if(isarray(var0)) {
    if(isarray(var1)) {
      return compare_arrays(var0, var1);
    }

    return 0;
  }

  if(isarray(var1)) {
    return 0;
  }

  return var0 == var1;
}

function compare_arrays(var0, var1) {
  if(var0.size != var1.size) {
    return false;
  }

  foreach(var3 in var0) {
    if(!isDefined(var1[var5])) {
      return false;
    }

    var4 = var1[var5];

    if(compare(var4, var3)) {
      return false;
    }
  }

  return true;
}

function array_deck_shuffle() {
  var0 = self;
  var0.index = 0;
  var0.items = scripts\engine\utility::array_randomize(var0.items);

  if(!var0.prevent_redraw || !isDefined(var0.last_drawn) || var0.items.size <= 1) {
    return;
  }

  var1 = compare(var0.items[0], var0.last_drawn);

  if(var1) {
    var2 = randomintrange(1, var0.items.size);
    var3 = var0.items[0];
    var0.items[0] = var0.items[var2];
    var0.items[var2] = var3;
    return;
  }
}

function default_if_undefined(var0, var1) {
  if(!isDefined(var0)) {
    var0 = var1;
  }

  return var0;
}

function wait_combat_cooldown(var0, var1, var2) {
  if(istrue(var2)) {
    wait var0;
  }

  while(!isDefined(var1) || var1 > 0) {
    if(!recently_in_combat(var0)) {
      return false;
    }

    waitframe();

    if(isDefined(var1)) {
      var1 -= 0.05;
    }
  }

  return true;
}

function recently_in_combat(var0) {
  var1 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var0);
  var2 = isDefined(level.player.last_damaged_time) && !scripts\engine\utility::time_has_passed(level.player.last_damaged_time, var0);
  return level.player isfiring() || var1 || var2;
}

function track_player_combat_time() {
  level.player endon("death");

  for(;;) {
    var0 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "damage") == "weapon_fired";

    if(var0) {
      level.player.last_weapon_fire_time = gettime();
      continue;
    }

    level.player.last_damaged_time = gettime();
  }
}

function wait_lookat_or_timeout(var0, var1, var2, var3, var4, var5, var6) {
  return wait_lookat(var0, var1, var3, var4, var5, var6, var2, 1);
}

function wait_lookat_ads_or_timeout(var0, var1, var2, var3, var4, var5, var6) {
  return wait_lookat_ads(var0, var1, var3, var4, var5, var6, var2);
}

function wait_lookat_ads(var0, var1, var2, var3, var4, var5, var6) {
  if(!istrue(var5)) {
    var5 = 0;
  }

  return wait_lookat(var0, var1, var2, var3, var4, var5, var6, 1);
}

function wait_lookaway(var0, var1, var2, var3, var4, var5, var6, var7) {
  return wait_lookat(var0, var1, var2, var3, var4, var5, var6, var7, 1);
}

function wait_lookat(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(isDefined(var3)) {
    var3 *= 1000;
  } else {
    var3 = 0;
  }

  var9 = undefined;

  while(!isDefined(var9) || gettime() - var9 <= var3) {
    if(!isDefined(var0)) {
      return;
    }

    if(isDefined(var4)) {
      wait_near(level.player, var0, var4);
    }

    var10 = is_looking_at(var0, var1, var2, var5);

    if(var8) {
      var10 = !var10;
    }

    if(istrue(var7)) {
      var10 = var10 && level.player scripts\engine\sp\utility::isads();
    }

    if(var10 && !isDefined(var9)) {
      var9 = gettime();
    } else if(!var10) {
      var9 = undefined;
    }

    if(var10 && (!isDefined(var3) || var3 == 0)) {
      break;
    }

    waitframe();

    if(isDefined(var6)) {
      var6 -= 0.05;

      if(var6 <= 0) {
        return 0;
      }
    }
  }

  return 1;
}

function is_looking_at(var0, var1, var2, var3) {
  if(isent(var0) && isDefined(var2)) {
    var4 = var0 gettagorigin(var2);
  } else if((isent(var1) || isstruct(var1)) && isDefined(var1.origin)) {
    var4 = var1.origin;
  } else {
    var4 = var2;
  }

  var5 = level.player worldpointtoscreenpos(var4, getdvarint("MRNKTKLLKP"));

  if(!isDefined(var5)) {
    return 0;
  }

  if(isDefined(var3) && length2d(var5) > var3) {
    return 0;
  }

  if(!isDefined(var4) || var4) {
    jumpiffalse(isent(var2)) LOC_00000098;
    var6 = [level.player, var2];
    goto LOC_000000a3;
  } else {
    var7 = 1;
  }

  return var7;
}

function wait_near(var0, var1) {
  var2 = var1 * var1;
  var3 = var0;

  for(;;) {
    if(isent(var0)) {
      var3 = var0.origin;
    }

    if(distance2dsquared(self.origin, var3) < var2) {
      break;
    }

    waitframe();
  }
}

function say_on_enemy_radio(var0, var1, var2) {
  var3 = 0;

  if(!istrue(var1) || isDefined(var2)) {
    var3 = wait_for_break_in_chatter(var2);
  }

  if(isDefined(var1) && !var1 && var3) {
    return;
  }

  var4 = getcorpsearrayinradius(level.player.origin, 1000);
  var5 = scripts\engine\utility::array_combine(var4, getaiarrayinradius(level.player.origin, 1000, "axis"));

  if(var5.size == 0) {
    return;
  }

  var6 = undefined;
  var7 = undefined;

  foreach(var9 in var5) {
    if(getsubstr(var9.classname, 0, 11) != "actor_enemy") {
      continue;
    }

    var10 = distance2dsquared(level.player.origin, var9 gettagorigin("j_chest"));

    if(!isDefined(var7) || var10 < var7) {
      var6 = var9;
      var7 = var10;
    }
  }

  if(!isDefined(var6)) {
    return;
  }

  var12 = var6 gettagorigin("j_chest");
  var13 = var6 gettagangles("j_chest");
  var14 = scripts\engine\utility::spawn_script_origin(var12, var13);
  var14 linkTo(var6, "j_chest");
  say(var14, var0, 1);
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