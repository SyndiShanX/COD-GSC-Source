/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg.gsc
*************************************************/

main() {
  scripts\sp\maps\stpetersburg\gen\stpetersburg_art.gsc::main();
  scripts\sp\maps\stpetersburg\stpetersburg_fx.gsc::main();
  scripts\sp\maps\stpetersburg\stpetersburg_lighting.gsc::main();
  scripts\sp\maps\stpetersburg\stpetersburg_precache.gsc::main();
  scripts\sp\maps\stpetersburg\stpetersburg_anim.gsc::main();
  setsaveddvar("MKNNNONLSK", 4);
  stpetersburg_starts();
  stpetersburg_transients();
  stpetersburg_preload();
  scripts\sp\fakeactor::fakeactor_spawner_init();
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  thread kilo121_hack();
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::bar_init();
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_apartment.gsc::apartment_init();
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_canal.gsc::canal_init();
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_acquire.gsc::acquire_init();
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_escort.gsc::escort_phase_init();
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_gauntlet.gsc::gauntlet_init();
  scripts\sp\maps\stpetersburg\stpetersburg_interrogation.gsc::interrogation_init();
  scripts\sp\maps\stpetersburg\stpetersburg_vignette_alleys.gsc::alleys_vig_init();
  scripts\sp\maps\stpetersburg\stpetersburg_vig_script_street_intro.gsc::vig_street_intro_init();
  scripts\sp\maps\stpetersburg\stpetersburg_vig_script_canal.gsc::canal_vig_init();
  scripts\sp\maps\stpetersburg\stpetersburg_vig_script_gauntlet.gsc::gauntlet_vig_init();
  scripts\sp\maps\stpetersburg\stpetersburg_containment.gsc::containment_init();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::init_dialog_structs();
  init_hints();
  init_dvars();
  thread stpetersburg_objectives();
  stpetersburg_player_setup();
  thread stpetersburg_door_init();
  stpetersburg_ai_spawn_function_setup();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::display_ai_count();
  thread scripts\sp\maps\stpetersburg\stpetersburg_containment.gsc::containment_start();
  setomnvar("ai_fulllight", 0.0025);
  setomnvar("ai_nolight", 0.001);
  scripts\engine\sp\utility::intro_screen_custom_func(::stpetersburg_intro_screen);
  scripts\engine\sp\utility::battlechatter_off("allies");
  thread scripts\sp\friendlyfire::strict_ff_enable();
}

kilo121_hack() {
  var_0 = getEnt("weapon_iw8_lm_kilo121+rec_kilo121+front_kilo121+back_kilo121+reflex_west01+box_kilo121", "code_classname");
  var_1 = spawn("weapon_iw8_lm_kilo121+rec_kilo121+front_kilo121+back_kilo121+reflex_west01+xmags_kilo121", var_0.origin, var_0.spawnflags);
  var_1.angles = var_0.angles;
  var_1.targetname = var_0.targetname;
  var_1 scripts\anim\shared.gsc::setscriptammo("weapon_iw8_lm_kilo121", var_0, undefined);
  var_0 delete();
}

stpetersburg_intro_screen() {
  scripts\engine\utility::flag_wait("intro_bink_done");
  scripts\sp\introscreen::introscreen(1);
}

stpetersburg_starts() {
  scripts\engine\sp\utility::set_default_start("stakeout_intro");
  scripts\engine\sp\utility::add_start("stakeout_intro", ::stakeout_intro_start, "", ::stakeout_stp_main, "10000000000_110", ::null_catchup);
  scripts\engine\sp\utility::add_start("stakeout", ::stakeout_start, "", ::stakeout_stp_main, "10000000000_110", ::stakeout_catchup);
  scripts\engine\sp\utility::add_start("alley_stealth", ::alley_stealth_start, "", ::alley_stealth_stp_main, "11000000000_110", ::alley_stealth_catchup);
  scripts\engine\sp\utility::add_start("bar_backroom", ::bar_backroom_start, "", ::bar_backroom_stp_main, "01100000000_110", ::bar_backroom_catchup);
  scripts\engine\sp\utility::add_start("bar_shootout", ::bar_shootout_start, "", ::bar_shootout_stp_main, "01100000000_110", ::bar_shootout_catchup);
  scripts\engine\sp\utility::add_start("bar_street", ::bar_street_start, "", ::bar_street_stp_main, "01100000000_110", ::bar_street_catchup);
  scripts\engine\sp\utility::add_start("apartment", ::apartment_start, "", ::apartment_stp_main, "00110000000_110", ::apartment_catchup);
  scripts\engine\sp\utility::add_start("canal", ::canal_start, "", ::canal_stp_main, "00011000000_110", ::canal_catchup);
  scripts\engine\sp\utility::add_start("acquire", ::acquire_start, "", ::acquire_stp_main, "00001100000_010", ::acquire_catchup);
  scripts\engine\sp\utility::add_start("evade", ::evade_start, "", ::evade_stp_main, "00001100000_010", ::evade_catchup);
  scripts\engine\sp\utility::add_start("gauntlet", ::gauntlet_start, "", ::gauntlet_stp_main, "00000110000_010", ::gauntlet_catchup);
  scripts\engine\sp\utility::add_start("gauntlet_shootout", ::gauntlet_shootout_start, "", ::gauntlet_shootout_stp_main, "00000011100_011", ::gauntlet_shootout_catchup);
  scripts\engine\sp\utility::add_start("interrogation_cine", ::interrogation_cine_start, "", ::interrogation_stp_main, "00000001100_001", ::null_catchup);
  scripts\engine\sp\utility::add_start("interrogation_intro", ::interrogation_intro_start, "", ::interrogation_stp_main, "00000001100_001", scripts\sp\maps\stpetersburg\stpetersburg_interrogation.gsc::interrogation_intro_catchup);
  scripts\engine\sp\utility::add_start("interrogation_room", ::interrogation_room_start, "", ::interrogation_stp_main, "00000001011_001", ::null_catchup);
  scripts\engine\sp\utility::add_start("interrogation_revolver", ::interrogation_revolver_start, "", ::interrogation_stp_main, "00000001001_001", ::null_catchup);
}

