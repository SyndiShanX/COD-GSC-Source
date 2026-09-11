/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\gametypes\cp_wave_sv.gsc
***********************************************/

function main() {
  scripts\cp\cp_globallogic::init();
  thread onplayerconnect();
  level.skip_playerhudphoto = 1;
  level.disable_nvg = 1;
  scripts\cp\cp_music_and_dialog::init();
  scripts\cp\survival\survival_loadout::init();
  scripts\cp\utility::coop_mode_enable(["loot_system"]);
  initdefaultsettings();
  scripts\cp\cp_weapon::weaponsinit();
  level.health_scalar = 1.5;
  scripts\cp\cp_outline::outline_init();
  level.playerent = &scripts\cp\cp_weapon::bomber_spawn_origin_array_init;
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  setomnvar("ui_hide_nameplates_for_zero_health", 0);
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
    return;
  }

  if(scripts\cp\pvpve\pvpve::pvpve_enabled()) {
    scripts\cp\pvpve\pvpve::init_pvpve();
    return;
  }
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
  level.default_weapon = "iw8_pi_golf21_mp";
  setdvarifuninitialized("enable_segmented_health_regen", 0);
  level.usehealthpacks = getdvarint("enable_segmented_health_regen", 0);
  level.pap_max = 2;
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
  level.enter_spectator_func = undefined;
  level.prespawnfromspectaorfunc = &prespawnfromspectatorfunc;
  level.laststand_exit_gamemodespecificaction = &exit_laststand_func;
  level.last_stand_hud_update = &last_stand_hud_update;
  level.getspawnpoint = &getspawnpoint;
  level.update_money_performance = &scripts\cp\cp_core_gamescore::update_money_earned_performance;
  level.active_volume_check = &scripts\cp\utility::is_in_active_volume;
  level.endgame_write_clientmatchdata_for_player_func = &endgame_clientmatchdata;
  level.hostmigrationend = &hostmigrationend;
  level.onhostmigration = &hostmigrationstart;
  setDvar("NKTQRKRMTS", 200);
  setDvar("LKMOLLSKKO", 375);
  setDvar("OMLLLQKQSR", 200);
  setDvar("LTMMLKRKTR", 375);
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
  setDvar("scr_wave_time_set", -1);
  thread init_enemy_spawner();
  thread scripts\cp\cp_traversalassist::traversal_assist_init();
  thread scripts\cp_mp\ent_manager::init();

  if(level.ref_12376) {
    scripts\cp\whizby::calloutmarkerping_init();
  }

  scripts\cp\cp_persistence::mortars_get_player_targeted();
  thread getclosestplayerforreward();
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
  thread ref_14524();
  thread smokinggunclassindex();
  thread scripts\cp\cp_outofbounds::initoob();
  scripts\cp\cp_modular_spawning::init_modular_spawning();
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  thread ref_137d5();
}

function ref_137d5() {
  thread clear_remaining_objective();
  begin_wave_spawning();

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    thread floor2lights();
  }

  scripts\cp\killstreaks\uav_cp::scriptable_adddamagedcallback();
}

function watch_for_super_ammo_depleted() {
  if(level.logfriendlyfire < 60) {
    return;
  }

  var0 = 20;

  switch (level.logfriendlyfire) {
    case 60:
    case 61:
    case 62:
    case 63:
    case 64:
      var0 = 18;
      break;
    case 65:
    case 66:
    case 67:
    case 68:
    case 69:
      var0 = 16;
      break;
    case 70:
    case 71:
    case 72:
    case 73:
    case 74:
      var0 = 14;
      break;
    case 79:
    case 78:
    case 77:
    case 76:
    case 75:
      var0 = 12;
      break;
    case 80:
    case 81:
    case 82:
    case 83:
    case 84:
      var0 = 11;
      break;
    case 85:
    case 86:
    case 87:
    case 88:
    case 89:
      var0 = 10;
      break;
    case 94:
    case 90:
    case 91:
    case 92:
    case 93:
      var0 = 9;
      break;
    case 98:
    case 97:
    case 96:
    case 95:
    case 99:
      var0 = 8;
      break;
  }

  if(level.logfriendlyfire >= 100 && level.logfriendlyfire < 125) {
    var0 = 7;
  } else if(level.logfriendlyfire >= 125 && level.logfriendlyfire < 150) {
    var0 = 6;
  } else if(level.logfriendlyfire >= 150) {
    var0 = 5;
  }

  level.ref_14529 = var0;
  setDvar("scr_wave_time_set", var0);

  if(level.logfriendlyfire == 100) {
    level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"COOP_GAME_PLAY/100_TEXT", "allies", 4);
    return;
  }
}

function floor2lights(var0) {
  level endon("game_ended");
  var1 = getEnt("weapon_crate", "targetname");
  var2 = getEnt("killstreak_crate", "targetname");
  var3 = getEnt("grenade_crate", "targetname");
  wait 10;

  if(isDefined(var1)) {
    flip_time(var1);
  }

  if(isDefined(var2)) {
    flip_time(var2);
  }

  if(isDefined(var3)) {
    flip_time(var3);
  }

  thread floor_gas();
}

