/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_mendota.gsc
********************************************************/

function activate_punchcard() {}

function activate_gas_trap() {}

function init() {
  scripts\mp\gametypes\br_alt_mode_mxp::init();
  level thread scripts\mp\gametypes\br_gametype_rebirth::enabledskiplaststand();
  level thread scripts\mp\gametypes\br_gametype_rebirth::enable_traversals_for_bombers();
  level thread scripts\mp\gametypes\obj_dogtag::init();
  test_anim_ai();
  thread time_reduction_bonus();
  thread testaccessoryvfx();
  thread teamstarttime();
  thread toggleusbstickinhand();
  thread subtract_from_spawn_count_from_group();
  thread init_locations();
  level.ref_13364 = 1;
  level.ref_133d7 = 1;
  level.disable_back_light = 1;
  level.littlebird_overrideoobseconds = level.ref_11bce.littlebird_overrideoobseconds;
  level.ref_142d1 = "mp_wz_island_mendota";
  level.visionsetoverrideplanes = "mp_wz_island_ap_mendota";
  level.train_hurt_damage_watcher = [];
}

function test_anim_ai() {
  level.ref_11bce = spawnStruct();
  level.ref_11bce.juggernaut_setupexecute = getdvarint("scr_mendota_default_respawn_height");

  if(isDefined(level.ref_11bce.juggernaut_setupexecute) && level.ref_11bce.juggernaut_setupexecute > 0) {
    level.ref_12ca7 = level.ref_11bce.juggernaut_setupexecute;
  }

  level.ref_11bce.ref_127b6 = getdvarfloat("scr_mendota_plunderDropPercent", 0.3);
  level.ref_11bce.ref_127b5 = getdvarfloat("scr_mendota_plunderDropAmount", 0);
  level.ref_11bce.ref_127be = getdvarfloat("scr_mendota_plunderKeepPercent", 0.6);
  level.ref_11bce.ref_12c9a = getdvarfloat("scr_mendota_respawn_time_default", 5);
  level.ref_11bce.ref_12c99 = getdvarfloat("scr_mendota_respawn_time_add_per_circle", 2);
  level.ref_11bce.ref_1385a = getdvarint("scr_mendota_starting_respawn_token_count", 0);
  level.ref_11bce.ref_13857 = getDvar("scr_mendota_starting_loadout_weapon_1", "iw8_fists_mp");
  level.ref_11bce.ref_13858 = getDvar("scr_mendota_starting_loadout_weapon_2", "iw8_sm_t9handling");
  level.ref_11bce.ref_13856 = getDvar("scr_mendota_starting_loadout_lethal", "frag_grenade_mp");
  level.ref_11bce.triage_glass_break = getdvarint("scr_mendota_intel_see_friendly_drops", 0);
  level.ref_11bce.on_intel_pickup_xp = getdvarint("scr_mendota_on_intel_pickup_xp", 25);
  level.ref_11bce.ref_11fe8 = getdvarint("scr_mendota_on_intel_pickup_health_refill", 1);
  level.ref_11bce.ref_11fe7 = getdvarint("scr_mendota_on_intel_pickup_armor_refill", 1);
  level.ref_11bce.ref_11fe6 = getdvarint("scr_mendota_on_intel_pickup_ammo_refill", 1);
  level.ref_11bce.ref_11fea = getdvarint("scr_mendota_on_intel_pickup_speed_increase", 1);
  level.ref_11bce.ref_11fe9 = getdvarfloat("scr_mendota_on_intel_pickup_overdrive_duration", 6);
  level.ref_11bce.ref_14199 = getdvarvector("scr_mendota_vehicle_impulse_vector", (0, 0, 0.5));
  level.ref_11bce.ref_14198 = getdvarfloat("scr_mendota_vehicle_impulse_magnitude", 150);
  level.ref_11bce.train_lootcrates_save_offsets = getdvarint("scr_mendota_intel_event", 1);
  level.ref_11bce.ref_11bea = getdvarint("scr_mendota_min_intel_circle_index", 2);
  level.ref_11bce.ref_11b48 = getdvarint("scr_mendota_max_intel_circle_index", 6);
  level.ref_11bce.infil_light_dvars = getdvarint("scr_mendota_crate_intel_count", 30);
  level.ref_11bce.ref_11beb = getdvarint("scr_mendota_intel_event_min", 20);
  level.ref_11bce.ref_11b49 = getdvarint("scr_mendota_intel_event_max", 30);
  level.ref_11bce.ref_11f1e = getdvarint("scr_mendota_intel_event_pairs", 1);
  level.ref_11bce.train_get_num_of_anim_ents = [];
  level.ref_11bce.train_get_num_of_anim_ents["k"] = getdvarint("scr_mendota_k_intel_crate_dist", 2000);
  level.ref_11bce.train_get_num_of_anim_ents["g"] = getdvarint("scr_mendota_g_intel_crate_dist", 6000);
  level.ref_11bce.trial_fetch_mission_table = getdvarfloat("scr_br_mxp_crate_min_time", 60);
  level.ref_11bce.trial_explosive_clear = getdvarfloat("scr_br_mxp_crate_max_time", 90);
  level.ref_11bce.inteldialogcooldown = getdvarfloat("scr_mxp_intel_dialog_cooldown", 30);
  level.ref_11bce.intelmax = getdvarint("scr_mxp_intel_max", 150);
  level.ref_11bce.intelreset = getdvarfloat("scr_mxp_intel_reset", 3);
  level.ref_11bce.vo_while_reviving = getdvarint("scr_mendota_killstreak_disable_circle", 8);
  level.ref_11bce.littlebird_overrideoobseconds = getdvarint("scr_mendota_littlebird_overrideOOBSeconts", 30);
  level.ref_11bce.finalcircledistfromfresno = getdvarint("scr_final_cir_dist_from_fresno_pt", 6000);
  level.ref_11bce.firstcirclemaxdistfromcenter = getdvarint("scr_first_cir_max_dist_from_center", 30000);

  switch (getdvarint("scr_mendota_circle_speed", 1)) {
    case 0:
      level.ref_11bce.groundentity = [0, 120, 90, 75, 60, 45, 30, 0];
      level.ref_11bce.ground_spawners = [1, 150, 120, 120, 105, 105, 150, 10];
      break;
    case 2:
      level.ref_11bce.groundentity = [0, 120, 90, 60, 45, 45, 30, 0];
      level.ref_11bce.ground_spawners = [1, 150, 120, 90, 90, 90, 150, 10];
      break;
    case 3:
      level.ref_11bce.groundentity = [0, 30, 10, 10, 10, 10, 30, 0];
      level.ref_11bce.ground_spawners = [1, 20, 10, 10, 10, 10, 10, 10];
      break;
    case 4:
      level.ref_11bce.groundentity = [0, 90, 75, 60, 45, 30, 0];
      level.ref_11bce.ground_spawners = [1, 120, 120, 105, 90, 150, 10];
      break;
    case 5:
      level.ref_11bce.groundentity = [0, 30, 10, 10, 10, 30, 0];
      level.ref_11bce.ground_spawners = [1, 20, 10, 10, 10, 150, 10];
      break;
    case 1:
    default:
      level.ref_11bce.groundentity = [0, 120, 90, 75, 60, 45, 45, 0];
      level.ref_11bce.ground_spawners = [1, 150, 135, 135, 120, 105, 105, 10];
      break;
  }

  if(getdvarint("scr_mendota_heavyWeaponCrate_ultraLoot", 0)) {
    level.delaystreamtomovingplane = 1;
  }

  if(getdvarint("scr_mendota_dangerNotifyCustomization", 1)) {
    level.isbotpracticematch = getdvarfloat("scr_mendota_dangerNotifyCooldown", 20);
    level.isbrgametypefuncdefined = [];
  }

  setDvar("scr_br_ending_enabled", 1);
}

function time_reduction_bonus() {
  level.tread_sfx = [];
  level.tread_sfx[level.tread_sfx.size] = tree_think(getdvarint("scr_br_mxp_reward_mask", 20), &translate_and_rotate_from_level_overrides);
  level.tread_sfx[level.tread_sfx.size] = tree_think(getdvarint("scr_br_mxp_reward_satchel", 40), &transitionac130tomovinganim);
  level.tread_sfx[level.tread_sfx.size] = tree_think(getdvarint("scr_br_mxp_reward_heavy", 60), &trap_room_ents);
  level.tread_sfx[level.tread_sfx.size] = tree_think(getdvarint("scr_br_mxp_reward_loadout", 80), &trap_timer_running);
  level.tread_sfx[level.tread_sfx.size] = tree_think(getdvarint("scr_br_mxp_reward_strike", 100), &trap_door_nvg_reset);
}

