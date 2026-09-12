/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_masterassassination_quest.gsc
*****************************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("masterassassination", 1);

  if(!var_0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_12B38("masterassassination_all");
  scripts\mp\gametypes\br_quest_util::ref_12B38("masterassassination_all_timed");
  scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").ref_1296B = getdvarint("scr_br_MAQ_questTimeBase", 180);
  scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").ref_1296C = getdvarint("scr_br_MAQ_questTimeBonus", 60);
  scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").ref_12C82 = getdvarint("scr_br_MAQ_resetTimerOnKill", 1);
  scripts\mp\gametypes\br_quest_util::registerquestthink("masterassassination", &ref_11AF5, 10);
  scripts\mp\gametypes\br_quest_util::registerquestthink("masterassassination", &ref_11AF6, 0.2);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("masterassassination", &ref_11AF7);
  scripts\mp\gametypes\br_quest_util::registeronplayerkilled("masterassassination", &ref_11AF2);
  scripts\mp\gametypes\br_quest_util::ref_12B2E("masterassassination", &ref_11AF3);
  var_1 = level.questinfo.defaultfilter;
  var_1 = scripts\engine\utility::array_add(var_1, &scripts\mp\gametypes\br_assassination_quest::filtercondition_hasbeentracked);
  var_1 = scripts\engine\utility::array_add(var_1, &scripts\mp\gametypes\br_quest_util::filtercondition_isdowned);

  if(getdvarint("scr_br_alt_mode_zxp", 0)) {
    var_1 = scripts\engine\utility::array_add(var_1, &scripts\mp\gametypes\br_quest_util::play_landlord_infil_vo);
  }

  scripts\mp\gametypes\br_quest_util::registerplayerfilter("masterassassination", var_1, 0);
  scripts\mp\gametypes\br_quest_util::ref_1297C("masterassassination", 1);
  scripts\mp\gametypes\br_quest_util::ref_12B32("masterassassination", &ref_11AF1);
  scripts\mp\gametypes\br_quest_util::ref_12B31("masterassassination", &ref_11AF0);
  scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").alltrackedplayers = [];
  scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").inner = [];
  scripts\mp\gametypes\br_assassination_quest::brexfilanimname();
  game["dialog"]["mission_ass_accept"] = "mission_mission_ass_single_accept";
  game["dialog"]["mission_ass_hunted"] = "mission_mission_ass_hunted";
  game["dialog"]["mission_ass_success"] = "mission_mission_ass_single_success";
  game["dialog"]["mission_ass_hunted_success"] = "mission_mission_ass_hunted_success";
  game["dialog"]["mission_ass_hunted_timed_out"] = "mission_mission_ass_hunted_timed_out";
  game["dialog"]["mission_ass_fail"] = "mission_mission_ass_fail";
}

function ref_11AF5() {
  if(self.modifier == "_all_timed") {
    return;
  }

  if(!isDefined(self.targetplayer)) {
    return;
  }

  scripts\mp\gametypes\br_assassination_quest::determinetrackingcircleposition(self.targetplayer);
  scripts\mp\gametypes\br_assassination_quest::lbravo_spawner_jammer3b();
  ref_13FF8(self.targetteam);
}

function ref_11AF6() {
  ref_11AED();
}

function ref_11AF7() {
  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C)) {
    scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").inner = scripts\engine\utility::array_remove(scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").inner, var_1);
  }

  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.hunterteam);
  scripts\mp\gametypes\br_assassination_quest::removeallaqui();
}

function takequestitem(var_0) {
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var_1 = self.team;
  var_2 = determinetargetteam(self);
  var_3 = search(var_1, var_2, var_0.index, self, "", var_0);

  if(!isDefined(var_3)) {
    scripts\mp\utility\lower_message::ref_1316E("br_assassination_notargets", undefined, 5);
    return;
  }

  search_target_think(var_3, self);
}

