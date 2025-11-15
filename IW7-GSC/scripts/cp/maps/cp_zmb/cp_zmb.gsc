/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb.gsc
*********************************************/

main() {
  registerscriptedagents();
  setdvar("sm_sunSampleSizeNear", 0.6);
  setdvar("sm_spotDistCull", 6100);
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 4);
  setdvar("r_umbraAccurateOcclusionThreshold", 512);
  setdvar("sm_roundRobinPrioritySpotShadows", 8);
  setdvar("sm_spotUpdateLimit", 8);
  precache();
  setdvar("player_limitedMovementLeftStickInputScale", 0);
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
  level.magic_wheel_spin_hint = & "CP_ZMB_INTERACTIONS_SPIN_WHEEL";
  level.reboard_barriers_hint = & "CP_ZMB_INTERACTIONS_SECURE_WINDOW";
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
    var_00 = getEntArray("script_brushmodel", "classname");
    foreach(var_02 in var_00) {
      var_02 delete();
    }

    return;
  }

  level.custom_pillageinitfunc = ::cp_zmb_pillage_init;
  level.challenge_registration_func = ::scripts\cp\maps\cp_zmb\cp_zmb_challenges::register_default_challenges;
  level.challenge_scalar_func = ::scripts\cp\maps\cp_zmb\cp_zmb_challenges::challenge_scalar_func;
  level.custom_death_challenge_func = ::scripts\cp\maps\cp_zmb\cp_zmb_challenges::default_death_challenge_func;
  level.custom_playerdamage_challenge_func = ::scripts\cp\maps\cp_zmb\cp_zmb_challenges::default_playerdamage_challenge_func;
  level.scriptablestatefunc = ::scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate;
  level.should_continue_progress_bar_think = ::cp_zmb_should_continue_progress_bar_think;
  level.mutilation_mask_override_func = ::cp_zmb_mutilation_mask_func;
  level.should_allow_far_search_dist_func = ::cp_zmb_should_allow_far_search_dist_func;
  level.laststand_enter_levelspecificaction = ::zmb_last_stand_handler;
  level.map_interaction_func = ::scripts\cp\maps\cp_zmb\cp_zmb_interactions::register_interactions;
  level.wait_for_interaction_func = ::scripts\cp\maps\cp_zmb\cp_zmb_interactions::zmb_wait_for_interaction_triggered;
  level.player_interaction_monitor = ::scripts\cp\maps\cp_zmb\cp_zmb_interactions::zmb_player_interaction_monitor;
  level.introscreen_text_func = ::cp_zmb_introscreen_text;
  level.char_intro_music = ::play_char_intro_music;
  level.char_intro_gesture = ::play_char_intro_gesture;
  level.force_song_func = ::scripts\cp\zombies\zombie_jukebox::force_song;
  level.drop_max_ammo_func = ::scripts\cp\loot::drop_loot;
  level.post_nondeterministic_func = ::post_nondeterministic_func;
  level.update_player_tickets_func = ::scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned;
  level.write_global_clientmatchdata_func = ::cp_zmb_global_clientmatchdata_func;
  level.spawn_fx_func = ::cp_zmb_spawn_fx_func;
  level.near_equipment_func = ::cp_zmb_near_equipment_func;
  level.purchase_area_vo = ::scripts\cp\maps\cp_zmb\cp_zmb_vo::purchase_area_vo;
  level.team_buy_vos = ::scripts\cp\maps\cp_zmb\cp_zmb_vo::purchase_team_buy_vos;
  level.patch_update_spawners = ::cp_zmb_patch_update_spawners;
  level.enter_afterlife_clear_player_scriptable_func = ::cp_zmb_enter_afterlife_clear_player_scriptable_func;
  level.traversal_dismember_check = ::cp_zmb_traversal_dismember_check;
  level.is_in_box_func = ::vectors_are_in_box;
  level.additional_loadout_func = ::willard_loadout_func;
  level.wave_complete_dialogues_func = ::scripts\cp\zombies\zombies_spawning::wave_complete_dialogues;
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

