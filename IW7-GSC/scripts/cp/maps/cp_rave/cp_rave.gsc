/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave.gsc
***********************************************/

main() {
  setdvar("sm_sunSampleSizeNear", 0.705);
  setdvar("r_volumetricsBulbAttenClamp", 250);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("r_umbraAccurateOcclusionThreshold", 4000);
  setdvar("sm_roundRobinPrioritySpotShadows", 8);
  setdvar("sm_spotUpdateLimit", 8);
  setdvar("groundPound_minActivateHeight", 32);
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  level.blumberjackdebugger = getdvarint("debug_lumberjack", 0);
  level.bsasquatchdebugger = getdvarint("debug_sasquatch", 0);
  level.bsuperslasherdebugger = getdvarint("debug_superslasher", 0);
  level.bslasherdebugger = getdvarint("debug_slasher", 0);
  registerscriptedagents();
  level.custom_onplayerconnect_func = ::cp_rave_onplayerconnect;
  setminimap("", 3072, 3072, -3072, -3072);
  scripts\cp\cp_weapon_autosentry::init();
  scripts\cp\zombies\craftables\_zm_soul_collector::init();
  scripts\cp\zombies\craftables\_electric_trap::init();
  scripts\cp\crafted_trap_mower::init();
  scripts\cp\crafted_trap_balloons::init();
  scripts\cp\zombies\craftables\_boombox::init();
  scripts\cp\zombies\craftables\_revocator::init();
  scripts\cp\maps\cp_rave\cp_rave_precache::main();
  scripts\cp\maps\cp_rave\gen\cp_rave_art::main();
  scripts\cp\maps\cp_rave\cp_rave_fx::main();
  rave_precache();
  if(level.createfx_enabled) {
    return;
  }

  level.player_suit = "zom_dlc1_suit";
  level.player_run_suit = "zom_dlc1_suit_sprint";
  level.use_adjacent_volumes = 1;
  level.slasher_visible_in_normal_mode = 0;
  level.avoidance_radius = 8;
  level.scriptablestatefunc = scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate;
  level.custom_pillageinitfunc = ::cp_rave_pillage_init;
  level.introscreen_text_func = ::cp_rave_introscreen_text;
  level.get_alias_2d_func = ::cp_rave_get_alias_2d_version;
  level.special_character_count = 0;
  level.map_interaction_func = scripts\cp\maps\cp_rave\cp_rave_interactions::register_interactions;
  level.wait_for_interaction_func = scripts\cp\maps\cp_rave\cp_rave_interactions::cp_rave_wait_for_interaction_triggered;
  level.player_interaction_monitor = scripts\cp\maps\cp_rave\cp_rave_interactions::cp_rave_interaction_monitor;
  level.callbackplayerdamage = scripts\cp\maps\cp_rave\cp_rave_damage::callback_ravezombieplayerdamage;
  level.coop_weapontable = "cp\cp_rave_weapontable.csv";
  level.spawn_score_distance = 750;
  level.should_continue_progress_bar_think = ::cp_rave_should_continue_progress_bar_think;
  level.drop_max_ammo_func = scripts\cp\loot::drop_loot;
  level.power_setup_init = scripts\cp\maps\cp_rave\cp_rave_powers::init;
  level.cac_vo_male = scripts\engine\utility::array_randomize(["p1_", "p3_"]);
  level.cac_vo_female = scripts\engine\utility::array_randomize(["p2_"]);
  level.spawn_fx_func = ::cp_rave_spawn_fx_func;
  level.initial_active_volumes = ["front_gate"];
  level.door_properties_func = ::setup_rave_mode_door;
  level.atm_amount_deposited = 0;
  level.perk_registration_func = ::registerraveperks;
  level.lethaldamage_func = ::cp_rave_lethaldamage_func;
  level.onzombiedamage_func = ::cp_rave_onzombiedamage_func;
  level.enter_rave_mode = ::enter_rave_mode;
  level.exit_rave_mode = ::exit_rave_mode;
  level.guidedinteractionexclusion = ::guidedinteractionsexclusions;
  level.guided_interaction_offset_func = ::guidedinteractionoffsetfunc;
  level.laststand_exit_gamemodespecificaction = ::cp_rave_exit_laststand_func;
  level.move_speed_scale = ::cp_rave_updatemovespeedscale;
  level.auto_melee_agent_type_check = ::cp_rave_auto_melee_agent_type_check;
  level.custom_weaponnamestring_func = ::rave_getweaponnamestring;
  level.no_clown_spawn = 1;
  level.goon_spawner_patch_func = ::cp_rave_goon_spawner_patch_func;
  level.patch_update_spawners = ::cp_rave_patch_update_spawners;
  level.custom_epehermal_attachment_func = ::rave_ephemeral_attachment;
  level.custom_epehermal_weapon_func = ::rave_ephemeral_weapon;
  level.custom_ephermal_camo_func = ::rave_ephemeral_camo;
  level.event_funcs_init = ::cp_rave_event_wave_init;
  level.available_event_func = ::cp_rave_event_selection;
  level.event_funcs_start = ::cp_rave_event_start;
  level.event_funcs_end = ::cp_rave_event_end;
  level.should_run_event_func = ::cp_rave_should_run_event;
  level.ai_cleanup_func = scripts\cp\zombies\cp_rave_spawning::cp_rave_cleanup_main;
  level.should_do_damage_check_func = ::cp_rave_should_do_damage_check_func;
  level.crystal_killed_notify = "kill_near_crystal";
  level.memory_quest_items = [];
  level.harpoon_projectiles = [];
  level.player_pap_machines = [];
  level.challenge_registration_func = scripts\cp\maps\cp_rave\cp_rave_challenges::register_default_challenges;
  level.challenge_scalar_func = scripts\cp\maps\cp_rave\cp_rave_challenges::challenge_scalar_func;
  level.custom_death_challenge_func = scripts\cp\maps\cp_rave\cp_rave_challenges::default_death_challenge_func;
  level.custom_playerdamage_challenge_func = scripts\cp\maps\cp_rave\cp_rave_challenges::default_playerdamage_challenge_func;
  level.death_challenge_update_func = scripts\cp\zombies\solo_challenges::update_death_challenges;
  level.challenge_init_func = scripts\cp\zombies\solo_challenges::init_solo_challenges;
  level.char_intro_gesture = ::play_char_intro_gesture;
  level.mutilation_mask_override_func = ::cp_rave_mutilation_mask_func;
  level.char_intro_music = ::play_char_intro_music;
  level.harpoon_impale_additional_func = scripts\cp\cp_weapon::harpoon_impale_additional_func;
  level.purchase_area_vo = scripts\cp\maps\cp_rave\cp_rave_vo::purchase_area_vo;
  level.aa_ww_char_vo = scripts\cp\zombies\zombie_afterlife_arcade::choose_correct_vo_for_player;
  level.aa_memoirs_vo = scripts\cp\zombies\zombie_afterlife_arcade::play_ww_vo_memoirs;
  level.setup_direct_boss_fight_func = ::rave_setup_direct_boss_fight_func;
  level.start_direct_boss_fight_func = ::rave_start_direct_boss_fight_func;
  level.is_valid_spawn_weapon_func = ::rave_is_valid_spawn_weapon_func;
  level.get_fists_weapon_func = ::get_char_fist_weapon;
  level.enable_slasher_weapon = scripts\cp\maps\cp_rave\cp_rave_interactions::enable_slasher_weapon;
  level thread setupinvalidvolumes();
  level thread cp_rave_gns_2_setup();
  level thread show_sym_pap();
  level thread scripts\cp\maps\cp_rave\cp_rave_vo::rave_vo_init();
  scripts\cp\maps\cp_rave\cp_rave_player_character_setup::init_player_characters();
  level thread wait_for_pre_game_period();
  level.additional_laststand_weapon_exclusion = ["iw7_cpbasketball_mp", "iw7_cpskeeball_mp", "iw7_cpclowntoothball_mp", "iw7_horseracepistol_zm_blue", "iw7_horseracepistol_zm_yellow", "iw7_horseracepistol_zm_red", "iw7_horseracepistol_zm_green", "iw7_shootgallery_zm", "iw7_blackholegun_mp", "iw7_penetrationrail_mp", "iw7_atomizer_mp", "iw7_glr_mp", "iw7_claw_mp", "iw7_steeldragon_mp", "iw7_shootgallery_zm_blue", "iw7_shootgallery_zm_yellow", "iw7_shootgallery_zm_red", "iw7_lawnmower_zm", "iw7_shootgallery_zm_green"];
  level.last_stand_weapons = ["iw7_g18_zm", "iw7_g18_zmr", "iw7_g18_zml", "iw7_g18c_zm", "iw7_mag_zm", "iw7_revolver_zm", "iw7_revolver_zmr", "iw7_revolver_zmr_explosive", "iw7_revolver_zml", "iw7_revolver_zml_single", "iw7_emc_zm", "iw7_emc_zmr", "iw7_emc_zmr_burst", "iw7_emc_zml", "iw7_emc_zml_spread", "iw7_nrg_zm", "iw7_nrg_zmr", "iw7_nrg_zmr_smart", "iw7_nrg_zml", "iw7_nrg_zml_charge", "iw7_dischord_zm", "iw7_headcutter_zm", "iw7_shredder_zm", "iw7_facemelter_zm", "iw7_dischord_zm_pap1", "iw7_headcutter_zm_pap1", "iw7_shredder_zm_pap1", "iw7_facemelter_zm_pap1", "iw7_golf_club_mp_pap1", "iw7_two_headed_axe_mp_pap1", "iw7_spiked_bat_mp_pap1", "iw7_machete_mp_pap1", "iw7_golf_club_mp_pap2", "iw7_two_headed_axe_mp_pap2", "iw7_spiked_bat_mp_pap2", "iw7_machete_mp_pap2", "iw7_golf_club_mp", "iw7_two_headed_axe_mp", "iw7_spiked_bat_mp", "iw7_machete_mp"];
  level.melee_weapons = ["iw7_machete_mp", "iw7_golf_club_mp", "iw7_two_headed_axe_mp", "iw7_spiked_bat_mp", "iw7_golf_club_mp_pap1", "iw7_two_headed_axe_mp_pap1", "iw7_spiked_bat_mp_pap1", "iw7_machete_mp_pap1", "iw7_golf_club_mp_pap2", "iw7_two_headed_axe_mp_pap2", "iw7_spiked_bat_mp_pap2", "iw7_machete_mp_pap2", "iw7_slasher_zm"];
  level.weapon_rank_event_table = "scripts\cp\maps\cp_rave\cp_rave_weaponrank_event.csv";
  scripts\cp\maps\cp_rave\cp_rave_crafting::set_crafting_starting_location("cabin_to_lake");
  scripts\cp\maps\cp_rave\cp_rave_crafting::init_crafting();
  setup_generic_zombie_model_list();
  level thread scripts\cp\zombies\interaction_rave_openareas::init_all_debris_and_door_positions();
  level thread setup_slide();
  level thread water_triggers();
  level thread setup_pap_camos();
  level thread scripts\cp\maps\cp_rave\cp_rave_interactions::setup_rave_dust_interactions();
  level thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::init_super_slasher_quest();
  level thread scripts\cp\maps\cp_rave\cp_rave_harpoon_quest::harpoon_quest_init();
  level thread scripts\cp\maps\cp_rave\cp_rave_j_mem_quest::j_mem_quest_init();
  level.processenemykilledfunc = ::rave_processenemykilledfunc;
  level.kill_reward_func = ::cp_rave_kill_reward;
  level.someones_in_rave = 0;
  level.slasher_level = 1;
  level.lumberjack_spawn_percent = 2;
  level.active_kill_quests = [];
  level.no_slasher = 0;
  level.custom_onspawnplayer_func = ::cp_rave_onplayerspawned;
  level.wave_complete_dialogues_func = ::wave_complete_dialogues;
  level.power_vo_func = ::rave_power_on_vo;
  level.magic_wheel_spin_hint = &"CP_RAVE_SPIN_WHEEL";
  level.reboard_barriers_hint = &"CP_RAVE_SECURE_WINDOW";
  level.enter_area_hint = &"CP_RAVE_ENTER_THIS_AREA";
  level thread setup_pa_speakers();
  init_weapon_change_funcs();
  init_wall_buys_array();
  init_rave_quests();
  adjust_player_spawn_pos();
  scripts\cp\maps\cp_rave\cp_rave_interactions::disable_slasher_weapon();
  level thread harpoon_upgrade_quest();
  level thread survivor_logic();
  level thread adjust_struct_positions();
  level thread rockwall_logic();
  level thread adjust_portal_location();
  level thread adjust_computer_interaction_pos();
  level thread setup_harpoon_cabinet_weapons();
  level thread b_man_head_tracking();
  level thread setup_glyph_targets();
  level thread setup_pool_balls();
  level thread watch_ee_song_quest_complete();
  level thread init_zombie_heads();
  level thread remove_door_ala();
  level.interaction_trigger_properties_func = ::rave_set_interaction_trigger_properties;
  scripts\cp\maps\cp_rave\cp_rave_memory_quests::rave_charm_mapping();
  scripts\cp\maps\cp_rave\cp_rave_memory_quests::init_memory_quests();
  scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::init_weapon_upgrade();
  scripts\cp\powers\coop_armageddon::init_armageddon();
  level thread scripts\cp\zombies\cp_rave_doors::rave_trap_door();
  level thread spawn_afterlife_speaker();
  level.no_ticket_machine = 1;
  level thread adjust_doorbuy_triggers();
  level.lnf_sign = getent("lost_found_island", "targetname");
  if(isDefined(level.lnf_sign)) {
    level.lnf_sign hide();
  }

  level thread setup_water_respawn_points();
  level thread show_pap_symbols();
  level thread fix_map_exploits();
  sysprint("MatchStarted: Completed");
}

fix_map_exploits() {
  level thread invalid_place_watcher();
  add_invalid_place((-1501, 1764, -18), (0, 250, 0), 32);
  add_invalid_place((-1471, 1804, -18), (0, 250, 0), 32);
  add_invalid_place((-1440.5, 1844.5, -18), (0, 250, 0), 32);
  add_invalid_place((-1409, 1884.5, -18), (0, 250, 0), 32);
  add_invalid_place((-1388, 1912, -18), (0, 250, 0), 32);
  add_invalid_place((-1368, 1936.5, -18), (0, 250, 0), 32);
  var_0 = spawn("script_model", (0, 0, 0));
  var_1 = spawn("script_model", (0, 0, 0));
  var_2 = spawn("script_model", (0, 0, 0));
  var_0 clonebrushmodeltoscriptmodel(getent("playerai128x128x8", "targetname"));
  var_1 clonebrushmodeltoscriptmodel(getent("playerai128x128x8", "targetname"));
  var_2 clonebrushmodeltoscriptmodel(getent("player64x64x8", "targetname"));
  var_0.origin = (-2003.5, 1365, -83);
  var_0.angles = (-90, 45, 0);
  var_1.origin = (-2425.5, -4892, 393);
  var_1.angles = (-90, 195, 0);
  var_2.origin = (-1871.3, -4394, 414);
  var_2.angles = (90, 180, -150);
}

add_invalid_place(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.origin = var_0;
  var_5.var_381 = var_1;
  var_5.distcheck = var_2 * var_2;
  var_5.moveplayer = var_3;
  var_5.moveplayerspot = var_4;
  level.invalid_orgs[level.invalid_orgs.size] = var_5;
}

invalid_place_watcher() {
  level.invalid_orgs = [];
  while(level.invalid_orgs.size == 0) {
    wait(0.1);
  }

  for(;;) {
    foreach(var_1 in level.invalid_orgs) {
      foreach(var_3 in level.players) {
        if(distancesquared(var_3.origin, var_1.origin) <= var_1.distcheck) {
          var_3 playlocalsound("ww_magicbox_laughter");
          var_3 setvelocity(var_1.var_381);
        }
      }

      wait(0.25);
    }

    wait(0.5);
  }
}

setup_pap_camos() {
  level.pap_1_camo = "camo204";
  level.pap_2_camo = "camo205";
  level.no_pap_camos = ["harpoon", "iw7_harpoon1_zm", "iw7_harpoon2_zm", "iw7_harpoon3_zm", "iw7_harpoon4_zm", "harpoon1", "harpoon2", "harpoon3", "harpoon4", "slasher", "axe", "two", "golf", "machete", "spiked"];
}

show_pap_symbols() {
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

adjust_portal_location() {
  wait(5);
  var_0 = scripts\engine\utility::getstruct("selfrevive_portal", "targetname");
  var_0.origin = var_0.origin + (0, 7, 11);
}

setup_water_respawn_points() {
  wait(10);
  level.water_respawn_points = [];
  setup_water_respawn_point((-4896, 6128, -134.1));
  setup_water_respawn_point((-4800, 6128, -133.8));
  setup_water_respawn_point((-4512, 6192, -137.6));
  setup_water_respawn_point((-4288, 6000, -129.2));
  setup_water_respawn_point((-4960, 6144, -135.6));
  setup_water_respawn_point((-4432, 6160, -135.6));
  setup_water_respawn_point((-3728, 4384, -133.1));
  setup_water_respawn_point((-4336, 6096, -132.7));
  setup_water_respawn_point((-4272, 5872, -133.3));
  setup_water_respawn_point((-3792, 4320, -135.5));
  setup_water_respawn_point((-4272, 5760, -134.9));
  setup_water_respawn_point((-4272, 5632, -133.8));
  setup_water_respawn_point((-4256, 5456, -133.4));
  setup_water_respawn_point((-4208, 5312, -132.3));
  setup_water_respawn_point((-4160, 5248, -133.3));
  setup_water_respawn_point((-4096, 5152, -134.4));
  setup_water_respawn_point((-4048, 5072, -130.5));
  setup_water_respawn_point((-3968, 5008, -126.3));
  setup_water_respawn_point((-3856, 4944, -114.1));
  setup_water_respawn_point((-3712, 4880, -110.4));
  setup_water_respawn_point((-3568, 4720, -117));
  setup_water_respawn_point((-3584, 4560, -123.4));
  setup_water_respawn_point((-3664, 4448, -127.2));
  setup_water_respawn_point((-3856, 4192, -140));
  setup_water_respawn_point((-3920, 4064, -140));
  setup_water_respawn_point((-4048, 4000, -140));
  setup_water_respawn_point((-4176, 3936, -140));
  setup_water_respawn_point((-4304, 3936, -140));
  setup_water_respawn_point((-4368, 3872, -140));
  setup_water_respawn_point((-4496, 3808, -140));
  setup_water_respawn_point((-1984, 2000, -123.4));
  setup_water_respawn_point((-2112, 1936, -123.4));
  setup_water_respawn_point((-2112, 1808, -123.4));
  setup_water_respawn_point((-2112, 1680, -123.4));
  setup_water_respawn_point((-2112, 1744, -123.4));
  setup_water_respawn_point((-2144, 1616, -123.4));
  setup_water_respawn_point((-2272, 1616, -123.4));
  setup_water_respawn_point((-2432, 1584, -123.4));
  setup_water_respawn_point((-2464, 1488, -123.4));
  setup_water_respawn_point((-2400, 1392, -123.4));
  setup_water_respawn_point((-2400, 1296, -123.4));
  setup_water_respawn_point((-2080, 1968, -123.4));
  setup_water_respawn_point((-2112, 1872, -123.4));
  setup_water_respawn_point((1536, 16, 4.6));
  setup_water_respawn_point((1472, 16, 4.6));
  setup_water_respawn_point((1408, 16, 4.6));
  setup_water_respawn_point((1344, 48, 4.6));
  setup_water_respawn_point((1248, 80, 4.6));
  setup_water_respawn_point((1176, 72, 4.6));
  setup_water_respawn_point((1074, 40, 4.6));
}

spawn_water_trigger(var_0) {
  var_1 = spawn("trigger_radius", var_0, 0, 175, 128);
  var_1.var_336 = "water_trigger";
}

setup_water_respawn_point(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  level.water_respawn_points[level.water_respawn_points.size] = var_1;
}

super_slasher_barrier_test() {
  for(var_0 = 30; var_0 > 0; var_0--) {
    wait(1);
    iprintlnbold("=== " + var_0);
  }

  for(;;) {
    scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::activate_super_slasher_barrier(1);
    wait(10);
    scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::activate_super_slasher_barrier(2);
    wait(10);
    scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::activate_super_slasher_barrier(3);
    wait(10);
    scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::activate_super_slasher_barrier(4);
    wait(10);
  }
}

rave_power_on_vo(var_0) {
  level endon("gamed_ended");
  var_0 endon("death");
  var_0 endon("disconnect");
  if(scripts\engine\utility::flag_exist("canFiresale")) {
    scripts\engine\utility::flag_set("canFiresale");
  }

  switch (var_0.vo_prefix) {
    case "p1_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("poweron_first_chola_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["poweron_first_chola_1"] = 1;
      break;

    case "p4_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("poweron_first_hiphop_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["poweron_first_hiphop_1"] = 1;
      break;

    case "p3_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("poweron_first_rocker_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["poweron_first_rocker_1"] = 1;
      break;

    case "p2_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("poweron_first_raver_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["poweron_first_raver_1"] = 1;
      break;

    default:
      break;
  }
}

watch_ee_song_quest_complete() {
  level endon("gamed_ended");
  level endon("song_ee_achievement_given");
  for(;;) {
    scripts\engine\utility::waitframe();
    if(!isDefined(level.total_glyphs_found) && !isDefined(level.total_glyphs_to_find)) {
      continue;
    }

    if(level.total_glyphs_found == level.total_glyphs_to_find) {
      foreach(var_1 in level.players) {
        var_1 scripts\cp\zombies\achievement::update_achievement("RAVE_ON", 1);
      }

      level notify("add_hidden_song_to_playlist");
      level thread play_hidden_song((1785, -2077, 211), "mus_pa_rave_hidden_track");
      level notify("song_ee_achievement_given");
      continue;
    }

    continue;
  }
}

play_hidden_song(var_0, var_1) {
  level endon("game_ended");
  if(var_1 == "mus_pa_rave_hidden_track") {
    level endon("add_hidden_song_to_playlist");
  }

  if(soundexists(var_1)) {
    wait(2.5);
    foreach(var_3 in level.players) {
      if(scripts\engine\utility::istrue(level.onlinegame)) {
        var_3 setplayerdata("cp", "hasSongsUnlocked", "any_song", 1);
        if(var_1 == "mus_pa_rave_hidden_track") {
          var_3 setplayerdata("cp", "hasSongsUnlocked", "song_3", 1);
        }
      }
    }

    var_5 = undefined;
    if(isDefined(var_5)) {
      level thread scripts\cp\cp_vo::try_to_play_vo(var_5, "zmb_dj_vo", "high", 60, 1, 0, 1);
      var_6 = lookupsoundlength(var_5) / 1000;
      wait(var_6);
    }

    scripts\engine\utility::play_sound_in_space("zmb_jukebox_on", var_0);
    var_7 = spawn("script_origin", var_0);
    var_8 = "ee";
    var_9 = 1;
    foreach(var_3 in level.players) {
      var_3 scripts\cp\cp_persistence::give_player_xp(500, 1);
    }

    var_7 playLoopSound(var_1);
    var_7 thread scripts\cp\zombies\zombie_jukebox::earlyendon(var_7);
    var_12 = lookupsoundlength(var_1) / 1000;
    level scripts\engine\utility::waittill_any_timeout(var_12, "skip_song");
    var_7 stoploopsound();
    var_7 delete();
  } else {
    wait(2);
  }

  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start(var_0, 1);
}

init_zombie_heads() {
  level.zombie_heads = getscriptablearray("mounted_zom_head", "targetname");
}

setup_harpoon_cabinet_weapons() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = scripts\engine\utility::getstructarray("iw7_harpoon_zm", "script_noteworthy");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    var_2 thread activate_struct_when_quest_complete(var_2);
  }
}

activate_struct_when_quest_complete(var_0) {
  scripts\engine\utility::flag_wait("harpoon_unlocked");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

adjust_computer_interaction_pos() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = scripts\engine\utility::getstruct("computer", "script_noteworthy");
  var_0.origin = (-554.2, -1444.3, 252);
  thread delay_remove_from_interactions(var_0);
  thread turn_on_effect_with_power(var_0, (-524.4, -1445.5, 265), (0, 38, 0));
}

turn_on_effect_with_power(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = spawnfx(level._effect["computer_screen"], var_1, anglesToForward(var_2), anglestoup(var_2));
  level waittill("activate_power");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  triggerfx(var_3);
}

setup_scares() {
  level endon("gamed_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = scripts\engine\utility::getstructarray("slasher_scenes", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread wait_for_player_approach(var_2);
  }
}

wait_for_player_approach(var_0) {
  level endon("game_ended");
  var_1 = 26896;
  if(isDefined(var_0.target)) {
    var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_3 = 0;
    var_4 = spawn("script_model", var_0.origin);
    if(isDefined(var_0.angles)) {
      var_4.angles = var_0.angles;
    } else {
      var_4.angles = (0, 0, 0);
    }

    var_4 setModel("body_zmb_slasher");
    var_4 hide();
    while(!var_3) {
      if(!isDefined(level.slasher)) {
        foreach(var_6 in level.players) {
          if(distance2dsquared(var_6.origin, var_2.origin) <= var_1) {
            if(scripts\engine\utility::within_fov(var_6.origin, var_6 getplayerangles(), var_4.origin, 0.83)) {
              var_3 = 1;
              break;
            }
          }
        }
      }

      wait(randomfloatrange(0.1, 1));
    }

    wait(0.5);
    foreach(var_6 in level.players) {
      if(!scripts\engine\utility::istrue(var_6.rave_mode)) {
        var_4 showtoplayer(var_6);
      }
    }

    var_4 scriptmodelplayanimdeltamotionfrompos("IW7_cp_slasher_walk_forward_01", var_4.origin, var_4.angles);
    var_10 = getanimlength(%iw7_cp_slasher_walk_forward_01);
    wait(var_10);
    var_4 delete();
  }
}

