/**************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_crab_boss_bomb.gsc
**************************************************************/

start_detonate_bomb() {
  level thread detonate_bomb_timer();
  setup_bomb_lights();
  reset_bomb_interaction_struct();
  var_00 = randomize_bomb_interaction_structs();
  foreach(var_03, var_02 in level.players) {
    var_02 thread exit_early_from_all_active_consumables(var_02);
    var_02 thread enter_detonate_bomb_sequence(var_02, var_00[var_03]);
  }

  if(!isDefined(level.bomb_detonation_attempts)) {
    level.bomb_detonation_attempts = 0;
  }

  level.bomb_detonation_attempts = level.bomb_detonation_attempts + 1;
}

exit_early_from_all_active_consumables(param_00) {
  var_01 = getarraykeys(param_00.consumables);
  if(param_00 scripts\cp\utility::are_any_consumables_active()) {
    foreach(var_03 in var_01) {
      if(var_03 == "bh_gun" || var_03 == "atomizer_gun" || var_03 == "claw_gun" || var_03 == "steel_dragon" || var_03 == "penetration_gun") {
        param_00 notify(var_03 + "_exited_early");
      }
    }
  }
}

refill_fnf_cards_after_bomb_explosion(param_00) {
  param_00 scripts\cp\zombies\zombies_consumables::reset_meter();
  param_00 thread scripts\cp\zombies\zombies_consumables::turn_on_cards();
  param_00 thread scripts\cp\zombies\zombies_consumables::meter_fill_up();
}

enter_bomb_code(param_00, param_01) {
  enter_bomb_code_internal(param_00, param_01);
}

enter_bomb_code_internal(param_00, param_01) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  param_01.bomb_interaction_struct = param_00;
  reset_nuclear_code_progress(param_01);
  transition_into_enter_bomb_code(param_00, param_01);
  turn_on_enter_bomb_code_hud(param_01, param_00);
  param_00 thread run_bomb_counters(param_01, param_00);
  param_00 thread bomb_counter_selected_monitor(param_01, param_00);
  param_00 thread player_exit_monitor(param_01, param_00);
}

run_bomb_counters(param_00, param_01) {
  param_00 endon("disconnect");
  param_01 notify("run_bomb_counters");
  param_01 endon("exit_enter_bomb_code");
  param_01 endon("run_bomb_counters");
  for(;;) {
    for(var_02 = 0; var_02 < 10; var_02++) {
      param_00 setclientomnvar("zm_ui_dialpad_0", var_02 + 1);
      wait(0.1);
    }
  }
}

bomb_counter_selected_monitor(param_00, param_01) {
  param_00 endon("disconnect");
  param_01 notify("bomb_counter_selected_monitor");
  param_01 endon("exit_enter_bomb_code");
  param_01 endon("bomb_counter_selected_monitor");
  for(;;) {
    param_00 waittill("luinotifyserver", var_02, var_03);
    if(var_02 != "bomb_counter_digit") {
      continue;
    }

    if(correct_digit_entered(param_00, var_03)) {
      advance_nuclear_code_progress(param_00, var_03);
      var_04 = nuclear_code_completed(param_00);
      correct_sfx(param_00, var_04);
      if(var_04) {
        player_complete_nuclear_code(param_01, param_00);
      }

      continue;
    }

    input_wrong_digit(param_01, param_00);
  }
}

correct_sfx(param_00, param_01) {
  if(param_01) {
    param_00 playlocalsound("cp_town_timer_final_pass");
    return;
  }

  param_00 playlocalsound("cp_town_timer_single_pass");
}

player_exit_monitor(param_00, param_01) {
  param_00 endon("disconnect");
  param_01 notify("player_exit_monitor");
  param_01 endon("exit_enter_bomb_code");
  param_01 endon("player_exit_monitor");
  for(;;) {
    param_00 waittill("luinotifyserver", var_02);
    if(var_02 != "exit_bomb_counter") {
      continue;
    }

    param_01 thread delay_enable_interaction(param_01);
    param_01 thread exit_enter_bomb_code(param_01, param_00);
  }
}

turn_on_enter_bomb_code_hud(param_00, param_01) {
  var_02 = anglesToForward(param_01.bomb_panel_model.angles);
  var_03 = spawn("script_model", param_01.bomb_panel_model.origin + var_02 * 15);
  var_03 setModel("tag_origin");
  var_03.angles = param_01.bomb_counter.angles;
  param_01.bomb_counter_ent = var_03;
  param_00 setclientomnvar("zm_ui_dialpad_ent", var_03);
  param_00 setclientomnvar("zm_ui_dialpad_2", 1);
  param_00 playLoopSound("cp_town_timer_lp");
}

