/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_kingslayer.gsc
***********************************************************/

function init() {
  thread displaydelayedmissioncompletesplash();
  thread displaycodes();
  thread displayplunderloss();
  thread display_who_broke_stealth_message();
  thread displaycodeindex();
}

function displaycodes() {
  if(getdvarint("scr_brking_debug", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  }

  setDvar("scr_br_moving_circle_enabled", 1);
  setDvar("scr_br_allowLoadout", 1);
  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_hide_redeploy_timer", 1);
  level.playerkillstreakgetownerlookatignoreents = getdvarint("scr_kingslayer_forceDisableLS", 0) == 1;
  level.scriptedphysicaldofenabled = getdvarint("scr_dmz_giveLoadoutEveryTime", 1);
  level.trackriotshield_tryreset = getdvarint("scr_bmo_instantBleedOutSquadWipe", 1);
  level.wait_until_emp_drone_done = getdvarint("scr_kingslayer_killsBeforePlacement", 1);
  level.wait_until_impact = getdvarint("scr_kingslayer_kingsWorthExtraBeforePlacement", 0);
  level.waitandapplybrweaponxp = getdvarint("scr_kingslayer_pointsToWin", 50);
  level.wait_until_trap_room_clear = getdvarint("scr_kingslayer_pointBonusForTeam", 1) == 1;
  level.wait_until_truck_arrives_at_station = getdvarint("scr_kingslayer_pointKingsGetNoBonus", 1) == 1;
  level.wait_use_respawn = getdvarint("scr_kingslayer_pointsPerKing", 5);
  setDvar("scr_risk_win_cost", level.waitandapplybrweaponxp);
  level.spawn_convoy_and_move = getdvarint("scr_bmo_hideLeaderHashUntilPercent", 0);
  level.lootchopper_modifyweapondamage = getdvarint("scr_dmz_loot_leader_update_on_pickup", 0) == 1;
  level.ref_13366 = getdvarint("scr_bmo_progressSplashesAndMusic", 1);
  level.ref_12FB3 = getdvarint("scr_bmo_secondsBeforePlacementUpdates", 60);
  level.loadout_updateclassdefault_headlessgetweaponn = getdvarint("scr_bmo_disable_perc_announcements", 0);
  level.ref_11A27 = getdvarint("scr_dmz_loot_leader_mark_count", 3);
  level.ref_11B62 = getdvarint("scr_dmz_loot_leader_mark_count", 3);
  level.ref_11A2A = getdvarint("scr_bmo_loot_leader_mark_size", 1000);
  level.ref_11A31 = getdvarint("scr_dmz_loot_leader_one_per_team", 1) == 1;
  level.ref_11A2B = getdvarint("scr_bmo_loot_leader_mark_size_dynamic", 0);
  level.ref_11A2D = getdvarint("scr_bmo_loot_leader_mark_info_strong_size", 2000);
  level.ref_11A2E = getdvarint("scr_bmo_loot_leader_mark_info_strong_value", 5000);
  level.ref_11A2F = getdvarint("scr_bmo_loot_leader_mark_info_weak_size", 5000);
  level.ref_11A30 = getdvarint("scr_bmo_loot_leader_mark_info_weak_value", 1000);
  level.ref_11A2C = getdvarint("scr_bmo_loot_leader_mark_top_teams", 3);
  level.ref_11A28 = getdvarint("scr_kingslayer_lootLeaderUpdateMarkerTime", 0);
  level.ref_127C0 = getdvarfloat("scr_bmo_music_first", 0.3);
  level.ref_127C2 = getdvarfloat("scr_bmo_music_second", 0.5);
  level.ref_127C3 = getdvarfloat("scr_bmo_music_third", 0.75);
  level.ref_127C1 = getdvarfloat("scr_bmo_music_fourth", 0.9);
  level.isbotpracticematch = getdvarfloat("scr_kingslayer_dangerNotifyCooldown", 20);
  level.isbrgametypefuncdefined = [];
  level.ref_14062 = getdvarint("scr_dmz_useAutoRespawn", 1);
  level.checkpoint_objective_id = getdvarint("scr_dmz_autoRespawnWaitTime", 1);
  level.ref_13BCD = getdvarint("scr_dmz_tokenRespawnWaitTime", level.checkpoint_objective_id);
  level.start_persistent_turbulence = getdvarint("scr_dmz_respawn_penalty", 0);
  level.start_pipe_room = getdvarfloat("scr_dmz_respawn_penalty_max", 15);
  level.ref_12CA7 = getdvarint("scr_bmo_respawnHeightOverride", 5000);
  level.ref_12CB4 = getdvarint("scr_dmz_respawn_time_disable", 0);
  level.ref_121CC = getdvarfloat("scr_bmo_parachuteDeployDelay", 0.5);
  level.wait_unload_jeep = getdvarint("scr_kingslayer_hideKingsOnSpawn", 1) == 1;
  level.waitandpause = getdvarint("scr_kingslayer_spawnProtection", 1) == 1;
  level.waitandspawnprops = getdvarfloat("scr_kingslayer_spawnProtectionModifier", 0.5);
  level.waitandgetnewspawnpoint = getdvarfloat("scr_kingslayer_spawnLauncherDamage", 0.5);
  level.ref_133EA = getdvarint("scr_bmo_skipWeaponDropOnDeath", 1);
  level.ref_133CD = getdvarint("scr_bmo_skipEquipmentDropOnDeath", 1);
  level.playerismatchedplayerready = getdvarint("scr_bmo_forceArmorDropOnDeath", 2);
  level.wait_to_spawn_r0 = getdvarint("scr_kingslayer_circleMoveDistance", 18000);
  level.wait_till_time = getdvarint("scr_kingslayer_airdropPerCircle", 1);
  level.wait_spawn_trucks_smokescreen = getdvarint("scr_kingslayer_airdropCrateUseTime", 3);
  level.wait_spawn_sidehouse_trucks = getdvarint("scr_kingslayer_airdropCrateArmor", 3);
  level.wait_to_close_in = getdvarint("scr_kingslayer_circleCount", 20);
  level.wait_unload_chopper = getdvarfloat("scr_kingslayer_circleRadius", 10100);
  level.wait_to_advance = getdvarfloat("scr_kingslayer_circleCloseTime", 50);
  level.wait_to_reset_wave_loadout = getdvarfloat("scr_kingslayer_circleDelayTime", 50);
  level.wait_to_spawn_ambush_vehicle = getdvarint("scr_kingslayer_circleMiniMapRadius", 4750);
  level.wait_to_stop_path_vehicle = getdvarint("scr_kingslayer_movingCircle", 1) == 1;
  level.wait_to_start_exfil_obj = getdvarint("scr_kingslayer_circleMovesAwayFromLeader", 1);
  level.wait_to_stop_pre_tmtyl_spawners = getdvarint("scr_kingslayer_circleOutOfBoundsPadding", 1);
  level.wait_to_play_intro_vo = getdvarint("scr_kingslayer_circleDebug", 0);
  level.ref_11C85 = &ref_126A6;
  level.needs_controller = getdvarint("scr_bmo_endMatchCameraTransitions", 1);
  level.ref_13BE1 = [];
  level.ref_11A32 = [];
  level.fuckwithgravity = 0;
  level.fuel_stability_event_init = 0;
  level.fuel_stability_event_start = 0;

  if(getdvarint("scr_kingslayer_disableKiosks", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("kiosk");
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("dropbag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("oneLife");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("missions");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizeCircleCenter");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("planeSnapToOOB");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("tabletReplace");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("planeUseCircleRadius");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");

  if(getdvarint("scr_kingslayer_disableLoot", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("loot");
  }

  if(getdvarint("scr_kingslayer_disableArmor", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("armor");
  }

  level.onstartgametype = &onstartgametype;
  level.ref_11C84 = &ref_11C83;
  level.ononeleftevent = &ononeleftevent;
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerShouldRespawn", &ref_12691);
  scripts\mp\gametypes\br_gametypes::ref_12B11("spawnHandled", &ref_1365D);
  scripts\mp\gametypes\br_gametypes::ref_12B11("onPlayerConnect", &dlog_analytics_init);
  scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
  scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
  scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
  scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
  scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
  scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  level.decoyassists = &brmini_initdialog;
  level.wait_until_done = [];
  level.ref_13364 = 1;
}

function ref_1365D(var_0) {
  return istrue(var_0.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done");
}

function ref_12691(var_0) {
  return true;
}

function displaydelayedmissioncompletesplash() {
  var_0 = spawnStruct();
  var_0.weights = [];
  level.votesys_update_time = var_0;
  display_message_to_guilty_player("toma_strike", getdvarint("scr_kingslayer_kingkill_toma", 50));
  display_message_to_guilty_player("precision_airstrike", getdvarint("scr_kingslayer_kingkill_precision", 10));
  display_message_to_guilty_player("directional_uav", getdvarint("scr_kingslayer_kingkill_auav", 40));
}

function displayplunderloss() {
  scripts\mp\gametypes\br_gametypes::ref_12B11("createC130PathStruct", &display_ping_hint_with_radial_check);
  scripts\mp\gametypes\br_gametypes::ref_12B11("addToC130Infil", &display_message_to_teammates);
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerWelcomeSplashes", &dmz_numteamswithplayers);
  waittillframeend();
  scripts\mp\flags::gameflaginit("placement_updates_allowed", 0);
  level.ontimelimit = &dmz_bot_callback_func;
  level.onplayerkilled = &dmg_trig;
  level.ref_11C7A = &ref_125F7;
  level.modifyplayerdamage = &distort_fx;
  level.assists_disabled = undefined;
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_c130Airdrop", "c130Airdrop_onCrateUse", &divide_living_ai);
  display_mission_failed_text();
  touchdown_origin();
  level.ref_11A29 = [];
  level.ref_140D9 = [];
  level.ref_140D9[0] = "assassination";
  level.ref_140D9[1] = "domination";
  level.ref_140D9[2] = "scavenger";
  thread numextractions();
  thread dmzextractcostdecrease();
  thread dist_sq_to_ref();
  thread dist_miles();
  thread ref_14365();
  thread ref_12397();

  if(getdvarfloat("scr_dmz_loot_leader_update_interval", 15) > 0) {
    thread ref_13FF1();
  }

  if(istrue(level.needs_controller)) {
    thread test_pipe_fire();
  }

  scripts\mp\rank::ref_12189("kill", 100);
  scripts\mp\rank::ref_12189("br_cacheOpen", 200);
}

function display_who_broke_stealth_message() {
  level endon("game_ended");
  level waittill("br_dialog_initialized");
  game["dialog"]["match_start"] = "gametype_tdm";
}

function display_mission_failed_text() {
  scripts\cp_mp\utility\game_utility::ref_12C10("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12C11("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::ref_12C11("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::ref_12C11("me_electrical_box_street_01", 1);
}

function displaycodeindex() {}

function touchdown_origin() {
  foreach(var_1 in level.teamnamelist) {
    level.teamdata[var_1]["teamTotalScore"] = 0;
    level.teamdata[var_1]["tokensTeamTotal"] = 0;
  }
}

function display_message_to_guilty_player(var_0, var_1) {
  level.votesys_update_time.weights[var_0] = var_1;
}

function display_relics_splash(var_0) {
  var_1 = [];
  var_2 = 0;

  foreach(var_5, var_4 in level.votesys_update_time.weights) {
    var_2 += var_4;
    var_1 = var_2;
  }

  var_6 = randomint(var_2);
  var_7 = undefined;

  foreach(var_2 in var_1) {
    if(var_6 < var_2) {
      var_7 = var_5;
      break;
    }
  }

  return var_7;
}

function dmz_numteamswithplayers(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_kingslayer_prematch_welcome");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");

    while(!self isonground()) {
      waitframe();
    }
  } else {
    level waittill("prematch_done");
  }

  scripts\mp\gametypes\br_analytics::detachriotshield(self);
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_kingslayer_welcome");
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("primary_objective", self, 0);
}

function dmz_bot_callback_func() {
  if(isDefined(level.numendgame)) {
    level thread scripts\mp\gametypes\br::startendgame(1);
  }

  level.numendgame = undefined;
}

function onstartgametype() {
  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/WAR");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/WAR_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"OBJECTIVES/WAR_HINT");
  }
}

function ref_11C83(var_0) {
  thread playerrespawn();
  return true;
}

function ref_125F7(var_0, var_1) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return false;
  }

  thread playerrespawn();
  return true;
}

function dist_to_line_seg() {
  self endon("death_or_disconnect");
  self endon("ks_remove_spawn_protection");
  self.waitandpause = 1;

  while(!self isonground()) {
    waitframe();
  }

  if(level.wait_unload_jeep) {
    self.wait_unload_chopper_flood_players = 0;
  }

  self.waitandpause = 0;
  self notify("ks_remove_spawn_protection");
}

function distance_weight() {
  self endon("death_or_disconnect");
  self endon("ks_remove_spawn_protection");
  self.waitandpause = 1;
  self waittill("weapon_fired");

  if(level.wait_unload_jeep) {
    self.wait_unload_chopper_flood_players = 0;
  }

  self.waitandpause = 0;
  self notify("ks_remove_spawn_protection");
}

function dist_to_line() {
  self endon("death_or_disconnect");
  self.wait_until_player_is_near = 1;

  while(!self isonground()) {
    waitframe();
  }

  self.wait_until_player_is_near = 0;
}

function distort_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(level.waitandpause) {
    if(isDefined(var_1.waitandpause) && var_1.waitandpause == 1) {
      var_3 *= level.waitandspawnprops;
    }

    if(isDefined(var_2) && isDefined(var_2.wait_until_player_is_near) && var_2.wait_until_player_is_near == 1) {
      switch (var_4) {
        case "MOD_EXPLOSIVE":
        case "MOD_GRENADE_SPLASH":
        case "MOD_GRENADE":
        case "MOD_PROJECTILE_SPLASH":
          var_3 *= level.waitandgetnewspawnpoint;
          break;
      }
    }
  }

  var_3 = scripts\mp\gametypes\br::brmodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  return var_3;
}

function playerrespawn() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(level.gameended)) {
    return;
  }

  if(getdvarint("scr_bmo_use_spawn_fix", 1) == 1) {
    self endon("brWaitAndSpawnClientComplete");
  }

  var_0 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

  if(!istrue(self.ref_13749) || var_0 == 1) {
    var_1 = 1;
    wait var_1;
  }

  var_2 = level.checkpoint_objective_id;
  var_3 = getdvarfloat("scr_bmo_respawn_predict_hint_time", 5);

  if(var_2 < var_3) {
    var_2 = var_3;
  }

  if(level.ref_12CB4 != 0) {
    var_2 = 0;
  }

  var_4 = getdvarfloat("scr_bmo_squad_wiped_stream_time", 3);
  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;

  if(istrue(self.ref_13749) || var_0 == 1) {
    var_5 = display_wave_num();
    var_6 = scripts\mp\gametypes\br_gulag::ref_1263E(var_5);
    thread patchfix(0, var_0 > 1);
    wait var_4;
  } else if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_2 * 1000));
    var_7 = var_2 - var_3;
    var_8 = var_2 - var_7;
    var_9 = var_2 - getdvarfloat("scr_bmo_respawn_intermission_time", 6);
    thread patchfix(var_9);
    var_10 = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", var_7);

    if(var_10 == "squad_wipe_death") {
      var_5 = display_wave_num();
      var_6 = scripts\mp\gametypes\br_gulag::ref_1263E(var_5);
      thread patchfix(0, 1);
      wait var_4;
    } else {
      thread ref_1400C();
      var_10 = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", var_8);

      if(var_10 == "squad_wipe_death") {
        var_5 = display_wave_num();
        var_6 = scripts\mp\gametypes\br_gulag::ref_1263E(var_5);
        thread patchfix(0, 1);
        wait var_4;
      }
    }
  }

  self notify("stop_updatePrestreamRespawn");
  var_5 = display_wave_num();
  var_6 = scripts\mp\gametypes\br_gulag::ref_1263E(var_5);

  if(istrue(self.ref_13749)) {
    self.ref_13749 = 0;

    if(var_0 > 1 && !scripts\mp\gametypes\br_public::uniquelootitemid()) {
      scripts\mp\hud_message::showsplash("bm_your_squad_wiped");
    }
  }

  if(!displaysplashtoplayersinradius(var_5.origin)) {
    var_11 = display_timer(0, 0.7);
    var_5.origin = (var_11[0], var_11[1], var_5.origin[2]);
  }

  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();

  if(scripts\mp\gametypes\br_public::uniquelootitemid() && isDefined(level.ref_124E7)) {
    var_5 = scripts\engine\utility::getStruct(level.ref_124E7, "targetname");
  }

  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var_5, 1, var_6, 1);
  scripts\mp\gametypes\br::ref_13F21(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "player_respawn");
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);

  if(level.waitandpause) {
    thread distance_weight();
    thread dist_to_line_seg();
    thread dist_to_line();
  }

  self setclientomnvar("ui_ctf_flag_carrier", 0);

  foreach(var_13 in level.ref_11A32) {
    if(var_13 == self) {
      carriabletype();
      break;
    }
  }
}

