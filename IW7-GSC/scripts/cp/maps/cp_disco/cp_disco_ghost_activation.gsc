/******************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\cp_disco_ghost_activation.gsc
******************************************************************/

init_ghost_n_skull_3_quest() {
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostThree", 0, ::blank, ::clean_arcade_cabinet, ::complete_clean_arcade_cabinet, ::debug_clean_arcade_cabinet);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostThree", 1, ::blank, ::make_winning_mahjong_hand, ::complete_make_winning_mahjong_hand, ::debug_make_winning_mahjong_hand);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostThree", 2, ::blank, ::write_1_9_7_2, ::complete_write_1_9_7_2, ::debug_write_1_9_7_2);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostThree", 3, ::blank, ::do_sky_steps, ::complete_sky_steps, ::debug_do_sky_steps);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostThree", 4, ::blank, ::grab_skull_in_front_train, ::complete_grab_skull_in_front_train, ::debug_grab_skull_in_front_train);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostThree", 5, ::blank, ::call_service_number, ::complete_call_service_number, ::debug_call_service_number);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostThree", 6, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation);
}

blank() {}

clean_arcade_cabinet() {
  delete_dirty_glass();
  level.sb_quest_cleaner = make_cleaning_item_to_collect("sb_quest_cleaner", "p7_bottle_plastic_cleaner_dmg", "picked_up_cleaner");
  level.sb_quest_towel = make_cleaning_item_to_collect("sb_quest_towel", "towel_crumpled_01", "picked_up_towel");
  level scripts\engine\utility::waittill_multiple("picked_up_cleaner", "picked_up_towel");
  wait_for_player_clean_up_arcade_cabinet();
}

make_cleaning_item_to_collect(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getstructarray(var_0, "targetname");
  var_4 = scripts\engine\utility::random(var_3);
  var_5 = spawn("script_model", var_4.origin);
  var_5 setModel(var_1);
  var_5.angles = var_4.angles;
  var_5 thread player_pick_up_monitor(var_5, var_2);
  return var_5;
}

player_pick_up_monitor(var_0, var_1) {
  var_0 endon("death");
  for(;;) {
    foreach(var_3 in level.players) {
      if(player_picking_up_item(var_3, var_0)) {
        level notify(var_1);
        if(var_0.model == "towel_crumpled_01") {
          var_4 = "skullbuster_arcade_pickup_rag";
        } else {
          var_4 = "skullbuster_arcade_pickup_spraycleaner";
        }

        var_3 playlocalsound(var_4);
        playFX(level._effect["sb_quest_item_pickup"], var_0.origin);
        var_0 delete();
      }
    }

    scripts\engine\utility::waitframe();
  }
}

player_picking_up_item(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return 0;
  }

  if(!player_within_pick_up_distance(var_0, var_1)) {
    return 0;
  }

  if(!var_0 usebuttonpressed()) {
    return 0;
  }

  if(!var_0 worldpointinreticle_circle(var_1.origin, 65, 80)) {
    return 0;
  }

  if(!sighttracepassed(var_0 getEye(), var_1.origin + (0, 0, 5), 0, var_1)) {
    return 0;
  }

  return 1;
}