turn_off_enter_bomb_code_hud(param_00) {
  param_00 setclientomnvar("zm_ui_dialpad_2", 0);
  param_00 stoploopsound("cp_town_timer_lp");
}

enter_detonate_bomb_sequence(param_00, param_01) {
  turn_off_other_hud(param_00);
  setup_bomb_panel(param_01);
  teleport_into_boss_crab(param_00, param_01);
  turn_on_bomb_status_light(param_01);
  param_00.weapon_before_bomb_sequence = param_00 scripts\cp\utility::getweapontoswitchbackto();
  param_00 scripts\cp\zombies\arcade_game_utility::take_player_super_pre_game();
  param_00.disable_self_revive_fnf = 1;
  param_00.allow_carry = 0;
  param_00.disable_consumables = 1;
  param_00 store_and_take_perks(param_00);
  param_00 allowmelee(0);
  param_00 giveweapon("iw7_gunless_zm");
  param_00 switchtoweaponimmediate("iw7_gunless_zm");
  param_00 scripts\engine\utility::allow_weapon_switch(0);
  param_00.powers_before_entangler = param_00 scripts\cp\powers\coop_powers::get_info_for_player_powers(param_00);
  param_00 scripts\cp\powers\coop_powers::clearpowers();
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_phase_6_crog_inside");
}

