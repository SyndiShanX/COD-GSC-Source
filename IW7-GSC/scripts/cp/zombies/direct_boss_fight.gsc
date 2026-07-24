/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp\zombies\direct_boss_fight.gsc
****************************************************/

init() {
  check_direct_boss_fight();

  if(should_directly_go_to_boss_fight()) {
    level.disable_start_spawn_on_navmesh = 1;
    level.getspawnpoint = ::get_direct_to_boss_spawn_point;
    set_up_perk_purchase_board();
    set_up_weapon_purchase_board();
    level thread disable_things_in_afterlife_arcade();
  }
}

check_direct_boss_fight() {
  if(direct_boss_fight_activated()) {
    activate_direct_to_boss_fight();
  }
}

should_directly_go_to_boss_fight() {
  return scripts\engine\utility::is_true(level.direct_to_boss_fight);
}

activate_direct_to_boss_fight() {
  level.direct_to_boss_fight = 1;
}

get_direct_to_boss_fight_starting_currency() {
  return 20000;
}

get_direct_to_boss_spawn_point() {
  var_0 = self;
  var_1 = scripts\engine\utility::getStructArray("afterlife_arcade", "targetname");

  if(isDefined(level.additional_afterlife_arcade_start_point)) {
    var_1 = scripts\engine\utility::array_combine(var_1, level.additional_afterlife_arcade_start_point);
  }

  return var_1[var_0 getentitynumber()];
}

disable_things_in_afterlife_arcade() {
  level endon("game_ended");
  var_0 = 9;
  var_1 = ["afterlife_spectate_door", "afterlife_selfrevive_door", "basketball_game_afterlife", "laughingclown_afterlife", "clown_tooth_game_afterlife", "game_race", "bowling_for_planets_afterlife", "shooting_gallery_afterlife", "arcade_icehock", "arcade_hero", "arcade_seaques", "arcade_boxing", "arcade_oink", "arcade_crackpo", "arcade_plaque", "arcade_keyston", "arcade_spider", "arcade_robottank", "arcade_riverraid", "arcade_pitfall", "arcade_demon", "arcade_barnstorming", "arcade_starmaster", "arcade_cosmic"];
  wait(var_0);

  foreach(var_3 in var_1) {
    var_4 = scripts\engine\utility::getStructArray(var_3, "script_noteworthy");

    foreach(var_6 in var_4) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_6);

      if(var_3 == "shooting_gallery_afterlife") {
        var_6._id_13C2C hide();
      }
    }
  }
}

enable_things_in_afterlife_arcade() {
  var_0 = ["afterlife_spectate_door", "afterlife_selfrevive_door", "basketball_game_afterlife", "laughingclown_afterlife", "clown_tooth_game_afterlife", "game_race", "bowling_for_planets_afterlife", "shooting_gallery_afterlife", "arcade_icehock", "arcade_hero", "arcade_seaques", "arcade_boxing", "arcade_oink", "arcade_crackpo", "arcade_plaque", "arcade_keyston", "arcade_spider", "arcade_robottank", "arcade_riverraid", "arcade_pitfall", "arcade_demon", "arcade_barnstorming", "arcade_starmaster", "arcade_cosmic"];

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getStructArray(var_2, "script_noteworthy");

    foreach(var_5 in var_3) {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_5);

      if(var_2 == "shooting_gallery_afterlife") {
        var_5._id_13C2C show();
      }
    }
  }
}

direct_boss_fight_activated() {
  switch (level.script) {
    case "cp_zmb":
      if(getdvarint("scr_direct_to_grey", 0) != 0) {
        return 1;
      } else {
        return 0;
      }
    case "cp_rave":
      if(getdvarint("scr_direct_to_super_slasher", 0) != 0) {
        return 1;
      } else {
        return 0;
      }
    case "cp_disco":
      if(getdvarint("scr_direct_to_rat_king", 0) != 0) {
        return 1;
      } else {
        return 0;
      }
    case "cp_town":
      if(getdvarint("scr_direct_to_crab_boss", 0) != 0) {
        return 1;
      } else {
        return 0;
      }
    case "cp_final":
      if(getdvarint("scr_direct_to_rhino_fight", 0) != 0) {
        return 1;
      } else {
        return 0;
      }
    default:
      return 0;
  }
}

set_up_perk_purchase_board() {
  create_perk_purchase_board();
  create_perk_purchase_candy_boxes();
  level thread create_perk_purchase_interaction();
  level thread create_perk_purchase_light();
}

clean_up_perk_purchase_board() {
  level.perk_purchase_board delete();

  foreach(var_1 in level.perk_purchase_structs) {
    var_1.candy_box delete();
  }

  if(isDefined(level.perk_purchase_light_fx)) {
    level.perk_purchase_light_fx delete();
  }

  foreach(var_4 in level.perk_purchase_interactions) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_4);
  }
}

