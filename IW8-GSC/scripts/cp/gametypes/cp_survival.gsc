/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\gametypes\cp_survival.gsc
************************************************/

function main() {
  scripts\cp\cp_globallogic::init();
  thread onplayerconnect();
  level.skip_playerhudphoto = 1;
  level.disable_nvg = 1;
  scripts\cp\cp_music_and_dialog::init();
  level.playerent = &scripts\cp\cp_weapon::bomber_spawn_origin_array_init;
  scripts\cp\utility::coop_mode_enable(["loot_system"]);
  initdefaultsettings();
  scripts\cp\cp_weapon::weaponsinit();
  level.health_scalar = 1.5;
  scripts\cp\cp_outline::outline_init();
  setomnvar("ui_hide_nameplates_for_zero_health", 0);
  scripts\cp\survival\survival_loadout::init();
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  level thread scripts\cp\loot_system::init_loot();
  level thread scripts\cp\cp_interaction::coop_interaction_pregame();
  level thread scripts\cp\utility::global_physics_sound_monitor();
  level thread scripts\cp\zombies\zombieclientmatchdata::init();
  thread monitor_num_players();
  level.use_temp_bc = 1;
  create_player_threatbias_groups();

  if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    scripts\cp\pvpe\pvpe::init_pvpe();
  } else if(scripts\cp\pvpve\pvpve::pvpve_enabled()) {
    scripts\cp\pvpve\pvpve::init_pvpve();
  }

  scripts\cp\cp_globallogic::clearmatchhasmorethan1playervariablesonroundend();
}

function create_player_threatbias_groups() {
  createthreatbiasgroup("player1");
  createthreatbiasgroup("player2");
  createthreatbiasgroup("player3");
  createthreatbiasgroup("player4");
  createthreatbiasgroup("player1_enemy");
  createthreatbiasgroup("player2_enemy");
  createthreatbiasgroup("player3_enemy");
  createthreatbiasgroup("player4_enemy");
  setthreatbias("player1", "player1_enemy", 10000);
  setthreatbias("player2", "player2_enemy", 10000);
  setthreatbias("player3", "player3_enemy", 10000);
  setthreatbias("player4", "player4_enemy", 10000);
}

function initdefaultsettings() {
  scripts\engine\utility::flag_init("insta_kill");
  scripts\engine\utility::flag_init("introscreen_over");
  scripts\engine\utility::flag_init("infil_complete");
  scripts\engine\utility::flag_init("intro_gesture_done");
  scripts\engine\utility::flag_init("pre_game_over");
  scripts\engine\utility::flag_init("interactions_initialized");
  scripts\engine\utility::flag_init("zombie_drop_powerups");
  scripts\engine\utility::flag_init("init_interaction_done");
  scripts\engine\utility::flag_init("strike_init_done");
  scripts\engine\utility::flag_init("create_script_initialized");
  scripts\engine\utility::flag_init("ready_for_devgui");
  scripts\engine\utility::flag_init("stealth_enabled");
  scripts\engine\utility::flag_init("stealth_spotted");
  level.wave_num = 1;
  level.cycle_reward_scalar = 1;
  level.cash_scalar = 1;
  level.powers = [];
  level.overcook_func = [];
  level.hardcoremode = getdvarint("scr_aliens_hardcore");
  level.ricochetdamage = getdvarint("scr_aliens_ricochet");
  level.casualmode = getdvarint("scr_aliens_casual");
  level.default_weapon = "iw8_pi_decho_mp";
  setdvarifuninitialized("enable_segmented_health_regen", 0);
  level.usehealthpacks = getdvarint("enable_segmented_health_regen", 0);
  level.pap_max = 2;

  if(getdvarint("scr_old_cp_fall_damage", 0) <= 0) {
    setDvar("NKTQRKRMTS", 560);
    setDvar("LKMOLLSKKO", 561);
    setDvar("OMLLLQKQSR", 560);
    setDvar("LTMMLKRKTR", 561);
  }

  level.exploimpactmod = 0.1;
  level.shotgundamagemod = 0.1;
  level.armorpiercingmod = 1.5;
  level.armorpiercingmodks = 1.25;
  level.maxlogclients = 10;
  level.custom_giveloadout = &givedefaultloadout;
  level.move_speed_scale = &scripts\cp\survival\survival_loadout::updatemovespeedscale;
  level.getnodearrayfunction = &getnodearray;
  level.prematchfunc = &prematchfunc;
  level.callbackplayerdamage = &scripts\cp\cp_damage::callback_playerdamage;
  level.callbackplayerkilled = &callbackplayerkilled;
  level.onplayerdisconnect = &onplayerdisconnect;
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.onprecachegametype = &onprecachegametype;
  level.laststand_enter_gamemodespecificaction = &enter_laststand;
  level.enter_spectator_func = &enable_dogtag_revive;
  level.prespawnfromspectaorfunc = &prespawnfromspectatorfunc;
  level.laststand_exit_gamemodespecificaction = &exit_laststand_func;
  level.last_stand_hud_update = &last_stand_hud_update;
  level.getspawnpoint = &getspawnpoint;
  level.update_money_performance = &scripts\cp\cp_core_gamescore::update_money_earned_performance;
  level.active_volume_check = &scripts\cp\utility::is_in_active_volume;
  level.endgame_write_clientmatchdata_for_player_func = &endgame_clientmatchdata;
  level.hostmigrationend = &hostmigrationend;
  level.onhostmigration = &hostmigrationstart;
  level.custom_player_hotjoin_func = &scripts\cp\respawn\cp_respawn::hotjoin_via_ac130;
  level.game_mode_statstable = "cp/zombies/mode_string_tables/zombies_statstable.csv";
  level.game_mode_attachment_map = "cp/zombies/zombie_attachmentmap.csv";
  var_0 = getDvar("NSQLTTMRMP");
  level.power_up_table = "cp/zombies/" + var_0 + "_loot.csv";
}

