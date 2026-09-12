/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_olaride.gsc
********************************************************/

function brolaride_initanims() {}

function brolaride_loadfx() {
  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._effect["olarideInfil_bomb"] = loadfx("vfx/iw8_br/island/cin/exfil_s5/vfx_br3_infil_bomb_sml_runner.vfx");
  level._effect["vfx_br3_olaride_ashes_visionset"] = loadfx("vfx/iw8_br/island/gameplay/vfx_br3_olaride_ashes_visionset.vfx");
}

function init() {
  level.decoyassists = &groundz;
  level.ref_13364 = 1;
  thread brolaride_initfeatures();
  thread brolaride_initpostmain();
  thread brolaride_initdialog();
  thread brolaride_initexternalfeatures();
  level.disable_super_in_turret.br_mindistbetweenbombsite = getdvarint("scr_br_olaride_bomb_site_min_distance_to_bomb_site", 2300);
  var_0 = getdvarint("scr_br_resurgence_never_ending", 1);
  level thread scripts\mp\gametypes\br_gametype_rebirth::enabledskiplaststand(var_0);
  level thread scripts\mp\gametypes\br_gametype_rebirth::enable_traversals_for_bombers();
  thread brolaride_initanims();
  thread brolaride_updateflagonleadersquads();
  brolaride_initbombsites(level);
  scripts\mp\gametypes\br_gametypes::ref_12B11("dangerCircleTick", &brolaride_dangercircletick);
  scripts\mp\gametypes\br_gametypes::ref_12B11("mapCenterFinalCircle", &getfinalcircle);
  scripts\mp\gametypes\br_gametypes::ref_12B11("getFinalCircleCenter", &getfinalcircle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "onPing", &brolaride_onping);
  level.stage = 1;
  level.bombsite_objectiveitem_amount = getdvarint("scr_br_olaride_objective_item_reward", 1);
}

function groundz() {
  ref_12FDC();
  thread bindingpc();
  level.br_level.br_circledelaytimes = [80, 420, 300, 60, 0];
  level.br_level.br_circleclosetimes = [180, 60, 60, 30, 10];
  level.br_level.br_circleradii = [75000, 45000, 30000, 20000, 7000, 0];
  level.br_level.br_circleminimapradii = [9000, 9000, 6500, 4000, 2000];
  level.br_level.default_player_connect_black_screen = [45, 0, 0, 0, 0];
  level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0];
}

function ref_12FDC() {
  if(level.mapname == "mp_br_mechanics") {
    level.grouptorewards = (626, -2400, 20);
    return;
  }

  level.grouptorewards = scripts\mp\gametypes\br_circle::getrandompointincircle(getdvarvector("scr_br_olaride_volcano_origin", (8387, 15066, 8191)), 13000, 0, 1, 0, 0);
}

function getfinalcircle() {
  return level.grouptorewards;
}

function bindingpc() {
  level endon("game_ended");
  level waittill("calc_circle_centers");
  var_0 = level.grouptorewards;

  for(var_1 = 0; var_1 < level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective; var_1++) {
    level.br_level.default_class_chosen[var_1] = var_0;
  }
}

function brolaride_initfeatures() {
  level endon("game_ended");

  if(getdvarint("scr_br_olaride_debug", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
    return;
  }
}

function brolaride_initpostmain() {
  level endon("game_ended");
  brolaride_loadfx();
  brolaride_initaudio();
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("dropBagLoop");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("firstCircleVo");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("playerCountLandmarks");
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerWelcomeSplashes", &brolaride_playerintrodialogs);
  scripts\mp\gametypes\br_gametypes::ref_12B11("canTakePickupLoot", &brolaride_cantakepickuploot);
  scripts\mp\gametypes\br_gametypes::ref_12B11("skipPickupFeedback", &brolaride_skippickupfeedback);
  scripts\mp\gametypes\br_gametypes::ref_12B11("lootUsedGiveFeedback", &brolaride_lootusedgivefeedback);
  scripts\mp\gametypes\br_gametypes::ref_12B11("onUseCompleted", &brolaride_onusecompleted);
  scripts\mp\gametypes\br_gametypes::ref_12B11("endGame", &brolaride_endgame);
  scripts\mp\gametypes\br_gametypes::ref_12B11("preOnPlayerKilled", &brolaride_onplayerkilled);
  scripts\mp\gametypes\br_gametypes::ref_12B11("createC130PathStruct", &brolaride_createc130pathstruct);
  scripts\mp\gametypes\br_gametypes::ref_12B11("onInfilSequenceEnd", &brolaride_infilsequenceend);
  scripts\mp\gametypes\br_gametypes::ref_12B11("onPlayerConnect", &brolaride_onplayerconnect);
  scripts\mp\gametypes\br_gametypes::ref_12B11("giveStartingPlunder", &brolaride_givestartingplunder);
  waittillframeend();
  brolaride_cleanupents();
  level.ref_140D9 = [];
  level.ref_140D9[0] = "assassination";
  level.ref_140D9[1] = "domination";
  level.ref_140D9[2] = "scavenger";
  scripts\mp\rank::ref_12189("kill", 100);
  scripts\mp\rank::ref_12189("br_cacheOpen", 200);
  level.disable_super_in_turret.onspawn_slowspeed = getdvarint("scr_br_olaride_win_xp", 1500);
  thread brolaride_processlastcalltimer();
  thread bombsite_activatebombsites();
  thread brolaride_initmeter();
  level thread scripts\mp\gametypes\br_publicevent_fafir::postinitfunc();
  thread brolaride_initvisionsetprogression();
  thread brolaride_initcallbacks();
  level.disable_super_in_turret.heromatchpoints = [];
  level.disable_super_in_turret.villainmatchpoints = [];
  level.disable_super_in_turret.ref_13AB8 = [];
  level.disable_super_in_turret.startingloadoutindex = getdvarint("scr_br_rebirth_starting_loadout_index", 2);
  level.disable_super_in_turret.startingplunder = getdvarint("scr_br_olaride_starting_plunder", 10);
  level.disable_super_in_turret.victorypoints = getdvarint("scr_br_olaride_victory_points", 8);
  var_0 = getdvarfloat("scr_br_olaride_last_call_ratio", 0.8);
  level.disable_super_in_turret.lastcallpoints = int(floor(var_0 * level.disable_super_in_turret.victorypoints));
  level.disable_super_in_turret.lastcallpoints = int(clamp(level.disable_super_in_turret.lastcallpoints, 1, level.disable_super_in_turret.victorypoints));
  level.disable_super_in_turret.objectiveleadersmaxdistance = getdvarint("scr_br_olaride_bomb_site_max_leader_distance", 750);
  level.disable_super_in_turret.bombsiteteamdeathmaxdistance = getdvarint("scr_br_olaride_team_death_close_bomb_site_distance", 3200);
  level.disable_super_in_turret.teamdeathrespawnmaxradius = getdvarint("scr_br_olaride_team_death_respawn_radius", 20500);
  level.disable_super_in_turret.carryitemvoresettime = getdvarint("scr_br_olaride_carry_item_vo_reset_time", 30);
  level.disable_super_in_turret.objectiveleaders = [];
  level.objectiveleadersmarksize = getdvarint("scr_br_olaride_bombsite_leader_mark_size", 5000);
  var_1 = getdvarfloat("scr_br_olaride_bomb_site_leader_point_ratio", 0.6);
  level.disable_super_in_turret.currentmaxscore = int(floor(var_1 * level.disable_super_in_turret.victorypoints));
  level.disable_super_in_turret.objectiveleadersplashon = 0;
  level.disable_super_in_turret.islastcall = 0;
  level.disable_super_in_turret.islastcallambswitchdone = 0;
  level.disable_super_in_turret.freezetimerwhendefusing = getdvarint("scr_br_olaride_freeze_timer_when_defusing", 1) > 0;
  level.disable_super_in_turret.remainingtimetostartpulsating = getdvarint("scr_br_olaride_bomb_timer_start_pulsating", 10);
}

function brolaride_cleanupents() {
  scripts\cp_mp\utility\game_utility::ref_12C10("delete_on_load", "targetname");
}

function brolaride_initdialog() {
  level endon("game_ended");
  level waittill("br_dialog_initialized");
  waitframe();
  game["dialog"]["match_start"] = "gametype_desc_endgame";
  game["dialog"]["desc_air1"] = "end_infil_taunt";
  game["dialog"]["desc_ground"] = "gametype_desc_endgame_kits";
  game["dialog"]["team_victory"] = "end_match_win";
  game["dialog"]["volcano_anticipation"] = "public_event_volcano_announce";
  game["dialog"]["bomb_disarmed"] = "end_bomb_disarm";
  game["dialog"]["bomb_warning"] = "end_bomb_warning";
  game["dialog"]["bomb_negative"] = "end_generic_negative";
  game["dialog"]["bomb_exploded"] = "end_bomb_explosion";
  game["dialog"]["volcano_meter_1"] = "end_volcano_meter1";
  game["dialog"]["volcano_meter_2"] = "end_volcano_meter2";
  game["dialog"]["volcano_meter_3_hero"] = "end_volcano_heroes";
  game["dialog"]["volcano_meter_3_villain"] = "end_volcano_villains";
  game["dialog"]["last_call_leading_team_dialog"] = "end_overtime_winning";
  game["dialog"]["last_call_other_team_dialog"] = "end_overtime_enemy";
  game["dialog"]["hero_contribution_dialog"] = "end_generic_positive";
  game["dialog"]["villain_contribution_dialog"] = "end_generic_positive";
  game["dialog"]["hero_token_pickup_dialog"] = "end_generic_positive";
  game["dialog"]["villain_token_pickup_dialog"] = "end_generic_positive";
  game["dialog"]["defuse_kit_pickup_dialog"] = "gametype_desc_endgame_obj";
  game["dialog"]["bomb_pickup_dialog"] = "end_infil_objective";
}

function brolaride_initexternalfeatures() {
  level endon("game_ended");
}

function brolaride_initcallbacks() {
  while(!isDefined(level.onplayerspawncallbacks)) {
    waitframe();
  }

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&brolaride_onplayerspawned);
}

function brolaride_playerintrodialogs() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("desc_air1", self, 1, 0, undefined, undefined, "mndz");

    while(!self isonground()) {
      waitframe();
    }

    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("desc_ground", self);
  } else {
    level waittill("prematch_done");
  }

  scripts\mp\gametypes\br_analytics::detachriotshield(self);
}

function brolaride_infilsequenceend() {
  level endon("game_ended");
  waitframe();
  thread bombsite_infil_explode();
  level waittill("olaride_infil_explosion");
  thread brolaride_introbanner();
  thread brolaride_showscorewidget();
  wait 2;
  thread brolaride_volcanicactivity();
}

function brolaride_onplayerconnect(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  brolaride_givestartingplunder(var_0);
}

function brolaride_givestartingplunder() {
  scripts\mp\gametypes\br_plunder::playersetplundercount(self.plundercount + level.disable_super_in_turret.startingplunder);
}

function brolaride_introbanner() {
  level endon("game_ended");
  wait 4.5;
  ref_13371("br_olaride_introduction");
}

function brolaride_showscorewidget() {
  level endon("game_ended");
  wait getdvarfloat("scr_br_olaride_score_delay", 15);

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      var_1 _calloutmarkerping_handleluinotify_added::ref_1313E("ui_br_olaride_points", 30, 1, 1);
    }
  }
}

function brolaride_createc130pathstruct() {
  var_0 = scripts\mp\gametypes\br_circle::getrandompointincircle((8387, 15066, 8191), 4000);
  var_1 = scripts\mp\gametypes\br_c130::createtestc130path(var_0);
  return var_1;
}

function brolaride_getplayersaverageposition() {
  var_0 = scripts\engine\utility::array_removeundefined(level.players);
  return scripts\mp\gametypes\br_ending::get_center_of_array(var_0);
}

function brolaride_playteamdialog(var_0, var_1, var_2) {
  foreach(var_4 in level.teamnamelist) {
    if(var_4 == var_0) {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var_1, var_4, undefined, undefined, undefined, 1);
      continue;
    }

    level thread scripts\mp\gametypes\br_public::dmztut_luicallback(var_2, var_4, undefined, undefined, undefined, 1);
  }
}

function brolaride_cantakepickuploot(var_0) {
  if(var_0.scriptablename == "br_bombsite") {
    var_1 = var_0.tracknonoobplayerlocation getscriptablepartstate("br_bombsite");

    if(var_1 == "active") {
      if(istrue(self.carrybomb)) {
        return 2;
      } else {
        return 30;
      }
    } else {
      return 2;
    }
  } else if(var_0.scriptablename == "br_bomb") {
    if(istrue(self.carrybomb)) {
      return 29;
    } else {
      return 1;
    }
  } else if(var_0.scriptablename == "br_defusekit") {
    if(istrue(self.carrydefusekit)) {
      return 31;
    } else {
      return 1;
    }
  }

  return undefined;
}

function brolaride_skippickupfeedback(var_0, var_1, var_2, var_3) {
  if(var_0.scriptablename == "br_bombsite" && bombsite_instanceandplayermatch(var_0.tracknonoobplayerlocation, var_3)) {
    return 1;
  }

  return undefined;
}

function brolaride_lootusedgivefeedback(var_0, var_1, var_2) {
  switch (var_2) {
    case 29:
      var_1 scripts\mp\hud_message::showerrormessage("MP_BR_INGAME_TU_WZ350/BR_ALREADY_HAVE_BOMB");
      return 1;
    case 30:
      var_1 scripts\mp\hud_message::showerrormessage("MP_BR_INGAME_TU_WZ350/BR_NO_BOMB");
      return 1;
    case 31:
      var_1 scripts\mp\hud_message::showerrormessage("MP_BR_INGAME_TU_WZ350/BR_ALREADY_HAVE_DEFUSEKIT");
      return 1;
  }

  return undefined;
}

function brolaride_initbombsites() {
  var_0 = getentitylessscriptablearrayinradius("scriptable_br_bombsite", "classname");
  var_1 = brolaride_createscriptbombsites();
  level.disable_super_in_turret.br_bombsites = scripts\engine\utility::array_combine(var_0, var_1);
  level.disable_super_in_turret.br_activebombsites = [];
  level.disable_super_in_turret.br_usedsites = [];
  level.disable_super_in_turret.br_ingasbombsites = [];
  level.disable_super_in_turret.br_bombsites_points_rewards = [200, 300, 400, 500];
  level.disable_super_in_turret.bombsite_planttime = getdvarfloat("scr_br_olaride_bomb_plant_time", 5);
  level.disable_super_in_turret.bombsite_defusetime = getdvarfloat("scr_br_olaride_bomb_defuse_time", 12);
  level.disable_super_in_turret.bombsite_defusekittime = getdvarfloat("scr_br_olaride_bomb_defusekit_time", 6);
  level.disable_super_in_turret.bombsite_armedtimer = getdvarfloat("scr_br_olaride_bomb_timer", 70);
  level.disable_super_in_turret.bombsite_initialtimer = getdvarfloat("scr_br_olaride_bomb_timer_initial", 120);
  level.disable_super_in_turret.bombsite_lastcalltimer = getdvarfloat("scr_br_olaride_bomb_last_call_timer", 70);
  level.disable_super_in_turret.bombsite_spawningradius = getdvarint("scr_br_olaride_bomb_site_start_spawning_radius", 40000);
  level.disable_super_in_turret.bombsite_wantedcount = getdvarint("scr_br_olaride_bomb_site_start_count", 15);
  scripts\engine\scriptable::ref_12F5B("br_bombsite", &bombsite_used);
  scripts\engine\scriptable::ref_12F5B("br_bomb", &bomb_used);
  scripts\engine\scriptable::ref_12F5B("br_defusekit", &defusekit_used);
  level.disable_super_in_turret.br_bombs = [];
  level.disable_super_in_turret.br_defusekits = [];
}

function brolaride_updatebombsitespawningradius(var_0) {
  var_1 = getdvarint("scr_br_olaride_bomb_site_start_spawning_radius", 40000);
  var_2 = getdvarint("scr_br_olaride_bomb_site_end_spawning_radius", 20500);
  var_3 = 0;

  if(level.disable_super_in_turret.victorypoints > 1) {
    var_3 = min(var_0 / (level.disable_super_in_turret.victorypoints - 1), 1);
  }

  level.disable_super_in_turret.bombsite_spawningradius = scripts\engine\math::lerp(var_1, var_2, var_3);
}

function brolaride_updatebombsiteswantedcount(var_0) {
  var_1 = getdvarint("scr_br_olaride_bomb_site_start_count", 15);
  var_2 = getdvarint("scr_br_olaride_bomb_site_end_count", 7);
  var_3 = 0;

  if(level.disable_super_in_turret.victorypoints > 1) {
    var_3 = min(var_0 / (level.disable_super_in_turret.victorypoints - 1), 1);
  }

  level.disable_super_in_turret.bombsite_wantedcount = int(scripts\engine\math::lerp(var_1, var_2, var_3));
}

function brolaride_dangercircletick(var_0, var_1) {
  if(!isDefined(level.disable_super_in_turret.br_activebombsites)) {
    return;
  }

  var_2 = level.disable_super_in_turret.br_activebombsites;

  foreach(var_4 in var_2) {
    var_5 = var_4 getscriptablepartstate("br_bombsite");

    if(var_5 == "planted" || scripts\engine\utility::array_contains(level.disable_super_in_turret.br_ingasbombsites, var_4)) {
      continue;
    }

    if(!scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_4.origin)) {
      level.disable_super_in_turret.br_ingasbombsites[level.disable_super_in_turret.br_ingasbombsites.size] = var_4;
      thread bombsite_removefromgas();
    }
  }
}

