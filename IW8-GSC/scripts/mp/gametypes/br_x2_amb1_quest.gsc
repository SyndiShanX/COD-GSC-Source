/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_x2_amb1_quest.gsc
*****************************************************/

function init() {
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("x2_amb1", 0);

  if(!var0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("x2_amb1").ref_11c4c = getdvarint("scr_br_x2_amb1_missionTimeBase", 240);
  scripts\mp\gametypes\br_quest_util::getquestdata("x2_amb1").brmodevariantrewardcullfunc = getdvarint("scr_br_x2_amb1_ambushCircleSize", 3000);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("x2_amb1", &ref_14647);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("x2_amb1", &ref_14646);
  scripts\mp\gametypes\br_quest_util::ref_12b30("x2_amb1", &ref_14648);
  scripts\mp\gametypes\br_quest_util::registerquestthink("x2_amb1", &ref_14649, 0.05);
  scripts\mp\gametypes\br_quest_util::ref_1297c("x2_amb1", 0);
  scripts\mp\gametypes\br_quest_util::ref_12b31("x2_amb1", &ref_14645);
  scripts\mp\gametypes\br_quest_util::ref_12b38("x2_amb_signal");
  init_range();
}

function init_range() {
  var0 = [];

  if(level.mapname == "mp_br_mechanics") {
    GscBinSkip0(0x2e, 0, (-483, -2260, 30));
  }

  GscBinSkip0(0x2e, 0, (4695, 306, -215));
}

function ref_14648(var0) {
  if(!gethillspawnshutofforigin(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow(resetchallengetimers());
  scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
}

function ref_14645() {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function ref_14647() {
  last_target();
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_14646(var0) {
  if(var0.team == self.team) {
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
  var5 = scripts\mp\gametypes\br_gametype_x2::extra_riders_getin_anim_func("x2_amb1", var0, var1, var4);
  var5.initprematchc130 = level.ref_14632;
  var6 = undefined;
  var7 = undefined;

  switch (level.ref_1464e) {
    case "signal":
      var6 = 13;
      var7 = "br_x2_amb1_signal_quest_start_team_notify";
      break;
    case "bomb":
    default:
      var6 = 12;
      var7 = "br_x2_amb1_quest_start_team_notify";
      break;
  }

  var8 = scripts\mp\gametypes\br_quest_util::getquestdata("x2_amb1").destination[var5.initprematchc130].origin;
  var5 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(4, var6, 0, var8);
  var5 scripts\mp\gametypes\br_quest_util::ref_1316f(scripts\mp\gametypes\br_quest_util::getquestdata("x2_amb1").brmodevariantrewardcullfunc);

  foreach(var2 in var5.playerlist) {
    var2.ref_1296e = var8;
  }

  ref_14031(var5);
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam(resetchallengetimers(), self.team);
  var5 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("x2_amb1").ref_11c4c, 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("x2_amb1", var5);
  scripts\mp\gametypes\br_quest_util::ref_13879("x2_amb1", self, self.team);
  var11 = spawnStruct();
  var11.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("x2_amb1", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, var7, var11);
  return var5;
}

function ref_14031() {
  foreach(var1 in self.playerlist) {
    var1 scripts\mp\gametypes\br_quest_util::uiobjectiveshow(resetchallengetimers());
    scripts\mp\gametypes\br_quest_util::ref_1336a(var1);
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
  var0 = spawnStruct();
  var1 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var2 = scripts\mp\gametypes\br_quest_util::getquestindex("x2_amb1");
  var3 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("x2_amb1"));
  var0.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var2, var1, var3);
  self.ref_12d2e = self.playerlist[0].origin;
  self.ref_12d2b = self.playerlist[0].angles;
  self.result = "success";
  self.ref_11eba = 1;
  scripts\mp\gametypes\br_gametype_x2::extract_ontimerexpired(self);
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function path_loop() {
  scripts\mp\gametypes\br_gametype_x2::extract_ontimerexpired(self);
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function spawn_boxes(var0) {
  scripts\mp\gametypes\br_quest_util::spawn_dogtags(var0);
  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function last_target() {
  foreach(var1 in self.playerlist) {
    if(isDefined(var1)) {
      spawn_boxes(var1);
    }
  }
}

function resetchallengetimers() {
  var0 = undefined;

  switch (level.ref_1464e) {
    case "signal":
      var0 = "x2_amb_signal";
      break;
    case "bomb":
    default:
      var0 = "x2_amb1";
      break;
  }

  return var0;
}