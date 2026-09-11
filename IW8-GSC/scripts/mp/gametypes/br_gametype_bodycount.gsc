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

function ref_126f1(var0) {
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

  foreach(var1 in level.players) {
    if(isDefined(var1)) {
      onplayerdisconnect(var1);
    }
  }

  foreach(var4 in level.ref_13748) {
    if(isDefined(level.ref_13457)) {
      [[level.ref_13457.ref_13738]](var4.total, var4.bridge_three_death_func, var4.node_targetname);
      [[level.ref_13457.ref_1373b]](var4.ref_12d24);
    }
  }

  if(istrue(level.ref_145c1) && isDefined(level.ref_13457)) {
    [[level.ref_13457.ref_145c1]]();
    return;
  }
}

function onplayerdisconnect(var0) {
  var1 = var0 getentitynumber();

  if(isDefined(level.ref_126c2[var1])) {
    var2 = level.ref_126c2[var1];
    var2.total = propgiveteamscore(var0);
    var2.bridge_three_death_func = prespawnspawn(var0);
    var2.node_targetname = propminigameupdates(var0);
    var2.ref_12d24 = propgetlocation(var0);

    if(!isDefined(var0.spectatetestonprematchfadedone)) {
      var2.ref_122ef = 1;
    } else {
      var2.ref_122ef = var0.spectatetestonprematchfadedone;
    }

    if(!isDefined(var0.spawntimestamp)) {
      var2.openrightblimadoor = 0;
    } else {
      var2.openrightblimadoor = var0.spawntimestamp;
    }
  } else {
    var2 = spawnStruct();
    var2.total = propgiveteamscore(var1);
    var2.bridge_three_death_func = prespawnspawn(var1);
    var2.node_targetname = propminigameupdates(var1);
    var2.ref_12d24 = propgetlocation(var1);

    if(!isDefined(var1.spectatetestonprematchfadedone)) {
      var2.ref_122ef = 1;
    } else {
      var2.ref_122ef = var1.spectatetestonprematchfadedone;
    }

    if(!isDefined(var1.spawntimestamp)) {
      var2.openrightblimadoor = 0;
    } else {
      var2.openrightblimadoor = var1.spawntimestamp;
    }
  }

  if(isDefined(level.ref_13748[var1.team])) {
    var3 = level.ref_13748[var1.team];
    var3.total += var2.total;
    var3.bridge_three_death_func += var2.bridge_three_death_func;
    var3.node_targetname += var2.node_targetname;

    if(var2.ref_12d24 > var3.ref_12d24) {
      var3.ref_12d24 = var2.ref_12d24;
    }
  } else {
    var3 = spawnStruct();
    var3.total = var3.total;
    var3.bridge_three_death_func = var3.bridge_three_death_func;
    var3.node_targetname = var3.node_targetname;
    var3.ref_12d24 = var3.ref_12d24;
  }

  level.ref_126c2[var2] = var3;
  level.ref_13748[var2.team] = var3;

  if(isDefined(level.ref_13457)) {
    [[level.ref_13457.ref_12540]](var2, var3.total, var3.bridge_three_death_func, var3.node_targetname);
    [[level.ref_13457.ref_12650]](var2, var3.ref_12d24);
    [[level.ref_13457.ref_125d1]](var2, var3.ref_122ef);
    [[level.ref_13457.ref_12556]](var2, var3.openrightblimadoor);
    return;
  }
}

