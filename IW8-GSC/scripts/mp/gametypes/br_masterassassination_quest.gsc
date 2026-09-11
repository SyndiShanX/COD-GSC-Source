/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_masterassassination_quest.gsc
*****************************************************************/

function init() {
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("masterassassination", 1);

  if(!var0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_12b38("masterassassination_all");
  scripts\mp\gametypes\br_quest_util::ref_12b38("masterassassination_all_timed");
  scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").ref_1296b = getdvarint("scr_br_MAQ_questTimeBase", 180);
  scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").ref_1296c = getdvarint("scr_br_MAQ_questTimeBonus", 60);
  scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").ref_12c82 = getdvarint("scr_br_MAQ_resetTimerOnKill", 1);
  scripts\mp\gametypes\br_quest_util::registerquestthink("masterassassination", &ref_11af5, 10);
  scripts\mp\gametypes\br_quest_util::registerquestthink("masterassassination", &ref_11af6, 0.2);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("masterassassination", &ref_11af7);
  scripts\mp\gametypes\br_quest_util::registeronplayerkilled("masterassassination", &ref_11af2);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("masterassassination", &ref_11af3);
  var1 = level.questinfo.defaultfilter;
  var1 = scripts\engine\utility::array_add(var1, &scripts\mp\gametypes\br_assassination_quest::filtercondition_hasbeentracked);
  var1 = scripts\engine\utility::array_add(var1, &scripts\mp\gametypes\br_quest_util::filtercondition_isdowned);

  if(getdvarint("scr_br_alt_mode_zxp", 0)) {
    var1 = scripts\engine\utility::array_add(var1, &scripts\mp\gametypes\br_quest_util::play_landlord_infil_vo);
  }

  scripts\mp\gametypes\br_quest_util::registerplayerfilter("masterassassination", var1, 0);
  scripts\mp\gametypes\br_quest_util::ref_1297c("masterassassination", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b32("masterassassination", &ref_11af1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("masterassassination", &ref_11af0);
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

function ref_11af5() {
  if(self.modifier == "_all_timed") {
    return;
  }

  if(!isDefined(self.targetplayer)) {
    return;
  }

  scripts\mp\gametypes\br_assassination_quest::determinetrackingcircleposition(self.targetplayer);
  scripts\mp\gametypes\br_assassination_quest::lbravo_spawner_jammer3b();
  ref_13ff8(self.targetteam);
}

function ref_11af6() {
  ref_11aed();
}

function ref_11af7() {
  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c)) {
    scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").inner = scripts\engine\utility::array_remove(scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").inner, var1);
  }

  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.hunterteam);
  scripts\mp\gametypes\br_assassination_quest::removeallaqui();
}

function takequestitem(var0) {
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var1 = self.team;
  var2 = determinetargetteam(self);
  var3 = search(var1, var2, var0.index, self, "", var0);

  if(!isDefined(var3)) {
    scripts\mp\utility\lower_message::ref_1316e("br_assassination_notargets", undefined, 5);
    return;
  }

  search_target_think(var3, self);
}

function search_target_think(var0) {
  var1 = spawnStruct();
  var1.excludedplayers = [];
  var1.excludedplayers[0] = self.targetplayer;

  if(isDefined(var0)) {
    var1.excludedplayers[1] = var0;
  }

  var1.stringvar = self.targetplayer.name;
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.targetteam, "br_masterassassination_quest_start_target_team", var1, self.ref_13a8c);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self.targetplayer, "br_masterassassination_quest_start_target_player");

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
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.hunterteam, "br_masterassassination_quest_start_hunter_team", var1);

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    if(istrue(level.questinfo.ref_132e8)) {
      var2 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex);
      level thread scripts\mp\gametypes\br_public::brleaderdialog("mission_ass_accept", 1, var2, 0);
    } else {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_ass_accept", self.hunterteam, 1);
    }
  }

  if(isDefined(var0)) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var0, "br_masterassassination_quest_start_tablet_finder", var1);
    scripts\mp\gametypes\br_quest_util::lookforvehicles(self.hunterteam, var0, 6, scripts\mp\gametypes\br_quest_util::getquestindex("masterassassination"));
    return;
  }
}

