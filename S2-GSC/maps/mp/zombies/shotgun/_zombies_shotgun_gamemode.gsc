/*****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_zombies_shotgun_gamemode.gsc
*****************************************************************/

init_sg() {
  level thread maps\mp\zombies\_zombies_progression::func_D5();
  setomnvar("ui_zm_gamemode_mod", 1);
  setomnvar("ui_zm_rs_active", 0);
  level.objectivescompleted = 0;
  maps\mp\zombies\shotgun\_zombies_shotgun_difficulty::func_D5();
  common_scripts\utility::func_3C87("zmb_players_gamemode_escaped");
  common_scripts\utility::func_3C87("zmb_players_gamemode_boss_defeated");
  common_scripts\utility::func_3C87("zmb_objectives_defense_start");
  common_scripts\utility::func_3C87("zmb_objectives_defense_end");
  common_scripts\utility::func_3C87("zmb_objectives_quest_end");
  common_scripts\utility::func_3C87("shotgun_classic_add_to_box");
  precacheshader("s2_morale_focus_overlay_01");
  level.sg_wallbuyclasses = ["weapon_pistol", "weapon_smg", "weapon_shotgun", "weapon_assault", "weapon_sniper", "weapon_heavy"];
  level.insane_mode_available = 0;
  level.max_prop_zombie_appearances = 2;
  level.iszombiesshotgun = 1;
  level.shotgunuseintrocams = 0;
  level.var_ABDA = 1;
  level.zmb_shattered_carepackage_gives_perks = 0;
  level.zmb_player_safe_teleport_on_perk_buy = 1;
  level.zmb_sg_disable_jolts_for_damage = 0;
  level.zmb_sg_disable_bonus_jolts_for_melee = 1;
  level.st_142418 = 1;
  level.var_scaling_reach_min_wave = 4;
  level.var_scaling_reach_max_wave = 11;
  level.grant_new_weapons = 1;
  level.buildablewallbuys = 1;
  level.validbuildablewallbuys = ["weapon_heavy", "weapon_shotgun", "weapon_sniper", "weapon_assault"];
  level.wallbuymaterials = 1;
  level.zombiespawnfxcount = 0;
  level.zmb_shotgun_game_won = 0;
  level.var_3C00 = 0;
  level.var_3BED = 0;
  level.zmb_match_countdown_time = 3;
  level.zmb_force_ended_wave = undefined;
  level.zmb_is_endless_wave = 0;
  level.zmb_sg_objectives = [];
  level.zmb_sg_obj_basic_funcs = [];
  level.var_2986 = "mp/zombieEnemyWavesShotgun.csv";
  level.override_weapon_costs = 1000;
  level.zombies_shotgun_weapons_in_play = [];
  level.use_zombie_unresolved_collision = 1;
  level.zmb_sg_banned_objectives = [];
  level.var_73BD = ::no_points_for_bosses_or_objective_zombies;
  level.unlockzmshatteredmap = ::unlockzmshatteredmap;
  level.var_8AF = ::lib_0547::razergunmaxammo;
  level.zombies_shotgun_weapons_splashes["weapon_pistol"] = "zm_collectible_splash_7";
  level.zombies_shotgun_weapons_splashes["weapon_smg"] = "zm_collectible_splash_8";
  level.zombies_shotgun_weapons_splashes["weapon_shotgun"] = "zm_collectible_splash_7";
  level.zombies_shotgun_weapons_splashes["weapon_sniper"] = "zm_collectible_splash_8";
  level.zombies_shotgun_weapons_splashes["weapon_assault"] = "zm_collectible_splash_9";
  level.zombies_shotgun_weapons_splashes["weapon_heavy"] = "zm_collectible_splash_10";
  level.zombies_shotgun_weapon_waypoints["weapon_pistol"] = "zm_hud_wallbuy_pistol";
  level.zombies_shotgun_weapon_waypoints["weapon_smg"] = "zm_hud_wallbuy_smg";
  level.zombies_shotgun_weapon_waypoints["weapon_shotgun"] = "zm_hud_wallbuy_shotgun";
  level.zombies_shotgun_weapon_waypoints["weapon_sniper"] = "zm_hud_wallbuy_sniper";
  level.zombies_shotgun_weapon_waypoints["weapon_assault"] = "zm_hud_wallbuy_ar";
  level.zombies_shotgun_weapon_waypoints["weapon_heavy"] = "zm_hud_wallbuy_lmg";
  level.zmb_boss_damage_reduction_func = ::zmb_shattered_boss_nerfs;
  foreach(var_02, var_01 in level.zombies_shotgun_weapons_splashes) {
    var_01 = tablelookup(maps\mp\gametypes\_hud_message::func_4369(), 0, var_01, 3);
    level.zombies_shotgun_weapons_splashes[var_02 + "_shader"] = var_01;
  }

  level.zombies_shotgun_weapons_splashes["weapon_pistol_shader"] = "s2_challenge_zombies_pistol";
  level.zombies_shotgun_weapons_splashes["weapon_smg_shader"] = "s2_challenge_zombies_smg";
  foreach(var_04, var_01 in level.zombies_shotgun_weapons_splashes) {
    if(issubstr(var_04, "shader") && var_01 != "") {
      precacheshader(var_01);
    }
  }

  foreach(var_01 in level.zombies_shotgun_weapon_waypoints) {
    if(var_01 != "") {
      precacheshader(var_01);
    }
  }

  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_fx::func_D5();
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_F9();
  level thread soundscripts\_snd_common_zmb_dlc3::snd_zmb_init_dlc3();
  level thread maps\mp\zombies\_zombies_audio_dlc2::initdlc2audio();
  level thread maps\mp\zombies\_zombies_money::func_D5();
  level thread maps\mp\zombies\sg_events_v1\_boss_util::func_D5();
  maps\mp\zombies\zombie_carepackage::func_D5();
  init_sg_shaders();
  var_06 = "normal";
  if(isDefined(level.zmb_sg_default_wave_override)) {
    var_06 = level.zmb_sg_default_wave_override;
  }

  level.upgrade_machine_upgrade_func = ::collect_souls_to_unlock_pack_a_punch;
  level.onstartshotgunfunc = ::onshotgunstart;
  level.zmb_sg_round_start_func = ::sg_run_round_start;
  level.zmb_sg_round_end_func = ::sg_run_round_end;
  level.zmb_round_over_override = ::sg_display_remaining_rounds;
  level.zombieslevelspawndelayfunc = ::sg_spawn_delay_func;
  level.zmb_trigger_weapon_get_func = ::maps\mp\zombies\shotgun\_wallbuys_shattered::get_weapon_from_trigger_data;
  level.var_902A = ::func_902A;
  level.dropschedulefunc = ::sg_pickup_drop_schedule;
  level.zmb_sg_desired_perk_order = ["quickrevive", "punchperk", "fastreload", "punchperk", "doubletap", "electriccherry"];
  level thread run_pack_a_punch_log();
  level sg_calc_wave_healths_inc_linear();
  initialize_common_shattered_v1_objectives();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::basic_boss_init();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::basic_collect_init();
  level thread sg_override_movemodes();
  level thread maps\mp\zombies\shotgun\_zombies_ammo_caches::ammo_cache_setup();
  level thread maps\mp\zombies\shotgun\_carepackage_shattered::func_D5();
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::func_D5();
  level thread maps\mp\zquests\dlc3_trophies_shattered_mode::func_D5();
  level thread run_red_skull_mode();
  level thread init_weapon_pickups_on_zombie_death();
  lib_0547::func_7BA9(::spawn_weapon_pickup_on_zombies);
}

init_weapon_pickups_on_zombie_death() {
  var_00 = getEntArray("wustling_weapon_drop_trigger", "targetname");
  foreach(var_02 in var_00) {
    var_02 common_scripts\utility::func_9D9F();
  }
}

unusable_for_other_players(param_00) {
  self disableplayeruse(param_00);
  self hidefromclient(param_00);
}

