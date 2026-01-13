/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\agents\gametype_zombie.gsc
*************************************************/

main() {
  scripts\cp\cp_globallogic::init();
  level thread onplayerconnect();
  init_callback_func();
  init_zombie_flags();
  init_zombie_fx();
  scripts\cp\cp_music_and_dialog::init();
  if(getdvarint("gnet_build", 0) != 0) {
    scripts\cp\utility::coop_mode_enable(["pillage", "loot", "challenge", "doors", "wall_buys", "crafting"]);
  } else {
    scripts\cp\utility::coop_mode_enable(["pillage", "loot", "challenge", "doors", "guided_interaction", "wall_buys", "crafting", "outline"]);
  }

  level.nodefiltertracestime = 0;
  level.nodefiltertracesthisframe = 0;
  level.wave_num = 0;
  level.laststand_currency_penalty_amount_func = ::zombie_laststand_currency_penalth_amount;
  level.disable_zombie_exo_abilities = 1;
  level.in_room_check_func = scripts\cp\zombies\zombies_spawning::is_in_any_room_volume;
  level.custom_giveloadout = scripts\cp\zombies\zombies_loadout::givedefaultloadout;
  level.move_speed_scale = scripts\cp\zombies\zombies_loadout::updatemovespeedscale;
  level.getnodearrayfunction = ::getnodearray;
  level.prematchfunc = ::default_zombie_prematch_func;
  level.callbackplayerdamage = scripts\cp\zombies\zombie_damage::callback_zombieplayerdamage;
  level.callbackplayerkilled = ::zombie_callbackplayerkilled;
  level.laststand_enter_gamemodespecificaction = ::func_13F1F;
  level.prespawnfromspectaorfunc = ::zombie_prespawnfromspectatorfunc;
  level.update_money_performance = scripts\cp\zombies\zombies_gamescore::update_money_earned_performance;
  level.rebuild_all_windows_func = scripts\cp\zombies\interaction_windowrepair::func_DDB4;
  level.var_B079 = scripts\cp\zombies\zombies_spawning::func_13FA2;
  level.loot_func = scripts\cp\loot::update_enemy_killed_event;
  level.upgrade_weapons_func = scripts\cp\zombies\interaction_weapon_upgrade::func_12F73;
  level.var_13D69 = scripts\cp\zombies\interaction_windowtraps::func_CC08;
  level.active_volume_check = scripts\cp\loot::is_in_active_volume;
  level.var_768C = ::func_13F35;
  level.var_E49D = ::func_13F50;
  level.splash_grenade_victim_scriptable_state_func = scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate;
  level.laststand_exit_gamemodespecificaction = ::func_13F20;
  level.onplayerdisconnected = ::func_13F44;
  level.endgame_write_clientmatchdata_for_player_func = ::func_13F1E;
  level.hostmigrationend = ::zombiehostmigrationend;
  level.var_C53D = ::zombiehostmigrationstart;
  level.arcade_last_stand_power_func = scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game;
  level.no_power_cooldowns = 1;
  level.zombiedlclevel = 1;
  level.var_4CB4 = 1;
  level.cycle_reward_scalar = 1;
  level.power_table = "cp\zombies\zombie_powertable.csv";
  level.statstable = "mp\statstable.csv";
  level.game_mode_statstable = "cp\zombies\mode_string_tables\zombies_statstable.csv";
  level.game_mode_attachment_map = "cp\zombies\zombie_attachmentmap.csv";
  var_0 = getdvar("ui_mapname");
  level.power_up_table = "cp\zombies\" + var_0 + "
  _loot.csv ";
  scripts\mp\passives::init();
  scripts\cp\cp_weapon::weaponsinit();
  scripts\cp\utility::healthregeninit(0);
  if(!isDefined(level.powers)) {
    level.powers = [];
  }

  level.overcook_func = [];
  level.hardcoremode = getdvarint("scr_aliens_hardcore");
  level.ricochetdamage = getdvarint("scr_aliens_ricochet");
  level.casualmode = getdvarint("scr_aliens_casual");
  level.last_loot_drop = 0;
  level.last_powers_dropped = [];
  level.cash_scalar = 1;
  level.insta_kill = 0;
  level.default_weapon = "iw7_g18_zmr";
  level.pap_max = 2;
  level.var_9B1A = 0;
  level.exploimpactmod = 0.1;
  level.shotgundamagemod = 0.1;
  level.armorpiercingmod = 0.2;
  level.maxlogclients = 10;
  scripts\cp\cp_outline::outline_init();
  scripts\cp\zombies\zombie_afterlife_arcade::init_afterlife_arcade();
  scripts\cp\zombies\zombies_gamescore::init_zombie_scoring();
  scripts\cp\zombies\craftables\_gascan::init();
  scripts\cp\agents\gametype_zombie::main();
  scripts\cp\zombies\craftables\_fireworks_trap::init();
  scripts\cp\zombies\zombie_quest::func_9700();
  scripts\cp\zombies\zombies_loadout::init();
  scripts\cp\zombies\directors_cut::init();
  scripts\cp\zombies\direct_boss_fight::init();
  level scripts\cp\cp_hud_message::init();
  level thread scripts\cp\zombies\zombies_pillage::init_pillage_drops();
  dev_damage_show_damage_numbers();
  level thread scripts\cp\cp_interaction::coop_interaction_pregame();
  level thread scripts\cp\utility::global_physics_sound_monitor();
  level thread scripts\cp\zombies\zombies_clientmatchdata::init();
  level thread func_11010();
}

blank() {}

waitforplayers() {
  while(!isDefined(level.players)) {
    wait(0.1);
  }
}

func_13F20(var_0) {
  var_0 scripts\cp\powers\coop_powers::restore_powers(var_0, var_0.pre_laststand_powers);
  var_0 scripts\cp\zombies\zombies_loadout::set_player_photo_status(var_0, "healthy");
  var_0.flung = undefined;
  var_0 setclientomnvar("zm_ui_player_in_laststand", 0);
  var_0 clearclienttriggeraudiozone(0.5);
  var_0 scripts\cp\utility::stoplocalsound_safe("zmb_laststand_music");
  var_0 clearclienttriggeraudiozone(0.3);
  if(isDefined(level.vision_set_override)) {
    var_0 thread reset_override_visionset(0.2);
  }

  var_0 visionsetnakedforplayer("", 0);
  var_1 = randomintrange(1, 5);
  var_2 = "zmb_revive_music_lr_0" + var_1;
  if(soundexists(var_2)) {
    var_0 playlocalsound(var_2);
  }

  if(var_0 scripts\cp\utility::isignoremeenabled()) {
    var_0 scripts\cp\utility::allow_player_ignore_me(0);
  }

  if(scripts\engine\utility::istrue(var_0.have_permanent_perks) && !scripts\engine\utility::istrue(var_0.playing_ghosts_n_skulls)) {
    var_0 thread give_permanent_perks(var_0);
  }
}