function search(var0, var1, var2, var3, var4, var5, var6) {
  var7 = var0;

  if(istrue(level.questinfo.ref_132e8)) {
    var7 = var3.team + var3.squadindex;
  }

  var8 = scripts\mp\gametypes\br_quest_util::createquestinstance("masterassassination", var7, var2, var5, var3.squadindex);
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

  var8 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(4, 16);

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
    var8 scripts\mp\gametypes\br_quest_util::ref_1297d(scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").ref_1296b, 4);
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").alltrackedplayers = scripts\engine\utility::array_combine(scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").alltrackedplayers, scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1, var8.ref_13a8c));
  scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").inner = scripts\engine\utility::array_combine(scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").inner, scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1, var8.ref_13a8c));

  if(var8.modifier == "_all_timed") {
    if(istrue(level.questinfo.ref_132e8)) {
      level.squaddata[var0][var8.squadindex].should_save_debug_info = 0;
    } else {
      level.teamdata[var0]["hasFailed"] = 0;
    }
  }

  var8 scripts\mp\gametypes\br_assassination_quest::determinetrackingcircleposition(var8.targetplayer);
  var8 scripts\mp\gametypes\br_assassination_quest::lbravo_spawner_jammer3b();
  ref_13ff8(var8, var8.targetteam);
  ref_11aed(var8);
  scripts\mp\gametypes\br_quest_util::addquestinstance("masterassassination", var8);
  scripts\mp\gametypes\br_quest_util::ref_13879("masterassassination", var3, var0);
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
  var4 = scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").alltrackedplayers;
  var5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1, self.squadindex);
  var6 = scripts\engine\utility::array_combine_unique(var4, var5);

  if(istrue(level.questinfo.ref_132e8)) {
    var6 = scripts\engine\utility::array_combine_unique(var6, scripts\mp\utility\teams::getteamdata(var1, "players"));
  }

  if(var3.size == var6.size && getdvarint("scr_assassin_quest_reset_list", 1)) {
    scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").alltrackedplayers = scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").inner;
    var4 = scripts\mp\gametypes\br_quest_util::getquestdata("masterassassination").alltrackedplayers;
    var5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1, self.squadindex);
    var6 = scripts\engine\utility::array_combine_unique(var4, var5);

    if(istrue(level.questinfo.ref_132e8)) {
      var6 = scripts\engine\utility::array_combine_unique(var6, scripts\mp\utility\teams::getteamdata(var1, "players"));
    }
  }

  var7 = 0;
  var8 = level.questinfo.quests["masterassassination"].filters[0];
  var9 = 5000;
  var10 = 30000;
  jumpiffalse(scripts\mp\gametypes\br_assassination_quest::playlandingbreath()) LOC_0000011a;
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
    var2 = undefined;
    var18 = -1;
    var19 = -1;
    var20 = -1;
    var21 = -1;
    var22 = -1;
    var23 = undefined;

    foreach(var30, var25 in var12) {
      if(!isDefined(var2)) {
        var2 = var30;
        var18 = rpg_guys_construction_spawners(var30);
        var19 = rpg_guys(var30);
        var20 = rpg_shoot_at_trig_watch(var30);
        var21 = rpg_max_range(var30);
      }

      var26 = rpg_guys_construction_spawners(var30);
      var27 = rpg_guys(var30);
      var28 = rpg_shoot_at_trig_watch(var30);
      var29 = rpg_max_range(var30);

      if(var26 < var18) {
        continue;
      } else if(var26 > var18) {
        var2 = var30;
        var18 = var26;
        var19 = var27;
        var20 = var28;
        var21 = var29;
        continue;
      }

      if(var27 < var19) {
        continue;
      } else if(var27 > var19) {
        var2 = var30;
        var18 = var26;
        var19 = var27;
        var20 = var28;
        var21 = var29;
        continue;
      }

      if(var28 < var20) {
        continue;
      } else if(var28 > var20) {
        var2 = var30;
        var18 = var26;
        var19 = var27;
        var20 = var28;
        var21 = var29;
        continue;
      }

      if(var29 > var21) {
        continue;
      }

      if(var29 > var21) {
        var2 = var30;
        var18 = var26;
        var19 = var27;
        var20 = var28;
        var21 = var29;
        continue;
      }

      if(!isDefined(var23)) {
        var23 = randomintrange(1, 2);
      }

      if(var23 == 1) {
        var2 = var30;
        var18 = var26;
        var19 = var27;
        var20 = var28;
        var21 = var29;
        var23 = undefined;
        continue;
      }

      var23 = undefined;
    }

    return var2;
  }
}

