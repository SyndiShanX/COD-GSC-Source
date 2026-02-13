/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1834.gsc
*************************************************/

init() {
  scripts\cp_mp\utility\game_utility::_id_815E();
  var_0 = scripts\cp\utility::getgametype();

  if(!isDefined(var_0)) {
    var_0 = getDvar("#x315af23e89f368200");
  }

  level._effect["money"] = loadfx("vfx/props/cash_player_drop");
  waitframe();
  var_1 = scripts\cp\utility::_id_459B(level.score_info_table, "cp/scoreinfo/cp_scoreinfo_base.csv");
  var_2 = scripts\cp\utility::_id_459B(level.score_splash_table, "cp/cp_splashTable.csv");
  var_3 = tablelookupgetnumrows(var_1);

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = spawnStruct();
    var_6 = tablelookupbyrow(var_1, var_4, 0);

    if(!isDefined(var_6) || var_6 == "") {
      continue;
    }
    var_7 = tablelookupbyrow(var_1, var_4, 1);

    if(var_7 != "") {
      _id_0756::_id_C2AC(var_6, "score", int(var_7));
    }

    var_8 = tablelookupbyrow(var_1, var_4, 2);

    if(var_8 != "") {
      _id_0756::_id_C2AC(var_6, "xp", int(var_8));
    }

    var_9 = tablelookupbyrow(var_1, var_4, 3);

    if(var_9 != "") {
      _id_0756::_id_C2AC(var_6, "weapon_xp", int(var_9));
    }

    var_10 = tablelookupbyrow(var_1, var_4, 4);

    if(var_10 == "True") {
      _id_0756::_id_C2AC(var_6, "double_xp", 1);
    } else {
      _id_0756::_id_C2AC(var_6, "double_xp", 0);
    }

    var_11 = tablelookupbyrow(var_1, var_4, 5);

    if(var_11 == "True") {
      _id_0756::_id_C2AC(var_6, "allowBonus", 1);
    } else {
      _id_0756::_id_C2AC(var_6, "allowBonus", 0);
    }

    var_12 = tablelookuprownum(var_2, 0, var_6);
    var_13 = tablelookupbyrow(var_2, var_4, 1);

    if(var_13 != "") {
      _id_0756::_id_C2AC(var_6, "eventID", var_12);
      _id_0756::_id_C2AC(var_6, "text", var_13);
    }
  }

  level._id_A78D = 0;
  level thread onplayerconnect();
  level thread _id_A116();
  _id_0961::_id_C28D(::_id_AB76);
  _id_095E::_id_C29C(::_id_A0F2);
  _id_095E::_id_C29C(::_id_FD41);
  _id_095E::_id_C29C(::_id_56BE);
  _id_06CB::_id_0FA4("on_ai_killed", ::killedactor);
  level.xp_per_round_highest_round = scripts\cp\utility::_id_459B(int(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", 0, 0)), 0);
  level.matchbonus_perminbase = scripts\cp\utility::_id_459B(int(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", 0, 1)), 375);
  level.operator_xp_scalar = scripts\cp\utility::_id_459B(int(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", 0, 2)), 1);
  level.xp_per_round_highest_round_forever_blitz = 150;
  level.xp_per_round_mode_order = [];
  level.xp_per_round_mode_order["default"] = 0;
  level.xp_per_round_mode_order["soul_capture"] = 1;
  level.xp_per_round_mode_order["holdout"] = 2;
  level.xp_per_round_mode_order["orb_follow"] = 3;
  level.xp_per_round_mode_order["exfil"] = 4;
  level.xp_per_round_mode_order["domination"] = 5;
  level.xp_per_round_mode_order["assault"] = 6;
  level.xp_per_round_mode_order["forever_blitz"] = 7;
  setperroundxp("default", 1);
}

setperroundxp(var_0, var_1) {
  if(var_0 == "forever_blitz") {
    if(var_1 > level.xp_per_round_highest_round_forever_blitz) {
      var_1 = level.xp_per_round_highest_round_forever_blitz;
    }
  } else if(var_1 > level.xp_per_round_highest_round)
    var_1 = level.xp_per_round_highest_round;

  var_2 = level.xp_per_round_mode_order[var_0] * level.xp_per_round_highest_round + var_1;
  var_3 = spawnStruct();
  var_3._id_A863 = tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 0);
  var_3.round = tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 1);

  if(var_3._id_A863 == var_0 && int(var_3.round) == var_1) {
    var_4 = float(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 2));
    var_5 = float(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 3));
    var_6 = float(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 4));
    var_7 = float(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 5));
    var_8 = float(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 6));
    var_9 = float(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 7));
    var_10 = float(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 8));
    var_11 = float(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 9));
    var_12 = int(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 10));
    var_13 = int(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 11));
    var_14 = int(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 12));
    var_15 = int(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 13));
    var_16 = float(tablelookupbyrow("cp/scoreinfo/cp_perroundxp.csv", var_2, 14));
    var_3.scoreevent = [var_4, var_5, var_6, var_7];
    var_3.weaponxp = [var_8, var_9, var_10, var_11];
    var_3.ekialimit = [var_12, var_13, var_14, var_15];
    var_3.matchbonus_limit = var_16;
    level.xp_per_round_parameter = var_3;
  }

  level.total_ekia_per_round_per_player = [];

  foreach(var_18 in level.players) {
    level.total_ekia_per_round_per_player[var_18 getxuid()] = 0;
    var_18.pers["matchbonus_participation_time"] = var_18.pers["matchbonus_participation_time"] + var_18.pers["matchbonus_round_participation_time"];
    var_18.pers["matchbonus_round_participation_time"] = 0;
    var_18.pers["battlepass_xp_participation_granted_this_round"] = 0;
  }
}

_id_AB76() {
  self._id_8C9B = 0;
  self._id_9A54 = 0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_8D7E = [];
    var_0._id_8D78 = [];
    var_0._id_8FFD = undefined;
    var_0._id_7120 = 0;
    var_0._id_C0F3 = 0;
    var_0._id_C0F1 = 0;
    var_0._id_9000 = 0;
    var_0._id_8FFB = 0;
    var_1 = var_0 getxuid();

    if(!isDefined(level.total_ekia_per_round_per_player[var_1])) {
      level.total_ekia_per_round_per_player[var_1] = 0;
    }

    var_0._id_42F6 = [];

    if(!isDefined(var_0.pers["cur_kill_streak"])) {
      var_0.pers["cur_kill_streak"] = 0;
    }

    if(!isDefined(var_0.pers["cur_death_streak"])) {
      var_0.pers["cur_death_streak"] = 0;
    }

    var_0 _id_828C();
    var_0 _id_8225();
    var_0 thread monitorreloadstart();
    var_0 thread _id_A139();
    var_0 thread _id_A150();
    var_0._id_90C7 = 0;
    var_0 _id_829A();
  }
}

_id_42F5(var_0, var_1) {
  if(var_1 < 50 && var_1 > 10) {
    level thread _id_0750::_id_CB70(self, "plr_damaged_light", undefined, 0.1);
  } else {
    level thread _id_0750::_id_CB70(self, "plr_damaged_heavy", undefined, 0.1);
  }
}

_id_B823(var_0, var_1) {}

killedactor(var_0) {
  if(!isDefined(var_0._id_50FF) || !isPlayer(var_0._id_50FF)) {
    return;
  }
  if(istrue(self._id_2042) || istrue(var_0._id_50FF.b_player_kill_scoring_disabled)) {
    return;
  }
  if(isDefined(self.on_zombie_killed_score_override_func)) {
    self[[self.on_zombie_killed_score_override_func]](var_0);
    return;
  }

  var_1 = self;
  var_2 = var_0._id_511D;
  var_3 = var_0._id_50FF;
  var_4 = var_0._id_DE2B;
  var_5 = var_0._id_04F6;
  var_6 = var_0._id_D9E0;
  var_7 = "";
  var_8 = undefined;

  switch (var_1._id_1210) {
    case "actor_enemy_zombie_screamer_cp":
      var_7 = "_screamer";
      var_8 = "screamer_kia";
      break;
    case "actor_enemy_zombie_juggernaut_cp":
      var_7 = "_special";
      var_8 = "juggernaut_kia";
      break;
    case "actor_enemy_zombie_trickster_cp":
      var_7 = "_trickster";
      var_8 = "trickster_kia";
      break;
    default:
      var_8 = "zombie_kia";
  }

  processkillingblows(var_1, var_3, var_2, var_4, var_5, var_6, var_7, var_8);
  processkillassists(var_1, var_3, var_8);
  processeffects(var_1, var_3, var_7);
  processuniquekilltracking(var_1, var_3, var_4, var_5, var_7);
}

