/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6425d54af3cd5a44.gsc
*************************************************/

#using script_4a6760982b403bad;
#using script_6425d54af3cd5a44;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\calloutmarkerping_cp;
#using scripts\cp\coop_personal_ents;
#using scripts\cp\cp_achievement;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_awards;
#using scripts\cp\cp_core_gamescore;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_hud_util;
#using scripts\cp\cp_mapselect;
#using scripts\cp\cp_outline;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\cp_spawner_scoring;
#using scripts\cp\endgame;
#using scripts\cp\equipment;
#using scripts\cp\equipment\nvg;
#using scripts\cp\globallogic;
#using scripts\cp\infilexfil\lbravo_infil_cp;
#using scripts\cp\interaction;
#using scripts\cp\laststand;
#using scripts\cp\loot_system;
#using scripts\cp\perks\cp_perk_utility;
#using scripts\cp\perks\cp_perks;
#using scripts\cp\persistence;
#using scripts\cp\spawning;
#using scripts\cp\survival\survival_loadout;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp\zombies\zombieclientmatchdata;
#using scripts\cp_mp\auto_ascender;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#namespace cp_survival;

function main() {
  level.var_59c3f456a9e5d4f0 = &scripts\cp\interaction::init;
  scripts\cp\globallogic::init();
  level thread onplayerconnect();
  level.skip_playerhudphoto = 1;
  level.fnoffhandfire = &scripts\cp\weapon::ai_offhandfiremanager;
  coop_mode_enable(["loot_system"]);
  initdefaultsettings();
  scripts\cp\weapon::weaponsinit();
  level.health_scalar = 1.5;
  scripts\cp\cp_outline::outline_init();
  setomnvar("ui_hide_nameplates_for_zero_health", 0);
  scripts\cp\survival\survival_loadout::init();
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  level thread scripts\cp\loot_system::init_loot();
  level thread scripts\cp\utility::global_physics_sound_monitor();
  level thread scripts\cp\zombies\zombieclientmatchdata::init();
  level thread monitor_num_players();
  level.use_temp_bc = 1;
  create_player_threatbias_groups();

  level thread function_af9055152e36c41f();

  scripts\cp\globallogic::function_d98e304dd9d5d8cd();
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
  flag_init("insta_kill");
  flag_init("introscreen_over");
  flag_init("infil_complete");
  flag_init("intro_gesture_done");
  flag_init("pre_game_over");
  flag_init("interactions_initialized");
  flag_init("zombie_drop_powerups");
  flag_init("init_interaction_done");
  flag_init("strike_init_done");
  flag_init("create_script_initialized");
  flag_init("ready_for_devgui");
  flag_init("stealth_enabled");
  flag_init("stealth_spotted");
  level.wave_num = 1;
  level.cycle_reward_scalar = 1;
  level.cash_scalar = 1;
  level.powers = [];
  level.overcook_func = [];
  level.tier1modeenabled = getdvarint(@ "hash_7026ceffe6e03f2d");
  level.default_weapon = "iw8_pi_decho_mp";
  level.pap_max = 2;

  if(getdvarint(@ "hash_302b919208fafa", 0) <= 0) {
    setDvar(@ "bg_falldamageminheight", 560);
    setDvar(@ "bg_falldamagemaxheight", 561);
    setDvar(@ "hash_180a6f432cfb6644", 560);
    setDvar(@ "hash_5dfbfd642e45b4b2", 561);
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
  level.callbackplayerkilled = &callbackplayerkilled;
  level.onplayerdisconnect = &onplayerdisconnect;
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.onprecachegametype = &onprecachegametype;
  level.laststand_enter_gamemodespecificaction = &enter_laststand;
  level.enter_spectator_func = &enable_dogtag_revive;
  level.prespawnfromspectatorfunc = &prespawnfromspectatorfunc;
  level.laststand_exit_gamemodespecificaction = &exit_laststand_func;
  level.last_stand_hud_update = &last_stand_hud_update;
  level.getspawnpoint = &getspawnpoint;
  level.update_money_performance = &scripts\cp\cp_core_gamescore::update_money_earned_performance;
  level.active_volume_check = &scripts\cp\utility::is_in_active_volume;
  level.endgame_write_clientmatchdata_for_player_func = &endgame_clientmatchdata;
  level.hostmigrationend = &hostmigrationend;
  level.onhostmigration = &hostmigrationstart;
  level.game_mode_statstable = "cp/zombies/mode_string_tables/zombies_statstable.csv";
  mapname = getDvar(@ "ui_mapname");
  level.power_up_table = "cp/zombies/" + mapname + "_loot.csv";
}

function exit_laststand_func(player) {
  player scripts\cp\equipment::restore_equipment();
  player setclientomnvar("ui_is_laststand", 0);
  player clearclienttriggeraudiozone(0.3);
  player playlocalsound("deaths_door_out");
  player stoplocalsound("deaths_door_in");

  if(isDefined(level.vision_set_override)) {
    player thread reset_override_visionset(0.2);
  }

  var_a91c50e065b4bebe = randomintrange(1, 5);
  var_56f3ccde65af5b46 = "zmb_revive_music_lr_0" + var_a91c50e065b4bebe;
  player playlocalsound_safe(var_56f3ccde65af5b46);
  player allow_player_ignore_me(0);

  if(is_raid_gamemode() && !istrue(level.dogtag_revive)) {
    player skydive_setbasejumpingstatus(0);
    player skydive_setdeploymentstatus(0);
  }
}

function reset_override_visionset(timer) {
  level endon("game_ended");
  self endon("disconnect");
  wait timer;

  if(isDefined(level.vision_set_override)) {
    level notify("vision_set_change_request", level.vision_set_override, self, 0.1);
  }
}

function onstartgametype() {
  scripts\cp\utility::set_segmented_health_regen_parameters(100, 100, 25, 2, 1, 0.05);
  scripts\cp\persistence::register_eog_to_lb_playerdata_mapping();
  scripts\cp\cp_analytics::initlevelvars();
  thread update_laststand_times();
  level thread init_enemy_spawner();
  level.ascendermsgfunc = &ascendermsgfunc;
  thread scripts\cp_mp\auto_ascender::init();
  thread scripts\cp_mp\ent_manager::init();
  level scripts\cp\calloutmarkerping_cp::calloutmarkerping_init();

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

  level.spawnloopupdatefunc = &scripts\cp\spawning::update_spawn_data_on_death;
  scripts\cp\persistence::rank_init();
  level thread handlenondeterministicentities();
  level thread scripts\cp\laststand::checkpoint_revive();
  scripts\cp\spawning::spawning_init();
  thread scripts\cp\cp_outofbounds::initoob();

  if(level.gametype == "cp_survival") {
    for(i = 0; i < level.players.size; i++) {
      level.players[i] setclientomnvar("ui_session_state", "spectator");
    }
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
}

function handlenondeterministicentities() {
  level endon("game_ended");
  wait 5;
  level notify("spawn_nondeterministic_entities");

  if(isDefined(level.post_nondeterministic_func)) {
    level thread[[level.post_nondeterministic_func]]();
  }
}

function onplayerconnect() {
  while(true) {
    level waittill("connected", player);

    if(!isai(player)) {
      player scripts\cp\cp_analytics::on_player_connect();
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_player_first_connect", player);

      if(isDefined(player.connecttime)) {
        player.connect_time = player.connecttime;
      } else {
        player.connect_time = gettime();
      }

      player.xpscale = getdvarint(@ "hash_e45cd6a1e800f0a8");
      player.weaponxpscale = getdvarint(@ "hash_1f4c0cfafb6305d8");

      if(player rankingenabled()) {
        var_69a07d6024aeb70b = getdvarint(@ "hash_70f2982f5218f87d");
        partyxpscale = getdvarint(@ "hash_505d6d408c8b40d2");
        isinparty = player getprivatepartysize() > 1;

        if(isDefined(var_69a07d6024aeb70b)) {
          if(isinparty && var_69a07d6024aeb70b > 1) {
            player.weaponxpscale = var_69a07d6024aeb70b;
          }
        }

        if(isDefined(partyxpscale)) {
          if(isinparty && partyxpscale > 1) {
            player.xpscale = partyxpscale;
          }
        }
      }

      if(istrue(player getplayerdata("cp", "tacOpsAchievements", "LANDLORD")) && istrue(player getplayerdata("cp", "tacOpsAchievements", "ARMED")) && istrue(player getplayerdata("cp", "tacOpsAchievements", "SMUGGLED")) && istrue(player getplayerdata("cp", "tacOpsAchievements", "LAUNDERED"))) {
        player thread scripts\cp\cp_awards::give_operator_based_on_task("all_operations");
      }

      player thread scripts\cp\globallogic::player_init_health_regen();
      player scripts\cp\persistence::session_stats_init();
      player.num_of_plays = [];
      player.nextcasheffecttime = 0;
      player.total_currency_earned = 0;
      player.can_give_revive_xp = 1;
      player.pap = [];
      player.powerupicons = [];
      player.powers = [];
      player.powers_active = [];
      player.disabled_interactions = [];
      player.onkillweaponpassives = [];
      player.onuseweaponpassives = [];
      player.ondamageweaponpassives = [];
      player.disabledteleportation = 0;
      player.disabledinteractions = 0;
      player.power_cooldowns = 0;
      player.tickets_earned = 0;
      player.time_to_give_next_tickets = gettime();
      player.self_revives_purchased = 0;
      player.max_self_revive_machine_use = 3;
      player.cash_scalar = 1;
      player.recentkillcount = 0;
      player.enabledignoreme = 0;
      player.infiniteammocounter = 0;
      player.awarenessadjustment = 0;
      player allow_player_teleport(0);
      player.achievement_registration_func = &scripts\cp\cp_achievement::register_default_achievements;
      player scripts\cp\cp_achievement::init_player_achievements(player);
      player.spawntimestamp = player.connect_time;
      player scripts\cp\cp_mapselect::set_uav_radarstrength(player);
      player scripts\cp\persistence::lb_player_update_stat("waveNum", level.wave_num, 1);
      player scripts\cp\persistence::player_persistence_init();
      player thread scripts\cp\cp_analytics::init_weapon_and_player_analytics(player);

      if(isDefined(level.fnhidefoundintel)) {
        player thread[[level.fnhidefoundintel]]();
      }

      player.gameskill = scripts\cp\cp_gameskill::get_gameskill();
      player scripts\cp\cp_gameskill::set_difficulty_from_locked_settings();
      player thread strike_player_connect_black_screen();
      player.timeplayed = [];

      foreach(team in level.teamnamelist) {
        player.timeplayed[team] = 0;
      }

      player.timeplayed["total"] = 0;
      player.timeplayed["missionTeam"] = 0;
      player.timeplayed["other"] = 0;
      player.timeplayed["timeDead"] = 0;
      player scripts\cp_mp\calloutmarkerping::calloutmarkerping_initplayer();

      if(flag("introscreen_over")) {
        if(isDefined(level.custom_player_hotjoin_func)) {
          player thread[[level.custom_player_hotjoin_func]]();
        }

        if(isDefined(level.hacking_lua_notify_func)) {
          player thread[[level.hacking_lua_notify_func]]();
        }
      }

      if(isDefined(level.custom_onplayerconnect_func)) {
        [[level.custom_onplayerconnect_func]](player);
      }

      if(!isDefined(level.kick_player_queue)) {
        level thread kick_player_queue_loop();
      }

      player thread kick_for_inactivity(player);
      player thread mission_jumpto_debug();
    }
  }
}

function mission_jumpto_debug() {
  level endon("game_ended");

  while(true) {
    self waittill("luinotifyserver", channel, index);

    if(channel == "mission_jump") {
      map_name = getDvar(@ "ui_mapname");
      objective_table = "cp/" + map_name + "_objectives.csv";
      objective_ref = tablelookup(objective_table, 0, index, 1);
      mission_dvar = hashcat(@ "hash_287b3b75f2c14fe9", map_name);
      setdvarifuninitialized(mission_dvar, objective_ref);
      setDvar(mission_dvar, objective_ref);
      scripts\cp\endgame::restart_map();
    }
  }
}

function team_slot_assignment_available_from_player_disconnect() {
  return level.disconnect_player_team_slot_assignment.size > 0;
}

function get_team_slot_assignment_from_player_disconnect() {
  var_1e30431586bfe80f = level.disconnect_player_team_slot_assignment[0];
  level.disconnect_player_team_slot_assignment = scripts\engine\utility::array_remove(level.disconnect_player_team_slot_assignment, var_1e30431586bfe80f);
  return var_1e30431586bfe80f;
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
  println("<dev string:x1c>");

  if(isDefined(level.wave_num)) {
    self.wave_num_when_joined = level.wave_num;
  }

  map_name = getDvar(@ "ui_mapname");
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);
  wait 3;
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 3);

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

function onspawnplayer(fauxspawn) {
  self.fireshield = 0;
  self.isreviving = 0;
  self.iscarrying = 0;
  self.burning = undefined;
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
  val::nuke_all();
  scripts\cp_mp\utility\damage_utility::cleardamagemodifiers();
  thread scripts\cp\perks\cp_perks::watchcombatspeedscaler();

  if(isDefined(level.custom_onspawnplayer_func)) {
    self[[level.custom_onspawnplayer_func]]();
  }

  if(istrue(level.parachutecancutautodeploy)) {
    self skydive_cutautodeployon();
  } else {
    self skydive_cutautodeployoff();
  }

  if(istrue(level.parachutecancutparachute)) {
    self skydive_cutparachuteon();
  } else {
    self skydive_cutparachuteoff();
  }

  scripts\cp\globallogic::player_init_invulnerability();
  scripts\cp\globallogic::player_init_damageshield();
  starting_currency = get_starting_currency(self);
  thread scripts\cp\persistence::wait_to_set_player_currency(starting_currency);
  set_player_max_currency(999999);
  thread scripts\cp\cp_hud_util::zom_player_health_overlay_watcher();

  thread add_player_to_threatbias_group();
  thread scripts\cp\coop_personal_ents::assignpersonalmodelents(self);
  thread scripts\cp\coop_personal_ents::movepentstostructs(self);
  thread give_skillpoints_at_start();

  if(function_6aafbdd00b977115()) {
    thread scripts\cp\equipment\nvg::runnvg();
  }

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  force_usability_enabled();
  self setclientomnvar("ui_hide_minimap", 1);

  if(isDefined(level.devgui_setup_func)) {
    self thread[[level.devgui_setup_func]](self);
  }
}

function add_player_to_threatbias_group() {
  for(i = 0; i < level.players.size; i++) {
    if(self == level.players[i]) {
      group_num = i + 1;

      if(group_num == 5) {
        return;
      }

      self setthreatbiasgroup("player" + group_num);
    }
  }
}

function get_starting_currency(player) {
  starting_currency_after_revived_from_spectator = player.starting_currency_after_revived_from_spectator;

  if(isDefined(starting_currency_after_revived_from_spectator)) {
    player.starting_currency_after_revived_from_spectator = undefined;
    return starting_currency_after_revived_from_spectator;
  }

  return scripts\cp\persistence::get_starting_currency();
}

function set_player_max_currency(amount) {
  amount = int(amount);
  self.maxcurrency = amount;
}

function prespawnfromspectatorfunc(player) {
  player.starting_currency_after_revived_from_spectator = player scripts\cp\persistence::get_player_currency();
  revivefromspectatorweaponsetup(player);
  set_spawn_loc(player);
}

function revivefromspectatorweaponsetup(player) {
  weaponlist = spawnStruct();
  weaponlist.copy_fullweaponlist = player.copy_fullweaponlist;
  weaponlist.copy_weapon_current = player.copy_weapon_current;
  weaponlist.copy_weapon_ammo_clip = player.copy_weapon_ammo_clip;
  weaponlist.copy_weapon_ammo_stock = player.copy_weapon_ammo_stock;

  if(isDefined(player.saved_last_stand_pistol)) {
    weaponlist.last_stand_pistol = player.saved_last_stand_pistol;
    player.saved_last_stand_pistol = undefined;
  } else {
    weaponlist.last_stand_pistol = player.last_stand_pistol;
  }

  weaponlist.weapon_levels = player.copy_weapon_level;

  if(isDefined(player.current_crafted_inventory)) {
    weaponlist.current_crafted_inventory = player.current_crafted_inventory;
    player.current_crafted_inventory = undefined;
  }

  weaponlist.copy_all_powers = player.pre_laststand_powers;
  weaponlist.copy_special_ammo_type = player.special_ammo_type;
  player.weaponlist = weaponlist;
}

function restore_player_weapons_after_bleedout(player) {
  player notify("weapon_purchased");
  weaponlist = player.weaponlist;
  player takeallweapons();
  player.copy_fullweaponlist = weaponlist.copy_fullweaponlist;
  player.copy_weapon_current = weaponlist.copy_weapon_current;
  player.copy_weapon_ammo_clip = weaponlist.copy_weapon_ammo_clip;
  player.copy_weapon_ammo_stock = weaponlist.copy_weapon_ammo_stock;
  player.copy_all_powers = weaponlist.copy_all_powers;
  player.copy_weapon_level = weaponlist.weapon_levels;
  player scripts\cp\utility::restore_primary_weapons_only();
  player scripts\cp\utility::restore_super_weapon();
  player scripts\cp\equipment::restore_equipment();

  if(isDefined(weaponlist.current_crafted_inventory)) {
    level thread[[weaponlist.current_crafted_inventory.restore_func]](undefined, player);
  }

  player.special_ammo_type = weaponlist.copy_special_ammo_type;
  player.have_things_in_lost_and_found = 0;
  player.last_stand_pistol = weaponlist.last_stand_pistol;
  player.weaponlist = undefined;
}

function set_spawn_loc(player) {
  spawnpoint = getplayerrespawnloc(player);
  player.forcespawnorigin = spawnpoint.origin;
  player.forcespawnangles = spawnpoint.angles;

  if(isDefined(player.respawn_forcespawnorigin)) {
    player.forcespawnorigin = player.respawn_forcespawnorigin;
  }

  if(isDefined(player.respawn_forcespawnangles)) {
    player.forcespawnangles = player.respawn_forcespawnangles;
  }
}

function getplayerrespawnloc(downed_player) {
  if(isDefined(level.force_respawn_location)) {
    return [[level.force_respawn_location]](downed_player);
  }

  if(!isDefined(level.active_player_respawn_locs) || level.active_player_respawn_locs.size == 0 || level.players.size == 0) {
    return [[level.getspawnpoint]]();
  }

  if(isDefined(level.respawn_loc_override_func)) {
    return [[level.respawn_loc_override_func]](downed_player);
  }

  var_28e11b47827da015 = get_available_players(downed_player);
  available_respawn_locs = get_available_respawn_locs(var_28e11b47827da015);

  if(available_respawn_locs.size == 0) {
    return get_respawn_loc_near_team_center(downed_player, var_28e11b47827da015);
  }

  if(available_respawn_locs.size == 1) {
    return available_respawn_locs[0];
  }

  return downed_player get_respawn_loc_rated(var_28e11b47827da015, available_respawn_locs);
}

function get_available_players(downed_player) {
  var_28e11b47827da015 = [];

  foreach(player in level.players) {
    if(player == downed_player) {
      continue;
    }

    if(scripts\cp\laststand::player_in_laststand(player)) {
      continue;
    }

    var_28e11b47827da015[var_28e11b47827da015.size] = player;
  }

  return var_28e11b47827da015;
}

function get_available_respawn_locs(var_28e11b47827da015) {
  available_respawn_locs = [];

  foreach(var_c337fc4166b34662 in level.active_player_respawn_locs) {
    if(!canspawn(var_c337fc4166b34662.origin)) {
      continue;
    }

    if(positionwouldtelefrag(var_c337fc4166b34662.origin)) {
      continue;
    }

    if(is_respawn_loc_near_available_players(var_c337fc4166b34662, var_28e11b47827da015)) {
      continue;
    }

    if(is_respawn_loc_near_alive_enemies(var_c337fc4166b34662)) {
      continue;
    }

    available_respawn_locs[available_respawn_locs.size] = var_c337fc4166b34662;
  }

  return available_respawn_locs;
}

function is_respawn_loc_near_available_players(respawn_loc, var_28e11b47827da015) {
  foreach(var_b2143e1339865ce4 in var_28e11b47827da015) {
    if(distancesquared(var_b2143e1339865ce4.origin, respawn_loc.origin) < 250000) {
      return true;
    }
  }

  return false;
}

function is_respawn_loc_near_alive_enemies(respawn_loc) {
  alive_enemies = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(alive_enemy in alive_enemies) {
    if(distancesquared(alive_enemy.origin, respawn_loc.origin) < 250000) {
      return true;
    }
  }

  return false;
}

function get_respawn_loc_near_team_center(downed_player, var_28e11b47827da015) {
  team_x = 0;
  team_y = 0;
  team_z = 0;
  counter = 0;

  foreach(player in var_28e11b47827da015) {
    team_x += player.origin[0];
    team_y += player.origin[1];
    team_z += player.origin[2];
    counter++;
  }

  if(counter == 0) {
    team_x = 487;
    team_y = 3089;
    team_z = 11;
    counter = 1;
  }

  team_center = (team_x / counter, team_y / counter, team_z / counter);
  var_2d6c745afab7a7b1 = sortbydistance(level.active_player_respawn_locs, team_center);
  return var_2d6c745afab7a7b1[0];
}

function get_respawn_loc_rated(var_28e11b47827da015, available_respawn_locs) {
  var_6e1f6c61482c7506 = ter_op(var_28e11b47827da015.size == 0, 1, var_28e11b47827da015.size);
  var_5408a7783ca52166 = level.spawned_enemies.size / var_6e1f6c61482c7506;
  var_620c96a13d50e7bd = var_5408a7783ca52166 * 2;
  var_a7b39f36afad5914 = -99999999;
  var_d024cacec9d41efd = undefined;

  foreach(var_fdf23b2021e21ba2 in available_respawn_locs) {
    var_2cec23ddabf59363 = 0;

    foreach(player in var_28e11b47827da015) {
      if(player == self) {
        continue;
      }

      if(!isalive(player)) {
        continue;
      }

      if(istrue(player.inlaststand)) {
        var_2cec23ddabf59363 -= distancesquared(player.origin, var_fdf23b2021e21ba2.origin) * var_620c96a13d50e7bd * 2;
        continue;
      }

      var_2cec23ddabf59363 -= distancesquared(player.origin, var_fdf23b2021e21ba2.origin) * var_620c96a13d50e7bd;
    }

    foreach(spawned_enemy in level.spawned_enemies) {
      var_2cec23ddabf59363 += distancesquared(spawned_enemy.origin, var_fdf23b2021e21ba2.origin);
    }

    var_2cec23ddabf59363 /= 1000000;

    if(var_2cec23ddabf59363 > var_a7b39f36afad5914) {
      var_a7b39f36afad5914 = var_2cec23ddabf59363;
      var_d024cacec9d41efd = var_fdf23b2021e21ba2;
    }
  }

  if(!isDefined(var_d024cacec9d41efd)) {
    println("<dev string:x74>");
  }

  return var_d024cacec9d41efd;
}

function prematchfunc() {
  prematchperiod = 0;

  if(prematchperiod > 0) {
    player = level wait_for_first_player_connect();
    wait prematchperiod - 3;

    if(isDefined(level.postintroscreenfunc)) {
      [[level.postintroscreenfunc]]();
    }

    flag_set("introscreen_over");
    level.introscreen_done = 1;
  } else {
    wait 2;

    if(flag("infil_complete")) {
      wait 2;
    }

    level.introscreen_done = 1;
    flag_set("introscreen_over");
  }

  if(istrue(level.intermission)) {
    return;
  }
}

function show_introscreen_text() {
  map_name = getDvar(@ "ui_mapname");
  obj_ref = getDvar(hashcat(@ "hash_287b3b75f2c14fe9", map_name), "");
  objective_table = "cp/" + map_name + "_objectives.csv";
  objective_index = int(tablelookup(objective_table, 1, obj_ref, 0));

  if(isDefined(obj_ref) && obj_ref != "") {
    self setclientomnvar("ui_hide_hud", 0);
    self setclientomnvar("ui_chyron_mission_index", objective_index);
    self setclientomnvar("ui_chyron_on", 1);
  }
}

function wait_for_first_player_connect() {
  player = undefined;

  if(level.players.size == 0) {
    level waittill("connected", player);
  } else {
    player = level.players[0];
  }

  return player;
}

function strike_player_connect_black_screen() {
  if(isDefined(level.strike_player_connect_black_screen_fn)) {
    [[level.strike_player_connect_black_screen_fn]](self);
    return;
  }

  default_strike_player_connect_black_screen(self);
}

function default_strike_player_connect_black_screen(player) {
  player endon("disconnect");
  player endon("stop_intro");
  player setclientomnvar("ui_hide_hud", 1);
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0);
  player waittill("spawned");
  player scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
  player disableweapons();
  player freezecontrolswrapper(1);

  if(istrue(player.ishotjoiningplayer)) {
    player show_introscreen_text();

    if(flag_exist("strike_init_done")) {
      flag_wait("strike_init_done");
    }

    if(!flag("introscreen_over")) {
      flag_wait("introscreen_over");
    }

    wait 1;
    player setclientomnvar("ui_hide_hud", 1);
    player setclientomnvar("ui_chyron_on", 0);
    player setclientomnvar("ui_chyron_mission_index", 0);
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 4);
    wait 2;
    player freezecontrolswrapper(0);
    player enableweapons();
    player setclientomnvar("ui_hide_hud", 0);
    scripts\cp\globallogic::refreshuimatchinprogressomnvarvalue();
  } else {
    if(isDefined(level.player_controls_failsafe)) {
      player thread[[level.player_controls_failsafe]]();
    }

    player show_introscreen_text();

    if(flag_exist("strike_init_done")) {
      flag_wait("strike_init_done");
    }

    if(!flag("introscreen_over")) {
      flag_wait("introscreen_over");
    }

    wait 6;
    player setclientomnvar("ui_hide_hud", 1);
    player setclientomnvar("ui_chyron_on", 0);
    player setclientomnvar("ui_chyron_mission_index", 0);
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 4);
    wait 2;
    player freezecontrolswrapper(0);
    player enableweapons();
    player setclientomnvar("ui_hide_hud", 0);
    scripts\cp\globallogic::refreshuimatchinprogressomnvarvalue();
  }

  player scripts\cp_mp\utility\player_utility::function_6fb380927695ee76();
}

