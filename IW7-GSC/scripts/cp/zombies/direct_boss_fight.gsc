/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\direct_boss_fight.gsc
****************************************************/

init() {
  check_direct_boss_fight();
  level thread init_boss_fight_data();
  if(should_directly_go_to_boss_fight()) {
    level.disable_start_spawn_on_navmesh = 1;
    level.bosstimer = 0;
    level.getspawnpoint = ::get_direct_to_boss_spawn_point;
    level.calculate_time_survived_func = ::get_direct_boss_fight_time_survived;
    level.disableplayerdamage = 1;
    level.disable_consumables = 1;
    set_up_perk_purchase_board();
    set_up_weapon_purchase_board();
    level thread create_activation_interaction();
    level thread disable_things_in_afterlife_arcade();
    level thread level_specific_setup();
    level thread run_pre_match_timer();
    setnojiptime(1);
    setnojipscore(1);
  }
}

init_boss_fight_data() {
  wait(15);
  scripts\cp\zombies\zombie_analytics::log_using_boss_fight_playlist(0);
  scripts\cp\zombies\zombie_analytics::log_boss_fight_result(0);
  if(should_directly_go_to_boss_fight()) {
    scripts\cp\zombies\zombie_analytics::log_using_boss_fight_playlist(1);
  }
}

check_direct_boss_fight() {
  if(direct_boss_fight_activated()) {
    activate_direct_to_boss_fight();
  }
}

should_directly_go_to_boss_fight() {
  return scripts\engine\utility::istrue(level.direct_to_boss_fight);
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
        var_6.var_13C2C hide();
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
        var_5.var_13C2C show();
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

      break;

    case "cp_rave":
      if(getdvarint("scr_direct_to_super_slasher", 0) != 0) {
        return 1;
      } else {
        return 0;
      }

      break;

    case "cp_disco":
      if(getdvarint("scr_direct_to_rat_king", 0) != 0) {
        return 1;
      } else {
        return 0;
      }

      break;

    case "cp_town":
      if(getdvarint("scr_direct_to_crab_boss", 0) != 0) {
        return 1;
      } else {
        return 0;
      }

      break;

    case "cp_final":
      if(getdvarint("scr_direct_to_rhino_fight", 0) != 0 || getdvarint("scr_direct_to_meph_fight", 0) != 0) {
        return 1;
      } else {
        return 0;
      }

      break;

    default:
      return 0;
  }
}

is_meph_fight() {
  return getdvarint("scr_direct_to_meph_fight", 0) != 0;
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

  if(isDefined(level.weapon_board_light_vfx)) {
    foreach(var_7 in level.weapon_board_light_vfx) {
      var_7 delete();
    }
  }

  foreach(var_10 in level.weapon_purchase_models) {
    var_10 delete();
  }
}

clean_up_activation_interaction() {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.boss_fight_activation_interaction);
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
  var_5.var_C71F = var_5.angles;
  var_5.var_C725 = var_5.origin;
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
  var_1 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
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
  wait(5);
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
  }

  var_5 = sortbydistance(var_1, var_0 getEye())[0];
  if(isDefined(var_0.candy_box_looking_at)) {
    if(var_5 == var_0.candy_box_looking_at) {
      return;
    }

    clear_candy_box_looking_at(var_0);
    mark_candy_box_looking_at(var_5, var_0);
    return;
  }

  mark_candy_box_looking_at(var_5, var_0);
}

mark_candy_box_looking_at(var_0, var_1) {
  var_0 hudoutlineenableforclient(var_1, 3, 1, 0);
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
    var_0.origin = var_0.var_C725;
  }
}

in_perk_purchase_range(var_0, var_1) {
  return distance2dsquared(var_0.origin, var_1.origin) <= 8100;
}

create_perk_purchase_interaction() {
  level endon("game_ended");
  wait(5);
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

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return "";
  }

  var_2 = var_1.candy_box_looking_at.perk;
  if(var_1 scripts\cp\utility::has_zombie_perk(var_2)) {
    return &"COOP_PERK_MACHINES_REMOVE_PERK";
  }

  if(isDefined(var_1.zombies_perks) && var_1.zombies_perks.size > 20 && !scripts\engine\utility::istrue(var_1.have_gns_perk)) {
    return &"COOP_PERK_MACHINES_PERK_SLOTS_FULL";
  }

  var_3 = get_perk_cost(var_2);
  if(var_1 scripts\cp\cp_persistence::get_player_currency() < var_3) {
    return &"COOP_INTERACTIONS_NEED_MONEY";
  }

  if(var_2 == "perk_machine_revive" && scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return &"COOP_PERK_MACHINES_SELF_REVIVE";
  }

  return level.interaction_hintstrings[var_2];
}

try_perk_purchase(var_0, var_1) {
  if(!isDefined(var_1.candy_box_looking_at)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  var_1 thread perk_purchase_internal(var_1);
}

perk_purchase_internal(var_0) {
  var_0 endon("disconnect");
  if(is_meph_fight() && !scripts\engine\utility::istrue(var_0.have_permanent_perks)) {
    var_0.have_permanent_perks = 1;
  }

  var_1 = var_0.candy_box_looking_at.perk;
  var_2 = get_perk_cost(var_1);
  if(var_0 scripts\cp\utility::has_zombie_perk(var_1)) {
    if(soundexists("perk_machine_remove_perk")) {
      var_0 playlocalsound("perk_machine_remove_perk");
    }

    if(!isDefined(self.current_perk_list)) {
      self.current_perk_list = [];
    }

    self.current_perk_list = scripts\engine\utility::array_remove(self.current_perk_list, var_1);
    var_0 scripts\cp\zombies\zombies_perk_machines::take_zombies_perk(var_1);
    var_0 scripts\cp\cp_persistence::give_player_currency(var_2);
    var_0 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(isDefined(var_0.zombies_perks) && var_0.zombies_perks.size > 20 && !scripts\engine\utility::istrue(var_0.have_gns_perk)) {
    return;
  }

  var_2 = get_perk_cost(var_0.candy_box_looking_at.perk);
  if(var_0 scripts\cp\cp_persistence::get_player_currency() < var_2) {
    return;
  }

  var_0 scripts\cp\cp_persistence::take_player_currency(var_2, 1, "perk");
  made_direct_boss_fight_purchase(var_0);
  if(!isDefined(self.current_perk_list)) {
    self.current_perk_list = [];
  }

  self.current_perk_list = scripts\engine\utility::add_to_array(self.current_perk_list, var_1);
  var_0 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_1, 0);
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
    case "perk_machine_revive":
      if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
        return 500;
      } else {
        return 1500;
      }

      break;

    case "perk_machine_deadeye":
    case "perk_machine_zap":
    case "perk_machine_fwoosh":
    case "perk_machine_boom":
    case "perk_machine_change":
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

  wait(5);
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
  wait(5);
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
      var_1[var_1.size] = var_3.var_13C2C;
    }
  }

  if(var_1.size == 0) {
    clear_weapon_looking_at(var_0);
    return;
  }

  var_5 = sortbydistance(var_1, var_0 getEye())[0];
  if(isDefined(var_0.weapon_purchase_looking_at)) {
    if(var_5 == var_0.weapon_purchase_looking_at) {
      return;
    }

    clear_weapon_looking_at(var_0);
    mark_weapon_looking_at(var_5, var_0);
    return;
  }

  mark_weapon_looking_at(var_5, var_0);
}