function brolaride_createscriptbombsites() {
  var_0 = [];

  if(level.mapname == "mp_br_mechanics") {
    var_0 = [bombsite_spawnbombsite((676, -2550, 0), (0, 90, 0)), bombsite_spawnbombsite((676, -3550, 0), (0, 90, 0)), bombsite_spawnbombsite((676, -4550, 0), (0, 90, 0))];
  } else if(level.mapname == "mp_wz_island") {
    var_0 = brolaride_createislandbombsites();
  }

  return var_0;
}

function brolaride_createislandbombsites() {
  var_0 = [[(41134, -42352, 378), (0, 111, 0)], [(11323, 20305, 6730), (0, 35, 0)], [(21195, 10991, 4717), (0, 35, 0)], [(-11827, 4094, 650), (0, 336, 0)], [(26012, 8919, 2578), (0, 34, 0)], [(14633, 2385, 4677), (0, 191, 0)], [(12990, 8182, 6066), (0, 189, 0)], [(12131, 17276, 9312), (0, 292, 0)], [(11387, 13218, 8664), (0, 224, 0)], [(14883, 16474, 7345), (0, 48, 0)], [(28474, 20436, 2336), (0, 25, 0)], [(1997, 2816, 3353), (0, 356, 0)], [(18373, 12711, 6298), (0, 259, 0)], [(7562, 22065, 6298), (0, 9, 0)], [(20965, 10263, 4747), (0, 184, 0)], [(7119, -1167, 3819), (0, 95, 0)], [(21710, 6928, 3365), (0, 95, 0)], [(-4899, 4136, 1939), (0, 242, 0)], [(17286, 137, 4150), (0, 109, 0)], [(23197, 18391, 3729), (0, 87, 0)], [(2939, 27350, 2673), (0, 297, 0)], [(-10862, 36050, 1655), (0, 239, 0)], [(2112, 19559, 4290), (0, 295, 0)], [(18367, 21476, 4662), (0, 66, 0)], [(32779, 26680, 1612), (0, 345, 0)], [(27917, -3259, 3109), (0, 323, 0)], [(33609, 32246, 2936), (0, 181, 0)], [(-6478, 31695, 907), (0, 277, 0)], [(-1122, -2420, 2464), (0, 260, 0)], [(4716, 9291, 5465), (0, 159, 0)], [(5116, -1495, 3860), (0, 249, 0)], [(28612, 4652, 1344), (0, 27, 0)], [(4703, 35221, 1153), (0, 45, 0)], [(2256, 38714, 674), (0, 234, 0)], [(3180.5, 39797, 1199.25), (0, 45, 0)], [(-6212, 23907, 890), (357, 90, 0)], [(-2515.25, 9780.75, 3778.5), (0, 325, 0)], [(-10177.3, 18180.5, 2015.25), (0, 217, 0)], [(-28173.5, 4750.25, 3330), (0, 343, 0)], [(-27278, 10795, 2500), (0, 276, 0)], [(14780.3, 9528.89, 6795), (0, 39, 0)], [(3359.97, 11608, 5737), (0, 175.394, 0)], [(12474, 16238, 8679.5), (0, 271, 0)], [(9648.75, 12613.8, 7108), (0, 325, 0)], [(15496, -16547, 2873), (0, 292, 0)], [(2368, -8882, 1799), (0, 261, 0)], [(25799.5, -19550, 5257.5), (0, 2.5, 0)], [(15980.4, -5323.74, 3103.46), (0, 325, 0)], [(-5352, -9466.53, 1672.75), (0, 270, 0)], [(-2546.75, -17361.3, 2123.5), (0, 0, 0)], [(-22291.8, -5906.75, 744.25), (0, 260, 0)], [(29571.3, 15480.4, 2447.5), (0, 140, 0)], [(19902.3, 24705.8, 4506.75), (0, 51, 0)], [(28773, 36971, 2642), (0, 16, 0)]];
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1 = bombsite_spawnbombsite(var_3[0], var_3[1]);
  }

  return var_1;
}

function bombsite_spawnbombsite(var_0, var_1) {
  var_2 = easepower("br_bombsite", var_0, var_1);
  return var_2;
}

function bombsite_activatebombsites() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(level.mapname == "mp_br_mechanics") {
    bomb_spawnbomb((626, -2300, 20));
    bomb_spawnbomb((626, -2400, 20));
    defusekit_spawndefusekit((550, -2300, 20));
    defusekit_spawndefusekit((550, -2400, 20));
  }

  thread bombsite_processbombsiteactivationrequests();
  thread bombsite_spawnmanager();
}

function bombsite_setinitialbombsites() {
  var_0 = level.disable_super_in_turret.br_bombsites;
  var_1 = [];
  var_2 = level.grouptorewards;
  var_3 = level.disable_super_in_turret.bombsite_spawningradius;

  foreach(var_5 in level.disable_super_in_turret.br_bombsites) {
    if(distance2d(var_2, var_5.origin) > var_3) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_5);
    }
  }

  var_7 = getdvarint("scr_br_olaride_bomb_site_start_count", 15);
  var_7 = min(var_7, var_0.size);
  var_8 = 0;
  var_9 = 0;
  var_0 = scripts\engine\utility::array_randomize(var_0);

  while(var_8 < var_7 && var_9 < var_0.size) {
    var_5 = var_0[var_9];

    if(canactivate(var_5)) {
      bombsite_activate(var_5);
      var_5.isinitial = 1;
      var_8++;
    }

    var_9++;
  }

  bombsite_autoplantinitialbombsites();
}

function bombsite_spawnmanager() {
  level endon("game_ended");
  bombsite_setinitialbombsites();

  for(;;) {
    var_0 = level.disable_super_in_turret.br_activebombsites.size;
    var_1 = level.disable_super_in_turret.requestedsitecount + level.disable_super_in_turret.requestedarmedsitecount;
    var_2 = level.disable_super_in_turret.bombsite_wantedcount;

    for(var_3 = var_2 - var_0 + var_1; var_3 < 0 && level.disable_super_in_turret.requestedsitecount > 0; var_3++) {
      level.disable_super_in_turret.requestedsitecount--;
    }

    while(var_3 < 0 && level.disable_super_in_turret.requestedarmedsitecount > 0) {
      level.disable_super_in_turret.requestedarmedsitecount--;
      var_3++;
    }

    while(var_3 > 0) {
      if(bombsite_shouldarmanotherneutralsite()) {
        bombsite_requestnewarmedsite();
      } else {
        bombsite_requestnewsite();
      }

      var_3--;
    }

    wait 3;
  }
}

function bombsite_processbombsiteactivationrequests() {
  level endon("game_ended");
  level.disable_super_in_turret.requestedsitecount = 0;
  level.disable_super_in_turret.requestedarmedsitecount = 0;

  for(;;) {
    if(level.disable_super_in_turret.requestedsitecount == 0 && level.disable_super_in_turret.requestedarmedsitecount == 0) {
      level waittill("site_requested");
    }

    wait 10;

    while(level.disable_super_in_turret.requestedsitecount > 0 && isDefined(bombsite_tryactivatesite())) {
      level.disable_super_in_turret.requestedsitecount--;
    }

    while(level.disable_super_in_turret.requestedarmedsitecount > 0 && isDefined(bombsite_tryactivateandarmsite())) {
      level.disable_super_in_turret.requestedarmedsitecount--;
    }
  }
}

function bombsite_requestnewsite() {
  var_0 = bombsite_tryactivatesite();

  if(isDefined(var_0)) {
    return;
  }

  level.disable_super_in_turret.requestedsitecount++;
  level notify("site_requested");
}

function bombsite_requestnewarmedsite() {
  var_0 = bombsite_tryactivateandarmsite();

  if(isDefined(var_0)) {
    return;
  }

  level.disable_super_in_turret.requestedarmedsitecount++;
  level notify("site_requested");
}

function bombsite_tryactivatesite() {
  var_0 = bombsite_getpossiblesites(0);

  if(var_0.size == 0) {
    return undefined;
  }

  var_1 = bombsite_choosesitetoactivate(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  bombsite_activate(var_1);
  return var_1;
}

function bombsite_tryactivateandarmsite() {
  var_0 = bombsite_tryactivatesite();

  if(!isDefined(var_0)) {
    return undefined;
  }

  bombsite_setupplantedbombsite(var_0, undefined, undefined);
  bombsite_setobjectiveasplanted(var_0, undefined);
  return var_0;
}

function bombsite_shouldarmanotherneutralsite() {
  if(!istrue(level.disable_super_in_turret.arevillainsstrictlyleading)) {
    return 0;
  }

  var_0 = getdvarint("scr_br_olaride_max_neutral_armed_site_count", 1);
  var_1 = brolaride_getneutralbombsitecount() + level.disable_super_in_turret.requestedarmedsitecount;

  if(var_1 >= var_0) {
    return 0;
  }

  var_2 = getdvarfloat("scr_br_olaride_chance_spawned_site_is_armed", 1);
  var_3 = var_2 >= 1 || randomfloat(1) < var_2;
  return var_3;
}

function brolaride_getneutralbombsitecount() {
  var_0 = 0;

  foreach(var_2 in level.disable_super_in_turret.br_activebombsites) {
    if(istrue(var_2.isneutral)) {
      var_0++;
    }
  }

  return var_0;
}

function bombsite_removesitefromactivelist() {
  var_0 = getdvarint("scr_br_olaride_bomb_site_deactivation_delay", 1);
  wait var_0;
  level.disable_super_in_turret.br_activebombsites = scripts\engine\utility::array_remove(level.disable_super_in_turret.br_activebombsites, self);
}

function bombsite_autoplantinitialbombsites() {
  var_0 = getdvarint("scr_br_olaride_bomb_site_auto_arm_delay", 24);
  wait var_0;
  var_1 = level.disable_super_in_turret.bombsite_initialtimer;

  if(var_1 > 0 && isDefined(level.disable_super_in_turret.br_activebombsites)) {
    var_2 = getdvarint("scr_br_olaride_bomb_site_armed_count", 3);

    if(var_2 > 0) {
      var_3 = spawn("trigger_radius", (0, 0, 0), 0, 1, 1);
      level.disable_super_in_turret.neutralbombentity = var_3;
    }

    bombsite_autoplantbomb(var_2, 1, var_1, level.disable_super_in_turret.br_activebombsites);
    return;
  }
}

function bombsite_autoplantbomb(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_4 = var_3;
  } else {
    var_4 = bombsite_getpossiblesites(var_2);
  }

  var_1 = min(var_1, var_4.size);
  var_5 = 0;
  var_4 = scripts\engine\utility::array_randomize(var_4);

  for(var_6 = 0; var_5 < var_1 && var_6 < var_4.size; var_6++) {
    var_7 = var_4[var_6];

    if(!istrue(var_2) && canactivate(var_7)) {
      bombsite_activate(var_7);
    }

    bombsite_setupplantedbombsite(var_7, undefined, var_3);
    bombsite_setobjectiveasplanted(var_7, undefined);
    var_5++;
  }
}

function bombsite_autoexploderandombomb() {
  if(level.disable_super_in_turret.br_activebombsites.size == 0) {
    return;
  }

  var_0 = randomint(level.players.size);
  var_1 = level.players[var_0];
  var_2 = scripts\engine\utility::array_randomize(level.disable_super_in_turret.br_activebombsites);

  if(isDefined(var_1)) {
    foreach(var_4 in var_2) {
      var_5 = var_4 getscriptablepartstate("br_bombsite");

      if(var_5 == "active") {
        var_6 = scripts\mp\utility\teams::getteamdata(var_1.team, "players");
        bombsite_explode(var_4, var_6);
        break;
      }
    }

    return;
  }
}

function bombsite_autodefuserandombomb() {
  if(level.disable_super_in_turret.br_activebombsites.size == 0) {
    return;
  }

  var_0 = randomint(level.players.size);
  var_1 = level.players[var_0];
  var_2 = scripts\engine\utility::array_randomize(level.disable_super_in_turret.br_activebombsites);

  if(isDefined(var_1)) {
    foreach(var_4 in var_2) {
      var_5 = var_4 getscriptablepartstate("br_bombsite");

      if(var_5 == "active") {
        bombsite_defusebomb(var_1, var_4);
        break;
      }
    }

    return;
  }
}

function bombsite_getpossiblesites(var_0) {
  var_1 = undefined;

  if(var_0) {
    var_1 = level.disable_super_in_turret.br_activebombsites;
  } else {
    var_1 = scripts\engine\utility::array_remove_array(level.disable_super_in_turret.br_bombsites, level.disable_super_in_turret.br_activebombsites);
  }

  var_2 = var_1;

  foreach(var_4 in var_1) {
    var_5 = var_4 getscriptablepartstate("br_bombsite");

    if(var_0 && var_5 == "planted") {
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
      continue;
    }

    if(!(level.mapname == "mp_br_mechanics") && !scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_4.origin)) {
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
      continue;
    }

    var_6 = getdvarint("scr_br_olaride_bomb_site_distance_min", 785);

    foreach(var_8 in level.players) {
      if(isDefined(var_8) && distance2d(var_4.origin, var_8.origin) < var_6) {
        var_2 = scripts\engine\utility::array_remove(var_2, var_4);
        break;
      }
    }
  }

  if(getdvarint("scr_br_olaride_bomb_site_limit_reuse", 1) == 1) {
    var_11 = var_2;

    foreach(var_13 in var_11) {
      if(scripts\engine\utility::array_contains(level.disable_super_in_turret.br_usedsites, var_13)) {
        var_11 = scripts\engine\utility::array_remove(var_11, var_13);
      }
    }

    if(var_11.size > 0) {
      return var_11;
    } else {
      bombsite_resetunusablesites();
    }
  }

  return var_2;
}

function bombsite_resetunusablesites() {
  level.disable_super_in_turret.br_usedsites = [];
}

function bombsite_choosensitestoactivate(var_0, var_1) {
  var_2 = [];

  if(var_0.size == 0) {
    return var_2;
  }

  var_3 = level.grouptorewards;
  var_4 = level.disable_super_in_turret.bombsite_spawningradius;
  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_6 in var_0) {
    var_7 = distance2d(var_3, var_6.origin) <= var_4;

    if(var_7 && canactivate(var_6)) {
      var_2 = var_6;

      if(var_2.size >= var_1) {
        break;
      }
    }
  }

  if(var_2.size < var_1) {
    var_0 = scripts\engine\utility::get_array_of_closest(var_3, var_0);

    foreach(var_6 in var_0) {
      if(canactivate(var_6)) {
        var_2 = var_6;

        if(var_2.size >= var_1) {
          break;
        }
      }
    }

    bombsite_resetunusablesites();
  }

  return var_2;
}

function bombsite_choosesitetoactivate(var_0) {
  var_1 = bombsite_choosensitestoactivate(var_0, 1);
  return var_1[0];
}

function bombsite_activate(var_0) {
  var_1 = var_0 getscriptablepartstate("br_bombsite");

  if(var_1 == "defused" && isDefined(var_0.plantedbomb)) {
    var_0.plantedbomb setscriptablepartstate("br_bomb", "hidden");
  }

  var_0 setscriptablepartstate("br_bombsite", "active");
  var_0 setasgametypeobjective();
  var_0.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  bombsite_setupobjectiveicon(var_0.objidnum, var_0.origin);
  bombsite_setobjectiveasactivated(var_0);
  thread bombsite_markclosetopplayers();
  level.disable_super_in_turret.br_activebombsites[level.disable_super_in_turret.br_activebombsites.size] = var_0;

  if(!scripts\engine\utility::array_contains(level.disable_super_in_turret.br_usedsites, var_0)) {
    level.disable_super_in_turret.br_usedsites[level.disable_super_in_turret.br_usedsites.size] = var_0;
    return;
  }
}

function bombsite_removefromgas() {
  level endon("game_ended");
  var_0 = getdvarint("scr_br_olaride_bomb_site_remove_from_gas_delay", 1);
  wait var_0;
  var_1 = self getscriptablepartstate("br_bombsite");

  if(var_1 == "planted" || !scripts\engine\utility::array_contains(level.disable_super_in_turret.br_ingasbombsites, self)) {
    return;
  }

  level.disable_super_in_turret.br_activebombsites = scripts\engine\utility::array_remove(level.disable_super_in_turret.br_activebombsites, self);
  level.disable_super_in_turret.br_ingasbombsites = scripts\engine\utility::array_remove(level.disable_super_in_turret.br_ingasbombsites, self);
  bombsite_deleteobjectiveicon();
  self setscriptablepartstate("br_bombsite", "hidden");
  thread bombsite_removesitefromactivelist();
}

function showobjectivetoallexcept(var_0, var_1) {
  objective_addalltomask(var_0);
  objective_hidefromplayersinmask(var_0);
  objective_removeallfrommask(var_0);

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && var_3 != var_1) {
      objective_addclienttomask(var_0, var_3);
    }
  }

  objective_showtoplayersinmask(var_0);
}

function bombsite_setupobjectiveicon(var_0, var_1) {
  scripts\mp\objidpoolmanager::objective_add(var_0, "current", var_1 + (0, 0, 90), "ui_mp_br_mapmenu_distance_icon_bombsite", "icon_regular");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_0, 1);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_0, undefined);
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_0, 1);
  objective_setshowdistance(var_0, 1);
  playencryptedcinematicforall(var_0, 1);
  getbnetigrbattlepassxpmultiplier(var_0, 13000, 15000);
  scripts\mp\objidpoolmanager::objective_show_on_compass(var_0, 1);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_0);
}

function bombsite_setobjectiveasactivated() {
  scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, "ui_mp_br_mapmenu_distance_icon_bombsite");
  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, undefined);
  scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_setlabel(self.objidnum, "MP_BR_INGAME_TU_WZ350/BR_BOMBSITE_CAPS");
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.objidnum);
}

function bombsite_setobjectiveasplanting(var_0, var_1) {
  scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);
  showobjectivetoallexcept(self.objidnum, var_1);
  scripts\mp\objidpoolmanager::update_objective_setlabel(self.objidnum, "MP_INGAME_ONLY/OBJ_PLANTING_CAPS");
}