wait_for_player_clean_up_arcade_cabinet() {
  for(;;) {
    foreach(var_1 in level.players) {
      if(player_cleaning_up_arcade_cabinet(var_1)) {
        var_1 playlocalsound("skullbuster_arcade_clean_arcade_machine");
        wait(2);
        return;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

player_cleaning_up_arcade_cabinet(var_0) {
  var_1 = (-731, 2610, 900);
  var_2 = (-717, 2610, 942);
  var_3 = 900;
  if(distance2dsquared(var_0.origin, var_1) > var_3) {
    return 0;
  }

  if(!var_0 usebuttonpressed()) {
    return 0;
  }

  if(!var_0 worldpointinreticle_circle(var_2, 80, 100)) {
    return 0;
  }

  return 1;
}

player_within_pick_up_distance(var_0, var_1) {
  if(distance2dsquared(var_1.origin, var_0.origin) <= 2500) {
    return 1;
  }

  if(distance2dsquared(var_1.origin, var_0 getEye()) <= 2500) {
    return 1;
  }

  return 0;
}

delete_dirty_glass() {
  var_0 = getent("sb_quest_dirty_glass", "targetname");
  var_0 delete();
}

complete_clean_arcade_cabinet() {
  delete_clean_arcade_cabinet_entities();
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(1);
}

delete_clean_arcade_cabinet_entities() {
  if(isDefined(level.sb_quest_cleaner)) {
    level.sb_quest_cleaner delete();
  }

  if(isDefined(level.sb_quest_towel)) {
    level.sb_quest_towel delete();
  }
}

debug_clean_arcade_cabinet() {}

make_winning_mahjong_hand() {
  var_0 = scripts\engine\utility::getstruct("mahjong_set", "targetname");
  level thread set_up_mahjong_set(var_0);
  level waittill("mahjong_won_sequence_complete");
}

complete_make_winning_mahjong_hand() {
  clean_up_all_mahjong();
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(2);
}

debug_make_winning_mahjong_hand() {}

set_up_mahjong_set(var_0) {
  init_current_mahjong_count();
  init_mahjong_set_controlling_struct(var_0);
  var_1 = generate_mahjong_values(get_num_of_missing_tiles());
  var_2 = scripts\engine\utility::array_randomize(var_1.starting_hand);
  var_3 = var_1.tiles_for_pick_up;
  set_up_starting_hand(var_0, var_2);
  set_up_tiles_for_pick_up(var_3);
  var_0 thread update_player_monitor(var_0);
  var_0 thread player_interact_monitor(var_0);
}

set_up_starting_hand(var_0, var_1) {
  for(var_2 = 1; var_2 <= 14; var_2++) {
    set_up_mahjong(var_0, var_2, var_1[var_2 - 1]);
    scripts\engine\utility::waitframe();
  }
}

player_interact_monitor(var_0) {
  level endon("winning_mahjong_hand");
  for(;;) {
    foreach(var_2 in level.players) {
      if(player_interact_with_mahjong_set(var_2, var_0)) {
        swap_mahjong_tile_with_player_mahjong(var_2.mahjong_struct_currently_looking_at, var_2, 1);
        if(check_winning_hand(var_0)) {
          level thread mahjong_win_sequence(var_0);
          level notify("winning_mahjong_hand");
          continue;
        }

        wait(1);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

mahjong_win_sequence(var_0) {
  clear_outline_for_all_players(var_0);
  wait(0.5);
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("sb_quest_origin");
  var_1 setscriptablepartstate("vfx", "fireworks_sparks");
  playsoundatpos(var_0.origin, "mahjong_success_fireworks");
  wait(3);
  var_1 delete();
  level notify("mahjong_won_sequence_complete");
}

clear_outline_for_all_players(var_0) {
  foreach(var_2 in level.players) {
    for(var_3 = 1; var_3 <= 14; var_3++) {
      var_0.mahjong_set[var_3].mahjong_tile hudoutlinedisableforclient(var_2);
    }
  }
}

check_winning_hand(var_0) {
  if(!check_all_mahjong_filled(var_0)) {
    return 0;
  }

  if(!check_streak_or_triplet(1, var_0)) {
    return 0;
  }

  if(!check_streak_or_triplet(4, var_0)) {
    return 0;
  }

  if(!check_streak_or_triplet(7, var_0)) {
    return 0;
  }

  if(!check_streak_or_triplet(10, var_0)) {
    return 0;
  }

  if(!check_pair(13, var_0)) {
    return 0;
  }

  return 1;
}

check_all_mahjong_filled(var_0) {
  for(var_1 = 1; var_1 <= 14; var_1++) {
    if(var_0.mahjong_set[var_1].mahjong_value == "") {
      return 0;
    }
  }

  return 1;
}

check_streak_or_triplet(var_0, var_1) {
  if(check_streak(var_0, var_1)) {
    return 1;
  }

  if(check_triplet(var_0, var_1)) {
    return 1;
  }

  return 0;
}

check_streak(var_0, var_1) {
  var_2 = int(var_1.mahjong_set[var_0].mahjong_value);
  var_3 = int(var_1.mahjong_set[var_0 + 1].mahjong_value);
  var_4 = int(var_1.mahjong_set[var_0 + 2].mahjong_value);
  if(var_3 == var_2 + 1 && var_4 == var_3 + 1) {
    return 1;
  }

  return 0;
}

check_triplet(var_0, var_1) {
  var_2 = int(var_1.mahjong_set[var_0].mahjong_value);
  var_3 = int(var_1.mahjong_set[var_0 + 1].mahjong_value);
  var_4 = int(var_1.mahjong_set[var_0 + 2].mahjong_value);
  if(var_3 == var_2 && var_4 == var_3) {
    return 1;
  }

  return 0;
}

check_pair(var_0, var_1) {
  var_2 = int(var_1.mahjong_set[var_0].mahjong_value);
  var_3 = int(var_1.mahjong_set[var_0 + 1].mahjong_value);
  if(var_3 == var_2) {
    return 1;
  }

  return 0;
}

update_player_monitor(var_0) {
  level endon("winning_mahjong_hand");
  for(;;) {
    foreach(var_2 in level.players) {
      update_mahjong_state_for_player(var_2, var_0);
    }

    scripts\engine\utility::waitframe();
  }
}

update_mahjong_state_for_player(var_0, var_1) {
  if(!player_in_play_space(var_0, var_1)) {
    if(player_looking_at_any_mahjong_tile(var_0)) {
      clear_mahjong_state_for_player(var_0);
    }

    return;
  }

  var_2 = get_mahjong_struct_currently_looking_at(var_0, var_1);
  if(isDefined(var_2)) {
    if(!looking_at_the_same_mahjong(var_0, var_2)) {
      if(player_looking_at_any_mahjong_tile(var_0)) {
        clear_mahjong_state_for_player(var_0);
      }

      set_mahjong_struct_currently_looking_at(var_0, var_2);
    }
  }
}

player_interact_with_mahjong_set(var_0, var_1) {
  if(!player_in_play_space(var_0, var_1)) {
    return 0;
  }

  if(!player_looking_at_any_mahjong_tile(var_0)) {
    return 0;
  }

  if(!var_0 usebuttonpressed()) {
    return 0;
  }

  return 1;
}

looking_at_the_same_mahjong(var_0, var_1) {
  return isDefined(var_0.mahjong_struct_currently_looking_at) && var_0.mahjong_struct_currently_looking_at == var_1;
}

player_in_play_space(var_0, var_1) {
  return ispointinvolume(var_0.origin, var_1.play_area);
}

set_mahjong_struct_currently_looking_at(var_0, var_1) {
  if(is_empty_mahjong(var_1)) {
    show_empty_mahjong_for_player(var_0, var_1);
  } else {
    show_mahjong_outline_for_player(var_0, var_1);
  }

  var_0.mahjong_struct_currently_looking_at = var_1;
}

clear_mahjong_state_for_player(var_0) {
  var_1 = var_0.mahjong_struct_currently_looking_at;
  if(is_empty_mahjong(var_1)) {
    clear_empty_mahjong_for_player(var_0, var_1);
  } else {
    hide_mahjong_outline_for_player(var_0, var_1);
  }

  var_0.mahjong_struct_currently_looking_at = undefined;
}

show_empty_mahjong_for_player(var_0, var_1) {
  var_1.mahjong_tile setModel("cp_disco_mahjong_tile_clear");
}

clear_empty_mahjong_for_player(var_0, var_1) {
  if(any_other_player_looking_at_it(var_0, var_1)) {
    return;
  }

  var_1.mahjong_tile setModel("tag_origin");
}

any_other_player_looking_at_it(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      continue;
    }

    if(isDefined(var_3.mahjong_struct_currently_looking_at) && var_3.mahjong_struct_currently_looking_at == var_1) {
      return 1;
    }
  }

  return 0;
}

show_mahjong_outline_for_player(var_0, var_1) {
  var_1.mahjong_tile hudoutlineenableforclient(var_0, 1, 1, 0);
}

hide_mahjong_outline_for_player(var_0, var_1) {
  var_1.mahjong_tile hudoutlinedisableforclient(var_0);
}

player_looking_at_any_mahjong_tile(var_0) {
  return isDefined(var_0.mahjong_struct_currently_looking_at);
}

is_empty_mahjong(var_0) {
  return get_mahjong_value(var_0) == "";
}

get_mahjong_value(var_0) {
  return var_0.mahjong_value;
}

get_mahjong_struct_currently_looking_at(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_1.mahjong_set) {
    if(var_0 worldpointinreticle_circle(var_4.origin, 25, 75)) {
      var_2[var_2.size] = var_4;
    }
  }

  return scripts\engine\utility::getclosest(var_0.origin, var_2);
}

generate_mahjong_values(var_0) {
  var_1 = spawnStruct();
  var_2 = [];
  var_3 = [];
  for(var_4 = 1; var_4 <= 4; var_4++) {
    if(coin_flip()) {
      var_3 = scripts\engine\utility::array_combine(var_3, get_random_streak());
      continue;
    }

    var_3 = scripts\engine\utility::array_combine(var_3, get_random_triplet());
  }

  var_3 = scripts\engine\utility::array_combine(var_3, get_random_pair());
  var_5 = get_index_to_remove(var_0);
  foreach(var_7 in var_5) {
    var_2[var_2.size] = var_3[var_7];
    var_3[var_7] = "";
  }

  var_9 = get_additional_num_of_missing_tiles();
  for(var_4 = 0; var_4 < var_9; var_4++) {
    var_2[var_2.size] = "" + randomintrange(1, 6);
  }

  var_1.starting_hand = var_3;
  var_1.tiles_for_pick_up = var_2;
  return var_1;
}

get_index_to_remove(var_0) {
  var_1 = [];
  var_2 = [];
  for(var_3 = 0; var_3 < 14; var_3++) {
    var_2[var_2.size] = var_3;
  }

  var_2 = scripts\engine\utility::array_randomize(var_2);
  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_1[var_1.size] = var_2[var_4];
  }

  return var_1;
}

init_current_mahjong_count() {
  level.current_mahjong_count = [];
  for(var_0 = 1; var_0 <= 5; var_0++) {
    level.current_mahjong_count[var_0] = 0;
  }
}

get_least_used_num(var_0) {
  var_1 = 9999;
  var_2 = -1;
  if(coin_flip()) {
    for(var_3 = 1; var_3 <= var_0; var_3++) {
      if(level.current_mahjong_count[var_3] <= var_1) {
        var_1 = level.current_mahjong_count[var_3];
        var_2 = var_3;
      }
    }
  } else {
    for(var_3 = var_1; var_3 >= 1; var_3--) {
      if(level.current_mahjong_count[var_3] <= var_1) {
        var_1 = level.current_mahjong_count[var_3];
        var_2 = var_3;
      }
    }
  }

  return var_2;
}

get_random_streak() {
  var_0 = get_least_used_num(3);
  update_current_mahjong_conunt([var_0, var_0 + 1, var_0 + 2]);
  return [int_to_string(var_0), int_to_string(var_0 + 1), int_to_string(var_0 + 2)];
}

get_random_triplet() {
  var_0 = get_least_used_num(5);
  update_current_mahjong_conunt([var_0, var_0, var_0]);
  return [int_to_string(var_0), int_to_string(var_0), int_to_string(var_0)];
}

get_random_pair() {
  var_0 = get_least_used_num(5);
  update_current_mahjong_conunt([var_0, var_0]);
  return [int_to_string(var_0), int_to_string(var_0)];
}

update_current_mahjong_conunt(var_0) {
  foreach(var_2 in var_0) {
    level.current_mahjong_count[var_2]++;
  }
}

coin_flip() {
  return randomintrange(1, 100) > 50;
}

set_up_tiles_for_pick_up(var_0) {
  level.mahjong_struct_for_pick_up = [];
  var_1 = scripts\engine\utility::getstructarray("sb_mahjong_tile", "targetname");
  var_1 = scripts\engine\utility::array_randomize(var_1);
  foreach(var_5, var_3 in var_0) {
    var_4 = var_1[var_5];
    level.mahjong_struct_for_pick_up[level.mahjong_struct_for_pick_up.size] = var_4;
    spawn_mahjong_tile(var_1[var_5], var_3);
    var_4 thread player_use_monitor(var_4);
    scripts\engine\utility::waitframe();
  }
}

player_use_monitor(var_0) {
  level endon("winning_mahjong_hand");
  for(;;) {
    foreach(var_2 in level.players) {
      if(player_use_mahjong_struct(var_0, var_2)) {
        try_play_swap_vfx(var_0, var_2);
        swap_mahjong_tile_with_player_mahjong(var_0, var_2, 0);
        var_2 thread mahjong_player_disconnect_monitor(var_2);
        wait(1);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

try_play_swap_vfx(var_0, var_1) {
  var_2 = get_mahjong_value(var_0);
  var_3 = get_mahjong_tile_on_player(var_1);
  if(var_2 == "" && var_3 == "") {
    return;
  }

  playFX(level._effect["sb_quest_item_pickup"], var_0.origin);
}

swap_mahjong_tile_with_player_mahjong(var_0, var_1, var_2) {
  var_3 = get_mahjong_value(var_0);
  var_4 = get_mahjong_tile_on_player(var_1);
  play_swap_mahjong_sfx(var_0, var_3, var_4, var_2);
  set_mahjong_tile_on_player(var_1, var_3);
  set_mahjong_value(var_0, var_4, var_2);
}

play_swap_mahjong_sfx(var_0, var_1, var_2, var_3) {
  if(var_1 != "" && var_2 == "" && var_3 == 1) {
    playsoundatpos(var_0.origin, "mahjong_pickup_existing_tile");
    return;
  }

  if(var_1 != "" && var_2 == "" && !var_3 == 1) {
    playsoundatpos(var_0.origin, "mahjong_pickup_tile_exlpo");
    return;
  }

  if(var_1 != "" && var_2 != "") {
    playsoundatpos(var_0.origin, "mahjong_pickup_existing_tile");
    return;
  }

  if(var_1 == "" && var_2 != "") {
    playsoundatpos(var_0.origin, "mahjong_place_tile");
    return;
  }
}

get_mahjong_tile_on_player(var_0) {
  if(!isDefined(var_0.mahjong_tile_on_me)) {
    var_0.mahjong_tile_on_me = "";
  }

  return var_0.mahjong_tile_on_me;
}

set_mahjong_tile_on_player(var_0, var_1) {
  var_0.mahjong_tile_on_me = var_1;
}

player_use_mahjong_struct(var_0, var_1) {
  if(distance2dsquared(var_0.origin, var_1.origin) > 6400) {
    return 0;
  }

  if(!var_1 usebuttonpressed()) {
    return 0;
  }

  if(!var_1 worldpointinreticle_circle(var_0.origin, 55, 75)) {
    return 0;
  }

  return 1;
}

set_up_mahjong(var_0, var_1, var_2) {
  var_3 = get_mahjong_struct_at_index(var_0, var_1);
  spawn_mahjong_tile(var_3, var_2);
}

spawn_mahjong_tile(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2.angles = var_0.angles;
  var_0.mahjong_tile = var_2;
  set_mahjong_value(var_0, var_1);
}

set_mahjong_value(var_0, var_1, var_2) {
  var_0.mahjong_value = var_1;
  var_0.mahjong_tile setModel(get_mahjong_model(var_1, var_2));
}

get_mahjong_model(var_0, var_1) {
  switch (var_0) {
    case "":
      if(scripts\engine\utility::istrue(var_1)) {
        return "cp_disco_mahjong_tile_clear";
      } else {
        return "tag_origin";
      }

      break;

    case "1":
      return "cp_disco_mahjong_tile_01";

    case "2":
      return "cp_disco_mahjong_tile_02";

    case "3":
      return "cp_disco_mahjong_tile_03";

    case "4":
      return "cp_disco_mahjong_tile_04";

    case "5":
      return "cp_disco_mahjong_tile_05";
  }
}

init_mahjong_set_controlling_struct(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  foreach(var_4 in var_2) {
    var_5 = int(var_4.script_noteworthy);
    var_1[var_5] = var_4;
  }

  var_0.mahjong_set = var_1;
  var_7 = getEntArray(var_0.target, "targetname");
  foreach(var_9 in var_7) {
    switch (var_9.script_noteworthy) {
      case "play_area":
        var_0.play_area = var_9;
        break;
    }
  }
}

get_mahjong_struct_at_index(var_0, var_1) {
  return var_0.mahjong_set[var_1];
}

int_to_string(var_0) {
  return "" + var_0;
}

get_num_of_missing_tiles() {
  return 3 + level.players.size - 1;
}

get_additional_num_of_missing_tiles() {
  return 2 + level.players.size - 1;
}

clean_up_all_mahjong() {
  var_0 = scripts\engine\utility::getstruct("mahjong_set", "targetname");
  if(isDefined(var_0.mahjong_set)) {
    for(var_1 = 1; var_1 <= 14; var_1++) {
      if(isDefined(var_0.mahjong_set[var_1].mahjong_tile)) {
        var_0.mahjong_set[var_1].mahjong_tile delete();
      }
    }
  }

  if(isDefined(level.mahjong_struct_for_pick_up)) {
    foreach(var_3 in level.mahjong_struct_for_pick_up) {
      if(isDefined(var_3.mahjong_tile)) {
        var_3.mahjong_tile delete();
      }
    }
  }
}

mahjong_player_disconnect_monitor(var_0) {
  level endon("winning_mahjong_hand");
  var_0 notify("mahjong_player_disconnect_monitor");
  var_0 endon("mahjong_player_disconnect_monitor");
  var_0 waittill("disconnect");
  if(var_0.mahjong_tile_on_me != "") {
    var_1 = get_available_mahjong_struct_for_pick_up();
    set_mahjong_value(var_1, var_0.mahjong_tile_on_me, 0);
  }
}

get_available_mahjong_struct_for_pick_up() {
  foreach(var_1 in level.mahjong_struct_for_pick_up) {
    if(var_1.mahjong_value == "") {
      return var_1;
    }
  }
}

write_1_9_7_2() {
  var_0 = ["1", "9", "7", "2"];
  foreach(var_2 in var_0) {
    wait_player_write_number(var_2);
  }
}

wait_player_write_number(var_0) {
  var_1 = scripts\engine\utility::getstruct("sb_writing_quest_" + var_0, "targetname");
  set_up_controlling_struct(var_1);
  set_up_timer_candles(var_1);
  for(;;) {
    set_should_detect_damage(var_1, 1);
    reset_tiles_hit_array(var_1);
    var_1 thread tiles_hit_listener(var_1, var_0);
    var_2 = var_1 scripts\engine\utility::waittill_any_return("write_number_success", "write_number_fail", "write_number_timeout");
    clean_all_flame_vfx(var_1);
    if(var_2 == "write_number_success") {
      thread scripts\engine\utility::play_sound_in_space("skullbuster_number_success_plr", var_1.origin);
      clean_all_candles(var_1);
      clean_damage_monitor(var_1);
      wait(0.3);
      clean_all_cube_vfx(var_1);
      play_success_vfx(var_1);
      return;
    } else {
      thread scripts\engine\utility::play_sound_in_space("skullbuster_number_fail_buzzer_plr", var_1.origin);
      set_should_detect_damage(var_1, 0);
      hide_all_candles(var_1);
      clean_all_cube_vfx(var_1);
      wait_one_wave();
      show_all_candles(var_1);
    }
  }
}

reset_tiles_hit_array(var_0) {
  var_0.tiles_hit = [];
}

play_success_vfx(var_0) {
  playFX(level._effect["write_1972_success"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
}

clean_damage_monitor(var_0) {
  if(isDefined(var_0.damage_monitor)) {
    var_0.damage_monitor delete();
  }
}

clean_all_candles(var_0) {
  if(isDefined(var_0.timer_structs)) {
    foreach(var_2 in var_0.timer_structs) {
      if(isDefined(var_2.candle)) {
        var_2.candle delete();
      }
    }
  }
}

clean_all_flame_vfx(var_0) {
  if(isDefined(var_0.timer_structs)) {
    foreach(var_2 in var_0.timer_structs) {
      if(isDefined(var_2.flame_vfx)) {
        var_2.flame_vfx delete();
      }
    }
  }
}

clean_all_cube_vfx(var_0) {
  if(isDefined(var_0.damage_marker_structs)) {
    foreach(var_2 in var_0.damage_marker_structs) {
      if(isDefined(var_2.cube_vfx)) {
        var_2.cube_vfx delete();
      }
    }
  }
}

show_cube_at_tile(var_0, var_1) {
  var_2 = get_damage_marker_with_id(var_0, var_1);
  var_3 = var_0.script_area;
  var_4 = spawn("script_model", var_2.origin);
  var_4.angles = var_2.angles;
  var_4 setModel("sb_quest_origin");
  var_4 setscriptablepartstate("vfx", "window_cube_" + var_3);
  var_2.cube_vfx = var_4;
}

get_damage_marker_with_id(var_0, var_1) {
  foreach(var_3 in var_0.damage_marker_structs) {
    if(isDefined(var_3.name) && var_3.name == var_1) {
      return var_3;
    }
  }

  return undefined;
}

wait_for_first_tile_hit(var_0) {
  for(;;) {
    var_0 waittill("damage_marker_hit", var_1);
    if(var_1 == 1) {
      return;
    }
  }
}

tiles_hit_listener(var_0, var_1) {
  var_0 endon("write_number_fail");
  for(;;) {
    var_0 waittill("damage_marker_hit", var_2);
    if(var_2 == -1) {
      if(var_0.tiles_hit.size > 0) {
        var_0 notify("write_number_fail");
      }

      continue;
    }

    if(!scripts\engine\utility::array_contains(var_0.tiles_hit, var_2)) {
      show_cube_at_tile(var_0, "" + var_2);
      var_0.tiles_hit[var_0.tiles_hit.size] = var_2;
      if(var_0.tiles_hit.size == 1) {
        var_0 thread start_candle_timer(var_0, get_timer_time(var_1));
      }
    }

    if(var_0.tiles_hit.size == var_0.num_of_tile_to_hit) {
      var_0 notify("write_number_success");
    }
  }
}

get_timer_time(var_0) {
  switch (var_0) {
    case "1":
      return 6;

    case "9":
      return 7;

    case "7":
      return 7;

    case "2":
      return 7;
  }
}

start_candle_timer(var_0, var_1) {
  var_0 endon("write_number_fail");
  var_0 endon("write_number_success");
  spawn_candle_flame(var_0);
  for(var_2 = 0; var_2 < 3; var_2++) {
    wait(var_1 / 3);
    var_0.timer_structs[var_2].flame_vfx delete();
  }

  var_0 notify("write_number_timeout");
}

hide_all_candles(var_0) {
  foreach(var_2 in var_0.timer_structs) {
    var_2.candle hide();
  }
}

show_all_candles(var_0) {
  foreach(var_2 in var_0.timer_structs) {
    var_2.candle show();
  }
}

spawn_candle_flame(var_0) {
  foreach(var_4, var_2 in var_0.timer_structs) {
    var_3 = spawnfx(level._effect["candle_flame"], var_2.candle.origin + get_flame_vfx_offset(var_4));
    triggerfx(var_3);
    var_2.flame_vfx = var_3;
  }
}

set_up_timer_candles(var_0) {
  foreach(var_3, var_2 in var_0.timer_structs) {
    var_2.candle = set_up_candle(var_2, var_3);
  }
}

set_up_controlling_struct(var_0) {
  var_0.timer_structs = [];
  var_0.damage_marker_structs = [];
  set_should_detect_damage(var_0, 0);
  var_1 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    var_4 = var_3.script_noteworthy;
    if(issubstr(var_4, "timer")) {
      var_5 = int(strtok(var_4, "_")[1]);
      var_0.timer_structs[var_5] = var_3;
      continue;
    }

    if(var_4 == "damage_marker") {
      var_0.damage_marker_structs[var_0.damage_marker_structs.size] = var_3;
    }
  }

  var_7 = getEntArray(var_0.target, "targetname");
  foreach(var_9 in var_7) {
    var_10 = var_9.script_noteworthy;
    if(var_10 == "damage_monitor") {
      var_9 thread damage_watcher(var_0, var_9);
      var_0.damage_monitor = var_9;
    }
  }

  var_0.num_of_tile_to_hit = int(var_0.name);
}

set_should_detect_damage(var_0, var_1) {
  var_0.should_detect_damage = var_1;
}

should_detect_damage(var_0) {
  return var_0.should_detect_damage;
}

damage_watcher(var_0, var_1) {
  var_1 endon("death");
  var_1 setCanDamage(1);
  var_1.health = 99999999;
  for(;;) {
    var_1 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_1.health = 99999999;
    if(should_detect_damage(var_0)) {
      var_12 = get_tile_hit_id(var_0, var_5);
      var_0 notify("damage_marker_hit", var_12);
    }
  }
}

get_tile_hit_id(var_0, var_1) {
  var_2 = var_0.damage_marker_structs;
  var_3 = scripts\engine\utility::getclosest(var_1, var_2);
  if(isDefined(var_3.name)) {
    return int(var_3.name);
  }

  return -1;
}

set_up_candle(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(get_candle_model(var_1));
  var_2.angles = var_0.angles;
  return var_2;
}

get_flame_vfx_offset(var_0) {
  switch (var_0) {
    case 0:
      return (0, 0, 8.2);

    case 1:
      return (0, 0, 6);

    case 2:
      return (0, 0, 3);

    default:
      break;
  }
}

get_candle_model(var_0) {
  switch (var_0) {
    case 0:
      return "p7_candle_tall";

    case 1:
      return "p7_candle_med";

    case 2:
      return "p7_candle_sml";

    default:
      break;
  }
}

complete_write_1_9_7_2() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(3);
}

debug_write_1_9_7_2() {}

clean_up_1_9_7_2_setups() {
  var_0 = ["1", "9", "7", "2"];
  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getstruct("sb_writing_quest_" + var_2, "targetname");
    clean_all_flame_vfx(var_3);
    clean_all_candles(var_3);
    clean_damage_monitor(var_3);
    clean_all_cube_vfx(var_3);
  }
}

do_sky_steps() {
  wait_for_ghetto_rooftop_bridge_door_open();
  prepare_sky_steps();
  for(;;) {
    var_0 = scripts\engine\utility::getstruct("sky_step_start", "targetname");
    var_1 = activate_sky_step(var_0, 0);
    wait_for_player_to_jump_on_top(var_1);
    var_1 thread sky_step_timeout_monitor(var_1);
    var_2 = var_1;
    var_3 = 1;
    for(;;) {
      var_4 = get_sky_steps_at_tier(var_3, var_2);
      if(var_4.size == 0) {
        break;
      }

      var_5 = scripts\engine\utility::random(var_4);
      activate_sky_step(var_5, 1);
      var_2 = var_5;
      wait(1);
      var_3++;
    }

    var_6 = activate_sky_step_goal();
    var_7 = level scripts\engine\utility::waittill_any_return("sky_step_goal_reached", "sky_step_goal_timeout");
    if(var_7 == "sky_step_goal_reached") {
      break;
    } else if(var_7 == "sky_step_goal_timeout") {
      wait_one_wave();
    }
  }
}

wait_for_ghetto_rooftop_bridge_door_open() {
  var_0 = (-564, 474, 978);
  var_1 = (-425, 445, 980);
  for(;;) {
    var_2 = getclosestdoortrig(var_0, level.door_trigs, 100);
    var_3 = getclosestdoortrig(var_1, level.door_trigs, 100);
    if(isDefined(var_2) || isDefined(var_3)) {
      wait(1);
      continue;
    }
  }
}

getclosestdoortrig(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 500000;
  }

  var_3 = undefined;
  foreach(var_5 in var_1) {
    if(isDefined(var_5)) {
      var_6 = distance(var_5.origin, var_0);
      if(var_6 >= var_2) {
        continue;
      }

      var_2 = var_6;
      var_3 = var_5;
    }
  }

  return var_3;
}

complete_sky_steps() {
  clean_up_sky_steps();
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(4);
}

debug_do_sky_steps() {}

activate_sky_step_goal() {
  var_0 = scripts\engine\utility::getstruct("sky_step_goal", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("sb_quest_origin");
  var_1 setscriptablepartstate("vfx", "train_skull");
  var_1.angles = var_0.angles;
  var_1 thread sky_step_goal_timeout_monitor(var_1);
  var_1 thread player_reached_monitor(var_1);
  return var_1;
}

sky_step_goal_timeout_monitor(var_0) {
  var_0 endon("death");
  wait(5);
  level notify("sky_step_goal_timeout");
  var_0 delete();
}

player_reached_monitor(var_0) {
  var_0 endon("death");
  for(;;) {
    if(player_reach_goal(var_0)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  level notify("sky_step_goal_reached");
  playFX(level._effect["ghost_explosion_death_green"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  var_0 delete();
}

player_reach_goal(var_0) {
  foreach(var_2 in level.players) {
    if(distancesquared(var_0.origin, var_2 getEye()) < 1600) {
      return 1;
    }
  }

  return 0;
}

wait_for_player_to_jump_on_top(var_0) {
  var_0 endon("death");
  for(;;) {
    foreach(var_2 in level.players) {
      if(player_is_on_top_sky_step(var_2, var_0)) {
        return;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

sky_step_timeout_monitor(var_0) {
  var_0 endon("death");
  wait(5);
  deactivate_sky_step(var_0);
}

player_is_on_top_sky_step(var_0, var_1) {
  if(distancesquared(var_0.origin, var_1.origin) > 400) {
    return 0;
  }

  if(var_0.origin[2] < var_1.origin[2]) {
    return 0;
  }

  return 1;
}

get_sky_steps_at_tier(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray("sky_step_tier_" + var_0, "targetname");
  var_3 = [];
  foreach(var_5 in var_2) {
    if(distancesquared(var_1.origin, var_5.origin) > 27225) {
      continue;
    }

    var_3[var_3.size] = var_5;
  }

  return var_3;
}

prepare_sky_steps() {
  var_0 = getEntArray("sky_step_clip", "targetname");
  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin + (0, 0, 2));
    var_3 setModel("sb_quest_origin");
    var_3 linkto(var_2);
    var_2.activated = 0;
    var_2.sky_step_vfx = var_3;
    var_2.original_pos = var_2.origin;
    var_2 dontinterpolate();
    scripts\engine\utility::waitframe();
  }

  level.sky_steps = var_0;
}

activate_sky_step(var_0, var_1) {
  var_2 = get_available_sky_step();
  var_2.activated = 1;
  var_2 dontinterpolate();
  var_2.sky_step_vfx dontinterpolate();
  var_2.sky_step_vfx show();
  var_2.origin = var_0.origin;
  var_2.sky_step_vfx setscriptablepartstate("vfx", "sky_step");
  if(scripts\engine\utility::istrue(var_1)) {
    var_2 thread sky_step_timeout_monitor(var_2);
  }

  return var_2;
}

deactivate_sky_step(var_0) {
  var_0.sky_step_vfx setscriptablepartstate("vfx", "off");
  var_0.activated = 0;
  var_0 dontinterpolate();
  var_0.sky_step_vfx dontinterpolate();
  var_0.sky_step_vfx hide();
  var_0.origin = var_0.original_pos;
}

clean_up_sky_steps() {
  if(isDefined(level.sky_steps)) {
    foreach(var_1 in level.sky_steps) {
      var_1.sky_step_vfx delete();
      var_1 delete();
    }
  }
}

get_available_sky_step() {
  foreach(var_1 in level.sky_steps) {
    if(var_1.activated == 0) {
      return var_1;
    }
  }
}

grab_skull_in_front_train() {
  level.should_set_up_skull_in_front_of_train = 1;
  level waittill("player_grabs_train_skull");
}

try_set_up_skull_in_front_of_train(var_0) {
  if(should_set_up_skull_in_front_of_train()) {
    var_1 = var_0.origin + (0, 450, 150);
    var_2 = spawn("script_model", var_1);
    var_2.angles = vectortoangles((0, 1, 0));
    var_2 setModel("sb_quest_origin");
    var_2 setscriptablepartstate("vfx", "train_skull");
    var_2 linkto(var_0);
    level.train_skull = var_2;
    var_2 thread player_jump_by_monitor(var_2);
  }
}

player_jump_by_monitor(var_0) {
  var_0 endon("death");
  for(;;) {
    if(any_player_reach_skull(var_0)) {
      playFX(level._effect["ghost_explosion_death_green"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
      level notify("player_grabs_train_skull");
      var_0 delete();
    }

    scripts\engine\utility::waitframe();
  }
}

any_player_reach_skull(var_0) {
  foreach(var_2 in level.players) {
    if(distancesquared(var_2 getEye(), var_0.origin) < 8100) {
      playfxontagforclients(level._effect["get_train_skull"], var_2, "tag_eye", var_2);
      return 1;
    }
  }

  return 0;
}

should_set_up_skull_in_front_of_train() {
  if(!scripts\engine\utility::istrue(level.should_set_up_skull_in_front_of_train)) {
    return 0;
  }

  if(isDefined(level.train_skull)) {
    return 0;
  }

  return 1;
}

complete_grab_skull_in_front_train() {
  if(isDefined(level.train_skull)) {
    level.train_skull delete();
  }

  level.should_set_up_skull_in_front_of_train = 0;
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(5);
}

debug_grab_skull_in_front_train() {}

call_service_number() {
  level.skullbuster_service_available = 1;
  level waittill("skullbuster_service_called");
}

complete_call_service_number() {
  level.skullbuster_service_available = 0;
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(6);
  level thread play_gns_success_vo();
}

play_gns_success_vo() {
  level endon("game_ended");
  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("access_ghostnskulls", "disco_comment_vo");
  }
}

debug_call_service_number() {}

wait_for_player_activation() {
  level endon("player_debug_activate_cabinet");
  level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"], (-713, 2609, 943));
  triggerfx(level.gns_game_console_vfx);
  var_0 = (-731, 2611, 898);
  var_1 = 2500;
  for(;;) {
    var_2 = 1;
    foreach(var_4 in level.players) {
      if(scripts\engine\utility::istrue(var_4.inlaststand)) {
        var_2 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_4.iscarrying)) {
        var_2 = 0;
        break;
      }

      if(distancesquared(var_4.origin, var_0) > var_1) {
        var_2 = 0;
        break;
      }

      if(!var_4 usebuttonpressed()) {
        var_2 = 0;
        break;
      }
    }

    wait(0.25);
    if(var_2) {
      var_2 = 1;
      foreach(var_4 in level.players) {
        if(scripts\engine\utility::istrue(var_4.inlaststand)) {
          var_2 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_4.iscarrying)) {
          var_2 = 0;
          break;
        }

        if(distancesquared(var_4.origin, var_0) > var_1) {
          var_2 = 0;
          break;
        }

        if(!var_4 usebuttonpressed()) {
          var_2 = 0;
          break;
        }
      }
    }

    foreach(var_4 in level.players) {
      if(isDefined(level.clock_interaction) && isDefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_4) {
        var_2 = 0;
      }

      if(isDefined(level.clock_interaction_q2) && isDefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_4) {
        var_2 = 0;
      }

      if(isDefined(level.clock_interaction_q3) && isDefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_4) {
        var_2 = 0;
      }

      if(scripts\engine\utility::istrue(var_4.start_breaking_clock)) {
        var_2 = 0;
      }

      if(scripts\engine\utility::istrue(var_4.is_using_gourd)) {
        var_2 = 0;
      }

      if(scripts\engine\utility::istrue(var_4.kung_fu_mode)) {
        var_2 = 0;
      }
    }

    if(var_2) {
      if(isDefined(level.gns_game_console_vfx)) {
        level.gns_game_console_vfx delete();
      }

      return;
    }

    scripts\engine\utility::waitframe();
  }
}

complete_clean_arcade_cabinet() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(-1, 0.5);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::start_ghost_wave();
}

debug_wait_for_player_activation() {}

wait_one_wave() {
  level waittill("regular_wave_starting");
}

cp_disco_gns_3_setup() {
  level.gns_num_of_wave = 3;
  level.init_formation_movement_func = ::gns3_formation_movement;
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::init();
  level.death_trigger_reset_y_pos = -3234;
  level.death_trigger_activate_y_pos = -2305;
  level.original_death_grid_lines_front_y_pos = -638;
  level.zombie_ghost_model = "zombie_ghost_cube_green";
  level.zombie_ghost_color_manager = ::cp_disco_ghost_color_manager;
  level.set_moving_target_color_func = ::cp_disco_set_moving_target_color;
  level.should_moving_target_explode = ::cp_disco_should_moving_target_explode;
  level.hit_wrong_moving_target_func = ::cp_disco_hit_wrong_moving_target_func;
  level.moving_target_pre_fly_time = 0.5;
  level.gns_hotjoin_wait_notify = "finish_intro_gesture";
  level.ghost_n_skull_reactivate_func = ::reactivate_skullbuster_cabinet;
  level.gns_reward_func = ::disco_gns_player_reward_func;
  level.get_fake_ghost_model_func = ::disco_get_fake_ghost_model_func;
  level.activate_moving_targets_func = ::cp_disco_activate_moving_targets;
  level.assign_moving_target_flags_func = ::cp_disco_assign_moving_target_flags;
  level.reset_moving_target_wave_data = ::cp_disco_reset_moving_target_wave_data;
  level.process_moving_target_hit_func = ::cp_disco_process_moving_target_hit_with_right_color;
  level.grab_same_ghost_string = &"CP_DISCO_GNS_TRACK_SAME_CUBE";
  level.gns_moving_target_model = "cp_disco_pixel_question_mark";
  level.enter_ghosts_n_skulls_func = ::cp_disco_enter_ghosts_n_skulls_func;
  level.all_perk_list = ["perk_machine_boom", "perk_machine_flash", "perk_machine_fwoosh", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_revive", "perk_machine_run", "perk_machine_deadeye", "perk_machine_tough", "perk_machine_zap"];
  load_gns_3_vfx();
  register_ghost_form();
  register_waves_movement();
  load_cp_disco_ghost_exp_vfx();
  level thread adjust_player_exit_gns_pos();
  level thread adjust_mahjong_pick_up_pos();
  init_ghost_n_skull_3_quest();
}

cp_disco_enter_ghosts_n_skulls_func(var_0) {
  var_0 notify("exit_kung_fu_requested");
  scripts\engine\utility::waitframe();
}

load_gns_3_vfx() {
  level._effect["combo_arc_green"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_green.vfx");
  level._effect["combo_arc_red"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_red.vfx");
  level._effect["combo_arc_blue"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_blue.vfx");
  level._effect["combo_arc_yellow"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_yellow.vfx");
  level._effect["candle_flame"] = loadfx("vfx\iw7\levels\cp_disco\amb\vfx_candle_flame.vfx");
  level._effect["get_train_skull"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_get_train_skull.vfx");
}

cp_disco_ghost_color_manager() {
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
    level.zombie_ghost_model = "zombie_ghost_cube_red";
    return;
  }

  if(var_2 < var_0) {
    level.zombie_ghost_model = "zombie_ghost_cube_green";
    return;
  }

  if(var_3 < var_0) {
    level.zombie_ghost_model = "zombie_ghost_cube_yellow";
    return;
  }

  level.zombie_ghost_model = "zombie_ghost_cube_blue";
}

cp_disco_set_moving_target_color(var_0, var_1) {
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

determine_color(var_0) {
  var_1 = scripts\engine\utility::array_randomize(var_0);
  level.moving_target_color_based_on_priority = [];
  level.moving_target_color_based_on_priority["low"] = var_1[0];
  level.moving_target_color_based_on_priority["medium"] = var_1[1];
  level.moving_target_color_based_on_priority["high"] = var_1[2];
}

cp_disco_should_moving_target_explode(var_0, var_1) {
  if(level.allow_skulls_to_explode == 0) {
    return 0;
  }

  if(var_1.revealed == 1) {
    return 0;
  }

  return isDefined(var_1) && isDefined(var_1.color) && var_0.color == var_1.color;
}

cp_disco_hit_wrong_moving_target_func(var_0, var_1, var_2) {
  if(var_1.revealed == 1) {
    return;
  }

  if(level.allow_skulls_to_explode == 0) {
    return;
  }

  playFXOnTag(level._effect["wrong_color_" + var_2.color], var_1, "tag_origin");
  var_0 playlocalsound("ghosts_8bit_match3_negative");
  level.num_moving_target_escaped++;
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::update_num_targets_escaped_hud();
  level thread delay_determine_game_fail();
}

delay_determine_game_fail() {
  level endon("game_ended");
  var_0 = 2;
  wait(var_0);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::determine_game_fail();
}

disco_gns_player_reward_func() {
  upgrade_magic_wheel();
  foreach(var_1 in level.players) {
    if(!scripts\engine\utility::istrue(level.entered_thru_card)) {
      var_1 scripts\cp\zombies\achievement::update_achievement("COIN_OP", 1);
    }

    var_1 thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::give_gns_base_reward(var_1);
  }

  level notify("end_this_thread_of_gns_fnf_card");
}

upgrade_magic_wheel() {
  level.magic_wheel_upgraded_pap1 = 1;
  level.complete_skull_buster = 1;
  if(isDefined(level.current_active_wheel)) {
    level.current_active_wheel setscriptablepartstate("fx", "upgrade");
  }
}

gns3_formation_movement() {
  level.formation_movements = [];
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(1, ::formation_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(2, ::formation_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(3, ::formation_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(4, ::formation_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(5, ::formation_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(6, ::formation_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(7, ::formation_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(8, ::formation_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(9, ::formation_move_pattern);
}

formation_move_pattern(var_0) {
  return ["R", "R", "R", "F", "L", "L", "L", "F"];
}

register_ghost_form() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1, 1);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1, 2);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1, 3);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 4);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 5);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 6);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 7);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 8);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 9);
}

register_waves_movement() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(1, 1, 2, 0.7);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(2, 1, 1.6, 0.7);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(3, 1, 1.2, 0.7);
  level.available_formations = undefined;
  level.formation_movements = undefined;
}

load_cp_disco_ghost_exp_vfx() {
  level._effect["ghost_explosion_death_red"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_red.vfx");
  level._effect["ghost_explosion_death_yellow"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_yellow.vfx");
  level._effect["ghost_explosion_death_blue"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_blue.vfx");
  level._effect["sb_quest_item_pickup"] = loadfx("vfx\iw7\core\zombie\vfx_zom_souvenir_pickup.vfx");
  level._effect["write_1972_success"] = loadfx("vfx\iw7\levels\cp_disco\vfx_skb_1972_burst.vfx");
  level._effect["wrong_color_green"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_alien_head_x_green.vfx");
  level._effect["wrong_color_red"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_alien_head_x_red.vfx");
  level._effect["wrong_color_blue"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_alien_head_x_blue.vfx");
  level._effect["wrong_color_yellow"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_alien_head_x_yellow.vfx");
}

disco_get_fake_ghost_model_func(var_0) {
  return "fake_zombie_ghost_cube_" + var_0;
}

cp_disco_activate_moving_targets(var_0) {
  randomize_color_for_color_group();
  assign_color_to_color_group();
  reveal_color_for_puzzle();
  set_allow_skulls_to_explode(1);
}

randomize_color_for_color_group() {
  level.color_for_color_group = [];
  for(var_0 = ["red", "blue", "yellow", "green"]; var_0.size > 0; var_0 = scripts\engine\utility::array_remove(var_0, var_1)) {
    var_1 = scripts\engine\utility::random(var_0);
    level.color_for_color_group[level.color_for_color_group.size] = var_1;
  }
}

assign_color_to_color_group() {
  foreach(var_1 in level.moving_target_groups) {
    foreach(var_3 in var_1) {
      var_3.color = level.color_for_color_group[var_3.color_group];
    }
  }
}

reveal_color_for_puzzle() {
  var_0 = 0.5;
  var_1 = 0.25;
  var_2 = 0.5;
  wait(var_0);
  var_3 = 0;
  for(;;) {
    var_4 = get_moving_targets_with_reveal_id(var_3);
    if(var_4.size > 0) {
      foreach(var_6 in var_4) {
        reveal_moving_target_color(var_6);
      }

      wait(var_1);
    } else {
      wait(var_2);
      return;
    }

    var_3++;
  }
}

get_moving_targets_with_reveal_id(var_0) {
  var_1 = [];
  foreach(var_3 in level.moving_target_groups) {
    foreach(var_5 in var_3) {
      if(isDefined(var_5.reveal_id) && var_5.reveal_id == var_0) {
        var_1[var_1.size] = var_5;
      }
    }
  }

  return var_1;
}

reveal_moving_target_color(var_0) {
  var_0 setModel("zmb_pixel_skull");
  var_0.revealed = 1;
  var_0 setscriptablepartstate("skull_vfx", var_0.color);
}

cp_disco_assign_moving_target_flags(var_0, var_1) {
  var_1.revealed = 0;
  var_1.color_group = int(var_0.groupname);
  var_1.subgroup = var_0.subclass;
  var_1.vfx_start = isDefined(var_0.script_side);
  if(isDefined(var_0.script_startname)) {
    var_1.reveal_id = int(var_0.script_startname);
  }
}

cp_disco_reset_moving_target_wave_data() {
  set_allow_skulls_to_explode(0);
}

set_allow_skulls_to_explode(var_0) {
  level.allow_skulls_to_explode = var_0;
}

cp_disco_process_moving_target_hit_with_right_color(var_0, var_1, var_2) {
  var_1 playlocalsound("ghosts_8bit_match3_positive");
  reveal_moving_target_color(var_0);
  var_3 = get_moving_targets_in_same_subgroup(var_0.subgroup);
  if(all_moving_targets_are_revealed(var_3)) {
    var_1 playlocalsound("ghosts_8bit_match3_explo");
    explode_moving_targets(var_3, var_1);
  }
}

get_moving_targets_in_same_subgroup(var_0) {
  var_1 = [];
  foreach(var_3 in level.moving_target_groups) {
    foreach(var_5 in var_3) {
      if(isDefined(var_5) && var_5.subgroup == var_0) {
        var_1[var_1.size] = var_5;
      }
    }
  }

  return var_1;
}

all_moving_targets_are_revealed(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.revealed == 0) {
      return 0;
    }
  }

  return 1;
}

explode_moving_targets(var_0, var_1) {
  var_2 = 1;
  var_3 = get_vfx_start_moving_target(var_0);
  foreach(var_5 in var_0) {
    if(var_5 == var_3) {
      var_5 thread delay_moving_target_explode(var_5, var_1, var_2);
      continue;
    }

    var_5 thread delay_moving_target_explode(var_5, var_1, var_2, var_3);
  }
}

get_vfx_start_moving_target(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\engine\utility::istrue(var_2.vfx_start)) {
      return var_2;
    }
  }
}

delay_moving_target_explode(var_0, var_1, var_2, var_3) {
  play_combo_arc_vfx(var_0, var_2, var_3);
  playFX(level._effect["ghost_explosion_death_" + var_0.color], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  scripts\aitypes\zombie_ghost\behaviors::remove_moving_target_default(var_0, var_1);
}

play_combo_arc_vfx(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = int(var_1 * 20);
    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2.origin;
      var_6 = var_0.origin;
      var_7 = var_6 - var_5;
      var_8 = vectortoangles(var_7);
      playfxbetweenpoints(level._effect["combo_arc_" + var_0.color], var_5, var_8, var_6);
      scripts\engine\utility::waitframe();
    }

    return;
  }

  wait(var_1);
}

adjust_player_exit_gns_pos() {
  level endon("game_ended");
  wait(5);
  var_0 = scripts\engine\utility::getstructarray("ghost_wave_player_end", "targetname");
  foreach(var_2 in var_0) {
    if(var_2.origin == (-743, 2620, 906)) {
      var_2.origin = (-745, 2620, 906);
      var_2.angles = (0, 345, 0);
      continue;
    }

    if(var_2.origin == (-743, 2572, 906)) {
      var_2.origin = (-771, 2598, 906);
      var_2.angles = (0, 15, 0);
      continue;
    }

    if(var_2.origin == (-743, 2596, 906)) {
      var_2.origin = (-784, 2621, 906);
      var_2.angles = (0, 355, 0);
    }
  }
}

adjust_mahjong_pick_up_pos() {
  level endon("game_ended");
  wait(5);
  var_0 = scripts\engine\utility::getstructarray("sb_mahjong_tile", "targetname");
  foreach(var_2 in var_0) {
    if(var_2.origin == (1393, 816, 801)) {
      var_2.origin = (1040, 568, 790.6);
      var_2.angles = (7, 135, -1);
    }
  }
}

reactivate_skullbuster_cabinet() {
  if(!scripts\cp\zombies\zombie_quest::quest_line_exist("reactivateghost")) {
    var_0 = getomnvar("zm_num_ghost_n_skull_coin");
    if(isDefined(var_0) && var_0 < 5) {
      return;
    }

    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 0, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::reactivate_cabinet, ::call_service_number, ::complete_call_service_number, ::debug_call_service_number);
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 1, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation);
  }

  level thread scripts\cp\zombies\zombie_quest::start_quest_line("reactivateghost");
}