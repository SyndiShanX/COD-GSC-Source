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
  level.ref_12fb3 = getdvarint("scr_bmo_secondsBeforePlacementUpdates", 60);
  level.loadout_updateclassdefault_headlessgetweaponn = getdvarint("scr_bmo_disable_perc_announcements", 0);
  level.ref_11a27 = getdvarint("scr_dmz_loot_leader_mark_count", 3);
  level.ref_11b62 = getdvarint("scr_dmz_loot_leader_mark_count", 3);
  level.ref_11a2a = getdvarint("scr_bmo_loot_leader_mark_size", 1000);
  level.ref_11a31 = getdvarint("scr_dmz_loot_leader_one_per_team", 1) == 1;
  level.ref_11a2b = getdvarint("scr_bmo_loot_leader_mark_size_dynamic", 0);
  level.ref_11a2d = getdvarint("scr_bmo_loot_leader_mark_info_strong_size", 2000);
  level.ref_11a2e = getdvarint("scr_bmo_loot_leader_mark_info_strong_value", 5000);
  level.ref_11a2f = getdvarint("scr_bmo_loot_leader_mark_info_weak_size", 5000);
  level.ref_11a30 = getdvarint("scr_bmo_loot_leader_mark_info_weak_value", 1000);
  level.ref_11a2c = getdvarint("scr_bmo_loot_leader_mark_top_teams", 3);
  level.ref_11a28 = getdvarint("scr_kingslayer_lootLeaderUpdateMarkerTime", 0);
  level.ref_127c0 = getdvarfloat("scr_bmo_music_first", 0.3);
  level.ref_127c2 = getdvarfloat("scr_bmo_music_second", 0.5);
  level.ref_127c3 = getdvarfloat("scr_bmo_music_third", 0.75);
  level.ref_127c1 = getdvarfloat("scr_bmo_music_fourth", 0.9);
  level.isbotpracticematch = getdvarfloat("scr_kingslayer_dangerNotifyCooldown", 20);
  level.isbrgametypefuncdefined = [];
  level.ref_14062 = getdvarint("scr_dmz_useAutoRespawn", 1);
  level.checkpoint_objective_id = getdvarint("scr_dmz_autoRespawnWaitTime", 1);
  level.ref_13bcd = getdvarint("scr_dmz_tokenRespawnWaitTime", level.checkpoint_objective_id);
  level.start_persistent_turbulence = getdvarint("scr_dmz_respawn_penalty", 0);
  level.start_pipe_room = getdvarfloat("scr_dmz_respawn_penalty_max", 15);
  level.ref_12ca7 = getdvarint("scr_bmo_respawnHeightOverride", 5000);
  level.ref_12cb4 = getdvarint("scr_dmz_respawn_time_disable", 0);
  level.ref_121cc = getdvarfloat("scr_bmo_parachuteDeployDelay", 0.5);
  level.wait_unload_jeep = getdvarint("scr_kingslayer_hideKingsOnSpawn", 1) == 1;
  level.waitandpause = getdvarint("scr_kingslayer_spawnProtection", 1) == 1;
  level.waitandspawnprops = getdvarfloat("scr_kingslayer_spawnProtectionModifier", 0.5);
  level.waitandgetnewspawnpoint = getdvarfloat("scr_kingslayer_spawnLauncherDamage", 0.5);
  level.ref_133ea = getdvarint("scr_bmo_skipWeaponDropOnDeath", 1);
  level.ref_133cd = getdvarint("scr_bmo_skipEquipmentDropOnDeath", 1);
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
  level.ref_11c85 = &ref_126a6;
  level.needs_controller = getdvarint("scr_bmo_endMatchCameraTransitions", 1);
  level.ref_13be1 = [];
  level.ref_11a32 = [];
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
  level.ref_11c84 = &ref_11c83;
  level.ononeleftevent = &ononeleftevent;
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerShouldRespawn", &ref_12691);
  scripts\mp\gametypes\br_gametypes::ref_12b11("spawnHandled", &ref_1365d);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerConnect", &dlog_analytics_init);
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

