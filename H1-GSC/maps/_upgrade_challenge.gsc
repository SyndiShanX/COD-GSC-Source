/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_upgrade_challenge.gsc
***************************************/

init() {
  upgrade_init_tables();

  if(isdefined(level.player))
    upgrade_init_player(level.player);
}

upgrade_init_tables() {
  level.upgrade_chal_stat_map = [];
  level.upgrade_chal_stat_map["kills"] = "ch_kills";
  level.upgrade_chal_stat_map["headshots"] = "ch_headshots";
  level.upgrade_chal_stat_map["kills_grenades"] = "ch_frag_kills";
  level.upgrade_chal_stat_map["intel"] = "ch_intel";
  level.upgrade_chal_index = [];
  level.upgrade_chal_complete_messages = [];
  level.upgrade_chal_points_trackers = [];
  var_0 = 0;

  for (;;) {
    var_1 = int(tablelookupbyrow("sp\upgrade_challenges.csv", var_0, 0));
    var_2 = tablelookupbyrow("sp\upgrade_challenges.csv", var_0, 1);

    if(var_2 == "") {
      break;
    }

    level.upgrade_chal_index[var_2] = var_1;
    level.upgrade_chal_goal[var_1] = [];
    level.upgrade_chal_complete_messages[var_1] = tablelookupbyrow("sp\upgrade_challenges.csv", var_0, 4);
    level.upgrade_chal_points_trackers[var_1] = 0;
    var_3 = 10;

    for (;;) {
      var_4 = int(tablelookupbyrow("sp\upgrade_challenges.csv", var_0, var_3));

      if(var_4 <= 0) {
        break;
      }

      level.upgrade_chal_goal[var_1][level.upgrade_chal_goal[var_1].size] = var_4;
      var_3++;
    }

    var_0++;
  }
}

upgrade_init_player(var_0) {
  var_0 maps\_player_stats::stat_notify_register_func(::upgrade_notify_stat);

  if(isdefined(level.upgrade_chal_index) && level.upgrade_chal_index.size > 0) {
    var_0.stats["upgradeChallengeStage"] = [];
    var_0.stats["upgradeChallengeProgress"] = [];

    if(!isdefined(var_0.stats["upgradePoints"]))
      var_0.stats["upgradePoints"] = 0;

    foreach(var_3, var_2 in level.upgrade_chal_stat_map)
    var_0 upgrade_notify_stat(var_3, 0);
  }
}

give_player_challenge_kill(var_0) {
  upgrade_notify_stat("kills", var_0);
}

give_player_challenge_headshot(var_0) {
  upgrade_notify_stat("headshots", var_0);
  give_player_challenge_kill(var_0);
}

give_player_challenge_frag(var_0) {
  upgrade_notify_stat("kills_grenades", var_0);
  give_player_challenge_kill(var_0);
}

upgrade_notify_stat(var_0, var_1) {
  if(isdefined(level.upgrade_chal_stat_map) && isdefined(level.upgrade_chal_stat_map[var_0])) {
    if(!isdefined(level.upgrade_chal_index[level.upgrade_chal_stat_map[var_0]])) {
      return;
    }
    var_2 = level.upgrade_chal_index[level.upgrade_chal_stat_map[var_0]];
    var_3 = getomnvar("ui_pm_t_" + var_0);
    setomnvar("ui_pm_t_" + var_0, var_3 + var_1);

    if(var_0 == "intel") {
      var_4 = int(self getlocalplayerprofiledata("sp_upgradeChallengeStage_" + var_2));

      if(!isdefined(self.stats["upgradeChallengeStage"][var_0])) {
        self.stats["intelUpgradePoints"] = 0;
        setomnvar("ui_pm_g_start_intel", var_4);
      }

      self.stats["upgradeChallengeStage"][var_0] = var_4;
      var_5 = int(self getlocalplayerprofiledata("sp_upgradeChallengeProgress_" + var_2));

      if(!isdefined(self.stats["upgradeChallengeProgress"][var_0]))
        setomnvar("ui_pm_p_start_intel", var_5);

      self.stats["upgradeChallengeProgress"][var_0] = var_5;
    } else {
      var_4 = 0;

      if(!isdefined(self.stats["upgradeChallengeStage"][var_0])) {
        var_4 = int(self getlocalplayerprofiledata("sp_upgradeChallengeStage_" + var_2));
        self.stats["upgradeChallengeStage"][var_0] = var_4;
      } else
        var_4 = self.stats["upgradeChallengeStage"][var_0];

      var_5 = 0;

      if(!isdefined(self.stats["upgradeChallengeProgress"][var_0])) {
        var_5 = int(self getlocalplayerprofiledata("sp_upgradeChallengeProgress_" + var_2));
        self.stats["upgradeChallengeProgress"][var_0] = var_5;
      } else
        var_5 = self.stats["upgradeChallengeProgress"][var_0];
    }

    var_6 = level.upgrade_chal_goal[var_2].size - 1;
    var_7 = level.upgrade_chal_goal[var_2][var_6];

    if(var_4 >= var_6 && var_5 >= var_7) {
      setomnvar("ui_pm_g_" + var_0, level.upgrade_chal_goal[var_2][var_6]);
      setomnvar("ui_pm_p_" + var_0, var_7);
      return;
    }

    var_8 = level.upgrade_chal_goal[var_2][var_4];
    var_9 = var_5;
    var_5 = var_5 + var_1;
    var_10 = 0;

    while (var_4 <= var_6 && var_5 >= var_8 && !var_10) {
      notifychallengecomplete(level.upgrade_chal_complete_messages[var_2]);

      if(var_0 == "intel")
        upgrade_challenge_complete_for_intel(var_2);
      else
        upgrade_challenge_complete(var_2);

      if(var_4 >= var_6 && var_5 >= var_7) {
        var_5 = var_7;
        var_10 = 1;
        continue;
      }

      var_5 = var_5 - var_8;
      var_4++;

      if(var_4 <= var_6)
        var_8 = level.upgrade_chal_goal[var_2][var_4];
    }

    self.stats["upgradeChallengeStage"][var_0] = var_4;
    self.stats["upgradeChallengeProgress"][var_0] = var_5;
    setomnvar("ui_pm_g_" + var_0, level.upgrade_chal_goal[var_2][var_4]);
    setomnvar("ui_pm_p_" + var_0, var_5);

    if(var_0 == "intel")
      commit_exo_awards_stage_and_progress(var_0, 1);
  }
}