processkillingblows(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = undefined;

  switch (var_3) {
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      if(var_0 scripts\cp\utility::_id_8891(var_4, var_5, var_3, var_1)) {
        var_8 = "headshot";
        var_1 thread updaterecentscoreeventkills("crit_finisher_multikill", 5, 1);
        var_1 _id_074E::_id_5530("kills_critical", 1);
      }

      break;
    case "MOD_MELEE":
      var_8 = "melee";

      if(var_4.basename == "s4_me_knife_mp" || var_4.basename == "s4_me_katana_mp" || var_4.basename == "s4_me_icepick_mp" || var_4.basename == "s4_me_leiomano_mp" || var_4.basename == "s4_me_axe_mp" || var_4.basename == "s4_me_rindigo_mp") {
        var_1 thread updaterecentscoreeventkills("melee_weapon_multikill", 5, 1);
      }

      break;
    case "MOD_IMPACT":
      if(isDefined(var_2) && istrue(var_2._id_86F2)) {
        var_8 = "brain_rot_turned";
      } else if(var_4.basename == "s4_throwing_knife_zm") {
        var_8 = "throwing_knife";
        var_1 thread updaterecentscoreeventkills(var_8 + "_multikill", 3);
      }

      break;
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
      if(var_4.basename == "s4_frag_usa_mk2_zm") {
        var_8 = "frag";
        var_1 thread updaterecentscoreeventkills(var_8 + "_multikill", 3);
      } else if(var_4.basename == "s4_monkey_bomb_zm") {
        var_8 = "monkey_bomb";
        var_1 thread updaterecentscoreeventkills(var_8 + "_multikill", 3);
      } else if(var_4.basename == "s4_frag_gbr_n82_zm") {
        var_8 = "gammon";
        var_1 thread updaterecentscoreeventkills(var_8 + "_multikill", 3);
      } else if(var_4.basename == "s4_la_walpha2_mp") {
        var_8 = "war_machine";
        var_1 thread updaterecentscoreeventkills(var_8 + "_multikill", 3);
      }

      break;
    case "MOD_EXPLOSIVE":
      if(var_4.basename == "s4_energy_mine_zm") {
        var_8 = "energy_mine";
        var_1 thread updaterecentscoreeventkills(var_8 + "_multikill", 3);
      } else if(var_4.basename == "s4_c4_zm") {
        var_8 = "c4";
        var_1 thread updaterecentscoreeventkills(var_8 + "_multikill", 3);
      } else if(var_4.basename == "s4_juggernaut_backpack_explosion_zm")
        var_1 thread updaterecentscoreeventkills("juggernaut_backpack_multikill", 3);
      else if(var_4.basename == "s4_me_rindigoww_mp") {
        var_8 = "ww_decimator";
        var_1 thread updaterecentscoreeventkills("ww_decimator_multikill", 5);
      }

      break;
    case "MOD_EXPLOSIVE_BULLET":
      if(var_4.basename == "s4_mg_streak_mp") {
        var_8 = "explosive_mg";
        var_1 thread updaterecentscoreeventkills(var_8 + "_multikill", 3);
      }

      break;
    case "MOD_FIRE":
      if(var_4.basename == "s4_molotov_zm") {
        var_8 = "molotov";

        if(isDefined(var_2) && isDefined(var_2.molotovkills)) {
          var_2.molotovkills++;

          if(var_2.molotovkills == 3) {
            var_1 _id_0752::_id_7003("molotov_multikill", undefined, undefined, undefined, var_0);
          }
        }
      } else if(var_4.basename == "s4_thermite_zm") {
        var_8 = "thermite";

        if(isDefined(var_2) && isDefined(var_2.thermitekills)) {
          var_2.thermitekills++;

          if(var_2.thermitekills == 3) {
            var_1 _id_0752::_id_7003("thermite_multikill", undefined, undefined, undefined, var_0);
          }
        }
      }

      break;
    case "MOD_UNKNOWN":
      if(var_4.basename == "s4_frost_blast_zm") {
        var_8 = "frost_blast";
      }

      break;
    default:
  }

  if(isDefined(var_2) && isDefined(var_2.score_event_string)) {
    var_8 = var_2.score_event_string;

    if(isDefined(var_2.s_trap) && isDefined(var_2.s_trap._id_039B) && var_2.s_trap._id_039B == "trap_electric" && isPlayer(var_1)) {
      level thread _id_070F::createelectrictrapkillevent(var_1);
    }
  }

  if(!isDefined(var_8)) {
    var_1 _id_0752::_id_7003(var_7, var_4, undefined, undefined, var_0);
  } else {
    var_1 _id_0752::_id_7003(var_8 + "_killingblow" + var_6, var_4, undefined, undefined, var_0);
  }

  var_1 giveekiasuperpoints(var_4);
  var_9 = var_1 getxuid();

  if(!isDefined(level.total_ekia_per_round_per_player[var_9])) {
    level.total_ekia_per_round_per_player[var_9] = 0;
  }

  level.total_ekia_per_round_per_player[var_9]++;
  var_1 _id_074E::_id_5530("kills", 1);
  var_1 thread updaterecentkillingblows(var_0);
}

processuniquekilltracking(var_0, var_1, var_2, var_3, var_4) {
  var_1 endon("disconnect");
  level endon("game_ended");
  var_1 notify("processUniqueKillTracking");
  var_1 endon("processUniqueKillTracking");

  if(var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_HEAD_SHOT") {
    var_1._id_2D30++;

    if(var_1._id_2D30 == 3) {
      var_5 = "oneshot_multikill";
      var_1 thread scripts\cp\cp_hud_message::showsplash(var_5);
      var_1 thread _id_070F::createmedalevent(var_1, var_5);
      scripts\cp\cp_playerstats::incrementcategorystat(self, "medalStats", var_5, "uses", 1);
      scripts\cp\cp_playerstats::updatecombatstat(self, "latestAchievement", var_5);
      scripts\cp\telemetry_cp::logevent_medal(self, var_5);
    }
  } else if(var_2 == "MOD_EXPLOSIVE" || var_2 == "MOD_GRENADE" || var_2 == "MOD_GRENADE_SPLASH" || var_2 == "MOD_PROJECTILE_SPLASH" || var_3.basename == "s4_energy_mine_zm" || var_3.basename == "s4_frost_blast_zm") {
    var_1.explosivekillsinaframecount++;

    if(var_1.explosivekillsinaframecount == 5) {
      var_5 = "oneshot_explosive_multikill";
      var_1 thread scripts\cp\cp_hud_message::showsplash(var_5);
      var_1 thread _id_070F::createmedalevent(var_1, var_5);
      scripts\cp\cp_playerstats::incrementcategorystat(self, "medalStats", var_5, "uses", 1);
      scripts\cp\cp_playerstats::updatecombatstat(self, "latestAchievement", var_5);
      scripts\cp\telemetry_cp::logevent_medal(self, var_5);
    }
  }

  var_1.killswithoutgettinghit++;

  if(!(var_1.killswithoutgettinghit % 20)) {
    var_5 = "killstreak_without_getting_hit";
    var_1 _id_0752::_id_7003(var_5, undefined, undefined, undefined, var_0);
    var_1 thread scripts\cp\cp_hud_message::showsplash(var_5);
    var_1 thread _id_070F::createmedalevent(var_1, var_5);
    scripts\cp\cp_playerstats::incrementcategorystat(self, "medalStats", var_5, "uses", 1);
    scripts\cp\cp_playerstats::updatecombatstat(self, "latestAchievement", var_5);
    scripts\cp\telemetry_cp::logevent_medal(self, var_5);
  }

  if(isDefined(var_1.adrenalineusetime)) {
    if(gettime() - var_1.adrenalineusetime <= 5000) {
      var_1.adrenalinekills++;

      if(var_1.adrenalinekills == 3) {
        var_1 _id_0752::_id_7003("stim_shot_multikill", undefined, undefined, undefined, var_0);
      }
    } else {
      var_1.adrenalineusetime = undefined;
      var_1.adrenalinekills = undefined;
    }
  }

  if(isDefined(var_1._id_11E0)) {
    var_1.aethershroudkills++;
    var_1 _id_0752::_id_7003("aether_shroud_finisher" + var_4, undefined, undefined, undefined, var_0);

    if(var_1.aethershroudkills == 5) {
      var_1 _id_0752::_id_7003("aether_shroud_multifinisher", undefined, undefined, undefined, var_0);
    }
  }

  if(_func_0107(var_1._id_0DF0) && var_1._id_0DF0.size) {
    foreach(var_7 in var_1._id_0DF0) {
      if(isDefined(var_7.owner) && var_7.owner == var_1 && isDefined(var_1._id_C86C)) {
        var_1 _id_0752::_id_7003("ring_of_fire_finisher" + var_4, undefined, undefined, undefined, var_0);
        var_1._id_C86C++;

        if(var_1._id_C86C == 10) {
          var_1 _id_0752::_id_7003("ring_of_fire_multifinisher", undefined, undefined, undefined, var_0);
        }

        continue;
      }

      var_1 _id_0752::_id_7003("ring_of_fire_assist", undefined, undefined, undefined, var_0);
    }
  }

  if(isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "orb_follow")) {
    var_9 = level._id_3BE9._id_0F51._id_2958;

    if(isDefined(var_9) && !var_1 istouching(var_9) && !var_0 istouching(var_9)) {
      var_1 thread updaterecentscoreeventkills("aether_orb_multikill_outside_dome", 3);
    }
  }

  waittillframeend;
  var_1._id_2D30 = 0;
  var_1.explosivekillsinaframecount = 0;
}