function display_wave_num() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 1;

  if(isDefined(self.setspawnpoint)) {
    var_0 = self.setspawnpoint.playerspawnpos;
    var_1 = self.setspawnpoint.playerspawnangles;
  }

  var_4 = getdvarfloat("scr_kingslayer_respawnMinRadiusPercent", 0.8);
  var_5 = getdvarfloat("scr_kingslayer_respawnMaxRadiusPercent", 0.9);
  var_6 = getdvarfloat("scr_kingslayer_respawnRandomArea", 100);

  if(!isDefined(var_0) && var_6 >= 0) {
    var_7 = scripts\mp\gametypes\br_gulag::ref_12568();

    if(isDefined(var_7)) {
      var_8 = display_ready_for_sequence();
      var_9 = scripts\mp\gametypes\br_circle::getsafecircleradius();
      var_10 = vectorNormalize(var_7.origin - var_8) * var_9 * var_4 + var_8;
      var_0 = scripts\mp\gametypes\br_circle::getrandompointincircle(var_10, var_6, var_4, var_5);

      if(isDefined(var_0)) {
        var_0 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_0);
        var_1 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var_0, var_7.origin);
      }
    }
  }

  if(!isDefined(var_0)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      var_11 = display_ready_for_sequence();
      var_12 = scripts\mp\gametypes\br_circle::getsafecircleradius();
      var_13 = getdvarint("scr_br_maxRespawnDropToGround", 1);
      var_14 = getdvarint("scr_br_maxRespawnSnapToNavMesh", 1);
      var_0 = scripts\mp\gametypes\br_circle::getrandompointincircle(var_11, var_12, var_4, var_5);
      var_1 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var_0, var_11);
    } else if(isDefined(level.prematchspawnorigins)) {
      if(isDefined(level.teamdata[self.team]["chosenSpawnWipeOrigin"]) && isDefined(level.teamdata[self.team]["spawnWipeOriginUseStartTime"]) && isDefined(level.checkpoint_objective_id) && level.teamdata[self.team]["spawnWipeOriginUseStartTime"] + level.checkpoint_objective_id * 1000 > gettime()) {
        var_0 = level.teamdata[self.team]["chosenSpawnWipeOrigin"];
      } else {
        var_15 = [];

        foreach(var_17 in level.prematchspawnorigins) {
          if(distance2dsquared(var_17.origin, self.origin) > var_6) {
            var_15 = var_17;
          }
        }

        if(var_15.size == 0) {
          var_15 = level.prematchspawnorigins;
        }

        var_15 = scripts\engine\utility::array_randomize(var_15);
        var_0 = var_15[0].origin;
        var_0 += scripts\engine\math::random_vector_2d() * randomfloatrange(100, 500);
        level.teamdata[self.team]["chosenSpawnWipeOrigin"] = var_0;
        level.teamdata[self.team]["spawnWipeOriginUseStartTime"] = gettime();
      }

      var_1 = (0, 0, 0);

      if(var_0[2] > 10000) {
        var_3 = 0;
        var_2 = scripts\mp\gametypes\br_public::getinfilspawnoffset();
      }
    } else {
      var_0 = (0, 0, 0);
      var_1 = (0, 0, 0);
    }
  }

  if(!isDefined(var_1)) {
    var_19 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var_20 = vectortoyaw(var_19 - var_0);
    var_1 = (0, var_20, 0);
  }

  if(var_3) {
    if(!isDefined(var_2)) {
      var_2 = scripts\cp_mp\parachute::getc130height();
    }

    if(isDefined(level.br_circle)) {
      var_21 = level.br_circle.circleindex;
      var_22 = scripts\mp\gametypes\br_gulag::remove_engineer_class();
      var_23 = isDefined(var_21) && var_21 >= var_22;

      if(var_23) {
        var_2 *= getdvarfloat("scr_br_gulagClosedSpawnOffsetScaler", 0.55);
      }
    }

    if(isDefined(level.ref_12CA7)) {
      var_2 = level.ref_12CA7;
    }

    var_24 = (0, 0, var_2);
    var_0 = scripts\mp\gametypes\br::getoffsetspawnorigin(var_0, var_24);
  }

  var_25 = spawnStruct();
  var_25.origin = var_0;
  var_25.angles = var_1;
  var_25.height = var_2;
  return var_25;
}

