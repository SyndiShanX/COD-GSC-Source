/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_bodycount.gsc
**********************************************************/

function activate_punchcard() {}

function activate_gas_trap() {}

function activate_laser_trap_parent() {}

function init() {
  test_anim_ai();
  thread test_train_array();
  thread terminal_pusher();
  thread testaccessoryvfx();
  thread teamstarttime();
  thread toggleusbstickinhand();
  thread subtract_from_spawn_count_from_group();
  thread init_locations();
  level.ref_13364 = 1;
  level.openrequested = [];
}

function test_anim_ai() {
  level.copy_wave_settings_from_module = spawnStruct();
  level.copy_wave_settings_from_module.juggernaut_setupexecute = getdvarint("scr_bodycount_default_respawn_height");

  if(isDefined(level.copy_wave_settings_from_module.juggernaut_setupexecute) && level.copy_wave_settings_from_module.juggernaut_setupexecute > 0) {
    level.ref_12ca7 = level.copy_wave_settings_from_module.juggernaut_setupexecute;
  }

  level.copy_wave_settings_from_module.ref_127b6 = getdvarfloat("scr_bodycount_plunderDropPercent", 0.3);
  level.copy_wave_settings_from_module.ref_127b5 = getdvarfloat("scr_bodycount_plunderDropAmount", 0);
  level.copy_wave_settings_from_module.ref_127be = getdvarfloat("scr_bodycount_plunderKeepPercent", 0.6);
  level.copy_wave_settings_from_module.ref_12c9a = getdvarfloat("scr_bodycount_respawn_time_default", 5);
  level.copy_wave_settings_from_module.ref_12c99 = getdvarfloat("scr_bodycount_respawn_time_add_per_circle", 2);
  level.copy_wave_settings_from_module.ref_1385a = getdvarint("scr_bodycount_starting_respawn_token_count", 1);
  level.copy_wave_settings_from_module.ref_13857 = getDvar("scr_bodycount_starting_loadout_weapon_1", "iw8_fists_mp");
  level.copy_wave_settings_from_module.ref_13858 = getDvar("scr_bodycount_starting_loadout_weapon_2", "iw8_sm_t9handling");
  level.copy_wave_settings_from_module.ref_13856 = getDvar("scr_bodycount_starting_loadout_lethal", "frag_grenade_mp");
  level.copy_wave_settings_from_module.ref_11fd6 = getdvarint("scr_bodycount_on_dogtag_pickup_health_refill", 1);
  level.copy_wave_settings_from_module.ref_11fd5 = getdvarint("scr_bodycount_on_dogtag_pickup_armor_refill", 1);
  level.copy_wave_settings_from_module.ref_11fd4 = getdvarint("scr_bodycount_on_dogtag_pickup_ammo_refill", 1);
  level.copy_wave_settings_from_module.ref_11fd8 = getdvarint("scr_bodycount_on_dogtag_pickup_speed_increase", 1);
  level.copy_wave_settings_from_module.ref_11fd7 = getdvarfloat("scr_bodycount_on_dogtag_pickup_overdrive_duration", 6);

  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    level.copy_wave_settings_from_module.old_load_hvt = getdvarint("scr_bodycount_exfil_extract_circle_index", 5);
  } else {
    level.copy_wave_settings_from_module.old_load_hvt = getdvarint("scr_bodycount_exfil_extract_circle_index", 6);
  }

  level.copy_wave_settings_from_module.old_goalheight = getdvarfloat("scr_bodycount_exfil_delay_before_spawn", 90);
  level.copy_wave_settings_from_module.oldlatespawnplayer = getdvarfloat("scr_bodycount_exfil_incoming_time", 20);
  level.copy_wave_settings_from_module.old_accuracy = getdvarfloat("scr_bodycount_exfil_chopper_fly_in_time", 15);
  level.copy_wave_settings_from_module.omnvar_bit = getdvarfloat("scr_bodycount_exfil_intro_splash_delay", 3);
  level.copy_wave_settings_from_module.oncrankedhit = getdvarint("scr_bodycount_exfil_radius", 250);
  level.copy_wave_settings_from_module.oilfire_burning_player_watch = getdvarint("scr_bodycount_exfil_capture_time", 12.5);
  level.copy_wave_settings_from_module.ref_14199 = getdvarvector("scr_bodycount_vehicle_impulse_vector", (0, 0, 0.5));
  level.copy_wave_settings_from_module.ref_14198 = getdvarfloat("scr_bodycount_vehicle_impulse_magnitude", 150);

  switch (getdvarint("scr_bodycount_circle_speed", 1)) {
    case 0:
      level.copy_wave_settings_from_module.groundentity = [0, 120, 90, 75, 60, 45, 30, 0];
      level.copy_wave_settings_from_module.ground_spawners = [1, 150, 120, 120, 105, 105, 150, 10];
      break;
    case 2:
      level.copy_wave_settings_from_module.groundentity = [0, 120, 90, 60, 45, 45, 30, 0];
      level.copy_wave_settings_from_module.ground_spawners = [1, 150, 120, 90, 90, 90, 150, 10];
      break;
    case 3:
      level.copy_wave_settings_from_module.groundentity = [0, 30, 10, 10, 10, 10, 30, 0];
      level.copy_wave_settings_from_module.ground_spawners = [1, 20, 10, 10, 10, 10, 150, 10];
      break;
    case 4:
      level.copy_wave_settings_from_module.groundentity = [0, 90, 75, 60, 45, 30, 0];
      level.copy_wave_settings_from_module.ground_spawners = [1, 120, 120, 105, 90, 150, 10];
      break;
    case 5:
      level.copy_wave_settings_from_module.groundentity = [0, 30, 10, 10, 10, 30, 0];
      level.copy_wave_settings_from_module.ground_spawners = [1, 20, 10, 10, 10, 150, 10];
      break;
    case 1:
    default:
      level.copy_wave_settings_from_module.groundentity = [0, 120, 90, 75, 60, 45, 45, 0];
      level.copy_wave_settings_from_module.ground_spawners = [1, 150, 135, 120, 105, 105, 150, 10];
      break;
  }

  if(getdvarint("scr_bodycount_heavyWeaponCrate_ultraLoot", 0)) {
    level.delaystreamtomovingplane = 1;
  }

  if(getdvarint("scr_bodycount_dangerNotifyCustomization", 1)) {
    level.isbotpracticematch = getdvarfloat("scr_bodycount_dangerNotifyCooldown", 20);
    level.isbrgametypefuncdefined = [];
  }

  setDvar("scr_br_ending_enabled", 1);
}