function playerinfildisabled(player) {
  return istrue(player.infil_disabled);
}

function callbackplayerkilled(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime) {
  [[level.callbackplayerlaststand]](einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime);
}

function enter_laststand(player, attacker) {
  player scripts\cp\persistence::eog_player_update_stat("downs", 1);
  player scripts\cp\cp_analytics::log_event("dropped_to_last_stand", 1, [player.clientid], [player.clientid], [player.clientid]);
  player.pre_arcade_game_weapon = undefined;
  player.pre_arcade_game_weapon_clip = undefined;
  player.pre_arcade_game_weapon_stock = undefined;
  player.former_mule_weapon = undefined;
  player scripts\cp\equipment::store_equipment();
  player scripts\cp_mp\equipment::clearallequipment();
  currentweapon = player getcurrentweapon();
  currentweapon_name = getweaponbasename(currentweapon);
  var_6a3b7f7386ab3be8 = player getcurrentweaponclipammo();

  if(!isDefined(player.downsperweaponlog[currentweapon_name])) {
    player.downsperweaponlog[currentweapon_name] = 1;
  } else {
    player.downsperweaponlog[currentweapon_name]++;
  }

  player clearclienttriggeraudiozone(0);

  if(!self issplitscreenplayer()) {
    player setclienttriggeraudiozonepartialwithfade("last_stand_cp", 0.02, "mix", "reverb", "filter");
  }

  have_self_revive = player has_auto_revive();

  if(have_self_revive) {
    var_f4a1f546fffcd5e4 = isplayingsolo() || level.only_one_player;
    player notify("player_has_self_revive", var_f4a1f546fffcd5e4);
  }

  if(isDefined(player.mule_weapon) && !istrue(player.playing_ghosts_n_skulls)) {
    player.former_mule_weapon = player.mule_weapon;
  } else {
    player.former_mule_weapon = undefined;
  }

  player allow_player_ignore_me(1);
  player setclientomnvar("ui_is_laststand", 1);
}