function patchfix(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  var_2 = 1;
  thread fadeoutin();
  wait var_2 - 0.25;

  if(getdvarint("scr_kingslayer_tacMapCenterAndZoom", 1) == 1) {
    scripts\mp\gametypes\br::ending_fade_in();
  }

  if(istrue(var_1)) {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 6);
  } else {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 2);
  }

  wait 0.25;

  if(getdvarint("scr_bmo_use_spawn_intermission_fix", 1) == 1) {
    scripts\mp\gametypes\br_public::ref_1252B();
    var_3 = display_wave_num();
    scripts\mp\gametypes\br_spectate::ref_1252A();
    scripts\mp\gametypes\br::spawnintermission(var_3.origin, var_3.angles);
    scripts\mp\spectating::setdisabled();
    self.trial_moving_target_think = var_3.origin;
    self.trial_other_team = gettime();
    scripts\engine\utility::ent_flag_set("playerRespawn_intermission_spawned");
    return;
  }
}

function fadeoutin() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  self waittill("spawned_player");
  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
}

function ref_1400C() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      var_0 = display_wave_num();
      var_1 = gettime();

      if(var_1 - self.trial_other_team >= getdvarfloat("scr_bmo_spawn_fallback_hint_delay", 2) * 1000) {
        var_0 = display_wave_num();
        var_2 = scripts\mp\gametypes\br_gulag::ref_1263E(var_0);
      }
    } else {
      var_0 = display_wave_num();
      var_2 = scripts\mp\gametypes\br_gulag::ref_1263E(var_0);
    }

    wait 1;
  }
}

