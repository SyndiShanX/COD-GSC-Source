/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\_so_survival_chaos.gsc
***********************************************/

chaos_pre_preload() {
  var_0 = getDvar("mapname");

  if(issplitscreen() || getDvar("coop") == "1") {
    level.loadout_table = "sp/coop_" + var_0 + "_chaos_waves.csv";
  } else {
    level.loadout_table = "sp/" + var_0 + "_chaos_waves.csv";
  }
}

chaos_preload() {
  precachemodel("prop_dogtags_foe");
  precachemodel("prop_dogtags_friend");
  precacheshader("chaos_specialty_juiced");
  precacheshader("chaos_specialty_armorvest");
  precacheshader("chaos_bonus_points");
  precacheshader("chaos_bonus_combo");
  precacheshader("chaos_bonus_time");
  precacheshader("chaos_meter_1");
  precacheshader("chaos_meter_2");
  precacheshader("chaos_meter_3");
  precacheshader("chaos_meter_4");
  precacheshader("chaos_meter_5");
  precacheshader("chaos_meter_6");
  precacheshader("chaos_meter_7");
  precacheshader("chaos_meter_8");
  precacheshader("chaos_meter_9");
  precacheshader("chaos_meter_10");
  precacheshader("chaos_meter_11");
  precacheshader("chaos_meter_12");
  precacheshader("chaos_meter_13");
  precacheshader("chaos_meter_14");
  precacheshader("chaos_meter_15");
  precacheshader("chaos_meter_16");
  precacheshader("chaos_frozen_meter");
  precacheitem("chaos_freeze_meter");
  precacheshader("chaos_bonus_freeze_meter");
  precacheshader("chaos_bonus_sentry_gun");
  precacheshader("chaos_bonus_laststand");
  precacheshader("combathigh_overlay");
  precachestring(&"SO_SURVIVAL_CHAOS_EASY_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_PLUS_SIGN");
  precachestring(&"SO_SURVIVAL_CHAOS_EMPTY");
  precachestring(&"SO_SURVIVAL_CHAOS_DOG_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_EXP_DOG");
  precachestring(&"SO_SURVIVAL_CHAOS_SUICIDE_BOMBER");
  precachestring(&"SO_SURVIVAL_CHAOS_CHEMICAL_CORPS");
  precachestring(&"SO_SURVIVAL_CHAOS_CLAYMORE_CORPS");
  precachestring(&"SO_SURVIVAL_CHAOS_REG_JUG");
  precachestring(&"SO_SURVIVAL_CHAOS_EXP_JUG");
  precachestring(&"SO_SURVIVAL_CHAOS_SHIELD_JUG");
  precachestring(&"SO_SURVIVAL_CHAOS_MINIGUN_JUG");
  precachestring(&"SO_SURVIVAL_CHAOS_DES_CHOPPER");
  precachestring(&"SO_SURVIVAL_CHAOS_REGULAR_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_HARDENED_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_VETERAN_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_ELITE_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_STAB");
  precachestring(&"SO_SURVIVAL_CHAOS_HEAD_SHOT");
  precachestring(&"SO_SURVIVAL_CHAOS_EXPLOSION");
  precachestring(&"SO_SURVIVAL_CHAOS_GRENADE");
  precachestring(&"SO_SURVIVAL_CHAOS_EXECUTION");
  precachestring(&"SO_SURVIVAL_CHAOS_TRIPLE_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_QUAD_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_MULTI_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_LONG_SHOT");
  precachestring(&"SO_SURVIVAL_CHAOS_TRIPLE_HEADSHOT");
  precachestring(&"SO_SURVIVAL_CHAOS_TRIPLE_KNIFE_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_TRIPLE_LONGSHOT");
  precachestring(&"SO_SURVIVAL_CHAOS_MASSIVE_EXPLOSION");
  precachestring(&"SO_SURVIVAL_CHAOS_DOG_TAGS");
  precachestring(&"SO_SURVIVAL_CHAOS_NEW_WEAPON");
  precachestring(&"SO_SURVIVAL_CHAOS_BONUS_SCORE");
  precachestring(&"SO_SURVIVAL_CHAOS_CARE_PACKAGE");
  precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_FINAL_STAND");
  precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_DEMO_MAN");
  precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_LONG_SHOOTER");
  precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_HEAD_HUNTER");
  precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_SLASHER");
  precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_TRIPLE_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_QUAD_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_MULTI_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_ACR");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_CLAYMORE");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_C4");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_FLASH");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_1887");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_AA12");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_AK47");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_AS50");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_CM901");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_FAD");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_FMG9");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_G18");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_MG36");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_G36");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_M16");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_M4");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_M60");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_M9");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_MK14");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_MK46");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_MP5");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_MP7");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_MP9");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_PP90");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_P90");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_PECHENEG");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_RSASS");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_SA80");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_SCAR");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_SKORPION");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_STRIKER");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_TYPE95");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_USP45");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_UMP45");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_USAS12");
  precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_RPG");
  precachestring(&"SO_SURVIVAL_CHAOS_HIGHEST_COMBO");
  precachestring(&"SO_SURVIVAL_CHAOS_BONUS_POINT");
  precachestring(&"SO_SURVIVAL_CHAOS_BONUS_MULTIPLIER");
  precachestring(&"SO_SURVIVAL_CHAOS_BONUS_TIME");
  precachestring(&"SO_SURVIVAL_CHAOS_BONUS_LASTSTAND");
  precachestring(&"SO_SURVIVAL_CHAOS_BONUS_FREEZE_METER");
  precachestring(&"SO_SURVIVAL_CHAOS_BONUS_SENTRY");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_CHOPPER");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_EXP_JUG");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_MUL_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_TRI_LONGSHOT");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_TRI_KNIFE");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_TRI_HEADSHOT");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_MASSIVE_EXP");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_QUAD_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_SHIELD_JUG");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_TRI_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_REG_JUG");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_NEW_WEAPON");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_GRENADE");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_CHEMICAL");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_ELITE");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_VETERAN");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_EXECUTION");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_HARDENED");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_EXP_DOG");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_MARTYRDOM");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_LONG_SHOT");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_KNIFE");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_EXP_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_REG_KILL");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_REG_DOG");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_EASY");
  precachestring(&"SO_SURVIVAL_CHAOS_EOG_HEADSHOT");
  maps\_so_survival_chaos_entities::chaos_entities_precache();
  maps\_so_survival_chaos_entities::chaos_load_drop_location();
  maps\_so_survival_chaos_entities::chaos_load_drop_item();
  maps\_so_survival_chaos_entities::chaos_load_desired_drop_distance();
  maps\_so_survival_chaos_entities::chaos_load_ai_size();
}

chaos_postload() {
  var_0 = getDvar("mapname");

  if(issplitscreen() || getDvar("coop") == "1") {
    level.wave_table = "sp/coop_" + var_0 + "_chaos_waves.csv";
  } else {
    level.wave_table = "sp/" + var_0 + "_chaos_waves.csv";
  }
  add_chaos_killstreak("bonus_score");
  add_chaos_killstreak("bonus_multiplier");
  add_chaos_killstreak("bonus_time");
  add_chaos_killstreak("bonus_laststand");
  add_chaos_killstreak("bonus_freezemeter");
}

add_chaos_killstreak(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;

  if(issubstr(var_0, "bonus_")) {
    var_1 = "airdrop_marker_mp";
    var_2 = _id_0611::_id_3CFD;
    var_10 = "SP_KILLSTREAKS_REWARDNAME_AIRDROP";
    var_3 = "UK_1mc_achieve_carepackage";
    var_4 = "UK_1mc_use_carepackage";
    var_5 = "specialty_carepackage";
    var_6 = &"SP_KILLSTREAKS_EARNED_AIRDROP";

    switch (var_0) {
      case "bonus_score":
        var_9 = ::sp_killstreak_bonus_score_crateopen;
        var_7 = "chaos_bonus_points";
        var_11 = &"SO_SURVIVAL_CHAOS_BONUS_POINT";
        break;
      case "bonus_multiplier":
        var_9 = ::sp_killstreak_bonus_multiplier_crateopen;
        var_7 = "chaos_bonus_combo";
        var_11 = &"SO_SURVIVAL_CHAOS_BONUS_MULTIPLIER";
        break;
      case "bonus_time":
        var_9 = ::sp_killstreak_bonus_time_crateopen;
        var_7 = "chaos_bonus_time";
        var_11 = &"SO_SURVIVAL_CHAOS_BONUS_TIME";
        break;
      case "bonus_laststand":
        var_9 = ::sp_killstreak_bonus_laststand_crateopen;
        var_7 = "chaos_bonus_laststand";
        var_11 = &"SO_SURVIVAL_CHAOS_BONUS_LASTSTAND";
        break;
      case "bonus_freezemeter":
        var_9 = ::sp_killstreak_bonus_freezemeter_crateopen;
        var_7 = "chaos_bonus_freeze_meter";
        var_11 = &"SO_SURVIVAL_CHAOS_BONUS_FREEZE_METER";
        break;
      default:
        return;
    }
  } else {}

  var_12 = spawnStruct();
  var_12.streaktype = var_0;
  var_12.weaponname = var_1;
  var_12._id_3CE9 = var_2;
  var_12._id_3CEA = var_10;
  var_12._id_3CEB = var_3;
  var_12._id_3CEC = var_4;
  var_12._id_3CED = var_5;
  var_12._id_3CEE = var_6;
  var_12._id_3BC5 = var_7;
  var_12._id_3BC6 = var_8;
  var_12._id_3BBE = var_9;
  var_12.cratehudstring = var_11;
  level._id_3CE3._id_3CE4[var_0] = var_12;
  _id_0611::_id_3CEF(var_3, var_4);
}

chaos_init() {
  level.perk_offset = 60;
  thread chaos_hud_survival_remove();
  thread chaos_ai_setup();
  thread chaos_armories_disable();
  thread chaos_score_init();
  thread chaos_players_setup();
  level.chaos_time_remaining = 120;
  thread chaos_timer_create(120, "start_survival", "win_survival");
  thread chaos_music_intro();
  thread maps\_so_survival_chaos_entities::chaos_entities_place();
  level._id_16BD = ::chaos_eog_summary;
  level.start_combo_decay = 0;
  level.timer_started = 0;
  level.player_currently_getting_perk = 0;
  level._id_3BBA = 0;
  level.freeze_combo_meter = 0;
  level._id_1312 = 0;
  var_0 = _id_0611::_id_3BC4("sentry");
  var_0.cratehudstring = &"SO_SURVIVAL_CHAOS_BONUS_SENTRY";
  var_0._id_3BC5 = "chaos_bonus_sentry_gun";
  var_0._id_3CE9 = ::chaos_killstreak_autosentry_main;
  level._id_3CE3._id_3CE4["sentry"] = var_0;
  level.grnd_fx["smoke"] = loadfx("smoke/airdrop_flare_mp_effect_now");
  level._id_3D47 = [];
  level._id_3D47 = chaos_wave_populate();
  level.focus_on_player = 0;
}

chaos_wave_populate() {
  var_0 = 0;
  var_1 = 1000;
  var_2 = [];

  for(var_3 = var_0; var_3 <= var_1; var_3++) {
    var_4 = _id_061C::_id_3E02(var_3);

    if(!isDefined(var_4) || var_4 == 0) {
      continue;
    }
    var_5 = spawnStruct();
    var_5._id_3D4A = var_3;
    var_5._id_1E2E = var_4;
    var_5._id_3D4B = _id_061C::_id_3E03(var_4);
    var_5._id_3D4C = _id_061C::_id_3E04(var_4);
    var_5._id_3D4D = _id_061C::_id_3E05(var_4);
    var_5._id_3D4E = _id_061C::_id_3E06(var_4);
    var_5._id_3D4F = _id_061C::_id_3E00(var_4);
    var_5._id_3D50 = _id_061C::_id_3E08(var_4);
    var_5._id_3D51 = _id_061C::_id_3E09(var_4);
    var_5._id_3D52 = _id_061C::_id_3E0C(var_4);
    var_5._id_3D53 = _id_061C::_id_3E0D(var_4);
    var_5._id_3D54 = _id_061C::_id_3E0A(var_4);
    var_6 = _id_061C::_id_3E0B(var_4);

    if(isDefined(var_6) && var_6.size) {
      if(!isDefined(level._id_3D55)) {
        level._id_3D55 = [];
      }
      foreach(var_8 in var_6) {}
      level._id_3D55[var_8] = var_4;
    }

    var_2[var_4] = var_5;

    if(var_5._id_3D54) {
      level._id_3D45[level._id_3D45.size] = var_5;
    }
  }

  return var_2;
}

chaos_players_setup() {
  common_scripts\utility::array_thread(level.players, ::chaos_player_infinite_ammo_pistol);

  foreach(var_1 in level.players) {
    var_1 thread hud_weapon_icon();
    var_1 thread live_1_hud_icon();
    var_1 thread live_2_hud_icon();
    var_1 thread live_3_hud_icon();
    var_1 thread live_4_hud_icon();
    var_1 thread live_5_hud_icon();
    var_1 thread manage_lives_left_hud();
    var_1 thread perk_hud_2();
    var_1 thread perk_hud_3();
    var_1 thread perk_hud_4();
    var_1 thread perk_hud_5();
    var_1 thread perk_hud_6();
    var_1 thread perk_hud_7();
    var_1 thread perk_hud_popup_icon();
    var_1 thread wait_for_death();
    var_1 thread listen_for_sentry_notification();
    var_1 thread listen_for_laststand_notification();

    if(maps\_utility::_id_12C1()) {
      var_1 thread wait_for_revive_teammate();
    }
    var_1.num_perk_obtained = 0;
    var_1.recentkillcount = 0;
    var_1.recentheadshotcount = 0;
    var_1.recentknifekillcount = 0;
    var_1.recentlongshotcount = 0;
    var_1.recentrocketkillcount = 0;
    var_1.justopencrate = 0;
    var_1._id_3B21 = 1;
    var_1._id_132B._id_1A53 = level.map_specific_starting_lives_remaining - 1;
    var_1.action_streak = [];
    var_1.hud_chaoseventpopup = var_1 createchaoseventpopup();
    var_1.hud_chaosscorepopup = var_1 createchaosscorepopup();
  }

  thread chaos_players_performance();
}

listen_for_sentry_notification() {
  level endon("special_op_terminated");

  for(;;) {
    self waittill("sentry_notification", var_0);

    if(!isDefined(var_0)) {
      self.hud_chaoseventpopup settext("");
      self.hud_chaoseventpopup.alpha = 0;
      continue;
    }

    self.hud_chaoseventpopup settext(var_0);
    self.hud_chaoseventpopup.color = (1, 1, 1);
    self.hud_chaoseventpopup.alpha = 0.85;
  }
}

listen_for_laststand_notification() {
  level endon("special_op_terminated");

  for(;;) {
    self waittill("laststand_notification", var_0);

    if(var_0 == &"SCRIPT_COOP_BLEEDING_OUT_PARTNER") {
      chaoseventpopup(var_0, (1, 0.4, 0.4), 0, 3.0);
      continue;
    }

    chaoseventpopup(var_0, (1, 1, 1));
  }
}

chaos_players_performance() {
  while(!isDefined(level.player._id_18D3)) {
    wait 0.05;
  }
  foreach(var_1 in level.players) {
    var_1._id_18D3["headshot"] = 0;
    var_1._id_18D3["knife_kill"] = 0;
    var_1._id_18D3["long_shot"] = 0;
    var_1._id_18D3["triple_kill"] = 0;
    var_1._id_18D3["quad_kill"] = 0;
    var_1._id_18D3["multi_kill"] = 0;
    var_1._id_18D3["new_weapon_collected"] = 0;
    var_1._id_18D3["comboscoremax"] = 0;
    var_1._id_18D3["combomultmax"] = 0;
    var_1._id_18D3["explosive_jug"] = 0;
    var_1._id_18D3["triple_headshot"] = 0;
    var_1._id_18D3["triple_knife_kill"] = 0;
    var_1._id_18D3["triple_long_shot"] = 0;
    var_1._id_18D3["massive_explosion"] = 0;
    var_1._id_18D3["riot_shield_jug"] = 0;
    var_1._id_18D3["regular_jug"] = 0;
    var_1._id_18D3["grenade_kill"] = 0;
    var_1._id_18D3["chemical_kill"] = 0;
    var_1._id_18D3["elite_kill"] = 0;
    var_1._id_18D3["veteran_kill"] = 0;
    var_1._id_18D3["execution"] = 0;
    var_1._id_18D3["hardened_kill"] = 0;
    var_1._id_18D3["explosive_dog"] = 0;
    var_1._id_18D3["martyrdom_kill"] = 0;
    var_1._id_18D3["explosive_kill"] = 0;
    var_1._id_18D3["regular_kill"] = 0;
    var_1._id_18D3["regular_dog"] = 0;
    var_1._id_18D3["easy_kill"] = 0;
    var_1._id_18D3["chopper_kill"] = 0;
  }
}

chaos_score_init() {
  chaos_combo_system_setup();
  chaos_score_event_populate();
  chaos_register_perk_progression();
  thread chaos_score_event_creators();
}

chaos_register_perk_progression() {
  level.chaos_perk_progression = [];
  level.perk_progression_gap = 10;
  add_perk_progression(10, "specialty_fastreload");
  add_perk_progression(20, "specialty_quickdraw");
  add_perk_progression(30, "specialty_longersprint");
  add_perk_progression(40, "specialty_stalker");
  add_perk_progression(50, "specialty_bulletaccuracy");
  add_perk_progression(60, "specialty_armorvest");
  add_perk_progression(70, "specialty_juiced");
}

add_perk_progression(var_0, var_1) {
  var_2 = "combo_" + var_0;
  level.chaos_perk_progression[var_2] = var_1;
}