function floor_gas() {
  level endon("game_ended");

  for(;;) {
    level waittill("timeout_wave");

    if(isDefined(level.ref_14531) && level.ref_14531 <= level.logfriendlyfire) {
      return;
    }

    thread init_client();
  }
}

function flip_time() {
  if(self.targetname == "weapon_crate") {
    self setHintString(&"COOP_GAME_PLAY/BUY_WEAPONS");
    level.infilvideocompletecallback = self;
  } else if(self.targetname == "grenade_crate") {
    self setHintString(&"COOP_GAME_PLAY/BUY_EQUIPMENT");
    level.infil_driver = self;
  } else if(self.targetname == "killstreak_crate") {
    self setHintString(&"COOP_GAME_PLAY/BUY_KILLSTREAKS");
    level.infil_plane_vo = self;
  }

  self setCursorHint("HINT_BUTTON");
  self sethintdisplayrange(256);
  self sethintdisplayfov(90);
  self setuserange(128);
  self setusefov(90);
  self sethinttag("antenna_rot_base_joint");
  self sethintonobstruction("hide");
  self setuseholdduration("duration_short");
  thread floor1lights();
}

function floor1lights() {
  level endon("game_ended");
  thread flood_spawn_till_flag();
  watch_for_super_ammo_depleted(level);
  level waittill("wave_starting");
  level.ref_14522 = 0;

  for(var0 = 0; var0 < level.players.size; var0++) {
    level.players[var0] setclientomnvar("cp_open_cac", -2);
    level.players[var0] clearsoundsubmix("cp_store_duck", 1);
  }

  if(self.targetname != "weapon_crate") {
    self makeunusable();
    self setscriptablepartstate("main", "off");

    if(isDefined(self.headicon)) {
      setheadiconteam(self.headicon);
    }
  }

  landing_damage_watcher();

  if(self.targetname == "weapon_crate") {
    thread init_and_start_whack_a_mole_sequence_data();
    thread bronloadoutcratedestroyed();
  }

  thread floor1lights();
}

function flood_spawn_till_flag() {
  level endon("game_ended");
  level waittill("timeout_wave");
  level endon("wave_starting");
  level notify("weapon_buy_starting");

  for(;;) {
    level.ref_14522 = 1;

    if(self.targetname == "weapon_crate") {
      self setHintString(&"COOP_GAME_PLAY/BUY_WEAPONS");
    }

    self makeusable();
    self setscriptablepartstate("main", "on");

    if(isDefined(self.headicon)) {
      hideheadiconfromplayersinmask(self.headicon);
    }

    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!istrue(var0.ref_12c68)) {
      var0 setclientomnvar("reset_wave_loadout", 2);
      var0.ref_12c68 = 1;
    }

    if(self.targetname == "weapon_crate") {
      var1 = -1;
      var2 = var0.currentprimaryweapon.basename;

      for(var3 = 0; var3 < var0.primaryweapons.size; var3++) {
        var4 = var0.primaryweapons[var3].basename;
        var5 = scripts\cp\utility::strip_suffix(var4, "_mp");

        if(var3 < 2) {
          var0 setplayerdata("cp", "waveSurvivalWeapon", var3, var5);
        }

        if(var2 == var4) {
          var1 = var3;
        }
      }

      wait 0.1;

      if(var1 == 0 || var1 == 1) {
        var0.ref_120b7 = var1;

        if(istrue(level.ref_14522)) {
          var0 setclientomnvar("cp_open_cac", var1);
        } else {
          var0 setclientomnvar("cp_open_cac", 4);
        }

        var0 setsoundsubmix("cp_store_duck", 1);
        thread ref_14542(level);
      } else {
        var0 thread scripts\cp\utility::hint_prompt("cant_use_with_weapon", 1, 2);
      }

      continue;
    }

    if(self.targetname == "grenade_crate") {
      var0 setclientomnvar("cp_open_cac", 2);
      var0 setsoundsubmix("cp_store_duck", 1);
      thread ref_14542(level);
      continue;
    }

    if(self.targetname == "killstreak_crate") {
      var0 setclientomnvar("cp_open_cac", 3);
      var0 setsoundsubmix("cp_store_duck", 1);
      continue;
    }
  }
}

function ref_14542(var0) {
  level endon("game_ended");
  level endon("timeout_wave");
  level endon("weapon_buy_starting");
  var0 endon("death_or_disconnect");
  var0 waittill("last_stand_start");
  var0 setclientomnvar("cp_open_cac", -2);
  var0 clearsoundsubmix("cp_store_duck", 1);
}