function ref_1365d(var0) {
  return istrue(var0.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done");
}

function ref_12691(var0) {
  return true;
}

function displaydelayedmissioncompletesplash() {
  var0 = spawnStruct();
  var0.weights = [];
  level.votesys_update_time = var0;
  display_message_to_guilty_player("toma_strike", getdvarint("scr_kingslayer_kingkill_toma", 50));
  display_message_to_guilty_player("precision_airstrike", getdvarint("scr_kingslayer_kingkill_precision", 10));
  display_message_to_guilty_player("directional_uav", getdvarint("scr_kingslayer_kingkill_auav", 40));
}

function displayplunderloss() {
  scripts\mp\gametypes\br_gametypes::ref_12b11("createC130PathStruct", &display_ping_hint_with_radial_check);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addToC130Infil", &display_message_to_teammates);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerWelcomeSplashes", &dmz_numteamswithplayers);
  waittillframeend();
  scripts\mp\flags::gameflaginit("placement_updates_allowed", 0);
  level.ontimelimit = &dmz_bot_callback_func;
  level.onplayerkilled = &dmg_trig;
  level.ref_11c7a = &ref_125f7;
  level.modifyplayerdamage = &distort_fx;
  level.assists_disabled = undefined;
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_c130Airdrop", "c130Airdrop_onCrateUse", &divide_living_ai);
  display_mission_failed_text();
  touchdown_origin();
  level.ref_11a29 = [];
  level.ref_140d9 = [];
  level.ref_140d9[0] = "assassination";
  level.ref_140d9[1] = "domination";
  level.ref_140d9[2] = "scavenger";
  thread numextractions();
  thread dmzextractcostdecrease();
  thread dist_sq_to_ref();
  thread dist_miles();
  thread ref_14365();
  thread ref_12397();

  if(getdvarfloat("scr_dmz_loot_leader_update_interval", 15) > 0) {
    thread ref_13ff1();
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
  scripts\cp_mp\utility\game_utility::ref_12c10("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12c11("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::ref_12c11("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::ref_12c11("me_electrical_box_street_01", 1);
}

function displaycodeindex() {}

function touchdown_origin() {
  foreach(var1 in level.teamnamelist) {
    level.teamdata[var1]["teamTotalScore"] = 0;
    level.teamdata[var1]["tokensTeamTotal"] = 0;
  }
}

function display_message_to_guilty_player(var0, var1) {
  level.votesys_update_time.weights[var0] = var1;
}

function display_relics_splash(var0) {
  var1 = [];
  var2 = 0;

  foreach(var5, var4 in level.votesys_update_time.weights) {
    var2 += var4;
    var1 = var2;
  }

  var6 = randomint(var2);
  var7 = undefined;

  foreach(var2 in var1) {
    if(var6 < var2) {
      var7 = var5;
      break;
    }
  }

  return var7;
}

function dmz_numteamswithplayers(var0) {
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
  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var1, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/WAR");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/WAR_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var1, &"OBJECTIVES/WAR_HINT");
  }
}

function ref_11c83(var0) {
  thread playerrespawn();
  return true;
}

function ref_125f7(var0, var1) {
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

function distort_fx(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(level.waitandpause) {
    if(isDefined(var1.waitandpause) && var1.waitandpause == 1) {
      var3 *= level.waitandspawnprops;
    }

    if(isDefined(var2) && isDefined(var2.wait_until_player_is_near) && var2.wait_until_player_is_near == 1) {
      switch (var4) {
        case "MOD_EXPLOSIVE":
        case "MOD_GRENADE_SPLASH":
        case "MOD_GRENADE":
        case "MOD_PROJECTILE_SPLASH":
          var3 *= level.waitandgetnewspawnpoint;
          break;
      }
    }
  }

  var3 = scripts\mp\gametypes\br::brmodifyplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
  return var3;
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

  var0 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

  if(!istrue(self.ref_13749) || var0 == 1) {
    var1 = 1;
    wait var1;
  }

  var2 = level.checkpoint_objective_id;
  var3 = getdvarfloat("scr_bmo_respawn_predict_hint_time", 5);

  if(var2 < var3) {
    var2 = var3;
  }

  if(level.ref_12cb4 != 0) {
    var2 = 0;
  }

  var4 = getdvarfloat("scr_bmo_squad_wiped_stream_time", 3);
  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;

  if(istrue(self.ref_13749) || var0 == 1) {
    var5 = display_wave_num();
    var6 = scripts\mp\gametypes\br_gulag::ref_1263e(var5);
    thread patchfix(0, var0 > 1);
    wait var4;
  } else if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var2 * 1000));
    var7 = var2 - var3;
    var8 = var2 - var7;
    var9 = var2 - getdvarfloat("scr_bmo_respawn_intermission_time", 6);
    thread patchfix(var9);
    var10 = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", var7);

    if(var10 == "squad_wipe_death") {
      var5 = display_wave_num();
      var6 = scripts\mp\gametypes\br_gulag::ref_1263e(var5);
      thread patchfix(0, 1);
      wait var4;
    } else {
      thread ref_1400c();
      var10 = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", var8);

      if(var10 == "squad_wipe_death") {
        var5 = display_wave_num();
        var6 = scripts\mp\gametypes\br_gulag::ref_1263e(var5);
        thread patchfix(0, 1);
        wait var4;
      }
    }
  }

  self notify("stop_updatePrestreamRespawn");
  var5 = display_wave_num();
  var6 = scripts\mp\gametypes\br_gulag::ref_1263e(var5);

  if(istrue(self.ref_13749)) {
    self.ref_13749 = 0;

    if(var0 > 1 && !scripts\mp\gametypes\br_public::uniquelootitemid()) {
      scripts\mp\hud_message::showsplash("bm_your_squad_wiped");
    }
  }

  if(!displaysplashtoplayersinradius(var5.origin)) {
    var11 = display_timer(0, 0.7);
    var5.origin = (var11[0], var11[1], var5.origin[2]);
  }

  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();

  if(scripts\mp\gametypes\br_public::uniquelootitemid() && isDefined(level.ref_124e7)) {
    var5 = scripts\engine\utility::getStruct(level.ref_124e7, "targetname");
  }

  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var5, 1, var6, 1);
  scripts\mp\gametypes\br::ref_13f21(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "player_respawn");
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);

  if(level.waitandpause) {
    thread distance_weight();
    thread dist_to_line_seg();
    thread dist_to_line();
  }

  self setclientomnvar("ui_ctf_flag_carrier", 0);

  foreach(var13 in level.ref_11a32) {
    if(var13 == self) {
      carriabletype();
      break;
    }
  }
}

