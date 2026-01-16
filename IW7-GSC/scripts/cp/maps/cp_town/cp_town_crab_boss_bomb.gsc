/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_crab_boss_bomb.gsc
**************************************************************/

start_detonate_bomb() {
  level thread detonate_bomb_timer();
  setup_bomb_lights();
  reset_bomb_interaction_struct();
  var_0 = randomize_bomb_interaction_structs();
  foreach(var_3, var_2 in level.players) {
    var_2 thread exit_early_from_all_active_consumables(var_2);
    var_2 thread enter_detonate_bomb_sequence(var_2, var_0[var_3]);
  }

  if(!isDefined(level.bomb_detonation_attempts)) {
    level.bomb_detonation_attempts = 0;
  }

  level.bomb_detonation_attempts = level.bomb_detonation_attempts + 1;
}

exit_early_from_all_active_consumables(var_0) {
  var_1 = getarraykeys(var_0.consumables);
  if(var_0 scripts\cp\utility::are_any_consumables_active()) {
    foreach(var_3 in var_1) {
      if(var_3 == "bh_gun" || var_3 == "atomizer_gun" || var_3 == "claw_gun" || var_3 == "steel_dragon" || var_3 == "penetration_gun") {
        var_0 notify(var_3 + "_exited_early");
      }
    }
  }
}

refill_fnf_cards_after_bomb_explosion(var_0) {
  var_0 scripts\cp\zombies\zombies_consumables::reset_meter();
  var_0 thread scripts\cp\zombies\zombies_consumables::turn_on_cards();
  var_0 thread scripts\cp\zombies\zombies_consumables::meter_fill_up();
}

enter_bomb_code(var_0, var_1) {
  enter_bomb_code_internal(var_0, var_1);
}

enter_bomb_code_internal(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1.bomb_interaction_struct = var_0;
  reset_nuclear_code_progress(var_1);
  transition_into_enter_bomb_code(var_0, var_1);
  turn_on_enter_bomb_code_hud(var_1, var_0);
  var_0 thread run_bomb_counters(var_1, var_0);
  var_0 thread bomb_counter_selected_monitor(var_1, var_0);
  var_0 thread player_exit_monitor(var_1, var_0);
}

run_bomb_counters(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 notify("run_bomb_counters");
  var_1 endon("exit_enter_bomb_code");
  var_1 endon("run_bomb_counters");
  for(;;) {
    for(var_2 = 0; var_2 < 10; var_2++) {
      var_0 setclientomnvar("zm_ui_dialpad_0", var_2 + 1);
      wait(0.1);
    }
  }
}

bomb_counter_selected_monitor(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 notify("bomb_counter_selected_monitor");
  var_1 endon("exit_enter_bomb_code");
  var_1 endon("bomb_counter_selected_monitor");
  for(;;) {
    var_0 waittill("luinotifyserver", var_2, var_3);
    if(var_2 != "bomb_counter_digit") {
      continue;
    }

    if(correct_digit_entered(var_0, var_3)) {
      advance_nuclear_code_progress(var_0, var_3);
      var_4 = nuclear_code_completed(var_0);
      correct_sfx(var_0, var_4);
      if(var_4) {
        player_complete_nuclear_code(var_1, var_0);
      }

      continue;
    }

    input_wrong_digit(var_1, var_0);
  }
}

correct_sfx(var_0, var_1) {
  if(var_1) {
    var_0 playlocalsound("cp_town_timer_final_pass");
    return;
  }

  var_0 playlocalsound("cp_town_timer_single_pass");
}

player_exit_monitor(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 notify("player_exit_monitor");
  var_1 endon("exit_enter_bomb_code");
  var_1 endon("player_exit_monitor");
  for(;;) {
    var_0 waittill("luinotifyserver", var_2);
    if(var_2 != "exit_bomb_counter") {
      continue;
    }

    var_1 thread delay_enable_interaction(var_1);
    var_1 thread exit_enter_bomb_code(var_1, var_0);
  }
}

