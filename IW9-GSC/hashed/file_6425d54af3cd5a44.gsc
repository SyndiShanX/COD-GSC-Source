/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6425d54af3cd5a44.gsc
***********************************************/

main() {
  level._id_59C3F456A9E5D4F0 = _id_71332A5B74214116::init;
  _id_116171939929AF39::init();
  level thread onplayerconnect();
  level.skip_playerhudphoto = 1;
  level.fnoffhandfire = _id_74502A9E0EF1F19C::ai_offhandfiremanager;
  scripts\cp\utility::coop_mode_enable(["loot_system"]);
  initdefaultsettings();
  _id_74502A9E0EF1F19C::weaponsinit();
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
  _id_116171939929AF39::_id_D98E304DD9D5D8CD();
}

create_player_threatbias_groups() {
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

initdefaultsettings() {
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
  level._id_12226443217B5474 = getdvarint("dvar_7026CEFFE6E03F2D");
  level.ricochetdamage = getdvarint("scr_aliens_ricochet");
  level.casualmode = getdvarint("scr_aliens_casual");
  level.default_weapon = "iw8_pi_decho_mp";
  setdvarifuninitialized("enable_segmented_health_regen", 0);
  level.usehealthpacks = getdvarint("enable_segmented_health_regen", 0);
  level.pap_max = 2;

  if(getdvarint("dvar_00302B919208FAFA", 0) <= 0) {
    setDvar("bg_fallDamageMinHeight", 560);
    setDvar("bg_fallDamageMaxHeight", 561);
    setDvar("bg_softLandingMinHeight", 560);
    setDvar("bg_softLandingMaxHeight", 561);
  }

  level.exploimpactmod = 0.1;
  level.shotgundamagemod = 0.1;
  level.armorpiercingmod = 1.5;
  level.armorpiercingmodks = 1.25;
  level.maxlogclients = 10;
  level.custom_giveloadout = ::givedefaultloadout;
  level.move_speed_scale = scripts\cp\survival\survival_loadout::updatemovespeedscale;
  level.getnodearrayfunction = ::getnodearray;
  level.prematchfunc = ::prematchfunc;
  level.callbackplayerkilled = ::callbackplayerkilled;
  level.onplayerdisconnect = ::onplayerdisconnect;
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level.onprecachegametype = ::onprecachegametype;
  level.laststand_enter_gamemodespecificaction = ::enter_laststand;
  level.enter_spectator_func = ::enable_dogtag_revive;
  level.prespawnfromspectatorfunc = ::prespawnfromspectatorfunc;
  level.laststand_exit_gamemodespecificaction = ::exit_laststand_func;
  level.last_stand_hud_update = ::last_stand_hud_update;
  level.getspawnpoint = ::getspawnpoint;
  level.update_money_performance = scripts\cp\cp_core_gamescore::update_money_earned_performance;
  level.active_volume_check = scripts\cp\utility::is_in_active_volume;
  level.endgame_write_clientmatchdata_for_player_func = ::endgame_clientmatchdata;
  level.hostmigrationend = ::hostmigrationend;
  level.onhostmigration = ::hostmigrationstart;
  level.game_mode_statstable = "cp/zombies/mode_string_tables/zombies_statstable.csv";
  mapname = getDvar("ui_mapname");
  level.power_up_table = "cp/zombies/" + mapname + "_loot.csv";
}

exit_laststand_func(player) {
  player _id_1DB8D0E02A99C5E2::_id_2DD3214261E60026();
  player setclientomnvar("ui_is_laststand", 0);
  player clearclienttriggeraudiozone(0.3);
  player playlocalsound("deaths_door_out");
  player stoplocalsound("deaths_door_in");

  if(isDefined(level.vision_set_override))
    player thread reset_override_visionset(0.2);

  _id_A91C50E065B4BEBE = randomintrange(1, 5);
  _id_56F3CCDE65AF5B46 = "zmb_revive_music_lr_0" + _id_A91C50E065B4BEBE;
  player scripts\cp\utility::playlocalsound_safe(_id_56F3CCDE65AF5B46);
  player scripts\cp\utility::allow_player_ignore_me(0);

  if(scripts\cp\utility::is_raid_gamemode() && !istrue(level.dogtag_revive)) {
    player skydive_setbasejumpingstatus(0);
    player skydive_setdeploymentstatus(0);
  }
}

reset_override_visionset(timer) {
  level endon("game_ended");
  self endon("disconnect");
  wait(timer);

  if(isDefined(level.vision_set_override))
    level notify("vision_set_change_request", level.vision_set_override, self, 0.1);
}

onstartgametype() {
  scripts\cp\utility::set_segmented_health_regen_parameters(100, 100, 25, 2, 1, 0.05);
  scripts\cp\cp_persistence::register_eog_to_lb_playerdata_mapping();
  scripts\cp\cp_analytics::initlevelvars();
  thread update_laststand_times();
  level thread init_enemy_spawner();
  level.ascendermsgfunc = ::ascendermsgfunc;
  thread scripts\cp_mp\auto_ascender::init();
  thread scripts\cp_mp\ent_manager::init();
  level scripts\cp\calloutmarkerping_cp::calloutmarkerping_init();

  if(!isDefined(level.normal_mode_activation_funcs))
    level.normal_mode_activation_funcs = [];

  if(!isDefined(level.special_mode_activation_funcs))
    level.special_mode_activation_funcs = [];

  if(!isDefined(level.pentskipfov))
    level.pentskipfov = [];

  if(!isDefined(level.pentparams))
    level.pentparams = [];

  level.spawnloopupdatefunc = _id_18A73A64992DD07D::update_spawn_data_on_death;
  scripts\cp\cp_persistence::rank_init();
  level thread handlenondeterministicentities();
  level thread checkpoint_revive();
  _id_18A73A64992DD07D::_id_4C108AF46678AF57();
  thread scripts\cp\cp_outofbounds::initoob();

  if(level.gametype == "cp_survival") {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
      level.players[_id_AC0E594AC96AA3A8] setclientomnvar("ui_session_state", "spectator");
  }
}

init_enemy_spawner() {
  scripts\cp\cp_spawner_scoring::spawner_scoring_init();
}

onprecachegametype() {
  level._effect["dogtag_pickup"] = loadfx("vfx/iw7/core/zombie/vfx_zom_souvenir_pickup.vfx");
  level._effect["vfx_br_infil_cloud_scroll"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_scroll.vfx");
  level._effect["vfx_br_infil_jump_smoke_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_02"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx");
  level._effect["vfx_br_infil_omni_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_omni_light.vfx");
  level._effect["vfx_br_infil_spot_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_spot_light.vfx");
  precachempanim("mp_dogtag_spin");
}

handlenondeterministicentities() {
  level endon("game_ended");
  wait 5;
  level notify("spawn_nondeterministic_entities");

  if(isDefined(level.post_nondeterministic_func))
    level thread[[level.post_nondeterministic_func]]();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);

    if(!isai(player)) {
      player scripts\cp\cp_analytics::on_player_connect();
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_player_first_connect", player);

      if(isDefined(player.connecttime))
        player.connect_time = player.connecttime;
      else
        player.connect_time = gettime();

      player.xpscale = getdvarint("online_zombies_xpscale");
      player.weaponxpscale = getdvarint("online_zombie_weapon_xpscale");

      if(player scripts\cp\utility::rankingenabled()) {
        _id_69A07D6024AEB70B = getdvarint("online_zombie_party_weapon_xpscale");
        _id_2B96F5B26B76CABB = getdvarint("online_zombie_party_xpscale");
        _id_E2F208FF5491C24E = player getprivatepartysize() > 1;

        if(isDefined(_id_69A07D6024AEB70B)) {
          if(_id_E2F208FF5491C24E && _id_69A07D6024AEB70B > 1)
            player.weaponxpscale = _id_69A07D6024AEB70B;
        }

        if(isDefined(_id_2B96F5B26B76CABB)) {
          if(_id_E2F208FF5491C24E && _id_2B96F5B26B76CABB > 1)
            player.xpscale = _id_2B96F5B26B76CABB;
        }
      }

      if(istrue(player getplayerdata("cp", "tacOpsAchievements", "LANDLORD")) && istrue(player getplayerdata("cp", "tacOpsAchievements", "ARMED")) && istrue(player getplayerdata("cp", "tacOpsAchievements", "SMUGGLED")) && istrue(player getplayerdata("cp", "tacOpsAchievements", "LAUNDERED")))
        player thread scripts\cp\cp_awards::give_operator_based_on_task("all_operations");

      player thread _id_116171939929AF39::player_init_health_regen();
      player scripts\cp\cp_persistence::session_stats_init();
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
      player scripts\cp\utility::allow_player_teleport(0);
      player.achievement_registration_func = scripts\cp\cp_achievement::register_default_achievements;
      player scripts\cp\cp_achievement::init_player_achievements(player);
      player.spawntimestamp = player.connect_time;
      player scripts\cp\cp_mapselect::set_uav_radarstrength(player);
      player scripts\cp\cp_persistence::lb_player_update_stat("waveNum", level.wave_num, 1);
      player scripts\cp\cp_persistence::player_persistence_init();
      player thread scripts\cp\cp_analytics::init_weapon_and_player_analytics(player);

      if(isDefined(level.fnhidefoundintel))
        player thread[[level.fnhidefoundintel]]();

      player.gameskill = scripts\cp\cp_gameskill::get_gameskill();
      player scripts\cp\cp_gameskill::set_difficulty_from_locked_settings();
      player thread strike_player_connect_black_screen();
      player.timeplayed = [];

      foreach(team in level.teamnamelist)
      player.timeplayed[team] = 0;

      player.timeplayed["total"] = 0;
      player.timeplayed["missionTeam"] = 0;
      player.timeplayed["other"] = 0;
      player.timeplayed["timeDead"] = 0;
      player scripts\cp_mp\calloutmarkerping::calloutmarkerping_initplayer();

      if(scripts\engine\utility::flag("introscreen_over")) {
        if(isDefined(level.custom_player_hotjoin_func))
          player thread[[level.custom_player_hotjoin_func]]();

        if(isDefined(level.hacking_lua_notify_func))
          player thread[[level.hacking_lua_notify_func]]();
      }

      if(isDefined(level.custom_onplayerconnect_func))
        [[level.custom_onplayerconnect_func]](player);

      if(!isDefined(level.kick_player_queue))
        level thread kick_player_queue_loop();

      player thread kick_for_inactivity(player);
      player thread mission_jumpto_debug();
    }
  }
}

mission_jumpto_debug() {
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, index);

    if(_id_7148C1A6F25491F8 == "mission_jump") {
      _id_DDAC31817B064B95 = getDvar("ui_mapname");
      _id_A1F826C73E18485B = "cp/" + _id_DDAC31817B064B95 + "_objectives.csv";
      _id_063A2D0CCB8BC9E6 = tablelookup(_id_A1F826C73E18485B, 0, index, 1);
      _id_419DB796B177B94B = _func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", _id_DDAC31817B064B95);
      setdvarifuninitialized(_id_419DB796B177B94B, _id_063A2D0CCB8BC9E6);
      setDvar(_id_419DB796B177B94B, _id_063A2D0CCB8BC9E6);
      _id_467F0FDFDD155A45::restart_map();
    }
  }
}