function teamstarttime() {
  scripts\mp\gametypes\br_gametypes::ref_13f25("circleTimer");
  scripts\mp\gametypes\br_gametypes::ref_13f25("dropOnPlayerDeath");
  scripts\mp\gametypes\br_gametypes::ref_12b11("circleTimer", &circletimer);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerWelcomeSplashes", &ref_126f1);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mapCenterFinalCircle", &ref_12181);
  scripts\mp\gametypes\br_gametypes::ref_12b11("getFinalCircleCenter", &ref_12181);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerGulagAutoWinWait", &ref_125bd);
  scripts\mp\gametypes\br_gametypes::ref_12b11("assignSpectatorToSpectatePlayer", &assignspectatortospectateplayer);
  scripts\mp\gametypes\br_gametypes::ref_12b11("markPlayerAsEliminatedOnKilled", &ref_11b16);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dropOnPlayerDeath", &droponplayerdeath);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerDropPlunderOnDeath", &playerdropplunderondeath);
  scripts\mp\gametypes\br_gametypes::ref_12b11("pickupModifyCount", &ref_12356);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onUseCompleted", &onusecompleted);
  scripts\mp\gametypes\br_gametypes::ref_12b11("canTakePickupLoot", &get_chopper_minigun_start_node);
  scripts\mp\gametypes\br_gametypes::ref_12b11("skipPickupFeedback", &skippickupfeedback);
  scripts\mp\gametypes\br_gametypes::ref_12b11("takePickup", &ref_13a36);
  scripts\mp\gametypes\br_gametypes::ref_12b11("initCrateData", &initcratedata);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerRebirthDisable", &ref_12646);
  scripts\mp\gametypes\br_gametypes::ref_12b11("rebirthDisable", &ref_12a7c);

  if(getdvarint("scr_br_mxp_normal_circle", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::ref_12b11("createC130PathStruct", &init_relic_aggressive_melee);
    scripts\mp\gametypes\br_gametypes::ref_12b11("addToC130Infil", &being_hacked);
  }

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  thread ref_14148();
}

function ref_126f1(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;

  if(!istrue(level.br_infils_disabled)) {
    self waittill("joining_Infil");
  } else {
    level waittill("prematch_done");
  }

  scripts\mp\hud_message::showsplash("br_gametype_mendota_welcome");
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gametype", self, 0);
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("primary_objective", self, 0);

  if(istrue(self.tutorial_usingparachute)) {
    level scripts\mp\gametypes\br_public::dmztut_endgamewithreward("deploy_squad_leader", self, 1, 0, 4.5);
  }

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");

    if(isDefined(game["dialog"]["match_desc"])) {
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("match_desc", self, 0);
    }

    while(!self isonground()) {
      waitframe();
    }
  } else {
    level waittill("prematch_done");
  }

  scripts\mp\gametypes\br_analytics::detachriotshield(self);
  wait 1;
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("secondary_objective", self, 0);
}

function iscarriablescriptable() {
  self waittill("game_ended");

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      onplayerdisconnect(var_1);
    }
  }

  foreach(var_4 in level.ref_13748) {
    if(isDefined(level.ref_13457)) {
      [[level.ref_13457.ref_13738]](var_4.total, var_4.bridge_tank_move_sfx, var_4.nextplayertospectate);
      [[level.ref_13457.ref_1373b]](var_4.ref_12d24);
    }
  }

  if(istrue(level.ref_145c1) && isDefined(level.ref_13457)) {
    [[level.ref_13457.ref_145c1]]();
    return;
  }
}

function onplayerdisconnect(var_0) {}

function init_relic_gas_martyr(var_0, var_1) {
  var_2 = init_relic_grounded(var_1);
  init_relic_gun_game(var_2, var_0);
  init_relic_headbullets(var_2, var_0);
  return var_2;
}

function init_relic_grounded(var_0) {
  if(isDefined(var_0)) {
    return var_0;
  }

  var_1 = spawnStruct();
  var_1.total = 0;
  var_1.set_flag_after_vo = 0;
  var_1.bridge_tank_move_sfx = 0;
  var_1.nextplayertospectate = 0;
  var_1.ref_12d24 = 0;
  var_1.ref_122ef = 0;
  var_1.openrightblimadoor = 0;
  return var_1;
}

function init_relic_gun_game(var_0) {
  self.total = train_play_anim(var_0);
  self.set_flag_after_vo = train_move_test_train_car_thread(var_0);
  self.bridge_tank_move_sfx = train_minimap_icon_attach(var_0);
  self.nextplayertospectate = train_minimap_icon_detach(var_0);
  self.ref_12d24 = trap_consoles(var_0);
}

function init_relic_headbullets(var_0) {
  if(!isDefined(var_0.spectatetestonprematchfadedone)) {
    self.ref_122ef = 1;
  } else {
    self.ref_122ef = var_0.spectatetestonprematchfadedone;
  }

  if(!isDefined(var_0.spawntimestamp)) {
    self.openrightblimadoor = 0;
    return;
  }

  self.openrightblimadoor = var_0.spawntimestamp;
}

function init_relic_healthpacks(var_0, var_1) {
  var_2 = init_relic_landlocked(var_1);
  init_relic_hideobjicons(var_2, var_0);
  return var_2;
}

function init_relic_landlocked(var_0) {
  if(isDefined(var_0)) {
    return var_0;
  }

  var_1 = spawnStruct();
  var_1.total = 0;
  var_1.set_flag_after_vo = 0;
  var_1.bridge_tank_move_sfx = 0;
  var_1.nextplayertospectate = 0;
  var_1.ref_12d24 = 0;
  return var_1;
}

function init_relic_hideobjicons(var_0) {
  self.total += var_0.total;
  self.set_flag_after_vo += var_0.set_flag_after_vo;
  self.bridge_tank_move_sfx += var_0.bridge_tank_move_sfx;
  self.nextplayertospectate += var_0.nextplayertospectate;

  if(var_0.ref_12d24 > self.ref_12d24) {
    self.ref_12d24 = var_0.ref_12d24;
    return;
  }
}

function setupkeybindings(var_0, var_1) {
  if(isDefined(level.ref_13457)) {
    [[level.ref_13457.ref_12540]](var_0, var_1.total, var_1.bridge_tank_move_sfx, var_1.nextplayertospectate);
    [[level.ref_13457.ref_12650]](var_0, var_1.ref_12d24);
    [[level.ref_13457.ref_125d1]](var_0, var_1.ref_122ef);
    [[level.ref_13457.ref_12556]](var_0, var_1.openrightblimadoor);
    return;
  }
}

function ref_11bcf(var_0, var_1) {
  switch (var_0.type) {
    case "br_mendota_intel":
    case "brloot_mendota_intel_icon":
    case "brloot_mendota_intel":
      trainent(var_0, var_1);
      return true;
  }

  return false;
}

function testaccessoryvfx() {
  if(getdvarint("scr_mendota_playtest", 0)) {
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  }

  level.decoyassists = &groundz;
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("useTokenToReviveTeammate");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulagWinnerRestoreLoadoutUseGulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("match_start_VO");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("firstCircleVo");

  if(getdvarint("scr_br_mxp_rebirth_only", 1) == 1) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  }

  if(getdvarint("scr_br_mxp_normal_circle", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizeCircleCenter");
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("planeUseCircleRadius");
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
    return;
  }
}

function toggleusbstickinhand() {
  waittillframeend();
  thread superterrainlightbakelodoverride();
  thread ref_127f7();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  scripts\mp\gametypes\br_pickups::ref_12b33("brloot_mendota_intel", &trial_gethitmarkerpriority);
}

function ref_127f7() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  scripts\mp\gametypes\br_gametypes::ref_12b11("preOnPlayerKilled", &onplayerkilled);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dangerCircleTick", &dangercircletick);
  level thread scripts\mp\gametypes\br_heavy_weapon_drop::init();
  level.ref_126c2 = [];
  level.ref_13748 = [];

  foreach(var_1 in level.players) {
    trial_dogtags(var_1);
    var_2 = var_1 getentitynumber();
    level.ref_126c2[var_2] = init_relic_grounded();
    level.ref_13748[var_1.team] = init_relic_landlocked(level.ref_13748[var_1.team]);
    ref_12604(var_1);
  }

  thread iscarriablescriptable();
}

function subtract_from_spawn_count_from_group() {
  wait 1;
  game["dialog"]["gametype"] = "gametype_titan";
  game["dialog"]["primary_objective"] = "gametype_desc_titan";
  game["dialog"]["secondary_objective"] = "oshkosh_intel_available";
  game["dialog"]["circles_resurgence"] = "oshkosh_circle_close_titan";
  game["dialog"]["circles_final"] = "oshkosh_circle_close_laststand";
  game["dialog"]["collected_monarch_intel"] = "oshkosh_intel_acquired";
}

function achievementtrackerforkills() {}

function dangercircletick(var_0, var_1) {
  var_2 = var_0;
  var_3 = var_1;
  isbotmedicrole(var_2, var_3, level.dogtags, &train_associate_models_with_brushes);
  isbotmedicrole(var_2, var_3, level.train_hurt_damage_watcher, &train_get_anim_ents_index);
  isbotmedicrole(var_2, var_3, level.shutdownattractionicontrigger, &scripts\mp\gametypes\br_heavy_weapon_drop::shut_down_laser_trap);
}

function isbotmedicrole(var_0, var_1, var_2, var_3) {
  var_4 = var_1 * var_1;

  foreach(var_6 in var_2) {
    if(isDefined(var_6) && distance2dsquared(var_6.origin, var_0) > var_4) {
      var_6[[var_3]]();
    }
  }
}

function ref_11b16() {
  return false;
}

function ref_125bd(var_0, var_1) {
  self endon("disconnect");

  if(!isDefined(var_0)) {
    if(level.ref_11bce.ref_12c9a) {
      self.chopper_boss_combat_actions = 1;
      var_2 = level.ref_11bce.ref_12c9a;
      wait 3;

      while(istrue(self.killcam)) {
        waitframe();
      }

      thread ref_1336e(var_2);
      thread scripts\mp\gametypes\br_spectate::spawnspectator(self, 0, 1);
      wait var_2;
      self.chopper_boss_combat_actions = undefined;
      return true;
    }
  }

  return false;
}

function ref_13dcb(var_0) {
  return true;
}

