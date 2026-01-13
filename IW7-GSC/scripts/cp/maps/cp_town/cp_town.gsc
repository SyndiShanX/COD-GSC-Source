/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town.gsc
***********************************************/

main() {
  setdvar("sm_sunSampleSizeNear", 0.97);
  setdvar("sm_sunCascadeSizeMultiplier1", 2);
  setdvar("sm_sunCascadeSizeMultiplier2", 3);
  setdvar("r_sdfShadowPenumbra", 0.4);
  setdvar("r_umbraMinObjectContribution", 6);
  setdvar("r_umbraAccurateOcclusionThreshold", 2000);
  setdvar("sm_roundRobinPrioritySpotShadows", 8);
  setdvar("sm_spotUpdateLimit", 8);
  level.bcrabbrutedebugger = getdvarint("debug_crab_brute", 0);
  level.bcrabminidebugger = getdvarint("debug_crab_mini", 0);
  level.bcrabbossdebugger = getdvarint("debug_crab_boss", 0);
  level.belviradebugger = getdvarint("debug_elvira", 0);
  if(scripts\engine\utility::istrue(level.belviradebugger)) {
    level.bzombiedebugger_nospawner = 1;
  }

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  registerscriptedagents();
  registerlevelenemyarrays();
  level.coop_weapontable = "cp\cp_town_weapontable.csv";
  scripts\cp\utility::coop_mode_enable(["pillage"]);
  scripts\cp\maps\cp_town\cp_town_precache::main();
  scripts\cp\maps\cp_town\gen\cp_town_art::main();
  scripts\cp\maps\cp_town\cp_town_fx::main();
  if(level.createfx_enabled) {
    return;
  }

  level.melee_weapons = [];
  level.player_pap_machines = [];
  level.current_vision_sets = [];
  level.current_vision_set = "cp_town_bw";
  level.vision_set_override = level.current_vision_set;
  scripts\cp\zombies\coop_wall_buys::init();
  level.map_interaction_func = ::scripts\cp\maps\cp_town\cp_town_interactions::register_interactions;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.weapon_rank_event_table = "scripts\cp\maps\cp_town\cp_town_weaponrank_event.csv";
  level.coop_weapontable = "cp\cp_town_weapontable.csv";
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.guidedinteractionexclusion = ::guidedinteractionsexclusions;
  level.guided_interaction_offset_func = ::guidedinteractionoffsetfunc;
  level.guidedinteractionendposoverride = ::guidedinteractionendposoverride;
  level.interaction_trigger_properties_func = ::interactiontriggerproperties;
  level.wait_to_be_revived_func = ::wait_to_be_revived_func;
  level.auto_melee_agent_type_check = ::auto_melee_agent_type_check;
  level.callbackplayerdamage = ::scripts\cp\maps\cp_town\cp_town_damage::callback_townzombieplayerdamage;
  level.aa_ww_char_vo = ::town_choose_correct_vo_for_player;
  level.spawn_fx_func = ::cp_town_spawn_fx_func;
  level.scriptablestatefunc = ::scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate;
  level.introscreen_text_func = ::cp_town_introscreen_text;
  level.mutilation_mask_override_func = ::mutilation_mask_func;
  level.customhostmigrationend = ::townhostmigrationfunc;
  level.ismeleeblocked_func = ::cp_town_ismeleeblocked_func;
  level.nextwheelweaponfunc = ::town_wheelnextweapon;
  scripts\cp\crafted_trap_portal::init();
  scripts\cp\crafted_trap_violetray::init();
  scripts\cp\crafted_trap_seismic::init();
  scripts\cp\crafted_trap_mindcontrol::init();
  scripts\cp\crafted_trap_hypnosis::init();
  level.magic_wheel_spin_hint = &"CP_TOWN_INTERACTIONS_SPIN_WHEEL";
  level.reboard_barriers_hint = &"CP_TOWN_INTERACTIONS_SECURE_WINDOW";
  level.enter_area_hint = &"CP_TOWN_INTERACTIONS_ENTER_THIS_AREA";
  level.primary_melee_weapons = ["iw7_knife_zm_schoolgirl", "iw7_knife_zm_scientist", "iw7_knife_zm_soldier", "iw7_knife_zm_rebel", "iw7_knife_zm_crowbar", "iw7_knife_zm_elvira", "iw7_knife_zm_cleaver"];
  level.additional_laststand_weapon_exclusion = ["iw7_cpbasketball_mp", "iw7_cpskeeball_mp", "iw7_cpclowntoothball_mp", "iw7_horseracepistol_zm_blue", "iw7_horseracepistol_zm_yellow", "iw7_horseracepistol_zm_red", "iw7_horseracepistol_zm_green", "iw7_shootgallery_zm", "iw7_blackholegun_mp", "iw7_penetrationrail_mp", "iw7_atomizer_mp", "iw7_glr_mp", "iw7_claw_mp", "iw7_steeldragon_mp", "iw7_shootgallery_zm_blue", "iw7_shootgallery_zm_yellow", "iw7_shootgallery_zm_red", "iw7_shootgallery_zm_green", "iw7_gunless_zm"];
  level.last_stand_weapons = ["iw7_g18_zm", "iw7_g18_zmr", "iw7_g18_zml", "iw7_g18c_zm", "iw7_mag_zm", "iw7_revolver_zm", "iw7_revolver_zmr", "iw7_revolver_zmr_explosive", "iw7_revolver_zml", "iw7_revolver_zml_single", "iw7_emc_zm", "iw7_emc_zmr", "iw7_emc_zmr_burst", "iw7_emc_zml", "iw7_emc_zml_spread", "iw7_nrg_zm", "iw7_nrg_zmr", "iw7_nrg_zmr_smart", "iw7_nrg_zml", "iw7_nrg_zml_charge", "iw7_dischord_zm", "iw7_headcutter_zm", "iw7_shredder_zm", "iw7_facemelter_zm", "iw7_dischord_zm_pap1", "iw7_headcutter_zm_pap1", "iw7_shredder_zm_pap1", "iw7_facemelter_zm_pap1", "iw7_golf_club_mp_pap1", "iw7_two_headed_axe_mp_pap1", "iw7_spiked_bat_mp_pap1", "iw7_machete_mp_pap1", "iw7_golf_club_mp_pap2", "iw7_two_headed_axe_mp_pap2", "iw7_spiked_bat_mp_pap2", "iw7_machete_mp_pap2", "iw7_golf_club_mp", "iw7_two_headed_axe_mp", "iw7_spiked_bat_mp", "iw7_machete_mp"];
  level.melee_weapons = ["iw7_knife_zm_cleaver", "iw7_knife_zm_crowbar"];
  level.invalid_gesture_weapon = ["iw7_nunchucks_zm"];
  setup_generic_zombie_model_list();
  scripts\cp\maps\cp_town\cp_town_crab_boss_bomb::generate_nuclear_code();
  level.player_suit = "zom_dlc3_suit";
  level.player_run_suit = "zom_dlc3_suit_sprint";
  level.player_interaction_monitor = ::scripts\cp\maps\cp_town\cp_town_interactions::town_player_interaction_monitor;
  level.wait_for_interaction_func = ::scripts\cp\maps\cp_town\cp_town_interactions::town_wait_for_interaction_triggered;
  level.should_run_event_func = ::cp_town_should_run_event;
  level.event_funcs_init = ::cp_town_event_wave_init;
  level.available_event_func = ::cp_town_event_selection;
  level.event_funcs_start = ::cp_town_event_start;
  level.event_funcs_end = ::cp_town_event_end;
  level.custom_pillageinitfunc = ::pillage_init;
  level.pap_room_func = ::pap_machine_func;
  level.should_do_damage_check_func = ::cp_town_should_do_damage_check_func;
  level.boss_spawn_func = ::scripts\cp\zombies\cp_town_spawning::cp_town_boss_spawn;
  level.should_spawn_special_zombie_func = ::scripts\cp\zombies\cp_town_spawning::should_spawn_skater;
  level.special_zombie_spawn_func = ::scripts\cp\zombies\cp_town_spawning::get_spawner_and_spawn_goons;
  level.goon_spawner_patch_func = ::cp_town_goon_patch_func;
  level.patch_update_spawners = ::patch_update_spawners;
  level.setup_direct_boss_fight_func = ::town_setup_direct_boss_fight_func;
  level.start_direct_boss_fight_func = ::town_start_direct_boss_fight_func;
  level.special_zap_start_func = ::cp_town_zap_start_func;
  level.special_zap_end_func = ::cp_town_zap_end_func;
  level.town_power_vo_func = ::town_power_on_vo;
  scripts\cp\maps\cp_town\cp_town_player_character_setup::init_player_characters();
  level scripts\engine\utility::delaythread(3, ::colorize_sound_state_change, "fullblackandwhite", 1);
  setglobalsoundcontext("color", "bw");
  level.char_intro_music = ::play_char_intro_music;
  level.char_intro_gesture = ::play_char_intro_gesture;
  level.initial_active_volumes = ["morgue"];
  level.drop_max_ammo_func = ::scripts\cp\loot::drop_loot;
  level thread scripts\cp\maps\cp_town\cp_town_vo::town_vo_init();
  level thread wait_for_pre_game_period();
  level thread watchforpowerontriggers();
  level thread setup_pap_camos();
  level thread map_exploit_spots();
  level thread scripts\cp\maps\cp_town\cp_town_interactions::initmeleeweapons();
  level thread scripts\cp\maps\cp_town\cp_town_interactions::initwwpieces();
  level thread scripts\cp\maps\cp_town\cp_town_mpq::cp_town_mpq_init();
  level thread scripts\cp\maps\cp_town\cp_town_ghost_activation::cp_town_gns_4_setup();
  level thread scripts\cp\maps\cp_town\cp_town_crab_boss_fight::init_crab_boss_stage();
  level thread scripts\cp\zombies\cp_town_spawning::cp_town_spawning_init();
  level thread setup_pa_speakers();
  level thread scripts\cp\maps\cp_town\cp_town_vo::power_nag();
  level.purchase_area_vo = ::scripts\cp\maps\cp_town\cp_town_vo::purchase_area_vo;
  level thread water_triggers();
  scripts\cp\maps\cp_town\cp_town_crafting::init_crafting();
  scripts\engine\utility::flag_init("fuses_inserted");
  level thread fix_doors();
  level thread add_cutie_eggs();
  sysprint("MatchStarted: Completed");
  thread scripts\cp\maps\cp_town\cp_town_chemistry::init();
}

