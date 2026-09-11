/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\rank.gsc
***********************************************/

function init() {
  level.scoreinfo = [];
  var0 = getdvarint("LKKNORQKTP");
  level.vip_death_player_hits_million = getdvarint("scr_kill_bracket_scaling_disable", 1);

  if(level.vip_death_player_hits_million != 1) {
    level.vip_failquest = getdvarint("scr_kill_bracket_start", 25);
    level.vip_completequest = getdvarint("scr_kill_bracket_range", 10);
    level.vip_bink_vo = getdvarint("scr_kill_bracket_percent", 10) / 100;
    level.vindia_assault3_check_size = getdvarint("scr_kill_bracket_count", 5);
  }

  if(var0 > 4 || var0 < 0) {
    exitlevel(0);
  }

  addglobalrankxpmultiplier(var0, "online_mp_xpscale");
  var1 = getdvarint("LTKKKPSRSK");

  if(var1 > 4 || var1 < 0) {
    exitlevel(0);
  }

  battle_tracks_playerinlisteningzoneinternal(var1, "online_battle_xpscale_dvar");
  var2 = getdvarint("LKMTLQRRSO", 1);

  if(var2 > 4 || var2 < 0) {
    exitlevel(0);
  }

  battle_tracks_playerselectrandomtracks(var2, "online_operator_xpscale");
  var3 = getdvarint("LRRNQTQTTM", 1);

  if(var3 > 4 || var3 < 0) {
    exitlevel(0);
  }

  battle_tracks_playerinsidezone(var3, "online_clan_xpscale");
  level.ranktable = [];
  level.weaponranktable = [];
  var4 = function_0428();
  level.maxrank = int(tablelookup(var4, 0, "maxrank", 1));
  level.ref_11b5c = int(tablelookup(var4, 0, "maxelder", 1));

  for(var5 = 0; var5 <= level.maxrank; var5++) {
    level.ranktable[var5][0] = int(tablelookup(var4, 0, var5, 2));
    level.ranktable[var5][1] = int(tablelookup(var4, 0, var5, 3));
    level.ranktable[var5][2] = int(tablelookup(var4, 0, var5, 7));
    level.ranktable[var5][3] = tablelookup(var4, 0, var5, 15);
  }

  scripts\mp\weaponrank::init();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  level.prestigeextras = [];
  thread onplayerconnect();
}

function isregisteredevent(var0) {
  if(isDefined(level.scoreinfo[var0])) {
    return 1;
  }

  return 0;
}

function registerscoreinfo(var0, var1, var2) {
  level.scoreinfo[var0][var1] = var2;

  if(var0 == "kill" && var1 == "value") {
    setomnvar("ui_game_type_kill_value", int(var2));
    return;
  }
}

function ref_12189(var0, var1) {
  var2 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_score_" + var0, var1);
  level.scoreinfo[var0]["value"] = var2;
}

function getscoreinfovalue(var0) {
  var1 = "scr_" + scripts\mp\utility\game::getgametype() + "_score_" + var0;

  if(getDvar(var1) != "") {
    return getdvarint(var1);
  }

  return level.scoreinfo[var0]["value"];
}

function getscoreinfocategory(var0, var1) {
  if(istrue(level.removekilleventsplash) && !isDefined(level.scoreinfo[var0])) {
    return;
  }

  switch (var1) {
    case "value":
      var2 = "scr_" + scripts\mp\utility\game::getgametype() + "_score_" + var0;

      if(getDvar(var2) != "") {
        return getdvarint(var2);
      } else {
        return level.scoreinfo[var0]["value"];
      }
    default:
      return level.scoreinfo[var0][var1];
  }
}

function getrankinfominxp(var0) {
  return level.ranktable[var0][0];
}

function getrankinfoxpamt(var0) {
  return level.ranktable[var0][1];
}

function getrankinfomaxxp(var0) {
  return level.ranktable[var0][2];
}

