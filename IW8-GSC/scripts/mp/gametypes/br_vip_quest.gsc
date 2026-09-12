/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_vip_quest.gsc
*************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("vip", 1);

  if(!var_0) {
    return;
  }

  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("vip_redacted", 1);

  if(var_0) {
    scripts\mp\gametypes\br_quest_util::ref_12B2A("vip_redacted", "brloot_redacted_vip_tablet");
  }

  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("vip", &ref_142C4);
  scripts\mp\gametypes\br_quest_util::registeronplayerkilled("vip", &ref_142C0);
  scripts\mp\gametypes\br_quest_util::ref_12B2E("vip", &ref_142C1);
  scripts\mp\gametypes\br_quest_util::ref_12B2D("vip", &ref_142BD);
  scripts\mp\gametypes\br_quest_util::ref_12B30("vip", &ref_142BE);
  scripts\mp\gametypes\br_quest_util::registerquestthink("vip", &ref_142C3, 0.5);
  game["dialog"]["hvt_accept"] = "contract_hvt_accept";
  game["dialog"]["mission_hvt_accept_first_person"] = "mission_mission_hvt_accept_first_person";
  game["dialog"]["mission_hvt_success_third_person"] = "mission_mission_hvt_success_third_person";
  game["dialog"]["mission_hvt_success_first_person"] = "mission_mission_hvt_success_first_person";
  game["dialog"]["mission_hvt_failure"] = "mission_mission_hvt_failure";
  game["dialog"]["mission_hvt_eliminated"] = "mission_mission_hvt_eliminated";
  scripts\mp\gametypes\br_quest_util::ref_1297C("vip", 1);
  scripts\mp\gametypes\br_quest_util::ref_12B31("vip", &ref_142BF);
}

function takequestitem(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::createquestinstance("vip", self.team, var_0.index, var_0, self.squadindex);
  var_1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var_2 = "";

  if(var_0.type == "brloot_redacted_vip_tablet") {
    var_2 = "_redacted";
  }

  var_1.modifier = var_2;
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var_1.team = self.team;
  var_1.vip = self;
  var_1.vip scripts\mp\gametypes\br_public::ref_131A4(1);
  var_1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active");
  function_0442(var_1.objectiveiconid, 1);
  ref_142CA(var_1);
  var_1 scripts\mp\gametypes\br_quest_util::ref_1297D(getdvarint("scr_br_VIP_questTimeBase", 180), 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("vip", var_1);
  scripts\mp\gametypes\br_quest_util::ref_13879("vip", self, self.team);
  var_3 = spawnStruct();
  var_3.excludedplayers = [];
  var_3.excludedplayers[0] = var_1.vip;
  var_3.ogangles = [];
  var_3.ogangles[0] = var_1.team;
  var_3.ref_127D5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("vip", scripts\mp\gametypes\br_quest_util::ringing(self.team), var_1.modifier);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var_1.team, "br_vip_quest_start_vip_team", var_3);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(var_1.vip, "br_vip_quest_start_tablet_finder", var_3);
  scripts\mp\gametypes\br_quest_util::look_at_heli("br_vip_quest_vip_spawn_alert", self.origin, 5000, level.questinfo.defaultfilter, var_3);
  level thread scripts\mp\gametypes\br_public::dmztutdropcash("hvt_accept", var_1.team, var_1.vip, 1, 0.5);
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_hvt_accept_first_person", var_1.vip, 1, 0.5);
}

function ref_142CA() {
  objective_addalltomask(self.objectiveiconid);
  var_0 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(level.players);

  foreach(var_2 in var_0["valid"]) {
    scripts\mp\gametypes\br_quest_util::ref_1336C(var_2);
  }

  foreach(var_2 in var_0["invalid"]) {
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_2);
  }

  foreach(var_2 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(!var_2 scripts\mp\gametypes\br_public::isplayeringulag()) {
      ref_142CB(var_2);
    }

    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_2);
  }
}

function ref_142C0(var_0, var_1) {
  if(var_1 scripts\mp\gametypes\br_public::isplayeringulag() || var_0 scripts\mp\gametypes\br_public::isplayeringulag()) {
    return;
  }

  ref_142C2(var_1, var_0);
}

function ref_142C1(var_0) {
  ref_142C2(var_0);
}

function ref_142BD(var_0) {
  ref_142C9(var_0);
}

