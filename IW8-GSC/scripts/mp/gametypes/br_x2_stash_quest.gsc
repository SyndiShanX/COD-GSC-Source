/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_x2_stash_quest.gsc
******************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("x2_stash", getdvarint("scr_br_x2stash_enabled", 1));

  if(!var_0) {
    return;
  }

  scripts\engine\scriptable::ref_12F5B("body", &ref_1466E);
  scripts\mp\gametypes\br_quest_util::getquestdata("x2_stash").ref_12FA0 = getdvarint("scr_br_x2_stash_searchCircleSize", 3000);
  scripts\mp\gametypes\br_quest_util::getquestdata("x2_stash").ref_11C4C = getdvarint("scr_br_x2_stash_missionTimeBase", 240);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("x2_stash", &ref_14671);
  scripts\mp\gametypes\br_quest_util::ref_12B2E("x2_stash", &ref_14670);
  scripts\mp\gametypes\br_quest_util::registerquestthink("x2_stash", &ref_1466C, 0.1);
  scripts\mp\gametypes\br_quest_util::ref_12B2D("x2_stash", &ref_1466D);
  scripts\mp\gametypes\br_quest_util::ref_12B30("x2_stash", &ref_14672);
  scripts\mp\gametypes\br_quest_util::ref_1297C("x2_stash", 0);
  scripts\mp\gametypes\br_quest_util::ref_12B31("x2_stash", &ref_1466F);
}