function copycirclearraystartingat(var0, var1, var2, var3, var4) {
  switch (var0.type) {
    case "br_bodycount_dogtag":
      makedroneguardscrambler(var0.entity, var3);
      break;
    case "brloot_bodycount_dogtag":
      makecrateusableforplayer(var0, var3);
      break;
    case "brloot_soa_pow_dogtag":
      makecrateusableforplayer(var0, var3);
      break;
    case "brloot_bodycount_extra_life":
      start_mine_caves(var3);
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

  foreach(var1 in level.players) {
    ref_13f79(var1);
    var2 = var1 getentitynumber();
    level.ref_126c2[var2] = spawnStruct();
    level.ref_126c2[var2].total = propgiveteamscore(var1);
    level.ref_126c2[var2].bridge_three_death_func = prespawnspawn(var1);
    level.ref_126c2[var2].node_targetname = propminigameupdates(var1);
    level.ref_126c2[var2].ref_12d24 = propgetlocation(var1);
    level.ref_126c2[var2].ref_122ef = 0;
    level.ref_126c2[var2].openrightblimadoor = 0;

    if(!isDefined(level.ref_13748[var1.team])) {
      level.ref_13748[var1.team] = spawnStruct();
      level.ref_13748[var1.team].total = 0;
      level.ref_13748[var1.team].bridge_three_death_func = 0;
      level.ref_13748[var1.team].node_targetname = 0;
      level.ref_13748[var1.team].ref_12d24 = 0;
    }

    ref_12604(var1);
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

function dangercircletick(var0, var1) {
  var2 = var1 * var1;

  foreach(var4 in level.dogtags) {
    if(distance2dsquared(var4.origin, var0) > var2) {
      thread removetags();
    }
  }

  foreach(var7 in level.openrequested) {
    if(distance2dsquared(var7.origin, var0) > var2) {
      thread opened_position();
      LOC_00000081:
    }
    LOC_00000081:
  }

  foreach(var7 in level.shutdownattractionicontrigger) {
    if(distance2dsquared(var7.origin, var0) > var2) {
      var7 scripts\mp\gametypes\br_heavy_weapon_drop::shut_down_laser_trap();
      LOC_000000c7:
    }
    LOC_000000c7:
  }
}

function ref_11b16() {
  return false;
}

function ref_125bd(var0, var1) {
  self endon("disconnect");

  if(!isDefined(var0)) {
    if(level.copy_wave_settings_from_module.ref_12c9a) {
      self.chopper_boss_combat_actions = 1;
      var2 = level.copy_wave_settings_from_module.ref_12c9a;
      wait 3;

      while(istrue(self.killcam)) {
        waitframe();
      }

      thread ref_1336e(var2);
      thread scripts\mp\gametypes\br_spectate::spawnspectator(self, 0, 1);
      wait var2;
      self.chopper_boss_combat_actions = undefined;
      return true;
    }
  }

  return false;
}

function ref_13dcb(var0) {
  return true;
}

function assignspectatortospectateplayer(var0, var1) {
  var0 notify("assignSpectatorToSpectatePlayerWaitForTeam");

  if(istrue(level.endmatchcameratransitions)) {
    return false;
  }

  if(!isDefined(var1) || !isPlayer(var1) || !isalive(var1) && !isDefined(var1.ref_1391a)) {
    return false;
  }

  if(var0.team == var1.team) {
    return false;
  }

  if(!scripts\mp\utility\teams::getteamdata(var0.team, "aliveCount")) {
    return false;
  }

  var2 = scripts\mp\utility\teams::getfriendlyplayers(var0.team, 1);

  if(var2.size == 0) {
    return false;
  }

  thread cargo_truck_mg_mp_init(var0);
  return true;
}

function cargo_truck_mg_mp_init(var0) {
  level endon("brSpawnPlayersEnding");
  var0 endon("assignSpectatorToSpectatePlayerWaitForTeam");
  var0 endon("death_or_disconnect");
  var0 scripts\mp\gametypes\br_spectate::ref_126ab();
  var0 setclientomnvar("ui_show_spectateHud", var0 getentitynumber());
  wait 1;
  var1 = scripts\mp\gametypes\br_spectate::regive_killstreak_after_use(var0);
  thread scripts\mp\gametypes\br_spectate::assignspectatortospectateplayer(var0, var1);
}

function onplayerspawned() {
  thread ref_14012();
}

function onplayerkilled(var0) {
  if(self.spawnsystem_init <= 0) {
    self.attacker thread scripts\mp\utility\points::giveunifiedpoints("br_gametype_bodycount_final_kill");
  }

  thread juggerbear();
  var1 = var0.inflictor;
  var2 = var0.attacker;

  if(isDefined(var2) && (!isDefined(var1) || var1.classname != "trigger_multiple" && var1.classname != "trigger_hurt")) {
    var3 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    thread spawndogtags(level, self, var2);
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

function ref_14202(var0) {
  if(isDefined(var0.direction_vec) && isDefined(var0.meansofdeath) && isexplosivedamagemod(var0.meansofdeath)) {
    var1 = level.copy_wave_settings_from_module.ref_14199;
    var2 = level.copy_wave_settings_from_module.ref_14198;
    self method_87c1(var0.direction_vec + var1, var2);
  }

  return true;
}

function ref_12604() {
  if(!isDefined(self.ref_12eb0)) {
    var0 = getcompleteweaponname(level.copy_wave_settings_from_module.ref_13857);
    var1 = scripts\mp\class::fixcollision(level.copy_wave_settings_from_module.ref_13858, "camo_01b", undefined, -1);
    var2 = getcompleteweaponname(level.copy_wave_settings_from_module.ref_13856);
    var3 = scripts\mp\equipment::getequipmentreffromweapon(var2);
    self giveweapon(var0);
    self giveweapon(var1);
    self switchtoweaponimmediate(var1);
    self assignweaponprimaryslot(var1);
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, "brloot_ammo_919", var1.clipsize * 2);
    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
    self notify("ammo_update");
    scripts\mp\equipment::giveequipment(var3, "primary");
    scripts\mp\weapons::fixupplayerweapons(self, var1);
  } else {
    ref_125fb();
  }

  scripts\mp\gametypes\br_armor::scriptablescurid(150);
}

function activate_escape_maze() {}

function spawndogtags(var0, var1, var2) {
  level endon("game_ended");

  if(isagent(var0)) {
    return;
  }

  if(isagent(var1)) {
    var1 = var1.owner;
  }

  var3 = 14;
  var4 = (0, 0, 0);
  var5 = var0.angles;

  if(var0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var5 = self getworldupreferenceangles();
    var4 = anglestoup(var5);

    if(var4[2] < 0) {
      var3 = -14;
    }
  }

  var6 = var0.origin + (0, 0, var3);
  var7 = spawn("script_model", var6);
  var7 setModel("military_dogtags_br_bodycount");
  var7 setotherent(var0);
  var7 hudoutlineenable("outline_depth_white");
  var7.team = var0.team;
  getclocksoundaliasfortimeleft();
  var8 = "" + var7 getentitynumber();
  var7.start_reach_wind_room = var8;
  level.dogtags[var8] = var7;
  var7 setasgametypeobjective();
  var7.victim = var0;
  var7.victimteam = var0.team;
  var7.attacker = var1;
  var7.attackerteam = var1.team;
  var7.ownerteam = var0.team;
  var7.spawntime = gettime();
  thread ref_13b4c(var7, var0);
  var7.offset3d = (0, 0, 16);
  var7.curorigin = var7.origin;
  var7 scripts\mp\gameobjects::requestid(1, 1);
  var7.type = "useObject";
  var7.numtouching["axis"] = 0;
  var7.numtouching["allies"] = 0;

  if(isDefined(level.dogtags[var8].objidnum)) {
    if(level.dogtags[var8].objidnum != -1) {
      var9 = level.dogtags[var8].objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(var9, "current");
      scripts\mp\objidpoolmanager::update_objective_onentity(var9, level.dogtags[var8]);
      scripts\mp\objidpoolmanager::update_objective_setzoffset(var9, 22);
      scripts\mp\objidpoolmanager::update_objective_setbackground(var9, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(level.dogtags[var8].objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(level.dogtags[var8].objidnum, 0);
      level.dogtags[var8] scripts\mp\gameobjects::setobjectivestatusicons("waypoint_dogtags_friendly", "waypoint_dogtags");
      level.dogtags[var8] scripts\mp\gameobjects::setvisibleteam("any");
      getbnetigrbattlepassxpmultiplier(var9, 8858, 9843);
      getscriptcachecontents(var9, 0.5, 1);
    }
  }

  playsoundatpos(var6, "mp_killconfirm_tags_drop");
}

function getclocksoundaliasfortimeleft() {
  if(level.dogtags.size > 60) {
    var0 = undefined;

    foreach(var2 in level.dogtags) {
      if(!isDefined(var0) || var2.spawntime < var0.spawntime) {
        var0 = var2;
      }
    }

    thread removetags();
    return;
  }
}

function ref_13b4c(var0, var1) {
  self endon("death");
  var2 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var1, self.origin, self.angles, var0, undefined, undefined, undefined, 1);
  var3 = var2.origin;
  var4 = abs(self.origin[2] - var3[2]);
  var5 = getdvarint("NPOQPMP", 800);
  var6 = sqrt(2 * var4 / var5) + 0.5;
  var7 = trajectorycalculateinitialvelocity(self.origin, var3, (0, 0, -1 * var5), var6);
  self movegravity(var7, var6);
  wait var6;
  self.origin = var3;

  if(isDefined(var2.set_force_aitype_armored)) {
    self linkTo(var2.set_force_aitype_armored);
    self.set_force_aitype_armored = var2.set_force_aitype_armored;
    return;
  }
}

function makedroneguardscrambler(var0) {
  if(isDefined(var0.owner)) {
    var0 = var0.owner;
  }

  if(getdvarint("MLNNMOPQOP", 0) == 6) {
    var0 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_collect_dog_tags_for_s3_5_event_wz", 1);
  }

  if(var0.pers["team"] == self.victimteam) {
    self playSound("mp_killconfirm_tags_deny");
    var0 scripts\mp\rank::giverankxp("tag_denied", 25);
    var0 scripts\mp\utility\stats::incpersstat("denied", 1);
    var0 scripts\mp\persistence::statsetchild("round", "denied", var0.pers["denied"]);
    thread make_emp_config();
    scripts\mp\gametypes\obj_dogtag::allyonuse(var0);

    if(var0 == self.victim) {
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("collect_own_tags", var0);
    }

    if(isDefined(level.dogtagallyonusecb) && !level.gameended) {
      self thread[[level.dogtagallyonusecb]](var0);
    }

    start_link_logic_on_players(var0);
  } else {
    self playSound("mp_killconfirm_tags_pickup");
    var0 scripts\mp\utility\stats::incpersstat("confirmed", 1);
    var0 scripts\mp\persistence::statsetchild("round", "confirmed", var0.pers["confirmed"]);
    scripts\mp\gametypes\obj_dogtag::enemyonuse(var0);

    if(isDefined(level.dogtagenemyonusecb) && !level.gameended) {
      self thread[[level.dogtagenemyonusecb]](var0);
    }

    var0 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
    make_hb_pick_up_interact(var0);
    start_marquee(var0);
  }

  self.victim notify("tag_removed");
  thread removetags();
}

function makecrateusableforplayer(var0) {
  if(isDefined(var0.owner)) {
    var0 = var0.owner;
  }

  if(getdvarint("MLNNMOPQOP", 0) == 6) {
    var0 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_collect_dog_tags_for_s3_5_event_wz", 1);
  }

  var1 = self.origin;
  playsoundatpos(var1, "mp_killconfirm_tags_pickup");
  var0 scripts\mp\utility\stats::incpersstat("confirmed", 1);
  var0 scripts\mp\persistence::statsetchild("round", "confirmed", var0.pers["confirmed"]);
  var0 scripts\mp\gametypes\obj_dogtag::ontagpickupevent("tag_collected");
  var0 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
  make_hb_pick_up_interact(var0);
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

function make_silencer_pick_up_interact(var0, var1) {
  var2 = spawnStruct();
  var2.spotlight_sweep_to_loc_safe = var0;
  var2.playerwaittillstreamhintcomplete = var1;
  return var2;
}

function make_hb_pick_up_interact() {
  thread make_emp_config();
  start_loc();
  var0 = propgiveteamscore();

  for(var1 = 1; var1 <= level.make_place_c4_interact.size; var1++) {
    if(var0 == level.make_place_c4_interact[var1].spotlight_sweep_to_loc_safe) {
      self[[level.make_place_c4_interact[var1].playerwaittillstreamhintcomplete]]();
      self.spawnropeandbag = var1;
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

function make_usb_model_usable(var0) {
  if(isDefined(var0)) {
    var0.label = &"BR_BODYCOUNT/NEXT_REWARD_UAV";
    return;
  }

  make_laser_shutdown_interact("uav");
}

function make_outline_ents(var0) {
  if(isDefined(var0)) {
    var0.label = &"BR_BODYCOUNT/NEXT_REWARD_LEGENDARY_WEAPON_DROP";
    return;
  }

  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_offhand_advancedlootdrop", 1);
  thread scripts\mp\hud_message::showsplash("br_body_count_legendary_weapon_drop");
}

function make_javelin_ammo_refill_interact(var0) {
  if(isDefined(var0)) {
    var0.label = &"BR_BODYCOUNT/NEXT_REWARD_CLUSTER_STRIKE";
    return;
  }

  make_laser_shutdown_interact("toma_strike");
}

function make_headicon_on_ai(var0) {
  if(isDefined(var0)) {
    var0.label = &"BR_BODYCOUNT/NEXT_REWARD_ADVANCED_GAS_MASK";
    return;
  }

  thread scripts\mp\hud_message::showsplash("br_body_count_rewarded_gas_mask");
  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_equip_gasmask_durable", 1);
}

function make_intel_model_usable(var0) {
  if(isDefined(var0)) {
    var0.label = &"BR_BODYCOUNT/NEXT_REWARD_ARMOR_SATCHEL";
    return;
  }

  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_plate_pouch", 1);
}

function make_pilot_invincible(var0) {
  if(isDefined(var0)) {
    var0.label = &"BR_BODYCOUNT/NEXT_REWARD_PRECISION_AIRSTRIKE";
    return;
  }

  make_laser_shutdown_interact("precision_airstrike");
}

function make_javelin_model(var0) {
  if(isDefined(var0)) {
    var0.label = &"BR_BODYCOUNT/NEXT_REWARD_EXTRA_LIFE";
    return;
  }

  thread scripts\mp\hud_message::showsplash("br_body_count_rewarded_extra_life");
  start_mine_caves();
}

function make_solution_struct(var0) {
  if(isDefined(var0)) {
    var0.label = &"BR_BODYCOUNT/NEXT_REWARD_SPECIALIST";
    return;
  }

  thread scripts\mp\hud_message::showsplash("br_body_count_rewarded_specialist");
  scripts\mp\perks\perks::bears();
}

function make_heli_blade_patch_clip(var0) {
  if(isDefined(var0)) {
    var0.label = &"BR_BODYCOUNT/NEXT_REWARD_ADVANCED_UAV";
    return;
  }

  make_laser_shutdown_interact("directional_uav");
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dogtag_reward", self, undefined, undefined, 1);
}

function make_laser_shutdown_interact(var0) {
  var1 = isDefined(self.streakdata.streaks[1]);
  scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar(var0, var1, 1);

  if(!level.gameended) {
    thread scripts\mp\hud_message::showkillstreaksplash(var0);
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
  var0 = propgiveteamscore();
  var1 = propgetlocation();
  var2 = propremovefromcircle();
  var3 = 0;
  var3 += var0 * 100;
  var3 += var1 * 10;
  var3 += var2;
  self setclientomnvar("ui_br_bodycount_reward_data", var3);
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

function ref_12ad7(var0, var1, var2) {
  if(!isDefined(level.copy_wave_settings_from_module.area_structs)) {
    level.copy_wave_settings_from_module.area_structs = [];
  }

  var1 = getdvarint("scr_bodycount_location_weight_" + var0, var1);

  if(var1 <= 0) {
    return;
  }

  var3 = spawnStruct();
  var3.ref_13902 = var0;
  var3.spotlights = var1;
  var3.ref_140b7 = var2;
  level.copy_wave_settings_from_module.area_structs[var0] = var3;
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
    foreach(var1 in level.copy_wave_settings_from_module.area_structs) {
      if(level.copy_wave_settings_from_module.ref_13903 == var2) {
        return var1;
      }
    }
  }

  if(level.copy_wave_settings_from_module.area_structs.size == 1) {
    return level.copy_wave_settings_from_module.area_structs[0];
  }

  var3 = 0;

  foreach(var1 in level.copy_wave_settings_from_module.area_structs) {
    var3 += var1.spotlights;
  }

  var6 = randomintrange(0, var3);

  foreach(var1 in level.copy_wave_settings_from_module.area_structs) {
    if(var6 < var1.spotlights) {
      return var1;
    }

    var6 -= var1.spotlights;
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
  var0 = getdvarvector("br_final_circle_override", level.grouptorewards);
  return var0;
}

function init_relic_aggressive_melee() {
  var0 = (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], 0);
  var1 = level.br_level.br_circleradii[1];
  var2 = scripts\mp\gametypes\br_c130::createtestc130path(var0, var1);
  return var2;
}

function being_hacked() {
  thread vehomn_getleveldata();
}

function vehomn_getleveldata() {
  level endon("game_ended");
  self endon("death");
  var0 = distance(self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor);
  var1 = var0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
  wait var1;

  foreach(var3 in level.players) {
    if(isDefined(var3) && isDefined(var3.br_infil_type) && var3.br_infil_type == "c130" && !isDefined(var3.jumptype)) {
      var3.jumptype = "outOfBounds";
      var3 notify("halo_kick_c130");
    }
  }
}

function circletimer(var0) {
  if(var0 >= 2) {
    level.copy_wave_settings_from_module.ref_12c9a += level.copy_wave_settings_from_module.ref_12c99;
  }

  if(var0 < level.copy_wave_settings_from_module.old_load_hvt) {
    openelevatordoors(var0);
    return false;
  }

  if(var0 == level.copy_wave_settings_from_module.old_load_hvt) {
    if((level.mapname == "mp_don4" || level.mapname == "mp_don4_pm") && !level.chopper_boss) {
      level.ref_12ca7 = 7500;
    }

    level thread scripts\mp\gametypes\br_quest_util::generate_solution();
    level thread scripts\mp\gametypes\br_quest_util::little_bird_mg_mp_enterendinternal();
    thread ondamagerelicsteelballs(level);

    foreach(var2 in level.players) {
      if(isalive(var2) || istrue(var2.chopper_boss_combat_actions)) {
        if(getdvarint("MLNNMOPQOP", 0) == 6) {
          var2 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_reach_final_circle_for_s3_5_event_wz", 1);
        }
      }
    }

    return false;
  }

  if(var3 == level.copy_wave_settings_from_module.old_load_hvt + 1) {
    level.br_circle.dangercircleui.origin = scripts\mp\gametypes\br_circle::getdangercircleorigin() + (0, 0, scripts\mp\gametypes\br_circle::getdangercircleradius());
    scripts\mp\gametypes\br_circle::setstaticuicircles(500, level.br_circle.safecircleui, level.br_circle.dangercircleui, 0);
  }

  return true;
}

function success_zone_width() {
  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    level.copy_wave_settings_from_module.arena_bot_think_seek_dropped_weapons = [(-865, -11255, 242), (-1896, -8692, 210), (-2890, -5367, 756), (383, -5884, 756), (2330, -7363, 758), (2660, -3249, 895), (-2062, -2682, 1041), (797, -2415, 1418), (-3666, -903, 746), (-566, 75, 1818), (2908, 70, 892), (5192, -3942, 198), (-6002, -109, 142), (-2431, 1723, 1060), (826, 2159, 1258), (-4423, 3943, 675), (-969, 4627, 1130), (3597, 3145, 252), (2066, 5665, 537), (-634, 7038, 1119), (-3103, 8079, 530), (1726, 9290, 722), (-322, 9748, 818), (-1428, 9176, 762), (-3014, 9975, 638)];
  }

  var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("extra_life_crate");
  var0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var0.dummymodel = "military_carepackage_01_br_respawn";
  var0.friendlymodel = undefined;
  var0.enemymodel = undefined;
  var0.mountmantlemodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.minimapicon = undefined;
  var0.usepriority = -1;
  var0.usefov = 180;
  var0.timeout = undefined;
  var0.friendlyuseonly = 0;
  var0.ownerusetime = 0.5;
  var0.otherusetime = 0.5;
  var0.activatecallback = &ownerxuid;
  var0.capturecallback = &p4_trigger;
  var0.destroyoncapture = 1;
}

function openelevatordoors(var0) {
  if(var0 == 2) {
    thread ref_1354e();
    return;
  }
}

function ref_1354e() {
  wait randomintrange(10, 20);

  foreach(var1 in level.players) {
    var1 scripts\mp\hud_message::showsplash("br_body_count_respawn_crate_event");
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("respawn_crate");
  var3 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var4 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var5 = randomfloat(120);
  var6 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);

  for(var7 = 0; var7 < 3; var7++) {
    var8 = var3 + anglesToForward((0, var5 + var6 * var7 * 120, 0)) * var4 * 0.65;
    var9 = proprange(var8, var4 * 0.35, 0.25, 0.75, 1);

    while(!scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var9)) {
      var9 = proprange(var3, var4, 0.1, 0.9, 1);
      waitframe();
    }

    var9 += (0, 0, 2000);
    var10 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "extra_life_crate", var9, (0, randomint(360), 0));
    level.openrequested[level.openrequested.size] = var10;
    thread opennukecrate();
    thread openpos();
    wait randomintrange(3, 10);
  }
}

function proprange(var0, var1, var2, var3, var4) {
  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    return previous_spawn_points();
  }

  return scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var0, var1, var2, var3, var4);
}

function previous_spawn_points() {
  level.copy_wave_settings_from_module.arena_bot_think_seek_dropped_weapons = scripts\engine\utility::array_randomize(level.copy_wave_settings_from_module.arena_bot_think_seek_dropped_weapons);

  foreach(var1 in level.copy_wave_settings_from_module.arena_bot_think_seek_dropped_weapons) {
    if(scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var1)) {
      return var1;
    }
  }
}

function ownerxuid(var0) {
  if(istrue(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
      return;
    }

    return;
  }
}

function p4_trigger(var0) {
  level.openrequested = scripts\engine\utility::array_remove(level.openrequested, self);
  self notify("captured");
  var1 = easepower("brloot_bodycount_extra_life", self.origin + (0, 0, 16));
  scripts\mp\gametypes\br_pickups::ref_12b3a(var1);

  if(isDefined(self.objectiveiconid)) {
    objective_delete(self.objectiveiconid);
  }

  playFX(level.conf_fx["vanish"], self.molotov_delete_oldest_trigger.origin);
  self.molotov_delete_oldest_trigger delete();
}

function opennukecrate() {
  var0 = scripts\engine\utility::drop_to_ground(self.origin, 50, -3000, (0, 0, 1));
  self.molotov_delete_oldest_trigger = spawn("script_model", var0 + (0, 0, 3));
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

function ondamagerelicsteelballs(var0, var1) {
  level endon("game_ended");
  level.copy_wave_settings_from_module.managevehiclehealthui = spawnStruct();
  var2 = level.copy_wave_settings_from_module.ref_140b6;

  if(isDefined(var1)) {
    var2 = var1;
  }

  var3 = level.copy_wave_settings_from_module.oncrankedhit;
  var4 = getgroundposition(var2, 1);

  if(isDefined(var0)) {
    var5 = var0 - level.copy_wave_settings_from_module.oldlatespawnplayer;

    if(var5 > 0) {
      wait var5;
    } else {
      wait 30;
    }
  }

  scripts\mp\gametypes\br_publicevents::ref_13371("br_body_count_exfil_incoming");
  thread ondroprelics(level);
  var6 = frag_crate_player_at_max_ammo(700);

  if(var6 < level.copy_wave_settings_from_module.old_accuracy) {
    var6 = level.copy_wave_settings_from_module.old_accuracy;
  }

  var5 = level.copy_wave_settings_from_module.oldlatespawnplayer - var6;
  wait var5;
  var7 = play_quarry_intro_vo();
  var8 = undefined;

  if(isDefined(var7)) {
    var8 = thread ref_126a8(var7, var2, undefined, 5000, 700, 0);
    thread outro_main();
  }

  var5 = level.copy_wave_settings_from_module.old_accuracy - level.copy_wave_settings_from_module.omnvar_bit;
  wait var5;
  scripts\mp\gametypes\br_publicevents::ref_13371("br_body_count_exfil_online");

  foreach(var10 in level.players) {
    var10 scripts\mp\utility\lower_message::setlowermessageomnvar(72, undefined, 10);
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_ready");
  wait level.copy_wave_settings_from_module.omnvar_bit;
  level.copy_wave_settings_from_module.managevehiclehealthui.trigger = spawn("trigger_radius", var4, 0, int(var3), int(level.defend_wave_3));
  var12 = scripts\mp\gametypes\obj_dom::setupobjective(level.copy_wave_settings_from_module.managevehiclehealthui.trigger, "neutral");
  var12.onuse = &oncapture;
  var12.onbeginuse = &omvar_code;
  var12.onuseupdate = &oncollectitem;
  var12.onenduse = &on_killed_tutorial;
  var12.oncontested = &on_execution_begin;
  var12.onuncontested = &onarmorboxusedbyplayer;
  var12.onunoccupied = &onattackerdamagenottracked;
  var12.onpinnedstate = &on_max;
  var12.onunpinnedstate = &oncacheopen;
  var12.ref_138b2 = &on_min;
  var12.stompprogressreward = &onfieldupgradeend;
  var12.gate_swings_open = 1;
  var12.id = "domFlag";
  var12.pinobj = 0;
  var12.lockupdatingicons = 1;
  var12 scripts\mp\gameobjects::setcapturebehavior("persistent");
  var13 = level.copy_wave_settings_from_module.oilfire_burning_player_watch;
  var12 scripts\mp\gameobjects::setusetime(var13);
  onfieldupgradeendbuffer(var12);
  playencryptedcinematicforall(var12.objidnum, 1);
  level.copy_wave_settings_from_module.managevehiclehealthui.oil_puddles = var12;
  level.objectivescaler = 1;

  foreach(var10 in level.players) {
    var10 setclientomnvar("ui_securing", 17);
    var10 setclientomnvar("ui_securing_progress", 0);
  }
}

function ondamagepredamagemodrelicfocusfire(var0) {
  foreach(var2 in level.players) {
    if(isDefined(var2) && isDefined(var2.team)) {
      if(var2.team == var0) {
        var2 setclientomnvar("ui_securing", 18);
        continue;
      }

      var2 setclientomnvar("ui_securing", 19);
    }
  }
}

function ondamagerelicfocusfire(var0) {
  if(var0 == "contested") {
    self setclientomnvar("ui_securing", 20);
    return;
  }

  if(var0 == "friendly") {
    self setclientomnvar("ui_securing", 18);
    return;
  }

  self setclientomnvar("ui_securing", 19);
}

function onfirstlandcallback(var0) {
  foreach(var2 in level.players) {
    if(isDefined(var2)) {
      var2 setclientomnvar("ui_securing_progress", var0);
    }
  }
}

function omnvardata(var0) {
  self notify("exfil_newOwnerFeedback");
  self endon("exfil_newOwnerFeedback");

  if(isPlayer(var0)) {
    var1 = var0.team;
  } else {
    var1 = var1;
  }

  foreach(var3 in level.players) {
    if(isDefined(var3) && isDefined(var1)) {
      if(var3.team == var1) {
        thread ondamagerelicfocusfire(var3);
        var3 thread scripts\mp\hud_message::showsplash("br_body_count_friendly_team_exfil");
        continue;
      }

      thread ondamagerelicfocusfire(var3);
      var3 thread scripts\mp\hud_message::showsplash("br_body_count_enemy_team_exfil");
    }
  }

  ref_1242c(var1, "exfil_friendly_start", "exfil_enemy_start");
}

function oncapture(var0) {
  var1 = var0.team;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var1].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  ref_1242c(var1, "exfil_friendly_win", "exfil_enemy_win");
  onfirstlandcallback(1);
  thread oldest_targeted_by_chopper_time(var1);
}

function omvar_code(var0) {
  if(!isDefined(self.ref_11f63) || !self.ref_11f63) {
    self.ref_11f63 = 1;
    thread omnvardata(var0);
    var1 = scripts\mp\utility\teams::getfriendlyplayers(var0.team, 0);

    foreach(var3 in var1) {
      var3 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function oncollectitem(var0, var1, var2, var3) {
  if(var1 < 1 && !level.gameended && !istrue(self.get_current_bush_zone)) {
    onfirstlandcallback(var1);
    ref_12427(var1, var0);
  }

  if(var1 > 0.05 && var2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
  }

  if(self.gate_swings_open && var1 > 0.5) {
    self.gate_swings_open = 0;
    ref_1242c(var0, "exfil_friendly_50", "exfil_enemy_50");
    return;
  }
}

function on_killed_tutorial(var0, var1, var2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var0, var1, var2);
}

function on_execution_begin() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_contested");
  var0 = scripts\mp\gameobjects::getownerteam();

  foreach(var2 in level.players) {
    if(isDefined(var2) && isDefined(var0)) {
      thread ondamagerelicfocusfire(var2);
    }
  }
}

function onarmorboxusedbyplayer(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  var2 = scripts\mp\gameobjects::getownerteam();
  var3 = undefined;
  var4 = oldbranchents();

  if(var4 <= 1) {
    foreach(var6 in level.teamnamelist) {
      var7 = self.teamprogress[var6];

      if(var7 > 0) {
        var3 = var6;
        break;
      }
    }

    if(isDefined(var3)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var3);

      if(var1) {
        ondamagepredamagemodrelicfocusfire(var3);
      }
    } else if(var2 != "neutral") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var2);
    } else if(var0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var0);
    }

    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");

    if(isDefined(var0) && (var0 == "none" || var2 == "neutral")) {
      self.didstatusnotify = 0;
      return;
    }

    return;
  }
}

function onattackerdamagenottracked() {
  var0 = scripts\mp\gameobjects::getownerteam();

  if(var0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral");
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
  }

  self.didstatusnotify = 0;
}

function on_max(var0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");
    return;
  }
}

function oncacheopen(var0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
    return;
  }
}

