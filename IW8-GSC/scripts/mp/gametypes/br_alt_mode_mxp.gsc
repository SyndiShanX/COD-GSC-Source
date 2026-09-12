/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_mxp.gsc
****************************************************/

function activate_laser_trap_parent() {}

function init() {
  if(!getdvarint("scr_br_alt_mode_mxp", 0)) {
    return;
  }

  unloadinfiltransient("mp_infil_wz_island_greenbay_tr");
  unloadinfiltransient("mp_infil_wz_island_kenosha_tr");
  teleportplayertoselection();
  tr_vis_radius_override_lod2();
  zombieregendelayscaleingas();
  vehicle_outline_watcher();
  post_safeges_weapon();
  testing();
  ref_13220();
  toggle_ai_settings();
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "aim_override", &binocularsseegk);
  thread toggleusbstickinhand();
}

function tr_vis_radius_override_lod2() {
  level.disable_super_in_turret.brlootchoppercratedestroycallback = 1;
  level.disable_oob_immunity_on_riders = 1;
  level.ref_11E18 = spawnStruct();
  level.ref_11E18.eetimebetweendialoglines = getdvarfloat("scr_br_mxp_ee_time_between_lines", 1.5);
  level.ref_11E18.kheadchallengetriggerheight = getdvarint("scr_br_mxp_k_head_challenge_trig_height", 1250);
  level.ref_11E18.kheadchallengetriggerradius = getdvarint("scr_br_mxp_k_head_challenge_trig_radius", 750);
  level.ref_11E18.kchallengetriggerheight = getdvarint("scr_br_mxp_k_challenge_trig_height", 1750);
  level.ref_11E18.kchallengetriggerradius = getdvarint("scr_br_mxp_k_challenge_trig_radius", 150);
  level.ref_11E18.kstandonheadduration = getdvarfloat("scr_br_mxp_k_stand_on_head_dur", 2.5);
  level.ref_11E18.ee_cooldown_duration = getdvarfloat("scr_br_mxp_ee_cooldown", 1);
  level.ref_11E18.kjumptracetestheight = getdvarint("scr_br_mxp_kk_jump_trace_test_height", 2000);
  level.ref_11E18.kjumpdistancemid = getdvarint("scr_br_mxp_k_jump_distance_mid", 17500);
  level.ref_11E18.kjumpdistancemidsq = level.ref_11E18.kjumpdistancemid * level.ref_11E18.kjumpdistancemid;
  level.ref_11E18.kjumpdistancelong = getdvarint("scr_br_mxp_k_jump_distance_long", 27500);
  level.ref_11E18.kjumpdistancelongsq = level.ref_11E18.kjumpdistancelong * level.ref_11E18.kjumpdistancelong;
  level.ref_11E18.kjumpgravitymin = getdvarint("scr_br_mxp_k_jump_gravity_min", 4000);
  level.ref_11E18.kjumpgravitymid = getdvarint("scr_br_mxp_k_jump_gravity_mid", 8000);
  level.ref_11E18.kjumpgravitymax = getdvarint("scr_br_mxp_k_jump_gravity_max", 12500);
  level.ref_11E18.kjumpspeedmin = getdvarint("scr_br_mxp_k_jump_speed_short_range", 6000);
  level.ref_11E18.kjumpspeedmid = getdvarint("scr_br_mxp_k_jump_speed_mid_range", 7500);
  level.ref_11E18.kjumpspeedmax = getdvarint("scr_br_mxp_k_jump_speed_long_range", 9000);
  level.ref_11E18.kgroundpoundstunduration = getdvarint("scr_mxp_k_ground_pound_stun_duration", 2);
  level.ref_11E18.kgroundpoundradius = getdvarint("scr_mxp_k_ground_pound_radius", 4000);
  level.ref_11E18.kroarduration = getdvarfloat("scr_mxp_k_roar_duration", 1.25);
  level.ref_11E18.groarduration = getdvarfloat("scr_mxp_g_roar_duration", 2.5);
  level.ref_11E18.tlightfeedbackduration = getdvarfloat("scr_mxp_light_feedback_duration", 0.5);
  level.ref_11E18.tmediumfeedbackduration = getdvarfloat("scr_mxp_medium_feedback_duration", 1);
  level.ref_11E18.theavyfeedbackduration = getdvarfloat("scr_mxp_heavy_feedback_duration", 1.25);
  level.ref_11E18.tlightfeedbackrange = getdvarint("scr_mxp_light_feedback_range", 10000);
  level.ref_11E18.tmediumfeedbackrange = getdvarint("scr_mxp_medium_feedback_range", 10000);
  level.ref_11E18.theavyfeedbackrange = getdvarint("scr_mxp_heavy_feedback_range", 10000);
  level.ref_11E18.wait_for_player_in_gas = getdvarint("scr_br_mxp_k_min_actions", 2);
  level.ref_11E18.wait_for_player_gulag_respawn = getdvarint("scr_br_mxp_k_max_actions", 3);
  level.ref_11E18.select_bunker_courtyard_spawners = getdvarfloat("scr_br_mxp_g_ks_chance", 0.5);
  level.ref_11E18.select_bunker_interior_groups = getdvarint("scr_br_mxp_g_ks_max", 20000);
  level.ref_11E18.select_bunker_interior_four_spawners = getdvarint("scr_br_mxp_g_ks_max", 10000);
  level.ref_11E18.gsmallkillstreakradius = getdvarint("scr_br_mxp_k_gz_small", 1000);
  level.ref_11E18.wait_for_players_init_puzzle = getdvarint("scr_br_mxp_k_ks_max", 20000);
  level.ref_11E18.wait_for_player_to_getup = getdvarint("scr_br_mxp_k_ks_max", 8000);
  level.ref_11E18.waitandstartplunderpolling = getdvarint("scr_br_mxp_k_ks_small", 2000);
  level.ref_11E18.damageperintel = getdvarint("scr_br_mxp_damage_intel", 300);
  level.ref_11E18.damageuntilnotice = getdvarint("scr_br_mxp_damage_notice", 1200);
  level.ref_11E18.kswataggroradius = getdvarint("scr_br_mxp_k_swat_aggro_radius", 6000);
  level.ref_11E18.kswataggroheight = getdvarint("scr_br_mxp_k_swat_aggro_height", 3500);
  level.ref_11E18.kswatheightoffset = getdvarint("scr_br_mxp_k_swat_height_offset", 0);
  level.ref_11E18.kswatyawmid = getdvarfloat("scr_br_mxp_k_swat_yaw_mid", 40);
  level.ref_11E18.kswatyawmax = getdvarfloat("scr_br_mxp_k_swat_yaw_max", 115);
  level.ref_11E18.kswatradius = getdvarint("scr_br_mxp_k_swat_radius", 350);
  level.ref_11E18.kswatheight = getdvarint("scr_br_mxp_k_swat_height", 500);
  level.ref_11E18.klimitanimspeak = getdvarint("scr_br_mxp_k_limit_anims_peak", 1);
  level.ref_11E18.kaltcrateattack = getdvarint("scr_br_mxp_k_alt_crate", 1);
  level.ref_11E18.ggoaldist = getdvarint("scr_br_mxp_g_goal_dist", 100);
  level.ref_11E18.ggoaldistsquared = level.ref_11E18.ggoaldist * level.ref_11E18.ggoaldist;
  level.ref_11E18.transferanger = getdvarint("scr_br_mxp_transfer_anger", 1);
  level.ref_11E18.gaimstate = getdvarint("scr_br_mxp_g_aim_state", 5);
  level.ref_11E18.gtargetairborneheight = getdvarint("scr_br_mxp_g_target_airborne_height", 500);
  level.ref_11E18.trandomkillstreakcircle = getdvarint("scr_br_mxp_t_random_killstreak_circle", 6);
  level.ref_11E18.klookdownradius = getdvarint("scr_br_mxp_k_look_down_radius", 6000);

  if(level.ref_11E18.wait_for_player_gulag_respawn < level.ref_11E18.wait_for_player_in_gas) {
    level.ref_11E18.wait_for_player_gulag_respawn = level.ref_11E18.wait_for_player_in_gas + 1;
  }

  level.ref_11E18.kidles = ["s4_mp_kenosha_idle_breath_01", "s4_mp_kenosha_idle_lookaround_01", "s4_mp_kenosha_idle_taunt_01", "s4_mp_kenosha_idle_knuckles_01", "s4_mp_kenosha_idle_knuckles_02"];
  level.ref_11E18.gidles = ["s4_mp_greenbay_idle_breath_01", "s4_mp_greenbay_idle_lookaround_01", "s4_mp_greenbay_idle_taunt_01"];
}

function teleportplayertoselection() {
  game["dialog"]["g_incoming_attack"] = "greenbay_killstreak_active";
  game["dialog"]["g_incoming_attack_player"] = "greenbay_killstreak_active_player";
  game["dialog"]["g_attack_used"] = "oshkosh_device_use_greenbay";
  game["dialog"]["k_incoming_attack"] = "kenosha_killstreak_active";
  game["dialog"]["k_incoming_attack_player"] = "kenosha_killstreak_active_player";
  game["dialog"]["k_attack_used"] = "oshkosh_device_use_kenosha";
  game["dialog"]["k_jump_incoming"] = "kenosha_titan_incoming";
  game["dialog"]["t_incoming_attack_player"] = "titan_killstreak_active";
  game["dialog"]["scream_device_acquired"] = "oshkosh_acquire";
  game["dialog"]["scream_device_acquired_desc"] = "oshkosh_reward_desc";
  game["dialog"]["enemy_scream_device_acquired"] = "oshkosh_acquired_enemy";
}

function toggle_ai_settings() {
  level.ref_11E18.notetracks = [];
  var_0 = [];
  var_0 = ["kenosha_chest_slam", "titan_roar"];
  level.ref_11E18.notetracks["s4_mp_kenosha_idle_taunt_01"] = var_0;
  level.ref_11E18.notetracks["s4_mp_kenosha_idle_bark_01"] = var_0;
  var_0 = ["kenosha_chest_slam", "titan_roar", "titan_step"];
  level.ref_11E18.notetracks["s4_mp_kenosha_idle_knuckles_01"] = var_0;
  var_0 = ["kenosha_grab_rock", "kenosha_throw_rock"];
  level.ref_11E18.notetracks["s4_mp_kenosha_toss_attack_01"] = var_0;
  level.ref_11E18.notetracks["s4_mp_kenosha_toss_attack_02"] = var_0;
  var_0 = ["kenosha_ground_pound"];
  level.ref_11E18.notetracks["s4_mp_kenosha_stomp_attack_01"] = var_0;
  var_0 = ["kenosha_chest_slam"];
  level.ref_11E18.notetracks["s4_mp_kenosha_swat_attack_fwd_01"] = var_0;
  var_0 = ["kenosha_chest_slam", "titan_step"];
  level.ref_11E18.notetracks["s4_mp_kenosha_swat_attack_l_01"] = var_0;
  level.ref_11E18.notetracks["s4_mp_kenosha_idle_knuckles_02"] = var_0;
  var_0 = ["titan_step", "titan_roar"];
  level.ref_11E18.notetracks["s4_mp_kenosha_jump_start_01"] = var_0;
  var_0 = ["kenosha_stomp"];
  level.ref_11E18.notetracks["s4_mp_kenosha_leg_stomp_attack_01"] = var_0;
  var_0 = ["kenosha_leap_land"];
  level.ref_11E18.notetracks["s4_mp_kenosha_jump_stomp_01"] = var_0;
  var_0 = ["titan_step"];
  level.ref_11E18.notetracks["s4_mp_kenosha_swat_attack_r_01"] = var_0;
  level.ref_11E18.notetracks["s4_mp_kenosha_idle_lookaround_01"] = var_0;
  level.ref_11E18.notetracks["s4_mp_kenosha_turn_l_45"] = var_0;
  level.ref_11E18.notetracks["s4_mp_kenosha_turn_l_90"] = var_0;
  level.ref_11E18.notetracks["s4_mp_kenosha_turn_l_135"] = var_0;
  level.ref_11E18.notetracks["s4_mp_kenosha_turn_l_180"] = var_0;
  level.ref_11E18.notetracks["s4_mp_kenosha_turn_r_45"] = var_0;
  level.ref_11E18.notetracks["s4_mp_kenosha_turn_r_90"] = var_0;
  level.ref_11E18.notetracks["s4_mp_kenosha_turn_r_135"] = var_0;
  level.ref_11E18.notetracks["s4_mp_kenosha_turn_r_180"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_dive_01"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_emerge"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_turn_l_45"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_turn_l_90"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_turn_l_135"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_turn_l_180"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_turn_r_45"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_turn_r_90"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_turn_r_135"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_turn_r_180"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_walk_left_01"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_walk_right_01"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_walk_01"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_walk_stop_01"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_idle_lookaround_01"] = var_0;
  var_0 = ["titan_roar"];
  level.ref_11E18.notetracks["s4_mp_greenbay_idle_taunt_01"] = var_0;
  var_0 = ["greenbay_tail_smash"];
  level.ref_11E18.notetracks["s4_mp_greenbay_tail_smash_01"] = var_0;
  level.ref_11E18.notetracks["s4_mp_greenbay_idle_bark_01"] = var_0;
}

function toggleusbstickinhand() {
  waittillframeend();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  thread ref_135FF();
  thread ee_setup();
}

function zombieregendelayscaleingas() {
  level._effect["greenbay_beam"] = loadfx("vfx/iw8_br/island/gameplay/mendota/vfx_br3_gbay_heatray_beam.vfx");
}

function ee_setup() {
  if(getdvarint("scr_br_mxp_ee_enabled", 1)) {
    scripts\engine\scriptable::ref_12F5B("spy_equipment", &ee_spyequipmentscriptableused);
    var_0 = getentitylessscriptablearrayinradius("mendota_ee", "targetname");

    if(getdvarint("scr_br_mxp_ee_wait_for_match_start", 1)) {
      foreach(var_2 in var_0) {
        var_2 setscriptablepartstate("spy_equipment", "off");
      }

      scripts\mp\flags::gameflagwait("prematch_fade_done");
    }

    foreach(var_2 in var_0) {
      var_2 setscriptablepartstate("spy_equipment", "on");
    }

    return;
  }
}

function ref_135FF() {
  if(level.agentarray.size < 2) {
    level waittill("add_agents_to_game");
  }

  var_0 = getdvarint("scr_br_alt_mode_mxp", 0);

  if(var_0 == 2) {
    set_mission_ai_cap((13496.2, 11587, 8766.97), (0, 156.672, 0));
    level.ref_11E18.setjailtimeouthud = level.ref_11E18.setincomingremovedcallback;
    level.ref_11E18.setincomingremovedcallback = undefined;
    set_mission_ai_cap((-16837.6, -16622, 888.125), (0, -128.981, 0));
    waitandstartscorepolling((11761, 12636, 8528), (0, -22, 0));
    level.ref_11E18.wait_for_one_player_near_point = level.ref_11E18.wait_for_next_hack_complete;
    level.ref_11E18.wait_for_next_hack_complete = undefined;
    waitandstartscorepolling((-18417.4, -18107.9, 888.125), (0, 488.342, 0));
  } else {
    thread set_omnvar_for_icon();
    thread waitfor_trigger_near_obit();
  }

  thread ref_13E32();
}

function testing() {
  level.ref_11E18.seq3_tanksettings = [];
  level.ref_11E18.seq3_tanksettings = [players_in_correct_volume((-1300, 60000, -640)), players_in_correct_volume((25600, 62360, -640)), players_in_correct_volume((49100, 52054, -640)), players_in_correct_volume((58000, 23000, -640)), players_in_correct_volume((50500, -9000, -640)), players_in_correct_volume((49270, -47613, -640)), players_in_correct_volume((16640, -61500, -640)), players_in_correct_volume((-18560, -55888, -640)), players_in_correct_volume((-35500, -35000, -640)), players_in_correct_volume((-50920, -6128, -640)), players_in_correct_volume((-56870, 15000, -640)), players_in_correct_volume((-34800, 40600, -640))];
}

function players_in_correct_volume(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_1.score_event_civilian_killed = reset_use_think(var_0);
  return var_1;
}

function reset_use_think(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in level.ref_11E18.setlethalonunresolvedcollision) {
    var_7 = distance2dsquared(var_6, var_0);

    if(!isDefined(var_2) || var_7 < var_1) {
      var_3 = var_1;
      var_4 = var_2;
      var_1 = var_7;
      var_2 = var_8;
      continue;
    }

    if(!isDefined(var_4) || var_7 < var_3) {
      var_3 = var_7;
      var_4 = var_8;
    }
  }

  var_9 = var_2 - var_4;

  if(abs(var_9) != 1 && abs(var_9) != level.ref_11E18.setlethalonunresolvedcollision.size - 1) {}

  if(abs(var_9) == level.ref_11E18.setlethalonunresolvedcollision.size - 1) {
    var_9 = 0 - var_9;
  }

  return scripts\engine\utility::ter_op(var_9 < 0, var_2, var_4);
}

