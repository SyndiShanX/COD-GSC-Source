/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\cp_disco.gsc
*************************************************/

main() {
  setdvar("sm_sunSampleSizeNear", 0.85);
  setdvar("r_mbVelocityScaleViewModel", 0.5);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("r_umbraAccurateOcclusionThreshold", 4000);
  setdvar("sm_roundRobinPrioritySpotShadows", 8);
  setdvar("sm_spotUpdateLimit", 8);
  setdvar("r_tessellationFactor", 40);
  setdvar("r_tessellationCutoffFalloff", 256);
  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  level.bskaterdebugger = getdvarint("debug_skater", 0);
  level.bcopdlc2debugger = getdvarint("debug_cop", 0);
  level.bratkingdebugger = getdvarint("debug_ratking", 0);
  level.bpamgrierdebugger = getdvarint("debug_pamgrier", 0);
  level.bkaratemasterdebugger = getdvarint("debug_karatemaster", 0);
  level.bratkingbattledebugger = getdvarint("debug_ratkingbattle", 0);
  movedefaultspawners();
  level.no_zapper_fx = 1;
  level.pam_radio_counter = 0;
  level.on_zombie_damaged_func = ::scripts\cp\maps\cp_disco\cp_disco_damage::cp_disco_onzombiedamaged;
  level.var_C4BE = ::scripts\mp\agents\zombie_dlc2\zombie_dlc2_agent::onzombiekilled;
  registerscriptedagents();
  registerlevelenemyarrays();
  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  level.power_table = "cp\zombies\disco_powertable.csv";
  scripts\cp\maps\cp_disco\cp_disco_precache::main();
  scripts\cp\maps\cp_disco\gen\cp_disco_art::main();
  scripts\cp\maps\cp_disco\cp_disco_fx::main();
  if(level.createfx_enabled) {
    return;
  }

  level.magic_wheel_spin_hint = &"CP_DISCO_INTERACTIONS_SPIN_WHEEL";
  level.reboard_barriers_hint = &"CP_DISCO_INTERACTIONS_SECURE_WINDOW";
  level.enter_area_hint = &"CP_DISCO_INTERACTIONS_ENTER_THIS_AREA";
  level thread subway_trains();
  level.player_pap_machines = [];
  level.event_funcs_init = ::cp_disco_event_wave_init;
  level.available_event_func = ::cp_disco_event_selection;
  level.event_funcs_start = ::cp_disco_event_start;
  level.event_funcs_end = ::cp_disco_event_end;
  level.should_run_event_func = ::cp_disco_should_run_event;
  level.ai_cleanup_func = ::scripts\cp\zombies\cp_disco_spawning::cp_disco_cleanup_main;
  level.callbackplayerdamage = ::scripts\cp\maps\cp_disco\cp_disco_damage::callback_discozombieplayerdamage;
  level.drop_max_ammo_func = ::scripts\cp\loot::drop_loot;
  level.should_drop_pillage = ::should_drop_pillage;
  level.show_challenge_outcome_func = ::show_challenge_outcome_func;
  level.should_continue_progress_bar_think = ::disco_should_continue_progress_bar_think;
  level.map_interaction_func = ::scripts\cp\maps\cp_disco\cp_disco_interactions::register_interactions;
  level.wait_for_interaction_func = ::scripts\cp\maps\cp_disco\cp_disco_interactions::disco_wait_for_interaction_triggered;
  level.player_interaction_monitor = ::scripts\cp\maps\cp_disco\cp_disco_interactions::disco_player_interaction_monitor;
  level.interaction_trigger_properties_func = ::discointeractiontriggerproperties;
  level.scriptablestatefunc = ::scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate;
  level.custom_pillageinitfunc = ::pillage_init;
  level.pap_room_func = ::cp_disco_pap_machine_func;
  level.kung_fu_interaction_func = ::kung_fu_interaction_func;
  level.introscreen_text_func = ::cp_disco_introscreen_text;
  level.custom_onplayerconnect_func = ::cp_disco_onplayerconnect;
  level.guidedinteractionexclusion = ::guidedinteractionsexclusions;
  level.guided_interaction_offset_func = ::guidedinteractionoffsetfunc;
  level.laststand_enter_levelspecificaction = ::disco_last_stand_handler;
  level.custom_grenade_pullback_func = ::disco_grenade_pullback_func;
  level.respawn_loc_override_func = ::respawn_loc_func;
  level.wait_to_be_revived_func = ::wait_to_be_revived_func;
  level.katana_damage_cone_func = ::katana_damage_cone;
  level.nunchucks_damage_cone_func = ::katana_damage_cone;
  level.char_intro_gesture = ::play_char_intro_gesture;
  level.mutilation_mask_override_func = ::mutilation_mask_func;
  level.lost_and_found_func = ::disco_lost_and_found;
  level.disco_power_vo_func = ::disco_power_on_vo;
  level.wheel_purchase_check = ::additional_deny_wheel_purchase;
  level.wheel_hint_func = ::deny_wheel_hint_func;
  level.magicwheel_weapon_take_check = ::magic_wheel_take_func;
  level.is_in_box_func = ::is_in_box;
  level.goon_spawner_patch_func = ::cp_disco_goon_spawner_patch_func;
  level.special_zap_start_func = ::cp_disco_zap_start_func;
  level.special_zap_end_func = ::cp_disco_zap_end_func;
  level.auto_melee_agent_type_check = ::cp_disco_auto_melee_agent_type_check;
  level.patch_update_spawners = ::disco_patch_update_spawners;
  adjuststructs();
  level.weapon_rank_event_table = "scripts\cp\maps\cp_disco\cp_disco_weaponrank_event.csv";
  level.coop_weapontable = "cp\cp_disco_weapontable.csv";
  level.customhostmigrationend = ::discohostmigrationfunc;
  level.perks = ["perk_machine_tough", "perk_machine_revive", "perk_machine_flash", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_run", "perk_machine_fwoosh", "perk_machine_deadeye", "perk_machine_zap", "perk_machine_boom"];
  level.additional_laststand_weapon_exclusion = ["iw7_cpbasketball_mp", "iw7_cpskeeball_mp", "iw7_cpclowntoothball_mp", "iw7_horseracepistol_zm_blue", "iw7_horseracepistol_zm_yellow", "iw7_horseracepistol_zm_red", "iw7_horseracepistol_zm_green", "iw7_shootgallery_zm", "iw7_blackholegun_mp", "iw7_penetrationrail_mp", "iw7_atomizer_mp", "iw7_glr_mp", "iw7_claw_mp", "iw7_steeldragon_zm", "iw7_fists_zm_tiger", "iw7_fists_zm_monkey", "iw7_fists_zm_snake", "iw7_fists_zm_crane", "iw7_fists_zm_dragon", "iw7_shootgallery_zm_blue", "iw7_shootgallery_zm_yellow", "iw7_shootgallery_zm_red", "iw7_lawnmower_zm", "iw7_shootgallery_zm_green", "iw7_gunless_zm"];
  level.last_stand_weapons = ["iw7_g18_zm", "iw7_g18_zmr", "iw7_g18_zml", "iw7_g18c_zm", "iw7_mag_zm", "iw7_revolver_zm", "iw7_revolver_zmr", "iw7_revolver_zmr_explosive", "iw7_revolver_zml", "iw7_revolver_zml_single", "iw7_emc_zm", "iw7_emc_zmr", "iw7_emc_zmr_burst", "iw7_emc_zml", "iw7_emc_zml_spread", "iw7_nrg_zm", "iw7_nrg_zmr", "iw7_nrg_zmr_smart", "iw7_nrg_zml", "iw7_nrg_zml_charge", "iw7_dischord_zm", "iw7_headcutter_zm", "iw7_shredder_zm", "iw7_facemelter_zm", "iw7_dischord_zm_pap1", "iw7_headcutter_zm_pap1", "iw7_shredder_zm_pap1", "iw7_facemelter_zm_pap1", "iw7_golf_club_mp_pap1", "iw7_two_headed_axe_mp_pap1", "iw7_spiked_bat_mp_pap1", "iw7_machete_mp_pap1", "iw7_golf_club_mp_pap2", "iw7_two_headed_axe_mp_pap2", "iw7_spiked_bat_mp_pap2", "iw7_machete_mp_pap2", "iw7_golf_club_mp", "iw7_two_headed_axe_mp", "iw7_spiked_bat_mp", "iw7_machete_mp"];
  level.melee_weapons = ["iw7_machete_mp", "iw7_golf_club_mp", "iw7_two_headed_axe_mp", "iw7_spiked_bat_mp", "iw7_golf_club_mp_pap1", "iw7_two_headed_axe_mp_pap1", "iw7_spiked_bat_mp_pap1", "iw7_machete_mp_pap1", "iw7_golf_club_mp_pap2", "iw7_two_headed_axe_mp_pap2", "iw7_spiked_bat_mp_pap2", "iw7_machete_mp_pap2", "iw7_slasher_zm", "iw7_katana_zm", "iw7_nunchucks_zm", "iw7_katana_zm_pap1", "iw7_katana_zm_pap2", "iw7_nunchucks_zm_pap1", "iw7_nunchucks_zm_pap2"];
  level.invalid_gesture_weapon = ["iw7_nunchucks_zm"];
  level.player_suit = "zom_dlc2_suit";
  level.player_run_suit = "zom_dlc2_suit_sprint";
  thread scripts\cp\maps\cp_disco\cp_disco_song_quest::song_quest_init();
  level.spawn_fx_func = ::cp_disco_spawn_fx_func;
  level.zombie_skater_vo_prefix = "zmb_vo_skater_";
  level.zombie_karatemaster_vo_prefix = "zmb_vo_karate_male_";
  level.should_spawn_special_zombie_func = ::scripts\cp\zombies\cp_disco_spawning::should_spawn_skater;
  level.special_zombie_spawn_func = ::scripts\cp\zombies\cp_disco_spawning::get_spawner_and_spawn_goons;
  level.karatemaster_spawn_percent = 0;
  level thread setupweaponupgradearray();
  level thread setup_pa_speakers();
  level thread cp_kung_fu_punch_fx();
  level thread scripts\cp\maps\cp_disco\cp_disco_ghost_activation::cp_disco_gns_3_setup();
  level thread scripts\cp\maps\cp_disco\cp_disco_vo::disco_vo_init();
  level thread scripts\cp\maps\cp_disco\rat_king::rat_king_init();
  thread power_manager();
  init_weapon_change_funcs();
  setup_pap_camos();
  scripts\cp\maps\cp_disco\kung_fu_mode::setup_kung_fu_mode_upgrades();
  thread scripts\cp\maps\cp_disco\kung_fu_mode::setup_kung_fu_powers();
  thread scripts\cp\maps\cp_disco\kung_fu_mode_dragon::setup_kung_fu_dragon_powers();
  thread scripts\cp\maps\cp_disco\kung_fu_mode_crane::setup_kung_fu_crane_powers();
  thread scripts\cp\maps\cp_disco\kung_fu_mode_snake::snake_kung_fu_init();
  thread scripts\cp\maps\cp_disco\kung_fu_mode_tiger::tiger_kung_fu_init();
  thread scripts\cp\cp_weapon::heart_power_init();
  thread scripts\cp\cp_weapon::eye_power_init();
  level.challenge_registration_func = ::scripts\cp\maps\cp_disco\cp_disco_challenges::register_default_challenges;
  level.challenge_scalar_func = ::scripts\cp\maps\cp_disco\cp_disco_challenges::challenge_scalar_func;
  level.custom_death_challenge_func = ::scripts\cp\maps\cp_disco\cp_disco_challenges::default_death_challenge_func;
  level.custom_playerdamage_challenge_func = ::scripts\cp\maps\cp_disco\cp_disco_challenges::default_playerdamage_challenge_func;
  level.death_challenge_update_func = ::scripts\cp\zombies\solo_challenges::update_death_challenges;
  level.challenge_init_func = ::scripts\cp\zombies\solo_challenges::init_solo_challenges;
  level.purchase_area_vo = ::scripts\cp\maps\cp_disco\cp_disco_vo::purchase_area_vo;
  level.aa_ww_char_vo = ::choose_correct_vo_for_player;
  level.wave_complete_dialogues_func = ::scripts\cp\zombies\cp_disco_spawning::wave_complete_vo;
  level.custom_weaponnamestring_func = ::choose_correct_strings_for_lost_and_found;
  level.setup_direct_boss_fight_func = ::disco_setup_direct_boss_fight_func;
  level.start_direct_boss_fight_func = ::disco_start_direct_boss_fight_func;
  level.direct_boss_get_kung_fu_func = ::scripts\cp\maps\cp_disco\kung_fu_mode::getactivekungfustyle;
  level.direct_boss_give_kung_fu_func = ::scripts\cp\maps\cp_disco\kung_fu_mode::direct_boss_give_kung_fu;
  scripts\cp\maps\cp_disco\cp_disco_player_character_setup::init_player_characters();
  scripts\cp\maps\cp_disco\cp_disco_weapon_upgrade::init_weapon_upgrade();
  level.char_intro_music = ::play_char_intro_music;
  level.initial_active_volumes = ["punk_subway"];
  level thread start_punk_and_disco_club_music();
  setup_generic_zombie_model_list();
  setuppamgrierchillinspots();
  scripts\cp\maps\cp_disco\rat_king_fight::rkfightinit();
  level thread wait_for_pre_game_period();
  thread scripts\cp\maps\cp_disco\disco_mpq::skq();
  scripts\cp\cp_weapon_autosentry::init();
  scripts\cp\zombies\craftables\_boombox::init();
  scripts\cp\crafted_trap_lavalamp::init();
  scripts\cp\crafted_trap_robot::init();
  level.crafting_remove_func = ::scripts\cp\maps\cp_disco\cp_disco_crafting::repopulate_puzzle_piece;
  level thread scripts\cp\maps\cp_disco\cp_disco_fast_travel::init_teleport_portals();
  level thread init_wall_buys_array();
  level thread setup_pap_token();
  level thread init_shock_subway_barriers();
  level thread rat_king_lair_doors();
  level thread cp_disco_environment();
  level thread map_exploit_spots();
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    drop_afterlife_start_points_to_ground();
  }

  sysprint("MatchStarted: Completed");
  level.no_auto_pap_upgrade = 1;
}

drop_afterlife_start_points_to_ground() {
  var_0 = scripts\engine\utility::getstructarray("afterlife_arcade", "targetname");
  foreach(var_2 in var_0) {
    var_2.origin = scripts\engine\utility::drop_to_ground(var_2.origin, 10, -100);
  }
}

hide_phone_booth_keypads() {
  self endon("disconnect");
  self waittill("spawned_player");
  foreach(var_1 in level.phone.booths) {
    var_1.keypad_frame hidefromplayer(self);
  }
}

show_soul_key_progress(var_0) {
  var_0 endon("disconnect");
  var_1 = (-10265, 932, -1581);
  var_2 = (0, 0, 90);
  var_3 = (-10260, 932, -1565);
  var_4 = (0, 0, 90);
  var_0 waittill("spawned_player");
  var_5 = var_0 getplayerdata("cp", "haveSoulKeys", "soul_key_1");
  var_6 = var_0 getplayerdata("cp", "haveSoulKeys", "soul_key_2");
  if(scripts\engine\utility::istrue(var_5)) {
    playFX(level._effect["vfx_zb_pack_grd_small_a"], var_1, anglesToForward(var_2), anglestoup(var_2), var_0);
  }

  if(scripts\engine\utility::istrue(var_6)) {
    playFX(level._effect["vfx_zb_pack_grd_small_b"], var_3, anglesToForward(var_4), anglestoup(var_4), var_0);
  }
}

init_wall_buys_array() {
  level.wall_buy_interactions = [];
  var_0 = scripts\engine\utility::getstructarray("interaction", "targetname");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.name) && var_2.name == "wall_buy") {
      level.wall_buy_interactions[level.wall_buy_interactions.size] = var_2;
    }
  }
}

map_exploit_spots() {
  level.invalid_orgs = [];
  add_invalid_place((-556.5, 1287, 1088), (500, 0, 0), 50, undefined, undefined, 1);
  add_invalid_place((-356, 2439, 960), (300, 0, 0), 64);
  add_invalid_place((-356, 2399, 960), (300, 0, 0), 64);
  add_invalid_place((-205, 921, 778), (75, -75, 0), 20, undefined, undefined, 1);
  create_linked_doors((-1520.5, 2547.5, 794.5), (-1354, 2550, 794.5));
  create_linked_doors((-1743.5, 2551.5, 953.5), (-1121.5, 2546.5, 953.5));
  var_0 = spawn("script_model", (-1808, 3736, 1160));
  var_0.angles = (90, 20, -10);
  var_0 setModel("player128x128x8");
  var_1 = spawn("script_model", (-3202, 2222, 1036));
  var_1.angles = (0, 315, -90);
  var_1 setModel("player128x128x8");
  var_2 = spawn("script_model", (-329, 2933, 239));
  var_2.angles = (0, 0, 90);
  var_2 setModel("player128x128x8");
  var_3 = spawn("script_model", (-1146, 2668, 238));
  var_3.angles = (270, 180, 180);
  var_3 setModel("player128x128x8");
  var_4 = spawn("script_model", (-2036, 3897, 894));
  var_4.angles = (0, 270, 90);
  var_4 setModel("player128x128x8");
  var_4 = spawn("script_model", (810, 2009.5, 558));
  var_4.angles = (360, 340, 90);
  var_4 setModel("player128x128x8");
  var_5 = spawn("script_model", (330, 2009.5, 558));
  var_5.angles = (0, -340, 90);
  var_5 setModel("player128x128x8");
}

add_invalid_place(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.origin = var_0;
  var_6.var_381 = var_1;
  var_6.distcheck = var_2 * var_2;
  var_6.moveplayer = var_3;
  var_6.moveplayerspot = var_4;
  var_6.skip_laugh = var_5;
  level.invalid_orgs[level.invalid_orgs.size] = var_6;
  level thread invalid_place_watcher();
}

invalid_place_watcher() {
  if(isDefined(level.invalid_place_watcher)) {
    return;
  }

  level.invalid_place_watcher = 1;
  while(!isDefined(level.players) || level.players.size == 0) {
    wait(1);
  }

  for(;;) {
    foreach(var_1 in level.invalid_orgs) {
      foreach(var_3 in level.players) {
        if(distancesquared(var_3.origin, var_1.origin) <= var_1.distcheck) {
          if(!scripts\engine\utility::istrue(var_1.skip_laugh)) {
            var_3 playlocalsound("ww_magicbox_laughter");
          }

          var_3 setvelocity(var_1.var_381);
        }
      }

      wait(0.1);
    }

    wait(0.1);
  }
}

show_ritual_site() {
  wait(10);
  scripts\engine\utility::exploder(21);
  wait(0.05);
  scripts\engine\utility::exploder(22);
  wait(0.05);
  scripts\engine\utility::exploder(23);
  wait(0.05);
  scripts\engine\utility::exploder(24);
  wait(0.05);
  scripts\engine\utility::exploder(25);
  wait(0.05);
  scripts\engine\utility::exploder(26);
  wait(0.05);
}

cp_disco_environment() {
  level thread show_ritual_site();
  level thread subway_a_power();
  level thread subway_b_power();
}