function on_min(var0) {
  var1 = scripts\mp\utility\teams::getenemyteams(var0);
  var2 = undefined;

  foreach(var4 in var1) {
    var5 = self.teamprogress[var4];

    if(var5 > 0) {
      var2 = var5 / self.usetime;
    }
  }

  if(isDefined(var2)) {
    onfirstlandcallback(var2);

    if(var2 <= 0.008) {
      thread omnvardata(self.claimteam);
    }

    if(!self.gate_swings_open && var2 < 0.4) {
      self.gate_swings_open = 1;
      return;
    }

    return;
  }
}

function onfieldupgradeend(var0) {
  var0 thread scripts\mp\utility\points::giveunifiedpoints("obj_prog_defend");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");

  if(isDefined(self.lastprogressteam)) {
    thread omnvardata(var0);
    self.lastprogressteam = undefined;
    return;
  }
}

function ref_12427(var0, var1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var2 = "";
    var0 = int(floor(var0 * 10));
    var2 = "mp_dom_capturing_tick_0" + var0;
    self.visuals[0] playsoundtoteam(var2, var1);
    return;
  }
}

function oldest_targeted_by_chopper_time(var0) {
  waitframe();

  if(istrue(level.ref_13dc0)) {
    return;
  }

  level.ref_13dc0 = 1;
  level.ref_145c1 = 1;
  level thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["objective_completed"]);
  var1 = [];

  if(isDefined(var0) && var0 != "tie") {
    var1 = scripts\mp\utility\teams::getteamdata(var0, "players");
  }

  thread scripts\mp\music_and_dialog::ref_12789(var1);
}