stpetersburg_transients() {
  scripts\engine\sp\utility::transient_init("stpetersburg_stakeout_script_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_alley_script_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_bar_script_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_apartment_script_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_canal_script_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_cafe_script_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_gauntlet_script_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_interrogation_shared_script_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_interrogation_intro_script_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_interrogation_escort_script_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_interrogation_main_script_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_intro_geo_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_periph_geo_tr");
  scripts\engine\sp\utility::transient_init("stpetersburg_interrogation_geo_tr");
}

stpetersburg_preload() {
  precachemodel("body_al_qatala_urban_ar_variants");
  precachemodel("body_al_qatala_urban_ar_variants_2_1");
  precachemodel("body_al_qatala_urban_lmg");
  precachemodel("body_al_qatala_urban_lmg_variants_2_1");
  precachemodel("body_al_qatala_urban_lmg_variants_2_2");
  precachemodel("body_al_qatala_urban_cqb_variants_1_2");
  precachemodel("body_al_qatala_urban_civ_6_1");
  precachemodel("body_al_qatala_urban_a6_variants");
  precachemodel("body_al_qatala_urban_a6_variants_1_2");
  precachemodel("body_civ_stpeterburg_female_1_1");
  precachemodel("body_civ_london_female_4_1");
  precachemodel("body_civ_london_female_7_1");
  precachemodel("body_civ_london_female_8_1");
  precachemodel("body_civ_london_female_9_1");
  precachemodel("body_civ_london_female_10_1");
  precachemodel("body_civ_stpeterburg_female_3_1");
  precachemodel("body_civ_stpeterburg_female_4_1");
  precachemodel("body_civ_stpeterburg_male_1_1");
  precachemodel("body_civ_stpeterburg_male_2_1");
  precachemodel("body_civ_stpeterburg_male_3_1");
  precachemodel("body_civ_stpeterburg_male_4_1");
  precachemodel("body_civ_stpeterburg_male_5_1");
  precachemodel("body_civ_london_male_5_1");
  precachemodel("body_civ_london_male_7_1");
  precachemodel("body_civ_london_male_8_1");
  precachestring(&"STPETERSBURG/PURSUIT_WARNING");
  precachemodel("viewhands_base_fullbody_iw8");
  precachemodel("veh8_civ_lnd_palfa_black");
  precachemodel("veh8_civ_lnd_decho_rus_police");
  precachemodel("veh8_civ_lnd_ralfa_grey");
  precachemodel("door_wood_double_b_r_01_brown_sp");
  precachemodel("veh8_civ_lnd_palfa_east_no_windows");
  precachemodel("veh8_civ_lnd_palfa_static_dst_east");
  precachemodel("veh8_civ_lnd_palfa");
  precachemodel("hat_civ_female_interrogation");
  precachemodel("hat_civ_child_interrogation");
  precachemodel("body_villain_enforcer_interrogation");
  precachemodel("head_villain_enforcer_damage");
  precachemodel("head_villain_enforcer_damage_blendshape");
  precachemodel("head_hero_nikolai_blendshape");
  precachemodel("head_hero_price_blendshape");
  precachemodel("head_sc_f_mahdawi_blendshape");
  precachemodel("decor_cigarette__01");
  precachemodel("ee_furniture_chair_wooden_interrogation");
  precachemodel("stpete_interrogation_van_light_01");
  precachemodel("veh8_civ_lnd_skilo");
  precachemodel("veh8_civ_lnd_skilo_black");
  precachemodel("veh8_civ_lnd_skilo_green");
  precachemodel("veh8_civ_lnd_skilo_grey");
  precachemodel("veh8_civ_lnd_skilo_blue");
  precachemodel("veh8_civ_lnd_skilo_red");
  precachemodel("veh8_civ_lnd_ralfa");
  precachemodel("veh8_civ_lnd_ralfa_grey");
  precachemodel("veh8_civ_lnd_ralfa_brown");
  precachemodel("veh8_civ_lnd_ralfa_blue");
  precachemodel("veh8_civ_lnd_ralfa_red");
  precachemodel("veh8_civ_lnd_victor40");
  precachemodel("veh8_civ_lnd_victor40_black");
  precachemodel("veh8_civ_lnd_victor40_brown");
  precachemodel("veh8_civ_lnd_victor40_blue");
  precachemodel("veh8_civ_lnd_victor40_silver");
  precachemodel("veh8_civ_lnd_victor40_red");
  precachemodel("veh8_civ_lnd_secho");
  precachemodel("veh8_civ_lnd_secho_black");
  precachemodel("veh8_civ_lnd_secho_blue");
  precachemodel("veh8_civ_lnd_secho_grey");
  precachemodel("veh8_civ_lnd_secho_red");
  precachemodel("veh8_civ_lnd_secho_green");
  precachemodel("veh8_civ_lnd_decho_black");
  precachemodel("veh8_civ_lnd_decho");
  precachemodel("veh8_civ_lnd_decho_silver");
  precachemodel("veh8_civ_lnd_decho_blue");
  precachemodel("veh8_civ_lnd_decho_green");
  precachemodel("veh8_civ_lnd_decho_tan");
  precachemodel("veh8_civ_lnd_decho_brown");
}

stpetersburg_player_setup() {
  var_0 = ["frag", "flash", "molotov"];
  scripts\engine\sp\utility::offhandprecache(var_0);
  setplayerviewmodel("viewhands_hero_kyle_urban", "viewhands_hero_kyle_urban_fullbody", "default_character_shadow");
  scripts\sp\utility::context_melee_set_arms("viewhands_hero_kyle_urban");
  setup_player_rig();
  thread track_player_achievements();
}

track_player_achievements() {
  if(!isDefined(level.killweaponarray))
    level.killweaponarray = [];

  scripts\engine\utility::flag_wait("flag_gauntlet_complete");

  if(level.killweaponarray.size >= 8)
    scripts\sp\utility::giveachievement_wrapper("HOTSWAP");
}