clean_up_weapon_purchase_board() {
  level notify("stop_weapon_purchase_board");

  foreach(var_1 in level.weapon_purchase_interactions) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
  }

  foreach(var_4 in level.weapon_purchase_boards) {
    var_4 delete();
  }

  foreach(var_7 in level.weapon_board_light_vfx) {
    var_7 delete();
  }

  foreach(var_10 in level.weapon_purchase_models) {
    var_10 delete();
  }
}

create_perk_purchase_candy_boxes() {
  level.perk_purchase_structs = [];
  var_0 = get_perk_list();
  var_1 = var_0.size;

  foreach(var_4, var_3 in var_0) {
    create_perk_purchase_candy_box(var_4, var_3, var_1);
  }
}

create_perk_purchase_candy_box(var_0, var_1, var_2) {
  var_3 = get_candy_box_struct_loc(var_0, var_2);
  var_4 = spawnStruct();
  var_4.origin = var_3;
  var_5 = spawn("script_model", get_candy_box_loc(var_3));
  var_5 setModel(get_perk_box_model(var_1));
  var_5.angles = vectortoangles(anglesToForward(level.perk_purchase_board.angles) * -1);
  var_5._id_C71F = var_5.angles;
  var_5._id_C725 = var_5.origin;
  var_5.perk = var_1;
  var_5 rotateroll(90, 0.1);
  var_4.candy_box = var_5;
  level.perk_purchase_structs[level.perk_purchase_structs.size] = var_4;
}

get_candy_box_loc(var_0) {
  var_1 = 0.25;
  var_2 = 3.1;
  var_3 = anglestoup(level.perk_purchase_board.angles);
  var_4 = anglestoright(level.perk_purchase_board.angles);
  var_5 = var_3 * -1 * var_1;
  var_6 = var_4 * var_2;
  return var_0 + var_5 + var_6;
}

get_candy_box_struct_loc(var_0, var_1) {
  var_2 = 2;
  var_3 = 20.25;
  var_4 = 5.1;
  var_5 = 11;
  var_6 = 0.8;
  var_7 = 40;
  var_8 = anglestoup(level.perk_purchase_board.angles);
  var_9 = anglestoright(level.perk_purchase_board.angles) * -1;
  var_10 = anglesToForward(level.perk_purchase_board.angles) * -1;
  var_11 = level.perk_purchase_board.origin + var_8 * var_3 + var_9 * var_4;
  var_12 = var_7 / ceil(var_1 / var_2 - 1);
  var_13 = floor(var_0 / var_2) * var_12 * var_8 * -1;
  var_14 = var_0 % var_2 * var_5 * var_9 * -1;
  var_15 = var_10 * var_6;
  return var_11 + var_13 + var_14 + var_15;
}

create_perk_purchase_board() {
  var_0 = "p7_cafe_wall_menu_01";
  var_1 = scripts\engine\utility::getStruct("afterlife_spectate_door", "script_noteworthy");
  var_2 = anglesToForward(var_1.angles);
  var_3 = anglestoright(var_1.angles) * -1;
  var_4 = spawn("script_model", var_1.origin + var_2 * get_board_forward_dist() + var_3 * get_board_left_dist());
  var_4 setModel(var_0);
  var_4.angles = var_1.angles;
  var_4 thread player_use_monitor(var_4);
  level.perk_purchase_board = var_4;
}

player_use_monitor(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  wait 5;

  for(;;) {
    foreach(var_2 in level.players) {
      if(in_perk_purchase_range(var_0, var_2)) {
        check_candy_box_looking_at(var_2);
        continue;
      }

      clear_candy_box_looking_at(var_2);
    }

    scripts\engine\utility::waitframe();
  }
}

check_candy_box_looking_at(var_0) {
  var_1 = [];

  foreach(var_3 in level.perk_purchase_structs) {
    if(var_0 worldpointinreticle_circle(var_3.origin, 35, 75)) {
      var_1[var_1.size] = var_3.candy_box;
    }
  }

  if(var_1.size == 0) {
    clear_candy_box_looking_at(var_0);
    return;
  } else {
    var_5 = sortbydistance(var_1, var_0 getEye())[0];

    if(isDefined(var_0.candy_box_looking_at)) {
      if(var_5 == var_0.candy_box_looking_at) {
        return;
      } else {
        clear_candy_box_looking_at(var_0);
        mark_candy_box_looking_at(var_5, var_0);
      }
    } else
      mark_candy_box_looking_at(var_5, var_0);
  }
}

mark_candy_box_looking_at(var_0, var_1) {
  var_0 hudoutlineenableforclient(var_1, 1, 1, 0);
  var_1.candy_box_looking_at = var_0;
  var_1 scripts\cp\cp_interaction::refresh_interaction();
  push_candy_box_forward(var_0);
}

