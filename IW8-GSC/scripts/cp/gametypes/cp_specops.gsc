/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\gametypes\cp_specops.gsc
***********************************************/

function main() {
  level.playerent = &scripts\cp\cp_weapon::bomber_spawn_origin_array_init;
  level.ref_127f3 = &playerattractiontriggerexit;
  level.ref_11b51 = 48;
  scripts\cp\helicopter\chopper_boss::init();
  thread onplayerconnect();
  level.skip_playerhudphoto = 1;
  scripts\cp\cp_music_and_dialog::init();
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
  setDvar("scr_cp_difficulty", 2);
  scripts\cp\cp_gameskill::init_gameskill();
  level.use_temp_bc = 1;
  create_player_threatbias_groups();

  if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    scripts\cp\pvpe\pvpe::init_pvpe();
  } else if(scripts\cp\pvpve\pvpve::pvpve_enabled()) {
    scripts\cp\pvpve\pvpve::init_pvpve();
  }

  thread scripts\cp\cp_battlechatter::manualinitbattlechatter();
  scripts\cp\laser_traps\cp_laser_traps::stopinteract();
  scripts\cp\laser_traps\cp_laser_traps::teamanchoredwidgetinstances();
  scripts\cp\killstreaks\nuke_cp::init_script_triggers();
  scripts\engine\utility::create_func_ref("spawn_ai", &ref_134ec);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "returnObjectiveID", &lastdepositinstruct);
  scripts\cp\helicopter\chopper_boss::clearmatchhasmorethan1playervariablesonroundend();
  scripts\cp\laser_traps\cp_laser_traps::ref_1430d();
}

function ref_134ec(var0) {
  return scripts\cp\laser_traps\cp_laser_traps::ref_134f1(self.script_type, self.origin, self.angles, 1);
}

function lastdepositinstruct(var0) {
  objective_delete(var0);
  scripts\cp\utility::nonobjective_returnobjectiveid(var0);
}

function create_player_threatbias_groups() {}

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
  scripts\engine\utility::flag_init("so_connect_timer_finished");
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
  level.exploimpactmod = 0.1;
  level.shotgundamagemod = 0.1;
  level.armorpiercingmod = 0.2;
  level.maxlogclients = 10;
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
  level.prespawnfromspectaorfunc = &prespawnfromspectatorfunc;
  level.laststand_exit_gamemodespecificaction = &exit_laststand_func;
  level.last_stand_hud_update = &last_stand_hud_update;
  level.getspawnpoint = &getspawnpoint;
  level.update_money_performance = &scripts\cp\cp_core_gamescore::update_money_earned_performance;
  level.active_volume_check = &scripts\cp\utility::is_in_active_volume;
  level.endgame_write_clientmatchdata_for_player_func = &endgame_clientmatchdata;
  level.hostmigrationend = &hostmigrationend;
  level.onhostmigration = &hostmigrationstart;
  level.custom_player_hotjoin_func = undefined;
  level.game_mode_statstable = "cp/zombies/mode_string_tables/zombies_statstable.csv";
  level.game_mode_attachment_map = "cp/zombies/zombie_attachmentmap.csv";
  var0 = getDvar("NSQLTTMRMP");
  level.power_up_table = "cp/zombies/" + var0 + "_loot.csv";
}

function exit_laststand_func(var0) {
  var0 scripts\cp\cp_powers::restore_powers(var0, var0.pre_laststand_powers);
  var0 setclientomnvar("zm_ui_player_in_laststand", 0);
  var0 clearclienttriggeraudiozone(0.3);
  var0 playlocalsound("deaths_door_out");
  var0 stoplocalsound("deaths_door_in");

  if(isDefined(level.vision_set_override)) {
    thread reset_override_visionset(var0);
  }

  var1 = randomintrange(1, 5);
  var2 = "zmb_revive_music_lr_0" + var1;
  var0 scripts\cp\utility::playlocalsound_safe(var2);
  var0 scripts\cp\utility::allow_player_ignore_me(0);
}