init_dropped_weapon_pickup_for_player(param_00) {
  var_01 = self;
  var_01 maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::initialize_weapon_pickup_trigger(param_00, level.zmb_wustling_weapon, 0);
  if(isDefined(level.zmb_wustling_weapon_spawned) && !level.zmb_wustling_weapon_spawned) {
    var_01.var_65DC.var_2F74 = 1;
    var_01.var_65DC.var_6642 = 1;
  }
}

spawn_weapon_pickup_on_zombies(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!lib_0547::func_5565(self.var_A4B, "zombie_heavy") && !isDefined(self.bossloot)) {
    return;
  }

  if(common_scripts\utility::func_562E(level.zmb_wustling_weapon_spawned)) {
    return;
  }

  if(lib_0547::func_5565(param_04, "dot_generic_zm")) {
    param_01 = level.var_721C;
  }

  if(!isDefined(param_01) || !isPlayer(param_01)) {
    return;
  }

  if(lib_0547::func_5565(self.var_A, level.var_746E)) {
    return;
  }

  var_09 = maps\mp\gametypes\zombies::func_3B9B(self.var_116);
  if(!isDefined(var_09)) {
    return;
  }

  var_0A = common_scripts\utility::func_F73(level.zombies_shotgun_weapons_in_play["weapon_pistol"], level.zombies_shotgun_weapons_in_play["weapon_smg"]);
  var_0A = common_scripts\utility::func_F6F(var_0A, "dp28_zm");
  var_0A = common_scripts\utility::func_F6F(var_0A, "blunderbuss_zm");
  if(isDefined(self.bossloot)) {
    var_0A = ["dp28_pap_zm", "sdk_pap_zm", "charlton_pap_zm", "emp44_pap_zm", "m1911_pap_zm", "p38_pap_zm", "svt40_pap_zm", "m1garand_pap_zm", "blunderbuss_pap_zm"];
  }

  var_0B = common_scripts\utility::func_7A33(var_0A);
  var_0C = issubstr(var_0B, "_pap");
  var_0B = maps\mp\zombies\_zombies_magicbox::func_454B(param_01, var_0B);
  if(var_0C) {
    var_0B = param_01 lib_0586::func_78B(lib_0547::func_AAF9(var_0B));
  }

  var_0D = getEntArray("wustling_weapon_drop_trigger", "targetname");
  level.zmb_wustling_weapon = var_0B;
  if(!isDefined(level.zmb_wustling_weapon_spawned)) {
    foreach(var_10, var_0F in var_0D) {
      var_0F.var_81E1 = var_10;
      lib_0547::func_8A4F(var_0F, ::init_dropped_weapon_pickup_for_player, ::unusable_for_other_players);
      var_0F.var_116 = var_09 + (0, 0, 32);
    }
  } else {
    foreach(var_0F in var_10) {
      if(isDefined(var_0F.var_65DC)) {
        var_0F.var_116 = var_09 + (0, 0, 32);
        var_0F.var_A9E0 = lib_0547::func_AAF9(var_0B, 1);
        var_0F.var_6C5C = var_0F.var_A9E0;
        var_0F.var_A7D7 = 1;
        var_0F.var_65DC.var_A9B4 = var_0F.var_A9E0;
        var_0F.var_65DC.var_A9A5 = 0;
        var_0F.var_65DC.var_2F74 = 0;
        var_0F.var_65DC.var_6642 = 1;
      }
    }
  }

  level.zmb_wustling_weapon_spawned = 1;
  var_12 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::spawn_a_floating_weapon_award(var_0B, var_09 + (0, 0, 8), undefined);
  foreach(var_0F in var_0D) {
    var_12 thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::func_A653(var_0F, var_12.var_3F2F, var_0B, 1);
  }

  level waittill("wustling_weapon_pickup", var_15);
  foreach(var_0F in var_0D) {
    var_12 maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::remove_weapon_pickup(var_0F, var_12.var_3F2F);
  }

  if(isDefined(var_12)) {
    var_12 delete();
  }

  if(isDefined(var_12.var_3F2F)) {
    var_12.var_3F2F delete();
  }

  foreach(var_0F in var_0D) {
    if(isDefined(var_0F.var_65DC)) {
      var_0F.var_65DC.var_2F74 = 1;
      var_0F.var_65DC.var_6642 = 1;
    }
  }

  if(issubstr(var_0B, "_pap")) {
    var_0B = var_15 lib_0586::func_78B(lib_0547::func_AAF9(var_0B));
  }

  if(isDefined(var_15)) {
    maps\mp\zombies\_zombies_magicbox::func_A7D6(var_15, var_0B);
  }

  level.zmb_wustling_weapon_spawned = 0;
}

donothing(param_00) {}

run_red_skull_mode() {
  var_00 = getEntArray("zmb_shattered_insane_mode_triggers", "targetname");
  foreach(var_03, var_02 in var_00) {
    var_02.var_81E1 = var_03;
    lib_0547::func_8A4F(var_02, ::assignpathtoplayer, ::hidefromothers);
  }

  while(!common_scripts\utility::func_562E(level.var_3FA6)) {
    wait 0.05;
  }

  level.insane_mode_available = 1;
  if(!common_scripts\utility::func_562E(level.insane_mode_available)) {
    return;
  }

  var_04 = wait_for_a_max_ranked_player();
  if(common_scripts\utility::func_562E(var_04)) {
    foreach(var_02 in var_00) {
      var_02 sethintstring(&"ZOMBIE_DLC3_RED_SKULL_MODEL");
    }

    level thread maps\mp\_utility::func_6F74(::spawn_client_hc_opt_in, var_00, "zmb_darkened_path_unavailable");
  }
}

activate_redskull_mode() {
  level.zmb_red_skull_mode_activated = 1;
  setomnvar("ui_zm_rs_active", 1);
  level.zmb_global_zombie_health_multiplier_wave_start = 0;
  do_rage_vision_for_all();
  level thread ensure_all_zombies_sprinting();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::register_banned_objective("keypoint_interact_repair_common");
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::register_banned_objective("dnk_kpi_bomb_defusal");
  level.zmb_exploder_always_chases = 1;
  level.var_scaling_reach_min_wave = 2;
  level.var_scaling_reach_max_wave = 4;
  modify_agent_spawn_boost("zombie_exploder", 2.1, 8);
  modify_agent_spawn_boost("zombie_heavy", 1.2, 1);
}

modify_agent_spawn_boost(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < level.dynamic_special_enemy_add[param_00].size; var_03++) {
    level.dynamic_special_enemy_add[param_00][var_03] = [int(param_02 + param_01 * level.dynamic_special_enemy_add[param_00][var_03][0]), int(param_02 + param_01 * level.dynamic_special_enemy_add[param_00][var_03][1])];
  }
}

ensure_all_zombies_sprinting() {
  for(;;) {
    foreach(var_01 in lib_0547::func_408F()) {
      var_01.var_6941 = 1;
    }

    wait(0.5);
  }
}

do_rage_vision_for_all() {
  level thread maps\mp\_utility::func_6F74(::showragevision);
}

showragevision() {
  var_00 = self;
  self method_8483(maps\mp\_utility::func_4571() + "_rage", 1);
  self lightsetoverrideenableforplayer(maps\mp\_utility::func_4571() + "_rage", 1);
  wait(2);
  self method_8483(maps\mp\_utility::func_4571(), 1);
  self lightsetoverrideenableforplayer(maps\mp\_utility::func_4571(), 1);
}

no_points_for_bosses_or_objective_zombies(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_01.sgvip)) {
    return 0;
  }

  if(common_scripts\utility::func_562E(param_01.sgboss)) {
    return 0;
  }

  return 1;
}

assignpathtoplayer(param_00) {
  param_00 endon("disconnect");
  common_scripts\utility::func_9DA3();
  level thread hide_trigger_on_disconnect(param_00, self);
  while(!common_scripts\utility::func_562E(level.redskull_mode_unavailable) && !common_scripts\utility::func_562E(param_00.optedintohc) && !common_scripts\utility::func_562E(param_00.failedoptintohc)) {
    wait 0.05;
  }

  common_scripts\utility::func_9D9F();
}

