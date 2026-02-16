/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_interactions.gsc
************************************************************/

register_interactions() {
  registerweaponinteractions();
  level.interaction_hintstrings["debris_350"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1000"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1500"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_2000"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_2500"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1250"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_750"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["team_door_switch"] = &"CP_TOWN_INTERACTIONS_TEAM_DOOR_SWITCH";
  level.interaction_hintstrings["power_door_sliding"] = &"COOP_INTERACTIONS_REQUIRES_POWER";
  level.interaction_hintstrings["weapon_upgrade"] = &"CP_TOWN_INTERACTIONS_UPGRADE_WEAPON";
  level.interaction_hintstrings["crank"] = &"CP_TOWN_INTERACTIONS_PICKUP_CRANK";
  level.interaction_hintstrings["front_barrel"] = &"CP_TOWN_INTERACTIONS_PICKUP_GRIP";
  level.interaction_hintstrings["plunger"] = &"CP_TOWN_INTERACTIONS_PICKUP_PLUNGER";
  scripts\cp\cp_interaction::register_interaction("debris_350", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 350);
  scripts\cp\cp_interaction::register_interaction("debris_1000", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 1000);
  scripts\cp\cp_interaction::register_interaction("debris_1500", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 1500);
  scripts\cp\cp_interaction::register_interaction("debris_2000", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 2000);
  scripts\cp\cp_interaction::register_interaction("debris_2500", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 2500);
  scripts\cp\cp_interaction::register_interaction("debris_1250", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 1250);
  scripts\cp\cp_interaction::register_interaction("debris_750", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::clear_debris, 750);
  scripts\cp\cp_interaction::register_interaction("team_door_switch", "door_buy", undefined, undefined, scripts\cp\zombies\interaction_openareas::use_team_door_switch, 250);
  scripts\cp\cp_interaction::register_interaction("power_door_sliding", "door_buy", undefined, undefined, undefined, 0, 1, ::init_sliding_power_doors);
  scripts\cp\cp_interaction::register_interaction("weapon_upgrade", "pap", undefined, scripts\cp\maps\cp_town\cp_town_weapon_upgrade::weapon_upgrade_hint_func, scripts\cp\maps\cp_town\cp_town_weapon_upgrade::weapon_upgrade, 5000, 1, scripts\cp\maps\cp_town\cp_town_weapon_upgrade::init_weapon_upgrade);
  town_register_interaction(1, "pap_fuse_switch", undefined, undefined, ::papfuseswitchhint, ::usepapfuseswitch, 0, 0);
  town_register_interaction(1, "fast_travel_panel_bridge", undefined, undefined, ::blankhintfunc, ::blankusefunc, 0, 0);
  town_register_interaction(1, "generator_field_center", undefined, undefined, ::generator_field_hint, ::usegeneratorfieldcenter, 0, 0);
  town_register_interaction(1, "pap_early_exit", undefined, undefined, ::blankhintfunc, ::papearlyexituse, 0, 0);
  town_register_interaction(1, "pap_fusebox", undefined, undefined, ::blankhintfunc, ::pickupfuse, 0, 0, ::init_papfusebox);
  town_register_interaction(1, "fast_travel_panel", undefined, undefined, ::papanomalyhint, ::usepapanomaly, 0, 0, ::init_papanomaly);
  town_register_interaction(1, "cutie", undefined, undefined, ::blankhintfunc, ::usecutiepickup, 0, 0);
  town_register_interaction(1, "crank", undefined, undefined, ::cutie_hint_func, ::addcutieattachment, 0, 0);
  town_register_interaction(1, "front_barrel", undefined, undefined, ::cutie_hint_func, ::addcutieattachment, 0, 0);
  town_register_interaction(1, "plunger", undefined, undefined, ::cutie_hint_func, ::addcutieattachment, 0, 0);
  town_register_interaction(1, "plunger_ammo", undefined, undefined, ::cutieammohintfunc, ::useplungerammo, 0, 0);
  level thread setup_additional_cutie_ammo();
  town_register_interaction(0, "technicolor_machine", undefined, undefined, ::tcs_hint, ::usetcs, 0, 0, ::init_tcs);
  town_register_interaction(1, "missing_handle", undefined, undefined, ::missinghandlehint, ::usemissinghandle, 0, 0, ::missinghandleinit);
  town_register_interaction(0, "generator_broken", undefined, undefined, ::brokengeneratorhint, ::usebrokengenerator, 0, 0);
  town_register_interaction(1, "pillage_item", undefined, undefined, scripts\cp\zombies\zombies_pillage::pillage_hint_func, scripts\cp\zombies\zombies_pillage::player_used_pillage_spot, 0, 0);
  town_register_interaction(1, "town_fast_travel", undefined, undefined, ::fast_travel_hint, ::fast_travel_use, 0, 0, ::fast_travel_init);
  town_register_interaction(1, "hidden_song_record", undefined, undefined, ::blankhintfunc, ::record_use_logic, 0, 0, ::show_record_debug);
  town_register_interaction(1, "hidden_song_jukebox", undefined, undefined, ::jukebox_interaction_hint, ::jukebox_use_func, 0, 0);
  scripts\engine\utility::flag_init("queue_hidden_song");
  scripts\engine\utility::flag_init("hidden_song_ended");
  town_register_interaction(0, "figure_1", undefined, undefined, scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_hint, scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_func, 0, 0, scripts\cp\maps\cp_town\cp_town_ghost_activation::init_fig1);
  town_register_interaction(0, "figure_2", undefined, undefined, scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_hint, scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_func, 0, 0, scripts\cp\maps\cp_town\cp_town_ghost_activation::init_fig2);
  town_register_interaction(0, "figure_3", undefined, undefined, scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_hint, scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_func, 0, 0, scripts\cp\maps\cp_town\cp_town_ghost_activation::init_fig3);
  town_register_interaction(0, "figure_4", undefined, undefined, scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_hint, scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_func, 0, 0, scripts\cp\maps\cp_town\cp_town_ghost_activation::init_fig4);
  town_register_interaction(1, "backstory_interaction", undefined, undefined, ::backstory_hint_func, ::backstory_activation, 0, 0, ::init_backstory_interaction, undefined);
  town_register_interaction(0, "debug_crab_boss", undefined, undefined, ::blankhintfunc, scripts\cp\maps\cp_town\cp_town_crab_boss_fight::usecrabbossdebug, 0, 0);
  registeratminteractions();
  register_afterlife_games();
  register_crab_boss_interactions();
  scripts\cp\maps\cp_town\cp_town_traps::register_traps();
  scripts\cp\maps\cp_town\cp_town_crafting::register_crafting();
  scripts\cp\maps\cp_town\cp_town_mpq::init_mpq_interactions();
  scripts\cp\maps\cp_town\cp_town_ghost_activation::init_skullbusters_interactions();
  scripts\engine\utility::flag_set("interactions_initialized");
  scripts\cp\maps\cp_town\cp_town_elvira::register_elvira_interactions();
  if(isDefined(level.escape_interaction_registration_func)) {
    [[level.escape_interaction_registration_func]]();
  }
}

backstory_activation(var_0, var_1) {
  var_1 endon("disconnect");
  if(!isDefined(var_1.completed_aliases_for_backstory_achievement)) {
    var_1.completed_aliases_for_backstory_achievement = [];
  }

  if(var_1.vo_prefix == "p5_") {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.playing_backstory)) {
    return;
  }

  level.pause_nag_vo = 1;
  var_2 = "";
  scripts\cp\cp_vo::func_C9CB([var_1]);
  var_2 = get_random_alias(var_0, var_1);
  if(var_2 != "" && !scripts\engine\utility::array_contains(var_1.completed_aliases_for_backstory_achievement, var_2)) {
    var_3 = strtok(var_2, "_");
    if(var_3[2] == "sally" || var_3[2] == "andre" || var_3[2] == "aj" || var_3[2] == "pdex") {
      switch (var_1.vo_prefix) {
        case "p1_":
          var_2 = "ww_diary_sally_" + var_3[3];
          break;

        case "p2_":
          var_2 = "ww_diary_pdex_" + var_3[3];
          break;

        case "p3_":
          var_2 = "ww_diary_andre_" + var_3[3];
          break;

        case "p4_":
          var_2 = "ww_diary_aj_" + var_3[3];
          break;

        default:
          break;
      }

      var_0.array_of_aliases = scripts\engine\utility::array_remove(var_0.array_of_aliases, var_2);
    }

    var_1 playlocalsound(var_2);
    var_1.playing_backstory = 1;
    if(!scripts\engine\utility::array_contains(var_1.completed_aliases_for_backstory_achievement, var_2)) {
      var_1.completed_aliases_for_backstory_achievement[var_1.completed_aliases_for_backstory_achievement.size] = var_2;
    }

    if(!scripts\engine\utility::istrue(level.defeated_crogboss)) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
    }

    var_1 scripts\cp\cp_interaction::refresh_interaction();
    wait(scripts\cp\cp_vo::get_sound_length(var_2));
    var_1.playing_backstory = undefined;
    var_1.played_backstory_vo = 1;
  }

  if(var_1.completed_aliases_for_backstory_achievement.size >= 9) {
    var_1 scripts\cp\zombies\achievement::update_achievement("DEAR_DIARY", 1);
  }

  scripts\cp\cp_vo::func_12BE3([var_1]);
  level.pause_nag_vo = 0;
}

get_random_alias(var_0, var_1) {
  while(var_1.completed_aliases_for_backstory_achievement.size < 9) {
    var_2 = scripts\engine\utility::random(var_0.array_of_aliases);
    var_3 = strtok(var_2, "_");
    if(var_3[2] == "sally" || var_3[2] == "andre" || var_3[2] == "aj" || var_3[2] == "pdex") {
      switch (var_1.vo_prefix) {
        case "p1_":
          if(var_3[2] != "sally") {
            scripts\engine\utility::waitframe();
            break;
          }
          break;

        case "p2_":
          if(var_3[2] != "pdex") {
            scripts\engine\utility::waitframe();
            break;
          }
          break;

        case "p3_":
          if(var_3[2] != "andre") {
            scripts\engine\utility::waitframe();
            break;
          }
          break;

        case "p4_":
          if(var_3[2] != "aj") {
            scripts\engine\utility::waitframe();
            break;
          }
          break;
      }
    }

    if(scripts\engine\utility::array_contains(var_1.completed_aliases_for_backstory_achievement, var_2)) {
      scripts\engine\utility::waitframe();
      continue;
    } else {
      return var_2;
    }

    scripts\engine\utility::waitframe();
  }
}

backstory_hint_func(var_0, var_1) {
  return "";
}