function test_train_array() {
  _setdomflagiconinfo("waypoint_captureneutral", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_capture", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_defend", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  _setdomflagiconinfo("waypoint_defending", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  _setdomflagiconinfo("waypoint_contested", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  _setdomflagiconinfo("waypoint_taking", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  _setdomflagiconinfo("waypoint_losing", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  level._effect["vfx_smk_signal_green"] = loadfx("vfx/iw8_cp/prop/vfx_smk_signal_green");
  scripts\mp\gametypes\br_dom_quest::ref_13239();
  thread ref_13bb1();
}

function ref_13bb1() {
  level waittill("br_dialog_initialized");
  level.disableinitplayergameobjects = 0;
}

function terminal_pusher() {
  level.make_place_c4_interact = [];
  level.make_place_c4_interact[1] = make_silencer_pick_up_interact(1, &make_usb_model_usable);
  level.make_place_c4_interact[2] = make_silencer_pick_up_interact(2, &make_outline_ents);
  level.make_place_c4_interact[3] = make_silencer_pick_up_interact(3, &make_javelin_model);
  level.make_place_c4_interact[4] = make_silencer_pick_up_interact(4, &make_javelin_ammo_refill_interact);
  level.make_place_c4_interact[5] = make_silencer_pick_up_interact(5, &make_intel_model_usable);
  level.make_place_c4_interact[6] = make_silencer_pick_up_interact(6, &make_headicon_on_ai);
  level.make_place_c4_interact[7] = make_silencer_pick_up_interact(7, &make_pilot_invincible);
  level.make_place_c4_interact[8] = make_silencer_pick_up_interact(8, &make_solution_struct);
  level.make_place_c4_interact[9] = make_silencer_pick_up_interact(9, &make_heli_blade_patch_clip);
}

function teamstarttime() {
  scripts\mp\gametypes\br_gametypes::ref_12b11("circleTimer", &circletimer);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerWelcomeSplashes", &ref_126f1);
  scripts\mp\gametypes\br_gametypes::ref_12b11("createC130PathStruct", &init_relic_aggressive_melee);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addToC130Infil", &being_hacked);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mapCenterFinalCircle", &ref_12181);
  scripts\mp\gametypes\br_gametypes::ref_12b11("getFinalCircleCenter", &ref_12181);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerGulagAutoWinWait", &ref_125bd);
  scripts\mp\gametypes\br_gametypes::ref_12b11("triggerRespawnOverlay", &ref_13dcb);
  scripts\mp\gametypes\br_gametypes::ref_12b11("assignSpectatorToSpectatePlayer", &assignspectatortospectateplayer);
  scripts\mp\gametypes\br_gametypes::ref_12b11("markPlayerAsEliminatedOnKilled", &ref_11b16);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", &ref_12604);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dropOnPlayerDeath", &droponplayerdeath);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerDropPlunderOnDeath", &playerdropplunderondeath);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  thread ref_14148();
  scripts\engine\scriptable::scriptable_addusedcallback(&copycirclearraystartingat);
  scripts\engine\scriptable::ref_12f57(&copycirclearraystartingat);
}

function ref_126f1(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  self waittill("joining_Infil");
  scripts\mp\hud_message::showsplash("br_gametype_bodycount_welcome");
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gametype", self, 0);
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("primary_objective", self, 0);

  if(istrue(self.tutorial_usingparachute)) {
    level scripts\mp\gametypes\br_public::dmztut_endgamewithreward("deploy_squad_leader", self, 1, 0, 4.5);
    return;
  }
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
      [[level.ref_13457.ref_13738]](var_4.total, var_4.bridge_three_death_func, var_4.node_targetname);
      [[level.ref_13457.ref_1373b]](var_4.ref_12d24);
    }
  }

  if(istrue(level.ref_145c1) && isDefined(level.ref_13457)) {
    [[level.ref_13457.ref_145c1]]();
    return;
  }
}

function onplayerdisconnect(var_0) {
  var_1 = var_0 getentitynumber();

  if(isDefined(level.ref_126c2[var_1])) {
    var_2 = level.ref_126c2[var_1];
    var_2.total = propgiveteamscore(var_0);
    var_2.bridge_three_death_func = prespawnspawn(var_0);
    var_2.node_targetname = propminigameupdates(var_0);
    var_2.ref_12d24 = propgetlocation(var_0);

    if(!isDefined(var_0.spectatetestonprematchfadedone)) {
      var_2.ref_122ef = 1;
    } else {
      var_2.ref_122ef = var_0.spectatetestonprematchfadedone;
    }

    if(!isDefined(var_0.spawntimestamp)) {
      var_2.openrightblimadoor = 0;
    } else {
      var_2.openrightblimadoor = var_0.spawntimestamp;
    }
  } else {
    var_2 = spawnStruct();
    var_2.total = propgiveteamscore(var_1);
    var_2.bridge_three_death_func = prespawnspawn(var_1);
    var_2.node_targetname = propminigameupdates(var_1);
    var_2.ref_12d24 = propgetlocation(var_1);

    if(!isDefined(var_1.spectatetestonprematchfadedone)) {
      var_2.ref_122ef = 1;
    } else {
      var_2.ref_122ef = var_1.spectatetestonprematchfadedone;
    }

    if(!isDefined(var_1.spawntimestamp)) {
      var_2.openrightblimadoor = 0;
    } else {
      var_2.openrightblimadoor = var_1.spawntimestamp;
    }
  }

  if(isDefined(level.ref_13748[var_1.team])) {
    var_3 = level.ref_13748[var_1.team];
    var_3.total += var_2.total;
    var_3.bridge_three_death_func += var_2.bridge_three_death_func;
    var_3.node_targetname += var_2.node_targetname;

    if(var_2.ref_12d24 > var_3.ref_12d24) {
      var_3.ref_12d24 = var_2.ref_12d24;
    }
  } else {
    var_3 = spawnStruct();
    var_3.total = var_3.total;
    var_3.bridge_three_death_func = var_3.bridge_three_death_func;
    var_3.node_targetname = var_3.node_targetname;
    var_3.ref_12d24 = var_3.ref_12d24;
  }

  level.ref_126c2[var_2] = var_3;
  level.ref_13748[var_2.team] = var_3;

  if(isDefined(level.ref_13457)) {
    [[level.ref_13457.ref_12540]](var_2, var_3.total, var_3.bridge_three_death_func, var_3.node_targetname);
    [[level.ref_13457.ref_12650]](var_2, var_3.ref_12d24);
    [[level.ref_13457.ref_125d1]](var_2, var_3.ref_122ef);
    [[level.ref_13457.ref_12556]](var_2, var_3.openrightblimadoor);
    return;
  }
}

function copycirclearraystartingat(var_0, var_1, var_2, var_3, var_4) {
  switch (var_0.type) {
    case "br_bodycount_dogtag":
      makedroneguardscrambler(var_0.entity, var_3);
      break;
    case "brloot_bodycount_dogtag":
      makecrateusableforplayer(var_0, var_3);
      break;
    case "brloot_soa_pow_dogtag":
      makecrateusableforplayer(var_0, var_3);
      break;
    case "brloot_bodycount_extra_life":
      start_mine_caves(var_3);
      break;
  }
}

function testaccessoryvfx() {
  if(getdvarint("scr_brbodycount_playtest", 0)) {
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  }

  level.decoyassists = &groundz;
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizeCircleCenter");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("planeSnapToOOB");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("useTokenToReviveTeammate");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulagWinnerRestoreLoadoutUseGulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("movingCircle");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("match_start_VO");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("planeUseCircleRadius");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
}

function toggleusbstickinhand() {
  level thread scripts\mp\gametypes\obj_dogtag::init();
  waittillframeend();
  thread ref_127f7();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
}

function ref_127f7() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(!istrue(level.tryupdategenericprogress)) {
    scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &onplayerkilled);
    scripts\mp\gametypes\br_gametypes::ref_12b11("dangerCircleTick", &dangercircletick);
    level thread scripts\mp\gametypes\br_heavy_weapon_drop::init();
  }

  success_zone_width();
  level.ref_126c2 = [];
  level.ref_13748 = [];

  foreach(var_1 in level.players) {
    ref_13f79(var_1);
    var_2 = var_1 getentitynumber();
    level.ref_126c2[var_2] = spawnStruct();
    level.ref_126c2[var_2].total = propgiveteamscore(var_1);
    level.ref_126c2[var_2].bridge_three_death_func = prespawnspawn(var_1);
    level.ref_126c2[var_2].node_targetname = propminigameupdates(var_1);
    level.ref_126c2[var_2].ref_12d24 = propgetlocation(var_1);
    level.ref_126c2[var_2].ref_122ef = 0;
    level.ref_126c2[var_2].openrightblimadoor = 0;

    if(!isDefined(level.ref_13748[var_1.team])) {
      level.ref_13748[var_1.team] = spawnStruct();
      level.ref_13748[var_1.team].total = 0;
      level.ref_13748[var_1.team].bridge_three_death_func = 0;
      level.ref_13748[var_1.team].node_targetname = 0;
      level.ref_13748[var_1.team].ref_12d24 = 0;
    }

    ref_12604(var_1);
  }

  thread iscarriablescriptable();
}