function updaterecentkills(victim, weapon) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.recentkillcount++;
  currentweapon_name = getweaponbasename(weapon);

  if(!isDefined(self.killsperweaponlog[currentweapon_name])) {
    self.killsperweaponlog[currentweapon_name] = 1;
  } else {
    self.killsperweaponlog[currentweapon_name]++;
  }

  if(!isDefined(self.recentkillsperweapon)) {
    self.recentkillsperweapon = [];
  }

  if(!isDefined(self.recentkillsperweapon[weapon])) {
    self.recentkillsperweapon[weapon] = 1;
  } else {
    self.recentkillsperweapon[weapon]++;
  }

  weaponinfo = getequipmenttype(weapon);
  wait 1.25;
  self.recentkillcount = 0;
  self.recentkillsperweapon = undefined;
}

function onplayerdisconnect(var_2421296ba8ccb5ee, reason) {
  var_2421296ba8ccb5ee setplayerdata("cp", "CPSession", "subParty", -1);
  scripts\cp\persistence::eog_update_on_player_disconnect(var_2421296ba8ccb5ee);
}

function endgame_clientmatchdata(player, player_index) {}

function hostmigrationstart() {
  alive_enemies = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(zombie in alive_enemies) {
    if(istrue(zombie.scripted_mode)) {
      println("<dev string:x96>");
      zombie.died_poorly = 1;
      zombie suicide();
      continue;
    }

    if(istrue(zombie.ignoreme)) {
      println("<dev string:xa4>");
      zombie.died_poorly = 1;
      zombie suicide();
      continue;
    }

    if(istrue(zombie.ignoreall)) {
      println("<dev string:xad>");
      zombie.died_poorly = 1;
      zombie suicide();
      continue;
    }

    if(!istrue(zombie.entered_playspace)) {
      print("<dev string:xb7>");

      zombie.died_poorly = 1;
      zombie suicide();
      continue;
    }

    zombie.scripted_mode = 1;
    zombie setgoalpos(zombie.origin);
    zombie.ignoreme = 1;
    zombie.ignoreall = 1;
  }
}