function assignspectatortospectateplayer(var_0, var_1) {
  var_0 notify("assignSpectatorToSpectatePlayerWaitForTeam");

  if(istrue(level.endmatchcameratransitions)) {
    return false;
  }

  if(!isDefined(var_1) || !isPlayer(var_1) || !isalive(var_1) && !isDefined(var_1.ref_1391a)) {
    return false;
  }

  if(var_0.team == var_1.team) {
    return false;
  }

  if(!scripts\mp\utility\teams::getteamdata(var_0.team, "aliveCount")) {
    return false;
  }

  var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 1);

  if(var_2.size == 0) {
    return false;
  }

  thread cargo_truck_mg_mp_init(var_0);
  return true;
}

function cargo_truck_mg_mp_init(var_0) {
  level endon("brSpawnPlayersEnding");
  var_0 endon("assignSpectatorToSpectatePlayerWaitForTeam");
  var_0 endon("death_or_disconnect");
  var_0 scripts\mp\gametypes\br_spectate::ref_126ab();
  var_0 setclientomnvar("ui_show_spectateHud", var_0 getentitynumber());
  wait 1;
  var_1 = scripts\mp\gametypes\br_spectate::regive_killstreak_after_use(var_0);
  thread scripts\mp\gametypes\br_spectate::assignspectatortospectateplayer(var_0, var_1);
}

function onplayerspawned() {
  if(isDefined(level.ref_142d1)) {
    self visionsetnakedforplayer(level.ref_142d1, 0);
  }

  thread ref_14012();
  trial_dogtags();
}

function onplayerkilled(var_0) {
  if(!istrue(level.disable_super_in_turret.ref_12ca4)) {
    thread juggerbear();
  }

  var_1 = var_0.inflictor;
  var_2 = var_0.attacker;

  if(isDefined(var_2) && (!isDefined(var_1) || var_1.classname != "trigger_multiple" && var_1.classname != "trigger_hurt")) {
    var_3 = getdvarint("scr_br_mxp_intel_dropped_on_death", 5);
    thread train_initcollision(level, self, var_2);
  }

  if(getdvarint("scr_br_mxp_rebirth_only", 1) == 0 && !istrue(level.disable_super_in_turret.ref_12ca4)) {
    scripts\mp\gametypes\br_gulag::trygulagspawn();
  }

  if(istrue(level.disable_super_in_turret.brlootchoppercratedestroycallback)) {
    scripts\mp\gametypes\br_alt_mode_mxp::playertransfertomahanger(var_2, self);
    return;
  }
}

function ref_14148() {
  while(!isDefined(level.vehicles) || !isDefined(level.vehicles.damagecallbacks)) {
    wait 0.1;
  }

  scripts\mp\vehicles\damage::set_post_mod_damage_callback("atv", &ref_14202);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("cargo_truck", &ref_14202);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("jeep", &ref_14202);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("tac_rover", &ref_14202);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("little_bird", &ref_14202);
}

function ref_14202(var_0) {
  if(isDefined(var_0.direction_vec) && isDefined(var_0.meansofdeath) && isexplosivedamagemod(var_0.meansofdeath)) {
    var_1 = level.ref_11bce.ref_14199;
    var_2 = level.ref_11bce.ref_14198;
    self method_87c1(var_0.direction_vec + var_1, var_2);
  }

  return true;
}

function ref_12604() {
  if(!isDefined(self.ref_12eb0)) {
    var_0 = getcompleteweaponname(level.ref_11bce.ref_13857);
    var_1 = scripts\mp\class::fixcollision(level.ref_11bce.ref_13858, "camo_01b", undefined, -1);
    var_2 = getcompleteweaponname(level.ref_11bce.ref_13856);
    var_3 = scripts\mp\equipment::getequipmentreffromweapon(var_2);
    self giveweapon(var_0);
    self giveweapon(var_1);
    self switchtoweaponimmediate(var_1);
    self assignweaponprimaryslot(var_1);
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, "brloot_ammo_919", var_1.clipsize * 2);
    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
    self notify("ammo_update");
    scripts\mp\equipment::giveequipment(var_3, "primary");
    scripts\mp\weapons::fixupplayerweapons(self, var_1);
  } else {
    ref_125fb();
  }

  scripts\mp\gametypes\br_armor::scriptablescurid(150);
}

function trial_active_fob(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(var_3 == 0) {
    return;
  }

  if(isDefined(var_0) && isDefined(var_1)) {
    return trial_alternate_progression(var_0, var_1, var_3);
  }

  if(isDefined(var_2)) {
    return trial_ai_spawn_far(var_2, var_0, var_3);
  }
}

function trial_alternate_progression(var_0, var_1, var_2) {
  if(!train_array(var_0)) {
    return;
  }

  var_3 = trial_ai_spawn_far(var_0.origin, var_0, var_2);
  trial_callback_ai_damage(var_3, var_0, var_1);
  return var_3;
}

function train_array(var_0) {
  if(isagent(var_0)) {
    return false;
  }

  return true;
}

function trial_combo(var_0) {
  if(level.ref_11bce.triage_glass_break >= 1) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

  foreach(var_3 in var_1) {
    self disablescriptableplayeruse(var_3);
  }
}

function trial_callback_ai_damage(var_0, var_1) {
  var_1 = train_sfx_init(var_1);
  self.team = var_0.team;
  self.victim = var_0;
  self.victimteam = var_0.team;
  self.attacker = var_1;
  self.attackerteam = var_1.team;
  self.owner = var_0;
  self.ownerteam = var_0.team;
}

function trial_ai_spawn_far(var_0, var_1, var_2) {
  var_3 = trial_active_ring(var_0, var_1, var_2);
  trial_celebration_flares(var_3, var_2);
  trial_dlog_clear(var_3, var_2);
  trial_combo(var_3, var_1);
  trial_dlog_lava(var_3, var_1);
  return var_3;
}

function trial_gethitmarkerpriority() {
  self.spawntime = gettime();
  var_0 = train_elements_enable(self.count);
  trial_celebration_flares(var_0);
}

function trial_active_ring(var_0, var_1, var_2) {
  var_0 += trial_callback_ai_killed(var_1);
  var_3 = trial_ai(var_0, var_1, var_2);
  var_3.spawntime = gettime();
  return var_3;
}

function trial_ai(var_0, var_1, var_2) {
  var_3 = undefined;

  switch (var_2) {
    case 10:
    case 9:
    case 8:
    case 7:
    case 6:
      var_3 = trial_dlog_arm_course(var_0, var_1);
      break;
    case 5:
    case 4:
    case 3:
    case 2:
    case 1:
    default:
      var_3 = trial_ai_jugg(var_0);
      break;
  }

  return var_3;
}

function trial_dlog_arm_course(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = var_1 getentitynumber();
  }

  var_3 = easepower("brloot_mendota_intel_icon", var_0, undefined, undefined, var_2);
  scripts\mp\gametypes\br_pickups::ref_12b3a(var_3);
  return var_3;
}

function trial_ai_jugg(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("military_intel_br_mendota");
  return var_1;
}

function trial_callback_ai_killed(var_0) {
  if(!isDefined(var_0)) {
    return (0, 0, 14);
  }

  var_1 = (0, 0, 0);
  var_2 = var_0.angles;

  if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var_2 = self getworldupreferenceangles();
    var_1 = anglestoup(var_2);

    if(var_1[2] < 0) {
      return (0, 0, -14);
    }
  }

  return (0, 0, 14);
}

function trial_celebration_flares(var_0) {
  trial_dlog_race(var_0);
  trial_civilians_killed();
  trial_delete_out_of_bounds();
}

function trial_dlog_race(var_0) {
  var_1 = undefined;

  if(train_wzcircle_override()) {
    var_1 = "" + self getentitynumber();
  } else {
    var_1 = self.index;
  }

  self.start_reach_wind_room = var_1;
  level.dogtags[var_1] = self;
  trial_dlog_sniper(var_0);
}

function trial_dlog_sniper(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self.count = trial_dogtag_setup(var_0);
}

function trial_dlog_clear(var_0) {
  if(train_wzcircle_override()) {
    trial_dlog_func(var_0);
    return;
  }

  trial_dlog_gun(var_0);
}

function trial_dlog_func(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  switch (var_0) {
    case 2:
      self hudoutlineenable("outline_depth_green");
      break;
    case 3:
      self hudoutlineenable("outline_depth_cyan");
      break;
    case 4:
      self hudoutlineenable("outline_depth_purple");
      break;
    case 5:
      self hudoutlineenable("outline_depth_orange");
      break;
    case 1:
    default:
      self hudoutlineenable("outline_depth_white");
      break;
  }
}

function trial_dlog_gun(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 6;
  }

  switch (var_0) {
    case 7:
      self setscriptablepartstate("brloot_mendota_intel", "green");
      break;
    case 8:
      self setscriptablepartstate("brloot_mendota_intel", "cyan");
      break;
    case 9:
      self setscriptablepartstate("brloot_mendota_intel", "orange");
      break;
    case 10:
      self setscriptablepartstate("brloot_mendota_intel", "red");
      break;
    case 6:
    default:
      self setscriptablepartstate("brloot_mendota_intel", "white");
      break;
  }
}

function trial_civilians_killed() {
  if(level.dogtags.size > level.ref_11bce.intelmax) {
    level.dogtags = scripts\engine\utility::array_removeundefined(level.dogtags);
  }

  if(level.dogtags.size > level.ref_11bce.intelmax) {
    var_0 = undefined;

    foreach(var_2 in level.dogtags) {
      if(!isDefined(var_0) || var_2.spawntime < var_0.spawntime) {
        var_0 = var_2;
      }
    }

    train_associate_models_with_brushes(var_0);
    return;
  }
}

function trial_delete_out_of_bounds() {
  if(!train_wzcircle_override()) {
    return;
  }

  self setasgametypeobjective();
  trial_dlog_jugg();
}