turn_on_enter_bomb_code_hud(var_0, var_1) {
  var_2 = anglesToForward(var_1.bomb_panel_model.angles);
  var_3 = spawn("script_model", var_1.bomb_panel_model.origin + var_2 * 15);
  var_3 setModel("tag_origin");
  var_3.angles = var_1.bomb_counter.angles;
  var_1.bomb_counter_ent = var_3;
  var_0 setclientomnvar("zm_ui_dialpad_ent", var_3);
  var_0 setclientomnvar("zm_ui_dialpad_2", 1);
  var_0 playLoopSound("cp_town_timer_lp");
}

turn_off_enter_bomb_code_hud(var_0) {
  var_0 setclientomnvar("zm_ui_dialpad_2", 0);
  var_0 stoploopsound("cp_town_timer_lp");
}

enter_detonate_bomb_sequence(var_0, var_1) {
  turn_off_other_hud(var_0);
  setup_bomb_panel(var_1);
  teleport_into_boss_crab(var_0, var_1);
  turn_on_bomb_status_light(var_1);
  var_0.weapon_before_bomb_sequence = var_0 scripts\cp\utility::getweapontoswitchbackto();
  var_0 scripts\cp\zombies\arcade_game_utility::take_player_super_pre_game();
  var_0.disable_self_revive_fnf = 1;
  var_0.allow_carry = 0;
  var_0.disable_consumables = 1;
  var_0 store_and_take_perks(var_0);
  var_0 allowmelee(0);
  var_0 giveweapon("iw7_gunless_zm");
  var_0 switchtoweaponimmediate("iw7_gunless_zm");
  var_0 scripts\engine\utility::allow_weapon_switch(0);
  var_0.powers_before_entangler = var_0 scripts\cp\powers\coop_powers::get_info_for_player_powers(var_0);
  var_0 scripts\cp\powers\coop_powers::clearpowers();
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_phase_6_crog_inside");
}

end_detonate_bomb(var_0) {
  foreach(var_2 in level.players) {
    var_2 thread exit_detonate_bomb_sequence(var_2);
  }

  foreach(var_5 in level.bomb_interaction_structs) {
    clean_up_bomb_interaction_struct(var_5);
  }

  delete_bomb_lights();
  if(scripts\engine\utility::istrue(var_0)) {
    level thread crab_boss_death_sequence();
  } else {
    scripts\cp\maps\cp_town\cp_town_crab_boss_fight::replay_final_sequence();
  }

  level notify("end_detonate_bomb");
}

crab_boss_death_sequence() {
  scripts\engine\utility::flag_clear("boss_fight_active");
  scripts\engine\utility::flag_set("boss_fight_finished");
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    level.crab_boss.nocorpse = 1;
    level.crab_boss suicide();
    level thread scripts\cp\zombies\direct_boss_fight::success_sequence(5, 4);
    return;
  }

  if(isDefined(level.crab_boss)) {
    level thread crab_boss_death_anim_sequence(level.crab_boss);
    scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall::deactivate_final_sequence_blocker();
    scripts\cp\maps\cp_town\cp_town_crab_boss_fight::deactivate_crab_boss_fight_blocker();
  }

  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::move_lost_and_found("tent");
  level.force_respawn_location = undefined;
  level.disable_loot_fly_to_player = 0;
  level.loot_time_out = undefined;
  level.wave_num_override = undefined;
  level notify("crab_boss_fight_complete");
  level thread clear_existing_enemies();
  level thread delay_resume_wave_progression();
  level thread delay_play_outro();
  level thread delay_give_rewards();
  level thread delay_drop_talisman();
}

delay_play_outro() {
  level endon("game_ended");
  wait(1.15);
  scripts\cp\utility::play_bink_video("sysmainunload", 67);
}

clear_existing_enemies() {
  foreach(var_1 in level.spawned_enemies) {
    var_1.died_poorly = 1;
    var_1.nocorpse = 1;
    var_1 suicide();
  }

  scripts\engine\utility::waitframe();
}

delay_resume_wave_progression() {
  level endon("game_ended");
  wait(71.15);
  resume_spawn_wave();
}

