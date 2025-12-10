/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_elvira.gsc
******************************************************/

init_elvira() {
  scripts\engine\utility::flag_init("spellbook_found");
  scripts\engine\utility::flag_init("vial_filled");
  scripts\engine\utility::flag_init("spellbook_placed");
  scripts\engine\utility::flag_init("spellbook_page1_found");
  scripts\engine\utility::flag_init("spellbook_page1_placed");
  scripts\engine\utility::flag_init("spellbook_page2_found");
  scripts\engine\utility::flag_init("spellbook_page2_placed");
  scripts\engine\utility::flag_init("elvira_summoned");
  wait(10);
  var_00 = scripts\engine\utility::getstruct("elvira", "targetname");
  if(!isDefined(var_00)) {
    var_00 = spawnStruct();
    var_00.origin = (353.5, -2560, 534.5);
    var_00.angles = (0, 175, 0);
  }

  level.elvira = spawn("script_model", var_00.origin);
  level.elvira.angles = var_00.angles;
  level.elvira setModel("fullbody_zmb_hero_elvira_couch");
  level.elvira_struct = var_00;
  level.elvira_spellbook = getent("elvira_spellbook", "targetname");
  level.elvira_spellbook hide();
  level thread elvira_idle_loop();
  level thread open_safe();
}

open_safe() {
  var_00 = scripts\engine\utility::getstruct("take_spellbook", "script_noteworthy");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_00);
  var_01 = getent("elvira_safe", "targetname");
  var_01 setModel("cp_town_safe");
  level waittill("activate_power");
  var_01 setModel("cp_town_safe_open");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_00);
}

register_elvira_interactions() {
  level.interaction_hintstrings["elvira_talk"] = &"CP_TOWN_INTERACTIONS_SPEAK_WITH_ELVIRA";
  level.interaction_hintstrings["take_spellbook"] = "";
  level.interaction_hintstrings["spell_page"] = "";
  level.interaction_hintstrings["elvira_beach"] = &"CP_TOWN_INTERACTIONS_SUMMON_ELVIRA";
  scripts\cp\cp_interaction::register_interaction("elvira_talk", "arcade_game", undefined, ::elvira_hint, ::interact_with_elvira, 0);
  scripts\cp\cp_interaction::register_interaction("elvira_beach", "arcade_game", undefined, ::elvira_beach_hint, ::elvira_beach, 0, 0, ::init_elvira_beach);
  scripts\cp\cp_interaction::register_interaction("take_spellbook", "arcade_game", undefined, undefined, ::take_elvira_spellbook, 0, 1);
  scripts\cp\cp_interaction::register_interaction("spell_page", "arcade_game", undefined, undefined, ::take_spellbook_page, 0, 1);
  level.interactions["take_spellbook"].disable_guided_interactions = 1;
  level.interactions["spell_page"].disable_guided_interactions = 1;
  level thread elvira_interaction_monitor();
}

elvira_interaction_monitor() {
  var_00 = scripts\engine\utility::getstruct("elvira_beach", "script_noteworthy");
  var_01 = scripts\engine\utility::getstruct("elvira_talk", "script_noteworthy");
  for(;;) {
    if(scripts\engine\utility::istrue(level.vo_system_busy)) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_01);
      while(scripts\engine\utility::istrue(level.vo_system_busy)) {
        wait(0.05);
      }

      wait(1);
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
    }

    wait(0.05);
  }
}

init_elvira_beach() {
  var_00 = scripts\engine\utility::getstruct("elvira_beach", "script_noteworthy");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_00);
  scripts\engine\utility::flag_wait("boss_fight_active");
  level thread delay_elvira_ready_vo();
  level.elvira_spawn_struct = scripts\engine\utility::getstruct("elvira_spawn_beach", "targetname");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_00);
  var_01 = getent("elvira_spellbook", "targetname");
  var_02 = getent("elvira_bookstand", "targetname");
  var_01.og_origin = var_01.origin;
  var_01.og_angles = var_01.angles;
  var_02.og_origin = var_02.origin;
  var_02.og_angles = var_02.angles;
  var_03 = scripts\engine\utility::getstruct("elvira_beach_bookstand", "targetname");
  var_04 = scripts\engine\utility::getstruct("elvira_beach_book", "targetname");
  var_01.origin = var_04.origin;
  var_01.angles = var_04.angles;
  var_02.origin = var_03.origin;
  var_02.angles = var_03.angles;
  var_05 = spawnfx(level._effect["vfx_cp_town_book_idle"], var_01.origin + (0, 0, 10), anglesToForward(var_01.angles), anglestoup(var_01.angles));
  wait(1);
  triggerfx(var_05);
  scripts\engine\utility::flag_wait("boss_fight_finished");
  level.elvira_spawn_struct = undefined;
  var_01.origin = var_01.og_origin;
  var_01.angles = var_01.og_angles;
  var_02.origin = var_02.og_origin;
  var_02.angles = var_02.og_angles;
  var_05 delete();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_00);
}