function search_target_think(var_0) {
  var_1 = spawnStruct();
  var_1.excludedplayers = [];
  var_1.excludedplayers[0] = self.targetplayer;

  if(isDefined(var_0)) {
    var_1.excludedplayers[1] = var_0;
  }

  var_1.stringvar = self.targetplayer.name;
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.targetteam, "br_masterassassination_quest_start_target_team", var_1, self.ref_13A8C);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self.targetplayer, "br_masterassassination_quest_start_target_player");

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    if(istrue(level.questinfo.ref_132E8)) {
      var_2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C);

      foreach(var_4 in var_2) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_ass_hunted", var_4, 1);
      }
    } else {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_hunted", self.targetteam, 1);
    }
  }

  var_1.ref_127D5 = scripts\mp\gametypes\br_quest_util::rewardorigin(scripts\mp\gametypes\br_quest_util::ringing(self.hunterteam));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.hunterteam, "br_masterassassination_quest_start_hunter_team", var_1);

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    if(istrue(level.questinfo.ref_132E8)) {
      var_2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex);
      level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_ass_accept", 1, var_2, 0);
    } else {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_accept", self.hunterteam, 1);
    }
  }

  if(isDefined(var_0)) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var_0, "br_masterassassination_quest_start_tablet_finder", var_1);
    scripts\mp\gametypes\br_quest_util::lookforvehicles(self.hunterteam, var_0, 6, scripts\mp\gametypes\br_quest_util::getquestindex("masterassassination"));
    return;
  }
}

function search(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0;

  if(istrue(level.questinfo.ref_132E8)) {
    var_7 = var_3.team + var_3.squadindex;
  }

  var_8 = scripts\mp\gametypes\br_quest_util::createquestinstance("masterassassination", var_7, var_2, var_5, var_3.squadindex);
  var_8.modifier = var_4;

  if(!isDefined(var_8.modifier)) {
    var_8.modifier = "";
  }

  var_8 scripts\mp\gametypes\br_quest_util::registerteamonquest(var_0, var_3);
  var_8.team = var_0;
  var_8.hunterteam = var_0;
  var_8.targetteam = var_1;
  var_8.ref_13A87 = 0;
  var_8.spawned_warp_traversethink = 0;
  var_8.ref_13A8E = 0;

  if(isDefined(var_1)) {
    var_8.ref_13A8E = var_8 scripts\mp\gametypes\br_quest_util::getvalidplayersinteam(var_1).size;
  }

  if(!isDefined(var_8.targetteam)) {
    generatenumbercode(var_8);
    return undefined;
  }

  var_8 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(4, 16);

  if(isDefined(var_6)) {
    var_8.targetplayer = var_6;
  } else {
    getnewtargetplayer(var_8, var_3);
  }

  if(!isDefined(var_8.targetplayer)) {
    generatenumbercode(var_8);
    return undefined;
  }

  if(var_8.modifier != "_all") {
    var_8 scripts\mp\gametypes\br_quest_util::ref_1297D(scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").ref_1296B, 4);
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").alltrackedplayers = scripts\engine\utility::array_combine(scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").alltrackedplayers, scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1, var_8.ref_13A8C));
  scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").inner = scripts\engine\utility::array_combine(scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").inner, scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1, var_8.ref_13A8C));

  if(var_8.modifier == "_all_timed") {
    if(istrue(level.questinfo.ref_132E8)) {
      level.squaddata[var_0][var_8.squadindex].should_save_debug_info = 0;
    } else {
      level.teamdata[var_0]["hasFailed"] = 0;
    }
  }

  var_8 scripts\mp\gametypes\br_assassination_quest::determinetrackingcircleposition(var_8.targetplayer);
  var_8 scripts\mp\gametypes\br_assassination_quest::lbravo_spawner_jammer3b();
  ref_13FF8(var_8, var_8.targetteam);
  ref_11AED(var_8);
  scripts\mp\gametypes\br_quest_util::addquestinstance("masterassassination", var_8);
  scripts\mp\gametypes\br_quest_util::ref_13879("masterassassination", var_3, var_0);
  return var_8;
}

function generatenumbercode(var_0) {
  if(isDefined(var_0.mapcircle)) {
    var_0 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  }

  var_0.result = "no_locale";
  var_0 scripts\mp\gametypes\br_quest_util::releaseteamonquest(var_0.hunterteam);
}