wave_complete_dialogues(var_0) {
  if(!isDefined(level.completed_dialogues)) {
    level.completed_dialogues = [];
  }

  if(level.players.size < 2) {
    if(level.players[0].vo_prefix == "p5_") {
      if(randomint(100) > 70) {
        level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("ww_p5_taunt", "rave_ww_vo");
      }
    }
  }

  if(var_0 >= 3 && var_0 <= 5) {
    if(randomint(100) > 60) {
      var_1 = scripts\engine\utility::random(level.players);
      if(isDefined(var_1.vo_prefix)) {
        switch (var_1.vo_prefix) {
          case "p1_":
            if(!isDefined(level.completed_dialogues["round3to5_14_1"])) {
              var_1 thread scripts\cp\cp_vo::try_to_play_vo("round3to5_14_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["round3to5_14_1"] = 1;
            }
            break;

          case "p4_":
            if(!isDefined(level.completed_dialogues["round3to5_15_1"])) {
              var_1 thread scripts\cp\cp_vo::try_to_play_vo("round3to5_15_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["round3to5_15_1"] = 1;
            }
            break;

          case "p3_":
            if(!isDefined(level.completed_dialogues["round3to5_16_1"])) {
              var_1 thread scripts\cp\cp_vo::try_to_play_vo("round3to5_16_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["round3to5_16_1"] = 1;
            }
            break;

          case "p2_":
            if(!isDefined(level.completed_dialogues["round3to5_17_1"])) {
              var_1 thread scripts\cp\cp_vo::try_to_play_vo("round3to5_17_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["round3to5_17_1"] = 1;
            }
            break;

          default:
            break;
        }

        return;
      }

      return;
    }

    return;
  }

  if(var_1 >= 9 && var_1 <= 12) {
    if(randomint(100) > 60) {
      var_1 = scripts\engine\utility::random(level.players);
      if(isDefined(var_1.vo_prefix)) {
        switch (var_1.vo_prefix) {
          case "p1_":
            if(!isDefined(level.completed_dialogues["round9to12_22_1"])) {
              var_1 thread scripts\cp\cp_vo::try_to_play_vo("round9to12_22_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["round9to12_22_1"] = 1;
            }
            break;

          case "p4_":
            if(!isDefined(level.completed_dialogues["round9to12_23_1"])) {
              var_1 thread scripts\cp\cp_vo::try_to_play_vo("round9to12_23_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["round9to12_23_1"] = 1;
            }
            break;

          case "p3_":
            if(!isDefined(level.completed_dialogues["round3to5_16_1"])) {
              var_1 thread scripts\cp\cp_vo::try_to_play_vo("round3to5_16_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["round3to5_16_1"] = 1;
            }
            break;

          case "p2_":
            if(!isDefined(level.completed_dialogues["round3to5_17_1"])) {
              var_1 thread scripts\cp\cp_vo::try_to_play_vo("round3to5_17_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["round3to5_17_1"] = 1;
            }
            break;

          default:
            break;
        }

        return;
      }

      return;
    }

    return;
  }

  if(randomint(100) > 60) {
    if(scripts\engine\utility::istrue(level.met_kev)) {
      var_2 = level.players[0];
      if(isDefined(level.players_who_met_kev)) {
        var_2 = scripts\engine\utility::random(level.players_who_met_kev);
      }

      switch (var_2.vo_prefix) {
        case "p1_":
          if(!isDefined(level.completed_dialogues["trustksmith_38_1"])) {
            var_2 thread scripts\cp\cp_vo::try_to_play_vo("trustksmith_38_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["trustksmith_38_1"] = 1;
          }
          break;

        case "p4_":
          if(!isDefined(level.completed_dialogues["trustksmith_40_1"])) {
            var_2 thread scripts\cp\cp_vo::try_to_play_vo("trustksmith_40_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["trustksmith_40_1"] = 1;
          }
          break;

        case "p3_":
          if(!isDefined(level.completed_dialogues["trustksmith_39_1"])) {
            var_2 thread scripts\cp\cp_vo::try_to_play_vo("trustksmith_39_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["trustksmith_39_1"] = 1;
          }
          break;

        case "p2_":
          if(!isDefined(level.completed_dialogues["trustksmith_41_1"])) {
            var_2 thread scripts\cp\cp_vo::try_to_play_vo("trustksmith_41_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["trustksmith_41_1"] = 1;
          }
          break;

        default:
          break;
      }

      return;
    }

    return;
  }
}

rave_precache() {
  precachempanim("IW7_cp_wyler_afterlife_idle_01");
  precachempanim("IW7_cp_wyler_afterlife_idle_02");
  precachempanim("IW7_cp_wyler_afterlife_idle_03");
  precachempanim("IW7_cp_wyler_afterlife_idle_04");
  precachempanim("IW7_cp_wyler_afterlife_idle_05");
  precachempanim("IW7_cp_wyler_afterlife_idle_06");
  precachempanim("IW7_cp_wyler_afterlife_idle_07");
  precachempanim("IW7_cp_wyler_afterlife_idle_08");
  precachempanim("IW7_cp_wyler_afterlife_idle_09");
  precachempanim("IW7_cp_wyler_afterlife_idle_10");
  precachempanim("IW7_cp_survivor_cabin_idle_01");
  precachempanim("IW7_cp_survivor_cabin_idle_02");
  precachempanim("IW7_cp_slasher_walk_forward_01");
  precachempanim("IW7_cp_survivor_boat_idle");
  precachempanim("IW7_cp_survivor_boat_fall");
  precachempanim("IW7_cp_super_taunt_intro");
  precachempanim("IW7_cp_log_swing");
  scripts\engine\utility::flag_init("survivor_released");
  scripts\engine\utility::flag_init("survivor_trapped");
}

setup_pa_speakers() {
  level.jukebox_table = "cp\zombies\cp_rave_music_genre.csv";
  scripts\cp\zombies\zombie_jukebox::parse_music_genre_table();
  wait(1.15);
  disablepaspeaker("pa_speaker_stage");
  disablepaspeaker("pa_speaker_stage_2");
  disablepaspeaker("pa_speaker_path");
  disablepaspeaker("pa_super_slasher");
  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start((1785, -2077, 211));
  level thread wait_for_intro_complete();
}

wait_for_intro_complete() {
  level waittill("start_pa_music");
  wait(5);
  level thread enableparkpas();
  level notify("jukebox_start");
}

enableparkpas() {
  enablepaspeaker("pa_speaker_stage");
}

disable_rave_speakers() {
  scripts\engine\utility::flag_set("jukebox_paused");
  level notify("skip_song");
}

reenable_rave_speakers() {
  scripts\engine\utility::flag_clear("jukebox_paused");
}

init_rave_quests() {
  init_statue_quest_flags();
  level.animal_statue_kills = [];
  level.animal_statue_kills["owl"] = 0;
  level.animal_statue_kills["wolf"] = 0;
  level.animal_statue_kills["eagle"] = 0;
  level.animal_statue_kills["deer"] = 0;
  level.animal_statue_weapons["owl"] = "iw7_harpoon1_zm";
  level.animal_statue_weapons["wolf"] = "iw7_harpoon2_zm";
  level.animal_statue_weapons["eagle"] = "iw7_harpoon3_zm+akimbo";
  level.animal_statue_weapons["deer"] = "iw7_harpoon4_zm";
  level.animal_quest_volume = getent("animal_statues", "targetname");
  scripts\engine\utility::flag_set("harpoon_upgrade_quest_active");
  level.rave_mode_activation_funcs = [];
  level.normal_mode_activation_funcs = [];
  spawn_missing_structs();
  move_struct((-1564.6, 2717.8, 31.3), (-1512.72, 2658.01, 22.7251), (15.5464, 277.396, 2.43727));
  move_struct((-3469.5, 48.5, -134.3), (-3385.7, 9.75768, -141.774), (0.443953, 293.884, -4.28248));
  move_struct((-619.3, -1932.8, 71.5), (-97.8, -3285.9, 171.5), (0, 350, 0));
  move_struct((-556.5, -1731.6, 123), (-551.5, -1725.6, 112.5), (82.1009, 226.684, 176.654));
  move_struct((-3698.4, -2852.9, 148), (-3737.24, -417.519, -52.3413), (356.817, 0.973019, -16.0763));
  move_struct((-1914.5, -4326.5, 290.1), (-2563.72, -1217.02, -24.1897), (15.7054, 6.89507, 18.1345));
  move_struct((-2254.8, -5120.2, 359.9), (-2059.06, 1297.45, -155.511), (357.057, 358.937, 8.51935));
  move_struct((-3036, 481.7, -77.3), (-3082, 580.7, -77.3), (0, 116.2, 0));
  add_additional_fix_pap_structs();
  var_0 = scripts\engine\utility::getstructarray("animal_statue_toys", "script_noteworthy");
  var_0 = scripts\engine\utility::array_randomize_objects(var_0);
  foreach(var_2 in var_0) {
    var_2 thread delay_remove_from_interactions(var_2);
  }

  var_4 = ["wolf", "eagle", "deer", "owl"];
  var_4 = scripts\engine\utility::array_randomize_objects(var_4);
  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_0[var_5] thread delay_add_to_interactions(var_0[var_5]);
    thread setup_statue_toy(var_0[var_5], var_4[var_5]);
  }
}

spawn_missing_structs(var_0, var_1) {
  var_2 = [(-5840.6, 4469.1, 140), (-5832.4, 4364.8, 140), (-5953.2, 4358.7, 140), (-5950.4, 4467.2, 140), (-6081.5, 5111.1, 148)];
  var_3 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 102, 0)];
  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = spawnStruct();
    var_5.origin = var_2[var_4];
    var_5.angles = var_3[var_4];
    var_5.groupname = "1";
    var_5.fgetarg = 21;
    var_5.script_noteworthy = "ritual_stone";
    var_5.var_336 = "interaction";
    var_5.requires_power = 0;
    var_5.powered_on = 1;
    var_5.script_parameters = "default";
    thread delay_add_to_interactions(var_5);
  }

  var_6 = [(-6090.2, 5151.6, 138), (-5898.1, 4410.2, 140)];
  var_7 = [(0, 0, 0), (0, 0, 0)];
  for(var_4 = 0; var_4 < var_6.size; var_4++) {
    var_5 = spawnStruct();
    var_5.origin = var_6[var_4];
    var_5.angles = var_7[var_4];
    var_5.groupname = "1";
    var_5.fgetarg = 200;
    var_5.var_336 = "rave_fx";
    level.struct_class_names["targetname"]["rave_fx"][level.struct_class_names["targetname"]["rave_fx"].size] = var_5;
  }
}

add_additional_fix_pap_structs() {
  var_0 = [(-6094.4, 4860.3, 143), (-6147.6, 4849.7, 143)];
  var_1 = [(0, 196, 0), (0, 16.5, 0)];
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = spawnStruct();
    var_3.origin = var_0[var_2];
    var_3.angles = var_1[var_2];
    var_3.var_336 = "interaction";
    var_3.script_noteworthy = "fix_pap";
    var_3.requires_power = 0;
    var_3.powered_on = 1;
    var_3.script_parameters = "default";
    thread delay_add_to_interactions(var_3);
    var_3 thread remove_struct_when_machine_fixed(var_3);
  }
}

remove_struct_when_machine_fixed(var_0) {
  level endon("game_ended");
  scripts\engine\utility::flag_init("pap_fixed");
  scripts\engine\utility::flag_wait("pap_fixed");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

init_statue_quest_flags() {
  scripts\engine\utility::flag_init("harpoon_upgrade_quest_active");
  scripts\engine\utility::flag_init("owl_quest_completed");
  scripts\engine\utility::flag_init("wolf_quest_completed");
  scripts\engine\utility::flag_init("eagle_quest_completed");
  scripts\engine\utility::flag_init("deer_quest_completed");
  scripts\engine\utility::flag_init("owl_toy_found");
  scripts\engine\utility::flag_init("wolf_toy_found");
  scripts\engine\utility::flag_init("eagle_toy_found");
  scripts\engine\utility::flag_init("deer_toy_found");
  scripts\engine\utility::flag_init("owl_toy_charged");
  scripts\engine\utility::flag_init("wolf_toy_charged");
  scripts\engine\utility::flag_init("eagle_toy_charged");
  scripts\engine\utility::flag_init("deer_toy_charged");
  scripts\engine\utility::flag_init("owl_toy_placed");
  scripts\engine\utility::flag_init("wolf_toy_placed");
  scripts\engine\utility::flag_init("eagle_toy_placed");
  scripts\engine\utility::flag_init("deer_toy_placed");
}

setup_statue_toy(var_0, var_1) {
  wait(0.25);
  var_0.groupname = "locOverride";
  var_0.model = spawn("script_model", var_0.origin);
  var_0.model setModel("tag_origin_toy_statues");
  var_0.model.angles = var_0.angles;
  var_0.model setscriptablepartstate("toy_model", var_1);
  var_0.animal_type = var_1;
}

use_toy_animal_statue(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.model setscriptablepartstate("events", "pickup");
  var_0.model setscriptablepartstate("toy_model", "neutral");
  var_0.model thread cleanup_model_after_time(var_0);
  switch (var_0.animal_type) {
    case "wolf":
      scripts\engine\utility::flag_set("wolf_toy_found");
      level scripts\cp\utility::set_quest_icon(17);
      break;

    case "owl":
      scripts\engine\utility::flag_set("owl_toy_found");
      level scripts\cp\utility::set_quest_icon(16);
      break;

    case "deer":
      scripts\engine\utility::flag_set("deer_toy_found");
      level scripts\cp\utility::set_quest_icon(2);
      break;

    case "eagle":
      scripts\engine\utility::flag_set("eagle_toy_found");
      level scripts\cp\utility::set_quest_icon(5);
      break;
  }
}

cleanup_model_after_time(var_0) {
  wait(1);
  if(isDefined(var_0.model)) {
    var_0.model delete();
  }
}

toy_animal_statue_hint_func(var_0, var_1) {
  return &"CP_RAVE_PICKUP_ITEM";
}

harpoon_upgrade_quest() {
  scripts\engine\utility::flag_wait("owl_quest_completed");
  scripts\engine\utility::flag_wait("wolf_quest_completed");
  scripts\engine\utility::flag_wait("eagle_quest_completed");
  scripts\engine\utility::flag_wait("deer_quest_completed");
  level scripts\cp\utility::set_completed_quest_mark(2);
}

toy_charging_hint_func(var_0, var_1) {
  var_2 = ["wolf", "owl", "deer", "eagle"];
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(scripts\engine\utility::flag(var_2[var_3] + "_toy_found") && !scripts\engine\utility::flag(var_2[var_3] + "_toy_placed") && !scripts\engine\utility::flag(var_2[var_3] + "_toy_charged")) {
      return &"CP_RAVE_PLACE_ITEM";
    }

    if(isDefined(var_0.current_statue) && scripts\engine\utility::flag(var_2[var_3] + "_toy_placed") && scripts\engine\utility::flag(var_2[var_3] + "_toy_charged")) {
      return &"CP_RAVE_PICKUP_ITEM";
    }
  }

  return "";
}

toy_charging_use_func(var_0, var_1) {
  var_2 = scripts\engine\utility::array_randomize_objects(["wolf", "owl", "deer", "eagle"]);
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(scripts\engine\utility::flag(var_2[var_3] + "_quest_completed")) {
      continue;
    }

    if(isDefined(var_0.current_statue) && scripts\engine\utility::flag(var_2[var_3] + "_toy_charged") && scripts\engine\utility::flag(var_2[var_3] + "_toy_placed")) {
      var_0.model thread cleanup_toy(var_0);
      var_0.current_statue = undefined;
      if(scripts\engine\utility::istrue(var_0.has_statue_equipped)) {
        var_0.has_statue_equipped = undefined;
      }

      scripts\engine\utility::flag_clear(var_2[var_3] + "_toy_placed");
      scripts\engine\utility::flag_set(var_2[var_3] + "_toy_found");
      return;
    } else if(scripts\engine\utility::flag(var_2[var_3] + "_toy_found") && !scripts\engine\utility::flag(var_2[var_3] + "_toy_placed") && !scripts\engine\utility::flag(var_2[var_3] + "_toy_charged")) {
      if(scripts\engine\utility::istrue(var_0.has_statue_equipped)) {
        return;
      }

      scripts\engine\utility::flag_set(var_2[var_3] + "_toy_placed");
      scripts\engine\utility::flag_clear(var_2[var_3] + "_toy_found");
      var_0.current_statue = var_2[var_3];
      thread run_charge_toy_statue_quest(var_0);
      return;
    }
  }
}

toy_statue_end_pos_hint_func(var_0, var_1) {
  if(!scripts\engine\utility::flag(var_0.name + "_toy_found") || !scripts\engine\utility::flag(var_0.name + "_toy_charged")) {
    return "";
  }

  if(!scripts\engine\utility::flag(var_0.name + "_toy_placed")) {
    return &"CP_RAVE_PLACE_ITEM";
  }

  if(scripts\engine\utility::flag(var_0.name + "_quest_completed")) {
    return &"CP_RAVE_PICKUP_ITEM";
  }

  return "";
}

run_charge_toy_statue_quest(var_0) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2.angles = var_1.angles;
  var_2 setModel("tag_origin_toy_statues");
  var_2 setscriptablepartstate("events", "place");
  var_2 setscriptablepartstate("toy_model", var_0.current_statue);
  var_0.model = var_2;
  thread setup_b_bman_quest(var_0);
  var_0 wait_for_charge_complete(var_0);
  var_0.has_statue_equipped = 1;
  scripts\engine\utility::flag_set(var_0.current_statue + "_toy_charged");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

setup_b_bman_quest(var_0) {
  if(!isDefined(level.head.setculldist)) {
    level.head.setculldist = [];
  }

  if(!isDefined(level.head.statues)) {
    level.head.statues = [];
  }

  level.head.statues[level.head.statues.size] = var_0;
  if(!isDefined(level.head.setculldist[var_0.current_statue])) {
    level.head.setculldist[var_0.current_statue] = 0;
  }
}

b_man_head_tracking() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  level endon("all_statues_charged");
  var_0 = getent("b_man_head", "targetname");
  var_0.og_angles = var_0.angles;
  var_0.og_origin = var_0.origin;
  level.head = var_0;
  level.head_statues_charged = 0;
  var_0 thread watch_zombie_health();
  var_1 = -40;
  var_2 = 180;
  var_3 = 0;
  var_4 = undefined;
  var_5 = (1879, -2702, 0);
  var_6 = (1660, -1825, 128);
  var_7 = (2291, -1800, 0);
  var_8 = (2284, -2407, 128);
  for(;;) {
    var_9 = 0;
    var_10 = undefined;
    var_11 = var_0 get_valid_statue_enemy(var_5, var_6, var_7, var_8);
    if(var_11.size < 1) {
      var_12 = sortbydistance(level.players, var_0.og_origin);
      var_13 = 0;
      foreach(var_15 in var_12) {
        if(scripts\cp\maps\cp_rave\cp_rave_memory_quests::is_in_box(var_5, var_6, var_7, var_8, var_15.origin)) {
          var_4 = var_15.origin;
          var_13 = 1;
          break;
        }
      }

      if(!var_13) {
        var_4 = undefined;
      }
    } else if(var_11.size >= 1) {
      var_4 = var_11[0].origin;
      foreach(var_12 in var_11) {
        if(var_12.health < 0.4 * var_12.maxhealth) {
          var_10 = var_12;
          var_4 = var_12.origin;
          break;
        }
      }
    } else {
      var_4 = undefined;
    }

    if(isDefined(var_4)) {
      var_0 rotateto(vectortoangles(var_4 - var_0.og_origin) + (var_1, var_2, var_3), 0.25);
      wait(0.25);
      if(isDefined(var_10)) {
        var_0 laser_eye_kill_target(var_10);
      }

      continue;
    }

    var_0 rotateto(var_0.og_angles, 0.25);
    wait(0.25);
  }
}

watch_zombie_health() {
  level endon("game_ended");
  level endon("all_statues_charged");
  var_0 = (1879, -2702, 0);
  var_1 = (1660, -1825, 128);
  var_2 = (2291, -1800, 0);
  var_3 = (2284, -2407, 128);
  for(;;) {
    var_4 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_5 = scripts\engine\utility::get_array_of_closest(self.origin, var_4, undefined, 24, 1000, 1);
    foreach(var_7 in var_4) {
      if(isDefined(var_7.agent_type) && var_7.agent_type == "superslasher" || var_7.agent_type == "slasher" || var_7.agent_type == "zombie_ghost") {
        continue;
      }

      if(scripts\cp\maps\cp_rave\cp_rave_memory_quests::is_in_box(var_0, var_1, var_2, var_3, var_7.origin)) {
        if(var_7.health <= 0.4 * var_7.maxhealth) {
          var_7 setscriptablepartstate("eyes", "red_eyes");
        }

        continue;
      }

      if(!scripts\engine\utility::istrue(var_7.is_skeleton)) {
        var_7 setscriptablepartstate("eyes", "yellow_eyes");
      }
    }

    wait(0.5);
  }
}

laser_eye_kill_target(var_0) {
  var_0.atomize_me = 1;
  if(isalive(var_0) && var_0.health >= 1) {
    var_0 dodamage(var_0.health + 1000, self.origin, self, self, "MOD_RIFLE_BULLET");
    foreach(var_2 in level.head.statues) {
      self.setculldist[var_2.current_statue]++;
      if(self.setculldist[var_2.current_statue] >= 10) {
        if(scripts\engine\utility::array_contains(level.head.statues, var_2)) {
          level.head.statues = scripts\engine\utility::array_remove(level.head.statues, var_2);
        }

        level notify(var_2.current_statue + "_statue_charged");
        level.head_statues_charged++;
        playsoundatpos(var_2.origin, "zmb_quest_complete");
      }
    }

    if(level.head_statues_charged >= 4) {
      level notify("all_statues_charged");
      self rotateto(self.og_angles, 0.25);
    }
  }
}

get_valid_statue_enemy(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.head.statues) || level.head.statues.size < 1) {
    return [];
  }

  var_4 = 24;
  var_5 = 2000;
  var_6 = cos(45);
  var_7 = [];
  var_8 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_9 = scripts\engine\utility::get_array_of_closest(self.origin, var_8, undefined, 24, var_5, 1);
  foreach(var_11 in var_9) {
    if(scripts\engine\utility::istrue(var_11.died_poorly)) {
      continue;
    }

    var_12 = 0;
    var_13 = var_11.origin;
    var_14 = scripts\cp\maps\cp_rave\cp_rave_memory_quests::is_in_box(var_0, var_1, var_2, var_3, var_11.origin);
    if(var_14) {
      var_12 = 1;
    }

    if(var_12 && var_7.size < var_4) {
      var_7[var_7.size] = var_11;
    }
  }

  return var_7;
}

wait_for_charge_complete(var_0) {
  level endon("gamed_ended");
  level waittill(var_0.current_statue + "_statue_charged");
}

disable_all_similar_interactions(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0.script_noteworthy, "script_noteworthy");
  foreach(var_3 in var_1) {
    if(isDefined(var_3.name) && var_3.name == var_0.name) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
    }
  }
}

toy_animal_statue_end_pos(var_0, var_1) {
  if(!scripts\engine\utility::flag(var_0.name + "_toy_found") || !scripts\engine\utility::flag(var_0.name + "_toy_charged")) {
    return;
  }

  if(scripts\engine\utility::flag(var_0.name + "_quest_completed")) {
    var_2 = 0;
    foreach(var_4 in level.players) {
      var_4 thread scripts\cp\cp_interaction::refresh_interaction();
    }

    foreach(var_7 in var_1 getweaponslistall()) {
      if(issubstr(var_7, "harpoon_")) {
        var_1 takeweapon(var_7);
        var_2 = 1;
      }
    }

    if(var_2) {
      thread disable_all_similar_interactions(var_0);
      var_1 scripts\cp\utility::_giveweapon(level.animal_statue_weapons[var_0.name], undefined, undefined, 0);
      var_1 notify("harpoon_quest_completed", level.animal_statue_weapons[var_0.name]);
      var_1 switchtoweapon(level.animal_statue_weapons[var_0.name]);
      var_9 = scripts\engine\utility::getstructarray("animal_statue_end_pos", "script_noteworthy");
      foreach(var_11 in var_9) {
        if(var_11.name != var_0.name) {
          continue;
        }

        if(isDefined(var_11.model)) {
          var_11.model thread cleanup_toy(var_11);
        }
      }

      return;
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    return;
  }

  if(!scripts\engine\utility::flag(var_0.name + "_toy_placed")) {
    scripts\engine\utility::flag_set(var_0.name + "_toy_placed");
    var_9 = scripts\engine\utility::getstructarray("animal_statue_end_pos", "script_noteworthy");
    var_13 = [];
    foreach(var_11 in var_9) {
      if(var_11.name != var_0.name) {
        continue;
      } else {
        var_15 = spawn("script_model", var_11.origin);
        var_15.angles = var_11.angles;
        var_15 setModel("tag_origin_toy_statues");
        var_15 setscriptablepartstate("events", "place");
        var_15 setscriptablepartstate("toy_model", var_0.name);
        var_11.model = var_15;
        var_13[var_13.size] = var_11.model;
      }
    }

    var_0 thread watch_for_quest_complete(var_0);
    foreach(var_1 in level.players) {
      var_1 thread watch_for_kills_with_correct_weapon(var_0, var_1, var_13);
    }
  }
}

watch_for_kills_with_correct_weapon(var_0, var_1, var_2) {
  level endon("game_ended");
  var_1 endon("disconnect");
  level endon(var_0.name + "_quest_completed");
  var_3 = 562500;
  for(;;) {
    var_1 waittill("zombie_killed", var_4, var_5, var_6, var_7);
    var_8 = getweaponbasename(var_6);
    if(var_8 == "iw7_harpoon_zm") {
      foreach(var_10 in var_2) {
        if(distancesquared(var_1.origin, var_10.origin) <= 562500) {
          level.animal_statue_kills[var_0.name]++;
          break;
        }
      }

      if(level.animal_statue_kills[var_0.name] >= 20) {
        break;
      }
    }
  }

  scripts\engine\utility::flag_set(var_0.name + "_quest_completed");
}

watch_for_quest_complete(var_0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait(var_0.name + "_quest_completed");
  level notify(var_0.name + "_quest_completed");
}

cleanup_toy(var_0) {
  level endon("game_ended");
  var_0.model setscriptablepartstate("events", "pickup");
  var_0.model setscriptablepartstate("toy_model", "neutral");
  wait(1);
  var_0.model delete();
}

waitforplayerinput(var_0, var_1) {
  level endon("game_ended");
  var_2 = "WaitForPlayerInput" + var_0;
  self notifyonplayercommand(var_2, var_0);
  for(;;) {
    self waittill(var_2);
    thread[[var_1]]();
  }
}

rave_processenemykilledfunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isplayer(var_1) && !scripts\engine\utility::istrue(var_1.has_rave_dust) && !isDefined(var_1.rave_dust_pouch)) {
    if((isDefined(var_1.setculldist) && var_1.setculldist % 20 == 0) || scripts\engine\utility::istrue(var_1.should_drop_pouch)) {
      var_1.should_drop_pouch = 1;
      var_10 = getclosestpointonnavmesh(var_9);
      if(!scripts\cp\loot::is_in_active_volume(var_10)) {
        return;
      }

      if(isDefined(var_1.rave_dust_pouch)) {
        var_1.rave_dust_pouch delete();
      }

      var_1.rave_dust_pouch = spawn("script_model", var_10 + (0, 0, 40));
      var_1.rave_dust_pouch setModel("zmb_pouch");
      foreach(var_12 in level.players) {
        if(var_12 == var_1) {
          var_1.rave_dust_pouch showtoplayer(var_12);
          continue;
        }

        var_1.rave_dust_pouch hidefromplayer(var_12);
      }

      level thread show_rave_dust_pickup(var_1, var_1.rave_dust_pouch);
      level thread wait_dust_pickup(var_1, var_1.rave_dust_pouch);
      level thread destroy_rave_dust_on_player_disconnect(var_1, var_1.rave_dust_pouch);
      return;
    }
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

init_weapon_change_funcs() {
  level.weapon_change_func = [];
  level.weapon_change_func["iw7_two_headed_axe_mp"] = ::axe_fl;
  level.weapon_change_func["iw7_machete_mp"] = ::machete_fl;
  level.weapon_change_func["iw7_spiked_bat_mp"] = ::bat_fl;
  level.weapon_change_func["iw7_slasher_zm"] = ::use_slasher_saw;
  level.weapon_change_func["iw7_lawnmower_zm"] = ::use_lawn_mower;
  level.weapon_change_func["iw7_golf_club_mp"] = ::golf_fl;
}

use_lawn_mower(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
  var_0 thread unset_mower(var_0);
  var_0 setscriptablepartstate("mower", "activated");
  for(;;) {
    if(var_0 adsbuttonpressed(1)) {
      var_0 allowfire(0);
      var_0 mower_gesture(var_0);
    }

    var_0 allowfire(1);
    wait(0.25);
  }
}

unset_mower(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("weapon_change");
  var_0 allowfire(1);
  var_0 stopgestureviewmodel("ges_mower_melee", 0, 0);
  var_0 notify("stop_lawn_mower_attack_logic");
  var_0 setscriptablepartstate("mower", "neutral");
}

mower_gesture(var_0) {
  var_0 endon("disconnect");
  var_0 forceplaygestureviewmodel("ges_mower_melee", undefined, 1, undefined, 1, 1);
  var_0 thread run_lawn_mower_logic(var_0);
  while(var_0 adsbuttonpressed(1) && var_0 isgestureplaying("ges_mower_melee")) {
    scripts\engine\utility::waitframe();
  }

  var_0 stopgestureviewmodel("ges_mower_melee", 0.5, 0);
  var_0 notify("stop_lawn_mower_attack_logic");
}

run_lawn_mower_logic(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
  var_0 endon("stop_lawn_mower_attack_logic");
  var_1 = 64;
  while(var_0 adsbuttonpressed(1) && var_0 isgestureplaying("ges_mower_melee")) {
    wait(1);
  }
}

use_slasher_saw(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
  var_0 setscriptablepartstate("slasher_saw_sound", "first_pull_out");
  var_0 thread unset_saw(var_0);
  var_1 = 0;
  for(;;) {
    var_1 = var_0 getweaponammoclip("iw7_slasher_zm") + var_0 getweaponammostock("iw7_slasher_zm");
    if(var_1 > 0 && var_0 adsbuttonpressed(1) && !var_0 secondaryoffhandbuttonpressed() && !var_0 isthrowinggrenade() && !var_0 fragbuttonpressed()) {
      var_0 getraidspawnpoint();
      var_0 allowfire(0);
      var_0 thread watch_for_player_attack(var_0);
      var_0 thread run_slasher_saw_logic(var_0);
      var_0 slasher_gesture(var_0);
    }

    if(!scripts\engine\utility::istrue(var_0.playing_ghosts_n_skulls)) {
      var_0 enableweaponswitch();
    }

    var_0 allowfire(1);
    wait(0.1);
  }
}

slasher_gesture(var_0) {
  var_0 endon("disconnect");
  var_0 forceplaygestureviewmodel("ges_slasher_charge", undefined, 1, undefined, 1, 1);
  var_0 setscriptablepartstate("slasher_saw_sound", "idle_high");
  var_0 setscriptablepartstate("slasher_weapon", "active");
  while(var_0 adsbuttonpressed(1) && var_0 isgestureplaying("ges_slasher_charge") || var_0 isgestureplaying("ges_slasher_charge_hit")) {
    var_1 = var_0 getweaponammoclip("iw7_slasher_zm") + var_0 getweaponammostock("iw7_slasher_zm");
    if(var_1 < 1) {
      break;
    }

    wait(0.1);
    if(scripts\engine\utility::istrue(var_0.should_lunge)) {
      var_0 forceplaygestureviewmodel("ges_slasher_charge_hit", undefined, 0.8, undefined, 1, 1);
      wait(0.8);
      var_0 forceplaygestureviewmodel("ges_slasher_charge", undefined, 1, undefined, 1, 0);
      var_0.should_lunge = undefined;
    }
  }

  var_0 setscriptablepartstate("slasher_saw_sound", "idle");
  var_0 setscriptablepartstate("slasher_weapon", "neutral");
  var_0 stopgestureviewmodel("ges_slasher_charge_hit", 0, 0);
  var_0 stopgestureviewmodel("ges_slasher_charge", 1, 0);
  var_0 notify("stop_slasher_saw_attack_logic");
  while(var_0 isgestureplaying("ges_slasher_charge") || var_0 isgestureplaying("ges_slasher_charge_hit")) {
    scripts\engine\utility::waitframe();
  }
}

unset_saw(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("weapon_change");
  var_0 allowfire(1);
  if(!scripts\engine\utility::istrue(var_0.playing_ghosts_n_skulls)) {
    var_0 enableweaponswitch();
  }

  var_0 setscriptablepartstate("slasher_weapon", "neutral");
  var_0 setscriptablepartstate("slasher_saw_sound", "neutral");
  var_0 stopgestureviewmodel("ges_slasher_charge_hit", 0, 0);
  var_0 stopgestureviewmodel("ges_slasher_charge", 0, 0);
  var_0 notify("stop_slasher_saw_attack_logic");
}

watch_for_player_attack(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
  var_0 endon("stop_slasher_saw_attack_logic");
  var_0 notifyonplayercommand("lunge_weapon", "+attack");
  var_0 notifyonplayercommand("lunge_weapon", "+attack_akimbo_accessible");
  while(var_0 adsbuttonpressed(1) && var_0 isgestureplaying("ges_slasher_charge")) {
    var_0 waittill("lunge_weapon");
    var_0 notify("slasher_weapon_hit_zombie");
    var_0.should_lunge = 1;
    wait(1);
  }
}

run_slasher_saw_logic(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
  var_0 endon("stop_slasher_saw_attack_logic");
  var_1 = 64;
  for(var_2 = 0; var_0 adsbuttonpressed(1); var_2 = 0) {
    var_3 = checkenemiesinfov(35, var_1, 5);
    foreach(var_5 in var_3) {
      if(isDefined(var_5.agent_type) && var_5.agent_type == "superslasher") {
        continue;
      }

      if(!scripts\engine\utility::istrue(var_0.slasher_screen_blood)) {
        var_0 thread screen_blood(var_0);
      }

      var_2 = 1;
      var_5.full_gib = 1;
      var_5 dodamage(var_5.maxhealth, var_0.origin, var_0, var_0, "MOD_MELEE", "iw7_slasher_zm");
    }

    if(isDefined(var_3) && var_3.size > 0) {
      var_0.should_lunge = 1;
    }

    if(var_2) {
      var_0 setweaponammoclip("iw7_slasher_zm", 0);
      var_0 notify("weapon_fired", "iw7_slasher_zm");
    }

    var_7 = var_0 scripts\engine\utility::waittill_any_timeout(0.1, "slasher_weapon_hit_zombie");
    if(isDefined(var_7) && var_7 == "slasher_weapon_hit_zombie") {
      var_1 = 80;
      continue;
    }

    var_1 = 64;
  }
}

screen_blood(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0.slasher_screen_blood = 1;
  var_0 setscriptablepartstate("screen_effects", "slasher_blood");
  wait(0.5);
  var_0.slasher_screen_blood = undefined;
}

axe_fl(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
  var_0 notifyonplayercommand("flourish", "+usereload");
  var_0 notifyonplayercommand("flourish", "+activate");
  var_0 thread watchplayermelee(var_0, "melee_weapon", "two_headed_axe");
  for(;;) {
    var_0 waittill("flourish");
    var_1 = var_0 scripts\engine\utility::waittill_any_timeout(0.25, "flourish");
    if(!isDefined(var_1) || var_1 != "flourish") {
      continue;
    }

    if(var_0 scripts\cp\utility::is_valid_player()) {
      var_0 setweaponammostock("two_headed_axe_flourish", 1);
      var_0 giveandfireoffhand("two_headed_axe_flourish");
      waittillgesturefinished(var_0);
    }
  }
}

golf_fl(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
  var_0 notifyonplayercommand("flourish", "+usereload");
  var_0 notifyonplayercommand("flourish", "+activate");
  var_0 thread watchplayermelee(var_0, "melee_weapon", "golf_club");
  for(;;) {
    var_0 waittill("flourish");
    var_1 = var_0 scripts\engine\utility::waittill_any_timeout(0.25, "flourish");
    if(!isDefined(var_1) || var_1 != "flourish") {
      continue;
    }

    if(var_0 scripts\cp\utility::is_valid_player()) {
      var_0 setweaponammostock("golf_club_flourish", 1);
      var_0 giveandfireoffhand("golf_club_flourish");
      waittillgesturefinished(var_0);
    }
  }
}

bat_fl(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
  var_0 notifyonplayercommand("flourish", "+usereload");
  var_0 notifyonplayercommand("flourish", "+activate");
  var_0 thread watchplayermelee(var_0, "melee_weapon", "spiked_bat");
  for(;;) {
    var_0 waittill("flourish");
    var_1 = var_0 scripts\engine\utility::waittill_any_timeout(0.25, "flourish");
    if(!isDefined(var_1) || var_1 != "flourish") {
      continue;
    }

    if(var_0 scripts\cp\utility::is_valid_player()) {
      var_0 setweaponammostock("spiked_bat_flourish", 1);
      var_0 giveandfireoffhand("spiked_bat_flourish");
      waittillgesturefinished(var_0);
    }
  }
}

machete_fl(var_0) {
  level endon("game_ended");
  var_0 endon("weapon_change");
  var_0 endon("disconnect");
  var_0 notifyonplayercommand("flourish", "+usereload");
  var_0 notifyonplayercommand("flourish", "+activate");
  var_0 thread watchplayermelee(var_0, "melee_weapon", "machete");
  for(;;) {
    var_0 waittill("flourish");
    var_1 = var_0 scripts\engine\utility::waittill_any_timeout(0.25, "flourish");
    if(!isDefined(var_1) || var_1 != "flourish") {
      continue;
    }

    if(var_0 scripts\cp\utility::is_valid_player()) {
      var_0 setweaponammostock("machete_flourish", 1);
      var_0 giveandfireoffhand("machete_flourish");
      waittillgesturefinished(var_0);
    }
  }
}

set_melee_scriptable_state(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 notify("set_melee_scriptable_state");
  var_0 endon("set_melee_scriptable_state");
  var_0 endon("disconnect");
  var_0 setscriptablepartstate(var_1, var_2);
  var_0 scripts\engine\utility::waittill_any_in_array_or_timeout_no_endon_death(["death", "weapon_change"], 5);
  var_0 setscriptablepartstate(var_1, "neutral");
}

waittillgesturefinished(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  while(var_0 isgestureplaying()) {
    wait(0.1);
  }
}

watchplayermelee(var_0, var_1, var_2) {
  self notify("watchPlayerMelee");
  self endon("watchPlayerMelee");
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  for(;;) {
    self waittill("melee_weapon_hit", var_3);
    var_0 thread set_melee_scriptable_state(var_0, var_1, var_2);
  }
}

spawn_initial_rave_pouch() {
  scripts\engine\utility::flag_wait("init_interaction_done");
  var_0 = scripts\engine\utility::getstruct("ritual_pouch", "targetname");
  var_0.origin = scripts\engine\utility::drop_to_ground((-682, -1621, 252), 12, -200);
  foreach(var_2 in level.players) {
    var_2.rave_dust_pouch = spawn("script_model", var_0.origin + (0, 0, 40));
    var_2.rave_dust_pouch setModel("zmb_pouch");
    foreach(var_4 in level.players) {
      if(var_4 == var_2) {
        var_2.rave_dust_pouch showtoplayer(var_4);
        continue;
      }

      var_2.rave_dust_pouch hidefromplayer(var_4);
    }

    level thread dust_initial_pickup(var_2, var_2.rave_dust_pouch);
    level thread wait_dust_pickup(var_2, var_2.rave_dust_pouch);
    level thread destroy_rave_dust_on_player_disconnect(var_2, var_2.rave_dust_pouch);
  }
}

wait_dust_pickup(var_0, var_1) {
  var_1 endon("death");
  var_0 endon("disconnect");
  for(;;) {
    if(distancesquared(var_0.origin + (0, 0, 40), var_1.origin) < 2304) {
      break;
    }

    wait(0.1);
  }

  playsoundatpos(var_1.origin, "zmb_dust_pickup");
  playFX(level._effect["souvenir_pickup"], var_1.origin);
  var_0.has_rave_dust = 1;
  var_0 setclientomnvar("zm_hud_inventory_2", 1);
  var_0.should_drop_pouch = undefined;
  var_1 delete();
}

dust_initial_pickup(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_1 endon("timeout");
  var_2 = 0;
  for(;;) {
    if(var_2 == 0) {
      var_1 rotateyaw(360, 2);
      var_1 movez(5, 2);
    }

    if(var_2 == 2) {
      var_1 rotateyaw(360, 2);
      var_1 movez(-5, 2);
    }

    if(var_2 == 4) {
      var_2 = 0;
      continue;
    }

    wait(1);
    var_2++;
  }

  if(isDefined(var_1)) {
    playsoundatpos(var_1.origin, "zmb_dust_pickup");
    playFX(level._effect["souvenir_pickup"], var_1.origin);
    var_1 delete();
  }
}

show_rave_dust_pickup(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("timeout");
  var_2 = 25;
  var_3 = gettime() + var_2 * 1000;
  var_4 = 0;
  for(var_5 = 0; gettime() < var_3; var_5++) {
    if(var_5 == 0) {
      var_1 rotateyaw(360, 2);
      var_1 movez(5, 2);
    }

    if(var_5 == 2) {
      var_1 rotateyaw(360, 2);
      var_1 movez(-5, 2);
    }

    if(var_5 == 4) {
      var_5 = 0;
      continue;
    }

    wait(1);
  }

  playsoundatpos(var_1.origin, "zmb_dust_pickup");
  playFX(level._effect["souvenir_pickup"], var_1.origin);
  var_1 delete();
}

destroy_rave_dust_on_player_disconnect(var_0, var_1) {
  var_1 endon("death");
  var_0 waittill("disconnect");
  if(isDefined(var_1)) {
    var_1 delete();
  }
}

log_swing_trap() {
  var_0 = getent("log_swing_rope", "targetname");
  var_1 = getent("log_swing_log", "targetname");
  var_1 linkto(var_0);
  wait(5);
  for(;;) {
    var_0 rotatepitch(110, 1);
    var_0 waittill("rotatedone");
    var_0 rotatepitch(-110, 1);
    var_0 waittill("rotatedone");
    wait(10);
  }
}

registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("mp\dlc1_agent_definition.csv");
  scripts\mp\agents\zombie_dlc1\zombie_dlc1_agent::registerscriptedagent();
  scripts\mp\agents\lumberjack\lumberjack_agent::registerscriptedagent();
  scripts\mp\agents\zombie_sasquatch\zombie_sasquatch_agent::registerscriptedagent();
  scripts\mp\agents\superslasher\superslasher_agent::registerscriptedagent();
  scripts\mp\agents\slasher\slasher_agent::registerscriptedagent();
  scripts\mp\agents\zombie_skeleton\zombie_skeleton::zombie_skeleton_init();
  setupslasherteleportpoints();
}

setupslasherteleportpoints() {
  level.slasherteleportpoints = [];
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-974.128, -1653.25, 229.322);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-237.696, -1333.41, 225.117);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1713.42, -2036.45, 69.5272);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2679.01, -2930.95, 150.04);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3074.45, -3063.72, 150.059);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3333.1, -2468.59, 152.189);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3552.75, -2211.7, 114.532);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3937.56, -3210.75, 301.126);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3551.87, -4254.81, 211.927);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2240.87, -4400.34, 257.723);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3673.82, -4371.53, 216.624);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3862.66, -2883.01, 149.145);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1305.97, -4018.11, 275.623);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-658.716, -3718.46, 250.124);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-5.15608, -4029.62, 157.126);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (278.393, -3877.45, 82.9562);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (131.01, -3233.66, 218.734);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (2530.01, -3047.51, 155.124);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (2201.91, -3088.46, 155.625);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (2976.63, -2139.66, 59.1264);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (2532.47, -1836.45, 58.1255);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (1542.53, -1974.05, -13.9781);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (776.267, 792.22, 48.1386);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (998.317, 296.732, 40.0368);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-331.755, 776.199, 52.5667);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-338.041, -25.8158, 72.3431);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1060.12, -1119.1, 225.121);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-107.68, -1152.33, 224.123);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1154.41, 1559.48, -15.8731);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1258.34, 2449.81, 44.1231);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1338.24, 1756.7, -110.18);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2316.13, 1772.21, -184.543);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2823.2, 596.546, -127.876);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2073.68, 238.421, -15.9696);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3612.04, 1521.7, -126.87);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2914.09, -1710.62, -21.2738);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2944.36, -4052.84, 210.896);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2382.61, -4395.84, 252.127);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3082.08, -5074.05, 312.862);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3003.76, -5115.83, 311.234);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3172.69, -4780.86, 312.124);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1228.32, -4017.54, 272.112);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2329.19, -4867.79, 257.182);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2573.54, -3004.51, 151.126);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3878.05, -2596.36, 142.499);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3439.8, -3442.85, 151.259);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-4379.7, -2989, 220.125);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3963.17, -3969.1, 232.394);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-4137.16, -1062.74, 46.7611);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3452.49, -103.671, -125.894);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3076.77, 393.764, -126.874);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3022.44, 698.133, -127.876);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3606.3, 1533.1, -125.45);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3555.31, 1834.37, -127.876);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2616.27, 656.545, -126.874);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2092.21, 1016.01, -158.436);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1683.96, 1815.85, -145.871);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1934.77, 2360.91, -153.877);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2243.52, 2717.41, -153.877);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2194.19, 2422.55, -153.877);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1444.36, 2600.57, 28.8089);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-913.834, 1635.32, -15.873);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-851.021, 1261.76, -15.873);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-613.604, 890.768, -3.19943);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1041.02, 1116.27, -13.1563);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (207.589, 1128.83, 48.032);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (2027.47, 95.396, 96.124);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (1973.11, -501.809, 176.125);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (1279.58, -577.696, 176.125);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (671.612, -689.36, 186.96);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (914.928, -1039.51, 244.97);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (672.781, -1454.14, 273.105);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (1695.88, -1348.46, 238.046);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (2428.12, -395.565, 288.122);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (1102.86, -2231.27, 143.999);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (1240.59, -2957.3, 99.2566);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (1675.8, -3203.36, 123.88);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (2397.54, -2742.19, 99.4899);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (2203.36, -2133.85, -17.8656);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (2210.27, -1370.78, -13.8699);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (1163.34, -1124.65, 23.1279);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (1020.8, -3492.9, 94.0181);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (223.932, -3464.44, 228.627);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2171.09, -4619.85, 358.093);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2220.08, -5202.24, 388.127);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3394.76, -1871.78, -5.56388);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3643.9, -2789.6, 148.126);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1935.81, -4601.36, 356.125);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1821.63, -4425.31, 312.055);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-5013.91, 6160.46, -161.406);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3535, 4635.2, -151.093);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-5413.44, 3645.18, -142.919);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-5885.3, 4503.57, 115.291);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (764.024, -3304.87, 174.913);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (2362.01, -639.772, 282.623);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (1853.81, -431.291, 179.374);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (144.936, -1421, 394.01);
  level.slasherteleportpoints[level.slasherteleportpoints.size] = (-720.185, -1075.81, 398.18);
}