function reset_override_visionset(var0) {
  level endon("game_ended");
  self endon("disconnect");
  wait var0;

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
  thread scripts\cp_mp\auto_ascender::init();
  thread scripts\cp_mp\ent_manager::init();

  if(level.ref_12376) {
    level scripts\cp\whizby::calloutmarkerping_init();
  }

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

  scripts\cp\cp_persistence::rank_init();
  thread handlenondeterministicentities();
  thread checkpoint_revive();

  if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    scripts\cp\pvpe\pvpe::initialize_player_team_slot_assignment();
  } else if(scripts\cp\pvpve\pvpve::pvpve_enabled()) {
    scripts\cp\pvpve\pvpve::initialize_player_team_slot_assignment();
  }

  thread scripts\cp\cp_outofbounds::initoob();
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
    level waittill("connected", var0);

    if(!isai(var0)) {
      var0 scripts\cp\cp_analytics::on_player_connect();

      if(isDefined(var0.connecttime)) {
        var0.connect_time = var0.connecttime;
      } else {
        var0.connect_time = gettime();
      }

      var0.xpscale = getdvarint("MSTMORLPKN");
      var0.weaponxpscale = getdvarint("NNKLRNNSOP");

      if(var0 scripts\cp\utility::rankingenabled()) {
        var1 = getdvarint("LTSPPRQSMO");
        var2 = getdvarint("NSRPSMKOMP");
        var3 = var0 getprivatepartysize() > 1;

        if(isDefined(var1)) {
          if(var3 && var1 > 1) {
            var0.weaponxpscale = var1;
          }
        }

        if(isDefined(var2)) {
          if(var3 && var2 > 1) {
            var0.xpscale = var2;
          }
        }
      }

      if(istrue(var0 getplayerdata("cp", "tacOpsAchievements", "LANDLORD")) && istrue(var0 getplayerdata("cp", "tacOpsAchievements", "ARMED")) && istrue(var0 getplayerdata("cp", "tacOpsAchievements", "SMUGGLED")) && istrue(var0 getplayerdata("cp", "tacOpsAchievements", "LAUNDERED"))) {
        var0 thread scripts\cp_mp\xmike109::screenent_d("all_operations");
      }

      var0 thread scripts\cp\helicopter\chopper_boss::player_init_health_regen();
      var0 scripts\cp\cp_persistence::session_stats_init();
      var0 scripts\cp\utility::brjugg_playerwelcomesplashes(0);
      var0.num_of_plays = [];
      var0.nextcasheffecttime = 0;
      var0.total_currency_earned = 0;
      var0.can_give_revive_xp = 1;
      var0.pap = [];
      var0.powerupicons = [];
      var0.powers = [];
      var0.powers_active = [];
      var0.disabled_interactions = [];
      var0.onkillweaponpassives = [];
      var0.onuseweaponpassives = [];
      var0.ondamageweaponpassives = [];
      var0.disabledteleportation = 0;
      var0.disabledinteractions = 0;
      var0.power_cooldowns = 0;
      var0.tickets_earned = 0;
      var0.time_to_give_next_tickets = gettime();
      var0.self_revives_purchased = 0;
      var0.max_self_revive_machine_use = 3;
      var0.cash_scalar = 1;
      var0.recentkillcount = 0;
      var0.enabledignoreme = 0;
      var0.infiniteammocounter = 0;
      var0.awarenessadjustment = 0;
      var0.move_door_to_pos = 0;
      var0 scripts\cp\utility::allow_player_teleport(0);
      var0.achievement_registration_func = &scripts\cp\cp_achievement::register_default_achievements;
      var0 scripts\cp\cp_achievement::switchminimapid(var0);
      var0.ref_136a1 = var0.connect_time;
      var0 scripts\cp\cp_mapselect::set_uav_radarstrength(var0);
      var0 scripts\cp\cp_persistence::lb_player_update_stat("waveNum", level.wave_num, 1);
      var0 scripts\cp\cp_wall_buys::setup_player_weapon_models(var0);
      var0 thread scripts\cp\cp_analytics::init_weapon_and_player_analytics(var0);

      if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
        var0 scripts\cp\pvpe\pvpe::assign_pvpe_team_and_slot_number(var0);
        var0 scripts\cp\pvpe\pvpe::terrorist_self_revive_time_override(var0);
      }

      if(level.ref_12376) {
        var0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();
      }

      var0.gameskill = scripts\cp\cp_gameskill::get_gameskill();
      var0 scripts\cp\cp_gameskill::set_difficulty_from_locked_settings();
      var0.gs.scripteddeathshielddurationscale = 1;
      thread juggernaut_pincer(var0);

      if(scripts\engine\utility::flag("introscreen_over")) {
        if(isDefined(level.custom_player_hotjoin_func)) {
          var0 thread[[level.custom_player_hotjoin_func]]();
        }
      }

      if(isDefined(level.custom_onplayerconnect_func)) {
        [[level.custom_onplayerconnect_func]](var0);
      }

      if(!isDefined(level.kick_player_queue)) {
        thread kick_player_queue_loop();
      }

      thread pausemenu_think();
    }
  }
}