chaos_score_event_populate() {
  if(!isDefined(level.chaos_score_events)) {
    level.chaos_score_events = [];
  }
  chaos_score_event_add("damage", 0, 0);
  chaos_score_event_add("damage_flash", 0, 0);
  chaos_score_event_add("damage_grenade", 0, 50);
  chaos_score_event_add("damage_explosive", 0, 250);
  chaos_score_event_add("damage_hipfire", 0, 0);
  chaos_score_event_add("dog_reg_kill", 1, 100, &"SO_SURVIVAL_CHAOS_DOG_KILL");
  chaos_score_event_add("dog_splode_kill", 1, 150, &"SO_SURVIVAL_CHAOS_EXP_DOG");
  chaos_score_event_add("martyrdom_kill", 1, 150, &"SO_SURVIVAL_CHAOS_SUICIDE_BOMBER");
  chaos_score_event_add("chemical_kill", 1, 300, &"SO_SURVIVAL_CHAOS_CHEMICAL_CORPS");
  chaos_score_event_add("claymore_kill", 1, 200, &"SO_SURVIVAL_CHAOS_CLAYMORE_CORPS");
  chaos_score_event_add("jug_regular_kill", 1, 500, &"SO_SURVIVAL_CHAOS_REG_JUG");
  chaos_score_event_add("jug_explosive_kill", 1, 1000, &"SO_SURVIVAL_CHAOS_EXP_JUG");
  chaos_score_event_add("jug_riotshield_kill", 1, 750, &"SO_SURVIVAL_CHAOS_SHIELD_JUG");
  chaos_score_event_add("jug_minigun_kill", 1, 1250, &"SO_SURVIVAL_CHAOS_MINIGUN_JUG");
  chaos_score_event_add("chopper_kill", 1, 2000, &"SO_SURVIVAL_CHAOS_DES_CHOPPER");
  chaos_score_event_add("easy_kill", 1, 50, &"SO_SURVIVAL_CHAOS_EASY_KILL");
  chaos_score_event_add("regular_kill", 1, 100, &"SO_SURVIVAL_CHAOS_REGULAR_KILL");
  chaos_score_event_add("hardened_kill", 1, 150, &"SO_SURVIVAL_CHAOS_HARDENED_KILL");
  chaos_score_event_add("veteran_kill", 1, 200, &"SO_SURVIVAL_CHAOS_VETERAN_KILL");
  chaos_score_event_add("elite_kill", 1, 250, &"SO_SURVIVAL_CHAOS_ELITE_KILL");
  chaos_score_event_add("kill_knife", 1, 150, &"SO_SURVIVAL_CHAOS_STAB");
  chaos_score_event_add("kill_headshot", 1, 300, &"SO_SURVIVAL_CHAOS_HEAD_SHOT");
  chaos_score_event_add("kill_explosive", 1, 150, &"SO_SURVIVAL_CHAOS_EXPLOSION");
  chaos_score_event_add("kill_grenade", 1, 400, &"SO_SURVIVAL_CHAOS_GRENADE");
  chaos_score_event_add("kill_execution", 1, 200, &"SO_SURVIVAL_CHAOS_EXECUTION");
  chaos_score_event_add("kill_triple", 1, 600, &"SO_SURVIVAL_CHAOS_TRIPLE_KILL");
  chaos_score_event_add("kill_quad", 1, 800, &"SO_SURVIVAL_CHAOS_QUAD_KILL");
  chaos_score_event_add("kill_multi", 1, 1000, &"SO_SURVIVAL_CHAOS_MULTI_KILL");
  chaos_score_event_add("kill_longshot", 1, 150, &"SO_SURVIVAL_CHAOS_LONG_SHOT");
  chaos_score_event_add("headshot_triple", 1, 1000, &"SO_SURVIVAL_CHAOS_TRIPLE_HEADSHOT");
  chaos_score_event_add("knife_triple", 1, 1000, &"SO_SURVIVAL_CHAOS_TRIPLE_KNIFE_KILL");
  chaos_score_event_add("longshot_triple", 1, 1000, &"SO_SURVIVAL_CHAOS_TRIPLE_LONGSHOT");
  chaos_score_event_add("massive_explosion", 1, 2000, &"SO_SURVIVAL_CHAOS_MASSIVE_EXPLOSION");
  chaos_score_event_add("dogtag", 1, 0, &"SO_SURVIVAL_CHAOS_DOG_TAGS");
  chaos_score_event_add("new_weapon_collect", 1, 500, &"SO_SURVIVAL_CHAOS_NEW_WEAPON");
  chaos_score_event_add("old_weapon_collect", 1, 0, "Old Weapon");
  chaos_score_event_add("placed_sentry", 1, 0, "Placed Sentry");
  chaos_score_event_add("revive_teammate", 1, 0, "Revived Teammate");
  chaos_score_event_add("weapon_ammo", 0, 0);
  chaos_score_event_add("bonus_score", 1, 5000, &"SO_SURVIVAL_CHAOS_BONUS_SCORE");
  chaos_score_event_add("bonus_multiplier", 0, 0, "Bonus Combo");
  chaos_score_event_add("care_package", 1, 500, &"SO_SURVIVAL_CHAOS_CARE_PACKAGE");
}

chaos_score_event_add(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(var_1 && !isDefined(var_3)) {}

  if(!isDefined(var_3)) {
    var_3 = "";
  }
  if(!isDefined(var_2)) {
    var_2 = 100;
  }
  level.chaos_score_events[var_0] = [];
  level.chaos_score_events[var_0]["combo"] = var_1;
  level.chaos_score_events[var_0]["points"] = var_2;
  level.chaos_score_events[var_0]["name"] = var_3;
}

chaos_combo_system_setup() {
  common_scripts\utility::flag_init("chaos_players_in_combo");
  chaos_score_globals_init();
  chaos_combo_globals_init();
  common_scripts\utility::array_thread(level.players, ::chaos_combo_player_create_hud);
  level thread chaos_combo_all_hud_destroy();
  chaos_combo_bar_set_fill(0.0);
  chaos_combo_bar_hide(1);
}

chaos_combo_globals_init() {
  level.chaos_combo_running = 0;
  level.chaos_combo_points = 0;
  level.chaos_combo_count = 0;
  level.chaos_combo_actions = [];
  level.chaos_combo_actions_max = 5;
}

chaos_combo_globals_reset() {
  chaos_combo_globals_init();
}

chaos_wave() {
  level endon("special_op_terminated");

  foreach(var_1 in level.chaos_entities) {
    foreach(var_3 in level.players) {}
    var_1.headiconforplayer[var_3.unique_id] = undefined;
  }

  level thread updateweaponheadiconforplayer();
  level._id_3C68["sentry_minigun"].health = 4000;

  if(issplitscreen()) {
    level._id_1A55 = -60;
  } else {
    level._id_1A55 = 10;
  }
  maps\_so_survival::_id_3F80();
  thread maps\_so_survival::_id_3FB6();
  maps\_so_survival::_id_3F70();

  if(!common_scripts\utility::flag("start_survival")) {
    common_scripts\utility::flag_set("start_survival");
  }
  level notify("wave_started", level._id_17F6);
  level.before_first_wave = 0;
  setsaveddvar("bg_viewKickScale", "0.2");
  level thread maps\_so_survival::_id_3F82();

  foreach(var_3 in level.players) {
    var_3._id_3FC9.icon thread chaos_perk_icon_destroy_on_mode_end();
    var_3 thread wait_and_display_lives_left_hud();
  }

  var_8 = 0;

  if(!isDefined(level._id_3BAF)) {
    level._id_3BAF = [];
  }
  for(;;) {
    var_9 = "wave_" + level._id_17F6;

    if(isDefined(level.chaos_drop_items[var_9]) && level._id_3BAF.size < 4) {
      if(maps\_utility::_id_12C1()) {
        var_10 = 4 - level._id_3BAF.size;

        if(var_10 > 1) {
          thread chaos_package_drop(2, level.player.origin);
        } else {
          thread chaos_package_drop(1, level.player.origin);
        }
      } else {
        thread chaos_package_drop(1, level.player.origin);
      }
    }

    if(isDefined(level._id_3B70.size) && level._id_3B70.size >= 3) {}

    var_11 = _id_061C::_id_3E04(level._id_17F6);

    if(var_11[0] == 0) {
      level._id_17F6--;
      var_11 = _id_061C::_id_3E04(level._id_17F6);
    }

    var_12 = 0;
    var_13 = _id_061C::_id_3E03(level._id_17F6);
    level.regular_ai_spawned_in = 0;

    foreach(var_15 in var_11) {
      if(var_15 > 0) {
        var_12 = var_12 + chaos_spawn_wave(1, var_15, var_13);
      }
    }

    level._id_3D71 = [];
    var_17 = _id_061C::_id_3E05(level._id_17F6);

    if(isDefined(var_17)) {
      foreach(var_19 in var_17) {
        if(issubstr(var_19, "dog")) {
          thread chaos_spawn_dogs(var_19, _id_061C::_id_3E0D(level._id_17F6), level._id_17F6);
          var_20 = undefined;

          if(_id_061C::_id_3E0D(level._id_17F6) > 1) {
            var_20 = "so_hq_enemy_intel_dogs";
          } else {
            var_20 = "so_hq_enemy_intel_dog";
          }
          maps\_utility::_id_11F4(var_20);
          continue;
        }

        var_21 = _id_061C::_id_3E07(level._id_17F6, var_19);

        if(isDefined(var_21) && var_21 > 0) {
          var_22 = maps\_so_survival::_id_3F8C(var_19, var_21);
        }
      }
    }

    if(isDefined(level._id_3D71)) {}

    if(maps\_so_survival::_id_3F8F(level._id_17F6)) {
      thread maps\_so_survival::_id_3F90();
    }
    wait 3.0;
    common_scripts\utility::flag_set("aggressive_mode");
    _id_0610::_id_3B72(0, _id_061C::_id_3D79);
    var_24 = getaiarray("axis").size + _id_061C::_id_3DC3();

    if(isDefined(level.map_specific_ai_size[var_9])) {
      var_8 = level.map_specific_ai_size[var_9];
    }
    while(var_24 > var_8) {
      level common_scripts\utility::waittill_any_timeout(1.0, "axis_died");
      var_24 = getaiarray("axis").size + _id_061C::_id_3DC3();
    }

    var_25 = level._id_17F6 + 1;
    var_26 = 0;
    var_27 = [];
    var_27 = _id_061C::_id_3E04(var_25);

    foreach(var_29 in var_27) {}
    var_26 = var_26 + var_29;

    var_31 = _id_061C::_id_3E05(var_25);

    if(isDefined(var_31)) {
      foreach(var_33 in var_31) {
        if(issubstr(var_33, "dog")) {
          var_26 = var_26 + _id_061C::_id_3E0D(var_25);
          continue;
        }

        var_26 = var_26 + _id_061C::_id_3E07(var_25, var_33);
      }
    }

    if(maps\_so_survival::_id_3F8F(var_25)) {
      if(isDefined(_id_061C::_id_3E08(var_25))) {
        var_26 = var_26 + _id_061C::_id_3E08(var_25).size;
      }
      if(isDefined(_id_061C::_id_3E09(var_25))) {
        var_26 = var_26 + _id_061C::_id_3E09(var_25).size;
      }
    }

    var_24 = getaiarray("axis").size + _id_061C::_id_3DC3();

    if(var_24 + var_26 > 25) {
      while(var_24 + var_26 > 25) {
        level common_scripts\utility::waittill_any_timeout(1.0, "axis_died");
        var_24 = getaiarray("axis").size + _id_061C::_id_3DC3();
      }
    }

    var_35 = getfreeaicount();

    if(var_26 > var_35) {
      while(var_26 > var_35) {
        level common_scripts\utility::waittill_any_timeout(1.0, "axis_died");
        var_35 = getfreeaicount();
      }
    }

    level._id_3B85 = _id_061C::_id_3D72;
    level._id_3D48 = _id_061C::_id_3D72;

    if(maps\_so_survival::_id_3F8F(level._id_17F6)) {
      common_scripts\utility::flag_wait("bosses_spawned");
    }
    if(common_scripts\utility::flag("boss_music")) {
      level notify("end_boss_music");
      common_scripts\utility::flag_clear("boss_music");
      maps\_utility::_id_1427(3);
    }

    level._id_17F6++;
  }
}

chaos_spawn_dogs(var_0, var_1, var_2) {
  level endon("special_op_terminated");
  level endon("wave_ended");

  if(!isDefined(var_0) || var_0 == "" || !isDefined(var_1) || !var_1) {
    return;
  }
  level._id_3DBB = [];
  var_3 = [];

  foreach(var_5 in level.players) {}
  var_3[var_3.size] = var_5;

  var_7 = getEntArray("dog_spawner", "targetname")[0];
  level._id_3DBC = isDefined(var_0) && var_0 == "dog_splode";
  var_7 maps\_utility::add_spawn_function(_id_061C::_id_3DC0);
  var_7 maps\_utility::add_spawn_function(_id_061C::_id_3DC2);
  var_7 maps\_utility::add_spawn_function(_id_061C::_id_3DC1);

  for(var_8 = 0; var_8 < var_1; var_8++) {
    var_9 = _id_0618::_id_3DBE(level._id_3DBD, var_3, 4);
    var_7.count = 1;
    var_7.origin = var_9.origin;
    var_7.angles = var_9.angles;
    var_10 = int((40 + randomint(10)) / var_1);
    level._id_3DBF = 1;
    var_11 = var_7 maps\_utility::_id_166F();

    if(isDefined(var_11)) {
      var_11._id_3D5D = _id_061C::_id_3DF4(var_0);
      var_11 setthreatbiasgroup("dogs");
      var_11[[level._id_3B89]]();
      var_11.canclimbladders = 0;
      level._id_3DBB[level._id_3DBB.size] = var_11;
    }

    level._id_3DBF = undefined;

    if(!common_scripts\utility::flag("aggressive_mode")) {
      common_scripts\utility::waittill_any_timeout(var_10, "aggressive_mode");
    }
    wait 0.05;
  }
}

chaos_spawn_wave(var_0, var_1, var_2) {
  level endon("special_op_terminated");

  for(var_0 = int(var_0); var_0; var_0--) {
    var_3 = spawn_chaos_squad(level._id_3DBD, maps\_so_survival::_id_3F8B("leader"), maps\_so_survival::_id_3F8B("follower"), var_1 - 1);

    foreach(var_5 in var_3) {
      var_5.chaos_squad_type = var_2;
      var_5 setthreatbiasgroup("axis");
      var_5 thread _id_061C::_id_3DE9();
    }
  }

  return level._id_3B70.size;
}

spawn_chaos_squad(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(maps\_utility::_id_12C1()) {
    if(level.focus_on_player == 0) {
      var_4 = level.players[0];
      level.focus_on_player = 1;
    } else {
      var_4 = level.players[1];
      level.focus_on_player = 0;
    }
  } else {
    var_4 = level.player;
  }
  var_5 = var_0.size;

  for(;;) {
    var_6 = 0;

    for(var_7 = 1; var_7 < var_5; var_7++) {
      var_8 = vectornormalize(anglesToForward(var_4 getplayerangles()));
      var_9 = vectornormalize(var_0[var_7 - 1].origin - var_4 getEye());
      var_10 = vectordot(var_8, var_9);
      var_11 = vectornormalize(var_0[var_7].origin - var_4 getEye());
      var_12 = vectordot(var_8, var_11);

      if(var_10 < var_12) {
        var_13 = var_0[var_7 - 1];
        var_0[var_7 - 1] = var_0[var_7];
        var_0[var_7] = var_13;
        var_6 = 1;
      }
    }

    if(var_6 == 0) {
      break;
    }

    var_5 = var_5 - 1;
  }

  var_14 = int(var_0.size / 3);
  var_15 = [];

  for(var_7 = 0; var_7 < var_14; var_7++) {
    var_15[var_7] = var_0[var_7];
  }
  var_16 = [];
  var_16[var_16.size] = level.player;

  if(maps\_utility::_id_12C1()) {
    var_16[var_16.size] = level.players[1];
  }
  foreach(var_18 in level._id_3B70) {}
  var_16[var_16.size] = var_18;

  var_20 = undefined;

  while(var_15.size > 1) {
    foreach(var_22 in var_16) {
      var_20 = maps\_utility::_id_0AE9(var_22.origin, var_15);
      var_15 = common_scripts\utility::array_remove(var_15, var_20);

      if(var_15.size == 1) {
        break;
      }
    }
  }

  var_20 = var_15[0];

  if(isspawner(var_0[0])) {
    var_24 = getEntArray(var_20.target, "targetname");
  } else {
    var_24 = common_scripts\utility::getstructarray(var_20.target, "targetname");
  }
  var_24[var_24.size] = var_20;

  foreach(var_26 in var_24) {
    if(!isDefined(var_26.script_noteworthy)) {
      var_26.script_noteworthy = "follower";
    }
  }

  common_scripts\utility::flag_set("squad_spawning");
  var_28 = [];
  var_28 = _id_0610::_id_3B81(var_24, var_1, var_2, var_3);
  level.regular_ai_spawned_in = level.regular_ai_spawned_in + (var_3 + 1);
  common_scripts\utility::flag_clear("squad_spawning");
  wait 0.05;
  return var_28;
}

chaos_package_drop(var_0, var_1) {
  level endon("special_op_terminated");
  level.drop_location_sorted = [];
  level.drop_location_sorted = level.chaos_drop_locations;
  var_2 = level.drop_location_sorted.size;
  var_3 = level.map_specific_desired_drop_distance;

  for(;;) {
    var_4 = 0;

    for(var_5 = 1; var_5 < var_2; var_5++) {
      var_6 = distance(level.drop_location_sorted[var_5 - 1], var_1);
      var_7 = distance(level.drop_location_sorted[var_5], var_1);

      if(abs(var_6 - var_3) > abs(var_7 - var_3)) {
        var_8 = level.drop_location_sorted[var_5 - 1];
        level.drop_location_sorted[var_5 - 1] = level.drop_location_sorted[var_5];
        level.drop_location_sorted[var_5] = var_8;
        var_4 = 1;
      }
    }

    if(var_4 == 0) {
      break;
    }

    var_2 = var_2 - 1;
  }

  var_9 = "wave_" + level._id_17F6;

  for(var_5 = 0; var_5 < var_0; var_5++) {
    level thread generatesmokefx(level.drop_location_sorted[var_5]);
  }
  level _id_3BA9(var_0, level.player, level.drop_location_sorted[0], randomfloat(360), undefined, var_9);
}

_id_3BA9(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("special_op_terminated");
  var_6 = _id_0614::getflyheightoffset(var_2);

  if(!isDefined(var_4)) {
    var_4 = 0;
  }
  var_6 = var_6 + var_4;

  if(!isDefined(var_1)) {
    return;
  }
  var_7 = var_2 * (1, 1, 0) + (0, 0, var_6);
  var_8 = chaos_getpathstart(var_7, var_3);
  var_9 = chaos_getpathend(var_7, var_3);
  var_10 = _id_0614::_id_3BAA(var_1, var_8, var_7);
  var_10 endon("death");

  if(maps\_utility::_id_12C1()) {
    maps\_utility::_id_11F4("chaos_cps_inbound");
  } else {
    maps\_utility::_id_11F4("chaos_cp_inbound");
  }
  level.drop_item_used = [];

  for(var_11 = 0; var_11 < var_0; var_11++) {
    if(var_11 > 0) {
      var_3 = randomfloat(360);
      var_6 = _id_0614::getflyheightoffset(level.drop_location_sorted[var_11]);

      if(!isDefined(var_4)) {
        var_4 = 0;
      }
      var_6 = var_6 + var_4;
      var_7 = level.drop_location_sorted[var_11] * (1, 1, 0) + (0, 0, var_6);
      var_7 = var_7 + anglesToForward((0, var_3, 0)) * -50;
    }

    var_10 setvehgoalpos(var_7, 1);
    var_10 vehicle_setspeed(150, 80);
    var_10 setyawspeed(180, 180, 180, 0.3);
    var_12 = get_random_drop_item(var_5, var_0);

    if(var_12 == "bonus_laststand") {
      if(player_have_max_lives()) {
        var_12 = "bonus_score";
      }
    }

    var_10 thread _id_3BAB(var_12, level.drop_location_sorted[var_11], var_6, 0, undefined, var_8);
    wait 1;

    while(var_10 vehicle_getspeed() > 5) {
      wait 0.1;
    }
    var_10 notify("drop_crate");
    var_13 = undefined;

    switch (var_12) {
      case "bonus_score":
        var_13 = "chaos_deliverd_socre";
        break;
      case "sentry":
        var_13 = "chaos_deliverd_sentry";
        break;
      case "bonus_laststand":
        var_13 = "chaos_deliverd_laststand";
        break;
      case "bonus_multiplier":
        var_13 = "chaos_deliverd_combomult";
        break;
      case "bonus_time":
        var_13 = "chaos_deliverd_extratime";
        break;
      case "bonus_freezemeter":
        var_13 = "chaos_deliverd_freeze";
        break;
    }

    if(isDefined(var_13)) {
      maps\_utility::_id_11F4(var_13);
    }
  }

  var_10 setvehgoalpos(var_9, 1);
  var_10 vehicle_setspeed(300, 75);
  var_10.leaving = 1;
  var_10 waittill("goal");
  var_10 notify("leaving");
  var_10 notify("delete");
  var_10 delete();
}