processkillassists(var_0, var_1, var_2) {
  if(isDefined(var_0._id_1DDE)) {
    foreach(var_4 in var_0._id_1DDE) {
      if(!isDefined(var_4) || !isPlayer(var_4)) {
        continue;
      }
      if(var_4 == var_1) {
        continue;
      }
      if(var_0 == var_4) {
        continue;
      }
      if(isDefined(level._id_1D2C)) {
        continue;
      }
      var_5 = undefined;

      if(isDefined(var_0._id_1DD4)) {
        var_6 = var_0._id_1DD4[var_4.guid];

        if(isDefined(var_6)) {
          if(gettime() - var_6._id_90A7 > 10000) {
            continue;
          }
          var_5 = var_6.objweapon;
        }
      }

      if(isDefined(level.custom_assist_event_name) && _func_0121(level.custom_assist_event_name)) {
        var_2 = level.custom_assist_event_name + var_2;
      }

      var_4 _id_0752::_id_7003(var_2, var_5, undefined, undefined, var_0);
      var_4 giveekiasuperpoints();
      var_7 = var_4 getxuid();

      if(!isDefined(level.total_ekia_per_round_per_player[var_7])) {
        level.total_ekia_per_round_per_player[var_7] = 0;
      }

      level.total_ekia_per_round_per_player[var_7]++;
      var_4 _id_074E::_id_5530("assists", 1);
    }
  }
}

processeffects(var_0, var_1, var_2) {
  if(isDefined(var_0.playereffects)) {
    foreach(var_4 in var_0.playereffects) {
      foreach(var_7, var_6 in var_4) {
        if(var_6.endtimeofeffect >= gettime() && isDefined(var_6._id_50FF)) {
          if(var_6._id_50FF == var_1) {
            var_6._id_50FF _id_0752::_id_7003(var_7 + "_finisher" + var_2, undefined, undefined, undefined, var_0);
            var_6._id_50FF thread updaterecentscoreeventkills(var_7 + "_multifinisher", 3);
            continue;
          }

          var_6._id_50FF _id_0752::_id_7003(var_7 + "_assist", undefined, undefined, undefined, var_0);
        }
      }
    }
  }
}

addplayereffects(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1) || isPlayer(var_1)) {
    return;
  }
  if(!isDefined(var_2) || !isDefined(var_2.guid)) {
    return;
  }
  if(!isDefined(var_1.playereffects)) {
    var_1.playereffects = [];
  }

  var_1.playereffects[var_2.guid] = ::scripts\cp\utility::_id_459B(var_1.playereffects[var_2.guid], []);
  var_4 = spawnStruct();
  var_4._id_50FF = var_2;
  var_4.endtimeofeffect = gettime() + var_3 * 1000;
  var_1.playereffects[var_2.guid][var_0] = var_4;
}

updaterecentkillingblows(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKillingblows");
  self endon("updateRecentKillingblows");

  if(!isDefined(self.recentkillingblowcount)) {
    self.recentkillingblowcount = 0;
  }

  self.recentkillingblowcount++;

  if(self.recentkillingblowcount > 1 && self.recentkillingblowcount < 26) {
    if(!(self.recentkillingblowcount % 5)) {
      var_1 = "multikillstreak_" + self.recentkillingblowcount;
      thread _id_0752::_id_7003(var_1, undefined, undefined, undefined, var_0);
      thread scripts\cp\cp_hud_message::showsplash(var_1);
      self notify("multikillstreak", self.recentkillingblowcount);
      thread _id_070F::createmedalevent(self, var_1);
      scripts\cp\cp_playerstats::incrementcategorystat(self, "medalStats", var_1, "uses", 1);
      scripts\cp\cp_playerstats::updatecombatstat(self, "latestAchievement", var_1);
      scripts\cp\telemetry_cp::logevent_medal(self, var_1);
    }
  }

  wait 2;
  self.recentkillingblowcount = 0;
}

updaterecentscoreeventkills(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentScoreEventKills");
  self endon("updateRecentScoreEventKills");
  self.recentscoreeventkills[var_0] = ::scripts\cp\utility::_id_459B(self.recentscoreeventkills[var_0], 0);
  self.recentscoreeventkills[var_0]++;

  if(!(self.recentscoreeventkills[var_0] % var_1)) {
    thread _id_0752::_id_7003(var_0);

    if(istrue(var_2)) {
      thread scripts\cp\cp_hud_message::showsplash(var_0);
      thread _id_070F::createmedalevent(self, var_0);
      scripts\cp\cp_playerstats::incrementcategorystat(self, "medalStats", var_0, "uses", 1);
      scripts\cp\cp_playerstats::updatecombatstat(self, "latestAchievement", var_0);
      scripts\cp\telemetry_cp::logevent_medal(self, var_0);
    }
  }

  wait 2;
  self.recentscoreeventkills = [];
}

giveekiasuperpoints(var_0) {
  if(!istrue(self._id_2043) && !istrue(self._id_11E0) && !istrue(self.b_frost_blast_active) && !_id_0766::_id_8A7D(var_0)) {
    _id_0766::_id_6FF9(0, "kill");
  }
}

_id_8D7D(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("killedPlayerNotify");
  self endon("killedPlayerNotify");

  if(!isDefined(self._id_8D9F)) {
    self._id_8D9F = 0;
  }

  self._id_8D9F++;

  if(weaponclass(var_2) == "spread") {
    if(!isDefined(self._id_DA59)) {
      self._id_DA59 = 1;
    } else {
      self._id_DA59++;

      if(self._id_DA59 >= 2) {
        _id_DA56(self._id_DA59);
      }
    }
  } else if(var_3 == "MOD_PISTOL_BULLET" || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_HEAD_SHOT") {
    if(!isDefined(self._id_2D30)) {
      self._id_2D30 = 1;
    } else {
      self._id_2D30++;

      if(self._id_2D30 >= 2) {
        _id_3A53(self._id_2D30);
      }
    }
  }

  waittillframeend;
  thread _id_A6A4(var_0, var_1, var_2, var_3, self._id_8D9F);
  self._id_8D9F = 0;
  self._id_2D30 = 0;
  self._id_DA59 = 0;
}

_id_A6A4(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getcompleteweaponname(var_2);

  for(var_6 = 0; var_6 < var_4; var_6++) {
    self notify("got_a_kill", var_1, var_5, var_3);
    waitframe();
  }
}

