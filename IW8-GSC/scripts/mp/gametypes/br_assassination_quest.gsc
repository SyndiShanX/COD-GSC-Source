/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_assassination_quest.gsc
***********************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("assassination", 1);

  if(!var_0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_12B38("assassination_all");
  scripts\mp\gametypes\br_quest_util::ref_12B38("assassination_all_timed");
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("assassination_redacted", 1);

  if(var_0) {
    scripts\mp\gametypes\br_quest_util::ref_12B2A("assassination_redacted", "brloot_redacted_assassination_tablet");
  }

  level.br_leaderbystreak = getdvarint("scr_br_leader_by_streak", 0) != 0;
  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").ref_1296B = getdvarint("scr_br_AQ_questTimeBase", 180);
  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").ref_1296C = getdvarint("scr_br_AQ_questTimeBonus", 60);
  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").ref_12C82 = getdvarint("scr_br_AQ_resetTimerOnKill", 1);
  scripts\mp\gametypes\br_quest_util::registerquestthink("assassination", &aq_questthink_circleposition, 5);
  scripts\mp\gametypes\br_quest_util::registerquestthink("assassination", &aq_questthink_objectivevisibility, 0.2);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("assassination", &aq_removequestinstance);
  scripts\mp\gametypes\br_quest_util::registeronplayerkilled("assassination", &aq_playerdied);
  scripts\mp\gametypes\br_quest_util::ref_12B2E("assassination", &calculateweaponmatchbonus);
  var_1 = level.questinfo.defaultfilter;
  var_1 = scripts\engine\utility::array_add(var_1, &scripts\mp\gametypes\br_quest_util::filtercondition_isdowned);
  var_2 = getDvar("scr_br_gametype");

  if(var_2 != "rebirth" && var_2 != "rebirth_reverse" && var_2 != "rumble" && var_2 != "rebirth_dbd" && var_2 != "rebirth_dbd_reverse") {
    var_1 = scripts\engine\utility::array_add(var_1, &filtercondition_hasbeentracked);
  }

  if(getdvarint("scr_br_alt_mode_zxp", 0)) {
    var_1 = scripts\engine\utility::array_add(var_1, &scripts\mp\gametypes\br_quest_util::play_landlord_infil_vo);
  }

  if(getdvarint("scr_br_alt_mode_gxp", 0)) {
    var_1 = scripts\engine\utility::array_add(var_1, &scripts\mp\gametypes\br_quest_util::play_intro_hacking_vo);
  }

  scripts\mp\gametypes\br_quest_util::registerplayerfilter("assassination", var_1, 0);
  scripts\mp\gametypes\br_quest_util::ref_1297C("assassination", 1);
  scripts\mp\gametypes\br_quest_util::ref_12B32("assassination", &calculatespawndisttodefenderflagstart);
  scripts\mp\gametypes\br_quest_util::ref_12B31("assassination", &calculatepurchasexp);
  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers = [];
  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").inner = [];
  brexfilanimname();
  game["dialog"]["mission_ass_accept"] = "mission_mission_ass_single_accept";
  game["dialog"]["mission_ass_hunted"] = "mission_mission_ass_hunted";
  game["dialog"]["mission_ass_success"] = "mission_mission_ass_single_success";
  game["dialog"]["mission_ass_hunted_success"] = "mission_mission_ass_hunted_success";
  game["dialog"]["mission_ass_hunted_timed_out"] = "mission_mission_ass_hunted_timed_out";
  game["dialog"]["mission_ass_fail"] = "mission_mission_ass_fail";
}

function filtercondition_hasbeentracked(var_0) {
  if(isDefined(var_0.hasbeentracked) && var_0.hasbeentracked) {
    return false;
  }

  return true;
}

function aq_questthink_circleposition() {
  if(self.modifier == "_all_timed") {
    return;
  }

  if(!isDefined(self.targetplayer)) {
    return;
  }

  determinetrackingcircleposition(self.targetplayer);
  lbravo_spawner_jammer3b();
  ref_13FC3(self.targetteam);
}

function aq_questthink_objectivevisibility() {
  determineobjectivevisibility();
}

function aq_removequestinstance() {
  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C)) {
    scripts\mp\gametypes\br_quest_util::getquestdata("assassination").inner = scripts\engine\utility::array_remove(scripts\mp\gametypes\br_quest_util::getquestdata("assassination").inner, var_1);
  }

  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.hunterteam);
  removeallaqui();
}