function subtract_from_spawn_count_from_group() {
  wait 1;
  game["dialog"]["gametype"] = "gametype_powergrab";
  game["dialog"]["primary_objective"] = "powergrab_mode_desc";
  game["dialog"]["respawn_crate"] = "event_respawn_crate";
  game["dialog"]["exfil_enemy_50"] = "powergrab_enemy_50";
  game["dialog"]["exfil_enemy_start"] = "powergrab_enemy_capture";
  game["dialog"]["exfil_enemy_win"] = "powergrab_enemy_success";
  game["dialog"]["exfil_ready"] = "powergrab_exfil_standby";
  game["dialog"]["exfil_friendly_50"] = "powergrab_friendly_50";
  game["dialog"]["exfil_friendly_start"] = "powergrab_friendly_capture";
  game["dialog"]["exfil_friendly_win"] = "powergrab_friendly_success";
  game["dialog"]["no_respawns"] = "powergrab_respawn_0";
  game["dialog"]["dogtag_reward"] = "powergrab_unlock";
  game["dialog"]["collect_own_tags"] = "powergrab_your_tag";
  game["dialog"]["exfil_contested"] = "powergrab_zone_contest";
}

function achievementtrackerforkills() {}

function dangercircletick(var_0, var_1) {
  var_2 = var_1 * var_1;

  foreach(var_4 in level.dogtags) {
    if(distance2dsquared(var_4.origin, var_0) > var_2) {
      thread removetags();
    }
  }

  foreach(var_7 in level.openrequested) {
    if(distance2dsquared(var_7.origin, var_0) > var_2) {
      thread opened_position();
      LOC_00000081:
    }
    LOC_00000081:
  }

  foreach(var_7 in level.shutdownattractionicontrigger) {
    if(distance2dsquared(var_7.origin, var_0) > var_2) {
      var_7 scripts\mp\gametypes\br_heavy_weapon_drop::shut_down_laser_trap();
      LOC_000000c7:
    }
    LOC_000000c7:
  }
}

function ref_11b16() {
  return false;
}

function ref_125bd(var_0, var_1) {
  self endon("disconnect");

  if(!isDefined(var_0)) {
    if(level.copy_wave_settings_from_module.ref_12c9a) {
      self.chopper_boss_combat_actions = 1;
      var_2 = level.copy_wave_settings_from_module.ref_12c9a;
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
  thread ref_14012();
}

function onplayerkilled(var_0) {
  if(self.spawnsystem_init <= 0) {
    self.attacker thread scripts\mp\utility\points::giveunifiedpoints("br_gametype_bodycount_final_kill");
  }

  thread juggerbear();
  var_1 = var_0.inflictor;
  var_2 = var_0.attacker;

  if(isDefined(var_2) && (!isDefined(var_1) || var_1.classname != "trigger_multiple" && var_1.classname != "trigger_hurt")) {
    var_3 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    thread spawndogtags(level, self, var_2);
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
    var_1 = level.copy_wave_settings_from_module.ref_14199;
    var_2 = level.copy_wave_settings_from_module.ref_14198;
    self method_87c1(var_0.direction_vec + var_1, var_2);
  }

  return true;
}

function ref_12604() {
  if(!isDefined(self.ref_12eb0)) {
    var_0 = getcompleteweaponname(level.copy_wave_settings_from_module.ref_13857);
    var_1 = scripts\mp\class::fixcollision(level.copy_wave_settings_from_module.ref_13858, "camo_01b", undefined, -1);
    var_2 = getcompleteweaponname(level.copy_wave_settings_from_module.ref_13856);
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

function activate_escape_maze() {}

function spawndogtags(var_0, var_1, var_2) {
  level endon("game_ended");

  if(isagent(var_0)) {
    return;
  }

  if(isagent(var_1)) {
    var_1 = var_1.owner;
  }

  var_3 = 14;
  var_4 = (0, 0, 0);
  var_5 = var_0.angles;

  if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var_5 = self getworldupreferenceangles();
    var_4 = anglestoup(var_5);

    if(var_4[2] < 0) {
      var_3 = -14;
    }
  }

  var_6 = var_0.origin + (0, 0, var_3);
  var_7 = spawn("script_model", var_6);
  var_7 setModel("military_dogtags_br_bodycount");
  var_7 setotherent(var_0);
  var_7 hudoutlineenable("outline_depth_white");
  var_7.team = var_0.team;
  getclocksoundaliasfortimeleft();
  var_8 = "" + var_7 getentitynumber();
  var_7.start_reach_wind_room = var_8;
  level.dogtags[var_8] = var_7;
  var_7 setasgametypeobjective();
  var_7.victim = var_0;
  var_7.victimteam = var_0.team;
  var_7.attacker = var_1;
  var_7.attackerteam = var_1.team;
  var_7.ownerteam = var_0.team;
  var_7.spawntime = gettime();
  thread ref_13b4c(var_7, var_0);
  var_7.offset3d = (0, 0, 16);
  var_7.curorigin = var_7.origin;
  var_7 scripts\mp\gameobjects::requestid(1, 1);
  var_7.type = "useObject";
  var_7.numtouching["axis"] = 0;
  var_7.numtouching["allies"] = 0;

  if(isDefined(level.dogtags[var_8].objidnum)) {
    if(level.dogtags[var_8].objidnum != -1) {
      var_9 = level.dogtags[var_8].objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(var_9, "current");
      scripts\mp\objidpoolmanager::update_objective_onentity(var_9, level.dogtags[var_8]);
      scripts\mp\objidpoolmanager::update_objective_setzoffset(var_9, 22);
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_9, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(level.dogtags[var_8].objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(level.dogtags[var_8].objidnum, 0);
      level.dogtags[var_8] scripts\mp\gameobjects::setobjectivestatusicons("waypoint_dogtags_friendly", "waypoint_dogtags");
      level.dogtags[var_8] scripts\mp\gameobjects::setvisibleteam("any");
      getbnetigrbattlepassxpmultiplier(var_9, 8858, 9843);
      getscriptcachecontents(var_9, 0.5, 1);
    }
  }

  playsoundatpos(var_6, "mp_killconfirm_tags_drop");
}

function getclocksoundaliasfortimeleft() {
  if(level.dogtags.size > 60) {
    var_0 = undefined;

    foreach(var_2 in level.dogtags) {
      if(!isDefined(var_0) || var_2.spawntime < var_0.spawntime) {
        var_0 = var_2;
      }
    }

    thread removetags();
    return;
  }
}

function ref_13b4c(var_0, var_1) {
  self endon("death");
  var_2 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, self.origin, self.angles, var_0, undefined, undefined, undefined, 1);
  var_3 = var_2.origin;
  var_4 = abs(self.origin[2] - var_3[2]);
  var_5 = getdvarint("bg_gravity", 800);
  var_6 = sqrt(2 * var_4 / var_5) + 0.5;
  var_7 = trajectorycalculateinitialvelocity(self.origin, var_3, (0, 0, -1 * var_5), var_6);
  self movegravity(var_7, var_6);
  wait var_6;
  self.origin = var_3;

  if(isDefined(var_2.set_force_aitype_armored)) {
    self linkTo(var_2.set_force_aitype_armored);
    self.set_force_aitype_armored = var_2.set_force_aitype_armored;
    return;
  }
}

function makedroneguardscrambler(var_0) {
  if(isDefined(var_0.owner)) {
    var_0 = var_0.owner;
  }

  if(getdvarint("MLNNMOPQOP", 0) == 6) {
    var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_collect_dog_tags_for_s3_5_event_wz", 1);
  }

  if(var_0.pers["team"] == self.victimteam) {
    self playSound("mp_killconfirm_tags_deny");
    var_0 scripts\mp\rank::giverankxp("tag_denied", 25);
    var_0 scripts\mp\utility\stats::incpersstat("denied", 1);
    var_0 scripts\mp\persistence::statsetchild("round", "denied", var_0.pers["denied"]);
    thread make_emp_config();
    scripts\mp\gametypes\obj_dogtag::allyonuse(var_0);

    if(var_0 == self.victim) {
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("collect_own_tags", var_0);
    }

    if(isDefined(level.dogtagallyonusecb) && !level.gameended) {
      self thread[[level.dogtagallyonusecb]](var_0);
    }

    start_link_logic_on_players(var_0);
  } else {
    self playSound("mp_killconfirm_tags_pickup");
    var_0 scripts\mp\utility\stats::incpersstat("confirmed", 1);
    var_0 scripts\mp\persistence::statsetchild("round", "confirmed", var_0.pers["confirmed"]);
    scripts\mp\gametypes\obj_dogtag::enemyonuse(var_0);

    if(isDefined(level.dogtagenemyonusecb) && !level.gameended) {
      self thread[[level.dogtagenemyonusecb]](var_0);
    }

    var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
    make_hb_pick_up_interact(var_0);
    start_marquee(var_0);
  }

  self.victim notify("tag_removed");
  thread removetags();
}

function makecrateusableforplayer(var_0) {
  if(isDefined(var_0.owner)) {
    var_0 = var_0.owner;
  }

  if(getdvarint("MLNNMOPQOP", 0) == 6) {
    var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_collect_dog_tags_for_s3_5_event_wz", 1);
  }

  var_1 = self.origin;
  playsoundatpos(var_1, "mp_killconfirm_tags_pickup");
  var_0 scripts\mp\utility\stats::incpersstat("confirmed", 1);
  var_0 scripts\mp\persistence::statsetchild("round", "confirmed", var_0.pers["confirmed"]);
  var_0 scripts\mp\gametypes\obj_dogtag::ontagpickupevent("tag_collected");
  var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
  make_hb_pick_up_interact(var_0);
}

function removetags() {
  playFX(level.conf_fx["vanish"], self.origin);
  self notify("reset");
  waitframe();

  if(isDefined(self)) {
    self notify("death");

    if(isDefined(level.dogtags[self.start_reach_wind_room])) {
      if(!isDefined(level.dogtags[self.start_reach_wind_room].skipminimapids)) {
        level.dogtags[self.start_reach_wind_room] scripts\mp\gameobjects::releaseid();
        self notify("deleted");
      }

      level.dogtags[self.start_reach_wind_room] = undefined;
    }

    self delete();
    return;
  }
}

function make_silencer_pick_up_interact(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.spotlight_sweep_to_loc_safe = var_0;
  var_2.playerwaittillstreamhintcomplete = var_1;
  return var_2;
}

function make_hb_pick_up_interact() {
  thread make_emp_config();
  start_loc();
  var_0 = propgiveteamscore();

  for(var_1 = 1; var_1 <= level.make_place_c4_interact.size; var_1++) {
    if(var_0 == level.make_place_c4_interact[var_1].spotlight_sweep_to_loc_safe) {
      self[[level.make_place_c4_interact[var_1].playerwaittillstreamhintcomplete]]();
      self.spawnropeandbag = var_1;
      ref_13f79();
    }
  }
}

function make_emp_config() {
  if(!isDefined(self.vehicle)) {
    if(level.copy_wave_settings_from_module.ref_11fd8 == 1) {
      thread ref_124ee();
    }
  }

  scripts\mp\rank::giverankxp("tag_collected", 25);

  if(level.copy_wave_settings_from_module.ref_11fd4 == 1) {
    thread make_focus_fire_icon_anchor();
  }

  if(level.copy_wave_settings_from_module.ref_11fd6 == 1) {
    self.health = self.maxhealth;
  }

  if(level.copy_wave_settings_from_module.ref_11fd5 == 1) {
    self.br_armorhealth = self.br_maxarmorhealth;
    self setclientomnvar("ui_br_armor_damage", 1);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
  }

  thread ref_124ef();
}

function make_focus_fire_icon_anchor() {
  self endon("death_or_disconnect");
  thread scripts\mp\equipment::givescavengerammo();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
}

function make_usb_model_usable(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"BR_BODYCOUNT/NEXT_REWARD_UAV";
    return;
  }

  make_laser_shutdown_interact("uav");
}

function make_outline_ents(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"BR_BODYCOUNT/NEXT_REWARD_LEGENDARY_WEAPON_DROP";
    return;
  }

  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_offhand_advancedlootdrop", 1);
  thread scripts\mp\hud_message::showsplash("br_body_count_legendary_weapon_drop");
}

function make_javelin_ammo_refill_interact(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"BR_BODYCOUNT/NEXT_REWARD_CLUSTER_STRIKE";
    return;
  }

  make_laser_shutdown_interact("toma_strike");
}