mark_weapon_looking_at(var_0, var_1) {
  var_0 hudoutlineenableforclient(var_1, 3, 1, 0);
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
    var_2 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
    var_3 = anglestoright(var_2.angles);
    var_0.origin = var_0.origin + var_3 * var_1;
  }
}

push_weapon_back(var_0) {
  var_0.num_times_being_looked_at--;
  if(var_0.num_times_being_looked_at == 0) {
    var_0.origin = var_0.var_C725;
  }
}

get_weapon_purchase_range_edge_x_value() {
  var_0 = 249;
  var_1 = 186;
  var_2 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_3 = anglestoright(var_2.angles) * -1;
  if(level.script == "cp_zmb") {
    var_4 = var_2.origin + var_3 * var_0;
  } else {
    var_4 = var_3.origin + var_4 * var_2;
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
  var_3 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
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
  var_0 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
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

  wait(5);
  level.weapon_board_light_vfx = [];
  var_0 = 30;
  var_1 = 35;
  var_2 = 96;
  var_3 = 48;
  var_4 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
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
  wait(3);
  level.weapon_purchase_structs = [];
  level.weapon_purchase_models = [];
  var_0 = get_weapon_list();
  var_1 = get_weapon_model_start_pos();
  var_2 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_3 = anglesToForward(var_2.angles);
  var_4 = anglestoup(var_2.angles);
  var_5 = 0;
  foreach(var_7 in var_0) {
    create_weapon_purchase_model(var_7, get_weapon_model_pos(var_1, var_3, var_4, var_5), var_2.angles);
    var_5++;
    if(var_5 == 30) {
      return;
    }

    wait(0.2);
  }
}

get_weapon_list() {
  switch (level.script) {
    case "cp_zmb":
      return ["iw7_kbs_zm", "iw7_dischord_zm", "iw7_facemelter_zm", "iw7_headcutter_zm", "iw7_shredder_zm", "iw7_m8_zm", "iw7_longshot_zm", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm", "iw7_sdflmg_zm", "iw7_fhr_zm", "iw7_m4_zm", "iw7_ake_zml", "iw7_vr_zm", "iw7_ar57_zm", "iw7_fmg_zm", "iw7_arclassic_zm", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_ripper_zmr", "iw7_erad_zm", "iw7_ump45_zml", "iw7_tacburst_zm", "iw7_ump45c_zm", "iw7_sdfshotty_zm", "iw7_spas_zmr", "iw7_devastator_zm", "iw7_g18_zmr"];

    case "cp_rave":
      return ["iw7_kbs_zm", "iw7_harpoon1_zm", "iw7_harpoon2_zm", "iw7_harpoon3_zm+akimbo", "iw7_harpoon4_zm", "iw7_m8_zm", "iw7_longshot_zm", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm", "iw7_sdflmg_zm", "iw7_fhr_zm", "iw7_m4_zm", "iw7_ake_zml", "iw7_vr_zm", "iw7_ar57_zm", "iw7_fmg_zm", "iw7_arclassic_zm", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_ripper_zmr", "iw7_erad_zm", "iw7_ump45_zml", "iw7_tacburst_zm", "iw7_ump45c_zm", "iw7_sdfshotty_zm", "iw7_spas_zmr", "iw7_devastator_zm", "iw7_g18_zmr"];

    case "cp_disco":
      return ["iw7_katana_zm_pap1", "crane", "snake", "dragon", "tiger", "iw7_nunchucks_zm_pap2", "iw7_longshot_zm", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm", "iw7_sdflmg_zm", "iw7_fhr_zm", "iw7_m4_zm", "iw7_ake_zml", "iw7_vr_zm", "iw7_ar57_zm", "iw7_fmg_zm", "iw7_arclassic_zm", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_ripper_zmr", "iw7_erad_zm", "iw7_ump45_zml", "iw7_tacburst_zm", "iw7_ump45c_zm", "iw7_sdfshotty_zm", "iw7_spas_zmr", "iw7_devastator_zm", "iw7_g18_zmr"];

    case "cp_town":
      return ["iw7_kbs_zm", "iw7_longshot_zm", "iw7_cutie_zm+cutiecrank+cutiegrip+cutieplunger", "iw7_gauss_zm", "iw7_cheytac_zmr", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm", "iw7_fhr_zm", "iw7_m4_zm", "iw7_vr_zm", "iw7_ar57_zm", "iw7_fmg_zm", "iw7_arclassic_zm", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_ripper_zmr", "iw7_erad_zm", "iw7_ump45_zml", "iw7_tacburst_zm", "iw7_sdfshotty_zm", "iw7_devastator_zm", "iw7_g18_zmr"];

    case "cp_final":
      return ["iw7_kbs_zm", "iw7_longshot_zm", "iw7_venomx_zm_pap2", "iw7_gauss_zm", "iw7_cheytac_zmr", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm", "iw7_fhr_zm", "iw7_m4_zm", "iw7_vr_zm", "iw7_ar57_zm", "iw7_fmg_zm", "iw7_arclassic_zm", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_ripper_zmr", "iw7_erad_zm", "iw7_ump45_zml", "iw7_tacburst_zm", "iw7_sdfshotty_zm", "iw7_devastator_zm", "iw7_g18_zmr"];
  }
}

get_weapon_model_pos(var_0, var_1, var_2, var_3) {
  var_4 = 55;
  var_5 = 6;
  var_6 = var_3 % var_5;
  var_7 = floor(var_3 / var_5);
  return var_0 + var_6 * var_4 * var_1 + var_7 * get_vertical_space() * var_2;
}

get_vertical_space() {
  switch (level.script) {
    case "cp_final":
    case "cp_town":
      return 22;

    default:
      return 18;
  }
}

get_weapon_model_start_pos() {
  var_0 = 3;
  var_1 = 32;
  var_2 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_3 = anglesToForward(var_2.angles);
  var_4 = anglestoright(var_2.angles);
  var_5 = anglestoup(var_2.angles) * -1;
  var_6 = get_start_down_offset();
  var_7 = get_weapon_purchase_board_start_pos();
  return var_7 + var_4 * var_0 + var_3 * var_1 + var_5 * var_6;
}

get_start_down_offset() {
  switch (level.script) {
    case "cp_final":
    case "cp_town":
      return 7;

    default:
      return 10;
  }
}

create_weapon_purchase_model(var_0, var_1, var_2) {
  if(is_kung_fu(var_0)) {
    var_3 = spawn("script_model", var_1);
    var_3 setModel(get_gourd_model(var_0));
    var_4 = vectortoangles(anglestoright(var_2) * -1);
    var_3.angles = var_4;
    var_3.var_C725 = var_3.origin;
    var_3.var_39C = var_0;
    var_3.weapontogive = var_0;
  } else {
    var_5 = scripts\cp\utility::getrawbaseweaponname(var_1);
    var_6 = "none";
    var_7 = undefined;
    var_8 = 0;
    var_9 = var_0;
    var_10 = level.players[0];
    var_7 = level.pap_2_camo;
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_5)) {
      var_7 = undefined;
    }

    if(isDefined(var_5)) {
      switch (var_5) {
        case "dischord":
          var_0 = "iw7_dischord_zm";
          var_7 = undefined;
          break;

        case "facemelter":
          var_0 = "iw7_facemelter_zm";
          var_7 = undefined;
          break;

        case "headcutter":
          var_0 = "iw7_headcutter_zm";
          var_7 = undefined;
          break;

        case "shredder":
          var_0 = "iw7_shredder_zm";
          var_7 = undefined;
          break;

        case "harpoon1":
          var_0 = "iw7_harpoon1_zm";
          var_7 = undefined;
          break;

        case "harpoon2":
          var_0 = "iw7_harpoon2_zm";
          var_7 = undefined;
          break;

        case "harpoon3":
          var_0 = "iw7_harpoon3_zm+akimbo";
          var_7 = undefined;
          break;

        case "harpoon4":
          var_0 = "iw7_harpoon4_zm";
          var_7 = undefined;
          break;

        default:
          break;
      }
    }

    if(var_5 == "axe") {
      var_0 = "iw7_axe_zm_pap2";
      var_8 = 1;
    }

    if(var_5 == "nunchucks") {
      var_0 = "iw7_nunchucks_zm_pap2";
      var_8 = 1;
    }

    if(var_5 == "katana") {
      var_0 = "iw7_katana_zm_pap1";
      var_7 = "camo222";
      var_11 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
      var_12 = anglesToForward(var_11.angles);
      var_13 = var_12 * -1;
      var_1 = var_1 + var_13 * 10;
      var_8 = 1;
    }

    if(var_5 == "venomx") {
      var_0 = "iw7_venomx_zm_pap2";
      var_8 = 1;
    }

    if(var_5 == "forgefreeze") {
      var_0 = "iw7_forgefreeze_zm_pap2";
      var_8 = 1;
    }

    if(var_5 == "cutie") {
      var_0 = "iw7_cutie_zm+cutiecrank+cutiegrip+cutieplunger";
      var_7 = undefined;
      var_8 = 1;
    }

    var_6 = return_pap_attachment(var_5);
    if(isDefined(var_6) && var_6 == "replace_me") {
      var_6 = undefined;
    }

    var_14 = getweaponattachments(var_0);
    if(issubstr(var_0, "g18_z")) {
      foreach(var_10 in var_14) {
        if(issubstr(var_10, "akimbo")) {
          var_14 = scripts\engine\utility::array_remove(var_14, var_10);
        }
      }
    }

    var_12 = var_14;
    foreach(var_10 in var_12) {
      if(issubstr(var_10, "silencer") || issubstr(var_10, "arcane") || issubstr(var_10, "ark")) {
        var_12 = scripts\engine\utility::array_remove(var_12, var_10);
      }
    }

    if(is_wonder_weapon(var_0)) {
      var_15 = var_0;
      var_16 = var_0;
      if(isDefined(var_7)) {
        var_15 = var_15 + "+" + var_7;
        var_16 = var_16 + "+" + var_7;
      }
    } else {
      var_2 = var_12 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_2, undefined, var_10);
      var_15 = var_12 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_2, var_8, var_10, undefined, var_9);
      var_16 = var_14 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_1, var_7, var_12, undefined, var_8);
    }

    if(var_8) {
      var_3 = spawn("script_weapon", var_1, 0, 0, var_9);
    } else {
      var_3 = spawn("script_weapon", var_1, 0, 0, var_0);
    }

    var_3.angles = get_weapon_model_angles(var_0, var_2);
    var_3 setmoverweapon(var_15);
    var_3.var_C725 = var_3.origin;
    var_3.var_39C = var_0;
    var_3.weapontogive = var_16;
    var_3.camotogive = var_7;
  }

  var_17 = spawnStruct();
  var_17.origin = var_1;
  var_17.var_39C = var_0;
  var_17.var_13C2C = var_3;
  level.weapon_purchase_structs[level.weapon_purchase_structs.size] = var_17;
  level.weapon_purchase_models[level.weapon_purchase_models.size] = var_3;
}

