/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\rank.gsc
***********************************************/

function init() {
  level.scoreinfo = [];
  var_0 = getdvarint("LKKNORQKTP");
  level.vip_death_player_hits_million = getdvarint("scr_kill_bracket_scaling_disable", 1);

  if(level.vip_death_player_hits_million != 1) {
    level.vip_failquest = getdvarint("scr_kill_bracket_start", 25);
    level.vip_completequest = getdvarint("scr_kill_bracket_range", 10);
    level.vip_bink_vo = getdvarint("scr_kill_bracket_percent", 10) / 100;
    level.vindia_assault3_check_size = getdvarint("scr_kill_bracket_count", 5);
  }

  if(var_0 > 4 || var_0 < 0) {
    exitlevel(0);
  }

  addglobalrankxpmultiplier(var_0, "online_mp_xpscale");
  var_1 = getdvarint("LTKKKPSRSK");

  if(var_1 > 4 || var_1 < 0) {
    exitlevel(0);
  }

  battle_tracks_playerinlisteningzoneinternal(var_1, "online_battle_xpscale_dvar");
  var_2 = getdvarint("LKMTLQRRSO", 1);

  if(var_2 > 4 || var_2 < 0) {
    exitlevel(0);
  }

  battle_tracks_playerselectrandomtracks(var_2, "online_operator_xpscale");
  var_3 = getdvarint("LRRNQTQTTM", 1);

  if(var_3 > 4 || var_3 < 0) {
    exitlevel(0);
  }

  battle_tracks_playerinsidezone(var_3, "online_clan_xpscale");
  level.ranktable = [];
  level.weaponranktable = [];
  var_4 = function_0428();
  level.maxrank = int(tablelookup(var_4, 0, "maxrank", 1));
  level.ref_11b5c = int(tablelookup(var_4, 0, "maxelder", 1));

  for(var_5 = 0; var_5 <= level.maxrank; var_5++) {
    level.ranktable[var_5][0] = int(tablelookup(var_4, 0, var_5, 2));
    level.ranktable[var_5][1] = int(tablelookup(var_4, 0, var_5, 3));
    level.ranktable[var_5][2] = int(tablelookup(var_4, 0, var_5, 7));
    level.ranktable[var_5][3] = tablelookup(var_4, 0, var_5, 15);
  }

  scripts\mp\weaponrank::init();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  level.prestigeextras = [];
  thread onplayerconnect();
}

function isregisteredevent(var_0) {
  if(isDefined(level.scoreinfo[var_0])) {
    return 1;
  }

  return 0;
}

function registerscoreinfo(var_0, var_1, var_2) {
  level.scoreinfo[var_0][var_1] = var_2;

  if(var_0 == "kill" && var_1 == "value") {
    setomnvar("ui_game_type_kill_value", int(var_2));
    return;
  }
}

function ref_12189(var_0, var_1) {
  var_2 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_score_" + var_0, var_1);
  level.scoreinfo[var_0]["value"] = var_2;
}

function getscoreinfovalue(var_0) {
  var_1 = "scr_" + scripts\mp\utility\game::getgametype() + "_score_" + var_0;

  if(getDvar(var_1) != "") {
    return getdvarint(var_1);
  }

  return level.scoreinfo[var_0]["value"];
}

function getscoreinfocategory(var_0, var_1) {
  if(istrue(level.removekilleventsplash) && !isDefined(level.scoreinfo[var_0])) {
    return;
  }

  switch (var_1) {
    case "value":
      var_2 = "scr_" + scripts\mp\utility\game::getgametype() + "_score_" + var_0;

      if(getDvar(var_2) != "") {
        return getdvarint(var_2);
      } else {
        return level.scoreinfo[var_0]["value"];
      }
    default:
      return level.scoreinfo[var_0][var_1];
  }
}

function getrankinfominxp(var_0) {
  return level.ranktable[var_0][0];
}

function getrankinfoxpamt(var_0) {
  return level.ranktable[var_0][1];
}

function getrankinfomaxxp(var_0) {
  return level.ranktable[var_0][2];
}