function takequestitem(var_0) {
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var_1 = self.team;
  var_2 = determinetargetteam(self);
  var_3 = "";

  if(var_0.type == "brloot_redacted_assassination_tablet") {
    var_3 = "_redacted";
  }

  var_4 = search(var_1, var_2, var_0.index, self, var_3, var_0);

  if(!isDefined(var_4)) {
    scripts\mp\utility\lower_message::ref_1316E("br_assassination_notargets", undefined, 5);
    return;
  }

  search_target_think(var_4, self);
}

function search_target_think(var_0) {
  var_1 = spawnStruct();
  var_1.excludedplayers = [];
  var_1.excludedplayers[0] = self.targetplayer;

  if(isDefined(var_0)) {
    var_1.excludedplayers[1] = var_0;
  }

  var_1.stringvar = self.targetplayer.name;
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.targetteam, "br_assassination_quest_start_target_team", var_1, self.ref_13A8C);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self.targetplayer, "br_assassination_quest_start_target_player");

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
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.hunterteam, "br_assassination_quest_start_hunter_team", var_1);

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    if(istrue(level.questinfo.ref_132E8)) {
      var_2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex);
      level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_ass_accept", 1, var_2, 0);
    } else {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_accept", self.hunterteam, 1);
    }
  }

  if(isDefined(var_0)) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var_0, "br_assassination_quest_start_tablet_finder", var_1);
    scripts\mp\gametypes\br_quest_util::lookforvehicles(self.hunterteam, var_0, 6, scripts\mp\gametypes\br_quest_util::getquestindex("assassination"));
    return;
  }
}

function search(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0;

  if(istrue(level.questinfo.ref_132E8)) {
    var_7 = var_3.team + var_3.squadindex;
  }

  var_8 = scripts\mp\gametypes\br_quest_util::createquestinstance("assassination", var_7, var_2, var_5, var_3.squadindex);
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

  var_8 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(4, 3);

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
    var_8 scripts\mp\gametypes\br_quest_util::ref_1297D(scripts\mp\gametypes\br_quest_util::getquestdata("assassination").ref_1296B, 4);
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers = scripts\engine\utility::array_combine(scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers, scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1, var_8.ref_13A8C));
  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").inner = scripts\engine\utility::array_combine(scripts\mp\gametypes\br_quest_util::getquestdata("assassination").inner, scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1, var_8.ref_13A8C));

  if(var_8.modifier == "_all_timed") {
    if(istrue(level.questinfo.ref_132E8)) {
      level.squaddata[var_0][var_8.squadindex].should_save_debug_info = 0;
    } else {
      level.teamdata[var_0]["hasFailed"] = 0;
    }
  }

  determinetrackingcircleposition(var_8, var_8.targetplayer);
  lbravo_spawner_jammer3b(var_8);
  ref_13FC3(var_8, var_8.targetteam);
  determineobjectivevisibility(var_8);
  scripts\mp\gametypes\br_quest_util::addquestinstance("assassination", var_8);
  scripts\mp\gametypes\br_quest_util::ref_13879("assassination", var_3, var_0);
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
  var_4 = scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers;
  var_5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1, self.squadindex);
  var_6 = scripts\engine\utility::array_combine_unique(var_4, var_5);

  if(istrue(level.questinfo.ref_132E8)) {
    var_6 = scripts\engine\utility::array_combine_unique(var_6, scripts\mp\utility\teams::getteamdata(var_1, "players"));
  }

  if(var_3.size == var_6.size && getdvarint("scr_assassin_quest_reset_list", 1)) {
    scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers = scripts\mp\gametypes\br_quest_util::getquestdata("assassination").inner;
    var_4 = scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers;
    var_5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1, self.squadindex);
    var_6 = scripts\engine\utility::array_combine_unique(var_4, var_5);

    if(istrue(level.questinfo.ref_132E8)) {
      var_6 = scripts\engine\utility::array_combine_unique(var_6, scripts\mp\utility\teams::getteamdata(var_1, "players"));
    }
  }

  var_7 = 0;
  var_8 = level.questinfo.quests["assassination"].filters[0];
  var_9 = 5000;
  var_10 = 30000;
  jumpiffalse(playlandingbreath()) LOC_0000011a;
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

    foreach(var_25, var_19 in var_12) {
      if(!isDefined(var_2)) {
        var_2 = var_25;
        continue;
      }

      if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
        var_20 = scripts\mp\gametypes\br_gametype_dmz::rpg_shoot_at_trigs(var_2);
        var_21 = scripts\mp\gametypes\br_gametype_dmz::rpg_shoot_at_trigs(var_25);

        if(var_21 > 100000) {
          if(var_21 > var_20) {
            var_2 = var_25;
            continue;
          }
        }
      }

      var_22 = abs(var_17 - var_19);

      if(var_22 < abs(var_17 - var_12[var_2])) {
        var_2 = var_25;
        continue;
      } else if(var_22 > abs(var_17 - var_12[var_2])) {
        continue;
      }

      if(var_19 > var_12[var_2]) {
        var_2 = var_25;
        continue;
      } else if(var_19 < var_12[var_2]) {
        continue;
      }

      var_23 = scripts\mp\gametypes\br_quest_util::getteamcenter(var_25, var_8);
      var_24 = scripts\mp\gametypes\br_quest_util::getteamcenter(var_2, var_8);

      if(distance2d(var_16, var_23) < distance2d(var_16, var_24)) {
        var_2 = var_25;
      }
    }
  }

  return var_2;
}