function display_ping_hint_with_radial_check() {
  var_0 = getdvarint("scr_kingslayer_first_point_distance", 30000);
  level.br_level.default_class_chosen[0] = scripts\mp\gametypes\br_circle::getrandompointincircle(level.br_level.default_class_chosen[0], var_0);

  if(istrue(level.wait_to_stop_path_vehicle)) {
    distsqtodefenderflagstart(0);
  } else {
    level.br_level.default_class_chosen[1] = level.br_level.default_class_chosen[0];
  }

  var_1 = (level.br_level.default_class_chosen[0][0], level.br_level.default_class_chosen[0][1], 0);
  var_2 = level.br_level.br_circleradii[0];
  var_3 = scripts\mp\gametypes\br_c130::createtestc130path(var_1, var_2);
  return var_3;
}

function display_message_to_teammates() {
  thread displaysquadmessagetoplayer();
}

function displaysquadmessagetoplayer() {
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

function dist_sq_to_ref() {
  level endon("game_ended");

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  level waittill("br_prematchEnded");
  wait 20;
  thread ref_1383F();
}

function ref_1383F() {
  level endon("game_ended");

  for(;;) {
    for(var_0 = 0; var_0 < level.wait_till_time; var_0++) {
      var_1 = display_timer(0, 0.6);
      var_2 = spawnStruct();
      var_2.origin = var_1;
      var_2.clear_legacy_pickup_munitions = spawn("script_model", var_2.origin);
      var_2.clear_legacy_pickup_munitions setModel("ks_airdrop_crate_br");
      thread mlgiconfullflag(level, var_2);
    }

    wait level.wait_to_advance + level.wait_to_reset_wave_loadout;
  }
}

function mlgiconfullflag(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(var_0.modify_blast_shield_damage)) {
    var_0.modify_blast_shield_damage = level.wait_unload_chopper;
  }

  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    var_2 = scripts\mp\gametypes\br_circle::getrandompointincircle(var_0.origin, var_0.modify_blast_shield_damage);
  } else {
    var_2 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_1.origin, var_1.modify_blast_shield_damage);
  }

  if(istrue(level.ref_1406F)) {
    var_2 = scripts\mp\gametypes\br_rewards::return_enemy_type_mask(var_2);
  }

  var_3 = scripts\mp\gametypes\br_c130airdrop::fn_spec_op_post_customization(undefined, var_2, 1);
  var_4 = distance(var_3.startpt, var_3.endpt);
  var_5 = scripts\mp\gametypes\br_c130::getc130speed();
  var_6 = var_4 / var_5;
  var_7 = scripts\mp\gametypes\br_c130airdrop::fntrapdeactivation(var_3, var_4, var_5, var_6);
  var_7.mode_can_play_ending = &mode_can_play_ending;
  var_7.ref_134E2 = var_2;
  var_7 scripts\mp\gametypes\br_c130airdrop::fob(1, "battle_royale_c130_loot", "kingslayer_world", var_1);
}

function mode_can_play_ending(var_0, var_1, var_2, var_3) {
  var_4 = self.startpt;
  var_5 = self.centerpt;
  var_6 = self.speed;
  var_7 = distance2d(var_4, var_5) / var_6;
  var_8 = 0;
  var_9 = 0;
  level.ref_11F2C += var_0;

  while(var_8 < var_0) {
    wait var_7;
    var_10 = scripts\mp\gametypes\br_c130airdrop::fnchildscorefunc(self.origin, 1);
    var_11 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_10 + (0, 0, level.fnhidefoundintel - 100), var_10, self.angles, var_1, var_2, var_3.ref_11EAB);
    var_8++;
    var_11.ml_p2_func = var_3;
    var_11.ref_134E2 = self.ref_134E2;
    level.focus_fire_attacker_timeout[level.focus_fire_attacker_timeout.size] = var_11;
    var_12 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_11);
    var_12.ref_140A0 = relic_laststand_modifyplayerdamage();
  }
}

function divide_living_ai(var_0) {
  var_1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_2 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
  scripts\mp\gametypes\br_pickups::spawnpickup("brloot_killstreak_uav", var_2);
  var_2 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
  scripts\mp\gametypes\br_pickups::spawnpickup("brloot_killstreak_clusterstrike", var_2);
  var_2 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
  scripts\mp\gametypes\br_pickups::spawnpickup("brloot_killstreak_precision_airstrike", var_2);

  if(!isDefined(var_0.ref_11A01)) {
    var_0.ref_11A01 = 1;
  } else {
    var_0.ref_11A01++;
  }

  var_0 scripts\mp\utility\stats::setextrascore1(var_0.ref_11A01);
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("br_c130_box_open");
}

function relic_laststand_modifyplayerdamage() {
  return level.wait_spawn_trucks_smokescreen;
}

function brmini_initdialog() {
  level.br_level.br_circleclosetimes = [level.wait_to_advance, level.wait_to_advance];
  level.br_level.br_circledelaytimes = [level.wait_to_reset_wave_loadout + 40, level.wait_to_reset_wave_loadout];
  level.br_level.default_player_connect_black_screen = [1, 0];
  level.br_level.default_suicidebomber_combat = [0, 0];
  level.br_level.br_circleminimapradii = [level.wait_to_spawn_ambush_vehicle, level.wait_to_spawn_ambush_vehicle];
  level.br_level.br_circleradii = [level.wait_unload_chopper, level.wait_unload_chopper, level.wait_unload_chopper];

  if(istrue(level.wait_to_stop_path_vehicle)) {
    var_0 = [];
    var_1 = [];
    var_2 = [];
    var_3 = [];

    for(var_4 = 0; var_4 < level.wait_to_close_in; var_4++) {
      var_0 = level.wait_unload_chopper;
      var_1 = level.wait_to_advance;
      var_2 = level.wait_to_reset_wave_loadout;
      var_3 = level.wait_to_spawn_ambush_vehicle;
    }

    scripts\mp\gametypes\br_circle::open_teleport_room_door(var_0, var_1, var_2, var_3);
    return;
  }

  level.br_level.ref_13884 = 1;
}

function ref_14365() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  thread dmzextractcost();
}

function dlog_analytics_init(var_0) {
  var_0.ref_12306 = 0;
  var_0.wagingplayer = 0;
  var_0.vstartposition = 0;
}

function dmg_trig(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\mp\gametypes\br::onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(level.wait_unload_jeep) {
    self.wait_unload_chopper_flood_players = 1;
  }

  lbravo_hover_rider_death_monitor();

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  if(isDefined(var_1) && isPlayer(self)) {
    display_welcome(var_1, self);
    return;
  }
}

