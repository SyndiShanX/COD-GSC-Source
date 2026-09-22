/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\shotgun\_zombies_shotgun_gamemode.gsc
*************************************************************************/

init_sg() {
  level thread maps\mp\zombies\_zombies_progression::init();
  _setomnvar("ui_zm_gamemode_mod", 1);
  _setomnvar("ui_zm_rs_active", 0);
  level.objectivescompleted = 0;
  maps\mp\zombies\shotgun\_zombies_shotgun_difficulty::init();
  common_scripts\utility::flag_init("zmb_players_gamemode_escaped");
  common_scripts\utility::flag_init("zmb_players_gamemode_boss_defeated");
  common_scripts\utility::flag_init("zmb_objectives_defense_start");
  common_scripts\utility::flag_init("zmb_objectives_defense_end");
  common_scripts\utility::flag_init("zmb_objectives_quest_end");
  common_scripts\utility::flag_init("shotgun_classic_add_to_box");
  _precacheshader("s2_morale_focus_overlay_01");
  level.sg_wallbuyclasses = ["weapon_pistol", "weapon_smg", "weapon_shotgun", "weapon_assault", "weapon_sniper", "weapon_heavy"];
  level.insane_mode_available = 0;
  level.max_prop_zombie_appearances = 2;
  level.iszombiesshotgun = 1;
  level.shotgunuseintrocams = 0;
  level._id_ABDA = 1;
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
  level._id_3C00 = 0;
  level._id_3BED = 0;
  level.zmb_match_countdown_time = 3;
  level.zmb_force_ended_wave = undefined;
  level.zmb_is_endless_wave = 0;
  level.zmb_sg_objectives = [];
  level.zmb_sg_obj_basic_funcs = [];
  level._id_2986 = "mp/zombieEnemyWavesShotgun.csv";
  level.override_weapon_costs = 1000;
  level.zombies_shotgun_weapons_in_play = [];
  level.use_zombie_unresolved_collision = 1;
  level.zmb_sg_banned_objectives = [];
  level._id_73BD = ::no_points_for_bosses_or_objective_zombies;
  level.unlockzmshatteredmap = ::unlockzmshatteredmap;
  level._id_08AF = _id_0547::razergunmaxammo;
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

  foreach(var_2, var_1 in level.zombies_shotgun_weapons_splashes) {
    var_1 = tablelookup(maps\mp\gametypes\_hud_message::get_splash_table(), 0, var_1, 3);
    level.zombies_shotgun_weapons_splashes[var_2 + "_shader"] = var_1;
  }

  level.zombies_shotgun_weapons_splashes["weapon_pistol_shader"] = "s2_challenge_zombies_pistol";
  level.zombies_shotgun_weapons_splashes["weapon_smg_shader"] = "s2_challenge_zombies_smg";

  foreach(var_4, var_1 in level.zombies_shotgun_weapons_splashes) {
    if(issubstr(var_4, "shader") && var_1 != "") {
      _precacheshader(var_1);
    }
  }

  foreach(var_4, var_1 in level.zombies_shotgun_weapon_waypoints) {
    if(var_1 != "") {
      _precacheshader(var_1);
    }
  }

  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_fx::init();
  maps\mp\mp_zombie_nest_ee_wave_manipulation::main();
  level thread soundscripts\_snd_common_zmb_dlc3::snd_zmb_init_dlc3();
  level thread maps\mp\zombies\_zombies_audio_dlc2::initdlc2audio();
  level thread _id_0544::init();
  level thread maps\mp\zombies\sg_events_v1\_boss_util::init();
  maps\mp\zombies\zombie_carepackage::init();
  init_sg_shaders();
  var_6 = "normal";

  if(isDefined(level.zmb_sg_default_wave_override)) {
    var_6 = level.zmb_sg_default_wave_override;
  }

  level.upgrade_machine_upgrade_func = ::collect_souls_to_unlock_pack_a_punch;
  level.onstartshotgunfunc = ::onshotgunstart;
  level.zmb_sg_round_start_func = ::sg_run_round_start;
  level.zmb_sg_round_end_func = ::sg_run_round_end;
  level.zmb_round_over_override = ::sg_display_remaining_rounds;
  level.zombieslevelspawndelayfunc = ::sg_spawn_delay_func;
  level.zmb_trigger_weapon_get_func = maps\mp\zombies\shotgun\_wallbuys_shattered::get_weapon_from_trigger_data;
  level._id_902A = ::_id_902A;
  level.dropschedulefunc = ::sg_pickup_drop_schedule;
  level.zmb_sg_desired_perk_order = ["quickrevive", "punchperk", "fastreload", "punchperk", "doubletap", "electriccherry"];
  level thread run_pack_a_punch_log();
  level sg_calc_wave_healths_inc_linear();
  initialize_common_shattered_v1_objectives();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::basic_boss_init();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::basic_collect_init();
  level thread sg_override_movemodes();
  level thread maps\mp\zombies\shotgun\_zombies_ammo_caches::ammo_cache_setup();
  level thread maps\mp\zombies\shotgun\_carepackage_shattered::init();
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::init();
  level thread maps\mp\zquests\dlc3_trophies_shattered_mode::init();
  level thread run_red_skull_mode();
  level thread init_weapon_pickups_on_zombie_death();
  _id_0547::_id_7BA9(::spawn_weapon_pickup_on_zombies);
}

init_weapon_pickups_on_zombie_death() {
  var_0 = getEntArray("wustling_weapon_drop_trigger", "targetname");

  foreach(var_2 in var_0) {
    var_2 common_scripts\utility::_id_9D9F();
  }
}

unusable_for_other_players(var_0) {
  self disableplayeruse(var_0);
  self _meth_8006(var_0);
}

init_dropped_weapon_pickup_for_player(var_0) {
  var_1 = self;
  var_1 maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::initialize_weapon_pickup_trigger(var_0, level.zmb_wustling_weapon, 0);

  if(isDefined(level.zmb_wustling_weapon_spawned) && !level.zmb_wustling_weapon_spawned) {
    var_1._id_65DC._id_2F74 = 1;
    var_1._id_65DC._id_6642 = 1;
  }
}