team_slot_assignment_available_from_player_disconnect() {
  return level.disconnect_player_team_slot_assignment.size > 0;
}

get_team_slot_assignment_from_player_disconnect() {
  _id_1E30431586BFE80F = level.disconnect_player_team_slot_assignment[0];
  level.disconnect_player_team_slot_assignment = scripts\engine\utility::array_remove(level.disconnect_player_team_slot_assignment, _id_1E30431586BFE80F);
  return _id_1E30431586BFE80F;
}

player_hotjoin() {
  self endon("disconnect");
  self notify("intro_done");
  self notify("stop_intro");
  self notify("player_hotjoin");
  self endon("player_hotjoin");
  level endon("game_ended");
  self waittill("spawned");
  thread hotjoin_protection();
  self.pers["hotjoined"] = 1;

  if(isDefined(level.wave_num))
    self.wave_num_when_joined = level.wave_num;

  _id_DDAC31817B064B95 = getDvar("ui_mapname");
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);
  wait 3;
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 3);

  while(!istrue(self.photosetup))
    wait 1;

  self setclientomnvar("ui_hide_hud", 0);
}

hotjoin_protection() {
  self notify("hotjoin_protection");
  self endon("hotjoin_protection");
  self endon("disconnect");
  scripts\cp\utility::allow_player_ignore_me(1);
  self.ability_invulnerable = 1;
  wait 8;
  scripts\cp\utility::allow_player_ignore_me(0);
  self.ability_invulnerable = undefined;
}