function initcpammoarmorcrate(var_0) {
  var_1 = spawnStruct();
  var_2 = level.loadoutsgroup;
  var_1.ref_12507 = var_0 getplayerdata(var_2, "squadMembers", "player_xp");
  var_1.ref_1454f = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_ar_mike4");
  var_1.ref_14548 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_ar_akilo47");
  var_1.ref_14549 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_ar_asierra12");
  var_1.ref_1454b = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_ar_falpha");
  var_1.ref_1454e = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_ar_mcharlie");
  var_1.ref_1454c = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_ar_golf36");
  var_1.ref_1454d = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_ar_kilo433");
  var_1.ref_1454a = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_ar_falima");
  var_1.ref_14550 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_ar_scharlie");
  var_1.ref_1456e = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sm_mpapa5");
  var_1.ref_1456c = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sm_beta");
  var_1.ref_1456b = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sm_augolf");
  var_1.ref_14570 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sm_papa90");
  var_1.ref_1456f = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sm_mpapa7");
  var_1.ref_14572 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sm_uzulu");
  var_1.ref_14573 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sm_victor");
  var_1.ref_14567 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sh_dpapa12");
  var_1.ref_14566 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sh_charlie725");
  var_1.ref_14569 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sh_oscar12");
  var_1.ref_1456a = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sh_romeo870");
  var_1.ref_1455a = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_lm_kilo121");
  var_1.ref_1455f = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_lm_pkilo");
  var_1.ref_1455b = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_lm_lima86");
  var_1.ref_1455c = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_lm_mgolf34");
  var_1.ref_1457b = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sn_mike14");
  var_1.ref_1457a = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sn_kilo98");
  var_1.ref_1457c = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sn_sbeta");
  var_1.ref_14574 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sn_alpha50");
  var_1.ref_14575 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sn_awhiskey");
  var_1.ref_14577 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sn_delta");
  var_1.ref_14579 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sn_hdromeo");
  var_1.ref_14576 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sn_crossbow");
  var_1.ref_14565 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_pi_papa320");
  var_1.ref_14561 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_pi_cpapa");
  var_1.ref_14564 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_pi_mike1911");
  var_1.ref_14563 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_pi_golf21");
  var_1.ref_14562 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_pi_decho");
  var_1.ref_14559 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_la_rpapa7");
  var_1.ref_14555 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_la_gromeo");
  var_1.ref_14558 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_la_mike32");
  var_1.ref_14556 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_la_juliet");
  var_1.ref_14557 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_la_kgolf");
  var_1.ref_14554 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_knife");
  var_1.ref_14560 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_me_riotshield");
  var_1.ref_14553 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_fists");
  var_1.ref_1456d = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sm_charlie9");
  var_1.ref_14552 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_ar_tango21");
  var_1.ref_1455d = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_lm_mgolf36");
  var_1.ref_14551 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_ar_sierra552");
  var_1.ref_1455e = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_lm_mkilo3");
  var_1.ref_14578 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sn_golf28");
  var_1.ref_14571 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sm_smgolf45");
  var_1.ref_14568 = var_0 getplayerdata(var_2, "squadMembers", "weapon_xp", "iw8_sh_mike26");
  return var_1;
}

function initcrossbowusage(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;

  if(var_3 != 0) {
    var_2.xp += var_3;
    var_2.count++;
    return;
  }
}