spawn_weapon_pickup_on_zombies(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!_id_0547::_id_5565(self._id_0A4B, "zombie_heavy") && !isDefined(self.bossloot)) {
    return;
  }
  if(common_scripts\utility::_id_562E(level.zmb_wustling_weapon_spawned)) {
    return;
  }
  if(_id_0547::_id_5565(var_4, "dot_generic_zm")) {
    var_1 = level.player;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  if(_id_0547::_id_5565(self._id_000A, level._id_746E)) {
    return;
  }
  var_9 = maps\mp\gametypes\zombies::_id_3B9B(self.origin);

  if(!isDefined(var_9)) {
    return;
  }
  var_10 = common_scripts\utility::_id_0F73(level.zombies_shotgun_weapons_in_play["weapon_pistol"], level.zombies_shotgun_weapons_in_play["weapon_smg"]);
  var_10 = common_scripts\utility::_id_0F6F(var_10, "dp28_zm");
  var_10 = common_scripts\utility::_id_0F6F(var_10, "blunderbuss_zm");

  if(isDefined(self.bossloot)) {
    var_10 = ["dp28_pap_zm", "sdk_pap_zm", "charlton_pap_zm", "emp44_pap_zm", "m1911_pap_zm", "p38_pap_zm", "svt40_pap_zm", "m1garand_pap_zm", "blunderbuss_pap_zm"];
  }

  var_11 = common_scripts\utility::random(var_10);
  var_12 = issubstr(var_11, "_pap");
  var_11 = _id_0548::_id_454B(var_1, var_11);

  if(var_12) {
    var_11 = var_1 _id_0586::_id_078B(_id_0547::_id_AAF9(var_11));
  }

  var_13 = getEntArray("wustling_weapon_drop_trigger", "targetname");
  level.zmb_wustling_weapon = var_11;

  if(!isDefined(level.zmb_wustling_weapon_spawned)) {
    foreach(var_16, var_15 in var_13) {
      var_15.setmovespeedscale = var_16;
      _id_0547::_id_8A4F(var_15, ::init_dropped_weapon_pickup_for_player, ::unusable_for_other_players);
      var_15.origin = var_9 + (0, 0, 32);
    }
  } else {
    foreach(var_16, var_15 in var_13) {
      if(isDefined(var_15._id_65DC)) {
        var_15.origin = var_9 + (0, 0, 32);
        var_15._id_A9E0 = _id_0547::_id_AAF9(var_11, 1);
        var_15._id_6C5C = var_15._id_A9E0;
        var_15._id_A7D7 = 1;
        var_15._id_65DC._id_A9B4 = var_15._id_A9E0;
        var_15._id_65DC._id_A9A5 = 0;
        var_15._id_65DC._id_2F74 = 0;
        var_15._id_65DC._id_6642 = 1;
      }
    }
  }

  level.zmb_wustling_weapon_spawned = 1;
  var_18 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::spawn_a_floating_weapon_award(var_11, var_9 + (0, 0, 8), undefined);

  foreach(var_15 in var_13) {
    var_18 thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::_id_A653(var_15, var_18.fx, var_11, 1);
  }

  level waittill("wustling_weapon_pickup", var_21);

  foreach(var_15 in var_13) {
    var_18 maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::remove_weapon_pickup(var_15, var_18.fx);
  }

  if(isDefined(var_18)) {
    var_18 delete();
  }

  if(isDefined(var_18.fx)) {
    var_18.fx delete();
  }

  foreach(var_16, var_15 in var_13) {
    if(isDefined(var_15._id_65DC)) {
      var_15._id_65DC._id_2F74 = 1;
      var_15._id_65DC._id_6642 = 1;
    }
  }

  if(issubstr(var_11, "_pap")) {
    var_11 = var_21 _id_0586::_id_078B(_id_0547::_id_AAF9(var_11));
  }

  if(isDefined(var_21)) {
    _id_0548::_id_A7D6(var_21, var_11);
  }

  level.zmb_wustling_weapon_spawned = 0;
}

donothing(var_0) {}

run_red_skull_mode() {
  var_0 = getEntArray("zmb_shattered_insane_mode_triggers", "targetname");

  foreach(var_3, var_2 in var_0) {
    var_2.setmovespeedscale = var_3;
    _id_0547::_id_8A4F(var_2, ::assignpathtoplayer, ::hidefromothers);
  }

  while(!common_scripts\utility::_id_562E(level.gamehasstarted)) {
    waitframe();
  }

  level.insane_mode_available = 1;

  if(!common_scripts\utility::_id_562E(level.insane_mode_available)) {
    return;
  }
  var_4 = wait_for_a_max_ranked_player();

  if(common_scripts\utility::_id_562E(var_4)) {
    foreach(var_3, var_2 in var_0) {
      var_2 setHintString(&"ZOMBIE_DLC3_RED_SKULL_MODEL");
    }

    level thread maps\mp\_utility::_id_6F74(::spawn_client_hc_opt_in, var_0, "zmb_darkened_path_unavailable");
  }
}

activate_redskull_mode() {
  level.zmb_red_skull_mode_activated = 1;
  _setomnvar("ui_zm_rs_active", 1);
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

modify_agent_spawn_boost(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level.dynamic_special_enemy_add[var_0].size; var_3++) {
    level.dynamic_special_enemy_add[var_0][var_3] = [int(var_2 + var_1 * level.dynamic_special_enemy_add[var_0][var_3][0]), int(var_2 + var_1 * level.dynamic_special_enemy_add[var_0][var_3][1])];
  }
}

ensure_all_zombies_sprinting() {
  for(;;) {
    foreach(var_1 in _id_0547::_id_408F()) {
      var_1._id_6941 = 1;
    }

    wait 0.5;
  }
}

do_rage_vision_for_all() {
  level thread maps\mp\_utility::_id_6F74(::showragevision);
}

showragevision() {
  var_0 = self;
  self setclienttriggervisionset(maps\mp\_utility::_id_4571() + "_rage", 1);
  self lightsetoverrideenableforplayer(maps\mp\_utility::_id_4571() + "_rage", 1);
  wait 2;
  self setclienttriggervisionset(maps\mp\_utility::_id_4571(), 1);
  self lightsetoverrideenableforplayer(maps\mp\_utility::_id_4571(), 1);
}

no_points_for_bosses_or_objective_zombies(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_1.sgvip)) {
    return 0;
  }

  if(common_scripts\utility::_id_562E(var_1.sgboss)) {
    return 0;
  }

  return 1;
}

assignpathtoplayer(var_0) {
  var_0 endon("disconnect");
  common_scripts\utility::_id_9DA3();
  level thread hide_trigger_on_disconnect(var_0, self);

  while(!common_scripts\utility::_id_562E(level.redskull_mode_unavailable) && !common_scripts\utility::_id_562E(var_0.optedintohc) && !common_scripts\utility::_id_562E(var_0.failedoptintohc)) {
    waitframe();
  }

  common_scripts\utility::_id_9D9F();
}

hide_trigger_on_disconnect(var_0, var_1) {
  var_0 waittill("disconnect");
  var_1 common_scripts\utility::_id_9D9F();
}

hidefromothers(var_0) {}

spawn_client_hc_opt_in(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  waitframe();
  var_2 = common_scripts\utility::_id_46B5("zmb_shattered_insane_mode", "targetname");

  if(!isDefined(level.shattered_opt_in_ents)) {
    level.shattered_opt_in_ents = [];
  }

  if(maps\mp\_utility::_id_4571() == "mp_zombie_dig_02") {
    var_2.origin = var_2.origin + (0, 0, 6);
  }

  var_3 = _id_0547::_id_8FBA(var_2, "zmb_shattered_insane_mode", var_1);
  var_3 _id_0378::_id_8D74("dlc3_zmb_redskull_pu");
  var_1 thread remove_visuals_on_disconnect(var_3);
  level.shattered_opt_in_ents[level.shattered_opt_in_ents.size] = var_3;
  _triggerfx(var_3);
  var_4 = 25;

  for(;;) {
    if(var_4 < 0 || !common_scripts\utility::_id_562E(var_1.optedintohc) && var_1 useButtonPressed() && distance(var_1.origin, var_2.origin) < 64) {
      if(var_4 >= 0) {
        var_1.optedintohc = 1;
      } else {
        var_1.failedoptintohc = 1;
      }

      if(isDefined(var_3)) {
        var_3 delete();
      }

      var_3 = _id_0547::_id_8FBA(var_2, "zmb_shattered_insane_mode_pending", var_1);
      level.shattered_opt_in_ents[level.shattered_opt_in_ents.size] = var_3;
      _triggerfx(var_3);
      var_3 _id_0378::_id_8D74("dlc3_redskull_accept");
      maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::try_activate_redskull_mode();
      return;
    }

    var_4 = var_4 - 0.1;
    wait 0.1;
  }

  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::remove_redskull_mode_activation();
}