function bombsite_setobjectiveasplanted(var_0) {
  scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, "ui_mp_br_mapmenu_distance_icon_bombplant");
  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, var_0);
  scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);
  scripts\mp\objidpoolmanager::update_objective_setlabel(self.objidnum, "MP_BR_INGAME_TU_WZ350/BR_ARMED");
  scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.objidnum);
  self.isbeingdefused = 0;
}

function bombsite_setobjectiveasdisarming(var_0, var_1) {
  scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, "ui_mp_br_mapmenu_distance_icon_bombdefuse");
  scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, var_0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);
  scripts\mp\objidpoolmanager::update_objective_setlabel(self.objidnum, "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS");
  scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
  showobjectivetoallexcept(self.objidnum, var_1);
}

function bombsite_updateobjectiveonfailuse(var_0) {
  if(var_0 == "active") {
    scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
    bombsite_setobjectiveasactivated();
    return;
  }

  if(var_0 == "planted") {
    self.isbeingdefused = 0;

    if(bombsite_canshowdefuse()) {
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
      bombsite_setobjectiveasplanted(self.bomberteam);
      return;
    }

    return;
  }
}

function bombsite_canshowdefuse() {
  return getdvarint("scr_br_olaride_bomb_hide_defuse", 0) == 0;
}

function bombsite_manageprogressobjectivecountdown(var_0, var_1) {
  self endon("bombDefused");
  self endon("bombExploded");
  level endon("game_ended");
  var_2 = gettime();
  var_3 = gettime() + var_0 * 1000;
  var_4 = var_3 - var_2;
  var_5 = 0;
  var_6 = 0;

  while(gettime() < var_3 || var_6) {
    var_7 = gettime() - var_2;
    var_8 = clamp(var_7 / var_4, 0, 1);
    var_9 = self getscriptablepartstate("br_bombsite", 1);
    var_10 = (1 - var_8) * var_0;

    if(var_10 < level.disable_super_in_turret.remainingtimetostartpulsating && !istrue(self.ispulsating)) {
      scripts\mp\objidpoolmanager::objective_set_pulsate(self.objidnum, 1);
      self.ispulsating = 1;
    }

    if(level.disable_super_in_turret.freezetimerwhendefusing) {
      if(istrue(self.isbeingdefused) && var_5 == 0) {
        var_5 = gettime();
      } else if(!istrue(self.isbeingdefused) && var_5 > 0) {
        var_11 = gettime() - var_5;
        var_2 += var_11;
        var_3 += var_11;
        var_5 = 0;
      }

      var_6 = istrue(self.isbeingdefused) || var_5 > 0;
    }

    if(!istrue(self.isbeingdefused)) {
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, var_8);
    }

    waitframe();
  }
}

function bombsite_deleteobjectiveicon() {
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnum);
  bombsite_unpingbombsiteforplayers(self, level.players);
}

function bombsite_unpingbombsite(var_0) {
  var_1 = self calloutmarkerping_getsavedzoffset(11);

  if(isDefined(var_1) && var_1.index == var_0.index) {
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(11);
    return;
  }
}

function bombsite_unpingbombsiteforplayers(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    bombsite_unpingbombsite(var_3, var_0);
  }
}

function brolaride_onping(var_0) {
  if(var_0 != 7) {
    return;
  }

  var_1 = self getnodeoffset_code(var_0);
  var_2 = undefined;

  foreach(var_4 in level.disable_super_in_turret.br_activebombsites) {
    if(!isDefined(var_4) || !isDefined(var_4.objidnum)) {
      continue;
    }

    if(var_4.objidnum == var_1) {
      var_2 = var_4;
      break;
    }
  }

  if(isDefined(var_2)) {
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(var_0);
    self calloutmarkerping_create(11, var_2.origin, var_2.index);
    return;
  }
}

function bombsite_used(var_0, var_1, var_2, var_3, var_4) {
  if(!bombsite_canstartusing(var_0, var_3, var_2)) {
    return;
  }

  thread bombsite_usedinternal(var_0, var_1, var_2, var_3, var_4);
}

function bombsite_usedinternal(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_3.tracking_max_health)) {
    var_3 notify("br_try_armor_cancel");
  }

  bombsite_initusehold(var_3, var_2);
  bombsite_startusing(var_3, var_0, var_2);
  var_5 = bombsite_watchuseinternal(var_3, var_0, var_2);

  if(isDefined(var_3)) {
    bombsite_stopusing(var_3, var_0, var_5);
  }

  if(istrue(var_5)) {
    if(var_2 == "active") {
      thread bombsite_plantbomb(var_3);
      brolaride_updatesquaddata(var_3, 0);
    } else if(var_2 == "planted") {
      thread bombsite_defusebomb(var_3);

      if(istrue(var_3.carrydefusekit)) {
        brolaride_updatesquaddata(var_3, 0);
      }
    }
  } else {
    bombsite_updateobjectiveonfailuse(var_0, var_2);
  }

  bombsite_destroyusehold(var_3);
}

function bombsite_canstartusing(var_0, var_1, var_2) {
  if(istrue(level.gameended)) {
    return false;
  }

  if(!var_1 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_1.inlaststand)) {
    return false;
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isusingremote()) {
    return false;
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(!var_1 isonground()) {
    return false;
  }

  if(var_2 == "defused") {
    var_1 scripts\mp\hud_message::showerrormessage("MP_BR_INGAME_TU_WZ350/BOMBSITE_DEFUSED");
    return false;
  }

  if(istrue(var_1 scripts\mp\gametypes\br_gametypes::ref_12E05("playerSkipKioskUse", var_0))) {
    return false;
  }

  if(istrue(var_1.iscarrying) && !isDefined(var_1.get_search_turret_target_player)) {
    var_1 scripts\mp\hud_message::showerrormessage("MP/FIELD_UPGRADE_CANNOT_USE");
    return false;
  }

  if(!bombsite_instanceandplayermatch(var_0, var_1)) {
    return false;
  }

  if(isDefined(var_0.isbeingused) && var_0.isbeingused) {
    return false;
  }

  return true;
}

function bombsite_instanceandplayermatch(var_0, var_1) {
  var_2 = var_0 getscriptablepartstate("br_bombsite");

  if(var_2 == "active") {
    if(istrue(var_1.carrybomb)) {
      return 1;
    }

    return 0;
  } else if(var_2 == "planted") {
    if(isDefined(var_0.bomberteam)) {
      var_3 = var_0.bomberteam != var_1.team;
    } else {
      var_3 = 1;
    }

    return var_3;
  }

  return 0;
}

function bombsite_watchuseinternal(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1.id = var_0.bomb_site_use.id;
  var_1.userate = scripts\engine\utility::ter_op(isDefined(var_0.objectivescaler), var_0.objectivescaler, 1);
  var_3 = bombsite_canshowdefuse();
  var_4 = !var_3 && var_2 == "planted";
  var_1.skipupdateobjectiveprogress = var_4;

  if(isDefined(var_0.bomb_site_use.ref_14099)) {
    bombsite_playusesound(var_0, var_0.bomb_site_use.ref_14099);
  }

  while(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && bombsite_cankeepusing(var_0, var_1, var_2) && var_0 useButtonPressed()) {
    var_0.bomb_site_use.curprogress += level.framedurationseconds * var_1.userate;

    if(var_0.bomb_site_use.curprogress >= var_0.bomb_site_use.usetime) {
      var_0.bomb_site_use.curprogress = 0;
      return true;
    }

    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 1, var_0.bomb_site_use);

    if(!var_4) {
      var_5 = clamp(var_0.bomb_site_use.curprogress / var_0.bomb_site_use.usetime, 0, 1);
      scripts\mp\objidpoolmanager::objective_set_progress(var_1.objidnum, var_5);
    }

    waitframe();
  }

  if(isDefined(var_0) && isDefined(var_0.bomb_site_use) && isDefined(var_0.bomb_site_use.curprogress)) {
    var_0.bomb_site_use.curprogress = 0;
  }

  return false;
}

function bombsite_cankeepusing(var_0, var_1, var_2) {
  if(!scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var_0 meleeButtonPressed()) {
    return false;
  }

  if(var_0 isinexecutionvictim()) {
    return false;
  }

  if(istrue(var_0.inlaststand)) {
    return false;
  }

  if(!isDefined(var_0.bomb_site_use)) {
    return false;
  }

  var_3 = var_1 getscriptablepartstate("br_bombsite", 1);

  if(var_2 != var_3) {
    return false;
  }

  if(!bombsite_instanceandplayermatch(var_1, var_0)) {
    return false;
  }

  var_4 = getdvarfloat("player_itemUseRadius", 128) + 16;
  var_5 = var_4 * var_4;

  if(distancesquared(var_0.origin, var_1.origin) > var_5) {
    return false;
  }

  return true;
}

function bombsite_initusehold(var_0, var_1) {
  var_0.bomb_site_use = spawnStruct();
  var_0.bomb_site_use.curprogress = 0;

  if(var_1 == "active") {
    var_0.bomb_site_use.id = "planting_explosive";
    var_0.bomb_site_use.usetime = level.disable_super_in_turret.bombsite_planttime;
    return;
  }

  if(var_1 == "planted") {
    var_0.bomb_site_use.id = "breach_defuse";
    var_0.bomb_site_use.usetime = scripts\engine\utility::ter_op(istrue(var_0.carrydefusekit), level.disable_super_in_turret.bombsite_defusekittime, level.disable_super_in_turret.bombsite_defusetime);
    return;
  }
}

function bombsite_destroyusehold(var_0) {
  var_0.bomb_site_use = undefined;
}

function bombsite_startusing(var_0, var_1, var_2) {
  var_1.isbeingused = 1;
  var_0.isusingolaridebombsite = 1;
  thread bombsite_playusinganimation(var_0);
  thread allowedwhileusingbombsite(var_0);
  var_0 scripts\mp\playeractions::allowactionset("crateUse", 0);

  if(var_2 == "planted") {
    var_1.isbeingdefused = 1;

    if(bombsite_canshowdefuse()) {
      var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0, var_0.bomb_site_use);
      bombsite_setobjectiveasdisarming(var_1, var_0.team, var_0);
      return;
    }

    return;
  }

  if(var_2 == "active") {
    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0, var_0.bomb_site_use);
    bombsite_setobjectiveasplanting(var_1, var_0.team, var_0);
    return;
  }
}

function bombsite_stopusing(var_0, var_1, var_2) {
  var_1.isbeingused = undefined;

  if(!level.gameended) {
    var_0 scripts\mp\playeractions::allowactionset("crateUse", 1);
  }

  if(isDefined(var_0.bomb_site_use)) {
    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0, var_0.bomb_site_use);

    if(isDefined(var_0.bomb_site_use.ref_14099)) {
      bombsite_stopusesound(var_0, var_0.bomb_site_use.ref_14099);
    }
  }

  thread allowedwhileusingbombsite(var_0);
  var_0 notify("bomb_site_use_end", var_2);
  var_0.isusingolaridebombsite = undefined;
}

function bombsite_playusesound(var_0, var_1) {
  var_0 playlocalsound(var_1);
}

function bombsite_stopusesound(var_0, var_1) {
  var_0 stoplocalsound(var_1);
}

function disableinputongameended() {
  wait 0.5;
  scripts\mp\playeractions::allowactionset("crateUse", 0);
}

function bombsite_playusinganimation(var_0) {
  self endon("disconnect");
  self notify("olaride_bombsite_play_using_animation");
  self endon("olaride_bombsite_play_using_animation");
  scripts\cp_mp\utility\weapon_utility::ref_12EB2();
  var_1 = scripts\engine\utility::ter_op(var_0 == "active", "briefcase_bomb_mp_vilain", "briefcase_bomb_defuse_mp_vilain");
  var_2 = getcompleteweaponname(var_1);

  while(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
    waitframe();
  }

  if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_2)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
    scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_2, 0, 1);
  }

  if(istrue(self.isusingolaridebombsite) && !level.gameended) {
    scripts\engine\utility::waittill_any_ents(level, "game_ended", self, "bomb_site_use_end");
  }

  if(level.gameended) {
    scripts\mp\playeractions::allowactionset("crateUse", 1);
    thread disableinputongameended();
  }

  scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);
}

function bombsite_setupplantedbombsite(var_0, var_1, var_2) {
  var_0 setscriptablepartstate("br_bombsite", "planted");

  if(!isDefined(var_0.plantedbomb)) {
    var_3 = var_0.angles;
    var_4 = anglesToForward(var_0.angles) * 8;
    var_4 += (0, 0, 38);
    var_3 = (var_3[0], 180 + var_3[1], var_3[2]);
    var_5 = easepower("br_bomb", var_0.origin + var_4, var_3);
    var_5 setscriptablepartstate("br_bomb", "planted");
    var_0.plantedbomb = var_5;
  } else {
    var_0.plantedbomb setscriptablepartstate("br_bomb", "planted");
  }

  var_0.isneutral = scripts\engine\utility::ter_op(isDefined(var_1), undefined, 1);
  thread bombsite_bombcountdown(var_0, var_1, var_2);
  bombsite_showsplashtoenemies(var_0, var_1, "br_bombPlantedInArea", "bomb_warning");
}

function bombsite_plantbomb(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  self.carrybomb = undefined;
  var_0.planter = self;
  bombsite_setupplantedbombsite(var_0, var_1, undefined);

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 thread scripts\mp\utility\points::giveunifiedpoints("br_plant");
      var_3 scripts\mp\hud_message::showsplash("br_defendTheBomb");
      var_0 disablescriptableplayeruse(var_3);
    }
  }

  var_0.bomberteam = self.team;
  bombsite_setobjectiveasplanted(var_0, self.team);
  bombsite_unpingbombsiteforplayers(var_0, var_1);
}

function bombsite_defusebomb(var_0) {
  getentitylessscriptablearray("dlog_event_hvv_bombsite_interacted", ["status", "Bombsite_Defused"]);
  var_0 notify("bombDefused");
  var_0 setscriptablepartstate("br_bombsite", "defused");
  var_1 = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 thread scripts\mp\utility\points::giveunifiedpoints("br_defuse");
      var_3 scripts\mp\hud_message::showsplash("br_youDefusedBomb");
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("bomb_disarmed", var_3, 1, 0);
    }
  }

  if(isDefined(var_0.bomberteam)) {
    var_5 = scripts\mp\utility\teams::getteamdata(var_0.bomberteam, "players");

    foreach(var_3 in var_5) {
      if(isDefined(var_3)) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("bomb_negative", var_3, 1, 0);
      }
    }

    showsplashtoteam(var_0, var_0.bomberteam, "br_bombDefusedEnemy");
  }

  brolaride_givematchpoint(1, var_1);
  bombsite_givereward(var_0, 1, var_1);
  bombsite_deleteobjectiveicon(var_0);

  if(istrue(var_0.hasleadericon)) {
    bombsite_deleteleadericon(var_0);
  }

  thread bombsite_removesitefromactivelist();

  if(istrue(self.carrydefusekit)) {
    self.carrydefusekit = undefined;
    return;
  }
}

function bombsite_explode(var_0) {
  self notify("bombExploded");
  self setscriptablepartstate("br_bombsite", "explode");

  if(isDefined(self.plantedbomb)) {
    self.plantedbomb setscriptablepartstate("br_bomb", "hidden");
  }

  var_1 = "bomb_explosion";
  var_2 = self.origin;
  var_3 = var_2 + (0, 0, 0);
  var_4 = spawnfx(level._effect[var_1], var_3);
  triggerfx(var_4);
  physicsexplosionsphere(var_3, 200, 100, 3);

  if(isDefined(self.planter)) {
    self.planter radiusdamage(var_2, 512, 200, 20, self.planter, "MOD_EXPLOSIVE", "bomb_site_mp");
  } else {
    radiusdamage(var_2, 512, 200, 20, level.disable_super_in_turret.neutralbombentity, "MOD_EXPLOSIVE", "bomb_site_mp");
  }

  playrumbleonposition("grenade_rumble", var_2);
  earthquake(0.75, 2, var_2, 2000);
  playsoundatpos(var_3, "exp_bombsite_lr");

  if(isDefined(var_0)) {
    if(isDefined(self.planter)) {
      self.planter dlog_recordplayerevent("dlog_event_hvv_bombsite_interacted", ["status", "Bombsite_Exploded"]);
    }

    foreach(var_6 in var_0) {
      if(isDefined(var_6)) {
        var_6 thread scripts\mp\utility\points::giveunifiedpoints("br_detonate");
        var_6 scripts\mp\hud_message::showsplash("br_youDestroyedBombsite");
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("bomb_exploded", var_6, 1, 0, undefined, undefined, "mndz");
      }
    }

    brolaride_givematchpoint(0, var_0);
    bombsite_givereward(0, var_0);
  }

  bombsite_deleteobjectiveicon();

  if(istrue(self.hasleadericon)) {
    bombsite_deleteleadericon();
  }

  thread bombsite_removesitefromactivelist();
  level notify("olaride_meter_boost");
}

function bombsite_showsplashtoenemies(var_0, var_1, var_2, var_3) {
  var_4 = level.players;

  if(isDefined(var_0)) {
    var_4 = scripts\engine\utility::array_remove_array(var_4, var_0);
  }

  if(isDefined(var_3)) {
    var_4 = scripts\engine\utility::array_remove_array(var_4, var_3);
  }

  var_5 = getdvarint("scr_br_olaride_dist_for_splash", 6000);

  foreach(var_7 in var_4) {
    if(isDefined(var_7)) {
      var_8 = distance2d(var_7.origin, self.origin);

      if(var_8 <= var_5) {
        var_7 scripts\mp\hud_message::showsplash(var_1);

        if(isDefined(var_2)) {
          level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var_2, var_7, 1, 0);
        }
      }
    }
  }
}