function determinetargetplayer(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = scripts\mp\gametypes\br_quest_util::getteamcenter(self.hunterteam);

  foreach(var_7 in level.teamdata[var_0]["players"]) {
    if(!scripts\mp\gametypes\br_quest_util::isplayervalid(var_7, relic_steelballs_dodamage(self.modifier))) {
      continue;
    }

    if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
      if(scripts\engine\utility::is_equal(var_7.script_noteworthy, "assassination_target")) {
        var_4 = var_7;
        break;
      }
    }

    if(!isDefined(var_4)) {
      var_4 = var_7;
    }

    if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
      var_8 = var_7.plundercount;

      if(isDefined(var_8)) {
        var_9 = distance2dsquared(var_1.origin, var_7.origin);

        if(!isDefined(var_3) || var_9 <= var_3) {
          if(!isDefined(var_2) || var_8 >= var_2) {
            var_2 = var_8;
            var_3 = var_9;
            var_4 = var_7;
          }
        }
      }

      continue;
    }

    if(distance2d(var_5, var_7.origin) < distance2d(var_5, var_4.origin)) {
      var_4 = var_7;
    }
  }

  var_4.hasbeentracked = 0;
  self.targetplayer = var_4;
  self.ref_13A8C = var_4.squadindex;
}

function lbravo_spawner_jammer2b(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = level.questinfo.quests["assassination"].filters[0];
  var_5 = level.teamdata[var_0]["players"];
  var_6 = scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers;
  var_7 = scripts\mp\gametypes\br_quest_util::rotations(var_1.team, var_4, var_1.squadindex);
  var_8 = scripts\mp\gametypes\br_quest_util::run_trap_room_combat(var_1.team, var_4, var_1.squadindex).size;
  var_9 = 0;
  var_10 = 5000;
  var_11 = 30000;
  jumpiffalse(playlandingbreath()) LOC_00000094;
  var_10 = level.ref_12962;
  var_11 = level.ref_12961;

  while(!isDefined(var_3)) {
    var_9 += 5000;
    var_12 = scripts\engine\utility::get_array_of_closest(var_1.origin, var_5, var_6, undefined, var_10 + var_9, var_10);
    var_12 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(var_12, var_4);

    if(!isDefined(var_12) || var_12.size == 0) {
      if(var_9 > var_11) {
        var_12 = scripts\engine\utility::get_array_of_closest(var_1.origin, var_5, var_6, undefined, undefined, undefined);
        var_12 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(var_12, var_4);

        if(!isDefined(var_12) || var_12.size == 0) {
          return undefined;
        }
      } else {
        continue;
      }
    }

    var_13 = [];

    foreach(var_2 in var_12) {
      if(isDefined(var_13[var_2.squadindex])) {
        continue;
      }

      var_13 = scripts\mp\gametypes\br_quest_util::run_trap_room_combat(var_2.team, var_4, var_2.squadindex).size;
    }

    foreach(var_21, var_17 in var_13) {
      if(!isDefined(var_3)) {
        var_3 = var_21;
        continue;
      }

      var_18 = abs(var_8 - var_17);

      if(var_18 < abs(var_8 - var_13[var_3])) {
        var_3 = var_21;
        continue;
      } else if(var_18 > abs(var_8 - var_13[var_3])) {
        continue;
      }

      if(var_17 > var_13[var_3]) {
        var_3 = var_21;
        continue;
      } else if(var_17 < var_13[var_3]) {
        continue;
      }

      var_19 = scripts\mp\gametypes\br_quest_util::rotations(var_0, var_4, var_21);
      var_20 = scripts\mp\gametypes\br_quest_util::rotations(var_0, var_4, var_3);

      if(distance2d(var_7, var_19) < distance2d(var_7, var_20)) {
        var_3 = var_21;
      }
    }
  }

  foreach(var_23 in scripts\mp\gametypes\br_quest_util::run_trap_room_combat(var_0, var_4, var_3)) {
    if(!isDefined(var_2)) {
      var_2 = var_23;
    }

    if(distance2d(var_7, var_23.origin) < distance2d(var_7, var_2.origin)) {
      var_2 = var_23;
    }
  }

  var_2.hasbeentracked = 0;
  self.targetplayer = var_2;
  self.ref_13A8C = var_2.squadindex;
}