function exit_laststand_func(var_0) {
  var_0 scripts\cp\cp_powers::restore_powers(var_0, var_0.pre_laststand_powers);
  var_0 setclientomnvar("zm_ui_player_in_laststand", 0);
  var_0 clearclienttriggeraudiozone(0.3);
  var_0 playlocalsound("deaths_door_out");
  var_0 stoplocalsound("deaths_door_in");

  if(isDefined(level.vision_set_override)) {
    thread reset_override_visionset(var_0);
  }

  var_1 = randomintrange(1, 5);
  var_2 = "zmb_revive_music_lr_0" + var_1;
  var_0 scripts\cp\utility::playlocalsound_safe(var_2);
  var_0 scripts\cp\utility::allow_player_ignore_me(0);

  if(scripts\cp\utility::try_start_driving_func() && !istrue(level.dogtag_revive)) {
    var_0 skydive_setbasejumpingstatus(0);
    var_0 skydive_setdeploymentstatus(0);
    return;
  }
}

function reset_override_visionset(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  wait var_0;

  if(isDefined(level.vision_set_override)) {
    level notify("vision_set_change_request", level.vision_set_override, self, 0.1);
    return;
  }
}

function onstartgametype() {
  scripts\cp\utility::set_segmented_health_regen_parameters(100, 100, 25, 2, 1, 0.05);
  scripts\cp\cp_persistence::register_eog_to_lb_playerdata_mapping();
  level thread scripts\cp\cp_interaction::init();
  scripts\cp\cp_analytics::initlevelvars();
  thread update_laststand_times();
  thread init_enemy_spawner();
  thread scripts\cp\cp_traversalassist::traversal_assist_init();
  level.canspawnitemname = &canspawnitemname;
  thread scripts\cp_mp\auto_ascender::init();
  thread scripts\cp_mp\ent_manager::init();

  if(level.ref_12376) {
    level scripts\cp\whizby::calloutmarkerping_init();
  }

  scripts\cp\utility\auto_ascender_ai::init();
  level.excludedattachments = [];

  if(!isDefined(level.normal_mode_activation_funcs)) {
    level.normal_mode_activation_funcs = [];
  }

  if(!isDefined(level.special_mode_activation_funcs)) {
    level.special_mode_activation_funcs = [];
  }

  if(!isDefined(level.pentskipfov)) {
    level.pentskipfov = [];
  }

  if(!isDefined(level.pentparams)) {
    level.pentparams = [];
  }

  level.spawnloopupdatefunc = &scripts\cp\cp_modular_spawning::update_spawn_data_on_death;
  scripts\cp\cp_persistence::rank_init();
  thread handlenondeterministicentities();
  thread checkpoint_revive();

  if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    scripts\cp\pvpe\pvpe::initialize_player_team_slot_assignment();
  } else if(scripts\cp\pvpve\pvpve::pvpve_enabled()) {
    scripts\cp\pvpve\pvpve::initialize_player_team_slot_assignment();
  }

  scripts\cp\cp_modular_spawning::init_modular_spawning();
  thread scripts\cp\cp_outofbounds::initoob();

  if(level.gametype == "cp_survival") {
    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      level.players[var_0] setclientomnvar("ui_session_state", "spectator");
    }

    return;
  }
}

function init_enemy_spawner() {
  scripts\cp\cp_spawner_scoring::spawner_scoring_init();
}

function onprecachegametype() {
  level._effect["dogtag_pickup"] = loadfx("vfx/iw7/core/zombie/vfx_zom_souvenir_pickup.vfx");
  level._effect["vfx_br_infil_cloud_scroll"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_scroll.vfx");
  level._effect["vfx_br_infil_jump_smoke_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_02"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx");
  level._effect["vfx_br_infil_omni_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_omni_light.vfx");
  level._effect["vfx_br_infil_spot_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_spot_light.vfx");
  precachempanim("mp_dogtag_spin");
  scripts\cp\pvpe\pvpe::precache_pvpe_vfx();
}

function handlenondeterministicentities() {
  level endon("game_ended");
  wait 5;
  level notify("spawn_nondeterministic_entities");

  if(isDefined(level.post_nondeterministic_func)) {
    level thread[[level.post_nondeterministic_func]]();
    return;
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {
      var_0 scripts\cp\cp_analytics::on_player_connect();

      if(isDefined(var_0.connecttime)) {
        var_0.connect_time = var_0.connecttime;
      } else {
        var_0.connect_time = gettime();
      }

      var_0.xpscale = getdvarint("MSTMORLPKN");
      var_0.weaponxpscale = getdvarint("NNKLRNNSOP");

      if(var_0 scripts\cp\utility::rankingenabled()) {
        var_1 = getdvarint("LTSPPRQSMO");
        var_2 = getdvarint("NSRPSMKOMP");
        var_3 = var_0 getprivatepartysize() > 1;

        if(isDefined(var_1)) {
          if(var_3 && var_1 > 1) {
            var_0.weaponxpscale = var_1;
          }
        }

        if(isDefined(var_2)) {
          if(var_3 && var_2 > 1) {
            var_0.xpscale = var_2;
          }
        }
      }

      if(istrue(var_0 getplayerdata("cp", "tacOpsAchievements", "LANDLORD")) && istrue(var_0 getplayerdata("cp", "tacOpsAchievements", "ARMED")) && istrue(var_0 getplayerdata("cp", "tacOpsAchievements", "SMUGGLED")) && istrue(var_0 getplayerdata("cp", "tacOpsAchievements", "LAUNDERED"))) {
        var_0 thread scripts\cp_mp\xmike109::screenent_d("all_operations");
      }

      var_0 thread scripts\cp\cp_globallogic::player_init_health_regen();
      var_0 scripts\cp\cp_persistence::session_stats_init();
      var_0.num_of_plays = [];
      var_0.nextcasheffecttime = 0;
      var_0.total_currency_earned = 0;
      var_0.can_give_revive_xp = 1;
      var_0.pap = [];
      var_0.powerupicons = [];
      var_0.powers = [];
      var_0.powers_active = [];
      var_0.disabled_interactions = [];
      var_0.onkillweaponpassives = [];
      var_0.onuseweaponpassives = [];
      var_0.ondamageweaponpassives = [];
      var_0.disabledteleportation = 0;
      var_0.disabledinteractions = 0;
      var_0.power_cooldowns = 0;
      var_0.tickets_earned = 0;
      var_0.time_to_give_next_tickets = gettime();
      var_0.self_revives_purchased = 0;
      var_0.max_self_revive_machine_use = 3;
      var_0.cash_scalar = 1;
      var_0.recentkillcount = 0;
      var_0.enabledignoreme = 0;
      var_0.infiniteammocounter = 0;
      var_0.awarenessadjustment = 0;
      var_0.move_door_to_pos = 0;
      var_0 scripts\cp\utility::allow_player_teleport(0);
      var_0.achievement_registration_func = &scripts\cp\cp_achievement::register_default_achievements;
      var_0 scripts\cp\cp_achievement::switchminimapid(var_0);
      var_0.ref_136a1 = var_0.connect_time;
      var_0 scripts\cp\cp_mapselect::set_uav_radarstrength(var_0);
      var_0 scripts\cp\cp_persistence::lb_player_update_stat("waveNum", level.wave_num, 1);
      var_0 scripts\cp\cp_wall_buys::setup_player_weapon_models(var_0);
      var_0 scripts\cp\cp_persistence::player_persistence_init();
      var_0 thread scripts\cp\cp_analytics::init_weapon_and_player_analytics(var_0);

      if(isDefined(level.playerclearstreamhintorigin)) {
        var_0 thread[[level.playerclearstreamhintorigin]]();
      }

      if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
        var_0 scripts\cp\pvpe\pvpe::assign_pvpe_team_and_slot_number(var_0);
        var_0 scripts\cp\pvpe\pvpe::terrorist_self_revive_time_override(var_0);
      }

      var_0.gameskill = scripts\cp\cp_gameskill::get_gameskill();
      var_0 scripts\cp\cp_gameskill::set_difficulty_from_locked_settings();
      thread strike_player_connect_black_screen();
      var_0.timeplayed = [];

      foreach(var_5 in level.teamnamelist) {
        var_0.timeplayed[var_5] = 0;
      }

      var_0.timeplayed["total"] = 0;
      var_0.timeplayed["missionTeam"] = 0;
      var_0.timeplayed["other"] = 0;
      var_0.timeplayed["timeDead"] = 0;

      if(level.ref_12376) {
        var_0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();
      }

      if(scripts\engine\utility::flag("introscreen_over")) {
        if(isDefined(level.custom_player_hotjoin_func)) {
          var_0 thread[[level.custom_player_hotjoin_func]]();
        }

        if(isDefined(level.setobjectivelocations)) {
          var_0 thread[[level.setobjectivelocations]]();
        }
      }

      if(isDefined(level.custom_onplayerconnect_func)) {
        [[level.custom_onplayerconnect_func]](var_0);
      }

      if(!isDefined(level.kick_player_queue)) {
        thread kick_player_queue_loop();
      }

      thread kick_for_inactivity(var_0);
      thread mission_jumpto_debug();
    }
  }
}

function mission_jumpto_debug() {
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "mission_jump") {
      var_2 = getDvar("NSQLTTMRMP");
      var_3 = "cp/" + var_2 + "_objectives.csv";
      var_4 = tablelookup(var_3, 0, var_1, 1);
      var_5 = var_2 + "_start_obj";
      setdvarifuninitialized(var_5, var_4);
      setDvar(var_5, var_4);
      scripts\cp\cp_endgame::restart_map();
    }
  }
}