push_candy_box_forward(var_0) {
  var_1 = 4;

  if(!isDefined(var_0.num_times_being_looked_at)) {
    var_0.num_times_being_looked_at = 0;
  }

  var_0.num_times_being_looked_at++;

  if(var_0.num_times_being_looked_at == 1) {
    var_2 = anglesToForward(level.perk_purchase_board.angles) * -1;
    var_0.origin = var_0.origin + var_2 * var_1;
  }
}

clear_candy_box_looking_at(var_0) {
  if(isDefined(var_0.candy_box_looking_at)) {
    push_candy_box_back(var_0.candy_box_looking_at);
    var_0.candy_box_looking_at hudoutlinedisableforclient(var_0);
    var_0.candy_box_looking_at = undefined;
    var_0 scripts\cp\cp_interaction::refresh_interaction();
  }
}

push_candy_box_back(var_0) {
  var_0.num_times_being_looked_at--;

  if(var_0.num_times_being_looked_at == 0) {
    var_0.origin = var_0._id_C725;
  }
}

in_perk_purchase_range(var_0, var_1) {
  return distance2dsquared(var_0.origin, var_1.origin) <= 8100;
}

create_perk_purchase_interaction() {
  level endon("game_ended");
  wait 5;
  level.perk_purchase_interactions = [];
  var_0 = anglesToForward(level.perk_purchase_board.angles) * -1;
  var_1 = anglestoright(level.perk_purchase_board.angles);
  set_up_perk_purchase_interaction_at(scripts\engine\utility::drop_to_ground(level.perk_purchase_board.origin + var_0 * 1, 0, -200));
}

set_up_perk_purchase_interaction_at(var_0) {
  var_1 = spawnStruct();
  var_1.name = "perk_purchase";
  var_1.script_noteworthy = "perk_purchase";
  var_1.origin = var_0;
  var_1.cost = 0;
  var_1.powered_on = 1;
  var_1.spend_type = undefined;
  var_1.script_parameters = "";
  var_1.requires_power = 0;
  var_1.hint_func = ::perk_purchase_hint_func;
  var_1.activation_func = ::try_perk_purchase;
  var_1.enabled = 1;
  var_1.disable_guided_interactions = 1;
  var_1.custom_search_dist = 100;
  level.interactions["perk_purchase"] = var_1;
  level.perk_purchase_interactions[level.perk_purchase_interactions.size] = var_1;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}

perk_purchase_hint_func(var_0, var_1) {
  if(!isDefined(var_1.candy_box_looking_at)) {
    return "";
  }

  var_2 = var_1.candy_box_looking_at.perk;

  if(var_1 scripts\cp\utility::has_zombie_perk(var_2)) {
    return &"COOP_PERK_MACHINES_REMOVE_PERK";
  }

  if(isDefined(var_1.zombies_perks) && var_1.zombies_perks.size > 4 && !scripts\engine\utility::is_true(var_1.have_gns_perk)) {
    return &"COOP_PERK_MACHINES_PERK_SLOTS_FULL";
  }

  var_3 = get_perk_cost(var_2);

  if(var_1 scripts\cp\cp_persistence::get_player_currency() < var_3) {
    return &"COOP_INTERACTIONS_NEED_MONEY";
  }

  return level.interaction_hintstrings[var_2];
}

try_perk_purchase(var_0, var_1) {
  if(!isDefined(var_1.candy_box_looking_at)) {
    return;
  }
  var_1 thread perk_purchase_internal(var_1);
}

perk_purchase_internal(var_0) {
  var_0 endon("disconnect");
  var_1 = var_0.candy_box_looking_at.perk;
  var_2 = get_perk_cost(var_1);

  if(var_0 scripts\cp\utility::has_zombie_perk(var_1)) {
    if(soundexists("perk_machine_remove_perk")) {
      var_0 playlocalsound("perk_machine_remove_perk");
    }

    var_0 scripts\cp\zombies\zombies_perk_machines::take_zombies_perk(var_1);
    var_0 scripts\cp\cp_persistence::give_player_currency(var_2);
    var_0 scripts\cp\cp_interaction::refresh_interaction();
  } else {
    if(isDefined(var_0.zombies_perks) && var_0.zombies_perks.size > 4 && !scripts\engine\utility::is_true(var_0.have_gns_perk)) {
      return;
    }
    var_2 = get_perk_cost(var_0.candy_box_looking_at.perk);

    if(var_0 scripts\cp\cp_persistence::get_player_currency() < var_2) {
      return;
    }
    var_0 scripts\cp\cp_persistence::take_player_currency(var_2, 1, "perk");

    if(var_1 == "perk_machine_rat_a_tat") {
      var_0 scripts\cp\zombies\zombies_perk_machines::play_perk_gesture(var_1);
      var_0 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_1, 1);
      return;
    }

    var_0 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_1, 1);
    wait 1;
    var_0 scripts\cp\zombies\zombies_perk_machines::play_perk_gesture(var_1);
  }
}

