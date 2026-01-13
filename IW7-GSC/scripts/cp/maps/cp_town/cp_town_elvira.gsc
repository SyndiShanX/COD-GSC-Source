/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
  var_0 = scripts\engine\utility::getstruct("elvira", "targetname");
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.origin = (353.5, -2560, 534.5);
    var_0.angles = (0, 175, 0);
  }

  level.elvira = spawn("script_model", var_0.origin);
  level.elvira.angles = var_0.angles;
  level.elvira setModel("fullbody_zmb_hero_elvira_couch");
  level.elvira_struct = var_0;
  level.elvira_spellbook = getent("elvira_spellbook", "targetname");
  level.elvira_spellbook hide();
  level thread elvira_idle_loop();
  level thread open_safe();
}

open_safe() {
  var_0 = scripts\engine\utility::getstruct("take_spellbook", "script_noteworthy");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1 = getent("elvira_safe", "targetname");
  var_1 setModel("cp_town_safe");
  level waittill("activate_power");
  var_1 setModel("cp_town_safe_open");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
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
  var_0 = scripts\engine\utility::getstruct("elvira_beach", "script_noteworthy");
  var_1 = scripts\engine\utility::getstruct("elvira_talk", "script_noteworthy");
  for(;;) {
    if(scripts\engine\utility::istrue(level.vo_system_busy)) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
      while(scripts\engine\utility::istrue(level.vo_system_busy)) {
        wait(0.05);
      }

      wait(1);
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
    }

    wait(0.05);
  }
}

init_elvira_beach() {
  var_0 = scripts\engine\utility::getstruct("elvira_beach", "script_noteworthy");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::flag_wait("boss_fight_active");
  level thread delay_elvira_ready_vo();
  level.elvira_spawn_struct = scripts\engine\utility::getstruct("elvira_spawn_beach", "targetname");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  var_1 = getent("elvira_spellbook", "targetname");
  var_2 = getent("elvira_bookstand", "targetname");
  var_1.og_origin = var_1.origin;
  var_1.og_angles = var_1.angles;
  var_2.og_origin = var_2.origin;
  var_2.og_angles = var_2.angles;
  var_3 = scripts\engine\utility::getstruct("elvira_beach_bookstand", "targetname");
  var_4 = scripts\engine\utility::getstruct("elvira_beach_book", "targetname");
  var_1.origin = var_4.origin;
  var_1.angles = var_4.angles;
  var_2.origin = var_3.origin;
  var_2.angles = var_3.angles;
  var_5 = spawnfx(level._effect["vfx_cp_town_book_idle"], var_1.origin + (0, 0, 10), anglesToForward(var_1.angles), anglestoup(var_1.angles));
  wait(1);
  triggerfx(var_5);
  scripts\engine\utility::flag_wait("boss_fight_finished");
  level.elvira_spawn_struct = undefined;
  var_1.origin = var_1.og_origin;
  var_1.angles = var_1.og_angles;
  var_2.origin = var_2.og_origin;
  var_2.angles = var_2.og_angles;
  var_5 delete();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
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

elvira_beach_hint(var_0, var_1) {
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

elvira_beach(var_0, var_1) {
  if(isDefined(level.elvira_available_again) && gettime() < level.elvira_available_again) {
    level thread play_elvira_sound_in_space_vo("el_nag_beachboss_combat_cooldown");
    return;
  }

  if(isDefined(level.elvira_ai)) {
    return;
  }

  if(!scripts\engine\utility::flag("vial_filled")) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    var_0 thread elvira_talks(5);
    wait(5);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    return;
  }

  if(scripts\engine\utility::flag("vial_filled")) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    scripts\engine\utility::flag_set("elvira_summoned");
    wait(0.5);
    scripts\engine\utility::flag_clear("vial_filled");
    elvira_finger_snap();
    level thread spawn_elvira();
    level thread play_elvira_sound_in_space_vo("el_nag_beachboss_combat_inbound");
    wait(1);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    foreach(var_1 in level.players) {
      var_1 scripts\cp\cp_merits::processmerit("mt_dlc3_elvira_summon");
      var_1 notify("elvira_summoned_notify");
    }

    scripts\engine\utility::flag_waitopen("elvira_summoned");
  }
}