function make_headicon_on_ai(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"BR_BODYCOUNT/NEXT_REWARD_ADVANCED_GAS_MASK";
    return;
  }

  thread scripts\mp\hud_message::showsplash("br_body_count_rewarded_gas_mask");
  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_equip_gasmask_durable", 1);
}

function make_intel_model_usable(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"BR_BODYCOUNT/NEXT_REWARD_ARMOR_SATCHEL";
    return;
  }

  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_plate_pouch", 1);
}

function make_pilot_invincible(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"BR_BODYCOUNT/NEXT_REWARD_PRECISION_AIRSTRIKE";
    return;
  }

  make_laser_shutdown_interact("precision_airstrike");
}

function make_javelin_model(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"BR_BODYCOUNT/NEXT_REWARD_EXTRA_LIFE";
    return;
  }

  thread scripts\mp\hud_message::showsplash("br_body_count_rewarded_extra_life");
  start_mine_caves();
}

function make_solution_struct(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"BR_BODYCOUNT/NEXT_REWARD_SPECIALIST";
    return;
  }

  thread scripts\mp\hud_message::showsplash("br_body_count_rewarded_specialist");
  scripts\mp\perks\perks::bears();
}

function make_heli_blade_patch_clip(var_0) {
  if(isDefined(var_0)) {
    var_0.label = &"BR_BODYCOUNT/NEXT_REWARD_ADVANCED_UAV";
    return;
  }

  make_laser_shutdown_interact("directional_uav");
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dogtag_reward", self, undefined, undefined, 1);
}

function make_laser_shutdown_interact(var_0) {
  var_1 = isDefined(self.streakdata.streaks[1]);
  scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar(var_0, var_1, 1);

  if(!level.gameended) {
    thread scripts\mp\hud_message::showkillstreaksplash(var_0);
    return;
  }
}

function propgiveteamscore() {
  if(!isDefined(self.spawnscavengerlootcache)) {
    self.spawnscavengerlootcache = 0;
  }

  return self.spawnscavengerlootcache;
}

function prespawnspawn() {
  if(!isDefined(self.spawnpoint_is_within_sight)) {
    self.spawnpoint_is_within_sight = 0;
  }

  return self.spawnpoint_is_within_sight;
}

function propminigameupdates() {
  if(!isDefined(self.spawnselectionafktime)) {
    self.spawnselectionafktime = 0;
  }

  return self.spawnselectionafktime;
}

function start_loc() {
  self.spawnscavengerlootcache = propgiveteamscore();
  self.spawnscavengerlootcache++;
  ref_13f79();
}

function start_link_logic_on_players() {
  self.spawnpoint_is_within_sight = prespawnspawn();
  self.spawnpoint_is_within_sight++;
  ref_13f79();
}

function start_marquee() {
  self.spawnselectionafktime = propminigameupdates();
  self.spawnselectionafktime++;
  ref_13f79();
}

function ref_13f79() {
  var_0 = propgiveteamscore();
  var_1 = propgetlocation();
  var_2 = propremovefromcircle();
  var_3 = 0;
  var_3 += var_0 * 100;
  var_3 += var_1 * 10;
  var_3 += var_2;
  self setclientomnvar("ui_br_bodycount_reward_data", var_3);
}

function propgetlocation() {
  if(!isDefined(self.spawnropeandbag)) {
    self.spawnropeandbag = 0;
  }

  return self.spawnropeandbag;
}

function activate_battle_station() {}