play_char_intro_gesture() {
  thread scripts\cp\utility::firegesturegrenade(self, self.intro_gesture);
  wait(waitgesturelength());
  self notify("finish_intro_gesture");
}

fix_doors() {
  while(!isDefined(level.struct)) {
    wait(1);
  }

  var_0 = scripts\engine\utility::getstructarray("debris_750", "script_noteworthy");
  var_1 = scripts\engine\utility::getclosest((4792.2, -4374, 9.5), var_0);
  var_1.script_area = "drive_in_elvira";
  var_2 = scripts\engine\utility::getclosest((4832.3, -4347.3, 9.5), var_0);
  var_2.script_area = "morgue";
}

waitgesturelength() {
  switch (self.vo_prefix) {
    case "p1_":
      return self getgestureanimlength("ges_load_in_schoolgirl");

    case "p2_":
      return self getgestureanimlength("ges_load_in_scientist");

    case "p3_":
      return self getgestureanimlength("ges_load_in_soldier");

    case "p4_":
      return self getgestureanimlength("ges_load_in_rebel");

    case "p5_":
      return self getgestureanimlength("ges_load_in_elvira");

    default:
      return 3;
  }
}

wait_for_pre_game_period() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  level.current_personal_interaction_structs = [];
  wait(0.2);
  scripts\engine\utility::flag_set("zombie_drop_powerups");
  scripts\engine\utility::flag_set("pillage_enabled");
  scripts\cp\zombies\zombie_entrances::enable_windows_in_area("morgue");
  level thread scripts\cp\maps\cp_town\cp_town_elvira::init_elvira();
  level thread bink_test();
  init_magic_wheel();
}

bink_test() {}

registerlevelenemyarrays() {
  level.ignoreimmune = ["crab_brute", "crab_boss"];
  level.fnfimmune = ["crab_brute", "crab_boss", "crab_mini"];
  level.instakillimmune = ["crab_brute", "crab_boss"];
  level.specialzombie = ["crab_brute"];
}

init_magic_wheel() {
  var_0 = ["camp_transition", "generator_transition", "elvira_transition", "elvira_station"];
  scripts\cp\zombies\interaction_magicwheel::set_magic_wheel_starting_location(scripts\engine\utility::random(var_0));
}

onplayerspawned() {
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    level.current_vision_set = "cp_town_color";
    self visionsetnakedforplayer("cp_town_color", 0);
    return;
  }

  if(isDefined(level.current_vision_set)) {
    self visionsetnakedforplayer(level.current_vision_set, 1);
    return;
  }

  self visionsetnakedforplayer("cp_town_c_bw", 0);
}

onplayerconnect(var_0) {
  var_0 thread streamweaponsonzonechange(var_0);
  var_0 thread run_pap_machine_logic(var_0);
  var_0 thread watchforweaponchange(var_0);
  var_0 thread setupdamagetriggers(var_0);
  var_0 thread assignpersonalmodelents(var_0);
  var_0 thread watchforplayerzonechange(var_0);
  var_0 thread movepentstostructs(var_0);
  var_0 thread watch_for_cdc_shade(var_0);
  var_0 thread start_chemistry_interaction_items(var_0);
  level thread show_soul_key_progress(var_0);
  level thread watch_player_on_ladders(var_0);
  var_0 thread update_client_omnvars();
  var_0 thread scripts\cp\cp_vo::add_to_nag_vo("nag_board_windows", "rave_comment_vo", 180, 60, 20, 1);
  var_0 thread scripts\cp\maps\cp_town\cp_town_ghost_activation::watch_for_player_position();
}