function initcprooftopcrate(var_0, var_1) {
  var_2 = var_1.ref_12507 - var_0.ref_12507;
  var_3 = spawnStruct();
  var_3.xp = 0;
  var_3.count = 0;
  initcrossbowusage(var_0.ref_1454f, var_1.ref_1454f, var_3);
  initcrossbowusage(var_0.ref_14548, var_1.ref_14548, var_3);
  initcrossbowusage(var_0.ref_14549, var_1.ref_14549, var_3);
  initcrossbowusage(var_0.ref_1454b, var_1.ref_1454b, var_3);
  initcrossbowusage(var_0.ref_1454e, var_1.ref_1454e, var_3);
  initcrossbowusage(var_0.ref_1454c, var_1.ref_1454c, var_3);
  initcrossbowusage(var_0.ref_1454d, var_1.ref_1454d, var_3);
  initcrossbowusage(var_0.ref_1454a, var_1.ref_1454a, var_3);
  initcrossbowusage(var_0.ref_14550, var_1.ref_14550, var_3);
  initcrossbowusage(var_0.ref_1456e, var_1.ref_1456e, var_3);
  initcrossbowusage(var_0.ref_1456c, var_1.ref_1456c, var_3);
  initcrossbowusage(var_0.ref_1456b, var_1.ref_1456b, var_3);
  initcrossbowusage(var_0.ref_14570, var_1.ref_14570, var_3);
  initcrossbowusage(var_0.ref_1456f, var_1.ref_1456f, var_3);
  initcrossbowusage(var_0.ref_14572, var_1.ref_14572, var_3);
  initcrossbowusage(var_0.ref_14573, var_1.ref_14573, var_3);
  initcrossbowusage(var_0.ref_14567, var_1.ref_14567, var_3);
  initcrossbowusage(var_0.ref_14566, var_1.ref_14566, var_3);
  initcrossbowusage(var_0.ref_14569, var_1.ref_14569, var_3);
  initcrossbowusage(var_0.ref_1456a, var_1.ref_1456a, var_3);
  initcrossbowusage(var_0.ref_1455a, var_1.ref_1455a, var_3);
  initcrossbowusage(var_0.ref_1455f, var_1.ref_1455f, var_3);
  initcrossbowusage(var_0.ref_1455b, var_1.ref_1455b, var_3);
  initcrossbowusage(var_0.ref_1455c, var_1.ref_1455c, var_3);
  initcrossbowusage(var_0.ref_1457b, var_1.ref_1457b, var_3);
  initcrossbowusage(var_0.ref_1457a, var_1.ref_1457a, var_3);
  initcrossbowusage(var_0.ref_1457c, var_1.ref_1457c, var_3);
  initcrossbowusage(var_0.ref_14574, var_1.ref_14574, var_3);
  initcrossbowusage(var_0.ref_14575, var_1.ref_14575, var_3);
  initcrossbowusage(var_0.ref_14577, var_1.ref_14577, var_3);
  initcrossbowusage(var_0.ref_14579, var_1.ref_14579, var_3);
  initcrossbowusage(var_0.ref_14576, var_1.ref_14576, var_3);
  initcrossbowusage(var_0.ref_14565, var_1.ref_14565, var_3);
  initcrossbowusage(var_0.ref_14561, var_1.ref_14561, var_3);
  initcrossbowusage(var_0.ref_14564, var_1.ref_14564, var_3);
  initcrossbowusage(var_0.ref_14563, var_1.ref_14563, var_3);
  initcrossbowusage(var_0.ref_14562, var_1.ref_14562, var_3);
  initcrossbowusage(var_0.ref_14559, var_1.ref_14559, var_3);
  initcrossbowusage(var_0.ref_14555, var_1.ref_14555, var_3);
  initcrossbowusage(var_0.ref_14558, var_1.ref_14558, var_3);
  initcrossbowusage(var_0.ref_14556, var_1.ref_14556, var_3);
  initcrossbowusage(var_0.ref_14557, var_1.ref_14557, var_3);
  initcrossbowusage(var_0.ref_14554, var_1.ref_14554, var_3);
  initcrossbowusage(var_0.ref_14560, var_1.ref_14560, var_3);
  initcrossbowusage(var_0.ref_14553, var_1.ref_14553, var_3);
  initcrossbowusage(var_0.ref_1456d, var_1.ref_1456d, var_3);
  initcrossbowusage(var_0.ref_14552, var_1.ref_14552, var_3);
  initcrossbowusage(var_0.ref_1455d, var_1.ref_1455d, var_3);
  initcrossbowusage(var_0.ref_14551, var_1.ref_14551, var_3);
  initcrossbowusage(var_0.ref_1455e, var_1.ref_1455e, var_3);
  initcrossbowusage(var_0.ref_14578, var_1.ref_14578, var_3);
  initcrossbowusage(var_0.ref_14571, var_1.ref_14571, var_3);
  initcrossbowusage(var_0.ref_14568, var_1.ref_14568, var_3);

  if(var_2 != 0 || var_3.xp != 0) {
    self dlog_recordplayerevent("dlog_event_player_stats_hack", ["player_xp_start", var_0.ref_12507, "player_xp_end", var_1.ref_12507, "diff_weapon_xp_count", var_3.count, "diff_weapon_xp", var_3.xp]);
    return;
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {
      var_0.initdismembermentlist = initcpammoarmorcrate(var_0);
    }

    if(!isai(var_0)) {
      if(level.playerxpenabled) {
        var_0.pers["rankxp"] = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "player_xp");
        var_0.pers["battlepassxp"] = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "battlepass_xp");
        var_1 = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");

        if(!isDefined(var_0.pers["xpEarnedThisMatch"])) {
          var_0.pers["xpEarnedThisMatch"] = 0;
        }
      } else {
        var_1 = 0;
        var_0.pers["rankxp"] = 0;
        var_0.pers["battlepassxp"] = 0;
      }
    } else {
      var_1 = 0;
      var_0.pers["rankxp"] = 0;
      var_0.pers["battlepassxp"] = 0;
    }

    var_0.pers["weaponxp"] = [];

    if(var_0.pers["rankxp"] < 0) {
      var_0.pers["rankxp"] = 0;
    }

    if(var_0.pers["battlepassxp"] < 0) {
      var_0.pers["battlepassxp"] = 0;
    }

    var_2 = getrankxp(var_0);
    var_3 = getrankforxp(var_0, var_2);
    var_4 = rodwatcher(var_0, var_2);
    var_0.pers["rank"] = var_3;
    var_0.pers["prestige"] = var_1;
    var_0 setrank(var_3 + var_4, var_1);
    var_0.pers["participation"] = 0;
    var_0.scoreupdatetotal = 0;
    var_0.scorepointsqueue = 0;
    var_0.scoreeventqueue = [];
    var_0.postgamepromotion = 0;
    var_0 setclientdvar("ui_promotion", 0);

    if(!isDefined(var_0.pers["summary"])) {
      var_0.pers["summary"] = [];
      var_0.pers["summary"]["xp"] = 0;
      var_0.pers["summary"]["score"] = 0;
      var_0.pers["summary"]["challenge"] = 0;
      var_0.pers["summary"]["match"] = 0;
      var_0.pers["summary"]["misc"] = 0;
      var_0.pers["summary"]["medal"] = 0;
      var_0.pers["summary"]["bonusXP"] = 0;
    }

    var_0 setclientdvar("MQNNLTKNTS", 0);

    if(level.playerxpenabled) {
      var_5 = getdvarint("NTLKOKLKRS");
      var_6 = var_0 getprivatepartysize() > 1;

      if(var_6) {
        addrankxpmultiplier(var_0, var_5, "online_mp_party_xpscale");

        if(function_043e(var_0)) {
          addrankxpmultiplier(var_0, 1.1, "online_clan_perk_xpscale");
        }
      }

      if(var_0 getplayerdata("mp", "prestigeDoubleWeaponXp")) {
        var_0.prestigedoubleweaponxp = 1;
      } else {
        var_0.prestigedoubleweaponxp = 0;
      }
    }

    var_0.scoreeventcount = 0;
    var_0.scoreeventlistindex = 0;
    var_0 setclientomnvar("ui_score_event_control", -1);
    var_0 setclientomnvar("ui_potg_score_event_control", -1);
  }
}

function onplayerspawned() {
  if(isai(self)) {
    self.pers["rankxp"] = scripts\mp\bots\bots_util::get_rank_xp_for_bot();
  } else if(!level.playerxpenabled) {
    self.pers["rankxp"] = 0;
  }

  playerupdaterank();
}