function init_locations() {
  if(level.mapname == "mp_don4" || level.mapname == "mp_don4_pm") {
    ref_12ad7("airport", 1, (-17654, 20472, 0));
    ref_12ad7("array", 1, (27262, 19562, 0));
    ref_12ad7("downtown", 1, (30451, -8704, 0));
    ref_12ad7("factory", 1, (-5201, 7260, 0));
    ref_12ad7("farmland", 1, (46307, -11229, 0));
    ref_12ad7("prom_east", 1, (10312, -23257, 0));
    ref_12ad7("prom_west", 1, (-19091, -33444, 0));
    ref_12ad7("mine", 1, (34541, 41465, 0));
    ref_12ad7("stadium", 1, (29411, 2720, 0));
    ref_12ad7("summit", 1, (-28903, 49517, 0));
    ref_12ad7("tower", 1, (18376, -14868, 0));
    return;
  }

  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    ref_12ad7("bioweapon_lab", 1, (-1585, 10202, 0));
    ref_12ad7("chemical_engineering", 1, (589, 8411, 0));
    ref_12ad7("harbor", 1, (3285, 953, 0));
    ref_12ad7("staircase", 1, (2364, -2407, 0));
    ref_12ad7("hq", 1, (102, -2075, 0));
    ref_12ad7("prison_block", 1, (-1301, 2339, 0));
    ref_12ad7("control_center", 1, (-2187, -3390, 0));
    ref_12ad7("security_area", 1, (-1259, -10892, 0));
    ref_12ad7("tents", 1, (-474, -5781, 0));
    return;
  }

  ref_12ad7("default", 1, (0, 0, 0));
}

function ref_12ad7(var_0, var_1, var_2) {
  if(!isDefined(level.copy_wave_settings_from_module.area_structs)) {
    level.copy_wave_settings_from_module.area_structs = [];
  }

  var_1 = getdvarint("scr_bodycount_location_weight_" + var_0, var_1);

  if(var_1 <= 0) {
    return;
  }

  var_3 = spawnStruct();
  var_3.ref_13902 = var_0;
  var_3.spotlights = var_1;
  var_3.ref_140b7 = var_2;
  level.copy_wave_settings_from_module.area_structs[var_0] = var_3;
}

function groundz() {
  ref_12fdc();
  thread bindingpc();

  if(istrue(level.copy_wave_settings_from_module.ref_1409d)) {
    level.grouptorewards = (0, 0, 0);
  }

  level.br_level.br_circledelaytimes = level.copy_wave_settings_from_module.groundentity;
  level.br_level.br_circleclosetimes = level.copy_wave_settings_from_module.ground_spawners;

  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    level.br_level.br_circleradii = [16000, 16000, 12500, 9500, 6500, 2000, 300, 0];
    level.br_level.br_circleminimapradii = [9000, 9000, 7750, 6500, 4500, 3500, 2500];
    level.br_level.default_player_connect_black_screen = [0, 0, 0, 0, 0, 0, 0];
    level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0];
    return;
  }

  level.br_level.br_circleradii = [72500, 72500, 50000, 32500, 17500, 7500, 2000, 300, 0];
  level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 8000, 6500, 5500, 5500];
  level.br_level.default_player_connect_black_screen = [0, 0, 0, 0, 0, 0, 0, 0];
  level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0, 0];
}

function ref_12fdc() {
  level.copy_wave_settings_from_module.ref_12e2c = ref_12d7f();
  level.grouptorewards = level.copy_wave_settings_from_module.ref_12e2c.ref_140b7;
  level.chopper_boss = level.copy_wave_settings_from_module.ref_12e2c.ref_13902 == "downtown";
}

function ref_12d7f() {
  if(isDefined(level.copy_wave_settings_from_module.ref_13903) && level.copy_wave_settings_from_module.ref_13903 != "random") {
    foreach(var_1 in level.copy_wave_settings_from_module.area_structs) {
      if(level.copy_wave_settings_from_module.ref_13903 == var_2) {
        return var_1;
      }
    }
  }

  if(level.copy_wave_settings_from_module.area_structs.size == 1) {
    return level.copy_wave_settings_from_module.area_structs[0];
  }

  var_3 = 0;

  foreach(var_1 in level.copy_wave_settings_from_module.area_structs) {
    var_3 += var_1.spotlights;
  }

  var_6 = randomintrange(0, var_3);

  foreach(var_1 in level.copy_wave_settings_from_module.area_structs) {
    if(var_6 < var_1.spotlights) {
      return var_1;
    }

    var_6 -= var_1.spotlights;
  }

  level.copy_wave_settings_from_module.area_structs = scripts\engine\utility::array_randomize(level.copy_wave_settings_from_module.area_structs);
  return level.copy_wave_settings_from_module.area_structs[0];
}

function bindingpc() {
  level endon("game_ended");
  level waittill("calc_circle_centers");

  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    level.br_level.default_class_chosen[1] = (0, 0, 0);
  }

  level.br_level.default_class_chosen[0] = level.br_level.default_class_chosen[1];
  level.br_level.default_class_chosen[level.copy_wave_settings_from_module.old_load_hvt + 1] = level.br_level.default_class_chosen[level.copy_wave_settings_from_module.old_load_hvt + 2];
  level.br_level.default_class_chosen[level.copy_wave_settings_from_module.old_load_hvt] = level.br_level.default_class_chosen[level.copy_wave_settings_from_module.old_load_hvt + 2];
  level.copy_wave_settings_from_module.ref_140b6 = level.br_level.default_class_chosen[level.copy_wave_settings_from_module.old_load_hvt];
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

function circletimer(var_0) {
  if(var_0 >= 2) {
    level.copy_wave_settings_from_module.ref_12c9a += level.copy_wave_settings_from_module.ref_12c99;
  }

  if(var_0 < level.copy_wave_settings_from_module.old_load_hvt) {
    openelevatordoors(var_0);
    return false;
  }

  if(var_0 == level.copy_wave_settings_from_module.old_load_hvt) {
    if((level.mapname == "mp_don4" || level.mapname == "mp_don4_pm") && !level.chopper_boss) {
      level.ref_12ca7 = 7500;
    }

    level thread scripts\mp\gametypes\br_quest_util::generate_solution();
    level thread scripts\mp\gametypes\br_quest_util::little_bird_mg_mp_enterendinternal();
    thread ondamagerelicsteelballs(level);

    foreach(var_2 in level.players) {
      if(isalive(var_2) || istrue(var_2.chopper_boss_combat_actions)) {
        if(getdvarint("MLNNMOPQOP", 0) == 6) {
          var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_reach_final_circle_for_s3_5_event_wz", 1);
        }
      }
    }

    return false;
  }

  if(var_3 == level.copy_wave_settings_from_module.old_load_hvt + 1) {
    level.br_circle.dangercircleui.origin = scripts\mp\gametypes\br_circle::getdangercircleorigin() + (0, 0, scripts\mp\gametypes\br_circle::getdangercircleradius());
    scripts\mp\gametypes\br_circle::setstaticuicircles(500, level.br_circle.safecircleui, level.br_circle.dangercircleui, 0);
  }

  return true;
}

function success_zone_width() {
  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    level.copy_wave_settings_from_module.arena_bot_think_seek_dropped_weapons = [(-865, -11255, 242), (-1896, -8692, 210), (-2890, -5367, 756), (383, -5884, 756), (2330, -7363, 758), (2660, -3249, 895), (-2062, -2682, 1041), (797, -2415, 1418), (-3666, -903, 746), (-566, 75, 1818), (2908, 70, 892), (5192, -3942, 198), (-6002, -109, 142), (-2431, 1723, 1060), (826, 2159, 1258), (-4423, 3943, 675), (-969, 4627, 1130), (3597, 3145, 252), (2066, 5665, 537), (-634, 7038, 1119), (-3103, 8079, 530), (1726, 9290, 722), (-322, 9748, 818), (-1428, 9176, 762), (-3014, 9975, 638)];
  }

  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("extra_life_crate");
  var_0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var_0.dummymodel = "military_carepackage_01_br_respawn";
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
  var_0.activatecallback = &ownerxuid;
  var_0.capturecallback = &p4_trigger;
  var_0.destroyoncapture = 1;
}

function openelevatordoors(var_0) {
  if(var_0 == 2) {
    thread ref_1354e();
    return;
  }
}

