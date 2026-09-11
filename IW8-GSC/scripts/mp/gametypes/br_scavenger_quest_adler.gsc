/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_scavenger_quest_adler.gsc
*************************************************************/

function init() {
  scripts\engine\scriptable::ref_12f5b("body", &ref_12ed5);
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("scavenger_adler", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b2a("scavenger_adler", "brloot_scavenger_tablet_adler");

  if(!var0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_adler").ref_12fa0 = getdvarint("scr_br_adler_searchCircleSize", 1000);
  scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_adler").ref_11c4c = getdvarint("scr_br_adler_missionTimeBase", 300);
  scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_adler").ref_11c4d = getdvarint("scr_br_adler_missionTimeBonus", 60);
  scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_adler").ref_12c83 = getdvarint("scr_br_adler_resetTimerOnPickup", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b3d("scavenger_adler", &ref_13731);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("scavenger_adler", &ref_1372b);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("scavenger_adler", &ref_13727);
  scripts\mp\gametypes\br_quest_util::registerquestlocale("scavenger_locale_adler");
  scripts\mp\gametypes\br_quest_util::registercreatequestlocale("scavenger_locale_adler", &ref_1371b);
  scripts\mp\gametypes\br_quest_util::ref_12b2b("scavenger_locale_adler", &ref_13721);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("scavenger_locale_adler", &ref_13729);
  scripts\mp\gametypes\br_quest_util::registercheckiflocaleisavailable("scavenger_locale_adler", &ref_13717);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("scavenger_locale_adler", &ref_13719);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("scavenger_locale_adler", &ref_1371e);
  scripts\mp\gametypes\br_quest_util::ref_12b30("scavenger_locale_adler", &ref_1372e);
  scripts\mp\gametypes\br_quest_util::ref_1297c("scavenger_adler", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("scavenger_adler", &ref_13724);
  var1 = [];
  GscBinSkip0(0x2e, 0, &scripts\mp\gametypes\br_quest_util::filtercondition_isdead);
}

function ref_1372b() {
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_13727(var0) {
  if(var0.team == self.team) {
    var1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("scavenger_locale_adler", self.team).playerlist = var1;

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

function ref_1371e(var0) {
  if(!gethillspawnshutoffradius(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
}

function ref_1372e(var0) {
  if(!gethillspawnshutoffradius(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("scavenger_adler");
  scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
}

function gethillspawnshutoffradius(var0) {
  if(var0.team == self.subscribedinstances[0].team) {
    return 1;
  }

  return 0;
}

function ref_1371b(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("scavenger_locale_adler", "scavenger_adler", self.team);

  if(!isDefined(var0)) {
    var1.curorigin = (0, 0, 0);
    var1.enabled = 0;
    return var1;
  }

  var1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_h4a_objective", "current");
  var1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var1.ref_12320 = 0;
  scripts\mp\gametypes\br_quest_util::addquestinstance("scavenger_locale_adler", var1);
  ref_13259(var1, var0);
  return var1;
}

function ref_13721(var0) {
  self.ref_12320++;
  var1 = ref_13259(var0);

  if(var1) {
    self.subscribedinstances[0].intelprogress = var0.origin;
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.subscribedinstances[0].team, "br_scavenger_adler_quest_next_location");
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_next_nptarget", self.subscribedinstances[0].team, 1);

    if(istrue(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_adler").ref_12c83)) {
      self.subscribedinstances[0] scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_adler").ref_11c4c, 1);
      return;
    }

    self.subscribedinstances[0] scripts\mp\gametypes\br_quest_util::ref_1297b(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_adler").ref_11c4d);
    return;
  }
}

function ref_13259(var0) {
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

function ref_13729() {
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

function ref_13719(var0, var1) {
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

function ref_13717() {
  return false;
}

function takequestitem(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createquestinstance("scavenger_adler", self.team, var0.index, var0);
  var1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var1 scripts\mp\gametypes\br_quest_util::ref_12b15(self);
  var1.team = self.team;
  var1.startlocation = self.origin;
  var1.intelprogress = self.origin;
  var1.ref_12c4a = var0.ref_12c4a;
  var2 = ref_11a00(var1.startlocation, var1.ref_12c4a[0]);
  var3 = var1 scripts\mp\gametypes\br_quest_util::requestquestlocale("scavenger_locale_adler", var2, 1);

  if(!var3.enabled) {
    scripts\mp\utility\lower_message::ref_1316e("br_assassination_notargets", undefined, 5);
    var1.result = "no_locale";
    var1 scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
    var4 = spawnStruct();
    var4.origin = var0.origin;
    var4.angles = var0.angles;
    var4.itemsdropped = 0;

    if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk") {
      var5 = "mp/loot_set_cache_contents_dmz.csv";
      var4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "health", var5);
      var4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 2, "ammo", var5);
      var4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(1, 1, "plunder", var5);
      return;
    }

    var4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "health");
    var4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 2, "ammo");
    var4 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(1, 1, "plunder");
    return;
  }

  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("scavenger_adler", self.team);
  var2.totalscavengeditems = 0;
  var2 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("scavenger_adler").ref_11c4c, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("scavenger_adler", var2);
  scripts\mp\gametypes\br_quest_util::ref_13879("scavenger_adler", self, self.team);
  var6 = spawnStruct();
  var6.excludedplayers = [];
  var6.excludedplayers[0] = self;
  var6.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("scavenger_adler", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_adler_quest_start_team", var6);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_scavenger_adler_quest_start_tablet_finder", var6);

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  }

  scripts\mp\gametypes\br_quest_util::lookforvehicles(var2.team, self, 6, scripts\mp\gametypes\br_quest_util::getquestindex("scavenger_adler"));
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_accept", var2.team, 1);
  var7 = distance2d(var2.startlocation, (52289, -19660, 248));
  var8 = distance2d(var2.startlocation, (-7091, 5857, 661));
  var9 = distance2d(var2.startlocation, (-22956, 50865, 3629));
  var10 = var7;
  var2.binoculars_getmaxrange = "farms";

  if(var8 < var10) {
    var10 = var8;
    var2.binoculars_getmaxrange = "factory";
  }

  if(var9 < var10) {
    var10 = var9;
    var2.binoculars_getmaxrange = "summit";
    return;
  }
}

function ref_11a00(var0, var1) {
  var2 = spawnStruct();
  var2.ref_12fa3 = "getUnusedLootCacheArray";
  var2.ref_12f9f = var0;
  var2.ref_12fa6 = 15000;
  var2.ref_12fa7 = 0;
  var2.ref_12fa4 = 6500;
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
  var1 = scripts\mp\gametypes\br_gametypes::ref_12e05("overrideQuestSearchParams", "scavenger_adler");

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

function hint_seq_button(var0) {
  var1 = spawnStruct();
  var2 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var3 = scripts\mp\gametypes\br_quest_util::getquestindex("scavenger_adler");
  var4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("scavenger_adler"));
  var1.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var3, var2, var4);

  if(!scripts\mp\gametypes\br_public::validtousesticker()) {
    scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_adler_quest_complete", var1);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_misc_success", self.team, 1, 1);
  }

  var5 = "";

  switch (self.binoculars_getmaxrange) {
    case "farms":
      var5 = "t9_ch_global_complete_intel_contract_at_farms_for_s3_event_wz";
      break;
    case "factory":
      var5 = "t9_ch_global_complete_intel_contract_at_factory_for_s3_event_wz";
      break;
    case "summit":
      var5 = "t9_ch_global_complete_intel_contract_at_summit_for_s3_event_wz";
      break;
  }

  foreach(var7 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    var7 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f(var5, 1);
  }

  self.ref_12d2e = var0.origin;
  self.ref_12d2b = var0.angles;
  self.result = "success";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function failscavengerquest() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_adler_quest_circle_failure");
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
    var1 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("scavenger_adler");
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

function ref_13724() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_scavenger_adler_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function ref_13698(var0, var1, var2) {
  var3 = spawn("script_model", var0);
  var4 = var2.playerlist[0];
  var3.angles = var1;
  var3 setotherent(var4);
  var3 setModel("military_loot_crate_01_br_scavenger_01_adler");
  var5 = "military_loot_crate_01_br_scavenger_01_adler";
  var3 setscriptablepartstate("body", "scavenger_adler_closed");
  var3.questlocale = var2;
  var2.force_spawn_all_dead_players = var3;

  foreach(var7 in level.players) {
    if(var7 != var4 && (var4.team == "none" || var7.team != var4.team)) {
      var3 disablescriptableplayeruse(var7);
    }
  }
}

function ref_12ed5(var0, var1, var2, var3, var4) {
  if(istrue(var3 scripts\mp\gametypes\br_gametypes::ref_12e05("playerSkipLootPickup", var0))) {
    return;
  }

  if(var2 == "scavenger_adler_closed" && isDefined(var0.entity)) {
    var5 = var0.entity.questlocale.subscribedinstances[0];

    if(var3.team != var5.team) {
      var3 iprintlnbold("Chest Requires a Scavenger Mission");
      return;
    }

    var0 setscriptablepartstate("body", "scavenger_adler_opening");
    var6 = getdvarint("scr_br_scavenger_cacheDeleteDelay", 30);
    var0.entity scripts\engine\utility::delaycallwatchself(var6, &delete);
    var5 scripts\mp\gametypes\br_quest_util::ref_12b15(var3);

    switch (var0.entity.questlocale.ref_12320) {
      case 0:
        scripts\mp\gametypes\br_quest_util::search_activate_battle_station("scavenger_1", var3.team, var0.origin, var0.angles, var5.ref_12d30);
        break;
      case 1:
        scripts\mp\gametypes\br_quest_util::search_activate_battle_station("scavenger_2", var3.team, var0.origin, var0.angles, var5.ref_12d30);
        break;
      case 3:
        break;
    }

    if(var0.entity.questlocale.ref_12320 == 2) {
      var5.ref_12d2e = var0.origin;
      var5.ref_12d2b = var0.angles;
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var5.team, var3, 8, scripts\mp\gametypes\br_quest_util::getquestindex("scavenger_adler"));
      hint_seq_button(var5, var0.entity);
    } else {
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var5.team, var3, 7, scripts\mp\gametypes\br_quest_util::getquestindex("scavenger_adler"));
      var7 = ref_11a00(var0.origin, var5.ref_12c4a[var0.entity.questlocale.ref_12320 + 1]);
      var0.entity.questlocale scripts\mp\gametypes\br_quest_util::ref_11daf("scavenger_locale_adler", var7);
    }

    level notify("lootcache_opened_kill_callout" + var0.origin);
    var8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var3.team, 0);

    foreach(var10 in var8) {
      var10 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function ref_13731() {
  self.ref_12c4a = [];
  var0 = self.origin;

  for(var1 = 0; var1 < 3; var1++) {
    var2 = ref_11a00(var0);
    var3 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("scavenger_adler", var2);

    if(!isDefined(var3)) {
      return false;
    }

    getlootspawnpointcount(var3.index);
    var0 = var3.origin;
    self.ref_12c4a[var1] = var3;
  }

  return true;
}