function sappliedstages() {
  var_0 = level.ref_11E18.setincomingremovedcallback scripts\engine\utility::array_sort_with_func(getarraykeys(level.ref_11E18.seq3_tanksettings), &post_race);

  if(!isDefined(level.br_circle.dangercircleent)) {
    var_1 = level.ref_11E18.seq3_tanksettings[var_0[0]];
    return [var_1.score_event_civilian_killed, var_1.origin];
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_1 = level.ref_11E18.seq3_tanksettings[var_3];

    if(scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_1.origin)) {
      return [var_1.score_event_civilian_killed, var_1.origin];
    }
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_1 = level.ref_11E18.seq3_tanksettings[var_3];

    if(scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_1.origin)) {
      return [var_1.score_event_civilian_killed, var_1.origin];
    }
  }

  var_1 = level.ref_11E18.seq3_tanksettings[var_1[0]];
  return [var_1.score_event_civilian_killed, var_1.origin];
}

function post_race(var_0, var_1) {
  var_2 = level.ref_11E18.seq3_tanksettings[var_0].origin;
  var_3 = level.ref_11E18.seq3_tanksettings[var_1].origin;
  return distancesquared(var_2, self.origin) < distancesquared(var_3, self.origin);
}

function set_mission_ai_cap(var_0, var_1) {
  var_2 = !isDefined(level.ref_11E18.setincomingremovedcallback);

  if(var_2) {
    level.ref_11E18.setincomingremovedcallback = spawnnewagent("greenbay", "wz_mv_greenbay", var_0, var_1, 3000, 8100, &postgamehitmarkerwaittime);
    level.ref_11E18.setincomingremovedcallback unmarkkeyframedmover(1);
    ref_13E31(level.ref_11E18.setincomingremovedcallback, "ui_mp_br_icon_greenbay", 8100);
    ref_13187(0, level.ref_11E18.setincomingremovedcallback getentitynumber());
    level.ref_11E18.setincomingremovedcallback.turnrate = 0.01;
    level.ref_11E18.setincomingremovedcallback.linked_mover = 0;
    level.ref_11E18.setincomingremovedcallback.playerdamage = [];
    level.ref_11E18.setincomingremovedcallback.angertargets = [];
    level.ref_11E18.setincomingremovedcallback sethitlocdamagetable("ai_mv_lochit_dmgtable");
    level.ref_11E18.setincomingremovedcallback.x1fin_respawn = spawn("script_model", var_0);
    level.ref_11E18.setincomingremovedcallback.x1fin_respawn setModel("tag_origin");
    level.ref_11E18.setincomingremovedcallback.x1fin_respawn unmarkkeyframedmover(1);
    level.ref_11E18.setincomingremovedcallback.clear_look_at_ent = spawn("script_model", var_0);
    level.ref_11E18.setincomingremovedcallback.clear_look_at_ent setModel("tag_player");
    level.ref_11E18.setincomingremovedcallback.clear_look_at_ent unmarkkeyframedmover(1);
    level.ref_11E18.setincomingremovedcallback.clear_look_at_ent linkTo(level.ref_11E18.setincomingremovedcallback, "tag_mouth_fx", (0, 0, 0), (0, 90, 0));
    level.ref_11E18.setincomingremovedcallback.breathattachent = spawn("script_model", var_0);
    level.ref_11E18.setincomingremovedcallback.breathattachent setModel("tag_origin_greenbay");
    level.ref_11E18.setincomingremovedcallback.breathattachent unmarkkeyframedmover(1);
    level.ref_11E18.setincomingremovedcallback.breathattachent linkTo(level.ref_11E18.setincomingremovedcallback, "tag_mouth_fx", (0, 0, 0), (0, 0, 0), 1);

    if(getdvarint("scr_br_mxp_gk_precise_collision", 1)) {
      thread ginitializeplayercollision();
    } else {
      var_3 = gkkilltriggercreate(level.ref_11E18.setincomingremovedcallback, 3000, 8100, "tag_origin");
      level.ref_11E18.setincomingremovedcallback.collisionkilltriggers = [var_3];
    }
  } else {
    ref_13E37(level.ref_11E18.setincomingremovedcallback);
    level.ref_11E18.setincomingremovedcallback asmsetstate(level.ref_11E18.setincomingremovedcallback.asmname, "idle");
    level.ref_11E18.setincomingremovedcallback.origin = var_0;
    level.ref_11E18.setincomingremovedcallback.x1fin_respawn.origin = var_0;
  }

  level.ref_11E18.setincomingremovedcallback orientmode("face current angles");
  level.ref_11E18.setincomingremovedcallback setplayerangles(var_1);
  level.ref_11E18.setincomingremovedcallback.x1fin_respawn.angles = var_1;
  return level.ref_11E18.setincomingremovedcallback;
}

function ginitializeplayercollision() {
  var_0 = self;
  var_0 endon("death");
  var_0 agentsetclipmode("large");
  var_1 = 0.1;
  var_0.collisionlist = [];
  var_2 = getEntArray("greenbay_collision", "targetname");

  foreach(var_4 in var_2) {
    var_5 = "?";
    var_6 = (0, 0, 0);
    var_7 = (0, 0, 0);
    var_8 = var_4.script_noteworthy;

    if(var_8 == "head") {
      var_5 = "j_head";
      var_6 = (360, 190, 35);
      var_7 = (0, 0, -90);
    } else if(var_8 == "body") {
      var_5 = "j_spine4";
      var_6 = (-1670, -420, 30);
      var_7 = (0, -41, -90);
    }

    var_9 = spawnStruct();
    var_9.colliderent = var_4;
    var_9.tagname = var_5;
    var_9.originoffset = var_6;
    var_9.angleoffset = var_7;
    var_0.collisionlist[var_8] = var_9;
  }

  var_11 = gkkilltriggercreate(var_0, 400, 500, "j_head", 1, (50, -80, -250), (0, 0, 0));
  wait var_1;
  var_12 = gkkilltriggercreate(var_0, 230, 1100, "j_elbow_le", 1, (100, -80, 10), (0, 100, 100));
  var_13 = gkkilltriggercreate(var_0, 230, 1100, "j_elbow_ri", 1, (100, -80, 10), (0, 100, 80));
  wait var_1;
  var_14 = gkkilltriggercreate(var_0, 550, 1900, "j_knee_le", 1, (-400, -100, -100), (90, 0, -10));
  var_15 = gkkilltriggercreate(var_0, 550, 1900, "j_knee_ri", 1, (-400, -100, 100), (90, 0, -10));
  wait var_1;
  var_16 = gkkilltriggercreate(var_0, 800, 3300, "j_spine4", 1, (-3350, -1050, 0), (90, 0, -10));
  var_17 = gkkilltriggercreate(var_0, 800, 4800, "j_spine4", 1, (-4000, 550, 0), (90, 0, -5));
  level.ref_11E18.setincomingremovedcallback.collisionkilltriggers = [var_11, var_12, var_13, var_14, var_15, var_16, var_17];
  var_0.collisioninitialized = 1;
  var_0 thread gkrunplayercollision(0);
}

function ref_1436F() {
  if(isDefined(level.ref_11E18.setincomingremovedcallback.idleanim)) {
    while(getanimlength(level.ref_11E18.setincomingremovedcallback.idleanim) == 0) {
      waitframe();
    }

    return;
  }
}

function waitandstartscorepolling(var_0, var_1) {
  if(!isDefined(level.ref_11E18.wait_for_next_hack_complete)) {
    level.ref_11E18.wait_for_next_hack_complete = spawnnewagent("kenosha", "wz_mv_kenosha_anim_body", var_0, var_1, 850, 3400);
    level.ref_11E18.wait_for_next_hack_complete attach("wz_mv_kenosha_anim_head");
    level.ref_11E18.wait_for_next_hack_complete unmarkkeyframedmover(1);
    ref_13E31(level.ref_11E18.wait_for_next_hack_complete, "ui_mp_br_icon_kenosha", 3400);
    ref_13187(1, level.ref_11E18.wait_for_next_hack_complete getentitynumber());
    level.ref_11E18.wait_for_next_hack_complete.turnrate = 0.01;
    level.ref_11E18.wait_for_next_hack_complete.playerdamage = [];
    level.ref_11E18.wait_for_next_hack_complete.angertargets = [];
    level.ref_11E18.wait_for_next_hack_complete sethitlocdamagetable("ai_mv_lochit_dmgtable");
    level.ref_11E18.wait_for_next_hack_complete.x1fin_respawn = spawn("script_model", var_0);
    level.ref_11E18.wait_for_next_hack_complete.x1fin_respawn setModel("tag_origin");
    level.ref_11E18.wait_for_next_hack_complete.x1fin_respawn unmarkkeyframedmover(1);
    khandkilltriggers(level.ref_11E18.wait_for_next_hack_complete, 1);

    if(getdvarint("scr_br_mxp_gk_precise_collision", 1)) {
      thread kinitializeplayercollision();
    } else {
      var_2 = gkkilltriggercreate(level.ref_11E18.wait_for_next_hack_complete, 850, 3400, "tag_origin");
      level.ref_11E18.wait_for_next_hack_complete.collisionkilltriggers = [var_2];
    }
  } else {
    ref_13E37(level.ref_11E18.wait_for_next_hack_complete);
    level.ref_11E18.wait_for_next_hack_complete asmsetstate(level.ref_11E18.wait_for_next_hack_complete.asmname, "idle");
    level.ref_11E18.wait_for_next_hack_complete.origin = var_0;
    level.ref_11E18.wait_for_next_hack_complete.x1fin_respawn.origin = var_0;
  }

  level.ref_11E18.wait_for_next_hack_complete.angles = var_1;
  level.ref_11E18.wait_for_next_hack_complete.x1fin_respawn.angles = var_1;
  return level.ref_11E18.wait_for_next_hack_complete;
}

function gkkilltriggercreate(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  var_7 = scripts\engine\utility::ter_op(istrue(var_3), "trigger_rotatable_radius", "trigger_radius");
  var_8 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, (0, 0, 0));
  var_9 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, (0, 0, 0));
  var_10 = spawn(var_7, var_6.origin, 0, var_0, var_1);
  var_10.targetname = "mxpTrigger";
  var_10.radius = var_0;
  var_10.height = var_1;
  var_10.ownertitan = var_6;
  var_10 enablelinkTo();
  var_10 linkTo(var_6, var_2, var_8, var_9);
  thread ref_13DCE();
  scripts\mp\utility\trigger::makeenterexittrigger(var_10, &secretstashlootcacheused);
  return var_10;
}

function gkkilltriggerdestroy() {
  self notify("destroy");
  self delete();
}

function ref_14372() {
  if(isDefined(level.ref_11E18.wait_for_next_hack_complete.idleanim)) {
    while(getanimlength(level.ref_11E18.wait_for_next_hack_complete.idleanim) == 0) {
      waitframe();
    }

    return;
  }
}

function ref_13E32() {
  if(getdvarint("scr_br_mxp_t_prematch", 0) == 0) {
    scripts\mp\flags::gameflagwait("prematch_fade_done");
    waittillframeend();
  }

  for(;;) {
    level.ref_11E18.setincomingremovedcallback method_87bc(gettime() + 10000);
    level.ref_11E18.wait_for_next_hack_complete method_87bc(gettime() + 10000);
    waitframe();
  }
}

function ref_13E31(var_0, var_1) {}

function set_omnvar_for_icon() {
  if(getdvarint("scr_br_mxp_t_prematch", 0) == 0) {
    scripts\mp\flags::gameflagwait("prematch_fade_done");
  }

  var_0 = set_recent_spawn_time_threshold_override();
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_3 = var_0[2];
  var_0 = undefined;
  level.ref_11E18.setlastdroppableweaponobj = var_3;
  set_mission_ai_cap(var_1, var_2);
  ref_1436F();
  gstartnotifywatchers();
  set_player_hurt_trigger();
}