function display_welcome(var_0, var_1) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(var_0 != var_1 && isDefined(var_0.team)) {
    var_2 = var_0.team;
    var_3 = 1;
    var_4 = 1;

    if(level.wait_until_truck_arrives_at_station) {
      foreach(var_6 in level.ref_11A32) {
        if(!isDefined(var_6)) {
          continue;
        }

        if(var_6.team == var_2) {
          var_4 = 0;
          break;
        }
      }
    }

    if(level.wait_until_impact == 0 && !scripts\mp\flags::gameflag("placement_updates_allowed")) {
      var_4 = 0;
    }

    if(var_4 == 1) {
      foreach(var_6 in level.ref_11A32) {
        if(!isDefined(var_6)) {
          continue;
        }

        var_9 = scripts\engine\utility::ter_op(level.wait_until_trap_room_clear, var_6.team == var_1.team, var_6 == var_1);

        if(var_9) {
          var_3 = level.wait_use_respawn;
          var_0.wagingplayer++;
          ref_121B6(var_0);
          var_1.vstartposition++;
          ref_121B6(var_1);
          var_10 = isDefined(var_0.streakdata.streaks[1]);
          var_11 = display_relics_splash(var_0);
          var_0 scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar(var_11, var_10, 1);
          var_0 thread scripts\mp\hud_message::showsplash("kingslayer_" + var_11);
          var_0 thread scripts\mp\rank::scoreeventpopup("hvt_kill");
          var_0 thread scripts\mp\rank::scoreeventpopup("teamscore_notify_" + var_3);
          break;
        }
      }
    }

    if(isDefined(level.teamdata[var_2])) {
      level.teamdata[var_2]["teamTotalScore"] = level.teamdata[var_2]["teamTotalScore"] + var_3;
      var_0.ref_12306 += var_3;

      if(level.wait_until_emp_drone_done > 0) {
        if(level.teamdata[var_2]["teamTotalScore"] >= level.wait_until_emp_drone_done) {
          level notify("brKing_startPlacements");
          return;
        }

        return;
      }

      return;
    }

    scripts\mp\utility\script::laststand_dogtags("team " + var_2 + " is not in level.teamData");
    return;
  }
}

function ref_121B6(var_0) {
  var_1 = self.wagingplayer;

  if(var_1 > 255) {
    var_1 = 255;
  }

  var_2 = self.vstartposition;

  if(var_2 > 255) {
    var_2 = 255;
  }

  var_1 += var_2 << 8;
  scripts\mp\utility\stats::setextrascore0(var_1);
}

function ref_121B4() {
  var_0 = self.wagingplayer;

  if(var_0 > 255) {
    var_0 = 255;
  }

  var_1 = self.vstartposition;

  if(var_1 > 255) {
    var_1 = 255;
  }

  var_0 += var_1 << 8;
  return var_0;
}

function numextractions() {
  level waittill("give_match_bonus");
  waitframe();
  var_0 = getdvarfloat("scr_bmo_eom_held_cash_scalar", 1);
  var_1 = getdvarfloat("scr_bmo_eom_banked_cash_scalar", 1);
  var_2 = getdvarint("scr_bmo_eom_initial_winner_bonus", 3000);
  var_3 = getdvarint("scr_bmo_eom_over_wincost_bonus", 2250);
  var_4 = getdvarint("scr_bmo_eom_top10_bonus", 1500);

  foreach(var_6 in level.teamnamelist) {
    var_7 = 0;
    var_8 = 0;
    var_9 = game["teamPlacements"][var_6];
    var_10 = 0;

    if(var_8) {
      var_10 = var_3;
    } else if(var_9 <= 10) {
      var_10 = var_4;
    } else {
      var_10 = 750;
    }

    var_11 = scripts\mp\utility\teams::getteamdata(var_6, "players");

    foreach(var_13 in var_11) {
      var_13 scripts\mp\gametypes\br::ref_138D6();
      var_13 scripts\cp_mp\utility\game_utility::ref_13168(var_9);

      if(!var_13 scripts\mp\utility\game::rankingenabled() || !var_13 hasplayerdata()) {
        continue;
      }

      var_13 scripts\mp\utility\stats::incpersstat("cash", int(var_7 / 10000));
      var_14 = var_13.pers["combatXP"];

      if(!isDefined(var_14)) {
        var_14 = 0;
      }

      var_13 setplayerdata("mp", "aarValue", 0, var_14);
      var_15 = var_13.pers["missionXP"];

      if(!isDefined(var_15)) {
        var_15 = 0;
      }

      var_13 setplayerdata("mp", "aarValue", 1, var_15);
      var_16 = var_13.pers["lootingXP"];

      if(!isDefined(var_16)) {
        var_16 = 0;
      }

      var_13 setplayerdata("mp", "aarValue", 2, var_16);
      var_17 = 0;

      if(isDefined(var_13.plundercount)) {
        var_17 = int(var_13.plundercount * var_0);
      }

      var_18 = 0;

      if(isDefined(var_13.plunderbanked)) {
        var_18 = int(var_13.plunderbanked * var_1);
      }

      var_19 = var_17 + var_18;

      if(var_19 > 0) {
        var_13 scripts\mp\rank::giverankxp("cash_conversion_bonus", var_19, undefined, 1, 1);
      }

      var_13 setplayerdata("mp", "aarValue", 3, 0);
      var_20 = 0;

      if(isDefined(var_13.matchbonus)) {
        var_20 = int(var_13.matchbonus);
      }

      var_13 setplayerdata("mp", "aarValue", 4, var_20);

      if(var_10 > 0) {
        var_13 scripts\mp\rank::giverankxp("placement_bonus", var_10, undefined, 1, 1);
      }

      var_13 setplayerdata("mp", "aarValue", 5, var_10);
      var_21 = var_13 getplayerdata("mp", "aarValue", 6);
      var_22 = var_21 + var_13.pers["summary"]["xp"];
      var_13 setplayerdata("mp", "aarValue", 7, var_22);
    }
  }
}

function dmzlootleaderupdateonpickup(var_0, var_1, var_2) {
  var_3 = int(game["teamScores"][var_1]);
  var_4 = var_0 - var_3;

  if(var_4 != 0) {
    var_5 = scripts\engine\utility::ter_op(scripts\mp\gametypes\br_public::uniquelootitemid(), 1, undefined);
    level thread scripts\mp\gamescore::giveteamscoreforobjective(var_1, var_4, 0, undefined, var_5, var_2);
  }

  return var_4;
}

function distsqtodefenderfalgstart(var_0) {
  scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, var_0);
}