function playerupdaterank() {
  var_0 = self.pers["rankxp"];

  if(var_0 < 0) {
    var_0 = 0;
    self.pers["rankxp"] = 0;
  }

  var_1 = getrankforxp(var_0);
  self.pers["rank"] = var_1;

  if(isai(self) || !isDefined(self.pers["prestige"])) {
    if(level.playerxpenabled && isDefined(self.bufferedstats)) {
      var_2 = getprestigelevel();
    } else {
      var_2 = 0;
    }

    self setrank(var_2, var_2);
    self.pers["prestige"] = var_2;
    return;
  }
}

function tryresetrankxp() {
  if(issubstr(self.class, "custom")) {
    if(!level.playerxpenabled) {
      self.pers["rankxp"] = 0;
      return;
    }

    if(isai(self)) {
      self.pers["rankxp"] = 0;
      return;
    }

    return;
  }
}

function giverankxp(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");

  if(isDefined(self.owner) && !isbot(self)) {
    giverankxp(self.owner, var_0, var_1, var_2);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }

  var_5 = botnodeavailabletoteam(self);
  var_1 = int(var_1 * var_5);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!level.playerxpenabled) {
    if(var_3 == 0) {
      scripts\mp\utility\points::displayscoreeventpoints(var_1, var_0);
    }

    return;
  }

  if(!isDefined(var_1) || var_1 == 0) {
    return;
  }

  var_6 = getscoreinfocategory(var_0, "group");

  if((!isDefined(level.forceranking) || !level.forceranking) && !scripts\mp\menus::brking_updateteamscore()) {
    jumpiffalse(level.teambased) LOC_00000105;
    var_7 = 0;

    foreach(var_9 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var_9, "teamCount")) {
        var_7++;

        if(var_7 >= 2) {
          break;
        }
      }
    }

    if(var_7 < 2) {
      return;
    }

    goto LOC_00000152;
  }

  var_2 = calculate_teleport_data_for_player(var_2);
  var_14 = getscoreinfocategory(var_1, "allowBonus");
  var_15 = 1;
  var_16 = var_2;
  var_17 = 0;

  if(istrue(var_14)) {
    var_15 = getrankxpmultipliertotal();
    var_16 = int(var_2 * var_15);
    var_17 = int(max(var_16 - var_2, 0));
    var_18 = round_spawn_bombers(var_1, var_3);
    var_16 += int(var_18);
    var_17 += int(var_18);
  }

  if(!var_4) {
    scripts\mp\utility\points::displayscoreeventpoints(var_16, var_1);
  }

  thread waitandapplyxp(var_1, var_2, var_16, var_17, var_3, var_5);
}

function calculate_teleport_data_for_player(var_0) {
  var_1 = var_0;

  if(level.vip_death_player_hits_million != 1) {
    if(self.kills > level.vip_failquest) {
      var_2 = min(int(1 + (self.kills - level.vip_failquest) / level.vip_completequest), level.vindia_assault3_check_size);
      var_3 = 1 - level.vip_bink_vo * var_2;
      var_1 = int(var_0 * var_3);
    }
  }

  return var_1;
}

function waitandapplyxp(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("disconnect");

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!var_5) {
    waitframe();
    scripts\mp\utility\script::waittillslowprocessallowed();
  }

  var_6 = getrankxp();

  if(updaterank(var_6)) {}

  syncxpstat();
  var_7 = 0;

  if(isDefined(var_4)) {
    if(isDefined(var_4.ref_121d9)) {
      var_4 = var_4.ref_121d9;
    }

    if(scripts\mp\weaponrank::weaponshouldgetxp(var_4.basename)) {
      var_7 = var_1;
      var_7 *= scripts\mp\weaponrank::getweaponrankxpmultipliertotal();
      var_7 = int(var_7);
    }
  }

  incrankxp(var_2, var_4, var_7, var_0);

  if(level.playerxpenabled && !isai(self)) {
    if(isDefined(var_4) && (scripts\mp\utility\weapon::iscacprimaryweapon(var_4) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_4))) {
      if(!scripts\mp\utility\weapon::ispickedupweapon(var_4) || scripts\mp\utility\game::getgametype() == "br") {
        scripts\common\utility::ref_13e0a(level.ref_11b31, scripts\mp\utility\weapon::getweaponrootname(var_4), "xp_earned", var_7, -1, var_4);
      }
    }
  }

  recordxpgains(var_0, var_1, var_3);
  var_8 = getprestigelevel();
  var_9 = getrank();
}