function set_pitch_roll_for_ground_normal() {
  for(;;) {
    var_0 = set_recent_spawn_time_threshold_override(20);
    var_1 = var_0[0];
    var_2 = var_0[1];
    var_3 = var_0[2];
    var_0 = undefined;
    level.ref_11E18.setlastdroppableweaponobj = var_3;
    set_mission_ai_cap(var_1, var_2);
    wait 1;
    var_4 = level.ref_11E18.setincomingremovedcallback;
    set_maze_ai_stealth_settings(0);
    var_4.linked_mover = 0;
    set_relic_dogtags(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_grounded(var_4, 12);
    waitframe();
    level.ref_11E18.setlastdroppableweaponobj = 0;
    set_relic_grounded(var_4, 0);
    set_relic_gas_martyr(var_4);
    waitframe();
    set_relic_dogtags(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_grounded(var_4, 12);
    waitframe();
    level.ref_11E18.setlastdroppableweaponobj = 1;
    set_relic_gas_martyr(var_4);
    waitframe();
    set_relic_dogtags(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_grounded(var_4, 12);
    waitframe();
    level.ref_11E18.setlastdroppableweaponobj = 2;
    set_relic_gas_martyr(var_4);
    waitframe();
    set_relic_dogtags(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_grounded(var_4, 12);
    waitframe();
    level.ref_11E18.setlastdroppableweaponobj = 3;
    set_relic_gas_martyr(var_4);
    waitframe();
    set_relic_dogtags(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_grounded(var_4, 12);
    waitframe();
    level.ref_11E18.setlastdroppableweaponobj = 4;
    set_relic_gas_martyr(var_4);
    waitframe();
    set_relic_dogtags(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_grounded(var_4, 12);
    waitframe();
    level.ref_11E18.setlastdroppableweaponobj = 5;
    set_relic_grounded(var_4, 0);
  }
}

function set_recent_spawn_time_threshold_override(var_0) {
  var_1 = sat_choose_missing_piece();
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_1 = undefined;
  var_4 = scripts\engine\utility::ter_op(var_2 + 1 < level.ref_11E18.setlethalonunresolvedcollision.size, var_2 + 1, 0);
  var_5 = level.ref_11E18.setlethalonunresolvedcollision[var_4];
  var_6 = var_5 - var_3;
  var_7 = vectortoangles(var_6);
  return [var_3, var_7, var_2];
}

function sat_choose_missing_piece() {
  var_0 = randomint(level.ref_11E18.setlethalonunresolvedcollision.size);
  var_1 = level.ref_11E18.setlethalonunresolvedcollision[var_0];
  var_2 = 0;

  if(getdvarint("scr_br_mxp_g_close_to_plane", 1) > 0 && level.mapname == "mp_wz_island" && isDefined(level.infilstruct)) {
    var_3 = [];
    var_4 = level.infilstruct.c130pathstruct.ref_1386E;
    var_3 = ggetstartcanidates(var_3, var_4);

    if(var_3.size == 0) {
      var_4 = level.infilstruct.c130pathstruct.neurotoxin_damage_monitor;
      var_3 = ggetstartcanidates(var_3, var_4);
    }

    if(var_3.size > 0) {
      level.ref_11E18.canidateindexes = var_3.size;
      var_5 = randomint(var_3.size);
      var_0 = var_3[var_5];
      var_1 = level.ref_11E18.setlethalonunresolvedcollision[var_0];
      return [var_0, var_1];
    }

    var_3 = 1;
  }

  if(getdvarint("scr_br_mxp_normal_circle", 0) == 0 || istrue(var_3)) {
    for(var_6 = 0; updateachievementhangtime(var_2) && var_6 < level.ref_11E18.setlethalonunresolvedcollision.size; var_6++) {
      var_1 = scripts\engine\utility::ter_op(var_1 + 1 < level.ref_11E18.setlethalonunresolvedcollision.size, var_1 + 1, 0);
      var_2 = level.ref_11E18.setlethalonunresolvedcollision[var_1];
    }
  }

  return [var_1, var_2];
}

function ggetstartcanidates(var_0, var_1) {
  var_2 = getdvarfloat("scr_br_mxp_g_distance_to_plane", 25000);
  var_3 = var_2 * var_2;

  foreach(var_5 in level.ref_11E18.setlethalonunresolvedcollision) {
    if(updateachievementhangtime(var_5)) {
      continue;
    }

    var_6 = distance2dsquared(var_5, var_1);

    if(var_6 < var_3) {
      var_0 = var_7;
    }
  }

  return var_0;
}

function post_safeges_weapon() {
  var_0 = [];
  var_0[var_0.size] = (-6969, -62217, -628);
  var_0[var_0.size] = (35110, -65651, -628);

  if(getdvarint("scr_br_mxp_skip_path", 0) == 0) {
    var_0[var_0.size] = (49127, -52078, -628);
    var_0[var_0.size] = (57520, -35449, -628);
    var_0[var_0.size] = (60361, 48474, -628);
    var_0[var_0.size] = (22320, 64983, -628);
    var_0[var_0.size] = (-22917, 64110, -628);
    var_0[var_0.size] = (-34118, 57593, -628);
    var_0[var_0.size] = (-35796, 38018, -628);
    var_0[var_0.size] = (-53281, 23823, -628);
    var_0[var_0.size] = (-53567, 1284, -628);
    var_0[var_0.size] = (-56000, -7500, -628);
    var_0[var_0.size] = (-57800, -19500, -628);
    var_0[var_0.size] = (-28765, -49330, -628);
  }

  level.ref_11E18.setlethalonunresolvedcollision = var_0;
  playerzombiesetuphud();
}

function playerzombiesetuphud() {
  var_0 = getdvarint("scr_br_mxp_g_node_dist", 20000);
  var_1 = [];
  var_1[var_1.size] = level.ref_11E18.setlethalonunresolvedcollision[0];

  for(var_2 = 0; var_2 < level.ref_11E18.setlethalonunresolvedcollision.size - 1; var_2++) {
    var_3 = var_2;
    var_4 = scripts\engine\utility::ter_op(var_3 + 1 < level.ref_11E18.setlethalonunresolvedcollision.size, var_3 + 1, 0);
    var_5 = level.ref_11E18.setlethalonunresolvedcollision[var_3];
    var_6 = level.ref_11E18.setlethalonunresolvedcollision[var_4];
    var_7 = distance(var_5, var_6);
    var_8 = int(var_7 / var_0);

    if(var_8 > 1) {
      var_9 = var_7 / var_8;
      var_10 = vectorNormalize(var_6 - var_5);

      for(var_11 = 1; var_11 < var_8; var_11++) {
        var_12 = var_5 + var_10 * var_11 * var_9;
        var_1[var_1.size] = var_12;
      }
    }

    var_1[var_1.size] = level.ref_11E18.setlethalonunresolvedcollision[var_4];
  }

  level.ref_11E18.setlethalonunresolvedcollision = var_1;
}

function set_player_hurt_trigger() {
  var_0 = level.ref_11E18.setincomingremovedcallback;
  set_maze_ai_stealth_settings(0);
  var_0.chopper_carepackage = undefined;
  set_distances_for_groups(var_0);

  for(;;) {
    if(score_message()) {
      waitframe();
      continue;
    }

    var_1 = sat_computer_think_new();

    if(isDefined(var_0.ref_12930) && !sales_discount()) {
      [[var_0.ref_12930]](var_0);
    } else if(var_1 == 14 && !sales_discount()) {
      gstatetalk(var_0);
    } else if(var_1 == 15 && !sales_discount()) {
      gstatetalkwait(var_0);
    } else if(isDefined(var_0.vo_one_remain) && !sales_discount()) {
      set_relic_grounded(var_0, 12, 0);
      set_relic_aggressive_melee_params(var_0);
    } else if(var_1 == 12) {
      set_relic_aggressive_melee(var_0);
      set_relic_doubletap(var_0);
    } else if(ginwalkingstate()) {
      if(score_event_kill(var_0)) {
        set_relic_grounded(var_0, 12, 1);
        set_player_munition_currency(var_0);
      } else {
        set_relic_dfa(var_0);
      }
    } else if(var_1 == 6) {} else if(var_1 == 5) {
      set_relic_amped(var_0);
    } else if(var_1 == 7) {
      set_player_munition_currency(var_0);
      set_relic_bang_and_boom(var_0);
    } else {
      var_2 = gismovingtocircle(var_0) && !ghasreachedcircle(var_0);
      set_relic_focus_fire(var_0, var_2);
    }

    waitframe();
  }
}

function set_player_munition_currency(var_0) {
  var_1 = sandboxprintlinebold(var_0);
  level.ref_11E18.setlastdroppableweaponobj = var_1;

  if(gismovingtocircle(var_0) && ghasreachedcircle(var_0)) {
    gsetmovetocircle(var_0, undefined);
  }

  if(sales_discount()) {
    set_relic_headbullets();
    return;
  }
}

function set_relic_aggressive_melee(var_0) {
  if(istrue(var_0.tofinalnode)) {
    return;
  }

  if(isDefined(level.ref_11E18.score_event_headshot) && !sales_discount()) {
    var_1 = level.ref_11E18.setlethalonunresolvedcollision[level.ref_11E18.score_event_headshot];

    if(update_volume_flag(var_1)) {
      var_2 = set_minigun_target_loc(var_0, level.ref_11E18.score_event_headshot);
      var_3 = var_2[0];
      var_4 = var_2[1];
      var_5 = var_2[2];
      var_2 = undefined;

      if(isDefined(var_4)) {
        gupdateintelcrates(level.ref_11E18.score_event_headshot, var_4);
      }

      level.ref_11E18.score_event_headshot = var_4;
    }

    if(isDefined(level.ref_11E18.score_event_headshot) && level.ref_11E18.setlastdroppableweaponobj != level.ref_11E18.score_event_headshot && !score_init(var_0, level.ref_11E18.score_event_headshot)) {
      var_0.linked_mover = !var_0.linked_mover;
    }
  }

  if(!sales_discount()) {
    var_6 = set_minigun_target_loc(var_0);
    var_3 = var_6[0];
    var_4 = var_6[1];
    var_5 = var_6[2];
    var_6 = undefined;

    if(var_5 || score_event_nuked(var_0)) {
      if(level.ref_11E18.setlastdroppableweaponobj == var_4) {
        var_4 = undefined;
      }

      gsetmovetocircle(var_0, var_4);
      var_0.tofinalnode = var_5;

      if(var_3) {
        var_0.linked_mover = !var_0.linked_mover;
        return;
      }

      return;
    }

    return;
  }
}

function set_distances_for_groups(var_0) {
  var_0.nodeidle = 0;
  var_0.ref_11EA7 = 0;
}

function set_relic_doubletap(var_0) {
  if(sendendofmatchdata(var_0)) {
    set_distances_for_groups(var_0);

    if(gismovingtocircle(var_0)) {
      set_maze_ai_stealth_settings(5);
      return;
    }

    set_maze_ai_stealth_settings(0);
    return;
  }

  if(!istrue(var_0.tofinalnode) && tisreadytotalk(var_0)) {
    var_0.talknexttime = gettime() + getdvarint("scr_br_mxp_next_talk", 40000);
    set_maze_ai_stealth_settings(14);
    waitandstartparachuteoverheadmonitoring(9);
    return;
  }

  if(istrue(var_0.tofinalnode)) {
    var_0.ref_11EA7 = 0;
  }

  if(tcanrandomkillstreak(var_0) && randomfloat(1) <= level.ref_11E18.select_bunker_courtyard_spawners) {
    set_relic_doubletap_params_internal(var_0);
    return;
  }

  var_0.ref_11EA7 = 1;
  set_relic_doubletap_params(var_0);
}

function gsetmovetocircle(var_0, var_1) {
  var_0.chopper_carepackage = var_1;
}

function gismovingtocircle(var_0) {
  return isDefined(var_0.chopper_carepackage);
}

function ghasreachedcircle(var_0) {
  return var_0.chopper_carepackage == level.ref_11E18.setlastdroppableweaponobj;
}

function sendendofmatchdata(var_0) {
  if(getdvarint("scr_br_mxp_g_force_stay", 0) > 0) {
    set_distances_for_groups(var_0);
    return false;
  }

  if(sales_discount()) {
    return true;
  } else if(istrue(var_0.tofinalnode)) {
    return gismovingtocircle(var_0);
  } else if(gismovingtocircle(var_0)) {
    return true;
  } else if(score_event_nuked(var_0)) {
    return false;
  } else if(tisreadytotalk(var_0)) {
    return false;
  } else if(score_event_fob_cleared() && !positioncheck(var_0)) {
    return true;
  } else if(!score_event_fob_cleared() && (var_0.nodeidle || var_0.ref_11EA7)) {
    return true;
  }

  return false;
}

function send_wave_spawns_to_roof(var_0) {
  if(score_event_fob_cleared() && positioncheck(var_0)) {
    var_1 = sandbox_safe_area();

    if(isDefined(var_1)) {
      return true;
    }
  }

  return false;
}

function positioncheck(var_0) {
  if(score_event_fob_cleared()) {
    return (level.ref_11E18.score_event_headshot == level.ref_11E18.setlastdroppableweaponobj);
  }

  return false;
}

function score_event_fob_cleared() {
  if(isDefined(level.ref_11E18.score_event_headshot)) {
    return true;
  }

  return false;
}

function isintelcratevalid(var_0) {
  return isDefined(var_0) && isDefined(var_0.trial_flares) && isDefined(var_0.trial_flares.type) && isDefined(var_0.trial_flares.index) && isDefined(var_0.trial_flares.expiretime);
}

function sandbox_safe_area() {
  foreach(var_1 in level.train_hurt_damage_watcher) {
    if(isintelcratevalid(var_1) && var_1.trial_flares.type == "g" && var_1.trial_flares.index == level.ref_11E18.setlastdroppableweaponobj && gettime() >= var_1.trial_flares.expiretime) {
      return var_1;
    }
  }
}

function sandbox_safe_area_count() {
  foreach(var_1 in level.train_hurt_damage_watcher) {
    if(isintelcratevalid(var_1) && var_1.trial_flares.type == "g" && var_1.trial_flares.index == level.ref_11E18.setlastdroppableweaponobj) {
      return var_1;
    }
  }
}

function gupdateintelcrates(var_0, var_1) {
  foreach(var_3 in level.train_hurt_damage_watcher) {
    if(isintelcratevalid(var_3) && var_3.trial_flares.type == "g" && var_3.trial_flares.index == var_0) {
      var_3.trial_flares.index = var_1;
    }
  }
}

function score_event_nuked(var_0) {
  if(update_volume_flag(var_0.origin) && !gismovingtocircle(var_0)) {
    return true;
  }

  if(gismovingtocircle(var_0)) {
    if(istrue(var_0.tofinalnode)) {
      return false;
    } else if(ghasreachedcircle(var_0)) {
      return false;
    }

    var_1 = level.ref_11E18.setlethalonunresolvedcollision[var_0.chopper_carepackage];

    if(update_volume_flag(var_1)) {
      return true;
    }

    if(!score_event_turret_killed(var_0)) {
      return true;
    }
  }

  return false;
}

function score_event_turret_killed(var_0) {
  return score_init(var_0, var_0.chopper_carepackage);
}

function score_init(var_0, var_1) {
  var_2 = level.ref_11E18.setlastdroppableweaponobj - var_1;

  if(abs(var_2) > 0) {
    var_3 = 0;
    var_4 = 0;

    if(var_2 > 0) {
      var_3 = var_2;
      var_4 = level.ref_11E18.setlethalonunresolvedcollision.size - level.ref_11E18.setlastdroppableweaponobj + var_1;
    } else {
      var_4 = 0 - var_2;
      var_3 = level.ref_11E18.setlethalonunresolvedcollision.size - var_1 + level.ref_11E18.setlastdroppableweaponobj;
    }

    if(var_3 < var_4 && var_0.linked_mover) {
      return true;
    } else if(var_4 < var_3 && !var_0.linked_mover) {
      return true;
    }
  }

  return false;
}

function set_minigun_target_loc(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level.ref_11E18.setlastdroppableweaponobj;
  }

  var_2 = var_1;
  var_3 = var_1;

  for(var_4 = 0; var_4 < level.ref_11E18.setlethalonunresolvedcollision.size; var_4++) {
    var_2 = sandboxprintlinebold(var_0, var_2);
    var_5 = level.ref_11E18.setlethalonunresolvedcollision[var_2];

    if(!update_volume_flag(var_5)) {
      return [0, var_2, 0];
    }

    var_3 = sandboxprintlineboldwait(var_0, var_3);
    var_6 = level.ref_11E18.setlethalonunresolvedcollision[var_3];

    if(!update_volume_flag(var_6)) {
      return [1, var_3, 0];
    }
  }

  var_7 = undefined;
  var_8 = 0;

  if(isDefined(level.ref_11BCE) && isDefined(level.ref_11BCE.ref_12E2C)) {
    var_7 = level.ref_11BCE.ref_12E2C.score_event_civilian_killed;

    if(var_7 == var_1) {
      var_7 = var_1;
    } else {
      var_2 = var_1;
      var_3 = var_1;

      for(var_4 = 0; var_4 < level.ref_11E18.setlethalonunresolvedcollision.size; var_4++) {
        var_2 = sandboxprintlinebold(var_0, var_2);
        var_5 = level.ref_11E18.setlethalonunresolvedcollision[var_2];

        if(var_2 == var_7) {
          break;
        }

        var_3 = sandboxprintlineboldwait(var_0, var_3);

        if(var_3 == var_7) {
          var_8 = 1;
          break;
        }
      }
    }
  }

  return [var_8, var_7, 1];
}

function set_maze_ai_stealth_settings(var_0) {
  level.ref_11E18.setincomingremovedcallback.state = var_0;
}

function sat_computer_think_new() {
  return level.ref_11E18.setincomingremovedcallback.state;
}

function ginnodestate() {
  var_0 = sat_computer_think_new();
  return var_0 == 0 || var_0 == 12;
}

function score_event_enemy_killed() {
  return sat_computer_think_new() == 9;
}

function ginwalkingstate() {
  var_0 = sat_computer_think_new();
  return var_0 == 2 || var_0 == 3;
}

function sandbox_combat_area_bits(var_0) {
  var_1 = sandboxprintlinebold(var_0);
  var_2 = level.ref_11E18.setlethalonunresolvedcollision[var_1];
  var_3 = distance2d(var_2, var_0.origin);
  return var_3;
}

function gmonitorgoal(var_0) {
  var_0 notify("goal_stopped");
  var_0 endon("goal_stopped");
  var_0 endon("walk_cycle_done");

  for(;;) {
    if(score_event_kill(var_0)) {
      var_0 notify("goal_reached");
      set_relic_grounded(var_0, 12, 1);
      set_player_munition_currency(var_0);
      return;
    }

    waitframe();
  }
}

function score_event_kill(var_0) {
  var_1 = 100;
  var_2 = sandboxprintlinebold(var_0);
  var_3 = level.ref_11E18.setlethalonunresolvedcollision[var_2];
  var_4 = distance2d(var_0.origin, var_3);

  if(var_4 <= level.ref_11E18.ggoaldist) {
    return true;
  }

  var_5 = level.ref_11E18.setlethalonunresolvedcollision[level.ref_11E18.setlastdroppableweaponobj];
  var_6 = var_3 - var_5;
  var_7 = var_3 - var_0.origin;
  var_8 = vectordot(var_6, var_7);
  return var_8 <= 0;
}

function set_relic_doubletap_params_internal(var_0) {
  var_1 = tgetnextangertarget(var_0);

  if(!isDefined(var_1)) {
    if(send_wave_spawns_to_roof(var_0)) {
      var_1 = sandbox_safe_area();
    }

    if(!isDefined(var_1)) {
      var_1 = var_0 scripts\mp\gametypes\_mxp_target::pristinestatehealthadd(level.ref_11E18.wait_for_player_to_getup, level.ref_11E18.wait_for_players_init_puzzle);
    }
  } else {
    tremoveangertarget(var_0, var_1);
  }

  jumpiffalse(isDefined(var_1)) LOC_0000007e;
  var_2 = randomizeattacklocation(var_1.origin, level.ref_11E18.gsmallkillstreakradius);
  var_3 = vectortoangles(var_2 - var_0.origin);
  goto LOC_000000c2;
}

function randomizeattacklocation(var_0, var_1) {
  var_2 = randomfloat(var_1 * 0.8);
  var_3 = randomfloatrange(-180, 180);
  var_4 = (0, var_3, 0);
  var_5 = anglesToForward(var_4);
  return var_0 + var_5 * var_2;
}

function set_pressure_stability_reading(var_0, var_1) {
  var_2 = vectortoangles(var_1.origin - var_0.origin);
  var_3 = _getrandomlocations::serverroomdogtagrevive(var_1.origin, var_2);
}

function update_volume_flag(var_0) {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return false;
  }

  return !scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_0);
}

function updateachievementhangtime(var_0) {
  return !updaterespawnstatus(var_0);
}

function updaterespawnstatus(var_0) {
  var_1 = relic_steelballs_stump_monitor();
  var_2 = float(relic_team_proximity_monitor());
  var_3 = distance2dsquared(var_0, var_1);

  if(var_3 < var_2 * var_2) {
    return true;
  }

  return false;
}

function relic_steelballs_stump_monitor() {
  return level.br_level.default_class_chosen[1];
}

function relic_team_proximity_monitor() {
  return level.br_level.br_circleradii[1];
}

function set_relic_dogtags(var_0) {
  set_relic_gas_martyr(var_0);
  set_maze_ai_stealth_settings(1);
  ref_13C1D(var_0, "s4_mp_greenbay_walk_start_01");
  set_maze_ai_stealth_settings(2);
}

function set_relic_dfa(var_0, var_1) {
  var_0 endon("goal_reached");
  var_0 endon("goal_interrupted");
  thread gmonitorgoal(var_0);
  var_2 = sat_computer_think_new();
  var_3 = 1;

  if(var_2 == 2) {
    if(scripts\engine\utility::cointoss() || istrue(var_1)) {
      ref_13C1D(var_0, "s4_mp_greenbay_walk_01");
    } else {
      set_maze_ai_stealth_settings(3);

      if(var_0.linked_mover) {
        ref_13C1D(var_0, "s4_mp_greenbay_walk_right_01");
      } else {
        ref_13C1D(var_0, "s4_mp_greenbay_walk_left_01");
      }

      var_3 = 0;
    }
  } else {
    set_maze_ai_stealth_settings(2);
    ref_13C1D(var_0, "s4_mp_greenbay_walk_01");
  }

  var_0 notify("walk_cycle_done");
}

function set_relic_doomslayer(var_0) {
  var_0 notify("goal_stopped");
  ref_13C1D(var_0, "s4_mp_greenbay_walk_stop_01");
}

function set_relic_amped(var_0) {
  set_relic_gas_martyr(var_0);
  set_maze_ai_stealth_settings(5);
  ref_13C1D(var_0, "s4_mp_greenbay_dive_01");
  set_maze_ai_stealth_settings(6);
  ref_13C1C(var_0, "s4_mp_greenbay_swim_01");
  var_1 = sandboxprintlinebold(var_0);
  var_2 = level.ref_11E18.setlethalonunresolvedcollision[var_1];
  thread gstatemovetorootmotion(var_0, var_2);
}

function set_relic_bang_and_boom(var_0) {
  level notify("gStateMoveWait");
  ref_13E37(var_0);
  ref_13C1D(var_0, "s4_mp_greenbay_emerge");
  set_maze_ai_stealth_settings(12);
}

function gstatemovetorootmotion(var_0, var_1) {
  var_2 = var_0.origin;
  var_3 = distance(var_0.origin, var_1);
  var_4 = var_3 / getdvarint("scr_br_mxp_g_speed", 3000);
  ref_13BA1(var_0);
  var_0.x1fin_respawn moveTo(var_1, var_4);
  wait var_4;
  set_maze_ai_stealth_settings(7);
}

function set_relic_focus_fire(var_0, var_1) {
  if(scripts\engine\utility::cointoss() || istrue(var_1)) {
    set_relic_amped(var_0);
    return;
  }

  set_relic_dogtags(var_0);
}

function set_relic_grounded(var_0, var_1, var_2) {
  if(ginwalkingstate()) {
    set_relic_doomslayer(var_0);
  } else if(sat_computer_think_new() == 6) {
    set_relic_bang_and_boom(var_0);
  }

  set_maze_ai_stealth_settings(var_1);
}

function sat_activate(var_0, var_1) {
  var_2 = 22.5;
  var_3 = 67.5;
  var_4 = 112.5;
  var_5 = 157.5;
  var_6 = abs(var_1);
  var_7 = scripts\engine\utility::sign(var_1) < 0;

  if(var_6 <= var_2) {
    return ["", 3, 0];
  }

  if(var_6 < var_3) {
    if(var_7) {
      return ["s4_mp_greenbay_turn_r_45", 2, 45];
    }

    return ["s4_mp_greenbay_turn_l_45", 2, 45];
  }

  if(var_6 < var_4) {
    if(var_7) {
      return ["s4_mp_greenbay_turn_r_90", 3, 90];
    }

    return ["s4_mp_greenbay_turn_l_90", 3, 90];
  }

  if(var_6 < var_5) {
    if(var_7) {
      return ["s4_mp_greenbay_turn_r_135", 4.5, 135];
    }

    return ["s4_mp_greenbay_turn_l_135", 4.5, 135];
  }

  if(var_7) {
    return ["s4_mp_greenbay_turn_r_180", 5, 180];
  }

  return ["s4_mp_greenbay_turn_l_180", 5, 180];
}

function set_relic_gas_martyr(var_0) {
  var_1 = var_0.origin;
  var_2 = sandboxprintlinebold(var_0);
  var_3 = level.ref_11E18.setlethalonunresolvedcollision[var_2];
  var_4 = var_3 - var_1;
  var_5 = vectortoangles(var_4);
  var_6 = angleclamp180(var_5[1]);
  set_maze_ai_stealth_settings(13);
  set_relic_explodedmg(var_0, var_6, var_3);
}

function ggetnextindexorigin() {
  var_0 = sandboxprintlinebold(level.ref_11E18.setincomingremovedcallback);

  if(!isDefined(var_0)) {
    var_0 = level.ref_11E18.setlastdroppableweaponobj;
  }

  var_1 = level.ref_11E18.setlethalonunresolvedcollision[var_0];
  return [var_0, var_1];
}

function sandboxprintlinebold(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level.ref_11E18.setlastdroppableweaponobj;
  }

  if(!var_0.linked_mover) {
    return scripts\engine\utility::ter_op(var_1 + 1 < level.ref_11E18.setlethalonunresolvedcollision.size, var_1 + 1, 0);
  }

  return scripts\engine\utility::ter_op(var_1 - 1 >= 0, var_1 - 1, level.ref_11E18.setlethalonunresolvedcollision.size - 1);
}

function sandboxprintlineboldwait(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level.ref_11E18.setlastdroppableweaponobj;
  }

  if(!var_0.linked_mover) {
    return scripts\engine\utility::ter_op(var_1 - 1 >= 0, var_1 - 1, level.ref_11E18.setlethalonunresolvedcollision.size - 1);
  }

  return scripts\engine\utility::ter_op(var_1 + 1 < level.ref_11E18.setlethalonunresolvedcollision.size, var_1 + 1, 0);
}

function set_relic_explodedmg(var_0, var_1, var_2) {
  var_3 = var_0.angles;
  var_4 = angleclamp180(var_3[1]);
  var_5 = angleclamp180(var_1 - var_4);
  var_6 = sat_activate(var_0, var_5);
  var_7 = var_6[0];
  var_8 = var_6[1];
  var_9 = var_6[2];
  var_6 = undefined;

  if(var_7 != "") {
    ref_13C1D(var_0, var_7);
  }

  var_10 = (0, var_1, 0);
  var_0 orientmode("face point", var_2);
}

function set_relic_aggressive_melee_params(var_0) {
  var_1 = var_0.vo_one_remain;
  var_2 = -90;

  if(!var_0.linked_mover) {
    var_2 = 90;
  }

  if(isDefined(var_1.origin)) {
    var_3 = var_1.origin - var_0.origin;
    var_4 = vectortoangles(var_3);
    var_5 = var_4[1];
    var_6 = var_0.angles[1];
    var_2 = angleclamp180(var_5 - var_6);
  }

  var_7 = sat_activate(var_0, var_2);
  var_8 = var_7[0];
  var_9 = var_7[1];
  var_10 = var_7[2];
  var_7 = undefined;
  set_maze_ai_stealth_settings(11);

  if(var_8 != "") {
    ref_13C1D(var_0, var_8);
  }

  if(var_0.vo_one_remain != var_1) {
    return;
  }

  _getrandomlocations::sequence_progression(1);
  set_maze_ai_stealth_settings(8);
  var_0 setscriptablepartstate("camo", "charge");
  gplaystartaim(var_0);
  set_maze_ai_stealth_settings(9);
  var_0 setscriptablepartstate("camo", "full");
  ref_13C1B(var_0);
  gblendtoaimwait(var_1.origin);
  var_11 = set_no_crash(var_0);
  set_maze_ai_stealth_settings(10);
  thread gdisablecamo(var_0);

  if(istrue(var_11)) {
    ref_13C1D(var_0, "s4_mp_greenbay_atomic_ray_end_01");
  }

  set_maze_ai_stealth_settings(12);
}

function gdisablecamo(var_0, var_1) {
  var_0 setscriptablepartstate("camo", "discharge");
  wait 4;
  var_0 setscriptablepartstate("camo", "fadeout");
  wait 4;
  var_0 setscriptablepartstate("camo", "disabled");
}

function gblendtoaimwait(var_0) {
  set_maze_ai_state(var_0);
  wait 2;
}

function gplaystartaim() {
  var_0 = ref_13C1C("s4_mp_greenbay_atomic_ray_start_01");
  var_1 = getanimlength(var_0);
  var_2 = var_1 - 2;
  wait var_2;
}

function set_number_of_subway_cars_on_track(var_0) {
  level.ref_11E18.setincomingremovedcallback.vo_one_remain = var_0;
}

function gendkillstreak() {
  level.ref_11E18.setincomingremovedcallback.vo_one_remain = undefined;
}

function set_no_crash(var_0) {
  var_1 = undefined;
  select_woods_three_spawners(var_0);

  if(isDefined(var_0.vo_one_remain.ref_134E3)) {
    var_1 = _getrandomlocations::server_structs(var_0.vo_one_remain);
  } else {
    wait 6;
  }

  set_relic_gun_game(var_0);
  return var_1;
}

function select_woods_three_spawners(var_0) {
  var_0.breathattachent setscriptablepartstate("beam", "beam_enable");
  var_0 setscriptablepartstate("beam", "beam_enable");

  if(isDefined(var_0.vo_one_remain.start_area_fx_end)) {
    var_0.breathattachent setotherent(var_0.vo_one_remain.start_area_fx_end);
    var_0.clear_mortar_settings = playfxontagsbetweenclients(scripts\engine\utility::getfx("greenbay_beam"), var_0.clear_look_at_ent, "tag_player", var_0.vo_one_remain.start_area_fx_end, "tag_player");
    var_0.clear_mortar_settings unmarkkeyframedmover(1);
    return;
  }
}

function set_relic_gun_game(var_0) {
  var_0.breathattachent setscriptablepartstate("beam", "beam_disable");
  var_0 setscriptablepartstate("beam", "beam_disable");
  var_0.breathattachent setotherent(undefined);

  if(isDefined(var_0.clear_mortar_settings)) {
    var_0.clear_mortar_settings delete();
    return;
  }
}

function gstatetalkwait(var_0) {
  if(var_0.talkwait == 0) {
    gstateidle(var_0, "s4_mp_greenbay_idle_taunt_01");
    var_0.talkwait = 1;
    return;
  }

  gstateidle(var_0, "s4_mp_greenbay_idle_breath_01");
}

function gstateidle(var_0, var_1) {
  ref_13C1D(var_0, var_1);
}

function set_relic_doubletap_params(var_0, var_1) {
  if(!isDefined(var_0.idleindex) || var_0.idleindex + 1 >= level.ref_11E18.gidles.size) {
    var_0.idleindex = 0;
    var_0.idles = scripts\engine\utility::array_randomize(level.ref_11E18.gidles);
  } else {
    var_0.idleindex++;
  }

  var_2 = var_0.idleindex;
  var_3 = var_0.idles[var_2];
  ref_13C1D(var_0, var_3);
  var_0.nodeidle = 1;
}

function gstatetalk(var_0) {
  var_1 = level.ref_11E18.wait_for_next_hack_complete;
  var_2 = var_1.origin - var_0.origin;
  var_3 = vectortoangles(var_2);
  var_4 = angleclamp180(var_3[1]);
  set_relic_explodedmg(var_0, var_4, var_1.origin);
  var_5 = ref_13C1C(var_0, "s4_mp_greenbay_idle_bark_01");
  waitandstartparachuteoverheadmonitoring(10);
  var_1 notify("break_idle");
  ref_13ED2(var_0, var_5);
  var_0.talkwait = 0;
  set_maze_ai_stealth_settings(15);
}

function postgamehitmarkerwaittime(var_0, var_1, var_2, var_3) {
  return !score_event_enemy_killed();
}

function waitfor_trigger_near_obit() {
  if(getdvarint("scr_br_mxp_t_prematch", 0) == 0) {
    scripts\mp\flags::gameflagwait("prematch_fade_done");
  }

  var_0 = waitformeleedamage();
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_3 = var_0[2];
  var_0 = undefined;
  level.ref_11E18.wait_for_open = var_3;
  waitandstartscorepolling(var_1, var_2);
  ref_14372();
  kstartnotifywatchers();
  kspawnchallengetrigger();
  kspawnheadchallengetrigger();
  waitforgulagfightstocomplete();
}

function waitforallcrates() {
  for(;;) {
    var_0 = waitformeleedamage(0);
    var_1 = var_0[0];
    var_2 = var_0[1];
    var_3 = var_0[2];
    var_0 = undefined;
    level.ref_11E18.wait_for_open = var_3;
    waitandstartscorepolling(var_1, var_2);
    wait 1;
    var_4 = level.ref_11E18.wait_for_next_hack_complete;
    kstateplayswat(var_4, 2);
    waitframe();
    waitforremoteend(var_4);
    waitframe();
    waitfornukecarriernearlz(var_4, 84.7375);
    waitframe();
    waitforremoteend(var_4);
    waitframe();
    waitframe();
  }
}

function waitformeleedamage(var_0) {
  var_1 = randomint(level.ref_11E18.wait_for_player_eliminated.size);
  var_2 = level.ref_11E18.wait_for_player_eliminated[var_1];
  var_3 = scripts\engine\utility::ter_op(var_1 + 1 < level.ref_11E18.wait_for_player_eliminated.size, var_1 + 1, 0);
  var_4 = level.ref_11E18.wait_for_player_eliminated[var_3];
  var_5 = var_4 - var_2;
  var_6 = vectortoangles(var_5);
  var_6 = (0, var_6[1], 0);
  return [var_2, var_6, var_1];
}

function vehicle_outline_watcher() {
  var_0 = [];
  var_0[var_0.size] = (11898.5, 12257.3, 8462.71);
  var_0[var_0.size] = (20782, 29873, 3990);

  if(getdvarint("scr_br_mxp_skip_path", 0) == 0) {
    var_0[var_0.size] = (31346, 26765, 1575);
    var_0[var_0.size] = (28493, 4769, 1353);
    var_0[var_0.size] = (2088, 2904, 3354);
    var_0[var_0.size] = (7245, 21948, 6297);
  }

  level.ref_11E18.wait_for_player_eliminated = var_0;
  level.red_11e18.kpathcalderaindex = 0;
}

function vehicletrail() {
  var_0 = scripts\engine\utility::array_randomize(getarraykeys(level.ref_11E18.wait_for_player_eliminated));

  if(!isDefined(level.br_circle.dangercircleent)) {
    return [var_0[0], level.ref_11E18.wait_for_player_eliminated[var_0[0]]];
  }

  foreach(var_2 in var_0) {
    if(var_2 == level.ref_11E18.wait_for_open) {
      continue;
    }

    var_3 = level.ref_11E18.wait_for_player_eliminated[var_2];

    if(scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_3)) {
      return [var_2, var_3];
    }
  }

  return [var_0[0], level.ref_11E18.wait_for_player_eliminated[var_0[0]]];
}