chaos_score_event_raise(var_0, var_1) {
  if(level.timer_started == 0) {
    level notify("Start timer");
    level._id_16CF = gettime();
    level.timer_started = 1;
  }

  if(common_scripts\utility::flag("special_op_terminated")) {
    return;
  }
  if(!isDefined(level.chaos_score_events[var_0])) {
    return;
  }
  chaos_combo_update(level.chaos_score_events[var_0]["name"], level.chaos_score_events[var_0]["points"], level.chaos_score_events[var_0]["combo"], var_1);

  if(int(level.chaos_score_events[var_0]["points"]) > 0) {
    foreach(var_3 in level.players) {}
    var_3 thread chaosscorepopup("+" + level.chaos_score_events[var_0]["points"]);
  }
}

chaos_combo_actions_update(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.action_string = var_0;
  var_2.point = var_1;

  if(level.chaos_combo_actions.size < level.chaos_combo_actions_max) {
    level.chaos_combo_actions[level.chaos_combo_actions.size] = var_2;
  } else {
    for(var_3 = 0; var_3 < level.chaos_combo_actions.size - 1; var_3++) {
      level.chaos_combo_actions[var_3] = level.chaos_combo_actions[var_3 + 1];
    }
    level.chaos_combo_actions[level.chaos_combo_actions.size - 1] = var_2;
  }
}

chaos_combo_update(var_0, var_1, var_2, var_3) {
  if(!common_scripts\utility::flag("chaos_players_in_combo")) {
    common_scripts\utility::flag_set("chaos_players_in_combo");
  }
  level.chaos_combo_points = level.chaos_combo_points + var_1;

  if(level.chaos_combo_count == 0 || var_2) {
    level.chaos_combo_count++;
  }
  foreach(var_5 in level.players) {}
  var_5 notify("combo_update");

  if(var_2) {
    if(isDefined(var_3)) {
      common_scripts\utility::array_call(level.players, ::playlocalsound, var_3);
    } else {
      common_scripts\utility::array_call(level.players, ::playlocalsound, "Chaos_combo");
    }
    var_7 = "combo_" + level.chaos_combo_count;

    if(isDefined(level.chaos_perk_progression[var_7])) {
      var_8 = level.chaos_perk_progression[var_7];
      thread chaos_give_perk_possible_wait(var_8);
    }
  }

  if(isstring(var_0)) {
    var_9 = &"SO_SURVIVAL_CHAOS_PLUS_SIGN";
  } else {
    var_9 = var_0;
  }
  chaos_combo_display_update(var_9, var_1, level.chaos_combo_points, level.chaos_combo_count, var_2);

  if(level.start_combo_decay == 1) {
    thread chaos_combo_on_end(4.0, 0.2);
  }
}

chaos_give_perk_possible_wait(var_0) {
  level endon("special_op_terminated");

  foreach(var_2 in level.players) {}
  var_2 thread makecombomultiplyglowandpop();

  if(level.player_currently_getting_perk == 1) {
    level waittill("proceed_with_next_perk");
  }
  foreach(var_2 in level.players) {}
  var_2 chaos_give_perk(var_0);

  level thread chaos_perk_radio(var_0);
}

chaos_combo_on_end(var_0, var_1) {
  level endon("special_op_terminated");
  level notify("combo_bumped");
  level endon("combo_bumped");
  level endon("stop_meter_decay");

  if(level.freeze_combo_meter == 1) {
    chaos_combo_bar_set_fill(1.0);
    chaos_combo_bar_hide(0);
  } else {
    var_2 = var_0 * 1000;
    var_3 = gettime();
    var_4 = var_3 + var_2;

    for(var_5 = var_3; var_5 < var_4; var_5 = gettime()) {
      var_6 = 1.0 - (var_5 - var_3) / var_2;
      chaos_combo_bar_set_fill(var_6);
      chaos_combo_bar_hide(0);
      wait 0.05;
    }

    if(isDefined(var_1) && var_1 > 0.0) {
      wait(var_1);
    }
    chaos_running_score_update(level.chaos_combo_points, level.chaos_combo_count);
    common_scripts\utility::array_call(level.players, ::playlocalsound, "Chaos_lose_combo");

    foreach(var_8 in level.players) {
      var_8 clearperks();
      var_8._id_3FC9.icon.alpha = 0;
      var_8.perk_icon_hud_2.icon.alpha = 0;
      var_8.perk_icon_hud_3.icon.alpha = 0;
      var_8.perk_icon_hud_4.icon.alpha = 0;
      var_8.perk_icon_hud_5.icon.alpha = 0;
      var_8.perk_icon_hud_6.icon.alpha = 0;
      var_8.perk_icon_hud_7.icon.alpha = 0;
      var_8 unsetjuiced();
      var_8 notify("chaos_stop_extra_health_regen");
      var_8.num_perk_obtained = 0;
    }

    chaos_combo_bar_set_fill(0.0);
    chaos_combo_bar_hide(1);
    chaos_combo_globals_reset();
    chaos_combo_display_clear();
    common_scripts\utility::flag_clear("chaos_players_in_combo");
    thread recreate_last_stand_hud();
  }
}

chaos_running_score_update(var_0, var_1) {
  level notify("score_update_bump");
  level endon("score_update_bump");
  var_2 = var_0 * var_1;
  level.chaos_score = level.chaos_score + var_2;

  foreach(var_4 in level.players) {
    if(var_2 > var_4._id_18D3["comboscoremax"]) {
      var_4._id_18D3["comboscoremax"] = var_2;
    }
    if(var_1 > var_4._id_18D3["combomultmax"]) {
      var_4._id_18D3["combomultmax"] = var_1;
    }
    if(isDefined(var_4.chaos_score_hud)) {
      var_4.chaos_score_hud settext(format_good_looking_score(level.chaos_score));
    }
  }
}

chaos_score_event_creators() {
  maps\_utility::_id_1A5A("axis", ::chaos_score_on_ai_damage);
  maps\_utility::_id_1A5A("axis", ::chaos_score_on_ai_flashed);
  maps\_utility::_id_1A5A("axis", ::chaos_score_on_ai_death);
}

chaos_score_on_ai_damage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      chaos_score_event_raise("damage");
      continue;
    }

    if(!isPlayer(var_1)) {
      continue;
    }
    var_10 = "damage";

    if(isDefined(var_4)) {
      if(var_1 playerads() == 0 && var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET") {
        var_10 = "damage_hipfire";
      } else {
        switch (var_4) {
          case "MOD_EXPLOSIVE":
            var_10 = "damage_explosive";
            break;
          case "MOD_GRENADE_SPLASH":
          case "MOD_GRENADE":
            var_10 = "damage_grenade";
            break;
          default:
            break;
        }
      }
    }

    chaos_score_event_raise(var_10);
  }
}

chaos_score_on_ai_flashed() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3);

    if(isPlayer(var_3)) {
      chaos_score_event_raise("damage_flash");
    }
  }
}

chaos_score_on_ai_death() {
  self waittill("death", var_0, var_1, var_2);

  if(isDefined(var_0) && isDefined(var_0.owner) && isPlayer(var_0.owner)) {
    var_3 = chaos_get_ai_type_ref() + "_kill";
    chaos_score_event_raise(var_3);
    return;
  }

  if(isDefined(var_1)) {
    if(var_1 == "MOD_EXPLOSIVE" && !isDefined(var_2)) {
      if(level.start_combo_decay == 0) {
        level.start_combo_decay = 1;
      }
      chaos_score_event_raise("kill_explosive");

      if(!maps\_utility::_id_12C1()) {
        level.player._id_18D3["explosive_kill"]++;
      }
      return;
    }
  }

  if(!isPlayer(var_0)) {
    return;
  }
  var_3 = chaos_get_ai_type_ref() + "_kill";

  if(isDefined(self.a) && isDefined(self.a._id_0D69)) {
    var_3 = "kill_execution";
    var_0._id_18D3["execution"]++;
  } else if(maps\_player_stats::_id_0A32()) {
    var_3 = "kill_headshot";
    var_0._id_18D3["headshot"]++;
  } else if(isDefined(var_1)) {
    if(var_1 == "MOD_MELEE") {
      var_3 = "kill_knife";
      var_0._id_18D3["knife_kill"]++;
    } else if(var_1 == "MOD_EXPLOSIVE") {
      var_3 = "kill_explosive";
      var_0._id_18D3["explosive_kill"]++;
    } else if(var_1 == "MOD_PROJECTILE_SPLASH") {
      var_3 = "kill_rocket";
    } else if(var_1 == "MOD_GRENADE_SPLASH" || var_1 == "MOD_GRENADE") {
      if(var_2 == "fraggrenade") {
        var_3 = "kill_grenade";
        var_0._id_18D3["grenade_kill"]++;
      } else if(var_2 == "claymore") {
        var_3 = "kill_explosive";
        var_0._id_18D3["explosive_kill"]++;
      }
    } else if(var_1 == "MOD_PISTOL_BULLET" || var_1 == "MOD_RIFLE_BULLET") {
      if(distancesquared(self.origin, var_0.origin) > 262144) {
        var_3 = "kill_longshot";
        var_0._id_18D3["long_shot"]++;
      }
    }
  }

  if(level.start_combo_decay == 0) {
    level.start_combo_decay = 1;
  }
  if(var_3 == "kill_headshot") {
    var_0 thread updaterecentheadshots();
  } else if(var_3 == "kill_knife") {
    var_0 thread updaterecentknifekills();
  } else if(var_3 == "kill_longshot") {
    var_0 thread updaterecentlongshots();
  } else if(var_3 == "kill_rocket" || isDefined(var_2) && (var_2 == "c4" || var_2 == "claymore")) {
    var_0 thread updaterecentrocketkills();
  }
  var_0 thread updaterecentkills();

  if(var_3 == "kill_rocket") {
    var_3 = chaos_get_ai_type_ref() + "_kill";
  }
  var_4 = chaos_get_ai_type_ref();

  if(issubstr(var_4, "jug")) {
    var_3 = chaos_get_ai_type_ref() + "_kill";

    if(issubstr(var_3, "explosive")) {
      var_0._id_18D3["explosive_jug"]++;
    } else if(issubstr(var_3, "riotshield")) {
      var_0._id_18D3["riot_shield_jug"]++;
    } else if(issubstr(var_3, "regular")) {
      var_0._id_18D3["regular_jug"]++;
    }
  }

  if(var_4 == "chopper") {
    var_3 = "chopper_kill";
    var_0._id_18D3["chopper_kill"]++;
  }

  if(var_4 == "martyrdom" && var_3 != "kill_headshot") {
    var_3 = "martyrdom_kill";
    var_0._id_18D3["martyrdom_kill"]++;
  }

  if(var_3 == "easy_kill") {
    var_0._id_18D3["easy_kill"]++;
  } else if(var_3 == "regular_kill") {
    var_0._id_18D3["regular_kill"]++;
  } else if(var_3 == "hardened_kill") {
    var_0._id_18D3["hardened_kill"]++;
  } else if(var_3 == "veteran_kill") {
    var_0._id_18D3["veteran_kill"]++;
  } else if(var_3 == "elite_kill") {
    var_0._id_18D3["elite_kill"]++;
  } else if(var_3 == "elite_kill") {
    var_0._id_18D3["elite_kill"]++;
  } else if(var_3 == "chemical_kill") {
    var_0._id_18D3["chemical_kill"]++;
  } else if(var_3 == "martyrdom_kill") {
    var_0._id_18D3["martyrdom_kill"]++;
  } else if(var_3 == "dog_reg_kill") {
    var_0._id_18D3["regular_dog"]++;
  } else if(var_3 == "dog_splode_kill") {
    var_0._id_18D3["explosive_dog"]++;
  }
  chaos_score_event_raise(var_3);
}

updaterecentrocketkills() {
  self endon("disconnect");
  level endon("special_op_terminated");
  self notify("updateRecentRocketKills");
  self endon("updateRecentRocketKills");
  self.recentrocketkillcount++;
  wait 1.0;

  if(self.recentrocketkillcount > 1) {
    multirocketkills(self.recentrocketkillcount);
  }
  self.recentrocketkillcount = 0;
}

multirocketkills(var_0) {
  if(var_0 > 10) {
    thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_DEMO_MAN", "cm_bp_kills_explosion");
    chaos_score_event_raise("massive_explosion");
    self._id_18D3["massive_explosion"]++;
  }
}

updaterecentlongshots() {
  self endon("disconnect");
  level endon("special_op_terminated");
  self notify("updateRecentLongshots");
  self endon("updateRecentLongshots");
  self.recentlongshotcount++;
  wait 1.0;

  if(self.recentlongshotcount > 1) {
    multilongshots(self.recentlongshotcount);
  }
  self.recentlongshotcount = 0;
}

multilongshots(var_0) {
  if(var_0 >= 3) {
    thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_LONG_SHOOTER", "cm_bp_kills_3longshot");
    chaos_score_event_raise("longshot_triple");
    self._id_18D3["triple_long_shot"]++;
  }
}

updaterecentheadshots() {
  self endon("disconnect");
  level endon("special_op_terminated");
  self notify("updateRecentHeadshots");
  self endon("updateRecentHeadshots");
  self.recentheadshotcount++;
  wait 1.5;

  if(self.recentheadshotcount > 1) {
    multiheadshots(self.recentheadshotcount);
  }
  self.recentheadshotcount = 0;
}

multiheadshots(var_0) {
  if(var_0 >= 3) {
    thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_HEAD_HUNTER", "cm_bp_kills_3headshot");
    chaos_score_event_raise("headshot_triple");
    self._id_18D3["triple_headshot"]++;
  }
}

updaterecentknifekills() {
  self endon("disconnect");
  level endon("special_op_terminated");
  self notify("updateRecentKnifekills");
  self endon("updateRecentKnifekills");
  self.recentknifekillcount++;
  wait 2.0;

  if(self.recentknifekillcount > 1) {
    multiknifekills(self.recentknifekillcount);
  }
  self.recentknifekillcount = 0;
}

multiknifekills(var_0) {
  if(var_0 >= 3) {
    thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_SLASHER", "cm_bp_kills_3knife");
    chaos_score_event_raise("knife_triple");
    self._id_18D3["triple_knife_kill"]++;
  }
}

updaterecentkills() {
  self endon("disconnect");
  level endon("special_op_terminated");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.recentkillcount++;
  wait 1.0;

  if(self.recentkillcount > 1) {
    multikill(self.recentkillcount);
  }
  self.recentkillcount = 0;
}

multikill(var_0) {
  if(var_0 == 3) {
    thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_TRIPLE_KILL", "cm_bp_kills_triple");
    chaos_score_event_raise("kill_triple");
    self._id_18D3["triple_kill"]++;
  } else if(var_0 == 4) {
    thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_QUAD_KILL", "cm_bp_kills_quad");
    chaos_score_event_raise("kill_quad");
    self._id_18D3["quad_kill"]++;
  } else if(var_0 > 4) {
    thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_MULTI_KILL", "cm_bp_kills_multiple");
    chaos_score_event_raise("kill_multi");
    self._id_18D3["multi_kill"]++;
  }
}

chaos_timer_create(var_0, var_1, var_2) {
  var_0 = common_scripts\utility::ter_op(isDefined(var_0) && var_0 > 0, var_0, 1200);

  if(isDefined(var_1) && !common_scripts\utility::flag_exist(var_1)) {
    common_scripts\utility::flag_init(var_1);
  }
  if(isDefined(var_2) && !common_scripts\utility::flag_exist(var_2)) {
    common_scripts\utility::flag_init(var_2);
  }
  foreach(var_4 in level.players) {}
  var_4 chaos_timer_player_setup(var_0, var_1, var_2);

  level thread update_level_chaos_timer();
  level thread play_time_related_vo(var_0);
  level thread startcombodecayontimer();
}

play_time_related_vo(var_0) {
  level endon("special_op_terminated");
  level notify("stop_play_time_related_VO");
  level endon("stop_play_time_related_VO");
  level common_scripts\utility::waittill_notify_or_timeout("Start timer", 10);
  var_1 = var_0 - 45;
  var_2 = 15;
  var_3 = 20;

  if(var_1 > 0) {
    wait(var_1);
    level thread maps\_utility::_id_11F4("chaos_time_almostup");
  }

  wait(var_2);
  level thread maps\_utility::_id_11F4("chaos_30sec_left", 2.0);
  wait(var_3);
  level thread maps\_utility::_id_11F4("chaos_10sec_left", 2.0);
  wait 10;
  level thread maps\_utility::_id_11F4("chaos_keep_combo");
}

chaos_timer_player_setup(var_0, var_1, var_2) {
  var_3 = chaos_timer_create_hud_elem(self);
  thread chaos_timer_destroy(var_3);
  thread chaos_timer_update(var_3, var_0, var_1, var_2);
  self.chaos_timer = var_3;
}

chaos_timer_update(var_0, var_1, var_2, var_3) {
  level endon("special_op_terminated");
  level endon("chaos_timer_reached_zero");
  level endon("update_chaos_timer");

  if(var_1 <= 0) {
    var_1 = 60;
  }
  var_0 settenthstimerstatic(var_1);
  level common_scripts\utility::waittill_notify_or_timeout("Start timer", 10);

  if(level.timer_started == 0) {
    level._id_16CF = gettime();
    level.timer_started = 1;
  }

  var_4 = var_1 * 1000;
  var_5 = var_1;
  var_6 = gettime();
  var_7 = gettime();
  thread chaos_timer_reached_zero(var_0, var_5, var_3);
  thread chaos_timer_update_color(var_0, var_5, 60);
  thread chaos_timer_update_flash(var_0, var_5, 30);
  thread chaos_timer_update_sound(var_5, 5);
  thread chaos_timer_update_vo(var_5, 10);

  for(;;) {
    var_0 settenthstimer(var_5);
    level waittill("wave_ended");
    var_7 = gettime();
    var_4 = var_4 - (var_7 - var_6);
    var_5 = var_4 / 1000;
    level.chaos_time_remaining = var_5;
    var_0 settenthstimerstatic(var_5);
    level waittill("wave_started");
    var_6 = gettime();
  }
}

chaos_timer_reached_zero(var_0, var_1, var_2) {
  level endon("special_op_terminated");
  level endon("wave_ended");
  level endon("update_chaos_timer");
  var_0 endon("death");
  wait(var_1);
  level notify("chaos_timer_reached_zero");

  for(;;) {
    if(common_scripts\utility::flag_exist("chaos_players_in_combo") && common_scripts\utility::flag("chaos_players_in_combo")) {
      common_scripts\utility::flag_waitopen("chaos_players_in_combo");
    }
    if(level.freeze_combo_meter != 1) {
      break;
    }

    wait 0.05;
  }

  common_scripts\utility::flag_set(var_2);
  thread chaos_timer_fade(var_0);
}