get_board_forward_dist() {
  var_0 = 170;
  var_1 = 158;

  switch (level.script) {
    case "cp_zmb":
      return var_0;
    default:
      return var_1;
  }
}

get_board_left_dist() {
  var_0 = 170;
  var_1 = 107;

  switch (level.script) {
    case "cp_zmb":
      return var_0;
    default:
      return var_1;
  }
}

get_perk_list() {
  var_0 = ["perk_machine_boom", "perk_machine_fwoosh", "perk_machine_flash", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_tough", "perk_machine_run", "perk_machine_revive", "perk_machine_zap"];

  switch (level.script) {
    case "cp_rave":
    case "cp_zmb":
      var_0 = scripts\engine\utility::array_add(var_0, "perk_machine_smack");
      break;
    case "cp_disco":
      var_0 = scripts\engine\utility::array_add(var_0, "perk_machine_deadeye");
      break;
    case "cp_final":
    case "cp_town":
      var_0 = scripts\engine\utility::array_add(var_0, "perk_machine_smack");
      var_0 = scripts\engine\utility::array_add(var_0, "perk_machine_change");
      var_0 = scripts\engine\utility::array_add(var_0, "perk_machine_deadeye");
      break;
  }

  return var_0;
}

get_perk_cost(var_0) {
  switch (var_0) {
    case "perk_machine_zap":
    case "perk_machine_change":
    case "perk_machine_deadeye":
    case "perk_machine_fwoosh":
    case "perk_machine_boom":
    case "perk_machine_revive":
      return 1500;
    case "perk_machine_run":
    case "perk_machine_more":
    case "perk_machine_rat_a_tat":
    case "perk_machine_smack":
      return 2000;
    case "perk_machine_tough":
      return 2500;
    case "perk_machine_flash":
      return 3000;
  }
}

get_perk_box_model(var_0) {
  switch (var_0) {
    case "perk_machine_boom":
      return "zmb_candybox_bomb_closed";
    case "perk_machine_flash":
      return "zmb_candybox_quickies_closed";
    case "perk_machine_fwoosh":
      return "zmb_candybox_trail_closed";
    case "perk_machine_more":
      return "zmb_candybox_mule_closed";
    case "perk_machine_rat_a_tat":
      return "zmb_candybox_bang_closed";
    case "perk_machine_revive":
      return "zmb_candybox_up_closed";
    case "perk_machine_run":
      return "zmb_candybox_racin_closed";
    case "perk_machine_deadeye":
      return "cp_disco_candybox_closed";
    case "perk_machine_tough":
      return "zmb_candybox_tuff_closed";
    case "perk_machine_change":
      return "cp_town_candybox_change_closed";
    case "perk_machine_zap":
      return "zmb_candybox_blue_closed";
    case "perk_machine_smack":
      return "zmb_candybox_slappy_closed";
  }
}

create_perk_purchase_light() {
  if(level.script == "cp_town") {
    return;
  }
  wait 5;
  var_0 = anglesToForward(level.perk_purchase_board.angles) * -1;
  var_1 = spawn("script_model", level.perk_purchase_board.origin + var_0 * 20);
  var_1 setModel("direct_boss_fight_origin");
  var_1 setscriptablepartstate("perk_board_light", "on");
  level.perk_purchase_light_fx = var_1;
}

set_up_weapon_purchase_board() {
  create_weapon_purchase_boards();
  level thread create_weapon_purchase_interaction();
  level thread create_weapon_purchase_models();
  level thread create_weapon_board_lights();
  level thread player_weapon_purchase_monitor();
}

player_weapon_purchase_monitor() {
  level endon("game_ended");
  level endon("stop_weapon_purchase_board");
  wait 5;
  var_0 = get_weapon_purchase_range_edge_x_value();

  for(;;) {
    foreach(var_2 in level.players) {
      if(in_weapon_purchase_range(var_2, var_0)) {
        check_weapon_looking_at(var_2);
        continue;
      }

      clear_weapon_looking_at(var_2);
    }

    scripts\engine\utility::waitframe();
  }
}

check_weapon_looking_at(var_0) {
  var_1 = [];

  foreach(var_3 in level.weapon_purchase_structs) {
    if(var_0 worldpointinreticle_circle(var_3.origin, 35, 135)) {
      var_1[var_1.size] = var_3._id_13C2C;
    }
  }

  if(var_1.size == 0) {
    clear_weapon_looking_at(var_0);
    return;
  } else {
    var_5 = sortbydistance(var_1, var_0 getEye())[0];

    if(isDefined(var_0.weapon_purchase_looking_at)) {
      if(var_5 == var_0.weapon_purchase_looking_at) {
        return;
      } else {
        clear_weapon_looking_at(var_0);
        mark_weapon_looking_at(var_5, var_0);
      }
    } else
      mark_weapon_looking_at(var_5, var_0);
  }
}

mark_weapon_looking_at(var_0, var_1) {
  var_0 hudoutlineenableforclient(var_1, 1, 1, 0);
  var_1.weapon_purchase_looking_at = var_0;
  var_1 scripts\cp\cp_interaction::refresh_interaction();
  push_weapon_forward(var_0);
}

clear_weapon_looking_at(var_0) {
  if(isDefined(var_0.weapon_purchase_looking_at)) {
    push_weapon_back(var_0.weapon_purchase_looking_at);
    var_0.weapon_purchase_looking_at hudoutlinedisableforclient(var_0);
    var_0.weapon_purchase_looking_at = undefined;
    var_0 scripts\cp\cp_interaction::refresh_interaction();
  }
}

push_weapon_forward(var_0) {
  var_1 = 4;

  if(!isDefined(var_0.num_times_being_looked_at)) {
    var_0.num_times_being_looked_at = 0;
  }

  var_0.num_times_being_looked_at++;

  if(var_0.num_times_being_looked_at == 1) {
    var_2 = scripts\engine\utility::getStruct("afterlife_spectate_door", "script_noteworthy");
    var_3 = anglestoright(var_2.angles);
    var_0.origin = var_0.origin + var_3 * var_1;
  }
}

push_weapon_back(var_0) {
  var_0.num_times_being_looked_at--;

  if(var_0.num_times_being_looked_at == 0) {
    var_0.origin = var_0._id_C725;
  }
}

get_weapon_purchase_range_edge_x_value() {
  var_0 = 249;
  var_1 = 186;
  var_2 = scripts\engine\utility::getStruct("afterlife_spectate_door", "script_noteworthy");
  var_3 = anglestoright(var_2.angles) * -1;

  if(level.script == "cp_zmb") {
    var_4 = var_2.origin + var_3 * var_0;
  } else {
    var_4 = var_2.origin + var_3 * var_1;
  }

  return var_4[0];
}

in_weapon_purchase_range(var_0, var_1) {
  return var_0.origin[0] <= var_1;
}

create_weapon_purchase_boards() {
  var_0 = "ch_corkboard_metaltrim_4x8";
  var_1 = 96;
  var_2 = 48;
  var_3 = scripts\engine\utility::getStruct("afterlife_spectate_door", "script_noteworthy");
  var_4 = anglesToForward(var_3.angles);
  var_5 = anglestoup(var_3.angles);
  level.weapon_purchase_boards = [];
  var_6 = get_weapon_purchase_board_start_pos();

  for(var_7 = 0; var_7 < 2; var_7++) {
    for(var_8 = 0; var_8 < 4; var_8++) {
      var_9 = spawn("script_model", var_6 + var_8 * var_4 * var_1 + var_7 * var_5 * var_2);
      var_9 setModel(var_0);
      var_9.angles = var_3.angles;
      level.weapon_purchase_boards[level.weapon_purchase_boards.size] = var_9;
    }
  }
}

get_weapon_purchase_board_start_pos() {
  var_0 = scripts\engine\utility::getStruct("afterlife_spectate_door", "script_noteworthy");
  var_1 = anglesToForward(var_0.angles) * -1;
  var_2 = anglestoright(var_0.angles) * -1;
  var_3 = anglestoup(var_0.angles);
  var_4 = get_weapon_purchase_board_back_start_offset();
  var_5 = get_weapon_purchase_board_left_start_offset();
  var_6 = get_weapon_purchase_board_up_start_offset();
  return var_0.origin + var_1 * var_4 + var_2 * var_5 + var_3 * var_6;
}

get_weapon_purchase_board_up_start_offset() {
  var_0 = 10;
  var_1 = 11;

  switch (level.script) {
    case "cp_zmb":
      return var_0;
    default:
      return var_1;
  }
}

get_weapon_purchase_board_back_start_offset() {
  var_0 = 327;
  var_1 = 338;

  switch (level.script) {
    case "cp_zmb":
      return var_0;
    default:
      return var_1;
  }
}

get_weapon_purchase_board_left_start_offset() {
  var_0 = 380;
  var_1 = 317;

  switch (level.script) {
    case "cp_zmb":
      return var_0;
    default:
      return var_1;
  }
}

create_weapon_board_lights() {
  if(level.script == "cp_rave") {
    return;
  }
  wait 5;
  level.weapon_board_light_vfx = [];
  var_0 = 30;
  var_1 = 35;
  var_2 = 96;
  var_3 = 48;
  var_4 = scripts\engine\utility::getStruct("afterlife_spectate_door", "script_noteworthy");
  var_5 = anglesToForward(var_4.angles);
  var_6 = anglestoright(var_4.angles);
  var_7 = anglestoup(var_4.angles);
  var_8 = get_weapon_purchase_board_start_pos() + var_6 * var_1;

  for(var_9 = 0; var_9 < 2; var_9++) {
    for(var_10 = 0; var_10 < 4; var_10++) {
      var_11 = var_8 + var_5 * var_2 * var_10 + var_7 * var_3 * var_9;

      if(var_10 == 0) {
        var_11 = var_11 + var_5 * var_0;
      }

      var_11 = spawn("script_model", var_11);
      var_11 setModel("direct_boss_fight_origin");
      var_11 setscriptablepartstate("weapon_board_light", "on");
      level.weapon_board_light_vfx[level.weapon_board_light_vfx.size] = var_11;
    }
  }
}

create_weapon_purchase_models() {
  level endon("game_ended");
  wait 3;
  level.weapon_purchase_structs = [];
  level.weapon_purchase_models = [];
  var_0 = get_weapon_list();
  var_1 = get_weapon_model_start_pos();
  var_2 = scripts\engine\utility::getStruct("afterlife_spectate_door", "script_noteworthy");
  var_3 = anglesToForward(var_2.angles);
  var_4 = anglestoup(var_2.angles);
  var_5 = 0;

  foreach(var_7 in var_0) {
    create_weapon_purchase_model(var_7, get_weapon_model_pos(var_1, var_3, var_4, var_5), var_2.angles);
    var_5++;

    if(var_5 == 30) {
      return;
    }
    wait 0.2;
  }
}

get_weapon_list() {
  switch (level.script) {
    case "cp_disco":
      return ["iw7_kbs_zm", "iw7_m8_zm", "iw7_longshot_zm", "iw7_longshot_zm", "iw7_cheytac_zmr", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm", "iw7_sdflmg_zm", "iw7_fhr_zm", "iw7_m4_zm", "iw7_ake_zml", "iw7_vr_zm", "iw7_ar57_zm", "iw7_fmg_zm", "iw7_arclassic_zm", "iw7_sdfar_zm", "iw7_gauss_zm", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_ripper_zmr", "iw7_erad_zm", "iw7_ump45_zml", "iw7_tacburst_zm", "iw7_sdfshotty_zm", "iw7_spas_zmr", "iw7_devastator_zm", "iw7_spas_zmr", "iw7_g18_zmr"];
    default:
      return ["iw7_kbs_zm", "iw7_m8_zm", "iw7_longshot_zm", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm", "iw7_sdflmg_zm", "iw7_fhr_zm", "iw7_m4_zm", "iw7_ake_zml", "iw7_vr_zm", "iw7_ar57_zm", "iw7_fmg_zm", "iw7_arclassic_zm", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_ripper_zmr", "iw7_erad_zm", "iw7_ump45_zml", "iw7_tacburst_zm", "iw7_sdfshotty_zm", "iw7_spas_zmr", "iw7_devastator_zm", "iw7_spas_zmr", "iw7_g18_zmr"];
  }
}

get_weapon_model_pos(var_0, var_1, var_2, var_3) {
  var_4 = 55;
  var_5 = 18;
  var_6 = 6;
  var_7 = var_3 % var_6;
  var_8 = floor(var_3 / var_6);
  return var_0 + var_7 * var_4 * var_1 + var_8 * var_5 * var_2;
}

get_weapon_model_start_pos() {
  var_0 = 3;
  var_1 = 32;
  var_2 = 10;
  var_3 = scripts\engine\utility::getStruct("afterlife_spectate_door", "script_noteworthy");
  var_4 = anglesToForward(var_3.angles);
  var_5 = anglestoright(var_3.angles);
  var_6 = anglestoup(var_3.angles) * -1;
  var_7 = get_weapon_purchase_board_start_pos();
  return var_7 + var_5 * var_0 + var_4 * var_1 + var_6 * var_2;
}

create_weapon_purchase_model(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::getrawbaseweaponname(var_0);
  var_4 = "none";
  var_5 = undefined;
  var_6 = 0;
  var_7 = var_0;
  var_8 = level.players[0];
  var_5 = level.pap_2_camo;

  if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_3)) {
    var_5 = undefined;
  }

  if(isDefined(var_3)) {
    switch (var_3) {
      case "dischord":
        var_0 = "iw7_dischord_zm_pap1";
        var_5 = "camo20";
        break;
      case "facemelter":
        var_0 = "iw7_facemelter_zm_pap1";
        var_5 = "camo22";
        break;
      case "headcutter":
        var_0 = "iw7_headcutter_zm_pap1";
        var_5 = "camo21";
        break;
      case "shredder":
        var_0 = "iw7_shredder_zm_pap1";
        var_5 = "camo23";
        break;
      default:
        break;
    }
  }

  if(var_3 == "axe") {
    var_0 = "iw7_axe_zm_pap2";
    var_6 = 1;
  }

  if(var_3 == "nunchucks") {
    var_0 = "iw7_nunchucks_zm_pap2";
    var_6 = 1;
  }

  if(var_3 == "katana") {
    var_0 = "iw7_katana_zm_pap2";
    var_6 = 1;
  }

  if(var_3 == "venomx") {
    var_0 = "iw7_venomx_zm_pap2";
    var_6 = 1;
  }

  if(var_3 == "forgefreeze") {
    var_0 = "iw7_forgefreeze_zm_pap2";
    var_6 = 1;
  }

  var_4 = return_pap_attachment(var_3);

  if(isDefined(var_4) && var_4 == "replace_me") {
    var_4 = undefined;
  }

  var_9 = getweaponattachments(var_0);

  if(issubstr(var_0, "g18_z")) {
    foreach(var_11 in var_9) {
      if(issubstr(var_11, "akimbo")) {
        var_9 = scripts\engine\utility::array_remove(var_9, var_11);
      }
    }
  }

  var_13 = var_9;

  foreach(var_11 in var_13) {
    if(issubstr(var_11, "silencer") || issubstr(var_11, "arcane") || issubstr(var_11, "ark")) {
      var_13 = scripts\engine\utility::array_remove(var_13, var_11);
    }
  }

  var_0 = var_8 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_0, undefined, var_13);
  var_16 = var_8 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_0, var_4, var_13, undefined, var_5);
  var_17 = var_8 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_0, var_4, var_9, undefined, var_5);

  if(var_6) {
    var_18 = spawn("script_weapon", var_1, 0, 0, var_7);
  } else {
    var_18 = spawn("script_weapon", var_1, 0, 0, var_0);
  }

  var_18.angles = var_2;
  var_18 setmoverweapon(var_16);
  var_18._id_C725 = var_18.origin;
  var_18.weaponname = var_0;
  var_18.weapontogive = var_17;
  var_19 = spawnStruct();
  var_19.origin = var_1;
  var_19.weaponname = var_0;
  var_19._id_13C2C = var_18;
  level.weapon_purchase_structs[level.weapon_purchase_structs.size] = var_19;
  level.weapon_purchase_models[level.weapon_purchase_models.size] = var_18;
}

