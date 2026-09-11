/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_assassination_quest.gsc
***********************************************************/

function init() {
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("assassination", 1);

  if(!var0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_12b38("assassination_all");
  scripts\mp\gametypes\br_quest_util::ref_12b38("assassination_all_timed");
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("assassination_redacted", 1);

  if(var0) {
    scripts\mp\gametypes\br_quest_util::ref_12b2a("assassination_redacted", "brloot_redacted_assassination_tablet");
  }

  level.br_leaderbystreak = getdvarint("scr_br_leader_by_streak", 0) != 0;
  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").ref_1296b = getdvarint("scr_br_AQ_questTimeBase", 180);
  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").ref_1296c = getdvarint("scr_br_AQ_questTimeBonus", 60);
  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").ref_12c82 = getdvarint("scr_br_AQ_resetTimerOnKill", 1);
  scripts\mp\gametypes\br_quest_util::registerquestthink("assassination", &aq_questthink_circleposition, 5);
  scripts\mp\gametypes\br_quest_util::registerquestthink("assassination", &aq_questthink_objectivevisibility, 0.2);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("assassination", &aq_removequestinstance);
  scripts\mp\gametypes\br_quest_util::registeronplayerkilled("assassination", &aq_playerdied);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("assassination", &calculateweaponmatchbonus);
  var1 = level.questinfo.defaultfilter;
  var1 = scripts\engine\utility::array_add(var1, &scripts\mp\gametypes\br_quest_util::filtercondition_isdowned);
  var2 = getDvar("scr_br_gametype");

  if(var2 != "rebirth" && var2 != "rebirth_reverse" && var2 != "rumble" && var2 != "rebirth_dbd" && var2 != "rebirth_dbd_reverse") {
    var1 = scripts\engine\utility::array_add(var1, &filtercondition_hasbeentracked);
  }

  if(getdvarint("scr_br_alt_mode_zxp", 0)) {
    var1 = scripts\engine\utility::array_add(var1, &scripts\mp\gametypes\br_quest_util::play_landlord_infil_vo);
  }

  if(getdvarint("scr_br_alt_mode_gxp", 0)) {
    var1 = scripts\engine\utility::array_add(var1, &scripts\mp\gametypes\br_quest_util::play_intro_hacking_vo);
  }

  scripts\mp\gametypes\br_quest_util::registerplayerfilter("assassination", var1, 0);
  scripts\mp\gametypes\br_quest_util::ref_1297c("assassination", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b32("assassination", &calculatespawndisttodefenderflagstart);
  scripts\mp\gametypes\br_quest_util::ref_12b31("assassination", &calculatepurchasexp);
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

function filtercondition_hasbeentracked(var0) {
  if(isDefined(var0.hasbeentracked) && var0.hasbeentracked) {
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
  ref_13fc3(self.targetteam);
}

function aq_questthink_objectivevisibility() {
  determineobjectivevisibility();
}

function aq_removequestinstance() {
  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c)) {
    scripts\mp\gametypes\br_quest_util::getquestdata("assassination").inner = scripts\engine\utility::array_remove(scripts\mp\gametypes\br_quest_util::getquestdata("assassination").inner, var1);
  }

  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.hunterteam);
  removeallaqui();
}

function takequestitem(var0) {
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var1 = self.team;
  var2 = determinetargetteam(self);
  var3 = "";

  if(var0.type == "brloot_redacted_assassination_tablet") {
    var3 = "_redacted";
  }

  var4 = search(var1, var2, var0.index, self, var3, var0);

  if(!isDefined(var4)) {
    scripts\mp\utility\lower_message::ref_1316e("br_assassination_notargets", undefined, 5);
    return;
  }

  search_target_think(var4, self);
}

function search_target_think(var0) {
  var1 = spawnStruct();
  var1.excludedplayers = [];
  var1.excludedplayers[0] = self.targetplayer;

  if(isDefined(var0)) {
    var1.excludedplayers[1] = var0;
  }

  var1.stringvar = self.targetplayer.name;
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.targetteam, "br_assassination_quest_start_target_team", var1, self.ref_13a8c);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self.targetplayer, "br_assassination_quest_start_target_player");

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    if(istrue(level.questinfo.ref_132e8)) {
      var2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c);

      foreach(var4 in var2) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_ass_hunted", var4, 1);
      }
    } else {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_hunted", self.targetteam, 1);
    }
  }

  var1.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardorigin(scripts\mp\gametypes\br_quest_util::ringing(self.hunterteam));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.hunterteam, "br_assassination_quest_start_hunter_team", var1);

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    if(istrue(level.questinfo.ref_132e8)) {
      var2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex);
      level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_ass_accept", 1, var2, 0);
    } else {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_accept", self.hunterteam, 1);
    }
  }

  if(isDefined(var0)) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var0, "br_assassination_quest_start_tablet_finder", var1);
    scripts\mp\gametypes\br_quest_util::lookforvehicles(self.hunterteam, var0, 6, scripts\mp\gametypes\br_quest_util::getquestindex("assassination"));
    return;
  }
}