function bombsite_givereward(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(isDefined(var_4)) {
      var_2 = var_4.team;
      break;
    }
  }

  if(!isDefined(var_2)) {
    return;
  }

  var_6 = 0;

  if(var_0) {
    var_6 = level.disable_super_in_turret.heromatchpoints[var_2];
  } else {
    var_6 = level.disable_super_in_turret.villainmatchpoints[var_2];
  }

  var_6 = floor(var_6 / level.disable_super_in_turret.victorypoints * 5);
  var_6 = int(max(var_6, 1));
  bombsite_givelootreward(var_0, var_6);
  bombsite_givepointsreward(var_0, var_6, var_1);
}

function bombsite_givelootreward(var_0, var_1) {
  self.itemsdropped = 0;
  var_2 = bombsite_getlootreward(var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }

  var_3 = spawnStruct();
  var_3.origin = self.origin;
  var_3.angles = self.angles;
  var_3.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_3.dropstruct.ml_p3_to_safehouse_transition = 14;
  var_3.dropstruct.silencer_pick_up_monitor = 50;

  if(!var_0) {
    var_3.dropstruct.ml_p3_to_safehouse_transition = 14;
    var_3.dropstruct.silencer_pick_up_monitor = 100;
  }

  var_4 = self.angles + (0, 45, 0);

  foreach(var_6 in var_2) {
    var_7 = var_6[0];
    var_8 = var_6[1];

    if(scripts\mp\gametypes\br_lootcache::get_bonus_targets(var_7)) {
      for(var_9 = 0; var_9 < var_8; var_9++) {
        var_10 = scripts\mp\gametypes\br_lootcache::ref_11A41(var_7, var_3.dropstruct, self.origin + (0, 0, var_3.dropstruct.silencer_pick_up_monitor), var_4, 0, 0);

        if(!var_0) {
          var_3.dropstruct.silencer_pick_up_monitor += 3;
        }

        self.itemsdropped++;
        waitframe();
      }
    }
  }
}

function bombsite_givepointsreward(var_0, var_1, var_2) {
  var_3 = level.disable_super_in_turret.br_bombsites_points_rewards[var_1 - 1];

  if(!isDefined(var_3)) {
    return;
  }

  foreach(var_5 in var_2) {
    if(isDefined(var_5)) {
      if(var_0) {
        giveheropoints(var_5, var_3);
        continue;
      }

      givevillainpoints(var_5, var_3);
    }
  }
}

function bombsite_getlootreward(var_0, var_1) {
  if(var_0) {
    switch (var_1) {
      case 1:
        return [["brloot_super_munitionsbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_smoke", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_super_armorbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_smoke", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["br_defusekit", level.bombsite_objectiveitem_amount]];
      case 2:
        return [["brloot_super_munitionsbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_smoke", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_super_armorbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_smoke", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["br_defusekit", level.bombsite_objectiveitem_amount]];
      case 3:
        return [["brloot_super_munitionsbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_smoke", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_super_armorbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_smoke", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["br_defusekit", level.bombsite_objectiveitem_amount]];
      case 4:
        return [["brloot_super_munitionsbox", 1], ["brloot_specialist_bonus", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_smoke", 1], ["brloot_specialist_bonus", 1], ["brloot_super_armorbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_specialist_bonus", 1], ["brloot_offhand_smoke", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_specialist_bonus", 1], ["br_defusekit", level.bombsite_objectiveitem_amount]];
      default:
        return;
    }

    return;
  }

  switch (var_1) {
    case 1:
      return [["brloot_super_munitionsbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_c4", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_super_armorbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_c4", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["br_bomb", level.bombsite_objectiveitem_amount]];
    case 2:
      return [["brloot_super_munitionsbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_c4", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_super_armorbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_c4", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["br_bomb", level.bombsite_objectiveitem_amount]];
    case 3:
      return [["brloot_super_munitionsbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_c4", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_super_armorbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_c4", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["br_bomb", level.bombsite_objectiveitem_amount]];
    case 4:
      return [["brloot_super_munitionsbox", 1], ["brloot_specialist_bonus", 1], ["brloot_offhand_slinger", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_c4", 1], ["brloot_specialist_bonus", 1], ["brloot_super_armorbox", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_specialist_bonus", 1], ["brloot_offhand_c4", 1], ["brloot_plunder_cash_uncommon_2", 1], ["brloot_offhand_slinger", 1], ["brloot_specialist_bonus", 1], ["br_bomb", level.bombsite_objectiveitem_amount]];
    default:
      return;
  }
}

function bombsite_bombcountdown(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("bombDefused");
  var_3 = undefined;

  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = level.disable_super_in_turret.bombsite_armedtimer;
  }

  bombsite_manageprogressobjectivecountdown(var_3, var_2);
  bombsite_explode(var_0);
}

function bombsite_infil_explode() {
  var_0 = (8387, 15066, 8191);
  var_1 = var_0 + (0, 0, 50);
  var_2 = playFX(level._effect["olarideInfil_bomb"], var_1);
  var_2 unmarkkeyframedmover(1);
  earthquake(0.75, 2, var_0, 0);
  playsoundatpos(var_1, "exp_bombsite_lr");
  waitframe();
  level notify("olaride_infil_explosion");
}

function bombsite_markclosetopplayers() {
  self endon("bombExploded");
  self endon("bombDefused");
  level endon("game_ended");
  var_0 = self getscriptablepartstate("br_bombsite");

  for(var_1 = []; var_0 == "active"; var_1 = var_2) {
    wait 0.5;
    var_2 = bombsite_updatenearleaders();

    if(var_2.size == 1 && var_1.size > 0) {
      bombsite_updatenewsolojoinleader(var_1, var_2);
    }

    if(var_2.size > 0) {
      bombsite_showleadericon(var_2);
      continue;
    }

    if(istrue(self.hasleadericon) && istrue(self.showleadericon)) {
      bombsite_hideleadericon();
    }
  }
}

function bombsite_updatenearleaders() {
  var_0 = [];
  var_1 = level.disable_super_in_turret.objectiveleadersmaxdistance * level.disable_super_in_turret.objectiveleadersmaxdistance;

  foreach(var_3 in level.disable_super_in_turret.objectiveleaders) {
    var_4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_3);

    foreach(var_6 in var_4) {
      if(isalive(var_6) && distance2dsquared(self.origin, var_6.origin) < var_1) {
        var_0 = scripts\engine\utility::array_add(var_0, var_3);
        break;
      }
    }
  }

  return var_0;
}

function bombsite_updatenewsolojoinleader(var_0, var_1) {
  if(!scripts\engine\utility::array_contains(var_0, var_1[0])) {
    var_2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1[0]);

    foreach(var_4 in var_2) {
      if(isDefined(var_4)) {
        scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_4);
      }
    }

    return;
  }
}

function bombsite_createleadericon() {
  var_0 = 1;
  var_1 = 20;
  scripts\mp\gametypes\br_quest_util::init_tactical_boxes(var_0, var_1, 0, self.origin);
  scripts\mp\gametypes\br_quest_util::ref_1316F(level.objectiveleadersmarksize);
  self.hasleadericon = 1;
  self.showleadericon = 0;
}

function bombsite_deleteleadericon() {
  scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  self.hasleadericon = 0;
}

function bombsite_showleadericon(var_0) {
  if(var_0.size > 1) {
    var_1 = level.players;
  } else {
    var_1 = scripts\mp\utility\teams::getenemyplayers(var_1[0], 0);
  }

  if(!istrue(self.hasleadericon)) {
    bombsite_createleadericon();
  }

  foreach(var_3 in var_1) {
    scripts\mp\gametypes\br_quest_util::ref_1336A(var_3);
  }

  self.showleadericon = 1;
}

function bombsite_hideleadericon() {
  scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
  self.showleadericon = 0;
}

function bomb_spawnbomb(var_0) {
  var_1 = easepower("br_bomb", var_0);
  scripts\mp\gametypes\br_pickups::ref_12B3A(var_1);
  level.disable_super_in_turret.br_bombs[level.disable_super_in_turret.br_bombs.size] = var_1;
}

function bomb_used(var_0, var_1, var_2, var_3, var_4) {
  brolaride_onpickupbomb(var_3);
}

function defusekit_spawndefusekit(var_0) {
  var_1 = easepower("br_defusekit", var_0);
  scripts\mp\gametypes\br_pickups::ref_12B3A(var_1);
  level.disable_super_in_turret.br_defusekits[level.disable_super_in_turret.br_defusekits.size] = var_1;
}

function defusekit_used(var_0, var_1, var_2, var_3, var_4) {
  brolaride_onpickupdefusekit(var_3);
}

function brolaride_updateflagonleadersquads() {
  level endon("game_ended");

  for(var_0 = [];; var_0 = level.disable_super_in_turret.objectiveleaders) {
    wait 0.5;

    foreach(var_2 in level.disable_super_in_turret.objectiveleaders) {
      var_3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_2);

      foreach(var_5 in var_3) {
        if(isDefined(var_5)) {
          if(brolaride_shoulddisplayflagonplayer(var_5)) {
            var_5 scripts\mp\gametypes\br_gametype_kingslayer::carriabletype();
            continue;
          }

          var_5 scripts\mp\gametypes\br_gametype_kingslayer::lbravo_hover_rider_death_monitor();
        }
      }
    }

    foreach(var_2 in var_0) {
      if(!scripts\engine\utility::array_contains(level.disable_super_in_turret.objectiveleaders, var_2)) {
        var_3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_2);

        foreach(var_5 in var_3) {
          if(isDefined(var_5)) {
            var_5 scripts\mp\gametypes\br_gametype_kingslayer::lbravo_hover_rider_death_monitor();
          }
        }
      }
    }
  }
}

function brolaride_shoulddisplayflagonplayer(var_0) {
  if(!isalive(var_0)) {
    return false;
  }

  var_1 = level.disable_super_in_turret.objectiveleadersmaxdistance * level.disable_super_in_turret.objectiveleadersmaxdistance;

  foreach(var_3 in level.disable_super_in_turret.br_activebombsites) {
    if(distance2dsquared(var_3.origin, var_0.origin) < var_1) {
      return true;
    }
  }

  return false;
}

function brolaride_detachallflag() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      var_1 scripts\mp\gametypes\br_gametype_kingslayer::lbravo_hover_rider_death_monitor();
    }
  }
}

function brolaride_onpickupbomb() {
  if(istrue(self.carrybomb)) {
    return;
  }

  if(!isDefined(self.playedcarrybombvo)) {
    self.playedcarrybombvo = 1;
    scripts\mp\gametypes\br_public::brleaderdialog("bomb_pickup_dialog", 1, [self], 1, 0, undefined, "mndz");
    thread brolaride_monitorplayedcarryitemvo(1);
  }

  self.carrybomb = 1;
  brolaride_updatesquaddata(1);
}

function brolaride_onpickupdefusekit() {
  if(istrue(self.carrydefusekit)) {
    return;
  }

  if(!isDefined(self.playedcarrydefusekitvo)) {
    self.playedcarrydefusekitvo = 1;
    scripts\mp\gametypes\br_public::brleaderdialog("defuse_kit_pickup_dialog", 1, [self], 1, 0, undefined, "bchr");
    thread brolaride_monitorplayedcarryitemvo(0);
  }

  self.carrydefusekit = 1;
  brolaride_updatesquaddata(2);
}

function brolaride_monitorplayedcarryitemvo(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  wait level.disable_super_in_turret.carryitemvoresettime;

  if(var_0) {
    self.playedcarrybombvo = undefined;
    return;
  }

  self.playedcarrydefusekitvo = undefined;
}

function brolaride_onusecompleted(var_0) {
  if(!isDefined(var_0.tracknonoobplayerlocation)) {
    return 0;
  }

  if(var_0.scriptablename == "br_defusekit") {
    if(istrue(self.carrydefusekit)) {
      return undefined;
    }

    return brolaride_switchtodefusekit(var_0.origin);
  } else if(var_0.scriptablename == "br_bomb") {
    if(istrue(self.carrybomb)) {
      return undefined;
    }

    return brolaride_switchtobomb(var_0.origin);
  }

  return undefined;
}

function brolaride_switchtobomb(var_0) {
  brolaride_spawncurrentitemfromplayer(var_0);
  self.carrydefusekit = undefined;
  return true;
}

function brolaride_switchtodefusekit(var_0) {
  brolaride_spawncurrentitemfromplayer(var_0);
  self.carrybomb = undefined;
  return true;
}

function brolaride_spawncurrentitemfromplayer(var_0) {
  if(istrue(self.carrybomb)) {
    brolaride_spawnbombfromplayer(var_0);
    return;
  }

  if(istrue(self.carrydefusekit)) {
    brolaride_spawndefusekitfromplayer(var_0);
    return;
  }
}

function brolaride_spawnbombfromplayer(var_0) {
  if(isDefined(var_0)) {
    bomb_spawnbomb(var_0);
    return;
  }

  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "br_bomb", 1, undefined, 1, 1);
}

function brolaride_spawndefusekitfromplayer(var_0) {
  if(isDefined(var_0)) {
    defusekit_spawndefusekit(var_0);
    return;
  }

  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "br_defusekit", 1, undefined, 1, 1);
}

function brolaride_updatesquaddata(var_0) {
  var_1 = scripts\mp\gametypes\br_public::round_at_max(self.team, self.squadindex, "ui_br_olaride_points");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(self.pers["squadMemberIndex"]), self.pers["squadMemberIndex"] - 1, 0);
  var_3 = var_2 * 2;
  var_4 = _calloutmarkerping_handleluinotify_added::repackomnvar(var_3, 2, var_1, var_0);
  scripts\mp\gametypes\br_public::ref_131C3(self.team, self.squadindex, "ui_br_olaride_points", var_4);

  if(var_4 != var_1) {
    var_5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);
    var_3 = 22;

    foreach(var_7 in var_5) {
      if(!isDefined(var_7)) {
        continue;
      }

      var_7 _calloutmarkerping_handleluinotify_added::ref_1313E("ui_br_olaride_points", var_3, 8, var_4);
    }

    return;
  }
}

function brolaride_onplayerkilled(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  var_1 = var_0.victim;
  var_2 = var_0.attacker;
  var_1 scripts\mp\gametypes\br_gametype_kingslayer::lbravo_hover_rider_death_monitor();

  if(!isDefined(var_1)) {
    return;
  }

  var_3 = isDefined(var_2) && (var_2.classname == "trigger_hurt" || var_2.classname == "worldspawn");
  var_4 = undefined;

  if(istrue(var_1.carrybomb)) {
    var_1.carrybomb = undefined;
    var_4 = &bomb_spawnbomb;
  } else if(istrue(var_1.carrydefusekit)) {
    var_1.carrydefusekit = undefined;
    var_4 = &defusekit_spawndefusekit;
  }

  if(!var_3 && isDefined(var_4)) {
    [[var_4]](var_1.origin);
  }

  brolaride_updatesquaddata(var_1, 0);
}

function canactivate(var_0) {
  foreach(var_2 in level.disable_super_in_turret.br_activebombsites) {
    if(distance2d(var_2.origin, var_0.origin) < level.disable_super_in_turret.br_mindistbetweenbombsite) {
      return false;
    }
  }

  return true;
}

function allowedwhileusingbombsite(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  scripts\common\utility::allow_jump(var_0);
  scripts\mp\utility\player::allow_gesture(var_0);
  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_mantle(var_0);
  scripts\common\utility::allow_movement(var_0);
  scripts\common\utility::allow_offhand_weapons(var_0);
}

function brolaride_initvisionsetprogression() {
  level waittill("prematch_fade_done");
  level.visionsetstate = 0;
  level.visionsetsuffixes = ["_s05_ltm_00", "_s05_ltm_00", "_s05_ltm_01", "_s05_ltm_02", "_s05_ltm_03"];
}

function brolaride_setvisionsetstate(var_0, var_1) {
  if(var_0 < 0 || var_0 >= level.visionsetsuffixes.size) {
    return;
  }

  level.visionsetstate = var_0;

  if(!isDefined(var_1)) {
    var_1 = 60;
  }

  thread overridevisionset(var_1);
}

function overridevisionset(var_0) {
  function_0444(var_0, level.visionsetsuffixes[level.visionsetstate]);
}

function brolaride_updatevisionsets(var_0) {
  var_1 = level.visionsetstate;

  if(level.disable_super_in_turret.islastcall) {
    var_1 = level.visionsetsuffixes.size - 1;
  } else {
    var_2 = var_0 / level.disable_super_in_turret.lastcallpoints;
    var_1 = var_2 * (level.visionsetsuffixes.size - 1);
    var_1 = int(floor(var_1));
  }

  if(var_1 > level.visionsetstate) {
    brolaride_setvisionsetstate(var_1);

    if(var_1 == level.visionsetsuffixes.size - 1) {
      foreach(var_4 in level.players) {
        if(isDefined(var_4)) {
          thread setplayerashvfxactive(var_4);
        }
      }

      return;
    }

    return;
  }
}

function brolaride_initmeter() {
  level endon("game_ended");

  if(getdvarint("scr_br_olaride_meter_enabled", 1) == 0) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.olaridemeter = spawnStruct();
  level.olaridemeter.progress = 0;
  level.olaridemeter.percentage = 0;
  level.olaridemeter.get_closest_enemy_near_turret = getdvarint("scr_br_olaride_meter_capacity", 10000);
  var_0 = spawnStruct();
  var_0.herodialog = "volcano_meter_1";
  var_1 = spawnStruct();
  var_1.herodialog = "volcano_meter_2";
  var_2 = spawnStruct();
  var_2.herodialog = "volcano_meter_3_hero";
  var_2.villaindialog = "volcano_meter_3_villain";
  var_2.soundeffect = "volcano_meter";
  var_3 = brolaride_createmeterstate(100, 40, 6, 7, undefined);
  var_4 = brolaride_createmeterstate(80, 40, 5, 7, var_2);
  var_5 = brolaride_createmeterstate(60, 40, 4, 6, var_1);
  var_6 = brolaride_createmeterstate(40, 60, 3, 5, undefined);
  var_7 = brolaride_createmeterstate(20, 60, 2, 4, var_0);
  var_8 = brolaride_createmeterstate(0, 60, 1, 3, undefined);
  level.olaridemeter.states = [var_3, var_4, var_5, var_6, var_7, var_8];
  level.olaridemeter.currentstateindex = level.olaridemeter.states.size - 1;
  thread brolaride_increasemeter();
  thread brolaride_trackmeterboost();
}