function dmzextractcost() {
  level endon("game_ended");
  var_0 = 0;
  var_1 = [];
  var_2 = level.spawn_convoy_and_move != 0;
  var_3 = 0;

  for(;;) {
    waittillframeend();
    var_4 = level.fuckwithgravity && level.fuel_stability_event_init && level.fuel_stability_event_start;
    var_5 = level.waitandapplybrweaponxp;
    var_0 += level.framedurationseconds;

    if(istrue(level.ref_14086)) {
      var_6 = scripts\mp\flags::gameflag("placement_updates_allowed");
    } else {
      var_6 = var_0 > level.ref_12FB3;
    }

    var_7 = level.ref_13366 && var_6;
    var_8 = scripts\mp\gamescore::run_common_functions_stealth();
    var_9 = level.ref_13ABD;
    var_10 = undefined;
    var_11 = undefined;
    var_12 = undefined;
    var_13 = [];
    var_14 = [];
    var_15 = [];
    var_16 = "none";
    var_17 = "none";
    var_18 = -1;
    var_19 = 0;

    foreach(var_21 in level.teamnamelist) {
      var_22 = level.teamdata[var_21]["teamTotalScore"];
      var_23 = dmzlootleaderupdateonpickup(var_22, var_21, level.disable_super_in_turret.player_enemy_cooldown);
      var_24 = revive_or_disconnect_monitor(var_21);
      var_25 = var_8[var_21];

      if(var_22 > var_18) {
        if(var_18 > var_19) {
          var_19 = var_18;
          var_17 = var_16;
        }

        var_18 = var_22;
        var_16 = var_21;
      } else if(var_16 != "none") {
        if(var_22 > var_19) {
          var_19 = var_22;
          var_17 = var_21;
        }
      }

      var_26 = var_22;
      var_27 = var_22;
      var_28 = 0;

      if(var_27 >= var_5 * 0.9) {
        var_10 = var_21;
      } else if(var_27 >= var_5 * 0.75) {
        var_11 = var_21;
      } else if(var_27 >= var_5 * 0.5) {
        var_12 = var_21;
      }

      if(var_27 >= var_5 * level.ref_127C1) {
        thread scripts\mp\music_and_dialog::ref_12791();
      } else if(var_27 >= var_5 * level.ref_127C3) {
        thread scripts\mp\music_and_dialog::ref_127A7();
      } else if(var_27 >= var_5 * level.ref_127C2) {
        thread scripts\mp\music_and_dialog::ref_1278B();
      } else if(var_27 >= var_5 * level.ref_127C0) {
        thread scripts\mp\music_and_dialog::ref_127A9();
      }

      var_29 = scripts\mp\utility\teams::getfriendlyplayers(var_21, 0);
      ref_14004(var_8, var_29);

      foreach(var_31 in var_29) {
        var_14 = var_31.ref_12306;
        var_15 = var_31;
      }

      if(var_7) {
        if(var_25 == 1) {
          var_13 = var_21;
        } else if(var_25 <= 5) {
          if(var_24 > 5) {
            showsplashtoteam(var_21, "bm_top_5");
          }
        } else if(var_25 <= 10) {
          if(var_24 > 10) {
            showsplashtoteam(var_21, "bm_top_10");
          }
        }
      }

      if(var_27 >= var_5) {
        thread searchradiusidealmin(level);
      }
    }

    foreach(var_31 in level.players) {
      var_35 = level.teamdata[var_31.team]["teamTotalScore"];
      var_31 setclientomnvar("ui_br_team_cash_banked", int(var_35));
      var_31 setclientomnvar("ui_br_team_cash_pockets", int(scripts\engine\utility::ter_op(var_35 >= var_18, var_19, var_18)));
    }

    var_37 = [];
    var_38 = [];

    if(level.ref_11A2C == 1) {
      var_37 = setteamplacement(game["teamPlacements"], "up");
    } else if(level.ref_11A2C == 2) {
      var_37 = var_16;
      var_38 = setteamplacement(var_14, "down");
    } else {
      var_38 = setteamplacement(var_14, "down");
    }

    level.disable_super_in_turret.player_enemy_cooldown = var_16;

    if(var_16 == "none") {
      var_1 = [];
      waitframe();
      continue;
    }

    if(!var_2 && var_18 >= var_5 * level.spawn_convoy_and_move * 0.1) {
      setomnvar("ui_br_leader_hash_percentage_hit", 1);
      var_2 = 1;
    }

    if(!var_7 || var_18 == 0) {
      waitframe();
      continue;
    }

    if(level.ref_11A2C > 0) {
      if(level.lootchopper_modifyweapondamage || istrue(level.ref_127D2)) {
        ref_13FF0(var_14, var_38, var_15, var_37);
        level.ref_127D2 = 0;
      }
    } else if(level.lootchopper_modifyweapondamage || istrue(level.ref_127D2)) {
      ref_13FF0(var_14, var_38, var_15);
      level.ref_127D2 = 0;
    }

    foreach(var_21 in var_13) {
      if(!scripts\engine\utility::array_contains(var_1, var_21)) {
        if(istrue(level.ref_13BE1[var_21])) {
          if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
            showsplashtoteam(var_21, "bm_top_team_regained");
          }

          continue;
        }

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          showsplashtoteam(var_21, "bm_top_team");
        }

        level.ref_13BE1[var_21] = 1;
      }
    }

    if(var_13.size > 0) {
      foreach(var_21 in var_1) {
        if(!scripts\engine\utility::array_contains(var_13, var_21)) {
          showsplashtoteam(var_21, "bm_top_team_lost");
        }
      }
    }

    var_1 = var_13;
    level.ref_13BE0 = var_16;
    level.ref_12884 = var_8;

    if(!var_4) {
      if(!level.fuel_stability_event_start && isDefined(var_10)) {
        level.fuel_stability_event_start = 1;

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            ref_13372(var_10, "bm_first_to_90_them");
            showsplashtoteam(var_10, "bm_first_to_90_us");
            level thread scripts\mp\gametypes\br_public::brleaderdialog("final_circle", 0, undefined, undefined, 2);
          }
        }
      } else if(!level.fuel_stability_event_init && isDefined(var_11)) {
        level.fuel_stability_event_init = 1;

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            ref_13372(var_11, "bm_first_to_75_them");
            showsplashtoteam(var_11, "bm_first_to_75_us");
          }
        }
      } else if(!level.fuckwithgravity && isDefined(var_12)) {
        level.fuckwithgravity = 1;

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            ref_13372(var_12, "bm_first_to_50_them");
            showsplashtoteam(var_12, "bm_first_to_50_us");
          }
        }
      }
    }

    waitframe();
  }
}

function ref_14004(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = var_0[var_3.team];
    var_3 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_placement", var_4);
    var_3 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_player_position", var_4);
  }
}

function revive_or_disconnect_monitor(var_0) {
  if(isDefined(level.ref_12884)) {
    return level.ref_12884[var_0];
  }

  return -1;
}

function ref_13371(var_0) {
  foreach(var_2 in level.players) {
    var_2 scripts\mp\hud_message::showsplash(var_0);
  }
}

function showsplashtoteam(var_0, var_1) {
  foreach(var_3 in level.teamdata[var_0]["players"]) {
    var_3 scripts\mp\hud_message::showsplash(var_1);
  }
}

function ref_13372(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3) && var_3.team != var_0) {
      var_3 scripts\mp\hud_message::showsplash(var_1);
    }
  }
}

function setobjectivecallbacks(var_0, var_1) {
  var_2 = int(min(var_1, 131072));
  self setclientomnvar(var_0, var_2);
}

function setoutputfunc(var_0, var_1) {
  var_2 = int(min(var_1, 131072));
  setomnvar(var_0, var_2);
}

function ref_13FF0(var_0, var_1, var_2, var_3) {
  level.ref_11A36 = level.ref_11A32;
  level.ref_11A32 = [];

  if(level.ref_11A2C == 1) {
    for(var_4 = 0; var_4 < level.ref_11A27; var_4++) {
      var_5 = removeplatepouch(var_4, var_0, var_3);

      if(isDefined(var_5)) {
        level.ref_11A32[level.ref_11A32.size] = var_2[var_5];
      }
    }
  } else {
    jumpiffalse(level.ref_11A2C == 2) LOC_00000106;
    var_5 = removeplatepouch(0, var_0, var_3);

    if(isDefined(var_5)) {
      level.ref_11A32[0] = var_2[var_5];
    }

    foreach(var_7 in var_1) {
      var_8 = var_2[var_7];
      var_9 = var_0[var_7];

      if(var_9 == 0) {
        break;
      }

      if(var_9 == level.ref_12D6F) {
        continue;
      }

      if(scripts\engine\utility::array_contains(level.ref_11A32, var_8)) {
        continue;
      }

      level.ref_11A32[level.ref_11A32.size] = var_8;

      if(level.ref_11A32.size == level.ref_11A27) {
        break;
      }
    }

    goto LOC_0000015f;
  }

  foreach(var_8 in level.ref_11A36) {
    if(isDefined(var_8) && !scripts\engine\utility::array_contains(level.ref_11A32, var_8)) {
      ref_12C18(var_8);
    }
  }

  level notify("update_loot_leaders");

  if(level.ref_11A29.size < level.ref_11A27) {
    for(var_4 = 0; var_4 < level.ref_11A27; var_4++) {
      var_15 = spawnStruct();
      var_15.hidden = 0;
      var_15 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active");
      level.ref_11A29[var_4] = var_15;
    }
  }

  for(var_4 = 0; var_4 < level.ref_11A27; var_4++) {
    var_15 = level.ref_11A29[var_4];

    if(isDefined(level.ref_11A32[var_4])) {
      var_15.targetplayer = level.ref_11A32[var_4];
      var_15.targetplayer.ref_11A26 = var_15;
      var_16 = var_15.targetplayer.origin;
      var_17 = scripts\engine\utility::array_contains(level.ref_11A32, var_15.targetplayer) && !scripts\engine\utility::array_contains(level.ref_11A36, var_15.targetplayer);

      if(var_15.hidden == 0) {
        var_18 = scripts\mp\utility\teams::getenemyplayers(var_15.targetplayer.team, 0);

        foreach(var_8 in var_18) {
          displaywelcome(var_15, var_8);
        }

        var_21 = scripts\mp\utility\teams::getfriendlyplayers(var_15.targetplayer.team, 0);

        foreach(var_8 in var_21) {
          displaysquadmessagetoteam(var_15, var_8);
        }
      }

      if(var_17) {
        battle_tracks_updatebattletracks(var_15);
      }

      continue;
    }

    var_15.targetplayer = undefined;
    objective_removeallfrommask(var_15.objectiveiconid);
  }
}