onspawnplayer(_id_13FE2B86C5E85A64) {
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

  if(!isDefined(self.enabledignoreme))
    self.enabledignoreme = 0;

  if(!isDefined(self.ignoreme))
    self.ignoreme = 0;

  self.hide_tutorial = 1;
  self.flung = undefined;
  self.is_holding_deployable = 0;
  self.has_special_weapon = 0;
  self.lastkilltime = gettime();
  self.lastmultikilltime = gettime();
  _id_3B64EB40368C1450::_id_8B5F9E0014775208();
  scripts\cp_mp\utility\damage_utility::cleardamagemodifiers();
  thread scripts\cp\perks\cp_perks::watchcombatspeedscaler();

  if(isDefined(level.custom_onspawnplayer_func))
    self[[level.custom_onspawnplayer_func]]();

  if(istrue(level.parachutecancutautodeploy))
    self skydive_cutautodeployon();
  else
    self skydive_cutautodeployoff();

  if(istrue(level.parachutecancutparachute))
    self skydive_cutparachuteon();
  else
    self skydive_cutparachuteoff();

  _id_116171939929AF39::player_init_invulnerability();
  _id_116171939929AF39::player_init_damageshield();
  starting_currency = get_starting_currency(self);
  thread scripts\cp\cp_persistence::wait_to_set_player_currency(starting_currency);
  set_player_max_currency(999999);
  thread scripts\cp\cp_hud_util::zom_player_health_overlay_watcher();
  thread add_player_to_threatbias_group();
  thread scripts\cp\coop_personal_ents::assignpersonalmodelents(self);
  thread scripts\cp\coop_personal_ents::movepentstostructs(self);
  thread give_skillpoints_at_start();

  if(scripts\cp\utility::_id_6AAFBDD00B977115())
    thread scripts\cp\equipment\nvg::runnvg();

  if(isDefined(self.anchor))
    self.anchor delete();

  scripts\cp\utility::force_usability_enabled();
  self setclientomnvar("ui_hide_minimap", 1);
}

add_player_to_threatbias_group() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(self == level.players[_id_AC0E594AC96AA3A8]) {
      _id_64F22D47F382BD43 = _id_AC0E594AC96AA3A8 + 1;

      if(_id_64F22D47F382BD43 == 5) {
        return;
      }
      self setthreatbiasgroup("player" + _id_64F22D47F382BD43);
    }
  }
}

get_starting_currency(player) {
  starting_currency_after_revived_from_spectator = player.starting_currency_after_revived_from_spectator;

  if(isDefined(starting_currency_after_revived_from_spectator)) {
    player.starting_currency_after_revived_from_spectator = undefined;
    return starting_currency_after_revived_from_spectator;
  } else
    return scripts\cp\cp_persistence::get_starting_currency();
}

set_player_max_currency(amount) {
  amount = int(amount);
  self.maxcurrency = amount;
}

prespawnfromspectatorfunc(player) {
  player.starting_currency_after_revived_from_spectator = player scripts\cp\cp_persistence::get_player_currency();
  revivefromspectatorweaponsetup(player);
  set_spawn_loc(player);
}

revivefromspectatorweaponsetup(player) {
  weaponlist = spawnStruct();
  weaponlist.copy_fullweaponlist = player.copy_fullweaponlist;
  weaponlist.copy_weapon_current = player.copy_weapon_current;
  weaponlist.copy_weapon_ammo_clip = player.copy_weapon_ammo_clip;
  weaponlist.copy_weapon_ammo_stock = player.copy_weapon_ammo_stock;

  if(isDefined(player.saved_last_stand_pistol)) {
    weaponlist.last_stand_pistol = player.saved_last_stand_pistol;
    player.saved_last_stand_pistol = undefined;
  } else
    weaponlist.last_stand_pistol = player.last_stand_pistol;

  weaponlist.weapon_levels = player.copy_weapon_level;

  if(isDefined(player.current_crafted_inventory)) {
    weaponlist.current_crafted_inventory = player.current_crafted_inventory;
    player.current_crafted_inventory = undefined;
  }

  weaponlist.copy_all_powers = player.pre_laststand_powers;
  weaponlist.copy_special_ammo_type = player.special_ammo_type;
  player.weaponlist = weaponlist;
}

restore_player_weapons_after_bleedout(player) {
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
  player _id_1DB8D0E02A99C5E2::_id_2DD3214261E60026();

  if(isDefined(weaponlist.current_crafted_inventory))
    level thread[[weaponlist.current_crafted_inventory.restore_func]](undefined, player);

  player.special_ammo_type = weaponlist.copy_special_ammo_type;
  player.have_things_in_lost_and_found = 0;
  player.last_stand_pistol = weaponlist.last_stand_pistol;
  player.weaponlist = undefined;
}