function trial_dlog_jugg() {
  var_0 = train_play_anim_init();

  if(isDefined(level.dogtags[var_0].objidnum)) {
    if(level.dogtags[var_0].objidnum != -1) {
      var_1 = level.dogtags[var_0].objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(var_1, "current");
      scripts\mp\objidpoolmanager::update_objective_onentity(var_1, level.dogtags[var_0]);
      scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, 22);
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_1, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(level.dogtags[var_0].objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(level.dogtags[var_0].objidnum, 0);
      level.dogtags[var_0] scripts\mp\gameobjects::setobjectivestatusicons("waypoint_dogtags_friendly", "waypoint_dogtags");
      level.dogtags[var_0] scripts\mp\gameobjects::setvisibleteam("any");
      getbnetigrbattlepassxpmultiplier(var_1, 8858, 9843);
      getscriptcachecontents(var_1, 0.5, 1);
      return;
    }

    return;
  }
}

function trial_dlog_lava(var_0, var_1) {
  if(!train_wzcircle_override()) {
    return;
  }

  thread trial_dlog_pitcher(var_0, var_1);
}

function trial_dlog_pitcher(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  }

  var_2 = self.origin;
  var_3 = self.angles;

  if(isDefined(var_0)) {
    var_2 = var_0.origin;
    var_3 = var_0.angles;
  }

  var_4 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, var_2, var_3, var_0, undefined, undefined, undefined, 1);
  var_5 = var_4.origin;
  var_6 = abs(self.origin[2] - var_5[2]);
  var_7 = getdvarint("bg_gravity", 800);
  var_8 = sqrt(2 * var_6 / var_7) + 0.5;
  var_9 = trajectorycalculateinitialvelocity(self.origin, var_5, (0, 0, -1 * var_7), var_8);
  self movegravity(var_9, var_8);
  wait var_8;
  self.origin = var_5;

  if(isDefined(var_4.set_force_aitype_armored)) {
    self linkTo(var_4.set_force_aitype_armored);
    self.set_force_aitype_armored = var_4.set_force_aitype_armored;
    return;
  }
}

function trial_dlog_gunslinger() {
  self.offset3d = (0, 0, 16);
  self.curorigin = self.origin;
  scripts\mp\gameobjects::requestid(1, 1);
  self.type = "useObject";
  self.numtouching["axis"] = 0;
  self.numtouching["allies"] = 0;
}

function train_initcollision(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_2 = int(var_2);

  while(var_2 > 0) {
    var_3 = train_elements_enable(var_2);
    trial_active_fob(var_0, var_1, undefined, var_3);
    var_2 -= trial_dogtag_setup(var_3);
    waitframe();
  }
}

function trainent(var_0) {
  var_0 = train_sfx_init(var_0);

  if(intel_cancollect(var_0)) {
    var_1 = train_scriptable_attach_delay();
    var_2 = intel_onuse_internal(var_0, var_1, "ground");
    self.count = var_2;

    if(var_2 <= 0) {
      train_associate_models_with_brushes(var_0);
      return;
    }

    return;
  }
}

function intel_collectedmisc(var_0, var_1, var_2) {
  if(intel_cancollect(var_0)) {
    intel_onuse_internal(var_0, var_0, var_1, var_2);
    return;
  }
}

function intel_cancollect(var_0) {
  var_1 = train_mover_test(var_0);
  var_2 = traincylestolink(var_0);
  return var_1 < var_2;
}

function intel_onuse_internal(var_0, var_1, var_2) {
  traintracefails(var_0, var_1);
  traintracesuccesses(var_0);
  traintracerelpos(var_0);
  intel_onuse_handledialog(var_0);
  var_3 = train_stopper(var_0, var_1);
  transition_parachutestate(var_0);
  var_0 playlocalsound("mxp_intel_pickup");
  scripts\mp\gametypes\br_analytics::branalytics_modespecificscore(var_0, var_1, var_2);

  if(level.ref_11bce.intelreset >= 0) {
    var_4 = train_mover_test(var_0);
    var_5 = traincylestolink(var_0);

    if(var_4 >= var_5) {
      thread intel_reset(level, var_0);
    }
  }

  return var_3;
}

function train_sfx_init(var_0) {
  if(isDefined(var_0.owner)) {
    return var_0.owner;
  }

  return var_0;
}

function intel_onuse_handledialog(var_0) {
  if(!isDefined(var_0.b_mxp_intel_dialog_on_cooldown) || !var_0.b_mxp_intel_dialog_on_cooldown) {
    thread intel_pickupdialog();
    return;
  }
}

function intel_pickupdialog() {
  self.b_mxp_intel_dialog_on_cooldown = 1;
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("collected_monarch_intel", self);
  thread intel_dialogcooldown();
}

function intel_dialogcooldown() {
  self endon("disconnect");
  self endon("team_eliminated");
  wait level.ref_11bce.inteldialogcooldown;
  self.b_mxp_intel_dialog_on_cooldown = 0;
}

function traintracefails(var_0, var_1) {
  var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_1301e("mv_event_intel_3", var_1);

  if(!train_vfx_init(var_0)) {
    var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
    return;
  }
}

function trainmove() {
  transient_world_autolod_enabled("mxp_intel_pickup");
}

function transient_world_autolod_enabled(var_0) {
  var_1 = self.origin;
  playsoundatpos(var_1, var_0);
}

function traintracesuccesses(var_0) {
  transient_prefab_group(var_0);
  trainwaittime(var_0);
}

function transient_prefab_group(var_0) {
  if(train_vfx_init(var_0)) {
    var_0 scripts\mp\utility\stats::incpersstat("confirmed", 1);
    var_0 scripts\mp\persistence::statsetchild("round", "confirmed", var_0.pers["confirmed"]);
    return;
  }

  if(train_wzcircle_time_subtractfrom()) {
    var_0 scripts\mp\utility\stats::incpersstat("denied", 1);
    var_0 scripts\mp\persistence::statsetchild("round", "denied", var_0.pers["denied"]);
    return;
  }
}

function trainwaittime(var_0) {
  if(train_vfx_init(var_0)) {
    scripts\mp\gametypes\obj_dogtag::allyonuse(var_0);
    return;
  }

  if(train_wzcircle_time_subtractfrom()) {
    scripts\mp\gametypes\obj_dogtag::enemyonuse(var_0);
    return;
  }
}

function traintracerelpos(var_0) {
  var_0 thread scripts\mp\rank::scoreeventpopup("br_mendota_intel");

  if(train_vfx_init(var_0)) {
    if(isDefined(level.dogtagallyonusecb) && !level.gameended) {
      self thread[[level.dogtagallyonusecb]](var_0);
      return;
    }

    return;
  }

  if(isDefined(level.dogtagenemyonusecb) && !level.gameended) {
    self thread[[level.dogtagenemyonusecb]](var_0);
    return;
  }
}

function intel_isintel() {
  var_0 = self.scriptablename;

  if(!isDefined(var_0) && isDefined(self.tracknonoobplayerlocation)) {
    var_0 = self.tracknonoobplayerlocation.type;
  }

  if(!isDefined(var_0)) {
    return false;
  }

  if(var_0 == "brloot_mendota_intel_icon" || var_0 == "brloot_mendota_intel" || var_0 == "br_mendota_intel") {
    return true;
  }

  return false;
}

function train_wzcircle_time_subtractfrom() {
  return isDefined(self.victim);
}

function train_vfx_init(var_0) {
  if(!train_wzcircle_time_subtractfrom()) {
    return false;
  }

  return var_0.pers["team"] == self.victimteam;
}

function traincar_hurt(var_0) {
  if(!train_wzcircle_time_subtractfrom()) {
    return false;
  }

  return var_0 == self.victim;
}

function train_wzcircle_override() {
  if(isent(self)) {
    return true;
  }

  return false;
}

function train_play_anim_init() {
  if(isDefined(self.entity)) {
    return self.entity.start_reach_wind_room;
  }

  return self.start_reach_wind_room;
}

function train_scriptable_attach_delay() {
  if(isDefined(self.entity)) {
    if(!isDefined(self.entity.count)) {
      return 1;
    }

    return self.entity.count;
  }

  if(!isDefined(self.count)) {
    return 1;
  }

  return self.count;
}

function train_elements_enable(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 >= 20) {
    return 10;
  } else if(var_0 >= 10) {
    return 9;
  } else if(var_0 >= 5) {
    return 8;
  } else if(var_0 >= 3) {
    return 7;
  } else if(var_0 >= 1) {
    return 6;
  }

  return 0;
}

function trial_dogtag_setup(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = 0;

  switch (var_0) {
    case 7:
    case 2:
      var_1 = 3;
      break;
    case 8:
    case 3:
      var_1 = 5;
      break;
    case 9:
    case 4:
      var_1 = 10;
      break;
    case 10:
    case 5:
      var_1 = 20;
      break;
    case 6:
    case 1:
    default:
      var_1 = 1;
      break;
  }

  return var_1;
}

function train_associate_models_with_brushes(var_0) {
  thread train_attach_useable_ammorestocklocation(var_0);
}

function train_attach_useable_ammorestocklocation(var_0) {
  train_attach_models_to_assembly(var_0);
  train_car_audio();
  waitframe();

  if(isDefined(self)) {
    self notify("death");
    train_attach_brushes_to_models();
    train_attach_player_hurts();
    return;
  }
}

function train_attach_models_to_assembly(var_0) {
  if(train_wzcircle_time_subtractfrom()) {
    thread scripts\mp\gametypes\obj_dogtag::removetags(self.victim.guid, undefined, var_0);
    train_collision_item_valid();
    return;
  }
}

function train_collision_item_valid() {
  self.victim notify("tag_removed");
}