function team_slot_assignment_available_from_player_disconnect() {
  return level.disconnect_player_team_slot_assignment.size > 0;
}

function get_team_slot_assignment_from_player_disconnect() {
  var_0 = level.disconnect_player_team_slot_assignment[0];
  level.disconnect_player_team_slot_assignment = scripts\engine\utility::array_remove(level.disconnect_player_team_slot_assignment, var_0);
  return var_0;
}

function player_hotjoin() {
  self endon("disconnect");
  self notify("intro_done");
  self notify("stop_intro");
  self notify("player_hotjoin");
  self endon("player_hotjoin");
  level endon("game_ended");
  self waittill("spawned");
  thread hotjoin_protection();
  self.pers["hotjoined"] = 1;

  if(isDefined(level.wave_num)) {
    self.wave_num_when_joined = level.wave_num;
  }

  var_0 = getDvar("NSQLTTMRMP");

  if(isDefined(self.introscreen_overlay)) {
    self.introscreen_overlay.alpha = 1;
    wait 3;
    self.introscreen_overlay fadeovertime(3);
    self.introscreen_overlay.alpha = 0;
    wait 3;

    if(isDefined(self.introscreen_overlay)) {
      self.introscreen_overlay destroy();
    }
  }

  while(!istrue(self.photosetup)) {
    wait 1;
  }

  self setclientomnvar("ui_hide_hud", 0);
}

function hotjoin_protection() {
  self notify("hotjoin_protection");
  self endon("hotjoin_protection");
  self endon("disconnect");
  scripts\cp\utility::allow_player_ignore_me(1);
  self.ability_invulnerable = 1;
  wait 8;
  scripts\cp\utility::allow_player_ignore_me(0);
  self.ability_invulnerable = undefined;
}

function onspawnplayer(var_0) {
  self.fireshield = 0;
  self.isreviving = 0;
  self.isrepairing = 0;
  self.iscarrying = 0;
  self.isboosted = undefined;
  self.ishealthboosted = undefined;
  self.burning = undefined;
  self.shocked = undefined;
  self.player_action_disabled = undefined;
  self.no_team_outlines = 0;
  self.no_outline = 0;
  self.disabledteleportation = 0;
  self.disabledinteractions = 0;
  self.can_teleport = 1;

  if(!isDefined(self.enabledignoreme)) {
    self.enabledignoreme = 0;
  }

  if(!isDefined(self.ignoreme)) {
    self.ignoreme = 0;
  }

  self.hide_tutorial = 1;
  self.flung = undefined;
  self.is_holding_deployable = 0;
  self.has_special_weapon = 0;
  self.lastkilltime = gettime();
  self.lastmultikilltime = gettime();
  scripts\common\input_allow::clear_all_allow_info();
  scripts\cp_mp\utility\damage_utility::cleardamagemodifiers();
  thread scripts\cp\perks\cp_perks::watchcombatspeedscaler();

  if(isDefined(level.custom_onspawnplayer_func)) {
    self[[level.custom_onspawnplayer_func]]();
  }

  if(istrue(level.ref_121c8)) {
    self getclientomnvar();
  } else {
    self weaponswitchbuttonPressed();
  }

  if(istrue(level.ref_121c9)) {
    self skydive_cutautodeployon();
  } else {
    self skydive_cutautodeployoff();
  }

  scripts\cp\cp_globallogic::player_init_invulnerability();
  scripts\cp\cp_globallogic::player_init_damageshield();
  var_1 = get_starting_currency(self);
  thread scripts\cp\cp_persistence::wait_to_set_player_currency(var_1);
  set_player_max_currency(999999);
  thread scripts\cp\cp_damage::core_health_regen();
  thread scripts\cp\cp_hud_util::zom_player_health_overlay_watcher();
  thread add_player_to_threatbias_group();
  thread scripts\cp\cp_weapon::watchweaponusage();
  thread scripts\cp\cp_weapon::watchweaponchange();
  thread scripts\cp\cp_weapon::watchweaponfired();
  thread scripts\cp\coop_personal_ents::assignpersonalmodelents(self);
  thread scripts\cp\coop_personal_ents::movepentstostructs(self);
  thread give_skillpoints_at_start();

  if(allow_nvg()) {
    thread scripts\cp\equipment\nvg::runnvg();
  }

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  scripts\cp\utility::force_usability_enabled();

  if(scripts\cp\pvpe\pvpe::pvpe_enabled() && scripts\cp\pvpe\pvpe::player_is_terrorist(self)) {
    scripts\cp\pvpe\pvpe::on_spawn_terrorist_player(self);
  }

  self setclientomnvar("ui_hide_minimap", 1);
}

