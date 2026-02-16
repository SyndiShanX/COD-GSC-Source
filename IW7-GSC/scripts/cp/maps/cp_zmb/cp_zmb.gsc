/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb.gsc
*********************************************/

main() {
  registerscriptedagents();
  setDvar("sm_sunSampleSizeNear", 0.6);
  setDvar("sm_spotDistCull", 6100);
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraAccurateOcclusionThreshold", 512);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotUpdateLimit", 8);
  precache();
  setDvar("player_limitedMovementLeftStickInputScale", 0);
  scripts\cp\utility::coop_mode_enable(["portal"]);
  level.avoidance_radius = 15;
  level.suicider_avoidance_radius = 40;
  level.use_adjacent_volumes = 1;
  level.idle_spot_patch_func = ::cp_zmb_idle_spot_patch_func;
  level.goon_spawner_patch_func = ::cp_zmb_goon_spawner_patch_func;
  scripts\mp\agents\c6\c6_agent::registerscriptedagent();
  scripts\mp\agents\zombie_cop\zombie_cop::zombie_cop_init();
  scripts\mp\agents\zombie_clown\zombie_clown::zombie_clown_init();
  level.disable_zombie_exo_abilities = 1;
  level.toy_damage_monitor = ::waitfordamage;
  level.toy_picture_damage_monitor = ::picturewaitfordamage;
  level.tutorial_message_table = "cp\zombies\cp_zmb_tutorial.csv";
  level.coop_weapontable = "cp\cp_weapontable.csv";
  level.custom_onplayerconnect_func = ::cp_zmb_onplayerconnect;
  level.respawn_loc_override_func = ::cp_zmb_respawn_loc_func;
  level.should_show_tutorial_func = ::setup_tutorial_requirements;
  level.should_drop_pillage = ::cp_zmb_should_drop_pillage;
  level.eligable_for_reward_func = ::cp_zmb_eligable_for_reward_func;
  level.should_do_damage_check_func = ::cp_zmb_should_do_damage_check_func;
  level.wait_to_be_revived_func = ::cp_zmb_wait_to_be_revived_func;
  level.magic_wheel_spin_hint = &"CP_ZMB_INTERACTIONS_SPIN_WHEEL";
  level.reboard_barriers_hint = &"CP_ZMB_INTERACTIONS_SECURE_WINDOW";
  level.custom_onspawnplayer_func = ::cp_zmb_onplayerspawned;
  scripts\cp\cp_weapon_autosentry::init();
  scripts\cp\zombies\craftables\_zm_soul_collector::init();
  scripts\cp\zombies\craftables\_electric_trap::init();
  scripts\cp\zombies\craftables\_boombox::init();
  scripts\cp\zombies\craftables\_revocator::init();
  scripts\cp\maps\cp_zmb\cp_zmb_precache::main();
  scripts\cp\maps\cp_zmb\gen\cp_zmb_art::main();
  scripts\cp\maps\cp_zmb\cp_zmb_fx::main();
  if(level.createfx_enabled) {
    var_0 = getEntArray("script_brushmodel", "classname");
    foreach(var_2 in var_0) {
      var_2 delete();
    }

    return;
  }

  level.custom_pillageinitfunc = ::cp_zmb_pillage_init;
  level.challenge_registration_func = scripts\cp\maps\cp_zmb\cp_zmb_challenges::register_default_challenges;
  level.challenge_scalar_func = scripts\cp\maps\cp_zmb\cp_zmb_challenges::challenge_scalar_func;
  level.custom_death_challenge_func = scripts\cp\maps\cp_zmb\cp_zmb_challenges::default_death_challenge_func;
  level.custom_playerdamage_challenge_func = scripts\cp\maps\cp_zmb\cp_zmb_challenges::default_playerdamage_challenge_func;
  level.scriptablestatefunc = scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate;
  level.should_continue_progress_bar_think = ::cp_zmb_should_continue_progress_bar_think;
  level.mutilation_mask_override_func = ::cp_zmb_mutilation_mask_func;
  level.should_allow_far_search_dist_func = ::cp_zmb_should_allow_far_search_dist_func;
  level.laststand_enter_levelspecificaction = ::zmb_last_stand_handler;
  level.map_interaction_func = scripts\cp\maps\cp_zmb\cp_zmb_interactions::register_interactions;
  level.wait_for_interaction_func = scripts\cp\maps\cp_zmb\cp_zmb_interactions::zmb_wait_for_interaction_triggered;
  level.player_interaction_monitor = scripts\cp\maps\cp_zmb\cp_zmb_interactions::zmb_player_interaction_monitor;
  level.introscreen_text_func = ::cp_zmb_introscreen_text;
  level.char_intro_music = ::play_char_intro_music;
  level.char_intro_gesture = ::play_char_intro_gesture;
  level.force_song_func = scripts\cp\zombies\zombie_jukebox::force_song;
  level.drop_max_ammo_func = scripts\cp\loot::drop_loot;
  level.post_nondeterministic_func = ::post_nondeterministic_func;
  level.update_player_tickets_func = scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned;
  level.write_global_clientmatchdata_func = ::cp_zmb_global_clientmatchdata_func;
  level.spawn_fx_func = ::cp_zmb_spawn_fx_func;
  level.near_equipment_func = ::cp_zmb_near_equipment_func;
  level.purchase_area_vo = scripts\cp\maps\cp_zmb\cp_zmb_vo::purchase_area_vo;
  level.team_buy_vos = scripts\cp\maps\cp_zmb\cp_zmb_vo::purchase_team_buy_vos;
  level.patch_update_spawners = ::cp_zmb_patch_update_spawners;
  level.enter_afterlife_clear_player_scriptable_func = ::cp_zmb_enter_afterlife_clear_player_scriptable_func;
  level.traversal_dismember_check = ::cp_zmb_traversal_dismember_check;
  level.is_in_box_func = ::vectors_are_in_box;
  level.additional_loadout_func = ::willard_loadout_func;
  level.wave_complete_dialogues_func = scripts\cp\zombies\zombies_spawning::wave_complete_dialogues;
  level.setup_direct_boss_fight_func = ::zmb_setup_direct_boss_fight_func;
  level.start_direct_boss_fight_func = ::zmb_start_direct_boss_fight_func;
  level.cac_vo_male = scripts\engine\utility::array_randomize(["p1_", "p3_"]);
  level.cac_vo_female = scripts\engine\utility::array_randomize(["p2_"]);
  level thread scripts\cp\maps\cp_zmb\cp_zmb_vo::zmb_vo_init();
  level thread setupinvalidvolumes();
  scripts\cp\cp_challenge::init_coop_challenge();
  level.crafting_table = "scripts\cp\maps\cp_zmb\cp_zmb_crafting.csv";
  level.weapon_rank_event_table = "scripts\cp\maps\cp_zmb\cp_zmb_weaponrank_event.csv";
  scripts\cp\maps\cp_zmb\cp_zmb_crafting::init_crafting();
  scripts\cp\maps\cp_zmb\cp_zmb_environment_scriptable::init();
  level thread wait_for_pre_game_period();
  level thread setup_slide();
  level thread gator_mouth();
  level thread bumper_cars();
  level thread geysers_and_boatride();
  level thread setup_ufo();
  level.additional_laststand_weapon_exclusion = ["iw7_cpbasketball_mp", "iw7_cpskeeball_mp", "iw7_cpclowntoothball_mp", "iw7_horseracepistol_zm_blue", "iw7_horseracepistol_zm_yellow", "iw7_horseracepistol_zm_red", "iw7_horseracepistol_zm_green", "iw7_shootgallery_zm", "iw7_blackholegun_mp", "iw7_penetrationrail_mp", "iw7_atomizer_mp", "iw7_glr_mp", "iw7_claw_mp", "iw7_steeldragon_mp", "iw7_shootgallery_zm_blue", "iw7_shootgallery_zm_yellow", "iw7_shootgallery_zm_red", "iw7_shootgallery_zm_green"];
  level.last_stand_weapons = ["iw7_g18_zm", "iw7_mag_zm", "iw7_g18_zmr", "iw7_g18_zml", "iw7_g18c_zm", "iw7_revolver_zm", "iw7_revolver_zmr", "iw7_revolver_zmr_explosive", "iw7_revolver_zml", "iw7_revolver_zml_single", "iw7_emc_zm", "iw7_emc_zmr", "iw7_emc_zmr_burst", "iw7_emc_zml", "iw7_emc_zml_spread", "iw7_nrg_zm", "iw7_nrg_zmr", "iw7_nrg_zmr_smart", "iw7_nrg_zml", "iw7_nrg_zml_charge", "iw7_dischord_zm", "iw7_headcutter_zm", "iw7_shredder_zm", "iw7_facemelter_zm", "iw7_dischord_zm_pap1", "iw7_headcutter_zm_pap1", "iw7_shredder_zm_pap1", "iw7_facemelter_zm_pap1"];
  level.mode_weapons_allowed = ["iw7_g18_zm", "iw7_g18_zmr"];
  scripts\cp\powers\coop_armageddon::init_armageddon();
  scripts\cp\maps\cp_zmb\cp_zmb_player_character_setup::init_player_characters();
  setup_generic_zombie_model_list();
  level thread gametype_level_init();
  level thread agent_definition_override();
  level thread boat_area_kill_trigger();
  level thread setup_pa_speakers();
  level thread init_hidden_song_quest();
  level thread init_hidden_song_2_quest();
  level thread scripts\cp\maps\cp_zmb\cp_zmb_dj::init_dj_quests();
  setminimap("", 3072, 3072, -3072, -3072);
  level thread scripts\cp\maps\cp_zmb\cp_zmb_vo::power_nag();
  level thread reset_trap_uses_each_round();
  level thread pap_test();
  level thread scripts\cp\zombies\interaction_openareas::init_all_debris_and_door_positions();
  add_more_afterlife_arcade_start_points();
  cp_zmb_ghost_n_skull_setup();
  level thread setup_pap_camos();
  if(scripts\cp\utility::is_codxp()) {
    level thread codxp_timer();
  }

  scripts\engine\utility::flag_init("team_doors_initialized");
  level thread player_standing_on_nothing_check();
  level thread adjust_interaction_structs();
  sysprint("MatchStarted: Completed");
}

willard_loadout_func(var_0) {
  if(isDefined(var_0.vo_prefix) && var_0.vo_prefix == "p6_") {
    if(scripts\engine\utility::istrue(var_0.got_willard_knife)) {
      return;
    }

    var_0 giveweapon("iw7_wylerdagger_zm");
    var_0 switchtoweaponimmediate("iw7_wylerdagger_zm");
    var_0.got_willard_knife = 1;
  }
}

setup_pap_camos() {
  level.pap_1_camo = "camo01";
  level.pap_2_camo = "camo04";
  level.no_pap_camos = ["axe", "iw7_axe_zm", "forgefreeze"];
}

cp_zmb_onplayerspawned() {
  thread scripts\cp\powers\coop_powers::power_watch_hint();
  thread scripts\cp\zombies\zombies_weapons::arcane_attachment_watcher(self);
}

registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("mp\default_agent_definition.csv");
  scripts\mp\agents\zombie\zmb_zombie_agent::registerscriptedagent();
  scripts\mp\agents\zombie_brute\zombie_brute_agent::registerscriptedagent();
  scripts\mp\agents\the_hoff\the_hoff_agent::registerscriptedagent();
}

adjust_interaction_structs() {
  while(!isDefined(level.struct)) {
    wait(1);
  }

  cp_zmb_interaction_struct_adjustment("iw7_m1c_zm");
}

codxp_timer() {
  wait(10);
  setomnvar("zm_ui_timer", gettime() + 900000);
  wait(900);
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

pap_test() {
  wait(10);
  scripts\engine\utility::exploder(21);
  scripts\engine\utility::exploder(22);
  scripts\engine\utility::exploder(23);
  scripts\engine\utility::exploder(24);
  scripts\engine\utility::exploder(25);
  scripts\engine\utility::exploder(26);
}

precache() {
  precachempanim("IW7_cp_zom_n31l_intro_enter");
  precachempanim("IW7_cp_zom_n31l_intro_loop");
  precachempanim("IW7_cp_zom_n31l_intro_exit");
  precachempanim("IW7_cp_zom_n31l_halt");
  precachempanim("IW7_cp_zom_n31l_head_on");
  precachempanim("IW7_cp_zom_n31l_hit");
  precachempanim("IW7_cp_zom_n31l_walk");
  precachempanim("IW7_cp_zom_hoff_intro");
  precachempanim("IW7_cp_zom_hoff_dj_window_open");
  precachempanim("IW7_cp_zom_hoff_dj_idle_01");
  precachempanim("IW7_cp_zom_hoff_dj_vo_01");
  precachempanim("IW7_cp_zom_hoff_dj_vo_02");
  precachempanim("IW7_cp_zom_hoff_dj_vo_03");
  precachempanim("IW7_cp_zom_hoff_dj_vo_04");
  precachempanim("IW7_cp_zom_hoff_dj_vo_05");
  precachempanim("IW7_cp_zom_hoff_dj_vo_06");
  precachempanim("IW7_cp_zom_hoff_dj_desk_01");
  precachempanim("IW7_cp_zom_hoff_dj_desk_02");
  precachempanim("IW7_cp_zom_hoff_dj_desk_03");
  precachempanim("IW7_cp_zom_hoff_dj_desk_04");
  precachempanim("IW7_cp_zom_hoff_dj_desk_05");
  precachempanim("IW7_cp_zom_hoff_dj_desk_06");
  precachempanim("IW7_cp_zom_hoff_dj_window_close");
  precachempanim("IW7_cp_zom_hoff_outro");
  precachempanim("IW7_cp_zom_hoff_dj_vo_06_enter");
  precachempanim("IW7_cp_zom_hoff_dj_vo_06_exit");
}

setup_pa_speakers() {
  scripts\cp\zombies\zombie_jukebox::parse_music_genre_table();
  wait(1.15);
  disablepaspeaker("starting_area");
  disablepaspeaker("cosmic_way");
  disablepaspeaker("kepler");
  disablepaspeaker("triton");
  disablepaspeaker("astrocade");
  disablepaspeaker("journey");
  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start((649, 683, 254));
}

reset_trap_uses_each_round() {
  for(;;) {
    level scripts\engine\utility::waittill_either("event_wave_starting", "regular_wave_starting");
    level.discotrapuses = 0;
    level.rockettrapuses = 0;
    level.beamtrapuses = 0;
    level.blackholetrapuses = 0;
    level.scrambletrapuses = 0;
  }
}

init_hidden_song_quest() {
  level.toys_found = 0;
  level.hidden_toys = [];
  var_0 = scripts\engine\utility::getStructArray("hidden_song_toy", "targetname");
  var_1 = scripts\engine\utility::array_randomize(var_0);
  var_2 = 5;
  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_1[var_3];
    var_5 = var_4.origin;
    var_6 = spawn("script_model", var_5);
    if(isDefined(var_4.angles)) {
      var_6.angles = var_4.angles;
    } else {
      var_6.angles = (0, 0, 0);
    }

    if(isDefined(var_4.script_noteworthy)) {
      var_7 = var_4.script_noteworthy;
    } else {
      var_7 = scripts\engine\utility::random(["toy_teddy_bear_01", "toy_teddy_bear_sitting_01"]);
    }

    var_6 setModel(var_7);
    var_6 thread waitfordamage(var_6);
    level.hidden_toys[level.hidden_toys.size] = var_6;
  }
}

init_hidden_song_2_quest() {
  level.pictures_found = 0;
  level.hidden_pictures = [];
  var_0 = getEntArray("hidden_song_toy", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  foreach(var_2 in var_0) {
    var_2 hide();
    var_2 setCanDamage(0);
  }

  var_4 = 3;
  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = var_0[var_5];
    var_7 = var_6;
    var_7.picture = 1;
    var_8 = getEntArray(var_7.target, "targetname");
    foreach(var_6 in var_8) {
      if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "blank_photo") {
        var_7.blank_photo = var_6;
      }

      var_6 hide();
    }

    var_7 show();
    var_7 thread picturewaitfordamage(var_7);
    level.hidden_pictures[level.hidden_pictures.size] = var_7;
    var_11 = 1;
  }
}

picturewaitfordamage(var_0) {
  var_0 endon("end_toy_watch_for_damage");
  var_0 setCanDamage(1);
  var_0.maxhealth = 100000;
  var_0.health = var_0.maxhealth;
  var_1 = spawnfx(level._effect["neil_repair_sparks"], var_0.origin);
  for(;;) {
    var_0 waittill("damage", var_2, var_3);
    if(isPlayer(var_3)) {
      var_3 playlocalsound("song_quest_mw1_step_notify");
      triggerfx(var_1);
      var_0.health = 0;
      var_0 hide();
      var_0.blank_photo show();
      var_0 setCanDamage(0);
      level.pictures_found++;
      break;
    }
  }

  if(!isDefined(level.hidden_song_2) && level.pictures_found >= 3) {
    level notify("add_hidden_song_2_to_playlist");
    level.hidden_song_2 = 1;
    scripts\cp\zombies\zombie_analytics::log_hidden_song_two_found(level.wave_num);
    scripts\cp\cp_vo::try_to_play_vo_on_all_players("quest_song_start");
    scripts\cp\zombies\achievement::update_achievement_all_players("I_LOVE_THE_80_S", 1);
    level thread play_hidden_song((649, 683, 254), "mus_pa_mw1_80s_cover");
  }

  wait(0.2);
  var_1 delete();
}

waitfordamage(var_0) {
  var_0 endon("end_toy_watch_for_damage");
  var_0 setCanDamage(1);
  var_0.maxhealth = 100000;
  var_0.health = var_0.maxhealth;
  var_1 = spawnfx(level._effect["neil_repair_sparks"], var_0.origin);
  for(;;) {
    var_0 waittill("damage", var_2, var_3);
    if(isPlayer(var_3)) {
      var_3 playlocalsound("song_quest_mw2_step_notify");
      triggerfx(var_1);
      var_0.health = 0;
      var_0 setModel("tag_origin");
      var_0 setCanDamage(0);
      level.toys_found++;
      break;
    }
  }

  if(!isDefined(level.hidden_song) && level.toys_found >= 5) {
    level notify("add_hidden_song_to_playlist");
    level.hidden_song = 1;
    scripts\cp\zombies\zombie_analytics::log_hidden_song_one_found(level.wave_num);
    scripts\cp\cp_vo::try_to_play_vo_on_all_players("quest_song_start");
    scripts\cp\zombies\achievement::update_achievement_all_players("I_LOVE_THE_80_S", 1);
    level thread play_hidden_song((649, 683, 254), "mus_pa_mw2_80s_cover");
  }

  wait(0.2);
  var_1 delete();
}

play_hidden_song(var_0, var_1) {
  level endon("game_ended");
  if(var_1 == "mus_pa_mw2_80s_cover") {
    level endon("add_hidden_song_2_to_playlist");
  } else if(var_1 == "mus_pa_mw1_80s_cover") {
    level endon("add_hidden_song_to_playlist");
  }

  wait(2.5);
  foreach(var_3 in level.players) {
    if(scripts\engine\utility::istrue(level.onlinegame)) {
      var_3 setplayerdata("cp", "hasSongsUnlocked", "any_song", 1);
      if(var_1 == "mus_pa_mw2_80s_cover") {
        var_3 setplayerdata("cp", "hasSongsUnlocked", "song_1", 1);
        continue;
      }

      if(var_1 == "mus_pa_mw1_80s_cover") {
        var_3 setplayerdata("cp", "hasSongsUnlocked", "song_2", 1);
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
  var_7 thread earlyendon(var_7);
  var_12 = lookupsoundlength(var_1) / 1000;
  level scripts\engine\utility::waittill_any_timeout(var_12, "skip_song");
  var_7 stoploopsound();
  var_7 delete();
  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start((649, 683, 254), 1);
}

earlyendon(var_0) {
  level endon("game_ended");
  level scripts\engine\utility::waittill_any("add_hidden_song_to_playlist", "add_hidden_song_2_to_playlist", "force_new_song");
  if(isDefined(var_0)) {
    var_0 stoploopsound();
    wait(2);
    var_0 delete();
  }
}

boat_area_kill_trigger() {
  var_0 = getent("player_kill_trig", "targetname");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isPlayer(var_1)) {
      continue;
    }

    var_2 = self;
    var_3 = self;
    var_4 = 100;
    var_5 = "MOD_TRIGGER_HURT";
    var_6 = undefined;
    var_7 = self.origin;
    var_8 = "none";
    var_9 = undefined;
    var_1 scripts\cp\cp_damage::onplayertouchkilltrigger(var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

agent_definition_override() {
  wait(1);
  level.agent_definition["c6"]["setup_func"] = ::setupc6agent;
}

cp_zmb_pillage_init() {
  level.pillageinfo = spawnStruct();
  level.pillageinfo.default_use_time = 1000;
  level.pillageinfo.ui_searching = 1;
  level.pillageable_powers = [];
  level.pillageable_explosives = ["power_bioSpike", "power_c4", "power_clusterGrenade", "power_concussionGrenade", "power_frag", "power_gasGrenade", "power_semtex", "power_splashGrenade"];
  level.pillageable_attachments = ["reflex", "grip", "barrelrange", "xmags", "overclock", "fastaim", "rof"];
  level.pillageinfo.clip = 33;
  level.pillageinfo.explosive = 33;
  level.pillageinfo.money = 20;
  level.pillageinfo.tickets = 10;
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_1", "backpack", "zombies_backpack_dropped", "zombies_backpack", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_2", "backpack", "zombies_backpack_dropped_red", "zombies_backpack_red", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_3", "backpack", "zombies_backpack_dropped_purple", "zombies_backpack_purple", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_4", "backpack", "zombies_backpack_dropped_green", "zombies_backpack_green", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("fanny_pack_1", "backpack", "zombies_fanny_pack_dropped", "zombies_fanny_pack", "J_HipTwist_LE");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("fanny_pack_3", "backpack", "zombies_fanny_pack_dropped_purple", "zombies_fanny_pack_purple", "J_HipTwist_LE");
}

wait_for_pre_game_period() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  wait(0.2);
  scripts\cp\zombies\zombie_entrances::enable_windows_in_area("front_gate");
  level thread scripts\cp\zombies\interaction_neil::init_neil_quest();
  level thread scripts\cp\zombies\zombies_wor::init();
  scripts\engine\utility::flag_set("zombie_drop_powerups");
  scripts\engine\utility::flag_set("pillage_enabled");
  init_magic_wheel();
  thread scripts\cp\zombies\zombies_mini_ufo_quest::init();
  if(!scripts\cp\utility::is_escape_gametype()) {
    level thread zmb_power_gate_handler();
  }

  scripts\engine\utility::flag_set("pre_game_over");
}

setup_tutorial_requirements(var_0) {
  switch (var_0) {
    case "quest_neil":
      if(scripts\engine\utility::istrue(level.neil_head_added)) {
        return 1;
      } else {
        return 0;
      }

      break;

    default:
      return 1;
  }

  return 1;
}

init_magic_wheel() {
  var_0 = ["arcade_back", "mars_3", "moon_bumpercars"];
  scripts\cp\zombies\interaction_magicwheel::set_magic_wheel_starting_location(scripts\engine\utility::random(var_0));
}

gametype_level_init() {
  if(scripts\cp\utility::is_escape_gametype()) {
    scripts\cp\maps\cp_zmb\cp_zmb_escape::cp_zmb_escape_init();
    return;
  }

  cp_zmb_zombie_init();
}

cp_zmb_zombie_init() {
  level.initial_active_volumes = ["front_gate"];
  level.escape_interaction_registration_func = ::remove_escape_entities;
  if(getDvar("createfx") != "") {
    level thread free_ents_for_createfx();
  }
}

free_ents_for_createfx() {
  var_0 = getEntArray("trigger_multiple", "classname");
  foreach(var_2 in var_0) {
    var_2 delete();
  }

  var_4 = getEntArray("spawn_volume", "targetname");
  foreach(var_6 in var_4) {
    var_6 delete();
  }
}

remove_escape_entities() {
  var_0 = scripts\engine\utility::getStructArray("escape_exit", "script_noteworthy");
  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    }
  }

  var_4 = getent("escape_1_blocker_brush", "targetname");
  if(isDefined(var_4)) {
    var_4 delete();
  }

  var_5 = getEntArray("escape_door", "targetname");
  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      var_7 delete();
    }
  }

  var_9 = getEntArray("escape_spawn_trigger", "targetname");
  if(isDefined(var_9)) {
    foreach(var_11 in var_9) {
      var_11 delete();
    }
  }

  var_13 = getEntArray("escape_exit_path", "targetname");
  if(isDefined(var_13)) {
    foreach(var_15 in var_13) {
      var_15 delete();
    }
  }
}