setup_rave_mode_door(var_0) {
  if(isDefined(var_0.groupname) && var_0.groupname == "rave_door") {
    var_0 makeunusable();
    var_1 = getEntArray(var_0.target, "targetname");
    foreach(var_3 in var_1) {
      if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "rave_objects") {
        if(isDefined(var_3.target)) {
          var_4 = scripts\engine\utility::getstructarray(var_3.target, "targetname");
          foreach(var_6 in var_4) {
            var_6 setup_rave_shimmer_fx(var_3);
          }
        }
      }
    }
  }
}

cp_rave_get_alias_2d_version(var_0, var_1, var_2) {
  var_3 = strtok(var_1, "_");
  if(var_3[0] == "ww" || var_3[0] == "dj" || var_3[0] == "ks") {
    return var_1;
  }

  var_4 = var_0.vo_prefix + "plr_" + var_2;
  if(soundexists(var_4)) {
    return var_4;
  }

  return undefined;
}

wait_for_pre_game_period() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  level.current_rave_interaction_structs = [];
  wait(0.2);
  scripts\cp\zombies\zombie_entrances::enable_windows_in_area("front_gate");
  scripts\engine\utility::flag_set("zombie_drop_powerups");
  scripts\engine\utility::flag_set("pillage_enabled");
  init_magic_wheel();
  level thread scripts\cp\zombies\zombie_zipline::fast_travel_init();
  scripts\engine\utility::flag_set("pre_game_over");
  level thread setupmemoryquestitems();
  level thread init_boat_and_pap_quest_structs();
  level thread scripts\cp\maps\cp_rave\cp_rave_memory_quests::set_up_ring_quest_interactions();
  level.agent_funcs["generic_zombie"]["on_damaged"] = ::scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiedamaged;
  level.agent_funcs["generic_zombie"]["gametype_on_killed"] = ::scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiekilled;
  level.agent_funcs["slasher"]["on_damaged"] = ::scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiedamaged;
}

init_magic_wheel() {
  var_0 = ["messhall", "rave", "lake_shore"];
  scripts\cp\zombies\interaction_magicwheel::set_magic_wheel_starting_location(scripts\engine\utility::random(var_0));
}

cp_rave_pillage_init() {
  level.pillageinfo = spawnStruct();
  level.pillageinfo.default_use_time = 500;
  level.pillageinfo.money_stack = "pb_money_stack_01";
  level.pillageinfo.attachment_model = "has_spotter_scope";
  level.pillageinfo.maxammo_model = "mil_ammo_case_1_open";
  level.pillageinfo.clip_model = "weapon_baseweapon_clip";
  level.pillageinfo.power_model = "misc_interior_card_game_01";
  level.pillageinfo.grenade_model = "frag_grenade_wm";
  level.pillageinfo.ui_searching = 1;
  level.pillageable_powers = ["power_speedBoost", "power_phaseShift", "power_kineticPulse", "power_teleport", "power_barrier"];
  level.pillageable_explosives = ["power_clusterGrenade", "power_gasGrenade", "power_splashGrenade", "power_bioSpike", "power_semtex", "power_frag"];
  level.pillageable_attachments = ["reflex", "grip", "barrelrange", "xmags", "overclock", "fastaim", "rof"];
  level.pillageinfo.clip = 33;
  level.pillageinfo.explosive = 33;
  level.pillageinfo.money = 33;
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_1", "backpack", "cp_rave_backpack_dropped", "cp_rave_backpack", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_2", "backpack", "cp_rave_backpack_dropped_green", "cp_rave_backpack_green", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_3", "backpack", "cp_rave_backpack_dropped_purple", "cp_rave_backpack_purple", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_4", "backpack", "cp_rave_backpack_dropped_red", "cp_rave_backpack_red", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("fanny_pack_1", "backpack", "zombies_fanny_pack_dropped", "zombies_fanny_pack", "J_HipTwist_LE");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("fanny_pack_3", "backpack", "zombies_fanny_pack_dropped_purple", "zombies_fanny_pack_purple", "J_HipTwist_LE");
}

cp_rave_introscreen_text() {
  var_0 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_RAVE_INTRO_LINE_1", 1);
  wait(1);
  var_1 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_RAVE_INTRO_LINE_2", 2);
  wait(1);
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    var_2 = scripts\cp\cp_hud_util::introscreen_corner_line(&"DIRECT_BOSS_FIGHT_LINE4_RAVE", 4);
  } else {
    var_2 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_RAVE_INTRO_LINE_3", 3);
  }

  wait(1);
  var_3 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_RAVE_INTRO_LINE_4", 4);
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

cp_rave_should_continue_progress_bar_think(var_0) {
  if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    return 1;
  }

  return !scripts\cp\cp_laststand::player_in_laststand(var_0);
}

init_boat_and_pap_quest_structs() {
  var_0 = scripts\engine\utility::getstructarray("pap_quest_piece", "script_noteworthy");
  var_1 = scripts\engine\utility::getstructarray("boat_quest_piece", "script_noteworthy");
  foreach(var_3 in var_0) {
    var_3.groupname = "locOverride";
  }

  foreach(var_3 in var_1) {
    var_3.groupname = "locOverride";
  }
}