subway_a_power() {
  level waittill("punk_subway power_on");
  playsoundatpos((806, 2753, 454), "power_buy_powerup_lr");
  level thread enablestreetpas();
  wait(1);
  var_0 = getEntArray("group_1", "script_noteworthy");
  var_1 = getEntArray("group_2", "script_noteworthy");
  var_2 = getEntArray("group_3", "script_noteworthy");
  foreach(var_4 in var_0) {
    var_4 setscriptablepartstate("onoff", "on");
  }

  wait(0.5);
  foreach(var_4 in var_1) {
    var_4 setscriptablepartstate("onoff", "on");
  }

  wait(0.5);
  foreach(var_4 in var_2) {
    var_4 setscriptablepartstate("onoff", "on");
  }

  wait(1);
  var_0A = getEntArray("subway_a_on", "targetname");
  foreach(var_4 in var_0A) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "parent_light") {
      var_4 setscriptablepartstate("onoff", "on");
      continue;
    }

    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "no_light") {
      var_4 setscriptablepartstate("onoff", "on_modelonly");
      continue;
    }

    var_4 setscriptablepartstate("onoff", "on");
  }
}

subway_b_power() {
  level waittill("disco_subway power_on");
  playsoundatpos((-2662, 2680, 366), "power_buy_powerup_lr");
  var_0 = getEntArray("subway_b_on", "targetname");
  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("onoff", "on");
  }
}

setup_pap_token() {
  wait(5);
  scripts\engine\utility::flag_init("disable_portals");
  scripts\engine\utility::flag_init("pap_portal_used");
  scripts\engine\utility::flag_init("fuses_inserted");
  var_0 = getent("take_peepshow_token", "targetname");
  var_1 = getent("peepshow_token", "targetname");
  var_1 setModel("tag_origin_crafting");
  var_1 setscriptablepartstate("coin", "on");
  var_1.origin = var_1.origin + (-3, 0, 0);
  for(;;) {
    var_0 waittill("trigger", var_2);
    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(var_2 getstance() != "prone") {
      continue;
    }

    if(scripts\engine\utility::within_fov(var_2 getEye(), var_2 getplayerangles(), var_1.origin + (0, 0, 1), level.cosine["45"]) && var_2 usebuttonpressed()) {
      take_peepshow_token(var_2, var_1);
      return;
    }
  }
}

take_peepshow_token(var_0, var_1) {
  var_0 playlocalsound("pap_quest_coin_pickup");
  playFX(level._effect["crafting_pickup"], var_1.origin);
  level.peepshow_token_found = 1;
  var_2 = scripts\engine\utility::getstruct("enter_stall", "script_noteworthy");
  var_2.script_noteworthy = "enter_stall_allowed";
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("pap_quest_collect_coin", "disco_comment_vo", "low", 10, 0, 2, 0, 40);
  var_1 delete();
  level scripts\cp\utility::set_quest_icon(10);
}

setupweaponupgradearray() {
  level.weapon_upgrade_path = [];
  level.weapon_upgrade_path["iw7_katana_zm"] = "iw7_katana_zm_pap1";
  level.weapon_upgrade_path["iw7_katana_zm_pap1"] = "iw7_katana_zm_pap2";
  level.weapon_upgrade_path["iw7_nunchucks_zm"] = "iw7_nunchucks_zm_pap1";
  level.weapon_upgrade_path["iw7_nunchucks_zm_pap1"] = "iw7_nunchucks_zm_pap2";
}

setuppamgrierchillinspots() {
  level.pam_grier_chillin_origins = [];
  level.pam_grier_chillin_angles = [];
  setuppamgrierchillinspot((-711.976, 1332.2, 317.13), (0, 111.99, 0));
  setuppamgrierchillinspot((-419.748, 1597.17, 317.069), (0, 160.407, 0));
  setuppamgrierchillinspot((-764.486, 2314.52, 317.13), (0, -100.244, 0));
  setuppamgrierchillinspot((-1168.48, 2256.3, 317.13), (0, -51.0089, 0));
  setuppamgrierchillinspot((-1367.35, 1916.83, 317.027), (0, -11.3702, 0));
  setuppamgrierchillinspot((-1326.41, 1535.38, 317.13), (0, 31.2842, 0));
  level.pamvalidteleportpositioncenter = (-872, 1839, 232);
  level.pamvalidteleportradius = 600;
}

setuppamgrierchillinspot(var_0, var_1) {
  level.pam_grier_chillin_origins[level.pam_grier_chillin_origins.size] = var_0;
  level.pam_grier_chillin_angles[level.pam_grier_chillin_angles.size] = var_1;
}

registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("mp\dlc2_agent_definition.csv");
  scripts\mp\agents\zombie_dlc2\zombie_dlc2_agent::registerscriptedagent();
  scripts\mp\agents\ratking\ratking_agent::registerscriptedagent();
  scripts\mp\agents\skater\skater_agent::registerscriptedagent();
  scripts\mp\agents\pamgrier\pamgrier_agent::registerscriptedagent();
  scripts\mp\agents\karatemaster\karatemaster_agent::registerscriptedagent();
  scripts\mp\agents\zombie_skeleton\zombie_skeleton::registerscriptedagent();
  scripts\cp\maps\cp_disco\ratking_damage::cp_ratking_callbacks();
  setupratkingteleportpoints();
}

setupratkingteleportpoints() {
  level.ratkingplatformteleportpoints = [];
  level.ratkingplatformteleportpoints[level.ratkingplatformteleportpoints.size] = (-684.214, 1335.38, 317.043);
  level.ratkingplatformteleportpoints[level.ratkingplatformteleportpoints.size] = (-528.93, 1462.45, 317.13);
  level.ratkingplatformteleportpoints[level.ratkingplatformteleportpoints.size] = (-412.909, 1623.13, 317.13);
  level.ratkingplatformteleportpoints[level.ratkingplatformteleportpoints.size] = (-791.492, 2319.98, 317.047);
  level.ratkingplatformteleportpoints[level.ratkingplatformteleportpoints.size] = (-982.638, 2305.95, 317.142);
  level.ratkingplatformteleportpoints[level.ratkingplatformteleportpoints.size] = (-1151.4, 2246.92, 317.13);
  level.ratkingplatformteleportpoints[level.ratkingplatformteleportpoints.size] = (-1369.53, 1918.71, 317.051);
  level.ratkingplatformteleportpoints[level.ratkingplatformteleportpoints.size] = (-1360.75, 1731.37, 317.13);
  level.ratkingplatformteleportpoints[level.ratkingplatformteleportpoints.size] = (-1290.91, 1555.26, 317.022);
  level.ratkingteleportpoints = [];
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1310.03, 1620.97, 178.013);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1307.11, 1843.66, 178.128);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1225.21, 2059.73, 170.066);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1036.26, 2199.05, 178.128);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-842.325, 2230.31, 178.014);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-666.487, 2206.76, 171.195);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-571.448, 2042.22, 178.075);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-504.043, 1876.39, 178.092);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-447.928, 1681.52, 178.128);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-579.268, 1494.25, 178.107);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-765.578, 1409.76, 178.028);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-956.474, 1447.47, 178.128);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1123.2, 1535.45, 178.128);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1254.46, 1690.5, 178.128);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1288.3, 1884.33, 178.043);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1209.84, 2080.16, 178.116);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1094.75, 2200.93, 178.096);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-930.01, 2127.66, 170.28);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1015.4, 1997.97, 154.717);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1091.93, 1819.04, 154.427);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1010.04, 1632.38, 154.719);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-812.357, 1621.31, 155.004);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-680.848, 1750.75, 155.007);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-673.177, 1926.77, 154.846);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-828.777, 2025.03, 154.596);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1017.89, 2004.05, 155.106);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-1059.36, 1832.49, 156.967);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-956.588, 1778.49, 178.101);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-845.313, 1760.35, 178.118);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-809.704, 1863.82, 178.058);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-910.266, 1879.26, 178.128);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-944.92, 1778.15, 178.128);
  level.ratkingteleportpoints[level.ratkingteleportpoints.size] = (-877.495, 1826.45, 178.043);
}

registerlevelenemyarrays() {
  level.ignoreimmune = ["ratking", "pamgrier"];
  level.fnfimmune = ["ratking", "pamgrier"];
  level.instakillimmune = ["ratking", "pamgrier"];
  level.specialzombie = ["ratking", "pamgrier"];
}

wait_for_pre_game_period() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  level.current_personal_interaction_structs = [];
  level.special_mode_activation_funcs = [];
  level.normal_mode_activation_funcs = [];
  wait(0.2);
  scripts\engine\utility::flag_set("zombie_drop_powerups");
  scripts\engine\utility::flag_set("pillage_enabled");
  scripts\cp\zombies\zombie_entrances::enable_windows_in_area("subway_start");
  init_magic_wheel();
  level thread add_additional_map_spawners();
}

init_magic_wheel() {
  var_0 = ["alley_west", "disco_roof"];
  scripts\cp\zombies\interaction_magicwheel::set_magic_wheel_starting_location(scripts\engine\utility::random(var_0));
}

add_additional_map_spawners() {
  scripts\engine\utility::flag_wait("init_spawn_volumes_done");
  scripts\cp\zombies\zombies_spawning::create_spawner("alley_west", (-2384, 768, 1000), (0, 0, 0), "ground_spawn_no_boards", "spawn_ground", "concrete");
  scripts\cp\zombies\zombies_spawning::create_spawner("alley_west", (-2016, 771, 1136), (0, 90, 0), "ground_spawn_no_boards", "spawn_ground", "concrete");
  scripts\cp\zombies\zombies_spawning::create_spawner("alley_west", (-2425, 2782.5, 752), (0, 90, 0), "ground_spawn_no_boards", "spawn_ground", "concrete");
  scripts\cp\zombies\zombies_spawning::create_spawner("alley_west", (-2676, 3155.5, 7522), (0, 315, 0), "ground_spawn_no_boards", "spawn_ground", "concrete");
  level.rat_king_lair_spawners = [];
  level.rat_king_lair_spawners[level.rat_king_lair_spawners.size] = scripts\cp\zombies\zombies_spawning::create_spawner("sewer_underground", (-699, 1933, 215), (0, 150, 0), "ground_spawn_no_boards", "spawn_ground", "dirt");
  level.rat_king_lair_spawners[level.rat_king_lair_spawners.size] = scripts\cp\zombies\zombies_spawning::create_spawner("sewer_underground", (-1051, 1921, 215), (0, 235, 0), "ground_spawn_no_boards", "spawn_ground", "dirt");
  level.rat_king_lair_spawners[level.rat_king_lair_spawners.size] = scripts\cp\zombies\zombies_spawning::create_spawner("sewer_underground", (-973, 1628, 215), (0, 0, 0), "ground_spawn_no_boards", "spawn_ground", "dirt");
  level.rat_king_lair_spawners[level.rat_king_lair_spawners.size] = scripts\cp\zombies\zombies_spawning::create_spawner("sewer_underground", (-645, 1803, 215), (0, 100, 0), "ground_spawn_no_boards", "spawn_ground", "dirt");
}

pillage_init() {
  level.pillageinfo = spawnStruct();
  level.pillageinfo.default_use_time = 500;
  level.pillageinfo.money_stack = "pb_money_stack_01";
  level.pillageinfo.attachment_model = "has_spotter_scope";
  level.pillageinfo.maxammo_model = "mil_ammo_case_1_open";
  level.pillageinfo.clip_model = "weapon_baseweapon_clip";
  level.pillageinfo.power_model = "misc_interior_card_game_01";
  level.pillageinfo.grenade_model = "weapon_m67_grenade";
  level.pillageinfo.ui_searching = 1;
  level.pillageable_powers = [];
  level.pillageable_explosives = ["power_clusterGrenade", "power_gasGrenade", "power_bioSpike", "power_c4", "power_frag"];
  level.pillageable_attachments = [];
  level.pillageinfo.clip = 33;
  level.pillageinfo.explosive = 33;
  level.pillageinfo.money = 34;
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_1", "backpack", "cp_rave_backpack_dropped", "cp_rave_backpack", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_2", "backpack", "cp_rave_backpack_dropped_green", "cp_rave_backpack_green", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_3", "backpack", "cp_rave_backpack_dropped_purple", "cp_rave_backpack_purple", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_4", "backpack", "cp_rave_backpack_dropped_red", "cp_rave_backpack_red", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("fanny_pack_1", "backpack", "zombies_fanny_pack_dropped", "zombies_fanny_pack", "J_HipTwist_LE");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("fanny_pack_3", "backpack", "zombies_fanny_pack_dropped_purple", "zombies_fanny_pack_purple", "J_HipTwist_LE");
}

init_weapon_change_funcs() {
  level.weapon_change_func = [];
  level.weapon_change_func["iw7_nunchucks_zm_pap1"] = ::watchnunchuckspap1usage;
  level.weapon_change_func["iw7_nunchucks_zm_pap2"] = ::watchnunchuckspap2usage;
  level.weapon_change_func["iw7_katana_zm_pap1"] = ::watchkatanapap1usage;
  level.weapon_change_func["iw7_katana_zm_pap2"] = ::watchkatanapap2usage;
}

katana_damage_cone() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  for(;;) {
    self waittill("katana_melee_hit", var_0, var_1, var_2);
    var_3 = getweaponbasename(var_0);
    var_4 = scripts\cp\cp_weapon::get_weapon_level(var_3);
    var_5 = get_katana_fov(var_3, var_4);
    var_6 = get_katana_hit_distance(var_3, var_4);
    var_7 = get_katana_max_enemies(var_3, var_4);
    var_8 = scripts\cp\zombies\zombies_weapons::checkenemiesinfov(var_5, var_6, var_7);
    foreach(var_0A in var_8) {
      if(var_0A == var_1) {
        continue;
      }

      var_0A thread katana_damage(var_0A, self, var_2, var_0A.origin, self.origin, var_0, 0.5);
    }
  }
}

katana_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  if(var_0 scripts\cp\agents\gametype_zombie::is_non_standard_zombie()) {
    var_0.allowpain = 1;
  }

  var_0 dodamage(var_2, var_3, var_1, var_1, "MOD_MELEE");
  wait(var_6);
  if(scripts\engine\utility::istrue(var_0.allowpain)) {
    var_0.allowpain = 0;
  }
}

get_katana_fov(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 45;
  }

  switch (var_1) {
    case 2:
      return 60;

    case 3:
      return 75;

    default:
      return 45;
  }
}

get_katana_hit_distance(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 125;
  }

  switch (var_1) {
    case 2:
      return 150;

    case 3:
      return 175;

    default:
      return 125;
  }
}

get_katana_max_enemies(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 1;
  }

  switch (var_1) {
    case 2:
      return 8;

    case 3:
      return 12;

    default:
      return 4;
  }
}

get_katana_melee_damage(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 110000;
  }

  switch (var_1) {
    case 2:
      return 150000;

    case 3:
      return 200000;

    default:
      return 110000;
  }
}

setkatanascriptablestate(var_0) {
  var_0 notify("setaxeblooddrip");
  var_0 endon("setaxeblooddrip");
  var_0 setscriptablepartstate("axe", "neutral");
  wait(0.5);
  var_0 setscriptablepartstate("axe", "blood on");
  wait(5);
  var_0 setscriptablepartstate("axe", "neutral");
}

cp_disco_onplayerconnect(var_0) {
  var_0 thread assignpersonalmodelents(var_0);
  var_0 thread watchforweaponchange(var_0);
  var_0 thread watchforplayerzonechange(var_0);
  var_0 thread movepentstostructs(var_0);
  var_1 = var_0 getplayerdata("cp", "haveSoulKeys", "any_soul_key");
  var_2 = var_0 getplayerdata("cp", "haveSoulKeys", "soul_key_1");
  var_3 = var_0 getplayerdata("cp", "haveSoulKeys", "soul_key_2");
  var_4 = var_0 getplayerdata("cp", "haveSoulKeys", "soul_key_3");
  if(var_4) {
    var_0.has_disco_soul_key = 1;
  }

  if(var_3) {
    var_0.has_ritrw_soul_key = 1;
  }

  if(var_2) {
    var_0.has_zis_soul_key = 1;
  }

  thread run_pap_machine_logic(var_0);
  var_0 scripts\cp\zombies\zombies_chi_meter::init_chi_meter(var_0);
  var_0 thread scripts\cp\maps\cp_disco\kung_fu_mode::setup_player_kung_fu_progression(var_0);
  level thread updatetunedataondisconnect(var_0);
  if(level.players.size == 1) {
    [[level.soloratkingtuning]](level.agenttunedata["ratking"]);
  } else {
    [[level.ratkingtuning]](level.agenttunedata["ratking"]);
  }

  if(isDefined(level.phonebooths)) {
    foreach(var_6 in level.phonebooths) {
      var_6.keypad_model hidefromplayer(var_0);
    }
  }

  level thread watch_player_on_ladders(var_0);
  var_0 thread scripts\cp\maps\cp_disco\cp_disco_song_quest::song_quest_interactions();
  var_0 thread scripts\cp\maps\cp_disco\cp_disco_song_quest::player_set_up_time_quests();
  var_0 thread scripts\cp\cp_vo::add_to_nag_vo("nag_board_windows", "disco_comment_vo", 500, 120, 2, 1);
  var_0 thread scripts\cp\maps\cp_disco\cp_disco_interactions::setup_backstory_models_hotjoined_player();
  var_0 thread achievement_watcher();
  var_0 thread show_soul_key_progress(var_0);
  var_0 thread hide_phone_booth_keypads();
}

achievement_watcher() {
  level endon("game_ended");
  self endon("all_collected");
  self endon("disconnect");
  var_0 = 0;
  self.craftables = ["purchase_zombgone", "purchase_turret", "purchase_boombox", "purchase_lavalamp", "purchase_robot"];
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  for(;;) {
    if(!scripts\engine\utility::istrue(var_1)) {
      var_5 = self getplayerdata("cp", "alienSession", "escapedRank0");
      var_6 = self getplayerdata("cp", "alienSession", "escapedRank1");
      var_7 = self getplayerdata("cp", "alienSession", "escapedRank2");
      var_8 = self getplayerdata("cp", "alienSession", "escapedRank3");
      if(isDefined(var_5) && isDefined(var_6) && isDefined(var_7) && isDefined(var_8)) {
        if(var_5 == 1 && var_6 == 1 && var_7 == 1 && var_8 == 1) {
          scripts\cp\zombies\achievement::update_achievement("BOOK_WORM", 1);
          var_1 = 1;
        }
      }
    }

    if(isDefined(self.craftables) && self.craftables.size == 0 && !scripts\engine\utility::istrue(var_2)) {
      scripts\cp\zombies\achievement::update_achievement("SOME_ASSEMBLY_REQUIRED", 1);
      var_2 = 1;
    }

    if(scripts\engine\utility::flag_exist("rk_fight_ended") && scripts\engine\utility::flag("rk_fight_ended")) {
      var_3 = 1;
    }

    if(scripts\engine\utility::istrue(self.found_pap)) {
      var_4 = 1;
    }

    if(var_3 && var_4) {
      foreach(var_0A in level.players) {
        var_0A scripts\cp\zombies\achievement::update_achievement("SOUL_BROTHER", 1);
      }
    }

    if(var_3 && var_4 && scripts\engine\utility::istrue(var_1) && scripts\engine\utility::istrue(var_2)) {
      self notify("all_collected");
    }

    wait(1);
  }
}