give_permanent_perks(var_0) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_1 = ["perk_machine_boom", "perk_machine_flash", "perk_machine_fwoosh", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_revive", "perk_machine_run", "perk_machine_smack", "perk_machine_tough", "perk_machine_zap"];
  if(isDefined(level.all_perk_list)) {
    var_1 = level.all_perk_list;
  }

  if(isDefined(self.current_perk_list)) {
    var_1 = self.current_perk_list;
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    var_1 = scripts\engine\utility::array_remove(var_1, "perk_machine_revive");
  }

  wait(1);
  foreach(var_3 in var_1) {
    if(var_0 scripts\cp\utility::has_zombie_perk(var_3)) {
      continue;
    }

    var_0 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_3, 0);
    scripts\engine\utility::waitframe();
  }
}

reset_override_visionset(var_0) {
  if(var_0 > 0) {
    wait(var_0);
  }

  if(isDefined(level.vision_set_override)) {
    self visionsetnakedforplayer(level.vision_set_override, 0.1);
  }
}

init_zombie_flags() {
  scripts\engine\utility::flag_init("insta_kill");
  scripts\engine\utility::flag_init("introscreen_over");
  scripts\engine\utility::flag_init("intro_gesture_done");
  scripts\engine\utility::flag_init("pre_game_over");
  scripts\engine\utility::flag_init("interactions_initialized");
}