function recordxpgains(var_0, var_1, var_2) {
  var_3 = var_1 + var_2;
  var_4 = getscoreinfocategory(var_0, "group");

  if(!isDefined(var_4) || var_4 == "") {
    self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + var_1;
    self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
    self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
    return;
  }

  switch (var_4) {
    case "match_bonus":
      self.pers["summary"]["match"] = self.pers["summary"]["match"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;
    case "challenge":
      self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;
    case "medal":
      if(!isDefined(self.pers["combatXP"])) {
        self.pers["combatXP"] = var_1;
      } else {
        self.pers["combatXP"] = self.pers["combatXP"] + var_1;
      }

      self.pers["summary"]["medal"] = self.pers["summary"]["medal"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;
    case "combat":
      if(!isDefined(self.pers["combatXP"])) {
        self.pers["combatXP"] = var_1;
      } else {
        self.pers["combatXP"] = self.pers["combatXP"] + var_1;
      }

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;
    case "looting":
      if(!isDefined(self.pers["lootingXP"])) {
        self.pers["lootingXP"] = var_1;
      } else {
        self.pers["lootingXP"] = self.pers["lootingXP"] + var_1;
      }

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;
    case "missions":
      if(!isDefined(self.pers["missionXP"])) {
        self.pers["missionXP"] = var_1;
      } else {
        self.pers["missionXP"] = self.pers["missionXP"] + var_1;
      }

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;
    default:
      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;
  }
}

function updaterank(var_0) {
  var_1 = getrank();
  var_2 = getprestigelevel();
  var_3 = self.pers["rank"] + self.pers["prestige"];
  var_4 = var_1 + var_2;
  self.pers["rank"] = var_1;
  self.pers["prestige"] = var_2;

  if(var_4 == var_3 || var_4 >= level.maxrank + level.ref_11b5c) {
    return false;
  }

  self setrank(var_1, var_2);
  return true;
}

function updaterankannouncehud() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  var_0 = self.pers["team"];

  if(!isDefined(var_0)) {
    return;
  }

  if(!scripts\mp\flags::levelflag("game_over")) {
    level scripts\engine\utility::waittill_notify_or_timeout("game_over", 0.25);
  }

  var_1 = self.pers["rank"] + self.pers["prestige"];

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];
    var_4 = var_3.pers["team"];

    if(isDefined(var_4) && var_4 == var_0) {
      var_3 iprintln(&"RANK/PLAYER_WAS_PROMOTED", self, var_1 + 1);
    }
  }
}

function queuescorepointspopup(var_0) {
  self.scorepointsqueue += var_0;
}

function flushscorepointspopupqueue() {
  scorepointspopup(self.scorepointsqueue);
  self.scorepointsqueue = 0;
}

function flushscorepointspopupqueueonspawn() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self notify("flushScorePointsPopupQueueOnspawn()");
  self endon("flushScorePointsPopupQueueOnspawn()");
  self waittill("spawned_player");
  wait 0.1;
  flushscorepointspopupqueue();
}

function scorepointspopup(var_0, var_1) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(var_0 == 0) {
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(self) && !self ismlgspectator() && !scripts\mp\utility\player::isusingremote()) {
    if(!istrue(var_1) || scripts\mp\utility\player::isinkillcam()) {
      queuescorepointspopup(var_0);
      thread flushscorepointspopupqueueonspawn();
      return;
    }
  }

  self notify("scorePointsPopup");
  self endon("scorePointsPopup");
  self.scoreupdatetotal += var_0;
  self setclientomnvar("ui_points_popup", self.scoreupdatetotal);
  self setclientomnvar("ui_points_popup_notify", gettime());
  wait 1;
  self.scoreupdatetotal = 0;
}

function notifyplayerscore() {
  waitframe();
  level notify("update_player_score", self, self.scoreupdatetotal);
}

function queuescoreeventpopup(var_0) {
  self.scoreeventqueue[self.scoreeventqueue.size] = var_0;
}

function flushscoreeventpopupqueue() {
  var_0 = self.scoreeventqueue;
  self.scoreeventqueue = [];

  foreach(var_2 in var_0) {
    scoreeventpopup(var_2);
  }
}

function flushscoreeventpopupqueueonspawn() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self notify("flushScoreEventPopupQueueOnspawn()");
  self endon("flushScoreEventPopupQueueOnspawn()");
  self waittill("spawned_player");
  wait 0.1;
  flushscoreeventpopupqueue();
}

function getscoreeventpriority(var_0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return 0;
  }

  var_1 = getscoreinfocategory(var_0, "priority");

  if(!istrue(var_1)) {
    return 0;
  }

  return var_1;
}

function scoreeventalwaysshowassplash(var_0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return false;
  }

  var_1 = getscoreinfocategory(var_0, "alwaysShowSplash");

  if(!istrue(var_1)) {
    return false;
  }

  return true;
}

function scoreeventhastext(var_0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return false;
  }

  var_1 = getscoreinfocategory(var_0, "eventID");
  var_2 = getscoreinfocategory(var_0, "text");

  if(!isDefined(var_1) || var_1 < 0 || !isDefined(var_2) || var_2 == "") {
    return false;
  }

  return true;
}

function scoreeventpopup(var_0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return;
  }

  if(isDefined(self.owner)) {
    scoreeventpopup(self.owner, var_0);
  }

  if(!isPlayer(self)) {
    return;
  }

  var_1 = getscoreinfocategory(var_0, "eventID");
  var_2 = getscoreinfocategory(var_0, "text");

  if(!isDefined(var_1) || var_1 < 0 || !isDefined(var_2) || var_2 == "") {
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(self) && !self ismlgspectator() && !scripts\mp\utility\player::isusingremote()) {
    queuescoreeventpopup(var_0);
    thread flushscoreeventpopupqueueonspawn();
    return;
  }

  if(!isDefined(self.scoreeventlistsize)) {
    self.scoreeventlistsize = 1;
    thread clearscoreeventlistafterwait();
  } else {
    self.scoreeventlistsize++;

    if(self.scoreeventlistsize > 5) {
      self.scoreeventlistsize = 5;
      return;
    }
  }

  self setclientomnvar("ui_potg_score_event_list_" + self.scoreeventlistindex, var_1);
  self setclientomnvar("ui_score_event_list_" + self.scoreeventlistindex, var_1);
  self setclientomnvar("ui_score_event_control", self.scoreeventcount % 10);
  self setclientomnvar("ui_potg_score_event_control", self.scoreeventcount % 10);
  self.scoreeventlistindex++;
  self.scoreeventlistindex %= 5;
  self.scoreeventcount++;
}