function pausemenu_think() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    if(var0 == "vote_retry") {
      scripts\cp\laser_traps\cp_laser_traps::ref_1430e("retry", 30);
      scripts\cp\laser_traps\cp_laser_traps::ref_1430b("retry", 1);
    }
  }
}

function team_slot_assignment_available_from_player_disconnect() {
  return level.disconnect_player_team_slot_assignment.size > 0;
}

function get_team_slot_assignment_from_player_disconnect() {
  var0 = level.disconnect_player_team_slot_assignment[0];
  level.disconnect_player_team_slot_assignment = scripts\engine\utility::array_remove(level.disconnect_player_team_slot_assignment, var0);
  return var0;
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

  var0 = getDvar("NSQLTTMRMP");

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

function onspawnplayer(var0) {
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

  if(!isDefined(self.move_door_to_pos)) {
    self.move_door_to_pos = 0;
  }

  scripts\cp\utility::brjugg_playerwelcomesplashes(1);

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

  scripts\cp\helicopter\chopper_boss::player_init_invulnerability();
  scripts\cp\helicopter\chopper_boss::player_init_damageshield();
  var1 = get_starting_currency(self);
  thread scripts\cp\cp_persistence::wait_to_set_player_currency(var1);
  set_player_max_currency(999999);
  thread scripts\cp\cp_damage::core_health_regen();
  thread scripts\cp\cp_hud_util::zom_player_health_overlay_watcher();
  thread scripts\cp\cp_weapon::watchweaponusage();
  thread scripts\cp\cp_weapon::watchweaponchange();
  thread scripts\cp\cp_weapon::watchweaponfired();
  thread scripts\cp\coop_personal_ents::assignpersonalmodelents(self);
  thread scripts\cp\coop_personal_ents::movepentstostructs(self);
  thread give_skillpoints_at_start();

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  scripts\cp\utility::force_usability_enabled();

  if(scripts\cp\pvpe\pvpe::pvpe_enabled() && scripts\cp\pvpe\pvpe::player_is_terrorist(self)) {
    scripts\cp\pvpe\pvpe::on_spawn_terrorist_player(self);
  }

  thread ref_12476();
}

function ref_12476() {
  self endon("disconnect");

  for(;;) {
    self waittill("chopper_gunner_used");
    scripts\cp\cp_globallogic::broadcast_status(self, 3);
    self waittill("chopper_gunner_ended");

    if(isalive(self) && !self.inlaststand) {
      scripts\cp\cp_globallogic::broadcast_status(self, 0);
    }
  }
}

function get_starting_currency(var0) {
  var1 = var0.starting_currency_after_revived_from_spectator;

  if(isDefined(var1)) {
    var0.starting_currency_after_revived_from_spectator = undefined;
    return var1;
  }

  return scripts\cp\cp_persistence::get_starting_currency();
}

function set_player_max_currency(var0) {
  var0 = int(var0);
  self.maxcurrency = var0;
}

function prespawnfromspectatorfunc(var0) {
  var0.starting_currency_after_revived_from_spectator = var0 scripts\cp\cp_persistence::get_player_currency();
  revivefromspectatorweaponsetup(var0);
  set_spawn_loc(var0);
}

function revivefromspectatorweaponsetup(var0) {
  var1 = spawnStruct();
  var1.copy_fullweaponlist = var0.copy_fullweaponlist;
  var1.copy_weapon_current = var0.copy_weapon_current;
  var1.copy_weapon_ammo_clip = var0.copy_weapon_ammo_clip;
  var1.copy_weapon_ammo_stock = var0.copy_weapon_ammo_stock;

  if(isDefined(var0.saved_last_stand_pistol)) {
    var1.last_stand_pistol = var0.saved_last_stand_pistol;
    var0.saved_last_stand_pistol = undefined;
  } else {
    var1.last_stand_pistol = var0.last_stand_pistol;
  }

  var1.weapon_levels = var0.copy_weapon_level;

  if(isDefined(var0.current_crafted_inventory)) {
    var1.current_crafted_inventory = var0.current_crafted_inventory;
    var0.current_crafted_inventory = undefined;
  }

  var1.copy_all_powers = var0.pre_laststand_powers;
  var1.copy_special_ammo_type = var0.special_ammo_type;
  var0.weaponlist = var1;
}

function restore_player_weapons_after_bleedout(var0) {
  var0 notify("weapon_purchased");
  var1 = var0.weaponlist;
  var0 takeallweapons();
  var0.copy_fullweaponlist = var1.copy_fullweaponlist;
  var0.copy_weapon_current = var1.copy_weapon_current;
  var0.copy_weapon_ammo_clip = var1.copy_weapon_ammo_clip;
  var0.copy_weapon_ammo_stock = var1.copy_weapon_ammo_stock;
  var0.copy_all_powers = var1.copy_all_powers;
  var0.copy_weapon_level = var1.weapon_levels;
  var0 scripts\cp\utility::restore_primary_weapons_only();
  var0 scripts\cp\utility::restore_super_weapon();
  var0 scripts\cp\cp_powers::restore_powers(var0, var0.copy_all_powers);

  if(isDefined(var1.current_crafted_inventory)) {
    level thread[[var1.current_crafted_inventory.restore_func]](undefined, var0);
  }

  var0.special_ammo_type = var1.copy_special_ammo_type;
  var0.have_things_in_lost_and_found = 0;
  var0.last_stand_pistol = var1.last_stand_pistol;
  var0.weaponlist = undefined;
}

function set_spawn_loc(var0) {
  var1 = getplayerrespawnloc(var0);
  var0.forcespawnorigin = var1.origin;
  var0.forcespawnangles = var1.angles;

  if(isDefined(var0.respawn_forcespawnorigin)) {
    var0.forcespawnorigin = var0.respawn_forcespawnorigin;
  }

  if(isDefined(var0.respawn_forcespawnangles)) {
    var0.forcespawnangles = var0.respawn_forcespawnangles;
    return;
  }
}

function getplayerrespawnloc(var0) {
  if(isDefined(level.force_respawn_location)) {
    return [[level.force_respawn_location]](var0);
  }

  if(!isDefined(level.active_player_respawn_locs) || level.active_player_respawn_locs.size == 0 || level.players.size == 0) {
    return [[level.getspawnpoint]]();
  }

  if(isDefined(level.respawn_loc_override_func)) {
    return [[level.respawn_loc_override_func]](var0);
  }

  var1 = get_available_players(var0);
  var2 = get_available_respawn_locs(var1);

  if(var2.size == 0) {
    return get_respawn_loc_near_team_center(var0, var1);
  }

  if(var2.size == 1) {
    return var2[0];
  }

  return get_respawn_loc_rated(var0, var1, var2);
}

function get_available_players(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(var3 == var0) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var3)) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function get_available_respawn_locs(var0) {
  var1 = [];

  foreach(var3 in level.active_player_respawn_locs) {
    if(!canspawn(var3.origin)) {
      continue;
    }

    if(positionwouldtelefrag(var3.origin)) {
      continue;
    }

    if(is_respawn_loc_near_available_players(var3, var0)) {
      continue;
    }

    if(is_respawn_loc_near_alive_enemies(var3)) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function is_respawn_loc_near_available_players(var0, var1) {
  foreach(var3 in var1) {
    if(distancesquared(var3.origin, var0.origin) < 250000) {
      return true;
    }
  }

  return false;
}

function is_respawn_loc_near_alive_enemies(var0) {
  var1 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(var3 in var1) {
    if(distancesquared(var3.origin, var0.origin) < 250000) {
      return true;
    }
  }

  return false;
}

function get_respawn_loc_near_team_center(var0, var1) {
  var2 = 0;
  var3 = 0;
  var4 = 0;
  var5 = 0;

  foreach(var7 in var1) {
    var2 += var7.origin[0];
    var3 += var7.origin[1];
    var4 += var7.origin[2];
    var5++;
  }

  var9 = (var2 / var5, var3 / var5, var4 / var5);
  var10 = sortbydistance(level.active_player_respawn_locs, var9);
  return var10[0];
}

function get_respawn_loc_rated(var0, var1) {
  var2 = scripts\engine\utility::ter_op(var0.size == 0, 1, var0.size);
  var3 = level.spawned_enemies.size / var2;
  var4 = var3 * 2;
  var5 = -99999999;
  var6 = undefined;

  foreach(var8 in var1) {
    var9 = 0;

    foreach(var11 in var0) {
      if(var11 == self) {
        continue;
      }

      if(!isalive(var11)) {
        continue;
      }

      if(istrue(var11.inlaststand)) {
        var9 -= distancesquared(var11.origin, var8.origin) * var4 * 2;
        continue;
      }

      var9 -= distancesquared(var11.origin, var8.origin) * var4;
    }

    foreach(var14 in level.spawned_enemies) {
      var9 += distancesquared(var14.origin, var8.origin);
    }

    var9 /= 1000000;

    if(var9 > var5) {
      var5 = var9;
      var6 = var8;
    }
  }

  return var6;
}

function prematchfunc() {
  var0 = 0;

  if(var0 > 0) {
    var1 = wait_for_first_player_connect(level);
    wait var0 - 3;

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
  var0 = getDvar("NSQLTTMRMP");
  var1 = getDvar(var0 + "_start_obj", "");
  var2 = "cp/" + var0 + "_objectives.csv";
  var3 = int(tablelookup(var2, 1, var1, 0));

  if(isDefined(var1) && var1 != "") {
    self setclientomnvar("ui_chyron_mission_index", var3);
    self setclientomnvar("ui_chyron_on", 1);
    return;
  }
}

function wait_for_first_player_connect() {
  var0 = undefined;

  if(level.players.size == 0) {
    level waittill("connected", var0);
  } else {
    var0 = level.players[0];
  }

  return var0;
}

function juggernaut_pincer(var0) {
  var0 endon("disconnect");
  var0.introscreen_overlay = newclienthudelem(var0);
  var0.introscreen_overlay.x = 0;
  var0.introscreen_overlay.y = 0;
  var0.introscreen_overlay setshader("black", 640, 480);
  var0.introscreen_overlay.alignx = "left";
  var0.introscreen_overlay.aligny = "top";
  var0.introscreen_overlay.sort = 1;
  var0.introscreen_overlay.horzalign = "fullscreen";
  var0.introscreen_overlay.vertalign = "fullscreen";
  var0.introscreen_overlay.alpha = 1;
  var0.introscreen_overlay.foreground = 1;
  var1 = 4;
  var0.introscreen_overlay fadeovertime(var1);
  var0.introscreen_overlay.alpha = 0;
  wait var1;
  var0.introscreen_overlay destroy();

  if(level.players.size > 1) {
    var2 = 0;

    foreach(var4 in level.players) {
      if(isDefined(var4.introscreen_overlay)) {
        var2 = 1;
        break;
      }
    }

    if(var2 == 0) {
      var6 = getdvarint("scr_delay_cpclassicspecops_matchinprogress", 5);
      wait var6;
      scripts\cp\helicopter\chopper_boss::refreshuimatchinprogressomnvarvalue();
      return;
    }

    return;
  }

  scripts\cp\helicopter\chopper_boss::refreshuimatchinprogressomnvarvalue();
}

function playerinfildisabled(var0) {
  return istrue(var0.infil_disabled);
}

function callbackplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  [[level.callbackplayerlaststand]](var0, var1, var2, var4, var5, var7, var8, var9);
}

function precachelb() {
  var0 = " LB_" + getDvar("NSQLTTMRMP");

  if(scripts\cp\utility::isplayingsolo()) {
    var0 += "_SOLO";
  } else {
    var0 += "_COOP";
  }

  precacheleaderboards(var0);
}

function enter_laststand(var0, var1) {
  var0 scripts\cp\cp_persistence::eog_player_update_stat("downs", 1);
  var0 scripts\cp\cp_analytics::log_event("dropped_to_last_stand", 1, [var0.clientid], [var0.clientid], [var0.clientid]);
  var0.pre_arcade_game_weapon = undefined;
  var0.pre_arcade_game_weapon_clip = undefined;
  var0.pre_arcade_game_weapon_stock = undefined;
  var0.former_mule_weapon = undefined;
  var0.pre_laststand_powers = var0 scripts\cp\cp_powers::get_info_for_player_powers(var0);
  var0 scripts\cp\cp_powers::clearpowers();
  var0 clearaccessory();
  var2 = var0 getcurrentweapon();
  var3 = getweaponbasename(var2);
  var4 = var0 getcurrentweaponclipammo();

  if(!isDefined(var0.downsperweaponlog[var3])) {
    var0.downsperweaponlog[var3] = 1;
  } else {
    var0.downsperweaponlog[var3]++;
  }

  var0 clearclienttriggeraudiozone(0);

  if(!self issplitscreenplayer() && !scripts\cp\cp_endgame::gamealreadyended()) {
    var0 setclienttriggeraudiozonepartialwithfade("last_stand_cp", 0.02, "mix", "reverb", "filter");
  }

  var0.have_self_revive = var0 scripts\cp\utility::has_auto_revive();

  if(var0.have_self_revive) {
    var5 = scripts\cp\utility::isplayingsolo() || level.only_one_player;
    var0 notify("player_has_self_revive", var5);
  }

  if(isDefined(var0.mule_weapon) && !istrue(var0.playing_ghosts_n_skulls)) {
    var0.former_mule_weapon = var0.mule_weapon;
  } else {
    var0.former_mule_weapon = undefined;
  }

  var0 scripts\cp\zombies\zombieclientmatchdata::logplayerdeath();
  var0 scripts\cp\utility::allow_player_ignore_me(1);
  var0 setclientomnvar("zm_ui_player_in_laststand", 1);

  if(scripts\cp\pvpe\pvpe::player_is_terrorist(var0)) {
    var0 thread scripts\cp\pvpe\pvpe::terrorist_enter_laststand(var0, var1);
    return;
  }
}

function updaterecentkills(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.recentkillcount++;
  var2 = getweaponbasename(var1);

  if(!isDefined(self.killsperweaponlog[var2])) {
    self.killsperweaponlog[var2] = 1;
  } else {
    self.killsperweaponlog[var2]++;
  }

  if(!isDefined(self.recentkillsperweapon)) {
    self.recentkillsperweapon = [];
  }

  if(!isDefined(self.recentkillsperweapon[var1])) {
    self.recentkillsperweapon[var1] = 1;
  } else {
    self.recentkillsperweapon[var1]++;
  }

  var3 = scripts\cp\utility::getequipmenttype(var1);
  wait 1.25;
  self.recentkillcount = 0;
  self.recentkillsperweapon = undefined;
}

function onplayerdisconnect(var0, var1) {
  var0 setplayerdata("cp", "CPSession", "subParty", -1);
  scripts\cp\cp_persistence::eog_update_on_player_disconnect(var0);
}

function endgame_clientmatchdata(var0, var1) {}

function hostmigrationstart() {
  var0 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(var2 in var0) {
    if(istrue(var2.scripted_mode)) {
      var2.died_poorly = 1;
      var2 suicide();
      continue;
    }

    if(istrue(var2.ignoreme)) {
      var2.died_poorly = 1;
      var2 suicide();
      continue;
    }

    if(istrue(var2.ignoreall)) {
      var2.died_poorly = 1;
      var2 suicide();
      continue;
    }

    if(!istrue(var2.entered_playspace)) {
      var2.died_poorly = 1;
      var2 suicide();
      continue;
    }

    var2.scripted_mode = 1;
    var2 scragentsetgoalpos(var2.origin);
    var2.ignoreme = 1;
    var2.ignoreall = 1;
  }
}

function hostmigrationend() {
  var0 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(var2 in var0) {
    var2.scripted_mode = 0;
    var2.ignoreme = 0;
    var2.ignoreall = 0;
  }

  if(isDefined(level.customhostmigrationend)) {
    level thread[[level.customhostmigrationend]]();
    return;
  }
}

function resetplayerhud() {
  foreach(var1 in level.players) {
    if(isDefined(var1.current_vehicle_seat)) {
      var2 = var1.current_vehicle_seat;
      var1 scripts\cp\maps\cp_br_syrk\vehicle_travel::enter_seat_omnvar(var1, var2);
    }
  }
}

function kick_for_inactivity(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  thread check_for_move_change();
  thread check_for_movement();
  var0.input_has_happened = 0;
  var1 = gettime();
  var2 = level.onlinegame && !getdvarint("LSTLQTSSRM");

  if(var2) {
    var0 notifyonplayercommand("inputReceived", "+speed_throw");
    var0 notifyonplayercommand("inputReceived", "+stance");
    var0 notifyonplayercommand("inputReceived", "+goStand");
    var0 notifyonplayercommand("inputReceived", "+usereload");
    var0 notifyonplayercommand("inputReceived", "+activate");
    var0 notifyonplayercommand("inputReceived", "+melee_zoom");
    var0 notifyonplayercommand("inputReceived", "+breath_sprint");
    var0 notifyonplayercommand("inputReceived", "+attack");
    var0 notifyonplayercommand("inputReceived", "+frag");
    var0 notifyonplayercommand("inputReceived", "+smoke");
    var3 = 120;
    var4 = 0.1;

    for(;;) {
      var5 = scripts\engine\utility::ref_143c0(var4, "inputReceived", "currency_earned");

      if(var5 != "timeout") {
        var3 = 120;
        var0.input_has_happened = 1;
        continue;
      }

      if(!istrue(var0.in_afterlife_arcade) && !istrue(var0.inlaststand)) {
        var3 -= var4;
      }

      if(var3 < 0) {
        if(level.players.size > 1) {
          if(var0.input_has_happened) {
            var0.input_has_happened = 0;
            continue;
          }

          add_to_kick_queue(var0);
          break;
        }
        LOC_00000179:
      }
      LOC_00000179:
    }

    return;
  }
}

function check_for_movement() {
  level endon("game_ended");
  self endon("disconnect");
  var0 = level.onlinegame && !getdvarint("LSTLQTSSRM");

  if(var0) {
    var1 = self getnormalizedmovement();
    var2 = gettime();

    for(;;) {
      wait 0.2;
      var3 = self getnormalizedmovement();

      if(var3[0] == var1[0] && var3[1] == var1[1]) {
        if(gettime() - var2 > 90000 && level.players.size > 1) {
          add_to_kick_queue(self);
        }

        continue;
      }

      return;
    }

    return;
  }
}

function add_to_kick_queue(var0) {
  if(!scripts\engine\utility::array_contains(level.kick_player_queue, var0)) {
    level.kick_player_queue = scripts\engine\utility::array_add_safe(level.kick_player_queue, var0);
    return;
  }
}

function kick_player_queue_loop() {
  level endon("game_ended");
  level.kick_player_queue = [];

  for(;;) {
    if(level.kick_player_queue.size > 0) {
      foreach(var1 in level.kick_player_queue) {
        if(!isDefined(var1)) {
          continue;
        }

        if(!var1 ishost()) {
          kick(var1 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE");
        }
      }

      if(level.kick_player_queue.size > 0) {
        foreach(var1 in level.kick_player_queue) {
          if(!isDefined(var1)) {
            continue;
          }

          kick(var1 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE");
        }
      }

      level.kick_player_queue = [];
    }

    wait 0.1;
  }
}

function check_for_move_change() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("done_inactivity_check");

  while(!isDefined(self.model)) {
    wait 0.1;
  }

  var0 = 1;
  var1 = var0;
  var2 = var0;

  for(;;) {
    var3 = self getnormalizedmovement();
    var1 = get_move_direction_from_vectors(var3);

    if(var2 != var1) {
      var2 = var1;
      self notify("inputReceived");
    }

    wait 0.1;
  }
}

function get_move_direction_from_vectors(var0) {
  var1 = 1;
  var2 = 2;
  var3 = 3;
  var4 = 4;
  var5 = 5;
  var6 = 6;
  var7 = 7;
  var8 = 8;
  var9 = var1;

  if(var0[0] > 0) {
    if(var0[1] <= 0.7 && var0[1] >= -0.7) {
      var9 = var1;
    }

    if(var0[0] > 0.5 && var0[1] > 0.7) {
      var9 = var2;
    } else if(var0[0] > 0.5 && var0[1] < -0.7) {
      var9 = var3;
    }
  } else if(var0[0] < 0) {
    if(var0[1] < 0.4 && var0[1] > -0.4) {
      var9 = var4;
    }

    if(var0[0] < -0.5 && var0[1] > 0.5) {
      var9 = var5;
    } else if(var0[0] < -0.5 && var0[1] < -0.5) {
      var9 = var6;
    }
  } else if(var0[1] > 0.4) {
    var9 = var7;
  } else if(var0[1] < -0.4) {
    var9 = var8;
  }

  return var9;
}

function health_meter_monitor(var0) {
  var0 endon("disconnect");
  level endon("game_ended");
  wait 1;

  for(;;) {
    var0 setclientomnvar("zm_player_health", var0.health / 100);
    wait 0.05;
  }
}

function last_stand_hud_update() {
  self setclientomnvar("zm_player_health", 0);
}

function monitor_num_players() {
  scripts\engine\utility::flag_init("player_count_determined");
  var0 = getDvar("NKSQNMMRRQ");

  if(var0 != "1") {
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

function checkpoint_revive() {
  level endon("game_ended");

  for(var0 = 1;; var0++) {
    level waittill("checkpoint_revive");
    var1 = scripts\engine\utility::getStructArray("player_checkpoint_" + var0, "targetname");

    foreach(var4, var3 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var3)) {
        var3.respawn_forcespawnorigin = var1[var4].origin;
        var3.respawn_forcespawnangles = var1[var4].angles;
        var3 scripts\cp\cp_laststand::instant_revive(var3);

        if(isDefined(var3.dogtag)) {
          var3.dogtag delete();
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

function givedefaultloadout() {
  var0 = self;
  var0 setclientomnvar("ui_options_menu", 0);
  var0 takeallweapons();
  var0 scripts\cp\utility::_clearperks();
  var0 scripts\cp\utility::_detachall();
  var0.headmodel = undefined;
  var0.changingweapon = undefined;
  var0.class = "none";
  var1 = var0 scripts\cp\cp_loadout::get_player_character_num();
  var0 thread scripts\cp\survival\survival_loadout::setmodelfromcustomization(var1);
  var2 = var0 scripts\cp\survival\survival_loadout::lookupcurrentoperatorskin(var0.team);
  var3 = var0 scripts\cp\survival\survival_loadout::getplayerfoleytype(var2);

  if(var3 == "") {
    var3 = "vestlight";
  }

  var0 setclothtype(var3);
  var0 scripts\cp\cp_loadout::updatemovespeedscale();
  var0 setsuit("iw8_suit_cp");
  var0.primaryweapon = isundefinedweapon();
  var0 scripts\cp\utility::giveperk("specialty_pistoldeath");
  var0 scripts\cp\utility::giveperk("specialty_expanded_minimap");
  var4 = var0.melee_weapon;
  var0.default_starting_melee_weapon = var4;
  var0.currentmeleeweapon = var4;
  var0 scripts\cp\classes\cp_class_progression::give_player_class();
  var0 scripts\cp\cp_loadout::set_player_perks();
  var0 setactionslot(2, "");
  var0 setactionslot(3, "altmode");
  scripts\cp\cp_munitions::reset_munitions(var0);
  var5 = var0 getplayerdata("cp", "inventorySlots", "totalSlots");

  for(var6 = 0; var6 < var5; var6++) {
    var0 scripts\cp\cp_munitions::give_munition_to_slot("none", var6);
  }

  var0.loadoutaccessoryweapon = var0 scripts\cp\cp_loadout::cac_getaccessoryweapon();
  var0.loadoutaccessorydata = var0 scripts\cp\cp_loadout::cac_getaccessorydata();
  var0.loadoutaccessorylogic = var0 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

  if(isDefined(var0.loadoutaccessorydata) && isDefined(var0.loadoutaccessoryweapon) && var0.loadoutaccessoryweapon != "none") {
    var0 scripts\cp\cp_accessories::giveplayeraccessory(var0.loadoutaccessorydata, var0.loadoutaccessoryweapon, var0.loadoutaccessorylogic);
  }

  var0.last_stand_pistol = scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911_mp", [], "none", "none", -1);

  if(level.ref_12376) {
    scripts\cp\whizby::ref_13263(self);
    return;
  }
}

function playerattractiontriggerexit() {
  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution)) {
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
    return;
  }
}

function getspawnpoint() {
  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  var0 = scripts\engine\utility::getStructArray("default_player_start", "targetname");

  if(isDefined(level.default_player_spawns)) {
    var1 = scripts\engine\utility::getStructArray(level.default_player_spawns, "targetname");

    if(var1.size > 0) {
      var0 = var1;
    }
  }

  if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    return scripts\cp\pvpe\pvpe::getassignedspawnpointbasedonteam(self);
  }

  if(scripts\cp\pvpve\pvpve::pvpve_enabled()) {
    return scripts\cp\pvpve\pvpve::getassignedspawnpointbasedonteam(self);
  }

  return getassignedspawnpoint(var0);
}

function getassignedspawnpoint(var0) {
  var1 = self getentitynumber();
  return var0[var1];
}

function update_laststand_times() {
  scripts\cp\cp_laststand::init_laststand_anims();
  var0 = level.scr_anim["ls_revive_helper"]["in_stand_1"];
  var1 = level.scr_anim["ls_revive_helper"]["idle_stand_1"];
  var2 = level.scr_anim["ls_revive_helper"]["out_stand_1"];
  var3 = getanimlength(var0);
  var4 = getanimlength(var1);
  var5 = getanimlength(var2);
  var6 = 0.5;
  var7 = (var3 + var4 + var5 + var6) * 1000;
  var8 = 5000;
  var9 = (var3 + var5 + var6) * 1000;
  scripts\cp\cp_laststand::set_revive_time(var7, var8, var9);
}