function bronloadoutcratedestroyed() {
  level endon("game_ended");
  level endon("timeout_wave");
  level endon("weapon_buy_starting");
  self setHintString(&"COOP_GAME_PLAY/CACHE_USE_HINT");

  for(;;) {
    self makeusable();
    self setscriptablepartstate("main", "on");

    if(isDefined(self.headicon)) {
      hideheadiconfromplayersinmask(self.headicon);
    }

    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!istrue(var0.ref_12c68)) {
      var0 setclientomnvar("reset_wave_loadout", 2);
      var0.ref_12c68 = 1;
    }

    if(self.targetname == "weapon_crate") {
      var1 = -1;
      var2 = var0.currentprimaryweapon.basename;

      for(var3 = 0; var3 < var0.primaryweapons.size; var3++) {
        var4 = var0.primaryweapons[var3].basename;
        var5 = scripts\cp\utility::strip_suffix(var4, "_mp");

        if(var3 < 2) {
          var0 setplayerdata("cp", "waveSurvivalWeapon", var3, var5);
        }

        if(var2 == var4) {
          var1 = var3;
        }
      }

      var6 = 1;
      var7 = tablelookup("mp/statstable.csv", 5, var2, 1);

      if(var7 == "weapon_melee" || var7 == "weapon_melee2") {
        var6 = 0;
      }

      if(var6 && (var1 == 0 || var1 == 1)) {
        var0.ref_120b7 = var1;

        if(istrue(level.ref_14522)) {
          var0 setclientomnvar("cp_open_cac", var1);
        } else {
          var0 setclientomnvar("cp_open_cac", 4);
        }

        var0 setsoundsubmix("cp_store_duck", 1);
      } else {
        var0 thread scripts\cp\utility::hint_prompt("cant_use_with_weapon", 1, 2);
      }

      continue;
    }
  }
}

function init_and_start_whack_a_mole_sequence_data() {
  level endon("game_ended");
  var0 = scripts\cp\cp_objectives::requestworldid("ammopurchase", 20);
  objective_state(var0, "current");
  objective_setshowoncompass(var0, 1);
  objective_setplayintro(var0, 1);
  objective_setlabel(var0, "");
  objective_icon(var0, "hud_icon_survival_ammo");
  objective_position(var0, level.infilvideocompletecallback.origin + infilcinematicactive(level.infilvideocompletecallback));
  objective_setshowdistance(var0, 1);
  objective_setshowprogress(var0, 0);
  objective_setbackground(var0, 1);
  level waittill("close_ammo_shop");
  objective_state(var0, "done");
  objective_delete(var0);
  scripts\cp\cp_objectives::freeworldidbyobjid(var0);
}

function init_client() {
  level endon("game_ended");
  level notify("close_ammo_shop");
  var0 = scripts\cp\cp_objectives::requestworldid("store_weapons", 20);
  var1 = scripts\cp\cp_objectives::requestworldid("store_equipment", 20);
  var2 = scripts\cp\cp_objectives::requestworldid("store_munitions", 20);
  level.infilcoveroverlay = 1;
  objective_state(var0, "current");
  objective_setshowoncompass(var0, 1);
  objective_setlabel(var0, "");
  objective_icon(var0, "hud_icon_survival_weapon");
  objective_position(var0, level.infilvideocompletecallback.origin + infilcinematicactive(level.infilvideocompletecallback));
  objective_setshowdistance(var0, 1);
  objective_setshowprogress(var0, 0);
  objective_setbackground(var0, 1);
  objective_state(var1, "current");
  objective_setshowoncompass(var1, 1);
  objective_setlabel(var1, "");
  objective_icon(var1, "hud_icon_survival_equipment");
  objective_position(var1, level.infil_driver.origin + infilcinematicactive(level.infil_driver));
  objective_setshowdistance(var1, 1);
  objective_setshowprogress(var1, 0);
  objective_setbackground(var1, 1);
  objective_state(var2, "current");
  objective_setshowoncompass(var2, 1);
  objective_setlabel(var2, "");
  objective_icon(var2, "hud_icon_survival_killstreak");
  objective_position(var2, level.infil_plane_vo.origin + infilcinematicactive(level.infil_plane_vo));
  objective_setshowdistance(var2, 1);
  objective_setshowprogress(var2, 0);
  objective_setbackground(var2, 1);

  if(level.logfriendlyfire <= 2) {
    objective_setplayintro(var0, 1);
    objective_setplayintro(var1, 1);
    objective_setplayintro(var2, 1);
  } else {
    objective_setplayintro(var0, 0);
    objective_setplayintro(var1, 0);
    objective_setplayintro(var2, 0);
  }

  level waittill("close_shops");
  objective_state(var0, "done");
  objective_delete(var0);
  scripts\cp\cp_objectives::freeworldidbyobjid(var0);
  objective_state(var1, "done");
  objective_delete(var1);
  scripts\cp\cp_objectives::freeworldidbyobjid(var1);
  objective_state(var2, "done");
  objective_delete(var2);
  scripts\cp\cp_objectives::freeworldidbyobjid(var2);
  thread init_and_start_whack_a_mole_sequence_data();
}

function infilcinematicactive(var0) {
  return rotatevector((17.5, 0, 0), var0.angles);
}

function landing_damage_watcher() {
  level notify("close_shops");
  level.infilcoveroverlay = 0;
}

function init_exfil() {
  self.headicon = deleteheadicon(self);

  if(self.targetname == "weapon_crate") {
    setheadiconfriendlyimage(self.headicon, "hud_icon_survival_weapon");
  } else if(self.targetname == "grenade_crate") {
    setheadiconfriendlyimage(self.headicon, "hud_icon_survival_equipment");
  } else if(self.targetname == "killstreak_crate") {
    setheadiconfriendlyimage(self.headicon, "hud_icon_survival_killstreak");
  }

  setheadicondrawthroughgeo(self.headicon, 1);
  setheadiconsnaptoedges(self.headicon, 29000);
  setheadiconmaxdistance(self.headicon, 30);
  addclienttoheadiconmask(self.headicon, 20);
  setheadiconteam(self.headicon);

  for(var0 = 0; var0 < level.players.size; var0++) {
    addteamtoheadiconmask(self.headicon, level.players[var0]);
  }
}