init_zombie_fx() {
  level._effect["goon_spawn_bolt"] = loadfx("vfx\iw7\_requests\coop\vfx_clown_spawn.vfx");
  level._effect["goon_spawn_bolt_underground"] = loadfx("vfx\iw7\_requests\coop\vfx_clown_spawn_indoor.vfx");
  level._effect["brute_spawn_bolt"] = loadfx("vfx\iw7\_requests\coop\vfx_brute_spawn.vfx");
  level._effect["brute_spawn_bolt_indoor"] = loadfx("vfx\iw7\_requests\coop\vfx_brute_spawn_indoor.vfx");
  level._effect["corpse_pop"] = loadfx("vfx\iw7\_requests\mp\vfx_body_expl");
  level._effect["bloody_death"] = loadfx("vfx\iw7\core\zombie\cards\vfx_zmb_card_headshot_exp.vfx");
  level._effect["gore"] = loadfx("vfx\iw7\core\impact\flesh\vfx_flesh_hit_body_meatbag_large.vfx");
  level._effect["stun_attack"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_geotrail_tesla_01.vfx");
  level._effect["stun_shock"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_shock_flash.vfx");
}

init_callback_func() {
  level.onstartgametype = ::zombie_onstartgametype;
  level.onspawnplayer = ::zombie_onspawnplayer;
  level.onprecachegametype = ::zombie_onprecachegametype;
}

zombie_onstartgametype() {
  scripts\cp\zombies\coop_wall_buys::init();
  scripts\cp\cp_persistence::register_eog_to_lb_playerdata_mapping();
  if(isDefined(level.challenge_init_func)) {
    [[level.challenge_init_func]]();
  } else {
    scripts\cp\cp_challenge::init_coop_challenge();
  }

  scripts\cp\zombies\zombie_analytics::init();
  scripts\cp\cp_laststand::set_revive_time(3000, 5000);
  level.excludedattachments = [];
  level.var_F480 = ::set_player_max_currency;
  scripts\cp\cp_persistence::rank_init();
  level.damagelistsize = 20;
  scripts\cp\utility::alien_health_per_player_init();
  if(scripts\cp\utility::coop_mode_has("loot")) {
    scripts\cp\loot::init_loot();
  }

  if(scripts\cp\utility::coop_mode_has("pillage")) {
    thread scripts\cp\zombies\zombies_pillage::pillage_init();
  }

  level thread handle_nondeterministic_entities();
  level thread revive_players_between_waves_monitor();
  level.updaterecentkills_func = ::func_12EFE;
  level scripts\engine\utility::delaythread(0.2, scripts\cp\zombies\zombie_entrances::init_zombie_entrances);
  level.gamemode_perk_callback_init_func = scripts\cp\zombies\zombies_perk_machines::register_zombie_perks;
  scripts\cp\perks\perkmachines::init_zombie_perks_callback();
  scripts\cp\perks\perkmachines::init_perks_from_table();
  if(isDefined(level.player_respawn_locations_init)) {
    level thread[[level.player_respawn_locations_init]]();
  }

  thread scripts\cp\zombies\zombies_consumables::init_consumables();
  if(isDefined(level.spawn_vo_func)) {
    level thread[[level.spawn_vo_func]]();
  }

  scripts\cp\zombies\zombies_weapons::init();
  scripts\cp\zombies\zombie_quest::func_10CEF();
  level thread func_95C9();
  level thread scripts\cp\zombies\zombies_spawning::enemy_spawning_run();
  level thread scripts\cp\cp_interaction::init();
  level thread scripts\cp\zombies\zombie_doors::func_97B1();
  level thread scripts\cp\zombies\zombie_power::func_96F4();
  level thread scripts\cp\zombies\interaction_magicwheel::func_94EF();
  level thread validate_door_buy_setup();
  level thread scripts\cp\zombies\directors_cut::start_directors_cut();
  if(scripts\cp\utility::coop_mode_has("wall_buys")) {
    level thread scripts\cp\zombies\coop_wall_buys::func_23DA();
  } else {
    scripts\cp\cp_interaction::func_55A2();
  }

  if(isDefined(level.var_F9F1)) {
    level[[level.var_F9F1]]();
  } else {
    func_F9F0();
  }

  level thread reset_variables_on_wave_start();
}

func_F9F0() {
  level.opweaponsarray = ["iw7_venomx_zm", "iw7_venomx_zm_pap1+camo32", "iw7_venomx_zm_pap2+camo34"];
}

func_95C9() {
  scripts\cp\zombies\func_0D60::func_13F54();
  scripts\cp\zombies\zombies_spawning::enemy_spawner_init();
}

reset_variables_on_wave_start() {
  level endon("game_ended");
  for(;;) {
    level waittill("wave_starting");
    foreach(var_1 in level.players) {
      var_1.can_give_revive_xp = 1;
    }
  }
}

zombie_onprecachegametype() {}

zombie_onspawnplayer() {
  onspawnplayer();
  thread scripts\cp\zombies\zombies_vo::zombie_behind_vo();
}

handle_nondeterministic_entities() {
  wait(5);
  level notify("spawn_nondeterministic_entities");
  if(isDefined(level.post_nondeterministic_func)) {
    level thread[[level.post_nondeterministic_func]]();
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    if(!isDefined(level.special_character_count)) {
      level.special_character_count = 0;
    }

    if(!isai(var_0)) {
      var_0 scripts\cp\cp_analytics::on_player_connect();
      var_0 thread watchforluinotifyweaponreset(var_0);
      if(isDefined(var_0.connecttime)) {
        var_0.connect_time = var_0.connecttime;
      } else {
        var_0.connect_time = gettime();
      }

      if(scripts\cp\utility::coop_mode_has("outline")) {
        var_0 thread scripts\cp\cp_outline::outline_monitor_think();
      }

      var_0.xpscale = getdvarint("online_zombies_xpscale");
      var_0.weaponxpscale = getdvarint("online_zombie_weapon_xpscale");
      if(var_0 scripts\cp\utility::rankingenabled()) {
        var_1 = getdvarint("online_zombie_party_weapon_xpscale");
        var_2 = getdvarint("online_zombie_party_xpscale");
        var_3 = var_0 func_85BE() > 1;
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

      var_0 thread scripts\cp\cp_globallogic::player_init_health_regen();
      var_0 scripts\cp\cp_gamescore::init_player_score();
      var_0 scripts\cp\cp_persistence::session_stats_init();
      var_0.var_C1F6 = [];
      var_0.var_BF74 = 0;
      var_0.total_currency_earned = 0;
      var_0.can_give_revive_xp = 1;
      if(!isDefined(var_0.pap)) {
        var_0.pap = [];
      }

      if(!isDefined(var_0.powerupicons)) {
        var_0.powerupicons = [];
      }

      if(!isDefined(var_0.powers)) {
        var_0.powers = [];
      }

      if(!isDefined(var_0.powers_active)) {
        var_0.powers_active = [];
      }

      if(!isDefined(var_0.disabled_interactions)) {
        var_0.disabled_interactions = [];
      }

      if(!isDefined(var_0.var_C54A)) {
        var_0.var_C54A = [];
      }

      if(!isDefined(var_0.var_C5C9)) {
        var_0.var_C5C9 = [];
      }

      if(!isDefined(var_0.var_C4E6)) {
        var_0.var_C4E6 = [];
      }

      var_0 thread zombie_player_connect_black_screen();
      var_0.disabledteleportation = 0;
      var_0.disabledinteractions = 0;
      var_0 scripts\cp\utility::allow_player_teleport(0);
      var_0.power_cooldowns = 0;
      var_0.tickets_earned = 0;
      var_0.time_to_give_next_tickets = gettime();
      var_0.self_revives_purchased = 0;
      var_0.max_self_revive_machine_use = 3;
      var_0.cash_scalar = 1;
      var_0.var_DDC2 = 0;
      var_0.ignorme_count = 0;
      var_0.infiniteammocounter = 0;
      var_0 scripts\cp\zombies\zombie_afterlife_arcade::init_soul_power(var_0);
      if(scripts\engine\utility::flag("introscreen_over")) {
        if(isDefined(level.custom_player_hotjoin_func)) {
          var_0 thread[[level.custom_player_hotjoin_func]]();
        } else {
          var_0 thread player_hotjoin();
        }

        if(scripts\cp\cp_challenge::current_challenge_exist() && scripts\cp\utility::coop_mode_has("challenge")) {
          if(isDefined(level.challenge_hotjoin_func)) {
            var_0 thread[[level.challenge_hotjoin_func]]();
          }
        }
      }

      var_0 scripts\cp\zombies\zombie_afterlife_arcade::player_init_afterlife(var_0);
      var_0 scripts\cp\cp_persistence::lb_player_update_stat("waveNum", level.wave_num, 1);
      var_0 scripts\cp\zombies\zombies_consumable_replenishment::player_init(var_0);
      var_0 scripts\cp\zombies\coop_wall_buys::func_FA1D(var_0);
      var_0 scripts\cp\cp_persistence::player_persistence_init();
      var_0 thread scripts\cp\zombies\zombie_analytics::func_97A4(var_0);
      var_0 thread streamweaponsonzonechange(var_0);
      if(isDefined(level.custom_onplayerconnect_func)) {
        [[level.custom_onplayerconnect_func]](var_0);
      }

      if(!scripts\cp\utility::map_check(0) && !scripts\cp\utility::map_check(1)) {
        if(!isDefined(level.kick_player_queue)) {
          level thread kick_player_queue_loop();
        }

        var_0 thread kick_for_inactivity(var_0);
      }
    }
  }
}

watchforluinotifyweaponreset(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("weaponplayerdatafinished");
  var_1 = "cp\cp_wall_buy_models.csv";
  if(scripts\cp\utility::map_check(3)) {
    var_1 = "cp\cp_town_wall_buy_models.csv";
  } else if(scripts\cp\utility::map_check(2)) {
    var_1 = "cp\cp_disco_wall_buy_models.csv";
  } else if(scripts\cp\utility::map_check(4)) {
    var_1 = "cp\cp_final_wall_buy_models.csv";
  }

  for(;;) {
    var_0 waittill("luinotifyserver", var_2, var_3);
    if(isDefined(var_2)) {
      if(var_2 == "reset_weapon_player_data") {
        var_4 = tablelookupbyrow(var_1, var_3, 1);
        if(isDefined(var_4)) {
          var_5 = tablelookup(var_1, 0, var_3, 2);
          if(isDefined(var_5) && var_5 != "") {
            var_0 setplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_5, "variantID", -1);
          }
        }

        continue;
      }

      if(var_2 == "weaponplayerdatafinished") {
        var_0 notify("weaponplayerdatafinished");
      }
    }
  }
}

streamweaponsonzonechange(var_0) {
  var_0 endon("disconnect");
  var_0 endon("kill_weapon_stream");
  level endon("game_ended");
  var_0 scripts\engine\utility::waittill_any_timeout_1(10, "player_spawned");
  scripts\engine\utility::flag_wait("wall_buy_setup_done");
  var_1 = [];
  var_2 = scripts\engine\utility::getstructarray("interaction", "targetname");
  foreach(var_4 in var_2) {
    if(isDefined(var_4.name) && var_4.name == "wall_buy") {
      var_1[var_1.size] = var_4;
    }
  }

  var_6 = 1;
  for(;;) {
    var_7 = 0;
    var_8 = 0;
    var_9 = [self.last_stand_pistol];
    var_0A = scripts\engine\utility::get_array_of_closest(var_0.origin, var_1, undefined, 10, 5000, 0);
    while(var_7 <= var_6 && var_8 < var_0A.size) {
      var_0B = scripts\cp\utility::getrawbaseweaponname(var_0A[var_8].script_noteworthy);
      if(isDefined(var_0.weapon_build_models[var_0B])) {
        var_0C = var_0.weapon_build_models[var_0B];
      } else {
        var_0C = var_0A[var_8].script_noteworthy;
      }

      var_9[var_9.size] = var_0C;
      var_9 = scripts\engine\utility::array_remove_duplicates(var_9);
      var_7 = var_9.size;
      var_8++;
    }

    var_0 loadweaponsforplayer(var_9);
    wait(1);
  }
}

player_hotjoin() {
  self endon("disconnect");
  self notify("intro_done");
  self notify("stop_intro");
  self waittill("spawned");
  thread hotjoin_protection();
  self.pers["hotjoined"] = 1;
  if(isDefined(level.wave_num)) {
    self.wave_num_when_joined = level.wave_num;
  }

  var_0 = getdvar("ui_mapname");
  if(var_0 == "cp_rave") {
    disablepaspeaker("pa_speaker_stage_2");
    disablepaspeaker("pa_speaker_path");
    if(!scripts\engine\utility::istrue(level.slasherpa)) {
      disablepaspeaker("pa_super_slasher");
    }
  }

  if(var_0 == "cp_disco") {
    if(scripts\engine\utility::istrue(level.ratking_playlist)) {
      disablepaspeaker("pa_punk_alley_1");
      disablepaspeaker("pa_punk_subway_1");
      disablepaspeaker("pa_punk_subway_2");
      disablepaspeaker("pa_punk_rooftops_2");
      disablepaspeaker("pa_punk_rooftops_3");
      disablepaspeaker("pa_disco_street_1");
      disablepaspeaker("pa_disco_street_3");
      disablepaspeaker("pa_disco_subway_2");
      disablepaspeaker("pa_disco_subway_1");
      disablepaspeaker("pa_park_1");
    } else {
      disablepaspeaker("pa_punk_alley_1");
      disablepaspeaker("pa_punk_subway_1");
      disablepaspeaker("pa_punk_subway_2");
      disablepaspeaker("pa_punk_rooftops_2");
      disablepaspeaker("pa_punk_rooftops_3");
      disablepaspeaker("pa_disco_street_1");
      disablepaspeaker("pa_disco_street_3");
      disablepaspeaker("pa_disco_subway_2");
      disablepaspeaker("pa_disco_subway_1");
      disablepaspeaker("pa_park_1");
      disablepaspeaker("pa_disco_club");
      disablepaspeaker("pa_punk_club");
      disablepaspeaker("pa_rk_arena");
    }
  }

  if(var_0 == "cp_town") {
    if(!scripts\engine\utility::istrue(level.power_on)) {
      disablepaspeaker("pa_town_icecream_out");
      disablepaspeaker("pa_town_icecream_in");
      disablepaspeaker("pa_town_snackshake_out");
      disablepaspeaker("pa_town_motel_out");
      disablepaspeaker("pa_town_market_in");
      disablepaspeaker("pa_town_market_out");
      disablepaspeaker("pa_town_camper_out");
    }
  }

  if(isDefined(self.introscreen_overlay)) {
    self.introscreen_overlay.alpha = 1;
    wait(3);
    self.introscreen_overlay fadeovertime(3);
    self.introscreen_overlay.alpha = 0;
    wait(3);
    if(isDefined(self.introscreen_overlay)) {
      self.introscreen_overlay destroy();
    }
  }

  while(!scripts\engine\utility::istrue(self.photosetup)) {
    wait(1);
  }

  self setclientomnvar("ui_hide_hud", 0);
  self.reboarding_points = 0;
  wait(3);
  scripts\cp\zombies\zombies_consumables::init_player_consumables();
  scripts\cp\zombies\zombie_afterlife_arcade::init_soul_power(self);
  if(getdvar("ui_gametype") == "zombie") {
    self setclientomnvar("zombie_wave_number", level.wave_num);
  }

  if(isDefined(level.char_intro_gesture)) {
    self[[level.char_intro_gesture]]();
  }

  level thread reenable_zombie_emmisive();
}

reenable_zombie_emmisive() {
  var_0 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  foreach(var_2 in var_0) {
    if(scripts\engine\utility::istrue(var_2.is_suicide_bomber)) {
      continue;
    } else if(scripts\engine\utility::istrue(var_2.is_turned)) {
      continue;
    }

    var_2 getrandomhovernodesaroundtargetpos(1, 0.1);
    wait(0.05);
  }
}

hotjoin_protection() {
  self endon("disconnect");
  self.ignoreme = 1;
  self.ability_invulnerable = 1;
  wait(8);
  self.ignoreme = 0;
  self.ability_invulnerable = undefined;
}

onspawnplayer() {
  self.pers["gamemodeLoadout"] = level.alien_loadout;
  self setclientomnvar("ui_refresh_hud", 1);
  self.drillspeedmodifier = 1;
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
  self.ignorme_count = 0;
  self.ignoreme = 0;
  self.hide_tutorial = 1;
  self.flung = undefined;
  self.is_holding_deployable = 0;
  self.has_special_weapon = 0;
  self.lastkilltime = gettime();
  self.lastmultikilltime = gettime();
  self setclientomnvar("zm_ui_player_in_laststand", 0);
  func_98B8();
  thread scripts\cp\perks\perkfunctions::watchcombatspeedscaler();
  if(!scripts\engine\utility::istrue(level.dont_resume_wave_after_solo_afterlife)) {
    if(!scripts\cp\utility::isplayingsolo() && !level.only_one_player) {
      scripts\engine\utility::flag_clear("pause_wave_progression");
      level.zombies_paused = 0;
    }
  }

  if(isDefined(level.custom_onspawnplayer_func)) {
    self[[level.custom_onspawnplayer_func]]();
  }

  scripts\cp\cp_globallogic::player_init_invulnerability();
  scripts\cp\cp_globallogic::player_init_damageshield();
  var_0 = get_starting_currency(self);
  thread scripts\cp\cp_persistence::wait_to_set_player_currency(var_0);
  set_player_max_currency(999999);
  thread watchglproxy();
  thread scripts\cp\utility::playerhealthregen();
  thread scripts\cp\zombies\zombies_spawning::func_D1F7();
  thread scripts\cp\cp_hud_util::zom_player_health_overlay_watcher();
  thread scripts\cp\zombies\zombies_weapons::weapon_watch_hint();
  thread scripts\cp\zombies\zombies_weapons::axe_damage_cone();
  if(isDefined(level.katana_damage_cone_func)) {
    self thread[[level.katana_damage_cone_func]]();
  }

  thread scripts\cp\zombies\zombies_weapons::reload_watcher();
  if(getdvar("ui_mapname") == "cp_zmb") {
    thread func_9B1A();
  }

  thread func_172D();
  thread scripts\cp\cp_weapon::watchweaponusage();
  thread scripts\cp\cp_weapon::watchweaponchange();
  thread scripts\cp\cp_weapon::watchweaponfired();
  thread scripts\cp\cp_weapon::watchplayermelee();
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    thread scripts\cp\cp_hud_message::init_tutorial_message_array();
  }

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  scripts\cp\utility::force_usability_enabled();
}

func_98B8() {
  self setclientomnvar("zombie_arcade_game_time", -1);
  self setclientomnvar("zombie_arcade_game_ticket_earned", 0);
}

func_172D() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(self == level.players[var_0]) {
      var_1 = var_0 + 1;
      if(var_1 == 5) {
        return;
      }

      self give_zombies_perk("player" + var_1);
    }
  }
}