resume_spawn_wave() {
  level.dont_resume_wave_after_solo_afterlife = undefined;
  level.zombies_paused = 0;
  scripts\engine\utility::flag_clear("pause_wave_progression");
}

delay_drop_talisman() {
  level endon("game_ended");
  var_0 = (2986, 2603, -131);
  wait(71.15);
  if(scripts\cp\zombies\directors_cut::directors_cut_is_activated()) {
    level notify("crab_boss_beaten");
  }

  level thread scripts\cp\zombies\directors_cut::try_drop_talisman(var_0, vectortoangles((0, 1, 0)));
}

delay_give_rewards() {
  level endon("game_ended");
  wait(71.15);
  level.defeated_crogboss = 1;
  scripts\cp\zombies\directors_cut::give_dc_player_extra_xp_for_carrying_newb();
  foreach(var_1 in level.players) {
    var_1 scripts\cp\cp_merits::processmerit("mt_dlc3_boss_killed");
    var_1 setplayerdata("cp", "haveSoulKeys", "any_soul_key", 1);
    var_1 setplayerdata("cp", "haveSoulKeys", "soul_key_4", 1);
    var_1 scripts\cp\zombies\achievement::update_achievement("SOUL_LESS", 1);
    var_1 thread refill_fnf_cards_after_bomb_explosion(var_1);
    if(!var_1 scripts\cp\utility::isteleportenabled()) {
      var_1 scripts\cp\utility::allow_player_teleport(1);
    }

    if(var_1.vo_prefix == "p5_") {
      var_1 scripts\cp\zombies\achievement::update_achievement("UNPLEASANT_DREAMS", 1);
    }
  }

  level scripts\cp\utility::set_completed_quest_mark(4);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_easteregg_complete", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  wait(scripts\cp\cp_vo::get_sound_length("ww_easteregg_complete") + 5);
  if(scripts\cp\cp_music_and_dialog::can_play_dialogue_system()) {
    level thread scripts\cp\cp_vo::try_to_play_vo("sally_soul_key_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
    return;
  }

  foreach(var_1 in level.players) {
    if(var_1.vo_prefix == "p5_") {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("defeat_radboss", "town_comment_vo", "low", 10, 0, 0, 0, 10);
    }
  }

  wait(scripts\cp\cp_vo::get_sound_length("el_defeat_radboss"));
  level thread scripts\cp\maps\cp_town\cp_town::play_willard_elvira_exchange("crogboss_defeat");
}

crab_boss_death_anim_sequence(var_0) {
  level endon("game_ended");
  if(isalive(var_0)) {
    var_0 scripts\aitypes\crab_boss\behaviors::dodeath(0);
    var_0 scripts\engine\utility::waittill_any_timeout(3, "death_done");
    var_0.nocorpse = 1;
    var_0 suicide();
  }

  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
  level.crab_boss = undefined;
}

clean_up_bomb_interaction_struct(var_0) {
  if(isDefined(var_0.bomb_counter_ent)) {
    var_0.bomb_counter_ent delete();
  }

  if(isDefined(var_0.bomb_status_light)) {
    var_0.bomb_status_light delete();
  }

  if(isDefined(var_0.bomb_panel_model)) {
    var_0.bomb_panel_model delete();
  }
}

exit_detonate_bomb_sequence(var_0) {
  turn_off_enter_bomb_code_hud(var_0);
  turn_on_other_hud(var_0);
  var_0 teleport_out_of_crab_boss(var_0);
  var_0 scripts\engine\utility::allow_weapon_switch(1);
  var_0 takeweapon("iw7_gunless_zm");
  if(!var_0 hasweapon(var_0.weapon_before_bomb_sequence)) {
    var_0 scripts\cp\utility::_giveweapon(var_0.weapon_before_bomb_sequence, undefined, undefined, 1);
  }

  var_0 switchtoweapon(var_0.weapon_before_bomb_sequence);
  var_0 scripts\cp\powers\coop_powers::restore_powers(var_0, var_0.powers_before_entangler);
  var_0 restore_all_previous_perks(var_0);
  var_0 scripts\cp\utility::restore_super_weapon();
  var_0.disable_self_revive_fnf = undefined;
  var_0.allow_carry = 1;
  var_0.disable_consumables = undefined;
  var_0 allowmelee(1);
  var_0 stoploopsound("cp_town_timer_lp");
}

turn_off_other_hud(var_0) {
  var_0 setclientomnvar("zm_ui_dialpad_4", 1);
}

turn_on_other_hud(var_0) {
  var_0 setclientomnvar("zm_ui_dialpad_4", 0);
}

store_and_take_perks(var_0) {
  var_0.pre_ghost_perks = [];
  if(!isDefined(var_0.zombies_perks)) {
    return;
  }

  foreach(var_3, var_2 in var_0.zombies_perks) {
    if(scripts\engine\utility::istrue(var_0.zombies_perks[var_3]) && should_be_removed_for_bomb_sequence(var_3)) {
      var_0.pre_ghost_perks = scripts\engine\utility::array_add(var_0.pre_ghost_perks, var_3);
      var_0 scripts\cp\zombies\zombies_perk_machines::take_zombies_perk(var_3);
      bomb_sequence_take_perks_handler(var_0, var_3);
    }
  }
}

bomb_sequence_take_perks_handler(var_0, var_1) {
  switch (var_1) {
    case "perk_machine_revive":
      var_0.self_revives_purchased--;
      break;

    default:
      break;
  }
}

should_be_removed_for_bomb_sequence(var_0) {
  switch (var_0) {
    case "perk_machine_more":
      return 0;

    default:
      return 1;
  }
}

restore_all_previous_perks(var_0) {
  foreach(var_2 in var_0.pre_ghost_perks) {
    var_0 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_2, 0);
  }
}