function display_wave_num() {
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  var3 = 1;

  if(isDefined(self.setspawnpoint)) {
    var0 = self.setspawnpoint.playerspawnpos;
    var1 = self.setspawnpoint.playerspawnangles;
  }

  var4 = getdvarfloat("scr_kingslayer_respawnMinRadiusPercent", 0.8);
  var5 = getdvarfloat("scr_kingslayer_respawnMaxRadiusPercent", 0.9);
  var6 = getdvarfloat("scr_kingslayer_respawnRandomArea", 100);

  if(!isDefined(var0) && var6 >= 0) {
    var7 = scripts\mp\gametypes\br_gulag::ref_12568();

    if(isDefined(var7)) {
      var8 = display_ready_for_sequence();
      var9 = scripts\mp\gametypes\br_circle::getsafecircleradius();
      var10 = vectorNormalize(var7.origin - var8) * var9 * var4 + var8;
      var0 = scripts\mp\gametypes\br_circle::getrandompointincircle(var10, var6, var4, var5);

      if(isDefined(var0)) {
        var0 = scripts\mp\gametypes\br_public::modifyplayer_damage(var0);
        var1 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var0, var7.origin);
      }
    }
  }

  if(!isDefined(var0)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      var11 = display_ready_for_sequence();
      var12 = scripts\mp\gametypes\br_circle::getsafecircleradius();
      var13 = getdvarint("scr_br_maxRespawnDropToGround", 1);
      var14 = getdvarint("scr_br_maxRespawnSnapToNavMesh", 1);
      var0 = scripts\mp\gametypes\br_circle::getrandompointincircle(var11, var12, var4, var5);
      var1 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var0, var11);
    } else if(isDefined(level.prematchspawnorigins)) {
      if(isDefined(level.teamdata[self.team]["chosenSpawnWipeOrigin"]) && isDefined(level.teamdata[self.team]["spawnWipeOriginUseStartTime"]) && isDefined(level.checkpoint_objective_id) && level.teamdata[self.team]["spawnWipeOriginUseStartTime"] + level.checkpoint_objective_id * 1000 > gettime()) {
        var0 = level.teamdata[self.team]["chosenSpawnWipeOrigin"];
      } else {
        var15 = [];

        foreach(var17 in level.prematchspawnorigins) {
          if(distance2dsquared(var17.origin, self.origin) > var6) {
            var15 = var17;
          }
        }

        if(var15.size == 0) {
          var15 = level.prematchspawnorigins;
        }

        var15 = scripts\engine\utility::array_randomize(var15);
        var0 = var15[0].origin;
        var0 += scripts\engine\math::random_vector_2d() * randomfloatrange(100, 500);
        level.teamdata[self.team]["chosenSpawnWipeOrigin"] = var0;
        level.teamdata[self.team]["spawnWipeOriginUseStartTime"] = gettime();
      }

      var1 = (0, 0, 0);

      if(var0[2] > 10000) {
        var3 = 0;
        var2 = scripts\mp\gametypes\br_public::getinfilspawnoffset();
      }
    } else {
      var0 = (0, 0, 0);
      var1 = (0, 0, 0);
    }
  }

  if(!isDefined(var1)) {
    var19 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var20 = vectortoyaw(var19 - var0);
    var1 = (0, var20, 0);
  }

  if(var3) {
    if(!isDefined(var2)) {
      var2 = scripts\cp_mp\parachute::getc130height();
    }

    if(isDefined(level.br_circle)) {
      var21 = level.br_circle.circleindex;
      var22 = scripts\mp\gametypes\br_gulag::remove_engineer_class();
      var23 = isDefined(var21) && var21 >= var22;

      if(var23) {
        var2 *= getdvarfloat("scr_br_gulagClosedSpawnOffsetScaler", 0.55);
      }
    }

    if(isDefined(level.ref_12ca7)) {
      var2 = level.ref_12ca7;
    }

    var24 = (0, 0, var2);
    var0 = scripts\mp\gametypes\br::getoffsetspawnorigin(var0, var24);
  }

  var25 = spawnStruct();
  var25.origin = var0;
  var25.angles = var1;
  var25.height = var2;
  return var25;
}

function patchfix(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(var0) && var0 > 0) {
    wait var0;
  }

  var2 = 1;
  thread fadeoutin();
  wait var2 - 0.25;

  if(getdvarint("scr_kingslayer_tacMapCenterAndZoom", 1) == 1) {
    scripts\mp\gametypes\br::ending_fade_in();
  }

  if(istrue(var1)) {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 6);
  } else {
    _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 2);
  }

  wait 0.25;

  if(getdvarint("scr_bmo_use_spawn_intermission_fix", 1) == 1) {
    scripts\mp\gametypes\br_public::ref_1252b();
    var3 = display_wave_num();
    scripts\mp\gametypes\br_spectate::ref_1252a();
    scripts\mp\gametypes\br::spawnintermission(var3.origin, var3.angles);
    scripts\mp\spectating::setdisabled();
    self.trial_moving_target_think = var3.origin;
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

function ref_1400c() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      var0 = display_wave_num();
      var1 = gettime();

      if(var1 - self.trial_other_team >= getdvarfloat("scr_bmo_spawn_fallback_hint_delay", 2) * 1000) {
        var0 = display_wave_num();
        var2 = scripts\mp\gametypes\br_gulag::ref_1263e(var0);
      }
    } else {
      var0 = display_wave_num();
      var2 = scripts\mp\gametypes\br_gulag::ref_1263e(var0);
    }

    wait 1;
  }
}

function display_ping_hint_with_radial_check() {
  var0 = getdvarint("scr_kingslayer_first_point_distance", 30000);
  level.br_level.default_class_chosen[0] = scripts\mp\gametypes\br_circle::getrandompointincircle(level.br_level.default_class_chosen[0], var0);

  if(istrue(level.wait_to_stop_path_vehicle)) {
    distsqtodefenderflagstart(0);
  } else {
    level.br_level.default_class_chosen[1] = level.br_level.default_class_chosen[0];
  }

  var1 = (level.br_level.default_class_chosen[0][0], level.br_level.default_class_chosen[0][1], 0);
  var2 = level.br_level.br_circleradii[0];
  var3 = scripts\mp\gametypes\br_c130::createtestc130path(var1, var2);
  return var3;
}

function display_message_to_teammates() {
  thread displaysquadmessagetoplayer();
}