willard_loadout_func(param_00) {
  if(isDefined(param_00.vo_prefix) && param_00.vo_prefix == "p6_") {
    if(scripts\engine\utility::istrue(param_00.got_willard_knife)) {
      return;
    }

    param_00 giveweapon("iw7_wylerdagger_zm");
    param_00 switchtoweaponimmediate("iw7_wylerdagger_zm");
    param_00.got_willard_knife = 1;
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
  var_00 = scripts\engine\utility::getstructarray("hidden_song_toy", "targetname");
  var_01 = scripts\engine\utility::array_randomize(var_00);
  var_02 = 5;
  for(var_03 = 0; var_03 < var_02; var_03++) {
    var_04 = var_01[var_03];
    var_05 = var_04.origin;
    var_06 = spawn("script_model", var_05);
    if(isDefined(var_04.angles)) {
      var_06.angles = var_04.angles;
    } else {
      var_06.angles = (0, 0, 0);
    }

    if(isDefined(var_04.script_noteworthy)) {
      var_07 = var_04.script_noteworthy;
    } else {
      var_07 = scripts\engine\utility::random(["toy_teddy_bear_01", "toy_teddy_bear_sitting_01"]);
    }

    var_06 setModel(var_07);
    var_06 thread waitfordamage(var_06);
    level.hidden_toys[level.hidden_toys.size] = var_06;
  }
}

init_hidden_song_2_quest() {
  level.pictures_found = 0;
  level.hidden_pictures = [];
  var_00 = getEntArray("hidden_song_toy", "targetname");
  var_00 = scripts\engine\utility::array_randomize(var_00);
  foreach(var_02 in var_00) {
    var_02 hide();
    var_02 setCanDamage(0);
  }

  var_04 = 3;
  for(var_05 = 0; var_05 < var_04; var_05++) {
    var_06 = var_00[var_05];
    var_07 = var_06;
    var_07.picture = 1;
    var_08 = getEntArray(var_07.target, "targetname");
    foreach(var_06 in var_08) {
      if(isDefined(var_06.script_noteworthy) && var_06.script_noteworthy == "blank_photo") {
        var_07.blank_photo = var_06;
      }

      var_06 hide();
    }

    var_07 show();
    var_07 thread picturewaitfordamage(var_07);
    level.hidden_pictures[level.hidden_pictures.size] = var_07;
    var_0B = 1;
  }
}

picturewaitfordamage(param_00) {
  param_00 endon("end_toy_watch_for_damage");
  param_00 setCanDamage(1);
  param_00.maxhealth = 100000;
  param_00.health = param_00.maxhealth;
  var_01 = spawnfx(level._effect["neil_repair_sparks"], param_00.origin);
  for(;;) {
    param_00 waittill("damage", var_02, var_03);
    if(isplayer(var_03)) {
      var_03 playlocalsound("song_quest_mw1_step_notify");
      triggerfx(var_01);
      param_00.health = 0;
      param_00 hide();
      param_00.blank_photo show();
      param_00 setCanDamage(0);
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
  var_01 delete();
}

waitfordamage(param_00) {
  param_00 endon("end_toy_watch_for_damage");
  param_00 setCanDamage(1);
  param_00.maxhealth = 100000;
  param_00.health = param_00.maxhealth;
  var_01 = spawnfx(level._effect["neil_repair_sparks"], param_00.origin);
  for(;;) {
    param_00 waittill("damage", var_02, var_03);
    if(isplayer(var_03)) {
      var_03 playlocalsound("song_quest_mw2_step_notify");
      triggerfx(var_01);
      param_00.health = 0;
      param_00 setModel("tag_origin");
      param_00 setCanDamage(0);
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
  var_01 delete();
}

play_hidden_song(param_00, param_01) {
  level endon("game_ended");
  if(param_01 == "mus_pa_mw2_80s_cover") {
    level endon("add_hidden_song_2_to_playlist");
  } else if(param_01 == "mus_pa_mw1_80s_cover") {
    level endon("add_hidden_song_to_playlist");
  }

  wait(2.5);
  foreach(var_03 in level.players) {
    if(scripts\engine\utility::istrue(level.onlinegame)) {
      var_03 setplayerdata("cp", "hasSongsUnlocked", "any_song", 1);
      if(param_01 == "mus_pa_mw2_80s_cover") {
        var_03 setplayerdata("cp", "hasSongsUnlocked", "song_1", 1);
        continue;
      }

      if(param_01 == "mus_pa_mw1_80s_cover") {
        var_03 setplayerdata("cp", "hasSongsUnlocked", "song_2", 1);
      }
    }
  }

  var_05 = undefined;
  if(isDefined(var_05)) {
    level thread scripts\cp\cp_vo::try_to_play_vo(var_05, "zmb_dj_vo", "high", 60, 1, 0, 1);
    var_06 = lookupsoundlength(var_05) / 1000;
    wait(var_06);
  }

  scripts\engine\utility::play_sound_in_space("zmb_jukebox_on", param_00);
  var_07 = spawn("script_origin", param_00);
  var_08 = "ee";
  var_09 = 1;
  foreach(var_03 in level.players) {
    var_03 scripts\cp\cp_persistence::give_player_xp(500, 1);
  }

  var_07 playLoopSound(param_01);
  var_07 thread earlyendon(var_07);
  var_0C = lookupsoundlength(param_01) / 1000;
  level scripts\engine\utility::waittill_any_timeout_1(var_0C, "skip_song");
  var_07 stoploopsound();
  var_07 delete();
  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start((649, 683, 254), 1);
}

earlyendon(param_00) {
  level endon("game_ended");
  level scripts\engine\utility::waittill_any_3("add_hidden_song_to_playlist", "add_hidden_song_2_to_playlist", "force_new_song");
  if(isDefined(param_00)) {
    param_00 stoploopsound();
    wait(2);
    param_00 delete();
  }
}

boat_area_kill_trigger() {
  var_00 = getent("player_kill_trig", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(!isplayer(var_01)) {
      continue;
    }

    var_02 = self;
    var_03 = self;
    var_04 = 100;
    var_05 = "MOD_TRIGGER_HURT";
    var_06 = undefined;
    var_07 = self.origin;
    var_08 = "none";
    var_09 = undefined;
    var_01 scripts\cp\cp_damage::onplayertouchkilltrigger(var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
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

setup_tutorial_requirements(param_00) {
  switch (param_00) {
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
  var_00 = ["arcade_back", "mars_3", "moon_bumpercars"];
  scripts\cp\zombies\interaction_magicwheel::set_magic_wheel_starting_location(scripts\engine\utility::random(var_00));
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
  if(getdvar("createfx") != "") {
    level thread free_ents_for_createfx();
  }
}

free_ents_for_createfx() {
  var_00 = getEntArray("trigger_multiple", "classname");
  foreach(var_02 in var_00) {
    var_02 delete();
  }

  var_04 = getEntArray("spawn_volume", "targetname");
  foreach(var_06 in var_04) {
    var_06 delete();
  }
}

remove_escape_entities() {
  var_00 = scripts\engine\utility::getstructarray("escape_exit", "script_noteworthy");
  if(isDefined(var_00)) {
    foreach(var_02 in var_00) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_02);
    }
  }

  var_04 = getent("escape_1_blocker_brush", "targetname");
  if(isDefined(var_04)) {
    var_04 delete();
  }

  var_05 = getEntArray("escape_door", "targetname");
  if(isDefined(var_05)) {
    foreach(var_07 in var_05) {
      var_07 delete();
    }
  }

  var_09 = getEntArray("escape_spawn_trigger", "targetname");
  if(isDefined(var_09)) {
    foreach(var_0B in var_09) {
      var_0B delete();
    }
  }

  var_0D = getEntArray("escape_exit_path", "targetname");
  if(isDefined(var_0D)) {
    foreach(var_0F in var_0D) {
      var_0F delete();
    }
  }
}

setup_slide() {
  var_00 = getent("slide_trig", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(scripts\engine\utility::istrue(var_01.onslide)) {
      continue;
    }

    if(isplayer(var_01)) {
      var_01.onslide = 1;
      var_01 thread player_down_slide(var_00);
    }
  }
}

player_down_slide(param_00) {
  self endon("disconnect");
  self.is_slide_sfx_playing = 0;
  self.is_slide_land_sfx_playing = 0;
  var_01 = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getstructarray("slide_start_spot", "targetname"));
  var_02 = scripts\engine\utility::getstruct(var_01.target, "targetname");
  if(distance2dsquared(self.origin, var_01.origin) > 65536) {
    while(self istouching(param_00)) {
      self setvelocity(vectornormalize(var_02.origin - self.origin) * 200);
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
  while(self istouching(param_00)) {
    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      thread last_stand_player_down_slide(var_02);
      return;
    }

    self.ability_invulnerable = 1;
    self.disable_consumables = 1;
    if(self.is_slide_sfx_playing == 0) {
      self playlocalsound("trap_hyperslide_plr_slide");
      self.is_slide_sfx_playing = 1;
    }

    self setvelocity(vectornormalize(var_02.origin - self.origin) * 500);
    wait(0.05);
  }

  self.ability_invulnerable = undefined;
  self notify("offslide");
  var_03 = self playanimscriptevent("power_active_cp", "gesture014");
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
  var_00 = 0;
  while(scripts\engine\utility::istrue(self.onslide)) {
    if(self isgestureplaying()) {
      wait(0.1);
      continue;
    }

    if(!var_00) {
      self playanimscriptevent("power_active_cp", "gesture012");
      wait(0.1);
      var_00 = 1;
    }

    self playanimscriptevent("power_active_cp", "gesture013");
    self playgestureviewmodel("ges_slide", undefined, 0);
    wait(0.1);
  }
}

last_stand_player_down_slide(param_00) {
  self endon("disconnect");
  self notify("stopslideanim");
  if(scripts\cp\cp_laststand::self_revive_activated()) {
    reset_slide_variables();
    self setorigin(param_00.origin);
    return;
  }

  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\utility::has_zombie_perk("perk_machine_revive")) {
    reset_slide_variables();
    self setorigin(param_00.origin);
    return;
  }

  self setorigin(param_00.origin);
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

cp_zmb_respawn_loc_func(param_00) {
  if(scripts\engine\utility::flag("first_door_opened")) {
    var_01 = level.fast_travel_spots[level.end_portal_name].end_positions;
    foreach(var_03 in var_01) {
      if(!canspawn(var_03.origin)) {
        continue;
      }

      if(positionwouldtelefrag(var_03.origin)) {
        continue;
      }

      return var_03;
    }
  }

  foreach(var_06 in level.active_player_respawn_locs) {
    if(!canspawn(var_06.origin)) {
      continue;
    }

    if(positionwouldtelefrag(var_06.origin)) {
      continue;
    }

    return var_06;
  }

  var_08 = scripts\cp\gametypes\zombie::get_available_players(param_00);
  return scripts\cp\gametypes\zombie::get_respawn_loc_near_team_center(param_00, var_08);
}

gator_mouth() {
  wait(5);
  var_00 = getent("gator_mouth", "targetname");
  var_01 = getent("gator_mouth_trig", "targetname");
  level.gator_mouth_trig = getent("gator_mouth_trig", "targetname");
  var_00.twitching = 0;
  var_02 = getent("croc_mouth_clip", "targetname");
  var_02 connectpaths();
  var_02 notsolid();
  level.gator_light = getent("gator_mouth_light", "targetname");
  level.gator_light setlightintensity(0);
  var_00 setModel("zmb_croc_chomp_head_toothless");
  var_00.origin = var_00.origin + (0, 0, -10);
  for(;;) {
    var_03 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", "mars power_on", "power_off");
    if(var_03 != "power_off") {
      level thread activate_gator_mouth(var_02, var_00, var_01, var_00.origin);
    }
  }
}

activate_gator_mouth(param_00, param_01, param_02, param_03) {
  level endon("deactivate_gator_mouth");
  level endon("game_ended");
  param_01 setModel("zmb_croc_chomp_head_toothless_on");
  wait(0.05);
  level.gator_light setlightintensity(4);
  param_02.lastmultikilltime = gettime();
  param_02.lastkilltime = gettime();
  for(;;) {
    wait(1);
    if(!param_01.twitching) {
      param_01.twitching = 1;
      level thread gator_mouth_twitch(param_00, param_01, param_02, param_03);
      level thread gator_mouth_crush(param_00, param_02, param_01, param_03);
    }
  }
}

bumper_cars() {
  scripts\cp\maps\cp_zmb\cp_zmb_bumpercars::init_bumper_cars();
}

gator_mouth_twitch(param_00, param_01, param_02, param_03) {
  param_02 endon("stop_twitch");
  playsoundatpos((-1696, 1201, 550), "croc_trap_idle_mechanics");
  param_01 moveto(param_01.origin + (0, 0, -5), 0.5, 0.4, 0.1);
  param_01 waittill("movedone");
  param_01 moveto(param_01.origin + (0, 0, 5), 0.5, 0.4, 0.1);
  param_01 waittill("movedone");
  param_01 moveto(param_01.origin + (0, 0, -5), 0.5, 0.4, 0.1);
  param_01 waittill("movedone");
  param_01 moveto(param_01.origin + (0, 0, 5), 0.5, 0.4, 0.1);
  param_01 waittill("movedone");
  param_01 moveto(param_01.origin + (0, 0, -5), 0.5, 0.4, 0.1);
  param_01 waittill("movedone");
  param_01 moveto(param_01.origin + (0, 0, 5), 0.5, 0.4, 0.1);
  param_01 waittill("movedone");
  wait(1);
  param_01.twitching = 0;
}

gator_mouth_crush(param_00, param_01, param_02, param_03) {
  level notify("stop_gator_mouth_crush");
  level endon("stop_gator_mouth_crush");
  level endon("deactivate_gator_mouth");
  for(;;) {
    param_01 waittill("trigger", var_04);
    if(isplayer(var_04) && var_04 scripts\cp\utility::is_valid_player()) {
      param_01 notify("stop_twitch");
      param_01 playSound("croc_trap_bite_tick_tock");
      param_01 playSound("croc_trap_trigger_switch");
      wait(3);
      var_05 = 1;
      var_06 = undefined;
      var_07 = undefined;
      foreach(var_09 in level.spawned_enemies) {
        if(isDefined(var_09.agent_type) && var_09.agent_type == "zombie_brute") {
          if(var_09 istouching(param_01)) {
            var_05 = 0;
            var_06 = var_09;
          }
        }
      }

      if(isDefined(level.the_hoff)) {
        if(level.the_hoff istouching(param_01)) {
          var_05 = 0;
          var_07 = 1;
        }
      }

      if(var_05) {
        param_02 moveto(param_03 + (0, 0, -100), 0.15);
        param_01 playSound("croc_trap_bite");
        earthquake(0.45, 3, param_01.origin, 750);
        param_01 thread mouth_trig_kill(var_04);
        wait(0.15);
        scripts\engine\utility::exploder(255);
        param_00 disconnectpaths();
        param_00 solid();
        param_01 notify("stop_killing");
        param_02 setModel("zmb_croc_chomp_head_toothless");
        level.gator_light setlightintensity(0);
        wait(1);
        param_00 connectpaths();
        param_00 notsolid();
        param_02 moveto(param_03, 1);
        wait(5);
        param_02.twitching = 0;
        level.gator_light setlightintensity(4);
        param_02 setModel("zmb_croc_chomp_head_toothless_on");
      } else if(isDefined(var_07)) {
        param_02 moveto(param_03 + (0, 0, -40), 0.1);
        param_01 playSound("trap_laser_activate");
        earthquake(0.45, 3, param_01.origin, 450);
        wait(1.5);
        param_02 moveto(param_03, 0.25);
        wait(1);
        param_02.twitching = 0;
      } else {
        if(isDefined(var_06)) {
          var_06.croc_chomp = 1;
          var_06.allowpain = 1;
          var_06 dodamage(1, var_06.origin, var_04, var_04);
          wait(0.1);
          var_06.croc_chomp = 0;
          var_06.allowpain = 0;
          wait(0.7);
          level thread break_gator_teeth(0.1);
        }

        param_02 moveto(param_03 + (0, 0, -40), 0.1);
        param_01 playSound("trap_laser_activate");
        earthquake(0.45, 3, param_01.origin, 450);
        wait(1.5);
        scripts\engine\utility::flag_set("gator_tooth_broken");
        param_02 moveto(param_03, 0.25);
        wait(1);
        param_02.twitching = 0;
      }

      return;
    }
  }
}

mouth_trig_kill(param_00) {
  self endon("stop_killing");
  var_01 = gettime() + 250;
  while(gettime() < var_01) {
    self waittill("trigger", var_02);
    if(isplayer(var_02) && scripts\cp\cp_laststand::player_in_laststand(var_02)) {
      continue;
    }

    var_02.nocorpse = 1;
    var_02.full_gib = 1;
    var_02.deathmethod = "croc";
    if(scripts\engine\utility::istrue(var_02.isrewinding)) {
      continue;
    }

    var_02 dodamage(var_02.health + 100, var_02.origin, self, self, "MOD_UNKNOWN");
    if(isDefined(param_00)) {
      if(!isDefined(param_00.trapkills["trap_gator"])) {
        param_00.trapkills["trap_gator"] = 1;
      } else {
        param_00.trapkills["trap_gator"]++;
      }

      var_03 = ["kill_trap_generic", "kill_trap_gator"];
      param_00 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_03), "zmb_comment_vo", "high", 10, 0, 0, 1, 25);
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

cp_zmb_onplayerconnect(param_00) {
  param_00.num_tickets = 0;
  param_00 scripts\cp\zombies\zombies_wor::wor_init();
  if(param_00 scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    param_00 setclientomnvar("zombie_afterlife_self_revive_count", 3);
  } else {
    param_00 setclientomnvar("zombie_afterlife_self_revive_count", 1);
  }

  param_00 thread update_team_door_buy_on_spawn();
  param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::update_player_revives_every_ten_waves(param_00);
  if(!isDefined(level.kick_player_queue)) {
    level thread kick_player_queue_loop();
  }

  param_00 thread kick_for_inactivity(param_00);
}

kick_for_inactivity(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 thread check_for_move_change();
  param_00 thread check_for_movement();
  param_00.input_has_happened = 0;
  var_01 = gettime();
  var_02 = level.onlinegame && !getdvarint("xblive_privatematch");
  if(var_02) {
    param_00 notifyonplayercommand("inputReceived", "+speed_throw");
    param_00 notifyonplayercommand("inputReceived", "+stance");
    param_00 notifyonplayercommand("inputReceived", "+goStand");
    param_00 notifyonplayercommand("inputReceived", "+usereload");
    param_00 notifyonplayercommand("inputReceived", "+activate");
    param_00 notifyonplayercommand("inputReceived", "+melee_zoom");
    param_00 notifyonplayercommand("inputReceived", "+breath_sprint");
    param_00 notifyonplayercommand("inputReceived", "+attack");
    param_00 notifyonplayercommand("inputReceived", "+frag");
    param_00 notifyonplayercommand("inputReceived", "+smoke");
    var_03 = 120;
    var_04 = 0.1;
    for(;;) {
      if(isDefined(level.wave_num) && level.wave_num > 5) {
        break;
      }

      var_05 = scripts\engine\utility::waittill_any_timeout_no_endon_death_2(var_04, "inputReceived", "currency_earned");
      if(gettime() - var_01 < 30000) {
        continue;
      }

      if(var_05 != "timeout") {
        var_03 = 120;
        param_00.input_has_happened = 1;
        continue;
      }

      if(!scripts\engine\utility::istrue(param_00.in_afterlife_arcade) && !scripts\engine\utility::istrue(param_00.inlaststand)) {
        var_03 = var_03 - var_04;
      }

      if(var_03 < 0) {
        if(level.players.size > 1) {
          if(param_00.input_has_happened) {
            param_00.input_has_happened = 0;
            continue;
          }

          add_to_kick_queue(param_00);
          break;
        }
      }
    }
  }
}

check_for_movement() {
  level endon("game_ended");
  self endon("disconnect");
  var_00 = level.onlinegame && !getdvarint("xblive_privatematch");
  if(var_00) {
    var_01 = self getnormalizedmovement();
    var_02 = gettime();
    for(;;) {
      wait(0.2);
      var_03 = self getnormalizedmovement();
      if(var_03[0] == var_01[0] && var_03[1] == var_01[1]) {
        if(gettime() - var_02 > 90000 && level.players.size > 1) {
          add_to_kick_queue(self);
        }

        continue;
      }

      return;
    }
  }
}

add_to_kick_queue(param_00) {
  if(!scripts\engine\utility::exist_in_array_MAYBE(level.kick_player_queue, param_00)) {
    level.kick_player_queue = scripts\engine\utility::array_add_safe(level.kick_player_queue, param_00);
  }
}

kick_player_queue_loop() {
  level.kick_player_queue = [];
  for(;;) {
    if(level.kick_player_queue.size > 0) {
      foreach(var_01 in level.kick_player_queue) {
        if(!isDefined(var_01)) {
          continue;
        }

        if(!var_01 ishost()) {
          kick(var_01 getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
        }
      }

      if(level.kick_player_queue.size > 0) {
        foreach(var_01 in level.kick_player_queue) {
          if(!isDefined(var_01)) {
            continue;
          }

          kick(var_01 getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
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

  var_00 = 1;
  var_01 = var_00;
  var_02 = var_00;
  for(;;) {
    var_03 = self getnormalizedmovement();
    var_01 = get_move_direction_from_vectors(var_03);
    if(var_02 != var_01) {
      var_02 = var_01;
      self notify("inputReceived");
    }

    wait(0.1);
  }
}

get_move_direction_from_vectors(param_00) {
  var_01 = 1;
  var_02 = 2;
  var_03 = 3;
  var_04 = 4;
  var_05 = 5;
  var_06 = 6;
  var_07 = 7;
  var_08 = 8;
  var_09 = var_01;
  if(param_00[0] > 0) {
    if(param_00[1] <= 0.7 && param_00[1] >= -0.7) {
      var_09 = var_01;
    }

    if(param_00[0] > 0.5 && param_00[1] > 0.7) {
      var_09 = var_02;
    } else if(param_00[0] > 0.5 && param_00[1] < -0.7) {
      var_09 = var_03;
    }
  } else if(param_00[0] < 0) {
    if(param_00[1] < 0.4 && param_00[1] > -0.4) {
      var_09 = var_04;
    }

    if(param_00[0] < -0.5 && param_00[1] > 0.5) {
      var_09 = var_05;
    } else if(param_00[0] < -0.5 && param_00[1] < -0.5) {
      var_09 = var_06;
    }
  } else if(param_00[1] > 0.4) {
    var_09 = var_07;
  } else if(param_00[1] < -0.4) {
    var_09 = var_08;
  }

  return var_09;
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

  var_00 = scripts\engine\utility::getstructarray("team_door_switch", "script_noteworthy");
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  foreach(var_05 in var_00) {
    if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_05)) {
      continue;
    }

    if(var_05.script_side == "moon") {
      if(var_02) {
        continue;
      }

      level.moon_donations--;
      var_02 = 1;
    }

    if(var_05.script_side == "triton") {
      if(var_03) {
        continue;
      }

      level.triton_donations--;
      var_03 = 1;
    }

    if(var_05.script_side == "kepler") {
      if(var_01) {
        continue;
      }

      level.kepler_donations--;
      var_01 = 1;
    }

    var_06 = getEntArray(var_05.target, "targetname");
    foreach(var_08 in var_06) {
      if(!isDefined(var_08.script_noteworthy)) {
        continue;
      } else {
        if(scripts\engine\utility::string_starts_with(var_08.classname, "scriptable")) {
          var_08 setscriptablepartstate("fx", "adjust");
          continue;
        }

        if(var_08.script_noteworthy == "progress") {
          var_08 movez(-4, 0.05);
          var_08 waittill("movedone");
          break;
        }
      }
    }
  }

  level.team_door_adjusted_for = level.players.size;
}

cp_zmb_should_continue_progress_bar_think(param_00) {
  if(scripts\engine\utility::istrue(param_00.in_afterlife_arcade)) {
    return 1;
  }

  return !scripts\cp\cp_laststand::player_in_laststand(param_00);
}

boat_ride() {
  for(;;) {
    var_00 = getvehiclenode("boat_ride_start", "targetname");
    var_01 = spawnvehicle("park_boat_ride_boat", "boat", "cp_kevin", var_00.origin, var_00.angles);
    var_01 attachpath(var_00);
    var_01 startpath(var_00);
    if(!isDefined(level.shredder_battery)) {
      var_01 thread shredder_battery_spawn();
    }

    var_01 waittill("reached_end_node");
    var_01 delete();
  }
}

shredder_battery_spawn() {
  if(scripts\cp\utility::is_codxp()) {
    return;
  }

  self endon("reached_end_node");
  var_00 = spawn("script_model", self.origin);
  while(!isDefined(var_00)) {
    scripts\engine\utility::waitframe();
  }

  thread delete_battery_at_end_node(var_00);
  var_00 setModel("alien_crafting_battery_single_01");
  self setCanDamage(1);
  var_00 linkto(self, "tag", (-80, 0, 15), (0, 0, 0));
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(isDefined(var_02) && isplayer(var_02)) {
      if(distancesquared(var_00.origin, var_04) < 400) {
        var_00 thread knock_off_battery(self);
        break;
      }
    }
  }

  if(isDefined(var_00)) {
    var_00 delete();
  }
}

delete_battery_at_end_node(param_00) {
  level endon("ww_iw7_shredder_zm_battery_dropped");
  scripts\engine\utility::waitframe();
  self waittill("reached_end_node");
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

knock_off_battery(param_00) {
  level.shredder_battery = 1;
  self unlink();
  var_01 = param_00 vehicle_getvelocity();
  var_01 = var_01 * -1;
  var_01 = var_01 + (0, 0, 10);
  level.battery_in_geyser = 1;
  self delete();
  level notify("ww_iw7_shredder_zm_battery_dropped", (0, 0, -10000));
}

geysers_and_boatride() {
  level waittill("swamp_stage power_on");
  level thread boat_ride();
  var_00 = scripts\engine\utility::getstructarray("geyser", "targetname");
  foreach(var_02 in var_00) {
    thread scripts\engine\utility::play_loopsound_in_space("trap_geyser_idle_lp", var_02.origin);
    playFX(level._effect["geyser_splash_lg"], var_02.origin);
    var_02 thread geyser_erupt();
  }

  level thread geyser_sequence();
}

setup_ufo() {
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::init_ufo_quest();
}

geyser_sequence() {
  var_00 = ["a", "e", "f"];
  var_01 = ["c", "a", "e"];
  var_02 = ["a", "b", "c", "e", "f"];
  var_03 = [var_00, var_01, var_02];
  for(;;) {
    wait(2);
    foreach(var_05 in var_03) {
      foreach(var_07 in var_05) {
        var_08 = get_geyser(var_07);
        var_08 notify("erupt");
        wait(1);
      }

      wait(2);
    }
  }
}

get_geyser(param_00) {
  var_01 = scripts\engine\utility::getstructarray("geyser", "targetname");
  foreach(var_03 in var_01) {
    if(var_03.script_noteworthy == param_00) {
      return var_03;
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

launch_battery_from_geyser(param_00) {
  level endon("end_battery_launch_func");
  level.battery_launched = 1;
  var_01 = param_00.origin;
  var_02 = level.shredder_battery;
  var_02.origin = param_00.origin;
  var_02 moveto(var_01 + (0, 0, 60), 0.25);
  var_02 waittill("movedone");
  var_02 makeusable();
  var_02 sethintstring( & "CP_QUEST_WOR_PART");
  var_02 thread pick_up_battery();
  for(var_03 = 0; var_03 < 8; var_03++) {
    var_02 rotateto(var_02.angles + (90, 0, 0), 0.2);
    wait(0.2);
  }

  var_02 makeunusable();
  var_02 moveto(var_01 + (0, 0, -10), 0.5);
  var_02 waittill("movedone");
  level.battery_launched = undefined;
}

pick_up_battery() {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_00);
    if(isplayer(var_00)) {
      break;
    }
  }

  level notify("end_battery_launch_func");
}

launch_players(param_00) {
  var_01 = param_00.origin;
  var_02 = (0, 0, 650);
  var_03 = undefined;
  for(var_04 = 0; var_04 < 40; var_04++) {
    foreach(var_06 in level.players) {
      if(scripts\engine\utility::istrue(var_06.isrewinding)) {
        continue;
      }

      if(distancesquared(var_06.origin, var_01) > 576 || isDefined(var_06.flung)) {
        continue;
      }

      var_06 notify("cancel_sentry");
      var_06 notify("cancel_medusa");
      var_06 notify("cancel_trap");
      var_06 notify("cancel_boombox");
      var_06 notify("cancel_revocator");
      var_06 notify("cancel_ims");
      var_06 notify("cancel_gascan");
      if(param_00.script_noteworthy == "a") {
        var_02 = vectornormalize((-2549.5, -163.5, 353.8) - param_00.origin) * 500 + (0, 0, 920);
        var_03 = (-2549.5, -163.5, 353.8);
        var_06 thread launch_player_to_kepler(var_03, param_00);
        wait(0.25);
        continue;
      }

      var_06 thread launch_player(param_00, var_02, var_03);
    }

    wait(0.05);
  }
}

launch_player_to_kepler(param_00, param_01) {
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
  var_02 = scripts\engine\utility::getstructarray(param_01.target, "targetname");
  var_03 = scripts\engine\utility::random(var_02);
  thread handle_host_migration_during_launch();
  thread watch_player_landing(param_01, param_00);
  var_04 = vectortoangles((-2613.5, -131.5, 353.8) - param_01.origin);
  self setplayerangles(var_04);
  for(;;) {
    var_05 = distance(self.anchor.origin, var_03.origin);
    var_06 = 850;
    var_07 = var_05 / var_06;
    if(var_07 < 0.05) {
      var_07 = 0.05;
    }

    self.anchor moveto(var_03.origin, var_07);
    wait(var_07 + 0.05);
    if(!isDefined(var_03.target)) {
      break;
    }

    var_02 = scripts\engine\utility::getstructarray(var_03.target, "targetname");
    var_03 = scripts\engine\utility::random(var_02);
  }

  self setorigin(self.anchor.origin);
  self unlink();
  self.anchor delete();
  self setvelocity((0, 0, 0));
  var_08 = vectornormalize((-2613.5, -131.5, 353.8) - self.origin) * 500 + (0, 0, 650);
  self setvelocity(var_08);
}

launch_player(param_00, param_01, param_02) {
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
  if(param_00.script_noteworthy == "a") {
    self setplayerangles((-2549.5, -163.5, 0));
  }

  self setvelocity(param_01);
  playfxontagforclients(level._effect["geyser_fullscreen_fx"], self, "tag_eye", self);
  thread watch_player_landing(param_00, param_02);
}

unset_player_flung(param_00) {
  self endon("disconnect");
  wait(param_00);
  self.flung = undefined;
}

watch_player_landing(param_00, param_01, param_02) {
  level endon("host_migration_end");
  self endon("disconnect");
  if(isDefined(param_02)) {
    wait(param_02);
  }

  var_03 = 2304;
  if(isDefined(param_01)) {
    var_04 = vectortoangles((-2549.5, -163.5, -200) - param_00.origin);
    self setplayerangles(var_04);
    self shellshock("zm_geyser_launch", 2);
  } else {
    self shellshock("zm_geyser_launch", 0.5);
  }

  wait(0.5);
  var_05 = 1;
  var_06 = gettime();
  while(!self isonground()) {
    if(scripts\engine\utility::istrue(self.isrewinding)) {
      var_05 = 0;
    }

    var_07 = scripts\cp\cp_agent_utils::get_alive_enemies();
    foreach(var_09 in var_07) {
      if(isDefined(var_09.agent_type) && var_09.agent_type == "zombie_brute" || var_09.agent_type == "zombie_ghost" || var_09.agent_type == "zombie_grey") {
        continue;
      }

      if(distancesquared(self.origin, var_09.origin) < var_03) {
        var_09 dodamage(var_09.health, var_09.origin, self, self, "MOD_CRUSH");
      }
    }

    wait(0.05);
    foreach(var_0C in level.players) {
      if(scripts\engine\utility::istrue(self.flung)) {
        continue;
      }

      if(var_0C == self) {
        continue;
      }

      if(!var_0C isonground()) {
        continue;
      }

      if(isDefined(var_0C.anchor)) {
        continue;
      }

      if(self istouching(var_0C)) {
        var_0C setvelocity(vectornormalize(var_0C.origin - self.origin) * 800 + (0, 0, 50));
      }
    }

    wait(0.05);
  }

  var_0E = gettime();
  if(isDefined(self.abh_used) && self.abh_used > var_06 && self.abh_used < var_0E) {
    var_05 = 0;
  }

  if(var_05) {
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
  var_00 = (-2617, -123, 469);
  var_01 = 0;
  if(!isDefined(level.kepler_landing_orgs)) {
    level.kepler_landing_orgs = [(-2617, -123, 469), (-2577, -123, 469), (-2657, -123, 469), (-2617, -83, 469), (-2617, -163, 469)];
    level.kepler_org_index = [0, 0, 0, 0, 0];
  }

  for(var_02 = 0; var_02 < level.kepler_org_index.size; var_02++) {
    if(level.kepler_org_index[var_02] == 0) {
      var_00 = level.kepler_landing_orgs[var_02];
      var_01 = var_02;
      level.kepler_org_index[var_02] = 1;
      break;
    }
  }

  self setorigin(var_00, 1);
  var_03 = 2304;
  var_04 = 1;
  var_05 = gettime();
  while(!self isonground()) {
    if(scripts\engine\utility::istrue(self.isrewinding)) {
      var_04 = 0;
    }

    var_06 = scripts\cp\cp_agent_utils::get_alive_enemies();
    foreach(var_08 in var_06) {
      if(isDefined(var_08.agent_type) && var_08.agent_type == "zombie_brute" || var_08.agent_type == "zombie_ghost" || var_08.agent_type == "zombie_grey") {
        continue;
      }

      if(distancesquared(self.origin, var_08.origin) < var_03) {
        var_08 dodamage(var_08.health, var_08.origin, self, self, "MOD_CRUSH");
      }
    }

    wait(0.05);
    foreach(var_0B in level.players) {
      if(var_0B == self) {
        continue;
      }

      if(self istouching(var_0B)) {
        var_0B setvelocity(vectornormalize(var_0B.origin - self.origin) * 800 + (0, 0, 50));
      }
    }

    wait(0.05);
  }

  var_0D = gettime();
  if(isDefined(self.abh_used) && self.abh_used > var_05 && self.abh_used < var_0D) {
    var_04 = 0;
  }

  if(var_04) {
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
  level.kepler_org_index[var_01] = 0;
  self notify("player_landed");
}

notify_after_time(param_00, param_01) {
  wait(param_01);
  level notify(param_00);
}

launch_zombies(param_00) {
  for(var_01 = 0; var_01 < 20; var_01++) {
    foreach(var_03 in level.spawned_enemies) {
      if(isDefined(var_03.flung) || isDefined(var_03.agent_type) && var_03.agent_type == "zombie_brute" || var_03.agent_type == "zombie_ghost" || var_03.agent_type == "zombie_grey") {
        continue;
      }

      if(distancesquared(var_03.origin, param_00) < 576) {
        var_03 thread zombie_geyser_fling(param_00);
      }
    }

    wait(0.1);
  }
}

zombie_geyser_fling(param_00) {
  self.flung = 1;
  self.do_immediate_ragdoll = 1;
  self.disable_armor = 1;
  self setsolid(0);
  self setvelocity((0, 0, 1050));
  wait(0.1);
  self dodamage(1000000, param_00, undefined, undefined, "MOD_UNKNOWN");
}

cp_zmb_mutilation_mask_func(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = undefined;
  var_07 = zombies_should_mutilate(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
  return var_07;
}

zombies_should_mutilate(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_07 = getweaponbasename(param_01);
  var_08 = param_03 >= 1;
  if(isDefined(param_02)) {
    switch (param_02) {
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_EXPLOSIVE":
        if(is_mutilate_explosion(param_01)) {
          if(var_08 && isDefined(param_06) && distance2dsquared(self.origin, param_06.origin) < 1600) {
            return 31;
          } else {
            return 12;
          }
        } else {
          return 0;
        }
        break;

      case "MOD_MELEE":
        if(!var_08 && isDefined(var_07) && var_07 == "iw7_axe_zm" || var_07 == "iw7_axe_zm_pap1" || var_07 == "iw7_axe_zm_pap2") {
          return param_00;
        } else {
          return 0;
        }

        break;

      case "MOD_UNKNOWN":
        if(isDefined(param_04) && isDefined(param_04.agent_type) && param_04.agent_type == "c6") {
          return 31;
        }

        break;

      default:
        break;
    }
  }

  if(isDefined(param_01)) {
    var_09 = weaponclass(param_01);
    var_07 = getweaponbasename(param_01);
    if(isDefined(var_09) && var_09 == "spread" && param_02 != "mod_melee") {
      if(isDefined(var_07) && var_07 == "iw7_nrg_zm" || var_07 == "iw7_forgefreeze_zm") {
        return 0;
      }

      if(var_08 && isDefined(param_06) && distance2dsquared(self.origin, param_06.origin) < 10000) {
        return 31;
      } else {
        return param_00;
      }
    }

    if(isDefined(var_07)) {
      switch (var_07) {
        case "iw7_chargeshot_zm":
          if(var_08 && isDefined(param_02) && param_02 == "MOD_PROJECTILE") {
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
          return param_00;

        case "iw7_shredder_zm_pap1":
        case "iw7_shredder_zm":
          if(var_08 && !is_arm_or_head_damage(param_00)) {
            return 31;
          }
          return param_00;

        default:
          if(is_arm_or_head_damage(param_00)) {
            return param_00;
          }

          break;
      }
    }
  }

  return 0;
}

is_arm_or_head_damage(param_00) {
  switch (param_00) {
    case 16:
    case 2:
    case 1:
      return 1;

    default:
      break;
  }

  return 0;
}

is_mutilate_explosion(param_00) {
  if(isDefined(param_00)) {
    var_01 = getweaponbasename(param_00);
    if(isDefined(var_01)) {
      switch (var_01) {
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
  var_00 = getEntArray("broken_gator_tooth_1", "targetname");
  level.gator_teeth_array = scripts\engine\utility::array_combine(level.gator_teeth_array, var_00);
  var_01 = getEntArray("broken_gator_tooth_2", "targetname");
  level.gator_teeth_array = scripts\engine\utility::array_combine(level.gator_teeth_array, var_01);
  var_02 = getEntArray("broken_gator_tooth_3", "targetname");
  level.gator_teeth_array = scripts\engine\utility::array_combine(level.gator_teeth_array, var_02);
  level.gold_tooth_3_pickup = getEntArray("broken_gator_gold_tooth_3_pickup", "targetname");
  level.gator_mouth_door = getent("gator_mouth_door", "targetname");
  var_03 = getent("croc_mouth_door", "targetname");
  if(isDefined(var_03)) {
    level.gator_mouth_door delete();
    level.gator_mouth_door = getent("croc_mouth_door", "targetname");
  }

  var_04 = getent("gator_mouth", "targetname");
  level.gator_mouth_light = getent("gator_mouth_room_light", "targetname");
  level.gator_mouth_light setlightintensity(0);
  level.gator_tooth_use_trig = spawn("script_origin", level.gator_teeth_array[0].origin + (0, 0, -75));
  foreach(var_06 in level.gator_teeth_array) {
    var_06 linkto(var_04);
  }

  level thread gator_tooth_broken();
  if(scripts\cp\utility::is_codxp()) {
    var_08 = scripts\engine\utility::getstruct("gold_teeth", "script_noteworthy");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_08);
  }
}

gator_tooth_broken() {
  scripts\engine\utility::flag_wait("gator_tooth_broken");
  scripts\engine\utility::flag_wait("gator_gold_tooth_placed");
  level.gator_mouth_door unlink();
  level.gator_mouth_door playSound("croc_trap_door_open");
  level.gator_mouth_door moveto(level.gator_mouth_door.origin + (0, 0, -200), 2);
  var_00 = scripts\engine\utility::getstructarray("gator_door_dust", "targetname");
  if(var_00.size > 0) {
    var_00 = scripts\engine\utility::array_randomize(var_00);
    foreach(var_02 in var_00) {
      playFX(level._effect["vfx_gator_door_dust"], var_02.origin);
      wait(randomfloatrange(0.2, 0.5));
    }
  }

  var_04 = level.gator_mouth_light;
  if(isDefined(var_04)) {
    for(var_05 = 0; var_05 < 4; var_05++) {
      var_04 setlightintensity(2);
      wait(randomfloatrange(0.5, 1));
      var_04 setlightintensity(0);
      wait(randomfloatrange(0.5, 1));
    }

    var_04 setlightintensity(5);
  }
}

break_gator_teeth(param_00) {
  level endon("game_ended");
  if(isDefined(param_00)) {
    wait(param_00);
  }

  playsoundatpos((-1616, 1502, 360), "zmb_croc_trap_teeth_shatter_01");
  playsoundatpos((-1897, 1508, 360), "zmb_croc_trap_teeth_shatter_02");
  foreach(var_02 in level.gator_teeth_array) {
    var_02 hide();
    playFX(level._effect["gator_tooth_break"], var_02.origin);
    scripts\engine\utility::waitframe();
  }
}

gold_teeth_pickup_debug() {
  level waittill("gold_tooth_pickup_trigger");
  var_00 = scripts\engine\utility::getstruct("gold_teeth", "script_noteworthy");
  var_01 = level.players[0];
  gold_teeth_pickup(var_00, var_01);
}

gold_teeth_pickup(param_00, param_01) {
  foreach(var_03 in level.gold_tooth_3_pickup) {
    var_03 delete();
  }

  param_01 playlocalsound("purchase_ticket");
  scripts\engine\utility::flag_set("gator_gold_tooth_pickup");
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_teeth", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  level scripts\cp\utility::set_quest_icon(6);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
}

gold_teeth_hint_func(param_00, param_01) {
  if(!isDefined(param_01.ticket_item_outlined)) {
    param_01.ticket_item_outlined = level.gold_tooth_3_pickup[0];
    if(self.num_tickets >= level.interactions[param_00.script_noteworthy].cost) {
      param_01.ticket_item_outlined hudoutlineenableforclient(param_01, 3, 1, 0);
    } else {
      param_01.ticket_item_outlined hudoutlineenableforclient(param_01, 1, 1, 0);
    }
  } else if(param_01.ticket_item_outlined != level.gold_tooth_3_pickup[0]) {
    param_01.ticket_item_outlined hudoutlinedisableforclient(param_01);
    param_01.ticket_item_outlined = level.gold_tooth_3_pickup[0];
    if(self.num_tickets >= level.interactions[param_00.script_noteworthy].cost) {
      param_01.ticket_item_outlined hudoutlineenableforclient(param_01, 3, 1, 0);
    } else {
      param_01.ticket_item_outlined hudoutlineenableforclient(param_01, 1, 1, 0);
    }
  }

  return level.interaction_hintstrings[param_00.script_noteworthy];
}

gator_tooth_placement_init() {
  level.gator_teeth_placed = 0;
}

gator_mouth_hint_func(param_00, param_01) {
  if(scripts\engine\utility::flag("gator_tooth_broken") && scripts\engine\utility::flag("gator_gold_tooth_pickup")) {
    return "";
  }

  return "";
}

gator_mouth_activation_func(param_00, param_01) {
  if(scripts\engine\utility::flag("gator_gold_tooth_pickup") && scripts\engine\utility::flag("gator_tooth_broken")) {
    if(level.gator_teeth_placed) {
      return;
    }

    level.gator_teeth_placed = 1;
    scripts\engine\utility::flag_set("gator_gold_tooth_placed");
    playsoundatpos((-1616, 1502, 360), "zmb_croc_trap_teeth_place_01");
    playsoundatpos((-1897, 1508, 360), "zmb_croc_trap_teeth_place_02");
    foreach(var_03 in level.gator_teeth_array) {
      var_03 setModel(var_03.model + "_gold");
      var_03 show();
    }

    var_05 = scripts\engine\utility::getstructarray("gator_teeth_placement", "script_noteworthy");
    foreach(var_07 in var_05) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_07);
    }
  }
}

put_tooth_in_gator_mouth() {
  var_00 = getent("gator_mouth", "targetname");
  scripts\engine\utility::flag_wait("gator_gold_tooth_pickup");
  level.gator_tooth_use_trig makeusable();
  level.gator_tooth_use_trig sethintstring( & "CP_QUEST_WOR_PLACE_PART");
  level.gator_tooth_use_trig waittill("trigger");
  scripts\engine\utility::flag_set("gator_gold_tooth_placed");
  foreach(var_02 in level.gator_teeth_array) {
    var_02 setModel(var_02.model + "_gold");
    var_02 show();
  }

  level.gator_tooth_use_trig delete();
}

gator_quest_debug() {
  wait(10);
  scripts\engine\utility::flag_set("gator_tooth_broken");
  scripts\engine\utility::flag_set("gator_gold_tooth_placed");
}

cp_zmb_should_allow_far_search_dist_func(param_00) {
  if(interaction_is_shootinggallery(param_00)) {
    return 1;
  }

  if(weapon_not_on_wall(param_00)) {
    return 1;
  }

  if(param_00.script_noteworthy == "dj_quest_speaker") {
    return 1;
  }

  if(param_00.script_noteworthy == "ark_quest_station") {
    return 1;
  }

  if(param_00.script_noteworthy == "dj_quest_speaker_mid") {
    return 1;
  }

  if(param_00.script_noteworthy == "coaster") {
    return 1;
  }

  return 0;
}

weapon_not_on_wall(param_00) {
  switch (param_00.script_noteworthy) {
    case "iw7_nrg_zm":
    case "iw7_m1c_zm":
    case "iw7_forgefreeze_zm+forgefreezealtfire":
    case "zfreeze_semtex_mp":
      return 1;

    default:
      return 0;
  }
}

interaction_is_shootinggallery(param_00) {
  return param_00.script_noteworthy == "shooting_gallery" || param_00.script_noteworthy == "shooting_gallery_afterlife";
}

zmb_last_stand_handler(param_00) {
  if(param_00 scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if(!scripts\engine\utility::istrue(param_00.have_self_revive)) {
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("laststand", "zmb_comment_vo");
    } else if(isDefined(param_00.times_self_revived)) {
      if(param_00.times_self_revived > 3) {
        param_00 thread scripts\cp\cp_vo::try_to_play_vo("laststand", "zmb_comment_vo");
      }
    }
  }

  if(level.players.size == 1) {
    if(isDefined(level.current_speaker)) {
      level notify("destroy_speaker");
    }
  }

  zmb_last_stand_weapon_handler(param_00);
}

delay_try_merge_clones() {
  level endon("game_ended");
  level notify("delay_try_merge_clones");
  level endon("delay_try_merge_clones");
  wait(1.5);
  scripts\mp\agents\zombie_grey\zombie_grey_agent::try_merge_clones();
}

zmb_last_stand_weapon_handler(param_00) {
  param_00 takeweapon("iw7_zm1coaster_zm");
}

zmb_power_gate_handler() {
  scripts\engine\utility::flag_wait("doors_initialized");
  var_00 = getEntArray("bollard_trigger", "targetname");
  foreach(var_02 in var_00) {
    var_02 sethintstring( & "COOP_INTERACTIONS_REQUIRES_POWER");
  }

  var_04 = getEntArray("first_gate_bollard", "targetname");
  var_05 = [];
  var_06 = [];
  foreach(var_08 in level.current_interaction_structs) {
    if(isDefined(var_08.script_area) && var_08.script_area == "moon" || var_08.script_area == "front_gate") {
      if(isDefined(var_08.script_noteworthy) && var_08.script_noteworthy == "debris_750") {
        var_05[var_05.size] = var_08;
      }
    }
  }

  var_0A = getEntArray("door_buy", "targetname");
  foreach(var_02 in var_0A) {
    var_02 scripts\engine\utility::trigger_off();
  }

  foreach(var_0E in var_05) {
    level thread scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0E);
    var_0E.out_of_order = 1;
  }

  level waittill("moon power_on");
  foreach(var_02 in var_00) {
    var_02 delete();
  }

  foreach(var_13 in var_04) {
    var_13 moveto(var_13.origin - (0, 0, 37), 2, 0.1, 0.1);
  }

  wait(1);
  var_15 = getEntArray("first_gate_bollard_clip", "targetname");
  foreach(var_13 in var_15) {
    var_13 connectpaths();
    var_13 delete();
  }

  foreach(var_0E in var_05) {
    var_0E.out_of_order = 0;
    level thread scripts\cp\cp_interaction::add_to_current_interaction_list(var_0E);
  }

  foreach(var_02 in var_0A) {
    var_02 scripts\engine\utility::trigger_on();
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

cp_zmb_near_equipment_func(param_00) {
  var_01 = 16384;
  if(isDefined(level.alldjcenterstructs)) {
    var_02 = sortbydistance(level.alldjcenterstructs, param_00.origin);
    if(scripts\engine\utility::istrue(var_02[0].placed)) {
      if(distance2dsquared(var_02[0].origin, param_00.origin) < var_01) {
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

dirt_fx(param_00) {
  self endon("death");
  self setscriptablepartstate("dirt", "active");
  wait(param_00);
  self setscriptablepartstate("dirt", "inactive");
}

dirt_concrete_fx(param_00) {
  self endon("death");
  self setscriptablepartstate("dirt_concrete", "active");
  wait(param_00);
  self setscriptablepartstate("dirt_concrete", "inactive");
}

cp_zmb_introscreen_text() {
  wait(2);
  var_00 = scripts\cp\cp_hud_util::introscreen_corner_line( & "CP_ZMB_INTRO_LINE_1", 1);
  wait(1);
  var_01 = scripts\cp\cp_hud_util::introscreen_corner_line( & "CP_ZMB_INTRO_LINE_2", 2);
  wait(1);
  var_02 = scripts\cp\cp_hud_util::introscreen_corner_line( & "CP_ZMB_INTRO_LINE_3", 3);
  wait(1);
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    var_03 = scripts\cp\cp_hud_util::introscreen_corner_line( & "DIRECT_BOSS_FIGHT_LINE4_ZMB", 4);
  } else {
    var_03 = scripts\cp\cp_hud_util::introscreen_corner_line( & "CP_ZMB_INTRO_LINE_4", 4);
  }

  level waittill("introscreen_over");
  var_00 fadeovertime(2);
  var_01 fadeovertime(2);
  var_02 fadeovertime(2);
  var_03 fadeovertime(2);
  var_00.alpha = 0;
  var_01.alpha = 0;
  var_02.alpha = 0;
  var_03.alpha = 0;
  var_00 destroy();
  var_01 destroy();
  var_02 destroy();
  var_03 destroy();
}

setup_generic_zombie_model_list() {
  level.generic_zombie_model_list = ["zombie_male_outfit_1", "zombie_male_outfit_1_2", "zombie_male_outfit_2", "zombie_male_outfit_2_2", "zombie_male_outfit_2_3", "zombie_male_outfit_2_4", "zombie_male_outfit_2_5", "zombie_male_outfit_2_6", "zombie_male_outfit_3", "zombie_male_outfit_3_2", "zombie_male_outfit_3_3", "zombie_male_outfit_4", "zombie_male_outfit_4_2", "zombie_male_outfit_4_3", "zombie_male_outfit_5", "zombie_male_outfit_5_2", "zombie_male_outfit_5_3", "zombie_male_outfit_6", "zombie_male_outfit_6_2", "zombie_male_outfit_1", "zombie_male_outfit_1_2", "zombie_male_outfit_2", "zombie_male_outfit_2_2", "zombie_male_outfit_2_3", "zombie_male_outfit_2_4", "zombie_male_outfit_2_5", "zombie_male_outfit_2_6", "zombie_male_outfit_3", "zombie_male_outfit_3_2", "zombie_male_outfit_3_3", "zombie_male_outfit_4", "zombie_male_outfit_4_2", "zombie_male_outfit_4_3", "zombie_male_outfit_5", "zombie_male_outfit_5_2", "zombie_male_outfit_5_3", "zombie_male_outfit_6", "zombie_male_outfit_6_2", "zombie_male_outfit_1", "zombie_male_outfit_1_2", "zombie_male_outfit_2", "zombie_male_outfit_2_2", "zombie_male_outfit_2_3", "zombie_male_outfit_2_4", "zombie_male_outfit_2_5", "zombie_male_outfit_2_6", "zombie_male_outfit_3", "zombie_male_outfit_3_2", "zombie_male_outfit_3_3", "zombie_male_outfit_4", "zombie_male_outfit_4_2", "zombie_male_outfit_4_3", "zombie_male_outfit_5", "zombie_male_outfit_5_2", "zombie_male_outfit_5_3", "zombie_male_outfit_6", "zombie_male_outfit_6_2", "zombie_male_outfit_1_b", "zombie_male_outfit_1_2_b", "zombie_male_outfit_2_b", "zombie_male_outfit_2_2_b", "zombie_male_outfit_2_3_b", "zombie_male_outfit_2_4_b", "zombie_male_outfit_2_5_b", "zombie_male_outfit_2_6_b", "zombie_male_outfit_3_b", "zombie_male_outfit_3_2_b", "zombie_male_outfit_3_3_b", "zombie_male_outfit_4_b", "zombie_male_outfit_4_2_b", "zombie_male_outfit_4_3_b", "zombie_male_outfit_5_b", "zombie_male_outfit_5_2_b", "zombie_male_outfit_5_3_b", "zombie_male_outfit_6_b", "zombie_male_outfit_6_2_b", "zombie_male_outfit_1_c", "zombie_male_outfit_1_2_c", "zombie_male_outfit_2_c", "zombie_male_outfit_2_2_c", "zombie_male_outfit_2_3_c", "zombie_male_outfit_2_4_c", "zombie_male_outfit_2_5_c", "zombie_male_outfit_2_6_c", "zombie_male_outfit_3_c", "zombie_male_outfit_3_2_c", "zombie_male_outfit_3_3_c", "zombie_male_outfit_4_c", "zombie_male_outfit_4_2_c", "zombie_male_outfit_4_3_c", "zombie_male_outfit_5_c", "zombie_male_outfit_5_2_c", "zombie_male_outfit_5_3_c", "zombie_male_outfit_6_c", "zombie_male_outfit_6_2_c", "zombie_female_outfit_1", "zombie_female_outfit_1_2", "zombie_female_outfit_1_3", "zombie_female_outfit_2", "zombie_female_outfit_2_2", "zombie_female_outfit_2_3", "zombie_female_outfit_3", "zombie_female_outfit_3_2", "zombie_female_outfit_3_3", "zombie_female_outfit_4", "zombie_female_outfit_4_2", "zombie_female_outfit_4_3", "zombie_female_outfit_5", "zombie_female_outfit_5_2", "zombie_female_outfit_5_3", "zombie_female_outfit_6", "zombie_female_outfit_6_2", "zombie_female_outfit_6_3", "zombie_female_outfit_7", "zombie_female_outfit_7_2", "zombie_female_outfit_7_3", "zombie_female_outfit_1_b", "zombie_female_outfit_1_2_b", "zombie_female_outfit_1_3_b", "zombie_female_outfit_2_b", "zombie_female_outfit_2_2_b", "zombie_female_outfit_2_3_b", "zombie_female_outfit_3_b", "zombie_female_outfit_3_2_b", "zombie_female_outfit_3_3_b", "zombie_female_outfit_4_b", "zombie_female_outfit_4_2_b", "zombie_female_outfit_4_3_b", "zombie_female_outfit_5_b", "zombie_female_outfit_5_2_b", "zombie_female_outfit_5_3_b", "zombie_female_outfit_6_b", "zombie_female_outfit_6_2_b", "zombie_female_outfit_6_3_b", "zombie_female_outfit_7_b", "zombie_female_outfit_7_2_b", "zombie_female_outfit_7_3_b", "zombie_female_outfit_1_c", "zombie_female_outfit_1_2_c", "zombie_female_outfit_1_3_c", "zombie_female_outfit_2_c", "zombie_female_outfit_2_2_c", "zombie_female_outfit_2_3_c", "zombie_female_outfit_3_c", "zombie_female_outfit_3_2_c", "zombie_female_outfit_3_3_c", "zombie_female_outfit_4_c", "zombie_female_outfit_4_2_c", "zombie_female_outfit_4_3_c", "zombie_female_outfit_5_c", "zombie_female_outfit_5_2_c", "zombie_female_outfit_5_3_c", "zombie_female_outfit_6_c", "zombie_female_outfit_6_2_c", "zombie_female_outfit_6_3_c", "zombie_female_outfit_7_c", "zombie_female_outfit_7_2_c", "zombie_female_outfit_7_3_c"];
}

post_nondeterministic_func() {
  wait(10);
  var_00 = scripts\engine\utility::getstructarray("team_door_switch", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_03 = getEntArray(var_02.target, "targetname");
    foreach(var_05 in var_03) {
      if(!isDefined(var_05.script_noteworthy)) {
        continue;
      } else if(var_05.script_noteworthy == "progress" && !isDefined(var_05.adjusted)) {
        var_05.adjusted = 1;
        var_06 = undefined;
        switch (level.players.size) {
          case 1:
            var_06 = 12;
            level.moon_donations = 2;
            level.kepler_donations = 2;
            level.triton_donations = 2;
            break;

          case 2:
            var_06 = 8;
            level.moon_donations = 1;
            level.kepler_donations = 1;
            level.triton_donations = 1;
            break;

          case 3:
            var_06 = 4;
            level.moon_donations = 0;
            level.kepler_donations = 0;
            level.triton_donations = 0;
            break;

          case 4:
            var_06 = undefined;
            level.moon_donations = -1;
            level.kepler_donations = -1;
            level.triton_donations = -1;
            break;
        }

        if(!isDefined(var_06)) {
          continue;
        }

        var_05 movez(var_06, 0.1);
        var_05 waittill("movedone");
      }
    }
  }

  level.team_door_adjusted_for = level.players.size;
  scripts\engine\utility::flag_set("team_doors_initialized");
}

cp_zmb_global_clientmatchdata_func() {
  var_00 = 24;
  setclientmatchdata("numQuestPiecesCompleted", level.num_of_quest_pieces_completed);
  setclientmatchdata("totalNumOfQuestPieces", var_00);
}

cp_zmb_should_drop_pillage(param_00, param_01) {
  if(isDefined(self.entered_playspace) && !self.entered_playspace) {
    return 0;
  }

  if(!scripts\cp\zombies\zombies_pillage::is_in_active_volume(param_01)) {
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

  if(scripts\cp\utility::too_close_to_other_interactions(param_01)) {
    return 0;
  }

  if(isDefined(param_00) && isplayer(param_00)) {
    return 1;
  }

  return 0;
}

cp_zmb_eligable_for_reward_func(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_04.shredder_death)) {
    return 0;
  }

  if(isDefined(param_04.rocket_feet)) {
    return 0;
  }

  if(isDefined(param_04.head_is_exploding)) {
    return 0;
  }

  if(isDefined(param_04.dischord_spin)) {
    return 0;
  }

  return 1;
}

cp_zmb_should_do_damage_check_func(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(scripts\engine\utility::istrue(param_05.rocket_feet)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_05.shredder_death)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_05.dischord_spin)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_05.head_is_exploding) && param_03 != "iw7_headcutterdummy_zm") {
    return 0;
  }

  if(isDefined(param_00) && isDefined(param_00.is_neil)) {
    return 0;
  }

  if(isDefined(param_00.agent_type) && param_00.agent_type == "zombie_grey" && scripts\cp\zombies\zombie_damage::isfriendlyfire(param_05, param_00)) {
    return 0;
  }

  if(!isDefined(self.is_coaster_zombie) && param_03 == "iw7_zm1coaster_zm") {
    return 0;
  }

  if(param_03 == "iw7_ufo_proj") {
    return 0;
  }

  if(param_03 == "zmb_grey_teleport_attack") {
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

cp_zmb_traversal_dismember_check(param_00) {
  var_01 = 75;
  var_02 = var_01 * var_01;
  if(!isDefined(level.traversal_dismember_locs)) {
    level.traversal_dismember_locs = [(1005, -936, 157), (1452, -1035, 190), (1346, -924, 192), (2378, 1377, 339), (3252, 1045, 133), (3330, 2253, 188), (3366, 542, 150), (3385, 211, 149), (2844, -981, 300), (-1161, -3361, 568), (-1534, -589, 440), (-2565, -1032, 427), (-2717, 1262, 428), (-2280, 1732, 427), (-2706, 2067, 465), (-2822, 1896, 465)];
  }

  foreach(var_04 in level.traversal_dismember_locs) {
    if(distancesquared(param_00.origin, var_04) < var_02) {
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

create_afterlife_arcade_start_point(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.origin = param_00;
  var_02.angles = param_01;
  level.additional_afterlife_arcade_start_point = scripts\engine\utility::array_add(level.additional_afterlife_arcade_start_point, var_02);
}

player_standing_on_nothing_check() {
  while(!isDefined(level.players)) {
    wait(0.1);
  }

  level.standing_list = [];
  for(;;) {
    foreach(var_01 in level.players) {
      var_01 bump_check((-1590, -628, 320), (-1475, -585, 490), (0, -200, 0), 1);
      var_01 bump_check((-815, -1075, 350), (-770, -760, 600), (200, 0, 0), 2);
    }

    wait(1);
  }
}

bump_check(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.standing_list[param_03])) {
    level.standing_list[param_03] = [];
  }

  var_04 = 0;
  if(is_in_box(param_00, param_01)) {
    if(isDefined(level.standing_list[param_03][self.name])) {
      self setvelocity(vectornormalize(param_02) * 100);
      var_04 = 1;
    }

    if(!var_04) {
      level.standing_list[param_03][self.name] = 1;
      return;
    }

    level.standing_list[param_03][self.name] = undefined;
    return;
  }

  level.standing_list[param_03][self.name] = undefined;
}

is_in_box(param_00, param_01) {
  if(self.origin[2] > param_00[2] && self.origin[2] < param_01[2]) {
    if(self.origin[1] > param_00[1] && self.origin[1] < param_01[1]) {
      if(self.origin[0] > param_00[0] && self.origin[0] < param_01[0]) {
        return 1;
      }
    }
  }

  return 0;
}

cp_zmb_enter_afterlife_clear_player_scriptable_func(param_00) {
  param_00 scripts\cp\zombies\zombies_weapons::turn_off_zapper_fx();
}

cp_zmb_idle_spot_patch_func() {
  scripts\cp\zombies\zombies_spawning::move_idle_spot((-34, -2417, 605), (20, -2344, 605));
  var_00 = [(844, -2322, 523), (-963, -3220, 477), (268, -1920, 229), (-586, -1168, -98), (1576, -873, -128), (2355, -265, -128), (3914, -357, 197), (4615, 1057, 207), (3440, 957, 182), (-2162, 519, 309), (-2167, -1201, 405), (-583, -2886, 643)];
  foreach(var_02 in var_00) {
    scripts\cp\zombies\zombies_spawning::add_idle_spot(var_02);
  }
}

cp_zmb_goon_spawner_patch_func(param_00) {
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00, (-357, -2605, 369), (-487, -2544, 369));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00, (2608, -498, 345), (2452, -560, 300));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00, (4578, 1, 235), (4560, 21, 172));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00, (4787, 538, 172), (4358, 345, 172));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00, (3891, 1766, 172), (3898, 2141, 116));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00, (2391, 1662, 60), (2391, 1662, 60));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00, (-2490, 1570, 284), (-2490, 1570, 284));
}

cp_zmb_interaction_struct_adjustment(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00, "script_noteworthy");
  foreach(var_03 in var_01) {
    var_03.origin = var_03.origin + anglesToForward(var_03.angles) * 2;
  }
}

cp_zmb_wait_to_be_revived_func(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if((scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) && scripts\engine\utility::istrue(level.the_hoff_revive)) {
    var_0C = wait_for_hoff_revive(param_00, param_07);
    if(scripts\engine\utility::istrue(var_0C)) {
      scripts\cp\cp_laststand::clear_last_stand_timer(param_00);
      self notify("revive_success");
      return 1;
    }

    if(scripts\engine\utility::istrue(param_0B)) {
      wait(5);
      scripts\cp\cp_laststand::clear_last_stand_timer(param_00);
      self notify("revive_success");
      return 1;
    }

    scripts\cp\cp_laststand::clear_last_stand_timer(param_00);
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    level waittill("forever");
    return 0;
  }

  return undefined;
}

wait_for_hoff_revive(param_00, param_01) {
  level endon("hoff_death");
  level endon("game_ended");
  param_00 endon("disconnect");
  var_02 = param_00.reviveent scripts\engine\utility::waittill_any_timeout_1(param_01, "trigger");
  if(var_02 != "trigger") {
    return undefined;
  }

  return 1;
}

cp_zmb_ghost_n_skull_setup() {
  level.gns_num_of_wave = 5;
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::init();
  level.ghost_n_skull_reactivate_func = ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_activation::reactive_ghost_n_skull_cabinet;
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

moving_targets_fly_to_portal_logic(param_00) {
  level notify("moving_targets_fly_to_portal_logic");
  level endon("moving_targets_fly_to_portal_logic");
  level endon("game_ended");
  level endon("stop_moving_target_sequence");
  while(scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::active_moving_target_available()) {
    wait(3);
    var_01 = scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::get_active_moving_target_based_on_priority();
    if(!isDefined(var_01)) {
      return;
    }

    scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::activate_red_moving_target(var_01);
  }
}

cp_zmb_set_moving_target_color(param_00, param_01) {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::set_moving_target_color(param_00, "green");
}

cp_zmb_should_moving_target_explode(param_00, param_01) {
  return 1;
}

zmb_gns_player_reward_func() {
  foreach(var_01 in level.players) {
    var_01 thread scripts\cp\cp_vo::try_to_play_vo("ghost_end", "zmb_comment_vo", "highest", 3, 0, 0, 1);
    var_01 thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::give_gns_base_reward(var_01);
  }
}

setupinvalidvolumes() {
  level.invalidtranspondervolumes = [];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(1326, -764, -25), (1334, -509, -25), (394, -430, 40), (406, -811, 60)];
  level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(2358, 954, 280), (2360, 1521, 280), (2838, 1522, 400), (2821, 948, 339)];
}

vectors_are_in_box(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [param_00, param_01, param_02, param_03];
  if(!isDefined(param_04)) {
    if(isplayer(self) || isagent(self)) {
      param_04 = self.origin;
    } else {
      return 0;
    }
  }

  for(var_06 = 0; var_06 < 2; var_06++) {
    foreach(var_08 in var_05) {
      var_09 = 0;
      foreach(var_0B in var_05) {
        if(var_08 == var_0B) {
          continue;
        }

        if((param_04[var_06] > var_08[var_06] && param_04[var_06] < var_0B[var_06]) || param_04[var_06] > var_0B[var_06] && param_04[var_06] < var_08[var_06]) {
          break;
        } else {
          var_09++;
          if(var_09 > 2) {
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

directgreyfightshouldruneventfunc(param_00) {
  return 0;
}

directgreyfightbossspawnfunc() {
  return 0;
}

direct_boss_fight_zombie_spawning() {
  var_00 = 28;
  level.zombies_paused = 1;
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::deactivateadjacentvolumes();
  level.wave_num = var_00;
  level.wave_num_override = var_00;
  level.current_enemy_deaths = 0;
  level.max_static_spawned_enemies = 24;
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    level.spawndelayoverride = 0.7;
  } else {
    level.spawndelayoverride = 0.35;
  }

  level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::force_zombie_sprint();
}

directgreyfightguidedinteractionexclusions(param_00, param_01, param_02) {
  if(isDefined(param_00) && isDefined(param_00.script_noteworthy) && param_00.script_noteworthy == "debris_750") {
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
  var_00 = scripts\engine\utility::getstructarray("interaction", "targetname");
  var_01 = [];
  foreach(var_03 in var_00) {
    if(isDefined(var_03.script_noteworthy) && var_03.script_noteworthy == "neil_head") {
      var_01[var_01.size] = var_03;
    }
  }

  foreach(var_06 in var_01) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_06);
  }
}

direct_boss_wait_for_grey_fight_complete() {
  level endon("game_ended");
  level waittill("complete_alien_grey_fight");
  level thread scripts\cp\zombies\direct_boss_fight::success_sequence(6, 1);
}

respawn_in_grey_fight() {
  var_00 = [(918, 1411, 11), (768, 1414, 11), (501, 1390, 11), (358, 1416, 11)];
  var_01 = (652, 795, 115);
  var_02 = [];
  foreach(var_06, var_04 in var_00) {
    var_05 = spawnStruct();
    var_05.origin = var_04;
    var_05.angles = vectortoangles(var_01 - var_04);
    var_02[var_06] = var_05;
  }

  foreach(var_05 in var_02) {
    if(positionwouldtelefrag(var_05.origin)) {
      continue;
    }

    return var_05;
  }

  return var_02[0];
}