setup_slide() {
  var_0 = getent("slide_trig", "targetname");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(scripts\engine\utility::istrue(var_1.onslide)) {
      continue;
    }

    if(isPlayer(var_1)) {
      var_1.onslide = 1;
      var_1 thread player_down_slide(var_0);
    }
  }
}

player_down_slide(var_0) {
  self endon("disconnect");
  self.is_slide_sfx_playing = 0;
  self.is_slide_land_sfx_playing = 0;
  var_1 = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("slide_start_spot", "targetname"));
  var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  if(distance2dsquared(self.origin, var_1.origin) > 65536) {
    while(self istouching(var_0)) {
      self setvelocity(vectornormalize(var_2.origin - self.origin) * 200);
      wait(0.05);
    }

    self.onslide = undefined;
    return;
  }

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
  self setplayerangles((-5, 0, 0));
  while(self istouching(var_0)) {
    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      thread last_stand_player_down_slide(var_2);
      return;
    }

    self.ability_invulnerable = 1;
    self.disable_consumables = 1;
    if(self.is_slide_sfx_playing == 0) {
      self playlocalsound("trap_hyperslide_plr_slide");
      self.is_slide_sfx_playing = 1;
    }

    self setvelocity(vectornormalize(var_2.origin - self.origin) * 500);
    wait(0.05);
  }

  self.ability_invulnerable = undefined;
  self notify("offslide");
  var_3 = self playanimscriptevent("power_active_cp", "gesture014");
  self.is_slide_sfx_playing = 0;
  if(self.is_slide_land_sfx_playing == 0) {
    self stoplocalsound("trap_hyperslide_plr_slide");
    scripts\engine\utility::delaycall(0.09, ::playlocalsound, "trap_hyperslide_plr_land");
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
  thread scripts\cp\cp_vo::try_to_play_vo("hyperslopes_slide", "zmb_comment_vo", "medium", 3, 0, 0, 1, 50);
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

cp_zmb_respawn_loc_func(var_0) {
  if(scripts\engine\utility::flag("first_door_opened")) {
    var_1 = level.fast_travel_spots[level.end_portal_name].end_positions;
    foreach(var_3 in var_1) {
      if(!canspawn(var_3.origin)) {
        continue;
      }

      if(positionwouldtelefrag(var_3.origin)) {
        continue;
      }

      return var_3;
    }
  }

  foreach(var_6 in level.active_player_respawn_locs) {
    if(!canspawn(var_6.origin)) {
      continue;
    }

    if(positionwouldtelefrag(var_6.origin)) {
      continue;
    }

    return var_6;
  }

  var_8 = scripts\cp\gametypes\zombie::get_available_players(var_0);
  return scripts\cp\gametypes\zombie::get_respawn_loc_near_team_center(var_0, var_8);
}

gator_mouth() {
  wait(5);
  var_0 = getent("gator_mouth", "targetname");
  var_1 = getent("gator_mouth_trig", "targetname");
  level.gator_mouth_trig = getent("gator_mouth_trig", "targetname");
  var_0.twitching = 0;
  var_2 = getent("croc_mouth_clip", "targetname");
  var_2 connectpaths();
  var_2 notsolid();
  level.gator_light = getent("gator_mouth_light", "targetname");
  level.gator_light setlightintensity(0);
  var_0 setModel("zmb_croc_chomp_head_toothless");
  var_0.origin = var_0.origin + (0, 0, -10);
  for(;;) {
    var_3 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", "mars power_on", "power_off");
    if(var_3 != "power_off") {
      level thread activate_gator_mouth(var_2, var_0, var_1, var_0.origin);
    }
  }
}

activate_gator_mouth(var_0, var_1, var_2, var_3) {
  level endon("deactivate_gator_mouth");
  level endon("game_ended");
  var_1 setModel("zmb_croc_chomp_head_toothless_on");
  wait(0.05);
  level.gator_light setlightintensity(4);
  var_2.lastmultikilltime = gettime();
  var_2.lastkilltime = gettime();
  for(;;) {
    wait(1);
    if(!var_1.twitching) {
      var_1.twitching = 1;
      level thread gator_mouth_twitch(var_0, var_1, var_2, var_3);
      level thread gator_mouth_crush(var_0, var_2, var_1, var_3);
    }
  }
}

bumper_cars() {
  scripts\cp\maps\cp_zmb\cp_zmb_bumpercars::init_bumper_cars();
}

gator_mouth_twitch(var_0, var_1, var_2, var_3) {
  var_2 endon("stop_twitch");
  playsoundatpos((-1696, 1201, 550), "croc_trap_idle_mechanics");
  var_1 moveto(var_1.origin + (0, 0, -5), 0.5, 0.4, 0.1);
  var_1 waittill("movedone");
  var_1 moveto(var_1.origin + (0, 0, 5), 0.5, 0.4, 0.1);
  var_1 waittill("movedone");
  var_1 moveto(var_1.origin + (0, 0, -5), 0.5, 0.4, 0.1);
  var_1 waittill("movedone");
  var_1 moveto(var_1.origin + (0, 0, 5), 0.5, 0.4, 0.1);
  var_1 waittill("movedone");
  var_1 moveto(var_1.origin + (0, 0, -5), 0.5, 0.4, 0.1);
  var_1 waittill("movedone");
  var_1 moveto(var_1.origin + (0, 0, 5), 0.5, 0.4, 0.1);
  var_1 waittill("movedone");
  wait(1);
  var_1.twitching = 0;
}

gator_mouth_crush(var_0, var_1, var_2, var_3) {
  level notify("stop_gator_mouth_crush");
  level endon("stop_gator_mouth_crush");
  level endon("deactivate_gator_mouth");
  for(;;) {
    var_1 waittill("trigger", var_4);
    if(isPlayer(var_4) && var_4 scripts\cp\utility::is_valid_player()) {
      var_1 notify("stop_twitch");
      var_1 playSound("croc_trap_bite_tick_tock");
      var_1 playSound("croc_trap_trigger_switch");
      wait(3);
      var_5 = 1;
      var_6 = undefined;
      var_7 = undefined;
      foreach(var_9 in level.spawned_enemies) {
        if(isDefined(var_9.agent_type) && var_9.agent_type == "zombie_brute") {
          if(var_9 istouching(var_1)) {
            var_5 = 0;
            var_6 = var_9;
          }
        }
      }

      if(isDefined(level.the_hoff)) {
        if(level.the_hoff istouching(var_1)) {
          var_5 = 0;
          var_7 = 1;
        }
      }

      if(var_5) {
        var_2 moveto(var_3 + (0, 0, -100), 0.15);
        var_1 playSound("croc_trap_bite");
        earthquake(0.45, 3, var_1.origin, 750);
        var_1 thread mouth_trig_kill(var_4);
        wait(0.15);
        scripts\engine\utility::exploder(255);
        var_0 disconnectpaths();
        var_0 solid();
        var_1 notify("stop_killing");
        var_2 setModel("zmb_croc_chomp_head_toothless");
        level.gator_light setlightintensity(0);
        wait(1);
        var_0 connectpaths();
        var_0 notsolid();
        var_2 moveto(var_3, 1);
        wait(5);
        var_2.twitching = 0;
        level.gator_light setlightintensity(4);
        var_2 setModel("zmb_croc_chomp_head_toothless_on");
      } else if(isDefined(var_7)) {
        var_2 moveto(var_3 + (0, 0, -40), 0.1);
        var_1 playSound("trap_laser_activate");
        earthquake(0.45, 3, var_1.origin, 450);
        wait(1.5);
        var_2 moveto(var_3, 0.25);
        wait(1);
        var_2.twitching = 0;
      } else {
        if(isDefined(var_6)) {
          var_6.croc_chomp = 1;
          var_6.allowpain = 1;
          var_6 dodamage(1, var_6.origin, var_4, var_4);
          wait(0.1);
          var_6.croc_chomp = 0;
          var_6.allowpain = 0;
          wait(0.7);
          level thread break_gator_teeth(0.1);
        }

        var_2 moveto(var_3 + (0, 0, -40), 0.1);
        var_1 playSound("trap_laser_activate");
        earthquake(0.45, 3, var_1.origin, 450);
        wait(1.5);
        scripts\engine\utility::flag_set("gator_tooth_broken");
        var_2 moveto(var_3, 0.25);
        wait(1);
        var_2.twitching = 0;
      }

      return;
    }
  }
}

mouth_trig_kill(var_0) {
  self endon("stop_killing");
  var_1 = gettime() + 250;
  while(gettime() < var_1) {
    self waittill("trigger", var_2);
    if(isPlayer(var_2) && scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    var_2.nocorpse = 1;
    var_2.full_gib = 1;
    var_2.deathmethod = "croc";
    if(scripts\engine\utility::istrue(var_2.isrewinding)) {
      continue;
    }

    var_2 dodamage(var_2.health + 100, var_2.origin, self, self, "MOD_UNKNOWN");
    if(isDefined(var_0)) {
      if(!isDefined(var_0.trapkills["trap_gator"])) {
        var_0.trapkills["trap_gator"] = 1;
      } else {
        var_0.trapkills["trap_gator"]++;
      }

      var_3 = ["kill_trap_generic", "kill_trap_gator"];
      var_0 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_3), "zmb_comment_vo", "high", 10, 0, 0, 1, 25);
    }
  }
}