remove_visuals_on_disconnect(var_0) {
  var_1 = self;
  var_0 endon("entitydeleted");
  var_1 waittill("disconnect");
  var_0 delete();
}

wait_for_a_max_ranked_player() {
  while(level._id_A980 < 3) {
    foreach(var_1 in level.players) {
      var_2 = var_1 maps\mp\zombies\_zombies_progression::get_zm_shotgun_player_level();

      if(var_2 == level.zmshotgunmaxlevel) {
        return 1;
      }
    }

    waitframe();
  }
}

getshatteredmapsequenceinfo() {
  var_0 = self;
  var_1 = _id_0547::zombie_shattered_get_map_number();
  var_2 = common_scripts\utility::_id_562E(level.zmb_shotgun_game_won);
  var_3 = common_scripts\utility::_id_562E(level.shattered_ee_complete);
  var_4 = common_scripts\utility::_id_562E(level.zmb_red_skull_mode_activated);
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;

  if(var_1 > 0) {
    if(_id_0547::is_zm_shattered_windmill_map()) {
      var_5 = var_2;
      var_6 = var_3;
      var_7 = var_4;
    } else if(_id_0547::is_zm_shattered_dnk_map() && _id_0547::is_zm_shattered_windmill_map(var_0.prevmapname) || _id_0547::is_zm_shattered_thule_map() && _id_0547::is_zm_shattered_dnk_map(var_0.prevmapname)) {
      var_5 = var_0.ismapinsequence && var_2;
      var_6 = var_0.iseeinsequence && var_3;
      var_7 = var_0.isredskullinsequence && var_4 && var_2;
    }
  }

  return [var_1, var_5, var_6, var_7];
}

unlockzmshatteredmap() {
  var_0 = self;
  [var_2, var_3, var_4, var_5] = getshatteredmapsequenceinfo();
  var_6 = common_scripts\utility::_id_562E(level.zmb_shotgun_game_won);

  if(var_2 > 0) {
    var_0 setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "prevWinStatus", var_6);
    var_0 setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "isMapInSequence", var_3);
    var_0 setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "isEEInSequence", var_4);
    var_0 setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "isRedSkullInSequence", var_5);

    if(var_6) {
      var_7 = 1 << var_2 - 1;
      var_8 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "mapCompleted");
      var_8 = var_8 | var_7;
      var_0 setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "mapCompleted", var_8);
    }

    if(_id_0547::is_zm_shattered_thule_map()) {
      if(getdvarint("spv_shattered_srv_unlock_easy", 0) == 1) {
        if(var_6 && _isonlinegame()) {
          var_0 _meth_8697(42, [5, 5]);
        }
      }

      if(common_scripts\utility::_id_562E(var_3)) {
        if(common_scripts\utility::_id_562E(var_4)) {
          if(var_6 && _isonlinegame()) {
            var_0 _meth_8697(42, [5, 5]);
            var_0 _id_0565::getanimentrycount(16, 3, 1, "wicht_set");
          }

          self setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "hasCompletedEESequence", 1);
        }

        if(common_scripts\utility::_id_562E(var_5)) {
          if(_isonlinegame()) {
            var_0 _meth_8697(44, [5, 7]);
            var_0 thread maps\mp\gametypes\_hud_message::_id_9102("zm_charm_unlocked", 0);
          }
        }
      }
    }
  }
}

initialize_common_shattered_v1_objectives() {
  level thread maps\mp\zombies\sg_events_v1\keypoint_defense::init();
  level thread maps\mp\zombies\sg_events_v1\interact_repair::init();
  level thread maps\mp\zombies\sg_events_v1\assassin_squad::init();
  level thread maps\mp\zombies\sg_events_v1\very_important_zombie::init();
  level thread maps\mp\zombies\sg_events_v1\escape_sequence::init();
  level thread maps\mp\zombies\sg_events_v1\extermination::init();
}

include_shotgun_v1_common_objectives(var_0) {
  if(!isDefined(var_0)) {
    var_0 = [];
  }

  var_1 = [];
  var_1["type_defense_common"] = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("defense_common", "type_defense_common", [6, 9], 240, undefined, undefined, undefined, undefined, 1);
  var_1["type_extermination_common"] = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("extermination_common", "type_extermination_common", [3, 6, 9]);
  var_1["type_meuchler_common"] = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("meuchler_common", "type_meuchler_common", [3, 6, 9]);
  var_1["type_keypoint_interact_repair_common"] = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("keypoint_interact_repair_common", "type_keypoint_interact_repair_common", [3, 6], 240, undefined, undefined, undefined, undefined, 1);
  var_1["type_assassinate_common"] = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("assassinate_common", "type_assassinate_common", [6, 9], 240, undefined, undefined, undefined, undefined, 1);
  var_1["type_escape_common"] = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register("escape_common", "type_escape_common", [11]);

  foreach(var_4, var_3 in var_1) {
    if(isDefined(var_0[var_4])) {
      if(isDefined(var_0[var_4].extra_func)) {
        var_3.extra_func = var_0[var_4].extra_func;
      }

      if(isDefined(var_0[var_4]._id_2A35)) {
        var_3._id_2A35 = var_0[var_4]._id_2A35;
      }
    }
  }
}

initialize_common_sg_weapons() {
  level thread _id_057D::_id_5162();
  level thread maps\mp\zombies\weapons\_zombie_dlc2_melee::init();
  common_scripts\utility::flag_init("dlc2_melee_packable");
  level.sworddeliveryoff = 1;
  level thread maps\mp\zombies\weapons\_zombie_dlc3_melee::init();
  level thread _id_0580::init();
  level thread maps\mp\zombies\weapons\_zombie_razer_gun::init();
}

init_sg_shaders() {
  level.zmb_sg_wallbuy_waypoint_icon = "zm_hud_wallbuy_pistol";
  _precacheshader("zm_hud_wallbuy_pistol");
  level.zmb_sg_keypoint_interact_repair_icon = "zm_hud_type_keypoint_interact_repair_common_icon";
  _precacheshader("zm_hud_type_keypoint_interact_repair_common_icon");
  level.zmb_sg_keypoint_interact_defuse_icon = "zm_hud_keypoint_interact_bomb_icon";
  _precacheshader("zm_hud_keypoint_interact_bomb_icon");
  _precacheshader("zm_hud_type_escape_common_icon");
  _precacheshader("zm_hud_type_escape_b_common_icon");
}

run_pack_a_punch_log() {
  if(isDefined(level.upgrade_machine_upgrade_func)) {
    level thread[[level.upgrade_machine_upgrade_func]]();
  }
}