function initcpammoarmorcrate(var0) {
  var1 = spawnStruct();
  var2 = level.loadoutsgroup;
  var1.ref_12507 = var0 getplayerdata(var2, "squadMembers", "player_xp");
  var1.ref_1454f = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_ar_mike4");
  var1.ref_14548 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_ar_akilo47");
  var1.ref_14549 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_ar_asierra12");
  var1.ref_1454b = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_ar_falpha");
  var1.ref_1454e = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_ar_mcharlie");
  var1.ref_1454c = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_ar_golf36");
  var1.ref_1454d = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_ar_kilo433");
  var1.ref_1454a = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_ar_falima");
  var1.ref_14550 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_ar_scharlie");
  var1.ref_1456e = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sm_mpapa5");
  var1.ref_1456c = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sm_beta");
  var1.ref_1456b = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sm_augolf");
  var1.ref_14570 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sm_papa90");
  var1.ref_1456f = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sm_mpapa7");
  var1.ref_14572 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sm_uzulu");
  var1.ref_14573 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sm_victor");
  var1.ref_14567 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sh_dpapa12");
  var1.ref_14566 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sh_charlie725");
  var1.ref_14569 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sh_oscar12");
  var1.ref_1456a = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sh_romeo870");
  var1.ref_1455a = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_lm_kilo121");
  var1.ref_1455f = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_lm_pkilo");
  var1.ref_1455b = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_lm_lima86");
  var1.ref_1455c = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_lm_mgolf34");
  var1.ref_1457b = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sn_mike14");
  var1.ref_1457a = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sn_kilo98");
  var1.ref_1457c = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sn_sbeta");
  var1.ref_14574 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sn_alpha50");
  var1.ref_14575 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sn_awhiskey");
  var1.ref_14577 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sn_delta");
  var1.ref_14579 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sn_hdromeo");
  var1.ref_14576 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sn_crossbow");
  var1.ref_14565 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_pi_papa320");
  var1.ref_14561 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_pi_cpapa");
  var1.ref_14564 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_pi_mike1911");
  var1.ref_14563 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_pi_golf21");
  var1.ref_14562 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_pi_decho");
  var1.ref_14559 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_la_rpapa7");
  var1.ref_14555 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_la_gromeo");
  var1.ref_14558 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_la_mike32");
  var1.ref_14556 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_la_juliet");
  var1.ref_14557 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_la_kgolf");
  var1.ref_14554 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_knife");
  var1.ref_14560 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_me_riotshield");
  var1.ref_14553 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_fists");
  var1.ref_1456d = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sm_charlie9");
  var1.ref_14552 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_ar_tango21");
  var1.ref_1455d = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_lm_mgolf36");
  var1.ref_14551 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_ar_sierra552");
  var1.ref_1455e = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_lm_mkilo3");
  var1.ref_14578 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sn_golf28");
  var1.ref_14571 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sm_smgolf45");
  var1.ref_14568 = var0 getplayerdata(var2, "squadMembers", "weapon_xp", "iw8_sh_mike26");
  return var1;
}

function initcrossbowusage(var0, var1, var2) {
  var3 = var1 - var0;

  if(var3 != 0) {
    var2.xp += var3;
    var2.count++;
    return;
  }
}

