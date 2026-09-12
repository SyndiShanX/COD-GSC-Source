/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_escape.gsc
*******************************************************/

function init() {
  if(!getdvarint("scr_br_alt_mode_escape", 0)) {
    return;
  }

  ammorestock_customlocale6cleanup();
  level.obit_activation = spawnStruct();
  level.obit_activation.ref_14385 = getdvarfloat("scr_br_escape_incoming_time", 240.9);
  level.obit_activation.ref_1438F = getdvarfloat("scr_br_escape_respawn_time", -1);
  level.obit_activation.ref_129DB = getdvarfloat("scr_br_escape_radio_safe_time", 10) + level.obit_activation.ref_14385;
  level.obit_activation.ref_13B6E = getdvarfloat("scr_br_escape_time_added_when_dropped", 20);
  level.obit_activation.radiotimebonusgap = getdvarfloat("scr_br_escape_time_bonus_gap", 30);
  level.obit_activation.ref_129D7 = getdvarfloat("scr_br_escape_radio_idle_time", 45);
  level.obit_activation.unset_forced_aitype = getdvarint("scr_br_alt_mode_escape_radio_reset_enable", 0);
  level.obit_activation.ref_12C73 = getdvarint("scr_br_alt_mode_escape_radio_reset_on_oob", 1);
  level.obit_activation.escaperadioooboffset = getdvarint("scr_br_alt_mode_escape_radio_oob_offset", -15);
  level.obit_activation.unset_just_keep_moving = getdvarint("scr_br_alt_mode_escape_extended_version", 1);
  level.obit_activation.ref_129D6 = getdvarint("scr_br_alt_mode_escape_radio_delete_loot_radius", 128);
  level.obit_activation.onspawn_fastspeed = getdvarint("scr_br_alt_mode_escape_radio_xp_pickup", 900);
  level.obit_activation.onspawn_slowspeed = getdvarint("scr_br_alt_mode_escape_radio_xp_win", 15000);
  level.obit_activation.ref_129D5 = getdvarint("scr_br_alt_mode_escape_radio_circle_peek", 1);
  level.obit_activation.start_fly_over = getdvarint("scr_br_alt_mode_escape_radio_incoming_respawn_time", 30);
  level.obit_activation.personalscorecount = getdvarint("scr_br_alt_mode_escape_radio_fast_respawn_time", 10);
  level.obit_activation.ref_129D8 = getdvarint("scr_br_alt_mode_escape_radio_max_time_in_gas", 15);
  level.obit_activation.personalnukecostoverride = getdvarint("scr_br_alt_mode_escape_radio_fast_respawn_index", 5);
  level.obit_activation.obj_destroy_tanks = [];
  level.obit_activation.obj_fob1 = [];
  level.obit_activation.obj_cleanup = [];
  level.obit_activation.obj_a_covers = [];
  level.obit_activation.ref_12345 = 0;
  level.obit_activation.ref_129DA = -1;
  game["dialog"]["last_man_standing"] = "rsrg_squad_last_alive";
  game["dialog"]["rebirth_avenge_teammate"] = "rebirth_avenge_teammate";
  game["dialog"]["rebirth_redeploy"] = "rebirth_redeploy";
  game["dialog"]["rebirth_disabled"] = "rebirth_reinforcement_disabled";
  game["dialog"]["rebirth_ending"] = "rebirth_reinforcement_ending";
  game["dialog"]["rebirth_teammate_respawn"] = "rebirth_teammate_respawn";
  game["dialog"]["exit_strategy_chopper_inbound"] = "exit_strategy_chopper_inbound";
  game["dialog"]["escape_chopper_comms_online"] = "cp1_escape_chopper_comms_online";
  game["dialog"]["exit_strategy_teammate_pickup"] = "exit_strategy_teammate_pickup";
  game["dialog"]["escape_radio_picked_up_enemy"] = "escape_radio_picked_up_enemy";
  game["dialog"]["exit_strategy_less_than_4_min"] = "exit_strategy_less_than_4_min";
  game["dialog"]["exit_strategy_less_than_3_min"] = "exit_strategy_less_than_3_min";
  game["dialog"]["exit_strategy_less_than_2_min"] = "exit_strategy_less_than_2_min";
  game["dialog"]["exit_strategy_less_than_60_sec"] = "exit_strategy_less_than_60_sec";
  game["dialog"]["exit_strategy_less_than_45_sec"] = "exit_strategy_less_than_45_sec";
  game["dialog"]["exit_strategy_less_than_20_sec"] = "exit_strategy_less_than_20_sec";
  game["dialog"]["exit_strategy_less_than_10_sec"] = "exit_strategy_less_than_10_sec";
  game["dialog"]["exit_strategy_less_than_5_sec"] = "exit_strategy_less_than_5_sec";
  game["dialog"]["escape_radio_incoming"] = "escape_radio_incoming";
  game["dialog"]["escape_radio_spawned"] = "escape_radio_spawned";
  game["dialog"]["exit_strategy_radio_down"] = "exit_strategy_radio_down";
  game["dialog"]["exit_strategy_radio_strength"] = "exit_strategy_radio_strength";
  game["dialog"]["exit_strategy_radio_fixing"] = "exit_strategy_radio_fixing";
  game["dialog"]["gametype_exit_strategy"] = "gametype_exit_strategy";
  game["dialog"]["gametype_exfiltration"] = "gametype_exfiltration";
  game["dialog"]["exit_strategy_carrier_down"] = "exit_strategy_carrier_down";
  game["dialog"]["exit_strategy_carrier_hit"] = "exit_strategy_carrier_hit";
  game["dialog"]["exit_strategy_radio_carrier"] = "exit_strategy_radio_carrier";
  game["dialog"]["exit_strategy_survive"] = "exit_strategy_survive";
  game["dialog"]["exit_strategy_update_heading"] = "exit_strategy_update_heading";
  level.obit_activation.ref_13BFD = getdvarint("scr_br_alt_mode_escape_win_timer", 300.9);
  level.obit_activation.ref_145CD = level.obit_activation.ref_13BFD;
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&ref_12069);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsRespawn", &vehicle_spawn_mp_gamemodesupportsrespawn);
  scripts\mp\gametypes\br_gametypes::ref_12B11("preOnPlayerKilled", &onplayerkilled);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  scripts\mp\gametypes\br_gametypes::ref_12B11("endGame", &obit_trigger_for_player);

  if(getdvarint("scr_br_alt_mode_escape_skip_initial_circle", 0)) {
    scripts\mp\gametypes\br_gametypes::ref_12B11("createC130PathStruct", &init_relic_aggressive_melee);
    scripts\mp\gametypes\br_gametypes::ref_12B11("addToC130Infil", &being_hacked);
  }

  scripts\mp\gametypes\br_gametypes::ref_12B10("dropBagDelay", 180);

  if(getdvarint("scr_br_escape_alt_respawn_system_enable", 0) == 0) {
    if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("gulag")) {
      level scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
    }

    level.usegulag = 0;
    level.obit_activation.ref_121AD = 3;
    level thread scripts\mp\gametypes\br_gametype_rebirth::enabledskiplaststand();
  } else {
    level.disable_super_in_turret.ref_12CA4 = 1;
    level.disable_super_in_turret.fly_to_laser_trap_start_pos = 1;
    level.disable_super_in_turret.ref_14081 = 1;
    scripts\mp\gametypes\br_gametype_rebirth::end_reach_icbm_launch();
    var_0 = 30;
    level.disable_super_in_turret.ref_12A7B = var_0;
    level.playingtutorialdialogue["mayConsiderPlayerDead"] = &scripts\mp\gametypes\br_gametype_rebirth::empty_function;
    level.playingtutorialdialogue["triggerRespawnOverlay"] = &scripts\mp\gametypes\br_gametype_rebirth::end_silo_thrust;
    level.playingtutorialdialogue["playerNakedDropLoadout"] = &scripts\mp\gametypes\br_gametype_rebirth::end_intro_obj;
    level.playingthrowingknifewickfx["mayConsiderPlayerDead"] = &scripts\mp\gametypes\br::dynamic_door;
    level.playingthrowingknifewickfx["triggerRespawnOverlay"] = &scripts\mp\gametypes\br_gulag::ref_13DCC;
    level.playingthrowingknifewickfx["playerNakedDropLoadout"] = &scripts\mp\gametypes\br::ref_11E23;
    scripts\mp\gametypes\br_gametypes::ref_12B11("mayConsiderPlayerDead", &add_pack_playeranim);
    scripts\mp\gametypes\br_gametypes::ref_12B11("triggerRespawnOverlay", &add_pilot_setup);
    scripts\mp\gametypes\br_gametypes::ref_12B11("playerNakedDropLoadout", &add_pack_startfunc);
  }

  level.nosuspensemusic = 1;
  level.ref_11E96 = 1;
  level.ref_1205E = &ref_131A9;
  thread ai_hold_wake_watch();
  thread anyone_can_see_spawner();
  thread ammoids();
  level.ref_13364 = 1;
  level.disable_super_in_turret.loadoutrestore = getdvarint("scr_br_loadout_restore_on_respawn", 1);
  level.ref_133EA = getdvarint("scr_bmo_skipWeaponDropOnDeath", 0);
}