stpetersburg_ai_spawn_function_setup() {
  scripts\engine\sp\utility::add_global_spawn_function("axis", scripts\engine\sp\utility::disable_long_death);
  scripts\engine\sp\utility::add_global_spawn_function("axis", ::track_achievement_death);
  scripts\engine\sp\utility::add_global_spawn_function("neutral", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::civ_stationary_ff_penalty_think);
  var_0 = getspawnerarray();
  scripts\engine\sp\utility::array_spawn_function(var_0, scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::breath_fx_thread);
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.classname == "actor_enemy_alq_urban_snow_ar" || var_3.classname == "actor_enemy_alq_urban_snow_smg" || var_3.classname == "actor_enemy_alq_urban_snow_shotgun")
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  scripts\engine\sp\utility::array_spawn_function(var_1, ::drop_pistol_on_death);
}

drop_pistol_on_death() {
  self endon("entitydeleted");
  waitframe();

  if(scripts\engine\utility::cointoss()) {
    return;
  }
  self waittill("death");
  var_0 = [];
  var_0[0] = "iw8_pi_papa320";
  var_0[1] = "iw8_pi_decho";
  var_0[2] = "iw8_pi_golf21";
  var_1 = scripts\sp\utility::make_weapon(scripts\engine\utility::random(var_0));
  self dropweaponnovelocity(var_1, "right");
}

track_achievement_death() {
  self endon("entitydeleted");
  self waittill("death", var_0, var_1, var_2);

  if(!isDefined(var_0)) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  var_3 = getweaponbasename(var_2);

  if(!isDefined(level.killweaponarray))
    level.killweaponarray = [];

  if(!scripts\engine\utility::array_contains(level.killweaponarray, var_3))
    level.killweaponarray = scripts\engine\utility::array_add(level.killweaponarray, var_3);
}

adjust_ai_pistol_accuracy() {
  var_0 = scripts\common\utility::getdifficulty();

  if(var_0 == "hard")
    self.base_accuracy = 1.0;
  else if(var_0 == "fu")
    self.base_accuracy = 10.0;
}

stpetersburg_friendly_fire_think() {
  thread scripts\sp\friendlyfire::friendly_fire_think(self);
}

setup_player_rig() {
  level.player.rig = scripts\engine\sp\utility::spawn_anim_model("player_rig", (0, 0, 0), level.player.angles);
  level.player.rig hide();
  level.player.rig dontcastshadows();
}

setplayerviewmodel(var_0, var_1, var_2) {
  if(isDefined(var_0))
    level.player setviewmodel(var_0);

  if(isDefined(var_1)) {}

  if(isDefined(var_2))
    level.player setshadowmodel(var_2);
}

stpetersburg_door_init() {
  var_0 = scripts\sp\door::get_all_interactive_doors();

  foreach(var_2 in var_0)
  var_2 scripts\game\sp\door::remove_door_snake_cam_ability();
}

init_hints() {
  scripts\engine\sp\utility::add_hint_string("holster_weapon", &"STPETERSBURG/HOLSTER_WEAPON", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_weapon_holstered);
  scripts\engine\sp\utility::add_hint_string("draw_weapon", &"STPETERSBURG/DRAW_WEAPON", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_holdingpistolweapon);
  scripts\engine\sp\utility::add_hint_string("draw_weapon_alt", &"STPETERSBURG/DRAW_WEAPON_ALT", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_holdingpistolweapon);
  scripts\engine\sp\utility::add_hint_string("wait_for_signal", &"STPETERSBURG/WAIT_FOR_SIGNAL", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_holdingpistolweapon);
  scripts\engine\sp\utility::add_hint_string("binoc_ads_hint", &"STPETERSBURG/STAKEOUT_BINOC_HINT");
  scripts\engine\sp\utility::add_hint_string("binoc_exit_hint", &"STPETERSBURG/STAKEOUT_BINOC_EXIT_HINT");
  scripts\engine\sp\utility::add_hint_string("weapon_ads", &"STPETERSBURG/WEAPON_ADS");
}

init_dvars() {
  setdvarifuninitialized("debug_disable_pursuit_timer", 0);
  setdvarifuninitialized("debug_disable_wander_fail", 0);
  setdvarifuninitialized("scr_price_accuracy_adjust", 1);
  setdvarifuninitialized("scr_display_temp_dialogue", 1);
}