function hostmigrationend() {
  alive_enemies = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(zombie in alive_enemies) {
    zombie.scripted_mode = 0;
    zombie.ignoreme = 0;
    zombie.ignoreall = 0;
  }

  if(isDefined(level.customhostmigrationend)) {
    level thread[[level.customhostmigrationend]]();
  }
}

function kick_for_inactivity(player) {
  level endon("game_ended");
  player endon("disconnect");
  input_has_happened = 0;
  var_a375f55fcb7b1c80 = gettime();
  var_47309ab08fa928a9 = level.onlinegame && !getdvarint(@ "xblive_privatematch");

  if(!var_47309ab08fa928a9) {
    return;
  }

  player thread check_for_move_change();
  player thread check_for_movement();
  player notifyonplayercommand("inputReceived", "+speed_throw");
  player notifyonplayercommand("inputReceived", "+stance");
  player notifyonplayercommand("inputReceived", "+goStand");
  player notifyonplayercommand("inputReceived", "+usereload");
  player notifyonplayercommand("inputReceived", "+activate");
  player notifyonplayercommand("inputReceived", "+melee_zoom");
  player notifyonplayercommand("inputReceived", "+breath_sprint");
  player notifyonplayercommand("inputReceived", "+attack");
  player notifyonplayercommand("inputReceived", "+frag");
  player notifyonplayercommand("inputReceived", "+smoke");
  time = 120;
  timestep = 0.1;

  for(;;) {
    result = waittill_any_timeout_no_endon_death_2(timestep, "inputReceived", "currency_earned");

    if(gettime() - var_a375f55fcb7b1c80 < 30000) {
      continue;
    }

    if(getdvarint(@ "hash_cf4556054ad4b032", 0)) {
      input_has_happened = 1;
      time = 120;
      continue;
    }

    if(result != "timeout") {
      time = 120;
      input_has_happened = 1;
      continue;
    }

    if(!istrue(player.in_afterlife_arcade) && !istrue(player.inlaststand)) {
      time -= timestep;
    }

    if(time < 0) {
      if(input_has_happened) {
        input_has_happened = 0;
        continue;
      }

      add_to_kick_queue(player);
    }
  }
}