function brolaride_createmeterstate(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.percentage = var_0;
  var_5.delay = var_1;
  var_5.toxicbombcount = var_2;
  var_5.cosmeticbombcount = var_3;
  var_5.sfx = var_4;
  return var_5;
}

function brolaride_increasemeter() {
  level endon("game_ended");
  var_0 = getdvarint("scr_br_olaride_meter_unit_per_second", 3);

  while(level.olaridemeter.progress < level.olaridemeter.get_closest_enemy_near_turret) {
    wait 1;
    brolaride_setmeterprogress(var_0);
  }
}

function brolaride_trackmeterboost() {
  level endon("game_ended");
  var_0 = getdvarint("scr_br_olaride_meter_boost", 218);

  while(level.olaridemeter.progress < level.olaridemeter.get_closest_enemy_near_turret) {
    level waittill("olaride_meter_boost");
    brolaride_setmeterprogress(var_0);
  }
}

function brolaride_setmeterprogress(var_0) {
  level.olaridemeter.progress = int(clamp(level.olaridemeter.progress + var_0, 0, level.olaridemeter.get_closest_enemy_near_turret));
  var_1 = level.olaridemeter.get_closest_enemy_near_turret / 100;
  level.olaridemeter.percentage = int(level.olaridemeter.progress / var_1);
  setomnvar("ui_br_pe_meter_data", level.olaridemeter.percentage);
  brolaride_setmetercurrentstate();
}

function brolaride_setmetercurrentstate() {
  for(var_0 = 0; var_0 < level.olaridemeter.states.size; var_0++) {
    var_1 = level.olaridemeter.states[var_0];
    var_2 = var_0 == level.olaridemeter.currentstateindex;
    var_3 = level.olaridemeter.percentage >= level.olaridemeter.states[level.olaridemeter.currentstateindex].percentage;

    if(var_2 && var_3) {
      break;
    }

    if(var_1.percentage > level.olaridemeter.percentage) {
      continue;
    }

    level.olaridemeter.currentstateindex = var_0;

    foreach(var_5 in level.players) {
      if(isDefined(var_5)) {
        brolaride_playvolcanometersfx(var_5, var_1);
      }
    }

    break;
  }
}

function brolaride_playvolcanometersfx(var_0) {
  if(!isDefined(var_0.sfx)) {
    return;
  }

  if(isDefined(var_0.sfx.soundeffect)) {
    self playsoundtoplayer(var_0.sfx.soundeffect, self);
  }

  if(isDefined(var_0.sfx.herodialog)) {
    var_1 = !isDefined(var_0.sfx.villaindialog) || brolaride_isplayerteamhero();
    var_2 = scripts\engine\utility::ter_op(var_1, var_0.sfx.herodialog, var_0.sfx.villaindialog);
    var_3 = 1;
    var_4 = scripts\engine\utility::ter_op(var_1, "bchr", "mndz");
    brolaride_brleaderdialog(var_2, var_3, var_4);
    return;
  }
}

function brolaride_brleaderdialog(var_0, var_1, var_2) {
  thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var_0, self, 1, 1, var_1, undefined, var_2);
}

function brolaride_isplayerteamhero() {
  var_0 = scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.heromatchpoints[self.team]), level.disable_super_in_turret.heromatchpoints[self.team], 0);
  var_1 = scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.villainmatchpoints[self.team]), level.disable_super_in_turret.villainmatchpoints[self.team], 0);
  return var_0 >= var_1;
}

function brolaride_getinfosforexplosion() {
  foreach(var_1 in level.olaridemeter.states) {
    if(level.olaridemeter.percentage >= var_1.percentage) {
      return var_1;
    }
  }
}

function brolaride_volcanicactivity() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  var_0 = 0;
  level.volcanicactivitystarted = 0;

  for(;;) {
    var_1 = brolaride_getinfosforexplosion();

    if(var_1.delay > 0) {
      if(level.volcanicactivitystarted == 0) {
        scripts\mp\gametypes\br_publicevent_fafir::volcanoexplode(0, 7);
        level.volcanicactivitystarted = 1;
      } else if(var_0 >= var_1.delay) {
        scripts\mp\gametypes\br_publicevent_fafir::volcanoexplode(var_1.toxicbombcount, var_1.cosmeticbombcount);
        var_0 = 0;
      } else {
        var_0 += 1;
      }
    }

    wait 1;
  }
}

function branalytics_doomstationstate(var_0) {
  var_1 = [];
  var_1[var_1.size] = "state";
  var_1[var_1.size] = var_0;
  getentitylessscriptablearray("dlog_event_doomstation_usage", var_1);
}

function initdoomstation() {
  if(!isDefined(level.hvv_data)) {
    level.hvv_data = spawnStruct();
  }

  level.doomstationinfo = spawnStruct();
  level.doomstationinfo.spawnpositonarray = [(15151.3, 9648.25, 7284.75), (30728.4, 15641.3, 2475.4), (13458.5, 5504.68, 6313.83), (3233.25, 10919.5, 5737.25), (2385.75, 3470.75, 3352.75), (17519, 15425, 6295.75), (20405, 24465.3, 4507.5)];
  level.doomstationinfo.spawnanglearray = [(0, 311.017, 0), (0, 90, 0), (0, 185.806, 0), (0, 49.8552, 0), (0, 176.498, 0), (0, 22.0244, 0), (0, 323.693, 0)];
  level.doomstationinfo.helispawnposition = [(26360, 2550, 20500), (26360, 2550, 20500), (3341, 4673, 20500), (3341, 4673, 20500), (-4149, 4135, 20500), (28634, 20711.6, 20500), (28634, 20711.6, 20500)];
  level.doomstationinfo.price = getdvarint("scr_br_doomstation_price", 10000);
  level.doomstationinfo.timer = getdvarint("scr_br_doomstation_timer", 60);
  level.doomstationinfo.deactivatetimer = getdvarint("scr_br_doomstation_deactivate_timer", 30);
  level.doomstationinfo.progressradius = getdvarint("scr_br_doomstation_progress_radius", 1000);
  level.doomstationinfo.showradius = getdvarint("scr_br_doomstation_show_radius", 3000);
  level.doomstationinfo.startedshowradius = getdvarint("scr_br_doomstation_started_show_radius", 7000);
  level.doomstationinfo.triggerheight = getdvarint("scr_br_doomstation_trigger_height", 3000);
  level.doomstationinfo.splashradius = getdvarint("scr_br_doomstation_splash_dist", 7000);
  level.doomstationinfo.fadedistance = getdvarint("scr_br_doomstation_fade_distance", 500);
  level.doomstationinfo.progress = 0;
  level.doomstationinfo.deactivateprogress = 0;
  level.doomstationinfo.progressdelay = getdvarint("scr_br_doomstation_progress_delay", 3);
  level.doomstationinfo.hideprogresstimer = getdvarint("scr_br_doomstation_hide_progress_timer", 5);
  level.doomstationinfo.shakedelay = getdvarfloat("scr_br_doomstation_shake_delay", 6.5);
  level.doomstationinfo.shakeintensity = getdvarfloat("scr_br_doomstation_shake_intensity", 0.2);
  level.doomstationinfo.shakeduration = getdvarfloat("scr_br_doomstation_shake_duration", 5);
  level.doomstationinfo.shakeradius = getdvarint("scr_br_doomstation_shake_radius", 20000);
  level.doomstationinfo.shakewave1start = getdvarfloat("scr_br_doomstation_shake_wave1_start", 13.27);
  level.doomstationinfo.shakewave2start = getdvarfloat("scr_br_doomstation_shake_wave2_start", 9.27);
  level.doomstationinfo.shakewavefrequence = getdvarfloat("scr_br_doomstation_shake_wave_delay", 10);
  level.doomstationinfo.shakewavedelay = getdvarfloat("scr_br_doomstation_shake_wave_delay", 1);
  level.doomstationinfo.shakewaveintensity = getdvarfloat("scr_br_doomstation_shake_wave_intensity", 0.1);
  level.doomstationinfo.shakewaveduration = getdvarfloat("scr_br_doomstation_shake_wave_duration", 1);
  level.doomstationinfo.shakewaveradius = getdvarint("scr_br_doomstation_shake_wave_radius", 3000);
  level.doomstationinfo.rewarddelay = getdvarint("scr_br_doomstation_reward_delay", 4);
  level.doomstationinfo.playersinradius = [];
  level.doomstationinfo.playerswatching = [];
  level.doomstationinfo.started = 0;
  level.doomstationinfo.ref_13606 = (0, 0, 0);
  level.doomstationinfo.spawnpos = (0, 0, 15000);
  level.doomstationinfo.endpoint = (0, 0, 850);
  level.doomstationinfo.agentstospawn = 8;
  level.doomstationinfo.new_rider_combat_logic = [];
  level.doomstationinfo.heli = [];
  level.doomstationinfo.agentsmaxhealth = getdvarint("scr_br_doomstation_AI_max_health", 200);
  level.doomstationinfo.agentsarmor = getdvarint("scr_br_doomstation_AI_armor_value", 300);
  level.doomstationinfo.agentsaccuracy = getdvarfloat("scr_br_doomstation_AI_accuracy_value", 0.7);
  level.doomstationinfo.ammodropchance = getdvarfloat("scr_br_doomstation_AI_ammo_drop_chance", 0.9);
  level._effect["vfx_br3_doom_shockwave"] = loadfx("vfx/iw8_br/island/gameplay/doom/vfx_br3_doom_shockwave.vfx");
  game["dialog"]["doomstation_ownTeam"] = "trials_doomstation_begin_friendly";
  game["dialog"]["doomstation_enemyTeam"] = "trials_doomstation_begin_enemy";
  game["dialog"]["doomstation_failure"] = "trials_doomstation_failure";
  game["dialog"]["doomstation_proximity"] = "trials_doomstation_proximity";
  game["dialog"]["doomstation_success"] = "trials_doomstation_success";
  spawndoomstation();
  thread activatedoomstation();
}

function spawndoomstation() {
  var_0 = createdoomstation();
  level.doomstationinfo.endpoint = var_0.origin + (0, 0, 850);
  level.doomstation = var_0;
}

function createdoomstation() {
  if(level.mapname == "mp_br_mechanics") {
    return easepower("br_doomstation", (2500, -2600, 0));
  }

  if(level.mapname == "mp_wz_island") {
    var_0 = 1;
    var_1 = getdvarint("scr_br_doomstation_spawn_pos_force", -1);
    var_2 = strtok(getDvar("scr_br_doomstation_spawn_pos_list", ""), ",");

    if(var_1 != -1) {
      var_3 = var_1;
      var_0 = 0;
    } else if(var_3.size > 0) {
      var_3 = int(var_3[randomint(var_3.size)]);
    } else {
      var_3 = randomint(level.doomstationinfo.spawnpositonarray.size);
    }

    level.doomstationinfo.spawnpos = level.doomstationinfo.helispawnposition[var_3];
    level.doomstationinfo.obs_id = createnavobstaclebybounds(level.doomstationinfo.spawnpositonarray[var_3], (20, 80, 32), level.doomstationinfo.spawnanglearray[var_3]);
    return easepower("br_doomstation", level.doomstationinfo.spawnpositonarray[var_3], level.doomstationinfo.spawnanglearray[var_3]);
  }

  var_4 = getentitylessscriptablearrayinradius("scriptable_br_doomstation", "classname");
  return undefined;
}

function doomstation_reset() {
  level.doomstationinfo.progress = 0;
  level.doomstationinfo.deactivateprogress = 0;
  level.doomstationinfo.playersinradius = [];
  level.doomstationinfo.playerswatching = [];
  level.doomstationinfo.new_rider_combat_logic = [];
  level.doomstationinfo.heli = [];
  level.doomstationinfo.started = 0;
  level.doomstation.useprompt.inuse delete();
  level.doomstation.useprompt delete();

  if(isDefined(level.doomstation.objid)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.doomstation.objid);
    scripts\mp\objidpoolmanager::returnobjectiveid(level.doomstation.objid);
  }

  activatedoomstation();
}

function activatedoomstation() {
  level endon("game_ended");
  waitframe();
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  var_0 = level.doomstation;
  var_1 = var_0.origin + (0, 0, 50);
  var_0 setscriptablepartstate("br_doomstation", "active");
  var_0.useprompt = scripts\mp\gameobjects::createhintobject(var_1, "HINT_BUTTON", undefined, &"MP_BR_INGAME_TU_WZ350/PURCHASE_BR_DOOMSTATION_ENABLED", undefined, undefined, undefined, 0, 0, 100, -1);
  var_0.useprompt.inuse = scripts\mp\gameobjects::createhintobject(var_1, "HINT_BUTTON", undefined, &"MP_BR_INGAME_TU_WZ350/PURCHASE_BR_DOOMSTATION_DISABLED", undefined, undefined, undefined, 0, 0, 100, -1);
  var_0.useprompt sethintstringparams(level.doomstationinfo.price);
  var_0.useprompt.inuse sethintstringparams(level.doomstationinfo.price);
  thread doomstation_managepromptinteraction(var_0);
  thread doomstation_manageredpromptinteraction(var_0);
  var_0.triggerorigin = var_0.origin - (0, 0, level.doomstationinfo.triggerheight / 2);
  var_0.trigger = spawn("trigger_radius", var_0.triggerorigin, 0, int(level.doomstationinfo.showradius), int(level.doomstationinfo.triggerheight));
  scripts\mp\utility\trigger::makeenterexittrigger(var_0.trigger, &doomstation_triggerenter);
  var_0.objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  scripts\mp\objidpoolmanager::objective_add_objective(var_0.objid, "current");
  objective_setbackground(var_0.objid, 1);
  objective_icon(var_0.objid, "ui_mp_br_doom_activate");
  objective_setminimapiconsize(var_0.objid, "icon_regular");
  function_0421(var_0.objid, 1);
  getbnetigrbattlepassxpmultiplier(var_0.objid, level.doomstationinfo.showradius, level.doomstationinfo.showradius + level.doomstationinfo.fadedistance);
  objective_removeallfrommask(var_0.objid);
  objective_position(var_0.objid, var_0.origin + (0, 0, 70));
  objective_setlabel(var_0.objid, &"MP_BR_INGAME_TU_WZ350/BR_DOOMSTATION_UNKNOWN_OBJECTIVE_LABEL");
  level.doomstationinfo.rewarditems = [["brloot_killstreak_auav", 1], ["brloot_killstreak_circle_peek", 1], ["brloot_specialist_bonus", scripts\mp\gametypes\br_public::replace_sat_piece_on_deathordisconnect()]];
  scripts\mp\gametypes\br_plunder::registerpostplundercallback(&doomstationpostplunder);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "shouldPingDisableObjectiveIntro", &brdoomstationmode_shouldpingdisableobjectiveintro);
  doomstation_playersupdatestructure();
}

function doomstation_playerupdateaffordablestate(var_0) {
  var_1 = int(level.doomstationinfo.price / 100);

  if(isDefined(self.plundercount) && self.plundercount >= var_1) {
    var_0 enableplayeruse(self);
    var_0.inuse disableplayeruse(self);
    return;
  }

  if(!isDefined(self.plundercount) || self.plundercount < var_1) {
    var_0 disableplayeruse(self);
    var_0.inuse enableplayeruse(self);
    return;
  }
}

function doomstation_playersupdatestructure() {
  foreach(var_1 in level.players) {
    thread doomstation_playerupdateaffordablestate(var_1);
  }
}

function doomstation_managepromptinteraction(var_0) {
  level endon("game_ended");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(doomstation_canstartusing(var_1)) {
      var_2 = int(level.doomstationinfo.price / 100);
      var_1 scripts\mp\gametypes\br_plunder::playersetplundercount(var_1.plundercount - var_2);
      level.doomstationinfo.starterteam = var_1.team;
      level.doomstationinfo.started = 1;
      level.doomstation setscriptablepartstate("br_doomstation", "earthquake");
      doomstation_disablepromptuse(var_0);
      getbnetigrbattlepassxpmultiplier(level.doomstation.objid, level.doomstationinfo.startedshowradius, level.doomstationinfo.startedshowradius + level.doomstationinfo.fadedistance);
      objective_setlabel(level.doomstation.objid, &"MP_BR_INGAME_TU_WZ350/BR_DOOMSTATION_OBJECTIVE_LABEL");
      level.doomstation.trigger delete();
      level.doomstation.trigger = spawn("trigger_radius", level.doomstation.triggerorigin, 0, int(level.doomstationinfo.startedshowradius), int(level.doomstationinfo.triggerheight));
      scripts\mp\utility\trigger::makeenterexittrigger(level.doomstation.trigger, &doomstation_triggerenter);
      level.doomstation.progresstrigger = spawn("trigger_radius", level.doomstation.triggerorigin, 0, int(level.doomstationinfo.progressradius), int(level.doomstationinfo.triggerheight));
      scripts\mp\utility\trigger::makeenterexittrigger(level.doomstation.progresstrigger, &doomstation_progresstriggerenter, &doomstation_progresstriggerexit);
      thread startshake(level.doomstationinfo.shakeintensity, level.doomstationinfo.shakeduration, level.doomstationinfo.shakedelay, level.doomstation.origin, level.doomstationinfo.shakeradius);
      thread startshakewave(level.doomstationinfo.shakewave1start, level.doomstationinfo.shakewavefrequence, level.doomstationinfo.shakewaveintensity, level.doomstationinfo.shakewaveduration, level.doomstationinfo.shakewavedelay, level.doomstation.origin, level.doomstationinfo.shakewaveradius);
      thread startshakewave(level.doomstationinfo.shakewave2start, level.doomstationinfo.shakewavefrequence, level.doomstationinfo.shakewaveintensity, level.doomstationinfo.shakewaveduration, level.doomstationinfo.shakewavedelay, level.doomstation.origin, level.doomstationinfo.shakewaveradius);
      doomstation_displayactivationbanners(var_1);
      thread doomstation_watchprogress();
      scripts\mp\gametypes\br_quest_util::ref_140B1(level.doomstation.origin, "doomstation");
      thread doomstation_chopperstart(level);
      branalytics_doomstationstate("activated");
    }
  }
}