function ref_1354e() {
  wait randomintrange(10, 20);

  foreach(var_1 in level.players) {
    var_1 scripts\mp\hud_message::showsplash("br_body_count_respawn_crate_event");
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("respawn_crate");
  var_3 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_4 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_5 = randomfloat(120);
  var_6 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);

  for(var_7 = 0; var_7 < 3; var_7++) {
    var_8 = var_3 + anglesToForward((0, var_5 + var_6 * var_7 * 120, 0)) * var_4 * 0.65;
    var_9 = proprange(var_8, var_4 * 0.35, 0.25, 0.75, 1);

    while(!scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_9)) {
      var_9 = proprange(var_3, var_4, 0.1, 0.9, 1);
      waitframe();
    }

    var_9 += (0, 0, 2000);
    var_10 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "extra_life_crate", var_9, (0, randomint(360), 0));
    level.openrequested[level.openrequested.size] = var_10;
    thread opennukecrate();
    thread openpos();
    wait randomintrange(3, 10);
  }
}

function proprange(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    return previous_spawn_points();
  }

  return scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_0, var_1, var_2, var_3, var_4);
}

function previous_spawn_points() {
  level.copy_wave_settings_from_module.arena_bot_think_seek_dropped_weapons = scripts\engine\utility::array_randomize(level.copy_wave_settings_from_module.arena_bot_think_seek_dropped_weapons);

  foreach(var_1 in level.copy_wave_settings_from_module.arena_bot_think_seek_dropped_weapons) {
    if(scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_1)) {
      return var_1;
    }
  }
}

function ownerxuid(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
      return;
    }

    return;
  }
}

function p4_trigger(var_0) {
  level.openrequested = scripts\engine\utility::array_remove(level.openrequested, self);
  self notify("captured");
  var_1 = easepower("brloot_bodycount_extra_life", self.origin + (0, 0, 16));
  scripts\mp\gametypes\br_pickups::ref_12b3a(var_1);

  if(isDefined(self.objectiveiconid)) {
    objective_delete(self.objectiveiconid);
  }

  playFX(level.conf_fx["vanish"], self.molotov_delete_oldest_trigger.origin);
  self.molotov_delete_oldest_trigger delete();
}

function opennukecrate() {
  var_0 = scripts\engine\utility::drop_to_ground(self.origin, 50, -3000, (0, 0, 1));
  self.molotov_delete_oldest_trigger = spawn("script_model", var_0 + (0, 0, 3));
  self.molotov_delete_oldest_trigger setModel("scr_smoke_grenade");
  wait 1;
  self.molotov_delete_oldest_trigger playLoopSound("mp_flare_burn_lp");
  self.molotov_delete_oldest_trigger setscriptablepartstate("smoke", "on");
}

function openpos() {
  self setscriptablepartstate("objective", "respawn");
}

function opened_position() {
  self.molotov_delete_oldest_trigger delete();
  playFX(level.conf_fx["vanish"], self.origin);
  level.openrequested = scripts\engine\utility::array_remove(level.openrequested, self);
  scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

function activate_gas_trap_puddles() {}

function ondamagerelicsteelballs(var_0, var_1) {
  level endon("game_ended");
  level.copy_wave_settings_from_module.managevehiclehealthui = spawnStruct();
  var_2 = level.copy_wave_settings_from_module.ref_140b6;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  var_3 = level.copy_wave_settings_from_module.oncrankedhit;
  var_4 = getgroundposition(var_2, 1);

  if(isDefined(var_0)) {
    var_5 = var_0 - level.copy_wave_settings_from_module.oldlatespawnplayer;

    if(var_5 > 0) {
      wait var_5;
    } else {
      wait 30;
    }
  }

  scripts\mp\gametypes\br_publicevents::ref_13371("br_body_count_exfil_incoming");
  thread ondroprelics(level);
  var_6 = frag_crate_player_at_max_ammo(700);

  if(var_6 < level.copy_wave_settings_from_module.old_accuracy) {
    var_6 = level.copy_wave_settings_from_module.old_accuracy;
  }

  var_5 = level.copy_wave_settings_from_module.oldlatespawnplayer - var_6;
  wait var_5;
  var_7 = play_quarry_intro_vo();
  var_8 = undefined;

  if(isDefined(var_7)) {
    var_8 = thread ref_126a8(var_7, var_2, undefined, 5000, 700, 0);
    thread outro_main();
  }

  var_5 = level.copy_wave_settings_from_module.old_accuracy - level.copy_wave_settings_from_module.omnvar_bit;
  wait var_5;
  scripts\mp\gametypes\br_publicevents::ref_13371("br_body_count_exfil_online");

  foreach(var_10 in level.players) {
    var_10 scripts\mp\utility\lower_message::setlowermessageomnvar(72, undefined, 10);
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_ready");
  wait level.copy_wave_settings_from_module.omnvar_bit;
  level.copy_wave_settings_from_module.managevehiclehealthui.trigger = spawn("trigger_radius", var_4, 0, int(var_3), int(level.defend_wave_3));
  var_12 = scripts\mp\gametypes\obj_dom::setupobjective(level.copy_wave_settings_from_module.managevehiclehealthui.trigger, "neutral");
  var_12.onuse = &oncapture;
  var_12.onbeginuse = &omvar_code;
  var_12.onuseupdate = &oncollectitem;
  var_12.onenduse = &on_killed_tutorial;
  var_12.oncontested = &on_execution_begin;
  var_12.onuncontested = &onarmorboxusedbyplayer;
  var_12.onunoccupied = &onattackerdamagenottracked;
  var_12.onpinnedstate = &on_max;
  var_12.onunpinnedstate = &oncacheopen;
  var_12.ref_138b2 = &on_min;
  var_12.stompprogressreward = &onfieldupgradeend;
  var_12.gate_swings_open = 1;
  var_12.id = "domFlag";
  var_12.pinobj = 0;
  var_12.lockupdatingicons = 1;
  var_12 scripts\mp\gameobjects::setcapturebehavior("persistent");
  var_13 = level.copy_wave_settings_from_module.oilfire_burning_player_watch;
  var_12 scripts\mp\gameobjects::setusetime(var_13);
  onfieldupgradeendbuffer(var_12);
  playencryptedcinematicforall(var_12.objidnum, 1);
  level.copy_wave_settings_from_module.managevehiclehealthui.oil_puddles = var_12;
  level.objectivescaler = 1;

  foreach(var_10 in level.players) {
    var_10 setclientomnvar("ui_securing", 17);
    var_10 setclientomnvar("ui_securing_progress", 0);
  }
}

function ondamagepredamagemodrelicfocusfire(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_2.team)) {
      if(var_2.team == var_0) {
        var_2 setclientomnvar("ui_securing", 18);
        continue;
      }

      var_2 setclientomnvar("ui_securing", 19);
    }
  }
}

function ondamagerelicfocusfire(var_0) {
  if(var_0 == "contested") {
    self setclientomnvar("ui_securing", 20);
    return;
  }

  if(var_0 == "friendly") {
    self setclientomnvar("ui_securing", 18);
    return;
  }

  self setclientomnvar("ui_securing", 19);
}

function onfirstlandcallback(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2 setclientomnvar("ui_securing_progress", var_0);
    }
  }
}

function omnvardata(var_0) {
  self notify("exfil_newOwnerFeedback");
  self endon("exfil_newOwnerFeedback");

  if(isPlayer(var_0)) {
    var_1 = var_0.team;
  } else {
    var_1 = var_1;
  }

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_1)) {
      if(var_3.team == var_1) {
        thread ondamagerelicfocusfire(var_3);
        var_3 thread scripts\mp\hud_message::showsplash("br_body_count_friendly_team_exfil");
        continue;
      }

      thread ondamagerelicfocusfire(var_3);
      var_3 thread scripts\mp\hud_message::showsplash("br_body_count_enemy_team_exfil");
    }
  }

  ref_1242c(var_1, "exfil_friendly_start", "exfil_enemy_start");
}

function oncapture(var_0) {
  var_1 = var_0.team;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var_1].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  ref_1242c(var_1, "exfil_friendly_win", "exfil_enemy_win");
  onfirstlandcallback(1);
  thread oldest_targeted_by_chopper_time(var_1);
}