function check_for_movement() {
  level endon("game_ended");
  self endon("disconnect");
  var_f20ce68135a2ba2c = self getnormalizedmovement();
  var_a375f55fcb7b1c80 = gettime();

  for(;;) {
    wait 0.2;
    var_8929332b64537b53 = self getnormalizedmovement();

    if(var_8929332b64537b53[0] == var_f20ce68135a2ba2c[0] && var_8929332b64537b53[1] == var_f20ce68135a2ba2c[1]) {
      if(gettime() - var_a375f55fcb7b1c80 > 90000) {
        add_to_kick_queue(self);
      }

      continue;
    }

    self notify("inputReceived");
    return;
  }
}

function add_to_kick_queue(player) {
  if(scripts\cp\laststand::player_in_laststand(player)) {
    return;
  }

  if(istrue(player.immune_against_kick_for_inactivity)) {
    return;
  }

  if(!array_contains(level.kick_player_queue, player)) {
    level.kick_player_queue = array_add_safe(level.kick_player_queue, player);
  }
}

function kick_player_queue_loop() {
  level endon("game_ended");
  level.kick_player_queue = [];

  while(true) {
    if(getdvarint(@ "hash_cf4556054ad4b032", 0)) {
      wait 0.1;
      continue;
    }

    if(level.kick_player_queue.size > 0) {
      foreach(player in level.kick_player_queue) {
        if(!isDefined(player)) {
          continue;
        }

        player thread delay_kick_inactive_player(player);
      }

      level.kick_player_queue = [];
    }

    wait 0.1;
  }
}