function search(var0, var1, var2, var3, var4, var5, var6) {
  var7 = var0;

  if(istrue(level.questinfo.ref_132e8)) {
    var7 = var3.team + var3.squadindex;
  }

  var8 = scripts\mp\gametypes\br_quest_util::createquestinstance("assassination", var7, var2, var5, var3.squadindex);
  var8.modifier = var4;

  if(!isDefined(var8.modifier)) {
    var8.modifier = "";
  }

  var8 scripts\mp\gametypes\br_quest_util::registerteamonquest(var0, var3);
  var8.team = var0;
  var8.hunterteam = var0;
  var8.targetteam = var1;
  var8.ref_13a87 = 0;
  var8.spawned_warp_traversethink = 0;
  var8.ref_13a8e = 0;

  if(isDefined(var1)) {
    var8.ref_13a8e = var8 scripts\mp\gametypes\br_quest_util::getvalidplayersinteam(var1).size;
  }

  if(!isDefined(var8.targetteam)) {
    generatenumbercode(var8);
    return undefined;
  }

  var8 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(4, 3);

  if(isDefined(var6)) {
    var8.targetplayer = var6;
  } else {
    getnewtargetplayer(var8, var3);
  }

  if(!isDefined(var8.targetplayer)) {
    generatenumbercode(var8);
    return undefined;
  }

  if(var8.modifier != "_all") {
    var8 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("assassination").ref_1296b, 4);
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers = scripts\engine\utility::array_combine(scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers, scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1, var8.ref_13a8c));
  scripts\mp\gametypes\br_quest_util::getquestdata("assassination").inner = scripts\engine\utility::array_combine(scripts\mp\gametypes\br_quest_util::getquestdata("assassination").inner, scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1, var8.ref_13a8c));

  if(var8.modifier == "_all_timed") {
    if(istrue(level.questinfo.ref_132e8)) {
      level.squaddata[var0][var8.squadindex].should_save_debug_info = 0;
    } else {
      level.teamdata[var0]["hasFailed"] = 0;
    }
  }

  determinetrackingcircleposition(var8, var8.targetplayer);
  lbravo_spawner_jammer3b(var8);
  ref_13fc3(var8, var8.targetteam);
  determineobjectivevisibility(var8);
  scripts\mp\gametypes\br_quest_util::addquestinstance("assassination", var8);
  scripts\mp\gametypes\br_quest_util::ref_13879("assassination", var3, var0);
  return var8;
}

function generatenumbercode(var0) {
  if(isDefined(var0.mapcircle)) {
    var0 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  }

  var0.result = "no_locale";
  var0 scripts\mp\gametypes\br_quest_util::releaseteamonquest(var0.hunterteam);
}

function determinetargetteam(var0) {
  var1 = var0.team;
  var2 = undefined;
  var3 = level.players;
  var4 = scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers;
  var5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1, self.squadindex);
  var6 = scripts\engine\utility::array_combine_unique(var4, var5);

  if(istrue(level.questinfo.ref_132e8)) {
    var6 = scripts\engine\utility::array_combine_unique(var6, scripts\mp\utility\teams::getteamdata(var1, "players"));
  }

  if(var3.size == var6.size && getdvarint("scr_assassin_quest_reset_list", 1)) {
    scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers = scripts\mp\gametypes\br_quest_util::getquestdata("assassination").inner;
    var4 = scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers;
    var5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1, self.squadindex);
    var6 = scripts\engine\utility::array_combine_unique(var4, var5);

    if(istrue(level.questinfo.ref_132e8)) {
      var6 = scripts\engine\utility::array_combine_unique(var6, scripts\mp\utility\teams::getteamdata(var1, "players"));
    }
  }

  var7 = 0;
  var8 = level.questinfo.quests["assassination"].filters[0];
  var9 = 5000;
  var10 = 30000;
  jumpiffalse(playlandingbreath()) LOC_0000011a;
  var9 = level.ref_12962;
  var10 = level.ref_12961;

  while(!isDefined(var2)) {
    var7 += 5000;
    var11 = scripts\engine\utility::get_array_of_closest(var0.origin, var3, var6, undefined, var9 + var7, var9);
    var11 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(var11, var8);

    if(!isDefined(var11) || var11.size == 0) {
      if(var7 > var10) {
        var11 = scripts\engine\utility::get_array_of_closest(var0.origin, var3, var6, undefined, undefined, undefined);
        var11 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(var11, var8);

        if(!isDefined(var11) || var11.size == 0) {
          return undefined;
        }
      } else {
        continue;
      }
    }

    var12 = [];

    foreach(var14 in var11) {
      var12 = scripts\mp\gametypes\br_quest_util::getvalidplayersinteam(var14.team, var8).size;
    }

    var16 = scripts\mp\gametypes\br_quest_util::getteamcenter(var1, var8);
    var17 = scripts\mp\gametypes\br_quest_util::getvalidplayersinteam(var1, var8).size;

    foreach(var25, var19 in var12) {
      if(!isDefined(var2)) {
        var2 = var25;
        continue;
      }

      if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
        var20 = scripts\mp\gametypes\br_gametype_dmz::rpg_shoot_at_trigs(var2);
        var21 = scripts\mp\gametypes\br_gametype_dmz::rpg_shoot_at_trigs(var25);

        if(var21 > 100000) {
          if(var21 > var20) {
            var2 = var25;
            continue;
          }
        }
      }

      var22 = abs(var17 - var19);

      if(var22 < abs(var17 - var12[var2])) {
        var2 = var25;
        continue;
      } else if(var22 > abs(var17 - var12[var2])) {
        continue;
      }

      if(var19 > var12[var2]) {
        var2 = var25;
        continue;
      } else if(var19 < var12[var2]) {
        continue;
      }

      var23 = scripts\mp\gametypes\br_quest_util::getteamcenter(var25, var8);
      var24 = scripts\mp\gametypes\br_quest_util::getteamcenter(var2, var8);

      if(distance2d(var16, var23) < distance2d(var16, var24)) {
        var2 = var25;
      }
    }
  }

  return var2;
}