play_elvira_sound_in_space_vo(var_0) {
  if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
    scripts\cp\cp_vo::set_vo_system_busy(1);
    scripts\engine\utility::play_sound_in_space(var_0, level.elvira.origin, 0, level.elvira);
    var_1 = scripts\cp\cp_vo::get_sound_length(var_0);
    wait(var_1);
    scripts\cp\cp_vo::set_vo_system_busy(0);
  }
}

elvira_hint(var_0, var_1) {
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

play_elvira_first_meet_vo(var_0) {
  var_1 = "";
  switch (self.vo_prefix) {
    case "p1_":
      var_1 = "sally_meet_elvira_1";
      break;

    case "p2_":
      var_1 = "pdex_meet_elvira_1";
      break;

    case "p3_":
      var_1 = "andre_meet_elvira_1";
      break;

    case "p4_":
      var_1 = "aj_meet_elvira_1";
      break;
  }

  if(!isDefined(var_1) || var_1 == "") {
    return;
  }

  scripts\cp\cp_vo::try_to_play_vo(var_1, "elvira_player_dialogue_vo", "highest", 70, 0, 0, 1);
}

interact_with_elvira(var_0, var_1) {
  if(isDefined(level.elvira_available_again) && gettime() < level.elvira_available_again) {
    elvira_mirror_check(var_1);
    return;
  }

  if(isDefined(level.elvira_ai)) {
    elvira_mirror_check(var_1);
    return;
  }

  if(!scripts\engine\utility::istrue(level.first_meeting_elvira) && !scripts\engine\utility::flag("spellbook_found")) {
    if(var_1.vo_prefix != "p5_") {
      var_1 thread play_elvira_first_meet_vo(var_0);
      level.first_meeting_elvira = 1;
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
      level waittill("dialogue_done");
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
      return;
    } else {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
      if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
        level.first_meeting_elvira = 1;
        scripts\cp\cp_vo::set_vo_system_busy(1);
        var_2 = "el_sally_meet_elvira_10";
        var_1 thread scripts\cp\cp_vo::try_to_play_vo(var_2, "elvira_player_dialogue_vo", "highest", 70, 0, 0, 1);
        var_3 = scripts\cp\cp_vo::get_sound_length(var_2);
        var_0 thread elvira_talks(var_3);
        for(;;) {
          level waittill("dialogue_done", var_4);
          if(var_4 != "elvira_player_dialogue_vo") {
            continue;
          }

          break;
        }

        scripts\cp\cp_vo::set_vo_system_busy(0);
      } else {
        wait(1);
      }

      scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
      return;
    }
  }

  if(scripts\engine\utility::flag("spellbook_placed") && scripts\engine\utility::flag("spellbook_page1_found") && !scripts\engine\utility::flag("spellbook_page1_placed")) {
    playFX(level._effect["vfx_cp_town_book_place"], level.elvira_spellbook.origin + (0, 0, 10), anglesToForward(level.elvira_spellbook.angles), anglestoup(level.elvira_spellbook.angles));
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
      level thread scripts\cp\maps\cp_town\cp_town::play_willard_elvira_exchange("elvira_upgrade2", var_0);
    } else {
      wait(1);
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    }

    scripts\engine\utility::flag_set("spellbook_page1_placed");
    return;
  }

  if(!scripts\engine\utility::flag("spellbook_found")) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
      scripts\cp\cp_vo::set_vo_system_busy(1);
      var_5 = ["el_pap_nag_spellbook_prior", "el_pap_nag_spellbook_prior_2", "el_pap_nag_spellbook_prior_3", "el_pap_nag_spellbook_prior_4"];
      var_2 = scripts\engine\utility::random(var_5);
      var_1 thread scripts\cp\cp_vo::try_to_play_vo(var_2, "elvira_player_dialogue_vo", "highest", 70, 0, 0, 1);
      var_3 = scripts\cp\cp_vo::get_sound_length(var_2);
      var_0 thread elvira_talks(var_3);
      for(;;) {
        level waittill("dialogue_done", var_4);
        if(var_4 != "elvira_player_dialogue_vo") {
          continue;
        }

        break;
      }

      scripts\cp\cp_vo::set_vo_system_busy(0);
    } else {
      wait(1);
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    return;
  }

  if(scripts\engine\utility::flag("spellbook_found") && !scripts\engine\utility::flag("spellbook_placed")) {
    level thread place_elvira_spellbook(var_1);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
      level thread found_book_vo(var_0, var_1);
      wait(32);
    } else {
      wait(1);
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    }

    scripts\cp\utility::set_quest_icon(23);
    scripts\engine\utility::flag_clear("vial_filled");
    level thread crog_vial_meter();
    level.first_meeting_elvira = 1;
    return;
  }

  if(scripts\engine\utility::flag("spellbook_placed") && !scripts\engine\utility::flag("vial_filled")) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
      scripts\cp\cp_vo::set_vo_system_busy(1);
      var_6 = ["el_pap_nag_generic_vial", "el_pap_nag_generic_vial_2", "el_pap_nag_generic_vial_3", "el_pap_nag_generic_vial_4"];
      var_2 = scripts\engine\utility::random(var_6);
      scripts\engine\utility::play_sound_in_space(var_2, level.elvira.origin, 0, level.elvira);
      var_3 = scripts\cp\cp_vo::get_sound_length(var_2);
      var_0 thread elvira_talks(var_3);
      wait(var_3 + 1);
      scripts\cp\cp_vo::set_vo_system_busy(0);
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    return;
  }

  if(scripts\engine\utility::flag("vial_filled")) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    if(!scripts\engine\utility::istrue(level.pause_nag_vo) && !scripts\engine\utility::istrue(level.vo_system_busy)) {
      scripts\cp\cp_vo::set_vo_system_busy(1);
      scripts\engine\utility::play_sound_in_space("el_pap_returned_vial", level.elvira.origin, 0, level.elvira);
      var_3 = scripts\cp\cp_vo::get_sound_length("el_pap_returned_vial");
      var_0 thread elvira_talks(var_3);
      wait(var_3);
      scripts\cp\cp_vo::set_vo_system_busy(0);
    }

    scripts\engine\utility::flag_set("elvira_summoned");
    scripts\engine\utility::flag_clear("vial_filled");
    elvira_finger_snap();
    level thread spawn_elvira();
    wait(1);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    level thread play_escort_elvira_vo(var_0);
    foreach(var_8 in level.players) {
      var_8 scripts\cp\cp_merits::processmerit("mt_dlc3_elvira_summon");
      var_8 notify("elvira_summoned_notify");
    }

    level thread scripts\cp\cp_vo::try_to_play_vo("ww_summon_elvira", "rave_announcer_vo", "highest", 70, 0, 0, 1);
    scripts\engine\utility::flag_waitopen("elvira_summoned");
    return;
  }
}