set_spawn_loc(player) {
  spawnpoint = getplayerrespawnloc(player);
  player.forcespawnorigin = spawnpoint.origin;
  player.forcespawnangles = spawnpoint.angles;

  if(isDefined(player.respawn_forcespawnorigin))
    player.forcespawnorigin = player.respawn_forcespawnorigin;

  if(isDefined(player.respawn_forcespawnangles))
    player.forcespawnangles = player.respawn_forcespawnangles;
}

getplayerrespawnloc(downed_player) {
  if(isDefined(level.force_respawn_location))
    return [[level.force_respawn_location]](downed_player);

  if(!isDefined(level.active_player_respawn_locs) || level.active_player_respawn_locs.size == 0 || level.players.size == 0)
    return [[level.getspawnpoint]]();

  if(isDefined(level.respawn_loc_override_func))
    return [[level.respawn_loc_override_func]](downed_player);

  _id_28E11B47827DA015 = get_available_players(downed_player);
  _id_5DD3D8AA84432CA3 = get_available_respawn_locs(_id_28E11B47827DA015);

  if(_id_5DD3D8AA84432CA3.size == 0)
    return get_respawn_loc_near_team_center(downed_player, _id_28E11B47827DA015);

  if(_id_5DD3D8AA84432CA3.size == 1)
    return _id_5DD3D8AA84432CA3[0];

  return downed_player get_respawn_loc_rated(_id_28E11B47827DA015, _id_5DD3D8AA84432CA3);
}

get_available_players(downed_player) {
  _id_28E11B47827DA015 = [];

  foreach(player in level.players) {
    if(player == downed_player) {
      continue;
    }
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      continue;
    }
    _id_28E11B47827DA015[_id_28E11B47827DA015.size] = player;
  }

  return _id_28E11B47827DA015;
}

get_available_respawn_locs(_id_28E11B47827DA015) {
  _id_5DD3D8AA84432CA3 = [];

  foreach(_id_C337FC4166B34662 in level.active_player_respawn_locs) {
    if(!canspawn(_id_C337FC4166B34662.origin)) {
      continue;
    }
    if(positionwouldtelefrag(_id_C337FC4166B34662.origin)) {
      continue;
    }
    if(is_respawn_loc_near_available_players(_id_C337FC4166B34662, _id_28E11B47827DA015)) {
      continue;
    }
    if(is_respawn_loc_near_alive_enemies(_id_C337FC4166B34662)) {
      continue;
    }
    _id_5DD3D8AA84432CA3[_id_5DD3D8AA84432CA3.size] = _id_C337FC4166B34662;
  }

  return _id_5DD3D8AA84432CA3;
}

is_respawn_loc_near_available_players(_id_D95EF4BCC28FA1AA, _id_28E11B47827DA015) {
  foreach(_id_B2143E1339865CE4 in _id_28E11B47827DA015) {
    if(distancesquared(_id_B2143E1339865CE4.origin, _id_D95EF4BCC28FA1AA.origin) < 250000)
      return 1;
  }

  return 0;
}

is_respawn_loc_near_alive_enemies(_id_D95EF4BCC28FA1AA) {
  _id_CCC9F9C05ABCFDE9 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(_id_2E90373C39823C95 in _id_CCC9F9C05ABCFDE9) {
    if(distancesquared(_id_2E90373C39823C95.origin, _id_D95EF4BCC28FA1AA.origin) < 250000)
      return 1;
  }

  return 0;
}

get_respawn_loc_near_team_center(downed_player, _id_28E11B47827DA015) {
  _id_05B96A0B63B2DA7F = 0;
  _id_05B9690B63B2D84C = 0;
  _id_05B96C0B63B2DEE5 = 0;
  counter = 0;

  foreach(player in _id_28E11B47827DA015) {
    _id_05B96A0B63B2DA7F = _id_05B96A0B63B2DA7F + player.origin[0];
    _id_05B9690B63B2D84C = _id_05B9690B63B2D84C + player.origin[1];
    _id_05B96C0B63B2DEE5 = _id_05B96C0B63B2DEE5 + player.origin[2];
    counter++;
  }

  _id_BF41D0CE35D5C8EC = (_id_05B96A0B63B2DA7F / counter, _id_05B9690B63B2D84C / counter, _id_05B96C0B63B2DEE5 / counter);
  _id_2D6C745AFAB7A7B1 = sortbydistance(level.active_player_respawn_locs, _id_BF41D0CE35D5C8EC);
  return _id_2D6C745AFAB7A7B1[0];
}

get_respawn_loc_rated(_id_28E11B47827DA015, _id_5DD3D8AA84432CA3) {
  _id_6E1F6C61482C7506 = scripts\engine\utility::ter_op(_id_28E11B47827DA015.size == 0, 1, _id_28E11B47827DA015.size);
  _id_5408A7783CA52166 = level.spawned_enemies.size / _id_6E1F6C61482C7506;
  _id_620C96A13D50E7BD = _id_5408A7783CA52166 * 2;
  _id_A7B39F36AFAD5914 = -99999999;
  _id_D024CACEC9D41EFD = undefined;

  foreach(_id_FDF23B2021E21BA2 in _id_5DD3D8AA84432CA3) {
    _id_2CEC23DDABF59363 = 0;

    foreach(player in _id_28E11B47827DA015) {
      if(player == self) {
        continue;
      }
      if(!isalive(player)) {
        continue;
      }
      if(istrue(player.inlaststand)) {
        _id_2CEC23DDABF59363 = _id_2CEC23DDABF59363 - distancesquared(player.origin, _id_FDF23B2021E21BA2.origin) * (_id_620C96A13D50E7BD * 2);
        continue;
      }

      _id_2CEC23DDABF59363 = _id_2CEC23DDABF59363 - distancesquared(player.origin, _id_FDF23B2021E21BA2.origin) * _id_620C96A13D50E7BD;
    }

    foreach(_id_C8C0E3CBCE8F401A in level.spawned_enemies)
    _id_2CEC23DDABF59363 = _id_2CEC23DDABF59363 + distancesquared(_id_C8C0E3CBCE8F401A.origin, _id_FDF23B2021E21BA2.origin);

    _id_2CEC23DDABF59363 = _id_2CEC23DDABF59363 / 1000000;

    if(_id_2CEC23DDABF59363 > _id_A7B39F36AFAD5914) {
      _id_A7B39F36AFAD5914 = _id_2CEC23DDABF59363;
      _id_D024CACEC9D41EFD = _id_FDF23B2021E21BA2;
    }
  }

  return _id_D024CACEC9D41EFD;
}