function clearscoreeventlistafterwait() {
  self endon("disconnect");
  self notify("clearScoreEventListAfterWait()");
  self endon("clearScoreEventListAfterWait()");
  scripts\engine\utility::waittill_notify_or_timeout("death", 0.5);
  self.scoreeventlistsize = undefined;
}

function getrank() {
  var_0 = self.pers["rankxp"];
  var_1 = self.pers["rank"];

  if(var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1)) {
    return var_1;
  }

  return getrankforxp(var_0);
}

function rodwatcher(var_0) {
  var_1 = getrankinfomaxxp(level.maxrank);

  if(var_0 >= var_1) {
    var_2 = var_0 - var_1;
    var_3 = int(var_2 / getdvarint("ONRNRMQSO") + 1);
    return var_3;
  }

  return 0;
}

function getrankforxp(var_0) {
  var_1 = level.maxrank;

  if(var_0 >= getrankinfominxp(var_1)) {
    return var_1;
  } else {
    var_1--;
  }

  while(var_1 > 0) {
    if(var_0 >= getrankinfominxp(var_1) && var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1)) {
      return var_1;
    }

    var_1--;
  }

  return var_1;
}

function getmatchbonusspm() {
  var_0 = getrank() + 1;
  return (3 + var_0 * 0.5) * 10;
}

function getprestigelevel() {
  if(isai(self) && isDefined(self.pers["prestige_fake"])) {
    return self.pers["prestige_fake"];
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");
}

function getrankxp() {
  return self.pers["rankxp"];
}

function registerpickupcreatedcallback() {
  return self.pers["battlepassxp"];
}

function safedivide(var_0) {
  if(isDefined(self.pers["weaponxp"][var_0])) {
    return self.pers["weaponxp"][var_0];
  }

  if(isenumvaluevalid(level.loadoutsgroup, "LoadoutWeapon", var_0)) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "weapon_xp", var_0);
  }

  return 0;
}

function incrankxp(var_0, var_1, var_2, var_3) {
  if(!level.playerxpenabled) {
    return;
  }

  if(isai(self)) {
    return;
  }

  if(!isDefined(level.ref_11b53)) {
    level.ref_11b53 = getdvarint("scr_beta_max_level", 0);
  }

  if(level.ref_11b53 > 0 && getrank() + 1 >= level.ref_11b53) {
    var_0 = 0;
  }

  var_4 = getrankxp();
  var_5 = int(min(var_4 + var_0, getrankinfomaxxp(level.maxrank) - 1));

  if(self.pers["rank"] == level.maxrank && var_5 >= getrankinfomaxxp(level.maxrank)) {
    var_5 = getrankinfomaxxp(level.maxrank);
  }

  self.pers["xpEarnedThisMatch"] = self.pers["xpEarnedThisMatch"] + var_0;
  self.pers["rankxp"] = var_5;
  var_6 = registerpublicevent();
  var_7 = var_0 * var_6;
  var_8 = registerpickupcreatedcallback();
  self.pers["battlepassxp"] = var_8 + var_7;
  var_9 = "";

  if(isDefined(var_1)) {
    var_9 = scripts\mp\utility\weapon::relic_nuketimer_globalthread(var_1.basename);
    var_10 = scripts\mp\utility\weapon::getweaponrootname(var_9);
    var_11 = safedivide(var_10);
    self.pers["weaponxp"][var_10] = var_11 + var_2;
  }

  var_12 = residuallight();
  var_13 = var_0 * var_12;
  var_14 = relic_award_bullets();
  var_15 = var_0 * var_14;
  var_16 = 1;
  var_17 = 1;
  var_18 = 1;
  var_19 = 1;
  var_20 = 1;

  if(isDefined(level.rankxpmultipliers) && isDefined(level.rankxpmultipliers["online_mp_xpscale"]) && level.rankxpmultipliers["online_mp_xpscale"] >= 2) {
    var_16 = 2;
  }

  if(isDefined(level.weaponrankxpmultipliers) && isDefined(level.weaponrankxpmultipliers["online_mp_weapon_xpscale"]) && level.weaponrankxpmultipliers["online_mp_weapon_xpscale"] >= 2) {
    var_17 = 2;
  }

  if(isDefined(level.ref_12133) && isDefined(level.ref_12133["online_operator_xpscale"]) && level.ref_12133["online_operator_xpscale"] >= 2) {
    var_19 = 2;
  }

  if(isDefined(level.cleanupfunc) && isDefined(level.cleanupfunc["online_battle_xpscale_dvar"]) && level.cleanupfunc["online_battle_xpscale_dvar"] >= 2) {
    var_18 = 2;
  }

  if(isDefined(level.halfheight) && isDefined(level.halfheight["online_clan_xpscale"]) && level.halfheight["online_clan_xpscale"] >= 2) {
    var_20 = 2;
  }

  var_21 = int(scripts\cp_mp\utility\game_utility::gettimesincegamestart() / 1000);
  self reportchallengeuserevent("mp_addxp", var_0, scripts\mp\teams::lookupcurrentoperator(self.team), var_9, var_2, var_7, int(var_16 * 100), int(var_17 * 100), int(var_18 * 100), var_21, var_13, int(var_19 * 100), var_15, int(var_20 * 100));
  scripts\mp\analyticslog::ref_119bf(self, var_0, var_9, var_2, var_3);
}