delay_elvira_ready_vo() {
  level endon("game_ended");
  level endon("elvira_summoned");
  wait(45);
  if(isDefined(level.elvira_ai)) {
    return;
  }

  if(isDefined(level.elvira_available_again) && gettime() < level.elvira_available_again) {
    return;
  }

  if(!scripts\engine\utility::flag("vial_filled")) {
    return;
  }

  level thread play_elvira_sound_in_space_vo("el_nag_beachboss_combat_ready");
}

elvira_beach_hint(param_00, param_01) {
  if(isDefined(level.elvira_ai)) {
    return &"CP_TOWN_INTERACTIONS_ELVIRA_GONE";
  }

  if(isDefined(level.elvira_available_again) && gettime() < level.elvira_available_again) {
    return &"CP_TOWN_INTERACTIONS_ELVIRA_GONE";
  }

  if(scripts\engine\utility::flag("vial_filled")) {
    return &"CP_TOWN_INTERACTIONS_GIVE_VIAL";
  }

  return level.interaction_hintstrings["elvira_beach"];
}

elvira_beach(param_00, param_01) {
  if(isDefined(level.elvira_available_again) && gettime() < level.elvira_available_again) {
    level thread play_elvira_sound_in_space_vo("el_nag_beachboss_combat_cooldown");
    return;
  }

  if(isDefined(level.elvira_ai)) {
    return;
  }

  if(!scripts\engine\utility::flag("vial_filled")) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    param_00 thread elvira_talks(5);
    wait(5);
    scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
    return;
  }

  if(scripts\engine\utility::flag("vial_filled")) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    scripts\engine\utility::flag_set("elvira_summoned");
    wait(0.5);
    scripts\engine\utility::flag_clear("vial_filled");
    elvira_finger_snap();
    level thread spawn_elvira();
    level thread play_elvira_sound_in_space_vo("el_nag_beachboss_combat_inbound");
    wait(1);
    scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
    foreach(param_01 in level.players) {
      param_01 scripts\cp\cp_merits::processmerit("mt_dlc3_elvira_summon");
      param_01 notify("elvira_summoned_notify");
    }

    scripts\engine\utility::flag_waitopen("elvira_summoned");
  }
}

play_elvira_sound_in_space_vo(param_00) {
  if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
    scripts\cp\cp_vo::set_vo_system_busy(1);
    scripts\engine\utility::play_sound_in_space(param_00, level.elvira.origin, 0, level.elvira);
    var_01 = scripts\cp\cp_vo::get_sound_length(param_00);
    wait(var_01);
    scripts\cp\cp_vo::set_vo_system_busy(0);
  }
}

elvira_hint(param_00, param_01) {
  if(isDefined(level.elvira_ai)) {
    return &"CP_TOWN_INTERACTIONS_ELVIRA_GONE";
  }

  if(isDefined(level.elvira_available_again) && gettime() < level.elvira_available_again) {
    return &"CP_TOWN_INTERACTIONS_ELVIRA_GONE";
  }

  if(scripts\engine\utility::flag("spellbook_found") && !scripts\engine\utility::flag("spellbook_placed")) {
    return &"CP_TOWN_INTERACTIONS_GIVE_BOOK";
  }

  if(scripts\engine\utility::flag("spellbook_placed") && scripts\engine\utility::flag("spellbook_page1_found") && !scripts\engine\utility::flag("spellbook_page1_placed")) {
    return &"CP_TOWN_INTERACTIONS_GIVE_PAGES";
  }

  if(scripts\engine\utility::flag("vial_filled")) {
    return &"CP_TOWN_INTERACTIONS_GIVE_VIAL";
  }

  return level.interaction_hintstrings["elvira_talk"];
}