function train_car_audio() {
  playFX(level.conf_fx["vanish"], self.origin);
  self notify("reset");
}

function train_attach_brushes_to_models() {
  var_0 = train_play_anim_init();

  if(isDefined(var_0) && isDefined(level.dogtags[var_0])) {
    if(!isDefined(level.dogtags[var_0].skipminimapids)) {
      level.dogtags[var_0] scripts\mp\gameobjects::releaseid();
      self notify("deleted");
    }

    level.dogtags[var_0] = undefined;
    return;
  }
}

function train_attach_player_hurts() {
  if(isDefined(self.entity)) {
    self.entity delete();
    return;
  }

  if(train_wzcircle_override()) {
    self delete();
    return;
  }

  self freescriptable();
}

function tree_think(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.spotlight_sweep_to_loc_safe = var_0;
  var_2.playerwaittillstreamhintcomplete = var_1;
  return var_2;
}

function intel_reset(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 scripts\engine\utility::waittill_notify_or_timeout("death", var_1);
  var_0.spawnvector = 0;
  var_0.spawnselectionmarker = 0;
  var_0.spawnpoint_setspawnpoint = 0;
  var_0.spawntvfix = 0;
  var_0.splashtime_helis = 0;
  trial_dogtags(var_0);
}

function transition_parachutestate(var_0) {
  thread trap_toggle_logic(var_0);

  if(!train_vfx_init(var_0)) {
    trap_door_nvg_reset_catch(var_0);
    return;
  }
}

function trap_toggle_logic(var_0) {
  trenchdebug(var_0);
  triage_door_clip(var_0);
  traversenotvalid(var_0);
  traversal_disabled_by_management(var_0);
  thread ref_124ef();
}

function trap_door_nvg_reset_catch(var_0) {
  for(var_1 = 0; var_1 <= level.tread_sfx.size; var_1++) {
    if(trap_room_dogtag_revive(var_0, var_1)) {
      var_0[[level.tread_sfx[var_1].playerwaittillstreamhintcomplete]]();
      trap_room_turret_init(var_0);
    }
  }
}

function trap_room_dogtag_revive(var_0, var_1) {
  var_2 = train_mover_test(var_0);
  var_3 = trap_consoles(var_0);

  if(!isDefined(level.tread_sfx[var_3])) {
    return false;
  }

  var_4 = var_2 >= level.tread_sfx[var_3].spotlight_sweep_to_loc_safe;
  var_5 = var_1 == var_3;
  return var_4 && var_5;
}

function trenchdebug(var_0) {
  if(isDefined(var_0.vehicle)) {
    return;
  }

  if(level.ref_11bce.ref_11fea == 1) {
    thread ref_124ee();
    return;
  }
}

function triage_door_clip(var_0) {
  var_1 = self.count;

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(train_vfx_init(var_0)) {
    var_0 scripts\mp\rank::giverankxp("tag_denied", level.ref_11bce.on_intel_pickup_xp * var_1);
    return;
  }

  var_0 scripts\mp\rank::giverankxp("tag_collected", level.ref_11bce.on_intel_pickup_xp * var_1);
}

function travelspeed(var_0) {
  if(level.ref_11bce.ref_11fe6 == 1) {
    thread transition_to_airfield();
    return;
  }
}

function traversenotvalid(var_0) {
  if(level.ref_11bce.ref_11fe8 == 1) {
    self.health = self.maxhealth;
    return;
  }
}

function traversal_disabled_by_management(var_0) {
  if(level.ref_11bce.ref_11fe7 == 1) {
    var_0.br_armorhealth = var_0.br_maxarmorhealth;
    var_0 setclientomnvar("ui_br_armor_damage", 1);
    var_0 scripts\mp\equipment\armor_plate::debug_state(var_0.br_armorhealth);
    return;
  }
}

function transition_to_airfield() {
  self endon("death_or_disconnect");
  thread scripts\mp\equipment::givescavengerammo();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
}

function triage_ai_campers() {
  trap_room_wave_settings("uav");
}

function trap_toggle_fx_logic() {
  scripts\mp\gametypes\br_pickups::forcegivesuper("super_ammo_drop", 1, 0, 0);
  thread scripts\mp\hud_message::showsplash("br_field_upgrade_purchased");
}

function intel_reward_selfrevive() {
  intel_reward_item("brloot_self_revive", "br_gametype_mendota_intel_self_revive");
}

function trap_room_ents() {
  intel_reward_item("brloot_offhand_advancedlootdrop", "br_gametype_mendota_intel_heavy_weapons");
}

function transition_to_next_section() {
  scripts\mp\gametypes\br_pickups::forcegivesuper("super_armor_drop", 1, 0, 0);
  thread scripts\mp\hud_message::showsplash("br_field_upgrade_purchased");
}

function transitionplayersoutofac130cinematic() {
  trap_room_wave_settings("toma_strike");
}

function translate_and_rotate_from_level_overrides() {
  intel_reward_item("brloot_equip_gasmask", "br_gametype_mendota_intel_gas_mask");
}

function transitionac130tomovinganim() {
  thread scripts\mp\hud_message::showsplash("br_gametype_mendota_intel_satchel");

  if(getdvarint("scr_mendota_refill_armor", 1)) {
    var_0 = scripts\mp\gametypes\br_pickups::br_createcustompickupitem(self, "brloot_plate_pouch");
    var_1 = scripts\mp\gametypes\br_pickups::cantakepickup(var_0);

    if(var_1 == 1) {
      scripts\mp\gametypes\br_pickups::onusecompleted(var_0, 1);
      return;
    }

    if(var_1 == 15) {
      var_2 = scripts\engine\utility::ter_op(isDefined(self.equipment["health"]), scripts\mp\equipment::getequipmentslotammo("health"), 0);
      var_3 = scripts\mp\equipment::getequipmentmaxammo(level.br_pickups.br_equipname["brloot_armor_plate"]);

      if(var_2 < var_3) {
        scripts\mp\equipment::setequipmentslotammo("health", var_3);
        return;
      }

      return;
    }

    return;
  }

  intel_reward_item("brloot_plate_pouch", undefined);
}

function trap_trigger_logic() {
  intel_reward_item("brloot_offhand_kioskdrop", undefined);
}

function traps_disabled() {
  trap_room_wave_settings("precision_airstrike");
}

function transitionplayerstoac130cinematic() {
  thread scripts\mp\hud_message::showsplash("br_body_count_rewarded_extra_life");
  start_mine_caves();
}

function trap_timer_running() {
  intel_reward_item("brloot_offhand_advancedsupplydrop", "br_gametype_mendota_intel_loadout_drop");
}

function treerootnodesizebitcount() {
  thread scripts\mp\hud_message::showsplash("br_body_count_rewarded_specialist");
  scripts\mp\perks\perks::bears();
}

function transition_snd_org() {
  trap_room_wave_settings("directional_uav");
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("intel_reward", self, undefined, undefined, 1);
}

function trap_door_nvg_reset() {
  thread scripts\mp\hud_message::showsplash("br_gametype_mendota_intel_oshkosh");
  var_0 = isDefined(self.streakdata.streaks[1]);
  scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar("greenbay_strike", var_0, 1);
}

function intel_reward_item(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  scripts\mp\gametypes\br_pickups::br_forcegivecustomreward(self, var_0, 1, var_2);

  if(isDefined(var_1)) {
    thread scripts\mp\hud_message::showsplash(var_1);
    return;
  }
}

function trap_room_wave_settings(var_0) {
  var_1 = isDefined(self.streakdata.streaks[1]);
  scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar(var_0, var_1, 1);

  if(!level.gameended) {
    thread scripts\mp\hud_message::showkillstreaksplash(var_0);
    return;
  }
}

function train_play_anim() {
  var_0 = 0;
  var_0 += train_move_test_train_car_thread();
  var_0 += train_minimap_icon_attach();
  var_0 += train_minimap_icon_detach();
  return var_0;
}

function train_mover_test() {
  if(!isDefined(self.splashtime_helis)) {
    self.splashtime_helis = 0;
  }

  return self.splashtime_helis;
}

function train_move_test_train_car_thread() {
  if(!isDefined(self.spawntvfix)) {
    self.spawntvfix = 0;
  }

  return self.spawntvfix;
}

function train_minimap_icon_attach() {
  if(!isDefined(self.spawnpoint_setspawnpoint)) {
    self.spawnpoint_setspawnpoint = 0;
  }

  return self.spawnpoint_setspawnpoint;
}

function train_minimap_icon_detach() {
  if(!isDefined(self.spawnselectionmarker)) {
    self.spawnselectionmarker = 0;
  }

  return self.spawnselectionmarker;
}

function train_stopper(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_0 = int(var_0);
  var_1 = train_mover_test();
  var_2 = traincylestolink();
  var_3 = 0;

  if(var_1 + var_0 > var_2) {
    var_4 = var_2 - var_1;
    var_3 = var_0 - var_4;
    var_0 = var_4;
  }

  if(train_wzcircle_time_subtractfrom()) {
    if(train_vfx_init(self)) {
      train_stop(var_0);
    } else {
      train_tag_array(var_0);
    }
  } else {
    train_tagoffset_array(var_0);
  }

  trial_dogtags();
  return var_3;
}

function traincylestolink() {
  var_0 = level.tread_sfx[level.tread_sfx.size - 1];
  return var_0.spotlight_sweep_to_loc_safe;
}

function train_track_velocity(var_0) {
  self.splashtime_helis = train_mover_test();

  if(isDefined(var_0)) {
    self.splashtime_helis += var_0;
    return;
  }

  self.splashtime_helis++;
}