function displaysquadmessagetoplayer() {
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

function dist_sq_to_ref() {
  level endon("game_ended");

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  level waittill("br_prematchEnded");
  wait 20;
  thread ref_1383f();
}

function ref_1383f() {
  level endon("game_ended");

  for(;;) {
    for(var0 = 0; var0 < level.wait_till_time; var0++) {
      var1 = display_timer(0, 0.6);
      var2 = spawnStruct();
      var2.origin = var1;
      var2.clear_legacy_pickup_munitions = spawn("script_model", var2.origin);
      var2.clear_legacy_pickup_munitions setModel("ks_airdrop_crate_br");
      thread mlgiconfullflag(level, var2);
    }

    wait level.wait_to_advance + level.wait_to_reset_wave_loadout;
  }
}

function mlgiconfullflag(var0, var1) {
  level endon("game_ended");

  if(!isDefined(var0.modify_blast_shield_damage)) {
    var0.modify_blast_shield_damage = level.wait_unload_chopper;
  }

  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    var2 = scripts\mp\gametypes\br_circle::getrandompointincircle(var0.origin, var0.modify_blast_shield_damage);
  } else {
    var2 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var1.origin, var1.modify_blast_shield_damage);
  }

  if(istrue(level.ref_1406f)) {
    var2 = scripts\mp\gametypes\br_rewards::return_enemy_type_mask(var2);
  }

  var3 = scripts\mp\gametypes\br_c130airdrop::fn_spec_op_post_customization(undefined, var2, 1);
  var4 = distance(var3.startpt, var3.endpt);
  var5 = scripts\mp\gametypes\br_c130::getc130speed();
  var6 = var4 / var5;
  var7 = scripts\mp\gametypes\br_c130airdrop::fntrapdeactivation(var3, var4, var5, var6);
  var7.mode_can_play_ending = &mode_can_play_ending;
  var7.ref_134e2 = var2;
  var7 scripts\mp\gametypes\br_c130airdrop::fob(1, "battle_royale_c130_loot", "kingslayer_world", var1);
}

function mode_can_play_ending(var0, var1, var2, var3) {
  var4 = self.startpt;
  var5 = self.centerpt;
  var6 = self.speed;
  var7 = distance2d(var4, var5) / var6;
  var8 = 0;
  var9 = 0;
  level.ref_11f2c += var0;

  while(var8 < var0) {
    wait var7;
    var10 = scripts\mp\gametypes\br_c130airdrop::fnchildscorefunc(self.origin, 1);
    var11 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var10 + (0, 0, level.fnhidefoundintel - 100), var10, self.angles, var1, var2, var3.ref_11eab);
    var8++;
    var11.ml_p2_func = var3;
    var11.ref_134e2 = self.ref_134e2;
    level.focus_fire_attacker_timeout[level.focus_fire_attacker_timeout.size] = var11;
    var12 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var11);
    var12.ref_140a0 = relic_laststand_modifyplayerdamage();
  }
}

function divide_living_ai(var0) {
  var1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var2 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var1, self.origin, self.angles, self);
  scripts\mp\gametypes\br_pickups::spawnpickup("brloot_killstreak_uav", var2);
  var2 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var1, self.origin, self.angles, self);
  scripts\mp\gametypes\br_pickups::spawnpickup("brloot_killstreak_clusterstrike", var2);
  var2 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var1, self.origin, self.angles, self);
  scripts\mp\gametypes\br_pickups::spawnpickup("brloot_killstreak_precision_airstrike", var2);

  if(!isDefined(var0.ref_11a01)) {
    var0.ref_11a01 = 1;
  } else {
    var0.ref_11a01++;
  }

  var0 scripts\mp\utility\stats::setextrascore1(var0.ref_11a01);
  var0 thread scripts\mp\utility\points::giveunifiedpoints("br_c130_box_open");
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
    var0 = [];
    var1 = [];
    var2 = [];
    var3 = [];

    for(var4 = 0; var4 < level.wait_to_close_in; var4++) {
      var0 = level.wait_unload_chopper;
      var1 = level.wait_to_advance;
      var2 = level.wait_to_reset_wave_loadout;
      var3 = level.wait_to_spawn_ambush_vehicle;
    }

    scripts\mp\gametypes\br_circle::open_teleport_room_door(var0, var1, var2, var3);
    return;
  }

  level.br_level.ref_13884 = 1;
}

function ref_14365() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  thread dmzextractcost();
}

function dlog_analytics_init(var0) {
  var0.ref_12306 = 0;
  var0.wagingplayer = 0;
  var0.vstartposition = 0;
}

function dmg_trig(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  scripts\mp\gametypes\br::onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

  if(level.wait_unload_jeep) {
    self.wait_unload_chopper_flood_players = 1;
  }

  lbravo_hover_rider_death_monitor();

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  if(isDefined(var1) && isPlayer(self)) {
    display_welcome(var1, self);
    return;
  }
}

function display_welcome(var0, var1) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(var0 != var1 && isDefined(var0.team)) {
    var2 = var0.team;
    var3 = 1;
    var4 = 1;

    if(level.wait_until_truck_arrives_at_station) {
      foreach(var6 in level.ref_11a32) {
        if(!isDefined(var6)) {
          continue;
        }

        if(var6.team == var2) {
          var4 = 0;
          break;
        }
      }
    }

    if(level.wait_until_impact == 0 && !scripts\mp\flags::gameflag("placement_updates_allowed")) {
      var4 = 0;
    }

    if(var4 == 1) {
      foreach(var6 in level.ref_11a32) {
        if(!isDefined(var6)) {
          continue;
        }

        var9 = scripts\engine\utility::ter_op(level.wait_until_trap_room_clear, var6.team == var1.team, var6 == var1);

        if(var9) {
          var3 = level.wait_use_respawn;
          var0.wagingplayer++;
          ref_121b6(var0);
          var1.vstartposition++;
          ref_121b6(var1);
          var10 = isDefined(var0.streakdata.streaks[1]);
          var11 = display_relics_splash(var0);
          var0 scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar(var11, var10, 1);
          var0 thread scripts\mp\hud_message::showsplash("kingslayer_" + var11);
          var0 thread scripts\mp\rank::scoreeventpopup("hvt_kill");
          var0 thread scripts\mp\rank::scoreeventpopup("teamscore_notify_" + var3);
          break;
        }
      }
    }

    if(isDefined(level.teamdata[var2])) {
      level.teamdata[var2]["teamTotalScore"] = level.teamdata[var2]["teamTotalScore"] + var3;
      var0.ref_12306 += var3;

      if(level.wait_until_emp_drone_done > 0) {
        if(level.teamdata[var2]["teamTotalScore"] >= level.wait_until_emp_drone_done) {
          level notify("brKing_startPlacements");
          return;
        }

        return;
      }

      return;
    }

    scripts\mp\utility\script::laststand_dogtags("team " + var2 + " is not in level.teamData");
    return;
  }
}