function delay_kick_inactive_player(player) {
  level endon("game_ended");
  self endon("disconnect");
  var_3e9f2bc33c97b138 = 10;

  if(istrue(player.being_kicked_from_inactivity)) {
    return;
  }

  player.being_kicked_from_inactivity = 1;
  player sethudtutorialmessage(&"COOP_GAME_PLAY/KICK_FOR_INACTIVITY", 1);
  player setclientomnvar("ui_kick_warning", 1);
  result = player scripts\engine\utility::waittill_any_in_array_or_timeout(["inputReceived"], var_3e9f2bc33c97b138);
  player clearhudtutorialmessage();
  player setclientomnvar("ui_kick_warning", 0);
  player.being_kicked_from_inactivity = undefined;

  if(result == "timeout") {
    if(scripts\cp\utility::get_num_of_valid_players() == 1) {
      level thread[[level.endgame]]("axis", level.end_game_string_index["fail"]);
      return;
    }

    kick(player getentitynumber(), "EXE/PLAYERKICKED_INACTIVE");
  }
}

function check_for_move_change() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("done_inactivity_check");

  while(!isDefined(self.model)) {
    wait 0.1;
  }

  forward = 1;
  var_e35fe7e5dcde5f75 = forward;
  var_e2ea1c206287e216 = forward;

  while(true) {
    var_ddb1a7c10dd388cc = self getnormalizedmovement();
    var_e35fe7e5dcde5f75 = get_move_direction_from_vectors(var_ddb1a7c10dd388cc);

    if(var_e2ea1c206287e216 != var_e35fe7e5dcde5f75) {
      var_e2ea1c206287e216 = var_e35fe7e5dcde5f75;
      self notify("inputReceived");
    }

    wait 0.1;
  }
}