prematchfunc() {
  prematchperiod = 0;

  if(prematchperiod > 0) {
    player = level wait_for_first_player_connect();
    wait(prematchperiod - 3);

    if(isDefined(level.postintroscreenfunc))
      [[level.postintroscreenfunc]]();

    scripts\engine\utility::flag_set("introscreen_over");
    level.introscreen_done = 1;
  } else {
    wait 2;

    if(scripts\engine\utility::flag("infil_complete"))
      wait 2;

    level.introscreen_done = 1;
    scripts\engine\utility::flag_set("introscreen_over");
  }

  if(istrue(level.intermission))
    return;
}

show_introscreen_text() {
  _id_DDAC31817B064B95 = getDvar("ui_mapname");
  _id_892708EFF6520B44 = getDvar(_func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", _id_DDAC31817B064B95), "");
  _id_A1F826C73E18485B = "cp/" + _id_DDAC31817B064B95 + "_objectives.csv";
  _id_D31685C0A626FF37 = int(tablelookup(_id_A1F826C73E18485B, 1, _id_892708EFF6520B44, 0));

  if(isDefined(_id_892708EFF6520B44) && _id_892708EFF6520B44 != "") {
    self setclientomnvar("ui_hide_hud", 0);
    self setclientomnvar("ui_chyron_mission_index", _id_D31685C0A626FF37);
    self setclientomnvar("ui_chyron_on", 1);
  }
}

wait_for_first_player_connect() {
  player = undefined;

  if(level.players.size == 0)
    level waittill("connected", player);
  else
    player = level.players[0];

  return player;
}

strike_player_connect_black_screen() {
  if(isDefined(level.strike_player_connect_black_screen_fn))
    [[level.strike_player_connect_black_screen_fn]](self);
  else
    default_strike_player_connect_black_screen(self);
}

default_strike_player_connect_black_screen(player) {
  player endon("disconnect");
  player endon("stop_intro");
  player setclientomnvar("ui_hide_hud", 1);
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0);
  player waittill("spawned");
  player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  player disableweapons();
  player scripts\cp\utility::freezecontrolswrapper(1);

  if(istrue(player.ishotjoiningplayer)) {
    player show_introscreen_text();

    if(scripts\engine\utility::flag_exist("strike_init_done"))
      scripts\engine\utility::flag_wait("strike_init_done");

    if(!scripts\engine\utility::flag("introscreen_over"))
      scripts\engine\utility::flag_wait("introscreen_over");

    wait 1;
    player setclientomnvar("ui_hide_hud", 1);
    player setclientomnvar("ui_chyron_on", 0);
    player setclientomnvar("ui_chyron_mission_index", 0);
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 4);
    wait 2;
    player scripts\cp\utility::freezecontrolswrapper(0);
    player enableweapons();
    player setclientomnvar("ui_hide_hud", 0);
    _id_116171939929AF39::refreshuimatchinprogressomnvarvalue();
  } else {
    if(isDefined(level.player_controls_failsafe))
      player thread[[level.player_controls_failsafe]]();

    player show_introscreen_text();

    if(scripts\engine\utility::flag_exist("strike_init_done"))
      scripts\engine\utility::flag_wait("strike_init_done");

    if(!scripts\engine\utility::flag("introscreen_over"))
      scripts\engine\utility::flag_wait("introscreen_over");

    wait 6;
    player setclientomnvar("ui_hide_hud", 1);
    player setclientomnvar("ui_chyron_on", 0);
    player setclientomnvar("ui_chyron_mission_index", 0);
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 4);
    wait 2;
    player scripts\cp\utility::freezecontrolswrapper(0);
    player enableweapons();
    player setclientomnvar("ui_hide_hud", 0);
    _id_116171939929AF39::refreshuimatchinprogressomnvarvalue();
  }

  player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
}

playerinfildisabled(player) {
  return istrue(player.infil_disabled);
}

callbackplayerkilled(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime) {
  [[level.callbackplayerlaststand]](einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime);
}

precachelb() {
  _id_D6C112F12A466CA4 = " LB_" + getDvar("ui_mapname");

  if(scripts\cp\utility::isplayingsolo())
    _id_D6C112F12A466CA4 = _id_D6C112F12A466CA4 + "_SOLO";
  else
    _id_D6C112F12A466CA4 = _id_D6C112F12A466CA4 + "_COOP";

  precacheleaderboards(_id_D6C112F12A466CA4);
}