init_backstory_interaction() {
  var_0 = scripts\engine\utility::getStructArray("backstory_interaction", "script_noteworthy");
  foreach(var_4, var_2 in var_0) {
    var_3 = undefined;
    switch (var_2.name) {
      case "backstory_interaction":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("cp_town_willard_book");
        var_3.angles = var_2.angles;
        var_2.array_of_aliases = ["ww_diary_sally_1", "ww_diary_sally_2", "ww_diary_sally_3", "ww_diary_aj_1", "ww_diary_aj_2", "ww_diary_aj_3", "ww_diary_andre_1", "ww_diary_andre_2", "ww_diary_andre_3", "ww_diary_pdex_1", "ww_diary_pdex_2", "ww_diary_pdex_3", "ww_diary_orig4_1", "ww_diary_orig4_2", "ww_diary_winona_1", "ww_diary_alexandra_1", "ww_diary_willard_1", "ww_diary_willard_2"];
        break;

      default:
        break;
    }

    if(isDefined(var_3)) {
      var_2.model = var_3;
    }

    level.backstory_interactions[var_4] = var_2;
  }
}

init_sliding_power_doors() {
  var_0 = scripts\engine\utility::getStructArray("power_door_sliding", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread sliding_power_door();
  }
}

sliding_power_door() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any("power_on", self.power_area + " power_on");
  }

  self.powered_on = 1;
  if(isDefined(self.script_sound)) {
    playsoundatpos(self.origin, self.script_sound);
  }

  var_0 = getEntArray(self.target, "targetname");
  foreach(var_2 in var_0) {
    if(var_2.classname == "script_brushmodel") {
      var_2 connectpaths();
      var_2 notsolid();
    }

    var_3 = undefined;
    if(isDefined(var_2.target)) {
      var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    }

    if(isDefined(var_3)) {
      var_4 = var_3.origin - var_2.origin;
      var_2 moveto(var_2.origin + (var_4[0], var_4[1], 0), 0.5, 0.1, 0.1);
      continue;
    }

    if(isDefined(var_2.script_angles)) {
      var_2 rotateto(var_2.script_angles, 0.75);
      continue;
    }

    var_2 hide();
  }

  scripts\cp\cp_interaction::disable_linked_interactions(self);
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(self);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(self.script_area);
}

register_afterlife_games() {
  level.interaction_hintstrings["basketball_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["laughingclown_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["bowling_for_planets_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["clown_tooth_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["game_race"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_icehock"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_seaques"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_boxing"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_oink"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_keyston"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_plaque"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_crackpo"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_hero"] = &"COOP_INTERACTIONS_PLAY_GAME";
  scripts\cp\cp_interaction::register_interaction("arcade_hero", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_icehock", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_seaques", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_boxing", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_oink", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_keyston", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_plaque", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_crackpo", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("basketball_game_afterlife", "afterlife_game", undefined, undefined, scripts\cp\zombies\interaction_basketball::use_basketball_game, 0, 0, scripts\cp\zombies\interaction_basketball::init_afterlife_basketball_game);
  scripts\cp\cp_interaction::register_interaction("clown_tooth_game_afterlife", "afterlife_game", undefined, undefined, scripts\cp\zombies\interaction_clowntooth::use_clowntooth_game, 0, 0, scripts\cp\zombies\interaction_clowntooth::init_afterlife_clowntooth_game);
  scripts\cp\cp_interaction::register_interaction("laughingclown_afterlife", "afterlife_game", undefined, undefined, scripts\cp\zombies\interaction_laughingclown::laughing_clown, 0, 0, scripts\cp\zombies\interaction_laughingclown::init_all_afterlife_laughing_clowns);
  scripts\cp\cp_interaction::register_interaction("bowling_for_planets_afterlife", "afterlife_game", undefined, undefined, scripts\cp\zombies\interaction_bowling_for_planets::use_bfp_game, 0, 0, scripts\cp\zombies\interaction_bowling_for_planets::init_bfp_afterlife_game);
  scripts\cp\cp_interaction::register_interaction("game_race", "arcade_game", undefined, scripts\cp\zombies\interaction_racing::race_game_hint_logic, scripts\cp\zombies\interaction_racing::use_race_game, 0, 1, scripts\cp\zombies\interaction_racing::init_all_race_games);
}

register_crafting_interactions() {
  scripts\cp\cp_interaction::register_interaction("pillage_item", undefined, undefined, scripts\cp\zombies\zombies_pillage::pillage_hint_func, scripts\cp\zombies\zombies_pillage::player_used_pillage_spot, 0, 0);
}

town_register_interaction(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawnStruct();
  var_10.name = var_1;
  var_10.hint_func = var_4;
  var_10.spend_type = var_2;
  var_10.tutorial = var_3;
  var_10.activation_func = var_5;
  var_10.enabled = 1;
  var_10.disable_guided_interactions = var_0;
  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_10.cost = var_6;
  if(isDefined(var_7)) {
    var_10.requires_power = var_7;
  } else {
    var_10.requires_power = 0;
  }

  var_10.init_func = var_8;
  var_10.can_use_override_func = var_9;
  level.interactions[var_1] = var_10;
}

registeratminteractions() {
  level.interaction_hintstrings["atm_deposit"] = &"CP_TOWN_INTERACTIONS_ATM_DEPOSIT";
  level.interaction_hintstrings["atm_withdrawal"] = &"CP_TOWN_INTERACTIONS_ATM_WITHDRAWAL";
  town_register_interaction(0, "atm_deposit", "atm", undefined, scripts\cp\cp_interaction::atm_deposit_hint, ::atm_deposit, 1000, 1, undefined);
  town_register_interaction(0, "atm_withdrawal", "atm", undefined, ::atm_withdrawal_hint, ::atm_withdrawal, 0, 1, ::setup_atm_system);
}

registerweaponinteractions() {
  level.interaction_hintstrings["iw7_ake_zml"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_cheytacc_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_rvn_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_fmg_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_g18c_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_lockon_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_revolver_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_minilmg_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_mp28_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_spasc_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ump45c_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_vr_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_arclassic_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_erad_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_udm45_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_crb_zml"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
  var_0 = 500;
  scripts\cp\cp_interaction::register_interaction("iw7_revolver_zm", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  var_0 = 750;
  scripts\cp\cp_interaction::register_interaction("iw7_udm45_zm", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_g18c_zm", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  var_0 = 1000;
  scripts\cp\cp_interaction::register_interaction("iw7_lockon_zm", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_cheytacc_zm", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_mp28_zm", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_ump45c_zm", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  var_0 = 1250;
  scripts\cp\cp_interaction::register_interaction("iw7_erad_zm", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_crb_zml", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_spasc_zm", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  var_0 = 1500;
  scripts\cp\cp_interaction::register_interaction("iw7_ake_zml", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_arclassic_zm", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_rvn_zm", "wall_buy", undefined, scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  var_0 = 2000;
  town_register_interaction(1, "iw7_knife_zm_cleaver", undefined, undefined, ::blankhintfunc, ::meleeweaponuse, 0, 0);
  town_register_interaction(1, "iw7_knife_zm_crowbar", undefined, undefined, ::blankhintfunc, ::meleeweaponuse, 0, 0);
}

town_wait_for_interaction_triggered(var_0) {
  self notify("interaction_logic_started");
  self endon("interaction_logic_started");
  self endon("stop_interaction_logic");
  self endon("disconnect");
  for(;;) {
    self.interaction_trigger waittill("trigger", var_1);
    if(var_1 isinphase()) {
      continue;
    }

    while(var_1 ismeleeing() || var_1 meleeButtonPressed()) {
      wait(0.05);
    }

    if(!scripts\cp\cp_interaction::interaction_is_valid(var_0, var_1)) {
      wait(0.1);
      continue;
    }

    var_0.triggered = 1;
    var_0 thread scripts\cp\cp_interaction::delayed_trigger_unset();
    var_2 = level.interactions[var_0.script_noteworthy].cost;
    if(!isDefined(level.interactions[var_0.script_noteworthy].spend_type)) {
      level.interactions[var_0.script_noteworthy].spend_type = "null";
    }

    if(isDefined(level.interactions[var_0.script_noteworthy].can_use_override_func)) {
      if(![[level.interactions[var_0.script_noteworthy].can_use_override_func]](var_0, var_1)) {
        wait(0.1);
        continue;
      }
    } else if(var_0.script_noteworthy == "lost_and_found") {
      if(!scripts\engine\utility::istrue(self.have_things_in_lost_and_found)) {
        wait(0.1);
        continue;
      }

      if(isDefined(self.lost_and_found_spot) && self.lost_and_found_spot != var_0) {
        wait(0.1);
        continue;
      }

      if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
        var_2 = 0;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_upgrade(var_0)) {
      if(scripts\cp\utility::is_codxp()) {
        wait(0.1);
        continue;
      }

      var_3 = var_1 getcurrentweapon();
      level.prevweapon = var_1 getcurrentweapon();
      var_4 = scripts\cp\cp_weapon::get_weapon_level(var_3);
      if(scripts\engine\utility::istrue(level.placed_alien_fuses)) {
        if(var_4 == 3) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_UPGRADE_MAXED");
          wait(0.1);
          continue;
        } else if(can_upgrade(var_3, 1)) {
          if(var_4 == 1) {
            var_2 = 5000;
          } else if(var_4 == 2) {
            var_2 = 10000;
          }
        } else {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_TOWN_UPGRADE_WEAPON_FAIL");
          wait(0.1);
          continue;
        }
      } else if(var_4 == level.pap_max && scripts\engine\utility::istrue(level.has_picked_up_fuses) && isDefined(level.placed_alien_fuses)) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_UPGRADE_MAXED");
        wait(0.1);
        continue;
      } else if(can_upgrade(var_3)) {
        if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
          var_2 = 0;
        } else if(var_4 == 1) {
          var_2 = 5000;
        } else if(var_4 == 2) {
          var_2 = 10000;
        }
      } else {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_TOWN_UPGRADE_WEAPON_FAIL");
        wait(0.1);
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var_0)) {
      if(scripts\cp\utility::is_weapon_purchase_disabled()) {
        wait(0.1);
        continue;
      }

      var_5 = var_1 getcurrentweapon();
      var_6 = scripts\cp\utility::getbaseweaponname(var_5);
      if(scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
        if(!scripts\cp\cp_interaction::can_purchase_ammo(var_0.script_noteworthy)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_GAME_PLAY_AMMO_MAX");
          wait(0.1);
          continue;
        } else {
          var_7 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
          var_4 = scripts\cp\cp_weapon::get_weapon_level(var_7);
          if(var_4 > 1) {
            var_2 = 4500;
          } else {
            var_2 = var_2 * 0.5;
          }
        }
      }
    } else if(scripts\cp\cp_interaction::interaction_is_perk(var_0)) {
      if(!var_1 scripts\cp\cp_interaction::can_use_perk(var_0)) {
        var_2 = 0;
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && var_0.perk_type == "perk_machine_revive" && var_1.self_revives_purchased <= var_1.max_self_revive_machine_use) {
        var_2 = 500;
      } else {
        var_2 = scripts\cp\cp_interaction::get_perk_machine_cost(var_0);
      }
    } else if(scripts\cp\cp_interaction::interaction_is_fortune_teller(var_0)) {
      if(!scripts\engine\utility::istrue(level.unlimited_fnf)) {
        if(var_1.card_refills == 2) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_NO_MORE_CARDS_OWNED");
          wait(0.1);
          continue;
        }
      }

      if(self.card_refills >= 1) {
        var_2 = level.fortune_visit_cost_2;
      } else {
        var_2 = level.fortune_visit_cost_1;
      }
    }

    if(!scripts\cp\cp_interaction::can_purchase_interaction(var_0, var_2, level.interactions[var_0.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[var_0.script_noteworthy], self);
      if(var_0.script_parameters == "tickets") {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_ZMB_INTERACTIONS_NEED_TICKETS");
        thread scripts\cp\cp_vo::try_to_play_vo("no_tickets", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\cp_interaction::interaction_is_perk(var_0) && var_0.perk_type == "perk_machine_revive" && var_1.self_revives_purchased >= var_1.max_self_revive_machine_use) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_CANNOT_BUY_SELF_REVIVE");
      } else {
        thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_NEED_MONEY");
      }

      wait(0.1);
      continue;
    }

    if(var_0.script_noteworthy == "atm_withdrawal") {
      if(isDefined(level.atm_transaction_amount)) {
        if(level.atm_amount_deposited < level.atm_transaction_amount) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_NEED_MONEY");
          wait(0.1);
          continue;
        }
      }
    }

    thread scripts\cp\cp_interaction::interaction_post_activate_delay(var_0);
    if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var_0)) {
      level notify("interaction", var_0.name, undefined, self);
    } else {
      level notify("interaction", "purchase", level.interactions[var_0.script_noteworthy], self);
    }

    var_8 = level.interactions[var_0.script_noteworthy].spend_type;
    thread scripts\cp\cp_interaction::take_player_money(var_2, var_8);
    level thread[[level.interactions[var_0.script_noteworthy].activation_func]](var_0, self);
    if(scripts\cp\cp_interaction::interaction_is_souvenir(var_0)) {
      level thread scripts\cp\cp_interaction::souvenir_team_splash(var_0.script_noteworthy, self);
    }

    scripts\cp\cp_interaction::interaction_post_activate_update(var_0);
    wait(0.1);
    var_0.triggered = undefined;
  }
}

can_upgrade(var_0, var_1) {
  if(!isDefined(level.pap)) {
    return 0;
  }

  if(isDefined(var_0)) {
    var_2 = scripts\cp\utility::getrawbaseweaponname(var_0);
  } else {
    return 0;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(!isDefined(level.pap[var_2])) {
    var_3 = getsubstr(var_2, 0, var_2.size - 1);
    if(!isDefined(level.pap[var_3])) {
      return 0;
    }
  }

  if(isDefined(self.ephemeralweapon) && getweaponbasename(self.ephemeralweapon) == getweaponbasename(var_0)) {
    return 0;
  }

  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_0)])) {
    return 1;
  }

  if(var_2 == "dischord" || var_2 == "facemelter" || var_2 == "headcutter" || var_2 == "shredder") {
    if(!scripts\engine\utility::flag("fuses_inserted")) {
      if(scripts\engine\utility::istrue(var_1)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(self.pap[var_2]) && self.pap[var_2].lvl == 2) {
      return 0;
    }
  }

  if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
    return 1;
  }

  if(scripts\engine\utility::istrue(self.has_zis_soul_key) || scripts\engine\utility::istrue(level.placed_alien_fuses)) {
    if(isDefined(self.pap[var_2]) && self.pap[var_2].lvl >= 3) {
      return 0;
    } else {
      return 1;
    }
  }

  if(scripts\engine\utility::istrue(var_1) && isDefined(self.pap[var_2]) && self.pap[var_2].lvl <= min(level.pap_max + 1, 2)) {
    return 1;
  }

  if(isDefined(self.pap[var_2]) && self.pap[var_2].lvl >= level.pap_max) {
    return 0;
  }

  return 1;
}

