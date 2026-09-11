/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_x2_stash_quest.gsc
******************************************************/

function init() {
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("x2_stash", getdvarint("scr_br_x2stash_enabled", 1));

  if(!var0) {
    return;
  }

  scripts\engine\scriptable::ref_12f5b("body", &ref_1466e);
  scripts\mp\gametypes\br_quest_util::getquestdata("x2_stash").ref_12fa0 = getdvarint("scr_br_x2_stash_searchCircleSize", 3000);
  scripts\mp\gametypes\br_quest_util::getquestdata("x2_stash").ref_11c4c = getdvarint("scr_br_x2_stash_missionTimeBase", 240);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("x2_stash", &ref_14671);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("x2_stash", &ref_14670);
  scripts\mp\gametypes\br_quest_util::registerquestthink("x2_stash", &ref_1466c, 0.1);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("x2_stash", &ref_1466d);
  scripts\mp\gametypes\br_quest_util::ref_12b30("x2_stash", &ref_14672);
  scripts\mp\gametypes\br_quest_util::ref_1297c("x2_stash", 0);
  scripts\mp\gametypes\br_quest_util::ref_12b31("x2_stash", &ref_1466f);
}

function ref_1466d(var0) {
  if(!gethillspawnshutofforigin(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_dogtags(var0);
}

function ref_14672(var0) {
  if(!gethillspawnshutofforigin(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("x2_stash");
  scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
}

function ref_1466f() {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function ref_14671() {
  lastspectatedplayer();
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_14670(var0) {
  if(var0.team == self.team) {
    var1 = self.playerlist;
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("x2_stash", self.team).playerlist = var1;

    if(isDefined(self) && isDefined(self.force_spawn_all_dead_players) && var1.size) {
      self.force_spawn_all_dead_players setotherent(var1[0]);
    }

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function gethillspawnshutofforigin(var0) {
  return scripts\mp\gametypes\br_gametype_x2::extra_riders_func(var0);
}

function search(var0, var1, var2, var3, var4) {
  var5 = scripts\mp\gametypes\br_gametype_x2::extra_riders_getin_anim_func("x2_stash", var0, var1, var4);
  var5.initprematchc130 = level.ref_14632;

  if(level.mapname == "mp_br_mechanics") {
    var6 = scripts\mp\gametypes\br_quest_util::getteamcenter(var0, level.questinfo.defaultfilter);
  } else {
    var6 = (4460, -1050, -110);

    if(var6.initprematchc130 == 1) {
      var6 = (-1139, 11302, -262);
    } else if(var6.initprematchc130 == 2) {
      var6 = (-33933, 4065, -164);
    } else if(var6.initprematchc130 == 3) {
      var6 = (-19743, -38579, 1844);
    }
  }

  var7 = ref_11a00(var6);
  var6.ref_12c4a = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("x2_stash", var7);
  ref_136b4(var6, var6.ref_12c4a.origin, var6.ref_12c4a.angles);
  var6 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_x2_01_objective", "current", var6.ref_12c4a.origin);
  ref_14032(var6);
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("x2_stash", self.team);
  var6 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("x2_stash").ref_11c4c, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("x2_stash", var6);
  scripts\mp\gametypes\br_quest_util::ref_13879("x2_stash", self, self.team);
  var8 = spawnStruct();
  var8.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("x2_stash", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_x2_stash_quest_start_team_notify", var8);
  return var6;
}

function calculatehelispawndata() {
  return scripts\mp\gametypes\br_gametype_x2::enemy_signal_flare("x2_stash", &search);
}

function ref_11a00(var0, var1) {
  var2 = spawnStruct();
  var2.ref_12fa3 = "getUnusedLootCacheArray";
  var2.ref_12f9f = var0;
  var2.ref_12fa6 = 10000;
  var2.ref_12fa7 = 1000;
  var2.ref_12fa4 = 3000;
  var2.ref_12fa5 = 1500;
  var2.ref_12fa1 = 1;
  var2.ref_12c4a = var1;
  var2.mintime = 60;

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race") {
    if(var2.ref_12fa6 < level.ref_12969) {
      var2.ref_12fa6 = level.ref_12969;
    }

    var2.ref_12fa4 = level.ref_12969;
    var2.ref_12fa5 = level.ref_1296a;
  }

  return var2;
}

function ref_136b4(var0, var1) {
  var2 = spawn("script_model", var0);
  var3 = self.playerlist[0];
  var2.angles = var1;
  var2 setotherent(var3);
  var2 setModel("x1_military_loot_crate_br_01");
  var2 setscriptablepartstate("body", "x1_stash_closed");
  var2.ref_12970 = self;
  self.force_spawn_all_dead_players = var2;
  var4 = getlootscriptablearrayinradius("br_loot_cache");
  self.ref_12d30 = var4[0];

  foreach(var6 in level.players) {
    if(var6 != var3 && (var3.team == "none" || var6.team != var3.team || var6.squadindex != var3.squadindex)) {
      var2 disablescriptableplayeruse(var6);
    }
  }
}

function ref_14032() {
  foreach(var1 in self.playerlist) {
    var1 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("x2_stash");
    scripts\mp\gametypes\br_quest_util::ref_1336c(var1);
  }
}

function lbravo_spawner_jammer3() {
  var0 = (self.force_spawn_all_dead_players.origin[0], self.force_spawn_all_dead_players.origin[1], scripts\mp\gametypes\br_quest_util::getquestdata("x2_stash").ref_12fa0);
  var0 += scripts\engine\math::random_vector_2d() * randomfloatrange(500, 2000);
  scripts\mp\gametypes\br_quest_util::ref_11dae(var0);
}

function spawn_enemy_claymore(var0) {
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function lastspectatedplayer() {
  foreach(var1 in self.playerlist) {
    spawn_enemy_claymore(var1);
  }
}

function ref_1466e(var0, var1, var2, var3, var4) {
  if(var2 == "x1_stash_closed" && isDefined(var0.entity)) {
    var5 = var0.entity.ref_12970;

    if(var3.team != var5.team || var3.squadindex != var5.squadindex) {
      var3 iprintlnbold("Chest Requires a Stash Mission");
      return;
    }

    var0 setscriptablepartstate("body", "x1_stash_opening");
    var6 = getdvarint("scr_br_secretstash_cacheDeleteDelay", 30);
    var0.entity scripts\engine\utility::delaycallwatchself(var6, &delete);
    var5 scripts\mp\gametypes\br_quest_util::search_activate_battle_station("x2stash", var3.team, var0.origin, var0.angles, var5.ref_12d30);
    var5.ref_12d2e = var0.origin;
    var5.ref_12d2b = var0.angles;
    level notify("lootcache_opened_kill_callout" + var0.origin);
    var7 = level.squaddata[var3.team][var3.squadindex].players;

    foreach(var9 in var7) {
      var9 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function ref_14654(var0) {
  var1 = scripts\mp\gametypes\br_gametype_x2::entmantling("x2_stash", var0);
  var2 = self.angles;

  if(!isDefined(self.angles)) {
    var2 = var1.ref_12d2b;
  }

  var1 scripts\mp\gametypes\br_quest_util::search_activate_battle_station("x2stash_end", var0.team, self.origin, var2, self.ref_12d30);
  scripts\mp\gametypes\br_quest_util::lookforvehicles(var0.team, var0, 8, scripts\mp\gametypes\br_quest_util::getquestindex("x2_stash"));
  his_ontimerexpired(var1, self.tracknonoobplayerlocation);
}

function his_ontimerexpired(var0) {
  var1 = spawnStruct();
  var2 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var3 = scripts\mp\gametypes\br_quest_util::getquestindex("x2_stash");
  var4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("x2_stash"));
  var1.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var3, var2, var4);

  if(getdvarint("scr_br_x2_contractKillcamFix", 1)) {
    var5 = scripts\mp\gametypes\br_gametype_x2::enter_laser_panel_anim_sequence(self.playerlist);
    scripts\mp\gametypes\br_quest_util::longwaitradarsweep(var5, "br_x2_stash_quest_complete", var1);
  } else {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_x2_stash_quest_complete", var1);
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_scav_success", 1, self.playerlist, undefined, 1, undefined);
  self.ref_12d2e = var0.origin;
  self.ref_12d2b = var0.angles;
  self.result = "success";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function pause_wave_hud() {
  lastspectatedplayer();
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_1466c() {
  var0 = self;

  if(istrue(var0.playermonitorspectatorcycle) || scripts\mp\flags::gameflag("x2_ambush" + self.initprematchc130 + 1 + "_starting") || scripts\mp\flags::gameflag("x2_train_destroyed")) {
    pause_wave_hud(var0);
    return;
  }
}