/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_geigerstash_quest.gsc
*********************************************************/

function init() {
  scripts\engine\scriptable::ref_12f5b("body", &postspawn_rpg);
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("geigerstash", 1);

  if(!var0) {
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
  var0 = self.origin;
  var1 = ref_11a00(var0);
  var2 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("geigerstash", var1);

  if(!isDefined(var2)) {
    return false;
  }

  getlootspawnpointcount(var2.index);
  var0 = var2.origin;
  self.ref_12c4a = var2;
  return true;
}

function postgamestate(var0, var1) {
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
    pathstruct();
    return;
  }
}

function postkillcamplunderlost(var0) {
  if(!gethillspawnshutofforigin(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function postspawn_initial_allies(var0) {
  if(!gethillspawnshutofforigin(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("geigerstash");
}

function postlaunchscenenodecorrection() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_geigerstash_quest_timer_expired");
  var0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](self.team, 0);
  postshipmodifychevrons(var0);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function postshipmodifychevrons(var0) {
  var1 = "secondary";
  var2 = "equip_geiger_counter";
  var0[0] scripts\mp\equipment::ref_13a30(var0, var1, var2, 0);

  foreach(var4 in var0) {
    if(isDefined(var4.modespawnclient)) {
      scripts\mp\gametypes\br_pickups::ref_11a21(var4.modespawnclient);
    }
  }
}

function postspawn_assault3_bombers() {
  lastboredscore();

  foreach(var1 in self.playerlist) {
    var1 setclientomnvar("ui_br_geiger_target", -1);
  }

  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function postplunder(var0) {
  if(var0.team == self.team) {
    var1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("geigerstash", self.team).playerlist = var1;

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
  if(var0.team == self.team) {
    return 1;
  }

  return 0;
}

function takequestitem(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createquestinstance("geigerstash", self.team, var0.index, var0);
  var1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var1 scripts\mp\gametypes\br_quest_util::ref_12b15(self);
  var1.team = self.team;
  var1.startlocation = self.origin;
  var1.intelprogress = self.origin;
  var1.ref_12c4a = var0.ref_12c4a;
  var1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var2 = ref_11a00(var1.startlocation, var1.ref_12c4a);
  ref_13659(var1, var1.ref_12c4a.origin, var1.ref_12c4a.angles);
  ref_13fdc(var1);
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("geigerstash", self.team);
  var1 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("geigerstash").ref_11c4c, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("geigerstash", var1);
  scripts\mp\gametypes\br_quest_util::ref_13879("geigerstash", self, self.team);
  var3 = spawnStruct();
  var3.excludedplayers = [];
  var3.excludedplayers[0] = self;
  var3.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("geigerstash", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_geigerstash_quest_start_team_notify", var3);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_geigerstash_quest_start_tablet_finder", var3);
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
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

function ref_13659(var0, var1) {
  var2 = spawn("script_model", var0);
  var3 = self.playerlist[0];
  var2.angles = var1;
  var2 setotherent(var3);
  var2 setModel("military_loot_crate_01_br_geigerstash_01");
  var2 setscriptablepartstate("body", "geigerstash_closed");
  var2.ref_12970 = self;
  self.force_spawn_all_dead_players = var2;
  var2.ref_12970.curorigin = var2.origin;

  foreach(var5 in level.players) {
    if(var5 != var3 && (var3.team == "none" || var5.team != var3.team)) {
      var2 disablescriptableplayeruse(var5);
    }
  }

  var7 = "secondary";
  var8 = "equip_geiger_counter";
  self.playerlist[0] scripts\mp\equipment::scriptablescleanupbatchsize(self.playerlist, var7, var8);
  var9 = self.force_spawn_all_dead_players getentitynumber();

  foreach(var5 in self.playerlist) {
    var5 setclientomnvar("ui_br_geiger_target", var9);
  }
}

function ref_13fdc() {
  var0 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(self.playerlist);

  foreach(var2 in var0["valid"]) {
    var2 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("geigerstash");
  }

  foreach(var2 in var0["invalid"]) {
    var2 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  }
}

function spawn_carriables_from_scriptables_individual_percentage(var0) {
  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function lastboredscore() {
  foreach(var1 in self.playerlist) {
    spawn_carriables_from_scriptables_individual_percentage(var1);
  }
}

function postspawn_rpg(var0, var1, var2, var3, var4) {
  if(istrue(var3 scripts\mp\gametypes\br_gametypes::ref_12e05("playerSkipLootPickup", var0))) {
    return;
  }

  if(var2 == "geigerstash_closed" && isDefined(var0.entity)) {
    var5 = var0.entity.ref_12970;

    if(istrue(var5.removed)) {
      var3 scripts\mp\utility\lower_message::ref_1316e("contract_expired", undefined, 5);
      return;
    }

    var0 setscriptablepartstate("body", "geigerstash_opening");
    var6 = getdvarint("scr_br_geigerstash_cacheDeleteDelay", 30);
    var0.entity scripts\engine\utility::delaycallwatchself(var6, &delete);
    var5.ref_12d2e = var0.origin;
    var5.ref_12d2b = var0.angles;
    hint_escape_maze(var5, var0.entity);
    level notify("lootcache_opened_kill_callout" + var0.origin);
    var7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var3.team, 0);

    foreach(var9 in var7) {
      var9 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    postshipmodifychevrons(var7);
    return;
  }
}

function hint_escape_maze(var0) {
  var1 = spawnStruct();
  var2 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var3 = scripts\mp\gametypes\br_quest_util::getquestindex("geigerstash");
  var4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("geigerstash"));
  var1.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var3, var2, var4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_geigerstash_quest_complete", var1);
  self.ref_12d2e = var0.origin;
  self.ref_12d2b = var0.angles;
  self.result = "success";

  foreach(var6 in self.playerlist) {
    var6 setclientomnvar("ui_br_geiger_target", -1);
  }

  scripts\mp\gametypes\br_quest_util::removequestinstance();

  foreach(var6 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    var6 scripts\cp\vehicles\vehicle_compass_cp::ref_12004("br_geiger_contract");
  }
}

function pathstruct() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_geigerstash_quest_circle_failure");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_circle_fail", self.team, 1);
  self.result = "fail";

  foreach(var1 in self.playerlist) {
    var1 setclientomnvar("ui_br_geiger_target", -1);
  }

  scripts\mp\gametypes\br_quest_util::removequestinstance();
}