return_pap_attachment(var_0) {
  var_1 = undefined;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "spiked":
      case "golf":
      case "two":
      case "machete":
      case "katana":
      case "nunchucks":
        return "replace_me";
      default:
        return "pap2";
    }
  }

  return var_1;
}

create_weapon_purchase_interaction() {
  level endon("game_ended");
  var_0 = 55;
  var_1 = 78;
  var_2 = 75;
  wait 5;
  level.weapon_purchase_interactions = [];
  var_3 = get_weapon_purchase_board_start_pos();
  var_4 = scripts\engine\utility::getStruct("afterlife_spectate_door", "script_noteworthy");
  var_5 = anglesToForward(var_4.angles);
  var_6 = anglestoright(var_4.angles);
  var_7 = var_3 + var_5 * var_0 + var_6 * var_1;
  var_7 = scripts\engine\utility::drop_to_ground(var_7, 0, -200);

  for(var_8 = 0; var_8 < 5; var_8++) {
    set_up_weapon_purchase_interaction_at(var_7 + var_8 * var_5 * var_2);
  }
}

set_up_weapon_purchase_interaction_at(var_0) {
  var_1 = spawnStruct();
  var_1.name = "weapon_purchase";
  var_1.script_noteworthy = "weapon_purchase";
  var_1.origin = var_0;
  var_1.cost = 0;
  var_1.powered_on = 1;
  var_1.spend_type = undefined;
  var_1.script_parameters = "";
  var_1.requires_power = 0;
  var_1.hint_func = ::weapon_purchase_hint_func;
  var_1.activation_func = ::try_weapon_purchase;
  var_1.enabled = 1;
  var_1.disable_guided_interactions = 1;
  var_1.custom_search_dist = 400;
  level.interactions["weapon_purchase"] = var_1;
  level.weapon_purchase_interactions[level.weapon_purchase_interactions.size] = var_1;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}