function train_tagoffset_array(var_0) {
  self.spawntvfix = train_move_test_train_car_thread();

  if(isDefined(var_0)) {
    self.spawntvfix += var_0;
  } else {
    self.spawntvfix++;
  }

  train_track_velocity(var_0);
}

function train_stop(var_0) {
  self.spawnpoint_setspawnpoint = train_minimap_icon_attach();

  if(isDefined(var_0)) {
    self.spawnpoint_setspawnpoint += var_0;
    return;
  }

  self.spawnpoint_setspawnpoint++;
}

function train_tag_array(var_0) {
  self.spawnselectionmarker = train_minimap_icon_detach();

  if(isDefined(var_0)) {
    self.spawnselectionmarker += var_0;
  } else {
    self.spawnselectionmarker++;
  }

  train_track_velocity(var_0);
}

function train_init_as_vehicle(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_0 = int(var_0);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    train_init_lootcrates_on_train();
  }

  trial_dogtags();
}

function train_init_lootcrates_on_train() {
  self.splashtime_helis = train_mover_test();
  self.splashtime_helis--;

  if(self.splashtime_helis < 0) {
    self.splashtime_helis = 0;
    return;
  }
}

function trial_dogtags() {
  var_0 = train_mover_test();
  var_1 = trap_consoles();
  var_2 = trap_array();
  var_3 = propremovefromcircle();
  var_4 = 0;
  var_4 += var_0 * 100000;
  var_4 += var_1 * 1000;
  var_4 += int(floor(var_2 * 100)) * 10;
  var_4 += var_3;
  self setclientomnvar("ui_br_bodycount_reward_data", var_4);
}

function trap_room_turret_init() {
  self.spawnvector = trap_consoles();
  self.spawnvector++;
  trial_dogtags();
}

function trap_consoles() {
  if(!isDefined(self.spawnvector)) {
    self.spawnvector = 0;
  }

  return self.spawnvector;
}

function trap_array() {
  var_0 = train_mover_test();
  var_1 = 0;

  for(var_2 = 0; var_2 < level.tread_sfx.size; var_2++) {
    var_3 = level.tread_sfx[var_2].spotlight_sweep_to_loc_safe;

    if(var_0 > var_1 && var_0 < var_3) {
      return ((var_0 - var_1) / (var_3 - var_1));
    }

    var_1 = var_3;
  }

  return 0;
}

function init_locations() {
  if(isDefined(level.ref_11e18.seq3_tanksettings)) {
    var_0 = 0;
    var_1 = "gf";

    foreach(var_3 in level.ref_11e18.seq3_tanksettings) {
      var_4 = var_1 + scripts\engine\utility::string(var_0);
      ref_12aea(var_4, 1, var_3);
      var_0++;
    }
  }

  if(!isDefined(level.ref_11bce.area_structs) || level.ref_11bce.area_structs.size <= 0) {
    ref_12aea("default", 1, (0, 0, 0));
    return;
  }
}

function ref_12aea(var_0, var_1, var_2) {
  if(!isDefined(level.ref_11bce.area_structs)) {
    level.ref_11bce.area_structs = [];
  }

  var_1 = getdvarint("scr_mendota_location_weight_" + var_0, var_1);

  if(var_1 <= 0) {
    return;
  }

  var_2.ref_13902 = var_0;
  var_2.spotlights = var_1;
  var_2.ref_140b7 = var_2.origin;
  level.ref_11bce.area_structs[var_0] = var_2;
}

function groundz() {
  ref_12fdc();
  thread bindingpc();

  if(getdvarint("scr_br_mxp_normal_circle", 0) == 0) {
    if(istrue(level.ref_11bce.ref_1409d)) {
      level.grouptorewards = (0, 0, 0);
    }

    level.br_level.br_circledelaytimes = level.ref_11bce.groundentity;
    level.br_level.br_circleclosetimes = level.ref_11bce.ground_spawners;

    if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
      level.br_level.br_circleradii = [16000, 16000, 12500, 9500, 6500, 2000, 300, 0];
      level.br_level.br_circleminimapradii = [9000, 9000, 7750, 6500, 4500, 3500, 2500];
      level.br_level.default_player_connect_black_screen = [0, 0, 0, 0, 0, 0, 0];
      level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0];
      return;
    }

    level.br_level.br_circleradii = [72500, 72500, 50000, 32500, 20000, 11500, 7000, 2000, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 8000, 6500, 5500, 5500];
    level.br_level.default_player_connect_black_screen = [0, 0, 0, 0, 0, 0, 0, 0];
    level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0, 0];
    return;
  }
}

function ref_12fdc() {
  level.ref_11bce.ref_12e2c = ref_12d7f();
  var_0 = level.ref_11bce.ref_12e2c.ref_140b7;
  level.grouptorewards = move_point_by_set_distance(var_0, get_closest_k_fresno_point(var_0), level.ref_11bce.finalcircledistfromfresno);
}

function ref_12d7f() {
  if(isDefined(level.ref_11bce.ref_13903) && level.ref_11bce.ref_13903 != "random") {
    foreach(var_1 in level.ref_11bce.area_structs) {
      if(level.ref_11bce.ref_13903 == var_2) {
        return var_1;
      }
    }
  }

  if(level.ref_11bce.area_structs.size == 1) {
    foreach(var_4 in level.ref_11bce.area_structs) {
      return var_4;
    }

    var_4 = undefined;
  }

  var_6 = 0;

  foreach(var_1 in level.ref_11bce.area_structs) {
    var_6 += var_1.spotlights;
  }

  var_9 = randomintrange(0, var_6);

  foreach(var_1 in level.ref_11bce.area_structs) {
    if(var_9 < var_1.spotlights) {
      return var_1;
    }

    var_9 -= var_1.spotlights;
  }

  level.ref_11bce.area_structs = scripts\engine\utility::array_randomize(level.ref_11bce.area_structs);
  return level.ref_11bce.area_structs[0];
}

function bindingpc() {
  level endon("game_ended");
  level waittill("calc_circle_centers");
  var_0 = (0, 0, 0);

  foreach(var_2 in level.ref_11e18.wait_for_player_eliminated) {
    var_0 += var_2;
  }

  var_0 /= level.ref_11e18.wait_for_player_eliminated.size;
  var_4 = level.ref_11bce.firstcirclemaxdistfromcenter;
  level.br_level.default_class_chosen[1] = check_dist_from_point_move_if_needed(level.br_level.default_class_chosen[1], var_0, var_4);
  level.br_level.default_class_chosen[0] = level.br_level.default_class_chosen[1];
  level.br_level.default_class_chosen[2] = check_dist_from_point_move_if_needed(level.br_level.default_class_chosen[2], var_0, var_4);
  check_fresno_points_move_if_needed(3, 1, 1);
  check_fresno_points_move_if_needed(4, 1, 0);
  check_fresno_points_move_if_needed(5, 1, 0);
  level.br_level.default_class_chosen[6] = level.br_level.default_class_chosen[8];
  level.br_level.default_class_chosen[6] = move_point_by_set_distance(level.br_level.default_class_chosen[6], level.ref_11bce.ref_12e2c.ref_140b7, 500);
  level.br_level.default_class_chosen[7] = level.br_level.default_class_chosen[8];

  for(var_5 = 9; var_5 < level.br_level.default_class_chosen.size; var_5++) {
    if(!scripts\mp\gametypes\br_circle::vandalize_minigun_speed(level.br_level.default_class_chosen[var_5], 1)) {
      var_6 = distance2d(level.br_level.default_class_chosen[var_5], level.grouptorewards);
      level.br_level.default_class_chosen[var_5] = move_point_by_set_distance(level.br_level.default_class_chosen[var_5], level.grouptorewards, var_6 / 2);
    }
  }
}

function check_fresno_points_move_if_needed(var_0, var_1, var_2) {
  var_3 = level.br_level.default_class_chosen[var_0];
  var_4 = level.br_level.br_circleradii[var_0];
  var_5 = check_fresno_points_in_circle(var_0);
  var_6 = var_5["greenbay"];
  var_7 = var_5["kenosha"];

  if(var_1 && var_2) {
    if(var_6 && var_7) {
      return;
    }
  }

  if(var_1 && !var_6) {
    var_8 = distance2d(var_3, level.ref_11bce.ref_12e2c.ref_140b7) - var_4;
    level.br_level.default_class_chosen[var_0] = move_point_by_set_distance(var_3, level.ref_11bce.ref_12e2c.ref_140b7, var_8 + 5000);
  }

  if(var_2 && !var_7) {
    var_8 = distance2d(var_3, level.ref_11bce.ref_12e2c.ref_140b7) - var_4;
    level.br_level.default_class_chosen[var_0] = move_point_by_set_distance(var_3, level.ref_11bce.ref_12e2c.ref_140b7, var_8 + 5000);
    return;
  }
}

function check_fresno_points_in_circle(var_0) {
  var_1 = [];
  var_2 = 0;
  var_3 = 0;
  var_4 = level.br_level.default_class_chosen[var_0];
  var_5 = level.br_level.br_circleradii[var_0];

  foreach(var_7 in level.ref_11e18.seq3_tanksettings) {
    if(scripts\engine\utility::updatescrapassistdata(var_7.origin, var_4, var_5)) {
      var_2++;
    }
  }

  foreach(var_10 in level.ref_11e18.wait_for_player_eliminated) {
    if(scripts\engine\utility::updatescrapassistdata(var_10, var_4, var_5)) {
      var_3++;
    }
  }

  var_1 = var_2;
  var_1 = var_3;
  return var_1;
}

function check_dist_from_point_move_if_needed(var_0, var_1, var_2) {
  var_3 = distance2d(var_0, var_1);

  if(var_3 > var_2) {
    var_4 = var_3 - var_2;
    return move_point_by_set_distance(var_0, var_1, var_4);
  }

  return var_1;
}