setupmemoryquestitems() {
  var_0 = scripts\engine\utility::getstructarray("memory_quest_start_pos", "script_noteworthy");
  var_1 = scripts\engine\utility::getstructarray("memory_quest_end_pos", "script_noteworthy");
  var_2 = scripts\engine\utility::array_randomize_objects(var_0);
  var_3 = [];
  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];
    if(isDefined(var_5.name) && scripts\engine\utility::array_contains(var_3, var_5.name)) {
      var_5 thread delay_remove_from_interactions(var_5);
      continue;
    }

    var_3[var_3.size] = var_5.name;
    var_5.id = var_5.name;
    var_5.name = var_5.script_noteworthy;
    var_5.ravetriggered = 0;
    var_5.currentlyownedby = [];
    var_5.groupname = "locOverride";
    add_to_current_rave_interaction_list(var_5);
  }

  level.rave_mode_activation_funcs["memory_quest_start_pos"] = ::memory_start_struct_mode;
  level.normal_mode_activation_funcs["memory_quest_start_pos"] = ::memory_start_struct_mode;
  level.rave_mode_activation_funcs["memory_quest_end_pos"] = ::memory_struct_rave_mode;
  level.normal_mode_activation_funcs["memory_quest_end_pos"] = ::memory_struct_normal_mode;
  foreach(var_7 in var_1) {
    var_7.activated = 0;
    var_7.groupname = "locOverride";
    var_7.player_has_charm = 0;
  }
}

delay_remove_from_interactions(var_0) {
  var_0 notify("delay_interaction_array");
  var_0 endon("delay_interaction_array");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

delay_add_to_interactions(var_0) {
  var_0 notify("delay_interaction_array");
  var_0 endon("delay_interaction_array");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

get_valid_id(var_0) {
  var_1 = ["pacifier", "shovel", "tiki_mask", "arrowhead", "lure", "toad", "pool_ball", "ring", "binoculars", "boots"];
  var_2 = scripts\engine\utility::getstructarray("memory_quest_end_pos", "script_noteworthy");
  var_3 = sortbydistance(var_2, var_0);
  var_4 = [];
  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    foreach(var_7 in var_3) {
      if(var_1[var_5] == var_7.name) {
        if(var_5 == 0) {
          continue;
        } else {
          return var_5;
        }
      }
    }
  }
}

setupravetoys() {
  var_0 = scripts\engine\utility::getstructarray("rave_toys", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_modelname)) {
      var_2.rave_model = var_2.script_modelname;
      var_2.normal_model = var_2.script_modelname;
    }

    var_2.name = var_2.script_noteworthy;
    var_2.ravetriggered = 0;
    var_2.groupname = "locOverride";
    add_to_current_rave_interaction_list(var_2);
  }
}

getscriptablestatefromstructmodel(var_0, var_1) {
  switch (var_1) {
    case "zmb_spaceland_discoball_toy":
      if(var_0) {
        return "discoball";
      } else {
        return undefined;
      }

      break;

    default:
      return undefined;
  }
}

setup_slide() {
  var_0 = getent("slide", "targetname");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(scripts\engine\utility::istrue(var_1.onslide)) {
      continue;
    }

    if(isplayer(var_1) && var_1 scripts\cp\utility::is_valid_player(1)) {
      var_1.onslide = 1;
      var_1 thread player_down_slide(var_0);
    }
  }
}

player_down_slide(var_0) {
  self endon("disconnect");
  self.is_slide_sfx_playing = 0;
  self.is_slide_land_sfx_playing = 0;
  var_1 = scripts\engine\utility::getstruct("slide_dir_struct", "targetname");
  while(self isjumping()) {
    wait(0.05);
  }

  scripts\engine\utility::allow_weapon(0);
  scripts\engine\utility::allow_jump(0);
  self limitedmovement(1);
  self allowprone(0);
  self allowstand(0);
  scripts\cp\utility::allow_player_teleport(0, "slide");
  thread slide_anim();
  while(self istouching(var_0)) {
    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      thread last_stand_player_down_slide(var_1);
      return;
    }

    self.ability_invulnerable = 1;
    self.disable_consumables = 1;
    if(self.is_slide_sfx_playing == 0) {
      self.is_slide_sfx_playing = 1;
    }

    self setvelocity(vectornormalize(var_1.origin - self.origin) * 500);
    wait(0.05);
  }

  self.ability_invulnerable = undefined;
  self notify("offslide");
  var_2 = self playanimscriptevent("power_active_cp", "gesture014");
  self.is_slide_sfx_playing = 0;
  if(self.is_slide_land_sfx_playing == 0) {
    self.is_slide_land_sfx_playing = 1;
  }

  self limitedmovement(0);
  self.disable_consumables = undefined;
  self stopgestureviewmodel("ges_slide");
  scripts\engine\utility::allow_jump(1);
  scripts\engine\utility::allow_weapon(1);
  self allowprone(1);
  self allowcrouch(1);
  self allowstand(1);
  self setstance("stand");
  if(!scripts\cp\utility::isteleportenabled()) {
    scripts\cp\utility::allow_player_teleport(1, "slide");
  }

  self.onslide = undefined;
  self notify("can_teleport");
}

slide_anim() {
  self endon("last_stand");
  self endon("death");
  self endon("disconnect");
  self endon("offslide");
  self endon("stopslideanim");
  var_0 = 0;
  while(scripts\engine\utility::istrue(self.onslide)) {
    if(self isgestureplaying()) {
      wait(0.1);
      continue;
    }

    if(!var_0) {
      self playanimscriptevent("power_active_cp", "gesture012");
      wait(0.1);
      var_0 = 1;
    }

    self playanimscriptevent("power_active_cp", "gesture013");
    self playgestureviewmodel("ges_slide", undefined, 0);
    wait(0.1);
  }
}

last_stand_player_down_slide(var_0) {
  self endon("disconnect");
  self notify("stopslideanim");
  if(scripts\cp\cp_laststand::self_revive_activated()) {
    reset_slide_variables();
    self setorigin(var_0.origin);
    return;
  }

  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\utility::has_zombie_perk("perk_machine_revive")) {
    reset_slide_variables();
    self setorigin(var_0.origin);
    return;
  }

  self setorigin(var_0.origin);
  reset_slide_variables();
}

reset_slide_variables() {
  self unlink();
  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  self limitedmovement(0);
  self.disable_consumables = undefined;
  self stopgestureviewmodel("ges_slide");
  scripts\engine\utility::allow_jump(1);
  self setstance("stand");
  self allowprone(1);
  self allowstand(1);
  self allowcrouch(1);
  scripts\engine\utility::allow_weapon(1);
  if(!scripts\cp\utility::isteleportenabled()) {
    scripts\cp\utility::allow_player_teleport(1, "slide");
  }

  self.onslide = undefined;
  self notify("can_teleport");
}

setup_rave_shimmer_fx(var_0) {
  if(!isDefined(var_0.spawnedfx)) {
    var_0.spawnedfx = [];
  }

  var_1 = spawnfx(level._effect["rave_shimmer"], self.origin);
  wait(0.5);
  triggerfx(var_1);
  var_0.spawnedfx[var_0.spawnedfx.size] = var_1;
}

watchforplayerzonechange(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  scripts\engine\utility::flag_wait("init_interaction_done");
  var_1 = getent("rave_zone_change", "targetname");
  for(;;) {
    if(var_0 istouching(var_1)) {
      var_2 = gettime();
      if(var_2 < var_0.zonechangecooldown) {
        scripts\engine\utility::waitframe();
        continue;
      }

      var_0 notify("rave_status_changed");
      var_0.zonechangecooldown = gettime() + 1000;
    }

    wait(0.1);
  }
}

cp_rave_onplayerspawned() {
  thread scripts\cp\powers\coop_powers::power_watch_hint(1);
  level thread show_rave_objects(self);
  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }

    if(isDefined(var_1.rave_dust_pouch)) {
      var_1.rave_dust_pouch hidefromplayer(self);
    }
  }

  if(scripts\engine\utility::istrue(level.forceravemode)) {
    self.unlimited_rave = 1;
    level thread enter_rave_mode(self);
  }
}

cp_rave_onplayerconnect(var_0) {
  var_0 thread assignravemodelents(var_0);
  var_0 thread moveraveentstostructs(var_0);
  var_0.zonechangecooldown = 0;
  var_0 thread watchforplayerzonechange(var_0);
  var_0 thread watchforweaponchange(var_0);
  var_0 thread watchforstickerachievement(var_0);
  var_0 scripts\cp\zombies\zombies_rave_meter::init_rave_meter(var_0);
  var_1 = var_0 getplayerdata("cp", "haveSoulKeys", "any_soul_key");
  var_2 = var_0 getplayerdata("cp", "haveSoulKeys", "soul_key_1");
  if(var_2) {
    var_0.has_zis_soul_key = 1;
  }

  level thread watch_player_on_ladders(var_0);
  thread run_pap_machine_logic(var_0);
  thread run_harpoon_interaction_logic(var_0);
  if(!isDefined(level.kick_player_queue)) {
    level thread kick_player_queue_loop();
  }

  var_0 thread kick_for_inactivity(var_0);
}

watchforstickerachievement(var_0) {
  level endon("game_ended");
  var_0 endon("all_collected");
  var_0 endon("disconnect");
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  for(;;) {
    if(scripts\engine\utility::flag("pap_fixed")) {
      var_1 = 1;
    }

    if(scripts\engine\utility::flag("owl_quest_completed") && scripts\engine\utility::flag("wolf_quest_completed") && scripts\engine\utility::flag("eagle_quest_completed") && scripts\engine\utility::flag("deer_quest_completed")) {
      var_5 = 1;
    }

    if(scripts\engine\utility::flag_exist("survivor_got_to_island") && scripts\engine\utility::flag("survivor_got_to_island")) {
      var_3 = 1;
    }

    if(isDefined(level.charms_collected) && level.charms_collected >= 10) {
      var_4 = 1;
    }

    if(isDefined(level.boat_pieces_found) && level.boat_pieces_found == 3) {
      var_2 = 1;
    }

    if(var_1 && var_5 && var_3 && var_4 && var_2) {
      var_0 scripts\cp\zombies\achievement::update_achievement("SCRAPBOOKING", 1);
      var_0 notify("all_collected");
    }

    wait(1);
  }
}

run_harpoon_interaction_logic(var_0) {
  while(!isDefined(level.harpoon_interactions)) {
    wait(0.1);
  }

  while(!isDefined(level.players) || level.players.size < 1) {
    wait(0.1);
  }

  foreach(var_2 in level.harpoon_interactions) {
    var_3 = 0;
    foreach(var_0 in level.players) {
      if(isDefined(var_0.harpoon_interaction) && var_0.harpoon_interaction == var_2) {
        var_3 = 1;
      }
    }

    if(!var_3) {
      var_0.harpoon_interaction = var_2;
      break;
    }
  }

  if(!isDefined(var_0.harpoon_interaction)) {}

  foreach(var_2 in level.harpoon_interactions) {
    if(var_0.harpoon_interaction != var_2) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_2, var_0);
    }
  }
}

run_pap_machine_logic(var_0) {
  wait(3);
  var_1 = getent("pap_machine", "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2.angles = var_1.angles;
  if(scripts\engine\utility::istrue(var_0.has_zis_soul_key) || scripts\engine\utility::istrue(level.placed_alien_fuses)) {
    var_2 setModel("zmb_pap_machine_animated_soul_key");
    var_2 setscriptablepartstate("machine", "upgraded");
  } else {
    var_2 setModel("zmb_pap_machine_animated_rave");
  }

  var_2 setscriptablepartstate("reels", "on");
  var_2 setscriptablepartstate("door", "open_idle");
  var_2.owner = var_0;
  foreach(var_4 in level.players) {
    if(var_4 != var_0) {
      var_2 hidefromplayer(var_4);
    }
  }

  level.player_pap_machines[level.player_pap_machines.size] = var_2;
  var_2 thread watch_for_player_connect(var_0);
  var_2 thread cleanup_ent_on_player_disconnect(var_0);
}

cleanup_ent_on_player_disconnect(var_0) {
  level endon("game_ended");
  var_0 waittill("disconnect");
  if(isDefined(self)) {
    self delete();
  }

  level.player_pap_machines = scripts\engine\utility::array_removeundefined(level.player_pap_machines);
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

assignravemodelents(var_0) {
  var_0.ravemodeents = [];
  for(var_1 = 0; var_1 < 10; var_1++) {
    var_2 = spawn("script_model", (0, 0, -5000));
    var_2.ogorigin = (0, 0, -5000);
    var_2 setModel("tag_origin");
    var_2.claimed = 0;
    var_2.used = 0;
    var_0.ravemodeents[var_0.ravemodeents.size] = var_2;
  }

  var_0 thread cleanup_ents_on_disconnect(var_0);
}

cleanup_ents_on_disconnect(var_0) {
  level endon("game_ended");
  var_1 = var_0.ravemodeents;
  var_0 waittill("disconnect");
  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 delete();
    }
  }
}

moveraveentstostructs(var_0) {
  var_0 endon("disconnect");
  if(!scripts\engine\utility::flag("init_interaction_done")) {
    scripts\engine\utility::flag_wait("init_interaction_done");
  }

  var_1 = ["zmb_spaceland_discoball_toy"];
  var_2 = ["zmb_spaceland_discoball_toy"];
  var_3 = scripts\engine\utility::istrue(var_0.rave_mode);
  for(;;) {
    var_0.rave_mode_updating = 1;
    var_4 = 0;
    var_5 = 0;
    if(scripts\engine\utility::istrue(var_0.rave_mode) != var_3) {
      var_3 = scripts\engine\utility::istrue(var_0.rave_mode);
      var_5 = 1;
    }

    var_6 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.current_rave_interaction_structs, undefined, 100);
    var_6 = removeinvalidstructs(var_6, var_0);
    var_6 = sortbydistance(var_6, var_0.origin);
    var_0 resetents(var_0, var_6);
    foreach(var_8 in var_6) {
      var_9 = 0;
      if(var_8 hasplayerentattached(var_0, var_8)) {
        var_10 = getattachedpersonalent(var_0, var_8);
        if(isDefined(var_10)) {
          if(var_5) {
            if(scripts\engine\utility::istrue(var_0.rave_mode)) {
              if(isDefined(var_8.script_noteworthy) && isDefined(level.rave_mode_activation_funcs[var_8.script_noteworthy])) {
                var_9 = 1;
                var_10[[level.rave_mode_activation_funcs[var_8.script_noteworthy]]](var_10, var_8, 0, var_0);
              } else if(isDefined(var_8.rave_model)) {
                var_10 setModel(var_8.rave_model);
              } else {
                var_10 setModel(scripts\engine\utility::random(var_1));
              }
            } else if(isDefined(var_8.script_noteworthy) && isDefined(level.normal_mode_activation_funcs[var_8.script_noteworthy])) {
              var_9 = 1;
              var_10[[level.normal_mode_activation_funcs[var_8.script_noteworthy]]](var_10, var_8, 0, var_0);
            } else if(isDefined(var_8.normal_model)) {
              var_10 setModel(var_8.normal_model);
            } else {
              var_10 setModel(scripts\engine\utility::random(var_2));
            }
          } else if(scripts\engine\utility::istrue(var_0.rave_mode)) {
            if(isDefined(var_8.script_noteworthy) && isDefined(level.rave_mode_activation_funcs[var_8.script_noteworthy])) {
              var_9 = 1;
              var_10[[level.rave_mode_activation_funcs[var_8.script_noteworthy]]](var_10, var_8, 1, var_0);
            }
          } else if(isDefined(var_8.script_noteworthy) && isDefined(level.normal_mode_activation_funcs[var_8.script_noteworthy])) {
            var_9 = 1;
            var_10[[level.normal_mode_activation_funcs[var_8.script_noteworthy]]](var_10, var_8, 1, var_0);
          }

          if(!var_9) {
            if(scripts\engine\utility::istrue(var_0.rave_mode)) {
              if(isDefined(var_8.current_rave_state) && isDefined(var_8.current_rave_part)) {
                var_10 setscriptablepartstate(var_8.current_rave_part, var_8.current_rave_state);
              }
            } else if(isDefined(var_8.current_normal_state) && isDefined(var_8.current_normal_part)) {
              var_10 setscriptablepartstate(var_8.current_normal_part, var_8.current_normal_state);
            }
          }
        }

        continue;
      }

      var_10 = getunclaimedpersonalent(var_0, var_6);
      if(isDefined(var_10)) {
        var_8.currentlyownedby[var_0.name] = var_10;
        var_10.claimed = 1;
        var_10.used = 1;
        var_10 dontinterpolate();
        var_10.origin = var_8.origin;
        if(isDefined(var_8.angles)) {
          var_10.angles = var_8.angles;
        } else {
          var_10.angles = (0, 0, 0);
        }

        if(scripts\engine\utility::istrue(var_0.rave_mode)) {
          if(isDefined(var_8.script_noteworthy) && isDefined(level.rave_mode_activation_funcs[var_8.script_noteworthy])) {
            var_9 = 1;
            var_10[[level.rave_mode_activation_funcs[var_8.script_noteworthy]]](var_10, var_8, 0, var_0);
          } else if(isDefined(var_8.rave_model)) {
            var_10 setModel(var_8.rave_model);
          } else {
            var_10 setModel(scripts\engine\utility::random(var_1));
          }
        } else if(isDefined(var_8.script_noteworthy) && isDefined(level.normal_mode_activation_funcs[var_8.script_noteworthy])) {
          var_9 = 1;
          var_10[[level.normal_mode_activation_funcs[var_8.script_noteworthy]]](var_10, var_8, 0, var_0);
        } else if(isDefined(var_8.normal_model)) {
          var_10 setModel(var_8.normal_model);
        } else {
          var_10 setModel(scripts\engine\utility::random(var_2));
        }

        if(!var_9) {
          if(scripts\engine\utility::istrue(var_0.rave_mode)) {
            if(isDefined(var_8.current_rave_state) && isDefined(var_8.current_rave_part)) {
              var_10 setscriptablepartstate(var_8.current_rave_part, var_8.current_rave_state);
            }
          } else if(isDefined(var_8.current_normal_state) && isDefined(var_8.current_normal_part)) {
            var_10 setscriptablepartstate(var_8.current_normal_part, var_8.current_normal_state);
          }
        }

        adjustmodelvis(var_0, var_10);
      }
    }

    var_0.rave_mode_updating = undefined;
    var_0 notify("rave_mode_updated");
    var_0 scripts\engine\utility::waittill_any_return_no_endon_death_3("zone_change", "rave_status_changed", "rave_interactions_updated");
  }
}

memory_start_struct_mode(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1.name)) {
    var_4 = var_1.name;
  } else {
    var_4 = undefined;
  }

  if(isDefined(var_4)) {
    if(!isDefined(var_0.model) || isDefined(var_0.model) && var_0.model != "tag_origin_memory_quest") {
      var_0 setModel("tag_origin_memory_quest");
    }

    var_5 = get_memory_attributes(var_4, undefined, !scripts\engine\utility::istrue(var_3.rave_mode), 1, var_1);
    var_6 = set_memory_model(var_4, undefined, !scripts\engine\utility::istrue(var_3.rave_mode), var_0, 1, var_1);
    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      if(isDefined(var_5[var_7][0]) && isDefined(var_5[var_7][1])) {
        var_0 setscriptablepartstate(var_5[var_7][0], var_5[var_7][1]);
      }
    }
  }
}

memory_struct_rave_mode(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1.name)) {
    var_4 = var_1.name;
  } else {
    var_4 = undefined;
  }

  var_2 = scripts\engine\utility::istrue(var_2);
  if(isDefined(var_4)) {
    if(!isDefined(var_0.model) || isDefined(var_0.model) && var_0.model != "tag_origin_memory_quest") {
      var_0 setModel("tag_origin_memory_quest");
    }

    if(isDefined(var_1.angles)) {
      var_0.angles = var_1.angles;
    }

    var_5 = scripts\engine\utility::istrue(var_1.activated);
    var_6 = get_memory_attributes(var_4, var_5, 0, 0, var_1);
    var_7 = set_memory_model(var_4, var_5, 0, var_0, 0, var_1);
    for(var_8 = 0; var_8 < var_6.size; var_8++) {
      if(isDefined(var_6[var_8][0]) && isDefined(var_6[var_8][1])) {
        var_0 setscriptablepartstate(var_6[var_8][0], var_6[var_8][1]);
      }
    }
  }
}

set_memory_model(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 = scripts\engine\utility::istrue(var_1);
  var_2 = scripts\engine\utility::istrue(var_2);
  var_6 = scripts\engine\utility::istrue(var_4);
  if(var_0 == "memory_quest_start_pos") {
    switch (var_5.id) {
      case "pacifier":
        var_3 setscriptablepartstate("model", "pacifier");
        break;

      case "shovel":
        var_3 setscriptablepartstate("model", "shovel");
        break;

      case "tiki_mask":
        var_3 setscriptablepartstate("model", "mask");
        break;

      case "arrowhead":
        var_3 setscriptablepartstate("model", "arrowhead");
        break;

      case "lure":
        var_3 setscriptablepartstate("model", "lure");
        break;

      case "toad":
        var_3 setscriptablepartstate("model", "toad");
        break;

      case "pool_ball":
        var_3 setscriptablepartstate("model", "8ball");
        break;

      case "ring":
        var_3 setscriptablepartstate("model", "ring");
        break;

      case "binoculars":
        var_3 setscriptablepartstate("model", "binoculars");
        break;

      case "boots":
        var_3 setscriptablepartstate("model", "boots");
        break;
    }

    return;
  }

  switch (var_0) {
    case "shovel":
      if(var_6) {
        var_3 setscriptablepartstate("model", "shovel");
      } else if(var_2) {
        if(var_1) {
          var_3 setscriptablepartstate("model", "shovel");
        } else {
          var_3 setscriptablepartstate("model", "neutral");
        }
      } else if(var_1) {
        var_3 setscriptablepartstate("model", "shovel");
      } else {
        var_3 setscriptablepartstate("model", "neutral");
      }
      break;

    case "tiki_mask":
      if(var_6) {
        var_3 setscriptablepartstate("model", "mask");
      } else if(var_2) {
        if(var_1) {
          var_3 setscriptablepartstate("model", "mask");
        } else {
          var_3 setscriptablepartstate("model", "neutral");
        }
      } else if(var_1) {
        var_3 setscriptablepartstate("model", "mask");
      } else {
        var_3 setscriptablepartstate("model", "neutral");
      }
      break;

    case "arrowhead":
      if(var_6) {
        var_3 setscriptablepartstate("model", "arrowhead");
      } else if(var_2) {
        if(var_1) {
          var_3 setscriptablepartstate("model", "arrowhead");
        } else {
          var_3 setscriptablepartstate("model", "neutral");
        }
      } else if(var_1) {
        var_3 setscriptablepartstate("model", "arrowhead");
      } else {
        var_3 setscriptablepartstate("model", "neutral");
      }
      break;

    case "lure":
      if(var_6) {
        var_3 setscriptablepartstate("model", "lure");
      } else if(var_2) {
        if(var_1) {
          var_3 setscriptablepartstate("model", "lure");
        } else {
          var_3 setscriptablepartstate("model", "neutral");
        }
      } else if(var_1) {
        var_3 setscriptablepartstate("model", "lure");
      } else {
        var_3 setscriptablepartstate("model", "neutral");
      }
      break;

    case "toad":
      if(var_6) {
        var_3 setscriptablepartstate("model", "toad");
      } else if(var_2) {
        if(var_1) {
          var_3 setscriptablepartstate("model", "toad");
        } else {
          var_3 setscriptablepartstate("model", "neutral");
        }
      } else if(var_1) {
        var_3 setscriptablepartstate("model", "toad");
      } else {
        var_3 setscriptablepartstate("model", "neutral");
      }
      break;

    case "pool_ball":
      if(var_6) {
        var_3 setscriptablepartstate("model", "8ball");
      } else if(var_2) {
        if(var_1) {
          var_3 setscriptablepartstate("model", "8ball");
        } else {
          var_3 setscriptablepartstate("model", "neutral");
        }
      } else if(var_1) {
        var_3 setscriptablepartstate("model", "8ball");
      } else {
        var_3 setscriptablepartstate("model", "neutral");
      }
      break;

    case "boots":
      if(var_6) {
        var_3 setscriptablepartstate("model", "boots");
      } else if(var_2) {
        if(var_1) {
          var_3 setscriptablepartstate("model", "boots");
        } else {
          var_3 setscriptablepartstate("model", "neutral");
        }
      } else if(var_1) {
        var_3 setscriptablepartstate("model", "boots");
      } else {
        var_3 setscriptablepartstate("model", "neutral");
      }
      break;

    case "ring":
      if(var_6) {
        var_3 setscriptablepartstate("model", "ring");
      } else if(var_2) {
        if(var_1) {
          var_3 setscriptablepartstate("model", "ring");
        } else {
          var_3 setscriptablepartstate("model", "neutral");
        }
      } else if(var_1) {
        var_3 setscriptablepartstate("model", "ring");
      } else {
        var_3 setscriptablepartstate("model", "neutral");
      }
      break;

    case "pacifier":
      if(var_6) {
        var_3 setscriptablepartstate("model", "pacifier");
      } else if(var_2) {
        if(var_1) {
          var_3 setscriptablepartstate("model", "pacifier");
        } else {
          var_3 setscriptablepartstate("model", "neutral");
        }
      } else if(var_1) {
        var_3 setscriptablepartstate("model", "pacifier");
      } else {
        var_3 setscriptablepartstate("model", "neutral");
      }
      break;

    case "binoculars":
      if(var_6) {
        var_3 setscriptablepartstate("model", "binoculars");
      } else if(var_2) {
        if(var_1) {
          var_3 setscriptablepartstate("model", "binoculars");
        } else {
          var_3 setscriptablepartstate("model", "neutral");
        }
      } else if(var_1) {
        var_3 setscriptablepartstate("model", "binoculars");
      } else {
        var_3 setscriptablepartstate("model", "neutral");
      }
      break;

    default:
      if(var_6) {
        var_3 setscriptablepartstate("model", "discoball");
        return;
      }

      if(var_1) {
        var_3 setscriptablepartstate("model", "discoball");
        return;
      }
      var_3 setscriptablepartstate("model", "neutral");
      break;
  }
}