function determinetrackingcircleposition(var_0) {
  var_1 = (var_0.origin[0], var_0.origin[1], relic_amped_test_explode_other_player());

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    var_1 += scripts\engine\math::random_vector_2d() * randomfloatrange(relic_amped_show_timer(), relic_amped_set_head_objective());
  }

  scripts\mp\gametypes\br_quest_util::ref_11DAE(var_1);
}

function lbravo_spawner_jammer3b() {
  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    scripts\mp\gametypes\br_quest_util::ref_1316F(level.ref_11A2A);
    self.ref_13B39 = 2;
    return;
  }

  if(getdvarint("scr_br_alt_mode_zxp", 0)) {
    var_0 = scripts\mp\gametypes\br_quest_util::run_trap_room_combat(self.hunterteam, level.questinfo.defaultfilter);
  } else {
    var_0 = scripts\mp\gametypes\br_quest_util::run_trap_room_combat(self.hunterteam);
  }

  if(var_0.size == 0) {
    scripts\mp\gametypes\br_quest_util::ref_1316F(3500);
    self.ref_13B39 = 0;
    return;
  }

  var_1 = undefined;

  foreach(var_3 in var_0) {
    var_4 = distance2d(var_3.origin, self.targetplayer.origin);

    if(!isDefined(var_1) || var_4 < var_1) {
      var_1 = var_4;
    }
  }

  if(var_1 > 5000) {
    scripts\mp\gametypes\br_quest_util::ref_1316F(3500);
    self.ref_13B39 = 0;
    return;
  }

  if(var_1 > 2500) {
    scripts\mp\gametypes\br_quest_util::ref_1316F(2000);
    self.ref_13B39 = 1;
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_1316F(1500);
  self.ref_13B39 = 2;
}

function determineobjectivevisibility() {
  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    var_2 = var_1 scripts\mp\gametypes\br_public::isplayeringulag();
    var_3 = isDefined(var_1.aq_hudenabled) && var_1.aq_hudenabled;

    if(var_2 && var_3) {
      hideassassinationhud(var_1, self);
    }

    if(!var_2 && !var_3) {
      showassassinationhud(var_1, self);
    }
  }

  var_5 = self.squadindex;

  if(isDefined(self.targetplayer.squadindex)) {
    var_5 = self.targetplayer.squadindex;
  }

  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, var_5)) {
    var_2 = var_1 scripts\mp\gametypes\br_public::isplayeringulag();
    var_3 = isDefined(var_1.call_exfil) && var_1.call_exfil;

    if(var_2 && var_3) {
      spawn_cache4_rpgs(var_1);
    }

    if(!var_2 && !var_3) {
      ref_13344(var_1, self.targetplayer, self.ref_13B39);
    }
  }
}

function calculatespawndisttodefenderflagstart() {
  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C)) {
    var_1 setclientomnvar("ui_br_assassination_target_timer", self.ref_11C51);
  }

  if(self.modifier == "_all_timed") {
    thread carepackage_set_useable();
    return;
  }
}