update_client_omnvars() {
  wait(5);
  if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
    foreach(var_1 in level.players) {
      var_1 setclientomnvar("zm_special_item", 1);
    }

    return;
  }

  if(scripts\engine\utility::flag("picked_up_uncharged_fuses")) {
    foreach(var_1 in level.players) {
      var_1 setclientomnvar("zm_special_item", 5);
    }
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
      while(var_0 isonladder() && var_0 scripts\cp\utility::is_valid_player()) {
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
          wait(1);
        }

        wait(0.05);
        var_0.time_on_ladders = var_0.time_on_ladders + 0.05;
      }
    }

    wait(0.05);
  }
}

start_chemistry_interaction_items(var_0) {
  var_0 endon("disconnect");
  while(!scripts\engine\utility::istrue(level.crafted_chem_set)) {
    wait(1);
  }

  if(isDefined(level.h_p_button_objects)) {
    foreach(var_2 in level.h_p_button_objects) {
      var_0 thread scripts\cp\maps\cp_town\cp_town_chemistry::update_player_monitor_buttons(var_2);
      var_0 thread scripts\cp\maps\cp_town\cp_town_chemistry::watch_for_input_entered_on_button(var_2);
    }
  }

  var_0 thread scripts\cp\maps\cp_town\cp_town_chemistry::watch_for_reaction_start_pressed(level.reaction_start_model);
  var_0 thread scripts\cp\maps\cp_town\cp_town_chemistry::update_player_monitor_reaction_start(level.reaction_start_model);
}

watch_for_cdc_shade(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  level thread hide_on_game_ended();
  wait(5);
  var_1 = getent("cdc_shade", "targetname");
  var_2 = getent("cdc_shade_volume", "targetname");
  var_0.shade_hidden = 0;
  for(;;) {
    if(var_0 istouching(var_2) && !scripts\engine\utility::istrue(var_0.zoom_out_camera)) {
      if(!var_0.shade_hidden) {
        var_1 showtoplayer(var_0);
        var_0.shade_hidden = 1;
      }
    } else if(var_0.shade_hidden) {
      var_1 hidefromplayer(var_0);
      var_0.shade_hidden = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

hide_on_game_ended() {
  level waittill("game_ended");
  wait(0.1);
  var_0 = getent("cdc_shade", "targetname");
  var_0 hide();
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
      var_0 thread[[level.weapon_change_func[var_2]]](var_0, var_1);
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

streamweaponsonzonechange(var_0) {
  var_0 endon("disconnect");
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

registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("mp\dlc3_agent_definition.csv");
  scripts\mp\agents\zombie_dlc3\zombie_dlc3_agent::registerscriptedagent();
  scripts\mp\agents\crab_brute\crab_brute_agent::registerscriptedagent();
  scripts\mp\agents\crab_mini\crab_mini_agent::registerscriptedagent();
  scripts\mp\agents\crab_boss\crab_boss_agent::registerscriptedagent();
  scripts\mp\agents\elvira\elvira_agent::registerscriptedagent();
}

add_cutie_eggs() {
  wait(5);
}

cp_town_event_wave_init() {
  level.event_funcs["crab_mini"] = ::scripts\cp\zombies\cp_town_spawning::goon_spawn_event_func;
  init_town_spawner_locations();
}

init_town_spawner_locations() {
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

  level thread scripts\cp\zombies\cp_town_spawning::update_crog_spawners();
}

cp_town_should_run_event(var_0) {
  if(var_0 < 5) {
    return 0;
  }

  if(!level.tent_door_opened) {
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

cp_town_event_selection(var_0) {
  return "crab_mini";
}

cp_town_event_start(var_0) {
  switch (var_0) {
    case "crab_mini":
      level thread clown_wave_music();
      break;

    default:
      break;
  }
}

clown_wave_music() {
  wait(0.5);
  if(!scripts\engine\utility::istrue(level.playspecialwave)) {
    level thread play_willard_elvira_exchange("special_wave");
    level.playspecialwave = 1;
  } else {
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_crog_wavestart", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  }

  wait(2.5);
  if(soundexists("mus_zombies_eventwave_start")) {
    level thread mus_rave_eventwave_start();
  }
}

play_willard_elvira_exchange(var_0, var_1) {
  if(scripts\engine\utility::istrue(level.vo_system_busy) || scripts\engine\utility::istrue(level.pause_nag_vo)) {
    wait(1);
    return;
  }

  scripts\cp\cp_vo::set_vo_system_busy(1);
  level.pause_nag_vo = 1;
  foreach(var_3 in level.players) {
    scripts\cp\cp_vo::func_C9CB([var_3]);
  }

  var_5 = level.elvira;
  switch (var_0) {
    case "special_wave":
      var_5 playSound("ww_specialwave_first_1");
      wait(scripts\cp\cp_vo::get_sound_length("ww_specialwave_first_1"));
      var_5 playSound("el_specialwave_first_2");
      wait(scripts\cp\cp_vo::get_sound_length("el_specialwave_first_2"));
      var_5 playSound("ww_specialwave_first_3");
      wait(scripts\cp\cp_vo::get_sound_length("ww_specialwave_first_3"));
      break;

    case "escortingelvira":
      var_5 playSound("ww_escortingelvira_1");
      wait(scripts\cp\cp_vo::get_sound_length("ww_escortingelvira_1"));
      var_5 playSound("el_escortingelvira_2");
      wait(scripts\cp\cp_vo::get_sound_length("el_escortingelvira_2"));
      var_5 playSound("ww_escortingelvira_3");
      wait(scripts\cp\cp_vo::get_sound_length("ww_escortingelvira_3"));
      var_5 playSound("el_escortingelvira_4");
      wait(scripts\cp\cp_vo::get_sound_length("el_escortingelvira_4"));
      break;

    case "elvira_upgrade1":
      var_5 playSound("ww_elvira_upgrade1_1");
      wait(scripts\cp\cp_vo::get_sound_length("ww_elvira_upgrade1_1"));
      var_5 playSound("el_elvira_upgrade1_2");
      wait(scripts\cp\cp_vo::get_sound_length("el_elvira_upgrade1_2"));
      var_5 playSound("ww_elvira_upgrade1_3");
      wait(scripts\cp\cp_vo::get_sound_length("ww_elvira_upgrade1_3"));
      var_5 playSound("el_elvira_upgrade1_4");
      wait(scripts\cp\cp_vo::get_sound_length("el_elvira_upgrade1_4"));
      break;

    case "elvira_upgrade2":
      var_5 playSound("el_elvira_upgrade2_1");
      var_6 = scripts\cp\cp_vo::get_sound_length("el_elvira_upgrade2_1");
      var_1 thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_talks(var_6);
      wait(var_6);
      var_5 playSound("ww_elvira_upgrade2_2");
      wait(scripts\cp\cp_vo::get_sound_length("ww_elvira_upgrade2_2"));
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
      break;

    case "evirasbook":
      scripts\engine\utility::play_sound_in_space("el_pap_nag_spellbook_vial", level.elvira.origin, 0, level.elvira);
      var_6 = scripts\cp\cp_vo::get_sound_length("el_pap_nag_spellbook_vial");
      var_1 thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_talks(var_6);
      wait(var_6);
      var_5 playSound("el_evirasbook_1");
      var_6 = scripts\cp\cp_vo::get_sound_length("el_evirasbook_1");
      var_1 thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_talks(var_6);
      wait(var_6);
      var_5 playSound("ww_evirasbook_2");
      wait(scripts\cp\cp_vo::get_sound_length("ww_evirasbook_2"));
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
      break;

    case "crogboss_defeat":
      var_5 playSound("el_crogboss_defeat_1");
      wait(scripts\cp\cp_vo::get_sound_length("el_crogboss_defeat_1"));
      var_5 playSound("ww_crogboss_defeat_2");
      wait(scripts\cp\cp_vo::get_sound_length("ww_crogboss_defeat_2"));
      var_5 playSound("el_crogboss_defeat_3");
      wait(scripts\cp\cp_vo::get_sound_length("el_crogboss_defeat_3"));
      break;
  }

  foreach(var_8 in level.players) {
    scripts\cp\cp_vo::func_12BE3([var_8]);
  }

  level.pause_nag_vo = 0;
  scripts\cp\cp_vo::set_vo_system_busy(0);
}

mus_rave_eventwave_start() {
  scripts\cp\utility::playsoundinspace("mus_zombies_eventwave_start", (0, 0, 0));
  level notify("wave_start_sound_done");
}

mus_rave_eventwave_end() {
  scripts\cp\utility::playsoundinspace("mus_zombies_eventwave_end", (0, 0, 0));
}

cp_town_event_end(var_0) {
  switch (var_0) {
    case "crab_mini":
      level thread mus_rave_eventwave_end();
      break;

    default:
      break;
  }
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

cp_town_goon_patch_func(var_0) {
  remove_goon_spawner((2848, 335.6, -14.5), var_0);
  remove_goon_spawner((2428.1, 462, -28.6), var_0);
  remove_goon_spawner((-415.2, -3898.9, 392), var_0);
  remove_goon_spawner((-42.7, -3045.9, 528.3), var_0);
  remove_goon_spawner((-413.1, -3389.7, 524.8), var_0);
  remove_goon_spawner((4849.3, -2515.9, -61.5), var_0);
  remove_goon_spawner((5001.4, -3962.1, -30.4), var_0);
  remove_goon_spawner((-181.3, -2857.9, 543.5), var_0);
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (116.2, -4497, 297.9), (564.2, -4993, 313.9));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (874.5, -470.4, 417.5), (602.5, -134.4, 417.5));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (-133.9, -3881.3, 422.8), (-117.9, -4185.3, 356.8));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (-600, -2656, 528), (-766, -2392, 536));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (5396.6, 404.9, 336), (5342.6, 274.9, 336));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (5071, 767.3, 353.1), (4847, 771.3, 353.1));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (5733.5, -3525.6, 42.8), (5781.5, -3545.6, 80.8));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (5502, -3900.8, -22.8), (5820, -3994.8, 5.2));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (5152.2, -3497.8, -58.4), (4824.2, -3603.8, -58.4));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (4637.8, -3391.1, -67.1), (4567.8, -3213.1, -61.1));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (4492.1, -2471.5, -51.6), (5535.4, -3147.6, 210.8));
  scripts\cp\zombies\zombies_spawning::move_goon_spawner(var_0, (-894.2, -4525, 334.7), (-1070.2, -4461, 334.7));
}