function ref_121b6(var0) {
  var1 = self.wagingplayer;

  if(var1 > 255) {
    var1 = 255;
  }

  var2 = self.vstartposition;

  if(var2 > 255) {
    var2 = 255;
  }

  var1 += var2 << 8;
  scripts\mp\utility\stats::setextrascore0(var1);
}

function ref_121b4() {
  var0 = self.wagingplayer;

  if(var0 > 255) {
    var0 = 255;
  }

  var1 = self.vstartposition;

  if(var1 > 255) {
    var1 = 255;
  }

  var0 += var1 << 8;
  return var0;
}

function numextractions() {
  level waittill("give_match_bonus");
  waitframe();
  var0 = getdvarfloat("scr_bmo_eom_held_cash_scalar", 1);
  var1 = getdvarfloat("scr_bmo_eom_banked_cash_scalar", 1);
  var2 = getdvarint("scr_bmo_eom_initial_winner_bonus", 3000);
  var3 = getdvarint("scr_bmo_eom_over_wincost_bonus", 2250);
  var4 = getdvarint("scr_bmo_eom_top10_bonus", 1500);

  foreach(var6 in level.teamnamelist) {
    var7 = 0;
    var8 = 0;
    var9 = game["teamPlacements"][var6];
    var10 = 0;

    if(var8) {
      var10 = var3;
    } else if(var9 <= 10) {
      var10 = var4;
    } else {
      var10 = 750;
    }

    var11 = scripts\mp\utility\teams::getteamdata(var6, "players");

    foreach(var13 in var11) {
      var13 scripts\mp\gametypes\br::ref_138d6();
      var13 scripts\cp_mp\utility\game_utility::ref_13168(var9);

      if(!var13 scripts\mp\utility\game::rankingenabled() || !var13 hasplayerdata()) {
        continue;
      }

      var13 scripts\mp\utility\stats::incpersstat("cash", int(var7 / 10000));
      var14 = var13.pers["combatXP"];

      if(!isDefined(var14)) {
        var14 = 0;
      }

      var13 setplayerdata("mp", "aarValue", 0, var14);
      var15 = var13.pers["missionXP"];

      if(!isDefined(var15)) {
        var15 = 0;
      }

      var13 setplayerdata("mp", "aarValue", 1, var15);
      var16 = var13.pers["lootingXP"];

      if(!isDefined(var16)) {
        var16 = 0;
      }

      var13 setplayerdata("mp", "aarValue", 2, var16);
      var17 = 0;

      if(isDefined(var13.plundercount)) {
        var17 = int(var13.plundercount * var0);
      }

      var18 = 0;

      if(isDefined(var13.plunderbanked)) {
        var18 = int(var13.plunderbanked * var1);
      }

      var19 = var17 + var18;

      if(var19 > 0) {
        var13 scripts\mp\rank::giverankxp("cash_conversion_bonus", var19, undefined, 1, 1);
      }

      var13 setplayerdata("mp", "aarValue", 3, 0);
      var20 = 0;

      if(isDefined(var13.matchbonus)) {
        var20 = int(var13.matchbonus);
      }

      var13 setplayerdata("mp", "aarValue", 4, var20);

      if(var10 > 0) {
        var13 scripts\mp\rank::giverankxp("placement_bonus", var10, undefined, 1, 1);
      }

      var13 setplayerdata("mp", "aarValue", 5, var10);
      var21 = var13 getplayerdata("mp", "aarValue", 6);
      var22 = var21 + var13.pers["summary"]["xp"];
      var13 setplayerdata("mp", "aarValue", 7, var22);
    }
  }
}

function dmzlootleaderupdateonpickup(var0, var1, var2) {
  var3 = int(game["teamScores"][var1]);
  var4 = var0 - var3;

  if(var4 != 0) {
    var5 = scripts\engine\utility::ter_op(scripts\mp\gametypes\br_public::uniquelootitemid(), 1, undefined);
    level thread scripts\mp\gamescore::giveteamscoreforobjective(var1, var4, 0, undefined, var5, var2);
  }

  return var4;
}

function distsqtodefenderfalgstart(var0) {
  scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, var0);
}