function initcprooftopcrate(var0, var1) {
  var2 = var1.ref_12507 - var0.ref_12507;
  var3 = spawnStruct();
  var3.xp = 0;
  var3.count = 0;
  initcrossbowusage(var0.ref_1454f, var1.ref_1454f, var3);
  initcrossbowusage(var0.ref_14548, var1.ref_14548, var3);
  initcrossbowusage(var0.ref_14549, var1.ref_14549, var3);
  initcrossbowusage(var0.ref_1454b, var1.ref_1454b, var3);
  initcrossbowusage(var0.ref_1454e, var1.ref_1454e, var3);
  initcrossbowusage(var0.ref_1454c, var1.ref_1454c, var3);
  initcrossbowusage(var0.ref_1454d, var1.ref_1454d, var3);
  initcrossbowusage(var0.ref_1454a, var1.ref_1454a, var3);
  initcrossbowusage(var0.ref_14550, var1.ref_14550, var3);
  initcrossbowusage(var0.ref_1456e, var1.ref_1456e, var3);
  initcrossbowusage(var0.ref_1456c, var1.ref_1456c, var3);
  initcrossbowusage(var0.ref_1456b, var1.ref_1456b, var3);
  initcrossbowusage(var0.ref_14570, var1.ref_14570, var3);
  initcrossbowusage(var0.ref_1456f, var1.ref_1456f, var3);
  initcrossbowusage(var0.ref_14572, var1.ref_14572, var3);
  initcrossbowusage(var0.ref_14573, var1.ref_14573, var3);
  initcrossbowusage(var0.ref_14567, var1.ref_14567, var3);
  initcrossbowusage(var0.ref_14566, var1.ref_14566, var3);
  initcrossbowusage(var0.ref_14569, var1.ref_14569, var3);
  initcrossbowusage(var0.ref_1456a, var1.ref_1456a, var3);
  initcrossbowusage(var0.ref_1455a, var1.ref_1455a, var3);
  initcrossbowusage(var0.ref_1455f, var1.ref_1455f, var3);
  initcrossbowusage(var0.ref_1455b, var1.ref_1455b, var3);
  initcrossbowusage(var0.ref_1455c, var1.ref_1455c, var3);
  initcrossbowusage(var0.ref_1457b, var1.ref_1457b, var3);
  initcrossbowusage(var0.ref_1457a, var1.ref_1457a, var3);
  initcrossbowusage(var0.ref_1457c, var1.ref_1457c, var3);
  initcrossbowusage(var0.ref_14574, var1.ref_14574, var3);
  initcrossbowusage(var0.ref_14575, var1.ref_14575, var3);
  initcrossbowusage(var0.ref_14577, var1.ref_14577, var3);
  initcrossbowusage(var0.ref_14579, var1.ref_14579, var3);
  initcrossbowusage(var0.ref_14576, var1.ref_14576, var3);
  initcrossbowusage(var0.ref_14565, var1.ref_14565, var3);
  initcrossbowusage(var0.ref_14561, var1.ref_14561, var3);
  initcrossbowusage(var0.ref_14564, var1.ref_14564, var3);
  initcrossbowusage(var0.ref_14563, var1.ref_14563, var3);
  initcrossbowusage(var0.ref_14562, var1.ref_14562, var3);
  initcrossbowusage(var0.ref_14559, var1.ref_14559, var3);
  initcrossbowusage(var0.ref_14555, var1.ref_14555, var3);
  initcrossbowusage(var0.ref_14558, var1.ref_14558, var3);
  initcrossbowusage(var0.ref_14556, var1.ref_14556, var3);
  initcrossbowusage(var0.ref_14557, var1.ref_14557, var3);
  initcrossbowusage(var0.ref_14554, var1.ref_14554, var3);
  initcrossbowusage(var0.ref_14560, var1.ref_14560, var3);
  initcrossbowusage(var0.ref_14553, var1.ref_14553, var3);
  initcrossbowusage(var0.ref_1456d, var1.ref_1456d, var3);
  initcrossbowusage(var0.ref_14552, var1.ref_14552, var3);
  initcrossbowusage(var0.ref_1455d, var1.ref_1455d, var3);
  initcrossbowusage(var0.ref_14551, var1.ref_14551, var3);
  initcrossbowusage(var0.ref_1455e, var1.ref_1455e, var3);
  initcrossbowusage(var0.ref_14578, var1.ref_14578, var3);
  initcrossbowusage(var0.ref_14571, var1.ref_14571, var3);
  initcrossbowusage(var0.ref_14568, var1.ref_14568, var3);

  if(var2 != 0 || var3.xp != 0) {
    self dlog_recordplayerevent("dlog_event_player_stats_hack", ["player_xp_start", var0.ref_12507, "player_xp_end", var1.ref_12507, "diff_weapon_xp_count", var3.count, "diff_weapon_xp", var3.xp]);
    return;
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);

    if(!isai(var0)) {
      var0.initdismembermentlist = initcpammoarmorcrate(var0);
    }

    if(!isai(var0)) {
      if(level.playerxpenabled) {
        var0.pers["rankxp"] = var0 getplayerdata(level.loadoutsgroup, "squadMembers", "player_xp");
        var0.pers["battlepassxp"] = var0 getplayerdata(level.loadoutsgroup, "squadMembers", "battlepass_xp");
        var1 = var0 getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");

        if(!isDefined(var0.pers["xpEarnedThisMatch"])) {
          var0.pers["xpEarnedThisMatch"] = 0;
        }
      } else {
        var1 = 0;
        var0.pers["rankxp"] = 0;
        var0.pers["battlepassxp"] = 0;
      }
    } else {
      var1 = 0;
      var0.pers["rankxp"] = 0;
      var0.pers["battlepassxp"] = 0;
    }

    var0.pers["weaponxp"] = [];

    if(var0.pers["rankxp"] < 0) {
      var0.pers["rankxp"] = 0;
    }

    if(var0.pers["battlepassxp"] < 0) {
      var0.pers["battlepassxp"] = 0;
    }

    var2 = getrankxp(var0);
    var3 = getrankforxp(var0, var2);
    var4 = rodwatcher(var0, var2);
    var0.pers["rank"] = var3;
    var0.pers["prestige"] = var1;
    var0 setrank(var3 + var4, var1);
    var0.pers["participation"] = 0;
    var0.scoreupdatetotal = 0;
    var0.scorepointsqueue = 0;
    var0.scoreeventqueue = [];
    var0.postgamepromotion = 0;
    var0 setclientdvar("ui_promotion", 0);

    if(!isDefined(var0.pers["summary"])) {
      var0.pers["summary"] = [];
      var0.pers["summary"]["xp"] = 0;
      var0.pers["summary"]["score"] = 0;
      var0.pers["summary"]["challenge"] = 0;
      var0.pers["summary"]["match"] = 0;
      var0.pers["summary"]["misc"] = 0;
      var0.pers["summary"]["medal"] = 0;
      var0.pers["summary"]["bonusXP"] = 0;
    }

    var0 setclientdvar("MQNNLTKNTS", 0);

    if(level.playerxpenabled) {
      var5 = getdvarint("NTLKOKLKRS");
      var6 = var0 getprivatepartysize() > 1;

      if(var6) {
        addrankxpmultiplier(var0, var5, "online_mp_party_xpscale");

        if(function_043e(var0)) {
          addrankxpmultiplier(var0, 1.1, "online_clan_perk_xpscale");
        }
      }

      if(var0 getplayerdata("mp", "prestigeDoubleWeaponXp")) {
        var0.prestigedoubleweaponxp = 1;
      } else {
        var0.prestigedoubleweaponxp = 0;
      }
    }

    var0.scoreeventcount = 0;
    var0.scoreeventlistindex = 0;
    var0 setclientomnvar("ui_score_event_control", -1);
    var0 setclientomnvar("ui_potg_score_event_control", -1);
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
  var0 = self.pers["rankxp"];

  if(var0 < 0) {
    var0 = 0;
    self.pers["rankxp"] = 0;
  }

  var1 = getrankforxp(var0);
  self.pers["rank"] = var1;

  if(isai(self) || !isDefined(self.pers["prestige"])) {
    if(level.playerxpenabled && isDefined(self.bufferedstats)) {
      var2 = getprestigelevel();
    } else {
      var2 = 0;
    }

    self setrank(var2, var2);
    self.pers["prestige"] = var2;
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

function giverankxp(var0, var1, var2, var3, var4) {
  self endon("disconnect");

  if(isDefined(self.owner) && !isbot(self)) {
    giverankxp(self.owner, var0, var1, var2);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }

  var5 = botnodeavailabletoteam(self);
  var1 = int(var1 * var5);

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  if(!level.playerxpenabled) {
    if(var3 == 0) {
      scripts\mp\utility\points::displayscoreeventpoints(var1, var0);
    }

    return;
  }

  if(!isDefined(var1) || var1 == 0) {
    return;
  }

  var6 = getscoreinfocategory(var0, "group");

  if((!isDefined(level.forceranking) || !level.forceranking) && !scripts\mp\menus::brking_updateteamscore()) {
    jumpiffalse(level.teambased) LOC_00000105;
    var7 = 0;

    foreach(var9 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var9, "teamCount")) {
        var7++;

        if(var7 >= 2) {
          break;
        }
      }
    }

    if(var7 < 2) {
      return;
    }

    goto LOC_00000152;
  }

  var2 = calculate_teleport_data_for_player(var2);
  var14 = getscoreinfocategory(var1, "allowBonus");
  var15 = 1;
  var16 = var2;
  var17 = 0;

  if(istrue(var14)) {
    var15 = getrankxpmultipliertotal();
    var16 = int(var2 * var15);
    var17 = int(max(var16 - var2, 0));
    var18 = round_spawn_bombers(var1, var3);
    var16 += int(var18);
    var17 += int(var18);
  }

  if(!var4) {
    scripts\mp\utility\points::displayscoreeventpoints(var16, var1);
  }

  thread waitandapplyxp(var1, var2, var16, var17, var3, var5);
}

