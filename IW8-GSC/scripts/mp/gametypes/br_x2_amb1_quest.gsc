/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_x2_amb1_quest.gsc
*****************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("x2_amb1", 0);

  if(!var_0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("x2_amb1").ref_11C4C = getdvarint("scr_br_x2_amb1_missionTimeBase", 240);
  scripts\mp\gametypes\br_quest_util::getquestdata("x2_amb1").brmodevariantrewardcullfunc = getdvarint("scr_br_x2_amb1_ambushCircleSize", 3000);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("x2_amb1", &ref_14647);
  scripts\mp\gametypes\br_quest_util::ref_12B2E("x2_amb1", &ref_14646);
  scripts\mp\gametypes\br_quest_util::ref_12B30("x2_amb1", &ref_14648);
  scripts\mp\gametypes\br_quest_util::registerquestthink("x2_amb1", &ref_14649, 0.05);
  scripts\mp\gametypes\br_quest_util::ref_1297C("x2_amb1", 0);
  scripts\mp\gametypes\br_quest_util::ref_12B31("x2_amb1", &ref_14645);
  scripts\mp\gametypes\br_quest_util::ref_12B38("x2_amb_signal");
  init_range();
}

function init_range() {
  var_0 = [];

  if(level.mapname == "mp_br_mechanics") {
    GscBinSkip0(0x2e, 0, (-483, -2260, 30));
  }

  GscBinSkip0(0x2e, 0, (4695, 306, -215));
}

function ref_14648(var_0) {
  if(!gethillspawnshutofforigin(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow(resetchallengetimers());
  scripts\mp\gametypes\br_quest_util::ref_1336C(var_0);
}

function ref_14645() {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function ref_14647() {
  last_target();
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_14646(var_0) {
  if(var_0.team == self.team) {
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
  var_5 = scripts\mp\gametypes\br_gametype_x2::extra_riders_getin_anim_func("x2_amb1", var_0, var_1, var_4);
  var_5.initprematchc130 = level.ref_14632;
  var_6 = undefined;
  var_7 = undefined;

  switch (level.ref_1464E) {
    case "signal":
      var_6 = 13;
      var_7 = "br_x2_amb1_signal_quest_start_team_notify";
      break;
    case "bomb":
    default:
      var_6 = 12;
      var_7 = "br_x2_amb1_quest_start_team_notify";
      break;
  }

  var_8 = scripts\mp\gametypes\br_quest_util::getquestdata("x2_amb1").destination[var_5.initprematchc130].origin;
  var_5 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(4, var_6, 0, var_8);
  var_5 scripts\mp\gametypes\br_quest_util::ref_1316F(scripts\mp\gametypes\br_quest_util::getquestdata("x2_amb1").brmodevariantrewardcullfunc);

  foreach(var_2 in var_5.playerlist) {
    var_2.ref_1296E = var_8;
  }

  ref_14031(var_5);
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam(resetchallengetimers(), self.team);
  var_5 scripts\mp\gametypes\br_quest_util::ref_1297D(scripts\mp\gametypes\br_quest_util::getquestdata("x2_amb1").ref_11C4C, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("x2_amb1", var_5);
  scripts\mp\gametypes\br_quest_util::ref_13879("x2_amb1", self, self.team);
  var_11 = spawnStruct();
  var_11.ref_127D5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("x2_amb1", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, var_7, var_11);
  return var_5;
}

function ref_14031() {
  foreach(var_1 in self.playerlist) {
    var_1 scripts\mp\gametypes\br_quest_util::uiobjectiveshow(resetchallengetimers());
    scripts\mp\gametypes\br_quest_util::ref_1336A(var_1);
  }
}

function calculatehelispawndata() {
  return scripts\mp\gametypes\br_gametype_x2::enemy_signal_flare("x2_amb1", &search);
}

function ref_14649() {
  if(istrue(self.playermonitorspectatorcycle) || scripts\mp\flags::gameflag("x2_train_destroyed")) {
    path_loop();
  }

  if(scripts\mp\flags::gameflag("x2_ambush" + self.initprematchc130 + 1 + "_completed")) {
    ref_14644();
    return;
  }
}

function ref_14644() {
  var_0 = spawnStruct();
  var_1 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_2 = scripts\mp\gametypes\br_quest_util::getquestindex("x2_amb1");
  var_3 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("x2_amb1"));
  var_0.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_2, var_1, var_3);
  self.ref_12D2E = self.playerlist[0].origin;
  self.ref_12D2B = self.playerlist[0].angles;
  self.result = "success";
  self.ref_11EBA = 1;
  scripts\mp\gametypes\br_gametype_x2::extract_ontimerexpired(self);
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function path_loop() {
  scripts\mp\gametypes\br_gametype_x2::extract_ontimerexpired(self);
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function spawn_boxes(var_0) {
  scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_0);
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function last_target() {
  foreach(var_1 in self.playerlist) {
    if(isDefined(var_1)) {
      spawn_boxes(var_1);
    }
  }
}

function resetchallengetimers() {
  var_0 = undefined;

  switch (level.ref_1464E) {
    case "signal":
      var_0 = "x2_amb_signal";
      break;
    case "bomb":
    default:
      var_0 = "x2_amb1";
      break;
  }

  return var_0;
}