function determinetargetplayer(var0, var1) {
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = scripts\mp\gametypes\br_quest_util::getteamcenter(self.hunterteam);

  foreach(var7 in level.teamdata[var0]["players"]) {
    if(!scripts\mp\gametypes\br_quest_util::isplayervalid(var7, relic_steelballs_dodamage(self.modifier))) {
      continue;
    }

    if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
      if(scripts\engine\utility::is_equal(var7.script_noteworthy, "assassination_target")) {
        var4 = var7;
        break;
      }
    }

    if(!isDefined(var4)) {
      var4 = var7;
    }

    if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
      var8 = var7.plundercount;

      if(isDefined(var8)) {
        var9 = distance2dsquared(var1.origin, var7.origin);

        if(!isDefined(var3) || var9 <= var3) {
          if(!isDefined(var2) || var8 >= var2) {
            var2 = var8;
            var3 = var9;
            var4 = var7;
          }
        }
      }

      continue;
    }

    if(distance2d(var5, var7.origin) < distance2d(var5, var4.origin)) {
      var4 = var7;
    }
  }

  var4.hasbeentracked = 0;
  self.targetplayer = var4;
  self.ref_13a8c = var4.squadindex;
}

function lbravo_spawner_jammer2b(var0, var1) {
  var2 = undefined;
  var3 = undefined;
  var4 = level.questinfo.quests["assassination"].filters[0];
  var5 = level.teamdata[var0]["players"];
  var6 = scripts\mp\gametypes\br_quest_util::getquestdata("assassination").alltrackedplayers;
  var7 = scripts\mp\gametypes\br_quest_util::rotations(var1.team, var4, var1.squadindex);
  var8 = scripts\mp\gametypes\br_quest_util::run_trap_room_combat(var1.team, var4, var1.squadindex).size;
  var9 = 0;
  var10 = 5000;
  var11 = 30000;
  jumpiffalse(playlandingbreath()) LOC_00000094;
  var10 = level.ref_12962;
  var11 = level.ref_12961;

  while(!isDefined(var3)) {
    var9 += 5000;
    var12 = scripts\engine\utility::get_array_of_closest(var1.origin, var5, var6, undefined, var10 + var9, var10);
    var12 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(var12, var4);

    if(!isDefined(var12) || var12.size == 0) {
      if(var9 > var11) {
        var12 = scripts\engine\utility::get_array_of_closest(var1.origin, var5, var6, undefined, undefined, undefined);
        var12 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(var12, var4);

        if(!isDefined(var12) || var12.size == 0) {
          return undefined;
        }
      } else {
        continue;
      }
    }

    var13 = [];

    foreach(var2 in var12) {
      if(isDefined(var13[var2.squadindex])) {
        continue;
      }

      var13 = scripts\mp\gametypes\br_quest_util::run_trap_room_combat(var2.team, var4, var2.squadindex).size;
    }

    foreach(var21, var17 in var13) {
      if(!isDefined(var3)) {
        var3 = var21;
        continue;
      }

      var18 = abs(var8 - var17);

      if(var18 < abs(var8 - var13[var3])) {
        var3 = var21;
        continue;
      } else if(var18 > abs(var8 - var13[var3])) {
        continue;
      }

      if(var17 > var13[var3]) {
        var3 = var21;
        continue;
      } else if(var17 < var13[var3]) {
        continue;
      }

      var19 = scripts\mp\gametypes\br_quest_util::rotations(var0, var4, var21);
      var20 = scripts\mp\gametypes\br_quest_util::rotations(var0, var4, var3);

      if(distance2d(var7, var19) < distance2d(var7, var20)) {
        var3 = var21;
      }
    }
  }

  foreach(var23 in scripts\mp\gametypes\br_quest_util::run_trap_room_combat(var0, var4, var3)) {
    if(!isDefined(var2)) {
      var2 = var23;
    }

    if(distance2d(var7, var23.origin) < distance2d(var7, var2.origin)) {
      var2 = var23;
    }
  }

  var2.hasbeentracked = 0;
  self.targetplayer = var2;
  self.ref_13a8c = var2.squadindex;
}