end_detonate_bomb(param_00) {
  foreach(var_02 in level.players) {
    var_02 thread exit_detonate_bomb_sequence(var_02);
  }

  foreach(var_05 in level.bomb_interaction_structs) {
    clean_up_bomb_interaction_struct(var_05);
  }

  delete_bomb_lights();
  if(scripts\engine\utility::istrue(param_00)) {
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
  foreach(var_01 in level.spawned_enemies) {
    var_01.died_poorly = 1;
    var_01.nocorpse = 1;
    var_01 suicide();
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
  var_00 = (2986, 2603, -131);
  wait(71.15);
  if(scripts\cp\zombies\directors_cut::directors_cut_is_activated()) {
    level notify("crab_boss_beaten");
  }

  level thread scripts\cp\zombies\directors_cut::try_drop_talisman(var_00, vectortoangles((0, 1, 0)));
}

delay_give_rewards() {
  level endon("game_ended");
  wait(71.15);
  level.defeated_crogboss = 1;
  scripts\cp\zombies\directors_cut::give_dc_player_extra_xp_for_carrying_newb();
  foreach(var_01 in level.players) {
    var_01 scripts\cp\cp_merits::processmerit("mt_dlc3_boss_killed");
    var_01 setplayerdata("cp", "haveSoulKeys", "any_soul_key", 1);
    var_01 setplayerdata("cp", "haveSoulKeys", "soul_key_4", 1);
    var_01 scripts\cp\zombies\achievement::update_achievement("SOUL_LESS", 1);
    var_01 thread refill_fnf_cards_after_bomb_explosion(var_01);
    if(!var_01 scripts\cp\utility::isteleportenabled()) {
      var_01 scripts\cp\utility::allow_player_teleport(1);
    }

    if(var_01.vo_prefix == "p5_") {
      var_01 scripts\cp\zombies\achievement::update_achievement("UNPLEASANT_DREAMS", 1);
    }
  }

  level scripts\cp\utility::set_completed_quest_mark(4);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_easteregg_complete", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  wait(scripts\cp\cp_vo::get_sound_length("ww_easteregg_complete") + 5);
  if(scripts\cp\cp_music_and_dialog::can_play_dialogue_system()) {
    level thread scripts\cp\cp_vo::try_to_play_vo("sally_soul_key_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
    return;
  }

  foreach(var_01 in level.players) {
    if(var_01.vo_prefix == "p5_") {
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("defeat_radboss", "town_comment_vo", "low", 10, 0, 0, 0, 10);
    }
  }

  wait(scripts\cp\cp_vo::get_sound_length("el_defeat_radboss"));
  level thread scripts\cp\maps\cp_town\cp_town::play_willard_elvira_exchange("crogboss_defeat");
}

crab_boss_death_anim_sequence(param_00) {
  level endon("game_ended");
  if(isalive(param_00)) {
    param_00 scripts\aitypes\crab_boss\behaviors::dodeath(0);
    param_00 scripts\engine\utility::waittill_any_timeout_1(3, "death_done");
    param_00.nocorpse = 1;
    param_00 suicide();
  }

  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
  level.crab_boss = undefined;
}

clean_up_bomb_interaction_struct(param_00) {
  if(isDefined(param_00.bomb_counter_ent)) {
    param_00.bomb_counter_ent delete();
  }

  if(isDefined(param_00.bomb_status_light)) {
    param_00.bomb_status_light delete();
  }

  if(isDefined(param_00.bomb_panel_model)) {
    param_00.bomb_panel_model delete();
  }
}

exit_detonate_bomb_sequence(param_00) {
  turn_off_enter_bomb_code_hud(param_00);
  turn_on_other_hud(param_00);
  param_00 teleport_out_of_crab_boss(param_00);
  param_00 scripts\engine\utility::allow_weapon_switch(1);
  param_00 takeweapon("iw7_gunless_zm");
  if(!param_00 hasweapon(param_00.weapon_before_bomb_sequence)) {
    param_00 scripts\cp\utility::_giveweapon(param_00.weapon_before_bomb_sequence, undefined, undefined, 1);
  }

  param_00 switchtoweapon(param_00.weapon_before_bomb_sequence);
  param_00 scripts\cp\powers\coop_powers::restore_powers(param_00, param_00.powers_before_entangler);
  param_00 restore_all_previous_perks(param_00);
  param_00 scripts\cp\utility::restore_super_weapon();
  param_00.disable_self_revive_fnf = undefined;
  param_00.allow_carry = 1;
  param_00.disable_consumables = undefined;
  param_00 allowmelee(1);
  param_00 stoploopsound("cp_town_timer_lp");
}

turn_off_other_hud(param_00) {
  param_00 setclientomnvar("zm_ui_dialpad_4", 1);
}

turn_on_other_hud(param_00) {
  param_00 setclientomnvar("zm_ui_dialpad_4", 0);
}

store_and_take_perks(param_00) {
  param_00.pre_ghost_perks = [];
  if(!isDefined(param_00.zombies_perks)) {
    return;
  }

  foreach(var_03, var_02 in param_00.zombies_perks) {
    if(scripts\engine\utility::istrue(param_00.zombies_perks[var_03]) && should_be_removed_for_bomb_sequence(var_03)) {
      param_00.pre_ghost_perks = scripts\engine\utility::array_add(param_00.pre_ghost_perks, var_03);
      param_00 scripts\cp\zombies\zombies_perk_machines::take_zombies_perk(var_03);
      bomb_sequence_take_perks_handler(param_00, var_03);
    }
  }
}

bomb_sequence_take_perks_handler(param_00, param_01) {
  switch (param_01) {
    case "perk_machine_revive":
      param_00.self_revives_purchased--;
      break;

    default:
      break;
  }
}

should_be_removed_for_bomb_sequence(param_00) {
  switch (param_00) {
    case "perk_machine_more":
      return 0;

    default:
      return 1;
  }
}

restore_all_previous_perks(param_00) {
  foreach(var_02 in param_00.pre_ghost_perks) {
    param_00 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_02, 0);
  }
}

teleport_into_boss_crab(param_00, param_01) {
  param_00.pre_bomb_code_pos = param_00.origin;
  param_00.pre_bomb_code_angles = param_00 getplayerangles();
  var_02 = spawnStruct();
  var_02.origin = param_01.origin + scripts\cp\utility::vec_multiply(anglesToForward(param_01.angles), -25);
  var_02.angles = param_01.angles;
  scripts\cp\maps\cp_town\cp_town_fast_travel::move_player_through_portal_tube(param_00, [var_02]);
}

randomize_bomb_interaction_structs() {
  var_00 = scripts\engine\utility::array_randomize(level.bomb_interaction_structs);
  var_01 = [];
  var_02 = 0;
  foreach(var_04 in var_00) {
    var_01[var_02] = var_04;
    var_02++;
  }

  return var_01;
}

delay_enable_interaction(param_00) {
  wait(0.5);
  if(scripts\engine\utility::istrue(level.denotate_bomb_timed_out)) {
    return;
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

exit_enter_bomb_code(param_00, param_01) {
  param_01 unlink();
  param_01 allowstand(1);
  param_01 allowprone(1);
  param_01 allowcrouch(1);
  param_01 setstance(param_01.pre_bomb_code_stance);
  turn_off_enter_bomb_code_hud(param_01);
  param_01.bomb_interaction_struct = undefined;
  param_00.anchor delete();
  param_00 notify("exit_enter_bomb_code");
}

delay_deactivate_bomb_panel(param_00) {
  wait(0.5);
  deactivate_bomb_panel(param_00);
}

transition_into_enter_bomb_code(param_00, param_01) {
  var_02 = spawn("script_model", param_01.origin);
  var_02 setModel("tag_origin");
  param_01 playerlinkto(var_02, "tag_origin", 1, 0, 0, 0, 0, 0);
  param_01.pre_bomb_code_stance = param_01 getstance();
  param_01 allowprone(0);
  param_01 allowcrouch(1);
  param_01 allowstand(0);
  var_02.angles = param_00.angles + (0, 0, 0);
  var_02 moveto(param_00.origin + scripts\cp\utility::vec_multiply(anglesToForward(param_00.angles), -15), 0.3);
  param_00.anchor = var_02;
  var_02 waittill("movedone");
}

generate_nuclear_code() {
  var_00 = [];
  var_01 = "";
  var_02 = scripts\engine\utility::array_randomize([1, 2, 3, 4, 5, 6, 7, 8, 9]);
  for(var_03 = 0; var_03 < 5; var_03++) {
    var_04 = var_02[var_03];
    var_00[var_03] = var_04;
    var_01 = var_01 + var_04;
  }

  level.nuclear_code = var_00;
  setomnvar("zm_speaker_defense_timer", int(var_01));
}

assign_nuclear_code(param_00, param_01) {
  param_00.nuclear_code = [];
  for(var_02 = 0; var_02 < 5; var_02++) {
    param_00.nuclear_code[var_02] = param_01[var_02];
  }
}

reset_bomb_interaction_struct() {
  level.num_of_nuclear_code_entered = 0;
  foreach(var_01 in level.bomb_interaction_structs) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
  }
}

init_bomb_interaction() {
  level.bomb_interaction_structs = [];
  var_00 = scripts\engine\utility::getstructarray("bomb_start", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_03 = scripts\engine\utility::getstructarray(var_02.target, "targetname");
    foreach(var_05 in var_03) {
      switch (var_05.script_noteworthy) {
        case "bomb_counter":
          var_02.bomb_counter = var_05;
          break;

        case "bomb_status":
          var_02.bomb_status = var_05;
          break;

        case "bomb_panel":
          var_02.bomb_panel = var_05;
          break;
      }
    }

    var_07 = int(var_02.groupname);
    var_02.index = var_07;
    level.bomb_interaction_structs[var_07] = var_02;
  }
}

reset_nuclear_code_progress(param_00) {
  param_00 setclientomnvar("zm_ui_dialpad_1", -1);
  param_00 setclientomnvar("zm_ui_dialpad_5", 0);
  param_00.nuclear_code_progress_index = 0;
  param_00.completed_nuclear_code = "";
  param_00.times_input_wrong_digits = 0;
}

correct_digit_entered(param_00, param_01) {
  return param_01 == level.nuclear_code[param_00.nuclear_code_progress_index];
}

input_wrong_digit(param_00, param_01) {
  param_01.times_input_wrong_digits++;
  param_01 setclientomnvar("zm_ui_dialpad_5", param_01.times_input_wrong_digits);
  wrong_sfx(param_01);
  if(param_01.times_input_wrong_digits == 3) {
    param_01 thread flashing_red_strikes(param_01);
    wait(1.25);
    param_00 thread delay_enable_interaction(param_00);
    param_00 thread exit_enter_bomb_code(param_00, param_01);
  }
}

wrong_sfx(param_00) {
  if(param_00.times_input_wrong_digits == 3) {
    param_00 playlocalsound("cp_town_timer_final_fail");
    return;
  }

  param_00 playlocalsound("cp_town_timer_single_fail");
}

flashing_red_strikes(param_00) {
  param_00 endon("disconnect");
  wait(0.2);
  param_00 setclientomnvar("zm_ui_dialpad_5", 5);
}

advance_nuclear_code_progress(param_00, param_01) {
  param_00.nuclear_code_progress_index++;
  param_00.completed_nuclear_code = param_00.completed_nuclear_code + param_01;
  param_00 setclientomnvar("zm_ui_dialpad_1", int(param_00.completed_nuclear_code));
}

nuclear_code_completed(param_00) {
  return param_00.nuclear_code_progress_index == 5;
}

player_complete_nuclear_code(param_00, param_01) {
  level.num_of_nuclear_code_entered++;
  param_01 setclientomnvar("zm_ui_dialpad_5", 4);
  param_00.bomb_status_light setscriptablepartstate("bomb_status", "green");
  level thread check_all_nuclear_code_entered();
  wait(2);
  exit_enter_bomb_code(param_00, param_01);
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
  foreach(var_01 in level.players) {
    if(level.bomb_detonation_attempts == 1) {
      var_01 scripts\cp\zombies\achievement::update_achievement("BELLY_OF_BEAST", 1);
    }
  }

  scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_phase_6_success");
  wait(3);
  end_detonate_bomb(1);
}

delay_move_status_lights_down() {
  wait(2);
  var_00 = scripts\engine\utility::getstruct("bomb_lights", "script_noteworthy");
  if(isDefined(var_00.bomb_lights)) {
    var_00.bomb_lights moveto(var_00.bomb_lights.origin - (0, 0, 8), 1.5);
  }

  foreach(var_02 in level.bomb_interaction_structs) {
    if(isDefined(var_02.bomb_status_light)) {
      var_02.bomb_status_light moveto(var_02.bomb_status_light.origin - (0, 0, 8), 1.5);
    }
  }
}

teleport_out_of_crab_boss(param_00) {
  var_01 = spawnStruct();
  var_01.origin = get_player_post_bomb_code_pos(param_00);
  var_01.angles = get_player_post_bomb_code_angles(param_00);
  scripts\cp\maps\cp_town\cp_town_fast_travel::move_player_through_portal_tube(param_00, [var_01]);
}

get_player_post_bomb_code_pos(param_00) {
  if(isDefined(param_00.pre_bomb_code_pos)) {
    return param_00.pre_bomb_code_pos;
  }

  return (2991, 2803, -134);
}

get_player_post_bomb_code_angles(param_00) {
  if(isDefined(param_00.pre_bomb_code_angles)) {
    return param_00.pre_bomb_code_angles;
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
  foreach(var_01 in level.bomb_interaction_structs) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_01);
  }

  foreach(var_04 in level.players) {
    if(is_entering_bomb_code(var_04)) {
      var_04.bomb_interaction_struct thread exit_enter_bomb_code(var_04.bomb_interaction_struct, var_04);
    }
  }

  scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_phase_6_fail");
  wait(3);
  end_detonate_bomb(0);
}

is_entering_bomb_code(param_00) {
  return isDefined(param_00.bomb_interaction_struct);
}

setup_bomb_panel(param_00) {
  var_01 = spawn("script_model", param_00.bomb_panel.origin + (0, 0, 6));
  var_01 setModel("cp_town_nuke_panel");
  var_01.angles = param_00.bomb_panel.angles;
  var_01.var_C725 = param_00.bomb_panel.origin;
  var_01.active_origin = param_00.bomb_panel.origin + (0, 0, 6);
  param_00.bomb_panel_model = var_01;
}

activate_bomb_panel(param_00) {
  param_00.bomb_panel_model moveto(param_00.bomb_panel_model.active_origin, 0.3);
}

deactivate_bomb_panel(param_00) {
  param_00.bomb_panel_model moveto(param_00.bomb_panel_model.var_C725, 0.3);
}

turn_on_bomb_status_light(param_00) {
  var_01 = spawn("script_model", param_00.bomb_status.origin);
  var_01 setModel("crab_boss_origin");
  var_01.angles = param_00.bomb_status.angles;
  var_01 setscriptablepartstate("bomb_status", "red");
  param_00.bomb_status_light = var_01;
}

show_bomb_code() {
  scripts\cp\utility::set_quest_icon(20);
}

setup_bomb_lights() {
  var_00 = scripts\engine\utility::getstruct("bomb_lights", "script_noteworthy");
  var_01 = spawn("script_model", var_00.origin);
  var_01 setModel("cp_town_nuke_lights");
  var_01.angles = var_00.angles;
  var_00.bomb_lights = var_01;
}

move_up(param_00) {
  param_00 endon("death");
  param_00 moveto(param_00.origin + (0, 0, 8), 1.5);
}

delete_bomb_lights() {
  var_00 = scripts\engine\utility::getstruct("bomb_lights", "script_noteworthy");
  if(isDefined(var_00.bomb_lights)) {
    var_00.bomb_lights delete();
  }
}

detonate_bomb_test() {}