function updatenukeprogress(var_0) {
  if(!isDefined(level.obit_activation.radio) || !isDefined(level.obit_activation.radio.ownerteam)) {
    return false;
  }

  return var_0.team == level.obit_activation.radio.ownerteam;
}

function addtodismembermentlist(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::getteamdata(var_0.team, "players")) {
    var_3 = !isalive(var_2);

    if(var_2 != var_0 && var_3) {
      var_2 notify("force_stop_respawn");
      var_2 scripts\mp\gametypes\br_gametype_rebirth::end_ml_p3_exfil();
    }
  }
}

function add_pack_playeranim(var_0) {
  var_1 = "mayConsiderPlayerDead";

  if(updatenukeprogress(var_0) && isDefined(level.playingtutorialdialogue[var_1])) {
    if(level.obit_activation.radio.owner == var_0) {
      addtodismembermentlist(var_0);
      return [[level.playingthrowingknifewickfx[var_1]]](var_0);
    } else {
      return [[level.playingtutorialdialogue[var_1]]](var_0);
    }
  } else if(isDefined(level.playingthrowingknifewickfx[var_1])) {
    return [[level.playingthrowingknifewickfx[var_1]]](var_0);
  }

  return undefined;
}

function add_pilot_setup() {
  return ref_12182("triggerRespawnOverlay");
}

function add_pack_startfunc() {
  return ref_12182("playerNakedDropLoadout");
}

function ref_12182(var_0) {
  var_1 = self;

  if(updatenukeprogress(var_1) && level.obit_activation.radio.owner != var_1 && isDefined(level.playingtutorialdialogue[var_0])) {
    return [[level.playingtutorialdialogue[var_0]]]();
  }

  if(isDefined(level.playingthrowingknifewickfx[var_0])) {
    return [[level.playingthrowingknifewickfx[var_0]]]();
  }
}

function ai_hold_wake_watch() {
  if(level.obit_activation.ref_129DA == -1) {
    level waittill("prematch_fade_done");
    waitframe();

    if(!istrue(level.br_circle_disabled)) {
      while(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent)) {
        waitframe();
      }
    }

    _escaperadiologic(1);
    return;
  }

  _escaperadiologic(4);
}

function _escaperadiologic(var_0) {
  var_1 = obj_a_post_behavior();
  level.obit_activation.radio = ai_goto_ascender_and_wait(var_1 + (0, 0, 10), var_0);
  thread obj_fob1_juggs(level);
  ai_dropgren_override_hide();
  scripts\mp\flags::gameflagwait("br_ready_to_jump");
  ai_give_flashlight(var_0);
  thread obit_destroy_old_vehicles(level, level.obit_activation.radio);
}

function ammorestock_customlocale6cleanup() {
  if(!getdvarint("scr_br_alt_mode_escape_skip_initial_circle", 0)) {
    return;
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizeCircleCenter");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("planeSnapToOOB");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("planeUseCircleRadius");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
}

function init_relic_aggressive_melee() {
  var_0 = (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], 0);
  var_1 = level.br_level.br_circleradii[1];
  var_2 = scripts\mp\gametypes\br_c130::createtestc130path(var_0, var_1);
  return var_2;
}

function being_hacked() {
  thread vehomn_getleveldata();
}

function vehomn_getleveldata() {
  level endon("game_ended");
  self endon("death");
  var_0 = distance(self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor);
  var_1 = var_0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
  wait var_1;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == "c130" && !isDefined(var_3.jumptype)) {
      var_3.jumptype = "outOfBounds";
      var_3 notify("halo_kick_c130");
    }
  }
}

function ammoids() {
  if(!getdvarint("scr_br_alt_mode_escape_skip_initial_circle", 0)) {
    return;
  }

  waittillframeend();
  level.br_level.br_circledelaytimes[1] = level.br_level.br_circledelaytimes[0];
  level.br_level.br_circledelaytimes[0] = 1;
  level.br_level.br_circleclosetimes[0] = 1;
  level.br_level.default_player_connect_black_screen[0] = 1;
}