stpetersburg_objectives() {
  if(!scripts\sp\starts::is_after_start("stakeout")) {
    scripts\engine\utility::flag_wait("flag_stakeout_camera_finished");
    var_0 = scripts\engine\utility::getStruct("obj_gear_up", "targetname");
    scripts\engine\sp\objectives::objective_add("gear_up", "current", var_0.origin, &"STPETERSBURG/OBJ_STAKEOUT_GET_WEAPON", &"STPETERSBURG/OBJ_STAKEOUT_GEAR_UP");
    level.player waittill("initial_loadout_selected");
    scripts\engine\sp\objectives::objective_complete("gear_up");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("gear_up");
    scripts\engine\sp\objectives::objective_add("follow_price_to_street_level", "current", undefined, &"STPETERSBURG/OBJ_STAKEOUT_FOLLOW_PRICE");

    while(!isDefined(level.price))
      waitframe();

    scripts\engine\sp\objectives::objective_set_on_entity("follow_price_to_street_level", "Captain Price", level.price);
    scripts\engine\sp\objectives::objective_set_z_offset("follow_price_to_street_level", 80);
  }

  if(!scripts\sp\starts::is_after_start("alley_stealth")) {
    if(!scripts\engine\sp\objectives::objective_exists("follow_price_to_street_level")) {
      scripts\engine\sp\objectives::objective_add("follow_price_to_street_level", "current", undefined, &"STPETERSBURG/OBJ_STAKEOUT_FOLLOW_PRICE");

      while(!isDefined(level.price))
        waitframe();

      scripts\engine\sp\objectives::objective_set_on_entity("follow_price_to_street_level", "Captain Price", level.price);
      scripts\engine\sp\objectives::objective_set_z_offset("follow_price_to_street_level", 80);
    }

    scripts\engine\utility::flag_wait("flag_alley_stealth_price_opening_door");
    scripts\engine\sp\objectives::objective_complete("follow_price_to_street_level");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("follow_price_to_street_level");
    scripts\engine\sp\objectives::objective_add("clear_alley", "current", undefined, &"STPETERSBURG/OBJ_ALLEY_WAIT_FOR_SIGNAL");

    while(!isDefined(level.price))
      waitframe();

    scripts\engine\sp\objectives::objective_set_on_entity("clear_alley", "Captain Price", level.price);
    scripts\engine\sp\objectives::objective_set_z_offset("clear_alley", 80);
    scripts\engine\utility::flag_wait_either("flag_alley_stealth_price_ambush_begin", "flag_alley_stealth_cover_blown");
    scripts\engine\sp\objectives::objective_update("clear_alley", "current", undefined, &"STPETERSBURG/OBJ_ALLEY_KILL_GUARDS");
    scripts\engine\utility::flag_wait("flag_alley_stealth_aq_dead");
    scripts\engine\sp\objectives::objective_complete("clear_alley");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("clear_alley");
    var_0 = scripts\engine\utility::getStruct("obj_find_butcher_1", "targetname");
    scripts\engine\sp\objectives::objective_add("find_butcher", "current", undefined, &"STPETERSBURG/OBJ_FIND_BUTCHER");
    scripts\engine\sp\objectives::objective_set_position("find_butcher", var_0.origin);
    scripts\engine\utility::flag_wait("flag_alley_stealth_player_opens_bar_door");
    var_0 = scripts\engine\utility::getStruct("obj_find_butcher_2", "targetname");
    scripts\engine\sp\objectives::objective_set_position("find_butcher", var_0.origin);
    scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
  }

  if(!scripts\sp\starts::is_after_start("bar_backroom")) {
    if(!scripts\engine\sp\objectives::objective_exists("find_butcher"))
      scripts\engine\sp\objectives::objective_add("find_butcher", "current", undefined, &"STPETERSBURG/OBJ_FIND_BUTCHER");

    var_0 = scripts\engine\utility::getStruct("obj_find_butcher_3", "targetname");
    scripts\engine\sp\objectives::objective_set_position("find_butcher", var_0.origin);
    scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_half", "flag_backroom_player_seen_standing");
    scripts\engine\sp\objectives::objective_complete("find_butcher");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("find_butcher");
    scripts\engine\sp\objectives::objective_add("chase_butcher", "current", undefined, &"STPETERSBURG/OBJ_CHASE_BUTCHER", &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER");
  }

  if(!scripts\sp\starts::is_after_start("bar_shootout")) {
    if(!scripts\engine\sp\objectives::objective_exists("chase_butcher"))
      scripts\engine\sp\objectives::objective_add("chase_butcher", "current", undefined, &"STPETERSBURG/OBJ_CHASE_BUTCHER", &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER");

    waitframe();
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "obj_chase_enforcer_1", "obj_chase_enforcer_1_complete");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "obj_chase_enforcer_2", "obj_chase_enforcer_2_complete");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "obj_chase_enforcer_3", "obj_chase_enforcer_3_complete");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "obj_chase_enforcer_4", "obj_chase_enforcer_4_complete");
    scripts\engine\utility::flag_wait("flag_bar_street_end");
  }

  if(!scripts\sp\starts::is_after_start("apartment")) {
    if(!scripts\engine\sp\objectives::objective_exists("chase_butcher"))
      scripts\engine\sp\objectives::objective_add("chase_butcher", "current", undefined, &"STPETERSBURG/OBJ_CHASE_BUTCHER", &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER");

    waitframe();
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "fallback_apartment_entrance", "fallback_end_apartment_entrance");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "fallback_apartment_door", "fallback_end_apartment_door");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "fallback_apartment_exit", "fallback_end_apartment_exit");
  }

  if(!scripts\sp\starts::is_after_start("canal")) {
    if(!scripts\engine\sp\objectives::objective_exists("chase_butcher"))
      scripts\engine\sp\objectives::objective_add("chase_butcher", "current", undefined, &"STPETERSBURG/OBJ_CHASE_BUTCHER", &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER");

    waitframe();
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "fallback_canal_bridge", "fallback_canal_bridge_end");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "fallback_canal_street", "fallback_canal_street_end");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "fallback_canal_gate", "fallback_canal_gate_end");
  }

  if(!scripts\sp\starts::is_after_start("acquire")) {
    if(!scripts\engine\sp\objectives::objective_exists("chase_butcher"))
      scripts\engine\sp\objectives::objective_add("chase_butcher", "current", undefined, &"STPETERSBURG/OBJ_CHASE_BUTCHER", &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER");

    waitframe();
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "fallback_acquire_corner", "fallback_acquire_corner_end");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "fallback_acquire_exit", "fallback_acquire_exit_end");
    scripts\engine\utility::flag_wait("flag_acquire_complete");
  }

  if(!scripts\sp\starts::is_after_start("evade")) {
    if(!scripts\engine\sp\objectives::objective_exists("chase_butcher"))
      scripts\engine\sp\objectives::objective_add("chase_butcher", "current", undefined, &"STPETERSBURG/OBJ_CHASE_BUTCHER", &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER");

    waitframe();
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "obj_recover_enforcer_1", "obj_recover_enforcer_1_complete");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::objective_enforcer_los("chase_butcher", "obj_recover_enforcer_2", "obj_recover_enforcer_2_complete");
  }

  if(!scripts\sp\starts::is_after_start("gauntlet")) {
    if(!scripts\engine\sp\objectives::objective_exists("chase_butcher"))
      scripts\engine\sp\objectives::objective_add("chase_butcher", "current", undefined, &"STPETERSBURG/OBJ_CHASE_BUTCHER", &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER");

    scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
    level notify("objective_enforcer_los_end");
    scripts\engine\sp\objectives::objective_complete("chase_butcher");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("chase_butcher");

    if(!scripts\engine\sp\objectives::objective_exists("recover_butcher"))
      scripts\engine\sp\objectives::objective_add("recover_butcher", "current", undefined, &"STPETERSBURG/OBJ_RECOVER_BUTCHER", &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER");

    scripts\engine\sp\objectives::objective_remove_all_locations("recover_butcher");
    scripts\engine\sp\objectives::objective_set_on_entity("recover_butcher", &"STPETERSBURG/OBJ_ICON_NAME_BUTCHER", level.enforcer);
    scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_recovered");
    scripts\engine\sp\objectives::objective_complete("recover_butcher");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("recover_butcher");
    scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_recovered");
    var_1 = getEnt("van_weapon_spot", "targetname");
    scripts\engine\sp\objectives::objective_add("get_in_van", "current", var_1.origin, &"STPETERSBURG/OBJ_GET_IN_VAN");
    scripts\engine\utility::flag_wait("flag_gauntlet_player_in_van");
    scripts\engine\sp\objectives::objective_complete("get_in_van");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("get_in_van");
  }

  if(!scripts\sp\starts::is_after_start("gauntlet_shootout")) {
    scripts\engine\utility::flag_wait("flag_gauntlet_enemies_spawn");
    scripts\engine\sp\objectives::objective_add("defend_van", "current", undefined, &"STPETERSBURG/OBJ_DEFEND_VAN");
    scripts\engine\utility::flag_wait("flag_gauntlet_battle_over");
    scripts\engine\sp\objectives::objective_complete("defend_van");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("defend_van");
  }

  if(!scripts\sp\starts::is_after_start("interrogation_intro")) {
    scripts\engine\utility::flag_wait("van_retrieve_package");
    scripts\engine\sp\objectives::objective_add("retrieve_package", "current", undefined, &"STPETERSBURG/OBJ_INTERROGATION_MEET_NIKOLAI", &"STPETERSBURG/OBJ_INTERROGATION_RETRIEVE_PACKAGE");
    scripts\engine\sp\objectives::objective_set_on_entity("retrieve_package", undefined, level.nikolaivan);
    scripts\engine\sp\objectives::objective_set_z_offset("retrieve_package", 64);
    scripts\engine\utility::flag_wait("van_interact_available");
    scripts\engine\utility::flag_waitopen("van_interact_available");
    wait 2;
    scripts\engine\sp\objectives::objective_complete("retrieve_package");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("retrieve_package");
    scripts\engine\sp\objectives::objective_add("escort_family", "current", undefined, &"STPETERSBURG/OBJ_INTERROGATION_ESCORT_PACKAGE");
    scripts\engine\sp\objectives::objective_set_on_entity("escort_family", undefined, level.enforcerson);
    scripts\engine\sp\objectives::objective_set_z_offset("escort_family", 64);
    scripts\engine\utility::flag_waitopen("van_retrieve_package");
    scripts\engine\sp\objectives::objective_complete("escort_family");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("escort_family");
    scripts\engine\sp\objectives::objective_add("rendezvous_price", "current", level.interrogationdoor.origin + (25, 0, 50), &"STPETERSBURG/OBJ_INTERROGATION_RETURN_TO_PRICE");
    scripts\engine\utility::flag_wait_any("warning_accepted", "warning_declined");
    scripts\engine\sp\objectives::objective_complete("rendezvous_price");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("rendezvous_price");

    if(!scripts\engine\utility::flag("warning_declined")) {
      scripts\engine\sp\objectives::objective_add("begin_interrogation", "current", undefined, &"STPETERSBURG/OBJ_INTERROGATION_DELIVER_PACKAGE");
      scripts\engine\sp\objectives::objective_set_on_entity("begin_interrogation", undefined, level.yegor);
      scripts\engine\sp\objectives::objective_set_z_offset("begin_interrogation", 50);
      scripts\engine\utility::flag_wait("interrogation_escort_done");
      scripts\engine\sp\objectives::objective_complete("begin_interrogation");
      waitframe();
      scripts\engine\sp\objectives::objective_remove("begin_interrogation");
    }
  }

  if(!scripts\sp\starts::is_after_start("interrogation_room") && !scripts\engine\utility::flag("warning_declined")) {
    var_2 = scripts\engine\utility::flag_wait_any_return("revolver_offered", "revolver_picked_up");

    if(var_2 == "revolver_offered") {
      var_3 = getEnt("revolver", "targetname");

      if(isDefined(var_3))
        scripts\engine\sp\objectives::objective_add("pick_up_revolver", "current", var_3 gettagorigin("j_trigger") + (0, 0, 7), &"STPETERSBURG/OBJ_INTERROGATION_TAKE_REVOLVER");
    }

    scripts\engine\utility::flag_wait("revolver_picked_up");

    if(scripts\engine\sp\objectives::objective_exists("pick_up_revolver")) {
      scripts\engine\sp\objectives::objective_complete("pick_up_revolver");
      waitframe();
      scripts\engine\sp\objectives::objective_remove("pick_up_revolver");
    }
  }

  if(!scripts\sp\starts::is_after_start("interrogation_revolver") && !scripts\engine\utility::flag("warning_declined")) {
    scripts\engine\sp\objectives::objective_add("retrieve_intel", "current", undefined, &"STPETERSBURG/OBJ_INTERROGATION_RETRIEVE_INTEL");
    scripts\engine\utility::flag_wait("bullets_offered");
    var_4 = getEntArray("bullets", "targetname")[0];
    scripts\engine\sp\objectives::objective_update("retrieve_intel", "active");
    scripts\engine\sp\objectives::objective_add("load_bullets", "current", var_4.origin + (0, 0, 10), &"STPETERSBURG/OBJ_INTERROGATION_LOAD_BULLETS");
    scripts\engine\utility::flag_waitopen("bullets_offered");
    scripts\engine\sp\objectives::objective_complete("load_bullets");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("load_bullets");
    scripts\engine\sp\objectives::objective_update("retrieve_intel", "current");
    scripts\engine\utility::flag_wait("intel_revealed");
    scripts\engine\sp\objectives::objective_complete("retrieve_intel");
    waitframe();
    scripts\engine\sp\objectives::objective_remove("retrieve_intel");
  }

  wait 5;
  scripts\engine\sp\objectives::objective_add("interrogation_end", "current", undefined, &"STPETERSBURG/OBJ_STAKEOUT_FOLLOW_PRICE");
  scripts\engine\sp\objectives::objective_set_on_entity("interrogation_end", undefined, level.price);
  scripts\engine\sp\objectives::objective_set_z_offset("interrogation_end", 70);
  scripts\engine\utility::flag_wait("interrogation_end");
  scripts\engine\sp\objectives::objective_complete("interrogation_end");
}

stakeout_intro_start() {
  setDvar("stp_intro_cinematic", 1);
}

audio_stp_intro_amb() {
  level.player setclienttriggeraudiozonepartialwithfade("stp_intro_flyin", 0.5, "mix", "ambient");
  scripts\engine\utility::flag_wait("flag_stakeout_camera_finished");
  level.player clearclienttriggeraudiozone(2.0);
}

stakeout_start() {
  setDvar("stp_intro_cinematic", 0);
  scripts\engine\utility::flag_set("flag_stakeout_camera_finished");
}

stakeout_stp_main() {
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 0.05);
  thread audio_music_start_st_pete();
  thread audio_stp_intro_amb();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::transient_waittill("flag_stakeout_nikolai_closed_door", undefined, "stpetersburg_alley_script_tr");
  setsaveddvar("TLOLRMSL", 0.01);
  set_player_health_fragile();
  scripts\engine\sp\utility::set_start_location("intro_stakeout", [level.player]);
  level.price = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_named_ai("price", "Captain Price", "start_intro_stakeout_price", undefined, "casual");
  thread scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::intro_stakeout_main();
  setup_price_silenced_pistol();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::trigger_safe_function("bar_street_triggers", "script_noteworthy", "disable");
  scripts\engine\utility::flag_wait("flag_stakeout_end");
}