function determinetargetteam(var_0) {
  var_1 = var_0.team;
  var_2 = undefined;
  var_3 = level.players;
  var_4 = scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").alltrackedplayers;
  var_5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1, self.squadindex);
  var_6 = scripts\engine\utility::array_combine_unique(var_4, var_5);

  if(istrue(level.questinfo.ref_132E8)) {
    var_6 = scripts\engine\utility::array_combine_unique(var_6, scripts\mp\utility\teams::getteamdata(var_1, "players"));
  }

  if(var_3.size == var_6.size && getdvarint("scr_assassin_quest_reset_list", 1)) {
    scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").alltrackedplayers = scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").inner;
    var_4 = scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").alltrackedplayers;
    var_5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1, self.squadindex);
    var_6 = scripts\engine\utility::array_combine_unique(var_4, var_5);

    if(istrue(level.questinfo.ref_132E8)) {
      var_6 = scripts\engine\utility::array_combine_unique(var_6, scripts\mp\utility\teams::getteamdata(var_1, "players"));
    }
  }

  var_7 = 0;
  var_8 = level.questinfo.quests["masterassassination"].filters[0];
  var_9 = 5000;
  var_10 = 30000;
  jumpiffalse(scripts\mp\gametypes\br_assassination_quest::playlandingbreath()) LOC_0000011a;
  var_9 = level.ref_12962;
  var_10 = level.ref_12961;

  while(!isDefined(var_2)) {
    var_7 += 5000;
    var_11 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_3, var_6, undefined, var_9 + var_7, var_9);
    var_11 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(var_11, var_8);

    if(!isDefined(var_11) || var_11.size == 0) {
      if(var_7 > var_10) {
        var_11 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_3, var_6, undefined, undefined, undefined);
        var_11 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(var_11, var_8);

        if(!isDefined(var_11) || var_11.size == 0) {
          return undefined;
        }
      } else {
        continue;
      }
    }

    var_12 = [];

    foreach(var_14 in var_11) {
      var_12 = scripts\mp\gametypes\br_quest_util::getvalidplayersinteam(var_14.team, var_8).size;
    }

    var_16 = scripts\mp\gametypes\br_quest_util::getteamcenter(var_1, var_8);
    var_17 = scripts\mp\gametypes\br_quest_util::getvalidplayersinteam(var_1, var_8).size;
    var_2 = undefined;
    var_18 = -1;
    var_19 = -1;
    var_20 = -1;
    var_21 = -1;
    var_22 = -1;
    var_23 = undefined;

    foreach(var_30, var_25 in var_12) {
      if(!isDefined(var_2)) {
        var_2 = var_30;
        var_18 = rpg_guys_construction_spawners(var_30);
        var_19 = rpg_guys(var_30);
        var_20 = rpg_shoot_at_trig_watch(var_30);
        var_21 = rpg_max_range(var_30);
      }

      var_26 = rpg_guys_construction_spawners(var_30);
      var_27 = rpg_guys(var_30);
      var_28 = rpg_shoot_at_trig_watch(var_30);
      var_29 = rpg_max_range(var_30);

      if(var_26 < var_18) {
        continue;
      } else if(var_26 > var_18) {
        var_2 = var_30;
        var_18 = var_26;
        var_19 = var_27;
        var_20 = var_28;
        var_21 = var_29;
        continue;
      }

      if(var_27 < var_19) {
        continue;
      } else if(var_27 > var_19) {
        var_2 = var_30;
        var_18 = var_26;
        var_19 = var_27;
        var_20 = var_28;
        var_21 = var_29;
        continue;
      }

      if(var_28 < var_20) {
        continue;
      } else if(var_28 > var_20) {
        var_2 = var_30;
        var_18 = var_26;
        var_19 = var_27;
        var_20 = var_28;
        var_21 = var_29;
        continue;
      }

      if(var_29 > var_21) {
        continue;
      }

      if(var_29 > var_21) {
        var_2 = var_30;
        var_18 = var_26;
        var_19 = var_27;
        var_20 = var_28;
        var_21 = var_29;
        continue;
      }

      if(!isDefined(var_23)) {
        var_23 = randomintrange(1, 2);
      }

      if(var_23 == 1) {
        var_2 = var_30;
        var_18 = var_26;
        var_19 = var_27;
        var_20 = var_28;
        var_21 = var_29;
        var_23 = undefined;
        continue;
      }

      var_23 = undefined;
    }

    return var_2;
  }
}