hide_trigger_on_disconnect(param_00, param_01) {
  param_00 waittill("disconnect");
  param_01 common_scripts\utility::func_9D9F();
}

hidefromothers(param_00) {}

spawn_client_hc_opt_in(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  wait 0.05;
  var_02 = common_scripts\utility::func_46B5("zmb_shattered_insane_mode", "targetname");
  if(!isDefined(level.shattered_opt_in_ents)) {
    level.shattered_opt_in_ents = [];
  }

  if(maps\mp\_utility::func_4571() == "mp_zombie_dig_02") {
    var_02.var_116 = var_02.var_116 + (0, 0, 6);
  }

  var_03 = lib_0547::func_8FBA(var_02, "zmb_shattered_insane_mode", var_01);
  var_03 lib_0378::func_8D74("dlc3_zmb_redskull_pu");
  var_01 thread remove_visuals_on_disconnect(var_03);
  level.shattered_opt_in_ents[level.shattered_opt_in_ents.size] = var_03;
  triggerfx(var_03);
  var_04 = 25;
  for(;;) {
    if(var_04 < 0 || !common_scripts\utility::func_562E(var_01.optedintohc) && var_01 useButtonPressed() && distance(var_01.var_116, var_02.var_116) < 64) {
      if(var_04 >= 0) {
        var_01.optedintohc = 1;
      } else {
        var_01.failedoptintohc = 1;
      }

      if(isDefined(var_03)) {
        var_03 delete();
      }

      var_03 = lib_0547::func_8FBA(var_02, "zmb_shattered_insane_mode_pending", var_01);
      level.shattered_opt_in_ents[level.shattered_opt_in_ents.size] = var_03;
      triggerfx(var_03);
      var_03 lib_0378::func_8D74("dlc3_redskull_accept");
      maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::try_activate_redskull_mode();
      return;
    }

    var_04 = var_04 - 0.1;
    wait(0.1);
  }

  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::remove_redskull_mode_activation();
}

remove_visuals_on_disconnect(param_00) {
  var_01 = self;
  param_00 endon("entitydeleted");
  var_01 waittill("disconnect");
  param_00 delete();
}

wait_for_a_max_ranked_player() {
  while(level.var_A980 < 3) {
    foreach(var_01 in level.var_744A) {
      var_02 = var_01 maps\mp\zombies\_zombies_progression::get_zm_shotgun_player_level();
      if(var_02 == level.zmshotgunmaxlevel) {
        return 1;
      }
    }

    wait 0.05;
  }
}

getshatteredmapsequenceinfo() {
  var_00 = self;
  var_01 = lib_0547::zombie_shattered_get_map_number();
  var_02 = common_scripts\utility::func_562E(level.zmb_shotgun_game_won);
  var_03 = common_scripts\utility::func_562E(level.shattered_ee_complete);
  var_04 = common_scripts\utility::func_562E(level.zmb_red_skull_mode_activated);
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  if(var_01 > 0) {
    if(lib_0547::is_zm_shattered_windmill_map()) {
      var_05 = var_02;
      var_06 = var_03;
      var_07 = var_04;
    } else if((lib_0547::is_zm_shattered_dnk_map() && lib_0547::is_zm_shattered_windmill_map(var_00.prevmapname)) || lib_0547::is_zm_shattered_thule_map() && lib_0547::is_zm_shattered_dnk_map(var_00.prevmapname)) {
      var_05 = var_00.ismapinsequence && var_02;
      var_06 = var_00.iseeinsequence && var_03;
      var_07 = var_00.isredskullinsequence && var_04 && var_02;
    }
  }

  return [var_01, var_05, var_06, var_07];
}

unlockzmshatteredmap() {
  var_00 = self;
  var_01 = getshatteredmapsequenceinfo();
  var_02 = var_01[0];
  var_03 = var_01[1];
  var_04 = var_01[2];
  var_05 = var_01[3];
  var_06 = common_scripts\utility::func_562E(level.zmb_shotgun_game_won);
  if(var_02 > 0) {
    var_00 setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "prevWinStatus", var_06);
    var_00 setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "isMapInSequence", var_03);
    var_00 setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "isEEInSequence", var_04);
    var_00 setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "isRedSkullInSequence", var_05);
    if(var_06) {
      var_07 = 1 << var_02 - 1;
      var_08 = var_00 getrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "mapCompleted");
      var_08 = var_08 | var_07;
      var_00 setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "mapCompleted", var_08);
    }

    if(lib_0547::is_zm_shattered_thule_map()) {
      if(getdvarint("spv_shattered_srv_unlock_easy", 0) == 1) {
        if(var_06 && function_02A3()) {
          var_00 ae_reportcomplexgameevent(42, [5, 5]);
        }
      }

      if(common_scripts\utility::func_562E(var_03)) {
        if(common_scripts\utility::func_562E(var_04)) {
          if(var_06 && function_02A3()) {
            var_00 ae_reportcomplexgameevent(42, [5, 5]);
            var_00 lib_0565::func_83DB(16, 3, 1, "wicht_set");
          }

          self setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "hasCompletedEESequence", 1);
        }

        if(common_scripts\utility::func_562E(var_05)) {
          if(function_02A3()) {
            var_00 ae_reportcomplexgameevent(44, [5, 7]);
            var_00 thread maps\mp\gametypes\_hud_message::func_9102("zm_charm_unlocked", 0);
            return;
          }

          return;
        }

        return;
      }
    }
  }
}

initialize_common_shattered_v1_objectives() {
  level thread maps\mp\zombies\sg_events_v1\keypoint_defense::func_D5();
  level thread maps\mp\zombies\sg_events_v1\interact_repair::func_D5();
  level thread maps\mp\zombies\sg_events_v1\assassin_squad::func_D5();
  level thread maps\mp\zombies\sg_events_v1\very_important_zombie::func_D5();
  level thread maps\mp\zombies\sg_events_v1\escape_sequence::func_D5();
  level thread maps\mp\zombies\sg_events_v1\extermination::func_D5();
}

include_shotgun_v1_common_objectives(param_00) {
  if(!isDefined(param_00)) {
    param_00 = [];
  }

  var_01 = [];
  var_01["type_defense_common"] = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("defense_common", "type_defense_common", [6, 9], 240, undefined, undefined, undefined, undefined, 1);
  var_01["type_extermination_common"] = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("extermination_common", "type_extermination_common", [3, 6, 9]);
  var_01["type_meuchler_common"] = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("meuchler_common", "type_meuchler_common", [3, 6, 9]);
  var_01["type_keypoint_interact_repair_common"] = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("keypoint_interact_repair_common", "type_keypoint_interact_repair_common", [3, 6], 240, undefined, undefined, undefined, undefined, 1);
  var_01["type_assassinate_common"] = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("assassinate_common", "type_assassinate_common", [6, 9], 240, undefined, undefined, undefined, undefined, 1);
  var_01["type_escape_common"] = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("escape_common", "type_escape_common", [11]);
  foreach(var_04, var_03 in var_01) {
    if(isDefined(param_00[var_04])) {
      if(isDefined(param_00[var_04].extra_func)) {
        var_03.extra_func = param_00[var_04].extra_func;
      }

      if(isDefined(param_00[var_04].var_2A35)) {
        var_03.var_2A35 = param_00[var_04].var_2A35;
      }
    }
  }
}

initialize_common_sg_weapons() {
  level thread lib_057D::func_5162();
  level thread maps\mp\zombies\weapons\_zombie_dlc2_melee::func_D5();
  common_scripts\utility::func_3C87("dlc2_melee_packable");
  level.sworddeliveryoff = 1;
  level thread maps\mp\zombies\weapons\_zombie_dlc3_melee::func_D5();
  level thread lib_0580::func_D5();
  level thread maps\mp\zombies\weapons\_zombie_razer_gun::func_D5();
}