town_player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");
  var_0 = 5184;
  var_1 = 9216;
  var_2 = 2304;
  for(;;) {
    if(isDefined(level.interactions_disabled)) {
      wait(1);
      continue;
    }

    var_4 = undefined;
    level.current_interaction_structs = scripts\engine\utility::array_removeundefined(level.current_interaction_structs);
    var_5 = sortbydistance(level.current_interaction_structs, self.origin);
    foreach(var_7 in self.disabled_interactions) {
      var_5 = scripts\engine\utility::array_remove(var_5, var_7);
    }

    if(var_5.size == 0) {
      wait(0.1);
      continue;
    }

    if(scripts\engine\utility::istrue(self.delay_hint)) {
      wait(0.1);
      continue;
    }

    if(scripts\cp\cp_interaction::interaction_is_window_entrance(var_5[0]) && distancesquared(var_5[0].origin, self.origin) < var_2) {
      var_4 = var_5[0];
    }

    if(!isDefined(var_4) && !scripts\cp\cp_interaction::interaction_is_window_entrance(var_5[0]) && distancesquared(var_5[0].origin, self.origin) <= var_0) {
      var_4 = var_5[0];
    }

    if(isDefined(var_4) && scripts\cp\cp_interaction::interaction_is_door_buy(var_4) || scripts\cp\cp_interaction::interaction_is_chi_door(var_4) && !scripts\cp\cp_interaction::interaction_is_special_door_buy(var_4)) {
      var_4 = undefined;
    }

    if(!isDefined(var_4) && isDefined(level.should_allow_far_search_dist_func)) {
      if(distancesquared(var_5[0].origin, self.origin) <= var_1) {
        var_4 = var_5[0];
      }

      if(isDefined(var_4) && ![[level.should_allow_far_search_dist_func]](var_4)) {
        var_4 = undefined;
      }
    } else if(!isDefined(var_4) && isDefined(var_5[0].custom_search_dist)) {
      if(distance(var_5[0].origin, self.origin) <= var_5[0].custom_search_dist) {
        var_4 = var_5[0];
      }
    }

    if(!isDefined(var_4) || !scripts\engine\utility::array_contains(level.current_interaction_structs, var_4)) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    }

    if(!scripts\cp\cp_interaction::can_use_interaction(var_4)) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    }

    if(scripts\cp\cp_interaction::interaction_is_window_entrance(var_4)) {
      var_9 = scripts\cp\utility::get_closest_entrance(var_4.origin);
      if(!isDefined(var_9)) {
        self.last_interaction_point = undefined;
        wait(0.05);
        continue;
      }

      if(scripts\cp\utility::entrance_is_fully_repaired(var_9)) {
        scripts\cp\cp_interaction::reset_interaction();
        if(isDefined(self.current_crafted_inventory) && self.current_crafted_inventory.randomintrange == "crafted_windowtrap") {
          if(!isDefined(var_4.has_trap)) {
            thread scripts\cp\cp_interaction::flash_inventory();
          }
        }

        self.last_interaction_point = var_4;
        continue;
      } else {
        self notify("stop_interaction_logic");
        self.last_interaction_point = undefined;
      }

      if(isDefined(self.current_crafted_inventory) && self.current_crafted_inventory.randomintrange == "crafted_windowtrap") {
        if(!isDefined(var_4.has_trap)) {
          thread scripts\cp\cp_interaction::flash_inventory();
        }
      }
    }

    if(scripts\cp\cp_interaction::interaction_is_perk(var_4) && self getstance() == "prone") {
      self.last_interaction_point = undefined;
      wait(0.05);
      continue;
    }

    if(!isDefined(self.last_interaction_point)) {
      scripts\cp\cp_interaction::set_interaction_point(var_4);
    } else if(self.last_interaction_point == var_4 && scripts\cp\cp_interaction::interaction_is_weapon_buy(var_4) && !scripts\engine\utility::istrue(self.delay_hint)) {
      scripts\cp\cp_interaction::set_interaction_point(var_4, 0);
    } else if(self.last_interaction_point != var_4) {
      scripts\cp\cp_interaction::set_interaction_point(var_4);
    }

    wait(0.05);
  }
}

setup_atm_system() {
  level.atm_amount_deposited = 0;
}

atm_deposit(var_0, var_1) {
  var_1 notify("stop_interaction_logic");
  var_1.last_interaction_point = undefined;
  level.atm_amount_deposited = level.atm_amount_deposited + 1000;
  scripts\cp\cp_interaction::increase_total_deposit_amount(var_1, 1000);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("atm_deposit", "zmb_comment_vo", "low");
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, var_1);
  var_1 scripts\cp\cp_interaction::refresh_interaction();
  if(scripts\cp\cp_interaction::exceed_deposit_limit(var_1)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  }
}

atm_withdrawal(var_0, var_1) {
  if(level.atm_amount_deposited < 1000) {
    return;
  }

  var_2 = 1000;
  var_1 scripts\cp\cp_persistence::give_player_currency(var_2, undefined, undefined, undefined, "atm");
  level.atm_amount_deposited = level.atm_amount_deposited - var_2;
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, var_1);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("withdraw_cash", "zmb_comment_vo", "low");
  var_1 scripts\cp\cp_interaction::refresh_interaction();
}

