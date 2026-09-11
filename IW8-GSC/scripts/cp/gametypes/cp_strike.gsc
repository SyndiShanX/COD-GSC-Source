/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\gametypes\cp_strike.gsc
***********************************************/

function main() {
  scripts\cp\cp_globallogic::init();
  thread onplayerconnect();
  level.skip_playerhudphoto = 1;
  scripts\cp\cp_music_and_dialog::init();
  scripts\cp\utility::coop_mode_enable(["challenge", "doors", "wall_buys", "crafting", "outline", "destruction"]);
  initdefaultsettings();
  scripts\cp\cp_weapon::weaponsinit();
  level.health_scalar = 1.5;
  scripts\cp\cp_outline::outline_init();
  setomnvar("ui_hide_nameplates_for_zero_health", 0);
  scripts\cp\cp_quest::init_quest_system();
  scripts\cp\survival\survival_loadout::init();
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  dev_damage_show_damage_numbers();
  level thread scripts\cp\loot_system::init_loot();
  level thread scripts\cp\cp_interaction::coop_interaction_pregame();
  level thread scripts\cp\utility::global_physics_sound_monitor();
  level thread scripts\cp\zombies\zombieclientmatchdata::init();
  thread monitor_num_players();
  level.use_temp_bc = 1;
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
  level.no_power_cooldowns = 1;
  level.cycle_damage_scalar = 1;
  level.cycle_reward_scalar = 1;
  level.powers = [];
  level.overcook_func = [];
  level.hardcoremode = getdvarint("scr_aliens_hardcore");
  level.ricochetdamage = getdvarint("scr_aliens_ricochet");
  level.casualmode = getdvarint("scr_aliens_casual");
  level.last_loot_drop = 0;
  level.last_powers_dropped = [];
  level.cash_scalar = 1;
  level.insta_kill = 0;
  level.default_weapon = "iw8_pi_decho_mp";
  level.pap_max = 2;
  level.inventory_nag = 0;
  level.exploimpactmod = 0.1;
  level.shotgundamagemod = 0.1;
  level.armorpiercingmod = 0.2;
  level.maxlogclients = 10;
  level.in_room_check_func = &blank_func;
  level.custom_giveloadout = &givedefaultloadout;
  level.move_speed_scale = &scripts\cp\survival\survival_loadout::updatemovespeedscale;
  level.getnodearrayfunction = &getnodearray;
  level.prematchfunc = &prematchfunc;
  level.callbackplayerdamage = &scripts\cp\cp_damage::callback_playerdamage;
  level.callbackplayerkilled = &callbackplayerkilled;
  level.laststand_enter_gamemodespecificaction = &enter_laststand;
  level.enter_spectator_func = &enable_dogtag_revive;
  level.prespawnfromspectaorfunc = &prespawnfromspectatorfunc;
  level.update_money_performance = &scripts\cp\cp_core_gamescore::update_money_earned_performance;
  level.loot_drop_check_func = &blank_func;
  level.active_volume_check = &scripts\cp\utility::is_in_active_volume;
  level.laststand_exit_gamemodespecificaction = &exit_laststand_func;
  level.onplayerdisconnect = &onplayerdisconnect;
  level.endgame_write_clientmatchdata_for_player_func = &endgame_clientmatchdata;
  level.hostmigrationend = &hostmigrationend;
  level.onhostmigration = &hostmigrationstart;
  level.last_stand_hud_update = &last_stand_hud_update;
  level.game_mode_statstable = "cp/zombies/mode_string_tables/zombies_statstable.csv";
  level.game_mode_attachment_map = "cp/zombies/zombie_attachmentmap.csv";
  var0 = getDvar("NSQLTTMRMP");
  level.power_up_table = "cp/zombies/" + var0 + "_loot.csv";
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.onprecachegametype = &onprecachegametype;
  level.agent_killed_queue = [];
  level.getspawnpoint = &getspawnpoint;
  level.forcespawnsettings = 1;
  setdvarifuninitialized("enable_segmented_health_regen", 0);
  level.usehealthpacks = getdvarint("enable_segmented_health_regen", 0);
}