function obj_fob2(var_0) {
  level endon("game_ended");
  scripts\mp\gametypes\br_public::brleaderdialog("gametype_exfiltration", 0, var_0);
  wait 1.5;
  scripts\mp\gametypes\br_public::brleaderdialog("gametype_exit_strategy", 0, var_0);
}

function obj_fob1_juggs(var_0) {
  level endon("radio_debug_spawned");

  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    var_1 = [1000, 3000, 5000, 7000, 13000];
    var_2 = [0, 30, 90, 120, 180];
  } else {
    var_1 = [3000, 7000, 10000, 13000, 17500];
    var_2 = [0, 45, 90, 135, 180];
  }

  level.obit_activation.ref_129D4 = gettime() + level.obit_activation.ref_14385 * 1000;
  var_3 = level.obit_activation.ref_14385;
  var_4 = undefined;
  var_5 = -1;

  if(level.obit_activation.ref_14385 > var_2[4]) {
    var_5 = 4;
  } else if(level.obit_activation.ref_14385 > var_2[3]) {
    var_5 = 3;
  } else if(level.obit_activation.ref_14385 > var_2[2]) {
    var_5 = 2;
  } else if(level.obit_activation.ref_14385 > var_2[1]) {
    var_5 = 1;
  } else if(level.obit_activation.ref_14385 > var_2[0]) {
    var_5 = 0;
  }

  jumpiffalse(var_5 < 0) LOC_00000122;
  wait 3;

  while(var_5 >= 0) {
    var_3 -= var_2[var_5];
    ai_ascender_giveascender(var_2, var_1[var_5]);
    scripts\mp\flags::gameflagwait("br_ready_to_jump");

    if(var_5 == 0) {
      ai_fire_at_chopper(var_2[1]);
      var_4 = scripts\engine\utility::play_loopsound_in_space("iw8_nuke_alarm_lp", var_2.origin);
    }

    var_6 = ai_ascender_getclosestdescender(var_3);

    if(!isDefined(var_6)) {
      var_5 = 0;
    }

    ai_ascender_getstartpos(var_2);
    var_3 = var_2[var_5];
    var_5--;
  }

  ai_ascender_getstartpos(var_2);

  if(isDefined(var_4)) {
    var_4 delete();
  }

  level.obit_activation.ref_129DA = 1;
  level notify("radio_landed");
}

function obit_destroy_old_vehicles(var_0, var_1) {
  level endon("game_ended");
  level endon("radio_debug_spawned");

  foreach(var_3 in level.players) {
    if(!var_3 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      var_3 scripts\mp\hud_message::showsplash("br_escape_radio_incoming");
    }
  }

  var_5 = 255;
  var_6 = level.obit_activation.ref_14385;
  var_7 = level.obit_activation.ref_14385;
  ai_extra_think(var_1, var_5, var_6, 0);
  ai_fire_at_chopper(var_7);
  level waittill("radio_landed");

  foreach(var_3 in level.players) {
    if(!var_3 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      var_3 scripts\mp\hud_message::showsplash("br_escape_radio_dropped");
    }
  }

  obj_hvt_dead("escape_radio_spawned", 0.75, 1);
  ai_dropgren_override_hide();
  ai_hold_wake_behavior(var_0, "on_ground");
  ai_goal_distribution_debug(var_0);
  var_1 = 2;
  var_5 = 255;
  var_6 = level.obit_activation.ref_13BFD;
  var_7 = level.obit_activation.ref_145CD;
  level.obit_activation.radio.waittime = var_7;
  ai_extra_think(var_1, var_5, var_6);
  ai_fire_at_chopper(var_7, 1);
  ai_deaf_event_active(level, var_0.origin);
}

function ai_ascender_getclosestdescender(var_0) {
  return level.obit_activation scripts\engine\utility::waittill_notify_or_timeout_return("force_incoming", var_0);
}

function obj_a_roof_jugg() {
  if(!isDefined(level.br_level) || !isDefined(level.br_level.br_circledelaytimes)) {
    return 0;
  }

  var_0 = level.br_level.delay_start_infiltrate_objective;

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = 0;

  if(level.obit_activation.unset_just_keep_moving) {
    var_1 = getdvarint("scr_br_escape_start_circles_remaining", 6);
  } else {
    var_1 = getdvarint("scr_br_escape_start_circles_remaining", 3);
  }

  var_2 = level.br_level.br_circledelaytimes.size - 1 - var_1 - var_0;
  return var_2;
}

function relic_amped_victim(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level.br_level.br_circledelaytimes.size && var_2 < var_0; var_2++) {
    var_1 += level.br_level.br_circledelaytimes[var_2] + level.br_level.br_circleclosetimes[var_2];
  }

  return var_1;
}

function obj_a_post_behavior() {
  var_0 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_1 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_2 = ref_11A00(var_0, var_1);
  var_3 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("escape", var_2);
  var_4 = undefined;
  var_5 = "none";

  if(isDefined(var_3)) {
    var_4 = var_3.origin;
    var_5 = "chest";
  } else {
    var_6 = 0;
    var_7 = 1;
    var_8 = 1;
    var_9 = 1;
    var_10 = 1;
    var_11 = level.obit_activation.ref_129DB;
    var_4 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_0, var_1, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_4 == var_0) {
      var_12 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
      var_4 = scripts\engine\utility::drop_to_ground((var_4[0], var_4[1], 4000), undefined, undefined, undefined, var_12);

      if(var_9 && isscriptabledefined()) {
        var_4 = getclosestpointonnavmesh(var_4);
      }
    }

    var_5 = "random";
  }

  logstring("Escape Mode: Circle o:" + var_0 + " r:" + var_1 + " Radio o:" + var_4 + " t:" + var_5);
  return var_4;
}