found_book_vo(var_0, var_1) {
  scripts\cp\maps\cp_town\cp_town::play_willard_elvira_exchange("evirasbook", var_0);
}

play_escort_elvira_vo(var_0) {
  wait(20);
  scripts\cp\maps\cp_town\cp_town::play_willard_elvira_exchange("escortingelvira", var_0);
  if(randomint(100) > 80) {
    wait(20);
    level thread scripts\cp\maps\cp_town\cp_town::play_willard_elvira_exchange("elvira_upgrade1", var_0);
  }
}

elvira_mirror_check(var_0) {
  var_1 = "elvira_mirror";
  if(isDefined(level.mirrors_picked_up[var_1])) {
    return;
  }

  var_2 = getent("elvira_mirror", "targetname");
  scripts\cp\utility::set_quest_icon(8);
  var_0 playlocalsound("part_pickup");
  playFX(level._effect["generic_pickup"], var_2.origin);
  var_2 delete();
  level.mirrors_picked_up[var_1] = 1;
}

place_elvira_spellbook(var_0) {
  scripts\engine\utility::flag_set("spellbook_placed");
  var_0 playlocalsound("zmb_coin_sounvenir_place");
  playFX(level._effect["vfx_cp_town_book_place"], level.elvira_spellbook.origin + (0, 0, 10), anglesToForward(level.elvira_spellbook.angles), anglestoup(level.elvira_spellbook.angles));
  wait(0.45);
  level.elvira_spellbook show();
  playFX(level._effect["vfx_cp_town_book_idle"], level.elvira_spellbook.origin + (0, 0, 10), anglesToForward(level.elvira_spellbook.angles), anglestoup(level.elvira_spellbook.angles));
}