init_sg_shaders() {
  level.zmb_sg_wallbuy_waypoint_icon = "zm_hud_wallbuy_pistol";
  precacheshader("zm_hud_wallbuy_pistol");
  level.zmb_sg_keypoint_interact_repair_icon = "zm_hud_type_keypoint_interact_repair_common_icon";
  precacheshader("zm_hud_type_keypoint_interact_repair_common_icon");
  level.zmb_sg_keypoint_interact_defuse_icon = "zm_hud_keypoint_interact_bomb_icon";
  precacheshader("zm_hud_keypoint_interact_bomb_icon");
  precacheshader("zm_hud_type_escape_common_icon");
  precacheshader("zm_hud_type_escape_b_common_icon");
}

run_pack_a_punch_log() {
  if(isDefined(level.upgrade_machine_upgrade_func)) {
    level thread[[level.upgrade_machine_upgrade_func]]();
  }
}

collect_souls_to_unlock_pack_a_punch() {
  var_00 = common_scripts\utility::func_46B7("zmb_sg_pap_light_display", "targetname");
  var_01 = common_scripts\utility::func_46B7("zmb_pack_key", "targetname");
  var_02 = common_scripts\utility::func_46B7("zmb_sg_availablility_light_display", "targetname");
  var_03 = function_021F("zmb_sg_reciver_scriptable", "targetname");
  foreach(var_05 in var_03) {
    var_05 thread maps\mp\mp_zombie_nest_hilt_altar_reciever::func_84DC();
  }

  if(var_01.size < 3) {
    return;
  }

  level.pack_a_punc_pre_func = ::wait_for_pap_available;
  for(var_07 = 0; var_07 < var_01.size; var_07++) {
    common_scripts\utility::func_3C87("zmb_sg_soul_collect_flag_" + var_01[var_07].var_81E1);
    common_scripts\utility::func_3C87("zmb_sg_soul_collect_ready_flag_" + var_01[var_07].var_81E1);
  }

  common_scripts\utility::func_FB2(var_01, ::set_pack_key_unlocked);
  common_scripts\utility::func_FB2(var_00, ::handle_unlock_lights, "zmb_sg_soul_collect_flag_");
  common_scripts\utility::func_FB2(var_02, ::handle_unlock_lights, "zmb_sg_soul_collect_ready_flag_", "zmb_sg_soul_collect_flag_");
  maps\mp\_utility::func_2CED(3, ::unlock_next_reciever);
  wait_for_pap_available();
  wait(0.5);
  level notify("pap_state_change");
  level thread maps\mp\_utility::func_6F74(::maps\mp\gametypes\_hud_message::func_9102, "zm_pap_unlocked");
}

wait_for_pap_available() {
  var_00 = getent("pack_a_punch_weapon_display", "targetname");
  var_00 method_8511();
  for(var_01 = 0; var_01 < 3; var_01++) {
    common_scripts\utility::func_3C9F("zmb_sg_soul_collect_flag_" + var_01 + 1);
  }
}

unlock_next_reciever() {
  if(!isDefined(level.zmb_pap_reciver_unlocks)) {
    level.zmb_pap_reciver_unlocks = 0;
  }

  level.zmb_pap_reciver_unlocks++;
  var_00 = "zmb_sg_soul_collect_ready_flag_" + level.zmb_pap_reciver_unlocks;
  if(common_scripts\utility::func_3C83(var_00)) {
    common_scripts\utility::func_3C8F(var_00);
  }
}

handle_unlock_lights(param_00, param_01) {
  lib_0547::func_A6F6();
  var_02 = self.var_81E1;
  var_03 = lib_0547::func_8FBA(self, "zmb_nest_generator_bulb_red");
  triggerfx(var_03);
  common_scripts\utility::func_3C9F(param_00 + self.var_81E1);
  var_03 delete();
  var_03 = lib_0547::func_8FBA(self, "zmb_nest_generator_bulb_green");
  triggerfx(var_03);
  if(!isDefined(param_01)) {
    return;
  }

  common_scripts\utility::func_3C9F(param_01 + self.var_81E1);
  var_03 delete();
  var_03 = lib_0547::func_8FBA(self, "zmb_nest_generator_bulb_off");
  triggerfx(var_03);
}

set_pack_key_unlocked() {
  var_00 = self.var_81E1;
  var_01 = spawn("script_model", self.var_116);
  var_01 setModel("tag_origin");
  common_scripts\utility::func_3C9F("zmb_sg_soul_collect_ready_flag_" + self.var_81E1);
  var_02 = 400;
  if(common_scripts\utility::func_562E(level.sg_pack_use_small_radius)) {
    var_02 = 256;
  }

  var_01.ignoresighttrace = 1;
  var_01 maps\mp\mp_zombies_soul_collection::func_170B(10, var_02, 70, "zmb_sg_soul_collect_ping_" + var_00, undefined, "tag_origin", undefined, "tag_origin");
  common_scripts\utility::func_3C8F("zmb_sg_soul_collect_flag_" + self.var_81E1);
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("geistcraft_device_powered");
}

sg_calc_wave_healths_inc_linear() {
  for(var_00 = 1; var_00 <= 11; var_00++) {
    var_01 = 150;
    var_02 = 75;
    if(var_00 > 1) {
      for(var_03 = 2; var_03 < var_00 + 1; var_03++) {
        var_04 = var_01;
        var_01 = var_01 + var_02 * var_03;
        if(var_01 < var_04) {
          var_01 = var_04;
          break;
        }
      }
    }

    var_05 = var_01;
    level.wave_healths[var_00] = var_05;
  }
}

sg_pickup_drop_schedule() {
  level waittill("zombie_wave_started");
  var_00 = level.var_744A.size * 2000;
  var_01 = level.var_744A.size * 3000;
  if(lib_0547::func_F0F("specialty_class_resourceful_zm")) {
    var_01 = level.var_744A.size * 2000;
  }

  var_02 = 1.14;
  var_03 = var_02;
  var_04 = var_00 + var_01;
  maps\mp\gametypes\zombies::func_6FC8("Next Scheduled at " + var_04 + " points");
  for(;;) {
    var_05 = 0;
    foreach(var_07 in level.var_744A) {
      if(isDefined(var_07.var_62D7)) {
        var_05 = var_05 + var_07.var_62D7;
      }
    }

    if(var_05 > var_04) {
      level.var_34AA = 1;
      maps\mp\gametypes\zombies::func_6FC8("Reached Scheduled " + var_05 + ">" + var_04);
      var_01 = level.var_744A.size * 3000;
      if(lib_0547::func_F0F("specialty_class_resourceful_zm")) {
        var_01 = level.var_744A.size * 2000;
      }

      var_04 = var_05 + var_01 * var_03;
      var_03 = var_03 * var_02;
      maps\mp\gametypes\zombies::func_6FC8("Next Scheduled at " + var_04 + " points");
    }

    wait(0.5);
  }
}

sg_pickup_max_per_round() {
  var_00 = clamp(lib_0547::func_45C9(), 1, 2);
  if(lib_0547::func_F0F("specialty_class_resourceful_zm")) {
    var_00 = var_00 + 1;
  }

  return var_00;
}

sg_spawn_delay_func(param_00) {
  if(isDefined(level.sg_manual_spawn_delay)) {
    return level.sg_manual_spawn_delay;
  }

  var_01 = 0.85;
  var_02 = 0.5;
  for(var_03 = 1; var_03 < param_00; var_03++) {
    var_02 = var_02 * var_01;
    if(var_02 <= 0.1) {
      var_02 = 0.1;
      break;
    }
  }

  return var_02;
}

onshotgunstart() {
  level.var_300C = ::zombiesdisplaygameendfuncwinnerslosers;
  initialize_weapons_in_play();
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_difficulty::initialize_care_package_rewards();
  level thread maps\mp\zombies\shotgun\_wallbuys_shattered::override_wall_buys_by_class();
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::altered_state_init();
  if(common_scripts\utility::func_562E(level.shotgunuseintrocams)) {
    level thread maps\mp\_utility::func_6F74(::run_intro_cinematic, undefined, "cinematic_intros_closed");
  }

  level thread start_match_in_time(10);
  common_scripts\utility::func_3C8F("ripsaw_punch_active");
}