collect_souls_to_unlock_pack_a_punch() {
  var_0 = common_scripts\utility::_id_46B7("zmb_sg_pap_light_display", "targetname");
  var_1 = common_scripts\utility::_id_46B7("zmb_pack_key", "targetname");
  var_2 = common_scripts\utility::_id_46B7("zmb_sg_availablility_light_display", "targetname");
  var_3 = _getscriptablearray("zmb_sg_reciver_scriptable", "targetname");

  foreach(var_5 in var_3) {
    var_5 thread maps\mp\mp_zombie_nest_hilt_altar_reciever::_id_84DC();
  }

  if(var_1.size < 3) {
    return;
  }
  level.pack_a_punc_pre_func = ::wait_for_pap_available;

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    common_scripts\utility::flag_init("zmb_sg_soul_collect_flag_" + var_1[var_7].setmovespeedscale);
    common_scripts\utility::flag_init("zmb_sg_soul_collect_ready_flag_" + var_1[var_7].setmovespeedscale);
  }

  common_scripts\utility::_id_0FB2(var_1, ::set_pack_key_unlocked);
  common_scripts\utility::_id_0FB2(var_0, ::handle_unlock_lights, "zmb_sg_soul_collect_flag_");
  common_scripts\utility::_id_0FB2(var_2, ::handle_unlock_lights, "zmb_sg_soul_collect_ready_flag_", "zmb_sg_soul_collect_flag_");
  maps\mp\_utility::_id_2CED(3, ::unlock_next_reciever);
  wait_for_pap_available();
  wait 0.5;
  level notify("pap_state_change");
  level thread maps\mp\_utility::_id_6F74(maps\mp\gametypes\_hud_message::_id_9102, "zm_pap_unlocked");
}

wait_for_pap_available() {
  var_0 = _getEnt("pack_a_punch_weapon_display", "targetname");
  var_0 ghost();

  for(var_1 = 0; var_1 < 3; var_1++) {
    common_scripts\utility::_id_3C9F("zmb_sg_soul_collect_flag_" + (var_1 + 1));
  }
}

unlock_next_reciever() {
  if(!isDefined(level.zmb_pap_reciver_unlocks)) {
    level.zmb_pap_reciver_unlocks = 0;
  }

  level.zmb_pap_reciver_unlocks++;
  var_0 = "zmb_sg_soul_collect_ready_flag_" + level.zmb_pap_reciver_unlocks;

  if(common_scripts\utility::_id_3C83(var_0)) {
    common_scripts\utility::flag_set(var_0);
  }
}

handle_unlock_lights(var_0, var_1) {
  _id_0547::_id_A6F6();
  var_2 = self.setmovespeedscale;
  var_3 = _id_0547::_id_8FBA(self, "zmb_nest_generator_bulb_red");
  _triggerfx(var_3);
  common_scripts\utility::_id_3C9F(var_0 + self.setmovespeedscale);
  var_3 delete();
  var_3 = _id_0547::_id_8FBA(self, "zmb_nest_generator_bulb_green");
  _triggerfx(var_3);

  if(!isDefined(var_1)) {
    return;
  }
  common_scripts\utility::_id_3C9F(var_1 + self.setmovespeedscale);
  var_3 delete();
  var_3 = _id_0547::_id_8FBA(self, "zmb_nest_generator_bulb_off");
  _triggerfx(var_3);
}

set_pack_key_unlocked() {
  var_0 = self.setmovespeedscale;
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  common_scripts\utility::_id_3C9F("zmb_sg_soul_collect_ready_flag_" + self.setmovespeedscale);
  var_2 = 400;

  if(common_scripts\utility::_id_562E(level.sg_pack_use_small_radius)) {
    var_2 = 256;
  }

  var_1.ignoresighttrace = 1;
  var_1 maps\mp\mp_zombies_soul_collection::_id_170B(10, var_2, 70, "zmb_sg_soul_collect_ping_" + var_0, undefined, "tag_origin", undefined, "tag_origin");
  common_scripts\utility::flag_set("zmb_sg_soul_collect_flag_" + self.setmovespeedscale);
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("geistcraft_device_powered");
}

sg_calc_wave_healths_inc_linear() {
  for(var_0 = 1; var_0 <= 11; var_0++) {
    var_1 = 150;
    var_2 = 75;

    if(var_0 > 1) {
      for(var_3 = 2; var_3 < var_0 + 1; var_3++) {
        var_4 = var_1;
        var_1 = var_1 + var_2 * var_3;

        if(var_1 < var_4) {
          var_1 = var_4;
          break;
        }
      }
    }

    var_5 = var_1;
    level.wave_healths[var_0] = var_5;
  }
}

sg_pickup_drop_schedule() {
  level waittill("zombie_wave_started");
  var_0 = level.players.size * 2000;
  var_1 = level.players.size * 3000;

  if(_id_0547::_id_0F0F("specialty_class_resourceful_zm")) {
    var_1 = level.players.size * 2000;
  }

  var_2 = 1.14;
  var_3 = var_2;
  var_4 = var_0 + var_1;
  maps\mp\gametypes\zombies::_id_6FC8("Next Scheduled at " + var_4 + " points");

  for(;;) {
    var_5 = 0;

    foreach(var_7 in level.players) {
      if(isDefined(var_7._id_62D7)) {
        var_5 = var_5 + var_7._id_62D7;
      }
    }

    if(var_5 > var_4) {
      level._id_34AA = 1;
      maps\mp\gametypes\zombies::_id_6FC8("Reached Scheduled " + var_5 + ">" + var_4);
      var_1 = level.players.size * 3000;

      if(_id_0547::_id_0F0F("specialty_class_resourceful_zm")) {
        var_1 = level.players.size * 2000;
      }

      var_4 = var_5 + var_1 * var_3;
      var_3 = var_3 * var_2;
      maps\mp\gametypes\zombies::_id_6FC8("Next Scheduled at " + var_4 + " points");
    }

    wait 0.5;
  }
}

sg_pickup_max_per_round() {
  var_0 = clamp(_id_0547::_id_45C9(), 1, 2);

  if(_id_0547::_id_0F0F("specialty_class_resourceful_zm")) {
    var_0 = var_0 + 1;
  }

  return var_0;
}

sg_spawn_delay_func(var_0) {
  if(isDefined(level.sg_manual_spawn_delay)) {
    return level.sg_manual_spawn_delay;
  }

  var_1 = 0.85;
  var_2 = 0.5;

  for(var_3 = 1; var_3 < var_0; var_3++) {
    var_2 = var_2 * var_1;

    if(var_2 <= 0.1) {
      var_2 = 0.1;
      break;
    }
  }

  return var_2;
}

onshotgunstart() {
  level._id_300C = ::zombiesdisplaygameendfuncwinnerslosers;
  initialize_weapons_in_play();
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_difficulty::initialize_care_package_rewards();
  level thread maps\mp\zombies\shotgun\_wallbuys_shattered::override_wall_buys_by_class();
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::altered_state_init();

  if(common_scripts\utility::_id_562E(level.shotgunuseintrocams)) {
    level thread maps\mp\_utility::_id_6F74(::run_intro_cinematic, undefined, "cinematic_intros_closed");
  }

  level thread start_match_in_time(10);
  common_scripts\utility::flag_set("ripsaw_punch_active");
}

start_match_in_time(var_0) {
  while(!common_scripts\utility::_id_562E(level.gamehasstarted)) {
    waitframe();
  }

  wait(var_0 * 0.3);
  level notify("cinematic_intros_closed");
  wait(var_0 * 0.7);
  level notify("zombies_manual_start");
}

run_intro_cinematic() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0._id_6772 = _newclienthudelem(var_0);
  var_0._id_6772 setshader("black", 640, 480);
  var_0._id_6772.sort = 999;
  var_0._id_6772._id_00C6 = "fullscreen";
  var_0._id_6772._id_01CA = "fullscreen";
  var_0._id_6772.foreground = 0;
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  var_1 = common_scripts\utility::_id_46B7("sg_intro_cam", "targetname");
  var_2 = common_scripts\utility::_id_46B7("sg_intro_cam", "script_noteworthy");
  var_1 = common_scripts\utility::_id_0FA5(var_1, ::script_index_compare);

  foreach(var_5, var_4 in var_1) {
    var_4.dest = common_scripts\utility::_id_4461(var_4.origin, var_2);
    var_0 maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::run_ingame_cinematic([var_4, 0, int(10 / var_1.size), 0.9, var_5 == var_1.size - 1, 1]);
  }
}