function ondroprelics(var0) {
  var1 = spawn("script_model", var0 - (0, 0, 3));
  var1 setModel("tag_origin");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), var1, "tag_origin");
}

function oldbranchents() {
  var0 = 0;

  foreach(var2 in self.numtouching) {
    if(var2 > 0 && (!isstring(var3) || var3 != "none")) {
      var0++;
    }
  }

  return var0;
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
  var0 = 0;
  thread make_focus_fire_objective();
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("zombiedefault");

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    scripts\mp\utility\perk::giveperk("specialty_sprintmelee");
    scripts\mp\utility\perk::giveperk("specialty_sprintads");
    scripts\mp\utility\perk::giveperk("specialty_marathon");
  }

  while(var0 < level.copy_wave_settings_from_module.ref_11fd7) {
    if(self issupersprinting()) {
      self refreshsprinttime();
    }

    wait 0.1;
    var0 += 0.1;
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
  var0 = level.copy_wave_settings_from_module.ref_11fd7;
  var1 = gettime() + var0 * 1000;
  self setclientomnvar("ui_privateevent_timer", var1);
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

function ref_1336e(var0) {
  waittillframeend();
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var0 * 1000));
  scripts\mp\gametypes\br_gulag::ref_131a2(1);
  thread spawn_drones(var0);
}