start_match_in_time(param_00) {
  while(!common_scripts\utility::func_562E(level.var_3FA6)) {
    wait 0.05;
  }

  wait(param_00 * 0.3);
  level notify("cinematic_intros_closed");
  wait(param_00 * 0.7);
  level notify("zombies_manual_start");
}

run_intro_cinematic() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00.var_6772 = newclienthudelem(var_00);
  var_00.var_6772 setshader("black", 640, 480);
  var_00.var_6772.ignoreme = 999;
  var_00.var_6772.var_C6 = "fullscreen";
  var_00.var_6772.var_1CA = "fullscreen";
  var_00.var_6772.var_A0 = 0;
  var_00 endon("disconnect");
  var_00 waittill("spawned_player");
  var_01 = common_scripts\utility::func_46B7("sg_intro_cam", "targetname");
  var_02 = common_scripts\utility::func_46B7("sg_intro_cam", "script_noteworthy");
  var_01 = common_scripts\utility::func_FA5(var_01, ::script_index_compare);
  foreach(var_05, var_04 in var_01) {
    var_04.dest = common_scripts\utility::func_4461(var_04.var_116, var_02);
    var_00 maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::run_ingame_cinematic([var_04, 0, int(10 / var_01.size), 0.9, var_05 == var_01.size - 1, 1]);
  }
}

run_outro_cinematic() {
  var_00 = self;
  var_00 endon("disconnect");
  if(!isDefined(level.outro_targetname)) {
    return;
  }

  var_00.var_6772 = newclienthudelem(var_00);
  var_00.var_6772 setshader("black", 640, 480);
  var_00.var_6772.ignoreme = 999;
  var_00.var_6772.var_C6 = "fullscreen";
  var_00.var_6772.var_1CA = "fullscreen";
  var_00.var_6772.var_A0 = 0;
  var_01 = common_scripts\utility::func_46B5(level.outro_targetname, "targetname");
  var_01.dest = common_scripts\utility::func_46B5(var_01.var_1A2, "targetname");
  var_00 maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::run_ingame_cinematic([var_01, 0, 10, 0.9, 1, 1]);
}

script_index_compare(param_00, param_01) {
  return param_00.var_81E1 < param_01.var_81E1;
}

set_game_won() {
  common_scripts\utility::func_3C8F("zmb_players_gamemode_escaped");
  level.zmb_shotgun_game_won = 1;
  maps\mp\zquests\dlc3_trophies_shattered_mode::complete_shattered_escape_event();
}

zombiesdisplaygameendfuncwinnerslosers(param_00, param_01) {
  if(level.zmb_shotgun_game_won) {
    param_00 = "allies";
  }

  maps\mp\gametypes\zombies::func_AC54(param_00, param_01);
}

sg_override_movemodes() {
  while(!isDefined(level.var_A41)) {
    wait 0.05;
  }

  while(!isDefined(level.var_A41["zombie_generic"])) {
    wait 0.05;
  }

  while(!isDefined(level.var_A41["zombie_generic"]["move_mode"])) {
    wait 0.05;
  }

  level.var_A41["zombie_generic"]["move_mode"] = ::sg_fodder_move_mode;
}

sg_fodder_move_mode() {
  var_00 = self.var_901F;
  if(common_scripts\utility::func_562E(self.var_6941) && isDefined(level.var_ABDD)) {
    return level.var_ABDD[level.var_ABDD.size - 1];
  }

  return lib_054D::func_957E(var_00 + 7);
}

initialize_weapons_in_play() {
  var_00 = [];
  foreach(var_02 in level.var_5F7F) {
    var_00 = common_scripts\utility::func_F6F(var_00, var_02["baseNameNoMP"]);
  }

  foreach(var_05 in level.var_A7DE) {
    var_00 = common_scripts\utility::func_F6F(var_00, var_05.var_165);
  }

  foreach(var_02 in var_00) {
    var_08 = lib_0547::zm_get_weapon_class(var_02);
    if(!isDefined(var_08)) {
      var_08 = "misc_weapon";
    }

    if(!isDefined(level.zombies_shotgun_weapons_in_play[var_08])) {
      level.zombies_shotgun_weapons_in_play[var_08] = [];
    }

    level.zombies_shotgun_weapons_in_play[var_08] = common_scripts\utility::func_F6F(level.zombies_shotgun_weapons_in_play[var_08], var_02);
  }

  level.zombies_shotgun_weapons_in_play["weapon_pistol"] = lib_0547::get_zombies_mode_starter_weapons();
  level.zombies_shotgun_weapons_in_play["weapon_pistol"] = common_scripts\utility::func_F93(level.zombies_shotgun_weapons_in_play["weapon_pistol"], "shovel_zm");
  level.zombies_shotgun_weapons_in_play["weapon_assault"] = common_scripts\utility::func_F93(level.zombies_shotgun_weapons_in_play["weapon_assault"], "m2carbine_zm");
  level.zombies_shotgun_weapons_in_play["weapon_assault"] = common_scripts\utility::func_F93(level.zombies_shotgun_weapons_in_play["weapon_assault"], "g43_zm");
  level.zombies_shotgun_weapons_in_play["weapon_assault"] = common_scripts\utility::func_F93(level.zombies_shotgun_weapons_in_play["weapon_assault"], "svt40_zm");
  level.zombies_shotgun_weapons_in_play["weapon_pistol"] = common_scripts\utility::func_F6F(level.zombies_shotgun_weapons_in_play["weapon_pistol"], "m2carbine_zm");
  level.zombies_shotgun_weapons_in_play["weapon_pistol"] = common_scripts\utility::func_F6F(level.zombies_shotgun_weapons_in_play["weapon_pistol"], "g43_zm");
  level.zombies_shotgun_weapons_in_play["weapon_pistol"] = common_scripts\utility::func_F6F(level.zombies_shotgun_weapons_in_play["weapon_pistol"], "svt40_zm");
  level.zombies_shotgun_weapons_in_play["weapon_shotgun"] = common_scripts\utility::func_F6F(level.zombies_shotgun_weapons_in_play["weapon_shotgun"], "model21_zm");
  level.zombies_shotgun_weapons_in_play["weapon_shotgun"] = common_scripts\utility::func_F6F(level.zombies_shotgun_weapons_in_play["weapon_shotgun"], "m30_zm");
  foreach(var_0F, var_0B in level.zombies_shotgun_weapons_in_play) {
    var_0B = common_scripts\utility::func_F97(var_0B);
    level.zombies_shotgun_weapons_in_play[var_0F] = var_0B;
  }
}

sg_run_round_start() {
  maps\mp\zombies\shotgun\_zombies_shotgun_difficulty::boost_special_enemy_waves();
  sg_obj_unset_wave_endless();
  sg_mod_intermission_time();
  level.var_60A9 = sg_pickup_max_per_round();
  var_00 = "normal";
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::try_activate_redskull_mode(1);
  var_01 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_select();
  if(isDefined(var_01)) {
    if(common_scripts\utility::func_562E(var_01.is_endless_wave)) {
      if(common_scripts\utility::func_562E(var_01.endless_no_heavies)) {
        sg_obj_set_wave_endless(1);
      } else {
        sg_obj_set_wave_endless(0);
      }
    }

    var_00 = var_01.var_1B9;
    sg_mod_intermission_time(30);
    level thread sg_run_obj_round(var_01);
  } else {
    foreach(var_03 in level.var_744A) {
      var_04 = tablelookup("mp/zombiesShotgunObjectiveData.csv", 0, var_00, 1);
      var_03 setclientomnvar("ui_onevone_class_1", int(var_04));
    }
  }

  return var_00;
}

sg_run_round_end(param_00) {
  level notify("zmb_shattered_play_dlg_" + level.var_A980);
}

sg_end_game() {
  if(common_scripts\utility::func_562E(level.zmb_shotgun_game_won)) {
    var_00 = "zombies_completed";
  } else {
    var_00 = "zombie_extraction_failed";
  }

  lib_0553::func_AC1F(var_00, undefined, 1);
}