sp_killstreak_bonus_freezemeter_crateopen() {
  level endon("special_op_terminated");

  if(_id_0611::_id_3CF4("sentry")) {
    _id_0611::_id_3CF2("sentry");
  }
  self giveweapon("chaos_freeze_meter");
  self setactionslot(4, "weapon", "chaos_freeze_meter");
  thread radio_dialogue_to_player(self, "chaos_pickup_freeze");
  thread wait_for_meter_freeze_activiation();
}

wait_for_meter_freeze_activiation() {
  level endon("special_op_terminated");
  level endon("stop_wait_for_meter_freeze_activation");
  self notifyonplayercommand("freeze_combo_meter", "+actionslot 4");

  for(;;) {
    self waittill("freeze_combo_meter");

    if(self._id_132B._id_1A53 == 0 && (isDefined(self.laststand) && self.laststand == 1)) {
      continue;
    }
    self takeweapon("chaos_freeze_meter");
    level thread execute_combo_freeze();
    break;
  }
}

execute_combo_freeze() {
  level endon("special_op_terminated");
  level notify("stop_freeze_meter_wait");
  level endon("stop_freeze_meter_wait");

  foreach(var_1 in level.players) {
    var_1 thread change_player_vision_set();
    var_1 playlocalsound("chaos_perk_activate");
  }

  level.freeze_combo_meter = 1;
  level notify("stop_meter_decay");
  chaos_combo_bar_set_fill(1.0);
  chaos_combo_bar_hide(0);
  wait 8;

  foreach(var_1 in level.players) {}
  var_1 playlocalsound("chaos_perk_deactivate");

  wait 2;
  level.freeze_combo_meter = 0;
  thread chaos_combo_on_end(4.0, 0.2);
}

sp_killstreak_bonus_multiplier_crateopen() {
  level.chaos_combo_count = level.chaos_combo_count + 10;
  chaos_score_event_raise("bonus_multiplier");
  level thread maps\_utility::_id_11F4("chaos_pickup_multiplier");

  if(level.player_currently_getting_perk == 1) {
    level waittill("proceed_with_next_perk");
  }
  if(level.player.num_perk_obtained < level.chaos_perk_progression.size) {
    var_0 = int(level.chaos_combo_count / level.perk_progression_gap);
    var_1 = level.player.num_perk_obtained;

    if(var_0 > var_1) {
      var_2 = var_0 * level.perk_progression_gap;
      var_3 = "combo_" + var_2;
      var_4 = level.chaos_perk_progression[var_3];

      foreach(var_6 in level.players) {}
      var_6 chaos_give_perk(var_4);

      level thread chaos_perk_radio(var_4);
    }
  }
}

sp_killstreak_bonus_laststand_crateopen() {
  var_0 = 0;
  self._id_132B._id_1A53 = self._id_132B._id_1A53 + 1;
  thread radio_dialogue_to_player(self, "chaos_pickup_laststand");

  if(isDefined(self.laststand) && self.laststand == 1) {
    return;
  }
  update_lives_left_hud(self._id_132B._id_1A53);
  return;
}

sp_killstreak_bonus_time_crateopen() {
  level notify("update_chaos_timer");
  var_0 = level.chaos_time_remaining + 60;
  level.chaos_time_remaining = var_0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2.chaos_timer)) {
      var_2.chaos_timer.fontscale = 1;
      var_2.chaos_timer maps\_specialops::_id_185D();
      thread chaos_timer_update(var_2.chaos_timer, var_0, undefined, "win_survival");
    }

    if(isDefined(var_2.combathighoverlay)) {
      var_2.combathighoverlay destroy();
    }
  }

  level thread update_level_chaos_timer();
  level thread maps\_utility::_id_11F4("chaos_pickup_time");
  level thread play_time_related_vo(var_0);
  level notify("Start timer");
}

chaos_give_perk(var_0) {
  if(var_0 != "specialty_juiced") {
    if(self hasperk(var_0, 1)) {
      return 1;
    }
  }

  level.player_currently_getting_perk = 1;
  var_1 = undefined;

  switch (var_0) {
    case "specialty_stalker":
      thread _id_0615::_id_3C61();
      break;
    case "specialty_longersprint":
      thread _id_0615::_id_3C57();
      break;
    case "specialty_fastreload":
      thread _id_0615::_id_3C59();
      break;
    case "specialty_quickdraw":
      thread _id_0615::_id_3C5B();
      thread chaos_give_perk_fastoffhand();
      break;
    case "specialty_detectexplosive":
      thread _id_0615::_id_3C5D();
      break;
    case "specialty_bulletaccuracy":
      thread _id_0615::_id_3C5F();
      break;
    case "specialty_armorvest":
      self setperk("specialty_armorvest", 1, 0);
      thread chaos_extra_health_regen();
      break;
    case "specialty_juiced":
      self setmovespeedscale(1.25);
      break;
    default:
      thread _id_0615::_id_3C55();
      break;
  }

  self.num_perk_obtained++;
  self notify("perk_pop_up", var_0);
  return 1;
}

chaos_extra_health_regen() {
  level endon("special_op_terminated");
  self endon("chaos_stop_extra_health_regen");

  for(;;) {
    if(self.health < self.maxhealth) {
      var_0 = self.maxhealth - self.health;
      self.health = self.health + int(var_0 * 0.8);
    }

    wait 0.1;
  }
}

chaos_give_perk_fastoffhand() {
  self setperk("specialty_fastoffhand", 1, 0);
}

unsetjuiced() {
  self setmovespeedscale(1);
}

chaos_eog_summary() {
  var_0 = int(min(level._id_16CE - level._id_16CF, 86400000));
  var_1 = int(var_0 % 1000 / 100);
  var_2 = int(var_0 / 1000) % 60;
  var_3 = int(var_0 / 60000) % 60;
  var_4 = int(var_0 / 3600000);

  if(var_4 < 10) {
    var_4 = "0" + var_4;
  }
  if(var_3 < 10) {
    var_3 = "0" + var_3;
  }
  if(var_2 < 10) {
    var_2 = "0" + var_2;
  }
  var_5 = var_4 + ":" + var_3 + ":" + var_2 + "." + var_1;
  chaos_clear_eog_summary_dvar();

  foreach(var_7 in level.players) {
    var_8 = var_7._id_18D3["kill"];
    var_9 = maps\_so_survival::_id_3F6A(var_7, "kill");
    var_10 = var_7._id_18D3["headshot"];
    var_11 = maps\_so_survival::_id_3F6A(var_7, "headshot");
    var_12 = var_7._id_18D3["knife_kill"];
    var_13 = maps\_so_survival::_id_3F6A(var_7, "knife_kill");
    var_14 = var_7._id_18D3["comboscoremax"];
    var_15 = var_7._id_18D3["combomultmax"];
    var_16 = var_7._id_18D3["long_shot"];
    var_17 = var_7._id_18D3["triple_kill"];
    var_18 = var_7._id_18D3["quad_kill"];
    var_19 = var_7._id_18D3["multi_kill"];
    var_20 = var_7._id_18D3["new_weapon_collected"];
    var_21 = var_7._id_18D3["massive_explosion"];
    var_22 = var_7._id_18D3["triple_long_shot"];
    var_23 = var_7._id_18D3["triple_headshot"];
    var_24 = var_7._id_18D3["triple_knife_kill"];
    var_25 = var_7._id_18D3["explosive_kill"];
    var_26 = var_7._id_18D3["execution"];
    var_27 = var_7._id_18D3["grenade_kill"];
    var_28 = var_7._id_18D3["explosive_jug"];
    var_29 = var_7._id_18D3["riot_shield_jug"];
    var_30 = var_7._id_18D3["regular_jug"];
    var_31 = var_7._id_18D3["easy_kill"];
    var_32 = var_7._id_18D3["regular_kill"];
    var_33 = var_7._id_18D3["hardened_kill"];
    var_34 = var_7._id_18D3["veteran_kill"];
    var_35 = var_7._id_18D3["elite_kill"];
    var_36 = var_7._id_18D3["chemical_kill"];
    var_37 = var_7._id_18D3["martyrdom_kill"];
    var_38 = var_7._id_18D3["regular_dog"];
    var_39 = var_7._id_18D3["explosive_dog"];
    var_40 = var_7._id_18D3["chopper_kill"];
    setDvar("ui_hide_hint", 1);
    var_41 = 0;
    var_42 = 4;

    if(maps\_utility::_id_12C1()) {
      var_7 chaos_add_custom_eog_summary_line("", "@SPECIAL_OPS_PERFORMANCE_YOU", "@SPECIAL_OPS_PERFORMANCE_PARTNER");
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_KILLS", var_8, var_9);
      var_7 chaos_add_custom_eog_summary_line("", "", "");
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_HIGHEST_COMBO", var_15);
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_TIME", var_5);
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_SCORE", level.chaos_score);
      continue;
    }

    if(var_40 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_CHOPPER", var_40);
      var_41++;
    }

    if(var_21 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_MASSIVE_EXP", var_21);
      var_41++;
    }

    if(var_28 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_EXP_JUG", var_28);
      var_41++;
    }

    if(var_19 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_MUL_KILL", var_19);
      var_41++;
    }

    if(var_22 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_TRI_LONGSHOT", var_22);
      var_41++;
    }

    if(var_24 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_TRI_KNIFE", var_24);
      var_41++;
    }

    if(var_23 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_TRI_HEADSHOT", var_23);
      var_41++;
    }

    if(var_18 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_QUAD_KILL", var_18);
      var_41++;
    }

    if(var_29 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_SHIELD_JUG", var_29);
      var_41++;
    }

    if(var_17 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_TRI_KILL", var_17);
      var_41++;
    }

    if(var_30 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_REG_JUG", var_30);
      var_41++;
    }

    if(var_20 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_NEW_WEAPON", var_20);
      var_41++;
    }

    if(var_27 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_GRENADE", var_27);
      var_41++;
    }

    if(var_36 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_CHEMICAL", var_36);
      var_41++;
    }

    if(var_10 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_HEADSHOT", var_10);
      var_41++;
    }

    if(var_35 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_ELITE", var_35);
      var_41++;
    }

    if(var_34 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_VETERAN", var_34);
      var_41++;
    }

    if(var_26 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_EXECUTION", var_26);
      var_41++;
    }

    if(var_33 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_HARDENED", var_33);
      var_41++;
    }

    if(var_39 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_EXP_DOG", var_39);
      var_41++;
    }

    if(var_37 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_MARTYRDOM", var_37);
      var_41++;
    }

    if(var_16 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_LONG_SHOT", var_16);
      var_41++;
    }

    if(var_12 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_KNIFE", var_12);
      var_41++;
    }

    if(var_25 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_EXP_KILL", var_25);
      var_41++;
    }

    if(var_32 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_REG_KILL", var_32);
      var_41++;
    }

    if(var_38 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_REG_DOG", var_38);
      var_41++;
    }

    if(var_31 > 0 && var_41 < var_42) {
      var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_EASY", var_31);
      var_41++;
    }

    var_7 chaos_add_custom_eog_summary_line_blank();
    var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_HIGHEST_COMBO", var_15);
    var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_TIME", var_5);
    var_7 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_SCORE", level.chaos_score);
  }
}

chaos_clear_eog_summary_dvar() {
  var_0 = "";

  if(level.players.size > 1) {
    for(var_1 = 1; var_1 < 10; var_1++) {
      for(var_2 = 1; var_2 < 5; var_2++) {
        var_0 = "ui_eog_r" + var_1 + "c" + var_2 + "_player1";
        setDvar(var_0, "");
        var_0 = "ui_eog_r" + var_1 + "c" + var_2 + "_player2";
        setDvar(var_0, "");
      }
    }
  } else {
    for(var_1 = 1; var_1 < 10; var_1++) {
      for(var_2 = 1; var_2 < 5; var_2++) {
        var_0 = "ui_eog_r" + var_1 + "c" + var_2 + "_player1";
        setDvar(var_0, "");
      }
    }
  }
}

chaos_add_custom_eog_summary_line(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self._id_1992)) {
    self._id_1992 = 0;
  }
  var_5 = undefined;

  if(isDefined(var_4)) {
    var_5 = var_4;

    if(var_4 > self._id_1992) {
      self._id_1992 = var_4;
    }
  } else {
    self._id_1992++;
    var_5 = self._id_1992;
  }

  chaos_set_custom_eog_summary(var_5, 1, var_0);
  var_6 = [];

  if(isDefined(var_3)) {
    var_6[var_6.size] = var_3;
  }
  if(isDefined(var_2)) {
    var_6[var_6.size] = var_2;
  }
  if(isDefined(var_1)) {
    var_6[var_6.size] = var_1;
  }
  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    chaos_set_custom_eog_summary(var_5, 4 - var_7, var_6[var_7]);
  }
}

chaos_set_custom_eog_summary(var_0, var_1, var_2) {
  var_3 = int(var_0);
  var_4 = int(var_1);
  var_5 = "";

  if(level.players.size > 1) {
    if(self == level.player) {
      var_5 = "ui_eog_r" + var_3 + "c" + var_4 + "_player1";
    } else if(self == level._id_1337) {
      var_5 = "ui_eog_r" + var_3 + "c" + var_4 + "_player2";
    } else {}
  } else {
    var_5 = "ui_eog_r" + var_3 + "c" + var_4 + "_player1";
  }
  setDvar(var_5, var_2);
}

chaos_add_custom_eog_summary_line_blank() {
  if(!isDefined(self._id_1992)) {
    self._id_1992 = 0;
  }
  self._id_1992++;
}

radio_dialogue_to_player(var_0, var_1, var_2) {
  if(!isDefined(level._id_26B0)) {
    var_3 = spawn("script_origin", (0, 0, 0));
    var_3 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level._id_26B0 = var_3;
  }

  maps\_utility::_id_16EA();
  var_4 = 0;

  if(!isDefined(var_2)) {
    var_4 = level._id_26B0 maps\_utility::_id_1255(::chaos_play_sound_to_player, var_0, level._id_11BB[var_1], undefined, 1);
  } else {
    var_4 = level._id_26B0 maps\_utility::_id_1257(var_2, ::chaos_play_sound_to_player, var_0, level._id_11BB[var_1], undefined, 1);
  }
  return var_4;
}

chaos_play_sound_to_player(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(maps\_utility::_id_2625()) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  thread chaos_delete_on_death_wait_sound(var_0, "sounddone");
  var_0 playlocalsound(var_1, "sounddone", 0);

  if(isDefined(var_3)) {
    if(!isDefined(maps\_utility_code::_id_13EC(var_0))) {
      var_0 stopsounds();
    }
    wait 0.05;
  } else {
    var_0 waittill("sounddone");
  }
  if(isDefined(var_4)) {
    self notify(var_4);
  }
}

chaos_delete_on_death_wait_sound(var_0, var_1) {
  var_0 endon("death");
  self waittill("death");

  if(isDefined(var_0)) {
    if(var_0 iswaitingonsound()) {
      var_0 waittill(var_1);
    }
  }
}

updateweaponheadiconforplayer() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_wait("slamzoom_finished");

  for(;;) {
    foreach(var_1 in level.chaos_entities) {
      foreach(var_3 in level.players) {
        if(sighttracepassed(var_3 getEye(), var_1.origin, 0, var_3) || distancesquared(var_1.origin, var_3.origin) < 562500) {
          if(!isDefined(var_1.headiconforplayer[var_3.unique_id]) && var_1.weapon_in_use == 0) {
            var_4 = var_1 createweaponheadicon(var_3, var_1.hud_icon);
            var_1.headiconforplayer[var_3.unique_id] = var_4;
          }

          continue;
        }

        if(isDefined(var_1.headiconforplayer[var_3.unique_id])) {
          var_1.headiconforplayer[var_3.unique_id] destroy();
          var_1.headiconforplayer[var_3.unique_id] = undefined;
        }
      }
    }

    wait 0.5;
  }
}

createweaponheadicon(var_0, var_1) {
  var_2 = newclienthudelem(var_0);
  var_2.x = self.origin[0];
  var_2.y = self.origin[1];
  var_2.z = self.origin[2] + 5;
  var_2.alpha = 0.85;
  var_2.hidewheninmenu = 1;
  var_2 setshader(var_1, 40, 40);
  var_2 setwaypoint(1, 0, 1, 0);
  var_2 thread chaoskeeppositioned(self, (0, 0, 5), 0.05);
  return var_2;
}

chaoskeeppositioned(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  var_3 = var_0.origin;

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }
    if(var_3 != var_0.origin) {
      var_3 = var_0.origin;
      self.x = var_3[0] + var_1[0];
      self.y = var_3[1] + var_1[1];
      self.z = var_3[2] + var_1[2];
    }

    if(var_2 > 0.05) {
      self.alpha = 0.85;
      self fadeovertime(var_2);
      self.alpha = 0;
    }

    wait(var_2);
  }
}

manage_lives_left_hud() {
  level endon("special_op_terminated");

  for(;;) {
    self waittill("player_downed");

    if(isDefined(self._id_132B._id_1A53) && self._id_132B._id_1A53 > 0) {
      thread radio_dialogue_to_player(self, "chaos_get_onekill", 1.0);
    }
    self.live_1_hud_icon.icon.alpha = 0.0;
    self.live_2_hud_icon.icon.alpha = 0.0;
    self.live_3_hud_icon.icon.alpha = 0.0;
    self.live_4_hud_icon.icon.alpha = 0.0;
    self.live_5_hud_icon.icon.alpha = 0.0;
    self waittill("revived");
    self disableinvulnerability();
    maps\_so_survival::_id_3F74("armor_1");

    if(isDefined(self._id_132B._id_1A53) && self._id_132B._id_1A53 - 1 > 0) {
      var_0 = self._id_132B._id_1A53 - 1;
      wait 0.5;
      update_lives_left_hud(var_0);
      continue;
    }

    var_1 = spawnStruct();
    var_1._id_3E1B = &"SO_SURVIVAL_CHAOS_SPLASH_FINAL_STAND";
    var_1.duration = 1.5;
    var_1.sound = "cm_bp_laststand_lastlife";
    thread player_combo_splash(var_1);
  }
}