function syncxpstat() {
  var_0 = getrankxp();
  var_1 = self getplayerdata("common", "mpProgression", "playerLevel", "xp");

  if(var_1 > var_0) {
    return;
  }

  self setplayerdata("common", "mpProgression", "playerLevel", "xp", var_0);
}

function delayplayerscorepopup(var_0, var_1, var_2) {
  wait var_0;
  thread scripts\mp\utility\points::giveunifiedpoints(var_1);
}

function getgametypexpmultiplier() {
  if(!isDefined(level.gametypexpmodifier)) {
    var_0 = getdvarfloat("scr_match_bonus_mode_override", 1);

    if(var_0 != 1) {
      level.gametypexpmodifier = var_0;
    } else {
      level.gametypexpmodifier = float(tablelookup("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 17));
    }
  }

  return level.gametypexpmodifier;
}

function addglobalrankxpmultiplier(var_0, var_1) {
  addrankxpmultiplier(level, var_0, var_1);
}

function getglobalrankxpmultiplier() {
  var_0 = getrankxpmultiplier(level);
  var_1 = getdvarint("scr_disable_xp_scale_quit", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1) {
    exitlevel(0);
  }

  return var_0;
}

function addrankxpmultiplier(var_0, var_1) {
  var_2 = 4 / getrankxpmultiplier(level);

  if(var_0 > var_2) {
    return;
  }

  if(!isDefined(self.rankxpmultipliers)) {
    self.rankxpmultipliers = [];
  }

  if(isDefined(self.rankxpmultipliers[var_1])) {
    self.rankxpmultipliers[var_1] = max(self.rankxpmultipliers[var_1], var_0);
    return;
  }

  self.rankxpmultipliers[var_1] = var_0;
}

function getrankxpmultiplier() {
  if(!isDefined(self.rankxpmultipliers)) {
    return 1;
  }

  var_0 = 1;

  foreach(var_2 in self.rankxpmultipliers) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_0 *= var_2;
  }

  return var_0;
}

function respawntagsfreed() {
  if(self resetclientkillstreakindexes()) {
    return getbnetigrweaponxpmultiplier();
  } else if(self isps4player()) {
    var_0 = getdvarfloat("MPPRMTPSLT", 1);
    return var_0;
  }

  return 1;
}

function removeglobalrankxpmultiplier(var_0) {
  removerankxpmultiplier(level, var_0);
}

function removerankxpmultiplier(var_0) {
  if(!isDefined(self.rankxpmultipliers)) {
    return;
  }

  if(!isDefined(self.rankxpmultipliers[var_0])) {
    return;
  }

  self.rankxpmultipliers[var_0] = undefined;
}

function addteamrankxpmultiplier(var_0, var_1, var_2) {
  if(!level.teambased) {
    var_1 = "all";
  }

  if(!isDefined(self.teamrankxpmultipliers)) {
    level.teamrankxpmultipliers = [];
  }

  if(!isDefined(level.teamrankxpmultipliers[var_1])) {
    level.teamrankxpmultipliers[var_1] = [];
  }

  if(isDefined(level.teamrankxpmultipliers[var_1][var_2])) {
    level.teamrankxpmultipliers[var_1][var_2] = max(self.teamrankxpmultipliers[var_1][var_2], var_0);
    return;
  }

  level.teamrankxpmultipliers[var_1][var_2] = var_0;
}

function removeteamrankxpmultiplier(var_0, var_1) {
  if(!level.teambased) {
    var_0 = "all";
  }

  if(!isDefined(level.teamrankxpmultipliers)) {
    return;
  }

  if(!isDefined(level.teamrankxpmultipliers[var_0])) {
    return;
  }

  if(!isDefined(level.teamrankxpmultipliers[var_0][var_1])) {
    return;
  }

  level.teamrankxpmultipliers[var_0][var_1] = undefined;
}

function getteamrankxpmultiplier(var_0) {
  if(!level.teambased) {
    var_0 = "all";
  }

  if(!isDefined(var_0) || !isDefined(level.teamrankxpmultipliers) || !isDefined(level.teamrankxpmultipliers[var_0])) {
    return 1;
  }

  var_1 = 1;

  foreach(var_3 in level.teamrankxpmultipliers[var_0]) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_1 *= var_3;
  }

  return var_1;
}

function risktokensbanked() {
  if(!isDefined(level.ref_12751)) {
    level.ref_12751 = getdvarfloat("scr_playlist_xp_scalar", 1);
  }

  return level.ref_12751;
}