atm_withdrawal_hint(var_0, var_1) {
  if(var_0.requires_power && !var_0.powered_on) {
    return &"COOP_INTERACTIONS_REQUIRES_POWER";
  }

  if(isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000) {
    return &"CP_TOWN_INTERACTIONS_ATM_INSUFFICIENT_FUNDS";
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

register_crab_boss_interactions() {
  level.interaction_hintstrings["bomb_start"] = &"CP_TOWN_INTERACTIONS_BOMB_CODE";
  level.interaction_hintstrings["push_bomb"] = &"CP_TOWN_INTERACTIONS_PUSH_BOMB";
  town_register_interaction(1, "bomb_start", undefined, undefined, undefined, scripts\cp\maps\cp_town\cp_town_crab_boss_bomb::enter_bomb_code, 0, 0, scripts\cp\maps\cp_town\cp_town_crab_boss_bomb::init_bomb_interaction);
  town_register_interaction(1, "push_bomb", undefined, undefined, undefined, scripts\cp\maps\cp_town\cp_town_crab_boss_escort::push_bomb, 0, 0, scripts\cp\maps\cp_town\cp_town_crab_boss_escort::init_escort_sequence);
  town_register_interaction(1, "death_ray_cannon", undefined, undefined, scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::death_ray_hint_func, ::blankusefunc, 0, 0);
  scripts\cp\cp_interaction::register_interaction("vehicle_teleporter", undefined, undefined, scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall::vehicle_teleporter_hint_func, ::blankusefunc, 0, 0);
}

blankhintfunc(var_0, var_1) {
  return "";
}

cutieammohintfunc(var_0, var_1) {
  var_2 = var_1 getcurrentweapon();
  if(issubstr(var_2, "cutieplunger")) {
    if(var_1 getweaponammoclip(var_2) < weaponclipsize(var_2)) {
      return &"CP_TOWN_CUTIE_AMMO";
    }

    return &"COOP_GAME_PLAY_AMMO_MAX";
  }

  return "";
}

blankusefunc(var_0, var_1) {}

meleeweaponuse(var_0, var_1) {
  if(isDefined(var_1.currentmeleeweapon) && var_1.currentmeleeweapon == var_0.script_noteworthy) {
    return;
  }

  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  if(isDefined(var_1.currentmeleeweapon)) {
    var_1 takeweapon(var_1.currentmeleeweapon);
  }

  var_1 takeweapon("iw7_knife_zm_crowbar");
  var_1 takeweapon("iw7_knife_zm_cleaver");
  if(issubstr(var_0.script_noteworthy, "cleaver")) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_2_collect_cleaver", "town_comment_vo");
  }

  var_2 = var_0.script_noteworthy;
  var_1 giveweapon(var_2);
  var_1.default_starting_melee_weapon = var_2;
  var_1.currentmeleeweapon = var_2;
  var_1.melee_weapon = var_2;
  playFX(level._effect["generic_pickup"], var_0.model.origin);
  var_1 playlocalsound("zmb_item_pickup");
  var_0.model hidefromplayer(var_1);
  if(var_0.script_noteworthy == "iw7_knife_zm_cleaver") {
    var_3 = scripts\engine\utility::getstruct("iw7_knife_zm_crowbar", "script_noteworthy");
    var_3.model showtoplayer(var_1);
    return;
  }

  var_4 = scripts\engine\utility::getstruct("iw7_knife_zm_cleaver", "script_noteworthy");
  var_4.model showtoplayer(var_1);
}

init_papfusebox() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("picked_up_uncharged_fuses");
  scripts\engine\utility::flag_init("picked_up_charged_fuses");
  scripts\engine\utility::flag_init("fuses_charged");
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = getEntArray("pap_upgrade_door", "targetname");
  var_1 = scripts\engine\utility::getStructArray("pap_fusebox", "script_noteworthy");
  var_2 = getent("pap_upgrade_door_handle", "targetname");
  var_2 notsolid();
  foreach(var_4 in var_1) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_4);
  }

  foreach(var_7 in var_0) {
    var_8 = scripts\engine\utility::getclosest(var_7.origin, var_1);
    thread watchforcrowbardamage(var_7, var_8);
  }

  turn_on_room_exit_portal();
}

turn_on_room_exit_portal() {
  var_0 = (-10353.5, 582.5, -1573);
  var_1 = anglesToForward((0, 45, 0));
  var_2 = spawnfx(level._effect["vfx_pap_return_portal"], var_0, var_1);
  thread scripts\engine\utility::play_loopsound_in_space("zmb_portal_powered_on_activate_lp", var_0);
  triggerfx(var_2);
  level thread pap_exit_teleporter();
}

pap_exit_teleporter() {
  var_0 = spawn("script_origin", (-10353.5, 582.5, -1573));
  var_0 makeusable();
  var_0 sethintstring(&"CP_TOWN_INTERACTIONS_HIDDEN_LEAVE");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isDefined(var_1.kicked_out)) {
      var_1 notify("left_hidden_room_early");
      hidden_room_exit_tube(var_1);
    }

    wait(0.1);
  }
}

watchforcrowbardamage(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 setCanDamage(1);
  var_0 setCanRadiusDamage(1);
  var_0.maxhealth = 9999999;
  var_0.health = 9999999;
  for(;;) {
    var_0 waittill("damage", var_4, var_5, var_6, var_6, var_6, var_6, var_6, var_6, var_6, var_7);
    if(isDefined(var_7) && issubstr(var_7, "crowbar")) {
      break;
    }

    var_0.maxhealth = 9999999;
    var_0.health = 9999999;
  }

  var_0.health = 0;
  var_0.maxhealth = 0;
  if(isDefined(var_1)) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  }

  if(!scripts\engine\utility::istrue(var_2)) {
    playFX(level._effect["fuse_door_break"], var_0.origin);
    playsoundatpos(var_0.origin, "zmb_wood_barrier_destroy");
  } else {
    var_0 playSound("town_pap_fuse_box_crowbar_open");
  }

  var_0 setCanDamage(0);
  if(isDefined(var_3)) {
    var_0 rotateto(var_0.angles + var_3, 0.2);
    return;
  }

  var_0 hide();
  var_8 = getent("pap_upgrade_door_handle", "targetname");
  var_8 hide();
}

init_papanomaly() {
  level.secretpapstructs = [];
  scripts\engine\utility::flag_init("pap_portal_used");
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = scripts\engine\utility::getStructArray("fast_travel_panel", "script_noteworthy");
  level thread pap_anomaly_logic();
  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin + (0, 0, 40));
    if(isDefined(var_2.angles)) {
      var_3.angles = var_2.angles;
    }

    var_3 setModel("tag_origin_portal");
    var_2.model = var_3;
    var_2.hidden = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    var_2 thread activateonpoweron(var_2);
  }
}

pap_anomaly_logic() {
  while(!scripts\engine\utility::istrue(level.anomaly_revealed)) {
    wait(1);
  }

  for(;;) {
    foreach(var_1 in level.secretpapstructs) {
      if(level.active_pap_teleporter == var_1) {
        var_1.model setscriptablepartstate("portal", "on");
        scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
        continue;
      }

      var_1.model setscriptablepartstate("portal", "off");
      var_1.revealed = 1;
      var_1.teleporter_active = 0;
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
    }

    scripts\engine\utility::flag_wait("pap_portal_used");
    wait(15);
    level.active_pap_teleporter.model setscriptablepartstate("portal", "off");
    level.active_pap_teleporter.teleporter_active = 0;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(level.active_pap_teleporter);
    wait(60);
    scripts\engine\utility::flag_clear("pap_portal_used");
    var_3 = scripts\engine\utility::array_randomize(level.secretpapstructs);
    foreach(var_5 in var_3) {
      if(var_5 == level.active_pap_teleporter) {
        continue;
      }

      level.active_pap_teleporter = var_5;
      level.active_pap_teleporter.teleporter_active = 1;
      break;
    }
  }
}

activateonpoweron(var_0) {
  level endon("game_ended");
  level waittill("activate_power");
  level.secretpapstructs[level.secretpapstructs.size] = var_0;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  var_0.model setscriptablepartstate("portal", "anomaly");
  var_0.hidden = undefined;
}

generator_field_hint(var_0, var_1) {
  if(scripts\engine\utility::flag("fuses_charged")) {
    return &"CP_TOWN_INTERACTIONS_PICKUP_CHARGED_FUSES";
  }

  return "";
}

generator_field_vibrate() {
  var_0 = scripts\engine\utility::getstruct("generator_field_center", "script_noteworthy");
  for(;;) {
    if(!scripts\engine\utility::flag("vial_filled")) {
      wait(0.05);
      continue;
    }

    var_1 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, undefined, 4, 96);
    foreach(var_3 in var_1) {
      var_3 setclientomnvar("ui_hud_shake", 1);
      var_3 playrumbleonentity("artillery_rumble");
    }

    wait(randomfloatrange(0.5, 2));
  }
}

usegeneratorfieldcenter(var_0, var_1) {
  if(!scripts\engine\utility::flag("picked_up_charged_fuses") && scripts\engine\utility::flag("fuses_charged")) {
    scripts\engine\utility::flag_set("picked_up_charged_fuses");
    var_2 = getEntArray("pap_fuses", "targetname");
    playFX(level._effect["generic_pickup"], var_2[0].origin);
    foreach(var_4 in var_2) {
      var_4 delete();
    }

    var_1 playlocalsound("zmb_item_pickup");
    level.upgraded_fuses_pickedup = 1;
    level.has_picked_up_fuses = 1;
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("pap_collect_fuse", "town_comment_vo", "low", 10, 0, 0, 1, 100);
    foreach(var_7 in level.players) {
      var_7 setclientomnvar("zm_special_item", 1);
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    return;
  }

  if(scripts\engine\utility::flag("picked_up_uncharged_fuses") && scripts\engine\utility::flag("vial_filled")) {
    foreach(var_7 in level.players) {
      var_7 setclientomnvar("zm_special_item", 5);
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    scripts\engine\utility::flag_clear("picked_up_uncharged_fuses");
    var_11 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
    var_2 = getEntArray("pap_fuses", "targetname");
    foreach(var_14, var_13 in var_11) {
      var_4 = var_2[var_14];
      var_4 dontinterpolate();
      var_4.origin = var_13.origin;
      if(isDefined(var_13.angles)) {
        var_4.angles = var_13.angles;
      }

      var_4 show();
    }

    var_2[0] playSound("town_pap_green_goo_start");
    foreach(var_7 in level.players) {
      var_7 setclientomnvar("zm_special_item", 0);
    }

    level.generator_blood = spawnfx(level._effect["vfx_crog_blood"], var_0.origin + (0, 0, -2));
    scripts\engine\utility::flag_clear("vial_filled");
    setomnvar("zom_general_fill_percent_2", 0);
    thread chargefuses(var_2, var_0);
    wait(0.5);
    triggerfx(level.generator_blood);
    var_2[0] playLoopSound("town_pap_green_goo_lp");
  }
}

chargefuses(var_0, var_1) {
  level endon("game_ended");
  level waittill("use_electric_trap");
  wait(2);
  var_2 = scripts\engine\utility::getStructArray("electric_trap_spots", "targetname");
  var_3 = scripts\engine\utility::getclosest(var_1.origin, var_2);
  var_4 = var_3.origin + (0, 0, randomintrange(100, 170));
  var_5 = var_1.origin;
  playfxbetweenpoints(level._effect["electric_trap_attack"], var_4, vectortoangles(var_5 - var_4), var_5);
  playsoundatpos(var_4, "town_pap_electric_bolt");
  wait(2);
  playfxbetweenpoints(level._effect["electric_trap_attack"], var_4, vectortoangles(var_5 - var_4), var_5);
  playsoundatpos(var_4, "town_pap_electric_bolt");
  wait(0.05);
  playFX(level._effect["vfx_bomb_portal_in"], var_1.origin);
  wait(0.05);
  foreach(var_7 in var_0) {
    var_7 setModel("park_alien_gray_fuse");
    wait(0.1);
    playFXOnTag(level._effect["fuse_charged"], var_7, "tag_origin");
  }

  scripts\engine\utility::flag_set("fuses_charged");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  level.generator_blood delete();
  var_0[0] stoploopsound("town_pap_green_goo_lp");
}

pickupfuse(var_0, var_1) {
  var_2 = getEntArray("pap_fuses", "targetname");
  var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2, undefined, 2);
  scripts\engine\utility::flag_set("picked_up_uncharged_fuses");
  var_1 playlocalsound("part_pickup");
  playFX(level._effect["generic_pickup"], var_3[0].origin);
  foreach(var_5 in level.players) {
    var_5 setclientomnvar("zm_special_item", 5);
  }

  foreach(var_8 in var_3) {
    var_8 hide();
  }

  var_0 scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  level thread generator_field_vibrate();
}

papearlyexituse(var_0, var_1) {
  if(scripts\engine\utility::istrue(level.pap_upgrade_fuses_available)) {
    level thread hidden_room_exit_tube(var_1);
  }
}

papfuseswitchhint(var_0, var_1) {
  return "";
}

usepapfuseswitch(var_0, var_1) {
  level endon("fuses_pickedup");
  var_2 = getent(var_0.target, "targetname");
  var_2 setModel("mp_frag_button_on_green");
  playsoundatpos(var_2.origin, "town_pap_room_button_press");
  level.pap_upgrade_fuses_available = 1;
  wait(0.5);
  playFX(level._effect["vfx_pap_upgrade_symb"], (-10245, 750, -1629.4));
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  wait(5);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  level.pap_upgrade_fuses_available = undefined;
  var_2 setModel("mp_frag_button_on");
}

usepapanomaly(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.isrewinding)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.playing_game)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_0.hidden)) {
    return;
  }

  if(!scripts\engine\utility::istrue(var_0.revealed)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_0.teleporter_active)) {
    thread teleporttopaproom(var_1, var_0);
    if(!scripts\engine\utility::flag("pap_portal_used")) {
      scripts\engine\utility::flag_set("pap_portal_used");
    }
  }
}