function calculate_teleport_data_for_player(var0) {
  var1 = var0;

  if(level.vip_death_player_hits_million != 1) {
    if(self.kills > level.vip_failquest) {
      var2 = min(int(1 + (self.kills - level.vip_failquest) / level.vip_completequest), level.vindia_assault3_check_size);
      var3 = 1 - level.vip_bink_vo * var2;
      var1 = int(var0 * var3);
    }
  }

  return var1;
}

function waitandapplyxp(var0, var1, var2, var3, var4, var5) {
  self endon("disconnect");

  if(!isDefined(var5)) {
    var5 = 0;
  }

  if(!var5) {
    waitframe();
    scripts\mp\utility\script::waittillslowprocessallowed();
  }

  var6 = getrankxp();

  if(updaterank(var6)) {}

  syncxpstat();
  var7 = 0;

  if(isDefined(var4)) {
    if(isDefined(var4.ref_121d9)) {
      var4 = var4.ref_121d9;
    }

    if(scripts\mp\weaponrank::weaponshouldgetxp(var4.basename)) {
      var7 = var1;
      var7 *= scripts\mp\weaponrank::getweaponrankxpmultipliertotal();
      var7 = int(var7);
    }
  }

  incrankxp(var2, var4, var7, var0);

  if(level.playerxpenabled && !isai(self)) {
    if(isDefined(var4) && (scripts\mp\utility\weapon::iscacprimaryweapon(var4) || scripts\mp\utility\weapon::iscacsecondaryweapon(var4))) {
      if(!scripts\mp\utility\weapon::ispickedupweapon(var4) || scripts\mp\utility\game::getgametype() == "br") {
        scripts\common\utility::ref_13e0a(level.ref_11b31, scripts\mp\utility\weapon::getweaponrootname(var4), "xp_earned", var7, -1, var4);
      }
    }
  }

  recordxpgains(var0, var1, var3);
  var8 = getprestigelevel();
  var9 = getrank();
}