function obj_heli_assault3_fob(var_0) {
  var_1 = self.tracknonoobplayerlocation;
  level endon("game_ended");
  level endon("force_end");
  level notify("radio_state_change");
  var_1 endon("death");
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(var_4.team == var_0.team) {
      if(var_4 == var_0) {
        level thread scripts\mp\gametypes\br_quest_util::ref_140B1(var_0.origin, "revive");
        thread ai_dropgren_override_hint(var_4, "escape_chopper_comms_online");
        var_4 scripts\mp\hud_message::showsplash("br_escape_radio_picked_up_self");
        thread ai_dropgren_weapontype(var_4, "exit_strategy_survive", 0.75);
      } else {
        if(!var_4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
          thread ai_dropgren_override_hint(var_4, "escape_chopper_comms_online");
        }

        var_4 scripts\mp\hud_message::showsplash("br_escape_radio_picked_up_ally");
        thread ai_dropgren_weapontype(var_4, "exit_strategy_teammate_pickup", 0.75);
        var_5 = scripts\mp\gametypes\br_vip_quest::ref_142C5(var_4, var_0, "exfil_respawn");

        if(var_5 && !var_2) {
          var_2 = 1;
          var_0 thread scripts\mp\hud_message::showsplash("br_squadmate_revived");
        }
      }

      continue;
    }

    if(!var_4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      thread ai_dropgren_override_hint(var_4, "escape_chopper_comms_online");
      var_4 scripts\mp\hud_message::showsplash("br_escape_radio_picked_up_enemy");
      thread ai_dropgren_weapontype(var_4, "escape_radio_picked_up_enemy", 0.75);
    }
  }

  ai_hold_positions_freed(var_1);
  ai_hold_wake_behavior(var_1, "picked_up", var_0);
  ai_dismount_turret(var_1);
  var_1.owner = var_0;
  var_1.ref_121AE = var_1.ownerteam;
  var_1.ownerteam = var_1.owner.team;
  var_7 = scripts\mp\utility\teams::getteamdata(var_1.ownerteam, "players");
  managekingflag(var_7, 1);
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("br_escape_radio_looted");

  if(level.obit_activation.onspawn_fastspeed > 0) {
    setteamscore(var_1.ownerteam, getteamscore(var_1.ownerteam) + level.obit_activation.onspawn_fastspeed);
  }

  level.obit_activation.ref_12345 = gettime();
  ai_dropgren_override_hide();
  var_8 = 3;
  var_9 = var_0 getentitynumber();
  var_10 = level.obit_activation.ref_13BFD;
  var_11 = level.obit_activation.ref_145CD;
  ai_extra_think(var_8, var_9, var_10, 0);
  ai_fire_at_chopper(var_11);
  thread obj_heli_assault2();
  thread ai_goal_update_population(var_1.owner);
  level.obit_activation.ref_129D1 = var_0.team;
  var_1 notify("escape_radio_picked_up");
  ai_hold_free(var_0, var_1);
}

function ai_dropgren_override_hint(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");
  level endon("game_ended");
  level endon("cancel_escapeRadioPlayChopperDialog");

  if(isDefined(var_1)) {
    wait var_1;
  }

  var_3 = "dx_bra_" + game["dialog"][var_0];
  var_3 = tolower(var_3);
  var_4 = lookupsoundlength(var_3, 1) / 1000;
  var_2 queuedialogforplayer(var_3, var_0, var_4);
}

function ai_dropgren_weapontype(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("disconnect");
  level endon("game_ended");
  level endon("radio_state_change");

  if(isDefined(var_1)) {
    wait var_1;
  }

  scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var_0, var_3, var_2);
}

function obj_hvt_dead(var_0, var_1, var_2) {
  thread ai_excluder(var_0, var_1, var_2);
}

function ai_excluder(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("radio_state_change");

  if(isDefined(var_1)) {
    wait var_1;
  }

  foreach(var_4 in level.players) {
    ai_dropgren_weapontype(var_4, var_0, undefined, var_2);
  }
}

function ai_hold_free(var_0) {
  var_1 = self;
  var_1 endon("escape_radio_win_timer_wait");
  level endon("game_ended");

  if(isDefined(level.obit_activation.radio.waittime)) {
    ai_hold_positions(level.obit_activation.radio.waittime);
    return;
  }

  ai_hold_positions(level.obit_activation.ref_145CD);
}

function mlgmodifyheadshotdamage(var_0) {
  var_1 = self;
  level.obit_activation notify("escape_radio_dropped");
  level notify("cancel_escapeRadioPlayChopperDialog");
  level notify("radio_state_change");
  var_1 notify("escape_radio_win_timer_wait");
  var_1 endon("escape_radio_win_timer_wait");
  level endon("game_ended");
  thread obj_caches_threaded_nags_vo();
  thread obj_a_goals();
  ai_goal_distribution(0);
  var_2 = _escaperadiogetremainingtime();

  if(var_2 <= 0) {
    var_2 = level.obit_activation.radiotimebonusgap;
  }

  var_3 = ceil(var_2 / level.obit_activation.radiotimebonusgap) * level.obit_activation.radiotimebonusgap;
  var_4 = min(level.obit_activation.ref_13BFD, var_3);
  level.obit_activation.radio.waittime = min(var_4, var_2 + level.obit_activation.ref_13B6E);
  level.obit_activation.ref_145CD = level.obit_activation.radio.waittime;
  ai_hold_positions_freed(level.obit_activation.radio);
  ai_dropgren_model();

  if(getdvarint("scr_br_escape_alt_respawn_system_enable", 0) != 0) {
    ai_ground_set_goal_radii(var_1);
  }

  var_5 = scripts\mp\utility\teams::getteamdata(var_1.team, "players");
  managekingflag(var_5, 0);
  var_6 = 2;
  var_7 = 255;
  var_8 = level.obit_activation.ref_13BFD;
  var_9 = level.obit_activation.radio.waittime;
  ai_extra_think(var_6, var_7, var_8, 0);
  ai_fire_at_chopper(var_9, 1);
  var_10 = var_9 - var_2;
  setomnvar("ui_br_exfil_radio_added_time", int(var_10));
  level.obit_activation.ref_129D1 = undefined;
  level.obit_activation.radio freescriptable();
  var_11 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_0, var_1.origin, var_1.angles, self, 0, 0, 10, 1);
  level.obit_activation.radio = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_escape_radio", var_11, 0, 1);
  level.obit_activation.radio.init_weapon_placements = 1;
  level.obit_activation.radio.keepinmap = 1;
  level.obit_activation.radio.hidden = 0;
  thread ai_deaf_event_active(level.obit_activation.radio);

  foreach(var_1 in level.players) {
    if(!var_1 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      var_1 scripts\mp\hud_message::showsplash("br_escape_radio_on_ground");
    }
  }

  obj_hvt_dead("exit_strategy_radio_down", 0.75, 1);
  ai_hold_wake_behavior(level.obit_activation.radio, "on_ground");
}

function obj_caches_threaded_nags_vo() {
  if(level.obit_activation.ref_12C73 != 1) {
    return;
  }

  level endon("radio_state_change");
  level endon("radio_oob");
  level endon("game_ended");
  var_0 = undefined;
  var_1 = (0, 0, level.obit_activation.escaperadioooboffset);
  var_2 = getEntArray("trigger_hurt", "classname");
  var_3 = getEntArray("trigger_hurt_no_heli", "targetname");
  var_4 = scripts\engine\utility::array_combine(var_2, var_3);

  for(;;) {
    if(isDefined(level.obit_activation.radio)) {
      if(isDefined(var_0) && var_0 == level.obit_activation.radio.origin) {
        foreach(var_6 in var_4) {
          if(ispointinvolume(level.obit_activation.radio.origin + var_1, var_6)) {
            thread obj_a_behavior();
            level notify("radio_oob");
          }
        }

        break;
      } else {
        var_0 = level.obit_activation.radio.origin;
      }
    }

    wait 1;
  }
}