function begin_wave_spawning() {
  wait 10;

  foreach(var1 in level.players) {
    scripts\cp\cp_persistence::update_player_career_highest_wave(var1, 1, level.players.size);
  }

  if(true) {
    thread ref_139ba();
  }

  level.ref_139bb = scripts\cp\cp_modular_spawning::run_spawn_module("wave_spawning");
}

function getclosestplayerforreward() {
  level endon("game_ended");
  var0 = getdvarint("scr_wavesv_finitewaves", 0);

  if(var0 == 0) {
    return;
  }

  waitframe();
  level.ref_14532 = 1;
  level.ref_14531 = var0;
  setomnvar("cp_objective_event_count", level.ref_14531);
  setDvar("scr_wave_time_set", 25);

  for(;;) {
    level waittill("wave_ending");
    waitframe();
    var1 = level.logfriendlyfire;

    if(var1 >= var0) {
      setomnvar("cp_wave_timer", 0);
      setomnvar("cp_enemies_remaining", 0);
      level notify("stop_wave_sounds");
      level.ref_14530 = 1;
      thread mp_t_reflex_patch();
      thread mp_vacant_patch();
      thread mp_t_reflex_containers_collisions();
      wait 6;
      scripts\cp\cp_objectives::screenent_c("major_objective");
      level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
    }
  }
}

function ref_139ba() {
  foreach(var1 in level.players) {
    var2 = max(0.05, var3 * 0.25);
    thread ref_14516(var1);
  }

  for(;;) {
    level waittill("wave_starting");
    level.inithelipropanims = gettime();
    level waittill("wave_ending");
    level.inithelipropanims = undefined;
  }
}

function ref_14516(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(self.ref_14516)) {
    return;
  }

  self.ref_14516 = 1;
  self.ref_14515 = [];

  for(;;) {
    if(istrue(level.wave_cooldown_active) || !isDefined(level.logfriendlyfire) || level.logfriendlyfire == 0) {
      self.ref_14515 = [];
      level waittill("wave_starting");
    }

    self.ref_14515 = scripts\engine\utility::array_removedead_or_dying(self.ref_14515);

    if(self.ref_14515.size >= 3) {
      wait 0.05;
      continue;
    }

    var1 = ref_143d8();

    if(!istrue(var1)) {
      wait 0.05;
      continue;
    }

    wait var0;
    var2 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

    if(isDefined(var2) && var2.size > 0) {
      var2 = sortbydistance(var2, self.origin);
    } else {
      continue;
    }

    var3 = randomintrange(1, 2);

    if(isDefined(level.inithelipropanims)) {
      if(gettime() - level.inithelipropanims > 90000) {
        var3 = 2;
      } else if(gettime() - level.inithelipropanims > 135000) {
        var3 = 3;
      }
    }

    var3 = int(min(var3, var2.size));

    for(var4 = 0; var4 < var3; var4++) {
      self.ref_14515 = scripts\engine\utility::array_removedead_or_dying(self.ref_14515);
      var5 = var2[var4];

      if(istrue(var5.module_vehicles_count) || isDefined(var5.unittype) && (var5.unittype == "suicidebomber" || var5.unittype == "juggernaut")) {
        if(var3 < var2.size && self.ref_14515.size < 3) {
          var3++;
        }

        continue;
      }

      self.ref_14515[self.ref_14515.size] = var5;
      thread bleedout_heartbeat_sfx_logic(var5);
    }
  }
}

function ref_143d8(var0, var1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  level endon("wave_ending");

  if(!isDefined(var0)) {
    var0 = 12;
  }

  jumpiftrue(isDefined(var1)) LOC_00000032;
  var1 = 300;

  while(isalive(self)) {
    var2 = self.origin;

    if(isDefined(level.inithelipropanims)) {
      while(gettime() - level.inithelipropanims < 30000) {
        var2 = self.origin;
        wait 1;
      }
    }

    var5 = gettime();
    var6 = 1;

    while(gettime() - var5 < var0 * 1000) {
      var7 = distance(self.origin, var2);

      if(var7 > var1) {
        var6 = 0;
        break;
      }

      wait 0.2;
    }

    if(gettime() - var5 < var0 * 1000) {
      var6 = 0;
    }

    if(var6) {
      return 1;
    }

    if(isDefined(level.ref_1451e) && isDefined(level.ref_1451e) > 0 && level.ref_1451e <= 3) {
      return 1;
    }
  }
}