get_weapon_model_angles(var_0, var_1) {
  if(issubstr(var_0, "nunchuck")) {
    return (0, 0, 90);
  }

  if(issubstr(var_0, "katana")) {
    return (90, 0, -90);
  }

  return var_1;
}

is_kung_fu(var_0) {
  switch (var_0) {
    case "tiger":
    case "snake":
    case "crane":
    case "dragon":
      return 1;

    default:
      return 0;
  }
}

get_kung_fu_string(var_0) {
  switch (var_0) {
    case "snake":
      return &"CP_DISCO_CHALLENGES_SNAKE";

    case "tiger":
      return &"CP_DISCO_CHALLENGES_TIGER";

    case "crane":
      return &"CP_DISCO_CHALLENGES_CRANE";

    case "dragon":
      return &"CP_DISCO_CHALLENGES_DRAGON";
  }
}

get_gourd_model(var_0) {
  switch (var_0) {
    case "crane":
      return "weapon_zmb_gourd_crane_wm";

    case "snake":
      return "weapon_zmb_gourd_snake_wm";

    case "dragon":
      return "weapon_zmb_gourd_dragon_wm";

    case "tiger":
      return "weapon_zmb_gourd_tiger_wm";
  }
}

is_wonder_weapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "iw7_cutie_zm+cutiecrank+cutiegrip+cutieplunger":
    case "iw7_harpoon4_zm":
    case "iw7_harpoon3_zm+akimbo":
    case "iw7_harpoon2_zm":
    case "iw7_harpoon1_zm":
    case "iw7_venomx_zm_pap2":
    case "iw7_headcutter_zm":
    case "iw7_facemelter_zm":
    case "iw7_dischord_zm":
    case "iw7_shredder_zm":
      return 1;

    default:
      return 0;
  }
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
  wait(5);
  level.weapon_purchase_interactions = [];
  var_3 = get_weapon_purchase_board_start_pos();
  var_4 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
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

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return "";
  }

  if(is_kung_fu(var_1.weapon_purchase_looking_at.var_39C)) {
    var_2 = [[level.direct_boss_get_kung_fu_func]](var_1);
    if(isDefined(var_2) && var_2 == var_1.weapon_purchase_looking_at.var_39C) {
      return "";
    }

    return &"CP_DISCO_CHALLENGES_DRINK_GOURD";
  }

  if(!have_weapon(var_1, var_1.weapon_purchase_looking_at.weapontogive)) {
    if(var_1 scripts\cp\cp_persistence::get_player_currency() < get_weapon_cost(var_1.weapon_purchase_looking_at.weapontogive)) {
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

    return;
  }

  return &"DIRECT_BOSS_FIGHT_WEAPON_REFUND";
}