enter_laststand(player, attacker) {
  player scripts\cp\cp_persistence::eog_player_update_stat("downs", 1);
  player scripts\cp\cp_analytics::log_event("dropped_to_last_stand", 1, [player.clientid], [player.clientid], [player.clientid]);
  player.pre_arcade_game_weapon = undefined;
  player.pre_arcade_game_weapon_clip = undefined;
  player.pre_arcade_game_weapon_stock = undefined;
  player.former_mule_weapon = undefined;
  player _id_1DB8D0E02A99C5E2::_id_7C70DC615DA72C51();
  player _id_7EF95BBA57DC4B82::clearallequipment();
  currentweapon = player getcurrentweapon();
  _id_66B240BF0B2BAFF8 = getweaponbasename(currentweapon);
  _id_6A3B7F7386AB3BE8 = player getcurrentweaponclipammo();

  if(!isDefined(player.downsperweaponlog[_id_66B240BF0B2BAFF8]))
    player.downsperweaponlog[_id_66B240BF0B2BAFF8] = 1;
  else
    player.downsperweaponlog[_id_66B240BF0B2BAFF8]++;

  player clearclienttriggeraudiozone(0);

  if(!self issplitscreenplayer())
    player setclienttriggeraudiozonepartialwithfade("last_stand_cp", 0.02, "mix", "reverb", "filter");

  have_self_revive = player scripts\cp\utility::has_auto_revive();

  if(have_self_revive) {
    _id_F4A1F546FFFCD5E4 = scripts\cp\utility::isplayingsolo() || level.only_one_player;
    player notify("player_has_self_revive", _id_F4A1F546FFFCD5E4);
  }

  if(isDefined(player.mule_weapon) && !istrue(player.playing_ghosts_n_skulls))
    player.former_mule_weapon = player.mule_weapon;
  else
    player.former_mule_weapon = undefined;

  player scripts\cp\utility::allow_player_ignore_me(1);
  player setclientomnvar("ui_is_laststand", 1);
}

updaterecentkills(victim, weapon) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.recentkillcount++;
  _id_66B240BF0B2BAFF8 = getweaponbasename(weapon);

  if(!isDefined(self.killsperweaponlog[_id_66B240BF0B2BAFF8]))
    self.killsperweaponlog[_id_66B240BF0B2BAFF8] = 1;
  else
    self.killsperweaponlog[_id_66B240BF0B2BAFF8]++;

  if(!isDefined(self.recentkillsperweapon))
    self.recentkillsperweapon = [];

  if(!isDefined(self.recentkillsperweapon[weapon]))
    self.recentkillsperweapon[weapon] = 1;
  else
    self.recentkillsperweapon[weapon]++;

  weaponinfo = scripts\cp\utility::getequipmenttype(weapon);
  wait 1.25;
  self.recentkillcount = 0;
  self.recentkillsperweapon = undefined;
}

onplayerdisconnect(_id_2421296BA8CCB5EE, _id_401C3A2E68AAB0FD) {
  _id_2421296BA8CCB5EE setplayerdata("cp", "CPSession", "subParty", -1);
  scripts\cp\cp_persistence::eog_update_on_player_disconnect(_id_2421296BA8CCB5EE);
}

endgame_clientmatchdata(player, _id_0432A6B6AADCC1EF) {}

hostmigrationstart() {
  _id_CCC9F9C05ABCFDE9 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(zombie in _id_CCC9F9C05ABCFDE9) {
    if(istrue(zombie.scripted_mode)) {
      zombie.died_poorly = 1;
      zombie suicide();
      continue;
    } else if(istrue(zombie.ignoreme)) {
      zombie.died_poorly = 1;
      zombie suicide();
      continue;
    } else if(istrue(zombie.ignoreall)) {
      zombie.died_poorly = 1;
      zombie suicide();
      continue;
    } else if(!istrue(zombie.entered_playspace)) {
      zombie.died_poorly = 1;
      zombie suicide();
      continue;
    } else {
      zombie.scripted_mode = 1;
      zombie setgoalpos(zombie.origin);
      zombie.ignoreme = 1;
      zombie.ignoreall = 1;
    }
  }
}

hostmigrationend() {
  _id_CCC9F9C05ABCFDE9 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(zombie in _id_CCC9F9C05ABCFDE9) {
    zombie.scripted_mode = 0;
    zombie.ignoreme = 0;
    zombie.ignoreall = 0;
  }

  if(isDefined(level.customhostmigrationend))
    level thread[[level.customhostmigrationend]]();
}

kick_for_inactivity(player) {
  level endon("game_ended");
  player endon("disconnect");
  input_has_happened = 0;
  _id_A375F55FCB7B1C80 = gettime();
  _id_47309AB08FA928A9 = level.onlinegame && !getdvarint("xblive_privatematch");

  if(!_id_47309AB08FA928A9) {
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
  _id_CD743003D3F4F0CA = 0.1;

  for(;;) {
    result = scripts\engine\utility::waittill_any_timeout_no_endon_death_2(_id_CD743003D3F4F0CA, "inputReceived", "currency_earned");

    if(gettime() - _id_A375F55FCB7B1C80 < 30000) {
      continue;
    }
    if(result != "timeout") {
      time = 120;
      input_has_happened = 1;
      continue;
    }

    if(!istrue(player.in_afterlife_arcade) && !istrue(player.inlaststand))
      time = time - _id_CD743003D3F4F0CA;

    if(time < 0) {
      if(input_has_happened) {
        input_has_happened = 0;
        continue;
      }

      add_to_kick_queue(player);
    }
  }
}

check_for_movement() {
  level endon("game_ended");
  self endon("disconnect");
  _id_F20CE68135A2BA2C = self getnormalizedmovement();
  _id_A375F55FCB7B1C80 = gettime();

  for(;;) {
    wait 0.2;
    _id_8929332B64537B53 = self getnormalizedmovement();

    if(_id_8929332B64537B53[0] == _id_F20CE68135A2BA2C[0] && _id_8929332B64537B53[1] == _id_F20CE68135A2BA2C[1]) {
      if(gettime() - _id_A375F55FCB7B1C80 > 90000)
        add_to_kick_queue(self);

      continue;
    }

    self notify("inputReceived");
    return;
  }
}

add_to_kick_queue(player) {
  if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
    return;
  }
  if(istrue(player.immune_against_kick_for_inactivity)) {
    return;
  }
  if(!scripts\engine\utility::array_contains(level.kick_player_queue, player))
    level.kick_player_queue = scripts\engine\utility::array_add_safe(level.kick_player_queue, player);
}

