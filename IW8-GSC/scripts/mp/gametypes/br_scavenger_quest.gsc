/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_scavenger_quest.gsc
*******************************************************/

function init() {
  scripts\engine\scriptable::ref_12f5b("body", &ref_12ed4);
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("scavenger", 1);

  if(!var0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("scavenger").ref_12fa0 = getdvarint("scr_br_scavenger_searchCircleSize", 1000);
  scripts\mp\gametypes\br_quest_util::getquestdata("scavenger").ref_11c4c = getdvarint("scr_br_scavenger_missionTimeBase", 300);
  scripts\mp\gametypes\br_quest_util::getquestdata("scavenger").ref_11c4d = getdvarint("scr_br_scavenger_missionTimeBonus", 60);
  scripts\mp\gametypes\br_quest_util::getquestdata("scavenger").ref_12c83 = getdvarint("scr_br_scavenger_resetTimerOnPickup", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b3d("scavenger", &ref_13730);
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("scavenger_redacted", 1);

  if(var0) {
    scripts\mp\gametypes\br_quest_util::ref_12b2a("scavenger_redacted", "brloot_redacted_scavenger_tablet");
    scripts\mp\gametypes\br_quest_util::ref_12b3d("scavenger_redacted", &ref_13730);
  }

  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("scavenger", &sq_removequestinstance);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("scavenger", &ref_13726);
  scripts\mp\gametypes\br_quest_util::registerquestlocale("scavenger_locale");
  scripts\mp\gametypes\br_quest_util::registercreatequestlocale("scavenger_locale", &sq_createquestlocale);
  scripts\mp\gametypes\br_quest_util::ref_12b2b("scavenger_locale", &ref_13720);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("scavenger_locale", &sq_removelocaleinstance);
  scripts\mp\gametypes\br_quest_util::registercheckiflocaleisavailable("scavenger_locale", &sq_checkiflocaleisavailable);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("scavenger_locale", &sq_circletick);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("scavenger_locale", &ref_1371d);
  scripts\mp\gametypes\br_quest_util::ref_12b30("scavenger_locale", &ref_1372d);
  scripts\mp\gametypes\br_quest_util::ref_1297c("scavenger", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("scavenger", &ref_13723);
  var1 = [];
  GscBinSkip0(0x2e, 0, &scripts\mp\gametypes\br_quest_util::filtercondition_isdead);
}

function sq_removequestinstance() {
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_13726(var0) {
  if(var0.team == self.team) {
    var1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("scavenger_locale", self.team).playerlist = var1;

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

function ref_1371d(var0) {
  if(!gethillspawnshutofforigin(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
}

function ref_1372d(var0) {
  if(!gethillspawnshutofforigin(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("scavenger" + self.modifier);
  scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
}

function gethillspawnshutofforigin(var0) {
  if(var0.team == self.subscribedinstances[0].team) {
    return 1;
  }

  return 0;
}

function sq_createquestlocale(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("scavenger_locale", "scavenger", self.team);

  if(!isDefined(var0)) {
    var1.curorigin = (0, 0, 0);
    var1.enabled = 0;
    return var1;
  }

  var1.modifier = self.modifier;
  var1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_scavengerhunt_objective", "current");
  var1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var1.ref_12320 = 0;
  scripts\mp\gametypes\br_quest_util::addquestinstance("scavenger_locale", var1);
  ref_13258(var1, var0);
  return var1;
}

function ref_13720(var0) {
  self.ref_12320++;
  var1 = ref_13258(var0);
  var2 = scripts\engine\utility::ter_op(isDefined(var0.ref_11c4e), var0.ref_11c4e, "?");
  var3 = scripts\engine\utility::ter_op(isDefined(var0), var0.origin, "no origin");
  logstring("Scavenger Debug: " + var2 + " - moving - " + var3 + ", phaseIndex=" + self.ref_12320);

  if(var1) {
    logstring("Scavenger Debug: " + var2 + " - setup locale succeeded - " + var3);
    self.subscribedinstances[0].intelprogress = var0.origin;
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.subscribedinstances[0].team, "br_scavenger_quest_next_location");
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_next_nptarget", self.subscribedinstances[0].team, 1);

    if(istrue(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger").ref_12c83)) {
      self.subscribedinstances[0] scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger").ref_11c4c, 1);
      return;
    }

    self.subscribedinstances[0] scripts\mp\gametypes\br_quest_util::ref_1297b(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger").ref_11c4d);
    return;
  }

  logstring("Scavenger Debug: " + var2 + " - setup locale failed - " + var3);
}

function ref_13258(var0) {
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
  scripts\mp\gametypes\br_quest_util::ref_11db0(self.curorigin);
  ref_14016();
  return true;
}

function sq_removelocaleinstance() {
  lastdroppableweaponchanged();
  self.playerlist = undefined;
  self.subscribedinstances = undefined;

  if(isDefined(self.force_spawn_all_dead_players)) {
    if(self.force_spawn_all_dead_players getscriptablepartstate("body") == "scavenger_closed") {
      self.force_spawn_all_dead_players delete();
      return;
    }

    return;
  }
}

function sq_circletick(var0, var1) {
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

function sq_checkiflocaleisavailable() {
  return false;
}

function takequestitem(var0) {
  var1 = scripts\engine\utility::ter_op(isDefined(var0.index), var0.index, "?");

  if(!isDefined(var0.ref_12c4a) && !ref_13730(var0)) {
    logstring("Scavenger Debug: " + var1 + " - reservedPlacement undefined and no placements found.");
    var0 freescriptable();
    return;
  }

  var2 = scripts\mp\gametypes\br_quest_util::createquestinstance("scavenger", self.team, var0.index, var0);
  var2 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var2 scripts\mp\gametypes\br_quest_util::ref_12b15(self);
  var2.team = self.team;
  var2.startlocation = self.origin;
  var2.intelprogress = self.origin;
  var2.ref_12c4a = var0.ref_12c4a;
  var3 = "";

  if(var0.type == "brloot_redacted_scavenger_tablet") {
    var3 = "_redacted";
  }

  var2.modifier = var3;
  logstring("Scavenger Debug: " + var1 + " - pickup - " + var0.origin);

  for(var4 = 0; var4 < var2.ref_12c4a.size; var4++) {
    logstring("Scavenger Debug: " + var1 + " - reservedPlacement[" + var4 + "] - " + var2.ref_12c4a[var4].origin);
  }

  var5 = ref_11a00(var2.startlocation, var2.ref_12c4a[0]);
  var6 = var2 scripts\mp\gametypes\br_quest_util::requestquestlocale("scavenger_locale", var5, 1);

  if(!var6.enabled) {
    scripts\mp\utility\lower_message::ref_1316e("br_assassination_notargets", undefined, 5);
    var2.result = "no_locale";
    var2 scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
    var7 = spawnStruct();
    var7.origin = var0.origin;
    var7.angles = var0.angles;
    var7.itemsdropped = 0;

    if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
      var8 = "mp/loot_set_cache_contents_dmz.csv";
      var7 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "health", var8);
      var7 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 2, "ammo", var8);
      var7 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(1, 1, "plunder", var8);
      return;
    }

    var7 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "health");
    var7 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 2, "ammo");
    var7 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(1, 1, "plunder");
    return;
  }

  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("scavenger" + var3.modifier, self.team);
  var3.totalscavengeditems = 0;
  var3 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger").ref_11c4c, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("scavenger", var3);
  scripts\mp\gametypes\br_quest_util::ref_13879("scavenger", self, self.team);
  var9 = spawnStruct();
  var9.excludedplayers = [];
  var9.excludedplayers[0] = self;
  var9.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("scavenger", scripts\mp\gametypes\br_quest_util::ringing(self.team), var3.modifier);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_quest_start_team", var9);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_scavenger_quest_start_tablet_finder", var9);

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  }

  scripts\mp\gametypes\br_quest_util::lookforvehicles(var3.team, self, 6, scripts\mp\gametypes\br_quest_util::getquestindex("scavenger"));
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_scav_accept", var3.team, 1);
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
  var1 = scripts\mp\gametypes\br_gametypes::ref_12e05("overrideQuestSearchParams", "scavenger");

  if(isDefined(var1)) {
    return var1;
  }

  var2 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var2) {
    case "mini":
    case "gold_war":
    case "risk":
    case "rat_race":
    case "dmz":
      var0 = 1;
      break;
  }

  return var0;
}

function completescavengerquest(var0, var1) {
  var2 = spawnStruct();
  var3 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var4 = scripts\mp\gametypes\br_quest_util::getquestindex("scavenger" + self.modifier);
  var5 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("scavenger", self.modifier));
  var6 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(var1);
  var2.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var4, var3, var5, undefined, var6);

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_quest_complete", var2);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_scav_success", self.team, 1, 1);
  }

  self.ref_12d2e = var0.origin;
  self.ref_12d2b = var0.angles;
  self.result = "success";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function failscavengerquest() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_quest_circle_failure");
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
    var1 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("scavenger" + self.modifier);
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

function ref_13723() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function ref_13698(var0, var1, var2) {
  var3 = spawn("script_model", var0);
  var4 = var2.playerlist[0];
  var3.angles = var1;
  var3 setotherent(var4);
  var3 setModel("military_loot_crate_scavenger_ch3");
  var3 setscriptablepartstate("body", "scavenger_closed");
  var3.questlocale = var2;
  var2.force_spawn_all_dead_players = var3;

  foreach(var6 in level.players) {
    if(var6 != var4 && (var4.team == "none" || var6.team != var4.team)) {
      var3 disablescriptableplayeruse(var6);
    }
  }
}

function ref_12ed4(var0, var1, var2, var3, var4) {
  if(istrue(var3 scripts\mp\gametypes\br_gametypes::ref_12e05("playerSkipLootPickup", var0))) {
    return;
  }

  if(var2 == "scavenger_closed" && isDefined(var0.entity)) {
    var5 = var0.entity.questlocale.subscribedinstances[0];

    if(var3.team != var5.team) {
      var3 iprintlnbold("Chest Requires a Scavenger Mission");
      return;
    }

    var0 setscriptablepartstate("body", "scavenger_opening");
    var6 = getdvarint("scr_br_scavenger_cacheDeleteDelay", 30);
    var0.entity scripts\engine\utility::delaycallwatchself(var6, &delete);
    var5 scripts\mp\gametypes\br_quest_util::ref_12b15(var3);

    switch (var0.entity.questlocale.ref_12320) {
      case 0:
        scripts\mp\gametypes\br_quest_util::search_activate_battle_station("scavenger_1" + var5.modifier, var3.team, var0.origin, var0.angles, var5.ref_12d30);
        break;
      case 1:
        scripts\mp\gametypes\br_quest_util::search_activate_battle_station("scavenger_2" + var5.modifier, var3.team, var0.origin, var0.angles, var5.ref_12d30);
        break;
      case 3:
        break;
    }

    var7 = scripts\engine\utility::ter_op(isDefined(var5.ref_11c4e), var5.ref_11c4e, "?");

    if(var0.entity.questlocale.ref_12320 == 2) {
      var5.ref_12d2e = var0.origin;
      var5.ref_12d2b = var0.angles;
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var5.team, var3, 8, scripts\mp\gametypes\br_quest_util::getquestindex("scavenger"));
      completescavengerquest(var5, var0.entity, var3);
      logstring("Scavenger Debug: " + var7 + " - complete - " + var0.origin);
    } else {
      logstring("Scavenger Debug: " + var7 + " - move - " + var0.origin);
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var5.team, var3, 7, scripts\mp\gametypes\br_quest_util::getquestindex("scavenger"));
      var8 = ref_11a00(var0.origin, var5.ref_12c4a[var0.entity.questlocale.ref_12320 + 1]);
      var8.ref_11c4e = var5.ref_11c4e;
      var0.entity.questlocale scripts\mp\gametypes\br_quest_util::ref_11daf("scavenger_locale", var8);
    }

    level notify("lootcache_opened_kill_callout" + var0.origin);
    var9 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var3.team, 0);

    foreach(var11 in var9) {
      var11 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function ref_13730() {
  self.ref_12c4a = [];
  var0 = self.origin;

  for(var1 = 0; var1 < 3; var1++) {
    var2 = ref_11a00(var0);
    var3 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("scavenger", var2);

    if(!isDefined(var3)) {
      return false;
    }

    getlootspawnpointcount(var3.index);
    var0 = var3.origin;
    self.ref_12c4a[var1] = var3;
  }

  return true;
}