listen_for_old_spawning_dvar() {
  level endon("game_ended");
  for(;;) {
    if(getdvarint("scr_use_old_spawning") == 1) {
      level.use_adjacent_volumes = 0;
    } else {
      level.use_adjacent_volumes = 1;
    }

    wait(1);
  }
}

cp_zmb_onplayerconnect(var_0) {
  var_0.num_tickets = 0;
  var_0 scripts\cp\zombies\zombies_wor::wor_init();
  if(var_0 scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    var_0 setclientomnvar("zombie_afterlife_self_revive_count", 3);
  } else {
    var_0 setclientomnvar("zombie_afterlife_self_revive_count", 1);
  }

  var_0 thread update_team_door_buy_on_spawn();
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::update_player_revives_every_ten_waves(var_0);
  if(!isDefined(level.kick_player_queue)) {
    level thread kick_player_queue_loop();
  }

  var_0 thread kick_for_inactivity(var_0);
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

update_team_door_buy_on_spawn() {
  self endon("disconnect");
  self waittill("spawned");
  if(!scripts\engine\utility::flag("team_doors_initialized")) {
    return;
  }

  if(isDefined(level.team_door_adjusted_for) && level.players.size == level.team_door_adjusted_for) {
    return;
  }

  if(isDefined(level.team_door_adjusted_for) && level.players.size < level.team_door_adjusted_for) {
    return;
  }

  var_0 = scripts\engine\utility::getStructArray("team_door_switch", "script_noteworthy");
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  foreach(var_5 in var_0) {
    if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_5)) {
      continue;
    }

    if(var_5.script_side == "moon") {
      if(var_2) {
        continue;
      }

      level.moon_donations--;
      var_2 = 1;
    }

    if(var_5.script_side == "triton") {
      if(var_3) {
        continue;
      }

      level.triton_donations--;
      var_3 = 1;
    }

    if(var_5.script_side == "kepler") {
      if(var_1) {
        continue;
      }

      level.kepler_donations--;
      var_1 = 1;
    }

    var_6 = getEntArray(var_5.target, "targetname");
    foreach(var_8 in var_6) {
      if(!isDefined(var_8.script_noteworthy)) {
        continue;
      } else {
        if(scripts\engine\utility::string_starts_with(var_8.classname, "scriptable")) {
          var_8 setscriptablepartstate("fx", "adjust");
          continue;
        }

        if(var_8.script_noteworthy == "progress") {
          var_8 movez(-4, 0.05);
          var_8 waittill("movedone");
          break;
        }
      }
    }
  }

  level.team_door_adjusted_for = level.players.size;
}

cp_zmb_should_continue_progress_bar_think(var_0) {
  if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    return 1;
  }

  return !scripts\cp\cp_laststand::player_in_laststand(var_0);
}

boat_ride() {
  for(;;) {
    var_0 = getvehiclenode("boat_ride_start", "targetname");
    var_1 = spawnvehicle("park_boat_ride_boat", "boat", "cp_kevin", var_0.origin, var_0.angles);
    var_1 attachpath(var_0);
    var_1 startpath(var_0);
    if(!isDefined(level.shredder_battery)) {
      var_1 thread shredder_battery_spawn();
    }

    var_1 waittill("reached_end_node");
    var_1 delete();
  }
}