kick_player_queue_loop() {
  level endon("game_ended");
  level.kick_player_queue = [];

  for(;;) {
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

delay_kick_inactive_player(player) {
  level endon("game_ended");
  self endon("disconnect");
  _id_3E9F2BC33C97B138 = 10;

  if(istrue(player.being_kicked_from_inactivity)) {
    return;
  }
  player.being_kicked_from_inactivity = 1;
  player sethudtutorialmessage(&"COOP_GAME_PLAY/KICK_FOR_INACTIVITY", 1);
  player setclientomnvar("ui_kick_warning", 1);
  result = player scripts\engine\utility::waittill_any_in_array_or_timeout(["inputReceived"], _id_3E9F2BC33C97B138);
  player clearhudtutorialmessage();
  player setclientomnvar("ui_kick_warning", 0);
  player.being_kicked_from_inactivity = undefined;

  if(result == "timeout") {
    if(scripts\cp\utility::get_num_of_valid_players() == 1)
      level thread[[level.endgame]]("axis", level.end_game_string_index["fail"]);
    else
      kick(player getentitynumber(), "EXE/PLAYERKICKED_INACTIVE");
  }
}

check_for_move_change() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("done_inactivity_check");

  while(!isDefined(self.model))
    wait 0.1;

  forward = 1;
  _id_E35FE7E5DCDE5F75 = forward;
  _id_E2EA1C206287E216 = forward;

  for(;;) {
    _id_DDB1A7C10DD388CC = self getnormalizedmovement();
    _id_E35FE7E5DCDE5F75 = get_move_direction_from_vectors(_id_DDB1A7C10DD388CC);

    if(_id_E2EA1C206287E216 != _id_E35FE7E5DCDE5F75) {
      _id_E2EA1C206287E216 = _id_E35FE7E5DCDE5F75;
      self notify("inputReceived");
    }

    wait 0.1;
  }
}

get_move_direction_from_vectors(_id_ECCBCEB6C0EB084B) {
  forward = 1;
  _id_41EF0825D377E717 = 2;
  _id_A85F14C2589F9C2A = 3;
  back = 4;
  back_right = 5;
  back_left = 6;
  right = 7;
  left = 8;
  _id_33A31B037E06CAAF = forward;

  if(_id_ECCBCEB6C0EB084B[0] > 0) {
    if(_id_ECCBCEB6C0EB084B[1] <= 0.7 && _id_ECCBCEB6C0EB084B[1] >= -0.7)
      _id_33A31B037E06CAAF = forward;

    if(_id_ECCBCEB6C0EB084B[0] > 0.5 && _id_ECCBCEB6C0EB084B[1] > 0.7)
      _id_33A31B037E06CAAF = _id_41EF0825D377E717;
    else if(_id_ECCBCEB6C0EB084B[0] > 0.5 && _id_ECCBCEB6C0EB084B[1] < -0.7)
      _id_33A31B037E06CAAF = _id_A85F14C2589F9C2A;
  } else if(_id_ECCBCEB6C0EB084B[0] < 0) {
    if(_id_ECCBCEB6C0EB084B[1] < 0.4 && _id_ECCBCEB6C0EB084B[1] > -0.4)
      _id_33A31B037E06CAAF = back;

    if(_id_ECCBCEB6C0EB084B[0] < -0.5 && _id_ECCBCEB6C0EB084B[1] > 0.5)
      _id_33A31B037E06CAAF = back_right;
    else if(_id_ECCBCEB6C0EB084B[0] < -0.5 && _id_ECCBCEB6C0EB084B[1] < -0.5)
      _id_33A31B037E06CAAF = back_left;
  } else if(_id_ECCBCEB6C0EB084B[1] > 0.4)
    _id_33A31B037E06CAAF = right;
  else if(_id_ECCBCEB6C0EB084B[1] < -0.4)
    _id_33A31B037E06CAAF = left;

  return _id_33A31B037E06CAAF;
}

health_meter_monitor(player) {
  player endon("disconnect");
  level endon("game_ended");
  wait 1;

  for(;;) {
    player setclientomnvar("zm_player_health", player.health / 100);
    wait 0.05;
  }
}

last_stand_hud_update() {
  self setclientomnvar("zm_player_health", 0);
}

monitor_num_players() {
  scripts\engine\utility::flag_init("player_count_determined");
  _id_4E272A6BB24A5E12 = getDvar("party_partyPlayerCountNum");

  if(_id_4E272A6BB24A5E12 != "1") {
    level.only_one_player = 0;
    scripts\engine\utility::flag_set("player_count_determined");
    return;
  }

  level.only_one_player = 1;
  scripts\engine\utility::flag_set("player_count_determined");

  while(!isDefined(level.players))
    wait 0.1;

  for(;;) {
    if(level.players.size > 1) {
      break;
    }

    wait 1;
  }

  level.only_one_player = 0;
  level notify("multiple_players");
}

enable_dogtag_revive(downed_player) {
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
  _id_0AFB7E332AEE4BF2::makereviveicon(dogtag, downed_player, (1, 0, 0));
  dogtag thread revivetriggerthink(downed_player);
  dogtag thread endreviveonownerdeathordisconnect();
  level notify("laststand_dogtag_spawned", dogtag);
}

rotate_tags() {
  self endon("death");

  for(;;) {
    self rotateYaw(30, 0.5);
    wait 0.5;
  }
}

revivetriggerthink(downed_player) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("instant_revive");
  downed_player endon("instant_revive");
  _id_A268CB99479F185D = 8000;

  for(;;) {
    _id_A268CB99479F185D = 8000;
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(istrue(player.class == "medic"))
      _id_A268CB99479F185D = 6800;

    self.bplayerrevivingteammate = 1;
    _id_0AFB7E332AEE4BF2::set_revive_icon_color(self, (0.0117, 0.9882, 0.9882), 1);
    result = scripts\cp\utility::player_lua_progressbar(player, _id_A268CB99479F185D, 9216, 5);
    _id_0AFB7E332AEE4BF2::set_revive_icon_color(self, (1, 0, 0), 1);
    self.bplayerrevivingteammate = undefined;

    if(!result) {
      continue;
    }
    break;
  }

  playFX(level._effect["dogtag_pickup"], self.origin);
  downed_player _id_0AFB7E332AEE4BF2::instant_revive(downed_player);
  downed_player notify("last_stand_finished");
}