function ref_12181() {
  var_0 = getdvarvector("br_final_circle_override", level.grouptorewards);
  return var_0;
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

function superterrainlightbakelodoverride() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("intel_crate");
  var_0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var_0.dummymodel = "military_carepackage_02_br_s3";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.minimapicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 0;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = &trial_enemy_dont_drop_weapon;
  var_0.capturecallback = &trial_enemy_quota;
  var_0.destroyoncapture = 1;
}

function train_handle_collide_crate_br(var_0) {
  level notify("intel_crate_event_check");
  level endon("intel_crate_event_check");

  if(scripts\mp\gametypes\br_publicevent_fresno::isfresnoactive()) {
    var_1 = scripts\mp\gametypes\br_publicevent_fresno::getfresnotimeremaining();
    wait var_1;
  }

  thread ref_13571();
}

function ref_13571(var_0) {
  if(!level.ref_11bce.train_lootcrates_save_offsets) {
    return;
  }

  if(!istrue(var_0)) {
    wait randomintrange(level.ref_11bce.ref_11beb, level.ref_11bce.ref_11b49);
  }

  var_1 = [];
  var_2 = scripts\mp\gametypes\br_alt_mode_mxp::sappliedstages();
  level.ref_11e18.score_event_headshot = var_2[0];
  var_3 = var_2[1];
  var_2 = undefined;

  if(isDefined(var_3)) {
    var_4 = spawnStruct();
    var_4.origin = var_3;
    var_4.index = level.ref_11e18.score_event_headshot;
    var_4.type = "g";
    var_1 = var_4;
  }

  var_5 = scripts\mp\gametypes\br_alt_mode_mxp::vehicletrail();
  level.ref_11e18.wait_and_destroy = var_5[0];
  var_3 = var_5[1];
  var_5 = undefined;

  if(isDefined(var_3)) {
    var_4 = spawnStruct();
    var_4.origin = var_3;
    var_4.index = level.ref_11e18.wait_and_destroy;
    var_4.type = "k";
    var_1 = var_4;
  }

  if(var_1.size > 0) {
    foreach(var_7 in level.players) {
      var_7 scripts\mp\hud_message::showsplash("br_gametype_mendota_crate_event");
    }
  }

  for(var_9 = 0; var_9 < var_1.size; var_9++) {
    var_10 = randomint(360);

    for(var_11 = 0; var_11 < level.ref_11bce.ref_11f1e; var_11++) {
      var_12 = var_10 + 90;
      var_13 = 0;
      var_14 = undefined;
      var_15 = 0;

      while(var_15 < 360) {
        var_16 = (0, var_12 + var_15, 0);
        var_17 = anglesToForward(var_16);
        var_4 = var_1[var_9];
        var_14 = var_4.origin + var_17 * level.ref_11bce.train_get_num_of_anim_ents[var_4.type];

        if(!scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_14) || updatesquadleaderpassstateforteam(var_14)) {} else if(!isDefined(level.br_circle.dangercircleent) || scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_14)) {
          var_13 = 1;
          break;
        }

        var_15 += 10;
      }

      if(!var_13) {
        break;
      }

      var_10 = var_12;
      var_18 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_14);
      var_18 += (0, 0, 2000);
      var_19 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "intel_crate", var_18, (0, randomint(360), 0));
      var_19.trial_flares = var_1[var_9];
      var_20 = randomfloatrange(level.ref_11bce.trial_fetch_mission_table, level.ref_11bce.trial_explosive_clear) * 1000;
      var_19.trial_flares.expiretime = gettime() + var_20;
      level.train_hurt_damage_watcher[level.train_hurt_damage_watcher.size] = var_19;
      thread train_handle_collide_mines();
      thread train_horn_sfx();
    }
  }
}

function updatesquadleaderpassstateforteam(var_0) {
  var_1 = getEntArray("trigger_hurt", "classname");

  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0, var_3)) {
      return true;
    }
  }

  if(isDefined(level.outofboundstriggers)) {
    foreach(var_3 in level.outofboundstriggers) {
      if(ispointinvolume(var_0, var_3)) {
        return true;
      }
    }
  }

  return false;
}

function trial_enemy_dont_drop_weapon(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
      return;
    }

    return;
  }
}

function trial_enemy_quota(var_0) {
  thread trial_flare_destruct_missile(self);
  self notify("captured");
  var_1 = train_elements_enable(level.ref_11bce.infil_light_dvars);
  var_2 = trial_ai_spawn_far(self.origin + (0, 0, 16), undefined, var_1);

  if(isDefined(self.objectiveiconid)) {
    objective_delete(self.objectiveiconid);
  }

  playFX(level.conf_fx["vanish"], self.molotov_delete_oldest_trigger.origin);
  self.molotov_delete_oldest_trigger delete();
}

function trial_flare_destruct_missile(var_0) {
  var_1 = var_0.trial_flares;
  level.train_hurt_damage_watcher = scripts\engine\utility::array_remove(level.train_hurt_damage_watcher, var_0);
  var_2 = 0;

  foreach(var_4 in level.train_hurt_damage_watcher) {
    if(isDefined(var_4) && var_4.trial_flares.type == var_1.type && var_4.trial_flares.index == var_1.index) {
      var_2 = 1;
      break;
    }
  }

  if(!var_2) {
    if(var_1.type == "k") {
      level.ref_11e18.wait_and_destroy = undefined;
      return;
    }

    level.ref_11e18.score_event_headshot = undefined;
    return;
  }
}

function train_handle_collide_mines() {
  var_0 = scripts\mp\gametypes\br_public::modifyplayer_damage(self.origin, 50, -3000);
  self.molotov_delete_oldest_trigger = spawn("script_model", var_0 + (0, 0, 3));
  self.molotov_delete_oldest_trigger setModel("scr_smoke_grenade");
  wait 1;
  self.molotov_delete_oldest_trigger playLoopSound("mp_flare_burn_lp");
  self.molotov_delete_oldest_trigger setscriptablepartstate("smoke", "on");
}

function train_horn_sfx() {
  self setscriptablepartstate("objective", "intel");
}

function train_get_anim_ents_index() {
  if(isDefined(self) && !istrue(self.isdestroyed)) {
    thread train_get_anim_to_play();
    return;
  }
}

function train_get_anim_to_play() {
  self.molotov_delete_oldest_trigger delete();
  playFX(level.conf_fx["vanish"], self.origin);
  trial_flare_destruct_missile(self);
  scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

function circletimer(var_0) {
  if(istrue(level.disable_super_in_turret.ref_12ca4)) {
    var_1 = scripts\mp\gametypes\br_gametype_rebirth::rocket_attack_min_cooldown();

    if(var_0 >= var_1) {
      scripts\mp\gametypes\br_gametype_rebirth::loadoutcustomperkdiscount();
    }
  }

  if(var_0 >= 2) {
    level.ref_11bce.ref_12c9a += level.ref_11bce.ref_12c99;
  }

  if(var_0 == level.ref_11bce.vo_while_reviving) {
    _getrandomlocations::vehicle_spawn_abandonedtimeoutcallback(1);
    _getrandomlocations::sequence_progression(1);
  }

  if(var_0 >= level.ref_11bce.ref_11bea && var_0 <= level.ref_11bce.ref_11b48) {
    thread train_handle_collide_crate_br(var_0);
  }

  return false;
}

function lb_dmg_factor_tail_stabilizer() {
  foreach(var_1 in level.train_hurt_damage_watcher) {
    train_get_anim_ents_index(var_1);
  }
}

function initcratedata(var_0) {
  scripts\mp\gametypes\fresno\fresno_screamer::initcratedata(var_0);
}

function active_fob_think() {}

function move_point_by_set_percent(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_3 = var_1 - var_0;
  return var_0 + var_3 * var_2;
}

function move_point_by_set_distance(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_3 = vectorNormalize(var_1 - var_0);
  return var_0 + var_3 * var_2;
}

function get_closest_k_fresno_point(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.ref_11e18.wait_for_player_eliminated) {
    var_5 = distance2dsquared(var_0, var_4);

    if(!isDefined(var_2) || var_5 < var_2) {
      var_2 = var_5;
      var_1 = var_4;
    }
  }

  return var_1;
}

function ref_124ee() {
  if(!isDefined(self.operatorcustomization) || !isDefined(self.operatorcustomization.suit)) {
    return;
  }

  if(self.operatorcustomization.suit == "actionhero_mp") {
    thread ref_1247e();
    return;
  }

  self.ref_12147 = self.operatorcustomization.suit;
  self.operatorcustomization.suit = "actionhero_mp";
  scripts\mp\utility\player::_setsuit("actionhero_mp");
  thread ref_1247e();
}

function ref_1247e() {
  self notify("custom_suit_start");
  self endon("custom_suit_start");
  self endon("disconnect");
  scripts\engine\utility::ref_143b9(level.ref_11bce.ref_11fe9, "death");

  if(isDefined(self.ref_12147) && self.operatorcustomization.suit != self.ref_12147) {
    self.operatorcustomization.suit = self.ref_12147;
    scripts\mp\utility\player::_setsuit(self.ref_12147);
    self.ref_12147 = undefined;
    return;
  }
}