function getnewtargetplayer(var_0) {
  determinetargetplayer(self.targetteam, var_0);
  scripts\mp\gametypes\br_assassination_quest::determinetrackingcircleposition(self.targetplayer);
  scripts\mp\gametypes\br_assassination_quest::lbravo_spawner_jammer3b();
  ref_13FF7();
}

function determinetargetplayer(var_0, var_1) {
  var_2 = -1;
  var_3 = -1;
  var_4 = -1;
  var_5 = -1;
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in level.teamdata[var_0]["players"]) {
    var_10 = var_9;

    if(!scripts\mp\gametypes\br_quest_util::isplayervalid(var_10, scripts\mp\gametypes\br_assassination_quest::relic_steelballs_dodamage(self.modifier))) {
      continue;
    }

    if(!isDefined(var_6)) {
      var_6 = var_10;
      var_2 = var_10.plundercount;
      var_3 = var_10.score;
      var_4 = var_10.extrascore3;
      var_5 = var_10.kills;
    }

    if(var_10.kills > var_5) {
      var_6 = var_10;
      continue;
    }

    if(var_10.extrascore3 > var_4) {
      var_6 = var_10;
      continue;
    }

    if(var_10.score > var_3) {
      var_6 = var_10;
      continue;
    }

    if(var_10.plundercount > var_2) {
      var_6 = var_10;
      continue;
    }

    if(!isDefined(var_7)) {
      var_7 = randomintrange(1, 2);
    }

    if(var_7 == 1) {
      var_6 = var_10;
      var_7 = undefined;
      continue;
    }

    var_7 = undefined;
  }

  var_6.hasbeentracked = 0;
  self.targetplayer = var_6;
  self.ref_13A8C = var_6.squadindex;
}

function ref_11AED() {
  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    var_2 = var_1 scripts\mp\gametypes\br_public::isplayeringulag();
    var_3 = isDefined(var_1.ref_11AEF) && var_1.ref_11AEF;

    if(var_2 && var_3) {
      spawn_custom_type(var_1, self);
    }

    if(!var_2 && !var_3) {
      ref_13360(var_1, self);
    }
  }

  var_5 = self.squadindex;

  if(isDefined(self.targetplayer.squadindex)) {
    var_5 = self.targetplayer.squadindex;
  }

  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, var_5)) {
    var_2 = var_1 scripts\mp\gametypes\br_public::isplayeringulag();
    var_3 = isDefined(var_1.ref_11AF8) && var_1.ref_11AF8;

    if(var_2 && var_3) {
      spawn_custom_type_array(var_1);
    }

    if(!var_2 && !var_3) {
      ref_13361(var_1, self.targetplayer, self.ref_13B39);
    }
  }
}

function ref_11AF1() {
  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C)) {
    var_1 setclientomnvar("ui_br_assassination_target_timer", self.ref_11C51);
  }

  if(self.modifier == "_all_timed") {
    thread ref_11B1C();
    return;
  }
}

function ref_11AF0() {
  if(self.modifier == "_all_timed") {
    if(istrue(level.questinfo.ref_132E8)) {
      level.squaddata[self.targetteam][self.ref_13A8C].should_save_debug_info = 1;
    } else {
      scripts\mp\utility\teams::setteamdata(self.targetteam, "hasFailed", 1);
    }

    scripts\mp\gametypes\br_assassination_quest::brgetloadoutoptionstandardloadoutindex(self.hunterteam);
    scripts\mp\gametypes\br_quest_util::removequestinstance();
    return;
  }

  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.hunterteam, "br_masterassassination_timer_expire_hunters_lose");
  var_0 = scripts\mp\gametypes\br_quest_util::ringing(self.targetteam);
  var_1 = scripts\mp\gametypes\br_quest_util::rewardmodifier("masterassassination", var_0);
  self.ref_12D2D = "_averted";
  var_2 = spawnStruct();
  var_3 = scripts\mp\gametypes\br_quest_util::getquestindex("masterassassination");
  var_4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("masterassassination", self.ref_12D2D, self.modifier));
  var_2.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_3, var_0, var_4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.targetteam, "br_masterassassination_timer_expire_targets_win", var_2, self.ref_13A8C);

  if(istrue(level.questinfo.ref_132E8)) {
    var_5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex);
    level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_ass_fail", 1, var_5, 0);
    var_5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C);
    level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_ass_hunted_timed_out", 1, var_5, 0);
  } else {
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_fail", self.hunterteam, 1);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_hunted_timed_out", self.targetteam, 1);
  }

  if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "gold_war") {
    var_6 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C);
    scripts\mp\gametypes\br_quest_util::search_speed(self.targetteam, self.targetplayer.origin, self.targetplayer.angles, self.ref_12D30, var_6, self.ref_13A8C);
    return;
  }
}