function calculatepurchasexp() {
  if(self.modifier == "_all_timed") {
    if(istrue(level.questinfo.ref_132E8)) {
      level.squaddata[self.targetteam][self.ref_13A8C].should_save_debug_info = 1;
    } else {
      scripts\mp\utility\teams::setteamdata(self.targetteam, "hasFailed", 1);
    }

    brgetloadoutoptionstandardloadoutindex(self.hunterteam);
    scripts\mp\gametypes\br_quest_util::removequestinstance();
    return;
  }

  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.hunterteam, "br_assassination_timer_expire_hunters_lose");
  var_0 = scripts\mp\gametypes\br_quest_util::ringing(self.targetteam);
  var_1 = scripts\mp\gametypes\br_quest_util::rewardmodifier("assassination", var_0);
  self.ref_12D2D = "_averted";
  var_2 = spawnStruct();
  var_3 = scripts\mp\gametypes\br_quest_util::getquestindex("assassination");
  var_4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("assassination", self.ref_12D2D, self.modifier));
  var_2.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_3, var_0, var_4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.targetteam, "br_assassination_timer_expire_targets_win", var_2, self.ref_13A8C);

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

function aq_playerdied(var_0, var_1) {
  if(var_1 scripts\mp\gametypes\br_public::isplayeringulag()) {
    return;
  }

  thread calculatewinningteam(var_1, var_0);
}

function calculateweaponmatchbonus(var_0) {
  thread calculatewinningteam(var_0);
}

function calculatewinningteam(var_0, var_1) {
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
      var_5 = scripts\mp\gametypes\br_quest_util::getquestindex("assassination");

      if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == self.hunterteam) {
        var_6 = "br_assassination_complete_hunters_win";
        self.ref_12D2D = "_target_killed";
        scripts\mp\gametypes\br_quest_util::lookforvehicles(self.hunterteam, var_1, 8, scripts\mp\gametypes\br_quest_util::getquestindex("assassination"));

        foreach(var_8 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
          var_8 scripts\cp\vehicles\vehicle_compass_cp::ref_12C3F("t9_ch_global_complete_wz_bounty_contracts_for_operator_mission", 1);
        }
      } else {
        var_6 = "br_assassination_complete_target_vanished";
        self.ref_12D2D = "_target_vanished";
      }

      var_10 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("assassination", self.ref_12D2D, self.modifier));
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
    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(self.hunterteam, relic_steelballs_dodamage(self.modifier))) {
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
      scripts\mp\gametypes\br_quest_util::displayteamsplash(self.targetteam, "br_assassination_complete_targets_win", var_3, self.ref_13A8C);
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function getnewtargetplayer(var_0) {
  if(istrue(level.questinfo.ref_132E8)) {
    lbravo_spawner_jammer2b(self.targetteam, var_0);
  } else {
    determinetargetplayer(self.targetteam, var_0);
  }

  determinetrackingcircleposition(self.targetplayer);
  lbravo_spawner_jammer3b();
  updateassassinationhud();
}

function removeallaqui() {
  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    hideassassinationhud(var_1, self);
  }

  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C)) {
    spawn_cache4_rpgs(var_1);
  }

  scripts\mp\gametypes\br_quest_util::lastdirtyscore();
}

function getplayerkills() {
  if(level.br_leaderbystreak) {
    return self.killsthislife.size;
  }

  return self.kills;
}

function relic_steelballs_dodamage(var_0) {
  switch (var_0) {
    case "_all_timed":
    case "_all":
      return level.questinfo.defaultfilter;
    default:
      return 0;
  }
}

function showassassinationhud(var_0) {
  self.aq_hudenabled = 1;
  scripts\mp\gametypes\br_quest_util::uiobjectiveshow("assassination" + var_0.modifier);
  var_0 scripts\mp\gametypes\br_quest_util::ref_1336A(self);
}

function hideassassinationhud(var_0) {
  self.aq_hudenabled = 0;
  scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  var_0 scripts\mp\gametypes\br_quest_util::spawn_dogtags(self);
}

function ref_13FC2(var_0, var_1) {
  if(isDefined(self.call_exfil) && self.call_exfil) {
    var_2 = var_0 getentitynumber();
  } else {
    var_2 = -1;
  }

  var_2 = var_1 getentitynumber();
  var_2 += 1;
  var_3 = var_2 << 8 | var_2;
  self setclientomnvar("ui_br_assassination_target", var_3);
}

function ref_13FC3(var_0) {
  foreach(var_2 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C)) {
    ref_13FC2(var_2, self.targetplayer, self.ref_13B39);
  }
}