function waitforgulagfightstocomplete() {
  var_0 = level.ref_11E18.wait_for_next_hack_complete;
  var_0.linked_mover = 0;
  waitandstartparachuteoverheadmonitoring(0);
  wait_in_spectate_for_time(var_0);

  for(;;) {
    var_1 = vehoccupancy_lastbctime();

    if(wait_for_morales_thanks()) {
      waitframe();
      continue;
    }

    if(isDefined(var_0.ref_12930) && !vehiclespawn_cargotruckmg()) {
      [[var_0.ref_12930]](var_0);
    } else if(var_1 == 9) {
      kstatetalkwait(var_0);
    } else if(var_1 == 10) {
      kstatetalk(var_0);
    } else if(isDefined(var_0.vo_one_remain) && !vehiclespawn_cargotruckmg()) {
      waitfornukecarriernearlz(var_0);
    } else {
      waitforoneplayernearlz(var_0);
    }

    waitframe();
  }
}

function wait_in_spectate_for_time(var_0) {
  var_0.ref_11EA4 = 0;
  var_0.nodeidle = 0;
  var_0.ref_11EA9 = 0;
  var_0.ref_11EA7 = 0;
  var_0.ref_11F40 = randomintrange(level.ref_11E18.wait_for_player_in_gas, level.ref_11E18.wait_for_player_gulag_respawn + 1);
}