function add_player_to_threatbias_group() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(self == level.players[var_0]) {
      var_1 = var_0 + 1;

      if(var_1 == 5) {
        return;
      }

      self setthreatbiasgroup("player" + var_1);
    }
  }
}

function get_starting_currency(var_0) {
  var_1 = var_0.starting_currency_after_revived_from_spectator;

  if(isDefined(var_1)) {
    var_0.starting_currency_after_revived_from_spectator = undefined;
    return var_1;
  }

  return scripts\cp\cp_persistence::get_starting_currency();
}

function set_player_max_currency(var_0) {
  var_0 = int(var_0);
  self.maxcurrency = var_0;
}

function prespawnfromspectatorfunc(var_0) {
  var_0.starting_currency_after_revived_from_spectator = var_0 scripts\cp\cp_persistence::get_player_currency();
  revivefromspectatorweaponsetup(var_0);
  set_spawn_loc(var_0);
}

function revivefromspectatorweaponsetup(var_0) {
  var_1 = spawnStruct();
  var_1.copy_fullweaponlist = var_0.copy_fullweaponlist;
  var_1.copy_weapon_current = var_0.copy_weapon_current;
  var_1.copy_weapon_ammo_clip = var_0.copy_weapon_ammo_clip;
  var_1.copy_weapon_ammo_stock = var_0.copy_weapon_ammo_stock;

  if(isDefined(var_0.saved_last_stand_pistol)) {
    var_1.last_stand_pistol = var_0.saved_last_stand_pistol;
    var_0.saved_last_stand_pistol = undefined;
  } else {
    var_1.last_stand_pistol = var_0.last_stand_pistol;
  }

  var_1.weapon_levels = var_0.copy_weapon_level;

  if(isDefined(var_0.current_crafted_inventory)) {
    var_1.current_crafted_inventory = var_0.current_crafted_inventory;
    var_0.current_crafted_inventory = undefined;
  }

  var_1.copy_all_powers = var_0.pre_laststand_powers;
  var_1.copy_special_ammo_type = var_0.special_ammo_type;
  var_0.weaponlist = var_1;
}

function restore_player_weapons_after_bleedout(var_0) {
  var_0 notify("weapon_purchased");
  var_1 = var_0.weaponlist;
  var_0 takeallweapons();
  var_0.copy_fullweaponlist = var_1.copy_fullweaponlist;
  var_0.copy_weapon_current = var_1.copy_weapon_current;
  var_0.copy_weapon_ammo_clip = var_1.copy_weapon_ammo_clip;
  var_0.copy_weapon_ammo_stock = var_1.copy_weapon_ammo_stock;
  var_0.copy_all_powers = var_1.copy_all_powers;
  var_0.copy_weapon_level = var_1.weapon_levels;
  var_0 scripts\cp\utility::restore_primary_weapons_only();
  var_0 scripts\cp\utility::restore_super_weapon();
  var_0 scripts\cp\cp_powers::restore_powers(var_0, var_0.copy_all_powers);

  if(isDefined(var_1.current_crafted_inventory)) {
    level thread[[var_1.current_crafted_inventory.restore_func]](undefined, var_0);
  }

  var_0.special_ammo_type = var_1.copy_special_ammo_type;
  var_0.have_things_in_lost_and_found = 0;
  var_0.last_stand_pistol = var_1.last_stand_pistol;
  var_0.weaponlist = undefined;
}

function set_spawn_loc(var_0) {
  var_1 = getplayerrespawnloc(var_0);
  var_0.forcespawnorigin = var_1.origin;
  var_0.forcespawnangles = var_1.angles;

  if(isDefined(var_0.respawn_forcespawnorigin)) {
    var_0.forcespawnorigin = var_0.respawn_forcespawnorigin;
  }

  if(isDefined(var_0.respawn_forcespawnangles)) {
    var_0.forcespawnangles = var_0.respawn_forcespawnangles;
    return;
  }
}

function getplayerrespawnloc(var_0) {
  if(isDefined(level.force_respawn_location)) {
    return [[level.force_respawn_location]](var_0);
  }

  if(!isDefined(level.active_player_respawn_locs) || level.active_player_respawn_locs.size == 0 || level.players.size == 0) {
    return [[level.getspawnpoint]]();
  }

  if(isDefined(level.respawn_loc_override_func)) {
    return [[level.respawn_loc_override_func]](var_0);
  }

  var_1 = get_available_players(var_0);
  var_2 = get_available_respawn_locs(var_1);

  if(var_2.size == 0) {
    return get_respawn_loc_near_team_center(var_0, var_1);
  }

  if(var_2.size == 1) {
    return var_2[0];
  }

  return get_respawn_loc_rated(var_0, var_1, var_2);
}

function get_available_players(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }

    var_1 = var_3;
  }

  return var_1;
}

function get_available_respawn_locs(var_0) {
  var_1 = [];

  foreach(var_3 in level.active_player_respawn_locs) {
    if(!canspawn(var_3.origin)) {
      continue;
    }

    if(positionwouldtelefrag(var_3.origin)) {
      continue;
    }

    if(is_respawn_loc_near_available_players(var_3, var_0)) {
      continue;
    }

    if(is_respawn_loc_near_alive_enemies(var_3)) {
      continue;
    }

    var_1 = var_3;
  }

  return var_1;
}