teleporttopaproom(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("left_hidden_room_early");
  var_2 = scripts\engine\utility::getStructArray("pap_spawners", "targetname");
  var_0.pap_interaction = var_1;
  wait(0.1);
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  scripts\cp\maps\cp_town\cp_town_fast_travel::move_player_through_portal_tube(var_0, var_2);
  var_0 playershow();
  var_0.is_off_grid = 1;
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0 set_in_pap_room(var_0, 1);
  var_0.disable_consumables = undefined;
  var_0 thread hidden_room_timer(var_0);
  level notify("hidden_room_portal_used");
}

set_in_pap_room(var_0, var_1) {
  var_0.is_in_pap = var_1;
}

hidden_room_timer(var_0) {
  var_0 endon("left_hidden_room_early");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0.kicked_out = undefined;
  var_0 thread pap_timer_start();
  level thread pap_vo(self);
  var_0 waittill("kicked_out");
  var_0.kicked_out = 1;
  level thread hidden_room_exit_tube(var_0);
}

pap_timer_start() {
  self endon("disconnect");
  if(!isDefined(self.pap_timer_running)) {
    thread runpaptimer(self);
    scripts\engine\utility::waittill_any_timeout(30, "left_hidden_room_early");
    self setclientomnvar("zombie_papTimer", -1);
    self notify("kicked_out");
    self.pap_timer_running = undefined;
  }
}

runpaptimer(var_0) {
  var_0 endon("disconnect");
  var_0 endon("left_hidden_room_early");
  var_0.pap_timer_running = 1;
  var_1 = 30;
  var_0 setclientomnvar("zombie_papTimer", var_1);
  wait(1);
  for(;;) {
    var_1--;
    if(var_1 < 0) {
      var_1 = 30;
      wait(1);
      break;
    }

    var_0 setclientomnvar("zombie_papTimer", var_1);
    wait(1);
  }
}

pap_vo(var_0) {
  var_0 endon("disconnect");
  level.pap_firsttime = 1;
  wait(4);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("ww_pap_nag", "rave_pap_vo", "high", undefined, undefined, undefined, 1);
}

hidden_room_exit_tube(var_0) {
  var_0 endon("disconnect");
  var_0 getrigindexfromarchetyperef();
  var_0 notify("delete_equipment");
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  if(scripts\engine\utility::istrue(level.pap_upgrade_fuses_available)) {
    var_1 = get_valid_pap_upgrade_spot();
    thread completeteleporttopos(var_0, var_1, ::delaysendingplayerback);
    return;
  }

  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  var_2 = get_valid_pap_return_spot(var_0.pap_interaction, 1);
  scripts\cp\maps\cp_town\cp_town_fast_travel::move_player_through_portal_tube(var_0, var_2);
  var_0 scripts\cp\cp_interaction::refresh_interaction();
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0 getrigindexfromarchetyperef();
  var_0 notify("left_hidden_room_early");
  var_0 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  var_0.disable_consumables = undefined;
  var_0.is_off_grid = undefined;
  var_0.kicked_out = undefined;
  var_0.pap_interaction = undefined;
  var_0 set_in_pap_room(var_0, 0);
  var_0 notify("fast_travel_complete");
  scripts\cp\cp_vo::remove_from_nag_vo("ww_pap_nag");
  scripts\cp\cp_vo::remove_from_nag_vo("nag_find_pap");
}

get_valid_pap_return_spot(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = scripts\engine\utility::getStructArray("pap_return_spots", "targetname")[0];
  }

  var_2 = scripts\engine\utility::get_array_of_closest(var_0.origin, scripts\engine\utility::getStructArray("pap_return_spots", "targetname"), undefined, 4);
  if(scripts\engine\utility::istrue(var_1)) {
    return var_2;
  }

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  while(!isDefined(var_3)) {
    foreach(var_7 in var_2) {
      var_8 = var_7.origin;
      if(!positionwouldtelefrag(var_8)) {
        var_3 = var_8;
        var_4 = var_7.angles;
        return var_7;
      }
    }

    wait(0.1);
  }
}

get_valid_pap_upgrade_spot() {
  var_0 = scripts\engine\utility::getStructArray("pap_upgrade_player", "script_noteworthy");
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  while(!isDefined(var_1)) {
    foreach(var_5 in var_0) {
      var_6 = var_5.origin;
      if(!positionwouldtelefrag(var_6)) {
        var_1 = var_6;
        var_2 = var_5.angles;
        return var_5;
      }
    }

    wait(0.1);
  }
}

delaysendingplayerback(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_0 endon("last_stand");
  var_0 thread scripts\engine\utility::play_loop_sound_on_entity("quest_rewind_clock_tick_long");
  wait(7);
  var_0 thread scripts\engine\utility::stop_loop_sound_on_entity("quest_rewind_clock_tick_long");
  var_0 playsoundtoplayer("mpq_fail_buzzer", var_0);
  var_1 = get_valid_pap_return_spot(var_0.pap_interaction);
  thread completeteleporttopos(var_0, var_1);
}

completeteleporttopos(var_0, var_1, var_2) {
  var_0 notify("completeTeleportToPos");
  var_0 endon("completeTeleportToPos");
  var_0 endon("disconnect");
  var_0 scripts\cp\cp_interaction::refresh_interaction();
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0 getrigindexfromarchetyperef();
  var_0 setorigin(var_1.origin);
  if(isDefined(var_1.angles)) {
    var_0 setplayerangles(var_1.angles);
  } else {
    var_0 setplayerangles((0, 0, 0));
  }

  var_0 notify("left_hidden_room_early");
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_0 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  if(isDefined(var_2)) {
    [[var_2]](var_0);
  }

  var_0.disable_consumables = undefined;
  var_0.is_off_grid = undefined;
  var_0.kicked_out = undefined;
  var_0.pap_interaction = undefined;
  var_0 set_in_pap_room(var_0, 0);
  var_0 notify("fast_travel_complete");
  scripts\cp\cp_vo::remove_from_nag_vo("ww_pap_nag");
  scripts\cp\cp_vo::remove_from_nag_vo("nag_find_pap");
}

papearlyexithint(var_0, var_1) {
  return "";
}

papanomalyhint(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.teleporter_active)) {
    return &"CP_TOWN_INTERACTIONS_HIDDEN_TELEPORT";
  }

  if(scripts\engine\utility::istrue(var_0.cooling_down)) {
    return &"COOP_INTERACTIONS_COOLDOWN";
  }

  return "";
}

tcspieceinit() {
  scripts\engine\utility::flag_init("found_tcs_piece");
  scripts\engine\utility::flag_init("tcs_piece_placed");
  scripts\engine\utility::flag_init("main_power_on");
  var_0 = scripts\engine\utility::getStructArray("tcs_piece", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.target)) {
      var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    } else {
      var_3 = var_2;
    }

    var_4 = spawn("script_model", var_3.origin);
    if(isDefined(var_3.angles)) {
      var_4.angles = var_3.angles;
    }

    var_4 setModel("cp_disco_film_reel_case");
    var_2.model = var_4;
  }
}

usetcspiece(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::flag_set("found_tcs_piece");
  var_1 playlocalsound("part_pickup");
  var_0.model delete();
}