function bleedout_heartbeat_sfx_logic(var0) {
  self endon("death");
  self notify("aggro_goal_shrink");
  self endon("aggro_goal_shrink");

  if(!isDefined(var0)) {
    return;
  }

  var1 = 6;
  var2 = 5;
  var3 = 0.5;
  var4 = self.goalradius;
  self.module_vehicles_count = 1;

  for(;;) {
    if(!isDefined(var0) || !isalive(var0) || scripts\cp\cp_laststand::player_in_laststand(var0)) {
      break;
    }

    self getenemyinfo(var0);
    var5 = var0.origin;
    scripts\cp\cp_modular_spawning::set_goal_pos(var5);
    var6 = max(64, self.goalradius * var3);
    scripts\cp\cp_modular_spawning::set_goal_radius(var6);
    var7 = scripts\engine\utility::ref_143b9(var1, "goal");

    if(isDefined(var7) && var7 == "goal") {
      wait var2;
    }
  }

  if(isDefined(var0) && isDefined(var0.ref_14515)) {
    var0.ref_14515 = scripts\engine\utility::array_remove(var0.ref_14515, self);
  }

  var8 = [];

  foreach(var10 in level.players) {
    if(!isDefined(var0) || !isalive(var0) || scripts\cp\cp_laststand::player_in_laststand(var0)) {
      continue;
    }

    var8 = var10;
  }

  if(var8.size > 0) {
    var8 = sortbydistance(var8, self.origin);
    self getenemyinfo(var8[0]);
    scripts\cp\cp_modular_spawning::set_goal_pos(var8[0].origin);
  }

  scripts\cp\cp_modular_spawning::set_goal_radius(var4);
  self.module_vehicles_count = undefined;
}

function isloadoutindexdefault(var0, var1) {
  self notify("debug_ai_aggro");
  self endon("debug_ai_aggro");
  self endon("death");
  var0 endon("death");

  while(istrue(self.module_vehicles_count)) {
    thread scripts\engine\utility::draw_circle(var1, self.goalradius, (1, 0, 0), 1, 0, 2);
    wait 0.1;
  }
}

function clear_remaining_objective() {
  level endon("game_ended");
  wait 3;
  var0 = ["dx_cps_lass_cache_collection_enemy_incoming_10", "dx_cps_lass_cache_collection_enemy_incoming_20", "dx_cps_kama_cache_collection_enemy_incoming_40"];
  var1 = scripts\engine\utility::random(var0);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var1, "allies");
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
      var0 scripts\cp\cp_mapselect::set_uav_radarstrength(var0);
      var0 scripts\cp\cp_persistence::lb_player_update_stat("waveNum", level.wave_num, 1);
      var0 scripts\cp\cp_wall_buys::setup_player_weapon_models(var0);
      var0 scripts\cp\cp_persistence::player_persistence_init();
      var0 thread scripts\cp\cp_analytics::init_weapon_and_player_analytics(var0);

      if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
        var0 scripts\cp\pvpe\pvpe::assign_pvpe_team_and_slot_number(var0);
        var0 scripts\cp\pvpe\pvpe::terrorist_self_revive_time_override(var0);
      }

      var0.gameskill = scripts\cp\cp_gameskill::get_gameskill();
      var0 scripts\cp\cp_gameskill::set_difficulty_from_locked_settings();
      thread strike_player_connect_black_screen();
      var0 thread scripts\cp\utility::ref_13c3e(1);
      var0.timeplayed = [];

      foreach(var5 in level.teamnamelist) {
        var0.timeplayed[var5] = 0;
      }

      var0.timeplayed["total"] = 0;
      var0.timeplayed["missionTeam"] = 0;
      var0.timeplayed["other"] = 0;
      var0.timeplayed["timeDead"] = 0;

      if(level.ref_12376) {
        var0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();
      }

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

      thread kick_for_inactivity(var0);
      thread mission_jumpto_debug();

      if(true) {
        var7 = max(0.05, int(var0 getentitynumber()) * 0.25);
        thread ref_14516(var0);
      }
    }
  }
}