function ref_11AF2(var_0, var_1) {
  if(var_1 scripts\mp\gametypes\br_public::isplayeringulag()) {
    return;
  }

  thread ref_11AF4(var_1, var_0);
}

function ref_11AF3(var_0) {
  thread ref_11AF4(var_0);
}

function ref_11AF4(var_0, var_1) {
  if(self.modifier == "_all_timed" && (istrue(level.questinfo.ref_132E8) && istrue(level.squaddata[self.hunterteam][self.squadindex].should_save_debug_info) || scripts\mp\utility\teams::getteamdata(self.hunterteam, "hasFailed"))) {
    return;
  }

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    if(!isbot(var_0)) {
      return;
    }
  }

  if(var_0.team == self.targetteam) {
    if(var_0 == self.targetplayer) {
      var_2 = var_0.attackers;
      wait 0.75;
      var_3 = spawnStruct();
      var_4 = scripts\mp\gametypes\br_quest_util::ringing(self.hunterteam);
      var_5 = scripts\mp\gametypes\br_quest_util::getquestindex("masterassassination");

      if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == self.hunterteam) {
        var_6 = "br_masterassassination_complete_hunters_win";
        self.ref_12D2D = "_target_killed";
        scripts\mp\gametypes\br_quest_util::lookforvehicles(self.hunterteam, var_1, 8, scripts\mp\gametypes\br_quest_util::getquestindex("masterassassination"));

        foreach(var_8 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
          var_8 scripts\cp\vehicles\vehicle_compass_cp::ref_12C3F("t9_ch_global_complete_wz_bounty_contracts_for_operator_mission", 1);
        }
      } else {
        var_6 = "br_masterassassination_complete_target_vanished";
        self.ref_12D2D = "_target_vanished";
      }

      var_10 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("masterassassination", self.ref_12D2D, self.modifier));
      var_11 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(var_2);
      var_4.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_6, var_5, var_10, undefined, var_11);
      scripts\mp\gametypes\br_quest_util::displayteamsplash(self.hunterteam, var_6, var_4);
      level notify("assassination_quest_completed", self.hunterteam, self.squadindex);

      if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
        if(istrue(level.questinfo.ref_132E8)) {
          var_12 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex);
          level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_ass_success", 1, var_12, 0);
        } else {
          level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_success", self.hunterteam, 1);
        }
      }

      self.ref_12D2E = var_1.origin;
      self.ref_12D2B = var_1.angles;

      if(isDefined(var_3)) {
        foreach(var_14 in var_3) {
          if(isDefined(var_14.team) && var_14.team == self.hunterteam) {
            scripts\mp\gametypes\br_quest_util::ref_12B15(var_14);
          }
        }
      }

      self.result = "success";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
    }

    if(self.modifier == "_all_timed") {
      if(!isDefined(level.gulag) || isDefined(level.gulag) && !istrue(level.gulag.shutdown)) {
        foreach(var_8 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
          if(istrue(var_8.inlaststand)) {
            var_8 scripts\mp\laststand::playanim_aibegindismountturret("use_hold_revive_success", var_8);
          }

          if(!isalive(var_8)) {
            var_8 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
            var_8 thread scripts\mp\gametypes\br_gulag::playergulagautowin("assassinationQuest");
          }
        }

        return;
      }

      return;
    }

    return;
  }

  if(var_8.team == self.hunterteam) {
    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(self.hunterteam, scripts\mp\gametypes\br_assassination_quest::relic_steelballs_dodamage(self.modifier))) {
      if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
        self.result = "fail";
        scripts\mp\gametypes\br_quest_util::removequestinstance();
        return;
      }

      self.ref_12D2D = "_averted";
      var_18 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C);
      var_19 = scripts\mp\gametypes\br_quest_util::search_speed(self.targetteam, var_8.origin, var_8.angles, self.ref_12D30, var_18, self.ref_13A8C);
      var_3 = spawnStruct();
      var_3.ref_127D5 = scripts\mp\gametypes\br::get_int_or_0(var_19["plunder"]);
      scripts\mp\gametypes\br_quest_util::displayteamsplash(self.targetteam, "br_masterassassination_complete_targets_win", var_3, self.ref_13A8C);
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function rpg_guys_construction_spawners(var_0) {
  var_1 = 0;

  foreach(var_3 in level.teamdata[var_0]["players"]) {
    var_1 += var_3.kills;
  }

  return var_1;
}