function is_respawn_loc_near_available_players(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(distancesquared(var_3.origin, var_0.origin) < 250000) {
      return true;
    }
  }

  return false;
}

function is_respawn_loc_near_alive_enemies(var_0) {
  var_1 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(var_3 in var_1) {
    if(distancesquared(var_3.origin, var_0.origin) < 250000) {
      return true;
    }
  }

  return false;
}

function get_respawn_loc_near_team_center(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  foreach(var_7 in var_1) {
    var_2 += var_7.origin[0];
    var_3 += var_7.origin[1];
    var_4 += var_7.origin[2];
    var_5++;
  }

  var_9 = (var_2 / var_5, var_3 / var_5, var_4 / var_5);
  var_10 = sortbydistance(level.active_player_respawn_locs, var_9);
  return var_10[0];
}

function get_respawn_loc_rated(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_0.size == 0, 1, var_0.size);
  var_3 = level.spawned_enemies.size / var_2;
  var_4 = var_3 * 2;
  var_5 = -99999999;
  var_6 = undefined;

  foreach(var_8 in var_1) {
    var_9 = 0;

    foreach(var_11 in var_0) {
      if(var_11 == self) {
        continue;
      }

      if(!isalive(var_11)) {
        continue;
      }

      if(istrue(var_11.inlaststand)) {
        var_9 -= distancesquared(var_11.origin, var_8.origin) * var_4 * 2;
        continue;
      }

      var_9 -= distancesquared(var_11.origin, var_8.origin) * var_4;
    }

    foreach(var_14 in level.spawned_enemies) {
      var_9 += distancesquared(var_14.origin, var_8.origin);
    }

    var_9 /= 1000000;

    if(var_9 > var_5) {
      var_5 = var_9;
      var_6 = var_8;
    }
  }

  return var_6;
}

function prematchfunc() {
  var_0 = 0;

  if(var_0 > 0) {
    var_1 = wait_for_first_player_connect(level);
    wait var_0 - 3;

    if(isDefined(level.postintroscreenfunc)) {
      [[level.postintroscreenfunc]]();
    }

    scripts\engine\utility::flag_set("introscreen_over");
    level.introscreen_done = 1;
  } else {
    wait 2;

    if(scripts\engine\utility::flag("infil_complete")) {
      wait 2;
    }

    level.introscreen_done = 1;
    scripts\engine\utility::flag_set("introscreen_over");
  }

  if(istrue(level.intermission)) {
    return;
  }
}

function show_introscreen_text() {
  var_0 = getDvar("NSQLTTMRMP");
  var_1 = getDvar(var_0 + "_start_obj", "");
  var_2 = "cp/" + var_0 + "_objectives.csv";
  var_3 = int(tablelookup(var_2, 1, var_1, 0));

  if(isDefined(var_1) && var_1 != "") {
    self setclientomnvar("ui_hide_hud", 0);
    self setclientomnvar("ui_chyron_mission_index", var_3);
    self setclientomnvar("ui_chyron_on", 1);
    return;
  }
}

function wait_for_first_player_connect() {
  var_0 = undefined;

  if(level.players.size == 0) {
    level waittill("connected", var_0);
  } else {
    var_0 = level.players[0];
  }

  return var_0;
}

function strike_player_connect_black_screen() {
  if(isDefined(level.strike_player_connect_black_screen_fn)) {
    [[level.strike_player_connect_black_screen_fn]](self);
    return;
  }

  default_strike_player_connect_black_screen(self);
}

function default_strike_player_connect_black_screen(var_0) {
  var_0 endon("disconnect");
  var_0 endon("stop_intro");
  var_0 setclientomnvar("ui_hide_hud", 1);
  var_0.introscreen_overlay = newclienthudelem(self);
  var_0.introscreen_overlay.x = 0;
  var_0.introscreen_overlay.y = 0;
  var_0.introscreen_overlay setshader("black", 640, 480);
  var_0.introscreen_overlay.alignx = "left";
  var_0.introscreen_overlay.aligny = "top";
  var_0.introscreen_overlay.sort = 1;
  var_0.introscreen_overlay.horzalign = "fullscreen";
  var_0.introscreen_overlay.vertalign = "fullscreen";
  var_0.introscreen_overlay.alpha = 1;
  var_0.introscreen_overlay.foreground = 1;
  var_0 waittill("spawned");
  var_0 playerhide();
  var_0 disableweapons();
  var_0 scripts\cp\utility::freezecontrolswrapper(1);

  if(istrue(var_0.unset_relic_oneclip)) {
    show_introscreen_text(var_0);

    if(scripts\engine\utility::flag_exist("strike_init_done")) {
      scripts\engine\utility::flag_wait("strike_init_done");
    }

    if(!scripts\engine\utility::flag("introscreen_over")) {
      scripts\engine\utility::flag_wait("introscreen_over");
    }

    wait 1;
    var_0 setclientomnvar("ui_hide_hud", 1);
    var_0 setclientomnvar("ui_chyron_on", 0);
    var_0 setclientomnvar("ui_chyron_mission_index", 0);
    var_0.introscreen_overlay fadeovertime(2);
    var_0.introscreen_overlay.alpha = 0.5;
    wait 1;
    var_0 scripts\cp\utility::freezecontrolswrapper(0);
    var_0 enableweapons();
    var_0.introscreen_overlay destroy();
    var_0 setclientomnvar("ui_hide_hud", 0);
    scripts\cp\cp_globallogic::refreshuimatchinprogressomnvarvalue();
  } else {
    if(isDefined(level.ref_1247c)) {
      var_0 thread[[level.ref_1247c]]();
    }

    show_introscreen_text(var_0);

    if(scripts\engine\utility::flag_exist("strike_init_done")) {
      scripts\engine\utility::flag_wait("strike_init_done");
    }

    if(!scripts\engine\utility::flag("introscreen_over")) {
      scripts\engine\utility::flag_wait("introscreen_over");
    }

    wait 6;
    var_0 setclientomnvar("ui_hide_hud", 1);
    var_0 setclientomnvar("ui_chyron_on", 0);
    var_0 setclientomnvar("ui_chyron_mission_index", 0);
    var_0 notify("open_loadout_menu");
    var_0 waittill("loadout_given");
    var_0.introscreen_overlay fadeovertime(2);
    var_0.introscreen_overlay.alpha = 0.5;
    wait 1;
    var_0 scripts\cp\utility::freezecontrolswrapper(0);
    var_0 enableweapons();
    var_0.introscreen_overlay destroy();
    var_0 setclientomnvar("ui_hide_hud", 0);
    scripts\cp\cp_globallogic::refreshuimatchinprogressomnvarvalue();
  }

  var_0 playershow();
}