function dmzextractcost() {
  level endon("game_ended");
  var0 = 0;
  var1 = [];
  var2 = level.spawn_convoy_and_move != 0;
  var3 = 0;

  for(;;) {
    waittillframeend();
    var4 = level.fuckwithgravity && level.fuel_stability_event_init && level.fuel_stability_event_start;
    var5 = level.waitandapplybrweaponxp;
    var0 += level.framedurationseconds;

    if(istrue(level.ref_14086)) {
      var6 = scripts\mp\flags::gameflag("placement_updates_allowed");
    } else {
      var6 = var0 > level.ref_12fb3;
    }

    var7 = level.ref_13366 && var6;
    var8 = scripts\mp\gamescore::run_common_functions_stealth();
    var9 = level.ref_13abd;
    var10 = undefined;
    var11 = undefined;
    var12 = undefined;
    var13 = [];
    var14 = [];
    var15 = [];
    var16 = "none";
    var17 = "none";
    var18 = -1;
    var19 = 0;

    foreach(var21 in level.teamnamelist) {
      var22 = level.teamdata[var21]["teamTotalScore"];
      var23 = dmzlootleaderupdateonpickup(var22, var21, level.disable_super_in_turret.player_enemy_cooldown);
      var24 = revive_or_disconnect_monitor(var21);
      var25 = var8[var21];

      if(var22 > var18) {
        if(var18 > var19) {
          var19 = var18;
          var17 = var16;
        }

        var18 = var22;
        var16 = var21;
      } else if(var16 != "none") {
        if(var22 > var19) {
          var19 = var22;
          var17 = var21;
        }
      }

      var26 = var22;
      var27 = var22;
      var28 = 0;

      if(var27 >= var5 * 0.9) {
        var10 = var21;
      } else if(var27 >= var5 * 0.75) {
        var11 = var21;
      } else if(var27 >= var5 * 0.5) {
        var12 = var21;
      }

      if(var27 >= var5 * level.ref_127c1) {
        thread scripts\mp\music_and_dialog::ref_12791();
      } else if(var27 >= var5 * level.ref_127c3) {
        thread scripts\mp\music_and_dialog::ref_127a7();
      } else if(var27 >= var5 * level.ref_127c2) {
        thread scripts\mp\music_and_dialog::ref_1278b();
      } else if(var27 >= var5 * level.ref_127c0) {
        thread scripts\mp\music_and_dialog::ref_127a9();
      }

      var29 = scripts\mp\utility\teams::getfriendlyplayers(var21, 0);
      ref_14004(var8, var29);

      foreach(var31 in var29) {
        var14 = var31.ref_12306;
        var15 = var31;
      }

      if(var7) {
        if(var25 == 1) {
          var13 = var21;
        } else if(var25 <= 5) {
          if(var24 > 5) {
            showsplashtoteam(var21, "bm_top_5");
          }
        } else if(var25 <= 10) {
          if(var24 > 10) {
            showsplashtoteam(var21, "bm_top_10");
          }
        }
      }

      if(var27 >= var5) {
        thread searchradiusidealmin(level);
      }
    }

    foreach(var31 in level.players) {
      var35 = level.teamdata[var31.team]["teamTotalScore"];
      var31 setclientomnvar("ui_br_team_cash_banked", int(var35));
      var31 setclientomnvar("ui_br_team_cash_pockets", int(scripts\engine\utility::ter_op(var35 >= var18, var19, var18)));
    }

    var37 = [];
    var38 = [];

    if(level.ref_11a2c == 1) {
      var37 = setteamplacement(game["teamPlacements"], "up");
    } else if(level.ref_11a2c == 2) {
      var37 = var16;
      var38 = setteamplacement(var14, "down");
    } else {
      var38 = setteamplacement(var14, "down");
    }

    level.disable_super_in_turret.player_enemy_cooldown = var16;

    if(var16 == "none") {
      var1 = [];
      waitframe();
      continue;
    }

    if(!var2 && var18 >= var5 * level.spawn_convoy_and_move * 0.1) {
      setomnvar("ui_br_leader_hash_percentage_hit", 1);
      var2 = 1;
    }

    if(!var7 || var18 == 0) {
      waitframe();
      continue;
    }

    if(level.ref_11a2c > 0) {
      if(level.lootchopper_modifyweapondamage || istrue(level.ref_127d2)) {
        ref_13ff0(var14, var38, var15, var37);
        level.ref_127d2 = 0;
      }
    } else if(level.lootchopper_modifyweapondamage || istrue(level.ref_127d2)) {
      ref_13ff0(var14, var38, var15);
      level.ref_127d2 = 0;
    }

    foreach(var21 in var13) {
      if(!scripts\engine\utility::array_contains(var1, var21)) {
        if(istrue(level.ref_13be1[var21])) {
          if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
            showsplashtoteam(var21, "bm_top_team_regained");
          }

          continue;
        }

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          showsplashtoteam(var21, "bm_top_team");
        }

        level.ref_13be1[var21] = 1;
      }
    }

    if(var13.size > 0) {
      foreach(var21 in var1) {
        if(!scripts\engine\utility::array_contains(var13, var21)) {
          showsplashtoteam(var21, "bm_top_team_lost");
        }
      }
    }

    var1 = var13;
    level.ref_13be0 = var16;
    level.ref_12884 = var8;

    if(!var4) {
      if(!level.fuel_stability_event_start && isDefined(var10)) {
        level.fuel_stability_event_start = 1;

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            ref_13372(var10, "bm_first_to_90_them");
            showsplashtoteam(var10, "bm_first_to_90_us");
            level thread scripts\mp\gametypes\br_public::brleaderdialog("final_circle", 0, undefined, undefined, 2);
          }
        }
      } else if(!level.fuel_stability_event_init && isDefined(var11)) {
        level.fuel_stability_event_init = 1;

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            ref_13372(var11, "bm_first_to_75_them");
            showsplashtoteam(var11, "bm_first_to_75_us");
          }
        }
      } else if(!level.fuckwithgravity && isDefined(var12)) {
        level.fuckwithgravity = 1;

        if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            ref_13372(var12, "bm_first_to_50_them");
            showsplashtoteam(var12, "bm_first_to_50_us");
          }
        }
      }
    }

    waitframe();
  }
}

function ref_14004(var0, var1) {
  foreach(var3 in var1) {
    if(!isDefined(var3)) {
      continue;
    }

    var4 = var0[var3.team];
    var3 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_placement", var4);
    var3 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_player_position", var4);
  }
}

function revive_or_disconnect_monitor(var0) {
  if(isDefined(level.ref_12884)) {
    return level.ref_12884[var0];
  }

  return -1;
}

function ref_13371(var0) {
  foreach(var2 in level.players) {
    var2 scripts\mp\hud_message::showsplash(var0);
  }
}

function showsplashtoteam(var0, var1) {
  foreach(var3 in level.teamdata[var0]["players"]) {
    var3 scripts\mp\hud_message::showsplash(var1);
  }
}

function ref_13372(var0, var1) {
  foreach(var3 in level.players) {
    if(isDefined(var3) && var3.team != var0) {
      var3 scripts\mp\hud_message::showsplash(var1);
    }
  }
}