loadplayerassets(var_0) {
  var_1 = [];
  if(isDefined(var_0.primaryweapon)) {
    var_1[var_1.size] = var_0.primaryweapon;
  }

  if(isDefined(var_0.secondaryweapon)) {
    var_1[var_1.size] = var_0.secondaryweapon;
  }

  if(var_1.size > 0) {
    self loadweaponsforplayer(var_1);
  }
}

get_starting_currency(var_0) {
  var_1 = var_0.starting_currency_after_revived_from_spectator;
  if(isDefined(var_1)) {
    var_0.starting_currency_after_revived_from_spectator = undefined;
    return var_1;
  }

  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    return scripts\cp\zombies\direct_boss_fight::get_direct_to_boss_fight_starting_currency();
  }

  if(scripts\cp\zombies\directors_cut::directors_cut_activated_for(var_0)) {
    return scripts\cp\zombies\directors_cut::get_directors_cut_starting_currency();
  }

  return scripts\cp\cp_persistence::get_starting_currency();
}

set_player_max_currency(var_0) {
  var_0 = int(var_0);
  self.maxcurrency = var_0;
}

replace_grenades_between_waves() {
  level endon("game_ended");
  foreach(var_1 in level.players) {
    thread replace_grenades_on_player(var_1);
  }
}