play_elvira_first_meet_vo(param_00) {
  var_01 = "";
  switch (self.vo_prefix) {
    case "p1_":
      var_01 = "sally_meet_elvira_1";
      break;

    case "p2_":
      var_01 = "pdex_meet_elvira_1";
      break;

    case "p3_":
      var_01 = "andre_meet_elvira_1";
      break;

    case "p4_":
      var_01 = "aj_meet_elvira_1";
      break;
  }

  if(!isDefined(var_01) || var_01 == "") {
    return;
  }

  scripts\cp\cp_vo::try_to_play_vo(var_01, "elvira_player_dialogue_vo", "highest", 70, 0, 0, 1);
}

interact_with_elvira(param_00, param_01) {
  if(isDefined(level.elvira_available_again) && gettime() < level.elvira_available_again) {
    elvira_mirror_check(param_01);
    return;
  }

  if(isDefined(level.elvira_ai)) {
    elvira_mirror_check(param_01);
    return;
  }

  if(!scripts\engine\utility::istrue(level.first_meeting_elvira) && !scripts\engine\utility::flag("spellbook_found")) {
    if(param_01.vo_prefix != "p5_") {
      param_01 thread play_elvira_first_meet_vo(param_00);
      level.first_meeting_elvira = 1;
      scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
      level waittill("dialogue_done");
      scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
      return;
    } else {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
      if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
        level.first_meeting_elvira = 1;
        scripts\cp\cp_vo::set_vo_system_busy(1);
        var_02 = "el_sally_meet_elvira_10";
        param_01 thread scripts\cp\cp_vo::try_to_play_vo(var_02, "elvira_player_dialogue_vo", "highest", 70, 0, 0, 1);
        var_03 = scripts\cp\cp_vo::get_sound_length(var_02);
        param_00 thread elvira_talks(var_03);
        for(;;) {
          level waittill("dialogue_done", var_04);
          if(var_04 != "elvira_player_dialogue_vo") {
            continue;
          }

          break;
        }

        scripts\cp\cp_vo::set_vo_system_busy(0);
      } else {
        wait(1);
      }

      scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
      return;
    }
  }

  if(scripts\engine\utility::flag("spellbook_placed") && scripts\engine\utility::flag("spellbook_page1_found") && !scripts\engine\utility::flag("spellbook_page1_placed")) {
    playFX(level._effect["vfx_cp_town_book_place"], level.elvira_spellbook.origin + (0, 0, 10), anglesToForward(level.elvira_spellbook.angles), anglestoup(level.elvira_spellbook.angles));
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
      level thread scripts\cp\maps\cp_town\cp_town::play_willard_elvira_exchange("elvira_upgrade2", param_00);
    } else {
      wait(1);
      scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
    }

    scripts\engine\utility::flag_set("spellbook_page1_placed");
    return;
  }

  if(!scripts\engine\utility::flag("spellbook_found")) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
      scripts\cp\cp_vo::set_vo_system_busy(1);
      var_05 = ["el_pap_nag_spellbook_prior", "el_pap_nag_spellbook_prior_2", "el_pap_nag_spellbook_prior_3", "el_pap_nag_spellbook_prior_4"];
      var_02 = scripts\engine\utility::random(var_05);
      param_01 thread scripts\cp\cp_vo::try_to_play_vo(var_02, "elvira_player_dialogue_vo", "highest", 70, 0, 0, 1);
      var_03 = scripts\cp\cp_vo::get_sound_length(var_02);
      param_00 thread elvira_talks(var_03);
      for(;;) {
        level waittill("dialogue_done", var_04);
        if(var_04 != "elvira_player_dialogue_vo") {
          continue;
        }

        break;
      }

      scripts\cp\cp_vo::set_vo_system_busy(0);
    } else {
      wait(1);
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
    return;
  }

  if(scripts\engine\utility::flag("spellbook_found") && !scripts\engine\utility::flag("spellbook_placed")) {
    level thread place_elvira_spellbook(param_01);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
      level thread found_book_vo(param_00, param_01);
      wait(32);
    } else {
      wait(1);
      scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
    }

    scripts\cp\utility::set_quest_icon(23);
    scripts\engine\utility::flag_clear("vial_filled");
    level thread crog_vial_meter();
    level.first_meeting_elvira = 1;
    return;
  }

  if(scripts\engine\utility::flag("spellbook_placed") && !scripts\engine\utility::flag("vial_filled")) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
      scripts\cp\cp_vo::set_vo_system_busy(1);
      var_06 = ["el_pap_nag_generic_vial", "el_pap_nag_generic_vial_2", "el_pap_nag_generic_vial_3", "el_pap_nag_generic_vial_4"];
      var_02 = scripts\engine\utility::random(var_06);
      scripts\engine\utility::play_sound_in_space(var_02, level.elvira.origin, 0, level.elvira);
      var_03 = scripts\cp\cp_vo::get_sound_length(var_02);
      param_00 thread elvira_talks(var_03);
      wait(var_03 + 1);
      scripts\cp\cp_vo::set_vo_system_busy(0);
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
    return;
  }

  if(scripts\engine\utility::flag("vial_filled")) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
      scripts\cp\cp_vo::set_vo_system_busy(1);
      scripts\engine\utility::play_sound_in_space("el_pap_returned_vial", level.elvira.origin, 0, level.elvira);
      var_03 = scripts\cp\cp_vo::get_sound_length("el_pap_returned_vial");
      param_00 thread elvira_talks(var_03);
      wait(var_03);
      scripts\cp\cp_vo::set_vo_system_busy(0);
    }

    scripts\engine\utility::flag_set("elvira_summoned");
    scripts\engine\utility::flag_clear("vial_filled");
    elvira_finger_snap();
    level thread spawn_elvira();
    wait(1);
    scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
    level thread play_escort_elvira_vo(param_00);
    foreach(var_08 in level.players) {
      var_08 scripts\cp\cp_merits::processmerit("mt_dlc3_elvira_summon");
      var_08 notify("elvira_summoned_notify");
    }

    level thread scripts\cp\cp_vo::try_to_play_vo("ww_summon_elvira", "rave_announcer_vo", "highest", 70, 0, 0, 1);
    scripts\engine\utility::flag_waitopen("elvira_summoned");
    return;
  }
}