function ref_124ef() {
  self notify("player_set_infinate_super_sprint");
  self endon("player_set_infinate_super_sprint");
  self endon("death_or_disconnect");
  self refreshsprinttime();
  var_0 = 0;
  thread transient_world_proxy_collision_distance();
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("zombiedefault");

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    scripts\mp\utility\perk::giveperk("specialty_sprintmelee");
    scripts\mp\utility\perk::giveperk("specialty_sprintads");
    scripts\mp\utility\perk::giveperk("specialty_marathon");
  }

  while(var_0 < level.ref_11bce.ref_11fe9) {
    if(self issupersprinting()) {
      self refreshsprinttime();
    }

    wait 0.1;
    var_0 += 0.1;
  }

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    if(isDefined(self.perks["specialty_sprintmelee"])) {
      scripts\mp\utility\perk::removeperk("specialty_sprintmelee");
    }

    if(isDefined(self.perks["specialty_sprintads"])) {
      scripts\mp\utility\perk::removeperk("specialty_sprintads");
    }

    if(isDefined(self.perks["specialty_marathon"])) {
      scripts\mp\utility\perk::removeperk("specialty_marathon");
    }
  }

  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("default_2seconds");
}

function transient_world_proxy_collision_distance() {
  self notify("reset_timer");
  waitframe();
  self setclientomnvar("ui_privateevent_timer_type", 4);
  var_0 = level.ref_11bce.ref_11fe9;
  var_1 = gettime() + var_0 * 1000;
  self setclientomnvar("ui_privateevent_timer", var_1);
  scripts\engine\utility::ref_143ba(level.ref_11bce.ref_11fe9, "reset_timer", "death");
  self setclientomnvar("ui_privateevent_timer_type", 0);
}

function ref_12646() {
  if(isalive(self)) {
    ref_14012();
    trial_dogtags();
    return;
  }
}

function ref_12a7c() {
  scripts\mp\gametypes\br_gametypes::ref_13f25("mayConsiderPlayerDead");
}

function ref_14012() {
  if(!istrue(level.disable_super_in_turret.ref_12ca4) && scripts\mp\flags::gameflag("prematch_done")) {
    if(propremovefromcircle()) {
      if(!scripts\mp\gametypes\br_public::hasrespawntoken()) {
        scripts\mp\gametypes\br_pickups::addrespawntoken(1);
        return;
      }

      return;
    }

    if(scripts\mp\gametypes\br_public::hasrespawntoken()) {
      scripts\mp\gametypes\br_pickups::removerespawntoken();
      return;
    }

    return;
  }
}

function ref_1336e(var_0) {
  waittillframeend();
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_0 * 1000));
  scripts\mp\gametypes\br_gulag::ref_131a2(1);
  thread spawn_drones(var_0);
}

function spawn_drones(var_0) {
  self endon("disconnect");

  if(isDefined(var_0)) {
    wait var_0;
  }

  scripts\mp\gametypes\br_gulag::ref_131a2(0);
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

function propremovefromcircle() {
  if(!isDefined(self.spawnsystem_init)) {
    self.spawnsystem_init = level.ref_11bce.ref_1385a;
  }

  return self.spawnsystem_init;
}

function start_mine_caves() {
  self.spawnsystem_init = propremovefromcircle();
  self.spawnsystem_init++;

  if(!isDefined(self.spectatetestonprematchfadedone)) {
    self.spectatetestonprematchfadedone = self.spawnsystem_init;
  } else if(self.spawnsystem_init > self.spectatetestonprematchfadedone) {
    self.spectatetestonprematchfadedone = self.spawnsystem_init;
  }

  ref_14012();
  trial_dogtags();
}

function juggerbear() {
  self.spawnsystem_init = propremovefromcircle();
  self.spawnsystem_init--;

  if(!isDefined(self.spawntimestamp)) {
    self.spawntimestamp = 1;
  } else {
    self.spawntimestamp++;
  }

  if(self.spawnsystem_init < 0) {
    self.spawnsystem_init = 0;
    return;
  }
}

function ref_125fc() {
  var_0 = spawnStruct();
  var_0.ref_12889 = [];
  var_0.brtdm_config = [];
  var_0.brtruck_cleanupents = [];
  var_0.brtruck_ontimelimit = [];
  var_0.offhands = [];
  var_0.nvidiaansel_overridecollisionradius = [];
  var_0.should_use_velo_forward = self.should_use_velo_forward;
  var_0.callprecisionairstrikeonlocation = scripts\mp\equipment::getequipmentslotammo("health");
  var_1 = [];
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var_4) && !issubstr(var_4.basename, "iw8_fists_mp") && !scripts\mp\utility\weapon::unset_relic_mythic(var_4.basename)) {
      var_1 = var_4;
    }
  }

  foreach(var_7 in var_1) {
    var_8 = createheadicon(var_7);

    if(var_7.basename == "iw8_lm_dblmg_mp" || var_7.basename == "iw8_la_mike32_mp") {
      var_0.brtdm_config[var_8] = self getweaponammoclip(var_7);
      var_0.brtruck_ontimelimit[var_8] = self getweaponammostock(var_7);
    } else {
      var_0.brtdm_config[var_8] = weaponclipsize(var_7);
      var_0.brtruck_ontimelimit[var_8] = int(max(self getweaponammostock(var_7), weaponclipsize(var_7)));
    }

    if(scripts\mp\utility\weapon::turnexfiltoside(var_7)) {
      var_0.brtruck_cleanupents[var_8] = weaponclipsize(var_7);
    }

    if(getsubstr(var_8, 0, 4) == "alt_") {
      continue;
    }

    var_0.ref_12889[var_0.ref_12889.size] = var_7;
  }

  var_10 = self getweaponslistoffhands();

  foreach(var_12 in var_10) {
    if(var_12.basename == "bandage_br") {
      continue;
    }

    var_13 = self getweaponammoclip(var_12);

    if(var_13 <= 0) {
      continue;
    }

    var_0.offhands[var_0.offhands.size] = var_12;
    var_14 = createheadicon(var_12);
    var_0.brtdm_config[var_14] = var_13;
  }

  foreach(var_17 in self.equipment) {
    var_0.nvidiaansel_overridecollisionradius[var_17] = var_18;
  }

  var_0.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent) {
    var_0.super = self.equipment["super"];
  }

  if(isDefined(self.streakdata.streaks[1])) {
    var_0.vo_one_remain = self.streakdata.streaks[1].streakname;
  }

  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    var_0.gasmaskhealth = self.gasmaskhealth;
    var_0.plunderpads = self.plunderpads;
    var_0.plundersilentcountdownendtime = self.plundersilentcountdownendtime;
  }

  self.ref_12eb0 = var_0;
}

function ref_125fb() {
  _unlinkcorpsefromvehicle::ref_125fb();
  thread ref_13fab();
  thread ref_12cc3();
}

function ref_13fab() {
  self endon("death");
  wait 1;
  trial_dogtags();
  self.spawnsystem_init = propremovefromcircle();

  if(self.spawnsystem_init == 0) {
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("no_respawns", self);
    return;
  }
}

function ref_12cc3() {
  var_0 = train_mover_test();

  if(var_0 >= 80) {
    scripts\mp\perks\perks::bears();
    return;
  }
}

function droponplayerdeath(var_0) {
  ref_125fc();
  var_1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  scripts\mp\gametypes\br_pickups::minplunderextractions(var_1);
  scripts\mp\gametypes\br_pickups::missiontime(var_1);
  scripts\mp\gametypes\br_pickups::mintokensdropondeath(var_1);
  scripts\mp\gametypes\br_pickups::missedinfilplayerhandler(var_1);
  scripts\mp\gametypes\br_pickups::hangar_doors_opening_quadrace();
  return true;
}

function playerdropplunderondeath(var_0, var_1) {
  if(scripts\mp\utility\game::updatehistoryhud(self)) {
    return 1;
  }

  if(istrue(level.gameended)) {
    return 1;
  }

  if(isDefined(self.plundercount) && self.plundercount > 0) {
    var_2 = self.plundercount;
  } else {
    var_2 = 0;
  }

  if(istrue(self.unicornpoints)) {
    var_3 = 0;
    var_4 = level.endgametutorial_func.ref_127b5;
  } else {
    var_3 = int(var_4 * level.ref_11bce.ref_127be + 0.5);
    var_4 = int(level.ref_11bce.ref_127b5 + var_4 * level.ref_11bce.ref_127b6 + 0.5);
  }

  scripts\mp\gametypes\br_plunder::playersetplundercount(var_3);

  if(var_4 <= 0) {
    return;
  }

  scripts\mp\gametypes\br_plunder::ml_p3_func(var_4, var_2);
  return 1;
}

function ref_12356(var_0, var_1, var_2, var_3) {
  if(var_0 != "brloot_mendota_intel") {
    return var_2;
  }

  if(istrue(var_3.playersetattractiontype)) {
    return getdvarint("scr_br_mxp_intel_quest_count", 10);
  }

  if(istrue(var_3.fromrewardcrate)) {
    return getdvarint("scr_br_mxp_intel_fresno_count", 10);
  }

  return getdvarint("scr_br_mxp_intel_cache_count", 1);
}

function onusecompleted(var_0) {
  if(!isDefined(var_0.tracknonoobplayerlocation)) {
    return false;
  }

  return ref_11bcf(var_0.tracknonoobplayerlocation, self);
}

function ref_13a36(var_0) {
  var_0.count = var_0.tracknonoobplayerlocation.count;
  return var_0.tracknonoobplayerlocation.count;
}

function get_chopper_minigun_start_node(var_0) {
  var_1 = self;

  if(scripts\mp\gametypes\br_pickups::isinteltype(var_0.scriptablename) || intel_isintel(var_0)) {
    if(intel_cancollect(var_1)) {
      return 1;
    }

    return 2;
  }
}

function skippickupfeedback(var_0, var_1, var_2, var_3) {
  if((scripts\mp\gametypes\br_pickups::isinteltype(var_0.scriptablename) || intel_isintel(var_0)) && istrue(var_1)) {
    return 1;
  }
}