function spawn_drones(var0) {
  self endon("disconnect");

  if(isDefined(var0)) {
    wait var0;
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

function radar_sweeps(var0, var1) {
  var2 = (randomfloat(1) - 0.5, randomfloat(1) - 0.5, 0);

  if(!istrue(var1)) {
    GscBinSkip0(0x2e, 2, randomfloat(1) - 0.5);
  }

  var3 = var0 * vectorNormalize(var2);
  return var3;
}

function _setdomflagiconinfo(var0, var1, var2, var3) {
  level.waypointcolors[var0] = var1;
  level.waypointbgtype[var0] = 1;
  level.waypointstring[var0] = var2;
  level.waypointshader[var0] = "ui_mp_br_mapmenu_icon_gulag_overtime_objective";
  level.waypointpulses[var0] = var3;
}

function ref_125fc() {
  var0 = spawnStruct();
  var0.ref_12889 = [];
  var0.brtdm_config = [];
  var0.brtruck_cleanupents = [];
  var0.brtruck_ontimelimit = [];
  var0.offhands = [];
  var0.nvidiaansel_overridecollisionradius = [];
  var0.should_use_velo_forward = self.should_use_velo_forward;
  var0.callprecisionairstrikeonlocation = scripts\mp\equipment::getequipmentslotammo("health");
  var1 = [];
  var2 = self getweaponslistprimaries();

  foreach(var4 in var2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var4) && !issubstr(var4.basename, "iw8_fists_mp") && !scripts\mp\utility\weapon::unset_relic_mythic(var4.basename)) {
      var1 = var4;
    }
  }

  foreach(var7 in var1) {
    var8 = createheadicon(var7);

    if(var7.basename == "iw8_lm_dblmg_mp" || var7.basename == "iw8_la_mike32_mp") {
      var0.brtdm_config[var8] = self getweaponammoclip(var7);
      var0.brtruck_ontimelimit[var8] = self getweaponammostock(var7);
    } else {
      var0.brtdm_config[var8] = weaponclipsize(var7);
      var0.brtruck_ontimelimit[var8] = int(max(self getweaponammostock(var7), weaponclipsize(var7)));
    }

    if(scripts\mp\utility\weapon::turnexfiltoside(var7)) {
      var0.brtruck_cleanupents[var8] = weaponclipsize(var7);
    }

    if(getsubstr(var8, 0, 4) == "alt_") {
      continue;
    }

    var0.ref_12889[var0.ref_12889.size] = var7;
  }

  var10 = self getweaponslistoffhands();

  foreach(var12 in var10) {
    if(var12.basename == "bandage_br") {
      continue;
    }

    var13 = self getweaponammoclip(var12);

    if(var13 <= 0) {
      continue;
    }

    var0.offhands[var0.offhands.size] = var12;
    var14 = createheadicon(var12);
    var0.brtdm_config[var14] = var13;
  }

  foreach(var17 in self.equipment) {
    var0.nvidiaansel_overridecollisionradius[var17] = var18;
  }

  var0.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent) {
    var0.super = self.equipment["super"];
  }

  if(isDefined(self.streakdata.streaks[1])) {
    var0.vo_one_remain = self.streakdata.streaks[1].streakname;
  }

  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    var0.gasmaskhealth = self.gasmaskhealth;
    var0.plunderpads = self.plunderpads;
    var0.plundersilentcountdownendtime = self.plundersilentcountdownendtime;
  }

  self.ref_12eb0 = var0;
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
  var0 = propgiveteamscore();

  if(var0 >= 8) {
    scripts\mp\perks\perks::bears();
    return;
  }
}