function rpg_shoot_at_trig_watch(var_0) {
  var_1 = 0;

  foreach(var_3 in level.teamdata[var_0]["players"]) {
    var_1 += var_3.score;
  }

  return var_1;
}

function rpg_guys(var_0) {
  var_1 = 0;

  foreach(var_3 in level.teamdata[var_0]["players"]) {
    var_1 += var_3.extrascore3;
  }

  return var_1;
}

function rpg_max_range(var_0) {
  var_1 = 0;

  foreach(var_3 in level.teamdata[var_0]["players"]) {
    var_1 += var_3.plundercount;
  }

  return var_1;
}

function ref_11AEE(var_0) {
  switch (var_0) {
    case "_all_timed":
    case "_all":
      return level.questinfo.defaultfilter;
    default:
      return 0;
  }
}

function ref_13360(var_0) {
  self.ref_11AEF = 1;
  scripts\mp\gametypes\br_quest_util::uiobjectiveshow("masterassassination" + var_0.modifier);
  var_0 scripts\mp\gametypes\br_quest_util::ref_1336A(self);
}

function spawn_custom_type(var_0) {
  self.ref_11AEF = 0;
  scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  var_0 scripts\mp\gametypes\br_quest_util::spawn_dogtags(self);
}

function ref_13FF6(var_0, var_1) {
  if(isDefined(self.ref_11AF8) && self.ref_11AF8) {
    var_2 = var_0 getentitynumber();
  } else {
    var_2 = -1;
  }

  var_2 = var_1 getentitynumber();
  var_2 += 1;
  var_3 = var_2 << 8 | var_2;
  self setclientomnvar("ui_br_assassination_target", var_3);
}

function ref_13FF8(var_0) {
  foreach(var_2 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C)) {
    ref_13FF6(var_2, self.targetplayer, self.ref_13B39);
  }
}

function ref_13361(var_0, var_1) {
  self.ref_11AF8 = 1;
  ref_13FF6(var_0, var_1);
}

function spawn_custom_type_array() {
  self.ref_11AF8 = 0;
  self setclientomnvar("ui_br_assassination_target", 0);
}

function ref_13FF7() {
  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    ref_13360(var_1, self);
    var_1 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(self.targetplayer getentitynumber());
  }

  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C)) {
    ref_13361(var_1, self.targetplayer, self.ref_13B39);
  }
}

function ref_11B1C() {
  self notify("masterAssassinationTimeWarning");
  self endon("masterAssassinationTimeWarning");
  self endon("removed");
  var_0 = [300, 240, 180, 120, 90, 60, 30, 10];

  foreach(var_2 in var_0) {
    var_3 = (self.ref_11C51 - gettime()) / 1000;
    var_4 = var_3 - var_2;

    if(var_4 < 0) {
      continue;
    }

    wait var_4;
    var_5 = int(var_2 / 60);
    var_6 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex), ref_11AEE(self.modifier));

    foreach(var_8 in var_6) {
      var_9 = gettime() + var_2 * 1000;
      var_10 = 5;

      if(var_2 <= 20) {
        var_10 = var_2;
      }

      var_8 scripts\mp\utility\lower_message::ref_1316E("br_assassin_mission_time_warning", var_9, var_10);

      if(var_5 >= 2) {
        var_8 iprintlnbold(&"MP_BR_INGAME/MISSION_ASSASSIN_2_TIME_WARNING_MIN", var_5);
        continue;
      }

      var_8 iprintlnbold(&"MP_BR_INGAME/MISSION_ASSASSIN_2_TIME_WARNING_SEC", var_2);
    }
  }
}