shredder_battery_spawn() {
  if(scripts\cp\utility::is_codxp()) {
    return;
  }

  self endon("reached_end_node");
  var_0 = spawn("script_model", self.origin);
  while(!isDefined(var_0)) {
    scripts\engine\utility::waitframe();
  }

  thread delete_battery_at_end_node(var_0);
  var_0 setModel("alien_crafting_battery_single_01");
  self setCanDamage(1);
  var_0 linkto(self, "tag", (-80, 0, 15), (0, 0, 0));
  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    if(isDefined(var_2) && isPlayer(var_2)) {
      if(distancesquared(var_0.origin, var_4) < 400) {
        var_0 thread knock_off_battery(self);
        break;
      }
    }
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

delete_battery_at_end_node(var_0) {
  level endon("ww_iw7_shredder_zm_battery_dropped");
  scripts\engine\utility::waitframe();
  self waittill("reached_end_node");
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

knock_off_battery(var_0) {
  level.shredder_battery = 1;
  self unlink();
  var_1 = var_0 vehicle_getvelocity();
  var_1 = var_1 * -1;
  var_1 = var_1 + (0, 0, 10);
  level.battery_in_geyser = 1;
  self delete();
  level notify("ww_iw7_shredder_zm_battery_dropped", (0, 0, -10000));
}

geysers_and_boatride() {
  level waittill("swamp_stage power_on");
  level thread boat_ride();
  var_0 = scripts\engine\utility::getStructArray("geyser", "targetname");
  foreach(var_2 in var_0) {
    thread scripts\engine\utility::play_loopsound_in_space("trap_geyser_idle_lp", var_2.origin);
    playFX(level._effect["geyser_splash_lg"], var_2.origin);
    var_2 thread geyser_erupt();
  }

  level thread geyser_sequence();
}

setup_ufo() {
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::init_ufo_quest();
}

geyser_sequence() {
  var_0 = ["a", "e", "f"];
  var_1 = ["c", "a", "e"];
  var_2 = ["a", "b", "c", "e", "f"];
  var_3 = [var_0, var_1, var_2];
  for(;;) {
    wait(2);
    foreach(var_5 in var_3) {
      foreach(var_7 in var_5) {
        var_8 = get_geyser(var_7);
        var_8 notify("erupt");
        wait(1);
      }

      wait(2);
    }
  }
}

get_geyser(var_0) {
  var_1 = scripts\engine\utility::getStructArray("geyser", "targetname");
  foreach(var_3 in var_1) {
    if(var_3.script_noteworthy == var_0) {
      return var_3;
    }
  }
}

geyser_erupt() {
  for(;;) {
    self waittill("erupt");
    if(self.script_noteworthy == "a") {
      playFX(level._effect["geyser_blast_side"], self.origin, anglesToForward(self.angles + (90, 0, 90)), anglestoup(self.angles + (90, 0, 90)));
    } else {
      playFX(level._effect["geyser_blast"], self.origin, anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
    }

    playsoundatpos(self.origin, "trap_geyser_launch");
    if(self.script_noteworthy != "a" && isDefined(level.battery_in_geyser) && !isDefined(level.battery_launched)) {
      level thread launch_battery_from_geyser(self);
    }

    level thread launch_players(self);
    level thread launch_zombies(self.origin);
  }
}

launch_battery_from_geyser(var_0) {
  level endon("end_battery_launch_func");
  level.battery_launched = 1;
  var_1 = var_0.origin;
  var_2 = level.shredder_battery;
  var_2.origin = var_0.origin;
  var_2 moveto(var_1 + (0, 0, 60), 0.25);
  var_2 waittill("movedone");
  var_2 makeusable();
  var_2 sethintstring(&"CP_QUEST_WOR_PART");
  var_2 thread pick_up_battery();
  for(var_3 = 0; var_3 < 8; var_3++) {
    var_2 rotateto(var_2.angles + (90, 0, 0), 0.2);
    wait(0.2);
  }

  var_2 makeunusable();
  var_2 moveto(var_1 + (0, 0, -10), 0.5);
  var_2 waittill("movedone");
  level.battery_launched = undefined;
}

pick_up_battery() {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_0);
    if(isPlayer(var_0)) {
      break;
    }
  }

  level notify("end_battery_launch_func");
}

launch_players(var_0) {
  var_1 = var_0.origin;
  var_2 = (0, 0, 650);
  var_3 = undefined;
  for(var_4 = 0; var_4 < 40; var_4++) {
    foreach(var_6 in level.players) {
      if(scripts\engine\utility::istrue(var_6.isrewinding)) {
        continue;
      }

      if(distancesquared(var_6.origin, var_1) > 576 || isDefined(var_6.flung)) {
        continue;
      }

      var_6 notify("cancel_sentry");
      var_6 notify("cancel_medusa");
      var_6 notify("cancel_trap");
      var_6 notify("cancel_boombox");
      var_6 notify("cancel_revocator");
      var_6 notify("cancel_ims");
      var_6 notify("cancel_gascan");
      if(var_0.script_noteworthy == "a") {
        var_2 = vectornormalize((-2549.5, -163.5, 353.8) - var_0.origin) * 500 + (0, 0, 920);
        var_3 = (-2549.5, -163.5, 353.8);
        var_6 thread launch_player_to_kepler(var_3, var_0);
        wait(0.25);
        continue;
      }

      var_6 thread launch_player(var_0, var_2, var_3);
    }

    wait(0.05);
  }
}

launch_player_to_kepler(var_0, var_1) {
  self endon("disconnect");
  self allowmelee(0);
  self allowslide(0);
  self allowjump(0);
  scripts\cp\utility::allow_player_teleport(0);
  self.flung = 1;
  self playlocalsound("trap_geyser_plr_launch_lr");
  self earthquakeforplayer(0.25, 3, self.origin, 700);
  self.anchor = spawn("script_model", self.origin);
  self.anchor setModel("tag_origin");
  self limitedmovement(1);
  self playerlinkto(self.anchor);
  thread unset_player_flung(2);
  playfxontagforclients(level._effect["geyser_fullscreen_fx"], self, "tag_eye", self);
  var_2 = scripts\engine\utility::getStructArray(var_1.target, "targetname");
  var_3 = scripts\engine\utility::random(var_2);
  thread handle_host_migration_during_launch();
  thread watch_player_landing(var_1, var_0);
  var_4 = vectortoangles((-2613.5, -131.5, 353.8) - var_1.origin);
  self setplayerangles(var_4);
  for(;;) {
    var_5 = distance(self.anchor.origin, var_3.origin);
    var_6 = 850;
    var_7 = var_5 / var_6;
    if(var_7 < 0.05) {
      var_7 = 0.05;
    }

    self.anchor moveto(var_3.origin, var_7);
    wait(var_7 + 0.05);
    if(!isDefined(var_3.target)) {
      break;
    }

    var_2 = scripts\engine\utility::getStructArray(var_3.target, "targetname");
    var_3 = scripts\engine\utility::random(var_2);
  }

  self setorigin(self.anchor.origin);
  self unlink();
  self.anchor delete();
  self setvelocity((0, 0, 0));
  var_8 = vectornormalize((-2613.5, -131.5, 353.8) - self.origin) * 500 + (0, 0, 650);
  self setvelocity(var_8);
}

launch_player(var_0, var_1, var_2) {
  self endon("disconnect");
  scripts\cp\utility::allow_player_teleport(0);
  self allowmelee(0);
  self allowslide(0);
  self.flung = 1;
  self playlocalsound("trap_geyser_plr_launch_lr");
  self earthquakeforplayer(0.25, 3, self.origin, 700);
  self.anchor = spawn("script_model", self.origin);
  self.anchor setModel("tag_origin");
  self playerlinkto(self.anchor);
  self.anchor moveto(self.origin + (0, 0, 90), 0.25);
  self.anchor waittill("movedone");
  self unlink();
  self.anchor delete();
  self shellshock("zm_geyser_launch", 2);
  thread unset_player_flung(2);
  if(var_0.script_noteworthy == "a") {
    self setplayerangles((-2549.5, -163.5, 0));
  }

  self setvelocity(var_1);
  playfxontagforclients(level._effect["geyser_fullscreen_fx"], self, "tag_eye", self);
  thread watch_player_landing(var_0, var_2);
}

unset_player_flung(var_0) {
  self endon("disconnect");
  wait(var_0);
  self.flung = undefined;
}

watch_player_landing(var_0, var_1, var_2) {
  level endon("host_migration_end");
  self endon("disconnect");
  if(isDefined(var_2)) {
    wait(var_2);
  }

  var_3 = 2304;
  if(isDefined(var_1)) {
    var_4 = vectortoangles((-2549.5, -163.5, -200) - var_0.origin);
    self setplayerangles(var_4);
    self shellshock("zm_geyser_launch", 2);
  } else {
    self shellshock("zm_geyser_launch", 0.5);
  }

  wait(0.5);
  var_5 = 1;
  var_6 = gettime();
  while(!self isonground()) {
    if(scripts\engine\utility::istrue(self.isrewinding)) {
      var_5 = 0;
    }

    var_7 = scripts\cp\cp_agent_utils::get_alive_enemies();
    foreach(var_9 in var_7) {
      if(isDefined(var_9.agent_type) && var_9.agent_type == "zombie_brute" || var_9.agent_type == "zombie_ghost" || var_9.agent_type == "zombie_grey") {
        continue;
      }

      if(distancesquared(self.origin, var_9.origin) < var_3) {
        var_9 dodamage(var_9.health, var_9.origin, self, self, "MOD_CRUSH");
      }
    }

    wait(0.05);
    foreach(var_12 in level.players) {
      if(scripts\engine\utility::istrue(self.flung)) {
        continue;
      }

      if(var_12 == self) {
        continue;
      }

      if(!var_12 isonground()) {
        continue;
      }

      if(isDefined(var_12.anchor)) {
        continue;
      }

      if(self istouching(var_12)) {
        var_12 setvelocity(vectornormalize(var_12.origin - self.origin) * 800 + (0, 0, 50));
      }
    }

    wait(0.05);
  }

  var_14 = gettime();
  if(isDefined(self.abh_used) && self.abh_used > var_6 && self.abh_used < var_14) {
    var_5 = 0;
  }

  if(var_5) {
    self shellshock("frag_grenade_mp", 1);
    self earthquakeforplayer(0.25, 1, self.origin, 120);
  }

  self.flung = undefined;
  if(!scripts\cp\utility::isteleportenabled()) {
    scripts\cp\utility::allow_player_teleport(1);
  }

  self notify("can_teleport");
  self allowmelee(1);
  self allowslide(1);
  self allowjump(1);
  self limitedmovement(0);
  self notify("player_landed");
}

handle_host_migration_during_launch() {
  self endon("player_landed");
  level waittill("host_migration_end");
  self unlink();
  var_0 = (-2617, -123, 469);
  var_1 = 0;
  if(!isDefined(level.kepler_landing_orgs)) {
    level.kepler_landing_orgs = [(-2617, -123, 469), (-2577, -123, 469), (-2657, -123, 469), (-2617, -83, 469), (-2617, -163, 469)];
    level.kepler_org_index = [0, 0, 0, 0, 0];
  }

  for(var_2 = 0; var_2 < level.kepler_org_index.size; var_2++) {
    if(level.kepler_org_index[var_2] == 0) {
      var_0 = level.kepler_landing_orgs[var_2];
      var_1 = var_2;
      level.kepler_org_index[var_2] = 1;
      break;
    }
  }

  self setorigin(var_0, 1);
  var_3 = 2304;
  var_4 = 1;
  var_5 = gettime();
  while(!self isonground()) {
    if(scripts\engine\utility::istrue(self.isrewinding)) {
      var_4 = 0;
    }

    var_6 = scripts\cp\cp_agent_utils::get_alive_enemies();
    foreach(var_8 in var_6) {
      if(isDefined(var_8.agent_type) && var_8.agent_type == "zombie_brute" || var_8.agent_type == "zombie_ghost" || var_8.agent_type == "zombie_grey") {
        continue;
      }

      if(distancesquared(self.origin, var_8.origin) < var_3) {
        var_8 dodamage(var_8.health, var_8.origin, self, self, "MOD_CRUSH");
      }
    }

    wait(0.05);
    foreach(var_11 in level.players) {
      if(var_11 == self) {
        continue;
      }

      if(self istouching(var_11)) {
        var_11 setvelocity(vectornormalize(var_11.origin - self.origin) * 800 + (0, 0, 50));
      }
    }

    wait(0.05);
  }

  var_13 = gettime();
  if(isDefined(self.abh_used) && self.abh_used > var_5 && self.abh_used < var_13) {
    var_4 = 0;
  }

  if(var_4) {
    self shellshock("frag_grenade_mp", 1);
    self earthquakeforplayer(0.25, 1, self.origin, 120);
  }

  self.flung = undefined;
  if(!scripts\cp\utility::isteleportenabled()) {
    scripts\cp\utility::allow_player_teleport(1);
  }

  self notify("can_teleport");
  self allowmelee(1);
  self allowslide(1);
  self allowjump(1);
  self limitedmovement(0);
  level.kepler_org_index[var_1] = 0;
  self notify("player_landed");
}

notify_after_time(var_0, var_1) {
  wait(var_1);
  level notify(var_0);
}

launch_zombies(var_0) {
  for(var_1 = 0; var_1 < 20; var_1++) {
    foreach(var_3 in level.spawned_enemies) {
      if(isDefined(var_3.flung) || isDefined(var_3.agent_type) && var_3.agent_type == "zombie_brute" || var_3.agent_type == "zombie_ghost" || var_3.agent_type == "zombie_grey") {
        continue;
      }

      if(distancesquared(var_3.origin, var_0) < 576) {
        var_3 thread zombie_geyser_fling(var_0);
      }
    }

    wait(0.1);
  }
}

zombie_geyser_fling(var_0) {
  self.flung = 1;
  self.do_immediate_ragdoll = 1;
  self.disable_armor = 1;
  self setsolid(0);
  self setvelocity((0, 0, 1050));
  wait(0.1);
  self dodamage(1000000, var_0, undefined, undefined, "MOD_UNKNOWN");
}

cp_zmb_mutilation_mask_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;
  var_7 = zombies_should_mutilate(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  return var_7;
}

zombies_should_mutilate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_3)) {
    var_3 = 0;
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
        if(isDefined(var_4) && isDefined(var_4.agent_type) && var_4.agent_type == "c6") {
          return 31;
        }

        break;

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

        case "iw7_shredder_zm_pap1":
        case "iw7_shredder_zm":
          if(var_8 && !is_arm_or_head_damage(var_0)) {
            return 31;
          }
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

gator_tooth_init() {
  scripts\engine\utility::flag_init("gator_tooth_broken");
  scripts\engine\utility::flag_init("gator_gold_tooth_pickup");
  scripts\engine\utility::flag_init("gator_tooth_fixed");
  scripts\engine\utility::flag_init("gator_gold_tooth_placed");
  level.gator_teeth_array = [];
  var_0 = getEntArray("broken_gator_tooth_1", "targetname");
  level.gator_teeth_array = scripts\engine\utility::array_combine(level.gator_teeth_array, var_0);
  var_1 = getEntArray("broken_gator_tooth_2", "targetname");
  level.gator_teeth_array = scripts\engine\utility::array_combine(level.gator_teeth_array, var_1);
  var_2 = getEntArray("broken_gator_tooth_3", "targetname");
  level.gator_teeth_array = scripts\engine\utility::array_combine(level.gator_teeth_array, var_2);
  level.gold_tooth_3_pickup = getEntArray("broken_gator_gold_tooth_3_pickup", "targetname");
  level.gator_mouth_door = getent("gator_mouth_door", "targetname");
  var_3 = getent("croc_mouth_door", "targetname");
  if(isDefined(var_3)) {
    level.gator_mouth_door delete();
    level.gator_mouth_door = getent("croc_mouth_door", "targetname");
  }

  var_4 = getent("gator_mouth", "targetname");
  level.gator_mouth_light = getent("gator_mouth_room_light", "targetname");
  level.gator_mouth_light setlightintensity(0);
  level.gator_tooth_use_trig = spawn("script_origin", level.gator_teeth_array[0].origin + (0, 0, -75));
  foreach(var_6 in level.gator_teeth_array) {
    var_6 linkto(var_4);
  }

  level thread gator_tooth_broken();
  if(scripts\cp\utility::is_codxp()) {
    var_8 = scripts\engine\utility::getstruct("gold_teeth", "script_noteworthy");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_8);
  }
}

gator_tooth_broken() {
  scripts\engine\utility::flag_wait("gator_tooth_broken");
  scripts\engine\utility::flag_wait("gator_gold_tooth_placed");
  level.gator_mouth_door unlink();
  level.gator_mouth_door playSound("croc_trap_door_open");
  level.gator_mouth_door moveto(level.gator_mouth_door.origin + (0, 0, -200), 2);
  var_0 = scripts\engine\utility::getStructArray("gator_door_dust", "targetname");
  if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    foreach(var_2 in var_0) {
      playFX(level._effect["vfx_gator_door_dust"], var_2.origin);
      wait(randomfloatrange(0.2, 0.5));
    }
  }

  var_4 = level.gator_mouth_light;
  if(isDefined(var_4)) {
    for(var_5 = 0; var_5 < 4; var_5++) {
      var_4 setlightintensity(2);
      wait(randomfloatrange(0.5, 1));
      var_4 setlightintensity(0);
      wait(randomfloatrange(0.5, 1));
    }

    var_4 setlightintensity(5);
  }
}