function mission_jumpto_debug() {
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    if(var0 == "mission_jump") {
      var2 = getDvar("NSQLTTMRMP");
      var3 = "cp/" + var2 + "_objectives.csv";
      var4 = tablelookup(var3, 0, var1, 1);
      var5 = var2 + "_start_obj";
      setdvarifuninitialized(var5, var4);
      setDvar(var5, var4);
      scripts\cp\cp_endgame::restart_map();
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
  scripts\cp\utility::freezecontrolswrapper(1);
  thread scripts\cp\perks\cp_perks::watchcombatspeedscaler();

  if(isDefined(level.custom_onspawnplayer_func)) {
    self[[level.custom_onspawnplayer_func]]();
  }

  scripts\cp\cp_globallogic::player_init_invulnerability();
  scripts\cp\cp_globallogic::player_init_damageshield();
  var1 = get_starting_currency(self);
  thread scripts\cp\cp_persistence::wait_to_set_player_currency(var1);
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

  if(!istrue(level.disable_nvg)) {
    thread scripts\cp\equipment\nvg::runnvg();
  }

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  scripts\cp\utility::force_usability_enabled();

  if(scripts\cp\pvpe\pvpe::pvpe_enabled() && scripts\cp\pvpe\pvpe::player_is_terrorist(self)) {
    scripts\cp\pvpe\pvpe::on_spawn_terrorist_player(self);
  }

  self setplayerdata("cp", "waveSurvivalWeapon", 0, "iw8_pi_golf21");
  self setplayerdata("cp", "waveSurvivalWeapon", 1, "iw8_pi_golf21");
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
    self setclientomnvar("ui_hide_hud", 0);
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
  show_introscreen_text(var0);
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
  var0 waittill("spawned_player");
  var0 playerhide();
  var0 disableweapons();
  var0 scripts\cp\utility::freezecontrolswrapper(1);

  while(!istrue(var0.zombiespawnabovedeath)) {
    wait 1;
  }

  var0 playershow();
  var0 scripts\cp\utility::freezecontrolswrapper(0);
  var0 enableweapons();
  var0 notify("open_loadout_menu");
  var0.introscreen_overlay fadeovertime(2);
  var0.introscreen_overlay.alpha = 0.5;
  wait 2;
  var0.introscreen_overlay destroy();
  var0 setclientomnvar("ui_hide_hud", 0);

  if(level.players.size > 1) {
    var1 = 0;

    foreach(var3 in level.players) {
      if(isDefined(var3.introscreen_overlay)) {
        var1 = 1;
        break;
      }
    }

    if(var1 == 0) {
      var5 = getdvarint("LKKRLSMRQP", 0);
      wait var5;
      scripts\cp\cp_globallogic::refreshuimatchinprogressomnvarvalue();
      return;
    }

    return;
  }

  scripts\cp\cp_globallogic::refreshuimatchinprogressomnvarvalue();
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
  }

  if(istrue(level.infilcoveroverlay)) {
    landing_damage_watcher();
    thread init_client();
  } else {
    landing_damage_watcher();
  }

  if(isDefined(level.ref_1451e)) {
    setomnvar("cp_enemies_remaining", level.ref_1451e);
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
  var1 = 0;
  var2 = gettime();
  var3 = level.onlinegame;

  if(!var3) {
    return;
  }

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
  var4 = 120;
  var5 = 0.1;

  for(;;) {
    var6 = scripts\engine\utility::ref_143c0(var5, "inputReceived", "currency_earned");

    if(var6 != "timeout") {
      var4 = 120;
      var1 = 1;
      continue;
    }

    if(!istrue(var0.in_afterlife_arcade) && !istrue(var0.inlaststand)) {
      var4 -= var5;
    }

    if(var4 < 0) {
      if(var1) {
        var1 = 0;
        continue;
      }

      add_to_kick_queue(var0);
      LOC_00000146:
    }
    LOC_00000146:
  }
}

function check_for_movement() {
  level endon("game_ended");
  self endon("disconnect");
  var0 = self getnormalizedmovement();
  var1 = gettime();

  for(;;) {
    wait 0.2;
    var2 = self getnormalizedmovement();

    if(var2[0] == var0[0] && var2[1] == var0[1]) {
      if(gettime() - var1 > 90000) {
        add_to_kick_queue(self);
      }

      continue;
    }

    self notify("inputReceived");
    return;
  }
}

function add_to_kick_queue(var0) {
  if(scripts\cp\cp_laststand::player_in_laststand(var0)) {
    return;
  }

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

        thread kill_off_non_essential_ai(var1);
      }

      level.kick_player_queue = [];
    }

    wait 0.1;
  }
}