function determinetrackingcircleposition(var0) {
  var1 = (var0.origin[0], var0.origin[1], relic_amped_test_explode_other_player());

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    var1 += scripts\engine\math::random_vector_2d() * randomfloatrange(relic_amped_show_timer(), relic_amped_set_head_objective());
  }

  scripts\mp\gametypes\br_quest_util::ref_11dae(var1);
}

function lbravo_spawner_jammer3b() {
  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    scripts\mp\gametypes\br_quest_util::ref_1316f(level.ref_11a2a);
    self.ref_13b39 = 2;
    return;
  }

  if(getdvarint("scr_br_alt_mode_zxp", 0)) {
    var0 = scripts\mp\gametypes\br_quest_util::run_trap_room_combat(self.hunterteam, level.questinfo.defaultfilter);
  } else {
    var0 = scripts\mp\gametypes\br_quest_util::run_trap_room_combat(self.hunterteam);
  }

  if(var0.size == 0) {
    scripts\mp\gametypes\br_quest_util::ref_1316f(3500);
    self.ref_13b39 = 0;
    return;
  }

  var1 = undefined;

  foreach(var3 in var0) {
    var4 = distance2d(var3.origin, self.targetplayer.origin);

    if(!isDefined(var1) || var4 < var1) {
      var1 = var4;
    }
  }

  if(var1 > 5000) {
    scripts\mp\gametypes\br_quest_util::ref_1316f(3500);
    self.ref_13b39 = 0;
    return;
  }

  if(var1 > 2500) {
    scripts\mp\gametypes\br_quest_util::ref_1316f(2000);
    self.ref_13b39 = 1;
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_1316f(1500);
  self.ref_13b39 = 2;
}

function determineobjectivevisibility() {
  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    var2 = var1 scripts\mp\gametypes\br_public::isplayeringulag();
    var3 = isDefined(var1.aq_hudenabled) && var1.aq_hudenabled;

    if(var2 && var3) {
      hideassassinationhud(var1, self);
    }

    if(!var2 && !var3) {
      showassassinationhud(var1, self);
    }
  }

  var5 = self.squadindex;

  if(isDefined(self.targetplayer.squadindex)) {
    var5 = self.targetplayer.squadindex;
  }

  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, var5)) {
    var2 = var1 scripts\mp\gametypes\br_public::isplayeringulag();
    var3 = isDefined(var1.call_exfil) && var1.call_exfil;

    if(var2 && var3) {
      spawn_cache4_rpgs(var1);
    }

    if(!var2 && !var3) {
      ref_13344(var1, self.targetplayer, self.ref_13b39);
    }
  }
}

function calculatespawndisttodefenderflagstart() {
  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c)) {
    var1 setclientomnvar("ui_br_assassination_target_timer", self.ref_11c51);
  }

  if(self.modifier == "_all_timed") {
    thread carepackage_set_useable();
    return;
  }
}

function calculatepurchasexp() {
  if(self.modifier == "_all_timed") {
    if(istrue(level.questinfo.ref_132e8)) {
      level.squaddata[self.targetteam][self.ref_13a8c].should_save_debug_info = 1;
    } else {
      scripts\mp\utility\teams::setteamdata(self.targetteam, "hasFailed", 1);
    }

    brgetloadoutoptionstandardloadoutindex(self.hunterteam);
    scripts\mp\gametypes\br_quest_util::removequestinstance();
    return;
  }

  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.hunterteam, "br_assassination_timer_expire_hunters_lose");
  var0 = scripts\mp\gametypes\br_quest_util::ringing(self.targetteam);
  var1 = scripts\mp\gametypes\br_quest_util::rewardmodifier("assassination", var0);
  self.ref_12d2d = "_averted";
  var2 = spawnStruct();
  var3 = scripts\mp\gametypes\br_quest_util::getquestindex("assassination");
  var4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("assassination", self.ref_12d2d, self.modifier));
  var2.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var3, var0, var4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.targetteam, "br_assassination_timer_expire_targets_win", var2, self.ref_13a8c);

  if(istrue(level.questinfo.ref_132e8)) {
    var5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex);
    level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_ass_fail", 1, var5, 0);
    var5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c);
    level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_ass_hunted_timed_out", 1, var5, 0);
  } else {
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_fail", self.hunterteam, 1);
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_hunted_timed_out", self.targetteam, 1);
  }

  if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "gold_war") {
    var6 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c);
    scripts\mp\gametypes\br_quest_util::search_speed(self.targetteam, self.targetplayer.origin, self.targetplayer.angles, self.ref_12d30, var6, self.ref_13a8c);
    return;
  }
}