function ref_13344(var_0, var_1) {
  self.call_exfil = 1;
  ref_13FC2(var_0, var_1);
}

function spawn_cache4_rpgs() {
  self.call_exfil = 0;
  self setclientomnvar("ui_br_assassination_target", 0);
}

function updateassassinationhud() {
  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    showassassinationhud(var_1, self);
    var_1 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(self.targetplayer getentitynumber());
  }

  foreach(var_1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13A8C)) {
    ref_13344(var_1, self.targetplayer, self.ref_13B39);
  }
}

function carepackage_set_useable() {
  self notify("assassinationTimeWarning");
  self endon("assassinationTimeWarning");
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
    var_6 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex), relic_steelballs_dodamage(self.modifier));

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

function brexfilanimname() {
  thread breventsinit();
}

function breventsinit() {
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = getdvarint("scr_br_all_assassin_version", 0);

  if(!var_0) {
    return;
  }

  var_1 = getdvarint("scr_br_all_assassin_wait_time", 120);
  loadtables();
  wait var_1;
  breventflagset(var_0);
}

function breventflagset(var_0) {
  var_1 = spawnStruct();
  var_1.ref_13AB1 = [];
  var_1.wam_interaction_structs = [];
  var_1.ref_12CC9 = int(getdvarfloat("scr_br_all_assassin_rest_time", 10) * 1000);

  if(var_0 == 1) {
    var_1.modifier = "_all";
  } else if(var_0 == 2) {
    var_1.modifier = "_all_timed";
  }

  if(var_1.modifier == "_all_timed") {
    brgetloadoutammomax(var_1);
  } else {
    brgametype(var_1);
  }

  thread brevent4();
  thread brhandleinvulnerability();
}

function breventflagclear() {
  var_0 = (0, 0, 0);
  var_1 = brgetloadoutoptionforname();
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = undefined;
    var_6 = scripts\mp\utility\teams::getteamdata(var_4, "players");

    foreach(var_8 in var_6) {
      if(var_8 scripts\mp\gametypes\br_public::isplayeringulag()) {
        continue;
      }

      if(var_8 scripts\mp\gametypes\br_public::updatedragonsbreath()) {
        var_5 = var_8;
        break;
      }

      if(!isDefined(var_5)) {
        var_5 = var_8;
      }
    }

    if(!isDefined(var_5)) {
      continue;
    }

    var_10 = spawnStruct();
    var_10.team = var_4;
    var_10.pos = var_5.origin;
    var_0 += var_10.pos;
    var_2 = var_10;
  }

  if(var_2.size < 2) {
    return var_2;
  }

  var_0 /= var_2.size;

  foreach(var_10 in var_2) {
    var_13 = var_10.pos - var_0;
    var_10.ref_134DA = vectortoangles(var_13)[1];
  }

  var_2 = scripts\mp\utility\script::quicksort(var_2, &brgetloadoutdropbagsdelayseconds);
  return var_2;
}

function brgametype() {
  var_0 = breventflagclear();
  var_1 = getdvarint("scr_br_all_assassin_group_size", 150);
  var_2 = var_0.size;

  if(isDefined(var_1)) {
    var_1 = int(min(var_1, var_2));
  } else {
    var_1 = var_2;
  }

  var_3 = int(var_2 / var_1);
  var_4 = var_2 % var_1;
  var_5 = [];

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_5 = var_1;
  }

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_5++;
  }

  var_7 = 0;

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_1 = var_5[var_6];

    for(var_8 = 0; var_8 < var_1; var_8++) {
      var_9 = var_0[var_7 + var_8].team;
      var_10 = ref_145EB(var_8 - 1, var_1);
      var_11 = ref_145EB(var_8 + 1, var_1);
      var_12 = var_0[var_7 + var_10].team;
      var_13 = var_0[var_7 + var_11].team;
      var_14 = spawnStruct();
      var_14.ref_13A75 = var_12;
      var_14.ref_13A78 = var_13;
      self.ref_13AB1[var_9] = var_14;
    }

    var_7 += var_1;
  }
}