replace_grenades_on_player(var_0) {
  if(scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
    var_0.refill_powers_after_kungfu = 1;
    return;
  }

  var_1 = getarraykeys(var_0.powers);
  foreach(var_3 in var_1) {
    if(var_0.powers[var_3].slot == "secondary") {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
      var_0 thread wait_for_last_stand();
      continue;
    }

    var_0 thread recharge_power(var_3);
  }

  if(isDefined(var_0.pre_arcade_primary_power) && isDefined(var_0.pre_arcade_primary_power_charges)) {
    var_0.pre_arcade_primary_power_charges = level.powers[var_0.pre_arcade_primary_power].maxcharges;
  }
}

wait_for_last_stand() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("spawned_player");
  wait(1);
  var_0 = getarraykeys(self.powers);
  if(var_0.size < 1) {
    return;
  }

  foreach(var_2 in var_0) {
    if(self.powers[var_2].slot == "secondary") {
      continue;
    }

    thread recharge_power(var_2);
  }
}

recharge_power(var_0) {
  var_1 = 2;
  while(scripts\engine\utility::istrue(self.powers[var_0].var_19)) {
    wait(0.05);
  }

  while(scripts\engine\utility::istrue(self.powers[var_0].updating)) {
    wait(0.05);
  }

  scripts\cp\powers\coop_powers::power_adjustcharges(var_1, "primary");
}

revive_players_between_waves_monitor() {
  level endon("game_ended");
  for(;;) {
    level waittill("spawn_wave_done");
    foreach(var_1 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
        if(scripts\engine\utility::istrue(var_1.kill_trigger_event_processed)) {
          level thread delayed_instant_revive(var_1);
          continue;
        }

        scripts\cp\cp_laststand::instant_revive(var_1);
        thread scripts\cp\cp_vo::try_to_play_vo("respawn_round", "zmb_comment_vo", "high", 5, 0, 0, 1, 60);
      }
    }
  }
}

delayed_instant_revive(var_0) {
  var_0 endon("disconnect");
  var_0 endon("revive");
  wait(4);
  scripts\cp\cp_laststand::instant_revive(var_0);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("respawn_round", "zmb_comment_vo", "high", 5, 0, 0, 1, 60);
}

zombie_prespawnfromspectatorfunc(var_0) {
  var_0.starting_currency_after_revived_from_spectator = var_0 scripts\cp\cp_persistence::get_player_currency();
  scripts\cp\zombies\zombie_lost_and_found::save_items_to_lost_and_found(var_0);
  var_0 scripts\cp\zombies\zombies_perk_machines::remove_perks_from_player();
  revive_from_spectator_weapon_setup(var_0);
  set_spawn_loc(var_0);
  take_away_special_ammo(var_0);
  scripts\cp\zombies\zombie_afterlife_arcade::try_exit_afterlife_arcade(var_0);
}

revive_from_spectator_weapon_setup(var_0) {
  var_0 scripts\cp\utility::clear_weapons_status();
  var_1 = var_0.currentmeleeweapon;
  var_2 = weaponclipsize(var_1);
  var_3 = weaponmaxammo(var_1);
  var_4 = var_0.default_starting_pistol;
  var_5 = weaponclipsize(var_4);
  var_6 = weaponmaxammo(var_4);
  var_7 = "super_default_zm";
  var_8 = weaponclipsize("super_default_zm");
  var_9 = weaponmaxammo("super_default_zm");
  var_0A = [];
  var_0B = [];
  var_0C = [];
  var_0A[var_0A.size] = var_1;
  var_0B[var_1] = var_2;
  var_0C[var_1] = var_3;
  var_0A[var_0A.size] = var_4;
  var_0B[var_4] = var_5;
  var_0C[var_4] = var_6;
  var_0A[var_0A.size] = var_7;
  var_0B[var_7] = var_8;
  var_0C[var_7] = var_9;
  var_0 scripts\cp\utility::add_to_weapons_status(var_0A, var_0B, var_0C, var_4);
  var_0.pre_laststand_weapon = var_4;
  var_0.pre_laststand_weapon_stock = var_6;
  var_0.pre_laststand_weapon_ammo_clip = var_5;
  var_0.lastweapon = var_4;
}

set_spawn_loc(var_0) {
  var_1 = zombie_get_player_respawn_loc(var_0);
  var_0.forcespawnorigin = var_1.origin;
  var_0.forcespawnangles = var_1.angles;
}

zombie_get_player_respawn_loc(var_0) {
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
  var_2 = func_784D(var_1);
  if(var_2.size == 0) {
    return get_respawn_loc_near_team_center(var_0, var_1);
  }

  if(var_2.size == 1) {
    return var_2[0];
  }

  return var_0 get_respawn_loc_rated(var_1, var_2);
}