function droponplayerdeath(var0) {
  ref_125fc();
  var1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  scripts\mp\gametypes\br_pickups::minplunderextractions(var1);
  scripts\mp\gametypes\br_pickups::missiontime(var1);
  scripts\mp\gametypes\br_pickups::mintokensdropondeath(var1);
  scripts\mp\gametypes\br_pickups::missedinfilplayerhandler(var1);
  scripts\mp\gametypes\br_pickups::hangar_doors_opening_quadrace();
  return true;
}

function playerdropplunderondeath(var0, var1) {
  if(scripts\mp\utility\game::updatehistoryhud(self)) {
    return 1;
  }

  if(istrue(level.gameended)) {
    return 1;
  }

  if(isDefined(self.plundercount) && self.plundercount > 0) {
    var2 = self.plundercount;
  } else {
    var2 = 0;
  }

  if(istrue(self.unicornpoints)) {
    var3 = 0;
    var4 = level.endgametutorial_func.ref_127b5;
  } else {
    var3 = int(var4 * level.copy_wave_settings_from_module.ref_127be + 0.5);
    var4 = int(level.copy_wave_settings_from_module.ref_127b5 + var4 * level.copy_wave_settings_from_module.ref_127b6 + 0.5);
  }

  scripts\mp\gametypes\br_plunder::playersetplundercount(var3);

  if(var4 <= 0) {
    return;
  }

  scripts\mp\gametypes\br_plunder::ml_p3_func(var4, var2);
  return 1;
}