sg_is_escape_round() {
  return level.var_A980 == 11;
}

sg_end_round() {
  level.zmb_force_ended_wave = level.var_A980;
}

sg_mod_intermission_time(param_00) {
  if(isDefined(param_00)) {
    level.var_7F1B = param_00;
  } else {
    level.var_7F1B = 20;
  }

  if(level.var_A980 >= 9) {
    level.var_7F1B = 30;
  }
}

sg_display_remaining_rounds(param_00) {
  setomnvar("ui_zm_round_number", param_00);
}

sg_run_obj_round(param_00) {
  if(isDefined(param_00.event_func)) {
    var_01 = sg_obj_splash_get_type_name_friendly(param_00.var_1B9);
    foreach(var_03 in level.var_744A) {
      var_04 = undefined;
      if(param_00.var_1B9 == "type_boss") {
        var_03 thread maps\mp\gametypes\_hud_message::func_9102(param_00.var_502A);
        var_04 = tablelookup("mp/zombiesShotgunObjectiveData.csv", 0, param_00.var_502A, 1);
      } else {
        if(param_00.var_1B9 != "type_escape_common") {
          var_03 thread maps\mp\gametypes\_hud_message::func_9102(param_00.var_1B9);
        }

        var_04 = tablelookup("mp/zombiesShotgunObjectiveData.csv", 0, param_00.var_1B9, 1);
      }

      var_03 setclientomnvar("ui_onevone_class_1", int(var_04));
    }

    level notify("sg_obj_start");
    if(isDefined(param_00.var_9A07) && param_00.var_9A07 != 0) {
      var_06 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting(param_00.var_1B9 + "_timer");
      if(!isDefined(var_06)) {
        var_06 = param_00.var_9A07;
      }

      level thread sg_obj_timer(int(var_06));
    }

    if(isDefined(param_00.extra_func)) {
      [[param_00.extra_func]]();
    }

    level.objectivewaveactive = 1;
    level.zmbdisablechancetospawnpickup = 1;
    var_07 = wave_end_or_objective_end(param_00);
    setomnvar("ui_zm_waypoint_ents_type", 0);
    level.zmbdisablechancetospawnpickup = 0;
    level.objectivewaveactive = 0;
    level.trucks_are_port_locked = 0;
    foreach(var_03 in level.var_744A) {
      var_09 = tablelookup("mp/zombiesShotgunObjectiveData.csv", 0, "obj_ending", 1);
      var_03 setclientomnvar("ui_onevone_class_1", int(var_09));
    }

    level.objectivescompleted++;
    if(sg_is_escape_round()) {
      level thread outro_run();
      level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_objective_completed");
      var_0B = 1;
      foreach(var_03 in level.var_744A) {
        var_0D = var_03 getshatteredmapsequenceinfo();
        var_0E = var_0D[0];
        var_0F = var_0D[1];
        var_10 = var_0D[2];
        var_11 = var_0D[3];
        var_0B = var_0B && common_scripts\utility::func_562E(var_0F) && common_scripts\utility::func_562E(var_10);
      }

      if(lib_0547::is_zm_shattered_thule_map() && var_0B) {
        lib_0547::zm_util_run_outro("mp/mp_zom_dlc3_outro", 67.5, 0.5, 1, 0, "dig_outro_movie");
      }

      sg_end_game();
      return;
    }

    if(!isDefined(var_0F) || !var_0F) {
      sg_obj_round_fail_wrapper(var_09);
    } else {
      level.outro_targetname = undefined;
      level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_objective_completed");
      foreach(var_0C in level.var_744A) {
        var_0C thread maps\mp\gametypes\_hud_message::func_9102("zm_shattered_obj_complete");
      }

      maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::completed_an_objective();
      level.grant_new_weapons = 1;
      if(isDefined(var_09.var_94D6)) {
        thread[[var_09.var_94D6]]();
      }

      level notify("zmb_shotgun_gamemode_pausing");
      maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
      level thread delay_pause();
      if(lib_056D::func_66D7() <= level.var_A980) {
        level.var_ABEC maps\mp\_utility::func_5DC7();
        level.var_ABED maps\mp\_utility::func_5DC7();
        level.var_AC12 maps\mp\_utility::func_5DC7();
        level.var_A981 = level.var_A980;
      }

      var_15 = lib_0547::func_408F().size;
      if(var_15 > 0) {
        level thread maps\mp\gametypes\zombies::func_8B2((0, 0, 0), 1);
      }

      foreach(var_17 in lib_0547::func_408F()) {
        if(common_scripts\utility::func_562E(var_17.longdeath)) {
          continue;
        }

        var_17 suicide();
      }

      unlock_next_reciever();
      maps\mp\_utility::func_2CED(7.25, ::maps\mp\zombies\shotgun\_wallbuys_shattered::give_wallbuy_materials);
      maps\mp\zombies\shotgun\_carepackage_shattered::start_care_package_reward_all();
      sg_end_round();
    }

    level notify("sg_obj_end");
  }
}

delay_pause() {
  wait 0.05;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
}

sg_obj_set_wave_endless(param_00) {
  level.zmb_is_endless_wave = 1;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8606();
  if(common_scripts\utility::func_562E(param_00)) {
    level.var_3774[level.var_744A.size][level.var_A980]["zombie_generic"] = 10;
    level.var_3774[level.var_744A.size][level.var_A980]["zombie_berserker"] = 5;
    level.var_3774[level.var_744A.size][level.var_A980]["zombie_exploder"] = 2;
    level.var_3774[level.var_744A.size][level.var_A980]["zombie_heavy"] = 0;
    return;
  }

  level.var_3774[level.var_744A.size][level.var_A980]["zombie_generic"] = 10;
  level.var_3774[level.var_744A.size][level.var_A980]["zombie_berserker"] = 5;
  level.var_3774[level.var_744A.size][level.var_A980]["zombie_exploder"] = 2;
  level.var_3774[level.var_744A.size][level.var_A980]["zombie_heavy"] = 0;
}

sg_obj_unset_wave_endless() {
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8607();
  level.zmb_is_endless_wave = 0;
}

sg_obj_round_fail_wrapper(param_00) {
  level.zmb_shattered_objectives_failed = 1;
  foreach(var_02 in level.var_744A) {
    var_02 thread maps\mp\gametypes\_hud_message::func_9102("zm_shattered_obj_failed");
  }

  if(isDefined(param_00.fail_func)) {
    [[param_00.fail_func]]();
  }

  level thread maps\mp\_utility::func_6F74(::setplayerhasfailed);
  wait(3.5);
  foreach(var_02 in level.var_744A) {
    var_02 setclientomnvar("ui_hide_hud", 0);
  }

  lib_0553::func_AC1F("zombie_extraction_failed", undefined, 1);
}

setplayerhasfailed() {
  var_00 = self;
  var_00.var_480F = 1;
  wait(0.7);
  var_00 setclientomnvar("ui_hide_hud", 1);
  level thread maps\mp\_utility::func_6F74(::run_outro_cinematic, undefined, level.outro_targetname);
}

wave_end_or_objective_end(param_00) {
  return level[[param_00.event_func]](param_00.var_502A);
}

get_rewards(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(isDefined(level.zombies_shotgun_weapons_in_play[var_03])) {
      var_01 = common_scripts\utility::func_F73(var_01, level.zombies_shotgun_weapons_in_play[var_03]);
    }
  }

  return var_01;
}

get_reward(param_00) {
  if(param_00 == 0) {
    return 0;
  }

  if(param_00 <= 2) {
    return 1;
  }

  if(param_00 <= 6) {
    return 2;
  }

  if(param_00 <= 10) {
    return 3;
  }

  return 0;
}