function playerinfildisabled(var_0) {
  return istrue(var_0.infil_disabled);
}

function callbackplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  [[level.callbackplayerlaststand]](var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9);
}

function precachelb() {
  var_0 = " LB_" + getDvar("NSQLTTMRMP");

  if(scripts\cp\utility::isplayingsolo()) {
    var_0 += "_SOLO";
  } else {
    var_0 += "_COOP";
  }

  precacheleaderboards(var_0);
}

function enter_laststand(var_0, var_1) {
  var_0 scripts\cp\cp_persistence::eog_player_update_stat("downs", 1);
  var_0 scripts\cp\cp_analytics::log_event("dropped_to_last_stand", 1, [var_0.clientid], [var_0.clientid], [var_0.clientid]);
  var_0.pre_arcade_game_weapon = undefined;
  var_0.pre_arcade_game_weapon_clip = undefined;
  var_0.pre_arcade_game_weapon_stock = undefined;
  var_0.former_mule_weapon = undefined;
  var_0.pre_laststand_powers = var_0 scripts\cp\cp_powers::get_info_for_player_powers(var_0);
  var_0 scripts\cp\cp_powers::clearpowers();
  var_2 = var_0 getcurrentweapon();
  var_3 = getweaponbasename(var_2);
  var_4 = var_0 getcurrentweaponclipammo();

  if(!isDefined(var_0.downsperweaponlog[var_3])) {
    var_0.downsperweaponlog[var_3] = 1;
  } else {
    var_0.downsperweaponlog[var_3]++;
  }

  var_0 clearclienttriggeraudiozone(0);

  if(!self issplitscreenplayer()) {
    var_0 setclienttriggeraudiozonepartialwithfade("last_stand_cp", 0.02, "mix", "reverb", "filter");
  }

  var_0.have_self_revive = var_0 scripts\cp\utility::has_auto_revive();

  if(var_0.have_self_revive) {
    var_5 = scripts\cp\utility::isplayingsolo() || level.only_one_player;
    var_0 notify("player_has_self_revive", var_5);
  }

  if(isDefined(var_0.mule_weapon) && !istrue(var_0.playing_ghosts_n_skulls)) {
    var_0.former_mule_weapon = var_0.mule_weapon;
  } else {
    var_0.former_mule_weapon = undefined;
  }

  var_0 scripts\cp\zombies\zombieclientmatchdata::logplayerdeath();
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 setclientomnvar("zm_ui_player_in_laststand", 1);

  if(scripts\cp\pvpe\pvpe::player_is_terrorist(var_0)) {
    var_0 thread scripts\cp\pvpe\pvpe::terrorist_enter_laststand(var_0, var_1);
    return;
  }
}

function updaterecentkills(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.recentkillcount++;
  var_2 = getweaponbasename(var_1);

  if(!isDefined(self.killsperweaponlog[var_2])) {
    self.killsperweaponlog[var_2] = 1;
  } else {
    self.killsperweaponlog[var_2]++;
  }

  if(!isDefined(self.recentkillsperweapon)) {
    self.recentkillsperweapon = [];
  }

  if(!isDefined(self.recentkillsperweapon[var_1])) {
    self.recentkillsperweapon[var_1] = 1;
  } else {
    self.recentkillsperweapon[var_1]++;
  }

  var_3 = scripts\cp\utility::getequipmenttype(var_1);
  wait 1.25;
  self.recentkillcount = 0;
  self.recentkillsperweapon = undefined;
}

function onplayerdisconnect(var_0, var_1) {
  var_0 setplayerdata("cp", "CPSession", "subParty", -1);
  scripts\cp\cp_persistence::eog_update_on_player_disconnect(var_0);
}

function endgame_clientmatchdata(var_0, var_1) {}

function hostmigrationstart() {
  var_0 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(var_2 in var_0) {
    if(istrue(var_2.scripted_mode)) {
      var_2.died_poorly = 1;
      var_2 suicide();
      continue;
    }

    if(istrue(var_2.ignoreme)) {
      var_2.died_poorly = 1;
      var_2 suicide();
      continue;
    }

    if(istrue(var_2.ignoreall)) {
      var_2.died_poorly = 1;
      var_2 suicide();
      continue;
    }

    if(!istrue(var_2.entered_playspace)) {
      var_2.died_poorly = 1;
      var_2 suicide();
      continue;
    }

    var_2.scripted_mode = 1;
    var_2 scragentsetgoalpos(var_2.origin);
    var_2.ignoreme = 1;
    var_2.ignoreall = 1;
  }
}

function hostmigrationend() {
  var_0 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(var_2 in var_0) {
    var_2.scripted_mode = 0;
    var_2.ignoreme = 0;
    var_2.ignoreall = 0;
  }

  if(isDefined(level.customhostmigrationend)) {
    level thread[[level.customhostmigrationend]]();
    return;
  }
}

function kick_for_inactivity(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = 0;
  var_2 = gettime();
  var_3 = level.onlinegame && !getdvarint("LSTLQTSSRM");

  if(!var_3) {
    return;
  }

  thread check_for_move_change();
  thread check_for_movement();
  var_0 notifyonplayercommand("inputReceived", "+speed_throw");
  var_0 notifyonplayercommand("inputReceived", "+stance");
  var_0 notifyonplayercommand("inputReceived", "+goStand");
  var_0 notifyonplayercommand("inputReceived", "+usereload");
  var_0 notifyonplayercommand("inputReceived", "+activate");
  var_0 notifyonplayercommand("inputReceived", "+melee_zoom");
  var_0 notifyonplayercommand("inputReceived", "+breath_sprint");
  var_0 notifyonplayercommand("inputReceived", "+attack");
  var_0 notifyonplayercommand("inputReceived", "+frag");
  var_0 notifyonplayercommand("inputReceived", "+smoke");
  var_4 = 120;
  var_5 = 0.1;

  for(;;) {
    var_6 = scripts\engine\utility::ref_143c0(var_5, "inputReceived", "currency_earned");

    if(var_6 != "timeout") {
      var_4 = 120;
      var_1 = 1;
      continue;
    }

    if(!istrue(var_0.in_afterlife_arcade) && !istrue(var_0.inlaststand)) {
      var_4 -= var_5;
    }

    if(var_4 < 0) {
      if(var_1) {
        var_1 = 0;
        continue;
      }

      add_to_kick_queue(var_0);
      LOC_00000152:
    }
    LOC_00000152:
  }
}