_id_8D7A(var_0, var_1, var_2, var_3, var_4, var_5) {
  level._id_A78D++;
  _id_3526(var_2, var_3, var_4);

  if(isai(var_1) || isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
    var_1.guid = var_1 getentitynumber();
  }

  var_6 = var_1.guid;
  var_7 = self.guid;
  var_8 = gettime();
  var_9 = getcompleteweaponname(var_2);
  thread _id_8D7D(var_0, var_1, var_2, var_3);
  thread _id_FD0E(var_0, var_1, var_2, var_9);
  thread _id_FD09(self);
  self._id_BC4A = self._id_9000;
  self._id_9000 = var_8;
  self._id_8FFE = var_1;
  self._id_9001 = var_1.origin;

  if(isPlayer(self)) {
    if(self._id_0157 > 0) {
      var_10 = self._id_0267 / self._id_0157;

      if(var_10 > 3.0) {
        level thread _id_0750::_id_CB70(self, "plr_kd_high", undefined, 0.75);
      }
    } else if(self._id_0267 > 5)
      level thread _id_0750::_id_CB70(self, "plr_kd_high", undefined, 0.75);
  }

  if(istrue(self._id_9075)) {
    _id_7DAE("clutch", 1);
  }

  self._id_9FFB = [];
  self._id_9FFB["mask"] = 0;
  self._id_9FFB["mask2"] = 0;
  self._id_42F6[var_6] = undefined;
  var_11 = scripts\cp\cp_weapon::getweapongroup(var_2.basename);

  if(!scripts\cp\utility::_id_88F6(var_2.basename) && !scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    if(var_3 == "MOD_EXECUTION") {
      _id_56F2(var_0);
    }

    if(var_2.basename == "none") {
      return 0;
    }

    if(isDefined(var_1._id_1DDC)) {
      var_12 = var_1._id_1DDC;
    } else {
      var_12 = self.origin;
    }

    var_13 = 1;

    if(isDefined(var_4)) {
      var_13 = var_4 == self;
    }

    var_14 = anglesToForward(self getplayerangles());
    var_15 = var_1.origin - var_12;
    var_16 = vectornormalize(var_15);
    var_17 = vectordot(var_14, var_16);
    var_18 = scripts\engine\utility::_id_8794(var_3);

    if(var_1._id_1DDE.size == 1 && !isDefined(var_1._id_1DDE[var_1.guid])) {
      if(var_11 == "weapon_sniper" && var_3 != "MOD_MELEE" && var_8 == var_1._id_1DD4[self.guid]._id_5BE2) {
        self._id_9FFB["oneshotkill"] = 1;
        self._id_9FFB["mask"] = self._id_9FFB["mask"] | 1;
        thread _id_8D83("one_shot_kill", 1);
        thread _id_0709::_id_6FB9("one_shot_kill");
        _id_7DAE("oneShotOneKills", 1);
      }

      if(var_11 == "weapon_shotgun" && var_3 != "MOD_MELEE" && var_8 == var_1._id_1DD4[self.guid]._id_5BE2) {
        self._id_9FFB["oneshotkill_shotgun"] = 1;
        _id_7DAE("oneShotOneKills", 1);
      }
    }

    if(var_3 == "MOD_MELEE") {
      if(var_11 != "weapon_melee" && var_11 != "weapon_melee2") {
        thread _id_8D83("gun_butt", 1);
        thread _id_0709::_id_6FB9("gun_butt");
      }

      if(var_2.basename == "iw8_fists_mp") {
        thread _id_8D83("fist_kill", 1);
        thread _id_0709::_id_6FB9("fist_kill");
      }
    }

    if(isPlayer(var_1)) {
      var_19 = var_1 getheldoffhand();

      if(var_19.basename == "frag_grenade_mp" || var_19.basename == "cluster_grenade_mp") {
        self._id_9FFB["cooking"] = 1;
        self._id_9FFB["mask"] = self._id_9FFB["mask"] | 2;
      }
    }

    if(isDefined(self._id_1D2B) && self._id_1D2B) {
      _id_1D2B(var_0, var_2);
    }

    if(level._id_A78D == 1) {
      _id_5BC4(var_0);
    }

    if(self.pers["cur_death_streak"] > 3) {
      _id_3AD3(var_0);
    }

    if(var_3 == "MOD_HEAD_SHOT") {
      level thread _id_0750::_id_CB70(self, "plr_killfirm_headshot", undefined, 0.75);
      _id_7617(var_0);
    }

    if(isDefined(self._id_10A22) && self._id_10A22 && var_8 - self._id_E393 <= 5000) {
      self._id_9FFB["jackintheboxkill"] = 1;
    }

    if(!scripts\cp\utility\player::isreallyalive(self) && isDefined(self._id_441F)) {
      var_20 = gettime() - self._id_441F;

      if(var_20 < 1500 && var_20 > 0) {
        _id_BA43(var_0);
      }

      if(scripts\cp\utility::_id_8A37()) {
        if(var_20 == 0 && isDefined(self._id_026E) && self._id_026E == var_1) {
          thread _id_8D83("simultaneous_kill", 0);
          thread _id_0709::_id_6FB9("simultaneous_kill", undefined, undefined, 1);
          var_1 thread _id_8D83("simultaneous_kill", 0);
          var_1 thread _id_0709::_id_6FB9("simultaneous_kill", undefined, undefined, 1);
        }
      }
    }

    if(isDefined(var_1._id_9000) && (level.teambased && var_8 - var_1._id_9000 < 1500)) {
      if(isDefined(var_1._id_8FFE) && var_1._id_8FFE != self) {
        _id_1F98(var_0, var_1._id_8FFE);
      }
    }

    foreach(var_23, var_22 in var_1._id_42F6) {
      if(var_23 == self.guid || var_23 == scripts\engine\utility::_id_EA52(var_1.guid)) {
        continue;
      }
      if(level.teambased && var_8 - var_22 < 1750) {
        _id_4619(var_0, var_23);
      }
    }

    if(var_13) {
      var_24 = _id_6D29(self, var_2, var_3, var_12, var_1);

      switch (var_24) {
        case "pointblank":
          thread _id_B9B4(var_0);
          break;
        case "longshot":
          thread _id_97CE(var_0);
          break;
        case "very_longshot":
          thread _id_97CE(var_0);
          thread _id_103AE(var_0);
          break;
      }
    }

    if(_id_8775(self, var_1, var_3)) {
      if(var_2.basename == "iw8_knife_mp") {
        thread _id_8D83("backstab", 1);
        thread _id_0709::_id_6FB9("backstab");
      }

      self._id_9FFB["backstab"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 4;
    }

    if(var_13) {
      switch (weaponclass(var_2.basename)) {
        case "rifle":
          _id_7DAE("arKills", 1);
          var_1 _id_7DAE("arDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            _id_7DAE("arHeadshots", 1);
          }

          break;
        case "smg":
          _id_7DAE("smgKills", 1);
          var_1 _id_7DAE("smgDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            _id_7DAE("smgHeadshots", 1);
          }

          break;
        case "spread":
          _id_7DAE("shotgunKills", 1);
          var_1 _id_7DAE("shotgunDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            _id_7DAE("shotgunHeadshots", 1);
          }

          break;
        case "mg":
          _id_7DAE("lmgKills", 1);
          var_1 _id_7DAE("lmgDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            _id_7DAE("lmgHeadshots", 1);
          }

          break;
        case "sniper":
          _id_7DAE("sniperKills", 1);
          var_1 _id_7DAE("sniperDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            _id_7DAE("sniperHeadshots", 1);
          }

          break;
        case "rocketlauncher":
          _id_7DAE("launcherKills", 1);
          var_1 _id_7DAE("launcherDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            _id_7DAE("launcherHeadshots", 1);
          }

          break;
        case "pistol":
          _id_7DAE("pistolKills", 1);
          var_1 _id_7DAE("pistolDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            _id_7DAE("pistolHeadshots", 1);
          }

          break;
      }

      if(var_3 == "MOD_MELEE") {
        _id_7DAE("meleeKills", 1);
        var_1 _id_7DAE("meleeDeaths", 1);
      }

      if(scripts\cp\utility::_hasperk("specialty_bulletdamage")) {
        _id_7DAE("stoppingPowerKills", 1);

        if(!isDefined(self._id_E935)) {
          self._id_E935 = 0;
        }

        self._id_E935++;
      }

      if(scripts\cp\utility::_hasperk("specialty_quieter")) {
        _id_7DAE("deadSilenceKills", 1);

        if(!isDefined(self._id_43A1)) {
          self._id_43A1 = 0;
        }

        self._id_43A1++;
      }

      if(isDefined(level._id_EB9A) && level._id_EB9A.size > 0) {
        foreach(var_26 in level._id_EB9A) {
          if(var_26.owner == self && var_26._id_786F == "radar_drone_overwatch") {
            var_26.owner _id_7DAE("killstreakPersonalUAVKills", 1);
            break;
          }
        }
      }

      if(_id_8A83(self)) {
        thread _id_6FAA("low_health_kill", var_0, var_2, "low_health_kill");
      }

      if(scripts\cp\utility\player::_id_8989()) {
        self._id_9FFB["ads"] = 1;
        self._id_9FFB["mask"] = self._id_9FFB["mask"] | 8;
        _id_7DAE("adsKills", 1);
      } else if(var_18) {
        self._id_9FFB["hipfire"] = 1;
        self._id_9FFB["mask"] = self._id_9FFB["mask"] | 16;
        _id_7DAE("hipfireKills", 1);
      }

      if(!self isonground()) {
        self._id_9FFB["airborne"] = 1;
      }

      if(isPlayer(var_1) || isagent(var_1)) {
        if(!var_1 isonground()) {
          self._id_9FFB["victim_airborne"] = 1;
        }
      }

      if(self _meth_826F() >= 0.5) {
        self._id_9FFB["mounted"] = 1;
        self._id_9FFB["mask"] = self._id_9FFB["mask"] | 32;
      }

      if(var_18) {
        self._id_9FFB["bullet_damage"] = 1;
        var_28 = self getweaponammoclip(var_2);

        if(var_28 <= 0) {
          self._id_9FFB["last_bullet_kill"] = 1;
          self._id_9FFB["mask"] = self._id_9FFB["mask"] | 64;
        }
      }

      if(isPlayer(var_1) || isagent(var_1)) {
        if(var_1 issprinting()) {
          self._id_9FFB["victim_sprinting"] = 1;
          self._id_9FFB["mask"] = self._id_9FFB["mask"] | 128;
        }
      }

      if(level.teambased) {
        foreach(var_30 in level.players) {
          if(self.team != var_30.team || self == var_30) {
            continue;
          }
          if(!scripts\cp\utility\player::isreallyalive(var_30)) {
            continue;
          }
          if(distancesquared(self.origin, var_30.origin) < 90000) {
            self._id_9FFB["buddy_kill"] = 1;
            break;
          }
        }
      }
    } else if(var_11 == "weapon_projectile") {
      if(isDefined(var_4) && isDefined(var_4._id_11B6)) {
        if(var_4._id_11B6) {
          self._id_9FFB["ads"] = 1;
          self._id_9FFB["mask"] = self._id_9FFB["mask"] | 8;
        } else {
          self._id_9FFB["hipfire"] = 1;
          self._id_9FFB["mask"] = self._id_9FFB["mask"] | 16;
        }
      }
    }

    if(isPlayer(var_1) || isagent(var_1)) {
      if(!var_1 isonground() && !var_1 _meth_8498() && (!self isonground() && !self _meth_8498())) {
        if(var_13) {
          thread _id_6FAA("air_to_air_kill", var_0, var_2, "air_to_air_kill");
        }
      } else {
        if(var_13) {
          if(self _meth_8498()) {
            thread _id_6FAA("wallkill", var_0, var_2, "wallrun_kill");
          } else if(_id_87F0(self, var_2, var_3, var_12, var_1)) {
            thread _id_6FAA("jumpkill", var_0, var_2, "air_kill");
          } else if(_id_56BD()) {
            thread _id_6FAA("slidekill", var_0, var_2, "slide_kill");
            self._id_9FFB["sliding"] = 1;
            self._id_9FFB["mask"] = self._id_9FFB["mask"] | 256;
          }

          var_32 = self getstance();

          switch (var_32) {
            case "prone":
              self._id_9FFB["prone_kill"] = 1;
              self._id_9FFB["mask"] = self._id_9FFB["mask"] | 512;
              break;
            case "crouch":
              self._id_9FFB["crouch_kill"] = 1;
              self._id_9FFB["mask"] = self._id_9FFB["mask"] | 1024;
              break;
          }
        }

        if(var_1 _meth_8498()) {
          thread _id_6FAA("killonwall", var_0, var_2, "kill_wallrunner");
        } else if(_id_8A3A(self, var_2, var_3, var_12, var_1)) {
          thread _id_6FAA("killinair", var_0, var_2, "kill_jumper");
        }
      }
    }

    if(isDefined(var_1._id_E9FF)) {
      foreach(var_34 in var_1._id_E9FF._id_EA14) {
        var_35 = var_34._id_41BD - var_1._id_EA13;

        if(var_35 > 0 && var_35 <= 1) {
          _id_2DE6(var_0, var_1);
          break;
        }
      }
    }

    if(var_13 && (isPlayer(self) || isagent(self))) {
      if(self _meth_81CE()) {
        thread _id_8D83("mantle_kill", 1);
        thread _id_0709::_id_6FB9("mantle_kill");
      }

      if(isDefined(self._id_F33C[var_9]) && self._id_F33C[var_9] == var_1) {
        thread _id_8D83("backfire", 1);
        thread _id_0709::_id_6FB9("backfire");
      }
    }

    if(isDefined(var_1._id_EA8D)) {
      level thread _id_0750::_id_CB70(self, "plr_killfirm_semtex", undefined, 0.75);
    }

    if(_id_0777::_id_8A9F(var_2.basename)) {
      thread _id_8D83("throwingknife_kill", 1);
      thread _id_0709::_id_6FB9("throwingknife_kill");
    }

    var_37 = self.pers["cur_kill_streak"] + 1;
    var_38 = 5;

    if(level.gametype == "arm") {
      var_38 = 10;
    }

    if(!(var_37 % var_38)) {
      if(!isDefined(self._id_8FFF) || var_37 != self._id_8FFF) {
        thread scripts\cp\cp_hud_util::_id_EF8D("callout_kill_streaking", self, undefined, var_37);
        self._id_8FFF = var_37;
      }

      if(var_37 <= 30) {
        thread _id_8D83("streak_" + var_37, 1);
        thread _id_0709::_id_6FB9("streak_" + var_37);
      }
    }

    if(!(var_37 % 5)) {}

    if(var_37 > 30) {
      thread _id_8D83("streak_max", 1);
      thread _id_0709::_id_6FB9("streak_max");
    }

    if(isDefined(var_4) && istrue(var_4._id_8835) && var_3 == "MOD_IMPACT" && !_id_0777::_id_8A9F(var_2.basename)) {
      thread _id_0709::_id_6FB9("item_impact");
      self._id_9FFB["item_impact"] = 1;
    }

    if(_id_0777::_id_8905(var_2, var_3)) {
      thread _id_8D83("launcher_direct_hit", 1);
      thread _id_0709::_id_6FB9("launcher_direct_hit");
      self._id_9FFB["launcher_impact"] = 1;
    }

    if(var_17 >= 0.6428) {
      self._id_9FFB["victim_in_standard_view"] = 1;
    }

    if(isDefined(self._id_8F84) && var_8 - self._id_8F84 <= 500 && var_11 == "weapon_sniper") {
      self._id_9FFB["quickscope"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 2048;
    }

    if(self.health <= 50) {
      self._id_9FFB["low_health_kill"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 4096;
    }

    if(isDefined(self._id_90C7) && var_8 - self._id_90C7 <= 1500) {
      self._id_9FFB["weapon_change_kill"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 8192;
    }

    if(isDefined(self._id_90CC) && var_8 - self._id_90CC <= 1500) {
      self._id_9FFB["weapon_pickup_kill"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 16384;
    }

    if(isDefined(self._id_9038) && var_8 - self._id_9038 <= 1500) {
      self._id_9FFB["reload_kill"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 65536;
    }

    if(istrue(var_1._id_87F7)) {
      self._id_9FFB["killed_defuser"] = 1;
    }

    if(scripts\cp\cp_weapon::_id_879C(var_2)) {
      self._id_9FFB["secondary_weapon"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 131072;
    }

    thread _id_352A(var_0, var_1);
  }

  if(!isDefined(self._id_8D7E[var_6])) {
    self._id_8D7E[var_6] = 0;
  }

  if(!isDefined(var_1._id_8D78[var_7])) {
    var_1._id_8D78[var_7] = 0;
  }

  self._id_8D7E[var_6]++;
  var_1._id_8D78[var_7]++;
  var_1._id_8FFD = self;

  if(isPlayer(var_1)) {
    if(!var_1 scripts\cp\utility::_id_8ACE() && (!var_1 scripts\cp\utility::_hasperk("specialty_survivor") || istrue(var_1.inlaststand))) {
      var_1 thread scripts\cp\utility::_id_D523();
    }
  }

  _id_0960::_id_2C9F("kill_event_buffered", var_1, var_9, var_3, self._id_9FFB);
}

_id_88F4(var_0) {
  return isDefined(var_0) && isDefined(var_0._id_1031E) && isDefined(var_0.streakinfo);
}

_id_3526(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::_id_88F6(var_0.basename) || _id_88F4(var_2);
  var_4 = _id_0752::_id_8868(var_0);

  if(var_3 && !var_4) {
    var_5 = level._id_8DEE[var_0.basename];
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;

    if(!isDefined(var_5)) {
      return;
    }
    switch (var_5) {
      case "bradley":
        _id_7DAE("killstreakTankKills", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "chopper_gunner":
        _id_7DAE("killstreakChopperGunnerKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "chopper_support":
        _id_7DAE("killstreakChopperSupportKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "cruise_predator":
        _id_7DAE("killstreakCruiseMissileKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "fuel_airstrike":
        var_7 = 1;
        break;
      case "gunship":
        _id_7DAE("killstreakGunshipKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "hover_jet":
        _id_7DAE("killstreakVTOLJetKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "juggernaut":
        _id_7DAE("killstreakJuggernautKills", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "manual_turret":
        _id_7DAE("killstreakShieldTurretKills", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "multi_airstrike":
        var_7 = 1;
        break;
      case "pac_sentry":
        _id_7DAE("killstreakWheelsonKills", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "precision_airstrike":
        _id_7DAE("killstreakAirstrikeKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "sentry_gun":
        _id_7DAE("killstreakSentryGunKills", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "toma_strike":
        _id_7DAE("killstreakCluserStrikeKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "white_phosphorus":
        _id_7DAE("killstreakWhitePhosphorousKillsAssists", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      default:
        thread _id_0752::_id_7003("killstreak_full_score", var_0);
        break;
    }

    if(isDefined(var_2.streakinfo)) {
      if(!isDefined(var_2.streakinfo._id_0267)) {
        var_2.streakinfo._id_0267 = 0;
      }

      var_2.streakinfo._id_0267++;
    }

    _id_7DAE("killstreakKills", 1);

    if(var_8) {
      _id_7DAE("killstreakAirKills", 1);
    }

    if(var_9) {
      _id_7DAE("killstreakGroundKills", 1);
    }

    if(var_7) {
      thread _id_0709::_id_6FB9("ss_kill_" + var_5, undefined, undefined, undefined, undefined, undefined, var_6);
    }

    level thread _id_0750::_id_CB70(self, "plr_killfirm_killstreak", undefined, 0.75);
  }
}

_id_8D7B(var_0, var_1, var_2) {
  if(scripts\cp\utility::_id_88F6(var_2.basename)) {
    thread _id_3526(var_2, undefined, var_1);
  } else {
    var_3 = "kill_ss_" + var_0;
    var_1 thread _id_0709::_id_6FB9(var_3);
    var_1 _id_7DAE("destroyedKillstreaks", 1);
    level thread _id_0750::_id_CB70(var_1, "plr_killstreak_destroy", undefined, 0.75);
  }

  if(isDefined(var_1._id_AFAA) && var_1 scripts\cp\utility::_hasperk("specialty_chain_killstreaks")) {
    var_4 = 10;
    var_5 = var_4 * var_1._id_AFAA["super_fill_scalar"];
  }
}

_id_85B7(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_3._id_038F > var_0._id_038F) {
      return 0;
    }
  }

  return 1;
}

_id_6D29(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(var_0) && !var_0 scripts\cp\utility::_id_8ACE() && (var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_HEAD_SHOT") && !scripts\cp\utility::_id_88F6(var_1.basename) && !istrue(var_0._id_1D2B)) {
    var_5 = distancesquared(var_3, var_4.origin);

    if(var_5 < 9216) {
      return "pointblank";
    }

    if(var_5 > 4000000) {
      return "very_longshot";
    }

    var_6 = scripts\cp\cp_weapon::getweapongroup(var_1.basename);
    var_7 = undefined;

    switch (var_6) {
      case "weapon_pistol":
        var_7 = 800;
        break;
      case "weapon_beam":
      case "weapon_smg":
        var_7 = 1200;
        break;
      case "weapon_assault":
      case "weapon_dmr":
      case "weapon_lmg":
        var_7 = 1500;
        break;
      case "weapon_rail":
      case "weapon_sniper":
        var_7 = 2000;
        break;
      case "weapon_shotgun":
        var_7 = 500;
        break;
      case "weapon_projectile":
      default:
        var_7 = 1536;
        break;
    }

    var_8 = var_7 * var_7;

    if(var_5 > var_8) {
      return "longshot";
    }
  }

  return "none";
}

_id_87F0(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(var_0) && var_0 _meth_846A() && scripts\engine\utility::_id_8794(var_2)) {
    var_5 = var_0.origin[2] - var_4.origin[2];
    return var_5 > 60;
  }

  return 0;
}

_id_8A3A(var_0, var_1, var_2, var_3, var_4) {
  return isalive(var_0) && var_4 _meth_846A() && scripts\engine\utility::_id_8794(var_2);
}

_id_8775(var_0, var_1, var_2) {
  if(!isPlayer(var_0) || !isPlayer(var_1)) {
    return 0;
  }

  if(var_2 != "MOD_RIFLE_BULLET" && var_2 != "MOD_PISTOL_BULLET" && var_2 != "MOD_MELEE" && var_2 != "MOD_HEAD_SHOT") {
    return 0;
  }

  var_3 = var_1 getplayerangles();
  var_4 = var_0 getplayerangles();
  var_5 = _func_000B(var_3[1] - var_4[1]);

  if(abs(var_5) < 80) {
    return 1;
  }

  return 0;
}

_id_8A83(var_0) {
  return var_0.health > 0 && var_0.health < var_0.maxhealth * 0.2;
}

_id_352A(var_0, var_1) {
  if(isDefined(self._id_8FFD) && self._id_8FFD == var_1) {
    self._id_8FFD = undefined;
    _id_C7B3(var_0, var_1);
  }
}

_id_6FAA(var_0, var_1, var_2, var_3) {
  self._id_9FFB[var_0] = 1;

  if(isDefined(var_3)) {
    thread _id_0709::_id_6FB9(var_3);
  } else {
    thread _id_0752::_id_7003(var_0, var_2);
  }
}

_id_BDD5(var_0) {
  self._id_9FFB["proximityAssist"] = 1;
  thread _id_0752::_id_7003("proximityassist");
}

_id_BDD7(var_0) {
  self._id_9FFB["proximityKill"] = 1;
  thread _id_0752::_id_7003("proximitykill");
}

_id_97CE(var_0) {
  self._id_9FFB["longshot"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 262144;
  _id_7DAE("longshotKills", 1);
  thread _id_8D83("longshot", 1);
  thread _id_0709::_id_6FB9("longshot");
}

_id_103AE(var_0) {
  self._id_9FFB["very_longshot"] = 1;
}

_id_B9B4(var_0) {
  self._id_9FFB["pointblank"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 524288;
  thread _id_8D83("pointblank", 1);
  thread _id_0709::_id_6FB9("pointblank");
  _id_7DAE("pointBlankKills", 1);
}

_id_7617(var_0) {
  self._id_9FFB["headshot"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 1048576;
  thread _id_8D83("headshot", 1);
  thread _id_0709::_id_6FB9("headshot");
}

_id_1F98(var_0, var_1) {
  self._id_9FFB["avenger"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 2097152;
  _id_7DAE("avengerKills", 1);
  thread _id_8D83("avenger", 1);
  thread _id_0709::_id_6FB9("avenger");
}

_id_1D2B(var_0, var_1) {
  self._id_9FFB["assistedsuicide"] = 1;
  thread _id_0752::_id_7003("assistedsuicide", var_1);
  thread _id_8D83("assistedsuicide", 1);
  thread _id_0709::_id_6FB9("assistedsuicide");
}

_id_4619(var_0, var_1) {
  self._id_9FFB["defender"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 4194304;
  _id_7DAE("defenderKills", 1);
  var_2 = scripts\cp\utility::_id_6C4D(var_1);
  thread _id_8D83("savior", 0);
  thread _id_0709::_id_6FB9("save_teammate");
}

_id_BA43(var_0) {
  self._id_9FFB["posthumous"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 8388608;
  thread _id_8D83("posthumous", 1);
  thread _id_0709::_id_6FB9("posthumous");
}

_id_C7B3(var_0, var_1) {
  self._id_9FFB["revenge"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 16777216;
  _id_7DAE("revengeKills", 1);
  thread _id_8D83("revenge", 1);
  thread _id_0709::_id_6FB9("revenge");
  playFX(scripts\engine\utility::getfx("money"), var_1.origin + (0, 0, 64));
}

_id_A2F8(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_41D6)) {
    self._id_41D6 = var_1;
  }

  if(var_1 < self._id_41D6) {
    return;
  }
  self notify("multiKill");
  self endon("multiKill");
  waitframe();
  var_4 = undefined;
  var_5 = undefined;

  switch (var_1) {
    case 2:
      var_4 = "double";
      break;
    case 3:
      var_4 = "triple";
      var_5 = "callout_3xkill";
      break;
    case 4:
      var_4 = "four";
      var_5 = "callout_4xkill";
      break;
    case 5:
      var_4 = "five";
      var_5 = "callout_5xkill";
      break;
    case 6:
      var_4 = "six";
      var_5 = "callout_6xkill";
      break;
    case 7:
      var_4 = "seven";
      var_5 = "callout_7xkill";
      break;
    case 8:
      var_4 = "eight";
      var_5 = "callout_8xkill";
      break;
    default:
      var_4 = "multi";
      var_5 = "callout_9xkill";
      break;
  }

  if(isDefined(self.pers["highestMultikill"]) && var_1 > self.pers["highestMultikill"]) {
    self.pers["highestMultikill"] = var_1;
  }

  if(isDefined(var_4)) {
    thread _id_8D83(var_4, scripts\engine\utility::ter_op(isDefined(var_2), var_2, 1), istrue(var_3));

    if(!istrue(var_3)) {
      thread _id_0709::_id_6FB9(var_4, undefined, undefined, undefined, undefined, undefined, undefined, undefined, self getcurrentweapon());
    }
  }

  if(isDefined(var_5)) {
    thread scripts\cp\cp_hud_util::_id_EF8D(var_5, self);
  }
}

_id_5BC4(var_0) {
  self._id_9FFB["firstblood"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 33554432;
  thread scripts\cp\cp_hud_util::_id_EF8D("callout_firstblood", self);
  thread _id_8D83("firstblood", 1);
  thread _id_0709::_id_6FB9("firstblood");
}

_id_10E5F(var_0) {}

_id_2DE6(var_0, var_1) {
  self._id_9FFB["buzzkill"] = var_1.pers["cur_kill_streak"];
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 67108864;
  thread _id_8D83("buzzkill", 1);
  thread _id_0709::_id_6FB9("buzzkill");
}

_id_3AD3(var_0) {
  self._id_9FFB["comeback"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 134217728;
  thread _id_8D83("comeback", 1);
  thread _id_0709::_id_6FB9("comeback");
  _id_7DAE("comebackKills", 1);
}

_id_3A53(var_0) {
  if(var_0 == 2) {
    level thread _id_0750::_id_CB70(self, "plr_killfirm_twofer", undefined, 0.75);
    thread _id_8D83("one_shot_two_kills", 1);
    thread _id_0709::_id_6FB9("one_shot_two_kills");
  }

  if(var_0 == 3) {
    level thread _id_0750::_id_CB70(self, "plr_killfirm_threefer", undefined, 0.75);
  }
}

_id_DA56(var_0) {}

_id_4B17() {
  var_0 = self.guid;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(isDefined(level.players[var_1]._id_8D7E[var_0])) {
      level.players[var_1]._id_8D7E[var_0] = undefined;
    }

    if(isDefined(level.players[var_1]._id_8D78[var_0])) {
      level.players[var_1]._id_8D78[var_0] = undefined;
    }
  }
}

_id_A116() {
  level endon("end_game");

  for(;;) {
    level waittill("healed", var_0);
    var_0 thread _id_0752::_id_7003("healed");
  }
}

_id_FD0E(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");

  if(!isDefined(self._id_C0F3)) {
    self._id_C0F3 = 0;
  }

  self._id_C0F3++;

  if(!isDefined(self._id_C0F4)) {
    self._id_C0F4 = [];
  }

  if(!isDefined(self._id_C0F4[var_3])) {
    self._id_C0F4[var_3] = 1;
  } else {
    self._id_C0F4[var_3]++;
  }

  var_4 = scripts\cp\utility::_id_6A18(var_2.basename);

  if(isDefined(var_4) && var_4 == "lethal" && var_2.basename != "throwingknife_mp") {
    level thread _id_0750::_id_CB70(self, "plr_killfirm_grenade", undefined, 0.75);
    level thread _id_0750::_id_CB70(self, "plr_killfirm_amf", undefined, 0.75);

    if(self._id_C0F4[var_3] > 0 && self._id_C0F4[var_3] % 2 == 0) {
      thread _id_8D83("grenade_double", 1);
      thread _id_0709::_id_6FB9("grenade_double");
    }
  }

  _id_0960::_id_2C9F("update_rapid_kill_buffered", self._id_C0F3, var_3);

  if(self._id_C0F3 > 1) {
    thread _id_A2F8(var_0, self._id_C0F3, 0);
  }

  wait 2.5;

  if(self._id_C0F3 > 1) {
    thread _id_A2F8(var_0, self._id_C0F3, 1, 1);

    if(self._id_C0F3 > 2) {}
  }

  _id_7DAE("mostMultikills", 1);
  self._id_C0F3 = 0;
  self._id_C0F1 = 0;
  self._id_C0F4 = undefined;
}

_id_A0FE() {
  level endon("end_game");
  self endon("disconnect");

  for(;;) {
    self waittill("hijacker", var_0, var_1);
    thread _id_0709::_id_6FB9("ss_use_enemy_dronedrop");
    var_2 = "hijacked_airdrop";

    if(isDefined(var_1)) {
      var_1 scripts\cp\cp_hud_message::showsplash(var_2, undefined, self);
    }
  }
}

_id_FD09(var_0) {
  if(isDefined(level._id_BE94) && gettime() - level._id_BE94._id_E72D > 5000) {
    level._id_BE94 = undefined;
  }

  if(!isDefined(level._id_BE94) || level._id_BE94.player != var_0) {
    var_1 = spawnStruct();
    var_1.player = var_0;
    var_1._id_E72D = gettime();
    var_1._id_5A02 = 1;
    level._id_BE94 = var_1;
  } else {
    var_1 = level._id_BE94;
    var_1._id_5A02++;

    if(var_1._id_5A02 == 4) {
      var_1.player thread _id_8D83("quad_feed", 1);
      var_1.player thread _id_0709::_id_6FB9("quad_feed");
      level._id_BE94 = undefined;
    }
  }
}

_id_828C() {
  self._id_56C2 = self issprintsliding();
  self._id_56C0 = undefined;
}

_id_56BE() {
  if(scripts\cp\utility\player::isreallyalive(self)) {
    var_0 = self issprintsliding();

    if(istrue(self._id_56C2) && !var_0) {
      self._id_56C0 = gettime();
    }

    self._id_56C2 = var_0;
  } else {
    self._id_56C2 = 0;
    self._id_56C0 = undefined;
  }
}

_id_56BD() {
  if(self issprintsliding()) {
    return 1;
  }

  _id_56BE();

  if(isDefined(self._id_56C0)) {
    if(gettime() - self._id_56C0 <= 150) {
      return 1;
    }
  }

  return 0;
}

_id_8225() {
  self._id_10A07 = scripts\cp\utility\player::_id_8989();
  self._id_8F84 = 0;
}

_id_A0F2() {
  if(scripts\cp\utility\player::_id_8989()) {
    if(!self._id_10A07) {
      self._id_8F84 = gettime();
      self._id_10A07 = 1;
    }
  } else
    self._id_10A07 = 0;
}

monitorreloadstart() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload_start");
    var_0 = self getcurrentweapon();
    var_1 = self getweaponammoclip(var_0);

    if(var_1 > 0) {
      self.nomanualreloads = 0;
    }
  }
}

_id_A139() {
  level endon("game_ended");
  self endon("disconnect");
  self._id_9038 = 0;

  for(;;) {
    self waittill("reload");
    self._id_9038 = gettime();
    _id_7DAE("reloads", 1);
  }
}

_id_A150() {
  level endon("game_ended");
  self endon("disconnect");
  self._id_90CC = 0;

  for(;;) {
    self waittill("weapon_pickup");
    self._id_90CC = gettime();
    _id_7DAE("weaponPickups", 1);
  }
}

_id_A152() {
  level endon("game_ended");
  self endon("disconnect");
  self._id_90C7 = 0;

  for(;;) {
    self waittill("weapon_change");
    self._id_90C7 = gettime();
  }
}

_id_FD89() {
  self._id_90C7 = gettime();
}

_id_829A() {
  self._id_9054 = self getstance();
  self._id_9055 = gettime();
  self._id_9056 = [];
  self._id_9056["prone"] = 0;
  self._id_9056["crouch"] = 0;
  self._id_9056["stand"] = 0;
}

_id_FD41() {
  if(!isalive(self)) {
    return;
  }
  var_0 = self._id_9A54;
  self._id_9A54 = self _meth_81CE();

  if(!istrue(var_0) && self._id_9A54) {}

  var_1 = self._id_8C9B;
  self._id_8C9B = self _meth_846A();

  if(!istrue(var_1) && self._id_8C9B) {}

  var_2 = self getstance();

  if(var_2 != self._id_9054) {
    if(self._id_9054 == "crouch") {
      var_3 = self._id_9055;
      var_4 = (gettime() - var_3) / 1000;
      _id_7DAE("timeCrouched", var_4);
    }

    if(self._id_9054 == "prone") {
      var_3 = self._id_9055;
      var_4 = (gettime() - var_3) / 1000;
      _id_7DAE("timeProne", var_4);
    }

    self._id_9055 = gettime();

    if(!isDefined(self.pers["stanceTracking"])) {
      self.pers["stanceTracking"] = [];
      self.pers["stanceTracking"]["prone"] = 0;
      self.pers["stanceTracking"]["crouch"] = 0;
      self.pers["stanceTracking"]["stand"] = 0;
    }

    if(var_2 == "prone" || var_2 == "crouch" || var_2 == "stand") {
      self.pers["stanceTracking"][var_2]++;
    }
  }

  self._id_9056[var_2] = gettime();
  self._id_9054 = var_2;
}

_id_BB7B(var_0) {}

_id_8EE6(var_0) {}

_id_10316(var_0) {}

_id_9F6E(var_0) {
  thread _id_F425(var_0);
}

_id_F425(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0._id_10E15 = [];

  for(;;) {
    var_1 = scripts\common\utility::_id_B7C7(var_0.origin, 220);

    foreach(var_3 in var_1) {
      if(isDefined(var_0.owner) && var_3 == var_0.owner) {
        continue;
      }
      _id_9F81(var_3, var_0);
      var_0._id_10E15[var_3.guid] = 1;
    }

    wait 0.1;
  }
}

_id_9F81(var_0, var_1) {}

_id_2635(var_0) {
  var_1 = 0;
  var_2 = 0;

  if(!var_1) {
    var_3 = scripts\cp\utility::_id_6C5F(var_0.origin, 600);

    foreach(var_5 in var_3) {
      if(var_5.team != var_0.team) {
        var_2 = 1;
        break;
      }
    }
  }

  if(var_1) {
    var_0 thread _id_0709::_id_6FB9("mode_sd_last_defuse");
  } else {
    var_0 thread _id_0709::_id_6FB9("mode_sd_defuse");
  }

  var_0 _id_7DAE("defuses", 1);

  if(isPlayer(var_0)) {
    var_0 thread _id_0740::_id_9797("defuse", var_0.origin);
  }
}

_id_C7E1(var_0, var_1) {
  if(scripts\cp\utility::getgametype() == "cp_survival") {
    return;
  }
}

_id_4E60(var_0, var_1) {
  if(var_1) {
    var_0._id_8FC0 = gettime();
  }
}

_id_DA5E() {}

_id_DA61() {}

_id_8D83(var_0, var_1, var_2) {
  self endon("death_or_disconnect");

  if(!_id_0756::_id_CBFC(var_0)) {
    return;
  }
  if(!scripts\cp\utility::_id_871A() && isDefined(self._id_F389) && isDefined(self._id_9CC2)) {
    if(self._id_F389 >= self._id_9CC2) {
      return;
    }
  }

  if(!isDefined(self._id_8D82)) {
    self._id_8D82 = [];
  }

  foreach(var_4 in self._id_8D82) {
    if(var_4._id_CC02 == var_0) {
      return;
    }
  }

  var_6 = spawnStruct();
  var_6._id_CC02 = var_0;
  var_6._id_DC87 = istrue(var_1);
  var_6._id_BD27 = _id_0756::_id_6D0B(var_0);
  var_6._id_165D = _id_0756::_id_CBF9(var_0);
  var_6._id_BD68 = 0;
  var_6._id_BD67 = 0;
  var_6._id_4DAF = istrue(var_2);
  self._id_8D82[self._id_8D82.size] = var_6;
  self notify("killEventTextPopup");
  self endon("killEventTextPopup");
  waitframe();

  if(!isDefined(self._id_E41A)) {
    self._id_E41A = [];
  }

  foreach(var_4 in self._id_8D82) {
    _id_82E7(var_4);
  }

  self._id_8D82 = undefined;
  var_9 = 0;

  foreach(var_4 in self._id_E41A) {
    if(var_4._id_BD68) {
      continue;
    }
    if(!istrue(level._id_C4DB) && istrue(var_4._id_DC87) && (!var_9 || var_4._id_165D)) {
      var_9 = 1;
      thread scripts\cp\cp_hud_message::showsplash(var_4._id_CC02);
    }

    var_4._id_BD68 = 1;
  }

  foreach(var_4 in self._id_E41A) {
    if(var_4._id_BD67 || var_4._id_4DAF) {
      continue;
    }
    thread _id_0756::_id_CC00(var_4._id_CC02);
    var_4._id_BD67 = 1;
    wait(getdvarfloat("#x34b79232251f0b4ce", 0.25));
  }

  self._id_E41A = undefined;
}

_id_82E7(var_0) {
  if(self._id_E41A.size == 0) {
    self._id_E41A[self._id_E41A.size] = var_0;
    return;
  }

  foreach(var_2 in self._id_E41A) {
    if(var_2._id_CC02 == var_0._id_CC02) {
      return;
    }
  }

  for(var_4 = 0; var_4 < self._id_E41A.size; var_4++) {
    if(var_0._id_BD27 > self._id_E41A[var_4]._id_BD27) {
      self._id_E41A = scripts\engine\utility::_id_1BB3(self._id_E41A, var_0, var_4);
      return;
    }
  }

  self._id_E41A[self._id_E41A.size] = var_0;
}

_id_8257(var_0) {
  if(!isDefined(self.pers[var_0])) {
    self.pers[var_0] = 0;
  }
}

_id_6C29(var_0) {
  return self.pers[var_0];
}

_id_7DAE(var_0, var_1) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[var_0])) {
    self.pers[var_0] = self.pers[var_0] + var_1;
  }
}

_id_D550(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self._id_01A5 = var_0;
  self.pers["extrascore0"] = var_0;
}

_id_D551(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self._id_01A6 = var_0;
  self.pers["extrascore1"] = var_0;
}

_id_D552(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self._id_01A7 = var_0;
  self.pers["extrascore2"] = var_0;
}

_id_D553(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self._id_01A8 = var_0;
  self.pers["extrascore3"] = var_0;
}

getplayerdataloadoutgroup() {
  return "zmloadouts";
}

setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
}

_id_31BA() {
  return level.rankedmatch && !istrue(level.ignorescoring) && scripts\cp\utility::getgametype() != "infect";
}

_id_6D95(var_0) {
  if(_func_030C("mp", "LethalScorestreakStatItems", var_0)) {
    return "lethalScorestreakStats";
  }

  if(_func_030C("mp", "SupportScorestreakStatItems", var_0)) {
    return "supportScorestreakStats";
  }

  return undefined;
}

_id_56F2(var_0) {
  self._id_9FFB["execution"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 256;
  thread _id_0752::_id_7003("execution");
}

_id_7EB8() {
  self._id_8D7E = [];
  self._id_8D78 = [];
  self._id_8FFD = undefined;
  self._id_7120 = 0;
  self._id_42F6 = [];
  self._id_9000 = 0;
  self._id_8FFB = 0;
  self._id_C0F3 = 0;
  self._id_C0F1 = 0;
  self._id_0267 = 0;
  self._id_0157 = 0;
  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_death_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;
  self._id_F33C = [];
  self.guid = scripts\cp\utility\player::getuniqueid();
}

updateweaponspecifickillingblows(var_0, var_1, var_2, var_3) {
  if(!isPlayer(self) || !isDefined(var_1) || !isDefined(var_1.basename)) {
    return;
  }
  var_4 = var_1.basename;

  if(!isDefined(self.recentweaponkills)) {
    self.recentweaponkills = [];
  }

  if(!isDefined(self.recentweaponkills[var_4])) {
    self.recentweaponkills[var_4] = 0;
  }

  self.recentweaponkills[var_4]++;
  thread recentweaponkillmonitor(var_4, 0);

  if(!isDefined(self.consecutiveweaponkills)) {
    self.consecutiveweaponkills = [];
  }

  if(!isDefined(self.consecutiveweaponkills[var_4])) {
    self.consecutiveweaponkills[var_4] = 0;
  }

  self.consecutiveweaponkills[var_4]++;

  if(var_0 scripts\cp\utility::_id_8891(var_1, var_3, var_2, self)) {
    if(!isDefined(self.recentweaponcriticalkills)) {
      self.recentweaponcriticalkills = [];
    }

    if(!isDefined(self.recentweaponcriticalkills[var_4])) {
      self.recentweaponcriticalkills[var_4] = 0;
    }

    self.recentweaponcriticalkills[var_4]++;
    thread recentweaponkillmonitor(var_4, 1);
  }

  if(!isDefined(self.weapononeshotmultikills)) {
    self.weapononeshotmultikills = [];
  }

  if(!isDefined(self.weapononeshotmultikills[var_4])) {
    self.weapononeshotmultikills[var_4] = 0;
  }

  self.weapononeshotmultikills[var_4]++;
  thread weapononeshotmultikillmonitor(var_1, var_2);
}

recentweaponkillmonitor(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_2 = "recentWeaponKill_" + var_0;

  if(var_1) {
    var_2 = var_2 + "_critical";
  }

  self notify(var_2);
  self endon(var_2);
  wait 2;

  if(istrue(var_1)) {
    self.recentweaponcriticalkills[var_0] = 0;
  } else {
    self.recentweaponkills[var_0] = 0;
  }
}

weapononeshotmultikillmonitor(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_2 = var_0.basename;
  self notify("weaponOneShotMultikill_" + var_2);
  self endon("weaponOneShotMultikill_" + var_2);
  var_3 = 0.1;

  if(var_2 == "s4_splatterfest_zm") {
    var_3 = 0.15;
  }

  wait(var_3);

  if(self.weapononeshotmultikills[var_2] > 1) {
    _id_070F::createoneshotmultikillevent(self, var_0, self.weapononeshotmultikills[var_2], var_1);
  }

  self.weapononeshotmultikills[var_2] = 0;
}