get_memory_attributes(var_0, var_1, var_2, var_3, var_4) {
  var_1 = scripts\engine\utility::istrue(var_1);
  var_2 = scripts\engine\utility::istrue(var_2);
  var_5 = scripts\engine\utility::istrue(var_3);
  var_6 = scripts\engine\utility::istrue(var_4.ravetriggered);
  var_7 = [];
  switch (var_0) {
    case "memory_quest_start_pos":
      if(var_2) {
        var_7[var_7.size] = ["idle_effects", "neutral"];
      } else {
        var_7[var_7.size] = ["idle_effects", "neutral"];
      }

      var_7[var_7.size] = ["sound", "neutral"];
      return var_7;

    case "ring":
      if(var_2) {
        if(var_1) {} else {
          var_7[var_7.size] = ["idle_effects", "neutral"];
        }
      } else if(var_1) {
        var_7[var_7.size] = ["idle_effects", "neutral"];
        var_7[var_7.size] = ["sound", "neutral"];
      } else {
        var_7[var_7.size] = ["sound", "idle"];
        var_7[var_7.size] = ["idle_effects", "idle"];
      }
      return var_7;

    case "pacifier":
      if(var_2) {
        if(var_1) {
          var_7[var_7.size] = ["sound", "neutral"];
          var_7[var_7.size] = ["idle_effects", "neutral"];
        } else {
          var_7[var_7.size] = ["sound", "neutral"];
          var_7[var_7.size] = ["idle_effects", "neutral"];
        }
      } else if(var_1) {
        var_7[var_7.size] = ["idle_effects", "neutral"];
        var_7[var_7.size] = ["sound", "pacifier"];
      } else {
        var_7[var_7.size] = ["sound", "idle"];
        var_7[var_7.size] = ["idle_effects", "idle"];
      }
      return var_7;

    default:
      if(var_2) {
        if(var_1) {} else {
          var_7[var_7.size] = ["idle_effects", "neutral"];
        }
      } else if(var_1) {
        var_7[var_7.size] = ["idle_effects", "neutral"];
        var_7[var_7.size] = ["sound", "neutral"];
      } else {
        var_7[var_7.size] = ["sound", "idle"];
        var_7[var_7.size] = ["idle_effects", "idle"];
      }
      return var_7;
  }
}

memory_struct_normal_mode(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1.name)) {
    var_4 = var_1.name;
  } else {
    var_4 = undefined;
  }

  var_2 = scripts\engine\utility::istrue(var_2);
  if(isDefined(var_4)) {
    if(!isDefined(var_0.model) || isDefined(var_0.model) && var_0.model != "tag_origin_memory_quest") {
      var_0 setModel("tag_origin_memory_quest");
    }

    if(isDefined(var_1.angles)) {
      var_0.angles = var_1.angles;
    }

    var_5 = scripts\engine\utility::istrue(var_1.activated);
    var_6 = get_memory_attributes(var_4, var_5, 1, 0, var_1);
    var_7 = set_memory_model(var_4, var_5, 1, var_0, 0, var_1);
    for(var_8 = 0; var_8 < var_6.size; var_8++) {
      if(isDefined(var_6[var_8][0]) && isDefined(var_6[var_8][1])) {
        var_0 setscriptablepartstate(var_6[var_8][0], var_6[var_8][1]);
      }
    }
  }
}

resetents(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_0.ravemodeents) {
    var_5 = 0;
    foreach(var_7 in var_1) {
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
    if(!scripts\engine\utility::istrue(var_1.rave_mode) && scripts\engine\utility::istrue(var_4.only_rave_mode)) {
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
      if(var_2.size >= 10) {
        break;
      }

      continue;
    }

    var_2[var_2.size] = var_4;
    if(var_2.size >= 10) {
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
  foreach(var_3 in var_0.ravemodeents) {
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
  foreach(var_3 in var_0.ravemodeents) {
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
}

getattachedpersonalent(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_0.ravemodeents) {
    var_5 = 0;
    if(var_4.origin == var_1.origin) {
      var_5 = 1;
    }

    if(var_5) {
      return var_4;
    }
  }

  return undefined;
}

getunclaimedpersonalent(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_0.ravemodeents) {
    var_5 = 0;
    foreach(var_7 in var_1) {
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

add_to_current_rave_interaction_list(var_0) {
  level.current_rave_interaction_structs = scripts\engine\utility::array_add(level.current_rave_interaction_structs, var_0);
}

remove_from_current_rave_interaction_list(var_0) {
  level.current_rave_interaction_structs = scripts\engine\utility::array_remove(level.current_rave_interaction_structs, var_0);
}

enter_rave_mode(var_0) {
  level.someones_in_rave = 1;
  level notify("player_entered_rave", var_0);
  var_0 thread scripts\cp\zombies\zombies_rave_meter::rave_meter_on(var_0);
  var_0 playlocalsound("amb_rave_mode_lr_start");
  var_0 setclienttriggeraudiozonepartialwithfade("cp_rave_mode", 0.5, "reverb", "filter", "ambient");
  var_0.vision_set_override = "cp_rave_rave_mode";
  var_0.current_rave_mode_timer = 30;
  var_0.rave_mode = 1;
  var_0.rave_cash_scalar = 2;
  var_0 notify("rave_status_changed");
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("ww_rave_mode", "rave_mode_vo", "highest", 5, 0, 0, 1);
  var_0 thread watch_time_in_rave();
  var_0 thread watch_player_kills_in_rave(var_0);
  var_0 thread play_enter_rave_gesture();
  var_0 setscriptablepartstate("rave_light", "active");
  if(randomint(100) > 50) {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("enter_rave", "rave_comment_vo");
  } else {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("rave_mental", "rave_comment_vo");
  }

  setimpactfx("cp_rave_mode", var_0);
  var_0 thread watch_for_ground_pound(var_0);
  var_0 allowgroundpound(1);
  var_0 setinteractwithethereal(1);
  set_rave_vision(var_0);
  func_8EA1(var_0);
  if(isDefined(level.wave_num) && level.wave_num >= 10) {
    level thread spawn_slasher_after_timer(5);
  }
}

watch_time_in_rave() {
  level endon("player_exited_rave");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(level.wave_num < 10) {
    return;
  }

  var_0 = gettime();
  while(gettime() < var_0 + 300000) {
    scripts\engine\utility::waitframe();
  }

  scripts\cp\zombies\achievement::update_achievement("HALLUCINATION_NATION", 1);
}

play_enter_rave_gesture() {
  self setweaponammostock("iw7_tripping_zm", 1);
  self giveandfireoffhand("iw7_tripping_zm");
}

watch_player_kills_in_rave(var_0) {
  var_0 endon("exit_rave");
  var_0 endon("disconnect");
  for(;;) {
    level waittill("zombie_killed", var_1, var_2, var_3, var_4);
    if(isDefined(var_4) && var_4 == var_0) {
      var_0 scripts\cp\zombies\zombies_rave_meter::rave_meter_kill_decrement();
    }
  }
}

watch_for_ground_pound(var_0) {
  var_0 endon("exit_rave");
  var_0 endon("disconnect");
  for(;;) {
    var_0 waittill("groundPoundLand");
    var_1 = var_0.origin;
    playrumbleonposition("slide_collision", var_1);
    var_0 earthquakeforplayer(0.75, 0.5, var_1, 128);
    var_0 shellshock("frag_grenade_mp", 0.5, 1, 0);
    var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_3 = scripts\engine\utility::get_array_of_closest(var_1, var_2, undefined, 24, 128);
    var_0.ground_pound_active = 1;
    var_0 thread spawn_ground_pound_flowers(var_0);
    if(isDefined(level.toad_ent_array)) {
      foreach(var_5 in level.toad_ent_array) {
        if(!isDefined(var_5)) {
          continue;
        }

        if(distance2dsquared(var_1, var_5.origin) <= 2500) {
          var_5 dodamage(10000, var_5.origin, var_0, var_0, "MOD_IMPACT", "zom_groundpound_rave_mp");
          scripts\engine\utility::array_remove(level.toad_ent_array, var_5);
        }
      }
    }

    foreach(var_9, var_8 in var_3) {
      if(isDefined(var_8.agent_type) && var_8.agent_type == "superslasher" || var_8.agent_type == "slasher") {
        continue;
      }

      var_8 thread killnearbyvictim(var_0, var_8.maxhealth, var_8.origin, var_1, var_1);
      if(var_9 % 3 == 1) {
        scripts\engine\utility::waitframe();
      }
    }
  }
}

spawn_ground_pound_flowers(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = var_0 getEye();
  var_4 = vectornormalize(anglesToForward(var_2)) * 50;
  var_5 = -1 * vectornormalize(var_4) * 50;
  var_6 = vectornormalize(anglestoright(var_2)) * 50;
  var_7 = -1 * vectornormalize(var_6) * 50;
  var_8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_canshootclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_9 = [];
  var_9[var_9.size] = ::scripts\engine\utility::drop_to_ground(var_1 + var_4, 32, -100);
  var_9[var_9.size] = ::scripts\engine\utility::drop_to_ground(var_1 + var_5, 32, -100);
  var_9[var_9.size] = ::scripts\engine\utility::drop_to_ground(var_1 + var_6, 32, -100);
  var_9[var_9.size] = ::scripts\engine\utility::drop_to_ground(var_1 + var_7, 32, -100);
  var_10 = [];
  foreach(var_12 in var_9) {
    var_13 = scripts\common\trace::ray_trace(var_3, var_12, var_0, var_8);
    var_14 = scripts\engine\utility::drop_to_ground(var_13["position"], 32, -2000);
    var_10[var_10.size] = var_14;
  }

  var_10 = [];
  foreach(var_12 in var_10) {
    var_13 = scripts\common\trace::ray_trace(var_12 + (0, 0, 32), var_12, var_0, var_8);
    var_13 = var_13["normal"];
    var_10[var_10.size] = vectortoangles(vectornormalize(var_13 + (-90, 0, 0)));
  }

  for(var_15 = 0; var_15 < var_10.size; var_15++) {
    var_16 = spawn("script_model", var_10[var_15]);
    var_16 setModel("foliage_flowers_blue_patch_iw6");
    var_16.angles = var_10[var_15];
    var_16 thread delete_flowers_after_timeout();
    scripts\engine\utility::waitframe();
  }
}

delete_flowers_after_timeout() {
  wait(2.5);
  if(isDefined(self)) {
    self delete();
  }
}

spawn_slasher_after_timer(var_0, var_1, var_2) {
  wait(var_0);
  if(isDefined(level.slasher)) {
    return;
  }

  if(level.no_slasher) {
    return;
  }

  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(1);
  while(scripts\mp\mp_agent::getfreeagentcount() < 1) {
    wait(0.1);
  }

  var_3 = scripts\cp\zombies\zombies_spawning::get_scored_goon_spawn_location();
  if(isDefined(var_3) && !isDefined(level.slasher)) {
    var_4 = var_3.origin;
    if(isDefined(var_1)) {
      var_4 = var_1;
    }

    var_5 = var_3.angles;
    if(isDefined(var_2)) {
      var_5 = var_2;
    }

    var_4 = getclosestpointonnavmesh(var_4);
    level.slasher = scripts\mp\mp_agent::spawnnewagent("slasher", "axis", var_4, var_5);
    level thread play_slasher_vo();
    if(isDefined(level.slasher)) {
      if(!isDefined(level.zombie_slasher_vo_prefix)) {
        level.zombie_slasher_vo_prefix = "zmb_vo_slasher_";
      }

      level.slasher setethereal(1);
      level.slasher.voprefix = level.zombie_slasher_vo_prefix;
      level.slasher thread clear_slasher_on_death();
      level.slasher thread slasher_enemy_monitor();
      level.slasher thread slasher_audio_monitor();
      return;
    }

    return;
  }

  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
}

play_slasher_vo() {
  foreach(var_1 in level.players) {
    if(var_1.vo_prefix == "p5_") {
      if(randomint(100) > 50) {
        if(scripts\engine\utility::istrue(var_1.rave_mode)) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("ww_slasher_spawn_p5", "rave_mode_vo", "highest", 5, 0, 0, 1);
          wait(6);
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("slasher_first", "zmb_comment_vo", "highest", 20, 0, 0, 1);
        }
      } else if(!scripts\engine\utility::istrue(level.slasher_first_spawn)) {
        level.slasher_first_spawn = 1;
        if(scripts\engine\utility::istrue(var_1.rave_mode)) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("ww_slasher_firstspawn", "rave_mode_vo", "highest", 5, 0, 0, 1);
          wait(6);
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("slasher_first", "zmb_comment_vo", "highest", 20, 0, 0, 1);
        }
      } else if(scripts\engine\utility::istrue(var_1.rave_mode)) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("ww_slasher_spawn", "rave_mode_vo", "highest", 5, 0, 0, 1);
        wait(6);
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("slasher_generic", "zmb_comment_vo", "highest", 20, 0, 0, 1);
      }

      continue;
    }

    if(!scripts\engine\utility::istrue(level.slasher_first_spawn)) {
      level.slasher_first_spawn = 1;
      if(scripts\engine\utility::istrue(var_1.rave_mode)) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("ww_slasher_firstspawn", "rave_mode_vo", "highest", 5, 0, 0, 1);
        wait(6);
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("slasher_first", "zmb_comment_vo", "highest", 20, 0, 0, 1);
      }

      continue;
    }

    if(scripts\engine\utility::istrue(var_1.rave_mode)) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("ww_slasher_spawn", "rave_mode_vo", "highest", 5, 0, 0, 1);
      wait(6);
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("slasher_generic", "zmb_comment_vo", "highest", 20, 0, 0, 1);
    }
  }
}

slasher_audio_monitor() {
  level endon("game_ended");
  self endon("death");
  thread scripts\cp\zombies\zombies_vo::play_zombie_death_vo(self.voprefix, undefined, 1);
  self.playing_stumble = 0;
  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_timeout(6, "attack_hit", "taunt", "attack_charge", "attack_shoot");
    switch (var_0) {
      case "attack_hit":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_melee", 0);
        break;

      case "attack_shoot":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_saw_blade_shoot", 0);
        break;

      case "taunt":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "taunt", 0);
        break;

      case "attack_charge":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "charge_grunt", 0);
        break;

      case "timeout":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "walk_idle_grunt", 0);
        break;
    }
  }
}

clear_slasher_on_death() {
  self waittill("death");
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_slasher_death", "rave_announcer_vo", "highest", 5, 0, 0, 1);
  level.slasher = undefined;
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
}

slasher_enemy_monitor() {
  self endon("death");
  for(;;) {
    var_0 = 1;
    if(isDefined(self.main_enemy)) {
      if(self isethereal() && isDefined(self.main_enemy.rave_mode)) {
        var_0 = 0;
      }
    }

    if(var_0) {
      self.main_enemy = undefined;
      var_1 = scripts\engine\utility::array_randomize(level.players);
      foreach(var_3 in var_1) {
        if(isDefined(var_3.rave_mode)) {
          self.main_enemy = var_3;
          break;
        }
      }
    }

    if(isDefined(self.main_enemy)) {
      var_5 = self.main_enemy getthreatbiasgroup();
      if(threatbiasgroupexists(var_5 + "_enemy")) {
        self give_zombies_perk(var_5 + "_enemy");
      }

      self.precacheleaderboards = 0;
    } else {
      self give_zombies_perk();
      self.precacheleaderboards = 1;
    }

    scripts\engine\utility::waitframe();
  }
}

get_num_players_in_rave_mode() {
  var_0 = 0;
  foreach(var_2 in level.players) {
    if(isDefined(var_2.rave_mode)) {
      var_0++;
    }
  }

  return var_0;
}

exit_rave_mode(var_0) {
  level notify("player_exited_rave", var_0);
  var_0 playlocalsound("amb_rave_mode_lr_end");
  var_0 clearclienttriggeraudiozone(1);
  var_0 setinteractwithethereal(0);
  var_0.vision_set_override = undefined;
  var_0.rave_mode = undefined;
  var_0.rave_cash_scalar = undefined;
  var_0 allowgroundpound(0);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("exit_rave", "rave_comment_vo");
  var_0 notify("rave_status_changed");
  setimpactfx("cp_rave", var_0);
  var_0 setscriptablepartstate("rave_light", "neutral");
  unset_rave_vision(var_0);
  show_rave_objects(var_0);
  var_0 notify("exit_rave");
  check_level_rave_status();
  var_0 scripts\cp\zombies\zombies_rave_meter::rave_meter_off(var_0);
}

check_level_rave_status() {
  foreach(var_1 in level.players) {
    if(scripts\engine\utility::istrue(var_1.rave_mode)) {
      return;
    }
  }

  level notify("rave_mode_empty");
  level.someones_in_rave = 0;
}

create_rave_fx_walls_after_time() {
  level endon("rave_mode_empty");
  level.someones_in_rave = 1;
  var_0 = scripts\engine\utility::getstructarray("rave_fx_structs", "targetname");
  foreach(var_2 in var_0) {
    var_2.claimed = undefined;
  }

  wait(30);
  while(scripts\engine\utility::istrue(level.someones_in_rave)) {
    var_4 = get_players_in_rave_mode();
    var_5 = getbestraveeffectstruct(var_4, var_0);
    if(isDefined(var_5)) {
      var_5.claimed = 1;
      var_6 = getraveeffectfromstruct(var_5);
      var_7 = spawnfx(level._effect[var_6], var_5.origin, anglesToForward(var_5.angles), anglestoup(var_5.angles));
      triggerfx(var_7);
      level thread run_additional_rave_effects(var_6, var_5, var_7);
      level thread delete_rave_effects_when_empty(var_7);
      level thread update_rave_effect_visibility(var_7);
      wait(30);
      continue;
    }

    wait(randomintrange(5, 10));
  }
}

run_additional_rave_effects(var_0, var_1, var_2) {
  switch (var_0) {
    case "vfx_fire_lrg":
      level thread create_fire_damage_trigger(var_0, var_1, var_2);
      break;

    case "rave_barrier_fx":
      level thread knockback_nearby_rave_players(var_1, var_2);
      break;

    default:
      break;
  }
}

create_fire_damage_trigger(var_0, var_1, var_2) {
  level endon("rave_mode_empty");
  var_2 endon("death");
  var_3 = spawn("trigger_radius", var_1.origin, 1, 100, 60);
  var_3.team = "axis";
  level thread kill_ents_on_ravefx_death(var_0, var_1, var_2, var_3);
  for(;;) {
    var_3 waittill("trigger", var_4);
    if(!isplayer(var_4)) {
      continue;
    }

    if(!scripts\engine\utility::istrue(var_4.rave_mode)) {
      continue;
    }

    if(scripts\cp\utility::is_valid_player(var_4)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_4.padding_damage)) {
      continue;
    }

    var_4.padding_damage = 1;
    var_4 dodamage(34, var_4.origin);
    var_4 thread remove_padding_damage();
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.5);
  self.padding_damage = undefined;
}

kill_ents_on_ravefx_death(var_0, var_1, var_2, var_3) {
  var_2 waittill("death");
  playsoundatpos(var_3.origin, "trap_kindle_pops_fire_end");
  var_3 stoploopsound();
  var_3 delete();
}

knockback_nearby_rave_players(var_0, var_1) {
  level endon("rave_mode_empty");
  var_1 endon("death");
  var_2 = var_0.origin;
  var_3 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  for(;;) {
    var_4 = get_players_in_rave_mode();
    foreach(var_6 in var_4) {
      if(scripts\engine\utility::istrue(var_6.rave_knockback)) {
        continue;
      }

      var_7 = distance2dsquared(var_6.origin, var_2);
      if(var_7 > -25536) {
        continue;
      }

      var_8 = getbestendpos(var_6, var_0, var_3);
      var_9 = getdistancetocheck(var_8, var_2, var_6);
      if(isDefined(var_9) && distance2dsquared(var_6.origin, var_2) < var_9 * var_9) {
        var_6.rave_knockback = 1;
        var_6 thread setvelocitybasedonplayerpos(var_6, var_2, var_8, var_1);
      }
    }

    wait(0.2);
  }
}

setvelocitybasedonplayerpos(var_0, var_1, var_2, var_3) {
  level endon("rave_mode_empty");
  var_0 endon("disconnect");
  var_3 endon("death");
  var_0 thread unset_rave_knockback(var_0);
  var_4 = distance2dsquared(var_0.origin, var_1) < 10000;
  var_0.movespeedscaler = 0.1;
  var_0[[level.move_speed_scale]]();
  while(var_4) {
    var_0 setvelocity(vectornormalize(var_2.origin + (0, 0, -100) - var_0.origin) * 100);
    scripts\engine\utility::waitframe();
    var_5 = getdistancetocheck(var_2, var_1, var_0);
    var_4 = isDefined(var_5) && distance2dsquared(var_0.origin, var_1) < var_5 * var_5;
  }

  var_0.movespeedscaler = 1;
  var_0.rave_knockback = undefined;
  var_0[[level.move_speed_scale]]();
}

getdistancetocheck(var_0, var_1, var_2) {
  var_3 = cos(89);
  var_4 = vectortoangles(var_0.origin - var_1);
  var_5 = vectornormalize(var_2.origin - var_1);
  var_6 = anglesToForward(var_4);
  var_7 = vectordot(var_6, var_5);
  if(var_7 >= var_3) {
    return int(max(1 - var_7 / var_3 * 50, 75));
  }

  return undefined;
}

unset_rave_knockback(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  for(;;) {
    level scripts\engine\utility::waittill_any("rave_mode_empty", "player_entered_rave", "player_exited_rave");
    if(scripts\engine\utility::istrue(var_0.rave_mode)) {
      continue;
    } else {
      var_0.rave_knockback = undefined;
      var_0.movespeedscaler = 1;
      var_0[[level.move_speed_scale]]();
    }
  }
}

getbestendpos(var_0, var_1, var_2) {
  foreach(var_4 in var_2) {
    var_5 = vectortoangles(var_4.origin - var_1.origin);
    if(scripts\engine\utility::within_fov(var_1.origin, var_5, var_0.origin, cos(90))) {
      return var_4;
    }
  }

  return scripts\engine\utility::random(var_2);
}

getraveeffectfromstruct(var_0) {
  if(isDefined(var_0.script_noteworthy)) {
    return var_0.script_noteworthy;
  }

  return "rave_barrier_fx";
}

update_rave_effect_visibility(var_0) {
  level endon("rave_mode_empty");
  var_0 endon("death");
  for(;;) {
    foreach(var_2 in level.players) {
      if(scripts\engine\utility::istrue(var_2.rave_mode)) {
        var_0 showtoplayer(var_2);
        continue;
      }

      var_0 hidefromplayer(var_2);
    }

    level scripts\engine\utility::waittill_any("player_exited_rave", "player_entered_rave");
  }
}