function check_for_movement() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = self getnormalizedmovement();
  var_1 = gettime();

  for(;;) {
    wait 0.2;
    var_2 = self getnormalizedmovement();

    if(var_2[0] == var_0[0] && var_2[1] == var_0[1]) {
      if(gettime() - var_1 > 90000) {
        add_to_kick_queue(self);
      }

      continue;
    }

    self notify("inputReceived");
    return;
  }
}

function add_to_kick_queue(var_0) {
  if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    return;
  }

  if(istrue(var_0.start_anim_train_scene)) {
    return;
  }

  if(!scripts\engine\utility::array_contains(level.kick_player_queue, var_0)) {
    level.kick_player_queue = scripts\engine\utility::array_add_safe(level.kick_player_queue, var_0);
    return;
  }
}

function kick_player_queue_loop() {
  level endon("game_ended");
  level.kick_player_queue = [];

  for(;;) {
    if(level.kick_player_queue.size > 0) {
      foreach(var_1 in level.kick_player_queue) {
        if(!isDefined(var_1)) {
          continue;
        }

        thread kill_off_non_essential_ai(var_1);
      }

      level.kick_player_queue = [];
    }

    wait 0.1;
  }
}

function kill_off_non_essential_ai(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = 10;

  if(istrue(var_0.clear_up_objective_after_delay)) {
    return;
  }

  var_0.clear_up_objective_after_delay = 1;
  var_0 sethudtutorialmessage(&"COOP_GAME_PLAY/KICK_FOR_INACTIVITY");
  var_0 setclientomnvar("ui_kick_warning", 1);
  var_2 = var_0 scripts\engine\utility::waittill_any_in_array_or_timeout(["inputReceived"], var_1);
  var_0 clearhudtutorialmessage();
  var_0 setclientomnvar("ui_kick_warning", 0);
  var_0.clear_up_objective_after_delay = undefined;

  if(var_2 == "timeout") {
    if(scripts\cp\utility::questtimeradd() == 1) {
      level thread[[level.endgame]]("axis", level.end_game_string_index["fail"]);
      return;
    }

    kick(var_0 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE");
    return;
  }
}

function check_for_move_change() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("done_inactivity_check");

  while(!isDefined(self.model)) {
    wait 0.1;
  }

  var_0 = 1;
  var_1 = var_0;
  var_2 = var_0;

  for(;;) {
    var_3 = self getnormalizedmovement();
    var_1 = get_move_direction_from_vectors(var_3);

    if(var_2 != var_1) {
      var_2 = var_1;
      self notify("inputReceived");
    }

    wait 0.1;
  }
}

function get_move_direction_from_vectors(var_0) {
  var_1 = 1;
  var_2 = 2;
  var_3 = 3;
  var_4 = 4;
  var_5 = 5;
  var_6 = 6;
  var_7 = 7;
  var_8 = 8;
  var_9 = var_1;

  if(var_0[0] > 0) {
    if(var_0[1] <= 0.7 && var_0[1] >= -0.7) {
      var_9 = var_1;
    }

    if(var_0[0] > 0.5 && var_0[1] > 0.7) {
      var_9 = var_2;
    } else if(var_0[0] > 0.5 && var_0[1] < -0.7) {
      var_9 = var_3;
    }
  } else if(var_0[0] < 0) {
    if(var_0[1] < 0.4 && var_0[1] > -0.4) {
      var_9 = var_4;
    }

    if(var_0[0] < -0.5 && var_0[1] > 0.5) {
      var_9 = var_5;
    } else if(var_0[0] < -0.5 && var_0[1] < -0.5) {
      var_9 = var_6;
    }
  } else if(var_0[1] > 0.4) {
    var_9 = var_7;
  } else if(var_0[1] < -0.4) {
    var_9 = var_8;
  }

  return var_9;
}

function health_meter_monitor(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  wait 1;

  for(;;) {
    var_0 setclientomnvar("zm_player_health", var_0.health / 100);
    wait 0.05;
  }
}

function last_stand_hud_update() {
  self setclientomnvar("zm_player_health", 0);
}

function monitor_num_players() {
  scripts\engine\utility::flag_init("player_count_determined");
  var_0 = getDvar("NKSQNMMRRQ");

  if(var_0 != "1") {
    level.only_one_player = 0;
    scripts\engine\utility::flag_set("player_count_determined");
    return;
  }

  level.only_one_player = 1;
  scripts\engine\utility::flag_set("player_count_determined");

  while(!isDefined(level.players)) {
    wait 0.1;
  }

  for(;;) {
    if(level.players.size > 1) {
      break;
    }

    wait 1;
  }

  level.only_one_player = 0;
  level notify("multiple_players");
}

function enable_dogtag_revive(var_0) {
  var_1 = spawn("script_model", var_0.origin + (0, 0, 40));
  var_1 setModel("military_dogtags_iw8_blue");
  var_1 makeusable();
  var_1 scriptmodelplayanim("mp_dogtag_spin");
  var_1 setHintString(&"COOP_GAME_PLAY/REVIVE_USE");
  var_1 endon("death");
  var_0.respawn_forcespawnorigin = var_0.origin;
  var_0.respawn_forcespawnangles = (0, 0, 0);
  var_0.dogtag = var_1;
  var_0.dogtag.owner = var_0;
  scripts\cp\cp_laststand::makereviveicon(var_1, var_0, (1, 0, 0));
  thread revivetriggerthink(var_1);
  thread endreviveonownerdeathordisconnect();
  level notify("laststand_dogtag_spawned", var_1);
}

function rotate_tags() {
  self endon("death");

  for(;;) {
    self rotateYaw(30, 0.5);
    wait 0.5;
  }
}