have_weapon(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::getbaseweaponname(var_1);
  if(isDefined(var_0.default_starting_pistol) && getweaponbasename(var_0.default_starting_pistol) == var_3) {
    if(!scripts\engine\utility::istrue(var_0.has_replaced_starting_pistol)) {
      return 0;
    }
  }

  var_4 = var_0 getweaponslistall();
  foreach(var_6 in var_4) {
    if(var_3 == scripts\cp\utility::getbaseweaponname(var_6)) {
      return 1;
    }
  }

  return 0;
}

try_weapon_purchase(var_0, var_1) {
  if(!isDefined(var_1.weapon_purchase_looking_at)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return "";
  }

  if(is_kung_fu(var_1.weapon_purchase_looking_at.weapontogive)) {
    var_2 = [[level.direct_boss_get_kung_fu_func]](var_1);
    if(isDefined(var_2) && var_2 == var_1.weapon_purchase_looking_at.var_39C) {
      return;
    }

    [[level.direct_boss_give_kung_fu_func]](var_1.weapon_purchase_looking_at.weapontogive, var_1);
    return;
  }

  if(have_weapon(var_1, var_1.weapon_purchase_looking_at.weapontogive, 1)) {
    direct_boss_refund_weapon(var_1);
    return;
  }

  direct_boss_purchase_weapon(var_1);
}

direct_boss_purchase_weapon(var_0) {
  if(var_0 scripts\cp\cp_persistence::get_player_currency() < get_weapon_cost(var_0.weapon_purchase_looking_at.weapontogive)) {
    return;
  }

  made_direct_boss_fight_purchase(var_0);
  var_0 scripts\cp\cp_persistence::take_player_currency(get_weapon_cost(var_0.weapon_purchase_looking_at.weapontogive), 1, "weapon");
  take_fists_weapon(var_0);
  var_1 = var_0.weapon_purchase_looking_at.weapontogive;
  if(var_0 scripts\cp\cp_weapon::has_weapon_variation(var_1)) {
    var_2 = scripts\cp\utility::getrawbaseweaponname(var_1);
    foreach(var_4 in var_0 getweaponslistall()) {
      var_5 = scripts\cp\utility::getrawbaseweaponname(var_4);
      if(var_2 == var_5) {
        var_0 takeweapon(var_4);
      }
    }
  }

  if(scripts\cp\zombies\zombies_weapons::should_take_players_current_weapon(var_0)) {
    var_7 = var_0 getcurrentweapon();
    var_8 = scripts\cp\utility::getrawbaseweaponname(var_7);
    var_0 takeweapon(var_7);
  }

  var_0 notify("weapon_taken");
  if(isDefined(var_0.default_starting_pistol) && getweaponbasename(var_0.default_starting_pistol) == getweaponbasename(var_1)) {
    if(!scripts\engine\utility::istrue(var_0.has_replaced_starting_pistol)) {
      var_0.has_replaced_starting_pistol = 1;
    }
  }

  var_1 = apply_weapon_build_kit_options(var_1, var_0.weapon_purchase_looking_at.camotogive, var_0);
  var_1 = var_0 scripts\cp\utility::_giveweapon(var_1, undefined, undefined, 0);
  var_0 givemaxammo(var_1);
  var_9 = var_0 getweaponslistprimaries();
  foreach(var_4 in var_9) {
    if(issubstr(var_4, var_1)) {
      if(scripts\cp\utility::isaltmodeweapon(var_4)) {
        var_2 = getweaponbasename(var_4);
        if(isDefined(level.mode_weapons_allowed) && scripts\engine\utility::array_contains(level.mode_weapons_allowed, var_2)) {
          var_11 = "alt_" + var_1;
          break;
        }
      }
    }
  }

  var_0 switchtoweapon(var_1);
  var_2 = scripts\cp\utility::getrawbaseweaponname(var_1);
  if(!isDefined(var_0.pap[var_2])) {
    var_0.pap[var_2] = spawnStruct();
  }

  var_0.pap[var_2].lvl = 3;
  var_0 notify("weapon_level_changed");
}