function getnewtargetplayer(var0) {
  determinetargetplayer(self.targetteam, var0);
  scripts\mp\gametypes\br_assassination_quest::determinetrackingcircleposition(self.targetplayer);
  scripts\mp\gametypes\br_assassination_quest::lbravo_spawner_jammer3b();
  ref_13ff7();
}

function determinetargetplayer(var0, var1) {
  var2 = -1;
  var3 = -1;
  var4 = -1;
  var5 = -1;
  var6 = undefined;
  var7 = undefined;

  foreach(var9 in level.teamdata[var0]["players"]) {
    var10 = var9;

    if(!scripts\mp\gametypes\br_quest_util::isplayervalid(var10, scripts\mp\gametypes\br_assassination_quest::relic_steelballs_dodamage(self.modifier))) {
      continue;
    }

    if(!isDefined(var6)) {
      var6 = var10;
      var2 = var10.plundercount;
      var3 = var10.score;
      var4 = var10.extrascore3;
      var5 = var10.kills;
    }

    if(var10.kills > var5) {
      var6 = var10;
      continue;
    }

    if(var10.extrascore3 > var4) {
      var6 = var10;
      continue;
    }

    if(var10.score > var3) {
      var6 = var10;
      continue;
    }

    if(var10.plundercount > var2) {
      var6 = var10;
      continue;
    }

    if(!isDefined(var7)) {
      var7 = randomintrange(1, 2);
    }

    if(var7 == 1) {
      var6 = var10;
      var7 = undefined;
      continue;
    }

    var7 = undefined;
  }

  var6.hasbeentracked = 0;
  self.targetplayer = var6;
  self.ref_13a8c = var6.squadindex;
}

function ref_11aed() {
  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    var2 = var1 scripts\mp\gametypes\br_public::isplayeringulag();
    var3 = isDefined(var1.ref_11aef) && var1.ref_11aef;

    if(var2 && var3) {
      spawn_custom_type(var1, self);
    }

    if(!var2 && !var3) {
      ref_13360(var1, self);
    }
  }

  var5 = self.squadindex;

  if(isDefined(self.targetplayer.squadindex)) {
    var5 = self.targetplayer.squadindex;
  }

  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, var5)) {
    var2 = var1 scripts\mp\gametypes\br_public::isplayeringulag();
    var3 = isDefined(var1.ref_11af8) && var1.ref_11af8;

    if(var2 && var3) {
      spawn_custom_type_array(var1);
    }

    if(!var2 && !var3) {
      ref_13361(var1, self.targetplayer, self.ref_13b39);
    }
  }
}

function ref_11af1() {
  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c)) {
    var1 setclientomnvar("ui_br_assassination_target_timer", self.ref_11c51);
  }

  if(self.modifier == "_all_timed") {
    thread ref_11b1c();
    return;
  }
}

function ref_11af0() {
  if(self.modifier == "_all_timed") {
    if(istrue(level.questinfo.ref_132e8)) {
      level.squaddata[self.targetteam][self.ref_13a8c].should_save_debug_info = 1;
    } else {
      scripts\mp\utility\teams::setteamdata(self.targetteam, "hasFailed", 1);
    }

    scripts\mp\gametypes\br_assassination_quest::brgetloadoutoptionstandardloadoutindex(self.hunterteam);
    scripts\mp\gametypes\br_quest_util::removequestinstance();
    return;
  }

  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.hunterteam, "br_masterassassination_timer_expire_hunters_lose");
  var0 = scripts\mp\gametypes\br_quest_util::ringing(self.targetteam);
  var1 = scripts\mp\gametypes\br_quest_util::rewardmodifier("masterassassination", var0);
  self.ref_12d2d = "_averted";
  var2 = spawnStruct();
  var3 = scripts\mp\gametypes\br_quest_util::getquestindex("masterassassination");
  var4 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("masterassassination", self.ref_12d2d, self.modifier));
  var2.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var3, var0, var4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.targetteam, "br_masterassassination_timer_expire_targets_win", var2, self.ref_13a8c);

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