function recordxpgains(var0, var1, var2) {
  var3 = var1 + var2;
  var4 = getscoreinfocategory(var0, "group");

  if(!isDefined(var4) || var4 == "") {
    self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + var1;
    self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
    self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
    return;
  }

  switch (var4) {
    case "match_bonus":
      self.pers["summary"]["match"] = self.pers["summary"]["match"] + var1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
      break;
    case "challenge":
      self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + var1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
      break;
    case "medal":
      if(!isDefined(self.pers["combatXP"])) {
        self.pers["combatXP"] = var1;
      } else {
        self.pers["combatXP"] = self.pers["combatXP"] + var1;
      }

      self.pers["summary"]["medal"] = self.pers["summary"]["medal"] + var1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
      break;
    case "combat":
      if(!isDefined(self.pers["combatXP"])) {
        self.pers["combatXP"] = var1;
      } else {
        self.pers["combatXP"] = self.pers["combatXP"] + var1;
      }

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
      break;
    case "looting":
      if(!isDefined(self.pers["lootingXP"])) {
        self.pers["lootingXP"] = var1;
      } else {
        self.pers["lootingXP"] = self.pers["lootingXP"] + var1;
      }

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
      break;
    case "missions":
      if(!isDefined(self.pers["missionXP"])) {
        self.pers["missionXP"] = var1;
      } else {
        self.pers["missionXP"] = self.pers["missionXP"] + var1;
      }

      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
      break;
    default:
      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
      break;
  }
}

function updaterank(var0) {
  var1 = getrank();
  var2 = getprestigelevel();
  var3 = self.pers["rank"] + self.pers["prestige"];
  var4 = var1 + var2;
  self.pers["rank"] = var1;
  self.pers["prestige"] = var2;

  if(var4 == var3 || var4 >= level.maxrank + level.ref_11b5c) {
    return false;
  }

  self setrank(var1, var2);
  return true;
}

function updaterankannouncehud() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  var0 = self.pers["team"];

  if(!isDefined(var0)) {
    return;
  }

  if(!scripts\mp\flags::levelflag("game_over")) {
    level scripts\engine\utility::waittill_notify_or_timeout("game_over", 0.25);
  }

  var1 = self.pers["rank"] + self.pers["prestige"];

  for(var2 = 0; var2 < level.players.size; var2++) {
    var3 = level.players[var2];
    var4 = var3.pers["team"];

    if(isDefined(var4) && var4 == var0) {
      var3 iprintln(&"RANK/PLAYER_WAS_PROMOTED", self, var1 + 1);
    }
  }
}

function queuescorepointspopup(var0) {
  self.scorepointsqueue += var0;
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

function scorepointspopup(var0, var1) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(var0 == 0) {
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(self) && !self ismlgspectator() && !scripts\mp\utility\player::isusingremote()) {
    if(!istrue(var1) || scripts\mp\utility\player::isinkillcam()) {
      queuescorepointspopup(var0);
      thread flushscorepointspopupqueueonspawn();
      return;
    }
  }

  self notify("scorePointsPopup");
  self endon("scorePointsPopup");
  self.scoreupdatetotal += var0;
  self setclientomnvar("ui_points_popup", self.scoreupdatetotal);
  self setclientomnvar("ui_points_popup_notify", gettime());
  wait 1;
  self.scoreupdatetotal = 0;
}

function notifyplayerscore() {
  waitframe();
  level notify("update_player_score", self, self.scoreupdatetotal);
}

function queuescoreeventpopup(var0) {
  self.scoreeventqueue[self.scoreeventqueue.size] = var0;
}

function flushscoreeventpopupqueue() {
  var0 = self.scoreeventqueue;
  self.scoreeventqueue = [];

  foreach(var2 in var0) {
    scoreeventpopup(var2);
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

function getscoreeventpriority(var0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return 0;
  }

  var1 = getscoreinfocategory(var0, "priority");

  if(!istrue(var1)) {
    return 0;
  }

  return var1;
}

function scoreeventalwaysshowassplash(var0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return false;
  }

  var1 = getscoreinfocategory(var0, "alwaysShowSplash");

  if(!istrue(var1)) {
    return false;
  }

  return true;
}

function scoreeventhastext(var0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return false;
  }

  var1 = getscoreinfocategory(var0, "eventID");
  var2 = getscoreinfocategory(var0, "text");

  if(!isDefined(var1) || var1 < 0 || !isDefined(var2) || var2 == "") {
    return false;
  }

  return true;
}

function scoreeventpopup(var0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return;
  }

  if(isDefined(self.owner)) {
    scoreeventpopup(self.owner, var0);
  }

  if(!isPlayer(self)) {
    return;
  }

  var1 = getscoreinfocategory(var0, "eventID");
  var2 = getscoreinfocategory(var0, "text");

  if(!isDefined(var1) || var1 < 0 || !isDefined(var2) || var2 == "") {
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(self) && !self ismlgspectator() && !scripts\mp\utility\player::isusingremote()) {
    queuescoreeventpopup(var0);
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

  self setclientomnvar("ui_potg_score_event_list_" + self.scoreeventlistindex, var1);
  self setclientomnvar("ui_score_event_list_" + self.scoreeventlistindex, var1);
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
  var0 = self.pers["rankxp"];
  var1 = self.pers["rank"];

  if(var0 < getrankinfominxp(var1) + getrankinfoxpamt(var1)) {
    return var1;
  }

  return getrankforxp(var0);
}