take_fists_weapon(var_0) {
  foreach(var_2 in var_0 getweaponslistall()) {
    if(issubstr(var_2, "iw7_fists")) {
      var_0 takeweapon(var_2);
    }
  }
}

apply_weapon_build_kit_options(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::getrawbaseweaponname(var_0);
  if(isDefined(var_2.weapon_build_models[var_3])) {
    var_4 = var_2.weapon_build_models[var_3];
    var_5 = getweaponattachments(var_4);
    var_6 = scripts\engine\utility::array_combine(["pap2"], var_5);
    var_0 = var_2 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(getweaponbasename(var_0), undefined, var_6, 1, var_1);
  }

  return var_0;
}

weapon_to_take_for_refund(var_0) {
  var_1 = scripts\cp\utility::getrawbaseweaponname(var_0.weapon_purchase_looking_at.weapontogive);
  var_2 = var_0 getweaponslistall();
  foreach(var_4 in var_2) {
    if(issubstr(var_4, var_1)) {
      return var_4;
    }
  }
}

direct_boss_refund_weapon(var_0) {
  var_1 = weapon_to_take_for_refund(var_0);
  var_0 takeweapon(var_1);
  if(should_issue_refund(var_0, var_1)) {
    var_0 scripts\cp\cp_persistence::give_player_currency(get_weapon_cost(var_0.weapon_purchase_looking_at.weapontogive));
  }

  var_2 = var_0 directbossgetvalidtakeweapon();
  if(var_2 != "super_default_zm") {
    var_0 switchtoweapon(var_2);
  }
}

should_issue_refund(var_0, var_1) {
  var_2 = getweaponbasename(var_1);
  if(isDefined(var_0.default_starting_pistol) && getweaponbasename(var_0.default_starting_pistol) == var_2) {
    if(!scripts\engine\utility::istrue(var_0.has_replaced_starting_pistol)) {
      return 0;
    }

    return 1;
  }

  return 1;
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

create_activation_interaction() {
  level endon("game_ended");
  wait(5);
  var_0 = 130;
  var_1 = 125;
  var_2 = 165;
  var_3 = 228;
  var_4 = scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy");
  var_5 = anglesToForward(var_4.angles);
  var_6 = anglestoright(var_4.angles);
  if(level.script == "cp_zmb") {
    var_7 = var_4.origin + var_5 * var_0 + var_6 * var_2;
  } else {
    var_7 = var_5.origin + var_6 * var_2 + var_7 * var_4;
  }

  var_7 = scripts\engine\utility::drop_to_ground(var_7, 0, -300);
  set_up_boss_fight_activation_interaction_at(var_7);
}

set_up_boss_fight_activation_interaction_at(var_0) {
  var_1 = 100;
  var_2 = spawnStruct();
  var_2.name = "boss_fight_activation";
  var_2.script_noteworthy = "boss_fight_activation";
  var_2.origin = var_0;
  var_2.cost = 0;
  var_2.powered_on = 1;
  var_2.spend_type = undefined;
  var_2.script_parameters = "";
  var_2.requires_power = 0;
  var_2.hint_func = ::activate_boss_fight_hint_func;
  var_2.activation_func = ::try_activate_boss_fight;
  var_2.enabled = 1;
  var_2.disable_guided_interactions = 0;
  var_2.custom_search_dist = var_1;
  level.interactions["boss_fight_activation"] = var_2;
  level.boss_fight_activation_interaction = var_2;
  level thread wait_to_activate(var_0, var_2);
}

activate_boss_fight_hint_func(var_0, var_1) {
  if(scripts\engine\utility::flag_exist("boss_fight_ready_soon") && scripts\engine\utility::flag("boss_fight_ready_soon")) {
    return &"CP_TOWN_BOSS_FIGHT_READY_SOON";
  }

  return &"DIRECT_BOSS_FIGHT_ACTIVATION";
}

try_activate_boss_fight(var_0, var_1) {}

made_direct_boss_fight_purchase(var_0) {
  var_0.made_direct_boss_fight_purchase = 1;
  foreach(var_2 in level.players) {
    if(!scripts\engine\utility::istrue(var_2.made_direct_boss_fight_purchase)) {
      return;
    }
  }

  level notify("start_boss_fight_activation");
}

wait_to_activate(var_0, var_1) {
  level endon("game_ended");
  level waittill("start_boss_fight_activation");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  if(isDefined(level.direct_boss_fight_flag_wait)) {
    scripts\engine\utility::flag_init("boss_fight_ready_soon");
    scripts\engine\utility::flag_set("boss_fight_ready_soon");
    scripts\engine\utility::flag_wait(level.direct_boss_fight_flag_wait);
    scripts\engine\utility::flag_clear("boss_fight_ready_soon");
    foreach(var_3 in level.players) {
      var_3 scripts\cp\cp_interaction::refresh_interaction();
    }
  }

  level thread wait_all_players_press_use(var_0);
}

wait_all_players_press_use(var_0) {
  level endon("game_ended");
  level endon("start_direct_boss_fight");
  var_1 = 13225;
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

      if(scripts\engine\utility::istrue(var_4.isusingsupercard)) {
        var_2 = 0;
        break;
      }

      if(distance2dsquared(var_4.origin, var_0) > var_1) {
        var_2 = 0;
        break;
      }

      if(!var_4 useButtonPressed()) {
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

        if(scripts\engine\utility::istrue(var_4.isusingsupercard)) {
          var_2 = 0;
          break;
        }

        if(distance2dsquared(var_4.origin, var_0) > var_1) {
          var_2 = 0;
          break;
        }

        if(!var_4 useButtonPressed()) {
          var_2 = 0;
          break;
        }
      }
    }

    if(var_2) {
      level thread start_direct_boss_fight();
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

start_direct_boss_fight() {
  level notify("start_direct_boss_fight");
  level.disableplayerdamage = undefined;
  level.disable_consumables = undefined;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.boss_fight_activation_interaction);
  level thread delay_restore_afterlife_arcade();
  if(isDefined(level.start_direct_boss_fight_func)) {
    level thread[[level.start_direct_boss_fight_func]]();
  }

  teleport_players_to_boss_fight();
}

delay_restore_afterlife_arcade() {
  level endon("game_ended");
  wait(1);
  enable_things_in_afterlife_arcade();
  clean_up_perk_purchase_board();
  clean_up_weapon_purchase_board();
}

teleport_players_to_boss_fight() {
  var_0 = get_start_look_at_loc();
  var_1 = get_start_stand_loc_list();
  foreach(var_5, var_3 in level.players) {
    var_4 = spawnStruct();
    var_4.origin = var_1[var_5];
    var_4.angles = vectortoangles(var_0 - var_1[var_5]);
    level thread get_players_best_times();
    level thread move_player_through_portal_tube(var_3, [var_4]);
  }
}

get_start_look_at_loc() {
  switch (level.script) {
    case "cp_zmb":
      return (652, 795, 115);

    case "cp_rave":
      return (-5365, 4834, 34);

    case "cp_disco":
      return (-628.8, 1422.4, 178);

    case "cp_town":
      return (3035, 2829, -141);

    case "cp_final":
      if(is_meph_fight()) {
        return (-13314, -337, -48);
      }
      return (2874, 2424, -116);
  }
}

get_start_stand_loc_list() {
  switch (level.script) {
    case "cp_zmb":
      return [(918, 1411, 11), (768, 1414, 11), (501, 1390, 11), (358, 1416, 11)];

    case "cp_rave":
      return [(-4037.4, 4094.5, -83.1), (-3968.5, 4113.5, -95.6), (-4089.8, 4176.5, -45.7), (-4020.8, 4195.6, -58.2)];

    case "cp_disco":
      return [(-1082, 1638.6, 170), (-600.2, 1834.6, 170), (-793.3, 1863.8, 178), (-962.8, 1770.4, 178)];

    case "cp_town":
      return [(1654, -1472, 304), (1812, -1366, 239), (1914, -1174, 187), (2185, -1170, 185)];

    case "cp_final":
      if(is_meph_fight()) {
        return [(-12819, -327, -106), (-12822, -397, -106), (-12769, -287, -106), (-12776, -361, -106)];
      }
      return [(2946, 2918, -68), (2846, 2918, -68), (2946, 2818, -68), (2846, 2818, -68)];
  }
}

level_specific_setup() {
  level endon("game_ended");
  wait(10);
  open_sesame();
  disable_weapon_upgrade_interaction();
  if(isDefined(level.setup_direct_boss_fight_func)) {
    level thread[[level.setup_direct_boss_fight_func]]();
  }
}

disable_weapon_upgrade_interaction() {
  var_0 = scripts\engine\utility::getStructArray("interaction", "targetname");
  var_1 = [];
  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "weapon_upgrade") {
      var_1[var_1.size] = var_3;
    }
  }

  foreach(var_6 in var_1) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_6);
  }
}