audio_music_start_st_pete() {
  wait 0.5;
  setmusicstate("mx_stpete_tmp_intro");
}

stakeout_catchup() {
  setsaveddvar("TLOLRMSL", 0.01);
  scripts\engine\utility::flag_set("flag_stealth_start_patrols_1");
  scripts\engine\utility::flag_set("flag_alley_stealth_price_at_door");
  scripts\engine\utility::delaythread(0.05, scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::intro_stakeout_swap_butcher_vehicle);

  if(!isDefined(level.nikolai))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::spawn_nikolai();

  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::holster_logic();
}

alley_stealth_start() {
  var_0 = getEntArray("bar_street_triggers", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 scripts\engine\utility::trigger_off();

  set_player_health_fragile();
  scripts\engine\sp\utility::set_start_location("alley_stealth", [level.player]);
  level.price = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_named_ai("price", "Captain Price", "start_alley_stealth_price", "price_start_alley_stealth_colors", "cqb");
  setup_player_silenced_pistol();
  thread alley_stealth_start_delayed();
  thread scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::alley_stealth_start_function();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vig_script_street_intro.gsc::vig_street_intro_start();
  scripts\engine\utility::flag_set("flag_start_alley_containment");
  scripts\engine\utility::flag_set("flag_stakeout_enforcer_left_alley");
}

alley_stealth_start_delayed() {
  while(level.player.currentweapon.basename != "iw8_pi_papa320")
    waitframe();

  level.player notify("actionslot 1");
}

alley_stealth_stp_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::alley_stealth_main();
  setup_price_silenced_pistol();
  scripts\engine\sp\utility::autosave_or_timeout("alley_stealth_start", 3);
  scripts\engine\utility::flag_wait("flag_backroom_player_downstairs");
}