run_outro_cinematic() {
  var_0 = self;
  var_0 endon("disconnect");

  if(!isDefined(level.outro_targetname)) {
    return;
  }
  var_0._id_6772 = _newclienthudelem(var_0);
  var_0._id_6772 setshader("black", 640, 480);
  var_0._id_6772.sort = 999;
  var_0._id_6772._id_00C6 = "fullscreen";
  var_0._id_6772._id_01CA = "fullscreen";
  var_0._id_6772.foreground = 0;
  var_1 = common_scripts\utility::_id_46B5(level.outro_targetname, "targetname");
  var_1.dest = common_scripts\utility::_id_46B5(var_1.target, "targetname");
  var_0 maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::run_ingame_cinematic([var_1, 0, 10, 0.9, 1, 1]);
}

script_index_compare(var_0, var_1) {
  return var_0.setmovespeedscale < var_1.setmovespeedscale;
}

set_game_won() {
  common_scripts\utility::flag_set("zmb_players_gamemode_escaped");
  level.zmb_shotgun_game_won = 1;
  maps\mp\zquests\dlc3_trophies_shattered_mode::complete_shattered_escape_event();
}

zombiesdisplaygameendfuncwinnerslosers(var_0, var_1) {
  if(level.zmb_shotgun_game_won) {
    var_0 = "allies";
  }

  maps\mp\gametypes\zombies::_id_AC54(var_0, var_1);
}

sg_override_movemodes() {
  while(!isDefined(level._id_0A41)) {
    waitframe();
  }

  while(!isDefined(level._id_0A41["zombie_generic"])) {
    waitframe();
  }

  while(!isDefined(level._id_0A41["zombie_generic"]["move_mode"])) {
    waitframe();
  }

  level._id_0A41["zombie_generic"]["move_mode"] = ::sg_fodder_move_mode;
}

sg_fodder_move_mode() {
  var_0 = self._id_901F;

  if(common_scripts\utility::_id_562E(self._id_6941) && isDefined(level._id_ABDD)) {
    return level._id_ABDD[level._id_ABDD.size - 1];
  }

  return _id_054D::_id_957E(var_0 + 7);
}

initialize_weapons_in_play() {
  var_0 = [];

  foreach(var_2 in level._id_5F7F) {
    var_0 = common_scripts\utility::_id_0F6F(var_0, var_2["baseNameNoMP"]);
  }

  foreach(var_5 in level._id_A7DE) {
    var_0 = common_scripts\utility::_id_0F6F(var_0, var_5._id_0165);
  }

  foreach(var_2 in var_0) {
    var_8 = _id_0547::zm_get_weapon_class(var_2);

    if(!isDefined(var_8)) {
      var_8 = "misc_weapon";
    }

    if(!isDefined(level.zombies_shotgun_weapons_in_play[var_8])) {
      level.zombies_shotgun_weapons_in_play[var_8] = [];
    }

    level.zombies_shotgun_weapons_in_play[var_8] = common_scripts\utility::_id_0F6F(level.zombies_shotgun_weapons_in_play[var_8], var_2);
  }

  level.zombies_shotgun_weapons_in_play["weapon_pistol"] = _id_0547::get_zombies_mode_starter_weapons();
  level.zombies_shotgun_weapons_in_play["weapon_pistol"] = common_scripts\utility::_id_0F93(level.zombies_shotgun_weapons_in_play["weapon_pistol"], "shovel_zm");
  level.zombies_shotgun_weapons_in_play["weapon_assault"] = common_scripts\utility::_id_0F93(level.zombies_shotgun_weapons_in_play["weapon_assault"], "m2carbine_zm");
  level.zombies_shotgun_weapons_in_play["weapon_assault"] = common_scripts\utility::_id_0F93(level.zombies_shotgun_weapons_in_play["weapon_assault"], "g43_zm");
  level.zombies_shotgun_weapons_in_play["weapon_assault"] = common_scripts\utility::_id_0F93(level.zombies_shotgun_weapons_in_play["weapon_assault"], "svt40_zm");
  level.zombies_shotgun_weapons_in_play["weapon_pistol"] = common_scripts\utility::_id_0F6F(level.zombies_shotgun_weapons_in_play["weapon_pistol"], "m2carbine_zm");
  level.zombies_shotgun_weapons_in_play["weapon_pistol"] = common_scripts\utility::_id_0F6F(level.zombies_shotgun_weapons_in_play["weapon_pistol"], "g43_zm");
  level.zombies_shotgun_weapons_in_play["weapon_pistol"] = common_scripts\utility::_id_0F6F(level.zombies_shotgun_weapons_in_play["weapon_pistol"], "svt40_zm");
  level.zombies_shotgun_weapons_in_play["weapon_shotgun"] = common_scripts\utility::_id_0F6F(level.zombies_shotgun_weapons_in_play["weapon_shotgun"], "model21_zm");
  level.zombies_shotgun_weapons_in_play["weapon_shotgun"] = common_scripts\utility::_id_0F6F(level.zombies_shotgun_weapons_in_play["weapon_shotgun"], "m30_zm");

  foreach(var_15, var_11 in level.zombies_shotgun_weapons_in_play) {
    var_11 = common_scripts\utility::_id_0F97(var_11);
    level.zombies_shotgun_weapons_in_play[var_15] = var_11;
  }
}

sg_run_round_start() {
  maps\mp\zombies\shotgun\_zombies_shotgun_difficulty::boost_special_enemy_waves();
  sg_obj_unset_wave_endless();
  sg_mod_intermission_time();
  level._id_60A9 = sg_pickup_max_per_round();
  var_0 = "normal";
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::try_activate_redskull_mode(1);
  var_1 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_select();

  if(isDefined(var_1)) {
    if(common_scripts\utility::_id_562E(var_1.is_endless_wave)) {
      if(common_scripts\utility::_id_562E(var_1.endless_no_heavies)) {
        sg_obj_set_wave_endless(1);
      } else {
        sg_obj_set_wave_endless(0);
      }
    }

    var_0 = var_1.type;
    sg_mod_intermission_time(30);
    level thread sg_run_obj_round(var_1);
  } else {
    foreach(var_3 in level.players) {
      var_4 = tablelookup("mp/zombiesShotgunObjectiveData.csv", 0, var_0, 1);
      var_3 setclientomnvar("ui_onevone_class_1", int(var_4));
    }
  }

  return var_0;
}

sg_run_round_end(var_0) {
  level notify("zmb_shattered_play_dlg_" + level._id_A980);
}

sg_end_game() {
  if(common_scripts\utility::_id_562E(level.zmb_shotgun_game_won)) {
    var_0 = "zombies_completed";
  } else {
    var_0 = "zombie_extraction_failed";
  }

  _id_0553::_id_AC1F(var_0, undefined, 1);
}

sg_is_escape_round() {
  return level._id_A980 == 11;
}

sg_end_round() {
  level.zmb_force_ended_wave = level._id_A980;
}

sg_mod_intermission_time(var_0) {
  if(isDefined(var_0)) {
    level._id_7F1B = var_0;
  } else {
    level._id_7F1B = 20;
  }

  if(level._id_A980 >= 9) {
    level._id_7F1B = 30;
  }
}

sg_display_remaining_rounds(var_0) {
  _setomnvar("ui_zm_round_number", var_0);
}