open_sesame() {
  if(isDefined(level.open_sesame_func)) {
    thread[[level.open_sesame_func]]();
  } else {
    if(scripts\engine\utility::istrue(level.open_sesame)) {
      level.open_sesame = undefined;
      return;
    } else {
      level.open_sesame = 1;
    }

    level start_all_generators();
    var_0 = getEntArray("door_buy", "targetname");
    foreach(var_2 in var_0) {
      var_2 notify("trigger", "open_sesame");
      wait(0.1);
    }

    var_4 = getEntArray("chi_door", "targetname");
    foreach(var_2 in var_4) {
      var_2.physics_capsulecast notify("damage", undefined, "open_sesame");
      wait(0.1);
    }

    level.moon_donations = 3;
    level.kepler_donations = 3;
    level.triton_donations = 3;
    if(isDefined(level.team_killdoors)) {
      foreach(var_8 in level.team_killdoors) {
        var_8 scripts\cp\zombies\zombie_doors::open_team_killdoor(level.players[0]);
      }
    }

    var_10 = scripts\engine\utility::getStructArray("interaction", "targetname");
    foreach(var_12 in var_10) {
      var_13 = scripts\engine\utility::getStructArray(var_12.script_noteworthy, "script_noteworthy");
      foreach(var_15 in var_13) {
        if(isDefined(var_15.target) && isDefined(var_12.target)) {
          if(var_15.target == var_12.target && var_15 != var_12) {
            if(scripts\engine\utility::array_contains(var_10, var_15)) {
              var_10 = scripts\engine\utility::array_remove(var_10, var_15);
            }
          }
        }
      }

      if(scripts\cp\cp_interaction::interaction_is_door_buy(var_12)) {
        if(!isDefined(var_12.script_noteworthy)) {
          continue;
        }

        if(var_12.script_noteworthy == "team_door_switch") {
          scripts\cp\zombies\interaction_openareas::use_team_door_switch(var_12, level.players[0]);
        }
      }
    }
  }

  if(scripts\engine\utility::flag_exist("restorepower_step1")) {
    scripts\engine\utility::flag_set("restorepower_step1");
  }
}

start_all_generators() {
  foreach(var_1 in level.generators) {
    thread scripts\cp\zombies\zombie_power::generic_generator(var_1);
    wait(0.1);
  }
}