teleport_into_boss_crab(var_0, var_1) {
  var_0.pre_bomb_code_pos = var_0.origin;
  var_0.pre_bomb_code_angles = var_0 getplayerangles();
  var_2 = spawnStruct();
  var_2.origin = var_1.origin + scripts\cp\utility::vec_multiply(anglesToForward(var_1.angles), -25);
  var_2.angles = var_1.angles;
  scripts\cp\maps\cp_town\cp_town_fast_travel::move_player_through_portal_tube(var_0, [var_2]);
}

randomize_bomb_interaction_structs() {
  var_0 = scripts\engine\utility::array_randomize(level.bomb_interaction_structs);
  var_1 = [];
  var_2 = 0;
  foreach(var_4 in var_0) {
    var_1[var_2] = var_4;
    var_2++;
  }

  return var_1;
}

delay_enable_interaction(var_0) {
  wait(0.5);
  if(scripts\engine\utility::istrue(level.denotate_bomb_timed_out)) {
    return;
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

exit_enter_bomb_code(var_0, var_1) {
  var_1 unlink();
  var_1 allowstand(1);
  var_1 allowprone(1);
  var_1 allowcrouch(1);
  var_1 setstance(var_1.pre_bomb_code_stance);
  turn_off_enter_bomb_code_hud(var_1);
  var_1.bomb_interaction_struct = undefined;
  var_0.anchor delete();
  var_0 notify("exit_enter_bomb_code");
}

delay_deactivate_bomb_panel(var_0) {
  wait(0.5);
  deactivate_bomb_panel(var_0);
}

transition_into_enter_bomb_code(var_0, var_1) {
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  var_1 playerlinkto(var_2, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_1.pre_bomb_code_stance = var_1 getstance();
  var_1 allowprone(0);
  var_1 allowcrouch(1);
  var_1 allowstand(0);
  var_2.angles = var_0.angles + (0, 0, 0);
  var_2 moveto(var_0.origin + scripts\cp\utility::vec_multiply(anglesToForward(var_0.angles), -15), 0.3);
  var_0.anchor = var_2;
  var_2 waittill("movedone");
}

generate_nuclear_code() {
  var_0 = [];
  var_1 = "";
  var_2 = scripts\engine\utility::array_randomize([1, 2, 3, 4, 5, 6, 7, 8, 9]);
  for(var_3 = 0; var_3 < 5; var_3++) {
    var_4 = var_2[var_3];
    var_0[var_3] = var_4;
    var_1 = var_1 + var_4;
  }

  level.nuclear_code = var_0;
  setomnvar("zm_speaker_defense_timer", int(var_1));
}

assign_nuclear_code(var_0, var_1) {
  var_0.nuclear_code = [];
  for(var_2 = 0; var_2 < 5; var_2++) {
    var_0.nuclear_code[var_2] = var_1[var_2];
  }
}

reset_bomb_interaction_struct() {
  level.num_of_nuclear_code_entered = 0;
  foreach(var_1 in level.bomb_interaction_structs) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  }
}

init_bomb_interaction() {
  level.bomb_interaction_structs = [];
  var_0 = scripts\engine\utility::getstructarray("bomb_start", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getstructarray(var_2.target, "targetname");
    foreach(var_5 in var_3) {
      switch (var_5.script_noteworthy) {
        case "bomb_counter":
          var_2.bomb_counter = var_5;
          break;

        case "bomb_status":
          var_2.bomb_status = var_5;
          break;

        case "bomb_panel":
          var_2.bomb_panel = var_5;
          break;
      }
    }

    var_7 = int(var_2.groupname);
    var_2.index = var_7;
    level.bomb_interaction_structs[var_7] = var_2;
  }
}

reset_nuclear_code_progress(var_0) {
  var_0 setclientomnvar("zm_ui_dialpad_1", -1);
  var_0 setclientomnvar("zm_ui_dialpad_5", 0);
  var_0.nuclear_code_progress_index = 0;
  var_0.completed_nuclear_code = "";
  var_0.times_input_wrong_digits = 0;
}

correct_digit_entered(var_0, var_1) {
  return var_1 == level.nuclear_code[var_0.nuclear_code_progress_index];
}

input_wrong_digit(var_0, var_1) {
  var_1.times_input_wrong_digits++;
  var_1 setclientomnvar("zm_ui_dialpad_5", var_1.times_input_wrong_digits);
  wrong_sfx(var_1);
  if(var_1.times_input_wrong_digits == 3) {
    var_1 thread flashing_red_strikes(var_1);
    wait(1.25);
    var_0 thread delay_enable_interaction(var_0);
    var_0 thread exit_enter_bomb_code(var_0, var_1);
  }
}

wrong_sfx(var_0) {
  if(var_0.times_input_wrong_digits == 3) {
    var_0 playlocalsound("cp_town_timer_final_fail");
    return;
  }

  var_0 playlocalsound("cp_town_timer_single_fail");
}

flashing_red_strikes(var_0) {
  var_0 endon("disconnect");
  wait(0.2);
  var_0 setclientomnvar("zm_ui_dialpad_5", 5);
}

advance_nuclear_code_progress(var_0, var_1) {
  var_0.nuclear_code_progress_index++;
  var_0.completed_nuclear_code = var_0.completed_nuclear_code + var_1;
  var_0 setclientomnvar("zm_ui_dialpad_1", int(var_0.completed_nuclear_code));
}

nuclear_code_completed(var_0) {
  return var_0.nuclear_code_progress_index == 5;
}

player_complete_nuclear_code(var_0, var_1) {
  level.num_of_nuclear_code_entered++;
  var_1 setclientomnvar("zm_ui_dialpad_5", 4);
  var_0.bomb_status_light setscriptablepartstate("bomb_status", "green");
  level thread check_all_nuclear_code_entered();
  wait(2);
  exit_enter_bomb_code(var_0, var_1);
}

check_all_nuclear_code_entered() {
  if(all_nuclear_code_entered()) {
    level thread nuclear_bomb_armed_sequence();
  }
}

all_nuclear_code_entered() {
  return level.num_of_nuclear_code_entered == level.players.size;
}

nuclear_bomb_armed_sequence() {
  level notify("nuclear_bomb_armed");
  foreach(var_1 in level.players) {
    if(level.bomb_detonation_attempts == 1) {
      var_1 scripts\cp\zombies\achievement::update_achievement("BELLY_OF_BEAST", 1);
    }
  }

  scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_phase_6_success");
  wait(3);
  end_detonate_bomb(1);
}

delay_move_status_lights_down() {
  wait(2);
  var_0 = scripts\engine\utility::getstruct("bomb_lights", "script_noteworthy");
  if(isDefined(var_0.bomb_lights)) {
    var_0.bomb_lights moveto(var_0.bomb_lights.origin - (0, 0, 8), 1.5);
  }

  foreach(var_2 in level.bomb_interaction_structs) {
    if(isDefined(var_2.bomb_status_light)) {
      var_2.bomb_status_light moveto(var_2.bomb_status_light.origin - (0, 0, 8), 1.5);
    }
  }
}

teleport_out_of_crab_boss(var_0) {
  var_1 = spawnStruct();
  var_1.origin = get_player_post_bomb_code_pos(var_0);
  var_1.angles = get_player_post_bomb_code_angles(var_0);
  scripts\cp\maps\cp_town\cp_town_fast_travel::move_player_through_portal_tube(var_0, [var_1]);
}

get_player_post_bomb_code_pos(var_0) {
  if(isDefined(var_0.pre_bomb_code_pos)) {
    return var_0.pre_bomb_code_pos;
  }

  return (2991, 2803, -134);
}

get_player_post_bomb_code_angles(var_0) {
  if(isDefined(var_0.pre_bomb_code_angles)) {
    return var_0.pre_bomb_code_angles;
  }

  return vectortoangles((530, 1733, -97));
}

detonate_bomb_timer() {
  level endon("game_ended");
  level endon("end_detonate_bomb");
  level endon("nuclear_bomb_armed");
  level.denotate_bomb_timed_out = 0;
  wait(30);
  level.denotate_bomb_timed_out = 1;
  foreach(var_1 in level.bomb_interaction_structs) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
  }

  foreach(var_4 in level.players) {
    if(is_entering_bomb_code(var_4)) {
      var_4.bomb_interaction_struct thread exit_enter_bomb_code(var_4.bomb_interaction_struct, var_4);
    }
  }

  scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_phase_6_fail");
  wait(3);
  end_detonate_bomb(0);
}

is_entering_bomb_code(var_0) {
  return isDefined(var_0.bomb_interaction_struct);
}

setup_bomb_panel(var_0) {
  var_1 = spawn("script_model", var_0.bomb_panel.origin + (0, 0, 6));
  var_1 setModel("cp_town_nuke_panel");
  var_1.angles = var_0.bomb_panel.angles;
  var_1.var_C725 = var_0.bomb_panel.origin;
  var_1.active_origin = var_0.bomb_panel.origin + (0, 0, 6);
  var_0.bomb_panel_model = var_1;
}

activate_bomb_panel(var_0) {
  var_0.bomb_panel_model moveto(var_0.bomb_panel_model.active_origin, 0.3);
}

deactivate_bomb_panel(var_0) {
  var_0.bomb_panel_model moveto(var_0.bomb_panel_model.var_C725, 0.3);
}

turn_on_bomb_status_light(var_0) {
  var_1 = spawn("script_model", var_0.bomb_status.origin);
  var_1 setModel("crab_boss_origin");
  var_1.angles = var_0.bomb_status.angles;
  var_1 setscriptablepartstate("bomb_status", "red");
  var_0.bomb_status_light = var_1;
}

show_bomb_code() {
  scripts\cp\utility::set_quest_icon(20);
}

setup_bomb_lights() {
  var_0 = scripts\engine\utility::getstruct("bomb_lights", "script_noteworthy");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("cp_town_nuke_lights");
  var_1.angles = var_0.angles;
  var_0.bomb_lights = var_1;
}

move_up(var_0) {
  var_0 endon("death");
  var_0 moveto(var_0.origin + (0, 0, 8), 1.5);
}

delete_bomb_lights() {
  var_0 = scripts\engine\utility::getstruct("bomb_lights", "script_noteworthy");
  if(isDefined(var_0.bomb_lights)) {
    var_0.bomb_lights delete();
  }
}

detonate_bomb_test() {}