function dmzextractcostdecrease() {
  level endon("game_ended");
  level waittill("update_loot_leaders");

  for(;;) {
    for(var_0 = 0; var_0 < level.ref_11A27; var_0++) {
      var_1 = level.ref_11A29[var_0];

      if(isDefined(var_1.targetplayer)) {
        if(!scripts\mp\utility\player::isreallyalive(var_1.targetplayer) && var_1.hidden == 0) {
          var_1.hidden = 1;
          objective_removeallfrommask(var_1.objectiveiconid);
          level notify("Objective_Delete", var_1.objectiveiconid);
        } else if(scripts\mp\utility\player::isreallyalive(var_1.targetplayer) && var_1.hidden == 1) {
          if(!level.wait_unload_jeep || isDefined(var_1.targetplayer.wait_unload_chopper_flood_players) && var_1.targetplayer.wait_unload_chopper_flood_players == 0) {
            var_1.hidden = 0;
            var_2 = scripts\mp\utility\teams::getenemyplayers(var_1.targetplayer.team, 0);

            foreach(var_4 in var_2) {
              displaywelcome(var_1, var_4);
            }
          }
        }

        distsqtodefenderfalgstart(var_1, var_1.targetplayer.origin);
        continue;
      }

      if(var_1.hidden == 0) {
        var_1.hidden = 1;
        objective_removeallfrommask(var_1.objectiveiconid);
      }
    }

    if(level.ref_11A28 > 0) {
      wait level.ref_11A28;
      continue;
    }

    waitframe();
  }
}

function displaywelcome(var_0) {
  scripts\mp\gametypes\br_quest_util::ref_1336C(var_0);
}

function displaysquadmessagetoteam(var_0) {
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
}

function removeplatepouch(var_0, var_1, var_2) {
  var_3 = var_2[var_0];
  var_4 = 0;
  var_5 = 0;

  if(level.teamdata[var_3]["players"].size == 0) {
    return undefined;
  }

  var_6 = level.teamdata[var_3]["players"][0].guid;

  foreach(var_8 in level.teamdata[var_3]["players"]) {
    var_4 = var_1[var_8.guid];

    if(var_4 > var_5) {
      var_5 = var_4;
      var_6 = var_8.guid;
    }
  }

  return var_6;
}

function battle_tracks_updatebattletracks(var_0) {
  var_1 = var_0.targetplayer;

  if(scripts\mp\utility\player::isreallyalive(var_1)) {
    carriabletype(var_1);

    if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
      var_1 scripts\mp\hud_message::showsplash("bm_player_marked");
      return;
    }

    return;
  }
}

function ref_13FF1() {
  level notify("restartLootLeaders");
  level endon("restartLootLeaders");
  level endon("game_ended");
  var_0 = getdvarfloat("scr_dmz_loot_leader_update_interval", 15);
  var_1 = getdvarfloat("scr_dmz_loot_leader_update_interval_blink", 5);
  var_2 = getdvarint("scr_bmo_circle_pulse_start", 800);
  var_3 = getdvarint("scr_bmo_circle_pulse_end", 200);
  var_4 = var_0 - var_1;
  scripts\mp\flags::gameflagwait("placement_updates_allowed");

  for(;;) {
    level.ref_127D2 = 1;
    scripts\engine\utility::waittill_notify_or_timeout("bmo_overtime_start", var_4);
  }
}

function ref_12397() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(isDefined(level.ref_12FB3)) {
    wait level.ref_12FB3;
  }

  if(level.wait_until_emp_drone_done > 0) {
    level waittill("brKing_startPlacements");
  }

  scripts\mp\flags::gameflagset("placement_updates_allowed");
}

function ref_12C18(var_0) {
  lbravo_hover_rider_death_monitor(var_0);

  if(isDefined(var_0.ref_11A26)) {
    foreach(var_2 in level.players) {
      displaysquadmessagetoteam(var_0.ref_11A26, var_2);
    }

    var_4 = var_0.ref_11A26.guard_spawners;
    var_0.ref_11A26.targetplayer = undefined;
    var_0.ref_11A26 = undefined;
  }

  level.ref_11A32 = scripts\engine\utility::array_remove(level.ref_11A32, var_0);
}

function searchradiusidealmin(var_0) {
  waitframe();
  ref_14004(scripts\mp\gamescore::run_common_functions_stealth(), level.players);

  if(istrue(level.ref_13DC0)) {
    return;
  }

  level.ref_13DC0 = 1;
  level thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["objective_completed"]);
  var_1 = [];

  if(isDefined(var_0) && var_0 != "tie") {
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");
  }

  thread scripts\mp\music_and_dialog::ref_12789(var_1);
}

function ononeleftevent(var_0) {}

function ref_126A6() {
  if(!istrue(self.controlsfrozen)) {
    scripts\mp\utility\player::_freezecontrols(1, undefined, "spawnEndOfGame");
  }

  var_0 = spawnStruct();
  var_1 = self getspectatingplayer();

  if(!isDefined(var_1)) {
    var_1 = self;
  }

  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;

  if(!var_1 isonground()) {
    var_2 = scripts\engine\trace::create_default_contents(1);
    var_0.origin = scripts\engine\utility::drop_to_ground(var_0.origin, 0, -20000, undefined, var_2);
  }

  var_0.origin += (0, 0, 100);

  if(!isDefined(level.needs_antenna)) {
    level.needs_antenna = 1;
    thread ref_13DB9();
  }

  return true;
}