remove_goon_spawner(var_0, var_1) {
  var_2 = scripts\engine\utility::getclosest(var_0, var_1, 500);
  var_2.remove_me = 1;
}

patch_update_spawners() {
  scripts\cp\zombies\zombies_spawning::remove_origin((4795.6, 1395.2, 344));
  scripts\cp\zombies\zombies_spawning::remove_origin((-608.7, -3560, 528.3));
  scripts\cp\zombies\zombies_spawning::remove_origin((-411.7, -3557.8, 532.6));
}

pap_machine_func(var_0, var_1) {
  level.pap_machine = var_1;
  level.pap_machine hide();
  var_0.powered_on = 1;
}

run_pap_machine_logic(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
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
  level.pillageinfo.battery_model = "crafting_battery_single_01";
  level.pillageable_powers = [];
  level.pillageable_explosives = ["power_clusterGrenade", "power_gasGrenade", "power_bioSpike", "power_c4", "power_frag"];
  level.pillageable_attachments = [];
  level.pillageinfo.clip = 33;
  level.pillageinfo.explosive = 33;
  level.pillageinfo.money = 34;
  level.pillageinfo.var_28C2 = 0;
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_1", "backpack", "cp_rave_backpack_dropped", "cp_rave_backpack", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_2", "backpack", "cp_rave_backpack_dropped_green", "cp_rave_backpack_green", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_3", "backpack", "cp_rave_backpack_dropped_purple", "cp_rave_backpack_purple", "j_spine4");
  scripts\cp\zombies\zombies_pillage::register_zombie_pillageable("backpack_4", "backpack", "cp_rave_backpack_dropped_red", "cp_rave_backpack_red", "j_spine4");
  level.battery_drop_wave = randomintrange(7, 11);
  level thread rebalance_pillage_after_wave(level.battery_drop_wave);
  level thread wait_for_radios_fixed();
}

rebalance_pillage_after_wave(var_0) {
  level endon("game_ended");
  level endon("both_radios_fixed");
  for(;;) {
    level waittill("regular_wave_starting");
    if(level.wave_num >= var_0) {
      for(var_1 = 0; var_1 < level.var_CB87.size; var_1++) {
        switch (level.var_CB87[var_1].ref) {
          case "explosive":
            var_2 = 20;
            break;

          case "clip":
            var_2 = 15;
            break;

          case "money":
            var_2 = 15;
            break;

          case "battery":
            var_2 = 50;
            break;

          default:
            var_2 = 0;
            break;
        }

        level.var_CB87[var_1].var_3C35 = var_2;
      }
    }
  }
}

rebalance_pillage_after_batteries() {
  for(var_0 = 0; var_0 < level.var_CB87.size; var_0++) {
    switch (level.var_CB87[var_0].ref) {
      case "explosive":
        var_1 = 33;
        break;

      case "clip":
        var_1 = 33;
        break;

      case "money":
        var_1 = 34;
        break;

      case "battery":
        var_1 = 0;
        break;

      default:
        var_1 = 0;
        break;
    }

    level.var_CB87[var_0].var_3C35 = var_1;
  }

  foreach(var_3 in level.players) {
    var_3 setclientomnvar("zm_nag_text", 0);
  }
}

wait_for_radios_fixed() {
  level endon("game_ended");
  level.chem_radios_fixed = 0;
  for(;;) {
    level waittill("radio_fixed");
    if(level.chem_radios_fixed == 2) {
      level notify("both_radios_fixed");
      level thread rebalance_pillage_after_batteries();
      break;
    }
  }
}