function doomstation_displayactivationbanners(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0.team, "players");

  foreach(var_0 in var_1) {
    if(isDefined(var_0)) {
      var_0 thread scripts\mp\utility\points::giveunifiedpoints("br_doomstation_activation");
      var_0 scripts\mp\hud_message::showsplash("br_doomstation_friendly_activation");
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("doomstation_ownTeam", var_0, 1);
    }
  }

  var_4 = level.players;

  if(isDefined(var_1)) {
    var_4 = scripts\engine\utility::array_remove_array(var_4, var_1);
  }

  var_5 = level.doomstationinfo.splashradius;

  foreach(var_7 in var_4) {
    if(isDefined(var_7)) {
      var_8 = distance2d(var_7.origin, self.origin);

      if(var_8 <= var_5) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.doomstation.objid, var_7);
        var_7 scripts\mp\hud_message::showsplash("br_doomstation_enemy_activation");
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward("doomstation_enemyTeam", var_7, 1);
      }
    }
  }
}

function doomstation_manageredpromptinteraction(var_0) {
  level endon("game_ended");

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_0 playsoundtoplayer("ui_screen_edge_deny", var_1);
  }
}

function doomstation_disablepromptuse(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_0 disableplayeruse(var_2);
      var_0.inuse disableplayeruse(var_2);
    }
  }
}

function doomstation_canstartusing(var_0, var_1) {
  if(istrue(level.gameended)) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_0.inlaststand)) {
    return false;
  }

  if(var_0 scripts\cp_mp\utility\player_utility::isusingremote()) {
    return false;
  }

  if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(istrue(var_0.iscarrying) && !isDefined(var_0.get_search_turret_target_player)) {
    var_0 scripts\mp\hud_message::showerrormessage("MP/FIELD_UPGRADE_CANNOT_USE");
    return false;
  }

  var_2 = int(level.doomstationinfo.price / 100);

  if(var_0.plundercount < var_2) {
    return false;
  }

  return true;
}

function doomstation_triggerenter(var_0, var_1) {
  if(isPlayer(var_0)) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.doomstation.objid, var_0);
    var_2 = level.doomstation getscriptablepartstate("br_doomstation");

    if(var_2 != "active") {
      return;
    }

    scripts\mp\gametypes\br_public::dmztut_endgamewithreward("doomstation_proximity", var_0);
    return;
  }
}

function doomstation_progresstriggerenter(var_0, var_1) {
  var_0 notify("progress_trigger_entered");

  if(isPlayer(var_0)) {
    level.doomstationinfo.playersinradius[level.doomstationinfo.playersinradius.size] = var_0;
    level.doomstationinfo.playerswatching[level.doomstationinfo.playerswatching.size] = var_0;
    return;
  }
}

function doomstation_progresstriggerexit(var_0, var_1) {
  if(isPlayer(var_0)) {
    level.doomstationinfo.playersinradius = scripts\engine\utility::array_remove(level.doomstationinfo.playersinradius, var_0);
    var_2 = var_0 scripts\engine\utility::ref_143B9(level.doomstationinfo.hideprogresstimer, "progress_trigger_entered");

    if(var_2 == "timeout") {
      level.doomstationinfo.playerswatching = scripts\engine\utility::array_remove(level.doomstationinfo.playerswatching, var_0);
      var_0 setclientomnvar("ui_securing", 0);
      return;
    }

    return;
  }
}

function doomstation_isprogressing() {
  foreach(var_1 in level.doomstationinfo.playersinradius) {
    if(!isDefined(var_1)) {
      level.doomstationinfo.playersinradius = scripts\engine\utility::array_remove(level.doomstationinfo.playersinradius, var_1);
    }
  }

  return level.doomstationinfo.playersinradius.size > 0;
}

function doomstation_watchprogress() {
  level endon("game_ended");
  wait level.doomstationinfo.progressdelay;

  for(var_0 = 1; var_0; var_0 = 0) {
    waitframe();

    if(doomstation_isprogressing()) {
      level.doomstationinfo.deactivateprogress = 0;
      level.doomstationinfo.progress += level.framedurationseconds;
      var_1 = level.doomstationinfo.progress / level.doomstationinfo.timer;
      var_1 = scripts\engine\utility::ter_op(var_1 < 1, var_1, 1);
      objective_setprogress(level.doomstation.objid, var_1);

      foreach(var_3 in level.doomstationinfo.playerswatching) {
        if(isDefined(var_3) && isPlayer(var_3) && isalive(var_3) && !istrue(var_3.usedprops) && !istrue(var_3.beingrevived) && !istrue(var_3.isreviving)) {
          if(scripts\engine\utility::array_contains(level.doomstationinfo.playersinradius, var_3)) {
            var_3 setclientomnvar("ui_securing", 25);
          } else {
            var_3 setclientomnvar("ui_securing", 26);
          }

          var_3 setclientomnvar("ui_securing_progress", var_1);
        }
      }
    } else {
      level.doomstationinfo.deactivateprogress += level.framedurationseconds;

      foreach(var_3 in level.doomstationinfo.playerswatching) {
        if(isDefined(var_3) && isPlayer(var_3) && isalive(var_3) && !istrue(var_3.usedprops) && !istrue(var_3.beingrevived) && !istrue(var_3.isreviving)) {
          var_3 setclientomnvar("ui_securing", 27);
        }
      }
    }

    if(level.doomstationinfo.progress >= level.doomstationinfo.timer) {
      doomstation_openstation();
      var_0 = 0;
    }

    if(level.doomstationinfo.deactivateprogress >= level.doomstationinfo.deactivatetimer) {
      doomstation_failprogress();
    }
  }

  level notify("stop_shake_waves");
  level.doomstation.trigger delete();
  level.doomstation.progresstrigger delete();
  wait 1;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.doomstation.objid);

  foreach(var_3 in level.doomstationinfo.playersinradius) {
    if(isDefined(var_3) && !istrue(var_3.usedprops) && !istrue(var_3.beingrevived) && !istrue(var_3.isreviving)) {
      var_3 setclientomnvar("ui_securing", 0);
      var_3 setclientomnvar("ui_securing_progress", 0);
    }
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(level.doomstation.objid);
  level.doomstation.objid = undefined;
}

function doomstation_openstation() {
  doomstation_playvoinradius("doomstation_success", level.doomstation.origin, level.doomstationinfo.splashradius);
  scripts\mp\gametypes\br_quest_util::look_at_heli("br_doomstation_secured", level.doomstation.origin, level.doomstationinfo.splashradius);
  thread startshake(level.doomstationinfo.shakeintensity, level.doomstationinfo.shakeduration, level.doomstationinfo.shakedelay, level.doomstation.origin, level.doomstationinfo.shakeradius);
  level.doomstation setscriptablepartstate("br_doomstation", "opening");
  thread doomstation_chopperflee(level);
  thread doomstation_givereward();
  branalytics_doomstationstate("complete");
}

function doomstation_givereward() {
  level endon("game_ended");
  wait level.doomstationinfo.rewarddelay;
  var_0 = scripts\mp\utility\player::getplayersinradius(level.doomstation.origin, level.doomstationinfo.progressradius);

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 thread scripts\mp\utility\points::giveunifiedpoints("br_doomstation_success");

      if(var_2.team == level.doomstationinfo.starterteam) {
        var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_12004("doom_watch");
        level.doomstation.useprompt playsoundtoplayer("doom_station_unique_reward", var_2, var_2);
      }
    }
  }

  level.doomstationinfo.itemsdropped = 0;
  var_4 = level.doomstationinfo.rewarditems;
  var_5 = spawnStruct();
  var_5.origin = level.doomstation.origin;
  var_5.angles = level.doomstation.angles;
  var_5.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_5.dropstruct.ml_p3_to_safehouse_transition = 20;
  var_5.dropstruct.silencer_pick_up_monitor = 40;
  var_6 = level.doomstation.angles + (0, 135, 0);

  foreach(var_8 in var_4) {
    var_9 = var_8[0];
    var_10 = var_8[1];

    if(scripts\mp\gametypes\br_lootcache::get_bonus_targets(var_9)) {
      for(var_11 = 0; var_11 < var_10; var_11++) {
        var_12 = scripts\mp\gametypes\br_lootcache::ref_11A41(var_9, var_5.dropstruct, var_5.origin + (0, 0, var_5.dropstruct.silencer_pick_up_monitor), var_6, 0, 0);
        level.doomstationinfo.itemsdropped++;
        waitframe();
      }
    }

    wait 0.5;
  }
}

function doomstation_failprogress() {
  doomstation_playvoinradius("doomstation_failure", level.doomstation.origin, level.doomstationinfo.splashradius);
  scripts\mp\gametypes\br_quest_util::look_at_heli("br_doomstation_failure", level.doomstation.origin, level.doomstationinfo.splashradius);
  level.doomstation setscriptablepartstate("br_doomstation", "deactivated");
  thread doomstation_chopperflee(level);
}

function doomstation_playvoinradius(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\player::getplayersinradius(var_1, var_2);

  foreach(var_5 in var_3) {
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var_0, var_5, 1);
  }
}

function brdoomstationmode_shouldpingdisableobjectiveintro(var_0) {
  if(isDefined(level.doomstation.objid)) {
    return (var_0 != level.doomstation.objid);
  }

  return true;
}

function doomstation_chopperstart(var_0) {
  level endon("game_ended");

  if(level.mapname == "mp_br_mechanics") {
    return;
  }

  var_1 = [(0, 800, 450), (800, 0, 0), (-800, 0, 0)];

  for(var_2 = 0; var_2 < 3; var_2++) {
    var_3 = level.doomstationinfo.spawnpos + var_1[var_2];
    var_4 = level.doomstationinfo.endpoint + var_1[var_2];
    var_5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_3, level.doomstationinfo.ref_13606, "veh_apache_doomsday_station_mp", "veh8_mil_air_mindia8_mercenary_extraction_s5");
    level.doomstationinfo.heli = scripts\engine\utility::array_add(level.doomstationinfo.heli, var_5);
    var_5 setmaxpitchroll(10, 25);
    var_5 vehicle_setspeed(90, 275);
    var_5 sethoverparams(10, 100, 40);
    var_5 setturningability(0.05);
    var_5 setyawspeed(45, 25, 25, 0.5);
    var_5 setvehgoalpos(var_4, 1);
    var_5 unmarkkeyframedmover(1);
  }

  var_6 = 360 / level.doomstationinfo.agentstospawn;
  var_7 = anglesToForward(level.doomstationinfo.ref_13606);
  var_8 = level.doomstationinfo.agentstospawn + level.doomstationinfo.playersinradius.size;

  for(var_2 = 0; var_2 < var_8; var_2++) {
    wait 2;
    var_9 = var_6 * var_2;
    var_10 = var_6 * (var_2 + 1);
    var_11 = randomfloatrange(var_9, var_10);
    var_12 = 350;
    var_13 = 450;
    var_14 = randomfloatrange(var_12, var_13);
    var_15 = vectorNormalize(rotatevector(var_7, (0, var_11, 0)));
    var_16 = level.doomstationinfo.endpoint + var_15 * var_14;
    var_16 = getclosestpointonnavmesh(var_16);
    var_17 = doomstation_spawnagent(var_16, (0, 0, 180), 1, "actor_enemy_lw_br");
    level.doomstationinfo.new_rider_combat_logic = scripts\engine\utility::array_add(level.doomstationinfo.new_rider_combat_logic, var_17);
  }
}

function doomstation_spawnagent(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.is_parachute_spawner = 1;
  var_5 = _testing_ending::spawnnewparachuteagent(var_0, var_1, 1, var_3);

  if(!isDefined(var_5)) {
    return;
  }

  var_5.move_closest_chopper_boss_vandalize_node_down = 1;
  var_6 = spawn("trigger_radius", level.doomstation.origin + (0, 0, -30), 0, 500, 500);
  var_5 setgoalvolumeauto(var_6);
  var_5 _testing_ending::ammobox_getbufferedattachmentsourceweapon();
  var_5 _testing_ending::ref_13122(level.doomstationinfo.agentsaccuracy);
  var_5 _testing_ending::setagentmaxhealth(level.doomstationinfo.agentsmaxhealth);
  var_5 thread _testing_ending::alwaysdoskyspawnontacinsert();
  var_5 thread _testing_ending::activeparachutersfactionvo();
  var_5 thread _testing_ending::activestate();
  thread doomstation_agentondeath();
  var_5.maxsightdistsqrd = 16000000;

  if(var_2) {
    var_5 _testing_ending::scriptable_token_scriptable_touched_callback(level.doomstationinfo.agentsarmor);
  }

  return var_5;
}

function doomstation_agentondeath() {
  self endon("game_ended");
  self waittill("death", var_0);
  level.doomstationinfo.new_rider_combat_logic = scripts\engine\utility::array_remove(level.doomstationinfo.new_rider_combat_logic, self);

  if(level.doomstationinfo.new_rider_combat_logic.size == 0) {
    thread doomstation_chopperflee(level);
  }

  if(randomfloat(1) > level.doomstationinfo.ammodropchance) {
    return;
  }

  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_1.itemsdropped = 0;
  var_1 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "ammo");
}

function doomstation_chopperflee(var_0) {
  level endon("game_ended");

  if(level.doomstationinfo.heli.size == 0) {
    return;
  }

  var_1 = level.doomstation getscriptablepartstate("br_doomstation");
  var_2 = 0;

  if(!var_0 && var_1 != "opening" && var_1 != "open") {
    level.doomstationinfo.heli[0] setvehgoalpos(level.doomstationinfo.endpoint + (0, 0, 450), 1);
    var_2 = 1;
  }

  var_3 = [];

  for(var_4 = var_2; var_4 < level.doomstationinfo.heli.size; var_4++) {
    var_5 = level.doomstationinfo.heli[var_4];
    var_3 = var_5;
    var_5 vehicle_setspeed(45, 137.5);
    var_5 setvehgoalpos((0, 0, 40000), 1);
    wait 2;
  }

  level.doomstationinfo.heli[var_2] waittill("goal");

  if(level.doomstation getscriptablepartstate("br_doomstation") == "open") {
    var_2 = 0;
  }

  for(var_4 = level.doomstationinfo.heli.size - 1; var_4 >= var_2; var_4--) {
    doomstation_chopperdelete(level.doomstationinfo.heli[var_4]);
    level.doomstationinfo.heli[var_4] = undefined;
  }

  level.doomstationinfo.heli = scripts\engine\utility::array_removeundefined(level.doomstationinfo.heli);
}

function doomstation_chopperdelete(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(var_0);
}

function doomstationpostplunder(var_0) {
  if(playerplunderupdatedoomstation(var_0)) {
    thread doomstation_playerupdateaffordablestate(level.doomstation.useprompt);
    return;
  }
}

function playerplunderupdatedoomstation(var_0) {
  if(istrue(level.doomstationinfo.started)) {
    return 0;
  }

  var_1 = int(level.doomstationinfo.price / 100);

  if(!isDefined(var_0) || !isDefined(var_0.player)) {
    return 1;
  }

  if(var_0.player.plundercount >= var_1 && var_0.player.plundercount - var_0.ref_127B4 >= var_1) {
    return 0;
  }

  if(var_0.player.plundercount < var_1 && var_0.player.plundercount - var_0.ref_127B4 < var_1) {
    return 0;
  }

  return 1;
}

function spawnherovillaintoken(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_5 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_4, var_0, var_1, var_2, undefined, 0, 0);
  var_6 = var_5.origin + (0, 0, 25);
  var_7 = anglesToForward(var_1);

  if(!isDefined(var_3)) {
    var_3 = var_0;
  }

  var_5.origin = var_6 + 20 * var_7;
  var_8 = vectortoangles(var_5.origin - var_3);
  var_5.angles = (0, var_8[1], 0);
  var_5.ref_12223 = getscriptablereservedremaining(var_3 - (0, 0, 20), var_5.origin);
  var_9 = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_hvv_hero_token", var_5, 1, 1, undefined, 1);
  var_5.origin = var_6 - 20 * var_7;
  var_8 = vectortoangles(var_5.origin - var_3);
  var_5.angles = (0, var_8[1], 0);
  var_5.ref_12223 = getscriptablereservedremaining(var_3 - (0, 0, 20), var_5.origin);
  var_10 = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_hvv_villain_token", var_5, 1, 1, undefined, 1);
  var_9.tokentodelete = var_10;
  var_10.tokentodelete = var_9;
}

function takeherovillaintokenpickup(var_0) {
  if(issubstr(var_0.scriptablename, "hvv_hero_token")) {
    thread scripts\mp\utility\points::giveunifiedpoints("br_heroContribution");
    giveheropoints(getdvarint("scr_br_hvv_token_points_pickup", 100));

    if(getdvarint("scr_br_enable_hvv_discounts", 0) > 0) {
      selectdiscountonhbundle(1);
    }

    self.lasthvvtoken = 1;
    scripts\mp\gametypes\br_public::brleaderdialog("hero_token_pickup_dialog", 1, [self], 1, 0, undefined, "bchr");
  } else if(issubstr(var_0.scriptablename, "hvv_villain_token")) {
    thread scripts\mp\utility\points::giveunifiedpoints("br_villainContribution");
    givevillainpoints(getdvarint("scr_br_hvv_token_points_pickup", 100));

    if(getdvarint("scr_br_enable_hvv_discounts", 0) > 0) {
      selectdiscountonvbundle(1);
    }

    self.lasthvvtoken = 2;
    scripts\mp\gametypes\br_public::brleaderdialog("villain_token_pickup_dialog", 1, [self], 1, 0, undefined, "mndz");
  }

  if(isDefined(var_0.tracknonoobplayerlocation) && isDefined(var_0.tracknonoobplayerlocation.tokentodelete)) {
    var_0.tracknonoobplayerlocation.tokentodelete scripts\mp\gametypes\br_pickups::lastgoodjobplayer();
    var_0.tracknonoobplayerlocation.tokentodelete = undefined;
    return;
  }
}