watch_player_on_ladders(var_0) {
  var_0 endon("disconnect");
  var_0.time_on_ladders = 0;
  var_0.time_off_ladders = 0;
  var_1 = 20;
  var_2 = 30;
  var_3 = 10;
  for(;;) {
    if(!var_0 isonladder()) {
      wait(0.05);
      var_0.time_off_ladders = var_0.time_off_ladders + 0.05;
      if(var_0.time_off_ladders >= var_3) {
        var_0.time_off_ladders = 0;
        var_0.time_on_ladders = 0;
      }

      continue;
    } else {
      var_0.time_off_ladders = 0;
      var_4 = 0;
      while(var_0 isonladder()) {
        if(var_0.time_on_ladders >= var_1 && !var_4) {
          var_0 dodamage(50, var_0.origin);
          wait(0.5);
          var_0 playlocalsound("ww_magicbox_laughter");
          var_4 = 1;
        }

        if(var_0.time_on_ladders >= var_2) {
          var_0 playlocalsound("ww_magicbox_laughter");
          wait(1);
          var_0 dodamage(var_0.health + 200, var_0.origin, var_0, var_0, "MOD_MELEE");
        }

        wait(0.05);
        var_0.time_on_ladders = var_0.time_on_ladders + 0.05;
      }
    }

    wait(0.05);
  }
}

watchforplayerzonechange(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  scripts\engine\utility::flag_wait("init_interaction_done");
  var_1 = getent("zone_change", "targetname");
  if(isDefined(var_1)) {
    for(;;) {
      if(var_0 istouching(var_1)) {
        var_0 notify("rave_status_changed");
        wait(1);
        continue;
      } else {
        wait(0.1);
      }
    }
  }
}

updatetunedataondisconnect(var_0) {
  level endon("game_ended");
  var_0 waittill("disconnect");
  if(level.players.size == 1) {
    [[level.soloratkingtuning]](level.agenttunedata["ratking"]);
    return;
  }

  [[level.ratkingtuning]](level.agenttunedata["ratking"]);
}

cp_disco_pap_machine_func(var_0, var_1) {
  level.pap_machine = var_1;
  level.pap_machine hide();
  var_0.powered_on = 1;
}

watchforweaponchange(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  for(;;) {
    var_0 waittill("weapon_change", var_1);
    var_2 = getweaponbasename(var_1);
    if(is_weapon_valid_primary(var_2)) {
      var_0.last_valid_weapon = var_1;
    }

    if(isDefined(level.weapon_change_func[var_2])) {
      var_0 thread[[level.weapon_change_func[var_2]]](var_0);
    }
  }
}

is_weapon_valid_primary(var_0) {
  var_1 = level.additional_laststand_weapon_exclusion;
  if(var_0 == "none") {
    return 0;
  }

  if(scripts\engine\utility::array_contains(var_1, var_0)) {
    return 0;
  }

  if(scripts\engine\utility::array_contains(var_1, getweaponbasename(var_0))) {
    return 0;
  }

  if(scripts\cp\utility::is_melee_weapon(var_0, 1)) {
    return 0;
  }

  return 1;
}

assignpersonalmodelents(var_0) {
  var_0.personalents = [];
  for(var_1 = 0; var_1 < 15; var_1++) {
    var_2 = spawn("script_model", (0, 0, -5000));
    var_2.ogorigin = (0, 0, -5000);
    var_2 setModel("tag_origin");
    var_2.claimed = 0;
    var_2.used = 0;
    var_0.personalents[var_0.personalents.size] = var_2;
  }

  level thread deletepentsondisconnect(var_0);
}

deletepentsondisconnect(var_0) {
  level endon("game_ended");
  var_0 waittill("disconnect");
  foreach(var_2 in var_0.personalents) {
    var_2 delete();
  }
}

addtopersonalinteractionlist(var_0) {
  level.current_personal_interaction_structs = scripts\engine\utility::array_add(level.current_personal_interaction_structs, var_0);
}

removefrompersonalinteractionlist(var_0) {
  level.current_personal_interaction_structs = scripts\engine\utility::array_remove(level.current_personal_interaction_structs, var_0);
}