cutie_hint_func(var_0, var_1) {
  if(!var_1 scripts\cp\cp_weapon::has_weapon_variation("iw7_cutie_zm") || !var_1 scripts\cp\cp_weapon::has_weapon_variation("iw7_cutier_zm")) {
    return "";
  } else {
    var_2 = var_1 getweaponslistall();
    var_3 = undefined;
    var_4 = undefined;
    foreach(var_6 in var_2) {
      if(issubstr(var_6, "iw7_cutie_zm") || issubstr(var_6, "iw7_cutier_zm")) {
        var_3 = var_6;
        break;
      }
    }

    if(isDefined(var_3)) {
      var_8 = getweaponattachments(var_3);
      var_9 = [];
      var_10 = getcutieattachmentname(var_0);
      if(var_8.size > 0) {
        foreach(var_12 in var_8) {
          if(var_12 == var_10) {
            return "";
          }
        }
      }
    }
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

addcutieattachment(var_0, var_1) {
  if(var_1 scripts\cp\cp_weapon::has_weapon_variation("iw7_cutie_zm") || var_1 scripts\cp\cp_weapon::has_weapon_variation("iw7_cutier_zm")) {
    var_2 = var_1 getweaponslistall();
    var_3 = undefined;
    var_4 = undefined;
    foreach(var_6 in var_2) {
      if(issubstr(var_6, "iw7_cutie_zm")) {
        var_3 = var_6;
        break;
      }
    }

    if(isDefined(var_3)) {
      var_8 = getweaponattachments(var_3);
      var_9 = [];
      var_10 = getcutieattachmentname(var_0);
      if(var_8.size > 0) {
        foreach(var_12 in var_8) {
          if(var_12 == var_10) {
            return;
          }
        }

        var_4 = createcutieweaponstring(var_1, var_8, var_10);
      } else {
        var_4 = createcutieweaponstring(var_1, var_8, var_10);
      }

      if(var_10 == "cutiecrank") {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("weapon_pap_ww1_1", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      } else if(var_10 == "cutiegrip") {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("weapon_pap_ww1_2", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }

      if(isDefined(var_4)) {
        var_1 takeweapon(var_3);
        var_1 scripts\cp\utility::_giveweapon(var_4, -1, undefined, 0);
        var_1 switchtoweapon(var_4);
      }

      if(var_4 == "iw7_cutie_zm+cutiecrank+cutiegrip+cutieplunger") {
        var_1 scripts\cp\zombies\achievement::update_achievement("MAD_PROTO", 1);
        return;
      }

      return;
    }

    return;
  }

  var_4 scripts\cp\cp_interaction::interaction_show_fail_reason(var_3, &"COOP_PILLAGE_CANT_USE");
}

createcutieweaponstring(var_0, var_1, var_2) {
  var_3 = "iw7_cutie_zm";
  if(var_1.size > 0) {
    var_1 = scripts\engine\utility::array_add(var_1, var_2);
    var_1 = scripts\engine\utility::alphabetize(var_1);
    foreach(var_5 in var_1) {
      var_3 = var_3 + "+" + var_5;
    }
  } else {
    var_3 = var_3 + "+" + var_2;
  }

  return var_3;
}

getcutieattachmentname(var_0) {
  switch (var_0.script_noteworthy) {
    case "crank":
      return "cutiecrank";

    case "front_barrel":
      return "cutiegrip";

    case "plunger":
      return "cutieplunger";
  }
}

usecutiepickup(var_0, var_1) {
  if(!var_1 scripts\cp\cp_weapon::has_weapon_variation("iw7_cutie_zm")) {
    var_1 thread scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_1, "iw7_cutie_zm");
  }
}

useplungerammo(var_0, var_1) {
  var_2 = var_1 scripts\cp\utility::getvalidtakeweapon();
  if(var_1 getweaponammoclip(var_2) == weaponclipsize(var_2)) {
    return;
  }

  if(issubstr(var_2, "iw7_cutie_zm") || issubstr(var_2, "iw7_cutier_zm")) {
    if(scripts\cp\utility::weaponhasattachment(var_2, "plunger")) {
      var_1 thread runcutieplungergesture(var_1, var_2, var_0);
    }
  }
}

init_tcs() {
  var_0 = scripts\engine\utility::getstruct("technicolor_machine", "script_noteworthy");
  level scripts\engine\utility::waittill_any("power_on", var_0.power_area + " power_on");
  var_0.powered_on = 1;
}

tcs_hint(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_0.powered_on)) {
    return &"COOP_INTERACTIONS_REQUIRES_POWER";
  }

  var_2 = ["color", "red", "green", "blue"];
  if(!isDefined(var_0.state)) {
    var_0.state = 0;
  }

  var_3 = var_0.state + 1;
  if(var_3 > 3) {
    var_3 = 0;
  }

  var_4 = var_2[var_3];
  switch (var_4) {
    case "red":
      return &"CP_TOWN_CINEMA_RED";

    case "green":
      return &"CP_TOWN_CINEMA_GREEN";

    case "blue":
      return &"CP_TOWN_CINEMA_BLUE";

    case "color":
      return &"CP_TOWN_CINEMA_COLOR";
  }
}

usetcs(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_0.powered_on)) {
    return;
  }

  var_2 = ["color", "red", "green", "blue"];
  if(!isDefined(var_0.state)) {
    var_0.state = 0;
  }

  var_0.state++;
  if(var_0.state > 3) {
    var_0.state = 0;
  }

  var_3 = var_0.state;
  var_4 = var_2[var_3];
  var_5 = undefined;
  switch (var_4) {
    case "red":
      var_5 = "cp_town_bw_r";
      break;

    case "green":
      var_5 = "cp_town_bw_g";
      break;

    case "blue":
      var_5 = "cp_town_bw_b";
      break;

    case "color":
      var_5 = "cp_town_color";
      break;
  }

  level.current_vision_set = var_5;
  level.vision_set_override = level.current_vision_set;
  level thread play_color_change_vo(var_1);
  applyvisionsettoallplayers(var_5);
}

play_color_change_vo(var_0) {
  if(randomint(100) > 50) {
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_nag_color_alternate", "rave_announcer_vo", "highest", 70, 0, 0, 1);
    return;
  }

  var_0 thread scripts\cp\cp_vo::try_to_play_vo("color_alternate", "town_comment_vo");
}

runfunctionafterwait(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = 0;
  if(!isDefined(var_0)) {
    var_4 = 1;
  } else {
    var_4 = var_1;
  }

  if(isDefined(var_1)) {
    thread[[var_1]]();
  }

  runwavewait(var_3, var_4);
  if(isDefined(var_2)) {
    thread[[var_2]]();
  }
}

runwavewait(var_0, var_1) {
  level endon("game_ended");
  level endon("runWaveWait_early_endon");
  for(;;) {
    level waittill("wave_starting");
    var_0++;
    if(var_0 >= var_1) {
      break;
    }
  }
}

applyvisionsettoallplayers(var_0) {
  level.current_vision_set = var_0;
  level.vision_set_override = level.current_vision_set;
  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!isalive(var_2)) {
      continue;
    }

    var_2 visionsetnakedforplayer(var_0, 1);
  }

  switch (var_0) {
    case "cp_town_bw_r":
      var_0 = "cp_town_bw_r";
      if(level.bomb_compound.color == "red") {
        setomnvar("zm_chem_value_choice", level.bomb_compound.choice);
        setomnvar("zm_chem_bvalue_choice", 0);
      } else {
        setomnvar("zm_chem_bvalue_choice", level.bad_choice_index_color_red);
        setomnvar("zm_chem_value_choice", 0);
      }

      scripts\cp\maps\cp_town\cp_town_chemistry::set_not_equal_constant("red");
      setomnvar("zm_chem_current_color", 1);
      break;

    case "cp_town_bw_g":
      var_0 = "cp_town_bw_g";
      if(level.bomb_compound.color == "green") {
        setomnvar("zm_chem_value_choice", level.bomb_compound.choice);
        setomnvar("zm_chem_bvalue_choice", 0);
      } else {
        setomnvar("zm_chem_bvalue_choice", level.bad_choice_index_color_green);
        setomnvar("zm_chem_value_choice", 0);
      }

      scripts\cp\maps\cp_town\cp_town_chemistry::set_not_equal_constant("green");
      setomnvar("zm_chem_current_color", 2);
      break;

    case "cp_town_bw_b":
      var_0 = "cp_town_bw_b";
      if(level.bomb_compound.color == "blue") {
        setomnvar("zm_chem_value_choice", level.bomb_compound.choice);
        setomnvar("zm_chem_bvalue_choice", 0);
      } else {
        setomnvar("zm_chem_bvalue_choice", level.bad_choice_index_color_blue);
        setomnvar("zm_chem_value_choice", 0);
      }

      scripts\cp\maps\cp_town\cp_town_chemistry::set_not_equal_constant("blue");
      setomnvar("zm_chem_current_color", 3);
      break;

    case "cp_town_color":
      var_0 = "cp_town_color";
      scripts\cp\maps\cp_town\cp_town_chemistry::set_not_equal_constant("full");
      setomnvar("zm_chem_current_color", 0);
      setomnvar("zm_chem_bvalue_choice", level.bad_choice_index_default);
      setomnvar("zm_chem_value_choice", 0);
      break;
  }
}

missinghandleinit() {
  scripts\engine\utility::flag_init("found_missing_handle");
  scripts\engine\utility::flag_init("placed_missing_handle");
  var_0 = scripts\engine\utility::getStructArray("missing_handle", "script_noteworthy");
  var_0 = scripts\engine\utility::array_randomize_objects(var_0);
  var_1 = var_0[0];
  if(isDefined(var_1.target)) {
    var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  } else {
    var_2 = var_2;
  }

  var_3 = spawn("script_model", var_2.origin);
  if(isDefined(var_2.angles)) {
    var_3.angles = var_2.angles;
  }

  var_3 setModel("icbm_electricpanel_switch_02");
  var_1.model = var_3;
  level.missing_handle_struct = var_1;
}

missinghandlehint(var_0, var_1) {
  return &"CP_TOWN_INTERACTIONS_PICKUP_HANDLE";
}

usemissinghandle(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::flag_set("found_missing_handle");
  var_2 = scripts\engine\utility::getStructArray("mpq_zom_body_part", "script_noteworthy");
  var_3 = scripts\engine\utility::getclosest(var_0.origin, var_2);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_3);
  playFX(level._effect["generic_pickup"], var_0.model.origin);
  var_1 playlocalsound("part_pickup");
  var_0.model delete();
  scripts\cp\maps\cp_town\cp_town_traps::givetrapparticon("lever");
}

usebrokengenerator(var_0, var_1) {
  if(scripts\engine\utility::flag("found_missing_handle")) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    var_0.fixed = 1;
    var_1 playlocalsound("part_pickup");
    var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_3 = spawn("script_model", var_2.origin);
    if(isDefined(var_2.angles)) {
      var_3.angles = var_2.angles;
    }

    var_3 setModel("icbm_electricpanel_switch_02");
    var_3.script_noteworthy = var_2.script_noteworthy;
    var_3.script_parameters = var_2.script_parameters;
    var_0.handle = var_3;
    var_0.handle.script_noteworthy = "-pitch";
    scripts\engine\utility::flag_set("placed_missing_handle");
    wait(1);
    level notify("found_power");
    level thread scripts\cp\zombies\zombie_power::generic_generator(var_0, var_1);
    if(isDefined(level.town_power_vo_func)) {
      var_4 = scripts\engine\utility::random(level.players);
      level thread[[level.town_power_vo_func]](var_4);
    }

    var_1 thread sfx_poweron(var_0);
    level thread scripts\cp\maps\cp_town\cp_town::enablepas();
    earthquake(0.3, 1, var_0.origin, 250);
    wait(1);
    var_5 = getent("box", "script_noteworthy");
    var_5 setModel("icbm_electricpanel9_on");
    scripts\cp\maps\cp_town\cp_town_traps::taketrapparticon("lever");
    setomnvar("zm_ui_color_eye_ent", level.color_eye);
  }
}

sfx_poweron(var_0) {
  wait(0.1);
  playsoundatpos(var_0.origin, "power_buy_plr_throw_switch");
  wait(0.2);
  playsoundatpos((6272, -2460, 166), "power_buy_powerup_lr");
}

brokengeneratorhint(var_0, var_1) {
  if(!scripts\engine\utility::flag("found_missing_handle")) {
    return &"CP_TOWN_INTERACTIONS_MISSING_HANDLE";
  } else if(!scripts\engine\utility::flag("placed_missing_handle")) {
    return &"CP_TOWN_INTERACTIONS_ADD_PART";
  }

  return "";
}

addtovisionsetarray(var_0) {
  if(!scripts\engine\utility::array_contains(level.current_vision_sets, var_0)) {
    level.current_vision_sets[level.current_vision_sets.size] = var_0;
  }
}

removefromvisionsetarray(var_0) {
  if(scripts\engine\utility::array_contains(level.current_vision_sets, var_0)) {
    level.current_vision_sets = scripts\engine\utility::array_remove(level.current_vision_sets.size, var_0);
  }
}

applyvisionsetarraytoplayer(var_0) {
  if(level.current_vision_sets.size > 0) {
    foreach(var_2 in level.current_vision_sets) {
      var_0 visionsetnakedforplayer(var_2, 0.1);
    }
  }
}