function is_friendly_dmg(var0, var1) {
  if(isDefined(var1)) {
    if(isDefined(var1.team) && var1.team == var0.team) {
      return true;
    }

    if(isDefined(var1.owner) && isDefined(var1.owner.team) && var1.owner.team == var0.team) {
      return true;
    }
  }

  return false;
}

function blank_func() {
  return false;
}

function waitforplayers() {
  while(!isDefined(level.players)) {
    wait 0.1;
  }
}

function exit_laststand_func(var0) {
  var0 scripts\cp\cp_powers::restore_powers(var0, var0.pre_laststand_powers);
  var0.flung = undefined;
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

  if(istrue(var0.have_permanent_perks)) {
    thread give_permanent_perks(var0);
    return;
  }
}

function give_permanent_perks(var0) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var1 = ["perk_machine_boom", "perk_machine_flash", "perk_machine_fwoosh", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_revive", "perk_machine_run", "perk_machine_smack", "perk_machine_tough", "perk_machine_zap"];

  if(isDefined(level.all_perk_list)) {
    var1 = level.all_perk_list;
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    var1 = scripts\engine\utility::array_remove(var1, "perk_machine_revive");
  }

  wait 1;

  foreach(var3 in var1) {
    if(var0 scripts\cp\utility::has_zombie_perk(var3)) {
      continue;
    }

    waitframe();
  }
}

function reset_override_visionset(var0) {
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
  scripts\cp\cp_laststand::set_revive_time(3000, 5000);
  thread init_enemy_spawner();
  thread scripts\cp\cp_traversalassist::traversal_assist_init();

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
  level.num_healthpacks = 0;
  thread checkpoint_revive();
  scripts\cp\cp_modular_spawning::init_modular_spawning();
}

function init_enemy_spawner() {
  scripts\cp\cp_spawner_scoring::spawner_scoring_init();
}

function onprecachegametype() {
  level._effect["dogtag_pickup"] = loadfx("vfx/iw7/core/zombie/vfx_zom_souvenir_pickup.vfx");
}

function handlenondeterministicentities() {
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

      var0 thread scripts\cp\cp_globallogic::player_init_health_regen();
      var0 scripts\cp\cp_persistence::session_stats_init();
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
      var0 scripts\cp\utility::allow_player_teleport(0);

      if(scripts\engine\utility::flag("introscreen_over")) {
        if(isDefined(level.custom_player_hotjoin_func)) {
          var0 thread[[level.custom_player_hotjoin_func]]();
        }
      }

      var0 scripts\cp\cp_mapselect::set_uav_radarstrength(var0);
      var0 scripts\cp\cp_persistence::lb_player_update_stat("waveNum", level.wave_num, 1);
      var0 scripts\cp\cp_wall_buys::setup_player_weapon_models(var0);
      var0 scripts\cp\cp_persistence::player_persistence_init();
      var0 thread scripts\cp\cp_analytics::init_weapon_and_player_analytics(var0);
      thread strike_player_connect_black_screen();

      if(isDefined(level.custom_onplayerconnect_func)) {
        [[level.custom_onplayerconnect_func]](var0);
      }

      if(!isDefined(level.kick_player_queue)) {
        thread kick_player_queue_loop();
      }

      thread kick_for_inactivity(var0);
    }
  }
}

function watchforluinotifyweaponreset(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("weaponplayerdatafinished");
  var1 = "cp/cp_wall_buy_models.csv";

  if(scripts\cp\utility::map_check(3)) {
    var1 = "cp/cp_town_wall_buy_models.csv";
    goto LOC_00000044;
  }

  jumpiffalse(scripts\cp\utility::map_check(2)) LOC_00000044;
  var1 = "cp/cp_disco_wall_buy_models.csv";

  for(;;) {
    var0 waittill("luinotifyserver", var2, var3);

    if(isDefined(var2)) {
      if(var2 == "reset_weapon_player_data") {
        var4 = tablelookupbyrow(var1, var3, 1);

        if(isDefined(var4)) {
          var5 = tablelookup(var1, 0, var3, 2);

          if(isDefined(var5) && var5 != "") {
            var0 setplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var5, "variantID", -1);
          }
        }

        continue;
      }

      if(var2 == "weaponplayerdatafinished") {
        var0 notify("weaponplayerdatafinished");
      }
    }
  }
}