function waitforoneplayernearlz(var_0) {
  if(wait_for_weapons_free(var_0)) {
    wait_in_spectate_for_time(var_0);
    waitforremoteend(var_0);
    return;
  }

  if(!level.ref_11E18.kaltcrateattack && wait_for_time_or_notify(var_0)) {
    waitforhvttrigger(var_0);
    return;
  }

  if(kreadytoswat(var_0)) {
    kstatechooseswat(var_0);
    return;
  }

  if(var_0.nodeidle && var_0.ref_11EA7) {
    var_0.nodeidle = 0;
    var_0.ref_11EA7 = 0;
  }

  var_1 = [];

  if(!var_0.nodeidle) {
    var_1[var_1.size] = ::waitforplayerstoconnect;
  }

  if(tcanrandomkillstreak(var_0)) {
    var_1[var_1.size] = ::waitforplayerstoconnect_countdown;
  }

  var_2 = 0;

  if(var_1.size > 1) {
    var_2 = randomint(var_1.size);
  }

  if(var_1.size > 0) {
    [[var_1[var_2]]](var_0);
    return;
  }

  waitforplayerstoconnect(var_0);
}

function kstatetalkwait(var_0) {
  var_0 endon("break_idle");
  kstateidle(var_0, "s4_mp_kenosha_idle_breath_01");
}

function kstatetalk(var_0) {
  var_1 = level.ref_11E18.setincomingremovedcallback;
  var_2 = var_1.origin - var_0.origin;
  var_3 = vectortoangles(var_2);
  var_4 = angleclamp180(var_3[1]);
  kstaterotate(var_0, var_4, var_1.origin);
  ref_13C1D(var_0, "s4_mp_kenosha_idle_bark_01");
  waitandstartparachuteoverheadmonitoring(0);

  if(getdvarint("scr_br_mxp_g_force_stay", 0) > 0) {
    set_maze_ai_stealth_settings(12);
    return;
  }

  set_maze_ai_stealth_settings(0);
}

function wait_for_weapons_free(var_0) {
  var_1 = kgetnextindex();

  if(vehiclespawn_cargotruckmg()) {
    return true;
  } else if(kisingas(var_0)) {
    if(isDefined(var_1)) {
      return (level.ref_11E18.wait_for_open != var_1);
    } else {
      var_2 = kgetlastindex();
      return (level.ref_11E18.wait_for_open != var_2);
    }
  } else if(wait_after_first_counter() && !vehicle_occupancy_setfriendlystatusdirty() && !kisintelcrateingas()) {
    return true;
  } else if(!wait_after_first_counter() && var_1.ref_11EA4 >= var_1.ref_11F40) {
    return (level.ref_11E18.wait_for_open != var_2);
  }

  return false;
}

function kisingas(var_0) {
  return kisindexingas(level.ref_11E18.wait_for_open);
}

function kisindexingas(var_0) {
  var_1 = level.ref_11E18.wait_for_player_eliminated[var_0];

  if(update_volume_flag(var_1)) {
    return true;
  }

  return false;
}

function waitforhvttrigger(var_0) {
  var_1 = vehiclespawninginto();

  if(isDefined(var_1)) {
    var_2 = _getrandomlocations::ref_11A9F(var_0.origin, level.ref_11E18.kgroundpoundradius, 0, 5);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange")) {
      var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](var_0.origin, level.ref_11E18.kgroundpoundradius, "kenosha_strike", 0);
    }

    var_3 = var_1.origin;
    waitforplayerstoconnect(var_0);
    waitforplayerentering(var_0, var_3, var_1);
    var_2 delete();
    return;
  }
}

function vehicle_occupancy_setfriendlystatusdirty() {
  if(wait_after_first_counter()) {
    return (level.ref_11E18.wait_and_destroy == level.ref_11E18.wait_for_open);
  }

  return false;
}

function wait_after_first_counter() {
  if(isDefined(level.ref_11E18.wait_and_destroy)) {
    return true;
  }

  return false;
}

function kisintelcrateingas() {
  return kisindexingas(level.ref_11E18.wait_and_destroy);
}

function vehiclespawninginto() {
  foreach(var_1 in level.train_hurt_damage_watcher) {
    if(isintelcratevalid(var_1) && var_1.trial_flares.type == "k" && var_1.trial_flares.index == level.ref_11E18.wait_for_open && gettime() >= var_1.trial_flares.expiretime) {
      return var_1;
    }
  }

  if(level.ref_11E18.kaltcrateattack) {
    foreach(var_1 in level.train_hurt_damage_watcher) {
      if(isintelcratevalid(var_1) && var_1.trial_flares.type == "k" && gettime() >= var_1.trial_flares.expiretime) {
        return var_1;
      }
    }

    return;
  }
}

function waitandstartparachuteoverheadmonitoring(var_0) {
  level.ref_11E18.wait_for_next_hack_complete.state = var_0;
}

function vehoccupancy_lastbctime() {
  return level.ref_11E18.wait_for_next_hack_complete.state;
}

function kinjumpstate() {
  var_0 = vehoccupancy_lastbctime();
  return var_0 == 1 || var_0 == 2 || var_0 == 3;
}

function kinnodestate() {
  var_0 = vehoccupancy_lastbctime();
  return var_0 == 0;
}

function khastomoveforkillstreak() {
  if(level.ref_11E18.klimitanimspeak && level.ref_11E18.wait_for_open == level.ref_11E18.kpathcalderaindex) {
    var_0 = kgetnextindexorigin();
    var_1 = var_0[0];
    var_2 = var_0[1];
    var_0 = undefined;

    if(level.ref_11E18.wait_for_open != var_1) {
      return [1, var_1];
    }
  }

  return [0, undefined];
}

function waitfornukecarriernearlz(var_0, var_1) {
  var_2 = khastomoveforkillstreak();
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_2 = undefined;

  if(var_3) {
    waitforremoteend(var_0, var_4);
  }

  waitandstartparachuteoverheadmonitoring(5);
  var_5 = var_0.vo_one_remain;
  var_6 = randomfloatrange(-180, 180);
  var_7 = angleclamp180(var_0.angles[1]);

  if(isDefined(var_5.origin)) {
    var_8 = var_5.origin - var_0.origin;
    var_9 = vectortoangles(var_8);
    var_6 = var_9[1];
  }

  var_10 = angleclamp180(var_6 - var_7);
  var_11 = vehicleturretshootthread(var_0, var_10);
  var_12 = var_11[0];
  var_13 = var_11[1];
  var_14 = var_11[2];
  var_11 = undefined;

  if(isDefined(var_12) && var_12 != "") {
    ref_13C1D(var_0, var_12);
  } else {
    var_15 = (0, var_10, 0);
    var_0.x1fin_respawn rotateby(var_15, var_13);
  }

  if(var_0.vo_one_remain != var_5) {
    return;
  }

  ref_13C1D(var_0, "s4_mp_kenosha_stomp_attack_01");

  if(var_0.vo_one_remain != var_5) {
    return;
  }

  if(kshoulddelaykillstreak(var_0)) {
    waitforplayerstoconnect(var_0);

    if(var_0.vo_one_remain != var_5) {
      return;
    }
  }

  _getrandomlocations::vehicle_spawn_abandonedtimeoutcallback(1);

  if(var_5.change_goal_radius_weapons_free_internal == 2) {
    thread ref_13C1D(var_0);
  } else if(var_5.change_goal_radius_weapons_free_internal == 1) {
    thread ref_13C1D(var_0);
  } else {
    thread ref_13C1D(var_0);
  }

  waitbombusestart(var_0);
  waitandstartparachuteoverheadmonitoring(0);
}

function waitforplayerentering(var_0, var_1, var_2) {
  waitandstartparachuteoverheadmonitoring(8);
  var_3 = angleclamp180(var_0.angles[1]);
  var_4 = var_1 - var_0.origin;
  var_5 = vectortoangles(var_4);
  var_6 = var_5[1];
  var_7 = angleclamp180(var_6 - var_3);
  var_8 = vehicleturretshootthread(var_0, var_7);
  var_9 = var_8[0];
  var_10 = var_8[1];
  var_11 = var_8[2];
  var_8 = undefined;

  if(isDefined(var_9) && var_9 != "") {
    ref_13C1D(var_0, var_9);
  } else {
    var_12 = (0, var_7, 0);
    var_0.x1fin_respawn rotateby(var_12, var_10);
  }

  if(isDefined(var_2)) {
    thread vehicle_playerenteredtrackedlittlebird(var_0, var_2, 1);
  }

  ref_13C1D(var_0, "s4_mp_kenosha_stomp_attack_01");
  waitandstartparachuteoverheadmonitoring(0);
}

function vehicle_playerenteredtrackedlittlebird(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::waittill_notify_or_timeout("kenosha_ground_pound", 1.5);
  var_1 thread scripts\mp\gametypes\br_gametype_mendota::train_get_anim_ents_index();
}

function kshoulddelaykillstreak(var_0) {
  var_1 = gettime() - var_0.vo_one_remain.starttime;

  if(kiskillstreakplayerinitiated(var_0)) {
    return (var_1 < getdvarint("scr_br_mxp_k_ks_player_delay", 0));
  }

  return var_1 < getdvarint("scr_br_mxp_k_ks_delay", 0);
}

function kiskillstreakplayerinitiated(var_0) {
  return isDefined(var_0.vo_one_remain) && isDefined(var_0.vo_one_remain.player) && isPlayer(var_0.vo_one_remain.player);
}

function waitfor_firstgroup_killedoffenough(var_0) {
  level.ref_11E18.wait_for_next_hack_complete.vo_one_remain = var_0;
}

function kendkillstreak(var_0) {
  level.ref_11E18.wait_for_next_hack_complete.vo_one_remain = undefined;
}

function waitbombusestart(var_0) {
  if(var_0.vo_one_remain.change_goal_radius_weapons_free_internal == 2) {
    var_0 scripts\engine\utility::waittill_notify_or_timeout("kenosha_stomp", 1.5);
  } else {
    var_0 scripts\engine\utility::waittill_notify_or_timeout("kenosha_grab_rock", 1.5);
  }

  var_0 setscriptablepartstate("rumble", "medium", 0);
  _getrandomlocations::vehicle_spawn_cancelpendingrespawns(var_0.vo_one_remain);
}

function vehicleturretshootthread(var_0, var_1) {
  var_2 = 22.5;
  var_3 = 67.5;
  var_4 = 112.5;
  var_5 = 157.5;
  var_6 = abs(var_1);
  var_7 = scripts\engine\utility::sign(var_1) < 0;

  if(var_6 <= var_2) {
    return ["", 1, 0];
  }

  if(var_6 < var_3) {
    if(var_7) {
      return ["s4_mp_kenosha_turn_r_45", 2.2, 45];
    }

    return ["s4_mp_kenosha_turn_l_45", 2.2, 45];
  }

  if(var_6 < var_4) {
    if(var_7) {
      return ["s4_mp_kenosha_turn_r_90", 2.8, 90];
    }

    return ["s4_mp_kenosha_turn_l_90", 2.8, 90];
  }

  if(var_6 < var_5) {
    if(var_7) {
      return ["s4_mp_kenosha_turn_r_135", 3, 135];
    }

    return ["s4_mp_kenosha_turn_l_135", 3.3, 135];
  }

  if(var_7) {
    return ["s4_mp_kenosha_turn_r_180", 3.3, 180];
  }

  return ["s4_mp_kenosha_turn_l_180", 3.3, 180];
}

function ksetnextidle(var_0) {
  for(var_1 = 0; var_1 < level.ref_11E18.kidles.size; var_1++) {
    if(!isDefined(var_0.idleindex) || var_0.idleindex + 1 >= level.ref_11E18.kidles.size) {
      var_0.idleindex = 0;
      var_0.idles = scripts\engine\utility::array_randomize(level.ref_11E18.kidles);
    } else {
      var_0.idleindex++;
    }

    var_2 = var_0.idles[var_0.idleindex];

    if(!level.ref_11E18.klimitanimspeak || level.ref_11E18.klimitanimspeak && !issubstr(var_2, "s4_mp_kenosha_idle_knuckles")) {
      break;
    }
  }

  return var_0.idleindex;
}

function waitforplayerstoconnect(var_0, var_1) {
  var_2 = [];

  if(getdvarint("scr_br_mxp_k_look_down_enabled", 1) == 1) {
    var_2 = kenemiesnearonground(var_0);
  }

  if(var_2.size > 0) {
    var_3 = kselectlookattarget(var_0, var_2);
    var_4 = angleclamp180(var_0.angles[1]);
    var_5 = var_3.origin - var_0.origin;
    var_6 = vectortoangles(var_5);
    var_7 = var_6[1];
    var_8 = angleclamp180(var_7 - var_4);
    var_9 = vehicleturretshootthread(var_0, var_8);
    var_10 = var_9[0];
    var_11 = var_9[1];
    var_12 = var_9[2];
    var_9 = undefined;

    if(isDefined(var_10) && var_10 != "") {
      ref_13C1D(var_0, var_10);
    }

    ref_13C1D(var_0, "s4_mp_kenosha_idle_lookingdown_01");
  } else {
    var_13 = ksetnextidle(var_0);
    var_14 = var_0.idles[var_13];
    ref_13C1D(var_0, var_14);
  }

  var_0.nodeidle = 1;
  var_0.ref_11EA4++;
}

