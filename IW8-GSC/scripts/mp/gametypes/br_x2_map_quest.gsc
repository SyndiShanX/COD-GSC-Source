/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_x2_map_quest.gsc
****************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("x2_map", 0);

  if(!var_0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("x2_map", &ref_1465D);
  scripts\mp\gametypes\br_quest_util::ref_12B2E("x2_map", &ref_1465C);
  scripts\mp\gametypes\br_quest_util::ref_12B30("x2_map", &ref_1465E);
  scripts\mp\gametypes\br_quest_util::registerquestthink("x2_map", &ref_1465F, 0.05);
  init_range();
}

function init_range() {
  var_0 = [];

  if(level.mapname == "mp_br_mechanics") {
    GscBinSkip0(0x2e, 0, (-483, -2260, 30));
  }

  GscBinSkip0(0x2e, 0, (4695, 306, -215));
}

function search(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\gametypes\br_gametype_x2::extra_riders_getin_anim_func("x2_map", var_0, var_1, var_4);
  var_5.initprematchc130 = level.ref_14632;
  var_5.ref_1296E = scripts\mp\gametypes\br_quest_util::getquestdata("x2_map").destination[var_5.initprematchc130].origin;
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("x2_map", self.team);
  scripts\mp\gametypes\br_quest_util::addquestinstance("x2_map", var_5);
  scripts\mp\gametypes\br_quest_util::ref_13879("x2_map", self, self.team);
  var_6 = spawnStruct();
  var_6.ref_127D5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("x2_map", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_x2_attack_quest_start_team_notify", var_6);
  var_7 = scripts\mp\gametypes\br_quest_util::getquestdata("x2_map").destination.size;

  if(!scripts\mp\flags::gameflag("x2_ambush" + var_7 + "_starting") && istrue(level.ref_13396)) {
    thread ref_14660();
  }

  return var_5;
}

function ref_14659() {
  var_0 = spawnStruct();
  var_1 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_2 = scripts\mp\gametypes\br_quest_util::getquestindex("x2_map");
  var_3 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("x2_map"));
  var_0.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_2, var_1, var_3);
  self.ref_12D2E = self.playerlist[0].origin;
  self.ref_12D2B = self.playerlist[0].angles;
  self.result = "success";
  self.ref_11EBA = 1;
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_1465D() {
  foreach(var_1 in self.playerlist) {
    if(isDefined(var_1)) {
      var_1 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
    }
  }
}

function ref_1465C(var_0) {
  if(var_0.team == self.team) {
    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var_0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function ref_1465E(var_0) {
  if(!gethillspawnshutofforigin(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("x2_map");
  scripts\mp\gametypes\br_quest_util::ref_1336C(var_0);
}

function calculatehelispawndata() {
  return scripts\mp\gametypes\br_gametype_x2::enemy_signal_flare("x2_map", &search);
}

function ref_14660() {
  level endon("game_ended");
  var_0 = level.ref_145F1.ref_13C8D[0];
  var_1 = scripts\mp\gametypes\br_quest_util::getquestdata("x2_map").destination.size;
  var_2 = 20000;

  if(self.initprematchc130 == var_1 - 1) {
    var_2 = 20000;
  }

  ref_143FD(var_0, self.ref_1296E, var_2);
  ref_14659();
}

function ref_143FD(var_0, var_1, var_2) {
  var_3 = var_2 * var_2;

  while(length2dsquared(var_0.origin - var_1) > var_3) {
    waitframe();
  }
}

function ref_1465F() {
  if(scripts\mp\flags::gameflag("x2_train_destroyed")) {
    ref_14659();
    return;
  }
}

function gethillspawnshutofforigin(var_0) {
  return scripts\mp\gametypes\br_gametype_x2::extra_riders_func(var_0);
}