function getrankxpmultipliertotal() {
  var_0 = getrankxpmultiplier();
  var_1 = getglobalrankxpmultiplier();
  var_2 = getteamrankxpmultiplier(self.team);
  var_3 = respawntagsfreed();
  var_4 = risktokensbanked();
  var_5 = scripts\engine\utility::ter_op(function_043e(self), 1.1, 1);
  var_6 = var_0 * var_1 * var_2 * var_3 * var_4 * var_5;
  return var_6;
}

function round_spawn_bombers(var_0, var_1) {
  var_2 = 0;
  var_2 += calculate_path_struct(var_0, var_1);
  return var_2;
}

function calculate_path_struct(var_0, var_1) {
  var_2 = 0;

  if(var_0 == "kill") {
    var_3 = isDefined(var_1) && var_1 hasattachment("gunperk_xp", 1) || scripts\mp\utility\perk::_hasperk("specialty_gunperk_xp");

    if(var_3) {
      var_2 += 20;
    }
  }

  return var_2;
}

function battle_tracks_playerinlisteningzoneinternal(var_0, var_1) {
  battle_tracks_gettogglestate(level, var_0, var_1);
}

function remindermessage() {
  var_0 = registerpreviousprop(level);
  var_1 = getdvarint("scr_disable_xp_scale_quit", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1) {
    exitlevel(0);
  }

  return var_0;
}

function battle_tracks_gettogglestate(var_0, var_1) {
  var_2 = 4 / registerpreviousprop(level);

  if(var_0 > var_2) {
    return;
  }

  if(!isDefined(self.cleanupfunc)) {
    self.cleanupfunc = [];
  }

  if(isDefined(self.cleanupfunc[var_1])) {
    self.cleanupfunc[var_1] = max(self.cleanupfunc[var_1], var_0);
    return;
  }

  self.cleanupfunc[var_1] = var_0;
}

function registerpreviousprop() {
  if(!isDefined(self.cleanupfunc)) {
    return 1;
  }

  var_0 = 1;

  foreach(var_2 in self.cleanupfunc) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_0 *= var_2;
  }

  return var_0;
}

function registerpublicevent() {
  var_0 = registerpreviousprop();
  var_1 = remindermessage();
  var_2 = radiusdamagestepped(self);
  var_3 = var_0 * var_1 * var_2;
  return var_3;
}

function battle_tracks_playerselectrandomtracks(var_0, var_1) {
  battle_tracks_togglestateis(level, var_0, var_1);
}

function remove_bank_lbravos() {
  var_0 = resetvisionsetnighttodefault(level);
  var_1 = getdvarint("scr_disable_xp_scale_quit", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1) {
    exitlevel(0);
  }

  return var_0;
}

function battle_tracks_togglestateis(var_0, var_1) {
  var_2 = 4 / resetvisionsetnighttodefault(level);

  if(var_0 > var_2) {
    return;
  }

  if(!isDefined(self.ref_12133)) {
    self.ref_12133 = [];
  }

  if(isDefined(self.ref_12133[var_1])) {
    self.ref_12133[var_1] = max(self.ref_12133[var_1], var_0);
    return;
  }

  self.ref_12133[var_1] = var_0;
}

function residuallight() {
  var_0 = resetvisionsetnighttodefault();
  var_1 = remove_bad_loot_drops();
  var_2 = respawntagsfreed();
  var_3 = risktokensbanked();
  var_4 = scripts\engine\utility::ter_op(function_043e(self), 1.1, 1);
  var_5 = var_0 * var_1 * var_2 * var_3 * var_4;
  return var_5;
}

function resetvisionsetnighttodefault() {
  if(!isDefined(self.ref_12133)) {
    return 1;
  }

  var_0 = 1;

  foreach(var_2 in self.ref_12133) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_0 *= var_2;
  }

  return var_0;
}

function remove_bad_loot_drops() {
  return resetvisionsetnighttodefault(level);
}

function battle_tracks_playerinsidezone(var_0, var_1) {
  battle_tracks_hasemptybattletracks(level, var_0, var_1);
}

function remove_assault_class() {
  var_0 = relic_amped_wait_till_revived(level);
  var_1 = getdvarint("scr_disable_xp_scale_quit", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1) {
    exitlevel(0);
  }

  return var_0;
}

function battle_tracks_hasemptybattletracks(var_0, var_1) {
  var_2 = 4 / relic_amped_wait_till_revived(level);

  if(var_0 > var_2) {
    return;
  }

  if(!isDefined(self.halfheight)) {
    self.halfheight = [];
  }

  if(isDefined(self.halfheight[var_1])) {
    self.halfheight[var_1] = max(self.halfheight[var_1], var_0);
    return;
  }

  self.halfheight[var_1] = var_0;
}

function relic_award_bullets() {
  var_0 = relic_amped_wait_till_revived();
  var_1 = remote_tank_think();
  var_2 = respawntagsfreed();
  var_3 = risktokensbanked();
  var_4 = scripts\engine\utility::ter_op(function_043f(self), 1, 0);
  var_5 = scripts\engine\utility::ter_op(function_043e(self), 1.1, 1);
  var_6 = var_0 * var_1 * var_2 * var_3 * var_4 * var_5;
  return var_6;
}

function relic_amped_wait_till_revived() {
  if(!isDefined(self.halfheight)) {
    return 1;
  }

  var_0 = 1;

  foreach(var_2 in self.halfheight) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_0 *= var_2;
  }

  return var_0;
}

function remote_tank_think() {
  return relic_amped_wait_till_revived(level);
}