weapon_purchase_hint_func(var_0, var_1) {
  if(!isDefined(var_1.weapon_purchase_looking_at)) {
    return "";
  }

  if(!var_1 hasweapon(var_1.weapon_purchase_looking_at.weapontogive)) {
    if(var_1 scripts\cp\cp_persistence::get_player_currency() < 5000) {
      return &"COOP_INTERACTIONS_NEED_MONEY";
    }

    switch (level.script) {
      case "cp_zmb":
        return &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
      case "cp_rave":
        return &"CP_RAVE_BUY_WEAPON";
      case "cp_disco":
        return &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
      case "cp_town":
        return &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
      case "cp_final":
        return &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
    }
  } else
    return &"DIRECT_BOSS_FIGHT_WEAPON_REFUND";
}

try_weapon_purchase(var_0, var_1) {
  if(!isDefined(var_1.weapon_purchase_looking_at)) {
    return;
  }
  if(var_1 hasweapon(var_1.weapon_purchase_looking_at.weapontogive)) {
    direct_boss_refund_weapon(var_1);
  } else {
    direct_boss_purchase_weapon(var_1);
  }
}

direct_boss_purchase_weapon(var_0) {
  if(var_0 scripts\cp\cp_persistence::get_player_currency() < 5000) {
    return;
  }
  var_0 scripts\cp\cp_persistence::take_player_currency(5000, 1, "weapon");
  var_1 = "iw7_fists_zm";

  if(var_0 hasweapon(var_1)) {
    var_0 takeweapon(var_1);
  }

  var_2 = var_0.weapon_purchase_looking_at.weapontogive;

  if(var_0 scripts\cp\cp_weapon::has_weapon_variation(var_2)) {
    var_3 = scripts\cp\utility::getrawbaseweaponname(var_2);

    foreach(var_5 in var_0 getweaponslistall()) {
      var_6 = scripts\cp\utility::getrawbaseweaponname(var_5);

      if(var_3 == var_6) {
        var_0 takeweapon(var_5);
      }
    }
  }

  if(scripts\cp\zombies\zombies_weapons::should_take_players_current_weapon(var_0)) {
    var_8 = var_0 getcurrentweapon();
    var_9 = scripts\cp\utility::getrawbaseweaponname(var_8);
    var_0 takeweapon(var_8);
  }

  self notify("weapon_taken");
  var_2 = var_0 scripts\cp\utility::_giveweapon(var_2, undefined, undefined, 0);
  var_0 givemaxammo(var_2);
  var_10 = var_0 getweaponslistprimaries();

  foreach(var_5 in var_10) {
    if(issubstr(var_5, var_2)) {
      if(scripts\cp\utility::isaltmodeweapon(var_5)) {
        var_3 = getweaponbasename(var_5);

        if(isDefined(level.alt_mode_weapons_allowed) && scripts\engine\utility::array_contains(level.alt_mode_weapons_allowed, var_3)) {
          var_12 = "alt_" + var_2;
          break;
        }
      }
    }
  }

  var_0 switchtoweapon(var_2);
  var_3 = scripts\cp\utility::getrawbaseweaponname(var_2);

  if(!isDefined(var_0.pap[var_3])) {
    var_0.pap[var_3] = spawnStruct();
  }

  var_0.pap[var_3].lvl = 3;
  var_0 notify("weapon_level_changed");
}

