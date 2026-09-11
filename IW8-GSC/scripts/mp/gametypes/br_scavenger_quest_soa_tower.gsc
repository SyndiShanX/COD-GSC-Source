/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_scavenger_quest_soa_tower.gsc
*****************************************************************/

function init() {
  scripts\engine\scriptable::ref_12f5b("body", &ref_12ed6);
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("scavenger_soa_tower", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b2a("scavenger_soa_tower", "brloot_scavenger_tablet_soa_tower");

  if(!var_0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_soa_tower").ref_12fa0 = getdvarint("scr_br_SOATower_searchCircleSize", 1000);
  scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_soa_tower").ref_11c4c = getdvarint("scr_br_SOATower_missionTimeBase", 300);
  scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_soa_tower").ref_11c4d = getdvarint("scr_br_SOATower_missionTimeBonus", 60);
  scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_soa_tower").ref_12c83 = getdvarint("scr_br_SOATower_resetTimerOnPickup", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b3d("scavenger_soa_tower", &ref_13732);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("scavenger_soa_tower", &ref_1372c);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("scavenger_soa_tower", &ref_13728);
  scripts\mp\gametypes\br_quest_util::registerquestlocale("scavenger_locale_soa_tower");
  scripts\mp\gametypes\br_quest_util::registercreatequestlocale("scavenger_locale_soa_tower", &ref_1371c);
  scripts\mp\gametypes\br_quest_util::ref_12b2b("scavenger_locale_soa_tower", &ref_13722);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("scavenger_locale_soa_tower", &ref_1372a);
  scripts\mp\gametypes\br_quest_util::registercheckiflocaleisavailable("scavenger_locale_soa_tower", &ref_13718);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("scavenger_locale_soa_tower", &ref_1371a);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("scavenger_locale_soa_tower", &ref_1371f);
  scripts\mp\gametypes\br_quest_util::ref_12b30("scavenger_locale_soa_tower", &ref_1372f);
  scripts\mp\gametypes\br_quest_util::ref_1297c("scavenger_soa_tower", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("scavenger_soa_tower", &ref_13725);
  var_1 = [];
  GscBinSkip0(0x2e, 0, &scripts\mp\gametypes\br_quest_util::filtercondition_isdead);
}

function ref_13463() {
  level waittill("prematch_fade_done");
  streakdeploy_playtabletdeploydialog();
  ref_13465((19934, -12275, -174));
  ref_13465((18431, -16469, -102));
  ref_13465((19912, -16488, -88));
}

function ref_13465(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::ref_135df("scavenger_soa_tower", scripts\engine\utility::drop_to_ground(var_0, 0, -100, (0, 0, 1)) + (0, 0, 25), 0);
  scripts\mp\gametypes\br_pickups::ref_12b3a(var_1);
}

function ref_1372c() {
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_13728(var_0) {
  if(var_0.team == self.team) {
    var_1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("scavenger_locale_soa_tower", self.team).playerlist = var_1;

    if(isDefined(self.ref_1393b) && isDefined(self.ref_1393b.force_spawn_all_dead_players) && var_1.size) {
      self.ref_1393b.force_spawn_all_dead_players setotherent(var_1[0]);
    }

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var_0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function ref_1371f(var_0) {
  if(!gethost(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
}

function ref_1372f(var_0) {
  if(!gethost(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("scavenger_soa_tower");
  scripts\mp\gametypes\br_quest_util::ref_1336c(var_0);
}

function gethost(var_0) {
  if(var_0.team == self.subscribedinstances[0].team) {
    return 1;
  }

  return 0;
}

function ref_1371c(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("scavenger_locale_soa_tower", "scavenger_soa_tower", self.team);

  if(!isDefined(var_0)) {
    var_1.curorigin = (0, 0, 0);
    var_1.enabled = 0;
    return var_1;
  }

  var_1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_vault_objective", "current");
  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var_1.ref_12320 = 0;
  scripts\mp\gametypes\br_quest_util::addquestinstance("scavenger_locale_soa_tower", var_1);
  ref_1325a(var_1, var_0);
  return var_1;
}

function ref_13722(var_0) {
  self.ref_12320++;
  var_1 = ref_1325a(var_0);

  if(var_1) {
    self.subscribedinstances[0].intelprogress = var_0.origin;
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.subscribedinstances[0].team, "br_scavenger_soa_tower_quest_next_location");
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_next_nptarget", self.subscribedinstances[0].team, 1);

    if(istrue(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_soa_tower").ref_12c83)) {
      self.subscribedinstances[0] scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_soa_tower").ref_11c4c, 1);
      return;
    }

    self.subscribedinstances[0] scripts\mp\gametypes\br_quest_util::ref_1297b(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_soa_tower").ref_11c4d);
    return;
  }
}

function ref_1325a(var_0) {
  if(!isDefined(var_0)) {
    var_1 = self.subscribedinstances[0];

    foreach(var_4, var_3 in scripts\mp\utility\teams::getteamdata(var_1.team, "players")) {
      var_3 scripts\mp\utility\lower_message::ref_1316e("br_assassination_notargets", undefined, 5);
    }

    var_1.result = "no_locale";
    var_1 scripts\mp\gametypes\br_quest_util::removequestinstance();
    return false;
  }

  getlootspawnpointcount(var_4.index);
  ref_13698(var_4.origin, var_4.angles, self);
  self.curorigin = var_4.origin + (0, 0, 50);
  ref_14016();
  return true;
}

function ref_1372a() {
  lastdroppableweaponchanged();
  self.playerlist = undefined;
  self.subscribedinstances = undefined;

  if(isDefined(self.force_spawn_all_dead_players)) {
    if(self.force_spawn_all_dead_players getscriptablepartstate("body") == "scavenger_soa_tower_closed") {
      self.force_spawn_all_dead_players delete();
      return;
    }

    return;
  }
}

function ref_1371a(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(self.curorigin)) {
    return;
  }

  if(!isDefined(self.lastcircletick)) {
    self.lastcircletick = -1;
  }

  var_2 = gettime();

  if(self.lastcircletick == var_2) {
    return;
  }

  self.lastcircletick = var_2;
  var_3 = distance2d(self.curorigin, var_0);

  if(var_3 > var_1) {
    foreach(var_5 in self.subscribedinstances) {
      failscavengerquest(var_5);
    }

    return;
  }
}

function ref_13718() {
  return false;
}

function takequestitem(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::createquestinstance("scavenger_soa_tower", self.team, var_0.index, var_0);
  var_1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var_1 scripts\mp\gametypes\br_quest_util::ref_12b15(self);
  var_1.team = self.team;
  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var_1.startlocation = self.origin;
  var_1.intelprogress = self.origin;
  var_1.ref_12c4a = var_0.ref_12c4a;
  var_2 = ref_11a00(var_1.startlocation, var_1.ref_12c4a[0]);
  var_3 = var_1 scripts\mp\gametypes\br_quest_util::requestquestlocale("scavenger_locale_soa_tower", var_2, 1);
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("scavenger_soa_tower", self.team);
  var_1.totalscavengeditems = 0;
  var_1 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_soa_tower").ref_11c4c, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("scavenger_soa_tower", var_1);
  scripts\mp\gametypes\br_quest_util::ref_13879("scavenger_soa_tower", self, self.team);
  var_4 = spawnStruct();
  var_4.excludedplayers = [];
  var_4.excludedplayers[0] = self;
  var_4.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("scavenger_soa_tower", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_soa_tower_quest_start_team", var_4);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_scavenger_soa_tower_quest_start_tablet_finder", var_4);

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  }

  scripts\mp\gametypes\br_quest_util::lookforvehicles(var_1.team, self, 6, scripts\mp\gametypes\br_quest_util::getquestindex("scavenger_soa_tower"));
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_accept", var_1.team, 1);
}

function ref_11a00(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.ref_12fa3 = "getUnusedLootCacheArray";
  var_2.ref_12f9f = var_0;
  var_2.ref_12fa6 = 10000;
  var_2.ref_12fa7 = 0;
  var_2.ref_12fa4 = 4000;
  var_2.ref_12fa5 = 2000;
  var_2.ref_12fa1 = 1;
  var_2.ref_12c4a = var_1;
  var_2.mintime = 45;

  if(playoverwatch_dialogue()) {
    if(var_2.ref_12fa6 < level.ref_12967) {
      var_2.ref_12fa6 = level.ref_12967;
    }

    var_2.ref_12fa4 = level.ref_12967;
    var_2.ref_12fa5 = level.ref_12968;
  }

  var_3 = getdvarint("scr_br_questScavDistMin", -1);
  var_4 = getdvarint("scr_br_questScavDistMax", -1);

  if(var_3 >= 0) {
    var_2.ref_12fa5 = var_3;
  }

  if(var_4 >= 0) {
    var_2.ref_12fa4 = var_4;
  }

  return var_2;
}

function playoverwatch_dialogue() {
  var_0 = 0;
  var_1 = scripts\mp\gametypes\br_gametypes::ref_12e05("overrideQuestSearchParams", "scavenger_soa_tower");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var_2) {
    case "mini":
    case "risk":
    case "rat_race":
    case "dmz":
      var_0 = 1;
      break;
  }

  return var_0;
}

function hint_target_think(var_0) {
  var_1 = easepower("brloot_access_card_gold_vault_lockbox_1", var_0.origin + (0, 0, 20));
  scripts\mp\gametypes\br_pickups::ref_12b3a(var_1);
  playsoundatpos(var_1.origin, "br_legendary_loot_drop");
  var_2 = spawnStruct();
  var_3 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_4 = scripts\mp\gametypes\br_quest_util::getquestindex("scavenger_soa_tower");
  var_5 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("scavenger_soa_tower"));
  var_2.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var_4, var_3, var_5);

  foreach(var_7 in self.playerlist) {
    if(isDefined(var_7) && getdvarint("MLNNMOPQOP", 0) == 6) {
      var_7 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_complete_side_mission_for_s3_5_event_wz", 1);
    }
  }

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_soa_tower_quest_complete", var_2);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_misc_success", self.team, 1, 1);
  }

  self.ref_12d2e = var_0.origin;
  self.ref_12d2b = var_0.angles;
  self.result = "success";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function failscavengerquest() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_soa_tower_quest_circle_failure");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_circle_fail", self.team, 1);
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_14016() {
  foreach(var_1 in self.playerlist) {
    var_1 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(self.ref_12320);
  }

  var_3 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(self.playerlist);

  foreach(var_1 in var_3["valid"]) {
    var_1 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("scavenger_soa_tower");
    scripts\mp\gametypes\br_quest_util::ref_1336c(var_1);
  }

  foreach(var_1 in var_3["invalid"]) {
    var_1 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_1);
  }
}

function spawn_dwn_twn_enemy_sentry(var_0) {
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function lastdroppableweaponchanged() {
  foreach(var_1 in self.playerlist) {
    spawn_dwn_twn_enemy_sentry(var_1);
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();
}

function ref_13725() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_soa_tower_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function ref_13698(var_0, var_1, var_2) {
  var_3 = ref_129f6();
  var_0 = var_3.origin;
  var_1 = var_3.angles;
  var_4 = spawn("script_model", var_0);
  var_5 = var_2.playerlist[0];
  var_4.angles = var_1;
  var_4 setotherent(var_5);
  var_4 setModel("military_loot_crate_01_br_scavenger_01_soa_tower");
  var_4 setscriptablepartstate("body", "scavenger_soa_tower_closed");
  var_4.questlocale = var_2;
  var_2.force_spawn_all_dead_players = var_4;
  var_2 scripts\mp\gametypes\br_quest_util::ref_11db0(var_3.origin + (0, 0, 50));

  foreach(var_7 in level.players) {
    if(var_7 != var_5 && (var_5.team == "none" || var_7.team != var_5.team)) {
      var_4 disablescriptableplayeruse(var_7);
    }
  }
}

function streakdeploy_playtabletdeploydialog() {
  level.areanygulagfightsactive = [];
  level.areanygulagfightsactive[0] = [];
  level.areanygulagfightsactive[1] = [];
  level.areanygulagfightsactive[2] = [];
  level.areanygulagfightsactive[0][0] = strafereverse_cleanup(scripts\engine\utility::drop_to_ground((20355, -14236, -22), 0, -100, (0, 0, 1)), (0, 180, 0));
  level.areanygulagfightsactive[0][1] = strafereverse_cleanup(scripts\engine\utility::drop_to_ground((20915, -14865, -22), 0, -100, (0, 0, 1)), (0, 90, 0));
  level.areanygulagfightsactive[0][2] = strafereverse_cleanup(scripts\engine\utility::drop_to_ground((19789, -13962, -22), 0, -100, (0, 0, 1)), (0, 0, 0));
  level.areanygulagfightsactive[1][0] = strafereverse_cleanup(scripts\engine\utility::drop_to_ground((19656, -14016, 298), 0, -100, (0, 0, 1)), (0, 180, 0));
  level.areanygulagfightsactive[1][1] = strafereverse_cleanup(scripts\engine\utility::drop_to_ground((20346, -15735, 298), 0, -100, (0, 0, 1)), (0, 45, 0));
  level.areanygulagfightsactive[1][2] = strafereverse_cleanup((20900, -14194, 241), (0, 90, 0));
  level.areanygulagfightsactive[2][0] = strafereverse_cleanup(scripts\engine\utility::drop_to_ground((19699, -13932, 437), 0, -100, (0, 0, 1)), (0, 90, 0));
  level.areanygulagfightsactive[2][1] = strafereverse_cleanup((20072, -15288, 387), (0, 0, 0));
  level.areanygulagfightsactive[2][2] = strafereverse_cleanup(scripts\engine\utility::drop_to_ground((20500, -15233, 442), 0, -100, (0, 0, 1)), (0, 270, 0));
}

function strafereverse_cleanup(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.angles = var_1;
  return var_2;
}

function ref_129f6() {
  var_0 = randomint(level.areanygulagfightsactive[self.ref_12320].size);
  var_1 = level.areanygulagfightsactive[self.ref_12320][var_0];
  level.areanygulagfightsactive[self.ref_12320] = scripts\engine\utility::array_remove(level.areanygulagfightsactive[self.ref_12320], var_1);
  return var_1;
}

function ref_12ed6(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_3 scripts\mp\gametypes\br_gametypes::ref_12e05("playerSkipLootPickup", var_0))) {
    return;
  }

  if(var_2 == "scavenger_soa_tower_closed" && isDefined(var_0.entity)) {
    var_5 = var_0.entity.questlocale.subscribedinstances[0];

    if(var_3.team != var_5.team) {
      var_3 iprintlnbold("Chest Requires a Scavenger Mission");
      return;
    }

    var_0 setscriptablepartstate("body", "scavenger_soa_tower_opening");
    var_6 = getdvarint("scr_br_scavenger_cacheDeleteDelay", 30);
    var_0.entity scripts\engine\utility::delaycallwatchself(var_6, &delete);
    var_5 scripts\mp\gametypes\br_quest_util::ref_12b15(var_3);

    switch (var_0.entity.questlocale.ref_12320) {
      case 0:
        ref_13464(var_0.entity);
        break;
      case 1:
        ref_13464(var_0.entity);
        break;
      case 3:
        break;
    }

    if(var_0.entity.questlocale.ref_12320 == 2) {
      var_5.ref_12d2e = var_0.origin;
      var_5.ref_12d2b = var_0.angles;
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var_5.team, var_3, 8, scripts\mp\gametypes\br_quest_util::getquestindex("scavenger_soa_tower"));
      hint_target_think(var_5, var_0.entity);
    } else {
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var_5.team, var_3, 7, scripts\mp\gametypes\br_quest_util::getquestindex("scavenger_soa_tower"));
      var_7 = ref_11a00(var_0.origin, var_5.ref_12c4a[var_0.entity.questlocale.ref_12320 + 1]);
      var_0.entity.questlocale scripts\mp\gametypes\br_quest_util::ref_11daf("scavenger_locale_soa_tower", var_7);
    }

    level notify("lootcache_opened_kill_callout" + var_0.origin);
    var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_3.team, 0);

    foreach(var_10 in var_8) {
      var_10 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function ref_13464() {
  var_0 = ["weapon", "lethal", "ammo", "plunder"];
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0.size;
  var_2 = "mp/loot/br/bodycount/lootset_root.csv";
  var_3 = scripts\mp\gametypes\br_pickups::test_ai_anim();

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = registerscriptedspawnpoints(var_0[var_4], 0, 3, var_2);

    if(scripts\mp\gametypes\br_lootcache::get_bonus_targets(var_5)) {
      var_6 = self.angles + (0, 45, 0);
      scripts\mp\gametypes\br_lootcache::ref_11a41(var_5, var_3, self.origin, var_6, undefined, 0);
    }
  }
}

function ref_13732() {
  self.ref_12c4a = [];
  var_0 = self.origin;

  for(var_1 = 0; var_1 < 3; var_1++) {
    var_2 = ref_11a00(var_0);
    var_3 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("scavenger_soa_tower", var_2);

    if(!isDefined(var_3)) {
      return false;
    }

    getlootspawnpointcount(var_3.index);
    var_0 = var_3.origin;
    self.ref_12c4a[var_1] = var_3;
  }

  return true;
}