movepentstostructs(var_0) {
  var_0 endon("disconnect");
  if(!scripts\engine\utility::flag("init_interaction_done")) {
    scripts\engine\utility::flag_wait("init_interaction_done");
  }

  var_1 = scripts\engine\utility::istrue(var_0.kung_fu_mode);
  for(;;) {
    var_0.mode_updating = 1;
    var_2 = 0;
    var_3 = 0;
    if(scripts\engine\utility::istrue(var_0.kung_fu_mode) != var_1) {
      var_1 = scripts\engine\utility::istrue(var_0.kung_fu_mode);
      var_3 = 1;
    }

    var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.current_personal_interaction_structs, undefined, 100);
    var_4 = removeinvalidstructs(var_4, var_0);
    var_4 = sortbydistance(var_4, var_0.origin);
    var_0 resetents(var_0, var_4);
    foreach(var_6 in var_4) {
      var_7 = undefined;
      if(isDefined(var_6.target)) {
        var_7 = scripts\engine\utility::getstruct(var_6.target, "targetname");
      }

      var_8 = 0;
      if(var_6 hasplayerentattached(var_0, var_6)) {
        var_9 = getattachedpersonalent(var_0, var_6);
        if(isDefined(var_9)) {
          if(var_3) {
            if(scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
              if(isDefined(var_6.script_noteworthy) && isDefined(level.special_mode_activation_funcs[var_6.script_noteworthy])) {
                var_8 = 1;
                if(isDefined(var_7)) {
                  var_9[[level.special_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_7, 0, var_0);
                } else {
                  var_9[[level.special_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_6, 0, var_0);
                }
              } else if(isDefined(var_6.kung_fu_model)) {
                var_9 setModel(var_6.kung_fu_model);
              }
            } else if(isDefined(var_6.script_noteworthy) && isDefined(level.normal_mode_activation_funcs[var_6.script_noteworthy])) {
              var_8 = 1;
              if(isDefined(var_7)) {
                var_9[[level.normal_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_7, 0, var_0);
              } else {
                var_9[[level.normal_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_6, 0, var_0);
              }
            } else if(isDefined(var_6.normal_model)) {
              var_9 setModel(var_6.normal_model);
            }
          } else if(scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
            if(isDefined(var_6.script_noteworthy) && isDefined(level.special_mode_activation_funcs[var_6.script_noteworthy])) {
              var_8 = 1;
              if(isDefined(var_7)) {
                var_9[[level.special_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_7, 1, var_0);
              } else {
                var_9[[level.special_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_6, 1, var_0);
              }
            }
          } else if(isDefined(var_6.script_noteworthy) && isDefined(level.normal_mode_activation_funcs[var_6.script_noteworthy])) {
            var_8 = 1;
            if(isDefined(var_7)) {
              var_9[[level.normal_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_7, 1, var_0);
            } else {
              var_9[[level.normal_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_6, 1, var_0);
            }
          }
        }

        continue;
      }

      var_9 = getunclaimedpersonalent(var_0, var_4);
      if(isDefined(var_9)) {
        var_9 setCanDamage(0);
        var_6.currentlyownedby[var_0.name] = var_9;
        var_9.claimed = 1;
        var_9.used = 1;
        var_9 dontinterpolate();
        if(isDefined(var_6.target)) {
          var_7 = scripts\engine\utility::getstruct(var_6.target, "targetname");
          var_9.origin = var_7.origin;
          if(isDefined(var_7.angles)) {
            var_9.angles = var_7.angles;
          } else {
            var_9.angles = (0, 0, 0);
          }
        } else {
          var_9.origin = var_6.origin;
          if(isDefined(var_6.angles)) {
            var_9.angles = var_6.angles;
          } else {
            var_9.angles = (0, 0, 0);
          }
        }

        if(scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
          if(isDefined(var_6.script_noteworthy) && isDefined(level.special_mode_activation_funcs[var_6.script_noteworthy])) {
            var_8 = 1;
            if(isDefined(var_7)) {
              var_9[[level.special_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_7, 0, var_0);
            } else {
              var_9[[level.special_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_6, 0, var_0);
            }
          } else if(isDefined(var_6.kung_fu_model)) {
            var_9 setModel(var_6.kung_fu_model);
          }
        } else if(isDefined(var_6.script_noteworthy) && isDefined(level.normal_mode_activation_funcs[var_6.script_noteworthy])) {
          var_8 = 1;
          if(isDefined(var_7)) {
            var_9[[level.normal_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_7, 0, var_0);
          } else {
            var_9[[level.normal_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_6, 0, var_0);
          }
        } else if(isDefined(var_6.normal_model)) {
          var_9 setModel(var_6.normal_model);
        }

        adjustmodelvis(var_0, var_9);
      }
    }

    var_0.mode_updating = undefined;
    var_0 notify("rave_mode_updated");
    var_0 scripts\engine\utility::waittill_any_return_no_endon_death_3("zone_change", "rave_status_changed", "rave_interactions_updated");
  }
}

update_special_mode_for_player(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  while(scripts\engine\utility::istrue(var_0.mode_updating)) {
    scripts\engine\utility::waitframe();
  }

  waittillframeend;
  var_0 notify("rave_interactions_updated");
}

resetents(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_0.personalents) {
    var_5 = 0;
    foreach(var_7 in var_1) {
      if(isDefined(var_7.playeroffset) && isDefined(var_7.playeroffset[var_0.name])) {
        if(var_4.origin == var_7.playeroffset[var_0.name]) {
          var_5 = 1;
          break;
        }
      }

      if(isDefined(var_7.target)) {
        var_8 = scripts\engine\utility::getstruct(var_7.target, "targetname");
        if(var_4.origin == var_8.origin) {
          var_5 = 1;
          break;
        }

        continue;
      }

      if(var_4.origin == var_7.origin) {
        var_5 = 1;
        break;
      }
    }

    if(!var_5) {
      var_4 resetpersonalent(var_4);
    }
  }

  scripts\engine\utility::waitframe();
}

removeinvalidstructs(var_0, var_1) {
  var_2 = [];
  var_0 = sortbydistance(var_0, var_1.origin);
  foreach(var_4 in var_0) {
    if(!scripts\engine\utility::istrue(var_1.kung_fu_mode) && scripts\engine\utility::istrue(var_4.only_kung_fu_mode)) {
      continue;
    }

    if(isDefined(var_1.disabled_interactions) && scripts\engine\utility::array_contains(var_1.disabled_interactions, var_4)) {
      continue;
    }

    if(isDefined(var_4.target)) {
      var_5 = scripts\engine\utility::getstructarray(var_4.var_336, "targetname");
      foreach(var_7 in var_5) {
        if(isDefined(var_7.target) && var_7.target == var_4.target) {
          var_0 = scripts\engine\utility::array_remove(var_0, var_7);
        }
      }

      var_2[var_2.size] = var_4;
      if(var_2.size >= 15) {
        break;
      }

      continue;
    }

    var_2[var_2.size] = var_4;
    if(var_2.size >= 15) {
      break;
    }
  }

  return var_2;
}

is_in_active_volume(var_0) {
  if(!isDefined(level.active_spawn_volumes)) {
    return 1;
  }

  var_1 = sortbydistance(level.active_spawn_volumes, var_0);
  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0, var_3)) {
      return 1;
    }
  }

  return 0;
}

hasplayerentattached(var_0, var_1) {
  foreach(var_3 in var_0.personalents) {
    if(isDefined(var_1.playeroffset) && isDefined(var_1.playeroffset[var_0.name])) {
      if(var_3.origin == var_1.playeroffset[var_0.name]) {
        var_3.used = 1;
        return 1;
      }
    }

    if(isDefined(var_1.target)) {
      var_4 = scripts\engine\utility::getstruct(var_1.target, "targetname");
      if(var_3.origin == var_4.origin) {
        var_3.used = 1;
        return 1;
      }
    }

    if(var_3.origin == var_1.origin) {
      var_3.used = 1;
      return 1;
    }
  }

  return 0;
}

adjustmodelvis(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      var_1 showtoplayer(var_3);
      continue;
    }

    var_1 hidefromplayer(var_3);
  }
}

resetpersonalents(var_0, var_1) {
  foreach(var_3 in var_0.personalents) {
    if(scripts\engine\utility::istrue(var_1)) {
      var_3 thread resetpersonalent(var_3);
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.used)) {
      var_3.used = 0;
      continue;
    }

    var_3 thread resetpersonalent(var_3);
  }

  scripts\engine\utility::waitframe();
}

resetpersonalent(var_0) {
  var_0 setModel("tag_origin");
  var_0.claimed = 0;
  var_0.used = 0;
  var_0 dontinterpolate();
  var_0.origin = var_0.ogorigin;
  var_0 notify("p_ent_reset");
}

getattachedpersonalent(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_0.personalents) {
    if(isDefined(var_1.playeroffset) && isDefined(var_1.playeroffset[var_0.name])) {
      if(var_4.origin == var_1.playeroffset[var_0.name]) {
        return var_4;
      }
    }

    if(isDefined(var_1.target)) {
      var_5 = scripts\engine\utility::getstruct(var_1.target, "targetname");
      if(var_4.origin == var_5.origin) {
        return var_4;
      }
    }

    if(var_4.origin == var_1.origin) {
      return var_4;
    }
  }

  return undefined;
}

getunclaimedpersonalent(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_0.personalents) {
    var_5 = 0;
    foreach(var_7 in var_1) {
      if(isDefined(var_7.playeroffset) && isDefined(var_7.playeroffset[var_0.name])) {
        if(var_4.origin == var_7.playeroffset[var_0.name]) {
          var_5 = 1;
          break;
        }
      }

      if(isDefined(var_7.target)) {
        var_8 = scripts\engine\utility::getstruct(var_7.target, "targetname");
        if(var_4.origin == var_8.origin) {
          var_5 = 1;
          break;
        }
      }

      if(var_4.origin == var_7.origin) {
        var_5 = 1;
        break;
      }
    }

    if(!var_5) {
      return var_4;
    }
  }

  return undefined;
}

run_pap_machine_logic(var_0) {
  wait(3);
  var_1 = getent("pap_machine", "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2.angles = var_1.angles;
  if(scripts\engine\utility::istrue(level.placed_alien_fuses)) {
    var_2 setModel("zmb_pap_machine_animated_soul_key");
    var_2 setscriptablepartstate("machine", "upgraded");
  } else {
    var_2 setModel("zmb_pap_machine_animated_rave");
  }

  var_2 setscriptablepartstate("reels", "on");
  var_2 setscriptablepartstate("door", "open_idle");
  var_2.triggerportableradarping = var_0;
  foreach(var_4 in level.players) {
    if(var_4 != var_0) {
      var_2 hidefromplayer(var_4);
    }
  }

  level.player_pap_machines[level.player_pap_machines.size] = var_2;
  var_2 thread watch_for_player_connect(var_0);
  var_2 thread cleanup_ent_on_player_disconnect(var_0);
}

watch_for_player_connect(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  for(;;) {
    level waittill("connected", var_1);
    if(var_1 != var_0) {
      self hidefromplayer(var_1);
    }
  }
}

cleanup_ent_on_player_disconnect(var_0) {
  level endon("game_ended");
  var_0 waittill("disconnect");
  if(isDefined(self)) {
    self delete();
  }

  level.player_pap_machines = scripts\engine\utility::array_removeundefined(level.player_pap_machines);
}

cp_kung_fu_punch_fx() {
  level._effect["afterlife_portal_fx"] = loadfx("vfx\iw7\levels\cp_disco\vfx_disco_portal_afterlife.vfx");
  level.centhub_portal_fx = level._effect["afterlife_portal_fx"];
  level._effect["chi_pulse"] = loadfx("vfx\iw7\core\zombie\weapon\vfx_proj_trail_hp4.vfx");
  level._effect["chi_screen_fx"] = loadfx("vfx\core\mp\core\vfx_battle_slide_camera");
  level._effect["chi_ghost_death"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_ghost_imp.vfx");
  level._effect["chi_ghost_death_blue"] = loadfx("vfx\iw7\levels\cp_rave\vfx_rave_soul_punch_explode.vfx");
  level._effect["chi_ghost_hit_blue"] = loadfx("vfx\iw7\levels\cp_disco\vfx_disco_soul_punch_hit_crane.vfx");
  level._effect["chi_ghost_hit_green"] = loadfx("vfx\iw7\levels\cp_disco\vfx_disco_soul_punch_hit_snake.vfx");
  level._effect["chi_ghost_hit_red"] = loadfx("vfx\iw7\levels\cp_disco\vfx_disco_soul_punch_hit_tiger.vfx");
  level._effect["chi_ghost_hit_yellow"] = loadfx("vfx\iw7\levels\cp_disco\vfx_disco_soul_punch_hit_dragon.vfx");
  level._effect["blood_fountain"] = loadfx("vfx\iw7\levels\cp_disco\fnf\vfx_zb_headoff_bld.vfx");
  level._effect["dragon_slice"] = loadfx("vfx\iw7\levels\cp_disco\vfx_kfc_dragon.vfx");
}

cp_disco_event_wave_init() {
  level.event_funcs["goon"] = scripts\cp\zombies\cp_disco_spawning::goon_spawn_event_func;
  init_disco_spawner_locations();
}

init_disco_spawner_locations() {
  level.goon_spawners = [];
  var_0 = scripts\engine\utility::getstructarray("dog_spawner", "targetname");
  if(isDefined(level.goon_spawner_patch_func)) {
    [[level.goon_spawner_patch_func]](var_0);
  }

  var_1 = [];
  foreach(var_3 in var_0) {
    if(!scripts\engine\utility::istrue(var_3.remove_me)) {
      var_1[var_1.size] = var_3;
    }
  }

  var_0 = var_1;
  foreach(var_3 in var_0) {
    var_6 = 0;
    foreach(var_8 in level.invalid_spawn_volume_array) {
      if(ispointinvolume(var_3.origin, var_8)) {
        var_6 = 1;
      }
    }

    if(!var_6) {
      foreach(var_8 in level.spawn_volume_array) {
        if(ispointinvolume(var_3.origin, var_8)) {
          if(!isDefined(var_3.angles)) {
            var_3.angles = (0, 0, 0);
          }

          level.goon_spawners[level.goon_spawners.size] = var_3;
          var_3.volume = var_8;
          if(!isDefined(var_8.goon_spawners)) {
            var_8.goon_spawners = [];
          }

          var_8.goon_spawners[var_8.goon_spawners.size] = var_3;
          break;
        }
      }
    }
  }
}

cp_disco_should_run_event(var_0) {
  if(scripts\engine\utility::flag("rk_fight_started")) {
    return 0;
  }

  var_1 = var_0 - level.last_event_wave;
  if(var_1 < 5) {
    return 0;
  } else {
    var_1 = var_1 - 4;
    var_2 = var_1 / 3 * 100;
    if(randomint(100) < var_2) {
      return 1;
    } else {
      return 0;
    }
  }

  return 0;
}

cp_disco_event_selection(var_0) {
  return "goon";
}

cp_disco_event_start(var_0) {
  switch (var_0) {
    case "goon":
      level thread clown_wave_music();
      break;

    default:
      break;
  }
}

clown_wave_music() {
  wait(0.5);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_skater_wavestart", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  wait(2.5);
  if(soundexists("mus_zombies_eventwave_start")) {
    level thread mus_rave_eventwave_start();
  }

  level.wait_for_music_sasquatch = 1;
}

mus_rave_eventwave_start() {
  scripts\cp\utility::playsoundinspace("mus_zombies_eventwave_start", (0, 0, 0));
  level notify("wave_start_sound_done");
}

mus_rave_eventwave_end() {
  scripts\cp\utility::playsoundinspace("mus_zombies_eventwave_end", (0, 0, 0));
}

cp_disco_event_end(var_0) {
  switch (var_0) {
    case "goon":
      level thread mus_rave_eventwave_end();
      break;

    default:
      break;
  }
}

setup_generic_zombie_model_list() {
  level.generic_zombie_model_list = ["zombie_dlc2_male_outfit_1", "zombie_dlc2_male_outfit_1_2", "zombie_dlc2_male_outfit_2", "zombie_dlc2_male_outfit_2_2", "zombie_dlc2_male_outfit_2_3", "zombie_dlc2_male_outfit_3", "zombie_dlc2_male_outfit_3_2", "zombie_dlc2_male_outfit_3_3", "zombie_dlc2_male_outfit_4", "zombie_dlc2_male_outfit_4_2", "zombie_dlc2_male_outfit_4_3", "zombie_dlc2_male_outfit_5", "zombie_dlc2_male_outfit_5_2", "zombie_dlc2_male_outfit_5_3", "zombie_dlc2_male_outfit_6", "zombie_dlc2_male_outfit_6_2", "zombie_dlc2_male_outfit_6_3", "zombie_dlc2_male_outfit_1_b", "zombie_dlc2_male_outfit_1_2_b", "zombie_dlc2_male_outfit_1_3_c", "zombie_dlc2_male_outfit_2_b", "zombie_dlc2_male_outfit_2_2_b", "zombie_dlc2_male_outfit_2_3_b", "zombie_dlc2_male_outfit_3_b", "zombie_dlc2_male_outfit_3_2_b", "zombie_dlc2_male_outfit_3_3_b", "zombie_dlc2_male_outfit_4_b", "zombie_dlc2_male_outfit_4_2_b", "zombie_dlc2_male_outfit_4_3_b", "zombie_dlc2_male_outfit_5_b", "zombie_dlc2_male_outfit_5_2_b", "zombie_dlc2_male_outfit_5_3_b", "zombie_dlc2_male_outfit_6_b", "zombie_dlc2_male_outfit_6_2_b", "zombie_dlc2_male_outfit_6_3_b", "zombie_dlc2_male_outfit_1_c", "zombie_dlc2_male_outfit_1_2_c", "zombie_dlc2_male_outfit_1_3_c", "zombie_dlc2_male_outfit_2_c", "zombie_dlc2_male_outfit_2_2_c", "zombie_dlc2_male_outfit_2_3_c", "zombie_dlc2_male_outfit_3_c", "zombie_dlc2_male_outfit_3_2_c", "zombie_dlc2_male_outfit_3_3_c", "zombie_dlc2_male_outfit_4_c", "zombie_dlc2_male_outfit_4_2_c", "zombie_dlc2_male_outfit_4_3_c", "zombie_dlc2_male_outfit_5_c", "zombie_dlc2_male_outfit_5_2_c", "zombie_dlc2_male_outfit_5_3_c", "zombie_dlc2_male_outfit_6_c", "zombie_dlc2_male_outfit_6_2_c", "zombie_dlc2_male_outfit_6_3_c", "zombie_dlc2_female_outfit_1", "zombie_dlc2_female_outfit_1_2", "zombie_dlc2_female_outfit_1_3", "zombie_dlc2_female_outfit_2", "zombie_dlc2_female_outfit_2_2", "zombie_dlc2_female_outfit_2_3", "zombie_dlc2_female_outfit_3", "zombie_dlc2_female_outfit_3_2", "zombie_dlc2_female_outfit_3_3", "zombie_dlc2_female_outfit_4", "zombie_dlc2_female_outfit_4_2", "zombie_dlc2_female_outfit_4_3", "zombie_dlc2_female_outfit_5", "zombie_dlc2_female_outfit_5_2", "zombie_dlc2_female_outfit_5_3", "zombie_dlc2_female_outfit_6", "zombie_dlc2_female_outfit_6_2", "zombie_dlc2_female_outfit_6_3", "zombie_dlc2_female_outfit_1_b", "zombie_dlc2_female_outfit_1_2_b", "zombie_dlc2_female_outfit_1_3_b", "zombie_dlc2_female_outfit_2_b", "zombie_dlc2_female_outfit_2_2_b", "zombie_dlc2_female_outfit_2_3_b", "zombie_dlc2_female_outfit_3_b", "zombie_dlc2_female_outfit_3_2_b", "zombie_dlc2_female_outfit_3_3_b", "zombie_dlc2_female_outfit_4_b", "zombie_dlc2_female_outfit_4_2_b", "zombie_dlc2_female_outfit_4_3_b", "zombie_dlc2_female_outfit_5_b", "zombie_dlc2_female_outfit_5_2_b", "zombie_dlc2_female_outfit_5_3_b", "zombie_dlc2_female_outfit_6_b", "zombie_dlc2_female_outfit_6_2_b", "zombie_dlc2_female_outfit_6_3_b", "zombie_dlc2_female_outfit_1_c", "zombie_dlc2_female_outfit_1_2_c", "zombie_dlc2_female_outfit_1_3_c", "zombie_dlc2_female_outfit_2_c", "zombie_dlc2_female_outfit_2_2_c", "zombie_dlc2_female_outfit_2_3_c", "zombie_dlc2_female_outfit_3_c", "zombie_dlc2_female_outfit_3_2_c", "zombie_dlc2_female_outfit_3_3_c", "zombie_dlc2_female_outfit_4_c", "zombie_dlc2_female_outfit_4_2_c", "zombie_dlc2_female_outfit_4_3_c", "zombie_dlc2_female_outfit_5_c", "zombie_dlc2_female_outfit_5_2_c", "zombie_dlc2_female_outfit_5_3_c", "zombie_dlc2_female_outfit_6_c", "zombie_dlc2_female_outfit_6_2_c", "zombie_dlc2_female_outfit_6_3_c"];
  level.karate_zombie_model_list = ["karatemaster_male_3_black", "karatemaster_male_3_brown", "karatemaster_male_3_white"];
}

power_manager() {
  level endon("game_ended");
  level.first_power_activated = undefined;
  level.power_on_counter = 0;
  for(;;) {
    level waittill("power_on_scriptable_and_light", var_0, var_1);
    level.power_on_counter++;
    var_2 = strtok(var_0, ",");
    foreach(var_4 in var_2) {
      if(var_4 == "alley_west") {
        playsoundatpos((-1933, 1233, 1172), "power_buy_powerup_lr");
      }

      switch (var_4) {}
    }

    if(!scripts\engine\utility::istrue(level.first_power_activated) && level.power_on_counter == 1) {
      if(isDefined(level.disco_power_vo_func)) {
        thread[[level.disco_power_vo_func]](var_1, 1);
      }

      level.first_power_activated = 1;
      continue;
    }

    if(level.power_on_counter == 4) {
      if(isDefined(level.disco_power_vo_func)) {
        thread[[level.disco_power_vo_func]](var_1, 0);
      }
    }
  }
}

disco_power_on_vo(var_0, var_1) {
  level endon("gamed_ended");
  var_0 endon("death");
  var_0 endon("disconnect");
  if(scripts\engine\utility::flag_exist("canFiresale")) {
    scripts\engine\utility::flag_set("canFiresale");
  }

  if(scripts\engine\utility::istrue(var_1)) {
    switch (var_0.vo_prefix) {
      case "p1_":
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("sally_power_first_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        level.completed_dialogues["sally_power_first_1"] = 1;
        break;

      case "p4_":
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("aj_power_first_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        level.completed_dialogues["aj_power_first_1"] = 1;
        break;

      case "p3_":
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("andre_power_first_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        level.completed_dialogues["andre_power_first_1"] = 1;
        break;

      case "p2_":
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pdex_power_first_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        level.completed_dialogues["pdex_power_first_1"] = 1;
        break;

      default:
        break;
    }

    return;
  }

  if(level.power_on_counter == 4) {
    switch (var_0.vo_prefix) {
      case "p1_":
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("sally_power_final_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        level.completed_dialogues["sally_power_final_1"] = 1;
        break;

      case "p4_":
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("aj_power_final_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        level.completed_dialogues["aj_power_final_1"] = 1;
        break;

      case "p3_":
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("andre_power_final_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        level.completed_dialogues["andre_power_final_1"] = 1;
        break;

      case "p2_":
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("pdex_power_final_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        level.completed_dialogues["pdex_power_final_1"] = 1;
        break;

      default:
        break;
    }

    scripts\cp\cp_vo::remove_from_nag_vo("nag_activate_power", 1);
  }
}

pickup_reel(var_0, var_1) {
  var_1 playlocalsound("pap_quest_film_reel_pickup");
  playFX(level._effect["crafting_pickup"], var_0.randomintrange.origin);
  var_0.randomintrange delete();
  level.peepshow_reel_found = 1;
  scripts\cp\cp_interaction::add_to_current_interaction_list(level.booth_projector_struct);
  level.interactions["add_reel"].disable_guided_interactions = undefined;
  level scripts\cp\utility::set_quest_icon(12);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

add_reel(var_0, var_1) {
  if(!isDefined(level.peepshow_reel_found)) {
    var_1 playlocalsound("perk_machine_deny");
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1 playlocalsound("pap_quest_film_reel_placement");
  level.booth_projector setModel("cp_rave_projector_with_reels");
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("pap_quest_success", "disco_comment_vo", "low", 10, 0, 2, 0, 40);
  var_1.found_pap = 1;
  level thread activate_pap(var_1);
  level scripts\cp\utility::set_completed_quest_mark(3);
}

enter_pap_stall(var_0, var_1) {
  if(!isDefined(level.peepshow_token_found)) {
    var_1 playlocalsound("perk_machine_deny");
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area_misc", "rave_comment_vo");
  var_2 = getEntArray(var_0.target, "targetname");
  foreach(var_4 in var_2) {
    if(isDefined(var_4.spawnimpulsefield) && var_4.spawnimpulsefield == 1) {
      var_4 connectpaths();
      var_4 notsolid();
      continue;
    }

    if(isDefined(var_4.model) && var_4.model == "p7_door_wood_global_01_deco") {
      var_4 rotateyaw(150, 0.5);
      var_4 playSound("pap_quest_wooden_door");
    }
  }
}

enter_peepshow(var_0, var_1) {
  if(!isDefined(level.peepshow_flyer_found)) {
    var_1 playlocalsound("perk_machine_deny");
    return;
  }

  foreach(var_3 in level.peepshow_entrances) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
  }

  var_1 thread scripts\cp\cp_vo::try_to_play_vo("pap_quest_insert_coin", "disco_comment_vo", "low", 10, 0, 2, 0, 40);
  foreach(var_3 in level.peepshow_entrances) {
    var_6 = getEntArray(var_3.target, "targetname");
    foreach(var_8 in var_6) {
      if(isDefined(var_8.spawnimpulsefield) && var_8.spawnimpulsefield == 1) {
        var_8 connectpaths();
        var_8 notsolid();
        continue;
      }

      var_8 rotateto(var_8.script_angles, 0.75);
      var_8 playSound("pap_quest_peep_show_door");
    }
  }

  var_0B = scripts\cp\zombies\zombies_spawning::create_spawner("disco_street", (-1657, 5495, 774), (0, 270, 0), "ground_spawn_no_boards", "spawn_ground", "concrete");
  var_0C = scripts\cp\zombies\zombies_spawning::create_spawner("disco_street", (-1212.5, 5298.5, 774), (0, 180, 0), "ground_spawn_no_boards", "spawn_ground", "concrete");
  var_0B scripts\cp\zombies\zombies_spawning::make_spawner_active();
  var_0C scripts\cp\zombies\zombies_spawning::make_spawner_active();
}

take_peepshow_flyer(var_0, var_1) {
  var_1 playlocalsound("pap_quest_flyer_pickup");
  playFX(level._effect["crafting_pickup"], var_0.randomintrange.origin);
  var_0.randomintrange delete();
  level.peepshow_flyer_found = 1;
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("pap_quest_collect_ticket", "disco_comment_vo", "low", 10, 0, 2, 0, 40);
  level scripts\cp\utility::set_quest_icon(11);
  level.peepshow_entrances = scripts\engine\utility::getstructarray("enter_peepshow", "script_noteworthy");
  foreach(var_3 in level.peepshow_entrances) {
    var_3.script_noteworthy = "enter_peepshow_allowed";
  }
}

init_peepshow_flyer() {
  var_0 = scripts\engine\utility::getstructarray("peepshow_flyer", "script_noteworthy");
  var_1 = scripts\engine\utility::random(var_0);
  var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  var_1.randomintrange = spawn("script_model", var_2.origin);
  if(isDefined(var_2.angles)) {
    var_1.randomintrange.angles = var_2.angles;
  }

  var_1.randomintrange setModel("cp_disco_peepshow_flyer_01");
  foreach(var_4 in var_0) {
    if(var_4 == var_1) {
      continue;
    } else {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_4);
    }
  }

  level.interactions["peepshow_flyer"].disable_guided_interactions = 1;
}

init_projector() {
  level.booth_projector = getent("booth_projector", "targetname");
  level.booth_projector_struct = scripts\engine\utility::getstruct("add_reel", "script_noteworthy");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.booth_projector_struct);
  level.interactions["add_reel"].disable_guided_interactions = 1;
  level.interactions["pickup_reel"].disable_guided_interactions = 1;
  var_0 = scripts\engine\utility::getstructarray("pickup_reel", "script_noteworthy");
  var_1 = scripts\engine\utility::random(var_0);
  var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  var_1.randomintrange = spawn("script_model", var_2.origin);
  var_1.randomintrange setModel("cp_disco_film_reel_case");
  if(isDefined(var_2.angles)) {
    var_1.randomintrange.angles = var_2.angles;
  }

  foreach(var_4 in var_0) {
    if(var_4 == var_1) {
      continue;
    } else {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_4);
    }
  }

  level.pap_fusebox_switch = scripts\engine\utility::getstruct("pap_fuse_switch", "script_noteworthy");
  level.pap_fuses_interaction = scripts\engine\utility::getstruct("pap_fusebox", "script_noteworthy");
  level.interactions["pap_fuse_switch"].disable_guided_interactions = 1;
  level.interactions["pap_fusebox"].disable_guided_interactions = 1;
}

use_pap_upgrade_switch(var_0, var_1) {
  level endon("fuses_pickedup");
  var_2 = getent(var_0.target, "targetname");
  var_2 setModel("mp_frag_button_on_green");
  playsoundatpos(var_2.origin, "disco_pap_room_button_press");
  var_3 = getent("pap_fusebox", "targetname");
  var_3 rotateyaw(-110, 1);
  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    playsoundatpos(var_3.origin, "disco_pap_fuse_box_open");
  }

  level.pap_upgrade_fuses_available = 1;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.pap_fusebox_switch);
  wait(25);
  scripts\cp\cp_interaction::add_to_current_interaction_list(level.pap_fusebox_switch);
  level.pap_upgrade_fuses_available = undefined;
  var_3 rotateyaw(110, 1);
  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    playsoundatpos(var_3.origin, "disco_pap_fuse_box_close");
  }

  var_2 setModel("mp_frag_button_on");
}

take_fuses(var_0, var_1) {
  if(!scripts\engine\utility::istrue(level.pap_upgrade_fuses_available)) {
    return;
  }

  var_2 = getEntArray("pap_fuses", "targetname");
  foreach(var_4 in var_2) {
    playFX(level._effect["crafting_pickup"], var_4.origin);
    var_4 delete();
  }

  var_1 playlocalsound("zmb_item_pickup");
  level.pap_fuses_found = 1;
  level notify("fuses_pickedup");
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("pap_collect_fuse", "zmb_comment_vo", "low", 10, 0, 0, 1, 100);
  foreach(var_7 in level.players) {
    var_7 setclientomnvar("zm_special_item", 5);
  }

  level thread set_fuse_icon_on_hotjoin(5);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

set_fuse_icon_on_hotjoin(var_0) {
  level notify("stop_hotjoin_fuse");
  level endon("stop_hotjoin_fuse");
  for(;;) {
    level waittill("connected", var_1);
    var_1 setclientomnvar("zm_special_item", var_0);
  }
}

init_placed_fuse() {
  var_0 = getEntArray("place_fuse", "targetname");
  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2.target, "targetname");
    foreach(var_5 in var_3) {
      var_5 hide();
    }

    var_2 thread place_pap_fuse();
  }
}

place_pap_fuse() {
  level endon("charged_fuses_pickedup");
  for(;;) {
    self waittill("trigger", var_0);
    if(!var_0 scripts\cp\utility::is_valid_player(1)) {
      continue;
    }

    if(!var_0 usebuttonpressed()) {
      continue;
    }

    if((scripts\engine\utility::istrue(level.pap_fuses_placed) || !scripts\engine\utility::istrue(level.pap_fuses_found)) && !scripts\engine\utility::istrue(level.pap_fuses_upgraded)) {
      var_0 playlocalsound("perk_machine_deny");
      while(var_0 scripts\cp\utility::is_valid_player(1) && var_0 usebuttonpressed()) {
        wait(0.05);
      }

      continue;
    }

    var_1 = getEntArray(self.target, "targetname");
    if(scripts\engine\utility::istrue(level.pap_fuses_upgraded)) {
      playFX(level._effect["crafting_pickup"], var_1[0].origin);
      foreach(var_3 in var_1) {
        var_3 hide();
      }

      var_0 playlocalsound("zmb_item_pickup");
      level.upgraded_fuses_pickedup = 1;
      level.has_picked_up_fuses = 1;
      foreach(var_6 in level.players) {
        var_6 setclientomnvar("zm_special_item", 1);
      }

      level thread set_fuse_icon_on_hotjoin(1);
      level notify("charged_fuses_pickedup");
      return;
    }

    foreach(var_0B in var_0A) {
      var_0B show();
      var_0B.waiting_for_charge = 1;
    }

    playFX(level._effect["crafting_pickup"], var_0A[0].origin);
    var_9 playlocalsound("zmb_item_pickup");
    foreach(var_5 in level.players) {
      var_5 setclientomnvar("zm_special_item", 0);
    }

    level thread set_fuse_icon_on_hotjoin(0);
    var_9 thread scripts\cp\cp_vo::try_to_play_vo("pap_place_fuse", "zmb_comment_vo", "low", 10, 0, 0, 1, 100);
    level.active_fuse_trigger = self;
    level.pap_fuses_placed = 1;
    wait(2);
  }
}

upgrade_fuses() {
  if(scripts\engine\utility::istrue(level.upgrading_pap_fuses)) {
    return;
  }

  level.upgrading_pap_fuses = 1;
  var_0 = getEntArray(level.active_fuse_trigger.target, "targetname");
  foreach(var_2 in var_0) {
    var_2 setModel("park_alien_gray_fuse");
    wait(0.1);
    playFXOnTag(level._effect["fuse_charged"], var_2, "tag_origin");
  }

  level.pap_fuses_upgraded = 1;
  foreach(var_5 in level.players) {
    var_5 thread scripts\cp\cp_vo::try_to_play_vo("pap_charge_fuse", "disco_comment_vo", "low", 10, 0, 0, 1, 100);
  }
}

guidedinteractionsexclusions(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(level.interactions[var_0.script_noteworthy].disable_guided_interactions)) {
    return 0;
  }

  if(!isDefined(var_0.script_noteworthy) || var_0.script_noteworthy == "puzzle") {
    return 0;
  }

  if(isDefined(var_2)) {
    switch (var_2) {
      default:
        break;
    }
  }

  if(scripts\cp\cp_interaction::interactionislostandfound(var_0) && !scripts\engine\utility::istrue(var_1.have_things_in_lost_and_found)) {
    return 0;
  }

  if(isDefined(var_0.script_noteworthy)) {
    switch (var_0.script_noteworthy) {
      case "chi_2":
      case "chi_1":
      case "chi_0":
        return 0;

      default:
        break;
    }
  }

  if(isDefined(var_0.groupname) && var_0.groupname == "challenge") {
    return 0;
  }

  if(isDefined(var_0.script_label)) {
    if(!scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
      return 0;
    }
  }

  return 1;
}

guidedinteractionoffsetfunc(var_0, var_1) {
  var_2 = (0, 0, 68);
  var_3 = scripts\cp\cp_interaction::get_area_for_power(var_0);
  if(isDefined(var_0.script_noteworthy)) {
    var_4 = var_0.script_noteworthy;
    switch (var_4) {
      case "martial_arts_trainer":
        var_2 = (0, 0, 24);
        break;

      case "iw7_kbs_zm":
        if(isDefined(var_3) && var_3 == "disco_roof") {
          var_2 = (0, 0, 16);
        }
        break;

      case "iw7_rvn_zm":
        if(isDefined(var_3) && var_3 == "alley_west") {
          var_2 = (0, 0, 48);
        }
        break;

      case "iw7_erad_zm":
        if(isDefined(var_3) && var_3 == "disco_subway") {
          var_2 = (0, 0, 40);
        } else if(isDefined(var_3) && var_3 == "rooftops_1") {
          var_2 = (0, 0, 72);
        }
        break;

      case "iw7_fmg_zm":
        if(isDefined(var_3) && var_3 == "disco_bottom") {
          var_2 = (0, 0, 48);
        }
        break;

      case "iw7_ake_zml":
        if(isDefined(var_3) && var_3 == "alley_west") {
          var_2 = (0, 0, 40);
        }
        break;

      case "iw7_ripper_zmr":
        if(isDefined(var_3) && var_3 == "rooftops_1") {
          var_2 = (0, 0, 40);
        } else if(isDefined(var_3) && var_3 == "disco_street") {
          var_2 = (0, 0, 48);
        }
        break;

      case "iw7_sonic_zmr":
        if(isDefined(var_3) && var_3 == "punk_subway") {
          var_2 = (0, 0, 32);
        }
        break;

      case "iw7_devastator_zm":
        if(isDefined(var_3) && var_3 == "alley_east") {
          var_2 = (0, 0, 40);
        }
        break;

      case "iw7_crb_zml":
        if(isDefined(var_3) && var_3 == "alley_east") {
          var_2 = (0, 0, 24);
        }
        break;

      case "trap_hydrant":
        var_2 = (0, 0, 30);
        break;

      default:
        var_2 = (0, 0, 56);
        break;
    }
  }

  return var_2;
}

discohostmigrationfunc() {
  if(scripts\engine\utility::istrue(level.ratking_playlist)) {
    level notify("stop_punk_and_disco_club_music_emitters");
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
    return;
  }

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

setup_pa_speakers() {
  level.jukebox_table = "cp\zombies\cp_disco_music_genre.csv";
  scripts\cp\zombies\zombie_jukebox::parse_music_genre_table();
  wait(1.15);
  disablepaspeaker("pa_punk_street");
  disablepaspeaker("pa_punk_bus");
  disablepaspeaker("pa_punk_alley_1");
  disablepaspeaker("pa_punk_subway_1");
  disablepaspeaker("pa_punk_subway_2");
  disablepaspeaker("pa_punk_rooftops_1");
  disablepaspeaker("pa_punk_rooftops_2");
  disablepaspeaker("pa_punk_rooftops_3");
  disablepaspeaker("pa_disco_street_1");
  disablepaspeaker("pa_disco_street_2");
  disablepaspeaker("pa_disco_street_3");
  disablepaspeaker("pa_disco_subway_2");
  disablepaspeaker("pa_disco_subway_1");
  disablepaspeaker("pa_park_1");
  disablepaspeaker("pa_park_2");
  disablepaspeaker("pa_disco_club");
  disablepaspeaker("pa_punk_club");
  disablepaspeaker("pa_rk_arena");
}

enablestreetpas() {
  enablepaspeaker("pa_punk_rooftops_1");
  enablepaspeaker("pa_punk_bus");
  enablepaspeaker("pa_punk_street");
  enablepaspeaker("pa_disco_street_2");
  enablepaspeaker("pa_park_2");
  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start((1785, -2077, 211));
  wait(5);
  level notify("jukebox_start");
}

setup_club_jukebox(var_0, var_1) {
  for(;;) {
    var_2 = (-284, 1186, 850);
    var_3 = spawn("script_origin", var_2);
    var_3 playLoopSound(var_1);
    var_4 = lookupsoundlength(var_1) / 1000;
    level scripts\engine\utility::waittill_any_timeout_1(var_4, "skip_song");
    var_3 stoploopsound();
  }
}

start_mosh_trap_music() {
  if(isDefined(level.rat_king)) {
    return;
  }

  if(isDefined(level.punk_club_music_default)) {
    level.punk_club_music_default stoploopsound();
    level.punk_club_music_default delete();
  }

  level.mosh_pit_music = 1;
  playsoundatpos((-317, 1034, 827), "trap_mosh_feedback");
  wait(1.1);
  scripts\engine\utility::play_sound_in_space("mus_disco_mosh_pit_trap", (-317, 1034, 827));
  wait(28);
  level.mosh_pit_music = undefined;
  if(!isDefined(level.rat_king)) {
    level.punk_club_music_default = scripts\engine\utility::play_loopsound_in_space("mus_emt_punk_club_mix", (-61, 1019, 831.996));
  }
}

start_punk_and_disco_club_music() {
  level.punk_club_music_default = scripts\engine\utility::play_loopsound_in_space("mus_emt_punk_club_mix", (-61, 1019, 831.996));
  level.disco_club_music_default = scripts\engine\utility::play_loopsound_in_space("mus_emt_disco_club_mix", (-1463.89, 3008.37, 849.802));
  level waittill("stop_punk_and_disco_club_music_emitters");
  level.disco_club_music_default stoploopsound();
  level.disco_club_music_default delete();
  if(isDefined(level.punk_club_music_default)) {
    level.punk_club_music_default stoploopsound();
    level.punk_club_music_default delete();
  }
}

enableratkingpas() {
  wait(1.5);
  foreach(var_1 in level.players) {
    var_1 playlocalsound("rk_record_scratch_static");
  }

  level notify("force_new_song");
  level notify("stop_punk_and_disco_club_music_emitters");
  wait(3.5);
  level.ratking_playlist = 1;
  level.jukebox_table_old = level.jukebox_table;
  level.jukebox_table = "cp\zombies\cp_disco_music_genre_ratking.csv";
  scripts\cp\zombies\zombie_jukebox::parse_music_genre_table();
  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start((1785, -2077, 211), undefined, 0);
  wait(0.5);
  level notify("jukebox_start");
  enablepaspeaker("pa_disco_club");
  enablepaspeaker("pa_rk_arena");
  level thread disableratkingpas();
  while(isDefined(level.mosh_pit_music)) {
    wait(0.05);
  }

  if(isDefined(level.rat_king)) {
    enablepaspeaker("pa_punk_club");
  }
}

disableratkingpas() {
  level waittill("rat_king_killed");
  disablepaspeaker("pa_disco_club");
  disablepaspeaker("pa_punk_club");
  disablepaspeaker("pa_rk_arena");
  level notify("force_new_song");
  level.jukebox_table = level.jukebox_table_old;
  level.ratking_playlist = undefined;
  scripts\cp\zombies\zombie_jukebox::parse_music_genre_table();
  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start((1785, -2077, 211));
  level notify("jukebox_start");
  level thread start_punk_and_disco_club_music();
}

get_info_for_player_powers(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in getarraykeys(var_0.powers)) {
    if(isDefined(var_1) && var_1 != var_0.powers[var_4].slot) {
      continue;
    }

    var_5 = spawnStruct();
    var_5.slot = var_0.powers[var_4].slot;
    var_5.charges = var_0.powers[var_4].charges;
    var_2[var_4] = var_5;
  }

  return var_2;
}

restore_powers(var_0, var_1) {
  foreach(var_3 in getarraykeys(var_0.powers)) {
    scripts\cp\powers\coop_powers::removepower(var_3);
  }

  foreach(var_3, var_6 in var_1) {
    if(var_6.slot == "secondary") {
      var_0 scripts\cp\powers\coop_powers::givepower(var_3, var_6.slot, undefined, undefined, undefined, undefined, 0);
      var_0 scripts\cp\powers\coop_powers::power_adjustcharges(var_6.charges, var_6.slot, 1);
      continue;
    }

    var_0 scripts\cp\powers\coop_powers::givepower(var_3, var_6.slot, undefined, undefined, undefined, undefined, 1);
    var_0 scripts\cp\powers\coop_powers::power_adjustcharges(var_6.charges, var_6.slot, 1);
  }
}

clean_up_kung_fu_mode_on_last_stand(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("kung_fu_style_timeout");
  var_0 scripts\engine\utility::waittill_either("last_stand", "death");
  scripts\cp\maps\cp_disco\kung_fu_mode::unset_kung_fu_mode(var_0, var_1);
}

disco_last_stand_handler(var_0) {
  if(scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
    var_0.pre_kung_fu_weapon = scripts\cp\utility::getvalidtakeweapon();
    scripts\cp\maps\cp_disco\kung_fu_mode::unset_kung_fu_mode(var_0, var_0.pre_kung_fu_weapon);
    var_0.pre_laststand_powers = var_0 scripts\cp\powers\coop_powers::get_info_for_player_powers(var_0);
  } else if(isDefined(self.pre_laststand_powers)) {
    foreach(var_2 in level.kung_fu_upgrades) {
      if(isDefined(var_2.rb)) {
        var_3 = var_2.rb;
        if(isDefined(self.pre_laststand_powers[var_3])) {
          self.pre_laststand_powers = scripts\engine\utility::array_remove(self.pre_laststand_powers, self.pre_laststand_powers[var_3]);
        }
      }

      if(isDefined(var_2.lb)) {
        var_3 = var_2.lb;
        if(isDefined(self.pre_laststand_powers[var_3])) {
          self.pre_laststand_powers = scripts\engine\utility::array_remove(self.pre_laststand_powers, self.pre_laststand_powers[var_3]);
        }
      }
    }
  }

  if(var_0 scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if(!scripts\engine\utility::istrue(var_0.have_self_revive)) {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("laststand", "zmb_comment_vo");
      return;
    }

    if(isDefined(var_0.times_self_revived)) {
      if(var_0.times_self_revived > 3) {
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("laststand", "zmb_comment_vo");
        return;
      }

      return;
    }
  }
}

disco_grenade_pullback_func(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  switch (var_1) {
    default:
      break;
  }
}

unset_grenade_scriptable_state(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("faux_spawn");
  var_0 scripts\engine\utility::waittill_either("offhand_end", "grenade_fire");
  var_0 setscriptablepartstate("fireball", "neutral");
}

respawn_loc_func(var_0) {
  foreach(var_2 in level.active_player_respawn_locs) {
    if(!canspawn(var_2.origin)) {
      continue;
    }

    if(positionwouldtelefrag(var_2.origin)) {
      continue;
    }

    return var_2;
  }

  var_4 = scripts\cp\gametypes\zombie::get_available_players(var_0);
  return scripts\cp\gametypes\zombie::get_respawn_loc_near_team_center(var_0, var_4);
}

wait_for_pam_revive(var_0, var_1) {
  level endon("hoff_death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("revive_success");
  var_0 endon("death");
  var_2 = var_0.reviveent scripts\engine\utility::waittill_any_timeout_1(var_1, "pg_trigger");
  if(!isDefined(var_2) || var_2 != "pg_trigger") {
    return undefined;
  }

  return 1;
}

wait_to_be_revived_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  if(scripts\engine\utility::istrue(level.the_hoff_revive)) {
    if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
      if(scripts\engine\utility::istrue(var_0B)) {
        wait(5);
        scripts\cp\cp_laststand::clear_last_stand_timer(var_0);
        self notify("revive_success");
        return 1;
      }

      var_0C = watchforpamrevive(var_0, var_7);
      if(scripts\engine\utility::istrue(var_0C)) {
        return 1;
      }

      scripts\cp\cp_laststand::clear_last_stand_timer(var_0);
      level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
      level waittill("forever");
      return 0;
    }

    thread threadedpamrevivewatch(var_0, var_5);
    return;
  }

  return undefined;
}

threadedpamrevivewatch(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("revive_success");
  var_2 = wait_for_pam_revive(var_0, var_1);
  if(scripts\engine\utility::istrue(var_2)) {
    scripts\cp\cp_laststand::clear_last_stand_timer(var_0);
    self notify("revive_success");
    return 1;
  }
}

watchforreviveduringpamrevive() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stop_watchForReviveDuringPamRevive");
  self waittill("revive_success");
  self.brevivedbeforepamcoulddoit = 1;
}

watchforpamrevive(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("abort_debugendon");
  var_0 notify("abort_debugendon");
  var_0 thread watchforreviveduringpamrevive();
  var_2 = wait_for_pam_revive(var_0, var_1);
  scripts\engine\utility::waitframe();
  var_0 notify("stop_watchForReviveDuringPamRevive");
  if(scripts\engine\utility::istrue(var_2)) {
    scripts\cp\cp_laststand::clear_last_stand_timer(var_0);
    self notify("revive_success");
    return 1;
  }

  if(scripts\engine\utility::istrue(self.brevivedbeforepamcoulddoit)) {
    self.brevivedbeforepamcoulddoit = undefined;
    return 1;
  }

  return undefined;
}

play_char_intro_music() {
  if(self issplitscreenplayer() && !self issplitscreenplayerprimary()) {
    return;
  }

  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    return;
  }

  self playlocalsound(self.intro_music);
}

activate_pap(var_0) {
  var_1 = level._effect["vfx_pap_portal"];
  var_2 = scripts\engine\utility::getstruct("portal_effect_location", "targetname");
  var_2.origin = var_2.origin + (0, -24, 0);
  var_2.angles = (0, 90, 0);
  var_3 = spawnStruct();
  var_3.origin = (-1918.4, 5430.5, 791);
  var_3.script_noteworthy = "pap_portal";
  var_3.portal_can_be_started = 1;
  var_3.requires_power = 0;
  var_3.powered_on = 1;
  var_3.script_parameters = "default";
  var_3.custom_search_dist = 96;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_3);
  level thread turn_on_room_exit_portal();
  var_4 = scripts\engine\utility::getstruct("projector_fx_struct", "targetname");
  var_5 = spawnfx(level._effect["projector_light"], var_4.origin, anglesToForward(var_4.angles), anglestoup(var_4.angles));
  var_3.portal = spawn("script_model", var_2.origin);
  var_3.portal.angles = var_2.angles;
  var_3.portal setModel("tag_origin_crafting");
  wait(0.5);
  triggerfx(var_5);
  scripts\engine\utility::delaythread(0.05, ::scripts\engine\utility::play_loopsound_in_space, "zmb_packapunch_machine_idle_lp", var_4.origin);
  wait(0.5);
  var_3.portal setscriptablepartstate("portal", "on");
  foreach(var_7 in level.players) {
    var_7 thread scripts\cp\cp_vo::add_to_nag_vo("nag_find_pap", "disco_comment_vo", 120, 120, 4, 1);
  }

  if(!isDefined(var_0) || !var_0 scripts\cp\utility::is_valid_player()) {
    return;
  }

  switch (var_0.vo_prefix) {
    case "p1_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("sally_pap_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["sally_pap_1"] = 1;
      break;

    case "p4_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("aj_pap_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["aj_pap_1"] = 1;
      break;

    case "p3_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("andre_pap_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["andre_pap_1"] = 1;
      break;

    case "p2_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("pdex_pap_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["pdex_pap_1"] = 1;
      break;

    default:
      break;
  }
}

turn_on_room_exit_portal() {
  var_0 = getent("hidden_room_portal", "targetname");
  var_1 = anglesToForward(var_0.angles);
  var_2 = spawnfx(level._effect["vfx_pap_return_portal"], var_0.origin, var_1);
  thread scripts\engine\utility::play_loopsound_in_space("zmb_portal_powered_on_activate_lp", var_0.origin);
  triggerfx(var_2);
  teleport_from_hidden_room_before_time_up(var_0);
}

teleport_from_hidden_room_before_time_up(var_0) {
  var_0 makeusable();
  var_0 sethintstring(&"CP_DISCO_INTERACTIONS_LEAVE_PAP");
  var_0.portal_is_open = 1;
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isDefined(var_1.kicked_out)) {
      var_1 notify("left_hidden_room_early");
      var_1.disable_consumables = 1;
      hidden_room_exit_tube(var_1);
    }

    wait(0.1);
  }
}