delete_rave_effects_when_empty(var_0) {
  level waittill("rave_mode_empty");
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

getbestraveeffectstruct(var_0, var_1) {
  var_2 = 999999;
  var_3 = undefined;
  foreach(var_5 in var_1) {
    var_6 = undefined;
    if(scripts\engine\utility::istrue(var_5.claimed)) {
      continue;
    }

    foreach(var_8 in var_0) {
      var_9 = distance2dsquared(var_8.origin, var_5.origin);
      if(var_9 > 6250000) {
        continue;
      }

      if(isDefined(var_6)) {
        var_6 = var_6 + var_9;
        continue;
      }

      var_6 = var_9;
    }

    if(isDefined(var_6) && var_6 < var_2) {
      var_2 = var_6;
      var_3 = var_5;
    }
  }

  if(isDefined(var_3)) {
    return var_3;
  }

  return undefined;
}

get_players_in_rave_mode() {
  var_0 = [];
  foreach(var_2 in level.players) {
    if(scripts\engine\utility::istrue(var_2.rave_mode)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

unlimited_ammo(var_0) {
  self endon("disconnect");
  self endon("exit_rave");
  self endon(var_0 + "_removed");
  if(!isDefined(self.weaponlist)) {
    self.weaponlist = self getweaponslistprimaries();
  }

  scripts\cp\utility::enable_infinite_ammo(1);
  for(;;) {
    var_1 = 0;
    foreach(var_3 in self.weaponlist) {
      if(var_3 == self getcurrentweapon() && weapon_no_unlimited_check(var_3)) {
        var_1 = 1;
        self setweaponammoclip(var_3, weaponclipsize(var_3), "left");
      }

      if(var_3 == self getcurrentweapon() && weapon_no_unlimited_check(var_3)) {
        var_1 = 1;
        self setweaponammoclip(var_3, weaponclipsize(var_3), "right");
      }

      if(var_1 == 0) {
        ammo_round_up();
      }
    }

    wait(0.05);
  }
}

ammo_round_up(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = [];
  if(isDefined(var_0)) {
    var_1[var_0] = self getrunningforwardpainanim(var_0);
  } else {
    foreach(var_0 in self.weaponlist) {
      var_1[var_0] = self getrunningforwardpainanim(var_0);
    }
  }

  return var_1;
}

updateperks(var_0, var_1) {
  if(!isDefined(var_0.zombies_perks)) {
    return;
  }

  var_2 = getarraykeys(var_0.zombies_perks);
  foreach(var_4 in var_2) {
    var_0 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_4);
  }
}

weapon_no_unlimited_check(var_0) {
  var_1 = 1;
  foreach(var_3 in level.opweaponsarray) {
    if(var_0 == var_3) {
      var_1 = 0;
    }
  }

  return var_1;
}

func_8EA1(var_0) {
  var_1 = getEntArray("rave_objects", "script_noteworthy");
  foreach(var_3 in var_1) {
    var_3 hidefromplayer(var_0);
  }

  update_rave_mode_doors();
  if(isDefined(level.active_archery_target)) {
    level.active_archery_target showtoplayer(var_0);
  }

  if(isDefined(level.zombie_heads)) {
    foreach(var_6 in level.zombie_heads) {
      var_6 showtoplayer(var_0);
    }
  }

  foreach(var_9 in level.wall_buy_interactions) {
    if(isDefined(var_9.trigger)) {
      var_9.trigger hidefromplayer(var_0);
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_9, var_0);
  }
}

set_rave_vision(var_0) {
  var_0 visionsetnakedforplayer("cp_rave_rave_mode", 1);
}

unset_rave_vision(var_0) {
  var_0 visionsetnakedforplayer("cp_rave", 1);
}

show_rave_objects(var_0) {
  var_1 = getEntArray("rave_objects", "script_noteworthy");
  foreach(var_3 in var_1) {
    var_3 showtoplayer(var_0);
  }

  update_rave_mode_doors();
  if(isDefined(level.active_archery_target)) {
    level.active_archery_target hidefromplayer(var_0);
  }

  if(!isDefined(level.zombie_heads)) {
    while(!isDefined(level.zombie_heads)) {
      wait(0.05);
    }
  }

  if(isDefined(level.zombie_heads)) {
    foreach(var_6 in level.zombie_heads) {
      var_6 hidefromplayer(var_0);
    }
  }

  foreach(var_9 in level.wall_buy_interactions) {
    if(scripts\engine\utility::istrue(var_9.should_be_hidden)) {
      continue;
    }

    if(isDefined(var_9.trigger)) {
      var_9.trigger showtoplayer(var_0);
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_9, var_0);
  }
}

update_rave_mode_doors() {
  var_0 = getEntArray("rave_door_buy", "targetname");
  foreach(var_2 in var_0) {
    var_2 makeusable();
    var_3 = getEntArray(var_2.target, "targetname");
    foreach(var_5 in level.players) {
      if(scripts\engine\utility::istrue(var_5.rave_mode)) {
        var_2 enableplayeruse(var_5);
      } else {
        var_2 disableplayeruse(var_5);
      }

      foreach(var_7 in var_3) {
        if(!isDefined(var_7.script_noteworthy)) {
          continue;
        }

        if(var_7.script_noteworthy == "rave_door") {
          if(scripts\engine\utility::istrue(var_5.rave_mode)) {
            var_7 showtoplayer(var_5);
          } else {
            var_7 hidefromplayer(var_5);
          }

          continue;
        }

        if(var_7.script_noteworthy == "normal_door") {
          if(scripts\engine\utility::istrue(var_5.rave_mode)) {
            var_7 hidefromplayer(var_5);
            continue;
          }

          var_7 showtoplayer(var_5);
        }
      }
    }
  }
}

cp_rave_spawn_fx_func() {
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

water_triggers() {
  spawn_water_trigger((-2736, 1478, -260));
  spawn_water_trigger((-2602, 1782, -260));
  spawn_water_trigger((-2370, 1912, -260));
  spawn_water_trigger((-2236, 2212, -260));
  var_0 = getEntArray("water_trigger", "targetname");
  scripts\engine\utility::array_thread(var_0, ::water_trigger);
}

water_trigger() {
  for(;;) {
    self waittill("trigger", var_0);
    if(!isplayer(var_0)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade) || isDefined(var_0.in_water)) {
      continue;
    }

    if(!isalive(var_0)) {
      continue;
    }

    var_0.in_water = 1;
    var_0 thread monitor_player_in_water(self);
  }
}

monitor_player_in_water(var_0) {
  self endon("disconnect");
  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    self.waterspeedscalar = 1;
    cp_rave_updatemovespeedscale();
    self.in_water = undefined;
    if(scripts\cp\cp_laststand::self_revive_activated()) {
      return;
    }

    if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\utility::has_zombie_perk("perk_machine_revive")) {
      return;
    }

    if(var_0.origin != (1218, -201, -48)) {
      move_player_to_closest_spot(self);
    }

    return;
  }

  if(scripts\engine\utility::istrue(self.noslowmovement)) {
    self.in_water = undefined;
    self.waterspeedscalar = 1;
    cp_rave_updatemovespeedscale();
    return;
  }

  scripts\engine\utility::allow_crouch(0);
  scripts\engine\utility::allow_prone(0);
  while(self istouching(var_0)) {
    if(self.waterspeedscalar > 0.5) {
      self.waterspeedscalar = self.waterspeedscalar - 0.05;
    } else {
      self.waterspeedscalar = 0.5;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      self.waterspeedscalar = 1;
      cp_rave_updatemovespeedscale();
      self.in_water = undefined;
      if(scripts\cp\cp_laststand::self_revive_activated()) {
        move_player_to_closest_spot(self);
        return;
      }

      if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\utility::has_zombie_perk("perk_machine_revive")) {
        return;
      }

      move_player_to_closest_spot(self);
      return;
    }

    cp_rave_updatemovespeedscale();
    wait(0.05);
  }

  if(scripts\engine\utility::istrue(self.disabledcrouch)) {
    scripts\engine\utility::allow_crouch(1);
  }

  if(scripts\engine\utility::istrue(self.disabledprone)) {
    scripts\engine\utility::allow_prone(1);
  }

  thread reset_move_speed();
}

reset_move_speed(var_0) {
  self endon("disconnect");
  self.in_water = undefined;
  wait(1);
  if(!scripts\engine\utility::istrue(self.in_water)) {
    if(scripts\engine\utility::istrue(self.disabledcrouch)) {
      scripts\engine\utility::allow_crouch(1);
    }

    if(scripts\engine\utility::istrue(self.disabledprone)) {
      scripts\engine\utility::allow_prone(1);
    }
  }

  while(!scripts\engine\utility::istrue(self.in_water)) {
    if(self.waterspeedscalar < 1) {
      self.waterspeedscalar = self.waterspeedscalar + 0.05;
      cp_rave_updatemovespeedscale();
      continue;
    }

    self.waterspeedscalar = 1;
    cp_rave_updatemovespeedscale();
    return;
    wait(0.05);
  }
}

move_player_to_closest_spot(var_0) {
  var_1 = get_closest_valid_respawn_struct(var_0);
  var_2 = var_1.origin + (0, 0, 20);
  var_3 = getgroundposition(var_2, 8, 32, 32);
  if(!isDefined(var_3)) {
    var_3 = var_1.origin;
  }

  var_0 setorigin(var_3);
  wait(0.5);
}

get_closest_valid_respawn_struct(var_0) {
  var_1 = sortbydistance(level.water_respawn_points, var_0.origin);
  foreach(var_3 in var_1) {
    if(canspawn(var_3.origin) && !positionwouldtelefrag(var_3.origin)) {
      return var_3;
    }
  }
}

setup_generic_zombie_model_list() {
  level.generic_zombie_model_list = ["zombie_male_outfit_dlc1_1", "zombie_male_outfit_dlc1_1_2", "zombie_male_outfit_dlc1_1_3", "zombie_male_outfit_dlc1_1_4", "zombie_male_outfit_dlc1_1_5", "zombie_male_outfit_dlc1_1_6", "zombie_male_outfit_dlc1_2", "zombie_male_outfit_dlc1_2_2", "zombie_male_outfit_dlc1_2_3", "zombie_male_outfit_dlc1_2_4", "zombie_male_outfit_dlc1_2_5", "zombie_male_outfit_dlc1_2_6", "zombie_male_outfit_dlc1_3", "zombie_male_outfit_dlc1_3_2", "zombie_male_outfit_dlc1_3_3", "zombie_male_outfit_dlc1_3_4", "zombie_male_outfit_dlc1_3_5", "zombie_male_outfit_dlc1_3_6", "zombie_male_outfit_dlc1_4", "zombie_male_outfit_dlc1_4_2", "zombie_male_outfit_dlc1_4_3", "zombie_male_outfit_dlc1_5", "zombie_male_outfit_dlc1_5_2", "zombie_male_outfit_dlc1_5_3", "zombie_male_outfit_dlc1_6", "zombie_male_outfit_dlc1_6_2", "zombie_male_outfit_dlc1_6_3", "zombie_male_outfit_dlc1_7", "zombie_male_outfit_dlc1_7_2", "zombie_male_outfit_dlc1_7_3", "zombie_female_outfit_dlc1_1", "zombie_female_outfit_dlc1_1_2", "zombie_female_outfit_dlc1_1_3", "zombie_female_outfit_dlc1_2", "zombie_female_outfit_dlc1_2_2", "zombie_female_outfit_dlc1_2_3", "zombie_female_outfit_dlc1_3", "zombie_female_outfit_dlc1_3_2", "zombie_female_outfit_dlc1_3_3", "zombie_female_outfit_dlc1_4", "zombie_female_outfit_dlc1_4_2", "zombie_female_outfit_dlc1_4_3", "zombie_female_outfit_dlc1_5", "zombie_female_outfit_dlc1_5_2", "zombie_female_outfit_dlc1_5_3", "zombie_female_outfit_dlc1_6", "zombie_female_outfit_dlc1_6_2", "zombie_female_outfit_dlc1_6_3"];
}

cp_rave_onzombiedamage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  return var_2;
}

cp_rave_lethaldamage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_5) && issubstr(var_5, "cos_092") && isDefined(var_1) && isplayer(var_1)) {
    playheadshotexplosioneffects(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }
}

registerraveperks() {
  registerraveperk("perk_machine_more", ::setravemore, ::unsetravemore);
  registerraveperk("perk_machine_tough", ::setravetough, ::unsetravetough);
  registerraveperk("perk_machine_revive", ::setraverevive, ::unsetraverevive);
  registerraveperk("perk_machine_flash", ::setraveflash, ::unsetraveflash);
  registerraveperk("perk_machine_rat_a_tat", ::setravebangbangs, ::unsetravebangbangs);
  registerraveperk("perk_machine_run", ::allownormalmovementinwater, ::forceslowmovementinwater);
  registerraveperk("perk_machine_fwoosh", ::setravefwoosh, ::unsetravefwoosh);
  registerraveperk("perk_machine_smack", ::setravesmack, ::unsetravesmack);
  registerraveperk("perk_machine_boom", ::setraveboom, ::unsetraveboom);
  registerraveperk("perk_machine_zap", ::setravezap, ::unsetravezap);
}

registerraveperk(var_0, var_1, var_2) {
  var_3 = level.coop_perk_callbacks[var_0];
  var_3.rave_set = var_1;
  var_3.rave_unset = var_2;
  level.coop_perk_callbacks[var_0] = var_3;
}

takeraveperk(var_0, var_1) {
  self[[level.coop_perk_callbacks[var_0].rave_unset]](var_0);
  var_2 = 0;
  switch (var_1) {
    case "cos_095":
      var_2 = 1;
      break;

    case "cos_086":
      var_2 = 2;
      break;

    case "cos_090":
      var_2 = 3;
      break;

    case "cos_089":
      var_2 = 4;
      break;

    case "cos_093":
      var_2 = 5;
      break;

    case "cos_085":
      var_2 = 6;
      break;

    case "cos_072":
      var_2 = 7;
      break;

    case "cos_091":
      var_2 = 8;
      break;

    case "cos_087":
      var_2 = 9;
      break;

    case "cos_092":
      var_2 = 10;
      break;

    default:
      break;
  }

  if(var_2 > 0) {
    self setclientomnvarbit("zm_charms_active", var_2, 0);
  }
}

giveraveperk(var_0, var_1) {
  self[[level.coop_perk_callbacks[var_0].rave_set]](var_0);
  var_2 = 0;
  switch (var_1) {
    case "cos_095":
      var_2 = 1;
      break;

    case "cos_086":
      var_2 = 2;
      break;

    case "cos_090":
      var_2 = 3;
      break;

    case "cos_089":
      var_2 = 4;
      break;

    case "cos_093":
      var_2 = 5;
      break;

    case "cos_085":
      var_2 = 6;
      break;

    case "cos_072":
      var_2 = 7;
      break;

    case "cos_091":
      var_2 = 8;
      break;

    case "cos_087":
      var_2 = 9;
      break;

    case "cos_092":
      var_2 = 10;
      break;

    default:
      break;
  }

  if(var_2 > 0) {
    if(!isDefined(self.charms_equipped)) {
      self.charms_equipped = [];
    }

    if(!isDefined(self.charms_equipped[var_1])) {
      self.charms_equipped[var_1] = 1;
      scripts\cp\cp_merits::processmerit("mt_dlc1_charms_added");
    }

    self setclientomnvarbit("zm_charms_active", var_2, 1);
  }
}

raveset(var_0) {
  if(!isDefined(self.rave_perks)) {
    self.rave_perks = 0;
  }

  self.rave_perks++;
}

raveunset(var_0) {
  if(!isDefined(self.rave_perks)) {
    self.rave_perks = 0;
  }

  self.rave_perks--;
}

setraveflash(var_0) {
  thread regen_ammo_while_stowed(self, var_0);
}

regen_ammo_while_stowed(var_0, var_1) {
  level endon("game_ended");
  var_0 endon(var_1 + "_removed");
  var_0 endon("disconnect");
  var_0 notify("regen_ammo_while_stowed");
  var_0 endon("regen_ammo_while_stowed");
  for(;;) {
    var_2 = var_0 scripts\cp\utility::getvalidtakeweapon();
    var_3 = var_0 getweaponslistprimaries();
    foreach(var_5 in var_3) {
      if(scripts\cp\utility::getrawbaseweaponname(var_5) == scripts\cp\utility::getrawbaseweaponname(var_2)) {
        continue;
      }

      if(scripts\cp\utility::isstrstart(var_5, "alt_")) {
        continue;
      }

      if(var_0 hasweapon(var_5)) {
        var_6 = var_0 getweaponammostock(var_5);
        if(var_6 >= 1) {
          var_7 = var_0 getweaponammoclip(var_5);
          if(var_7 < weaponclipsize(var_5)) {
            var_0 setweaponammoclip(var_5, var_7 + 1);
            if(var_0 getweaponammoclip(var_5) != var_7) {
              var_0 setweaponammostock(var_5, var_6 - 1);
            }
          }
        }
      }

      if(issubstr(var_5, "akimbo")) {
        var_6 = var_0 getweaponammostock(var_5);
        if(var_6 >= 1) {
          var_7 = var_0 getweaponammoclip(var_5, "left");
          if(var_7 < weaponclipsize(var_5)) {
            var_0 setweaponammoclip(var_5, var_7 + 1, "left");
            if(var_0 getweaponammoclip(var_5, "left") != var_7) {
              var_0 setweaponammostock(var_5, var_6 - 1);
            }
          }
        }
      }
    }

    wait(1);
  }
}

unsetraveflash(var_0) {
  self notify(var_0 + "_removed");
}

forcepushenemieswhilerunning(var_0, var_1) {
  level endon("game_ended");
  var_0 endon(var_1 + "_removed");
  var_0 endon("disconnect");
  for(;;) {
    while(var_0 issprinting()) {
      var_2 = checkenemiesinfov(35, 128, 2);
      var_3 = sortbydistance(var_2, var_0.origin);
      foreach(var_5 in var_3) {
        if(scripts\engine\utility::within_fov(var_0 getEye(), var_0.angles, var_5 getEye(), cos(65))) {
          var_5 thread killnearbyvictim(var_0, var_5.maxhealth, var_5.origin, var_0.origin, var_0.origin);
        }
      }

      wait(0.25);
    }

    wait(0.25);
  }
}

checkenemiesinfov(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = cos(var_0);
  var_4 = [];
  var_5 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_6 = scripts\engine\utility::get_array_of_closest(self.origin, var_5, undefined, 24, var_1, 1);
  foreach(var_8 in var_6) {
    var_9 = anglesToForward(self.angles);
    var_10 = vectornormalize(var_9) * -35;
    var_11 = 0;
    var_12 = var_8.origin;
    var_13 = scripts\engine\utility::within_fov(self getEye() + var_10, self.angles, var_12 + (0, 0, 30), var_3);
    if(var_13) {
      if(isDefined(var_1)) {
        var_14 = distance2d(self.origin, var_12);
        if(var_14 < var_1) {
          var_11 = 1;
        }
      } else {
        var_11 = 1;
      }
    }

    if(var_11 && var_4.size < var_2) {
      var_4[var_4.size] = var_8;
    }
  }

  return var_4;
}

setravemore(var_0) {
  scripts\cp\utility::_setperk("specialty_autoaimhead");
}

unsetravemore(var_0) {
  self notify(var_0 + "_removed");
  scripts\cp\utility::_unsetperk("specialty_autoaimhead");
}

setraveboom(var_0) {}

unsetraveboom(var_0) {
  self notify(var_0 + "_removed");
}

playheadshotexplosioneffects(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(scripts\mp\agents\zombie\zmb_zombie_agent::dying_zapper_death()) {
    return;
  }

  if(!scripts\engine\utility::isbulletdamage(var_4)) {
    return;
  }

  if(!scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1)) {
    return;
  }

  thread explodevictimshead(self, var_5, var_8, var_4, var_1);
}

explodevictimshead(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0.head_is_exploding = 1;
  var_5 = var_0 gettagorigin("J_Spine4");
  playsoundatpos(var_0.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect["bloody_death"], var_5);
  foreach(var_7 in level.players) {
    if(distance(var_7.origin, var_5) <= 350) {
      var_7 thread showonscreenbloodeffects();
    }
  }

  if(isDefined(var_0.headmodel)) {
    var_0 detach(var_0.headmodel);
  }

  if(!scripts\engine\utility::istrue(var_0.is_suicide_bomber)) {
    var_0 setscriptablepartstate("head", "hide");
  }
}

showonscreenbloodeffects() {
  self notify("turn_on_screen_blood_on");
  self endon("turn_on_screen_blood_on");
  self setscriptablepartstate("on_screen_blood", "on");
  scripts\engine\utility::waittill_any_timeout(2, "death", "last_stand");
  self setscriptablepartstate("on_screen_blood", "neutral");
}

setravefwoosh(var_0) {
  thread scripts\cp\perks\perkfunctions::setbattleslide();
}

unsetravefwoosh(var_0) {
  self notify(var_0 + "_removed");
  thread scripts\cp\perks\perkfunctions::unsetbattleslide();
}

allownormalmovementinwater(var_0) {
  self.noslowmovement = 1;
  scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
}

forceslowmovementinwater(var_0) {
  self notify(var_0 + "_removed");
  self.noslowmovement = undefined;
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
}

setravebangbangs(var_0) {
  if(!scripts\cp\utility::_hasperk("specialty_momentum")) {
    scripts\cp\utility::_setperk("specialty_momentum");
  }
}

unsetravebangbangs(var_0) {
  self notify(var_0 + "_removed");
  scripts\cp\utility::_unsetperk("specialty_momentum");
}

setravetough(var_0) {
  thread watchforplayerdamaged(self, var_0);
}

unsetravetough(var_0) {
  self notify(var_0 + "_removed");
}

watchforplayerdamaged(var_0, var_1) {
  var_0 notify("watchForPlayerDamaged");
  var_0 endon("watchForPlayerDamaged");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon(var_1 + "_removed");
  for(;;) {
    var_0 waittill("damage", var_2, var_3);
    if(isDefined(var_3.agent_type) && var_3.agent_type == "zombie_sasquatch" || var_3.agent_type == "slasher" || var_3.agent_type == "superslasher") {
      continue;
    }

    if(isDefined(var_3) && var_3 == var_0) {
      continue;
    }

    if(var_3.health >= 1) {
      var_3 thread setandunsetpain(var_3);
      var_3 dodamage(var_3.maxhealth * 0.2, var_0.origin, var_0, var_0, "MOD_UNKNOWN");
    }
  }
}

setandunsetpain(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0.allowpain = 1;
  wait(1);
  var_0.allowpain = 0;
}

setraverevive(var_0) {
  self.forcepushrevive = 1;
  thread waitforplayertorevive(self, var_0);
}

unsetraverevive(var_0) {
  self notify(var_0 + "_removed");
  self.forcepushrevive = undefined;
}

waitforplayertorevive(var_0, var_1) {
  var_0 notify("waitForPlayerToRevive");
  var_0 endon(var_1 + "_removed");
  var_0 endon("disconnect");
  var_0 endon("waitForPlayerToRevive");
  for(;;) {
    var_0 waittill("revive_teammate", var_2);
    var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_3, undefined, 24, 256);
    foreach(var_7, var_6 in var_4) {
      var_6 thread killnearbyvictim(var_0, var_6.maxhealth, var_6.origin, var_2.origin, var_2.origin);
      if(var_7 % 3 == 1) {
        scripts\engine\utility::waitframe();
      }
    }
  }
}

killnearbyvictim(var_0, var_1, var_2, var_3, var_4) {
  var_1 = self.maxhealth;
  var_5 = anglesToForward(var_0.angles);
  var_6 = vectornormalize(var_5) * -100;
  self setvelocity(vectornormalize(self.origin - var_4) * 800 + (0, 0, 300));
  self.do_immediate_ragdoll = 1;
  if(var_1 >= self.health) {
    self.customdeath = 1;
  }

  self dodamage(var_1, var_2, var_0, var_0, "MOD_IMPACT", "zom_repulsor_mp");
}

setravesmack(var_0) {
  thread watchforplayermeleedamage(self, var_0);
}

unsetravesmack(var_0) {
  self notify(var_0 + "_removed");
}

watchforplayermeleedamage(var_0, var_1) {
  var_0 endon(var_1 + "_removed");
  var_0 endon("disconnect");
  for(;;) {
    var_0 waittill("weapon_hit_enemy", var_2, var_3, var_4, var_5, var_6, var_7);
    if(!isDefined(var_3)) {
      continue;
    }

    if(!isplayer(var_3)) {
      continue;
    }

    if(var_3 != var_0) {
      continue;
    }

    if(isDefined(var_7) && var_7 == "MOD_MELEE") {
      var_0.health = var_0.maxhealth;
    }
  }
}

setravezap(var_0) {
  thread watchforblueboltactivation(self, var_0);
}

unsetravezap(var_0) {
  self notify(var_0 + "_removed");
}

watchforblueboltactivation(var_0, var_1) {
  var_0 endon(var_1 + "_removed");
  var_0 endon("disconnect");
  for(;;) {
    var_0 waittill("reload_start");
    var_2 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, [var_0], 3, 256);
    foreach(var_4 in var_2) {
      if(var_4 != var_0) {
        var_5 = var_4 getcurrentweapon();
        var_6 = weaponclipsize(var_5);
        var_7 = var_4 getweaponammoclip(var_5);
        var_8 = var_6 - var_7 / var_6;
        var_9 = max(1045 * var_8, 10);
        var_10 = max(128 * var_8, 48);
        var_4 thread scripts\cp\zombies\zombies_perk_machines::create_zap_ring(var_10, var_9);
      }
    }
  }
}

cp_rave_event_start(var_0) {
  switch (var_0) {
    case "team_rave_mode":
      level.vision_set_override = "cp_rave_rave_mode";
      level notify("rave_event_started");
      foreach(var_2 in level.players) {
        var_2 enter_rave_mode(var_2);
      }
      break;

    case "sasquatch_wave":
      level thread clown_wave_music();
      break;

    default:
      break;
  }
}

clown_wave_music() {
  wait(0.5);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_clownwave_wavestart", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  wait(3);
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

cp_rave_event_end(var_0) {
  switch (var_0) {
    case "team_rave_mode":
      level.vision_set_override = undefined;
      foreach(var_2 in level.players) {
        var_2 exit_rave_mode(var_2);
      }
      break;

    case "sasquatch_wave":
      level thread mus_rave_eventwave_end();
      break;

    default:
      break;
  }
}

cp_rave_event_selection(var_0) {
  return "sasquatch_wave";
}

guidedinteractionoffsetfunc(var_0, var_1) {
  var_2 = (0, 0, 68);
  var_3 = scripts\cp\cp_interaction::get_area_for_power(var_0);
  if(isDefined(var_0.script_noteworthy)) {
    var_4 = var_0.script_noteworthy;
    switch (var_4) {
      case "iw7_ripper_zmr":
        if(isDefined(var_3) && var_3 == "lake_shore") {
          var_2 = (0, 0, 0);
        }
        break;

      case "iw7_revolver_zm":
        if(isDefined(var_3) && var_3 == "cabin_to_lake") {
          var_2 = (0, 0, 20);
        }
        break;

      default:
        var_2 = (0, 0, 56);
        break;
    }
  }

  return var_2;
}

guidedinteractionsexclusions(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(var_1.rave_mode)) {
    return 0;
  }

  if(isDefined(var_2)) {
    switch (var_2) {
      case "interaction_packboat":
        if(level.boat_pieces_found < 3) {
          return 0;
        } else {
          return 1;
        }

        break;

      case "disco_toy_test":
      case "rave_toys":
      case "mushroom_patch":
      case "memory_quest_start_pos":
      case "computer":
      case "memory_vo_skull":
      case "atm_deposit":
      case "ritual_stone":
      case "atm_withdrawal":
        return 0;
    }
  }

  if(isDefined(var_0.script_noteworthy)) {
    switch (var_0.script_noteworthy) {
      case "memory_quest_end_pos":
      case "charge_animal_toys":
      case "animal_statue_end_pos":
      case "animal_statue_toys":
      case "survivor_interaction":
      case "iw7_slasher_zm":
      case "fix_pap":
      case "iw7_harpoon_zm":
      case "iw7_harpoon4_zm":
      case "iw7_harpoon3_zm+akimbo":
      case "iw7_harpoon2_zm":
      case "iw7_harpoon1_zm":
        return 0;
    }
  }

  if(isDefined(var_0.groupname) && var_0.groupname == "challenge") {
    return 0;
  }

  if(isDefined(var_0.script_label)) {
    if(!scripts\engine\utility::istrue(var_1.rave_mode)) {
      return 0;
    }
  }

  return 1;
}

blank() {}

deactivateadjacentvolumes() {
  level endon("game_ended");
  var_0 = level.active_spawn_volumes;
  if(!isDefined(level.volumes_before_fight)) {
    level.volumes_before_fight = level.active_spawn_volumes;
  }

  var_1 = getEntArray("placed_transponder", "script_noteworthy");
  foreach(var_3 in var_0) {
    if(var_3.basename == "island") {
      continue;
    }

    var_3 scripts\cp\zombies\zombies_spawning::make_volume_inactive();
    foreach(var_5 in var_1) {
      if(ispointinvolume(var_5.origin, var_3)) {
        var_5 notify("detonateExplosive");
      }
    }
  }

  while(!scripts\engine\utility::flag("disable_portals")) {
    wait(0.05);
  }

  scripts\engine\utility::flag_waitopen("disable_portals");
  foreach(var_9 in var_0) {
    var_9 scripts\cp\zombies\zombies_spawning::make_volume_active();
  }
}