sg_run_obj_round(var_0) {
  if(isDefined(var_0.event_func)) {
    var_1 = sg_obj_splash_get_type_name_friendly(var_0.type);

    foreach(var_3 in level.players) {
      var_4 = undefined;

      if(var_0.type == "type_boss") {
        var_3 thread maps\mp\gametypes\_hud_message::_id_9102(var_0._id_502A);
        var_4 = tablelookup("mp/zombiesShotgunObjectiveData.csv", 0, var_0._id_502A, 1);
      } else {
        if(var_0.type != "type_escape_common") {
          var_3 thread maps\mp\gametypes\_hud_message::_id_9102(var_0.type);
        }

        var_4 = tablelookup("mp/zombiesShotgunObjectiveData.csv", 0, var_0.type, 1);
      }

      var_3 setclientomnvar("ui_onevone_class_1", int(var_4));
    }

    level notify("sg_obj_start");

    if(isDefined(var_0._id_9A07) && var_0._id_9A07 != 0) {
      var_6 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting(var_0.type + "_timer");

      if(!isDefined(var_6)) {
        var_6 = var_0._id_9A07;
      }

      level thread sg_obj_timer(int(var_6));
    }

    if(isDefined(var_0.extra_func)) {
      [[var_0.extra_func]]();
    }

    level.objectivewaveactive = 1;
    level.zmbdisablechancetospawnpickup = 1;
    var_7 = wave_end_or_objective_end(var_0);
    _setomnvar("ui_zm_waypoint_ents_type", 0);
    level.zmbdisablechancetospawnpickup = 0;
    level.objectivewaveactive = 0;
    level.trucks_are_port_locked = 0;

    foreach(var_3 in level.players) {
      var_9 = tablelookup("mp/zombiesShotgunObjectiveData.csv", 0, "obj_ending", 1);
      var_3 setclientomnvar("ui_onevone_class_1", int(var_9));
    }

    level.objectivescompleted++;

    if(sg_is_escape_round()) {
      level thread outro_run();
      level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_objective_completed");
      var_11 = 1;

      foreach(var_3 in level.players) {
        [var_14, var_15, var_16, var_17] = var_3 getshatteredmapsequenceinfo();
        var_11 = var_11 && common_scripts\utility::_id_562E(var_15) && common_scripts\utility::_id_562E(var_16);
      }

      if(_id_0547::is_zm_shattered_thule_map() && var_11) {
        _id_0547::zm_util_run_outro("mp/mp_zom_dlc3_outro", 67.5, 0.5, 1, 0, "dig_outro_movie");
      }

      sg_end_game();
      return;
    }

    if(!isDefined(var_7) || !var_7) {
      sg_obj_round_fail_wrapper(var_0);
    } else {
      level.outro_targetname = undefined;
      level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_objective_completed");

      foreach(var_3 in level.players) {
        var_3 thread maps\mp\gametypes\_hud_message::_id_9102("zm_shattered_obj_complete");
      }

      maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::completed_an_objective();
      level.grant_new_weapons = 1;

      if(isDefined(var_0._id_94D6)) {
        thread[[var_0._id_94D6]]();
      }

      level notify("zmb_shotgun_gamemode_pausing");
      maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
      level thread delay_pause();

      if(_id_056D::_id_66D7() <= level._id_A980) {
        level._id_ABEC maps\mp\_utility::_id_5DC7();
        level._id_ABED maps\mp\_utility::_id_5DC7();
        level._id_AC12 maps\mp\_utility::_id_5DC7();
        level._id_A981 = level._id_A980;
      }

      var_21 = _id_0547::_id_408F().size;

      if(var_21 > 0) {
        level thread maps\mp\gametypes\zombies::_id_08B2((0, 0, 0), 1);
      }

      foreach(var_23 in _id_0547::_id_408F()) {
        if(common_scripts\utility::_id_562E(var_23.longdeath)) {
          continue;
        }
        var_23 suicide();
      }

      unlock_next_reciever();
      maps\mp\_utility::_id_2CED(7.25, maps\mp\zombies\shotgun\_wallbuys_shattered::give_wallbuy_materials);
      maps\mp\zombies\shotgun\_carepackage_shattered::start_care_package_reward_all();
      sg_end_round();
    }

    level notify("sg_obj_end");
  } else {}
}

delay_pause() {
  waitframe();
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
}

sg_obj_set_wave_endless(var_0) {
  level.zmb_is_endless_wave = 1;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();

  if(common_scripts\utility::_id_562E(var_0)) {
    level._id_3774[level.players.size][level._id_A980]["zombie_generic"] = 10;
    level._id_3774[level.players.size][level._id_A980]["zombie_berserker"] = 5;
    level._id_3774[level.players.size][level._id_A980]["zombie_exploder"] = 2;
    level._id_3774[level.players.size][level._id_A980]["zombie_heavy"] = 0;
  } else {
    level._id_3774[level.players.size][level._id_A980]["zombie_generic"] = 10;
    level._id_3774[level.players.size][level._id_A980]["zombie_berserker"] = 5;
    level._id_3774[level.players.size][level._id_A980]["zombie_exploder"] = 2;
    level._id_3774[level.players.size][level._id_A980]["zombie_heavy"] = 0;
  }
}

sg_obj_unset_wave_endless() {
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  level.zmb_is_endless_wave = 0;
}

sg_obj_round_fail_wrapper(var_0) {
  level.zmb_shattered_objectives_failed = 1;

  foreach(var_2 in level.players) {
    var_2 thread maps\mp\gametypes\_hud_message::_id_9102("zm_shattered_obj_failed");
  }

  if(isDefined(var_0.fail_func)) {
    [[var_0.fail_func]]();
  }

  level thread maps\mp\_utility::_id_6F74(::setplayerhasfailed);
  wait 3.5;

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_hide_hud", 0);
  }

  _id_0553::_id_AC1F("zombie_extraction_failed", undefined, 1);
}

setplayerhasfailed() {
  var_0 = self;
  var_0._id_480F = 1;
  wait 0.7;
  var_0 setclientomnvar("ui_hide_hud", 1);
  level thread maps\mp\_utility::_id_6F74(::run_outro_cinematic, undefined, level.outro_targetname);
}

wave_end_or_objective_end(var_0) {
  return level[[var_0.event_func]](var_0._id_502A);
}

get_rewards(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(level.zombies_shotgun_weapons_in_play[var_3])) {
      var_1 = common_scripts\utility::_id_0F73(var_1, level.zombies_shotgun_weapons_in_play[var_3]);
    }
  }

  return var_1;
}

get_reward(var_0) {
  if(var_0 == 0) {
    return 0;
  }

  if(var_0 <= 2) {
    return 1;
  }

  if(var_0 <= 6) {
    return 2;
  }

  if(var_0 <= 10) {
    return 3;
  }

  return 0;
}

