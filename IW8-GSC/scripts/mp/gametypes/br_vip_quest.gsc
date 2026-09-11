/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_vip_quest.gsc
*************************************************/

function init() {
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("vip", 1);

  if(!var0) {
    return;
  }

  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("vip_redacted", 1);

  if(var0) {
    scripts\mp\gametypes\br_quest_util::ref_12b2a("vip_redacted", "brloot_redacted_vip_tablet");
  }

  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("vip", &ref_142c4);
  scripts\mp\gametypes\br_quest_util::registeronplayerkilled("vip", &ref_142c0);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("vip", &ref_142c1);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("vip", &ref_142bd);
  scripts\mp\gametypes\br_quest_util::ref_12b30("vip", &ref_142be);
  scripts\mp\gametypes\br_quest_util::registerquestthink("vip", &ref_142c3, 0.5);
  game["dialog"]["hvt_accept"] = "contract_hvt_accept";
  game["dialog"]["mission_hvt_accept_first_person"] = "mission_mission_hvt_accept_first_person";
  game["dialog"]["mission_hvt_success_third_person"] = "mission_mission_hvt_success_third_person";
  game["dialog"]["mission_hvt_success_first_person"] = "mission_mission_hvt_success_first_person";
  game["dialog"]["mission_hvt_failure"] = "mission_mission_hvt_failure";
  game["dialog"]["mission_hvt_eliminated"] = "mission_mission_hvt_eliminated";
  scripts\mp\gametypes\br_quest_util::ref_1297c("vip", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("vip", &ref_142bf);
}

function takequestitem(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createquestinstance("vip", self.team, var0.index, var0, self.squadindex);
  var1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var2 = "";

  if(var0.type == "brloot_redacted_vip_tablet") {
    var2 = "_redacted";
  }

  var1.modifier = var2;
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var1.team = self.team;
  var1.vip = self;
  var1.vip scripts\mp\gametypes\br_public::ref_131a4(1);
  var1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active");
  function_0442(var1.objectiveiconid, 1);
  ref_142ca(var1);
  var1 scripts\mp\gametypes\br_quest_util::ref_1297d(getdvarint("scr_br_VIP_questTimeBase", 180), 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("vip", var1);
  scripts\mp\gametypes\br_quest_util::ref_13879("vip", self, self.team);
  var3 = spawnStruct();
  var3.excludedplayers = [];
  var3.excludedplayers[0] = var1.vip;
  var3.ogangles = [];
  var3.ogangles[0] = var1.team;
  var3.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("vip", scripts\mp\gametypes\br_quest_util::ringing(self.team), var1.modifier);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var1.team, "br_vip_quest_start_vip_team", var3);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(var1.vip, "br_vip_quest_start_tablet_finder", var3);
  scripts\mp\gametypes\br_quest_util::look_at_heli("br_vip_quest_vip_spawn_alert", self.origin, 5000, level.questinfo.defaultfilter, var3);
  level thread scripts\mp\gametypes\br_public::dmztutdropcash("hvt_accept", var1.team, var1.vip, 1, 0.5);
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_hvt_accept_first_person", var1.vip, 1, 0.5);
}

function ref_142ca() {
  objective_addalltomask(self.objectiveiconid);
  var0 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(level.players);

  foreach(var2 in var0["valid"]) {
    scripts\mp\gametypes\br_quest_util::ref_1336c(var2);
  }

  foreach(var2 in var0["invalid"]) {
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var2);
  }

  foreach(var2 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(!var2 scripts\mp\gametypes\br_public::isplayeringulag()) {
      ref_142cb(var2);
    }

    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var2);
  }
}

function ref_142c0(var0, var1) {
  if(var1 scripts\mp\gametypes\br_public::isplayeringulag() || var0 scripts\mp\gametypes\br_public::isplayeringulag()) {
    return;
  }

  ref_142c2(var1, var0);
}

function ref_142c1(var0) {
  ref_142c2(var0);
}

function ref_142bd(var0) {
  ref_142c9(var0);
}