found_book_vo(param_00, param_01) {
  scripts\cp\maps\cp_town\cp_town::play_willard_elvira_exchange("evirasbook", param_00);
}

play_escort_elvira_vo(param_00) {
  wait(20);
  scripts\cp\maps\cp_town\cp_town::play_willard_elvira_exchange("escortingelvira", param_00);
  if(randomint(100) > 80) {
    wait(20);
    level thread scripts\cp\maps\cp_town\cp_town::play_willard_elvira_exchange("elvira_upgrade1", param_00);
  }
}

elvira_mirror_check(param_00) {
  var_01 = "elvira_mirror";
  if(isDefined(level.mirrors_picked_up[var_01])) {
    return;
  }

  var_02 = getent("elvira_mirror", "targetname");
  scripts\cp\utility::set_quest_icon(8);
  param_00 playlocalsound("part_pickup");
  playFX(level._effect["generic_pickup"], var_02.origin);
  var_02 delete();
  level.mirrors_picked_up[var_01] = 1;
}

place_elvira_spellbook(param_00) {
  scripts\engine\utility::flag_set("spellbook_placed");
  param_00 playlocalsound("zmb_coin_sounvenir_place");
  playFX(level._effect["vfx_cp_town_book_place"], level.elvira_spellbook.origin + (0, 0, 10), anglesToForward(level.elvira_spellbook.angles), anglestoup(level.elvira_spellbook.angles));
  wait(0.45);
  level.elvira_spellbook show();
  playFX(level._effect["vfx_cp_town_book_idle"], level.elvira_spellbook.origin + (0, 0, 10), anglesToForward(level.elvira_spellbook.angles), anglestoup(level.elvira_spellbook.angles));
}

take_elvira_spellbook(param_00, param_01) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  scripts\engine\utility::flag_set("spellbook_found");
  var_02 = getent(param_00.target, "targetname");
  param_01 playlocalsound("part_pickup");
  playFX(level._effect["generic_pickup"], var_02.origin);
  var_02 delete();
  scripts\cp\utility::set_quest_icon(19);
}