function ref_1242c(var0, var1, var2) {
  foreach(var4 in level.teamnamelist) {
    if(var4 == var0) {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var1, var4);
      continue;
    }

    level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var2, var4);
  }
}

function ref_126a8(var0, var1, var2, var3, var4, var5) {
  var6 = var0;
  var7 = var6 + (0, 0, 2500);
  var8 = play_skit_and_watch_for_endons(var7, var1);
  var9 = (0, var8, 0);
  var10 = undefined;
  var11 = undefined;

  if(isDefined(var2)) {
    var10 = var7 + -1 * anglesToForward(var9) * var2;
    var11 = var7 + anglesToForward(var9) * var2;
  } else {
    var10 = var7 + -1 * anglesToForward(var9) * 5000;
    var11 = var7 + anglesToForward(var9) * 5000;
  }

  var12 = spawnheli(self, var10, var7, var11, var3, var4, var5);
  return var12;
}

function play_quarry_intro_vo() {
  var0 = getarraykeys(level.teamdata);

  foreach(var2 in var0) {
    if(level.teamdata[var2]["alivePlayers"].size > 0) {
      return level.teamdata[var2]["alivePlayers"][0];
    }
  }

  return undefined;
}

function play_skit_and_watch_for_endons(var0, var1) {
  if(isDefined(var1) && isDefined(var1.player_respawn)) {
    return var1.player_respawn;
  }

  var2 = 10;
  var3 = scripts\engine\trace::create_world_contents();
  var4 = 0;

  while(var4 < 360) {
    var5 = (0, var4, 0);
    var6 = var0 + -1 * anglesToForward(var5) * 5000;
    var7 = var0 + anglesToForward(var5) * 5000;
    var8 = scripts\engine\trace::sphere_trace(var0, var7, 100, undefined, var3, 1);

    if(var8["fraction"] == 1) {
      if(isDefined(var1)) {
        var1.player_respawn = var4;
      }

      return var4;
    }

    if(var4 % 3 == 0) {
      waitframe();
    }

    var4 += var2;
  }

  var4 = randomfloat(360);

  if(isDefined(var1)) {
    var1.player_respawn = var4;
  }

  return var4;
}