initmeleeweapons() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = scripts\engine\utility::getStructArray("iw7_knife_zm_crowbar", "script_noteworthy");
  var_1 = scripts\engine\utility::getStructArray("iw7_knife_zm_cleaver", "script_noteworthy");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  foreach(var_4 in var_2) {
    if(isDefined(var_4.target)) {
      var_5 = scripts\engine\utility::getstruct(var_4.target, "targetname");
    } else {
      var_5 = var_4;
    }

    var_6 = spawn("script_model", var_5.origin);
    if(isDefined(var_5.angles)) {
      var_6.angles = var_5.angles;
    }

    switch (var_4.script_noteworthy) {
      case "iw7_knife_zm_cleaver":
        var_6 setModel("zmb_meat_cleaver_wm");
        break;

      case "iw7_knife_zm_crowbar":
        var_6 setModel("zmb_crowbar_wm");
        break;
    }

    var_4.model = var_6;
  }
}

initwwpieces() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  level.weapon_change_func["iw7_cutie_zm"] = ::runcutielogic;
  level.weapon_change_func["iw7_cutier_zm"] = ::runcutielogic;
  var_0 = scripts\engine\utility::getStructArray("front_barrel", "script_noteworthy");
  var_1 = scripts\engine\utility::getStructArray("plunger", "script_noteworthy");
  var_2 = scripts\engine\utility::getStructArray("crank", "script_noteworthy");
  var_3 = scripts\engine\utility::getStructArray("cutie", "script_noteworthy");
  var_4 = scripts\engine\utility::array_combine(var_0, var_1);
  var_5 = scripts\engine\utility::array_combine(var_2, var_3);
  var_6 = scripts\engine\utility::array_combine(var_4, var_5);
  var_7 = getEntArray("rg_lid", "targetname");
  foreach(var_9 in var_6) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_9);
    var_10 = scripts\engine\utility::getclosest(var_9.origin, var_7);
    thread watchforcrowbardamage(var_10, var_9, 1, (0, -140, 0));
    if(isDefined(var_9.target)) {
      var_11 = scripts\engine\utility::getstruct(var_9.target, "targetname");
    } else {
      var_11 = var_9;
    }

    var_12 = spawn("script_model", var_11.origin);
    if(isDefined(var_11.angles)) {
      var_12.angles = var_11.angles;
    }

    switch (var_9.script_noteworthy) {
      case "cutie":
        var_12 setModel("weapon_zmb_raygun_wm");
        break;

      case "front_barrel":
        var_12 setModel("weapon_zmb_raygun_front_barrel_wm");
        break;

      case "plunger":
        var_12 setModel("weapon_zmb_raygun_plunger_wm");
        break;

      case "crank":
        var_12 setModel("weapon_zmb_raygun_crank_wm");
        break;
    }
  }
}

runcutielogic(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("weapon_change");
  var_2 = 0;
  var_3 = 0;
  if(scripts\cp\utility::weaponhasattachment(var_1, "crank")) {
    var_3 = 1;
  }

  if(scripts\cp\utility::weaponhasattachment(var_1, "plunger")) {
    var_2 = 1;
  }

  var_0.cutiechargecount = 0;
  var_0 thread unsetcutieonweaponchange(var_0);
  var_0 setscriptablepartstate("cutie_fx", "power_on");
  if(var_3 || var_2) {
    var_0 notifyonplayercommand("cutie_used", "+speed_throw");
    var_0 notifyonplayercommand("cutie_used", "+toggleads_throw");
    var_0 notifyonplayercommand("cutie_used", "+ads_akimbo_accessible");
    for(;;) {
      var_0 waittill("cutie_used");
      if(var_0 useButtonPressed() || scripts\engine\utility::istrue(var_0.playingperkgesture)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_0.fired_fov_beam)) {
        continue;
      }

      if(var_3 && !scripts\engine\utility::istrue(var_0.disablecrank)) {
        var_4 = 0;
        var_0 notify("end_cutie_gesture_loop");
        var_0 stopgestureviewmodel("ges_cutie_crank");
        var_5 = 0;
        if(var_0 getweaponammoclip(var_1) >= 5) {
          while(!scripts\engine\utility::istrue(var_0.disablecrank) && var_0 adsButtonPressed(1) && var_0 scripts\cp\utility::getvalidtakeweapon() == var_1) {
            var_5 = 1;
            var_0 runcutiegestureloop(var_0, var_1);
            break;
          }

          continue;
        }

        var_0 playlocalsound("purchase_deny");
      }
    }
  }
}

runcutieplungergesture(var_0, var_1, var_2) {
  if(!scripts\engine\utility::istrue(var_0.disableplunger)) {
    level endon("game_ended");
    var_0 endon("disconnect");
    var_0.disablecrank = 1;
    var_0 setscriptablepartstate("cutiefov", "plungersuck");
    var_0 playgestureviewmodel("ges_cutie_plunger", undefined, 0);
    wait(var_0 getgestureanimlength("ges_cutie_plunger"));
    var_0 stopgestureviewmodel("ges_cutie_plunger");
    var_0 setscriptablepartstate("cutiefov", "inactive");
    var_0 setweaponammoclip(var_1, weaponclipsize(var_1));
    if(isDefined(var_2)) {
      var_0 thread cooldowninteractionstruct(var_2, var_0);
    }

    var_0.disablecrank = undefined;
  }
}

cooldowninteractionstruct(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_2 = scripts\engine\utility::getclosest(var_0.origin, level.egg_sacs);
  playFX(level._effect["egg_sac_explode"], var_2.origin + (0, 0, 4));
  scripts\cp\utility::playsoundinspace("egg_explode_after_refill_ammo", var_2.origin + (0, 0, 40));
  wait(0.05);
  var_2 setModel("cp_town_creature_egg_sac_destroyed");
  stopFXOnTag(level._effect["vfx_egg_vapor"], var_2, "tag_origin");
  foreach(var_4 in level.plunger_ammo_spots) {
    if(distance(var_4.origin, var_2.origin) > 256) {
      continue;
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_4);
  }

  level waittill("wave_starting");
  level waittill("wave_starting");
  level waittill("wave_starting");
  level waittill("wave_starting");
  level waittill("wave_starting");
  scripts\cp\utility::playsoundinspace("egg_explode_after_refill_ammo", var_2.origin + (0, 0, 40));
  playFX(level._effect["egg_sac_explode"], var_2.origin + (0, 0, 4));
  wait(0.05);
  var_2 setModel("cp_town_creature_egg_sac");
  wait(1);
  playFXOnTag(level._effect["vfx_egg_vapor"], var_2, "tag_origin");
  foreach(var_4 in level.plunger_ammo_spots) {
    if(distance(var_4.origin, var_2.origin) > 256) {
      continue;
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list(var_4);
  }
}

unsetcutieonweaponchange(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("weapon_change");
  var_0.disableplunger = undefined;
  var_0.disablecrank = undefined;
  var_0.cutiechargecount = 0;
  var_0.fired_fov_beam = undefined;
  if(isDefined(var_0.disabledfire) && var_0.disabledfire >= 1) {
    var_0 scripts\engine\utility::allow_fire(1);
  }

  var_0 stopgestureviewmodel("ges_cutie_crank");
  var_0 setscriptablepartstate("cutie_fx", "inactive");
  var_0 notify("end_cutie_gesture_loop");
}

runcutiegestureloop(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("weapon_change");
  var_0 notify("end_cutie_gesture_loop");
  var_0 endon("end_cutie_gesture_loop");
  if(isDefined(var_0.cutiechargecount) && var_0.cutiechargecount >= 5) {
    return;
  }

  var_2 = var_0 func_8513("ges_cutie_crank", "crank_loop_end");
  if(isDefined(var_0.disabledfire) && var_0.disabledfire < 1) {
    var_0 scripts\engine\utility::allow_fire(0);
  }

  var_0.disableplunger = 1;
  var_3 = 5;
  var_0 playgestureviewmodel("ges_cutie_crank", undefined, 0);
  while(var_0.cutiechargecount < var_3 && var_0 adsButtonPressed(1) && var_0 scripts\cp\utility::getvalidtakeweapon() == var_1) {
    wait(0.75);
    var_0.cutiechargecount++;
  }

  var_0 stopgestureviewmodel("ges_cutie_crank");
  if(var_0.cutiechargecount >= var_3) {
    var_0.fired_fov_beam = 1;
    var_0 thread watchforcutiefire(var_0, var_1);
  } else {
    var_0 thread delay_crank_fail_sfx();
  }

  var_0.cutiechargecount = 0;
  if(isDefined(var_0.disabledfire) && var_0.disabledfire >= 1) {
    var_0 scripts\engine\utility::allow_fire(1);
  }

  var_0.disableplunger = undefined;
  var_0 stopgestureviewmodel("ges_cutie_crank");
  wait(1.25);
}

delay_crank_fail_sfx() {
  self endon("disconnect");
  wait(0.05);
  self playlocalsound("purchase_deny");
}

deal_damage_to_zombies_within_fov(var_0, var_1) {
  if(self.vo_prefix == "p5_") {
    thread scripts\cp\cp_vo::try_to_play_vo("ww_3", "town_comment_vo", "low", 10, 0, 0, 0, 20);
  } else {
    thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ww_3", "town_comment_vo", "low", 10, 0, 0, 0, 20);
  }

  thread play_fov_fx();
  var_2 = 1;
  foreach(var_4 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    if(var_4 scripts\cp\utility::agentisfnfimmune()) {
      continue;
    }

    if(scripts\engine\utility::within_fov(self.origin, self.angles, var_4.origin, cos(100))) {
      if(distance2dsquared(self.origin, var_4.origin) <= 250000) {
        var_4.nocorpse = 1;
        var_4.full_gib = 1;
        var_4.affectedbyfovdamage = 1;
        var_4 dodamage(var_2 * var_4.health + 1000, var_4.origin, self, self, "MOD_IMPACT", var_0);
      }
    }
  }
}

play_fov_fx() {
  self setscriptablepartstate("cutiefov", "active");
  self playlocalsound("weap_cutie_cranked_fire_lyr_plr");
  wait(2);
  self setscriptablepartstate("cutiefov", "inactive");
}

watchforcutiefire(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("weapon_change");
  var_0 setscriptablepartstate("cutie_fx", "charged");
  var_0 thread delayed_charged_sound();
  for(;;) {
    var_0 waittill("weapon_fired", var_2);
    if(getweaponbasename(var_2) == getweaponbasename(var_1)) {
      var_3 = var_0 getweaponammoclip(var_2);
      var_4 = var_3 - 4;
      if(var_4 < 0) {
        var_4 = 0;
      }

      var_0 setweaponammoclip(var_2, var_4);
      var_0.cutiechargecount = 0;
      var_0 thread deal_damage_to_zombies_within_fov(var_2, var_3);
      var_0.fired_fov_beam = 0;
      break;
    }
  }

  var_0 setscriptablepartstate("cutie_fx", "power_on");
}

delayed_charged_sound() {
  self endon("disconnect");
  wait(0.1);
  self playlocalsound("weap_cutie_first_raise_plr");
}

fast_travel_hint(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.cooling_down)) {
    return &"COOP_INTERACTIONS_COOLDOWN";
  }

  if(!scripts\engine\utility::istrue(var_0.powered_on)) {
    return &"COOP_INTERACTIONS_REQUIRES_POWER";
  }

  if(!scripts\engine\utility::istrue(var_0.activated)) {
    return &"CP_TOWN_INTERACTIONS_ACTIVATE_FASTTRAVEL";
  }

  if(!scripts\engine\utility::flag("fast_travel_ready")) {
    return &"CP_TOWN_INTERACTIONS_FASTTRAVEL_INACTIVE";
  }

  if(scripts\engine\utility::flag("fast_travel_ready")) {
    return &"CP_TOWN_INTERACTIONS_ENTER_PORTAL";
  }
}