function streamweaponsonzonechange(var0) {}

function player_hotjoin() {
  self endon("disconnect");
  self notify("intro_done");
  self notify("stop_intro");
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
  self.reboarding_points = 0;
  wait 3;
  thread reenable_zombie_emmisive();
}

function reenable_zombie_emmisive() {
  var0 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(var2 in var0) {
    if(istrue(var2.is_suicide_bomber)) {
      continue;
    } else if(istrue(var2.is_turned)) {
      continue;
    }

    var2 emissiveblend(1, 0.1);
    wait 0.05;
  }
}

function hotjoin_protection() {
  self endon("disconnect");
  self.ignoreme = 1;
  self.ability_invulnerable = 1;
  wait 8;
  self.ignoreme = 0;
  self.ability_invulnerable = undefined;
}

function onspawnplayer() {
  self.pers["gamemodeLoadout"] = level.alien_loadout;
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
  initplayeromnvars();
  thread scripts\cp\perks\cp_perks::watchcombatspeedscaler();

  if(isDefined(level.custom_onspawnplayer_func)) {
    self[[level.custom_onspawnplayer_func]]();
  }

  scripts\cp\cp_globallogic::player_init_invulnerability();
  scripts\cp\cp_globallogic::player_init_damageshield();
  var0 = get_starting_currency(self);
  thread scripts\cp\cp_persistence::wait_to_set_player_currency(var0);
  set_player_max_currency(999999);
  thread watchglproxy();
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
}

function initplayeromnvars() {
  self setclientomnvar("ui_refresh_hud", 1);
  self setclientomnvar("zm_ui_player_in_laststand", 0);
  self setclientomnvar("ui_hide_minimap", 0);
}