cp_rave_should_run_event(var_0) {
  var_1 = var_0 - level.last_event_wave;
  if(var_1 < 5) {
    return 0;
  }

  if(scripts\engine\utility::flag_exist("defense_sequence_active") && scripts\engine\utility::flag("defense_sequence_active")) {
    return 0;
  }

  var_1 = var_1 - 4;
  var_2 = var_1 / 3 * 100;
  if(randomint(100) < var_2) {
    return 1;
  }

  return 0;
}

cp_rave_event_wave_init() {
  level.event_funcs["team_rave_mode"] = ::team_rave_event_func;
  level.event_funcs["sasquatch_wave"] = ::scripts\cp\zombies\cp_rave_spawning::goon_spawn_event_func;
  init_rave_spawner_locations();
}

init_rave_spawner_locations() {
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

team_rave_event_func() {
  level.static_enemy_types = ["generic_zombie"];
  level.dynamic_enemy_types = [];
  level.max_static_spawned_enemies = 24;
  level.max_dynamic_spawners = 0;
  level.desired_enemy_deaths_this_wave = int(scripts\engine\utility::ter_op(level.specialroundcounter >= 1, min(level.specialroundcounter * 25, 100), 25));
  level.current_enemy_deaths = 0;
  spawn_team_rave_zombies();
}

spawn_team_rave_zombies() {
  level endon("force_spawn_wave_done");
  level endon("game_ended");
  level.respawning_enemies = 0;
  level.num_goons_spawned = 0;
  level.current_spawn_group_index = 0;
  level.spawn_group = [];
  var_0 = 0;
  while(level.current_enemy_deaths < level.desired_enemy_deaths_this_wave) {
    while(scripts\engine\utility::istrue(level.zombies_paused) || scripts\engine\utility::istrue(level.nuke_zombies_paused)) {
      scripts\engine\utility::waitframe();
    }

    var_1 = scripts\cp\zombies\zombies_spawning::num_goons_to_spawn();
    var_2 = 0;
    if(isDefined(var_1) && var_1 >= 1) {
      var_2 = scripts\cp\zombies\zombies_spawning::spawn_zombie();
      var_0 = var_0 + var_2;
    }

    if(var_2 > 0) {
      wait(wait_spawns(var_0, level.desired_enemy_deaths_this_wave));
      continue;
    }

    wait(0.1);
  }

  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.stop_spawning = 1;
}

wait_spawns(var_0, var_1) {
  var_2 = 1.5;
  switch (level.specialroundcounter) {
    case 0:
      var_2 = 3;
      break;

    case 1:
      var_2 = 2;
      break;

    case 2:
      var_2 = 1.5;
      break;

    case 3:
      var_2 = 1;
      break;

    default:
      var_2 = 1;
      break;
  }

  var_2 = var_2 - var_0 / var_1;
  var_2 = max(var_2, 0.05);
  return var_2;
}

cp_rave_kill_reward(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_4)) {
    if(isDefined(level.melee_weapons) && scripts\engine\utility::array_contains(level.melee_weapons, getweaponbasename(var_4))) {
      return 60;
    }

    if(isDefined(var_1) && isplayer(var_1) && scripts\engine\utility::istrue(var_1.rave_mode)) {
      return var_6 * 2;
    }

    return var_6;
  }

  if(isDefined(var_1) && isplayer(var_1) && level.slasher_fight) {
    return 0;
  }

  if(isDefined(var_1) && isplayer(var_1) && scripts\engine\utility::istrue(var_1.rave_mode)) {
    return var_6 * 2;
  }

  return var_6;
}

cp_rave_exit_laststand_func(var_0) {
  var_0 scripts\cp\powers\coop_powers::restore_powers(var_0, var_0.pre_laststand_powers);
  var_0 scripts\cp\zombies\zombies_loadout::set_player_photo_status(var_0, "healthy");
  var_0.flung = undefined;
  var_0 setclientomnvar("zm_ui_player_in_laststand", 0);
  var_0 clearclienttriggeraudiozone(0.5);
  var_0 stoplocalsound("zmb_laststand_music");
  var_0 clearclienttriggeraudiozone(0.3);
  if(isDefined(level.vision_set_override)) {
    var_0 thread reset_override_visionset(0.2, level.vision_set_override);
  } else if(isDefined(var_0.vision_set_override)) {
    var_0 thread reset_override_visionset(0.2, var_0.vision_set_override);
  }

  var_0 visionsetnakedforplayer("", 0.1);
  var_1 = randomintrange(1, 5);
  var_2 = "zmb_revive_music_lr_0" + var_1;
  if(soundexists(var_2)) {
    var_0 playlocalsound(var_2);
  }

  if(var_0 scripts\cp\utility::isignoremeenabled()) {
    var_0 scripts\cp\utility::allow_player_ignore_me(0);
  }

  if(scripts\engine\utility::istrue(var_0.have_permanent_perks) && !scripts\engine\utility::istrue(var_0.playing_ghosts_n_skulls)) {
    var_0 thread scripts\cp\gametypes\zombie::give_permanent_perks(var_0);
  }
}

reset_override_visionset(var_0, var_1) {
  wait(var_0);
  if(isDefined(var_1)) {
    self visionsetnakedforplayer(var_1, 0.1);
  }
}

cp_rave_updatemovespeedscale() {
  var_0 = undefined;
  if(isDefined(self.playerstreakspeedscale)) {
    var_0 = 1;
    var_0 = var_0 + self.playerstreakspeedscale;
  } else {
    var_0 = scripts\cp\zombies\zombies_loadout::getplayerspeedbyweapon(self);
    if(isDefined(self.chargemode_speedscale)) {
      var_0 = self.chargemode_speedscale;
    } else if(isDefined(self.siege_speedscale)) {
      var_0 = self.siege_speedscale;
    }

    var_1 = self.chill_data;
    if(isDefined(var_1) && isDefined(var_1.speedmod)) {
      var_0 = var_0 + var_1.speedmod;
    }

    if(isDefined(self.speedstripmod)) {
      var_0 = var_0 + self.speedstripmod;
    }

    if(isDefined(self.phasespeedmod)) {
      var_0 = var_0 + self.phasespeedmod;
    }

    if(isDefined(self.weaponaffinityspeedboost)) {
      var_0 = var_0 + self.weaponaffinityspeedboost;
    }

    if(isDefined(self.weaponpassivespeedmod)) {
      var_0 = var_0 + self.weaponpassivespeedmod;
    }

    if(isDefined(self.weaponpassivespeedonkillmod)) {
      var_0 = var_0 + self.weaponpassivespeedonkillmod;
    }

    var_0 = min(1.5, var_0);
  }

  self.weaponspeed = var_0;
  if(!isDefined(self.combatspeedscalar)) {
    self.combatspeedscalar = 1;
  }

  if(!isDefined(self.waterspeedscalar) || !isDefined(self.customweaponspeedscalar)) {
    self.waterspeedscalar = 1;
    self.customweaponspeedscalar = 1;
  }

  self setmovespeedscale(var_0 * self.movespeedscaler * self.combatspeedscalar * self.waterspeedscalar * self.customweaponspeedscalar);
}

rave_add_attachment_to_weapon(var_0, var_1) {
  var_2 = var_1 scripts\cp\utility::getvalidtakeweapon();
  if(!can_use_charm_attachment(var_2, var_0)) {
    return 0;
  }

  var_1 notify("weapon_purchased");
  var_3 = getweaponattachments(var_2);
  var_4 = scripts\cp\utility::getbaseweaponname(var_2);
  var_5 = var_1 scripts\cp\utility::getweaponreticle(var_4);
  var_6 = undefined;
  if(var_1 isdualwielding()) {
    var_6 = var_1 getweaponammoclip(var_2, "left");
  }

  var_7 = var_1 getweaponammoclip(var_2, "right");
  var_8 = var_1 getweaponammostock(var_2);
  if(issubstr(var_2, "+camo")) {
    var_9 = getweaponcamoname(var_2);
  } else {
    var_9 = var_2 scripts\cp\utility::getweaponcamo(var_5);
  }

  var_10 = var_1 scripts\cp\utility::getweaponpaintjobid(var_4);
  foreach(var_12 in var_3) {
    if(issubstr(var_12, "cos_")) {
      var_3 = scripts\engine\utility::array_remove(var_3, var_12);
    }
  }

  var_14 = scripts\cp\utility::mpbuildweaponname(scripts\cp\utility::getweaponrootname(var_2), var_3, var_9, var_5, scripts\cp\utility::get_weapon_variant_id(var_1, var_2), var_1 getentitynumber(), var_1.clientid, var_10, var_0);
  if(isDefined(var_14)) {
    var_1 takeweapon(var_2);
    var_1 scripts\cp\utility::_giveweapon(var_14, undefined, undefined, 1);
    var_1 switchtoweapon(var_14);
    var_1 setweaponammoclip(var_14, var_7, "right");
    var_1 setweaponammostock(var_14, var_8);
    if(isDefined(var_6)) {
      var_1 setweaponammoclip(var_14, var_6, "left");
    }
  }

  foreach(var_10 in var_1 getweaponslistall()) {
    var_3 = getweaponattachments(var_10);
    foreach(var_12 in var_3) {
      if(issubstr(var_12, "cos_")) {
        if(isDefined(level.rave_charm_attachment_perks[var_12])) {
          var_1 giveraveperk(level.rave_charm_attachment_perks[var_12], var_12);
        }
      }
    }
  }

  return 1;
}

can_use_charm_attachment(var_0, var_1) {
  var_2 = scripts\cp\utility::getrawbaseweaponname(var_0);
  switch (var_2) {
    case "lockon":
    case "fists":
    case "slasher":
    case "glprox":
    case "chargeshot":
    case "spiked":
    case "golf":
    case "two":
    case "forgefreeze":
    case "axe":
    case "harpoon":
    case "harpoon4":
    case "harpoon3":
    case "harpoon2":
    case "harpoon1":
    case "knife":
    case "machete":
      return 0;

    default:
      return 1;
  }
}

set_charm_icon(var_0) {
  if(!isDefined(level.charms_collected)) {
    level.charms_collected = 0;
  }

  set_charm_icon_internal(var_0);
  level.charms_collected++;
}

set_charm_icon_internal(var_0) {
  setomnvarbit("zm_secondary_quest_pieces", var_0, 1);
}

cp_rave_currency_scalar_func(var_0, var_1) {
  if(isDefined(var_0.rave_cash_scalar)) {
    var_1 = var_1 * var_0.rave_cash_scalar;
  }

  return int(var_1);
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

play_char_intro_gesture() {
  self endon("disconnect");
  level endon("game_ended");
  self setweaponammostock(self.intro_gesture, 1);
  self giveandfireoffhand(self.intro_gesture);
  if(isDefined(self.vo_prefix) && self.vo_prefix == "p2_") {
    thread activate_glow_stick_glow();
  }

  if(isDefined(self.vo_prefix) && self.vo_prefix == "p4_") {
    thread throw_money();
  }

  wait(waitgesturelength());
  if(self hasweapon("iw7_gunless_zm")) {
    self takeweapon("iw7_gunless_zm");
  }

  var_0 = get_char_fist_weapon(self);
  scripts\cp\utility::_giveweapon(var_0, undefined, undefined, 1);
  self switchtoweapon(var_0);
  self.starting_weapon = var_0;
  self.default_starting_pistol = var_0;
  var_1 = scripts\cp\zombies\zombies_loadout::get_player_character_num();
  level.player_character_info[var_1].starting_weapon = var_0;
  level notify("start_pa_music");
  self notify("finish_intro_gesture");
}

get_char_fist_weapon(var_0) {
  var_1 = "iw7_fists_zm";
  if(isDefined(var_0.vo_prefix)) {
    switch (var_0.vo_prefix) {
      case "p1_":
        return "iw7_fists_zm_chola";

      case "p2_":
        return "iw7_fists_zm_raver";

      case "p3_":
        return "iw7_fists_zm_grunge";

      case "p4_":
        return "iw7_fists_zm_hiphop";

      case "p5_":
        return "iw7_fists_zm_kevinsmith";

      default:
        return "iw7_fists_zm";
    }

    return;
  }

  return var_1;
}

throw_money() {
  self endon("disconnect");
  wait(2);
  self setscriptablepartstate("money", "throw_money");
}

activate_glow_stick_glow() {
  self endon("disconnect");
  wait(1.35);
  self setscriptablepartstate("glow_stick", "activated");
}

waitgesturelength() {
  switch (self.vo_prefix) {
    case "p1_":
      return self getgestureanimlength("ges_load_in_chola");

    case "p2_":
      return self getgestureanimlength("ges_load_in_raver");

    case "p3_":
      return self getgestureanimlength("ges_load_in_grunge");

    case "p4_":
      return self getgestureanimlength("ges_load_in_hiphop") - 0.5;

    case "p5_":
      return self getgestureanimlength("ges_load_in_survivor");

    default:
      return 3;
  }
}

cp_rave_mutilation_mask_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
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

adjust_struct_positions() {}

move_struct(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getclosest(var_0, level.struct, 500);
  var_3.origin = var_1;
  if(isDefined(var_2)) {
    var_3.angles = var_2;
  }
}

survivor_logic() {
  var_0 = scripts\engine\utility::getstruct("slasher_pos", "targetname");
  level.survivor = spawn("script_model", var_0.origin);
  level.survivor.angles = var_0.angles;
  level.survivor setModel("zmb_world_k_smith");
  var_1 = [ % iw7_cp_survivor_cabin_idle_01, %iw7_cp_survivor_cabin_idle_02];
  var_2 = ["IW7_cp_survivor_cabin_idle_01", "IW7_cp_survivor_cabin_idle_02"];
  var_3 = 0;
  for(;;) {
    var_4 = getanimlength(var_1[var_3]);
    level.survivor scriptmodelplayanimdeltamotionfrompos(var_2[var_3], var_0.origin + (0, 0, 3), var_0.angles, 1);
    wait(var_4);
    var_3++;
    if(var_3 > 1) {
      var_3 = 0;
    }
  }
}

rockwall_logic() {
  var_0 = getent("rockwall", "targetname");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isplayer(var_1)) {
      continue;
    }

    if(isDefined(var_1.on_rockwall)) {
      continue;
    }

    var_1 thread player_rockwall_logic(var_0);
  }
}

player_rockwall_logic(var_0) {
  self endon("disconnect");
  self.on_rockwall = 1;
  self setonwallanimconditional(1);
  while(self istouching(var_0)) {
    wait(1);
  }

  self setonwallanimconditional(0);
  self.on_rockwall = undefined;
}

cp_rave_auto_melee_agent_type_check(var_0) {
  if(var_0.agent_type == "zombie_sasquatch" || var_0.agent_type == "slasher" || var_0.agent_type == "superslasher") {
    return 0;
  }

  return 1;
}

setup_pool_balls() {
  level endon("gamed_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = scripts\engine\utility::getstructarray("pool_balls", "targetname");
  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    if(isDefined(var_2.angles)) {
      var_3.angles = var_2.angles;
    }

    if(isDefined(var_2.script_noteworthy)) {
      var_3 setModel(var_2.script_noteworthy);
    } else {
      var_3 setModel("cp_rave_pool_ball_01");
    }

    var_2.model = var_3;
  }
}

setup_glyph_targets() {
  level endon("gamed_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = scripts\engine\utility::getstructarray("ee_song_structs", "targetname");
  var_0 = scripts\engine\utility::array_randomize_objects(var_0);
  level.total_glyphs_to_find = int(var_0.size);
  level.total_glyphs_found = 0;
  for(var_1 = 0; var_1 < 10; var_1++) {
    var_2 = spawn("script_model", var_0[var_1].origin);
    var_2 setModel("tag_origin_ee_song_quest");
    var_2.angles = var_0[var_1].angles;
    var_2 thread glyph_watch_for_player_interaction(var_2, var_0[var_1], "glyph" + var_1 + 1);
  }
}

glyph_watch_for_player_interaction(var_0, var_1, var_2) {
  level endon("game_ended");
  while(!scripts\engine\utility::istrue(var_0.found)) {
    if(!isDefined(level.someones_in_rave) || !level.someones_in_rave) {
      var_0 setscriptablepartstate("glyph", "neutral");
      foreach(var_4 in level.players) {
        var_0 hidefromplayer(var_4);
      }

      level waittill("player_entered_rave");
    }

    foreach(var_4 in level.players) {
      if(scripts\engine\utility::istrue(var_4.rave_mode)) {
        var_0 showtoplayer(var_4);
      } else {
        var_0 hidefromplayer(var_4);
      }

      if(scripts\engine\utility::istrue(var_4.ee_song_tracking)) {
        continue;
      }

      if(var_4 adsbuttonpressed()) {
        var_4 thread check_ads_validity(var_4, var_0);
      }
    }

    wait(0.2);
  }

  var_0 setscriptablepartstate("glyph", var_2);
  level.total_glyphs_found++;
}

check_ads_validity(var_0, var_1) {
  var_2 = 0;
  var_3 = 1;
  var_0.ee_song_tracking = 1;
  while(var_0 worldpointinreticle_circle(var_1.origin, 65, 15)) {
    wait(0.05);
    var_2 = var_2 + 0.05;
    if(var_2 >= var_3) {
      var_0.ee_song_tracking = 0;
      var_1.found = 1;
      return 1;
    }
  }

  var_0.ee_song_tracking = 0;
  return 0;
}

rave_set_interaction_trigger_properties(var_0, var_1, var_2) {
  if(!isDefined(var_1.script_noteworthy)) {
    return;
  }

  if(var_1.script_noteworthy == "memory_quest_start_pos" || var_1.script_noteworthy == "memory_quest_end_pos" || var_1.script_noteworthy == "ring_quest_lights" || var_1.script_noteworthy == "animal_statue_toys" || var_1.script_noteworthy == "animal_statue_end_pos" || var_1.script_noteworthy == "charge_animal_toys" || var_1.script_noteworthy == "survivor_interaction" || var_1.script_noteworthy == "boat_quest_piece" || var_1.script_noteworthy == "ritual_stone" || var_1.script_noteworthy == "pap_quest_piece" || var_1.script_noteworthy == "mushroom_patch") {
    self.interaction_trigger usetriggerrequirelookat(0);
    self.interaction_trigger setusefov(360);
  }

  if(var_1.script_noteworthy == "charge_animal_toys") {
    self.interaction_trigger usetriggerrequirelookat(1);
    self.interaction_trigger setusefov(160);
  }
}

give_harpoon_weapon(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = self getweaponslistprimaries();
  var_6 = var_5.size;
  var_7 = 3;
  var_8 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
  var_9 = 1;
  var_9 = 0;
  var_0.trigger hide();
  var_0 scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  thread watch_for_weapon_removed(var_0, self);
  if(!scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
    self notify("weapon_purchased");
    var_10 = scripts\cp\utility::getvalidtakeweapon();
    self.curr_weap = var_10;
    if(isDefined(var_10)) {
      var_2 = 1;
      var_11 = scripts\cp\utility::getrawbaseweaponname(var_10);
      if(scripts\cp\utility::has_special_weapon() && var_6 < var_7 + 1) {
        var_2 = 0;
      }

      foreach(var_13 in var_5) {
        if(scripts\cp\utility::isstrstart(var_13, "alt_")) {
          var_7++;
        }
      }

      if(scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
        var_7++;
      }

      if(var_5.size < var_7) {
        var_2 = 0;
      }

      if(var_2) {
        if(isDefined(self.pap[var_11])) {
          self.pap[var_11] = undefined;
          self notify("weapon_level_changed");
        }

        thread scripts\cp\cp_interaction::play_weapon_purchase_vo(var_0, self);
        self takeweapon(var_10);
      }
    }

    if(isDefined(self.weapon_build_models[var_8])) {
      var_3 = self.weapon_build_models[var_8];
    } else {
      var_3 = var_0.weapon;
    }

    var_15 = getweaponattachments(var_3);
    var_10 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_3, undefined, var_15);
    var_10 = scripts\cp\utility::_giveweapon(var_10, undefined, undefined, var_9);
    self.itempicked = var_10;
    level.transactionid = randomint(100);
    scripts\cp\zombies\zombie_analytics::log_purchasingaweapon(1, self, self.itempicked, self.curr_weap, level.wave_num, var_0.name, self.wavesheldwithweapon, self.killsperweaponlog, self.downsperweaponlog);
    removefistsweapons(var_5);
    var_11 = spawnStruct();
    var_11.lvl = 1;
    self.pap[var_8] = var_11;
    self notify("wor_item_pickup", var_10);
    if(var_0.trigger.cost > 1) {
      scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
    }

    if(isDefined(var_10) && isDefined(var_0.clip)) {
      self setweaponammoclip(var_10, var_0.clip);
    }

    if(isDefined(var_10) && isDefined(var_0.left_clip)) {
      self setweaponammoclip(var_10, var_0.left_clip, "left");
    }

    if(isDefined(var_10) && isDefined(var_0.stock)) {
      self setweaponammostock(var_10, var_0.stock);
    } else {
      self givemaxammo(var_10);
    }

    self notify("weapon_level_changed");
    self switchtoweapon(var_10);
    wait(0.25);
    while(self isswitchingweapon()) {
      wait(0.05);
    }

    thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
  } else {
    self notify("weapon_purchased");
    self.purchasing_ammo = 1;
    var_8 = undefined;
    var_12 = self getweaponslistall();
    var_13 = self getcurrentweapon();
    var_14 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
    var_15 = undefined;
    foreach(var_17 in var_12) {
      var_8 = scripts\cp\utility::getrawbaseweaponname(var_17);
      if(var_8 == var_14) {
        var_15 = var_17;
        break;
      }
    }

    var_19 = weaponmaxammo(var_15);
    var_1A = scripts\cp\perks\prestige::prestige_getminammo();
    var_1B = int(var_1A * var_19);
    var_1C = self getweaponammostock(var_15);
    if(var_1C < var_1B) {
      self setweaponammostock(var_15, var_1B);
    }

    thread scripts\cp\cp_vo::try_to_play_vo("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 1, 50);
  }

  wait(0.05);
  self.purchasing_ammo = undefined;
  scripts\cp\cp_interaction::refresh_interaction();
}

cp_rave_give_weapon(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = self getweaponslistprimaries();
  var_6 = var_5.size;
  var_7 = 3;
  var_8 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
  var_9 = 1;
  if(scripts\cp\utility::weapon_is_dlc_melee(var_0.script_noteworthy) || var_0.script_noteworthy == "iw7_harpoon_zm") {
    var_9 = 0;
    var_0.trigger hide();
    var_0 scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    thread watch_for_weapon_removed(var_0, self);
  } else if(var_8 == "harpoon") {
    var_9 = 0;
    var_0.trigger hide();
    var_0 scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    thread watch_for_weapon_removed(var_0, self);
  }

  if(!scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
    var_10 = scripts\cp\utility::getvalidtakeweapon();
    self.curr_weap = var_10;
    if(isDefined(var_10)) {
      self notify("weapon_purchased");
      var_2 = 1;
      var_11 = scripts\cp\utility::getrawbaseweaponname(var_10);
      if(scripts\cp\utility::has_special_weapon() && var_6 < var_7 + 1) {
        var_2 = 0;
      }

      foreach(var_13 in var_5) {
        if(scripts\cp\utility::isstrstart(var_13, "alt_")) {
          var_7++;
        }
      }

      if(scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
        var_7++;
      }

      if(var_5.size < var_7) {
        var_2 = 0;
      }

      if(var_2) {
        if(isDefined(self.pap[var_11])) {
          self.pap[var_11] = undefined;
          self notify("weapon_level_changed");
        }

        thread scripts\cp\cp_interaction::play_weapon_purchase_vo(var_0, self);
        self takeweapon(var_10);
      }
    }

    if(isDefined(self.weapon_build_models[var_8])) {
      var_3 = self.weapon_build_models[var_8];
    } else {
      var_3 = var_0.weapon;
    }

    if(scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::can_upgrade(var_3) && scripts\cp\utility::is_consumable_active("wall_power")) {
      self notify("weapon_purchased");
      var_4 = scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::get_pap_camo(2, var_8, var_3);
      var_15 = scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::return_pap_attachment(var_1, 2, var_8, var_3);
      if(isDefined(var_15) && var_15 != "replace_me") {
        var_10 = scripts\engine\utility::array_combine(getweaponattachments(var_3), ["pap1"]);
      } else {
        var_10 = getweaponattachments(var_3);
      }

      var_11 = scripts\cp\utility::getrawbaseweaponname(var_3);
      var_12 = spawnStruct();
      var_12.lvl = 1;
      self.pap[var_11] = var_12;
      var_13 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_3, undefined, var_10, undefined, var_4);
      var_13 = scripts\cp\utility::_giveweapon(var_13, undefined, undefined, var_9);
      self.pap[var_11].lvl++;
      scripts\cp\cp_merits::processmerit("mt_upgrade_weapons");
      scripts\cp\utility::notify_used_consumable("wall_power");
      removefistsweapons(var_5);
    } else {
      self notify("weapon_purchased");
      var_10 = getweaponattachments(var_6);
      var_13 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_5, undefined, var_13);
      var_13 = scripts\cp\utility::_giveweapon(var_13, undefined, undefined, var_9);
      self.itempicked = var_13;
      level.transactionid = randomint(100);
      scripts\cp\zombies\zombie_analytics::log_purchasingaweapon(1, self, self.itempicked, self.curr_weap, level.wave_num, var_0.name, self.wavesheldwithweapon, self.killsperweaponlog, self.downsperweaponlog);
      removefistsweapons(var_5);
      var_12 = spawnStruct();
      var_12.lvl = 1;
      self.pap[var_8] = var_12;
    }

    self notify("wor_item_pickup", var_13);
    if(var_0.trigger.cost > 1) {
      scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
    }

    if(issubstr(var_0.script_noteworthy, "iw7_slasher_zm")) {
      if(isDefined(self.saw_clip)) {
        self setweaponammoclip(var_13, self.saw_clip);
      }

      if(issubstr(var_0.script_noteworthy, "+akimbo") && !isDefined(self.saw_left_clip)) {
        self setweaponammoclip(var_13, self.saw_left_clip, "left");
      }

      if(isDefined(self.saw_stock)) {
        self setweaponammostock(var_13, self.saw_stock);
      } else {
        self givemaxammo(var_13);
      }
    } else {
      self givemaxammo(var_13);
    }

    self notify("weapon_level_changed");
    self switchtoweapon(var_13);
    wait(0.25);
    while(self isswitchingweapon()) {
      wait(0.05);
    }

    thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
  } else {
    self notify("weapon_purchased");
    self.purchasing_ammo = 1;
    var_8 = undefined;
    var_14 = self getweaponslistall();
    var_15 = self getcurrentweapon();
    var_16 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
    var_17 = undefined;
    foreach(var_19 in var_14) {
      var_8 = scripts\cp\utility::getrawbaseweaponname(var_19);
      if(var_8 == var_16) {
        var_17 = var_19;
        break;
      }
    }

    var_1B = weaponmaxammo(var_17);
    var_1C = scripts\cp\perks\prestige::prestige_getminammo();
    var_1D = int(var_1C * var_1B);
    var_1E = self getweaponammostock(var_17);
    if(var_1E < var_1D) {
      self setweaponammostock(var_17, var_1D);
    }

    thread scripts\cp\cp_vo::try_to_play_vo("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 1, 50);
  }

  wait(0.05);
  self.purchasing_ammo = undefined;
  scripts\cp\cp_interaction::refresh_interaction();
}