update_lives_left_hud(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  if(isDefined(self.live_1_hud_icon.icon) && isDefined(self.live_2_hud_icon.icon) && isDefined(self.live_3_hud_icon.icon) && isDefined(self.live_4_hud_icon.icon) && isDefined(self.live_5_hud_icon.icon)) {
    if(var_0 == 5) {
      self.live_1_hud_icon.icon.alpha = 0.85;
      self.live_2_hud_icon.icon.alpha = 0.85;
      self.live_3_hud_icon.icon.alpha = 0.85;
      self.live_4_hud_icon.icon.alpha = 0.85;
      self.live_5_hud_icon.icon.alpha = 0.85;
      var_2 = -75;
    } else if(var_0 == 4) {
      self.live_1_hud_icon.icon.alpha = 0.85;
      self.live_2_hud_icon.icon.alpha = 0.85;
      self.live_3_hud_icon.icon.alpha = 0.85;
      self.live_4_hud_icon.icon.alpha = 0.85;
      self.live_5_hud_icon.icon.alpha = 0.0;
      var_2 = -60;
    } else if(var_0 == 3) {
      self.live_1_hud_icon.icon.alpha = 0.85;
      self.live_2_hud_icon.icon.alpha = 0.85;
      self.live_3_hud_icon.icon.alpha = 0.85;
      self.live_4_hud_icon.icon.alpha = 0.0;
      self.live_5_hud_icon.icon.alpha = 0.0;
      var_2 = -45;
    } else if(var_0 == 2) {
      self.live_1_hud_icon.icon.alpha = 0.85;
      self.live_2_hud_icon.icon.alpha = 0.85;
      self.live_3_hud_icon.icon.alpha = 0.0;
      self.live_4_hud_icon.icon.alpha = 0.0;
      self.live_5_hud_icon.icon.alpha = 0.0;
      var_2 = -30;

      if(!isDefined(var_1)) {
        thread radio_dialogue_to_player(self, "chaos_2_last_stand", 1.0);
      }
    } else if(var_0 == 1) {
      self.live_1_hud_icon.icon.alpha = 0.85;
      self.live_2_hud_icon.icon.alpha = 0.0;
      self.live_3_hud_icon.icon.alpha = 0.0;
      self.live_4_hud_icon.icon.alpha = 0.0;
      self.live_5_hud_icon.icon.alpha = 0.0;
      var_2 = -15;

      if(!isDefined(var_1)) {
        thread radio_dialogue_to_player(self, "chaos_1_last_stand", 1.0);
      }
    } else if(var_0 == 0) {
      self.live_1_hud_icon.icon.alpha = 0.0;
      self.live_2_hud_icon.icon.alpha = 0.0;
      self.live_3_hud_icon.icon.alpha = 0.0;
      self.live_4_hud_icon.icon.alpha = 0.0;
      self.live_5_hud_icon.icon.alpha = 0.0;
      var_2 = 0;
    } else {}

    if(issplitscreen()) {
      var_3 = -80 - (self != level.player) * 19;
    } else {
      var_3 = 152;
    }
    self.live_1_hud_icon.icon maps\_hud_util::setpoint("LEFT", "CENTER", var_2, var_3);
    self.live_2_hud_icon.icon maps\_hud_util::setpoint("LEFT", "CENTER", var_2 + 30, var_3);
    self.live_3_hud_icon.icon maps\_hud_util::setpoint("LEFT", "CENTER", var_2 + 60, var_3);
    self.live_4_hud_icon.icon maps\_hud_util::setpoint("LEFT", "CENTER", var_2 + 90, var_3);
    self.live_5_hud_icon.icon maps\_hud_util::setpoint("LEFT", "CENTER", var_2 + 120, var_3);
  }
}

chaos_combo_player_create_hud() {
  level.chaos_combo_all_hud_elems = [];
  self.chaos_score_hud = maps\_hud_util::createserverclientfontstring("hudbig", 1.25);

  if(issplitscreen()) {
    self.chaos_score_hud maps\_hud_util::setpoint("RIGHT", "TOP RIGHT", undefined, 0 + (self != level.player) * 27);
  } else {
    self.chaos_score_hud maps\_hud_util::setpoint("RIGHT", "TOP RIGHT", undefined, undefined);
  }
  self.chaos_score_hud settext("0");
  self.chaos_score_hud.color = (1, 1, 0);
  self.chaos_score_hud.glowalpha = 0.25;
  self.chaos_score_hud.glowcolor = (0.2, 0.2, 0.2);
  self.chaos_score_hud._id_184E = 1.25;
  self.chaos_score_hud._id_184F = 1.65;
  self.chaos_score_hud maps\_specialops_code::_id_1849();
  self.chaos_score_hud.hidewheninmenu = 1;
  level.chaos_combo_all_hud_elems[level.chaos_combo_all_hud_elems.size] = self.chaos_score_hud;
  self.chaos_score_info_hud = maps\_hud_util::createserverclientfontstring("hudbig", 1.0);
  self.chaos_score_info_hud maps\_hud_util::setpoint("RIGHT", "TOP RIGHT", undefined, 25);
  self.chaos_score_info_hud settext("0");
  self.chaos_score_info_hud maps\_specialops_code::_id_1849();
  self.chaos_score_info_hud.hidewheninmenu = 1;
  self.chaos_score_info_hud.alpha = 0.0;
  level.chaos_combo_all_hud_elems[level.chaos_combo_all_hud_elems.size] = self.chaos_score_info_hud;
  self.chaos_combo_bar = chaos_special_item_hudelem(20, 20);
  self.chaos_combo_bar.children = [];
  self.chaos_combo_bar maps\_hud_util::setparent(level.uiparent);
  self.chaos_combo_bar setshader("chaos_meter_16", 162, 8);

  if(issplitscreen()) {
    self.chaos_combo_bar maps\_hud_util::setpoint("LEFT", "CENTER", -79, 85 - (self != level.player) * 27);
  } else {
    self.chaos_combo_bar maps\_hud_util::setpoint("LEFT", "CENTER", -79, 45);
  }
  self.chaos_combo_bar.glowcolor = (0.8, 0.8, 0.8);
  self.chaos_combo_bar.glowalpha = 0.5;
  self.chaos_combo_bar.hidewheninmenu = 1;
  level.chaos_combo_all_hud_elems[level.chaos_combo_all_hud_elems.size] = self.chaos_combo_bar;
  self.chaos_combo_hud_action_array = [];

  for(var_0 = 0; var_0 < level.chaos_combo_actions_max; var_0++) {
    var_1 = maps\_hud_util::createserverclientfontstring("hudsmall", 1.0);

    if(issplitscreen()) {
      var_1 maps\_hud_util::setpoint("RIGHT", "CENTER RIGHT", undefined, var_0 * 18 + -20);
    } else {
      var_1 maps\_hud_util::setpoint("RIGHT", "CENTER RIGHT", undefined, var_0 * 18);
    }
    var_1 settext("");
    var_1.alpha = 1.0 - var_0 * (1.0 / level.chaos_combo_actions_max);
    var_1.hidewheninmenu = 1;
    self.chaos_combo_hud_action_array[var_0] = var_1;
    level.chaos_combo_all_hud_elems[level.chaos_combo_all_hud_elems.size] = var_1;
  }

  self.chaos_combo_hud_multiply = maps\_hud_util::createserverclientfontstring("hudbig", 1.6);

  if(issplitscreen()) {
    self.chaos_combo_hud_multiply maps\_hud_util::setpoint("RIGHT", "CENTER", -10, 105 - (self != level.player) * 27);
  } else {
    self.chaos_combo_hud_multiply maps\_hud_util::setpoint("RIGHT", "CENTER", -10, 65);
  }
  self.chaos_combo_hud_multiply settext("");
  self.chaos_combo_hud_multiply.color = (1, 1, 0);
  self.chaos_combo_hud_multiply.glowcolor = (0, 0, 0);
  self.chaos_combo_hud_multiply.glowalpha = 0.8;
  self.chaos_combo_hud_multiply._id_184E = 1.25;
  self.chaos_combo_hud_multiply._id_184F = 2.0;
  self.chaos_combo_hud_multiply._id_184D = 0.3;
  self.chaos_combo_hud_multiply maps\_specialops_code::_id_1849();
  self.chaos_combo_hud_multiply.hidewheninmenu = 1;
  level.chaos_combo_all_hud_elems[level.chaos_combo_all_hud_elems.size] = self.chaos_combo_hud_multiply;
  self.chaos_combo_hud_score = maps\_hud_util::createserverclientfontstring("hudbig", 1.0);

  if(issplitscreen()) {
    self.chaos_combo_hud_score maps\_hud_util::setpoint("LEFT", "CENTER", 5, 105 - (self != level.player) * 27);
  } else {
    self.chaos_combo_hud_score maps\_hud_util::setpoint("LEFT", "CENTER", 5, 65);
  }
  self.chaos_combo_hud_score settext("");
  self.chaos_combo_hud_score.color = (1, 1, 0);
  self.chaos_combo_hud_score.hidewheninmenu = 1;
  level.chaos_combo_all_hud_elems[level.chaos_combo_all_hud_elems.size] = self.chaos_combo_hud_score;
}

chaos_combo_all_hud_destroy() {
  level waittill("special_op_terminated");

  foreach(var_1 in level.chaos_combo_all_hud_elems) {}
  var_1 maps\_hud_util::destroyelem();
}

makecombomultiplyglowandpop() {
  level endon("special_op_terminated");
  self.chaos_combo_hud_multiply.glowcolor = (0, 0.2, 1);
  self.chaos_combo_hud_multiply.glowalpha = 1;
  common_scripts\utility::waittill_notify_or_timeout("combo_update", 1);
  self.chaos_combo_hud_multiply.glowcolor = (0, 0, 0);
  self.chaos_combo_hud_multiply.glowalpha = 0.0;
}

chaos_combo_display_update(var_0, var_1, var_2, var_3, var_4) {
  level endon("special_op_terminated");

  if(isDefined(var_4) && var_4) {
    if(var_1 != 0) {
      chaos_combo_actions_update(var_0, var_1);
    }
  }

  var_5 = level.chaos_score + var_2 * var_3;

  foreach(var_7 in level.players) {
    if(var_1 != 0) {
      var_7 chaos_combo_action_display_clear();
      var_8 = 0;

      for(var_9 = level.chaos_combo_actions.size - 1; var_9 >= 0; var_9--) {
        var_7.chaos_combo_hud_action_array[var_8].label = level.chaos_combo_actions[var_9].action_string;
        var_7.chaos_combo_hud_action_array[var_8] setvalue(level.chaos_combo_actions[var_9].point);
        var_8++;
      }

      if(issplitscreen()) {
        var_7.chaos_combo_hud_action_array[0] maps\_hud_util::setpoint("CENTER", "CENTER RIGHT", undefined, -20);
        var_7.chaos_combo_hud_action_array[0] maps\_hud_util::setpoint("RIGHT", "CENTER RIGHT", undefined, -20, 0.25);
      } else {
        var_7.chaos_combo_hud_action_array[0] maps\_hud_util::setpoint("CENTER", "CENTER RIGHT", undefined, undefined);
        var_7.chaos_combo_hud_action_array[0] maps\_hud_util::setpoint("RIGHT", "CENTER RIGHT", undefined, undefined, 0.25);
      }
    }

    var_7.chaos_combo_hud_multiply settext(var_3 + "x");
    var_7.chaos_combo_hud_score settext(var_2);
    var_7.chaos_score_hud settext(format_good_looking_score(var_5));

    if(isDefined(var_4) && var_4) {
      var_7.chaos_combo_hud_multiply thread maps\_specialops::_id_1848();
    }
  }
}

format_good_looking_score(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_0 = int(var_0);

  if(var_0 < 1000) {
    if(isDefined(var_1) && var_1 == 1) {
      if(var_0 == 0) {
        return "000";
      } else if(var_0 < 10) {
        return "00" + var_0;
      } else if(var_0 < 100) {
        return "0" + var_0;
      } else {
        return var_0;
      }
    } else {
      return var_0;
    }
  } else {
    var_2 = var_0 % 1000;
    var_3 = (float(var_0) - float(var_2)) / 1000;
    return format_good_looking_score(var_3) + "," + format_good_looking_score(var_2, 1);
  }
}

chaos_combo_display_clear() {
  foreach(var_1 in level.players) {
    var_1 chaos_combo_action_display_clear();
    var_1.chaos_combo_hud_multiply settext("");
    var_1.chaos_combo_hud_score settext("");
  }
}

chaos_combo_action_display_clear() {
  for(var_0 = 0; var_0 < self.chaos_combo_hud_action_array.size; var_0++) {
    self.chaos_combo_hud_action_array[var_0].label = "";
    self.chaos_combo_hud_action_array[var_0] settext("");
  }
}

recreate_last_stand_hud() {
  common_scripts\utility::waitframe();

  if(!isDefined(level.player._id_1A8B)) {
    level._id_1A57 = [];
    maps\_laststand::_id_1A8A();
  }
}

chaos_combo_bar_hide(var_0) {
  foreach(var_2 in level.players) {
    if(var_0) {
      var_2.chaos_combo_bar.alpha = 0;
      continue;
    }

    var_2.chaos_combo_bar.alpha = 1;
  }
}

chaos_combo_bar_get_fill() {
  return level.player.chaos_combo_bar.bar.frac;
}

chaos_combo_bar_set_fill(var_0) {
  common_scripts\utility::array_thread(level.players, ::chaos_combo_bar_player_set_fill, var_0);
}

chaos_combo_bar_player_set_fill(var_0) {
  var_1 = "";

  if(isDefined(level.freeze_combo_meter) && level.freeze_combo_meter == 1) {
    var_1 = "chaos_frozen_meter";
    self.chaos_combo_bar setshader(var_1, 162, 32);
  } else {
    var_2 = int(var_0 * 100 / 6);

    if(var_2 == 0) {
      var_2 = 1;
    }
    var_1 = "chaos_meter_" + var_2;
    self.chaos_combo_bar setshader(var_1, 162, 8);
  }
}

chaos_score_hud_player_update(var_0) {
  level endon("special_op_terminated");
  level endon("score_update_bump");
  self.chaos_score_info_hud.alpha = 1.0;
  self.chaos_score_info_hud settext(var_0 + "X COMBO!");
  self.chaos_score_info_hud maps\_hud_util::setpoint("LEFT", "CENTER", undefined, -25);
  self.chaos_score_info_hud maps\_hud_util::setpoint("RIGHT", "TOP RIGHT", undefined, 25, 0.5);
  self.chaos_score_info_hud maps\_specialops::_id_1848();
  self.chaos_score_info_hud fadeovertime(0.5);
  self.chaos_score_info_hud.alpha = 0.0;
  self.chaos_score_hud settext(level.chaos_score);
  self.chaos_score_hud thread maps\_specialops::_id_1848();
}

chaos_timer_destroy(var_0) {
  level waittill("special_op_terminated");

  if(isDefined(var_0)) {
    var_0 maps\_hud_util::destroyelem();
  }
}

set_player_time_up_vision() {
  level endon("special_op_terminated");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1.combathighoverlay)) {
      var_1.combathighoverlay = newclienthudelem(var_1);
      var_1.combathighoverlay.x = 0;
      var_1.combathighoverlay.y = 0;
      var_1.combathighoverlay.alignx = "left";
      var_1.combathighoverlay.aligny = "top";
      var_1.combathighoverlay.horzalign = "fullscreen";
      var_1.combathighoverlay.vertalign = "fullscreen";
      var_1.combathighoverlay setshader("combathigh_overlay", 640, 480);
      var_1.combathighoverlay.sort = -10;
      var_1.combathighoverlay.archived = 1;
    }
  }
}

chaos_timer_fade(var_0) {
  var_0 endon("death");
  var_0 maps\_hud_util::fade_over_time(0.0, 2.0);
  wait 2.0;

  if(!isDefined(var_0)) {
    return;
  }
  var_0 destroy();
}

chaos_timer_create_hud_elem(var_0) {
  var_1 = newclienthudelem(var_0);
  var_1.elemtype = "timer";
  var_1.font = "hudbig";
  var_1.fontscale = 1;
  var_1.basefontscale = var_1.fontscale;
  var_1.x = 0;
  var_1.y = 0;
  var_1.width = 0;
  var_1.height = int(level.fontheight * var_1.fontscale);
  var_1.hidewheninmenu = 1;
  var_1.xoffset = 0;
  var_1.yoffset = 0;
  var_1.children = [];
  var_1 maps\_hud_util::setparent(level.uiparent);

  if(issplitscreen()) {
    var_1 maps\_hud_util::setpoint("TOP", "TOP", undefined, -12 + (self != level.player) * 27);
  } else {
    var_1 maps\_hud_util::setpoint("TOP", "TOP", undefined, -12);
  }
  var_1.hidden = 0;
  return var_1;
}

chaos_timer_update_flash(var_0, var_1, var_2) {
  level endon("special_op_terminated");
  level endon("wave_ended");
  level endon("update_chaos_timer");
  var_3 = var_1 - var_2;

  if(var_3 > 0) {
    wait(var_3);
  }
  var_4 = var_2 / 1.0;

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_0.fontscale = 1.2;
    var_0 maps\_specialops::_id_16AC();
    wait 0.5;
    var_0.fontscale = 1;
    var_0 maps\_specialops::_id_185F();
    wait 0.5;
  }

  var_0 maps\_specialops::_id_16AC();
  level thread set_player_time_up_vision();
}

chaos_timer_update_color(var_0, var_1, var_2) {
  level endon("special_op_terminated");
  level endon("wave_ended");
  level endon("update_chaos_timer");
  var_3 = var_1 - var_2;

  if(var_3 > 0) {
    wait(var_3);
  }
  var_0 maps\_specialops::_id_185F();
}

chaos_timer_update_sound(var_0, var_1) {
  level endon("special_op_terminated");
  level endon("wave_ended");
  level endon("chaos_timer_reached_zero");
  level endon("update_chaos_timer");
  var_2 = var_0 - var_1;

  if(var_2 >= 0) {
    if(var_2 > 0) {
      wait(var_2);
    }
    var_0 = var_0 - var_2;
    self playlocalsound("so_countdown_beep");
  }

  for(;;) {
    var_3 = var_0 - int(var_0);

    if(var_3 == 0) {
      var_3 = 1.0;
    }
    if(var_0 - var_3 <= 0) {
      break;
    }

    wait(var_3);
    var_0 = var_0 - var_3;
    self playlocalsound("so_countdown_beep");
  }
}

chaos_destroyelem() {
  var_0 = [];

  for(var_1 = 0; var_1 < self.children.size; var_1++) {
    if(isDefined(self.children[var_1])) {
      var_0[var_0.size] = self.children[var_1];
    }
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] maps\_hud_util::setparent(maps\_hud_util::getparent());
  }
  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar destroy();
  }
  self destroy();
}

showelem() {
  if(!self.hidden) {
    return;
  }
  self.hidden = 0;

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    if(self.alpha != 0.5) {
      self.alpha = 0.5;
    }
    self.bar.hidden = 0;

    if(self.bar.alpha != 1) {
      self.bar.alpha = 1;
    }
  } else if(self.alpha != 1) {
    self.alpha = 1;
  }
}

hideelem() {
  if(self.hidden) {
    return;
  }
  self.hidden = 1;

  if(self.alpha != 0) {
    self.alpha = 0;
  }
  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar.hidden = 1;

    if(self.bar.alpha != 0) {
      self.bar.alpha = 0;
    }
  }
}

chaos_updatebar(var_0, var_1) {
  if(self.elemtype == "bar") {
    updatebarscale(var_0, var_1);
  }
}

updatebarscale(var_0, var_1) {
  var_2 = int(self.width * var_0 + 0.5);

  if(!var_2) {
    var_2 = 1;
  }
  self.bar.frac = var_0;
  self.bar setshader(self.bar.shader, var_2, self.height);

  if(isDefined(var_1) && var_2 < self.width) {
    if(var_1 > 0) {
      self.bar scaleovertime((1 - var_0) / var_1, self.width, self.height);
    } else if(var_1 < 0) {
      self.bar scaleovertime(var_0 / (-1 * var_1), 1, self.height);
    }
  }

  self.bar.rateofchange = var_1;
  self.bar.lastupdatetime = gettime();
}

createprimaryprogressbartext(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  var_1 = maps\_hud_util::createserverclientfontstring("hudbig", level.primaryprogressbarfontsize);
  var_1.hidden = 0;
  var_1 chaos_setpoint("CENTER", undefined, level.primaryprogressbartextx, level.primaryprogressbartexty - var_0);
  var_1.sort = -1;
  return var_1;
}