function brgetloadoutammomax() {
  var_0 = getdvarfloat("scr_br_all_assassin_max_dist", 10000);
  var_1 = breventflagclear();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2].team;

    if(isDefined(self.ref_13AB1[var_3])) {
      continue;
    }

    for(var_4 = 0; var_4 < var_1.size - 1; var_4++) {
      if(var_4 % 2) {
        var_5 = int(-0.5 * var_4 - 0.5);
      } else {
        var_5 = int(0.5 * var_4 + 1);
      }

      var_6 = ref_145EB(var_2 + var_5, var_1.size);
      var_7 = var_1[var_6].team;

      if(isDefined(self.ref_13AB1[var_7])) {
        continue;
      }

      var_8 = var_1[var_6].pos;
      var_9 = var_1[var_2].pos;

      if(distance(var_8, var_9) > var_0) {
        continue;
      }

      var_10 = spawnStruct();
      var_10.ref_13A75 = var_7;
      var_10.ref_13A78 = var_7;
      self.ref_13AB1[var_3] = var_10;
      var_11 = spawnStruct();
      var_11.ref_13A75 = var_3;
      var_11.ref_13A78 = var_3;
      self.ref_13AB1[var_7] = var_11;
      break;
    }
  }
}

function brgetloadoutoptionforname() {
  var_0 = gettime();
  var_1 = [];

  foreach(var_5, var_3 in level.teamdata) {
    if(isDefined(self.ref_13AB1[var_5])) {
      continue;
    }

    var_4 = self.wam_interaction_structs[var_5];

    if(isDefined(var_4) && var_0 < var_4 + self.ref_12CC9) {
      continue;
    }

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var_5, relic_steelballs_dodamage(self.modifier))) {
      continue;
    }

    var_1 = var_5;
  }

  return var_1;
}

function brgetloadoutammomultiplier(var_0) {
  var_0 waittill("removed");
  self.wam_interaction_structs[var_0.hunterteam] = gettime();
  self notify("update");
}

function brhandleinvulnerability() {
  var_0 = getdvarint("scr_br_all_assassin_update_delay", 10);

  for(;;) {
    scripts\engine\utility::waittill_notify_or_timeout("update", var_0);

    if(self.modifier == "_all_timed") {
      brgivestartfieldupgrade();
      continue;
    }

    brgetoperatorteam();
  }
}

function brgivestartfieldupgrade() {
  var_0 = [];

  foreach(var_3, var_2 in self.ref_13AB1) {
    if(!isDefined(level.questinfo.quests["assassination"].instances[var_3])) {
      var_0 = var_3;
    }
  }

  foreach(var_3 in var_0) {
    self.ref_13AB1[var_3] = undefined;
  }

  brgetloadoutammomax();
  brevent4();
}

function brgetoperatorteam() {
  var_0 = [];

  foreach(var_3, var_2 in self.ref_13AB1) {
    if(!isDefined(level.questinfo.quests["assassination"].instances[var_3])) {
      if(var_2.ref_13A78 == var_2.ref_13A75) {
        var_0 = var_3;
      }
    }
  }

  foreach(var_3 in var_0) {
    self.ref_13AB1[var_3] = undefined;
  }

  var_6 = brgetloadoutoptionforname();
  var_7 = var_6.size;
  var_0 = [];

  foreach(var_3, var_2 in self.ref_13AB1) {
    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var_3, relic_steelballs_dodamage(self.modifier))) {
      if(var_7 > 0) {
        var_7--;
        var_9 = var_6[var_7];
        self.ref_13AB1[var_9] = spawnStruct();
        self.ref_13AB1[var_9].ref_13A78 = var_2.ref_13A78;
        self.ref_13AB1[var_9].ref_13A75 = var_2.ref_13A75;
        self.ref_13AB1[var_2.ref_13A75].ref_13A78 = var_9;
        self.ref_13AB1[var_2.ref_13A78].ref_13A75 = var_9;
      } else {
        self.ref_13AB1[var_2.ref_13A75].ref_13A78 = var_2.ref_13A78;
        self.ref_13AB1[var_2.ref_13A78].ref_13A75 = var_2.ref_13A75;
      }

      var_0 = var_3;
    }
  }

  foreach(var_3 in var_0) {
    self.ref_13AB1[var_3] = undefined;
  }

  if(var_7 >= 2) {
    for(var_12 = 0; var_12 < var_7; var_12++) {
      var_3 = var_6[var_12];
      var_13 = ref_145EB(var_12 - 1, var_7);
      var_14 = ref_145EB(var_12 + 1, var_7);
      var_15 = var_6[var_13];
      var_16 = var_6[var_14];
      var_17 = spawnStruct();
      var_17.ref_13A75 = var_15;
      var_17.ref_13A78 = var_16;
      self.ref_13AB1[var_3] = var_17;
    }
  }

  if(self.ref_13AB1.size < 2) {
    return;
  }

  brevent4();
}