watchforpowerontriggers() {
  level endon("game_ended");
  for(;;) {
    level waittill("volume_activated", var_0);
    if(var_0 == "generator_transition" || var_0 == "elvira_transition") {
      break;
    }
  }

  wait(randomintrange(8, 10));
  if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("el_color_restore_first", "elvira_player_dialogue_vo", "highest", 70, 0, 0, 1);
  }

  level thread colorize_sound_state_change("colorized", 2.5);
  setglobalsoundcontext("color", "full", 3);
  level.current_vision_set = "cp_town_color";
  level.vision_set_override = level.current_vision_set;
  scripts\cp\maps\cp_town\cp_town_interactions::applyvisionsettoallplayers("cp_town_color");
  level.film_grain_off = 1;
  foreach(var_2 in level.players) {
    if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
      var_2 playlocalsound("mus_zmb_town_full_color_lr");
    }

    var_2 setclientomnvar("zm_ui_dialpad_9", 2);
  }
}

colorize_sound_state_change(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1.5;
  }

  switch (var_0) {
    case "fullblackandwhite":
      setaudiotriggerstate("worldcolorstate", "full_black_and_white", var_1);
      break;

    case "colorized":
      setaudiotriggerstate("worldcolorstate", "color", var_1);
      break;

    default:
      setaudiotriggerstate("worldcolorstate", "color", var_1);
      break;
  }
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

cp_town_spawn_fx_func() {
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

      case "sand":
        self setscriptablepartstate("spawn_fx_sand", "active");
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

guidedinteractionsexclusions(var_0, var_1, var_2) {
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
      default:
        break;
    }
  }

  if(isDefined(var_0.groupname) && var_0.groupname == "challenge") {
    return 0;
  }

  if(isDefined(var_0.script_label)) {}

  return 1;
}

guidedinteractionendposoverride(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_3 = scripts\cp\cp_interaction::get_area_for_power(var_1);
  if(isDefined(var_1.script_noteworthy)) {
    var_4 = var_1.script_noteworthy;
    switch (var_4) {
      case "iw7_mp28_zm":
        if(isDefined(var_3) && var_3 == "motel_transition") {
          var_2 = (0, 0, 24);
        }
        break;

      case "debris_750":
        if(isDefined(var_3) && var_3 == "morgue") {
          var_2 = (0, 0, 56);
        }
        break;

      case "perk_machine_rat_a_tat":
        if(isDefined(var_3) && var_3 == "elvira_station") {
          var_2 = (0, 0, 56);
        }
        break;

      case "debris_1500":
        if(isDefined(var_3) && var_3 == "supermarket") {
          var_2 = (0, 0, 56);
        }
        break;

      default:
        var_2 = (0, 0, 0);
        break;
    }
  }

  return var_1.origin + var_2;
}

guidedinteractionoffsetfunc(var_0, var_1) {
  var_2 = (0, 0, 56);
  var_3 = scripts\cp\cp_interaction::get_area_for_power(var_0);
  if(isDefined(var_0.script_noteworthy)) {
    var_4 = var_0.script_noteworthy;
    switch (var_4) {
      case "iw7_fmg_zm":
        if(isDefined(var_3) && var_3 == "camp_transition") {
          var_2 = (0, 0, 48);
        }
        break;

      case "iw7_cheytacc_zm":
        if(isDefined(var_3) && var_3 == "motel_transition") {
          var_2 = (0, 0, 16);
        }
        break;

      case "iw7_mp28_zm":
        if(isDefined(var_3) && var_3 == "motel_transition") {
          var_2 = (0, 0, 40);
        }
        break;

      case "iw7_revolver_zm":
        if(isDefined(var_3) && var_3 == "morgue") {
          var_2 = (0, 0, 45);
        }
        break;

      case "iw7_erad_zm":
        if(isDefined(var_3) && var_3 == "drive_in_theater") {
          var_2 = (0, 0, 5);
        }
        break;

      case "iw7_ump45c_zm":
        if(isDefined(var_3) && var_3 == "elvira_station") {
          var_2 = (0, 0, 62);
        }
        break;

      case "iw7_lockon_zm":
        if(isDefined(var_3) && var_3 == "bridge_beach") {
          var_2 = (0, 0, 57);
        }
        break;

      case "iw7_crb_zml":
        if(isDefined(var_3) && var_3 == "generator_transition") {
          var_2 = (0, 0, 68);
        }
        break;

      case "iw7_rvn_zm":
        if(isDefined(var_3) && var_3 == "gas_station_street") {
          var_2 = (0, 0, 45);
        }
        break;

      case "debris_1500":
        if(isDefined(var_3) && var_3 == "supermarket") {
          var_2 = (6, 0, 56);
        }
        break;

      default:
        var_2 = (0, 0, 56);
        break;
    }
  }

  return var_2;
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
    if(var_4.size > 0) {
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
                  var_9 thread[[level.normal_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_6, 0, var_0);
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
                var_9 thread[[level.normal_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_6, 1, var_0);
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
                var_9 thread[[level.special_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_6, 0, var_0);
              }
            } else if(isDefined(var_6.kung_fu_model)) {
              var_9 setModel(var_6.kung_fu_model);
            }
          } else if(isDefined(var_6.script_noteworthy) && isDefined(level.normal_mode_activation_funcs[var_6.script_noteworthy])) {
            var_8 = 1;
            if(isDefined(var_7)) {
              var_9[[level.normal_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_7, 0, var_0);
            } else {
              var_9 thread[[level.normal_mode_activation_funcs[var_6.script_noteworthy]]](var_9, var_6, 0, var_0);
            }
          } else if(isDefined(var_6.normal_model)) {
            var_9 setModel(var_6.normal_model);
          }

          adjustmodelvis(var_0, var_9);
        }
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
  if(!isDefined(var_0)) {
    return;
  }

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
      case "MOD_GRENADE":
      case "MOD_PROJECTILE_SPLASH":
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
        case "iw7_bluebolts_zm":
        case "concussion_grenade_mp":
          return 0;

        default:
          break;
      }
    }
  }

  return 1;
}

setup_generic_zombie_model_list() {
  level.generic_zombie_model_list = ["zombie_dlc3_male_outfit_1", "zombie_dlc3_male_outfit_1_2", "zombie_dlc3_male_outfit_2", "zombie_dlc3_male_outfit_2_2", "zombie_dlc3_male_outfit_2_3", "zombie_dlc3_male_outfit_3", "zombie_dlc3_male_outfit_3_2", "zombie_dlc3_male_outfit_3_3", "zombie_dlc3_male_outfit_4", "zombie_dlc3_male_outfit_4_2", "zombie_dlc3_male_outfit_4_3", "zombie_dlc3_male_outfit_5", "zombie_dlc3_male_outfit_5_2", "zombie_dlc3_male_outfit_5_3", "zombie_dlc3_male_outfit_6", "zombie_dlc3_male_outfit_6_2", "zombie_dlc3_male_outfit_6_3", "zombie_dlc3_female_outfit_1", "zombie_dlc3_female_outfit_1_2", "zombie_dlc3_female_outfit_1_3", "zombie_dlc3_female_outfit_2", "zombie_dlc3_female_outfit_2_2", "zombie_dlc3_female_outfit_2_3", "zombie_dlc3_female_outfit_3", "zombie_dlc3_female_outfit_3_2", "zombie_dlc3_female_outfit_3_3", "zombie_dlc3_female_outfit_4", "zombie_dlc3_female_outfit_4_2", "zombie_dlc3_female_outfit_4_3", "zombie_dlc3_female_outfit_5", "zombie_dlc3_female_outfit_5_2", "zombie_dlc3_female_outfit_5_3", "zombie_dlc3_female_outfit_6", "zombie_dlc3_female_outfit_6_2", "zombie_dlc3_female_outfit_6_3", "zombie_dlc3_male_greaser_01", "zombie_dlc3_male_greaser_02", "zombie_dlc3_male_greaser_01", "zombie_dlc3_male_greaser_02"];
}