function ref_11af2(var0, var1) {
  if(var1 scripts\mp\gametypes\br_public::isplayeringulag()) {
    return;
  }

  thread ref_11af4(var1, var0);
}

function ref_11af3(var0) {
  thread ref_11af4(var0);
}

function ref_11af4(var0, var1) {
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
      var5 = scripts\mp\gametypes\br_quest_util::getquestindex("masterassassination");

      if(isDefined(var1) && isDefined(var1.team) && var1.team == self.hunterteam) {
        var6 = "br_masterassassination_complete_hunters_win";
        self.ref_12d2d = "_target_killed";
        scripts\mp\gametypes\br_quest_util::lookforvehicles(self.hunterteam, var1, 8, scripts\mp\gametypes\br_quest_util::getquestindex("masterassassination"));

        foreach(var8 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
          var8 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_complete_wz_bounty_contracts_for_operator_mission", 1);
        }
      } else {
        var6 = "br_masterassassination_complete_target_vanished";
        self.ref_12d2d = "_target_vanished";
      }

      var10 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("masterassassination", self.ref_12d2d, self.modifier));
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
    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(self.hunterteam, scripts\mp\gametypes\br_assassination_quest::relic_steelballs_dodamage(self.modifier))) {
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
      scripts\mp\gametypes\br_quest_util::displayteamsplash(self.targetteam, "br_masterassassination_complete_targets_win", var3, self.ref_13a8c);
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function rpg_guys_construction_spawners(var0) {
  var1 = 0;

  foreach(var3 in level.teamdata[var0]["players"]) {
    var1 += var3.kills;
  }

  return var1;
}

function rpg_shoot_at_trig_watch(var0) {
  var1 = 0;

  foreach(var3 in level.teamdata[var0]["players"]) {
    var1 += var3.score;
  }

  return var1;
}

function rpg_guys(var0) {
  var1 = 0;

  foreach(var3 in level.teamdata[var0]["players"]) {
    var1 += var3.extrascore3;
  }

  return var1;
}

function rpg_max_range(var0) {
  var1 = 0;

  foreach(var3 in level.teamdata[var0]["players"]) {
    var1 += var3.plundercount;
  }

  return var1;
}

function ref_11aee(var0) {
  switch (var0) {
    case "_all_timed":
    case "_all":
      return level.questinfo.defaultfilter;
    default:
      return 0;
  }
}

function ref_13360(var0) {
  self.ref_11aef = 1;
  scripts\mp\gametypes\br_quest_util::uiobjectiveshow("masterassassination" + var0.modifier);
  var0 scripts\mp\gametypes\br_quest_util::ref_1336a(self);
}

function spawn_custom_type(var0) {
  self.ref_11aef = 0;
  scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  var0 scripts\mp\gametypes\br_quest_util::spawn_dogtags(self);
}

function ref_13ff6(var0, var1) {
  if(isDefined(self.ref_11af8) && self.ref_11af8) {
    var2 = var0 getentitynumber();
  } else {
    var2 = -1;
  }

  var2 = var1 getentitynumber();
  var2 += 1;
  var3 = var2 << 8 | var2;
  self setclientomnvar("ui_br_assassination_target", var3);
}

function ref_13ff8(var0) {
  foreach(var2 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c)) {
    ref_13ff6(var2, self.targetplayer, self.ref_13b39);
  }
}

function ref_13361(var0, var1) {
  self.ref_11af8 = 1;
  ref_13ff6(var0, var1);
}

function spawn_custom_type_array() {
  self.ref_11af8 = 0;
  self setclientomnvar("ui_br_assassination_target", 0);
}

function ref_13ff7() {
  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    ref_13360(var1, self);
    var1 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(self.targetplayer getentitynumber());
  }

  foreach(var1 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.targetteam, self.ref_13a8c)) {
    ref_13361(var1, self.targetplayer, self.ref_13b39);
  }
}

function ref_11b1c() {
  self notify("masterAssassinationTimeWarning");
  self endon("masterAssassinationTimeWarning");
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
    var6 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.hunterteam, self.squadindex), ref_11aee(self.modifier));

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