function aq_playerdied(var0, var1) {
  if(var1 scripts\mp\gametypes\br_public::isplayeringulag()) {
    return;
  }

  thread calculatewinningteam(var1, var0);
}

function calculateweaponmatchbonus(var0) {
  thread calculatewinningteam(var0);
}

function calculatewinningteam(var0, var1) {
  if(self.modifier == "_all_timed" && (istrue(level.questinfo.ref_132e8) && istrue(level.squaddata[self.hunterteam][self.squadindex].should_save_debug_info) || scripts\mp\utility\teams::getteamdata(self.hunterteam, "hasFailed"))) {
    return;
  }

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    if(!isbot(var0)) {
      return;
    }
  }

  if(var0.team == self.targetteam) {
    if(var0 == self.targetplayer) {
      var2 = var0.attackers;
      wait 0.75;
      var3 = spawnStruct();
      var4 = scripts\mp\gametypes\br_quest_util::ringing(self.hunterteam);
      var5 = scripts\mp\gametypes\br_quest_util::getquestindex("assassination");

      if(isDefined(var1) && isDefined(var1.team) && var1.team == self.hunterteam) {
        var6 = "br_assassination_complete_hunters_win";
        self.ref_12d2d = "_target_killed";
        scripts\mp\gametypes\br_quest_util::lookforvehicles(self.hunterteam, var1, 8, scripts\mp\gametypes\br_quest_util::getquestindex("assassination"));

        foreach(var8 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
          var8 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_complete_wz_bounty_contracts_for_operator_mission", 1);
        }
      } else {
        var6 = "br_assassination_complete_target_vanished";
        self.ref_12d2d = "_target_vanished";
      }

      var10 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("assassination", self.ref_12d2d, self.modifier));
      var11 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(var2);
      var4.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var6, var5, var10, undefined, var11);
      scripts\mp\gametypes\br_quest_util::displayteamsplash(self.hunterteam, var6, var4);
      level notify("assassination_quest_completed", self.hunterteam, self.squadindex);

      if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
        if(istrue(level.questinfo.ref_132e8)) {
          var12 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex);
          level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_ass_success", 1, var12, 0);
        } else {
          level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_success", self.hunterteam, 1);
        }
      }

      self.ref_12d2e = var1.origin;
      self.ref_12d2b = var1.angles;

      if(isDefined(var3)) {
        foreach(var14 in var3) {
          if(isDefined(var14.team) && var14.team == self.hunterteam) {
            scripts\mp\gametypes\br_quest_util::ref_12b15(var14);
          }
        }
      }

      self.result = "success";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
    }

    if(self.modifier == "_all_timed") {
      if(!isDefined(level.gulag) || isDefined(level.gulag) && !istrue(level.gulag.shutdown)) {
        foreach(var8 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
          if(istrue(var8.inlaststand)) {
            var8 scripts\mp\laststand::playanim_aibegindismountturret("use_hold_revive_success", var8);
          }

          if(!isalive(var8)) {
            var8 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
            var8 thread scripts\mp\gametypes\br_gulag::playergulagautowin("assassinationQuest");
          }
        }

        return;
      }

      return;
    }

    return;
  }

  if(var8.team == self.hunterteam) {
    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(self.hunterteam, relic_steelballs_dodamage(self.modifier))) {
      if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
        self.result = "fail";
        scripts\mp\gametypes\br_quest_util::removequestinstance();
        return;
      }

      self.ref_12d2d = "_averted";
      var18 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c);
      var19 = scripts\mp\gametypes\br_quest_util::search_speed(self.targetteam, var8.origin, var8.angles, self.ref_12d30, var18, self.ref_13a8c);
      var3 = spawnStruct();
      var3.ref_127d5 = scripts\mp\gametypes\br::get_int_or_0(var19["plunder"]);
      scripts\mp\gametypes\br_quest_util::displayteamsplash(self.targetteam, "br_assassination_complete_targets_win", var3, self.ref_13a8c);
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function getnewtargetplayer(var0) {
  if(istrue(level.questinfo.ref_132e8)) {
    lbravo_spawner_jammer2b(self.targetteam, var0);
  } else {
    determinetargetplayer(self.targetteam, var0);
  }

  determinetrackingcircleposition(self.targetplayer);
  lbravo_spawner_jammer3b();
  updateassassinationhud();
}