function rodwatcher(var0) {
  var1 = getrankinfomaxxp(level.maxrank);

  if(var0 >= var1) {
    var2 = var0 - var1;
    var3 = int(var2 / getdvarint("ONRNRMQSO") + 1);
    return var3;
  }

  return 0;
}

function getrankforxp(var0) {
  var1 = level.maxrank;

  if(var0 >= getrankinfominxp(var1)) {
    return var1;
  } else {
    var1--;
  }

  while(var1 > 0) {
    if(var0 >= getrankinfominxp(var1) && var0 < getrankinfominxp(var1) + getrankinfoxpamt(var1)) {
      return var1;
    }

    var1--;
  }

  return var1;
}

function getmatchbonusspm() {
  var0 = getrank() + 1;
  return (3 + var0 * 0.5) * 10;
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

function safedivide(var0) {
  if(isDefined(self.pers["weaponxp"][var0])) {
    return self.pers["weaponxp"][var0];
  }

  if(isenumvaluevalid(level.loadoutsgroup, "LoadoutWeapon", var0)) {
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "weapon_xp", var0);
  }

  return 0;
}

function incrankxp(var0, var1, var2, var3) {
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
    var0 = 0;
  }

  var4 = getrankxp();
  var5 = int(min(var4 + var0, getrankinfomaxxp(level.maxrank) - 1));

  if(self.pers["rank"] == level.maxrank && var5 >= getrankinfomaxxp(level.maxrank)) {
    var5 = getrankinfomaxxp(level.maxrank);
  }

  self.pers["xpEarnedThisMatch"] = self.pers["xpEarnedThisMatch"] + var0;
  self.pers["rankxp"] = var5;
  var6 = registerpublicevent();
  var7 = var0 * var6;
  var8 = registerpickupcreatedcallback();
  self.pers["battlepassxp"] = var8 + var7;
  var9 = "";

  if(isDefined(var1)) {
    var9 = scripts\mp\utility\weapon::relic_nuketimer_globalthread(var1.basename);
    var10 = scripts\mp\utility\weapon::getweaponrootname(var9);
    var11 = safedivide(var10);
    self.pers["weaponxp"][var10] = var11 + var2;
  }

  var12 = residuallight();
  var13 = var0 * var12;
  var14 = relic_award_bullets();
  var15 = var0 * var14;
  var16 = 1;
  var17 = 1;
  var18 = 1;
  var19 = 1;
  var20 = 1;

  if(isDefined(level.rankxpmultipliers) && isDefined(level.rankxpmultipliers["online_mp_xpscale"]) && level.rankxpmultipliers["online_mp_xpscale"] >= 2) {
    var16 = 2;
  }

  if(isDefined(level.weaponrankxpmultipliers) && isDefined(level.weaponrankxpmultipliers["online_mp_weapon_xpscale"]) && level.weaponrankxpmultipliers["online_mp_weapon_xpscale"] >= 2) {
    var17 = 2;
  }

  if(isDefined(level.ref_12133) && isDefined(level.ref_12133["online_operator_xpscale"]) && level.ref_12133["online_operator_xpscale"] >= 2) {
    var19 = 2;
  }

  if(isDefined(level.cleanupfunc) && isDefined(level.cleanupfunc["online_battle_xpscale_dvar"]) && level.cleanupfunc["online_battle_xpscale_dvar"] >= 2) {
    var18 = 2;
  }

  if(isDefined(level.halfheight) && isDefined(level.halfheight["online_clan_xpscale"]) && level.halfheight["online_clan_xpscale"] >= 2) {
    var20 = 2;
  }

  var21 = int(scripts\cp_mp\utility\game_utility::gettimesincegamestart() / 1000);
  self reportchallengeuserevent("mp_addxp", var0, scripts\mp\teams::lookupcurrentoperator(self.team), var9, var2, var7, int(var16 * 100), int(var17 * 100), int(var18 * 100), var21, var13, int(var19 * 100), var15, int(var20 * 100));
  scripts\mp\analyticslog::ref_119bf(self, var0, var9, var2, var3);
}

function syncxpstat() {
  var0 = getrankxp();
  var1 = self getplayerdata("common", "mpProgression", "playerLevel", "xp");

  if(var1 > var0) {
    return;
  }

  self setplayerdata("common", "mpProgression", "playerLevel", "xp", var0);
}

function delayplayerscorepopup(var0, var1, var2) {
  wait var0;
  thread scripts\mp\utility\points::giveunifiedpoints(var1);
}