pap_portal_hint_logic(var_0, var_1) {
  if(scripts\engine\utility::flag("disable_portals")) {
    return "";
  }

  if(isDefined(var_0.cooling_down)) {
    return &"COOP_INTERACTIONS_COOLDOWN";
  }

  return &"CP_DISCO_INTERACTIONS_ACCESS_PAP";
}

pap_portal_use_func(var_0, var_1) {
  if(scripts\engine\utility::flag("disable_portals")) {
    return;
  }

  if(isDefined(level.clock_interaction) && isDefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_1) {
    return;
  }

  if(isDefined(level.clock_interaction_q2) && isDefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_1) {
    return;
  }

  if(isDefined(level.clock_interaction_q3) && isDefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_1) {
    return;
  }

  if(!var_1 scripts\cp\utility::isteleportenabled()) {
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  var_1 thread disable_teleportation(var_1, 0.5, "fast_travel_complete");
  var_0 thread travel_through_hidden_tube(var_1);
  var_0 thread pap_portal_cooldown(var_0);
}

pap_portal_cooldown(var_0) {
  if(scripts\engine\utility::istrue(var_0.in_cool_down)) {
    return;
  }

  var_0.in_cool_down = 1;
  wait(31);
  var_0.portal setscriptablepartstate("portal", "cooldown");
  var_0.cooling_down = 1;
  wait(60);
  var_0.in_cool_down = undefined;
  var_0.cooling_down = undefined;
  var_0.portal setscriptablepartstate("portal", "on");
}

travel_through_hidden_tube(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 scripts\cp\powers\coop_powers::power_disablepower();
  var_0 notify("delete_equipment");
  var_0.disable_consumables = 1;
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_1 = move_through_tube(var_0, "hidden_travel_tube_start", "hidden_travel_tube_end");
  var_0 teleport_to_hidden_room();
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_1 delete();
}

teleport_to_hidden_room() {
  self endon("left_hidden_room_early");
  if(!scripts\engine\utility::istrue(self.is_in_pap)) {
    thread scripts\cp\cp_vo::try_to_play_vo("pap_room_first", "zmb_pap_vo");
  }

  set_in_pap_room(self, 1);
  scripts\cp\utility::adddamagemodifier("papRoom", 0, 0);
  self.is_off_grid = 1;
  self.disable_consumables = undefined;
  var_0 = scripts\engine\utility::getstruct("hidden_room_spot", "targetname");
  self unlink();
  self dontinterpolate();
  scripts\cp\powers\coop_powers::power_enablepower();
  self setorigin(var_0.origin);
  self setplayerangles(var_0.angles);
  self playershow();
  thread hidden_room_timer();
  level notify("hidden_room_portal_used");
}

pap_timer_start() {
  self endon("disconnect");
  if(!isDefined(self.pap_timer_running)) {
    self.pap_timer_running = 1;
    var_0 = 30;
    self setclientomnvar("zombie_papTimer", var_0);
    wait(1);
    for(;;) {
      var_0--;
      if(var_0 < 0) {
        var_0 = 30;
        wait(1);
        break;
      }

      self setclientomnvar("zombie_papTimer", var_0);
      wait(1);
    }

    self setclientomnvar("zombie_papTimer", -1);
    self notify("kicked_out");
    wait(30);
    self.pap_timer_running = undefined;
  }
}

hidden_room_exit_tube(var_0) {
  var_0 endon("disconnect");
  var_0 getrigindexfromarchetyperef();
  var_0 notify("delete_equipment");
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_1 = move_through_tube(var_0, "hidden_travel_tube_end", "hidden_travel_tube_start", 1);
  teleport_to_safe_spot(var_0);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_1 delete();
  if(scripts\engine\utility::istrue(var_0.wor_phase_shift)) {
    var_0 scripts\cp\powers\coop_phaseshift::exitphaseshift(1);
    var_0.wor_phase_shift = 0;
  }

  var_0 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  var_0.is_off_grid = undefined;
  var_0.kicked_out = undefined;
  var_0 set_in_pap_room(var_0, 0);
  var_0 notify("fast_travel_complete");
  scripts\cp\cp_vo::remove_from_nag_vo("ww_pap_nag");
  scripts\cp\cp_vo::remove_from_nag_vo("nag_find_pap");
}

set_in_pap_room(var_0, var_1) {
  var_0.is_in_pap = var_1;
}

teleport_to_safe_spot(var_0) {
  var_1 = scripts\engine\utility::getstructarray("pap_exit_spots", "targetname");
  var_2 = undefined;
  while(!isDefined(var_2)) {
    foreach(var_4 in var_1) {
      if(!positionwouldtelefrag(var_4.origin)) {
        var_2 = var_4;
      }
    }

    if(!isDefined(var_2)) {
      var_6 = scripts\cp\utility::vec_multiply(anglesToForward(var_1[0].angles, 64));
      var_2 = var_1[0].origin + var_6;
    }

    wait(0.1);
  }

  var_0 playershow();
  var_0 unlink();
  var_0 dontinterpolate();
  var_0 setorigin(var_2.origin);
  var_0 setplayerangles(var_2.angles);
  var_0.disable_consumables = undefined;
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
}

hidden_room_timer() {
  self endon("left_hidden_room_early");
  self endon("disconnect");
  self endon("last_stand");
  self.kicked_out = undefined;
  if(!scripts\engine\utility::flag("pap_portal_used")) {
    scripts\engine\utility::flag_set("pap_portal_used");
  }

  thread pap_timer_start();
  level thread pap_vo(self);
  self waittill("kicked_out");
  self.kicked_out = 1;
  level thread hidden_room_exit_tube(self);
}

pap_vo(var_0) {
  var_0 endon("disconnect");
  if(level.pap_firsttime != 1) {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("pap_room_first", "rave_pap_vo");
  }

  level.pap_firsttime = 1;
  wait(4);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("ww_pap_nag", "rave_pap_vo", "high", undefined, undefined, undefined, 1);
}

move_through_tube(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("move_through_tube");
  var_0 earthquakeforplayer(0.3, 0.2, var_0.origin, 200);
  var_4 = getent(var_1, "targetname");
  var_5 = getent(var_2, "targetname");
  var_0 cancelmantle();
  var_0.no_outline = 1;
  var_0.no_team_outlines = 1;
  var_6 = var_4.origin + (0, 0, -45);
  var_7 = var_5.origin + (0, 0, -45);
  var_0.is_fast_traveling = 1;
  var_0 scripts\cp\utility::adddamagemodifier("fast_travel", 0, 0);
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 dontinterpolate();
  var_0 setorigin(var_6);
  var_0 setplayerangles(var_4.angles);
  var_0 playlocalsound("zmb_portal_travel_lr");
  var_8 = spawn("script_origin", var_6);
  var_0 playerlinkto(var_8);
  var_0 getweaponrankxpmultiplier();
  wait(0.1);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  var_8 moveto(var_7, 1);
  wait(1);
  var_0.is_fast_traveling = undefined;
  var_0 scripts\cp\utility::removedamagemodifier("fast_travel", 0);
  if(var_0 scripts\cp\utility::isignoremeenabled()) {
    var_0 scripts\cp\utility::allow_player_ignore_me(0);
  }

  var_0.is_fast_traveling = undefined;
  var_0.no_outline = 0;
  var_0.no_team_outlines = 0;
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  return var_8;
}

disable_teleportation(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 scripts\cp\utility::allow_player_teleport(0);
  var_0 waittill(var_2);
  wait(var_1);
  if(!var_0 scripts\cp\utility::isteleportenabled()) {
    var_0 scripts\cp\utility::allow_player_teleport(1);
  }

  var_0 notify("can_teleport");
}

subway_trains() {
  var_0 = spawn("script_model", (-2794, -3203, 191));
  var_0.angles = (0, 0, 0);
  scripts\engine\utility::waitframe();
  var_1 = spawn("script_model", (-2794, -3975, 191));
  var_1.angles = (0, 180, 0);
  scripts\engine\utility::waitframe();
  var_2 = spawn("script_model", (-2794, -4747, 191));
  var_2.angles = (0, 0, 0);
  scripts\engine\utility::waitframe();
  var_0 setModel("cp_disco_subway_train_bsp2xmodel");
  var_3 = spawn("script_model", var_0.origin);
  var_1 setModel("cp_disco_subway_train_bsp2xmodel");
  var_4 = spawn("script_model", var_1.origin);
  var_2 setModel("cp_disco_subway_train_bsp2xmodel");
  var_5 = spawn("script_model", var_2.origin);
  scripts\engine\utility::waitframe();
  var_1 linkto(var_0);
  var_2 linkto(var_1);
  level waittill("disco_subway power_on");
  var_3 linkto(var_0, "tag_origin", (0, 420, 100), (0, 0, 0));
  var_4 linkto(var_1, "tag_origin", (-91, 0, 180), (0, 0, 0));
  var_5 linkto(var_2, "tag_origin", (0, -420, 100), (0, 0, 0));
  var_6 = getEntArray("subway_power_gates_front", "targetname");
  var_7 = getEntArray("subway_power_gates_rear", "targetname");
  foreach(var_9 in var_6) {
    if(var_9.script_noteworthy == "left") {
      var_9 rotateyaw(90, 1);
      playsoundatpos(var_9.origin, "power_buy_subway_track_gate_open_left");
    } else {
      var_9 rotateyaw(-90, 1);
    }

    wait(0.15);
  }

  foreach(var_9 in var_7) {
    if(var_9.script_noteworthy == "left") {
      var_9 rotateyaw(90, 1);
      playsoundatpos(var_9.origin, "power_buy_subway_track_gate_open_right");
    } else {
      var_9 rotateyaw(-90, 1);
    }

    wait(0.15);
  }

  var_0D = getscriptablearray("train_lights_front_far", "targetname");
  var_0E = getscriptablearray("train_lights_front_near", "targetname");
  var_0F = getscriptablearray("train_lights_back_near", "targetname");
  var_10 = getscriptablearray("train_lights_back_far", "targetname");
  foreach(var_12 in var_0D) {
    var_12 setscriptablepartstate("root", "red");
  }

  foreach(var_12 in var_0E) {
    var_12 setscriptablepartstate("root", "red");
  }

  wait(1);
  foreach(var_12 in var_0F) {
    var_12 setscriptablepartstate("root", "red");
  }

  foreach(var_12 in var_10) {
    var_12 setscriptablepartstate("root", "red");
  }

  wait(1);
  for(;;) {
    wait(1);
    var_0.origin = (-2794, -3203, 192);
    scripts\cp\maps\cp_disco\cp_disco_ghost_activation::try_set_up_skull_in_front_of_train(var_0);
    scripts\engine\utility::waitframe();
    var_0 setscriptablepartstate("root", "front_fx");
    var_2 setscriptablepartstate("root", "rear_fx");
    scripts\engine\utility::waitframe();
    var_0 setscriptablepartstate("sparks", "on");
    var_1 setscriptablepartstate("sparks", "on");
    var_2 setscriptablepartstate("sparks", "on");
    wait(30);
    level thread watch_for_train_player_damage(var_0, var_1, var_2);
    level thread watch_for_train_zombie_damage(var_0, var_1, var_2);
    level thread train_light_sequence();
    var_0 movey(var_0.origin[1] + 14000, 12);
    level thread rumble_quake_subway();
    wait(2);
    playsoundatpos((-2815, 1982, 314), "train_trap_horn_blast");
    wait(2);
    var_3 playsoundonmovingent("train_trap_passby_front");
    wait(1);
    var_4 playsoundonmovingent("train_trap_passby_middle");
    wait(1);
    var_5 playsoundonmovingent("train_trap_passby_back");
    wait(2);
    playsoundatpos((-2772, 3459, 314), "train_trap_away_tunnel");
    wait(2);
    level notify("stop_rumble_quake");
    earthquake(0.18, 3, (-2808, 2680, 204), 784);
    wait(5);
    scripts\engine\utility::waitframe();
    var_0 setscriptablepartstate("root", "off");
    var_2 setscriptablepartstate("root", "off");
    scripts\engine\utility::waitframe();
    var_0 setscriptablepartstate("sparks", "off");
    var_1 setscriptablepartstate("sparks", "off");
    var_2 setscriptablepartstate("sparks", "off");
    scripts\engine\utility::waitframe();
    var_0 moveto(var_0.origin + (0, 0, -300), 0.1);
    var_0 waittill("movedone");
    var_0 moveto((-2794, -3203, -108), 0.1);
    var_0 waittill("movedone");
  }
}

rumble_quake_subway() {
  level endon("stop_rumble_quake");
  playsoundatpos((-2775, 2660, 243), "train_trap_passby_lfe");
  wait(3.5);
  earthquake(0.1, 9, (-2808, 2680, 204), 512);
  wait(0.05);
  playrumbleonposition("artillery_rumble", (-2808, 2680, 204));
  wait(0.45);
  for(;;) {
    wait(0.2);
    earthquake(0.18, 1, (-2808, 2680, 204), 512);
    wait(0.05);
    playrumbleonposition("artillery_rumble", (-2808, 2680, 204));
  }
}

train_light_sequence() {
  var_0 = getscriptablearray("train_lights_front_far", "targetname");
  var_1 = getscriptablearray("train_lights_front_near", "targetname");
  var_2 = getscriptablearray("train_lights_back_near", "targetname");
  var_3 = getscriptablearray("train_lights_back_far", "targetname");
  playsoundatpos((-2800, 2200, 365), "train_trap_approach_tunnel");
  foreach(var_5 in var_0) {
    var_5 setscriptablepartstate("root", "green");
  }

  level thread train_zap_spot(var_1);
  wait(1);
  foreach(var_5 in var_1) {
    var_5 setscriptablepartstate("root", "green");
  }

  wait(1);
  foreach(var_5 in var_2) {
    var_5 setscriptablepartstate("root", "green");
  }

  level thread train_zap_spot(var_2);
  wait(1);
  foreach(var_5 in var_3) {
    var_5 setscriptablepartstate("root", "green");
  }

  wait(6);
  foreach(var_5 in var_0) {
    var_5 setscriptablepartstate("root", "red");
  }

  wait(1);
  foreach(var_5 in var_1) {
    var_5 setscriptablepartstate("root", "red");
  }

  wait(1);
  foreach(var_5 in var_2) {
    var_5 setscriptablepartstate("root", "red");
  }

  wait(1);
  foreach(var_5 in var_3) {
    var_5 setscriptablepartstate("root", "red");
  }
}

train_zap_spot(var_0) {
  level endon("stop_rumble_quake");
  for(;;) {
    wait(randomfloat(1.5));
    foreach(var_2 in var_0) {
      var_3 = scripts\engine\utility::getclosest(var_2.origin, getEntArray("place_fuse", "targetname"));
      var_4 = getEntArray(var_3.target, "targetname");
      foreach(var_6 in var_4) {
        playfxbetweenpoints(level._effect["electric_trap_attack"], var_2.origin, vectortoangles(var_2.origin - var_6.origin), var_6.origin);
        wait(randomfloat(1));
      }

      if(scripts\engine\utility::istrue(level.pap_fuses_placed) && var_4.size > 0 && scripts\engine\utility::istrue(var_4[0].waiting_for_charge)) {
        level thread upgrade_fuses();
      }
    }
  }
}

watch_for_train_player_damage(var_0, var_1, var_2) {
  level endon("stop_rumble_quake");
  for(;;) {
    foreach(var_4 in level.players) {
      if(!var_4 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(var_4 istouching(var_0) || var_4 istouching(var_1) || var_4 istouching(var_2)) {
        var_4 playlocalsound("disco_plr_hit_by_train_lr");
        var_4 dodamage(var_4.health + 100, var_0.origin, var_0, var_0, "MOD_CRUSH");
      }

      wait(0.05);
    }

    wait(0.1);
  }
}

watch_for_train_zombie_damage(var_0, var_1, var_2) {
  level endon("stop_rumble_quake");
  for(;;) {
    var_3 = scripts\cp\cp_agent_utils::getaliveagents();
    if(var_3.size < 1) {
      wait(1);
      continue;
    }

    foreach(var_5 in var_3) {
      if(!scripts\cp\utility::should_be_affected_by_trap(var_5, 0, 1)) {
        continue;
      }

      if(var_5 istouching(var_0) || var_5 istouching(var_1) || var_5 istouching(var_2)) {
        var_5.full_gib = 1;
        var_5.customdeath = 1;
        var_5.nocorpse = 1;
        var_5 dodamage(var_5.health + 100, var_0.origin, var_0, var_0, "MOD_IMPACT");
      }

      wait(0.05);
    }

    wait(0.1);
  }
}

setup_pap_camos() {
  level.pap_1_camo = "camo211";
  level.pap_2_camo = "camo212";
}

init_shock_subway_barriers() {
  level thread init_placed_fuse();
  var_0 = getent("shock_barrier", "targetname");
  var_1 = spawn("script_origin", (-2794.95, 2239.35, 187.998));
  var_2 = spawn("script_origin", (-2794.49, 3398.74, 187.998));
  level waittill("disco_subway power_on");
  scripts\engine\utility::exploder(105);
  var_1 playLoopSound("third_rail_right_lp");
  var_2 playLoopSound("third_rail_left_lp");
  for(;;) {
    var_0 waittill("trigger", var_3);
    if(var_3 scripts\cp\utility::is_valid_player(1) && !isDefined(var_3.padding_damage)) {
      playsoundatpos(var_3.origin, "third_rail_hit_electrocute");
      var_4 = playfxontagforclients(level._effect["electric_shock_plyr"], var_3, "tag_eye", var_3);
      var_3.padding_damage = 1;
      var_3 dodamage(25, var_3.origin);
      var_3 setvelocity(vectornormalize(var_0.origin - var_3.origin) * 500);
      var_3 thread scripts\cp\maps\cp_disco\cp_disco_interactions::remove_padding_damage();
    }
  }
}

play_char_intro_gesture() {
  thread scripts\cp\utility::firegesturegrenade(self, self.intro_gesture);
  wait(waitgesturelength());
  self notify("finish_intro_gesture");
}

waitgesturelength() {
  switch (self.vo_prefix) {
    case "p1_":
      return self getgestureanimlength("ges_load_in_disco_chick");

    case "p2_":
      return self getgestureanimlength("ges_load_in_punk");

    case "p3_":
      return self getgestureanimlength("ges_plyr_gesture008");

    case "p4_":
      return self getgestureanimlength("ges_plyr_gesture034");

    case "p5_":
      return get_pam_gesture_length();

    default:
      return 3;
  }
}

get_pam_gesture_length() {
  var_0 = 7;
  if(isDefined(self.intro_gesture)) {
    switch (self.intro_gesture) {
      case 0:
        var_0 = self getgestureanimlength("ges_plyr_gesture001");
        break;

      case 1:
        var_0 = self getgestureanimlength("ges_plyr_gesture001");
        break;

      case 2:
        var_0 = self getgestureanimlength("ges_plyr_gesture001");
        break;

      case 3:
        var_0 = self getgestureanimlength("ges_plyr_gesture001");
        break;

      default:
        var_0 = self getgestureanimlength("ges_plyr_gesture001");
        break;
    }
  }

  return var_0;
}

watchnunchuckspap1usage(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
}

watchnunchuckspap2usage(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
  if(!isDefined(var_0.nunchucks_kills_counter)) {
    var_0.nunchucks_kills_counter = 0;
  }

  if(!isDefined(var_0.nunchucks_swipes_counter)) {
    var_0.nunchucks_swipes_counter = 0;
  }

  var_1 = var_0 getweaponammoclip("iw7_nunchucks_zm_pap2");
  var_0 setweaponammoclip("iw7_nunchucks_zm_pap2", var_1 + var_0.nunchucks_swipes_counter);
  for(;;) {
    var_0 waittill("melee_fired", var_2);
    var_3 = getweaponbasename(var_2);
    if(var_3 == "iw7_nunchucks_zm_pap2") {
      var_0.nunchucks_swipes_counter++;
      var_1 = var_0 getweaponammoclip(var_2);
      var_0 thread display_weapon_stats(var_1, var_2);
      var_0 setweaponammoclip("iw7_nunchucks_zm_pap2", var_1 + var_0.nunchucks_swipes_counter);
      if(var_0.nunchucks_kills_counter >= 3) {
        var_0 thread nunchucks_pap2_ability();
        var_1 = var_0 getweaponammoclip(var_2);
        var_4 = var_1 - var_0.nunchucks_kills_counter;
        var_0 setweaponammoclip(var_2, var_4);
      }
    }
  }
}

nunchucks_recent_kills(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentNunchucksKills");
  self endon("updateRecentNunchucksKills");
  self.nunchucks_kills_counter++;
  thread reduce_kill_count_after_duration(3.5);
}

reduce_kill_count_after_duration(var_0) {
  wait(var_0);
  self.nunchucks_kills_counter--;
  if(self.nunchucks_kills_counter <= 0) {
    self.nunchucks_kills_counter = 0;
    thread remove_pap2_ability();
  }
}

nunchucks_pap2_ability() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("weapon_change");
  self notify("reaperActive");
  self endon("reaperActive");
  if(!scripts\engine\utility::istrue(self.applied_perks)) {
    if(!scripts\engine\utility::istrue(self.isreaping)) {
      self.isreaping = 1;
    }

    self.applied_perks = 1;
    scripts\cp\utility::_setperk("specialty_extendedmelee");
    scripts\cp\utility::_setperk("specialty_fastermelee");
    scripts\cp\utility::_setperk("specialty_sprintmelee");
    scripts\cp\utility::_setperk("specialty_fastoffhand");
  }
}

remove_pap2_ability() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("weapon_change");
  self notify("reaperInActive");
  self endon("reaperInActive");
  wait(3);
  if(scripts\engine\utility::istrue(self.applied_perks)) {
    self.isreaping = 0;
    self.applied_perks = undefined;
    scripts\cp\utility::_unsetperk("specialty_extendedmelee");
    scripts\cp\utility::_unsetperk("specialty_fastermelee");
    scripts\cp\utility::_unsetperk("specialty_sprintmelee");
    scripts\cp\utility::_unsetperk("specialty_fastoffhand");
  }
}