function setobjectivecallbacks(var0, var1) {
  var2 = int(min(var1, 131072));
  self setclientomnvar(var0, var2);
}

function setoutputfunc(var0, var1) {
  var2 = int(min(var1, 131072));
  setomnvar(var0, var2);
}

function ref_13ff0(var0, var1, var2, var3) {
  level.ref_11a36 = level.ref_11a32;
  level.ref_11a32 = [];

  if(level.ref_11a2c == 1) {
    for(var4 = 0; var4 < level.ref_11a27; var4++) {
      var5 = removeplatepouch(var4, var0, var3);

      if(isDefined(var5)) {
        level.ref_11a32[level.ref_11a32.size] = var2[var5];
      }
    }
  } else {
    jumpiffalse(level.ref_11a2c == 2) LOC_00000106;
    var5 = removeplatepouch(0, var0, var3);

    if(isDefined(var5)) {
      level.ref_11a32[0] = var2[var5];
    }

    foreach(var7 in var1) {
      var8 = var2[var7];
      var9 = var0[var7];

      if(var9 == 0) {
        break;
      }

      if(var9 == level.ref_12d6f) {
        continue;
      }

      if(scripts\engine\utility::array_contains(level.ref_11a32, var8)) {
        continue;
      }

      level.ref_11a32[level.ref_11a32.size] = var8;

      if(level.ref_11a32.size == level.ref_11a27) {
        break;
      }
    }

    goto LOC_0000015f;
  }

  foreach(var8 in level.ref_11a36) {
    if(isDefined(var8) && !scripts\engine\utility::array_contains(level.ref_11a32, var8)) {
      ref_12c18(var8);
    }
  }

  level notify("update_loot_leaders");

  if(level.ref_11a29.size < level.ref_11a27) {
    for(var4 = 0; var4 < level.ref_11a27; var4++) {
      var15 = spawnStruct();
      var15.hidden = 0;
      var15 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active");
      level.ref_11a29[var4] = var15;
    }
  }

  for(var4 = 0; var4 < level.ref_11a27; var4++) {
    var15 = level.ref_11a29[var4];

    if(isDefined(level.ref_11a32[var4])) {
      var15.targetplayer = level.ref_11a32[var4];
      var15.targetplayer.ref_11a26 = var15;
      var16 = var15.targetplayer.origin;
      var17 = scripts\engine\utility::array_contains(level.ref_11a32, var15.targetplayer) && !scripts\engine\utility::array_contains(level.ref_11a36, var15.targetplayer);

      if(var15.hidden == 0) {
        var18 = scripts\mp\utility\teams::getenemyplayers(var15.targetplayer.team, 0);

        foreach(var8 in var18) {
          displaywelcome(var15, var8);
        }

        var21 = scripts\mp\utility\teams::getfriendlyplayers(var15.targetplayer.team, 0);

        foreach(var8 in var21) {
          displaysquadmessagetoteam(var15, var8);
        }
      }

      if(var17) {
        battle_tracks_updatebattletracks(var15);
      }

      continue;
    }

    var15.targetplayer = undefined;
    objective_removeallfrommask(var15.objectiveiconid);
  }
}

function dmzextractcostdecrease() {
  level endon("game_ended");
  level waittill("update_loot_leaders");

  for(;;) {
    for(var0 = 0; var0 < level.ref_11a27; var0++) {
      var1 = level.ref_11a29[var0];

      if(isDefined(var1.targetplayer)) {
        if(!scripts\mp\utility\player::isreallyalive(var1.targetplayer) && var1.hidden == 0) {
          var1.hidden = 1;
          objective_removeallfrommask(var1.objectiveiconid);
          level notify("Objective_Delete", var1.objectiveiconid);
        } else if(scripts\mp\utility\player::isreallyalive(var1.targetplayer) && var1.hidden == 1) {
          if(!level.wait_unload_jeep || isDefined(var1.targetplayer.wait_unload_chopper_flood_players) && var1.targetplayer.wait_unload_chopper_flood_players == 0) {
            var1.hidden = 0;
            var2 = scripts\mp\utility\teams::getenemyplayers(var1.targetplayer.team, 0);

            foreach(var4 in var2) {
              displaywelcome(var1, var4);
            }
          }
        }

        distsqtodefenderfalgstart(var1, var1.targetplayer.origin);
        continue;
      }

      if(var1.hidden == 0) {
        var1.hidden = 1;
        objective_removeallfrommask(var1.objectiveiconid);
      }
    }

    if(level.ref_11a28 > 0) {
      wait level.ref_11a28;
      continue;
    }

    waitframe();
  }
}

function displaywelcome(var0) {
  scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
}

function displaysquadmessagetoteam(var0) {
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
}

function removeplatepouch(var0, var1, var2) {
  var3 = var2[var0];
  var4 = 0;
  var5 = 0;

  if(level.teamdata[var3]["players"].size == 0) {
    return undefined;
  }

  var6 = level.teamdata[var3]["players"][0].guid;

  foreach(var8 in level.teamdata[var3]["players"]) {
    var4 = var1[var8.guid];

    if(var4 > var5) {
      var5 = var4;
      var6 = var8.guid;
    }
  }

  return var6;
}

function battle_tracks_updatebattletracks(var0) {
  var1 = var0.targetplayer;

  if(scripts\mp\utility\player::isreallyalive(var1)) {
    carriabletype(var1);

    if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
      var1 scripts\mp\hud_message::showsplash("bm_player_marked");
      return;
    }

    return;
  }
}

function ref_13ff1() {
  level notify("restartLootLeaders");
  level endon("restartLootLeaders");
  level endon("game_ended");
  var0 = getdvarfloat("scr_dmz_loot_leader_update_interval", 15);
  var1 = getdvarfloat("scr_dmz_loot_leader_update_interval_blink", 5);
  var2 = getdvarint("scr_bmo_circle_pulse_start", 800);
  var3 = getdvarint("scr_bmo_circle_pulse_end", 200);
  var4 = var0 - var1;
  scripts\mp\flags::gameflagwait("placement_updates_allowed");

  for(;;) {
    level.ref_127d2 = 1;
    scripts\engine\utility::waittill_notify_or_timeout("bmo_overtime_start", var4);
  }
}