interactiontriggerproperties(var_0, var_1, var_2) {
  if(isDefined(var_1.script_noteworthy)) {
    switch (var_1.script_noteworthy) {
      case "bomb_start":
      case "push_bomb":
        self.interaction_trigger usetriggerrequirelookat(1);
        self.interaction_trigger setusefov(360);
        break;

      case "crafting_piece":
        self.interaction_trigger usetriggerrequirelookat(1);
        self.interaction_trigger setusefov(270);
        break;

      case "iw7_knife_zm_crowbar":
        self.interaction_trigger usetriggerrequirelookat(1);
        self.interaction_trigger setusefov(270);
        self.interaction_trigger.origin = var_1.origin + (0, 0, 10);
        break;

      case "iw7_knife_zm_cleaver":
        self.interaction_trigger usetriggerrequirelookat(1);
        self.interaction_trigger setusefov(270);
        break;

      case "hidden_song_record":
        self.interaction_trigger usetriggerrequirelookat(1);
        self.interaction_trigger setusefov(30);
        if(var_1.target == "45_record_2") {
          self.interaction_trigger.origin = var_1.origin + (20, 8, 10);
        } else if(var_1.target == "45_record_1") {
          self.interaction_trigger.origin = var_1.origin + (5, 0, 5);
        } else if(var_1.target == "45_record_3") {
          self.interaction_trigger.origin = var_1.origin + (-30, -5, 0);
        } else if(var_1.target == "45_record_4") {
          self.interaction_trigger.origin = var_1.origin + (15, 15, 25);
        } else {
          self.interaction_trigger setusefov(20);
          self.interaction_trigger.origin = var_1.origin + (-15, -35, 0);
        }
        break;

      case "mpq_zom_body_part":
        self.interaction_trigger.origin = var_1.origin + (0, 0, 10);
        self.interaction_trigger usetriggerrequirelookat(1);
        self.interaction_trigger setusefov(270);
        break;

      case "element_pickup":
      case "radiation_collector_interaction":
      case "cipher_interaction":
      case "radiation_extraction_interaction":
      case "town_fast_travel":
      case "plunger_ammo":
      case "generator_field_center":
      case "bomb_teleporter_part":
        self.interaction_trigger.origin = var_1.origin + (0, 0, 10);
        self.interaction_trigger usetriggerrequirelookat(1);
        self.interaction_trigger setusefov(270);
        break;

      case "compound_storage_4":
      case "compound_storage_3":
      case "compound_storage_2":
      case "compound_storage_1":
      case "chem_container_04":
      case "chem_container_03":
      case "chem_container_02":
      case "chem_container_01":
        self.interaction_trigger.origin = var_1.origin + (0, 0, 10);
        self.interaction_trigger usetriggerrequirelookat(1);
        self.interaction_trigger setusefov(270);
        break;

      case "discard_chem_interaction":
        self.interaction_trigger.origin = var_1.origin + (0, 0, 20);
        self.interaction_trigger usetriggerrequirelookat(1);
        self.interaction_trigger setusefov(270);
        break;
    }
  }
}

cp_town_zap_start_func(var_0) {
  self.scripted_mode = 1;
  self ghostskulls_complete_status(self.origin);
}

cp_town_zap_end_func(var_0) {
  self.scripted_mode = 0;
}

auto_melee_agent_type_check(var_0) {
  if(isDefined(var_0.agent_type)) {
    if(var_0.agent_type == "crab_mini") {
      return 0;
    }

    if(var_0.agent_type == "crab_brute") {
      return 0;
    }
  } else {
    return 0;
  }

  return 1;
}

cp_town_should_do_damage_check_func(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(self.nodamage)) {
    return 0;
  }

  return 1;
}