break_gator_teeth(var_0) {
  level endon("game_ended");
  if(isDefined(var_0)) {
    wait(var_0);
  }

  playsoundatpos((-1616, 1502, 360), "zmb_croc_trap_teeth_shatter_01");
  playsoundatpos((-1897, 1508, 360), "zmb_croc_trap_teeth_shatter_02");
  foreach(var_2 in level.gator_teeth_array) {
    var_2 hide();
    playFX(level._effect["gator_tooth_break"], var_2.origin);
    scripts\engine\utility::waitframe();
  }
}

gold_teeth_pickup_debug() {
  level waittill("gold_tooth_pickup_trigger");
  var_0 = scripts\engine\utility::getstruct("gold_teeth", "script_noteworthy");
  var_1 = level.players[0];
  gold_teeth_pickup(var_0, var_1);
}

gold_teeth_pickup(var_0, var_1) {
  foreach(var_3 in level.gold_tooth_3_pickup) {
    var_3 delete();
  }

  var_1 playlocalsound("purchase_ticket");
  scripts\engine\utility::flag_set("gator_gold_tooth_pickup");
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_teeth", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  level scripts\cp\utility::set_quest_icon(6);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

gold_teeth_hint_func(var_0, var_1) {
  if(!isDefined(var_1.ticket_item_outlined)) {
    var_1.ticket_item_outlined = level.gold_tooth_3_pickup[0];
    if(self.num_tickets >= level.interactions[var_0.script_noteworthy].cost) {
      var_1.ticket_item_outlined hudoutlineenableforclient(var_1, 3, 1, 0);
    } else {
      var_1.ticket_item_outlined hudoutlineenableforclient(var_1, 1, 1, 0);
    }
  } else if(var_1.ticket_item_outlined != level.gold_tooth_3_pickup[0]) {
    var_1.ticket_item_outlined hudoutlinedisableforclient(var_1);
    var_1.ticket_item_outlined = level.gold_tooth_3_pickup[0];
    if(self.num_tickets >= level.interactions[var_0.script_noteworthy].cost) {
      var_1.ticket_item_outlined hudoutlineenableforclient(var_1, 3, 1, 0);
    } else {
      var_1.ticket_item_outlined hudoutlineenableforclient(var_1, 1, 1, 0);
    }
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

gator_tooth_placement_init() {
  level.gator_teeth_placed = 0;
}

gator_mouth_hint_func(var_0, var_1) {
  if(scripts\engine\utility::flag("gator_tooth_broken") && scripts\engine\utility::flag("gator_gold_tooth_pickup")) {
    return "";
  }

  return "";
}

gator_mouth_activation_func(var_0, var_1) {
  if(scripts\engine\utility::flag("gator_gold_tooth_pickup") && scripts\engine\utility::flag("gator_tooth_broken")) {
    if(level.gator_teeth_placed) {
      return;
    }

    level.gator_teeth_placed = 1;
    scripts\engine\utility::flag_set("gator_gold_tooth_placed");
    playsoundatpos((-1616, 1502, 360), "zmb_croc_trap_teeth_place_01");
    playsoundatpos((-1897, 1508, 360), "zmb_croc_trap_teeth_place_02");
    foreach(var_3 in level.gator_teeth_array) {
      var_3 setModel(var_3.model + "_gold");
      var_3 show();
    }

    var_5 = scripts\engine\utility::getStructArray("gator_teeth_placement", "script_noteworthy");
    foreach(var_7 in var_5) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_7);
    }
  }
}

put_tooth_in_gator_mouth() {
  var_0 = getent("gator_mouth", "targetname");
  scripts\engine\utility::flag_wait("gator_gold_tooth_pickup");
  level.gator_tooth_use_trig makeusable();
  level.gator_tooth_use_trig sethintstring(&"CP_QUEST_WOR_PLACE_PART");
  level.gator_tooth_use_trig waittill("trigger");
  scripts\engine\utility::flag_set("gator_gold_tooth_placed");
  foreach(var_2 in level.gator_teeth_array) {
    var_2 setModel(var_2.model + "_gold");
    var_2 show();
  }

  level.gator_tooth_use_trig delete();
}

gator_quest_debug() {
  wait(10);
  scripts\engine\utility::flag_set("gator_tooth_broken");
  scripts\engine\utility::flag_set("gator_gold_tooth_placed");
}

cp_zmb_should_allow_far_search_dist_func(var_0) {
  if(interaction_is_shootinggallery(var_0)) {
    return 1;
  }

  if(weapon_not_on_wall(var_0)) {
    return 1;
  }

  if(var_0.script_noteworthy == "dj_quest_speaker") {
    return 1;
  }

  if(var_0.script_noteworthy == "ark_quest_station") {
    return 1;
  }

  if(var_0.script_noteworthy == "dj_quest_speaker_mid") {
    return 1;
  }

  if(var_0.script_noteworthy == "coaster") {
    return 1;
  }

  return 0;
}

weapon_not_on_wall(var_0) {
  switch (var_0.script_noteworthy) {
    case "iw7_nrg_zm":
    case "iw7_m1c_zm":
    case "iw7_forgefreeze_zm+forgefreezealtfire":
    case "zfreeze_semtex_mp":
      return 1;

    default:
      return 0;
  }
}

interaction_is_shootinggallery(var_0) {
  return var_0.script_noteworthy == "shooting_gallery" || var_0.script_noteworthy == "shooting_gallery_afterlife";
}

zmb_last_stand_handler(var_0) {
  if(var_0 scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if(!scripts\engine\utility::istrue(var_0.have_self_revive)) {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("laststand", "zmb_comment_vo");
    } else if(isDefined(var_0.times_self_revived)) {
      if(var_0.times_self_revived > 3) {
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("laststand", "zmb_comment_vo");
      }
    }
  }

  if(level.players.size == 1) {
    if(isDefined(level.current_speaker)) {
      level notify("destroy_speaker");
    }
  }

  zmb_last_stand_weapon_handler(var_0);
}

delay_try_merge_clones() {
  level endon("game_ended");
  level notify("delay_try_merge_clones");
  level endon("delay_try_merge_clones");
  wait(1.5);
  scripts\mp\agents\zombie_grey\zombie_grey_agent::try_merge_clones();
}

zmb_last_stand_weapon_handler(var_0) {
  var_0 takeweapon("iw7_zm1coaster_zm");
}

zmb_power_gate_handler() {
  scripts\engine\utility::flag_wait("doors_initialized");
  var_0 = getEntArray("bollard_trigger", "targetname");
  foreach(var_2 in var_0) {
    var_2 sethintstring(&"COOP_INTERACTIONS_REQUIRES_POWER");
  }

  var_4 = getEntArray("first_gate_bollard", "targetname");
  var_5 = [];
  var_6 = [];
  foreach(var_8 in level.current_interaction_structs) {
    if(isDefined(var_8.script_area) && var_8.script_area == "moon" || var_8.script_area == "front_gate") {
      if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == "debris_750") {
        var_5[var_5.size] = var_8;
      }
    }
  }

  var_10 = getEntArray("door_buy", "targetname");
  foreach(var_2 in var_10) {
    var_2 scripts\engine\utility::trigger_off();
  }

  foreach(var_14 in var_5) {
    level thread scripts\cp\cp_interaction::remove_from_current_interaction_list(var_14);
    var_14.out_of_order = 1;
  }

  level waittill("moon power_on");
  foreach(var_2 in var_0) {
    var_2 delete();
  }

  foreach(var_13 in var_4) {
    var_13 moveto(var_13.origin - (0, 0, 37), 2, 0.1, 0.1);
  }

  wait(1);
  var_15 = getEntArray("first_gate_bollard_clip", "targetname");
  foreach(var_13 in var_15) {
    var_13 connectpaths();
    var_13 delete();
  }

  foreach(var_14 in var_5) {
    var_14.out_of_order = 0;
    level thread scripts\cp\cp_interaction::add_to_current_interaction_list(var_14);
  }

  foreach(var_2 in var_10) {
    var_2 scripts\engine\utility::trigger_on();
  }
}

setupc6agent() {
  scripts\mp\agents\c6\c6_agent::setupagent();
  self.accuracy = 1;
  self.noattackeraccuracymod = 0;
  self.sharpturnnotifydist = 48;
  self.last_enemy_sight_time = 0;
  self.desiredenemydistmax = 500;
  self.desiredenemydistmin = 400;
  self.maxtimetostrafewithoutlos = 3000;
  self.strafeifwithindist = self.desiredenemydistmax + 100;
  self.maxsightdistsqrd = 67108864;
  self.fastcrawlanimscale = 12;
  self.forcefastcrawldist = 340;
  self.fastcrawlmaxhealth = 40;
  self.dismemberchargeexplodedistsq = 2500;
  self.explosionradius = 75;
  self.explosiondamagemin = 30;
  self.explosiondamagemax = 50;
  self.meleerangesq = 9216;
  self.meleechargedist = 45;
  self.meleechargedistvsplayer = 45;
  self.meleechargedistreloadmultiplier = 1.2;
  self.maxzdiff = 50;
  self.meleeactorboundsradius = 32;
  self.meleemindamage = 300;
  self.meleemaxdamage = 450;
  self.footstepdetectdist = 1000;
  self.footstepdetectdistwalk = 1000;
  self.footstepdetectdistsprint = 1000;
  thread scripts\mp\agents\c6\c6_agent::scriptedgoalwaitforarrival();
}

cp_zmb_near_equipment_func(var_0) {
  var_1 = 16384;
  if(isDefined(level.alldjcenterstructs)) {
    var_2 = sortbydistance(level.alldjcenterstructs, var_0.origin);
    if(scripts\engine\utility::istrue(var_2[0].placed)) {
      if(distance2dsquared(var_2[0].origin, var_0.origin) < var_1) {
        return 1;
      }

      return 0;
    }

    return 0;
  }

  return 0;
}

cp_zmb_spawn_fx_func() {
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

cp_zmb_introscreen_text() {
  wait(2);
  var_0 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_ZMB_INTRO_LINE_1", 1);
  wait(1);
  var_1 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_ZMB_INTRO_LINE_2", 2);
  wait(1);
  var_2 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_ZMB_INTRO_LINE_3", 3);
  wait(1);
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    var_3 = scripts\cp\cp_hud_util::introscreen_corner_line(&"DIRECT_BOSS_FIGHT_LINE4_ZMB", 4);
  } else {
    var_3 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_ZMB_INTRO_LINE_4", 4);
  }

  level waittill("introscreen_over");
  var_0 fadeovertime(2);
  var_1 fadeovertime(2);
  var_2 fadeovertime(2);
  var_3 fadeovertime(2);
  var_0.alpha = 0;
  var_1.alpha = 0;
  var_2.alpha = 0;
  var_3.alpha = 0;
  var_0 destroy();
  var_1 destroy();
  var_2 destroy();
  var_3 destroy();
}