function obj_a_behavior() {
  level endon("radio_state_change");
  level endon("game_ended");
  wait 2.5;
  obj_hvt_dead("exit_strategy_radio_strength", 0, 1);
  wait 2.5;
  thread ai_ascender_use(level.obit_activation.radio);
}

function obj_a_goals() {
  if(level.obit_activation.unset_forced_aitype != 1) {
    return;
  }

  level endon("radio_state_change");
  level endon("radio_oob");
  level endon("game_ended");
  wait level.obit_activation.ref_129D7 * 0.75;
  obj_hvt_dead("exit_strategy_radio_strength", 0, 1);
  wait level.obit_activation.ref_129D7 * 0.25;
  thread ai_ascender_use(level.obit_activation.radio);
}

function ai_ground_set_goal_radii(var_0) {
  foreach(var_0 in scripts\mp\utility\teams::getteamdata(var_0.team, "players")) {
    var_0 notify("force_stop_respawn");
    var_0 scripts\mp\gametypes\br_gametype_rebirth::brrebirth_hiderebirthrespawntimer();
    var_0 scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", 0);
  }
}

function ai_damage_monitor(var_0) {
  if(level.obit_activation.ref_129D6 <= 0) {
    return;
  }

  var_1 = canceljoins(undefined, undefined, var_0, level.obit_activation.ref_129D6);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(!scripts\mp\gametypes\br_pickups::update_gamebattles_char_loc(var_3, 0)) {
        continue;
      }

      if(var_3 getscriptableisreserved() && !isDefined(var_3.embassy_main)) {
        continue;
      }

      scripts\mp\gametypes\br_pickups::ref_11A21(var_3);
    }

    return;
  }
}

function ai_deaf_event_active(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("escape_radio_picked_up");

  if(level.obit_activation.ref_129D6 <= 0) {
    return;
  }

  for(;;) {
    ai_damage_monitor(var_0);
    wait 2;
  }
}

function ai_hold_positions(var_0) {
  var_1 = self;
  var_1 endon("escape_radio_win_timer_wait");
  var_1 endon("disconnect");
  thread ai_ascender_takeascender(var_1);
  thread ai_ground_think(var_1);
  ai_flash_swap(level.obit_activation.ref_13BFD);
  ai_fire_at_chopper(var_0);
  wait var_0;
  ai_dropgren_override_hide();
  ai_delete_after_level_notify(var_1.team, 1);
}

function _escaperadiogetremainingtime() {
  var_0 = gettime() - level.obit_activation.ref_12345;
  var_1 = level.obit_activation.ref_145CD - var_0 / 1000;

  if(isDefined(level.obit_activation.radio.overalltimespentpaused) && level.obit_activation.radio.overalltimespentpaused > 0) {
    var_2 = level.obit_activation.radio.overalltimespentpaused / 1000;
    var_1 += var_2;
  }

  return var_1;
}

function ai_ascender_takeascender(var_0) {
  var_1 = self;
  level endon("game_ended");
  level endon("force_end");
  level.obit_activation endon("escape_radio_dropped");
  var_1 endon("escape_radio_win_timer_wait");
  var_1 endon("disconnect");
  var_2 = 10;
  var_3 = max(0, var_0 - var_2);
  wait var_3;

  while(var_2 > 1) {
    var_4 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc(var_2);

    foreach(var_6 in level.players) {
      var_6 playlocalsound(var_4);
    }

    var_2 -= 1;
    wait 1;
  }
}

function ai_ground_think(var_0) {
  var_1 = self;
  level endon("game_ended");
  level endon("force_end");
  level.obit_activation endon("escape_radio_dropped");
  var_1 endon("escape_radio_win_timer_wait");
  var_1 endon("disconnect");
  var_2 = [];

  if(var_0 >= 240) {
    var_2 = [240, 180, 120, 60, 45, 20, 10, 5];
  } else if(var_0 >= 180) {
    var_2 = [180, 120, 60, 45, 20, 10, 5];
  } else if(var_0 >= 120) {
    var_2 = [120, 60, 45, 20, 10, 5];
  } else if(var_0 >= 60) {
    var_2 = [60, 45, 20, 10, 5];
  } else if(var_0 >= 45) {
    var_2 = [45, 20, 10, 5];
  } else if(var_0 >= 20) {
    var_2 = [20, 10, 5];
  } else if(var_0 >= 10) {
    var_2 = [10, 5];
  } else if(var_0 >= 5) {
    var_2 = [5];
  }

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_0 - var_2[var_3];
    var_0 -= var_4;
    wait var_4;

    if(var_2[var_3] <= 60) {
      scripts\mp\gametypes\br_public::brleaderdialog("exit_strategy_less_than_" + var_2[var_3] + "_sec");
      continue;
    }

    scripts\mp\gametypes\br_public::brleaderdialog("exit_strategy_less_than_" + var_2[var_3] / 60 + "_min");
  }
}

function ai_goto_ascender_and_wait(var_0, var_1) {
  var_2 = easepower("brloot_escape_radio", var_0);
  var_2.keepinmap = 1;
  var_3 = 255;
  var_4 = level.obit_activation.ref_14385;
  var_5 = level.obit_activation.ref_14385;
  ai_extra_think(var_1, var_3, var_4, 0);
  ai_fire_at_chopper(var_5);
  ai_dismount_turret(var_2);
  level.obit_activation.radio = var_2;
  return var_2;
}

function ai_hold_debug() {
  self notify("_escapeRadioUpdateIconPosition");
  self endon("_escapeRadioUpdateIconPosition");
  self endon("escape_radio_icon_hide");
  self endon("death");

  for(;;) {
    scripts\mp\objidpoolmanager::update_objective_position(self.icon, self.origin + (0, 0, 50));
    waitframe();
  }
}

function ai_hold_wake_behavior(var_0, var_1) {
  var_2 = self;

  if(var_0 == "picked_up") {
    ammobox_giverandomattachment(var_2, var_1, "ui_mp_br_mapmenu_icon_escape_objective_friendly", "ui_mp_br_mapmenu_icon_escape_objective_enemy");
    return;
  }

  if(var_0 == "on_ground") {
    var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(var_3 != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(var_3, "current", var_2.origin + (0, 0, 50), "ui_mp_br_mapmenu_icon_escape_objective");
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_3, 1);

      foreach(var_5 in level.players) {
        if(!var_5 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
          objective_addclienttomask(var_3, var_5);
        }
      }

      objective_showtoplayersinmask(var_3);
      var_2.icon = var_3;
      thread ai_hold_debug();
      return;
    }

    return;
  }
}