function brevent4() {
  foreach(var_1 in self.ref_13AB1) {
    if(isDefined(level.questinfo.quests["assassination"].instances[var_6])) {
      continue;
    }

    var_2 = var_6;
    var_3 = var_1.ref_13A78;
    var_4 = "all_" + var_2 + "_" + var_3;
    var_5 = search(var_2, var_3, var_4, undefined, self.modifier);

    if(isDefined(var_5)) {
      search_target_think(var_5);

      if(self.modifier == "_all_timed") {
        thread brgulagdamagefilter();
      }

      thread brgetloadoutammomultiplier(var_5);
    }
  }
}

function brgulagdamagefilter() {
  self endon("removed");
  var_0 = getdvarfloat("scr_br_all_assassin_circle_start_update", 5);
  var_1 = getdvarfloat("scr_br_all_assassin_circle_end_update", 0.5);

  for(;;) {
    aq_questthink_circleposition();
    determinetrackingcircleposition(self.targetplayer);
    var_2 = riotshield_common();
    var_3 = var_0 - var_1;
    wait var_3 * var_2 + var_1;
  }
}

function brgetloadoutdropbagsdelayseconds(var_0, var_1) {
  return var_0.ref_134DA <= var_1.ref_134DA;
}

function brgetloadoutoptionstandardloadoutindex(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(scripts\mp\utility\teams::getteamdata(var_0, "players"));

  foreach(var_3 in var_1) {
    if(isalive(var_3)) {
      var_3 kill(var_3.origin, var_3);
    }
  }

  scripts\mp\gametypes\br_quest_util::displayteamsplash(var_0, "br_assassination_timer_expire_hunters_lose");

  if(istrue(level.questinfo.ref_132E8)) {
    var_5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, self.squadindex);
    level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_ass_fail", 1, var_5, 0);
    return;
  }

  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_fail", var_0, 1);
}

function ref_145EB(var_0, var_1) {
  return (var_0 % var_1 + var_1) % var_1;
}

function loadtables() {
  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").lobby_door_enemy_watcher = 1;
}

function loadout_updateweapondependentsettings() {
  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").loadoutaddblueprintattachments = 1;
}

function getkeypadcodelengthfromomnvar() {
  return isDefined(scripts\mp\gametypes\br_quest_util::getquestdata("assassination").lobby_door_enemy_watcher) && scripts\mp\gametypes\br_quest_util::getquestdata("assassination").lobby_door_enemy_watcher;
}

function getjuggmazespawnpoint() {
  return isDefined(scripts\mp\gametypes\br_quest_util::getquestdata("assassination").loadoutaddblueprintattachments) && scripts\mp\gametypes\br_quest_util::getquestdata("assassination").loadoutaddblueprintattachments;
}

function riotshield_common() {
  var_0 = scripts\mp\gametypes\br_quest_util::getquestdata("assassination").ref_1296B;
  var_1 = (self.ref_11C51 - gettime()) / 1000;
  var_2 = clamp(var_1 / var_0, 0, 1);
  return var_2;
}

function relic_amped_test_explode_other_player() {
  if(self.modifier == "_all_timed") {
    var_0 = getdvarfloat("scr_br_all_assassin_circle_start_size", 3000);
    var_1 = getdvarfloat("scr_br_all_assassin_circle_end_size", 200);
    var_2 = riotshield_common();
    var_3 = var_0 - var_1;
    return (var_3 * var_2 + var_1);
  }

  return 2000;
}

function relic_amped_show_timer() {
  if(self.modifier == "_all_timed") {
    return 0;
  }

  return 100;
}

function relic_amped_set_head_objective() {
  if(self.modifier == "_all_timed") {
    var_0 = relic_amped_test_explode_other_player();
    return (var_0 * 0.5);
  }

  return 900;
}

function playlandingbreath() {
  var_0 = 0;
  var_1 = scripts\mp\gametypes\br_gametypes::ref_12E05("overrideQuestSearchParams", "assassination");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var_2) {
    case "mini":
    case "gold_war":
    case "risk":
    case "rat_race":
    case "dmz":
      var_0 = 1;
      break;
  }

  return var_0;
}