setup_generic_zombie_model_list() {
  level.generic_zombie_model_list = ["zombie_male_outfit_1", "zombie_male_outfit_1_2", "zombie_male_outfit_2", "zombie_male_outfit_2_2", "zombie_male_outfit_2_3", "zombie_male_outfit_2_4", "zombie_male_outfit_2_5", "zombie_male_outfit_2_6", "zombie_male_outfit_3", "zombie_male_outfit_3_2", "zombie_male_outfit_3_3", "zombie_male_outfit_4", "zombie_male_outfit_4_2", "zombie_male_outfit_4_3", "zombie_male_outfit_5", "zombie_male_outfit_5_2", "zombie_male_outfit_5_3", "zombie_male_outfit_6", "zombie_male_outfit_6_2", "zombie_male_outfit_1", "zombie_male_outfit_1_2", "zombie_male_outfit_2", "zombie_male_outfit_2_2", "zombie_male_outfit_2_3", "zombie_male_outfit_2_4", "zombie_male_outfit_2_5", "zombie_male_outfit_2_6", "zombie_male_outfit_3", "zombie_male_outfit_3_2", "zombie_male_outfit_3_3", "zombie_male_outfit_4", "zombie_male_outfit_4_2", "zombie_male_outfit_4_3", "zombie_male_outfit_5", "zombie_male_outfit_5_2", "zombie_male_outfit_5_3", "zombie_male_outfit_6", "zombie_male_outfit_6_2", "zombie_male_outfit_1", "zombie_male_outfit_1_2", "zombie_male_outfit_2", "zombie_male_outfit_2_2", "zombie_male_outfit_2_3", "zombie_male_outfit_2_4", "zombie_male_outfit_2_5", "zombie_male_outfit_2_6", "zombie_male_outfit_3", "zombie_male_outfit_3_2", "zombie_male_outfit_3_3", "zombie_male_outfit_4", "zombie_male_outfit_4_2", "zombie_male_outfit_4_3", "zombie_male_outfit_5", "zombie_male_outfit_5_2", "zombie_male_outfit_5_3", "zombie_male_outfit_6", "zombie_male_outfit_6_2", "zombie_male_outfit_1_b", "zombie_male_outfit_1_2_b", "zombie_male_outfit_2_b", "zombie_male_outfit_2_2_b", "zombie_male_outfit_2_3_b", "zombie_male_outfit_2_4_b", "zombie_male_outfit_2_5_b", "zombie_male_outfit_2_6_b", "zombie_male_outfit_3_b", "zombie_male_outfit_3_2_b", "zombie_male_outfit_3_3_b", "zombie_male_outfit_4_b", "zombie_male_outfit_4_2_b", "zombie_male_outfit_4_3_b", "zombie_male_outfit_5_b", "zombie_male_outfit_5_2_b", "zombie_male_outfit_5_3_b", "zombie_male_outfit_6_b", "zombie_male_outfit_6_2_b", "zombie_male_outfit_1_c", "zombie_male_outfit_1_2_c", "zombie_male_outfit_2_c", "zombie_male_outfit_2_2_c", "zombie_male_outfit_2_3_c", "zombie_male_outfit_2_4_c", "zombie_male_outfit_2_5_c", "zombie_male_outfit_2_6_c", "zombie_male_outfit_3_c", "zombie_male_outfit_3_2_c", "zombie_male_outfit_3_3_c", "zombie_male_outfit_4_c", "zombie_male_outfit_4_2_c", "zombie_male_outfit_4_3_c", "zombie_male_outfit_5_c", "zombie_male_outfit_5_2_c", "zombie_male_outfit_5_3_c", "zombie_male_outfit_6_c", "zombie_male_outfit_6_2_c", "zombie_female_outfit_1", "zombie_female_outfit_1_2", "zombie_female_outfit_1_3", "zombie_female_outfit_2", "zombie_female_outfit_2_2", "zombie_female_outfit_2_3", "zombie_female_outfit_3", "zombie_female_outfit_3_2", "zombie_female_outfit_3_3", "zombie_female_outfit_4", "zombie_female_outfit_4_2", "zombie_female_outfit_4_3", "zombie_female_outfit_5", "zombie_female_outfit_5_2", "zombie_female_outfit_5_3", "zombie_female_outfit_6", "zombie_female_outfit_6_2", "zombie_female_outfit_6_3", "zombie_female_outfit_7", "zombie_female_outfit_7_2", "zombie_female_outfit_7_3", "zombie_female_outfit_1_b", "zombie_female_outfit_1_2_b", "zombie_female_outfit_1_3_b", "zombie_female_outfit_2_b", "zombie_female_outfit_2_2_b", "zombie_female_outfit_2_3_b", "zombie_female_outfit_3_b", "zombie_female_outfit_3_2_b", "zombie_female_outfit_3_3_b", "zombie_female_outfit_4_b", "zombie_female_outfit_4_2_b", "zombie_female_outfit_4_3_b", "zombie_female_outfit_5_b", "zombie_female_outfit_5_2_b", "zombie_female_outfit_5_3_b", "zombie_female_outfit_6_b", "zombie_female_outfit_6_2_b", "zombie_female_outfit_6_3_b", "zombie_female_outfit_7_b", "zombie_female_outfit_7_2_b", "zombie_female_outfit_7_3_b", "zombie_female_outfit_1_c", "zombie_female_outfit_1_2_c", "zombie_female_outfit_1_3_c", "zombie_female_outfit_2_c", "zombie_female_outfit_2_2_c", "zombie_female_outfit_2_3_c", "zombie_female_outfit_3_c", "zombie_female_outfit_3_2_c", "zombie_female_outfit_3_3_c", "zombie_female_outfit_4_c", "zombie_female_outfit_4_2_c", "zombie_female_outfit_4_3_c", "zombie_female_outfit_5_c", "zombie_female_outfit_5_2_c", "zombie_female_outfit_5_3_c", "zombie_female_outfit_6_c", "zombie_female_outfit_6_2_c", "zombie_female_outfit_6_3_c", "zombie_female_outfit_7_c", "zombie_female_outfit_7_2_c", "zombie_female_outfit_7_3_c"];
}

post_nondeterministic_func() {
  wait(10);
  var_0 = scripts\engine\utility::getStructArray("team_door_switch", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2.target, "targetname");
    foreach(var_5 in var_3) {
      if(!isDefined(var_5.script_noteworthy)) {
        continue;
      } else if(var_5.script_noteworthy == "progress" && !isDefined(var_5.adjusted)) {
        var_5.adjusted = 1;
        var_6 = undefined;
        switch (level.players.size) {
          case 1:
            var_6 = 12;
            level.moon_donations = 2;
            level.kepler_donations = 2;
            level.triton_donations = 2;
            break;

          case 2:
            var_6 = 8;
            level.moon_donations = 1;
            level.kepler_donations = 1;
            level.triton_donations = 1;
            break;

          case 3:
            var_6 = 4;
            level.moon_donations = 0;
            level.kepler_donations = 0;
            level.triton_donations = 0;
            break;

          case 4:
            var_6 = undefined;
            level.moon_donations = -1;
            level.kepler_donations = -1;
            level.triton_donations = -1;
            break;
        }

        if(!isDefined(var_6)) {
          continue;
        }

        var_5 movez(var_6, 0.1);
        var_5 waittill("movedone");
      }
    }
  }

  level.team_door_adjusted_for = level.players.size;
  scripts\engine\utility::flag_set("team_doors_initialized");
}

cp_zmb_global_clientmatchdata_func() {
  var_0 = 24;
  setclientmatchdata("numQuestPiecesCompleted", level.num_of_quest_pieces_completed);
  setclientmatchdata("totalNumOfQuestPieces", var_0);
}

cp_zmb_should_drop_pillage(var_0, var_1) {
  if(isDefined(self.entered_playspace) && !self.entered_playspace) {
    return 0;
  }

  if(!scripts\cp\zombies\zombies_pillage::is_in_active_volume(var_1)) {
    return 0;
  }

  if(isDefined(self.hasplayedvignetteanim) && !self.hasplayedvignetteanim) {
    return 0;
  }

  if(isDefined(self.shredder_death)) {
    return 0;
  }

  if(isDefined(self.rocket_feet)) {
    return 0;
  }

  if(isDefined(self.head_is_exploding)) {
    return 0;
  }

  if(isDefined(self.dischord_spin)) {
    return 0;
  }

  if(scripts\cp\utility::too_close_to_other_interactions(var_1)) {
    return 0;
  }

  if(isDefined(var_0) && isPlayer(var_0)) {
    return 1;
  }

  return 0;
}

cp_zmb_eligable_for_reward_func(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4.shredder_death)) {
    return 0;
  }

  if(isDefined(var_4.rocket_feet)) {
    return 0;
  }

  if(isDefined(var_4.head_is_exploding)) {
    return 0;
  }

  if(isDefined(var_4.dischord_spin)) {
    return 0;
  }

  return 1;
}

cp_zmb_should_do_damage_check_func(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(scripts\engine\utility::istrue(var_5.rocket_feet)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_5.shredder_death)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_5.dischord_spin)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_5.head_is_exploding) && var_3 != "iw7_headcutterdummy_zm") {
    return 0;
  }

  if(isDefined(var_0) && isDefined(var_0.is_neil)) {
    return 0;
  }

  if(isDefined(var_0.agent_type) && var_0.agent_type == "zombie_grey" && scripts\cp\zombies\zombie_damage::isfriendlyfire(var_5, var_0)) {
    return 0;
  }

  if(!isDefined(self.is_coaster_zombie) && var_3 == "iw7_zm1coaster_zm") {
    return 0;
  }

  if(var_3 == "iw7_ufo_proj") {
    return 0;
  }

  if(var_3 == "zmb_grey_teleport_attack") {
    return 0;
  }

  return 1;
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
  self setweaponammostock(self.intro_gesture, 1);
  self giveandfireoffhand(self.intro_gesture);
}

cp_zmb_traversal_dismember_check(var_0) {
  var_1 = 75;
  var_2 = var_1 * var_1;
  if(!isDefined(level.traversal_dismember_locs)) {
    level.traversal_dismember_locs = [(1005, -936, 157), (1452, -1035, 190), (1346, -924, 192), (2378, 1377, 339), (3252, 1045, 133), (3330, 2253, 188), (3366, 542, 150), (3385, 211, 149), (2844, -981, 300), (-1161, -3361, 568), (-1534, -589, 440), (-2565, -1032, 427), (-2717, 1262, 428), (-2280, 1732, 427), (-2706, 2067, 465), (-2822, 1896, 465)];
  }

  foreach(var_4 in level.traversal_dismember_locs) {
    if(distancesquared(var_0.origin, var_4) < var_2) {
      return 0;
    }
  }

  return 1;
}

cp_zmb_patch_update_spawners() {
  scripts\cp\zombies\zombies_spawning::update_kvp((1328.2, -1057.4, 163.2), "script_fxid", "dirt");
  scripts\cp\zombies\zombies_spawning::update_kvp((1434.2, -1063.4, 163.2), "script_fxid", "dirt");
  scripts\cp\zombies\zombies_spawning::remove_origin((2231, -928.6, 256.2));
  scripts\cp\zombies\zombies_spawning::remove_origin((2205.5, -801.6, 250.5));
  scripts\cp\zombies\zombies_spawning::update_origin((2422.7, 136, -197.1), (2430.7, 136, -196));
  scripts\cp\zombies\zombies_spawning::update_origin((422, 1602.1, 16.7), (412, 1662.1, 16.7));
}