get_available_players(var_0) {
  var_1 = [];
  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

func_784D(var_0) {
  var_1 = [];
  foreach(var_3 in level.active_player_respawn_locs) {
    if(!canspawn(var_3.origin)) {
      continue;
    }

    if(positionwouldtelefrag(var_3.origin)) {
      continue;
    }

    if(func_9CA5(var_3, var_0)) {
      continue;
    }

    if(func_9CA4(var_3)) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

func_9CA5(var_0, var_1) {
  var_2 = 250000;
  foreach(var_4 in var_1) {
    if(distancesquared(var_4.origin, var_0.origin) < var_2) {
      return 1;
    }
  }

  return 0;
}

func_9CA4(var_0) {
  var_1 = 250000;
  var_2 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  foreach(var_4 in var_2) {
    if(distancesquared(var_4.origin, var_0.origin) < var_1) {
      return 1;
    }
  }

  return 0;
}

get_respawn_loc_near_team_center(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  foreach(var_7 in var_1) {
    var_2 = var_2 + var_7.origin[0];
    var_3 = var_3 + var_7.origin[1];
    var_4 = var_4 + var_7.origin[2];
    var_5++;
  }

  var_9 = (var_2 / var_5, var_3 / var_5, var_4 / var_5);
  var_0A = sortbydistance(level.active_player_respawn_locs, var_9);
  return var_0A[0];
}

get_respawn_loc_rated(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_0.size == 0, 1, var_0.size);
  var_3 = level.spawned_enemies.size / var_2;
  var_4 = var_3 * 2;
  var_5 = -99999999;
  var_6 = undefined;
  foreach(var_8 in var_1) {
    var_9 = 0;
    foreach(var_0B in var_0) {
      if(var_0B == self) {
        continue;
      }

      if(!isalive(var_0B)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_0B.inlaststand)) {
        var_9 = var_9 - distancesquared(var_0B.origin, var_8.origin) * var_4 * 2;
        continue;
      }

      var_9 = var_9 - distancesquared(var_0B.origin, var_8.origin) * var_4;
    }

    foreach(var_0E in level.spawned_enemies) {
      var_9 = var_9 + distancesquared(var_0E.origin, var_8.origin);
    }

    var_9 = var_9 / 1000000;
    if(var_9 > var_5) {
      var_5 = var_9;
      var_6 = var_8;
    }
  }

  return var_6;
}

take_away_special_ammo(var_0) {
  var_0.special_ammo_type = undefined;
}

default_zombie_prematch_func() {
  var_0 = 0;
  if(!scripts\engine\utility::istrue(level.introscreen_done)) {
    var_0 = 10;
  }

  if(scripts\engine\utility::istrue(game["gamestarted"])) {
    var_0 = 0;
  }

  if(var_0 > 0) {
    var_1 = level wait_for_first_player_connect();
    level thread show_introscreen_text();
    if(isDefined(level.intro_dialogue_func)) {
      level thread[[level.intro_dialogue_func]]();
    }

    wait(var_0 - 3);
    if(isDefined(level.postintroscreenfunc)) {
      [
        [level.postintroscreenfunc]
      ]();
    }

    scripts\engine\utility::flag_set("introscreen_over");
    level.introscreen_done = 1;
  } else {
    wait(1);
    level.introscreen_done = 1;
    scripts\engine\utility::flag_set("introscreen_over");
  }

  if(scripts\engine\utility::istrue(level.preloadcinematicforall)) {}
}

show_introscreen_text() {
  if(isDefined(level.introscreen_text_func)) {
    [[level.introscreen_text_func]]();
  }
}

wait_for_first_player_connect() {
  var_0 = undefined;
  if(level.players.size == 0) {
    level waittill("connected", var_0);
  } else {
    var_0 = level.players[0];
  }

  return var_0;
}

zombie_player_connect_black_screen() {
  self endon("disconnect");
  self endon("stop_intro");
  self setclientomnvar("ui_hide_hud", 1);
  self getradiuspathsighttestnodes();
  self.introscreen_overlay = newclienthudelem(self);
  self.introscreen_overlay.x = 0;
  self.introscreen_overlay.y = 0;
  self.introscreen_overlay setshader("black", 640, 480);
  self.introscreen_overlay.alignx = "left";
  self.introscreen_overlay.aligny = "top";
  self.introscreen_overlay.sort = 1;
  self.introscreen_overlay.horzalign = "fullscreen";
  self.introscreen_overlay.vertalign = "fullscreen";
  self.introscreen_overlay.alpha = 1;
  self.introscreen_overlay.foreground = 1;
  if(!scripts\engine\utility::flag("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  self.introscreen_overlay fadeovertime(2);
  self.introscreen_overlay.alpha = 0;
  while(!scripts\engine\utility::istrue(self.photosetup)) {
    wait(1);
  }

  var_0 = 2;
  var_1 = getdvar("ui_mapname");
  if(var_1 == "cp_town" && !self issplitscreenplayer() && !isDefined(level.cp_town_bink_played) && !scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    wait(2);
    self playlocalsound("mus_zombies_title_splash");
    self setclientomnvar("zm_ui_dialpad_9", 1);
    var_0 = 4;
    level.cp_town_bink_played = 1;
    wait(var_0);
  } else {
    wait(var_0);
  }

  self setclientomnvar("zm_ui_dialpad_9", 0);
  self setclientomnvar("ui_hide_hud", 0);
  if(isDefined(level.char_intro_music)) {
    self thread[[level.char_intro_music]]();
  }

  if(var_1 != "cp_town") {
    wait(1.5);
  }

  self.introscreen_overlay destroy();
  if(var_1 != "cp_town") {
    func_CE90();
  }

  scripts\engine\utility::flag_set("intro_gesture_done");
  scripts\cp\zombies\zombies_consumables::init_player_consumables();
  wait(3);
  if(isDefined(level.char_intro_gesture)) {
    self[[level.char_intro_gesture]]();
  }

  wait(1.5);
  scripts\cp\utility::freezecontrolswrapper(0);
  self enableweapons();
  if(var_1 == "cp_town" && isDefined(level.film_grain_off)) {
    self setclientomnvar("zm_ui_dialpad_9", 2);
  }
}

func_CE90() {
  self setweaponammostock("iw7_walkietalkie_zm", 1);
  self giveandfireoffhand("iw7_walkietalkie_zm");
}

melee_strength_timer() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("shock_melee_upgrade activated");
  self.meleestrength = 1;
  var_0 = 1;
  self.meleestrength = 0;
  var_1 = gettime();
  for(;;) {
    var_2 = gettime();
    if(var_2 - var_1 >= level.playermeleestunregentime) {
      self.meleestrength = 1;
    } else {
      self.meleestrength = 0;
    }

    if(self meleebuttonpressed() && !self getteamsize() && !self usebuttonpressed()) {
      var_1 = gettime();
      if(var_0 == 1) {
        var_0 = 0;
      }
    } else if(!self meleebuttonpressed()) {
      var_0 = 1;
    } else {
      var_0 = 0;
    }

    wait(0.05);
  }
}

hasgl3weapon() {
  var_0 = 0;
  var_1 = self getweaponslist("primary");
  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(isgl3weapon(var_3)) {
        var_0 = 1;
        break;
      }
    }
  }

  return var_0;
}