setupdamagetriggers(var_0) {
  var_0 endon("disconnect");
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_1 = getent("boundary_toxic_line", "targetname");
  var_2 = scripts\engine\utility::getstructarray("boundary_toxic_line_center", "targetname");
  for(;;) {
    if(var_0 scripts\cp\utility::is_valid_player() && ispointinvolume(var_0.origin, var_1)) {
      if(!isDefined(var_0.geiger_counter)) {
        var_0.geiger_counter = 1;
        var_0 playlocalsound("town_geiger_counter_lvl4_plr");
      }

      if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
        if(isDefined(var_0.geiger_counter)) {
          var_0.geiger_counter = undefined;
          var_0 scripts\cp\utility::stoplocalsound_safe("town_geiger_counter_lvl4_plr");
        }
      }

      if(var_0 istouching(level.radiation_collection_volume)) {
        if(var_0 scripts\cp\utility::has_zombie_perk("perk_machine_tough")) {
          var_3 = scripts\engine\utility::getclosest(var_0.origin, var_2);
          var_4 = scripts\engine\utility::ter_op(distance(var_3.origin, var_0.origin) >= 128, int(var_0.maxhealth * 0.2), int(var_0.maxhealth * 0.5));
          var_0 dodamage(var_4 / 10, var_3.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_contamination_zm");
          wait(0.5);
        } else {
          var_3 = scripts\engine\utility::getclosest(var_2.origin, var_4);
          var_4 = scripts\engine\utility::ter_op(distance(var_4.origin, var_1.origin) >= 128, int(var_1.maxhealth * 0.2), int(var_1.maxhealth * 0.5));
          var_0 dodamage(var_4, var_3.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_contamination_zm");
          wait(0.5);
        }

        var_0 setscriptablepartstate("screen_effects", "screen_goo");
      } else {
        var_3 = scripts\engine\utility::getclosest(var_2.origin, var_4);
        var_4 = scripts\engine\utility::ter_op(distance(var_4.origin, var_1.origin) >= 128, int(var_1.maxhealth * 0.2), int(var_1.maxhealth * 0.5));
        var_0 dodamage(var_4, var_3.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_contamination_zm");
        wait(0.5);
        var_0 setscriptablepartstate("screen_effects", "screen_goo");
      }

      continue;
    }

    wait(0.1);
    if(isDefined(var_0.geiger_counter)) {
      var_0.geiger_counter = undefined;
      var_0 scripts\cp\utility::stoplocalsound_safe("town_geiger_counter_lvl4_plr");
    }
  }
}

car_trap_test() {
  wait(10);
  var_0 = getvehiclenode("car_path_1", "targetname");
  var_1 = spawnvehicle("park_roller_coaster_cart", "vehicle_car", "cp_town_temp_vehicle", var_0.origin, var_0.angles);
  var_1 attachpath(var_0);
  var_1 startpath();
  for(;;) {
    wait(25);
    var_1 attachpath(var_0);
    var_1 startpath();
  }
}

town_wheelnextweapon(var_0, var_1, var_2) {
  if(!var_2 scripts\cp\cp_weapon::has_weapon_variation("iw7_cutier_zm") && !var_2 scripts\cp\cp_weapon::has_weapon_variation("iw7_cutie_zm") && randomint(100) <= 10) {
    var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_cutie_zm");
    return "iw7_cutie_zm";
  }

  return var_1;
}

town_choose_correct_vo_for_player(var_0) {
  wait(18);
  var_1 = "";
  if(var_0.times_self_revived >= var_0.max_self_revive_machine_use) {
    var_1 = "ww_afterlife_p4_notoken";
  } else {
    var_2 = ["ww_afterlife_p1_generic", "ww_afterlife_p5_alt_1", "ww_afterlife_arrive"];
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

      case "alt":
        var_2 = var_2 + var_0 + "_alt_1";
        break;

      default:
        break;
    }

    if(!soundexists(var_2)) {
      var_3 = ["ww_afterlife_p1_generic", "ww_afterlife_arrive", "ww_afterlife_p5_alt_1"];
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

setup_pap_camos() {
  level.no_pap_camos = ["cutie", "iw7_cutier_zm"];
  level.pap_1_camo = "camo92";
  level.pap_2_camo = "camo93";
}

setupweaponupgradearray() {
  level.weapon_upgrade_path = [];
  level.weapon_upgrade_path["iw7_cutie_zm"] = "iw7_cutie_zm+cutiegrip";
  level.weapon_upgrade_path["iw7_cutie_zm+cutiegrip"] = " iw7_cutie_zm+cutiecrank+cutiegrip+cutieplunger";
}

water_triggers() {
  var_0 = getEntArray("water_trigger", "targetname");
  scripts\engine\utility::array_thread(var_0, ::water_trigger);
  level.water_respawn_spots = scripts\engine\utility::getstructarray("water_respawn_spot", "targetname");
}

water_trigger() {
  for(;;) {
    self waittill("trigger", var_0);
    if(!isplayer(var_0)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade) || isDefined(var_0.in_water)) {
      if(scripts\engine\utility::istrue(var_0.iscarrying)) {
        if(isDefined(var_0.carriedsentry) && isDefined(var_0.carriedsentry.name) && var_0.carriedsentry.name == "crafted_rad_extractor") {
          if(!scripts\engine\utility::istrue(level.completed_pool_part_skulltop_quest)) {
            continue;
          } else {
            if(isDefined(level.pool_extraction_fx)) {
              level.pool_extraction_fx delete();
            }

            level.rad_extractor_owner = undefined;
          }
        }

        var_0 notify("force_cancel_placement");
        var_0 playlocalsound("ww_magicbox_laughter");
      }

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
    self.in_water = undefined;
    if(scripts\cp\cp_laststand::self_revive_activated()) {
      reset_water_values();
      return;
    }

    if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\utility::has_zombie_perk("perk_machine_revive")) {
      reset_water_values();
      return;
    }

    reset_water_values();
    move_player_to_closest_spot(self);
    return;
  }

  scripts\engine\utility::allow_crouch(0);
  scripts\engine\utility::allow_prone(0);
  scripts\engine\utility::allow_slide(0);
  while(self istouching(var_0)) {
    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      self.in_water = undefined;
      if(scripts\cp\cp_laststand::self_revive_activated()) {
        move_player_to_closest_spot(self);
        reset_water_values();
        return;
      }

      if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\utility::has_zombie_perk("perk_machine_revive")) {
        reset_water_values();
        return;
      }

      move_player_to_closest_spot(self);
      reset_water_values();
      return;
    }

    wait(0.05);
  }

  reset_water_values();
}

reset_water_values() {
  if(scripts\engine\utility::istrue(self.disabledcrouch)) {
    scripts\engine\utility::allow_crouch(1);
  }

  if(scripts\engine\utility::istrue(self.disabledprone)) {
    scripts\engine\utility::allow_prone(1);
  }

  if(scripts\engine\utility::istrue(self.disabledslide)) {
    scripts\engine\utility::allow_slide(1);
  }

  self.in_water = undefined;
}

move_player_to_closest_spot(var_0) {
  var_1 = get_closest_valid_water_respawn_spots(var_0);
  var_2 = var_1.origin + (0, 0, 20);
  var_3 = getgroundposition(var_2, 8, 32, 32);
  if(!isDefined(var_3)) {
    var_3 = var_1.origin;
  }

  var_0 setorigin(var_3);
  wait(0.5);
}

get_closest_valid_water_respawn_spots(var_0) {
  var_1 = sortbydistance(level.water_respawn_spots, var_0.origin);
  foreach(var_3 in var_1) {
    if(canspawn(var_3.origin) && !positionwouldtelefrag(var_3.origin)) {
      return var_3;
    }
  }
}

setup_pa_speakers() {
  level.jukebox_table = "cp\zombies\cp_town_music_genre.csv";
  scripts\cp\zombies\zombie_jukebox::parse_music_genre_table();
  wait(1.15);
  disablepaspeaker("pa_town_icecream_out");
  disablepaspeaker("pa_town_icecream_in");
  disablepaspeaker("pa_town_snackshake_out");
  disablepaspeaker("pa_town_motel_out");
  disablepaspeaker("pa_town_market_in");
  disablepaspeaker("pa_town_market_out");
  disablepaspeaker("pa_town_camper_out");
  level thread reenablepas_after_host_migration();
}

reenablepas_after_host_migration() {
  level endon("game_ended");
  level waittill("host_migration_begin");
  level waittill("host_migration_end");
  if(scripts\engine\utility::istrue(level.music_playing)) {
    if(!isDefined(level.enabled_jukeboxes)) {
      return;
    }

    foreach(var_1 in level.enabled_jukeboxes) {
      scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town(var_1);
    }
  }

  if(isDefined(level.current_vision_set)) {
    scripts\cp\maps\cp_town\cp_town_interactions::applyvisionsettoallplayers(level.current_vision_set);
  }
}

enablepas() {
  level.music_playing = 1;
  if(!isDefined(level.enabled_jukeboxes)) {
    level.enabled_jukeboxes = [];
  }

  scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_icecream_out");
  scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_icecream_in");
  scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_snackshake_out");
  scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_motel_out");
  scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_market_in");
  scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_market_out");
  scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_camper_out");
  wait(1);
  if(scripts\engine\utility::flag("queue_hidden_song")) {
    scripts\engine\utility::flag_wait("hidden_song_ended");
  }

  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start((1785, -2077, 211));
  wait(4);
  level notify("jukebox_start");
}

show_soul_key_progress(var_0) {
  var_0 endon("disconnect");
  var_1 = (-10265, 932, -1581);
  var_2 = (0, 0, 90);
  var_3 = (-10260, 932, -1561);
  var_4 = (0, 0, 90);
  var_5 = (-10250, 932, -1555);
  var_6 = (0, 0, 90);
  var_0 waittill("spawned_player");
  var_7 = var_0 getplayerdata("cp", "haveSoulKeys", "soul_key_1");
  var_8 = var_0 getplayerdata("cp", "haveSoulKeys", "soul_key_2");
  var_9 = var_0 getplayerdata("cp", "haveSoulKeys", "soul_key_3");
  if(scripts\engine\utility::istrue(var_7)) {
    playFX(level._effect["soul_jar_d"], var_1, anglesToForward(var_2), anglestoup(var_2), var_0);
  }

  if(scripts\engine\utility::istrue(var_8)) {
    playFX(level._effect["soul_jar_e"], var_3, anglesToForward(var_4), anglestoup(var_4), var_0);
  }

  if(scripts\engine\utility::istrue(var_8)) {
    playFX(level._effect["soul_jar_a"], var_5, anglesToForward(var_6), anglestoup(var_6), var_0);
  }
}

town_power_on_vo(var_0) {
  level endon("gamed_ended");
  var_0 endon("death");
  var_0 endon("disconnect");
  if(scripts\engine\utility::flag_exist("canFiresale")) {
    scripts\engine\utility::flag_set("canFiresale");
  }

  var_1 = "final_1";
  switch (var_0.vo_prefix) {
    case "p1_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("sally_power_" + var_1, "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["sally_power_" + var_1] = 1;
      break;

    case "p4_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("aj_power_" + var_1, "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["aj_power_" + var_1] = 1;
      break;

    case "p3_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("andre_power_" + var_1, "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["andre_power_" + var_1] = 1;
      break;

    case "p2_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("pdex_power_" + var_1, "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level.completed_dialogues["pdex_power_" + var_1] = 1;
      break;

    default:
      break;
  }

  scripts\cp\cp_vo::remove_from_nag_vo("nag_activate_power", 1);
}

cp_town_introscreen_text() {
  var_0 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_TOWN_INTRO_LINE_1", 1);
  wait(1);
  var_1 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_TOWN_INTRO_LINE_2", 2);
  wait(1);
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    var_2 = scripts\cp\cp_hud_util::introscreen_corner_line(&"DIRECT_BOSS_FIGHT_LINE4_TOWN", 4);
  } else {
    var_2 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_TOWN_INTRO_LINE_3", 3);
  }

  wait(1);
  var_3 = scripts\cp\cp_hud_util::introscreen_corner_line(&"CP_TOWN_INTRO_LINE_4", 4);
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

comp_test() {
  wait(10);
  foreach(var_1 in level.chemistry_set_parts) {
    if(isDefined(var_1.model) && var_1.model == "cp_town_chem_lab_computer_interactive") {
      var_1 show();
      var_1 setscriptablepartstate("screen", "on");
      for(;;) {
        var_1 setscriptablepartstate("screen", "on");
        wait(2);
        var_1 setscriptablepartstate("redlight", "on");
        wait(2);
        var_1 setscriptablepartstate("redlight", "off");
        wait(2);
        var_1 setscriptablepartstate("greenlight", "on");
        wait(2);
        var_1 setscriptablepartstate("greenlight", "off");
        wait(2);
        var_1 setscriptablepartstate("yellowlight", "on");
        wait(2);
        var_1 setscriptablepartstate("yellowlight", "off");
        wait(2);
      }
    }
  }
}

map_exploit_spots() {
  level.invalid_orgs = [];
  var_0 = spawn("script_model", (4969.5, -2212.4, 166));
  var_0.angles = (88.7987, 51.7666, 2.36934);
  var_0 setModel("player128x128x8");
  var_1 = spawn("script_model", (4904.5, -2156.1, 166));
  var_1.angles = (88.7989, 51.8044, 3.00622);
  var_1 setModel("player128x128x8");
  var_2 = spawn("script_model", (912, -945.5, 544.5));
  var_2 setModel("player16x16x128_rounded");
}

townhostmigrationfunc() {
  if(isDefined(level.film_grain_off)) {
    foreach(var_1 in level.players) {
      var_1 setclientomnvar("zm_ui_dialpad_9", 2);
    }
  }

  scripts\cp\maps\cp_town\cp_town_interactions::applyvisionsettoallplayers(level.current_vision_set);
}

cp_town_ismeleeblocked_func() {
  var_0 = self.origin + (0, 0, self.var_B5F9);
  var_1 = self.curmeleetarget.origin + (0, 0, self.var_B5F9);
  if(!isplayer(self.curmeleetarget) && !isai(self.curmeleetarget)) {
    return 0;
  }

  if(isplayer(self.curmeleetarget)) {
    if(self.curmeleetarget isusingturret()) {
      return 0;
    }
  }

  var_2 = [];
  var_2[var_2.size] = self.curmeleetarget;
  foreach(var_4 in level.death_ray_cannons) {
    var_2[var_2.size] = var_4;
  }

  var_6 = scripts\common\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  if(scripts\common\trace::ray_trace_passed(var_0, var_1, var_2, var_6)) {
    return 0;
  }

  if(isplayer(self.curmeleetarget)) {
    var_6 = scripts\common\trace::create_default_contents(0);
    var_7 = scripts\common\trace::ray_trace(var_0, var_1, level.agentarray, var_6);
    if(var_7["hittype"] == "hittype_entity" && var_7["entity"] == self.curmeleetarget) {
      return 0;
    }
  }

  return 1;
}

town_setup_direct_boss_fight_func() {
  level.zombies_paused = 1;
  level.direct_boss_fight_flag_wait = "crab_boss_combat_ready";
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::advance_pre_combat_stage();
}

town_start_direct_boss_fight_func() {
  level notify("crab_boss_quest_completed");
  level.getspawnpoint = ::respawn_in_crab_boss_fight;
  wait(2);
  give_players_cleaver();
  scripts\cp\utility::set_quest_icon(23);
  scripts\engine\utility::flag_clear("vial_filled");
  level thread scripts\cp\maps\cp_town\cp_town_elvira::crog_vial_meter();
  setomnvar("zom_general_fill_percent_2", 0);
  scripts\cp\utility::set_quest_icon(20);
}

give_players_cleaver() {
  var_0 = "iw7_knife_zm_cleaver";
  foreach(var_2 in level.players) {
    if(isDefined(var_2.currentmeleeweapon)) {
      var_2 takeweapon(var_2.currentmeleeweapon);
    }

    var_2 giveweapon(var_0);
    var_2.default_starting_melee_weapon = var_0;
    var_2.currentmeleeweapon = var_0;
    var_2.melee_weapon = var_0;
  }
}

respawn_in_crab_boss_fight() {
  var_0 = [(1654, -1472, 304), (1812, -1366, 239), (1914, -1174, 187), (2185, -1170, 185)];
  var_1 = (3035, 2829, -141);
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