direct_boss_refund_weapon(var_0) {
  var_0 scripts\cp\cp_persistence::give_player_currency(5000);
  var_1 = var_0.weapon_purchase_looking_at.weapontogive;
  var_0 takeweapon(var_1);
  var_2 = var_0 directbossgetvalidtakeweapon();

  if(var_2 != "super_default_zm") {
    var_0 switchtoweapon(var_2);
  }
}

directbossgetvalidtakeweapon() {
  var_0 = self getcurrentweapon();
  var_1 = 0;
  var_2 = level.additional_laststand_weapon_exclusion;

  if(var_0 == "none") {
    var_1 = 1;
  } else if(scripts\engine\utility::array_contains(var_2, var_0)) {
    var_1 = 1;
  } else if(scripts\engine\utility::array_contains(var_2, getweaponbasename(var_0))) {
    var_1 = 1;
  } else if(scripts\cp\utility::is_melee_weapon(var_0, 1)) {
    var_1 = 1;
  }

  if(isDefined(self.last_valid_weapon) && self hasweapon(self.last_valid_weapon) && var_1) {
    var_0 = self.last_valid_weapon;

    if(var_0 == "none") {
      var_1 = 1;
    } else if(scripts\engine\utility::array_contains(var_2, var_0)) {
      var_1 = 1;
    } else if(scripts\engine\utility::array_contains(var_2, getweaponbasename(var_0))) {
      var_1 = 1;
    } else if(scripts\cp\utility::is_melee_weapon(var_0, 1)) {
      var_1 = 1;
    } else {
      var_1 = 0;
    }
  }

  if(var_1) {
    var_3 = self getweaponslistall();

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(var_3[var_4] == "none") {
        continue;
      } else if(scripts\engine\utility::array_contains(var_2, var_3[var_4])) {
        continue;
      } else if(scripts\engine\utility::array_contains(var_2, getweaponbasename(var_3[var_4]))) {
        continue;
      } else if(scripts\cp\utility::is_melee_weapon(var_3[var_4], 1)) {
        continue;
      } else if(var_3[var_4] == "super_default_zm") {
        continue;
      } else if(var_3[var_4] == "frag_grenade_zm") {
        continue;
      } else {
        var_1 = 0;
        var_0 = var_3[var_4];
        break;
      }
    }
  }

  return var_0;
}