isgl3weapon(var_0) {
  var_1 = getweaponbasename(var_0);
  if(!isDefined(var_1)) {
    return 0;
  }

  return var_0 == "iw7_glprox_zm";
}

watchglproxy() {
  self endon("death");
  self endon("disconnect");
  self endon("endExpJump");
  level endon("game_ended");
  var_0 = undefined;
  self notifyonplayercommand("fired", "+attack");
  for(;;) {
    scripts\engine\utility::waittill_any_3("weapon_switch_started", "weapon_change", "weaponchange");
    self notify("stop_regen_on_weapons");
    wait(0.1);
    var_1 = self getweaponslistall();
    foreach(var_3 in var_1) {
      if(isgl3weapon(var_3)) {
        var_0 = 1;
        continue;
      }

      var_0 = 0;
    }
  }
}

zombie_laststand_currency_penalth_amount(var_0) {
  var_1 = var_0 scripts\cp\cp_persistence::get_player_currency();
  var_1 = var_1 * 0.05;
  var_1 = int(var_1 / 10) * 10;
  return var_1;
}

zombie_callbackplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\cp\zombies\zombie_analytics::func_AF84(self, var_8);
  [[level.callbackplayerlaststand]](var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9);
}

func_1BA3() {}

on_alien_type_killed(var_0) {}

dev_damage_show_damage_numbers() {
  if(getdvarint("zm_damage_numbers", 0) == 1) {
    setomnvar("zm_dev_damage", 1);
    return;
  }

  setomnvar("zm_dev_damage", 0);
}

precachelb() {
  var_0 = " LB_" + getdvar("ui_mapname");
  if(scripts\cp\utility::isplayingsolo()) {
    var_0 = var_0 + "_SOLO";
  } else {
    var_0 = var_0 + "_COOP";
  }

  precacheleaderboards(var_0);
}

func_13F1F(var_0) {
  var_0.pre_laststand_powers = var_0 scripts\cp\powers\coop_powers::get_info_for_player_powers(var_0);
  var_0 scripts\cp\powers\coop_powers::clearpowers();
  var_1 = var_0 getcurrentweapon();
  var_2 = getweaponbasename(var_1);
  var_3 = var_0 getcurrentweaponclipammo();
  if(!isDefined(var_0.downsperweaponlog[var_2])) {
    var_0.downsperweaponlog[var_2] = 1;
  } else {
    var_0.downsperweaponlog[var_2]++;
  }

  if(!scripts\engine\utility::istrue(level.no_laststand_music)) {
    var_0 scripts\cp\utility::playlocalsound_safe("zmb_laststand_music");
  }

  var_0 clearclienttriggeraudiozone(0);
  if(!self issplitscreenplayer()) {
    var_0 setclienttriggeraudiozonepartialwithfade("last_stand_cp", 0.02, "mix", "reverb", "filter");
  }

  var_0.have_self_revive = var_0 scripts\cp\utility::has_zombie_perk("perk_machine_revive") || var_0 scripts\cp\utility::is_consumable_active("self_revive") && !scripts\engine\utility::istrue(var_0.disable_self_revive_fnf);
  if(isDefined(level.have_self_revive_override)) {
    var_0.have_self_revive = [[level.have_self_revive_override]](var_0);
  }

  if(var_0.have_self_revive) {
    var_4 = (scripts\cp\utility::isplayingsolo() || level.only_one_player) && var_0 scripts\cp\utility::has_zombie_perk("perk_machine_revive");
    var_0 notify("player_has_self_revive", var_4);
  }

  if(isDefined(var_0.mule_weapon) && !scripts\engine\utility::istrue(var_0.playing_ghosts_n_skulls)) {
    var_0.former_mule_weapon = var_0.mule_weapon;
  } else {
    var_0.former_mule_weapon = undefined;
  }

  var_0 scripts\cp\zombies\zombies_perk_machines::remove_perks_from_player();
  scripts\cp\zombies\zombie_analytics::func_AF68(1, var_0, var_1, var_3, var_0.recent_attacker, var_0.origin, level.wave_num, var_0.setculldist);
  var_0 scripts\cp\zombies\zombies_clientmatchdata::logplayerdeath();
  var_0 scripts\cp\zombies\zombies_loadout::set_player_photo_status(var_0, "laststand");
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 setclientomnvar("zm_ui_player_in_laststand", 1);
  var_0 setclientomnvarbit("player_damaged", 2, 0);
  var_0 visionsetnakedforplayer("last_stand_cp_zmb", 1);
}

func_9B1A() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  var_0 = 0;
  var_1 = 1;
  if(!scripts\cp\utility::is_codxp()) {
    while(var_0 < 3) {
      level waittill("spawn_wave_done");
      if(0 == var_1 % 2 && var_1 > 1) {
        foreach(var_3 in level.players) {
          var_3 setclientomnvar("zm_nag_text", 1);
        }

        var_0 = var_0 + 1;
      }

      var_1 = var_1 + 1;
      wait(0.5);
      foreach(var_3 in level.players) {
        var_3 setclientomnvar("zm_nag_text", 0);
      }
    }
  }
}

func_13F35() {
  scripts\cp\zombies\zombie_afterlife_arcade::register_interactions();
  scripts\cp\zombies\interaction_shooting_gallery::register_interactions();
  scripts\cp\zombies\zombie_lost_and_found::register_interactions();
  scripts\cp\zombies\zombies_perk_machines::register_interactions();
  scripts\cp\zombies\zombie_power::register_interactions();
  scripts\cp\zombies\interaction_windowrepair::register_interactions();
  scripts\cp\zombies\zombies_consumable_replenishment::register_interactions();
}

func_13F50(var_0) {
  if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    return 0;
  }

  return 1;
}

func_12EFE(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.var_DDC2++;
  var_2 = getweaponbasename(var_1);
  if(var_1 == "zmb_fireworksprojectile_mp") {
    if(!isDefined(self.killswithitem[self.itemtype])) {
      self.killswithitem[self.itemtype] = 1;
    } else {
      self.killswithitem[self.itemtype]++;
    }
  }

  if(!isDefined(self.killsperweaponlog[var_2])) {
    self.killsperweaponlog[var_2] = 1;
  } else {
    self.killsperweaponlog[var_2]++;
  }

  if(!isDefined(self.var_DDC3)) {
    self.var_DDC3 = [];
  }

  if(!isDefined(self.var_DDC3[var_1])) {
    self.var_DDC3[var_1] = 1;
  } else {
    self.var_DDC3[var_1]++;
  }

  var_3 = scripts\cp\utility::getequipmenttype(var_1);
  if(isDefined(var_3) && var_3 == "lethal") {
    if(self.var_DDC3[var_1] > 0 && self.var_DDC3[var_1] % 2 == 0) {}
  }

  wait(1.25);
  self.var_DDC2 = 0;
  self.var_DDC3 = undefined;
}