function omvar_code(var_0) {
  if(!isDefined(self.ref_11f63) || !self.ref_11f63) {
    self.ref_11f63 = 1;
    thread omnvardata(var_0);
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_3 in var_1) {
      var_3 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function oncollectitem(var_0, var_1, var_2, var_3) {
  if(var_1 < 1 && !level.gameended && !istrue(self.get_current_bush_zone)) {
    onfirstlandcallback(var_1);
    ref_12427(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
  }

  if(self.gate_swings_open && var_1 > 0.5) {
    self.gate_swings_open = 0;
    ref_1242c(var_0, "exfil_friendly_50", "exfil_enemy_50");
    return;
  }
}

function on_killed_tutorial(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var_0, var_1, var_2);
}

function on_execution_begin() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_contested");
  var_0 = scripts\mp\gameobjects::getownerteam();

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_0)) {
      thread ondamagerelicfocusfire(var_2);
    }
  }
}

function onarmorboxusedbyplayer(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = scripts\mp\gameobjects::getownerteam();
  var_3 = undefined;
  var_4 = oldbranchents();

  if(var_4 <= 1) {
    foreach(var_6 in level.teamnamelist) {
      var_7 = self.teamprogress[var_6];

      if(var_7 > 0) {
        var_3 = var_6;
        break;
      }
    }

    if(isDefined(var_3)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_3);

      if(var_1) {
        ondamagepredamagemodrelicfocusfire(var_3);
      }
    } else if(var_2 != "neutral") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_2);
    } else if(var_0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);
    }

    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");

    if(isDefined(var_0) && (var_0 == "none" || var_2 == "neutral")) {
      self.didstatusnotify = 0;
      return;
    }

    return;
  }
}

function onattackerdamagenottracked() {
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral");
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
  }

  self.didstatusnotify = 0;
}

function on_max(var_0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");
    return;
  }
}

function oncacheopen(var_0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
    return;
  }
}

function on_min(var_0) {
  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_5 = self.teamprogress[var_4];

    if(var_5 > 0) {
      var_2 = var_5 / self.usetime;
    }
  }

  if(isDefined(var_2)) {
    onfirstlandcallback(var_2);

    if(var_2 <= 0.008) {
      thread omnvardata(self.claimteam);
    }

    if(!self.gate_swings_open && var_2 < 0.4) {
      self.gate_swings_open = 1;
      return;
    }

    return;
  }
}

function onfieldupgradeend(var_0) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("obj_prog_defend");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");

  if(isDefined(self.lastprogressteam)) {
    thread omnvardata(var_0);
    self.lastprogressteam = undefined;
    return;
  }
}

function ref_12427(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "";
    var_0 = int(floor(var_0 * 10));
    var_2 = "mp_dom_capturing_tick_0" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
    return;
  }
}

function oldest_targeted_by_chopper_time(var_0) {
  waitframe();

  if(istrue(level.ref_13dc0)) {
    return;
  }

  level.ref_13dc0 = 1;
  level.ref_145c1 = 1;
  level thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["objective_completed"]);
  var_1 = [];

  if(isDefined(var_0) && var_0 != "tie") {
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");
  }

  thread scripts\mp\music_and_dialog::ref_12789(var_1);
}

function ondroprelics(var_0) {
  var_1 = spawn("script_model", var_0 - (0, 0, 3));
  var_1 setModel("tag_origin");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), var_1, "tag_origin");
}

function oldbranchents() {
  var_0 = 0;

  foreach(var_2 in self.numtouching) {
    if(var_2 > 0 && (!isstring(var_3) || var_3 != "none")) {
      var_0++;
    }
  }

  return var_0;
}

function onfieldupgradeendbuffer() {
  scripts\mp\objidpoolmanager::update_objective_setneutrallabel(self.objidnum, "BR_BODYCOUNT/EXFIL");
}

function active_fob_think() {}

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
  scripts\engine\utility::ref_143b9(level.copy_wave_settings_from_module.ref_11fd7, "death");
  self.operatorcustomization.suit = self.ref_12147;
  scripts\mp\utility\player::_setsuit(self.ref_12147);
  self.ref_12147 = undefined;
}

function ref_124ef() {
  self notify("player_set_infinate_super_sprint");
  self endon("player_set_infinate_super_sprint");
  self endon("death_or_disconnect");
  self refreshsprinttime();
  var_0 = 0;
  thread make_focus_fire_objective();
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("zombiedefault");

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    scripts\mp\utility\perk::giveperk("specialty_sprintmelee");
    scripts\mp\utility\perk::giveperk("specialty_sprintads");
    scripts\mp\utility\perk::giveperk("specialty_marathon");
  }

  while(var_0 < level.copy_wave_settings_from_module.ref_11fd7) {
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

function make_focus_fire_objective() {
  self notify("reset_timer");
  waitframe();
  self setclientomnvar("ui_privateevent_timer_type", 4);
  var_0 = level.copy_wave_settings_from_module.ref_11fd7;
  var_1 = gettime() + var_0 * 1000;
  self setclientomnvar("ui_privateevent_timer", var_1);
  scripts\engine\utility::ref_143ba(level.copy_wave_settings_from_module.ref_11fd7, "reset_timer", "death");
  self setclientomnvar("ui_privateevent_timer_type", 0);
}

function ref_14012() {
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
    self.spawnsystem_init = level.copy_wave_settings_from_module.ref_1385a;
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
  ref_13f79();
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

function radar_sweeps(var_0, var_1) {
  var_2 = (randomfloat(1) - 0.5, randomfloat(1) - 0.5, 0);

  if(!istrue(var_1)) {
    GscBinSkip0(0x2e, 2, randomfloat(1) - 0.5);
  }

  var_3 = var_0 * vectorNormalize(var_2);
  return var_3;
}

function _setdomflagiconinfo(var_0, var_1, var_2, var_3) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 1;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = "ui_mp_br_mapmenu_icon_gulag_overtime_objective";
  level.waypointpulses[var_0] = var_3;
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
  ref_13f79();
  self.spawnsystem_init = propremovefromcircle();

  if(self.spawnsystem_init == 0) {
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("no_respawns", self);
    return;
  }
}

function ref_12cc3() {
  var_0 = propgiveteamscore();

  if(var_0 >= 8) {
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
    var_3 = int(var_4 * level.copy_wave_settings_from_module.ref_127be + 0.5);
    var_4 = int(level.copy_wave_settings_from_module.ref_127b5 + var_4 * level.copy_wave_settings_from_module.ref_127b6 + 0.5);
  }

  scripts\mp\gametypes\br_plunder::playersetplundercount(var_3);

  if(var_4 <= 0) {
    return;
  }

  scripts\mp\gametypes\br_plunder::ml_p3_func(var_4, var_2);
  return 1;
}

function ref_1242c(var_0, var_1, var_2) {
  foreach(var_4 in level.teamnamelist) {
    if(var_4 == var_0) {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var_1, var_4);
      continue;
    }

    level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var_2, var_4);
  }
}

function ref_126a8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0;
  var_7 = var_6 + (0, 0, 2500);
  var_8 = play_skit_and_watch_for_endons(var_7, var_1);
  var_9 = (0, var_8, 0);
  var_10 = undefined;
  var_11 = undefined;

  if(isDefined(var_2)) {
    var_10 = var_7 + -1 * anglesToForward(var_9) * var_2;
    var_11 = var_7 + anglesToForward(var_9) * var_2;
  } else {
    var_10 = var_7 + -1 * anglesToForward(var_9) * 5000;
    var_11 = var_7 + anglesToForward(var_9) * 5000;
  }

  var_12 = spawnheli(self, var_10, var_7, var_11, var_3, var_4, var_5);
  return var_12;
}

function play_quarry_intro_vo() {
  var_0 = getarraykeys(level.teamdata);

  foreach(var_2 in var_0) {
    if(level.teamdata[var_2]["alivePlayers"].size > 0) {
      return level.teamdata[var_2]["alivePlayers"][0];
    }
  }

  return undefined;
}