function kstateidle(var_0, var_1) {
  ref_13C1D(var_0, var_1);
}

function kstaterotate(var_0, var_1, var_2) {
  var_3 = var_0.angles;
  var_4 = angleclamp180(var_3[1]);
  var_5 = angleclamp180(var_1 - var_4);
  var_6 = vehicleturretshootthread(var_0, var_5);
  var_7 = var_6[0];
  var_8 = var_6[1];
  var_6 = undefined;

  if(var_7 != "") {
    ref_13C1D(var_0, var_7);
  }

  var_9 = (0, var_1, 0);
  var_0 orientmode("face point", var_2);
}

function waitforremoteend(var_0, var_1) {
  waitandstartparachuteoverheadmonitoring(6);
  var_2 = var_0.origin;
  var_3 = var_0.angles;
  jumpiffalse(isDefined(var_1)) LOC_0000003a;
  var_4 = var_1;
  var_5 = level.ref_11E18.wait_for_player_eliminated[var_4];
  goto LOC_00000052;
}

function klaunchplayersduringjump() {
  var_0 = self;
  var_0 notify("kLaunchPlayersDuringJump");
  var_0 endon("kLaunchPlayersDuringJump");

  if(var_0.collisionlist.size == 0) {
    return;
  }

  var_1 = getdvarfloat("scr_br_mxp_lp_pre_jump_delay", 0.65);
  var_2 = getdvarint("scr_br_mxp_lp_check_duration", 1000);
  var_3 = getdvarint("scr_br_mxp_lp_check_radius", 550);
  var_4 = getdvarfloat("scr_br_mxp_lp_check_interval", 0.5);
  var_5 = getdvarint("scr_br_mxp_lp_speed", 5000);
  wait var_1;
  var_6 = var_0.collisionlist["head"].colliderent;
  var_7 = gettime() + var_2;

  while(gettime() < var_7) {
    var_8 = getentarrayinradius("player", "classname", var_6.origin, var_3);

    foreach(var_10 in var_8) {
      if(!isalive(var_10)) {
        continue;
      }

      var_11 = var_10 getgroundentity();

      if(isDefined(var_11) && var_11 == var_6) {
        var_10 setvelocity((0, 0, var_5));
      }
    }

    wait var_4;
  }
}

function kgetindexorigin(var_0) {
  var_1 = level.ref_11E18.wait_for_player_eliminated[var_0];
  return var_1;
}

function kgetnextindexorigin() {
  var_0 = kgetnextindex();

  if(!isDefined(var_0)) {
    var_0 = kgetlastindex();
  }

  var_1 = level.ref_11E18.wait_for_player_eliminated[var_0];
  return [var_0, var_1];
}

function kgetjumpinfo(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.jumpgravity = level.ref_11E18.kjumpgravitymax;
  var_2.jumpspeed = level.ref_11E18.kjumpspeedmin;
  var_3 = distance2dsquared(var_0, var_1);

  if(var_3 > level.ref_11E18.kjumpdistancelongsq) {
    var_2.jumpgravity = level.ref_11E18.kjumpgravitymin;
    var_2.jumpspeed = level.ref_11E18.kjumpspeedmax;
  } else if(var_3 > level.ref_11E18.kjumpdistancemidsq) {
    var_2.jumpgravity = level.ref_11E18.kjumpgravitymid;
    var_2.jumpspeed = level.ref_11E18.kjumpspeedmid;
  }

  return var_2;
}

function kstatesetindex(var_0) {
  level.ref_11E18.wait_for_open = var_0;
}

function kgetnextindex() {
  if(wait_after_first_counter() && !vehicle_occupancy_setfriendlystatusdirty() && !kisintelcrateingas()) {
    return level.ref_11E18.wait_and_destroy;
  }

  return kgetsafenode();
}

function kgetlastindex() {
  var_0 = undefined;
  var_1 = undefined;

  for(var_2 = 0; var_2 < level.ref_11E18.wait_for_player_eliminated.size; var_2++) {
    var_3 = level.ref_11E18.wait_for_player_eliminated[var_2];
    var_4 = distance2dsquared(var_3, level.grouptorewards);

    if(!isDefined(var_0) || var_4 < var_0) {
      var_0 = var_4;
      var_1 = var_2;
    }
  }

  return var_1;
}

function kgetsafenode() {
  var_0 = level.ref_11E18.wait_for_open;
  var_1 = level.ref_11E18.wait_for_open;

  for(var_2 = 0; var_2 < level.ref_11E18.wait_for_player_eliminated.size; var_2++) {
    var_0 = scripts\engine\utility::ter_op(var_0 + 1 < level.ref_11E18.wait_for_player_eliminated.size, var_0 + 1, 0);
    var_3 = level.ref_11E18.wait_for_player_eliminated[var_0];

    if(!update_volume_flag(var_3)) {
      return var_0;
    }

    var_1 = scripts\engine\utility::ter_op(var_1 - 1 >= 0, var_1 - 1, level.ref_11E18.wait_for_player_eliminated.size - 1);
    var_4 = level.ref_11E18.wait_for_player_eliminated[var_1];

    if(!update_volume_flag(var_4)) {
      return var_1;
    }
  }
}

function kenemiesinview(var_0) {
  var_1 = level.ref_11E18.wait_for_next_hack_complete gettagorigin("j_head") + (0, 0, level.ref_11E18.kswatheightoffset);
  var_2 = level.ref_11E18.kswataggroradius;
  var_3 = getentarrayinradius("player", "classname", var_1, var_2);
  var_4 = tablesort(var_1, var_2, level.ref_11E18.kswataggroheight);
  var_5 = scripts\engine\utility::array_combine(var_3, var_4);
  var_6 = [];

  foreach(var_8 in var_5) {
    var_9 = var_8.origin[2] - var_1[2];

    if(var_9 > 0 && var_9 < level.ref_11E18.kswataggroheight) {
      var_6 = var_8;
    }
  }

  return var_6;
}

function kenemiesnearonground(var_0) {
  var_1 = level.ref_11E18.wait_for_next_hack_complete gettagorigin("tag_origin");
  var_2 = level.ref_11E18.klookdownradius;
  var_3 = getentarrayinradius("player", "classname", var_1, var_2);
  var_4 = var_3;
  return var_4;
}

function kselectlookattarget(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = [];

  foreach(var_5 in var_1) {
    var_6 = var_5.origin - var_0.origin;
    var_7 = vectordot(var_2, var_6);

    if(var_7 > 0) {
      var_3 = var_5;
    }
  }

  if(var_3.size > 0) {
    return scripts\engine\utility::random(var_3);
  }

  return scripts\engine\utility::random(var_1);
}

function kisplayerorplane(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isalive(var_0) && (isPlayer(var_0) || isagent(var_0))) {
    return true;
  }

  if(var_0 scripts\mp\gametypes\br_public::nuke_vault_suicidebombers()) {
    if(var_0 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var_0 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr() || var_0 scripts\common\vehicle::ishelicopter()) {
      return true;
    }
  }

  return false;
}

function kreadytoswat(var_0) {
  if(getdvarfloat("scr_br_mxp_kk_swat_timer", 10) > 0) {
    if(isDefined(var_0.lastswattime) && gettime() - var_0.lastswattime < 10000) {
      return false;
    }
  }

  var_1 = kenemiesinview(var_0);

  foreach(var_3 in var_1) {
    if(kisplayerorplane(var_3)) {
      return true;
    }
  }

  return false;
}

function kstatechooseswat(var_0, var_1) {
  var_2 = kenemiesinview(var_0);
  var_3 = 0;
  var_4 = [];
  var_4[0] = 0;
  var_4[1] = 0;
  var_4[2] = 0;

  foreach(var_6 in var_2) {
    if(!kisplayerorplane(var_6)) {
      continue;
    }
    var_7 = level._id_11E18.wait_for_next_hack_complete.angles;
    var_8 = vectortoangles((var_6.origin[0], var_6.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
    var_9 = var_7[1] - var_8[1];
    var_10 = 0;

    if(abs(var_9) < level._id_11E18.kswatyawmid) {
      var_4[0]++;
      var_10 = var_4[0];
    } else if(var_9 < 0 - level._id_11E18.kswatyawmid && var_9 > 0 - level._id_11E18.kswatyawmax) {
      var_4[1]++;
      var_10 = var_4[1];
    } else if(var_9 > level._id_11E18.kswatyawmid && var_9 < level._id_11E18.kswatyawmax) {
      var_4[2]++;
      var_10 = var_4[2];
    }

    if(var_10 > var_3)
      var_3 = var_10;
  }

  var_12 = [];

  foreach(var_15, var_14 in var_4) {
    if(var_14 == var_3)
      var_12[var_12.size] = var_15;
  }

  if(var_12.size > 0) {
    var_16 = scripts\engine\utility::random(var_12);
    kstateplayswat(var_0, var_16);
  } else
    kstateplayswat(var_0);

  var_0.lastswattime = gettime();
}

function kstateplayswat(var_0, var_1) {
  waitandstartparachuteoverheadmonitoring(7);
  var_2 = ["s4_mp_kenosha_swat_attack_fwd_01", "s4_mp_kenosha_swat_attack_l_01", "s4_mp_kenosha_swat_attack_r_01"];
  var_3 = [5.8, 4.5, 5];

  if(!isDefined(var_1)) {
    var_1 = randomint(var_2.size);
  }

  var_4 = var_2[var_1];
  var_5 = var_3[var_1];
  ref_13C1D(var_0, var_4);
  var_0.ref_11EA9 = 1;
  var_0.ref_11EA4++;
}

function khandkilltriggers(var_0) {
  if(istrue(var_0)) {
    if(isDefined(level.ref_11E18.wait_for_next_hack_complete.triggerhandri) || isDefined(level.ref_11E18.wait_for_next_hack_complete.triggerhandle)) {
      return;
    }

    level.ref_11E18.wait_for_next_hack_complete.triggerhandri = gkkilltriggercreate(level.ref_11E18.wait_for_next_hack_complete, level.ref_11E18.kswatradius, level.ref_11E18.kswatheight, "j_mid_ri_1");
    level.ref_11E18.wait_for_next_hack_complete.triggerhandle = gkkilltriggercreate(level.ref_11E18.wait_for_next_hack_complete, level.ref_11E18.kswatradius, level.ref_11E18.kswatheight, "j_mid_le_1");
    return;
  }

  if(!isDefined(level.ref_11E18.wait_for_next_hack_complete.triggerhandri) || !isDefined(level.ref_11E18.wait_for_next_hack_complete.triggerhandle)) {
    return;
  }

  gkkilltriggerdestroy(level.ref_11E18.wait_for_next_hack_complete.triggerhandri);
  gkkilltriggerdestroy(level.ref_11E18.wait_for_next_hack_complete.triggerhandle);
}

function waitforplayerstoconnect_countdown(var_0) {
  var_1 = tgetnextangertarget(var_0);

  if(!isDefined(var_1)) {
    if(level.ref_11E18.kaltcrateattack) {
      var_1 = vehiclespawninginto();
    }

    if(!isDefined(var_1)) {
      var_1 = var_0 scripts\mp\gametypes\_mxp_target::pristinestatehealthadd(level.ref_11E18.wait_for_player_to_getup, level.ref_11E18.wait_for_players_init_puzzle);
    }
  } else {
    tremoveangertarget(var_0, var_1);
  }

  jumpiffalse(isDefined(var_1)) LOC_00000083;
  var_2 = randomizeattacklocation(var_1.origin, level.ref_11E18.waitandstartplunderpolling);
  var_3 = vectortoangles(var_2 - var_0.origin);
  goto LOC_000000b1;
}

function wait_for_time_or_notify(var_0) {
  var_1 = khastomoveforkillstreak();
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_1 = undefined;

  if(wait_after_first_counter() && vehicle_occupancy_setfriendlystatusdirty() && !var_2) {
    var_4 = vehiclespawninginto();

    if(isDefined(var_4)) {
      return true;
    }
  }

  return false;
}

function set_maze_ai_state(var_0) {
  var_1 = level.ref_11E18.setincomingremovedcallback;
  var_1.gunposeoverride_internal = "disable";
  var_1.upaimlimit = -90;
  var_1.downaimlimit = 90;
  var_1.rightaimlimit = -90;
  var_1.leftaimlimit = 90;
  var_1.aimyawspeed = 100;
  var_2 = (0, 0, 0);
  var_3 = sandbox_combat_area();
  var_4 = var_1 setaimangles(var_3, var_0, 1, var_2, 0, 0, 0);
  gsetaimstate(var_1, level.ref_11E18.gaimstate);
}

function gsetaimstate(var_0, var_1) {
  var_0 setaimstate(var_1);
}

function sandbox_combat_area(var_0) {
  var_1 = level.ref_11E18.setincomingremovedcallback.origin;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  return var_1 + (0, 0, 8100);
}

function vehiclespawn_littlebirdmg() {
  return level.ref_11E18.wait_for_next_hack_complete.origin + (0, 0, 3400);
}

function ref_13220() {
  if(!isDefined(level.agent_funcs["actor_greenbay"])) {
    level.agent_funcs["actor_greenbay"] = [];
  }

  level.agent_funcs["actor_greenbay"]["spawn"] = &scripts\mp\mp_agent::default_spawn_func;
  level.agent_funcs["actor_greenbay"]["on_damaged"] = &post_customization_func;
  level.agent_funcs["actor_greenbay"]["gametype_on_damage_finished"] = &post_get_up_animation_function;

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition["actor_greenbay"])) {
    level.agent_definition["actor_greenbay"] = [];
  }

  level.agent_definition["actor_greenbay"]["animclass"] = "greenbay";

  if(!isDefined(level.agent_funcs["actor_kenosha"])) {
    level.agent_funcs["actor_kenosha"] = [];
  }

  level.agent_funcs["actor_kenosha"]["spawn"] = &scripts\mp\mp_agent::default_spawn_func;
  level.agent_funcs["actor_kenosha"]["on_damaged"] = &vehicle_occupancy_takeriotshield;
  level.agent_funcs["actor_kenosha"]["gametype_on_damage_finished"] = &vehicle_occupancy_updateriotshield;

  if(!isDefined(level.agent_definition["actor_kenosha"])) {
    level.agent_definition["actor_kenosha"] = [];
  }

  level.agent_definition["actor_kenosha"]["animclass"] = "kenosha";
}

function spawnnewagent(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = "actor_" + var_0;
  var_8 = scripts\mp\mp_agent::getfreeagent(var_7);

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_8 scripts\mp\mp_agent::set_agent_team("team_two_hundred");
  var_8 setModel(var_1);
  var_8 show();
  var_8 spawnagent(var_2, var_3, level.agent_definition[var_7]["animclass"], var_4, var_5, undefined, 0);
  var_8.connecttime = gettime();
  var_8.agent_height = var_5;
  var_8.agent_radius = var_4;
  var_8.callback = var_0;
  var_8.asmname = var_0;
  var_8.is_scripted_agent = 1;
  var_8.scripted_mode = 1;
  var_8.ignoreall = 1;
  var_8 scripts\mp\mp_agent::set_agent_team("team_two_hundred");
  var_8 scripts\mp\mp_agent::set_agent_health(9999);
  var_8 scripts\mp\mp_agent::add_to_characters_array();
  var_8 scripts\mp\mp_agent::activateagent();
  var_8 scripts\engine\utility::set_ai_number();
  var_8 animmode("noclip");
  var_8.animationarchetype = var_0;
  var_8 scripts\asm\asm_mp::asm_init(var_0, var_0);
  var_8.intro_heli_animate_player = var_6;
  return var_8;
}