function outro_main() {
  self endon("death");
  self endon("leaving");
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  var0 = ref_13c30(self.pathgoal, self.hoverheight);
  var1 = self.pathgoal[2] - var0;
  self.player_weapon_fired_monitor = frag_crate_player_at_max_ammo(var1);
  sortplayerplunderscores(1, self.player_weapon_fired_monitor);
  self waittill("goal");
  thread heliwatchgameendleave();
  thread snapshot_crate_spawn();
  helidescend(self.endpoint, var0);
  soldier_agent_lwfn0();
  helicleanupextract();
  thread sol_3_4_pool();
}

function spawnheli(var0, var1, var2, var3, var4, var5, var6) {
  var7 = vectortoangles(var2 - var1);
  var8 = 99;
  var9 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var0, var1, var7, "veh_apache_plunder_mp", "veh8_mil_air_mindia8_plunder_x");

  if(!isDefined(var9)) {
    return;
  }

  var10 = var2 * (1, 1, 0);
  var9.speed = 50;
  var9.accel = 125;
  var9.health = 1000;
  var9.maxhealth = var9.health;
  var9.team = var0.team;
  var9.owner = var0;
  var9.defendloc = var2;
  var9.lifeid = 0;
  var9.flaresreservecount = var8;
  var9.pathgoal = var2;
  var9.ref_121ff = var3;
  var9.endpoint = var10;
  var9.select_mountain_two_spawners = var7[1];
  var9.canuse = var6;
  var9.hoverheight = var4;
  var9.vehiclename = "magma_plunder_chopper";

  if(istrue(var5)) {
    var9 setCanDamage(1);
  } else {
    var9 setCanDamage(0);
  }

  var9 setmaxpitchroll(10, 25);
  var9 vehicle_setspeed(var9.speed, var9.accel);
  var9 sethoverparams(50, 100, 50);
  var9 setturningability(0.05);
  var9 setyawspeed(45, 25, 25, 0.5);
  var9 setotherent(var0);
  var9 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  return var9;
}

function frag_crate_player_at_max_ammo(var0) {
  var1 = frag_crate_spawn(5000, 100, 125);
  var2 = frag_crate_spawn(var0, 25, 31.25);
  var3 = var1 + var2;
  return var3;
}

function ref_13c30(var0, var1) {
  var2 = undefined;

  if(isDefined(var1)) {
    var2 = var1;
  } else {
    var2 = 256;
  }

  var3 = tracegroundpoint(var0, 100, [self]);
  var4 = var3[2];
  var5 = var4 + var2;
  return var5;
}

function sortplayerplunderscores(var0, var1) {
  var2 = gettime() + int(var1 * 1000);
  var3 = level.teamdata[self.team]["alivePlayers"];

  foreach(var5 in var3) {
    var5 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_plunder_extract_state", var0);
    var5 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_plunder_extract_end_time", var2);
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

function helidescend(var0, var1) {
  self endon("death");
  var2 = var0[0];
  var3 = var0[1];
  var4 = (var2, var3, var1);
  self setvehgoalpos(var4, 1);
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

function smoke_init(var0) {
  scripts\engine\utility::waittill_either("leaving", "death");
  heliusecleanup();
}

function helicleanupextract(var0) {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
  }

  if(istrue(var0) && isDefined(self.site)) {
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

function tracegroundpoint(var0, var1, var2) {
  var3 = -99999;
  var4 = (var0[0], var0[1], var3);
  var5 = scripts\engine\trace::create_world_contents();
  var6 = undefined;

  if(isDefined(var1)) {
    var6 = scripts\engine\trace::sphere_trace(var0, var4, var1, var2, var5);
  } else {
    var6 = scripts\engine\trace::ray_trace(var0, var4, var2, var5);
  }

  return var6["position"];
}

function frag_crate_spawn(var0, var1, var2) {
  var3 = var0 * 1.57828e-05;
  var4 = 0.5 * var2;
  var5 = var1;
  var6 = -1 * var3;
  var7 = (-1 * var5 + sqrt(var5 * var5 - 4 * var4 * var6)) / 2 * var4;
  var7 *= 3600;
  var7 += 1.5;
  return var7;
}

function snapplayertotoppos() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", var0);

    if(isDefined(var0) && nuke_vault_suicidebomber_internal(var0)) {
      var0 dodamage(var0.health, self.origin, var0, var0, "MOD_CRUSH");
    }
  }
}

function snappointtooutofboundstriggertrace() {
  self endon("leaving");
  self endon("death");
  var0 = 70;
  var1 = -80;
  var2 = 150;
  var3 = 25;
  var4 = -100;

  for(;;) {
    var5 = getentarrayinradius("script_vehicle", "classname", self.origin, getdvarfloat("test_radius", 400));

    if(var5.size <= 1) {
      wait 0.5;
      continue;
    }

    var6 = scripts\engine\trace::create_vehicle_contents();
    var7 = anglesToForward(self.angles);
    var8 = self.origin + var7 * getdvarfloat("test_f", var2) + (0, 0, getdvarfloat("test_d", var1));
    var9 = scripts\engine\trace::sphere_trace(var8, var8 + (0, 0, 1), var0, self, var6);
    var10 = var9["entity"];

    if(isDefined(var10) && nuke_vault_suicidebomber_internal(var10)) {
      var10 dodamage(var10.health, self.origin, var10, var10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var8 = self.origin + var7 * getdvarfloat("test_m", var3) + (0, 0, getdvarfloat("test_d", var1));
    var9 = scripts\engine\trace::sphere_trace(var8, var8 + (0, 0, 1), var0, self, var6);
    var10 = var9["entity"];

    if(isDefined(var10) && nuke_vault_suicidebomber_internal(var10)) {
      var10 dodamage(var10.health, self.origin, var10, var10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var8 = self.origin + var7 * getdvarfloat("test_b", var4) + (0, 0, getdvarfloat("test_d", var1));
    var9 = scripts\engine\trace::sphere_trace(var8, var8 + (0, 0, 1), var0, self, var6);
    var10 = var9["entity"];

    if(isDefined(var10) && nuke_vault_suicidebomber_internal(var10)) {
      var10 dodamage(var10.health, self.origin, var10, var10, "MOD_CRUSH");
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