createprimaryprogressbar(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  var_1 = chaos_createbar((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
  var_1 chaos_setpoint("CENTER", undefined, level.primaryprogressbarx, level.primaryprogressbary - var_0);
  return var_1;
}

chaos_createbar(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.frac = 0;
  var_4.color = var_0;
  var_4.sort = -2;
  var_4.shader = "progress_bar_fill";
  var_4 setshader("progress_bar_fill", var_1, var_2);
  var_4.hidden = 0;

  if(isDefined(var_3)) {
    var_4.flashfrac = var_3;
  }
  var_5 = newclienthudelem(self);
  var_5.elemtype = "bar";
  var_5.width = var_1;
  var_5.height = var_2;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.bar = var_4;
  var_5.children = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  var_5.padding = 0;
  var_5 maps\_hud_util::setparent(level.uiparent);
  var_5 setshader("progress_bar_bg", var_1 + 4, var_2 + 4);
  var_5.hidden = 0;
  return var_5;
}

chaos_setpoint(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }
  var_5 = maps\_hud_util::getparent();

  if(var_4) {
    self moveovertime(var_4);
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  self.xoffset = var_2;

  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  self.yoffset = var_3;
  self.point = var_0;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(var_0, "TOP")) {
    self.aligny = "top";
  }
  if(issubstr(var_0, "BOTTOM")) {
    self.aligny = "bottom";
  }
  if(issubstr(var_0, "LEFT")) {
    self.alignx = "left";
  }
  if(issubstr(var_0, "RIGHT")) {
    self.alignx = "right";
  }
  if(!isDefined(var_1)) {
    var_1 = var_0;
  }
  self.relativepoint = var_1;
  var_6 = "center_adjustable";
  var_7 = "middle";

  if(issubstr(var_1, "TOP")) {
    var_7 = "top_adjustable";
  }
  if(issubstr(var_1, "BOTTOM")) {
    var_7 = "bottom_adjustable";
  }
  if(issubstr(var_1, "LEFT")) {
    var_6 = "left_adjustable";
  }
  if(issubstr(var_1, "RIGHT")) {
    var_6 = "right_adjustable";
  }
  if(var_5 == level.uiparent) {
    self.horzalign = var_6;
    self.vertalign = var_7;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(strip_suffix(var_6, "_adjustable") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_6 == "center" || var_5.alignx == "center") {
    var_8 = int(var_5.width / 2);

    if(var_6 == "left_adjustable" || var_5.alignx == "right") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  } else {
    var_8 = var_5.width;

    if(var_6 == "left_adjustable") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  }

  self.x = var_5.x + var_8 * var_9;

  if(strip_suffix(var_7, "_adjustable") == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_7 == "middle" || var_5.aligny == "middle") {
    var_10 = int(var_5.height / 2);

    if(var_7 == "top_adjustable" || var_5.aligny == "bottom") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  } else {
    var_10 = var_5.height;

    if(var_7 == "top_adjustable") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  }

  self.y = var_5.y + var_10 * var_11;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;

  switch (self.elemtype) {
    case "bar":
      chaos_setpointbar(var_0, var_1, var_2, var_3);
      break;
  }

  maps\_hud_util::updatechildren();
}

chaos_setpointbar(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "left") {
    self.bar.x = self.x;
  } else if(self.alignx == "right") {
    self.bar.x = self.x - self.width;
  } else {
    self.bar.x = self.x - int(self.width / 2);
  }
  if(self.aligny == "top") {
    self.bar.y = self.y;
  } else if(self.aligny == "bottom") {
    self.bar.y = self.y;
  }
  chaos_updatebar(self.bar.frac);
}

strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size) {
    return var_0;
  }
  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
    return getsubstr(var_0, 0, var_0.size - var_1.size);
  }
  return var_0;
}

destroyiconsondeath() {
  self notify("destroyIconsOnDeath");
  self endon("destroyIconsOnDeath");
  self waittill("death");

  foreach(var_1 in self._id_3BCC) {}
  var_1 destroy();
}

keeppositioned(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  var_3 = var_0.origin;

  for(;;) {
    if(var_3 != var_0.origin) {
      var_3 = var_0.origin;
      self.x = var_3[0] + var_1[0];
      self.y = var_3[0] + var_1[0];
      self.z = var_3[0] + var_1[0];
    }

    wait 0.05;
  }
}

keepiconpositioned() {
  self endon("kill_entity_headicon_thread");
  self endon("death");
  var_0 = self.origin;

  for(;;) {
    if(var_0 != self.origin) {
      updateheadiconorigin();
      var_0 = self.origin;
    }

    wait 0.05;
  }
}