function post_customization_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(shouldignorevehicleaabbcollision(var_0, var_1, var_4)) {
    return;
  }

  if(isDefined(level.ref_11E18.setincomingremovedcallback.ref_12930) || istrue(level.ref_11E18.playerregendelayspeed)) {
    scripts\mp\gametypes\br_publicevent_fresno::sec_sys_struct_3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    return;
  }

  tagentdamaged(var_0, var_1, var_2, var_4, var_5);
}

function post_get_up_animation_function(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = 0;
}

function vehicle_occupancy_takeriotshield(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(level.ref_11E18.wait_for_next_hack_complete.ref_12930) || istrue(level.ref_11E18.playerregendelayspeed)) {
    scripts\mp\gametypes\br_publicevent_fresno::sec_sys_struct_3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    return;
  }

  tagentdamaged(var_0, var_1, var_2, var_4, var_5);
}

function vehicle_occupancy_updateriotshield(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = 0;
}

function tagentdamaged(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4) && var_4.basename == "greenbay_strike") {
    return;
  }

  var_5 = var_1;

  if(isDefined(var_1.classname) && (var_1.classname == "script_vehicle" || var_1.classname == "misc_turret")) {
    if(isDefined(var_1.owner)) {
      var_5 = var_1.owner;
    }
  }

  if(isPlayer(var_5)) {
    playerupdatetomahdamage(var_5, self, var_2, var_3, var_4, 0);
    var_5 scripts\mp\damagefeedback::updatedamagefeedback("standard", 0, 0, "standard", 0, 1);
    return;
  }
}

function playerupdatetomahdamage(var_0, var_1, var_2, var_3, var_4) {
  var_1 = modifydamagebyweapon(var_1, var_2, var_3);
  playerupdatetomahdamagechallenges(var_0, var_1, var_4);
  var_5 = self getentitynumber();
  var_6 = 0;

  if(!isDefined(var_0.playerdamage[var_5])) {
    var_0.playerdamage[var_5] = 0;
    var_6 = 1;
  }

  var_7 = int(var_0.playerdamage[var_5] / level.ref_11E18.damageperintel);
  var_8 = (var_7 + 1) * level.ref_11E18.damageperintel;
  var_9 = int(var_0.playerdamage[var_5] / level.ref_11E18.damageuntilnotice);
  var_10 = (var_9 + 1) * level.ref_11E18.damageuntilnotice;
  var_0.playerdamage[var_5] += var_1;
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("tomahDamage", int(var_0.playerdamage[var_5] / 10));

  if(var_0.playerdamage[var_5] >= var_8) {
    var_6 = 1;
  }

  if(var_6) {
    var_11 = int(var_0.playerdamage[var_5] / level.ref_11E18.damageperintel) - var_7;
    thread scripts\mp\gametypes\br_gametype_mendota::intel_collectedmisc(self, var_11, var_3.basename);
  }

  if(var_0.playerdamage[var_5] >= var_10) {
    tupdateangertarget(var_0, self, 1);
  }

  if(isPlayer(self)) {
    var_12 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_3);
    var_13 = isDefined(var_12) && var_12 == "precision_airstrike";

    if(var_13) {
      if(isDefined(self.brattractions)) {
        self.brattractions++;
        return;
      }

      return;
    }

    return;
  }
}

function modifydamagebyweapon(var_0, var_1, var_2) {
  if(var_0 > level.ref_11E18.damageperintel) {
    var_0 = level.ref_11E18.damageperintel;
  }

  var_3 = weaponclass(var_2);
  var_4 = scripts\mp\utility\weapon::getweaponrootname(var_2);
  var_5 = 0;
  var_6 = "scr_br_mxp_max_" + var_3;
  var_7 = 50;

  if(var_3 == "sniper") {
    var_7 = 150;
  } else if(var_1 == "MOD_EXPLOSIVE") {
    var_7 = level.ref_11E18.damageperintel;
  } else if(var_3 == "rocketlauncher" || issubstr(var_4, "_la_")) {
    var_7 = level.ref_11E18.damageperintel;
    var_5 = 1;
  }

  var_8 = getdvarfloat(var_6, var_7);

  if(var_8 != 0) {
    var_0 = int(min(var_0, var_8));
  }

  var_9 = "scr_br_mxp_scale_" + var_4;
  var_7 = 0;

  if(issubstr(var_4, "manual_turret_flak")) {
    if(var_1 == "MOD_EXPLOSIVE") {
      var_0 = 0;
    } else {
      var_0 = 100;
    }
  } else if(var_5) {
    var_7 = 5;
  } else if(scripts\mp\utility\weapon::update_health_on_spawn(var_2)) {
    var_7 = 0.45;
  } else {
    var_10 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_2);

    if(isDefined(var_10) && var_10 == "greenbay_strike") {
      return 0;
    }

    if(isDefined(var_10) && var_10 == "precision_airstrike") {
      var_7 = 0.6;
    }
  }

  var_11 = getdvarfloat(var_9, var_7);

  if(var_11 != 0) {
    var_0 = int(ceil(var_0 * var_11));
  }

  return var_0;
}

function playerupdatetomahdamagechallenges(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    if(var_0 == level.ref_11E18.wait_for_next_hack_complete) {
      scripts\cp\vehicles\vehicle_compass_cp::ref_1301E("mv_event_intel_4", var_1);
    } else {
      scripts\cp\vehicles\vehicle_compass_cp::ref_1301E("mv_event_intel_5", var_1);
    }

    scripts\cp\vehicles\vehicle_compass_cp::ref_1301E("mv_event_intel_6", 1);
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_1301E("mv_event_intel_1", var_1);
}

function onplayerdisconnect(var_0) {
  var_1 = var_0 getentitynumber();

  if(isDefined(level.ref_11E18.setincomingremovedcallback)) {
    level.ref_11E18.setincomingremovedcallback.angertargets[var_1] = undefined;
  }

  if(isDefined(level.ref_11E18.wait_for_next_hack_complete)) {
    level.ref_11E18.wait_for_next_hack_complete.angertargets[var_1] = undefined;
    return;
  }
}

function tgetnextangertarget(var_0) {
  if(var_0.angertargets.size > 0) {
    var_1 = var_0 scripts\engine\utility::array_sort_with_func(var_0.angertargets, &tcompareangertargets);

    foreach(var_3 in var_1) {
      if(isDefined(var_3.player)) {
        return var_3.player;
      }
    }

    return;
  }
}

function tupdateangertarget(var_0, var_1, var_2) {
  var_3 = var_1 getentitynumber();
  taddangertarget(var_0, var_1);
  var_0.angertargets[var_3].time = gettime();
  var_0.angertargets[var_3].angerlevel += var_2;
}

function taddangertarget(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(!isDefined(var_0.angertargets[var_2])) {
    var_0.angertargets[var_2] = spawnStruct();
    var_0.angertargets[var_2].player = var_1;
    var_0.angertargets[var_2].angerlevel = 0;
    return;
  }
}

function tremoveangertarget(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_0.angertargets[var_2] = undefined;
}

function tcompareangertargets(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_0.player)) {
    return 0;
  }

  if(!isDefined(var_1) || !isDefined(var_1.player)) {
    return 1;
  }

  if(var_0.angerlevel < var_1.angerlevel) {
    return 1;
  }

  if(var_0.angerlevel > var_1.angerlevel) {
    return 0;
  }

  return var_0.time > var_1.time;
}

function ref_13187(var_0, var_1) {
  var_2 = "ui_large_agent_entity_numbers";
  var_3 = 8;
  var_4 = var_3;
  var_5 = 0;

  if(var_0) {
    var_5 = var_3;
  }

  var_6 = int(pow(2, var_4)) - 1;
  var_7 = (var_1 &var_6) << var_5;
  var_8 = ~(var_6 << var_5);
  var_9 = getomnvar(var_2);
  var_10 = var_9 &var_8;
  var_11 = var_10 + var_7;
  setomnvar(var_2, var_11);
}

function playertransfertomahanger(var_0, var_1) {
  if(!level.ref_11E18.transferanger || !isDefined(var_0) || !isPlayer(var_0) || !isDefined(var_1) || var_0 == var_1) {
    return;
  }

  ttransferanger(level.ref_11E18.setincomingremovedcallback, var_0, var_1);
  ttransferanger(level.ref_11E18.wait_for_next_hack_complete, var_0, var_1);
}

function ttransferanger(var_0, var_1, var_2) {
  var_3 = var_1 getentitynumber();

  foreach(var_5 in var_0.angertargets) {
    if(isDefined(var_5) && isDefined(var_5.player) && var_5.player == var_2) {
      taddangertarget(var_0, var_1);
      var_0.angertargets[var_3].time = gettime();
      var_0.angertargets[var_3].angerlevel += var_5.angerlevel;
      tremoveangertarget(var_0, var_2);
    }
  }
}

function ____notifywatchers() {}

function kstartnotifywatchers() {
  var_0 = level.ref_11E18.wait_for_next_hack_complete;
  thread vehomn_clearleveldataforvehicle();
  thread kleaplandwatcher();
  thread kchestslamwatcher();
  thread troarwatcher();
  thread tstepwatcher();
}

function gstartnotifywatchers() {
  var_0 = level.ref_11E18.setincomingremovedcallback;
  thread gtailsmashwatcher();
  thread troarwatcher();
  thread tstepwatcher();
}

function vehomn_clearleveldataforvehicle() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("kenosha_ground_pound");
    vehomn_clearcontrols();
  }
}

function kleaplandwatcher() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("kenosha_leap_land");
    self setscriptablepartstate("rumble", "medium", 0);
  }
}

function vehomn_clearcontrols() {
  tstunplayersandremovearmor(self.origin + (0, 0, 50), level.ref_11E18.kgroundpoundradius);
  self setscriptablepartstate("rumble", "heavy", 0);
}

function kchestslamwatcher() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("kenosha_chest_slam");
    self setscriptablepartstate("rumble", "light", 0);
  }
}

function gtailsmashwatcher() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("greenbay_tail_smash");
    self setscriptablepartstate("rumble", "heavy", 0);
  }
}

function troarwatcher() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("titan_roar");
    thread troarfeedback();
    thread troarscreenfxmanager();
  }
}

function troarscreenfxmanager() {
  level endon("game_ended");
  var_0 = level.ref_11E18.kroarduration;
  var_1 = 0.25;
  var_2 = 0;
  jumpiffalse(self == level.ref_11E18.setincomingremovedcallback) LOC_00000040;
  var_0 = level.ref_11E18.groarduration;

  while(var_2 < var_0) {
    var_3 = scripts\mp\utility\player::getplayersinradius(self.origin, level.ref_11E18.theavyfeedbackrange);

    foreach(var_5 in var_3) {
      if(isalive(var_5)) {
        thread tplayroarscreenfx(var_5);
        thread screenfxendearlywatcher();
      }
    }

    wait var_1;
    var_2 += var_1;
  }
}

function tplayroarscreenfx(var_0) {
  self notify("tPlayRoarScreenFX_starting");
  self endon("tPlayRoarScreenFX_starting");
  self setscriptablepartstate("headVFX", "mendotaRoar", 0);
  scripts\engine\utility::waittill_notify_or_timeout("roar_screen_fx_end_early", var_0);
  self notify("roar_screen_fx_end");
  self setscriptablepartstate("headVFX", "neutral", 0);
}

function screenfxendearlywatcher() {
  self endon("roar_screen_fx_end");
  self endon("tPlayRoarScreenFX_starting");
  self waittill("death_or_disconnect");
  self notify("roar_screen_fx_end_early");
}

function troarfeedback() {
  if(self == level.ref_11E18.setincomingremovedcallback) {
    self setscriptablepartstate("rumble", "heavy_long", 0);
    return;
  }

  self setscriptablepartstate("rumble", "heavy", 0);
}

function tstepwatcher() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("titan_step");
    thread tstepfeedback();
  }
}

function tstepfeedback() {
  self setscriptablepartstate("rumble", "light", 0);
}

function active_healthpacks() {}

function tplaydialogforplayersinrange(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::playersincylinder(var_1, var_2);

  foreach(var_5 in var_3) {
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var_0, var_5);
  }
}

function tcanrandomkillstreak() {
  if(istrue(self.ref_11EA7)) {
    return false;
  }

  var_0 = khastomoveforkillstreak();
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_0 = undefined;

  if(var_1) {
    return false;
  }

  if(isDefined(level.br_circle.circleindex) && level.ref_11E18.trandomkillstreakcircle <= level.br_circle.circleindex) {
    self.ref_11EA7 = 1;
    return false;
  }

  return true;
}

function kspawnheadchallengetrigger() {
  var_0 = level.ref_11E18.wait_for_next_hack_complete;
  var_1 = level.ref_11E18.kheadchallengetriggerradius;
  var_2 = level.ref_11E18.kheadchallengetriggerheight;
  var_3 = "j_head";
  var_4 = var_0 gettagorigin(var_3);
  var_5 = spawn("trigger_radius", var_4, 0, var_1, var_2);
  var_5.angles = var_0 gettagangles(var_3);
  var_5 enablelinkTo();
  var_5.x1loadout = 1;
  var_5 linkTo(var_0, var_3, (0, 0, 0), (0, 0, 0));
  var_0 scripts\mp\utility\trigger::makeenterexittrigger(var_5, &k_headchallengetriggerenter, &k_headchallengetriggerexit, undefined, "k_headChallengeTriggerExit", &k_headchallengetriggerfilter);
}

function k_headchallengetriggerfilter(var_0, var_1) {
  if(isPlayer(var_0) && isalive(var_0)) {
    return false;
  }

  return true;
}

function k_headchallengetriggerenter(var_0, var_1) {
  if(!istrue(var_0.isonkkhead)) {
    var_0.isonkkhead = 1;
    thread kstandingonheadwatcher();
    return;
  }
}

function k_headchallengetriggerexit(var_0, var_1) {
  if(istrue(var_0.isonkkhead)) {
    var_0.isonkkhead = 0;
    return;
  }
}

function kstandingonheadwatcher() {
  self endon("k_headChallengeTriggerExit");
  self endon("disconnect");
  scripts\engine\utility::waittill_notify_or_timeout("death", level.ref_11E18.kstandonheadduration);
  scripts\cp\vehicles\vehicle_compass_cp::ref_12004("mv_event_intel_8");
}

function kspawnchallengetrigger() {
  var_0 = level.ref_11E18.wait_for_next_hack_complete;
  var_1 = level.ref_11E18.kchallengetriggerradius;
  var_2 = level.ref_11E18.kchallengetriggerheight;
  var_3 = "tag_origin";
  var_4 = var_0 gettagorigin(var_3);
  var_5 = spawn("trigger_radius", var_4, 0, var_1, var_2);
  var_5.angles = var_0 gettagangles(var_3);
  var_5 enablelinkTo();
  var_5.x1loadout = 1;
  var_5 linkTo(var_0, var_3, (0, 0, 0), (0, 0, 0));
  var_0 scripts\mp\utility\trigger::makeenterexittrigger(var_5, &k_challengetriggerenter, undefined, undefined, undefined, &k_challengetriggerfilter);
}

function k_challengetriggerenter(var_0, var_1) {
  var_2 = var_0 getvehicleowner();

  if(isDefined(var_2) && isPlayer(var_2)) {
    var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_12004("mv_event_intel_9");
    return;
  }
}

function k_challengetriggerfilter(var_0, var_1) {
  if(isDefined(var_0.vehiclename) && var_0.vehiclename == "veh_a10fd" && isDefined(var_0 getvehicleowner())) {
    return false;
  }

  return true;
}

function ee_spyequipmentscriptableused(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "on") {
    ee_activatespyequipment(var_0, var_3);
    return;
  }
}

function ee_activatespyequipment(var_0) {
  self setscriptablepartstate("spy_equipment", "off");

  if(isDefined(self.script_noteworthy)) {
    ee_playspyequipmentdialog(self.script_noteworthy);
  }

  thread ee_spy_equipment_cooldown();
}

