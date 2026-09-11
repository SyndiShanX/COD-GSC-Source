/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_geigerstash_quest.gsc
*********************************************************/

function init() {
  scripts\engine\scriptable::ref_12f5b("body", &postspawn_rpg);
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("geigerstash", 1);

  if(!var_0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("geigerstash").ref_12fa0 = getdvarint("scr_br_geigerstash_searchCircleSize", 7000);
  scripts\mp\gametypes\br_quest_util::getquestdata("geigerstash").ref_11c4c = getdvarint("scr_br_geigerstash_missionTimeBase", 180);
  scripts\mp\gametypes\br_quest_util::ref_12b3d("geigerstash", &postspawn_sniper);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("geigerstash", &postspawn_assault3_bombers);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("geigerstash", &postplunder);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("geigerstash", &postgamestate);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("geigerstash", &postkillcamplunderlost);
  scripts\mp\gametypes\br_quest_util::ref_12b30("geigerstash", &postspawn_initial_allies);
  scripts\mp\gametypes\br_quest_util::ref_1297c("geigerstash", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("geigerstash", &postlaunchscenenodecorrection);
}

function postspawn_sniper() {
  var_0 = self.origin;
  var_1 = ref_11a00(var_0);
  var_2 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("geigerstash", var_1);

  if(!isDefined(var_2)) {
    return false;
  }

  getlootspawnpointcount(var_2.index);
  var_0 = var_2.origin;
  self.ref_12c4a = var_2;
  return true;
}

function postgamestate(var_0, var_1) {
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
    pathstruct();
    return;
  }
}

function postkillcamplunderlost(var_0) {
  if(!gethillspawnshutofforigin(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function postspawn_initial_allies(var_0) {
  if(!gethillspawnshutofforigin(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("geigerstash");
}

function postlaunchscenenodecorrection() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_geigerstash_quest_timer_expired");
  var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](self.team, 0);
  postshipmodifychevrons(var_0);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function postshipmodifychevrons(var_0) {
  var_1 = "secondary";
  var_2 = "equip_geiger_counter";
  var_0[0] scripts\mp\equipment::ref_13a30(var_0, var_1, var_2, 0);

  foreach(var_4 in var_0) {
    if(isDefined(var_4.modespawnclient)) {
      scripts\mp\gametypes\br_pickups::ref_11a21(var_4.modespawnclient);
    }
  }
}

function postspawn_assault3_bombers() {
  lastboredscore();

  foreach(var_1 in self.playerlist) {
    var_1 setclientomnvar("ui_br_geiger_target", -1);
  }

  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function postplunder(var_0) {
  if(var_0.team == self.team) {
    var_1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("geigerstash", self.team).playerlist = var_1;

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
  if(var_0.team == self.team) {
    return 1;
  }

  return 0;
}

function takequestitem(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::createquestinstance("geigerstash", self.team, var_0.index, var_0);
  var_1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var_1 scripts\mp\gametypes\br_quest_util::ref_12b15(self);
  var_1.team = self.team;
  var_1.startlocation = self.origin;
  var_1.intelprogress = self.origin;
  var_1.ref_12c4a = var_0.ref_12c4a;
  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var_2 = ref_11a00(var_1.startlocation, var_1.ref_12c4a);
  ref_13659(var_1, var_1.ref_12c4a.origin, var_1.ref_12c4a.angles);
  ref_13fdc(var_1);
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("geigerstash", self.team);
  var_1 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("geigerstash").ref_11c4c, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("geigerstash", var_1);
  scripts\mp\gametypes\br_quest_util::ref_13879("geigerstash", self, self.team);
  var_3 = spawnStruct();
  var_3.excludedplayers = [];
  var_3.excludedplayers[0] = self;
  var_3.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("geigerstash", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_geigerstash_quest_start_team_notify", var_3);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_geigerstash_quest_start_tablet_finder", var_3);
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
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
  var_2.mintime = 60;

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race") {
    if(var_2.ref_12fa6 < level.ref_12969) {
      var_2.ref_12fa6 = level.ref_12969;
    }

    var_2.ref_12fa4 = level.ref_12969;
    var_2.ref_12fa5 = level.ref_1296a;
  }

  return var_2;
}

function ref_13659(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_3 = self.playerlist[0];
  var_2.angles = var_1;
  var_2 setotherent(var_3);
  var_2 setModel("military_loot_crate_01_br_geigerstash_01");
  var_2 setscriptablepartstate("body", "geigerstash_closed");
  var_2.ref_12970 = self;
  self.force_spawn_all_dead_players = var_2;
  var_2.ref_12970.curorigin = var_2.origin;

  foreach(var_5 in level.players) {
    if(var_5 != var_3 && (var_3.team == "none" || var_5.team != var_3.team)) {
      var_2 disablescriptableplayeruse(var_5);
    }
  }

  var_7 = "secondary";
  var_8 = "equip_geiger_counter";
  self.playerlist[0] scripts\mp\equipment::scriptablescleanupbatchsize(self.playerlist, var_7, var_8);
  var_9 = self.force_spawn_all_dead_players getentitynumber();

  foreach(var_5 in self.playerlist) {
    var_5 setclientomnvar("ui_br_geiger_target", var_9);
  }
}

function ref_13fdc() {
  var_0 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(self.playerlist);

  foreach(var_2 in var_0["valid"]) {
    var_2 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("geigerstash");
  }

  foreach(var_2 in var_0["invalid"]) {
    var_2 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  }
}

function spawn_carriables_from_scriptables_individual_percentage(var_0) {
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function lastboredscore() {
  foreach(var_1 in self.playerlist) {
    spawn_carriables_from_scriptables_individual_percentage(var_1);
  }
}

function postspawn_rpg(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_3 scripts\mp\gametypes\br_gametypes::ref_12e05("playerSkipLootPickup", var_0))) {
    return;
  }

  if(var_2 == "geigerstash_closed" && isDefined(var_0.entity)) {
    var_5 = var_0.entity.ref_12970;

    if(istrue(var_5.removed)) {
      var_3 scripts\mp\utility\lower_message::ref_1316e("contract_expired", undefined, 5);
      return;
    }

    var_0 setscriptablepartstate("body", "geigerstash_opening");
    var_6 = getdvarint("scr_br_geigerstash_cacheDeleteDelay", 30);
    var_0.entity scripts\engine\utility::delaycallwatchself(var_6, &delete);
    var_5.ref_12d2e = var_0.origin;
    var_5.ref_12d2b = var_0.angles;
    hint_escape_maze(var_5, var_0.entity);
    level notify("lootcache_opened_kill_callout" + var_0.origin);
    var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_3.team, 0);

    foreach(var_9 in var_7) {
      var_9 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    postshipmodifychevrons(var_7);
    return;
  }
}

function hint_escape_maze(var_0) {
  var_1 = spawnStruct();
  var_2 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_3 = scripts\mp\gametypes\br_quest_util::getquestindex("geigerstash");
  var_4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("geigerstash"));
  var_1.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var_3, var_2, var_4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_geigerstash_quest_complete", var_1);
  self.ref_12d2e = var_0.origin;
  self.ref_12d2b = var_0.angles;
  self.result = "success";

  foreach(var_6 in self.playerlist) {
    var_6 setclientomnvar("ui_br_geiger_target", -1);
  }

  scripts\mp\gametypes\br_quest_util::removequestinstance();

  foreach(var_6 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    var_6 scripts\cp\vehicles\vehicle_compass_cp::ref_12004("br_geiger_contract");
  }
}

function pathstruct() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_geigerstash_quest_circle_failure");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_circle_fail", self.team, 1);
  self.result = "fail";

  foreach(var_1 in self.playerlist) {
    var_1 setclientomnvar("ui_br_geiger_target", -1);
  }

  scripts\mp\gametypes\br_quest_util::removequestinstance();
}