function arefactionpointsenabled() {
  return getdvarint("scr_br_enable_hvv_points", 0) > 0;
}

function loadplayerhvveventpoints() {
  if(isDefined(self.hvvplayerdata)) {
    return;
  }

  self.hvvplayerdata = spawnStruct();
  self.hvvplayerdata.pregameheropoints = 0;
  self.hvvplayerdata.pregamevillainpoints = 0;
  self.hvvplayerdata.gameheropoints = 0;
  self.hvvplayerdata.gamevillainpoints = 0;
  self.hvvplayerdata.totalheropoints = self.hvvplayerdata.pregameheropoints + self.hvvplayerdata.gameheropoints;
  self.hvvplayerdata.totalvillainpoints = self.hvvplayerdata.pregamevillainpoints + self.hvvplayerdata.gamevillainpoints;
  self waittill("joined_squad");
  self.hvvplayerdata.hvv_allegiance = getplayerhvvallegiance();
  updatehvvallegiancesquaddataomnvar(self.hvvplayerdata.hvv_allegiance);
}

function getplayerhvvallegiance() {
  if(self.hvvplayerdata.totalheropoints > self.hvvplayerdata.totalvillainpoints) {
    return 1;
  }

  if(self.hvvplayerdata.totalheropoints < self.hvvplayerdata.totalvillainpoints) {
    return 2;
  }

  return 0;
}

function updateplayerpointsomnvar() {
  updatehvvplayerpointsdataomnvar();
  updatehvvallegiancesquaddataomnvar(self.hvvplayerdata.hvv_allegiance);
}

function giveheropoints(var_0) {
  var_1 = arefactionpointsenabled();

  if(!var_1) {
    return false;
  }

  if(var_0 <= 0) {
    return false;
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_1301E("hvv_h", var_0);
  var_2 = self.hvvplayerdata.hvv_allegiance;
  self.hvvplayerdata.gameheropoints += var_0;
  self.hvvplayerdata.totalheropoints += var_0;
  self.hvvplayerdata.hvv_allegiance = getplayerhvvallegiance();
  updateplayerpointsomnvar();

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = self.hvvplayerdata.hvv_allegiance == 0;
  var_4 = var_2 != self.hvvplayerdata.hvv_allegiance;

  if(var_4 && !var_3) {
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("welcome_faction", self, 1, 0);
  }

  branalytics_hvvpoints(var_0, "hero");
  return true;
}

function givevillainpoints(var_0) {
  var_1 = arefactionpointsenabled();

  if(!var_1) {
    return false;
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_1301E("hvv_v", var_0);
  var_2 = self.hvvplayerdata.hvv_allegiance;
  self.hvvplayerdata.gamevillainpoints += var_0;
  self.hvvplayerdata.totalvillainpoints += var_0;
  self.hvvplayerdata.hvv_allegiance = getplayerhvvallegiance();
  updateplayerpointsomnvar();

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = self.hvvplayerdata.hvv_allegiance == 0;
  var_4 = var_2 != self.hvvplayerdata.hvv_allegiance;

  if(var_4 && !var_3) {
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("welcome_faction", self, 1, 0, undefined, undefined, "mndz");
  }

  branalytics_hvvpoints(var_0, "villain");
  return true;
}

function branalytics_hvvpoints(var_0, var_1) {
  var_2 = [];
  var_2[var_2.size] = "type";
  var_2[var_2.size] = var_1;
  var_2[var_2.size] = "amount";
  var_2[var_2.size] = var_0;
  self dlog_recordplayerevent("dlog_event_hvv_points_earned", var_2);
}

function updatehvvplayerpointsdataomnvar() {
  var_0 = int(self.hvvplayerdata.gameheropoints / 100);
  var_1 = int(self.hvvplayerdata.gamevillainpoints / 100);
  var_2 = self calloutmarkerping_entityzoffset("ui_br_hvv_points");
  var_2 = _calloutmarkerping_handleluinotify_added::repackomnvar(0, 12, var_2, var_0);
  var_2 = _calloutmarkerping_handleluinotify_added::repackomnvar(12, 12, var_2, var_1);
  self setclientomnvar("ui_br_hvv_points", var_2);
}

function updatehvvallegiancesquaddataomnvar(var_0) {
  var_1 = scripts\mp\gametypes\br_public::round_at_max(self.team, self.squadindex, "ui_br_hvv_points");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(self.pers["squadMemberIndex"]), self.pers["squadMemberIndex"] - 1, 0);
  var_3 = var_2 * 2;
  var_4 = _calloutmarkerping_handleluinotify_added::repackomnvar(var_3, 2, var_1, var_0);
  scripts\mp\gametypes\br_public::ref_131C3(self.team, self.squadindex, "ui_br_hvv_points", var_4);

  if(var_4 != var_1) {
    var_5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);
    var_3 = 24;

    foreach(var_7 in var_5) {
      if(!isDefined(var_7)) {
        continue;
      }

      var_7 _calloutmarkerping_handleluinotify_added::ref_1313E("ui_br_hvv_points", var_3, 8, var_4);
    }

    return;
  }
}

function brolaride_givematchpoint(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(isDefined(var_4)) {
      var_4 playlocalsound("hud_points_count");
      var_2 = var_4.team;
    }
  }

  if(!isDefined(var_2)) {
    return;
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.villainmatchpoints[var_2]), level.disable_super_in_turret.villainmatchpoints[var_2], 0);
  var_7 = scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.heromatchpoints[var_2]), level.disable_super_in_turret.heromatchpoints[var_2], 0);

  if(var_0) {
    var_7 += 1;
    level.disable_super_in_turret.heromatchpoints[var_2] = var_7;
  } else {
    var_6 += 1;
    level.disable_super_in_turret.villainmatchpoints[var_2] = var_6;
  }

  if(!isDefined(level.disable_super_in_turret.leadingteampointshero) || var_7 > level.disable_super_in_turret.leadingteampointshero) {
    level.disable_super_in_turret.leadingteampointshero = var_7;
  }

  if(!isDefined(level.disable_super_in_turret.leadingteampointsvillain) || var_6 > level.disable_super_in_turret.leadingteampointsvillain) {
    level.disable_super_in_turret.leadingteampointsvillain = var_6;
  }

  var_8 = int(max(level.disable_super_in_turret.leadingteampointshero, level.disable_super_in_turret.leadingteampointsvillain));
  var_9 = var_8 == level.disable_super_in_turret.leadingteampointsvillain;
  var_10 = var_8 == level.disable_super_in_turret.leadingteampointshero;
  level.disable_super_in_turret.arevillainsstrictlyleading = scripts\engine\utility::ter_op(var_9 && !var_10, 1, undefined);

  if(var_8 >= level.disable_super_in_turret.lastcallpoints && !istrue(level.disable_super_in_turret.islastcall)) {
    brolaride_triggerlastcall(var_10, var_2);
  }

  br_olaride_updateleaders(var_2, var_0, var_1);
  brolaride_updatevisionsets(var_8);
  brolaride_updatebombsitespawningradius(var_8);
  brolaride_updatebombsiteswantedcount(var_8);
  brolaride_updatemusicandambience(var_8);

  foreach(var_2 in level.teamnamelist) {
    brolaride_updateteamscore(var_2);
  }
}

function br_olaride_updateleaders(var_0, var_1, var_2) {
  if(br_olaride_isnewleader(var_0, var_1)) {
    level.disable_super_in_turret.objectiveleaders = [var_0];
    level.disable_super_in_turret.currentmaxscore = brolaride_getteamscore(var_0, var_1);
  } else if(brolaride_getteamscore(var_0, var_1) == level.disable_super_in_turret.currentmaxscore) {
    level.disable_super_in_turret.objectiveleaders = scripts\engine\utility::array_add(level.disable_super_in_turret.objectiveleaders, var_0);
  }

  if(istrue(level.disable_super_in_turret.objectiveleadersplashon)) {
    thread br_olaride_showleadersplash(var_0);
    return;
  }
}

function br_olaride_isnewleader(var_0, var_1) {
  if(brolaride_getteamscore(var_0, var_1) > level.disable_super_in_turret.currentmaxscore) {
    return true;
  } else if(level.disable_super_in_turret.objectiveleaders.size == 0 && brolaride_getteamscore(var_0, var_1) >= level.disable_super_in_turret.currentmaxscore) {
    level.disable_super_in_turret.objectiveleadersplashon = 1;
    return true;
  }

  return false;
}

function br_olaride_showleadersplash(var_0) {
  level endon("game_ended");
  wait 1;
  level.disable_super_in_turret.objectiveleadersplashon = undefined;
  ref_13372(var_0, "bm_vips_marked");
  showsplashtoteam(var_0, "bm_player_marked");
}

function brolaride_updateteamscore(var_0) {
  var_1 = scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.heromatchpoints[var_0]), level.disable_super_in_turret.heromatchpoints[var_0], 0);
  var_2 = scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.villainmatchpoints[var_0]), level.disable_super_in_turret.villainmatchpoints[var_0], 0);
  var_3 = max(var_1, var_2);
  var_4 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_5 = 0;
  var_6 = 0;
  var_7 = getteamscore(var_0);
  var_8 = 1;

  foreach(var_10 in var_4) {
    var_11 = scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.heromatchpoints[var_10]), level.disable_super_in_turret.heromatchpoints[var_10], 0);
    var_12 = scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.villainmatchpoints[var_10]), level.disable_super_in_turret.villainmatchpoints[var_10], 0);
    var_13 = max(var_11, var_12);

    if(var_11 > var_5) {
      var_5 = var_11;
    }

    if(var_12 > var_6) {
      var_6 = var_12;
    }

    if(var_13 > var_3 || var_13 == var_3 && getteamscore(var_10) > var_7) {
      var_8++;
    }
  }

  level.disable_super_in_turret.ref_13AB8[var_0] = var_8;
  updateolaridedataomnvar(var_0, var_1, var_2, var_5, var_6, var_8);
  brolaride_checkvictory(var_0, var_1 > var_2, var_3);
}

function brolaride_getteamscore(var_0, var_1) {
  if(var_1) {
    return scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.heromatchpoints[var_0]), level.disable_super_in_turret.heromatchpoints[var_0], 0);
  }

  return scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.villainmatchpoints[var_0]), level.disable_super_in_turret.villainmatchpoints[var_0], 0);
}

function brolaride_getteamplacement(var_0) {
  var_1 = max(brolaride_getteamscore(var_0, 1), brolaride_getteamscore(var_0, 0));
  var_2 = getteamscore(var_0);
  var_3 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_4 = 1;

  foreach(var_6 in var_3) {
    var_7 = max(brolaride_getteamscore(var_6, 1), brolaride_getteamscore(var_6, 0));

    if(var_7 > var_1 || var_7 == var_1 && getteamscore(var_6) > var_2) {
      var_4++;
    }
  }

  return var_4;
}

function updateolaridedataomnvar(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  if(!isDefined(var_6) || var_6.size == 0) {
    return;
  }

  var_7 = 0;
  var_1 = int(var_1) & 15;
  var_7 += var_1 << 0;
  var_2 = int(var_2) & 15;
  var_7 += var_2 << 4;
  var_3 = int(var_3) & 15;
  var_7 += var_3 << 8;
  var_4 = int(var_4) & 15;
  var_7 += var_4 << 12;
  var_5 = int(var_5) & 31;
  var_7 += var_5 << 16;
  var_8 = scripts\engine\utility::ter_op(istrue(level.disable_super_in_turret.islastcall), 1, 0);
  var_7 += var_8 << 21;

  foreach(var_10 in var_6) {
    if(isDefined(var_10)) {
      var_10 _calloutmarkerping_handleluinotify_added::ref_1313E("ui_br_olaride_points", 0, 22, var_7);
    }
  }
}

function brolaride_checkvictory(var_0, var_1, var_2) {
  if(var_2 < level.disable_super_in_turret.victorypoints) {
    return;
  }

  brolaride_endgame(var_0, var_1);
}

function brolaride_endgame(var_0, var_1) {
  if(isDefined(level.olaridegameended)) {
    return;
  }

  level.olaridegameended = 1;

  if(!isDefined(var_1)) {
    var_2 = scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.heromatchpoints[var_0]), level.disable_super_in_turret.heromatchpoints[var_0], 0);
    var_3 = scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.villainmatchpoints[var_0]), level.disable_super_in_turret.villainmatchpoints[var_0], 0);

    if(var_2 > 0 || var_3 > 0) {
      var_1 = var_2 > var_3;
    } else {
      var_4 = 0;
      var_5 = 0;
      var_6 = scripts\mp\utility\teams::getteamdata(var_0, "players");

      foreach(var_8 in var_6) {
        if(!isDefined(var_8) || !isDefined(var_8.hvvplayerdata)) {
          continue;
        }

        var_4 += var_8.hvvplayerdata.gameheropoints;
        var_5 += var_8.hvvplayerdata.gamevillainpoints;
      }

      if(var_4 > 0 || var_5 > 0) {
        var_1 = var_4 > var_5;
      } else {
        var_1 = 1;
      }
    }
  }

  foreach(var_8 in level.players) {
    if(isDefined(var_8)) {
      setplayerashvfxactive(var_8, 0);
      var_8 _calloutmarkerping_handleluinotify_added::ref_1313E("ui_br_olaride_points", 31, 1, var_1);
    }
  }

  var_6 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  foreach(var_8 in var_6) {
    if(!isDefined(var_8)) {
      continue;
    }

    if(var_1) {
      var_8 scripts\cp\vehicles\vehicle_compass_cp::ref_12004("hvv_ltm_w_h");
      continue;
    }

    var_8 scripts\cp\vehicles\vehicle_compass_cp::ref_12004("hvv_ltm_w_v");
  }

  var_14 = "";

  if(var_1) {
    var_14 = "Hero";
    scripts\mp\infilexfil\mp_br_ex_olaride::heroesexfil_init();
  } else {
    var_14 = "Villain";
    scripts\mp\infilexfil\mp_br_ex_olaride::villainsexfil_init();
    level.victorydialogvoiceoverride = "mndz";
  }

  getentitylessscriptablearray("dlog_event_hvv_victorious_faction", ["faction", var_14]);
  setteamscore(var_0, getteamscore(var_0) + level.disable_super_in_turret.onspawn_slowspeed);

  foreach(var_21, var_16 in level.teamdata) {
    if(!scripts\mp\utility\teams::isgameplayteam(var_21)) {
      continue;
    }

    var_17 = scripts\engine\utility::ter_op(isDefined(level.disable_super_in_turret.ref_13AB8[var_21]), level.disable_super_in_turret.ref_13AB8[var_21], brolaride_getteamplacement(var_21));
    thread scripts\mp\gametypes\br::ref_1209B(var_21, var_17, 0, 1, undefined, var_21 == var_0);

    if(var_21 == var_0) {
      continue;
    }

    var_18 = scripts\mp\utility\teams::getteamdata(var_21, "alivePlayers");

    if(var_18.size > 0) {
      foreach(var_8 in var_18) {
        if(isDefined(var_8)) {
          var_8.plotarmor = 1;
          var_8 freezecontrols(1);
          var_8 playerhide();

          if(isDefined(var_8.flare_thread) && var_8.flare_thread.size > 0) {
            var_8 scripts\mp\weapons::disableburnfx();
          }

          if(!var_8 isonground() && !var_8 isparachuting()) {
            var_8 skydive_deployparachute();
          }
        }
      }
    }
  }

  thread brolaride_postexfil();
  thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["objective_completed"], game["end_reason"]["objective_failed"], undefined, undefined, 1);
}

function brolaride_processlastcalltimer() {
  level endon("game_ended");
  level waittill("infils_ready");
  wait brolaride_getlastcalltimer();

  if(istrue(level.disable_super_in_turret.islastcall)) {
    return;
  }

  brolaride_updatemusicandambience(level.disable_super_in_turret.lastcallpoints);
  brolaride_triggerlastcall(undefined, undefined);
  var_0 = scripts\engine\utility::ter_op(istrue(level.disable_super_in_turret.islastcall), 1, 0);

  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2 _calloutmarkerping_handleluinotify_added::ref_1313E("ui_br_olaride_points", 21, 1, var_0);
    }
  }
}

function brolaride_getlastcalltimer() {
  var_0 = 0;
  var_1 = getdvarint("scr_br_last_call_trigger_circle", 3);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = level.br_level.br_circledelaytimes[var_2];

    if(isDefined(var_3)) {
      var_0 += var_3;
    }

    var_3 = level.br_level.br_circleclosetimes[var_2];

    if(isDefined(var_3)) {
      var_0 += var_3;
    }
  }

  var_4 = getdvarint("scr_br_last_call_trigger_time_before_circle_end", 120);
  var_0 = max(0, var_0 - var_4);
  return var_0;
}

function brolaride_triggerlastcall(var_0, var_1) {
  if(istrue(level.disable_super_in_turret.islastcall)) {
    return;
  }

  level.disable_super_in_turret.islastcall = 1;
  brolaride_createlastcallbombsites(var_0);
  brolaride_triggerlastcalldialog(var_1);
  brolaride_triggerlastcallsplash(var_1);
}