removefistsweapons(var_0) {
  foreach(var_2 in var_0) {
    if(issubstr(var_2, "iw7_fists")) {
      self takeweapon(var_2);
    }
  }
}

watch_for_weapon_removed(var_0, var_1) {
  var_0 notify("watch_for_weapon_removed");
  var_0 thread wait_for_weapon_disowned(var_0, var_1);
  level thread watch_player_disconnect(var_0, var_1);
  var_1 thread wait_for_weapon_removed(var_0, var_1);
  var_1 thread wait_for_player_death(var_0, var_1);
}

watch_player_disconnect(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("watch_for_weapon_removed");
  var_0 endon("watch_for_weapon_removed_" + var_1.name);
  var_0 endon("weapon_disowned_" + var_0.script_noteworthy);
  var_1 waittill("disconnect");
  var_0 notify("weapon_disowned_" + var_0.script_noteworthy);
}

wait_for_player_death(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_0 endon("weapon_disowned_" + var_0.script_noteworthy);
  var_2 = 1;
  for(;;) {
    if(!var_2) {
      break;
    }

    var_3 = undefined;
    var_1 waittill("last_stand");
    var_2 = 0;
    var_4 = var_1 scripts\engine\utility::waittill_any_return_no_endon_death_3("player_entered_ala", "revive", "death");
    if(var_4 != "revive") {
      var_3 = var_1 scripts\engine\utility::waittill_any_return("lost_and_found_collected", "lost_and_found_time_out");
      if(isDefined(var_3) && var_3 == "lost_and_found_time_out") {
        continue;
      }
    }

    var_5 = var_1 getweaponslistall();
    foreach(var_7 in var_5) {
      if(issubstr(getweaponbasename(var_7), getweaponbasename(var_0.script_noteworthy))) {
        var_1 thread wait_for_weapon_removed(var_0, var_1);
        var_2 = 1;
        break;
      }
    }
  }

  var_0 notify("weapon_disowned_" + var_0.script_noteworthy);
}

wait_for_weapon_removed(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("last_stand");
  var_1 endon("disconnect");
  var_0 endon("watch_for_weapon_removed");
  var_0 endon("weapon_disowned_" + var_0.script_noteworthy);
  var_2 = 1;
  for(;;) {
    if(!var_2) {
      break;
    }

    var_1 scripts\engine\utility::waittill_any("weapon_purchased", "mule_munchies_sold");
    var_2 = 0;
    var_3 = var_1 getweaponslistall();
    foreach(var_5 in var_3) {
      if(issubstr(getweaponbasename(var_5), getweaponbasename(var_0.script_noteworthy))) {
        var_2 = 1;
        break;
      }
    }
  }

  var_0 notify("weapon_disowned_" + var_0.script_noteworthy);
}

wait_for_weapon_disowned(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("watch_for_weapon_removed");
  var_0.should_be_hidden = 1;
  var_0 waittill("weapon_disowned_" + var_0.script_noteworthy);
  var_0.should_be_hidden = undefined;
  var_0 scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  if(isDefined(var_1)) {
    var_0 scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_0, var_1);
  }

  var_0.trigger show();
}

get_camo_for_wall_buy(var_0, var_1, var_2) {
  var_3 = undefined;
  if(var_1 scripts\cp\utility::is_consumable_active("wall_power")) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_2)) {
      var_3 = undefined;
    } else if(isDefined(level.pap_1_camo)) {
      var_3 = level.pap_1_camo;
    }
  }

  return var_3;
}

rave_ephemeral_camo(var_0, var_1, var_2) {
  var_3 = scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::get_pap_camo(var_0.pap[var_1].lvl + 1, var_1, var_2);
  return var_3;
}

rave_ephemeral_weapon(var_0, var_1, var_2) {
  return var_2;
}

rave_ephemeral_attachment(var_0, var_1, var_2) {
  var_3 = scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::return_pap_attachment(var_0, var_0.pap[var_1].lvl + 1, var_1, var_2, 1);
  return var_3;
}

rave_getweaponnamestring(var_0, var_1) {
  var_2 = issubstr(var_1, "_pap1");
  var_3 = issubstr(var_1, "_pap2");
  switch (var_0) {
    case "iw7_two":
      if(var_2) {
        return &"CP_RAVE_WEAPONS_TWO_HEADED_AXE_PAP1";
      } else if(var_3) {
        return &"CP_RAVE_WEAPONS_TWO_HEADED_AXE_PAP2";
      } else {
        return &"CP_RAVE_WEAPONS_TWO_HEADED_AXE";
      }

      break;

    case "iw7_machete":
      if(var_2) {
        return &"CP_RAVE_WEAPONS_MACHETE_PAP1";
      } else if(var_3) {
        return &"CP_RAVE_WEAPONS_MACHETE_PAP2";
      } else {
        return &"CP_RAVE_WEAPONS_MACHETE";
      }

      break;

    case "iw7_spiked":
      if(var_2) {
        return &"CP_RAVE_WEAPONS_BAT_PAP1";
      } else if(var_3) {
        return &"CP_RAVE_WEAPONS_BAT_PAP2";
      } else {
        return &"CP_RAVE_WEAPONS_BAT";
      }

      break;

    case "iw7_slasher":
      return &"CP_RAVE_WEAPONS_SLASHER_SAW";

    case "iw7_harpoon":
      return &"CP_RAVE_WEAPONS_HARPOON";

    case "iw7_harpoon1":
      return &"CP_RAVE_WEAPONS_HARPOON1";

    case "iw7_harpoon2":
      return &"CP_RAVE_WEAPONS_HARPOON2";

    case "iw7_harpoon3":
      return &"CP_RAVE_WEAPONS_HARPOON3";

    case "iw7_harpoon4":
      return &"CP_RAVE_WEAPONS_HARPOON4";

    case "iw7_golf":
      if(var_2) {
        return &"CP_RAVE_WEAPONS_GOLF_CLUB_PAP1";
      } else if(var_3) {
        return &"CP_RAVE_WEAPONS_GOLF_CLUB_PAP2";
      } else {
        return &"CP_RAVE_WEAPONS_GOLF_CLUB";
      }

      break;

    default:
      return &"CP_ZMB_WEAPONS_GENERIC";
  }
}

spawn_afterlife_speaker() {
  var_0 = (-10101.5, -317, -1661.5);
  var_1 = (0, 180, 90);
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("ehq_speaker_monitor_01");
  level.willard_speaker = var_2;
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

adjust_player_spawn_pos() {
  var_0 = scripts\engine\utility::getstructarray("default_player_start", "targetname");
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    switch (var_1) {
      case 0:
        var_2.origin = (-941, -1619, 224);
        var_2.angles = (0, 168, 0);
        break;

      case 1:
        var_2.origin = (-942, -1555, 224);
        var_2.angles = (0, 185, 0);
        break;

      case 2:
        var_2.origin = (-957, -1456, 224);
        var_2.angles = (0, 208, 0);
        break;

      case 3:
        var_2.origin = (-981, -1695, 224);
        var_2.angles = (0, 155, 0);
        break;
    }
  }
}

cp_rave_goon_spawner_patch_func(var_0) {
  remove_goon_spawner((1956, -1878, 46), var_0);
  remove_goon_spawner((-4852.5, 6318.4, -168), var_0);
}

remove_goon_spawner(var_0, var_1) {
  var_2 = scripts\engine\utility::getclosest(var_0, var_1, 500);
  var_2.remove_me = 1;
}

cp_rave_patch_update_spawners() {
  scripts\cp\zombies\zombies_spawning::remove_origin((-3431.8, -1972.2, 29.7));
  scripts\cp\zombies\zombies_spawning::remove_origin((-575.5, -196.3, 264.8));
  scripts\cp\zombies\zombies_spawning::remove_origin((1564.9, -1678.4, 241.7));
  scripts\cp\zombies\zombies_spawning::remove_origin((1717.4, -1529.4, 241.7));
  scripts\cp\zombies\zombies_spawning::remove_origin((-4921.2, 6328, -110.9));
  scripts\cp\zombies\zombies_spawning::update_origin((-2614.5, 283.6, -115.5), (-2664.5, 283.6, -115.5));
  scripts\cp\zombies\zombies_spawning::update_origin((2063, -1848.8, -8.5), (2063, -1880.8, -8.5), (0, 180, 0));
}

respawn_on_island(var_0) {
  var_1 = scripts\engine\utility::getstructarray("island_dropoff_player", "targetname");
  for(var_2 = 0; var_2 < 40; var_2++) {
    foreach(var_4 in var_1) {
      if(canspawn(var_4.origin) && !positionwouldtelefrag(var_4.origin)) {
        return var_4;
      }
    }

    wait(0.05);
  }

  return var_1[0];
}

hotjoin_on_boat() {
  level endon("end_boat_hotjoin");
  while(scripts\engine\utility::flag("survivor_released")) {
    level waittill("player_spawned", var_0);
    var_1 = undefined;
    foreach(var_3 in level.boat_vehicle.linked_players) {
      if(!var_3 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      for(var_4 = 1; var_4 < 5; var_4++) {
        if(distance2dsquared(level.boat_vehicle gettagorigin("tag_player_0" + var_4), var_3.origin) < 64) {
          continue;
        } else {
          var_1 = "tag_player_0" + var_4;
          break;
        }
      }

      if(isDefined(var_1)) {
        break;
      }
    }

    if(isDefined(var_1)) {
      level thread scripts\cp\maps\cp_rave\cp_rave_boat::link_player_to_boat(var_0, undefined, var_1);
      continue;
    }

    level thread scripts\cp\maps\cp_rave\cp_rave_boat::link_player_to_boat(var_0, undefined, "tag_player_04");
  }
}

remove_door_ala() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = scripts\engine\utility::getstructarray("afterlife_selfrevive_door", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(var_2.origin == (-10270.5, 259.7, -1759)) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    }
  }
}

adjust_doorbuy_triggers() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  wait(1);
  var_0 = getEntArray("debris_1250", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(distancesquared(var_2.origin, (-1680, 1384, 24.7)) < 1000) {
      var_2.origin = var_2.origin + (0, 0, 100);
    }
  }
}

cp_rave_should_do_damage_check_func(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3) && var_3 == "iw7_bait_zm") {
    return 0;
  }

  return 1;
}

show_sym_pap() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread delay_play_soul_key_symbol(var_0);
  }
}

setupinvalidvolumes() {
  level.invalidtranspondervolumes = [];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-3538, -2455, 150), (-3539, -2327, 200), (-3364, -2280, 125), (-3418, -2461, 225)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(438, 282, 0), (148, 382, -20), (89, 235, 200), (398, 184, 200)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-288, -1573, 200), (-200, -1575, 200), (-192, -1533, 264), (-299, -1533, 264)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(2589, -2724, 75), (2496, -2911, 75), (2689, -3010, 225), (2813, -2679, 225)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(70, 674, 0), (671, 540, 0), (701, 400, 200), (991, 532, 200)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-2937, -4267, 200), (-2731, -4372, 200), (-2727, -4428, 350), (-2965, -4325, 400)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-929, 1695, -15), (-877, 1753, -15), (-787, 1568, 200), (-744, 1617, 200)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-2422, -4034, 240), (-2470, -4046, 240), (-2300, -3868, 400), (-2457, -3802, 400)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-3740, -2181, 70), (-3679, -1927, 70), (-3840, -1860, 250), (-3934, -2282, 250)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-1107, 1970, -20), (-1007, 1787, -20), (-867, 1897, 150), (-1050, 2070, 150)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(848, -517, 400), (847, -606, 400), (1036, -603, -10), (1031, -517, -10)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-3284, 3878, -200), (-5244, 2985, -200), (-4289, 1680, 100), (-2139, 2955, 100)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-1525, -1716, 100), (-2009, -1763, 0), (-1475, -1544, 300), (-1978, -1631, 147)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(1680, -486, 50), (1680, -606, 0), (1032, -512, 165), (1010, -750, 165)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-1066, -730, 175), (-944, -653, 300), (-950, -534, 300), (-1203, -674, 175)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(1708, -1247, 150), (1720, -1512, 350), (1835, -1464, 350), (1803, -1211, 150)];
}

delay_play_soul_key_symbol(var_0) {
  var_0 endon("disconnect");
  var_1 = (-10265, 932, -1581);
  var_2 = (0, 0, 90);
  var_0 waittill("spawned_player");
  var_3 = var_0 getplayerdata("cp", "haveSoulKeys", "soul_key_1");
  if(scripts\engine\utility::istrue(var_3)) {
    playFX(level._effect["vfx_zb_pack_grd_small_a"], var_1, anglesToForward(var_2), anglestoup(var_2), var_0);
  }
}

cp_rave_gns_2_setup() {
  level.gns_num_of_wave = 3;
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::init();
  ghost_player_end_pos();
  form_5_priority();
  level.death_trigger_reset_y_pos = 7183;
  level.death_trigger_activate_y_pos = 8112;
  level.original_death_grid_lines_front_y_pos = 9779;
  level.zombie_ghost_model = "zombie_ghost_green";
  level.zombie_ghost_color_manager = ::cp_rave_ghost_color_manager;
  level.set_moving_target_color_func = ::cp_rave_set_moving_target_color;
  level.should_moving_target_explode = ::cp_rave_should_moving_target_explode;
  level.hit_wrong_moving_target_func = ::cp_rave_hit_wrong_moving_target_func;
  level.moving_target_activation_func = ::hide_show_color_logic;
  level.moving_target_pre_fly_time = 0.5;
  level.process_player_gns_combo_func = ::process_player_gns_combo;
  level.gns_laststand_monitor = ::gns2_laststand_monitor;
  level.ghost_n_skull_reactivate_func = scripts\cp\maps\cp_rave\cp_rave_ghost_activation::reactive_ghost_n_skull_cabinet;
  level.gns_reward_func = ::rave_gns_player_reward_func;
  level.gns_hotjoin_wait_notify = "finish_intro_gesture";
  register_ghost_form();
  register_waves_movement();
  load_cp_rave_ghost_exp_vfx();
  scripts\cp\maps\cp_rave\cp_rave_ghost_activation::init_ghost_n_skull_2_quest();
}

ghost_player_end_pos() {
  var_0 = scripts\engine\utility::getstructarray("ghost_wave_player_end", "targetname");
  foreach(var_2 in var_0) {
    if(var_2.origin == (-8431.5, 10156.5, -753.5)) {
      var_2.origin = (-320, -1458, 403);
      var_2.angles = (0, 0, 0);
      continue;
    }

    if(var_2.origin == (-8399.5, 10156.5, -753.5)) {
      var_2.origin = (-320, -1478, 403);
      var_2.angles = (0, 0, 0);
      continue;
    }

    if(var_2.origin == (-8367.5, 10156.5, -753.5)) {
      var_2.origin = (-320, -1498, 403);
      var_2.angles = (0, 0, 0);
      continue;
    }

    if(var_2.origin == (-8335.5, 10156.5, -753.5)) {
      var_2.origin = (-320, -1518, 403);
      var_2.angles = (0, 0, 0);
    }
  }
}

register_ghost_form() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1, 1);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 2);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 3);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 4);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1, 5);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 7);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 9);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 10);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 11);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 12);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 13);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 14);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 15);
}

register_waves_movement() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(1, 1, 2, 0.3);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(2, 1, 1.8, 0.3);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(3, 1, 1.6, 0.3);
  level.available_formations = undefined;
  level.formation_movements = undefined;
}

cp_rave_ghost_color_manager() {
  var_0 = 6;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  foreach(var_6 in level.zombie_ghosts) {
    if(var_6.color == "red") {
      var_1++;
    }

    if(var_6.color == "green") {
      var_2++;
    }

    if(var_6.color == "yellow") {
      var_3++;
    }

    if(var_6.color == "blue") {
      var_4++;
    }
  }

  if(var_1 < var_0) {
    level.zombie_ghost_model = "zombie_ghost_red";
    return;
  }

  if(var_2 < var_0) {
    level.zombie_ghost_model = "zombie_ghost_green";
    return;
  }

  if(var_3 < var_0) {
    level.zombie_ghost_model = "zombie_ghost_yellow";
    return;
  }

  level.zombie_ghost_model = "zombie_ghost_blue";
}

load_cp_rave_ghost_exp_vfx() {
  level._effect["ghost_explosion_death_red"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_red.vfx");
  level._effect["ghost_explosion_death_yellow"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_yellow.vfx");
  level._effect["ghost_explosion_death_blue"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_blue.vfx");
}

cp_rave_set_moving_target_color(var_0, var_1) {
  var_2 = ["green", "yellow", "blue"];
  var_3 = "";
  if(var_1 == 1) {
    if(!isDefined(level.moving_target_color_based_on_priority)) {
      determine_color(var_2);
    }

    if(scripts\engine\utility::array_contains(level.moving_target_priority["low"], var_0)) {
      var_3 = level.moving_target_color_based_on_priority["low"];
    } else if(scripts\engine\utility::array_contains(level.moving_target_priority["medium"], var_0)) {
      var_3 = level.moving_target_color_based_on_priority["medium"];
    } else if(scripts\engine\utility::array_contains(level.moving_target_priority["high"], var_0)) {
      var_3 = level.moving_target_color_based_on_priority["high"];
    }
  } else {
    var_3 = scripts\engine\utility::random(var_2);
  }

  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::set_moving_target_color(var_0, var_3);
}

cp_rave_should_moving_target_explode(var_0, var_1) {
  return isDefined(var_1.color) && var_0.color == var_1.color;
}

cp_rave_hit_wrong_moving_target_func(var_0, var_1, var_2) {
  reset_player_gns_combo(var_0);
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::activate_red_moving_target(var_1);
}

determine_color(var_0) {
  var_1 = scripts\engine\utility::array_randomize(var_0);
  level.moving_target_color_based_on_priority = [];
  level.moving_target_color_based_on_priority["low"] = var_1[0];
  level.moving_target_color_based_on_priority["medium"] = var_1[1];
  level.moving_target_color_based_on_priority["high"] = var_1[2];
}

form_5_priority() {
  var_0 = scripts\engine\utility::getstructarray("ghost_formation_5", "targetname");
  foreach(var_2 in var_0) {
    if(var_2.script_parameters == "RD") {
      var_3 = scripts\engine\utility::getstructarray(var_2.target, "targetname");
      foreach(var_5 in var_3) {
        if(var_5.origin == (-10304, 9604, -2288.5)) {
          var_5.script_noteworthy = "low";
        }

        if(var_5.origin == (-10560, 9604, -2288.5)) {
          var_5.script_noteworthy = "medium";
        }
      }
    }
  }
}

hide_show_color_logic(var_0) {
  reset_all_players_gns_combo();
  if(var_0 == 2) {
    level thread wave_2_hide_show_color_logic();
    return;
  }

  if(var_0 == 3) {
    level thread wave_3_hide_show_color_logic();
  }
}

wave_2_hide_show_color_logic() {
  level notify("cp_rave_hide_show_logic");
  level endon("cp_rave_hide_show_logic");
  level endon("game_ended");
  level endon("stop_moving_target_sequence");
  var_0 = 12;
  for(;;) {
    wait(var_0);
    scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::all_moving_targets_hide_color();
    wait(var_0);
    scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::all_moving_targets_show_color();
  }
}

wave_3_hide_show_color_logic() {
  level notify("cp_rave_hide_show_logic");
  level endon("cp_rave_hide_show_logic");
  level endon("game_ended");
  level endon("stop_moving_target_sequence");
  var_0 = 20;
  wait(var_0);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::all_moving_targets_hide_color();
}

reset_all_players_gns_combo() {
  foreach(var_1 in level.players) {
    reset_player_gns_combo(var_1);
  }
}

reset_player_gns_combo(var_0) {
  var_0.current_gns_streak_color = "none";
  var_0.current_gns_streak_length = 0;
}

process_player_gns_combo(var_0, var_1) {
  if(!isDefined(var_1)) {
    reset_player_gns_combo(var_0);
    return;
  }

  if(var_1.color == "red") {
    reset_player_gns_combo(var_0);
    return;
  }

  if(!isDefined(var_0.current_gns_streak_color)) {
    reset_player_gns_combo(var_0);
  }

  if(var_0.current_gns_streak_color == var_1.color) {
    var_0.current_gns_streak_length++;
  } else {
    var_0.current_gns_streak_color = var_1.color;
    var_0.current_gns_streak_length = 1;
  }

  if(var_0.current_gns_streak_length > 1) {
    level thread take_out_targets(var_0, var_0.current_gns_streak_length - 1, var_1);
  }
}

take_out_targets(var_0, var_1, var_2) {
  var_3 = get_color_targ(var_2);
  var_4 = sortbydistance(var_3, var_2.origin);
  var_5 = min(var_1, var_4.size);
  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = var_4[var_6];
    playFX(level._effect["ghost_explosion_death_" + var_7.color], var_7.origin, anglesToForward(var_7.angles), anglestoup(var_7.angles));
    scripts\aitypes\zombie_ghost\behaviors::remove_moving_target_default(var_7, var_0);
  }
}

get_color_targ(var_0) {
  var_1 = var_0.color;
  var_2 = [];
  foreach(var_4 in level.moving_target_groups) {
    foreach(var_6 in var_4) {
      if(var_6 == var_0) {
        continue;
      }

      if(isDefined(var_6) && var_6.color == var_1) {
        var_2[var_2.size] = var_6;
      }
    }
  }

  return var_2;
}

rave_gns_player_reward_func() {
  foreach(var_1 in level.players) {
    var_1 thread delay_give_gns_reward(var_1);
  }
}

delay_give_gns_reward(var_0) {
  var_0 endon("disconnect");
  var_0.max_self_revive_machine_use = 6;
  var_0.have_gns_perk = 1;
  var_0 thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::give_gns_base_reward(var_0);
  wait(1);
  var_0 setclientomnvar("zm_nag_text", 1);
}

gns2_laststand_monitor(var_0) {
  level endon("game_ended");
  level endon("delay_end_ghost");
  var_0 endon("disconnect");
  for(;;) {
    var_0 waittill("last_stand");
    reset_player_gns_combo(var_0);
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

      var_5 = scripts\engine\utility::waittill_any_timeout_no_endon_death(var_4, "inputReceived", "currency_earned");
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
    level.kick_player_queue = scripts\engine\utility::add_to_array(level.kick_player_queue, var_0);
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

rave_setup_direct_boss_fight_func() {
  direct_boss_fight_zombie_spawning();
  scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::move_lost_and_found("island");
}

direct_boss_fight_zombie_spawning() {
  level.zombies_paused = 1;
}

rave_start_direct_boss_fight_func() {
  level.getspawnpoint = ::respawn_on_island;
  scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::init_super_slasher_fight();
  level.wave_num_override = int(max(38, level.wave_num));
  level.disable_loot_fly_to_player = 1;
  level.loot_time_out = 99999;
  level thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::max_ammo_manager();
  scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::deploy_stair_barrier();
  scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::stop_spawn_wave();
  scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::clear_existing_enemies();
  scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::activate_fight_stage_vfx();
  scripts\engine\utility::flag_clear("zombie_drop_powerups");
  for(;;) {
    level.superslasher = scripts\mp\mp_agent::spawnnewagent("superslasher", "axis", level.superslasherspawnspot, level.superslasherspawnangles);
    if(isDefined(level.superslasher)) {
      break;
    } else {
      scripts\engine\utility::waitframe();
    }
  }

  thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::watch_for_player_connect();
  level.superslasher.dont_cleanup = 1;
  level.superslasher.var_E0 = 1;
  level.superslasher thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::put_on_happy_face(level.superslasher);
  level.force_respawn_location = ::respawn_on_island;
  scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::soul_collection_sequence_init();
  thread deactivateadjacentvolumes();
  wait(2);
  level notify("ss_intro_finished");
  foreach(var_1 in level.players) {
    var_1 playsoundtoplayer(var_1.vo_prefix + "slasher_super_first", var_1);
  }

  wait(6);
  level thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::unlimited_zombie_spawn();
  level thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::soul_collection_sequence();
  level thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::enableslasherpas();
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_superslasher_firstspawn", "rave_announcer_vo", "highest", 5, 0, 0, 1);
  level waittill("super_slasher_death");
  scripts\cp\zombies\direct_boss_fight::success_sequence(10, 2);
}

rave_is_valid_spawn_weapon_func(var_0) {
  switch (var_0) {
    case "iw7_fists_zm_kevinsmith":
    case "iw7_fists_zm_raver":
    case "iw7_fists_zm_hiphop":
    case "iw7_fists_zm_grunge":
    case "iw7_fists_zm_chola":
      return 0;

    default:
      return 1;
  }
}