function getgametypexpmultiplier() {
  if(!isDefined(level.gametypexpmodifier)) {
    var0 = getdvarfloat("scr_match_bonus_mode_override", 1);

    if(var0 != 1) {
      level.gametypexpmodifier = var0;
    } else {
      level.gametypexpmodifier = float(tablelookup("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 17));
    }
  }

  return level.gametypexpmodifier;
}

function addglobalrankxpmultiplier(var0, var1) {
  addrankxpmultiplier(level, var0, var1);
}

function getglobalrankxpmultiplier() {
  var0 = getrankxpmultiplier(level);
  var1 = getdvarint("scr_disable_xp_scale_quit", 0) == 0;

  if((var0 > 4 || var0 < 0) && var1) {
    exitlevel(0);
  }

  return var0;
}

function addrankxpmultiplier(var0, var1) {
  var2 = 4 / getrankxpmultiplier(level);

  if(var0 > var2) {
    return;
  }

  if(!isDefined(self.rankxpmultipliers)) {
    self.rankxpmultipliers = [];
  }

  if(isDefined(self.rankxpmultipliers[var1])) {
    self.rankxpmultipliers[var1] = max(self.rankxpmultipliers[var1], var0);
    return;
  }

  self.rankxpmultipliers[var1] = var0;
}

function getrankxpmultiplier() {
  if(!isDefined(self.rankxpmultipliers)) {
    return 1;
  }

  var0 = 1;

  foreach(var2 in self.rankxpmultipliers) {
    if(!isDefined(var2)) {
      continue;
    }

    var0 *= var2;
  }

  return var0;
}

function respawntagsfreed() {
  if(self resetclientkillstreakindexes()) {
    return getbnetigrweaponxpmultiplier();
  } else if(self isps4player()) {
    var0 = getdvarfloat("MPPRMTPSLT", 1);
    return var0;
  }

  return 1;
}

function removeglobalrankxpmultiplier(var0) {
  removerankxpmultiplier(level, var0);
}

function removerankxpmultiplier(var0) {
  if(!isDefined(self.rankxpmultipliers)) {
    return;
  }

  if(!isDefined(self.rankxpmultipliers[var0])) {
    return;
  }

  self.rankxpmultipliers[var0] = undefined;
}

function addteamrankxpmultiplier(var0, var1, var2) {
  if(!level.teambased) {
    var1 = "all";
  }

  if(!isDefined(self.teamrankxpmultipliers)) {
    level.teamrankxpmultipliers = [];
  }

  if(!isDefined(level.teamrankxpmultipliers[var1])) {
    level.teamrankxpmultipliers[var1] = [];
  }

  if(isDefined(level.teamrankxpmultipliers[var1][var2])) {
    level.teamrankxpmultipliers[var1][var2] = max(self.teamrankxpmultipliers[var1][var2], var0);
    return;
  }

  level.teamrankxpmultipliers[var1][var2] = var0;
}

function removeteamrankxpmultiplier(var0, var1) {
  if(!level.teambased) {
    var0 = "all";
  }

  if(!isDefined(level.teamrankxpmultipliers)) {
    return;
  }

  if(!isDefined(level.teamrankxpmultipliers[var0])) {
    return;
  }

  if(!isDefined(level.teamrankxpmultipliers[var0][var1])) {
    return;
  }

  level.teamrankxpmultipliers[var0][var1] = undefined;
}

function getteamrankxpmultiplier(var0) {
  if(!level.teambased) {
    var0 = "all";
  }

  if(!isDefined(var0) || !isDefined(level.teamrankxpmultipliers) || !isDefined(level.teamrankxpmultipliers[var0])) {
    return 1;
  }

  var1 = 1;

  foreach(var3 in level.teamrankxpmultipliers[var0]) {
    if(!isDefined(var3)) {
      continue;
    }

    var1 *= var3;
  }

  return var1;
}

function risktokensbanked() {
  if(!isDefined(level.ref_12751)) {
    level.ref_12751 = getdvarfloat("scr_playlist_xp_scalar", 1);
  }

  return level.ref_12751;
}

function getrankxpmultipliertotal() {
  var0 = getrankxpmultiplier();
  var1 = getglobalrankxpmultiplier();
  var2 = getteamrankxpmultiplier(self.team);
  var3 = respawntagsfreed();
  var4 = risktokensbanked();
  var5 = scripts\engine\utility::ter_op(function_043e(self), 1.1, 1);
  var6 = var0 * var1 * var2 * var3 * var4 * var5;
  return var6;
}

function round_spawn_bombers(var0, var1) {
  var2 = 0;
  var2 += calculate_path_struct(var0, var1);
  return var2;
}

function calculate_path_struct(var0, var1) {
  var2 = 0;

  if(var0 == "kill") {
    var3 = isDefined(var1) && var1 hasattachment("gunperk_xp", 1) || scripts\mp\utility\perk::_hasperk("specialty_gunperk_xp");

    if(var3) {
      var2 += 20;
    }
  }

  return var2;
}

function battle_tracks_playerinlisteningzoneinternal(var0, var1) {
  battle_tracks_gettogglestate(level, var0, var1);
}

function remindermessage() {
  var0 = registerpreviousprop(level);
  var1 = getdvarint("scr_disable_xp_scale_quit", 0) == 0;

  if((var0 > 4 || var0 < 0) && var1) {
    exitlevel(0);
  }

  return var0;
}

function battle_tracks_gettogglestate(var0, var1) {
  var2 = 4 / registerpreviousprop(level);

  if(var0 > var2) {
    return;
  }

  if(!isDefined(self.cleanupfunc)) {
    self.cleanupfunc = [];
  }

  if(isDefined(self.cleanupfunc[var1])) {
    self.cleanupfunc[var1] = max(self.cleanupfunc[var1], var0);
    return;
  }

  self.cleanupfunc[var1] = var0;
}

function registerpreviousprop() {
  if(!isDefined(self.cleanupfunc)) {
    return 1;
  }

  var0 = 1;

  foreach(var2 in self.cleanupfunc) {
    if(!isDefined(var2)) {
      continue;
    }

    var0 *= var2;
  }

  return var0;
}

function registerpublicevent() {
  var0 = registerpreviousprop();
  var1 = remindermessage();
  var2 = radiusdamagestepped(self);
  var3 = var0 * var1 * var2;
  return var3;
}

function battle_tracks_playerselectrandomtracks(var0, var1) {
  battle_tracks_togglestateis(level, var0, var1);
}

function remove_bank_lbravos() {
  var0 = resetvisionsetnighttodefault(level);
  var1 = getdvarint("scr_disable_xp_scale_quit", 0) == 0;

  if((var0 > 4 || var0 < 0) && var1) {
    exitlevel(0);
  }

  return var0;
}

function battle_tracks_togglestateis(var0, var1) {
  var2 = 4 / resetvisionsetnighttodefault(level);

  if(var0 > var2) {
    return;
  }

  if(!isDefined(self.ref_12133)) {
    self.ref_12133 = [];
  }

  if(isDefined(self.ref_12133[var1])) {
    self.ref_12133[var1] = max(self.ref_12133[var1], var0);
    return;
  }

  self.ref_12133[var1] = var0;
}

function residuallight() {
  var0 = resetvisionsetnighttodefault();
  var1 = remove_bad_loot_drops();
  var2 = respawntagsfreed();
  var3 = risktokensbanked();
  var4 = scripts\engine\utility::ter_op(function_043e(self), 1.1, 1);
  var5 = var0 * var1 * var2 * var3 * var4;
  return var5;
}

function resetvisionsetnighttodefault() {
  if(!isDefined(self.ref_12133)) {
    return 1;
  }

  var0 = 1;

  foreach(var2 in self.ref_12133) {
    if(!isDefined(var2)) {
      continue;
    }

    var0 *= var2;
  }

  return var0;
}

function remove_bad_loot_drops() {
  return resetvisionsetnighttodefault(level);
}

function battle_tracks_playerinsidezone(var0, var1) {
  battle_tracks_hasemptybattletracks(level, var0, var1);
}

function remove_assault_class() {
  var0 = relic_amped_wait_till_revived(level);
  var1 = getdvarint("scr_disable_xp_scale_quit", 0) == 0;

  if((var0 > 4 || var0 < 0) && var1) {
    exitlevel(0);
  }

  return var0;
}

function battle_tracks_hasemptybattletracks(var0, var1) {
  var2 = 4 / relic_amped_wait_till_revived(level);

  if(var0 > var2) {
    return;
  }

  if(!isDefined(self.halfheight)) {
    self.halfheight = [];
  }

  if(isDefined(self.halfheight[var1])) {
    self.halfheight[var1] = max(self.halfheight[var1], var0);
    return;
  }

  self.halfheight[var1] = var0;
}

function relic_award_bullets() {
  var0 = relic_amped_wait_till_revived();
  var1 = remote_tank_think();
  var2 = respawntagsfreed();
  var3 = risktokensbanked();
  var4 = scripts\engine\utility::ter_op(function_043f(self), 1, 0);
  var5 = scripts\engine\utility::ter_op(function_043e(self), 1.1, 1);
  var6 = var0 * var1 * var2 * var3 * var4 * var5;
  return var6;
}

function relic_amped_wait_till_revived() {
  if(!isDefined(self.halfheight)) {
    return 1;
  }

  var0 = 1;

  foreach(var2 in self.halfheight) {
    if(!isDefined(var2)) {
      continue;
    }

    var0 *= var2;
  }

  return var0;
}

function remote_tank_think() {
  return relic_amped_wait_till_revived(level);
}