do_damage_cone_nunchucks(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_2 gettagorigin("j_spine4");
  var_7 = var_1 getplayerangles();
  var_8 = anglesToForward(var_7);
  var_9 = anglestoup(var_7);
  var_0A = var_6 - var_8 * 128;
  var_0B = 384;
  var_0C = var_2.origin - var_1.origin;
  var_0C = vectornormalize((var_0C[0], var_0C[1], 0));
  var_0C = var_0C * 2;
  if(issubstr(var_0, "pap1")) {
    thread scripts\engine\utility::play_sound_in_space("nunchucks_pap1_impact", var_6);
    playFX(level._effect["nunchuck_pap1"], var_6 + var_0C);
  } else {
    thread scripts\engine\utility::play_sound_in_space("nunchucks_pap2_impact", var_6);
    playFX(level._effect["nunchuck_pap2"], var_6 + var_0C);
  }

  var_0D = scripts\cp\cp_agent_utils::get_alive_enemies();
  foreach(var_0F in var_0D) {
    if(!isDefined(var_0F)) {
      continue;
    }

    if(isDefined(var_0F.flung) || isDefined(var_0F.agent_type) && var_0F.agent_type == "zombie_brute" || var_0F.agent_type == "zombie_ghost" || var_0F.agent_type == "zombie_grey" || var_0F.agent_type == "slasher" || var_0F.agent_type == "superslasher") {
      continue;
    }

    if(var_0F == var_2) {
      continue;
    }

    if(!isalive(var_0F)) {
      continue;
    }

    if(!scripts\cp\utility::pointvscone(var_0F gettagorigin("tag_origin"), var_0A, var_8, var_9, var_0B, 128, 24)) {
      continue;
    }

    if(var_0F damageconetrace(var_6, var_1) <= 0) {
      continue;
    }

    var_10 = int(400 * var_1 scripts\cp\cp_weapon::get_weapon_level(var_0));
    var_0F.nocorpse = 1;
    var_0F.full_gib = 1;
    var_0F.dontmutilate = 1;
    wait(0.05);
    var_0F dodamage(var_10, var_6, var_1, var_1, "MOD_EXPLOSIVE", var_0);
  }
}