function ref_142BE(var_0) {
  if(var_0.team == self.team) {
    ref_142CB(var_0);
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_1336C(var_0);
}

function ref_142C2(var_0, var_1) {
  if(isDefined(var_0)) {
    if(var_0.team == self.team) {
      if(var_0 == self.vip) {
        if(isDefined(var_1)) {
          ref_142BA(var_1);
          return;
        }

        ref_142BA(var_0);
        return;
      }

      ref_142C9(var_0);
      return;
    }

    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);

    if(isDefined(var_1)) {
      if(isDefined(var_1.team) && isDefined(self.team)) {
        if(var_1.team == self.team) {
          var_1 thread scripts\mp\events::killeventtextpopup("br_vip_kill", 0, 0);
          scripts\mp\gametypes\br_quest_util::questtimersubtract(getdvarint("scr_br_VIP_cacheTimeReduction", 20));
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function ref_142BF() {
  ref_142B7();
}

function ref_142C4() {
  level notify("calloutmarkerping_warzoneKillQuestIconGlobal_" + self.objectiveiconid);
  ref_142C8();
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_142CB(var_0) {
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("vip" + self.modifier);
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(self.vip getentitynumber());
  scripts\mp\gametypes\br_quest_util::ref_1336C(var_0);
}

function ref_142C9(var_0) {
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
}

function ref_142C8() {
  foreach(var_1 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    ref_142C9(var_1);
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();
}

function ref_142C5(var_0, var_1, var_2) {
  if(istrue(var_0.inlaststand)) {
    var_0 scripts\mp\laststand::playanim_aibegindismountturret("use_hold_revive_success", var_0);
    return 1;
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("vipRespawnPlayer")) {
    var_0 thread scripts\mp\gametypes\br_gametypes::ref_12E05("vipRespawnPlayer", var_1, var_2);
    return 1;
  }

  return ref_142C6(var_0, var_1, var_2);
}

function ref_142C6(var_0, var_1, var_2) {
  if(istrue(var_0.inlaststand)) {
    var_0 scripts\mp\laststand::playanim_aibegindismountturret("use_hold_revive_success", var_0);
    return true;
  } else if(!isalive(var_0) && !var_0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    var_0 thread scripts\mp\gametypes\br_gulag::playergulagautowin("vipRespawn", var_1);
    return true;
  } else if(var_0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    var_0 thread scripts\mp\gametypes\br_gulag::ref_12642(var_1, var_2);
    return true;
  }

  return false;
}

function ref_142B7() {
  var_0 = spawnStruct();
  var_1 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_2 = scripts\mp\gametypes\br_quest_util::getquestindex("vip" + self.modifier);
  var_3 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("vip", self.modifier));
  var_4 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(self.vip);
  var_0.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_2, var_1, var_3, undefined, var_4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_vip_quest_complete", var_0);
  self.vip scripts\cp\vehicles\vehicle_compass_cp::ref_12C3F("t9_ch_global_survive_or_kill_most_wanted_contracts_s1_wz", 1);
  level thread scripts\mp\gametypes\br_public::dmztutdropcash("mission_hvt_success_third_person", self.team, self.vip, 1, 0, 0.5);
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_hvt_success_first_person", self.vip, 1, 0, 0.5);
  self.vip scripts\mp\gametypes\br_public::ref_131A4(0);

  foreach(var_6 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    var_6 scripts\cp\vehicles\vehicle_compass_cp::ref_12C3F("t9_ch_global_most_wanted_contract_completed_for_operator_mission", 1);
    ref_142C5(var_6, self.vip, "vip");
  }

  self.ref_12D2D = undefined;
  self.ref_12D2E = self.vip.origin;
  self.ref_12D2B = self.vip.angles;
  self.result = "success";
  thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_142BA(var_0) {
  if(isDefined(var_0) && isPlayer(var_0) && var_0.team != self.team) {
    var_1 = spawnStruct();
    var_2 = scripts\mp\gametypes\br_quest_util::ringing(var_0.team);
    var_3 = scripts\mp\gametypes\br_quest_util::getquestindex("vip");
    self.ref_12D2D = "_killer";
    var_4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("vip", self.ref_12D2D, self.modifier));
    var_1.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_3, var_2, var_4);
    scripts\mp\gametypes\br_quest_util::displayteamsplash(var_0.team, "br_vip_quest_you_killed_the_vip", var_1);
    var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_12C3F("t9_ch_global_survive_or_kill_most_wanted_contracts_s1_wz", 1);

    foreach(var_6 in scripts\mp\utility\teams::getteamdata(var_0.team, "players")) {
      var_6 scripts\cp\vehicles\vehicle_compass_cp::ref_12C3F("t9_ch_global_most_wanted_contract_completed_for_operator_mission", 1);
    }

    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_hvt_eliminated", var_0.team, 1, 1);
    scripts\mp\gametypes\br_quest_util::search_speed(var_0.team, self.vip.origin, self.vip.angles, self.ref_12D30);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_hvt_failure", self.team, 1, 1);
    self.ref_12D2D = undefined;
    self.result = "fail";
    wait 0.05;
    self.vip scripts\mp\gametypes\br_public::ref_131A4(0);
  }

  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_vip_quest_failure");
  self.ref_12D2D = undefined;
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function getplayervipquest(var_0) {
  if(isDefined(level.questinfo) && isDefined(level.questinfo.quests["vip"])) {
    if(isDefined(level.questinfo.quests["vip"].instances)) {
      if(level.questinfo.quests["vip"].instances.size > 0) {
        foreach(var_2 in level.questinfo.quests["vip"].instances) {
          if(var_2.team == var_0.team) {
            return var_2;
          }
        }
      }
    }
  }

  return undefined;
}

function ref_142C3() {
  scripts\mp\gametypes\br_quest_util::ref_11DB0(self.vip.origin);
}