function ref_1466D(var_0) {
  if(!gethillspawnshutofforigin(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_0);
}

function ref_14672(var_0) {
  if(!gethillspawnshutofforigin(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("x2_stash");
  scripts\mp\gametypes\br_quest_util::ref_1336C(var_0);
}

function ref_1466F() {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function ref_14671() {
  lastspectatedplayer();
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_14670(var_0) {
  if(var_0.team == self.team) {
    var_1 = self.playerlist;
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("x2_stash", self.team).playerlist = var_1;

    if(isDefined(self) && isDefined(self.force_spawn_all_dead_players) && var_1.size) {
      self.force_spawn_all_dead_players setotherent(var_1[0]);
    }

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var_0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function gethillspawnshutofforigin(var_0) {
  return scripts\mp\gametypes\br_gametype_x2::extra_riders_func(var_0);
}

function search(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\gametypes\br_gametype_x2::extra_riders_getin_anim_func("x2_stash", var_0, var_1, var_4);
  var_5.initprematchc130 = level.ref_14632;

  if(level.mapname == "mp_br_mechanics") {
    var_6 = scripts\mp\gametypes\br_quest_util::getteamcenter(var_0, level.questinfo.defaultfilter);
  } else {
    var_6 = (4460, -1050, -110);

    if(var_6.initprematchc130 == 1) {
      var_6 = (-1139, 11302, -262);
    } else if(var_6.initprematchc130 == 2) {
      var_6 = (-33933, 4065, -164);
    } else if(var_6.initprematchc130 == 3) {
      var_6 = (-19743, -38579, 1844);
    }
  }

  var_7 = ref_11A00(var_6);
  var_6.ref_12C4A = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("x2_stash", var_7);
  ref_136B4(var_6, var_6.ref_12C4A.origin, var_6.ref_12C4A.angles);
  var_6 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_x2_01_objective", "current", var_6.ref_12C4A.origin);
  ref_14032(var_6);
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("x2_stash", self.team);
  var_6 scripts\mp\gametypes\br_quest_util::ref_1297D(scripts\mp\gametypes\br_quest_util::getquestdata("x2_stash").ref_11C4C, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("x2_stash", var_6);
  scripts\mp\gametypes\br_quest_util::ref_13879("x2_stash", self, self.team);
  var_8 = spawnStruct();
  var_8.ref_127D5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("x2_stash", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_x2_stash_quest_start_team_notify", var_8);
  return var_6;
}

function calculatehelispawndata() {
  return scripts\mp\gametypes\br_gametype_x2::enemy_signal_flare("x2_stash", &search);
}

function ref_11A00(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.ref_12FA3 = "getUnusedLootCacheArray";
  var_2.ref_12F9F = var_0;
  var_2.ref_12FA6 = 10000;
  var_2.ref_12FA7 = 1000;
  var_2.ref_12FA4 = 3000;
  var_2.ref_12FA5 = 1500;
  var_2.ref_12FA1 = 1;
  var_2.ref_12C4A = var_1;
  var_2.mintime = 60;

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race") {
    if(var_2.ref_12FA6 < level.ref_12969) {
      var_2.ref_12FA6 = level.ref_12969;
    }

    var_2.ref_12FA4 = level.ref_12969;
    var_2.ref_12FA5 = level.ref_1296A;
  }

  return var_2;
}

function ref_136B4(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_3 = self.playerlist[0];
  var_2.angles = var_1;
  var_2 setotherent(var_3);
  var_2 setModel("x1_military_loot_crate_br_01");
  var_2 setscriptablepartstate("body", "x1_stash_closed");
  var_2.ref_12970 = self;
  self.force_spawn_all_dead_players = var_2;
  var_4 = getlootscriptablearrayinradius("br_loot_cache");
  self.ref_12D30 = var_4[0];

  foreach(var_6 in level.players) {
    if(var_6 != var_3 && (var_3.team == "none" || var_6.team != var_3.team || var_6.squadindex != var_3.squadindex)) {
      var_2 disablescriptableplayeruse(var_6);
    }
  }
}

function ref_14032() {
  foreach(var_1 in self.playerlist) {
    var_1 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("x2_stash");
    scripts\mp\gametypes\br_quest_util::ref_1336C(var_1);
  }
}

function lbravo_spawner_jammer3() {
  var_0 = (self.force_spawn_all_dead_players.origin[0], self.force_spawn_all_dead_players.origin[1], scripts\mp\gametypes\br_quest_util::getquestdata("x2_stash").ref_12FA0);
  var_0 += scripts\engine\math::random_vector_2d() * randomfloatrange(500, 2000);
  scripts\mp\gametypes\br_quest_util::ref_11DAE(var_0);
}

function spawn_enemy_claymore(var_0) {
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function lastspectatedplayer() {
  foreach(var_1 in self.playerlist) {
    spawn_enemy_claymore(var_1);
  }
}

function ref_1466E(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "x1_stash_closed" && isDefined(var_0.entity)) {
    var_5 = var_0.entity.ref_12970;

    if(var_3.team != var_5.team || var_3.squadindex != var_5.squadindex) {
      var_3 iprintlnbold("Chest Requires a Stash Mission");
      return;
    }

    var_0 setscriptablepartstate("body", "x1_stash_opening");
    var_6 = getdvarint("scr_br_secretstash_cacheDeleteDelay", 30);
    var_0.entity scripts\engine\utility::delaycallwatchself(var_6, &delete);
    var_5 scripts\mp\gametypes\br_quest_util::search_activate_battle_station("x2stash", var_3.team, var_0.origin, var_0.angles, var_5.ref_12D30);
    var_5.ref_12D2E = var_0.origin;
    var_5.ref_12D2B = var_0.angles;
    level notify("lootcache_opened_kill_callout" + var_0.origin);
    var_7 = level.squaddata[var_3.team][var_3.squadindex].players;

    foreach(var_9 in var_7) {
      var_9 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function ref_14654(var_0) {
  var_1 = scripts\mp\gametypes\br_gametype_x2::entmantling("x2_stash", var_0);
  var_2 = self.angles;

  if(!isDefined(self.angles)) {
    var_2 = var_1.ref_12D2B;
  }

  var_1 scripts\mp\gametypes\br_quest_util::search_activate_battle_station("x2stash_end", var_0.team, self.origin, var_2, self.ref_12D30);
  scripts\mp\gametypes\br_quest_util::lookforvehicles(var_0.team, var_0, 8, scripts\mp\gametypes\br_quest_util::getquestindex("x2_stash"));
  his_ontimerexpired(var_1, self.tracknonoobplayerlocation);
}

function his_ontimerexpired(var_0) {
  var_1 = spawnStruct();
  var_2 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_3 = scripts\mp\gametypes\br_quest_util::getquestindex("x2_stash");
  var_4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("x2_stash"));
  var_1.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_3, var_2, var_4);

  if(getdvarint("scr_br_x2_contractKillcamFix", 1)) {
    var_5 = scripts\mp\gametypes\br_gametype_x2::enter_laser_panel_anim_sequence(self.playerlist);
    scripts\mp\gametypes\br_quest_util::longwaitradarsweep(var_5, "br_x2_stash_quest_complete", var_1);
  } else {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_x2_stash_quest_complete", var_1);
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_scav_success", 1, self.playerlist, undefined, 1, undefined);
  self.ref_12D2E = var_0.origin;
  self.ref_12D2B = var_0.angles;
  self.result = "success";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function pause_wave_hud() {
  lastspectatedplayer();
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_1466C() {
  var_0 = self;

  if(istrue(var_0.playermonitorspectatorcycle) || scripts\mp\flags::gameflag("x2_ambush" + self.initprematchc130 + 1 + "_starting") || scripts\mp\flags::gameflag("x2_train_destroyed")) {
    pause_wave_hud(var_0);
    return;
  }
}