display_weapon_stats(var_0, var_1) {
  level endon("game_ended");
  self endon("weapon_change");
  self endon("disconnect");
  wait(1);
}

unset_katanapap_effects() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    var_0 = self getcurrentweapon();
    if(!issubstr(var_0, "iw7_katana_zm_pap1") && !issubstr(var_0, "iw7_katana_zm_pap2")) {
      return;
    }

    if(isDefined(self.katana_swipes_counter) && self.katana_swipes_counter < 2) {
      self setscriptablepartstate("katanaFx", "neutral");
    }

    scripts\engine\utility::waittill_any_3("weapon_change", "special_done");
    self setscriptablepartstate("katanaFx", "neutral");
  }
}

setkatanaeffects(var_0) {
  self endon("weapon_change");
  self.seteffect = 0;
  for(;;) {
    if(self.seteffect != 1 && isDefined(self.katana_swipes_counter) && self.katana_swipes_counter == 2) {
      if(var_0 == 1) {
        self setscriptablepartstate("katanaFx", "active_pap1");
      } else {
        self setscriptablepartstate("katanaFx", "active_pap2");
      }

      self.seteffect = 1;
    }

    wait(1);
  }
}

watchkatanapap1usage(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
  var_0 thread setkatanaeffects(1);
  var_0 thread unset_katanapap_effects();
  if(!isDefined(var_0.katana_swipes_counter)) {
    var_0.katana_swipes_counter = 0;
  }

  for(;;) {
    var_0 waittill("melee_fired", var_1);
    var_2 = var_0 getweaponammoclip(var_1);
    var_0 thread display_weapon_stats(var_2, var_1);
    if(var_2 < 1) {
      continue;
    }

    if(issubstr(var_1, "iw7_katana_zm_pap1")) {
      var_0.katana_swipes_counter++;
      if(var_0.katana_swipes_counter == 3) {
        var_0 thread katana_earth_shatter();
        var_2 = var_0 getweaponammoclip(var_1);
        var_3 = var_2 - 1;
        var_0 setweaponammoclip(var_1, var_3);
        var_0.katana_swipes_counter = 0;
        var_0.seteffect = 0;
        var_0 notify("special_done");
      }
    }
  }
}

watchkatanapap2usage(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
  if(!isDefined(var_0.katana_swipes_counter)) {
    var_0.katana_swipes_counter = 0;
  }

  var_0 thread setkatanaeffects(2);
  var_0 thread unset_katanapap_effects();
  for(;;) {
    var_0 waittill("melee_fired", var_1);
    var_2 = var_0 getweaponammoclip(var_1);
    var_0 thread display_weapon_stats(var_2, var_1);
    if(issubstr(var_1, "iw7_katana_zm_pap2")) {
      if(var_2 < 1) {
        continue;
      }

      var_0.katana_swipes_counter++;
      if(var_0.katana_swipes_counter == 3) {
        var_2 = var_0 getweaponammoclip(var_1);
        var_3 = var_2 - 1;
        var_0 setweaponammoclip(var_1, var_3);
        var_0.katana_swipes_counter = 0;
        var_0 notify("special_done");
        var_0.seteffect = 0;
        var_4 = var_0 gettagorigin("j_gun") + (0.265, 6, 5);
        var_5 = var_0 getplayerangles();
        var_6 = rotatepointaroundvector(anglestoup(var_5), anglesToForward(var_5), 0);
        var_7 = var_4 + var_6 * 512;
        var_8 = scripts\cp\zombies\zombies_consumables::_magicbullet("iw7_katana_windforce_zm", var_4, var_7, var_0);
        if(isDefined(var_8)) {
          var_0 thread dual_katana_windforce(var_8);
        }
      }
    }
  }
}

dual_katana_windforce(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  var_1 = 256;
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_3 = self.angles;
  var_4 = self getEye();
  thread scripts\engine\utility::play_sound_in_space("katana_super_pap2_blast", var_0.origin);
  var_0 playsoundonmovingent("katana_super_pap2_proj");
  while(isDefined(var_0)) {
    var_5 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2, undefined, 24, var_1);
    self.closestenemies = var_5;
    var_6 = 0;
    foreach(var_8 in self.closestenemies) {
      if(!isDefined(var_8.agent_type)) {
        continue;
      }

      if(isDefined(var_0)) {
        var_9 = var_8.origin - var_0.origin;
        if(vectordot(anglesToForward(var_0.angles), var_9) < 0) {
          continue;
        } else if(distance2dsquared(var_0.origin, var_8.origin) < 16384) {
          if(isDefined(var_8.agent_type) && var_8.agent_type == "slasher" || var_8.agent_type == "superslasher") {
            var_8 dodamage(var_8.health, var_8.origin, self, self, "MOD_UNKNOWN", "iw7_katana_windforce_zm");
            continue;
          }

          var_8 thread katana_wind_attack_triggered(var_8.health + 1000, var_8, self, var_0);
        }
      }
    }

    scripts\engine\utility::waitframe();
  }

  var_0B = var_0.origin;
  if(isDefined(var_0.origin)) {
    var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_0C = 160000;
    foreach(var_0E in var_2) {
      if(!isDefined(var_0E)) {
        continue;
      }

      if(!isDefined(var_0E.agent_type)) {
        continue;
      }

      var_9 = var_0E.origin - var_0.origin;
      if(vectordot(anglesToForward(self.angles), var_9) < 0) {
        continue;
      } else if(distancesquared(var_0E.origin, var_0B) < var_0C) {
        var_0E.do_immediate_ragdoll = 1;
        var_0E.disable_armor = 1;
        var_0E.customdeath = 1;
        playsoundatpos(var_0E.origin, "perk_blue_bolts_sparks");
        var_0F = anglesToForward(self.angles);
        var_10 = vectornormalize(var_0F) * -100;
        if(isDefined(var_0E.agent_type) && var_0E.agent_type != "slasher" && var_0E.agent_type != "superslasher") {
          var_0E setvelocity(vectornormalize(var_0E.origin - self.origin + var_10) * 800 + (200, 0, 200));
        }

        wait(0.2);
        var_0E.nocorpse = 1;
        var_0E.full_gib = 1;
        if(isDefined(var_0E.agent_type) && var_0E.agent_type == "slasher" || var_0E.agent_type == "superslasher") {
          var_0E dodamage(var_0E.health, var_0E.origin, self, self, "MOD_UNKNOWN", "iw7_katana_windforce_zm");
        } else {
          var_0E dodamage(var_0E.health + 1000, var_0E.origin, self, self, "MOD_UNKNOWN", "iw7_katana_windforce_zm");
        }
      }
    }
  }
}

katana_wind_attack_triggered(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_3 endon("death");
  if(!isDefined(var_3)) {
    return;
  }

  var_4 = var_1.origin - var_3.origin;
  var_5 = anglesToForward(var_2.angles);
  var_6 = vectornormalize(var_5) * -100;
  if(isDefined(var_2)) {
    var_1.do_immediate_ragdoll = 1;
    var_1.disable_armor = 1;
    var_1.customdeath = 1;
    wait(0.1);
    var_1.nocorpse = 1;
    var_1.full_gib = 1;
    self dodamage(self.health + 1000, var_1.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_katana_windforce_zm");
    return;
  }

  self.nocorpse = 1;
  self.full_gib = 1;
  self dodamage(self.health + 1000, var_1.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_katana_windforce_zm");
}

katana_earth_shatter() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  thread get_earth_shatter_points(var_0, 1024);
}

get_earth_shatter_points(var_0, var_1) {
  var_2 = 64;
  var_3 = 0.2;
  var_4 = 1024;
  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  var_5 = int(var_4 / var_2 * 2);
  var_6 = var_4 - var_2 * 2 / var_5 - 1;
  var_7 = anglesToForward(self.angles);
  var_8 = 0 + var_2;
  var_9 = self.origin + var_7 * var_8;
  thread scripts\engine\utility::play_sound_in_space("katana_super_pap1_blast", var_9);
  for(var_0A = 0; var_0A < var_5; var_0A++) {
    var_0B = var_9 + var_0A * var_6 * var_7;
    thread launch_ground_effects_damage(var_0, var_0B, 128, 1000);
    if(var_0A > 0) {
      thread scripts\engine\utility::play_sound_in_space("katana_super_pap1_expl", var_0B);
    }

    wait(var_3);
  }
}

launch_ground_effects_damage(var_0, var_1, var_2, var_3) {
  self endon("death");
  level endon("game_ended");
  self endon("disconnect");
  var_4 = var_2 * var_2;
  playFX(level._effect["katana_pap1_tell"], var_1, anglesToForward(self.angles), anglestoup(self.angles));
  wait(0.2);
  foreach(var_6 in var_0) {
    if(distance2dsquared(var_6.origin, var_1) < var_4) {
      if(isDefined(var_6)) {
        playFX(level._effect["katana_pap1_earth"], var_6.origin, anglesToForward(var_6.angles), anglestoup(var_6.angles));
        playFX(level._effect["katana_pap1_subside"], var_6.origin, anglesToForward(var_6.angles), anglestoup(var_6.angles));
        var_6.flung = 1;
        var_6.do_immediate_ragdoll = 1;
        var_6.disable_armor = 1;
        var_6.full_gib = 1;
        var_6.nocorpse = 1;
        wait(0.05);
        var_6 dodamage(var_6.health + 1000000, var_6.origin, self, self, "MOD_IMPACT", "iw7_katana_zm_pap1");
      }
    }
  }
}

katana_recent_kills(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKatanaKills");
  self endon("updateRecentKatanaKills");
  self.katana_kills_counter++;
  wait(3.5);
  self.katana_kills_counter = 0;
}

rat_king_lair_doors() {
  level waittill("activate_power");
  getent("power_door_light_1", "targetname") setscriptablepartstate("light", "on");
  level waittill("activate_power");
  getent("power_door_light_2", "targetname") setscriptablepartstate("light", "on");
  level waittill("activate_power");
  getent("power_door_light_3", "targetname") setscriptablepartstate("light", "on");
  level waittill("activate_power");
  getent("power_door_light_4", "targetname") setscriptablepartstate("light", "on");
  level notify("sewer_underground power_on");
}

disco_lost_and_found() {
  var_0 = scripts\engine\utility::getstructarray("lost_and_found", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.name) && var_2.name == "rk_fight") {
      level thread scripts\cp\maps\cp_disco\cp_disco_interactions::delay_remove_from_interactions(var_2);
    }
  }
}

cp_disco_spawn_fx_func() {
  if(isDefined(self.spawner.script_fxid)) {
    switch (self.spawner.script_fxid) {
      case "concrete":
        if(!isDefined(self.spawner.last_ground_fx_time)) {
          self.spawner.last_ground_fx_time = gettime();
          self setscriptablepartstate("spawn_fx_concrete", "active");
        } else if(self.spawner.last_ground_fx_time + -5536 < gettime()) {
          self.spawner.last_ground_fx_time = gettime();
          self setscriptablepartstate("spawn_fx_concrete", "active");
        } else {
          self setscriptablepartstate("spawn_fx_dirt", "active");
        }

        thread dirt_concrete_fx(3);
        thread dirt_fx(6);
        break;

      case "dirt":
        self setscriptablepartstate("spawn_fx_dirt", "active");
        thread dirt_fx(6);
        break;

      case "ceiling":
        self setscriptablepartstate("spawn_fx_ceiling", "active");
        break;

      default:
        break;
    }
  }
}

dirt_fx(var_0) {
  self endon("death");
  self setscriptablepartstate("dirt", "active");
  wait(var_0);
  self setscriptablepartstate("dirt", "inactive");
}

dirt_concrete_fx(var_0) {
  self endon("death");
  self setscriptablepartstate("dirt_concrete", "active");
  wait(var_0);
  self setscriptablepartstate("dirt_concrete", "inactive");
}

discointeractiontriggerproperties(var_0, var_1, var_2) {
  if(isDefined(var_1.script_noteworthy)) {
    switch (var_1.script_noteworthy) {
      case "perk_candy_box":
      case "poster_struct":
      case "poster_num_struct":
      case "rk_arena_center":
      case "rk_debug":
      case "rk_relic_pos":
      case "disco_fever_interact":
      case "turnstile":
        self.interaction_trigger usetriggerrequirelookat(0);
        self.interaction_trigger setusefov(360);
        break;

      case "black_cat":
        self.interaction_trigger usetriggerrequirelookat(1);
        self.interaction_trigger setusefov(360);
        break;

      case "puzzle":
      case "peepshow_flyer":
        self.interaction_trigger.origin = var_1.origin + (0, 0, 10);
        self.interaction_trigger usetriggerrequirelookat(1);
        self.interaction_trigger setusefov(270);
        break;
    }
  }
}

choose_correct_vo_for_player(var_0) {
  wait(10);
  var_1 = "";
  if(var_0.times_self_revived >= var_0.max_self_revive_machine_use) {
    var_1 = "ww_afterlife_p4_notoken";
  } else {
    var_2 = ["ww_afterlife_p1_generic", "ww_afterlife_arrive"];
    var_1 = scripts\engine\utility::random(var_2);
  }

  if(var_1 == "ww_afterlife_arrive") {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo(var_1, "zmb_afterlife_vo", "high", 20, 0, 0, 1);
    return;
  }

  var_3 = strtok(var_1, "_");
  var_4 = "";
  var_5 = var_3[3];
  var_6 = var_0.vo_suffix;
  var_7 = strtok(var_6, "_");
  var_8 = var_7[0];
  switch (var_8) {
    case "p5":
    case "p4":
    case "p3":
    case "p2":
    case "p1":
      var_4 = choose_vo_based_on_type(var_8, var_5);
      break;

    default:
      var_4 = var_1;
      break;
  }

  if(soundexists(var_4)) {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo(var_4, "zmb_afterlife_vo", "high", 60, 1, 0, 1);
  }
}

choose_vo_based_on_type(var_0, var_1) {
  var_2 = "ww_afterlife_";
  for(;;) {
    var_2 = "ww_afterlife_";
    switch (var_1) {
      case "generic":
        var_2 = var_2 + var_0 + "_generic";
        break;

      case "notoken":
        var_2 = var_2 + var_0 + "_notoken";
        break;

      default:
        break;
    }

    if(!soundexists(var_2)) {
      var_3 = ["ww_afterlife_p1_generic", "ww_afterlife_arrive"];
      var_2 = scripts\engine\utility::random(var_3);
      if(var_2 == "ww_afterlife_arrive") {
        return var_2;
      } else {
        var_4 = strtok(var_2, "_");
        var_1 = var_4[3];
        continue;
      }
    } else {
      return var_2;
    }

    scripts\engine\utility::waitframe();
  }

  return var_2;
}

cp_disco_get_alias_2d_version(var_0, var_1, var_2) {
  var_3 = strtok(var_1, "_");
  if(var_3[0] == "ww" || var_3[0] == "pg") {
    return var_1;
  }

  var_4 = var_0.vo_prefix + "plr_" + var_2;
  if(soundexists(var_4)) {
    return var_4;
  }

  return undefined;
}

mutilation_mask_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;
  var_7 = zombies_should_mutilate(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  return var_7;
}