take_spellbook_page(param_00, param_01) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  scripts\engine\utility::flag_set("spellbook_page1_found");
  var_02 = getent(param_00.target, "targetname");
  param_01 playlocalsound("part_pickup");
  playFX(level._effect["generic_pickup"], var_02.origin);
  var_02 delete();
  scripts\cp\utility::set_quest_icon(21);
  scripts\cp\utility::set_quest_icon(22);
}

elvira_idle_loop() {
  level notify("elvira_stop_talk_loop");
  level endon("elvira_summoned");
  level endon("elvira_stop_idle_loop");
  var_00 = [ % iw7_cp_elvira_idle_01, % iw7_cp_elvira_idle_02];
  var_01 = ["IW7_cp_elvira_idle_01", "IW7_cp_elvira_idle_02"];
  for(;;) {
    var_02 = scripts\engine\utility::random(var_01);
    var_03 = undefined;
    switch (var_02) {
      case "IW7_cp_elvira_idle_01":
        var_03 = % iw7_cp_elvira_idle_01;
        break;

      case "IW7_cp_elvira_idle_02":
        var_03 = % iw7_cp_elvira_idle_02;
        break;
    }

    var_04 = getanimlength(var_03);
    level.elvira scriptmodelplayanimdeltamotionfrompos(var_02, level.elvira_struct.origin, level.elvira_struct.angles, 1);
    wait(var_04);
    if(scripts\engine\utility::flag("elvira_summoned")) {
      level notify("elvira_ready");
      break;
    }
  }
}

elvira_talks(param_00, param_01) {
  if(isDefined(level.elvira_talking)) {
    return;
  }

  level.elvira_talking = 1;
  level thread elvira_talk_loop();
  wait(param_00);
  level thread elvira_idle_loop();
  wait(0.25);
  level.elvira_talking = undefined;
}

elvira_talk_loop() {
  level notify("elvira_stop_idle_loop");
  level endon("elvira_summoned");
  level endon("elvira_stop_talk_loop");
  var_00 = [ % iw7_cp_elvira_talk_01, % iw7_cp_elvira_talk_02, % iw7_cp_elvira_talk_03, % iw7_cp_elvira_talk_04];
  var_01 = ["IW7_cp_elvira_talk_01", "IW7_cp_elvira_talk_02", "IW7_cp_elvira_talk_03", "IW7_cp_elvira_talk_04"];
  var_02 = 0;
  for(;;) {
    var_03 = scripts\engine\utility::random(var_01);
    var_04 = undefined;
    switch (var_03) {
      case "IW7_cp_elvira_talk_01":
        var_04 = % iw7_cp_elvira_talk_01;
        break;

      case "IW7_cp_elvira_talk_02":
        var_04 = % iw7_cp_elvira_talk_02;
        break;

      case "IW7_cp_elvira_talk_03":
        var_04 = % iw7_cp_elvira_talk_03;
        break;

      case "IW7_cp_elvira_talk_04":
        var_04 = % iw7_cp_elvira_talk_04;
        break;
    }

    var_05 = getanimlength(var_04);
    level.elvira scriptmodelplayanimdeltamotionfrompos(var_03, level.elvira_struct.origin, level.elvira_struct.angles, 1);
    wait(var_05);
    if(scripts\engine\utility::flag("elvira_summoned")) {
      level notify("elvira_ready");
      break;
    }
  }
}

elvira_finger_snap() {
  scripts\engine\utility::flag_set("elvira_summoned");
  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(1);
  wait(1);
  var_00 = % iw7_cp_elvira_snap_01;
  level.elvira scriptmodelplayanimdeltamotionfrompos("IW7_cp_elvira_snap_01", level.elvira_struct.origin, level.elvira_struct.angles, 1);
  wait(1.1);
  playsoundatpos(level.elvira.origin, "town_elvira_vanish");
  playFX(level._effect["elvira_couch_smoke"], level.elvira.origin);
  level.elvira hide();
  wait(1);
}