function test_pipe_fire() {
  var_0 = [];
  level.mp_m_trench_patch = [];
  level.mp_m_speedball_patch = [];

  if(level.mapname == "mp_br_mechanics") {
    level.mp_m_trench_patch[0] = (8682, -1036, 427);
    level.mp_m_speedball_patch[0] = (14, 163, 0);
    level.mp_m_trench_patch[1] = (-1139, -3425, 1116);
    level.mp_m_speedball_patch[1] = (33, 75, 0);
    level.mp_m_trench_patch[2] = (-5567, -4786, 1116);
    level.mp_m_speedball_patch[2] = (37, 192, 0);
    return;
  }

  level.mp_m_trench_patch[0] = (-36548, -31983, 2400);
  level.mp_m_speedball_patch[0] = (12, 72, 0);
  level.mp_m_trench_patch[1] = (-17592, -36440, 1379);
  level.mp_m_speedball_patch[1] = (17, 90, 0);
  level.mp_m_trench_patch[2] = (-3520, -34298, 1217);
  level.mp_m_speedball_patch[2] = (11, 110, 0);
  level.mp_m_trench_patch[3] = (-9577, -25957, 360);
  level.mp_m_speedball_patch[3] = (357, 82, 0);
  level.mp_m_trench_patch[4] = (23022, -26926, 1359);
  level.mp_m_speedball_patch[4] = (16, 101, 0);
  level.mp_m_trench_patch[5] = (31261, -29753, 1359);
  level.mp_m_speedball_patch[5] = (27, 52, 0);
  level.mp_m_trench_patch[6] = (44843, -41261, 3220);
  level.mp_m_speedball_patch[6] = (16, 52, 0);
  level.mp_m_trench_patch[7] = (44229, -15403, 1331);
  level.mp_m_speedball_patch[7] = (13, 72, 0);
  level.mp_m_trench_patch[8] = (44491, 3484, 1638);
  level.mp_m_speedball_patch[8] = (23, 11, 0);
  level.mp_m_trench_patch[9] = (16047, -3206, 2613);
  level.mp_m_speedball_patch[9] = (27, 309, 0);
  level.mp_m_trench_patch[10] = (5668, -5905, 1614);
  level.mp_m_speedball_patch[10] = (23, 304, 0);
  level.mp_m_trench_patch[11] = (-13412, -20443, 1033);
  level.mp_m_speedball_patch[11] = (11, 109, 0);
  level.mp_m_trench_patch[12] = (-30369, -7811, 1680);
  level.mp_m_speedball_patch[12] = (31, 339, 0);
  level.mp_m_trench_patch[13] = (-26278, 4081, 142);
  level.mp_m_speedball_patch[13] = (6, 110, 0);
  level.mp_m_trench_patch[14] = (-16429, 6021, 847);
  level.mp_m_speedball_patch[14] = (21, 57, 0);
  level.mp_m_trench_patch[15] = (-7525, 11672, 1082);
  level.mp_m_speedball_patch[15] = (14, 46, 0);
  level.mp_m_trench_patch[16] = (8356, 15296, 2021);
  level.mp_m_speedball_patch[16] = (12, 38, 0);
  level.mp_m_trench_patch[17] = (26010, 29975, 2716);
  level.mp_m_speedball_patch[17] = (13, 68, 0);
  level.mp_m_trench_patch[18] = (12043, 30910, 3081);
  level.mp_m_speedball_patch[18] = (21, 88, 0);
  level.mp_m_trench_patch[19] = (7127, 52592, 2100);
  level.mp_m_speedball_patch[19] = (28, 241, 0);
  level.mp_m_trench_patch[20] = (-6693, 56481, 4026);
  level.mp_m_speedball_patch[20] = (16, 246, 0);
  level.mp_m_trench_patch[21] = (-21394, 37175, 757);
  level.mp_m_speedball_patch[21] = (2, 124, 0);
  level.mp_m_trench_patch[22] = (-26151, 25577, 271);
  level.mp_m_speedball_patch[22] = (357, 10, 0);
}

function ref_13DB9() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    thread ref_12753(var_2, var_2);
    var_0++;

    if(var_0 == 5) {
      waitframe();
      var_0 = 0;
    }
  }
}

function registerquestcategorytablevalues(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.mp_m_trench_patch) {
    var_5 = distance2dsquared(var_0.origin, var_4);

    if(var_5 <= 9000000) {
      return var_6;
    }

    if(!isDefined(var_2) || var_2 > var_5) {
      var_2 = var_5;
      var_1 = var_6;
    }
  }

  return var_1;
}

function ref_12753(var_0, var_1) {
  var_2 = level.mp_m_trench_patch[var_1];
  var_3 = level.mp_m_speedball_patch[var_1];
  var_4 = var_2 + anglestoright(var_3) * 1000;
  var_5 = var_3;
  var_6 = spawn("script_model", var_2);
  var_6 setModel("tag_origin");
  var_6.angles = var_3;
  var_0 cameralinkTo(var_6, "tag_origin");
  var_6 moveTo(var_4, 60);
  var_6 rotateTo(var_5, 60);
}

function dist_miles() {
  level endon("game_ended");
  thread dmzminextractcost();

  for(;;) {
    level waittill("br_circle_set");
    distsqtodefenderflagstart();
  }
}

function distsqtodefenderflagstart(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level.br_circle.circleindex + 1;
  }

  if(level.br_level.default_class_chosen.size <= var_0 || !istrue(level.wait_to_stop_path_vehicle)) {
    return;
  }

  var_1 = level.br_level.default_class_chosen[var_0];
  var_2 = level.wait_to_spawn_r0;
  var_3 = level.ref_11A32.size > 0;
  jumpiffalse(var_3) LOC_00000081;
  var_4 = level.ref_11A32[0].origin;
  var_5 = scripts\engine\utility::ter_op(level.wait_to_start_exfil_obj, var_1 - var_4, var_4 - var_1);
  goto LOC_000000a2;
}

function displaysplashtoplayers(var_0) {
  var_1 = level.br_level.br_mapbounds;
  var_2 = level.wait_to_stop_pre_tmtyl_spawners;
  var_3 = var_0[0] < var_1[0][0] * var_2 && var_0[0] > var_1[1][0] * var_2 && var_0[1] < var_1[0][1] * var_2 && var_0[1] > var_1[1][1] * var_2;
  return var_3;
}

function dmzminextractcost() {
  level endon("game_ended");
  level.group_unset_jugg_ignoreall_after_notify = gettime();

  for(;;) {
    level waittill("br_circle_started");
    level.group_unset_jugg_ignoreall_after_notify = gettime();
  }
}

function display_reinforcement_called_icon() {
  return (gettime() - level.group_unset_jugg_ignoreall_after_notify) / 1000 / level.wait_to_advance;
}

function display_ready_for_sequence() {
  var_0 = display_reinforcement_called_icon();

  if(level.br_circle.circleindex < 0) {
    return level.br_level.default_class_chosen[0];
  }

  if(var_0 > 1) {
    return level.br_level.default_class_chosen[level.br_circle.circleindex];
  }

  var_1 = level.br_level.default_class_chosen[level.br_circle.circleindex + 1];
  var_2 = level.br_level.default_class_chosen[level.br_circle.circleindex];
  return vectorlerp(var_2, var_1, display_reinforcement_called_icon());
}

function displaysplashtoplayersinradius(var_0) {
  var_1 = display_ready_for_sequence();
  var_2 = distance2d(var_0, var_1);
  return var_2 < level.wait_unload_chopper;
}

function display_timer(var_0, var_1) {
  var_2 = display_ready_for_sequence();
  return scripts\mp\gametypes\br_circle::getrandompointincircle(var_2, level.wait_unload_chopper, var_0, var_1);
}

function carriabletype() {
  if(!isDefined(self.carryflag)) {
    self attach("prop_king_game_flag", "tag_stowed_back3", 1);
    self.carryflag = "prop_ctf_game_flag_west";
    self setclientomnvar("ui_ctf_flag_carrier", 1);
    return;
  }
}

function lbravo_hover_rider_death_monitor() {
  if(isDefined(self.carryflag)) {
    self detach("prop_king_game_flag", "tag_stowed_back3");
    self.carryflag = undefined;
    self setclientomnvar("ui_ctf_flag_carrier", 0);
    return;
  }
}