add_more_afterlife_arcade_start_points() {
  level.additional_afterlife_arcade_start_point = [];
  create_afterlife_arcade_start_point((-10128, -243, -1795), (0, 90, 0));
  create_afterlife_arcade_start_point((-10072, -243, -1795), (0, 90, 0));
}

create_afterlife_arcade_start_point(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.angles = var_1;
  level.additional_afterlife_arcade_start_point = scripts\engine\utility::array_add(level.additional_afterlife_arcade_start_point, var_2);
}

player_standing_on_nothing_check() {
  while(!isDefined(level.players)) {
    wait(0.1);
  }

  level.standing_list = [];
  for(;;) {
    foreach(var_1 in level.players) {
      var_1 bump_check((-1590, -628, 320), (-1475, -585, 490), (0, -200, 0), 1);
      var_1 bump_check((-815, -1075, 350), (-770, -760, 600), (200, 0, 0), 2);
    }

    wait(1);
  }
}

bump_check(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.standing_list[var_3])) {
    level.standing_list[var_3] = [];
  }

  var_4 = 0;
  if(is_in_box(var_0, var_1)) {
    if(isDefined(level.standing_list[var_3][self.name])) {
      self setvelocity(vectornormalize(var_2) * 100);
      var_4 = 1;
    }

    if(!var_4) {
      level.standing_list[var_3][self.name] = 1;
      return;
    }

    level.standing_list[var_3][self.name] = undefined;
    return;
  }

  level.standing_list[var_3][self.name] = undefined;
}

is_in_box(var_0, var_1) {
  if(self.origin[2] > var_0[2] && self.origin[2] < var_1[2]) {
    if(self.origin[1] > var_0[1] && self.origin[1] < var_1[1]) {
      if(self.origin[0] > var_0[0] && self.origin[0] < var_1[0]) {
        return 1;
      }
    }
  }

  return 0;
}

cp_zmb_enter_afterlife_clear_player_scriptable_func(var_0) {
  var_0 scripts\cp\zombies\zombies_weapons::turn_off_zapper_fx();
}

cp_zmb_idle_spot_patch_func() {
  scripts\cp\zombies\zombies_spawning::move_idle_spot((-34, -2417, 605), (20, -2344, 605));
  var_0 = [(844, -2322, 523), (-963, -3220, 477), (268, -1920, 229), (-586, -1168, -98), (1576, -873, -128), (2355, -265, -128), (3914, -357, 197), (4615, 1057, 207), (3440, 957, 182), (-2162, 519, 309), (-2167, -1201, 405), (-583, -2886, 643)];
  foreach(var_2 in var_0) {
    scripts\cp\zombies\zombies_spawning::add_idle_spot(var_2);
  }
}

cp_zmb_goon_spawner_patch_func(var_0) {
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (-357, -2605, 369), (-487, -2544, 369));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (2608, -498, 345), (2452, -560, 300));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (4578, 1, 235), (4560, 21, 172));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (4787, 538, 172), (4358, 345, 172));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (3891, 1766, 172), (3898, 2141, 116));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (2391, 1662, 60), (2391, 1662, 60));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (-2490, 1570, 284), (-2490, 1570, 284));
}

cp_zmb_interaction_struct_adjustment(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  foreach(var_3 in var_1) {
    var_3.origin = var_3.origin + anglesToForward(var_3.angles) * 2;
  }
}

cp_zmb_wait_to_be_revived_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if((scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) && scripts\engine\utility::istrue(level.the_hoff_revive)) {
    var_12 = wait_for_hoff_revive(var_0, var_7);
    if(scripts\engine\utility::istrue(var_12)) {
      scripts\cp\cp_laststand::clear_last_stand_timer(var_0);
      self notify("revive_success");
      return 1;
    }

    if(scripts\engine\utility::istrue(var_11)) {
      wait(5);
      scripts\cp\cp_laststand::clear_last_stand_timer(var_0);
      self notify("revive_success");
      return 1;
    }

    scripts\cp\cp_laststand::clear_last_stand_timer(var_0);
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    level waittill("forever");
    return 0;
  }

  return undefined;
}

wait_for_hoff_revive(var_0, var_1) {
  level endon("hoff_death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_2 = var_0.reviveent scripts\engine\utility::waittill_any_timeout(var_1, "trigger");
  if(var_2 != "trigger") {
    return undefined;
  }

  return 1;
}

cp_zmb_ghost_n_skull_setup() {
  level.gns_num_of_wave = 5;
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::init();
  level.ghost_n_skull_reactivate_func = scripts\cp\maps\cp_zmb\cp_zmb_ghost_activation::reactive_ghost_n_skull_cabinet;
  level.death_trigger_reset_y_pos = -3489;
  level.death_trigger_activate_y_pos = -2560;
  level.original_death_grid_lines_front_y_pos = -893;
  level.moving_target_pre_fly_time = 20;
  level.moving_target_activation_func = ::moving_targets_fly_to_portal_logic;
  level.set_moving_target_color_func = ::cp_zmb_set_moving_target_color;
  level.should_moving_target_explode = ::cp_zmb_should_moving_target_explode;
  level.zombie_ghost_model = "zombie_ghost_green";
  level.gns_reward_func = ::zmb_gns_player_reward_func;
  register_cp_zmb_ghost_formations();
  register_cp_zmb_target_waves_movement();
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_activation::init_ghost_n_skull_quest();
}

register_cp_zmb_ghost_formations() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1, 1);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1, 2);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1, 3);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 4);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 5);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 6);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 7);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 8);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 9);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(4, 10);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(4, 11);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(4, 12);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(5, 13);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(5, 14);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(5, 15);
}

register_cp_zmb_target_waves_movement() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(1, 2.3, 3.3, 0.6);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(2, 2, 3, 0.6);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(3, 1.7, 2.7, 0.6);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(4, 1.4, 2.4, 0.6);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(5, 1.1, 2.1, 0.6);
  level.available_formations = undefined;
  level.formation_movements = undefined;
}

moving_targets_fly_to_portal_logic(var_0) {
  level notify("moving_targets_fly_to_portal_logic");
  level endon("moving_targets_fly_to_portal_logic");
  level endon("game_ended");
  level endon("stop_moving_target_sequence");
  while(scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::active_moving_target_available()) {
    wait(3);
    var_1 = scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::get_active_moving_target_based_on_priority();
    if(!isDefined(var_1)) {
      return;
    }

    scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::activate_red_moving_target(var_1);
  }
}

cp_zmb_set_moving_target_color(var_0, var_1) {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::set_moving_target_color(var_0, "green");
}

cp_zmb_should_moving_target_explode(var_0, var_1) {
  return 1;
}

zmb_gns_player_reward_func() {
  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("ghost_end", "zmb_comment_vo", "highest", 3, 0, 0, 1);
    var_1 thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::give_gns_base_reward(var_1);
  }
}

setupinvalidvolumes() {
  level.invalidtranspondervolumes = [];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(1326, -764, -25), (1334, -509, -25), (394, -430, 40), (406, -811, 60)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(2358, 954, 280), (2360, 1521, 280), (2838, 1522, 400), (2821, 948, 339)];
}

vectors_are_in_box(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [var_0, var_1, var_2, var_3];
  if(!isDefined(var_4)) {
    if(isPlayer(self) || isagent(self)) {
      var_4 = self.origin;
    } else {
      return 0;
    }
  }

  for(var_6 = 0; var_6 < 2; var_6++) {
    foreach(var_8 in var_5) {
      var_9 = 0;
      foreach(var_11 in var_5) {
        if(var_8 == var_11) {
          continue;
        }

        if((var_4[var_6] > var_8[var_6] && var_4[var_6] < var_11[var_6]) || var_4[var_6] > var_11[var_6] && var_4[var_6] < var_8[var_6]) {
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

zmb_setup_direct_boss_fight_func() {
  level.guidedinteractionexclusion = ::directgreyfightguidedinteractionexclusions;
  level.should_run_event_func = ::directgreyfightshouldruneventfunc;
  level.boss_spawn_func = ::directgreyfightbossspawnfunc;
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::start_grey_fight_blocker_vfx();
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::disableportals();
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::move_grey_fight_clip_down();
  direct_boss_fight_zombie_spawning();
}

directgreyfightshouldruneventfunc(var_0) {
  return 0;
}

directgreyfightbossspawnfunc() {
  return 0;
}

direct_boss_fight_zombie_spawning() {
  var_0 = 28;
  level.zombies_paused = 1;
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::deactivateadjacentvolumes();
  level.wave_num = var_0;
  level.wave_num_override = var_0;
  level.current_enemy_deaths = 0;
  level.max_static_spawned_enemies = 24;
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    level.spawndelayoverride = 0.7;
  } else {
    level.spawndelayoverride = 0.35;
  }

  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::force_zombie_sprint();
}

directgreyfightguidedinteractionexclusions(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "debris_750") {
    return 0;
  }

  return 1;
}

zmb_start_direct_boss_fight_func() {
  level.getspawnpoint = ::respawn_in_grey_fight;
  disable_n3il_head_pickup();
  scripts\engine\utility::flag_init("ufo_intro_reach_center_portal");
  wait(1.3);
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::ufo_intro_fly_to_center_portal();
  level.desired_enemy_deaths_this_wave = 999999;
  scripts\engine\utility::flag_set("pause_wave_progression");
  level.no_clown_spawn = 1;
  level.zombies_paused = 0;
  scripts\cp\maps\cp_zmb\cp_zmb_ufo::start_grey_sequence();
  level thread direct_boss_wait_for_grey_fight_complete();
}

disable_n3il_head_pickup() {
  var_0 = scripts\engine\utility::getStructArray("interaction", "targetname");
  var_1 = [];
  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "neil_head") {
      var_1[var_1.size] = var_3;
    }
  }

  foreach(var_6 in var_1) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_6);
  }
}

direct_boss_wait_for_grey_fight_complete() {
  level endon("game_ended");
  level waittill("complete_alien_grey_fight");
  level thread scripts\cp\zombies\direct_boss_fight::success_sequence(6, 1);
}

respawn_in_grey_fight() {
  var_0 = [(918, 1411, 11), (768, 1414, 11), (501, 1390, 11), (358, 1416, 11)];
  var_1 = (652, 795, 115);
  var_2 = [];
  foreach(var_6, var_4 in var_0) {
    var_5 = spawnStruct();
    var_5.origin = var_4;
    var_5.angles = vectortoangles(var_1 - var_4);
    var_2[var_6] = var_5;
  }

  foreach(var_5 in var_2) {
    if(positionwouldtelefrag(var_5.origin)) {
      continue;
    }

    return var_5;
  }

  return var_2[0];
}