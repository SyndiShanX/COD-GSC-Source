/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_scavenger_quest_soa_tower.gsc
*****************************************************************/

function init() {
  scripts\engine\scriptable::ref_12f5b("body", &ref_12ed6);
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("scavenger_soa_tower", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b2a("scavenger_soa_tower", "brloot_scavenger_tablet_soa_tower");

  if(!var0) {
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
  var1 = [];
  GscBinSkip0(0x2e, 0, &scripts\mp\gametypes\br_quest_util::filtercondition_isdead);
}

function ref_13463() {
  level waittill("prematch_fade_done");
  streakdeploy_playtabletdeploydialog();
  ref_13465((19934, -12275, -174));
  ref_13465((18431, -16469, -102));
  ref_13465((19912, -16488, -88));
}

function ref_13465(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::ref_135df("scavenger_soa_tower", scripts\engine\utility::drop_to_ground(var0, 0, -100, (0, 0, 1)) + (0, 0, 25), 0);
  scripts\mp\gametypes\br_pickups::ref_12b3a(var1);
}

function ref_1372c() {
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_13728(var0) {
  if(var0.team == self.team) {
    var1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("scavenger_locale_soa_tower", self.team).playerlist = var1;

    if(isDefined(self.ref_1393b) && isDefined(self.ref_1393b.force_spawn_all_dead_players) && var1.size) {
      self.ref_1393b.force_spawn_all_dead_players setotherent(var1[0]);
    }

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function ref_1371f(var0) {
  if(!gethost(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
}

function ref_1372f(var0) {
  if(!gethost(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("scavenger_soa_tower");
  scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
}

function gethost(var0) {
  if(var0.team == self.subscribedinstances[0].team) {
    return 1;
  }

  return 0;
}

function ref_1371c(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("scavenger_locale_soa_tower", "scavenger_soa_tower", self.team);

  if(!isDefined(var0)) {
    var1.curorigin = (0, 0, 0);
    var1.enabled = 0;
    return var1;
  }

  var1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_vault_objective", "current");
  var1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var1.ref_12320 = 0;
  scripts\mp\gametypes\br_quest_util::addquestinstance("scavenger_locale_soa_tower", var1);
  ref_1325a(var1, var0);
  return var1;
}

function ref_13722(var0) {
  self.ref_12320++;
  var1 = ref_1325a(var0);

  if(var1) {
    self.subscribedinstances[0].intelprogress = var0.origin;
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

function ref_1325a(var0) {
  if(!isDefined(var0)) {
    var1 = self.subscribedinstances[0];

    foreach(var4, var3 in scripts\mp\utility\teams::getteamdata(var1.team, "players")) {
      var3 scripts\mp\utility\lower_message::ref_1316e("br_assassination_notargets", undefined, 5);
    }

    var1.result = "no_locale";
    var1 scripts\mp\gametypes\br_quest_util::removequestinstance();
    return false;
  }

  getlootspawnpointcount(var4.index);
  ref_13698(var4.origin, var4.angles, self);
  self.curorigin = var4.origin + (0, 0, 50);
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

function ref_1371a(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var1)) {
    return;
  }

  if(!isDefined(self.curorigin)) {
    return;
  }

  if(!isDefined(self.lastcircletick)) {
    self.lastcircletick = -1;
  }

  var2 = gettime();

  if(self.lastcircletick == var2) {
    return;
  }

  self.lastcircletick = var2;
  var3 = distance2d(self.curorigin, var0);

  if(var3 > var1) {
    foreach(var5 in self.subscribedinstances) {
      failscavengerquest(var5);
    }

    return;
  }
}

function ref_13718() {
  return false;
}

function takequestitem(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createquestinstance("scavenger_soa_tower", self.team, var0.index, var0);
  var1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var1 scripts\mp\gametypes\br_quest_util::ref_12b15(self);
  var1.team = self.team;
  var1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var1.startlocation = self.origin;
  var1.intelprogress = self.origin;
  var1.ref_12c4a = var0.ref_12c4a;
  var2 = ref_11a00(var1.startlocation, var1.ref_12c4a[0]);
  var3 = var1 scripts\mp\gametypes\br_quest_util::requestquestlocale("scavenger_locale_soa_tower", var2, 1);
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("scavenger_soa_tower", self.team);
  var1.totalscavengeditems = 0;
  var1 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_soa_tower").ref_11c4c, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("scavenger_soa_tower", var1);
  scripts\mp\gametypes\br_quest_util::ref_13879("scavenger_soa_tower", self, self.team);
  var4 = spawnStruct();
  var4.excludedplayers = [];
  var4.excludedplayers[0] = self;
  var4.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("scavenger_soa_tower", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_soa_tower_quest_start_team", var4);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_scavenger_soa_tower_quest_start_tablet_finder", var4);

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  }

  scripts\mp\gametypes\br_quest_util::lookforvehicles(var1.team, self, 6, scripts\mp\gametypes\br_quest_util::getquestindex("scavenger_soa_tower"));
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_accept", var1.team, 1);
}

function ref_11a00(var0, var1) {
  var2 = spawnStruct();
  var2.ref_12fa3 = "getUnusedLootCacheArray";
  var2.ref_12f9f = var0;
  var2.ref_12fa6 = 10000;
  var2.ref_12fa7 = 0;
  var2.ref_12fa4 = 4000;
  var2.ref_12fa5 = 2000;
  var2.ref_12fa1 = 1;
  var2.ref_12c4a = var1;
  var2.mintime = 45;

  if(playoverwatch_dialogue()) {
    if(var2.ref_12fa6 < level.ref_12967) {
      var2.ref_12fa6 = level.ref_12967;
    }

    var2.ref_12fa4 = level.ref_12967;
    var2.ref_12fa5 = level.ref_12968;
  }

  var3 = getdvarint("scr_br_questScavDistMin", -1);
  var4 = getdvarint("scr_br_questScavDistMax", -1);

  if(var3 >= 0) {
    var2.ref_12fa5 = var3;
  }

  if(var4 >= 0) {
    var2.ref_12fa4 = var4;
  }

  return var2;
}

function playoverwatch_dialogue() {
  var0 = 0;
  var1 = scripts\mp\gametypes\br_gametypes::ref_12e05("overrideQuestSearchParams", "scavenger_soa_tower");

  if(isDefined(var1)) {
    return var1;
  }

  var2 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var2) {
    case "mini":
    case "risk":
    case "rat_race":
    case "dmz":
      var0 = 1;
      break;
  }

  return var0;
}

function hint_target_think(var0) {
  var1 = easepower("brloot_access_card_gold_vault_lockbox_1", var0.origin + (0, 0, 20));
  scripts\mp\gametypes\br_pickups::ref_12b3a(var1);
  playsoundatpos(var1.origin, "br_legendary_loot_drop");
  var2 = spawnStruct();
  var3 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var4 = scripts\mp\gametypes\br_quest_util::getquestindex("scavenger_soa_tower");
  var5 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("scavenger_soa_tower"));
  var2.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var4, var3, var5);

  foreach(var7 in self.playerlist) {
    if(isDefined(var7) && getdvarint("MLNNMOPQOP", 0) == 6) {
      var7 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_complete_side_mission_for_s3_5_event_wz", 1);
    }
  }

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_soa_tower_quest_complete", var2);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_misc_success", self.team, 1, 1);
  }

  self.ref_12d2e = var0.origin;
  self.ref_12d2b = var0.angles;
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
  foreach(var1 in self.playerlist) {
    var1 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(self.ref_12320);
  }

  var3 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(self.playerlist);

  foreach(var1 in var3["valid"]) {
    var1 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("scavenger_soa_tower");
    scripts\mp\gametypes\br_quest_util::ref_1336c(var1);
  }

  foreach(var1 in var3["invalid"]) {
    var1 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var1);
  }
}

function spawn_dwn_twn_enemy_sentry(var0) {
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function lastdroppableweaponchanged() {
  foreach(var1 in self.playerlist) {
    spawn_dwn_twn_enemy_sentry(var1);
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();
}

function ref_13725() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_soa_tower_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function ref_13698(var0, var1, var2) {
  var3 = ref_129f6();
  var0 = var3.origin;
  var1 = var3.angles;
  var4 = spawn("script_model", var0);
  var5 = var2.playerlist[0];
  var4.angles = var1;
  var4 setotherent(var5);
  var4 setModel("military_loot_crate_01_br_scavenger_01_soa_tower");
  var4 setscriptablepartstate("body", "scavenger_soa_tower_closed");
  var4.questlocale = var2;
  var2.force_spawn_all_dead_players = var4;
  var2 scripts\mp\gametypes\br_quest_util::ref_11db0(var3.origin + (0, 0, 50));

  foreach(var7 in level.players) {
    if(var7 != var5 && (var5.team == "none" || var7.team != var5.team)) {
      var4 disablescriptableplayeruse(var7);
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

function strafereverse_cleanup(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0;
  var2.angles = var1;
  return var2;
}

function ref_129f6() {
  var0 = randomint(level.areanygulagfightsactive[self.ref_12320].size);
  var1 = level.areanygulagfightsactive[self.ref_12320][var0];
  level.areanygulagfightsactive[self.ref_12320] = scripts\engine\utility::array_remove(level.areanygulagfightsactive[self.ref_12320], var1);
  return var1;
}

function ref_12ed6(var0, var1, var2, var3, var4) {
  if(istrue(var3 scripts\mp\gametypes\br_gametypes::ref_12e05("playerSkipLootPickup", var0))) {
    return;
  }

  if(var2 == "scavenger_soa_tower_closed" && isDefined(var0.entity)) {
    var5 = var0.entity.questlocale.subscribedinstances[0];

    if(var3.team != var5.team) {
      var3 iprintlnbold("Chest Requires a Scavenger Mission");
      return;
    }

    var0 setscriptablepartstate("body", "scavenger_soa_tower_opening");
    var6 = getdvarint("scr_br_scavenger_cacheDeleteDelay", 30);
    var0.entity scripts\engine\utility::delaycallwatchself(var6, &delete);
    var5 scripts\mp\gametypes\br_quest_util::ref_12b15(var3);

    switch (var0.entity.questlocale.ref_12320) {
      case 0:
        ref_13464(var0.entity);
        break;
      case 1:
        ref_13464(var0.entity);
        break;
      case 3:
        break;
    }

    if(var0.entity.questlocale.ref_12320 == 2) {
      var5.ref_12d2e = var0.origin;
      var5.ref_12d2b = var0.angles;
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var5.team, var3, 8, scripts\mp\gametypes\br_quest_util::getquestindex("scavenger_soa_tower"));
      hint_target_think(var5, var0.entity);
    } else {
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var5.team, var3, 7, scripts\mp\gametypes\br_quest_util::getquestindex("scavenger_soa_tower"));
      var7 = ref_11a00(var0.origin, var5.ref_12c4a[var0.entity.questlocale.ref_12320 + 1]);
      var0.entity.questlocale scripts\mp\gametypes\br_quest_util::ref_11daf("scavenger_locale_soa_tower", var7);
    }

    level notify("lootcache_opened_kill_callout" + var0.origin);
    var8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var3.team, 0);

    foreach(var10 in var8) {
      var10 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function ref_13464() {
  var0 = ["weapon", "lethal", "ammo", "plunder"];
  var0 = scripts\engine\utility::array_randomize(var0);
  var1 = var0.size;
  var2 = "mp/loot/br/bodycount/lootset_root.csv";
  var3 = scripts\mp\gametypes\br_pickups::test_ai_anim();

  for(var4 = 0; var4 < var1; var4++) {
    var5 = registerscriptedspawnpoints(var0[var4], 0, 3, var2);

    if(scripts\mp\gametypes\br_lootcache::get_bonus_targets(var5)) {
      var6 = self.angles + (0, 45, 0);
      scripts\mp\gametypes\br_lootcache::ref_11a41(var5, var3, self.origin, var6, undefined, 0);
    }
  }
}

function ref_13732() {
  self.ref_12c4a = [];
  var0 = self.origin;

  for(var1 = 0; var1 < 3; var1++) {
    var2 = ref_11a00(var0);
    var3 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("scavenger_soa_tower", var2);

    if(!isDefined(var3)) {
      return false;
    }

    getlootspawnpointcount(var3.index);
    var0 = var3.origin;
    self.ref_12c4a[var1] = var3;
  }

  return true;
}