function ee_playspyequipmentdialog(var_0) {
  level endon("game_ended");

  switch (var_0) {
    case "audio1":
      ee_play_dialog_and_wait("dx_brm_nvof_titan_convo_shipments_one_10");
      ee_play_dialog_and_wait("dx_brm_sci2_titan_convo_shipments_two_10");
      ee_play_dialog_and_wait("dx_brm_sci2_titan_convo_shipments_three_10");
      break;
    case "audio2":
      ee_play_dialog_and_wait("dx_brm_nvof_titan_convo_carrier_one_10");
      ee_play_dialog_and_wait("dx_brm_sci2_titan_convo_carrier_two_10");
      ee_play_dialog_and_wait("dx_brm_nvof_titan_convo_carrier_three_10");
      ee_play_dialog_and_wait("dx_brm_sci2_titan_convo_carrier_four_10");
      break;
    case "audio3":
      ee_play_dialog_and_wait("dx_brm_sci1_titan_convo_seismic_one_10");
      ee_play_dialog_and_wait("dx_brm_sci2_titan_convo_seismic_two_10");
      ee_play_dialog_and_wait("dx_brm_sci1_titan_convo_seismic_three_10");
      ee_play_dialog_and_wait("dx_brm_sci2_titan_convo_seismic_four_10");
      break;
    case "audio4":
      ee_play_dialog_and_wait("dx_brm_nvof_titan_convo_lostcontact_one_10");
      ee_play_dialog_and_wait("dx_brm_sci1_titan_convo_lostcontact_two_10");
      ee_play_dialog_and_wait("dx_brm_nvof_titan_convo_lost_contact_three_10");
      break;
    case "audio5":
      ee_play_dialog_and_wait("dx_brm_sci2_titan_convo_noescape_one_10");
      ee_play_dialog_and_wait("dx_brm_sci1_titan_convo_noescape_two_10");
      ee_play_dialog_and_wait("dx_brm_sci2_titan_convo_noescape_three_10");
      ee_play_dialog_and_wait("dx_brm_sci1_titan_convo_noescape_four_10");
      break;
  }
}

function ee_play_dialog_and_wait(var_0) {
  var_1 = lookupsoundlength(var_0);
  playsoundatpos(self.origin, var_0);
  wait var_1 / 1000;

  if(level.ref_11E18.eetimebetweendialoglines > 0) {
    wait level.ref_11E18.eetimebetweendialoglines;
    return;
  }
}

function ee_spy_equipment_cooldown() {
  self endon("death");
  wait level.ref_11E18.ee_cooldown_duration;
  self setscriptablepartstate("spy_equipment", "on");
}

function tstunplayersandremovearmor(var_0, var_1) {
  var_2 = getentarrayinradius("player", "classname", var_0, var_1);

  foreach(var_4 in var_2) {
    if(isalive(var_4)) {
      if(var_4 scripts\mp\gametypes\br_public::hasarmor()) {
        var_4 dodamage(var_4.br_armorhealth, var_0, self, self, "MOD_EXPLOSIVE", getcompleteweaponname("kenosha_strike"));
      }

      var_4 scripts\mp\weapons::setplayerstunned();
      var_4 thread scripts\mp\weapons::cleanupconcussionstun(level.ref_11E18.kgroundpoundstunduration);
      var_4 scripts\cp_mp\utility\shellshock_utility::_shellshock("concussion_grenade_mp", "stun", level.ref_11E18.kgroundpoundstunduration, 1);
    }
  }
}

function ref_13C1D(var_0) {
  var_1 = ref_13C1C(var_0);
  ref_13ED2(var_1);
}

function tplayinterruptableanim(var_0) {
  var_1 = ref_13C1C(var_0);
  var_2 = getanimlength(var_1);
  var_3 = scripts\engine\utility::waittill_notify_or_timeout_return("gk_driven_off", var_2);
  return var_3 == "timeout";
}

function ref_13C1B() {
  self asmsetstate(self.asmname, "idle_aim");
  self asmfireevent(self.asmname, "start_aim");
}

function ref_13C1C(var_0) {
  var_1 = "scripted_anim";
  var_2 = archetypegetrandomalias(self.callback, var_1, var_0, 0);
  var_3 = self getanimentry(var_1, var_2);
  self setanimstate(var_1, var_2, 1);
  thread ref_13BA6(var_0, var_3);
  return var_3;
}

function ref_13ED2(var_0) {
  var_1 = getanimlength(var_0);
  wait var_1;
}

function ref_13BA6(var_0, var_1) {
  if(!isDefined(level.ref_11E18.notetracks) || !isDefined(level.ref_11E18.notetracks[var_0])) {
    return;
  }

  foreach(var_3 in level.ref_11E18.notetracks[var_0]) {
    var_4 = getnotetracktimes(var_1, var_3);
    var_5 = getanimlength(var_1);
    thread ref_13BA7(var_3, var_5, var_4);
  }
}

function ref_13BA7(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death");
  self endon("gk_driven_off");
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in var_2) {
    var_4 = var_6 - var_3;
    wait var_1 * var_4;
    self notify(var_0);
    var_3 += var_4;
  }
}

function ref_13BA1() {
  self.x1fin_respawn.origin = self.origin;
  self.x1fin_respawn.angles = self.angles;
  self linkTo(self.x1fin_respawn, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.x1fin_respawn dontinterpolate();
}

function ref_13E37() {
  self unlink();
  self.x1fin_respawn.origin = self.origin;
  self.x1fin_respawn.angles = self.angles;
  self.x1fin_respawn dontinterpolate();
}

function tisreadytotalk(var_0) {
  if(isDefined(var_0.talknexttime) && gettime() < var_0.talknexttime) {
    return 0;
  }

  if(!ginnodestate() || !kinnodestate()) {
    return 0;
  }

  var_1 = sandbox_combat_area();
  var_2 = vehiclespawn_littlebirdmg();
  var_3 = scripts\engine\trace::create_contents(0, 1);
  var_4 = scripts\engine\trace::ray_trace_passed(var_1, var_2, [level.ref_11E18.setincomingremovedcallback, level.ref_11E18.wait_for_next_hack_complete], var_3);
  return var_4;
}

function score_message() {
  if(istrue(level.ref_11E18.ref_12212)) {
    return true;
  }

  if(getdvarint("scr_br_mxp_pause", 0)) {
    if(sales_discount()) {
      return false;
    }

    return true;
  }

  return false;
}

function wait_for_morales_thanks() {
  if(istrue(level.ref_11E18.ref_12212)) {
    return true;
  }

  if(getdvarint("scr_br_mxp_pause", 0)) {
    if(vehiclespawn_cargotruckmg()) {
      return false;
    }

    return true;
  }

  return false;
}

function sales_discount() {
  return getdvarint("scr_br_mxp_g_advance", 0) || getdvarint("scr_br_mxp_g_keep_walking", 0);
}

function set_relic_headbullets() {
  setDvar("scr_br_mxp_g_advance", 0);
}

function vehiclespawn_cargotruckmg() {
  return getdvarint("scr_br_mxp_k_advance", 0) || getdvarint("scr_br_mxp_k_keep_jumping", 0);
}

function waitforreturntobattlestance() {
  setDvar("scr_br_mxp_k_advance", 0);
}

function secretstashlootcacheused(var_0, var_1) {
  if(!isalive(var_0)) {
    return;
  }

  if(isPlayer(var_0)) {
    var_0.ref_136DC = gkgetdeathspectatepoint(var_1.ownertitan, var_0);
    var_0 method_87e1(1);
    var_0 kill(var_1.origin, var_1.ownertitan, var_1);
    return;
  }

  if(var_0 scripts\mp\gametypes\br_public::nuke_vault_suicidebombers()) {
    var_0 dodamage(var_0.health, var_1.origin, var_1.ownertitan, var_1);
    return;
  }
}

function gkgetdeathspectatepoint(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(var_0.agent_type == "actor_greenbay") {
    var_2 = 3000;
    var_3 = level.ref_11E18.setincomingremovedcallback.origin;
    var_4 = level.mapcenter - var_3;
  } else {
    var_2 = 3400;
    var_3 = level.ref_11E18.wait_for_next_hack_complete.origin;
    var_4 = var_1.origin - var_3;
  }

  var_4 = vectorNormalize((var_4[0], var_4[1], 0));
  var_5 = (var_3[0], var_3[1], var_1.origin[2]);
  var_6 = var_5 + var_4 * (var_2 + 500);
  var_7 = [var_0, var_1];
  var_8 = scripts\engine\trace::create_contents(0, 1);
  var_9 = scripts\engine\trace::ray_trace(var_5, var_6, var_7, var_8);
  var_10 = var_4 * -1;
  var_11 = var_9["position"] + var_10 * 50;
  var_12 = vectortoangles(var_10);
  var_13 = spawnStruct();
  var_13.origin = var_11;
  var_13.angles = var_12;
  return var_13;
}

function ref_13DCE() {
  self endon("destroy");
  var_0 = length2d((self.height / 2, self.radius, 0));

  for(;;) {
    if(self.classname == "trigger_rotatable_radius") {
      var_1 = anglestoup(self.angles);
    } else {
      var_1 = (0, 0, 1);
    }

    var_2 = self.origin + var_1 * self.height / 2;
    var_3 = tablesort(var_2, var_0);

    foreach(var_5 in var_3) {
      if(isDefined(var_5) && var_5 istouching(self)) {
        secretstashlootcacheused(var_5, self);
      }
    }

    waitframe();
  }
}

function kinitializeplayercollision() {
  var_0 = self;
  var_0 endon("death");
  var_0 agentsetclipmode("large");
  var_1 = 0.1;
  var_0.collisionlist = [];
  var_2 = getEntArray("kenosha_collision", "targetname");

  foreach(var_4 in var_2) {
    var_5 = "?";
    var_6 = (0, 0, 0);
    var_7 = (0, 0, 0);
    var_8 = var_4.script_noteworthy;

    if(var_8 == "head") {
      var_5 = "j_head";
      var_6 = (520, -200, 0);
      var_7 = (180, 82, 90);
    } else if(var_8 == "left_foot") {
      var_5 = "j_ankle_le";
      var_6 = (360, -230, -30);
      var_7 = (0, -30, 90);
    } else if(var_8 == "right_foot") {
      var_5 = "j_ankle_ri";
      var_6 = (340, -165, 60);
      var_7 = (0, -20, 90);
    } else if(var_8 == "left_shoulder") {
      var_5 = "j_shoulder_le";
      var_6 = (-310, 140, -20);
      var_7 = (180, 260, 110);
    } else if(var_8 == "right_shoulder") {
      var_5 = "j_shoulder_ri";
      var_6 = (300, -80, 0);
      var_7 = (180, 90, 65);
    } else if(var_8 == "torso") {
      var_5 = "j_spineupper";
      var_6 = (0, -200, 0);
      var_7 = (180, 110, 90);
    }

    var_9 = spawnStruct();
    var_9.colliderent = var_4;
    var_9.tagname = var_5;
    var_9.originoffset = var_6;
    var_9.angleoffset = var_7;
    var_0.collisionlist[var_8] = var_9;
  }

  var_11 = gkkilltriggercreate(var_0, 550, 670, "j_head", 1, (-300, 0, 0), (180, 82, 90));
  var_12 = gkkilltriggercreate(var_0, 500, 1200, "j_spineupper", 1, (800, 180, -600), (0, 0, 0));
  wait var_1;
  var_13 = gkkilltriggercreate(var_0, 400, 1600, "j_shoulder_le", 1, (-100, 0, 0), (90, 0, 0));
  var_14 = gkkilltriggercreate(var_0, 400, 1600, "j_shoulder_ri", 1, (100, 0, 0), (-90, 0, 0));
  wait var_1;
  var_15 = gkkilltriggercreate(var_0, 400, 1100, "j_elbow_le", 1, (-100, 0, 0), (90, -10, 0));
  var_16 = gkkilltriggercreate(var_0, 400, 1100, "j_elbow_ri", 1, (-100, 0, 0), (-90, -10, 0));
  wait var_1;
  var_17 = gkkilltriggercreate(var_0, 350, 1000, "j_hip_le", 1, (200, 0, 0), (90, -15, 0));
  var_18 = gkkilltriggercreate(var_0, 350, 1000, "j_hip_ri", 1, (200, 0, 0), (90, 0, 0));
  wait var_1;
  var_19 = gkkilltriggercreate(var_0, 320, 1400, "j_knee_le", 1, (-100, 100, 0), (90, 0, 0));
  var_20 = gkkilltriggercreate(var_0, 320, 1400, "j_knee_ri", 1, (-100, 100, 0), (90, 0, 0));
  wait var_1;
  var_21 = gkkilltriggercreate(var_0, 450, 120, "j_ankle_le", 1, (470, -20, 30), (0, -32, 86));
  var_22 = gkkilltriggercreate(var_0, 450, 120, "j_ankle_ri", 1, (470, 60, 30), (0, -23, 90));
  level.ref_11E18.wait_for_next_hack_complete.collisionkilltriggers = [var_11, var_12, var_13, var_14, var_15, var_16, var_13, var_14, var_19, var_20, var_21, var_22];

  if(getdvarint("scr_br_mxp_kk_back_trigger", 1)) {
    var_23 = gkkilltriggercreate(var_0, 800, 2000, "j_spinelower", 1, (-700, 0, 0), (90, 0, 0));
    level.ref_11E18.wait_for_next_hack_complete.collisionkilltriggers[level.ref_11E18.wait_for_next_hack_complete.collisionkilltriggers.size] = var_23;
  }

  var_0.collisioninitialized = 1;
  thread gkrunplayercollision(var_0);
}

function gkrunplayercollision(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 notify("gkRunPlayerCollision");
  var_1 endon("gkRunPlayerCollision");

  while(!istrue(var_1.collisioninitialized)) {
    waitframe();
  }

  jumpiffalse(var_0 == 1) LOC_00000088;

  foreach(var_3 in var_1.collisionlist) {
    var_3.colliderent unlink();
    var_3.colliderent linkTo(var_1, var_3.tagname, var_3.originoffset, var_3.angleoffset);
  }

  return;
}

function gkcalculatecolliderpositioning(var_0) {
  var_1 = self;
  var_2 = var_1 gettagorigin(var_0.tagname);
  var_3 = var_1 gettagangles(var_0.tagname);
  var_4 = var_2 + rotatevector(var_0.originoffset, var_3);
  var_5 = combineangles(var_3, var_0.angleoffset);
  return [var_4, var_5];
}

function binocularsseegk() {
  var_0 = ["physicscontents_actor", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicleclip"];
  var_1 = physics_createcontents(var_0);
  var_2 = self getvieworigin();
  var_3 = var_2 + anglesToForward(self getplayerangles()) * 50000;
  var_4 = ignore_ents_when_targetting();
  var_5 = scripts\engine\trace::ray_trace(var_2, var_3, var_4, var_1);

  if(getdvarint("scr_br_mxp_precision_target_disable", 0)) {
    return scripts\engine\utility::ter_op(var_5["hittype"] == "hittype_none", undefined, var_5["position"]);
  }

  if(var_5["hittype"] == "hittype_none") {
    return undefined;
  }

  var_6 = var_5["position"];

  if(var_5["hittype"] == "hittype_entity") {
    var_7 = var_5["entity"];

    if(isDefined(var_7) && isDefined(var_7.agent_type)) {
      if(var_7.agent_type == "actor_greenbay" || var_7.agent_type == "actor_kenosha") {
        var_6 = var_7.origin;
      }
    }
  }

  return var_6;
}

function ignore_ents_when_targetting() {
  var_0 = undefined;

  if(isDefined(self.vehicle)) {
    var_0 = [self.vehicle];
  } else {
    var_1 = self getgroundentity();

    if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      var_0 = [var_1];
    }
  }

  return var_0;
}

function shouldignorevehicleaabbcollision(var_0, var_1, var_2) {
  return var_2 == "MOD_CRUSH" && isDefined(var_1) && isDefined(var_0) && var_1 == var_0 && isDefined(var_1.vehiclename) && (var_1.vehiclename == "veh_a10fd" || var_1.vehiclename == "veh_bt" || issubstr(var_1.vehiclename, "little_bird"));
}

function activate_destructible_cinderblocks() {}