function ai_hold_positions_freed() {
  var_0 = self;
  var_0 notify("escape_radio_icon_hide");

  if(isDefined(var_0.icon)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.icon);
    var_0.icon = undefined;
  }

  if(isDefined(var_0.playersetattractionstateindex)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.playersetattractionstateindex);
    var_0.playersetattractionstateindex = undefined;
  }

  if(isDefined(var_0.nuke_cancel)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.nuke_cancel);
    var_0.nuke_cancel = undefined;
    return;
  }
}

function ai_ascender_giveascender(var_0) {
  var_1 = self;
  var_2 = scripts\mp\gametypes\br_circle::getrandompointincircle(var_1.origin, var_0, 0, 0.4, 0, 0);
  var_1 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(4, 8, 4, var_2);
  var_1 scripts\mp\gametypes\br_quest_util::ref_1316F(var_0);

  foreach(var_4 in level.players) {
    var_1 scripts\mp\gametypes\br_quest_util::ref_1336A(var_4);
  }
}

function ai_ascender_getstartpos() {
  var_0 = self;

  foreach(var_2 in level.players) {
    var_0 scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_2);
  }
}

function ai_goal_update_population(var_0) {
  if(level.obit_activation.ref_129D5 != 1) {
    return;
  }

  level endon("game_ended");
  level.obit_activation notify("escape_circle_peek");
  level.obit_activation endon("escape_circle_peek");
  jumpiffalse(!isDefined(level.ref_13ACA) || !isDefined(level.ref_13ACA[var_0.team]) || level.ref_13ACA[var_0.team] == 0) LOC_0000006e;
  scripts\mp\gametypes\br_quest_util::ref_12972(var_0.team);

  for(;;) {
    level waittill("br_circle_set", var_1);
    var_2 = level.br_circle.circleindex + 1;

    if(var_1 >= var_2) {
      if(level.ref_13ACA[var_0.team] + var_2 <= var_1 + 1) {
        level.ref_13ACA[var_0.team] = undefined;
        scripts\mp\gametypes\br_quest_util::ref_12972(var_0.team);
      }
    }
  }
}

function ai_dropgren_model() {
  level.obit_activation notify("escape_circle_peek");
}

function ai_dismount_turret() {
  var_0 = self;
  var_0.hidden = 1;
  var_0 setscriptablepartstate("brloot_escape_radio", "hidden");
}

function ai_goal_distribution_debug() {
  var_0 = self;
  var_0.hidden = 0;
  var_0 setscriptablepartstate("brloot_escape_radio", "visible");
}

function obit_trigger_for_player(var_0) {
  thread ai_dropgren_override_hide();
  ai_delete_after_level_notify(var_0);
}

function ai_delete_after_level_notify(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = level.obit_activation.radio.ownerteam;
  }

  if(istrue(var_1)) {
    thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["enemies_eliminated"], undefined, undefined, undefined, 1);
    return;
  }

  var_2 = getarraykeys(level.teamdata);
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5 == var_0) {
      setteamscore(var_5, getteamscore(var_5) + level.obit_activation.onspawn_slowspeed);
    }

    if(level.teamdata[var_5]["aliveCount"] > 0) {
      var_3 = var_5;
    }
  }

  var_7 = scripts\mp\utility\script::quicksort(var_3, &ammorestock_disableusefortime);

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_5 = var_7[var_8];
    var_9 = var_8 + 1;
    thread scripts\mp\gametypes\br::ref_1209B(var_5, var_9, 0, 1, undefined, var_5 == var_0);
  }

  foreach(var_5, var_11 in level.teamdata) {
    if(var_5 == var_0) {
      var_12 = scripts\mp\utility\teams::getteamdata(var_5, "players");
      managekingflag(var_12, 0);
      continue;
    }

    var_13 = scripts\mp\utility\teams::getteamdata(var_5, "alivePlayers");

    if(var_13.size > 0) {
      foreach(var_15 in var_13) {
        var_15 freezecontrols(1);
        var_15 playerhide();
      }
    }
  }
}

function ammorestock_disableusefortime(var_0, var_1) {
  var_2 = getteamscore(var_0);
  var_3 = getteamscore(var_1);
  return var_2 >= var_3;
}

function ref_11A00(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.ref_12FA3 = "getUnusedLootCacheArray";
  var_2.ref_12F9F = var_0;
  var_2.ref_12FA6 = var_1;
  var_2.ref_12FA7 = 0;
  var_2.ref_12FA1 = 1;
  var_2.mintime = level.obit_activation.ref_129DB;
  return var_2;
}

function ammobox_giverandomattachment(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_4 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_4, "current", var_3.origin, var_1);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_4, 1);
    var_5 = getdvarfloat("scr_br_escape_friendly_icon_ping_rate", 0);
    thread anyoneisinmarkingrange(var_3, var_0, var_4);
    objective_removeallfrommask(var_4);
    var_6 = scripts\mp\utility\teams::getteamdata(var_0.team, "players");

    foreach(var_8 in var_6) {
      if(!var_8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
        objective_addclienttomask(var_4, var_8);
      }
    }

    objective_showtoplayersinmask(var_4);
    var_3.playersetattractionstateindex = var_4;
  }

  var_10 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_10 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_10, "current", var_3.origin, var_2);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_10, 1);
    var_5 = getdvarfloat("scr_br_escape_enemy_icon_ping_rate", 0);
    thread anyoneisinmarkingrange(var_3, var_0, var_10);
    objective_removeallfrommask(var_10);

    foreach(var_8 in level.players) {
      if(var_8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() || var_8.team == var_0.team) {
        objective_addclienttomask(var_10, var_8);
      }
    }

    objective_hidefromplayersinmask(var_10);
    var_3.nuke_cancel = var_10;
    return;
  }
}

function anyoneisinmarkingrange(var_0, var_1, var_2) {
  var_3 = self;
  level.obit_activation endon("escape_radio_dropped");

  if(var_2 <= 0) {
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, 50);
    scripts\mp\objidpoolmanager::update_objective_onentity(var_1, var_0);
    return;
  }

  for(;;) {
    if(isDefined(var_0)) {
      scripts\mp\objidpoolmanager::update_objective_position(var_1, var_0.origin + (0, 0, 50));

      if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
        wait 0.1;
        continue;
      }

      wait var_2;
    }
  }
}