function revivetriggerthink(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("instant_revive");
  var_0 endon("instant_revive");
  var_1 = 8000;

  for(;;) {
    var_1 = 8000;
    self waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(istrue(var_2.class == "medic")) {
      var_1 = 6800;
    }

    self.bplayerrevivingteammate = 1;
    scripts\cp\cp_laststand::set_revive_icon_color(self, (0.0117, 0.9882, 0.9882), 1);
    var_3 = scripts\cp\utility::player_lua_progressbar(var_2, var_1, 9216, 5);
    scripts\cp\cp_laststand::set_revive_icon_color(self, (1, 0, 0), 1);
    self.bplayerrevivingteammate = undefined;

    if(!var_3) {
      continue;
    }

    break;
  }

  playFX(level._effect["dogtag_pickup"], self.origin);
  var_0 scripts\cp\cp_laststand::instant_revive(var_0);
  var_0 notify("last_stand_finished");
}

function endreviveonownerdeathordisconnect() {
  self endon("disconnect");
  self endon("death");
  self.owner scripts\engine\utility::ref_143a5("disconnect", "last_stand_finished");
  self.owner = undefined;
  self delete();
}

function checkpoint_revive() {
  level endon("game_ended");

  for(var_0 = 1;; var_0++) {
    level waittill("checkpoint_revive");
    var_1 = scripts\engine\utility::getStructArray("player_checkpoint_" + var_0, "targetname");

    foreach(var_4, var_3 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
        var_3.respawn_forcespawnorigin = var_1[var_4].origin;
        var_3.respawn_forcespawnangles = var_1[var_4].angles;
        var_3 scripts\cp\cp_laststand::instant_revive(var_3);

        if(isDefined(var_3.dogtag)) {
          var_3.dogtag delete();
        }
      }
    }
  }
}

function give_skillpoints_at_start() {
  self endon("disconnect");
  self waittill("loadout_given");

  if(!isDefined(self.starting_skillpoints_given)) {
    scripts\cp\classes\cp_class_progression::give_skill_points(4);
    self.starting_skillpoints_given = 1;
    return;
  }
}

function givedefaultloadout(var_0, var_1) {
  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  scripts\cp\survival\survival_loadout::givedefaultloadout(var_0, var_1);
}

function getspawnpoint() {
  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  var_0 = scripts\engine\utility::getStructArray("default_player_start", "targetname");

  if(isDefined(level.default_player_spawns)) {
    var_1 = scripts\engine\utility::getStructArray(level.default_player_spawns, "targetname");

    if(var_1.size > 0) {
      var_0 = var_1;
    }
  }

  if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    return scripts\cp\pvpe\pvpe::getassignedspawnpointbasedonteam(self);
  }

  if(scripts\cp\pvpve\pvpve::pvpve_enabled()) {
    return scripts\cp\pvpve\pvpve::getassignedspawnpointbasedonteam(self);
  }

  return getassignedspawnpoint(var_0);
}

function getassignedspawnpoint(var_0) {
  var_1 = self getentitynumber();
  return var_0[var_1];
}

function allow_nvg() {
  if(istrue(level.disable_nvg)) {
    return false;
  }

  return true;
}

function mortars_get_enemies() {
  if(getdvarint("scr_skip_infils", 0) == 1) {
    return;
  }

  if(ref_124b9()) {
    return;
  }

  level.strike_player_connect_black_screen_fn = &lbravo_infil_spawn_blackscreen_func;
  thread delay_init_infil();
}

function ref_124b9() {
  return istrue(game["player_infil_already_played"]);
}

function delay_init_infil() {
  level endon("game_ended");
  var_0 = 4;
  wait var_0;
  level thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("alpha");
  level waittill("players_unloaded_from_infil");
  game["player_infil_already_played"] = 1;
}

function lbravo_infil_spawn_blackscreen_func(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("stop_intro");
  var_1 = 6;
  var_0 setclientomnvar("ui_hide_hud", 1);
  var_0.introscreen_overlay = newclienthudelem(self);
  var_0.introscreen_overlay.x = 0;
  var_0.introscreen_overlay.y = 0;
  var_0.introscreen_overlay setshader("black", 640, 480);
  var_0.introscreen_overlay.alignx = "left";
  var_0.introscreen_overlay.aligny = "top";
  var_0.introscreen_overlay.sort = 1;
  var_0.introscreen_overlay.horzalign = "fullscreen";
  var_0.introscreen_overlay.vertalign = "fullscreen";
  var_0.introscreen_overlay.alpha = 1;
  var_0.introscreen_overlay.foreground = 1;

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  wait 5;
  var_0 scripts\cp\survival\survival_loadout::givedefaultloadout(0, undefined, 0);
  var_0 disableweapons();
  var_0 scripts\cp\utility::freezecontrolswrapper(1);
  var_0 setclientomnvar("ui_hide_hud", 0);
  show_introscreen_text(var_0);
  wait var_1;
  var_0 setclientomnvar("ui_hide_hud", 1);
  var_0 setclientomnvar("ui_chyron_on", 0);
  var_0 setclientomnvar("ui_chyron_mission_index", 0);
  scripts\cp\cp_globallogic::refreshuimatchinprogressomnvarvalue();
  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  var_0 enableweapons();

  if(!scripts\cp\utility::gameflag("infil_started")) {
    var_0.introscreen_overlay destroy();
    level notify("trying_to_join_infil", var_0);
    return;
  }

  var_0 notify("open_loadout_menu");
  var_0.introscreen_overlay fadeovertime(2);
  var_0.introscreen_overlay.alpha = 0.5;
  wait 2;
  var_0.introscreen_overlay destroy();
  var_0 setclientomnvar("ui_hide_hud", 0);
}

function update_laststand_times() {
  scripts\cp\cp_laststand::init_laststand_anims();
  var_0 = level.scr_anim["ls_revive_helper"]["in_stand_1"];
  var_1 = level.scr_anim["ls_revive_helper"]["idle_stand_1"];
  var_2 = level.scr_anim["ls_revive_helper"]["out_stand_1"];
  var_3 = getanimlength(var_0);
  var_4 = getanimlength(var_1);
  var_5 = getanimlength(var_2);
  var_6 = 0.5;
  var_7 = (var_3 + var_4 + var_5 + var_6) * 1000;
  var_8 = 5000;
  var_9 = (var_3 + var_5 + var_6) * 1000;
  scripts\cp\cp_laststand::set_revive_time(var_7, var_8, var_9);
}

function canspawnitemname(var_0, var_1) {
  self endon("disconnect");
  scripts\cp\utility::hint_prompt(var_0, 1);
  wait var_1;
  scripts\cp\utility::hint_prompt(var_0, 0);
}