function kill_off_non_essential_ai(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var1 = 10;

  if(istrue(var0.clear_up_objective_after_delay)) {
    return;
  }

  var0.clear_up_objective_after_delay = 1;
  var0 sethudtutorialmessage(&"COOP_GAME_PLAY/KICK_FOR_INACTIVITY");
  var0 setclientomnvar("ui_kick_warning", 1);
  var2 = var0 scripts\engine\utility::waittill_any_in_array_or_timeout(["inputReceived"], var1);
  var0 clearhudtutorialmessage();
  var0 setclientomnvar("ui_kick_warning", 0);
  var0.clear_up_objective_after_delay = undefined;

  if(var2 == "timeout") {
    if(scripts\cp\utility::questtimeradd() == 1) {
      level thread[[level.endgame]]("axis", level.end_game_string_index["fail"]);
      return;
    }

    kick(var0 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE");
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

function enable_dogtag_revive(var0) {
  var1 = spawn("script_model", var0.origin + (0, 0, 40));
  var1 setModel("military_dogtags_iw8_blue");
  var1 makeusable();
  var1 scriptmodelplayanim("mp_dogtag_spin");
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
  self endon("instant_revive");

  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self.bplayerrevivingteammate = 1;
    var2 = scripts\cp\utility::player_lua_progressbar(var1, 8000, 9216, 5);
    self.bplayerrevivingteammate = undefined;

    if(!var2) {
      continue;
    }

    break;
  }

  playFX(level._effect["dogtag_pickup"], self.origin);
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

function ref_14524() {
  level endon("game_ended");

  for(;;) {
    level waittill("timeout_wave_complete");
    var0 = [];

    foreach(var2 in level.players) {
      if(istrue(var2.isreviving)) {
        var0 = var2;
      }

      if(scripts\cp\cp_laststand::player_in_laststand(var2) && !istrue(var2.clear_prev_goal) && !istrue(scripts\cp\cp_laststand::is_being_revived(var2))) {
        var2 scripts\cp\cp_laststand::instant_revive(var2);
      }
    }

    wait 2;

    foreach(var2 in var0) {
      if(!scripts\cp\cp_laststand::player_in_laststand(var2) && !istrue(var2.clear_prev_goal)) {
        var2 thread scripts\cp\cp_laststand::set_cam();
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

function givedefaultloadout(var0, var1, var2) {
  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  var3 = self;

  if(!istrue(var3.ref_12c69)) {
    var3 setclientomnvar("reset_wave_loadout", 1);
    thread ref_1434c();
    var3.ref_12c69 = 1;
  }

  var3.changingweapon = undefined;
  var3 scripts\cp\cp_accessories::clearplayeraccessory();
  var3 takeallweapons();

  if(!istrue(var3.keep_perks)) {
    var3 scripts\cp\utility::_clearperks();
  }

  var3 scripts\cp\utility::_detachall();
  var3.spawnperk = 0;

  if(initmaxspeedforpathlengthtable(var3)) {
    thread ref_13b0e();
  }

  if(isDefined(var3.headmodel)) {
    var3.headmodel = undefined;
  }

  var3 thread scripts\cp\survival\survival_loadout::setmodelfromcustomization();
  var4 = var3 scripts\cp\survival\survival_loadout::lookupcurrentoperatorskin(var3.team);
  var5 = var3 scripts\cp\survival\survival_loadout::getplayerfoleytype(var4);

  if(var5 == "") {
    var5 = "vestlight";
  }

  var3 setclothtype(var5);
  scripts\engine\utility::flag_wait("introscreen_over");

  if(isDefined(level.move_speed_scale)) {
    var3[[level.move_speed_scale]]();
  } else {
    var3 scripts\cp\survival\survival_loadout::updatemovespeedscale();
  }

  var3.primaryweapon = isundefinedweapon();
  var3.starting_weapon = isundefinedweapon();
  var3 thread scripts\cp\cp_weapon::setweaponlaser_internal();
  var3 notify("giveLoadout");
  var3 scripts\cp\utility::giveperk("specialty_pistoldeath");
  var3 scripts\cp\utility::giveperk("specialty_expanded_minimap");

  if(isDefined(var0) && var0) {
    return;
  }

  var6 = var3.melee_weapon;
  var3.default_starting_melee_weapon = var6;
  var3.currentmeleeweapon = var6;
  var3.class = "none";
  var3.class_num = 666;

  if(getqueuedspleveltransients(var3.default_starting_pistol)) {
    if(!getqueuedspleveltransients(var3.starting_weapon)) {
      var3.default_starting_pistol = var3.starting_weapon;
    } else if(isDefined(level.default_weapon)) {
      var3.default_starting_pistol = scripts\cp\cp_weapon::buildweapon(level.default_weapon, [], "none", "none", -1);
    } else {
      var3.default_starting_pistol = scripts\cp\cp_weapon::buildweapon("iw8_pi_golf21_mp", [], "none", "none", -1);
    }
  }

  var3.last_stand_pistol = var3.default_starting_pistol;
  var7 = spawnStruct();
  var8 = var3 scripts\cp\cp_loadout::cac_getloadoutselectedidx();
  var9 = var3 scripts\cp\cp_loadout::loadout_updateclasscustom(var7, var8);
  var3.classstruct = var9;
  var10 = scripts\cp\utility::getrawbaseweaponname(var3.default_starting_pistol);
  var3.default_starting_pistol = scripts\cp\survival\survival_loadout::return_wbk_version_of_weapon(var3, var10, var3.default_starting_pistol);
  var3 scripts\cp\utility::_giveweapon(var3.default_starting_pistol, undefined, undefined, 1);

  LOC_0000027e:
    if(!getqueuedspleveltransients(var3.starting_weapon)) {
      var10 = scripts\cp\utility::getrawbaseweaponname(var3.starting_weapon);
      var3.starting_weapon = scripts\cp\survival\survival_loadout::return_wbk_version_of_weapon(var3, var10, var3.starting_weapon);
      var3 scripts\cp\utility::_giveweapon(var3.starting_weapon, undefined, undefined, 0);
    }

  if(isDefined(var3.operatorcustomization) && isDefined(var3.operatorcustomization.execution)) {
    var3 scripts\cp_mp\execution::_giveexecution(var3.operatorcustomization.execution);
  }

  var11 = scripts\cp\utility::getrawbaseweaponname(var3.default_starting_pistol);
  var3[[level.move_speed_scale]]();
  var7 = spawnStruct();
  var7.lvl = scripts\cp\survival\survival_loadout::get_baseweapon_pap_level(var3, var11);
  var3.pap[var11] = var7;
  var3 notify("weapon_level_changed");
  var3 giveweapon("super_default_zm");
  var3 assignweaponoffhandspecial("super_default_zm");
  var3.specialoffhandgrenade = "super_default_zm";
  var3 scripts\cp\survival\survival_loadout::set_player_perks();
  var12 = var3.default_starting_pistol;

  if(!getqueuedspleveltransients(var3.starting_weapon)) {
    var12 = var3.starting_weapon;
  }

  if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "none") {
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);
  }

  var13 = self getplayerdata("cp", "inventorySlots", "totalSlots");
  var3 scripts\cp\cp_munitions::reset_munitions(self, var13);
  var14 = 1;
  var15 = 1;
  var16 = "power_frag";
  var17 = "power_flash";
  var3 thread scripts\cp\cp_powers::givepower(var16, "primary", undefined, undefined, undefined, undefined, 1, var14);
  var3 thread scripts\cp\cp_powers::givepower(var17, "secondary", undefined, undefined, undefined, undefined, 1, var15);
  var3 thread scripts\cp\survival\survival_loadout::wait_and_force_weapon_switch(var12);

  if(istrue(level.disable_nvg)) {
    var3 setactionslot(2, "");
  }

  var3 setactionslot(3, "altmode");

  if(isDefined(var3.operatorcustomization) && isDefined(var3.operatorcustomization.execution)) {
    var3 scripts\cp_mp\execution::_giveexecution(var3.operatorcustomization.execution);
  }

  var3 notify("loadout_given");
  var3.zombiespawnabovedeath = 1;

  if(!scripts\engine\utility::flag_exist("player_spawned_with_loadout")) {
    scripts\engine\utility::flag_init("player_spawned_with_loadout");
  }

  scripts\engine\utility::flag_set("player_spawned_with_loadout");
}

function ref_1434c() {
  wait 15;
  self setclientomnvar("reset_wave_loadout", 1);
}

function ref_13b0e() {
  if(getdvarint("scr_testclient_ignorespawn", 0) == 0) {
    return;
  }

  wait 3;
  self.ignoreme = 1;
}

function getspawnpoint() {
  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    return scripts\cp\pvpe\pvpe::getassignedspawnpointbasedonteam(self);
  }

  if(scripts\cp\pvpve\pvpve::pvpve_enabled()) {
    return scripts\cp\pvpve\pvpve::getassignedspawnpointbasedonteam(self);
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

function mp_t_reflex_patch() {
  foreach(var1 in level.players) {
    var1.ability_invulnerable = 1;
  }

  wait 6.6;

  foreach(var1 in level.players) {
    var1 clearclienttriggeraudiozone(1);

    if(istrue(var1.musicplaying)) {
      var1 playlocalsound("mp_jugg_mus_toggle_button");
      var1 setscriptablepartstate("juggernaut", "neutral", 0);
    }

    var1 setplayermusicstate("mus_west_victory");
    var1 setsoundsubmix("cp_matchend", 1);
  }

  wait 2.2;

  foreach(var1 in level.players) {
    var1 clearsoundsubmix("cp_matchend", 1);
    var1 clearsoundsubmix("mp_matchend_music", 1);
  }
}

function mp_vacant_patch() {
  var0 = "dx_cps_kama_quarry2_extraction_50";
  level scripts\cp\cp_vo::try_to_play_vo_on_team(var0, "allies");
  wait 0.2;
  var0 = "dx_cps_kama_safehouse_return_safehouse_20";
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var0, "allies");
}

function mp_t_reflex_containers_collisions() {
  wait 1;

  foreach(var1 in level.players) {
    var1 allowmovement(0);
    var1 allowfire(0);
    var1 disableoffhandweapons();
    var1 disableusability();
    var1 allowmovement(0);
  }

  wait 3;

  foreach(var1 in level.players) {
    var1 thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340d(1.5, 1, 1);
  }

  wait 2;
  var5 = scripts\engine\utility::getStructArray("heli_search", "script_noteworthy");

  if(!isDefined(var5) || var5.size == 0) {
    return;
  }

  foreach(var1 in level.players) {
    var7 = var5[0];
    var8 = var7.origin;
    var9 = scripts\engine\utility::getStruct(var7.target, "targetname");
    var10 = spawn("script_model", var8);
    var10 setModel("tag_origin");
    var10.angles = var7.angles;
    var10 moveTo(var9.origin, 20, 1, 1);
    var1 playerhide();
    var1 setclientomnvar("ui_hide_hud", 1);
    spawn_endgame_camera(var1, var10);
    var1 lerpfovscalefactor(0, 0);
  }
}

function spawn_endgame_camera(var0) {
  self.ignoreme = 1;
  self cameralinkTo(var0, "tag_origin", 1);
  self setclientdvar("LQKPQMPRQN", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer()) {
    self setclientdvar("QTSPTNLOL", "50");
    return;
  }
}

function smokinggunclassindex() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  wait 10;
  var0 = 60000;
  var1 = [];

  for(;;) {
    if(isDefined(level.vehicle) && isDefined(level.vehicle.helicopter_crash_locations)) {
      for(var2 = 0; var2 < level.vehicle.helicopter_crash_locations.size; var2++) {
        var3 = level.vehicle.helicopter_crash_locations[var2];

        if(!isDefined(var3) || !isstruct(var3)) {
          continue;
        }

        if(istrue(var3.claimed)) {
          if(!isDefined(var3.hacks_needed)) {
            var3.hacks_needed = gettime();
            var1 = var3;
          } else if(isDefined(var3.hacks_needed)) {
            if(gettime() > var3.hacks_needed + var0) {
              var3.hacks_needed = undefined;
              var3.claimed = undefined;

              if(scripts\engine\utility::array_contains(var1, var3)) {
                var1 = scripts\engine\utility::array_remove(var1, var3);
              }
            }
          }

          continue;
        }

        if(scripts\engine\utility::array_contains(var1, var3)) {
          var3.hacks_needed = undefined;
          var1 = scripts\engine\utility::array_remove(var1, var3);
        }
      }
    }

    wait 1;
  }
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