endreviveonownerdeathordisconnect() {
  self endon("disconnect");
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_2("disconnect", "last_stand_finished");
  self.owner = undefined;
  self delete();
}

checkpoint_revive() {
  level endon("game_ended");
  checkpoint = 1;

  for(;;) {
    level waittill("checkpoint_revive");
    _id_9522874AB2BF9C33 = scripts\engine\utility::getStructArray("player_checkpoint_" + checkpoint, "targetname");

    foreach(_id_AC0E594AC96AA3A8, player in level.players) {
      if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
        player.respawn_forcespawnorigin = _id_9522874AB2BF9C33[_id_AC0E594AC96AA3A8].origin;
        player.respawn_forcespawnangles = _id_9522874AB2BF9C33[_id_AC0E594AC96AA3A8].angles;
        player _id_0AFB7E332AEE4BF2::instant_revive(player);

        if(isDefined(player.dogtag))
          player.dogtag delete();
      }
    }

    checkpoint++;
  }
}

give_skillpoints_at_start() {
  self endon("disconnect");
  self waittill("loadout_given");

  if(!isDefined(self.starting_skillpoints_given))
    self.starting_skillpoints_given = 1;
}

givedefaultloadout(_id_86DB2022C4F0F4BF, _id_185EA69B2FE37360) {
  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  scripts\cp\survival\survival_loadout::givedefaultloadout(_id_86DB2022C4F0F4BF, _id_185EA69B2FE37360);
}

getspawnpoint() {
  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  _id_267CC90C53834B52 = scripts\engine\utility::getStructArray("default_player_start", "targetname");

  if(isDefined(level.default_player_spawns)) {
    _id_0F0700E8B95517CB = scripts\engine\utility::getStructArray(level.default_player_spawns, "targetname");

    if(_id_0F0700E8B95517CB.size > 0)
      _id_267CC90C53834B52 = _id_0F0700E8B95517CB;
  }

  return getassignedspawnpoint(_id_267CC90C53834B52);
}

getassignedspawnpoint(spawnpoints) {
  _id_556E8724DC4D8291 = self getentitynumber();
  return spawnpoints[_id_556E8724DC4D8291];
}

enable_lbravo_player_infil() {
  if(getdvarint("scr_skip_infils", 0) == 1) {
    return;
  }
  if(player_infil_already_played()) {
    return;
  }
  level.strike_player_connect_black_screen_fn = ::lbravo_infil_spawn_blackscreen_func;
  level thread delay_init_infil();
}

player_infil_already_played() {
  return istrue(game["player_infil_already_played"]);
}

delay_init_infil() {
  level endon("game_ended");
  _id_C36DC418FD5A866C = 4;
  wait(_id_C36DC418FD5A866C);
  level thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("alpha");
  level waittill("players_unloaded_from_infil");
  game["player_infil_already_played"] = 1;
}

lbravo_infil_spawn_blackscreen_func(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("stop_intro");
  _id_EEFD63015D3FE876 = 6;
  player setclientomnvar("ui_hide_hud", 1);
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0);

  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  if(scripts\engine\utility::flag_exist("introscreen_over"))
    scripts\engine\utility::flag_wait("introscreen_over");

  wait 5;
  player scripts\cp\survival\survival_loadout::givedefaultloadout(0, undefined, 0);
  player disableweapons();
  player scripts\cp\utility::freezecontrolswrapper(1);
  player setclientomnvar("ui_hide_hud", 0);
  player show_introscreen_text();
  wait(_id_EEFD63015D3FE876);
  player setclientomnvar("ui_hide_hud", 1);
  player setclientomnvar("ui_chyron_on", 0);
  player setclientomnvar("ui_chyron_mission_index", 0);
  _id_116171939929AF39::refreshuimatchinprogressomnvarvalue();
  player scripts\cp\utility::freezecontrolswrapper(0);
  player enableweapons();

  if(!scripts\cp\utility::gameflag("infil_started")) {
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0);
    level notify("trying_to_join_infil", player);
  } else {
    player notify("open_loadout_menu");
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 4);
    player setclientomnvar("ui_hide_hud", 0);
  }
}

update_laststand_times() {
  _id_0AFB7E332AEE4BF2::init_laststand_anims();
  inanim = level.scr_anim["ls_revive_helper"]["in_stand_1"];
  idleanim = level.scr_anim["ls_revive_helper"]["idle_stand_1"];
  _id_548EA94669718E62 = level.scr_anim["ls_revive_helper"]["out_stand_1"];
  _id_F05037A2663B00D9 = getanimlength(inanim);
  _id_2385B76CF2542716 = getanimlength(idleanim);
  _id_0DCD276B4FDA552A = getanimlength(_id_548EA94669718E62);
  _id_750C94BA41F40A47 = 0.5;
  normal_revive_time = (_id_F05037A2663B00D9 + _id_2385B76CF2542716 + _id_0DCD276B4FDA552A + _id_750C94BA41F40A47) * 1000;
  spectator_revive_time = 5000;
  fast_revive_time = (_id_F05037A2663B00D9 + _id_0DCD276B4FDA552A + _id_750C94BA41F40A47) * 1000;
  _id_0AFB7E332AEE4BF2::set_revive_time(normal_revive_time, spectator_revive_time, fast_revive_time);
}

ascendermsgfunc(_id_E94B62032A5AE9C3, time) {
  self endon("disconnect");
  scripts\cp\utility::hint_prompt(_id_E94B62032A5AE9C3, 1);
  wait(time);
  scripts\cp\utility::hint_prompt(_id_E94B62032A5AE9C3, 0);
}