spawn_elvira() {
  level.elvira_ai = undefined;
  if(!isDefined(level.elvira_spawn_struct)) {
    var_00 = spawnStruct();
    var_00.origin = (261, -2560, 520);
    var_00.angles = (0, 180, 0);
  } else {
    var_00 = level.elvira_spawn_struct;
  }

  for(;;) {
    level.elvira_ai = scripts\cp\zombies\zombies_spawning::func_33B1("elvira", var_00.origin, var_00.angles, "allies", undefined, "iw7_erad_zm");
    if(!isDefined(level.elvira_ai)) {
      wait(0.2);
      continue;
    } else {
      break;
    }
  }

  level.elvira_ai.a.rockets = 5;
  level.elvira_ai.health = 100000;
  level.elvira_ai.maxhealth = 100000;
  level.elvira_ai setCanDamage(0);
  level.elvira_ai.allowpain = 0;
  level.elvira_ai.ignoreme = 1;
  level.elvira_ai.can_revive = 1;
  level.elvira_ai.var_FFEF = 1;
  playFX(level._effect["elvira_stand_smoke"], level.elvira_ai.origin);
  playsoundatpos(level.elvira_ai.origin, "town_elvira_appear");
  level thread elvira_spawned_vo();
  level scripts\cp\utility::set_completed_quest_mark(2);
}

elvira_spawned_vo() {
  wait(90);
  if(!scripts\engine\utility::istrue(level.anomaly_revealed)) {
    if(isDefined(level.elvira_ai)) {
      scripts\engine\utility::play_sound_in_space("el_pap_nag_energy_warn_timeout", level.elvira_ai.origin, 0, level.elvira_ai);
      return;
    }

    if(isDefined(level.elvira)) {
      scripts\engine\utility::play_sound_in_space("el_pap_nag_energy_warn_timeout", level.elvira.origin, 0, level.elvira);
      return;
    }
  }
}

crog_vial_meter() {
  var_00 = 0;
  for(;;) {
    var_01 = level scripts\engine\utility::waittill_any_return("cleaver_kill", "cleaver_kill_zombie", "cleaver_damage_zombie");
    if(scripts\engine\utility::flag("vial_filled")) {
      continue;
    }

    if(var_01 == "cleaver_kill") {
      var_00 = var_00 + 0.1;
    } else if(var_01 == "cleaver_kill_zombie") {
      var_00 = var_00 + 0.05;
    } else if(var_01 == "cleaver_damage_zombie") {
      var_00 = var_00 + 0.01;
    }

    if(var_00 >= 1) {
      setomnvar("zom_general_fill_percent_2", 1);
      scripts\engine\utility::flag_set("vial_filled");
      scripts\engine\utility::flag_waitopen("vial_filled");
      var_00 = 0;
      setomnvar("zom_general_fill_percent_2", 0);
      continue;
    }

    setomnvar("zom_general_fill_percent_2", var_00);
  }
}

elvira_timely_torrent(param_00) {
  wait(1);
  level endon("game_ended");
  var_01 = [];
  var_02 = 0;
  var_03 = scripts\cp\cp_agent_utils::get_alive_enemies();
  foreach(var_06, var_05 in var_03) {
    if(isDefined(var_05.flung)) {
      continue;
    }

    if(!isDefined(var_05.agent_type)) {
      continue;
    }

    if(distancesquared(var_05.origin, self.origin) > 810000) {
      continue;
    }

    if(scripts\engine\utility::within_fov(self.origin, self.angles, var_05.origin, cos(60))) {
      level thread torrent_kill_zombie(var_05, var_06);
    }
  }
}

torrent_kill_zombie(param_00, param_01) {
  param_00 endon("death");
  level endon("game_ended");
  if(param_01 % 3 == 0) {
    playsoundatpos(param_00.origin, "zmb_fnf_timely_torrent_lava");
  }

  playFX(level._effect["lava_torrent"], param_00.origin, undefined, anglestoup((0, 0, 90)));
  if(param_00.agent_type != "crab_brute") {
    param_00.flung = 1;
    param_00.do_immediate_ragdoll = 1;
    param_00.disable_armor = 1;
    param_00 setsolid(0);
    param_00 setvelocity((0, 0, 600));
    wait(0.1);
    if(isDefined(param_00)) {
      param_00 dodamage(10000, param_00.origin);
      return;
    }

    return;
  }

  if(isDefined(param_00)) {
    param_00 dodamage(1000, param_00.origin);
  }
}