get_players_best_times() {
  setomnvar("zm_boss_splash", 4);
  level notify("enter_fast_travel");
  wait(0.85);
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(var_0 == 0) {
      var_1 = get_player_best_time(level.players[var_0]);
      setomnvar("zm_boss_time_p1", var_1);
    }

    if(var_0 == 1) {
      var_1 = get_player_best_time(level.players[var_0]);
      setomnvar("zm_boss_time_p2", var_1);
    }

    if(var_0 == 2) {
      var_1 = get_player_best_time(level.players[var_0]);
      setomnvar("zm_boss_time_p3", var_1);
    }

    if(var_0 == 3) {
      var_1 = get_player_best_time(level.players[var_0]);
      setomnvar("zm_boss_time_p4", var_1);
    }
  }

  boss_fight_splash();
}

get_player_best_time(var_0) {
  if(level.script == "cp_final" && is_meph_fight()) {
    return var_0 getplayerdata("cp", "alienPlayerStats", "bestscore");
  }

  return var_0 getplayerdata("cp", "duration", level.script);
}

set_player_best_time(var_0, var_1) {
  if(level.script == "cp_final" && is_meph_fight()) {
    var_0 setplayerdata("cp", "alienPlayerStats", "bestscore", var_1);
    return;
  }

  var_0 setplayerdata("cp", "duration", level.script, var_1);
}

boss_fight_splash() {
  if(is_meph_fight()) {
    setomnvar("zm_boss_id", 6);
  }

  setomnvar("zm_boss_splash", 1);
  wait(5);
  setomnvar("zm_boss_splash", 0);
  wait(1);
  setomnvar("zm_boss_id", -1);
  level thread run_boss_timer();
}

run_boss_timer() {
  level endon("game_ended");
  level endon("boss_beat");
  setomnvar("zm_boss_splash", 2);
  var_0 = 0;
  var_1 = gettime();
  for(;;) {
    var_2 = gettime();
    level.bosstimer = var_2 - var_1;
    setomnvar("zm_boss_timer", level.bosstimer);
    wait(1);
  }
}

run_pre_match_timer() {
  level endon("game_ended");
  level endon("enter_fast_travel");
  wait(13);
  setomnvar("zm_boss_splash", 3);
  level.prebossfighttime = 180000;
  var_0 = gettime();
  while(level.prebossfighttime >= 0) {
    var_1 = gettime();
    setomnvar("zm_boss_timer", level.prebossfighttime);
    level.prebossfighttime = 180000 - var_1 - var_0;
    wait(1);
  }

  level thread start_direct_boss_fight();
}

success_sequence(var_0, var_1) {
  level notify("boss_beat");
  if(!isDefined(var_0)) {
    var_0 = 3;
  }

  switch (var_1) {
    case 1:
      var_2 = "boss_spaceland";
      break;

    case 2:
      var_2 = "boss_rave";
      break;

    case 3:
      var_2 = "boss_disco";
      break;

    case 4:
      var_2 = "boss_town";
      break;

    case 5:
      var_2 = "boss_final";
      break;

    case 6:
      var_2 = "boss_dc";
      break;

    default:
      var_2 = "boss_spaceland";
      break;
  }

  if(var_0 > 3) {
    wait(var_0 - 3);
  }

  foreach(var_4 in level.players) {
    var_4.ignoreme = 1;
    var_4 thread scripts\cp\cp_hud_message::showsplash(var_2);
    var_4 scripts\cp\cp_persistence::give_player_xp(int(1000), 1);
  }

  wait(3);
  foreach(var_4 in level.players) {
    try_set_personal_best_time(var_4);
  }

  scripts\cp\zombies\zombie_analytics::log_boss_fight_result(1);
  scripts\cp\zombies\zombie_analytics::log_wave_dur_boss_fight(int(level.bosstimer / 1000));
  setomnvar("zm_boss_splash", 5);
  setomnvar("zm_boss_id", var_1);
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

try_set_personal_best_time(var_0) {
  var_1 = get_player_best_time(var_0);
  var_2 = int(level.bosstimer);
  if(should_set_personal_best_time(var_1, var_2)) {
    set_player_best_time(var_0, var_2);
  }
}

should_set_personal_best_time(var_0, var_1) {
  if(var_0 == 0) {
    return 1;
  }

  if(var_1 < var_0) {
    return 1;
  }

  return 0;
}

get_direct_boss_fight_time_survived() {
  return int(level.bosstimer / 1000);
}

move_player_through_portal_tube(var_0, var_1) {
  var_2 = 30;
  var_0 endon("disconnect");
  var_0 scripts\cp\powers\coop_powers::power_disablepower();
  var_0.disable_consumables = 1;
  var_0.isfasttravelling = 1;
  var_0 getrigindexfromarchetyperef();
  var_0 notify("delete_equipment");
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_3 = move_through_tube(var_0, "fast_travel_tube_start", "fast_travel_tube_end");
  if(isDefined(self.cooldown)) {
    self.cooldown = self.cooldown + var_2;
  }

  teleport_to_portal_safe_spot(var_0, var_1);
  if(isDefined(level.boss_fight_post_portal_tube_func)) {
    var_0 thread[[level.boss_fight_post_portal_tube_func]](var_0);
  }

  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_3 delete();
  var_0 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  var_0.is_off_grid = undefined;
  var_0.kicked_out = undefined;
  var_0.isfasttravelling = undefined;
  var_0.disable_consumables = undefined;
  var_0 notify("fast_travel_complete");
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  if(var_0.vo_prefix == "p5_") {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("fasttravel_exit", "town_comment_vo");
  }
}

move_through_tube(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("move_through_tube");
  var_0 earthquakeforplayer(0.3, 0.2, var_0.origin, 200);
  var_3 = getent(var_1, "targetname");
  var_4 = getent(var_2, "targetname");
  var_0 cancelmantle();
  var_0.no_outline = 1;
  var_0.no_team_outlines = 1;
  var_5 = var_3.origin + (0, 0, -45);
  var_6 = var_4.origin + (0, 0, -45);
  var_0.is_fast_traveling = 1;
  var_0 scripts\cp\utility::adddamagemodifier("fast_travel", 0, 0);
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 dontinterpolate();
  var_0 setorigin(var_5);
  var_0 setplayerangles(var_3.angles);
  var_0 playlocalsound("zmb_portal_travel_lr");
  var_7 = spawn("script_origin", var_5);
  var_0 playerlinkto(var_7);
  var_0 getweaponrankxpmultiplier();
  wait(0.1);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  var_7 moveto(var_6, 1);
  wait(1);
  var_0.is_fast_traveling = undefined;
  var_0 scripts\cp\utility::removedamagemodifier("fast_travel", 0);
  if(var_0 scripts\cp\utility::isignoremeenabled()) {
    var_0 scripts\cp\utility::allow_player_ignore_me(0);
  }

  var_0.is_fast_traveling = undefined;
  var_0.no_outline = 0;
  var_0.no_team_outlines = 0;
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  return var_7;
}

unlinkplayerafterduration() {
  while(scripts\engine\utility::istrue(self.isrewinding) || isDefined(self.rewindmover)) {
    scripts\engine\utility::waitframe();
  }

  self unlink();
}

teleport_to_portal_safe_spot(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = self.teleport_spots;
  }

  var_3 = undefined;
  while(!isDefined(var_3)) {
    foreach(var_5 in var_2) {
      if(!positionwouldtelefrag(var_5.origin)) {
        var_3 = var_5;
      }
    }

    if(!isDefined(var_3)) {
      if(!isDefined(var_2[0].angles)) {
        var_2[0].angles = (0, 0, 0);
      }

      var_7 = scripts\cp\utility::vec_multiply(anglesToForward(var_2[0].angles), 64);
      var_3 = spawnStruct();
      var_3.origin = var_2[0].origin + var_7;
      var_3.angles = var_2[0].angles;
    }

    wait(0.1);
  }

  var_0 playershow();
  if(scripts\engine\utility::istrue(var_0.isrewinding) || isDefined(self.rewindmover)) {
    var_0 thread unlinkplayerafterduration();
  } else {
    var_0 unlink();
  }

  var_0 dontinterpolate();
  var_0 setorigin(var_3.origin);
  var_0 setplayerangles(var_3.angles);
  var_0.disable_consumables = undefined;
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0.portal_end_origin = var_3.origin;
}