sg_obj_splash_get_type_name_friendly(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "type_assassinate_common":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_ASSASSIN";
      break;
    case "type_escort":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_ESCORT";
      break;
    case "type_defense_common":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_DEFENSE";
      break;
    case "blimp_attack":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_BLIMP";
      break;
    case "air_attack":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_AIR";
      break;
    case "type_extermination_common":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_EXT";
      break;
    case "type_boss":
      if(_id_0547::is_zm_shattered_dnk_map()) {
        var_1 = &"ZOMBIE_DLC3_OBJ_NAME_DNK_BOSS";
      } else if(_id_0547::is_zm_shattered_windmill_map()) {
        var_1 = &"ZOMBIE_DLC3_OBJ_NAME_WINDMILL_BOSS";
      } else {
        var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_BOSS";
      }

      break;
    case "collect":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_COLLECT";
      break;
    case "type_escape_common":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_ESCAPE";
      break;
    case "type_keypoint_interact_repair_common":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_KPI_REPAIR";
      break;
    case "type_meuchler_common":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_MEUCHLER";
      break;
    case "keypoint_interact_build":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_KPI_BUILD";
      break;
    case "keypoint_interact_bomb":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_GEN_KPI_BOMB";
      break;
    case "visions":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_VISIONS";
      break;
    case "blood_plates":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_DIG_PLATES";
      break;
    case "boss_guardian":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_DIG_BOSS";
      break;
    case "altar_defense":
      var_1 = &"ZOMBIE_DLC3_OBJ_NAME_DIG_ALTAR";
      break;
  }

  if(isDefined(level.sg_get_level_obj_strings_func) && !isDefined(var_1)) {
    var_1 = [[level.sg_get_level_obj_strings_func]]("name", var_0);
  }

  if(!isDefined(var_1)) {
    var_1 = &"OBJECTIVE";
  }

  return var_1;
}

sg_obj_splash_get_type_desc_friendly(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "type_assassinate_common":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_ASSASSIN";
      break;
    case "type_escort":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_ESCORT";
      break;
    case "type_defense_common":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_DEFENSE";
      break;
    case "blimp_attack":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_BLIMP";
      break;
    case "air_attack":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_AIR";
      break;
    case "type_extermination_common":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_EXT";
      break;
    case "type_boss":
      if(_id_0547::is_zm_shattered_dnk_map()) {
        var_1 = &"ZOMBIE_DLC3_OBJ_DESC_DNK_BOSS";
      } else if(_id_0547::is_zm_shattered_windmill_map()) {
        var_1 = &"ZOMBIE_DLC3_OBJ_DESC_WINDMILL_BOSS";
      } else {
        var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_BOSS";
      }

      break;
    case "collect":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_COLLECT";
      break;
    case "type_escape_common":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_ESCAPE";
      break;
    case "type_keypoint_interact_repair_common":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_KPI_REPAIR";
      break;
    case "type_meuchler_common":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_MEUCHLER";
      break;
    case "keypoint_interact_build":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_KPI_BUILD";
      break;
    case "keypoint_interact_bomb":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_GEN_KPI_BOMB";
      break;
    case "visions":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_VISIONS";
      break;
    case "blood_plates":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_DIG_PLATES";
      break;
    case "boss_guardian":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_DIG_BOSS";
      break;
    case "altar_defense":
      var_1 = &"ZOMBIE_DLC3_OBJ_DESC_DIG_ALTAR";
      break;
  }

  if(!isDefined(var_1) && isDefined(level.sg_get_level_obj_strings_func)) {
    var_1 = [[level.sg_get_level_obj_strings_func]]("desc", var_0);
  }

  if(!isDefined(var_1)) {
    var_1 = &"Unknown Objective Type";
  }

  return var_1;
}

sg_obj_splash(var_0) {
  var_1 = self;
  wait 1;
  var_2 = 6;
  var_1 thread sg_obj_splash_title(var_0, var_2, 0, -1);
  var_1 thread sg_obj_splash_desc(var_0, var_2, 1, 0);
}

sg_obj_splash_title(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = common_scripts\utility::_id_40B5();

  if(isDefined(var_4.splashtitle)) {
    var_4 sg_obj_splash_clear_title();
  }

  var_4.splashtitle = var_4 maps\mp\gametypes\_hud_util::createfontstring("bigfixed", 1);
  var_4.splashtitle maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, -10);
  var_4.splashtitle.label = sg_obj_splash_get_type_name_friendly(var_0);
  var_4.splashtitle.alpha = 0;
  var_4.splashtitle.color = (1, 0, 0.07);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  wait(var_2);
  var_4.splashtitle sg_obj_splash_fade_in();
  wait(var_1 - var_3);
  var_4.splashtitle moveovertime(0.5);
  var_4.splashtitle._id_00C6 = "left_adjustable";
  var_4.splashtitle._id_01CA = "top_adjustable";
  var_4.splashtitle.aligny = "top";
  var_4.splashtitle.alignx = "left";
  var_4.splashtitle.x = var_5._id_01D2 * 0.042;
  var_4.splashtitle.y = var_5._id_00BD * 0.031;
  var_6 = 0.05;
  var_7 = 0.5;

  for(var_8 = 0; var_8 < var_7; var_8 = var_8 + var_6) {
    var_4.splashtitle.fontscale = var_4.splashtitle.fontscale - 0.03;
    wait(var_6);
  }

  level waittill("round complete");
  var_4 sg_obj_splash_clear_title();
}

sg_obj_splash_desc(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(isDefined(var_4.splashtitle)) {
    var_4 sg_obj_splash_clear_desc();
  }

  var_4.splashdesc = var_4 maps\mp\gametypes\_hud_util::createfontstring("default", 1);
  var_4.splashdesc maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, 10);
  var_4.splashdesc.label = sg_obj_splash_get_type_desc_friendly(var_0);
  var_4.splashdesc.alpha = 0;

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  wait(var_2);
  var_4.splashdesc sg_obj_splash_fade_in();
  wait(var_1 - var_3);
  wait(var_3);
  var_4.splashdesc sg_obj_splash_fade_out();
  var_4 sg_obj_splash_clear_desc();
}

sg_obj_splash_fade_in() {
  self endon("death");
  var_0 = 0.05;
  var_1 = 0.5;
  self.alpha = 1;

  for(var_2 = 0; var_2 < var_1; var_2 = var_2 + var_0) {
    self.alpha = clamp(var_2 / var_1 - 0.25, 0, 0.75);
    wait(var_0 / 2);
    self.alpha = var_2 / var_1;
    wait(var_0 / 2);
  }
}

sg_obj_splash_fade_out() {
  self endon("death");
  var_0 = 0.1;
  var_1 = 0.5;

  for(var_2 = var_1; var_2 > 0; var_2 = var_2 - var_0) {
    if(!isDefined(self)) {
      break;
    }

    self.alpha = clamp(var_2 / var_1 + 0.25, 0.25, 1);
    wait(var_0 / 2);
    self.alpha = var_2 / var_1;
    wait(var_0 / 2);
  }
}

sg_obj_splash_clear_title() {
  var_0 = self;

  if(isDefined(var_0.splashtitle)) {
    var_0.splashtitle maps\mp\gametypes\_hud_util::destroyelem();
  }
}

sg_obj_splash_clear_desc() {
  var_0 = self;

  if(isDefined(var_0.splashdesc)) {
    var_0.splashdesc maps\mp\gametypes\_hud_util::destroyelem();
  }
}

sg_obj_timer(var_0) {
  level endon("sg_obj_end");
  level.sg_obj_timer = var_0;

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_onevone_class_2", int(var_0));
  }

  sg_obj_timer_countdown();
  level notify("sg_obj_timeout");
}