alley_stealth_catchup() {
  scripts\engine\utility::flag_set("flag_backroom_player_downstairs");
}

bar_backroom_start() {
  set_player_health_semifragile();
  scripts\engine\sp\utility::set_start_location("stpetersburg_bar_backroom", [level.player]);
  level.price = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_named_ai("price", "Captain Price", "start_bar_backroom_price", "price_checkpoint_bar_backroom_colors", "cqb");
  setup_player_silenced_pistol();
  waitframe();
  scripts\engine\utility::flag_set("flag_start_bar_backroom_containment");
}

bar_backroom_stp_main() {
  setsaveddvar("TLOLRMSL", 1);
  set_player_health_semifragile();
  setup_price_silenced_pistol();
  thread scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::bar_price_handler();
  thread scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::bar_shootout_door_handler();
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::bar_backroom_main();
  scripts\engine\sp\utility::autosave_or_timeout("bar_backroom_start", 3);
  scripts\engine\utility::flag_wait("flag_player_exit_back_room");
}

bar_backroom_catchup() {
  setsaveddvar("TLOLRMSL", 1);
  scripts\engine\utility::flag_set("flag_player_exit_back_room");
}

bar_shootout_start() {
  scripts\engine\sp\utility::set_start_location("stpetersburg_bar_shootout", [level.player]);
  level.price = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_named_ai("price", "Captain Price", "start_bar_shootout_price_alt");
  setsaveddvar("NQNQPRLRQM", 0.15);
  set_player_health_semifragile();
  setup_player_silenced_pistol();
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::bar_shootout_main();
  waitframe();
  scripts\engine\utility::flag_set("flag_start_bar_backroom_containment");
}

bar_shootout_stp_main() {
  setup_price_smg();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_reset_fake_health();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::trigger_safe_function("bar_street_triggers", "script_noteworthy", "enable");
  scripts\engine\utility::flag_wait("flag_player_exit_club");
}

bar_shootout_catchup() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::trigger_safe_function("bar_street_triggers", "script_noteworthy", "enable");
  thread reduce_friendlyfire_penalties();
}

bar_street_start() {
  set_player_health_semifragile();
  scripts\engine\sp\utility::set_start_location("stpetersburg_bar_street", [level.player]);
  level.price = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_named_ai("price", "Captain Price", "start_bar_street_price", "price_checkpoint_bar_street_alt_colors");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::spawn_enforcer("node_enforcer_alley");
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::bar_street_enforcer_spawn();
  setup_player_ar();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vignette_alleys.gsc::spawn_traffic();
  thread scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::bar_street_main();
  waitframe();
  scripts\engine\utility::flag_set("flag_start_bar_street_containment");
}