function get_move_direction_from_vectors(var_eccbceb6c0eb084b) {
  forward = 1;
  var_41ef0825d377e717 = 2;
  var_a85f14c2589f9c2a = 3;
  back = 4;
  back_right = 5;
  back_left = 6;
  right = 7;
  left = 8;
  var_33a31b037e06caaf = forward;

  if(var_eccbceb6c0eb084b[0] > 0) {
    if(var_eccbceb6c0eb084b[1] <= 0.7 && var_eccbceb6c0eb084b[1] >= -0.7) {
      var_33a31b037e06caaf = forward;
    }

    if(var_eccbceb6c0eb084b[0] > 0.5 && var_eccbceb6c0eb084b[1] > 0.7) {
      var_33a31b037e06caaf = var_41ef0825d377e717;
    } else if(var_eccbceb6c0eb084b[0] > 0.5 && var_eccbceb6c0eb084b[1] < -0.7) {
      var_33a31b037e06caaf = var_a85f14c2589f9c2a;
    }
  } else if(var_eccbceb6c0eb084b[0] < 0) {
    if(var_eccbceb6c0eb084b[1] < 0.4 && var_eccbceb6c0eb084b[1] > -0.4) {
      var_33a31b037e06caaf = back;
    }

    if(var_eccbceb6c0eb084b[0] < -0.5 && var_eccbceb6c0eb084b[1] > 0.5) {
      var_33a31b037e06caaf = back_right;
    } else if(var_eccbceb6c0eb084b[0] < -0.5 && var_eccbceb6c0eb084b[1] < -0.5) {
      var_33a31b037e06caaf = back_left;
    }
  } else if(var_eccbceb6c0eb084b[1] > 0.4) {
    var_33a31b037e06caaf = right;
  } else if(var_eccbceb6c0eb084b[1] < -0.4) {
    var_33a31b037e06caaf = left;
  }

  return var_33a31b037e06caaf;
}

function health_meter_monitor(player) {
  player endon("disconnect");
  level endon("game_ended");
  wait 1;

  while(true) {
    player setclientomnvar("zm_player_health", player.health / 100);
    wait 0.05;
  }
}

function last_stand_hud_update() {
  self setclientomnvar("zm_player_health", 0);
}

function monitor_num_players() {
  scripts\engine\utility::flag_init("player_count_determined");
  initial_players = getDvar(@ "hash_6317f96738d7a501");

  if(initial_players != "1") {
    level.only_one_player = 0;
    println("<dev string:xc9>");
    scripts\engine\utility::flag_set("player_count_determined");
    return;
  }

  level.only_one_player = 1;
  scripts\engine\utility::flag_set("player_count_determined");

  while(!isDefined(level.players)) {
    wait 0.1;
  }

  while(true) {
    if(getdvarint(@ "hash_fd79ccd2feba375f", 0) == 1) {
      break;
    }

    if(level.players.size > 1) {
      break;
    }

    wait 1;
  }

  level.only_one_player = 0;
  level notify("multiple_players");
}

function enable_dogtag_revive(downed_player) {
  dogtag = spawn("script_model", downed_player.origin + (0, 0, 40));
  dogtag setModel("military_dogtags_iw9_blue");
  dogtag makeusable();
  dogtag scriptmodelplayanim("mp_dogtag_spin");
  dogtag setHintString(&"COOP_GAME_PLAY/REVIVE_USE");
  dogtag endon("death");
  downed_player.respawn_forcespawnorigin = downed_player.origin;
  downed_player.respawn_forcespawnangles = (0, 0, 0);
  downed_player.dogtag = dogtag;
  downed_player.dogtag.owner = downed_player;
  scripts\cp\laststand::makereviveicon(dogtag, downed_player, (1, 0, 0));
  dogtag thread revivetriggerthink(downed_player);
  dogtag thread endreviveonownerdeathordisconnect();
  level notify("laststand_dogtag_spawned", dogtag);
}

function rotate_tags() {
  self endon("death");

  while(true) {
    self rotateYaw(30, 0.5);
    wait 0.5;
  }
}