sg_obj_splash_get_type_name_friendly(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "type_assassinate_common":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_ASSASSIN";
      break;

    case "type_escort":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_ESCORT";
      break;

    case "type_defense_common":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_DEFENSE";
      break;

    case "blimp_attack":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_BLIMP";
      break;

    case "air_attack":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_AIR";
      break;

    case "type_extermination_common":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_EXT";
      break;

    case "type_boss":
      if(lib_0547::is_zm_shattered_dnk_map()) {
        var_01 = &"ZOMBIE_DLC3_OBJ_NAME_DNK_BOSS";
      } else if(lib_0547::is_zm_shattered_windmill_map()) {
        var_01 = &"ZOMBIE_DLC3_OBJ_NAME_WINDMILL_BOSS";
      } else {
        var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_BOSS";
      }
      break;

    case "collect":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_COLLECT";
      break;

    case "type_escape_common":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_ESCAPE";
      break;

    case "type_keypoint_interact_repair_common":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_KPI_REPAIR";
      break;

    case "type_meuchler_common":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_MEUCHLER";
      break;

    case "keypoint_interact_build":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_KPI_BUILD";
      break;

    case "keypoint_interact_bomb":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_KPI_BOMB";
      break;

    case "visions":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_VISIONS";
      break;

    case "blood_plates":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_DIG_PLATES";
      break;

    case "boss_guardian":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_DIG_BOSS";
      break;

    case "altar_defense":
      var_01 = &"ZOMBIE_DLC3_OBJ_NAME_DIG_ALTAR";
      break;
  }

  if(isDefined(level.sg_get_level_obj_strings_func) && !isDefined(var_01)) {
    var_01 = [[level.sg_get_level_obj_strings_func]]("name", param_00);
  }

  if(!isDefined(var_01)) {
    var_01 = &"OBJECTIVE";
  }

  return var_01;
}

sg_obj_splash_get_type_desc_friendly(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "type_assassinate_common":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_ASSASSIN";
      break;

    case "type_escort":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_ESCORT";
      break;

    case "type_defense_common":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_DEFENSE";
      break;

    case "blimp_attack":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_BLIMP";
      break;

    case "air_attack":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_AIR";
      break;

    case "type_extermination_common":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_EXT";
      break;

    case "type_boss":
      if(lib_0547::is_zm_shattered_dnk_map()) {
        var_01 = &"ZOMBIE_DLC3_OBJ_DESC_DNK_BOSS";
      } else if(lib_0547::is_zm_shattered_windmill_map()) {
        var_01 = &"ZOMBIE_DLC3_OBJ_DESC_WINDMILL_BOSS";
      } else {
        var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_BOSS";
      }
      break;

    case "collect":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_COLLECT";
      break;

    case "type_escape_common":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_ESCAPE";
      break;

    case "type_keypoint_interact_repair_common":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_KPI_REPAIR";
      break;

    case "type_meuchler_common":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_MEUCHLER";
      break;

    case "keypoint_interact_build":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_KPI_BUILD";
      break;

    case "keypoint_interact_bomb":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_KPI_BOMB";
      break;

    case "visions":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_VISIONS";
      break;

    case "blood_plates":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_DIG_PLATES";
      break;

    case "boss_guardian":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_DIG_BOSS";
      break;

    case "altar_defense":
      var_01 = &"ZOMBIE_DLC3_OBJ_DESC_DIG_ALTAR";
      break;
  }

  if(!isDefined(var_01) && isDefined(level.sg_get_level_obj_strings_func)) {
    var_01 = [[level.sg_get_level_obj_strings_func]]("desc", param_00);
  }

  if(!isDefined(var_01)) {
    var_01 = &"Unknown Objective Type";
  }

  return var_01;
}

sg_obj_splash(param_00) {
  var_01 = self;
  wait(1);
  var_02 = 6;
  var_01 thread sg_obj_splash_title(param_00, var_02, 0, -1);
  var_01 thread sg_obj_splash_desc(param_00, var_02, 1, 0);
}

sg_obj_splash_title(param_00, param_01, param_02, param_03) {
  var_04 = self;
  var_05 = common_scripts\utility::func_40B5();
  if(isDefined(var_04.splashtitle)) {
    var_04 sg_obj_splash_clear_title();
  }

  var_04.splashtitle = var_04 maps\mp\gametypes\_hud_util::func_27ED("bigfixed", 1);
  var_04.splashtitle maps\mp\gametypes\_hud_util::func_8707("CENTER", "CENTER", 0, -10);
  var_04.splashtitle.var_E5 = sg_obj_splash_get_type_name_friendly(param_00);
  var_04.splashtitle.var_18 = 0;
  var_04.splashtitle.var_56 = (1, 0, 0.07);
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  wait(param_02);
  var_04.splashtitle sg_obj_splash_fade_in();
  wait(param_01 - param_03);
  var_04.splashtitle moveovertime(0.5);
  var_04.splashtitle.var_C6 = "left_adjustable";
  var_04.splashtitle.var_1CA = "top_adjustable";
  var_04.splashtitle.var_11 = "top";
  var_04.splashtitle.accuracy = "left";
  var_04.splashtitle.maxsightdistsqrd = var_05.var_1D2 * 0.042;
  var_04.splashtitle.var_1D7 = var_05.var_BD * 0.031;
  var_06 = 0.05;
  var_07 = 0.5;
  for(var_08 = 0; var_08 < var_07; var_08 = var_08 + var_06) {
    var_04.splashtitle.var_9B = var_04.splashtitle.var_9B - 0.03;
    wait(var_06);
  }

  level waittill("round complete");
  var_04 sg_obj_splash_clear_title();
}

sg_obj_splash_desc(param_00, param_01, param_02, param_03) {
  var_04 = self;
  if(isDefined(var_04.splashtitle)) {
    var_04 sg_obj_splash_clear_desc();
  }

  var_04.splashdesc = var_04 maps\mp\gametypes\_hud_util::func_27ED("default", 1);
  var_04.splashdesc maps\mp\gametypes\_hud_util::func_8707("CENTER", "CENTER", 0, 10);
  var_04.splashdesc.var_E5 = sg_obj_splash_get_type_desc_friendly(param_00);
  var_04.splashdesc.var_18 = 0;
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  wait(param_02);
  var_04.splashdesc sg_obj_splash_fade_in();
  wait(param_01 - param_03);
  wait(param_03);
  var_04.splashdesc sg_obj_splash_fade_out();
  var_04 sg_obj_splash_clear_desc();
}

sg_obj_splash_fade_in() {
  self endon("death");
  var_00 = 0.05;
  var_01 = 0.5;
  self.var_18 = 1;
  for(var_02 = 0; var_02 < var_01; var_02 = var_02 + var_00) {
    self.var_18 = clamp(var_02 / var_01 - 0.25, 0, 0.75);
    wait(var_00 / 2);
    self.var_18 = var_02 / var_01;
    wait(var_00 / 2);
  }
}

sg_obj_splash_fade_out() {
  self endon("death");
  var_00 = 0.1;
  var_01 = 0.5;
  for(var_02 = var_01; var_02 > 0; var_02 = var_02 - var_00) {
    if(!isDefined(self)) {
      break;
    }

    self.var_18 = clamp(var_02 / var_01 + 0.25, 0.25, 1);
    wait(var_00 / 2);
    self.var_18 = var_02 / var_01;
    wait(var_00 / 2);
  }
}