take_elvira_spellbook(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::flag_set("spellbook_found");
  var_2 = getent(var_0.target, "targetname");
  var_1 playlocalsound("part_pickup");
  playFX(level._effect["generic_pickup"], var_2.origin);
  var_2 delete();
  scripts\cp\utility::set_quest_icon(19);
}

take_spellbook_page(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::flag_set("spellbook_page1_found");
  var_2 = getent(var_0.target, "targetname");
  var_1 playlocalsound("part_pickup");
  playFX(level._effect["generic_pickup"], var_2.origin);
  var_2 delete();
  scripts\cp\utility::set_quest_icon(21);
  scripts\cp\utility::set_quest_icon(22);
}

elvira_idle_loop() {
  level notify("elvira_stop_talk_loop");
  level endon("elvira_summoned");
  level endon("elvira_stop_idle_loop");
  var_0 = [ % iw7_cp_elvira_idle_01, % iw7_cp_elvira_idle_02];
  var_1 = ["IW7_cp_elvira_idle_01", "IW7_cp_elvira_idle_02"];
  for(;;) {
    var_2 = scripts\engine\utility::random(var_1);
    var_3 = undefined;
    switch (var_2) {
      case "IW7_cp_elvira_idle_01":
        var_3 = % iw7_cp_elvira_idle_01;
        break;

      case "IW7_cp_elvira_idle_02":
        var_3 = % iw7_cp_elvira_idle_02;
        break;
    }

    var_4 = getanimlength(var_3);
    level.elvira scriptmodelplayanimdeltamotionfrompos(var_2, level.elvira_struct.origin, level.elvira_struct.angles, 1);
    wait(var_4);
    if(scripts\engine\utility::flag("elvira_summoned")) {
      level notify("elvira_ready");
      break;
    }
  }
}

elvira_talks(var_0, var_1) {
  if(isDefined(level.elvira_talking)) {
    return;
  }

  level.elvira_talking = 1;
  level thread elvira_talk_loop();
  wait(var_0);
  level thread elvira_idle_loop();
  wait(0.25);
  level.elvira_talking = undefined;
}