bar_street_stp_main() {
  setsaveddvar("TLOLRMSL", 0.01);
  setsaveddvar("NQNQPRLRQM", 1);
  thread reduce_friendlyfire_penalties();
  setup_price_smg();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_reset_fake_health();
  thread walla_bar_street();
  scripts\engine\utility::flag_wait("flag_bar_street_end");
}

walla_bar_street() {
  wait 0.1;
  var_0 = spawn("script_origin", (1542, -2375, 106));
  var_0 playSound("stp_walla_alley_civs_grp_01");
  var_0 moveTo((2273, -2399, 106), 4);
  wait 3;
  var_1 = spawn("script_origin", (1504, -2258, 114));
  var_1 playSound("stp_walla_alley_civs_couple_01", "sounddone");
  var_1 moveTo((1864, -2224, 114), 4);
  var_1 waittill("sounddone");
  var_1 playSound("stp_walla_alley_civs_female_react");
  wait 4;
  var_0 delete();
  var_1 delete();
}

bar_street_catchup() {
  setsaveddvar("TLOLRMSL", 0.01);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::trigger_safe_function("bar_street_triggers", "script_noteworthy", "disable");
}

apartment_start() {
  set_player_health_semifragile();
  scripts\engine\sp\utility::set_start_location("start_stpetersburg_apartment_player", [level.player]);
  level.price = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_named_ai("price", "Captain Price", "start_stpetersburg_apartment_price");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::spawn_enforcer("start_petersburg_apartment_enforcer");
  thread apartment_enforcer_enter_apt();
  setup_player_ar();
  scripts\engine\utility::flag_set("flag_traffic_on");
  scripts\engine\utility::flag_set("lighting_alley_to_apartments");
  waitframe();
  scripts\engine\utility::flag_set("flag_start_bar_street_containment");
}

apartment_stp_main() {
  setup_price_smg();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_reset_fake_health();
  scripts\engine\sp\utility::autosave_or_timeout("apartment_start", 3);
  scripts\engine\utility::flag_set("lighting_alley_to_apartments");
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_apartment.gsc::apartment_main();
}

apartment_catchup() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_gameplay_apartment.gsc::delete_scriptables_in_bar();
  setsaveddvar("TLOLRMSL", 1);
  scripts\engine\utility::flag_set("flag_apartment_enforcer_stairs_vignette");
  scripts\engine\utility::flag_set("flag_canal_enforcer_on_bridge");
  scripts\engine\utility::flag_set("flag_canal_player_jump_down");
  scripts\engine\utility::flag_set("flag_apartment_player_done_speaking");
}

canal_start() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::spawn_enforcer("start_petersburg_canal_enforcer");
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  set_player_health_semifragile();
  scripts\engine\sp\utility::set_start_location("start_stpetersburg_canal_player", [level.player]);
  level.price = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_named_ai("price", "Captain Price", "start_stpetersburg_canal_price");
  setup_player_ar();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vig_script_canal.gsc::canal_vig_start();
  waitframe();
  scripts\engine\utility::flag_set("flag_start_canal_containment");
  scripts\engine\utility::flag_set("flag_apartment_grenade_explosion");
  scripts\engine\utility::flag_set("flag_apartment_grenade_aftermath");
}

canal_stp_main() {
  setsaveddvar("TLOLRMSL", 0.01);
  setup_price_smg();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_reset_fake_health();
  scripts\engine\sp\utility::autosave_or_timeout("canal_start", 3);
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_canal.gsc::canal_main();
}

canal_catchup() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_gameplay_canal.gsc::disable_canal_trigs();
  setsaveddvar("TLOLRMSL", 0.01);
}

acquire_start() {
  scripts\engine\sp\utility::set_start_location("start_stpetersburg_acquire_player", [level.player]);
  level.price = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_named_ai("price", "Captain Price", "start_stpetersburg_acquire_price");
  set_player_health_semifragile();
  setup_player_ar();
  scripts\engine\utility::flag_set("flag_canal_enforcer_in_alley");
}

acquire_stp_main() {
  setDvar("stp_interrogation_escort", 0);
  setup_price_smg();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_reset_fake_health();
  scripts\engine\sp\utility::autosave_or_timeout("acquire_start", 3);
  scripts\engine\utility::flag_set("flag_start_acquire_containment");
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_acquire.gsc::acquire_main();
}

acquire_catchup() {}

evade_start() {
  setDvar("stp_interrogation_escort", 0);
  set_player_health_semifragile();
  scripts\engine\sp\utility::set_start_location("start_stpetersburg_evade_player", [level.player]);
  level.price = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_named_ai("price", "Captain Price", "start_stpetersburg_evade_price");
  setup_player_ar();
  var_0 = getnode("enforcer_evade_teleport_node", "targetname");
  scripts\engine\utility::flag_set("flag_start_escort_containment");
}

evade_stp_main() {
  setsaveddvar("TLOLRMSL", 1);
  setup_price_smg();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_reset_fake_health();
  scripts\engine\sp\utility::autosave_or_timeout("evade_start", 3);
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_escort.gsc::evade_main();
}

evade_catchup() {
  setsaveddvar("TLOLRMSL", 1);
  thread reset_friendlyfire_penalties();
  scripts\engine\utility::flag_set("flag_evade_police_window_vig");
  scripts\engine\utility::flag_set("flag_evade_exit_cafe");
}

gauntlet_start() {
  scripts\engine\sp\utility::set_start_location("start_stpetersburg_gauntlet_player", [level.player]);
  level.price = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_named_ai("price", "Captain Price", "start_stpetersburg_gauntlet_price", "gauntlet_price_colors_1");
  setup_price_smg();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::spawn_enforcer("evade_enforcer_flee_node");
  setup_player_ar();
  waitframe();
  scripts\engine\utility::flag_set("flag_gauntlet_enforcer_hit_vig");
}