function removeallaqui() {
  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    hideassassinationhud(var1, self);
  }

  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c)) {
    spawn_cache4_rpgs(var1);
  }

  scripts\mp\gametypes\br_quest_util::lastdirtyscore();
}

function getplayerkills() {
  if(level.br_leaderbystreak) {
    return self.killsthislife.size;
  }

  return self.kills;
}

function relic_steelballs_dodamage(var0) {
  switch (var0) {
    case "_all_timed":
    case "_all":
      return level.questinfo.defaultfilter;
    default:
      return 0;
  }
}

function showassassinationhud(var0) {
  self.aq_hudenabled = 1;
  scripts\mp\gametypes\br_quest_util::uiobjectiveshow("assassination" + var0.modifier);
  var0 scripts\mp\gametypes\br_quest_util::ref_1336a(self);
}

function hideassassinationhud(var0) {
  self.aq_hudenabled = 0;
  scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  var0 scripts\mp\gametypes\br_quest_util::spawn_dogtags(self);
}

function ref_13fc2(var0, var1) {
  if(isDefined(self.call_exfil) && self.call_exfil) {
    var2 = var0 getentitynumber();
  } else {
    var2 = -1;
  }

  var2 = var1 getentitynumber();
  var2 += 1;
  var3 = var2 << 8 | var2;
  self setclientomnvar("ui_br_assassination_target", var3);
}

function ref_13fc3(var0) {
  foreach(var2 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c)) {
    ref_13fc2(var2, self.targetplayer, self.ref_13b39);
  }
}

function ref_13344(var0, var1) {
  self.call_exfil = 1;
  ref_13fc2(var0, var1);
}

function spawn_cache4_rpgs() {
  self.call_exfil = 0;
  self setclientomnvar("ui_br_assassination_target", 0);
}

function updateassassinationhud() {
  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    showassassinationhud(var1, self);
    var1 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(self.targetplayer getentitynumber());
  }

  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c)) {
    ref_13344(var1, self.targetplayer, self.ref_13b39);
  }
}

function carepackage_set_useable() {
  self notify("assassinationTimeWarning");
  self endon("assassinationTimeWarning");
  self endon("removed");
  var0 = [300, 240, 180, 120, 90, 60, 30, 10];

  foreach(var2 in var0) {
    var3 = (self.ref_11c51 - gettime()) / 1000;
    var4 = var3 - var2;

    if(var4 < 0) {
      continue;
    }

    wait var4;
    var5 = int(var2 / 60);
    var6 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex), relic_steelballs_dodamage(self.modifier));

    foreach(var8 in var6) {
      var9 = gettime() + var2 * 1000;
      var10 = 5;

      if(var2 <= 20) {
        var10 = var2;
      }

      var8 scripts\mp\utility\lower_message::ref_1316e("br_assassin_mission_time_warning", var9, var10);

      if(var5 >= 2) {
        var8 iprintlnbold(&"MP_BR_INGAME/MISSION_ASSASSIN_2_TIME_WARNING_MIN", var5);
        continue;
      }

      var8 iprintlnbold(&"MP_BR_INGAME/MISSION_ASSASSIN_2_TIME_WARNING_SEC", var2);
    }
  }
}

function brexfilanimname() {
  thread breventsinit();
}

function breventsinit() {
  scripts\mp\flags::gameflagwait("prematch_done");
  var0 = getdvarint("scr_br_all_assassin_version", 0);

  if(!var0) {
    return;
  }

  var1 = getdvarint("scr_br_all_assassin_wait_time", 120);
  loadtables();
  wait var1;
  breventflagset(var0);
}

function breventflagset(var0) {
  var1 = spawnStruct();
  var1.ref_13ab1 = [];
  var1.wam_interaction_structs = [];
  var1.ref_12cc9 = int(getdvarfloat("scr_br_all_assassin_rest_time", 10) * 1000);

  if(var0 == 1) {
    var1.modifier = "_all";
  } else if(var0 == 2) {
    var1.modifier = "_all_timed";
  }

  if(var1.modifier == "_all_timed") {
    brgetloadoutammomax(var1);
  } else {
    brgametype(var1);
  }

  thread brevent4();
  thread brhandleinvulnerability();
}