upgrade_challenge_complete_for_intel(var_0, var_1) {
  commit_exo_awards_upgrade_points_custom(1);
  self.stats["intelUpgradePoints"]++;
  level.upgrade_chal_points_trackers[var_0] = self.stats["intelUpgradePoints"];
  var_2 = tablelookupbyrow("sp\upgrade_challenges.csv", var_0, 6);
  setomnvar(var_2, level.upgrade_chal_points_trackers[var_0]);
}

upgrade_challenge_complete(var_0) {
  if(!isdefined(self.stats["upgradePoints"]))
    self.stats["upgradePoints"] = 0;

  self.stats["upgradePoints"]++;
  level.upgrade_chal_points_trackers[var_0] = level.upgrade_chal_points_trackers[var_0] + 1;
  var_1 = tablelookupbyrow("sp\upgrade_challenges.csv", var_0, 6);
  setomnvar(var_1, level.upgrade_chal_points_trackers[var_0]);
}

commit_exo_awards_upgrade_points_custom(var_0) {
  if(isdefined(level.player)) {
    var_1 = level.player;
    var_2 = int(var_1 getlocalplayerprofiledata("sp_upgradePoints"));
    var_3 = var_2 + var_0;

    if(var_3 > var_2)
      var_1 setlocalplayerprofiledata("sp_upgradePoints", var_3);
  }
}

commit_exo_awards_stage_and_progress(var_0, var_1) {
  if(isdefined(level.player)) {
    var_2 = level.player;
    var_3 = level.upgrade_chal_index[level.upgrade_chal_stat_map[var_0]];
    var_4 = 0;

    if(isdefined(var_2.stats["upgradeChallengeStage"][var_0])) {
      var_4 = var_2.stats["upgradeChallengeStage"][var_0];
      var_5 = int(var_2 getlocalplayerprofiledata("sp_upgradeChallengeStage_" + var_3));

      if(var_4 > var_5)
        var_2 setlocalplayerprofiledata("sp_upgradeChallengeStage_" + var_3, var_4);
    }

    var_6 = 0;

    if(isdefined(var_2.stats["upgradeChallengeProgress"][var_0])) {
      var_6 = var_2.stats["upgradeChallengeProgress"][var_0];
      var_7 = int(var_2 getlocalplayerprofiledata("sp_upgradeChallengeProgress_" + var_3));

      if(var_6 != var_7)
        var_2 setlocalplayerprofiledata("sp_upgradeChallengeProgress_" + var_3, var_6);
    }

    if(var_1)
      updategamerprofileall();
  }
}

commit_exo_awards_upon_mission_success() {
  if(isdefined(level.player)) {
    var_0 = level.player;
    commit_exo_awards_upgrade_points_custom(var_0.stats["upgradePoints"]);

    if(isdefined(level.upgrade_chal_stat_map)) {
      foreach(var_4, var_2 in level.upgrade_chal_stat_map) {
        if(var_4 == "intel") {
          continue;
        }
        var_3 = var_4;

        if(!isdefined(level.upgrade_chal_index[level.upgrade_chal_stat_map[var_3]])) {
          continue;
        }
        if(!isdefined(level.upgrade_chal_stat_map[var_3])) {
          continue;
        }
        commit_exo_awards_stage_and_progress(var_3, 0);
      }
    }

    updategamerprofileall();
  }
}