gauntlet_stp_main() {
  level.autosave_threat_check_enabled = 1;
  scripts\engine\sp\utility::autosave_or_timeout("gauntlet_start", 6);
  scripts\engine\utility::flag_set("flag_start_escort_containment");
  thread reset_friendlyfire_penalties();
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_gauntlet.gsc::gauntlet_main();
}

gauntlet_catchup() {
  setsaveddvar("TLOLRMSL", 0.01);
  level.autosave_threat_check_enabled = 1;
}

gauntlet_shootout_start() {
  level.price = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_named_ai("price", "Captain Price", "start_stpetersburg_gauntlet_price");
  setup_price_smg();
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_gauntlet.gsc::gauntlet_shootout_setup_van();
  waitframe();
  scripts\engine\sp\utility::set_start_location("start_gauntlet_shootout_player", [level.player]);
  setup_player_ar();
  var_0 = getEnt("civ_gauntlet_react_2", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  scripts\engine\utility::flag_set("flag_gauntlet_player_in_van");
}

gauntlet_shootout_stp_main() {
  level.autosave_threat_check_enabled = 1;
  scripts\engine\sp\utility::autosave_or_timeout("gauntlet_shootout_start", 3);
  set_player_health_standard();
  scripts\sp\maps\stpetersburg\stpetersburg_gameplay_gauntlet.gsc::gauntlet_shootout_main();
  setDvar("stp_interrogation_phase", 0);
}

gauntlet_shootout_catchup() {
  level.autosave_threat_check_enabled = 1;
}

interrogation_cine_start() {
  setDvar("stp_interrogation_phase", 0);
}

interrogation_intro_start() {
  setDvar("stp_interrogation_phase", 1);
}

interrogation_room_start() {
  setDvar("stp_interrogation_phase", 2);
  level.player allowmelee(0);
}

interrogation_revolver_start() {
  setDvar("stp_interrogation_phase", 3);
}

interrogation_stp_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::mus_intro_torture();

  if(!isDefined(level.blackoverlay))
    level.blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 1);

  scripts\engine\utility::flag_set("lighting_interrogation");
  interrogation_actor_setup();
  level.player allowmovement(0);
  var_0 = [level.price, level.enforcer, level.nikolai];
  scripts\engine\sp\utility::set_start_location("interrogation_start", var_0);
  var_1 = scripts\engine\utility::ter_op(getdvarint("stp_interrogation_phase") < 2, "interrogation_intro_start", "interrogation_start");
  scripts\engine\sp\utility::set_start_location(var_1, [level.player]);
  scripts\sp\maps\stpetersburg\stpetersburg_interrogation.gsc::interrogation_main();
}

interrogation_actor_setup() {
  if(isDefined(level.enforcer))
    level.enforcer delete();

  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::spawn_enforcer();

  if(!isDefined(level.price))
    level.price = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_named_ai("price", "Captain Price", undefined, undefined, "casual_gun");

  if(!isDefined(level.nikolai))
    level.nikolai = scripts\engine\sp\utility::spawn_targetname("nikolai", 1);

  if(isDefined(level.nikolai.og_name))
    level.nikolai scripts\engine\sp\utility::name_show();

  if(!isDefined(level.yegor))
    level.yegor = scripts\engine\sp\utility::spawn_targetname("yegor", 1);
}

setup_player_silenced_pistol() {
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_papa320", ["silencerpstl_west01", "reflex_west01_pstl"]);
  level.player giveweapon(var_0, 0, 0, 0, 1);
  level.player givemaxammo(var_0);
  level.player switchtoweaponimmediate(var_0);
  level.player.initial_loadout_weapon = var_0;
}

setup_player_ar() {
  var_0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["reflexstable_west01"]);
  level.player giveweapon(var_0, 0, 0, 0, 1);
  level.player givemaxammo(var_0);
  level.player switchtoweaponimmediate(var_0);
}

setup_price_silenced_pistol() {
  if(isDefined(level.price.silenced_pistol)) {
    return;
  }
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_papa320", ["silencerpstl_west01"]);
  level.price.silenced_pistol = var_0;
  level.price scripts\anim\shared.gsc::forceuseweapon(var_0, "sidearm");
}

setup_price_smg() {
  if(isDefined(level.price.smg)) {
    return;
  }
  var_0 = scripts\sp\utility::make_weapon("iw8_sm_mpapa7", ["reflex_west01", "back_mpapa7"]);
  level.price.smg = var_0;
  level.price scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
  level.price.no_pistol_switch = 1;
  level.price.disablepistol = 1;
}

reduce_friendlyfire_penalties() {
  level.orig_max_participation = level.friendlyfire["max_participation"];
  level.orig_player_participation = level.player.participation;
  level.friendlyfire["max_participation"] = level.friendlyfire["friend_kill_points"] * -2;
  level.player.participation = level.friendlyfire["friend_kill_points"] * -2;
}

reset_friendlyfire_penalties() {
  if(isDefined(level.orig_max_participation))
    level.friendlyfire["max_participation"] = level.orig_max_participation;

  if(isDefined(level.orig_player_participation))
    level.player.participation = level.orig_player_participation;
}

set_player_health_fragile() {
  level.player scripts\sp\player::scale_player_death_shield_duration(0.5);
  level.player scripts\sp\player::set_player_max_health(80);
}

set_player_health_semifragile() {
  level.player scripts\sp\player::scale_player_death_shield_duration(0.75);
  level.player scripts\sp\player::set_player_max_health(90);
}

set_player_health_standard() {
  level.player scripts\sp\player::scale_player_death_shield_duration(1);
  level.player scripts\sp\player::set_player_max_health(100);
}

null_catchup() {}

apartment_enforcer_enter_apt() {
  level.enforcer endon("death");
  var_0 = getnode("apartment_stairs_blindfire_position", "targetname");
  level.enforcer scripts\engine\sp\utility::set_goal_radius(16);
  level.enforcer scripts\engine\sp\utility::set_goal_node(var_0);
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  level.enforcer waittill("goal");
  scripts\engine\utility::flag_set("flag_bar_street_enforcer_in_apt");
}