function ref_12397() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(isDefined(level.ref_12fb3)) {
    wait level.ref_12fb3;
  }

  if(level.wait_until_emp_drone_done > 0) {
    level waittill("brKing_startPlacements");
  }

  scripts\mp\flags::gameflagset("placement_updates_allowed");
}

function ref_12c18(var0) {
  lbravo_hover_rider_death_monitor(var0);

  if(isDefined(var0.ref_11a26)) {
    foreach(var2 in level.players) {
      displaysquadmessagetoteam(var0.ref_11a26, var2);
    }

    var4 = var0.ref_11a26.guard_spawners;
    var0.ref_11a26.targetplayer = undefined;
    var0.ref_11a26 = undefined;
  }

  level.ref_11a32 = scripts\engine\utility::array_remove(level.ref_11a32, var0);
}

function searchradiusidealmin(var0) {
  waitframe();
  ref_14004(scripts\mp\gamescore::run_common_functions_stealth(), level.players);

  if(istrue(level.ref_13dc0)) {
    return;
  }

  level.ref_13dc0 = 1;
  level thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["objective_completed"]);
  var1 = [];

  if(isDefined(var0) && var0 != "tie") {
    var1 = scripts\mp\utility\teams::getteamdata(var0, "players");
  }

  thread scripts\mp\music_and_dialog::ref_12789(var1);
}

function ononeleftevent(var0) {}

function ref_126a6() {
  if(!istrue(self.controlsfrozen)) {
    scripts\mp\utility\player::_freezecontrols(1, undefined, "spawnEndOfGame");
  }

  var0 = spawnStruct();
  var1 = self getspectatingplayer();

  if(!isDefined(var1)) {
    var1 = self;
  }

  var0.origin = var1.origin;
  var0.angles = var1.angles;

  if(!var1 isonground()) {
    var2 = scripts\engine\trace::create_default_contents(1);
    var0.origin = scripts\engine\utility::drop_to_ground(var0.origin, 0, -20000, undefined, var2);
  }

  var0.origin += (0, 0, 100);

  if(!isDefined(level.needs_antenna)) {
    level.needs_antenna = 1;
    thread ref_13db9();
  }

  return true;
}

function test_pipe_fire() {
  var0 = [];
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

function ref_13db9() {
  var0 = 0;

  foreach(var2 in level.players) {
    thread ref_12753(var2, var2);
    var0++;

    if(var0 == 5) {
      waitframe();
      var0 = 0;
    }
  }
}

function registerquestcategorytablevalues(var0) {
  var1 = undefined;
  var2 = undefined;

  foreach(var4 in level.mp_m_trench_patch) {
    var5 = distance2dsquared(var0.origin, var4);

    if(var5 <= 9000000) {
      return var6;
    }

    if(!isDefined(var2) || var2 > var5) {
      var2 = var5;
      var1 = var6;
    }
  }

  return var1;
}

function ref_12753(var0, var1) {
  var2 = level.mp_m_trench_patch[var1];
  var3 = level.mp_m_speedball_patch[var1];
  var4 = var2 + anglestoright(var3) * 1000;
  var5 = var3;
  var6 = spawn("script_model", var2);
  var6 setModel("tag_origin");
  var6.angles = var3;
  var0 cameralinkTo(var6, "tag_origin");
  var6 moveTo(var4, 60);
  var6 rotateTo(var5, 60);
}

function dist_miles() {
  level endon("game_ended");
  thread dmzminextractcost();

  for(;;) {
    level waittill("br_circle_set");
    distsqtodefenderflagstart();
  }
}

function distsqtodefenderflagstart(var0) {
  if(!isDefined(var0)) {
    var0 = level.br_circle.circleindex + 1;
  }

  if(level.br_level.default_class_chosen.size <= var0 || !istrue(level.wait_to_stop_path_vehicle)) {
    return;
  }

  var1 = level.br_level.default_class_chosen[var0];
  var2 = level.wait_to_spawn_r0;
  var3 = level.ref_11a32.size > 0;
  jumpiffalse(var3) LOC_00000081;
  var4 = level.ref_11a32[0].origin;
  var5 = scripts\engine\utility::ter_op(level.wait_to_start_exfil_obj, var1 - var4, var4 - var1);
  goto LOC_000000a2;
}

function displaysplashtoplayers(var0) {
  var1 = level.br_level.br_mapbounds;
  var2 = level.wait_to_stop_pre_tmtyl_spawners;
  var3 = var0[0] < var1[0][0] * var2 && var0[0] > var1[1][0] * var2 && var0[1] < var1[0][1] * var2 && var0[1] > var1[1][1] * var2;
  return var3;
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
  var0 = display_reinforcement_called_icon();

  if(level.br_circle.circleindex < 0) {
    return level.br_level.default_class_chosen[0];
  }

  if(var0 > 1) {
    return level.br_level.default_class_chosen[level.br_circle.circleindex];
  }

  var1 = level.br_level.default_class_chosen[level.br_circle.circleindex + 1];
  var2 = level.br_level.default_class_chosen[level.br_circle.circleindex];
  return vectorlerp(var2, var1, display_reinforcement_called_icon());
}

function displaysplashtoplayersinradius(var0) {
  var1 = display_ready_for_sequence();
  var2 = distance2d(var0, var1);
  return var2 < level.wait_unload_chopper;
}

function display_timer(var0, var1) {
  var2 = display_ready_for_sequence();
  return scripts\mp\gametypes\br_circle::getrandompointincircle(var2, level.wait_unload_chopper, var0, var1);
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