function revivetriggerthink(downed_player) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("instant_revive");
  downed_player endon("instant_revive");
  revivetime = 8000;

  while(true) {
    revivetime = 8000;
    self waittill("trigger", player);

    if(!player is_valid_player()) {
      continue;
    }

    if(istrue(player.class == "medic")) {
      revivetime = 6800;
    }

    self.bplayerrevivingteammate = 1;
    scripts\cp\laststand::set_revive_icon_color(self, (0.0117, 0.9882, 0.9882), 1);
    result = player_lua_progressbar(player, revivetime, 9216, 5);
    scripts\cp\laststand::set_revive_icon_color(self, (1, 0, 0), 1);
    self.bplayerrevivingteammate = undefined;

    if(!result) {
      continue;
    }

    break;
  }

  playFX(level._effect["dogtag_pickup"], self.origin);
  downed_player scripts\cp\laststand::instant_revive(downed_player);
  downed_player notify("last_stand_finished");
}

function endreviveonownerdeathordisconnect() {
  self endon("disconnect");
  self endon("death");
  self.owner waittill_any_2("disconnect", "last_stand_finished");
  self.owner = undefined;
  self delete();
}

function give_skillpoints_at_start() {
  self endon("disconnect");
  self waittill("loadout_given");

  if(!isDefined(self.starting_skillpoints_given)) {
    self.starting_skillpoints_given = 1;
  }
}

function givedefaultloadout(var_86db2022c4f0f4bf, var_185ea69b2fe37360) {
  if(flag_exist("strike_init_done")) {
    flag_wait("strike_init_done");
  }

  scripts\cp\survival\survival_loadout::givedefaultloadout(var_86db2022c4f0f4bf, var_185ea69b2fe37360);
}

function getspawnpoint() {
  if(flag_exist("strike_init_done")) {
    flag_wait("strike_init_done");
  }

  default_spawners = getStructArray("default_player_start", "targetname");

  if(isDefined(level.default_player_spawns)) {
    override_spawners = getStructArray(level.default_player_spawns, "targetname");

    if(override_spawners.size > 0) {
      default_spawners = override_spawners;
    }
  }

  return getassignedspawnpoint(default_spawners);
}

function getassignedspawnpoint(spawnpoints) {
  assertex(spawnpoints.size > 0, "No spawn points found");
  player_entity_num = self getentitynumber();
  assertex(isDefined(spawnpoints[player_entity_num]), "No spawn point for player ID: " + player_entity_num);
  return spawnpoints[player_entity_num];
}

function enable_lbravo_player_infil() {
  if(getdvarint(@ "scr_skip_infils", 0) == 1) {
    return;
  }

  if(player_infil_already_played()) {
    return;
  }

  level.strike_player_connect_black_screen_fn = &lbravo_infil_spawn_blackscreen_func;
  level thread delay_init_infil();
}

function player_infil_already_played() {
  return istrue(game["player_infil_already_played"]);
}

function delay_init_infil() {
  level endon("game_ended");
  var_c36dc418fd5a866c = 4;
  wait var_c36dc418fd5a866c;
  level thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("alpha");
  level waittill("players_unloaded_from_infil");
  game["player_infil_already_played"] = 1;
}

function lbravo_infil_spawn_blackscreen_func(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("stop_intro");
  var_eefd63015d3fe876 = 6;
  player setclientomnvar("ui_hide_hud", 1);
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0);

  if(flag_exist("strike_init_done")) {
    flag_wait("strike_init_done");
  }

  if(flag_exist("introscreen_over")) {
    flag_wait("introscreen_over");
  }

  wait 5;
  player scripts\cp\survival\survival_loadout::givedefaultloadout(0, undefined, 0);
  player disableweapons();
  player scripts\cp\utility::freezecontrolswrapper(1);
  player setclientomnvar("ui_hide_hud", 0);
  player namespace_4305d13d4c0bcb7a::show_introscreen_text();
  wait var_eefd63015d3fe876;
  player setclientomnvar("ui_hide_hud", 1);
  player setclientomnvar("ui_chyron_on", 0);
  player setclientomnvar("ui_chyron_mission_index", 0);
  scripts\cp\globallogic::refreshuimatchinprogressomnvarvalue();
  player scripts\cp\utility::freezecontrolswrapper(0);
  player enableweapons();

  if(!scripts\cp\utility::gameflag("infil_started")) {
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0);
    level notify("trying_to_join_infil", player);
    return;
  }

  player notify("open_loadout_menu");
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 4);
  player setclientomnvar("ui_hide_hud", 0);
}

function function_af9055152e36c41f() {
  while(true) {
    str = getDvar(@ "hash_eb00de0539eb962f");

    if(str != "<dev string:xfb>") {
      tokens = strtok(str, "<dev string:xfc>");

      foreach(player in level.players) {
        if(i == int(tokens[0])) {
          player[[level.custom_giveloadout]](0, int(tokens[1]));
        }
      }

      setDvar(@ "hash_eb00de0539eb962f", "<dev string:xfb>");
    }

    wait 0.5;
  }
}

function update_laststand_times() {
  scripts\cp\laststand::init_laststand_anims();
  inanim = level.scr_anim["ls_revive_helper"]["in_stand_1"];
  idleanim = level.scr_anim["ls_revive_helper"]["idle_stand_1"];
  outanim = level.scr_anim["ls_revive_helper"]["out_stand_1"];
  var_f05037a2663b00d9 = getanimlength(inanim);
  var_2385b76cf2542716 = getanimlength(idleanim);
  var_dcd276b4fda552a = getanimlength(outanim);
  buffer = 0.5;
  normal_revive_time = (var_f05037a2663b00d9 + var_2385b76cf2542716 + var_dcd276b4fda552a + buffer) * 1000;
  spectator_revive_time = 5000;
  fast_revive_time = (var_f05037a2663b00d9 + var_dcd276b4fda552a + buffer) * 1000;
  scripts\cp\laststand::set_revive_time(normal_revive_time, spectator_revive_time, fast_revive_time);
}

function ascendermsgfunc(txt, time) {
  self endon("disconnect");
  hint_prompt(txt, 1);
  wait time;
  hint_prompt(txt, 0);
}