func_11010() {
  level endon("game_ended");
  for(;;) {
    level waittill("regular_wave_starting");
    if(level.wave_num >= 6) {
      break;
    }
  }

  setnojiptime(1);
}

func_13F44(var_0, var_1) {
  scripts\cp\cp_persistence::eog_update_on_player_disconnect(var_0);
  scripts\cp\zombies\zombies_loadout::release_character_number(var_0);
  scripts\cp\zombies\zombies_loadout::set_player_photo_status(var_0, "healthy");
}

func_13F1E(var_0, var_1) {
  scripts\cp\zombies\zombies_consumables::write_consumable_used(var_0, var_1);
}

zombiehostmigrationstart() {
  var_0 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  foreach(var_2 in var_0) {
    var_3 = isDefined(var_2.agent_type) && var_2.agent_type == "zombie_brute" || var_2.agent_type == "zombie_grey" || var_2.agent_type == "superslasher" || var_2.agent_type == "slasher" || var_2.agent_type == "zombie_ghost";
    if(!var_3 && !var_2 scripts\cp\utility::agentisinstakillimmune()) {
      if(scripts\engine\utility::istrue(var_2.scripted_mode)) {
        var_2.died_poorly = 1;
        var_2 suicide();
        continue;
      }

      if(scripts\engine\utility::istrue(var_2.ignoreme)) {
        var_2.died_poorly = 1;
        var_2 suicide();
        continue;
      }

      if(scripts\engine\utility::istrue(var_2.precacheleaderboards)) {
        var_2.died_poorly = 1;
        var_2 suicide();
        continue;
      }

      if(!scripts\engine\utility::istrue(var_2.entered_playspace)) {
        var_2.died_poorly = 1;
        var_2 suicide();
        continue;
      }
    }

    var_2.scripted_mode = 1;
    var_2 ghostskulls_complete_status(var_2.origin);
    var_2.ignoreme = 1;
    var_2.precacheleaderboards = 1;
  }
}

zombiehostmigrationend() {
  reenable_zombie_emmisive();
  thread resetplayerhud();
  var_0 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  foreach(var_2 in var_0) {
    var_2.scripted_mode = 0;
    var_2.ignoreme = 0;
    var_2.precacheleaderboards = 0;
  }

  if(isDefined(level.customhostmigrationend)) {
    level thread[[level.customhostmigrationend]]();
  }
}

resetplayerhud() {
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("zm_consumable_selection_ready", 20);
    var_1 setclientomnvar("zm_dpad_up_activated", 6);
    var_1 setclientomnvar("zombie_wave_number", 0);
    wait(0.1);
    var_1 setclientomnvar("zm_consumables_remaining", var_1.slot_array.size);
    var_1 setclientomnvar("zombie_wave_number", level.wave_num);
    wait(0.1);
    if(scripts\engine\utility::istrue(var_1.deck_select_ready)) {
      var_1 setclientomnvar("zm_consumable_selection_ready", 1);
    } else {
      var_1 setclientomnvar("zm_consumable_selection_ready", 0);
    }

    wait(0.1);
  }
}

validate_door_buy_setup() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("introscreen_over");
  var_0 = scripts\engine\utility::getstructarray("interaction", "targetname");
  foreach(var_2 in var_0) {
    if(issubstr(var_2.script_noteworthy, "debris")) {
      var_3 = getEntArray(var_2.target, "targetname");
      if(var_3.size < 2) {}
    }
  }
}

kick_for_inactivity(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 thread check_for_move_change();
  var_0 thread check_for_movement();
  var_0.input_has_happened = 0;
  var_1 = gettime();
  var_2 = level.onlinegame && !getdvarint("xblive_privatematch");
  if(var_2) {
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
    var_3 = 120;
    var_4 = 0.1;
    for(;;) {
      if(isDefined(level.wave_num) && level.wave_num > 5) {
        break;
      }

      var_5 = scripts\engine\utility::waittill_any_timeout_no_endon_death_2(var_4, "inputReceived", "currency_earned");
      if(gettime() - var_1 < 30000) {
        continue;
      }

      if(var_5 != "timeout") {
        var_3 = 120;
        var_0.input_has_happened = 1;
        continue;
      }

      if(!scripts\engine\utility::istrue(var_0.in_afterlife_arcade) && !scripts\engine\utility::istrue(var_0.inlaststand)) {
        var_3 = var_3 - var_4;
      }

      if(var_3 < 0) {
        if(level.players.size > 1) {
          if(var_0.input_has_happened) {
            var_0.input_has_happened = 0;
            continue;
          }

          add_to_kick_queue(var_0);
          break;
        }
      }
    }
  }
}

check_for_movement() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = level.onlinegame && !getdvarint("xblive_privatematch");
  if(var_0) {
    var_1 = self getnormalizedmovement();
    var_2 = gettime();
    for(;;) {
      wait(0.2);
      var_3 = self getnormalizedmovement();
      if(var_3[0] == var_1[0] && var_3[1] == var_1[1]) {
        if(gettime() - var_2 > 90000 && level.players.size > 1) {
          add_to_kick_queue(self);
        }

        continue;
      }

      return;
    }
  }
}

add_to_kick_queue(var_0) {
  if(!scripts\engine\utility::exist_in_array_MAYBE(level.kick_player_queue, var_0)) {
    level.kick_player_queue = scripts\engine\utility::array_add_safe(level.kick_player_queue, var_0);
  }
}

kick_player_queue_loop() {
  level.kick_player_queue = [];
  for(;;) {
    if(level.kick_player_queue.size > 0) {
      foreach(var_1 in level.kick_player_queue) {
        if(!isDefined(var_1)) {
          continue;
        }

        if(!var_1 ishost()) {
          kick(var_1 getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
        }
      }

      if(level.kick_player_queue.size > 0) {
        foreach(var_1 in level.kick_player_queue) {
          if(!isDefined(var_1)) {
            continue;
          }

          kick(var_1 getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
        }
      }

      level.kick_player_queue = [];
    }

    wait(0.1);
  }
}

check_for_move_change() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("done_inactivity_check");
  while(!isDefined(self.model)) {
    wait(0.1);
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

    wait(0.1);
  }
}

get_move_direction_from_vectors(var_0) {
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