function ref_142be(var0) {
  if(var0.team == self.team) {
    ref_142cb(var0);
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
}

function ref_142c2(var0, var1) {
  if(isDefined(var0)) {
    if(var0.team == self.team) {
      if(var0 == self.vip) {
        if(isDefined(var1)) {
          ref_142ba(var1);
          return;
        }

        ref_142ba(var0);
        return;
      }

      ref_142c9(var0);
      return;
    }

    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);

    if(isDefined(var1)) {
      if(isDefined(var1.team) && isDefined(self.team)) {
        if(var1.team == self.team) {
          var1 thread scripts\mp\events::killeventtextpopup("br_vip_kill", 0, 0);
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

function ref_142bf() {
  ref_142b7();
}

function ref_142c4() {
  level notify("calloutmarkerping_warzoneKillQuestIconGlobal_" + self.objectiveiconid);
  ref_142c8();
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_142cb(var0) {
  var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("vip" + self.modifier);
  var0 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(self.vip getentitynumber());
  scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
}

function ref_142c9(var0) {
  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
}

function ref_142c8() {
  foreach(var1 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    ref_142c9(var1);
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();
}

function ref_142c5(var0, var1, var2) {
  if(istrue(var0.inlaststand)) {
    var0 scripts\mp\laststand::playanim_aibegindismountturret("use_hold_revive_success", var0);
    return 1;
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("vipRespawnPlayer")) {
    var0 thread scripts\mp\gametypes\br_gametypes::ref_12e05("vipRespawnPlayer", var1, var2);
    return 1;
  }

  return ref_142c6(var0, var1, var2);
}

function ref_142c6(var0, var1, var2) {
  if(istrue(var0.inlaststand)) {
    var0 scripts\mp\laststand::playanim_aibegindismountturret("use_hold_revive_success", var0);
    return true;
  } else if(!isalive(var0) && !var0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    var0 thread scripts\mp\gametypes\br_gulag::playergulagautowin("vipRespawn", var1);
    return true;
  } else if(var0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    var0 thread scripts\mp\gametypes\br_gulag::ref_12642(var1, var2);
    return true;
  }

  return false;
}

function ref_142b7() {
  var0 = spawnStruct();
  var1 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var2 = scripts\mp\gametypes\br_quest_util::getquestindex("vip" + self.modifier);
  var3 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("vip", self.modifier));
  var4 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(self.vip);
  var0.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var2, var1, var3, undefined, var4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_vip_quest_complete", var0);
  self.vip scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_survive_or_kill_most_wanted_contracts_s1_wz", 1);
  level thread scripts\mp\gametypes\br_public::dmztutdropcash("mission_hvt_success_third_person", self.team, self.vip, 1, 0, 0.5);
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_hvt_success_first_person", self.vip, 1, 0, 0.5);
  self.vip scripts\mp\gametypes\br_public::ref_131a4(0);

  foreach(var6 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    var6 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_most_wanted_contract_completed_for_operator_mission", 1);
    ref_142c5(var6, self.vip, "vip");
  }

  self.ref_12d2d = undefined;
  self.ref_12d2e = self.vip.origin;
  self.ref_12d2b = self.vip.angles;
  self.result = "success";
  thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_142ba(var0) {
  if(isDefined(var0) && isPlayer(var0) && var0.team != self.team) {
    var1 = spawnStruct();
    var2 = scripts\mp\gametypes\br_quest_util::ringing(var0.team);
    var3 = scripts\mp\gametypes\br_quest_util::getquestindex("vip");
    self.ref_12d2d = "_killer";
    var4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("vip", self.ref_12d2d, self.modifier));
    var1.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var3, var2, var4);
    scripts\mp\gametypes\br_quest_util::displayteamsplash(var0.team, "br_vip_quest_you_killed_the_vip", var1);
    var0 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_survive_or_kill_most_wanted_contracts_s1_wz", 1);

    foreach(var6 in scripts\mp\utility\teams::getteamdata(var0.team, "players")) {
      var6 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_most_wanted_contract_completed_for_operator_mission", 1);
    }

    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_hvt_eliminated", var0.team, 1, 1);
    scripts\mp\gametypes\br_quest_util::search_speed(var0.team, self.vip.origin, self.vip.angles, self.ref_12d30);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_hvt_failure", self.team, 1, 1);
    self.ref_12d2d = undefined;
    self.result = "fail";
    wait 0.05;
    self.vip scripts\mp\gametypes\br_public::ref_131a4(0);
  }

  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_vip_quest_failure");
  self.ref_12d2d = undefined;
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function getplayervipquest(var0) {
  if(isDefined(level.questinfo) && isDefined(level.questinfo.quests["vip"])) {
    if(isDefined(level.questinfo.quests["vip"].instances)) {
      if(level.questinfo.quests["vip"].instances.size > 0) {
        foreach(var2 in level.questinfo.quests["vip"].instances) {
          if(var2.team == var0.team) {
            return var2;
          }
        }
      }
    }
  }

  return undefined;
}

function ref_142c3() {
  scripts\mp\gametypes\br_quest_util::ref_11db0(self.vip.origin);
}