sg_obj_splash_clear_title() {
  var_00 = self;
  if(isDefined(var_00.splashtitle)) {
    var_00.splashtitle maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

sg_obj_splash_clear_desc() {
  var_00 = self;
  if(isDefined(var_00.splashdesc)) {
    var_00.splashdesc maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

sg_obj_timer(param_00) {
  level endon("sg_obj_end");
  level.sg_obj_timer = param_00;
  foreach(var_02 in level.var_744A) {
    var_02 setclientomnvar("ui_onevone_class_2", int(param_00));
  }

  sg_obj_timer_countdown();
  level notify("sg_obj_timeout");
}

sg_obj_timer_countdown() {
  level endon("sg_obj_end");
  for(;;) {
    var_00 = common_scripts\utility::func_A70F(1, level, "sg_obj_update_timer");
    if(lib_0547::func_5565(var_00[1], "timeout")) {
      level.sg_obj_timer--;
    } else if(lib_0547::func_5565(var_00[1], "sg_obj_update_timer") && isDefined(var_00[2])) {
      level.sg_obj_timer = level.sg_obj_timer + var_00[2];
    }

    if(level.sg_obj_timer < 30) {
      foreach(var_02 in level.var_744A) {
        if(isDefined(var_02.objtimerhud) && var_02.objtimerhud.var_56 != (1, 0, 0)) {
          var_02.objtimerhud.var_56 = (1, 0, 0);
        }
      }
    }

    if(level.sg_obj_timer <= 0) {
      break;
    }
  }
}

sg_obj_timer_ui(param_00) {
  var_01 = self;
  if(isDefined(var_01.objtimerhud)) {
    var_01 sg_obj_timer_ui_clear();
  }

  var_01.objtimerhud = var_01 maps\mp\gametypes\_hud_util::func_27ED("default", 1);
  var_01.objtimerhud maps\mp\gametypes\_hud_util::func_8707("LEFT", undefined, 20, 50);
  var_01.objtimerhud.var_E5 = &"Time Remaining: ";
  var_01.objtimerhud settenthstimer(level.sg_obj_timer);
  for(;;) {
    var_02 = level common_scripts\utility::func_A715("sg_obj_end", "sg_obj_timeout", "sg_obj_remove_timer", "sg_obj_update_timer");
    if(var_02 == "sg_obj_update_timer") {
      var_01.objtimerhud settenthstimer(level.sg_obj_timer);
      continue;
    }

    break;
  }

  var_01.objtimerhud fadeovertime(1);
  var_01.objtimerhud.var_18 = 0;
  wait(1);
  var_01 sg_obj_timer_ui_clear();
}

sg_obj_timer_ui_clear() {
  var_00 = self;
  if(isDefined(var_00.objtimerhud)) {
    var_00.objtimerhud maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

outro_run() {
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
  foreach(var_01 in lib_0547::func_408F()) {
    var_01 suicide();
  }
}

func_902A(param_00) {
  if(isDefined(param_00.var_82EC)) {
    switch (param_00.var_82EC) {
      case "spawn_dirt":
        return::dirtspawnnotetrackhandler;

      case "spawn_concrete":
        return::concretespawnnotetrackhandler;

      case "spawn_mud":
        return::mudspawnnotetrackhandler;

      case "spawn_sand":
        return::sandspawnnotetrackhandler;

      case "spawn_water":
        return::waterspawnnotetrackhandler;

      case "spawn_fire":
        thread try_catch_on_fire();
        return undefined;
    }
  }
}

try_catch_on_fire() {
  self endon("death");
  var_00 = 0;
  foreach(var_02 in lib_0547::func_408F()) {
    if(lib_0547::func_5565(var_02.var_A4B, "zombie_sizzler")) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_02.isonfire)) {
      var_00++;
    }
  }

  if(var_00 < 4) {
    self.isonfire = 1;
    lib_0547::func_A6F6();
    self setonfire(0, 100, 1, "none", 1);
  }
}

dirtspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_dirt");
  }
}

mudspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_mud");
  }
}

concretespawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_concrete");
  }
}

sandspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_sand");
  }
}

waterspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_water");
    thread zombiedripfx("zmb_spawn_water");
  }
}

zombiedripfx(param_00) {
  if(level.var_A980 >= 20) {
    return;
  }

  var_01 = "spawn_water_drip";
  if(isDefined(param_00)) {
    var_01 = param_00 + "_drip";
  }

  var_02 = ["J_Shoulder_RI", "J_Shoulder_LE", "J_Hip_LE", "J_Hip_RI", "J_Head"];
  foreach(var_05 in var_02) {
    if(isDefined(self gettagorigin(var_05))) {
      lib_0547::func_74A5(common_scripts\utility::func_44F5(var_01), self, var_05);
    }
  }

  zombiedripfxcleanup(var_02, var_01);
}

zombiedripfxcleanup(param_00, param_01) {
  self endon("death");
  while(isDefined(self) && isalive(self)) {
    wait(0.1);
    if(!isDefined(self.var_53D9) || !self.var_53D9) {
      break;
    }
  }

  wait(randomfloatrange(5, 15));
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  foreach(var_03 in param_00) {
    if(isDefined(self gettagorigin(var_03))) {
      lib_0547::func_9406(common_scripts\utility::func_44F5(param_01), self, var_03);
    }
  }
}

zombiespawnfx(param_00) {
  if(level.zombiespawnfxcount >= 12) {
    return;
  }

  var_01 = spawnfx(common_scripts\utility::func_44F5(param_00), self.var_116, anglesToForward(self.var_1D), anglestoup(self.var_1D));
  triggerfx(var_01);
  level.zombiespawnfxcount++;
  common_scripts\utility::func_A74B("death", 2);
  level.zombiespawnfxcount--;
  var_01 delete();
}

zmb_shattered_boss_nerfs(param_00, param_01, param_02) {
  var_03 = 4500;
  var_04 = 200;
  var_05 = 1500;
  param_00 = lib_0547::func_AAF9(param_00);
  var_06 = 4500;
  var_07 = param_01;
  if(lib_0547::func_5565(param_00, "p38_zm") && param_01 >= var_04) {
    param_01 = param_01 * 0.85;
  }

  if(lib_0547::func_5565(param_00, "svt40_zm") && param_01 >= var_05) {
    param_01 = param_01 * 0.85;
  }

  if(lib_0547::func_5565(param_00, "dp28_zm") && lib_0547::func_5565(param_02, "MOD_EXPLOSIVE")) {
    param_01 = var_03;
  }

  if(lib_0547::func_5565(param_00, "teslagun_zm_blood") && param_01 > var_03) {
    param_01 = var_03;
  }

  if(lib_0547::func_5565(param_00, "teslagun_zm_death") && param_01 > var_03) {
    param_01 = var_03;
  }

  if(lib_0547::func_5565(param_00, "teslagun_zm_moon") && param_01 > var_03) {
    param_01 = var_03;
  }

  if(lib_0547::func_5565(param_00, "teslagun_zm_storm") && param_01 > var_03) {
    param_01 = var_03;
  }

  if(param_01 > var_06) {
    param_01 = param_01 * 0.8;
  }

  return int(param_01);
}

________the_classic________() {}

shotgun_classic_init() {
  var_00 = getent("the_classic_jolt_volume", "targetname");
  for(;;) {
    level waittill("zombie_airdrop_inbound");
    var_00 thread shotgun_classic_listen_for_jolts();
  }
}

shotgun_classic_listen_for_jolts() {
  level endon("zombie_airdrop_inbound");
  level endon("zombie_airdrop_landed");
  level endon("classic_added_to_box");
  var_00 = 0;
  for(;;) {
    level waittill("spawned_money_share");
    foreach(var_02 in level.var_8AD2) {
      if(!self method_858B(var_02.var_116)) {
        continue;
      }

      var_03 = var_02.var_117;
      var_04 = var_03 getentitynumber();
      var_02 maps\mp\zombies\_zombies_money::func_8ADD(var_04, 0);
      var_02.var_6FD4 = 0;
      var_02.var_6FCB = 0;
      var_00++;
      thread shotgun_classic_jolt_drop_fx(self.var_116);
    }

    if(var_00 >= 5) {
      shotgun_classic_add_classic_to_box();
    }
  }
}

shotgun_classic_jolt_drop_fx(param_00) {
  var_01 = spawnfx(common_scripts\utility::func_44F5("moneyCloud"), param_00);
  triggerfx(var_01);
  wait(3);
  var_01 delete();
}

shotgun_classic_add_classic_to_box() {
  iprintlnbold("Classic added to SMG box!");
  var_00 = common_scripts\utility::func_46B7("the_classic_complete_fx_org", "targetname");
  foreach(var_02 in var_00) {
    thread shotgun_classic_jolt_drop_fx(var_02.var_116);
  }

  common_scripts\utility::func_3C8F("shotgun_classic_add_to_box");
  level notify("classic_added_to_box");
}