fast_travel_use(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.cooling_down)) {
    return;
  }

  if(scripts\engine\utility::flag("fast_travel_powered") && !scripts\engine\utility::istrue(var_0.activated)) {
    var_0.activated = 1;
    var_2 = scripts\engine\utility::getclosest(var_0.origin, getEntArray("fast_travel", "targetname"));
    var_2 setscriptablepartstate("portal", "idle");
    var_0.portal = var_2;
  }

  if(!scripts\engine\utility::flag("fast_travel_ready")) {
    foreach(var_4 in level.fast_travel_devices) {
      if(!scripts\engine\utility::istrue(var_4.activated)) {
        return;
      }
    }

    scripts\engine\utility::flag_set("fast_travel_ready");
    foreach(var_4 in level.fast_travel_devices) {
      var_4.portal setscriptablepartstate("portal", "on");
    }

    return;
  }

  var_8 = "";
  switch (var_6.name) {
    case "station":
      var_8 = "campsite";
      break;

    case "power":
      var_8 = "station";
      break;

    case "market":
      var_8 = "power";
      break;

    case "campsite":
      var_8 = "market";
      break;
  }

  var_9 = scripts\engine\utility::getStructArray(var_8 + "_fast_travel", "script_noteworthy");
  var_6 thread scripts\cp\maps\cp_town\cp_town_fast_travel::move_player_through_portal_tube(var_7, var_9);
  level thread fast_travel_cooldown(var_6);
}

fast_travel_cooldown(var_0) {
  if(isDefined(var_0.start_cooldown)) {
    return;
  }

  if(!isDefined(var_0.start_cooldown)) {
    var_0.start_cooldown = 1;
  }

  wait(10);
  var_0.cooling_down = 1;
  var_0.portal setscriptablepartstate("portal", "idle");
  wait(60);
  var_0.portal setscriptablepartstate("portal", "on");
  var_0.start_cooldown = undefined;
  var_0.cooling_down = undefined;
}

fast_travel_init() {
  scripts\engine\utility::flag_init("fast_travel_ready");
  scripts\engine\utility::flag_init("fast_travel_powered");
  level.fast_travel_devices = scripts\engine\utility::getStructArray("town_fast_travel", "script_noteworthy");
  level scripts\engine\utility::waittill_any("power_on", level.fast_travel_devices[0].power_area + " power_on");
  foreach(var_1 in level.fast_travel_devices) {
    var_1.cooldown = 0;
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
    var_1.powered_on = 1;
  }

  scripts\engine\utility::flag_set("fast_travel_powered");
  if(scripts\engine\utility::flag_exist("canFiresale")) {
    scripts\engine\utility::flag_set("canFiresale");
  }

  scripts\engine\utility::exploder(206);
}

show_record_debug() {}

jukebox_interaction_hint(var_0, var_1) {
  if(!isDefined(level.music_playing) || level.music_playing != 1) {
    return &"COOP_INTERACTIONS_REQUIRES_POWER";
  }

  if(!isDefined(var_0.is_jukebox_on)) {
    var_0.is_jukebox_on = 1;
  }

  if(var_0.is_jukebox_on) {
    return &"CP_TOWN_INTERACTIONS_JUKEBOX_OFF";
  }

  return &"CP_TOWN_INTERACTIONS_JUKEBOX_ON";
}

disable_pa_speaker_for_town(var_0) {
  disablepaspeaker(var_0);
  level.enabled_jukeboxes = scripts\engine\utility::array_remove(level.enabled_jukeboxes, var_0);
}

enable_pa_speaker_for_town(var_0) {
  enablepaspeaker(var_0);
  level.enabled_jukeboxes = scripts\engine\utility::add_to_array(level.enabled_jukeboxes, var_0);
  level.enabled_jukeboxes = scripts\engine\utility::array_remove_duplicates(level.enabled_jukeboxes);
}

jukebox_use_func(var_0, var_1) {
  if(!isDefined(level.music_playing) || level.music_playing != 1) {
    return;
  }

  if(!isDefined(var_0.is_jukebox_on)) {
    var_0.is_jukebox_on = 1;
  }

  if(!isDefined(level.enabled_jukeboxes)) {
    level.enabled_jukeboxes = [];
  }

  var_1 playgestureviewmodel("ges_thumbs_up_mp");
  var_2 = var_0.is_jukebox_on;
  if(scripts\engine\utility::istrue(var_2)) {
    var_3 = ::disable_pa_speaker_for_town;
  } else {
    var_3 = ::enable_pa_speaker_for_town;
  }

  switch (var_0.script_parameters) {
    case "jukebox_icecream":
      [[var_3]]("pa_town_icecream_out");
      [[var_3]]("pa_town_icecream_in");
      break;

    case "jukebox_market":
      [[var_3]]("pa_town_market_in");
      [[var_3]]("pa_town_market_out");
      break;

    case "jukebox_campgrounds":
      [[var_3]]("pa_town_camper_out");
      break;

    case "jukebox_motel":
      [[var_3]]("pa_town_motel_out");
      break;

    default:
      break;
  }

  var_0.is_jukebox_on = !var_2;
}

record_use_logic(var_0, var_1) {
  var_2 = var_1 getstance();
  switch (var_0.target) {
    case "45_record_1":
      if(var_2 != "prone") {
        return;
      }
      break;

    case "45_record_4":
      if(var_2 != "prone") {
        return;
      }
      break;

    default:
      break;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(!isDefined(level.records_found)) {
    level.records_found = 0;
  }

  var_3 = getent(var_0.target, "targetname");
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  playFX(level._effect["generic_pickup"], var_3.origin);
  var_1 playlocalsound("zmb_item_pickup");
  var_3 delete();
  level.records_found++;
  if(level.records_found >= 5) {
    finished_town_hidden_song();
  }
}

finished_town_hidden_song() {
  level notify("add_hidden_song_to_playlist");
  level thread play_town_hidden_song((0, 0, 0), "mus_pa_town_hidden_track");
}

play_town_hidden_song(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("placed_missing_handle");
  scripts\engine\utility::flag_set("queue_hidden_song", 1);
  if(var_1 == "mus_pa_town_hidden_track") {
    level endon("add_hidden_song_to_playlist");
  }

  if(soundexists(var_1)) {
    wait(2.5);
    foreach(var_3 in level.players) {
      if(scripts\engine\utility::istrue(level.onlinegame)) {
        var_3 setplayerdata("cp", "hasSongsUnlocked", "any_song", 1);
        if(var_1 == "mus_pa_town_hidden_track") {
          var_3 setplayerdata("cp", "hasSongsUnlocked", "song_5", 1);
        }
      }
    }

    scripts\engine\utility::play_sound_in_space("zmb_jukebox_on", var_0);
    var_5 = spawn("script_origin", var_0);
    var_6 = "ee";
    var_7 = 1;
    foreach(var_3 in level.players) {
      var_3 scripts\cp\cp_persistence::give_player_xp(500, 1);
    }

    var_5 playLoopSound(var_1);
    var_5 thread scripts\cp\zombies\zombie_jukebox::earlyendon(var_5);
    var_10 = lookupsoundlength(var_1) / 1000;
    level scripts\engine\utility::waittill_any_timeout(var_10, "skip_song");
    var_5 stoploopsound();
    scripts\engine\utility::flag_set("hidden_song_ended", 1);
    var_5 delete();
  } else {
    wait(2);
  }

  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start(var_0, 1);
}

setup_additional_cutie_ammo() {
  var_0 = scripts\engine\utility::getStructArray("plunger_ammo", "script_noteworthy");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    var_2 = undefined;
  }

  var_4 = [(4836, -3370, -55), (4670, -3302, -55), (4780, -3250, -55), (4845, -3279, -55)];
  var_5 = [(513, 2980, 396), (579, 2944, 396), (577, 2871, 396), (499, 2854, 396), (463, 2922, 396), (519, 686, 426), (558, 634, 426), (524, 571, 426), (458, 579, 426), (444, 646, 426), (1123.5, 625.5, 425), (1076.5, 591.5, 425), (1175.5, 595.5, 425), (1524.5, 893.5, 425), (904, 977, 423), (4777, 392.5, 344), (4784, 339.5, 344), (4765, 286.5, 344), (4835, 261.5, 344), (4917, 265.5, 344), (5426.5, 1025, 342), (5478.5, 975, 342), (5446.5, 894, 342), (5367.5, 900, 342), (5344.5, 959, 342), (5737, -831, 362), (5798.5, -807.5, 362), (732.5, -1718, 212)];
  var_4 = scripts\engine\utility::array_combine(var_4, var_5);
  level.plunger_ammo_spots = [];
  foreach(var_7 in var_4) {
    var_8 = spawnStruct();
    var_8.name = "plunger_ammo";
    var_8.script_noteworthy = "plunger_ammo";
    var_8.origin = var_7;
    var_8.cost = 0;
    var_8.powered_on = 1;
    var_8.spend_type = undefined;
    var_8.script_parameters = "";
    var_8.requires_power = 0;
    var_8.hint_func = ::cutieammohintfunc;
    var_8.activation_func = ::useplungerammo;
    var_8.enabled = 1;
    var_8.disable_guided_interactions = 1;
    level.interactions["plunger_ammo"] = var_8;
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_8);
    level.plunger_ammo_spots[level.plunger_ammo_spots.size] = var_8;
  }

  level.egg_sacs = [];
  add_egg_sac((525.5, 2918.5, 396), (0, 275, 0));
  add_egg_sac((4762, -3329.5, -75), (0, 0, 0));
  add_egg_sac((5778, -861.5, 336.5), (0, 0, 0));
  add_egg_sac((5416.5, 958, 328), (0, 0, 0));
  add_egg_sac((4861, 365.5, 327.5), (0, 0, 0));
  add_egg_sac((1542.5, 958, 410), (0, 85, 0));
  add_egg_sac((1126.5, 574, 410), (0, 115, 0));
  add_egg_sac((806.5, 950, 410), (0, 115, 0));
  add_egg_sac((502.5, 628, 410), (0, 0, 0));
  add_egg_sac((773, -1692, 197.386), (0, 0, 0));
}

add_egg_sac(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("cp_town_creature_egg_sac");
  wait(1);
  playFXOnTag(level._effect["vfx_egg_vapor"], var_2, "tag_origin");
  level.egg_sacs[level.egg_sacs.size] = var_2;
}