function dangercircletick(var_0, var_1, var_2) {
  if(!isDefined(level.obit_activation)) {
    return;
  }

  if(!isDefined(level.obit_activation.radio)) {
    level.obit_activation.plundereventamount = undefined;
    return;
  }

  if(istrue(level.obit_activation.radio.hidden)) {
    level.obit_activation.plundereventamount = undefined;
    return;
  }

  var_3 = var_1 * var_1;
  var_4 = var_2 * var_2;
  var_5 = distance2dsquared(level.obit_activation.radio.origin, var_0);

  if(var_5 > var_3) {
    thread ai_ascender_use(level.obit_activation.radio);
    level.obit_activation.plundereventamount = undefined;
    return;
  }

  if(var_5 > var_4) {
    if(!isDefined(level.obit_activation.plundereventamount)) {
      level.obit_activation.plundereventamount = 1;
    } else {
      level.obit_activation.plundereventamount += 1;
    }

    if(level.obit_activation.plundereventamount == 5) {
      obj_hvt_dead("exit_strategy_radio_strength", 0, 1);
    }

    if(level.obit_activation.plundereventamount >= level.obit_activation.ref_129D8) {
      thread ai_ascender_use(level.obit_activation.radio);
      level.obit_activation.plundereventamount = undefined;
      return;
    }

    return;
  }

  level.obit_activation.plundereventamount = undefined;
}

function ai_ascender_use(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("escape_radio_picked_up");
  level notify("radio_state_change");

  foreach(var_3 in level.players) {
    if(!var_3 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      if(var_0) {
        var_3 scripts\mp\hud_message::showsplash("br_escape_radio_lost_in_gas");
        continue;
      }

      var_3 scripts\mp\hud_message::showsplash("br_escape_radio_expired");
    }
  }

  obj_hvt_dead("exit_strategy_radio_fixing", 0.75, 1);
  ai_dropgren_override_hide();
  ai_hold_positions_freed(var_1);
  var_1 freescriptable();
  level.obit_activation.radio = undefined;
  wait 5;
  var_5 = level.obit_activation.personalscorecount;

  if(level.obit_activation.ref_1438F != -1) {
    var_5 = level.obit_activation.ref_1438F;
  } else if(level.br_circle.circleindex < level.obit_activation.personalnukecostoverride) {
    var_5 = level.obit_activation.start_fly_over;
  }

  level.obit_activation.ref_14385 = var_5;
  thread ai_hold_wake_watch();
}

function obj_hangar_bombs() {
  var_0 = self;

  if(!isDefined(level.obit_activation) || !isDefined(level.obit_activation.radio)) {
    return;
  }

  if(isDefined(level.obit_activation.radio.icon)) {
    objective_removeclientfrommask(level.obit_activation.radio.icon, var_0);
    objective_showtoplayersinmask(level.obit_activation.radio.icon);
    return;
  }

  if(isDefined(level.obit_activation.radio.ownerteam)) {
    if(var_0.team == level.obit_activation.radio.ownerteam && isDefined(level.obit_activation.radio.playersetattractionstateindex)) {
      objective_removeclientfrommask(level.obit_activation.radio.playersetattractionstateindex, var_0);
      objective_showtoplayersinmask(level.obit_activation.radio.playersetattractionstateindex);
    }

    if(var_0.team != level.obit_activation.radio.ownerteam && isDefined(level.obit_activation.radio.nuke_cancel)) {
      objective_addclienttomask(level.obit_activation.radio.nuke_cancel, var_0);
      objective_hidefromplayersinmask(level.obit_activation.radio.nuke_cancel);
      return;
    }

    return;
  }
}

function obj_hangar_juggs() {
  var_0 = self;

  if(!isDefined(level.obit_activation) || !isDefined(level.obit_activation.radio)) {
    return;
  }

  if(isDefined(level.obit_activation.radio.icon)) {
    objective_addclienttomask(level.obit_activation.radio.icon, var_0);
    objective_showtoplayersinmask(level.obit_activation.radio.icon);
    return;
  }

  if(isDefined(level.obit_activation.radio.ownerteam)) {
    if(var_0.team == level.obit_activation.radio.ownerteam && isDefined(level.obit_activation.radio.playersetattractionstateindex)) {
      objective_addclienttomask(level.obit_activation.radio.playersetattractionstateindex, var_0);
      objective_showtoplayersinmask(level.obit_activation.radio.playersetattractionstateindex);
    }

    if(var_0.team != level.obit_activation.radio.ownerteam && isDefined(level.obit_activation.radio.nuke_cancel)) {
      objective_removeclientfrommask(level.obit_activation.radio.nuke_cancel, var_0);
      objective_hidefromplayersinmask(level.obit_activation.radio.nuke_cancel);
      return;
    }

    return;
  }
}

function ref_12069(var_0) {
  var_0.locationtriggerupdate = var_0.origin;

  if(isDefined(level.obit_activation) && isDefined(level.obit_activation.radio) && isDefined(level.obit_activation.radio.owner) && level.obit_activation.radio.owner == var_0) {
    var_1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    mlgmodifyheadshotdamage(var_0, var_1);
    return;
  }
}

function onplayerspawned() {
  if(istrue(level.gameended)) {
    return;
  }

  if(updatenukeprogress(self)) {
    scripts\mp\gametypes\br_gametype_kingslayer::carriabletype();
    thread managekingflagxp();
    return;
  }
}

function onplayerkilled(var_0) {
  if(isDefined(var_0.victim.carryflag)) {
    var_0.attacker thread scripts\mp\utility\points::giveunifiedpoints("radiosquadkill");
  }

  scripts\mp\gametypes\br_gametype_kingslayer::lbravo_hover_rider_death_monitor();
}

function managekingflag(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && isalive(var_3)) {
      if(var_1) {
        var_3 scripts\mp\gametypes\br_gametype_kingslayer::carriabletype();
        thread managekingflagxp();
        continue;
      }

      var_3 scripts\mp\gametypes\br_gametype_kingslayer::lbravo_hover_rider_death_monitor();
    }
  }
}

function managekingflagxp() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  level.obit_activation endon("escape_radio_dropped");

  while(isDefined(self.carryflag)) {
    wait 5;
    thread scripts\mp\utility\points::giveunifiedpoints("radiosquadsurvive");
  }
}

function ai_fire_at_chopper(var_0, var_1) {
  var_2 = int(var_0 * 1000);
  var_3 = undefined;

  if(istrue(var_1)) {
    var_3 = var_2 | 1073741824;
  } else {
    var_4 = gettime() + var_2;
    var_3 = var_4 &~1073741824;
  }

  setomnvar("ui_br_exfil_radio_end_time", var_3);
}

function ai_give_flashlight(var_0) {
  ai_extra_think(var_0);
}

function ai_force_damage_hit(var_0) {
  ai_extra_think(undefined, var_0);
}