zombies_should_mutilate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(scripts\engine\utility::istrue(self.is_skeleton)) {
    return 0;
  }

  var_7 = getweaponbasename(var_1);
  var_8 = var_3 >= 1;
  if(isDefined(var_2)) {
    switch (var_2) {
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_EXPLOSIVE":
        if(is_mutilate_explosion(var_1)) {
          if(var_8 && isDefined(var_6) && distance2dsquared(self.origin, var_6.origin) < 1600) {
            return 31;
          } else {
            return 12;
          }
        } else {
          return 0;
        }
        break;

      case "MOD_MELEE":
        if(!var_8 && isDefined(var_7) && var_7 == "iw7_axe_zm" || var_7 == "iw7_axe_zm_pap1" || var_7 == "iw7_axe_zm_pap2") {
          return var_0;
        } else {
          return 0;
        }

        break;

      case "MOD_UNKNOWN":
        return 0;

      default:
        break;
    }
  }

  if(isDefined(var_1)) {
    var_9 = weaponclass(var_1);
    var_7 = getweaponbasename(var_1);
    if(isDefined(var_9) && var_9 == "spread" && var_2 != "mod_melee") {
      if(isDefined(var_7) && var_7 == "iw7_nrg_zm" || var_7 == "iw7_forgefreeze_zm") {
        return 0;
      }

      if(var_8 && isDefined(var_6) && distance2dsquared(self.origin, var_6.origin) < 10000) {
        return 31;
      } else {
        return var_0;
      }
    }

    if(isDefined(var_7)) {
      switch (var_7) {
        case "iw7_chargeshot_zm":
          if(var_8 && isDefined(var_2) && var_2 == "MOD_PROJECTILE") {
            return 31;
          }

          break;

        case "iw7_cheytac_zm":
        case "iw7_sdflmg_zm":
        case "iw7_unsalmg_zm":
        case "iw7_minilmg_zm":
        case "iw7_mauler_zm":
        case "iw7_lmg03_zm":
        case "iw7_m8_zm":
        case "iw7_kbs_zm":
          return var_0;

        default:
          if(is_arm_or_head_damage(var_0)) {
            return var_0;
          }

          break;
      }
    }
  }

  return 0;
}

is_arm_or_head_damage(var_0) {
  switch (var_0) {
    case 16:
    case 2:
    case 1:
      return 1;

    default:
      break;
  }

  return 0;
}

is_mutilate_explosion(var_0) {
  if(isDefined(var_0)) {
    var_1 = getweaponbasename(var_0);
    if(isDefined(var_1)) {
      switch (var_1) {
        case "kineticwave_mp":
        case "concussion_grenade_mp":
          return 0;

        default:
          break;
      }
    }
  }

  return 1;
}

additional_deny_wheel_purchase(var_0, var_1) {
  var_1 endon("disconnect");
  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return 1;
  }

  return 0;
}

deny_wheel_hint_func(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 playlocalsound("purchase_deny");
  if(isDefined(var_2)) {
    var_1 forceusehinton(&"CP_DISCO_INTERACTIONS_KUNG_FU_FAIL");
  } else {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
    var_1 forceusehinton(&"COOP_INTERACTIONS_NEED_MONEY");
  }

  wait(1);
  var_1 getrigindexfromarchetyperef();
}

magic_wheel_take_func(var_0, var_1, var_2) {
  if(!scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return 1;
  } else {
    var_1 forceusehinton(&"CP_DISCO_INTERACTIONS_KUNG_FU_FAIL");
    wait(0.5);
    var_1 getrigindexfromarchetyperef();
    return 0;
  }

  return 0;
}

cp_disco_zap_start_func(var_0) {
  self.scripted_mode = 1;
  self ghostskulls_complete_status(self.origin);
}

cp_disco_zap_end_func(var_0) {
  self.scripted_mode = 0;
}

adjuststructs() {
  var_0 = scripts\engine\utility::getstructarray("iw7_udm45_zm", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
  }

  move_struct((-2885.9, 1332.3, 1009), (-2898, 1332, 1009), (0, 180, 90));
  move_struct((-2913, 1297, 1009), (-2913, 1301, 1009), (0, 131, 90));
  move_struct((-609, 815, 928), (262, 228, 962));
}

move_struct(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getclosest(var_0, level.struct, 500);
  var_3.origin = var_1;
  if(isDefined(var_2)) {
    var_3.angles = var_2;
  }
}

should_drop_pillage(var_0, var_1) {
  if(scripts\engine\utility::istrue(self.died_poorly)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.flung)) {
    return 0;
  }

  if(isDefined(self.entered_playspace) && !self.entered_playspace) {
    return 0;
  }

  if(!scripts\cp\zombies\zombies_pillage::is_in_active_volume(var_1)) {
    return 0;
  }

  if(isDefined(self.hasplayedvignetteanim) && !self.hasplayedvignetteanim) {
    return 0;
  }

  if(scripts\cp\utility::too_close_to_other_interactions(var_1)) {
    return 0;
  }

  if(isDefined(var_0) && isplayer(var_0)) {
    return 1;
  }

  return 0;
}

show_challenge_outcome_func(var_0, var_1, var_2) {
  wait(3);
  var_3 = var_2.kung_fu_progression.active_discipline;
  var_4 = var_2.kung_fu_progression.disciplines_levels[var_3];
  var_2 setclientomnvar("ui_intel_progress_current", -1);
  var_2 setclientomnvar("ui_intel_progress_max", -1);
  if(var_4 < 3) {
    var_2 thread scripts\cp\zombies\solo_challenges::activate_new_challenge(var_3 + "_" + var_4 + 1 + "_challenge", var_2);
    return;
  }

  var_2 thread scripts\cp\zombies\solo_challenges::reset_omnvars();
}

disco_should_continue_progress_bar_think(var_0) {
  if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    return 1;
  }

  return !scripts\cp\cp_laststand::player_in_laststand(var_0);
}

cp_disco_auto_melee_agent_type_check(var_0) {
  if(scripts\engine\utility::istrue(var_0.bhasdiscofever)) {
    return 0;
  }

  return 1;
}

is_in_box(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [var_0, var_1, var_2, var_3];
  if(!isDefined(var_4)) {
    if(isplayer(self) || isagent(self)) {
      var_4 = self.origin;
    } else {
      return 0;
    }
  }

  for(var_6 = 0; var_6 < 2; var_6++) {
    foreach(var_8 in var_5) {
      var_9 = 0;
      foreach(var_0B in var_5) {
        if(var_8 == var_0B) {
          continue;
        }

        if((var_4[var_6] > var_8[var_6] && var_4[var_6] < var_0B[var_6]) || var_4[var_6] > var_0B[var_6] && var_4[var_6] < var_8[var_6]) {
          break;
        } else {
          var_9++;
          if(var_9 > 2) {
            return 0;
          }
        }
      }
    }
  }

  return 1;
}

kung_fu_interaction_func(var_0) {
  if(!scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(scripts\engine\utility::getstruct("craft_lavalamp", "script_noteworthy"), var_0);
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(scripts\engine\utility::getstruct("craft_boombox", "script_noteworthy"), var_0);
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(scripts\engine\utility::getstruct("craft_turret", "script_noteworthy"), var_0);
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(scripts\engine\utility::getstruct("craft_robot", "script_noteworthy"), var_0);
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(scripts\engine\utility::getstruct("craft_zombgone", "script_noteworthy"), var_0);
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(scripts\engine\utility::getstruct("craft_lavalamp", "script_noteworthy"), var_0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(scripts\engine\utility::getstruct("craft_boombox", "script_noteworthy"), var_0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(scripts\engine\utility::getstruct("craft_turret", "script_noteworthy"), var_0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(scripts\engine\utility::getstruct("craft_robot", "script_noteworthy"), var_0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(scripts\engine\utility::getstruct("craft_zombgone", "script_noteworthy"), var_0);
}

init_punk_record() {
  var_0 = spawnStruct();
  var_0.origin = (106.663, 908.5, 794.5);
  var_0.angles = (0.186416, 346.504, 90.7772);
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("cp_disco_record_sleeve_02");
  var_1 hide();
  var_0.model = var_1;
  var_2 = spawnStruct();
  var_2.origin = (106, 878, 802);
  var_2.angles = (0, 90, 0);
  var_2.model = var_1;
  addpunkrecordinteraction(var_2);
  thread showpunkrecordaftertime(var_2);
}

init_disco_record() {
  var_0 = spawnStruct();
  var_0.origin = (-1385, 3334, 939);
  var_0.angles = (0, 180, 158.8);
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("cp_disco_record_sleeve_01");
  var_1 hide();
  var_0.model = var_1;
  var_2 = spawnStruct();
  var_2.origin = (-1387, 3368, 926);
  var_2.angles = (0, 270, 0);
  var_2.model = var_1;
  adddiscorecordinteraction(var_2);
  thread showdiscorecordaftertime(var_2);
}

init_pa_turntables() {
  var_0 = spawnStruct();
  var_0.origin = (-1785, 3537, 1126);
  var_0.angles = (0, 180, 0);
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("cp_rave_turntable_01");
  var_1 hide();
  var_0.model = var_1;
  var_2 = spawnStruct();
  var_2.origin = (-1786, 3565.5, 1148);
  var_2.angles = (0, 270, 0);
  var_2.model = var_1;
  addturntableinteraction(var_2);
  thread showturntableaftertime(var_2);
}

showturntableaftertime(var_0) {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0.model show();
  var_0.var_19 = 1;
}

showdiscorecordaftertime(var_0) {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0.model show();
  var_0.var_19 = 1;
  level waittill("disco_record_used");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.model delete();
}

showpunkrecordaftertime(var_0) {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0.model show();
  var_0.var_19 = 1;
  level waittill("punk_record_used");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.model delete();
}

addturntableinteraction(var_0) {
  var_0.script_noteworthy = "pa_turntable";
  var_0.script_parameters = "default";
  var_0.requires_power = 0;
  var_0.powered_on = 1;
  var_0.name = "pa_turntable";
  var_0.spend_type = undefined;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

adddiscorecordinteraction(var_0) {
  var_0.script_noteworthy = "disco_record";
  var_0.script_parameters = "default";
  var_0.requires_power = 0;
  var_0.powered_on = 1;
  var_0.name = "disco_record";
  var_0.spend_type = undefined;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

addpunkrecordinteraction(var_0) {
  var_0.script_noteworthy = "punk_record";
  var_0.script_parameters = "default";
  var_0.requires_power = 0;
  var_0.powered_on = 1;
  var_0.name = "punk_record";
  var_0.spend_type = undefined;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

paturntableuse(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_0.var_19)) {
    return;
  }

  if(scripts\engine\utility::istrue(level.ratking_playlist)) {
    return;
  }

  if(scripts\engine\utility::istrue(level.punk_songs_added) && scripts\engine\utility::istrue(level.disco_songs_added)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.has_disco_record) && scripts\engine\utility::istrue(var_1.has_punk_record)) {
    if(scripts\engine\utility::istrue(level.disco_songs_added) && scripts\engine\utility::istrue(level.punk_songs_added)) {
      return;
    }

    if(scripts\engine\utility::istrue(level.punk_songs_added)) {
      level thread add_turntable_songs("disco_and_punk");
    } else if(scripts\engine\utility::istrue(level.disco_songs_added)) {
      level thread add_turntable_songs("punk_and_disco");
    } else {
      level thread add_turntable_songs("punk_and_disco");
    }

    var_1.has_disco_record = undefined;
    var_1.has_punk_record = undefined;
    level.disco_songs_added = 1;
    level.punk_songs_added = 1;
    level notify("punk_record_used");
    level notify("disco_record_used");
    return;
  }

  if(scripts\engine\utility::istrue(var_1.has_disco_record) && !scripts\engine\utility::istrue(var_1.has_punk_record)) {
    if(scripts\engine\utility::istrue(level.disco_songs_added)) {
      return;
    }

    if(scripts\engine\utility::istrue(level.punk_songs_added)) {
      level thread add_turntable_songs("disco_and_punk");
    } else {
      level thread add_turntable_songs("disco_only");
    }

    var_1.has_disco_record = undefined;
    level.disco_songs_added = 1;
    level notify("disco_record_used");
    return;
  }

  if(!scripts\engine\utility::istrue(var_1.has_disco_record) && scripts\engine\utility::istrue(var_1.has_punk_record)) {
    if(scripts\engine\utility::istrue(level.punk_songs_added)) {
      return;
    }

    if(scripts\engine\utility::istrue(level.disco_songs_added)) {
      level thread add_turntable_songs("punk_and_disco");
    } else {
      level thread add_turntable_songs("punk_only");
    }

    var_1.has_punk_record = undefined;
    level.punk_songs_added = 1;
    level notify("punk_record_used");
    return;
  }
}

add_turntable_songs(var_0) {
  foreach(var_2 in level.players) {
    var_2 playlocalsound("rk_record_scratch_static");
  }

  level notify("force_new_song");
  wait(3.5);
  if(var_0 == "punk_and_disco") {
    level.jukebox_table = "cp\zombies\cp_disco_music_genre_funkdiscopunk.csv";
    level scripts\cp\zombies\zombie_jukebox::force_song((1785, -2077, 211), "mus_pa_i_wanna_be_your_dog", undefined, undefined, undefined, undefined, 1);
  }

  if(var_0 == "disco_and_punk") {
    level.jukebox_table = "cp\zombies\cp_disco_music_genre_funkdiscopunk.csv";
    level scripts\cp\zombies\zombie_jukebox::force_song((1785, -2077, 211), "mus_pa_disco_inferno", undefined, undefined, undefined, undefined, 1);
    return;
  }

  if(var_0 == "punk_only") {
    level.jukebox_table = "cp\zombies\cp_disco_music_genre_funkpunk.csv";
    level scripts\cp\zombies\zombie_jukebox::force_song((1785, -2077, 211), "mus_pa_i_wanna_be_your_dog", undefined, undefined, undefined, undefined, 1);
    return;
  }

  if(var_0 == "disco_only") {
    level.jukebox_table = "cp\zombies\cp_disco_music_genre_funkdisco.csv";
    level scripts\cp\zombies\zombie_jukebox::force_song((1785, -2077, 211), "mus_pa_disco_inferno", undefined, undefined, undefined, undefined, 1);
    return;
  }
}

discorecorduse(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.has_disco_record)) {
    return;
  }

  var_1.has_disco_record = 1;
  var_1 playlocalsound("pap_quest_coin_pickup");
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  var_0.model hidefromplayer(var_1);
}

punkrecorduse(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.has_punk_record)) {
    return;
  }

  var_1.has_punk_record = 1;
  var_1 playlocalsound("pap_quest_coin_pickup");
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  var_0.model hidefromplayer(var_1);
}

paturntablehint(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_0.var_19)) {
    return "";
  }

  return "";
}

discorecordhint(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_0.var_19)) {
    return "";
  }

  return "";
}

punkrecordhint(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_0.var_19)) {
    return "";
  }

  return "";
}

choose_correct_strings_for_lost_and_found(var_0, var_1) {
  if(!isDefined(var_1)) {
    return undefined;
  }

  var_0 = scripts\cp\utility::getbaseweaponname(var_1);
  if(!isDefined(var_0)) {
    return &"CP_ZMB_WEAPONS_GENERIC";
  }

  switch (var_0) {
    case "iw7_katana":
      return &"CP_DISCO_WEAPONS_KATANA";

    case "iw7_nunchucks":
      return &"CP_DISCO_WEAPONS_NUNCHUCKS";

    default:
      return &"CP_ZMB_WEAPONS_GENERIC";
  }

  return &"CP_ZMB_WEAPONS_GENERIC";
}

movedefaultspawners() {
  var_0 = scripts\engine\utility::getstructarray("default_player_start", "targetname");
  var_1 = [(579, 3025, 286.5), (535, 2538, 286.5), (571, 2399, 286.5), (595, 2978, 286.5)];
  var_2 = [(0, 216, 0), (0, 220, 0), (0, 40, 0), (0, 333, 0)];
  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_0[var_3];
    var_4.origin = var_1[var_3];
    var_4.angles = var_2[var_3];
  }
}

cp_disco_introscreen_text() {
  var_0 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_DISCO_INTRO_LINE_1", 1);
  wait(1);
  var_1 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_DISCO_INTRO_LINE_2", 2);
  wait(1);
  var_2 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_DISCO_INTRO_LINE_3", 3);
  wait(1);
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    var_3 = scripts\cp\cp_hud_util::introscreen_corner_line(&"DIRECT_BOSS_FIGHT_LINE4_DISCO", 4);
  } else {
    var_3 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_DISCO_INTRO_LINE_4", 4);
  }

  wait(3);
  var_0 fadeovertime(3);
  var_1 fadeovertime(3);
  var_2 fadeovertime(3);
  var_3 fadeovertime(3);
  var_0.alpha = 0;
  var_1.alpha = 0;
  var_2.alpha = 0;
  var_3.alpha = 0;
  var_0 destroy();
  var_1 destroy();
  var_2 destroy();
  var_3 destroy();
}

create_linked_doors(var_0, var_1) {
  while(!isDefined(level.door_trigs)) {
    wait(0.05);
  }

  var_2 = scripts\engine\utility::getclosest(var_0, level.door_trigs, 100);
  var_3 = scripts\engine\utility::getclosest(var_1, level.door_trigs, 100);
  var_2 thread link_door(var_3);
  var_3 thread link_door(var_2);
}

link_door(var_0) {
  var_0 endon("purchased");
  self waittill("purchased");
  var_0.allow_nonplayer_trigger = 1;
  var_0 notify("trigger", level);
}

disco_patch_update_spawners() {
  scripts\cp\zombies\zombies_spawning::update_origin((-867.6, 1573.6, 1212), (-867.6, 1531.6, 1212));
  scripts\cp\zombies\zombies_spawning::update_origin((-1536, 1002, 1134), (-1536, 992, 1135));
  scripts\cp\zombies\zombies_spawning::update_origin((-1439.8, 4751, 770), (-1439.8, 4687, 770), (0, 270, 0));
  scripts\cp\zombies\zombies_spawning::update_origin((-1880.5, 4712.2, 776), (-1880.5, 4679.7, 776), (0, 270, 0));
  scripts\cp\zombies\zombies_spawning::update_origin((-2169.5, 4735.5, 771.7), (-2169.5, 4693.5, 771.7));
}

cp_disco_goon_spawner_patch_func(var_0) {
  remove_goon_spawner((647.8, 569.4, 750), var_0);
}

remove_goon_spawner(var_0, var_1) {
  var_2 = scripts\engine\utility::getclosest(var_0, var_1, 500);
  var_2.remove_me = 1;
}

disco_setup_direct_boss_fight_func() {
  level.zombies_paused = 1;
  level.disable_kung_fu_mode = 1;
}

disco_start_direct_boss_fight_func() {
  level.last_event_wave = 30;
  level.wave_num = 30;
  level.current_enemy_deaths = 0;
  level.max_static_spawned_enemies = scripts\cp\zombies\cp_disco_spawning::get_max_static_enemies(level.wave_num);
  level.desired_enemy_deaths_this_wave = scripts\cp\zombies\cp_disco_spawning::get_total_spawned_enemies(level.wave_num);
  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\powers\coop_powers::givepower("power_rat_king_eye", "secondary", undefined, undefined, undefined, 1, 1);
    var_1 thread scripts\cp\powers\coop_powers::givepower("power_heart", "primary", undefined, undefined, undefined, undefined, 1);
  }

  level.zombies_paused = 0;
  level.disable_kung_fu_mode = undefined;
  level thread scripts\cp\maps\cp_disco\rat_king_fight::start_rk_fight();
}