function brolaride_applylastcalldiscount(var_0) {
  if(getdvarint("scr_br_enable_hvv_discounts", 0) == 0) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = scripts\engine\utility::ter_op(var_0, "br_bomb", "br_defusekit");
  var_2 = _getidfromrefinpurchasetable(var_1);
  _sethvvlastcalldiscountid(var_2);
}

function brolaride_createlastcallbombsites(var_0) {
  var_1 = bombsite_getpossiblesites(0);

  if(var_1.size == 0) {
    return 0;
  }

  var_2 = getdvarint("scr_br_olaride_last_call_bomb_count", 3);

  if(!isDefined(var_0) && (var_2 & 1) == 1) {
    var_2++;
  }

  var_3 = bombsite_choosensitestoactivate(var_1, var_2);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(!isDefined(var_0)) {
      brolaride_activatelastcallbombsite(var_5, (var_4 & 1) == 1);
      continue;
    }

    if(var_0) {
      brolaride_activatelastcallbombsite(var_5, 0);
      continue;
    }

    brolaride_activatelastcallbombsite(var_5, 1);
  }

  return var_3.size;
}

function brolaride_activatelastcallbombsite(var_0) {
  bombsite_activate(self);

  if(!istrue(var_0)) {
    return;
  }

  var_1 = level.disable_super_in_turret.bombsite_lastcalltimer;
  bombsite_setupplantedbombsite(self, undefined, var_1);
  bombsite_setobjectiveasplanted(undefined);
}

function brolaride_triggerlastcalldialog(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");
  }

  var_2 = scripts\engine\utility::array_remove_array(level.players, var_1);
  scripts\mp\gametypes\br_public::brleaderdialog("last_call_leading_team_dialog", 1, var_1, 1, 1);
  scripts\mp\gametypes\br_public::brleaderdialog("last_call_other_team_dialog", 1, var_2, 1, 1);
}

function brolaride_triggerlastcallsplash(var_0) {
  if(isDefined(var_0)) {
    ref_13372(var_0, "br_olaride_overtime_them");
    showsplashtoteam(var_0, "br_olaride_overtime_us");
    return;
  }

  ref_13371("br_olaride_overtime_neutral");
}

function ammorestock_disableusefortime(var_0, var_1) {
  var_2 = max(brolaride_getteamscore(var_0, 1), brolaride_getteamscore(var_0, 0));
  var_3 = max(brolaride_getteamscore(var_1, 1), brolaride_getteamscore(var_1, 0));
  return var_2 >= var_3;
}

function kiosk_getscripteddiscount(var_0, var_1) {
  switch (var_0) {
    case 0:
      return _gethvvitemdiscount(var_1);
    case 1:
      return _gethvvbundlediscount(var_1);
    case 2:
      return _gethvvlastcalldiscount(var_1);
    default:
      return 0;
  }
}

function _gethvvitemdiscount(var_0) {
  var_1 = getDvar("br_kiosk_discounts_filename", "mp/br_hvv_kiosk_discounts.csv");

  if(var_1 == "") {
    return 0;
  }

  return int(_vlookup(var_1, 1, 3, var_0, 0));
}

function _gethvvbundlediscount(var_0) {
  return 50;
}

function _gethvvlastcalldiscount(var_0) {
  return 75;
}

function _getcurrenthbundleid() {
  return _getcurrentbundleid(["br_defusekit", "contribute_heroes"]);
}

function _getcurrentvbundleid() {
  return _getcurrentbundleid(["br_bomb", "contribute_villains"]);
}

function _getcurrentbundleid(var_0) {
  foreach(var_2 in var_0) {
    var_3 = _getidfromrefinpurchasetable(var_2);

    if(var_3 != -1) {
      return var_3;
    }
  }

  return -1;
}

function kiosk_initializecallbacks() {
  if(getdvarint("scr_br_enable_hvv_discounts", 0) > 0) {
    scripts\mp\gametypes\br_gametypes::ref_12B11("kiosk_onPlayerKilled", &kiosk_onplayerkilled);
    scripts\mp\gametypes\br_gametypes::ref_12B11("getScriptedDiscount", &kiosk_getscripteddiscount);
  }

  if(getdvarint("scr_br_enable_hvv_kiosk_items", 0) > 0) {
    scripts\mp\gametypes\br_gametypes::ref_12B11("kiosk_onPurchase", &kiosk_onpurchase);
    return;
  }
}

function kiosk_onpurchase(var_0, var_1) {
  if(var_1 == "contribute_heroes") {
    kiosk_onherocontribution(var_0, getdvarint("scr_br_hvv_kiosk_contribution_bundle", 200));
  } else if(var_1 == "br_defusekit") {
    kiosk_onherocontribution(var_0, getdvarint("scr_br_hvv_kiosk_contribution_item", 100));
  } else if(var_1 == "contribute_villains") {
    kiosk_onvillaincontribution(var_0, getdvarint("scr_br_hvv_kiosk_contribution_bundle", 200));
  } else if(var_1 == "br_bomb") {
    kiosk_onvillaincontribution(var_0, getdvarint("scr_br_hvv_kiosk_contribution_item", 100));
  }

  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, "type");
}

function kiosk_onplayerkilled(var_0) {
  removediscountonbundle(var_0);
}

function kiosk_onherocontribution(var_0) {
  giveheropoints(var_0);

  if(getdvarint("scr_br_enable_hvv_discounts", 0) > 0) {
    selectdiscountonhbundle(0);
    selectrandomscripteddiscountonkiosk(self.delay_kick_inactive_player);
  }

  scripts\mp\gametypes\br_public::brleaderdialog("hero_contribution_dialog", 1, [self], 1, 0, undefined, "bchr");
}

function kiosk_onvillaincontribution(var_0) {
  givevillainpoints(var_0);

  if(getdvarint("scr_br_enable_hvv_discounts", 0) > 0) {
    selectdiscountonvbundle(0);
    selectrandomscripteddiscountonkiosk(self.delay_kick_inactive_player);
  }

  scripts\mp\gametypes\br_public::brleaderdialog("villain_contribution_dialog", 1, [self], 1, 0, undefined, "mndz");
}

function selectdiscountonhbundle(var_0) {
  var_1 = _getcurrenthbundleid();
  _selectdiscountonbundle(var_0, var_1);
}

function selectdiscountonvbundle(var_0) {
  var_1 = _getcurrentvbundleid();
  _selectdiscountonbundle(var_0, var_1);
}

function _selectdiscountonbundle(var_0, var_1) {
  if(var_0) {
    _sethvvbundlediscountid(var_1);
    return;
  }

  var_2 = _gethvvbundlediscountid();

  if(var_1 == var_2) {
    removediscountonbundle();
    return;
  }
}

function removediscountonbundle() {
  _sethvvbundlediscountid(-1);
}

function selectrandomscripteddiscountonkiosk(var_0) {
  var_1 = _selectrandomref();

  if(var_1 == "") {
    return;
  }

  var_2 = _getidfromrefinpurchasetable(var_1);

  if(var_2 == -1) {
    return;
  }

  _sethvvitemdiscountid(var_2);
}

function _selectrandomref() {
  var_0 = getDvar("br_kiosk_discounts_filename", "mp/br_hvv_kiosk_discounts.csv");

  if(var_0 == "") {
    return "";
  }

  var_1 = _isfullsquadalive();
  var_2 = scripts\engine\utility::ter_op(var_1, "teamrevive", "");
  var_3 = "";

  for(;;) {
    var_4 = randomint(100);
    var_3 = scripts\engine\utility::string(_weightlookup(var_0, 2, 1, var_4, ""));

    if(var_3 != var_2) {
      return var_3;
    }
  }
}

function _isfullsquadalive() {
  var_0 = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(isalive(var_2)) {
      continue;
    }

    return false;
  }

  return true;
}

function _getidfromrefinpurchasetable(var_0) {
  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("getIdFromRefInPurchaseTable")) {
    return scripts\mp\gametypes\br_gametypes::ref_12E05("getIdFromRefInPurchaseTable", var_0);
  }

  return -1;
}

function _gethvvbundlediscountid() {
  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("getScriptedDiscountId")) {
    return scripts\mp\gametypes\br_gametypes::ref_12E05("getScriptedDiscountId", self, 1);
  }

  return -1;
}

function _sethvvitemdiscountid(var_0) {
  _setscripteddiscountid(self, 0, var_0);
}

function _sethvvbundlediscountid(var_0) {
  _setscripteddiscountid(self, 1, var_0);
}

function _sethvvlastcalldiscountid(var_0) {
  _setscripteddiscountid(undefined, 2, var_0);
}

function _setscripteddiscountid(var_0, var_1, var_2) {
  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("setScriptedDiscountId")) {
    scripts\mp\gametypes\br_gametypes::ref_12E06("setScriptedDiscountId", var_0, var_1, var_2);
    return;
  }
}

function _vlookup(var_0, var_1, var_2, var_3, var_4) {
  var_5 = tablelookupgetnumrows(var_0);
  var_6 = 0;

  while(var_6 < var_5) {
    var_7 = tablelookupbyrow(var_0, var_6, var_1);

    if(var_7 != scripts\engine\utility::string(var_3)) {} else {
      var_8 = tablelookupbyrow(var_0, var_6, var_2);
      return var_8;
    }

    var_7++;
  }

  return var_5;
}

function _weightlookup(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;
  var_6 = tablelookupgetnumrows(var_0);
  var_7 = 0;

  while(var_7 < var_6) {
    var_8 = int(tablelookupbyrow(var_0, var_7, var_1));
    var_5 += var_8;

    if(var_5 <= int(var_3)) {} else {
      var_9 = tablelookupbyrow(var_0, var_7, var_2);
      return var_9;
    }

    var_8++;
  }

  return var_5;
}

function ref_1458B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_0) && isDefined(var_0.targetname) && var_0.targetname == "trigger_multiple_lava") {
    return true;
  }

  return false;
}

function setuplavatriggers() {
  level endon("game_ended");
  wait 5;
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "weaponIgnoresBRArmor", &ref_1458B);
  var_0 = getEntArray("trigger_multiple_lava", "targetname");
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    var_3.touchingentities = [];
    thread watchlavatrigger(var_3);

    if(var_3.dmg >= 9999 && getdvarint("scr_br_lava_triggers_affect_vehicles", 1) > 0)
      thread watchvehiclecollisionwithlavatriggers(var_3, var_4 * 0.1);
  }
}

function watchlavatrigger(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!scripts\engine\utility::array_contains(var_0.touchingentities, var_1)) {
      thread handleentitytouchinglava(var_1, var_0);
    }
  }
}

function handleentitytouchinglava(var_0, var_1) {
  level endon("game_ended");
  var_1.touchingentities = scripts\engine\utility::array_add(var_1.touchingentities, var_0);
  var_2 = undefined;

  while(isDefined(var_0) && isalive(var_0) && var_0 istouching(var_1)) {
    var_3 = var_1.dmg;

    if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var_3 *= 5;
    }

    if(var_3 >= 9999 && isPlayer(var_0) && var_0 scripts\mp\utility\perk::_hasperk("specialty_blastshield")) {
      var_0 scripts\mp\utility\perk::removeperk("specialty_blastshield");
    }

    var_0 dodamage(var_3, var_0.origin, var_1, var_1, "MOD_FIRE");

    if(isPlayer(var_0) && !isDefined(var_2)) {
      var_2 = spawn("script_origin", var_0.origin);
      var_2 linkTo(var_0);
      var_2 playLoopSound("player_lava_burn_damage_loop");
    }

    if(isPlayer(var_0)) {
      var_0 playlocalsound("trigger_hurt_impact_plr");
    }

    wait 1;
  }

  if(isDefined(var_2)) {
    var_0 playlocalsound("player_lava_burn_damage_end");
    thread entitystoploopingsound(var_2, 0.15);
  }

  var_1.touchingentities = scripts\engine\utility::array_remove(var_1.touchingentities, var_0);
}

function entitystoploopingsound(var_0, var_1) {
  level endon("game_ended");
  wait var_1;

  if(isDefined(var_0)) {
    var_0 stoploopsound();
    wait 0.1;
    var_0 delete();
    return;
  }
}

function watchvehiclecollisionwithlavatriggers(var_0, var_1, var_2) {
  level endon("game_ended");
  wait var_2;

  while(var_1.size >= 1) {
    foreach(var_4 in var_1) {
      if(isDefined(var_4) && var_4 istouching(var_0)) {
        var_4 dodamage(var_0.dmg, var_4.origin, var_0, var_0, "MOD_FIRE");
      }
    }

    wait 1;
    var_1 = scripts\engine\utility::array_removeundefined(var_1);
  }
}

function getallvehiclesinstances() {
  var_0 = [];

  if(!isDefined(level.vehicle.instances)) {
    return var_0;
  }

  foreach(var_2 in level.vehicle.instances) {
    foreach(var_4 in var_2) {
      if(isDefined(var_4)) {
        var_0 = scripts\engine\utility::array_add(var_0, var_4);
      }
    }
  }

  return var_0;
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

function brolaride_initaudio() {
  scripts\mp\utility\sound::besttime("br_mode_olaride");
  level.ref_11E96 = 1;
  level.nosuspensemusic = 1;
  level.musicstate = 0;
}

function brolaride_updateendingmusicstate() {
  setmusicstate("");
  var_0 = level.players;

  foreach(var_2 in level.disable_super_in_turret.objectiveleaders) {
    var_3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_2);

    foreach(var_5 in var_3) {
      if(!isDefined(var_5)) {
        continue;
      }

      var_5 setplayermusicstate("br3_olaride_victory");
      var_0 = scripts\engine\utility::array_remove(var_0, var_5);
    }
  }

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }

    var_5 setplayermusicstate("br3_olaride_defeat");
  }
}

function brolaride_updatemusicandambience(var_0) {
  if(var_0 == level.disable_super_in_turret.victorypoints) {
    brolaride_updateendingmusicstate();
    level notify("matchCompleted");
    return;
  }

  if(var_0 <= level.musicstate) {
    return;
  } else {
    level.musicstate = var_0;
  }

  if(istrue(level.disable_super_in_turret.islastcallambswitchdone)) {
    return;
  }

  if(var_0 >= level.disable_super_in_turret.lastcallpoints) {
    setmusicstate("br3_olaride_last_stage_1");
    level notify("lastCall");
    brolaride_playloopingsound("amb_olaride_lastcall_storm_lr", "matchCompleted");
    level.disable_super_in_turret.islastcallambswitchdone = 1;
    return;
  }

  if(var_0 >= level.disable_super_in_turret.lastcallpoints - 1) {
    setmusicstate("br3_olaride_pre_last_stage_1");
    brolaride_playloopingsound("amb_olaride_stage3_storm_lr", "lastCall");
    return;
  }

  if(var_0 >= 3) {
    var_1 = ["br3_olaride_middle_stage_1", "br3_olaride_middle_stage_2", "br3_olaride_middle_stage_3", "br3_olaride_middle_stage_3"];
    setmusicstate(scripts\engine\utility::random(var_1));
    return;
  }

  if(var_0 >= 2) {
    setmusicstate("br3_olaride_second_stage_1");
    return;
  }

  if(var_0 >= 1) {
    setmusicstate("br3_olaride_first_stage_1");
    return;
  }
}

function brolaride_playloopingsound(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3) || !isDefined(var_0)) {
      continue;
    }

    var_4 = spawn("script_origin", var_3.origin + (0, 0, 50));
    var_4 linkTo(var_3);
    var_4 playLoopSound(var_0);

    if(!isDefined(var_1)) {
      continue;
    }

    thread brolaride_stoploopingsound(var_1, var_4);
  }
}

function brolaride_stoploopingsound(var_0, var_1) {
  level endon("game_ended");
  level waittill(var_0);
  var_1 stoploopsound();
  wait 0.1;
  var_1 delete();
}

function setplayerashvfxactive(var_0) {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(self.ash_vfx)) {
    stopfxontagforclients(scripts\engine\utility::getfx("vfx_br3_olaride_ashes_visionset"), self, "j_head", self);
    self.ash_vfx = undefined;
  }

  if(var_0) {
    self.ash_vfx = scripts\engine\utility::getfx("vfx_br3_olaride_ashes_visionset");
    playfxontagforclients(self.ash_vfx, self, "j_head", self);
    return;
  }
}

function startshake(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  wait var_2;
  earthquake(var_0, var_1, var_3, var_4);
  radiusdamage(var_3, var_4, 0.1, 0.05, undefined, "MOD_EXPLOSIVE", undefined, 1);
  var_5 = scripts\mp\utility\player::getplayersinradius(var_3, var_4);

  if(scripts\mp\flags::gameflag("br_ready_to_jump")) {
    foreach(var_7 in var_5) {
      if(isDefined(var_7)) {
        var_8 = 1 - clamp(distance2d(var_3, var_7.origin) / var_4, 0, 1);
        var_7 playsoundtoplayer("fafir_anticipation_earthquake_lr", var_7);
        var_7 setclientomnvar("ui_br_hvv_shake", var_8);
      }
    }

    wait var_1;

    foreach(var_7 in var_5) {
      if(isDefined(var_7)) {
        var_7 setclientomnvar("ui_br_hvv_shake", 0);
      }
    }

    return;
  }
}

function startshakewave(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("game_ended");
  level endon("stop_shake_waves");
  wait var_0;

  for(;;) {
    thread startshake(var_2, var_3, var_4, var_5, var_6);
    wait var_1;
  }
}

function brolaride_onplayerspawned() {
  if(istrue(level.gameended) || !istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  thread brolaride_playmatchvowhengrounded();
}

function brolaride_playmatchvowhengrounded() {
  self endon("death_or_disconnect");

  while(!self isonground()) {
    waitframe();
  }

  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("match_start", self);
}

function brolaride_postexfil() {
  level waittill("br_ending_start");
  scripts\engine\utility::waittill_any_ents(level.defendkill, "all_scenes_end");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && isalive(var_1)) {
      var_1 setOrigin((0, 0, 2900));
    }
  }
}