destroyheadiconsondeath() {
  self endon("kill_entity_headicon_thread");
  self waittill("death");

  if(!isDefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}

updateheadiconorigin() {
  self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
  self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
  self.entityheadicon.z = self.origin[2] + self.entityheadiconoffset[2];
}

perk_hud_popup_icon() {
  self endon("death");
  self.perk_hud_popup_icon = spawnStruct();
  self.perk_hud_popup_icon._id_3FCA = -30;

  if(issplitscreen()) {
    self.perk_hud_popup_icon._id_3FCB = 2 + (self == level.player) * 27;
  } else {
    self.perk_hud_popup_icon._id_3FCB = 86;
  }
  self.perk_hud_popup_icon._id_3FCC = 28;
  self.perk_hud_popup_icon.icon = chaos_special_item_hudelem(self.perk_hud_popup_icon._id_3FCA, self.perk_hud_popup_icon._id_3FCB);
  self.perk_hud_popup_icon.icon.color = (1, 1, 1);
  self.perk_hud_popup_icon.icon.alpha = 1.0;
  self.perk_hud_popup_icon.icon.children = [];
  self.perk_hud_popup_icon.icon maps\_hud_util::setparent(level.uiparent);
  self.perk_hud_popup_icon.icon thread chaos_perk_icon_destroy_on_mode_end();

  for(;;) {
    self waittill("perk_pop_up", var_0);

    if(isDefined(self.live_1_hud_icon.icon) && isDefined(self.live_2_hud_icon.icon) && isDefined(self.live_3_hud_icon.icon) && isDefined(self.live_4_hud_icon.icon) && isDefined(self.live_5_hud_icon.icon)) {
      if(!issplitscreen()) {
        self.live_1_hud_icon.icon.alpha = 0.0;
        self.live_2_hud_icon.icon.alpha = 0.0;
        self.live_3_hud_icon.icon.alpha = 0.0;
        self.live_4_hud_icon.icon.alpha = 0.0;
        self.live_5_hud_icon.icon.alpha = 0.0;
      }
    }

    var_1 = getperkname(var_0);

    if(var_0 == "specialty_juiced") {
      var_2 = "chaos_specialty_juiced";
    } else if(var_0 == "specialty_armorvest") {
      var_2 = "chaos_specialty_armorvest";
    } else {
      var_2 = level._id_3D68["airsupport"][var_0].icon;
    }
    self.perk_hud_popup_icon.icon setshader(var_2, self.perk_hud_popup_icon._id_3FCC, self.perk_hud_popup_icon._id_3FCC);
    self.perk_hud_popup_icon.icon.alpha = 0.85;

    if(issplitscreen()) {
      self.perk_hud_popup_icon.icon maps\_hud_util::setpoint("LEFT", "CENTER", self.perk_hud_popup_icon._id_3FCA - 150, self.perk_hud_popup_icon._id_3FCB + 80);
    } else {
      self.perk_hud_popup_icon.icon maps\_hud_util::setpoint("LEFT", "CENTER", self.perk_hud_popup_icon._id_3FCA - 50, self.perk_hud_popup_icon._id_3FCB + 30);
    }
    wait 0.2;

    if(issplitscreen()) {
      self.perk_hud_popup_icon.icon setshader(var_2, self.perk_hud_popup_icon._id_3FCC * 2, self.perk_hud_popup_icon._id_3FCC * 2);
    } else {
      self.perk_hud_popup_icon.icon setshader(var_2, self.perk_hud_popup_icon._id_3FCC * 3, self.perk_hud_popup_icon._id_3FCC * 3);
    }
    wait 0.45;
    self.perk_hud_popup_icon.icon setshader(var_2, self.perk_hud_popup_icon._id_3FCC, self.perk_hud_popup_icon._id_3FCC);

    if(issplitscreen()) {
      self.perk_hud_popup_icon.icon maps\_hud_util::setpoint("LEFT", "BOTTOM LEFT", 241 - self.num_perk_obtained * 30 + level.perk_offset + (self != level.player) * 100, -8, 0.35);
    } else {
      self.perk_hud_popup_icon.icon maps\_hud_util::setpoint("LEFT", "BOTTOM LEFT", 241 - self.num_perk_obtained * 30 + level.perk_offset, -8, 0.35);
    }
    wait 0.35;
    self.perk_hud_popup_icon.icon.alpha = 0;

    if(self.num_perk_obtained > 1) {
      var_3 = "give_perk_" + self.num_perk_obtained;
      self notify(var_3, var_0);
    } else {
      self notify("give_perk", var_0);
    }
    level.player_currently_getting_perk = 0;
    level notify("proceed_with_next_perk");

    if(!maps\_utility::_id_1A43(self)) {
      update_lives_left_hud(self._id_132B._id_1A53, 1);
    }
  }
}

live_1_hud_icon() {
  self endon("death");
  self.live_1_hud_icon = spawnStruct();
  self.live_1_hud_icon._id_3FCA = -75;

  if(issplitscreen()) {
    self.live_1_hud_icon._id_3FCB = 2 + (self == level.player) * 27;
  } else {
    self.live_1_hud_icon._id_3FCB = 86;
  }
  self.live_1_hud_icon._id_3FCC = 28;
  self.live_1_hud_icon.icon = chaos_special_item_hudelem(self.live_1_hud_icon._id_3FCA, self.live_1_hud_icon._id_3FCB);
  self.live_1_hud_icon.icon.color = (1, 1, 1);
  self.live_1_hud_icon.icon.alpha = 0.0;
  self.live_1_hud_icon.icon.children = [];
  self.live_1_hud_icon.icon maps\_hud_util::setparent(level.uiparent);
  self.live_1_hud_icon.icon thread chaos_perk_icon_destroy_on_mode_end();
  self.live_1_hud_icon.icon setshader("specialty_self_revive", self.live_1_hud_icon._id_3FCC, self.live_1_hud_icon._id_3FCC);
  self.live_1_hud_icon.icon maps\_hud_util::setpoint("LEFT", "TOP", self.live_1_hud_icon._id_3FCA, self.live_1_hud_icon._id_3FCB - 55);
}

live_2_hud_icon() {
  self endon("death");
  self.live_2_hud_icon = spawnStruct();
  self.live_2_hud_icon._id_3FCA = -45;

  if(issplitscreen()) {
    self.live_2_hud_icon._id_3FCB = 2 + (self == level.player) * 27;
  } else {
    self.live_2_hud_icon._id_3FCB = 86;
  }
  self.live_2_hud_icon._id_3FCC = 28;
  self.live_2_hud_icon.icon = chaos_special_item_hudelem(self.live_2_hud_icon._id_3FCA, self.live_2_hud_icon._id_3FCB);
  self.live_2_hud_icon.icon.color = (1, 1, 1);
  self.live_2_hud_icon.icon.alpha = 0.0;
  self.live_2_hud_icon.icon.children = [];
  self.live_2_hud_icon.icon maps\_hud_util::setparent(level.uiparent);
  self.live_2_hud_icon.icon thread chaos_perk_icon_destroy_on_mode_end();
  self.live_2_hud_icon.icon setshader("specialty_self_revive", self.live_2_hud_icon._id_3FCC, self.live_2_hud_icon._id_3FCC);
  self.live_2_hud_icon.icon maps\_hud_util::setpoint("LEFT", "TOP", self.live_2_hud_icon._id_3FCA, self.live_2_hud_icon._id_3FCB - 55);
}

live_3_hud_icon() {
  self endon("death");
  self.live_3_hud_icon = spawnStruct();
  self.live_3_hud_icon._id_3FCA = -15;

  if(issplitscreen()) {
    self.live_3_hud_icon._id_3FCB = 2 + (self == level.player) * 27;
  } else {
    self.live_3_hud_icon._id_3FCB = 86;
  }
  self.live_3_hud_icon._id_3FCC = 28;
  self.live_3_hud_icon.icon = chaos_special_item_hudelem(self.live_3_hud_icon._id_3FCA, self.live_3_hud_icon._id_3FCB);
  self.live_3_hud_icon.icon.color = (1, 1, 1);
  self.live_3_hud_icon.icon.alpha = 0.0;
  self.live_3_hud_icon.icon.children = [];
  self.live_3_hud_icon.icon maps\_hud_util::setparent(level.uiparent);
  self.live_3_hud_icon.icon thread chaos_perk_icon_destroy_on_mode_end();
  self.live_3_hud_icon.icon setshader("specialty_self_revive", self.live_3_hud_icon._id_3FCC, self.live_3_hud_icon._id_3FCC);
  self.live_3_hud_icon.icon maps\_hud_util::setpoint("LEFT", "TOP", self.live_3_hud_icon._id_3FCA, self.live_3_hud_icon._id_3FCB - 55);
}

live_4_hud_icon() {
  self endon("death");
  self.live_4_hud_icon = spawnStruct();
  self.live_4_hud_icon._id_3FCA = 15;

  if(issplitscreen()) {
    self.live_4_hud_icon._id_3FCB = 2 + (self == level.player) * 27;
  } else {
    self.live_4_hud_icon._id_3FCB = 86;
  }
  self.live_4_hud_icon._id_3FCC = 28;
  self.live_4_hud_icon.icon = chaos_special_item_hudelem(self.live_4_hud_icon._id_3FCA, self.live_4_hud_icon._id_3FCB);
  self.live_4_hud_icon.icon.color = (1, 1, 1);
  self.live_4_hud_icon.icon.alpha = 0.0;
  self.live_4_hud_icon.icon.children = [];
  self.live_4_hud_icon.icon maps\_hud_util::setparent(level.uiparent);
  self.live_4_hud_icon.icon thread chaos_perk_icon_destroy_on_mode_end();
  self.live_4_hud_icon.icon setshader("specialty_self_revive", self.live_4_hud_icon._id_3FCC, self.live_4_hud_icon._id_3FCC);
  self.live_4_hud_icon.icon maps\_hud_util::setpoint("LEFT", "TOP", self.live_4_hud_icon._id_3FCA, self.live_4_hud_icon._id_3FCB - 55);
}

live_5_hud_icon() {
  self endon("death");
  self.live_5_hud_icon = spawnStruct();
  self.live_5_hud_icon._id_3FCA = 45;

  if(issplitscreen()) {
    self.live_5_hud_icon._id_3FCB = 2 + (self == level.player) * 27;
  } else {
    self.live_5_hud_icon._id_3FCB = 86;
  }
  self.live_5_hud_icon._id_3FCC = 28;
  self.live_5_hud_icon.icon = chaos_special_item_hudelem(self.live_5_hud_icon._id_3FCA, self.live_5_hud_icon._id_3FCB);
  self.live_5_hud_icon.icon.color = (1, 1, 1);
  self.live_5_hud_icon.icon.alpha = 0.0;
  self.live_5_hud_icon.icon.children = [];
  self.live_5_hud_icon.icon maps\_hud_util::setparent(level.uiparent);
  self.live_5_hud_icon.icon thread chaos_perk_icon_destroy_on_mode_end();
  self.live_5_hud_icon.icon setshader("specialty_self_revive", self.live_5_hud_icon._id_3FCC, self.live_5_hud_icon._id_3FCC);
  self.live_5_hud_icon.icon maps\_hud_util::setpoint("LEFT", "TOP", self.live_5_hud_icon._id_3FCA, self.live_5_hud_icon._id_3FCB - 55);
}

hud_weapon_icon() {
  self endon("death");
  self.hud_weapon_icon = spawnStruct();
  self.hud_weapon_icon._id_3FCA = 0;

  if(issplitscreen()) {
    self.hud_weapon_icon._id_3FCB = -122 + (self == level.player) * 27;
  } else {
    self.hud_weapon_icon._id_3FCB = -14;
  }
  self.hud_weapon_icon._id_3FCC = 28;
  self.hud_weapon_icon.icon = chaos_special_item_hudelem(self.hud_weapon_icon._id_3FCA, self.hud_weapon_icon._id_3FCB);
  self.hud_weapon_icon.icon.color = (1, 1, 1);
  self.hud_weapon_icon.icon.alpha = 0.0;
  self.hud_weapon_icon.icon thread chaos_perk_icon_destroy_on_mode_end();

  for(;;) {
    self waittill("weapon_icon_popup", var_0);

    if(issubstr(var_0, "fmg9") || issubstr(var_0, "m9") || issubstr(var_0, "glock")) {
      self.hud_weapon_icon.icon setshader(var_0, 64, 64);
    } else {
      self.hud_weapon_icon.icon setshader(var_0, 128, 64);
    }
    self.hud_weapon_icon.icon.alpha = 0.85;
    thread weapon_icon_fadeaway();
  }
}

weapon_icon_fadeaway() {
  self notify("end_on_weapon_icon_fadeaway");
  self endon("end_on_weapon_icon_fadeaway");
  wait 0.05;
  self.hud_weapon_icon.icon fadeovertime(0.05);
  self.hud_weapon_icon.icon.alpha = 0;
}

perk_hud_2() {
  self endon("death");
  self.perk_icon_hud_2 = spawnStruct();
  self.perk_icon_hud_2._id_3FCA = -168 + level.perk_offset;

  if(issplitscreen()) {
    self.perk_icon_hud_2._id_3FCB = 112 + (self == level.player) * 27;
  } else {
    self.perk_icon_hud_2._id_3FCB = 196;
  }
  self.perk_icon_hud_2._id_3FCC = 28;
  self.perk_icon_hud_2.icon = chaos_special_item_hudelem(self.perk_icon_hud_2._id_3FCA, self.perk_icon_hud_2._id_3FCB);
  self.perk_icon_hud_2.icon.color = (1, 1, 1);
  self.perk_icon_hud_2.icon.alpha = 0.0;
  self.perk_icon_hud_2.icon thread chaos_perk_icon_destroy_on_mode_end();

  for(;;) {
    self waittill("give_perk_2", var_0);

    if(var_0 == "specialty_juiced") {
      var_1 = "chaos_specialty_juiced";
    } else if(var_0 == "specialty_armorvest") {
      var_1 = "chaos_specialty_armorvest";
    } else {
      var_1 = level._id_3D68["airsupport"][var_0].icon;
    }
    self.perk_icon_hud_2.icon setshader(var_1, self.perk_icon_hud_2._id_3FCC, self.perk_icon_hud_2._id_3FCC);
    self.perk_icon_hud_2.icon.alpha = 0.85;
  }
}

perk_hud_3() {
  self endon("death");
  self.perk_icon_hud_3 = spawnStruct();
  self.perk_icon_hud_3._id_3FCA = -198 + level.perk_offset;

  if(issplitscreen()) {
    self.perk_icon_hud_3._id_3FCB = 112 + (self == level.player) * 27;
  } else {
    self.perk_icon_hud_3._id_3FCB = 196;
  }
  self.perk_icon_hud_3._id_3FCC = 28;
  self.perk_icon_hud_3.icon = chaos_special_item_hudelem(self.perk_icon_hud_3._id_3FCA, self.perk_icon_hud_3._id_3FCB);
  self.perk_icon_hud_3.icon.color = (1, 1, 1);
  self.perk_icon_hud_3.icon.alpha = 0.0;
  self.perk_icon_hud_3.icon thread chaos_perk_icon_destroy_on_mode_end();

  for(;;) {
    self waittill("give_perk_3", var_0);

    if(var_0 == "specialty_juiced") {
      var_1 = "chaos_specialty_juiced";
    } else if(var_0 == "specialty_armorvest") {
      var_1 = "chaos_specialty_armorvest";
    } else {
      var_1 = level._id_3D68["airsupport"][var_0].icon;
    }
    self.perk_icon_hud_3.icon setshader(var_1, self.perk_icon_hud_3._id_3FCC, self.perk_icon_hud_3._id_3FCC);
    self.perk_icon_hud_3.icon.alpha = 0.85;
  }
}

perk_hud_4() {
  self endon("death");
  self.perk_icon_hud_4 = spawnStruct();
  self.perk_icon_hud_4._id_3FCA = -228 + level.perk_offset;

  if(issplitscreen()) {
    self.perk_icon_hud_4._id_3FCB = 112 + (self == level.player) * 27;
  } else {
    self.perk_icon_hud_4._id_3FCB = 196;
  }
  self.perk_icon_hud_4._id_3FCC = 28;
  self.perk_icon_hud_4.icon = chaos_special_item_hudelem(self.perk_icon_hud_4._id_3FCA, self.perk_icon_hud_4._id_3FCB);
  self.perk_icon_hud_4.icon.color = (1, 1, 1);
  self.perk_icon_hud_4.icon.alpha = 0.0;
  self.perk_icon_hud_4.icon thread chaos_perk_icon_destroy_on_mode_end();

  for(;;) {
    self waittill("give_perk_4", var_0);

    if(var_0 == "specialty_juiced") {
      var_1 = "chaos_specialty_juiced";
    } else if(var_0 == "specialty_armorvest") {
      var_1 = "chaos_specialty_armorvest";
    } else {
      var_1 = level._id_3D68["airsupport"][var_0].icon;
    }
    self.perk_icon_hud_4.icon setshader(var_1, self.perk_icon_hud_4._id_3FCC, self.perk_icon_hud_4._id_3FCC);
    self.perk_icon_hud_4.icon.alpha = 0.85;
  }
}

perk_hud_5() {
  self endon("death");
  self.perk_icon_hud_5 = spawnStruct();
  self.perk_icon_hud_5._id_3FCA = -258 + level.perk_offset;

  if(issplitscreen()) {
    self.perk_icon_hud_5._id_3FCB = 112 + (self == level.player) * 27;
  } else {
    self.perk_icon_hud_5._id_3FCB = 196;
  }
  self.perk_icon_hud_5._id_3FCC = 28;
  self.perk_icon_hud_5.icon = chaos_special_item_hudelem(self.perk_icon_hud_5._id_3FCA, self.perk_icon_hud_5._id_3FCB);
  self.perk_icon_hud_5.icon.color = (1, 1, 1);
  self.perk_icon_hud_5.icon.alpha = 0.0;
  self.perk_icon_hud_5.icon thread chaos_perk_icon_destroy_on_mode_end();

  for(;;) {
    self waittill("give_perk_5", var_0);

    if(var_0 == "specialty_juiced") {
      var_1 = "chaos_specialty_juiced";
    } else if(var_0 == "specialty_armorvest") {
      var_1 = "chaos_specialty_armorvest";
    } else {
      var_1 = level._id_3D68["airsupport"][var_0].icon;
    }
    self.perk_icon_hud_5.icon setshader(var_1, self.perk_icon_hud_5._id_3FCC, self.perk_icon_hud_5._id_3FCC);
    self.perk_icon_hud_5.icon.alpha = 0.85;
  }
}

perk_hud_6() {
  self endon("death");
  self.perk_icon_hud_6 = spawnStruct();
  self.perk_icon_hud_6._id_3FCA = -288 + level.perk_offset;

  if(issplitscreen()) {
    self.perk_icon_hud_6._id_3FCB = 112 + (self == level.player) * 27;
  } else {
    self.perk_icon_hud_6._id_3FCB = 196;
  }
  self.perk_icon_hud_6._id_3FCC = 28;
  self.perk_icon_hud_6.icon = chaos_special_item_hudelem(self.perk_icon_hud_6._id_3FCA, self.perk_icon_hud_6._id_3FCB);
  self.perk_icon_hud_6.icon.color = (1, 1, 1);
  self.perk_icon_hud_6.icon.alpha = 0.0;
  self.perk_icon_hud_6.icon thread chaos_perk_icon_destroy_on_mode_end();

  for(;;) {
    self waittill("give_perk_6", var_0);

    if(var_0 == "specialty_juiced") {
      var_1 = "chaos_specialty_juiced";
    } else if(var_0 == "specialty_armorvest") {
      var_1 = "chaos_specialty_armorvest";
    } else {
      var_1 = level._id_3D68["airsupport"][var_0].icon;
    }
    self.perk_icon_hud_6.icon setshader(var_1, self.perk_icon_hud_6._id_3FCC, self.perk_icon_hud_6._id_3FCC);
    self.perk_icon_hud_6.icon.alpha = 0.85;
  }
}

perk_hud_7() {
  self endon("death");
  self.perk_icon_hud_7 = spawnStruct();
  self.perk_icon_hud_7._id_3FCA = -318 + level.perk_offset;

  if(issplitscreen()) {
    self.perk_icon_hud_7._id_3FCB = 112 + (self == level.player) * 27;
  } else {
    self.perk_icon_hud_7._id_3FCB = 196;
  }
  self.perk_icon_hud_7._id_3FCC = 28;
  self.perk_icon_hud_7.icon = chaos_special_item_hudelem(self.perk_icon_hud_7._id_3FCA, self.perk_icon_hud_7._id_3FCB);
  self.perk_icon_hud_7.icon.color = (1, 1, 1);
  self.perk_icon_hud_7.icon.alpha = 0.0;
  self.perk_icon_hud_7.icon thread chaos_perk_icon_destroy_on_mode_end();

  for(;;) {
    self waittill("give_perk_7", var_0);

    if(var_0 == "specialty_juiced") {
      var_1 = "chaos_specialty_juiced";
    } else if(var_0 == "specialty_armorvest") {
      var_1 = "chaos_specialty_armorvest";
    } else {
      var_1 = level._id_3D68["airsupport"][var_0].icon;
    }
    self.perk_icon_hud_7.icon setshader(var_1, self.perk_icon_hud_7._id_3FCC, self.perk_icon_hud_7._id_3FCC);
    self.perk_icon_hud_7.icon.alpha = 0.85;
  }
}

chaos_perk_icon_destroy_on_mode_end() {
  level waittill("special_op_terminated");
  self destroy();
}

chaos_special_item_hudelem(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.hidden = 0;
  var_2.elemtype = "icon";
  var_2.hidewheninmenu = 1;
  var_2.archived = 0;
  var_2.x = var_0;
  var_2.y = var_1;
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "center";
  var_2.vertalign = "middle";
  return var_2;
}

createchaosscorepopup() {
  var_0 = newclienthudelem(self);
  var_0.children = [];
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.alignx = "center";
  var_0.aligny = "middle";

  if(issplitscreen()) {
    var_0.x = 60;
    var_0.y = 30;
  } else {
    var_0.x = 50;
    var_0.y = 0;
  }

  var_0.font = "hudbig";
  var_0.fontscale = 0.8;
  var_0.archived = 0;
  var_0.color = (1, 1, 0.8);
  var_0.sort = 10000;
  var_0.elemtype = "msgText";
  var_0 chaosfontpulseinit(3);
  return var_0;
}

chaosscorepopup(var_0, var_1, var_2) {
  thread chaosscorepopupfinalize(var_0, var_1, var_2);
  thread chaosscorepopupterminate();
}

chaosscorepopupfinalize(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self notify("chaosScorePopup");
  self endon("chaosScorePopup");
  wait 0.05;

  if(!isDefined(var_1)) {
    var_1 = (1, 1, 0.5);
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  if(!isDefined(self)) {
    return;
  }
  self.hud_chaosscorepopup.color = var_1;
  self.hud_chaosscorepopup.glowcolor = var_1;
  self.hud_chaosscorepopup.glowalpha = var_2;
  self.hud_chaosscorepopup settext(var_0);
  self.hud_chaosscorepopup.alpha = 0.85;
  wait 1.0;

  if(!isDefined(self)) {
    return;
  }
  self.hud_chaosscorepopup fadeovertime(0.75);
  self.hud_chaosscorepopup.alpha = 0;
  self notify("ScorePopComplete");
}

chaosscorepopupterminate() {
  self endon("ScorePopComplete");
  common_scripts\utility::waittill_any("joined_team", "joined_spectators");
  self.hud_chaosscorepopup fadeovertime(0.05);
  self.hud_chaosscorepopup.alpha = 0;
}

createchaoseventpopup() {
  var_0 = newclienthudelem(self);
  var_0.children = [];
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.x = 55;

  if(issplitscreen()) {
    var_0.y = -35;
  } else {
    var_0.y = -35;
  }
  var_0.font = "hudbig";
  var_0.fontscale = 0.65;
  var_0.archived = 0;
  var_0.color = (1, 1, 0.8);
  var_0.sort = 10000;
  var_0.elemtype = "msgText";
  var_0 chaosfontpulseinit(3);
  return var_0;
}

chaosfontpulseinit(var_0) {
  self.basefontscale = self.fontscale;

  if(isDefined(var_0)) {
    self.maxfontscale = min(var_0, 6.3);
  } else {
    self.maxfontscale = min(self.fontscale * 2, 6.3);
  }
  self.inframes = 2;
  self.outframes = 4;
}

chaoseventpopup(var_0, var_1, var_2, var_3) {
  thread chaoseventpopupfinalize(var_0, var_1, var_2, var_3);
  thread chaoseventpopupterminate();
}

chaoseventpopupfinalize(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self notify("chaosEventPopup");
  self endon("chaosEventPopup");
  wait 0.05;

  if(!isDefined(var_1)) {
    var_1 = (1, 1, 0.5);
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  if(!isDefined(self)) {
    return;
  }
  self.hud_chaoseventpopup.color = var_1;
  self.hud_chaoseventpopup.glowcolor = var_1;
  self.hud_chaoseventpopup.glowalpha = var_2;
  self.hud_chaoseventpopup settext(var_0);
  self.hud_chaoseventpopup.alpha = 0.85;

  if(!isDefined(var_3)) {
    var_3 = 0.05;
  }
  wait(var_3);

  if(!isDefined(self)) {
    return;
  }
  self.hud_chaoseventpopup fadeovertime(0.05);
  self.hud_chaoseventpopup.alpha = 0;
  self notify("PopComplete");

  if(isDefined(self._id_1A96)) {
    self notify("sentry_notification", &"SENTRY_PLACE");
  }
}

chaoseventpopupterminate() {
  self endon("PopComplete");
  common_scripts\utility::waittill_any("joined_team", "joined_spectators");
  self.hud_chaoseventpopup fadeovertime(0.05);
  self.hud_chaoseventpopup.alpha = 0;
}

chaos_combo_splash(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_3E1B = var_0;
  var_2.duration = 1.5;
  thread chaos_splash_radio(var_1);
  player_combo_splash(var_2);
}

chaos_splash_radio(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = undefined;

  switch (var_0) {
    case "cm_bp_kills_explosion":
      var_1 = "chaos_action_explosion";
      break;
    case "cm_bp_kills_3longshot":
      var_1 = "chaos_action_3longshot";
      break;
    case "cm_bp_kills_3headshot":
      var_1 = "chaos_action_3headshot";
      break;
    case "cm_bp_kills_3knife":
      var_1 = "chaos_action_3knife";
      break;
    case "cm_bp_kills_triple":
      var_1 = "chaos_action_triple";
      break;
    case "cm_bp_kills_quad":
      var_1 = "chaos_action_quad";
      break;
    case "cm_bp_kills_multiple":
      var_1 = "chaos_action_multiple";
      break;
    default:
      break;
  }

  if(isDefined(var_1)) {
    thread radio_dialogue_to_player(self, var_1, 1.0);
  }
}

player_combo_splash(var_0) {
  if(isDefined(self._id_12C6) && self._id_12C6) {
    while(self._id_12C6) {
      wait 0.05;
    }
  }

  if(!isDefined(var_0.duration)) {
    var_0.duration = 1.5;
  }
  var_0._id_3E20 = (0, 0, 0);
  var_0._id_3E21 = (0.95, 0.95, 0);
  var_0.type = "wave";
  var_0._id_3E1D = "hudbig";
  var_0._id_3E31 = 1;
  var_0._id_3E2E = 1;
  var_0._id_3E34 = 1;
  var_0._id_15E0 = 1;
  var_0._id_3E33 = 1;

  if(issplitscreen()) {
    var_0._id_3E1F = 1;
    var_0._id_3E24 = 1.2;
    thread turn_lives_hud_back_after_splash(var_0.duration);
  } else {
    var_0._id_3E1F = 1.1;
    var_0._id_3E24 = 1.2;
  }

  _id_0618::_id_3E14(var_0);
}

turn_lives_hud_back_after_splash(var_0) {
  level endon("special_op_terminated");
  self notify("stop_turn_lives_back_on_wait");
  self endon("stop_turn_lives_back_on_wait");

  if(isDefined(self.live_1_hud_icon.icon) && isDefined(self.live_2_hud_icon.icon) && isDefined(self.live_3_hud_icon.icon) && isDefined(self.live_4_hud_icon.icon) && isDefined(self.live_5_hud_icon.icon)) {
    self.live_1_hud_icon.icon.alpha = 0.0;
    self.live_2_hud_icon.icon.alpha = 0.0;
    self.live_3_hud_icon.icon.alpha = 0.0;
    self.live_4_hud_icon.icon.alpha = 0.0;
    self.live_5_hud_icon.icon.alpha = 0.0;
  }

  wait(var_0 + 0.5);
  update_lives_left_hud(self._id_132B._id_1A53);
}

chaos_killstreak_autosentry_main(var_0) {
  common_scripts / _sentry::givesentry("sentry_minigun");
  thread chaos_sentry_cancel_notify();
  self notifyonplayercommand("controller_sentry_cancel", "+actionslot 4");
  self notifyonplayercommand("controller_sentry_cancel", "weapnext");
  chaos_waittill_any("sentry_placement_finished", "sentry_placement_canceled");
  chaos_post_killstreak_weapon_switchback();
  return 1;
}

chaos_waittill_any(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }
  self waittill(var_0);
  chaos_score_event_raise("placed_sentry");
}

chaos_sentry_cancel_notify() {
  self endon("sentry_placement_canceled");
  self endon("sentry_placement_finished");
  self waittill("controller_sentry_cancel");

  if(!isDefined(self._id_00D3) || !self._id_00D3) {
    self notify("sentry_placement_canceled");
  }
}

chaos_post_killstreak_weapon_switchback() {
  if(maps\_utility::_id_1A43(self)) {
    return;
  }
  if(isDefined(self._id_3CE3._id_3CF6)) {
    if(self._id_3CE3._id_3CF6 == "none") {
      var_0 = self getweaponslistprimaries();
      self switchtoweapon(var_0[0]);
    } else {
      self switchtoweapon(self._id_3CE3._id_3CF6);
    }
  }
}

_id_3BAB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  self.owner endon("disconnect");
  var_6 = _id_3BAC(self.owner, var_0, var_5);
  var_6 linkto(self, "tag_ground", (32, 0, 5), (0, 0, 0));
  var_6.angles = (0, 0, 0);
  var_6 show();
  var_7 = self.veh_speed;
  self waittill("drop_crate");
  var_6 unlink();
  var_6 physicslaunchserver((0, 0, 0), (randomint(5), randomint(5), randomint(5)));
  var_6 thread _id_3BB7();
  var_6 thread _id_00D2(var_1, 64);
}

_id_3BAC(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_2);
  var_3.inuse = 0;
  var_3.curprogress = 0;
  var_3.usetime = 0;
  var_3.userate = 0;

  if(isDefined(var_0)) {
    var_3.owner = var_0;
  } else {
    var_3.owner = undefined;
  }
  var_3.cratetype = var_1;
  var_3.targetname = "care_package";
  var_3 setModel("com_plasticcase_taskforce141");
  var_3 _id_3BB4();
  var_3.collision thread _id_3BB6(var_3);
  var_3._id_3BAD = spawn("script_model", var_2);
  var_3._id_3BAD setModel("com_plasticcase_friendly");
  var_3._id_3BAD common_scripts\utility::delaycall(0.25, ::linkto, var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_3 thread _id_3BB5(var_0);
  level._id_3B9F++;
  return var_3;
}

_id_3BAE() {
  if(isDefined(level._id_3BAF) && level._id_3BAF.size) {
    level._id_3BAF = common_scripts\utility::array_remove(level._id_3BAF, self);
    level._id_3B9F--;
  }

  if(isDefined(self)) {
    if(isDefined(self.care_package_trigger)) {
      self.care_package_trigger delete();
    }
    self._id_3BAD delete();
    self delete();
  }
}

_id_3BB0() {
  var_0 = getEntArray("airdrop_crate_collision", "targetname");

  foreach(var_2 in var_0) {
    var_2 connectpaths();
    var_2 notsolid();
  }

  level._id_3BB1 = var_0;
}

_id_3BB2() {
  var_0 = undefined;

  foreach(var_2 in level._id_3BB1) {
    if(!isDefined(var_2._id_3BB3)) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

_id_3BB4() {
  var_0 = _id_3BB2();
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_0 solid();
  var_0 linkto(self);
  var_0._id_3BB3 = 1;
  self.collision = var_0;
}

_id_00D2(var_0, var_1) {
  while(isDefined(self) && distancesquared(self.origin, var_0) > 1024) {
    wait 0.05;
  }
  if(!isDefined(self)) {
    return;
  }
  var_2 = getaispeciesarray("axis", "all");

  foreach(var_4 in var_2) {
    if(distancesquared(self.origin, var_4.origin) < var_1 * var_1) {
      if(isDefined(self.owner)) {
        var_4 dodamage(300, self.origin, self.owner, self);
        continue;
      }

      var_4 dodamage(300, self.origin);
    }
  }
}

_id_3BB5(var_0) {
  var_0 waittill("death");
  _id_3BAE();
}

sp_airdrop_crate_delete_when_owner_pickups_one_crate() {
  self endon("death");
  level waittill("delete_all_crates");
  _id_3BAE();
}

_id_3BB6(var_0) {
  var_0 waittill("death");
  self unlink();
  self connectpaths();
  self notsolid();
  self._id_3BB3 = undefined;
}

_id_3BB7() {
  self waittill("physics_finished");
  self._id_3BB8 = gettime();

  if(!isDefined(level._id_3BAF)) {
    level._id_3BAF = [];
  }
  level._id_3BAF[level._id_3BAF.size] = self;

  if(level._id_3BAF.size > 4) {
    level._id_3BAF[0] _id_3BAE();
    level._id_3BAF[1] _id_3BAE();
  }

  thread _id_3BBB();
  level thread _id_3BB9(self, self.owner);
}

_id_3BB9(var_0, var_1) {
  var_0 endon("death");
  var_2 = 120;

  if(isDefined(level._id_3BBA)) {
    var_2 = level._id_3BBA;
  }
  if(var_2 <= 0) {
    return;
  }
  wait(var_2);

  while(var_0.curprogress != 0) {
    wait 1;
  }
  var_0 _id_3BAE();
}

_id_3BBB() {
  self endon("death");
  _id_3BC3();
  var_0 = spawn("trigger_radius", self.origin, 0, 50, 50);
  var_0 enablelinkto();
  var_0 linkto(self);
  var_0.radius = self;
  var_0.owner = self;
  self.care_package_trigger = var_0;
  var_0 thread cratetriggerthink(self._id_3BBD.cratehudstring);
  thread _id_3BCE();

  if(isDefined(level._id_3BBC)) {
    self thread[[level._id_3BBC]]();
  }
  for(;;) {
    self waittill("captured", var_1);

    if(isDefined(self.owner) && var_1 != self.owner) {
      thread _id_3BC0(var_1);
    }
    if(isPlayer(var_1)) {
      var_2 = var_1;
      var_2 playlocalsound("cm_use_carepackage");

      if(isDefined(self._id_3BBD._id_3BBE)) {
        if(issubstr(self._id_3BBD.streaktype, "specialty_")) {
          var_2 thread chaos_give_perk(self._id_3BBD.streaktype);
        } else {
          var_2 thread[[self._id_3BBD._id_3BBE]]();
        }
      } else {
        var_2 thread _id_0611::_id_3BBF(self.cratetype);
      }
    }

    _id_3BAE();
  }
}

cratetriggerthink(var_0) {
  level endon("special_op_terminated");
  self.owner endon("death");
  var_1 = &"SO_SURVIVAL_CHAOS_BONUS_SENTRY";
  var_2 = &"SO_SURVIVAL_CHAOS_BONUS_FREEZE_METER";

  for(;;) {
    self waittill("trigger", var_3);
    var_3 chaoseventpopup(var_0, (1, 1, 1));

    if(!isPlayer(var_3) || var_3 _id_0611::isusingremote() || !var_3 usebuttonpressed()) {
      continue;
    }
    if(isDefined(var_3.justopencrate) && var_3.justopencrate == 1) {
      continue;
    }
    if(isPlayer(var_3)) {
      if(var_0 == var_1) {
        if(var_3 hasweapon("chaos_freeze_meter")) {
          var_3 takeweapon("chaos_freeze_meter");
          level notify("stop_wait_for_meter_freeze_activation");
        }
      }

      if(var_0 == var_2) {
        if(var_3 hasweapon("chaos_freeze_meter")) {
          level notify("stop_wait_for_meter_freeze_activation");
        }
      }

      self.owner notify("captured", var_3);
      chaos_score_event_raise("care_package");
      level notify("crate_captured");
      var_3.justopencrate = 1;
      var_3 thread resetjustopencrateflag();
      break;
    }
  }
}

resetjustopencrateflag() {
  level endon("special_op_terminated");
  wait 1.0;
  self.justopencrate = 0;
}

_id_3BC0(var_0) {
  self notify("hijacked", var_0);

  if(!isPlayer(self.owner)) {
    return;
  }
  if(var_0.team == self.owner.team) {
    if(isDefined(level._id_3BC1)) {
      self.owner thread[[level._id_3BC1]](var_0);
    }
  } else if(isDefined(level._id_3BC2)) {
    self.owner thread[[level._id_3BC2]](var_0);
  }
}

_id_3BC3() {
  self.collision disconnectpaths();
  var_0 = _id_0611::_id_3BC4(self.cratetype);
  self._id_3BBD = var_0;
  _id_3BCB(var_0._id_3BC5, (0, 0, 12), 256, 256);
  self setcursorhint("HINT_NOICON");
  self makeusable();

  if(isDefined(level._id_3BC7) && level._id_3BC7) {
    thread _id_3BC8();
  }
}

_id_3BC8() {
  self endon("death");
  self endon("captured");
  wait 2;
  var_0 = undefined;
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(self.collision) && self.collision istouching(var_3)) {
      if(isDefined(self.owner) && self.owner == var_3) {
        var_0 = var_3;
        continue;
      }

      var_1[var_1.size] = var_3;
    }
  }

  if(isDefined(var_0)) {
    self notify("trigger", var_0);
    return;
  }

  if(var_1.size > 0) {
    self notify("trigger", var_1[0]);
  }
}

_id_3BC9() {
  var_0 = undefined;

  if(!isDefined(level._id_3BCA)) {
    var_0 = level._id_3B9E;
  } else {
    var_0 = level._id_3BCA + 1;
  }
  if(var_0 > level._id_3B9E + 7) {
    var_0 = level._id_3B9E;
  }
  level._id_3BCA = var_0;
  return var_0;
}

_id_3BCB(var_0, var_1, var_2, var_3) {
  self._id_3BCC = [];

  foreach(var_5 in level.players) {
    var_6 = var_5 chaos_special_item_hudelem(20, 20);
    var_6.children = [];
    var_6 maps\_hud_util::setparent(level.uiparent);
    var_6.archived = 1;
    var_6.x = self.origin[0] + var_1[0];
    var_6.y = self.origin[1] + var_1[1];
    var_6.z = self.origin[2] + var_1[2];
    var_6.alpha = 1;
    var_6 setshader(var_0, var_2, var_3);
    var_6 setwaypoint(0, 1, 0);
    var_6 thread keeppositioned(self, var_1, var_0);
    self._id_3BCC[self._id_3BCC.size] = var_6;
  }

  thread destroyiconsondeath();
}

_id_3BCE() {
  while(isDefined(self)) {
    self waittill("trigger", var_0);

    if(isDefined(self.owner) && var_0 == self.owner) {
      continue;
    }
    if(!_id_3BCF(var_0)) {
      continue;
    }
    self notify("captured", var_0);
    level notify("crate_captured");
  }
}

_id_3BCF(var_0, var_1) {
  var_0 freezecontrols(1);
  var_0 common_scripts\utility::_disableweapon();
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;

  if(isDefined(level._id_3BD0)) {
    self.usetime = level._id_3BD0;
  } else if(isDefined(var_1)) {
    self.usetime = var_1;
  } else {
    self.usetime = 3000;
  }
  if(self.usetime > 0) {
    var_0 thread _id_3BD2(self);
    var_2 = _id_3BD1(var_0);
  } else {
    var_2 = 1;
  }
  if(isalive(var_0)) {
    var_0 common_scripts\utility::_enableweapon();
    var_0 freezecontrols(0);
  }

  if(!isDefined(self)) {
    return 0;
  }
  self.inuse = 0;
  self.curprogress = 0;
  return var_2;
}

_id_3BD1(var_0) {
  while(isDefined(self) && isalive(var_0) && var_0 usebuttonpressed() && self.curprogress < self.usetime) {
    self.curprogress = self.curprogress + 50 * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }
    if(self.curprogress >= self.usetime) {
      return isalive(var_0);
    }
    wait 0.05;
  }

  return 0;
}