sg_obj_timer_countdown() {
  level endon("sg_obj_end");

  for(;;) {
    var_0 = common_scripts\utility::_id_A70F(1, level, "sg_obj_update_timer");

    if(_id_0547::_id_5565(var_0[1], "timeout")) {
      level.sg_obj_timer--;
    } else if(_id_0547::_id_5565(var_0[1], "sg_obj_update_timer") && isDefined(var_0[2])) {
      level.sg_obj_timer = level.sg_obj_timer + var_0[2];
    }

    if(level.sg_obj_timer < 30) {
      foreach(var_2 in level.players) {
        if(isDefined(var_2.objtimerhud) && var_2.objtimerhud.color != (1, 0, 0)) {
          var_2.objtimerhud.color = (1, 0, 0);
        }
      }
    }

    if(level.sg_obj_timer <= 0) {
      break;
    }
  }
}

sg_obj_timer_ui(var_0) {
  var_1 = self;

  if(isDefined(var_1.objtimerhud)) {
    var_1 sg_obj_timer_ui_clear();
  }

  var_1.objtimerhud = var_1 maps\mp\gametypes\_hud_util::createfontstring("default", 1);
  var_1.objtimerhud maps\mp\gametypes\_hud_util::setpoint("LEFT", undefined, 20, 50);
  var_1.objtimerhud.label = &"Time Remaining: ";
  var_1.objtimerhud settenthstimer(level.sg_obj_timer);

  for(;;) {
    var_2 = level common_scripts\utility::waittill_any_return("sg_obj_end", "sg_obj_timeout", "sg_obj_remove_timer", "sg_obj_update_timer");

    if(var_2 == "sg_obj_update_timer") {
      var_1.objtimerhud settenthstimer(level.sg_obj_timer);
      continue;
    }

    break;
  }

  var_1.objtimerhud fadeovertime(1);
  var_1.objtimerhud.alpha = 0;
  wait 1;
  var_1 sg_obj_timer_ui_clear();
}

sg_obj_timer_ui_clear() {
  var_0 = self;

  if(isDefined(var_0.objtimerhud)) {
    var_0.objtimerhud maps\mp\gametypes\_hud_util::destroyelem();
  }
}

outro_run() {
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();

  foreach(var_1 in _id_0547::_id_408F()) {
    var_1 suicide();
  }
}

_id_902A(var_0) {
  if(isDefined(var_0.weaponlocktargettooclose)) {
    switch (var_0.weaponlocktargettooclose) {
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
  var_0 = 0;

  foreach(var_2 in _id_0547::_id_408F()) {
    if(_id_0547::_id_5565(var_2._id_0A4B, "zombie_sizzler")) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_2.isonfire)) {
      var_0++;
    }
  }

  if(var_0 < 4) {
    self.isonfire = 1;
    _id_0547::_id_A6F6();
    self _meth_8682(0, 100, 1, "none", 1);
  }
}

dirtspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_dirt");
  }
}

mudspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_mud");
  }
}

concretespawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_concrete");
  }
}

sandspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_sand");
  }
}

waterspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_water");
    thread zombiedripfx("zmb_spawn_water");
  }
}

zombiedripfx(var_0) {
  if(level._id_A980 >= 20) {
    return;
  }
  var_1 = "spawn_water_drip";

  if(isDefined(var_0)) {
    var_1 = var_0 + "_drip";
  }

  var_2 = ["J_Shoulder_RI", "J_Shoulder_LE", "J_Hip_LE", "J_Hip_RI", "J_Head"];

  foreach(var_5 in var_2) {
    if(isDefined(self gettagorigin(var_5))) {
      _id_0547::_id_74A5(common_scripts\utility::_id_44F5(var_1), self, var_5);
    }
  }

  zombiedripfxcleanup(var_2, var_1);
}

zombiedripfxcleanup(var_0, var_1) {
  self endon("death");

  while(isDefined(self) && isalive(self)) {
    wait 0.1;

    if(!isDefined(self._id_53D9) || !self._id_53D9) {
      break;
    }
  }

  wait(_randomfloatrange(5.0, 15.0));

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  foreach(var_3 in var_0) {
    if(isDefined(self gettagorigin(var_3))) {
      _id_0547::_id_9406(common_scripts\utility::_id_44F5(var_1), self, var_3);
    }
  }
}

zombiespawnfx(var_0) {
  if(level.zombiespawnfxcount >= 12) {
    return;
  }
  var_1 = _spawnfx(common_scripts\utility::_id_44F5(var_0), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  _triggerfx(var_1);
  level.zombiespawnfxcount++;
  common_scripts\utility::waittill_notify_or_timeout("death", 2.0);
  level.zombiespawnfxcount--;
  var_1 delete();
}

zmb_shattered_boss_nerfs(var_0, var_1, var_2) {
  var_3 = 4500;
  var_4 = 200;
  var_5 = 1500;
  var_0 = _id_0547::_id_AAF9(var_0);
  var_6 = 4500;
  var_7 = var_1;

  if(_id_0547::_id_5565(var_0, "p38_zm") && var_1 >= var_4) {
    var_1 = var_1 * 0.85;
  }

  if(_id_0547::_id_5565(var_0, "svt40_zm") && var_1 >= var_5) {
    var_1 = var_1 * 0.85;
  }

  if(_id_0547::_id_5565(var_0, "dp28_zm") && _id_0547::_id_5565(var_2, "MOD_EXPLOSIVE")) {
    var_1 = var_3;
  }

  if(_id_0547::_id_5565(var_0, "teslagun_zm_blood") && var_1 > var_3) {
    var_1 = var_3;
  }

  if(_id_0547::_id_5565(var_0, "teslagun_zm_death") && var_1 > var_3) {
    var_1 = var_3;
  }

  if(_id_0547::_id_5565(var_0, "teslagun_zm_moon") && var_1 > var_3) {
    var_1 = var_3;
  }

  if(_id_0547::_id_5565(var_0, "teslagun_zm_storm") && var_1 > var_3) {
    var_1 = var_3;
  }

  if(var_1 > var_6) {
    var_1 = var_1 * 0.8;
  }

  return int(var_1);
}

________the_classic________() {}

shotgun_classic_init() {
  var_0 = _getEnt("the_classic_jolt_volume", "targetname");

  for(;;) {
    level waittill("zombie_airdrop_inbound");
    var_0 thread shotgun_classic_listen_for_jolts();
  }
}

shotgun_classic_listen_for_jolts() {
  level endon("zombie_airdrop_inbound");
  level endon("zombie_airdrop_landed");
  level endon("classic_added_to_box");
  var_0 = 0;

  for(;;) {
    level waittill("spawned_money_share");

    foreach(var_2 in level._id_8AD2) {
      if(!self _meth_858B(var_2.origin)) {
        continue;
      }
      var_3 = var_2._id_0117;
      var_4 = var_3 getentitynumber();
      var_2 _id_0544::_id_8ADD(var_4, 0);
      var_2._id_6FD4 = 0;
      var_2._id_6FCB = 0;
      var_0++;
      thread shotgun_classic_jolt_drop_fx(self.origin);
    }

    if(var_0 >= 5) {
      shotgun_classic_add_classic_to_box();
    }
  }
}

shotgun_classic_jolt_drop_fx(var_0) {
  var_1 = _spawnfx(common_scripts\utility::_id_44F5("moneyCloud"), var_0);
  _triggerfx(var_1);
  wait 3;
  var_1 delete();
}

shotgun_classic_add_classic_to_box() {
  _iprintlnbold("Classic added to SMG box!");
  var_0 = common_scripts\utility::_id_46B7("the_classic_complete_fx_org", "targetname");

  foreach(var_2 in var_0) {
    thread shotgun_classic_jolt_drop_fx(var_2.origin);
  }

  common_scripts\utility::flag_set("shotgun_classic_add_to_box");
  level notify("classic_added_to_box");
}