function breventflagclear() {
  var0 = (0, 0, 0);
  var1 = brgetloadoutoptionforname();
  var2 = [];

  foreach(var4 in var1) {
    var5 = undefined;
    var6 = scripts\mp\utility\teams::getteamdata(var4, "players");

    foreach(var8 in var6) {
      if(var8 scripts\mp\gametypes\br_public::isplayeringulag()) {
        continue;
      }

      if(var8 scripts\mp\gametypes\br_public::updatedragonsbreath()) {
        var5 = var8;
        break;
      }

      if(!isDefined(var5)) {
        var5 = var8;
      }
    }

    if(!isDefined(var5)) {
      continue;
    }

    var10 = spawnStruct();
    var10.team = var4;
    var10.pos = var5.origin;
    var0 += var10.pos;
    var2 = var10;
  }

  if(var2.size < 2) {
    return var2;
  }

  var0 /= var2.size;

  foreach(var10 in var2) {
    var13 = var10.pos - var0;
    var10.ref_134da = vectortoangles(var13)[1];
  }

  var2 = scripts\mp\utility\script::quicksort(var2, &brgetloadoutdropbagsdelayseconds);
  return var2;
}

function brgametype() {
  var0 = breventflagclear();
  var1 = getdvarint("scr_br_all_assassin_group_size", 150);
  var2 = var0.size;

  if(isDefined(var1)) {
    var1 = int(min(var1, var2));
  } else {
    var1 = var2;
  }

  var3 = int(var2 / var1);
  var4 = var2 % var1;
  var5 = [];

  for(var6 = 0; var6 < var3; var6++) {
    var5 = var1;
  }

  for(var6 = 0; var6 < var4; var6++) {
    var5++;
  }

  var7 = 0;

  for(var6 = 0; var6 < var5.size; var6++) {
    var1 = var5[var6];

    for(var8 = 0; var8 < var1; var8++) {
      var9 = var0[var7 + var8].team;
      var10 = ref_145eb(var8 - 1, var1);
      var11 = ref_145eb(var8 + 1, var1);
      var12 = var0[var7 + var10].team;
      var13 = var0[var7 + var11].team;
      var14 = spawnStruct();
      var14.ref_13a75 = var12;
      var14.ref_13a78 = var13;
      self.ref_13ab1[var9] = var14;
    }

    var7 += var1;
  }
}

function brgetloadoutammomax() {
  var0 = getdvarfloat("scr_br_all_assassin_max_dist", 10000);
  var1 = breventflagclear();

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2].team;

    if(isDefined(self.ref_13ab1[var3])) {
      continue;
    }

    for(var4 = 0; var4 < var1.size - 1; var4++) {
      if(var4 % 2) {
        var5 = int(-0.5 * var4 - 0.5);
      } else {
        var5 = int(0.5 * var4 + 1);
      }

      var6 = ref_145eb(var2 + var5, var1.size);
      var7 = var1[var6].team;

      if(isDefined(self.ref_13ab1[var7])) {
        continue;
      }

      var8 = var1[var6].pos;
      var9 = var1[var2].pos;

      if(distance(var8, var9) > var0) {
        continue;
      }

      var10 = spawnStruct();
      var10.ref_13a75 = var7;
      var10.ref_13a78 = var7;
      self.ref_13ab1[var3] = var10;
      var11 = spawnStruct();
      var11.ref_13a75 = var3;
      var11.ref_13a78 = var3;
      self.ref_13ab1[var7] = var11;
      break;
    }
  }
}

function brgetloadoutoptionforname() {
  var0 = gettime();
  var1 = [];

  foreach(var5, var3 in level.teamdata) {
    if(isDefined(self.ref_13ab1[var5])) {
      continue;
    }

    var4 = self.wam_interaction_structs[var5];

    if(isDefined(var4) && var0 < var4 + self.ref_12cc9) {
      continue;
    }

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var5, relic_steelballs_dodamage(self.modifier))) {
      continue;
    }

    var1 = var5;
  }

  return var1;
}

function brgetloadoutammomultiplier(var0) {
  var0 waittill("removed");
  self.wam_interaction_structs[var0.hunterteam] = gettime();
  self notify("update");
}

function brhandleinvulnerability() {
  var0 = getdvarint("scr_br_all_assassin_update_delay", 10);

  for(;;) {
    scripts\engine\utility::waittill_notify_or_timeout("update", var0);

    if(self.modifier == "_all_timed") {
      brgivestartfieldupgrade();
      continue;
    }

    brgetoperatorteam();
  }
}

function brgivestartfieldupgrade() {
  var0 = [];

  foreach(var3, var2 in self.ref_13ab1) {
    if(!isDefined(level.questinfo.quests["assassination"].instances[var3])) {
      var0 = var3;
    }
  }

  foreach(var3 in var0) {
    self.ref_13ab1[var3] = undefined;
  }

  brgetloadoutammomax();
  brevent4();
}