elvira_talk_loop() {
  level notify("elvira_stop_idle_loop");
  level endon("elvira_summoned");
  level endon("elvira_stop_talk_loop");
  var_0 = [ % iw7_cp_elvira_talk_01, % iw7_cp_elvira_talk_02, % iw7_cp_elvira_talk_03, % iw7_cp_elvira_talk_04];
  var_1 = ["IW7_cp_elvira_talk_01", "IW7_cp_elvira_talk_02", "IW7_cp_elvira_talk_03", "IW7_cp_elvira_talk_04"];
  var_2 = 0;
  for(;;) {
    var_3 = scripts\engine\utility::random(var_1);
    var_4 = undefined;
    switch (var_3) {
      case "IW7_cp_elvira_talk_01":
        var_4 = % iw7_cp_elvira_talk_01;
        break;

      case "IW7_cp_elvira_talk_02":
        var_4 = % iw7_cp_elvira_talk_02;
        break;

      case "IW7_cp_elvira_talk_03":
        var_4 = % iw7_cp_elvira_talk_03;
        break;

      case "IW7_cp_elvira_talk_04":
        var_4 = % iw7_cp_elvira_talk_04;
        break;
    }

    var_5 = getanimlength(var_4);
    level.elvira scriptmodelplayanimdeltamotionfrompos(var_3, level.elvira_struct.origin, level.elvira_struct.angles, 1);
    wait(var_5);
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
  var_0 = % iw7_cp_elvira_snap_01;
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
    var_0 = spawnStruct();
    var_0.origin = (261, -2560, 520);
    var_0.angles = (0, 180, 0);
  } else {
    var_0 = level.elvira_spawn_struct;
  }

  for(;;) {
    level.elvira_ai = scripts\cp\zombies\zombies_spawning::func_33B1("elvira", var_0.origin, var_0.angles, "allies", undefined, "iw7_erad_zm");
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
  var_0 = 0;
  for(;;) {
    var_1 = level scripts\engine\utility::waittill_any_return("cleaver_kill", "cleaver_kill_zombie", "cleaver_damage_zombie");
    if(scripts\engine\utility::flag("vial_filled")) {
      continue;
    }

    if(var_1 == "cleaver_kill") {
      var_0 = var_0 + 0.1;
    } else if(var_1 == "cleaver_kill_zombie") {
      var_0 = var_0 + 0.05;
    } else if(var_1 == "cleaver_damage_zombie") {
      var_0 = var_0 + 0.01;
    }

    if(var_0 >= 1) {
      setomnvar("zom_general_fill_percent_2", 1);
      scripts\engine\utility::flag_set("vial_filled");
      scripts\engine\utility::flag_waitopen("vial_filled");
      var_0 = 0;
      setomnvar("zom_general_fill_percent_2", 0);
      continue;
    }

    setomnvar("zom_general_fill_percent_2", var_0);
  }
}

elvira_timely_torrent(var_0) {
  wait(1);
  level endon("game_ended");
  var_1 = [];
  var_2 = 0;
  var_3 = scripts\cp\cp_agent_utils::get_alive_enemies();
  foreach(var_6, var_5 in var_3) {
    if(isDefined(var_5.flung)) {
      continue;
    }

    if(!isDefined(var_5.agent_type)) {
      continue;
    }

    if(distancesquared(var_5.origin, self.origin) > 810000) {
      continue;
    }

    if(scripts\engine\utility::within_fov(self.origin, self.angles, var_5.origin, cos(60))) {
      level thread torrent_kill_zombie(var_5, var_6);
    }
  }
}

torrent_kill_zombie(var_0, var_1) {
  var_0 endon("death");
  level endon("game_ended");
  if(var_1 % 3 == 0) {
    playsoundatpos(var_0.origin, "zmb_fnf_timely_torrent_lava");
  }

  playFX(level._effect["lava_torrent"], var_0.origin, undefined, anglestoup((0, 0, 90)));
  if(var_0.agent_type != "crab_brute") {
    var_0.flung = 1;
    var_0.do_immediate_ragdoll = 1;
    var_0.disable_armor = 1;
    var_0 setsolid(0);
    var_0 setvelocity((0, 0, 600));
    wait(0.1);
    if(isDefined(var_0)) {
      var_0 dodamage(10000, var_0.origin);
      return;
    }

    return;
  }

  if(isDefined(var_0)) {
    var_0 dodamage(1000, var_0.origin);
  }
}