function ai_flash_swap(var_0) {
  ai_extra_think(undefined, undefined, var_0);
}

function ai_extra_think(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.onmatchstartbr)) {
    level.onmatchstartbr = spawnStruct();
    level.onmatchstartbr.ref_129DE = 0;
    level.onmatchstartbr.ref_129DD = 0;
    level.onmatchstartbr.ref_129D9 = 255;
    level.onmatchstartbr.ref_11B6F = 0;
  }

  if(isDefined(var_3)) {
    level.onmatchstartbr.ref_129DE = var_3;
  }

  if(isDefined(var_0)) {
    level.onmatchstartbr.ref_129DD = var_0;
  }

  if(isDefined(var_1)) {
    level.onmatchstartbr.ref_129D9 = var_1;
  }

  if(isDefined(var_2)) {
    level.onmatchstartbr.ref_11B6F = var_2;
  }

  var_4 = (int(level.onmatchstartbr.ref_129DE) & 1) << 22;
  var_4 += (int(level.onmatchstartbr.ref_129DD) & 7) << 19;
  var_4 += (int(level.onmatchstartbr.ref_129D9) & 255) << 11;
  var_4 += int(level.onmatchstartbr.ref_11B6F) & 2047;
  setomnvar("ui_br_exfil_radio_state", var_4);
}

function ai_dropgren_override_hide() {
  ai_give_flashlight(0);
}

function ai_goal_distribution(var_0) {
  if(var_0 && !istrue(level.onmatchstartbr.ref_129DE)) {
    level.obit_activation.radio.enteredpausedstatetime = gettime();
  } else if(!var_0 && istrue(level.onmatchstartbr.ref_129DE) && isDefined(level.obit_activation.radio.enteredpausedstatetime)) {
    level.obit_activation.radio.overalltimespentpaused += gettime() - level.obit_activation.radio.enteredpausedstatetime;
  }

  ai_extra_think(undefined, undefined, undefined, var_0);
}

function obj_heli_assault2() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("disconnect");
  level.obit_activation endon("escape_radio_dropped");
  var_1 = 0;
  level.obit_activation.radio.overalltimespentpaused = 0;

  for(;;) {
    var_2 = istrue(var_0.unset_relic_shieldsonly) && !istrue(var_0.start_death_from_above_sequence) || scripts\mp\utility\player::unset_relic_trex(var_0);

    if(var_2 && !var_1) {
      var_1 = 1;
      var_3 = gettime();

      if(getdvarint("scr_br_alt_mode_escape_reset_timer_when_invalid_state", 0)) {
        level.obit_activation.radio.waittime = level.obit_activation.ref_145CD;
        ai_goal_distribution(1);
      } else {
        var_0 notify("escape_radio_win_timer_wait");
        ai_goal_distribution(1);
        level.obit_activation.radio.waittime = _escaperadiogetremainingtime();
      }

      ai_fire_at_chopper(level.obit_activation.radio.waittime, 1);
    } else if(!var_2 && var_1) {
      var_1 = 0;
      thread ai_hold_free(var_0);
      ai_goal_distribution(0);
      ai_fire_at_chopper(level.obit_activation.radio.waittime);
    }

    waitframe();
  }
}

function vehicle_spawn_mp_gamemodesupportsrespawn() {
  return true;
}

function adjustzoneactivationdelayforlargemaps() {
  if(!isDefined(level.onmatchstartbr) || !isDefined(level.onmatchstartbr.ref_129DD)) {
    return -1;
  }

  var_0 = level.onmatchstartbr.ref_129DD;

  if((var_0 == 1 || var_0 == 4) && isDefined(level.obit_activation.ref_129D4)) {
    var_1 = max(0, level.obit_activation.ref_129D4 - gettime());
    var_2 = var_1 / 1000;
    return var_2;
  }

  if(var_2 == 3) {
    var_2 = _escaperadiogetremainingtime();
    return var_2;
  }

  if(var_2 == 2) {
    return level.obit_activation.ref_145CD;
  }

  return -1;
}

function anyone_can_see_spawner() {
  level endon("game_ended");
  level endon("force_end");
  level.initial_allies = undefined;
  level.initial_angles = -1;
  var_0 = 0;
  var_1 = level.obit_activation.ref_13BFD;

  for(;;) {
    var_2 = 1;

    if(!isDefined(level.obit_activation)) {
      var_2 = 0;
    } else if(!isDefined(level.onmatchstartbr) || !isDefined(level.onmatchstartbr.ref_129DD)) {
      var_2 = 0;
    }

    if(var_2) {
      var_3 = adjustzoneactivationdelayforlargemaps();
      var_4 = level.onmatchstartbr.ref_129DD;

      if(var_3 == -1 || var_4 == 0) {} else if((var_4 == 1 || var_4 == 4) && !var_0) {
        if(getdvarint("scr_br_override_remaining_time", 0) != 0) {
          var_3 = getdvarint("scr_br_override_remaining_time", 0);
        }

        if(var_3 < 80) {
          ammobox_getbufferedattachmentweapon("br_escape_tenpercent");
        }
      } else if(var_4 == 3 || var_4 == 2 || var_0) {
        if(var_4 == 1 || var_4 == 4) {
          var_3 = var_1;
        }

        var_0 = 1;
        var_5 = min(var_1, var_3);
        var_1 = var_5;

        if(getdvarint("scr_br_override_remaining_time", 0) != 0) {
          var_5 = getdvarint("scr_br_override_remaining_time", 0);
        }

        if(var_5 <= 60) {
          ammobox_getbufferedattachmentweapon("br_escape_ninetypercent");
        } else if(var_5 < 125) {
          ammobox_getbufferedattachmentweapon("br_escape_eightypercent");
        } else if(var_5 < 185) {
          ammobox_getbufferedattachmentweapon("br_escape_seventypercent");
        } else if(var_5 < 250) {
          ammobox_getbufferedattachmentweapon("br_escape_fiftypercent");
        } else {
          ammobox_getbufferedattachmentweapon("br_escape_thirtypercent");
        }
      }
    }

    wait 1;
  }
}

function ammobox_getbufferedattachmentweapon(var_0) {
  if(isDefined(level.initial_allies) && level.initial_allies == var_0) {
    return;
  }

  var_1 = game["music"][var_0].size;
  var_2 = randomint(var_1);
  setmusicstate("");
  level.initial_allies = var_0;
  level.initial_angles = var_2;

  foreach(var_4 in level.players) {
    if(!var_4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      ref_131A9(var_4);
    }
  }
}

function ref_131A9() {
  var_0 = self;

  if(isDefined(level.initial_allies)) {
    var_0 setplayermusicstate(game["music"][level.initial_allies][level.initial_angles]);
    return;
  }
}