function add_player_to_threatbias_group() {
  for(var0 = 0; var0 < level.players.size; var0++) {
    if(self == level.players[var0]) {
      var1 = var0 + 1;

      if(var1 == 5) {
        return;
      }

      self setthreatbiasgroup("player" + var1);
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

  if(isDefined(var0.current_crafting_struct)) {
    var1.copy_crafting_struct = var0.current_crafting_struct;
    var0 scripts\cp\utility::remove_crafting_item();
  } else if(isDefined(var0.puzzle_piece)) {
    var0 scripts\cp\utility::remove_crafting_item();
  }

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

  if(isDefined(var1.copy_crafting_struct)) {
    var0.current_crafting_struct = var1.copy_crafting_struct;
    var0[[level.crafting_icon_create_func]](var0.current_crafting_struct);
  }

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
  var2 = 250000;

  foreach(var4 in var1) {
    if(distancesquared(var4.origin, var0.origin) < var2) {
      return true;
    }
  }

  return false;
}

function is_respawn_loc_near_alive_enemies(var0) {
  var1 = 250000;
  var2 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(var4 in var2) {
    if(distancesquared(var4.origin, var0.origin) < var1) {
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

function take_away_special_ammo(var0) {
  var0.special_ammo_type = undefined;
}

function prematchfunc() {
  var0 = 0;
  thread show_introscreen_text();

  if(var0 > 0) {
    var1 = wait_for_first_player_connect(level);
    wait var0 - 3;

    if(isDefined(level.postintroscreenfunc)) {
      [[level.postintroscreenfunc]]();
    }

    scripts\engine\utility::flag_set("introscreen_over");
    level notify("introscreen_over");
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
  level waittill("start_scene");
  wait 3;

  if(isDefined(level.introscreen_text_func)) {
    [[level.introscreen_text_func]]();
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

function strike_player_connect_black_screen() {
  if(isDefined(level.strike_player_connect_black_screen_fn)) {
    [[level.strike_player_connect_black_screen_fn]](self);
    return;
  }

  default_strike_player_connect_black_screen(self);
}

function default_strike_player_connect_black_screen(var0) {
  var0 endon("disconnect");
  var0 endon("stop_intro");
  var0 setclientomnvar("ui_hide_hud", 1);
  var0 disableweapons();
  var0 scripts\cp\utility::freezecontrolswrapper(1);
  var0.introscreen_overlay = newclienthudelem(self);
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

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(!scripts\engine\utility::flag("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  var0.introscreen_overlay fadeovertime(1);
  var0.introscreen_overlay.alpha = 0;
  wait 1;

  if(scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_wait("infil_complete");
  }

  var0 setclientomnvar("ui_hide_hud", 0);
  var0.introscreen_overlay destroy();
  scripts\engine\utility::flag_set("intro_gesture_done");
  var0 scripts\cp\zombies\cp_consumables::init_player_consumables();
  var0 scripts\cp\utility::freezecontrolswrapper(0);
  var0 enableweapons();
}

function melee_strength_timer() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("shock_melee_upgrade activated");
  self.meleestrength = 1;
  var0 = 1;
  self.meleestrength = 0;
  var1 = gettime();

  for(;;) {
    var2 = gettime();

    if(var2 - var1 >= level.playermeleestunregentime) {
      self.meleestrength = 1;
    } else {
      self.meleestrength = 0;
    }

    if(self meleeButtonPressed() && !self isreloading() && !self useButtonPressed()) {
      var1 = gettime();

      if(var0 == 1) {
        var0 = 0;
      }
    } else if(!self meleeButtonPressed()) {
      var0 = 1;
    } else {
      var0 = 0;
    }

    wait 0.05;
  }
}

function hasgl3weapon() {
  var0 = 0;
  var1 = self getweaponslist("primary");

  if(var1.size > 0) {
    foreach(var3 in var1) {
      if(isgl3weapon(var3)) {
        var0 = 1;
        break;
      }
    }
  }

  return var0;
}

function isgl3weapon(var0) {
  var1 = getweaponbasename(var0);

  if(!isDefined(var1)) {
    return false;
  }

  return var1 == "iw7_glprox_zm";
}

function watchglproxy() {
  self endon("death");
  self endon("disconnect");
  self endon("endExpJump");
  level endon("game_ended");
  var0 = undefined;
  self notifyonplayercommand("fired", "+attack");

  for(;;) {
    scripts\engine\utility::ref_143a6("weapon_switch_started", "weapon_change", "weaponchange");
    self notify("stop_regen_on_weapons");
    wait 0.1;
    var1 = self getweaponslistall();

    foreach(var3 in var1) {
      if(isgl3weapon(var3)) {
        var0 = 1;
        continue;
      }

      var0 = 0;
    }
  }
}

function laststandcurrencypenaltyamount(var0) {}

function callbackplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  [[level.callbackplayerlaststand]](var0, var1, var2, var4, var5, var7, var8, var9);
}

function dev_damage_show_damage_numbers() {
  if(getdvarint("zm_damage_numbers", 0) == 1) {
    setomnvar("zm_dev_damage", 1);
    return;
  }

  setomnvar("zm_dev_damage", 0);
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
  var0.pre_arcade_game_weapon = undefined;
  var0.pre_arcade_game_weapon_clip = undefined;
  var0.pre_arcade_game_weapon_stock = undefined;
  var0.former_mule_weapon = undefined;
  var0.pre_laststand_powers = var0 scripts\cp\cp_powers::get_info_for_player_powers(var0);
  var0 scripts\cp\cp_powers::clearpowers();
  var2 = var0 getcurrentweapon();
  var3 = getweaponbasename(var2);
  var4 = var0 getcurrentweaponclipammo();

  if(!isDefined(var0.downsperweaponlog[var3])) {
    var0.downsperweaponlog[var3] = 1;
  } else {
    var0.downsperweaponlog[var3]++;
  }

  var0 clearclienttriggeraudiozone(0);

  if(!self issplitscreenplayer()) {
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
}

function inventory_nag() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  var0 = 0;
  var1 = 1;

  if(!scripts\cp\utility::is_codxp()) {
    while(var0 < 3) {
      level waittill("spawn_wave_done");

      if(0 == var1 % 2 && var1 > 1) {
        foreach(var3 in level.players) {
          var3 setclientomnvar("zm_nag_text", 1);
        }

        var0 += 1;
      }

      var1 += 1;
      wait 0.5;

      foreach(var3 in level.players) {
        var3 setclientomnvar("zm_nag_text", 0);
      }
    }

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

  if(var1 == "zmb_fireworksprojectile_mp") {
    if(!isDefined(self.killswithitem[self.itemtype])) {
      self.killswithitem[self.itemtype] = 1;
    } else {
      self.killswithitem[self.itemtype]++;
    }
  }

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
    var3 = isDefined(var2.agent_type) && (var2.agent_type == "zombie_brute" || var2.agent_type == "zombie_grey" || var2.agent_type == "superslasher" || var2.agent_type == "slasher" || var2.agent_type == "zombie_ghost");

    if(!var3 && !var2 scripts\cp\utility::agentisinstakillimmune()) {
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
    }

    var2.scripted_mode = 1;
    var2 scragentsetgoalpos(var2.origin);
    var2.ignoreme = 1;
    var2.ignoreall = 1;
  }
}

function hostmigrationend() {
  thread resetplayerhud();
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
  foreach(var1 in level.players) {}
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
        LOC_00000192:
      }
      LOC_00000192:
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

function armor_meter_monitor(var0) {
  var0 endon("disconnect");
  level endon("game_ended");
  wait 1;

  for(;;) {
    if(isDefined(var0.armoramount)) {
      var0 setclientomnvar("zm_player_armor", var0.armoramount);
    }

    waitframe();
  }
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

function enable_dogtag_revive(var0) {
  var1 = spawn("script_model", var0.origin + (0, 0, 40));
  var1 setModel("dogtags_iw7_friend");
  var1 makeusable();
  thread rotate_tags();
  var1 setHintString(&"COOP_GAME_PLAY/REVIVE_USE");
  var1 endon("death");
  var0.respawn_forcespawnorigin = var0.origin;
  var0.respawn_forcespawnangles = (0, 0, 0);
  var0.dogtag = var1;
  var0.dogtag.owner = var0;
  scripts\cp\cp_laststand::makereviveicon(var1, var0, (1, 0, 0));
  thread revivetriggerthink(var1);
  thread endreviveonownerdeathordisconnect();
}

function rotate_tags() {
  self endon("death");

  for(;;) {
    self rotateYaw(30, 0.5);
    wait 0.5;
  }
}

function revivetriggerthink(var0) {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var2 = scripts\cp\utility::player_lua_progressbar(var1, 8000, 9216, 5);

    if(!var2) {
      continue;
    }

    break;
  }

  playFX(level._effect["dogtag_pickup"], self.origin);
  playsoundatpos(self.origin, "zmb_item_pickup");
  var0 scripts\cp\cp_laststand::instant_revive(var0);
  var0 notify("last_stand_finished");
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
  self waittill("loadout_given");

  if(!isDefined(self.starting_skillpoints_given)) {
    scripts\cp\classes\cp_class_progression::give_skill_points(4);
    self.starting_skillpoints_given = 1;
    return;
  }
}

function givedefaultloadout(var0, var1) {
  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(isDefined(self.weaponlist)) {
    restore_player_weapons_after_bleedout(self);
  }

  scripts\cp\survival\survival_loadout::givedefaultloadout(var0, var1);
}

function getspawnpoint() {
  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  return getassignedspawnpoint(scripts\engine\utility::getStructArray("default_player_start", "targetname"));
}

function getassignedspawnpoint(var0) {
  var1 = self getentitynumber();
  return var0[var1];
}

function allow_nvg() {
  if(istrue(level.disable_nvg)) {
    return false;
  }

  return true;
}