function brgetoperatorteam() {
  var0 = [];

  foreach(var3, var2 in self.ref_13ab1) {
    if(!isDefined(level.questinfo.quests["assassination"].instances[var3])) {
      if(var2.ref_13a78 == var2.ref_13a75) {
        var0 = var3;
      }
    }
  }

  foreach(var3 in var0) {
    self.ref_13ab1[var3] = undefined;
  }

  var6 = brgetloadoutoptionforname();
  var7 = var6.size;
  var0 = [];

  foreach(var3, var2 in self.ref_13ab1) {
    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var3, relic_steelballs_dodamage(self.modifier))) {
      if(var7 > 0) {
        var7--;
        var9 = var6[var7];
        self.ref_13ab1[var9] = spawnStruct();
        self.ref_13ab1[var9].ref_13a78 = var2.ref_13a78;
        self.ref_13ab1[var9].ref_13a75 = var2.ref_13a75;
        self.ref_13ab1[var2.ref_13a75].ref_13a78 = var9;
        self.ref_13ab1[var2.ref_13a78].ref_13a75 = var9;
      } else {
        self.ref_13ab1[var2.ref_13a75].ref_13a78 = var2.ref_13a78;
        self.ref_13ab1[var2.ref_13a78].ref_13a75 = var2.ref_13a75;
      }

      var0 = var3;
    }
  }

  foreach(var3 in var0) {
    self.ref_13ab1[var3] = undefined;
  }

  if(var7 >= 2) {
    for(var12 = 0; var12 < var7; var12++) {
      var3 = var6[var12];
      var13 = ref_145eb(var12 - 1, var7);
      var14 = ref_145eb(var12 + 1, var7);
      var15 = var6[var13];
      var16 = var6[var14];
      var17 = spawnStruct();
      var17.ref_13a75 = var15;
      var17.ref_13a78 = var16;
      self.ref_13ab1[var3] = var17;
    }
  }

  if(self.ref_13ab1.size < 2) {
    return;
  }

  brevent4();
}

function brevent4() {
  foreach(var1 in self.ref_13ab1) {
    if(isDefined(level.questinfo.quests["assassination"].instances[var6])) {
      continue;
    }

    var2 = var6;
    var3 = var1.ref_13a78;
    var4 = "all_" + var2 + "_" + var3;
    var5 = search(var2, var3, var4, undefined, self.modifier);

    if(isDefined(var5)) {
      search_target_think(var5);

      if(self.modifier == "_all_timed") {
        thread brgulagdamagefilter();
      }

      thread brgetloadoutammomultiplier(var5);
    }
  }
}

function brgulagdamagefilter() {
  self endon("removed");
  var0 = getdvarfloat("scr_br_all_assassin_circle_start_update", 5);
  var1 = getdvarfloat("scr_br_all_assassin_circle_end_update", 0.5);

  for(;;) {
    aq_questthink_circleposition();
    determinetrackingcircleposition(self.targetplayer);
    var2 = riotshield_common();
    var3 = var0 - var1;
    wait var3 * var2 + var1;
  }
}

function brgetloadoutdropbagsdelayseconds(var0, var1) {
  return var0.ref_134da <= var1.ref_134da;
}

function brgetloadoutoptionstandardloadoutindex(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(scripts\mp\utility\teams::getteamdata(var0, "players"));

  foreach(var3 in var1) {
    if(isalive(var3)) {
      var3 kill(var3.origin, var3);
    }
  }

  scripts\mp\gametypes\br_quest_util::displayteamsplash(var0, "br_assassination_timer_expire_hunters_lose");

  if(istrue(level.questinfo.ref_132e8)) {
    var5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, self.squadindex);
    level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_ass_fail", 1, var5, 0);
    return;
  }

  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_fail", var0, 1);
}

function ref_145eb(var0, var1) {
  return (var0 % var1 + var1) % var1;
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
  var0 = scripts\mp\gametypes\br_quest_util::getquestdata("assassination").ref_1296b;
  var1 = (self.ref_11c51 - gettime()) / 1000;
  var2 = clamp(var1 / var0, 0, 1);
  return var2;
}

function relic_amped_test_explode_other_player() {
  if(self.modifier == "_all_timed") {
    var0 = getdvarfloat("scr_br_all_assassin_circle_start_size", 3000);
    var1 = getdvarfloat("scr_br_all_assassin_circle_end_size", 200);
    var2 = riotshield_common();
    var3 = var0 - var1;
    return (var3 * var2 + var1);
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
    var0 = relic_amped_test_explode_other_player();
    return (var0 * 0.5);
  }

  return 900;
}

function playlandingbreath() {
  var0 = 0;
  var1 = scripts\mp\gametypes\br_gametypes::ref_12e05("overrideQuestSearchParams", "assassination");

  if(isDefined(var1)) {
    return var1;
  }

  var2 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var2) {
    case "mini":
    case "gold_war":
    case "risk":
    case "rat_race":
    case "dmz":
      var0 = 1;
      break;
  }

  return var0;
}