function play_skit_and_watch_for_endons(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.player_respawn)) {
    return var_1.player_respawn;
  }

  var_2 = 10;
  var_3 = scripts\engine\trace::create_world_contents();
  var_4 = 0;

  while(var_4 < 360) {
    var_5 = (0, var_4, 0);
    var_6 = var_0 + -1 * anglesToForward(var_5) * 5000;
    var_7 = var_0 + anglesToForward(var_5) * 5000;
    var_8 = scripts\engine\trace::sphere_trace(var_0, var_7, 100, undefined, var_3, 1);

    if(var_8["fraction"] == 1) {
      if(isDefined(var_1)) {
        var_1.player_respawn = var_4;
      }

      return var_4;
    }

    if(var_4 % 3 == 0) {
      waitframe();
    }

    var_4 += var_2;
  }

  var_4 = randomfloat(360);

  if(isDefined(var_1)) {
    var_1.player_respawn = var_4;
  }

  return var_4;
}

function outro_main() {
  self endon("death");
  self endon("leaving");
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  var_0 = ref_13c30(self.pathgoal, self.hoverheight);
  var_1 = self.pathgoal[2] - var_0;
  self.player_weapon_fired_monitor = frag_crate_player_at_max_ammo(var_1);
  sortplayerplunderscores(1, self.player_weapon_fired_monitor);
  self waittill("goal");
  thread heliwatchgameendleave();
  thread snapshot_crate_spawn();
  helidescend(self.endpoint, var_0);
  soldier_agent_lwfn0();
  helicleanupextract();
  thread sol_3_4_pool();
}

function spawnheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = vectortoangles(var_2 - var_1);
  var_8 = 99;
  var_9 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_1, var_7, "veh_apache_plunder_mp", "veh8_mil_air_mindia8_plunder_x");

  if(!isDefined(var_9)) {
    return;
  }

  var_10 = var_2 * (1, 1, 0);
  var_9.speed = 50;
  var_9.accel = 125;
  var_9.health = 1000;
  var_9.maxhealth = var_9.health;
  var_9.team = var_0.team;
  var_9.owner = var_0;
  var_9.defendloc = var_2;
  var_9.lifeid = 0;
  var_9.flaresreservecount = var_8;
  var_9.pathgoal = var_2;
  var_9.ref_121ff = var_3;
  var_9.endpoint = var_10;
  var_9.select_mountain_two_spawners = var_7[1];
  var_9.canuse = var_6;
  var_9.hoverheight = var_4;
  var_9.vehiclename = "magma_plunder_chopper";

  if(istrue(var_5)) {
    var_9 setCanDamage(1);
  } else {
    var_9 setCanDamage(0);
  }

  var_9 setmaxpitchroll(10, 25);
  var_9 vehicle_setspeed(var_9.speed, var_9.accel);
  var_9 sethoverparams(50, 100, 50);
  var_9 setturningability(0.05);
  var_9 setyawspeed(45, 25, 25, 0.5);
  var_9 setotherent(var_0);
  var_9 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  return var_9;
}

function frag_crate_player_at_max_ammo(var_0) {
  var_1 = frag_crate_spawn(5000, 100, 125);
  var_2 = frag_crate_spawn(var_0, 25, 31.25);
  var_3 = var_1 + var_2;
  return var_3;
}

function ref_13c30(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = 256;
  }

  var_3 = tracegroundpoint(var_0, 100, [self]);
  var_4 = var_3[2];
  var_5 = var_4 + var_2;
  return var_5;
}

function sortplayerplunderscores(var_0, var_1) {
  var_2 = gettime() + int(var_1 * 1000);
  var_3 = level.teamdata[self.team]["alivePlayers"];

  foreach(var_5 in var_3) {
    var_5 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_plunder_extract_state", var_0);
    var_5 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_plunder_extract_end_time", var_2);
  }
}

function heliwatchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread sol_3_4_pool();
}

function snapshot_crate_spawn() {
  self endon("death");

  if(!isDefined(self.vfxent)) {
    return;
  }

  self.vfxent endon("death");
  wait 5;
  self.vfxent setscriptablepartstate("smoke", "dissipate");
  self.vfxent playSound("smoke_canister_tail_dissipate");
  wait 1;
  self.vfxent stoploopsound();
  wait 4.5;
  self.vfxent delete();
}

function helidescend(var_0, var_1) {
  self endon("death");
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = (var_2, var_3, var_1);
  self setvehgoalpos(var_4, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self vehicle_setspeed(25, 31.25);
  thread snapplayertotoppos();
  thread snappointtooutofboundstriggertrace();
  self waittill("goal");
  self sethoverparams(1, 1);
  wait 1;
  self sethoverparams(25, 20, 10);
}

function soldier_agent_lwfn0() {
  self endon("game_ended");
  thread smoke_init();
  sortplayerplunderscores(2, 300);
  wait 300;
  self.isdepot = 0;
  heliusecleanup();
}

function heliusecleanup() {
  if(isDefined(self.usable)) {
    level.br_depots = scripts\engine\utility::array_remove(level.br_depots, self.usable);
    self.usable = undefined;
    return;
  }
}

function smoke_init(var_0) {
  scripts\engine\utility::waittill_either("leaving", "death");
  heliusecleanup();
}

function helicleanupextract(var_0) {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
  }

  if(istrue(var_0) && isDefined(self.site)) {
    self.site setscriptablepartstate(self.site.type, self.site.audio_shf_kill_hangar_lights);
    return;
  }
}

function sol_3_4_pool() {
  self endon("death");
  self notify("leaving");
  self.leaving = 1;
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  sortplayerplunderscores(3, self.player_weapon_fired_monitor);
  self waittill("goal");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self.ref_121ff, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self waittill("goal");
  self stoploopsound();
  sortplayerplunderscores(0, 0);
  self notify("heli_gone");
  smuggler_killed_early();
}

function tracegroundpoint(var_0, var_1, var_2) {
  var_3 = -99999;
  var_4 = (var_0[0], var_0[1], var_3);
  var_5 = scripts\engine\trace::create_world_contents();
  var_6 = undefined;

  if(isDefined(var_1)) {
    var_6 = scripts\engine\trace::sphere_trace(var_0, var_4, var_1, var_2, var_5);
  } else {
    var_6 = scripts\engine\trace::ray_trace(var_0, var_4, var_2, var_5);
  }

  return var_6["position"];
}

function frag_crate_spawn(var_0, var_1, var_2) {
  var_3 = var_0 * 1.57828e-05;
  var_4 = 0.5 * var_2;
  var_5 = var_1;
  var_6 = -1 * var_3;
  var_7 = (-1 * var_5 + sqrt(var_5 * var_5 - 4 * var_4 * var_6)) / 2 * var_4;
  var_7 *= 3600;
  var_7 += 1.5;
  return var_7;
}

function snapplayertotoppos() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", var_0);

    if(isDefined(var_0) && nuke_vault_suicidebomber_internal(var_0)) {
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "MOD_CRUSH");
    }
  }
}

function snappointtooutofboundstriggertrace() {
  self endon("leaving");
  self endon("death");
  var_0 = 70;
  var_1 = -80;
  var_2 = 150;
  var_3 = 25;
  var_4 = -100;

  for(;;) {
    var_5 = getentarrayinradius("script_vehicle", "classname", self.origin, getdvarfloat("test_radius", 400));

    if(var_5.size <= 1) {
      wait 0.5;
      continue;
    }

    var_6 = scripts\engine\trace::create_vehicle_contents();
    var_7 = anglesToForward(self.angles);
    var_8 = self.origin + var_7 * getdvarfloat("test_f", var_2) + (0, 0, getdvarfloat("test_d", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && nuke_vault_suicidebomber_internal(var_10)) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("test_m", var_3) + (0, 0, getdvarfloat("test_d", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && nuke_vault_suicidebomber_internal(var_10)) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("test_b", var_4) + (0, 0, getdvarfloat("test_d", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && nuke_vault_suicidebomber_internal(var_10)) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

function smuggler_killed_early() {
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function activate_emp_drone_pick_up() {}