_id_3BD2(var_0) {
  self endon("disconnect");
  var_1 = createprimaryprogressbar(-25);
  var_2 = createprimaryprogressbartext(-25);
  var_2 settext(&"SP_KILLSTREAKS_CAPTURING_CRATE");
  var_3 = -1;

  while(isalive(self) && isDefined(var_0) && var_0.inuse) {
    if(var_3 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }
      var_1 chaos_updatebar(var_0.curprogress / var_0.usetime, 1000 / var_0.usetime * var_0.userate);

      if(!var_0.userate) {
        var_1 hideelem();
        var_2 hideelem();
      } else {
        var_1 showelem();
        var_2 showelem();
      }
    }

    var_3 = var_0.userate;
    wait 0.05;
  }

  var_1 chaos_destroyelem();
  var_2 chaos_destroyelem();
}

wait_and_display_lives_left_hud() {
  level endon("special_op_terminated");

  if(issplitscreen()) {
    wait 2.5;
  }
  update_lives_left_hud(self._id_132B._id_1A53);
}

player_have_max_lives() {
  var_0 = 0;
  var_1 = 0;

  foreach(var_3 in level._id_3BAF) {
    if(var_3.cratetype == "bonus_laststand") {
      var_1 = var_1 + 1;
    }
  }

  foreach(var_6 in level.players) {
    if(var_6._id_132B._id_1A53 + var_1 == 5) {
      var_0 = 1;
    }
  }

  return var_0;
}

generatesmokefx(var_0) {
  var_1 = spawnfx(level.grnd_fx["smoke"], var_0);
  triggerfx(var_1);
  wait 5;
  var_1 delete();
}

drop_item_already_used(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level.drop_item_used.size; var_2++) {
    if(level.drop_item_used[var_2] == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

chaos_give_weapon(var_0) {
  if(!isDefined(var_0) || var_0 == "") {
    return 0;
  }
  self giveweapon(var_0);
  _id_0626::_id_3F01(var_0);
  self switchtoweapon(var_0);
  return 1;
}

chaos_give_grenade(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "" || !isDefined(var_1) || var_1 == "") {
    return 0;
  }
  self giveweapon(var_0);

  if(var_1 == "max") {
    self setweaponammostock(var_0, weaponmaxammo(var_0));
  } else {
    self setweaponammostock(var_0, int(var_1));
  }
  if(var_0 == "flash_grenade") {
    self setoffhandsecondaryclass("flash");
  }
  return 1;
}

chaos_give_armor(var_0) {
  if(!isDefined(var_0) || var_0 == "") {
    return 0;
  }
  _id_0626::_id_3F1A("armor", int(var_0));
  return 1;
}

chaos_player_infinite_laststand() {
  for(;;) {
    self waittill("revived");
    maps\_laststand::_id_1ABE(1);
  }
}

chaos_player_infinite_ammo_pistol() {
  self endon("death");

  for(;;) {
    common_scripts\utility::waittill_either("reload", "weapon_change");

    if(isDefined(level._id_1AB1) && self hasweapon(level._id_1AB1)) {
      self setweaponammostock(level._id_1AB1, weaponmaxammo(level._id_1AB1));
    }
  }
}

chaos_music_intro() {
  wait 2;
  maps\_utility::_id_142B("music_intro_cm");
}

startcombodecayontimer() {
  level endon("special_op_terminated");
  level common_scripts\utility::waittill_notify_or_timeout("Start timer", 10);
  wait 20;

  if(level.start_combo_decay == 0) {
    level.start_combo_decay = 1;
    thread chaos_combo_on_end(4.0, 0.2);
  }
}

chaos_hud_survival_remove() {
  thread chaos_wave_hud_hide();
  wait 0.05;
  waittillframeend;
  common_scripts\utility::array_thread(level.players, maps\_specialops::_id_18A5, "credits");
  common_scripts\utility::array_thread(level.players, maps\_specialops::_id_18A5, "challenge");
  level._id_12E5 = 0;
}

chaos_wave_hud_hide() {
  self endon("death");
  level waittill("wave_started", var_0);
  waittillframeend;
  common_scripts\utility::array_thread(level.players, maps\_specialops::_id_18A5, "wave");
  common_scripts\utility::array_thread(level.players, maps\_specialops::_id_18A6, "surHUD_wave", 0);
}

wait_for_revive_teammate() {
  level endon("special_op_terminated");

  for(;;) {
    self waittill("so_revive_success");
    chaos_score_event_raise("revive_teammate");
  }
}

wait_for_death() {
  level endon("special_op_terminated");
  self waittill("death");
  chaos_running_score_update(level.chaos_combo_points, level.chaos_combo_count);
}

get_random_drop_item(var_0, var_1) {
  if(var_1 == 1) {
    return level.chaos_drop_items[var_0][0];
  } else {
    for(;;) {
      var_2 = randomint(level.chaos_drop_items[var_0].size);
      var_3 = level.chaos_drop_items[var_0][var_2];

      if(drop_item_already_used(var_3)) {
        continue;
      } else {
        level.drop_item_used[level.drop_item_used.size] = var_3;
        return var_3;
      }
    }
  }
}

chaos_dog_tags_spawn(var_0, var_1) {
  var_2 = spawn("script_model", var_0 + (0, 0, 24));

  if(var_1 == 1) {
    var_2 setModel("prop_dogtags_friend");
  } else {
    var_2 setModel("prop_dogtags_foe");
  }
  var_2 endon("death");
  var_3 = spawn("trigger_radius", var_0, 0, 32, 32);
  var_2 thread temp_chaos_dog_tags_rotate();
  var_2 thread chaos_dog_tags_flicker(10.0, 5.0);
  var_2 thread chaos_dog_tags_cleanup(10.0, var_3);

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(isDefined(var_4) && isPlayer(var_4)) {
      break;
    }
  }

  if(var_1 == 1) {
    chaos_score_event_raise("dogtag", "cm_redtag_pickup");
    var_5 = 200;
    var_6 = var_4._id_3F16["points"];
    var_4 _id_0626::_id_3F1A("armor", var_5 + var_6);
    var_4 thread radio_dialogue_to_player(var_4, "chaos_pickup_armor");
  } else {
    chaos_score_event_raise("dogtag");
  }
  var_3 delete();
  var_2 delete();
}

temp_chaos_dog_tags_rotate() {
  self endon("death");

  for(;;) {
    self rotateyaw(359, 1, 0, 0);
    wait 1.0;
  }
}

chaos_dog_tags_cleanup(var_0, var_1) {
  self endon("death");
  wait(var_0);
  var_1 delete();
  self delete();
}

chaos_dog_tags_flicker(var_0, var_1) {
  self endon("death");
  var_2 = var_0 * 1000;
  var_3 = gettime() + var_2;
  var_4 = min(var_1, var_0);

  if(var_4 > 0) {
    wait(var_4);
    var_0 = var_0 - var_4;
  }

  var_5 = 1;

  for(;;) {
    if(var_5) {
      self hide();
      wait 0.1;
    } else {
      self show();
      wait 0.25;
    }

    var_5 = !var_5;
  }
}

chaos_ai_setup() {
  maps\_utility::_id_1A5A("axis", ::chaos_on_ai_spawn);
}

chaos_on_ai_spawn() {
  self.dropweapon = 0;
  thread chaos_on_ai_death();
}

chaos_on_ai_death() {
  self waittill("death");

  if(!isDefined(self) || !isDefined(self.origin)) {
    return;
  }
  var_0 = chaos_get_ai_type_ref();

  if(var_0 != "chopper") {
    if(issubstr(var_0, "jug")) {
      thread chaos_dog_tags_spawn(self.origin, 1);
    } else {
      thread chaos_dog_tags_spawn(self.origin, 0);
    }
  }
}

chaos_armories_disable() {
  waittillframeend;
  var_0 = ["weapon", "equipment", "airsupport"];

  foreach(var_2 in var_0) {
    var_3 = "armory_" + var_2;
    var_4 = getent(var_3, "targetname");

    if(!isDefined(var_4)) {
      continue;
    }
    var_4 makeunusable();
    var_4 maps\_utility::_id_27C5();
    var_4._id_3ECA maps\_utility::_id_27C5();
    var_4._id_3ECB maps\_utility::_id_27C5();
  }

  var_6 = getEntArray("armory_script_brushmodel", "targetname");

  foreach(var_8 in var_6) {}
  var_8 notsolid();
}

chaos_score_globals_init() {
  level.chaos_score = 0;
}

chaos_score_update(var_0, var_1) {
  level notify("score_update_bump");
  level endon("score_update_bump");
  level thread sound_wait_for_bank();
  var_2 = var_0 * var_1;
  var_3 = level.chaos_score;
  level.chaos_score = level.chaos_score + var_2;

  foreach(var_5 in level.players) {
    if(var_2 > var_5._id_18D3["comboscoremax"]) {
      var_5._id_18D3["comboscoremax"] = var_2;
    }
    if(var_1 > var_5._id_18D3["combomultmax"]) {
      var_5._id_18D3["combomultmax"] = var_1;
    }
    if(isDefined(var_5.chaos_score_hud)) {
      var_5.chaos_score_hud settext(var_3);
      var_5 thread chaos_score_hud_player_update(var_1);
    }
  }
}

sound_wait_for_bank() {
  wait 0.3;
  common_scripts\utility::array_call(level.players, ::playlocalsound, "chaos_bank");
}

chaos_get_ai_type_ref() {
  if(isDefined(self._id_3D5D)) {
    return self._id_3D5D._id_160B;
  }
  if(isDefined(self.chaos_squad_type)) {
    return self.chaos_squad_type;
  }
  return undefined;
}

update_level_chaos_timer() {
  level endon("special_op_terminated");
  level endon("update_chaos_timer");
  level endon("chaos_timer_reached_zero");
  level common_scripts\utility::waittill_notify_or_timeout("Start timer", 10);

  for(;;) {
    wait 0.2;
    level.chaos_time_remaining = level.chaos_time_remaining - 0.2;
  }
}

chaos_timer_update_vo(var_0, var_1) {
  level endon("special_op_terminated");
  level endon("wave_ended");
  level endon("chaos_timer_reached_zero");
  level endon("update_chaos_timer");
  var_2 = var_0 - var_1;

  if(var_2 >= 0) {
    if(var_2 > 0) {
      wait(var_2);
    }
    maps\_utility::_id_142B("music_timeout_cm");
  }
}

change_player_vision_set() {
  level endon("special_op_terminated");
  self visionsetnakedforplayer("coup_sunblind", 0.25);
  wait 0.2;
  self visionsetnakedforplayer("", 1.0);
}

sp_killstreak_bonus_score_crateopen() {
  chaos_score_event_raise("bonus_score", "cm_bp_cp_bonus");
}

chaos_killstreaks_init_done() {
  return isDefined(level._id_3CE3) && isDefined(level._id_3CE3._id_3BA1);
}

chaos_killstreak_exists(var_0) {
  foreach(var_3, var_2 in level._id_3CE3._id_3CE4) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

chaos_getpathstart(var_0, var_1) {
  var_2 = 100;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4) * (-1 * var_3);
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

chaos_getpathend(var_0, var_1) {
  var_2 = 150;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4 + (0, 90, 0)) * var_3;
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

getperkname(var_0) {
  var_1 = "";

  switch (var_0) {
    case "specialty_fastreload":
      var_1 = "Sleight of Hand";
      break;
    case "specialty_quickdraw":
      var_1 = "Quick Draw";
      break;
    case "specialty_longersprint":
      var_1 = "Extreme Conditioning";
      break;
    case "specialty_stalker":
      var_1 = "Stalker";
      break;
    case "specialty_bulletaccuracy":
      var_1 = "Steady Aim";
      break;
    case "specialty_armorvest":
      var_1 = "Armor Vest";
      break;
    case "specialty_juiced":
      var_1 = "Juiced";
      break;
    default:
      break;
  }

  return var_1;
}

chaos_perk_radio(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "specialty_stalker":
      var_1 = "chaos_perk_stalker";
      break;
    case "specialty_longersprint":
      var_1 = "chaos_perk_excond";
      break;
    case "specialty_fastreload":
      var_1 = "chaos_perk_sleight";
      break;
    case "specialty_quickdraw":
      var_1 = "chaos_perk_quickdraw";
      break;
    case "specialty_bulletaccuracy":
      var_1 = "chaos_perk_steadyaim";
      break;
    case "specialty_armorvest":
      var_1 = "chaos_perk_regeneration";
      break;
    case "specialty_juiced":
      var_1 = "chaos_perk_juiced";
      break;
    default:
      break;
  }

  if(isDefined(var_1)) {
    maps\_utility::_id_11F4(var_1);
  }
}