adjust_wave_num(var_0) {
  if(should_directly_go_to_boss_fight()) {
    foreach(var_2 in level.players) {
      var_2.wave_num_when_joined = undefined;
    }

    if(var_0 == "all_escape") {
      level.wave_num = get_victory_wave_num();
    } else {
      level.wave_num = get_fail_wave_num();
    }

    foreach(var_2 in level.players) {
      var_2 setclientomnvar("zombie_wave_number", level.wave_num);
    }
  }
}

get_victory_wave_num() {
  var_0 = 30000;
  var_1 = int(level.bosstimer);
  var_2 = get_best_time_for_player_count();
  if(var_1 <= var_2) {
    return 16;
  }

  if(var_1 <= var_2 + var_0 * 1) {
    return 15;
  }

  if(var_1 <= var_2 + var_0 * 2) {
    return 13;
  }

  if(var_1 <= var_2 + var_0 * 3) {
    return 12;
  }

  return 11;
}

get_fail_wave_num() {
  var_0 = int(level.bosstimer);
  if(var_0 < 1000) {
    return 1;
  }

  if(var_0 < 120000) {
    return 2;
  }

  if(var_0 >= 120000 && var_0 < 300000) {
    return 3;
  }

  if(var_0 >= 300000 && var_0 < 480000) {
    return 4;
  }

  if(var_0 >= 480000 && var_0 < 600000) {
    return 5;
  }

  return 6;
}

get_best_time() {
  switch (level.script) {
    case "cp_zmb":
      return 149000;

    case "cp_rave":
      return 913000;

    case "cp_disco":
      return 231000;

    case "cp_town":
      return 361000;

    case "cp_final":
      if(is_meph_fight()) {
        return 1032000;
      }
      return 1324000;
  }
}

get_best_time_for_player_count() {
  switch (level.script) {
    case "cp_zmb":
      switch (level.players.size) {
        case 1:
          return 240000;

        case 2:
          return 271000;

        case 3:
          return 302000;

        case 4:
          return 334000;

        default:
          return 240000;
      }

      break;

    case "cp_rave":
      switch (level.players.size) {
        case 1:
          return 705000;

        case 2:
          return 774000;

        case 3:
          return 843000;

        case 4:
          return 913000;

        default:
          return 705000;
      }

      break;

    case "cp_disco":
      switch (level.players.size) {
        case 1:
          return 285000;

        case 2:
          return 267000;

        case 3:
          return 249000;

        case 4:
          return 231000;

        default:
          return 285000;
      }

      break;

    case "cp_town":
      switch (level.players.size) {
        case 1:
          return 310000;

        case 2:
          return 327000;

        case 3:
          return 344000;

        case 4:
          return 361000;

        default:
          return 310000;
      }

      break;

    case "cp_final":
      if(is_meph_fight()) {
        switch (level.players.size) {
          case 1:
            return 939000;

          case 2:
            return 970000;

          case 3:
            return 1001000;

          case 4:
            return 1032000;

          default:
            return 939000;
        }

        return;
      }

      switch (level.players.size) {
        case 1:
          return 799000;

        case 2:
          return 974000;

        case 3:
          return 1149000;

        case 4:
          return 1324000;

        default:
          return 799000;
      }

      break;
  }
}

get_weapon_cost(var_0) {
  var_1 = scripts\cp\utility::getrawbaseweaponname(var_0);
  switch (var_1) {
    case "g18":
    case "crdb":
    case "fhr":
    case "mauler":
    case "minilmg":
    case "unsalmg":
    case "shredder":
    case "headcutter":
    case "facemelter":
    case "dischord":
    case "cutie":
    case "harpoon4":
    case "harpoon3":
    case "harpoon2":
    case "harpoon1":
    case "katana":
    case "nunchucks":
    case "venomx":
      return 5000;

    case "gauss":
    case "sdfar":
    case "devastator":
    case "sdfshotty":
    case "ump45c":
    case "tacburst":
    case "mp28":
    case "ump45":
    case "fmg":
    case "vr":
    case "m4":
    case "lmg03":
    case "sdflmg":
    case "arclassic":
    case "ar57":
    case "ripper":
    case "kbs":
      return 3500;

    case "spas":
    case "ake":
    case "longshot":
    case "erad":
    case "m8":
    case "cheytac":
      return 2500;
  }
}